# If you are standing on a team and aren't allowed to join
execute as @a at @s if block ~ ~-1 ~ minecraft:red_concrete if entity @s[team=!red,tag=!admin] unless score @s introCompleted matches 1 run tag @s add temp
execute as @a at @s if block ~ ~-1 ~ minecraft:yellow_concrete if entity @s[team=!yellow,tag=!admin] unless score @s introCompleted matches 1 run tag @s add temp
execute as @a at @s if block ~ ~-1 ~ minecraft:lime_concrete if entity @s[team=!green,tag=!admin] unless score @s introCompleted matches 1 run tag @s add temp
execute as @a at @s if block ~ ~-1 ~ minecraft:light_blue_concrete if entity @s[team=!blue,tag=!admin] unless score @s introCompleted matches 1 run tag @s add temp

execute as @a at @s if block ~ ~-1 ~ minecraft:orange_concrete if entity @s[team=!orange,tag=!admin] unless score @s introCompleted matches 1 run tag @s add temp
execute as @a at @s if block ~ ~-1 ~ minecraft:magenta_concrete if entity @s[team=!magenta,tag=!admin] unless score @s introCompleted matches 1 run tag @s add temp

# Send info to all with temp
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":""}]
tellraw @a[tag=temp] [{"text":"You can't join a team until you "},{"text":"complete the tutorial","color":"aqua","hoverEvent":{"action":"show_text","value":"Click here to start the tutorial!"},"clickEvent":{"action":"run_command","value":"/trigger intro set 0"}},{"text":"."}]
tellraw @a[tag=temp] [{"text":"Or "},{"text":"click here","color":"red","hoverEvent":{"action":"show_text","value":"Click here to skip the tutorial."},"clickEvent":{"action":"run_command","value":"/trigger introComplTr set 1"}},{"text":" to skip the tutorial."}]

# Cleanup
tag @a remove temp

# Rerun this function
schedule function crossfire:team_deny_info 10t replace