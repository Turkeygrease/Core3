crazed_geonosian_boss = Creature:new {
	objectName = "@mob/creature_names:geonosian_crazed_guard",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "self",
	faction = "",
	mobType = MOB_HERBIVORE,
	level = 400,
	chanceHit = 45.5,
	damageMin = 396,
	damageMax = 1216,
	baseXp = 3465,
	bonusType = "pve_xp",
	bonusXP = 500,
	baseHAM = 1217000,
	baseHAMmax = 1330000,
	armor = 2,
	resists = {55,60,45,70,70,70,45,45,35},
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

	templates = {
		"object/mobile/dressed_geonosian_warrior_01.iff",
		"object/mobile/dressed_geonosian_warrior_02.iff",
		"object/mobile/dressed_geonosian_warrior_03.iff"
	},
	
	scale = 1.5,

	lootGroups = {
		{
	        groups = {
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        groups = {
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 10000000,
		},
		{
			groups = {
				{group = "crovaxloot_group", chance =  10000000}
			},
			lootChance = 6000000
		},
		{
	        groups = {
				{group = "power_crystals", chance = 10000000},
			},
			lootChance = 8500000,
		},
		{
	        groups = {
				{group = "geo_weapon_schems", chance = 10000000},
			},
			lootChance = 8500000,
		},
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "geonosian_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(brawlermaster,marksmanmaster,pistoleermaster,riflemanmaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(crazed_geonosian_boss, "crazed_geonosian_boss")
