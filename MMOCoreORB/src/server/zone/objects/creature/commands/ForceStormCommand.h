/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef FORCESTORMCOMMAND_H_
#define FORCESTORMCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "CombatQueueCommand.h"

class ForceStormCommand : public CombatQueueCommand {
public:

	ForceStormCommand(const String& name, ZoneProcessServer* server)
		: CombatQueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (creature->hasAttackDelay() || !creature->hasPostureChangeDelay())
			return GENERALERROR;

		if (isWearingArmor(creature)) {
			return NOJEDIARMOR;
		}
	
		uint32 avoidIncapacitationCRC = BuffCRC::JEDI_AVOID_INCAPACITATION;
		// Stop channeling while AI 
		if (creature->hasBuff(avoidIncapacitationCRC)){
			creature->sendSystemMessage("@jedi_spam:avoid_incap_drain_force_storm"); // You cannnot use Force Storm while using Avoid Incapacitiation.
			return GENERALERROR;
		}

		// Fail if target is not a player...

		ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(target);

		if (object == nullptr || !object->isPlayerCreature())
			return INVALIDTARGET;

		CreatureObject* targetCreature = cast<CreatureObject*>( object.get());

		if (targetCreature == NULL || targetCreature->isDead() || (targetCreature->isIncapacitated() && !targetCreature->isFeigningDeath()) || !targetCreature->isAttackableBy(creature))
			return INVALIDTARGET;

		if(!checkDistance(creature, targetCreature, range))
			return TOOFAR;

		if (!CollisionManager::checkLineOfSight(creature, targetCreature)) {
			creature->sendSystemMessage("@combat_effects:cansee_fail");//You cannot see your target.
			return GENERALERROR;
		}

		if (!creature->checkCooldownRecovery("forcestorm")) {
			StringIdChatParameter stringId;

			const Time* cdTime = creature->getCooldownTime("forcestorm");

			// Returns -time. Multiple by -1 to return positive.
			int timeLeft = floor((float)cdTime->miliDifference() / 1000) *-1;

			stringId.setStringId("@cbt_spam:cooldown_ability_message"); // You must wait %DI seconds before using %TU again.
			stringId.setDI(timeLeft);
			stringId.setTU("Force Storm");
			creature->sendSystemMessage(stringId);

			return GENERALERROR;
		}

		Locker clocker(targetCreature, creature);

		ManagedReference<PlayerObject*> targetGhost = targetCreature->getPlayerObject();
		ManagedReference<PlayerObject*> playerGhost = creature->getPlayerObject();

		if (targetGhost == nullptr || playerGhost == nullptr)
			return GENERALERROR;

		CombatManager* manager = CombatManager::instance();
		int maxDrain = 0;
		if (manager->startCombat(creature, targetCreature, false)) { //lockDefender = false because already locked above.
			int forceSpace = playerGhost->getForcePowerMax() - playerGhost->getForcePower();
			if (forceSpace <= 0) //Cannot Force Drain if attacker can't hold any more Force.
				return GENERALERROR;

			maxDrain = minDamage; //Value set in command lua.

			int targetForce = targetGhost->getForcePower();
			if (targetForce <= 0) {
				creature->sendSystemMessage("@jedi_spam:target_no_force"); //That target does not have any Force Power.
				return GENERALERROR;
			}

	//		maxDrain += 30;
	//		maxDrain *= creature->getFrsMod("power"); //FRS drains more
	//		maxDrain /= targetCreature->getFrsMod("control"); //FRS gets drained less

			if (creature->hasSkill("force_discipline_enhancements_master"))
				maxDrain *= 1.5; //Master enhancer drains more

			if (targetCreature->hasSkill("force_discipline_enhancements_master"))
				maxDrain /= 1.5; //Master enhancer gets drained less

			// Force Shield vs Drain
			float forceShield = targetCreature->getSkillMod("force_shield");

			if (forceShield > 0) {
				maxDrain *= (1 - (forceShield / 100.f));
			}

			int forceDrain = targetForce >= maxDrain ? maxDrain : targetForce; //Drain whatever Force the target has, up to max.

			if (forceDrain > forceSpace)
				forceDrain = forceSpace; //Drain only what attacker can hold in their own Force pool.

			playerGhost->setForcePower(playerGhost->getForcePower() + forceDrain);
			targetGhost->setForcePower(targetGhost->getForcePower() - forceDrain);

			uint32 animCRC = getAnimationString().hashCode();
			creature->doCombatAnimation(targetCreature, animCRC, 0x1, 0xFF);
			manager->broadcastCombatSpam(creature, targetCreature, NULL, forceDrain, "cbt_spam", combatSpam, 1);
			creature->updateCooldownTimer("forcestorm", (5000/creature->getFrsMod("manipulation"))); // CD scales with frs

			return SUCCESS;
		}

		return GENERALERROR;

	}

	float getCommandDuration(CreatureObject* object, const UnicodeString& arguments) const {
		float baseDuration = defaultTime * 3.0;
		float combatHaste = object->getSkillMod("combat_haste");

		if (combatHaste > 0) {
			return baseDuration * (1.f - (combatHaste / 100.f));
		} else {
			return baseDuration;
		}
	}

};

#endif //DRAINFORCECOMMAND_H_
