holiday_candy_graul_boss = Creature:new {
	objectName = "",
	customName = "Elder Candy Graul",
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	mobType = MOB_CARNIVORE,
	level = 300,
	chanceHit = 300,
	damageMin = 345,
	damageMax = 1450,
	baseXp = 296845,
	bonusType = "holiday_xp",
	bonusXP = 100,
	baseHAM = 491000,
	baseHAMmax = 492000,
	armor = 2,
	resists = {20,30,40,50,40,25,35,40,-1},
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/candy_graul.iff"},
	scale = .6,	
	lootGroups = {	
	},

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

CreatureTemplates:addCreatureTemplate(holiday_candy_graul_boss, "holiday_candy_graul_boss")
