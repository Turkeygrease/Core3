event_scientist = Creature:new {
	customName = "Facility Scientist",
	randomNameTag = true,
	socialGroup = "nightsister",
	pvpFaction = "nightsister",
	faction = "nightsister",
	mobType = MOB_NPC,
	level = 200,
	chanceHit = 0.8,
	damageMin = 396,
	damageMax = 916,
	baseXp = 3465,
	baseHAM = 131700,
	baseHAMmax = 133000,
	armor = 2,
	resists = {52,25,25,65,65,65,65,44,33},
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
	optionsBitmask = 128,
	diet = HERBIVORE,
	templates = { "object/mobile/dressed_combatmedic_trainer_human_male_01.iff", 
			"object/mobile/dressed_brigade_captain_human_male_01.iff",
			"object/mobile/dressed_hutt_medic2_twilek_male_01.iff",
			"object/mobile/dressed_combatmedic_trainer_human_female_01.iff",
			"object/mobile/dressed_doctor_trainer_moncal_male_01.iff",
			"object/mobile/dressed_combatmedic_trainer_rodian_male_01.iff",
			"object/mobile/dressed_mercenary_medic_rodian_female_01.iff"},
	lootGroups = {
		{
			groups = {
				{group = "color_crystals", chance = 150000},
				{group = "junk", chance = 7300000},
				{group = "rifles", chance = 600000},
				{group = "holocron_dark", chance = 150000},
				{group = "holocron_light", chance = 150000},
				{group = "carbines", chance = 600000},
				{group = "pistols", chance = 600000},
				{group = "clothing_attachments", chance = 200000},
				{group = "armor_attachments", chance = 250000}
			},
			lootChance = 3900000
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "unarmed_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(brawlermaster,tkamaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(event_scientist, "event_scientist")
