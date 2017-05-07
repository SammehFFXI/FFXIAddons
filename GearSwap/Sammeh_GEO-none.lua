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
    sets.precast.JA['Life Cycle'] = {back="Nantosuelta's Cape", body="Geomancy Tunic +1"}
	sets.precast.FastCast = {
	    main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Culminus",
    range="Dunna",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-4','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+9',}},
    body="Azimuth Coat +1",
    hands={ name="Bagua Mitaines +1", augments={'Enhances "Curative Recantation" effect',}},
    legs="Geo. Pants +1",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+9','"Subtle Blow"+9','"Fast Cast"+6','Accuracy+12 Attack+12','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    neck="Voltsurge Torque",
    waist="Witful Belt",
    left_ear="Loquac. Earring",
    right_ear="Handler's Earring +1",
    left_ring="Kishar Ring",
    right_ring="Prolix Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +20','Pet: Damage taken -5%',}},
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
	    main={ name="Grioavolr", augments={'"Conserve MP"+4','MP+86','Mag. Acc.+13','"Mag.Atk.Bns."+26','Magic Damage +3',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-4','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+9',}},
    body="Azimuth Coat +1",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'INT+13','Magic burst dmg.+6%','Accuracy+15 Attack+15','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+9','"Subtle Blow"+9','"Fast Cast"+6','Accuracy+12 Attack+12','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Porous Rope",
    left_ear="Hermetic Earring",
    right_ear="Hecate's Earring",
    left_ring="Shiva Ring",
    right_ring="Shiva Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +20','Pet: Damage taken -5%',}},
}
	sets.midcast['Elemental Magic'].MACC = {
	    main={ name="Grioavolr", augments={'"Conserve MP"+4','MP+86','Mag. Acc.+13','"Mag.Atk.Bns."+26','Magic Damage +3',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-4','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+9',}},
    body="Mallquis Saio +1",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'INT+13','Magic burst dmg.+6%','Accuracy+15 Attack+15','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+9','"Subtle Blow"+9','"Fast Cast"+6','Accuracy+12 Attack+12','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Porous Rope",
    left_ear="Hermetic Earring",
    right_ear="Hecate's Earring",
    left_ring="Stikini Ring",
    right_ring="Kishar Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +20','Pet: Damage taken -5%',}},
}
	sets.midcast['Elemental Magic'].MATT = sets.midcast['Elemental Magic']
	sets.midcast['Elemental Magic'].StoreTP = {
	    main={ name="Grioavolr", augments={'"Conserve MP"+4','MP+86','Mag. Acc.+13','"Mag.Atk.Bns."+26','Magic Damage +3',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-4','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+9',}},
    body="Azimuth Coat +1",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'INT+13','Magic burst dmg.+6%','Accuracy+15 Attack+15','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+9','"Subtle Blow"+9','"Fast Cast"+6','Accuracy+12 Attack+12','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Porous Rope",
    left_ear="Hermetic Earring",
    right_ear="Hecate's Earring",
    left_ring="Shiva Ring",
    right_ring="Shiva Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +20','Pet: Damage taken -5%',}},
}
	sets.midcast['Elemental Magic'].MagicBurst = {
	    main={ name="Grioavolr", augments={'"Conserve MP"+4','MP+86','Mag. Acc.+13','"Mag.Atk.Bns."+26','Magic Damage +3',}},
    sub="Enki Strap",
    ammo="Pemphredo Tathlum",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-4','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+9',}},
    body="Azimuth Coat +1",
    hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    legs={ name="Merlinic Shalwar", augments={'INT+13','Magic burst dmg.+6%','Accuracy+15 Attack+15','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+9','"Subtle Blow"+9','"Fast Cast"+6','Accuracy+12 Attack+12','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    neck="Sanctity Necklace",
    waist="Porous Rope",
    left_ear="Hermetic Earring",
    right_ear="Hecate's Earring",
    left_ring="Shiva Ring",
    right_ring="Shiva Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +20','Pet: Damage taken -5%',}},
}
    sets.midcast['Dark Magic'] = set_combine(sets.midcast['Elemental Magic'], {ring1="Evanescence Ring",ring2="Archon Ring",body="Shango Robe"})
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {})    
    sets.midcast['Enfeebling Magic'] = {
		main={ name="Gada", augments={'"Conserve MP"+3','INT+5','Mag. Acc.+24','"Mag.Atk.Bns."+25','DMG:+13',}},
		sub="Ammurapi Shield",
		range="Dunna",
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
		range="Dunna",
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
		range="Dunna",
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
	    main={ name="Serenity", augments={'MP+50','Enha.mag. skill +8','"Cure" potency +3%','"Cure" spellcasting time -9%',}},
    sub="Enki Strap",
    range="Dunna",
    head={ name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Enmity-4','MND+5','Mag. Acc.+15','"Mag.Atk.Bns."+9',}},
    body="Mallquis Saio +1",
    hands="Mallquis Cuffs +1",
    legs="Mallquis Trews +1",
    feet="Regal Pumps",
    neck="Arciela's Grace +1",
    waist="Witful Belt",
    left_ear="Loquac. Earring",
    right_ear="Hermetic Earring",
    left_ring="Stikini Ring",
    right_ring="Kishar Ring",
    back="Solemnity cape",
}
	sets.midcast.CurePotencyRecieved = set_combine(sets.midcast.Cure, {waist="Gishdubar Sash"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
    sets.midcast.Geomancy = {
	    main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Culminus",
    range="Dunna",
    head="Azimuth Hood +1",
    body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
    hands="Geo. Mitaines +1",
    legs={ name="Bagua Pants +1", augments={'Enhances "Mending Halation" effect',}},
    feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
    neck="Incanter's Torque",
    waist="Witful Belt",
    left_ear="Hermetic Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring",
    right_ring="Kishar Ring",
    back={ name="Lifestream Cape", augments={'Geomancy Skill +9','Indi. eff. dur. +20','Pet: Damage taken -5%',}},
}
    sets.midcast.Geomancy.Indi = {
		main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Culminus",
    range="Dunna",
    head="Azimuth Hood +1",
    body={ name="Bagua Tunic +1", augments={'Enhances "Bolster" effect',}},
    hands="Geo. Mitaines +1",
    legs={ name="Bagua Pants +1", augments={'Enhances "Mending Halation" effect',}},
    feet="Azimuth Gaiters +1",
    neck="Incanter's Torque",
    waist="Witful Belt",
    left_ear="Hermetic Earring",
    right_ear="Loquac. Earring",
    left_ring="Stikini Ring",
    right_ring="Kishar Ring",
    back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}},
}
    sets.Idle = {
	    main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genbu's Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Azimuth Coat +1",
    hands={ name="Bagua Mitaines +1", augments={'Enhances "Curative Recantation" effect',}},
    legs="Assid. Pants +1",
    feet="Geo. Sandals +1",
    neck="Incanter's Torque",
    waist="Fucho-no-Obi",
    left_ear="Handler's Earring",
    right_ear="Handler's Earring +1",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back="Solemnity Cape",
}
	sets.Idle.PDT = set_combine(sets.Idle, {main="Mafic Cudgel"})
	sets.Idle.Pet = {
	    main={ name="Solstice", augments={'Mag. Acc.+20','Pet: Damage taken -4%','"Fast Cast"+5',}},
    sub="Genbu's Shield",
    range="Dunna",
    head="Azimuth Hood +1",
    body="Azimuth Coat +1",
    hands="Geo. Mitaines +1",
    legs="Assid. Pants +1",
    feet={ name="Bagua Sandals", augments={'Enhances "Radial Arcana" effect',}},
    neck="Wiglen Gorget",
    waist="Channeler's Stone",
    left_ear="Handler's Earring",
    right_ear="Handler's Earring +1",
    left_ring="Kishar Ring",
    right_ring="Defending Ring",
    back={ name="Nantosuelta's Cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Pet: "Regen"+10',}},
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
    set_macro_page(2, 2)
end