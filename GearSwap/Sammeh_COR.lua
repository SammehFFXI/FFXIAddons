
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
	-- send_command('@wait 1;input /lockstyleset 22')
	
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

	
function init_gear_sets()
	
	TP_Hands = { name="Herculean Gloves", augments={'Rng.Acc.+15 Rng.Atk.+15','Weapon skill damage +2%','DEX+9','Rng.Atk.+15',}}
    RNGWeapon = "Fomalhaut"
	TP_Ammo="Chrono Bullet"
	WS_Ammo="Chrono Bullet"
	send_command("alias rngws1 input /ws 'Leaden Salute' <t>")
	send_command("alias rngws2 input /ws 'Last Stand' <t>")
	send_command("alias rngws3 input /ws 'Wildfire' <t>")
			
    ---  PRECAST SETS  ---
    sets.precast = {}
	sets.precast.PreShot = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body="Oshosi Vest", -- 6 --
		hands="Carmine Fin. Ga. +1",  -- 8 --
		legs="Adhemar Kecks",  -- 9 -- 
		feet="Adhemar Gamashes", -- 8 -- 
		neck="Iskur Gorget",
		waist="Yemaya Belt",    -- 3 from impulse belt --
		left_ear="Neritic Earring",
		right_ear="Enervating Earring",
		left_ring="K'ayres Ring",
		right_ring="Rajas Ring",
		back="Camulus's Mantle"
    }
	
	sets.midcast.TP = {} 
	sets.midcast.TP.normal = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body="Oshosi Vest",
		hands=TP_Hands,
		legs="Adhemar Kecks",
		feet="Adhemar Gamashes",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Neritic Earring",
		right_ear="Enervating Earring",
		left_ring="K'ayres Ring",
		right_ring="Rajas Ring",
		back="Camulus's Mantle",
	}
	sets.midcast.TP.RACC = {
		head="Meghanada Visor +1",
		body="Meg. Cuirie +1",
		hands="Meg. Gloves +2",
		legs="Meg. Chausses +1",
		feet="Meg. Jam. +1",
		neck="Iskur Gorget",
		waist="Yemaya Belt",
		left_ear="Neritic Earring",
		right_ear="Enervating Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back="Camulus's Mantle"
	}
    
	--Job Abilities
	sets.precast.JA = {}
    sets.precast.JA['Phantom Roll'] = {head="Lanun Tricorne",ring2="Luzaf's Ring",hands="Chasseur\'s Gants",back="Camulus\'s Mantle",neck="Regal Necklace"}
	sets.precast.JA['Random Deal'] = {body="Lanun Frac"}
	sets.precast.JA['Snake Eye'] = {legs="Lanun Culottes"}
    sets.precast.JA.Wildcard = {feet="Lanun Bottes"}
    
	-- WS Sets
	sets.precast.WS = {
	    ammo=TP_Ammo,
		head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+23 Rng.Atk.+23','Weapon skill damage +3%','Rng.Atk.+9',}},
		hands="Meg. Gloves +2",
		legs="Adhemar Kecks",
		feet={ name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +2%','Rng.Acc.+1','Rng.Atk.+9',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",
		left_ring="K'ayres Ring",
		right_ring="Rajas Ring",
		back="Camulus's Mantle"
	}
	sets.precast.WS['Leaden Salute'] = {
	    head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body={ name="Herculean Vest", augments={'"Mag.Atk.Bns."+26','"Dbl.Atk."+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		hands="Leyline Gloves",
		legs="Gyve Trousers",
		feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Crematio Earring",
		right_ear={ name="Moonshade Earring", augments={'MP+25','TP Bonus +25',}},
		left_ring="Resonance Ring",
		right_ring="Weather. Ring",
		back="Camulus's Mantle",
	}
    sets.precast.WS['Wildfire'] = sets.precast.WS['Leaden Salute']
	
    ---  AFTERCAST SETS  ---
    sets.idle = set_combine(sets.precast.PreShot, {legs="Carmine Cuisses +1"})

	
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
