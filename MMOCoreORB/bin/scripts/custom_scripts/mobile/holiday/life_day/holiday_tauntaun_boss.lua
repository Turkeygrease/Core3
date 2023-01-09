holiday_tauntaun_boss = Creature:new {
	objectName = "@mob/creature_names:unkajo",
	customName = "The Abominabital Tauntaun",
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	level = 500,
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
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/tauntaun_hue.iff"},
	scale = 3.5,	
	lootGroups = {

		{
	        	groups = 
			{
				{group = "crovaxloot_group", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        	groups = 
			{
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
			groups = {
				{group = "kkorrwrot_boss", chance = 10000000},
			},
			lootChance = 7500000
		},
		{
	        	groups = 
			{
				{group = "corvette_boss", chance = 10000000},
			},
			lootChance = 9500000,
		},
				
	},
	weapons = {},
	conversationTemplate = "",
	attacks = {
		{"creatureareapoison"},
		{"creatureareaknockdown","knockdownChance=90"}
	}
}

CreatureTemplates:addCreatureTemplate(holiday_tauntaun_boss, "holiday_tauntaun_boss")
