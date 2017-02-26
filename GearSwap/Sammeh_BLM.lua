
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
-- General Gearswap Commands:
-- F10 Changes Idle Mode
-- Ctrl+F11 = Magical Mode Change

    state.CastingMode:options('Normal', 'MACC','MagicBurst','StoreTP')
    state.IdleMode:options('Normal','PDT','Death')
	state.TPMode = M{['description']='TP Mode', 'Normal', 'WeaponLock'}
	state.SuperTank = M{['description']='Super Tank Mode','Off','On'}
	send_command('alias tank gs c cycle SuperTank')
	send_command('alias tp gs c cycle tpmode')
	send_command('bind f10 gs c cycle idlemode')
	send_command('bind f12 gs c update CastingMode')
	select_default_macro_book()
	send_command('@wait 1;input /lockstyleset 20')
		-- Set Common Aliases --
	send_command("alias idle gs equip sets.Idle.Current")
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias ele gs equip sets.midcast['Elemental Magic'].Main")
	send_command("alias macc gs equip sets.midcast['Elemental Magic'].MACC")
	send_command("alias storetp gs equip sets.midcast['Elemental Magic'].StoreTP")
	send_command("alias magicburst gs equip sets.midcast['Elemental Magic'].MagicBurst")
	send_command("alias enf gs equip sets.midcast['Enfeebling Magic']")
	send_command("alias dark gs equip sets.midcast['Dark Magic']")
	send_command("alias deathset gs equip sets.midcast['Dark Magic'].DeathMagicBurst")
	send_command("alias cureset gs equip sets.midcast['Healing Magic']")
	send_command("alias regen gs equip sets.midcast.Regen")
	send_command("alias myrkrset gs equip sets.precast.WS['Myrkr']")
	send_command("alias manawallset gs equip sets.precast.JA['Mana Wall']")
end

	
function init_gear_sets()

	-- Weapon Locks used for TP Mode.  When WeaponLock is set - it locks in the following Main and SUB. 
	weaponlock_main={ name="Grioavolr", augments={'Magic burst mdg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}}
	--weaponlock_main="Khatvanga"
	weaponlock_sub="Niobid Strap"

    sets.ele = {}
    
    sets.enh = {}


    sets.precast = {}
    sets.precast.JA = {}
    sets.precast.JA['Mana Wall'] = {
	    main="Terra's Staff",
		sub="Alber Strap",
		ammo="Sihirik",
		head={ name="Merlinic Hood", augments={'Attack+1','Magic dmg. taken -4%','Mag. Acc.+9',}},
		body={ name="Hagondes Coat +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -4%','Pet: Accuracy+21 Pet: Rng. Acc.+21',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','"Avatar perpetuation cost" -5',}},
		feet="Wicce Sabots +1",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Genmei Earring",
		right_ear="Handler's Earring +1",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}

	
	sets.precast.FastCast = {
	    --main={ name="Grioavolr", augments={'Magic burst mdg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},
		main="Oranyan",
		sub="Clerisy Strap +1",
		ammo="Pemphredo Tathlum",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+16','"Fast Cast"+6','INT+4',}},
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+2','"Fast Cast"+6','"Mag.Atk.Bns."+1',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Regal Pumps +1",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back="Perimede Cape",
	}
    sets.precast.EnhancingMagic = set_combine(sets.precast.Fastcast,{waist="Siegel Sash"})
    sets.precast.Stoneskin = set_combine(sets.precast.EnhancingMagic,{head="Umuthi Hat",legs="Doyen Pants"})
	sets.precast.Cure = set_combine(sets.precast.FastCast,{back="Pahtli Cape",legs="Doyen Pants",feet="Vanya Clogs"})

	sets.meva = {
		main="Reikikon",
		sub="Irenic Strap +1",
		ammo="Staunch Tathlum",
		head={ name="Telchine Cap", augments={'Mag. Evasion+21','Enemy crit. hit rate -3','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +8',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +10',}},
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Eabani Earring",
		right_ear="Flashward Earring",
		left_ring="Purity Ring",
		right_ring="Vengeful Ring",
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10',}},
	}

	
	-- WS Sets
	sets.precast.WS = {
		ammo="Homiliary",
		head="Alhazen Hat +1",
		body="Onca Suit",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Digni. Earring",
		left_ring="Etana Ring",
		right_ring="Rajas Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	}
	-- Max MP set
    sets.precast.WS['Myrkr'] = {
	    ammo="Pemphredo Tathlum",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+16','"Fast Cast"+6','INT+4',}},
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+2','"Fast Cast"+6','"Mag.Atk.Bns."+1',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Regal Pumps +1",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back="Perimede Cape",
	} 
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    sets.midcast['Elemental Magic'] = {}
	sets.midcast['Elemental Magic'].Main = {
	    main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Niobid Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +3','MND+5','Mag. Acc.+10','"Mag.Atk.Bns."+13',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}},
		neck="Sanctity Necklace",
		waist="Refoccilation Stone",
		left_ear="Barkaro. Earring",
		right_ear="Crematio Earring",
		left_ring="Resonance Ring",
		right_ring="Weather. Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
	sets.midcast['Elemental Magic'].MACC = set_combine(sets.midcast['Elemental Magic'], {
		main={ name="Grioavolr", augments={'Magic burst mdg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},
		sub="Enki Strap",
		left_ear="Hermetic Earring",
		neck="Incanter's Torque",
		hands={ name="Psycloth Manillas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
	})
	sets.midcast['Elemental Magic'].StoreTP = set_combine(sets.midcast['Elemental Magic'].Main, {
		ammo="Seraphic Ampulla",
		head={ name="Helios Band", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Occult Acumen"+7','Mag. crit. hit dmg. +10%',}},
		body="Seidr Cotehardie",
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+8','INT+11','Mag. Acc.+9','"Mag.Atk.Bns."+6',}},
		legs="Perdition Slops",
		feet={ name="Helios Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Occult Acumen"+7','Mag. crit. hit dmg. +9%',}},
		neck="Combatant's Torque",
		waist="Oneiros Rope",
	})
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].Main, {head=empty,body="Twilight Cloak",ring1="K'ayres Ring",ring2="Rajas Ring",neck="Combatant's Torque"})
	sets.midcast['Elemental Magic'].MagicBurst = set_combine(sets.midcast['Elemental Magic'].Main, {
		main={ name="Grioavolr", augments={'Magic burst mdg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},   -- 6
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},  -- 5(over cap)
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+28','Magic burst mdg.+11%','VIT+8','Mag. Acc.+14',}}, -- 11
		neck="Mizu. Kubikazari", -- 10
		left_ring="Locus Ring", -- 5 
		right_ring="Mujin Band", -- 5 (over cap)
		right_ear="Static Earring",  -- 5 
		-- feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}},  -- 7
	}) -- Back adds 5, that gives +52
    sets.midcast['Dark Magic'] = {
	    main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
		sub="Culminus",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body="Shango Robe",
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}},
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		left_ear="Barkaro. Earring",
		right_ear="Crematio Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {right_ear="Digni. Earring"})    
    sets.midcast['Dark Magic'].Death = set_combine(sets.midcast['Elemental Magic'].Main,{head="Pixie Hairpin +1",back="Bane Cape",ring1="Evanescence Ring",ring2="Archon Ring"})
	sets.midcast['Dark Magic'].DeathMagicBurst = set_combine(sets.midcast['Elemental Magic'].MagicBurst, {head={ name="Pixie Hairpin +1",priority=14},back={ name="Taranus's Cape", augments={'MP+60','Mag. Acc+20 /Mag. Dmg.+20','"Fast Cast"+10',},priority=15},ring1="Archon Ring"})
    sets.midcast['Enfeebling Magic'] = {
	    main={ name="Gada", augments={'"Conserve MP"+3','INT+5','Mag. Acc.+24','"Mag.Atk.Bns."+25','DMG:+13',}},
		sub="Chanter's Shield",
		ammo="Pemphredo Tathlum",
		head="Befouled Crown",
		body="Shango Robe",
		hands="Lurid Mitts",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Skaoi Boots",
		neck="Incanter's Torque",
		waist="Luminary Sash",
		left_ear="Hermetic Earring",
		right_ear="Digni. Earring",
		left_ring="Stikini Ring",
		right_ring="Weather. Ring",
		back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
	sets.midcast['Healing Magic'] = {
	    main={ name="Tamaxchi", augments={'Mag. Acc.+30','"Regen"+3',}},
		sub="Chanter's Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body="Shango Robe",
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +9',}},
		legs="Gyve Trousers",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Nodens Gorget",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
    sets.midcast['Enhancing Magic'] = {
	    main="Oranyan",
		sub="Enki Strap",
		ammo="Savant's Treatise",
		head={ name="Telchine Cap", augments={'Mag. Evasion+21','Enemy crit. hit rate -3','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +8',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Rumination Sash",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring",
		right_ring="Weather. Ring",
		back="Perimede Cape",
	}
	sets.midcast.RefreshRecieved = set_combine(sets.midcast['Enhancing Magic'], {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"})
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga"})
	sets.midcast.Cure = sets.midcast['Healing Magic']
	sets.midcast.CurePotencyRecieved = set_combine(sets.midcast.Cure, {waist="Siegel Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash",neck="Nodens Gorget"})
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {}
	sets.Idle.Main = {
	    main={ name="Lathi", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Niobid Strap",
		ammo="Sihirik",
		head="Befouled Crown",
		body="Jhakri Robe +1",
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +9',}},
		legs="Assid. Pants +1",
		feet="Herald's Gaiters",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		left_ear="Genmei Earring",
		right_ear="Hearty Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	sets.Idle.PDT = {
	    main="Terra's Staff",
		sub="Alber Strap",
		ammo="Sihirik",
		head={ name="Merlinic Hood", augments={'Attack+1','Magic dmg. taken -4%','Mag. Acc.+9',}},
		body={ name="Hagondes Coat +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -4%','Pet: Accuracy+21 Pet: Rng. Acc.+21',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','"Avatar perpetuation cost" -5',}},
		feet="Herald's Gaiters",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Genmei Earring",
		right_ear="Hearty Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	sets.Idle.Manawall = set_combine(sets.Idle.PDT,{feet="Wicce Sabots +1",back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}})
	
	sets.Idle.Death = sets.precast.FastCast
	sets.Idle.Current = sets.Idle.Main
end

function job_precast(spell)
	handle_equipping_gear(player.status)
	checkblocking(spell)
	if string.find(spell.name,'Stoneskin') then 
	  equip(sets.precast.Stoneskin) 
    elseif sets.precast.JA[spell.name] then
        equip(sets.precast.JA[spell.name])
    elseif string.find(spell.name,'Cur') and spell.name ~= 'Cursna' then
        equip(sets.precast.Cure)
    elseif spell.skill == 'EnhancingMagic' then
        equip(sets.precast.EnhancingMagic)
    elseif spell.action_type == 'Magic' then
        equip(sets.precast.FastCast)
    end
    if spell.type == 'WeaponSkill' and buffactive['Mana Wall'] then
	   equip(sets.Idle.Manawall)
	end
	
    if spell.name == 'Impact' then
        equip({head=empty,body="Twilight Cloak"})
    elseif spell.name == 'Stun' then
	    if not buffactive.thunderstorm then
            add_to_chat(8,'--------- Thunderstorm is down ---------')
        elseif not buffactive.klimaform then
            add_to_chat(8,'----------- Klimaform is down -----------')
        end    
    end
end


function job_post_midcast(spell)
    if spell.name == "Mana Wall" then 
	   equip(sets.Idle.Manawall)
	end
    if string.find(spell.english,'Cur') then 
        equip(sets.midcast.Cure)
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.CurePotencyRecieved)
		end
        weathercheck(spell.element)
    elseif spell.skill=="Elemental Magic" then
		if state.CastingMode.value == "MACC" then
	     equip(sets.midcast['Elemental Magic'].MACC)
		elseif state.CastingMode.value == "StoreTP" then
	     equip(sets.midcast['Elemental Magic'].StoreTP)
		elseif state.CastingMode.value == "MagicBurst" then
		 if player.equipment.main == 'Khatvanga' then
		   equip(sets.midcast['Elemental Magic'].MagicBurst,{feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}},})
		 else 
	       equip(sets.midcast['Elemental Magic'].MagicBurst)
		 end
		else 
         equip(sets.midcast['Elemental Magic'].Main)
		end
		if spell.english == 'Impact' then
		 equip(set_combine(sets.midcast['Elemental Magic'].StoreTP,{head=empty,body="Twilight Cloak"}))
         weathercheck(spell.element)
		end 
        if sets.ele[spell.element] then equip(sets.ele[spell.element]) end
          weathercheck(spell.element)
	elseif spell.english == 'Death' then
		if state.CastingMode.value == "MagicBurst" then
	      equip(sets.midcast['Dark Magic'].DeathMagicBurst)
		else
          equip(sets.midcast['Dark Magic'].Death)
		end
        weathercheck(spell.element)	
		if state.IdleMode.value ~= 'Death' then
		  add_to_chat(2,'----- You could have done more Damage if you changed your Idle Mode!!! ------')
		end
    elseif spell.english == 'Stoneskin' then
        equip(sets.midcast.Stoneskin)
	elseif spell.english == 'Refresh' then
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.RefreshRecieved)
		end	
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingMagic)
        if string.find(spell.english,'Regen') then
                equip(sets.midcast.Regen)
        end
    elseif spell.skill == 'Enfeebling Magic' then
	    equip(sets.midcast['Enfeebling Magic'])
		weathercheck(spell.element)
    else
        equip(sets.midcast[spell.skill])
        weathercheck(spell.element)
    end
    
    if spell.english == 'Sneak' and buffactive.sneak and spell.target.type == 'SELF' then
        send_command('@wait 1;cancel 71;')
    end
	
	if spell.name == 'Utsusemi: Ichi' then
	  send_command('cancel Copy Image|Copy Image (2)')
	end
	if spell.type == "WeaponSkill" then
	  tpspent = spell.tp_cost
	end
    
end        

function job_aftercast(spell)
    if state.SpellDebug.value == "On" then 
      spelldebug(spell)
	end
    if spell.interrupted then
	  add_to_chat(8,'--------- Casting Interupted: '..spell.english..'---------')
	end 
	handle_equipping_gear(player.status)
	equip(sets.Idle.Current)    
	if spell.name == "Mana Wall" then 
	   equip(sets.Idle.Manawall)
	end
    if spell.english == 'Sleep' or spell.english == 'Sleepga' then
        send_command('@wait 50;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
        send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    elseif spell.english == 'Break' or spell.english == 'Breakga' then
        send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    end
end

function status_change(new,tab)
    handle_equipping_gear(player.status)
    equip(sets.Idle.Current)
end


function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    

	if buffactive["Mana Wall"] then
		-- add_to_chat(8,'Mana wall is On')
	    sets.Idle.Current = sets.Idle.Manawall
		if state.SuperTank.value == "On" then
		 equip(sets.Idle.Current)
		 disable("main","sub","ranged","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
		else
		 enable("main","sub","ranged","ammo","head","neck","ear1","ear2","body","hands","ring1","ring2","back","waist","legs","feet")
		end
	else 
	  enable("ranged","ammo","head","neck","ear1","ear2","body","hands","waist","legs","feet")
	  disable_specialgear()
	  if state.TPMode.value == "WeaponLock" then
	   equip({main=weaponlock_main,sub=weaponlock_sub})
	   disable("main")
	   disable("sub")
	  else
	    enable("main")
	    enable("sub")
	  end	
	  if state.IdleMode.value == "PDT" then
   	   sets.Idle.Current = sets.Idle.PDT
	  elseif state.IdleMode.value == "Death" then
	   sets.Idle.Current = sets.Idle.Death
	  else
	   sets.Idle.Current = sets.Idle.Main
	  end
    end	
    
end



function job_self_command(command)

end


function select_default_macro_book()
    set_macro_page(3, 2)
end



--[[
	myrkr_ammo="Pemphredo Tathlum"
	myrkr_head="Vanya Hood"
	myrkr_neck="Voltsurge Torque"
	myrkr_ear1="Loquac. Earring"
	myrkr_ear2="Moonshade Earring"
	myrkr_body="Amalric Doublet"
	myrkr_hands="Telchine Gloves"
	myrkr_ring1="Mephitas's Ring +1"
	myrkr_ring2="Etana Ring"
	myrkr_back="Pahtli Cape"
	myrkr_waist="Fucho-no-Obi"
	myrkr_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	myrkr_feet="Skaoi Boots"


	
	
	-- Idle Sets
	
	idle_main="Lathi"
	idle_sub="Niobid Strap"
	idle_ranged=""
	idle_ammo="Sihirik"
	idle_head="Befouled Crown"
	idle_neck="Loricate Torque +1"
	idle_ear1="Genmei Earring"
	idle_ear2="Hearty Earring"
	idle_body="Jhakri Robe +1"
	idle_hands="Amalric Gages"
	idle_ring1="Dark Ring"
	idle_ring2="Defending Ring"
	idle_back="Solemnity Cape"
	idle_waist="Fucho-no-obi"
	idle_legs="Assiduity Pants +1"
	idle_feet="Herald's Gaiters"

	idle_pdt_main="Terra's Staff"  -- 20 pdt -- 
	idle_pdt_sub="Alber Strap" -- 2 pdt --
	idle_pdt_ranged=""
	idle_pdt_ammo="Sihirik"  -- 2 mdt --
	idle_pdt_head={ name="Merlinic Hood", augments={'Attack+1','Magic dmg. taken -4%','Mag. Acc.+9',}}   -- 4 mdt --
	idle_pdt_neck="Loricate Torque +1" -- 6dt --
	idle_pdt_ear1="Genmei Earring" -- 2 pdt -- 
	idle_pdt_ear2="Sorcerer's Earring"
	idle_pdt_body={ name="Hagondes Coat +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -4%','Pet: Accuracy+21 Pet: Rng. Acc.+21',}} -- 3pdt, 4mdt-- 
	idle_pdt_hands="Amalric Gages"
	idle_pdt_ring1="Dark Ring" -- 6pdt, 3mdt -- 
	idle_pdt_ring2="Defending Ring" -- 10dt --
	idle_pdt_back="Solemnity Cape" -- 4dt --
	idle_pdt_waist="Slipor Sash" -- 3mdt --
	idle_pdt_legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','"Avatar perpetuation cost" -5',}} -- 3pdt, 3mdt --
	idle_pdt_feet="Herald's Gaiters"
	-- total: 20 DT, 36 pdt, 23mdt

	manawall_feet="Wicce Sabots +1"
	manawall_back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	-- lose 4 DT from pdt set; so combined: 16+34pdt, 16+21mdt, 16bdt
	
	-- Precast Section
	FC_main={ name="Grioavolr", augments={'Magic burst mdg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}}
	FC_sub="Clerisy Strap +1"
	FC_ranged=""
	FC_ammo="Pemphredo Tathlum"
	FC_head="Vanya Hood"
	FC_neck="Voltsurge Torque"
	FC_ear1="Loquacious earring"
	FC_ear2="Enchntr. Earring +1"
	FC_body="Shango Robe"
	FC_hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+2','"Fast Cast"+6','"Mag.Atk.Bns."+1',}}
	FC_ring1="Prolix Ring"
	FC_ring2="Weather. Ring"
	FC_back="Perimede Cape"
	FC_waist="Witful Belt"
	FC_legs="Psycloth Lappas"
	FC_feet="Regal Pumps +1"
	
	FC_enh_waist="Siegel Sash"
	FC_stoneskin_legs="Doyen Pants"
	FC_stoneskin_head="Umuthi Hat"
	
	FC_cure_legs=FC_stoneskin_legs
	FC_cure_feet="Vanya Clogs"
	FC_Cure_back="Pahtli Cape"
	
	-- Midcast Section
	-- enh_main="Gada"
	-- enh_sub="Chanter's Shield"
	enh_main={ name="Grioavolr", augments={'Enh. Mag. eff. dur. +9','MP+74',}}
	enh_sub="Clerisy Strap +1"
	enh_ranged=""
	enh_ammo="Pemphredo Tathlum"
	enh_head="Befouled Crown"
	enh_neck="Incanter's Torque"
	enh_ear1=FC_ear1
	enh_ear2=FC_ear2
	enh_body="Telchine Chasuble"
	enh_hands="Amalric Gages"
	enh_ring1="Prolix Ring"
	enh_ring2="Weather. Ring"
	enh_back="Perimede Cape"
	enh_waist="Witful Belt"
	enh_legs="Psycloth Lappas"
	enh_feet="Telchine Pigaches"
	
	enh_stoneskin_waist="Siegel Sash"
	enh_stoneskin_neck="Nodens Gorget"
	enh_regen_main="Bolelabunga"
	
	cure_main="Tamaxchi"
	cure_sub="Chanter's Shield"
	cure_ranged=""
	cure_ammo="Pemphredo Tathlum"
	cure_head="Vanya Hood"
	cure_neck="Nodens Gorget"
	cure_ear1=FC_ear1
	cure_ear2=FC_ear2
	cure_body="Shango Robe"
	cure_hands="Telchine Gloves"
	cure_ring1="Dark Ring"
	cure_ring2="Defending Ring"
	cure_back="Solemnity Cape"
	cure_waist="Witful Belt"
	cure_legs="Gyve Trousers"
	cure_feet="Vanya Clogs"

	curepotrec_waist="Gishdubar Sash"	
	refreshpotrec_waist="Gishdubar Sash"	
	refreshpotrec_back="Grapevine Cape"	
	refreshpotrec_feet="Inspirited Boots"
	
	ele_main="Lathi"
	ele_sub="Niobid Strap"
	ele_ranged=""
	ele_ammo="Pemphredo Tathlum"
	ele_head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}}
	ele_neck="Sanctity Necklace"
	ele_ear1="Barkarole Earring"
	ele_ear2="Crematio Earring"
	ele_body={ name="Merlinic Jubbah", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +3','MND+5','Mag. Acc.+10','"Mag.Atk.Bns."+13',}}
	ele_hands="Amalric Gages"
	ele_ring1="Resonance Ring"
	ele_ring2="Weather. Ring"
	ele_back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	ele_waist="Refoccilation Stone"
	ele_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	ele_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}}
		
	ele_macc_main={ name="Grioavolr", augments={'Magic burst mdg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}}
	ele_macc_sub="Clerisy Strap +1"
	ele_macc_ear1="Hermetic Earring"
	ele_macc_neck="Incanter's Torque"
	ele_macc_hands="Psycloth Manillas"

	ele_storetp_legs="Perdition Slops"
	ele_storetp_waist="Oneiros Rope"
	ele_storetp_hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+8','INT+11','Mag. Acc.+9','"Mag.Atk.Bns."+6',}}
	ele_storetp_head="Helios Band"
	ele_storetp_ammo="Seraphic Ampulla"
	ele_storetp_feet="Helios Boots"
	ele_storetp_body="Seidr Cotehardie"
			
    ele_burst_main={ name="Grioavolr", augments={'Magic burst mdg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}}    -- 6 -- 
	ele_burst_hands="Amalric Gages" -- 5 over cap --
	ele_burst_neck="Mizu. Kubikazari" -- 10 --
	ele_burst_ring1="Locus Ring"  -- 5 -- 
	ele_burst_ring2="Mujin Band"  -- 5 -- over cap --
	ele_burst_ear2="Static Earring" -- 5 --
	ele_burst_body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+28','Magic burst mdg.+11%','VIT+8','Mag. Acc.+14',}} -- 11 --
	ele_burst_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	ele_burst_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst mdg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}}  -- 7 -- 
	-- 52 --   (if Khatvanga is locked on - swap burst legs and earring

	dark_main="Rubicundity"
	dark_sub="Culminus"
	dark_body="Shango Robe"
	dark_ear2="Dignitary's Earring"
	dark_ring1="Evanescence Ring"
	dark_ring2="Archon Ring"
	dark_waist="Fucho-no-obi"
	
	enf_main="Gada"
	enf_sub="Chanter's Shield"
	enf_ranged=""
	enf_ammo="Pemphredo Tathlum"
	enf_head="Befouled Crown"
	enf_neck="Incanter's Torque"
	enf_ear1="Hermetic Earring"
	enf_ear2="Barkarole Earring"
	enf_body="Shango Robe"
	enf_hands="Lurid Mitts"
	enf_ring1="Globidonta Ring"
	enf_ring2="Weather. Ring"
	enf_back={ name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}
	enf_waist="Luminary Sash"
	enf_legs="Psycloth Lappas"
	enf_feet="Skaoi Boots"

	-- Relevant Obis. Add the ones you have.
    sets.obi = {}
    sets.obi.Wind = {waist='Hachirin-no-obi'}
    sets.obi.Ice = {waist='Hachirin-no-obi'}
    sets.obi.Lightning = {waist='Hachirin-no-obi'}
    sets.obi.Light = {waist='Hachirin-no-obi'}
    sets.obi.Dark = {waist='Hachirin-no-obi'}
    sets.obi.Water = {waist='Hachirin-no-obi'}
    sets.obi.Earth = {waist='Hachirin-no-obi'}
    sets.obi.Fire = {waist='Hachirin-no-obi'}
    
	-- Generic gear for day/weather
	sets.weather = {back='Twilight Cape'}
    sets.day = {ring1='Zodiac Ring'}
    
	
]]