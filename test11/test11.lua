_addon.name = 'test11'
_addon.author = 'Sammeh'
_addon.version = '0.1'
_addon.command = 'test11'


password = "test2"

require('chat')
require('logger')
packets = require('packets')
res = require ('resources')



windower.register_event('incoming text', function(original, modified, original_mode, modified_mode, blocked)
	formatted = original:strip_format()
	split_formatted = T{}
	if original_mode == 12 then
		for i in string.gmatch(original, "%S+") do
			split_formatted[#split_formatted+1] = i
		end
		who = split_formatted[1]
		if split_formatted[2] and split_formatted[3] then 
			t_password = split_formatted[2]
			if t_password == password then
				count = 3
				local action = ""
				while count <= #split_formatted do
					action = action.." "..split_formatted[count]
					count = count +1
				end
				windower.send_command(action)
			end
		end
	end
end)

windower.register_event('addon command', function(command)
end)
