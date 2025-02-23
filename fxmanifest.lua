fx_version "cerulean"
game "gta5"

author "Pineapple Studios"
description "Join our discord - discord.gg/547nKvQhZ7"
lua54 'yes'

shared_scripts {
    "@ox_lib/init.lua",
    "@es_extended/imports.lua",
    "shared/*.lua",
    "config.lua"
}

client_scripts {
    "bridge/client.lua",
    "client/menu.lua",
    "client/interactions.lua",
    "client/notifications.lua",
    "client/main.lua"
}

server_scripts {
    "@oxmysql/lib/MySQL.lua",
    "bridge/server.lua",
    "server/*.lua"
}