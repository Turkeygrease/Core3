nightsister_lelli_hi = Creature:new {
	objectName = "@mob/creature_names:nightsister_elder",
	customName = "Lelli Hi The Conniver",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 400,
	chanceHit = 27.25,
	damageMin = 820,
	damageMax = 1550,
	baseXp = 26654,
	baseHAM = 501000,
	baseHAMmax = 502000,
	armor = 3,
	resists = {41,50,67,34,45,50,32,20,20},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	aggroRadius = 15,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + HEALER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_dathomir_nightsister_guardian.iff"},
	scale = 1.2,
	lootGroups = {
		{
			groups = {
				{group = "ns_lelli_group", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        	groups =
			{
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 4500000,
		},
		{
	        	groups = 
			{
				{group = "armor_attachments", chance = 4000000},
				{group = "clothing_attachments", chance = 6000000},
			},
			lootChance = 5000000,
		}
	},
	weapons = {"ubar_weapons"},
	conversationTemplate = "",
	attacks = merge(swordsmanmaster,forcewielder)
}

CreatureTemplates:addCreatureTemplate(nightsister_lelli_hi, "nightsister_lelli_hi")
