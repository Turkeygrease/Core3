holiday_candy_graul_boss = Creature:new {
	objectName = "",
	customName = "Elder Candy Graul",
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
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
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"creatureareapoison"},
		{"creatureareaknockdown","knockdownChance=90"}
	}
}

CreatureTemplates:addCreatureTemplate(holiday_candy_graul_boss, "holiday_candy_graul_boss")
