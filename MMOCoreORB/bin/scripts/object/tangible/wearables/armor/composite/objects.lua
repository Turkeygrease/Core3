--Copyright (C) 2009 <SWGEmu>

--This File is part of Core3.

--This program is free software; you can redistribute
--it and/or modify it under the terms of the GNU Lesser
--General Public License as published by the Free Software
--Foundation; either version 2 of the License,
--or (at your option) any later version.

--This program is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
--See the GNU Lesser General Public License for
--more details.

--You should have received a copy of the GNU Lesser General
--Public License along with this program; if not, write to
--the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

--Linking Engine3 statically or dynamically with other modules
--is making a combined work based on Engine3.
--Thus, the terms and conditions of the GNU Lesser General Public License
--cover the whole combination.

--In addition, as a special exception, the copyright holders of Engine3
--give you permission to combine Engine3 program with free software
--programs or libraries that are released under the GNU LGPL and with
--code included in the standard release of Core3 under the GNU LGPL
--license (or modified versions of such code, with unchanged license).
--You may copy and distribute such a system following the terms of the
--GNU LGPL for Engine3 and the licenses of the other code concerned,
--provided that you include the source code of that other code when
--and as the GNU LGPL requires distribution of source code.

--Note that people who make modified versions of Engine3 are not obligated
--to grant this special exception for their modified versions;
--it is their choice whether to do so. The GNU Lesser General Public License
--gives permission to release a modified version without this exception;
--this exception also makes it possible to release a modified version
--which carries forward this exception.


object_tangible_wearables_armor_composite_shared_armor_composite_bicep_l = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_bicep_l.iff"
	--Data below here is deprecated and loaded from the tres, keeping for easy lookups
--[[
	appearanceFilename = "appearance/armor_composite_s01_bicep_l_f.sat",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/bicep_l.iff",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	clientGameObjectType = 261,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@wearables_detail:armor_composite_bicep_l",

	gameObjectType = 261,

	locationReservationRadius = 0,
	lookAtText = "@wearables_lookat:armor_composite_bicep_l",

	noBuildRadius = 0,

	objectName = "@wearables_name:armor_composite_bicep_l",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/tangible.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	clientObjectCRC = 329570833,
	derivedFromTemplates = {"object/object/base/shared_base_object.iff", "object/tangible/base/shared_tangible_base.iff", "object/tangible/base/shared_tangible_craftable.iff", "object/tangible/wearables/base/shared_wearables_base.iff", "object/tangible/wearables/base/shared_armor_base.iff", "object/tangible/wearables/base/shared_base_bicep_l.iff"}
]]
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_bicep_l, "object/tangible/wearables/armor/composite/shared_armor_composite_bicep_l.iff")

object_tangible_wearables_armor_composite_shared_armor_composite_bicep_r = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_bicep_r.iff"
	--Data below here is deprecated and loaded from the tres, keeping for easy lookups
--[[
	appearanceFilename = "appearance/armor_composite_s01_bicep_r_f.sat",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/bicep_r.iff",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	clientGameObjectType = 261,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@wearables_detail:armor_composite_bicep_r",

	gameObjectType = 261,

	locationReservationRadius = 0,
	lookAtText = "@wearables_lookat:armor_composite_bicep_r",

	noBuildRadius = 0,

	objectName = "@wearables_name:armor_composite_bicep_r",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/tangible.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	clientObjectCRC = 1668390786,
	derivedFromTemplates = {"object/object/base/shared_base_object.iff", "object/tangible/base/shared_tangible_base.iff", "object/tangible/base/shared_tangible_craftable.iff", "object/tangible/wearables/base/shared_wearables_base.iff", "object/tangible/wearables/base/shared_armor_base.iff", "object/tangible/wearables/base/shared_base_bicep_r.iff"}
]]
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_bicep_r, "object/tangible/wearables/armor/composite/shared_armor_composite_bicep_r.iff")

object_tangible_wearables_armor_composite_shared_armor_composite_boots = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_boots.iff"
	--Data below here is deprecated and loaded from the tres, keeping for easy lookups
--[[
	appearanceFilename = "appearance/armor_composite_s01_boots_f.sat",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/shoe.iff",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	clientGameObjectType = 263,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@wearables_detail:armor_composite_boots",

	gameObjectType = 263,

	locationReservationRadius = 0,
	lookAtText = "@wearables_lookat:armor_composite_boots",

	noBuildRadius = 0,

	objectName = "@wearables_name:armor_composite_boots",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/tangible.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	clientObjectCRC = 3683772891,
	derivedFromTemplates = {"object/object/base/shared_base_object.iff", "object/tangible/base/shared_tangible_base.iff", "object/tangible/base/shared_tangible_craftable.iff", "object/tangible/wearables/base/shared_wearables_base.iff", "object/tangible/wearables/base/shared_base_shoes.iff"}
]]
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_boots, "object/tangible/wearables/armor/composite/shared_armor_composite_boots.iff")

object_tangible_wearables_armor_composite_shared_armor_composite_bracer_l = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_bracer_l.iff"
	--Data below here is deprecated and loaded from the tres, keeping for easy lookups
--[[
	appearanceFilename = "appearance/armor_composite_s01_bracer_l_f.sat",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/bracer_l.iff",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	clientGameObjectType = 261,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@wearables_detail:armor_composite_bracer_l",

	gameObjectType = 261,

	locationReservationRadius = 0,
	lookAtText = "@wearables_lookat:armor_composite_bracer_l",

	noBuildRadius = 0,

	objectName = "@wearables_name:armor_composite_bracer_l",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/tangible.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	clientObjectCRC = 1303386413,
	derivedFromTemplates = {"object/object/base/shared_base_object.iff", "object/tangible/base/shared_tangible_base.iff", "object/tangible/base/shared_tangible_craftable.iff", "object/tangible/wearables/base/shared_wearables_base.iff", "object/tangible/wearables/base/shared_armor_base.iff", "object/tangible/wearables/base/shared_base_bracer_l.iff"}
]]
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_bracer_l, "object/tangible/wearables/armor/composite/shared_armor_composite_bracer_l.iff")

object_tangible_wearables_armor_composite_shared_armor_composite_bracer_r = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_bracer_r.iff"
	--Data below here is deprecated and loaded from the tres, keeping for easy lookups
--[[
	appearanceFilename = "appearance/armor_composite_s01_bracer_r_f.sat",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/bracer_r.iff",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	clientGameObjectType = 261,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@wearables_detail:armor_composite_bracer_r",

	gameObjectType = 261,

	locationReservationRadius = 0,
	lookAtText = "@wearables_lookat:armor_composite_bracer_r",

	noBuildRadius = 0,

	objectName = "@wearables_name:armor_composite_bracer_r",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/tangible.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	clientObjectCRC = 1030053054,
	derivedFromTemplates = {"object/object/base/shared_base_object.iff", "object/tangible/base/shared_tangible_base.iff", "object/tangible/base/shared_tangible_craftable.iff", "object/tangible/wearables/base/shared_wearables_base.iff", "object/tangible/wearables/base/shared_armor_base.iff", "object/tangible/wearables/base/shared_base_bracer_r.iff"}
]]
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_bracer_r, "object/tangible/wearables/armor/composite/shared_armor_composite_bracer_r.iff")

object_tangible_wearables_armor_composite_shared_armor_composite_chest_plate = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_chest_plate.iff"
	--Data below here is deprecated and loaded from the tres, keeping for easy lookups
--[[
	appearanceFilename = "appearance/armor_composite_s01_chest_plate_f.sat",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/vest.iff",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	clientGameObjectType = 257,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@wearables_detail:armor_composite_chest_plate",

	gameObjectType = 257,

	locationReservationRadius = 0,
	lookAtText = "@wearables_lookat:armor_composite_chest_plate",

	noBuildRadius = 0,

	objectName = "@wearables_name:armor_composite_chest_plate",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/tangible.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	clientObjectCRC = 2068279078,
	derivedFromTemplates = {"object/object/base/shared_base_object.iff", "object/tangible/base/shared_tangible_base.iff", "object/tangible/base/shared_tangible_craftable.iff", "object/tangible/wearables/base/shared_wearables_base.iff", "object/tangible/wearables/base/shared_base_vest.iff"}
]]
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_chest_plate, "object/tangible/wearables/armor/composite/shared_armor_composite_chest_plate.iff")

object_tangible_wearables_armor_composite_shared_armor_composite_gloves = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_gloves.iff"
	--Data below here is deprecated and loaded from the tres, keeping for easy lookups
--[[
	appearanceFilename = "appearance/armor_composite_s01_gloves_f.sat",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/gauntlets.iff",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	clientGameObjectType = 262,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@wearables_detail:armor_composite_gloves",

	gameObjectType = 262,

	locationReservationRadius = 0,
	lookAtText = "@wearables_lookat:armor_composite_gloves",

	noBuildRadius = 0,

	objectName = "@wearables_name:armor_composite_gloves",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/tangible.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	clientObjectCRC = 741736354,
	derivedFromTemplates = {"object/object/base/shared_base_object.iff", "object/tangible/base/shared_tangible_base.iff", "object/tangible/base/shared_tangible_craftable.iff", "object/tangible/wearables/base/shared_wearables_base.iff", "object/tangible/wearables/base/shared_armor_base.iff", "object/tangible/wearables/base/shared_base_gauntlets.iff"}
]]
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_gloves, "object/tangible/wearables/armor/composite/shared_armor_composite_gloves.iff")

object_tangible_wearables_armor_composite_shared_armor_composite_helmet = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_helmet.iff"
	--Data below here is deprecated and loaded from the tres, keeping for easy lookups
--[[
	appearanceFilename = "appearance/armor_composite_s01_helmet_f.sat",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/helmet_closed_full.iff",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	clientGameObjectType = 258,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@wearables_detail:armor_composite_helmet",

	gameObjectType = 258,

	locationReservationRadius = 0,
	lookAtText = "@wearables_lookat:armor_composite_helmet",

	noBuildRadius = 0,

	objectName = "@wearables_name:armor_composite_helmet",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/tangible.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	clientObjectCRC = 2599755434,
	derivedFromTemplates = {"object/object/base/shared_base_object.iff", "object/tangible/base/shared_tangible_base.iff", "object/tangible/base/shared_tangible_craftable.iff", "object/tangible/wearables/base/shared_wearables_base.iff", "object/tangible/wearables/base/shared_armor_base.iff", "object/tangible/wearables/base/shared_base_helmet_closed_full.iff"}
]]
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_helmet, "object/tangible/wearables/armor/composite/shared_armor_composite_helmet.iff")

object_tangible_wearables_armor_composite_shared_armor_composite_leggings = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_leggings.iff"
	--Data below here is deprecated and loaded from the tres, keeping for easy lookups
--[[
	appearanceFilename = "appearance/armor_composite_s01_leggings_f.sat",
	arrangementDescriptorFilename = "abstract/slot/arrangement/wearables/skirt.iff",

	certificationsRequired = {},
	clearFloraRadius = 0,
	clientDataFile = "",
	clientGameObjectType = 260,
	collisionActionBlockFlags = 0,
	collisionActionFlags = 51,
	collisionActionPassFlags = 1,
	collisionMaterialBlockFlags = 0,
	collisionMaterialFlags = 1,
	collisionMaterialPassFlags = 0,
	containerType = 0,
	containerVolumeLimit = 1,
	customizationVariableMapping = {},

	detailedDescription = "@wearables_detail:armor_composite_pants",

	gameObjectType = 260,

	locationReservationRadius = 0,
	lookAtText = "@wearables_lookat:armor_composite_pants",

	noBuildRadius = 0,

	objectName = "@wearables_name:armor_composite_pants",
	onlyVisibleInTools = 0,

	paletteColorCustomizationVariables = {},
	portalLayoutFilename = "",

	rangedIntCustomizationVariables = {},

	scale = 1,
	scaleThresholdBeforeExtentTest = 0.5,
	sendToClient = 1,
	slotDescriptorFilename = "abstract/slot/descriptor/tangible.iff",
	snapToTerrain = 1,
	socketDestinations = {},
	structureFootprintFileName = "",
	surfaceType = 0,

	targetable = 1,
	totalCellNumber = 0,

	useStructureFootprintOutline = 0,

	clientObjectCRC = 3264529458,
	derivedFromTemplates = {"object/object/base/shared_base_object.iff", "object/tangible/base/shared_tangible_base.iff", "object/tangible/base/shared_tangible_craftable.iff", "object/tangible/wearables/base/shared_wearables_base.iff", "object/tangible/wearables/base/shared_base_skirt.iff"}
]]
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_leggings, "object/tangible/wearables/armor/composite/shared_armor_composite_leggings.iff")

object_tangible_wearables_armor_composite_shared_armor_composite_helmet_invis = SharedTangibleObjectTemplate:new {
	clientTemplateFileName = "object/tangible/wearables/armor/composite/shared_armor_composite_helmet_invis.iff"
}

ObjectTemplates:addClientTemplate(object_tangible_wearables_armor_composite_shared_armor_composite_helmet_invis, "object/tangible/wearables/armor/composite/shared_armor_composite_helmet_invis.iff")
