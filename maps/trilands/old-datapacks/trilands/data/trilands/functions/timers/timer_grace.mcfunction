execute unless score data endround matches 0.. if score data gracetime matches 0.. run execute store result bossbar minecraft:gracetimer value run scoreboard players get data gracetime
execute unless score data endround matches 0.. if score data gracetime matches 0.. run bossbar set minecraft:gracetimer players @a[tag=!admin]

execute unless score data endround matches 0.. if score data gracetime matches 2.. run bossbar set gracetimer name ["",{"text":"Grace period ends in "},{"score":{"name":"data","objective":"gracetime"}},{"text":" seconds."}]
execute unless score data endround matches 0.. if score data gracetime matches 1 run bossbar set gracetimer name ["",{"text":"Grace period ends in "},{"score":{"name":"data","objective":"gracetime"}},{"text":" second."}]

execute unless score data endround matches 0.. if score data gracetime matches 0 run bossbar set minecraft:gracetimer players

execute unless score data endround matches 0.. if score data gracetime matches 0 run playsound minecraft:event.raid.horn master @a[tag=!admin] ~ ~ ~ 100000000000000000000000000000000000000 1
execute unless score data endround matches 0.. if score data gracetime matches 0.. run scoreboard players remove data gracetime 1
execute unless score data endround matches 0.. if score data gracetime matches 0.. if score data gameround < data rounds run team join ingame @a[tag=joined]
execute unless score data endround matches 0.. if score data gracetime matches 0 run scoreboard players operation data roundtimer = roundtime settings

schedule function trilands:timers/timer_grace 1s
