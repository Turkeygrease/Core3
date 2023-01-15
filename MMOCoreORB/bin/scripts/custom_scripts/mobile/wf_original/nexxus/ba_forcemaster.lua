ba_forcemaster = Creature:new {
	customName = "Dark Adept of the Force",
	socialGroup = "Dark Jedi",
	pvpFaction = "",
	faction = "",
	mobType = MOB_NPC,
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

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "light_jedi_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(lightsabermaster,forcepowermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(ba_forcemaster, "ba_forcemaster")
