world_dant_common_a = Creature:new {
	objectName = "@mob/creature_names:dark_force_crystal_hunter",
	customName = "Crystal Hunter-Bronze",
	socialGroup = "kun",
	faction = "",
	mobType = MOB_NPC,
	level = 500,
	chanceHit = 75,
	damageMin = 820,
	damageMax = 1350,
	baseXp = 10921,
	bonusType = "pve_xp",
	bonusXP = 1000,
	baseHAM = 424000,
	baseHAMmax = 430000,
	armor = 2,
	resists = {20,20,30,50,30,20,10,40,-1},
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_dark_force_crystal_hunter.iff"},
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
	primaryWeapon = "mixed_force_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(pikemanmaster,brawlermaster,fencermaster,swordsmanmaster,forcewielder),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(world_dant_common_a, "world_dant_common_a")
