--[[ By: Michael Simnitt aka Mindsoft
Date: Aug/24/2018
Description: Boss Mobile Event Screenplay and Handler Utilities
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.

** Key **
	string pointer: string that points to a tables location in Lua ex. "myScreenplay.bossTable"

	string list: table in string format ex. "itemOne/itemTwo/itemThree" ,(don't use spaces)

	table: any valid Lua table specific to that attribute
	
	list: a table of values or tables specific to the attribute

	integer: any valid whole number , use is specific to attribute



** Trigger & Boss Table Attributes **
	attributeName: (rules)
		-descriptions

 (Required)
	stringData: (Required) (string pointer) 
		-string pointer to spawns table
		-the information in this table will be used to control object's spawn and handlers

	spawnList: (Required) (string pointer / table / string list)

	wpList: (Required) (string pointer / table / list)
		-accepts table of multiple waypoint tables or a single waypoint table
		-waypoint table format: {p,x,z,y,f,c,rng} , (range is optional)
		-if spawning in cellID:0 you can use a Z of 0 and nav will find the correct Z height

 (Spawn Config)
	spawnRange: (integer) (only used if not specified in selected wp's table)
		-used to randomize spawns x,y coord's during spawn process
		-integer given will be random( + or - integer )+(x,y) set to nearest 100th

	respawnTimer: (integer)
		-used to set the time for respawning if despawned
		-if int and there is no bossStringData or triggerStringData, will spawn stringData
		-if false does not respawn

	despawn: (integer)
		-used to set the despawn timer of spawn
		-defaults to 120s on death to clean-up corps'
		-reschedules if in combat, 10s in future
		-if false does not despawn
		-if respawn is int, npc will respawn stringData int respawn seconds

	spawnDelay: (integer)
		-used to set the delay time of next spawn after death
		-if false spawn is instant
		-if int represents seconds until next spawn in chain is spawned

	leash: (integer)
		-used to specify distance npc can travel from it's spawn point before it "corrects"
		-npc will correct by dropping targets past 1.25 this distance away
		-if no players are in leash+1m, npc will peace-all and goto spawn point healing 20%max HAM
		-if players are in leash range when npc corrects, those players will remain in combat

 (Pointers)
	*Notes for Both TriggerStringData and BossStringData pointer type Attributes:
		-can be used by both trigger and boss spawn types, tho only 1 will fire.
		-If both exist one will be randomly chosen.
		-can use string list pointer format, ex: bossStringData = "WFboss.myBoss1/WFboss.myBoss2/WFboss.myBoss3"
			-1 item will be randomly selected from this list when this attributes event fires
		-can use string pointer format, ex: bossStringData = "WFboss.myBoss1"
		-If respawn timer attribute exists spawn will occur in respawnTimer*100ms

	triggerStringData: (string pointer, string list)
		-option used to spawn trigger at trigger/boss death
		-points to spawn table for the desired trigger

	bossStringData: (string pointer, string list)
		-option used to spawn boss at trigger/boss death
		-points to spawn table for the desired boss
	
 (Events)
	*Notes for events:
		-must be valid function in memory or string pointer
		-will be passed the mobile and string pointer in most cases

	spawnEvent: (string pointer, function)
		-fires after the npc is spawned

	addEvent: (Boss only) (string pointer, function)
		-fires after the Boss is created if add list is found
		-fires before default add handler task is added
		-used to set up custom add-handler/boss-HAM-Observer

	deathEvent: (string pointer, function)
		--fires after the npc death event

	despawnEvent: (string pointer, function)
		--fires after the npc despawn event
	
** Boss Table Only Attributes **
	intro: (string)
		-string is broadcasted in spatial chat when npc is spawned

	broadcast: (string)
		-string is broadcasted in galaxy chat when npc is spawned

	taunts:	(string list)
		-string randomly chosen from list and broadcasted in spatial to taunt players

--]]
WFskills = ScreenPlay:new{
	areaKD = function(pMob)
 		CreatureObject(pMob):doAnimation("angry")
		spatialChat(pMob, "Bow to the Force!") --spatial random taunt from list
		local playerTable = SceneObject(pMob):getPlayersInRange(5)
		foreach(playerTable, function(pPlayer)
 			CreatureObject(pPlayer):setPosture(KNOCKEDDOWN)
			CreatureObject(pPlayer):sendSystemMessage("The Force pushes you to the ground.")
		end)
		return 0
	end,

	areaKD2 = function(pMob)
 		CreatureObject(pMob):doAnimation("angry")
		spatialChat(pMob, "Behold!..the Force!") --spatial random taunt from list
		local playerTable = SceneObject(pMob):getPlayersInRange(10)
		foreach(playerTable, function(pPlayer)
 			CreatureObject(pPlayer):setPosture(KNOCKEDDOWN)
			CreatureObject(pPlayer):sendSystemMessage("The Force pushes you Hard to the ground.")
		end)
		return 0
	end,

	areaPoison = function(pMob)
 		CreatureObject(pMob):doAnimation("wave_finger_warning")
		spatialChat(pMob, "You will soon see your fate!") --spatial random taunt from list
		local playerTable = SceneObject(pMob):getPlayersInRange(5)
		foreach(playerTable, function(pPlayer)
 			CreatureObject(pPlayer):addDotState(pMob, POISONED, getRandomNumber(50) + 40, HEALTH, 100, 1000, SceneObject(pMob):getObjectID(), 0)
		end)
		return 0
	end,
}
registerScreenPlay("WFskills", false)

WFadds = ScreenPlay:new{
	testeOne = function(str)
		print("\n\ntesteOne ran: "..tostring(str).."\n")
	end,

	testeTwo = function(str)
		print("\n\ntesteTwo ran: "..tostring(str).."\n")
	end,


	--for open-world boss use only, must be in cell-ID:0
	generateTest = function(pMob, stringData, addTable, wp) -- wp = {p,x,z,y,c}
		local addStr = ""
		local i = 0
		local rng = addTable[4]
		local DDlist = CreatureObject(pMob):getDamageDealerList() --get threat map
		local addList = HelperFuncs:splitString(addTable[5], "/") --Split Spawn-List from string
		repeat
			local x = WFnav:rndRng(wp[2], rng)
			local y = WFnav:rndRng(wp[4], rng)
			local z = WFnav:getZ(wp[1],x,y)
			local t = addList[math.random(#addList)] --pick random template from list
			local add = spawnMobile(wp[1],t,-1,x,z,y,math.random(360),wp[5]) --spawn add
			SceneObject(add):addPendingTask((10+math.random(40)*1000), "WFadds", "taunt") --set up taunt event
			CreatureObject(add):engageCombat(DDlist[math.random(#DDlist)]) --engage randomly from boss threat map
			addStr = addStr..tostring(SceneObject(add):getObjectID()).."/" --build add-string for despawns/ect
			i = i + 1
		until (i >= addTable[3])
		return addStr --return add-string to WFboss handler
	end,

	--add generic taunting to each add in add-list	
	addTaunt = function(pMob, stringData, str) -- wp = {p,x,z,y,c}
		local addList = HelperFuncs:splitString(str, "/")
		foreach(addList, function(pAdd)
			local add = getSceneObject(pAdd)
			if (SceneObject(add)) then
				SceneObject(add):addPendingTask((10+math.random(40)*1000), "WFadds", "taunt") --set up taunt event
			end
		end)
		
	end,

	--generic taunt event
	taunt = function(d1,pMob)
		if (SceneObject(pMob)) then --test object is valid
			if (CreatureObject(pMob):isInCombat() and (math.random(10)>3)) then --test for in-combat
				SceneObject(pMob):cancelPendingTask("WFadds", "taunt")
				local taunts = {"Ow!","Hey now!","Oof!","I make a Squish!","Bam, Straight to the moon","Grr"}
				spatialChat(pMob, taunts[math.random(#taunts)]) --spatial random taunt from list
			end
			SceneObject(pMob):addPendingTask((30+math.random(15))*1000, "WFadds", "taunt") --retask event
		end
		return 0
	end,

}
registerScreenPlay("WFadds", false)

---------------------------------------------(WFboss Event Screenplay & Spawns)
WFboss = ScreenPlay:new{
	["waypoints1"] = { --{Planet, X, Z, Y, Facing direction, Cell id, RaNGe}
		{"dathomir", -110, 129, -1658, math.random(360), 0, 6},

		--{"dathomir", -90.2, -100.5, -102.3, math.random(360), 3695712, 5},
	},

	trigy = {
		{"dathomir", -110, 129, -1658, math.random(360), 0, 6},
		--{"dathomir", -158, 4, -1738, math.random(360), 0},
	},

	--test boss table
	boss = {
		stringData = "WFboss.boss", --   <---(*FIELD REQUIRED*) string pointer to this table
		spawnList = "boss_chuba", --string or string list of templates to use for boss
		wpList = "WFboss.trigy", --string pointer to the waypoint list OR table of waypoints in {p,x,z,y,f,c,rng} format
		spawnRange = 8, --if false spawns at initial x,z,y , if int spawns random(+/-)int x,y from initial x,y 
		respawnTimer = 5, --if false no respawn, if int>0 respawns in int seconds
		despawn = false, --if false no despawn, if int>0 despawn in int seconds
		despawnEvent = false, --if false use default, if function run function instead of default
		intro = "Hello youngling...", --if false no intro, if string spatials intro when engaged
		broadcast = false, --if false no broadcast, if string broadcast that string, ie: broadcast = "boss spawned"
		taunts = { --if false no taunts, if table uses taunts
			"You can't hurt me..",
			"Do you think that will save you?",
			"You should run now, child!",
		},
		spawnEvent = false, --if false use default, if function run function instead of default
		deathEvent = false,--if false use default, if function run function instead of default
		--aiTemplate = "idlewander", --if false no template change, if string set as current ai template --NOT WORKING WELL
		addEvent = false, --if false use default, if  function run function instead of default
		adds = { --if false no add, if table run table[i] at HAM/#table intervals, ie:2 lists in table is 66%HAM and 33%HAM
			--#SubType, event, #toSpawn, #range, spawns1,..spawn3
			--SubType 0, (string/list/string pointer)
				--spawns scale if boss does, #toSpawn is how many total from spawn list will be spawned
			--SubType 1, spawns scale if boss does, #toSpawn is how many from each spawn in list will be spawned
			--SubType 10, spawns do not scale, #toSpawn is how many total from spawn list will be spawned
			--SubType 11, spawns do not scale, #toSpawn is how many from each spawn in list will be spawned
			--SubType 20, spawns are generated from function and add-string passed back to handler
			--SubType 21, spawn-table is passed back from spawns function then ran as normal spawnTable
			{0,false, 2, 10, "chuba/kwi"},
			{0,WFadds.testeOne, 0, 5, "purbole/kamurith_snapper/rancor"},
		},
		spawnDelay = false, --if false no delay, if int delays triggered spawn for int seconds
		triggerStringData = "WFboss.trigger", --if false no trigger, if string -points to the trigger NPC table
		bossStringData = false, -- if false no boss spawned, if string -points to boss table
	},
	
	trigger = {
		stringData = "WFboss.trigger", --   <---(*FIELD REQUIRED*)
		bossStringData = false, -- if false no boss spawned, if string -points to boss table
		spawnList = "chuba", --string or string list of templates to use for trigger <---(*FIELD REQUIRED*)
		wpList = "WFboss.waypoints1", --string pointer to the waypoint list OR table of waypoints <---(*FIELD REQUIRED*)
		spawnRange = 6, --if false spawns at initial x,z,y , if int spawns random(+/-)int x,y from initial x,y
		respawnTimer = false, --if false no respawn, if int>0 respawns in int seconds
		despawn = false, --if false no despawn, if int>0 despawn in int seconds
		despawnEvent = false, --if false use default, if function run function instead of default
		spawnEvent = false, --if false use default, if function run function instead of default
		deathEvent = false,--if false use default, if function run function instead of default
		spawnDelay = false, --if false no delay, if int delays triggered spawn for int seconds
		triggerStringData = "WFboss.boss", --if false no trigger, if string -points to the trigger NPC table
		--aiTemplate = "idlewander", --if false no template change, if string set as current ai template --NOT WORKING WELL
		--scaled = {2,.3,9}, --if false no scaling, if table use format {scaleType,scaleFactor,scale}
	},
}
registerScreenPlay("WFboss", false)

function WFboss:start()
	--spawnTriggerMobile("WFboss.trigger")
	local boss = WFboss.boss
	local addList = boss.adds
	local addsOne = addList[1]
	local addsTwo = addList[2]
	print("addsOne: "..tostring(addsOne[2]))
	print("addsTwo: "..tostring(addsTwo[2]))
	addsTwo[2]("\nhello world\n")
end

function WFboss:triggerDead(pMob, pKiller)
	--print("\n*Running WFboss:triggerDead")
	local stringData = readStringData(SceneObject(pMob):getObjectID() .. ":stringData")
	local func = load('return '..stringData)
	local data = func()

	if (data.leash) then 
		deleteStringData(SceneObject(pMob):getObjectID() .. ":WFbossLeashString")
		SceneObject(pMob):cancelPendingTask("WFboss", "leashTest")
	elseif (data.WFskills) then
		SceneObject(pMob):cancelPendingTask("WFboss", "leashTest")
	end

	deleteStringData(SceneObject(pMob):getObjectID() .. ":stringData") --clean up stringData
	SceneObject(pMob):cancelPendingTask("WFboss", "despawn")
	SceneObject(pMob):addPendingTask(120000, "WFboss", "destroy")

	if (data.deathEvent and (type(data.deathEvent)== "function")) then --Test for table-defined death event
		if not(data.deathEvent(pMob, pKiller, stringData)) then
			return 0
		end		
	end

	local bossList = false
	local triggerList = false
	if (data.bossStringData) then --test for boss and trigger pointers
		if (data.triggerStringData) then
			if (math.random(100)>50) then -- if both pick one randomly
				bossList = HelperFuncs:splitString(data.bossStringData, "/")
			else
				triggerList = HelperFuncs:splitString(data.triggerStringData, "/")
			end
		else --only boss
			bossList = HelperFuncs:splitString(data.bossStringData, "/")
		end
	elseif (data.triggerStringData) then --only trigger
		triggerList = HelperFuncs:splitString(data.triggerStringData, "/")
	end

	if (bossList) then --test for and spawn bosses first
		local bossStringData = bossList[math.random(#bossList)]

		if (data.spawnDelay) then
			createEvent(data.spawnDelay*1000,"WFboss","bossSpawnEvent",pMob,bossStringData)
		else
			spawnBossMobile(bossStringData)
		end
	elseif (triggerList) then --if no boss found check for trigger to spawn
		local triggerStringData = triggerList[math.random(#triggerList)]

		if (data.spawnDelay) then
			createEvent(data.spawnDelay*1000,"WFboss","triggerSpawnEvent",pMob,triggerStringData)
		else
			spawnTriggerMobile(triggerStringData)
		end
	elseif (data.respawnTimer) then
		createEvent(respawnTimer*1000,"WFboss","triggerSpawnEvent",pMob,stringData)
	end
	return 0
end

--default respawn event
function WFboss:triggerSpawnEvent(pMob, triggerStringData)
	spawnTriggerMobile(triggerStringData)
end

function WFboss:bossDead(pMob, pKiller)
	--print("*Running WFboss:bossDead ")
	local stringData = readStringData(SceneObject(pMob):getObjectID() .. ":stringData")
	local func = load('return '..stringData)
	local data = func()
	deleteStringData(SceneObject(pMob):getObjectID() .. ":stringData")
	SceneObject(pMob):cancelPendingTask("WFboss", "despawnBoss")
	SceneObject(pMob):addPendingTask(120000, "WFboss", "destroy")

	if (data.adds) then
		deleteData(SceneObject(pMob):getObjectID() .. ":WFbossPhase")
		SceneObject(pMob):cancelPendingTask("WFboss", "testBoss")
		local addString = readStringData(SceneObject(pMob):getObjectID() .. ":WFbossAddString")
		deleteStringData(SceneObject(pMob):getObjectID() .. ":WFbossAddString")
		if (data.scaled) then
			deleteStringData(SceneObject(pMob):getObjectID() .. ":ScaledRespawn")
			WFboss:cleanupAdds(addString,true)
		else
			WFboss:cleanupAdds(addString)
		end
	end

	if (data.leash) then 
		deleteStringData(SceneObject(pMob):getObjectID() .. ":WFbossLeashString")
		SceneObject(pMob):cancelPendingTask("WFboss", "leashTest")
	elseif (data.WFskills or data.taunts) then
		SceneObject(pMob):cancelPendingTask("WFboss", "leashTest")
	end

	if (data.deathEvent and (type(data.deathEvent)== "function")) then
		if not(data.deathEvent(pMob, pKiller, stringData)) then
			return 0
		end		
	end

	local bossList = false
	local triggerList = false
	if (data.bossStringData) then --test for boss and trigger pointers
		if (data.triggerStringData) then
			if (math.random(100)>50) then -- if both pick one randomly
				bossList = HelperFuncs:splitString(data.bossStringData, "/")
			else
				triggerList = HelperFuncs:splitString(data.triggerStringData, "/")
			end
		else --only boss
			bossList = HelperFuncs:splitString(data.bossStringData, "/")
		end
	elseif (data.triggerStringData) then --only trigger
		triggerList = HelperFuncs:splitString(data.triggerStringData, "/")
	end

	if (bossList) then --test for and spawn boss
		local bossStringData = bossList[math.random(#bossList)]
		if (data.spawnDelay) then
			createEvent(data.spawnDelay*1000,"WFboss","bossSpawnEvent",pMob,bossStringData)
		else
			spawnBossMobile(bossStringData)
		end
	elseif (triggerList) then --if no boss found check for trigger to spawn
		local triggerStringData = triggerList[math.random(#triggerList)]
		if (data.spawnDelay) then
			createEvent(data.spawnDelay*1000,"WFboss","triggerSpawnEvent",pMob,triggerStringData)
		else
			spawnTriggerMobile(triggerStringData)
		end
	elseif (data.respawnTimer) then --else spawn self
		createEvent(data.respawnTimer*1000,"WFboss","bossSpawnEvent",pMob,stringData)
	end
	return 0
end

function WFboss:bossSpawnEvent(pMob, bossStringData)
	spawnBossMobile(bossStringData)
end

function WFboss:cleanupAdds(addString,boolScaled)
	local addList = HelperFuncs:splitString(addString, "/")
	foreach(addList, function(pAdd)
		local add = getSceneObject(pAdd)
		if (SceneObject(add)) then
			SceneObject(add):addPendingTask(getRandomNumber(400,500)*100, "WFboss", "destroy")
			if (boolScaled) then
				deleteStringData(SceneObject(add):getObjectID() .. ":ScaledRespawn")
			end
		end
	end)
	return 0
end

function WFboss:destroy(pMob)
	if (SceneObject(pMob)) then
		forcePeace(pMob)
		SceneObject(pMob):destroyObjectFromWorld()
	end
	return 0
end

function WFboss:despawn(pMob)
	--print("*Running WFboss:despawn")
	if not(SceneObject(pMob)) then
		print("\nERROR: in WFboss:despawn, pMob is not a valid Scene Object\n")
		return 0
	end

	SceneObject(pMob):cancelPendingTask("WFboss", "despawn")
	if (CreatureObject(pMob):isInCombat()) then
		SceneObject(pMob):addPendingTask(10000, "WFboss", "despawn")
		return 0
	end

	if (CreatureObject(pMob):isDead()) then
		return
	end

	local stringData = readStringData(SceneObject(pMob):getObjectID() .. ":stringData")
	local func = load('return '..stringData)
	local data = func()
	deleteStringData(SceneObject(pMob):getObjectID() .. ":stringData")
	dropObserver(OBJECTDESTRUCTION, "WFboss", "triggerDead",pMob)

	if (data.leash) then 
		deleteStringData(SceneObject(pMob):getObjectID() .. ":WFbossLeashString")
		SceneObject(pMob):cancelPendingTask("WFboss", "leashTest")
	elseif (data.WFskills) then
		SceneObject(pMob):cancelPendingTask("WFboss", "leashTest")
	end

	if (data.scaled) then
		deleteStringData(SceneObject(pMob):getObjectID() .. ":ScaledRespawn")
	end


	if (data.despawnEvent) then
		if not(data.despawnEvent(pMob, stringData)) then
			return 0
		end
	end

	if (data.respawnTimer) then
		createEvent(data.respawnTimer*1000,"WFboss","triggerSpawnEvent",pMob,stringData)
	end

	forcePeace(pMob)
	SceneObject(pMob):destroyObjectFromWorld()
	return 0
end

function WFboss:despawnBoss(pMob)
	--print("*Running WFboss:despawnBoss")
	if not(SceneObject(pMob)) then
		print("\nERROR: in WFboss:despawnBoss, pMob is not a valid Scene Object\n")
		return 0
	end

	SceneObject(pMob):cancelPendingTask("WFboss", "despawnBoss")
	if (CreatureObject(pMob):isInCombat()) then
		SceneObject(pMob):addPendingTask(10000, "WFboss", "despawnBoss")
		return 0
	end

	if (CreatureObject(pMob):isDead()) then
		return
	end

	local stringData = readStringData(SceneObject(pMob):getObjectID() .. ":stringData")
	local func = load('return '..stringData)
	local data = func()

	if (data.leash) then 
		deleteStringData(SceneObject(pMob):getObjectID() .. ":WFbossLeashString")
		SceneObject(pMob):cancelPendingTask("WFboss", "leashTest")
	elseif (data.WFskills or data.taunts) then
		SceneObject(pMob):cancelPendingTask("WFboss", "leashTest")
	end
	deleteStringData(SceneObject(pMob):getObjectID() .. ":stringData")
	dropObserver(OBJECTDESTRUCTION, "WFboss", "bossDead",pMob)

	if (data.adds) then
		deleteData(SceneObject(pMob):getObjectID() .. ":WFbossPhase")
		SceneObject(pMob):cancelPendingTask("WFboss", "testBoss")
		local addString = readStringData(SceneObject(pMob):getObjectID() .. ":WFbossAddString")
		deleteStringData(SceneObject(pMob):getObjectID() .. ":WFbossAddString")
		if (data.scaled) then
			deleteStringData(SceneObject(pMob):getObjectID() .. ":ScaledRespawn")
			WFboss:cleanupAdds(addString,true)
		else
			WFboss:cleanupAdds(addString)
		end
	elseif (data.scaled) then
		deleteStringData(SceneObject(pMob):getObjectID() .. ":ScaledRespawn")
	end

	if (data.despawnEvent) then
		if not(data.despawnEvent(pMob, stringData)) then
			return 0
		end
	end

	if (data.respawnTimer) then
		createEvent(data.respawnTimer*1000, "WFboss","bossSpawnEvent", pMob, stringData)
	elseif (data.triggerStringData) then
		local delay = data.respawnDelay or 30000
		createEvent(delay, "WFboss", "triggerSpawnEvent", pMob, data.triggerStringData)
	end

	forcePeace(pMob)
	SceneObject(pMob):destroyObjectFromWorld()
end

function WFboss:testBoss(pBoss, pPlayer)
	SceneObject(pBoss):cancelPendingTask("WFboss", "testBoss")
	if not(CreatureObject(pBoss) or CreatureObject(pPlayer)) then
		return 0
	end

	local boss = LuaCreatureObject(pBoss)
	local stringData = readStringData(SceneObject(pBoss):getObjectID() .. ":stringData")
	local func = load('return '..stringData)
	local data = func()
	if (data == nil) then return 0 end
	local x = boss:getPositionX()
	local y = boss:getPositionY()
	local z = boss:getPositionZ()

	if (data.leash) then
		local wpString = readStringData(SceneObject(pBoss):getObjectID() .. ":WFbossLeashString")
		local wp = HelperFuncs:splitString(wpString, "/") --Split WP-table from string
		wp = tableToNum(wp)
		if (SceneObject(pBoss):getDistanceToPosition(wp[1], wp[2], wp[3]) > wp[4]) then
			WFboss:leashCorrection(pBoss, wp[1],wp[2],wp[3],wp[4])
		end
	end

	if (CreatureObject(pBoss):isInCombat() and data.taunts) then
		local randAction = getRandomNumber(10)
		if (randAction > 8) then
			if (CreatureObject(pBoss):checkCooldownRecovery("WFbossTaunt")) then
				local taunt = data.taunts[math.random(#data.taunts)]
				spatialChat(pBoss, taunt)
				CreatureObject(pBoss):addCooldown("WFbossTaunt",getRandomNumber(300,400)*100)
			end
		end

		if (data.WFskills) then
			if(randAction < 4 and (CreatureObject(pBoss):checkCooldownRecovery("WFbossSkill"))) then
				local skill = data.WFskills[math.random(#data.WFskills)]
				skill(pBoss)
				CreatureObject(pBoss):addCooldown("WFbossSkill",getRandomNumber(250,300)*100)
			end	
		end
	end
	if (data.adds) then
		local phases = #data.adds
		local phase = readData(SceneObject(pBoss):getObjectID() .. ":WFbossPhase")
		if (phase >= phases) then --conserve process power if boss is at max phase allready
			if (data.leash or data.taunts or data.WFskills) then
				SceneObject(pBoss):addPendingTask(getRandomNumber(5,10)*1000, "WFboss", "leashTest")--test every 5s-10s
				return 0
			else --exit test loop, no more tests to run
				return 0
			end
		end

		local frag = 1 - (phase+1)*(1 / (phases + 1))
		if (CreatureObject(pBoss):isInCombat() and ((boss:getHAM(0) <= (boss:getMaxHAM(0)*frag)) or
 (boss:getHAM(3) <= (boss:getMaxHAM(3)*frag)) or (boss:getHAM(6) <= (boss:getMaxHAM(6)*frag)))) then
			--#SubType, event, #toSpawn, #range, spawns1,..spawn3
			phase = phase + 1
			writeData(SceneObject(pBoss):getObjectID() .. ":WFbossPhase",phase)

			local addTable = data.adds[phase]
			local p = SceneObject(pBoss):getZoneName()
			local addList = HelperFuncs:splitString(addTable[5], "/") --Split Spawn-List from string
			local t
			local c = SceneObject(pBoss):getParentID()
			local range = addTable[4] or 0
			local i = 0
			local tmpStr = readStringData(SceneObject(pBoss):getObjectID() .. ":WFbossAddString")
			local str = ""
			if (addTable[1] == 21) then
				--allow function to pass back addTable for processed spawning
				addTable = addTable[2](pBoss, stringData, str)
			end
			if (addTable[1] < 20) then
				local DDlist = CreatureObject(pBoss):getDamageDealerList()
				if ((addTable[1] == 0) or (addTable[1] == 10)) then
					repeat
						i = i + 1
						t = addList[math.random(#addList)]
						if (range > 0) then
							x = WFnav:rndRng(x, range)
							y = WFnav:rndRng(y, range)
						end
						if (c == 0) then 
							z = WFnav:getZ(p,x,y)
						end
						if (data.scaled and (addTable[1] == 0)) then
							local sc = data.scaled
							pAdd = spawnScaledMobile(p,t,-1,x,z,y,math.random(360),c, sc[1], sc[2], sc[3])
						else
							pAdd = spawnMobile(p,t,-1,x,z,y,math.random(360),c)
						end
						CreatureObject(pAdd):engageCombat(DDlist[math.random(#DDlist)])
						str = str..tostring(SceneObject(pAdd):getObjectID()).."/"
					until (i >= addTable[3])
				elseif ((addTable[1] == 1) or (addTable[1] == 11)) then
					repeat
						i = i + 1
						t = addList[i]
						local count = 0
						repeat
							count = count + 1
							if (range > 0) then
								x = WFnav:rndRng(x, range)
								y = WFnav:rndRng(y, range)
							end
							if (c == 0) then 
								z = WFnav:getZ(p,x,y)
							end
							if (data.scaled and (addTable[1] == 1)) then
								local sc = data.scaled
								pAdd=spawnScaledMobile(p,t,-1,x,z,y,math.random(360),c,sc[1],sc[2],sc[3])
							else
								pAdd = spawnMobile(p,t,-1,x,z,y,math.random(360),c)
							end
							CreatureObject(pAdd):engageCombat(DDlist[math.random(#DDlist)])
							str = str..tostring(SceneObject(pAdd):getObjectID()).."/"
						until (count >= addTable[3])
					until (i >= #addList)
				end
				if (type(addTable[2]) == "function") then --check for and run add spawn event
					local evStr = addTable[2](pBoss, stringData, str)
					if (evStr ~= nil) then
						str = evStr
					end
				end
			elseif (addTable[1] == 20) then
				local tmp = {p,x,z,y,c}
				local evStr = addTable[2](pBoss, stringData, addTable, tmp)
				if (evStr ~= nil) then
					str = evStr
				end
			else
				return 0
			end
			tmpStr = tmpStr..str
			writeStringData(SceneObject(pBoss):getObjectID() .. ":WFbossAddString", tmpStr)
			--Attempt a taunt each time adds fire
			if (data.taunts and CreatureObject(pBoss):checkCooldownRecovery("WFbossTaunt")) then
				local taunt = data.taunts[math.random(#data.taunts)]
				spatialChat(pBoss, taunt)
				CreatureObject(pBoss):addCooldown("WFbossTaunt",getRandomNumber(300,400)*100)
			end
		end
		SceneObject(pBoss):addPendingTask(getRandomNumber(50,100)*100, "WFboss", "testBoss")--test boss every 5s-10s
	end
	return 0
end

function WFboss:leashCorrection(pMob, x,z,y, leashRange)
	local DDlist = CreatureObject(pMob):getDamageDealerList()
	local closeCreature = false
	foreach(DDlist, function(pCreo)
		if (CreatureObject(pCreo)) then
			if (SceneObject(pCreo):getDistanceToPosition(x,z,y) > leashRange - 1) then
				AiAgent(pMob):removeDefender(pCreo)
 				AiAgent(pMob):addDefender(pCreo)
			else
				closeCreature = true
			end
		end
	end) 
	if not(closeCreature) then
		AiAgent(pMob):leash() --resets to home location and clears dots/ starts recovery
		for i = 0, 6, 3 do --Heal 20% MaxHAM
			CreatureObject(pMob):setHAM(i,(CreatureObject(pMob):getHAM(i) + (CreatureObject(pMob):getMaxHAM(i)*.2)))
		end
		for i = 0, 8 do --Heal Wounds
			CreatureObject(pMob):setWounds(i, 0)
		end
	end
	return 0
end

function WFboss:leashTest(pMob)
	SceneObject(pMob):cancelPendingTask("WFboss", "leashTest")
	local stringData = readStringData(SceneObject(pMob):getObjectID() .. ":stringData")
	local func = load('return '..stringData)
	local data = func()
	local wp = false
	if (data.leash) then
		local wpString = readStringData(SceneObject(pMob):getObjectID() .. ":WFbossLeashString")
		wp = HelperFuncs:splitString(wpString, "/") --Split WP-table from string
		wp = tableToNum(wp)
	end

	if (wp and (SceneObject(pMob):getDistanceToPosition(wp[1],wp[2],wp[3]) > wp[4])) then --test leash
		WFboss:leashCorrection(pMob, wp[1],wp[2],wp[3],wp[4]) --correct leash
	elseif (CreatureObject(pMob):isInCombat()) then --test combat actions
		local randAction = getRandomNumber(10)
		if (data.taunts) then
			if (randAction > 8) then
				if (CreatureObject(pMob):checkCooldownRecovery("WFbossTaunt")) then
					local taunt = data.taunts[math.random(#data.taunts)]
					spatialChat(pMob, taunt)
					CreatureObject(pMob):addCooldown("WFbossTaunt",getRandomNumber(300,400)*100)
				end
			end
		end
		if (data.WFskills) then
			if(randAction < 4) then
				local skill = data.WFskills[math.random(#data.WFskills)]
				skill(pMob)
				CreatureObject(pMob):addCooldown("WFbossSkill",getRandomNumber(250,300)*100)
			end	
		end
	end
	SceneObject(pMob):addPendingTask(getRandomNumber(5,10)*1000, "WFboss", "leashTest")--test boss every 5s-10s
end

--***************************************** ( Boss Tools ) *****************************************

function WFspawnMobile(stringData, returnType) --returnType: 1 = spawn, 2 = trigger, 3 = boss
	local data
	local func
	if (type(stringData) == "table") then --make sure data is in table format
		data = stringData
		if not(data.stringData) then
			print("\nERROR: in spawnTriggerMobile, expected stringData in table for triggerData\n")
			return
		end
	elseif (type(stringData) == "string") then
		func = load('return '..stringData)
		data = func()
		if not(type(data)=="table") then
			print("\nERROR: in spawnTriggerMobile, expected type(table) got type: "..type(data).." for triggerData\n")
			return
		elseif not(data.stringData) then
			print("\nERROR: in spawnTriggerMobile, expected stringData in table for triggerData\n")
			return
		end
	else
		print("\nERROR: in spawnTriggerMobile, expected type(table or string) got type: "..type(data).." for triggerData\n")
	end

	local wpList
	if (type(data.wpList) == "table") then --make sure wpList is in table format
		wpList = data.wpList
	elseif (type(data.wpList) == "string") then
		func = load('return '..data.wpList)
		wpList = func()
		if not(type(wpList)=="table") then
			print("\nERROR: in spawnTriggerMobile, expected type(table) got type: "..type(wpList).." for wpList\n")
			return
		end
	else
		print("\nERROR: in spawnTriggerMobile, expected type(table or string) got type: "..type(data).." for wpList\n")
	end

	local way
	if (type(wpList[1]) =="table") then --check to see if its a table of waypoints or single point
		way = wpList[math.random(#wpList)]
	else
		way = wpList
		wpList = false
	end

	local range = false
	if (way[7] and (way[7]>0))then -- if spawn range value found in wp table
		range = way[7]
	elseif (data.spawnRange and (data.spawnRange>0)) then -- if a default spawn range was given
		range = data.spawnRange
	end
	
	local x = way[2]
	local z = way[3]
	local y = way[4]
	local pMob
	if (data.scaled) then -- if mobile should be scaled
		local st = data.scaled[1]
		local sf = data.scaled[2]
		local sr = data.scaled[3]
		pMob = spawnScaledMobile(way[1],data.spawnList,0,x,way[3],y,way[5],way[6], st, sf, sr)
	else --spawn normally (do not scale)
		if (range) then -- if spawn range specified
			x = x-range+(math.random(range*200)*.01)
			y = y-range+(math.random(range*200)*.01)
		end

		if (way[6] == 0) then --if open world get adjusted z
			z = WFnav:getZ(way[1],x,y) --get adjusted z from nav system
		end

		local t -- Get template to spawn
		if(type(data.spawnList)=="table")then
			t = data.spawnList[math.random(#data.spawnList)]
		else
			local spawnList = HelperFuncs:splitString(data.spawnList, "/") --Split Spawn-List from string
			t = spawnList[math.random(#spawnList)]
		end

		pMob = spawnMobile(way[1],t,0,x,z,y,way[5],way[6])
		if (data.aiTemplate) then
			AiAgent(pMob):setAiTemplate("")
			--AiAgent(pMob):setAiTemplate(data.aiTemplate)
		end
	end

	if (data.spawnEvent) then --check for and run spawn event
		if not(data.spawnEvent(pMob)) then --test if code should continue on
			return pMob
		end
	end

	if (data.leash) then
		local wpString = tostring(x).."/"..tostring(z).."/"..tostring(y).."/"..tostring(data.leash)
		writeStringData(SceneObject(pMob):getObjectID() .. ":WFbossLeashString",wpString)
	end

	if (returnType ~= 3) then
		if (data.leash or data.WFskills) then
			SceneObject(pMob):addPendingTask(getRandomNumber(5,10)*1000, "WFboss", "leashTest")--test trigger every 5s-10s
		end
		createObserver(OBJECTDESTRUCTION, "WFboss", "triggerDead",pMob)
	else
		createObserver(OBJECTDESTRUCTION, "WFboss", "bossDead",pMob)
	end

	if (data.despawn and (data.despawn>0)) then --check for if mobile should despawn and add task if so
		if (returnType == 3) then
			SceneObject(pMob):addPendingTask(data.despawn * 1000, "WFboss", "despawnBoss")
		else
			SceneObject(pMob):addPendingTask(data.despawn * 1000, "WFboss", "despawn")
		end
	end

	writeStringData(SceneObject(pMob):getObjectID() .. ":stringData", data.stringData)
	return pMob
end

function spawnTriggerMobile(stringData)
	WFspawnMobile(stringData, 2)
end

function spawnBossMobile(stringData)
	local pMob = WFspawnMobile(stringData, 3)
	if not(pMob) then
		print("\nERROR: in spawnBossMobile, invalid mobile returned")
		return false
	end

	local func = load('return '..stringData)
	local data = func()
	if (data.adds) then --Check boss for an Add-Table
		writeData(SceneObject(pMob):getObjectID() .. ":WFbossPhase", 0)
		if (data.addEvent) then --check for and run add event
			if not(data.addEvent(pMob)) then --test if code should continue on
				return pMob
			end
		end
		SceneObject(pMob):addPendingTask(getRandomNumber(5,10)*1000, "WFboss", "testBoss")--test boss every 5s-10s
	elseif (data.leash or data.taunts or data.WFskills) then
		SceneObject(pMob):addPendingTask(getRandomNumber(5,10)*1000, "WFboss", "leashTest")--test boss every 5s-10s
	end

	if (data.intro) then
		spatialChat(pMob, data.intro)
		CreatureObject(pMob):addCooldown("WFbossTaunt",getRandomNumber(300,400)*100)
	end

	if (data.broadcast) then
		broadcastGalaxy(data.broadcast)
	end
	return pMob
end
