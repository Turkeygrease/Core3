world_s_rare_c = Creature:new {
	customName = "Infected Kkorrwrot",
	socialGroup = "geonosian_creature",
	pvpFaction = "",
	faction = "",
	mobType = MOB_CARNIVORE,
	level = 500,
	chanceHit = 45.5,
	damageMin = 1500,
	damageMax = 2500,
	baseXp = 79336,
	bonusType = "pve_xp",
	bonusXP = 800,
	baseHAM = 1150000,
	baseHAMmax = 1200000,
	armor = 3,
	resists = {55,60,45,70,70,70,45,45,-1},
	meatType = "meat_carnivore",
	meatAmount = 2000,
	hideType = "hide_leathery",
	hideAmount = 2000,
	boneType = "bone_mammal",
	boneAmount = 2000,
	milk = 0,
	tamingChance = 0,
	ferocity = 15,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = 128,
	diet = CARNIVORE,

	templates = {"object/mobile/infected_kkorrwrot.iff"},
	scale = 1.5,
	lootGroups = {
		{
	        groups = {
				{group = "elite_mastery_jewelry", chance = 10000000},
			},
			lootChance = 5000000,
		},
		{
	        groups = {
				{group = "armor_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
	        groups = {
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
			groups = {
				{group = "crovaxloot_group", chance =  10000000}
			},
			lootChance = 8000000
		},
		{
	        groups = {
				{group = "dw_tissue", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "kkorrwrot_boss", chance = 10000000},
			},
			lootChance = 2500000,
		},
		{
			groups = {
				{group = "heavy_weapons", chance = 4500000},
				{group = "grenades_looted", chance = 5500000},
			},
			lootChance = 7500000,
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

CreatureTemplates:addCreatureTemplate(world_s_rare_c, "world_s_rare_c")
