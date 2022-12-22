white_thranta_technician = Creature:new {
	customName = "a White Thranta technician",
	socialGroup = "thug",
	faction = "thug",
	mobType = MOB_NPC,
	level = 7,
	chanceHit = 0.46,
	damageMin = 65,
	damageMax = 80,
	baseXp = 250,
	baseHAM = 290,
	baseHAMmax = 390,
	armor = 0,
	resists = {10, 10, 10, 10, 10, 10, 10, -1, -1},
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
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1,
	customAiMap = "",

	templates = {
		"object/mobile/dressed_corsec_detective_human_female_01.iff",
		"object/mobile/dressed_corsec_detective_human_male_01.iff"
	},

	lootGroups = {
		{
			groups = {
				{group = "junk", chance = 4000000},
				{group = "wearables_common", chance = 2000000},
				{group = "pistols", chance = 1000000},
				{group = "tailor_components", chance = 1500000},
				{group = "loot_kit_parts", chance = 1500000}
			}
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "pirate_weapons_light",
	secondaryWeapon = "none",

	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(marksmannovice,brawlernovice),
	secondaryAttacks = {},
	conversationTemplate = "",
	reactionStf = "@npc_reaction/slang"
}

CreatureTemplates:addCreatureTemplate(white_thranta_technician, "white_thranta_technician")