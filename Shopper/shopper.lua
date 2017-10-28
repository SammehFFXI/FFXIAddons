--[[
Copyright © 2017, Sammeh of Quetzalcoatl
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Shopper nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Sammeh BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'Shopper'
_addon.author = 'Sammeh'
_addon.version = '1.0.2'
_addon.command = 'shop'

-- 1.0.0 Orig release
-- 1.0.1 Clean-up old copied code
-- 1.0.2 added in some ugly auto-purchases.   //shop buyall  (same syntax otherwise as //shop buy)



-- Todo:
-- Track Guild NPCs 0x083 incoming- currently bad format


require('tables')
require('chat')
require('logger')
require('functions')
packets = require('packets')
json  = require('json')
files = require('files')
config = require('config')
res = require('resources')


local mobid = ""
local npc_name = ""

local zone = windower.ffxi.get_info()['zone']
local busy = false

function createpacket(npc_by_name)
	local found = 0
	local result = {}
	--windower.add_to_chat(8,"Searching for NPC: "..npc_by_name)
	for i,v in pairs(windower.ffxi.get_mob_array()) do
		if string.find(v['name']:lower(),npc_by_name) and windower.ffxi.get_mob_by_index(i).valid_target then
			found = 1
			target_index = i
			target_id = v['id']
			npc_name = v['name']
			distance = windower.ffxi.get_mob_by_id(target_id).distance
			--windower.add_to_chat(8,npc_by_name..' Found! Distance:'..math.sqrt(distance))
		end
	end
	
	if found == 1 then 
		if math.sqrt(distance)<6 then
			result['Menu ID'] = 6003
			result['Target'] = target_id
			result['Option Index'] = 10
			result['_unknown1'] = 0
			result['_unknown2'] = 0
			result['Target Index'] = target_index
			result['Zone'] = zone 
		else
			windower.add_to_chat(10,"Not close enough to "..npc_by_name)
			result = nil
		end
	else
		windower.add_to_chat(8,npc_by_name.." Not Found!")
	end
	
return result
end

function validate_item(npc_item)
  for i,v in pairs(res.items) do
    if v.name:lower() == npc_item then
	   return v.id
	end
  end
end

windower.register_event('addon command', function(...)
    local args = T{...}
    local cmd = args[1]
	args:remove(1)
	if cmd and cmd:lower() == 'reset' and lastpkt then 
		reset_me()
	end
	
	if cmd and cmd:lower() == 'buy' then
		count = tonumber(args[1])
		args:remove(1)
		if type(count) ~= 'number' then
			windower.add_to_chat(10,'Count not specified.  Usage: //shop buy COUNT NPC_NAME ITEM')
		else
			local npc_by_name = args[1]:lower()
			args:remove(1)
			local npc_item = table.concat(args," "):lower()
			npc_item_by_id = validate_item(npc_item)
			if npc_item_by_id then
				if res.items[npc_item_by_id].stack >= count then
					local freeslots = count_inv()
					if freeslots > 0 then 
						if not busy and npc_item_by_id then
							--windower.add_to_chat(8,'Trying to buy Item:'..npc_item..' Item ID: '..npc_item_by_id..' From: '..npc_by_name)
							pkt = createpacket(npc_by_name)
							if pkt and pkt['Target'] then
								busy = true
								poke_npc(pkt['Target'],pkt['Target Index'])
							end
						else
							windower.add_to_chat(10,'Still Busy buying last Item!')
						end
					else
						windower.add_to_chat(10,'You are out of inventory!')
					end
				else
					windower.add_to_chat(10,'You specified too many.  Max Count for '..npc_item..' is '..res.items[npc_item_by_id].stack)
				end
			else 
				windower.add_to_chat(10,'Cannot Find Item in Resources: '..npc_item)
			end
		end
	end
	if cmd and cmd:lower() == 'buyall' then
		local freeslots = count_inv()
		count = tonumber(args[1])
		args:remove(1)
		local npc_by_name = args[1]:lower()
		args:remove(1)
		while (count_inv() > 0) do
			coroutine.sleep(1)
			if type(count) ~= 'number' then
				windower.add_to_chat(10,'Count not specified.  Usage: //shop buyall COUNT NPC_NAME ITEM')
			else
				local npc_item = table.concat(args," "):lower()
				npc_item_by_id = validate_item(npc_item)
				if npc_item_by_id then
					if res.items[npc_item_by_id].stack >= count then
						if freeslots > 0 then 
							if not busy and npc_item_by_id then
								--windower.add_to_chat(8,'Trying to buy Item:'..npc_item..' Item ID: '..npc_item_by_id..' From: '..npc_by_name)
								pkt = createpacket(npc_by_name)
								if pkt and pkt['Target'] then
									busy = true
									poke_npc(pkt['Target'],pkt['Target Index'])
								end
							else
								windower.add_to_chat(10,'Still Busy buying last Item!')
							end
						else
							windower.add_to_chat(10,'You are out of inventory!')
						end
					else
						windower.add_to_chat(10,'You specified too many.  Max Count for '..npc_item..' is '..res.items[npc_item_by_id].stack)
					end
				else 
					windower.add_to_chat(10,'Cannot Find Item in Resources: '..npc_item)
				end
			end
		end
		windower.add_to_chat(10,'You are all out of inventory!')
	end
	
	if cmd and cmd:lower() == 'find' then
		local id = tonumber(args[1])
		local target = windower.ffxi.get_mob_by_index(id)
		if target then
			print(target.name)
		else
			print("Target not found")
		end
	end
end)

function poke_npc(npc,target_index)
	if npc and target_index then
		local packet = packets.new('outgoing', 0x01A, {
			["Target"]=npc,
			["Target Index"]=target_index,
			["Category"]=0,
			["Param"]=0,
			["_unknown1"]=0})
		packets.inject(packet)
	end
end


function reset_me()
		
end

windower.register_event('incoming chunk',function(id,data,modified,injected,blocked)

	if id == 0x03e and busy then
		return true
	end
	if id == 0x036 and busy then
		return true
	end
	if id == 0x03c and busy then
		local p = packets.parse('incoming',data)
		local parsed_item_id 
		last_item = false
		slot_number = 1
		found = 0
		repeat 
			if p["Shop Slot "..slot_number] then
				parsed_item_id = p["Item "..slot_number]
				parsed_item_slot = p["Shop Slot "..slot_number]
				if npc_item_by_id == parsed_item_id then 
				   last_item = true
				   found = 1
				end
				slot_number = slot_number + 1
			else
				last_item = true
			end
		until(last_item)
		
		if found == 1 and pkt then
			buy_item(npc_item_by_id,count,parsed_item_slot)
			busy = false
			lastpkt = pkt
			pkt = {}
		else
			windower.add_to_chat(10,'NPC does not offer: '..npc_item_by_id..res.items[npc_item_by_id].en)
			busy = false
			lastpkt = pkt
			pkt = {}
		end
	end
end)

function count_inv()
	local playerinv = windower.ffxi.get_items().inventory
	local freeslots = playerinv.max - playerinv.count
	return freeslots
end


function buy_item(npc_item_by_id,count,parsed_item_slot)
	--windower.add_to_chat(10,'Time To Buy Item: ('..count..') '..npc_item_by_id..res.items[npc_item_by_id].en..parsed_item_slot)
	local packet = packets.new('outgoing', 0x083)
	packet["Count"]=count
	packet["Shop Slot"]=parsed_item_slot
	packets.inject(packet)
end

