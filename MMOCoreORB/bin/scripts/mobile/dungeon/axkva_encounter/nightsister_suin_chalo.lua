nightsister_suin_chalo = Creature:new {
	objectName = "@mob/creature_names:nightsister_elder",
	customName = "Suin Chalo The Ravager",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 378,
	chanceHit = 27.25,
	damageMin = 1020,
	damageMax = 1850,
	baseXp = 26654,
	baseHAM = 681000,
	baseHAMmax = 692000,
	armor = 3,
	resists = {71,60,47,44,45,40,42,50,20},
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

	templates = {"object/mobile/dressed_dathomir_nightsister_protector.iff"},
	scale = 1.2,
	lootGroups = {
		{
			groups = {
				{group = "ns_suin_group", chance = 10000000},
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

CreatureTemplates:addCreatureTemplate(nightsister_suin_chalo, "nightsister_suin_chalo")
