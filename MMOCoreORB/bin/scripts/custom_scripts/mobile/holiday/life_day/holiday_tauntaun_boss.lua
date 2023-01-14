holiday_tauntaun_boss = Creature:new {
	customName = "The Abominabital Tauntaun",
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	level = 500,
	mobType = MOB_HERBIVORE,
	chanceHit = 300,
	damageMin = 345,
	damageMax = 1450,
	baseXp = 296845,
	bonusType = "holiday_xp",
	bonusXP = 100,
	baseHAM = 491000,
	baseHAMmax = 492000,
	armor = 2,
	resists = {20,30,40,50,40,25,35,40,-1},
	meatType = "meat_carnivore",
	meatAmount = 2000,
	hideType = "hide_leathery",
	hideAmount = 2000,
	boneType = "bone_mammal",
	boneAmount = 2000,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/tauntaun_hue.iff"},
	scale = 3.5,	
	lootGroups = {
		{
	        groups = {
				{group = "crovaxloot_group", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        groups = {
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
			groups = {
				{group = "kkorrwrot_boss", chance = 10000000},
			},
			lootChance = 7500000
		},
		{
	        groups = {
				{group = "corvette_boss", chance = 10000000},
			},
			lootChance = 9500000,
		},
				
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"creatureareapoison"}, {"creatureareaknockdown","knockdownChance=90"} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(holiday_tauntaun_boss, "holiday_tauntaun_boss")
