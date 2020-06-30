_addon.name = 'test21'
_addon.author = 'Sammeh'
_addon.version = '0.0'
_addon.command = 'test21'


windower.register_event('addon command', function(...)
end)

windower.register_event('keyboard',function(dik,pressed,flags,blocked)
    if pressed == true then
      print("Keyboard DIK: "..dik.." pushed down")
    else
      print("Keyboard DIK: "..dik.." released")
    end
    --print(dik,pressed,flags,blocked)
end)


windower.register_event('load', function()
end)




