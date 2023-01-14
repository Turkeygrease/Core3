lord_jagganoth = Creature:new {
	customName = "Lord Jagganoth",
	socialGroup = "Dark Jedi",
	pvpFaction = "",
	faction = "",
	mobType = MOB_NPC,
	level = 320,
	chanceHit = 100,
	damageMin = 900,
	damageMax = 2700,
	baseXp = 24081,
	baseHAM = 1861000,
	baseHAMmax = 1920000,
	armor = 3,
	resists = {40,50,50,30,20,70,60,30,60},
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

	templates = {"object/mobile/vendor/rodian_male.iff"},
	outfit = "jagganoth_outfit",
	scale = 1.2,
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "dark_jedi_weapons_gen4",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(lightsabermaster,forcepowermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(lord_jagganoth, "lord_jagganoth")
