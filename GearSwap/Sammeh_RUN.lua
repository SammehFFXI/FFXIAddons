
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.OffenseMode = M{['description']='Engaged Mode', 'Normal','ACC','DT'} -- f9 to cycle
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.ws")
	send_command("alias dt gs equip sets.dt")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias meva gs equip sets.meva")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 5;input /lockstyleset 27')
	
end

	
function init_gear_sets()
	
	sets.dt = {
		ammo="Staunch Tathlum",
		head="Meghanada Visor +1",
		body="Erilaz Surcoat +1",
		hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}},
		legs="Erilaz Leg Guards",
		feet="Erilaz Greaves",
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Sherida Earring",
		right_ear="Genmei Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+6','"Dbl.Atk."+4','Damage taken-3%',}},
	}
	sets.engaged = {
		ammo="Ginsen",
		head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
		body={ name="Adhemar Jacket", augments={'DEX+10','AGI+10','Accuracy+15',}},
		hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}},
		legs="Samnuha Tights",
		feet={ name="Herculean Boots", augments={'Mag. Acc.+1 "Mag.Atk.Bns."+1','STR+11','Quadruple Attack +2','Accuracy+18 Attack+18',}},
		neck="Combatant's Torque",
		waist="Ioskeha Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+6','"Dbl.Atk."+4','Damage taken-3%',}},
	}
	sets.engaged.DT = sets.dt
	sets.ws = {
		ammo="Seeth. Bomblet +1",
		head={ name="Herculean Helm", augments={'Accuracy+27','Weapon skill damage +3%','STR+10',}},
		body={ name="Herculean Vest", augments={'Accuracy+22 Attack+22','Weapon skill damage +3%','STR+12','Accuracy+10','Attack+12',}},
		hands={ name="Herculean Gloves", augments={'Accuracy+7 Attack+7','Weapon skill damage +3%','STR+10','Accuracy+9','Attack+8',}},
		legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
		feet={ name="Herculean Boots", augments={'Attack+18','Weapon skill damage +4%','STR+7','Accuracy+14',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Sherida Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Epona's Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+6','"Dbl.Atk."+4','Damage taken-3%',}},
	}
	
	sets.enmity = {}
	
    ---  PRECAST SETS  ---
	sets.precast = {}
	
	
	sets.precast.FastCast = {
	    ammo="Impatiens",
		head={ name="Herculean Helm", augments={'Accuracy+23 Attack+23','"Triple Atk."+3','Accuracy+9','Attack+14',}},
		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
		hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}},
		legs="Erilaz Leg Guards",
		feet={ name="Herculean Boots", augments={'Accuracy+28','"Fast Cast"+2','Accuracy+20 Attack+20',}},
		neck="Voltsurge Torque",
		waist="Siegel Sash",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		right_ring="Weather. Ring",
		back={ name="Evasionist's Cape", augments={'Enmity+3','"Embolden"+6','"Dbl.Atk."+4','Damage taken-3%',}},
	}
	
	
    sets.precast.JA = set_combine(sets.enmity, {})
	--[[
    sets.precast.JA['Vallation'] = {body="Runeist coat +1", legs="Futhark trousers +1"}
    sets.precast.JA['Valiance'] = sets.precast.JA['Vallation']
    sets.precast.JA['Pflug'] = {feet="Runeist bottes +1"}
    sets.precast.JA['Battuta'] = {head="Futhark Bandeau +1"}
    sets.precast.JA['Liement'] = {body="Futhark Coat +1"}
    sets.precast.JA['Lunge'] = {head="Thaumas Hat", neck="Eddy Necklace", ear1="Novio Earring", ear2="Friomisi Earring",
            body="Vanir Cotehardie", ring1="Acumen Ring", ring2="Omega Ring",
            back="Evasionist's Cape", waist="Yamabuki-no-obi", legs="Iuitl Tights +1", feet="Qaaxo Leggings"}
    sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = {hands="Runeist Mitons +1"}
    sets.precast.JA['Rayke'] = {feet="Futhark Bottes +1"}
    sets.precast.JA['Elemental Sforzo'] = {body="Futhark Coat 1"}
	sets.precast.JA['Swordplay'] = {hands="Futhark Mitons +1"}
	sets.precast.JA['Embolden'] = {}
	sets.precast.JA['Vivacious Pulse'] = {}
	sets.precast.JA['One For All'] = {}
	]]
	sets.meva = {
		ammo="Staunch Tathlum",
		head="Meghanada Visor +1",
		body="Erilaz Surcoat +1",
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Erilaz Greaves",
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
    sets.Idle = set_combine(sets.dt,{
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
	})
	
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle
	
	sets.WakeSleep = {head="Frenzy Sallet"}
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
	if player.tp < 2750 and spell.type == 'WeaponSkill' then
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
	sets.Idle.Current = sets.Idle
end



function select_default_macro_book()
    set_macro_page(9, 1)
end
