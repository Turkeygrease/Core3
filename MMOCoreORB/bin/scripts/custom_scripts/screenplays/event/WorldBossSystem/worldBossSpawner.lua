--[[ By: Michael Simnitt aka Mindsoft
Date: Sep/14/2018
Description: World boss spawner for all planets, world bosses will be controlled via this system.
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]


---------------------------------------------(World Boss Spawner Event Screenplay & Spawn tables)
worldBossSpawner = ScreenPlay:new{
	planets = {
		["tatooine"] = {
			minBossKills = 3,
			worldBossString = "tatooine_bosses.worldBoss",
			cities = {
				{
					name = "Mos Eisley",
					-- {x, y, min, max, count, respawnTimer, despawnTimer}
					wp = {3529, -4800, 500, 700, 10, 30, 1200},
					triggerTemplates = {"bh_tusken_carnage_champion", "tusken_witch_doctor"},
					minTriggerKills = 20,
					cityBossString = "tatooine_bosses.eisleyCityBoss",
				},
				{
					name = "Mos Entha",
					-- {x, y, min, max, count, respawnTimer, despawnTimer}
					wp = {1337, 3049, 500, 700, 10, 30, 1200},
					triggerTemplates = {"bh_tusken_carnage_champion", "tusken_witch_doctor"},
					minTriggerKills = 20,
					cityBossString = "tatooine_bosses.enthaCityBoss",
				},
				{
					name = "Bestine",
					-- {x, y, min, max, count, respawnTimer, despawnTimer}
					wp = {-1281, -3589, 500, 700, 10, 30, 1200},
					triggerTemplates = {"bh_tusken_carnage_champion", "tusken_witch_doctor"},
					minTriggerKills = 20,
					cityBossString = "tatooine_bosses.bestineCityBoss",
				},
			},
		},
	},
}
registerScreenPlay("worldBossSpawner", true)

function worldBossSpawner:indexOfCity(planetTable, value)
	i = 1
	repeat
		if (planetTable.cities[i].name == value) then
			return i
		end
		i = i + 1
	until (i > #planetTable.cities)
	return false
end

function worldBossSpawner:start()
	worldBossSpawner:spawnMobiles()
	--TODO spawn Galaxy boss tracker (will be used to store galaxy kills sp state, to spawn galaxy boss)
end
---------------------------------------------(Custom Events)
--planet,x,y,min,planetsize
function worldBossSpawner:spawnMobiles()
	for planet,planetTable in pairs(worldBossSpawner.planets) do
		print("\nSpawning World Boss Event Mobiles for Planet: "..planet)
		for cityIndex, cityTable in ipairs(planetTable.cities) do
			print("Spawning City Triggers for : "..cityTable.name)
			local wp = cityTable.wp -- {x, y, min, max, count, respawnTimer, despawnTimer}
			local i = 1
			local pMob
			repeat
				local spawnPoint = getSpawnArea(planet, wp[1], wp[2], wp[3], wp[4], 20, 10)
				if (spawnPoint == nil) then
					printLuaError("Trigger Mobile could not find a spawn point, Rescheduling spawn event.")
					local pNav = WFnav:getNav(planet)
					createEvent(1000, "worldBossSpawner", "respawnTrigger", pNav, cityIndex)
					return false
				end

				local template = cityTable.triggerTemplates[math.random(#cityTable.triggerTemplates)]
				pMob = spawnMobile(planet,template,-1,spawnPoint[1],spawnPoint[2],spawnPoint[3],math.random(360),0)
				createEvent(wp[7]*1000, "worldBossSpawner", "despawnTrigger", pMob, cityIndex)
				writeData(SceneObject(pMob):getObjectID()..":cityIndex", cityIndex)
				createObserver(OBJECTDESTRUCTION, "worldBossSpawner", "triggerDead",pMob)
				AiAgent(pMob):setAITemplate("")
				i = i + 1
			until (i >wp[5])
			print("# of Triggers spawned: "..tostring(i-1).."\n")
		end
	end
end

function worldBossSpawner:despawnTrigger(pMob, cityIndex)
	if not(SceneObject(pMob)) then
		return
	end

	if (CreatureObject(pMob):isInCombat()) then
		createEvent(10000, "worldBossSpawner", "despawnTrigger", pMob, cityIndex)
		return
	end

	local zoneName = SceneObject(pMob):getZoneName()
	if ((zoneName == "") or CreatureObject(pMob):isDead()) then
		return
	end

	local pNav = WFnav:getNav(zoneName)
	local respawnTimer = self.planets[SceneObject(pNav):getZoneName()].cities[tonumber(cityIndex)].wp[6]
	createEvent((respawnTimer+math.random(5))*1000, "worldBossSpawner", "respawnTrigger", pNav, cityIndex)
	deleteData(SceneObject(pMob):getObjectID()..":cityIndex")
	SceneObject(pMob):destroyObjectFromWorld()
end

function worldBossSpawner:respawnTrigger(pNav, cityIndex)
	local zoneName = SceneObject(pNav):getZoneName()
	local cityTable = self.planets[SceneObject(pNav):getZoneName()].cities[tonumber(cityIndex)]
	local wp = cityTable.wp -- wp={x, y, min, max, count, respawnTimer, despawnTimer}
	local spawnPoint = getSpawnArea(zoneName, wp[1], wp[2], wp[3], wp[4], 20, 10)

	if (spawnPoint == nil) then
		printLuaError("Trigger Mobile could not find a spawn point, Rescheduling spawn event.")
		local pNav = WFnav:getNav(zoneName)
		createEvent(1000, "worldBossSpawner", "respawnTrigger", pNav, cityIndex)
		return false
	end

	local template = cityTable.triggerTemplates[math.random(#cityTable.triggerTemplates)]
	pMob = spawnMobile(zoneName, template, -1, spawnPoint[1], spawnPoint[2], spawnPoint[3], math.random(360),0)
	createEvent((wp[7]+math.random(5))*1000, "worldBossSpawner", "despawnTrigger", pMob, cityIndex)
	writeData(SceneObject(pMob):getObjectID()..":cityIndex", cityIndex)
	createObserver(OBJECTDESTRUCTION, "worldBossSpawner", "triggerDead",pMob)
	AiAgent(pMob):setAITemplate("")
	return true
end

function worldBossSpawner:triggerDead(pMob, pKiller)
	local cityIndex = readData(SceneObject(pMob):getObjectID()..":cityIndex")
	deleteData(SceneObject(pMob):getObjectID()..":cityIndex")
	local zoneName = SceneObject(pMob):getZoneName()
	local pNav = WFnav:getNav(zoneName)
	local cityTable = self.planets[zoneName].cities[tonumber(cityIndex)]
	local triggerCounter = readData(zoneName..":"..cityTable.name..":triggerCounter")

	if (CreatureObject(pNav):checkCooldownRecovery(zoneName..":"..cityTable.name..":cityBossEvent") and SceneObject(pKiller):isPlayerCreature()) then
		writeData(zoneName..":"..cityTable.name..":triggerCounter", triggerCounter+1)
		if (cityTable.minTriggerKills <= (triggerCounter+1)) then
			CreatureObject(pNav):addCooldown(zoneName..":"..cityTable.name..":cityBossEvent", 3600000)
			writeData(zoneName..":"..cityTable.name..":triggerCounter", 0) --reset counter
			self:spawnBoss(cityTable.name, cityTable.cityBossString, cityIndex)
			CreatureObject(pKiller):playMusicMessage("sound/music_combat_bfield_vict.snd")
		else
			CreatureObject(pKiller):sendSystemMessage("City Kills: "..tostring(triggerCounter+1).." of "..tostring(cityTable.minTriggerKills))
			CreatureObject(pKiller):playMusicMessage("sound/ui_quest_waypoint_target.snd")
		end
	end
	local respawnTimer = self.planets[SceneObject(pNav):getZoneName()].cities[tonumber(cityIndex)].wp[6]
	createEvent((respawnTimer+math.random(5))*1000, "worldBossSpawner", "respawnTrigger", pNav, cityIndex)
	return 0
end

--spawn city boss
function worldBossSpawner:spawnBoss(cityName, cityBossString, cityIndex)
	local pBoss = spawnBossMobile(cityBossString)
	AiAgent(pBoss):setAITemplate("")
	createObserver(OBJECTDESTRUCTION, "worldBossSpawner", "bossDead",pBoss)
	writeData(SceneObject(pBoss):getObjectID()..":cityIndex", cityIndex)
end

--despawn city boss clean-up
function worldBossSpawner:despawnBoss(pMob,stringData)
	if not(SceneObject(pMob)) then
		return
	end
	deleteData(SceneObject(pMob):getObjectID()..":cityIndex")
	return true
end

--city boss death clean-up and tests for world boss
function worldBossSpawner:bossDead(pMob, pKiller)
	local cityIndex = readData(SceneObject(pMob):getObjectID()..":cityIndex")
	deleteData(SceneObject(pMob):getObjectID()..":cityIndex")
	local zoneName = SceneObject(pMob):getZoneName()
	local pNav = WFnav:getNav(zoneName)
	local spState = math.pow(2,cityIndex)
	if not(CreatureObject(pNav):hasScreenPlayState(spState,"worldBossSpawner")) then
		CreatureObject(pNav):setScreenPlayState(spState,"worldBossSpawner")
	end

	local i = 1
	local counter = 0
	repeat --check each city on planet for completed boss kill state
		local spState = math.pow(2,i)
		if (CreatureObject(pNav):hasScreenPlayState(spState,"worldBossSpawner")) then
			counter = counter + 1
		end
		i = i + 1
	until (i > #worldBossSpawner.planets[zoneName].cities)
	local minKills = worldBossSpawner.planets[zoneName].minBossKills
	if (counter >= minKills) then --check if min kills for world boss spawn reached
		local bossString = worldBossSpawner.planets[zoneName].worldBossString
		worldBossSpawner:spawnWorldBoss(bossString)
	end

	return 0
end

--spawn world boss
function worldBossSpawner:spawnWorldBoss(bossString)
	local pMob = spawnBossMobile(bossString)
	createObserver(OBJECTDESTRUCTION, "worldBossSpawner", "worldBossDead",pMob)
	AiAgent(pMob):setAITemplate("")
end

--despawn world boss clean-up and reset
function worldBossSpawner:despawnWorldBoss(pMob, stringData)
	if not(SceneObject(pMob)) then
		return
	end
	local zoneName = SceneObject(pMob):getZoneName()
	local pNav = WFnav:getNav(zoneName)
	CreatureObject(pNav):setScreenPlayState(0,"worldBossSpawner")--reset planet
	return true
end

--world boss death clean-up and reset
function worldBossSpawner:worldBossDead(pMob, pKiller)
	local zoneName = SceneObject(pMob):getZoneName()
	local pNav = WFnav:getNav(zoneName)
	CreatureObject(pNav):setScreenPlayState(0,"worldBossSpawner")--reset planet
	--TODO add galaxy boss state
	return 0
end

--spawn galaxy boss
function worldBossSpawner:spawnGalaxyBoss()
	--TODO
end

--despawn galaxy boss clean-up and reset
function worldBossSpawner:despawnGalaxyBoss(pMob)
	if not(SceneObject(pMob)) then
		return
	end
	--TODO
end

--galaxy boss death clean-up and reset
function worldBossSpawner:galaxyBossDead()
	--TODO
	return 0
end

