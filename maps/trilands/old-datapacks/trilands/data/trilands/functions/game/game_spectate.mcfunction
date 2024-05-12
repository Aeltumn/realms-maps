execute unless score data endround matches 0.. if score data started matches 1.. as @a[tag=dead,tag=!admin] run gamemode spectator
execute unless score data endround matches 0.. if score data started matches 1.. as @a[tag=dead,tag=!admin] run team join spectate @s
execute unless score data endround matches 0.. if score data started matches 1.. as @a[tag=!joined,tag=!admin] run gamemode spectator
execute unless score data endround matches 0.. if score data started matches 1.. as @a[tag=!joined,tag=!admin] run team join spectate @s
execute unless score data endround matches 0.. if score data started matches 1.. as @a at @s if entity @s[gamemode=spectator,y=0,dy=38.0] run tp @s ~ 39 ~
execute unless score data endround matches 0.. if score data started matches 1.. as @a if entity @s[gamemode=spectator] at @s unless block ~ 1 ~ minecraft:black_glazed_terracotta run function trilands:map-teleport