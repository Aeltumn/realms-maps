# Add barriers above the water
fill 509 70 276 549 70 316 barrier replace air

# Kill summary
tellraw @a[scores={map=1}] [""]
tellraw @a[scores={map=1}] [""]
tellraw @a[scores={map=1}] ["",{"text":"Point scoreboard for this game:","bold":true}]
tellraw @a[scores={map=1}] ["",{"text":"(kills give 1 point, death from water retracts 1 point)","color":"gray"}]
tellraw @a[scores={map=1}] [""]
execute if entity @a[tag=player1,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player1]"},{"text":": "},{"score":{"name":"@a[tag=player1]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player2,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player2]"},{"text":": "},{"score":{"name":"@a[tag=player2]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player3,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player3]"},{"text":": "},{"score":{"name":"@a[tag=player3]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player4,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player4]"},{"text":": "},{"score":{"name":"@a[tag=player4]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player5,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player5]"},{"text":": "},{"score":{"name":"@a[tag=player5]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player6,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player6]"},{"text":": "},{"score":{"name":"@a[tag=player6]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player7,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player7]"},{"text":": "},{"score":{"name":"@a[tag=player7]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player8,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player8]"},{"text":": "},{"score":{"name":"@a[tag=player8]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player9,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player9]"},{"text":": "},{"score":{"name":"@a[tag=player9]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player10,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player10]"},{"text":": "},{"score":{"name":"@a[tag=player10]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player11,scores={map=1}] run tellraw @a[scores={map=1}] ["",{"selector":"@a[tag=player11]"},{"text":": "},{"score":{"name":"@a[tag=player11]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
tellraw @a[scores={map=1}] [""]
execute if entity @a[team=orange] run tellraw @a[scores={map=1}] ["",{"text":"Orange Team","color":"gold"},{"text":": "},{"score":{"name":"Orange","objective":"kills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[team=magenta] run tellraw @a[scores={map=1}] ["",{"text":"Magenta Team","color":"light_purple"},{"text":": "},{"score":{"name":"Magenta","objective":"kills"},"color":"white"},{"text":" points","color":"white"}]
tellraw @a[scores={map=1}] [""]
tellraw @a[scores={map=1}] [""]

# Send titles to winnerstitle @a[scores={map=1}] clear
title @a[scores={map=1}] subtitle {"text":""}
title @a[scores={map=1}] times 40 160 40

execute unless entity @a[team=orange] run scoreboard players set Orange kills -999
execute unless entity @a[team=magenta] run scoreboard players set Magenta kills -999
execute if score Orange kills > Magenta kills run scoreboard players set Orange winner 1
execute if score Magenta kills > Orange kills run scoreboard players set Magenta winner 1
execute unless score Orange winner matches 1.. unless score Magenta winner matches 1.. run scoreboard players set Draw1 winner 1
execute if score Orange winner matches 1.. run tellraw @a[scores={map=1}] ["",{"text":"Orange","bold":true,"color":"gold"},{"text":" won the game!"}]
execute if score Orange winner matches 1.. run title @a[scores={map=1}] title ["",{"text":"Orange","bold":true,"color":"gold"},{"text":" won the game!"}]
execute if score Magenta winner matches 1.. run tellraw @a[scores={map=1}] ["",{"text":"Magenta","bold":true,"color":"light_purple"},{"text":" won the game!"}]
execute if score Magenta winner matches 1.. run title @a[scores={map=1}] title ["",{"text":"Magenta","bold":true,"color":"light_purple"},{"text":" won the game!"}]
execute if score Draw1 winner matches 1.. run tellraw @a[scores={map=1}] ["",{"text":"It's a draw!","bold":true,"color":"gold"}]
execute if score Draw1 winner matches 1.. run title @a[scores={map=1}] title ["",{"text":"It's a draw!","bold":true,"color":"gold"}]

# Actually give the wins to the players
execute if score Orange winner matches 1.. run scoreboard players add @a[team=orange] wins 1
execute if score Magenta winner matches 1.. run scoreboard players add @a[team=magenta] wins 1

# Play sound to play depending on if they won or lost
execute if score Orange winner matches 1.. run tag @a[team=orange,scores={map=1}] add won1
execute if score Magenta winner matches 1.. run tag @a[team=magenta,scores={map=1}] add won1

# Give lost if you don't have win
tag @a[tag=!won1,scores={map=1}] add lost1

# Play this game's song function (in case of simultanious wins we have two copies)
schedule function crossfire:song1 6s replace

# Clear viewers of the timer
bossbar set crossfire:timer1 players
# Show the postgame bossbar
bossbar set crossfire:postgame1 players
bossbar set crossfire:postgame1 players @a[scores={map=1}]
scoreboard players set game1 bar 2
# Set the post game timer to its start value
scoreboard players set postgametimer1 postgametimer 25
# Reset all players in this map
execute as @a[scores={map=1},tag=joined] run function crossfire:reset_player
# Reset all players in this map
function crossfire:timer1-3
# Cleanup
kill @e[tag=cleanup1]
