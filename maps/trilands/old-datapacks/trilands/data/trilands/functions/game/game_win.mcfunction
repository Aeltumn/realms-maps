tag @s add won
execute as @s if score @s challenge matches 8 run scoreboard players add @s[tag=!challengefinish] c_progress 1
scoreboard players add @s Wins 1
tellraw @a ["",{"selector":"@s","color":"gold"},{"text":" won the game!"}]
tp @s -206.5 45 279.5 -45 0