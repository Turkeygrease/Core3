holiday_boar = Creature:new {
	customName = "Frost Boar",	
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	mobType = MOB_HERBIVORE,
	level = 260,
	chanceHit = 0.28,
	damageMin = 220,
	damageMax = 830,
	baseXp = 21356,
	baseHAM = 41675,
	baseHAMmax = 42825,
	armor = 0,
	resists = {0,0,0,0,0,0,0,0,0},
	meatType = "meat_herbivore",
	meatAmount = 82865,
	hideType = "hide_leathery",
	hideAmount = 82840,
	boneType = "bone_mammal",
	boneAmount = 82825,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = NONE,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/hoth_boar.iff"},
	scale = 1.5,	
	controlDeviceTemplate = "",
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"stunattack","stunChance=100"} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(holiday_boar, "holiday_boar")
