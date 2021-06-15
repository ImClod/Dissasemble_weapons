fx_version "bodacious"
game "gta5"


client_script {"project/client/MxM_C.lua","client/main.lua"}
server_script {
    "config.lua",
    'project/server/MxM_S.lua',
    "server/main.lua"
}