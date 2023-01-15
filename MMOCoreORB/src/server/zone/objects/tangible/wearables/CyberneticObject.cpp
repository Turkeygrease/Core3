/*
 * CyberneticObjectImplementation.cpp
 *
 *  Created on: 01/15/2023
 *      Author: Zac Jones
 */

#include "server/zone/objects/tangible/wearables/CyberneticObject.h"

void CyberneticObjectImplementation::initializeTransientMembers() {
	ArmorObjectImplementation::initializeTransientMembers();

	setLoggingName("CyberneticObject");
}

void CyberneticObjectImplementation::loadTemplateData(SharedObjectTemplate* templateData) {
	ArmorObjectImplementation::loadTemplateData(templateData);
}

void CyberneticObjectImplementation::notifyLoadFromDatabase() {
	ArmorObjectImplementation::notifyLoadFromDatabase();
}

void CyberneticObjectImplementation::fillAttributeList(AttributeListMessage* alm, CreatureObject* object) {
	ArmorObjectImplementation::fillAttributeList(alm, object);
}

void CyberneticObjectImplementation::updateCraftingValues(CraftingValues* values, bool firstUpdate) {
	ArmorObjectImplementation::updateCraftingValues(values, firstUpdate);
}
