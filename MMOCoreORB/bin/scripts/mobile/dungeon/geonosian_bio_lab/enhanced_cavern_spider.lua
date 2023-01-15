enhanced_cavern_spider = Creature:new {
	customName = "an Enhanced Cavern Spider",
	socialGroup = "geonosian_creature",
	pvpFaction = "",
	faction = "",
	mobType = MOB_CARNIVORE,
	level = 270,
	chanceHit = 33.36,
	damageMin = 550,
	damageMax = 860,
	baseXp = 17822,
	baseHAM = 39700,
	baseHAMmax = 49400,
	armor = 0,
	resists = {45,45,35,25,45,30,35,25,15},
	meatType = "meat_insect",
	meatAmount = 250,
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

	templates = {"object/mobile/gaping_spider.iff"},
	scale = 1.1,
	lootGroups = {
		{
	        groups = {
				{group = "armor_attachments", chance = 5000000},
				{group = "clothing_attachments", chance = 5000000},
			},
			lootChance = 500000,
		},

	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"intimidationattack","intimidationChance=50"}, {"mildpoison",""} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(enhanced_cavern_spider, "enhanced_cavern_spider")
