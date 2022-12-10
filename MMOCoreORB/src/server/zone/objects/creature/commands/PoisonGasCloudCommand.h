/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef POISONGASCLOUDCOMMAND_H_
#define POISONGASCLOUDCOMMAND_H_

#include "CombatQueueCommand.h"

class PoisonGasCloudCommand : public CombatQueueCommand {
public:

	PoisonGasCloudCommand(const String& name, ZoneProcessServer* server)
		: CombatQueueCommand(name, server) {
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		ManagedReference<SceneObject*> targetObject = creature->getZoneServer()->getObject(target);

		CreatureObject* targetCreature = cast<CreatureObject*>(targetObject.get());

		if (targetCreature == nullptr)
			return INVALIDTARGET;

		if (creature != targetCreature && !CollisionManager::checkLineOfSight(creature, targetCreature)) {
			creature->sendSystemMessage("@cbt_spam:los_recycle"); // You cannot see your target. 
			return INVALIDTARGET;
		}


		if (!targetCreature->isAttackableBy(creature))
			return INVALIDTARGET;

		CreatureObject* player = cast<CreatureObject*>(creature);
		Locker clocker(targetCreature, creature);

		if (creature->getDistanceTo(targetCreature) > 20.f){
			creature->sendSystemMessage("@cbt_spam:target_out_of_range"); // You are out of range of your target.
			return GENERALERROR;}

		if (!creature->checkCooldownRecovery("gas")) {
   			StringIdChatParameter stringId;

   			const Time* cdTime = creature->getCooldownTime("gas");

   			int timeLeft = floor((float)cdTime->miliDifference() / 1000) *-1;

   			stringId.setStringId("@cbt_spam:cooldown_ability_message"); // You must wait %DI seconds before using %TU again.
			stringId.setDI(timeLeft);
			stringId.setTU("Poison Gas Cloud");
			creature->sendSystemMessage(stringId);
   			return GENERALERROR;
   		}

 		player->addCooldown("gas", 30 * 1000); // 30 second cooldown
		targetCreature->playEffect("clienteffect/cbt_explode_asteroid_gas_large.cef", "");

		return doCombatAction(creature, target);
	}

};

#endif //POISONGASCLOUDCOMMAND_H_
