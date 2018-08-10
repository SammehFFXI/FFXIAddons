state.SpellDebug = M{['description']='Debug Spells', 'Off', 'On'}
send_command('alias spelldebug gs c cycle spelldebug')

-- require 'strings'
-- require 'actions'
-- require 'pack'
require 'tables'
files = require 'files'
res = require 'resources'
extdata = require('extdata')

--lastspell = require('last_spell.lua')   -- this was just a test - don't ask
--lastspell_file = files.new('data\\last_spell.lua')

sets.craftgear = {body="Carpenter\'s Apron",ring1="Craftmaster\'s Ring",ring2="Craftkeeper\'s Ring",neck="Carver\'s Torque",hands="Carpenter\'s Gloves",sub="Joiner's shield"}

follow = 0
autorun = 0

send_command('alias craftgear gs equip sets.craftgear; lua unload gearswap')
send_command('alias uncraft lua load gearswap; gs c update')
send_command('alias revit input /item "Super Revitalizer" <me>')
send_command('alias pot1 input /item "Lucid Potion I" <me>')
send_command('alias pot2 input /item "Lucid Potion II" <me>')
send_command('alias pot3 input /item "Lucid Potion III" <me>')
send_command('alias eth1 input /item "Lucid Ether I" <me>')
send_command('alias eth2 input /item "Lucid Ether II" <me>')
send_command('alias eth3 input /item "Lucid Ether III" <me>')
send_command('alias elixir1 input /item "Lucid Elixir I" <me>')
send_command('alias elixir2 input /item "Lucid Elixir II" <me>')
send_command('alias wings1 input /item "Lucid Wings I" <me>')
send_command('alias wings2 input /item "Lucid Wings II" <me>')
send_command('alias manamist input /item "Mana Mist" <me>')
send_command('alias hpmist input /item "Healing Mist" <me>')
send_command('alias megalixir input /item "Megalixir" <me>')
send_command('alias cat input /item "Catholicon" <me>')
send_command('alias cat1 input /item "Catholicon +1" <me>')
send_command('alias stonic input /item "Steadfast Tonic" <me>')
send_command('alias mtonic input /item "Mirror\'s Tonic" <me>')
send_command('alias echodrop input /item "Echo Drops" <me>')
send_command('alias remedy input /item "Remedy" <me>')
send_command('alias holywater input /item "Holy Water" <me>')
send_command('alias warpring input /equip ring1 "Warp Ring"')
send_command('alias adrink input /item "Assassin\'s Drink"')

sets.frenzysallet = {head="Frenzy Sallet"}

function check_temp_items()
 local tempitems = windower.ffxi.get_items(3)
  for id,item in pairs(tempitems) do
     print(item)
  end
end

-- Thanks Langly for has_charges and is_enchant_ready
-- Item must be equipped for it to return any meaningful value.
function is_enchant_ready(--[[name of item]]item)
	local item_id, item = res.items:find(function(v) if v.name == item then return true end end)
	local inventory = windower.ffxi.get_items()
	local usable_bags = T{'inventory','wardrobe','wardrobe2','wardrobe3','wardrobe4'}
	local itemdata = {}
	
	for i,v in pairs(inventory) do
		if usable_bags:contains(i) then
			for key,val in pairs(v) do
				if type(val) == 'table' and val.id == item_id then
					itemdata = extdata.decode(val)
				end
			end
		end
	end
	
	if itemdata and itemdata.charges_remaining then
		if itemdata.activation_time - itemdata.next_use_time > item.cast_delay then
			return true
		end
	end
	return false
end

function has_charges(--[[name of item]]item)
	local item_id, item = res.items:find(function(v) if v.name == item then return true end end)
	local inventory = windower.ffxi.get_items()
	local bags = T{'inventory','safe','safe2','storage','satchel','locker','sack','case','wardrobe','wardrobe2','wardrobe3','wardrobe4'}
	local itemdata = {}
	
	for i,v in pairs(inventory) do
		if bags:contains(i) then
			for key,val in pairs(v) do
				if type(val) == 'table' and val.id == item_id then
					itemdata = extdata.decode(val)
				end
			end
		end
	end
	
	if itemdata and itemdata.charges_remaining then
		if itemdata.charges_remaining > 0 then
			return true
		end
	end
	return false
end



function disable_specialgear()
--[[
	if player.equipment.head == "Reraise Hairpin" then
		disable('head')
	else
		enable('head')
	end
	if player.equipment.back == 'Mecisto. Mantle' or player.equipment.back == 'Aptitude Mantle' or player.equipment.back == 'Aptitude Mantle +1' or player.equipment.back == 'Nexus Cape' then
        disable('back')
    else
        enable('back')
    end
        if player.equipment.ring1 == 'Dim. Ring (Holla)' or player.equipment.ring1 == 'Warp Ring' or player.equipment.ring1 == 'Trizek Ring' or player.equipment.ring1 == 'Capacity Ring' or player.equipment.ring1 == "Vocation Ring" or player.equipment.ring1 == 'Facility Ring' then
        disable('ring1')
    else
        enable('ring1')
    end
    if player.equipment.ring2 == 'Dim. Ring (Holla)' or player.equipment.ring2 == 'Warp Ring' or player.equipment.ring2 == 'Trizek Ring' or player.equipment.ring2 == 'Capacity Ring' or player.equipment.ring2 == "Vocation Ring" or player.equipment.ring2 == 'Facility Ring'  then
        disable('ring2')
    else
        enable('ring2')
    end
]]
	local lockables = T{'Mecisto. Mantle', 'Shobuhouou Kabuto', 'Aptitude Mantle', 'Nexus Cape', 'Aptitude Mantle +1', 'Warp Ring', 'Vocation Ring', 'Reraise Earring', 'Capacity Ring', 'Trizek Ring', 'Echad Ring', 'Facility Ring', 'Dim. Ring (Holla)', 'Dim. Ring (Dem)', 'Dim. Ring (Mea)'}
	local watch_slots = T{'ear1','ear2','ring1','ring2','back','head'}

	for _,v in pairs(watch_slots) do
		if lockables:contains(player.equipment[v]) then
			disable(v)
			if has_charges(player.equipment[v]) and (not is_enchant_ready(player.equipment[v])) then
				enable(v)
			end
		else
			enable(v)
		end
	end
end

function check_height() 
 selfz = math.floor(windower.ffxi.get_mob_by_index(player.index).z * 10)/10
 targetz = math.floor(windower.ffxi.get_mob_by_index(player.target.index).z * 10)/10
 heightdiff = selfz - targetz
 targdistance = math.floor(windower.ffxi.get_mob_by_index(player.target.index).distance:sqrt() * 10+0.5)/10
 send_command('input /echo My Height:'..selfz..' Target Height:'..targetz..' Height Difference:'..heightdiff..'  Target Distance:'..targdistance..'')
end

function spelldebug(spell)
  skillchainproperties = "None"
  add_to_chat(2,'Spell Type:'..spell.type..'  Ability Type:'..spell.action_type..'')
  if spell.action_type == 'Magic' then
    add_to_chat(2,'-----------Spell Info-----------')
    add_to_chat(2,'Name:'..spell.name..'     Element:'..spell.element..'     Skill:'..spell.skill..'')
	add_to_chat(2,'Target:'..spell.target.name..'     Target Type:'..spell.target.type)
	add_to_chat(2,'Base Cast Time:'..spell.cast_time..'     Base Recast:'..spell.recast..'')
	if spell.type ~= 'Ninjutsu' then
	  add_to_chat(2,'MP Cost:'..spell.mp_cost..'')
	end
    if string.find(spell.english,'ga') or buffactive.Accession or buffactive.Manifestation then
	 add_to_chat(2,'Range:'..spell.range..'')
	end
	add_to_chat(2,'-----------Spell End-----------')
  end
  if spell.type == "JobAbility" then
  end
  if spell.type == "WeaponSkill" then
	add_to_chat(2,'-----------WS Info-----------')
	add_to_chat(2,'Name:'..spell.name..'     Spell Skill:'..spell.skill..'')
	add_to_chat(2,'Base TP:'..tpspent..'') -- Does not include bonuses such as Moonshade Earring
	if (#spell.skillchain_a > 1) then
	  skillchainproperties = spell.skillchain_a
	end
	if (#spell.skillchain_b > 1) then
	  skillchainproperties = skillchainproperties ..' '.. spell.skillchain_b
	end
	if (#spell.skillchain_c) then
	  skillchainproperties = skillchainproperties ..' '.. spell.skillchain_c
	end
      add_to_chat(2,'Skillchain Properties:'..skillchainproperties..'') 
  end
  if spell.type == "Scholar" then
    stratrecast = windower.ffxi.get_ability_recasts()[spell.recast_id]
	stratsremaining = math.floor(((165 - stratrecast) / 33) - 1)
	add_to_chat(2,'Remaining Stratagems: '..stratsremaining..'')
  end
  if spell.type == "Monster" then
	add_to_chat(2,'Name:'..spell.name..'')
	send_command('@wait 1;input //gs c showcharges')
  end
  -- add_to_chat(2,'-----------Target Info-----------')
  -- add_to_chat(2,'Target Name:'..spell.target.name..'')
  -- add_to_chat(2,'Target Type:'..spell.target.type..'')
  -- add_to_chat(2,'Model Size:'..spell.target.model_size..'')
  -- add_to_chat(2,'-----------Target End-----------')
  if spell.type == "CorsairRoll" then
	add_to_chat(2,'Corsair Roll:'..spell.name..' Value:'..spell.value)
  end
end

-- For BST to see how many Charges Remain
function chargesremaining()
    charges = 3
    ready = windower.ffxi.get_ability_recasts()[102]
	if ready ~= 0 then
	  charges = math.floor(((30 - ready) / 10))
	end
	add_to_chat(2,'Ready Recast:'..ready..'   Charges Remaining:'..charges..'')
	windower.send_command('timers delete "Sic/Ready"')
	windower.send_command('timers create "Sic/Ready ['..charges..']" '..ready..' down fire')
	--windower.send_command('timers delete "'..dragon..' Pop Timer:"')
	--windower.send_command('timers create "'..dragon..' Pop Timer:" 600 down fire')
end

-- Equip Obi based on Weather

function weathercheck(spell_element)
    -- Relevant Obis. Add the ones you have uniquely - or add the Hachirin-no-obi on each
    sets.obi = {}
    sets.obi.Wind = {waist='Hachirin-no-obi'}
    sets.obi.Ice = {waist='Hachirin-no-obi'}
    sets.obi.Lightning = {waist='Hachirin-no-obi'}
    sets.obi.Light = {waist='Hachirin-no-obi'}
    sets.obi.Dark = {waist='Hachirin-no-obi'}
    sets.obi.Water = {waist='Hachirin-no-obi'}
    sets.obi.Earth = {waist='Hachirin-no-obi'}
    sets.obi.Fire = {waist='Hachirin-no-obi'}
    
    -- Generic gear for day/weather
    sets.weather = {back='Twilight Cape'}
    sets.day = {ring1='Zodiac Ring'}
	
    if spell_element == world.weather_element then
        equip(sets.weather)
        if sets.obi[spell_element] then
            equip(sets.obi[spell_element])
        end
    end
    if spell_element == world.day_element then
        equip(sets.day)
        if sets.obi[spell_element] then
            equip(sets.obi[spell_element])
        end
    end
end

-- Called whenever you gain or lose a buff.
function job_buff_change(status,gain_or_loss)
   if (gain_or_loss) then  
   add_to_chat(4,'------- Gained Buff: '..status..'-------')
   if status == "KO" then
	   send_command('input /party These tears... they sting-wing....')
   end
   if status == "Sublimation: Complete" then
		handle_equipping_gear(player.status)
		equip(sets.Idle.Current)
   end
   else 
   add_to_chat(3,'------- Lost Buff: '..status..'-------')
   if status == "stun" then 
	if sets.Idle then
	  if sets.Idle.Current then
		equip(sets.Idle.Current)
	  end
	end
   end
   end
   build_melee_classes()
   handle_equipping_gear(player.status)
end

function build_melee_classes() 
    classes.CustomMeleeGroups:clear()
	self = windower.ffxi.get_player()
	for i,v in pairs(self.buffs) do
		local buff = res.buffs[v]
		classes.CustomMeleeGroups:append(buff.en)
	end
end

function check_run_status()
	if autorun == 1 then 
		windower.ffxi.run()
		autorun = 0
	end
end

function GetElementID(element)
   local elementID
   for i,v in pairs(res.elements) do
      if v.en == element then
	     elementID = i
	  end 
   end
   return elementID
end

function SpellsByElement(element,spelltype,skill)
   local spellList = S{}
   local AccessToSpells = windower.ffxi.get_spells()
   local skillID = GetSkillIDBySkill(skill)
   for i,v in pairs(res.spells) do
      if v.element == element and v.type == spelltype and AccessToSpells[i] == true and v.skill == skillID then
	     table.insert(spellList, i)
	  end 
   end
   return spellList
end

function CurrentJobIDByJob(job)
  local jobID
  for i,v in pairs(res.jobs) do
     if v.ens == job then
	    jobID = i
	 end
  end
  return jobID
end

function GetSkillIDBySkill(skill)
  local skillID
  for i,v in pairs(res.skills) do
	if v.en == skill then
	   skillID = i
	end
  end
  return skillID
end

function checkblocking(spell)
	if type(windower.ffxi.get_player().autorun) == 'table' and (spell.action_type == 'Magic' or spell.name == 'Ranged') then 
		windower.add_to_chat(3,'Currently auto-running - stopping to cast spell')
		windower.ffxi.run(false)
		windower.ffxi.follow()  -- disabling Follow - turning back autorun automatically turns back on follow.
		autorun = 1
		cast_delay(.4)
		return
	end
	if buffactive.sleep or buffactive.petrification or buffactive.terror then 
	   add_to_chat(3,'Canceling Action - Asleep/Petrified/Terror!')
	   cancel_spell()
	   send_command('gs c update')
	   return
	end 
	if spell.english == "Double-Up" then
	  if not buffactive["Double-Up Chance"] then 
	   add_to_chat(3,'Canceling Action - No ability to Double Up')
	   cancel_spell()
	   send_command('gs c update')
	   return
	  end
	end
	if spell.name ~= 'Ranged' and spell.type ~= 'WeaponSkill' and spell.type ~= 'Scholar' and spell.type ~= 'Monster' then
      if spell.action_type == 'Ability' then
	    if buffactive.Amnesia then
		  cancel_spell()
		  send_command('gs c update')
		  add_to_chat(3,'Canceling Ability - Currently have Amnesia')
		  return
		else
	      recasttime = windower.ffxi.get_ability_recasts()[spell.recast_id] 
          if spell and (recasttime >= 1) then
		    add_to_chat(3,'Ability Canceled:'..spell.name..' - Waiting on Recast:(seconds) '..recasttime..'')
            cancel_spell()
			send_command('gs c update')
            return
          end
		end
	  end
	end
    if spell.action_type == 'Magic' then
	    if buffactive.Silence then
	      cancel_spell()
		  send_command('gs c update')
		  echodrops = "Echo Drops"
		  numberofecho = player.inventory[echodrops].count
		  if numberofecho < 2 then 
		    add_to_chat(2,'Silenced - Consider using Echo Drops. QTY:'..player.inventory[echodrops].count..'')
		  else 
		    add_to_chat(3,'Silenced - Using Echo Drops.  QTY:'..numberofecho..'')
		    send_command('input /item "Echo Drops" <me>')
		  end
		  return
	    else 
		  if (spell.name == 'Refresh' and (buffactive["Sublimation: Complete"] or buffactive["Sublimation: Activated"]) and spell.target.type == 'SELF') then
		   add_to_chat(3,'Cancel Refresh - Have Sublimation Already')
		   cancel_spell()
		   send_command('gs c update')
		   return
		  end
		  allrecasts = windower.ffxi.get_spell_recasts()
	      recasttime = allrecasts[spell.recast_id] / 100
          if spell and (recasttime >= 1) then
			if spell.skill == 'Elemental Magic' and AutoNextTier then 
		   		local main_jobID = CurrentJobIDByJob(player.main_job)
		   		local sub_jobID = CurrentJobIDByJob(player.sub_job)
		   		local spellElementID = GetElementID(spell.element)
		   		local spellsForElement = SpellsByElement(spellElementID,spell.type,spell.skill)
		   		local spellsByJob = {}
		   		for i,v in pairs(spellsForElement) do
					for i2,v2 in pairs(res.spells[v].levels) do
						if (i2 == main_jobID and v2 <= player.main_job_level) or (i2 == sub_jobID and v2 <= player.sub_job_level) then 
							if not spellsByJob[v] then
								spellsByJob[v] = v
							end
						end
					end
				end
				for i,v in pairs(spellsByJob) do
					print(i,v,res.spells[v].en,allrecasts[v] / 100)
				end
				add_to_chat(2,'Spell Canceled:'..spell.name..' - Moving to next Spell '..recasttime..'')
				cancel_spell()
				-- Determine Tier cast and go to next available in same class.
			  
				send_command('gs c update')
				return
			else 
				add_to_chat(2,'Spell Canceled:'..spell.name..' - Waiting on Recast:(seconds) '..recasttime..'')
				cancel_spell()
				send_command('gs c update')
				return
			end
          end
		end
    end
    if spell.type == 'WeaponSkill' and player.tp < 1000 then
		cancel_spell()
		send_command('gs c update')
		add_to_chat(3,'Canceled Spell:'..spell.name..' - Waiting on TP')
		return
	end
	if spell.type == 'WeaponSkill' and buffactive.Amnesia then
		  cancel_spell()
		  send_command('gs c update')
		  add_to_chat(3,'Canceling Ability - Currently have Amnesia')
		  return	  
	end
	if spell.type == 'WeaponSkill' then
	    local range_mult = {
			[2] = 1.55,
			[3] = 1.490909,
			[4] = 1.44,
			[5] = 1.377778,
			[6] = 1.30,
			[7] = 1.15,
			[8] = 1.25,
			[9] = 1.377778,
			[10] = 1.45,
			[11] = 1.454545454545455,
			[12] = 1.666666666666667,
		}
		ability_distance = res.weapon_skills[spell.id].range
		if spell.target.distance > (ability_distance * range_mult[ability_distance] + spell.target.model_size + player.model_size) then
		    cancel_spell()
			add_to_chat(3, spell.name..' Canceled: [Out of Range]')
			send_command('gs c update')
			return
		end
	end
	if spell.name == 'Utsusemi: Ichi' and (buffactive['Copy Image (3)'] or buffactive ['Copy Image (4+)']) then
	  cancel_spell()
	  send_command('gs c update')
	  add_to_chat(3,'Canceling Utsusemi - Already have Max and can not override')
	  return
	end
	if spell.type == 'Monster' or spell.name == 'Reward' or spell.name == 'Spur' then
		if pet.isvalid then 
			local s = windower.ffxi.get_mob_by_target('me')
			local pet = windower.ffxi.get_mob_by_target('pet')
			local PetMaxDistance = 4
			local pettargetdistance = PetMaxDistance + pet.model_size + s.model_size
			if pet.model_size > 1.6 then 
				pettargetdistance = PetMaxDistance + pet.model_size + s.model_size + 0.1
			end
			if pet.distance:sqrt() >= pettargetdistance then
				add_to_chat(3,'Canceling: '..spell.name..'! Outside Distance:'..pet.distance:sqrt())
				cancel_spell()
				send_command('gs c update')
				return
			end
		else
			add_to_chat(3,'Canceling: '..spell.name..'!  You have no pet!')
			cancel_spell()
			send_command('gs c update')
			return
		end
	end
	if spell.name == 'Fight' then
		if pet.isvalid then 
			local t = windower.ffxi.get_mob_by_target('t') or windower.ffxi.get_mob_by_target('st')
			local pet = windower.ffxi.get_mob_by_target('pet')
			local PetMaxDistance = 30 
			local DistanceBetween = ((t.x - pet.x)*(t.x-pet.x) + (t.y-pet.y)*(t.y-pet.y)):sqrt()
			if DistanceBetween > PetMaxDistance then 
				add_to_chat(3,'Canceling: Fight! Replacing with Heel - > 30 yalms away')
				cancel_spell()
				send_command('@wait .5; input /pet Heel <me>')
				return
			end
		end
	end
end



--[[
Just not worth it

--- The following detects movement and automatically equips gear whether you're moving or not.

-- Current Concerns:
-- ** What happens for draw_in & knock-back  (I've somewhat mitigated by adding an engaged check on player.status see player.status ~= engaged below.
-- ** When casting a spell and past the interruption window and start running - you equip the gear pre-midcast finalizing. I think I can 
-- determine if mid-cast maybe with a variable on job_midcast{ CustomStatus = casting} and job_aftercast { CustomStatus = Idle } 
sets.moving = {}
--sets.moving.BLM = {feet="Herald's Gaiters"}
--sets.moving.SCH = {feet="Herald's Gaiters"}
-- sets.moving.RNG = {feet="Jute Boots +1"}
sets.moving.SAM = {feet="Danzo Sune-ate"}
--sets.moving.NIN = {feet=gear.MovementFeet.name}  -- this doesn't werk - need some function to check for day/time><
sets.notmoving = {}
--sets.notmoving.BLM = {feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}}}
--sets.notmoving.SCH = {feet={ name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','INT+5','Mag. Acc.+11','"Mag.Atk.Bns."+8',}}}
-- sets.notmoving.RNG = {feet={ name="Herculean Boots", augments={'Rng.Acc.+25 Rng.Atk.+25','Weapon skill damage +2%','Rng.Acc.+1','Rng.Atk.+9',}}}
sets.notmoving.SAM = {feet={ name="Valorous Greaves", augments={'Accuracy+23 Attack+23','Enmity+2','STR+8','Accuracy+9','Attack+9',}}}
--sets.notmoving.NIN = {feet={ name="Herculean Boots", augments={'Mag. Acc.+1 "Mag.Atk.Bns."+1','STR+11','Quadruple Attack +2','Accuracy+18 Attack+18',}}}

mov = {counter=0}
if player and player.index and windower.ffxi.get_mob_by_index(player.index) then
    mov.x = windower.ffxi.get_mob_by_index(player.index).x
    mov.y = windower.ffxi.get_mob_by_index(player.index).y
    mov.z = windower.ffxi.get_mob_by_index(player.index).z
end
moving = false
windower.raw_register_event('prerender',function()
    mov.counter = mov.counter + 1;
    if mov.counter>5 then
        local pl = windower.ffxi.get_mob_by_index(player.index)
        if pl and pl.x and mov.x then
            local movement = math.sqrt( (pl.x-mov.x)^2 + (pl.y-mov.y)^2 + (pl.z-mov.z)^2 ) > 0.1
            if movement and not moving then
			    if sets.moving[player.main_job] and player.status ~= "Engaged" then  
                  send_command('gs equip sets.moving.'..player.main_job..'')
				end
				if state.SpellDebug.value == "On" then 
				  send_command('input /echo Moving! Status: '..player.status..'') 
				end
                moving = true
            elseif not movement and moving then
			    if sets.notmoving[player.main_job] and player.status ~= "Engaged" then 
                  send_command('gs equip sets.notmoving.'..player.main_job..'')
				end
				if state.SpellDebug.value == "On" then 
				  send_command('input /echo Stopped Moving! Status: '..player.status..'')
				end
                moving = false
            end
        end
        if pl and pl.x then
            mov.x = pl.x
            mov.y = pl.y
            mov.z = pl.z
        end
        mov.counter = 0
    end
end)


]]

