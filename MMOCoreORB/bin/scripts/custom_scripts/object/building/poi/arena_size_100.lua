object_building_poi_arena_size_100 = object_building_poi_shared_arena_size_100:new {
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
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = -52, z = 0, y = 16, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},
		--Bottom Wall
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = -52, z = 0, y = -16, ox = 0, oy = 1, oz = 0, ow = 0, cellid = -1, containmentType = -1},
		--Left Wall
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = -68, z = 0, y = 0, ox = 0, oy = 0.7, oz = 0, ow = -0.7, cellid = -1, containmentType = -1},

	--Right Pen (BLUE)
		--Top Wall
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = 52, z = 0, y = 16, ox = 0, oy = 0, oz = 0, ow = 1, cellid = -1, containmentType = -1},
		--Bottom Wall
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = 52, z = 0, y = -16, ox = 0, oy = 1, oz = 0, ow = 0, cellid = -1, containmentType = -1},
		--Left Wall
		{templateFile = "object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", x = 68, z = 0, y = 0, ox = 0, oy = 0.7, oz = 0, ow = 0.7, cellid = -1, containmentType = -1},

	},
}

ObjectTemplates:addTemplate(object_building_poi_arena_size_100, "object/building/poi/arena_size_100.iff")
