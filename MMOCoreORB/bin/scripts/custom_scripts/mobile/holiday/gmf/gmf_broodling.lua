gmf_broodling = Creature:new {
	customName = "Spider Broodling",
	socialGroup = "nightsister",
	level = 44,
	chanceHit = 0.46,
	damageMin = 390,
	damageMax = 490,
	baseXp = 4370,
	baseHAM = 39500,
	baseHAMmax = 41600,
	armor = 1,
	resists = {130,130,160,125,-1,-1,0,-1,-1},
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = CARNIVORE,
	templates = {
		"object/mobile/gaping_spider.iff",
		"object/mobile/hermit_spider.iff",
		"object/mobile/nightspider.iff"
	},
	scale = .2,
	lootGroups = {},
	weapons = {"creature_spit_small_toxicgreen"},
	conversationTemplate = "",
	attacks = {
		{"creatureareapoison",""},
		{"strongpoison",""}
	}
}

CreatureTemplates:addCreatureTemplate(gmf_broodling, "gmf_broodling")
