-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
    include('sammeh_custom_functions.lua')
end
 
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper", "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
     
    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Head'] = 'Magic',
        ['Soulsoother Head'] = 'Heal',
        ['Spiritreaver Head'] = 'Nuke'
        }
 
    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}
     
    -- Var to track the current pet mode.
    state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic', 'Heal', 'Nuke'}
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'Martial_Arts', 'Hizamaru')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('PDT', 'Evasion', 'PetDT')
    state.IdleMode:options('Normal', 'PetDT')
     
    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }
 
    update_pet_mode()
    select_default_macro_book()
end
 
 
-- Define sets used by this job file.
function init_gear_sets()
     
    -- Precast Sets
 
    sets.precast.Step = {head="Hizamaru Somen +1",ear2="Zennaroi Earring",waist="Klouskap Sash",back="Visucius's Mantle",ring1="Varar Ring",ring2="Varar Ring",
    hands="Hizamaru Kote +1",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-Ate +1",body="Hiza. Haramaki +1",neck="Ej Necklace",ear1="Steelflash Earring"}
     
    sets.precast.Flourish1 = {head="Hizamaru Somen +1",ear2="Zennaroi Earring",waist="Klouskap Sash",back="Visucius's Mantle",ring1="Varar Ring",ring2="Varar Ring",
    hands="Hizamaru Kote +1",feet="Herculean Boots",body="Hiza. Haramaki +1",neck="Ej Necklace",ear1="Steelflash Earring"}  
     
    -- Fast cast sets for spells
    sets.precast.FC = {head="Herculean Helm",body="Taeon Tabard",neck="Voltsurge Torque",ring1="Weatherspoon Ring",ring2="Prolix Ring",ear1="Enchntr. Earring +1",ear2="Loquacious Earring",hands="Thaumas Gloves",back="Ogapepo Cape",waist="Witful Belt",
    legs="Rawhide Trousers",
    feet="Regal Pumps +1"}
 
    sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {back="Mujin Mantle",neck="Magoraga Beads"})
     
    -- Precast sets to enhance JAs
    sets.precast.JA['Tactical Switch'] = {feet="Karagoz Scarpe"}
     
    sets.precast.JA['Repair'] = {feet="Foire Babouches +1",ear1="Guignol Earring",ear2="Pratik Earring",legs="Desultor Tassets"}
 
    sets.precast.JA.Maneuver = {neck="Buffoon's Collar +1",body="Karagoz Farsetto",hands="Foire Dastanas +1",back="Visucius's Mantle",ear2="Burana Earring"}
 
 
 
    -- Waltz set (chr and vit)
    sets.precast.Waltz = {
        head="Herculean Helm",neck="Tjukurrpa Medal",ear2="Roundel Earring",ear1="Soil Pearl",
        body={ name="Rawhide Vest", augments={'DEX+10','STR+7','INT+7',}},hands="Slither Gloves +1",ring1="Titan Ring",ring2="Titan Ring",
        back="Iximulew Cape",waist="Warwolf Belt",legs="Samnuha Tights",feet="Rawhide Boots"}
         
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}
 
        
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {
        head="Hizamaru Somen +1",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Moonshade Earring",
        body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Visucius's Mantle",waist="Fotia Belt",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1"}--Dispersal Mantle
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    sets.precast.WS['Stringing Pummel'] = set_combine(sets.precast.WS, {
    neck="Fotia Gorget",belt="Fotia Belt",back="Rancorous Mantle",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1"})
     
    sets.precast.WS['Stringing Pummel'].Mod = set_combine(sets.precast.WS['Stringing Pummel'], {legs="Hiza. Hizayoroi +1"})
 
    sets.precast.WS['Victory Smite'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",body="Hiza. Haramaki +1",waist="Fotia Belt",
    legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1",back="Rancorous Mantle",head="Hizamaru Somen +1"})
 
    sets.precast.WS['Shijin Spiral'] = set_combine(sets.precast.WS, {head="Lilitu Headpiece",body="Naga Samue",hands="Rawhide Gloves",neck="Fotia Gorget",waist="Fotia Belt"})
 
     
    -- Midcast Sets
 
    sets.midcast.FastRecast = {head="Herculean Helm",body="Taeon Tabard",neck="Voltsurge Torque",ring1="Weatherspoon Ring",ring2="Prolix Ring",
    ear1="Enchntr. Earring +1",ear2="Loquacious Earring",hands="Thaumas Gloves",back="Ogapepo Cape",waist="Witful Belt",
    legs="Rawhide Trousers",
    feet="Regal Pumps +1"}
         
 
    -- Midcast sets for pet actions
        sets.midcast.Pet.Cure = {range="Divinator II",ear1="Cirque Earring",back="Visucius's Mantle",legs="Foire Churidars +1",waist="Ukko Sash"}
 
        sets.midcast.Pet['Elemental Magic'] = {range="Divinator II",ear1="Cirque Earring",back="Visucius's Mantle",hands="Naga Tekko",legs="Kara. Pantaloni +1",feet="Naga Kyahan",waist="Ukko Sash"}
 
        sets.midcast.Pet['Enfeebling Magic'] = {range="Divinator II",ear1="Cirque Earring",back="Visucius's Mantle",hands="Naga Tekko",legs="Kara. Pantaloni +1",feet="Naga Kyahan",waist="Ukko Sash"}
     
        sets.midcast.Pet['Dark Magic'] = {range="Divinator II",ear1="Cirque Earring",back="Visucius's Mantle",hands="Naga Tekko",legs="Kara. Pantaloni +1",feet="Naga Kyahan",waist="Ukko Sash"}
     
        sets.midcast.Pet['Divine Magic'] = {range="Divinator II",ear1="Cirque Earring",back="Visucius's Mantle",hands="Naga Tekko",legs="Kara. Pantaloni +1",feet="Naga Kyahan",waist="Ukko Sash"}
     
        sets.midcast.Pet['Enhancing Magic'] = {range="Divinator II",ear1="Cirque Earring",back="Visucius's Mantle",hands="Naga Tekko",legs="Kara. Pantaloni +1",feet="Naga Kyahan",waist="Ukko Sash"}
     
    --Set for Pet Weapon Skill DMG MAX
     
    sets.midcast.Pet.Weaponskill = {range="Divinator",neck="Empath Necklace",head="Karagoz Capello",body="Karagoz Farsetto",hands="Karagoz Guanti",legs="Kara. Pantaloni +1",feet="Naga Kyahan",back="Dispersal Mantle",ear2="Burana Earring",ear1="Cirque Earring",waist="Klouskap Sash",ring1="Overbearing Ring"}
 
     
    -- Sets to return to when not performing an action.
     
    --Burana Earring (PUP) Maneuver effects +1 Automaton: Attack+15 Ranged Attack+15 "Magic Atk. Bonus"+10 "Regen"+2
 
    --Cirque Earring (PUP) Automaton: Attack+2 Ranged Attack+2 "Magic Atk. Bonus"+2
     
     
    --Hizamaru Somen +1
    --Hiza. Haramaki +1
    --Hizamaru Kote +1
    --Hiza. Hizayoroi +1 
    --Hiza. Sune-ate +1
     
    -- Resting sets
    sets.resting = {head="Pitre Taj +1",neck="Sanctity Necklace",
        ring1="Dark Ring",ring2="Defending Ring",back="Contriver's Cape",ear2="Burana Earring",waist="Isa Belt"}
     
    -- Idle sets
 
    sets.idle = {ammo="Automat. Oil +3",
        head="Pitre Taj +1",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Burana Earring",
        body="Foire Tobe +1",hands="Regimen Mittens",ring1="Matrimony Ring",ring2="Defending Ring",
        back="Contriver's Cape",waist="Isa Belt",legs="Kara. Pantaloni +1",feet="Hermes' Sandals"}--Sanctity Necklace/Burana Earring/Shepherd's Chain
 
    sets.idle.Town = set_combine(sets.idle, {range="Divinator",main="Denouements"})
 
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet = sets.idle
 
    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = {range="Divinator",ammo="Automat. Oil +3",
        head="Pitre Taj +1",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Burana Earring",
        body="Foire Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Klouskap Sash",legs="Kara. Pantaloni +1",feet="Naga Kyahan"}--Handler's Earring/Burana Earring
 
    sets.idle.Pet.PetDT = set_combine(sets.idle.Pet.Engaged,  {range="Divinator",ammo="Automat. Oil +3",
        head="Pitre Taj +1",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Handler's Earring",
        body="Foire Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Isa Belt",legs="Kara. Pantaloni +1",feet="Naga Kyahan"})--Pet: Damage Taken set
         
    sets.idle.Pet.Engaged.Ranged = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",neck="Empath Necklace",
    hands="Regimen Mittens",legs="Kara. Pantaloni +1",ear2="Burana Earring",ear1="Cirque Earring",back="Visucius's Mantle",
    waist="Klouskap Sash"})
 
    sets.idle.Pet.Engaged.Nuke = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",
    legs="Kara. Pantaloni +1",feet="Naga Kyahan",hands="Naga Tekko",
    ear2="Burana Earring",ear1="Cirque Earring",back="Visucius's Mantle",
    waist="Klouskap Sash"})
 
    sets.idle.Pet.Engaged.Heal = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",
    legs="Kara. Pantaloni +1",feet="Naga Kyahan",ear2="Burana Earring",ear1="Cirque Earring",back="Visucius's Mantle",
    waist="Klouskap Sash"})
     
    sets.idle.Pet.Engaged.Magic = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",
    legs="Kara. Pantaloni +1",feet="Naga Kyahan",hands="Naga Tekko",
    ear2="Burana Earring",ear1="Cirque Earring",back="Visucius's Mantle",
    waist="Klouskap Sash"})
 
 
    -- Defense sets
 
    sets.defense.Evasion = {
        head="Herculean Helm",neck="Ej Necklace",ear1="Infused Earring",
        body="Hiza. Haramaki +1",hands="Herculean Gloves",ring1="Varar Ring",ring2="Defending Ring",
        back="Dispersal Mantle",waist="Klouskap Sash",legs="Herculean Trousers",feet="Herculean Boots"}
 
    sets.defense.PDT = {
        head="Herculean Helm",neck="Twilight Torque",
        body="Hiza. Haramaki +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Klouskap Sash",legs="Herculean Trousers",feet="Herculean Boots"}
 
    sets.defense.PetDT = {range="Divinator",ammo="Automat. Oil +3",
        head="Pitre Taj +1",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Handler's Earring",
        body="Foire Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Isa Belt",legs="Kara. Pantaloni +1",feet="Naga Kyahan"}
         
    sets.defense.MDT = {
        head="Herculean Helm",neck="Twilight Torque",
        body="Hiza. Haramaki +1",hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Mollusca Mantle",waist="Klouskap Sash",legs="Ta'lab Trousers",feet="Herculean Boots"}
 
    sets.Kiting = {feet="Hermes' Sandals"}
 
    -- Engaged sets
 
    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
    sets.engaged = {ammo="Automat. Oil +3",
        head="Herculean Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"}--Karagoz Guanti/Karagoz Capello/Hurch'lan Sash/Clotharius Torque/Dispersal Mantle
    sets.engaged.Acc = {ammo="Automat. Oil +3",
        head="Hizamaru Somen +1",neck="Ej Necklace",ear1="Steelflash Earring",ear2="Zennaroi Earring",
        body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Klouskap Sash",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1"}
    sets.engaged.Martial_Arts = {ammo="Automat. Oil +3",
        head="Hizamaru Somen +1",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Klouskap Sash",legs="Kara. Pantaloni +1",feet="Herculean Boots"}
    sets.engaged.Hizamaru = {ammo="Automat. Oil +3",
        head="Hizamaru Somen +1",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body="Hiza. Haramaki +1",hands="Hizamaru Kote +1",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Klouskap Sash",legs="Hiza. Hizayoroi +1",feet="Hiza. Sune-ate +1"}
    sets.engaged.DT = {ammo="Automat. Oil +3",
        head="Herculean Helm",neck="Twilight Torque",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Klouskap Sash",legs="Herculean Trousers",feet="Herculean Boots"}
    sets.engaged.Acc.DT = {ammo="Automat. Oil +3",
        head="Dampening Tam",neck="Twilight Torque",ear1="Steelflash Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Klouskap Sash",legs={ name="Taeon Tights", augments={'Accuracy+17','"Triple Atk."+2','Crit. hit damage +3%',}},feet="Herculean Boots"}
    ------------------------------------------------------------------------------
    -- When Pet is Engaged this what will be Equiped for armor while your weapons are Drawn.
    ------------------------------------------------------------------------------
    sets.engaged.PetEngaged = {range="Divinator",ammo="Automat. Oil +3",
        head="Pitre Taj +1",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Burana Earring",
        body="Foire Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Klouskap Sash",legs="Kara. Pantaloni +1",feet="Naga Kyahan"}
         
    sets.engaged.PetEngaged.PetDT = set_combine(sets.idle.Pet.Engaged,  {range="Divinator",ammo="Automat. Oil +3",
        head="Pitre Taj +1",neck="Empath Necklace",ear1="Handler's Earring +1",ear2="Handler's Earring",
        body="Foire Tobe +1",hands="Regimen Mittens",ring1="Varar Ring",ring2="Varar Ring",
        back="Visucius's Mantle",waist="Isa Belt",legs="Kara. Pantaloni +1",feet="Naga Kyahan"})--Pet: Damage Taken set
         
    sets.engaged.PetEngaged.Ranged = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",neck="Empath Necklace",
    hands="Regimen Mittens",legs="Kara. Pantaloni +1",ear2="Burana Earring",ear1="Cirque Earring",back="Visucius's Mantle",
    waist="Klouskap Sash"})
 
    sets.engaged.PetEngaged.Nuke = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",ammo="Automat. Oil +3",
        head="Herculean Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"})
 
    sets.engaged.PetEngaged.Heal = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",ammo="Automat. Oil +3",
        head="Herculean Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"})
     
    sets.engaged.PetEngaged.Magic = set_combine(sets.idle.Pet.Engaged, {range="Divinator II",ammo="Automat. Oil +3",
        head="Herculean Helm",neck="Asperity Necklace",ear1="Brutal Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Petrov Ring",ring2="Epona's Ring",
        back="Dispersal Mantle",waist="Windbuffet Belt +1",legs="Herculean Trousers",feet="Herculean Boots"})
     
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then
        handle_equipping_gear(player.status)
    end
end
 
-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end
 
-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        display_pet_status()
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
end
 
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        if pet.isvalid then
            local man = defaultManeuvers[state.PetMode.value]
            if man and tonumber(cmdParams[2]) then
                man = man[tonumber(cmdParams[2])]
            end
 
            if man then
                send_command('input /pet "'..man..'" <me>')
            end
        else
            add_to_chat(123,'No valid pet.')
        end
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
        return petModes[pet.head] or 'None'
    else
        return 'None'
    end
end
 
-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end
 
-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end
 
-- Engage updates
 
function job_handle_equipping_gear(playerStatus, eventArgs)
    classes.CustomMeleeGroups:clear()
    if pet.status=="Engaged" then
        classes.CustomMeleeGroups:append('PetEngaged')
        classes.CustomMeleeGroups:append(state.PetMode.value)
    end
end
 
-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
         
        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end
         
        add_to_chat(122,petInfoString)
    end
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 7)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 7)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 7)
    else
        set_macro_page(1, 7)
    end
end