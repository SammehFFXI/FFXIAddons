
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.IdleMode:options('Normal','Reraise','DT','MEVA')
	send_command('bind f10 gs c cycle IdleMode')
	send_command('bind f12 gs c wslist')
	
	--state.OffenseMode = M{['description']='Engaged Mode', 'Normal','Zanshin','Reraise','DT','MedAccuracy','HighAccuracy','HighACCMDB','MEVA'}
	state.OffenseMode = M{['description']='Engaged Mode', 'Normal','DT','HighAccuracy','MEVA','Reraise'}
	-- f9 =  offense mode
	state.WeaponskillMode:options('Normal','Acc','WSD','AccMDB')
	-- win+f9 = ws mode
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.precast.WS")
	send_command("alias mwsset gs equip sets.precast.WS.magic")
	send_command("alias eng gs equip sets.engaged.Normal")
	send_command("alias medacc gs equip sets.engaged.MedAccuracy")
	send_command("alias highacc gs equip sets.engaged.HighAccuracy")
	send_command("alias meva gs equip sets.meva")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 5;input /lockstyleset 1')
	
	-- the following aliases are based on having a Logitech G11 keyboard with extra function keys.
	send_command("alias g11_m2g7 gs c set OffenseMode Normal")
	send_command("alias g11_m2g8 gs c set OffenseMode Zanshin")
	send_command("alias g11_m2g9 gs c set OffenseMode DT")
	send_command("alias g11_m2g10 gs c set OffenseMode MedAccuracy")
	send_command("alias g11_m2g10 gs c set OffenseMode HighAccuracy")
	send_command("alias g11_m2g12 gs c set OffenseMode MEVA")
	send_command("alias g11_m2g13 input /ja Berserk <me>")
	send_command("alias g11_m2g14 input /ja Warcry <me>")
	send_command("alias g11_m2g15 input /ja Aggressor <me>")
	send_command("alias g11_m2g16 gs c ws 1")
	send_command("alias g11_m2g17 gs c ws 2")
	send_command("alias g11_m2g18 gs c ws 3")

	res = require 'resources'
	
	WeaponSkill = {
		["Great Katana"] = {
			["1"] = "Tachi: Shoha",
			["2"] = "Tachi: Hobaku",
			["3"] = "Tachi: Jinpu"
		},
		["Polearm"] = {
			["1"] = "Stardiver",
			["2"] = "Impulse Drive",
			["3"] = "Leg Sweep"
		},
		["Staff"] = {
			["1"] = "Earth Crusher",
			["2"] = "Earth Crusher",
			["3"] = "Earth Crusher"
		},
		
	}
	
end

	
function init_gear_sets()
	
	sets.meva = {
		ammo="Staunch Tathlum +1",
		head="Volte Cap",
		body="Ken. Samue +1",
		hands="Volte Bracers",
		--legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate",
		neck="Warder's Charm +1",
		waist="Carrier's Sash",
		left_ear="Hearty Earring",
		right_ear="Eabani Earring",
		left_ring="Purity Ring",
		right_ring="Vengeful Ring",
		back="Moonbeam Cape",
	}
	
	
	sets.engaged = {}
	sets.engaged.Normal = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		--body={ name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Store TP"+7','Attack+9',}},
		body="Kendatsuba Samue +1",
		--hands={ name="Valorous Mitts", augments={'Accuracy+13 Attack+13','CHR+5','Quadruple Attack +3','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		hands="Wakido Kote +3",
		legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
		feet="Flamma gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		--right_ring="Ilabrat Ring",
		right_ring="Flamma Ring",
		back={ name="Takaha Mantle", augments={'STR+4','"Zanshin"+3','"Store TP"+3','Meditate eff. dur. +7',}},
	}
	
	sets.engaged.Zanshin = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		--body="Kendatsuba Samue +1",
		body="Kasuga Domaru +1",
		hands="Wakido Kote +3",
		legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
		feet="Flamma gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Flamma Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}},
	}
	--sets.engaged["Aftermath: Lv.3"] = set_combine(sets.engaged, {legs="Ken. Hakama +1"})
	--sets.engaged.Zanshin["Aftermath: Lv.3"] = set_combine(sets.engaged, {legs="Ken. Hakama +1"})
	
	sets.engaged.Reraise = set_combine(sets.engaged,{body="Twilight Mail",head="Twilight Helm"})
	sets.engaged.MEVA = sets.meva
	sets.engaged.HighACCMDB = {
	    ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.engaged.HighAccuracy = {
	    ammo="Ginsen",
		head="Wakido Kabuto +3",
		body="Ken. Samue +1",
		hands="Wakido Kote +3",
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10','Damage taken-5%',}},
	}
	sets.engaged.MedAccuracy = {
	    ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body="Ken. Samue +1",
		-- hands={ name="Valorous Mitts", augments={'Accuracy+13 Attack+13','CHR+5','Quadruple Attack +3','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		hands="Wakido Kote +3",
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Takaha Mantle", augments={'STR+4','"Zanshin"+3','"Store TP"+3','Meditate eff. dur. +7',}},
	}

	sets.dt = {
	    head="Ynglinga Sallet",
		--body="Chozor. Coselete",
        body="Wakido Domaru +3",
		hands="Sakonji Kote +3",
		--legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
		legs="Sakonji Haidate +3",
		feet="Flam. Gambieras +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		right_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		left_ring="Defending Ring",
		back="Moonbeam Cape",
		ammo="Staunch Tathlum +1"
	}
	sets.engaged.DT = sets.dt
	sets.precast.WS = {
		ammo="Knobkierrie",
		head="Flam. Zucchetto +2",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Valorous Mitts", augments={'Attack+16','Weapon skill damage +3%','STR+10','Accuracy+7',}},
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'Mag. Acc.+17','"Store TP"+4','Weapon skill damage +8%','Accuracy+5 Attack+5','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		neck="Sam. Nodowa +2",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		--left_ring="Niqmaddu Ring",
        left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.precast.WS.Acc = {
		ammo="Knobkierrie",
	    head="Wakido Kabuto +3",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Valorous Mitts", augments={'Attack+16','Weapon skill damage +3%','STR+10','Accuracy+7',}},
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Epaminondas's Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	sets.precast.WS.WSD = {
		ammo="Knobkierrie",
	    head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+4','Mag. Acc.+24','Weapon skill damage +9%',}},
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Valorous Mitts", augments={'Attack+16','Weapon skill damage +3%','STR+10','Accuracy+7',}},
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'Mag. Acc.+17','"Store TP"+4','Weapon skill damage +8%','Accuracy+5 Attack+5','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		neck="Sam. Nodowa +2",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Ishvara Earring",
		left_ring="Epaminondas's Ring",
		--right_ring="Regal Ring",
        right_ring="Karieyh Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	sets.precast.WS.AccMDB = {
	    ammo="Knobkierrie",
		head="Wakido Kabuto +3",
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		hands={ name="Sakonji Kote +3", augments={'Enhances "Blade Bash" effect',}},
		legs="Wakido Haidate +3",
		feet="Flam. Gambieras +2",
		neck="Sam. Nodowa +2",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Defending Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Magic dmg. taken-10%',}},
	}
	
	
	sets.precast.WS.magic = {
	    ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+4','Mag. Acc.+24','Weapon skill damage +9%',}},
		body={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Wakido Haidate +3",
		feet={ name="Valorous Greaves", augments={'"Snapshot"+4','"Mag.Atk.Bns."+27','"Fast Cast"+1','Accuracy+8 Attack+8','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		--neck="Sanctity Necklace",
		neck="Fotia Gorget",
		--waist="Eschan Stone",
		waist="Fotia Belt",
		left_ear="Hermetic Earring",
		right_ear="Crematio Earring",
		left_ring="Etana Ring",
		right_ring="Weather. Ring",
		--back="Argocham. Mantle",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
			
	sets.ranged = {
		head="Sakonji Kabuto +3",
		body="Ken. Samue +1",
		hands="Ken. Tekko",
        legs="Wakido Haidate +3",
		--legs="Ken. Hakama +1",
		feet="Ken. Sune-Ate",
		neck="Combatant's Torque",
		waist="Reiki Yotai",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Smertrios's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
	}

	-- WS Sets
    sets.precast.WS['Tachi: Ageha'] = {
        ammo="Pemphredo Tathlum",
        head="Flam. Zucchetto +2",
        body="Flamma Korazin +2",
        hands="Flam. Manopolas +2",
        legs="Flamma Dirs +2",
        feet="Flam. Gambieras +2",
        neck="Sanctity Necklace",
        waist="Eschan Stone",
        left_ear="Enchntr. Earring +1",
        right_ear="Digni. Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%','Magic dmg. taken-10%',}},
    }
    
	sets.precast.WS['Namas Arrow'] = set_combine(sets.ranged, {
		body={ name="Sakonji Domaru +3", augments={'Enhances "Overwhelm" effect',}},
		legs="Wakido Haidate +3",
		})
	sets.precast.WS['Apex Arrow'] = sets.precast.WS['Namas Arrow']
	sets.precast.WS["Tachi: Jinpu"] = sets.precast.WS.magic
	sets.precast.WS["Tachi: Goten"] = sets.precast.WS.magic
	sets.precast.WS["Tachi: Koki"] = sets.precast.WS.magic
	sets.precast.WS["Earth Crusher"] = sets.precast.WS.magic
	
	sets.precast.JA.Meditate = set_combine(sets.precast.JA, {
		back="Smertrios's Mantle",
		hands={ name="Sakonji Kote +3", augments={'Enhances "Blade Bash" effect',}},
		head="Wakido Kabuto +3"
	})
	sets.precast.JA['Warding Circle'] = set_combine(sets.precast.JA, {head="Wakido Kabuto +3"})
	sets.precast.JA['Sekkanoki'] = set_combine(sets.precast.JA, {})
	sets.precast.JA['Konzen-ittai'] = set_combine(sets.precast.JA, {})
	sets.precast.JA['Blade Bash'] = set_combine(sets.precast.JA, {hands="Sakonji Kote +3"})
	sets.precast.JA['Meikyo Shisui'] = set_combine(sets.precast.JA, {feet="Sakonji Sune-Ate +3"})
	sets.precast.JA['Hasso'] = set_combine(sets.precast.JA, {})
	sets.precast.JA['Sengikori'] = set_combine(sets.precast.JA, {})
	
	
	sets.CurePotencyRecv = { }
	

    ---  MIDCAST SETS  ---
    sets.midcast = {}
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {
	    head="Ynglinga Sallet",
		--body="Chozor. Coselete",
        body="Wakido Domaru +3",
		hands="Sakonji Kote +3",
		--legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
		legs="Sakonji Haidate +3",
		feet="Danzo Sune-Ate",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		right_ring="Sheltered Ring",
		left_ring="Defending Ring",
		back="Moonbeam Cape",
		ammo="Staunch Tathlum +1"
	}
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle
	
	sets.WakeSleep = {head="Frenzy Sallet"}
	sets.ProtectBuff = {ring1="Sheltered Ring"}

end



function job_pretarget(spell) 
checkblocking(spell)
end


function job_precast(spell)
    handle_equipping_gear(player.status)
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  equip(sets.Idle.Current)
	  return
	end
    if sets.precast.JA[spell.name] then
        equip(sets.precast.JA[spell.name])
    end
	if spell.name == 'Ranged' then
		equip(sets.ranged)
	end	
end

function job_post_precast(spell)
	if player.tp < 2250 and spell.type == 'WeaponSkill' and player.equipment.main == "Dojikiri Yasutsuna" then
		equip({left_ear="Moonshade Earring"})
		windower.add_to_chat(10,"Adding in Moonshade Earring for more TP:"..player.tp)
	elseif player.tp < 2750 and spell.type == 'WeaponSkill' then
		windower.add_to_chat(10,"Adding in Moonshade Earring for more TP:"..player.tp)
		equip({left_ear="Moonshade Earring"})
    elseif player.tp >= 2750 and spell.type == 'WeaponSkill' and (world.time >= (17*60) or world.time < (7*60)) then
        equip({left_ear="Lugra Earring +1"})
	end
    if spell.type == 'WeaponSkill' and buffactive['Meikyo Shisui'] then
        equip({feet="Sakonji Sune-Ate +3"})
    end
end

function job_post_midcast(spell)
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
    job_handle_equipping_gear(player.status)
   if (gain_or_loss) then  
     add_to_chat(4,'------- Gained Buff: '..status..'-------')
	 if status == "sleep" then
	   equip(sets.WakeSleep)
	 end
	 if status == "KO" then
	   send_command('input /party These tears... they sting-wing....')
	 end
   else 
     add_to_chat(3,'------- Lost Buff: '..status..'-------')
   end
 end

 function job_self_command(command)
	if command[1]:lower() == "ws" and command[2] ~= nil then
		local EquipedGear = windower.ffxi.get_items()
		local CurrentSkill
		if EquipedGear.equipment.main == nil or EquipedGear.equipment.main == 0 then 
		  CurrentSkill = "Hand-to-Hand"
		else 
		  CurrentSkill = res.skills[res.items[windower.ffxi.get_items(EquipedGear.equipment.main_bag, EquipedGear.equipment.main).id].skill].en
		end
		send_command('input /ws '..WeaponSkill[CurrentSkill][command[2]])
	end
	if command[1]:lower() == "wslist" then
		local EquipedGear = windower.ffxi.get_items()
		local CurrentSkill
		if EquipedGear.equipment.main == nil or EquipedGear.equipment.main == 0 then 
		  CurrentSkill = "Hand-to-Hand"
		else 
		  CurrentSkill = res.skills[res.items[windower.ffxi.get_items(EquipedGear.equipment.main_bag, EquipedGear.equipment.main).id].skill].en
		end
		windower.add_to_chat(2,"WS List:")
		for i,v in pairs(WeaponSkill[CurrentSkill]) do
			windower.add_to_chat(2,i..") "..v)
		end
	end
end

function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
	disable_specialgear()
    if buffactive.sleep then
	equip(sets.WakeSleep)
	end
	if playerStatus == 'Idle' then
        equip(sets.Idle.Current)
    end
	if state.IdleMode.value == "Reraise" then
	   sets.Idle.Current = set_combine(sets.Idle,{body="Twilight Mail",head="Twilight Helm"})   
	elseif state.IdleMode.value == "MEVA" then 
		sets.Idle.Current = sets.meva
	elseif state.IdleMode.value == "DT" or state.OffenseMode.value == "DT" then
		if buffactive['Aftermath'] then
			sets.Idle.Current = sets.dtaftermath
			sets.engaged.DT = sets.dtaftermath
		else
			sets.Idle.Current = sets.dt
			sets.engaged.DT = sets.dt
		end
	else
	   sets.Idle.Current = sets.Idle
	end
end



function select_default_macro_book()
    set_macro_page(2, 1)
end
