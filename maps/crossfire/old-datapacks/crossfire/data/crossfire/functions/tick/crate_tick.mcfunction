# Kill power-ups after 50s
kill @e[tag=sparkling,scores={age=1000..}]

# Increase copter age
scoreboard players add @e[tag=supplycrate] age 1
scoreboard players add @e[tag=crate] age 1

# Make too old crates leave
execute as @e[tag=supplycrate,tag=!wantstodrop,tag=!crateless,scores={age=800..}] run tag @s add crateless
execute as @e[tag=crate,tag=!wantstodrop,tag=!dropped,scores={age=800..}] run tag @s add crateless

# Cloud particle in copter
execute as @e[tag=crate] at @s run particle minecraft:cloud ~ ~2.5 ~ 0.6 0.3 0.6 0 1

# Sparkling particles for dropped items
execute as @e[tag=sparkling] at @s run particle minecraft:firework ~ ~0.2 ~ 0.2 0.3 0.2 0 1

# Lava particle if crate wants to dorp
execute as @e[tag=supplycrate,tag=wantstodrop,tag=!crateless] at @s run particle minecraft:lava ~ ~2.5 ~ 0.3 0.5 0.3 0 1

# Make crates explode on impact
execute as @e[tag=dropped] at @s unless block ~ ~-1 ~ minecraft:air positioned ~0.5 ~ ~0.5 run function crossfire:drop
execute as @e[tag=dropped,scores={age=40..}] at @s positioned ~0.5 ~ ~0.5 run function crossfire:drop

# Make crates drop if they want to and are above terracotta
execute as @e[tag=wantstodrop,tag=crate,tag=!crateless] at @s if block ~ 0 ~ minecraft:purple_glazed_terracotta run tag @s add dropped
execute as @e[tag=wantstodrop,tag=crate,tag=dropped] run scoreboard players set @s age 0
execute as @e[tag=wantstodrop,tag=crate,tag=dropped] run data merge entity @s {NoGravity:0b,Marker:0b}
execute as @e[tag=wantstodrop,tag=crate,tag=dropped] run tag @s remove wantstodrop

# Make copters fly away if they are above terracotta
execute as @e[tag=wantstodrop,tag=supplycrate,tag=!crateless] at @s if block ~ 0 ~ minecraft:purple_glazed_terracotta run tag @s add crateless
execute as @e[tag=wantstodrop,tag=supplycrate,tag=crateless] run tag @s remove wantstodrop