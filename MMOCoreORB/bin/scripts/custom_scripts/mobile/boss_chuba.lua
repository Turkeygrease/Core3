boss_chuba = Creature:new {
	customName = "Abuhca",
	socialGroup = "chuba",
	faction = "",
	mobType = MOB_HERBIVORE,
	level = 80,
	chanceHit = 0.55,
	damageMin = 90,
	damageMax = 250,
	baseXp = 185,
	bonusType = "pve_xp",
	bonusXP = 20,
	baseHAM = 20000,
	baseHAMmax = 30000,
	armor = 2,
	resists = {10,20,5,0,10,40,30,10,30},
	meatType = "meat_herbivore",
	meatAmount = 17,
	hideType = "hide_leathery",
	hideAmount = 11,
	boneType = "bone_mammal",
	boneAmount = 23,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/chuba_hue.iff"},
	controlDeviceTemplate = "object/intangible/pet/chuba_hue.iff",
	lootGroups = {},
	conversationTemplate = "",
	scale = 3,

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "object/weapon/ranged/creature/creature_spit_small_yellow.iff",
	secondaryWeapon = "unarmed",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = { {"posturedownattack",""}, {"mildpoison",""}, {"blindattack",""}, {"stunattack",""} },
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(boss_chuba, "boss_chuba")
