holiday_tauntaun = Creature:new {
	objectName = "@mob/creature_names:cu_pa",
	customName = "a Tauntaun",	
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	mobType = MOB_HERBIVORE,
	level = 65,
	chanceHit = 30,
	damageMin = 1150,
	damageMax = 1160,
	baseXp = 714,
	baseHAM = 82000,
	baseHAMmax = 82400,
	armor = 0,
	resists = {10,20,30,20,20,20,50,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 450,
	hideType = "hide_wooly",
	hideAmount = 325,
	boneType = "bone_mammal",
	boneAmount = 250,
	milkType = "milk_wild",
	milk = 250,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = HERD,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {
		"object/mobile/tauntaun_hue.iff"
	},
	
	controlDeviceTemplate = "object/intangible/pet/cu_pa_hue.iff",
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "creature_spit_large_red",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"dizzyattack","dizzyChance=50"} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(holiday_tauntaun, "holiday_tauntaun")
