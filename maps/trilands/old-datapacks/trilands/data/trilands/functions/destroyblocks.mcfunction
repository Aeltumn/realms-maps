execute if block ~ ~1 ~ minecraft:jungle_leaves run setblock ~ ~1 ~ air destroy
execute if block ~ ~-1 ~ minecraft:jungle_leaves run setblock ~ ~-1 ~ air destroy
execute if block ~ ~ ~1 minecraft:jungle_leaves run setblock ~ ~ ~1 air destroy
execute if block ~1 ~ ~ minecraft:jungle_leaves run setblock ~1 ~ ~ air destroy
execute if block ~ ~ ~-1 minecraft:jungle_leaves run setblock ~ ~ ~-1 air destroy
execute if block ~-1 ~ ~ minecraft:jungle_leaves run setblock ~-1 ~ ~ air destroy

execute if block ~ ~1 ~ minecraft:birch_fence run setblock ~ ~1 ~ air destroy
execute if block ~ ~-1 ~ minecraft:birch_fence run setblock ~ ~-1 ~ air destroy
execute if block ~ ~ ~1 minecraft:birch_fence run setblock ~ ~ ~1 air destroy
execute if block ~1 ~ ~ minecraft:birch_fence run setblock ~1 ~ ~ air destroy
execute if block ~ ~ ~-1 minecraft:birch_fence run setblock ~ ~ ~-1 air destroy
execute if block ~-1 ~ ~ minecraft:birch_fence run setblock ~-1 ~ ~ air destroy

execute if block ~ ~1 ~ minecraft:nether_wart_block run setblock ~ ~1 ~ air destroy
execute if block ~ ~-1 ~ minecraft:nether_wart_block run setblock ~ ~-1 ~ air destroy
execute if block ~ ~ ~1 minecraft:nether_wart_block run setblock ~ ~ ~1 air destroy
execute if block ~1 ~ ~ minecraft:nether_wart_block run setblock ~1 ~ ~ air destroy
execute if block ~ ~ ~-1 minecraft:nether_wart_block run setblock ~ ~ ~-1 air destroy
execute if block ~-1 ~ ~ minecraft:nether_wart_block run setblock ~-1 ~ ~ air destroy

execute if block ~ ~ ~ minecraft:andesite_wall run setblock ~ ~1 ~ air destroy

execute as @s[tag=player0] run execute as @a[tag=player0] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player1] run execute as @a[tag=player1] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player2] run execute as @a[tag=player2] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player3] run execute as @a[tag=player3] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player4] run execute as @a[tag=player4] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player5] run execute as @a[tag=player5] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player6] run execute as @a[tag=player6] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player7] run execute as @a[tag=player7] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player8] run execute as @a[tag=player8] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player9] run execute as @a[tag=player9] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player
execute as @s[tag=player10] run execute as @a[tag=player10] unless block ~ ~ ~ water unless block ~ ~ ~ air run function trilands:destroy_blocks_player

setblock ~ ~ ~ air destroy