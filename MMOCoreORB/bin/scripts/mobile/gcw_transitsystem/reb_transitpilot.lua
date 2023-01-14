reb_transitpilot = Creature:new {
    customName = "Alliance Factional Pilot",
	socialGroup = "rebel",
	pvpFaction = "rebel",
	faction = "rebel",
	mobType = MOB_NPC,
	level = 80,
	chanceHit = 20,
	damageMin = 150,
	damageMax = 550,
	baseXp = 1470,
	baseHAM = 4000,
	baseHAMmax = 4000,
	armor = 1,
	resists = {30,30,30,30,35,35,20,20,-1},
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
	optionsBitmask = 264, --for conversation
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_rebel_pilot_human_male_01.iff"},
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "reb_transitconvo_template",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(reb_transitpilot, "reb_transitpilot")
