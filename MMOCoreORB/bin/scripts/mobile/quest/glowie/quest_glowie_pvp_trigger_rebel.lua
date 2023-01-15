quest_glowie_pvp_trigger_rebel = Creature:new {
	objectName = "",
	customName = "General Sintu",
	socialGroup = "rebel",
	pvpFaction = "rebel",
	faction = "rebel",
	level = 25,
	mobType = MOB_NPC,
	chanceHit = 40,
	damageMin = 240,
	damageMax = 250,
	baseXp = 2637,
	baseHAM = 7200,
	baseHAMmax = 8800,
	armor = 0,
	resists = {0,20,0,0,0,0,0,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = NONE,
	creatureBitmask = NONE,
	optionsBitmask = INVULNERABLE + CONVERSABLE + INTERESTING,
	diet = NONE,

	templates = {"object/mobile/dressed_rebel_general_rodian_female_01.iff"},
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "imperial_weapons_heavy",
	secondaryWeapon = "none",
	conversationTemplate = "glowie_expansion_quest_pvp_rebel_template",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(quest_glowie_pvp_trigger_rebel, "quest_glowie_pvp_trigger_rebel")
