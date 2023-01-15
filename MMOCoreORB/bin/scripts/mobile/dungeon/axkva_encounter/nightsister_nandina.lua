nightsister_nandina = Creature:new {
	objectName = "@mob/creature_names:nightsister_elder",
	customName = "Nandina",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 378,
	chanceHit = 27.25,
	damageMin = 1020,
	damageMax = 1850,
	baseXp = 26654,
	baseHAM = 581000,
	baseHAMmax = 592000,
	armor = 3,
	resists = {57,84,77,44,23,71,44,50,20},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + HEALER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	aggroRadius = 15,
	templates = {"object/mobile/dressed_dathomir_nightsister_protector.iff"},
	scale = 1.2,
	lootGroups = {
		{
			groups = {
				{group = "nightsister_common", chance = 10000000},
			},
			lootChance = 9000000,
		},
		{
	        	groups =
			{
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 3500000,
		},
		{
	        	groups = 
			{
				{group = "armor_attachments", chance = 4000000},
				{group = "clothing_attachments", chance = 6000000},
			},
			lootChance = 3000000,
		}
	},
	weapons = {"kirana_ti_weapons"},
	conversationTemplate = "",
	attacks = merge(swordsmanmaster,pikemanmaster)
}

CreatureTemplates:addCreatureTemplate(nightsister_nandina, "nightsister_nandina")
