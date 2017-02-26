
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.EngagedMode = M{['description']='Engaged Mode', 'Normal','ACC'}
	send_command('bind f9 gs c cycle EngageddMode')
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.ws")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 1;input /lockstyleset 1')
	
end

	
function init_gear_sets()
	   
	sets.engaged = {
		ammo="Ginsen",
		head={ name="Ryuo Somen", augments={'HP+50','Accuracy+15','Attack+15',}},
		body={ name="Valorous Mail", augments={'Accuracy+22','"Store TP"+7',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+13 Attack+13','CHR+5','Quadruple Attack +3','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
		feet={ name="Valorous Greaves", augments={'Accuracy+26','"Dbl.Atk."+4','DEX+8','Attack+3',}},
		neck="Combatant's Torque",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Ilabrat Ring",
		back={ name="Takaha Mantle", augments={'STR+4','"Zanshin"+1','"Store TP"+2','Meditate eff. dur. +6',}},
	}
	sets.ws = {
		ammo="Knobkierrie",
	    head={ name="Valorous Mask", augments={'Weapon skill damage +5%','AGI+7','Accuracy+15','Attack+10',}},
		body={ name="Valorous Mail", augments={'Accuracy+24 Attack+24','Weapon skill damage +3%','DEX+6','Accuracy+1','Attack+13',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+23 Attack+23','Weapon skill damage +3%','VIT+8','Accuracy+2','Attack+12',}},
		legs="Hiza. Hizayoroi +1",
		feet={ name="Valorous Greaves", augments={'Accuracy+23 Attack+23','Enmity+2','STR+8','Accuracy+9','Attack+9',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Rajas Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
	
    ---  PRECAST SETS  ---
	sets.precast = {}
    sets.precast.JA = {}
	sets.precast.JA.Meditate = {
		back="Smertrios's Mantle",
		hands={ name="Sakonji Kote", augments={'Enhances "Blade Bash" effect',}},
		head="Wakido Kabuto +1"
	}
    
	
	-- WS Sets
	sets.precast.WS = sets.ws
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {
	    head="Loess Barbuta +1",
		body="Hiza. Haramaki +1",
		hands="Macabre Gaunt.",
		legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
		feet="Danzo Sune-Ate",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle
	
	sets.WakeSleep = {head="Frenzy Sallet"}

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
    elseif string.find(spell.name,'Cur') and spell.name ~= 'Cursna' then
        equip(sets.precast.Cure)
    elseif spell.skill == 'EnhancingMagic' then
        equip(sets.precast.EnhancingMagic)
    elseif spell.action_type == 'Magic' then
        equip(sets.precast.FastCast)
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
    handle_equipping_gear(player.status)
   if (gain_or_loss) then  
     add_to_chat(4,'------- Gained Buff: '..status..'-------')
	 if status == "sleep" then
	   send_command ('input /equip head "Frenzy Sallet"')
	 end
	 if status == "KO" then
	   send_command('input /party These tears... they sting-wing....')
	 end
   else 
     add_to_chat(3,'------- Lost Buff: '..status..'-------')
   end
 end




function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
    if buffactive.sleep then
	equip(sets.WakeSleep)
	end

    if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' or player.equipment.back == 'Nexus Cape' then
        disable('back')
    else
        enable('back')
    end
        if player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Trizek Ring' or player.equipment.ring1 == 'Capacity Ring' or player.equipment.ring1 == "Vocation Ring" then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Trizek Ring' or player.equipment.ring2 == 'Capacity Ring' or player.equipment.ring2 == "Vocation Ring" then
        disable('ring2')
    else
        enable('ring2')
    end
	if playerStatus == 'Idle' then
        equip(sets.Idle.Current)
    end
	
end



function select_default_macro_book()
    set_macro_page(2, 1)
end
