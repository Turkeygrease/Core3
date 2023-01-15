holiday_cupid_boss = Creature:new {
	customName = "Cupid",
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	mobType = MOB_HERBIVORE,
	level = 300,
	chanceHit = 300,
	damageMin = 345,
	damageMax = 1450,
	baseXp = 296845,
	bonusType = "holiday_xp",
	bonusXP = 100,
	baseHAM = 691000,
	baseHAMmax = 692000,
	armor = 2,
	resists = {20,30,40,50,40,25,35,40,-1},
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = 128,
	diet = HERBIVORE,
	templates = {"object/mobile/candy_graul_hue.iff"},
	scale = 1.0,	
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"creatureareapoison"}, {"creatureareaknockdown","knockdownChance=90"} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(holiday_cupid_boss, "holiday_cupid_boss")
