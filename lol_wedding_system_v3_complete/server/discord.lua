function SendWeddingLog(title, message)
    if not Config.Discord.Enabled then return end
    if not Config.Discord.Webhook or Config.Discord.Webhook == 'YOUR_WEBHOOK_HERE' then return end

    PerformHttpRequest(Config.Discord.Webhook, function() end, 'POST', json.encode({
        username = 'Wedding Logs',
        embeds = {
            {
                title = title,
                description = message,
                color = 16764755
            }
        }
    }), {
        ['Content-Type'] = 'application/json'
    })
end
