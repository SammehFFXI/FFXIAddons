-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
	-- Load and initialize the include file.
	include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
	state.Buff.Migawari = buffactive.migawari or false
	state.Buff.Doomed = buffactive.doomed or false
	state.Buff.Sange = buffactive.Sange or false
	state.Buff.Yonin = buffactive.Yonin or false
	state.Buff.Innin = buffactive.Innin or false
	state.Buff.Futae = buffactive.Futae or false
	
	gear.MovementFeet = {name="Danzo Sune-ate"}
	gear.DayFeet = "Danzo Sune-ate"
	gear.NightFeet = "Hachiya Kyahan"
	gear.AccAmmo = {name="Togakushi Shuriken"}
	gear.AccAmmoDay = "Togakushi Shuriken"
	gear.AccAmmoNight = "Togakushi Shuriken"
    gear.ElementalObi = {name="Hachirin-no-Obi"}
	gear.default.obi_waist = "Eschan Stone"
	
	send_command("alias fc gs equip sets.precast.FC")
	send_command("alias idle gs equip sets.idle")
	send_command("alias nindebuff gs equip sets.midcast.NinjutsuDebuff")
	send_command("alias ele gs equip sets.midcast.ElementalNinjutsu")
	send_command("alias utsus gs equip sets.midcast.Utsusemi")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias wsset gs equip sets.precast.WS")
	send_command("alias ten gs equip sets.precast.WS['Blade: Ten']")
	send_command("alias meva gs equip sets.meva")
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	windower.register_event('time change', time_change)	
	-- Options: Override default values
	state.OffenseMode:options ('Normal', 'Acc', 'Acc2', 'Acc3')
	state.WeaponskillMode:options('Normal', 'Acc', 'Mod')
	state.CastingMode:options('Normal', 'Resistant')
	state.IdleMode:options('Normal')
	
	select_movement_feet()
	select_default_macro_book()
	send_command('@wait 1;input /lockstyleset 25')


end


-- Define sets and vars used by this job file.
function init_gear_sets()
	
	--------------------------------------
	-- Precast sets
	--------------------------------------
	sets.Enmity = {
	hands="Macabre Gauntlets",
    body="Emet Harness",
    feet="Ahosi Leggings",
    neck="Unmoving Collar +1",
    waist="Flume Belt +1",
    left_ear="Cryptic Earring",
    right_ear="Trux Earring",
    left_ring="Supershear Ring",
    right_ring="Petrov Ring",
    back="Agema Cape",
	}
	-- Precast sets to enhance JAs
	-- sets.precast.JA['Mijin Gakure'] = {legs="Mochizuki Hakama +1"}
	--sets.precast.JA['Futae'] = {legs="Iga Tekko +2"}
	sets.precast.JA = {}
	sets.precast.JA['Sange'] = {ammo=gear.AccAmmo,legs="Mochizuki Chainmail +1"}
	sets.precast.JA['Provoke'] = sets.Enmity
	sets.precast.JA['Warcry'] = sets.Enmity
	
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		-- Uk'uxkaj Cap, Daihanshi Habaki
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	-- Set for acc on steps, since Yonin drops acc a fair bit
	sets.precast.Step = {}

	sets.precast.Flourish1 = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {
	head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",
	body="Taeon Tabard",hands="Leyline Gloves",ring1="Kishar Ring",ring2="Weatherspoon Ring",feet={ name="Herculean Boots", augments={'Accuracy+28','"Fast Cast"+2','Accuracy+20 Attack+20',}}}
	
	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {back="Andartia's Mantle",body="Mochizuki Chainmail +1",feet="Hattori Kyahan"})

	-- Snapshot for ranged
	sets.precast.RA = {}
	
      
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
      ammo="Seething Bomblet +1",
      head={ name="Herculean Helm", augments={'Accuracy+27','Weapon skill damage +3%','STR+10',}},
      body={ name="Herculean Vest", augments={'Accuracy+22 Attack+22','Weapon skill damage +3%','STR+12','Accuracy+10','Attack+12',}},
      hands={ name="Herculean Gloves", augments={'Accuracy+7 Attack+7','Weapon skill damage +3%','STR+10','Accuracy+9','Attack+8',}},
      legs="Hiza. Hizayoroi +2",
      feet={ name="Herculean Boots", augments={'Accuracy+28','"Fast Cast"+2','Accuracy+20 Attack+20',}},
      neck="Fotia Gorget",
      waist="Fotia Belt",
      left_ear="Cessance Earring",
      right_ear="Moonshade Earring",
      left_ring="Ilabrat Ring",
      right_ring="Regal Ring",
      back={ name="Andartia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
		
	sets.cursnarec={waist="Gishdubar Sash",ring1="Purity Ring",}
	
	-- sets.precast.WS.Acc = set_combine(sets.precast.WS, {ammo="Honed Tathlum",hands="Ryuo Tekko",back="Yokaze Mantle"})

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Blade: Hi'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Blade: Ten'] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",
		waist="Grunfeld Rope",
		legs="Hiza. Hizayoroi +2",
		feet={ name="Herculean Boots", augments={'Attack+18','Weapon skill damage +4%','STR+7','Accuracy+14',}},
		left_ear="Ishvara Earring",
	})
	--sets.precast.WS['Blade: Ku'] = set_combine(sets.precast.WS, {ammo="Jukukik Feather"})
	--sets.precast.WS['Blade: Jin'] = set_combine(sets.precast.WS, {ammo="Jukukik Feather"})
	sets.precast.WS['Blade: Kamu'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Blade: Shun'] = set_combine(sets.precast.WS, {})
	--sets.precast.WS['Blade: Yu'] = {}
	--sets.precast.WS['Aeolian Edge'] = {}

	--------------------------------------
	-- Midcast sets
	--------------------------------------

	sets.midcast.FastRecast = {
	  head="Herculean Helm",
      body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
      hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}},
      legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
      feet={ name="Herculean Boots", augments={'Accuracy+28','"Fast Cast"+2','Accuracy+20 Attack+20',}},
      neck="Voltsurge Torque",
      waist="Grunfeld Rope",
      left_ear="Enchntr. Earring +1",
      right_ear="Loquac. Earring",
      left_ring="Kishar Ring",
      right_ring="Weatherspoon Ring",
      back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}},
	}
		
	sets.midcast.Utsusemi = set_combine(sets.midcast.SelfNinjutsu, {feet="Hattori Kyahan",back="Andartia's Mantle"})

	sets.midcast.ElementalNinjutsu = {
    ammo="Pemphredo Tathlum",  -- 8macc
    head={ name="Herculean Helm", augments={'Magic burst dmg.+7%','Mag. Acc.+11','"Mag.Atk.Bns."+9',}}, --mb7  --11 macc
    body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}}, --mb8 (2)  -- 28 macc
    hands={ name="Herculean Gloves", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+5%','INT+5','Mag. Acc.+15',}}, --mb5 --35 macc
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+23','Magic burst dmg.+6%','MND+3','"Mag.Atk.Bns."+15',}}, --mb6  --23 macc
    feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+1','MND+10','Mag. Acc.+6','"Mag.Atk.Bns."+11',}}, -- 36macc
    neck="Sanctity Necklace", -- 10macc
    waist="Eschan Stone", --15macc 
    left_ear="Digni. Earring",  --10macc
    right_ear="Static Earring",  -- 5mb
    left_ring="Mujin Band", -- 5mb
    right_ring="Locus Ring", -- 5 mb(2)
    back={ name="Andartia's Mantle", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','"Mag.Atk.Bns."+10',}}, --30macc
	}
	-- total:  28(1)  13(2) +13(2 - ochu) = 54  (+13(2) if 2x ochu) == 67 
	-- +206 macc
	
	
	sets.midcast.ElementalNinjutsuSan = sets.midcast.ElementalNinjutsu
	
	sets.midcast.ElementalNinjutsu.Burst = sets.midcast.ElementalNinjutsu

	sets.midcast.ElementalNinjutsu.Resistant = sets.midcast.ElementalNinjutsu

	sets.midcast.NinjutsuDebuff = sets.midcast.ElementalNinjutsu

	--sets.midcast.NinjutsuBuff = {}

	sets.midcast.RA = {}

	--------------------------------------
	-- Idle/resting/defense/etc sets
	--------------------------------------
	
	-- Resting sets
	sets.resting = {}
	
	-- Idle sets
	sets.idle = set_combine(sets.engaged, {head={ name="Herculean Helm", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Damage taken-3%','Mag. Acc.+8',}},body="Hiza. Haramaki +2",neck="Loricate Torque +1",ring1="Dark Ring",ring2="Defending Ring",waist="Flume Belt +1",back="Solemnity Cape",feet=gear.MovementFeet,ear1="Odnowa Earring +1",ear2="Genmei Earring",ammo=gear.AccAmmo})
	sets.Idle = {}
	sets.Idle.Current = sets.idle
	
	sets.dt = {
	    head={ name="Herculean Helm", augments={'Mag. Acc.+15 "Mag.Atk.Bns."+15','Damage taken-3%','Mag. Acc.+8',}},
		body="Ashera Harness",
		hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet="Ahosi Leggings",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Genmei Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}

	sets.idle.Town = sets.idle
	
	sets.idle.Weak = sets.idle
	
	-- Defense sets
	sets.defense.Evasion = {}


	sets.defense.PDT = {}

	sets.defense.MDT = {}

	sets.meva = {
	    ammo="Staunch Tathlum",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body="Hiza. Haramaki +2",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Gyve Trousers",
		feet="Ahosi Leggings",
		neck="Warder's Charm +1",
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear="Flashward Earring",
		left_ring="Purity Ring",
		right_ring="Vengeful Ring",
		back="Solemnity Cape",
	}

	sets.Kiting = {feet=gear.MovementFeet}
	
	sets.precast.Flash = sets.Enmity
	--------------------------------------
	-- Engaged sets
	--------------------------------------


	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group
	-- Acc 972 (Kikoku/Ochu) :: Acc 999 (Ochu/Shigi) :: Acc 1006 (Ochu/Ochu) :: Acc ??? (Kanaria/Ochu)
	sets.engaged = {
      ammo=gear.AccAmmo,
	head="Ryuo Somen",
    --body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
	body="Ken. Samue +1",
    hands={ name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}},
    legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+1 "Mag.Atk.Bns."+1','STR+11','Quadruple Attack +2','Accuracy+18 Attack+18',}},
    neck="Moonlight Nodowa",
    waist="Reiki Yotai",
    left_ear="Telos Earring",
    right_ear="Suppanomimi",
    left_ring="Epona's Ring",
    right_ring="Hetairoi Ring",
    back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
	--[[
	sets.engaged = {
		ammo=gear.AccAmmo,
	    head="Ken. Jinpachi",
		body="Ken. Samue +1",
		hands="Ken. Tekko",
		legs="Ken. Hakama",
		feet="Ken. Sune-Ate",
		neck="Moonlight Nodowa",
		waist="Reiki Yotai",
		left_ear="Telos Earring",
		right_ear="Suppanomimi",
		left_ring="Epona's Ring",
		right_ring="Hetairoi Ring",
		back={ name="Andartia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}},
	}
		]]
	-- Acc 1043 (Kikoku/Ochu) :: Acc 1070 (Ochu/Shigi) :: Acc 1077 (Ochu/Ochu)
	sets.engaged.Acc = set_combine(sets.engaged, {feet={ name="Herculean Boots", augments={'Accuracy+28','"Fast Cast"+2','Accuracy+20 Attack+20',}},})
	
	-- Acc 1072 (Kikoku/Ochu) :: Acc 1099 (Ochu/Shigi) :: Acc 1107 (Ochu/Ochu)
	sets.engaged.Acc2 = sets.engaged.Acc
	
	-- Acc 1139 (Kikoku/Ochu) :: Acc 1168 (Ochu/Shigi) :: Acc 1175 (Ochu/Ochu)
	sets.engaged.Acc3 = sets.engaged.Acc


	-- Custom melee group: High Haste (~20% DW)
	sets.engaged.HighHaste = sets.engaged
	sets.engaged.Acc.HighHaste = sets.engaged.Acc
	sets.engaged.Acc2.HighHaste = sets.engaged.Acc
	sets.engaged.Acc3.HighHaste = sets.engaged.Acc

	-- Custom melee group: Embrava Haste (7% DW)
	sets.engaged.EmbravaHaste = sets.engaged
	sets.engaged.Acc.EmbravaHaste = sets.engaged.Acc
	sets.engaged.Acc2.EmbravaHaste = sets.engaged.Acc
	sets.engaged.Acc3.EmbravaHaste = sets.engaged.Acc

	-- Custom melee group: Max Haste (0% DW)
	sets.engaged.MaxHaste = sets.engaged
	sets.engaged.Acc.MaxHaste = sets.engaged.Acc
	sets.engaged.Acc2.MaxHaste = sets.engaged.Acc
	sets.engaged.Acc3.MaxHaste = sets.engaged.Acc

	--------------------------------------
	-- Custom buff sets
	--------------------------------------

	sets.buff.Migawari = {}
	sets.buff.Doomed = {}
	sets.buff.Yonin = {}
	sets.buff.Innin = {}
	sets.buff.Sange = {ammo="Hachiya Shuriken"}

end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

function job_post_precast(spell, action, spellMap, eventArgs)
	if string.find(spell.name,'Utsusemi') then
	  equip(sets.precast.FC.Utsusemi)
	end
end


-- Run after the general midcast() is done.
-- eventArgs is the same one used in job_midcast, in case information needs to be persisted.
function job_post_midcast(spell, action, spellMap, eventArgs)
	if spell.name == "Flash" then
		equip(sets.Enmity)
	end
	if string.find(spell.name,'Utsusemi') then
	  equip(sets.midcast.Utsusemi)
	end
	if spell.type == "WeaponSkill" then
	  tpspent = spell.tp_cost
	end

	if state.Buff.Doomed then
		equip(sets.buff.Doomed)
	end
	if spell.type ~= 'WeaponSkill' then 
	weathercheck(spell.element)
	end
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted and spell.english == "Migawari: Ichi" then
		state.Buff.Migawari = true
	end
    if state.SpellDebug.value == "On" then 
      spelldebug(spell)
	end

	equip(sets.idle)
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
	-- If we gain or lose any haste buffs, adjust which gear set we target.
	if S{'haste','march','embrava','haste samba'}:contains(buff:lower()) then
		determine_haste_group()
		handle_equipping_gear(player.status)
	elseif state.Buff[buff] ~= nil then
		handle_equipping_gear(player.status)
	end
end

function job_status_change(new_status, old_status)
	if new_status == 'Idle' then
		select_movement_feet()
	end
end

function job_pretarget(spell) 
checkblocking(spell)
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Get custom spell maps
function job_get_spell_map(spell, default_spell_map)
	if spell.skill == "Ninjutsu" then
		if not default_spell_map then
			if spell.target.type == 'SELF' then
				return 'NinjutsuBuff'
			else
				return 'NinjutsuDebuff'
			end
		end
	end
end

-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
	if state.Buff.Migawari then
		idleSet = set_combine(idleSet, sets.buff.Migawari)
	end
	if state.Buff.Doomed then
		idleSet = set_combine(idleSet, sets.buff.Doomed)
	end
	return idleSet
end


-- Modify the default melee set after it was constructed.
function customize_melee_set(meleeSet)
	if state.Buff.Migawari then
		meleeSet = set_combine(meleeSet, sets.buff.Migawari)
	end
	if state.Buff.Doomed then
		meleeSet = set_combine(meleeSet, sets.buff.Doomed)
	end
	if state.Buff.Sange then
		meleeSet = set_combine(meleeSet, sets.buff.Sange)
	end
    return meleeSet
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)    	
disable_specialgear()
end

-- Called by the default 'update' self-command.
function job_update(cmdParams, eventArgs)
	select_movement_feet()
	determine_haste_group()
end

function job_state_change(stateField, newValue, oldValue)


end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function determine_haste_group()
	-- We have three groups of DW in gear: Hachiya body/legs, Ptica head + DW earrings
	
	-- Standard gear set reaches near capped delay with just Haste (77%-78%, depending on HQs)

	-- For high haste, we want to be able to drop one of the 10% groups.
	-- Basic gear hits capped delay (roughly) with:
	-- 1 March + Haste
	-- 2 March
	-- Haste + Haste Samba
	-- 1 March + Haste Samba
	-- Embrava
	
	-- High haste buffs:
	-- 2x Marches + Haste Samba == 19% DW in gear
	-- 1x March + Haste + Haste Samba == 22% DW in gear
	-- Embrava + Haste or 1x March == 7% DW in gear
	
	-- For max haste (capped magic haste + 25% gear haste), we can drop all DW gear.
	-- Max haste buffs:
	-- Embrava + Haste+March or 2x March
	-- 2x Marches + Haste
	
	-- So we want four tiers:
	-- Normal DW
	-- 20% DW -- High Haste
	-- 7% DW (earrings) - Embrava Haste (specialized situation with embrava and haste, but no marches)
	-- 0 DW - Max Haste
	classes.CustomMeleeGroups:clear()
        if ( buffactive[580] and ( buffactive.march or buffactive[33] or buffactive.embrava) ) or 
           ( buffactive[33] and buffactive.march == 2 )  then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif ( buffactive.embrava and ( buffactive.march == 1 or buffactive[33] ) ) then
            classes.CustomMeleeGroups:append('EmbravaHaste')
		-- This is the line to change for with Koru-Moru
        elseif buffactive[33] and buffactive['haste samba'] and buffactive.march == 1 then
            classes.CustomMeleeGroups:append('MaxHaste')
        elseif (buffactive[33] and buffactive.march == 1) or (buffactive.march == 2 and buffactive['haste samba']) or buffactive[580] then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif buffactive.embrava or buffactive.march == 2 then
            classes.CustomMeleeGroups:append('HighHaste')
        elseif buffactive[33] or buffactive.march == 1 then
            classes.CustomMeleeGroups:append('HighHaste')
        end
end


function select_movement_feet()
	if world.time >= (17*60) or world.time < (7*60) then
		gear.MovementFeet.name = gear.NightFeet
	else
		gear.MovementFeet.name = gear.DayFeet
	end
end

function select_acc_ammo()
	if world.time >= (18*60) or world.time <= (6*60) then
		gear.AccAmmo.name = gear.AccAmmoNight
	else
		gear.AccAmmo.name = gear.AccAmmoDay
	end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
	-- Default macro set/book
	if player.sub_job == 'DNC' then
		set_macro_page(3, 1)
	elseif player.sub_job == 'THF' then
		set_macro_page(3, 1)
	else
		set_macro_page(3, 1)
	end
end