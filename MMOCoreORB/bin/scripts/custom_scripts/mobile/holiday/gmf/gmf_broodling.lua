gmf_broodling = Creature:new {
	customName = "Spider Broodling",
	socialGroup = "nightsister",
	level = 44,
	mobType = MOB_CARNIVORE,
	chanceHit = 0.46,
	damageMin = 390,
	damageMax = 490,
	baseXp = 4370,
	baseHAM = 39500,
	baseHAMmax = 41600,
	armor = 1,
	resists = {130,130,160,125,-1,-1,0,-1,-1},
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
	
	templates = {
		"object/mobile/gaping_spider.iff",
		"object/mobile/hermit_spider.iff",
		"object/mobile/nightspider.iff"
	},

	scale = 0.2,
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "creature_spit_small_toxicgreen",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"creatureareapoison",""}, {"strongpoison",""} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(gmf_broodling, "gmf_broodling")
