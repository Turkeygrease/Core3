
#include "CurrencyBuffMenuComponent.h"
#include "server/zone/objects/creature/CreatureObject.h"
#include "templates/params/creature/CreatureAttribute.h"
#include "server/zone/objects/tangible/wearables/WearableObject.h"
#include "server/zone/objects/player/PlayerObject.h"
#include "server/zone/managers/player/PlayerManager.h"
#include "server/zone/objects/scene/components/ObjectMenuComponent.h"
#include "server/zone/packets/object/ObjectMenuResponse.h"
#include "server/zone/objects/tangible/components/currencyBuffDataComponent.h"
#include "server/zone/packets/object/PlayClientEffectObjectMessage.h"
#include "server/zone/Zone.h"
#include "server/zone/objects/group/GroupObject.h"
#include "server/zone/managers/collision/CollisionManager.h"

void CurrencyBuffMenuComponent::fillObjectMenuResponse(SceneObject* sceneObject, ObjectMenuResponse* menuResponse, CreatureObject* player) const {
	TangibleObjectMenuComponent::fillObjectMenuResponse(sceneObject, menuResponse, player);
	TangibleObject* bracelet = cast<TangibleObject*>(sceneObject);

	if (bracelet == NULL)
		return;

	CurrencyBuffDataComponent* data = cast<CurrencyBuffDataComponent*>(bracelet->getDataObjectComponent()->get());

	if (data == NULL || !data->isCurrencyBuffData())
		return;

	String buffType = data->getBuffType();

//validate player faction
	if (buffType[0] == '0'){
		if (player->getFactionStatus() != 0)
			return;
	}else if (buffType[0] == '1'){
		if (player->getFactionStatus() != 2)
			return;
		if (buffType[2] == '1'){
			if (!player->isImperial())
				return;
		}else if (buffType[2] == '2'){
			if (!player->isRebel())
				return;
		}else
			return;
	}else
		return;


	if (data->getCharges() > 0){
		if (buffType[1] =='0'){
			menuResponse->addRadialMenuItem(20, 3, "Combat Enhance Player (cost:1 Use)");
			if ((buffType[3] == '1')||(buffType[3]=='2'))
				menuResponse->addRadialMenuItemToRadialID(20, 23, 3, "Combat Enhance Group (cost:2 Uses)");
			if (buffType[3] == '2')
				menuResponse->addRadialMenuItemToRadialID(20, 24, 3, "Combat Enhance Area (cost:3 Uses)");
		}else if (buffType[1]=='1'){
			menuResponse->addRadialMenuItem(21, 3, "Mind Enhance Player (cost:1 Use)");
			if ((buffType[3] == '1')||(buffType[3]=='2'))
				menuResponse->addRadialMenuItemToRadialID(21, 25, 3, "Mind Enhance Group (cost:2 Uses)");
			if (buffType[3] == '2')
				menuResponse->addRadialMenuItemToRadialID(21, 26, 3, "Mind Enhance Area (cost:3 Uses)");
		}
	}else
		menuResponse->addRadialMenuItem(22, 3, "Recharge Band (whole lotta exp)");
}

int CurrencyBuffMenuComponent::handleObjectMenuSelect(SceneObject* sceneObject, CreatureObject* player, byte selectedID) const {
//validate buffer:

	if (!player->isPlayerCreature())
		return 0;

	if ((selectedID == 11)||(selectedID == 12)||(selectedID == 7)||(selectedID == 14))
		return TangibleObjectMenuComponent::handleObjectMenuSelect(sceneObject, player, selectedID);

	if (player->isDead()) {
		player->sendSystemMessage("Your are too DEAD to provide enhancements.");
		return 0;
	}

	if (!sceneObject->isASubChildOf(player))
		return 0;

	WearableObject* wearable = cast<WearableObject*>(sceneObject);

	if (wearable == NULL)
		return 0;

	if (!wearable->isEquipped()) {
		player->sendSystemMessage("Buff bracelets must be equipped to use");
		return 0;
	}

//test for and handle rechage selection
	if (selectedID == 22) {
		//process refill uses TODO
		player->sendSystemMessage("(DEV-TEAM)..Sorry, this feature is not yet implemented.");
	}

//check cooldown
	if (!player->checkCooldownRecovery("Currency_Buff")) {
		Time* timeRemaining = player->getCooldownTime("Currency_Buff");
		StringIdChatParameter cooldown("quest/hero_of_tatooine/system_messages", "restore_not_yet");
		cooldown.setTO(getCooldownString(timeRemaining->miliDifference() * -1));
		player->sendSystemMessage(cooldown);
		return 0;
	}

//validate data

	CurrencyBuffDataComponent* data = cast<CurrencyBuffDataComponent*>(wearable->getDataObjectComponent()->get());

	if (data == NULL || !data->isCurrencyBuffData())
		return 0;

//re-check player faction and charges for back end (anti-hook code)
	String buffType = data->getBuffType();
	if (((buffType[2]=='0')&(player->getFactionStatus() == 2))||((buffType[2]=='1')&(!player->isImperial()))||((buffType[2]=='2')&(!player->isRebel())))
		return 0;

	int charges = data->getCharges();

	if (charges <= 0)
		return 0;

//validate selection:

	int cost = 1;
	//single target buff selected?
	if ((selectedID == 20)||(selectedID == 21)) {
		buffType[4] = '0';

	//group buff selected?
	}else if ((selectedID == 23)||(selectedID == 25)) {
		if ((buffType[3] != '1') & (buffType[3] != '2'))
			return 0; //invalid option match
		buffType[4] = '1';
		cost += 1;

	//area buff selected?
	}else if ((selectedID == 24)||(selectedID == 26)) {
		if (buffType[3] != '2')
			return 0; //invalid option match
		buffType[4] = '2';
		cost += 2;

	//invalid or NULL option selected
	} else {
		return TangibleObjectMenuComponent::handleObjectMenuSelect(sceneObject, player, selectedID);
	}

	if (charges < cost){
		player->sendSystemMessage("Insufficient charges remain to use this skill.");
	}

	data->setBuffType(buffType);

// Determine Bracelet type and set up attribute variables

	bool skill = false;
	int power = 1000;
	String rules;
	String quality;
	int range;
	int buff;

	if(buffType[1] == '0'){ //is doc buff?
		if(buffType[0] == '1'){ //pvp buff
			switch(buffType[3]){ //what tier is the buff
				case '0':{power = 3400; skill = player->hasSkill("gcw_medic_novice"); break;}//skill = player->hasSkill("  ")
				case '1':{power = 3600; skill = player->hasSkill("gcw_medic_01"); break;}
				case '2':{power = 3800; skill = player->hasSkill("gcw_medic_03"); break;}
			}
		}else{ //pve buff
			switch(buffType[3]){ //what tier is the buff
				case '0':{power = 3000; skill = player->hasSkill("science_doctor_novice"); break;}
				case '1':{power = 3200; skill = player->hasSkill("science_doctor_ability_04"); break;}
				case '2':{power = 3400; skill = player->hasSkill("science_doctor_master"); break;}
			}				
		}
	}else if (buffType[1] == '1'){ //is ent buff
		if(buffType[0] == '1'){ //pvp buff
			switch(buffType[3]){ //what tier is the buff
				case '0':{power = 1200; skill = (player->hasSkill("social_entertainer_master") || player->hasSkill("social_dancer_novice") || player->hasSkill("social_musician_novice")); break;}
				case '1':{power = 1375; skill = (player->hasSkill("social_musician_master") || player->hasSkill("social_dancer_master")); break;}
				case '2':{power = 1550; skill = (player->hasSkill("social_dancer_master") & player->hasSkill("social_musician_master")); break;}
			}
		}else{ //pve buff
			switch(buffType[3]){ //what tier is the buff
				case '0':{power = 1050; skill = (player->hasSkill("social_entertainer_master") || player->hasSkill("social_dancer_novice") || player->hasSkill("social_musician_novice")); break;}
				case '1':{power = 1125; skill = (player->hasSkill("social_musician_master") || player->hasSkill("social_dancer_master")); break;}
				case '2':{power = 1200; skill = (player->hasSkill("social_dancer_master") || player->hasSkill("social_musician_master")); break;}
			}				
		}
	}else 
		return 0;

	if (!skill){
		player->sendSystemMessage("You lack the required skill to use this enhancement.");
		return 0;
	}

//calculate power and duration

	int duration = 0;
	duration = calcPower(player, buffType[1]);//get skill mods
	power += (duration*3); /*Power X Skill multiplier*/
	duration = ((duration*4)+((buffType[3]-47)*300))+7200;/*3600 = 1hr as base duration*/

//Disperse buffs

	bool message = true;
	bool didBuff = false;
	PlayerManager* pm = player->getZoneServer()->getPlayerManager();

	//is target buff?
	if (cost == 1){
		ManagedReference<CreatureObject*> target = player->getZoneServer()->getObject(player->getTargetID()).castTo<CreatureObject*>();

		if (target == NULL || !target->isPlayerCreature()){
			target = player;
		}


		if (target == player){
			if (buffType[1] == '0'){
				message = message && pm->doEnhanceCharacter(0x98321369, player, power, duration, BuffType::MEDICAL, 0,0); // medical_enhance_health
				message = message && pm->doEnhanceCharacter(0x815D85C5, player, power, duration, BuffType::MEDICAL, 1,0); // medical_enhance_strength
				message = message && pm->doEnhanceCharacter(0x7F86D2C6, player, power, duration, BuffType::MEDICAL, 2,0); // medical_enhance_constitution
				message = message && pm->doEnhanceCharacter(0x4BF616E2, player, power, duration, BuffType::MEDICAL, 3,0); // medical_enhance_action
				message = message && pm->doEnhanceCharacter(0x71B5C842, player, power, duration, BuffType::MEDICAL, 4,0); // medical_enhance_quickness
				message = message && pm->doEnhanceCharacter(0xED0040D9, player, power, duration, BuffType::MEDICAL, 5,0); // medical_enhance_stamina
			}else if (buffType[1] == '1'){
				message = message && pm->doEnhanceCharacter(0x11C1772E, player, power, duration, BuffType::PERFORMANCE, 6,0); // performance_enhance_dance_mind
				message = message && pm->doEnhanceCharacter(0x2E77F586, player, power, duration, BuffType::PERFORMANCE, 7,0); // performance_enhance_music_focus
				message = message && pm->doEnhanceCharacter(0x3EC6FCB6, player, power, duration, BuffType::PERFORMANCE, 8,0); // performance_enhance_music_willpower
			}else
				return 0;
		}else if (target->isInRange(player, 10.f)){
			if (!CollisionManager::checkLineOfSight(player, target)) {
				player->sendSystemMessage("@combat_effects:cansee_fail");// You cannot see your target.
				return 0;
			}

			if (!(checkTarget(target, buffType[2]-48))){
				player->sendSystemMessage("Target is currently unable to recieve this enhancement.");
				return 0;
			}

			Locker clocker(target, player);//lock target
			if (buffType[1] == '0'){
				message = message && pm->doEnhanceCharacter(0x98321369, target, power, duration, BuffType::MEDICAL, 0,0); // medical_enhance_health
				message = message && pm->doEnhanceCharacter(0x815D85C5, target, power, duration, BuffType::MEDICAL, 1,0); // medical_enhance_strength
				message = message && pm->doEnhanceCharacter(0x7F86D2C6, target, power, duration, BuffType::MEDICAL, 2,0); // medical_enhance_constitution
				message = message && pm->doEnhanceCharacter(0x4BF616E2, target, power, duration, BuffType::MEDICAL, 3,0); // medical_enhance_action
				message = message && pm->doEnhanceCharacter(0x71B5C842, target, power, duration, BuffType::MEDICAL, 4,0); // medical_enhance_quickness
				message = message && pm->doEnhanceCharacter(0xED0040D9, target, power, duration, BuffType::MEDICAL, 5,0); // medical_enhance_stamina
			}else if (buffType[1] == '1'){
				message = message && pm->doEnhanceCharacter(0x11C1772E, target, power, duration, BuffType::PERFORMANCE, 6,0); // performance_enhance_dance_mind
				message = message && pm->doEnhanceCharacter(0x2E77F586, target, power, duration, BuffType::PERFORMANCE, 7,0); // performance_enhance_music_focus
				message = message && pm->doEnhanceCharacter(0x3EC6FCB6, target, power, duration, BuffType::PERFORMANCE, 8,0); // performance_enhance_music_willpower
			}else
				return 0;
		}else{
			player->sendSystemMessage("Your target is out of range for this command.");
			player->addCooldown("Currency_Buff", 30000);
			return 0;
		}

		if (!message){
			player->sendSystemMessage("You cannot currently provide further Enhancement.");
			player->addCooldown("Currency_Buff", 30000);
			return 0;
		}

		if (player == target)
			player->sendSystemMessage("Your focus on the bracelet grants you an Enhancement.");
		else{
			player->sendSystemMessage("Your focus on the bracelet grants an Enhancement to: "+ target->getFirstName() +".");
			target->sendSystemMessage(player->getFirstName() + ":  bestows an Enhancement.");
		}
	//is group buff?
	}else if (cost == 2){
		ManagedReference<GroupObject*> group = player->getGroup();
		if (group == NULL) {
			player->sendSystemMessage("@error_message:not_grouped");
			return 0;
		}

		for (int i = 0; i < group->getGroupSize(); ++i) {
			ManagedReference<CreatureObject*> target = group->getGroupMember(i);
			if (target == NULL || !target->isPlayerCreature())
				continue;

			if (!target->isInRange(player, 35.f))
				continue;

			Locker clocker(target, player);

			if (!CollisionManager::checkLineOfSight(player, target))
				continue;

			if (!(checkTarget(target, buffType[2]-48)))
				continue;

			message = true;
			if (buffType[1] == '0'){
				message = message && pm->doEnhanceCharacter(0x98321369, target, power, duration, BuffType::MEDICAL, 0,0); // medical_enhance_health
				message = message && pm->doEnhanceCharacter(0x815D85C5, target, power, duration, BuffType::MEDICAL, 1,0); // medical_enhance_strength
				message = message && pm->doEnhanceCharacter(0x7F86D2C6, target, power, duration, BuffType::MEDICAL, 2,0); // medical_enhance_constitution
				message = message && pm->doEnhanceCharacter(0x4BF616E2, target, power, duration, BuffType::MEDICAL, 3,0); // medical_enhance_action
				message = message && pm->doEnhanceCharacter(0x71B5C842, target, power, duration, BuffType::MEDICAL, 4,0); // medical_enhance_quickness
				message = message && pm->doEnhanceCharacter(0xED0040D9, target, power, duration, BuffType::MEDICAL, 5,0); // medical_enhance_stamina
			}else if (buffType[1] == '1'){
				message = message && pm->doEnhanceCharacter(0x11C1772E, target, power, duration, BuffType::PERFORMANCE, 6,0); // performance_enhance_dance_mind
				message = message && pm->doEnhanceCharacter(0x2E77F586, target, power, duration, BuffType::PERFORMANCE, 7,0); // performance_enhance_music_focus
				message = message && pm->doEnhanceCharacter(0x3EC6FCB6, target, power, duration, BuffType::PERFORMANCE, 8,0); // performance_enhance_music_willpower
			}else
				return 0;
			
			if (player == target)
				player->sendSystemMessage("The Force courses inside you and attempts to Enhance your group.");
			else
				target->sendSystemMessage(player->getFirstName() + ": bestows a group Enhancement.");


			if(message)
				didBuff = true;
		}
		if (!didBuff){
				player->sendSystemMessage("There is currently no valid targets for enhancement in your group.");
				player->addCooldown("Currency_Buff", 60000);
				return 0;
			}

	//is area buff?
	}else if (cost == 3){
		//player->sendSystemMessage("Area Buffs have not been implemented yet.");

		Zone* thisZone = player->getZone();

		if (thisZone == NULL) {
			return 0;
		}

		Reference<SortedVector<ManagedReference<QuadTreeEntry*> >*> closeObjects = new SortedVector<ManagedReference<QuadTreeEntry*> >();
		thisZone->getInRangeObjects(player->getWorldPositionX(), player->getWorldPositionY(), 35, closeObjects, true);
		int numPlayers = 0;

		for (int i = 0; i < closeObjects->size(); ++i) {
			SceneObject* object = cast<SceneObject*>(closeObjects->get(i).get());

			if (object == NULL || !object->isPlayerCreature())
				continue;

			CreatureObject* pCob = object->asCreatureObject();

			if (!object->isInRange(player, 35.f))
				continue;

			if (pCob == NULL || pCob->isInvisible())
				continue;

			Locker clocker(pCob, player);

			if (!CollisionManager::checkLineOfSight(player, pCob))
				continue;

			if (!(checkTarget(pCob, buffType[2]-48)))
				continue;

			message = true;
			if (buffType[1] == '0'){
				message = message && pm->doEnhanceCharacter(0x98321369, pCob, power, duration, BuffType::MEDICAL, 0,0); // medical_enhance_health
				message = message && pm->doEnhanceCharacter(0x815D85C5, pCob, power, duration, BuffType::MEDICAL, 1,0); // medical_enhance_strength
				message = message && pm->doEnhanceCharacter(0x7F86D2C6, pCob, power, duration, BuffType::MEDICAL, 2,0); // medical_enhance_constitution
				message = message && pm->doEnhanceCharacter(0x4BF616E2, pCob, power, duration, BuffType::MEDICAL, 3,0); // medical_enhance_action
				message = message && pm->doEnhanceCharacter(0x71B5C842, pCob, power, duration, BuffType::MEDICAL, 4,0); // medical_enhance_quickness
				message = message && pm->doEnhanceCharacter(0xED0040D9, pCob, power, duration, BuffType::MEDICAL, 5,0); // medical_enhance_stamina
			}else if (buffType[1] == '1'){
				message = message && pm->doEnhanceCharacter(0x11C1772E, pCob, power, duration, BuffType::PERFORMANCE, 6,0); // performance_enhance_dance_mind
				message = message && pm->doEnhanceCharacter(0x2E77F586, pCob, power, duration, BuffType::PERFORMANCE, 7,0); // performance_enhance_music_focus
				message = message && pm->doEnhanceCharacter(0x3EC6FCB6, pCob, power, duration, BuffType::PERFORMANCE, 8,0); // performance_enhance_music_willpower
			}else
				return 0;

 			if (player == pCob)
				player->sendSystemMessage("The Force surges and you Attempt to Enhance the entire area.");
			else
				pCob->sendSystemMessage(player->getFirstName() + ": bestows an Area Enhancement.");

			if(message)
				didBuff = true;
		}
			if (!didBuff){
				player->sendSystemMessage("There is currently no valid targets for enhancement in this area.");
				player->addCooldown("Currency_Buff", 60000);
				return 0;
			}
	//invalid cost value
	}else
		return 0;

	data->setCharges(charges - cost);

	int luck = player->getSkillMod("force_luck");
		//if (luck > 0){} TODO add in luck bonus of some type

	//broadcast client effect to area (electric charge in 
	PlayClientEffectObjectMessage* effect = new PlayClientEffectObjectMessage(player, "clienteffect/trap_electric_01.cef", "hold_r");
	player->broadcastMessage(effect, true);

	int cooldown = (cost * 180000); //3 mins per use spent on the buff
	player->addCooldown("Currency_Buff", cooldown);

	return 0;
}

String CurrencyBuffMenuComponent::getCooldownString(uint32 delta) const {

	int seconds = delta / 1000;

	int hours = seconds / 3600;
	seconds -= hours * 3600;

	int minutes = seconds / 60;
	seconds -= minutes * 60;

	StringBuffer buffer;

	if (hours > 0) {
		buffer << hours << " hour";

		if (hours > 1)
			buffer << "s";

		if (minutes > 0 || seconds > 0)
			buffer << ", ";
	}

	if (minutes > 0) {
		buffer << minutes << " minute";

		if (minutes > 1)
			buffer << "s";

		if (seconds > 0)
			buffer << ", ";
	}

	if (seconds > 0) {
		buffer << seconds << " second";

		if (seconds > 1)
			buffer << "s";
	}

	return buffer.toString();
}

int CurrencyBuffMenuComponent::calcPower(CreatureObject* creature, int type) const{
	int maxBuffStrength = 0.0f;
	if(type == '0') { // Doctor Buff being applied
		maxBuffStrength += creature->getSkillMod("healing_ability");
		maxBuffStrength += creature->getSkillMod("combat_healing_ability");
	}else { // Entertainer Buff being applied
		maxBuffStrength += creature->getSkillMod("healing_dance_mind");
		maxBuffStrength += creature->getSkillMod("healing_music_mind");
		maxBuffStrength /= 2;
	}
	return maxBuffStrength;
}

bool CurrencyBuffMenuComponent::checkTarget(CreatureObject* target, int faction) const{

	if (target->isDead()) {
		target->sendSystemMessage("Your are too DEAD to recieve enhancements.");
		return false;

	}else if (target->isIncapacitated()) {
		target->sendSystemMessage("Your are too unconcious to recieve enhancements.");
		return false;

	}else if (target->isFeigningDeath()) {
		target->sendSystemMessage("Your are too fake DEAD to recieve enhancements.");
		return false;

	}else if (target->isInCombat()) {
		target->sendSystemMessage("You cannot recieve enhancements while in combat.");
		return false;

	}else if ((faction == 0)&(target->getFactionStatus() == 2)) {
			target->sendSystemMessage("You cannot recieve Neutral enhancements while SF.");
			return 0;

	}else if ((faction == 1)&(!target->isImperial())){
		target->sendSystemMessage("You cannot recieve Imperial enhancements while Rebel.");
		return false;

	}else if ((faction == 2)&(!target->isRebel())){
		target->sendSystemMessage("You cannot recieve Rebel enhancements while Imperial.");
		return false;
	}
	return true;
}

/* TODO this following could be used to add in a cm buff item for pets
} else if (targetObject->isPet()) {
			AiAgent* pet = cast<AiAgent*>( targetObject.get());

			Locker clocker(pet, creature);

			if (!CollisionManager::checkLineOfSight(creature, pet)) {
				creature->sendSystemMessage("@combat_effects:cansee_fail");// You cannot see your target.
				return GENERALERROR;
			}

			if (!pet->isIncapacitated()){
				creature->sendSystemMessage("@error_message:target_not_incapacitated"); //You cannot perform the death blow. Your target is not incapacitated.
				return GENERALERROR;
			}

			if (pet->isAttackableBy(creature) && checkDistance(pet, creature, 5)) {
				PetManager* petManager = server->getZoneServer()->getPetManager();

				petManager->killPet(creature, pet);
}
*/
