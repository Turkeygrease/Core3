holiday_tauntaun = Creature:new {
	objectName = "@mob/creature_names:cu_pa",
	customName = "a Tauntaun",	
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	level = 65,
	chanceHit = 30,
	damageMin = 1150,
	damageMax = 1160,
	baseXp = 714,
	baseHAM = 82000,
	baseHAMmax = 82400,
	armor = 0,
	resists = {10,20,30,20,20,20,50,-1,-1},
	meatType = "meat_herbivore",
	meatAmount = 450,
	hideType = "hide_wooly",
	hideAmount = 325,
	boneType = "bone_mammal",
	boneAmount = 250,
	milkType = "milk_wild",
	milk = 250,
	tamingChance = 0.25,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = HERD,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/tauntaun_hue.iff"},
	controlDeviceTemplate = "object/intangible/pet/cu_pa_hue.iff",
	lootGroups = {},
	weapons = {"creature_spit_large_red"},
	conversationTemplate = "",
	attacks = {
		{"dizzyattack","dizzyChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(holiday_tauntaun, "holiday_tauntaun")
