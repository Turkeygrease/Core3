modern_deco_box_group = {
	description = "Modern Deco Furniture",
	minimumLevel = 0,
	maximumLevel = 0,
	lootItems = {
		{groupTemplate = "modern_furniture_group", weight = 9000000}, -- Very Common 90%
		{groupTemplate = "counter_group", weight = 600000}, -- Rare 6%
		{itemTemplate = "loot_rug_rnd_sml_s01", weight = 300000}, -- Very Rare 3%
		{itemTemplate = "loot_rug_rect_sml_s01", weight = 100000}, -- Scarce 1%
	}
}
addLootGroupTemplate("modern_deco_box_group", modern_deco_box_group)
