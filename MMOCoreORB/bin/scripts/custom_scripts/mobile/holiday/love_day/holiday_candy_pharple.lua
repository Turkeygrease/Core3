holiday_candy_pharple = Creature:new {
	objectName = "",
	customName = "Candy Pharple",	
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	level = 260,
	chanceHit = 0.28,
	damageMin = 220,
	damageMax = 830,
	baseXp = 1356,
	baseHAM = 41675,
	baseHAMmax = 42825,
	armor = 0,
	resists = {0,0,0,0,0,0,0,0,0},
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = NONE,
	optionsBitmask = 128,
	diet = HERBIVORE,
	templates = {"object/mobile/candy_pharple.iff"},
	scale = 1,	
	controlDeviceTemplate = "",
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack","stunChance=100"}
	}
}

CreatureTemplates:addCreatureTemplate(holiday_candy_pharple, "holiday_candy_pharple")
