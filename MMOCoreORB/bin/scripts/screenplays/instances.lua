local instances = {
	corvette = {
		iff = "object/building/general/space_dungeon_corellian_corvette.iff",
		playerSpawn = {-42.9, 0, 0.1, 1}, -- x,z,y,cell#
		factionSpawns = {rebel = {}, imperial = {}, neutral = {}}, --if playerSpawn does not exist
		exitPoint = {"tatooine", 3516, 5, -4813, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	warRoom = {
		iff = "object/building/general/newbie_hall_skipped.iff",
		playerSpawn = {27.6, -4.2, -160, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3498, 5, -4800, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	ig88 = {
		iff = "object/building/heroic/ig88_factory_arena.iff",
		--iff = "object/building/mustafar/dungeon/old_republic_facility.iff",
		playerSpawn = {0, 0, 38, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3498, 5, -4800, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	axkva = {
		iff = "object/building/heroic/axkva_min_lair.iff",
		playerSpawn = {9, 0, 0, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3536, 5, -4830, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	exar = {
		iff = "object/building/heroic/exar_kun_tomb.iff",
		playerSpawn = {-11, 0, -123, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3523, 5, -4777, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
		groupType = "group", --"solo","group","open","guild"
		minPlayerCount = 3, --min players in group to enter instance
		maxPlayerCount = 8, --max players in group that can have this instance active
	},
	nova = {
		iff = "object/building/content/nova_orion_station/chapter_8_space_station_decorated.iff",
		playerSpawn = {14.1, -1, 0, 1},
		screenplay = "novaTestSP",
		zone = "dungeon1",
		groupType = "open",
	},
	nova2 = {
		iff = "object/building/general/space_dungeon_corellian_corvette.iff",--"object/building/content/nova_orion_station/chapter_8_space_station_decorated.iff",
		playerSpawn = {-42, 0, 0, 1},
		zone = "dungeon2",
		groupType = "open",
	},
	ddf = {
		iff = "object/building/mustafar/dungeon/decrepit_droid_factory.iff",
		playerSpawn = {0, 0, 5, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3503, 5, -4767, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	orf = {
		iff = "object/building/mustafar/dungeon/old_republic_facility.iff",
		playerSpawn = {6.7, 0, 1, 35}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3530, 5, -4823, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	wdf = {
		iff = "object/building/mustafar/dungeon/working_droid_factory.iff",
		playerSpawn = {0, 0, 3.2, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3530, 5, -4823, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	lotc = {
		iff = "object/building/mustafar/dungeon/obiwan_finale/lair_of_the_crystal.iff",
		playerSpawn = {0, 0, 5, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3503, 5, -4767, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	met = {
		iff = "object/building/mustafar/dungeon/escape_tunnel/must_escape_tunnel.iff",
		playerSpawn = {4.4, 0, 0.3, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3503, 5, -4767, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	lavaCave = {
		iff = "object/building/mustafar/dungeon/lava_cave/must_lava_cave.iff",
		playerSpawn = {-3.8, 0, 1.9, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3516, 5, -4813, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	uplink = {
		iff = "object/building/mustafar/dungeon/establish_uplink/uplink_cave.iff",
		playerSpawn = {-25, 2, -14, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3516, 5, -4813, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	ta = {
		iff = "object/building/heroic/tusken_army_controller.iff",
		playerSpawn = {23.9, 0, 0.2, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3503, 5, -4767, 0}, --p,x,z,y,cellID
		lockoutTimer = 30000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	test = {
		iff = {
		"object/building/general/association_hall_civilian_general.iff", --guildhall **
		--"object/building/general/association_hall_general.iff", --guildhall *
		--"object/building/general/bunker_allum_mine.iff", --deathwatch -
		"object/building/general/bunker_blacksun_outpost_01.iff", --blacksun bunker **
		--"object/building/general/bunker_crimelord_retreat_01.iff", --crimelord retreat bunker
		"object/building/general/bunker_imperial_01.iff", --imperial bunker 01 **
		"object/building/general/bunker_imperial_02.iff", --imperial bunker 02 **
		"object/building/general/bunker_imperial_03.iff", --imperial bunker 03 **
		"object/building/general/bunker_imperial_bunker_abandoned.iff", -- abondoned imperial bunker **
		"object/building/general/bunker_imperial_prison_01.iff", -- imperial prison 01 **
		--"object/building/corellia/ply_corl_house_s_s02_fp1.iff", --style 2 house -
		--"object/building/naboo/hangar_naboo_theed.iff", --theed hangar -
		},
		playerSpawn = {-2.7, 0, 10.3, 1}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3527, 5, -4785, 0}, --p,x,z,y,cellID
		lockoutTimer = 300000, --Building lockout/despawn timer
		screenplay = "myInstancePlayName", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
	},
	tatRanchHouse = {
		iff = "object/building/general/ranchers_house_tatooine.iff", --tatooine ranchers house **
		playerSpawn = {-0.7, .6, 10.4, 1},
		exitPoint = {"tatooine", 3527, 5, -4785, 0},
		lockoutTimer = 120000, --2 min lockout / cooldown
		zone = "dungeon1",
		lockedCells = {8}, -- upper balcony has cell location bug
		groupType = "solo",
	},
	isdtest = {
		iff = "object/building/general/space_dungeon_star_destroyer.iff",
		playerSpawn = {0, 172.3, 225, 1},
		exitPoint = {"tatooine", 3527, 5, -4785, 0},
		lockoutTimer = 300000, --2 min lockout / cooldown
		zone = "dungeon2",
		groupType = "solo",
	},
	impHeroicCloner = {
		iff = "object/building/military/wf_imperial_heroic_cloner_01.iff",
		playerSpawn = {0,0.1,-5.5,3},
		exitPoint = {"tatooine", 3527, 5, -4785, 0},
		zone = "dungeon2",
		lockedCells = {1},
		groupType = "open",
		tests= "isImp",
	},
	rebHeroicCloner = {
		iff = "object/building/military/wf_rebel_heroic_cloner_01.iff",
		playerSpawn = {0,0.1,-5.5,3},
		exitPoint = {"tatooine", 3527, 5, -4785, 0},
		zone = "dungeon2",
		lockedCells = {1},
		groupType = "open",
		tests= "isReb",
	},
	neutralHeroicCloner = {
		iff = "object/building/military/wf_neutral_heroic_cloner_01.iff",
		playerSpawn = {0,0.1,-5.5,3},
		exitPoint = {"tatooine", 3527, 5, -4785, 0},
		zone = "dungeon2",
		lockedCells = {1},
		groupType = "open",
	},
	soloSPtest = {
		iff = "object/building/general/bunker_imperial_instance_01.iff", --imperial bunker 01 **
		playerSpawn = {0, 0.3, 9, 1},
		exitPoint = {"tatooine", 3527, 5, -4785, 0},
		lockoutTimer = 1200000, --20 min lockout
		cooldownTimer = 28800000, --8 hr cooldown
		screenplay = "soloSPtest", --test screenplay
		zone = "dungeon2",
		--noExit = true,
		groupType = "solo",
	},
	life_day_solo = {
		iff = "object/building/general/cave_02_ice.iff", --imperial bunker 01 **
		playerSpawn = {-15, -4.5, -5.7, 1},
		exitPoint = {"tatooine", 3515.5, 5, -4800, 0},
		lockoutTimer = 2400000, --40 min lockout
		cooldownTimer = 28800000, --8 hr cooldown
		screenplay = "life_day_solo_sp", --test screenplay
		zone = "dungeon2",
		lockedCells = {10},
		--noExit = true,
		groupType = "solo",
	},
	moonFestivalOpen = {
		iff = "object/building/general/bunker_imperial_weapons_research_facility_01.iff",
		playerSpawn = {0, 0.3, 9, 1},
		exitPoint = {"tatooine", 3527, 5, -4785, 0},
		screenplay = "moonFestivalOpen", --test screenplay
		zone = "dungeon2",
		groupType = "open",
	},
	moonFestivalSolo = {
		iff = "object/building/general/bunker_imperial_weapons_research_facility_01.iff",
		playerSpawn = {0, 0.3, 9, 1},
		exitPoint = {"tatooine", 3527, 5, -4785, 0},
		lockoutTimer = 1200000, --20 min lockout
		cooldownTimer = 28800000, --8 hr cooldown
		screenplay = "moonFestivalSolo", --test screenplay
		zone = "dungeon2",
		groupType = "solo",
	},
	theedPalace = {
		iff = "object/building/naboo/palace_naboo_theed.iff", --theed palace
		playerSpawn = {0, 8, 93, 2}, -- x,z,y,cell#
		exitPoint = {"tatooine", 3527, 5, -4785, 0}, --p,x,z,y,cellID
		lockoutTimer = 1800000, --Building lockout/despawn timer
		screenplay = "theedTestSP", --screenplay for this instance
		zone = "dungeon1", --zone that this instance should spawn in
		lockedCells = {1,29,35},
		groupType = "group", --"solo","group","open","guild"
		--tests= "isReb/isRebOvert"
	},
	ig88Open = {
		iff = "object/building/heroic/ig88_factory_arena.iff",
		playerSpawn = {0, 0, 38, 1}, -- x,z,y,cell#
		exitPoint = {"lok", -7584, 91, 3482, 0}, --p,x,z,y,cellID
		screenplay = "ig88Open", --screenplay for this instance
		zone = "dungeon2", --zone that this instance should spawn in
		groupType = "open", --"solo","group","open","guild"
	},
	ig88Group = {
		iff = "object/building/heroic/ig88_factory_arena.iff",
		playerSpawn = {0, 0, 38, 1}, -- x,z,y,cell#
		screenplay = "ig88Group", --screenplay for this instance
		zone = "dungeon2", --zone that this instance should spawn in
		groupType = "group", --"solo","group","open","guild"
		lockoutTimer = 1800000, --30 min lockout
		cooldownTimer = 7200000, --2 hr cooldown
		minPlayerCount = 4, --min players in group to enter instance
	},
	axkvaGroup = {
		iff = "object/building/heroic/axkva_min_lair.iff",
		playerSpawn = {31.5, 0.1, .33, 1}, -- x,z,y,cell#
		exitPoint = {"dathomir", -4000, 126.6, -5.5, 0}, --p,x,z,y,cellID
		screenplay = "axkvaGroup", --screenplay for this instance
		zone = "dungeon2", --zone that this instance should spawn in
		lockoutTimer = 3600000, --1 hr lockout
		cooldownTimer = 7200000, --2 hr cooldown
		noExit = true,
		groupType = "group", --"solo","group","open","guild"
		minPlayerCount = 4, --min players in group to enter instance
		maxPlayerCount = 8, --max players in group that can have this instance active
	},
	love_day_solo = {
		iff = "object/building/general/cave_02_mirror.iff",
		playerSpawn = {14.3, -4.7, -7.3, 1},
		exitPoint = {"tatooine", 3515.5, 5, -4800, 0},
		lockoutTimer = 3600000, --1 hr lockout
		cooldownTimer = 7200000, --2 hr cooldown
		screenplay = "love_day_solo_sp", --test screenplay
		zone = "dungeon2",
		lockedCells = {10},
		--noExit = true,
		groupType = "solo",
	},
	arena_graveyard = {
		iff = "object/building/poi/arena_graveyard.iff",
		playerSpawn = {14.3, -4.7, -7.3, 0},
		exitPoint = {"tatooine", 3515.5, 5, -4800, 0},
		screenplay = "arena_graveyard_01", --test screenplay
		zone = "dungeon2",
		noExit = true,
		groupType = "open",
	},
	soroSuubSolo = {
		iff = "object/building/general/sorosuub_instance_yacht.iff", --Yacht **
		playerSpawn = {0.0, 0.4, 20.5, 1},
		exitPoint = {"tatooine", 3600, 5, -4781, 0},
		--lockoutTimer = 1200000, --20 min lockout
		--cooldownTimer = 28800000, --8 hr cooldown
		screenplay = "soroSuubSolo", --test screenplay
		zone = "dungeon1",
		--noExit = true,
		groupType = "open",
	},
}

return instances
