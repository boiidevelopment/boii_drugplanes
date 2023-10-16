----------------------------------
--<!>-- BOII | DEVELOPMENT --<!>--
----------------------------------

fx_version 'cerulean'
game {'gta5'}

author 'boiidevelopment'

description 'BOII | Development - Drugs: Drug Planes'

version '0.0.3'

lua54 'yes'

shared_scripts {
    'shared/language/en.lua',
    'shared/config.lua',
    'shared/framework.lua',
}

server_scripts {
    'server/config_sv.lua',
    'server/framework.lua',
    'server/main.lua',
}

client_scripts {
    'client/framework.lua',
    'client/main.lua',
}

escrow_ignore {
    'shared/**/*',
    'server/*',
    'client/*',
}