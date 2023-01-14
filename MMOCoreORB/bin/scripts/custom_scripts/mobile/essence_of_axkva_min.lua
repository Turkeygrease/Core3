essence_of_axkva_min = Creature:new {
	objectName = "@mob/creature_names:axkva_min",
	customName = "Essence of Axkva Min",
	socialGroup = "nightsister",
	faction = "nightsister",
	mobType = MOB_NPC,
	level = 500,
	chanceHit = 300,
	damageMin = 1800,
	damageMax = 2800,
	baseHAM = 2000000,
	baseHAMmax = 2000000,
	armor = 3,
	resists = {99,99,99,99,99,99,99,99,99},
	aggroRadius = 1,
	pvpBitmask = NONE,
	creatureBitmask = PACK,
	optionsBitmask = AIENABLED,

	templates = {"object/mobile/dressed_dathomir_nightsister_axkva.iff"},
	scale = 1.6,
	lootGroups = {
		{
			groups = {
				{group = "nightsister_common", chance = 5000000},
				{group = "power_crystals", chance = 5000000}
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "axkva_min", chance = 10000000},
			},
			lootChance = 9000000
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

CreatureTemplates:addCreatureTemplate(essence_of_axkva_min, "essence_of_axkva_min")
