RegisterCommand(Config.Commands.WeddingAdmin, function(source, args)
    local src = source

    if not QBCore.Functions.HasPermission(src, Config.Admin.Permission) then
        TriggerClientEvent('QBCore:Notify', src, 'No permission.', 'error')
        return
    end

    local action = args[1]

    if action == 'list' then
        local rows = MySQL.query.await('SELECT * FROM marriages ORDER BY id DESC LIMIT 10')
        TriggerClientEvent('QBCore:Notify', src, 'Recent marriage records printed to server console.', 'primary')
        print(json.encode(rows, { indent = true }))
        return
    end

    if action == 'setstatus' then
        local id = tonumber(args[2])
        local status = args[3]

        if not id or not status then
            TriggerClientEvent('QBCore:Notify', src, 'Usage: /weddingadmin setstatus [id] [status]', 'error')
            return
        end

        MySQL.update.await('UPDATE marriages SET status = ? WHERE id = ?', { status, id })
        TriggerClientEvent('QBCore:Notify', src, 'Marriage status updated.', 'success')
        return
    end

    TriggerClientEvent('QBCore:Notify', src, 'Admin: /weddingadmin list or /weddingadmin setstatus [id] [status]', 'primary')
end, false)
