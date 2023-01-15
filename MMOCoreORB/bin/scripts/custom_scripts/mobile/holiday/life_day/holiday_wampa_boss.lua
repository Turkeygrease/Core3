holiday_wampa_boss = Creature:new {
	customName = "The Abominabital Snowman",
	socialGroup = "rancor",
	pvpFaction = "",
	faction = "",
	mobType = MOB_HERBIVORE,
	level = 500,
	chanceHit = 300,
	damageMin = 345,
	damageMax = 1450,
	baseXp = 296845,
	bonusType = "holiday_xp",
	bonusXP = 100,
	baseHAM = 691000,
	baseHAMmax = 692000,
	armor = 2,
	resists = {20,30,40,50,40,25,35,40,-1},
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
	creatureBitmask = KILLER + STALKER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/wampa.iff"},
	scale = 1.0,	
	lootGroups = {
		{
	        groups = {
				{group = "tusken_dot_group", chance = 10000000},
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
				{group = "lootcollectiontierheroics", chance = 3000000},
				{group = "lootcollectiontierdiamonds", chance = 7000000},
			},
			lootChance = 5000000,
		},
		{
			groups = {
				{group = "bw_tooth", chance = 10000000},
			},
			lootChance = 9900000,
		},
		{
	        groups = {
				{group = "vendor_pvp_ranged_comps", chance = 4000000},
				{group = "vendor_pvp_cm_comps", chance = 6000000},
			},
			lootChance = 4000000,
		}
				
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

CreatureTemplates:addCreatureTemplate(holiday_wampa_boss, "holiday_wampa_boss")
