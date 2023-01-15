ig88_npc_boss = Creature:new {
	objectName = "@mob/creature_names:ig_assassin_droid",
	customName = "IG-88",
	socialGroup = "death_watch",
	pvpFaction = "death_watch",
	faction = "",
	mobType = MOB_NPC,
	level = 500,
	chanceHit = 200,
	damageMin = 800,
	damageMax = 2275,
	baseXp = 12612,
	bonusType = "pve_xp",
	bonusXP = 1500,
	baseHAM = 1896000,
	baseHAMmax = 1900000,
	armor = 3,
	resists = {55,55,40,60,30,35,40,35,15},
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
	creatureBitmask = PACK,
	optionsBitmask = 128,
	diet = HERBIVORE,
	scale = 2.5,

	templates = {"object/mobile/ig_assassin_droid.iff"},
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
				{group = "tusken_dot_group", chance = 10000000},
			},
			lootChance = 8000000
		},
		{
	        groups = {
				{group = "krayt_pearls", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        groups = {
				{group = "krayt_pearls", chance = 10000000},
			},
			lootChance = 4500000,
		},
		{
			groups = {
				{group = "ig_boss_loot", chance = 10000000},
			},
			lootChance = 10000000
		},
		{
			groups = {
				{group = "ig_tissue", chance = 10000000},
			},
			lootChance = 10000000
		},
				
	},

	defaultWeapon = "object/weapon/ranged/droid/droid_droideka_ranged.iff",
	defaultAttack = "attack",

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

CreatureTemplates:addCreatureTemplate(ig88_npc_boss, "ig88_npc_boss")
