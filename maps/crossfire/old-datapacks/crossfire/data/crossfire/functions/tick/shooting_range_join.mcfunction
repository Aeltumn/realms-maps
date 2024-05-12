# Enter shooting range
execute as @a[tag=!selected,tag=!shootrange] at @s if block ~ 88 ~ minecraft:red_glazed_terracotta run tag @s add reloadcrossbow
execute as @a[tag=!selected,tag=!shootrange] at @s if block ~ 88 ~ minecraft:red_glazed_terracotta run tag @s add shootrange

# Leave shooting range
execute as @a[tag=!selected,tag=shootrange] at @s if block ~ 88 ~ minecraft:light_blue_glazed_terracotta run scoreboard players set @s isreloading 0
execute as @a[tag=!selected,tag=shootrange] at @s if block ~ 88 ~ minecraft:light_blue_glazed_terracotta run scoreboard players set @s timer 0
execute as @a[tag=!selected,tag=shootrange] at @s if block ~ 88 ~ minecraft:light_blue_glazed_terracotta run item replace entity @s container.1 with crossbow{HideFlags:63,Charged:0b,display:{Name:"{\"italic\":false,\"text\":\"Empty Crossbow\",\"color\":\"dark_gray\"}"}} 1
execute as @a[tag=!selected,tag=shootrange] at @s if block ~ 88 ~ minecraft:light_blue_glazed_terracotta run tag @s remove reloadcrossbow
execute as @a[tag=!selected,tag=shootrange] at @s if block ~ 88 ~ minecraft:light_blue_glazed_terracotta run tag @s remove shootrange