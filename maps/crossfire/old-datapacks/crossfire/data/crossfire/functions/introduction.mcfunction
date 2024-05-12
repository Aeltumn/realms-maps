# Start intro
execute as @a if score @s intro matches 0 run scoreboard players set @s map -1

# Increase intro value
scoreboard players add @a[scores={intro=0..}] intro 1

# Send messages depending on the intro state
# PHASE 1 - Lobby
execute as @a if score @s intro matches 1 run tellraw @s [{"text":""}]
execute as @a if score @s intro matches 1 run tellraw @s ["",{"text":"Welcome to "},{"text":"Crossfire","color":"gold"},{"text":"! A team vs team minigame where you try to hit your friends with fireworks shot from a crossbow. You can join a team of your choosing by walking on one of the "},{"text":"colored areas", "color":"yellow"},{"text":"."}]
execute as @a if score @s intro matches 1 run tellraw @s [{"text":""}]

execute as @a if score @s intro matches 7 run tellraw @s [{"text":""}]
execute as @a if score @s intro matches 7 run tellraw @s ["",{"text":"Crossfire","color":"gold"},{"text":" can be played on two maps: "},{"text":"Party","color":"aqua","hoverEvent":{"action":"show_text","value":["",{"text":"A map where four teams play together at once: "},{"text":"Red","color":"red"},{"text":", "},{"text":"Yellow","color":"yellow"},{"text":", "},{"text":"Green","color":"green"},{"text":" and "},{"text":"Blue","color":"aqua"},{"text":". The map is more focussed towards finding out the position of your enemies than direct confrontation."}]}},{"text":" and "},{"text":"Duel","color":"green","hoverEvent":{"action":"show_text","value":["",{"text":"The duel map is played on by only two teams, "},{"text":"Orange","color":"gold"},{"text":" and "},{"text":"Magenta","color":"light_purple"},{"text":". The map is focussed on trying to evade incoming attacks whilst trying to attack yourself. The map is very open so spotting the enemy won't be hard."}]}},{"text":". The maps have different amounts of participating teams and each offer a different experience. Both maps can be played simultaneously. You can switch between maps using the "},{"text":"arrow","color":"gold"},{"text":" item in your inventory."}]
execute as @a if score @s intro matches 7 run tellraw @s [{"text":""}]

# PHASE 2 - Shooting Range
execute as @a if score @s intro matches 19 run tellraw @s [{"text":""}]
execute as @a if score @s intro matches 19 run tellraw @s ["",{"text":"During the game you'll receive your main weapon: "},{"text":"the crossbow","color":"dark_purple"},{"text":". It will automatically reload but only whilst you're holding it."}]
execute as @a if score @s intro matches 19 run tellraw @s [{"text":""}]

execute as @a if score @s intro matches 24 run tellraw @s [{"text":""}]
execute as @a if score @s intro matches 24 run tellraw @s ["",{"text":"Whenever you use "},{"text":"the crossbow","color":"dark_purple"},{"text":" it will shoot a "},{"text":"fireworks rocket","color":"light_purple"},{"text":". This rocket will explode as soon as it hits something. Anyone hit by a rocket will be 'sploded, shot into the skies above and respawn again after a few seconds. Players have "},{"text":"5 seconds of invulnerability","color":"yellow"},{"text":" after respawning."}]
execute as @a if score @s intro matches 24 run tellraw @s [{"text":""}]

# PHASE 3 - Game
execute as @a if score @s intro matches 32 run tellraw @s [{"text":""}]
execute as @a if score @s intro matches 32 run tellraw @s ["",{"text":"During the game there will sometimes be some "},{"text":"loot crates","color":"gold"},{"text":" that will spawn in the skies. If they are hit with fireworks they will fall down and drop their contents. "},{"text":"These crates contain powerful power-ups that can change the tide of battle.","color":"red"}]
execute as @a if score @s intro matches 32 run tellraw @s [{"text":""}]

execute as @a if score @s intro matches 37 run tellraw @s [{"text":""}]
execute as @a if score @s intro matches 37 run tellraw @s ["",{"text":"The team that gets the most points will win in the end."},{"text":" You get one point for every kill,","color":"red"},{"text":" but lose a point every time you fall into the water.","color":"aqua"}]
execute as @a if score @s intro matches 37 run tellraw @s [{"text":""}]

# Reset intro to -1 at the end by resetting the player
execute as @a if score @s intro matches 40 run scoreboard players set @s introCompleted 1
execute as @a if score @s intro matches 40 run scoreboard players set @s map 0
execute as @a if score @s intro matches 40 run function crossfire:reset_player

# Rerun this function
schedule function crossfire:introduction 1s replace