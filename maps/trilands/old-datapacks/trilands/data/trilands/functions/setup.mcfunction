function trilands:reset_game
schedule function trilands:timers/timers 1s

function trilands:cosmetics/cosmetic_particle_display
function trilands:timers/timer_new_round
function trilands:timers/timer_grace
function trilands:timers/timer_lobby
function trilands:timers/timer_cooldown
function trilands:water-die
function trilands:cosmetics/cosmetic_particles







scoreboard objectives add roundjoined dummy
scoreboard objectives add totalgold dummy
scoreboard objectives add totaloutlived dummy
scoreboard objectives add destroygold dummy
scoreboard objectives add roundtimer dummy
scoreboard objectives add buy trigger
scoreboard objectives add totaldestroyed dummy
scoreboard objectives add totalkills dummy
scoreboard objectives add testonline dummy
scoreboard objectives add roundswon dummy
scoreboard objectives add lifetimegold dummy
scoreboard objectives add tridentcount dummy
scoreboard objectives add firstjoined dummy
scoreboard objectives add cooldown dummy
scoreboard objectives add outlived dummy
scoreboard objectives add tridentreload dummy
scoreboard objectives add Wins dummy
scoreboard objectives add crossbowreload dummy
scoreboard objectives add settings dummy
scoreboard objectives add gamesplayed dummy
scoreboard objectives add destroy dummy
scoreboard objectives add usedgrapling dummy
scoreboard objectives add c_progress dummy
scoreboard objectives add useitem minecraft.used:minecraft.carrot_on_a_stick
scoreboard objectives add hittime dummy
scoreboard objectives add roundswongold dummy
scoreboard objectives add tridentused dummy
scoreboard objectives add shop dummy
scoreboard objectives add alive dummy
scoreboard objectives add gracetime dummy
scoreboard objectives add killgold dummy
scoreboard objectives add reloading dummy
scoreboard objectives add crossbowuse minecraft.used:minecraft.crossbow
scoreboard objectives add survivegold dummy
scoreboard objectives add newround dummy
scoreboard objectives add tridentsused dummy
scoreboard objectives add gold dummy
scoreboard objectives add result dummy
scoreboard objectives add tutorial dummy
scoreboard objectives add map dummy
scoreboard objectives add destroyedblocks dummy
scoreboard objectives add gamejoined dummy
scoreboard objectives add villager minecraft.custom:minecraft.talked_to_villager
scoreboard objectives add joined dummy
scoreboard objectives add started dummy
scoreboard objectives add gameround dummy
scoreboard objectives add rounddestroyed dummy
scoreboard objectives add tridentuse minecraft.used:minecraft.trident
scoreboard objectives add endround dummy
scoreboard objectives add round dummy
scoreboard objectives add roundkills dummy
scoreboard objectives add online dummy
scoreboard objectives add challenge dummy
scoreboard objectives add starttimer dummy
scoreboard objectives add rounds dummy


scoreboard players add data round 1
scoreboard players set data map 1
scoreboard players set tridentreload settings 0
scoreboard players set weather settings 0
scoreboard players set data rounds 3
scoreboard players set roundtime settings 200
scoreboard players set hatshop shop 0
scoreboard players set particleshop shop 0
scoreboard players set armorshop shop 0
scoreboard players set data settings 0
scoreboard players set data started 0
scoreboard players set data roundjoined 0
scoreboard players set data started 0
scoreboard players set data roundtimer -1
scoreboard players set data joined 0
scoreboard players add @a round 1
scoreboard players add data round 1
scoreboard players set data alive 0
scoreboard players set @a tridentreload 0
scoreboard players set @a reloading 0
scoreboard players set data gameround 0
scoreboard players set @a destroy 0
scoreboard players set data endround -1
scoreboard players set data newround -1
scoreboard players set data gracetime -1
scoreboard players set data settings 0

team add ready
team add notready
team add spectate
team add ingame

team modify ingame friendlyFire false

team modify spectate prefix {"text":"SPECTATING "}
team modify ready prefix {"text":"READY ","color":"green"}
team modify notready prefix {"text":"NOT READY ","color":"red"}
team modify ingame prefix {"text":"INGAME ","color":"gray"}

team modify ingame collisionRule never
team modify ready collisionRule never
team modify notready collisionRule never
team modify spectate collisionRule never

function trilands:reset_map