essence_of_axkva_min = Creature:new {
	objectName = "@mob/creature_names:axkva_min",
	customName = "Essence of Axkva Min",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 500,
	chanceHit = 300,
	damageMin = 1800,
	damageMax = 2800,
	baseHAM = 2000000,
	baseHAMmax = 2000000,
	armor = 3,
	resists = {99,99,99,99,99,99,99,99,99},
	aggroRadius = 1,
	pvpBitmask = NONE,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,

	templates = {"object/mobile/dressed_dathomir_nightsister_axkva.iff"},
	scale = 1.6,
	lootGroups = {
		{
	        	groups =
			{
				{group = "nightsister_common", chance = 3000000},
				{group = "power_crystals", chance = 4000000},
				{group = "nightsister_rare", chance = 3000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "axkva_min", chance = 10000000},
			},
			lootChance = 9000000
		}
	},
	weapons = {"mixed_force_weapons"},
	conversationTemplate = "",
	attacks = merge(fencermaster,swordsmanmaster,tkamaster,pikemanmaster,brawlermaster,forcepowermaster)
}

CreatureTemplates:addCreatureTemplate(essence_of_axkva_min, "essence_of_axkva_min")
