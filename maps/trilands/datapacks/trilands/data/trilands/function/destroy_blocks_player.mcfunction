execute run scoreboard players add @s destroy 1
scoreboard players add @s totaldestroyed 1
scoreboard players add @s destroyedblocks 1
scoreboard players add @s rounddestroyed 1
execute as @s if score @s challenge matches 3 run scoreboard players add @s c_progress 1

execute if block ~ ~ ~ minecraft:stripped_acacia_log if score @s challenge matches 0 run scoreboard players add @s[tag=!challengefinish] c_progress 1
execute if block ~ ~ ~ minecraft:stripped_jungle_log if score @s challenge matches 0 run scoreboard players add @s[tag=!challengefinish] c_progress 1
execute if block ~ ~ ~ minecraft:purpur_pillar if score @s challenge matches 0 run scoreboard players add @s[tag=!challengefinish] c_progress 1

execute as @a if score @s destroyedblocks matches 50.. run scoreboard players add @s destroygold 5
execute as @a if score @s destroyedblocks matches 50.. if score @s challenge matches 6 run scoreboard players add @s c_progress 5
execute as @a if score @s destroyedblocks matches 50.. run scoreboard players set @s destroyedblocks 0
execute if score @s destroy matches ..75 run title @s actionbar ["",{"score":{"name":"@s","objective":"destroy"},"color":"gold"},{"text":"/"},{"text":"75","color":"gold"},{"text":" blocks destroyed until "},{"text":"Speed boost 1","color":"gold"},{"text":"!"}]
execute if score @s destroy matches 76..150 run title @s actionbar ["",{"score":{"name":"@s","objective":"destroy"},"color":"gold"},{"text":"/"},{"text":"150","color":"gold"},{"text":" blocks destroyed until "},{"text":"Jump boost 1","color":"gold"},{"text":"!"}]
execute if score @s destroy matches 151..225 run title @s actionbar ["",{"score":{"name":"@s","objective":"destroy"},"color":"gold"},{"text":"/"},{"text":"225","color":"gold"},{"text":" blocks destroyed until "},{"text":"Speed boost 2","color":"gold"},{"text":"!"}]
execute if score @s destroy matches 226..300 run title @s actionbar ["",{"score":{"name":"@s","objective":"destroy"},"color":"gold"},{"text":"/"},{"text":"300","color":"gold"},{"text":" blocks destroyed until "},{"text":"Jump boost 2","color":"gold"},{"text":"!"}]