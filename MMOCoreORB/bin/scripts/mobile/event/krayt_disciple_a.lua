krayt_disciple_a = Creature:new {
	customName = "Baxh Rah (Tusken Desciple of the Dark Side)",
	socialGroup = "tusken_raider",
	faction = "tusken_raider",
	level = 500,
	mobType = MOB_NPC,
	chanceHit = 300,
	damageMin = 495,
	damageMax = 1500,
	baseXp = 56845,
	bonusType = "pve_xp",
	bonusXP = 1000,
	baseHAM = 1306000,
	baseHAMmax = 1352000,
	armor = 3,
	resists = {60,30,40,50,60,25,35,70,15},
	meatType = "",
	meatAmount = 0,
	hideType = "",
	hideAmount = 0,
	boneType = "",
	boneAmount = 0,
	milk = 0,
	tamingChance = 0,
	ferocity = 0,
	pvpBitmask = AGGRESSIVE + ATTACKABLE,
	creatureBitmask = PACK + HERD + KILLER,
	optionsBitmask = 128,
	diet = HERBIVORE,

	templates = {"object/mobile/tatooine_npc/hedon_istee.iff"},
	outfit = "tusken_disciple_outfit",	
	scale = 1.2,	
	lootGroups = {
		{
			groups = {
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "vendor_pvp_melee_comps", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "tusk_weap_group", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "krayt_pearls", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
			groups = {
				{group = "krayt_pearls", chance = 10000000},
			},
			lootChance = 7500000,
		},
		{
			groups = {
				{group = "junk", chance = 2500000},
				{group = "tailor_components", chance = 500000},
				{group = "loot_kit_parts", chance = 500000},
				{group = "color_crystals", chance = 500000},
				{group = "power_crystals", chance = 1000000},
				{group = "wearables_all", chance = 1000000},
				{group = "weapons_all", chance = 1000000},
				{group = "armor_all", chance = 1000000},
				{group = "clothing_attachments", chance = 1000000},
				{group = "armor_attachments", chance = 1000000}
			},
			lootChance = 4000000
		},
		{
			groups = {
				{group = "junk", chance = 2500000},
				{group = "tailor_components", chance = 500000},
				{group = "loot_kit_parts", chance = 500000},
				{group = "color_crystals", chance = 500000},
				{group = "power_crystals", chance = 1000000},
				{group = "wearables_all", chance = 1000000},
				{group = "weapons_all", chance = 1000000},
				{group = "armor_all", chance = 1000000},
				{group = "clothing_attachments", chance = 1000000},
				{group = "armor_attachments", chance = 1000000}
			},
			lootChance = 4000000
		}
	},

	-- Primary and secondary weapon should be different types (rifle/carbine, carbine/pistol, rifle/unarmed, etc)
	-- Unarmed should be put on secondary unless the mobile doesn't use weapons, in which case "unarmed" should be put primary and "none" as secondary
	primaryWeapon = "light_jedi_weapons",
	secondaryWeapon = "none",
	conversationTemplate = "",

	-- primaryAttacks and secondaryAttacks should be separate skill groups specific to the weapon type listed in primaryWeapon and secondaryWeapon
	-- Use merge() to merge groups in creatureskills.lua together. If a weapon is set to "none", set the attacks variable to empty brackets
	primaryAttacks = merge(lightsabermaster,forcepowermaster),
	secondaryAttacks = { }
}

CreatureTemplates:addCreatureTemplate(krayt_disciple_a, "krayt_disciple_a")
