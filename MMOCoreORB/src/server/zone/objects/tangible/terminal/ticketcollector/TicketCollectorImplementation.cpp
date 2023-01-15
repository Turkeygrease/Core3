/*
 * TicketCollectorImplemetation.cpp
 *
 *  Created on: 30/05/2010
 *      Author: victor
 */

#include "server/zone/objects/tangible/terminal/ticketcollector/TicketCollector.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/Zone.h"
#include "server/zone/packets/object/ObjectMenuResponse.h"
#include "server/zone/managers/jedi/JediManager.h"
#include "server/zone/managers/director/DirectorManager.h"
#include "server/zone/managers/planet/PlanetTravelPoint.h"
#include "server/zone/managers/planet/PlanetManager.h"
#include "server/zone/objects/player/PlayerObject.h"

void TicketCollectorImplementation::fillObjectMenuResponse(ObjectMenuResponse* menuResponse, CreatureObject* player) {
	if (JediManager::instance()->getJediProgressionType() == JediManager::VILLAGEJEDIPROGRESSION) {
		Zone* thisZone = getZone();

		if (thisZone == nullptr)
			return;

		ManagedReference<PlanetManager*> pMan = thisZone->getPlanetManager();

		if (pMan == nullptr)
			return;

		PlanetTravelPoint* ptp = pMan->getNearestPlanetTravelPoint(_this.getReferenceUnsafeStaticCast(), 64.f);

		if (ptp != nullptr && ptp->isInterplanetary()) {
			PlayerObject* ghost = player->getPlayerObject();

			if (ghost != nullptr && ghost->hasActiveQuestBitSet(PlayerQuestData::FS_CRAFTING4_QUEST_03) && !ghost->hasCompletedQuestsBitSet(PlayerQuestData::FS_CRAFTING4_QUEST_03))
				menuResponse->addRadialMenuItem(193, 3, "@quest/force_sensitive/fs_crafting:tracking_data_menu_obtain_data"); // Obtain Satellite Data
		}
		ManagedReference<PlayerObject*> playerGhost = player->getPlayerObject();

		if (not(playerGhost->hasPvpTef() || playerGhost->hasBhTef() || playerGhost->hasJediTef())){
			int age = playerGhost->getCharacterAgeInDays();
			if (age < 31)
				menuResponse->addRadialMenuItem(101, 3, "Travel to Nova Orion [Free]");
			else
				menuResponse->addRadialMenuItem(101, 3, "Travel to Nova Orion [500 Credits]");
		}
	}
}

int TicketCollectorImplementation::handleObjectMenuSelect(CreatureObject* player, byte selectedID) {
	if (selectedID == 20) {
		player->executeObjectControllerAction(0x5DCD41A2); //boardShuttle

	} else if (selectedID == 101 || selectedID == 102) { //Mindsoft added for porting to Nova Orion
		if (player->isInCombat() || player->isDead() || player->isIncapacitated()) { //test for valid non-combat state
			player->sendSystemMessage("You Cannot Travel in your current state.");
			return 0;
		}

		if (!player->isInRange(_this.getReferenceUnsafeStaticCast(), 6)) { //range test
			player->sendSystemMessage("You are Not in range to do this action.");
			return 0;
		}

		ManagedReference<PlayerObject*> playerGhost = player->getPlayerObject();
		if (playerGhost->hasPvpTef() || playerGhost->hasBhTef() || playerGhost->hasJediTef()){ //tef test
			player->sendSystemMessage("You Cannot travel to Nova while in TEF.");
			return 0;
		}

		int age = playerGhost->getCharacterAgeInDays();
		if (age > 31){ //Toons > 1month old should pay 500 credits
			// Player must have enough credits
			if( player->getCashCredits() + player->getBankCredits() < 500 ){
				player->sendSystemMessage( "You have insufficient funds for this purchase." );
				return 0;
			}

			// Deduct cost
			if( player->getCashCredits() >= 500 ){
				player->setCashCredits(player->getCashCredits() - 500, true);
			}
			else{
				int fromBank = 500 - player->getCashCredits();
				player->setCashCredits(0, true);
				player->setBankCredits(player->getBankCredits() - fromBank, true);
			}
		}
		uint64 nova = DirectorManager::instance()->readSharedMemory("WF_Instance_Handler:openInstance:nova");
		player->switchZone("dungeon1", 14.1, -1, 0, (nova + 1));

	} else if (selectedID == 193 && JediManager::instance()->getJediProgressionType() == JediManager::VILLAGEJEDIPROGRESSION) {
		Zone* thisZone = getZone();

		if (thisZone == nullptr)
			return 0;

		ManagedReference<PlanetManager*> planetManager = thisZone->getPlanetManager();

		if (planetManager == nullptr)
			return 0;

		PlanetTravelPoint* ptp = planetManager->getNearestPlanetTravelPoint(_this.getReferenceUnsafeStaticCast(), 64.f);

		if (ptp != nullptr && ptp->isInterplanetary()) {
			PlayerObject* ghost = player->getPlayerObject();

			if (ghost != nullptr && ghost->hasActiveQuestBitSet(PlayerQuestData::FS_CRAFTING4_QUEST_03) && !ghost->hasCompletedQuestsBitSet(PlayerQuestData::FS_CRAFTING4_QUEST_03)) {
				Lua* lua = DirectorManager::instance()->getLuaInstance();
				Reference<LuaFunction*> luaObtainData = lua->createFunction("FsCrafting4", "obtainSatelliteData", 0);
				*luaObtainData << player;
				*luaObtainData << _this.getReferenceUnsafeStaticCast();

				luaObtainData->callFunction();
			}
		}
	}

	return 0;
}

