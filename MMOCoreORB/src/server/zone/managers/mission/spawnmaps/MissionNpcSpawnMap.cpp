/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#include "MissionNpcSpawnMap.h"
#include "engine/lua/Lua.h"

void MissionNpcSpawnMap::loadSpawnPointsFromLua() {
	info("Loading NPC mission spawn points.", true);
	try {
		Lua* lua = new Lua();
		lua->init();

		lua->runFile("scripts/managers/mission/mission_manager.lua");

		LuaObject cities = lua->getGlobalObject("cities");

		spawnMap.addCities(&cities);

		LuaObject universeObject = lua->getGlobalObject("universe");

		spawnMap.readObject(&universeObject);

		universeObject.pop();

		delete lua;
		lua = nullptr;
	}
	catch (Exception& e) {
		info(e.getMessage(), true);
	}
}

NpcSpawnPoint* MissionNpcSpawnMap::getRandomNpcSpawnPoint(const uint32 planetCRC, const Vector3* position, const int spawnType, const float minDistance, const float maxDistance) {
	Reference<PlanetSpawnMap* > planet = spawnMap.getPlanet(planetCRC);

	if (planet != nullptr) {
		Reference<CitySpawnMap* > city = planet->getClosestCity(position);

		if (city != nullptr) {
			Reference<NpcSpawnPoint*> npc = city->getRandomNpcSpawnPoint(position, spawnType, minDistance, maxDistance);
			return npc;
		}
	}

	//Planet or city not found.
	return nullptr;
}

Vector3* MissionNpcSpawnMap::getRandomCityCoordinates(const uint32 planetCRC, const Vector3* notCloseToPosition) {
	Reference<PlanetSpawnMap* > planet = spawnMap.getPlanet(planetCRC);

	if (planet != nullptr) {
		return planet->getRandomCityNotCloseTo(notCloseToPosition)->getCityCenter();
	}

	//Planet not found.
	return nullptr;
}

NpcSpawnPoint* MissionNpcSpawnMap::addSpawnPoint(uint32 planetCRC, Reference<NpcSpawnPoint* > npc) {
	Reference<PlanetSpawnMap* > planet = spawnMap.getPlanet(planetCRC);

	if (planet != nullptr) {
		return planet->addToClosestCity(npc, true);
	}

	return nullptr;
}

NpcSpawnPoint* MissionNpcSpawnMap::findSpawnAt(uint32 planetCRC, Vector3* position) {
	Reference<PlanetSpawnMap* > planet = spawnMap.getPlanet(planetCRC);

	if (planet != nullptr) {
		return planet->findSpawnAt(position);
	}

	return nullptr;
}

void MissionNpcSpawnMap::saveSpawnPoints() {
	std::ofstream file;
	file.open("scripts/managers/mission/mission_npc_spawn_points.lua");
	file << "--This file is auto-generated from core3 every time a new mission NPC spawn point is added." << std::endl;
	file << "--DO NOT EDIT THIS FILE!" << std::endl << std::endl;
	file << "dofile(\"scripts/managers/mission/mission_cities.lua\");" << std::endl << std::endl;
	file << "UniverseSpawnMap = {" << std::endl;
	file << "\tplanets = {}" << std::endl;
	file << "}" << std::endl << std::endl;
	file << "PlanetSpawnMap = {" << std::endl;
	file << "\tname = \"\"," << std::endl;
	file << "\tnpcs = {}" << std::endl;
	file << "}" << std::endl << std::endl;
	file << "function UniverseSpawnMap:new (o)" << std::endl;
	file << "\to = o or { }" << std::endl;
	file << "\tsetmetatable(o, self)" << std::endl;
	file << "\tself.__index = self" << std::endl;
	file << "\treturn o" << std::endl;
	file << "end" << std::endl << std::endl;
	file << "function UniverseSpawnMap:addPlanet(planet)" << std::endl;
	file << "\ttable.insert(self.planets, planet)" << std::endl;
	file << "end" << std::endl << std::endl;
	file << "function PlanetSpawnMap:new (o)" << std::endl;
	file << "\to = o or { }" << std::endl;
	file << "\tsetmetatable(o, self)" << std::endl;
	file << "\tself.__index = self" << std::endl;
	file << "\treturn o" << std::endl;
	file << "end" << std::endl << std::endl;
	file << "universe = UniverseSpawnMap:new {" << std::endl;
	file << "\tplanets = {}" << std::endl;
	file << "}" << std::endl << std::endl;

	spawnMap.saveSpawnPoints(file);
}
