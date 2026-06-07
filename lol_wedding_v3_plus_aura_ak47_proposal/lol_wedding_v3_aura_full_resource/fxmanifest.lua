fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Original Aura Wedding Venue Creator + compatibility packaging by OpenAI'
description 'Full Aura Wedding Venue Stream Resource for LOL Wedding System V3'
version '1.1.1'

this_is_a_map 'yes'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/aura_config.lua'
}

client_scripts {
    'client/aura_venue.lua'
}

server_scripts {
    'server/aura_venue.lua'
}

files {
    'stream/*.ymap',
    'stream/*.ytyp',
    'stream/*.ydr',
    'stream/*.ytd',
    'stream/*.ybn',
    'stream/*.ymf'
}

data_file 'DLC_ITYP_REQUEST' 'stream/aura-wedding.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/aura-wedding-extra.ytyp'
