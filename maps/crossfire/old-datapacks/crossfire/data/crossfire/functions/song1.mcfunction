# Make sure we have scores in the board
scoreboard players add song1 song 0

# Notes of the song
# Winners
execute if score song1 song matches 0 as @a[tag=won1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 1.3
execute if score song1 song matches 1 as @a[tag=won1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 1.1
execute if score song1 song matches 2 as @a[tag=won1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 1.4
execute if score song1 song matches 3 as @a[tag=won1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 1.6
execute if score song1 song matches 5 as @a[tag=won1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 1.9

# Losers
execute if score song1 song matches 0 as @a[tag=lost1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 1
execute if score song1 song matches 1 as @a[tag=lost1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 0.9
execute if score song1 song matches 2 as @a[tag=lost1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 0.7
execute if score song1 song matches 3 as @a[tag=lost1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 0.6
execute if score song1 song matches 5 as @a[tag=lost1] at @s run playsound minecraft:block.note_block.bit master @s ~ ~ ~ 100 0.3

# Keep the song going if we haven't had all notes yet
execute if score song1 song matches ..5 run scoreboard players add song1 song 1
execute if score song1 song matches ..5 run schedule function crossfire:song1 8t

# Reset song for next loop
execute if score song1 song matches 6.. run tag @a[tag=won1] remove won1
execute if score song1 song matches 6.. run tag @a[tag=lost1] remove lost1
execute if score song1 song matches 6.. run scoreboard players set song1 song 0