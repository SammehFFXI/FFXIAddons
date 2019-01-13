packets = require('packets')

function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	windower.add_to_chat(4,'F11: Auto RA')
	windower.add_to_chat(4,'ALT  F11: WS Selection')
	windower.add_to_chat(4,'CTRL F11: Auto WS')
	-- for Auto RA
	rngdelay = 1
	
    state.IdleMode:options('Normal','PDT')
	state.TPMode = M{['description']='TP Mode', 'Normal','RACC'}
	state.RngMode = M{['description']='Ranger Mode', 'Fail-Not','Yoichinoyumi','Fomalhaut','Armageddon','XBow'}
	state.Bolt = M{['description']='Bolt Mode','Normal','DefDown','Holy Bolt','Bloody Bolt'}
	state.AutoRA = M{['description']='Auto RA','false','true'}
	state.AutoWSMode = M{['description']='Auto WS Mode','false','true'}
	state.AutoWS = M{['description']='Auto WS',"Last Stand","Trueflight","Jishnu's Radiance"}
    state.AutoDoubleShot = M{['description']='Auto Doubleshot','true','false'}
	state.Arrow = M{['description']='Arrow Mode','Normal'}
	state.Bullet = M{['description']='Bullet','Normal','Stun'}
	
	send_command('alias tp gs c cycle tpmode')
	send_command('alias rngmode gs c cycle rngmode')
	send_command('alias boltmode gs c cycle Bolt')
	send_command('bind f9 gs c cycle RngMode')
	send_command('bind !f9 gs c cycle Arrow')
	send_command('bind ^f9 gs c cycle Bolt')
	send_command('bind ^f10 gs c cycle Bullet')
    send_command('bind f10 gs c cycle idlemode')
	send_command('bind f11 gs c cycle AutoRA')
	send_command('bind ^f11 gs c cycle AutoWSMode')
	send_command('bind !f11 gs c cycle AutoWS')
	send_command('bind f12 gs c wslist')
    send_command('bind ^f12 gs c cycle AutoDoubleShot')
	send_command("alias g11_m2g16 gs c ws 1")
	send_command("alias g11_m2g17 gs c ws 2")
	send_command("alias g11_m2g18 gs c ws 3")
	select_default_macro_book()
	if player.sub_job == 'NIN' then
	-- send_command('@wait 1;input /equip sub "Perun"')   
	end
	send_command('@wait 1;input /lockstyleset 22')
	
	
	-- Set Common Aliases --
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias preshot gs equip sets.precast.PreShot")
	send_command("alias rngtp gs equip sets.midcast.TP.normal")
	send_command("alias rngtpacc gs equip sets.midcast.TP.RACC")
	send_command("alias wsset gs equip sets.precast.WS")
	send_command("alias agiwsset gs equip sets.precast.WS['Last Stand']")
	send_command("alias mwsset gs equip sets.precast.WS['Trueflight']")
	send_command("alias jr gs equip sets.Jishnus")
	
	add_to_chat(2,'Ranged Weapon:'..player.equipment.range)
	if player.equipment.range == "Yoichinoyumi" then
		send_command("gs c set RngMode Yoichinoyumi")
		send_command("dp bow")
		state.AutoWS = M{['description']='Auto WS',"Jishnu's Radiance","Namas Arrow"}
	elseif player.equipment.range == "Fail-Not" then
		send_command("gs c set RngMode Fail-Not")
		send_command("dp bow") 
		state.AutoWS = M{['description']='Auto WS',"Jishnu's Radiance","Apex Arrow"}
	elseif player.equipment.range == "Fomalhaut" then
		send_command("gs c set RngMode Fomalhaut")
		send_command("dp gun")
		state.AutoWS = M{['description']='Auto WS','Last Stand','Trueflight'}
	elseif player.equipment.range == "Armageddon" then
		send_command("gs c set RngMode Armageddon")
		send_command("dp gun")
		state.AutoWS = M{['description']='Auto WS','Wildfire','Last Stand','Trueflight'}
	elseif player.equipment.range == "Wochowsen" then
		send_command("gs c set RngMode XBow")
		send_command("dp marksmanship")
		state.AutoWS = M{['description']='Auto WS','Last Stand','Trueflight'}	
	end
	
	res = require 'resources'
	
	WeaponSkill = {
		["Marksmanship"] = {
			["1"] = "Wildfire",
			["2"] = "Last Stand",
			["3"] = "Trueflight"
		},
		["Archery"] = {
		    ["1"] = "Jishnu's Radiance",
			["2"] = "Namas Arrow",
			["3"] = "Apex Arrow"
		},
		
	}
	
	
end

	
function init_gear_sets()
	
	
	TP_Hands = "Meg. Gloves +2"
	
	if state.RngMode.value == 'Fail-Not' then
	  --RNGWeapon = "Yoichinoyumi"
	  RNGWeapon = "Fail-Not"
	  TP_Ammo = "Chrono Arrow"
	  WS_Ammo = "Chrono Arrow"
	  send_command("alias rngws1 input /ws 'Jishnu\'s Radiance' <t>")
	  send_command("alias rngws2 input /ws 'Namas Arrow' <t>")
	  send_command("alias rngws3 input /ws 'Apex Arrow' <t>")
	  TP_Hands = "Amini Glovelettes +1"
	elseif state.RngMode.value == 'Yoichinoyumi' then
	  RNGWeapon = "Yoichinoyumi"
	  --TP_Ammo = "Yoichi's Arrow"
	  --WS_Ammo = "Yoichi's Arrow"
	  TP_Ammo = "Chrono Arrow"
	  WS_Ammo = "Chrono Arrow"
	  send_command("alias rngws1 input /ws 'Jishnu\'s Radiance' <t>")
	  send_command("alias rngws2 input /ws 'Namas Arrow' <t>")
	  send_command("alias rngws3 input /ws 'Apex Arrow' <t>")
	  TP_Hands = "Amini Glovelettes +1"
	elseif state.RngMode.value == 'Fomalhaut' then 
	  RNGWeapon = "Fomalhaut"
	  TP_Ammo="Chrono Bullet"
	  WS_Ammo="Chrono Bullet"
	  if state.Bullet.value == 'Stun' then
		TP_Ammo="Spartan Bullet"
		WS_Ammo="Spartan Bullet"
	  end
	  TP_Hands = "Meg. Gloves +2"
	  send_command("alias rngws1 input /ws 'Wildfire' <t>")
	  send_command("alias rngws2 input /ws 'Last Stand' <t>")
	  send_command("alias rngws3 input /ws 'Trueflight' <t>")
	elseif state.RngMode.value == 'Armageddon' then 
	  RNGWeapon = "Armageddon"
	  TP_Ammo="Chrono Bullet"
	  WS_Ammo="Chrono Bullet"
	  if state.Bullet.value == 'Stun' then
		TP_Ammo="Spartan Bullet"
		WS_Ammo="Spartan Bullet"
	  end
	  TP_Hands = "Meg. Gloves +2"
	  send_command("alias rngws1 input /ws 'Wildfire' <t>")
	  send_command("alias rngws2 input /ws 'Last Stand' <t>")
	  send_command("alias rngws3 input /ws 'Trueflight' <t>")
	elseif state.RngMode.value == 'XBow' then
	  RNGWeapon = "Wochowsen"
	  TP_Ammo = "Achiyal. Bolt"
	  WS_Ammo = "Achiyal. Bolt"
	  if state.Bolt.value == 'DefDown' then 
		TP_Ammo = "Abrasion Bolt"
	  elseif state.Bolt.value == 'Holy Bolt' then
	    TP_Ammo = "Righteous Bolt"
	  elseif state.Bolt.value == 'Bloody Bolt' then
	    TP_Ammo = "Bloody Bolt"
	  end
	  send_command("alias rngws2 input /ws 'Wildfire' <t>")
	  send_command("alias rngws3 input /ws 'Slug Shot' <t>")
	  send_command("alias rngws1 input /ws 'Trueflight' <t>")
	end
	
			
    ---  PRECAST SETS  ---
    sets.precast = {}
	sets.precast.PreShot = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		head="Amini Gapette +1",  -- 6 --
		--body="Nisroch Jerkin",
		body="Oshosi Vest +1",
		hands="Carmine Fin. Ga. +1",  -- 8 --
		legs={ name="Adhemar Kecks", augments={'AGI+10','"Rapid Shot"+10','Enmity-5',}},
		--feet="Adhemar Gamashes", -- 8 -- 
		feet="Meg. Jam. +2", -- 10 -- 
		neck="Scout's Gorget +2",
		waist="Yemaya Belt",    
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		right_ring="Dingir Ring",
		left_ring="Ilabrat Ring",
		back={ name="Belenus's Cape", augments={'"Snapshot"+10',}}, -- 10 -- 
    } -- Snapshot: 47  -- Rapid Shot:16
	
	sets.precast.PreShot.Overkill = set_combine(sets.precast.PreShot, {})
	
	sets.midcast.TP = {} 
	sets.midcast.TP.normal = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		head="Arcadian Beret +2",
		body="Nisroch Jerkin",
		hands=TP_Hands,
		legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		feet="Adhemar Gamashes",
		neck="Scout's Gorget +2",
		waist="Yemaya Belt",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		right_ring="Dingir Ring",
		left_ring="Ilabrat Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.midcast.TP.DoubleShotArmageddon = {
	    --head={ name="Arcadian Beret +2", augments={'Enhances "Recycle" effect',}},
		--head="Meghanada Visor +2",
		head="Oshosi Mask +1",
		body={ name="Arc. Jerkin +3", augments={'Enhances "Snapshot" effect',}},
		
		--hands="Mummu Wrists +2",
		hands="Oshosi Gloves +1",
		--legs="Mummu Kecks +2",
        legs="Oshosi Trousers +1",
		feet="Osh. Leggings +1",
        neck="Scout's Gorget +2",
		--waist="Yemaya Belt",
		waist="K. Kachina Belt +1",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		--left_ring="Mummu Ring",
        left_ring="Ilabrat Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}},
	}
	sets.midcast.TP.ArmageddonAftermath = {
	    --head="Meghanada Visor +2",
		head="Oshosi Mask +1",
		body="Nisroch Jerkin",
		--hands="Mummu Wrists +2",
		hands="Oshosi Gloves +1",
		--legs="Mummu Kecks +2",
        legs="Oshosi Trousers +1",
		-- feet="Thereoid Greaves",
		feet="Osh. Leggings +1",
		--neck="Iskur Gorget",
        neck="Scout's Gorget +2",
		--waist="Yemaya Belt",
		waist="K. Kachina Belt +1",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		--left_ring="Mummu Ring",
        left_ring="Ilabrat Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}},
	}
	sets.midcast.TP.RACC = {
		range=RNGWeapon,
		ammo=TP_Ammo,
		head="Orion Beret +3",
        body="Orion Jerkin +2",
        hands="Orion Bracers +3",
        legs={ name="Arc. Braccae +3", augments={'Enhances "Eagle Eye Shot" effect',}},
        feet="Osh. Leggings +1",
        neck="Scout's Gorget +2",
        waist="Yemaya Belt",
        left_ear="Telos Earring",
        right_ear="Enervating Earring",
        left_ring="Regal Ring",
        right_ring="Cacoethic Ring +1",
        back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.Barrage = {
	    head="Meghanada Visor +2",
		body="Nisroch Jerkin",
		hands="Orion Bracers +3",
		legs="Oshosi Trousers +1",
		feet="Osh. Leggings +1",
        neck="Scout's Gorget +2",
		waist="K. Kachina Belt +1",
		left_ear="Telos Earring",
		right_ear="Enervating Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
    
	--Job Abilities
	sets.precast.JA = {}
    sets.precast.JA.Scavenge = {feet="Orion Socks +1"}
	sets.precast.JA.Sharpshot = {legs="Orion Braccae +1"}
	sets.precast.JA['Bounty Shot'] = { hands="Amini Glove. +1"}
    sets.precast.JA.Camouflage = {body="Orion Jerkin +2"}
    sets.precast.JA['Eagle Eye Shot'] = {}
    sets.precast.JA.Shadowbind = {}
    sets.precast.JA.Sharpshot = {}
 
	-- WS Sets
	sets.precast.WS = {
	    ammo=TP_Ammo,
		head="Orion Beret +3",
		--head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body="Nisroch Jerkin",
		hands="Meg. Gloves +2",
		--legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
		--legs="Amini Brague +1",
        legs="Arc. Braccae +3",
		feet={ name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +2%','Rng.Acc.+1','Rng.Atk.+9',}},
        neck="Scout's Gorget +2",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Last Stand'] = {
	    head="Orion Beret +3",
		body="Nisroch Jerkin",
		hands="Meg. Gloves +2",
		--legs={ name="Adhemar Kecks", augments={'AGI+10','Rng.Acc.+15','Rng.Atk.+15',}},
        legs="Arc. Braccae +3",
		feet={ name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +2%','Rng.Acc.+1','Rng.Atk.+9',}},
		--neck="Fotia Gorget",
        neck="Scout's Gorget +2",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Jishnu\'s Radiance'] = {
		ammo=TP_Ammo,
		--head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		head="Orion Beret +3",
		body="Meg. Cuirie +2",
		hands="Meg. Gloves +2",
		--legs="Darraigner's Brais",
        legs="Arc. Braccae +3",
		feet="Oshosi Leggings +1",
		--neck="Fotia Gorget",
        neck="Scout's Gorget +2",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Sherida Earring",
		left_ring="Regal Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Crit.hit rate+10',}},
	}
	sets.Jishnus = sets.precast.WS['Jishnu\'s Radiance']
	sets.precast.WS['Trueflight'] = {
		-- head="Orion Beret +3"
		ammo="Devastating Bullet",
	    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Enmity-5','VIT+6','Mag. Acc.+13','"Mag.Atk.Bns."+13',}},
		body={ name="Herculean Vest", augments={'"Mag.Atk.Bns."+26','"Dbl.Atk."+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		hands="Carmine Fin. Ga. +1",
		--legs="Gyve Trousers",
        legs="Arc. Braccae +3",
		-- feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
		feet={ name="Herculean Boots", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','"Fast Cast"+1','MND+10','Mag. Acc.+6','"Mag.Atk.Bns."+11',}},
		--neck="Fotia Gorget",
		--waist="Fotia Belt",
		--neck="Sanctity necklace",
        neck="Scout's Gorget +2",
		waist="Eschan Stone",
		left_ear="Crematio Earring",
		right_ear="Moonshade Earring",
		left_ring="Dingir Ring",
		right_ring="Weather. Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','AGI+10','Weapon skill damage +10%',}},
	}
    sets.precast.WS['Wildfire'] = sets.precast.WS['Trueflight']
	
    ---  AFTERCAST SETS  ---
    sets.idle = set_combine(sets.precast.PreShot, {feet="Skadi's Jambeaux +1"})
	sets.Idle = sets.idle
	sets.Idle.Current = sets.Idle

	
end

function job_precast(spell)
	last_precast = spell
    handle_equipping_gear(player.status)
	checkblocking(spell)
	if not buffactive["Velocity Shot"] and spell.name == "Ranged" then
	  velocity_recasttime = windower.ffxi.get_ability_recasts()[129] 
	  if velocity_recasttime == 0 then 
	    windower.add_to_chat(8,"Turn on Velocity Shot!")
	  else
	    windower.add_to_chat(8,"You need to turn on Velocity Shot!	Time Remaining: "..velocity_recasttime)
	  end
	end
	if not buffactive["Double Shot"] and spell.name == "Ranged" then
	  doubleshot_recasttime = windower.ffxi.get_ability_recasts()[126] 
	  if doubleshot_recasttime == 0 then 
        if state.AutoDoubleShot.value == 'true' then 
            cancel_spell()
            send_command('input /ja "Double Shot" <me>; wait 0.4; input /ra <t>')
            windower.add_to_chat(8,"Turning on Double Shot - then shoot!")
        else 
            windower.add_to_chat(8,"Turn on Double Shot!")
        end
        
	  end
	end
	
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('@wait 1;')
	  return
	end
    if spell.name == 'Ranged' then
        equip(sets.precast.PreShot)
        if buffactive.Overkill then
            equip(sets.precast.PreShot.Overkill)
        end
    end
end

function job_post_precast(spell)
  if spell.type == "WeaponSkill" and buffactive["Velocity Shot"] and spell.name ~= "Trueflight" and spell.name ~= "Wildfire" and (spell.skill == "Marksmanship" or spell.skill == "Archery") then
		if sets.precast.WS[spell.name] then 
			equip(set_combine(sets.precast.WS[spell.name], {body="Amini Caban +1"}))
		else
			equip(set_combine(sets.precast.WS, {body="Amini Caban +1"}))
		end
  end
	weathercheck(spell.element)
end

function job_post_midcast(spell)
    if spell.english == 'Sneak' and buffactive.sneak and spell.target.type == 'SELF' then
        send_command('@wait 1;cancel 71;')
    end
	if spell.name == 'Utsusemi: Ichi' then
	  send_command('cancel Copy Image|Copy Image (2)')
	end
	
	if spell.name == 'Ranged' then
	 if state.TPMode.value == 'Normal' then
	   equip(sets.midcast.TP.normal)
	 elseif state.TPMode.Value == 'RACC' then
	   equip(sets.midcast.TP.RACC)
	 end
	 if player.equipment.range == "Armageddon" and (buffactive["Aftermath: Lv.3"] or buffactive["Aftermath: Lv.2"] or buffactive["Aftermath: Lv.1"]) then
		equip(sets.midcast.TP.ArmageddonAftermath)
	 end
	 if buffactive['Double Shot'] and player.equipment.range == "Armageddon" and (buffactive["Aftermath: Lv.3"] or buffactive["Aftermath: Lv.2"] or buffactive["Aftermath: Lv.1"]) then
	   equip(sets.midcast.TP.DoubleShotArmageddon)
	 end
     if buffactive.Barrage then
		windower.add_to_chat(8,"Barrage Active - adding in hands")
        equip(sets.Barrage)
     end
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
    equip(sets.idle)
end

function status_change(new,tab)
	handle_equipping_gear(player.status)
    if new == 'Resting' then
        equip(sets.Resting)
    else
        equip(sets.idle)
    end
end

function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.idle)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
	init_gear_sets()
	disable_specialgear()
end



function select_default_macro_book()
    set_macro_page(4, 1)
end


 function job_self_command(command)
	if command[1]:lower() == "ws" and command[2] ~= nil then
		local EquipedGear = windower.ffxi.get_items()
		local CurrentSkill
		if EquipedGear.equipment.range == nil or EquipedGear.equipment.range == 0 then 
		  CurrentSkill = "Hand-to-Hand"
		else 
		  CurrentSkill = res.skills[res.items[windower.ffxi.get_items(EquipedGear.equipment.range_bag, EquipedGear.equipment.range).id].skill].en
		end
		send_command('input /ws '..WeaponSkill[CurrentSkill][command[2]])
	end
	if command[1]:lower() == "wslist" then
		local EquipedGear = windower.ffxi.get_items()
		local CurrentSkill
		if EquipedGear.equipment.range == nil or EquipedGear.equipment.range == 0 then 
		  CurrentSkill = "Hand-to-Hand"
		else 
          CurrentSkill = res.skills[res.items[windower.ffxi.get_items(EquipedGear.equipment.range_bag, EquipedGear.equipment.range).id].skill].en
		end
		windower.add_to_chat(2,"WS List:")
		for i,v in pairs(WeaponSkill[CurrentSkill]) do
			windower.add_to_chat(2,i..") "..v)
		end
	end    
end

windower.raw_register_event('incoming chunk', function(id,original,modified,injected,blocked)
	local self = windower.ffxi.get_player()
    if id == 0x028 then
		local packet = packets.parse('incoming', original)
		local category = packet['Category']
		if packet.Actor == self.id and category == 2 then 
			if state.AutoRA.value == 'true' then 
				if state.AutoWSMode.value == 'true' and player.tp >= 1000 then 
					send_command('wait '..rngdelay..';input /ws "'..state.AutoWS.value..'" <t>')
				else 
					send_command('wait '..rngdelay..'; input /ra <t>')
				end
			end
		end
		if packet.Actor == self.id and category == 3 and state.AutoRA.value == 'true' then 
			send_command('wait 3.5; input /ra <t>')
		end
	end
end)

--[[
windower.raw_register_event('incoming text', function(original)
	if string.contains(original,"You must wait longer") then 
		--print('Interrupted:'..last_precast.name,os.clock())
		if last_precast.name == 'Ranged' then 
			send_command('wait .5; input /ra <t>')
			return true
		end
	end
end)

]]