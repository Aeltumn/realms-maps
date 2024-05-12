execute if score starttimer0 starttimer matches 1.. run title @a[scores={map=0}] subtitle {"text":""}
execute if score starttimer0 starttimer matches 1.. run title @a[scores={map=0}] title {"score":{"name":"starttimer0","objective":"starttimer"},"bold":true,"color":"gold"}
execute if score starttimer0 starttimer matches 1.. as @a[scores={map=0}] at @s run playsound minecraft:entity.experience_orb.pickup master @s ~ ~ ~ 0.2 0

execute if score starttimer0 starttimer matches 0 run function crossfire:start_round0

execute if score starttimer0 starttimer matches 0.. run scoreboard players remove starttimer0 starttimer 1
execute if score starttimer0 starttimer matches 0.. run schedule function crossfire:timer0 1s