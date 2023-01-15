endor_b4 = Creature:new {
	objectName = "",
	customName = "Death Watch Leader",
	socialGroup = "death_watch",
	faction = "",
	mobType = MOB_NPC,
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

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "death_watch_commander_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(carbineermaster,marksmanmaster,brawlermaster,pistoleermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(endor_b4, "endor_b4")
