
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
end

function user_setup()
	state.IdleMode:options('Normal','FastPants')
    state.ShieldMode = M{['description']='Shield Mode', 'Aegis', 'Ochain'} -- ,'Priwen' }
	-- state.EngagedMode = M{['description']='Engaged Mode', 'Normal','ACC','ExtraMDT' }
	send_command('bind f9 gs c cycle ShieldMode')
    send_command('bind f10 gs c cycle IdleMode')
	select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias fc gs equip sets.precast.FastCast")
	send_command("alias enh gs equip sets.midcast['Enhancing Magic']")
	send_command("alias enm gs equip sets.enmity")
	send_command("alias cureset gs equip sets.midcast.Cure")
	send_command("alias wsset gs equip sets.ws")
	send_command("alias eng gs equip sets.engaged")
	
	
end

	
function init_gear_sets()
    -- Setting up Gear As Variables --

	-- Idle Sets
	
	idle_ranged=""
	idle_ammo="Homiliary"
	idle_head="Loess Barbuta +1"
	idle_neck="Loricate Torque +1"
	idle_ear1="Cessance Earring"
	idle_ear2="Thureous Earring"
	idle_body={ name="Souveran Cuirass", augments={'VIT+10','Attack+20','"Refresh"+2',}}
	idle_hands={ name="Odyssean Gauntlets", augments={'Accuracy+25 Attack+25','Potency of "Cure" effect received+3%','AGI+6','Accuracy+10','Attack+4',}}
	idle_ring1="Supershear Ring"
	idle_ring2="Defending Ring"
	idle_back="Agema Cape"
	idle_waist="Flume Belt +1"
	idle_legs={ name="Valor. Hose", augments={'Accuracy+20 Attack+20','Phys. dmg. taken -4%','DEX+1','Accuracy+15','Attack+12',}}
	idle_feet={ name="Valorous Greaves", augments={'Accuracy+25 Attack+25','STR+5','Accuracy+1',}}
	
	idle_fastpants_legs="Crimson Cuisses"
	
	
	-- Precast Section
	FC_ranged=""
	FC_ammo="Incantor Stone"
	FC_head={ name="Jumalik Helm", augments={'MND+7','"Mag.Atk.Bns."+12','Magic burst dmg.+7%',}}
	FC_neck="Voltsurge Torque"
	FC_ear1="Loquacious earring"
	FC_ear2="Enchntr. Earring +1"
	FC_body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}}
	FC_hands={ name="Leyline Gloves", augments={'Accuracy+12','Mag. Acc.+10','"Mag.Atk.Bns."+1',}}
	FC_ring1="Kishar Ring"
	FC_ring2="Weather. Ring"
	FC_back="Agema Cape"
	FC_waist="Flume Belt +1"
	FC_legs={ name="Valor. Hose", augments={'Accuracy+20 Attack+20','Phys. dmg. taken -4%','DEX+1','Accuracy+15','Attack+12',}}
	FC_feet={ name="Odyssean Greaves", augments={'Attack+15','Weapon skill damage +3%','AGI+12',}}

	FC_enh_waist="Siegel Sash"
	
	FC_cure_legs=FC_legs
	FC_cure_feet=FC_feet
	FC_Cure_back=FC_back

	-- Midcast Section
	enh_ranged=""
	enh_ammo=""
	enh_head=""
	enh_neck="Incanter's Torque"
	enh_ear1=FC_ear1
	enh_ear2=FC_ear2
	enh_body=""
	enh_hands=""
	enh_ring1="Kishar Ring"
	enh_ring2="Weather. Ring"
	enh_back=""
	enh_waist=""
	enh_legs=""
	enh_feet=""
	
	
    enm_ranged=""
	enm_ammo="Homiliary"
	enm_head="Reverence Coronet +1"  -- 5 --
	enm_neck="Unmoving Collar +1" -- 10 -- 
	enm_ear1="Trux Earring" -- 5 --
	enm_ear2="Thureous Earring"
	enm_body={ name="Souveran Cuirass", augments={'VIT+10','Attack+20','"Refresh"+2',}} -- 10 -- 
	enm_hands="Macabre Gaunt." -- 6 -- 
	enm_ring1="Supershear Ring" -- 5 -- 
	enm_ring2="Apeile Ring" -- 5 -- 
	enm_back="Agema Cape" -- 5 -- 
	enm_waist="Creed Baudrier" -- 5 -- 
	enm_legs={ name="Cab. Breeches +1", augments={'Enhances "Invincible" effect',}} -- 6 --
	enm_feet={ name="Yorium Sabatons", augments={'Enmity+9',}} -- 13 -- 
	
	engaged_ranged=""
	engaged_ammo="Hasty Pinion +1"
	engaged_head="Loess Barbuta +1"
	engaged_neck="Loricate Torque +1"
	engaged_ear1="Cessance Earring"
	engaged_ear2="Thureous Earring"
	engaged_body="Sulevia's Plate. +1"
	engaged_hands="Sulev. Gauntlets +1"
	engaged_ring1="Supershear Ring"
	engaged_ring2="Defending Ring"
	engaged_back="Agema Cape"
	-- engaged_back="Philidor Mantle"
	engaged_waist="Anguinus Belt"
	engaged_legs="Sulevi. Cuisses +1"
	engaged_legs="Sulev. Leggings +1"
	
	ws_ranged=""
	ws_ammo="Hasty Pinion +1"
	ws_head={ name="Valorous Mask", augments={'Accuracy+24 Attack+24','"Store TP"+1','AGI+1','Attack+8',}}
	ws_neck="Fotia Gorget"
	ws_ear1="Cessance Earring"
	ws_ear2="Digni. Earring"
	ws_body={ name="Valorous Mail", augments={'Accuracy+22 Attack+22','Weapon Skill Acc.+9','STR+2','Accuracy+14','Attack+10',}}
	ws_hands={ name="Odyssean Gauntlets", augments={'Accuracy+25 Attack+25','Potency of "Cure" effect received+3%','AGI+6','Accuracy+10','Attack+4',}}
	ws_ring1="Supershear Ring"
	ws_ring2="Etana Ring"
	ws_back="Agema Cape"
	ws_waist="Fotia Belt"
	ws_legs="Sulevia'a Cuisses +1"
	ws_feet="Sulevia's Leggings +1"
	
		
	cure_ammo="Homiliary"
	cure_head="Loess Barbuta +1"
	cure_neck="Loricate Torque +1"
	cure_ear1=FC_ear1
	cure_ear2="Nourish. Earring"
	cure_body={ name="Jumalik Mail", augments={'HP+50','Attack+15','Enmity+9','"Refresh"+2',}}
	cure_hands="Macabre Gaunt."
	cure_ring1="Dark Ring"
	cure_ring2="Defending Ring"
	cure_back="Agema Cape"
	cure_waist="Flume Belt +1"
	cure_legs={ name="Valor. Hose", augments={'Accuracy+20 Attack+20','Phys. dmg. taken -4%','DEX+1','Accuracy+15','Attack+12',}}
	cure_feet={ name="Odyssean Greaves", augments={'Attack+15','Weapon skill damage +3%','AGI+12',}}

	
	curepotrec_waist="Gishdubar Sash"
	
	   
	sets.enmity = {ammo=enm_ammo,head=enm_head,neck=enm_neck,ear1=enm_ear1,ear2=enm_ear2,body=enm_body,hands=enm_hands,ring1=enm_ring1,ring2=enm_ring2,back=enm_back,waist=enm_waist,legs=enm_legs,feet=enm_feet}
	sets.engaged = {ammo=engaged_ammo,head=engaged_head,body=engaged_body,hands=engaged_hands,legs=engaged_legs,feet=engaged_feet,neck=engaged_neck,waist=engaged_waist,ear1=engaged_ear1,ear2=engaged_ear2,ring1=engaged_ring1,ring2=engaged_ring2,back=engaged_back,}
	sets.ws = {ammo=ws_ammo,head=ws_head,body=ws_body,hands=ws_hands,legs=ws_legs,feet=ws_feet,neck=ws_neck,waist=ws_waist,ear1=ws_ear1,ear2=ws_ear2,ring1=ws_ring1,ring2=ws_ring2,back=ws_back,}
	
	
    ---  PRECAST SETS  ---
	sets.precast = {}
    sets.precast.JA = set_combine(sets.midcast.enmity, {})
    sets.precast.JA.Enlightenment = set_combine(sets.midcast.enmity, {body=enlightenment_body})
    sets.precast.FastCast = {ammo=FC_ammo,head=FC_head,neck=FC_neck,ear1=FC_ear1,ear2=FC_ear2,body=FC_body,hands=FC_hands,ring1=FC_ring1,ring2=FC_ring2,back=FC_back,waist=FC_waist,legs=FC_legs,feet=FC_feet}
    sets.precast.EnhancingMagic = set_combine(sets.precast.Fastcast,{waist=FC_enh_waist})
    sets.precast.Cure = set_combine(sets.precast.FastCast,{back=FC_cure_back,legs=FC_cure_legs,feet=FC_cure_feet})
	
	
	-- WS Sets
	sets.precast.WS = sets.ws
	
    ---  MIDCAST SETS  ---
    sets.midcast = {}
    sets.midcast['Healing Magic'] = {ammo=cure_ammo,head=cure_head,neck=cure_neck,ear1=cure_ear1,ear2=cure_ear2,body=cure_body,hands=cure_hands,ring1=cure_ring1,ring2=cure_ring2,back=cure_back,waist=cure_waist,legs=cure_legs,feet=cure_feet}
    sets.midcast['Enhancing Magic'] = {ammo=enh_ammo,head=enh_head,neck=enh_neck,ear1=enh_ear1,ear2=enh_ear2,body=enh_body,hands=enh_hands,ring1=enh_ring1,ring2=enh_ring2,back=enh_back,waist=enh_waist,legs=enh_legs,feet=enh_feet}
	sets.midcast['Divine Magic'] = set_combine(sets.midcast.enmity, {})
    sets.midcast.Cure = {ammo=cure_ammo,head=cure_head,neck=cure_neck,ear1=cure_ear1,ear2=cure_ear2,body=cure_body,hands=cure_hands,ring1=cure_ring1,ring2=cure_ring2,back=cure_back,waist=cure_waist,legs=cure_legs,feet=cure_feet}
	sets.midcast.CurePotencyRecieved = set_combine(sets.midcast.Cure, {waist=curepotrec_waist})
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {ammo=idle_ammo,head=idle_head,neck=idle_neck,ear1=idle_ear1,ear2=idle_ear2,body=idle_body,hands=idle_hands,ring1=idle_ring1,ring2=idle_ring2,back=idle_back,waist=idle_waist,legs=idle_legs,feet=idle_feet}
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle

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
    if string.find(spell.english,'Cur') then 
        equip(sets.midcast.Cure)
		if spell.target.type == 'SELF' then
		 equip(sets.midcast.CurePotencyRecieved)
		end
    elseif spell.skill == 'Enhancing Magic' then
        equip(sets.midcast.EnhancingMagic)
    else
        equip(sets.midcast[spell.skill])
    end
	if spell.name == 'Utsusemi: Ichi' then
	  send_command('cancel Copy Image|Copy Image (2)')
	end
end        

function job_aftercast(spell)
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
    equip(sets.Idle.Current)
end


function job_state_change(stateField, newValue, oldValue)
    job_handle_equipping_gear(player.status)
	equip(sets.Idle.Current)
end


function job_handle_equipping_gear(playerStatus, eventArgs)    	
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
	if state.ShieldMode.value == "Priwen" then
	   equip({sub="Priwen"})
    elseif state.ShieldMode.value == "Ochain" then
	   equip({sub="Ochain"})
	elseif state.ShieldMode.value == "Aegis" then
	   equip({sub="Aegis"})
	end	
	if state.IdleMode.value == "FastPants" then
	   sets.Idle.Current = set_combine(sets.Idle,{legs=idle_fastpants_legs})   
	else 
	   sets.Idle.Current = set_combine(sets.Idle,{legs=idle_legs})
	end
	if playerStatus == 'Idle' then
        equip(sets.Idle.Current)
    end
	
end



function select_default_macro_book()
    send_command('input /echo ------- Loading Default Paladin Set.   -------')
	send_command('input /echo ------- F9: ShieldMode || F10: IdleSet -------')
    set_macro_page(6, 1)
end
