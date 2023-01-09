holiday_cupid_baby = Creature:new {
	objectName = "",
	customName = "Pigmy Cupid",	
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
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
	weapons = {"creature_spit_large_red"},
	conversationTemplate = "",
	attacks = {
		{"dizzyattack","dizzyChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(holiday_cupid_baby, "holiday_cupid_baby")
