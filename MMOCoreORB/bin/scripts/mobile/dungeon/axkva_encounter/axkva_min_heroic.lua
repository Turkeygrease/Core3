axkva_min_heroic = Creature:new {
	objectName = "@mob/creature_names:axkva_min",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 500,
	mobType = MOB_NPC,
	chanceHit = 300,
	damageMin = 1100,
	damageMax = 2075,
	baseXp = 12612,
	bonusType = "pve_xp",
	bonusXP = 1700,
	baseHAM = 1596000,
	baseHAMmax = 1600000,
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
	aggroRadius = 15,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + HEALER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_dathomir_nightsister_axkva.iff"},
	scale = 1.6,
	lootGroups = {
		{
			groups = {
				{group = "power_crystals", chance = 10000000},
			},
			lootChance = 9900000,
		},
		{
	        groups = {
				{group = "axkva_motor", chance = 10000000},
			},
			lootChance = 9900000,
		},
		{
	        groups = {
				{group = "axkva_deco", chance = 10000000},
			},
			lootChance = 9900000,
		},
		{
			groups = {
				{group = "axkva_min", chance = 10000000},
			},
			lootChance = 9900000
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "mixed_force_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(fencermaster,swordsmanmaster,tkamaster,pikemanmaster,brawlermaster,forcepowermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(axkva_min_heroic, "axkva_min_heroic")
