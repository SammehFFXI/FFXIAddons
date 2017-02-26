-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

--[[
    Custom commands:
    
    ExtraSongsMode may take one of three values: None, Dummy, FullLength
    
    You can set these via the standard 'set' and 'cycle' self-commands.  EG:
    gs c cycle ExtraSongsMode
    gs c set ExtraSongsMode Dummy
    
    The Dummy state will equip the bonus song instrument and ensure non-duration gear is equipped.
    The FullLength state will simply equip the bonus song instrument on top of standard gear.
    
    
    Simple macro to cast a dummy Daurdabla song:
    /console gs c set ExtraSongsMode Dummy
    /ma "Shining Fantasia" <me>
    
    To use a Terpander rather than Daurdabla, set the info.ExtraSongInstrument variable to
    'Terpander', and info.ExtraSongs to 1.
--]]

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('sammeh_custom_functions.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.ExtraSongsMode = M{['description']='Extra Songs', 'None', 'FullLength', 'Dummy'}
    state.Buff['Pianissimo'] = buffactive['pianissimo'] or false
	
	send_command("alias buff gs equip sets.midcast.SongEffect")
    send_command("alias debuff gs equip sets.midcast.SongDebuff")
	send_command("alias macc gs equip sets.midcast.ResistantSongDebuff")
	send_command("alias lul gs equip sets.midcast.LullabyFull")
	send_command("alias fc gs equip sets.precast.FastCast.BardSong")
    -- For tracking current recast timers via the Timers plugin.
    custom_timers = {}
end

-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('None', 'Normal')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT')

    --brd_daggers = S{'Izhiikoh', 'Vanir Knife', 'Atoyac', 'Aphotic Kukri', 'Sabebus'}
    --pick_tp_weapon()
    
    -- Adjust this if using the Terpander (new +song instrument)
    info.ExtraSongInstrument = 'Terpander'
    -- How many extra songs we can keep from Daurdabla/Terpander
    info.ExtraSongs = 1
	
	-- If Max Job Points - adds alot of timers to the custom timers
	MaxJobPoints = 1
    
    -- Set this to false if you don't want to use custom timers.
    state.UseCustomTimers = M(true, 'Use Custom Timers')
    
    -- Additional local binds
    send_command('bind ^` gs c cycle ExtraSongsMode')
    send_command('bind !` input /ma "Chocobo Mazurka" <me>')

    select_default_macro_book()
	send_command('@wait 1;input /lockstyleset 40')
end


-- Called when this job file is unloaded (eg: job change)
function user_unload()
    send_command('unbind ^`')
    send_command('unbind !`')
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets

    -- Fast cast sets for spells
    sets.precast.FastCast = {head="Vanya Hood",
		neck="Voltsurge Torque",ear1="Loquacious earring",ear2="Enchntr. Earring +1",
		body="Shango Robe",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Weather. Ring",
		back="Intarabus's Cape",waist="Witful Belt",}

    sets.precast.FastCast.Cure = set_combine(sets.precast.FastCast, {back="Pahtli Cape",legs="Doyen Pants"})

    sets.precast.FastCast.Stoneskin = set_combine(sets.precast.FastCast, {head="Umuthi Hat",legs="Doyen Pants"})

    sets.precast.FastCast['Enhancing Magic'] = set_combine(sets.precast.FastCast, {waist="Witful Belt"})

    sets.precast.FastCast.BardSong = {
    	main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},Sub="Ammurapi Shield",range="Gjallarhorn",
        head="Fili Calot +1",neck="Aoidos' Matinee",ear1="Aoidos' Earring",ear2="Loquac. Earring",
        hands="Gendewitha Gages +1",ring1="Kishar Ring",ring2="Weather. Ring",
        back="Intarabus's Cape",waist="Witful Belt",legs="Doyen Pants",feet="Bihu Slippers",}

    sets.precast.FastCast.Daurdabla = set_combine(sets.precast.FastCast.BardSong, {range=info.ExtraSongInstrument})
        
    
    -- Precast sets to enhance JAs
    
    sets.precast.JA.Nightingale = {feet="Bihu Slippers"}
    sets.precast.JA.Troubadour = {body="Bihu Justaucorps"}
    -- sets.precast.JA['Soul Voice'] = {legs="Bihu Cannions"}

    -- Waltz set (chr and vit)
    sets.precast.Waltz = {}
    
       
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {waist="Fotia Belt"}
		
    
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Evisceration'] = set_combine(sets.precast.WS)
    sets.precast.WS['Rudras Storm'] = set_combine(sets.precast.WS, {neck="Fotia Gorget"})
    sets.precast.WS['Exenterator'] = set_combine(sets.precast.WS, {neck="Fotia Gorget"})
    sets.precast.WS['Mordant Rime'] = set_combine(sets.precast.WS)
    
    
    -- Midcast Sets

    -- General set for recast times.
    sets.midcast.FastRecast = {    head="Vanya Hood",
		neck="Voltsurge Torque",ear1="Loquacious earring",ear2="Enchntr. Earring +1",
		body="Shango Robe",hands="Gende. Gages +1",ring1="Kishar Ring",ring2="Weather. Ring",
		back="Intarabus's Cape",waist="Witful Belt",}
        
    -- Gear to enhance certain classes of songs.  No instruments added here since Linos is being used.
    sets.midcast.Ballad = {legs="Fili Rhingrave +1"}
    sets.midcast.Lullaby = {hands="Brioso Cuffs +1"}
    sets.midcast.Madrigal = {head="Fili Calot +1",back="Intarabus's Cape"}
	sets.midcast.Prelude = {back="Intarabus's Cape"}
    sets.midcast.March = {hands="Fili Manchettes +1"}
	sets.midcast.HonorMarch = {hands="Fili Manchettes +1",range="Marsyas"}
    sets.midcast.Minuet = {body="Fili Hongreline +1"}
    sets.midcast.Minne = {}
    sets.midcast.Paeon = {head="Brioso Roundlet +1"}
    sets.midcast.Carol = {}
    sets.midcast["Sentinel's Scherzo"] = {feet="Fili Cothurnes +1"}
    sets.midcast['Magic Finale'] = {neck="Sanctity Necklace",waist="Luminary Sash",legs="Fili Rhingrave +1"}

    sets.midcast.Mazurka = {}
    

    -- For song buffs (duration and AF3 set bonus)
    sets.midcast.SongEffect = {main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},Sub="Ammurapi Shield",range="Gjallarhorn",
        head="Fili Calot +1",body="Fili Hongreline +1",neck="Moonbow Whistle",ear1="Aoidos' Earring",ear2="Loquac. Earring",
        hands="Gendewitha Gages +1",ring1="Stikini Ring",ring2="Weather. Ring",
        back="Intarabus's Cape",waist="Witful Belt",legs="Inyanga Shalwar +1",feet="Brioso Slippers +2",}

    -- For song defbuffs (duration primary, accuracy secondary)
    sets.midcast.SongDebuff = {
	    main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},Sub="Ammurapi Shield",range="Gjallarhorn",
        head="Chironic Hat",neck="Moonbow Whistle",ear1="Digni. Earring",ear2="Enchntr. Earring +1",
        body="Fili Hongreline +1",hands="Fili Manchettes +1",ring1="Stikini Ring",ring2="Weather. Ring",
        back="Intarabus's Cape",waist="Luminary Sash",legs="Inyanga Shalwar +1",feet="Brioso Slippers +2"}

    -- For song defbuffs (accuracy primary, duration secondary)
    sets.midcast.ResistantSongDebuff = {main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},Sub="Ammurapi Shield",range="Gjallarhorn",
        head="Chironic Hat",neck="Moonbow Whistle",ear1="Digni. Earring",ear2="Enchntr. Earring +1",
        body="Chironic Doublet",hands="Fili Manchettes +1",ring1="Stikini Ring",ring2="Weather. Ring",
        back="Intarabus's Cape",waist="Luminary Sash",legs={ name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Haste+1','INT+4','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},feet="Brioso Slippers +2"}
		
	sets.midcast.LullabyFull = set_combine(sets.midcast.SongDebuff, sets.midcast.Lullaby)

    -- Song-specific recast reduction
    sets.midcast.SongRecast = {ear2="Loquacious Earring",ring1="Kishar Ring",legs="Fili Rhingrave +1"} --back="Harmony Cape",waist="Corvax Sash",

    --sets.midcast.Daurdabla = set_combine(sets.midcast.FastRecast, sets.midcast.SongRecast, {range=info.ExtraSongInstrument})

    -- Cast spell with normal gear, except using Daurdabla instead
    sets.midcast.Daurdabla = {range=info.ExtraSongInstrument}

    -- Dummy song with Daurdabla; minimize duration to make it easy to overwrite.
    sets.midcast.DaurdablaDummy = {
        main={ name="Kali", augments={'Mag. Acc.+15','String instrument skill +10','Wind instrument skill +10',}},Sub="Ammurapi Shield",range=info.ExtraSongInstrument,
        head="Fili Calot +1",neck="Aoidos' Matinee",ear1="Aoidos' Earring",ear2="Loquac. Earring",
        hands="Gendewitha Gages +1",ring1="Kishar Ring",ring2="Weather. Ring",
        back="Intarabus's Cape",waist="Witful Belt",legs="Doyen Pants",feet="Bihu Slippers",}

    -- Other general spells and classes.
    sets.midcast.Cure = {
        head="Vanya Hood",
		neck="Loricate Torque +1",ear1="Loquacious earring",ear2="Enchntr. Earring +1",
		body="Chironic Doublet",hands="Telchine Gloves",ring1="Dark Ring",ring2="Defending ring",
		back="Intarabus's Cape",waist="Fucho-no-obi",legs="Gyve Trousers",feet="Vanya Clogs"}
        
    sets.midcast.Curaga = sets.midcast.Cure
        
    sets.midcast['Enhancing Magic'] = {
        head="Vanya Hood",
		neck="Incanter's Torque",ear1="Loquacious earring",ear2="Enchntr. Earring +1",
		body="Telchine Chasuble",hands="Chironic Gloves",ring1="Kishar Ring",ring2="Weather. Ring",
		back="Intarabus's Cape",waist="Witful Belt",legs="Doyen Pants",feet="Chironic Slippers"}
    
	sets.midcast.Stoneskin = set_combine(sets.midcast['Enhancing Magic'], {waist="Siegel Sash"})
        
    sets.midcast.Cursna = sets.midcast.Cure

    
    -- Sets to return to when not performing an action.
    
    
    -- Idle sets (default idle set not needed since the other three are defined, but leaving for testing purposes)
    sets.idle = {
	main="Sangoma",
    sub="Genmei Shield",
	range="Marsyas",
	head="Gende. Caubeen +1",
		neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Genmei Earring",
		body="Gende. Bilaut +1",hands="Gende. Gages +1",ring1="Dark Ring",ring2="Defending ring",
		back="Intarabus's Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Fili Cothurnes +1"}
	sets.Idle = sets.idle
	sets.Idle.Current = sets.idle
    sets.idle.PDT = {main="Sangoma",
    sub="Genmei Shield",
	head="Gende. Caubeen +1",
		neck="Loricate Torque +1",ear1="Odnowa Earring +1",ear2="Genmei Earring",
		body="Gende. Bilaut +1",hands="Gende. Gages +1",ring1="Dark Ring",ring2="Defending ring",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Fili Cothurnes +1"}

    sets.idle.Town = {main="Sangoma",
    sub="Genmei Shield",
	range="Marsyas",
	head="Gende. Caubeen +1",
		neck="Loricate Torque +1",ear1="Digni. Earring",ear2="Enchntr. Earring +1",
		body="Gende. Bilaut +1",hands="Gende. Gages +1",ring1="Dark Ring",ring2="Defending ring",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Fili Cothurnes +1"}
    
    sets.idle.Weak = {main="Sangoma",
    sub="Genmei Shield",
	head="Gende. Caubeen +1",
		neck="Loricate Torque +1",ear1="Digni. Earring",ear2="Enchntr. Earring +1",
		body="Gende. Bilaut +1",hands="Gende. Gages +1",ring1="Dark Ring",ring2="Defending ring",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Assiduity Pants +1",feet="Fili Cothurnes +1"}
    
    
    -- Defense sets

    sets.defense.PDT = {}

    sets.defense.MDT = {}

    sets.Kiting = {feet="Fili Cothurnes +1"}

    sets.latent_refresh = {waist="Fucho-no-obi"}

    -- Engaged sets

	sets.engaged = {
	  range={ name="Linos", augments={'Accuracy+14','Sklchn.dmg.+4%','Quadruple Attack +2',}},
	  body="Onca Suit", head="Alhazen Hat +1",waist="Grunfeld Rope",Ear1="Dignitary's Earring",ear2="Cessance Earring",
	  ring1="Etana Ring",ring2="Hetairoi Ring",neck="Combatant's Torque"
	}
	
	-- Relevant Obis. Add the ones you have.
    sets.obi = {}
    sets.obi.Wind = {waist='Hachirin-no-obi'}
    sets.obi.Ice = {waist='Hachirin-no-obi'}
    sets.obi.Lightning = {waist='Hachirin-no-obi'}
    sets.obi.Light = {waist='Hachirin-no-obi'}
    sets.obi.Dark = {waist='Hachirin-no-obi'}
    sets.obi.Water = {waist='Hachirin-no-obi'}
    sets.obi.Earth = {waist='Hachirin-no-obi'}
    sets.obi.Fire = {waist='Hachirin-no-obi'}
    
	

end


-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- handle_equipping_gear(player.status)
	checkblocking(spell)
   if spell.type == 'BardSong' then
		if buffactive.Nightingale then
			local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
				windower.add_to_chat(8,'Equipping Midcast - Nightingale active.'..generalClass)
                equip(sets.midcast[generalClass])
             end
		else 
			equip(sets.precast.FastCast.BardSong)
		end
	elseif string.find(spell.name,'Cur') and spell.name ~= 'Cursna' then
		equip(sets.precast.FastCast.Cure)
	elseif spell.name == 'Stoneskin' then 
		equip(sets.precast.FastCast.Stoneskin)
	else
		equip(sets.precast.FastCast)
	end
	
	if spell.name == 'Honor March' then
        equip({ranged="Marsyas"})
	end
	
end


-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
function job_midcast(spell, action, spellMap, eventArgs)
    if spell.action_type == 'Magic' then
        if spell.type == 'BardSong' then
            -- layer general gear on first, then let default handler add song-specific gear.
            local generalClass = get_song_class(spell)
            if generalClass and sets.midcast[generalClass] then
                equip(sets.midcast[generalClass])
            end
        end
    end
	if spell.name == 'Honor March' then
        equip(sets.midcast.HonorMarch)
	end
	if buffactive['Nightengale'] and string.find(spell.name,'Lullaby') then
		equip({ranged="Marsyas"})
	end
	weathercheck(spell.element)
end

function job_post_midcast(spell, action, spellMap, eventArgs)
    if spell.type == 'BardSong' then
        if state.ExtraSongsMode.value == 'FullLength' then
            equip(sets.midcast.Daurdabla)
        end
    end
	weathercheck(spell.element)
end

-- Set eventArgs.handled to true if we don't want automatic gear equipping to be done.
function job_aftercast(spell, action, spellMap, eventArgs)
	
    if spell.type == 'BardSong' and not spell.interrupted then
        -- if spell.target and spell.target.type == 'SELF' then
		if spell.target.type ~= 'SELF' and spell.name ~= "Magic Finale" then   -- (Only using Custom Timers for debuffs; no huge reason for buffs)
            --adjust_timers(spell, spellMap)
			local dur = calculate_duration(spell, spellMap)
			send_command('timers create "'..spell.target.name..':'..spell.name..'" '..dur..' down')
        end
		state.ExtraSongsMode:reset()
    end
	
	
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------


function job_buff_change(buff, gain)
        job_update(cmdParams, eventArgs)
        handle_equipping_gear(player.status)
end



-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    handle_equipping_gear(player.status)
    if stateField == 'Offense Mode' then
        if newValue == 'Normal' then
            disable('main','sub','ammo')
        else
            enable('main','sub','ammo')
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    -- pick_tp_weapon()
end


-- Modify the default idle set after it was constructed.
function customize_idle_set(idleSet)
    if player.mpp < 51 then
        idleSet = set_combine(idleSet, sets.latent_refresh)
    end
    
    return idleSet
end


-- Function to display the current relevant user state when doing an update.
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

-- Determine the custom class to use for the given song.
function get_song_class(spell)
    -- Can't use spell.targets:contains() because this is being pulled from resources
    if set.contains(spell.targets, 'Enemy') then
        if state.CastingMode.value == 'Resistant' then
            return 'ResistantSongDebuff'
        else
            return 'SongDebuff'
        end
    elseif state.ExtraSongsMode.value == 'Dummy' then
        return 'DaurdablaDummy'
    else
        return 'SongEffect'
    end
end



--[[
Commenting Out because I don't use it ;)

-- Function to create custom buff-remaining timers with the Timers plugin,
-- keeping only the actual valid songs rather than spamming the default
-- buff remaining timers.
function adjust_timers(spell, spellMap)
    if state.UseCustomTimers.value == false then
        return
    end
    
    local current_time = os.time()
    
    -- custom_timers contains a table of song names, with the os time when they
    -- will expire.
    
    -- Eliminate songs that have already expired from our local list.
    local temp_timer_list = {}
    for song_name,expires in pairs(custom_timers) do
        if expires < current_time then
            temp_timer_list[song_name] = true
        end
    end
    for song_name,expires in pairs(temp_timer_list) do
        custom_timers[song_name] = nil
    end
    
    local dur = calculate_duration(spell, spellMap)
    if custom_timers[spell.name] then
		if spell.target.type ~= 'SELF' then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.target.name..':'..spell.name..'" '..dur..' down')
		else
			if custom_timers[spell.name] < (current_time + dur) then
				send_command('timers delete "'..spell.name..'"')
				custom_timers[spell.name] = current_time + dur
				send_command('timers create "'..spell.name..'" '..dur..' down')
			end
		end
    else
        -- Figure out how many songs we can maintain.
        local maxsongs = 2
        if player.equipment.range == info.ExtraSongInstrument then
            maxsongs = maxsongs + info.ExtraSongs
        end
        if buffactive['Clarion Call'] then
            maxsongs = maxsongs + 1
        end
        -- If we have more songs active than is currently apparent, we can still overwrite
        -- them while they're active, even if not using appropriate gear bonuses (ie: Daur).
        if maxsongs < table.length(custom_timers) then
            maxsongs = table.length(custom_timers)
        end
        
        -- Create or update new song timers.
        if table.length(custom_timers) < maxsongs then
            custom_timers[spell.name] = current_time + dur
            send_command('timers create "'..spell.target.name..':'..spell.name..'" '..dur..' down')
        else
            local rep,repsong
            for song_name,expires in pairs(custom_timers) do
                if current_time + dur > expires then
                    if not rep or rep > expires then
                        rep = expires
                        repsong = song_name
                    end
                end
            end
            if repsong then
                custom_timers[repsong] = nil
                send_command('timers delete "'..repsong..'"')
                custom_timers[spell.name] = current_time + dur
                send_command('timers create "'..spell.target..':'..spell.name..'" '..dur..' down')
            end
        end
    end
end

--]]

-- Function to calculate the duration of a song based on the equipment used to cast it.
-- Called from adjust_timers(), which is only called on aftercast().
function calculate_duration(spell, spellMap)
    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
	if player.equipment.range == "Marsyas" then mult = mult + 0.5 end -- 
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.1 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
	if player.equipment.neck == "Moonbow Whistle" then mult = mult + 0.2 end 
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
	if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
    
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet" then mult = mult + 0.1 end
    if spellMap == 'Paeon' and player.equipment.head == "Brioso Roundlet +1" then mult = mult + 0.1 end
    if spellMap == 'Madrigal' and player.equipment.head == "Fili Calot +1" then mult = mult + 0.1 end
    if spellMap == 'Minuet' and player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.1 end
    if spellMap == 'March' and player.equipment.hands == 'Fili Manchettes +1' then mult = mult + 0.1 end
    if spellMap == 'Ballad' and player.equipment.legs == "Fili Rhingrave +1" then mult = mult + 0.1 end
	if spellMap == 'Lullaby' and player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    if spell.name == "Sentinel's Scherzo" and player.equipment.feet == "Fili Cothurnes +1" then mult = mult + 0.1 end
	if MaxJobPoints == 1 then
		mult = mult + 0.05
	end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    if spell.name == "Sentinel's Scherzo" then
        if buffactive['Soul Voice'] then
            mult = mult*2
        elseif buffactive['Marcato'] then
            mult = mult*1.5
        end
    end
	
	local generalClass = get_song_class(spell)
	-- add_to_chat(8,'Info: Spell Name'..spell.name..' Spell Map:'..spellMap..' General Class:'..generalClass..' Multiplier:'..mult)
	if spell.name == "Foe Lullaby II" or spell.name == "Horde Lullaby II" then 
		base = 60
	elseif spell.name == "Foe Lullaby" or spell.name == "Horde Lullaby" then 
		base = 30
	elseif spell.name == "Carnage Elegy" then 
		base = 180
	elseif spell.name == "Battlefield Elegy" then
		base = 120
	elseif spell.name == "Pining Nocturne" then
		base = 120
	elseif spell.name == "Maiden's Virelai" then
		base = 20
		
	end
	
	if generalClass == 'SongEffect' then 
		base = 120
		totalDuration = math.floor(mult*base)		
	end
	
	totalDuration = math.floor(mult*base)		
	
	if MaxJobPoints == 1 then 
		if string.find(spell.name,'Lullaby') then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Lullaby Job Points')
			totalDuration = totalDuration + 20
		end
		if buffactive['Clarion Call'] then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Clarion Call Job Points')
			totalDuration = totalDuration + 40
		end
		if buffactive['Tenuto'] then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Tenuto Job Points')
			totalDuration = totalDuration + 20
		end
		if buffactive['Marcato'] then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Marcato Job Points')
			totalDuration = totalDuration + 20
		end
	end
	add_to_chat(8,'Total Duration:'..totalDuration)
	
    return totalDuration
	
end



-- Examine equipment to determine what our current TP weapon is.
--[[
function pick_tp_weapon()
    if brd_daggers:contains(player.equipment.main) then
        state.CombatWeapon:set('Dagger')
        
        if S{'NIN','DNC'}:contains(player.sub_job) and brd_daggers:contains(player.equipment.sub) then
            state.CombatForm:set('DW')
        else
            state.CombatForm:reset()
        end
    else
        state.CombatWeapon:reset()
        state.CombatForm:reset()
    end
end
]]

-- Function to reset timers.
function reset_timers()
    for i,v in pairs(custom_timers) do
        send_command('timers delete "'..i..'"')
    end
    custom_timers = {}
end

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)    	
	disable_specialgear()
end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    set_macro_page(8, 1)
end

windower.raw_register_event('zone change',reset_timers)
windower.raw_register_event('logout',reset_timers)







--[[
  Custom TXT Box for Lullaby Duration
]]

texts = require('texts')
res = require 'resources'
packets = require('packets')

lullaby_txt = {}
lullaby_txt.pos = {}
lullaby_txt.pos.x = -180
lullaby_txt.pos.y = 45
lullaby_txt.text = {}
lullaby_txt.text.font = 'Arial'
lullaby_txt.text.size = 10
lullaby_txt.flags = {}
lullaby_txt.flags.right = true

lullaby_box = texts.new('${value}', lullaby_txt)


local lullaby_list = {}

function new_lullaby(target, duration)
	local lullabytime = os.clock()
	lullaby_list[target] = {start=lullabytime,lullabyduration=duration}
end

windower.raw_register_event('prerender', function()
    local t = windower.ffxi.get_mob_by_index(windower.ffxi.get_player().target_index or 0)
	if t then 
		if lullaby_list[t.id] then 
			local start_time = lullaby_list[t.id].start
			local duration = lullaby_list[t.id].lullabyduration
			local now = os.clock()	
			local remaining_time = string.format("%.1f", duration - (now - start_time))
			if duration - (now - start_time) < 0 then 
				lullaby_list[t.id] = nil
			end
			lullaby_box.value = "Mob: "..t.name.." Is Asleep! Remaining:"..remaining_time
		else 
			lullaby_box.value = ""
		end
	end
    lullaby_box:visible(t ~= nil)
end)

last_spell = ''
lullaby_spell_ids = S{376, 377, 463, 471}

windower.raw_register_event('incoming chunk', function(id,original,modified,injected,blocked)
	local self = windower.ffxi.get_player()
    if id == 0x028 then
		local packet = packets.parse('incoming', original)
		
		if packet['Category'] == 8 and packet.Actor == self.id then 
			last_spell = packet['Target 1 Action 1 Param']
		end
		
		if packet['Category'] == 4 and packet.Actor == self.id and lullaby_spell_ids:contains(last_spell) then
			local numtargets = packet['Target Count']
			local count = 0
			
			if packet.Actor == self.id then
				while count < numtargets do
					count = count + 1
					local target_id = packet['Target '..count..' ID']
					local spell_duration = calculate_duration_raw(last_spell)
					local message = packet['Target '..count..' Action 1 Message']
					--print("Target ID:",target_id,message)
					if message == 270 or message == 236 then 
						
						new_lullaby(target_id, spell_duration)
					end
				end
				
			end
		end
		
		if lullaby_list[packet.Actor] then 
			lullaby_list[packet.Actor] = nil
		end
	end
end)

function calculate_duration_raw(spell_id)
	spell = res.spells[spell_id]
    local mult = 1
    if player.equipment.range == 'Daurdabla' then mult = mult + 0.3 end -- change to 0.25 with 90 Daur
    if player.equipment.range == "Gjallarhorn" then mult = mult + 0.4 end -- change to 0.3 with 95 Gjall
	if player.equipment.range == "Marsyas" then mult = mult + 0.5 end -- 
    
    if player.equipment.main == "Carnwenhan" then mult = mult + 0.5 end -- 0.1 for 75, 0.4 for 95, 0.5 for 99/119
    if player.equipment.main == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.main == "Kali" then mult = mult + 0.05 end
    if player.equipment.sub == "Legato Dagger" then mult = mult + 0.05 end
    if player.equipment.neck == "Aoidos' Matinee" then mult = mult + 0.1 end
	if player.equipment.neck == "Moonbow Whistle" then mult = mult + 0.2 end 
    if player.equipment.body == "Fili Hongreline +1" then mult = mult + 0.12 end
    if player.equipment.legs == "Inyanga Shalwar +1" then mult = mult + 0.15 end
    if player.equipment.feet == "Brioso Slippers" then mult = mult + 0.1 end
    if player.equipment.feet == "Brioso Slippers +1" then mult = mult + 0.11 end
	if player.equipment.feet == "Brioso Slippers +2" then mult = mult + 0.13 end
	
	if player.equipment.hands == 'Brioso Cuffs +1' then mult = mult + 0.1 end
    
	if MaxJobPoints == 1 then
		mult = mult + 0.05
	end
    
    if buffactive.Troubadour then
        mult = mult*2
    end
    
	if spell.en == "Foe Lullaby II" or spell.en == "Horde Lullaby II" then 
		base = 60
	elseif spell.en == "Foe Lullaby" or spell.en == "Horde Lullaby" then 
		base = 30
	end
	
	totalDuration = math.floor(mult*base)		
	
	if MaxJobPoints == 1 then 
		-- add_to_chat(8,'Adding 20 seconds to Timer for Lullaby Job Points')
		totalDuration = totalDuration + 20
		if buffactive['Clarion Call'] then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Clarion Call Job Points')
			totalDuration = totalDuration + 40
		end
		if buffactive['Tenuto'] then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Tenuto Job Points')
			totalDuration = totalDuration + 20
		end
		if buffactive['Marcato'] then
			-- add_to_chat(8,'Adding 20 seconds to Timer for Marcato Job Points')
			totalDuration = totalDuration + 20
		end
	end
	
    return totalDuration
	
end

