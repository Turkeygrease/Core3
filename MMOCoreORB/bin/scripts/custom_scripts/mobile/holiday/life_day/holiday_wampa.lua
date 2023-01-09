holiday_wampa = Creature:new {
	objectName = "@mob/creature_names:bull_rancor",
	customName = "a Wampa",	
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	level = 65,
	chanceHit = 30,
	damageMin = 815,
	damageMax = 1230,
	baseXp = 28549,
	baseHAM = 104500,
	baseHAMmax = 105100,
	armor = 3,
	resists = {25,35,15,55,35,15,100,10,0},
	meatType = "meat_carnivore",
	meatAmount = 1000,
	hideType = "hide_leathery",
	hideAmount = 900,
	boneType = "bone_mammal",
	boneAmount = 850,
	milk = 0,
	tamingChance = 0.01,
	ferocity = 11,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/wampa.iff"},
	controlDeviceTemplate = "object/intangible/pet/rancor_hue.iff",	
	scale = .50,	
	lootGroups = {
		{
			groups = {
				{group = "grenades_looted", chance = 850000},
				{group = "pistols", chance = 750000},
				{group = "heavy_weapons", chance = 500000},
				{group = "rifles", chance = 750000},
				{group = "carbines", chance = 500000},
				{group = "grenades_looted", chance = 500000},
				{group = "armor_all", chance = 1000000},
				{group = "melee_unarmed", chance = 1000000},
				{group = "wearables_common", chance = 500000},
				{group = "wearables_uncommon", chance = 500000}
			},
			lootChance = 10000000
		}
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"stunattack","stunChance=50"},
		{"knockdownattack","knockdownChance=50"}
	}
}

CreatureTemplates:addCreatureTemplate(holiday_wampa, "holiday_wampa")
