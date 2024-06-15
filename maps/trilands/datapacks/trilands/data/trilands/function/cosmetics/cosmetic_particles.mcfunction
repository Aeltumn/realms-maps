execute as @e[tag=particle1selected,type=player] at @s[gamemode=!spectator] run particle minecraft:enchant ~ ~.4 ~ 0.1 0.2 0.1 1 2
execute as @e[tag=particle2selected,type=player] at @s[gamemode=!spectator] run particle minecraft:happy_villager ~ ~.4 ~ 0.2 0.2 0.2 0.02 1
execute as @e[tag=particle3selected,type=player] at @s[gamemode=!spectator] run particle minecraft:flame ~ ~.4 ~ 0.2 0.2 0.2 0 1
execute as @e[tag=adminparticle,type=player] at @s[gamemode=!spectator] run particle minecraft:end_rod ~ ~.3 ~ 0.3 0.2 0.3 0 1
schedule function trilands:cosmetics/cosmetic_particles 4t