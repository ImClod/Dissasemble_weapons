local ESX = nil
TriggerEvent('esx:getSharedObject',function(obj) ESX = obj end)
local version = GetResourceMetadata('es_extended','version',GetNumResourceMetadata('es_extended','version')-1)
AddEventHandler('onResourceStart',function(resName)
    if resName==GetCurrentResourceName() then
        if version ~= nil then
            if version == 'legacy' or version =='1.final' or version == '1.2.0' then
                print('^1[ Smontaarmi ] ^0 Made by ImClod#0001 Correct ESX version')
                print('^1[ SmontaArmi ]^0 Inizializing items')
                local i = 0
                for k,v in pairs(Config.Weapons) do
                    i = i+1
                    ESX.RegisterUsableItem(v.item, function(source) 
                    local xPlayer = ESX.GetPlayerFromId(source)
                        if xPlayer then
                           if xPlayer.getInventoryItem(v.item).count >0 then
                                xPlayer.addWeapon(k,0)
                                xPlayer.removeInventoryItem(v.item,1)
                                xPlayer.triggerEvent('esx:showNotification', 'Hai montato '..ESX.GetWeaponLabel(k))
                           end
                        end
                    end)
                end
                print('^1[ SmontaArmi ]^0 Finished inizializing in : '..i..' ms')
            else
                print('^1[ Smontaarmi ]^0 Your ESX version doesnt support this resource. ^1 Your ESX version: '..version..'^0 ^3 Required: legacy or v1 final^0 \nPlease update your server ^1 Made By ImClod#001')
            end
        else
            print('^1[ Smontaarmi ] ^0 Made by ImClod#0001 Seems like u dont have ESX installed on your server, this resource need ESX in order to run')
        end
    end
end)
ESX.RegisterServerCallback('requestPlayerLoadout', function(source,cb)
    local elements = {} 
    local xPlayer = ESX.GetPlayerFromId(source)
    if version and version == 'legacy' or version == '1.2.0' or version =='1.final' then
        if xPlayer then
            if Config.KRZ then
                cb(xPlayer.loadout)
            else
                for k,v in pairs(xPlayer.loadout) do
                    table.insert(elements, {label = 'Smonta '..ESX.GetWeaponLabel(v.name)..' Numero di accessori:'.. #v.components,value ={name =v.name,ammo = v.ammo,components= v.components}})
                end
                cb(elements)
            end
        end
    else
        print('This resource will not work with your ESX version please update it to v1 final')
    end
end)
RegisterServerEvent('smontaarmi')
AddEventHandler('smontaarmi',function(completo, arma)
local xPlayer = ESX.GetPlayerFromId(source)          
    if xPlayer then
        if not completo then
            for k,v in pairs(xPlayer.loadout) do
                if arma == v.name then
                    if #(v.components) > 0 then
                        if v.ammo > 0 then
                            DaiMunizioni(v.ammo,v.name,source)
                            RimuoviDaiAccessori(v.components,v.name,source)
                            xPlayer.removeWeapon(v.name)
                            xPlayer.addInventoryItem(Config.Weapons[v.name].item,1)
                        else
                            RimuoviDaiAccessori(v.components,v.name,source)
                            xPlayer.removeWeapon(v.name)
                            xPlayer.addInventoryItem(Config.Weapons[v.name].item,1)
                        end
                    else
                        if v.ammo > 0 then
                            DaiMunizioni(v.ammo,v.name,source)
                            xPlayer.removeWeapon(v.name)
                            xPlayer.addInventoryItem(Config.Weapons[v.name].item,1)
                        else
                            xPlayer.removeWeapon(v.name)
                            xPlayer.addInventoryItem(Config.Weapons[v.name].item,1)
                        end
                    end
                end
            end
        else
            local pistole = 0
            local smg = 0
            local rifles = 0
            local pompa = 0
            local Colpi = {}
            Colpi.Pistole = {}
            Colpi.Smg = {}
            Colpi.Rifles = {}
            Colpi.Pompa = {}
            for k,v in pairs(xPlayer.loadout) do
                if #(v.components) > 0 then
                    if v.ammo > 0 then
                        RimuoviDaiAccessori(v.components,v.name,source)
                        if string.match(v.name:lower():lower(),'pistol') then
                            pistole = pistole+1
                        Colpi.Pistole = v.ammo
                        elseif string.match(v.name:lower(),'smg') then
                            smg = smg+1 
                            Colpi.Smg = v.ammo
                        elseif string.match(v.name:lower(),'rifle') then
                            rifles = rifles+1
                            Colpi.Rifles = v.ammo
                        elseif string.match(v.name:lower(),'shot') then
                            pompa = pompa +1 
                            Colpi.Pompa = v.ammo
                        end
                    else
                        RimuoviDaiAccessori(v.components,v.name,source)
                        xPlayer.removeWeapon(v.name)
                        xPlayer.addInventoryItem(Config.Weapons[v.name].item,1)
                    end
                else
                    if v.ammo > 0 then
                        if string.match(v.name,'pistol') then
                            pistole = pistole+1
                        Colpi.Pistole = v.ammo
                        elseif string.match(v.name,'smg') then
                            smg = smg+1 
                            Colpi.Smg = v.ammo
                        elseif string.match(v.name,'rifle') then
                            rifles = rifles+1
                            Colpi.Rifles = v.ammo
                        elseif string.match(v.name,'shot') then
                            pompa = pompa +1 
                            Colpi.Pompa = v.ammo
                        end
                    else
                        xPlayer.removeWeapon(v.name)
                        xPlayer.addInventoryItem(Config.Weapons[v.name].item,1)
                    end
                end
            end
            print(pistole,smg,rifles,pompa,ESX.DumpTable(Colpi))
            ControllaColpi(pistole,smg,rifles,pompa,Colpi,source)
        end
    end 
end)
DaiMunizioni = function(ammo,weaponName,id)
    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer then
        xPlayer.removeWeaponAmmo(weaponName, ammo)
        if string.match(weaponName:lower(),'pistol') then
            xPlayer.addInventoryItem('pAmmo',ESX.Math.Round(ammo/12))
        elseif string.match(weaponName:lower(),'smg') then
            xPlayer.addInventoryItem('smgAmmo',ESX.Math.Round(ammo/25))
        elseif string.match(weaponName:lower(),'rifle') then
            xPlayer.addInventoryItem('arAmmo',ESX.Math.Round(ammo/30))
        elseif string.match(weaponName:lower(),'shot') then
            xPlayer.addInventoryItem('stAmmo',ESX.Math.Round(ammo/8))
        end
    end
end
RimuoviDaiAccessori = function(accTable,name,source)
   local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        for k,v in pairs(accTable) do
            xPlayer.addInventoryItem('weapon_'..v,1)
            xPlayer.removeWeaponComponent(name, v)
        end
    end
end
ControllaColpi = function(pistole,smg,rifles,pompa,Colpi,id)
    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer then
        if pistole > 0 then
            print(Colpi.Pistole)
            xPlayer.addInventoryItem('pAmmo',ESX.Math.Round(tonumber(Colpi.Pistole)/12))
        elseif smg > 0 then
            xPlayer.addInventoryItem('smgAmmo',ESX.Math.Round(tonumber(Colpi.Smg)/25))
        elseif rifles > 0 then
            xPlayer.addInventoryItem('arAmmo',ESX.Math.Round(tonumber(Colpi.Rifles)/30))
        elseif pompa > 0 then
            xPlayer.addInventoryItem('stAmmo',ESX.Math.Round(tonumber(Colpi.Pompa)/8))
        end
        for k,v in pairs(xPlayer.loadout) do
            xPlayer.addInventoryItem(Config.Weapons[v.name].item,1)
            xPlayer.removeWeapon(v.name)
        end
    end
end
ESX.RegisterUsableItem('pAmmo', function(source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MxM.T_C_projectCallback(source,'CurrentPlayerWeapon',function(weaponHash)
            if weaponHash then
                local weaponName = ESX.GetWeaponFromHash(weaponHash)
                if weaponName and weaponName.name then
                    if string.match(weaponName.name:lower(),'pistol') then
                        local loadout,weapon = xPlayer.getWeapon(weaponName.name)
                        if xPlayer.getInventoryItem('pAmmo').count> 0 then
                            if weapon.ammo+12 < 250 then
                                xPlayer.removeInventoryItem('pAmmo',1)
                                xPlayer.addWeaponAmmo(weaponName.name ,12)
                            end
                        end
                    end
                else 
                    xPlayer.showNotification('non hai un arma equipaggiata')
                end
            end
        end)
    end
end)
ESX.RegisterUsableItem('smgAmmo', function(source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MxM.T_C_projectCallback(source,'CurrentPlayerWeapon',function(weaponHash)
            if weaponHash then
                local weaponName = ESX.GetWeaponFromHash(weaponHash)
                local loadout,weapon = xPlayer.getWeapon(weaponName.name)
                if weaponName and weaponName.name then
                    if string.match(weaponName.name ,'smg') then
                        if weapon.ammo+25 < 250 then
                            if xPlayer.getInventoryItem('smgAmmo').count >0 then
                                xPlayer.addWeaponAmmo(weaponName.name ,25)
                            end
                        end
                    end
                end
            else 
                xPlayer.showNotification('non hai un arma equipaggiata')
            end
        end)
    end
end)
ESX.RegisterUsableItem('arAmmo', function(source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MxM.T_C_projectCallback(source,'CurrentPlayerWeapon',function(weaponHash)
            if weaponHash then
                local weaponName = ESX.GetWeaponFromHash(weaponHash)
                local loadout,weapon = xPlayer.getWeapon(weaponName.name)
                if weaponName and weaponName.name then
                    if string.match(weaponName.name ,'rifle') then
                        if weapon.ammo+30 < 250 then
                            if xPlayer.getInventoryItem('arAmmo').count >0 then
                                xPlayer.addWeaponAmmo(weaponName.name ,30)
                            end
                        end
                    end
                end
            else 
                xPlayer.showNotification('non hai un arma equipaggiata')
            end
        end)
    end
end)
ESX.RegisterUsableItem('stAmmo', function(source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MxM.T_C_projectCallback(source,'CurrentPlayerWeapon',function(weaponHash)
            if weaponHash then
                local weaponName = ESX.GetWeaponFromHash(weaponHash)
                local loadout,weapon = xPlayer.getWeapon(weaponName.name)
                if weaponName and weaponName.name then
                    if string.match(weaponName.name ,'shot') then
                        if weapon.ammo+8 < 250 then
                            if xPlayer.getInventoryItem('stAmmo').count >0 then
                                xPlayer.addWeaponAmmo(weaponName.name ,8)
                            end
                        end
                    end
                end
            else 
                xPlayer.showNotification('non hai un arma equipaggiata')
            end
        end)
    end
end)
ESX.RegisterUsableItem('weapon_suppressor', function(source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MxM.T_C_projectCallback(source,'CurrentPlayerWeapon',function(weaponHash)
            if weaponHash then
                local weaponName = ESX.GetWeaponFromHash(weaponHash)
                if weaponName and weaponName.name then
                    if not xPlayer.hasWeaponComponent(weaponName.name ,'suppressor') then
                        xPlayer.removeInventoryItem('weapon_suppressor',1)
                        xPlayer.addWeaponComponent(weaponName.name,'suppressor')
                    end
                end
            else 
                xPlayer.showNotification('non hai un arma equipaggiata')
            end
        end)
    end
end)
ESX.RegisterUsableItem('weapon_clip_extended', function(source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MxM.T_C_projectCallback(source,'CurrentPlayerWeapon',function(weaponHash)
            if weaponHash then
                local weaponName = ESX.GetWeaponFromHash(weaponHash)
                if weaponName and weaponName.name then
                    if  not xPlayer.hasWeaponComponent(weaponName.name ,'clip_extended') then
                        xPlayer.removeInventoryItem('weapon_clip_extended',1)
                        xPlayer.addWeaponComponent(weaponName.name ,'clip_extended')
                    end
                end
            else 
                xPlayer.showNotification('non hai un arma equipaggiata')
            end
        end)
    end
end)

ESX.RegisterUsableItem('weapon_flashlight', function(source) 
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        MxM.T_C_projectCallback(source,'CurrentPlayerWeapon',function(weaponHash)
            if weaponHash then
                local weaponName = ESX.GetWeaponFromHash(weaponHash)
                if weaponName and weaponName.name then
                    if not  xPlayer.hasWeaponComponent(weaponName.name ,'flashlight') then
                        xPlayer.removeInventoryItem('weapon_flashlight',1)
                        xPlayer.addWeaponComponent(weaponName.name ,'flashlight')
                    end
                end
            else 
                xPlayer.showNotification('non hai un arma equipaggiata')
            end
        end)
    end
end)
