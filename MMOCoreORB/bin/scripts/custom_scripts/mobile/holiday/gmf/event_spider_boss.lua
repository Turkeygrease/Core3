event_spider_boss = Creature:new {
	objectName = "@mob/creature_names:geonosian_gaping_spider_fire",
	customName = "Mutant Spider Queen",
	socialGroup = "nightsister",
	pvpFaction = "nightsister",
	faction = "nightsister",
	mobType = MOB_CARNIVORE,
	level = 415,
	chanceHit = 75.5,
	damageMin = 800,
	damageMax = 1400,
	baseXp = 10267,
	bonusType = "pve_xp",
	bonusXP = 200,
	baseHAM = 610000,
	baseHAMmax = 629000,
	armor = 2,
	resists = {50,35,25,95,45,35,25,45,15},
	meatType = "meat_insect",
	meatAmount = 1000,
	hideType = "hide_leathery",
	hideAmount = 1000,
	boneType = "bone_mammal",
	boneAmount = 950,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {
		"object/mobile/gaping_spider.iff",
		"object/mobile/hermit_spider.iff",
		"object/mobile/nightspider.iff"
	},
	scale = 2.5,
	lootGroups = {
		{
	        groups = {
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        groups = {
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 2500000,
		},
		{
	        groups = {
				{group = "halloween_group", chance = 10000000},
			},
			lootChance = 10000000,
		},
		{
			groups = {
				{group = "fire_breathing_spider", chance = 10000000},
			},
			lootChance = 8500000,
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "creature_spit_heavy_flame",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"strongpoison",""}, {"stunattack",""} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(event_spider_boss, "event_spider_boss")
