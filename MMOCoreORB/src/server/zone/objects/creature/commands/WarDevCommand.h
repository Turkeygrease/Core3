/*
				Copyright R. Bassett Jr.

				ALL CREDITS GO TO THE ORIGINAL AUTHOR ABOVE - ADAPTED FOR WARFRONT SERVER USE

				See file COPYING for copying conditions.*/

#ifndef WARDEVCOMMAND
#define WARDEVCOMMAND

#include "server/zone/objects/scene/SceneObject.h"
#include "server/zone/managers/director/DirectorManager.h"
// #include "server/ServerCore.h"

class WarDevCommand : public QueueCommand {
public:

	WarDevCommand(const String& name, ZoneProcessServer* server): QueueCommand(name, server) {
	}

	int doQueueCommand(CreatureObject* creature, const uint64& target, const UnicodeString& arguments) const {
		creature->sendSystemMessage("Attempted to use WarDev command!");

		if (!checkStateMask(creature))
			return INVALIDSTATE;

		if (!checkInvalidLocomotions(creature))
			return INVALIDLOCOMOTION;

		if (!creature->isPlayerCreature())
			return GENERALERROR;

		ManagedReference<PlayerObject*> ghost = creature->getPlayerObject();

		if (ghost == nullptr)
			return GENERALERROR;

		int adminLevelCheck = ghost->getAdminLevel();

		ResourceManager* resMan = creature->getZoneServer()->getResourceManager();

		Locker locker(resMan);

		StringTokenizer args(arguments.toString());

		try {
			String command;

			if(args.hasMoreTokens()){
				args.getStringToken(command);
				
				command = command.toLowerCase();

				if(command == "admin") {
					if (adminLevelCheck != 15){
						creature->sendSystemMessage("Sorry, /wardev admin commands require administrator privileges.");
						return GENERALERROR;
					}

					String adminCommand;

					if(args.hasMoreTokens()){
						args.getStringToken(adminCommand);
						adminCommand = adminCommand.toLowerCase();

						// Added new target-based commands
						if (target == 0 && (adminCommand == "spoutmobile" || adminCommand == "spoutobject" || adminCommand == "spoutstatic" || adminCommand == "spoutcreoquat" || adminCommand == "spoutcreoquatvis" || adminCommand == "deletetargobj")){
							creature->sendSystemMessage("Target required for this WarDev command!");
							return GENERALERROR;
						}

						ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(target, false);

						if(adminCommand == "spoutmobile") {
							if(!object->isCreatureObject()){
							   creature->sendSystemMessage("Target must be a creature for: /wardev admin spoutMobile [file_name]");
							   return GENERALERROR;
							}

							String templateFile = object->getObjectTemplate()->getFullTemplateString();

							if (templateFile.contains("junk") || templateFile.contains("vehicle") || templateFile.contains("vendor")){
							   creature->sendSystemMessage("Sorry, /wardev admin spoutMobile: " + templateFile);
							   return GENERALERROR; // Beause they crash the server if we try to use them as an AI agent when getting the mob name.
							}
							spout(creature, &args, formatSpoutText(creature, target, 1));
						} else if(adminCommand == "spoutobject") {
							if(object->isCreatureObject()){
							   creature->sendSystemMessage("Target must be a tangible or static object for: /wardev admin spoutObject [file_name]");
							   return GENERALERROR;
							}
							spout(creature, &args, formatSpoutText(creature, target, 2));
						} else if(adminCommand == "spoutstatic") {
							if(object->isCreatureObject()){
							   creature->sendSystemMessage("Target must be a tangible or static object for: /wardev admin spoutObject [file_name]");
							   return GENERALERROR;
							}
							spout(creature, &args, formatSpoutText(creature, target, 3));
						} else if(adminCommand == "spoutonme") {
							spout(creature, &args, formatSpoutText(creature, target, 4));
						} else if(adminCommand == "spoutonmevis") {
							spout(creature, &args, formatSpoutText(creature, target, 5));
						} else if(adminCommand == "spoutcreoquat") {
							// Paranoid anti-segfault check, should not need this.
							if (target != 0) {
								if(!object->isCreatureObject()){
									creature->sendSystemMessage("Target is NOT a Creature! HELP!");
									return GENERALERROR;
								}
								spout(creature, &args, formatSpoutText(creature, target, 6));
							}
						} else if(adminCommand == "spoutcreoquatvis") {
							// Paranoid anti-segfault check, should not need this.
							if (target != 0) {
								if(!object->isCreatureObject()){
									creature->sendSystemMessage("Target is NOT a Creature! HELP!");
									return GENERALERROR;
								}
								spout(creature, &args, formatSpoutText(creature, target, 7));
							}
						} else if(adminCommand == "deletetargobj") {
							// Paranoid anti-segfault check, should not need this.
							if (target != 0) {
								if(object->isCreatureObject()){
									creature->sendSystemMessage("Target is NOT an Object! HELP!");
									return GENERALERROR;
								}
							}
							spout(creature, &args, formatSpoutText(creature, target, 8), adminCommand);
						} else if(adminCommand == "spoutroom") {
							spout(creature, &args, formatSpoutTextMulti(creature, 1));
						} else if(adminCommand == "spoutbuilding") {
							spout(creature, &args, formatSpoutTextMulti(creature, 0));
						} else if(adminCommand == "decor") {
							decor(creature);
						} else if(adminCommand == "placestructure") {
							wardevPlaceStructure(creature);
						} else {
							throw Exception(); // Used: /wardev admin <wrong>
						}
					} else {
						throw Exception(); // Used: /wardev admin <blank>
					}
				} else if(command == "help") {
					StringBuffer text;

					

					if (adminLevelCheck == 15){
						text << endl;
						text << "- - - - - - - - - - - - - - - - - - -" << endl;
						text << "wardev Development: The Command" << endl;
						text << "- - - - - - - - - - - - - - - - - - -" << endl;
						text << endl;
						text << "- - - - - - - - - - - - - - - - - - -" << endl;
						text << "Admin syntax: /wardev admin <option> [params]" << endl;
						text << "- - - - - - - - - - - - - - - - - - -" << endl;
						text << "/wardev admin decor" << endl;
						text << "- Opens a list of decorative items that may be used anywhere." << endl;
						text << endl;
						text << "- - - - - - - - - - - - - - - - - - -" << endl;
						text << "Screenplay Builder Commands:" << endl;
						text << "Writes screenplay calls in bin/custom_scripts/spout/file_name.lua on the server." << endl;
						text << "- - - - - - - - - - - - - - - - - - -" << endl;
						text << "/wardev admin spoutMobile [file_name]" << endl;
						text << "- spawnMobile for the targeted creature."  << endl;
						text << "/wardev admin spoutOnme [file_name]"  << endl;
						text << "- Old command that only returns xyz 'spawnMobile' based on where you are standing and facing."  << endl;
						// ------------------------------------------
						// NEW CUSTOM WF -- Boogles
						// spoutonmevis
						text << "/wardev admin spoutOnMeVis [file_name]"  << endl;
						text << "- New command that will spawn a visual helper NPC based on where you are standing and facing. Default mobile type: commoner."  << endl;
						// spoutcreoquat
						text << "/wardev admin spoutCreoQuat [file_name]"  << endl;
						text << "- New command that will return the Quaternian positional values needed for objects based on xyz and facing of a targed CreatureObject."  << endl;
						// spoutcreoquatvis
						text << "/wardev admin spoutCreoQuatVis [file_name]"  << endl;
						text << "- New command that will return the Quaternian positional values needed for objects, and spawns a helper Object, based on xyz and facing of a targed CreatureObject."  << endl;
						// deletetargobj
						text << "/wardev admin deleteTargObject [file_name]"  << endl;
						text << "- New command that will delete a targetable object from the world."  << endl;
						// NEW CUSTOM WF -- Boogles
						// ------------------------------------------
						text << "/wardev admin spoutObject [file_name]"  << endl;
						text << "- spawnSceneObject for the targeted object."  << endl;
						text << "/wardev admin spoutStatic [file_name]"  << endl;
						text << "- spawnSceneObject for the static version of a LoH specific outdoor decor items."  << endl;
						text << "/wardev admin spoutRoom [file_name]"  << endl;
						text << "- spawnSceneObject for all decorations in the room (cell) you are standing in. Layout iff loaded items excluded."  << endl;
						text << "/wardev admin spoutBuilding [file_name]"  << endl;
						text << "- spawnSceneObject for all decorations in the whole building you are standing in. Layout iff loaded items excluded."  << endl;
						text << endl;
					}
					creature->sendSystemMessage(text.toString());
				} else {
					throw Exception(); // Used: /wardev <wrong>
				}
			} else {
				throw Exception();
			}
		} catch (Exception& e){
			creature->sendSystemMessage("Invalid arguments for wardev command. Help: /wardev help");
		}

		return SUCCESS;
	}

	/* Legend of wardev
	 * Helpful Admin Commands
	 */

	String formatSpoutText(CreatureObject* creature, const uint64& target, int textType) const {
		ManagedReference<SceneObject*> object = server->getZoneServer()->getObject(target, false);

		String planetName = "";
		String templateFile = "";

		if (object == nullptr){
			planetName = creature->getZone()->getZoneName();
		} else {
			planetName = object->getZone()->getZoneName();
			templateFile = object->getObjectTemplate()->getFullTemplateString();
		}

		StringBuffer text;

		if (textType == 1){
			int angle = object->getDirectionAngle();

			AiAgent* mob = object.castTo<AiAgent*> ();
			const CreatureTemplate* creatureTemplate = mob->getCreatureTemplate();
			String mobileName = creatureTemplate->getTemplateName();

			text << "spawnMobile(\"" << planetName << "\", " <<  "\"" << mobileName << "\", 1, ";

			if (object->getParent() != nullptr && object->getParent().get()->isCellObject()) {
				// Inside
				ManagedReference<CellObject*> cell = cast<CellObject*>( object->getParent().get().get());
				Vector3 cellPosition = object->getPosition();

				text << cellPosition.getX() << ", " << cellPosition.getZ() << ", " << cellPosition.getY() << ", " << angle << ", " << cell->getObjectID() << ")";
			}else {
				// Outside
				Vector3 worldPosition = object->getWorldPosition();

				text << worldPosition.getX() << ", " << worldPosition.getZ() << ", " << worldPosition.getY() << ", " << angle << ", " << "0" << ")";
			}
			// Returning: spawnMobile("planet", "mobileTemplate", 1, x, z, y, heading, cellid)
		} else if (textType == 2){
			text << "spawnSceneObject(\"" << planetName << "\", \"" << templateFile << "\", ";

			if (object->getParent() != nullptr && object->getParent().get()->isCellObject()) {
				// Inside
				ManagedReference<CellObject*> cell = cast<CellObject*>( object->getParent().get().get());
				Vector3 cellPosition = object->getPosition();

				text << cellPosition.getX() << ", " << cellPosition.getZ() << ", " << cellPosition.getY() << ", " << cell->getObjectID() << ", ";
			}else {
				// Outside
				Vector3 worldPosition = object->getWorldPosition();
				text << worldPosition.getX() << ", " << worldPosition.getZ() << ", " << worldPosition.getY() << ", " << "0" << ", ";
			}

			const Quaternion* dir = object->getDirection();
			text << dir->getW() << ", " << dir->getX() << ", " << dir->getY() << ", " << dir->getZ() << ")";
			// Returning: spawnSceneObject("planet", "objectTemplateFilePathAndName", x, z, y, cellNumber, dw, dx, dy, dz>
		} else if (textType == 3){
			if (!templateFile.contains("wardev/decoration")){
				creature->sendSystemMessage("Error: Target object must be a decendant of object/tangible/wardev/decoration/");
				throw Exception();
			}

			// Examples:
			// object/tangible/wardev/decoration/building/tatooine/filler_building_tatt_style01_01.lua
			// object/tangible/wardev/decoration/structure/tatooine/antenna_tatt_style_2.lua
			// get changed to
			// object/building/tatooine/filler_building_tatt_style01_01.lua
			// object/static/structure/tatooine/antenna_tatt_style_2.iff

			if (templateFile.contains("decoration/building")){
				templateFile = templateFile.replaceAll("tangible/wardev/decoration/", ""); // Fix path for filler type buildings
			} else {
				templateFile = templateFile.replaceAll("tangible/wardev/decoration", "static"); // Fix path for static objects
			}

			text << "spawnSceneObject(\"" << planetName << "\", \"" << templateFile << "\", ";

			if (object->getParent() != nullptr && object->getParent().get()->isCellObject()) {
				// Inside
				ManagedReference<CellObject*> cell = cast<CellObject*>( object->getParent().get().get());
				Vector3 cellPosition = object->getPosition();

				text << cellPosition.getX() << ", " << cellPosition.getZ() << ", " << cellPosition.getY() << ", " << cell->getObjectID() << ", ";
			}else {
				// Outside
				Vector3 worldPosition = object->getWorldPosition();
				text << worldPosition.getX() << ", " << worldPosition.getZ() << ", " << worldPosition.getY() << ", " << "0" << ", ";
			}

			const Quaternion* dir = object->getDirection();

			text << dir->getW() << ", " << dir->getX() << ", " << dir->getY() << ", " << dir->getZ() << ")";

			// Returning: spawnSceneObject("planet", "staticObjectTemplateFilePathAndName", x, z, y, cellNumber, dw, dx, dy, dz>
		} else if (textType == 4){
			int angle = creature->getDirectionAngle();

			text << "spawnMobile(\"" << planetName << "\", " <<  "\"commoner" << "\", 1, ";

			if (creature->getParent() != nullptr && creature->getParent().get()->isCellObject()) {
				// Inside
				ManagedReference<CellObject*> cell = cast<CellObject*>( creature->getParent().get().get());
				Vector3 cellPosition = creature->getPosition();

				text << cellPosition.getX() << ", " << cellPosition.getZ() << ", " << cellPosition.getY() << ", " << angle << ", " << cell->getObjectID() << ")";
			}else {
				// Outside
				Vector3 worldPosition = creature->getWorldPosition();

				text << worldPosition.getX() << ", " << worldPosition.getZ() << ", " << worldPosition.getY() << ", " << angle << ", " << "0" << ")";
			}
			// Returning: spawnMobile("planet", "commoner", 1, x, z, y, heading, cellid)
		} else if (textType == 5) {
			int angle = creature->getDirectionAngle();

			text << "spawnMobile(\"" << planetName << "\", " <<  "\"commoner" << "\", 1, ";

			// Spawn NPC visualization part
			if (creature->getParent() != nullptr && creature->getParent().get()->isCellObject()) {
				// Inside
				ManagedReference<CellObject*> cell = cast<CellObject*>( creature->getParent().get().get());
				Vector3 cellPosition = creature->getPosition();

				text << cellPosition.getX() << ", " << cellPosition.getZ() << ", " << cellPosition.getY() << ", " << angle << ", " << cell->getObjectID() << ")";

				// Spawn Visual Helper
				spawnVisualNPCHelper(creature, cellPosition.getX(), cellPosition.getY(), cellPosition.getZ(), cell->getObjectID());
			}else {
				// Outside
				Vector3 worldPosition = creature->getWorldPosition();

				text << worldPosition.getX() << ", " << worldPosition.getZ() << ", " << worldPosition.getY() << ", " << angle << ", " << "0" << ")";

				// Spawn Visual Helper
				spawnVisualNPCHelper(creature, worldPosition.getX(), worldPosition.getY(), worldPosition.getZ(), 0);
			}
		} else if (textType == 6) {
			text << "spawnSceneObject(\"" << planetName << "\", \"" << templateFile << "\", ";

			if (creature->getParent() != nullptr && creature->getParent().get()->isCellObject()) {
				// Inside
				ManagedReference<CellObject*> cell = cast<CellObject*>( creature->getParent().get().get());
				Vector3 cellPosition = creature->getPosition();

				text << cellPosition.getX() << ", " << cellPosition.getZ() << ", " << cellPosition.getY() << ", " << cell->getObjectID() << ", ";
			}else {
				// Outside
				Vector3 worldPosition = creature->getWorldPosition();
				text << worldPosition.getX() << ", " << worldPosition.getZ() << ", " << worldPosition.getY() << ", " << "0" << ", ";
			}

			const Quaternion* dir = creature->getDirection();
			text << dir->getW() << ", " << dir->getX() << ", " << dir->getY() << ", " << dir->getZ() << ")";
			// Returning: spawnSceneObject("planet", "objectTemplateFilePathAndName", x, z, y, cellNumber, dw, dx, dy, dz>
		} else if (textType == 7) {
			text << "spawnSceneObject(\"" << planetName << "\", \"" << templateFile << "\", ";
			
			// Convert Target to a CREO
			ManagedReference<SceneObject*> targetObject = server->getZoneServer()->getObject(target, false);

			// Grab Quat earlier so we can spawn something from it based on inside/outside!
			const Quaternion* dir = nullptr;
			if (targetObject != nullptr) {
				dir = targetObject->getDirection();
			}

			if (targetObject->getParent() != nullptr && targetObject->getParent().get()->isCellObject()) {
				// Inside
				ManagedReference<CellObject*> cell = cast<CellObject*>( targetObject->getParent().get().get());
				Vector3 cellPosition = targetObject->getPosition();
				text << cellPosition.getX() << ", " << cellPosition.getZ() << ", " << cellPosition.getY() << ", " << cell->getObjectID() << ", ";

				// Spawn Visual Helper for SceneObjects
				spawnVisualObjectHelper(creature, cellPosition.getX(), cellPosition.getY(), cellPosition.getZ(), cell->getObjectID(), dir->getW(), dir->getX(), dir->getY(), dir->getZ());
			}else {
				// Outside
				Vector3 worldPosition = targetObject->getWorldPosition();
				text << worldPosition.getX() << ", " << worldPosition.getZ() << ", " << worldPosition.getY() << ", " << "0" << ", ";

				// Spawn Visual Helper for SceneObjects
				spawnVisualObjectHelper(creature, worldPosition.getX(), worldPosition.getY(), worldPosition.getZ(), 0, dir->getW(), dir->getX(), dir->getY(), dir->getZ());
			}

			// const Quaternion* dir = creature->getDirection();
			text << dir->getW() << ", " << dir->getX() << ", " << dir->getY() << ", " << dir->getZ() << ")";
			// Returning: spawnSceneObject("planet", "objectTemplateFilePathAndName", x, z, y, cellNumber, dw, dx, dy, dz>
		} else if (textType == 8) { 
			// Delete Targeted Object

			// This is how to get an object by its ID when targeted...
			ManagedReference<SceneObject*> objectToDelete = server->getZoneServer()->getObject(target, false);
			
			if (objectToDelete != nullptr) {
				// Test Destroy
				objectToDelete->destroyChildObjects();
				objectToDelete->destroyObjectFromWorld(true);
				objectToDelete->destroyObjectFromDatabase(true);
			} else {
				creature->sendSystemMessage("TargetObject was NULL!");
			}
		}

		return text.toString();
	}

	// Format screenplay text for all items in a room or the whole building
	String formatSpoutTextMulti(CreatureObject* creature, int roomOnly) const {
		if (creature->getParent() == nullptr){
			creature->sendSystemMessage("You need to be inside a building to output info about the decorations in it.");
			throw Exception();
		}

		ManagedReference<SceneObject*> parent = creature->getParent();

		if (parent == nullptr)
			throw Exception();

		String planetName = creature->getZone()->getZoneName();
		String templateFile = "";

		ManagedReference<SceneObject*> building;
		building = parent->getParent();
		BuildingObject* buildingObject = building.castTo<BuildingObject*>();

		StringBuffer text;

		text << "-- " << building->getObjectNameStringIdName() << " world position: " << building->getPositionX() << " " << building->getPositionY() << endl;

		uint32 numOfCells = buildingObject->getTotalCellNumber();

		if (roomOnly == 1)
			numOfCells = 1;

		CellObject* cell = nullptr;

		for (uint32 i = 1; i <= numOfCells; ++i) {
			if (roomOnly == 1){
				cell = parent.castTo<CellObject*>();
			} else {
				cell = buildingObject->getCell(i);
			}

			uint32 items = cell->getContainerObjectsSize();

			if (items > 0)
				text << "-- Room " << cell->getCellNumber() << ": " << endl;

			for (int j = 0; j < items; ++j) {
				ReadLocker rlocker(cell->getContainerLock());

				ManagedReference<SceneObject*> childObject = cell->getContainerObject(j);

				rlocker.release();

				templateFile = childObject->getObjectTemplate()->getFullTemplateString();

				if (!childObject->isCreatureObject() && !childObject->isVendor() && !templateFile.contains("terminal_player_structure")) {
					if (creature->getParent().get()->getParent().get() == childObject->getParent().get()->getParent().get()) {
						Vector3 cellPosition = childObject->getPosition();
						const Quaternion* dir = childObject->getDirection();

						text << "spawnSceneObject(\"" << planetName << "\", \"" << templateFile << "\", ";
						text << cellPosition.getX() << ", " << cellPosition.getZ() << ", " << cellPosition.getY() << ", " << cell->getObjectID() << ", ";
						text << dir->getW() << ", " << dir->getX() << ", " << dir->getY() << ", " << dir->getZ() << ")" << endl;
					}
				}
			}
		}
		return text.toString();
	}


	// Ouput screenplay formated code to a file on the server
	// Boogles-Note: I overloaded the spout command with the given command so we can pivot special cases.
	void spout(CreatureObject* creature, StringTokenizer* args, String outputText, String command = "unknown") const {
		// Custom Pivot, could have done this differently but it works out just fine.
		if (command != "deletetargobj") {
			if(creature->getZoneServer() == nullptr)
				return;

			String fileName = "";
			if(args->hasMoreTokens()) {
				args->getStringToken(fileName);
			}


			if(fileName.isEmpty()) {
				throw Exception();
			}

		
			File* file = new File("custom_scripts/spout/" + fileName + ".lua");
			FileWriter* writer = new FileWriter(file, true); // true for appending new lines

			writer->writeLine(outputText);

			writer->close();
			delete file;
			delete writer;

			creature->sendSystemMessage("Data written to bin/custom_scripts/spout/" + fileName + ".lua!");
		}
	}

	void decor(CreatureObject* creature) const {
		Lua* lua = DirectorManager::instance()->getLuaInstance();

		Reference<LuaFunction*> adminDecor = lua->createFunction("AdminDecor", "openWindow", 0);
		*adminDecor << creature;

		adminDecor->callFunction();
	}

	void wardevPlaceStructure(CreatureObject* creature) const {
		if (creature->getParent() != nullptr){
			creature->sendSystemMessage("You must be outside to place a structure.");
			throw Exception();
		}

		Lua* lua = DirectorManager::instance()->getLuaInstance();

		Reference<LuaFunction*> adminPlaceStructure = lua->createFunction("AdminPlaceStructure", "openWindow", 0);
		*adminPlaceStructure << creature;

		adminPlaceStructure->callFunction();
	}

	// Method for spawning a 'Commoner' NPC as a "Visual Helper" for building, or enhancing, POIs
	void spawnVisualNPCHelper(CreatureObject* creature, float x, float y, float z, uint64 parID) const {
		// ========================================================
		// Spawn helper NPC to help visualize placement

		// Create Creature
		Zone* zone = creature->getZone();
		CreatureManager* creatureManager = zone->getCreatureManager();
		AiAgent* npc = nullptr;
		String templateName = "commoner";
		uint32 objTempl = 0;
		uint32 templ = templateName.hashCode();

		// Setup npc definition
		npc = cast<AiAgent*>(creatureManager->spawnCreature(templ, objTempl, x, z, y, parID));

		Locker clocker(npc, creature);

		float scale = -1.0;
		npc->updateDirection(Math::deg2rad(creature->getDirectionAngle()));
		
		if (scale > 0 && scale != 1.0){
			npc->setHeight(scale);
		}

		// Done spawning visual example
		// ========================================================
	}

	// dir->getW(), dir->getX(), dir->getY(), dir->getZ()
	// Method for spawning a 'Commoner' NPC as a "Visual Helper" for building, or enhancing, POIs
	void spawnVisualObjectHelper(CreatureObject* creature, float x, float y, float z, uint64 parID, float dw, float dx, float dy, float dz) const {
		// ========================================================
		// Spawn helper Object to help visualize placement

		// Create Creature
		Zone* zone = creature->getZone();
		if (zone == nullptr) {
			creature->sendSystemMessage("Could not get current zone! Where are you??");
			return;
		}

		// Convert path to template to templateCRC hash
		uint32 templ = String::hashCode("object/tangible/terminal/terminal_hq_imperial.iff");

		// Setup ZoneServer so we can transfer the newly created object to the world.
		ZoneServer* zoneServer = ServerCore::getZoneServer();

		// Init the new object.
		ManagedReference<SceneObject*> object = zoneServer->createObject(templ, 0);
		if (object != nullptr) {
			// Lock our new Object
			Locker objLocker(object);

			// Init Pos
			object->initializePosition(x, z, y);
			object->setDirection(dw, dx, dy, dz);

			// Init CellParent
			Reference<SceneObject*> cellParent = nullptr;

			// Making sure our parent exists!
			if (parID != 0) {
				cellParent = zoneServer->getObject(parID);

				// If our parent is NOT a CellObject then make sure it is actually null!
				if (cellParent != nullptr && !cellParent->isCellObject()) {
					cellParent = nullptr;
				}
			}

			// If our Parent IS a CellParent (inside a building, for example) then transfer correctly and replicate to clients.
			if (cellParent != nullptr) {
				cellParent->broadcastObject(object, true);
				cellParent->transferObject(object, -1, true);
			} else {
				// Probably open world? Transfer accordingly!
				zone->transferObject(object, -1, true);
			}

			// Does our new object have children? If so, populate those too!
			object->createChildObjects();

			// Mark as updated so the Garbage Collector doesn't delete our new object from the world.
			object->_setUpdated(true);
		}
		else {
			String err = "Could not spawn object helper template!";
		}

		// Done spawning visual example
		// ========================================================
	}

};
#endif //WARDEVCOMMAND