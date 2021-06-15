local ESX = nil 
Citizen.CreateThread(function() 
    while ESX == nil do 
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) 
        Citizen.Wait(0) 
    end 
end)
function ApriMenuSmonta()
    ESX.TriggerServerCallback('requestPlayerLoadout', function(elements)
        ESX.UI.Menu.Open('default',GetCurrentResourceName(),'fnx_smontaarmi',
            { 
            title = 'Smontaarmi', 
            align = 'top-left', 
            elements = elements 
            }, function(data, menu)
                if data.current.value ~= nil then
                    TriggerServerEvent('smontaarmi',false,data.current.value.name)
                end
        end, function(data, menu) 
        menu.close() 
        end)
    end)
end
if Config.UseKeyBind then
    RegisterCommand('apriMenuSmonta',ApriMenuSmonta)
    RegisterKeyMapping('apriMenuSmonta','Tasto per aprire il menu smontaarmi','KEYBOARD',Config.KeyBind)
end
RegisterNetEvent('fnx  ::  ApriMenuSmonta')
AddEventHandler('fnx  ::  ApriMenuSmonta',ApriMenuSmonta)
MxM.R_C_projectCallback('CurrentPlayerWeapon',function(cb)
local ped = PlayerPedId()
cb(GetSelectedPedWeapon(ped))
end)
AddEventHandler('esx:onPlayerDeath',function()
TriggerServerEvent('smontaarmi',true)
end)