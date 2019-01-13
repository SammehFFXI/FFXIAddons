
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
    state.CastingMode:options('Normal', 'MACC', 'MagicBurst','StoreTP')
    state.IdleMode:options('Normal','PDT','MEVA','MaxHP')
	state.TPMode = M{['description']='TP Mode', 'Normal', 'WeaponLock'}
	state.RegenMode = M{['description']='Regen Mode', 'Duration', 'Potency'}
	send_command('alias tp gs c cycle tpmode')
	send_command('alias regenmode gs c cycle regenmode')
    send_command('bind f10 gs c cycle idlemode')
	send_command('bind f12 gs c update caster')
	select_default_macro_book()
	send_command('@wait 5;input /lockstyleset 11')
	
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
	AutoNextTier = true
	SublimationStartTimer = nil
	AutoFire = false	
	waittime = 2.6

	packets = require('packets')
	
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
		ammo="Staunch Tathlum +1",
		head="Volte Cap",
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		hands="Volte Bracers",
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
	
	--sets.oncasuit = set_combine(sets.meva,{body="Onca Suit",ear1="Dominance Earring",back="Tantalic Cape",hands="",legs="",feet=""})
    
    sets.enh = {}
    sets.enh.Rapture = {head="Arbatel Bonnet +1"}
    sets.enh.Ebullience = {head="Arbatel Bonnet +1"}
	sets.enh.Klimaform = {feet="Arbatel Loafers +1"}
    sets.enh.Perpetuance = {hands="Savant's Bracers +2"}

	
	
    ---  PRECAST SETS  ---
    sets.precast = {}
	
	
	sets.engaged = {
		ammo="Amar Cluster",
		head="Jhakri Coronal +2",
		body="Jhakri Robe +2",
		hands="Jhakri Cuffs +2",
		legs="Jhakri Slops +2",
		feet="Jhakri Pigaches +2",
		neck="Combatant's Torque",
		waist="Eschan Stone",
		left_ear="Cessance Earring",
		right_ear="Digni. Earring",
		left_ring="Etana Ring",
		right_ring="Hetairoi Ring",
		back="Argocham. Mantle",
	}
	
	sets.MaxHP = {
	    main="Raetic Staff +1",
        sub="Irenic Strap +1",
        ammo="Homiliary",
        head="Acad. Mortar. +3",
        body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
        hands={ name="Gende. Gages +1", augments={'Phys. dmg. taken -3%','Song spellcasting time -4%',}},
        legs="Perdition Slops",
        feet="Skaoi Boots",
        neck="Bathy Choker +1",
        waist="Carrier's Sash",
        left_ear="Eabani Earring",
        right_ear="Odnowa Earring +1",
        left_ring="K'ayres Ring",
        right_ring="Etana Ring",
        back="Moonbeam Cape",
	}
	
	sets.enh_protect = {ring1="Sheltered Ring"}
	
    sets.precast.FastCast = {
		main="Hvergelmir", -- FC 50
		sub="Clerisy Strap +1", -- FC 3
		ammo="Incantor Stone", -- FC 2
		head="Welkin Crown",
        body="Shango Robe",
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
	
	sets.precast.Grimoire = {head="Peda. M.Board +3",feet="Acad. Loafers +3"}

	-- WS Sets
	sets.precast.WS = set_combine(sets.engaged,{neck="Fotia Gorget",waist="Fotia Belt"})
	
	-- Max MP set
    sets.precast.WS['Myrkr'] = {
		ammo="Incantor Stone",
		head={ name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}},
		body={ name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
		legs={ name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7',}},
		feet="Volte Boots",
		neck="Sanctity Necklace",
		waist="Luminary Sash",
		left_ear="Loquac. Earring",
		right_ear={ name="Moonshade Earring", augments={'MP+25','TP Bonus +250',}},
		left_ring="Mephitas's Ring +1",
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
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
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
	sets.midcast['Elemental Magic'].MACC = {
	    main={ name="Grioavolr", augments={'Magic burst dmg.+6%','INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+21','Magic Damage +5',}},
		sub="Enki Strap",
		ammo="Pemphredo Tathlum",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+13','Mag. Acc.+10','"Mag.Atk.Bns."+4',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','INT+4','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet="Acad. Loafers +3",
		neck="Incanter's Torque",
		waist="Refoccilation Stone",
		left_ear="Regal Earring",
		right_ear="Barkaro. Earring",
		left_ring="Stikini Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	
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
		--head={ name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','Mag. Acc.+11','"Mag.Atk.Bns."+14',}},
		head="Peda. M.Board +3",
		body={ name="Merlinic Jubbah", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+10%','"Mag.Atk.Bns."+7',}},
		hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','CHR+8','Mag. Acc.+12','"Mag.Atk.Bns."+15',}},
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
	
	sets.midcast.Helix = set_combine(sets.midcast['Elemental Magic'], {
		main="Raetic Staff +1",
	})
	sets.midcast.Helix.MACC = set_combine(sets.midcast['Elemental Magic'].MACC, {
		main="Raetic Staff +1",
	})
	sets.midcast.Helix.StoreTP = sets.midcast['Elemental Magic'].StoreTP
	sets.midcast.Helix.MagicBurst = set_combine(sets.midcast['Elemental Magic'].MagicBurst, {
		main="Raetic Staff +1",
	})
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
    --[[ sets.midcast['Enfeebling Magic'] = {
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
	]]

	sets.midcast['Enfeebling Magic'] = {
	    main={ name="Gada", augments={'"Conserve MP"+3','INT+5','Mag. Acc.+24','"Mag.Atk.Bns."+25','DMG:+13',}},
		sub="Ammurapi Shield",
		ammo="Savant's Treatise",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+13','Mag. Acc.+10','"Mag.Atk.Bns."+4',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','INT+4','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		--feet="Skaoi Boots",
		feet="Acad. Loafers +3",
		neck="Erra Pendant",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Etana Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
	
	sets.midcast['Enfeebling Magic'].MACC = {
	    main={ name="Gada", augments={'"Conserve MP"+3','INT+5','Mag. Acc.+24','"Mag.Atk.Bns."+25','DMG:+13',}},
		sub="Ammurapi Shield",
		ammo="Savant's Treatise",
		head="Acad. Mortar. +3",
		body="Acad. Gown +3",
		hands={ name="Chironic Gloves", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','MND+13','Mag. Acc.+10','"Mag.Atk.Bns."+4',}},
		legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','INT+4','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
		feet="Skaoi Boots",
		neck="Erra Pendant",
		waist="Luminary Sash",
		left_ear="Digni. Earring",
		right_ear="Regal Earring",
		left_ring="Etana Ring",
		right_ring="Weather. Ring",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}},
	}
    sets.midcast['Healing Magic'] = {
		--main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		main="Chatoyant Staff",
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
		back="Moonbeam Cape",
	}
    sets.midcast['Enhancing Magic'] = {
	    main="Oranyan",
        sub="Enki Strap",
        head={ name="Telchine Cap", augments={'Enh. Mag. eff. dur. +9',}},
        body={ name="Telchine Chas.", augments={'Enh. Mag. eff. dur. +8',}},
        hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
        legs={ name="Telchine Braconi", augments={'Enh. Mag. eff. dur. +10',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
        neck="Incanter's Torque",
        waist="Witful Belt",
        left_ear="Hermetic Earring",
        right_ear="Genmei Earring",
        left_ring="Stikini Ring",
        right_ring="Kishar Ring",
        back="Twilight Cape",
	}
	sets.midcast['Ninjutsu'] = sets.precast.FastCast
    sets.midcast.Embrava = sets.midcast['Enhancing Magic']
	
	-- regen defaults to Duration, Can swap to potency
    sets.midcast.Regen = set_combine(sets.midcast['Enhancing Magic'], {
		back={ name="Lugh's Cape", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10',}},
	})
	sets.midcast.RegenPotency = set_combine(sets.midcast['Enhancing Magic'], {
		main="Bolelabunga",
		head="Arbatel Bonnet +1",
		back={ name="Bookworm's Cape", augments={'INT+1','MND+1','Helix eff. dur. +20','"Regen" potency+8',}},
	})
	sets.midcast.Cure = sets.midcast['Healing Magic']
	sets.midcast.CurePotencyRecieved = set_combine(sets.midcast.Cure, {waist="Gishdubar Sash"})
	sets.midcast.RefreshRecieved = set_combine(sets.midcast['Enhancing Magic'], {back="Grapevine Cape",waist="Gishdubar Sash",feet="Inspirited Boots"})
    sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash",neck="Nodens Gorget",legs="Shedir Seraweels"})
    
    sets.Idle = {}
	sets.Idle.Main = {
		main={ name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}},
		sub="Irenic Strap +1",
		ammo="Homiliary",
        head="Befouled Crown",
        body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
        hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
        legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
        neck="Bathy Choker +1",
        waist="Gishdubar Sash",
        left_ear="Hermetic Earring",
        right_ear="Genmei Earring",
        left_ring="Vocane Ring",
        right_ring="Defending Ring",
        back="Solemnity Cape",
	}
	sets.Idle.PDT = {
		main="Terra's Staff",
		sub="Alber Strap",
		ammo="Homiliary",
		head="Befouled Crown",
        body={ name="Witching Robe", augments={'MP+50','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
        hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
        legs={ name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}},
        feet={ name="Telchine Pigaches", augments={'Enh. Mag. eff. dur. +10',}},
        neck="Bathy Choker +1",
        waist="Gishdubar Sash",
        left_ear="Hermetic Earring",
        right_ear="Genmei Earring",
        left_ring="Vocane Ring",
        right_ring="Defending Ring",
        back="Solemnity Cape",
	}
	sets.Idle.NoSubl = sets.Idle.Main
	sets.Idle.Subl = set_combine(sets.Idle.NoSubl, {
		head="Acad. Mortar. +3",
		body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		right_ear="Savant's Earring",
	})	
	
	sets.Idle.Current = sets.Idle.NoSubl
    sets.Resting = sets.Idle.Main
	
	sets.pixiehairpin = {head="Pixie Hairpin +1"}
	
	sets.precast.JA = {}
    sets.precast.JA.Enlightenment = {body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},}
    sets.precast.JA['Tabula Rasa'] = {legs="Pedagogy Pants"}
	--sets.precast.JA.Sublimation = sets.Idle.Subl
	
end

function job_pretarget(spell)
checkblocking(spell)
	if spell.action_type == 'Magic' then
		if aftercast_start and os.clock() - aftercast_start < waittime then
			windower.add_to_chat(8,"Precast too early! Adding Delay:"..waittime - (os.clock() - aftercast_start))
			cast_delay(waittime - (os.clock() - aftercast_start))
		end
	end
end

function job_precast(spell)
	precast_start = os.clock()
	if spell.english == 'Sublimation' and not buffactive["Sublimation: Activated"] and not buffactive["Sublimation: Complete"] then
	  equip(sets.precast.JA.Sublimation)
	  SublimationStartTimer = precast_start
    end
	handle_equipping_gear(player.status)
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
    if string.find(spell.english,'Cur') and spell.target.type ~= "MONSTER" then 
        equip(sets.midcast.Cure)
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.CurePotencyRecieved)
		end
        weathercheck(spell.element)
        if buffactive.rapture then equip(sets.enh.Rapture) end
	elseif string.find(spell.english,'Cur') and spell.target.type == "MONSTER" then 
		if state.CastingMode.value == "MACC" then
	        equip(sets.midcast['Elemental Magic'].MACC)
			elseif state.CastingMode.value == "StoreTP" then
	        equip(sets.midcast['Elemental Magic'].StoreTP)
			elseif state.CastingMode.value == "MagicBurst" then
			 if player.equipment.main == 'Khatvanga' or player.equipment.main == "Raetic Staff +1" then
			   equip(sets.midcast['Elemental Magic'].MagicBurst,{
			   legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','AGI+9','"Mag.Atk.Bns."+12',}},
			   -- feet={name="Merlinic Crackows", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+7%','Mag. Acc.+13','"Mag.Atk.Bns."+3',}}
			   })
			 else 
	           equip(sets.midcast['Elemental Magic'].MagicBurst)
			 end
			else 
            equip(sets.midcast['Elemental Magic'])
		end
		equip{ring1="Mujin Band"}
		equip{ring2="Weatherspoon Ring"}
		weathercheck(spell.element)
    elseif spell.skill=="Elemental Magic" or spell.name == "Kaustra" then
        if string.find(spell.english,'helix') or spell.name == 'Kaustra' then
            if state.CastingMode.value == "MACC" then
			  equip(sets.midcast.Helix.MACC)
			elseif state.CastingMode.value == "MagicBurst" then
			 if player.equipment.main == 'Khatvanga' or player.equipment.main == 'Raetic Staff +1' then
			   equip(sets.midcast.Helix.MagicBurst,{
			   legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','AGI+9','"Mag.Atk.Bns."+12',}},
			   })
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
			 if player.equipment.main == 'Khatvanga' or player.equipment.main == 'Raetic Staff +1' then
			   equip(sets.midcast['Elemental Magic'].MagicBurst,{
			   legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+8%','AGI+9','"Mag.Atk.Bns."+12',}},
			   })
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
        --if buffactive.ebullience then equip(sets.enh.Ebullience) end  (Doesn't seem to beat out relic head +3)
        if buffactive.klimaform and spell.element == world.weather_element then 
		  equip(sets.enh.Klimaform) 
		end
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
			equip({head={ name="Chironic Hat", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Cure" spellcasting time -3%','INT+1','Mag. Acc.+14',}},hands={ name="Chironic Gloves", augments={'"Blood Pact" ability delay -7','Accuracy+6','"Refresh"+1','Accuracy+15 Attack+15',}},legs="Shedir Seraweels"})
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
	  if (AutoCast == true) then
		add_to_chat(8,'AutoCast Interruption - canceling series').
		AutoCast = false
	  end
	end 
	if spell.english ~= 'Sublimation' then
	  handle_equipping_gear(player.status)
      equip(sets.Idle.Current)    
	end 
	if spell.english == 'Sublimation' and not buffactive["Sublimation: Activated"] and not buffactive["Sublimation: Complete"] then
	  sets.Idle.Current = sets.Idle.Subl
	  send_command('@wait 2;gs equip sets.Idle.Current')
      equip(sets.Idle.Current)
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
	--precast_start = nil
	if spell.action_type ~= 'Magic' then
	 aftercast_start = nil
	end
	
	if (AutoCast == true) then
	  if AutoCastSet[AutoCastIteration] then
	    windower.add_to_chat(8,"AutoCast: "..AutoCastSet[AutoCastIteration])
	    send_command('wait '..waittime..'; input /ma "'..AutoCastSet[AutoCastIteration]..'" <t>')
	  else 
	    AutoCast = false
	  end
	  AutoCastIteration = AutoCastIteration + 1
    end
end

function job_post_aftercast(spell)

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
	if cmdParams[1]:lower() == 'test' then
        print(player.status)
        eventArgs.handled = true
    end
	if cmdParams[1]:lower() == 'UpdateIdle' then
		job_handle_equipping_gear(player.status)
		equip(sets.Idle.Current)
	end
	if cmdParams[1]:lower() == 'autocast' then
		AutoCast = true
		AutoCastIteration = 2
		AutoCastSet = cmdParams
		AutoCastSet[1] = nil -- Removing cmdParams
		send_command('input /ma '..AutoCastSet[AutoCastIteration]..' <t>')
	end
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
		if SublimationStartTimer and CurrentTime - SublimationStartTimer > 85 then
		   sets.Idle.Current = sets.MaxHP
		end
    end
	if buffactive["Sublimation: Complete"] then
		SublimationStartTimer = nil
	end
	if state.IdleMode.value == "PDT" then
	   sets.Idle.Current = sets.Idle.PDT
	--[[elseif state.IdleMode.value == "OncaSuit" then
	   sets.Idle.Current = set_combine(sets.meva,{main=idle_pdt_main,body="Onca Suit",ear1="Dominance Earring",back="Tantalic Cape",hands="",legs="",feet=""})     
       ]]
	elseif state.IdleMode.value == "MEVA" then
		sets.Idle.Current = sets.meva
	elseif state.IdleMode.value == "MaxHP" then
		sets.Idle.Current = sets.MaxHP
	end
	
	if state.TPMode.value == "WeaponLock" then
	  equip({main=weaponlock_main,sub=weaponlock_sub})
	  disable("main")
	  disable("sub")
	else
	  enable("main")
	  enable("sub")
	end
end





function select_default_macro_book()
    set_macro_page(4, 1)
end


windower.raw_register_event('time change',function()
   CurrentTime = os.clock()
   if precast_start == nil then 
      precast_start = CurrentTime
   end
   if SublimationStartTimer and CurrentTime - SublimationStartTimer > 80 then 
	  job_handle_equipping_gear(player.status)
	  send_command("gs equip sets.Idle.Current")
   end
   if buffactive["Sublimation: Complete"] then
		SublimationStartTimer = nil
   end
   CurrentInfo = windower.ffxi.get_info()
   if not buffactive["Sublimation: Complete"] and not buffactive["Sublimation: Activated"] and windower.ffxi.get_ability_recasts()[234] == 0 
      and not CurrentInfo.mog_house and not buffactive['weakness'] and not buffactive['Refresh'] and player.hpp > 75 then
	  if (areas.Cities:contains(world.zone) or (CurrentTime - precast_start) > 1800) and not buffactive['Regen'] then   -- Basically if AFK for > 30 min or in a City, use Regen V after casting. 
		send_command("input /ja sublimation; wait 1; input /ma Regen V <me>")
	  else 
	    send_command("input /ja sublimation")
	  end
   end
end)	



--[[
windower.raw_register_event('incoming chunk',function(id,data)
	if id == 0x028 then
		local packet = packets.parse('incoming', data)
		print(packet.Recast,packet._unknown1,packet.Param)
	end
end)

windower.raw_register_event('action',function (act)
	-- Should mirror AfterCast - but get a few more variables..... I think?
	-- info here: http://dev.windower.net/doku.php?id=lua:api:events:action
	local actor = windower.ffxi.get_mob_by_id(act.actor_id)		
	local self = windower.ffxi.get_player()
	local target_count = act.target_count 
	local category = act.category  
	local param = act.param
	local recast = act.recast  
	local targets = act.targets
	local primarytarget = windower.ffxi.get_mob_by_id(targets[1].id)
	local valid_target = act.valid_target
	if actor and actor.name == self.name and category == 4 then
		if res.spells[param] then
			--print('Completed Casting',actor.name,res.spells[param].en)
			windower.add_to_chat(8,'Completed Casting: '..res.spells[param].en..' Recast Time: '..recast)
			if (recast == 1) then 
				windower.add_to_chat(8,'You got an insta-cast')
			end
		end
	end
end)


]]

