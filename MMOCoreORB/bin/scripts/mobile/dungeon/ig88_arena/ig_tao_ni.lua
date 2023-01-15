ig_tao_ni = Creature:new {
	objectName = "",
	customName = "Tao-Ni Security Elite Protector",
	socialGroup = "death_watch",
	pvpFaction = "death_watch",
	faction = "",
	level = 240,
	chanceHit = 200,
	damageMin = 270,
	damageMax = 950,
	baseXp = 10081,
	baseHAM = 126000,
	baseHAMmax = 156000,
	armor = 2,
	resists = {35,45,40,35,45,70,45,35,25},
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
	creatureBitmask = KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/tatooine_npc/hedon_istee.iff"},
        outfit = "ig_taoni_outfit",
	lootGroups = {
		{
			groups = {
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 4000000
		},
		{
			groups =
			{
				{group = "infiltrator_armor_loot",  chance = 4000000},
				{group = "spec_force_armor_loot",  chance = 6000000}
			},
			lootChance = 4000000,
		},
	},
	weapons = {"st_bombardier_weapons"},
	conversationTemplate = "",
	attacks = merge(riflemanmaster,swordsmanmaster,brawlermaster,marksmanmaster)
}

CreatureTemplates:addCreatureTemplate(ig_tao_ni, "ig_tao_ni")
