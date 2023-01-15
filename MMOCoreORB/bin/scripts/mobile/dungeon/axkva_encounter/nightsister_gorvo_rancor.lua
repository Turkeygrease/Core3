nightsister_gorvo_rancor = Creature:new {
	customName = "Gorvo",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 300,
	mobType = MOB_CARNIVORE,
	chanceHit = 55.5,
	damageMin = 900,
	damageMax = 1600,
	baseXp = 79336,
	baseHAM = 550000,
	baseHAMmax = 600000,
	armor = 3,
	resists = {55,60,45,70,70,70,45,45,25},
	meatType = "meat_carnivore",
	meatAmount = 800,
	hideType = "hide_leathery",
	hideAmount = 850,
	boneType = "bone_mammal",
	boneAmount = 799,
	milk = 0,
	tamingChance = 0,
	ferocity = 15,
	aggroRadius = 15,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/beast_master/bm_mutated_rancor.iff"},
	scale = 1,
	lootGroups = {
		{
	        groups = {
				{group = "elite_mastery_jewelry", chance = 10000000},
			},
			lootChance = 8500000,
		},
		{
	        groups = {
				{group = "ns_rancor_tissue", chance = 10000000},
			},
			lootChance = 9900000,
		},
		{
	        groups = {
				{group = "bw_tooth", chance = 10000000},
			},
			lootChance = 4900000,
		},
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"creatureareattack",""}, {"stunattack","stunChance=70"}, {"creatureareableeding",""} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(nightsister_gorvo_rancor, "nightsister_gorvo_rancor")
