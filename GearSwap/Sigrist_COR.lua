
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
    state.IdleMode:options('Normal','PDT')
	state.TPMode = M{['description']='TP Mode', 'Normal','RACC'}
	state.AreaRolls = M{['description']='Area of Rolls','Large','Small'}
	send_command('bind f9 gs c cycle AreaRolls')
	send_command('alias tp gs c cycle tpmode')
	send_command('bind f10 gs c cycle idlemode')
	select_default_macro_book()
	--if player.sub_job == 'NIN' then
	-- equip(sub="Perun")  
	-- end
	send_command('@wait 1;input /lockstyleset 1')
	send_command('@wait 1;input //lua load rolltracker')
	
	-- Set Common Aliases --
	send_command("alias idle gs equip sets.idle")
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias preshot gs equip sets.precast.PreShot")
	send_command("alias rngtp gs equip sets.midcast.TP.normal")
	send_command("alias rngtpacc gs equip sets.midcast.TP.RACC")
	send_command("alias wsset gs equip sets.precast.WS")
	send_command("alias mwsset gs equip sets.precast.WS['Leaden Salute']")
	
	define_roll_values()
	
end

function user_unload()
	send_command('@wait 1;input //lua unload rolltracker')
end

	
function init_gear_sets()
	
	TP_Hands = { name="Herculean Gloves", augments={'Rng.Acc.+15 Rng.Atk.+15','Weapon skill damage +2%','DEX+9','Rng.Atk.+15',}}
    RNGWeapon = "Molybdosis"
	TP_Ammo="Adlivun Bullet"
	WS_Ammo="Adlivun Bullet"
	send_command("alias rngws1 input /ws 'Leaden Salute' <t>")
	send_command("alias rngws2 input /ws 'Last Stand' <t>")
	send_command("alias rngws3 input /ws 'Wildfire' <t>")
			
    ---  PRECAST SETS  ---
    sets.precast = {}
	sets.precast.PreShot = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		head="Meghanada Visor +2",
		body="Oshosi Vest",
		hands="Carmine Fin. Ga. +1",
		legs="Mirador Trou. +1",
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Infused Earring",
		right_ear="Neritic Earring",
		left_ring="Defending Ring",
		right_ring="Ilabrat Ring",
		back="Camulus's Mantle",
    }
	
	sets.midcast.TP = {} 
	sets.midcast.TP.normal = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		head="Meghanada Visor +2",
		body="Oshosi Vest",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Infused Earring",
		right_ear="Neritic Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.engaged = {
	    head="Meghanada Visor +2",
		body="Sayadio's Kaftan",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Sanctity Necklace",
		waist="Yemaya Belt",
		left_ear="Steelflash Earring",
		right_ear="Bladeborn Earring",
		left_ring="Epona's Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.midcast.TP.RACC = {
		head="Meghanada Visor +2",
		body="Oshosi Vest",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Infused Earring",
		right_ear="Neritic Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
    
	--Job Abilities
	sets.precast.JA = {}
    sets.precast.JA['Phantom Roll'] = {head="Lanun Tricorne",ring2="Luzaf's Ring",hands="Chasseur\'s Gants",back="Camulus\'s Mantle",neck="Regal Necklace"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac +3"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Trews"}
    sets.precast.JA['Wild Card'] = {feet="Lanun Bottes +3"}
    
	-- WS Sets
	sets.precast.WS = {
	    ammo=TP_Ammo,
		head="Meghanada Visor +2",
		body="Meg. Cuirie +1",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +2",
		feet="Meg. Jam. +2",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Infused Earring",
		right_ear="Neritic Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Leaden Salute'] = {
	    head={ name="Herculean Helm", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +2%','INT+8','Mag. Acc.+15',}},
		--head="Pixie Hairpin +1",
		body={ name="Lanun Frac +3", augments={'Enhances "Loaded Deck" effect',}},
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		--legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+3%','MND+3','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+21','DEX+1','Phalanx +3','Accuracy+19 Attack+19','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		--feet={ name="Herculean Boots", augments={'Accuracy+29','INT+7','"Refresh"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet="Lanun Bottes +3",
		neck="Sanctity Necklace",
		waist="Yemaya Belt",
		left_ear="Hermetic Earring",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
	}
    sets.precast.WS['Wildfire'] = sets.precast.WS['Leaden Salute']
	sets.precast.CorsairShot = {
	    head={ name="Herculean Helm", augments={'Mag. Acc.+18 "Mag.Atk.Bns."+18','Weapon skill damage +2%','INT+8','Mag. Acc.+15',}},
		body="Oshosi Vest",
		hands={ name="Carmine Fin. Ga. +1", augments={'Rng.Atk.+20','"Mag.Atk.Bns."+12','"Store TP"+6',}},
		legs={ name="Herculean Trousers", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+3%','MND+3','Mag. Acc.+9','"Mag.Atk.Bns."+5',}},
		--feet={ name="Herculean Boots", augments={'Accuracy+29','INT+7','"Refresh"+2','Mag. Acc.+16 "Mag.Atk.Bns."+16',}},
		feet="Lanun Bottes +3",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Hermetic Earring",
		right_ear="Friomisi Earring",
		left_ring="Dingir Ring",
		right_ring="Ilabrat Ring",
		back={ name="Camulus's Mantle", augments={'AGI+20','Mag. Acc+20 /Mag. Dmg.+20','Weapon skill damage +10%',}},
	}
	
    ---  AFTERCAST SETS  ---
    sets.idle = set_combine(sets.precast.PreShot)

	
end

function job_precast(spell)
    handle_equipping_gear(player.status)
	checkblocking(spell)
	
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  return
	end
    if spell.name == 'Ranged' then
        equip(sets.precast.PreShot)
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
	if spell_element == world.weather_element then
        equip(sets.weather)
        if sets.obi[spell_element] then
            equip({waist="Anrin Obi"})
        end
    end
    if spell_element == world.day_element then
        equip(sets.day)
        if sets.obi[spell_element] then
            equip({waist="Anrin Obi"})
        end
    end
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
	disable_specialgear()
end

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
