world_lok_common_a = Creature:new {
	objectName = "@mob/creature_names:recluse_gurk_king",
	customName = "Gurk King-Bronze",
	socialGroup = "gurk",
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
	meatType = "meat_herbivore",
	meatAmount = 300,
	hideType = "hide_leathery",
	hideAmount = 275,
	boneType = "bone_mammal",
	boneAmount = 300,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/recluse_gurk_king.iff"},
	scale = 2.4,
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
		{"posturedownattack",""},
		{"blindattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(world_lok_common_a, "world_lok_common_a")
