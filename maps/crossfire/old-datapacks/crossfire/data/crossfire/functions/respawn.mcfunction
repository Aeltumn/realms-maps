# Update the title showing you when you died
execute as @a[tag=died] if score @s deadtimer matches ..4 run title @s times 0 24 0
execute as @a[tag=died] if score @s deadtimer matches ..4 run title @s title {"text":" "}
execute as @a[tag=died] if score @s deadtimer matches 1..4 run title @s subtitle ["",{"text":"Respawning in: "},{"score":{"name":"@s","objective":"deadtimer"},"bold":true,"color":"gold"}]
execute as @a[tag=died] if score @s deadtimer matches ..0 run title @s subtitle {"text":""}

# Fireworks when you explode after flying upwards
execute as @a[tag=died,tag=!waterdead] if entity @s[team=red] if score @s deadtimer matches 4 at @s run summon firework_rocket ~ ~ ~ {LifeTime:0,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Colors:[I;11743532]}],Flight:1}}}}
execute as @a[tag=died,tag=!waterdead] if entity @s[team=green] if score @s deadtimer matches 4 at @s run summon firework_rocket ~ ~ ~ {LifeTime:0,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Colors:[I;4312372]}],Flight:1}}}}
execute as @a[tag=died,tag=!waterdead] if entity @s[team=yellow] if score @s deadtimer matches 4 at @s run summon firework_rocket ~ ~ ~ {LifeTime:0,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Colors:[I;14602026]}],Flight:1}}}}
execute as @a[tag=died,tag=!waterdead] if entity @s[team=blue] if score @s deadtimer matches 4 at @s run summon firework_rocket ~ ~ ~ {LifeTime:0,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Colors:[I;6719955]}],Flight:1}}}}
execute as @a[tag=died,tag=!waterdead] if entity @s[team=orange] if score @s deadtimer matches 4 at @s run summon firework_rocket ~ ~ ~ {LifeTime:0,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Colors:[I;15435844]}],Flight:1}}}}
execute as @a[tag=died,tag=!waterdead] if entity @s[team=magenta] if score @s deadtimer matches 4 at @s run summon firework_rocket ~ ~ ~ {LifeTime:0,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:1,Flicker:1,Colors:[I;12801229]}],Flight:1}}}}

# Turn into spectator mode when you reach the top
execute as @a[tag=died,tag=!waterdead] if score @s deadtimer matches 4 at @s run playsound minecraft:item.trident.return master @a ~ ~ ~ 100 0
execute as @a[tag=died,tag=!waterdead] if score @s deadtimer matches 4 at @s run tag @s add spectating
execute as @a[tag=died,tag=!waterdead] if score @s deadtimer matches 4 at @s run effect give @s minecraft:levitation 1000000 255 true
execute as @a[tag=died,tag=!waterdead] if score @s deadtimer matches 4 at @s run effect give @s minecraft:invisibility 1000000 255 true
execute as @a[tag=died,tag=!waterdead] if score @s deadtimer matches 4 at @s run clear @s minecraft:leather_chestplate
execute as @a[tag=died,tag=!waterdead] if score @s deadtimer matches 4 at @s run clear @s minecraft:leather_leggings
execute as @a[tag=died,tag=!waterdead] if score @s deadtimer matches 4 at @s run clear @s minecraft:leather_boots