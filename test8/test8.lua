

_addon.name = 'test8'

_addon.author = 'Sammeh'

_addon.version = '0.0.1'

_addon.command = 'test8'



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

function createpacket()
	local found = 0
	local result = {}
	windower.add_to_chat(8,"Searching for Riftworn Pyxis:")
	for i,v in pairs(windower.ffxi.get_mob_array()) do
		if string.find(v['name'],'Riftworn Pyxis') and windower.ffxi.get_mob_by_index(i).valid_target then
			found = 1
			target_index = i
			target_id = v['id']
			npc_name = v['name']
			distance = windower.ffxi.get_mob_by_id(target_id).distance
			windower.add_to_chat(8,'Riftworn Pyxis Found! Distance:'..math.sqrt(distance))
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
			windower.add_to_chat(10,"Not close enough to Pxiys")
			result = nil
		end
	else
		windower.add_to_chat(8,"Riftworn Pyxis Found")
	end
	
return result
end

windower.register_event('addon command', function(...)
    local args = T{...}
    local cmd = args[1]
	args:remove(1)
	if cmd and cmd == 'reset' and lastpkt then 
		reset_me()
	else
		if not busy then
			pkt = createpacket()
			if pkt and pkt['Target'] then
				busy = true
				poke_npc(pkt['Target'],pkt['Target Index'])
			end
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
		windower.add_to_chat(8,"Got PKT.... here is mob id:"..packet['Target'])
	end
end


function reset_me()
		local packet = packets.new('outgoing', 0x05B)
		packet["Target"]=lastpkt['Target']
		packet["Option Index"]=lastpkt['Option Index']
		packet["_unknown1"]="16384"
		packet["Target Index"]=lastpkt['Target Index']
		packet["Automated Message"]=false
		packet["_unknown2"]=0
		packet["Zone"]=lastpkt['Zone']
		packet["Menu ID"]=lastpkt['Menu ID']
		packets.inject(packet)
end



windower.register_event('incoming chunk',function(id,data,modified,injected,blocked)

	if id == 0x034 or id == 0x032 then
	--[[
		Need to parse packet for return.  If it says 'you're not elegible etc etc' then we need to mark 
		menu ID or whatever to validate data.   Otherwise we'll lock up on some kind of menu.  May have 
		fixed with the p['Menu ID'] == pkt['Menu ID'] statement below.. not sure 
	]]
		local p = packets.parse('incoming',data)
		if busy and pkt and p['Menu ID'] == pkt['Menu ID'] then
			local packet = packets.new('outgoing', 0x05B)
			packet["Target"]=pkt['Target']
			packet["Option Index"]=pkt['Option Index']
			packet["_unknown1"]=pkt['_unknown1']
			packet["Target Index"]=pkt['Target Index']
			packet["Automated Message"]=false
			packet["_unknown2"]=pkt['_unknown2']
			packet["Zone"]=pkt['Zone']
			packet["Menu ID"]=pkt['Menu ID']
			packets.inject(packet)
		
		busy = false
		lastpkt = pkt
		pkt = {}
		
		return true
		else 
			busy = false
			lastpkt = pkt
			pkt = {}
		end
	end
end)

