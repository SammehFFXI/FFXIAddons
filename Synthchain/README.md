Synthchain Addon:

This addon is used to automate the menu of the Synthesis Focuser II

Usage:

* //synthchain help -- Prints Help Menu
* //synthchain setchain Element1 Element2 Element3....   (can build long chains, manually edit txt file if you want longer than cmd line input gives you)
* //synthchain inv -- Populates inventory menu.
* //synthchain start -- starts chain
* //synthchain stop -- stops chain
* //synthchain log -- turns on/off logging.  By default there's a pretty deep debug log that will print out. 

NOTE:  You should not be engaged with the focuser already to use this chain.  Just be in range (6' yalms)

Once you've loaded the Addon.  Simply stand next to the synthesis focuser.   You can //synthchain inv  and it will just poke it and return your inv then leave, If you want to start just //synthchain start .   It will continue and loop through your current chain until you run out of Crystals, Spheres, or Catalysts. 

A few notes:
* On Tier 2/ Tier 3 Chains - it will pick one of the elements to use for the crystal. If you don't have that crystal it will use the next one available for that t2/t3.
* Any "break" resets the chain back to position #1.
* You can create chains well beyond a normal skillchain.  For Example //synthchain setchain Liquefaction Impaction Fragmentation Light Detonation Compression Distortion Darkness   
* when you do a //synthchain setchain   it will create a synthchain_YOURNAME.lua - you can manually edit this and make the table as long as you like.

