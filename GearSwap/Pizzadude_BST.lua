-------------------------------------------------------------------------------------------------------------------
-- Last Revised: July 25th, 2015 (Added 8 new precast broths:
-- SuspiciousAlice (Furious Broth)
-- AnklebiterJade [Jedd* in-game] (Crackling Broth)
-- FleetReinhard (Rapid Broth)
-- CursedAnnabelle (Creepy Broth)
-- SurgingStorm (Insipid Broth)
-- SubmergedIyo (Deepwater Broth)
-- MosquitoFamiliar (Wetlands Broth)
-- Left-HandedYoko (Heavenly Broth)
-- Added Infected Leech and Gloom Spray to list of Ready moves.)
--
-- alt+F8 cycles through designated Jug Pets
-- ctrl+F8 toggles Monster Correlation between Neutral and Favorable
-- 'Windows Key'+F8 switches between Pet stances for Master/Pet hybrid gearsets
-- alt+= cycles through Pet Food types
-- ctrl+= can swap in the usage of Chaac Belt for Treasure Hunter on common subjob abilities.
-- ctrl+F11 cycles between Magical Defense Modes
--
-- General Gearswap Commands:
-- F9 cycles Accuracy modes
-- ctrl+F9 cycles Hybrid modes
-- 'Windows Key'+F9 cycles Weapon Skill modes
-- F10 equips Physical Defense
-- alt+F10 toggles Kiting on or off
-- ctrl+F10 cycles Physical Defense modes
-- F11 equips Magical Defense
-- alt+F12 turns off Defense modes
-- ctrl+F12 cycles Idle modes
--
-- Keep in mind that any time you Change Jobs/Subjobs, your Pet/Pet Food/etc. reset to default options.
-- F12 will list your current options.
-------------------------------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------------------------------
-- Initialization function that defines sets and variables to be used.
-------------------------------------------------------------------------------------------------------------------

-- IMPORTANT: Make sure to also get the Mote-Include.lua file (and its supplementary files) to go with this.

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2

    -- Load and initialize the include file.
    include('Mote-Include.lua')
end

function job_setup()
    state.Buff['Aftermath: Lv.3'] = buffactive['Aftermath: Lv.3'] or false
    state.Buff['Killer Instinct'] = buffactive['Killer Instinct'] or false
    state.Buff.Doomed = buffactive.doomed or false

    get_combat_form()
    get_melee_groups()
end

function user_setup()
    state.OffenseMode:options('Normal', 'MedAcc', 'HighAcc')
    state.HybridMode:options('Normal', 'Hybrid')
    state.WeaponskillMode:options('Normal', 'WSMedAcc', 'WSHighAcc')
    state.CastingMode:options('Normal')
    state.IdleMode:options('Normal', 'Reraise', 'Refresh', 'Regen')
    state.RestingMode:options('Normal')
    state.PhysicalDefenseMode:options('PetPDT', 'PDT', 'Reraise')
    state.MagicalDefenseMode:options('MDTShell', 'MDT')

    -- 'Out of Range' distance; WS will auto-cancel
    target_distance = 6

    -- Set up Jug Pet cycling and keybind Alt+F8
    -- INPUT PREFERRED JUG PETS HERE
    state.JugMode = M{['description']='Jug Mode', 'BlackbeardRandy', 'SwoopingZhivago', 'WarlikePatrick',
        'HeadbreakerKen', 'VivaciousVickie', 'BouncingBertha', 'ThreestarLynn', 'HeraldHenry'}
    send_command('bind !f8 gs c cycle JugMode')

    -- Set up Monster Correlation Modes and keybind Ctrl+F8
    state.CorrelationMode = M{['description']='Correlation Mode', 'Neutral', 'Favorable'}
    send_command('bind ^f8 gs c cycle CorrelationMode')

    -- Set up Pet Modes for Hybrid sets and keybind 'Windows Key'+F8
    state.PetMode = M{['description']='Pet Mode', 'PetOnly', 'PetTank', 'Normal'}
    send_command('bind @f8 gs c cycle PetMode')

    -- Keybind Ctrl+F11 to cycle Magical Defense Modes
    send_command('bind ^f11 gs c cycle MagicalDefenseMode')

    -- Set up Reward Modes and keybind alt+=
    state.RewardMode = M{['description']='Reward Mode', 'Theta', 'Eta', 'Zeta'}
    send_command('bind != gs c cycle RewardMode')

    -- Set up Treasure Modes and keybind Ctrl+=
    state.TreasureMode = M{['description']='Treasure Mode', 'Tag', 'Normal'}
    send_command('bind ^= gs c cycle TreasureMode')

-- Complete list of Ready moves
physical_ready_moves = S{'Sic','Foot Kick','Whirl Claws','Wild Carrot','Sheep Charge','Lamb Chop','Head Butt',
    'Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang','Nimble Snap','Cyclotail','Rhino Attack','Power Attack',
    'Mandibular Bite','Big Scissors','Grapple','Spinning Top','Double Claw','Frogkick','Blockhead','Brain Crush',
    'Tail Blow','??? Needles','Needleshot','Scythe Tail','Ripper Fang','Chomp Rush','Recoil Dive','Sudden Lunge',
    'Spiral Spin','Wing Slap','Beak Lunge','Suction','Back Heel','Choke Breath','Fantod','Tortoise Stomp',
    'Harden Shell','Sensilla Blades','Tegmina Buffet','Swooping Frenzy','Pentapeck','Sweeping Gouge',
    'Zealous Snort','Somersault','Tickling Tendrils','Pecking Flurry','Sickle Slash'}

magic_atk_ready_moves = S{'Dust Cloud','Cursed Sphere','Venom','Toxic Spit','Bubble Shower','Drainkiss',
    'Silence Gas','Dark Spore','Fireball','Plague Breath','Snow Cloud','Charged Whisker','Purulent Ooze',
    'Corrosive Ooze','Aqua Breath','Stink Bomb','Nectarous Deluge','Nepenthic Plunge','Pestilent Plume',
    'Foul Waters','Infected Leech','Gloom Spray'}

magic_acc_ready_moves = S{'Sheep Song','Scream','Dream Flower','Roar','Gloeosuccus','Palsy Pollen',
    'Soporific','Geist Wall','Toxic Spit','Numbing Noise','Spoil','Hi-Freq Field','Sandpit','Sandblast',
    'Venom Spray','Filamented Hold','Queasyshroom','Numbshroom','Spore','Shakeshroom','Infrasonics',
    'Chaotic Eye','Blaster','Intimidate','Noisome Powder','Acid Mist','TP Drainkiss','Jettatura',
    'Molting Plumage','Spider Web'}

tp_based_ready_moves = S{'Sic','Foot Kick','Dust Cloud','Snow Cloud','Wild Carrot','Sheep Song','Sheep Charge',
    'Lamb Chop','Rage','Head Butt','Scream','Dream Flower','Wild Oats','Leaf Dagger','Claw Cyclone','Razor Fang',
    'Roar','Gloeosuccus','Palsy Pollen','Soporific','Cursed Sphere','Somersault','Geist Wall','Numbing Noise',
    'Frogkick','Nimble Snap','Cyclotail','Spoil','Rhino Guard','Rhino Attack','Hi-Freq Field','Sandpit','Sandblast',
    'Mandibular Bite','Metallic Body','Bubble Shower','Bubble Curtain','Scissor Guard','Grapple','Spinning Top',
    'Double Claw','Filamented Hold','Spore','Blockhead','Secretion','Fireball','Tail Blow','Plague Breath',
    'Brain Crush','Infrasonics','Needleshot','Chaotic Eye','Blaster','Ripper Fang','Intimidate','Recoil Dive',
    'Water Wall','Sudden Lunge','Noisome Powder','Wing Slap','Beak Lunge','Suction','Drainkiss','Acid Mist',
    'TP Drainkiss','Back Heel','Jettatura','Choke Breath','Fantod','Charged Whisker','Purulent Ooze',
    'Corrosive Ooze','Tortoise Stomp','Harden Shell','Aqua Breath','Sensilla Blades','Tegmina Buffet',
    'Sweeping Gouge','Zealous Snort','Tickling Tendrils','Pecking Flurry','Pestilent Plume','Foul Waters',
    'Spider Web','Gloom Spray'}

-- List of abilities to reference for applying Treasure Hunter +1 via Chaac Belt.
abilities_to_check = S{'Feral Howl','Quickstep','Box Step','Stutter Step','Desperate Flourish',
    'Violent Flourish','Animated Flourish','Provoke','Dia','Dia II','Flash','Bio','Bio II',
    'Sleep','Sleep II','Drain','Aspir','Dispel','Stun','Steal','Mug'}
end

function file_unload()
    if binds_on_unload then
        binds_on_unload()
    end

    -- Unbinds the Reward, Correlation, PetMode and Treasure hotkeys.
    send_command('unbind ^=')
    send_command('unbind !f8')
    send_command('unbind ^f8')
    send_command('unbind ^f11')
end

-- BST gearsets
function init_gear_sets()
    -- AUGMENTED GEAR
	Pet_PDT_AxeMain = "Izizoeksi"
    Pet_PDT_AxeSub = { name="Kumbhakarna", augments={'Pet: Attack+17 Pet: Rng.Atk.+17','Pet: Phys. dmg. taken -4%','Pet: TP Bonus+160',}}

    Pet_PDT_head = "Despair Helm"
    Pet_PDT_body = "Acro Surcoat"
	-- Pet_PDT_body = "Jumalik Mail"
    Pet_PDT_hands = "Ankusa Gloves +1"
    Pet_PDT_legs = "Nukumi Quijotes +1"
    Pet_PDT_feet = "Acro Leggings"
    Pet_PDT_back = "Pastoralist's Mantle"

    Ready_Atk_head = "Despair Helm"
    Ready_Atk_body = "Acro Surcoat"
    Ready_Atk_hands = "Nukumi Manoplas +1"
    Ready_Atk_legs = "Wisent Kecks"
    Ready_Atk_feet = "Acro Leggings"
    Ready_Atk_back = "Pastoralist's Mantle"

    Ready_Acc_head = Ready_Atk_Head
    Ready_Acc_body = Ready_Atk_Body
    Ready_Acc_hands = Ready_Atk_Hands
    Ready_Acc_legs = Ready_Atk_Legs
    Ready_Acc_feet = Ready_Atk_Feet
    Ready_Acc_back = Ready_Atk_back

    -- Ready_MAB_head = "Taeon Chapeau"
	Ready_MAB_head = "Arco Helm"
    Ready_MAB_body = "Taeon Tabard"
    Ready_MAB_hands = "Nukumi Manoplas +1"
    Ready_MAB_legs = "Acro Breeches"
    Ready_MAB_feet = "Taeon Boots"

    Ready_MAcc_head = Ready_MAB_Head
    Ready_MAcc_body = Ready_MAB_Body
    Ready_MAcc_hands = Ready_Atk_Hands
    Ready_MAcc_legs = Ready_MAB_Legs
    Ready_MAcc_feet = Ready_MAB_Feet

    Ready_Atk_Axe = "Skullrender"
    Ready_Acc_Axe = Ready_Atk_Axe
    Ready_MAB_Axe = { name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+18','Pet: Phys. dmg. taken -3%',}}
	Ready_MAB_Axe_Main = { name="Kumbhakarna", augments={'Pet: "Mag.Atk.Bns."+19','Pet: Phys. dmg. taken -4%','Pet: TP Bonus+160',}}
    
    Ready_MAcc_Axe = Ready_MAB_Axe

    Pet_Melee_head = Ready_Atk_head
    Pet_Melee_body = Ready_Atk_body
    Pet_Melee_hands = Pet_Pdt_Hands
    Pet_Melee_legs = Ready_Atk_legs
    Pet_Melee_feet = Ready_Atk_feet

    Hybrid_head = Pet_PDT_Head
    Hybrid_body = Pet_PDT_body
    Hybrid_hands = Pet_PDT_hands
    Hybrid_legs = Pet_PDT_Legs
    Hybrid_feet = Pet_PDT_Feet

    DW_head = Pet_PDT_Head
    DW_body = Pet_PDT_Body
    DW_hands = Pet_PDT_Hands
    DW_legs = Pet_PDT_Legs
    DW_feet = Pet_PDT_Feet

    MAB_head = Pet_PDT_Head
    MAB_body = Pet_PDT_Body
    MAB_hands = Pet_PDT_Hands
    MAB_legs = Pet_PDT_Legs
    MAB_feet = Pet_PDT_Feet

    FC_head = MAB_head
    FC_body = MAB_body
    FC_hands = MAB_hands
    FC_legs = MAB_legs
    FC_feet = MAB_feet

    MAcc_head = "Seiokona Beret"
    MAcc_body = "Ankusa Jackcoat +1"
    MAcc_hands = MAB_hands
    MAcc_legs = MAB_legs
    MAcc_feet = MAB_feet

    CB_head = Pet_PDT_Head
    CB_body = Pet_PDT_Body
    CB_hands = "Ankusa Gloves +1"
    CB_legs = Pet_PDT_Legs
    CB_feet = Pet_PDT_Feet

    -- PRECAST SETS
    sets.precast.JA['Killer Instinct'] = {head="Ankusa Helm +1"}
    sets.precast.JA['Bestial Loyalty'] = {head=CB_head,
        body=CB_body,
        hands=CB_hands,
        legs=CB_legs,
        feet=CB_feet}
    sets.precast.JA['Call Beast'] = sets.precast.JA['Bestial Loyalty']
    sets.precast.JA.Familiar = {legs="Ankusa Trousers +1"}
    sets.precast.JA.Tame = {head="Totemic Helm +1",ear1="Tamer's Earring",legs="Stout Kecks"}
    sets.precast.JA.Spur = {feet="Nukumi Ocreae +1",main="Skullrender"}

    sets.precast.JA['Feral Howl'] = {
	    -- ammo="Ombre Tathlum +1",
        head=MAcc_head,
        neck="Voltsurge Torque",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body=MAcc_body,
        hands=MAcc_hands,
        ring1="Etana Ring",ring2="Sangoma Ring",
        back=Pet_PDT_Back,
        waist="Incarnation Sash",
        legs=MAcc_legs,
        feet=MAcc_feet}

    sets.precast.JA.Reward = {
	    main="Mdomo Axe",
        head="Bison Warbonnet",neck="Aife's Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Totemic Jackcoat +1",hands="Nukumi Manoplas +1",
        back=Pet_PDT_back,
        legs="Tot. Trousers +1",feet="Tot. Gaiters +1"}

    sets.precast.JA.Reward.Theta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Theta"})
    sets.precast.JA.Reward.Zeta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Zeta"})
    sets.precast.JA.Reward.Eta = set_combine(sets.precast.JA.Reward, {ammo="Pet Food Eta"})

    sets.precast.JA.Charm = {ammo="Tsar's Egg",
        head="Ighwa Cap",neck="Dualism Collar +1",ear1="Enchanter's Earring",ear2="Enchanter Earring +1",
        body="Totemic Jackcoat +1",hands="Ankusa Gloves +1",ring1="Dawnsoul Ring",ring2="Dawnsoul Ring",
        back="Aisance Mantle +1",waist="Aristo Belt",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}

    -- CURING WALTZ
    sets.precast.Waltz = {ammo="Sonia's Plectrum",
        head="Ighwa Cap",neck="Dualism Collar +1",ear1="Enchanter's Earring",ear2="Enchanter Earring +1",
        body="Totemic Jackcoat +1",hands="Regimen Mittens",ring1="Valseur's Ring",ring2="Asklepian Ring",
        back="Aisance Mantle +1",waist="Aristo Belt",legs="Desultor Tassets",feet="Totemic Gaiters +1"}

    -- HEALING WALTZ
    sets.precast.Waltz['Healing Waltz'] = {}

    -- STEPS
	sets.precast.Step = {ammo="Hasty Pinion +1",
        head="Yaoyotl Helm",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Heartseeker Earring",
        body="Mes'yohi Haubergeon",
        hands=DW_hands,
        ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Grounded Mantle +1",waist="Olseni Belt",
        legs=DW_legs,
        feet=DW_feet}

    -- VIOLENT FLOURISH
    sets.precast.Flourish1 = {}
    sets.precast.Flourish1['Violent Flourish'] = {ammo="Hasty Pinion +1",
        head=MAcc_head,
        neck="Stoicheion Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body="Mes'yohi Haubergeon",
        hands=MAcc_hands,
        ring1="Sangoma Ring",ring2="Fenrir Ring +1",
        back="Grounded Mantle +1",waist="Eschan Stone",
        legs=MAcc_legs,
        feet=MAcc_feet}

    sets.precast.FC = {ammo="Impatiens",
        head=FC_head,
        neck="Voltsurge Torque",ear1="Loquacious Earring",ear2="Enchanter Earring +1",
        body=FC_body,
        hands=FC_hands,
        ring1="Prolix Ring",ring2="Weather. Ring",
        legs=FC_legs,
        feet=FC_feet,
		wasit="Hurch'lan Sash"}

        sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Voltsurge Torque"})

    -- MIDCAST SETS
    sets.midcast.FastRecast = {
        head=FC_head,
        neck="Voltsurge Torque",ear1="Loquacious Earring",ear2="Enchanter Earring +1",
        body=FC_body,
        hands=FC_hands,
        ring1="Prolix Ring",ring2="Defending Ring",
        back="Repulse Mantle",wasit="Hurch'lan Sash",
        legs=FC_legs,
        feet=FC_feet}
 
    sets.midcast.Utsusemi = sets.midcast.FastRecast

    sets.midcast.Cure = {ammo="Quartz Tathlum +1",
        head="Yaoyotl Helm",neck="Phalaina Locket",ear1="Lifestorm Earring",ear2="Neptune's Pearl",
        body="Savas Jawshan",hands="Buremte Gloves",ring1="Leviathan Ring +1",ring2="Asklepian Ring",
        back=Pet_PDT_back,
        waist="Chuq'aba Belt",legs="Ankusa Trousers +1",feet="Ankusa Gaiters +1"}

    sets.midcast.Curaga = sets.midcast.Cure

    sets.midcast.Stoneskin = {ammo="Quartz Tathlum +1",
        head="Ighwa Cap",neck="Stone Gorget",ear1="Earthcry Earring",ear2="Lifestorm Earring",
        body="Totemic Jackcoat +1",hands="Stone Mufflers",ring1="Leviathan Ring +1",ring2="Leviathan Ring +1",
        back=Pet_PDT_back,
        waist="Engraved Belt",legs="Haven Hose",feet="Whirlpool Greaves"}

    sets.midcast.Cursna = set_combine(sets.midcast.FastRecast, {neck="Malison Medallion",
        ring1="Eshmun's Ring",ring2="Haoma's Ring"})

    sets.midcast.Protect = {ring2="Sheltered Ring"}
    sets.midcast.Protectra = sets.midcast.Protect

    sets.midcast.Shell = {ring2="Sheltered Ring"}
    sets.midcast.Shellra = sets.midcast.Shell

    sets.midcast['Enfeebling Magic'] = {ammo="Quartz Tathlum +1",
        head=FC_head,
        neck="Stoicheion Medal",ear1="Lifestorm Earring",ear2="Psystorm Earring",
        body=FC_body,
        hands=FC_hands,
        ring1="Sangoma Ring",ring2="Fenrir Ring +1",
        back="Aput Mantle +1",waist="Eschan Stone",
        legs=FC_legs,
        feet=FC_feet}

    sets.midcast['Elemental Magic'] = sets.midcast['Enfeebling Magic']

    sets.precast.LuzafRing = {ring1="Luzaf's Ring"}

    -- WEAPONSKILLS
    -- Default weaponskill sets.
    sets.precast.WS = {ammo="Cheruski Needle",
        head="Otomi Helm",neck="Asperity Necklace",ear1="Kokou's Earring",ear2="Brutal Earring",
        body="Mes'yohi Haubergeon",
        hands=DW_hands,
        ring1="Ifrit Ring +1",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt",
        legs=Hybrid_legs,
        feet=Hybrid_Feet}

    sets.precast.WS.WSMedAcc = {ammo="Hasty Pinion +1",
        head="Otomi Helm",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Mes'yohi Haubergeon",
        hands=DW_hands,
        ring1="Ifrit Ring +1",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Anguinus Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet}

    sets.precast.WS.WSHighAcc = {ammo="Hasty Pinion +1",
        head="Yaoyotl Helm",neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Mes'yohi Haubergeon",
        hands=DW_hands,
        ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Grounded Mantle +1",waist="Anguinus Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet}

    -- Specific weaponskill sets.
    sets.precast.WS['Ruinator'] = set_combine(sets.precast.WS, {neck="Fotia Gorget",hands="Boor Bracelets",
        back="Buquwik Cape",waist="Fotia Belt"})
    sets.precast.WS['Ruinator'].Gavialis = set_combine(sets.precast.WS['Ruinator'], {head="Gavialis Helm"})
    sets.precast.WS['Ruinator'].WSMedAcc = set_combine(sets.precast.WS.WSMedAcc, {neck="Fotia Gorget",
        ear1="Kokou's Earring",ear2="Brutal Earring",
        back="Buquwik Cape",waist="Fotia Belt"})
    sets.precast.WS['Ruinator'].WSHighAcc = set_combine(sets.precast.WS.WSHighAcc, {neck="Fotia Gorget",
        ear1="Kokou's Earring",ear2="Brutal Earring",
        waist="Fotia Belt"})

    sets.precast.WS['Onslaught'] = set_combine(sets.precast.WS, {neck="Justiciar's Torque",
        ear1="Steelflash Earring",ear2="Bladeborn Earring",
        ring1="Rajas Ring",back="Vespid Mantle"})
    sets.precast.WS['Onslaught'].WSMedAcc = set_combine(sets.precast.WSMedAcc, {ring1="Rajas Ring",back="Vespid Mantle"})
    sets.precast.WS['Onslaught'].WSHighAcc = set_combine(sets.precast.WSHighAcc, {back="Vespid Mantle"})

    sets.precast.WS['Primal Rend'] = {ammo="Erlene's Notebook",
        head=MAB_head,
        neck="Stoicheion Medal",ear1="Moonshade Earring",ear2="Friomisi Earring",
        body=MAB_body,
        hands=MAB_hands,
        ring1="Acumen Ring",ring2="Fenrir Ring +1",
        back="Argochampsa Mantle",waist="Eschan Stone",
        legs=MAB_legs,
        feet=MAB_feet}
    sets.precast.WS['Primal Rend'].WSMedAcc = set_combine(sets.precast.WS['Primal Rend'], {neck="Fotia Gorget",waist="Fotia Belt"})
    sets.precast.WS['Primal Rend'].WShighAcc = sets.precast.WS['Primal Rend'].WSMedAcc
    sets.precast.WS['Cloudsplitter'] = set_combine(sets.precast.WS['Primal Rend'], {neck="Fotia Gorget",
        ring2="Fenrir Ring +1",waist="Fotia Belt"})

    sets.midcast.NightEarrings = {ear1="Lugra Earring",ear2="Lugra Earring +1"}
    sets.midcast.ExtraMAB = {ear1="Hecate's Earring"}

    -- PET SIC & READY MOVES
    sets.midcast.Pet.WS = {ammo="Demonry Core",
        neck="Empath Necklace",ear2="Domesticator's Earring",
        body=Ready_Atk_body,
        hands=Ready_Atk_hands,
        --ring1="Thurandaut Ring",
        --ring2="Angel's Ring",
        back=Ready_Atk_back,
        waist="Incarnation Sash",
        legs=Ready_Atk_legs,
        feet=Ready_Atk_feet}

    sets.midcast.Pet.MagicAtkReady = set_combine(sets.midcast.Pet.WS, {
        head=Ready_MAB_head,
        --ear1="Diamond Earring",ear2="Sapphire Earring",
        body=Ready_MAB_body,
		waist="Incarnation Sash",
        hands=Ready_MAB_hands,
        back="Argochampsa Mantle",
        legs=Ready_MAB_legs,
        feet=Ready_MAB_feet})

    sets.midcast.Pet.MagicAccReady = set_combine(sets.midcast.Pet.WS, {
        head=Ready_MAcc_head,
        --ear1="Diamond Earring",ear2="Sapphire Earring",
        body=Ready_MAcc_body,
        hands=Ready_MAcc_hands,
		waist="Incarnation Sash",
        back="Argochampsa Mantle",
        legs=Ready_MAcc_legs,
        feet=Ready_MAcc_feet})

    sets.midcast.Pet.ReadyRecast = {legs="Desultor Tassets"}

    sets.midcast.Pet.Neutral = {head=Ready_Atk_head}
    sets.midcast.Pet.Favorable = {head=Ready_Atk_Head}
    sets.midcast.Pet.MedAcc = set_combine(sets.midcast.Pet.WS, {--ear2="Ferine Earring",
        body=Ready_Acc_body,
        legs=Ready_Acc_legs})
    sets.midcast.Pet.HighAcc = set_combine(sets.midcast.Pet.WS, {--ear2="Ferine Earring",
        body=Ready_Acc_body,
        hands=Ready_Acc_hands,
        legs=Ready_Acc_legs,
        feet=Ready_Acc_feet})
    sets.midcast.Pet.TPBonus = {hands="Nukumi Manoplas +1"}

    -- PET-ONLY READY GEARSETS
    -- Single-wield PetOnly Sets
    sets.midcast.Pet.ReadyRecastNE = {main="Charmer's Merlin",legs="Desultor Tassets"}

    sets.midcast.Pet.ReadyNE = set_combine(sets.midcast.Pet.WS, {main="Kerehcatl"})
    sets.midcast.Pet.ReadyNE.MedAcc = set_combine(sets.midcast.Pet.WS, {main="Kerehcatl",
        ear2="Ferine Earring",
        body=Ready_Acc_body,
        legs=Ready_Acc_legs})
    sets.midcast.Pet.ReadyNE.HighAcc = set_combine(sets.midcast.Pet.WS, {main="Kerehcatl",
        ear2="Ferine Earring",
        body=Ready_Acc_body,
        hands=Ready_Acc_hands,
        legs=Ready_Acc_legs,
        feet=Ready_Acc_feet})

    sets.midcast.Pet.MagicAtkReadyNE = set_combine(sets.midcast.Pet.MagicAtkReady, {main=Ready_MAB_Axe})
    sets.midcast.Pet.MagicAtkReadyNE.MedAcc = set_combine(sets.midcast.Pet.MagicAtkReady, {main=Ready_MAB_Axe,
        head=Ready_MAcc_head,
		waist="Incarnation Sash",
        legs=Ready_MAcc_legs,
        feet=Ready_MAcc_feet})
    sets.midcast.Pet.MagicAtkReadyNE.HighAcc = set_combine(sets.midcast.Pet.MagicAtkReady, {main=Ready_MAB_Axe,
        head=Ready_MAcc_head,
		waist="Incarnation Sash",
        body=Ready_MAcc_body,
        hands=Ready_MAcc_hands,
        legs=Ready_MAcc_legs,
        feet=Ready_MAcc_feet})

    sets.midcast.Pet.MagicAccReadyNE = set_combine(sets.midcast.Pet.MagicAccReady, {main="Aymur"})

    sets.DTAxeShield = {main=Pet_PDT_AxeMain,
        sub="Pallas's Shield"}

    -- Dual-wield PetOnly Sets
    -- sets.midcast.Pet.ReadyRecastDWNE = {main="Kerehcatl",sub="Charmer's Merlin",legs="Desultor Tassets"}
	sets.midcast.Pet.ReadyRecastDWNE = {main=Ready_MAB_Axe_MAIN,sub="Charmer's Merlin",legs="Desultor Tassets"}

    sets.midcast.Pet.ReadyDWNE = set_combine(sets.midcast.Pet.ReadyNE, {sub=Ready_Atk_Axe})
    sets.midcast.Pet.ReadyDWNE.MedAcc = set_combine(sets.midcast.Pet.ReadyNE.MedAcc, {sub=Ready_Acc_Axe})
    sets.midcast.Pet.ReadyDWNE.HighAcc = set_combine(sets.midcast.Pet.ReadyNE.HighAcc, {sub=Ready_Acc_Axe})

    sets.midcast.Pet.MagicAtkReadyDWNE = set_combine(sets.midcast.Pet.MagicAtkReadyNE, {main=Ready_MAB_Axe_Main,sub=Ready_MAB_Axe})
    sets.midcast.Pet.MagicAtkReadyDWNE.MedAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.MedAcc, {main=Ready_MAB_Axe_Main,sub=Ready_MAB_Axe})
    sets.midcast.Pet.MagicAtkReadyDWNE.HighAcc = set_combine(sets.midcast.Pet.MagicAtkReadyNE.HighAcc, {main=Ready_MAB_Axe_Main,sub=Ready_MAcc_Axe})

    sets.midcast.Pet.MagicAccReadyDWNE = set_combine(sets.midcast.Pet.MagicAccReadyNE, {main=Ready_MAB_Axe_Main,sub=Ready_MAcc_Axe})

    sets.DTAxes = {main=Pet_PDT_AxeMain,
        sub=Pet_PDT_AxeSub}

    -- RESTING
    sets.resting = {}

    -- IDLE SETS
    sets.ExtraRegen = {waist="Muscle Belt +1"}
    sets.RegenAxes = {main="Hatxiik",sub="Hunahpu"}

    sets.idle = {ammo="Demonry Core",
        head="Twilight Helm",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Kirin's Osode",hands="Umuthi Gloves",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Repulse Mantle",waist="Flume Belt +1",legs="Iuitl Tights +1",feet="Skadi's Jambeaux +1"}

    sets.idle.Regen = {ammo="Demonry Core",
        head="Twilight Helm",neck="Bathy Choker +1",ear1="Infused Earring",ear2="Dawn Earring",
        body="Kirin's Osode",hands="Umuthi Gloves",ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back="Repulse Mantle",waist="Flume Belt +1",legs="Iuitl Tights +1",feet="Skadi's Jambeaux +1"}

    sets.idle.Refresh = set_combine(sets.idle, {head="Wivre Hairpin",body="Twilight Mail",legs="Stearc Subligar"})
    sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})

    sets.idle.Pet = set_combine(sets.idle, {ammo="Demonry Core",
        head=Hybrid_head,
        neck="Empath Necklace",ear1="Handler's Earring",ear2="Handler's Earring +1",
        body=Pet_PDT_body,
        hands=Pet_PDT_hands,
        ring1="Paguroidea Ring",ring2="Sheltered Ring",
        back=Pet_PDT_back,
        waist="Isa Belt",
        legs=Pet_PDT_legs,
        feet="Skadi's Jambeaux +1"})

    sets.idle.Pet.Engaged = {ammo="Demonry Core",
        head=Pet_Melee_head,
        neck="Ferine Necklace",ear1="Sabong Earring",ear2="Domesticator's Earring",
        body=Pet_Melee_body,
        hands=Pet_Melee_hands,
        ring1="Dark Ring",ring2="Defending Ring",
        back=Pet_PDT_back,
        waist="Incarnation Sash",
        legs=Pet_Melee_legs,
        feet=Pet_Melee_feet}

    -- DEFENSE SETS
    sets.defense.PDT = {ammo="Hasty Pinion +1",
        head="Ighwa Cap",neck="Agitator's Collar",
        body="Emet Harness +1",hands="Umuthi Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Repulse Mantle",waist="Flume Belt +1",legs="Iuitl Tights +1",feet="Diamantaire Sollerets"}

    sets.defense.Killer = set_combine(sets.defense.PDT, {ammo="Bibiki Seashell",head="Ankusa Helm +1",
        hands=DW_hands,
        ring1="Patricius Ring",ring2="Oneiros Annulet",
        waist="Incarnation Sash",
        legs=DW_legs,
        feet=DW_feet})

    sets.defense.Reraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

    sets.defense.PetPDT = {
	    head="Anwig Salade",ear1="Handler's Earring",ear2="Handler's Earring +1",
		neck="Twilight Torque",ring1="Dark Ring",ring2="Defending Ring",
        body=Pet_PDT_body,
        hands=Pet_PDT_hands,
        back=Pet_PDT_back,
        waist="Isa Belt",
        legs=Pet_PDT_legs,
        feet=Pet_PDT_feet}

    sets.defense.MDT = set_combine(sets.defense.PDT, {ammo="Sihirik",
        head="Iuitl Headgear +1",neck="Twilight Torque",ear1="Sanare Earring",ear2="Etiolation Earring",
        body="Savas Jawshan",
        back="Engulfer Cape +1",waist="Nierenschutz"})

    sets.defense.MDTShell = set_combine(sets.defense.MDT, {ammo="Vanir Battery",
        neck="Inquisitor Bead Necklace",ear1="Sanare Earring",
        ring1="Shadow Ring",back="Engulfer Cape +1",waist="Resolute Belt"})

    sets.Kiting = {feet="Skadi's Jambeaux +1"}

    -- MELEE (SINGLE-WIELD) SETS
    sets.engaged = {ammo="Paeapua",
        head="Otomi Helm",neck="Asperity Necklace",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Mes'yohi Haubergeon",hands="Xaddi Gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet}
    sets.engaged.LowAccHaste = sets.engaged
    sets.engaged.MedAcc = {ammo="Paeapua",
        head=Hybrid_head,
        neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Bladeborn Earring",
        body="Mes'yohi Haubergeon",
        hands=DW_hands,
        ring1="Rajas Ring",ring2="Epona's Ring",
        back="Grounded Mantle +1",waist="Incarnation Sash",
        legs=Hybrid_legs,
        feet=Hybrid_feet}
    sets.engaged.MedAccHaste = sets.engaged.MedAcc
    sets.engaged.HighAcc = {ammo="Hasty Pinion +1",
        head=Hybrid_head,
        neck="Subtlety Spectacles",ear1="Steelflash Earring",ear2="Zennaroi Earring",
        body="Mes'yohi Haubergeon",
        hands=DW_hands,
        ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Grounded Mantle +1",waist="Olseni Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet}
    sets.engaged.HighAccHaste = sets.engaged.HighAcc
    sets.engaged.Aftermath = set_combine(sets.engaged, {hands="Aetosaur Gloves +1"})
    sets.engaged.LowAccHaste.Aftermath = sets.engaged.Aftermath
    sets.engaged.MedAcc.Aftermath = set_combine(sets.engaged.MedAcc, {hands="Aetosaur Gloves +1"})
    sets.engaged.MedAccHaste.Aftermath = sets.engaged.MedAcc.Aftermath
    sets.engaged.HighAcc.Aftermath = set_combine(sets.engaged.HighAcc)
    sets.engaged.HighAccHaste.Aftermath = sets.engaged.HighAcc.Aftermath

    -- MELEE (SINGLE-WIELD) HYBRID SETS
    sets.engaged.Hybrid = set_combine(sets.engaged, {head="Iuitl Headgear +1",
        back="Mollusca Mantle",hands="Umuthi Gloves",legs="Iuitl Tights +1",feet="Diamantaire Sollerets"})
    sets.engaged.LowAccHaste.Hybrid = sets.engaged.Hybrid
    sets.engaged.MedAcc.Hybrid = set_combine(sets.engaged.MedAcc, {head="Iuitl Headgear +1",
        legs="Iuitl Tights +1",feet="Diamantaire Sollerets"})
    sets.engaged.MedAccHaste.Hybrid = sets.engaged.MedAcc.Hybrid
    sets.engaged.HighAcc.Hybrid = set_combine(sets.engaged.HighAcc, {head="Iuitl Headgear +1",
        legs="Iuitl Tights +1",feet="Diamantaire Sollerets"})
    sets.engaged.HighAccHaste.Hybrid = sets.engaged.HighAcc.Hybrid

    -- MELEE (DUAL-WIELD) SETS FOR DNC AND NIN SUBJOB
    sets.engaged.DW = {ammo="Paeapua",
        head=DW_head,
        neck="Asperity Necklace",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        body=DW_body,
        hands=DW_hands,
        ring1="Rajas Ring",ring2="Epona's Ring",
        back="Vellaunus' Mantle +1",waist="Patentia Sash",
        legs=DW_legs,
        feet=DW_feet}
    sets.engaged.DW.LowAccHaste = {ammo="Paeapua",
        head="Otomi Helm",neck="Asperity Necklace",ear1="Suppanomimi",ear2="Brutal Earring",
        body=DW_body,
        hands="Xaddi Gauntlets",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Bleating Mantle",waist="Windbuffet Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet}
    sets.engaged.DW.MedAcc = {ammo="Hasty Pinion +1",
        head=DW_head,
        neck="Subtlety Spectacles",ear1="Heartseeker Earring",ear2="Dudgeon Earring",
        body=DW_body,
        hands=DW_hands,
        ring1="Rajas Ring",ring2="Epona's Ring",
        back="Vellaunus' Mantle +1",waist="Patentia Sash",
        legs=DW_legs,
        feet=DW_feet}
    sets.engaged.DW.MedAccHaste = {ammo="Hasty Pinion +1",
        head=Hybrid_head,
        neck="Subtlety Spectacles",ear1="Suppanomimi",ear2="Brutal Earring",
        body="Mes'yohi Haubergeon",
        hands=DW_hands,
        ring1="Rajas Ring",ring2="Epona's Ring",
        back="Grounded Mantle +1",waist="Incarnation Sash",
        legs=Hybrid_legs,
        feet=Hybrid_feet}
    sets.engaged.DW.HighAcc = {ammo="Hasty Pinion +1",
        head=Hybrid_head,
        neck="Subtlety Spectacles",ear1="Heartseeker Earring",ear2="Zennaroi Earring",
        body=DW_body,
        hands=DW_hands,
        ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Grounded Mantle +1",waist="Olseni Belt",
        legs=DW_legs,
        feet=DW_feet}
    sets.engaged.DW.HighAccHaste = {ammo="Hasty Pinion +1",
        head=Hybrid_head,
        neck="Subtlety Spectacles",ear1="Heartseeker Earring",ear2="Zennaroi Earring",
        body="Mes'yohi Haubergeon",
        hands=DW_hands,
        ring1="Mars's Ring",ring2="Oneiros Annulet",
        back="Grounded Mantle +1",waist="Olseni Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet}
    sets.engaged.DW.Aftermath = sets.engaged.DW
    sets.engaged.DW.LowAccHaste.Aftermath = sets.engaged.DW.Aftermath
    sets.engaged.DW.MedAcc.Aftermath = sets.engaged.DW.MedAcc
    sets.engaged.DW.MedAccHaste.Aftermath = sets.engaged.DW.MedAcc.Aftermath
    sets.engaged.DW.HighAcc.Aftermath = sets.engaged.DW.HighAcc
    sets.engaged.DW.HighAccHaste.Aftermath = sets.engaged.DW.HighAcc.Aftermath
    -- MELEE (DUAL-WIELD) HYBRID SETS
    sets.engaged.DW.Hybrid = set_combine(sets.engaged.DW, {head="Iuitl Headgear +1",
        back="Mollusca Mantle",hands="Umuthi Gloves",legs="Iuitl Tights +1",feet="Diamantaire Sollerets"})
    sets.engaged.DW.LowAccHaste.Hybrid = sets.engaged.DW.Hybrid
    sets.engaged.DW.MedAcc.Hybrid = set_combine(sets.engaged.DW.MedAcc, {head="Iuitl Headgear +1",
        legs="Iuitl Tights +1",feet="Diamantaire Sollerets"})
    sets.engaged.DW.MedAccHaste.Hybrid =sets.engaged.DW.MedAcc.Hybrid
    sets.engaged.DW.HighAcc.Hybrid = set_combine(sets.engaged.DW.HighAcc, {head="Iuitl Headgear +1",
        legs="Iuitl Tights +1",feet="Diamantaire Sollerets"})
    sets.engaged.DW.HighAccHaste.Hybrid = sets.engaged.DW.HighAcc.Hybrid

    -- GEARSETS FOR MASTER ENGAGED (SINGLE-WIELD) & PET TANKING
    sets.engaged.PetTank = set_combine(sets.engaged, {
        head=Hybrid_head,
        neck="Shepherd's Chain",ear1="Handler's Earring",ear2="Handler's Earring +1",
        body=Hybrid_body,
        hands=Hybrid_hands,
        ring1="Thurandaut Ring",
        back=Pet_PDT_back,
        waist="Isa Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet})
    sets.engaged.PetTank.LowAccHaste = sets.engaged.PetTank
    sets.engaged.PetTank.MedAcc = sets.engaged.PetTank
    sets.engaged.PetTank.MedAccHaste = sets.engaged.PetTank
    sets.engaged.PetTank.HighAcc = sets.engaged.PetTank
    sets.engaged.PetTank.HighAccHaste = sets.engaged.PetTank

    -- GEARSETS FOR MASTER ENGAGED (DUAL-WIELD) & PET TANKING
    sets.engaged.DW.PetTank = set_combine(sets.engaged.DW, {
        head=Pet_PDT_head,
        neck="Shepherd's Chain",ear1="Handler's Earring",ear2="Handler's Earring +1",
        body=Hybrid_body,
        hands=Hybrid_hands,
        ring1="Thurandaut Ring",
        back=Pet_PDT_back,
        waist="Isa Belt",
        legs=Hybrid_legs,
        feet=Hybrid_feet})
    sets.engaged.DW.PetTank.LowAccHaste = sets.engaged.DW.PetTank
    sets.engaged.DW.PetTank.MedAcc = set_combine(sets.engaged.DW.MedAcc, {
        head=Hybrid_head,
        ear1="Handler's Earring",ear2="Handler's Earring +1",
        body=Hybrid_body,
        ring1="Thurandaut Ring",
        hands=Hybrid_hands,
        legs=Hybrid_legs,
        feet=Hybrid_feet})
    sets.engaged.DW.PetTank.MedAccHaste = sets.engaged.DW.PetTank.MedAcc
    sets.engaged.DW.PetTank.HighAcc = set_combine(sets.engaged.DW.HighAcc, {
        head=Hybrid_head,
        ear1="Handler's Earring",ear2="Handler's Earring +1",
        body="Mes'yohi Haubergeon",
        hands=Hybrid_hands,
        ring1="Thurandaut Ring",
        legs=Hybrid_legs,
        feet=Hybrid_feet})
    sets.engaged.DW.PetTank.HighAccHaste = sets.engaged.DW.PetTank.HighAcc

    sets.buff['Killer Instinct'] = {body="Nukumi Gausape +1"}
    sets.buff.Doomed = {ring1="Eshmun's Ring"}
    sets.THBelt = {waist="Chaac Belt"}
    sets.DaytimeAmmo = {ammo="Tengu-no-Hane"}

-------------------------------------------------------------------------------------------------------------------
-- Complete Lvl 76-99 Jug Pet Precast List +Funguar +Courier +Amigo
-------------------------------------------------------------------------------------------------------------------

    sets.precast.JA['Bestial Loyalty'].FunguarFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Seedbed Soil"})
    sets.precast.JA['Bestial Loyalty'].CourierCarrie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fish Oil Broth"})
    sets.precast.JA['Bestial Loyalty'].AmigoSabotender = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sun Water"})
    sets.precast.JA['Bestial Loyalty'].NurseryNazuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="D. Herbal Broth"})
    sets.precast.JA['Bestial Loyalty'].CraftyClyvonne = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cng. Brain Broth"})
    sets.precast.JA['Bestial Loyalty'].PrestoJulio = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Grass. Broth"})
    sets.precast.JA['Bestial Loyalty'].SwiftSieghard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Mlw. Bird Broth"})
    sets.precast.JA['Bestial Loyalty'].MailbusterCetas = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Gob. Bug Broth"})
    sets.precast.JA['Bestial Loyalty'].AudaciousAnna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
    sets.precast.JA['Bestial Loyalty'].TurbidToloi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Auroral Broth"})
    sets.precast.JA['Bestial Loyalty'].LuckyLulush = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="L. Carrot Broth"})
    sets.precast.JA['Bestial Loyalty'].DipperYuly = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wool Grease"})
    sets.precast.JA['Bestial Loyalty'].FlowerpotMerle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vermihumus"})
    sets.precast.JA['Bestial Loyalty'].DapperMac = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Briny Broth"})
    sets.precast.JA['Bestial Loyalty'].DiscreetLouise = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepbed Soil"})
    sets.precast.JA['Bestial Loyalty'].FatsoFargann = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="C. Plasma Broth"})
    sets.precast.JA['Bestial Loyalty'].FaithfulFalcorr = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lucky Broth"})
    sets.precast.JA['Bestial Loyalty'].BugeyedBroncha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Svg. Mole Broth"})
    sets.precast.JA['Bestial Loyalty'].BloodclawShasra = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rzr. Brain Broth"})
    sets.precast.JA['Bestial Loyalty'].GorefangHobs = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="B. Carrion Broth"})
    sets.precast.JA['Bestial Loyalty'].GooeyGerard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Cl. Wheat Broth"})
    sets.precast.JA['Bestial Loyalty'].CrudeRaphie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shadowy Broth"})

-------------------------------------------------------------------------------------------------------------------
-- Complete iLvl Jug Pet Precast List
-------------------------------------------------------------------------------------------------------------------

    sets.precast.JA['Bestial Loyalty'].DroopyDortwin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Swirling Broth"})
    sets.precast.JA['Bestial Loyalty'].PonderingPeter = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Vis. Broth"})
    sets.precast.JA['Bestial Loyalty'].SunburstMalfik = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Shimmering Broth"})
    sets.precast.JA['Bestial Loyalty'].AgedAngus = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Ferm. Broth"})
    sets.precast.JA['Bestial Loyalty'].WarlikePatrick = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Livid Broth"})
    sets.precast.JA['Bestial Loyalty'].ScissorlegXerin = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Spicy Broth"})
    sets.precast.JA['Bestial Loyalty'].BouncingBertha = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bubbly Broth"})
    sets.precast.JA['Bestial Loyalty'].RhymingShizuna = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Lyrical Broth"})
    sets.precast.JA['Bestial Loyalty'].AttentiveIbuki = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Salubrious Broth"})
    sets.precast.JA['Bestial Loyalty'].SwoopingZhivago = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Windy Greens"})
    sets.precast.JA['Bestial Loyalty'].AmiableRoche = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Airy Broth"})
    sets.precast.JA['Bestial Loyalty'].HeraldHenry = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Trans. Broth"})
    sets.precast.JA['Bestial Loyalty'].BrainyWaluis = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crumbly Soil"})
    sets.precast.JA['Bestial Loyalty'].HeadbreakerKen = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Blackwater Broth"})
    sets.precast.JA['Bestial Loyalty'].RedolentCandi = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Electrified Broth"})
    sets.precast.JA['Bestial Loyalty'].AlluringHoney = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Bug-Ridden Broth"})
    sets.precast.JA['Bestial Loyalty'].CaringKiyomaro = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Fizzy Broth"})
    sets.precast.JA['Bestial Loyalty'].VivaciousVickie = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Tant. Broth"})
    sets.precast.JA['Bestial Loyalty'].HurlerPercival = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Pale Sap"})
    sets.precast.JA['Bestial Loyalty'].BlackbeardRandy = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Meaty Broth"})
    sets.precast.JA['Bestial Loyalty'].GenerousArthur = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Dire Broth"})
    sets.precast.JA['Bestial Loyalty'].ThreestarLynn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Muddy Broth"})
    sets.precast.JA['Bestial Loyalty'].BraveHeroGlenn = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wispy Broth"})
    sets.precast.JA['Bestial Loyalty'].SharpwitHermes = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Saline Broth"})
    sets.precast.JA['Bestial Loyalty'].ColibriFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sugary Broth"})
    sets.precast.JA['Bestial Loyalty'].ChoralLeera = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Glazed Broth"})
    sets.precast.JA['Bestial Loyalty'].SpiderFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Sticky Webbing"})
    sets.precast.JA['Bestial Loyalty'].GussyHachirobe = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Slimy Webbing"})
    sets.precast.JA['Bestial Loyalty'].AcuexFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Poisonous Broth"})
    sets.precast.JA['Bestial Loyalty'].FluffyBredo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Venomous Broth"})
    sets.precast.JA['Bestial Loyalty'].SuspiciousAlice = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Furious Broth"})
    sets.precast.JA['Bestial Loyalty'].AnklebiterJedd = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Crackling Broth"})
    sets.precast.JA['Bestial Loyalty'].FleetReinhard = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Rapid Broth"})
    sets.precast.JA['Bestial Loyalty'].CursedAnnabelle = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Creepy Broth"})
    sets.precast.JA['Bestial Loyalty'].SurgingStorm = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Insipid Broth"})
    sets.precast.JA['Bestial Loyalty'].SubmergedIyo = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Deepwater Broth"})
    sets.precast.JA['Bestial Loyalty'].MosquitoFamiliar = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Wetlands Broth"})
    sets.precast.JA['Bestial Loyalty'].LeftHandedYoko = set_combine(sets.precast.JA['Bestial Loyalty'], {ammo="Heavenly Broth"})
end

-------------------------------------------------------------------------------------------------------------------
-- General hooks for other game events.
-------------------------------------------------------------------------------------------------------------------

function job_buff_change(buff, gain)
    if buff == 'Aftermath: Lv.3' and gain then
        job_update(cmdParams, eventArgs)
                handle_equipping_gear(player.status)
    else
        job_update(cmdParams, eventArgs)
        handle_equipping_gear(player.status)
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks that are called to process player actions at specific points in time.
-------------------------------------------------------------------------------------------------------------------

function job_precast(spell, action, spellMap, eventArgs)
    if player.equipment.main == 'Aymur' then
        custom_aftermath_timers_precast(spell)
    end

    if spell.type == "WeaponSkill" and spell.name ~= 'Mistral Axe' and spell.name ~= 'Bora Axe' and spell.target.distance > target_distance then
        cancel_spell()
        add_to_chat(123, spell.name..' Canceled: [Out of Range]')
        handle_equipping_gear(player.status)
        return
    end

    if spell.type == 'CorsairRoll' or spell.english == "Double-Up" then
        equip(sets.precast.LuzafRing)
    end

    if spell.english == 'Reward' then
        if state.RewardMode.value == 'Theta' then
            equip(sets.precast.JA.Reward.Theta)
        elseif state.RewardMode.value == 'Zeta' then
            equip(sets.precast.JA.Reward.Zeta)
        elseif state.RewardMode.value == 'Eta' then
            equip(sets.precast.JA.Reward.Eta)
        end
    end

    if spell.english == 'Bestial Loyalty' or spell.english == 'Call Beast' then
        if state.JugMode.value == 'FunguarFamiliar' then
            equip(sets.precast.JA['Bestial Loyalty'].FunguarFamiliar)
        elseif state.JugMode.value == 'CourierCarrie' then
            equip(sets.precast.JA['Bestial Loyalty'].CourierCarrie)
        elseif state.JugMode.value == 'AmigoSabotender' then
            equip(sets.precast.JA['Bestial Loyalty'].AmigoSabotender)
        elseif state.JugMode.value == 'NurseryNazuna' then
            equip(sets.precast.JA['Bestial Loyalty'].NurseryNazuna)
        elseif state.JugMode.value == 'CraftyClyvonne' then
            equip(sets.precast.JA['Bestial Loyalty'].CraftyClyvonne)
        elseif state.JugMode.value == 'PrestoJulio' then
            equip(sets.precast.JA['Bestial Loyalty'].PrestoJulio)
        elseif state.JugMode.value == 'SwiftSieghard' then
            equip(sets.precast.JA['Bestial Loyalty'].SwiftSieghard)
        elseif state.JugMode.value == 'MailbusterCetas' then
            equip(sets.precast.JA['Bestial Loyalty'].MailbusterCetas)
        elseif state.JugMode.value == 'AudaciousAnna' then
            equip(sets.precast.JA['Bestial Loyalty'].AudaciousAnna)
        elseif state.JugMode.value == 'TurbidToloi' then
            equip(sets.precast.JA['Bestial Loyalty'].TurbidToloi)
        elseif state.JugMode.value == 'SlipperySilas' then
            equip(sets.precast.JA['Bestial Loyalty'].SlipperySilas)
        elseif state.JugMode.value == 'LuckyLulush' then
            equip(sets.precast.JA['Bestial Loyalty'].LuckyLulush)
        elseif state.JugMode.value == 'DipperYuly' then
            equip(sets.precast.JA['Bestial Loyalty'].DipperYuly)
        elseif state.JugMode.value == 'FlowerpotMerle' then
            equip(sets.precast.JA['Bestial Loyalty'].FlowerpotMerle)
        elseif state.JugMode.value == 'DapperMac' then
            equip(sets.precast.JA['Bestial Loyalty'].DapperMac)
        elseif state.JugMode.value == 'DiscreetLouise' then
            equip(sets.precast.JA['Bestial Loyalty'].DiscreetLouise)
        elseif state.JugMode.value == 'FatsoFargann' then
            equip(sets.precast.JA['Bestial Loyalty'].FatsoFargann)
        elseif state.JugMode.value == 'FaithfulFalcorr' then
            equip(sets.precast.JA['Bestial Loyalty'].FaithfulFalcorr)
        elseif state.JugMode.value == 'BugeyedBroncha' then
            equip(sets.precast.JA['Bestial Loyalty'].BugeyedBroncha)
        elseif state.JugMode.value == 'BloodclawShasra' then
            equip(sets.precast.JA['Bestial Loyalty'].BloodclawShasra)
        elseif state.JugMode.value == 'GorefangHobs' then
            equip(sets.precast.JA['Bestial Loyalty'].GorefangHobs)
        elseif state.JugMode.value == 'GooeyGerard' then
            equip(sets.precast.JA['Bestial Loyalty'].GooeyGerard)
        elseif state.JugMode.value == 'CrudeRaphie' then
            equip(sets.precast.JA['Bestial Loyalty'].CrudeRaphie)
        elseif state.JugMode.value == 'DroopyDortwin' then
            equip(sets.precast.JA['Bestial Loyalty'].DroopyDortwin)
        elseif state.JugMode.value == 'PonderingPeter' then
            equip(sets.precast.JA['Bestial Loyalty'].PonderingPeter)
        elseif state.JugMode.value == 'SunburstMalfik' then
            equip(sets.precast.JA['Bestial Loyalty'].SunburstMalfik)
        elseif state.JugMode.value == 'AgedAngus' then
            equip(sets.precast.JA['Bestial Loyalty'].AgedAngus)
        elseif state.JugMode.value == 'WarlikePatrick' then
            equip(sets.precast.JA['Bestial Loyalty'].WarlikePatrick)
        elseif state.JugMode.value == 'ScissorlegXerin' then
            equip(sets.precast.JA['Bestial Loyalty'].ScissorlegXerin)
        elseif state.JugMode.value == 'BouncingBertha' then
            if spell.english == 'Call Beast' then
                add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
                return
            end
            equip(sets.precast.JA['Bestial Loyalty'].BouncingBertha)
        elseif state.JugMode.value == 'RhymingShizuna' then
            equip(sets.precast.JA['Bestial Loyalty'].RhymingShizuna)
        elseif state.JugMode.value == 'AttentiveIbuki' then
            equip(sets.precast.JA['Bestial Loyalty'].AttentiveIbuki)
        elseif state.JugMode.value == 'SwoopingZhivago' then
            if spell.english == 'Call Beast' then
                add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
                return
            end
            equip(sets.precast.JA['Bestial Loyalty'].SwoopingZhivago)
        elseif state.JugMode.value == 'AmiableRoche' then
            equip(sets.precast.JA['Bestial Loyalty'].AmiableRoche)
        elseif state.JugMode.value == 'HeraldHenry' then
            equip(sets.precast.JA['Bestial Loyalty'].HeraldHenry)
        elseif state.JugMode.value == 'BrainyWaluis' then
            equip(sets.precast.JA['Bestial Loyalty'].BrainyWaluis)
        elseif state.JugMode.value == 'HeadbreakerKen' then
            equip(sets.precast.JA['Bestial Loyalty'].HeadbreakerKen)
        elseif state.JugMode.value == 'RedolentCandi' then
            equip(sets.precast.JA['Bestial Loyalty'].RedolentCandi)
        elseif state.JugMode.value == 'AlluringHoney' then
            if spell.english == 'Call Beast' then
                add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
                return
            end
            equip(sets.precast.JA['Bestial Loyalty'].AlluringHoney)
        elseif state.JugMode.value == 'CaringKiyomaro' then
            equip(sets.precast.JA['Bestial Loyalty'].CaringKiyomaro)
        elseif state.JugMode.value == 'VivaciousVickie' then
            if spell.english == 'Call Beast' then
                add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
                return
            end
            equip(sets.precast.JA['Bestial Loyalty'].VivaciousVickie)
        elseif state.JugMode.value == 'HurlerPercival' then
            equip(sets.precast.JA['Bestial Loyalty'].HurlerPercival)
        elseif state.JugMode.value == 'BlackbeardRandy' then
            equip(sets.precast.JA['Bestial Loyalty'].BlackbeardRandy)
        elseif state.JugMode.value == 'GenerousArthur' then
            equip(sets.precast.JA['Bestial Loyalty'].GenerousArthur)
        elseif state.JugMode.value == 'ThreestarLynn' then
            equip(sets.precast.JA['Bestial Loyalty'].ThreestarLynn)
        elseif state.JugMode.value == 'BraveHeroGlenn' then
            equip(sets.precast.JA['Bestial Loyalty'].BraveHeroGlenn)
        elseif state.JugMode.value == 'SharpwitHermes' then
            equip(sets.precast.JA['Bestial Loyalty'].SharpwitHermes)
        elseif state.JugMode.value == 'ColibriFamiliar' then
            equip(sets.precast.JA['Bestial Loyalty'].ColibriFamiliar)
        elseif state.JugMode.value == 'ChoralLeera' then
            if spell.english == 'Call Beast' then
                add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
                return
            end
            equip(sets.precast.JA['Bestial Loyalty'].ChoralLeera)
        elseif state.JugMode.value == 'SpiderFamiliar' then
            equip(sets.precast.JA['Bestial Loyalty'].SpiderFamiliar)
        elseif state.JugMode.value == 'GussyHachirobe' then
            if spell.english == 'Call Beast' then
                add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
                return
            end
            equip(sets.precast.JA['Bestial Loyalty'].GussyHachirobe)
        elseif state.JugMode.value == 'AcuexFamiliar' then
            equip(sets.precast.JA['Bestial Loyalty'].AcuexFamiliar)
        elseif state.JugMode.value == 'FluffyBredo' then
            if spell.english == 'Call Beast' then
                add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
                return
            end
            equip(sets.precast.JA['Bestial Loyalty'].FluffyBredo)
        elseif state.JugMode.value == 'SuspiciousAlice' then
            equip(sets.precast.JA['Bestial Loyalty'].SuspiciousAlice)
        elseif state.JugMode.value == 'AnklebiterJedd' then
            equip(sets.precast.JA['Bestial Loyalty'].AnklebiterJedd)
        elseif state.JugMode.value == 'FleetReinhard' then
            equip(sets.precast.JA['Bestial Loyalty'].FleetReinhard)
        elseif state.JugMode.value == 'CursedAnnabelle' then
            equip(sets.precast.JA['Bestial Loyalty'].CursedAnnabelle)
        elseif state.JugMode.value == 'SurgingStorm' then
            equip(sets.precast.JA['Bestial Loyalty'].SurgingStorm)
        elseif state.JugMode.value == 'SubmergedIyo' then
            if spell.english == 'Call Beast' then
                add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
                return
            end
            equip(sets.precast.JA['Bestial Loyalty'].SubmergedIyo)
        elseif state.JugMode.value == 'MosquitoFamiliar' then
            equip(sets.precast.JA['Bestial Loyalty'].MosquitoFamiliar)
        elseif state.JugMode.value == 'Left-HandedYoko' then
            if spell.english == 'Call Beast' then
                add_to_chat(123, spell.name..' Canceled: [HQ Jug Pet]')
                return
            end
            equip(sets.precast.JA['Bestial Loyalty'].LeftHandedYoko)
        end
    end

-- Define class for Sic and Ready moves.
    if spell.type == "Monster" then
            classes.CustomClass = "WS"
        if state.PetMode.Value == 'PetOnly' and not buffactive['Unleash']then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.midcast.Pet.ReadyRecastDWNE)
            else
                equip(sets.midcast.Pet.ReadyRecastNE)
            end
        else
            equip(sets.midcast.Pet.ReadyRecast)
        end
    end
end

function job_post_precast(spell, action, spellMap, eventArgs)
-- If Killer Instinct is active during WS, equip Nukumi Gausape +1.
    if spell.type:lower() == 'weaponskill' and buffactive['Killer Instinct'] then
        equip(sets.buff['Killer Instinct'])
    end

    if world.time >= 17*60 or world.time < 7*60 then
        if spell.english == "Ruinator" or spell.english == "Rampage" or spell.english == "Calamity" then
            equip(sets.midcast.NightEarrings)
        end
    end

    if spell.english == "Primal Rend" and player.tp > 2750 then
        equip(sets.midcast.ExtraMAB)
    end

-- Equip Chaac Belt for TH+1 on common Subjob Abilities or Spells.
    if abilities_to_check:contains(spell.english) and state.TreasureMode.value == 'Tag' then
        equip(sets.THBelt)
    end
end

function job_pet_midcast(spell, action, spellMap, eventArgs)
    if physical_ready_moves:contains(spell.name) then
        if state.PetMode.value == 'PetOnly' then
            if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    equip(sets.midcast.Pet.ReadyDWNE.HighAcc, sets.midcast.Pet[state.CorrelationMode.value])
                else
                    equip(sets.midcast.Pet.ReadyNE.HighAcc, sets.midcast.Pet[state.CorrelationMode.value])
                end
            elseif state.OffenseMode.value == 'MedAcc' or state.OffenseMode.value == 'MedAccHaste' then
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    equip(sets.midcast.Pet.ReadyDWNE.MedAcc, sets.midcast.Pet[state.CorrelationMode.value])
                else
                    equip(sets.midcast.Pet.ReadyNE.MedAcc, sets.midcast.Pet[state.CorrelationMode.value])
                end
            else
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    equip(set_combine(sets.midcast.Pet.ReadyDWNE, sets.midcast.Pet[state.CorrelationMode.value]))
                else
                    equip(set_combine(sets.midcast.Pet.ReadyNE, sets.midcast.Pet[state.CorrelationMode.value]))
                end
            end
        else
            if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
                equip(sets.midcast.Pet.HighAcc, sets.midcast.Pet[state.CorrelationMode.value])
            elseif state.OffenseMode.value == 'MedAcc' or state.OffenseMode.value == 'MedAccHaste' then
                equip(sets.midcast.Pet.MedAcc, sets.midcast.Pet[state.CorrelationMode.value])
            else
                equip(set_combine(sets.midcast.Pet.WS, sets.midcast.Pet[state.CorrelationMode.value]))
            end
        end
    end

    if magic_atk_ready_moves:contains(spell.name) then
        if state.PetMode.value == 'PetOnly' then
            if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    equip(sets.midcast.Pet.MagicAtkReadyDWNE.HighAcc)
                else
                    equip(sets.midcast.Pet.MagicAtkReadyNE.HighAcc)
                end
            elseif state.OffenseMode.value == 'MedAcc' or state.OffenseMode.value == 'MedAccHaste' then
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    equip(sets.midcast.Pet.MagicAtkReadyDWNE.MedAcc)
                else
                    equip(sets.midcast.Pet.MagicAtkReadyNE.MedAcc)
                end
            else
                if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                    equip(sets.midcast.Pet.MagicAtkReadyDWNE)
                else
                    equip(sets.midcast.Pet.MagicAtkReadyNE)
                end
            end
        else
            equip(sets.midcast.Pet.MagicAtkReady)
        end
    end

    if magic_acc_ready_moves:contains(spell.name) then
        if state.PetMode.value == 'PetOnly' then
            if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                equip(sets.midcast.Pet.MagicAccReadyDWNE)
            else
                equip(sets.midcast.Pet.MagicAccReadyNE)
            end
        else
            equip(sets.midcast.Pet.MagicAccReady)
        end
    end

    -- If Pet TP, before bonuses, is less than a certain value then equip Nukumi Manoplas +1
    if physical_ready_moves:contains(spell.name) and state.OffenseMode.value ~= 'HighAcc' then
            equip(sets.midcast.Pet.TPBonus)
    end
end

function job_pet_aftercast(spell, action, spellMap, eventArgs)
    if state.PetMode.value == 'PetOnly' then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            equip(sets.DTAxes)
        else
            equip(sets.DTAxeShield)
        end
    end
end

-- Return true if we handled the aftercast work.  Otherwise it will fall back
-- to the general aftercast() code in Mote-Include.
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.equipment.main == 'Aymur' then
        custom_aftermath_timers_aftercast(spell)
    end

    if world.time >= 360 and world.time < 1080 then
        if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
            if player.status == 'Engaged' then
                equip(sets.DaytimeAmmo)
            end
        end
    end

    if state.PetMode.value == 'PetOnly' then
        if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
            equip(sets.DTAxes)
        else
            equip(sets.DTAxeShield)
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Customization hook for idle sets.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 50 and pet.status ~= 'Engaged' then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    return idleSet
end

-------------------------------------------------------------------------------------------------------------------
-- Hooks for Reward, Correlation, Treasure Hunter, and Pet Mode handling.
-------------------------------------------------------------------------------------------------------------------

function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Correlation Mode' then
        state.CorrelationMode:set(newValue)
    elseif stateField == 'Reward Mode' then
        state.RewardMode:set(newValue)
    elseif stateField == 'Treasure Mode' then
        state.TreasureMode:set(newValue)
    elseif stateField == 'Pet Mode' then
        state.CombatWeapon:set(newValue)
    end

    if world.time >= 360 and world.time < 1080 then
        if state.OffenseMode.value == 'HighAcc' or state.OffenseMode.value == 'HighAccHaste' then
            if player.status == 'Engaged' then
                equip(sets.DaytimeAmmo)
            end
        end
    end
end

function get_custom_wsmode(spell, spellMap, default_wsmode)
    if default_wsmode == 'Normal' then
        if spell.english == "Ruinator" and (world.day_element == 'Water' or world.day_element == 'Wind' or world.day_element == 'Ice') then
            return 'Gavialis'
        end
    end
end

-------------------------------------------------------------------------------------------------------------------
-- User code that supplements self-commands.
-------------------------------------------------------------------------------------------------------------------

-- Called any time we attempt to handle automatic gear equips (ie: engaged or idle gear).
function job_handle_equipping_gear(playerStatus, eventArgs)    	
    if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' or player.equipment.back == 'Nexus Cape' then
        disable('back')
    else
        enable('back')
    end
        if player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Trizek Ring' or player.equipment.ring1 == 'Capacity Ring' then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Trizek Ring' or player.equipment.ring2 == 'Capacity Ring' then
        disable('ring2')
    else
        enable('ring2')
    end
end

-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    get_combat_form()
    get_melee_groups()

        if state.JugMode.value == 'FunguarFamiliar' then
                PetInfo = "Funguar, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Frogkick'
                ReadyMoveTwo = 'Spore'
                ReadyMoveThree = 'Silence Gas'
        elseif state.JugMode.value == 'CourierCarrie' then
                PetInfo = "Crab, Aquan"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Big Scissors'
                ReadyMoveTwo = 'Scissor Guard'
                ReadyMoveThree = 'Bubble Curtain'
        elseif state.JugMode.value == 'AmigoSabotender' then
                PetInfo = "Cactuar, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Needle Shot'
                ReadyMoveTwo = '??? Needles'
                ReadyMoveThree = '??? Needles'
        elseif state.JugMode.value == 'NurseryNazuna' then
                PetInfo = "Sheep, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Lamb Chop'
                ReadyMoveTwo = 'Rage'
                ReadyMoveThree = 'Sheep Song'
        elseif state.JugMode.value == 'CraftyClyvonne' then
                PetInfo = "Coeurl, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Blaster'
                ReadyMoveTwo = 'Chaotic Eye'
                ReadyMoveThree = 'None'
        elseif state.JugMode.value == 'PrestoJulio' then
                PetInfo = "Flytrap, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Frogkick'
                ReadyMoveTwo = 'Spore'
                ReadyMoveThree = 'Silence Gas'
        elseif state.JugMode.value == 'SwiftSieghard' then
                PetInfo = "Raptor, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Scythe Tail'
                ReadyMoveTwo = 'Ripper Fang'
                ReadyMoveThree = 'Chomp Rush'
        elseif state.JugMode.value == 'MailbusterCetas' then
                PetInfo = "Fly, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Somersault'
                ReadyMoveTwo = 'Cursed Sphere'
                ReadyMoveThree = 'Venom'
        elseif state.JugMode.value == 'AudaciousAnna' then
                PetInfo = "Lizard, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Tail Blow'
                ReadyMoveTwo = 'Brain Crush'
                ReadyMoveThree = 'Fireball'
        elseif state.JugMode.value == 'TurbidToloi' then
                PetInfo = "Pugil, Aquan"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Recoil Dive'
                ReadyMoveTwo = 'Water Wall'
                ReadyMoveThree = 'Intimidate'
        elseif state.JugMode.value == 'SlipperySilas' then
                PetInfo = "Toad, Aquan"
                PetJob = 'Warrior'
                ReadyMoveOne = 'None'
                ReadyMoveTwo = 'None'
                ReadyMoveThree = 'None'
        elseif state.JugMode.value == 'LuckyLulush' then
                PetInfo = "Rabbit, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Foot Kick'
                ReadyMoveTwo = 'Whirl Claws'
                ReadyMoveThree = 'Wild Carrot'
        elseif state.JugMode.value == 'DipperYuly' then
                PetInfo = "Ladybug, Vermin"
                PetJob = 'Thief'
                ReadyMoveOne = 'Spiral Spin'
                ReadyMoveTwo = 'Sudden Lunge'
                ReadyMoveThree = 'Noisome Powder'
        elseif state.JugMode.value == 'FlowerpotMerle' then
                PetInfo = "Mandragora, Plantoid"
                PetJob = 'Monk'
                ReadyMoveOne = 'Head Butt'
                ReadyMoveTwo = 'Leaf Dagger'
                ReadyMoveThree = 'Wild Oats'
        elseif state.JugMode.value == 'DapperMac' then
                PetInfo = "Apkallu, Bird"
                PetJob = 'Monk'
                ReadyMoveOne = 'Beak Lunge'
                ReadyMoveTwo = 'Wing Slap'
                ReadyMoveThree = 'None'
        elseif state.JugMode.value == 'DiscreetLouise' then
                PetInfo = "Funguar, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Frogkick'
                ReadyMoveTwo = 'Spore'
                ReadyMoveThree = 'Silence Gas'
        elseif state.JugMode.value == 'FatsoFargann' then
                PetInfo = "Leech, Amorph"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Suction'
                ReadyMoveTwo = 'Acid Mist'
                ReadyMoveThree = 'Drain Kiss'
        elseif state.JugMode.value == 'FaithfulFalcorr' then
                PetInfo = "Hippogryph, Bird"
                PetJob = 'Thief'
                ReadyMoveOne = 'Back Heel'
                ReadyMoveTwo = 'Choke Breath'
                ReadyMoveThree = 'Fantod'
        elseif state.JugMode.value == 'BugeyedBroncha' then
                PetInfo = "Eft, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Nimble Snap'
                ReadyMoveTwo = 'Cyclotail'
                ReadyMoveThree = 'Geist Wall'
        elseif state.JugMode.value == 'BloodclawShasra' then
                PetInfo = "Lynx, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Blaster'
                ReadyMoveTwo = 'Chaotic Eye'
                ReadyMoveThree = 'Charged Whisker'
        elseif state.JugMode.value == 'GorefangHobs' then
                PetInfo = "Tiger, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Razor Fang'
                ReadyMoveTwo = 'Claw Cyclone'
                ReadyMoveThree = 'Roar'
        elseif state.JugMode.value == 'GooeyGerard' then
                PetInfo = "Slug, Amorph"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Purulent Ooze'
                ReadyMoveTwo = 'Corrosive Ooze'
                ReadyMoveThree = 'Corrosive Ooze'
        elseif state.JugMode.value == 'CrudeRaphie' then
                PetInfo = "Adamantoise, Lizard"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Tortoise Stomp'
                ReadyMoveTwo = 'Harden Shell'
                ReadyMoveThree = 'Aqua Breath'
        elseif state.JugMode.value == 'DroopyDortwin' then
                PetInfo = "Rabbit, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Foot Kick'
                ReadyMoveTwo = 'Whirl Claws'
                ReadyMoveThree = 'Wild Carrot'
        elseif state.JugMode.value == 'PonderingPeter' then
                PetInfo = "HQ Rabbit, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Foot Kick'
                ReadyMoveTwo = 'Whirl Claws'
                ReadyMoveThree = 'Wild Carrot'
        elseif state.JugMode.value == 'SunburstMalfik' then
                PetInfo = "Crab, Aquan"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Big Scissors'
                ReadyMoveTwo = 'Scissor Guard'
                ReadyMoveThree = 'Bubble Curtain'
        elseif state.JugMode.value == 'AgedAngus' then
                PetInfo = "HQ Crab, Aquan"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Big Scissors'
                ReadyMoveTwo = 'Scissor Guard'
                ReadyMoveThree = 'Bubble Curtain'
        elseif state.JugMode.value == 'WarlikePatrick' then
                PetInfo = "Lizard, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Tail Blow'
                ReadyMoveTwo = 'Brain Crush'
                ReadyMoveThree = 'Fireball'
        elseif state.JugMode.value == 'ScissorlegXerin' then
                PetInfo = "Chapuli, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Sensilla Blades'
                ReadyMoveTwo = 'Tegmina Buffet'
                ReadyMoveThree = 'Tegmina Buffet'
        elseif state.JugMode.value == 'BouncingBertha' then
                PetInfo = "HQ Chapuli, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Sensilla Blades'
                ReadyMoveTwo = 'Tegmina Buffet'
                ReadyMoveThree = 'Tegmina Buffet'
        elseif state.JugMode.value == 'RhymingShizuna' then
                PetInfo = "Sheep, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Lamb Chop'
                ReadyMoveTwo = 'Rage'
                ReadyMoveThree = 'Sheep Song'
        elseif state.JugMode.value == 'AttentiveIbuki' then
                PetInfo = "Tulfaire, Bird"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Swooping Frenzy'
                ReadyMoveTwo = 'Pentapeck'
                ReadyMoveThree = 'Molting Plumage'
        elseif state.JugMode.value == 'SwoopingZhivago' then
                PetInfo = "HQ Tulfaire, Bird"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Swooping Frenzy'
                ReadyMoveTwo = 'Pentapeck'
                ReadyMoveThree = 'Molting Plumage'
        elseif state.JugMode.value == 'AmiableRoche' then
                PetInfo = "Pugil, Aquan"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Recoil Dive'
                ReadyMoveTwo = 'Water Wall'
                ReadyMoveThree = 'Intimidate'
        elseif state.JugMode.value == 'HeraldHenry' then
                PetInfo = "Crab, Aquan"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Big Scissors'
                ReadyMoveTwo = 'Scissor Guard'
                ReadyMoveThree = 'Bubble Curtain'
        elseif state.JugMode.value == 'BrainyWaluis' then
                PetInfo = "Funguar, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Frogkick'
                ReadyMoveTwo = 'Spore'
                ReadyMoveThree = 'Silence Gas'
        elseif state.JugMode.value == 'HeadbreakerKen' then
                PetInfo = "Fly, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Somersault'
                ReadyMoveTwo = 'Cursed Sphere'
                ReadyMoveThree = 'Venom'
        elseif state.JugMode.value == 'RedolentCandi' then
                PetInfo = "Snapweed, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Tickling Tendrils'
                ReadyMoveTwo = 'Stink Bomb'
                ReadyMoveThree = 'Nepenthic Plunge'
        elseif state.JugMode.value == 'AlluringHoney' then
                PetInfo = "HQ Snapweed, Plantoid"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Tickling Tendrils'
                ReadyMoveTwo = 'Stink Bomb'
                ReadyMoveThree = 'Nectarous Deluge'
        elseif state.JugMode.value == 'CaringKiyomaro' then
                PetInfo = "Raaz, Beast"
                PetJob = 'Monk'
                ReadyMoveOne = 'Sweeping Gouge'
                ReadyMoveTwo = 'Zealous Snort'
                ReadyMoveThree = 'Zealous Snort'
        elseif state.JugMode.value == 'VivaciousVickie' then
                PetInfo = "HQ Raaz, Beast"
                PetJob = 'Monk'
                ReadyMoveOne = 'Sweeping Gouge'
                ReadyMoveTwo = 'Zealous Snort'
                ReadyMoveThree = 'Zealous Snort'
        elseif state.JugMode.value == 'HurlerPercival' then
                PetInfo = "Beetle, Vermin"
                PetJob = 'Paladin'
                ReadyMoveOne = 'Power Attack'
                ReadyMoveTwo = 'Rhino Attack'
                ReadyMoveThree = 'Hi-Freq Field'
        elseif state.JugMode.value == 'BlackbeardRandy' then
                PetInfo = "Tiger, Beast"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Razor Fang'
                ReadyMoveTwo = 'Claw Cyclone'
                ReadyMoveThree = 'Roar'
        elseif state.JugMode.value == 'GenerousArthur' then
                PetInfo = "Slug, Amorph"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Purulent Ooze'
                ReadyMoveTwo = 'Corrosive Ooze'
                ReadyMoveThree = 'Corrosive Ooze'
        elseif state.JugMode.value == 'ThreestarLynn' then
                PetInfo = "Ladybug, Vermin"
                PetJob = 'Thief'
                ReadyMoveOne = 'Spiral Spin'
                ReadyMoveTwo = 'Sudden Lunge'
                ReadyMoveThree = 'Noisome Powder'
        elseif state.JugMode.value == 'BraveHeroGlenn' then
                PetInfo = "Frog, Aquan"
                PetJob = 'Warrior'
                ReadyMoveOne = 'None'
                ReadyMoveTwo = 'None'
                ReadyMoveThree = 'None'
        elseif state.JugMode.value == 'SharpwitHermes' then
                PetInfo = "Mandragora, Plantoid"
                PetJob = 'Monk'
                ReadyMoveOne = 'Head Butt'
                ReadyMoveTwo = 'Leaf Dagger'
                ReadyMoveThree = 'Wild Oats'
        elseif state.JugMode.value == 'ColibriFamiliar' then
                PetInfo = "Colibri, Bird"
                PetJob = 'Red Mage'
                ReadyMoveOne = 'Pecking Flurry'
                ReadyMoveTwo = 'Pecking Flurry'
                ReadyMoveThree = 'Pecking Flurry'
        elseif state.JugMode.value == 'ChoralLeera' then
                PetInfo = "HQ Colibri, Bird"
                PetJob = 'Red Mage'
                ReadyMoveOne = 'Pecking Flurry'
                ReadyMoveTwo = 'Pecking Flurry'
                ReadyMoveThree = 'Pecking Flurry'
        elseif state.JugMode.value == 'SpiderFamiliar' then
                PetInfo = "Spider, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Sickle Slash'
                ReadyMoveTwo = 'Acid Spray'
                ReadyMoveThree = 'Spider Web'
        elseif state.JugMode.value == 'GussyHachirobe' then
                PetInfo = "HQ Spider, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Sickle Slash'
                ReadyMoveTwo = 'Acid Spray'
                ReadyMoveThree = 'Spider Web'
        elseif state.JugMode.value == 'AcuexFamiliar' then
                PetInfo = "Acuex, Amorph"
                PetJob = 'Black Mage'
                ReadyMoveOne = 'Foul Waters'
                ReadyMoveTwo = 'Pestilent Plume'
                ReadyMoveThree = 'Pestilent Plume'
        elseif state.JugMode.value == 'FluffyBredo' then
                PetInfo = "HQ Acuex, Amorph"
                PetJob = 'Black Mage'
                ReadyMoveOne = 'Foul Waters'
                ReadyMoveTwo = 'Pestilent Plume'
                ReadyMoveThree = 'Pestilent Plume'
        elseif state.JugMode.value == 'SuspiciousAlice' then
                PetInfo = "Eft, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Nimble Snap'
                ReadyMoveTwo = 'Cyclotail'
                ReadyMoveThree = 'Geist Wall'
        elseif state.JugMode.value == 'AnklebiterJedd' then
                PetInfo = "Diremite, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Double Claw'
                ReadyMoveTwo = 'Spinning Top'
                ReadyMoveThree = 'Filamented Hold'
        elseif state.JugMode.value == 'FleetReinhard' then
                PetInfo = "Raptor, Lizard"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Scythe Tail'
                ReadyMoveTwo = 'Ripper Fang'
                ReadyMoveThree = 'Chomp Rush'
        elseif state.JugMode.value == 'CursedAnnabelle' then
                PetInfo = "Antlion, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Mandibular Bite'
                ReadyMoveTwo = 'Venom Spray'
                ReadyMoveThree = 'Sandblast'
        elseif state.JugMode.value == 'SurgingStorm' then
                PetInfo = "Apkallu, Bird"
                PetJob = 'Monk'
                ReadyMoveOne = 'Beak Lunge'
                ReadyMoveTwo = 'Wing Slap'
                ReadyMoveThree = 'Wing Slap'
        elseif state.JugMode.value == 'SubmergedIyo' then
                PetInfo = "HQ Apkallu, Bird"
                PetJob = 'Monk'
                ReadyMoveOne = 'Beak Lunge'
                ReadyMoveTwo = 'Wing Slap'
                ReadyMoveThree = 'Wing Slap'
        elseif state.JugMode.value == 'MosquitoFamiliar' then
                PetInfo = "Mosquito, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Infected Leech'
                ReadyMoveTwo = 'Gloom Spray'
                ReadyMoveThree = 'Gloom Spray'
        elseif state.JugMode.value == 'Left-HandedYoko' then
                PetInfo = "HQ Mosquito, Vermin"
                PetJob = 'Warrior'
                ReadyMoveOne = 'Infected Leech'
                ReadyMoveTwo = 'Gloom Spray'
                ReadyMoveThree = 'Gloom Spray'
        end

end

-------------------------------------------------------------------------------------------------------------------
-- Ready Move Presets - Credit to Bomberto
-------------------------------------------------------------------------------------------------------------------

function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'ready' then
        ready_move(cmdParams)
        eventArgs.handled = true
    end
end
 
function ready_move(cmdParams)
     local move = cmdParams[2]:lower()
 
        if pet.name == 'DroopyDortwin' or pet.name == 'PonderingPeter' or pet.name == 'HareFamiliar' or pet.name == 'KeenearedSteffi' or pet.name == 'LuckyLulush' then
            if move == 'one' then
                send_command('input /pet "Foot Kick" <me>')
            elseif move == 'two' then
                send_command('input /pet "Whirl Claws" <me>')
            elseif move == 'three' then
                send_command('input /pet "Wild Carrot" <me>') end
        elseif pet.name == 'SunburstMalfik' or pet.name == 'AgedAngus' or pet.name == 'HeraldHenry' or pet.name == 'CrabFamiliar' or pet.name == 'CourierCarrie' then
            if move == 'one' then
                send_command('input /pet "Big Scissors" <me>')
            elseif move == 'two' then
                send_command('input /pet "Scissor Guard" <me>')
            elseif move == 'three' then
                send_command('input /pet "Bubble Curtain" <me>') end
        elseif pet.name == 'WarlikePatrick' or pet.name == 'LizardFamiliar' or pet.name == 'ColdbloodedComo' or pet.name == 'AudaciousAnna' then
            if move == 'one' then
                send_command('input /pet "Tail Blow" <me>')
            elseif move == 'two' then
                send_command('input /pet "Brain Crush" <me>')
            elseif move == 'three' then
                send_command('input /pet "Fireball" <me>') end
        elseif pet.name == 'ScissorlegXerin' or pet.name == 'BouncingBertha' then
            if move == 'one' then
                send_command('input /pet "Sensilla Blades" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /pet "Tegmina Buffet" <me>') end
        elseif pet.name == 'RhymingShizuna' or pet.name == 'SheepFamiliar' or pet.name == 'LullabyMelodia' or pet.name == 'NurseryNazuna' then
            if move == 'one' then
                send_command('input /pet "Lamb Chop" <me>')
            elseif move == 'two' then
                send_command('input /pet "Rage" <me>')
            elseif move == 'three' then
                send_command('input /pet "Sheep Song" <me>') end
        elseif pet.name == 'AttentiveIbuki' or pet.name == 'SwoopingZhivago' then
            if move == 'one' then
                send_command('input /pet "Swooping Frenzy" <me>')
            elseif move == 'two' then
                send_command('input /pet "Pentapeck" <me>')
            elseif move == 'three' then
                send_command('input /pet "Molting Plumage" <me>') end
        elseif pet.name == 'AmiableRoche' or pet.name == 'TurbidToloi' then
            if move == 'one' then
                send_command('input /pet "Recoil Dive" <me>')
            elseif move == 'two' then
                send_command('input /pet "Water Wall" <me>')
            elseif move == 'three' then
                send_command('input /pet "Intimidate" <me>') end
        elseif pet.name == 'BrainyWaluis' or pet.name == 'FunguarFamiliar' or pet.name == 'DiscreetLouise' then
            if move == 'one' then
                send_command('input /pet "Frogkick" <me>')
            elseif move == 'two' then
                send_command('input /pet "Spore" <me>')
            elseif move == 'three' then
                send_command('input /pet "Silence Gas" <me>') end               
        elseif pet.name == 'HeadbreakerKen' or pet.name == 'MayflyFamiliar' or pet.name == 'ShellbusterOrob' or pet.name == 'MailbusterCetas' then
            if move == 'one' then
                send_command('input /pet "Somersault" <me>')   
            elseif move == 'two' then
                send_command('input /pet "Cursed Sphere" <me>')
            elseif move == 'three' then
                send_command('input /pet "Venom" <me>') end                
        elseif pet.name == 'RedolentCandi' or pet.name == 'AlluringHoney' then
            if move == 'one' then
                send_command('input /pet "Tickling Tendrils" <me>')
            elseif move == 'two' then
                send_command('input /pet "Stink Bomb" <me>')
            elseif move == 'three' then
                send_command('input /pet "Nectarous Deluge" <me>') end
        elseif pet.name == 'CaringKiyomaro' or pet.name == 'VivaciousVickie' then
            if move == 'one' then
                send_command('input /pet "Sweeping Gouge" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /pet "Zealous Snort" <me>') end
        elseif pet.name == 'HurlerPercival' or pet.name == 'BeetleFamiliar' or pet.name == 'PanzerGalahad' then
            if move == 'one' then
                send_command('input /pet "Power Attack" <me>')
            elseif move == 'two' then
                send_command('input /pet "Rhino Attack" <me>')
            elseif move == 'three' then
                send_command('input /pet "Hi-Freq Field" <me>') end
        elseif pet.name == 'BlackbeardRandy' or pet.name == 'TigerFamiliar' or pet.name == 'SaberSiravarde' or pet.name == 'GorefangHobs' then
            if move == 'one' then
                send_command('input /pet "Razor Fang" <me>')
            elseif move == 'two' then
                send_command('input /pet "Claw Cyclone" <me>')
            elseif move == 'three' then
                send_command('input /pet "Roar" <me>') end
        elseif pet.name == 'ColibriFamiliar' or pet.name == 'ChoralLeera' then
            if move == 'one' or move == 'two' or move == 'three' then
                send_command('input /pet "Pecking Flurry" <me>') end
        elseif pet.name == 'SpiderFamiliar' or pet.name == 'GussyHachirobe' then
            if move == 'one' then
                send_command('input /pet "Sickle Slash" <me>')
            elseif move == 'two' then
                send_command('input /pet "Acid Spray" <me>')
            elseif move == 'three' then
                send_command('input /pet "Spider Web" <me>') end
        elseif pet.name == 'GenerousArthur' or pet.name == 'GooeyGerard' then
            if move == 'one' then
                send_command('input /pet "Purulent Ooze" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /pet "Corrosive Ooze" <me>') end
        elseif pet.name == 'ThreestarLynn' or pet.name == 'DipperYuly' then
            if move == 'one' then
                send_command('input /pet "Spiral Spin" <me>')
            elseif move == 'two' then
                send_command('input /pet "Sudden Lunge" <me>')
            elseif move == 'three' then
                send_command('input /pet "Noisome Powder" <me>') end
        elseif pet.name == 'SharpwitHermes' or pet.name == 'FlowerpotBill' or pet.name == 'FlowerpotBen' or pet.name == 'Homunculus' or pet.name == 'FlowerpotMerle' then
            if move == 'one' then
                send_command('input /pet "Head Butt" <me>')
            elseif move == 'two' then
                send_command('input /pet "Leaf Dagger" <me>')
            elseif move == 'three' then
                send_command('input /pet "Wild Oats" <me>') end
        elseif pet.name == 'AcuexFamiliar' or pet.name == 'FluffyBredo' then
            if move == 'one' then
                send_command('input /pet "Foul Waters" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /pet "Pestilent Plume" <me>') end
        elseif pet.name == 'FlytrapFamiliar' or pet.name == 'VoraciousAudrey' or pet.name == 'PrestoJulio' then
            if move == 'one' then
                send_command('input /pet "Soporific" <me>')
            elseif move == 'two' then
                send_command('input /pet "Palsy Pollen" <me>')
            elseif move == 'three' then
                send_command('input /pet "Gloeosuccus" <me>') end
        elseif pet.name == 'EftFamiliar' or pet.name == 'AmbusherAllie' or pet.name == 'BugeyedBroncha' or pet.name == 'SuspiciousAlice' then
            if move == 'one' then
                send_command('input /pet "Nimble Snap" <me>')
            elseif move == 'two' then
                send_command('input /pet "Cyclotail" <me>')
            elseif move == 'three' then
                send_command('input /pet "Geist Wall" <me>') end
        elseif pet.name == 'AntlionFamiliar' or pet.name == 'ChopsueyChucky' or pet.name == 'CursedAnnabelle' then
            if move == 'one' then
                send_command('input /pet "Mandibular Bite" <me>')
            elseif move == 'two' then
                send_command('input /pet "Venom Spray" <me>')
            elseif move == 'three' then
                send_command('input /pet "Sandblast" <me>') end
        elseif pet.name == 'MiteFamiliar' or pet.name == 'LifedrinkerLars' or pet.name == 'AnklebiterJedd' then
            if move == 'one' then 
                send_command('input /pet "Double Claw" <me>')
            elseif move == 'two' then
                send_command('input /pet "Spinning Top" <me>')
            elseif move == 'three' then
                send_command('input /pet "Filamented Hold" <me>') end
        elseif pet.name == 'AmigoSabotender' then
            if move == 'one' then
                send_command('input /pet "Needleshot" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /pet "??? Needles" <me>') end
        elseif pet.name == 'CraftyClyvonne' or pet.name == 'BloodclawShashra' then
            if move == 'one' then
                send_command('input /pet "Chaotic Eye" <me>')
            elseif move == 'two' then
                send_command('input /pet "Blaster" <me>')
            elseif move == 'three' then
                send_command('input /pet "Charged Whisker" <me>') end
        elseif pet.name == 'SwiftSieghard' or pet.name == 'FleetReinhard' then
            if move == 'one' then
                send_command('input /pet "Scythe Tail" <me>')
            elseif move == 'two' then
                send_command('input /pet "Ripper Fang" <me>')
            elseif move == 'three' then
                send_command('input /pet "Chomp Rush" <me>') end
        elseif pet.name == 'DapperMac' or pet.name == 'SurgingStorm' or pet.name == 'SubmergedIyo' then
            if move == 'one' then
                send_command('input /pet "Beak Lunge" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /pet "Wing Slap" <me>') end
        elseif pet.name == 'FatsoFargann' then
            if move == 'one' then
                send_command('input /pet "Suction" <me>')
            elseif move == 'two' then
                send_command('input /pet "Acid Mist" <me>')
            elseif move == 'three' then
                send_command('input /pet "Drain Kiss" <me>') end
        elseif pet.name == 'FaithfulFalcorr' then
            if move == 'one' then
                send_command('input /pet "Back Heel" <me>')
            elseif move == 'two' then
                send_command('input /pet "Choke Breath" <me>')
            elseif move == 'three' then
                send_command('input /pet "Fantod" <me>') end
        elseif pet.name == 'CrudeRaphie' then
            if move == 'one' then
                send_command('input /pet "Tortoise Stomp" <me>')   
            elseif move == 'two' then
                send_command('input /pet "Harden Shell" <me>')
            elseif move == 'three' then
                send_command('input /pet "Aqua Breath" <me>') end
        elseif pet.name == 'MosquitoFamilia' or pet.name == 'Left-HandedYoko' then
            if move == 'one' then
                send_command('input /pet "Infected Leech" <me>')
            elseif move == 'two' or move == 'three' then
                send_command('input /pet "Gloom Spray" <me>') end
    end 
end

-- Updates gear based on pet status changes.
function job_pet_status_change(newStatus, oldStatus, eventArgs)
        if newStatus == 'Idle' or newStatus == 'Engaged' then
                handle_equipping_gear(player.status)
        end
end 

-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    local msg = 'Melee'
    
    if state.CombatForm.has_value then
        msg = msg .. ' (' .. state.CombatForm.value .. ')'
    end
    
    msg = msg .. ': '
    
    msg = msg .. state.OffenseMode.value
    if state.HybridMode.value ~= 'Normal' then
        msg = msg .. '/' .. state.HybridMode.value
    end
    msg = msg .. ', WS: ' .. state.WeaponskillMode.value
    
    if state.DefenseMode.value ~= 'None' then
        msg = msg .. ', ' .. 'Defense: ' .. state.DefenseMode.value .. ' (' .. state[state.DefenseMode.value .. 'DefenseMode'].value .. ')'
    end
    
    if state.Kiting.value then
        msg = msg .. ', Kiting'
    end

    msg = msg .. ', Reward: '..state.RewardMode.value..', Corr.: '..state.CorrelationMode.value

    if state.JugMode.value ~= 'None' then
        add_to_chat(8,'--- Jug Pet: '.. state.JugMode.value ..' --- ('.. PetInfo ..', '.. PetJob ..')')
    end

    add_to_chat(28,'Ready Moves: 1.'.. ReadyMoveOne ..'  2.'.. ReadyMoveTwo ..'  3.'.. ReadyMoveThree ..'')
    add_to_chat(122, msg)

    eventArgs.handled = true
end

-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function get_combat_form()
    if player.sub_job == 'NIN' or player.sub_job == 'DNC' then
                state.CombatForm:set('DW')
    else
        state.CombatForm:reset()
    end
end

function get_melee_groups()
        classes.CustomMeleeGroups:clear()

        if buffactive['Aftermath: Lv.3'] then
                classes.CustomMeleeGroups:append('Aftermath')
        end
end


