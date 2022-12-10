/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef REMOTEDETONATORCOMMAND_H_
#define REMOTEDETONATORCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "CombatQueueCommand.h"
#include "server/zone/packets/player/PlayMusicMessage.h"
#include "server/zone/objects/creature/buffs/SingleUseBuff.h"

class RemoteDetonatorCommand : public CombatQueueCommand {
public:

	RemoteDetonatorCommand(const String& name, ZoneProcessServer* server)
		: CombatQueueCommand(name, server) {
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;
		ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(target);

		if (object == nullptr || !object->isCreatureObject())
			return INVALIDTARGET;

		CreatureObject* creatureTarget = cast<CreatureObject*>( object.get());
		PlayerManager* playerManager = server->getPlayerManager();

		if (creature != creatureTarget && !CollisionManager::checkLineOfSight(creature, creatureTarget)) {
			creature->sendSystemMessage("@cbt_spam:los_recycle"); // You cannot see your target. 
			return INVALIDTARGET;
		}

		if (!creature->checkCooldownRecovery("explosion")) {
			StringIdChatParameter stringId;

			const Time* cdTime = creature->getCooldownTime("explosion");

			// Returns -time. Multiple by -1 to return positive.
			int timeLeft = floor((float)cdTime->miliDifference() / 1000) *-1;

			stringId.setStringId("@cbt_spam:cooldown_ability_message"); // You must wait %DI seconds before using %TU again.
			stringId.setDI(timeLeft);
			stringId.setTU("Remote Detonator");
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

		if (creature->getDistanceTo(creatureTarget) > 20.f){
			creature->sendSystemMessage("@cbt_spam:target_out_of_range"); // You are out of range of your target.
			return GENERALERROR;
		}

		if (creatureTarget->isRidingMount()) {
			creature->sendSystemMessage("@error_message:target_mounted_invalid"); // You cannot use this attack on a mounted target. 
			return GENERALERROR;
		}

		if (object->isCreatureObject() && creatureTarget->isAttackableBy(creature)) {
			creatureTarget->setSnaredState(5);
			//creatureTarget->playEffect("clienteffect/carbine_snare.cef", "");
			creatureTarget->playEffect("clienteffect/restuss_event_big_explosion.cef", "");
			creatureTarget->inflictDamage(creatureTarget, CreatureAttribute::HEALTH, 500 + System::random(500), true);
			creatureTarget->sendSystemMessage("@cbt_spam:combat_snared"); // You have been snared!
			creature->addCooldown("explosion", 60 * 1000);

		}
		
		uint32 buffCRC = BuffCRC::FORCE_RANK_SUFFERING; //DURATION
		int duration = 10;
		int loopCount = ((duration/9)-1);
		ManagedReference<SingleUseBuff*> buff = new SingleUseBuff(creatureTarget, buffCRC, duration, BuffType::JEDI, getNameCRC());
		
		 if (!creature->hasBuff(buffCRC)) {
			Locker locker(buff);
			buff->setSpeedMultiplierMod(0.01f);
			creatureTarget->addBuff(buff);
		}

		return doCombatAction(creature, target);
	}
		
};

#endif //REMOTEDETONATORCOMMAND_H_
