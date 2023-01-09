world_dath_uncommon_a = Creature:new {
	objectName = "@mob/creature_names:ancient_bull_rancor",
	customName = "Ancient Bull Rancor-Silver",
	socialGroup = "rancor",
	faction = "",
	level = 500,
	chanceHit = 75,
	damageMin = 820,
	damageMax = 1350,
	baseXp = 10921,
	bonusType = "pve_xp",
	bonusXP = 1200,
	baseHAM = 524000,
	baseHAMmax = 530000,
	armor = 2,
	resists = {20,20,30,50,30,20,10,40,-1},
	meatType = "meat_carnivore",
	meatAmount = 1000,
	hideType = "hide_leathery",
	hideAmount = 1000,
	boneType = "bone_mammal",
	boneAmount = 950,
	milk = 0,
	tamingChance = 0,
	ferocity = 20,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/bull_rancor.iff"},
	scale = 2.25,
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
		{"creatureareableeding",""},
		{"creatureareacombo",""}
	}
}

CreatureTemplates:addCreatureTemplate(world_dath_uncommon_a, "world_dath_uncommon_a")
