ig_droideka = Creature:new {
	objectName = "@mob/creature_names:geonosian_droideka_crazed",
	customName = "IG-88 Droideka",
	socialGroup = "death_watch",
	pvpFaction = "death_watch",
	faction = "",
	mobType = MOB_NPC,
	level = 300,
	chanceHit = 140,
	damageMin = 300,
	damageMax = 1450,
	baseXp = 22650,
	baseHAM = 226000,
	baseHAMmax = 256000,
	armor = 2,
	resists = {140,155,110,125,125,91,90,90,3},
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
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/droideka.iff"},
	scale = 1.3,
	lootGroups = {
		{
	        groups = {
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "death_watch_bunker_ingredient_protective",   chance = 2500000},
				{group = "death_watch_bunker_ingredient_binary", chance = 2500000},
				{group = "death_watch_bunker_lieutenants",  chance = 2500000},
				{group = "death_watch_bunker_ingredient_protective",  chance = 2500000}
			},
			lootChance = 93500000
		},
	},
	defaultAttack = "creaturerangedattack",
	defaultWeapon = "object/weapon/ranged/droid/droid_droideka_ranged.iff",

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(ig_droideka, "ig_droideka")
