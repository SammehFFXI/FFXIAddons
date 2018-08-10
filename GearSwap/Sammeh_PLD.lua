
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.IdleMode:options('Normal','FastPants')
    state.ShieldMode = M{['description']='Shield Mode', 'Srivatsa','Aegis', 'Ochain'} -- ,'Priwen' }
	state.TPMode = M{['description']='TP Mode', 'Normal', 'WeaponLock'}
	state.OffenseMode = M{['description']='Engaged Mode', 'Turtle','DD'}
	send_command('bind f11 gs c cycle ShieldMode')
    send_command('bind f10 gs c cycle IdleMode')
	select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias fchp gs equip sets.precast.FastCastHighHP")
	send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias enm gs equip sets.enmity")
	send_command("alias cureset gs equip sets.midcast.Cure")
	send_command("alias wsset gs equip sets.ws")
	send_command("alias eng gs equip sets.engaged")
	waittime = 2.6	
	
end

	
function init_gear_sets()
    -- Setting up Gear As Variables --

	-- Idle Sets
	sets.dt = {
	    ammo="Homiliary",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Odnowa Earring +1",
		right_ear="Thureous Earring",
		left_ring="Regal Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
	}
	
	sets.sird = {
	    ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',},priority=15},
		body={ name="Rev. Surcoat +2",priority=14},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',},priority=13},
		legs={ name="Founder's Hose", augments={'MND+10','Mag. Acc.+15','Attack+15','Breath dmg. taken -5%',},priority=2},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+4','Mag. Acc.+8',},priority=1},
		neck="Moonbeam Necklace",
		waist="Rumination Sash",
		left_ear={ name="Odnowa Earring +1",priority=11},
		right_ear="Trux Earring",
		left_ring="Apeile Ring",
		right_ring="Apeile Ring +1",
		back={ name="Rudianos's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',},priority=12},
	}
	
	
	sets.enmity = {}
	sets.engaged = {}
	sets.engaged.Turtle = set_combine(sets.dt, {})
	sets.engaged.DD = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Store TP"+7','Attack+9',}},
		hands="Sulev. Gauntlets +2",
		legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
		feet="Flam. Gambieras +2",
		neck="Combatant's Torque",
		waist="Grunfeld Rope",
		left_ear="Cessance Earring",
		right_ear="Brutal Earring",
		left_ring="Regal Ring",
		right_ring="Flamma Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	
	
	
    ---  PRECAST SETS  ---
	sets.precast = {}
    sets.precast.JA = set_combine(sets.midcast.enmity, {})
    sets.precast.JA.Enlightenment = set_combine(sets.midcast.enmity, {body=enlightenment_body})
	sets.precast.FastCastHighHP = {
		body={ name="Rev. Surcoat +2",priority=15},
		back={ name="Rudianos's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',},priority=14},
		ammo="Incantor Stone",
		neck="Voltsurge Torque",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
	}
    sets.precast.FastCast = {
	    ammo="Impatiens",
		head={ name="Odyssean Helm", augments={'Mag. Acc.+19','"Fast Cast"+6','AGI+6','"Mag.Atk.Bns."+3',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+4','Mag. Acc.+8',}},
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		body={ name="Rev. Surcoat +2",priority=15},
		back={ name="Rudianos's Mantle", augments={'HP+60','Mag. Acc+20 /Mag. Dmg.+20','HP+20','"Fast Cast"+10','Phys. dmg. taken-10%',},priority=14},
	}
    sets.precast.EnhancingMagic = {}
    sets.precast.Cure = set_combine(sets.precast.FastCast,{})
	
    sets.Idle = sets.dt
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle
	
	
    sets.midcast = set_combine(sets.sird, {})
    sets.midcast['Healing Magic'] = {
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Unmoving Collar +1",
		waist="Rumination Sash",
		left_ear="Odnowa Earring +1",
		right_ear="Trux Earring",
		left_ring="Apeile Ring",
		right_ring="Apeile Ring +1",
		back="Moonbeam Cape",
	}
	sets.cursna = {
		ring1="Eshmun's Ring",
		ring2="Eshmun's Ring",
		waist="Gishdubar Sash"
	}
	sets.midcast['Healing Magic'] = sets.sird
    sets.midcast['Enhancing Magic'] = set_combine(sets.sird, {})
	sets.midcast['Divine Magic'] = {
		ammo="Staunch Tathlum",
		head={ name="Souv. Schaller +1", augments={'HP+105','VIT+12','Phys. dmg. taken -4',}},
		body={ name="Souv. Cuirass +1", augments={'VIT+12','Attack+25','"Refresh"+3',}},
		hands={ name="Souv. Handsch. +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Unmoving Collar +1",
		waist="Rumination Sash",
		left_ear={ name="Odnowa Earring +1",priority=14},
		right_ear="Trux Earring",
		left_ring="Apeile Ring",
		right_ring="Apeile Ring +1",
		back={ name="Moonbeam Cape",priority=15},
	}
	sets.midcast['Blue Magic'] = set_combine(sets.sird, {})
    sets.ws = {}
	sets.ws.wsd = {
	    head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Attack+21','"Dbl.Atk."+4','STR+10','Accuracy+12',}},
		hands={ name="Valorous Mitts", augments={'Attack+16','Weapon skill damage +3%','STR+10','Accuracy+7',}},
		legs={ name="Valor. Hose", augments={'Accuracy+29','"Dbl.Atk."+3','STR+15',}},
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Odnowa Earring +1",
		right_ear="Thureous Earring",
		left_ring="Regal Ring",
		right_ring="Defending Ring",
		back={ name="Rudianos's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
    sets.ws.savageblade = set_combine(sets.ws.wsd, {neck="Caro Necklace",waist="Engraved Belt",hands="Agoge Mufflers +3",legs="Sulev. Cuisses +2",})
    sets.ws["Savage Blade"] = set_combine(sets.ws.wsd, {neck="Caro Necklace",waist="Engraved Belt",hands="Agoge Mufflers +3",legs="Sulev. Cuisses +2",})
    
	sets.precast.WS = sets.ws

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
    handle_equipping_gear(player.status)
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  equip(sets.Idle.Current)
	  return
	end
	if player.hpp > 80 and spell.action_type == 'Magic' then 
       equip(sets.precast.FastCastHighHP)
	end
    if sets.precast.JA[spell.name] then
        equip(sets.precast.JA[spell.name])
    elseif string.find(spell.name,'Cur') and spell.name ~= 'Cursna' and player.hpp < 80 then
        equip(sets.precast.Cure)
    elseif spell.skill == 'EnhancingMagic' then
        equip(sets.precast.EnhancingMagic)
    elseif spell.action_type == 'Magic' and spell.skill ~= 'Blue Magic' and spell.skill ~= 'Divine Magic' and player.hpp < 75 then
        equip(sets.precast.FastCast)
    end
end

function job_post_midcast(spell)
    if string.find(spell.english,'Cur') then 
        equip(sets.midcast.Cure)
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.CurePotencyRecieved)
		end
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingMagic)
    else
        equip(sets.midcast[spell.skill])
    end
	if spell.name == 'Utsusemi: Ichi' then
	  send_command('cancel Copy Image|Copy Image (2)')
	end
end        

function job_aftercast(spell)
	aftercast_start = os.clock()
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
    handle_equipping_gear(player.status)
    equip(sets.Idle.Current)
end


function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
	if state.TPMode.value == "WeaponLock" then
	  equip({main=weaponlock_main,sub=weaponlock_sub})
	  disable("main")
	  disable("sub")
	else
	  enable("main")
	  enable("sub")
	end
    if state.ShieldMode.value == "Priwen" then
	   equip({sub="Priwen"})
    elseif state.ShieldMode.value == "Ochain" then
	   equip({sub="Ochain"})
	elseif state.ShieldMode.value == "Aegis" then
	   equip({sub="Aegis"})
	elseif state.ShieldMode.value == "Srivatsa" then
	   equip({sub="Srivatsa"})
	end	
	if state.IdleMode.value == "FastPants" then
	   sets.Idle.Current = set_combine(sets.Idle,{legs="Carmine Cuisses +1"})   
	else 
	   sets.Idle.Current = set_combine(sets.Idle)
	end
	if playerStatus == 'Idle' then
        equip(sets.Idle.Current)
    end
	
end



function select_default_macro_book()
    set_macro_page(6, 1)
end
