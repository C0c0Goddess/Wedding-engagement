fx_version 'cerulean'
game 'gta5'
lua54 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua',
    'shared/items.lua'
}

client_scripts {
    'client/proposal.lua',
    'client/name_tags.lua',
    'client/ui_fix.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/proposal.lua',
    'server/name_tags.lua'
}

ui_page 'web/index.html'

files {
    'web/index.html',
    'web/style.css',
    'web/app.js',
    'images/*.png'
}
