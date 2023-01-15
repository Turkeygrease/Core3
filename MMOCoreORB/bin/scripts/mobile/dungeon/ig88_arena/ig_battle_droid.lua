ig_battle_droid = Creature:new {
	objectName = "@mob/creature_names:mand_bunker_battle_droid",
	customName = "IG-88 Battle Droid",
	socialGroup = "death_watch",
	pvpFaction = "death_watch",
	faction = "",
	mobType = MOB_NPC,
	level = 300,
	chanceHit = 110,
	damageMin = 100,
	damageMax = 1175,
	baseXp = 12612,
	baseHAM = 226000,
	baseHAMmax = 256000,
	armor = 2,
	resists = {27,25,10,20,10,25,40,25,15},
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
	lootGroups = {
		{
			groups = {
				{group = "death_watch_bunker_ingredient_protective",   chance = 2500000},
				{group = "death_watch_bunker_ingredient_binary", chance = 2500000},
				{group = "death_watch_bunker_lieutenants",  chance = 2500000},
				{group = "death_watch_bunker_ingredient_protective",  chance = 2500000}
			},
			lootChance = 93500000
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "battle_droid_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(riflemanmaster,pistoleermaster,carbineermaster,brawlermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(ig_battle_droid, "ig_battle_droid")
