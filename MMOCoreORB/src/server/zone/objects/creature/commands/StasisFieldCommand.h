/**
 * file STASISFIELDCOMMAND_H_

 */

#ifndef STASISFIELDCOMMAND_H_
#define STASISFIELDCOMMAND_H_

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/managers/combat/CombatManager.h"
#include "CombatQueueCommand.h"
#include "server/zone/objects/creature/buffs/Buff.h"
#include "server/zone/objects/creature/buffs/DelayedBuff.h"
#include "server/zone/packets/object/CombatAction.h"
#include "server/zone/objects/player/FactionStatus.h"
#include "server/zone/objects/creature/buffs/SingleUseBuff.h"
#include "server/zone/objects/creature/events/StasisFieldAnimationTask.h"

class StasisFieldCommand : public CombatQueueCommand {
public:

	StasisFieldCommand(const String& name, ZoneProcessServer* server)
		: CombatQueueCommand(name, server) {
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;
					
		// Action cost of skill.
		int actionCost = 650;

		if (creature->getHAM(CreatureAttribute::ACTION) < actionCost) {
			creature->sendSystemMessage("@cbt_spam:medic_stasisfield_too_tired"); // You do not have enough action to activate your Stasis Field.
			return false;
		}
		
		//unsigned int buffCRC = STRING_HASHCODE("STASIS_SELF_DURATION");
		//uint32 buffCRC = BuffCRC::JEDI_FORCE_ARMOR_2; //DURATION
		unsigned int buffCRC = STRING_HASHCODE("JEDI_FORCE_ARMOR_All");
		unsigned int buffCRC2 = STRING_HASHCODE("STASIS_SELF_COOLDOWN");

		int duration = 30;
		int loopCount = ((duration/9)-1);
		
		int cooldown = 300;
		//ManagedReference<Buff*> buff = new Buff(creature, buffCRC, duration, BuffType::OTHER);
		ManagedReference<SingleUseBuff*> buff = new SingleUseBuff(creature, buffCRC, duration, BuffType::JEDI, getNameCRC());
		ManagedReference<Buff*> buff2 = new Buff(creature, buffCRC2, cooldown, BuffType::OTHER);

		if (creature->hasBuff(buffCRC2)) {
			creature->sendSystemMessage("@cbt_spam:medic_stasisfield_fail"); // You cannot activate a Stasis Field at this time!
		} else if (!creature->hasBuff(buffCRC2)) {
			Locker locker(buff);
			Locker locker2(buff2);
			creature->sendSystemMessage("@cbt_spam:medic_stasisfield_activate"); // You activate a Stasis Field to protect yourself.
			buff->setSkillModifier("force_armor", 75);
			buff->setSpeedMultiplierMod(0.01f);
			creature->addBuff(buff);
			creature->addBuff(buff2);
			creature->inflictDamage(creature, CreatureAttribute::ACTION, actionCost, false);
			
			creature->playEffect("clienteffect/medic_stasis.cef", "");
			
			Reference<Task*> stasisFieldAnimationTask = new StasisFieldAnimationTask(creature, loopCount); //crc,
			creature->addPendingTask("stasis_animation", stasisFieldAnimationTask, 9000);
		} else {
			creature->sendSystemMessage("@cbt_spam:medic_stasisfield_protected"); // You are alreadying using a Stasis Field.
		}

		return SUCCESS;
	}

};

#endif
