local Config = lib.require('config')
local carveryFood = {
    ['beefcarvery'] = {
        event = 'stag_carvery:client:makeFood',
        remove = { {ing = 'broccoli', amount = 1}, {ing = 'roastpotato', amount = 3}, {ing = 'gravy', amount = 1}, {ing = 'carrot', amount = 1}, {ing = 'peas', amount = 2}, {ing = 'yorkshires', amount = 1}, {ing = 'beefjoint', amount = 1}, }
    },
    ['chickencarvery'] = {
        event = 'stag_carvery:client:makeFood',
        remove = { {ing = 'broccoli', amount = 1}, {ing = 'roastpotato', amount = 3}, {ing = 'gravy', amount = 1}, {ing = 'carrot', amount = 1}, {ing = 'peas', amount = 2}, {ing = 'yorkshires', amount = 1}, {ing = 'roastchicken', amount = 1},}
    },
    ['gammoncarvery'] = {
        event = 'stag_carvery:client:makeFood',
        remove = { {ing = 'broccoli', amount = 1}, {ing = 'roastpotato', amount = 3}, {ing = 'gravy', amount = 1}, {ing = 'carrot', amount = 1}, {ing = 'peas', amount = 2}, {ing = 'yorkshires', amount = 1}, {ing = 'roastgammon', amount = 1},}
    },
    ['mixedcarvery'] = {
        event = 'stag_carvery:client:makeFood',
        remove = { {ing = 'broccoli', amount = 1}, {ing = 'roastpotato', amount = 3}, {ing = 'gravy', amount = 1}, {ing = 'carrot', amount = 1}, {ing = 'peas', amount = 2}, {ing = 'yorkshires', amount = 1}, {ing = 'roastgammon', amount = 1}, {ing = 'roastchicken', amount = 1}, {ing = 'beefjoint', amount = 1},}
    },
    ['veggiecarvery'] = {
        event = 'stag_carvery:client:makeFood',
        remove = { {ing = 'broccoli', amount = 1}, {ing = 'roastpotato', amount = 3}, {ing = 'gravy', amount = 1}, {ing = 'carrot', amount = 1}, {ing = 'peas', amount = 2}, {ing = 'yorkshires', amount = 1},}
    },
    ['roastpotato'] = {
        event = 'stag_carvery:client:prepStation',
        remove = { {ing = 'potato', amount = 1}, {ing = 'oil', amount = 1}, }
    },
    ['gravy'] = {
        event = 'stag_carvery:client:prepStation',
        remove = { {ing = 'flour', amount = 1}, {ing = 'beefstock', amount = 1}, {ing = 'hotwater', amount = 1},}
    },
    ['yorkshires'] = {
        event = 'stag_carvery:client:prepStation',
        remove = { {ing = 'flour', amount = 1}, {ing = 'oil', amount = 1}, {ing = 'yeast', amount = 1}, {ing = 'egg', amount = 2},}
    },
    ['orangejuice'] = {
        event = 'stag_carvery:client:makeDrink',
        remove = { {ing = 'orange', amount = 1},{ing = 'water_bottle', amount = 1}, {ing = 'sugarpacket', amount = 1}, }
    },
    ['applejuice'] = {
          event = 'stag_carvery:client:makeDrink',
          remove = { {ing = 'apple', amount = 1},{ing = 'water_bottle', amount = 1}, {ing = 'sugarpacket', amount = 1}, }
      },
}

lib.callback.register('stag_carvery:server:handleFood', function(source, itemName)
    local src = source
    local Player = GetPlayer(src)

    local food = carveryFood[itemName]
    if not food or not iscarvery(Player) then return end

    local canMake = true
    for _, ingredient in pairs(food.remove) do
        if not itemCount(Player, ingredient.ing, ingredient.amount) then
            canMake = false
            break
        end
    end

    if not canMake then
        return DoNotification(src, 'You don\'t have all the required ingredients.', 'error')
    end

    for _, ingredient in pairs(food.remove) do
        RemoveItem(Player, ingredient.ing, ingredient.amount)
    end
    TriggerClientEvent(food.event, src)
    SetTimeout(Config.CookDuration, function() AddItem(Player, itemName, 1) end)
end)

lib.callback.register('stag_carvery:server:removeConsumable', function(source, item, slot)
    local src = source
    local Player = GetPlayer(src)
    RemoveItemFromSlot(Player, item, 1, slot)
end)

RegisterNetEvent("stag_carvery:server:billPlayer", function(playerId, amount)
    local src = source
    local Player = GetPlayer(src)
    local biller = Player
    local billed = GetPlayer(tonumber(playerId))
    local amount = tonumber(amount)
    if biller.PlayerData.job.name == 'carveryjob' then
        if billed ~= nil then
            if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                if amount and amount > 0 then
                billed.Functions.RemoveMoney('bank', amount)
                DoNotification(src, 'You charged a customer.', 'success')
                DoNotification(billed.PlayerData.source, 'You have been charged £'..amount..' for your order at Taco Shop.')
                exports['qb-management']:AddMoney('carveryjob', value)
                else
                    DoNotification(src, 'Must be a valid amount above 0.', 'error')
                end
            else
                DoNotification(src, 'You cannot bill yourself.', 'error')
            end
        else
            DoNotification(src, 'Player not online', 'error')
        end
    end
end)