--[[
Copyright © 2016, Sammeh of Quetzalcoatl, adaptations Copyright © 2018 Iminiillusions of Quetzalcoatl.
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of Skillup nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Sammeh or Iminiillusions BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]



_addon.name = 'skillup'
_addon.author = 'Sammeh, adapted by Iminiillusions'
_addon.version = '1.0.1'
_addon.command = 'skillup'


require('chat')

delay = 6  -- how much delay in between spells
spell_list = {
	healing = T{
		'Cure', 
		'Cure II'
		}
	enhancing = T{
		'Protect',
		'Protect II'
		}
	blue = T{
		'Pollen',
		'Wild Carrot'
		}
	geomancy= T{
		'Indi-Poison',
		'Indi-Voidance'
		}
	summoning = T{
		'Carbuncle',
		'Garuda'
		}
}


continue = false

windower.register_event('addon command', function(command, skill)
		if command == 'help'
			display_help()
		elseif command == 'stop' then
			continue = false
		elseif command == 'start' then
			continue = true
			skill_up(skill)
		end
	end
end)

function skill_up(skill)
	while continue do 
		for _, spell in pairs(spell_list[skill]) do
			windower.send_command('input /ma '..v..' <me>')
			coroutine.sleep(delay)
		end
	end
end

function display_help()
	windower.add_to_chat(7, _addon.name..'v.'.._addon.version..'by'.._addon.author)
	windower.add_to_chat(7, 'Usage: //skillup start healing | enhancing | blue | geomancy | summoning')
	windower.add_to_chat(7, 'To Stop: //skillup stop')
end
