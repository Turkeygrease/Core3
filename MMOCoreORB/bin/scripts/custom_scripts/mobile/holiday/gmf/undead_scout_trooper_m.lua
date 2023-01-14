undead_scout_trooper_m = Creature:new {
	objectName = "",
	customName = "an Undead Scout Trooper",
	socialGroup = "nightsister",
	pvpFaction = "nightsister",
	faction = "nightsister",
	mobType = MOB_NPC,
	level = 360,
	chanceHit = 0.8,
	damageMin = 396,
	damageMax = 916,
	baseXp = 3465,
	baseHAM = 211700,
	baseHAMmax = 213000,
	armor = 2,
	resists = {52,25,25,65,65,65,65,-1,-1},
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/outbreak_undead_deathtrooper_02_m.iff"},
	lootGroups = {
		{
	        groups = {
				{group = "undead_armor_d", chance = 10000000},
			},
			lootChance = 4000000,
		},
		{
			groups = {
				{group = "color_crystals", chance = 150000},
				{group = "junk", chance = 7300000},
				{group = "rifles", chance = 600000},
				{group = "holocron_dark", chance = 150000},
				{group = "holocron_light", chance = 150000},
				{group = "carbines", chance = 600000},
				{group = "pistols", chance = 600000},
				{group = "clothing_attachments", chance = 200000},
				{group = "armor_attachments", chance = 250000}
			},
			lootChance = 3900000,
		},
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "stormtrooper_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(riflemanmaster,pistoleermaster,carbineermaster,brawlermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(undead_scout_trooper_m, "undead_scout_trooper_m")
