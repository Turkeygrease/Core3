vette_rescue_boss = Creature:new {
	objectName = "",
	customName = "Corvette Slaver",
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
	baseHAM = 781000,
	baseHAMmax = 799000,
	armor = 2,
	resists = {95,95,15,65,75,15,15,15,15},
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
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_marauder.iff"},
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
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        groups = {
				{group = "holocron_light", chance = 10000000},
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
				{group = "elite_melee_schems_01", chance = 10000000},
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

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "mixed_force_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(pikemanmaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(vette_rescue_boss, "vette_rescue_boss")
