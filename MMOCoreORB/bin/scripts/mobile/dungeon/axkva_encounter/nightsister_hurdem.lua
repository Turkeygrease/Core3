nightsister_hurdem = Creature:new {
	objectName = "@mob/creature_names:nightsister_ranger",
	customName = "Hur'dem Cin",
	socialGroup = "nightsister",
	faction = "nightsister",
	level = 300,
	mobType = MOB_NPC,
	chanceHit = 200,
	damageMin = 1555,
	damageMax = 2820,
	baseXp = 7761,
	baseHAM = 15000,
	baseHAMmax = 16000,
	armor = 1,
	resists = {95,95,95,95,-1,95,95,95,95}, --kinetic,energy,blast,heat,cold,electric,acid,stun,ls
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	aggroRadius = 80,
	pvpBitmask = AGGRESSIVE + ATTACKABLE + ENEMY,
	creatureBitmask = PACK + KILLER + STALKER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,

	templates = {"object/mobile/dressed_dathomir_nightsister_ranger.iff"},
	lootGroups = {},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "mixed_force_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(fencermid,swordsmanmid,tkamid,pikemanmid,brawlermaster,forcewielder),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(nightsister_hurdem, "nightsister_hurdem")
