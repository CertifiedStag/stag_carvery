fx_version 'cerulean'
game 'gta5'

author 'Main Body by Randolio Edits by CertifiedStag'
description 'Carvery Job'

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua',
}

client_scripts {
    'bridge/client/**.lua',
    'cl_carvery.lua',
}

server_scripts {
    'bridge/server/**.lua',
    'sv_carvery.lua',
}
escrow_ignore {
    'bridge/client/**.lua',
    'bridge/server/**.lua',
    'readme.md',
    'cl_carvery.lua',
    'sv_carvery.lua',
    'config.lua',
}
lua54 'yes'
