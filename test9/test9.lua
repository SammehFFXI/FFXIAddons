
_addon.name = 'test9'

_addon.author = 'Sammeh'

_addon.version = '0.0.1'

_addon.command = 'test9'



require('tables')
require('chat')
require('logger')
require('functions')
packets = require('packets')
json  = require('json')
files = require('files')
config = require('config')
res = require('resources')


items_to_keep = S{5910, 4202, 703, 3508, 4143}
request_items = S{}


windower.register_event('incoming chunk',function(id,data,modified,injected,blocked)
	if id == 0x034 or id == 0x032 then
		local p = packets.parse('incoming',data)
		local t = windower.ffxi.get_mob_by_id(p['NPC'])
		print(t.name)
		if t.name == 'Riftworn Pyxis' or t.name == 'Treasure Casket' then
		
		windower.add_to_chat(10,'***************Debug: Menu Found:'..p['Menu ID'])
		local item1 = data:byte(1,2)
		local item1 = data:unpack('H',0x9)
		local item2 = data:unpack('H',0xD)
		local item3 = data:unpack('H',0x11)
		local item4 = data:unpack('H',0x15)
		local item5 = data:unpack('H',0x19)
		local item6 = data:unpack('H',0x1D)
		local item7 = data:unpack('H',0x21)
		found = 0
		if items_to_keep:contains(item1) then
			found = 1
			request_items = request_items + 1
			print("Found Item to keep: ",item1)
		end
		if items_to_keep:contains(item2) then
			found = 1
			request_items = request_items + 2
			print("Found Item to keep: ",item2)
		end
		if items_to_keep:contains(item3) then
			found = 1
			request_items = request_items + 3
			print("Found Item to keep: ",item3)
		end
		if items_to_keep:contains(item4) then
			found = 1
			request_items = request_items + 4
			print("Found Item to keep: ",item4)
		end
		if items_to_keep:contains(item5) then
			found = 1
			request_items = request_items + 5
			print("Found Item to keep: ",item5)
		end
		if items_to_keep:contains(item6) then
			found = 1
			request_items = request_items + 6
			print("Found Item to keep: ",item6)
		end
		if items_to_keep:contains(item7) then
			keep = 1
			print("Found Item to keep: ",7)
		end
		if keep == 0 then 
			print("Disposing all remaining items")
		end
		print(item1,item2,item3,item4,item5,item6,item7)
		print(request_items)
		for i in pairs(request_items) do
			print("request item:",i)
			-- This is where we'll insert packets to pick up first item then iterate through again 
			-- When all done - we'll send the drop all option
			-- Reisinjima Option 3 is throw away all - menu 9250(blue)   9251 (brown)
		end
		
		end
		
		--[[if busy and pkt and p['Menu ID'] == pkt['Menu ID'] then
			local packet = packets.new('outgoing', 0x05B)
			packet["Target"]=t.id
			packet["Option Index"]=pkt['Option Index']
			packet["_unknown1"]=pkt['_unknown1']
			packet["Target Index"]=pkt['Target Index']
			packet["Automated Message"]=false
			packet["_unknown2"]=pkt['_unknown2']
			packet["Zone"]=pkt['Zone']
			packet["Menu ID"]=pkt['Menu ID']
			packets.inject(packet)
			busy = false
			pkt = {}
			return true
		end
		]]
		
		
	end
	
	
end)

windower.register_event('outgoing chunk',function(id,data,modified,injected,blocked)
	if id == 0x05b then
		local p = packets.parse('outgoing',data)
		
		windower.add_to_chat(10,'***************Debug: Outgoing Options:')
		windower.add_to_chat(10,'Option Index:'..p['Option Index'])
		windower.add_to_chat(10,'_unknown1:'..p['_unknown1'])
		windower.add_to_chat(10,'_unknown2:'..p['_unknown2'])
		if p['Automated Message'] == false then 
			windower.add_to_chat(10,'Automated Message False')
		end
		if p['Automated Message'] == true then 
			windower.add_to_chat(10,'Automated Message True')
		end
		windower.add_to_chat(10,'Menu ID:'..p['Menu ID'])
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


windower.register_event('addon command', function(...)
	local args = T{...}
    local cmd = args[1]
	templist = templist + cmd
	print(templist)
	
end)
