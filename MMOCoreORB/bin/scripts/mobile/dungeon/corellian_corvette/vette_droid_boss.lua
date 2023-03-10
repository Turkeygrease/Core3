vette_droid_boss = Creature:new {
	objectName = "",
	customName = "Corvette Elite Droideka",
	socialGroup = "self",
	faction = "",
	mobType = MOB_NPC,
	level = 400,
	chanceHit = 8.5,
	damageMin = 320,
	damageMax = 1250,
	baseXp = 15417,
	bonusType = "pve_xp",
	bonusXP = 700,
	baseHAM = 681000,
	baseHAMmax = 699000,
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
	pvpBitmask = ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = NONE,

	templates = {"object/mobile/droideka.iff"},
	scale = 1.8,
	lootGroups = {
		{
	        groups = {
				{group = "armor_attachments", chance = 10000000},
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
				{group = "crovaxloot_group", chance = 10000000},
			},
			lootChance = 6500000,
		},
		{
	        groups = {
				{group = "corvette_boss", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        groups = {
				{group = "elite_ranged_schems_01", chance = 10000000},
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
		{
	        groups = {
				{group = "infiltrator_armor_loot", chance = 5000000},
				{group = "spec_force_armor_loot", chance = 5000000},
			},
			lootChance = 6500000,
		},
	},

	conversationTemplate = "",
	defaultAttack = "attack",
	defaultWeapon = "object/weapon/ranged/droid/droid_droideka_ranged.iff",

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

CreatureTemplates:addCreatureTemplate(vette_droid_boss, "vette_droid_boss")
