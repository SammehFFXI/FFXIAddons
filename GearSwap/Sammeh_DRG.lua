
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.IdleMode:options('Normal','Reraise','DT','MEVA')
	send_command('bind f10 gs c cycle IdleMode')
	send_command('bind f12 gs c wslist')
	
	state.OffenseMode = M{['description']='Engaged Mode', 'Normal','STP','Reraise','DT','MEVA'}
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.ws")
	send_command("alias strwsset gs equip sets.ws.strbased")
	send_command("alias vitwsset gs equip sets.ws.vitbased")
	send_command("alias eng gs equip sets.engaged.Normal")
    send_command("alias stp gs equip sets.engaged.STP")
	send_command("alias meva gs equip sets.meva")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 5;input /lockstyleset 27')
	send_command("alias g11_m2g1 input /ja 'Ancient Circle' <me>")
	send_command("alias g11_m2g2 input /ja 'Deep Breathing' <me>")
	send_command("alias g11_m2g3 input /ja Angon <t>")
	send_command("alias g11_m2g4 input /ja 'Spirit Link' <me>")
	send_command("alias g11_m2g8 input /ja 'Spirit Jump' <t>")
	send_command("alias g11_m2g9 input /ja 'Soul Jump' <t>")
	send_command("alias g11_m2g10 input /pet 'Steady Wing' <me>")
	send_command("alias g11_m2g11 input /ja Defender <me>")
	send_command("alias g11_m2g12 input /ja Restraint <me>")
	send_command("alias g11_m2g13 input /ja Berserk <me>")
	send_command("alias g11_m2g14 input /ja Warcry <me>")
	send_command("alias g11_m2g15 input /ja Aggressor <me>")
	send_command("alias g11_m2g16 gs c ws 1")
	send_command("alias g11_m2g17 gs c ws 2")
	send_command("alias g11_m2g18 gs c ws 3")

	
	res = require 'resources'
	
	WeaponSkill = {
		["Polearm"] = {
			["1"] = "Leg Sweep",
			["2"] = "Camlann\'s Torment",
			["3"] = "Stardiver"
		},
		["Staff"] = {
			["1"] = "Cataclysm",
			["2"] = "Earth Crusher",
			["3"] = "Shattersoul"
		},

	}

end

	
function init_gear_sets()
	sets.dt = {
		ammo="Staunch Tathlum +1",
	    head="Sulevia's Mask +2",
		--body="Sulevia's Plate. +2",
        body="Tartarus Platemail",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +2",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Flashward Earring",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	sets.engaged = {}
	sets.engaged.Normal = {ammo="Ginsen",
		head="Flam. Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Store TP"+7','Attack+9',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+13 Attack+13','CHR+5','Quadruple Attack +3','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
        --hands={ name="Acro Gauntlets", augments={'Accuracy+20 Attack+20','"Store TP"+6','DEX+10',}},
		legs="Sulev. Cuisses +2",
		feet="Flam. Gambieras +2",
		--neck="Shulmanu Collar",
        neck="Anu Torque",
		waist="Ioskeha Belt +1",
		left_ear="Telos Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
    sets.engaged.STP = {
        ammo="Ginsen",
        head="Flam. Zucchetto +2",
        body={ name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Store TP"+7','Attack+9',}},
        hands={ name="Acro Gauntlets", augments={'Accuracy+20 Attack+20','"Store TP"+6','DEX+10',}},
        legs={ name="Valor. Hose", augments={'Accuracy+30','"Store TP"+8','CHR+7',}},
        feet="Flam. Gambieras +2",
        neck="Anu Torque",
        waist="Ioskeha Belt +1",
        left_ear="Telos Earring",
        right_ear="Sherida Earring",
        left_ring="Flamma Ring",
        right_ring="Petrov Ring",
        back={ name="Brigantia's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Store TP"+10',}},
    }
	sets.meva = {
		ammo="Staunch Tathlum +1",
		head="Volte Cap",
		body="Tartarus Platemail",
		hands="Volte Bracers",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Volte Boots",
		neck="Warder's Charm +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Flashward Earring",
		left_ring="Purity Ring",
		right_ring="Vengeful Ring",
		back="Solemnity Cape",
	}
	sets.engaged.MEVA = sets.meva
	
	sets.engaged.Reraise = set_combine(sets.engaged.Normal,{body="Twilight Mail",head="Twilight Helm"})
    
	sets.engaged.DT = sets.dt
	sets.ws = {
		-- ammo="Seeth. Bomblet +1",
		ammo="Knobkierrie",
		--head={ name="Valorous Mask", augments={'Weapon skill damage +5%','AGI+7','Accuracy+15','Attack+10',}},
		head="Flamma Zucchetto +2",
		body={ name="Valorous Mail", augments={'Attack+21','"Dbl.Atk."+4','STR+10','Accuracy+12',}},
		hands="Sulev. Gauntlets +2",
		legs={ name="Valor. Hose", augments={'Accuracy+29','"Dbl.Atk."+3','STR+15',}},
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		right_ear="Sherida Earring",
		left_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
    sets.ws['Leg Sweep'] = {
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
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
    }
	sets.ws.Stardiver = set_combine(sets.ws, {
		feet="Flam. Gambieras +2",
	})
    sets.ws.WSD = {
        ammo="Knobkierrie",
        head={ name="Valorous Mask", augments={'"Mag.Atk.Bns."+4','Mag. Acc.+24','Weapon skill damage +9%',}},
        body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},
        --hands={ name="Valorous Mitts", augments={'Attack+16','Weapon skill damage +3%','STR+10','Accuracy+7',}},
        hands="Ptero. Fin. G. +2",
        legs="Vishap Brais +3",
        feet="Sulev. Leggings +2",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Ishvara Earring",
        right_ear="Sherida Earring",
        left_ring="Epaminondas's Ring",
        right_ring="Karieyh Ring",
        back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
    }
	sets.ws['Camlann\'s Torment'] = sets.ws.WSD
    sets.ws['Sonic Thrust'] = sets.ws.WSD
	
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
		--right_ring="Weather. Ring",
		back="Argocham. Mantle",
	}
		
    ---  PRECAST SETS  ---
	sets.precast = {}
    sets.precast.JA = {}
	sets.precast.JA.Berserk = {}
	sets.precast.JA.Warcry = {}
	sets.precast.JA.Meditate = {}
	sets.precast.JA.Angon = {ammo="Angon", hands="Ptero. Fin. G. +2"}
    sets.precast.JA['Deep Breathing'] = {head="Ptero. Armet +3"}
    sets.precast.JA['Spirit Link'] = {head="Ptero. Armet +3"}
    sets.precast.JA['Call Wyvern'] = {body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},}
    sets.precast.JA['Jump'] = {body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},}
    sets.precast.JA['High Jump'] = {body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},}
    sets.precast.JA['Spirit Jump'] = {body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},}
    sets.precast.JA['Soul Jump'] = {body={ name="Ptero. Mail +3", augments={'Enhances "Spirit Surge" effect',}},}
	
	sets.WSDayBonus = {head="Gavialis Helm"}

	-- WS Sets
	sets.precast.WS = sets.ws
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {
		ammo="Ginsen",
		head="Twilight Helm",
		--body="Sulevia's Plate. +2",
        body="Tartarus Platemail",
		hands="Sulev. Gauntlets +2",
		legs="Carmine Cuisses +1",
		feet="Sulev. Leggings +2",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		right_ear="Genmei Earring",
		left_ear="Odnowa Earring +1",
		left_ring="Moonlight Ring",
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle
	
	sets.WakeSleep = {neck="Vim Torque +1"}
	sets.ProtectBuff = {ring1="Sheltered Ring"}

end

check_ws_day = {
Firesday = S {'Liquefaction','Fusion','Light'},
Earthsday= S {'Scission','Gravitation','Darkness'},
Watersday = S {'Reverberation','Distortion','Darkness'},
Windsday = S {'Detonation','Fragmentation','Light'},
Iceday = S {'Induration','Distortion','Darkness'},
Lightningsday = S {'Impaction','Fragmentation','Light'},
Lightsday = S {'Transfixion','Fusion','Light'},
Darksday = S {'Compression','Gravitation','Darkness'},
}




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
	if player.tp < 2250 and spell.type == 'WeaponSkill' and player.equipment.main == "Trishula" then
		windower.add_to_chat(10,"Adding in Moonshade Earring for more TP:"..player.tp)
		equip({left_ear="Moonshade Earring"})
	end
	if spell.english == 'Stardiver' and (check_ws_day[world.day]:contains(spell.skillchain_a) or check_ws_day[world.day]:contains(spell.skillchain_b) or check_ws_day[world.day]:contains(spell.skillchain_c)) then
	 windower.add_to_chat(8,"Adding in Helm for WS")
	 equip(sets.WSDayBonus)
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


function job_pretarget(spell) 
checkblocking(spell)
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
	else 
	   sets.Idle.Current = sets.Idle
	end
end



function select_default_macro_book()
    set_macro_page(10, 2)
end
