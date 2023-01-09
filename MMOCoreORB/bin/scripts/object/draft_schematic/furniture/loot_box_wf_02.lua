object_draft_schematic_furniture_loot_box_wf_02 = object_draft_schematic_furniture_shared_loot_box_wf_02:new {
	templateType = DRAFTSCHEMATIC,

	customObjectName = "Furniture Loot Box",

	craftingToolTab = 512, -- (See DraftSchematicObjectTemplate.h)
	complexity = 24,
	size = 1,
	factoryCrateSize = 0,

	xpType = "crafting_structure_general",
	xp = 2700,

	assemblySkill = "structure_assembly",
	experimentingSkill = "structure_experimentation",
	customizationSkill = "structure_customization",

	customizationOptions = {},
	customizationStringNames = {},
	customizationDefaults = {},

	ingredientTemplateNames = {"craft_furniture_ingredients_n", "craft_furniture_ingredients_n", "craft_furniture_ingredients_n"},
	ingredientTitleNames = {"frame", "pandora_core", "electronics"},
	ingredientSlotType = {0, 0, 2},
	resourceTypes = {"metal", "ore", "object/tangible/component/item/shared_electronics_gp_module.iff"},
	resourceQuantities = {2000, 1000, 2},
	contribution = {100, 100, 100},

	targetTemplate = "object/tangible/furniture/loot_box_wf_02.iff",

}
ObjectTemplates:addTemplate(object_draft_schematic_furniture_loot_box_wf_02, "object/draft_schematic/furniture/loot_box_wf_02.iff")
