
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
    state.CastingMode:options('Normal', 'MACC', 'MagicBurst','StoreTP')
    state.IdleMode:options('Normal','PDT','MEVA')
	state.TPMode = M{['description']='TP Mode', 'Normal', 'WeaponLock'}
	state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
	send_command('alias tp gs c cycle tpmode')
	send_command('alias regenmode gs c cycle regenmode')
    send_command('bind f10 gs c cycle idlemode')
	send_command('bind f12 gs c update caster')
	select_default_macro_book()
	send_command('@wait 5;input /lockstyleset 20')
	
	-- Set Common Aliases --
	send_command("alias idle gs equip sets.Idle.Current")
	send_command("alias meva gs equip sets.meva")
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias ele gs equip sets.midcast['Elemental Magic']")
	send_command("alias macc gs equip sets.midcast['Elemental Magic'].MACC")
	send_command("alias storetp gs equip sets.midcast['Elemental Magic'].StoreTP")
	send_command("alias magicburst gs equip sets.midcast['Elemental Magic'].MagicBurst")
	send_command("alias enf gs equip sets.midcast['Enfeebling Magic']")
	send_command("alias dark gs equip sets.midcast['Dark Magic']")
	send_command("alias regen gs equip sets.midcast.Regen")
	send_command("alias cureset gs equip sets.midcast.Cure")
	send_command("alias impactset gs equip sets.midcast.Impact")
	send_command("alias stunset gs equip sets.midcast.Stun")
	send_command("alias myrkrset gs equip sets.precast.WS['Myrkr']")	
	send_command("alias eng gs equip sets.engaged")	
end

	
function init_gear_sets()
    -- Setting up Gear As Variables --
	
	-- Weapon Locks used for TP Mode.  When WeaponLock is set - it locks in the following Main and SUB. 
	-- weaponlock_main="Akademos"
	weaponlock_main="Khatvanga"
	--weaponlock_sub="Clerisy Strap +1"
	weaponlock_sub="Enki Strap"
	
	-- array for specific elemental magic - Ex: as sets.ele.Wind = {back="Back Armor with +wind"}
	sets.ele = {}

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
	
	sets.oncasuit = set_combine(sets.meva,{body="Onca Suit",ear1="Dominance Earring",back="Tantalic Cape",hands="",legs="",feet=""})
    
    sets.enh = {}
    sets.enh.Rapture = {head="Arbatel Bonnet +1"}
    sets.enh.Ebullience = {head="Arbatel Bonnet +1"}
	sets.enh.Klimaform = {feet="Arbatel Loafers +1"}
    sets.enh.Perpetuance = {hands="Arbatel Bracers +1"}

	
	
    ---  PRECAST SETS  ---
    sets.precast = {}
	
	
	sets.engaged = {
		ammo="Amar Cluster",
		head="Jhakri Coronal +1",
		body="Jhakri Robe +1",
		hands="Jhakri Cuffs +1",
		legs="Jhakri Slops +1",
		feet="Jhakri Pigaches +1",
		neck="Combatant's Torque",
		waist="Eschan Stone",
		left_ear="Cessance Earring",
		right_ear="Digni. Earring",
		left_ring="Etana Ring",
		right_ring="Hetairoi Ring",
		back="Argocham. Mantle",
	}
	
	sets.MaxHP = {
	    ammo="Homiliary",
		head="Befouled Crown",
		body={ name="Peda. Gown +1", augments={'Enhances "Enlightenment" effect',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -4%',}},
		legs="Perdition Slops",
		feet="Skaoi Boots",
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Cryptic Earring",
		right_ear="Odnowa Earring +1",
		left_ring="K'ayres Ring",
		right_ring="Etana Ring",
		back="Tantalic Cape",
	}
	
	sets.enh_protect = {ring1="Sheltered Ring"}
	
    sets.precast.JA = {}
    sets.precast.JA.Enlightenment = {body={ name="Peda. Gown +1", augments={'Enhances "Enlightenment" effect',}},}
    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants"}
	sets.precast.JA.Sublimation = sets.MaxHP
		
    sets.precast.FastCast = {
		main="Oranyan", -- FC 7
		sub="Clerisy Strap +1", -- FC 3
		ammo="Incantor Stone", -- FC 2
		head={ name="Merlinic Hood", augments={'"Fast Cast"+6',}}, -- FC 14
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+16','"Fast Cast"+6','INT+4',}}, -- FC 12
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -4%',}}, -- FC 7
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}}, -- FC 7
		feet="Regal Pumps +1", -- FC 4 (+3 if Unity rank #1)
		neck="Voltsurge Torque", -- FC 4
		waist="Witful Belt", -- FC 3 + QC 3
		left_ear="Loquac. Earring", -- FC 2
		right_ear="Enchntr. Earring +1", -- FC 2
		left_ring="Kishar Ring", -- FC 4 
		right_ring="Weather. Ring", -- FC 5, QC 3
		back="Perimede Cape", -- QC 4
	}  -- FC +70, QC +10
    sets.precast.EnhancingMagic = set_combine(sets.precast.FastCast,{waist="Siegel Sash"})
    sets.precast.Stoneskin = set_combine(sets.precast.EnhancingMagic,{head="Umuthi Hat",legs="Doyen Pants"})
	sets.precast.Cure = set_combine(sets.precast.FastCast,{
		back="Pahtli Cape",
		legs="Doyen Pants",
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}
	})
	
	sets.precast.Grimoire = {head="Pedagogy Mortarboard +1",feet="Acad. Loafers +2"}

	-- WS Sets
	sets.precast.WS = set_combine(sets.engaged,{neck="Fotia Gorget",waist="Fotia Belt"})
	
	-- Max MP set
    sets.precast.WS['Myrkr'] = {
	    ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +9',}},
		legs="Perdition Slops",
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +10',}},
		neck="Voltsurge Torque",
		waist="Luminary Sash",
		left_ear="Loquac. Earring",
		right_ear={ name="Moonshade Earring", augments={'MP+25','TP Bonus +25',}},
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Etana Ring",
		back="Pahtli Cape",	
	} 
	
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
	sets.midcast['Elemental Magic'] = {
		main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Drain" and "Aspir" potency +3','MND+5','Mag. Acc.+10','"Mag.Atk.Bns."+13',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+13','Mag. Acc.+10','"Mag.Atk.Bns."+4',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','INT+4','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}},
		neck="Sanctity Necklace",
		waist="Refoccilation Stone",
		left_ear="Regal Earring",
		right_ear="Barkaro. Earring",
		left_ring="Resonance Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	sets.midcast['Elemental Magic'].MACC = set_combine(sets.midcast['Elemental Magic'], {
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+13','Mag. Acc.+10','"Mag.Atk.Bns."+4',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}},
		neck="Incanter's Torque",
		left_ear="Hermetic Earring",
		right_ear="Barkaro. Earring",
	})
	
	sets.midcast['Elemental Magic'].StoreTP = {
	    main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},
		sub="Enki Strap",
		ammo="Seraphic Ampulla",
		head={ name="Helios Band", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Occult Acumen"+7','Mag. crit. hit dmg. +10%',}},
		body="Seidr Cotehardie",
		hands={ name="Merlinic Dastanas", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+8','INT+11','Mag. Acc.+9','"Mag.Atk.Bns."+6',}},
		legs="Perdition Slops",
		feet={ name="Helios Boots", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Occult Acumen"+7','Mag. crit. hit dmg. +9%',}},
		neck="Combatant's Torque",
		waist="Oneiros Rope",
		left_ear="Telos Earring",
		right_ear="Digni. Earring",
		left_ring="K'ayres Ring",
		right_ring="Rajas Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	
	sets.midcast['Elemental Magic'].MagicBurst = {
	    main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body={ name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+28','Magic burst dmg.+11%','VIT+8','Mag. Acc.+14',}},
		hands={ name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','CHR+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}},
		neck="Mizu. Kubikazari",
		waist="Refoccilation Stone",
		left_ear="Regal Earring",
		right_ear="Static Earring",
		left_ring="Locus Ring",
		right_ring="Mujin Band",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	sets.midcast.Impact = set_combine(sets.midcast['Elemental Magic'].StoreTP, {head=empty,body="Twilight Cloak",neck="Combatant's Torque"})
	
	sets.midcast.Helix = sets.midcast['Elemental Magic']
	sets.midcast.Helix.MACC = sets.midcast['Elemental Magic'].MACC
	sets.midcast.Helix.StoreTP = sets.midcast['Elemental Magic'].StoreTP
	sets.midcast.Helix.MagicBurst = sets.midcast['Elemental Magic'].MagicBurst
    sets.midcast['Dark Magic'] = {
	    main={ name="Rubicundity", augments={'Mag. Acc.+10','"Mag.Atk.Bns."+10','Dark magic skill +10','"Conserve MP"+7',}},
		sub="Ammurapi Shield",
		ammo="Pemphredo Tathlum",
		head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		body="Shango Robe",
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+13','Mag. Acc.+10','"Mag.Atk.Bns."+4',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','INT+4','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet={ name="Chironic Slippers", augments={'Mag. Acc.+29','"Drain" and "Aspir" potency +10','"Mag.Atk.Bns."+10',}},
		neck="Erra Pendant",
		waist="Fucho-no-Obi",
		left_ear="Regal Earring",
		right_ear="Barkaro. Earring",
		left_ring="Evanescence Ring",
		right_ring="Archon Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	sets.midcast.Stun = set_combine(sets.midcast['Dark Magic'], {
	    sub="Chanter's Shield",
		feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}},
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Barkaro. Earring",
	})    
    sets.midcast['Enfeebling Magic'] = {
	    main={ name="Gada", augments={'"Conserve MP"+3','INT+5','Mag. Acc.+24','"Mag.Atk.Bns."+25','DMG:+13',}},
		sub="Ammurapi Shield",
		ammo="Savant's Treatise",
		head="Befouled Crown",
		body="Shango Robe",
		hands="Lurid Mitts",
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','INT+4','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet="Skaoi Boots",
		neck="Incanter's Torque",
		waist="Rumination Sash",
		left_ear="Digni. Earring",
		right_ear="Barkaro. Earring",
		left_ring="Stikini Ring",
		right_ring="Kishar Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	sets.midcast['Enfeebling Magic'].MACC = {
	    main={ name="Gada", augments={'"Conserve MP"+3','INT+5','Mag. Acc.+24','"Mag.Atk.Bns."+25','DMG:+13',}},
		sub="Ammurapi Shield",
		ammo="Savant's Treatise",
		head={ name="Chironic Hat", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Cure" spellcasting time -3%','INT+1','Mag. Acc.+14',}},
		body={ name="Chironic Doublet", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+9','Mag. Acc.+6','"Mag.Atk.Bns."+14',}},
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+13','Mag. Acc.+10','"Mag.Atk.Bns."+4',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','INT+4','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet="Skaoi Boots",
		neck="Incanter's Torque",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Barkaro. Earring",
		left_ring="Etana Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
    sets.midcast['Healing Magic'] = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		--sub="Clerisy Strap +1",
		sub="Enki Strap",
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},  -- Cure Pot 10
		body={ name="Chironic Doublet", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+9','Mag. Acc.+6','"Mag.Atk.Bns."+14',}}, -- Cure Pot 13
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +9',}}, -- Cure Pot 10
		legs="Gyve Trousers", -- Cure Pot +10
		feet={ name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}},  -- Cure Pot 10
		neck="Incanter's Torque",
		waist="Witful Belt",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring",
		right_ring="Weather. Ring",
		back={ name="Bookworm's Cape", augments={'INT+1','MND+1','Helix eff. dur. +20','"Regen" potency+8',}},
	}
    sets.midcast['Enhancing Magic'] = {
	    --main="Oranyan",
		--sub="Clerisy Strap +1",
		--sub="Enki Strap",
		main={ name="Gada", augments={'"Conserve MP"+3','INT+5','Mag. Acc.+24','"Mag.Atk.Bns."+25','DMG:+13',}},
		sub="Ammurapi Shield",
		ammo="Staunch Tathlum",
		head={ name="Telchine Cap", augments={'Mag. Evasion+21','Enemy crit. hit rate -3','Enh. Mag. eff. dur. +10',}},
		body={ name="Telchine Chas.", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +8',}},
		hands={ name="Telchine Gloves", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +9',}},
		legs={ name="Telchine Braconi", augments={'Mag. Evasion+24','Enemy crit. hit rate -4','Enh. Mag. eff. dur. +9',}},
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Rumination Sash",
		left_ear="Halasz Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring",
		right_ring="Evanescence Ring",
		back="Perimede Cape",
	}
    sets.midcast.Embrava = sets.midcast['Enhancing Magic']
	
	-- regen defaults to Duration, Can swap to potency
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		main="Oranyan",
		head={ name="Telchine Cap", augments={'Mag. Evasion+21','Enemy crit. hit rate -3','Enh. Mag. eff. dur. +10',}},
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +10',}},
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10',}},
	})
	sets.midcast.RegenPotency = set_combine(sets.midcast['Enhancing Magic'], {
		main="Bolelabunga",
		sub="Chanter's Shield",
		head="Arbatel Bonnet +1",
		feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +10',}},
		back={ name="Bookworm's Cape", augments={'INT+1','MND+1','Helix eff. dur. +20','"Regen" potency+8',}},
	})
	sets.midcast.Cure = sets.midcast['Healing Magic']
	sets.midcast.CurePotencyRecieved = set_combine(sets.midcast.Cure, {waist="Gishdubar Sash"})
	sets.midcast.RefreshRecieved = set_combine(sets.midcast['Enhancing Magic'], {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash",neck="Nodens Gorget"})
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {}
	sets.Idle.Main = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Irenic Strap +1",
		ammo="Homiliary",
		head="Befouled Crown",
		body="Jhakri Robe +1",
		hands={ name="Chironic Gloves", augments={'"Blood Pact" ability delay -7','Accuracy+6','"Refresh"+1','Accuracy+15 Attack+15',}},
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
		ammo="Homiliary",
		head={ name="Merlinic Hood", augments={'Attack+1','Magic dmg. taken -4%','Mag. Acc.+9',}},
		body={ name="Gende. Bilaut +1", augments={'Phys. dmg. taken -4%','Magic dmg. taken -4%','"Cure" potency +4%',}},
		hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -4%',}},
		legs={ name="Hagondes Pants +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -3%','"Avatar perpetuation cost" -5',}},
		feet="Herald's Gaiters",
		neck="Loricate Torque +1",
		waist="Slipor Sash",
		left_ear="Genmei Earring",
		right_ear="Handler's Earring +1",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	sets.Idle.NoSubl = sets.Idle.Main
	sets.Idle.Subl = set_combine(sets.Idle.NoSubl, {
		head="Acad. Mortar. +2",
		body={ name="Peda. Gown +1", augments={'Enhances "Enlightenment" effect',}},
		right_ear="Savant's Earring",
	})
	sets.Idle.Current = sets.Idle.NoSubl
    sets.Resting = sets.Idle.Main
	
	sets.pixiehairpin = {head="Pixie Hairpin +1"}
end

function job_precast(spell)
	precast_start = os.clock()
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
	
	if spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then 
		equip(sets.precast.Grimoire) 
	end
	if spell.type == "BlackMagic" and (buffactive["Dark Arts"] or buffactive["Addendum: Black"]) then 
		equip(sets.precast.Grimoire) 
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
    if string.find(spell.english,'Cur') then 
        equip(sets.midcast.Cure)
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.CurePotencyRecieved)
		end
        weathercheck(spell.element)
        if buffactive.rapture then equip(sets.enh.Rapture) end
    elseif spell.skill=="Elemental Magic" or spell.name == "Kaustra" then
        if string.find(spell.english,'helix') or spell.name == 'Kaustra' then
            if state.CastingMode.value == "MACC" then
			  equip(sets.midcast.Helix.MACC)
			elseif state.CastingMode.value == "MagicBurst" then
			 if player.equipment.main == 'Khatvanga' then
			   equip(sets.midcast.Helix.MagicBurst,{feet={name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}}})
			 else 
	           equip(sets.midcast.Helix.MagicBurst)
			 end
			elseif state.CastingMode.value == "StoreTP" then
			  equip(sets.midcast.Helix.StoreTP)
			else 
	          equip(sets.midcast.Helix)
			end
			if sets.ele[spell.element] then equip(sets.ele[spell.element]) end
        else
		    if state.CastingMode.value == "MACC" then
	        equip(sets.midcast['Elemental Magic'].MACC)
			elseif state.CastingMode.value == "StoreTP" then
	        equip(sets.midcast['Elemental Magic'].StoreTP)
			elseif state.CastingMode.value == "MagicBurst" then
			 if player.equipment.main == 'Khatvanga' then
			   equip(sets.midcast['Elemental Magic'].MagicBurst,{feet={name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}}})
			 else 
	           equip(sets.midcast['Elemental Magic'].MagicBurst)
			 end
			else 
            equip(sets.midcast['Elemental Magic'])
			end
			if spell.english == 'Impact' then
			  equip(sets.midcast.Impact)
			  weathercheck(spell.element)
			end
            if sets.ele[spell.element] then equip(sets.ele[spell.element]) end
            weathercheck(spell.element)
        end
        if buffactive.ebullience then equip(sets.enh.Ebullience) end
        if buffactive.klimaform then equip(sets.enh.Klimaform) end
		if spell.element == "Dark" and spell.english ~= 'Impact' then equip(sets.pixiehairpin) end
    elseif spell.english == 'Impact' then
        equip(sets.midcast[spell.skill],{head=empty,body="Twilight Cloak"})
        weathercheck(spell.element)
    elseif spell.english == 'Stoneskin' then
        equip(sets.midcast.Stoneskin)
	elseif spell.english == 'Refresh' then
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.RefreshRecieved)
		end
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast['Enhancing Magic'])
		if string.find(spell.english,'Protect') or string.find(spell.english,'Shell') then 
			if spell.target.type == 'SELF' then
				equip(sets.enh_protect)
			end
		end
		if spell.english == 'Aquaveil' then
			equip({head={ name="Chironic Hat", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Cure" spellcasting time -3%','INT+1','Mag. Acc.+14',}},hands={ name="Chironic Gloves", augments={'"Blood Pact" ability delay -7','Accuracy+6','"Refresh"+1','Accuracy+15 Attack+15',}},})
		end
        if spell.english == 'Embrava' then
            equip(sets.midcast.Embrava)
            if not buffactive.perpetuance then
                add_to_chat(8,'--------- Perpetuance is down ---------')
            end
            if not buffactive.accession then
                add_to_chat(8,'--------- Accession is down ---------')
            end
            if not buffactive.penury then
                add_to_chat(8,'--------- Penury is down ---------')
            end
        else
            if string.find(spell.english,'Regen') then
				if state.RegenMode.value == "Duration" then 
					equip(sets.midcast.Regen)
				elseif state.RegenMode.value == "Potency" then
					equip(sets.midcast.RegenPotency)
				end
            end
            if buffactive.penury then equip(sets.enh.Penury) end
        end
		if string.find(spell.english, 'Raise') then
			equip(sets.precast.FastCast)
			if spell.type == "WhiteMagic" and (buffactive["Light Arts"] or buffactive["Addendum: White"]) then 
				equip(sets.precast.Grimoire) 
			end
		end
        if buffactive.perpetuance then equip(sets.enh.Perpetuance) end
    elseif spell.skill == 'Enfeebling Magic' then
	    if state.CastingMode.value == "MACC" then
		equip(sets.midcast['Enfeebling Magic'].MACC)
		else
        equip(sets.midcast['Enfeebling Magic'])
		end
		weathercheck(spell.element)
        if spell.type == 'WhiteMagic' and buffactive.altruism then equip(sets.enh.Altruism) end
        if spell.type == 'BlackMagic' and buffactive.focalization then equip(sets.enh.Focalization) end
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
	aftercast_start = os.clock()
	if state.SpellDebug.value == "On" then 
      spelldebug(spell)
	end
    if spell.interrupted then
	  add_to_chat(8,'--------- Casting Interupted: '..spell.name..'---------')
	end 
	if spell.english ~= 'Sublimation' then
	  handle_equipping_gear(player.status)
      equip(sets.Idle.Current)    
	end 
	if spell.english == 'Sublimation' and not buffactive["Sublimation: Activated"] and not buffactive["Sublimation: Complete"] then
	  sets.Idle.Current = sets.Idle.Subl
	  send_command('@wait 2;gs equip sets.Idle.Current')
      -- equip(sets.Idle.Current)
    elseif spell.english == 'Sublimation' and (buffactive["Sublimation: Activated"] or buffactive["Sublimation: Complete"]) then
	  sets.Idle.Current = sets.Idle.NoSubl
	  equip(sets.Idle.Current)
	end
    if spell.english == 'Sleep' or spell.english == 'Sleepga' then
        send_command('@wait 50;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
        send_command('@wait 80;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    elseif spell.english == 'Break' or spell.english == 'Breakga' then
        send_command('@wait 20;input /echo ------- '..spell.english..' is wearing off in 10 seconds -------')
    end
	check_run_status()
	if precast_start and state.SpellDebug.value == "On" then 
		add_to_chat(8,"Spell: "..spell.name..string.format(" Casting Time: %.2f", aftercast_start - precast_start))
	end
	precast_start = nil
end



function status_change(new,tab)
    handle_equipping_gear(player.status)
    if new == 'Resting' then
        equip(sets.Resting)
    else
        equip(sets.Idle.Current)
    end
end




function job_self_command(cmdParams, eventArgs)

end


function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
	disable_specialgear()
	if player.equipment.neck == "Arciela's Grace +1" then
        disable('neck')
    else
        enable('neck')
    end
	sets.Idle.Current = sets.Idle.NoSubl
	if buffactive["Sublimation: Activated"] then
        sets.Idle.Current = sets.Idle.Subl
    end
	if state.IdleMode.value == "PDT" then
	   sets.Idle.Current = sets.Idle.PDT
	elseif state.IdleMode.value == "OncaSuit" then
	   sets.Idle.Current = set_combine(sets.meva,{main=idle_pdt_main,body="Onca Suit",ear1="Dominance Earring",back="Tantalic Cape",hands="",legs="",feet=""})     
	elseif state.IdleMode.value == "MEVA" then
		sets.Idle.Current = sets.meva
	end
	
	if state.TPMode.value == "WeaponLock" then
	  equip({main=weaponlock_main,sub=weaponlock_sub})
	  disable("main")
	  disable("sub")
	else
	  enable("main")
	  enable("sub")
	end
	if playerStatus == 'Idle' then
        equip(sets.Idle.Current)
    end

end





function select_default_macro_book()
    set_macro_page(3, 2)
end


