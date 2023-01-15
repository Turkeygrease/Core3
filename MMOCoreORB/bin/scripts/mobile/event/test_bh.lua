test_bh = Creature:new {
	objectName = "@mob/creature_names:bounty_hunter",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "swoop",
	faction = "swoop",
	mobType = MOB_NPC,
	level = 500,
	chanceHit = 300,
	damageMin = 395,
	damageMax = 1300,
	baseXp = 56845,
	bonusType = "pve_xp",
	bonusXP = 800,
	baseHAM = 426000,
	baseHAMmax = 452000,
	armor = 2,
	resists = {20,30,40,50,40,25,35,70,15},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = NONE,

	templates = {"object/mobile/dressed_bounty_hunter_zabrak_female_01.iff"},
	scale = 1.2,
	lootGroups = {
		{
	        groups = {
				{group = "mando_loot", chance = 10000000},
			},
			lootChance = 10000000,
		},

		{
	        groups = {
				{group = "lootcollectiontierheroics", chance = 3000000},
				{group = "lootcollectiontierdiamonds", chance = 7000000},
			},
			lootChance = 3000000,
		},
		{
			groups = {
				{group = "death_watch_bunker_ingredient_protective",  chance = 10000000},
			},
			lootChance = 10000000,
		},

		{
	        groups = {
				{group = "vendor_pvp_ranged_comps", chance = 3300000},
				{group = "vendor_pvp_melee_comps", chance = 3400000},
				{group = "vendor_pvp_cm_comps", chance = 3300000},
			},
			lootChance = 7000000,
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "pirate_weapons_heavy",
	secondaryWeapon = "none",
	conversationTemplate = "",

	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(bountyhuntermaster,marksmanmaster,brawlermaster,pikemanmaster,fencermaster,swordsmanmaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(test_bh, "test_bh")
