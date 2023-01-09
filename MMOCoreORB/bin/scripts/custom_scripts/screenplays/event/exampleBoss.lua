--[[ By: Michael Simnitt aka Mindsoft
Date: Aug/30/2018
Description: Example Boss Mobile Event Screenplay
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]


---------------------------------------------(exampleBoss Event Screenplay & Spawn tables)
exampleBoss = ScreenPlay:new{
	waypoints1 = { --{Planet, X, Z, Y, Facing direction, Cell id, RaNGe}
		{"dathomir", -110, 18, -1658, math.random(360), 0, 7}, --multi-table format
		{"dathomir", -78, 18, -1667, math.random(360), 0, 7},
		{"dathomir", -36, 18, -1640, math.random(360), 0, 7},
		{"dathomir", -8, 18, -1596, math.random(360), 0, 7},
		{"dathomir", -43, 18, -1536, math.random(360), 0, 7},
		{"dathomir", -147, 18, -1556, math.random(360), 0, 7},		
	},

	togWp = {"dathomir", -125.3, 18, -1635.2, -85, 0},

	boss2 = {
		stringData = "exampleBoss.boss2",
		triggerStringData = "exampleBoss.trigger1",
		spawnList = "scalable_boss_a",
		wpList = {"dathomir", -110, 18, -1658, math.random(360), 0, 4},
		despawn = 900,
		spawnDelay = 300,
		leash = 30,
		adds = { 	
			{0,WFadds.addTaunt, 1, 4, "scalable_add_a"},
			{0,WFadds.addTaunt, 2, 5, "scalable_add_a"},
			{0,WFadds.addTaunt, 1, 6, "scalable_add_a"},
			{0,WFadds.addTaunt, 2, 4, "scalable_add_a"},
		},
		taunts = {
			"The force Abandons you!","You think you are a Jedi?","Victory is Mine!","Your armor is soft.",
			"I will Avenge you, Abuhca","Did you really think you could defeat me?","You will suffer..",
		},
		intro = "I will destroy you for harming my pet!",
		broadcast = "Scaling World Boss has spawned @ Dathomir Science Outpost",
		WFskills = {WFskills.areaKD,WFskills.areaKD2,WFskills.areaPoison},
		scaled = {2,.08,80},
	},

	boss = {
		stringData = "exampleBoss.boss",
		triggerStringData = "exampleBoss.trigger1",
		bossStringData = "exampleBoss.boss2",
		spawnList = "boss_chuba",
		wpList = {"dathomir", -110, 18, -1658, math.random(360), 0, 3},
		despawn = 500,
		spawnDelay = 15,
		leash = 60,
		adds = { 	
			{10,false, 2, 7, "chuba/large_chuba"},
			{10,false, 6, 8, "flesh_eating_chuba/large_chuba"},
			{20,WFadds.generateTest, 16, 8, "flesh_eating_chuba/large_chuba/chuba"},
		},
		taunts = {
			"You will Fail!","Meh, that all you got?","Maybe your mom can hit harder?","weak...WEAK!",
			"The force calls for you to return..","Did you really think you could win?",
		},
	},

	trigger1 = {
		stringData = "exampleBoss.trigger1", --single item string pointer format
		triggerStringData = "exampleBoss.trigger1/exampleBoss.trigger2", --multi-item string pointer format (picks randomly)
		--bossStringData = "exampleBoss.boss", --single item string pointer format
		spawnList = "chuba", --single item string format
		wpList = "exampleBoss.waypoints1", --single item string pointer format
		spawnDelay = 15,
	},

	trigger2 = {
		stringData = "exampleBoss.trigger2", --single item string pointer format
		triggerStringData = "exampleBoss.trigger1/exampleBoss.trigger3", --multi-item string pointer format (picks randomly)
		spawnList = "large_chuba", --multi-item string format (picks randomly)
		wpList = "exampleBoss.waypoints1", --single item string pointer format
		spawnDelay = 15,
	},

	trigger3 = {
		stringData = "exampleBoss.trigger3", --single item string pointer format
		triggerStringData = "exampleBoss.trigger1/exampleBoss.trigger2", --multi-item string pointer format (picks randomly)
		bossStringData = "exampleBoss.boss", --single item string pointer format
		spawnList = "flesh_eating_chuba/large_chuba", --multi-item string format (picks randomly)
		wpList = "exampleBoss.waypoints1", --single item string pointer format
		spawnDelay = 15,
		scaled = {0,10,false}, --forced scale of 15
	},


	--Imperial / Rebel Toggle npc example
	togTrigger1 = {
		stringData = "exampleBoss.togTrigger1",
		spawnList = "imperial_trooper",
		triggerStringData = "exampleBoss.togTrigger2",
		wpList = "exampleBoss.togWp",
		spawnDelay = 300,
	},

	togTrigger2 = {
		stringData = "exampleBoss.togTrigger2",
		spawnList = "rebel_trooper",
		triggerStringData = "exampleBoss.togTrigger1",
		wpList = "exampleBoss.togWp",
		spawnDelay = 300,
	},
}
registerScreenPlay("exampleBoss", false)

function exampleBoss:start()
	spawnTriggerMobile("exampleBoss.trigger1")
	spawnTriggerMobile("exampleBoss.togTrigger1")
end
---------------------------------------------(Custom Events)
--custom death event example
function exampleBoss.boss.deathEvent(pMob, pKiller, stringData)
	--print("\n*Running exampleBoss:testTriggerDeathEvent")
	--("-Death event Trigger: "..tostring(pMob).." , Killer: "..tostring(pKiller).." , stringData: "..tostring(stringData))
	--YOUR CUSTOM CODE HERE
 	spatialChat(pMob, "Curse you "..CreatureObject(pKiller):getFirstName().."!\nAvenge Me master..")
	return true --return true to continue with default death code
end

--custom spawn event example (runs after mobile is spawned before observer is set)
function exampleBoss.boss.spawnEvent(pMob, triggerStringData)
	--print("\n*Running exampleBoss.trigger2.spawnEvent")
	--print("-Spawn event Trigger: "..tostring(pMob).." , stringData: "..tostring(stringData))
	--YOUR CUSTOM CODE HERE
 	spatialChat(pMob, "Prepare to die foolish creature..")
	return true --return true to continue with default spawn code
end

function exampleBoss.boss.despawnEvent(pMob, triggerStringData)
	createEvent(5000,"WFboss","triggerSpawnEvent",pMob,"exampleBoss.trigger1")
	SceneObject(pMob):destroyObjectFromWorld()
end

function exampleBoss.boss2.despawnEvent(pMob, triggerStringData)
	exampleBoss.boss.despawnEvent(pMob, triggerStringData)
end
