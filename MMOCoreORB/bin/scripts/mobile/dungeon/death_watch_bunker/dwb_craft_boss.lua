dwb_craft_boss = Creature:new {
	customName = "Death Watch Asset Protector",
	socialGroup = "death_watch",
	pvpFaction = "death_watch",
	faction = "",
	mobType = MOB_NPC,
	level = 420,
	chanceHit = 23.5,
	damageMin = 1395,
	damageMax = 2300,
	baseXp = 24081,
	bonusType = "pve_xp",
	bonusXP = 500,
	baseHAM = 1001000,
	baseHAMmax = 1020000,
	armor = 2,
	resists = {40,40,20,40,50,40,50,40,35},
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
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.15,

	templates = {"object/mobile/dressed_death_watch_gold.iff"},
	lootGroups = {
		{
			groups = {
				{group = "mando_loot", chance =  10000000}
			},
			lootChance = 10000000
		},
		{
			groups = {
				{group = "mando_loot", chance =  10000000}
			},
			lootChance = 500000
		},
		{
			groups = {
				{group = "armor_attachments", chance =  10000000}
			},
			lootChance = 10000000
		},
		{
			groups = {
				{group = "power_crystals", chance  = 10000000}
			},
			lootChance = 6000000
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "dark_trooper_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(riflemanmaster,fencermaster,marksmanmaster,brawlermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(dwb_craft_boss, "dwb_craft_boss")
