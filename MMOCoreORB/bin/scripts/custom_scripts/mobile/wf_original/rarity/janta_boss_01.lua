janta_boss_01 = Creature:new {
	objectName = "@mob/creature_names:janta_boss_01",
	customName = "Deven Rarmark",
	socialGroup = "janta_tribe",
	faction = "janta_tribe",
	level = 60,
	chanceHit = 0.65,
	damageMin = 470,
	damageMax = 650,
	baseXp = 5830,
	baseHAM = 12000,
	baseHAMmax = 14000,
	armor = 1,
	resists = {-1,40,-1,20,100,100,20,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + HERD + KILLER + HEALER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dantari_male_boss1.iff"},
	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 5500000},
				{group = "janta_common", chance = 1500000},
				{group = "loot_kit_parts", chance = 3000000}
			},
			lootChance = 8000000
		},
		{
	        	groups = 
			{
				{group = "janta_common", chance = 10000000},
			},
			lootChance = 4500000,
		}
	},
	weapons = {"primitive_weapons"},
	conversationTemplate = "",
	attacks = merge(pikemanmaster,fencermaster,brawlermaster)
}

CreatureTemplates:addCreatureTemplate(janta_boss_01, "janta_boss_01")
