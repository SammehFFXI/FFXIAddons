
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.IdleMode:options('Normal','Reraise','DT')
	send_command('bind f10 gs c cycle IdleMode')
	send_command('bind f12 gs c wslist')
	
	state.OffenseMode = M{['description']='Engaged Mode', 'Normal','DT','Accuracy'}
	-- f9 =  offense mode
	state.WeaponskillMode:options('Normal', 'Acc')
	-- win+f9 = ws mode
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.precast.WS")
	send_command("alias mwsset gs equip sets.precast.WS.magic")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias acc gs equip sets.engaged.Accuracy")
	send_command("alias meva gs equip sets.meva")
	send_command("alias idle gs equip sets.Idle.Current")
	
	-- the following aliases are based on having a Logitech G11 keyboard with extra function keys.
	
	send_command("alias g11_m2g13 input /ja Berserk <me>")
	send_command("alias g11_m2g14 input /ja Warcry <me>")
	send_command("alias g11_m2g15 input /ja Aggressor <me>")
	send_command("alias g11_m2g16 gs c ws 1")
	send_command("alias g11_m2g17 gs c ws 2")
	send_command("alias g11_m2g18 gs c ws 3")

	res = require 'resources'
	
	WeaponSkill = {
		["Great Sword"] = {
			["1"] = "Resolution",
			["2"] = "Shockwave",
			["3"] = "Freezebite"
		},
	}
	
end

	
function init_gear_sets()
	
	sets.engaged = {
		ammo="Ginsen",
		head={ name="Futhark Bandeau", augments={'Enhances "Battuta" effect',}},
		body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+29','Accuracy+16 Attack+16','Quadruple Attack +1','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Twilight Torque",
		waist="Olseni Belt",
		left_ear="Genmei Earring",
		right_ear="Sherida Earring",
		left_ring="Patricius Ring",
		right_ring="Gelatnous Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+9','"Dbl.Atk."+2','Damage taken-2%',}},
	}
	
	
	sets.engaged.Accuracy = {
		ammo="Ginsen",
		head={ name="Futhark Bandeau", augments={'Enhances "Battuta" effect',}},
		body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+29','Accuracy+16 Attack+16','Quadruple Attack +1','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Twilight Torque",
		waist="Olseni Belt",
		left_ear="Genmei Earring",
		right_ear="Sherida Earring",
		left_ring="Patricius Ring",
		right_ring="Gelatnous Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+9','"Dbl.Atk."+2','Damage taken-2%',}},
	}
	
	
	sets.precast.WS = {
		ammo="Knobkierrie",
		head={ name="Futhark Bandeau", augments={'Enhances "Battuta" effect',}},
		body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+29','Accuracy+16 Attack+16','Quadruple Attack +1','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Twilight Torque",
		waist="Olseni Belt",
		left_ear="Genmei Earring",
		right_ear="Sherida Earring",
		left_ring="Patricius Ring",
		right_ring="Gelatnous Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+9','"Dbl.Atk."+2','Damage taken-2%',}},
	}
	
	sets.precast.WS.Acc = {
		ammo="Knobkierrie",
		head={ name="Futhark Bandeau", augments={'Enhances "Battuta" effect',}},
		body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+29','Accuracy+16 Attack+16','Quadruple Attack +1','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Twilight Torque",
		waist="Olseni Belt",
		left_ear="Genmei Earring",
		right_ear="Sherida Earring",
		left_ring="Patricius Ring",
		right_ring="Gelatnous Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+9','"Dbl.Atk."+2','Damage taken-2%',}},
	}
	
	sets.precast.WS.magic = {
		ammo="Knobkierrie",
		head={ name="Futhark Bandeau", augments={'Enhances "Battuta" effect',}},
		body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+29','Accuracy+16 Attack+16','Quadruple Attack +1','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Twilight Torque",
		waist="Olseni Belt",
		left_ear="Genmei Earring",
		right_ear="Sherida Earring",
		left_ring="Patricius Ring",
		right_ring="Gelatnous Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+9','"Dbl.Atk."+2','Damage taken-2%',}},
	}
	
	-- WS Sets
	-- sets.precast.WS[''] = {}
	
	sets.enmity = {}

    sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark trousers"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {}
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons"}
    sets.precast.JA['Rayke'] = {feet="Futhark Bottes"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat +1"}
    sets.precast.JA['Swordplay'] = {hands="Futhark Mitons"}
    sets.precast.JA['Embolden'] = {}
    sets.precast.JA['Vivacious Pulse'] = {}
    sets.precast.JA['One For All'] = {}
    sets.precast.JA['Provoke'] = sets.enmity
	
	sets.meva = {	}
	
	sets.CurePotencyRecv = { }
	

    ---  MIDCAST SETS  ---
    sets.midcast = {}
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {
		ammo="Ginsen",
		head={ name="Futhark Bandeau", augments={'Enhances "Battuta" effect',}},
		body={ name="Futhark Coat +1", augments={'Enhances "Elemental Sforzo" effect',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+29','Accuracy+16 Attack+16','Quadruple Attack +1','Mag. Acc.+14 "Mag.Atk.Bns."+14',}},
		legs="Eri. Leg Guards +1",
		feet="Erilaz Greaves +1",
		neck="Twilight Torque",
		waist="Olseni Belt",
		left_ear="Genmei Earring",
		right_ear="Sherida Earring",
		left_ring="Patricius Ring",
		right_ring="Gelatnous Ring +1",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+9','"Dbl.Atk."+2','Damage taken-2%',}},
	}
	
	sets.dt = sets.Idle
	sets.engaged.DT = sets.dt
	
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
		equip(sets.precast.Ranged)
	end	
end

function job_post_precast(spell)
	if player.tp < 2250 and spell.type == 'WeaponSkill' and player.equipment.main == "Lionheart" then
		equip({left_ear="Moonshade Earring"})
		windower.add_to_chat(10,"Adding in Moonshade Earring for more TP:"..player.tp)
	elseif player.tp < 2750 and spell.type == 'WeaponSkill' then
		windower.add_to_chat(10,"Adding in Moonshade Earring for more TP:"..player.tp)
		equip({left_ear="Moonshade Earring"})
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
