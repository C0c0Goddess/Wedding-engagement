QBCore = exports['qb-core']:GetCoreObject()

function GetPlayerBySource(src)
    return QBCore.Functions.GetPlayer(src)
end

local function AK47Resource()
    if Config.AK47Inventory and Config.AK47Inventory.Resource then
        return Config.AK47Inventory.Resource
    end

    return 'ak47_inventory'
end

function AddItem(src, item, amount)
    local Player = GetPlayerBySource(src)
    if not Player then return false end

    amount = amount or 1

    if Config.Inventory == 'ox' then
        return exports.ox_inventory:AddItem(src, item, amount)
    end

    if Config.Inventory == 'ak47' then
        local resource = AK47Resource()

        if GetResourceState(resource) == 'started' then
            -- Common AK47 inventory export style.
            -- If your AK47 version differs, edit this line.
            return exports[resource]:AddItem(src, item, amount)
        end

        print(('[LOL Weddings] AK47 inventory resource "%s" is not started. Falling back to QBCore AddItem.'):format(resource))
    end

    Player.Functions.AddItem(item, amount)
    return true
end

function RemoveItem(src, item, amount)
    local Player = GetPlayerBySource(src)
    if not Player then return false end

    amount = amount or 1

    if Config.Inventory == 'ox' then
        return exports.ox_inventory:RemoveItem(src, item, amount)
    end

    if Config.Inventory == 'ak47' then
        local resource = AK47Resource()

        if GetResourceState(resource) == 'started' then
            -- Common AK47 inventory export style.
            -- If your AK47 version differs, edit this line.
            return exports[resource]:RemoveItem(src, item, amount)
        end

        print(('[LOL Weddings] AK47 inventory resource "%s" is not started. Falling back to QBCore RemoveItem.'):format(resource))
    end

    return Player.Functions.RemoveItem(item, amount)
end

function HasItem(src, item)
    local Player = GetPlayerBySource(src)
    if not Player then return false end

    if Config.Inventory == 'ox' then
        local count = exports.ox_inventory:Search(src, 'count', item)
        return count and count > 0
    end

    if Config.Inventory == 'ak47' then
        local resource = AK47Resource()

        if GetResourceState(resource) == 'started' then
            -- Common AK47 inventory export style.
            -- If your AK47 version differs, edit this line.
            local count = exports[resource]:GetItemCount(src, item)
            return count and count > 0
        end

        print(('[LOL Weddings] AK47 inventory resource "%s" is not started. Falling back to QBCore item check.'):format(resource))
    end

    return Player.Functions.GetItemByName(item) ~= nil
end

function GetMoney(src, account)
    local Player = GetPlayerBySource(src)
    if not Player then return 0 end
    return Player.PlayerData.money[account or 'bank'] or 0
end

function RemoveMoney(src, account, amount, reason)
    local Player = GetPlayerBySource(src)
    if not Player then return false end
    return Player.Functions.RemoveMoney(account or 'bank', amount, reason or 'wedding-system')
end
