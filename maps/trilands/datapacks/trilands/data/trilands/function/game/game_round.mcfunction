kill @e[type=minecraft:trident]
kill @e[type=minecraft:arrow]

function trilands:reset_map
gamemode adventure @a[tag=joined,tag=!admin]
execute as @a run function trilands:map-teleport
clear @a[tag=joined]

tag @a[tag=joined] remove dead

execute store result score data alive run scoreboard players get data roundjoined

scoreboard players add data gameround 1
scoreboard players set @a[tag=joined] water 10
scoreboard players set @a[tag=joined] onland 7
scoreboard players set @a[tag=joined] reloading 0
scoreboard players set @a[tag=joined] tridentreload 0
scoreboard players set @a destroy 0

title @a[tag=joined] title ["",{"text":"Round ","bold":true,"color":"green"},{"score":{"name":"data","objective":"gameround"},"bold":true,"color":"green"}]