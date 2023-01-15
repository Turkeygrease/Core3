armored_dewback_tamable = Creature:new {
	objectName = "@mob/creature_names:mountain_dewback",
	customName = "Greater Armored Dewback",
	socialGroup = "geonosian_creature",
	faction = "",
	mobType = MOB_CARNIVORE,
	level = 1,
	chanceHit = 1,
	damageMin = 50,
	damageMax = 100,
	baseXp = 100,
	baseHAM = 50,
	baseHAMmax = 100,
	armor = 1,
	resists = {1,1,1,1,1,1,1,1,-1},
	meatType = "meat_reptilian",
	meatAmount = 330,
	hideType = "hide_leathery",
	hideAmount = 240,
	boneType = "bone_mammal",
	boneAmount = 170,
	milk = 0,
	tamingChance = 1,
	ferocity = 1,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/dewback_armored.iff"},
	controlDeviceTemplate = "object/intangible/pet/dewback_armor_hue.iff",
	scale = 1.50,
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"creatureareableeding","stateAccuracyBonus=50"}, {"dizzyattack","stateAccuracyBonus=50"} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(armored_dewback_tamable, "armored_dewback_tamable")
