ba_forcemaster = Creature:new {
	objectName = "",
	customName = "Dark Adept of the Force",
	socialGroup = "Dark Jedi",
	pvpFaction = "",
	faction = "",
	level = 325,
	chanceHit = 40,
	damageMin = 700,
	damageMax = 1500,
	baseXp = 11675,
	baseHAM = 31200,
	baseHAMmax = 45000,
	armor = 3,
	resists = {35,45,40,45,40,30,35,40,40},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_fightmaster_jorak.iff"},
--	outfit = "exar_outfit",

	lootGroups = {},
	weapons = {"light_jedi_weapons"},
	conversationTemplate = "",
	attacks = merge(lightsabermaster,forcepowermaster)
	}

CreatureTemplates:addCreatureTemplate(ba_forcemaster, "ba_forcemaster")
