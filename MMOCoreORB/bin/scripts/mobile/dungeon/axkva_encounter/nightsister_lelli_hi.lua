nightsister_lelli_hi = Creature:new {
	objectName = "@mob/creature_names:nightsister_elder",
	customName = "Lelli Hi The Conniver",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 400,
	mobType = MOB_NPC,
	chanceHit = 27.25,
	damageMin = 820,
	damageMax = 1550,
	baseXp = 26654,
	baseHAM = 501000,
	baseHAMmax = 502000,
	armor = 3,
	resists = {41,50,67,34,45,50,32,20,20},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	aggroRadius = 15,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + HEALER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_dathomir_nightsister_guardian.iff"},
	scale = 1.2,
	lootGroups = {
		{
			groups = {
				{group = "ns_lelli_group", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        	groups =
			{
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 4500000,
		},
		{
	        	groups = 
			{
				{group = "armor_attachments", chance = 4000000},
				{group = "clothing_attachments", chance = 6000000},
			},
			lootChance = 5000000,
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "ubar_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(swordsmanmaster,forcewielder),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(nightsister_lelli_hi, "nightsister_lelli_hi")
