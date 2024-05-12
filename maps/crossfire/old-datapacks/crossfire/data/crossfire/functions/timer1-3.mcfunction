# Send bossbar to players
execute if score postgametimer1 postgametimer matches 0.. run execute store result bossbar crossfire:postgame1 value run scoreboard players get postgametimer1 postgametimer
execute if score postgametimer1 postgametimer matches 2.. run bossbar set crossfire:postgame1 name ["",{"text":"Back to lobby in: "},{"score":{"name":"postgametimer1","objective":"postgametimer"},"bold":true,"color":"aqua"},{"text":" seconds."}]
execute if score postgametimer1 postgametimer matches 1 run bossbar set crossfire:postgame1 name ["",{"text":"Back to lobby in: "},{"score":{"name":"postgametimer1","objective":"postgametimer"},"bold":true,"color":"aqua"},{"text":" second."}]

# Spawn fireworks
execute if score Orange winner matches 1 run summon firework_rocket 525.5 76 292.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;15435844]}],Flight:2}}}}
execute if score Magenta winner matches 1 run summon firework_rocket 525.5 76 292.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;12801229]}],Flight:2}}}}
execute if score Orange winner matches 1 run summon firework_rocket 533.5 76 300.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;15435844]}],Flight:2}}}}
execute if score Magenta winner matches 1 run summon firework_rocket 533.5 76 300.5 {Tags:["custom"],LifeTime:18,FireworksItem:{id:firework_rocket,Count:1,tag:{Fireworks:{Explosions:[{Type:0,Colors:[I;12801229]}],Flight:2}}}}

# Clone the logos back
execute if score postgametimer1 postgametimer matches 0 run clone 464 95 345 467 75 382 525 89 278 replace normal
execute if score postgametimer1 postgametimer matches 0 run function crossfire:lobby_teleport1

# Re-run the timer
execute if score postgametimer1 postgametimer matches 0.. run scoreboard players remove postgametimer1 postgametimer 1
execute if score postgametimer1 postgametimer matches 0.. run schedule function crossfire:timer1-3 1s replace