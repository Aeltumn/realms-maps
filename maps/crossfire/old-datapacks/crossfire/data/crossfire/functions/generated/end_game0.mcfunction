# Add barriers above the water
fill 509 70 401 549 70 441 barrier replace air

# Kill summary
tellraw @a[scores={map=0}] [""]
tellraw @a[scores={map=0}] [""]
tellraw @a[scores={map=0}] ["",{"text":"Point scoreboard for this game:","bold":true}]
tellraw @a[scores={map=0}] ["",{"text":"(kills give 1 point, death from water retracts 1 point)","color":"gray"}]
tellraw @a[scores={map=0}] [""]
execute if entity @a[tag=player1,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player1]"},{"text":": "},{"score":{"name":"@a[tag=player1]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player2,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player2]"},{"text":": "},{"score":{"name":"@a[tag=player2]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player3,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player3]"},{"text":": "},{"score":{"name":"@a[tag=player3]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player4,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player4]"},{"text":": "},{"score":{"name":"@a[tag=player4]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player5,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player5]"},{"text":": "},{"score":{"name":"@a[tag=player5]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player6,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player6]"},{"text":": "},{"score":{"name":"@a[tag=player6]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player7,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player7]"},{"text":": "},{"score":{"name":"@a[tag=player7]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player8,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player8]"},{"text":": "},{"score":{"name":"@a[tag=player8]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player9,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player9]"},{"text":": "},{"score":{"name":"@a[tag=player9]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player10,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player10]"},{"text":": "},{"score":{"name":"@a[tag=player10]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[tag=player11,scores={map=0}] run tellraw @a[scores={map=0}] ["",{"selector":"@a[tag=player11]"},{"text":": "},{"score":{"name":"@a[tag=player11]","objective":"roundKills"},"color":"white"},{"text":" points","color":"white"}]
tellraw @a[scores={map=0}] [""]
execute if entity @a[team=red] run tellraw @a[scores={map=0}] ["",{"text":"Red Team","color":"red"},{"text":": "},{"score":{"name":"Red","objective":"kills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[team=yellow] run tellraw @a[scores={map=0}] ["",{"text":"Yellow Team","color":"yellow"},{"text":": "},{"score":{"name":"Yellow","objective":"kills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[team=green] run tellraw @a[scores={map=0}] ["",{"text":"Green Team","color":"green"},{"text":": "},{"score":{"name":"Green","objective":"kills"},"color":"white"},{"text":" points","color":"white"}]
execute if entity @a[team=blue] run tellraw @a[scores={map=0}] ["",{"text":"Blue Team","color":"aqua"},{"text":": "},{"score":{"name":"Blue","objective":"kills"},"color":"white"},{"text":" points","color":"white"}]
tellraw @a[scores={map=0}] [""]
tellraw @a[scores={map=0}] [""]

# Send titles to winnerstitle @a[scores={map=0}] clear
title @a[scores={map=0}] subtitle {"text":""}
title @a[scores={map=0}] times 40 160 40

execute unless entity @a[team=red] run scoreboard players set Red kills -999
execute unless entity @a[team=yellow] run scoreboard players set Yellow kills -999
execute unless entity @a[team=green] run scoreboard players set Green kills -999
execute unless entity @a[team=blue] run scoreboard players set Blue kills -999
execute if score Red kills > Blue kills if score Red kills > Yellow kills if score Red kills > Green kills run scoreboard players set Red winner 1
execute if score Blue kills > Red kills if score Blue kills > Yellow kills if score Blue kills > Green kills run scoreboard players set Blue winner 1
execute if score Yellow kills > Blue kills if score Yellow kills > Red kills if score Yellow kills > Green kills run scoreboard players set Yellow winner 1
execute if score Green kills > Red kills if score Green kills > Yellow kills if score Green kills > Blue kills run scoreboard players set Green winner 1
execute unless score Red winner matches 1.. unless score Green winner matches 1.. unless score Yellow winner matches 1.. unless score Blue winner matches 1.. run scoreboard players set Draw0 winner 1
execute if score Red winner matches 1.. run tellraw @a[scores={map=0}] ["",{"text":"Red","bold":true,"color":"red"},{"text":" won the game!"}]
execute if score Red winner matches 1.. run title @a[scores={map=0}] title ["",{"text":"Red","bold":true,"color":"red"},{"text":" won the game!"}]
execute if score Blue winner matches 1.. run tellraw @a[scores={map=0}] ["",{"text":"Blue","bold":true,"color":"aqua"},{"text":" won the game!"}]
execute if score Blue winner matches 1.. run title @a[scores={map=0}] title ["",{"text":"Blue","bold":true,"color":"aqua"},{"text":" won the game!"}]
execute if score Yellow winner matches 1.. run tellraw @a[scores={map=0}] ["",{"text":"Yellow","bold":true,"color":"yellow"},{"text":" won the game!"}]
execute if score Yellow winner matches 1.. run title @a[scores={map=0}] title ["",{"text":"Yellow","bold":true,"color":"yellow"},{"text":" won the game!"}]
execute if score Green winner matches 1.. run tellraw @a[scores={map=0}] ["",{"text":"Green","bold":true,"color":"green"},{"text":" won the game!"}]
execute if score Green winner matches 1.. run title @a[scores={map=0}] title ["",{"text":"Green","bold":true,"color":"green"},{"text":" won the game!"}]
execute if score Draw0 winner matches 1.. run tellraw @a[scores={map=0}] ["",{"text":"It's a draw!","bold":true,"color":"gold"}]
execute if score Draw0 winner matches 1.. run title @a[scores={map=0}] title ["",{"text":"It's a draw!","bold":true,"color":"gold"}]

# Actually give the wins to the players
execute if score Red winner matches 1.. run scoreboard players add @a[team=red] wins 1
execute if score Yellow winner matches 1.. run scoreboard players add @a[team=yellow] wins 1
execute if score Green winner matches 1.. run scoreboard players add @a[team=green] wins 1
execute if score Blue winner matches 1.. run scoreboard players add @a[team=blue] wins 1

# Play sound to play depending on if they won or lost
execute if score Red winner matches 1.. run tag @a[team=red,scores={map=0}] add won0
execute if score Yellow winner matches 1.. run tag @a[team=yellow,scores={map=0}] add won0
execute if score Green winner matches 1.. run tag @a[team=green,scores={map=0}] add won0
execute if score Blue winner matches 1.. run tag @a[team=blue,scores={map=0}] add won0

# Give lost if you don't have win
tag @a[tag=!won0,scores={map=0}] add lost0

# Play this game's song function (in case of simultanious wins we have two copies)
schedule function crossfire:song0 6s replace

# Clear viewers of the timer
bossbar set crossfire:timer0 players
# Show the postgame bossbar
bossbar set crossfire:postgame0 players
bossbar set crossfire:postgame0 players @a[scores={map=0}]
scoreboard players set game0 bar 2
# Set the post game timer to its start value
scoreboard players set postgametimer0 postgametimer 25
# Reset all players in this map
execute as @a[scores={map=0},tag=joined] run function crossfire:reset_player
# Reset all players in this map
function crossfire:timer0-3
# Cleanup
kill @e[tag=cleanup0]
