--[[

Copyright © 2016, Sammeh of Quetzalcoatl
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of MobMon nor the
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

-- Add on used in order to monitor something like a Notorious Monster or Single-named pop. 
-- While it's alive it will be Green with a clock next to it (effectively 'now').  When it dies or is no longer up it will turn White and that clock will be frozen, thus you know the last time it was alive
-- When it pops you can //mobmon runto    to run in the direction/towards its x/y coords.
-- Two notes:
-- * You still have to target/claim yourself
-- * This works based off Mob Array - so you're going to have to be withina bout 50 yalms of it popping

-- Usage: //mobmon "Name of Mob"
-- 		  //mobmon runto    (runs in direction of mob)
--		   //mobmon 0xXX  (hex of the mob)
--		  //mobmon 101  (index of mob)
-- Example:  //mobmon Sisyphus
 

_addon.name = 'mobmon'
_addon.author = 'Sammeh'
_addon.version = '1.0.0.2'
_addon.command = 'mobmon'

require 'tables'
require 'sets'
require 'strings'
require 'actions'
require 'pack'
texts = require('texts')

defaults = {}
defaults.pos = {}
defaults.pos.x = -178
defaults.pos.y = 51
defaults.text = {}
defaults.text.font = 'Arial'
defaults.text.size = 14
defaults.flags = {}
defaults.flags.right = true

txtbox = texts.new('${value}', defaults)

last_seen = ''

txtbox.value = nil
mobname = nil

function mobup(name)
 local self = windower.ffxi.get_player()
 local currentmobs = windower.ffxi.get_mob_array()
 for i,v in pairs(currentmobs) do
	if (v.name == name or (tonumber(name) and tonumber(name) == v.index)) and v.hpp > 0 then 
		mob_by_id = v.id
		mobup_run = os.clock()
		last_seen = os.date()
	end
 end
end

windower.register_event('addon command', function(command)
	if command:lower() == 'runto' then 
		local mobinfo = windower.ffxi.get_mob_by_id(mob_by_id)
		runto(mobinfo,1)
	else
		mobname = command
		txtbox:visible(true)
	end
end)

function runto(actor,action_distance)
	local target = {}
	if actor then
		target = actor
	else 
		target = windower.ffxi.get_mob_by_index(windower.ffxi.get_player().target_index or 0)
	end
	
	local self_vector = windower.ffxi.get_mob_by_index(windower.ffxi.get_player().index or 0)
	if target and target.name ~= self_vector.name then  -- Please note if you target yourself you will run Due East
		local angle = (math.atan2((target.y - self_vector.y), (target.x - self_vector.x))*180/math.pi)*-1
		windower.ffxi.run((angle):radian())
		autorun = 1
		autorun_target = target
		autorun_distance = action_distance
		autorun_tofrom = 1	
	else
		windower.add_to_chat(10,"Nothing to run to")
	end
end



windower.register_event('prerender', function()
	if mobname then 
		mobup(mobname)
		if mobup_run and (os.clock() - mobup_run) < 1 then 
			txtbox:color(0,255,0)
			txtbox.value = mobname..last_seen
		else
			txtbox:color(255,255,255)
			txtbox.value = mobname..last_seen
		end
		
		--txtbox.value = mobname..last_seen
	end
end)

windower.register_event('job change', function()
end)
