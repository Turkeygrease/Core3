nightsister_kimaru = Creature:new {
	objectName = "@mob/creature_names:nightsister_elder",
	customName = "Kimaru The False",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 278,
	chanceHit = 27.25,
	damageMin = 920,
	damageMax = 1650,
	baseXp = 26654,
	baseHAM = 591000,
	baseHAMmax = 592000,
	armor = 3,
	resists = {41,50,67,34,45,50,32,20,20},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	aggroRadius = 15,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + HEALER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_dathomir_nightsister_elder.iff"},
	scale = 1.2,
	lootGroups = {
		{
			groups = {
				{group = "ns_kimaru_group", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        	groups =
			{
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 4500000,
		},
		{
	        	groups = 
			{
				{group = "armor_attachments", chance = 4000000},
				{group = "clothing_attachments", chance = 6000000},
			},
			lootChance = 5000000,
		}
	},
	weapons = {"warden_banhammer_weapons"},
	conversationTemplate = "",
	attacks = {
		{"swordsmanmaster"},
		{"intimidationattack","intimidationChance=100"},
		{"creatureareadisease","stateAccuracyBonus=100"},
		{"creatureareapoison","stateAccuracyBonus=100"}
	}
}

CreatureTemplates:addCreatureTemplate(nightsister_kimaru, "nightsister_kimaru")
