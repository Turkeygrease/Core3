holiday_cupid_baby = Creature:new {
	customName = "Pigmy Cupid",	
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	mobType = MOB_HERBIVORE,
	level = 65,
	chanceHit = 30,
	damageMin = 1150,
	damageMax = 1160,
	baseXp = 714,
	baseHAM = 52000,
	baseHAMmax = 62400,
	armor = 0,
	resists = {10,20,30,20,20,20,50,-1,-1},
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = HERD,
	optionsBitmask = 128,
	diet = HERBIVORE,
	scale = 0.6,
	templates = {"object/mobile/candy_graul_hue.iff"},
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

CreatureTemplates:addCreatureTemplate(holiday_cupid_baby, "holiday_cupid_baby")
