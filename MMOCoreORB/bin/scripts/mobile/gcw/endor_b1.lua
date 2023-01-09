endor_b1 = Creature:new {
	objectName = "",
	customName = "Death Watch Champion",
	socialGroup = "death_watch",
	faction = "",
	level = 300,
	chanceHit = 12.25,
	damageMin = 10,
	damageMax = 50,
	baseXp = 16794,
	bonusType = "pvp_xp",
	bonusXP = 400,
	baseHAM = 475000,
	baseHAMmax = 475000,
	armor = 2,
	resists = {45,55,70,60,45,45,80,50,25},
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
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.5,
	
	templates = {"object/mobile/dressed_death_watch_grey.iff"},
	lootGroups = {
		{
	        	groups = 
			{
				{group = "clothing_attachments", chance = 2500000},
				{group = "armor_attachments", chance = 2500000},
				{group = "mando_loot", chance = 2000000},
				{group = "bounty_hunter_armor", chance = 3000000},
			},
			lootChance = 10000000,
		},
		{
	        	groups = 
			{
				{group = "clothing_attachments", chance = 6000000},
				{group = "armor_attachments", chance = 4000000},
			},
			lootChance = 10000000,
		} 
	},
	weapons = {"death_watch_commander_weapons"},
	conversationTemplate = "",
	attacks = merge(carbineermaster,marksmanmaster,brawlermaster,pistoleermaster)
}

CreatureTemplates:addCreatureTemplate(endor_b1, "endor_b1")
