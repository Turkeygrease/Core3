counter_group = {
	description = 'Loot Group Description',
	minimumLevel = 0,
	maximumLevel = 0,
	lootItems = {
		{ itemTemplate = 'loot_bar_piece_straight_01', weight = 2500000}, --25%
		{ itemTemplate = 'loot_bar_piece_straight_02', weight = 2500000}, --25%
		{ itemTemplate = 'loot_bar_piece_curve_01', weight = 2000000}, --20%
		{ itemTemplate = 'loot_bar_piece_curve_02', weight = 2000000}, --20%
		{ itemTemplate = 'loot_bar_counter_01', weight = 1000000}, --10%
	}
}
addLootGroupTemplate('counter_group', counter_group)
