# Make sure we have scores in the board
scoreboard players add gamesong song 0

# Notes of the song
# Winners
execute if score gamesong song matches 0 as @a[tag=selected] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 0.2 1.4
execute if score gamesong song matches 1 as @a[tag=selected] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 0.2 1.4
execute if score gamesong song matches 2 as @a[tag=selected] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 0.2 1.4
execute if score gamesong song matches 3 as @a[tag=selected] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 0.2 1.3
execute if score gamesong song matches 5 as @a[tag=selected] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 0.2 1.6
execute if score gamesong song matches 6 as @a[tag=selected] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 0.2 1.8
execute if score gamesong song matches 7 as @a[tag=selected] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 0.2 1.8
execute if score gamesong song matches 8 as @a[tag=selected] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 0.2 1.4
execute if score gamesong song matches 9 as @a[tag=selected] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 0.2 1.6

# Keep the song going if we haven't had all notes yet
scoreboard players add gamesong song 1
schedule function crossfire:gamesong 8t

# Reset song for next loop
execute if score gamesong song matches 12.. run scoreboard players set gamesong song 0