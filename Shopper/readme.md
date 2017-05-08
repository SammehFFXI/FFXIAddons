Shopper Addon - 1.0

Usage: //shop buy COUNT NPC_NAME ITEM

Example: //shop buy 1 Yoskolo Grape Juice

Notes: 
* You can only buy based on stack item in resources.  Example: Juices can only buy 1 at a time.  Other items like Arrows can go up to 99
* NPC_NAME must be in quotes if it's a Mithra (2 names - silly)
* Some NPCs have special menus before they give you the purchase menu, weed through these manually for now.


Since the built in Packets Library doesn't have a complete data definition for incoming 0x03c you must mod the fields.lua 
the section starting with "types.shop_item" (around Line 2097) you'll add 2 lines (the _unknown1 and _unknown2)
types.shop_item = L{
    {ctype='unsigned int',      label='Price',              fn=gil},            -- 00
    {ctype='unsigned short',    label='Item',               fn=item},           -- 04
    {ctype='unsigned short',    label='Shop Slot'},                             -- 08
	{ctype='unsigned short',     label='_unknown1'},                               -- Shows up on Guild NPCs.  Unknown.
	{ctype='unsigned short',     label='_unknown2'},                               -- Correlates to Rank able to purchase product from GuildNPC
}
