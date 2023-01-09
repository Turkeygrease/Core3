undead_trooper_m = Creature:new {
	objectName = "",
	customName = "an undead Imperial Stormtrooper",
	socialGroup = "nightsister",
	pvpFaction = "nightsister",
	faction = "nightsister",
	level = 200,
	chanceHit = 0.8,
	damageMin = 396,
	damageMax = 416,
	baseXp = 3465,
	baseHAM = 131700,
	baseHAMmax = 133000,
	armor = 2,
	resists = {52,25,25,65,65,65,65,44,33},
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
	creatureBitmask = KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/outbreak_undead_deathtrooper_01_m.iff"},
	scale = 1.2,	
	lootGroups = {
		{
	        	groups =
			{
				{group = "undead_armor", chance = 10000000},
			},
			lootChance = 2000000,
		},
		{
			groups = {
				{group = "color_crystals", chance = 150000},
				{group = "junk", chance = 7300000},
				{group = "rifles", chance = 600000},
				{group = "holocron_dark", chance = 150000},
				{group = "holocron_light", chance = 150000},
				{group = "carbines", chance = 600000},
				{group = "pistols", chance = 600000},
				{group = "clothing_attachments", chance = 200000},
				{group = "armor_attachments", chance = 250000}
			},
			lootChance = 3900000,
		},
	},
	weapons = {"unarmed_weapons"},
	conversationTemplate = "",
	attacks = merge(brawlermaster,tkamaster)
}

CreatureTemplates:addCreatureTemplate(undead_trooper_m, "undead_trooper_m")
