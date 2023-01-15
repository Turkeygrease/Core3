geo_jedi = Creature:new {
	objectName = "",
	customName = "Spirit of Darth Kivala",
	socialGroup = "geonosian_creature",
	pvpFaction = "",
	faction = "",
	mobType = MOB_NPC,
	level = 500,
	chanceHit = 45.5,
	damageMin = 396,
	damageMax = 1416,
	baseXp = 3465,
	bonusType = "pve_xp",
	bonusXP = 1000,
	baseHAM = 1217000,
	baseHAMmax = 1330000,
	armor = 2,
	resists = {52,25,25,65,65,65,65,44,33},
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
	creatureBitmask = KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/sith_ghost_m.iff"},
	scale = 1.5,
	lootGroups = {
		{
	        	groups =
			{
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        	groups =
			{
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        	groups =
			{
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 10000000,
		},
		{
	        	groups =
			{
				{group = "power_crystals", chance = 10000000},
			},
			lootChance = 8500000,
		},
		{
	        	groups =
			{
				{group = "fifth_gen", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "jedi_armor_01", chance = 10000000},				
			},
			lootChance = 9500000,
		},
		
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "dark_jedi_weapons_gen4",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(lightsabermaster,forcewielder),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(geo_jedi, "geo_jedi")
