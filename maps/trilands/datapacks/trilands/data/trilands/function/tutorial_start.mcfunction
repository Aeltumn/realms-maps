execute as @a if score @s tutorial matches 0.. run scoreboard players add @s tutorial 1
execute as @a if score @s tutorial matches 0.. run gamemode spectator @s
execute as @a if score @s tutorial matches 0.. run tag @s remove joined
execute as @a if score @s tutorial matches 0.. run item replace entity @s armor.head with minecraft:carved_pumpkin

execute as @a if score @s tutorial matches 1..200 run tp @s -145.5 60 166.5 90 30
execute as @a if score @s tutorial matches 1 run tellraw @s ["",{"text":"\nIn "},{"text":"Trilands","color":"dark_aqua"},{"text":" you need to eliminate your opponents by dropping them into the ocean. The last player that still stands on dry land wins the round. After a few rounds one player is dubbed the victor based on how many blocks they "},{"text":"destroyed","color":"dark_aqua"},{"text":", how long they "},{"text":"survived","color":"dark_aqua"},{"text":" and how many "},{"text":"kills","color":"dark_aqua"},{"text":" they got.\n"}]

execute as @a if score @s tutorial matches 200..400 run tp @s -200.5 58 249.5 130 30
execute as @a if score @s tutorial matches 200 run tellraw @s ["",{"text":"\nTo destroy the blocks beneath the feet of your enemies you are given a "},{"text":"trident","color":"dark_aqua"},{"text":". Whenever you throw this "},{"text":"trident","color":"dark_aqua"},{"text":" the ground is destroyed where it lands. There is a small recharge time on the trident before you can throw it again.\n"}]


execute as @a if score @s tutorial matches 400..600 run tp @s -189 57 198 -140 5
execute as @a if score @s tutorial matches 400 run tellraw @s ["",{"text":"\nThere are upgrades to be earned each round by destroying blocks. When you destroy "},{"text":"75","color":"dark_aqua"},{"text":" blocks you get Speed I, destroying another "},{"text":"75","color":"dark_aqua"},{"text":" blocks gives you Jump Boost I. You can eventually get "},{"text":"Speed II","color":"dark_aqua"},{"text":" and "},{"text":"Jump Boost II","color":"dark_aqua"},{"text":" by destroying "},{"text":"400","color":"dark_aqua"},{"text":" blocks in total.\n"}]


execute as @a if score @s tutorial matches 600..800 run tp @s -165.5 59 154.5 140 30
execute as @a if score @s tutorial matches 600 run tellraw @s ["",{"text":"\nAfter a game you are awarded gold depending on how good you performed during each round. The person who earned the largest amount of gold wins the game. You can spend this gold to buy "},{"text":"hats","color":"dark_aqua"},{"text":", "},{"text":"particles","color":"dark_aqua"},{"text":" or "},{"text":"armor","color":"dark_aqua"},{"text":" from the villagers near the lobby spawn.\n"}]


execute as @a if score @s tutorial matches 800.. run item replace entity @s armor.head with minecraft:air
execute as @a if score @s tutorial matches 800.. run function trilands:reset_player
execute as @a if score @s tutorial matches 800.. run scoreboard players set @s tutorial -1