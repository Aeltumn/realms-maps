execute if score data endround matches 0.. run execute store result bossbar minecraft:lobbyreturn value run scoreboard players get data endround
execute if score data endround matches 0.. run bossbar set minecraft:lobbyreturn players @a[tag=!admin]

execute if score data endround matches 2.. run bossbar set lobbyreturn name ["",{"text":"Returning to lobby in "},{"score":{"name":"data","objective":"endround"}},{"text":" seconds."}]
execute if score data endround matches 1 run bossbar set lobbyreturn name ["",{"text":"Returning to lobby in "},{"score":{"name":"data","objective":"endround"}},{"text":" second."}]

execute if score data endround matches 0 run bossbar set minecraft:round players @a[tag=joined]
execute if score data endround matches 0 run function trilands:reset_game

execute if score data endround matches 0.. run scoreboard players remove data endround 1

schedule function trilands:timers/timer_lobby 1s
