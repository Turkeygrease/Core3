world_s_rare_a = Creature:new {
	objectName = "@mob/creature_names:dark_jedi_master",
	customName = "Grievous Replica-System Rare",
	socialGroup = "death_watch",
	faction = "death_watch",
	mobType = MOB_NPC,
	level = 500,
	chanceHit = 55.5,
	damageMin = 900,
	damageMax = 1600,
	baseXp = 79336,
	bonusType = "pve_xp",
	bonusXP = 500,
	baseHAM = 850000,
	baseHAMmax = 900000,
	armor = 3,
	resists = {55,60,45,70,70,70,45,45,25},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {
		"object/mobile/ep3/general_grievous.iff"
	},

	scale = 1.4,

	lootGroups = {
		{
	    	groups = {
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 1000000,
		},
		{
	    	groups = {
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 1000000,
		},
		{
	    	groups = {
				{group = "fifth_gen", chance = 10000000},
			},
			lootChance = 1000000,
		},
		{
			groups = {
				{group = "crovaxloot_group", chance =  10000000}
			},
			lootChance = 1000000
		},
		{
	    	groups = {
				{group = "power_crystals", chance = 10000000},
			},
			lootChance = 1000000,
		},
		{
	    	groups = {
				{group = "jedi_jewelry", chance = 10000000},
			},
			lootChance = 1000000,
		},
		{
			groups = {
				{group = "holocron_dark", chance = 600000},
				{group = "holocron_light", chance = 600000},
				{group = "power_crystals", chance = 600000},
				{group = "rifles", chance = 1300000},
				{group = "pistols", chance = 1300000},
				{group = "melee_weapons", chance = 1300000},
				{group = "armor_attachments", chance = 1100000},
				{group = "clothing_attachments", chance = 1100000},
				{group = "carbines", chance = 1300000},
				{group = "dark_jedi_common", chance = 800000}
			}
		}
	},

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

CreatureTemplates:addCreatureTemplate(world_s_rare_a, "world_s_rare_a")
