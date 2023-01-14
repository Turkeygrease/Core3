pvp_loot_vendor = Creature:new {
	customName = "PvP Currency Loot Box Exchange",	
	socialGroup = "",
	pvpFaction = "",
	faction = "",
	mobType = MOB_NPC,
	level = 1,
	chanceHit = 1.5,
	damageMin = 20,
	damageMax = 100,
	baseXp = 0,
	baseHAM = 500,
	baseHAMmax = 1000,
	armor = 2,
	resists = {0,0,0,0,0,0,0,0,0},--kinetic,energy,blast,heat,cold,electric,acid,stun,ls
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0.0,
	ferocity = 11,
	pvpBitmask = NONE,
	creatureBitmask = NONE,
	optionsBitmask = 264, --for conversation
	diet = CARNIVORE,

	templates = {"object/mobile/som/hk47.iff"},
	--	outfit = "guile_outfit",	
	scale = 1.0,
	lootGroups = {},
	defaultWeapon = "",

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "light_jedi_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "PvpCurrencyVendor_convo_template",

	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(lightsabermaster,forcepowermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(pvp_loot_vendor, "pvp_loot_vendor")
