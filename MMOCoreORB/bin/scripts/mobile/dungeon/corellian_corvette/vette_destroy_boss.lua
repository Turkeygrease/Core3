vette_destroy_boss = Creature:new {
	objectName = "",
	customName = "Corvette Defender",
	socialGroup = "self",
	pvpFaction = "",
	faction = "",
	mobType = MOB_NPC,
	level = 500,
	chanceHit = 8.5,
	damageMin = 320,
	damageMax = 850,
	baseXp = 26845,
	bonusType = "pve_xp",
	bonusXP = 700,
	baseHAM = 881000,
	baseHAMmax = 899000,
	armor = 2,
	resists = {15,35,35,45,55,65,95,75,15},
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
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {
		"object/mobile/dressed_jedi_trainer_chiss_male_01.iff"},
	lootGroups = {
		{
	        groups = {
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        groups = {
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        groups = {
				{group = "krayt_pearls", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        groups = {
				{group = "fifth_gen_oldrep", chance = 3400000},
				{group = "jerec_robe", chance = 3300000},
				{group = "qurahn_robe", chance = 3300000},
			},
			lootChance = 9900000,
		},
		{
	        groups = {
				{group = "infiltrator_armor_loot", chance = 5000000},
				{group = "spec_force_armor_loot", chance = 5000000},
			},
			lootChance = 9500000,
		},
		{
	        groups = {
				{group = "infiltrator_armor_loot", chance = 5000000},
				{group = "spec_force_armor_loot", chance = 5000000},
			},
			lootChance = 9500000,
		},
		
	},

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

CreatureTemplates:addCreatureTemplate(vette_destroy_boss, "vette_destroy_boss")
