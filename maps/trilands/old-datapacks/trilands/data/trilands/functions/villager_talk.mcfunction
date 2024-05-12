execute as @a[tag=!clickedshop] if score @s villager matches 1.. at @s positioned ^ ^ ^1 if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=!shop] run function trilands:cosmetics/cosmetic_equip
execute as @a[tag=!clickedshop] if score @s villager matches 1.. at @s positioned ^ ^ ^2 if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=!shop] run function trilands:cosmetics/cosmetic_equip
execute as @a[tag=!clickedshop] if score @s villager matches 1.. at @s positioned ^ ^ ^3 if entity @e[type=minecraft:villager,distance=..0.5,limit=1,tag=!shop] run function trilands:cosmetics/cosmetic_equip

execute as @a[tag=!clickedshop] if score hatshop shop matches 0 if score @s villager matches 1.. at @s positioned ^ ^ ^1 if entity @e[type=minecraft:villager,distance=..1,limit=1] run execute as @e[type=minecraft:villager,distance=..1,tag=hatshop,limit=1] run scoreboard players set hatshop shop 1
execute as @a[tag=!clickedshop] if score hatshop shop matches 0 if score @s villager matches 1.. at @s positioned ^ ^ ^2 if entity @e[type=minecraft:villager,distance=..1,limit=1] run execute as @e[type=minecraft:villager,distance=..1,tag=hatshop,limit=1] run scoreboard players set hatshop shop 1
execute as @a[tag=!clickedshop] if score hatshop shop matches 0 if score @s villager matches 1.. at @s positioned ^ ^ ^3 if entity @e[type=minecraft:villager,distance=..1,limit=1] run execute as @e[type=minecraft:villager,distance=..1,tag=hatshop,limit=1] run scoreboard players set hatshop shop 1

execute as @a[tag=!clickedshop] if score particleshop shop matches 0 if score @s villager matches 1.. at @s positioned ^ ^ ^1 if entity @e[type=minecraft:villager,distance=..1,limit=1] run execute as @e[type=minecraft:villager,distance=..1,tag=particleshop,limit=1] run scoreboard players set particleshop shop 1
execute as @a[tag=!clickedshop] if score particleshop shop matches 0 if score @s villager matches 1.. at @s positioned ^ ^ ^2 if entity @e[type=minecraft:villager,distance=..1,limit=1] run execute as @e[type=minecraft:villager,distance=..1,tag=particleshop,limit=1] run scoreboard players set particleshop shop 1
execute as @a[tag=!clickedshop] if score particleshop shop matches 0 if score @s villager matches 1.. at @s positioned ^ ^ ^3 if entity @e[type=minecraft:villager,distance=..1,limit=1] run execute as @e[type=minecraft:villager,distance=..1,tag=particleshop,limit=1] run scoreboard players set particleshop shop 1

execute as @a[tag=!clickedshop] if score armorshop shop matches 0 if score @s villager matches 1.. at @s positioned ^ ^ ^1 if entity @e[type=minecraft:villager,distance=..1,limit=1] run execute as @e[type=minecraft:villager,distance=..1,tag=armorshop,limit=1] run scoreboard players set armorshop shop 1
execute as @a[tag=!clickedshop] if score armorshop shop matches 0 if score @s villager matches 1.. at @s positioned ^ ^ ^2 if entity @e[type=minecraft:villager,distance=..1,limit=1] run execute as @e[type=minecraft:villager,distance=..1,tag=armorshop,limit=1] run scoreboard players set armorshop shop 1
execute as @a[tag=!clickedshop] if score armorshop shop matches 0 if score @s villager matches 1.. at @s positioned ^ ^ ^3 if entity @e[type=minecraft:villager,distance=..1,limit=1] run execute as @e[type=minecraft:villager,distance=..1,tag=armorshop,limit=1] run scoreboard players set armorshop shop 1

execute as @a if score @s villager matches 1.. at @s positioned ^ ^ ^1.5 if entity @e[type=minecraft:villager,distance=..2,limit=1,tag=challenges] run function trilands:challenge/challenge_progress
execute as @a if score @s tutorial matches -1 if score @s villager matches 1.. at @s positioned ^ ^ ^1.5 if entity @e[type=minecraft:villager,distance=..2,limit=1,tag=tutorial] run scoreboard players set @s tutorial 0

execute as @a if score @s tutorial matches -1 if score @s villager matches 1.. at @s positioned ^ ^ ^1.5 if entity @e[type=minecraft:villager,distance=..2,limit=1,tag=credits] run tellraw @s ["",{"text":"\n"},{"text":"Trilands","bold":true,"color":"dark_aqua"},{"text":"\nBy Acented, Aeltumn & Grafisch\n\n"},{"text":"Twitter:","color":"dark_aqua"},{"text":" "},{"text":"Click here","color":"white","clickEvent":{"action":"open_url","value":"https://twitter.com/TeamGrafisch"}},{"text":"\n"},{"text":"Discord:","color":"dark_aqua"},{"text":" "},{"text":"Click here","color":"white","clickEvent":{"action":"open_url","value":"https://discord.com/invite/4RV2Nwa"}},{"text":"\n "}]

execute as @a if score @s villager matches 1.. run scoreboard players set data1 result 0
execute as @a if score @s villager matches 1.. run scoreboard players set @s villager 0