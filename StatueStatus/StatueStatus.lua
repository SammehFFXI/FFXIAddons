
_addon.name = 'StatueStatus'
_addon.author = 'Windower'
_addon.version = '1.0.0.2'
_addon.command = 'StatueStatus'


packets = require('packets')
config = require('config')
texts = require('texts')

defaults = {}
defaults.pos = {}
defaults.pos.x = -178
defaults.pos.y = 121
defaults.text = {}
defaults.text.font = 'Arial'
defaults.text.size = 14
defaults.flags = {}
defaults.flags.right = true

settings = config.load(defaults)
statue_textbox = texts.new('${value}', settings)

debug.setmetatable(nil, {__index = {}, __call = functions.empty})

local statue_list = {}
local AurixIndex = 0

windower.register_event('incoming chunk', function(id,original,modified,injected,blocked)
    if id == 0x00E then
		local packet = packets.parse('incoming', original)
		local index = packet["Index"]
		local status = packet["_unknown4"]
		color = statue_list[index] or nil
		if (status == 458784) then color = "Green" end
		if (status == 393248) then color = "Blue" end
		if (status == 327712) then color = "Red" end
		if (color ~= "Green" and color ~= "Blue" and color ~= "Red") then 
			color = "Aurix" 
			AurixIndex = index
		end
		statue_list[index] = color
	end
end)



windower.register_event('prerender', function()
    local t = windower.ffxi.get_mob_by_index(windower.ffxi.get_player().target_index or 0)
	if  statue_list[t.index] and (t.name == "Corporal Tombstone" or t.name == "Lithicthrower Image" or t.name == "Incarnation Icon" or t.name == "Impish Statue") then
		statue_textbox.value = statue_list[t.index]
	else
		statue_textbox.value = nil
	end
	local mobArray = windower.ffxi.get_mob_array()
	for (i,v) in pairs (mobArray) do
		if i.valid_target and i.index == AurixIndex then
			statue_textbox.value = statue_textbox.value.."\nAurix in Range"
		end
	end
	statue_textbox:visible(t ~= nil)
end)
