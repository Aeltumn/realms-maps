execute unless score data endround matches 0.. if score data newround matches 0.. run execute store result bossbar minecraft:newround value run scoreboard players get data newround
execute unless score data endround matches 0.. if score data newround matches 0.. run bossbar set minecraft:newround players @a[tag=!admin]

execute unless score data endround matches 0.. if score data newround matches 2.. run bossbar set newround name ["",{"text":"New round starts in "},{"score":{"name":"data","objective":"newround"}},{"text":" seconds."}]
execute unless score data endround matches 0.. if score data newround matches 1 run bossbar set newround name ["",{"text":"New round starts in "},{"score":{"name":"data","objective":"newround"}},{"text":" second."}]

execute unless score data endround matches 0.. if score data newround matches 0 run playsound minecraft:block.beacon.activate master @a[tag=!admin] ~ ~ ~ 100000000000000000000000000000000000000 1
execute unless score data endround matches 0.. if score data newround matches 0 run bossbar set minecraft:newround players
execute unless score data endround matches 0.. if score data newround matches 0 run function trilands:game/game_round
execute unless score data endround matches 0.. if score data newround matches 0 run scoreboard players set data gracetime 10

execute unless score data endround matches 0.. if score data newround matches 0.. run scoreboard players remove data newround 1

schedule function trilands:timers/timer_new_round 1s
