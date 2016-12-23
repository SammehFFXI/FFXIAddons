React:

React is a plugin to react to different situations.  

React can react to the following events
 * <Actor> begins casting <action>
 * <Actor> readies <action>
 * <Actor> finishes casting <action>
 * <Actor> finishes ready move.
 
To create an action:
 //react add "Actor" "Action" Ready "Reaction"  -- during readies phase
 //react add "Actor" "Action" Complete "Reaction" -- After Ready phase
 
To list actions for an Actor
 //react list "Actor"
 
To remove an action
 //react remove "Actor" "Action"
 
Reactions are job specific and are saved in a file within the React directory called react_<JOB>.lua
 
Prior to version 1.4; React only worked with the actor as an NPC (trust or enemy mob).  With version 1.4, react has been expanded to react based on Player characters only in the instances of Healing or Enhancing Magic.  In order for this type of processing to occur, you must build a reaction with the Actor of yourself.  Example:  //react add "YOURNAMEHERE" "Protect V" ready "input /equip ring1 'sheltered ring'"
 
At version 1.4.0.4 I added in a default "complete" command of "gs c update" 
 
Custom Reactions:
 * The special reaction verb "turnaround" will simply face same direction as the <actor>.  Useful for Gaze attacks in 'ready' phase.)
 * The special reaction verb "facemob" will simply face the same direction as the <actor>.  (Used in 'complete' phase.)
 
Examples:
 Warder of Courage uses an SP 60 seconds after previous move wears off - so can create a timer based on that.
 //react add "Warder of Courage" "Benediction" Complete "timers create \"Next Ready Move:\" 60 down"
 
 or Turn around from "Mortal Ray" 
 //react add "Tyrannotaur" "Mortal Ray" ready "turnaround"
 //react add "Tyrannotaur" "Mortal Ray" complete "facemob"
 
 
 
 
 