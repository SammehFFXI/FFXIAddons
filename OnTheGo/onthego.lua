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
    * Neither the name of OnTheGo nor the
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



_addon.name = 'OnTheGo'
_addon.author = 'Sammeh'
_addon.version = '1.1'
_addon.command = 'otg'


res = require 'resources'
packets = require('packets')

autorun = 0

windower.register_event('outgoing chunk',function(id,data)
	if id == 0x037 then
		local packet = packets.parse('outgoing', data)
		if type(windower.ffxi.get_player().autorun) == 'table' then 
			item_used = res.items[windower.ffxi.get_items(packet.Bag, packet.Slot).id].en
			windower.add_to_chat(3,'Currently auto-running - Stopping to Use Item:'..item_used)
			windower.ffxi.run(false)
			windower.ffxi.follow()  -- disabling Follow - turning back autorun automatically turns back on follow.
			autorun = 1
		end
	end
end)


windower.register_event('incoming chunk',function(id,data)
	if id == 0x028 then
		local self = windower.ffxi.get_player() 
		local packet = packets.parse('incoming', data)
		if packet.Category == 5 and autorun == 1 and self.id == packet.Actor then 
			windower.ffxi.run()  -- start Running again
			autorun = 0
		end
	end
end)
