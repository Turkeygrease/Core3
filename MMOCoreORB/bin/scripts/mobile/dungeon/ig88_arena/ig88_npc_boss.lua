ig88_npc_boss = Creature:new {
	objectName = "@mob/creature_names:ig_assassin_droid",
	customName = "IG-88",
	socialGroup = "death_watch",
	pvpFaction = "death_watch",
	faction = "",
	level = 500,
	chanceHit = 200,
	damageMin = 800,
	damageMax = 2275,
	baseXp = 12612,
	bonusType = "pve_xp",
	bonusXP = 1500,
	baseHAM = 1896000,
	baseHAMmax = 1900000,
	armor = 3,
	resists = {55,55,40,60,30,35,40,35,15},
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
	creatureBitmask = PACK,
	optionsBitmask = 128,
	diet = HERBIVORE,
	scale = 2.5,

	templates = {"object/mobile/ig_assassin_droid.iff"},
	lootGroups = {
		

		{
	        	groups = 
			{
				{group = "armor_attachments", chance = 10000000},
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
			groups = {
				{group = "tusken_dot_group", chance = 10000000},
			},
			lootChance = 8000000
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
			lootChance = 4500000,
		},
		{
			groups = {
				{group = "ig_boss_loot", chance = 10000000},
			},
			lootChance = 10000000
		},
		{
			groups = {
				{group = "ig_tissue", chance = 10000000},
			},
			lootChance = 10000000
		},
				
	},
	conversationTemplate = "",
	defaultWeapon = "object/weapon/ranged/droid/droid_droideka_ranged.iff",
	defaultAttack = "attack"
}

CreatureTemplates:addCreatureTemplate(ig88_npc_boss, "ig88_npc_boss")
