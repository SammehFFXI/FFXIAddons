--[[ 
Copyright © 2018, Sammeh and Langly of Quetzalcoatl
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of React nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Sammeh or Langly BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
]]

_addon.name = 'SynthChain'
_addon.author = 'Sammeh + Langly, the Indomitable Duo'
_addon.version = '1.14.S'
_addon.date = '9.11.2018'
_addon.commands = {'synthchain'}

packets = require('packets')
res = require('resources')
require('tables')
require('logger')
require('pack')
config = require('config')
texts = require('texts')
files = require('files')

-- Text Setup
defaults = {}
defaults.display = {}
defaults.display.pos = {}
defaults.display.pos.x = 0
defaults.display.pos.y = 0
defaults.display.bg = {}
defaults.display.bg.red = 0
defaults.display.bg.green = 0
defaults.display.bg.blue = 0
defaults.display.bg.alpha = 150
defaults.display.text = {}
defaults.display.text.font = 'Courier New'
defaults.display.text.red = 255
defaults.display.text.green = 255
defaults.display.text.blue = 255
defaults.display.text.alpha = 255
defaults.display.text.size = 9

defaults.synthchainbox = {}
defaults.synthchainbox.pos = {}
defaults.synthchainbox.pos.x = 0
defaults.synthchainbox.pos.y = 0
defaults.synthchainbox.bg = {}
defaults.synthchainbox.bg.red = 0
defaults.synthchainbox.bg.green = 0
defaults.synthchainbox.bg.blue = 0
defaults.synthchainbox.bg.alpha = 150
defaults.synthchainbox.text = {}
defaults.synthchainbox.text.font = 'Courier New'
defaults.synthchainbox.text.red = 255
defaults.synthchainbox.text.green = 255
defaults.synthchainbox.text.blue = 255
defaults.synthchainbox.text.alpha = 255
defaults.synthchainbox.text.size = 9

defaults.logging = true
defaults.AddTimestamp = true
defaults.TimestampFormat = '%H:%M:%S'

settings = config.load(defaults)
settings:save()

name = windower.ffxi.get_player() and windower.ffxi.get_player().name
text_box = texts.new(settings.display, settings)
synthchainbox = texts.new(settings.synthchainbox, settings)

ValidChainOptions = S{"Liquefaction","Induration","Detonation","Scission","Impaction","Reverberation","Transfixion","Compression","Fusion","Distortion","Fragmentation","Gravitation","Light","Darkness"}

if windower.ffxi.get_player() then 
    synthchain_file = files.new('synthchain_'..name..'.lua')
 
    if synthchain_file:exists() then
    else
        emptyChain = {}
        synthchain_file:write('return ' .. T(emptyChain):tovstring())
    end

    synthchain_table = require('synthchain_'..name)
end



----------------------------------------------------------------
-- Globals
----------------------------------------------------------------
current_chain_packet_id_color = 0
switch = false
invonly = false
info = {}
lastpacket = nil

-- Modify this chain table for your desired chain. (how do we want this to look?)
info.status = 'None'
info.step = 1
info.spirit = 0


info.crystals = {
    ['Fire Crystal'] = 0,
    ['Water Crystal'] = 0,
    ['Lightning Crystal'] = 0,
    ['Wind Crystal'] = 0,
    ['Dark Crystal'] = 0,
    ['Light Crystal'] = 0,
    ['Ice Crystal'] = 0,
    ['Earth Crystal'] = 0}
    
info.spheres = {
    ['Liquefaction Sphere'] = { ['Count'] = 0, ['Tier'] = 1 },
    ['Induration Sphere'] = { ['Count'] = 0, ['Tier'] = 1 },
    ['Detonation Sphere'] = { ['Count'] = 0, ['Tier'] = 1 },
    ['Scission Sphere'] = { ['Count'] = 0, ['Tier'] = 1 },
    ['Impaction Sphere'] = { ['Count'] = 0, ['Tier'] = 1 },
    ['Reverberation Sphere'] = { ['Count'] = 0, ['Tier'] = 1 },
    ['Transfixion Sphere'] = { ['Count'] = 0, ['Tier'] = 1 },
    ['Compression Sphere'] = { ['Count'] = 0, ['Tier'] = 1 },
    ['Fusion Sphere'] = { ['Count'] = 0, ['Tier'] = 2 },
    ['Distortion Sphere'] = { ['Count'] = 0, ['Tier'] = 2 },
    ['Fragmentation Sphere'] = { ['Count'] = 0, ['Tier'] = 2 },
    ['Gravitation Sphere'] = { ['Count'] = 0, ['Tier'] = 2 },
    ['Light Sphere'] = { ['Count'] = 0, ['Tier'] = 3 },
    ['Darkness Sphere'] = { ['Count'] = 0, ['Tier'] = 3 }}
    
info.catalysts = {
    ['MC-I-SR01'] = 0,
    ['MC-I-SR02'] = 0,
    ['MC-I-SR03'] = 0}

info.synthchains = {
    ['Liquefaction'] = {['Fire Crystal'] = 4353 },
    ['Induration'] =  {['Ice Crystal'] = 8705 },
    ['Detonation'] =  {['Wind Crystal'] = 13057 },
    ['Scission'] =  {['Earth Crystal'] = 17409 },
    ['Impaction'] =  {['Lightning Crystal'] = 21761 },
    ['Reverberation'] = {['Water Crystal'] = 26113},
    ['Transfixion'] = {['Light Crystal'] = 30465},
    ['Compression'] = {['Dark Crystal'] = 34817},
    ['Fusion'] = {['Fire Crystal'] = 37121, ['Light Crystal'] = 38657},
    ['Distortion'] = {['Ice Crystal'] = 41473, ['Water Crystal'] = 42497},
    ['Fragmentation'] = {['Wind Crystal'] = 45825, ['Lightning Crystal'] = 46337},
    ['Gravitation'] = {['Dark Crystal'] = 51201, ['Earth Crystal'] = 50177},
    ['Light'] = {['Fire Crystal'] = 53505, ['Wind Crystal'] = 54017, ['Lightning Crystal'] = 54529, ['Light Crystal'] = 55041 },
    ['Darkness'] = {['Ice Crystal'] = 57857, ['Earth Crystal'] = 58369, ['Water Crystal'] = 58881, ['Dark Crystal'] = 59393 },
}

function reverse_lookup_packet_id()
    for index,chain in pairs(info.synthchains) do
        for crystal,packet_id in pairs(chain) do
            if packet_id == current_chain_packet_id_color then
                return {index,crystal,info.spheres[index..' Sphere']['Tier']}
            end
        end
    end
    return {nil,nil,nil}
end

function update_synthchainbox()
    local infobox = L{}
    local loop_number = 1
    infobox:append(' \\cs(0,255,255)Current Synthchain:\\cs(255,255,255)  ')
    while loop_number <= #synthchain_table do
        if loop_number == info.step then 
            infobox:append('\\cs(0,255,0)'..synthchain_table[loop_number])
        else
            infobox:append('\\cs(255,255,255)'..synthchain_table[loop_number])
        end
        loop_number = loop_number + 1
    end
    synthchainbox:clear()
    synthchainbox:append(infobox:concat('\n'))
    synthchainbox:show()
end

function update_all_textboxes()
    update_textbox()
    update_synthchainbox()
end

function return_color_count(count)
    if count == 0 then
        return '\\cs(255,0,0)'..count..'\\cs(255,255,255)'
    end
    if count < 10 then
        return '\\cs(255,255,0)'..count..'\\cs(255,255,255)'
    end
    if count >= 10 then
        return '\\cs(0,255,0)'..count..'\\cs(255,255,255)'
    end
end

function return_color_item(item)
    local count = 1
    local chain_data = reverse_lookup_packet_id()
    while count <= #chain_data do
        if item == chain_data[count] or item == chain_data[count]..' Sphere' or item == 'MC-I-SR0'..chain_data[count] then
            return('\\cs(0,255,0)'..item..'\\cs(255,255,255)')
        end
        count = count +1
    end
    return(item)
end

function logdata(data) 
    local date = os.date('*t')
    local file = files.new('./logs/%s_%.4u.%.2u.%.2u.log':format(name, date.year, date.month, date.day))
    if not file:exists() then
        file:create()
    end
    file:append('%s%s\n':format(settings.AddTimestamp and os.date(settings.TimestampFormat, os.time()) or '', data:strip_format()))
end

function update_textbox()
    local infobox = L{}
    infobox:append(' \\cs(0,255,255)Crystals:\\cs(255,255,255)')
    infobox:append(return_color_item('Fire Crystal')..':         '..return_color_count(info.crystals['Fire Crystal']))
    infobox:append(return_color_item('Ice Crystal')..':          '..return_color_count(info.crystals['Ice Crystal']))
    infobox:append(return_color_item('Wind Crystal')..':         '..return_color_count(info.crystals['Wind Crystal']))
    infobox:append(return_color_item('Earth Crystal')..':        '..return_color_count(info.crystals['Earth Crystal']))
    infobox:append(return_color_item('Lightning Crystal')..':    '..return_color_count(info.crystals['Lightning Crystal']))
    infobox:append(return_color_item('Water Crystal')..':        '..return_color_count(info.crystals['Water Crystal']))
    infobox:append(return_color_item('Light Crystal')..':        '..return_color_count(info.crystals['Light Crystal']))
    infobox:append(return_color_item('Dark Crystal')..':         '..return_color_count(info.crystals['Dark Crystal']))
    infobox:append(' ')
    infobox:append(' \\cs(0,255,255)Spheres:\\cs(255,255,255)')
    infobox:append(return_color_item('Liquefaction Sphere')..':  '..return_color_count(info.spheres['Liquefaction Sphere']['Count']))
    infobox:append(return_color_item('Induration Sphere')..':    '..return_color_count(info.spheres['Induration Sphere']['Count']))
    infobox:append(return_color_item('Detonation Sphere')..':    '..return_color_count(info.spheres['Detonation Sphere']['Count']))
    infobox:append(return_color_item('Scission Sphere')..':      '..return_color_count(info.spheres['Scission Sphere']['Count']))
    infobox:append(return_color_item('Impaction Sphere')..':     '..return_color_count(info.spheres['Impaction Sphere']['Count']))
    infobox:append(return_color_item('Reverberation Sphere')..': '..return_color_count(info.spheres['Reverberation Sphere']['Count']))
    infobox:append(return_color_item('Transfixion Sphere')..':   '..return_color_count(info.spheres['Transfixion Sphere']['Count']))
    infobox:append(return_color_item('Compression Sphere')..':   '..return_color_count(info.spheres['Compression Sphere']['Count']))
    infobox:append(return_color_item('Fusion Sphere')..':        '..return_color_count(info.spheres['Fusion Sphere']['Count']))
    infobox:append(return_color_item('Distortion Sphere')..':    '..return_color_count(info.spheres['Distortion Sphere']['Count']))
    infobox:append(return_color_item('Fragmentation Sphere')..': '..return_color_count(info.spheres['Fragmentation Sphere']['Count']))
    infobox:append(return_color_item('Gravitation Sphere')..':   '..return_color_count(info.spheres['Gravitation Sphere']['Count']))
    infobox:append(return_color_item('Light Sphere')..':         '..return_color_count(info.spheres['Light Sphere']['Count']))
    infobox:append(return_color_item('Darkness Sphere')..':      '..return_color_count(info.spheres['Darkness Sphere']['Count']))
    infobox:append(' ')
    infobox:append(' \\cs(0,255,255)Catalysts:\\cs(255,255,255)')
    infobox:append(return_color_item('MC-I-SR01')..':            '..return_color_count(info.catalysts['MC-I-SR01']))
    infobox:append(return_color_item('MC-I-SR02')..':            '..return_color_count(info.catalysts['MC-I-SR02']))
    infobox:append(return_color_item('MC-I-SR03')..':            '..return_color_count(info.catalysts['MC-I-SR03']))
    infobox:append(' ')
    infobox:append(' ')
    infobox:append(' \\cs(0,255,255)Spirit:\\cs(255,255,255)              '..info.spirit)
    
    text_box:clear()
    text_box:append(infobox:concat('\n'))
    text_box:show()
end

text_box:register_event('reload', update_all_textboxes)


windower.register_event('load', function()
    update_all_textboxes()
end)

----------------------------------------------------------------
-- Commands
----------------------------------------------------------------

windower.register_event('addon command', function (command, ...)
    command = command and command:lower()
    local args = T{...}
    
    if command == "start" then
        if #synthchain_table < 1 then
            warning('Synthchain Table Empty.  Please use //synthchain setchain Element1 Element2 Element3')
            return
        end
        info.step = 1  -- resetting Chain back to 0 to start.
        if settings.logging then
           logdata("Start Command Issued.")
        end
        
        notice('Starting SynthChain.')
        switch = true
        info.status = 'Open Menu'
        local focuser = get_marray('synthesis focuser ii')
        poke_npc(focuser[1].id, focuser[1].index)
        return
    end
    
    if command == "inv" then
        if settings.logging then
           logdata("Loading Inventory Start.")
        end
        
        notice('Loading Inventory')
        invonly = true
        switch = true
        info.status = 'Open Menu'
        local focuser = get_marray('synthesis focuser ii')
        poke_npc(focuser[1].id, focuser[1].index)
    end
  
    if command == 'killmenu' then
        if settings.logging then
           logdata("Killing Menu Manually.")
        end
        
        focuser_packet(10,false)
    end
    
    if command == "stop" then
        if settings.logging then
           logdata("Stop Issued. Exiting Menu.")
        end
        notice('Stopping SynthChain.  Please wait for current synth to End and Exit Menu')
        switch = false
        coroutine.sleep(10)
        focuser_packet(10,false)
        notice('Exit Complete.')
        return
    end
    
    if command == "setchain" then
        for i,v in pairs(args) do
            local current = windower.convert_auto_trans(v)
            if not ValidChainOptions:contains(current) then
                warning(v..' is not a valid Synthchain.  Please Fix.')
                return
            end
            args[i]=windower.convert_auto_trans(current) 
        end
        synthchain_file:write('return ' .. T(args):tovstring())
        synthchain_table = args 
        update_all_textboxes()
    end
    
    if command == "log" then
        if settings.logging then 
            settings.logging = false
            settings:save()
            notice('Turning off Logging')
        else
            settings.logging = true
            settings:save()
            notice('Turning on Logging')
        end 
    end
    
    if command == "help" then
        notice('Synthchain Help:')
        notice('Step 1: Set chain.  //synthchain setchain Element1 Element2 Element3')
        notice('Step 2: Stand next to Synthesis focuser and //synthchain start')
        notice('You will automatically stop if you run out of spheres, crystals, or catalysts.')
        notice('If you would like to stop manually, //synthchain stop')
        notice('Other Commands:')
        notice('...//synthchain inv         -- Populates Inventory Only')
        notice('...//synthchain start       -- Starts Chain')
        notice('...//synthchain stop        -- Exits Chain')
        notice('...//synthchain log         -- turns on/off Debug Logging')
        notice('...//synthchain setchain   -- Writes Chain. Case Sensitive. ')
        notice('.......Ex: //synthchain setchain Liquefaction Impaction Fragmentation .. ..')
    end
    
end)

----------------------------------------------------------------
-- Events
----------------------------------------------------------------
windower.register_event('incoming chunk',function(id,data,modified,injected,blocked)
    if id == 0x34 and info.status == 'Open Menu' then
        info.status = 'Initial'
        if settings.logging then
            logdata("Received 0x34 back from Open Menu, Setting to Initial.")
        end
        if invonly then
            focuser_packet(10, true)
            if settings.logging then
                logdata("Setting for Inventory Load Only.")
            end
            return true 
        end
        focuser_packet(10, true)
        notice('Opening Chain Menu.')
        if settings.logging then
           logdata("Opening Initial Menu.")
        end
        return true
    end

    if id == 0x5C and switch then
        --local packet = packets.parse('incoming', data)
        local packet = {}
        if settings.logging then
            local packet2 = packets.parse('incoming', data)
            logdata("Received 0x05C. Current Status: "..info.status.."   Showing all non 0 byte packets:")
            for i=0, packet2._size, 1 do
                currentChar = data:unpack('C',i)
                if currentChar ~= 0 then 
                    logdata("Byte "..i..": "..currentChar)
                end
            end
        end
        
        
        -- Duplicate packet detection
        if data == lastpacket then
            if settings.logging then
                logdata("Dupe packet detected - Ignoring")
            end
            notice('Dupe packet detected, Ignoring')
            return
        end
        
        lastpacket = data
        
        
        local TypePacket = 0
        -- 1 = Inventory Update,  2 = Spirit Update,  3 = Ack/Shield/Other
        
        if data:unpack('II',33) == 0 then
            TypePacket = 1
        end
        if data:unpack('II',33) ~= 0 then
            TypePacket = 2
        end
        if data:unpack('C',10) == 103 and data:unpack('C',21) == 99 and data:unpack('C',13) == 0 and data:unpack('C',14) == 0 and data:unpack('C',15) == 0 then
            TypePacket = 3
        end
        
        packet['Spirit'] = data:unpack('II',33)
        
        if TypePacket == 1 then
            packet['Fire Crystal'] = data:unpack('C',5)
            packet['Ice Crystal'] = data:unpack('C',6)
            packet['Wind Crystal'] = data:unpack('C',7)
            packet['Earth Crystal'] = data:unpack('C',8)
            packet['Lightning Crystal'] = data:unpack('C',9)
            packet['Water Crystal'] = data:unpack('C',10)
            packet['Light Crystal'] = data:unpack('C',11)
            packet['Dark Crystal'] = data:unpack('C',12)
            packet['MC-I-SR01'] = data:unpack('C',13)
            packet['MC-I-SR02'] = data:unpack('C',14)
            packet['MC-I-SR03'] = data:unpack('C',15)
            packet['Liquefaction Sphere'] = data:unpack('C',16)
            packet['Induration Sphere'] = data:unpack('C',17)
            packet['Detonation Sphere'] = data:unpack('C',18)
            packet['Scission Sphere'] = data:unpack('C',19)
            packet['Impaction Sphere'] = data:unpack('C',20)
            packet['Reverberation Sphere'] = data:unpack('C',21)
            packet['Transfixion Sphere'] = data:unpack('C',22)
            packet['Compression Sphere'] = data:unpack('C',23)
            packet['Fusion Sphere'] = data:unpack('C',24)
            packet['Distortion Sphere'] = data:unpack('C',25)
            packet['Fragmentation Sphere'] = data:unpack('C',26)
            packet['Gravitation Sphere'] = data:unpack('C',27)
            packet['Light Sphere'] = data:unpack('C',28)
            packet['Darkness Sphere'] = data:unpack('C',29)
            info.crystals['Fire Crystal'] = packet['Fire Crystal']
            info.crystals['Water Crystal'] = packet['Water Crystal']
            info.crystals['Lightning Crystal'] = packet['Lightning Crystal']
            info.crystals['Wind Crystal'] = packet['Wind Crystal']
            info.crystals['Dark Crystal'] = packet['Dark Crystal']
            info.crystals['Light Crystal'] = packet['Light Crystal']
            info.crystals['Ice Crystal'] = packet['Ice Crystal']
            info.crystals['Earth Crystal'] = packet['Earth Crystal']
            info.spheres['Liquefaction Sphere']['Count'] = packet['Liquefaction Sphere']
            info.spheres['Induration Sphere']['Count'] = packet['Induration Sphere']
            info.spheres['Detonation Sphere']['Count'] = packet['Detonation Sphere']
            info.spheres['Scission Sphere']['Count'] = packet['Scission Sphere']
            info.spheres['Impaction Sphere']['Count'] = packet['Impaction Sphere']
            info.spheres['Reverberation Sphere']['Count'] = packet['Reverberation Sphere']
            info.spheres['Transfixion Sphere']['Count'] = packet['Transfixion Sphere']
            info.spheres['Compression Sphere']['Count'] = packet['Compression Sphere']
            info.spheres['Fusion Sphere']['Count'] = packet['Fusion Sphere']
            info.spheres['Distortion Sphere']['Count'] = packet['Distortion Sphere']
            info.spheres['Fragmentation Sphere']['Count'] = packet['Fragmentation Sphere']
            info.spheres['Gravitation Sphere']['Count'] = packet['Gravitation Sphere']
            info.spheres['Light Sphere']['Count'] = packet['Light Sphere']
            info.spheres['Darkness Sphere']['Count'] = packet['Darkness Sphere']
            info.catalysts['MC-I-SR01'] = packet['MC-I-SR01']
            info.catalysts['MC-I-SR02'] = packet['MC-I-SR02']
            info.catalysts['MC-I-SR03'] = packet['MC-I-SR03']
            update_all_textboxes()
        end
        
        if TypePacket == 2 then
            --notice('Received updated Spirit Packet - Current spirit: '..packet['Spirit'])
            info.spirit = packet['Spirit']
        end
            
        if invonly then
            if settings.logging then
                logdata("Inv only received.  Stopping and exiting Menu.")
            end
            invonly = false
            switch = false
            focuser_packet(10,false)
            return
        end

        if info.status == 'Initial' and TypePacket == 1 and not invonly then
            --[[ 
                See if I have enough Catalysts, Crystals, and Sphere's for current step
                if 0, we don't have enough Catalysts, Crystals, or sphere.  Otherwise, 
                we return the packet ID needed to submit the synth.
            ]]
            local chain_packet_id = synth_lookup(synthchain_table[info.step])
            current_chain_packet_id_color = chain_packet_id
            update_all_textboxes()
            if chain_packet_id > 0 then 
                coroutine.sleep(2)
                update_synthchainbox()
                focuser_packet(chain_packet_id, true)
                if settings.logging then 
                    logdata("Sending Synthchain: "..chain_packet_id..".  Setting info.status to Spirit Update")
                end
                info.status = 'Spirit Update'
            else 
                switch = false
                info.status = 'End'
            end
        elseif info.status == 'Spirit Update' and TypePacket == 2 then
            --[[ 
                Get Packet Info:
            On a Spirit Update: 
                Byte 9 is animation for Skillchain. 
                    Value: 
                    0 = no animation / no chain
                    1 = Liquefaction
                    2 = Induration
                    3 = Detonation
                    4 = Scission
                    5 = Impaction
                    6 = Reverberation
                    7 = Transfixion
                    8 = Compression
                    9 = Fusion
                    10 = Distortion
                    11 = Fragmentation
                    12 = Gravitation
                    13 = Light
                    14 = Dark

                Byte 5 is 0 on a Synth fail, and 1 on a synth success  2 = (seems reasonably an HQ)
                Byte 17:  Correlates to the crystal used in res/elements.lua
                Byte 21:  _unknown (Seen values: 194, 134)
                Byte 22: 1 (static?) 
                Byte 25: Amount of Spirit Gain/Loss
                Byte 29: Seen 0 - 80 observed - on errors seems to grow quickly;  I think could be Stability bar?  (negative? - normally at 100 and reduces by value?) 
            ]]
            local SynthChainOptions = {
                [0] = "None",
                [1] = "Liquefaction",
                [2] = "Induration",
                [3] = "Detonation",
                [4] = "Scission",
                [5] = "Impaction",
                [6] = "Reverberation",
                [7] = "Transfixion",
                [8] = "Compression",
                [9] = "Fusion",
                [10] = "Distortion",
                [11] = "Fragmentation",
                [12] = "Gravitation",
                [13] = "Light",
                [14] = "Darkness",
            }
            local SynthSuccess = data:unpack('C',5)
            local SynthChain = SynthChainOptions[data:unpack('C',9)]
            local AnimationElement = res.elements[data:unpack('C',17)].en
            local SpiritGain = data:unpack('C',25)
            local Stability = data:unpack('C',29)
            
            info.spirit = packet['Spirit']

            if SynthSuccess == 0 then
                info.step = 1  -- We can work on timing and chose not to reset and instead repeat here.
                if settings.logging then
                    notice("ERROR: Synth Fail. Resetting Chain. Current Spirit:"..info.spirit)
                    logdata("ERROR: Synth Fail. Resetting Chain. Current Spirit:"..info.spirit)
                end
            else 
                if settings.logging then 
                    if SynthSuccess == 1 then 
                        notice("Synth Success! Chain Performed:"..SynthChain.." Spirit Gained:"..SpiritGain.." Current Spirit:"..info.spirit)
                        logdata("Synth Success! Chain Performed:"..SynthChain.." Spirit Gained:"..SpiritGain.." Current Spirit:"..info.spirit)
                    elseif SynthSuccess == 2 then
                        notice("HQ Synth Success! Chain Performed:"..SynthChain.." Spirit Gained:"..SpiritGain.." Current Spirit:"..info.spirit)
                        logdata("HQ Synth Success! Chain Performed:"..SynthChain.." Spirit Gained:"..SpiritGain.." Current Spirit:"..info.spirit)
                    end
                end 
                if info.step >= #synthchain_table then 
                    info.step = 1
                    if settings.logging then
                        logdata("Hit end of chain - resetting. Current Spirit:"..info.spirit)
                        
                    end
                else
                    info.step = info.step + 1
                    if settings.logging then
                        logdata("Moving to next step. "..info.step.." Current Spirit:"..info.spirit)
                    end
                end
            end
            
            if settings.logging then
                logdata("Sleeping 10 for animation delay and sending ACK, setting to 'Chain Ready'")
            end
            coroutine.sleep(10)
            focuser_packet(4,true)
            info.status = 'Chain Ready'
            
        elseif info.status == 'Chain Ready' and TypePacket == 3 then
            coroutine.sleep(1)
            focuser_packet(10,true)
            if switch then
                info.status = 'Initial'
                if settings.logging then
                    logdata("Finished synth. Setting Status back to Initial")
                end
            else
                info.status = 'End'
                warning('Chain Ended - Exiting Menu. ')
                if settings.logging then
                    logdata("Chain Ended. Setting Status:"..info.status)
                end
            end
        end
        
        if info.status == 'End' then 
            coroutine.sleep(2)
            focuser_packet(10,false)
            if settings.logging then
               logdata("Sending Exit Menu Packet.  Status: End")
            end
        end
    end
end)

----------------------------------------------------------------
-- Helpers
----------------------------------------------------------------
--Obvious functionality
function poke_npc(id, index)
    if id and index then
        local packet = packets.new('outgoing', 0x01A, {
            ["Target"]=id,
            ["Target Index"]=index,
            ["Category"]=0,
            ["Param"]=0,
            ["_unknown1"]=0})
        packets.inject(packet)
    end
end

--[[ 
Check if I have the appropriate pre-req's to synth - return 0 if false, otherwise return packet ID 
]]
function synth_lookup(chain)
    if settings.logging then
       logdata("Looking up Chain.."..chain)
    end
        
    local sphereInfo = info.spheres[chain..' Sphere']
    local tier = sphereInfo['Tier']
    -- Check Catalyst
    if info.catalysts['MC-I-SR0'..tier] == 0 then 
        if settings.logging then
            logdata(chain..": Out of Catalysts!")
        end
        warning(chain..': Out of Catalysts!')
        return 0
    end
    -- Check Sphere's
    if sphereInfo['Count'] == 0 then
        if settings.logging then
            logdata(chain..": Out of Spheres!")
        end
        
        warning(chain..': Out of Spheres!')
        return 0
    end
    
    for crystal,value in pairs(info.synthchains[chain]) do
        if info.crystals[crystal] > 0 then
            notice(chain..': Found Crystal: '..crystal)
            if settings.logging then
                logdata(chain..": Found Crystal: "..crystal)
            end
        
            --notice('Chain Packet ID: '..value)
            return value
        end
    end
    if settings.logging then
        logdata(chain..": Out of Crystals!")
    end
        
    warning(chain..': Out of Crystals!')
    return 0
end

--[[
    Pass an option index (4,10,chain value) as well as the automated message for exiting
--]]
function focuser_packet(option_index, automated)
    local focuser = get_marray('synthesis focuser ii')
    local packet = packets.new('outgoing', 0x05B, {
        ["Target"]=focuser[1].id,
        ["Option Index"]=option_index,
        ["Target Index"]=focuser[1].index,
        ["Zone"]=246,
        ["Menu ID"]=426,
        ["Automated Message"]=automated})
    packets.inject(packet)
end

--[[ Format of new Mob Array
    Returns an array of comprehensive mob data. Useful fields below.
    number:
        id, index, claim_id, x, y, z, distance, facing, entity type, target index,
        spawn_type, status, model_scale, heading, model_size, movement_speed,
    string:
        name,
    booleans:
        is_npc, in_alliance, charmed, in_party, valid_target
--]]
function get_marray(--[[optional]]name)
    local marray = windower.ffxi.get_mob_array()
    local target_name = name or nil
    local new_marray = T{}
    
    for i,v in pairs(marray) do
        if v.id == 0 or v.index == 0 then
            marray[i] = nil
        end
    end
    
    -- If passed a target name, strip those that do not match
    if target_name then
        for i,v in pairs(marray) do
            if v.name:lower() ~= target_name:lower() then
                marray[i] = nil
            end
        end
    end
    
    for i,v in pairs(marray) do 
        new_marray[#new_marray + 1] = windower.ffxi.get_mob_by_index(i)
    end
    return new_marray
end

windower.register_event('job change', function()
	windower.send_command('lua r synthchain')    
end)

windower.register_event('login', function()
	windower.send_command('lua r synthchain')    
end)
