candy_graul = Creature:new {
	objectName = "",
	customName = "Candy Graul",
	socialGroup = "graul",
	faction = "",
	level = 173,
	chanceHit = 10.75,
	damageMin = 1095,
	damageMax = 1900,
	baseXp = 16411,
	baseHAM = 120000,
	baseHAMmax = 125000,
	armor = 2,
	resists = {175,155,190,190,190,155,155,155,-1},
	tamingChance = 0,
	ferocity = 15,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,

	templates = {"object/mobile/candy_graul.iff"},
	scale = .2,
	lootGroups = {},
	weapons = {"creature_spit_small_yellow"},
	conversationTemplate = "",
	attacks = {
		{"creatureareableeding",""},
		{"stunattack",""}
	}
}

CreatureTemplates:addCreatureTemplate(candy_graul, "candy_graul")
