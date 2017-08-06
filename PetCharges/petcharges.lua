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
    * Neither the name of PetCharges nor the
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


_addon.name = 'PetCharges'
_addon.author = 'Sammeh'
_addon.version = '1.7' 
_addon.command = 'petcharges'

config = require('config')
texts = require('texts')
res = require 'resources'
packets = require('packets')

abilitytxt = {}
abilitytxt.pos = {}
abilitytxt.pos.x = -80
abilitytxt.pos.y = 45
abilitytxt.text = {}
abilitytxt.text.font = 'Arial'
abilitytxt.text.size = 10
abilitytxt.flags = {}
abilitytxt.flags.right = true

settings = config.load(abilitytxt)
abilities_list = texts.new('${value}', settings)
showabilities = true

equip_reduction = 0


function displayabilities()
  if pet then
    local list = "Charges: "..charges.." - "..next_ready_recast.."\n"
    for key,ability in pairs(abilitylist) do
        ability_en = res.job_abilities[ability].en
        ability_type = res.job_abilities[ability].type
        ability_targets = res.job_abilities[ability].targets
        ability_charges = res.job_abilities[ability].mp_cost
        if ability_targets.Self == true and ability_type == 'Monster' then
            if charges >= ability_charges then 
                list = list..'\\cs(0,255,0)'..ability_en..'\\cs(255,255,255)'..'\n'
            else
                list = list..'\\cs(255,255,255)'..ability_en..'\n'
            end
        end
    end
    abilities_list.value = list
    abilities_list:visible(true)
  else
    abilities_list:visible(false)
  end
end

windower.register_event('prerender', function()
    if self then
        if self.main_job == 'BST' then
            duration = windower.ffxi.get_ability_recasts()[102]
            if duration then 
                chargebase = (30 - merits - jobpoints - equip_reduction)
                charges = math.floor(((chargebase * 3) - duration) / chargebase)
                next_ready_recast = math.fmod(duration,chargebase)
                displayabilities()
            end
        end
    end
end)

windower.register_event('outgoing chunk',function(id,data)
    if id == 0x01A then
        local packet = packets.parse('outgoing', data)
        local ability_used = packet.Param
        local category = packet.Category
        if res.job_abilities[ability_used] then 
            if res.job_abilities[ability_used].type == 'Monster' and category == 9 then
                expect_ready_move = true
            end
        end
    end
end)

windower.register_event('incoming chunk',function(id,data)
    if id == 0x119 and expect_ready_move then
        local gear = windower.ffxi.get_items()
        local mainweapon = res.items[windower.ffxi.get_items(gear.equipment.main_bag, gear.equipment.main).id].en
        local subweapon = res.items[windower.ffxi.get_items(gear.equipment.sub_bag, gear.equipment.sub).id].en
        local legs = res.items[windower.ffxi.get_items(gear.equipment.legs_bag, gear.equipment.legs).id].en
    
        equip_reduction = 0
        if mainweapon == "Charmer's Merlin" or subweapon == "Charmer's Merlin" then 
            equip_reduction = equip_reduction + 5
        end
        if legs == "Desultor Tassets" then
            equip_reduction = equip_reduction + 5
        end
        expect_ready_move = false
    end
	if id == 0x67 or id == 0x68 then
		local packet = packets.parse('incoming', data)
		local msg_type = packet['Message Type']
		pet_idx = packet['Pet Index']
		if pet_idx ~= 0 and msg_type == 0x04 then 
			pet = windower.ffxi.get_mob_by_target('pet')
			abilitylist = windower.ffxi.get_abilities().job_abilities
		else
			if pet_idx == 0 then 
				pet = nil
			end
		end
	end
end)

windower.register_event('addon command', function(command)
    if command == 'save' then
        config.save(settings, 'all')
    end
	if command == 'jp' then
	  for i,v in pairs(self.merits) do
	    print (i,v)
	  end
	end
end)

windower.register_event('load', function()
    if windower.ffxi.get_player() then 
        coroutine.sleep(2) 
        self = windower.ffxi.get_player()
		if self.job_points.bst.jp_spent >= 100 then
			jobpoints = 5
		else
			jobpoints = 0
		end	
    end
	merits = self.merits.sic_recast
end)

windower.register_event('login', function()
    coroutine.sleep(2)
    self = windower.ffxi.get_player()
	if self.job_points.bst.jp_spent >= 100 then
		jobpoints = 5
	else
		jobpoints = 0
	end	
	merits = self.merits.sic_recast
end)

windower.register_event('zone change', function(command)
    coroutine.sleep(2)
    self = windower.ffxi.get_player()
	if self.job_points.bst.jp_spent >= 100 then
		jobpoints = 5
	else
		jobpoints = 0
	end	
	merits = self.merits.sic_recast
	pet = windower.ffxi.get_mob_by_target('pet')
	abilitylist = windower.ffxi.get_abilities().job_abilities
end)

windower.register_event('job change', function(command)
    coroutine.sleep(2)
    self = windower.ffxi.get_player()
	if self.job_points.bst.jp_spent >= 100 then
		jobpoints = 5
	else
		jobpoints = 0
	end	
	merits = self.merits.sic_recast
	pet = windower.ffxi.get_mob_by_target('pet')
	abilitylist = windower.ffxi.get_abilities().job_abilities
end)

