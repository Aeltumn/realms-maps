
execute if score data roundtimer matches 0.. if score data started matches 1 run bossbar set minecraft:round players @a[tag=!admin]
execute if score data roundtimer matches 0.. if score data started matches 1 run execute store result bossbar minecraft:round value run scoreboard players get data roundtimer
execute if score data roundtimer matches 2.. if score data started matches 1 run bossbar set minecraft:round name ["",{"text":"Round "},{"score":{"name":"data","objective":"gameround"}},{"text":"/"},{"score":{"name":"data","objective":"rounds"}},{"text":" ends in: "},{"score":{"name":"data","objective":"roundtimer"}},{"text":" seconds."}]
execute if score data roundtimer matches 1 if score data started matches 1 run bossbar set minecraft:round name ["",{"text":"Round "},{"score":{"name":"data","objective":"gameround"}},{"text":"/"},{"score":{"name":"data","objective":"rounds"}},{"text":" ends in: "},{"score":{"name":"data","objective":"roundtimer"}},{"text":" second."}]
execute if score data roundtimer matches 0 if score data started matches 1 run bossbar set minecraft:round players
execute if score data roundtimer matches 0 if score data started matches 1 run function trilands:new_round
execute if score data roundtimer matches 0.. if score data started matches 1 run scoreboard players remove data roundtimer 1


execute if score data joined matches ..1 run bossbar set minecraft:gamestart players
execute if score data joined matches ..1 unless score data started matches 1 run bossbar set minecraft:waiting players @a[tag=joined]
execute if score data joined matches ..1 if score data started matches 0 run scoreboard players set data starttimer 30
execute if score data joined matches 2.. run bossbar set minecraft:waiting players

execute unless score data joined matches ..1 if score data started matches 0 run bossbar set minecraft:gamestart players @a
execute if score data starttimer matches 6.. if score data joined matches 2.. as @a at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 100000000000000000000000000000000000000 0
execute if score data starttimer matches 1..5 if score data joined matches 2.. as @a at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 100000000000000000000000000000000000000 1
execute if score data starttimer matches 0.. if score data joined matches 2.. run execute store result bossbar minecraft:gamestart value run scoreboard players get data starttimer
execute if score data starttimer matches 0.. if score data joined matches 2.. run bossbar set minecraft:gamestart name ["",{"text":"The next round is starting in: "},{"score":{"name":"data","objective":"starttimer"}},{"text":" seconds."}]
execute if score data starttimer matches 0 run function trilands:game/game_start
execute if score data starttimer matches 0.. if score data joined matches 2.. run scoreboard players remove data starttimer 1

execute as @a if score @s hittime matches 0.. run scoreboard players remove @s hittime 1
execute as @a if score @s hittime matches 0 run function trilands:clear_hit

schedule function trilands:timers/timers 1s
