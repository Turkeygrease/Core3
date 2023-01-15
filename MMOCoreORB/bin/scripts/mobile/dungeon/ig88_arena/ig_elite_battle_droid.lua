ig_elite_battle_droid = Creature:new {
	objectName = "@mob/creature_names:mand_bunker_battle_droid",
	customName = "IG-88 ELITE Battle Droid",
	socialGroup = "death_watch",
	pvpFaction = "death_watch",
	faction = "",
	level = 350,
	chanceHit = 290,
	damageMin = 500,
	damageMax = 1775,
	baseXp = 12612,
	baseHAM = 396000,
	baseHAMmax = 400000,
	armor = 2,
	resists = {45,-1,40,50,20,-1,40,35,5},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	aggroRadius = 80,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {
		"object/mobile/death_watch_battle_droid.iff",
		"object/mobile/death_watch_battle_droid_02.iff",
		"object/mobile/death_watch_battle_droid_03.iff"},
	scale = 3.0,	
	lootGroups = {
		{
			groups = {
				{group = "death_watch_bunker_ingredient_protective",   chance = 6500000},
				{group = "death_watch_bunker_ingredient_binary", chance = 6300000},
				{group = "death_watch_bunker_lieutenants",  chance = 3500000},
				{group = "death_watch_bunker_ingredient_protective",  chance = 6400000}
			},
			lootChance = 93500000
		}
	},
	weapons = {"st_bombardier_weapons"},
	conversationTemplate = "",
	attacks = merge(commandomaster,riflemanmaster,carbineermaster,pikemanmaster)
}

CreatureTemplates:addCreatureTemplate(ig_elite_battle_droid, "ig_elite_battle_droid")
