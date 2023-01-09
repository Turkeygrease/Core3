--[[ By: Michael Simnitt aka Mindsoft
Date: Sep/19/2018
Description: Boss tables for WFboss system utilized in WorldBossSpawner handler to spawn planetary/city bosses.
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]

tatooine_bosses = ScreenPlay:new{
	worldBoss = { --Tatooine world Boss
		stringData = "tatooine_bosses.eisleyCityBoss",
		spawnList = "darth_krayt",
		wpList = {"tatooine", -2979, 5, 1969, 76, 0, 1},
		despawn = 1200,
		spawnEvent = function () tatWorldBossSp:start(); return true end,
		despawnEvent = function(a,b) return worldBossSpawner:despawnWorldBoss(a,b) end,
		leash = 70,
		adds = { 	
			{0,false, 6, 4, "bh_tusken_carnage_champion/tusken_witch_doctor/tusken_raider"},
			{0,false, 2, 4, "bh_tusken_carnage_champion/tusken_witch_doctor/tusken_raider"},
			{0,false, 4, 4, "bh_tusken_carnage_champion/tusken_witch_doctor/tusken_raider"},
			{0,false, 4, 4, "bh_tusken_carnage_champion/tusken_witch_doctor/tusken_raider"},
			{0,false, 8, 4, "bh_tusken_carnage_champion/tusken_witch_doctor/tusken_raider"},
		},
		taunts = {
			"The force Abandons you!","You think you are a Jedi?","Victory is Mine!","Your armor is soft.",
			"You will fall to me!","Did you really think you could defeat me?","You will suffer..",
		},
		intro = "I will destroy you for harming my pet!",
		broadcast = "Tatooine world boss has spawned!",
		WFskills = {WFskills.areaKD,WFskills.areaKD2,WFskills.areaPoison},
	},

	eisleyCityBoss = { --Mos Eisley City Boss
		stringData = "tatooine_bosses.eisleyCityBoss",
		spawnList = "krayt_disciple_a",
		wpList = {"tatooine", 3251, 5, -4879, 40, 0, 0}, -- {p, x, z, y, dir, cell, rng }
		despawn = 1200,
		despawnEvent = function(a,b) return worldBossSpawner:despawnBoss(a,b) end, 
		leash = 70,
		adds = { --subType, event, spawnCount, spawnRange, addString
			{0,false, 8, 4, "tusken_raider"},
			{0,false, 4, 4, "tusken_raider/bh_tusken_carnage_champion/tusken_witch_doctor"},
			{0,false, 10, 4, "tusken_raider"},
			{0,false, 8, 4, "bh_tusken_carnage_champion/tusken_raider"},
		},
		taunts = {
			"Poodoo!","Rooo roo Wrooo! (cursing in Tusken)","This city is Mine!","Lord Krayt will rule here!",
			"Lord Krayt is coming..","You all will suffer..",
		},
		intro = "This city now belongs to lord Krayt!",
		broadcast = "Distress Message: Mos Eisley is under attack!",
		WFskills = {WFskills.areaKD,WFskills.areaKD2,WFskills.areaPoison},
	},

	enthaCityBoss = { --Mos Entha City Boss
		stringData = "tatooine_bosses.enthaCityBoss",
		spawnList = "krayt_disciple_b",
		wpList = {"tatooine", 1435, 7, 3342, 1, 0, 0}, -- {p, x, z, y, dir, cell, rng }
		despawn = 1200,
		despawnEvent = function(a,b) return worldBossSpawner:despawnBoss(a,b) end, 
		leash = 70,
		adds = { --subType, event, spawnCount, spawnRange, addString
			{0,false, 8, 4, "tusken_raider"},
			{0,false, 4, 4, "tusken_raider/bh_tusken_carnage_champion/tusken_witch_doctor"},
			{0,false, 10, 4, "tusken_raider"},
			{0,false, 8, 4, "bh_tusken_carnage_champion/tusken_raider"},
		},
		taunts = {
			"Poodoo!","Rooo roo Wrooo! (cursing in Tusken)","This city is Mine!","Lord Krayt will rule here!",
			"Lord Krayt is coming..","You all will suffer..",
		},
		intro = "This city now belongs to lord Krayt!",
		broadcast = "Distress Message: Mos Entha is under attack!",
		WFskills = {WFskills.areaKD,WFskills.areaKD2,WFskills.areaPoison},
	},

	bestineCityBoss = { --Bestine City Boss
		stringData = "tatooine_bosses.bestineCityBoss",
		spawnList = "krayt_disciple_c",
		wpList = {"tatooine", -1087, 12, -3649, -45, 0, 0}, -- {p, x, z, y, dir, cell, rng }
		despawn = 1200,
		despawnEvent = function(a,b) return worldBossSpawner:despawnBoss(a,b) end, 
		leash = 70,
		adds = { --subType, event, spawnCount, spawnRange, addString
			{0,false, 8, 4, "tusken_raider"},
			{0,false, 4, 4, "tusken_raider/bh_tusken_carnage_champion/tusken_witch_doctor"},
			{0,false, 10, 4, "tusken_raider"},
			{0,false, 8, 4, "bh_tusken_carnage_champion/tusken_raider"},
		},
		taunts = {
			"Poodoo!","Rooo roo Wrooo! (cursing in Tusken)","This city is Mine!","Lord Krayt will rule here!",
			"Lord Krayt is coming..","You all will suffer..",
		},
		intro = "This city now belongs to lord Krayt!",
		broadcast = "Distress Message: Bestine is under attack!",
		WFskills = {WFskills.areaKD,WFskills.areaKD2,WFskills.areaPoison},
	},
}
registerScreenPlay("tatooine_bosses", false)
