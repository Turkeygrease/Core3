krayt_disciple_c = Creature:new {
	objectName = "",
	customName = "Jehp Tsiada (Tusken Desciple of the Dark Side)",
	socialGroup = "tusken_raider",
	faction = "tusken_raider",
	level = 500,
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
	        	groups =
			{
				{group = "holocron_light", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        	groups =
			{
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        	groups =
			{
				{group = "clothing_attachments", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        	groups =
			{
				{group = "vendor_pvp_cm_comps", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        	groups =
			{
				{group = "grenades_looted", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        	groups =
			{
				{group = "krayt_pearls", chance = 10000000},
			},
			lootChance = 9500000,
		},
		{
	        	groups =
			{
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
	weapons = {"light_jedi_weapons"},
	conversationTemplate = "",
	attacks = merge(lightsabermaster,forcepowermaster)
}

CreatureTemplates:addCreatureTemplate(krayt_disciple_c, "krayt_disciple_c")
