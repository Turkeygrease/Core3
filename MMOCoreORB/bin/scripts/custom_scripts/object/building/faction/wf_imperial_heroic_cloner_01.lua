object_building_military_wf_imperial_heroic_cloner_01 = object_building_military_shared_military_base_shed_rebel_style_01:new {
	planetMapCategory = "cloningfacility",
	faction = "imperial",
	customName = "Imperial Cloning Facility",
	zoneComponent = "StructureZoneComponent",
	templateType = CLONINGBUILDING,
	facilityType = CLONER_FACTION_IMPERIAL,
	alwaysPublic = 1,

	skillMods = {
		{"private_buff_mind", 100},
		{"private_medical_rating", 100},
		{"private_med_wound_health", 100},
		{"private_med_wound_action", 100},
		{"private_med_battle_fatigue", 5},
	},

	spawningPoints = {
		{ x = -3.4, z = 0.1, y = -4.8, ow = -0.70527, ox = 0, oz = 0, oy = 0.708939, cellid = 6 },
		{ x = -3.5, z = 0.1, y = -3.1, ow = -0.70527, ox = 0, oz = 0, oy = 0.708939, cellid = 6 },
		{ x = -3.5, z = 0.1, y = -1.2, ow = -0.70527, ox = 0, oz = 0, oy = 0.708939, cellid = 6 }
	},

	childObjects = {
		{templateFile = "object/tangible/terminal/terminal_insurance.iff", x = -6.2, z = -0.05, y = 3, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = 2, containmentType = -1},
	},

	childCreatureObjects = {
		{ mobile = "imperial_recruiter", x = -0.1, z = 0.1, y = 2.0, cellid = 3, containmentType = -1, respawn = 60, heading = 3.14},
	},
}

ObjectTemplates:addTemplate(object_building_military_wf_imperial_heroic_cloner_01, "object/building/military/wf_imperial_heroic_cloner_01.iff")
