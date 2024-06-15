execute if score @s challenge matches 0 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Destroy 30 crates."},{"text":". ("},{"text":"100 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 1 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Kill 5 players."},{"text":". ("},{"text":"150 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 2 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Throw 50 tridents."},{"text":". ("},{"text":"75 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 3 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Destroy 500 blocks."},{"text":". ("},{"text":"125 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 4 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Use the grappling hook 10 times."},{"text":". ("},{"text":"50 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 5 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Win a round."},{"text":". ("},{"text":"175 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 6 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Earn 500 gold."},{"text":". ("},{"text":"125 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 7 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Play rounds."},{"text":". ("},{"text":"75 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 8 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Win a game."},{"text":". ("},{"text":"300 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 9 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Outlive players."},{"text":". ("},{"text":"100 Gold","color":"gray"},{"text":")\n "}]
execute if score @s challenge matches 10 run tellraw @s ["",{"text":"\n"},{"text":"CHALLENGE COMPLETED","bold":true,"color":"green"},{"text":"\n"},{"text":"Play games."},{"text":". ("},{"text":"150 Gold","color":"gray"},{"text":")\n "}]


execute if score @s challenge matches 0 run scoreboard players add @s totalgold 100
execute if score @s challenge matches 1 run scoreboard players add @s totalgold 150
execute if score @s challenge matches 2 run scoreboard players add @s totalgold 75
execute if score @s challenge matches 3 run scoreboard players add @s totalgold 125
execute if score @s challenge matches 4 run scoreboard players add @s totalgold 50
execute if score @s challenge matches 5 run scoreboard players add @s totalgold 175
execute if score @s challenge matches 6 run scoreboard players add @s totalgold 125
execute if score @s challenge matches 7 run scoreboard players add @s totalgold 75
execute if score @s challenge matches 8 run scoreboard players add @s totalgold 300
execute if score @s challenge matches 9 run scoreboard players add @s totalgold 100
execute if score @s challenge matches 10 run scoreboard players add @s totalgold 150


scoreboard players set @s c_progress 0
tag @s add challengefinish

scoreboard players add @s challenge 1
execute if score @s challenge matches 11.. run scoreboard players set @s challenge 0