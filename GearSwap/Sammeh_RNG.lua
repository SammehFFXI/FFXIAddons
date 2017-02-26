
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
    state.IdleMode:options('Normal','PDT')
	state.TPMode = M{['description']='TP Mode', 'Normal','RACC'}
	state.RngMode = M{['description']='Ranger Mode', 'Archery','Gun','XBow'}
	state.Bolt = M{['description']='Bolt Mode','Normal','DefDown','Holy Bolt','Bloody Bolt'}
	state.Arrow = M{['description']='Arrow Mode','Normal','Bodkin'}
	state.Bullet = M{['description']='Bullet','Normal','Stun'}
	
	send_command('alias tp gs c cycle tpmode')
	send_command('alias rngmode gs c cycle rngmode')
	send_command('alias boltmode gs c cycle Bolt')
	send_command('bind f9 gs c cycle RngMode')
	send_command('bind !f9 gs c cycle Arrow')
	send_command('bind ^f9 gs c cycle Bolt')
	send_command('bind ^f10 gs c cycle Bullet')
    send_command('bind f10 gs c cycle idlemode')
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
	send_command("alias mwsset gs equip sets.precast.WS['Trueflight']")
	send_command("alias jr gs equip sets.Jishnus")
	
	add_to_chat(2,'Ranged Weapon:'..player.equipment.range)
	if player.equipment.range == "Yoichinoyumi" then
		send_command("gs c set RngMode Archery")
		send_command("dp bow")
	elseif player.equipment.range == "Fomalhaut" then
		send_command("gs c set RngMode Gun")
		send_command("dp gun")
	elseif player.equipment.range == "Wochowsen" then
		send_command("gs c set RngMode XBow")
		send_command("dp marksmanship")
	end
	
end

	
function init_gear_sets()
	
	
	TP_Hands = { name="Herculean Gloves", augments={'Rng.Acc.+15 Rng.Atk.+15','Weapon skill damage +2%','DEX+9','Rng.Atk.+15',}}
	
	if state.RngMode.value == 'Archery' then
	  -- RNGWeapon = { name="Teller", augments={'STR+4','Rng.Acc.+30','Rng.Atk.+29','DMG:+13',}}
	  RNGWeapon = "Yoichinoyumi"
	  TP_Ammo = "Yoichi's Arrow"
	  WS_Ammo = "Yoichi's Arrow"
	  if state.Arrow.value == 'Bodkin' then
	    TP_Ammo = "Bodkin Arrow"
		WS_Ammo = "Bodkin Arrow"
	  end
	  send_command("alias rngws1 input /ws 'Jishnu\'s Radiance' <t>")
	  send_command("alias rngws2 input /ws 'Namas Arrow' <t>")
	  send_command("alias rngws3 input /ws 'Apex Arrow' <t>")
	  TP_Hands = "Amini Glovelettes +1"
	elseif state.RngMode.value == 'Gun' then 
	  RNGWeapon = "Fomalhaut"
	  TP_Ammo="Chrono Bullet"
	  WS_Ammo="Chrono Bullet"
	  if state.Bullet.value == 'Stun' then
		TP_Ammo="Spartan Bullet"
		WS_Ammo="Spartan Bullet"
	  end
	  send_command("alias rngws1 input /ws 'Trueflight' <t>")
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
		head="Amini Gapette",  -- 6 --
		body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}}, -- 6 --
		hands="Alruna's Gloves +1",  -- 5 --
		legs="Adhemar Kecks",  -- 9 -- 
		feet="Adhemar Gamashes", -- 8 -- 
		neck="Combatant's Torque",
		waist="Yemaya Belt",    
		left_ear="Neritic Earring",
		right_ear="Enervating Earring",
		left_ring="Dingir Ring",
		right_ring="Rajas Ring",
		back={ name="Belenus's Cape", augments={'"Snapshot"+10',}}, -- 10 -- 
    }
	sets.precast.PreShot.Overkill = set_combine(sets.precast.PreShot, {})
	
	sets.midcast.TP = {} 
	sets.midcast.TP.normal = {
	    range=RNGWeapon,
		ammo=TP_Ammo,
		head="Arcadian Beret +1",
		body={ name="Pursuer's Doublet", augments={'HP+50','Crit. hit rate+4%','"Snapshot"+6',}},
		hands=TP_Hands,
		legs="Adhemar Kecks",
		feet="Adhemar Gamashes",
		neck="Combatant's Torque",
		waist="Yemaya Belt",
		left_ear="Neritic Earring",
		right_ear="Enervating Earring",
		left_ring="Dingir Ring",
		right_ring="Rajas Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.midcast.TP.RACC = {
		head="Meghanada Visor +1",
		body="Meg. Cuirie +1",
		hands="Meg. Gloves +1",
		legs="Meg. Chausses +1",
		feet="Meg. Jam. +1",
		neck="Combatant's Torque",
		waist="Yemaya Belt",
		left_ear="Neritic Earring",
		right_ear="Enervating Earring",
		left_ring="Cacoethic Ring",
		right_ring="Cacoethic Ring +1",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','"Store TP"+10',}},
	}
	sets.Barrage = {hands="Orion Bracers +1"}
    
	--Job Abilities
	sets.precast.JA = {}
    sets.precast.JA.Scavenge = {feet="Orion Socks +1"}
	sets.precast.JA.Sharpshot = {hands="Orion Braccae +1"}
	sets.precast.JA['Bounty Shot'] = { hands="Amini Glove. +1"}
    sets.precast.JA.Camouflage = {body="Orion Jerkin +1"}
    sets.precast.JA['Eagle Eye Shot'] = {}
    sets.precast.JA.Shadowbind = {}
    sets.precast.JA.Sharpshot = {}
     
	-- sets.precast.FastCast = {main=FC_Main,sub=FC_sub,ammo=FC_ammo,head=FC_head,neck=FC_neck,ear1=FC_ear1,ear2=FC_ear2,body=FC_body,hands=FC_hands,ring1=FC_ring1,ring2=FC_ring2,back=FC_back,waist=FC_waist,legs=FC_legs,feet=FC_feet}
    
	-- WS Sets
	sets.precast.WS = {
	    ammo=TP_Ammo,
		head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body={ name="Herculean Vest", augments={'Rng.Acc.+23 Rng.Atk.+23','Weapon skill damage +3%','Rng.Atk.+9',}},
		hands="Meg. Gloves +1",
		--legs="Adhemar Kecks",
		legs="Amini Brague +1",
		feet={ name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +2%','Rng.Acc.+1','Rng.Atk.+9',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",
		left_ring="Apate Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
	sets.precast.WS['Jishnu\'s Radiance'] = {
		ammo=TP_Ammo,
		head={ name="Herculean Helm", augments={'Rng.Acc.+28','Weapon skill damage +3%','DEX+11','Rng.Atk.+12',}},
		body="Meg. Cuirie +1",
		hands="Meg. Gloves +1",
		legs="Amini Brague +1",  -- have a crit hit dmg herc legs - may be good
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Moonshade Earring",
		right_ear="Enervating Earring",  --- maybe a dex earring?
		left_ring="Apate Ring",
		right_ring="Dingir Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
		-- change back to Belenus's cape w/ dex+30, crit hit rate +10%
		feet="Thereoid Greaves",
	}
	sets.Jishnus = sets.precast.WS['Jishnu\'s Radiance']
	sets.precast.WS['Trueflight'] = {
	    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Enmity-5','VIT+6','Mag. Acc.+13','"Mag.Atk.Bns."+13',}},
		body={ name="Herculean Vest", augments={'"Mag.Atk.Bns."+26','"Dbl.Atk."+2','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		hands="Leyline Gloves",
		legs="Gyve Trousers",
		feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Crematio Earring",
		right_ear={ name="Moonshade Earring", augments={'MP+25','TP Bonus +25',}},
		left_ring="Dingir Ring",
		right_ring="Weather. Ring",
		back={ name="Belenus's Cape", augments={'AGI+20','Rng.Acc.+20 Rng.Atk.+20','Weapon skill damage +10%',}},
	}
    sets.precast.WS['Wildfire'] = sets.precast.WS['Trueflight']
	
    ---  AFTERCAST SETS  ---
    sets.idle = set_combine(sets.precast.PreShot, {feet="Jute Boots +1"})
	sets.Idle = sets.idle
	sets.Idle.Current = sets.Idle

	
end

function job_precast(spell)
    handle_equipping_gear(player.status)
	checkblocking(spell)
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
	if spell.type == "WeaponSkill" and buffactive["Velocity Shot"] then
	    if sets.precast.WS[spell.name] then 
			equip(set_combine(sets.precast.WS[spell.name], {body="Amini Caban +1"}))
		else
			equip(set_combine(sets.precast.WS, {body="Amini Caban +1"}))
		end
	end
	--[[if spell.type == "WeaponSkill" and state.TPMode.value == 'RACC' then
		if sets.precast.WS[spell.name].RACC then 
			equip(sets.precast.WS[spell.name].RACC)
		else
			equip(sets.precast.WS.RACC)
		end
	end]]
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
     if buffactive.Barrage then
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
