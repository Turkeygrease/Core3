magma_drenched_rancor = Creature:new {
	objectName = "",
	customName = "Magma Drenched Rancor",
	socialGroup = "geonosian_creature",
	pvpFaction = "",
	faction = "",
	level = 500,
	chanceHit = 55.5,
	damageMin = 900,
	damageMax = 1600,
	baseXp = 79336,
	bonusType = "pve_xp",
	bonusXP = 900,
	baseHAM = 1550000,
	baseHAMmax = 1600000,
	armor = 3,
	resists = {55,60,45,70,70,70,45,45,-1},
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

	templates = {"object/mobile/magma_drenched_rancor.iff"},
	scale = 1.4,
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

CreatureTemplates:addCreatureTemplate(magma_drenched_rancor, "magma_drenched_rancor")
