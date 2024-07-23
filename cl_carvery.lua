local carveryZones = {}
local Config = lib.require('config')
local ox_inv = GetResourceState('ox_inventory') == 'started'
local emoteProp

local ta_blip = AddBlipForCoord(Config.BlipCoords)
SetBlipSprite(ta_blip, 79)
SetBlipDisplay(ta_blip, 4)
SetBlipScale(ta_blip, 0.5)
SetBlipAsShortRange(ta_blip, true)
SetBlipColour(ta_blip, 69)
BeginTextCommandSetBlipName('STRING')
AddTextComponentSubstringPlayerName('Carvery')
EndTextCommandSetBlipName(ta_blip)

local function toggleEmotes(bool, emote)
    if bool then
        local doEmote = Config.Emotes[emote]
        lib.requestAnimDict(doEmote.dict, 2000)
        lib.requestModel(doEmote.prop, 2000)
        if doEmote.prop then
            emoteProp = CreateObject(doEmote.prop, 0.0, 0.0, 0.0, true, true, false)
            AttachEntityToEntity(emoteProp, cache.ped, GetPedBoneIndex(cache.ped, doEmote.bone), doEmote.coords.x, doEmote.coords.y, doEmote.coords.z, doEmote.rot.x, doEmote.rot.y, doEmote.rot.z, true, true, false, true, 1, true)
        end
        TaskPlayAnim(cache.ped, doEmote.dict, doEmote.anim, 8.0, 8.0, -1, 49, 0, 0, 0, 0)
        SetModelAsNoLongerNeeded(doEmote.prop)
    else
        ClearPedTasks(cache.ped)
        if emoteProp and DoesEntityExist(emoteProp) then 
            DetachEntity(emoteProp, true, false) 
            DeleteEntity(emoteProp)
            emoteProp = nil
        end
    end
end

function createJobZones()
    for k, v in pairs(Config.Zones) do
        exports['qb-target']:AddCircleZone('carveryZone'..k, v.coords, v.radius,{ 
            name= 'carveryZone'..k, 
            debugPoly = false, 
            useZ=true, 
        }, {
            options = {
                { event = v.event, icon = v.icon, label = v.label, job = v.job, },
            },
            distance = 1.5
        })
        carveryZones[#carveryZones+1] = 'carveryZone'..k
    end
end

function removeJobZones()
    for i = 1, #carveryZones do
        exports['qb-target']:RemoveZone(carveryZones[i])
    end
    table.wipe(carveryZones)
end
    
AddEventHandler('stag_carvery:client:frontTray', function()
    if ox_inv then
        exports.ox_inventory:openInventory('stash', { id = 'CA_Front_Tray_1'})
    else
        TriggerEvent('inventory:client:SetCurrentStash', 'CA_Front_Tray_1')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'CA_Front_Tray_1', {
            maxweight = 75000,
            slots = 10,
        })
    end
end)

AddEventHandler('stag_carvery:client:frontTray2', function()
    if ox_inv then
        exports.ox_inventory:openInventory('stash', { id = 'CA_Fridge'})
    else
        TriggerEvent('inventory:client:SetCurrentStash', 'CA_Fridge')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'CA_Fridge', {
            maxweight = 750000,
            slots = 20,
        })
    end
end)

AddEventHandler('stag_carvery:client:passThrough', function()
    if ox_inv then
        exports.ox_inventory:openInventory('stash', { id = 'CA_Big_Tray'})
    else
        TriggerEvent('inventory:client:SetCurrentStash', 'CA_Big_Tray')
        TriggerServerEvent('inventory:server:OpenInventory', 'stash', 'CA_Big_Tray', {
            maxweight = 150000,
            slots = 10,
        })
    end
end)

AddEventHandler('stag_carvery:client:ingredientStore', function()
    if ox_inv then
        exports.ox_inventory:openInventory('shop', { id = 1, type = 'Ingredients - Carvery'})
    else
        TriggerServerEvent('inventory:server:OpenInventory', 'shop', 'carvery', Config.Items)
    end
end)

RegisterNetEvent('stag_carvery:client:Eat', function(itemName, itemSlot, emote)
    if GetInvokingResource() then return end
    toggleEmotes(true, emote)
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        label = 'Munching..',
        useWhileDead = true,
        canCancel = true,
        disable = { move = false, car = false, mouse = false, combat = true, },
    }) then
        toggleEmotes(false)
        handleStatus('hunger', itemName)
        lib.callback.await('stag_carvery:server:removeConsumable', false, itemName, itemSlot)
    else
        toggleEmotes(false)
    end
end)

RegisterNetEvent('stag_carvery:client:Drink', function(itemName, itemSlot, emote)
    if GetInvokingResource() then return end
    toggleEmotes(true, emote)
    if lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        label = 'Drinking..',
        useWhileDead = true,
        canCancel = true,
        disable = { move = false, car = false, mouse = false, combat = true, },
    }) then
        toggleEmotes(false)
        handleStatus('thirst', itemName)
        lib.callback.await('stag_carvery:server:removeConsumable', false, itemName, itemSlot)
    else
        toggleEmotes(false)
    end
end)

RegisterNetEvent('stag_carvery:client:makeFood', function()
    if GetInvokingResource() then return end
    toggleEmotes(true, 'bbqf')
    if lib.progressCircle({
        duration = Config.CookDuration,
        position = 'bottom',
        label = 'Making food..',
        useWhileDead = true,
        canCancel = false,
        disable = { move = true, car = false, mouse = false, combat = true, },
    }) then
        toggleEmotes(false)
        TriggerEvent('stag_carvery:client:makeFood')
    end
end)

RegisterNetEvent('stag_carvery:client:prepStation', function()
    if GetInvokingResource() then return end
    toggleEmotes(true, 'bbqf')
    if lib.progressCircle({
        duration = Config.CookDuration,
        position = 'bottom',
        label = 'Combining Ingredients..',
        useWhileDead = true,
        canCancel = false,
        disable = { move = true, car = false, mouse = false, combat = true, },
    }) then
        toggleEmotes(false)
        TriggerEvent('stag_carvery:client:prepStation')
    end
end)

RegisterNetEvent('stag_carvery:client:makeDrink', function()
    if GetInvokingResource() then return end
    toggleEmotes(true, 'drinks')
    if lib.progressCircle({
        duration = Config.CookDuration,
        position = 'bottom',
        label = 'Making Drinks..',
        useWhileDead = true,
        canCancel = false,
        disable = { move = true, car = false, mouse = false, combat = true, },
    }) then
        toggleEmotes(false)
        TriggerEvent('stag_carvery:client:drinkStation')
    end
end)

AddEventHandler('stag_carvery:client:makeFood', function()
    local carvery = 'ta_info'
    local taMenu = {
        id = carvery,
        title = 'Prep Station',
        options = {
            {
                title = 'Beef Carvery',
                description = 'Requires: 1x Broccoli | 3x Roast Potatos  | 1x Gravy | 1x Carrot | 2x Peas | 1x Yorkshire Pudding | 1x Beef Joint',
                icon = 'fa-solid fa-burger',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'beefcarvery')
                end,
            },
            {
                title = 'Chicken Carvery',
                description = 'Requires: 1x Broccoli | 3x Roast Potatos  | 1x Gravy | 1x Carrot | 2x Peas | 1x Yorkshire Pudding | 1x Roast Chicken',
                icon = 'fa-solid fa-burger',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'chickencarvery')
                end,
            },
            {
                title = 'Gammon Carvery',
                description = 'Requires: 1x Broccoli | 3x Roast Potatos  | 1x Gravy | 1x Carrot | 2x Peas | 1x Yorkshire Pudding | 1x Roast Gammon',
                icon = 'fa-solid fa-burger',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'gammoncarvery')
                end,
            },
            {
                title = 'Mixed Carvery',
                description = 'Requires: 1x Broccoli | 3x Roast Potatos  | 1x Gravy | 1x Carrot | 2x Peas | 1x Yorkshire Pudding | 1x Roast Gammon | 1x Beef Joint | 1x Roast Chicken',
                icon = 'fa-solid fa-burger',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'mixedcarvery')
                end,
            },
            {
                title = 'Veggie Carvery',
                description = 'Requires: 1x Broccoli | 3x Roast Potatos  | 1x Gravy | 1x Carrot | 2x Peas | 1x Yorkshire Pudding',
                icon = 'fa-solid fa-burger',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'veggiecarvery')
                end,
            },
        }
    }
    lib.registerContext(taMenu)
    lib.showContext(carvery)
end)

AddEventHandler('stag_carvery:client:drinkStation', function()
    local carvery = 'ta_info'
    local taMenu = {
        id = carvery,
        title = 'Drink Station',
        options = {
            {
                title = 'Orange Juice',
                description = 'Requires: 1x Orange | 1x Water Bottle | 1x Sugar Packet',
                icon = 'fa-solid fa-mug-hot',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'orangejuice')
                end,
            },
            {
                title = 'Apple Juice',
                description = 'Requires: 1x Apple | 1x Water Bottle | 1x Sugar Packet',
                icon = 'fa-solid fa-mug-hot',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'applejuice')
                end,
            },
        }
    }
    lib.registerContext(taMenu)
    lib.showContext(carvery)
end)

AddEventHandler('stag_carvery:client:prepStation', function()
    local carvery = 'ca_info'
    local caMenu = {
        id = carvery,
        title = 'Sides Station',
        options = {
            {
                title = 'Roast Potato',
                description = 'Requires: 1x Potato | 1x Oil',
                icon = 'fa-solid fa-fire-burner',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'roastpotato')
                end,
            },
          {
                title = 'Gravy',
                description = 'Requires: 1x Flour | 1x Beef Stock | 1x Hot Water',
                icon = 'fa-solid fa-fire-burner',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'gravy')
                end,
            },
            {
                title = 'Yorkshire Pudding',
                description = 'Requires: 1x Flour | 1x Oil | 1x Yeast | 2x Eggs',
                icon = 'fa-solid fa-fire-burner',
                onSelect = function()
                    lib.callback.await('stag_carvery:server:handleFood', false, 'yorkshires')
                end,
            },
        }
    }
    lib.registerContext(caMenu)
    lib.showContext(carvery)
end)

AddEventHandler('onResourceStop', function(resourceName) 
    if GetCurrentResourceName() == resourceName then
        removeJobZones()
    end 
end)

RegisterNetEvent("stag_carvery:client:useRegister", function()
    local bill = exports['qb-input']:ShowInput({
        header = "Cash Register",
		submitText = "Charge",
        inputs = {
            {
                text = "Server ID(#)",
				name = "citizenid", 
                type = "text", 
                isRequired = true
            },
            {
                text = "   Bill Price (£)",
                name = "billprice", 
                type = "number",
                isRequired = false
            }
			
        }
    })
    if bill ~= nil then
        if bill.citizenid == nil or bill.billprice == nil then 
            return 
        end
        TriggerServerEvent("stag_carvery:server:billPlayer", bill.citizenid, bill.billprice)
    end
end)

RegisterNetEvent('stag_carvery:ToggleDuty', function()
    TriggerServerEvent('QBCore:ToggleDuty')
end)