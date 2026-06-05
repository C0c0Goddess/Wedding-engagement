function SendWeddingLog(title, message)
    local webhook = 'YOUR_WEBHOOK_HERE'

    PerformHttpRequest(webhook, function() end, 'POST', json.encode({
        username = 'Wedding Logs',
        embeds = {
            {
                title = title,
                description = message,
                color = 16738740
            }
        }
    }), {
        ['Content-Type'] = 'application/json'
    })
end
