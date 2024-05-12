# Update scoreboard values
scoreboard players set @s introComplTr 0
scoreboard players set @s introCompleted 1

# Send message
tellraw @s ["",{"text":"You've skipped the tutorial!","color":"yellow"}]