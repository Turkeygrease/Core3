nightsister_gorvo_rancor = Creature:new {
	objectName = "@mob/creature_names:enhanced_rancor",
	customName = "Gorvo",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 300,
	chanceHit = 55.5,
	damageMin = 900,
	damageMax = 1600,
	baseXp = 79336,
	baseHAM = 550000,
	baseHAMmax = 600000,
	armor = 3,
	resists = {55,60,45,70,70,70,45,45,25},
	meatType = "meat_carnivore",
	meatAmount = 0,
	hideType = "hide_leathery",
	hideAmount = 0,
	boneType = "bone_mammal",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 15,
	aggroRadius = 15,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/beast_master/bm_mutated_rancor.iff"},
	scale = 1,
	lootGroups = {
		{
	        	groups =
			{
				{group = "elite_mastery_jewelry", chance = 10000000},
			},
			lootChance = 8500000,
		},
		{
	        	groups =
			{
				{group = "ns_rancor_tissue", chance = 10000000},
			},
			lootChance = 9900000,
		},
		{
	        	groups =
			{
				{group = "bw_tooth", chance = 10000000},
			},
			lootChance = 4900000,
		},
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"creatureareattack",""},
		{"stunattack","stunChance=70"},
		{"creatureareableeding",""}
	}
}

CreatureTemplates:addCreatureTemplate(nightsister_gorvo_rancor, "nightsister_gorvo_rancor")
