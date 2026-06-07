RegisterCommand(Config.Commands.Marry, function(source, args)
    local src = source
    local targetId = tonumber(args[1])
    if not targetId then TriggerClientEvent('QBCore:Notify', src, 'Usage: /marry [player id]', 'error') return end
    local Player = GetPlayerBySource(src)
    local Target = GetPlayerBySource(targetId)
    if not Player or not Target then return end

    local changed = MySQL.update.await([[UPDATE marriages SET status = 'married', shared_lastname = ?, married_at = NOW() WHERE ((citizenid1 = ? AND citizenid2 = ?) OR (citizenid1 = ? AND citizenid2 = ?)) AND status = 'engaged' LIMIT 1]], {
        Player.PlayerData.charinfo.lastname, Player.PlayerData.citizenid, Target.PlayerData.citizenid, Target.PlayerData.citizenid, Player.PlayerData.citizenid
    })

    if changed and changed > 0 then
        TriggerClientEvent('QBCore:Notify', src, 'You are now married!', 'success')
        TriggerClientEvent('QBCore:Notify', targetId, 'You are now married!', 'success')
        SendWeddingLog('Marriage Completed', Player.PlayerData.charinfo.firstname .. ' married ' .. Target.PlayerData.charinfo.firstname)
    else
        TriggerClientEvent('QBCore:Notify', src, 'No active engagement found.', 'error')
    end
end, false)

RegisterCommand(Config.Commands.Divorce, function(source)
    local src = source
    local Player = GetPlayerBySource(src)
    if not Player then return end
    if GetMoney(src, 'bank') < Config.Prices.Divorce then TriggerClientEvent('QBCore:Notify', src, 'Not enough money for divorce processing.', 'error') return end
    local cid = Player.PlayerData.citizenid
    local changed = MySQL.update.await([[UPDATE marriages SET status = 'divorced' WHERE (citizenid1 = ? OR citizenid2 = ?) AND status = 'married' LIMIT 1]], { cid, cid })
    if changed and changed > 0 then
        RemoveMoney(src, 'bank', Config.Prices.Divorce, 'wedding-divorce')
        TriggerClientEvent('QBCore:Notify', src, 'Divorce processed.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'No active marriage found.', 'error')
    end
end, false)

RegisterCommand(Config.Commands.MarriageStatus, function(source)
    local src = source
    local Player = GetPlayerBySource(src)
    if not Player then return end
    local cid = Player.PlayerData.citizenid
    local row = MySQL.single.await([[SELECT * FROM marriages WHERE citizenid1 = ? OR citizenid2 = ? ORDER BY id DESC LIMIT 1]], { cid, cid })
    if not row then TriggerClientEvent('QBCore:Notify', src, 'No relationship record found.', 'primary') return end
    TriggerClientEvent('QBCore:Notify', src, 'Marriage status: ' .. row.status, 'primary')
end, false)

RegisterCommand(Config.Commands.CreateLicense, function(source, args)
    local src = source
    local targetId = tonumber(args[1])
    local Player = GetPlayerBySource(src)
    local Target = GetPlayerBySource(targetId)
    if not targetId or not Target then TriggerClientEvent('QBCore:Notify', src, 'Usage: /marriagelicense [player id]', 'error') return end
    if GetMoney(src, 'bank') < Config.Prices.MarriageLicense then TriggerClientEvent('QBCore:Notify', src, 'Not enough money for marriage license.', 'error') return end
    RemoveMoney(src, 'bank', Config.Prices.MarriageLicense, 'marriage-license')
    MySQL.insert.await([[INSERT INTO marriage_licenses (owner, partner, issued_at) VALUES (?, ?, NOW())]], { Player.PlayerData.citizenid, Target.PlayerData.citizenid })
    AddItem(src, 'marriage_license', 1)
    TriggerClientEvent('QBCore:Notify', src, 'Marriage license created.', 'success')
end, false)

RegisterCommand(Config.Commands.NameChange, function(source, args)
    local src = source
    local Player = GetPlayerBySource(src)
    if not Player then return end
    local newLast = args[1]
    if not newLast then TriggerClientEvent('QBCore:Notify', src, 'Usage: /changemarriedname [lastname]', 'error') return end
    if GetMoney(src, 'bank') < Config.Prices.NameChange then TriggerClientEvent('QBCore:Notify', src, 'Not enough money for name change.', 'error') return end
    local cid = Player.PlayerData.citizenid
    local changed = MySQL.update.await([[UPDATE marriages SET shared_lastname = ? WHERE (citizenid1 = ? OR citizenid2 = ?) AND status = 'married' LIMIT 1]], { newLast, cid, cid })
    if changed and changed > 0 then
        RemoveMoney(src, 'bank', Config.Prices.NameChange, 'married-name-change')
        TriggerClientEvent('QBCore:Notify', src, 'Married last name updated to ' .. newLast .. '.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'No active marriage found.', 'error')
    end
end, false)

RegisterNetEvent('lol-weddings:server:startCeremony', function(targetId)
    local src = source
    local Player = GetPlayerBySource(src)
    local Target = GetPlayerBySource(targetId)
    if not Player or not Target then return end
    TriggerClientEvent('lol-weddings:client:playCeremony', src, Target.PlayerData.charinfo.firstname)
    TriggerClientEvent('lol-weddings:client:playCeremony', targetId, Player.PlayerData.charinfo.firstname)
end)
