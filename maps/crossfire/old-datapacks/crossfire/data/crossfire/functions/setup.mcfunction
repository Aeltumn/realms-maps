# Stop all scheduled tasks
schedule clear crossfire:timer0
schedule clear crossfire:timer1
schedule clear crossfire:timer0-2
schedule clear crossfire:timer1-2
schedule clear crossfire:timer0-3
schedule clear crossfire:timer1-3

# Create objectives
scoreboard objectives add gametimer dummy
scoreboard objectives add postgametimer dummy
scoreboard objectives add starttimer dummy
scoreboard objectives add started dummy
scoreboard objectives add player dummy
scoreboard objectives add deadtimer dummy
scoreboard objectives add respawnshield dummy
scoreboard objectives add joined dummy
scoreboard objectives add age dummy
scoreboard objectives add roundKills dummy
scoreboard objectives add spectateSuccess dummy
scoreboard objectives add isreloading dummy
scoreboard objectives add timer dummy
scoreboard objectives add round dummy
scoreboard objectives add result dummy
scoreboard objectives add map dummy
scoreboard objectives add song dummy
scoreboard objectives add wins dummy
scoreboard objectives add cooldown dummy
scoreboard objectives add item_tele dummy
scoreboard objectives add item_tele2 dummy
scoreboard objectives add item_leave dummy
scoreboard objectives add item_cross dummy
scoreboard objectives add winner dummy
scoreboard objectives add introCompleted dummy
scoreboard objectives add bar dummy

scoreboard objectives add intro trigger
scoreboard objectives add introComplTr trigger
scoreboard objectives add crossbow minecraft.used:minecraft.crossbow
scoreboard objectives add powerup minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add kills dummy {"text":"Kills"}

scoreboard objectives setdisplay below_name kills
scoreboard objectives setdisplay list kills

# Cleanup
kill @e[tag=cleanup]

# Create Bossbars
bossbar add crossfire:postgame0 {"text":""}
bossbar set crossfire:postgame0 color blue
bossbar add crossfire:postgame1 {"text":""}
bossbar set crossfire:postgame1 color blue
bossbar add crossfire:timer0 {"text":""}
bossbar set crossfire:timer0 color yellow
bossbar add crossfire:timer1 {"text":""}
bossbar set crossfire:timer1 color yellow
bossbar set crossfire:postgame0 max 25
bossbar set crossfire:postgame1 max 25
bossbar set crossfire:timer0 max 300
bossbar set crossfire:timer1 max 300

# Add the teams
team add red
team add yellow
team add green
team add blue
team add orange
team add magenta
team add lobby

# Setup team attributes
team modify blue color aqua
team modify blue collisionRule never
team modify green color green
team modify green collisionRule never
team modify yellow color yellow
team modify yellow collisionRule never
team modify red color red
team modify red collisionRule never
team modify lobby color gray
team modify lobby collisionRule never
team modify orange color gold
team modify orange collisionRule never
team modify magenta color light_purple
team modify magenta collisionRule never

team modify blue seeFriendlyInvisibles false
team modify green seeFriendlyInvisibles false
team modify yellow seeFriendlyInvisibles false
team modify red seeFriendlyInvisibles false
team modify orange seeFriendlyInvisibles false
team modify magenta seeFriendlyInvisibles false
team modify lobby seeFriendlyInvisibles false

team modify blue nametagVisibility never
team modify green nametagVisibility never
team modify yellow nametagVisibility never
team modify red nametagVisibility never
team modify orange nametagVisibility never
team modify magenta nametagVisibility never
team modify lobby nametagVisibility always

# Setup gamestate
difficulty peaceful
gamerule announceAdvancements false
gamerule disableRaids true
gamerule doInsomnia false
gamerule doPatrolSpawning false
gamerule doTraderSpawning false
gamerule doWeatherCycle false
gamerule drowningDamage false
gamerule fireDamage false
gamerule fallDamage false
gamerule mobGriefing false
gamerule doMobSpawning false
gamerule naturalRegeneration false
gamerule sendCommandFeedback false

# Add some values to round so it always triggers
scoreboard players add round0 round 1
scoreboard players add round1 round 1

# Bring everyone back to their lobbies
function crossfire:lobby_teleport0
function crossfire:lobby_teleport1