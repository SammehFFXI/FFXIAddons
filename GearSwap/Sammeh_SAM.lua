
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.EngagedMode = M{['description']='Engaged Mode', 'Normal','PDT'}
	send_command('bind f9 gs c cycle EngagedMode')
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.ws")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias meva gs equip sets.meva")
	send_command("alias rng gs equip sets.ranged")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 5;input /lockstyleset 1')
	
end

	
function init_gear_sets()
	   
	sets.engaged = {
		ammo="Ginsen",
		head="Flam. Zucchetto +2",
		--body={ name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Store TP"+7','Attack+9',}},
		body="Kendatsuba Samue +1",
		hands={ name="Valorous Mitts", augments={'Accuracy+13 Attack+13','CHR+5','Quadruple Attack +3','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
		feet="Flamma gambieras +2",
		neck="Moonbeam Nodowa",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Ilabrat Ring",
		back={ name="Takaha Mantle", augments={'STR+4','"Zanshin"+1','"Store TP"+2','Meditate eff. dur. +6',}},
	}
	sets.engaged.DT = set_combine(sets.engaged,{ring2="Defending Ring",head="Loess barbuta +1",neck="Loricate Torque +1",ring1="Dark Ring",})
	sets.ws = {
		ammo="Knobkierrie",
	    head={ name="Valorous Mask", augments={'Accuracy+18 Attack+18','Weapon skill damage +3%','STR+9','Accuracy+1',}},
		body={ name="Valorous Mail", augments={'Accuracy+24 Attack+24','Weapon skill damage +3%','DEX+6','Accuracy+1','Attack+13',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+23 Attack+23','Weapon skill damage +3%','VIT+8','Accuracy+2','Attack+12',}},
		legs="Hiza. Hizayoroi +2",
		feet={ name="Valorous Greaves", augments={'Mag. Acc.+17','"Store TP"+4','Weapon skill damage +8%','Accuracy+5 Attack+5','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Smertrios's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}},
	}
	
	sets.ranged = {
		head="Ken. Jinpachi",
		body="Ken. Samue +1",
		hands="Ken. Tekko",
		legs="Ken. Hakama",
		feet="Ken. Sune-Ate",
		neck="Combatant's Torque",
		waist="Reiki Yotai",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Smertrios's Mantle", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Rng.Acc.+10','"Store TP"+10',}},
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
	sets.precast.WS['Namas Arrow'] = sets.ranged
	sets.precast.WS['Apex Arrow'] = sets.ranged
	
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
		ammo="Staunch Tathlum"
	}
	sets.meva = {
	    ammo="Staunch Tathlum",
    head="Ken. Jinpachi",
    body="Ken. Samue +1",
    hands="Ken. Tekko",
    legs="Ken. Hakama",
    feet="Ken. Sune-Ate",
    neck="Warder's Charm +1",
    waist="Carrier's Sash",
    left_ear="Hearty Earring",
    right_ear="Eabani Earring",
    left_ring="Purity Ring",
    right_ring="Vengeful Ring",
    back="Moonbeam Cape",
	}
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle
	sets.dt = set_combine(sets.Idle,{body="Kendatsuba Samue +1",ring2="Defending Ring",head="Loess barbuta +1",neck="Loricate Torque +1",ring1="Dark Ring",})
	
	sets.WakeSleep = {head="Frenzy Sallet"}

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
end


function job_post_precast(spell)
	if player.tp < 2250 and spell.type == 'WeaponSkill' and player.equipment.main == "Dojikiri Yasutsuna" then
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
	if spell.name == 'Ranged' then
		equip(sets.ranged)
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
	disable_specialgear()
	if player.equipment.ranged == "Yoichinoyumi" then
		disable('ammo','ranged')
	else
		enable('ammo','ranged')
	end
    if buffactive.sleep then
		equip(sets.WakeSleep)
	end
	if playerStatus == 'Idle' then
        equip(sets.Idle.Current)
    end
end



function select_default_macro_book()
    set_macro_page(2, 1)
end
