holiday_cupid_boss = Creature:new {
	objectName = "",
	customName = "Cupid",
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
	lootGroups = {	
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"creatureareapoison"},
		{"creatureareaknockdown","knockdownChance=90"}
	}
}

CreatureTemplates:addCreatureTemplate(holiday_cupid_boss, "holiday_cupid_boss")
