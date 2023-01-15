ig_mouse_droid = Creature:new {
	objectName = "",
	customName = "Mouse Droid",
	socialGroup = "death_watch",
	pvpFaction = "death_watch",
	faction = "",
	mobType = MOB_NPC,
	level = 1,
	chanceHit = 0.26,
	damageMin = 55,
	damageMax = 265,
	baseXp = 1,
	baseHAM = 5,
	baseHAMmax = 50,
	armor = 0,
	resists = {10,10,10,10,10,10,10,10,10},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.000000,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	diet = HERBIVORE,

	templates = {"object/mobile/mouse_droid.iff"},
	scale = 2.0,
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "battle_droid_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(riflemanmaster,pistoleermaster,carbineermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(ig_mouse_droid, "ig_mouse_droid")
