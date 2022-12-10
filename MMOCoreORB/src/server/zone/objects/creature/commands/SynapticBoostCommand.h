/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef SYNAMPTICBOOSTCOMMAND_H_
#define SYNAMPTICBOOSTCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/managers/collision/CollisionManager.h"

class SynapticBoostCommand : public QueueCommand {
	//float mindCost;
	float mindWoundCost;
	float range;
public:

	SynapticBoostCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {
		
		//mindCost = 10;
		mindWoundCost = 100;
		range = 6;
	}

	void doAnimations(CreatureObject* creature, CreatureObject* creatureTarget) const {
		creatureTarget->playEffect("clienteffect/healing_healenhance.cef", "");

		if (creature == creatureTarget)
			creature->doAnimation("heal_self");
		else
			creature->doAnimation("heal_other");
	}

	void sendHealMessage(CreatureObject* creature, CreatureObject* creatureTarget, int mindDamage) const {
		if (!creature->isPlayerCreature())
			return;

		CreatureObject* player = cast<CreatureObject*>(creature);

		StringBuffer msgPlayer, msgTarget, msgBody, msgTail;

		if (mindDamage > 0) {
			msgBody << mindDamage << " mind";
		} else {
			return; //No damage to heal.
		}

		msgTail << " damage.";

		if (creatureTarget->isPlayerCreature()) {
			msgPlayer << "You heal " << creatureTarget->getFirstName() << " for " << msgBody.toString() << msgTail.toString();
			msgTarget << player->getFirstName() << " heals you for " << msgBody.toString() << msgTail.toString();

			player->sendSystemMessage(msgPlayer.toString());
			creatureTarget->sendSystemMessage(msgTarget.toString());
		} else {
			msgPlayer << "You heal " << creatureTarget->getDisplayedName() << " for " << msgBody.toString() << msgTail.toString();
			player->sendSystemMessage(msgPlayer.toString());
		}
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		int result = doCommonMedicalCommandChecks(creature);

		if (result != SUCCESS)
			return result;

		if (!creature->isPlayerCreature())
			return GENERALERROR;

		unsigned int buffCRC = STRING_HASHCODE("SYNAPTIC_BOOST_COOLDOWN");
		if (creature->hasBuff(buffCRC)) {
			creature->sendSystemMessage("@cbt_spam:synaptic_boost_fail"); // You cannot Synaptic Boost at this time.
			return GENERALERROR;
		}

		ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(target);

		if (object != nullptr) {
			if (!object->isCreatureObject()) {
					object = creature;
			}
		} else {
			object = creature;
		}

		CreatureObject* creatureTarget = cast<CreatureObject*>( object.get());

		Locker clocker(creatureTarget, creature);

		CreatureObject* player = cast<CreatureObject*>(creature);

		if (creatureTarget->isDead() || (creatureTarget->isAiAgent() && !creatureTarget->isPet()) || creatureTarget->isDroidObject()) {
            creatureTarget = creature;
		}

		if (checkForArenaDuel(creatureTarget)) {
            creatureTarget = creature;
		}

		if (!creatureTarget->isHealableBy(creature)) {
            creatureTarget = creature;
		}

		if ((creature->getHAM(CreatureAttribute::FOCUS) < (mindWoundCost+1)) || (creature->getHAM(CreatureAttribute::WILLPOWER) < (mindWoundCost+1))) {
			creature->sendSystemMessage("@healing_response:not_enough_mind"); //You do not have enough mind to do that.
			return GENERALERROR;
		}

		if (creatureTarget->getHAM(CreatureAttribute::MIND) == 0 || !(creatureTarget->hasDamage(CreatureAttribute::MIND))) {
			if (creatureTarget->isPlayerCreature()) {
				StringIdChatParameter stringId("healing", "no_mind_to_heal_target"); //%NT has no mind to heal.
				stringId.setTT(creatureTarget->getObjectID());
				creature->sendSystemMessage(stringId); 
			} else {
				StringBuffer message;
				message << creatureTarget->getDisplayedName() << " has no mind to heal.";
				creature->sendSystemMessage(message.toString());
			}
			return GENERALERROR;
		}

		if(!checkDistance(creature, creatureTarget, range))
			return TOOFAR;

		PlayerManager* playerManager = server->getPlayerManager();

		if (creature != creatureTarget && !CollisionManager::checkLineOfSight(creature, creatureTarget)) {
			creature->sendSystemMessage("@healing:no_line_of_sight"); // You cannot see your target.
			return GENERALERROR;
		}

	//	float modSkill = (float) creature->getSkillMod("combat_medic_effectiveness");
		int healPower = (int) (System::random(500)+2000); // * modSkill / 100;

		// Check BF
		healPower = (int) (healPower * creature->calculateBFRatio());

		int healedMind = creatureTarget->healDamage(creature, CreatureAttribute::MIND, healPower);

		int cooldown = 120;
		ManagedReference<Buff*> buff = new Buff(creature, buffCRC, cooldown, BuffType::OTHER);
		Locker locker(buff);
		creature->addBuff(buff);

		sendHealMessage(creature, creatureTarget, healedMind);

		creature->addWounds(CreatureAttribute::FOCUS, mindWoundCost, true, false);
		creature->addWounds(CreatureAttribute::WILLPOWER, mindWoundCost, true, false);

		doAnimations(creature, creatureTarget);

		checkForTef(creature, creatureTarget);

		return SUCCESS;
	}

};

#endif //SYNAMPTICBOOSTCOMMAND_H_
