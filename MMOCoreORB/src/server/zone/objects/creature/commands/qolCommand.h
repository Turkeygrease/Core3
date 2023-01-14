#ifndef QOLCOMMAND_H_
#define QOLCOMMAND_H_

#include "server/zone/managers/director/DirectorManager.h"
#include "server/zone/objects/player/sui/messagebox/SuiMessageBox.h"

class QolCommand : public QueueCommand {
public:

	QolCommand(const String& name, ZoneProcessServer* server)
		: QueueCommand(name, server) {

	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		StringTokenizer args(arguments.toString());

		String arg = "main";

		if (args.hasMoreTokens()) {
			args.getStringToken(arg);
			if (arg == "lots") {
				return sendLots(creature);
			}else if (arg == "veteranrewards") {
				return sendVeteranRewardInfo(creature);
			}else if (not( (arg == "tools") || (arg == "group") || (arg == "server") || (arg == "perks") || (arg == "dev") )) {
				arg = "main";
			}
		}

		Lua* lua = DirectorManager::instance()->getLuaInstance();

		Reference<LuaFunction*> staffTools = lua->createFunction("qol_menu", arg, 0);
		*staffTools << creature;

		staffTools->callFunction();

		return SUCCESS;
	}

	int sendLots(CreatureObject* creature) const {
		ManagedReference<PlayerObject*> ghost = creature->getPlayerObject();

		if (ghost == nullptr)
			return GENERALERROR;

		int lotsRemaining = ghost->getLotsRemaining();

		StringBuffer body;

		body << "Player Name:\t" << creature->getFirstName() << endl;
		body << "Unused Lots:\t" << String::valueOf(lotsRemaining) << endl << endl;
		body << "Player Structures:";

		for (int i = 0; i < ghost->getTotalOwnedStructureCount(); i++) {
			ManagedReference<StructureObject*> structure = creature->getZoneServer()->getObject(ghost->getOwnedStructure(i)).castTo<StructureObject*>();

			int num = i + 1;
			body << endl << String::valueOf(num) << ". ";

			if (structure == nullptr) {
				body << "nullptr Structure" << endl << endl;
				continue;
			}

			body << "StructureID:\t" << structure->getObjectID() << endl;
			body << "    Name:\t" << structure->getCustomObjectName().toString() << endl;
			body << "    Type:\t" << structure->getObjectTemplate()->getFullTemplateString() << endl;
			body << "    Lots:\t" << String::valueOf(structure->getLotSize()) << endl;

			body << "    Zone:\t";
			Zone* zone = structure->getZone();
			if (zone == nullptr) {
				body << "nullptr" << endl;
			} else {
				body << zone->getZoneName() << endl;
				body << "    World Position:\t" << structure->getWorldPositionX() << ", " << structure->getWorldPositionY() << endl;
			}
		}

		ManagedReference<SuiMessageBox*> box = new SuiMessageBox(creature, 0);
		box->setPromptTitle("(qol) My Lots");
		box->setPromptText(body.toString());
		box->setUsingObject(creature);
		box->setForceCloseDisabled();

		ghost->addSuiBox(box);
		creature->sendMessage(box->generateMessage());

		return SUCCESS;
	}


	int sendVeteranRewardInfo(CreatureObject* creature) const {
		ManagedReference<PlayerObject*> ghost = creature->getPlayerObject();
		PlayerManager* playerManager = server->getZoneServer()->getPlayerManager();

		if (ghost == nullptr || playerManager == nullptr)
			return GENERALERROR;

		StringBuffer body;
		body << "Player Name:\t" << creature->getFirstName() << endl;
		body << "Claimed Rewards:" << endl;
		body << "\tMilestone\tReward"<< endl;
		for( int i = 0; i < playerManager->getNumVeteranRewardMilestones(); i++ ){
			int milestone = playerManager->getVeteranRewardMilestone(i);
			body << "\t" << String::valueOf(milestone);
			String claimedReward = ghost->getChosenVeteranReward(milestone);
			if( claimedReward.isEmpty() ){
				body << "\t\t" << "Unclaimed" << endl;
			}
			else{
				body << "\t\t" << "Claimed Reward" << endl;
			}
		}

		ManagedReference<SuiMessageBox*> box = new SuiMessageBox(creature, 0);
		box->setPromptTitle("(qol) My Veteran Reward Info");
		box->setPromptText(body.toString());
		box->setUsingObject(creature);
		box->setForceCloseDisabled();

		ghost->addSuiBox(box);
		creature->sendMessage(box->generateMessage());

		return SUCCESS;

	}


};

#endif //QolCommand_H_
