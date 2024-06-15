execute as @e[type=trident] run data merge entity @s {pickup:0}
execute as @a if score @s tridentuse matches 1.. at @s run playsound minecraft:entity.player.attack.strong master @a ~ ~ ~ 100000000000000 0

execute as @a if score @s tridentuse matches 1.. run function trilands:trident_player

execute as @a if score @s tridentuse matches 1.. run scoreboard players add @s tridentsused 1
execute as @a if score @s tridentuse matches 1.. if score @s challenge matches 2 run scoreboard players add @s[tag=!challengefinish] c_progress 1

execute as @a[tag=player0] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player0
execute as @a[tag=player0,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player0,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player0,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player1] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player1
execute as @a[tag=player1,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player1,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player1,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player2] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player2
execute as @a[tag=player2,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player2,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player2,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player3] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player3
execute as @a[tag=player3,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player3,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player3,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player4] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player4
execute as @a[tag=player4,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player4,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player4,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player5] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player5
execute as @a[tag=player5,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player5,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player5,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player6] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player6
execute as @a[tag=player6,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player6,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player6,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player7] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player7
execute as @a[tag=player7,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player7,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player7,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player8] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player8
execute as @a[tag=player8,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player8,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player8,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player9] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player9
execute as @a[tag=player9,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player9,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player9,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

execute as @a[tag=player10] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add player10
execute as @a[tag=player10,tag=particle1selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle1selected
execute as @a[tag=player10,tag=particle2selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle2selected
execute as @a[tag=player10,tag=particle3selected] if score @s tridentuse matches 1.. at @s run tag @e[tag=!used,type=trident,distance=..4,limit=1] add particle3selected

tag @e[type=trident,distance=..4,limit=1] add used

execute as @a if score @s tridentuse matches 1.. run scoreboard players set @s reloading 1
execute as @a if score @s tridentuse matches 1.. run scoreboard players set @s tridentuse 0