
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
    state.CastingMode:options('Normal', 'MACC', 'MATT', 'MagicBurst','StoreTP')
    state.IdleMode:options('Normal','PDT','MEVA')
	state.TPMode = M{['description']='TP Mode', 'Normal', 'WeaponLock'}
	send_command('alias tp gs c cycle tpmode')
	send_command('bind f10 gs c cycle Idlemode')
	send_command('bind f12 gs c update CastingMode')
	select_default_macro_book()
	
		-- Set Common Aliases --
		
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias ele gs equip sets.midcast['Elemental Magic']")
	send_command("alias macc gs equip sets.midcast['Elemental Magic'].MACC")
	send_command("alias matt gs equip sets.midcast['Elemental Magic'].MATT")
	send_command("alias storetp gs equip sets.midcast['Elemental Magic'].StoreTP")
	send_command("alias magicburst gs equip sets.midcast['Elemental Magic'].MagicBurst")
	send_command("alias enf gs equip sets.midcast['Enfeebling Magic']")
	send_command("alias dark gs equip sets.midcast['Dark Magic']")
	send_command("alias regen gs equip sets.midcast.Regen")
	send_command("alias geo gs equip sets.midcast.Geomancy")
	send_command("alias indi gs equip sets.midcast.Geomancy.Indi")
	send_command("alias idle gs equip sets.Idle")
	send_command("alias idlepet gs equip sets.Idle.Pet")
	indi_timer = ''
    indi_duration = 290  -- Update for whatever you get on your Cape  /////    Base = 180 + 15 Relic Legs, +20 Empy Feet, +15 Solstice + 20 JSE Back + 40 Job Points
end

	
function init_gear_sets()

	-- Weapon Locks used for TP Mode.  When WeaponLock is set - it locks in the following Main and SUB. 
	weaponlock_main="Solstice"
	weaponlock_sub="Ammurapi Shield"

    -- Generic gear for day/weather
	sets.ele = {}
    sets.weather = {back='Twilight Cape'}
    sets.day = {ring1='Zodiac Ring'}
    
    -- Various pieces that enhance specific spells/etc **** Mainly for Midcast.
    sets.enh = {}



    ---  PRECAST SETS  ---
    sets.precast = {}
    sets.precast.JA = {}
	sets.precast.JA['Bolster'] = {body="Bagua Tunic +1"}
    sets.precast.JA['Life Cycle'] = {back="Nantosuelta's Cape",}
	sets.precast.FastCast = {
	    main="Bolelabunga",
		sub="Chanter's Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body="Shango Robe",
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+2','"Fast Cast"+6','"Mag.Atk.Bns."+1',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Regal Pumps +1",
		neck="Voltsurge Torque",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +12','Pet: Damage taken -1%',}},
	}
    sets.precast.EnhancingMagic = set_combine(sets.precast.Fastcast,{waist="Siegel Sash"})
    sets.precast.Stoneskin = set_combine(sets.precast.EnhancingMagic,{head="Umuthi Hat",legs="Doyen Pants"})
	sets.precast.Cure = set_combine(sets.precast.FastCast,{back="Pahtli Cape",legs="Doyen Pants",feet="Vanya Clogs"})
	
	-- WS Sets
	sets.precast.WS = {waist="Fotia Belt"}
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
		back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}},
	}
	
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    sets.midcast['Elemental Magic'] = {
	    main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+28','Magic burst dmg.+11%','VIT+8','Mag. Acc.+14',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}},
		neck="Sanctity Necklace",
		waist="Refoccilation Stone",
		left_ear="Crematio Earring",
		right_ear="Barkaro. Earring",
		left_ring="Resonance Ring",
		right_ring="Weather. Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +12','Pet: Damage taken -1%',}},
	}
	sets.midcast['Elemental Magic'].MACC = {
	    main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},
		sub="Clerisy Strap +1",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+28','Magic burst dmg.+11%','VIT+8','Mag. Acc.+14',}},
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+8','INT+11','Mag. Acc.+9','"Mag.Atk.Bns."+6',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}},
		neck="Incanter's Torque",
		waist="Refoccilation Stone",
		left_ear="Hermetic Earring",
		right_ear="Barkaro. Earring",
		left_ring="Resonance Ring",
		right_ring="Weather. Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +12','Pet: Damage taken -1%',}},
	}
	sets.midcast['Elemental Magic'].MATT = sets.midcast['Elemental Magic']
	sets.midcast['Elemental Magic'].StoreTP = {
	    main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},
		sub="Clerisy Strap +1",
		ammo="Seraphic Ampulla",
		head={ name="Helios Band", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Occult Acumen"+7','Mag. crit. hit dmg. +10%',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+28','Magic burst dmg.+11%','VIT+8','Mag. Acc.+14',}},
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+8','INT+11','Mag. Acc.+9','"Mag.Atk.Bns."+6',}},
		legs="Perdition Slops",
		feet={ name="Helios Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Occult Acumen"+7','Mag. crit. hit dmg. +9%',}},
		neck="Sanctity Necklace",
		waist="Oneiros Rope",
		left_ear="Crematio Earring",
		right_ear="Barkaro. Earring",
		left_ring="Resonance Ring",
		right_ring="Weather. Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +12','Pet: Damage taken -1%',}},
	}
	sets.midcast['Elemental Magic'].MagicBurst = {
	    main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+28','Magic burst dmg.+11%','VIT+8','Mag. Acc.+14',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}},
		neck="Mizu. Kubikazari",
		waist="Refoccilation Stone",
		left_ear="Crematio Earring",
		right_ear="Static Earring",
		left_ring="Locus Ring",
		right_ring="Mujin Band",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +12','Pet: Damage taken -1%',}},
	}
    sets.midcast['Dark Magic'] = set_combine(sets.midcast['Elemental Magic'], {ring1="Evanescence Ring",ring2="Archon Ring",body="Shango Robe"})
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})    
    sets.midcast['Enfeebling Magic'] = {
		main={ name="Gada", augments={'"Conserve MP"+3','INT+5','Mag. Acc.+24','"Mag.Atk.Bns."+25','DMG:+13',}},
		sub="Ammurapi Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Befouled Crown",
		body="Shango Robe",
		hands="Lurid Mitts",
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Skaoi Boots",
		neck="Incanter's Torque",
		waist="Luminary Sash",
		left_ear="Hermetic Earring",
		right_ear="Barkaro. Earring",
		left_ring="Stikini Ring",
		right_ring="Weather. Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +12','Pet: Damage taken -1%',}},
	}
	sets.midcast['Enfeebling Magic'].MACC = set_combine(sets.midcast['Enfeebling Magic'], {})
    sets.midcast['Healing Magic'] = {
	    main={ name="Tamaxchi", augments={'Mag. Acc.+30','"Regen"+3',}},
		sub="Ammurapi Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Psycloth Manillas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
		legs="Gyve Trousers",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Loricate Torque +1",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Pahtli Cape",
	}
    sets.midcast['Enhancing Magic'] = {
		main={ name="Gada", augments={'"Conserve MP"+3','INT+5','Mag. Acc.+24','"Mag.Atk.Bns."+25','DMG:+13',}},
		sub="Ammurapi Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Befouled Crown",
		body={ name="Telchine Chas.", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +8',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +9',}},
		feet="Regal Pumps +1",
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring",
		right_ring="Weather. Ring",
		back="Perimede Cape",
	}
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {main="Bolelabunga"})
	sets.midcast.Cure = {
	    main={ name="Tamaxchi", augments={'Mag. Acc.+30','"Regen"+3',}},
		sub="Ammurapi Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Psycloth Manillas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}},
		legs="Gyve Trousers",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},
		neck="Loricate Torque +1",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Pahtli Cape",
	}
	sets.midcast.CurePotencyRecieved = set_combine(sets.midcast.Cure, {waist="Gishdubar Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    sets.midcast.Geomancy = {
	    main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Culminus",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
		hands="Geo. Mitaines +1",
		legs={ name="Bagua Pants +1", augments={'Enhances "Mending Halation" effect',}},
		feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
		neck="Incanter's Torque",
		waist="Luminary Sash",
		left_ear="Hermetic Earring",
		right_ear="Barkaro. Earring",
		left_ring="Etana Ring",
		right_ring="Weather. Ring",
		back={ name="Lifestream Cape", augments={'Geomancy Skill +10','Indi. eff. dur. +12','Pet: Damage taken -1%',}},
	}
    sets.midcast.Geomancy.Indi = {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Culminus",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
		hands="Geo. Mitaines +1",
		legs={ name="Bagua Pants +1", augments={'Enhances "Mending Halation" effect',}},
		feet="Azimuth Gaiters +1",
		neck="Incanter's Torque",
		waist="Luminary Sash",
		left_ear="Hermetic Earring",
		right_ear="Barkaro. Earring",
		left_ring="Etana Ring",
		right_ring="Weather. Ring",
		back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}},
	}
    sets.Idle = {
	    main="Bolelabunga",
		sub="Genmei Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Befouled Crown",
		body="Jhakri Robe +1",
		hands={ name="Bagua Mitaines", augments={'Enhances "Curative Recantation" effect',}},
		legs="Assid. Pants +1",
		feet="Geo. Sandals +1",
		neck="Loricate Torque +1",
		waist="Fucho-no-Obi",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	sets.Idle.PDT = set_combine(sets.Idle, {main="Mafic Cudgel"})
	sets.Idle.Pet = {
	    main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
		sub="Genmei Shield",
		range={ name="Dunna", augments={'MP+20','Mag. Acc.+10','"Fast Cast"+3',}},
		head="Azimuth Hood +1",
		body="Jhakri Robe +1",
		hands="Geo. Mitaines +1",
		legs="Assid. Pants +1",
		feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
		neck="Loricate Torque +1",
		waist="Isa Belt",
		left_ear="Handler's Earring",
		right_ear="Handler's Earring +1",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}},
	}
	sets.Idle.Pet.PDT = set_combine(sets.Idle.Pet, {main="Mafic Cudgel"})
	sets.Idle.Current = sets.Idle
end

function job_precast(spell)
	handle_equipping_gear(player.status)
	checkblocking(spell)
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  equip(sets.Idle.Current)
	  return
	end
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
    if spell.name == 'Impact' then
        if not buffactive['Elemental Seal'] then
            add_to_chat(8,'--------- Elemental Seal is down ---------')
        end
        equip({head=empty,body="Twilight Cloak"})
    elseif spell.name == 'Stun' then
        if not buffactive.thunderstorm then
            add_to_chat(8,'--------- Thunderstorm is down ---------')
        elseif not buffactive.klimaform then
            add_to_chat(8,'----------- Klimaform is down -----------')
        end
        if stuntarg ~= 'Shantotto' then
            send_command('@input /t '..stuntarg..' ---- Stunned!!! ---- ')
        end
    end
end

function job_post_midcast(spell)
    if string.find(spell.english,'Cur') then 
        equip(sets.midcast.Cure)
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.CurePotencyRecieved)
		end
        weathercheck(spell.element)
        if buffactive.rapture then equip(sets.enh.Rapture) end
    elseif spell.skill=="Elemental Magic" or spell.name == "Kaustra" then
		if state.CastingMode.value == "MACC" then
	     equip(sets.midcast['Elemental Magic'].MACC)
		elseif state.CastingMode.value == "MATT" then
	     equip(sets.midcast['Elemental Magic'].MATT)
		elseif state.CastingMode.value == "StoreTP" then
	     equip(sets.midcast['Elemental Magic'].StoreTP)
		elseif state.CastingMode.value == "MagicBurst" then
	     equip(sets.midcast['Elemental Magic'].MagicBurst)
		else 
         equip(sets.midcast['Elemental Magic'])
		end
        if sets.ele[spell.element] then equip(sets.ele[spell.element]) end
          weathercheck(spell.element)
        if buffactive.ebullience then equip(sets.enh.Ebullience) end
        if buffactive.klimform then equip(sets.enh.Klimaform) end
	elseif spell.skill=='Geomancy' then
	   if string.find(spell.english,'Indi') then
	     equip(sets.midcast.Geomancy.Indi)
	   else
	     equip(sets.midcast.Geomancy)
	   end
	elseif spell.english == 'Death' then
		if state.CastingMode.value == "MagicBurst" then
	      equip(sets.midcast['Dark Magic'].Death.MagicBurst)
		else
          equip(sets.midcast['Dark Magic'].Death)
		end
        weathercheck(spell.element)		
    elseif spell.english == 'Impact' then
        equip(sets.midcast[spell.skill],{head=empty,body="Twilight Cloak"})
        weathercheck(spell.element)
    elseif spell.english == 'Stoneskin' then
        equip(sets.midcast.Stoneskin)
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingMagic)
        if string.find(spell.english,'Regen') then
                equip(sets.midcast.Regen)
        end
    elseif spell.skill == 'Enfeebling Magic' then
	    if state.CastingMode.value == "MACC" then
		equip(sets.midcast['Enfeebling Magic'].MACC)
		else
        equip(sets.midcast['Enfeebling Magic'])
		end
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
end    

function job_pet_change(pet,gain)
  if pet.isvalid then 
    if state.IdleMode.value == "PDT" then
	 sets.Idle.Current = sets.Idle.Pet.PDT
	elseif state.IdleMode.value == "MEVA" then
		sets.Idle.Current = sets.meva
	else
	 sets.Idle.Current = sets.Idle.Pet
    end
  else 
    send_command('input /echo ------- Your Loupan has been removed -------')
	if state.IdleMode.value == "PDT" then
	 sets.Idle.Current = sets.Idle.PDT
	elseif state.IdleMode.value == "MEVA" then
		sets.Idle.Current = sets.meva
	else
	 sets.Idle.Current = sets.Idle
    end
   end
   equip(sets.Idle.Current)
end

function job_aftercast(spell, action, spellMap, eventArgs)
	check_run_status()
	if state.SpellDebug.value == "On" then 
      spelldebug(spell)
	end
    
    if not spell.interrupted then
        if spell.english:startswith('Indi') then
            if not classes.CustomIdleGroups:contains('Indi') then
                classes.CustomIdleGroups:append('Indi')
            end
            send_command('@timers d "'..indi_timer..'"')
            indi_timer = spell.english
            send_command('@timers c "'..indi_timer..'" '..indi_duration..' down spells/00136.png')
        elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 60 down spells/00220.png')
        elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
            send_command('@timers c "'..spell.english..' ['..spell.target.name..']" 90 down spells/00220.png')
        end
    elseif not player.indi then
        classes.CustomIdleGroups:clear()
    end
	handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function status_change(new,tab)
    handle_equipping_gear(player.status)
    if new == 'Resting' then
        equip(sets.Resting)
    else
        equip(sets.Idle.Current)
    end
end


function job_buff_change(status,gain_or_loss)
    handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    
	disable_specialgear()	
    if state.IdleMode.value == "PDT" then
		if pet.isvalid then 
			sets.Idle.Current = sets.Idle.Pet.PDT
		else
			sets.Idle.Current = sets.Idle.PDT
		end
	elseif state.IdleMode.value == "MEVA" then
		sets.Idle.Current = sets.meva
	else
		if pet.isvalid then 
			sets.Idle.Current = sets.Idle.Pet
		else
			sets.Idle.Current = sets.Idle
		end
	end
	if state.TPMode.value == "WeaponLock" then
	  equip({main=weaponlock_main,sub=weaponlock_sub})
	  disable("main","sub","ranged","ammo")
	else
	  enable("main","sub","ranged","ammo")
	end	
end

function select_default_macro_book()
    set_macro_page(4, 2)
end


--[[
	-- Enhances JA 
	sublimation_head="Acad. Mortar. +1"
	sublimation_body="Pedagogy Gown +1"
    enlightenment_body="Pedagogy gown +1"	

	-- Idle Sets
	idle_main="Bolelabunga"
	idle_sub="Genmei Shield"
	idle_ranged="Dunna"
	idle_head="Befouled Crown"
	idle_neck="Loricate Torque +1"
	idle_ear1="Handler's Earring"
	idle_ear2="Handler's Earring +1"
	idle_body="Jhakri Robe +1"
	idle_hands="Bagua Mitaines"
	idle_ring1="Dark Ring"
	idle_ring2="Defending Ring"
	idle_back="Solemnity Cape"
	idle_waist="Fucho-no-obi"
	idle_legs="Assid. Pants +1"
	idle_feet="Geomancy Sandals +1"

	
	idle_pdt_main="Mafic Cudgel"
	
	idle_loupon_main="Solstice"
	idle_loupon_hands="Geomancy Mitaines +1"
	idle_loupon_head="Azimuth Hood +1"
	idle_loupon_waist="Isa Belt"
	idle_loupon_feet="Bagua Sandals"
	idle_loupon_back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}

	-- Precast Section
	FC_main="Solstice"
	FC_sub="Chanter's Shield"
	FC_ranged="Dunna"
	FC_head="Vanya Hood"
	FC_neck="Voltsurge Torque"
	FC_ear1="Loquacious earring"
	FC_ear2="Enchntr. Earring +1"
	FC_body="Shango Robe"
	FC_hands="Amalric Gages"
	FC_ring1="Kishar Ring"
	FC_ring2="Weather. Ring"
	FC_back="Lifestream Cape"
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
	enh_main="Gada"
	enh_sub="Chanter's Shield"
	enh_ranged="Dunna"
	enh_head="Befouled Crown"
	enh_neck="Incanter's Torque"
	enh_ear1=FC_ear1
	enh_ear2=FC_ear2
	enh_body="Telchine Chasuble"
	enh_hands="Amalric Gages"
	enh_ring1="Stikini Ring"
	enh_ring2="Weather. Ring"
	enh_back="Lifestream Cape"
	enh_waist="Witful Belt"
	enh_legs="Psycloth Lappas"
	enh_feet="Regal Pumps +1"
	
	enh_stoneskin_waist="Siegel Sash"
	enh_regen_main="Bolelabunga"
	
	cure_main="Tamaxchi"
	cure_sub="Chanter's Shield"
	cure_ranged="Dunna"
	cure_head="Vanya Hood"
	cure_neck="Loricate Torque +1"
	cure_ear1=FC_ear1
	cure_ear2=FC_ear2
	cure_body="Amalric Doublet"
	cure_hands="Telchine Gloves"
	cure_ring1="Dark Ring"
	cure_ring2="Defending Ring"
	cure_back="Lifestream Cape"
	cure_waist="Witful Belt"
	cure_legs="Gyve Trousers"
	cure_feet="Vanya Clogs"

	curepotrec_waist="Gishdubar Sash"	
	
	ele_main="Grioavolr"
	ele_sub="Zuuxowu Grip"
	ele_ammo="Pemphredo Tathlum"
	ele_head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}}
	ele_neck="Sanctity Necklace"
	ele_ear1="Crematio Earring"
	ele_ear2="Barkarole Earring"
	ele_body="Merlinic Jubbah"
	ele_hands="Amalric Gages"
	ele_ring1="Resonance Ring"
	ele_ring2="Weather. Ring"
	ele_back="Lifestream Cape"
	ele_waist="Refoccilation Stone"
	ele_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	ele_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}}
		
	ele_macc_main="Grioavolr"
	ele_macc_sub="Niobid Strap"
	ele_macc_ear1="Hermetic Earring"
	ele_macc_neck="Incanter's Torque"
	ele_macc_hands="Psycloth Manillas"

	ele_storetp_legs="Perdition Slops"
	ele_storetp_waist="Oneiros Rope"
	ele_storetp_hands="Merlinic Dastanas"
	ele_storetp_head="Helios Band"
	ele_storetp_ammo="Seraphic Ampulla"
	ele_storetp_feet="Helios Boots"
			
    ele_burst_main="Grioavolr"
	ele_burst_hands="Amalric Gages"
	ele_burst_neck="Mizu. Kubikazari"
	ele_burst_ring1="Locus Ring"
	ele_burst_ring2="Mujin Band"
	ele_burst_ear2="Static Earring"
	ele_burst_legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}}
	ele_burst_feet={ name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}}  -- 7 -- 
	
	dark_body="Shango Robe"
	dark_ring1="Evanescence Ring"
	dark_ring2="Archon Ring"
	
	enf_main="Gada"
	enf_sub="Chanter's Shield"
	enf_ranged="Dunna"
	enf_head="Befouled Crown"
	enf_neck="Incanter's Torque"
	enf_ear1="Hermetic Earring"
	enf_ear2="Barkarole Earring"
	enf_body="Shango Robe"
	enf_hands="Lurid Mitts"
	enf_ring1="Stikini Ring"
	enf_ring2="Weather. Ring"
	enf_back="Lifestream Cape"
	enf_waist="Luminary Sash"
	enf_legs="Psycloth Lappas"
	enf_feet="Skaoi Boots"
	
	
	-- Geomancy sets
	
	geo_main="Solstice"
	geo_sub="Culminus"
	geo_ranged="Dunna"
	geo_head="Azimuth Hood +1"
	geo_neck="Incanter's Torque"
	geo_ear1="Hermetic Earring"
	geo_ear2="Barkarole Earring"
	geo_body="Bagua Tunic +1"
	geo_hands="Geomancy Mitaines +1"
	geo_ring1="Etana Ring"
	geo_ring2="Weather. Ring"
	geo_back="Lifestream Cape"
	geo_indi_back={ name="Nantosuelta's Cape", augments={'Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}}
	geo_waist="Luminary Sash"
	geo_legs="Bagua Pants +1"
	geo_feet="Bagua Sandals"
	geo_indi_feet="Azimuth Gaiters +1"
			
    
]]