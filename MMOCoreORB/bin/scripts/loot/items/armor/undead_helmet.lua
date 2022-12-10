

undead_helmet =
{
	minimumLevel = 0,
	maximumLevel = -1,
	customObjectName = "Undead Helmet",
	directObjectTemplate = "object/tangible/wearables/armor/deathtrooper/armor_deathtrooper_helmet.iff",
	craftingValues = {
	         {"armor_rating",1,1,0},
	         {"armor_effectiveness",30,45,0},
	         {"acideffectiveness",70,70,0},
	         {"stuneffectiveness",0,20,0},
	         {"armor_integrity",30000,40000,0},
	         {"armor_health_encumbrance",25,15,0},
	         {"armor_action_encumbrance",22,13,0},
	         {"armor_mind_encumbrance",30,18,0},
	},
	customizationStringNames = {},
	customizationValues = {},
	skillMods ={}
}

addLootItemTemplate("undead_helmet", undead_helmet)
