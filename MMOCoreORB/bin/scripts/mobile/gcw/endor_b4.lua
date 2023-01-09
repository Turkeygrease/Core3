endor_b4 = Creature:new {
	objectName = "",
	customName = "Death Watch Leader",
	socialGroup = "death_watch",
	faction = "",
	level = 500,
	chanceHit = 12.25,
	damageMin = 10,
	damageMax = 50,
	baseXp = 16794,
	bonusType = "pvp_xp",
	bonusXP = 500,
	baseHAM = 1065000,
	baseHAMmax = 1075000,
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
	
	templates = {"object/mobile/dressed_death_watch_red.iff"},
	lootGroups = {
		{
	        	groups = 
			{
				{group = "vendor_pvp_ranged_comps", chance = 2500000},
				{group = "vendor_pvp_melee_comps", chance = 2000000},
				{group = "vendor_pvp_cm_comps", chance = 2500000},
				{group = "vendor_gold_a", chance = 3000000},
			},
			lootChance = 10000000,
		} 
	},
	weapons = {"death_watch_commander_weapons"},
	conversationTemplate = "",
	attacks = merge(carbineermaster,marksmanmaster,brawlermaster,pistoleermaster)
}

CreatureTemplates:addCreatureTemplate(endor_b4, "endor_b4")
