_addon.name = 'DragonWatch'
_addon.author = 'Sammeh'
_addon.version = '1.0.0.1'
_addon.command = 'dw'

require 'pack'
require('chat')

UnityList = T{'Pieuje','Ayame','Invincible Shield','IShield','Apururu','Maat','Aldo','Jakoh Wahcondalo','Jakoh','Naja Salaheem','Naja','Flaviria','Yoran-Oran','Sylvie',}
messages = require('map')


windower.register_event('incoming text', function(original, modified, original_mode, modified_mode, blocked)
    if blocked or text == '' then
        return
    end
	formatted = original:strip_format()
	split_formatted = T{}
	
	for i in string.gmatch(formatted, "%S+") do
		split_formatted[#split_formatted+1] = i
	end
	
	who = split_formatted[1]
	
	for key,value in pairs(UnityList) do
		if string.find(who,value) and messages[value] then
			parse_message(value,formatted)
		end
	end
	
end)

function parse_message(unity,text)
	if string.find(text,"Azi Dahaka") then
		dragon = "Azi Dahaka"
	elseif string.find(text,"Naga Raja") then
		dragon = "Naga Raja"
	elseif string.find(text,"Quetzalcoatl") then
		dragon = "Quetzalcoatl"
	else 
		dragon = "none"
	end
	if dragon ~= "none" then
		if string.find(text,"10 minutes") then
			windower.send_command('timers delete "'..dragon..' Live Timer:"')
			windower.send_command('timers delete "'..dragon..' Pop Timer:"')
			windower.send_command('timers create "'..dragon..' Pop Timer:" 600 down fire')
		elseif string.find(text,messages[unity].deathmsg) then
			windower.send_command('timers delete "'..dragon..' Live Timer:"')
			windower.send_command('timers delete "'..dragon..' Pop Timer:"')
		elseif string.find(text,messages[unity].popmsg) then
			windower.send_command('timers delete "'..dragon..' Live Timer:"')
			windower.send_command('timers create "'..dragon..' Live Timer:" 1800 down fire')
		else 
			-- do nothing
		end
	end

end

windower.register_event('load', function()	
end)

windower.register_event('zone change',function(new,old)
end)

windower.register_event('addon command', function(command)
end)

windower.register_event('job change', function()
end)
