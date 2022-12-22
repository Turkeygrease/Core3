me_lesser_desert_womp_rat = Creature:new {
	objectName = "@mob/creature_names:lesser_desert_womprat",
	customName = "",
	socialGroup = "rat",
	faction = "",
	mobType = MOB_CARNIVORE,
	level = 10,
	chanceHit = 0.28,
	damageMin = 90,
	damageMax = 110,
	baseXp = 356,
	baseHAM = 810,
	baseHAMmax = 990,
	armor = 0,
	resists = {0, 0, 0, 0, 0, 0, 0, -1, -1},
	meatType = "meat_wild",
	meatAmount = 14,
	hideType = "hide_leathery",
	hideAmount = 13,
	boneType = "bone_mammal",
	boneAmount = 12,
	milk = 0,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
	scale = 1,
	customAiMap = "",

	templates = {
		"object/mobile/womp_rat.iff"
	},
	controlDeviceTemplate = "object/intangible/pet/womp_rat_hue.iff",

	lootGroups = {
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",

	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = {
		{"intimidationattack", ""}
	},
	secondaryAttacks = {},
	conversationTemplate = ""
}

CreatureTemplates:addCreatureTemplate(me_lesser_desert_womp_rat, "me_lesser_desert_womp_rat")