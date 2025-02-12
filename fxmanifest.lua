fx_version 'cerulean'
game 'gta5'

lua54 'yes'

description 'Environment Interaction System for QBCore'
author 'mundstock'
version '1.0.0'

client_scripts {
    'client.lua'
}

shared_scripts {
    'config.lua',
    '@ox_lib/init.lua',
}

dependencies {
    'qb-core'
}

