rare_boss_handler = ScreenPlay:new{
	planets = {
		["dathomir"] = {
			planetSize = 6000,

			common = {"world_dath_common_a"},
			commonPaintings = { -- common.iff , rare.iff
				{"object/tangible/painting/reptilian_flier_painting_common.iff","object/tangible/painting/reptilian_flier_painting_rare.iff"}, --dath common_a
			},

			uncommon = {"world_dath_uncommon_a"},
			uncommonPaintings = { -- common.iff , rare.iff
				{"object/tangible/painting/bull_rancor_painting_common.iff","object/tangible/painting/bull_rancor_painting_rare.iff"}, --dath uncommon_a	
			},

			pois = {	--{x,y,min,max},
				{-6358, 930, 400, 450}, --imp prison
				{-2112, 3157, 150, 200}, --dath sarlaac
				{-4453, 592, 200, 250}, --crashed escape pod
				{3557, 1557, 200, 250}, --misty falls
				{640, -4896, 200, 250}, --dath tar pits
				{-3952, -58, 200, 250}, --ns stronghold
				{672, 4069, 200, 250}, --smc
				{-2464, 1520, 200, 250}, --ns v smc
				{-1226, 6266, 200, 250}, --cult cave
				{2426, -1706, 200, 250}, --forced labor camp
			},
		},
		["dantooine"] = {
			planetSize = 7000,

			common = {"world_dant_common_a"},
			commonPaintings = { -- common.iff , rare.iff
				{"object/tangible/painting/dark_force_crystal_hunter_painting_common.iff","object/tangible/painting/dark_force_crystal_hunter_painting_rare.iff"},	
			},

			uncommon = {"world_dant_uncommon_a"},
			uncommonPaintings = { -- common.iff , rare.iff
				{"object/tangible/painting/graul_painting_common.iff","object/tangible/painting/graul_painting_rare.iff"},	
			},

			pois = {	--{x,y,min,max},
				{-3930, -5638, 200, 250}, --dantari village 1
				{-7184, -890, 200, 250}, --dantari village 2
				{5576, -630, 200, 250}, --dantari village 3
				{-6754, 5519, 300, 350}, --abandoned rebel base
				{4215, 5245, 250, 300}, --jedi temple ruins
				{-5965, 7253, 1, 150}, --force crystal hunters cave
				{6891, -4107, 1, 150}, --janta stronghold
				{-7025, -3376, 200, 250}, --mokk stronghold
				{-144, -418, 200, 250}, --kunga stronghold
				{-556, -3819, 200, 250}, --the warren
			},
		},
		["lok"] = {
			planetSize = 6000,

			common = {"world_lok_common_a"},
			commonPaintings = { -- common.iff , rare.iff
				{"object/tangible/painting/recluse_gurk_king_painting_common.iff","object/tangible/painting/recluse_gurk_king_painting_rare.iff"},	
			},

			uncommon = {"world_lok_uncommon_a"},
			uncommonPaintings = { -- common.iff , rare.iff
				{"object/tangible/painting/giant_kimogila_painting_common.iff","object/tangible/painting/giant_kimogila_painting_rare.iff"},	
			},

			pois = {	--{x,y,min,max},
				{2953, -4703, 550, 650}, --mount chaolt
				{-1920, -3084, 300, 350}, --imperial outpost
				{4573, -1149, 140, 200}, --great kimogila skeleton
				{-76, 2712, 200, 250}, --kimogila town
				{-3854, -3797, 200, 300}, --corsair stronghold
				{3633, 2172, 350, 400}, --blood razor transport
				{3829, -506, 100, 200}, --maze of lok
			},
		},
		["rori"] = {
			planetSize = 7000,

			common = {"world_rori_common_a"},
			commonPaintings = { -- common.iff , rare.iff
				{"object/tangible/painting/torton_painting_common.iff","object/tangible/painting/torton_painting_rare.iff"},	
			},

			uncommon = {"world_rori_uncommon_a"},
			uncommonPaintings = { -- common.iff , rare.iff
				{"object/tangible/painting/borgle_painting_common.iff","object/tangible/painting/borgle_painting_rare.iff"},	
			},

			pois = {	--{x,y,min,max},
				{3677, -6447, 200, 250}, --reb outpost
				{7358, 107, 200, 300}, --kobola bunker
				{-5611, -5662, 200, 300}, --imperial encampment
				{-1153, 4554, 200, 250}, --hyperdrive research facility
				{-5975, -1826, 200, 250}, --garyn raiders bunker
				{782, -4800, 200, 300}, --borgle bat cave
				{5445, 5033, 200, 300}, --cobral hideout
				{-1957, -4561, 200, 300}, --pygmy torton cave
				{774, -2061, 200, 300}, --poacher battle
				{3641, 5544, 200, 300}, --bark mite cave
				{-2076, 3276, 200, 300}, --gungan swamp town
			},
		},
	},


	rare = {"world_rare_a"},
	rarePaintings = {
		{"object/tangible/painting/kkorrwrot_painting_common.iff","object/tangible/painting/kkorrwrot_painting_rare.iff"},	
	},

	systemRare = {"world_s_rare_a", "world_s_rare_b", "world_s_rare_c", "world_s_rare_d", "world_s_rare_e"},
	systemRarePaintings = {
		{"object/tangible/painting/grievous_painting_common.iff","object/tangible/painting/grievous_painting_rare.iff","bespin_house_schem"},
		{"object/tangible/painting/fluorescent_reptilian_flier_painting_common.iff","object/tangible/painting/fluorescent_reptilian_flier_painting_rare.iff","relaxation_house_schem"},
		{"object/tangible/painting/infected_kkorrwrot_painting_common.iff","object/tangible/painting/infected_kkorrwrot_painting_rare.iff","sandcrawler_house_schem"},
		{"object/tangible/painting/magma_drenched_rancor_painting_common.iff","object/tangible/painting/magma_drenched_rancor_painting_rare.iff","tree_house_schem"},
		{"object/tangible/painting/undead_grievous_painting_common.iff","object/tangible/painting/undead_grievous_painting_rare.iff","jabbas_house_schem"},
	},
	--talus 
}
registerScreenPlay("rare_boss_handler", true)

function rare_boss_handler:start()
	createEvent(900*1000, "rare_boss_handler", "InitializeSpawns", "", "")
end

function rare_boss_handler:InitializeSpawns()
	self:spawnCommon()
	self:spawnUncommon()
	self:spawnRare()
	self:spawnSystemRare()
end



--Common Bosses
function rare_boss_handler:spawnCommon()
	for planet,planetTable in pairs(self.planets) do
		local spawn = getSpawnArea(planet, 0, 0, 1, self.planets[planet].planetSize, 20, 10)
		if (spawn == nil) then
			printLuaError("could not find a spawn point, Rescheduling common boss spawn event.")
			createEvent(1000, "rare_boss_handler", "respawnCommon", "", planet)
			return false
		end

		local bossIndex = math.random(#self.planets[planet].common)
		local boss = self.planets[planet].common[bossIndex]
		local pSob = spawnMobile(planet, boss, 0, spawn[1], spawn[2], spawn[3], math.random(360), 0)
		rare_boss_handler:generatePainting(pSob, self.planets[planet].commonPaintings[bossIndex])
		createObserver(OBJECTREMOVEDFROMZONE, "rare_boss_handler", "commonDead",pSob)
	end
end

function rare_boss_handler:respawnCommon(val, planet)
	local spawn = getSpawnArea(planet, 0, 0, 1, self.planets[planet].planetSize, 20, 10)
	if (spawn == nil) then
		printLuaError("could not find a spawn point, Rescheduling common boss spawn event.")
		createEvent(1000, "rare_boss_handler", "respawnCommon", "", planet)
		return false
	end

	local bossIndex = math.random(#self.planets[planet].common)
	local boss = self.planets[planet].common[bossIndex]
	local pSob = spawnMobile(planet, boss, 0, spawn[1], spawn[2], spawn[3], math.random(360), 0)
	rare_boss_handler:generatePainting(pSob, self.planets[planet].commonPaintings[bossIndex])
	createObserver(OBJECTREMOVEDFROMZONE, "rare_boss_handler", "commonDead",pSob)
end

function rare_boss_handler:commonDead(pSob)
	if not(SceneObject(pSob)) then
		return
	end

	local planet = SceneObject(pSob):getZoneName()
	if (planet == "") then
		return
	end

	createEvent((3600 + math.random(3600))*1000, "rare_boss_handler", "respawnCommon", "", planet)

	return 0
end

--Uncommon Bosses
function rare_boss_handler:spawnUncommon()
	for planet,planetTable in pairs(self.planets) do
		local spawn = getSpawnArea(planet, 0, 0, 1, self.planets[planet].planetSize, 20, 10)
		if (spawn == nil) then
			printLuaError("could not find a spawn point, Rescheduling uncommon boss spawn event.")
			createEvent(1000, "rare_boss_handler", "respawnUncommon", "", planet)
			return false
		end

		local bossIndex = math.random(#self.planets[planet].uncommon)
		local boss = self.planets[planet].uncommon[bossIndex]
		local pSob = spawnMobile(planet, boss, 0, spawn[1], spawn[2], spawn[3], math.random(360), 0)
		rare_boss_handler:generatePainting(pSob, self.planets[planet].uncommonPaintings[bossIndex])
		createObserver(OBJECTREMOVEDFROMZONE, "rare_boss_handler", "uncommonDead",pSob)
	end
end

function rare_boss_handler:respawnUncommon(val, planet)
	local spawn = getSpawnArea(planet, 0, 0, 1, self.planets[planet].planetSize, 20, 10)
	if (spawn == nil) then
		printLuaError("could not find a spawn point, Rescheduling uncommon boss spawn event.")
		createEvent(1000, "rare_boss_handler", "respawnUncommon", "", planet)
		return false
	end

	local bossIndex = math.random(#self.planets[planet].uncommon)
	local boss = self.planets[planet].uncommon[bossIndex]
	local pSob = spawnMobile(planet, boss, 0, spawn[1], spawn[2], spawn[3], math.random(360), 0)
	rare_boss_handler:generatePainting(pSob, self.planets[planet].uncommonPaintings[bossIndex])
	createObserver(OBJECTREMOVEDFROMZONE, "rare_boss_handler", "uncommonDead",pSob)
end

function rare_boss_handler:uncommonDead(pSob)
	if not(SceneObject(pSob)) then
		return
	end

	local planet = SceneObject(pSob):getZoneName()
	if (planet == "") then
		return
	end

	createEvent(((3600 * 2) + math.random(3600 * 6))*1000, "rare_boss_handler", "respawnUncommon", "", planet)
	return 0
end

--Rare Bosses
function rare_boss_handler:spawnRare()
	local tbl = {}
	for planet,planetTable in pairs(self.planets) do
		table.insert(tbl, planet)
	end
	local planet = tbl[math.random(#tbl)]
	local spawn = getSpawnArea(planet, 0, 0, 1, self.planets[planet].planetSize, 20, 10)
	if (spawn == nil) then
		printLuaError("could not find a spawn point, Rescheduling rare boss spawn event.")
		createEvent(1000, "rare_boss_handler", "respawnRare", "", "")
		return false
	end

	local bossIndex = math.random(#self.rare)
	local boss = self.rare[bossIndex]
	local pSob = spawnMobile(planet, boss, 0, spawn[1], spawn[2], spawn[3], math.random(360), 0)
	rare_boss_handler:generatePainting(pSob, self.rarePaintings[bossIndex])
	createObserver(OBJECTREMOVEDFROMZONE, "rare_boss_handler", "rareDead",pSob)
	local msg = "A Rare disturbance in the force has been felt on "..planet
	broadcastToGalaxy(msg)
	return 0
end

function rare_boss_handler:respawnRare()
	local tbl = {}
	for planet,planetTable in pairs(self.planets) do
		table.insert(tbl, planet)
	end
	local planet = tbl[math.random(#tbl)]
	local spawn = getSpawnArea(planet, 0, 0, 1, self.planets[planet].planetSize, 20, 10)
	if (spawn == nil) then
		printLuaError("could not find a spawn point, Rescheduling rare boss spawn event.")
		createEvent(1000, "rare_boss_handler", "respawnRare", "", "")
		return false
	end

	local bossIndex = math.random(#self.rare)
	local boss = self.rare[bossIndex]
	local pSob = spawnMobile(planet, boss, 0, spawn[1], spawn[2], spawn[3], math.random(360), 0)
	rare_boss_handler:generatePainting(pSob, self.rarePaintings[bossIndex])
	createObserver(OBJECTREMOVEDFROMZONE, "rare_boss_handler", "rareDead",pSob)
	local msg = "A Rare disturbance in the force has been felt on "..planet
	broadcastToGalaxy(msg)
end

function rare_boss_handler:rareDead(pSob)
	if not(SceneObject(pSob)) then
		return
	end

	local planet = SceneObject(pSob):getZoneName()
	if (planet == "") then
		return
	end

	createEvent(((3600 * 4) + math.random(3600 * 8))*1000, "rare_boss_handler", "respawnRare", "", "")
	return 0
end

--System Rare Bosses
function rare_boss_handler:spawnSystemRare()
	local tbl = {}
	for planet,planetTable in pairs(self.planets) do
		table.insert(tbl, planet)
	end
	local planet = tbl[math.random(#tbl)]
	local wp = self.planets[planet].pois[math.random(#self.planets[planet].pois)]
	local spawn = getSpawnArea(planet, wp[1], wp[2], wp[3], wp[4], 20, 10)
	if (spawn == nil) then
		printLuaError("could not find a spawn point, Rescheduling system rare boss spawn event.")
		createEvent(1000, "rare_boss_handler", "respawnSystemRare", "", "")
		return false
	end

	local bossIndex = math.random(#self.systemRare)
	local boss = self.systemRare[bossIndex]
	local pSob = spawnMobile(planet, boss, 0, spawn[1], spawn[2], spawn[3], math.random(360), 0)
	rare_boss_handler:generatePainting(pSob, self.systemRarePaintings[bossIndex])
	createObserver(OBJECTREMOVEDFROMZONE, "rare_boss_handler", "systemRareDead",pSob)
	local msg = "A Powerful disturbance in the force has been felt on "..planet
	broadcastToGalaxy(msg)
	return 0
end

function rare_boss_handler:respawnSystemRare()
	local tbl = {}
	for planet,planetTable in pairs(self.planets) do
		table.insert(tbl, planet)
	end
	local planet = tbl[math.random(#tbl)]
	local wp = self.planets[planet].pois[math.random(#self.planets[planet].pois)]
	local spawn = getSpawnArea(planet, wp[1], wp[2], wp[3], wp[4], 20, 10)

	if (spawn == nil) then
		printLuaError("could not find a spawn point, Rescheduling system rare boss spawn event.")
		createEvent(1000, "rare_boss_handler", "respawnSystemRare", "", "")
		return false
	end

	local bossIndex = math.random(#self.systemRare)
	local boss = self.systemRare[bossIndex]
	local pSob = spawnMobile(planet, boss, 0, spawn[1], spawn[2], spawn[3], math.random(360), 0)
	rare_boss_handler:generatePainting(pSob, self.systemRarePaintings[bossIndex])
	createObserver(OBJECTREMOVEDFROMZONE, "rare_boss_handler", "systemRareDead",pSob)
	local msg = "A Powerful disturbance in the force has been felt on "..planet
	broadcastToGalaxy(msg)
end

function rare_boss_handler:systemRareDead(pSob)
	if not(SceneObject(pSob)) then
		return
	end

	local planet = SceneObject(pSob):getZoneName()
	if (planet == "") then
		return
	end

	createEvent(((3600 * 8) + math.random(3600 * 24))*1000, "rare_boss_handler", "respawnSystemRare", "", "")
	return 0
end

--Forced Loot Roll for Rare Bosses
function rare_boss_handler:generatePainting(pBoss, paintingTable)
	local pInventory = CreatureObject(pBoss):getSlottedObject("inventory")
	if (pInventory ~= nil) then
		local picked = math.random(20)
		local painting = false
		if (picked > 10) then -- 5:10 Odds to get nothing
			if (paintingTable[3] and (picked > 18)) then -- 1:10 Odds to get rare loot
				createLoot(pInventory, paintingTable[3], 0, true)
			elseif (picked > 15) then -- 1.5:10 Odds to get rare painting
				painting = paintingTable[1]
			else -- 2.5:10 Odds to get common painting
				painting = paintingTable[2]
			end
		end
		if (painting) then
			pItem = giveItem(pInventory, painting, -1)
		end
	end
end
