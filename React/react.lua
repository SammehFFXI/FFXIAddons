_addon.name = 'React'
_addon.author = 'Sammeh'
_addon.version = '1.4.0.9'
_addon.command = 'react'

-- 1.3.0 changing map.lua to job specific
-- 1.4.0 Allow react to react to PCs only if target = self 
-- 1.4.0.2/3 Fix for no primary target or skill in resources
-- 1.4.0.4 Add in a default "complete" command of "gs c update".
-- 1.4.0.5 Fix 1.4.0.4... urghzzz
-- 1.4.0.6 (Forgot to add in a part for auto doing "gs c update" for cure parts)
-- 1.4.0.7 Enhanced Debugging - Print to screen when in debugmode.
-- 1.4.0.8 With help of Langly - Fixed turnaround/facemob to be based on vector of the two objects vs. where the target is facing.  So now works with all angles
-- 1.4.0.9 Enhance the new turnaround/facemob with (actor) parameters so its not exclusively off target, but 'actor' in some instances.

require 'tables'
require 'sets'
require 'strings'
require 'actions'
require 'pack'
require 'logger'
files = require 'files'
require('chat')
res = require 'resources'

-- Change default React comments.
chatcolor = 8


if windower.ffxi.get_player() then 
 self = windower.ffxi.get_player()

 custom_reactions_file = files.new('react_'..self.main_job..'.lua')

if custom_reactions_file:exists() then
 windower.add_to_chat(2,'React: Loading File: react_'..self.main_job..'.lua')
else
 windower.add_to_chat(2,'React: New job detected, Creating file: react_'..self.main_job..'.lua')
 custom_reactions = {}
 custom_reactions_file:write('return ' .. T(custom_reactions):tovstring())
end


custom_reactions = require('react_'..self.main_job)

end

function addaction(args)
	local monster = args[1]
	local monster_action = args[2]
	local monster_reactiontype = args[3]
	if monster_reactiontype:lower() ~= "ready" and monster_reactiontype:lower() ~= "complete" then
		windower.add_to_chat(2,"Error: You didn't specify the Action Type as 'Ready' or 'Complete'")
		return
	end
	local monster_reaction = args[4]
	if custom_reactions[monster] then
		if custom_reactions[monster][monster_action] then
			current_ready_reaction = custom_reactions[monster][monster_action].ready_reaction or nil
			current_complete_reaction = custom_reactions[monster][monster_action].complete_reaction or nil
			if monster_reactiontype:lower() == "ready" then
				custom_reactions[monster][monster_action] = {ready_reaction=monster_reaction, complete_reaction=current_complete_reaction}
			elseif monster_reactiontype:lower() == "complete" then
				custom_reactions[monster][monster_action] = {complete_reaction=monster_reaction, ready_reaction=current_ready_reaction}
			end
		else 
			custom_reactions[monster][monster_action] = {}
			if monster_reactiontype:lower() == "ready" then
				custom_reactions[monster][monster_action] = {ready_reaction=monster_reaction, complete_reaction=""}
			elseif monster_reactiontype:lower() == "complete" then
				custom_reactions[monster][monster_action] = {complete_reaction=monster_reaction, ready_reaction=""}
			end
		end
	else 
		custom_reactions[monster] = {}
		if custom_reactions[monster][monster_action] then
			current_ready_reaction = custom_reactions[monster][monster_action].ready_reaction or nil
			current_complete_reaction = custom_reactions[monster][monster_action].reaction or nil
			if monster_reactiontype:lower() == "ready" then
				custom_reactions[monster][monster_action] = {ready_reaction=monster_reaction, complete_reaction=current_complete_reaction}
			elseif monster_reactiontype:lower() == "complete" then
				custom_reactions[monster][monster_action] = {complete_reaction=monster_reaction, ready_reaction=current_ready_reaction}
			end
		else 
			custom_reactions[monster][monster_action] = {}
			if monster_reactiontype:lower() == "ready" then
				custom_reactions[monster][monster_action] = {ready_reaction=monster_reaction, complete_reaction=""}
			elseif monster_reactiontype:lower() == "complete" then
				custom_reactions[monster][monster_action] = {complete_reaction=monster_reaction, ready_reaction=""}
			end
		end
	end
	custom_reactions_file:write('return ' .. T(custom_reactions):tovstring())
end

function listaction(args)
	local monster = args[1]
	if custom_reactions[monster] then
		for index,value in pairs(custom_reactions[monster]) do
			windower.add_to_chat(2,'Action:'..index..' Readies Reaction:'..value.ready_reaction..' Complete Reaction:'..value.complete_reaction)
		end
	else
		windower.add_to_chat(2,"No Monster found to list actions for:"..monster)
	end
end

function removeaction(args)
	local monster = args[1]
	local monster_action = args[2]
	if custom_reactions[monster][monster_action] then
		windower.add_to_chat(chatcolor,"Removed Reactions for:"..monster_action)
		custom_reactions[monster][monster_action] = nil
	else
		windower.add_to_chat(chatcolor,"Could not find Action to Remove:"..monster_action)
	end
	custom_reactions_file:write('return ' .. T(custom_reactions):tovstring())
end

windower.register_event('action',function (act)
	-- info here: http://dev.windower.net/doku.php?id=lua:api:events:action
		local actor = windower.ffxi.get_mob_by_id(act.actor_id)		
		local self = windower.ffxi.get_player()
		local target_count = act.target_count 
		local category = act.category  
		local param = act.param
		local recast = act.recast  
		local targets = act.targets
		local primarytarget = windower.ffxi.get_mob_by_id(targets[1].id)
		local valid_target = act.valid_target
		-- React to incidents where you're the primary target or any action by an NPC
		if actor and (actor.is_npc or primarytarget.name == self.name) and actor.name ~= self.name then 
			if debugmode == 1 then
				if category == 7 then 
					if res.monster_abilities[targets[1].actions[1].param] then 
						print('Ready Move:',actor.name,res.monster_abilities[targets[1].actions[1].param].en)
					end
				elseif category == 8 then 
					if res.spells[targets[1].actions[1].param] then
						print('Begins Casting',actor.name,res.spells[targets[1].actions[1].param].en,res.skills[res.spells[targets[1].actions[1].param].skill].en)
					end
				elseif category == 11 then
					if res.monster_abilities[param] then 
						print('Completed Ready Move:',actor.name,res.monster_abilities[param].en)
					end
				elseif category == 4 then
					if res.spells[param] then
						print('Completed Casting',actor.name,res.spells[param].en)
					end
				end
			end
			if category == 7 then -- Begin JA http://dev.windower.net/doku.php?id=lua:api:events:category_07
				if targets[1].actions[1].param ~= 0 then
					if res.monster_abilities[targets[1].actions[1].param] then 
						ability = res.monster_abilities[targets[1].actions[1].param] -- .en
						reaction(actor,category,ability,primarytarget)
					end
				end
			elseif category == 11 then  -- Finished JA (1hr's start / end here)  http://dev.windower.net/doku.php?id=lua:api:events:category_11
				if res.monster_abilities[param] then
					ability = res.monster_abilities[param] -- .en
					reaction(actor,category,ability,primarytarget)
				end
			elseif category == 8 then -- Start Casing Spell  http://dev.windower.net/doku.php?id=lua:api:events:category_08
				if targets[1].actions[1].param ~= 0 then
					ability = res.spells[targets[1].actions[1].param] -- .en
					reaction(actor,category,ability,primarytarget)
				end
			elseif category == 4 then -- Finished Casting Spell  http://dev.windower.net/doku.php?id=lua:api:events:category_04
				if res.spells[param] then
					ability = res.spells[param] --.en
					reaction(actor,category,ability,primarytarget)
				end
			end
		end
		
end)

function reaction(actor,category,ability,primarytarget)
	if custom_reactions[actor.name] then 
		if custom_reactions[actor.name][ability.en] then
			if category == 7 or category == 8 then 
				if custom_reactions[actor.name][ability.en].ready_reaction then
					if custom_reactions[actor.name][ability.en].ready_reaction:lower() == 'turnaround' then 
						turnaround(actor)
						if showcmds == 1 then 
							windower.add_to_chat(chatcolor,"----- React Action: Turning Around")
						end
					elseif custom_reactions[actor.name][ability.en].ready_reaction:lower() == 'facemob' then 
						facemob(actor)
						if showcmds == 1 then 
							windower.add_to_chat(chatcolor,"----- React Action: Facing Mob")
						end
					else
						windower.send_command(custom_reactions[actor.name][ability.en].ready_reaction)
						if showcmds == 1 then 
							windower.add_to_chat(chatcolor,"----- React Action:"..custom_reactions[actor.name][ability.en].ready_reaction)
						end
					end
				end
			else
				if custom_reactions[actor.name][ability.en].complete_reaction then
					if custom_reactions[actor.name][ability.en].complete_reaction:lower() == 'turnaround' then 
						turnaround(actor)
						if showcmds == 1 then 
							windower.add_to_chat(chatcolor,"----- React Action: Turning Around")
						end
					elseif custom_reactions[actor.name][ability.en].complete_reaction:lower() == 'facemob' then 
						facemob(actor)
						if showcmds == 1 then 
							windower.add_to_chat(chatcolor,"----- React Action: Facing")
						end
					elseif custom_reactions[actor.name][ability.en].complete_reaction == '' then
						windower.send_command("gs c update")
						if showcmds == 1 then 
							windower.add_to_chat(chatcolor,"----- React Action: Running Default gs c update")
						end
					else
						windower.send_command(custom_reactions[actor.name][ability.en].complete_reaction)
						if showcmds == 1 then 
							windower.add_to_chat(chatcolor,"----- React Action:"..custom_reactions[actor.name][ability.en].complete_reaction)
						end
					end
				end
			end
		end
	end
	-- Looking for if the target is yourself, and the magic skill is enhancing or healing magic
	if primarytarget and res.skills[ability.skill] then
		if (primarytarget.name == self.name and (res.skills[ability.skill].en == "Enhancing Magic" or res.skills[ability.skill].en == "Healing Magic")) then
			if debugmode == 1 then
				print('Primary Target Self, Spell:',ability.en,'Type:',res.skills[ability.skill].en)
			end
			if custom_reactions[self.name] then
				if custom_reactions[self.name][ability.en] then
					if category == 7 or category == 8 then
						if custom_reactions[self.name][ability.en].ready_reaction then
							windower.send_command(custom_reactions[self.name][ability.en].ready_reaction)
							if showcmds == 1 then 
								windower.add_to_chat(chatcolor,"----- React Action:"..custom_reactions[self.name][ability.en].ready_reaction)
							end
						end
					else
						if custom_reactions[self.name][ability.en].complete_reaction then
							if custom_reactions[self.name][ability.en].complete_reaction == '' then
								windower.send_command("gs c update")
								if showcmds == 1 then 
									windower.add_to_chat(chatcolor,"----- React Action: Running Default gs c update")
								end
							else
								windower.send_command(custom_reactions[self.name][ability.en].complete_reaction)
								if showcmds == 1 then 
									windower.add_to_chat(chatcolor,"----- React Action:"..custom_reactions[self.name][ability.en].complete_reaction)
								end
							end
						end
					end
				end
			end
		end
	end
end

windower.register_event('load', function()	
	debugmode = 0
	showcmds = 1
end)

windower.register_event('zone change',function(new,old)
end)

windower.register_event('addon command', function(command, ...)
	local args = L{...}
	if command:lower() == 'debugmode' then
		if debugmode == 0 then
			debugmode = 1
			windower.add_to_chat(chatcolor,"React: DEBUG MODE ON")
		else 
			debugmode = 0
			windower.add_to_chat(chatcolor,"React: DEBUG MODE OFF")
		end
	end
	if command:lower() == 'showcmds' then
		if showcmds == 0 then
			showcmds = 1
			windower.add_to_chat(chatcolor,"React: SHOW COMMANDS ON")
		else 
			showcmds = 0
			windower.add_to_chat(chatcolor,"React: SHOW COMMANDS OFF")
		end
	end

	if command:lower() == 'add' then
		addaction(args)
	end
	if command:lower() == 'list' then
		listaction(args)
	end
	if command:lower() == 'remove' then
		removeaction(args)
	end
	if command:lower() == 'help' then
		windower.add_to_chat(2,'React Help:')
		windower.add_to_chat(2,'	Please note all monsters and abilities are CASE SENSITIVE!!')
		windower.add_to_chat(2,'	Use Quotes to distinguish arugments with multiple words.  Ex: "Greater Manticore"')
		windower.add_to_chat(2,'React Commands:')
		windower.add_to_chat(2,'list:  Lists abilities per monster.  ARGS[1]"Monster"')
		windower.add_to_chat(2,'add:  Adds a reaction to an ability.  ARGS[1]"Monster" ARGS[2]"Action" ARGS[3]Type\{Ready or Complete\} ARGS[4]"Reaction"')
		windower.add_to_chat(2,'.....example: //react add "Greater Manticore" "Tail Swing" Ready "input /echo he used tail swing!!!"')
		windower.add_to_chat(2,'remove:  Removes action/reaction from a Monster.  ARGS[1]"Monster" ARGS[2]"Action"')
		windower.add_to_chat(2,'debugmode: Print to console all moves capable of reacting')
		windower.add_to_chat(2,'showcmds: Print to Chat Log cmds Executed')
	end

	if command:lower() == 'turnaround' then
		turnaround()
	end
    
    if command:lower() == 'facemob' then
        facemob()
    end
	

end)


function turnaround(actor) 
	local target = {}
	if actor then 
		target = actor
	else 
		target = windower.ffxi.get_mob_by_index(windower.ffxi.get_player().target_index or 0)
	end
	local self_vector = windower.ffxi.get_mob_by_index(windower.ffxi.get_player().index or 0)
	if target then  -- Pleaes note if you target yourself you will face due West
		local angle = (math.atan2((target.y - self_vector.y), (target.x - self_vector.x))*180/math.pi)*-1
		windower.ffxi.turn((angle+180):radian())
	else 
		windower.add_to_chat(10,"React: You're not targeting anything to turn around from")
	end
end

function facemob(actor)
	local target = {}
	if actor then
		target = actor
	else 
		target = windower.ffxi.get_mob_by_index(windower.ffxi.get_player().target_index or 0)
	end
	local self_vector = windower.ffxi.get_mob_by_index(windower.ffxi.get_player().index or 0)
	if target then  -- Please note if you target yourself you will face Due East
		local angle = (math.atan2((target.y - self_vector.y), (target.x - self_vector.x))*180/math.pi)*-1
		windower.ffxi.turn((angle):radian())
	else
		windower.add_to_chat(10,"React: You're not targeting anything to face")
	end
end


windower.register_event('job change', function()
	windower.send_command('lua r react')    
end)

windower.register_event('login', function()
	windower.send_command('lua r react')    
end)
