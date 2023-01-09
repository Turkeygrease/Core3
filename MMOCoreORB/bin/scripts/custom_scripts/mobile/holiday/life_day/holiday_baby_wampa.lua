holiday_baby_wampa = Creature:new {
	objectName = "@mob/creature_names:unkajo",
	customName = "a baby Wampa",
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	level = 300,
	chanceHit = 0.60,
	damageMin = 400,
	damageMax = 700,
	baseXp = 5,
	baseHAM = 56000,
	baseHAMmax = 57000,
	armor = 0,
	resists = {0,0,0,0,0,0,0,0,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = NONE,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/wampa.iff"},
	scale = .20,	
	lootGroups = {},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack","stunChance=100"},
		{"creatureareaknockdown","knockdownChance=100"}
	}
}

CreatureTemplates:addCreatureTemplate(holiday_baby_wampa, "holiday_baby_wampa")
