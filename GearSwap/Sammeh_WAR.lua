
function get_sets()
    mote_include_version = 2
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end

function user_setup()
	state.IdleMode:options('Normal','Reraise','DT','MEVA')
	send_command('bind f10 gs c cycle IdleMode')
	send_command('bind f11 gs c berserkmode')
	send_command('bind f12 gs c wslist')
	
	state.OffenseMode = M{['description']='Engaged Mode', 'Normal','Reraise','DT','MedAccuracy','HighAccuracy','ShieldBlock','MEVA'}
	state.BerserkMode = M{['description']='Berserk Mode', 'Normal','Auto'}
    state.WeaponskillMode:options('Normal','ACC')
    select_default_macro_book()
	
	-- Set Common Aliases --
	send_command("alias axe gs equip sets.axe")
	send_command("alias sword gs equip sets.sword")
	send_command("alias greatsword gs equip sets.greatsword")
	send_command("alias greataxe gs equip sets.greataxe")
	send_command("alias wsset gs equip sets.ws")
	send_command("alias mwsset gs equip sets.ws.magic")
	send_command("alias strwsset gs equip sets.ws.strbased")
	send_command("alias vitwsset gs equip sets.ws.vitbased")
	send_command("alias eng gs equip sets.engaged")
	send_command("alias enmity gs equip sets.enmity")
	send_command("alias meva gs equip sets.meva")
	send_command("alias idle gs equip sets.Idle.Current")
	send_command("alias shieldblock gs equip sets.engaged.ShieldBlock")
	--send_command('@wait 5;input /lockstyleset 15')
	--send_command('@wait 5;input /lockstyleset 27')
    send_command('@wait 5;input /lockstyleset 43')
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
		["Great Sword"] = {
			["1"] = "Resolution",
			["2"] = "Scourge",
			["3"] = "Shockwave"
		},
		["Great Axe"] = {
			["1"] = "Upheaval",
			["2"] = "King's Justice",
			["3"] = "Full Break"
		},
		["Axe"] = {
			["1"] = "Mistral Axe",
			["2"] = "Calamity",
			["3"] = "Cloudsplitter"
		},
		["Sword"] = {
			["1"] = "Savage Blade",
			["2"] = "Requiescat",
			["3"] = "Vorpal Blade"
		},
		["Club"] = {
			["1"] = "Realmrazer",
			["2"] = "Black Halo",
			["3"] = "Judgment"
		},
		["Dagger"] = {
			["1"] = "Evisceration",
			["2"] = "Aeolian Edge",
			["3"] = "Exenterator"
		},
		["Polearm"] = {
			["1"] = "Stardiver",
			["2"] = "Impulse Drive",
			["3"] = "Vorpal Thrust"
		},
		["Staff"] = {
			["1"] = "Cataclysm",
			["2"] = "Earth Crusher",
			["3"] = "Shattersoul"
		},

	}
	
end

	
function init_gear_sets()
	
	sets.greataxe = {
		main="Chango",
		sub="Utu Grip"
	}
	sets.greatsword = {
		main="Ragnarok",
		sub="Utu Grip"
	}
	sets.sword = {
		main="Reikiko",
		sub="Blurred Shield +1"
	}
	sets.axe = {
		main="Barbarity +1",
		sub="Blurred Shield +1"
	}
	
	
	sets.meva = {
		ammo="Staunch Tathlum +1",
		head="Volte Cap",
		body="Pumm. Lorica +3",
		hands="Volte Bracers",
		legs="Volte Brayettes",
		feet="Volte Sollerets",
		neck="Warder's Charm +1",
		waist="Engraved Belt",
		left_ear="Eabani Earring",
		right_ear="Flashward Earring",
		left_ring="Purity Ring",
		right_ring="Vengeful Ring",
		back={ name="Cichol's Mantle", augments={'MND+20','Eva.+20 /Mag. Eva.+20','Mag. Evasion+10','Mag. Evasion+15',}},
	}
	sets.dt = {
		ammo="Staunch Tathlum +1", --dt3
	    head="Sulevia's Mask +2", --dt6 
		body="Tartarus Platemail", --dt10
		hands="Sulev. Gauntlets +2", --dt4
		legs="Sulev. Cuisses +2", --dt7
		feet="Pumm. Calligae +3", 
		neck="Loricate Torque +1", --dt6 
		waist="Ioskeha Belt +1",
		right_ear="Telos Earring",
		left_ear="Cessance Earring",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}}, --pdt6, mdt3
		right_ring="Defending Ring", -- dt10
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	} -- pdt 48 mdt -- 48 (Shell will easily make up diff)
	sets.dtenmity = {
	    ammo="Staunch Tathlum +1",
		head="Pummeler's Mask +3",
		body={ name="Souveran Cuirass", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		hands="Pumm. Mufflers +3",
		legs="Sulev. Cuisses +2",
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		neck="Loricate Torque +1",
		waist="Flume Belt +1",
		left_ear="Cryptic Earring",
		right_ear="Trux Earring",
		left_ring="Apeile Ring +1",
		right_ring="Apeile Ring",
		back="Philidor Mantle",
	}
	sets.dtaftermath = {
		ammo="Ginsen",
	    head="Flamma Zucchetto +2",
		body="Tartarus Platemail", --dt9
		hands="Sulev. Gauntlets +2", --dt5
		legs={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','"Store TP"+6','STR+8',}},
		feet="Sulev. Leggings +2", --dt4
		neck="Loricate Torque +1", --dt6 
		waist="Ioskeha Belt +1",
		right_ear="Telos Earring",
		left_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Defending Ring", -- dt10
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	} --pdt 31 --mdt 31 (+20% aftermath DT) 
	sets.engaged = {}
	sets.engaged.Normal = {
		ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body={ name="Valorous Mail", augments={'Accuracy+20 Attack+20','"Store TP"+7','Attack+9',}},
		hands="Sulev. Gauntlets +2",
		legs={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','"Store TP"+6','STR+8',}},
		feet="Pumm. Calligae +3",
		--neck="Combatant's Torque",
        neck="Warrior's Beads",
		waist="Ioskeha Belt +1",
		right_ear="Telos Earring",
		left_ear="Cessance Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Petrov Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	
	sets.enmity = {
	    ammo="Aqreqaq Bomblet", -- 2
		head="Pummeler's Mask +3", -- 12  (+3 adds +3)
		body={ name="Souveran Cuirass", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}}, -- 17
		hands="Pumm. Mufflers +3", -- 15
		legs={ name="Odyssean Cuisses", augments={'Accuracy+22 Attack+22','"Store TP"+6','STR+8',}}, -- 4   (+8 aug) 
		feet={ name="Yorium Sabatons", augments={'Enmity+9',}}, -- 14
		neck="Unmoving Collar +1", -- 10 
		waist="Sinew belt", -- 3
		left_ear="Cryptic Earring", -- 4
		right_ear="Trux Earring", -- 5
		left_ring="Apeile Ring +1", -- 5~9
		right_ring="Apeile Ring", -- 5~9
		back="Philidor Mantle", -- 5 (jse back +5)
	} -- Enmity = 98-106
	sets.engaged.Reraise = set_combine(sets.engaged,{body="Twilight Mail",head="Twilight Helm"})
	sets.engaged.HighAccuracy = {
	    ammo="Ginsen",
		head="Pummeler's Mask +3",
		body="Pumm. Lorica +3",
		hands="Pumm. Mufflers +3",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
        neck="Warrior's Beads",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	sets.engaged.MedAccuracy = {
	    ammo="Ginsen",
		head="Flamma Zucchetto +2",
		body="Pumm. Lorica +3",
		hands="Sulev. Gauntlets +2",
		legs="Pumm. Cuisses +3",
		feet="Pumm. Calligae +3",
		neck="Warrior's Beads",
		waist="Ioskeha Belt +1",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	}
	sets.engaged.ShieldBlock = {  
		ammo="Staunch Tathlum +1",  --2
    		-- head="Sulevia's Mask +2", -- 6
			head={ name="Valorous Mask", augments={'Mag. Acc.+22','MND+8','Chance of successful block +10','Accuracy+13 Attack+13','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
    		body="Tartarus Platemail", -- 9 
    		hands="Agoge Mufflers +3", -- pdt 6
    		legs="Arjuna Breeches", -- pdt 4
    		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}}, -- pdt 5
    		neck="Loricate Torque +1", -- 6
			--neck="Combatant's Torque",
    		waist="Ioskeha Belt +1",
    		left_ear="Thureous Earring",
    		right_ear="Telos Earring",
    		left_ring="Niqmaddu Ring",
    		right_ring="Defending Ring", -- 10 
    		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},
	} -- Axe + Shield = 4 pdt + 5 DT.    Totals: DT-38, PDT-18  (total PDT: 56) (should consider swapping neck)
	sets.engaged.MEVA = sets.meva
	sets.engaged.DT = sets.dt
	sets.ws = {
		-- ammo="Seeth. Bomblet +1",
		ammo="Knobkierrie",   -- Losing 13 acc for +10 att +6WSD; not sure if that's a gr8 thing.
		head="Agoge mask +3",
		body="Pumm. Lorica +3",
		hands="Sulev. Gauntlets +2",
		legs={ name="Valor. Hose", augments={'Accuracy+29','"Dbl.Atk."+3','STR+15',}},
		feet="Sulev. Leggings +2",
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
        --head="Sulevia's Mask +2",
		body="Pumm. Lorica +3",
		right_ring="Regal Ring",
        hands={ name="Odyssean Gauntlets", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','STR+15',}},
		legs="Sulev. Cuisses +2",
		feet="Pumm. Calligae +3",
		back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10',}},
	})
	sets.ws.strbased = set_combine(sets.ws,{
	ammo="Seeth. Bomblet +1",
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
		legs="Pumm. Cuisses +3",
		feet={ name="Valorous Greaves", augments={'"Snapshot"+4','"Mag.Atk.Bns."+27','"Fast Cast"+1','Accuracy+8 Attack+8','Mag. Acc.+20 "Mag.Atk.Bns."+20',}},
		neck="Sanctity Necklace",
		waist="Eschan Stone",
		left_ear="Hermetic Earring",
		right_ear="Crematio Earring",
		left_ring="Etana Ring",
		right_ring="Weather. Ring",
		back="Argocham. Mantle",
	}
	sets.ws.wsd = {
	    ammo="Knobkierrie",
		head="Agoge mask +3",
		body="Pumm. Lorica +3",
		--hands={ name="Argosy Mufflers +1", augments={'STR+20','"Dbl.Atk."+3','Haste+3%',}},
        hands={ name="Odyssean Gauntlets", augments={'Accuracy+18 Attack+18','Weapon skill damage +4%','STR+15',}},
		legs={ name="Argosy Breeches +1", augments={'STR+12','DEX+12','Attack+20',}},
		feet="Sulev. Leggings +2",
		neck="Fotia Gorget",
		waist="Fotia Belt",
		left_ear="Cessance Earring",
		right_ear="Telos Earring",
		left_ring="Niqmaddu Ring",
		right_ring="Regal Ring",
		back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%',}},
	}
	
	sets.ws["King\'s Justice"] = sets.ws.strbased
	sets.ws["Fell Cleve"] = sets.ws.strbased
	sets.ws["Scourge"] = sets.ws.wsd
	sets.ws["Resolution"] = sets.ws.strbased
    --sets.ws["Resolution"] = sets.ws.wsd
    
	sets.ws["Decimation"] = sets.ws.strbased
	sets.ws["Rampage"] = sets.ws.wsd
	sets.ws["Mistral Axe"] = set_combine(sets.ws.wsd, {neck="Warrior's Beads",waist="Engraved Belt"})
	sets.ws.savageblade = set_combine(sets.ws.wsd, {neck="Warrior's Beads",waist="Engraved Belt",legs="Sulev. Cuisses +2",})
	sets.ws["Savage Blade"] = set_combine(sets.ws.wsd, {neck="Warrior's Beads",waist="Engraved Belt",legs="Sulev. Cuisses +2",})
	sets.ws["Judgment"] = sets.ws.savageblade
	sets.ws["True Strike"] = sets.ws.wsd
	sets.ws["Black Halo"] = sets.ws.savageblade
	sets.ws["Metatron Torment"] = sets.ws.wsd
	sets.ws["Upheaval"] = sets.ws.vitbased
    sets.ws["Upheaval"].ACC = {
        ammo="Knobkierrie",
        head={ name="Agoge Mask +3", augments={'Enhances "Savagery" effect',}},
        body="Pumm. Lorica +3",
        hands="Sulev. Gauntlets +2",
        legs="Pumm. Cuisses +3",
        feet="Pumm. Calligae +3",
        neck="Fotia Gorget",
        waist="Fotia Belt",
        left_ear="Cessance Earring",
        right_ear="Telos Earring",
        left_ring="Niqmaddu Ring",
        right_ring="Regal Ring",
        back={ name="Cichol's Mantle", augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','"Dbl.Atk."+10',}},
    }
	sets.ws["Cloudsplitter"] = sets.ws.magic
	sets.ws["Freezebite"] = sets.ws.magic
	sets.ws["Aeolian Edge"] = sets.ws.magic
	sets.ws["Flash Nova"] = sets.ws.magic
	sets.ws["Cataclysm"] = sets.ws.magic
	sets.ws["Earth Crusher"] = sets.ws.magic

	
    ---  PRECAST SETS  ---
	sets.precast = {}
    sets.precast.JA = set_combine(sets.enmity, {})
	sets.precast.JA.Berserk = set_combine(sets.precast.JA, {back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},body="Pumm. Lorica +3",feet="Agoge Calligae +3"})
	sets.MaxBerserk = set_combine(sets.precast.JA, {back={ name="Cichol's Mantle", augments={'STR+20','Accuracy+20 Attack+20','STR+10','"Dbl.Atk."+10',}},body="Pumm. Lorica +3",feet="Agoge Calligae +3",main="Firangi"})
	sets.precast.JA.Warcry = set_combine(sets.precast.JA, {head="Agoge mask +3"})
	sets.precast.JA.Aggressor = set_combine(sets.precast.JA, {head="Pummeler's Mask +3",body="Agoge Lorica +3"})
	sets.precast.JA['Mighty Strikes'] = set_combine(sets.precast.JA, {hands="Agoge Mufflers +3"})
	sets.precast.JA['Defender'] = set_combine(sets.precast.JA, {hands="Agoge Mufflers +3"})
	sets.precast.JA['Blood Rage'] = set_combine(sets.precast.JA, {body="Boii Lorica +1"})
	sets.precast.Restraint = set_combine(sets.precast.JA, {hands="Boii Mufflers +1"})
	sets.precast.JA.Tomahawk = set_combine(sets.precast.JA, {ammo="Thr. Tomahawk",feet="Agoge Calligae +3"})
	sets.precast.Ranged = { ammo="Dart" }


	
	sets.CurePotencyRecv = { 
		body={ name="Souveran Cuirass", augments={'HP+80','Enmity+7','Potency of "Cure" effect received +10%',}},
		legs={ name="Souv. Diechlings +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
		feet={ name="Souveran Schuhs +1", augments={'HP+105','Enmity+9','Potency of "Cure" effect received +15%',}},
    }
	
	sets.precast.WS = sets.ws
	
	sets.precast.FastCast = {
		ammo="Impatiens",
		head={ name="Odyssean Helm", augments={'Mag. Acc.+19','"Fast Cast"+6','AGI+6','"Mag.Atk.Bns."+3',}},
		body={ name="Odyss. Chestplate", augments={'Mag. Acc.+14','"Fast Cast"+5','"Mag.Atk.Bns."+6',}},
		hands={ name="Leyline Gloves", augments={'Accuracy+15','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Fast Cast"+3',}},
		legs="Arjuna Breeches",
		feet={ name="Odyssean Greaves", augments={'"Mag.Atk.Bns."+15','"Fast Cast"+4','Mag. Acc.+8',}},
		neck="Voltsurge Torque",
		waist="Flume Belt +1",
		left_ear="Loquac. Earring",
		right_ear="Enchntr. Earring +1",
		left_ring="Weather. Ring",
		right_ring="Defending Ring",
		back="Moonbeam Cape",
	}

	
    sets.midcast = {}
    
    ---  AFTERCAST SETS  ---
    sets.Idle = {
		ammo="Staunch Tathlum +1",
		head="Volte Salade",
        body="Tartarus Platemail",
		hands="Sulev. Gauntlets +2",
		legs="Volte Brayettes",
		feet="Volte Sollerets",
		neck="Bathy Choker +1",
		waist="Flume Belt +1",
		left_ear="Genmei Earring",
		right_ear="Odnowa Earring +1",
		left_ring={ name="Dark Ring", augments={'Magic dmg. taken -3%','Phys. dmg. taken -6%',}},
		right_ring="Defending Ring",
		back="Solemnity Cape",
	}
	
	sets.Idle.Current = sets.Idle
    sets.Resting = sets.Idle
	
	sets.WakeSleep = {neck="Vim Torque +1"}
	sets.ProtectBuff = {ring1="Sheltered Ring"}

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
    elseif string.find(spell.name,'Cur') and spell.name ~= 'Cursna' then
        equip(sets.precast.Cure)
    elseif spell.skill == 'EnhancingMagic' then
        equip(sets.precast.EnhancingMagic)
    elseif spell.action_type == 'Magic' then
        equip(sets.precast.FastCast)
    end
	if spell.name == 'Ranged' then
		equip(sets.precast.Ranged)
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
    if (world.time >= (17*60) or world.time < (7*60)) and spell.type == 'WeaponSkill' then
        equip({right_ear="Lugra Earring +1"})
    end
end

function job_midcast(spell)
	if spell.name == 'Ranged' then
		equip(sets.precast.Ranged)
	end	
	if spell.action_type == 'Magic' then 
		equip(sets.dtenmity)
	end
	if spell.name:contains('Utsusemi') then
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

function job_post_aftercast(spell)
	if spell.type == "WeaponSkill" and state.BerserkMode.value == "Auto" and windower.ffxi.get_ability_recasts()[1] == 0 then
	   currentMain = player.equipment.main
	   currentSub = player.equipment.sub
	   windower.add_to_chat("Current Equipment: "..currentMain.." "..currentSub)
	   equip(sets.MaxBerserk)
	   send_command("@wait 2.5;input /ja Berserk <me>")
	end
	if spell.name == "Berserk" and state.BerserkMode.value == "Auto" and currentMain and currentSub then
		equip({main=currentMain,sub=currentSub})
	end
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
	if command[1]:lower() == "berserkmode" then
	   currentMain = player.equipment.main
	   currentSub = player.equipment.sub
	   send_command('gs c cycle BerserkMode')
	end
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
	elseif state.IdleMode.value == "MEVA" or state.OffenseMode.value == "MEVA" then
		sets.Idle.Current = sets.meva
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
