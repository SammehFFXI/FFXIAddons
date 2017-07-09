
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.IdleMode:options('Normal','Reraise','DT')
	send_command('bind f10 gs c cycle IdleMode')
	state.OffenseMode = M{['description']='Engaged Mode', 'Normal','Reraise','DT'}
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.ws")
	send_command("alias strwsset gs equip sets.ws.strbased")
	send_command("alias vitwsset gs equip sets.ws.vitbased")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias enmity gs equip sets.enmity")
	send_command("alias meva gs equip sets.meva")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 5;input /lockstyleset 27')
	
	send_command("alias g11_m2g13 input /ja Berserk <me>")
	send_command("alias g11_m2g14 input /ja Warcry <me>")
	send_command("alias g11_m2g15 input /ja Aggressor <me>")
	send_command("alias g11_m2g16 input /ja Restraint <me>")
	send_command("alias g11_m2g17 input /ws Scourge")
	send_command("alias g11_m2g18 input /ws Resolution")

	
end

	
function init_gear_sets()
	sets.dt = {
		ammo="Staunch Tathlum", --dt2
	    head="Sulevia's Mask +1", --dt5 
		body="Arke Corazza", --dt12
		hands="Sulev. Gauntlets +2", --dt4
		legs="Sulev. Cuisses +2", --dt6
		feet="Sulev. Leggings +1", --dt3
		neck="Loricate Torque +1", --dt6 
		waist="Ioskeha Belt",
		right_ear="Telos Earring",
		left_ear="Cessance Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}}, --pdt6, mdt3
		right_ring="Defending Ring", -- dt10
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	} -- pdt 50 mdt -- 47 (Shell will easily make up diff)
	sets.dtaftermath = {
		ammo="Ginsen",
	    head="Flamma Zucchetto +1",
		body="Sulevia's Plate. +1", --dt8
		hands="Sulev. Gauntlets +2", --dt5
		legs={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','"Store TP"+6','STR+8',}},
		feet="Sulev. Leggings +1", --dt3
		neck="Loricate Torque +1", --dt6 
		waist="Ioskeha Belt",
		right_ear="Telos Earring",
		left_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring", -- dt10
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	} --pdt 31 --mdt 31 (+20% aftermath DT) 
	sets.engaged = {
		ammo="Ginsen",
		head="Flamma Zucchetto +1",
		body={ name="Valorous Mail", augments={'Accuracy+22','"Store TP"+7',}},
		hands="Sulev. Gauntlets +2",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','"Store TP"+6','STR+8',}},
		feet="Pumm. Calligae +3",
		neck="Combatant's Torque",
		waist="Ioskeha Belt",
		right_ear="Telos Earring",
		left_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	sets.enmity = {
	    head="Halitus Helm", -- 8
		body={ name="Souveran Cuirass", augments={'VIT+10','Attack+20','"Refresh"+2',}}, -- 10
		hands="Macabre Gaunt.", -- 6
		legs={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','"Store TP"+6','STR+8',}}, -- 4
		feet={ name="Yorium Sabatons", augments={'Enmity+9',}}, -- 14
		neck="Unmoving Collar +1", -- 10
		waist="Flume Belt +1",
		left_ear="Cryptic Earring", -- 4
		right_ear="Trux Earring", -- 5
		left_ring="Supershear Ring", --5 
		right_ring="Apeile Ring", --5~9
		back="Philidor Mantle", -- 5
	} -- Enmity = 76~80
	sets.engaged.Reraise = set_combine(sets.engaged,{body="Twilight Mail",head="Twilight Helm"})
	sets.engaged.DT = sets.dt
	sets.ws = {
		-- ammo="Seeth. Bomblet +1",
		ammo="Knobkierrie",   -- Losing 13 acc for +10 att +6WSD; not sure if that's a gr8 thing.
		head={ name="Valorous Mask", augments={'Weapon skill damage +5%','AGI+7','Accuracy+15','Attack+10',}},
		body="Pumm. Lorica +3",
		hands="Sulev. Gauntlets +2",
		legs={ name="Valor. Hose", augments={'Accuracy+29','"Dbl.Atk."+3','STR+15',}},
		feet="Sulev. Leggings +1",
		right_ear="Telos Earring",
		left_ear="Cessance Earring",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	--back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10',}},
	sets.ws.vitbased = set_combine(sets.ws,{
		body="Pumm. Lorica +3",
		right_ring="Regal Ring",
		legs="Sulev. Cuisses +2",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10',}},
	})
	sets.ws.strbased = set_combine(sets.ws,{
	head={ name="Argosy Celata +1", augments={'STR+12','DEX+12','Attack+20',}},
    body={ name="Argosy Hauberk", augments={'STR+10','DEX+10','Attack+15',}},
	hands={ name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}},
    legs={ name="Argosy Breeches +1", augments={'STR+12','DEX+12','Attack+20',}},
    feet={ name="Argosy Sollerets +1", augments={'STR+12','DEX+12','Attack+20',}},
    })
	sets.ws.magic = {
	    ammo="Pemphredo Tathlum",
		head={ name="Jumalik Helm", augments={'MND+7','"Mag.Atk.Bns."+12','Magic burst dmg.+7%',}},
		body={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Argosy Breeches +1", augments={'STR+12','DEX+12','Attack+20',}},
		feet={ name="Founder's Greaves", augments={'VIT+10','Accuracy+15','"Mag.Atk.Bns."+15','Mag. Evasion+15',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Hermetic Earring",
		right_ear="Crematio Earring",
		left_ring="Etana Ring",
		right_ring="Weather. Ring",
		back="Argocham. Mantle",
	}
	sets.ws["King\'s Justice"] = sets.ws.strbased
	sets.ws["Fell Cleve"] = sets.ws.strbased
	sets.ws["Resolution"] = sets.ws.strbased
	sets.ws["Mistral Axe"] = sets.ws.strbased
	sets.ws["Savage Blade"] = sets.ws.strbased
	sets.ws["Metatron Torment"] = sets.ws.strbased
	sets.ws["Upheaval"] = sets.ws.vitbased
	sets.ws["Cloudsplitter"] = sets.ws.magic
	
	
	
    ---  PRECAST SETS  ---
	sets.precast = {}
    sets.precast.JA = set_combine(sets.enmity, {})
	sets.precast.JA.Berserk = set_combine(sets.precast.JA, {back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},body="Pumm. Lorica +3",feet="Agoge Calligae +1"})
	sets.precast.JA.Warcry = set_combine(sets.precast.JA, {head="Agoge mask +1"})
	sets.precast.JA['Blood Rage'] = set_combine(sets.precast.JA, {body="Boii Lorica +1"})
	sets.precast.Restraint = set_combine(sets.precast.JA, {hands="Boii Mufflers +1"})
	sets.precast.JA.Tomahawk = set_combine(sets.precast.JA, {ammo="Thr. Tomahawk",feet="Agoge Calligae +1"})
	
	sets.meva = {
		ammo="Staunch Tathlum",
		head={ name="Jumalik Helm", augments={'MND+7','"Mag.Atk.Bns."+12','Magic burst dmg.+7%',}},
		body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','"Store TP"+6','STR+8',}},
		feet="Founder's Greaves",
		neck="Warder's Charm +1",
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear="Flashward Earring",
		left_ring="Purity Ring",
		right_ring="Vengeful Ring",
		back="Tantalic Cape",
	}
	
	-- WS Sets
	sets.precast.WS = sets.ws
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {
		ammo="Ginsen",
		head="Twilight Helm",
		body="Arke Corazza",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Hermes' Sandals",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		right_ear="Telos Earring",
		left_ear="Cessance Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle
	
	sets.WakeSleep = {neck="Vim Torque +1"}
	sets.ProtectBuff = {ring1="Sheltered Ring"}

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

function job_post_precast(spell)
	if player.tp < 2250 and spell.type == 'WeaponSkill' and player.equipment.main == "Chango" then
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
    set_macro_page(9, 1)
end
