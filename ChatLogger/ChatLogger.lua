_addon.name = 'ChatLogger'
_addon.author = 'Sammeh'
_addon.version = '1.0.3'

require('chat')
files = require('files')
config = require('config')

defaults = {}
defaults.AddTimestamp = false
defaults.TimestampFormat = '%H:%M:%S'
defaults.LogUnknown = true
defaults.LogCombined = true
defaults.LogIndividual = false
defaults.CombinedSeperator = "||||"

settings = config.load(defaults)

name = windower.ffxi.get_player() and windower.ffxi.get_player().name

windower.register_event('login', function(new_name)
    name = new_name
end)

windower.register_event('incoming text', function(unmodified, text, mode, mode2, blocked)
    if blocked or text == '' then
        return
    end
	
	local date = os.date('*t')
	
	local chatmode = {
		[1] = "say",
		[2] = "shout",
		[3] = "yell",
		[4] = "tell",
		[5] = "party",
		[6] = "ls1",
		[7] = "emote",
		[9] = "say",
		[10] = "shout",
		[11] = "yell",
		[12] = "tell",
		[13] = "party",
		[14] = "ls1",
		[15] = "emote",
		[20] = "battlespam", -- dmg done to mob
		[21] = "battlespam", -- missed attack
		[22] = "battlespam", -- pc casting / npc actions
		[25] = "battlespam", -- crit hits
		[28] = "battlespam", -- mob actions towards us
		[29] = "battlespam", -- mob misses
		[30] = "battlespam", -- casts cure iii, player receives
		[36] = "battlespam", -- player defeats mob
		[50] = "battlespam", -- begins casting
		[56] = "battlespam", -- casting enaero and gaining effect
		[57] = "battlespam", -- trust receives status debuff
		[59] = "battlespam", -- sylvie's erase has no effect
		[63] = "battlespam", -- no effect
		[64] = "battlespam", -- casts silena, removes effect
		[81] = "battlespam", -- multiple parties dex down disappears
		[90] = "battlespam", -- uses item
		[101] = "battlespam", -- pc uses ability
		[102] = "battlespam", -- mob uses ability, pc receives debuff
		[104] = "battlespam", -- mob uses action
		[107] = "battlespam", -- mob uses action, pc receives debuff
		[110] = "battlespam", -- readies ws
		[114] = "battlespam", -- trust evades
		[121] = "battlespam", -- master chain, must wait longer to perform that action
		[127] = "battlespam", -- roe notices
		[129] = "battlespam", -- skillup
		[122] = "battlespam", -- out of range
		[131] = "battlespam", -- limit chain & job points
		[191] = "battlespam", -- effects wear off
		[211] = "unity",
		[212] = "unity",
		[213] = "ls2",
		[214] = "ls2",
		[219] = "assist",
		[220] = "assist",
		[221] = "assist",
		[222] = "assist"
		
	}
	
	text = text:gsub("\n","\t")
	
	if chatmode[mode] then
		-- print("ChatMode:"..chatmode[mode], text)
		if settings.LogIndividual then
			local file = files.new('./logs/%s_%.4u.%.2u.%.2u_%s.log':format(name, date.year, date.month, date.day, chatmode[mode]))
			if not file:exists() then
				file:create()
			end
			file:append('%s%s\n':format(settings.AddTimestamp and os.date(settings.TimestampFormat, os.time()) or '', text:strip_format()))
		end
		if settings.LogCombined then 
			local CombinedFile = files.new('./logs/Combined_%s_%.4u.%.2u.%.2u.log':format(name, date.year, date.month, date.day))
			if not CombinedFile:exists() then
				CombinedFile:create()
			end
			CombinedFile:append('%s%s%s\n':format(chatmode[mode]..settings.CombinedSeperator,settings.AddTimestamp and os.date(settings.TimestampFormat, os.time()) or '', text:strip_format()))
		end
	else 
		--print("ChatMode:"..mode, text)
		if settings.LogUnknown then 
			local file = files.new('./logs/%s_%.4u.%.2u.%.2u_undefined.log':format(name, date.year, date.month, date.day))
			if not file:exists() then
				file:create()
			end
			file:append('%s%s%s\n':format(settings.AddTimestamp and os.date(settings.TimestampFormat, os.time()) or '', text:strip_format(), ' Mode: '..mode))
			
			local CombinedFile = files.new('./logs/Combined_%s_%.4u.%.2u.%.2u.log':format(name, date.year, date.month, date.day))
			if not CombinedFile:exists() then
				CombinedFile:create()
			end
			CombinedFile:append('%s%s%s\n':format("unknown"..mode..settings.CombinedSeperator,settings.AddTimestamp and os.date(settings.TimestampFormat, os.time()) or '', text:strip_format()))
		end
	end
	

	
end)
