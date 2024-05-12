# Determine joined value
scoreboard players set joined0 joined 0
execute as @e[tag=joined0] run scoreboard players add joined0 joined 1

# If only one team is filled we set joined to 0 to prevent a game start
scoreboard players set temp50 result 0
execute if entity @a[team=red] run scoreboard players add temp50 result 1
execute if entity @a[team=green] run scoreboard players add temp50 result 1
execute if entity @a[team=yellow] run scoreboard players add temp50 result 1
execute if entity @a[team=blue] run scoreboard players add temp50 result 1

execute if score temp50 result matches ..1 run scoreboard players set joined0 joined 0

# Start the game if possible
execute if score joined0 joined matches 0 run tellraw @a[scores={map=0}] {"text":"You need to have at least 2 teams with players in them."}
execute if score joined0 joined matches 1 run tellraw @a[scores={map=0}] {"text":"Not enough players have chosen a team yet!"}

execute if score joined0 joined matches 2.. as @a[tag=!admin,scores={map=0}] run function crossfire:init_player
execute if score joined0 joined matches 2.. run scoreboard players set started0 started 1

# Reset kills for this team
execute if score joined0 joined matches 2.. run scoreboard players set Red kills 0
execute if score joined0 joined matches 2.. run scoreboard players set Yellow kills 0
execute if score joined0 joined matches 2.. run scoreboard players set Green kills 0
execute if score joined0 joined matches 2.. run scoreboard players set Blue kills 0
execute if score joined0 joined matches 2.. unless entity @a[tag=player1] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player1
execute if score joined0 joined matches 2.. as @a[tag=player1,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player1,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player1,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player1,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player2] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player2
execute if score joined0 joined matches 2.. as @a[tag=player2,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player2,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player2,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player2,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player3] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player3
execute if score joined0 joined matches 2.. as @a[tag=player3,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player3,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player3,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player3,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player4] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player4
execute if score joined0 joined matches 2.. as @a[tag=player4,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player4,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player4,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player4,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player5] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player5
execute if score joined0 joined matches 2.. as @a[tag=player5,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player5,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player5,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player5,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player6] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player6
execute if score joined0 joined matches 2.. as @a[tag=player6,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player6,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player6,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player6,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player7] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player7
execute if score joined0 joined matches 2.. as @a[tag=player7,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player7,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player7,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player7,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player8] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player8
execute if score joined0 joined matches 2.. as @a[tag=player8,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player8,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player8,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player8,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player9] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player9
execute if score joined0 joined matches 2.. as @a[tag=player9,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player9,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player9,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player9,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player10] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player10
execute if score joined0 joined matches 2.. as @a[tag=player10,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player10,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player10,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player10,scores={map=0}] run tag @s add selected0

execute if score joined0 joined matches 2.. unless entity @a[tag=player11] as @a[tag=!selected0,tag=joined,scores={map=0},limit=1] run tag @s add player11
execute if score joined0 joined matches 2.. as @a[tag=player11,scores={map=0}] run tag @s add selected
execute if score joined0 joined matches 2.. as @a[tag=player11,scores={map=0}] run tag @s add pregame
execute if score joined0 joined matches 2.. as @a[tag=player11,scores={map=0}] run tag @s remove mapchanger
execute if score joined0 joined matches 2.. as @a[tag=player11,scores={map=0}] run tag @s add selected0



execute if score joined0 joined matches 2.. run scoreboard players set starttimer0 starttimer 5
execute if score joined0 joined matches 2.. run function crossfire:timer0

# Create party map cages (0)
execute if score joined0 joined matches 2.. run clone 438 76 383 444 86 386 526 70 440
execute if score joined0 joined matches 2.. run clone 438 76 388 444 86 391 526 70 399
execute if score joined0 joined matches 2.. run clone 444 76 393 441 86 399 548 70 418
execute if score joined0 joined matches 2.. run clone 441 76 407 444 86 401 507 70 418

# Remove post-game barriers
execute if score joined0 joined matches 2.. run fill 509 70 401 549 70 441 air replace barrier

# Remove the logos
execute if score joined0 joined matches 2.. run fill 525 109 403 528 89 440 air
