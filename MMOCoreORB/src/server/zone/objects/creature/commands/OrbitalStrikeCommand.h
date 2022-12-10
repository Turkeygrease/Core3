/*
 * Orbital Strike
 *
 *  Created on: 11/22/2015
 *
 */

#ifndef ORBITALSTRIKECOMMAND_H_
#define ORBITALSTRIKECOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "CombatQueueCommand.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "templates/params/creature/CreatureAttribute.h"
#include "server/zone/Zone.h"
#include "SquadLeaderCommand.h"

class OrbitalStrikeCommand : public SquadLeaderCommand {
public:

	OrbitalStrikeCommand(const String& name, ZoneProcessServer* server)
		: SquadLeaderCommand(name, server) {

	}
	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		ManagedReference<CreatureObject*> player = cast<CreatureObject*>(creature);
		ManagedReference<GroupObject*> group = player->getGroup();

		if (!checkGroupLeader(player, group))
			return GENERALERROR;

		int nSkill = 0;
		if (creature->hasSkill("force_title_jedi_rank_02"))
			nSkill += 1;

		ZoneServer* zserv = creature->getZoneServer();
		PlayerObject* jedi = creature->getPlayerObject();

		if (nSkill > 0) {
			creature->sendSystemMessage("@jedi_spam:jedi_forbidden"); // Your knowledge of the force forbids you from using this ability.
			return GENERALERROR;
		}

		// Fail if target is not a player...
		ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(target);

		if (object == nullptr || !object->isCreatureObject())
			return INVALIDTARGET;

		CreatureObject* creatureTarget = cast<CreatureObject*>( object.get());
		/* ManagedReference<SceneObject*> parent = creature->getParent().get();

		if (parent == nullptr || parent->isCellObject() || parent != creatureTarget->getParent().get()) {
			creature->sendSystemMessage("You AND your target must be outside to perform this action.");
			return INVALIDTARGET;
		}*/

		PlayerManager* playerManager = server->getPlayerManager();

		if (creature != creatureTarget && !CollisionManager::checkLineOfSight(creature, creatureTarget)) {
			creature->sendSystemMessage("@cbt_spam:los_recycle"); // You cannot see your target. 
			return INVALIDTARGET;
		}

		if (!creature->checkCooldownRecovery("strike")) {
			StringIdChatParameter stringId;

			const Time* cdTime = creature->getCooldownTime("strike");

			// Returns -time. Multiple by -1 to return positive.
			int timeLeft = floor((float)cdTime->miliDifference() / 1000) *-1;

			stringId.setStringId("@cbt_spam:cooldown_ability_message"); // You must wait %DI seconds before using %TU again.
			stringId.setDI(timeLeft);
			stringId.setTU("Orbital Strike");
			creature->sendSystemMessage(stringId);

			return GENERALERROR;
		}

		if (creatureTarget == nullptr)
			return INVALIDTARGET;

		Locker clocker(creatureTarget, creature);

		ManagedReference<PlayerObject*> targetGhost = creatureTarget->getPlayerObject();
		ManagedReference<PlayerObject*> playerObject = creature->getPlayerObject();

		if (targetGhost == nullptr || playerObject == nullptr)
			return GENERALERROR;

		if (creature->getDistanceTo(creatureTarget) > 42.f) {
			creature->sendSystemMessage("@cbt_spam:target_out_of_range"); // You are out of range of your target.
			return GENERALERROR;
		}

		if (object->isCreatureObject() && creatureTarget->isAttackableBy(creature)) {
    		creatureTarget->setDizziedState(6);
			creature->addDefender(creatureTarget);
		    creatureTarget->setPosture(CreaturePosture::CROUCHED);
			creatureTarget->playEffect("clienteffect/combat_pt_orbitalstrike.cef", "");
			creatureTarget->sendSystemMessage("@cbt_spam:oribtal_strike_activate"); // A focused beam of energy from an orbiting ship fires at your position!
			creatureTarget->inflictDamage(creatureTarget, CreatureAttribute::HEALTH, 1000 + System::random(500), true);
			creature->addCooldown("strike", 60 * 1000);
		}

		return SUCCESS;
	}

};


#endif //ORBITALSTRIKECOMMAND_H_
