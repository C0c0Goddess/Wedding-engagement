RegisterCommand(Config.Commands.SharedAccount, function(source)
    local src = source
    local Player = GetPlayerBySource(src)
    if not Player then return end
    local cid = Player.PlayerData.citizenid
    local account = MySQL.single.await([[SELECT * FROM shared_accounts WHERE citizenid1 = ? OR citizenid2 = ? LIMIT 1]], { cid, cid })
    if not account then TriggerClientEvent('QBCore:Notify', src, 'No shared couple account found. Open it in the planner.', 'error') return end
    TriggerClientEvent('QBCore:Notify', src, 'Shared account balance: $' .. account.balance, 'primary')
end, false)

RegisterNetEvent('lol-weddings:server:openSharedAccount', function()
    local src = source
    local Player = GetPlayerBySource(src)
    if not Player then return end
    local cid = Player.PlayerData.citizenid
    local marriage = MySQL.single.await([[SELECT * FROM marriages WHERE (citizenid1 = ? OR citizenid2 = ?) AND status = 'married' LIMIT 1]], { cid, cid })
    if not marriage then TriggerClientEvent('QBCore:Notify', src, 'You must be married to open a shared account.', 'error') return end
    local exists = MySQL.single.await([[SELECT * FROM shared_accounts WHERE marriage_id = ? LIMIT 1]], { marriage.id })
    if exists then TriggerClientEvent('QBCore:Notify', src, 'Shared account already exists.', 'error') return end
    if GetMoney(src, 'bank') < Config.Prices.SharedAccountOpen then TriggerClientEvent('QBCore:Notify', src, 'Not enough money to open shared account.', 'error') return end
    RemoveMoney(src, 'bank', Config.Prices.SharedAccountOpen, 'open-shared-couple-account')
    MySQL.insert.await([[INSERT INTO shared_accounts (marriage_id, citizenid1, citizenid2, balance, created_at) VALUES (?, ?, ?, 0, NOW())]], { marriage.id, marriage.citizenid1, marriage.citizenid2 })
    TriggerClientEvent('QBCore:Notify', src, 'Shared account opened.', 'success')
end)

RegisterNetEvent('lol-weddings:server:depositShared', function(amount)
    local src = source
    amount = tonumber(amount)
    if not amount or amount <= 0 then return end
    local Player = GetPlayerBySource(src)
    if not Player then return end
    if GetMoney(src, 'bank') < amount then TriggerClientEvent('QBCore:Notify', src, 'Not enough money.', 'error') return end
    local cid = Player.PlayerData.citizenid
    local account = MySQL.single.await([[SELECT * FROM shared_accounts WHERE citizenid1 = ? OR citizenid2 = ? LIMIT 1]], { cid, cid })
    if not account then TriggerClientEvent('QBCore:Notify', src, 'No shared account found.', 'error') return end
    RemoveMoney(src, 'bank', amount, 'shared-account-deposit')
    MySQL.update.await([[UPDATE shared_accounts SET balance = balance + ? WHERE id = ?]], { amount, account.id })
    TriggerClientEvent('QBCore:Notify', src, 'Deposited $' .. amount .. '.', 'success')
end)

RegisterNetEvent('lol-weddings:server:withdrawShared', function(amount)
    local src = source
    amount = tonumber(amount)
    if not amount or amount <= 0 then return end
    local Player = GetPlayerBySource(src)
    if not Player then return end
    local cid = Player.PlayerData.citizenid
    local account = MySQL.single.await([[SELECT * FROM shared_accounts WHERE citizenid1 = ? OR citizenid2 = ? LIMIT 1]], { cid, cid })
    if not account or account.balance < amount then TriggerClientEvent('QBCore:Notify', src, 'Insufficient shared funds.', 'error') return end
    MySQL.update.await([[UPDATE shared_accounts SET balance = balance - ? WHERE id = ?]], { amount, account.id })
    Player.Functions.AddMoney('bank', amount, 'shared-account-withdraw')
    TriggerClientEvent('QBCore:Notify', src, 'Withdrew $' .. amount .. '.', 'success')
end)
