event_scientist_boss = Creature:new {
	customName = "Outbreak Containment Officer",
	randomNameTag = true,
	socialGroup = "nightsister",
	pvpFaction = "nightsister",
	faction = "nightsister",
	mobType = MOB_NPC,
	level = 500,
	chanceHit = 0.8,
	damageMin = 396,
	damageMax = 1616,
	baseXp = 3465,
	bonusType = "pve_xp",
	bonusXP = 200,
	baseHAM = 831700,
	baseHAMmax = 833000,
	armor = 3,
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
	templates = {"object/mobile/dressed_stormtrooper_black_black.iff"},
	scale = 1.5,
	lootGroups = {
		{
	        groups = {
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        groups = {
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 2500000,
		},
		{
	        groups = {
				{group = "corvette_boss", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        groups = {
				{group = "halloween_group", chance = 10000000},
			},
			lootChance = 10000000,
		},
		{
			groups = {
				{group = "color_crystals", chance = 150000},
				{group = "junk", chance = 7300000},
				{group = "rifles", chance = 600000},
				{group = "holocron_dark", chance = 150000},
				{group = "holocron_light", chance = 150000},
				{group = "carbines", chance = 600000},
				{group = "pistols", chance = 600000},
				{group = "clothing_attachments", chance = 200000},
				{group = "armor_attachments", chance = 250000}
			},
			lootChance = 3900000
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "dark_trooper_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(riflemanmaster,marksmanmaster,fencermaster,brawlermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(event_scientist_boss, "event_scientist_boss")
