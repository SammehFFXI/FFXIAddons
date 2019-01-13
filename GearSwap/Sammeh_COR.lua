packets = require('packets')

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	windower.add_to_chat(4,'F11: Auto RA')
	windower.add_to_chat(4,'ALT  F11: WS Selection')
	windower.add_to_chat(4,'CTRL F11: Auto WS')
	-- for Auto RA
	rngdelay = 1
	
    state.IdleMode:options('Normal','PDT')
	state.TPMode = M{['description']='TP Mode', 'Normal','RACC'}
	state.RngMode = M{['description']='Ranger Mode', 'Fomalhaut','Armageddon'}
	state.AreaRolls = M{['description']='Area of Rolls','Large','Small'}
	state.AutoRA = M{['description']='Auto RA','false','true'}
	state.AutoWSMode = M{['description']='Auto WS Mode','false','true'}
	state.AutoWS = M{['description']='Auto WS',"Last Stand","Leaden Salute"}
	state.Bullet = M{['description']='Bullet','Normal','Stun'}
	
	send_command('alias tp gs c cycle tpmode')
	send_command('alias rngmode gs c cycle rngmode')
	send_command('alias boltmode gs c cycle Bolt')
	send_command('bind f9 gs c cycle RngMode')
	send_command('bind !f9 gs c cycle Arrow')
	send_command('bind ^f9 gs c cycle Bolt')
	send_command('bind ^f10 gs c cycle Bullet')
    send_command('bind f10 gs c cycle idlemode')
	send_command('bind f11 gs c cycle AutoRA')
	send_command('bind ^f11 gs c cycle AutoWSMode')
	send_command('bind !f11 gs c cycle AutoWS')
	send_command('bind f12 gs c wslist')
	send_command("alias g11_m2g16 gs c ws 1")
	send_command("alias g11_m2g17 gs c ws 2")
	send_command("alias g11_m2g18 gs c ws 3")
	select_default_macro_book()
	if player.sub_job == 'NIN' then
	-- send_command('@wait 1;input /equip sub "Perun"')   
	end
	send_command('@wait 1;input /lockstyleset 22')
	
	
	-- Set Common Aliases --
											  
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias preshot gs equip sets.precast.PreShot")
	send_command("alias rngtp gs equip sets.midcast.TP.normal")
	send_command("alias rngtpacc gs equip sets.midcast.TP.RACC")
	send_command("alias wsset gs equip sets.precast.WS")
	send_command("alias agiwsset gs equip sets.precast.WS['Last Stand']")
	send_command("alias mwsset gs equip sets.precast.WS['Trueflight']")
	send_command("alias jr gs equip sets.Jishnus")
	
	add_to_chat(2,'Ranged Weapon:'..player.equipment.range)
	send_command("gs c set RngMode Armageddon")
	send_command("dp gun")
	state.AutoWS = M{['description']='Auto WS','Last Stand','Leaden Salute'}
	
	res = require 'resources'
	
	WeaponSkill = {
		["Marksmanship"] = {
			["1"] = "Wildfire",
			["2"] = "Last Stand",
			["3"] = "Leaden Salute"
		},
		
	}
	define_roll_values()	
	
end

	
function init_gear_sets()
	
	
	TP_Hands = "Meg. Gloves +2"
	
	if state.RngMode.value == 'Fomalhaut' then 
	  RNGWeapon = "Fomalhaut"
	  TP_Ammo="Chrono Bullet"
	  WS_Ammo="Chrono Bullet"
	  if state.Bullet.value == 'Stun' then
		TP_Ammo="Spartan Bullet"
		WS_Ammo="Spartan Bullet"
	  end
	  TP_Hands = "Meg. Gloves +2"
	  send_command("alias rngws1 input /ws 'Wildfire' <t>")
	  send_command("alias rngws2 input /ws 'Last Stand' <t>")
	  send_command("alias rngws3 input /ws 'Leaden Salute' <t>")
	elseif state.RngMode.value == 'Armageddon' then 
	  RNGWeapon = "Armageddon"
	  TP_Ammo="Chrono Bullet"
	  WS_Ammo="Chrono Bullet"
	  if state.Bullet.value == 'Stun' then
		TP_Ammo="Spartan Bullet"
		WS_Ammo="Spartan Bullet"
	  end
	  TP_Hands = "Meg. Gloves +2"
	  send_command("alias rngws1 input /ws 'Wildfire' <t>")
	  send_command("alias rngws2 input /ws 'Last Stand' <t>")
	  send_command("alias rngws3 input /ws 'Leaden Salute' <t>")
	  
	end
	
			
    ---  PRECAST SETS  ---
    sets.precast = {}
	sets.precast.PreShot = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		--body="Nisroch Jerkin",
		body="Oshosi Vest +1",
		hands="Carmine Fin. Ga. +1",  -- 8 --
        head="Oshosi Mask +1",
		legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
		--feet="Adhemar Gamashes", -- 8 -- 
		feet="Meg. Jam. +2", -- 10 -- 
		neck="Iskur Gorget",
		waist="Yemaya Belt",    
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		right_ring="Dingir Ring",
		left_ring="Ilabrat Ring",
		--back={ name="Belenus's Cape", augments={'"Snapshot"+10',}}, -- 10 -- 
    } -- Snapshot: 47  -- Rapid Shot:16
	
	
	sets.midcast.TP = {} 
	sets.midcast.TP.normal = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		-- head="Arcadian Beret +2",
        head="Oshosi Mask +1",
		body="Nisroch Jerkin",
		hands=TP_Hands,
		legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		feet="Adhemar Gamashes",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		right_ring="Dingir Ring",
		left_ring="Ilabrat Ring",
		-- back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.midcast.TP.DoubleShotArmageddon = {
	    --head={ name="Arcadian Beret +2", augments={'Enhances "Recycle" effect',}},
		--head="Meghanada Visor +2",
		head="Oshosi Mask +1",
		-- body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		
		--hands="Mummu Wrists +2",
		hands="Oshosi Gloves +1",
		legs="Mummu Kecks +2",
		feet="Oshosi Leggings +1",
		neck="Iskur Gorget",
		--waist="Yemaya Belt",
		waist="K. Kachina Belt +1",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Mummu Ring",
		right_ring="Dingir Ring",
		-- back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}},
	}
	sets.midcast.TP.ArmageddonAftermath = {
	    --head="Meghanada Visor +2",
		head="Oshosi Mask +1",
		body="Nisroch Jerkin",
		--hands="Mummu Wrists +2",
		hands="Oshosi Gloves +1",
		legs="Mummu Kecks +2",
		-- feet="Thereoid Greaves",
		feet="Oshosi Leggings +1",
		neck="Iskur Gorget",
		--waist="Yemaya Belt",
		waist="K. Kachina Belt +1",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Mummu Ring",
		right_ring="Dingir Ring",
		-- back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}},
	}
	sets.midcast.TP.RACC = {
		range=RNGWeapon,
		ammo=TP_Ammo,
		head="Meghanada Visor +2",
		body="Nisroch Jerkin",
		hands="Meg. Gloves +2",
		legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		-- back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	
	
	--Job Abilities
	sets.precast.JA = {}
    sets.precast.JA['Phantom Roll'] = {head="Lanun Tricorne",ring2="Luzaf's Ring",hands="Chasseur\'s Gants",back="Camulus\'s Mantle",neck="Regal Necklace"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +1"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
    sets.precast.JA.Wildcard = {feet="Lanun Bottes +2"}
	
	
	-- WS Sets
	sets.precast.WS = {
	    ammo=TP_Ammo,
		-- head="Orion Beret +3",
		--head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body="Nisroch Jerkin",
		hands="Meg. Gloves +2",
		legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		--legs="Amini Brague +1",
		feet={ name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +2%','Rng.Acc.+1','Rng.Atk.+9',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		-- back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Last Stand'] = {
	    -- head="Orion Beret +3",
		body="Nisroch Jerkin",
		hands="Meg. Gloves +2",
		legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		feet={ name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +2%','Rng.Acc.+1','Rng.Atk.+9',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		-- back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Trueflight'] = {
		-- head="Orion Beret +3"
		ammo="Devastating Bullet",
	    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Enmity-5','VIT+6','Mag. Acc.+13','"Mag.Atk.Bns."+13',}},
		body={ name="Herculean Vest", augments={'"Mag.Atk.Bns."+26','"Dbl.Atk."+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		hands="Carmine Fin. Ga. +1",
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Dbl.Atk."+1','STR+7','Mag. Acc.+13','"Mag.Atk.Bns."+10',}},
		-- feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
		feet="Lanun Bottes +2",
		--neck="Fotia Gorget",
		--waist="Fotia Belt",
		neck="Sanctity necklace",
		waist="Eschan Stone",
		left_ear="Crematio Earring",
		right_ear="Moonshade Earring",
		right_ring="Dingir Ring",
		left_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','AGI+10','Weapon skill damage +10%',}},
	}
    sets.precast.WS['Wildfire'] = sets.precast.WS['Trueflight']
	sets.precast.WS['Leaden Salute'] = sets.precast.WS['Trueflight']
	
    ---  AFTERCAST SETS  ---
    sets.idle = set_combine(sets.precast.PreShot, {feet="Skadi's Jambeaux +1"})
	sets.Idle = sets.idle
	sets.Idle.Current = sets.Idle

	
end

function job_precast(spell)
	last_precast = spell
    handle_equipping_gear(player.status)
	checkblocking(spell)
	if not buffactive["Triple Shot"] and spell.name == "Ranged" then
	  doubleshot_recasttime = windower.ffxi.get_ability_recasts()[84] 
	  if doubleshot_recasttime == 0 then 
	    windower.add_to_chat(8,"Turn on Triple Shot!")
	  end
	end
	
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  return
	end
    if spell.type == "CorsairRoll" or spell.english == "Double-Up" then 
	  if state.AreaRolls.value == "Large" then 
	    equip(set_combine(sets.precast.JA['Phantom Roll'], {ring2="Luzaf's Ring"}))
	  else 
	    equip(sets.precast.JA['Phantom Roll'])
	  end
	  if buffactive["Snake Eye"] then
	    equip(sets.precast.JA['Snake Eye'])
	  end
	end
	
end

function job_post_precast(spell)
  weathercheck(spell.element)
end

function job_post_midcast(spell)
    if spell.english == 'Sneak' and buffactive.sneak and spell.target.type == 'SELF' then
        send_command('@wait 1;cancel 71;')
    end
	if spell.name == 'Utsusemi: Ichi' then
	  send_command('cancel Copy Image|Copy Image (2)')
	end
	
	if spell.name == 'Ranged' then
	 if state.TPMode.value == 'Normal' then
	   equip(sets.midcast.TP.normal)
	 elseif state.TPMode.Value == 'RACC' then
	   equip(sets.midcast.TP.RACC)
	 end
	 if player.equipment.range == "Armageddon" and (buffactive["Aftermath: Lv.3"] or buffactive["Aftermath: Lv.2"] or buffactive["Aftermath: Lv.1"]) then
		equip(sets.midcast.TP.ArmageddonAftermath)
	 end
	 if buffactive['Double Shot'] and player.equipment.range == "Armageddon" and (buffactive["Aftermath: Lv.3"] or buffactive["Aftermath: Lv.2"] or buffactive["Aftermath: Lv.1"]) then
	   equip(sets.midcast.TP.DoubleShotArmageddon)
	 end
     if buffactive.Barrage then
		windower.add_to_chat(8,"Barrage Active - adding in hands")
        equip(sets.Barrage)
     end
    end
	if spell.type == "WeaponSkill" then
	  tpspent = spell.tp_cost
	end

end        


function job_aftercast(spell)
	if state.SpellDebug.value == "On" then 
      spelldebug(spell)
	end
    if spell.type == 'CorsairRoll' and not spell.interrupted then
        display_roll_info(spell)
    end
    handle_equipping_gear(player.status)
    equip(sets.idle)
end



function status_change(new,tab)
	handle_equipping_gear(player.status)
    if new == 'Resting' then
        equip(sets.Resting)
    else
        equip(sets.idle)
    end
end

function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.idle)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
	init_gear_sets()
	disable_specialgear()
end

							 


function select_default_macro_book()
    set_macro_page(4, 1)
end


 function job_self_command(command)
	if command[1]:lower() == "ws" and command[2] ~= nil then
		local EquipedGear = windower.ffxi.get_items()
		local CurrentSkill
		if EquipedGear.equipment.range == nil or EquipedGear.equipment.range == 0 then 
		  CurrentSkill = "Hand-to-Hand"
		else 
		  CurrentSkill = res.skills[res.items[windower.ffxi.get_items(EquipedGear.equipment.range_bag, EquipedGear.equipment.range).id].skill].en
		end
		send_command('input /ws '..WeaponSkill[CurrentSkill][command[2]])
	end
	if command[1]:lower() == "wslist" then
		local EquipedGear = windower.ffxi.get_items()
		local CurrentSkill
		if EquipedGear.equipment.range == nil or EquipedGear.equipment.range == 0 then 
		  CurrentSkill = "Hand-to-Hand"
		else 
		  CurrentSkill = res.skills[res.items[windower.ffxi.get_items(EquipedGear.equipment.range_bag, EquipedGear.equipment.range).id].skill].en
		end
		windower.add_to_chat(2,"WS List:")
		for i,v in pairs(WeaponSkill[CurrentSkill]) do
			windower.add_to_chat(2,i..") "..v)
		end
	end
end

windower.raw_register_event('incoming chunk', function(id,original,modified,injected,blocked)
	local self = windower.ffxi.get_player()
    if id == 0x028 then
		local packet = packets.parse('incoming', original)
		local category = packet['Category']
		if packet.Actor == self.id and category == 2 then 
			if state.AutoRA.value == 'true' then 
				if state.AutoWSMode.value == 'true' and player.tp >= 1000 then 
					send_command('wait '..rngdelay..';input /ws "'..state.AutoWS.value..'" <t>')
				else 
					send_command('wait '..rngdelay..'; input /ra <t>')
				end
			end
		end
		if packet.Actor == self.id and category == 3 and state.AutoRA.value == 'true' then 
			send_command('wait 3.5; input /ra <t>')
		end
	end

end)




--[[
windower.raw_register_event('incoming text', function(original)
	if string.contains(original,"You must wait longer") then 
		--print('Interrupted:'..last_precast.name,os.clock())
		if last_precast.name == 'Ranged' then 
			send_command('wait .5; input /ra <t>')
			return true
		end
	end
end)

]]

function define_roll_values()

    rolls = {
        ["Corsair's Roll"]   = {lucky=5, unlucky=9, bonus="Experience Points"},
        ["Ninja Roll"]       = {lucky=4, unlucky=8, bonus="Evasion"},
        ["Hunter's Roll"]    = {lucky=4, unlucky=8, bonus="Accuracy"},
        ["Chaos Roll"]       = {lucky=4, unlucky=8, bonus="Attack"},
        ["Magus's Roll"]     = {lucky=2, unlucky=6, bonus="Magic Defense"},
        ["Healer's Roll"]    = {lucky=3, unlucky=7, bonus="Cure Potency Received"},
        ["Puppet Roll"]      = {lucky=3, unlucky=7, bonus="Pet Magic Accuracy/Attack"},
        ["Choral Roll"]      = {lucky=2, unlucky=6, bonus="Spell Interruption Rate"},
        ["Monk's Roll"]      = {lucky=3, unlucky=7, bonus="Subtle Blow"},
        ["Beast Roll"]       = {lucky=4, unlucky=8, bonus="Pet Attack"},
        ["Samurai Roll"]     = {lucky=2, unlucky=6, bonus="Store TP"},
        ["Evoker's Roll"]    = {lucky=5, unlucky=9, bonus="Refresh"},
        ["Rogue's Roll"]     = {lucky=5, unlucky=9, bonus="Critical Hit Rate"},
        ["Warlock's Roll"]   = {lucky=4, unlucky=8, bonus="Magic Accuracy"},
        ["Fighter's Roll"]   = {lucky=5, unlucky=9, bonus="Double Attack Rate"},
        ["Drachen Roll"]     = {lucky=4, unlucky=8, bonus="Pet Accuracy"},
        ["Gallant's Roll"]   = {lucky=3, unlucky=7, bonus="Defense"},
        ["Wizard's Roll"]    = {lucky=5, unlucky=9, bonus="Magic Attack"},
        ["Dancer's Roll"]    = {lucky=3, unlucky=7, bonus="Regen"},
        ["Scholar's Roll"]   = {lucky=2, unlucky=6, bonus="Conserve MP"},
        ["Bolter's Roll"]    = {lucky=3, unlucky=9, bonus="Movement Speed"},
        ["Caster's Roll"]    = {lucky=2, unlucky=7, bonus="Fast Cast"},
        ["Courser's Roll"]   = {lucky=3, unlucky=9, bonus="Snapshot"},
        ["Blitzer's Roll"]   = {lucky=4, unlucky=9, bonus="Attack Delay"},
        ["Tactician's Roll"] = {lucky=5, unlucky=8, bonus="Regain"},
        ["Allies' Roll"]    = {lucky=3, unlucky=10, bonus="Skillchain Damage"},
        ["Miser's Roll"]     = {lucky=5, unlucky=7, bonus="Save TP"},
        ["Companion's Roll"] = {lucky=2, unlucky=10, bonus="Pet Regain and Regen"},
        ["Avenger's Roll"]   = {lucky=4, unlucky=8, bonus="Counter Rate"},
    }
end



function display_roll_info(spell)
    rollinfo = rolls[spell.english]
    local rollsize = state.AreaRolls.value 
    if rollinfo then
	    if spell.value < 12 then 
        -- add_to_chat(8, spell.english..' provides a bonus to '..rollinfo.bonus..'.  Roll size: '..rollsize)
			add_to_chat(8, 'Lucky roll is '..tostring(rollinfo.lucky)..', Unlucky roll is '..tostring(rollinfo.unlucky)..'.   Your Roll:'..spell.value)
			if spell.value == 11 then 
				add_to_chat(217,'You got an 11! Stop doubling up!')
			elseif spell.value == rollinfo.lucky then
				add_to_chat(217,'You hit lucky roll!!')
			elseif spell.value < rollinfo.lucky then 
				local rolldiff = rollinfo.lucky - spell.value
				add_to_chat(218,'You are only '..rolldiff..' away from a Lucky roll!')
				if rolldiff == 1 then 
					add_to_chat(218,'Considering using Snake Eye to hit Lucky')
				end
			elseif spell.value > rollinfo.lucky then
				local rolldiff = 11 - spell.value
				add_to_chat(218,'Rolling for 11! You need '..rolldiff..' to hit it!')
				if rolldiff == 1 then 
					add_to_chat(218,'Considering using Snake Eye to hit 11')
				end
				if rolldiff < 6 then
					local bustrisk = 100 - math.floor(rolldiff / 6 * 100)
					add_to_chat(167,'Caution!!! You have a '..bustrisk..'% chance of BUST!')
				end
			end
		end
    end

end




function select_default_macro_book()
    set_macro_page(4, 1)
end
