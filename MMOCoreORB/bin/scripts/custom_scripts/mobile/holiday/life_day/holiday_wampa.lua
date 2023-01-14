holiday_wampa = Creature:new {
	objectName = "@mob/creature_names:bull_rancor",
	customName = "a Wampa",	
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	mobType = MOB_CARNIVORE,
	level = 65,
	chanceHit = 30,
	damageMin = 815,
	damageMax = 1230,
	baseXp = 28549,
	baseHAM = 104500,
	baseHAMmax = 105100,
	armor = 3,
	resists = {25,35,15,55,35,15,100,10,0},
	meatType = "meat_carnivore",
	meatAmount = 1000,
	hideType = "hide_leathery",
	hideAmount = 900,
	boneType = "bone_mammal",
	boneAmount = 850,
	milk = 0,
	tamingChance = 0.01,
	ferocity = 11,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/wampa.iff"},
	controlDeviceTemplate = "object/intangible/pet/rancor_hue.iff",	
	scale = 0.50,
	lootGroups = {
		{
			groups = {
				{group = "grenades_looted", chance = 850000},
				{group = "pistols", chance = 750000},
				{group = "heavy_weapons", chance = 500000},
				{group = "rifles", chance = 750000},
				{group = "carbines", chance = 500000},
				{group = "grenades_looted", chance = 1650000},
				{group = "armor_all", chance = 1000000},
				{group = "melee_unarmed", chance = 1000000},
				{group = "wearables_common", chance = 1500000},
				{group = "wearables_uncommon", chance = 1500000}
			},
			lootChance = 10000000
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"stunattack","stunChance=50"}, {"knockdownattack","knockdownChance=50"} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(holiday_wampa, "holiday_wampa")
