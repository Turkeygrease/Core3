krayt_dragon_tamable = Creature:new {
	customName = "A Cavern Krayt Dragon",
	socialGroup = "krayt",
	faction = "",
	mobType = MOB_CARNIVORE,
	level = 65,
	chanceHit = 30,
	damageMin = 655,
	damageMax = 1520,
	baseXp = 28549,
	baseHAM = 81000,
	baseHAMmax = 82000,
	armor = 3,
	resists = {55,45,55,35,25,25,35,45,-1},
	meatType = "meat_carnivore",
	meatAmount = 1000,
	hideType = "hide_bristley",
	hideAmount = 950,
	boneType = "bone_mammal",
	boneAmount = 905,
	milk = 0,
	tamingChance = 0.10,
	ferocity = 1,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/krayt_dragon.iff"},
	controlDeviceTemplate = "object/intangible/pet/krayt_hue.iff",
	scale = 0.4,
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"creatureareacombo","stateAccuracyBonus=20"}, {"creatureareableeding","stateAccuracyBonus=20"} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(krayt_dragon_tamable, "krayt_dragon_tamable")
