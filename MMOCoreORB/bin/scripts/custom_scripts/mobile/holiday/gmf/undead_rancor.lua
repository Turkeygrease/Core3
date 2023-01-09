undead_rancor = Creature:new {
	objectName = "@mob/creature_names:enhanced_rancor",
	customName = "Undead Mutant Rancor",
	socialGroup = "nightsister",
	pvpFaction = "nightsister",
	faction = "nightsister",
	level = 500,
	chanceHit = 55.5,
	damageMin = 900,
	damageMax = 1900,
	baseXp = 79336,
	bonusType = "pve_xp",
	bonusXP = 500,
	baseHAM = 1150000,
	baseHAMmax = 1200000,
	armor = 3,
	resists = {55,60,45,70,70,70,45,45,45},
	meatType = "meat_carnivore",
	meatAmount = 2000,
	hideType = "hide_leathery",
	hideAmount = 2000,
	boneType = "bone_mammal",
	boneAmount = 2000,
	milk = 0,
	tamingChance = 0,
	ferocity = 15,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/outbreak_afflicted_blackwing_rancor_boss.iff"},
	scale = 0.4,
	lootGroups = {

		{
	        	groups =
			{
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        	groups =
			{
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        	groups =
			{
				{group = "halloween_group", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        	groups =
			{
				{group = "halloween_group", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        	groups =
			{
				{group = "bw_tooth", chance = 10000000},
			},
			lootChance = 9900000,
		},
		{
	        	groups =
			{
				{group = "undead_armor_b", chance = 10000000},
			},
			lootChance = 9900000,
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

CreatureTemplates:addCreatureTemplate(undead_rancor, "undead_rancor")
