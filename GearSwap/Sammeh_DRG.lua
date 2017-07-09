
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.IdleMode:options('Normal','Reraise')
	send_command('bind f10 gs c cycle IdleMode')
	state.OffenseMode = M{['description']='Engaged Mode', 'Normal','ACC','Reraise','DT'}
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.ws")
	send_command("alias strwsset gs equip sets.ws.strbased")
	send_command("alias vitwsset gs equip sets.ws.vitbased")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias meva gs equip sets.meva")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 5;input /lockstyleset 38')
	send_command("alias g11_m2g1 input /ja 'Ancient Circle' <me>")
	send_command("alias g11_m2g2 input /ja 'Deep Breathing' <me>")
	send_command("alias g11_m2g3 input /ja Angon <t>")
	send_command("alias g11_m2g4 input /ja 'Spirit Link' <me>")
	send_command("alias g11_m2g8 input /ja Jump <t>")
	send_command("alias g11_m2g9 input /ja 'High Jump' <t>")
	send_command("alias g11_m2g10 input /pet 'Steady Wing' <me>")
	send_command("alias g11_m2g11 input /pet 'Smiting Breath' <t>")
	send_command("alias g11_m2g12 input /pet 'Restoring Breath' <me>")
	send_command("alias g11_m2g13 input /ja Berserk <me>")
	send_command("alias g11_m2g14 input /ja Warcry <me>")
	send_command("alias g11_m2g15 input /ja Aggressor <me>")
	send_command("alias g11_m2g16 input /ja Restraint <me>")
	send_command("alias g11_m2g17 input /ws 'Camlann\'s Torment'")
	send_command("alias g11_m2g18 input /ws 'Star Diver'")

end

	
function init_gear_sets()
	sets.dt = {
		ammo="Staunch Tathlum",
	    head="Sulevia's Mask +1",
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Sulev. Cuisses +2",
		feet="Sulev. Leggings +1",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Eabani Earring",
		right_ear="Flashward Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	sets.engaged = {
		ammo="Ginsen",
		head="Flam. Zucchetto +1",
		body={ name="Valorous Mail", augments={'Accuracy+22','"Store TP"+7',}},
		hands={ name="Valorous Mitts", augments={'Accuracy+13 Attack+13','CHR+5','Quadruple Attack +3','Mag. Acc.+19 "Mag.Atk.Bns."+19',}},
		legs="Sulev. Cuisses +2",
		feet={ name="Valorous Greaves", augments={'Accuracy+26','"Dbl.Atk."+4','DEX+8','Attack+3',}},
		neck="Shulmanu Collar",
		waist="Ioskeha Belt",
		left_ear="Cessance Earring",
		right_ear="Sherida Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	sets.engaged.Reraise = set_combine(sets.engaged,{body="Twilight Mail",head="Twilight Helm"})
	sets.engaged.DT = sets.dt
	sets.ws = {
		-- ammo="Seeth. Bomblet +1",
		ammo="Knobkierrie",
		head={ name="Valorous Mask", augments={'Weapon skill damage +5%','AGI+7','Accuracy+15','Attack+10',}},
		body={ name="Valorous Mail", augments={'Accuracy+24 Attack+24','Weapon skill damage +3%','DEX+6','Accuracy+1','Attack+13',}},
		hands="Sulev. Gauntlets +2",
		legs={ name="Valor. Hose", augments={'Accuracy+29','"Dbl.Atk."+3','STR+15',}},
		feet="Sulev. Leggings +1",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Brigantia's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	sets.ws.strbased = set_combine(sets.ws,{
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
		
    ---  PRECAST SETS  ---
	sets.precast = {}
    sets.precast.JA = {}
	sets.precast.JA.Berserk = {}
	sets.precast.JA.Warcry = {}
	sets.precast.JA.Meditate = {}
	sets.precast.JA.Angon = {ammo="Angon"}
	
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
		body="Sulevia's Plate. +1",
		hands="Sulev. Gauntlets +2",
		legs="Carmine Cuisses +1",
		feet="Sulev. Leggings +1",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		right_ear="Genmei Earring",
		left_ear="Odnowa Earring +1",
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
	if player.tp < 2250 and spell.type == 'WeaponSkill' then
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
    set_macro_page(9, 1)
end
