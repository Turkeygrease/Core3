object_building_poi_arena4v4_01 = object_building_poi_shared_arena_size_100:new {
	customName = "Arena100 Template",
	zoneComponent = "StructureZoneComponent",
	childObjects = {
	--Top Wall
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_style_01.iff", x = 0, z = 0, y = 36, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = -20, z = 0, y = 36, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = 20, z = 0, y = 36, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},

	--Bottom Wall
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_style_01.iff", x = 0, z = 0, y = -36, ox = 0, oy = 1, oz = 0, ow = 0, cellid = -1, containmentType = -1},
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = -20, z = 0, y = -36, ox = 0, oy = 1, oz = 0, ow = 0, cellid = -1, containmentType = -1},
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = 20, z = 0, y = -36, ox = 0, oy = 1, oz = 0, ow = 0, cellid = -1, containmentType = -1},

	--Left Wall
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = -36, z = 0, y = 20, ox = 0, oy = 0.7, oz = 0, ow = -0.7, cellid = -1, containmentType = -1},
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = -36, z = 0, y = -20, ox = 0, oy = 0.7, oz = 0, ow = -0.7, cellid = -1, containmentType = -1},

	--Right Wall
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = 36, z = 0, y = 20, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = -1, containmentType = -1},
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = 36, z = 0, y = -20, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = -1, containmentType = -1},

	--Left Pen (RED)
		--Top Wall
		{templateFile = "object/static/structure/military/arena_wall_strong_red_32_style_01.iff", x = -52, z = 0, y = 16, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},
		--Bottom Wall
		{templateFile = "object/static/structure/military/arena_wall_strong_red_32_style_01.iff", x = -52, z = 0, y = -16, ox = 0, oy = 1, oz = 0, ow = 0, cellid = -1, containmentType = -1},
		--Left Wall
		{templateFile = "object/static/structure/military/arena_wall_strong_red_32_style_01.iff", x = -68, z = 0, y = 0, ox = 0, oy = 0.7, oz = 0, ow = -0.7, cellid = -1, containmentType = -1},

	--Right Pen (BLUE)
		--Top Wall
		{templateFile = "object/static/structure/military/arena_wall_strong_blue_32_style_01.iff", x = 52, z = 0, y = 16, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},
		--Bottom Wall
		{templateFile = "object/static/structure/military/arena_wall_strong_blue_32_style_01.iff", x = 52, z = 0, y = -16, ox = 0, oy = 1, oz = 0, ow = 0, cellid = -1, containmentType = -1},
		--Left Wall
		{templateFile = "object/static/structure/military/arena_wall_strong_blue_32_style_01.iff", x = 68, z = 0, y = 0, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = -1, containmentType = -1},

	--Scoreboard
		--Bilboard
		{templateFile = "object/static/worldbuilding/sign/scoreboard_arena_sign_01.iff", x = 0, z = 0, y = 36, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = -1, containmentType = -1},
		--Blinking Colon
		{templateFile = "object/tangible/furniture/decorative/scoreboard_number_colon_01.iff", x = 0, z = 6.4, y = 36, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},

	--Left Lamps (RED)
		--Left TOP Corner
		{templateFile = "object/tangible/furniture/city/streetlamp_large_red_arena_02.iff", x = -66, z = 0, y = 14, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = -1, containmentType = -1},
		--Left Bottom Corner
		{templateFile = "object/tangible/furniture/city/streetlamp_large_red_arena_02.iff", x = -66, z = 0, y = -14, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = -1, containmentType = -1},

	--Left Entry Lights (RED)
		--Left TOP Corner
		{templateFile = "object/static/particle/pt_light_streetlamp_red.iff", x = -36, z = 5, y = 5.5, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},
		--Left Bottom Corner
		{templateFile = "object/static/particle/pt_light_streetlamp_red.iff", x = -36, z = 5, y = -5.5, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},

	--Left Pen Banner
		--Left Center Wall
		{templateFile = "object/tangible/furniture/decorative/factions_all_logo_red_1.iff", x = -66.6, z = 1.3, y = 0, ox = 0, oy = 0.707, oz = 0.07, ow = 0.707, cellid = -1, containmentType = -1},

	--Right Lamps (BLUE)
		--Right TOP Corner
		{templateFile = "object/tangible/furniture/city/streetlamp_large_royalblue_02.iff", x = 66, z = 0, y = 14, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = -1, containmentType = -1},
		--Right Bottom Corner
		{templateFile = "object/tangible/furniture/city/streetlamp_large_royalblue_02.iff", x = 66, z = 0, y = -14, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = -1, containmentType = -1},

	--Right Entry Lights (Blue)
		--Right TOP Corner
		{templateFile = "object/static/particle/pt_light_streetlamp_blue.iff", x = 36, z = 5, y = 5.5, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},
		--Right Bottom Corner
		{templateFile = "object/static/particle/pt_light_streetlamp_blue.iff", x = 36, z = 5, y = -5.5, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},

	--Right Pen Banner
		--Right Center Wall
		{templateFile = "object/tangible/furniture/decorative/factions_all_logo_blue_1.iff", x = 66.6, z = 1.3, y = 0, ox = 0, oy = 0.707, oz = 0.07, ow = -0.707, cellid = -1, containmentType = -1},
	},
}

ObjectTemplates:addTemplate(object_building_poi_arena4v4_01, "object/building/poi/arena4v4_01.iff")
