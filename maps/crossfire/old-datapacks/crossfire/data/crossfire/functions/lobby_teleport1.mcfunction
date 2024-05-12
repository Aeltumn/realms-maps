bossbar set crossfire:timer1 players
bossbar set crossfire:postgame1 players
scoreboard players reset game1 bar

# Empty teams
team empty orange
team empty magenta

# Reset some scoreboard values
scoreboard players set started1 started 0
scoreboard players set joined1 joined 0
scoreboard players set gametimer1 gametimer -1
scoreboard players set postgametimer1 postgametimer -1
scoreboard players set starttimer1 starttimer -1
scoreboard players add round1 round 1
