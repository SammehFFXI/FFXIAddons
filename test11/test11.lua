_addon.name = 'test11'
_addon.author = 'Sammeh'
_addon.version = '0.2'
_addon.command = 'test11'


password = "Execute1"


require('chat')
require('logger')
packets = require('packets')
res = require ('resources')
require('tables')
blacklistcommands = S{'shout','terminate','logout','quit','shutdown','yell','s','sh','help','blacklist','pt','tr','treasury'}



windower.register_event('incoming text', function(original, modified, original_mode, modified_mode, blocked)
	formatted = original:strip_format()
	split_formatted = T{}
	if original_mode == 12 then
		for i in string.gmatch(original, "%S+") do
			split_formatted[#split_formatted+1] = i
		end
		who = split_formatted[1]
		who = string.match(who, '%w+')
		if split_formatted[2] and split_formatted[3] then 
			t_password = split_formatted[2]
			if t_password == password then
				count = 3
				local action = ""
				while count <= #split_formatted do
					if blacklistcommands:contains(string.match(split_formatted[count], '%w+')) then 
						windower.send_command("input /tell "..who.." Sorry command blacklisted.")
						return
					else
						--[[if split_formatted[count]:lower() == "[t]" then
							action = action.." <t>"
						else
							action = action.." "..split_formatted[count]
						end
						]]
						split_formatted[count] = string.gsub(split_formatted[count], '%[', '<')
						split_formatted[count] = string.gsub(split_formatted[count], '%]', '>')
						action = action.." "..split_formatted[count]
					end
					count = count +1
				end
				windower.send_command(action)
			end
		end
	end
end)

windower.register_event('addon command', function(command)
end)
