bossbar set crossfire:timer0 players
bossbar set crossfire:postgame0 players
scoreboard players reset game0 bar

# Empty teams
team empty blue
team empty red
team empty yellow
team empty green

# Reset some scoreboard values
scoreboard players set started0 started 0
scoreboard players set joined0 joined 0
scoreboard players set gametimer0 gametimer -1
scoreboard players set postgametimer0 postgametimer -1
scoreboard players set starttimer0 starttimer -1
scoreboard players add round0 round 1
