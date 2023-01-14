endor_rebtrooper = Creature:new {
	objectName = "@mob/creature_names:rebel_trooper",
	randomNameType = NAME_GENERIC,
	randomNameTag = true,
	socialGroup = "rebel",
	faction = "rebel",
	mobType = MOB_NPC,
	level = 25,
	chanceHit = 0.36,
	damageMin = 5,
	damageMax = 25,
	baseXp = 2637,
	baseHAM = 7200,
	baseHAMmax = 8800,
	armor = 0,
	resists = {15,15,40,15,15,15,15,-1,-1},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = ATTACKABLE,
	creatureBitmask = PACK + KILLER,
	optionsBitmask = AIENABLED,
	diet = HERBIVORE,
	scale = 1.05,

	templates = {
		"object/mobile/dressed_rebel_trooper_bith_m_01.iff",
		"object/mobile/dressed_rebel_commando_human_female_01.iff",
		"object/mobile/dressed_rebel_specforce_captain_rodian_female_01.iff",
		"object/mobile/dressed_rebel_army_captain_human_male_01.iff",
		"object/mobile/dressed_rebel_ris_01.iff",
		"object/mobile/dressed_jedi_trainer_chiss_male_01.iff"
	},

	lootGroups = {
		{
			groups = {
				{group = "color_crystals", chance = 100000},
				{group = "junk", chance = 4700000},
				{group = "rifles", chance = 1000000},
				{group = "pistols", chance = 1000000},
				{group = "melee_weapons", chance = 1000000},
				{group = "carbines", chance = 1000000},
				{group = "clothing_attachments", chance = 100000},
				{group = "armor_attachments", chance = 100000},
				{group = "wearables_common", chance = 1000000}
			}
		}
	},

	reactionStf = "@npc_reaction/military",
	personalityStf = "@hireling/hireling_military",

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "rebel_weapons_light",
	secondaryWeapon = "none",
	conversationTemplate = "",
	
	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(brawlermid,marksmanmid),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(endor_rebtrooper, "endor_rebtrooper")
