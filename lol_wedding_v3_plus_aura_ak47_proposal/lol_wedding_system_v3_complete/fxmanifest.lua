fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'OpenAI'
description 'Loyalty Ova Love Wedding System V3 Complete'
version '3.0.1'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/items.lua'
}

client_scripts {
    'client/ui.lua',
    'client/rings.lua',
    'client/proposal.lua',
    'client/name_tags.lua',
    'client/ceremony.lua',
    'client/venues.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/utils.lua',
    'server/rings.lua',
    'server/proposal.lua',
    'server/marriage.lua',
    'server/planner.lua',
    'server/name_tags.lua',
    'server/accounts.lua',
    'server/admin.lua',
    'server/discord.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css',
    'web/app.js',
    'images/*.png'
}
