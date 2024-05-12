# Send bossbar to players
execute if score postgametimer0 postgametimer matches 0.. run execute store result bossbar crossfire:postgame0 value run scoreboard players get postgametimer0 postgametimer
execute if score postgametimer0 postgametimer matches 2.. run bossbar set crossfire:postgame0 name ["",{"text":"Back to lobby in: "},{"score":{"name":"postgametimer0","objective":"postgametimer"},"bold":true,"color":"aqua"},{"text":" seconds."}]
execute if score postgametimer0 postgametimer matches 1 run bossbar set crossfire:postgame0 name ["",{"text":"Back to lobby in: "},{"score":{"name":"postgametimer0","objective":"postgametimer"},"bold":true,"color":"aqua"},{"text":" second."}]

# Spawn fireworks
execute if score Red winner matches 1 run summon firework_rocket 534.5 73 416.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;11743532]}],Flight:2}}}}
execute if score Yellow winner matches 1 run summon firework_rocket 534.5 73 416.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;14602026]}],Flight:2}}}}
execute if score Green winner matches 1 run summon firework_rocket 534.5 73 416.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;4312372]}],Flight:2}}}}
execute if score Blue winner matches 1 run summon firework_rocket 534.5 73 416.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;6719955]}],Flight:2}}}}
execute if score Red winner matches 1 run summon firework_rocket 524.5 74 426.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;11743532]}],Flight:2}}}}
execute if score Yellow winner matches 1 run summon firework_rocket 524.5 74 426.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;14602026]}],Flight:2}}}}
execute if score Green winner matches 1 run summon firework_rocket 524.5 74 426.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;4312372]}],Flight:2}}}}
execute if score Blue winner matches 1 run summon firework_rocket 524.5 74 426.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;6719955]}],Flight:2}}}}

# Clone the logos back
execute if score postgametimer0 postgametimer matches 0 run clone 464 95 345 467 75 382 525 89 403 replace normal
execute if score postgametimer0 postgametimer matches 0 run function crossfire:lobby_teleport0

# Re-run the timer
execute if score postgametimer0 postgametimer matches 0.. run scoreboard players remove postgametimer0 postgametimer 1
execute if score postgametimer0 postgametimer matches 0.. run schedule function crossfire:timer0-3 1s replace