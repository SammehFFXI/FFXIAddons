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
    * Neither the name of Mumor nor the
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


_addon.name = 'Mumor'
_addon.author = 'Sammeh'
_addon.version = '1.0.1'
_addon.command = 'mumor'

		--[[
		IMPORTANT THIS WILL NOT WORK WITHOUT THIS.
		
		This definition must be inside of libs\packets\fields.lua.  I recommend right after outgoing.0x05C which should end at 692. 
		
-- Emote 
fields.outgoing[0x05D] = L{
    {ctype='unsigned int',      label='Target',             fn=id},             -- 04
    {ctype='unsigned short',    label='Target Index',       fn=index},          -- 08
    {ctype='unsigned char',     label='Emote'},                                 -- 0A -- emote # - pull from resources
	{ctype='unsigned char',     label='Motion'},                                -- 0B -- 0 for normal, 2 for 'motion' (silent)
    {ctype='unsigned short',    label='Dance Index'},                           -- 0C -- dance1 = 2, dance2 = 3, dance3 = 4, dance4 = 5
    {ctype='unsigned short',    label='_unknown1'},                             -- 0E -- always 0
}

		]]


require('chat')
require('logger')
packets = require('packets')
res = require ('resources')

cheerMode = false
HideMotion = false
DanceTarget = "Uka Totlihn"  -- default dance target

windower.register_event('incoming text', function(original, modified, original_mode, modified_mode, blocked)
    if original_mode == 142 and (string.find(original,"I hope you enjoy the show!") and string.find(original,"Bongo")) then 
		DanceTarget = "Uka Totlihn"
	end
	
	if original_mode == 142 and (string.find(original,"the true meaning of dance!") or string.find(original,"I need your help!")) then 
	    cheerMode = true
		LoopCheer()
	end
	if original_mode == 142 and string.find(original,"Keep at it!") then 
	    cheerMode = false
	end
	
	if original_mode == 142 and string.find(original,"Shining Summer Samba") and string.find(original,"Mumor") then 
		send_emote_by_name(DanceTarget,"dance1")
	end
	if original_mode == 142 and string.find(original,"Lovely Miracle Waltz") and string.find(original,"Mumor") then 
		send_emote_by_name(DanceTarget,"dance2")
	end
	if original_mode == 142 and string.find(original,"Neo Crystal Jig") and string.find(original,"Mumor") then 
		send_emote_by_name(DanceTarget,"dance3")
	end
	if original_mode == 142 and string.find(original,"Super Crusher Jig") and string.find(original,"Mumor") then 
		send_emote_by_name(DanceTarget,"dance4")
	end
	if original_mode == 142 and string.find(original,"Curse you, Mumor!") and string.find(original,"Ullegore") then 
		DanceTarget = "Ullegore"
	end
	
	
end)

windower.register_event('addon command', function(command, ...)
	local args = L{...}
	if command:lower() == 'motion' and HideMotion == false then
	   HideMotion = true
	elseif command:lower() == 'motion' and HideMotion == true then
	   HideMotion = false
	end
end)

function LoopCheer()
  while cheerMode == true do
		send_emote_by_name("Mumor","cheer")
		coroutine.sleep(4)
		if cheerMode == false then
		  return
		else
		  send_emote_by_name("Mumor","clap")
		  coroutine.sleep(4)
		end
		if cheerMode == false then
		  return
		else
		  send_emote_by_name("Mumor","wave")
		  coroutine.sleep(4)
		end 
  end 
end

function send_emote_by_name(tname,temote)

		local TargetID,TargetIndex,EmoteID
		for i,v in pairs(windower.ffxi.get_mob_array()) do
			if v.name == tname and v.valid_target == true then
				TargetID = v.id
				TargetIndex = v.index
			end
		end
		
		for i,v in pairs(res.emotes) do
		  if v.command:lower() == temote then 
			EmoteID = i
		  end
		end
		
		local DanceIndex = 0
		local MotionValue = 0
		
		if temote == "dance1" then 
			DanceIndex = 2
		elseif temote == "dance2" then
			DanceIndex = 3
		elseif temote == "dance3" then
			DanceIndex = 4
		elseif temote == "dance4" then
			DanceIndex = 5
		end
		
		if HideMotion == true then
			MotionValue = 2
		end
		
		if TargetID then 
			local packet = packets.new('outgoing', 0x05D, {
				['Target'] = TargetID,
				['Target Index'] = TargetIndex,
				['Motion'] = MotionValue,
				['Emote'] = EmoteID,
				['Dance Index'] = DanceIndex,
			})
			packets.inject(packet)
		end

end

