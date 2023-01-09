event_cavern_spider = Creature:new {
	objectName = "@mob/creature_names:enhanced_cavern_spider",
	customName = " A Mutant Spider",
	socialGroup = "nightsister",
	pvpFaction = "nightsister",
	faction = "nightsister",
	level = 290,
	chanceHit = 33.36,
	damageMin = 550,
	damageMax = 860,
	baseXp = 17822,
	baseHAM = 39700,
	baseHAMmax = 49400,
	armor = 0,
	resists = {45,45,35,25,45,30,35,25,15},
	meatType = "meat_insect",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = { "object/mobile/gaping_spider.iff",
			"object/mobile/hermit_spider.iff",
			"object/mobile/nightspider.iff"},
	scale = 1.1,
	lootGroups = {
		{
	        	groups = 
			{
				{group = "armor_attachments", chance = 5000000},
				{group = "clothing_attachments", chance = 5000000},
			},
			lootChance = 500000,
		},

	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"intimidationattack","intimidationChance=50"},
		{"mildpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(event_cavern_spider, "event_cavern_spider")
