world_dath_common_a = Creature:new {
	objectName = "@mob/creature_names:ancient_reptilian_flier",
	customName = "Ancient Reptillian Flyer-Bronze",
	socialGroup = "reptilian_flier",
	faction = "",
	level = 500,
	chanceHit = 75,
	damageMin = 820,
	damageMax = 1350,
	baseXp = 10921,
	bonusType = "pve_xp",
	bonusXP = 1000,
	baseHAM = 424000,
	baseHAMmax = 430000,
	armor = 2,
	resists = {20,20,30,50,30,20,10,40,-1},
	meatType = "meat_avian",
	meatAmount = 135,
	hideType = "hide_leathery",
	hideAmount = 90,
	boneType = "bone_avian",
	boneAmount = 85,
	milk = 0,
	tamingChance = 0.25,
	ferocity = 7,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/reptilian_flier_hue.iff"},
	controlDeviceTemplate = "object/intangible/pet/pet_control.iff",
	scale = 2.1,
	lootGroups = {
		{
	        	groups = 
			{
				{group = "mando_loot", chance = 10000000},
			},
			lootChance = 10000000,
		},

		{
	        	groups = 
			{
				{group = "lootcollectiontierheroics", chance = 3000000},
				{group = "lootcollectiontierdiamonds", chance = 7000000},
			},
			lootChance = 3000000,
		},
		{
			groups = {
				{group = "death_watch_bunker_ingredient_protective",  chance = 10000000},
			},
			lootChance = 10000000,
		},

		{
	        	groups = 
			{
				{group = "vendor_pvp_ranged_comps", chance = 3300000},
				{group = "vendor_pvp_melee_comps", chance = 3400000},
				{group = "vendor_pvp_cm_comps", chance = 3300000},
			},
			lootChance = 7000000,
		}
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"",""},
		{"blindattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(world_dath_common_a, "world_dath_common_a")
