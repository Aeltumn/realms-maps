# Give proper player shooter tags (we have at most 3 arrows we shoot)
execute at @s run data modify entity @e[type=arrow,distance=..4,tag=!givecrossbow,limit=1] Tags set from entity @s Tags
execute at @s run data modify entity @e[type=arrow,distance=..4,tag=!givecrossbow,limit=1] Tags set from entity @s Tags
execute at @s run data modify entity @e[type=arrow,distance=..4,tag=!givecrossbow,limit=1] Tags set from entity @s Tags

# Give the arrows tags from the player that shot them
execute if entity @s[team=red] at @s run tag @e[type=arrow,distance=..4,tag=!red,tag=!green,tag=!yellow,tag=!blue,tag=!orange,tag=!magenta,tag=!lobby] add red
execute if entity @s[team=yellow] at @s run tag @e[type=arrow,distance=..4,tag=!red,tag=!green,tag=!yellow,tag=!blue,tag=!orange,tag=!magenta,tag=!lobby] add yellow
execute if entity @s[team=green] at @s run tag @e[type=arrow,distance=..4,tag=!red,tag=!green,tag=!yellow,tag=!blue,tag=!orange,tag=!magenta,tag=!lobby] add green
execute if entity @s[team=blue] at @s run tag @e[type=arrow,distance=..4,tag=!red,tag=!green,tag=!yellow,tag=!blue,tag=!orange,tag=!magenta,tag=!lobby] add blue
execute if entity @s[team=orange] at @s run tag @e[type=arrow,distance=..4,tag=!red,tag=!green,tag=!yellow,tag=!blue,tag=!orange,tag=!magenta,tag=!lobby] add orange
execute if entity @s[team=magenta] at @s run tag @e[type=arrow,distance=..4,tag=!red,tag=!green,tag=!yellow,tag=!blue,tag=!orange,tag=!magenta,tag=!lobby] add magenta
execute if entity @s[team=lobby] at @s run tag @e[type=arrow,distance=..4,tag=!red,tag=!green,tag=!yellow,tag=!blue,tag=!orange,tag=!magenta,tag=!lobby] add lobby

# Play the bow shooting sounds
execute at @s run playsound minecraft:item.trident.hit_ground ambient @a ~ ~ ~ 10 0
execute at @s run playsound minecraft:entity.firework_rocket.launch ambient @a ~ ~ ~ 10 1.0