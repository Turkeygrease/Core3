holiday_candy_graul = Creature:new {
	customName = "Candy Graul",	
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	mobType = MOB_CARNIVORE,
	level = 65,
	chanceHit = 30,
	damageMin = 815,
	damageMax = 1230,
	baseXp = 1549,
	baseHAM = 54500,
	baseHAMmax = 56100,
	armor = 2,
	resists = {25,35,15,55,35,15,100,10,0},
	tamingChance = 0,
	ferocity = 11,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/candy_graul.iff"},
	scale = 0.2,
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

CreatureTemplates:addCreatureTemplate(holiday_candy_graul, "holiday_candy_graul")
