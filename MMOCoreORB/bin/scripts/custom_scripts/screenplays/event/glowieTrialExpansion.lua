--[[
	GLOWIE-QUEST: NEW SPAWN LOCATIONS

	{-926,-2058} <--blue leaf RND1
	{-842,-2153} <--blue leaf RND2
	{-737,-2063} <--blue leaf imp
	{-812,-1979} <--blue leaf reb

	{-3161,-3157} <--Massassi RND1
	{-2896,-2778} <--Massassi RND2
	{-2846,-3103} <--Massassi imp
	{-3176,-2787} <--Massassi reb

	{5099,5538} <--exar RND1
	{5004,5679} <--exar RND2
	{4994,5522} <--exar imp
	{5183,5552} <--exar reb
]]

--WFboss Driven Screenplay and Boss spawn Tables
glowieTrialExpansion = ScreenPlay:new {
	screenplayName = "glowieTrialExpansion", --add screenplay name for squad control.
	impBoss = {
		stringData = "glowieTrialExpansion.impBoss",
		spawnList = "glowie_imp_a/glowie_imp_b/glowie_imp_c",
		aiTemplate = true,
		wpList = {	--{Planet, X, Z, Y, Facing direction, Cell id, RaNGe}
			{"yavin4", -737, 70, -2063, math.random(360), 0, 3}, --blue leaf
			{"yavin4", -2846, 70, -3103, math.random(360), 0, 3}, --Massassi
			{"yavin4", 4994, 70, 5522, math.random(360), 0, 3}, --exar
		},
		despawn = 3600,
		respawnTimer = 600,
		leash = 70,
		adds = { 	--{SubType, Event, #toSpawn, spawnRange, template/list}
			{10,false, 2, 4, "fbase_scout_trooper/fbase_stormtrooper_captain"},
			{11,false, 2, 4, "fbase_scout_trooper/fbase_stormtrooper_captain"},
		},
		taunts = {
			"Where is your rebellion now?","Lord Vader will be pleased","For the Empire!","Long live the emperor!",
		},
	},

	rebBoss = {
		stringData = "glowieTrialExpansion.rebBoss",
		spawnList = "glowie_reb_a/glowie_reb_b/glowie_reb_c",
		aiTemplate = true,
		wpList = {	--{Planet, X, Z, Y, Facing direction, Cell id, RaNGe}
			{"yavin4", -812, 70, -1979, math.random(360), 0, 3}, --blue leaf
			{"yavin4", -3176, 70, -2787, math.random(360), 0, 3}, --Massassi
			{"yavin4", 5183, 70, 5552, math.random(360), 0, 3}, --exar
		},
		despawn = 3600,
		respawnTimer = 600,
		leash = 70,
		adds = { 	--{SubType, Event, #toSpawn, spawnRange, template/list}
			{10,false, 2, 4, "fbase_rebel_army_captain/fbase_rebel_army_captain_hard"},
			{11,false, 2, 4, "fbase_rebel_army_captain/fbase_rebel_army_captain_hard"},
		},
		taunts = {
			"Your aim is aweful!", "You smell bantha?", "Good day to kill the empire.", "Does the Emperor dress you?",
		},
	},

		--WP List for Random Faction Chain #1
	wpList1 = {	--{Planet, X, Z, Y, Facing direction, Cell id, RaNGe}
		{"yavin4", -926, 84, -2058, math.random(360), 0, 3}, --blue leaf
		{"yavin4", -3161, 70, -3157, math.random(360), 0, 3}, --Massassi
		{"yavin4", 5099, 70, 5538, math.random(360), 0, 3}, --exar
	},

	neutBoss1 = {
		stringData = "glowieTrialExpansion.neutBoss1",
		spawnList = "dark_jedi_sentinel/dark_jedi_knight/enhanced_gaping_spider",
		aiTemplate = true,
		bossStringData = "glowieTrialExpansion.impBoss1/glowieTrialExpansion.rebBoss1",
		wpList = "glowieTrialExpansion.wpList1",
		despawn = 3600,
		respawnTimer = 600,
		spawnDelay = 600,
		leash = 70,
		adds = { 	--{SubType, Event, #toSpawn, spawnRange, template/list}
			{10,false, 2, 4, "cavern_spider/gaping_spider_hunter"},
			{11,false, 2, 4, "cavern_spider/gaping_spider_hunter"},
		},
		taunts = {
			"I will kill you!", "Ready to run yet?", "You will die.", "Do you wish to harm me?",
		},
	},

	impBoss1 = {
		stringData = "glowieTrialExpansion.impBoss1",
		spawnList = "glowie_imp_a/glowie_imp_b/glowie_imp_c",
		aiTemplate = true,
		bossStringData = "glowieTrialExpansion.neutBoss1/glowieTrialExpansion.rebBoss1",
		wpList = "glowieTrialExpansion.wpList1",
		despawn = 3600,
		respawnTimer = 600,
		spawnDelay = 600,
		leash = 70,
		adds = { 	--{SubType, Event, #toSpawn, spawnRange, template/list}
			{10,false, 2, 4, "fbase_scout_trooper/fbase_stormtrooper_captain"},
			{11,false, 2, 4, "fbase_scout_trooper/fbase_stormtrooper_captain"},
		},
		taunts = {
			"Where is your rebellion now?","Lord Vader will be pleased","For the Empire!","Long live the emperor!",
		},
	},

	rebBoss1 = {
		stringData = "glowieTrialExpansion.rebBoss1",
		spawnList = "glowie_reb_a/glowie_reb_b/glowie_reb_c",
		aiTemplate = true,
		bossStringData = "glowieTrialExpansion.impBoss1/glowieTrialExpansion.neutBoss1",
		wpList = "glowieTrialExpansion.wpList1",
		despawn = 3600,
		respawnTimer = 600,
		spawnDelay = 600,
		leash = 70,
		adds = { 	--{SubType, Event, #toSpawn, spawnRange, template/list}
			{10,false, 2, 4, "fbase_rebel_army_captain/fbase_rebel_army_captain_hard"},
			{11,false, 2, 4, "fbase_rebel_army_captain/fbase_rebel_army_captain_hard"},
		},
		taunts = {
			"Your aim is aweful!", "You smell bantha?", "Good day to kill the empire.", "Does the Emperor dress you?",
		},
	},

		--WP List for Random Faction Chain #2
	wpList2 = {	--{Planet, X, Z, Y, Facing direction, Cell id, RaNGe}
		{"yavin4", -842, 70, -2153, math.random(360), 0, 3}, --blue leaf
		{"yavin4", -2896, 70, -2778, math.random(360), 0, 3}, --Massassi
		{"yavin4", 5004, 70, 5679, math.random(360), 0, 3}, --exar
	},

	neutBoss2 = {
		stringData = "glowieTrialExpansion.neutBoss2",
		spawnList = "dark_jedi_sentinel/dark_jedi_knight/enhanced_gaping_spider",
		aiTemplate = true,
		bossStringData = "glowieTrialExpansion.impBoss2/glowieTrialExpansion.rebBoss2",
		wpList = "glowieTrialExpansion.wpList2",
		despawn = 3600,
		respawnTimer = 600,
		spawnDelay = 600,
		leash = 70,
		adds = { 	--{SubType, Event, #toSpawn, spawnRange, template/list}
			{10,false, 2, 4, "cavern_spider/gaping_spider_hunter"},
			{11,false, 2, 4, "cavern_spider/gaping_spider_hunter"},
		},
		taunts = {
			"You cannot harm me!", "Ready to submit?", "You are weak.", "Do you wish to die?",
		},
	},

	impBoss2 = {
		stringData = "glowieTrialExpansion.impBoss2",
		spawnList = "glowie_imp_a/glowie_imp_b/glowie_imp_c",
		aiTemplate = true,
		bossStringData = "glowieTrialExpansion.neutBoss2/glowieTrialExpansion.rebBoss2",
		wpList = "glowieTrialExpansion.wpList2",
		despawn = 3600,
		respawnTimer = 600,
		spawnDelay = 600,
		leash = 70,
		adds = { 	--{SubType, Event, #toSpawn, spawnRange, template/list}
			{10,false, 2, 4, "fbase_scout_trooper/fbase_stormtrooper_captain"},
			{11,false, 2, 4, "fbase_scout_trooper/fbase_stormtrooper_captain"},
		},
		taunts = {
			"Where is your rebellion now?","Lord Vader will be pleased","For the Empire!","Long live the emperor!",
		},
	},

	rebBoss2 = {
		stringData = "glowieTrialExpansion.rebBoss2",
		spawnList = "glowie_reb_a/glowie_reb_b/glowie_reb_c",
		aiTemplate = true,
		bossStringData = "glowieTrialExpansion.impBoss2/glowieTrialExpansion.neutBoss2",
		wpList = "glowieTrialExpansion.wpList2",
		despawn = 3600,
		respawnTimer = 600,
		spawnDelay = 600,
		leash = 70,
		adds = { 	--{SubType, Event, #toSpawn, spawnRange, template/list}
			{10,false, 2, 4, "fbase_rebel_army_captain/fbase_rebel_army_captain_hard"},
			{11,false, 2, 4, "fbase_rebel_army_captain/fbase_rebel_army_captain_hard"},
		},
		taunts = {
			"Your aim is aweful!", "You smell bantha?", "Good day to kill the empire.", "Does the Emperor dress you?",
		},
	},
}
registerScreenPlay("glowieTrialExpansion", true)

function glowieTrialExpansion:start()
	spawnBossMobile("glowieTrialExpansion.impBoss")
	spawnBossMobile("glowieTrialExpansion.rebBoss")
	spawnBossMobile("glowieTrialExpansion.neutBoss1")
	spawnBossMobile("glowieTrialExpansion.neutBoss2")
end

function glowieTrialExpansion.impBoss.deathEvent(pBoss, pKiller)
 	spatialChat(pBoss, "The Empire will crush your rebellion "..CreatureObject(pKiller):getFirstName().."!")
	glowieTrialExpansion:looted(pBoss,pKiller)
	return 0
end

function glowieTrialExpansion.impBoss1.deathEvent(pBoss, pKiller)
 	spatialChat(pBoss, "The Empire will crush your rebellion "..CreatureObject(pKiller):getFirstName().."!")
	glowieTrialExpansion:looted(pBoss,pKiller)
	return 0
end

function glowieTrialExpansion.impBoss2.deathEvent(pBoss, pKiller)
 	spatialChat(pBoss, "The Empire will crush your rebellion "..CreatureObject(pKiller):getFirstName().."!")
	glowieTrialExpansion:looted(pBoss,pKiller)
	return 0
end

function glowieTrialExpansion.rebBoss.deathEvent(pBoss, pKiller)
 	spatialChat(pBoss, "The Rebels will crush your Empire "..CreatureObject(pKiller):getFirstName().."!")
	glowieTrialExpansion:looted(pBoss,pKiller)
	return 0
end

function glowieTrialExpansion.rebBoss1.deathEvent(pBoss, pKiller)
 	spatialChat(pBoss, "The Rebels will crush your Empire "..CreatureObject(pKiller):getFirstName().."!")
	glowieTrialExpansion:looted(pBoss,pKiller)
	return 0
end

function glowieTrialExpansion.rebBoss2.deathEvent(pBoss, pKiller)
 	spatialChat(pBoss, "The Rebels will crush your Empire "..CreatureObject(pKiller):getFirstName().."!")
	glowieTrialExpansion:looted(pBoss,pKiller)
	return 0
end

function glowieTrialExpansion.neutBoss1.deathEvent(pBoss, pKiller)
 	spatialChat(pBoss, "This is not the last you have seen of me "..CreatureObject(pKiller):getFirstName().."!")
	glowieTrialExpansion:looted(pBoss,pKiller)
	return 0
end

function glowieTrialExpansion.neutBoss2.deathEvent(pBoss, pKiller)
 	spatialChat(pBoss, "Others will come for you "..CreatureObject(pKiller):getFirstName().."!")
	glowieTrialExpansion:looted(pBoss,pKiller)
	return 0
end

function glowieTrialExpansion:looted(pBoss,pPlayer)
	if (CreatureObject(pBoss):isNeutral() or CreatureObject(pPlayer):isNeutral()) then
		return 0 --If Killer or NPC are Neutral skip tests
	end
	if (CreatureObject(pBoss):getFaction() ~= CreatureObject(pPlayer):getFaction()) then
		local bossName = SceneObject(pBoss):getDisplayedName()
		if (CreatureObject(pPlayer):isImperial()) then --Player is Imperial
			if (bossName ==  "Master Zhi") then
				bf_tools:rewardGroupAll(pPlayer,"screenplay",8,"glowie_expansion_quest_kills",4,"imperial")
			elseif (bossName ==  "Triv Eno") then
				bf_tools:rewardGroupAll(pPlayer,"screenplay",4,"glowie_expansion_quest_kills",2 ,"imperial")
			elseif ( bossName == "Sal Boca") then --reb a
				bf_tools:rewardGroupAll(pPlayer,"screenplay",2,"glowie_expansion_quest_kills",{64,"glowie_expansion_quest"},"imperial")
			end
		else
			if (bossName ==  "Inquisitor Sihv") then --Player is Rebel
				bf_tools:rewardGroupAll(pPlayer,"screenplay",64,"glowie_expansion_quest_kills",32,"rebel")
			elseif (bossName ==  "Agent Kayn") then
				bf_tools:rewardGroupAll(pPlayer,"screenplay",32,"glowie_expansion_quest_kills",16,"rebel")
			elseif ( bossName == "Commander Larn" ) then --imp a
				bf_tools:rewardGroupAll(pPlayer,"screenplay",16,"glowie_expansion_quest_kills",{64,"glowie_expansion_quest"},"rebel")
			end
		end
	end
	return 0
end
