res = require 'resources'
packets = require('packets')

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.OffenseMode = M{['description']='Engaged Mode', 'Normal','DD'} -- f9 to cycle
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias wsset gs equip sets.ws")
	send_command("alias dt gs equip sets.dt")
	send_command("alias eng gs equip sets.engaged")
    send_command("alias engdd gs equip sets.engaged.DD")
    send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias meva gs equip sets.meva")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command('@wait 5;input /lockstyleset 27')
	
end

	
function init_gear_sets()
	
	sets.dt = {
		ammo="Staunch Tathlum +1",
        head="Meghanada Visor +2",
        body="Ashera Harness",
        hands="Turms Mittens +1",
        legs="Eri. Leg Guards +1",
        feet="Turms Leggings +1",
        neck="Futhark Torque +2",
        waist="Sailfi Belt +1",
        left_ear="Sanare Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Moonlight Ring",
        right_ring="Defending Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
	sets.engaged = {
		ammo="Staunch Tathlum +1",
        head="Meghanada Visor +2",
        body="Ashera Harness",
        hands="Turms Mittens +1",
        legs="Eri. Leg Guards +1",
        feet="Turms Leggings +1",
        neck="Futhark Torque +2",
        waist="Sailfi Belt +1",
        left_ear="Sanare Earring",
        right_ear="Odnowa Earring +1",
        left_ring="Moonlight Ring",
        right_ring="Defending Ring",
        back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
	sets.engaged.DT = sets.dt
    sets.engaged.DD = {
        ammo="Aurgelmir Orb +1",
        head={ name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}},
        body="Ashera Harness",
        hands={ name="Herculean Gloves", augments={'Attack+4','"Triple Atk."+4','DEX+1','Accuracy+14',}},
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet={ name="Herculean Boots", augments={'Mag. Acc.+1 "Mag.Atk.Bns."+1','STR+11','Quadruple Attack +2','Accuracy+18 Attack+18',}},
        neck="Combatant's Torque",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Telos Earring",
        right_ear="Brutal Earring",
        left_ring="Epona's Ring",
        right_ring="Niqmaddu Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
    }
	sets.ws = {
		ammo="Knobkierrie",
        head={ name="Herculean Helm", augments={'Accuracy+27','Weapon skill damage +3%','STR+10',}},
        body={ name="Herculean Vest", augments={'Accuracy+22 Attack+22','Weapon skill damage +3%','STR+12','Accuracy+10','Attack+12',}},
        hands="Meg. Gloves +2",
        legs={ name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}},
        feet={ name="Herculean Boots", augments={'Attack+18','Weapon skill damage +4%','STR+7','Accuracy+14',}},
        neck="Fotia Gorget",
        waist={ name="Sailfi Belt +1", augments={'Path: A',}},
        left_ear="Sherida Earring",
        right_ear="Brutal Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Epona's Ring",
        back={ name="Ogma's cape", augments={'DEX+20','Accuracy+20 Attack+20','DEX+10','"Dbl.Atk."+10','Phys. dmg. taken-10%',}},
	}
    sets.cursnareceived = {
    left_ring="Eshmun's Ring",
    right_ring="Eshmun's Ring",
    neck="Nicander's Necklace",
    waist="Gishdubar Sash"
    }
	
	sets.enmity = {
        ammo="Staunch Tathlum +1",
    head="Halitus Helm",
    body="Emet Harness +1",
    hands="Kurys Gloves",
    legs="Eri. Leg Guards +1",
    feet="Ahosi Leggings",
    neck="Futhark Torque +2",
    waist="Ioskeha Belt +1",
    left_ear="Trux Earring",
    right_ear="Cryptic Earring",
    left_ring="Supershear Ring",
    right_ring="Defending Ring",
    back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
    }
	
    ---  PRECAST SETS  ---
	sets.precast = {}
	
	
	sets.precast.FastCast = {
	    ammo="Impatiens",
		head="Rune. Bandeau +2",
		body={ name="Samnuha Coat", augments={'Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+5','"Dual Wield"+5',}},
		hands="Leyline Gloves",
		legs="Futhark Trousers +1",
		feet={ name="Herculean Boots", augments={'Accuracy+28','"Fast Cast"+2','Accuracy+20 Attack+20',}},
		neck="Voltsurge Torque",
		waist="Siegel Sash",
		left_ear="Enchntr. Earring +1",
		right_ear="Loquac. Earring",
		left_ring="Kishar Ring",
		--right_ring="Weather. Ring",
		back={ name="Ogma's cape", augments={'"Fast Cast"+10',}},
	}
	
	
    sets.precast.JA = set_combine(sets.enmity, {})
	
    sets.precast.JA['Vallation'] = set_combine(sets.enmity, {body="Runeist coat +1", legs="Futhark trousers +1"})
    sets.precast.JA['Valiance'] = set_combine(sets.enmity, sets.precast.JA['Vallation'])
    --sets.precast.JA['Pflug'] = set_combine(sets.enmity, {feet="Runeist bottes +1"})
    sets.precast.JA['Battuta'] = set_combine(sets.enmity, {head="Futhark Bandeau +1"})
    --sets.precast.JA['Liement'] = set_combine(sets.enmity, {body="Futhark Coat +1"})
    --sets.precast.JA['Lunge'] = {head="Thaumas Hat", neck="Eddy Necklace", ear1="Novio Earring", ear2="Friomisi Earring",
    --        body="Vanir Cotehardie", ring1="Acumen Ring", ring2="Omega Ring",
    --        back="Evasionist's Cape", waist="Yamabuki-no-obi", legs="Iuitl Tights +1", feet="Qaaxo Leggings"}
    --sets.precast.JA['Swipe'] = sets.precast.JA['Lunge']
    sets.precast.JA['Gambit'] = set_combine(sets.enmity, {hands="Runeist Mitons +1"})
    --sets.precast.JA['Rayke'] = set_combine(sets.enmity, {feet="Futhark Bottes +1"})
    sets.precast.JA['Elemental Sforzo'] = set_combine(sets.enmity, {body="Futhark Coat +1"})
	--sets.precast.JA['Swordplay'] = set_combine(sets.enmity, {hands="Futhark Mitons +1"})
	sets.precast.JA['Embolden'] = set_combine(sets.enmity, {})
	sets.precast.JA['Vivacious Pulse'] = set_combine(sets.enmity, {})
	sets.precast.JA['One For All'] = set_combine(sets.enmity, {})
	
	sets.meva = {
		ammo="Staunch Tathlum +1",
		head="Meghanada Visor +2",
		body="Ashera Harness",
		hands="Volte Bracers",
		legs={ name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}},
		feet="Turms leggings +1",
		neck="Warder's Charm +1",
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear="Flashward Earring",
		left_ring="Purity Ring",
		right_ring="Vengeful Ring",
		back={ name="Ogma's cape", augments={'HP+60','Eva.+20 /Mag. Eva.+20','Mag. Evasion+5','Enmity+10','Phys. dmg. taken-10%',}},
	}
	
	-- WS Sets
	sets.precast.WS = sets.ws
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    sets.midcast.Cursna = sets.cursnareceived
    sets.midcast['Enhancing Magic'] = {
	    ammo="Staunch Tathlum +1",
		head="Erilaz Galea +1",
		--body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
		hands="Runeist Mitons +1",
		legs="Futhark Trousers +1",
		--feet={ name="Telchine Pigaches", augments={'Mag. Evasion+25','"Subtle Blow"+6','Enh. Mag. eff. dur. +10',}},
		neck="Incanter's Torque",
		waist="Rumination Sash",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Stikini Ring +1",
		right_ring="Stikini Ring",
		--back="Perimede Cape",
	}
    sets.midcast.Phalanx = set_combine(sets.midcast['Enhancing Magic'], {head="Futhark Bandeau +1"})
    sets.midcast.Refresh = set_combine(sets.midcast['Enhancing Magic'], {waist="Gishdubar Sash"})
    sets.midcast.Flash = set_combine(sets.enmity, {})
    sets.midcast.Foil = set_combine(sets.enmity, {})
	
    
    ---  AFTERCAST SETS  ---
    sets.Idle = set_combine(sets.dt,{legs="Carmine Cuisses +1", ammo="Homiliary"})
	
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

function job_pretarget(spell)
checkblocking(spell)
	if spell.action_type == 'Magic' then
		if aftercast_start and os.clock() - aftercast_start < waittime then
			windower.add_to_chat(8,"Precast too early! Adding Delay:"..waittime - (os.clock() - aftercast_start))
			cast_delay(waittime - (os.clock() - aftercast_start))
		end
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
    check_run_status()
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


windower.raw_register_event('outgoing chunk',function(id,data)
	if id == 0x037 then
		local packet = packets.parse('outgoing', data)
        item_used = res.items[windower.ffxi.get_items(packet.Bag, packet.Slot).id].en
        if item_used == 'Holy Water' then
          windower.send_command("gs equip sets.cursnareceived")
        end
	end
end)



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
