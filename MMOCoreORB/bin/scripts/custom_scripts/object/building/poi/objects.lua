--includeFile("../custom_scripts/object/building/poi/file.lua")
includeFile("../custom_scripts/object/building/poi/arenas/objects.lua")

--Arena 100 radius
object_building_poi_shared_arena_size_100 = SharedBuildingObjectTemplate:new {
	clientTemplateFileName = "object/building/poi/base/shared_arena_size_100.iff"
}
ObjectTemplates:addClientTemplate(object_building_poi_shared_arena_size_100, "object/building/poi/shared_arena_size_100.iff")

--Arena 200 radius
object_building_poi_shared_arena_size_200 = SharedBuildingObjectTemplate:new {
	clientTemplateFileName = "object/building/poi/base/shared_arena_size_200.iff"
}
ObjectTemplates:addClientTemplate(object_building_poi_shared_arena_size_200, "object/building/poi/shared_arena_size_200.iff")

--Arena 300 radius
object_building_poi_shared_arena_size_300 = SharedBuildingObjectTemplate:new {
	clientTemplateFileName = "object/building/poi/base/shared_arena_size_300.iff"
}
ObjectTemplates:addClientTemplate(object_building_poi_shared_arena_size_300, "object/building/poi/shared_arena_size_300.iff")

--Arena Gate 01 Blue 8m
object_building_poi_shared_arena_gate_01_blue_8m = SharedStaticObjectTemplate:new {
	clientTemplateFileName = "object/building/poi/shared_arena_gate_01_blue_8m.iff"
}
ObjectTemplates:addClientTemplate(object_building_poi_shared_arena_gate_01_blue_8m, "object/building/poi/shared_arena_gate_01_blue_8m.iff")

--Arena Gate 01 Red 8m
object_building_poi_shared_arena_gate_01_red_8m = SharedStaticObjectTemplate:new {
	clientTemplateFileName = "object/building/poi/shared_arena_gate_01_red_8m.iff"
}
ObjectTemplates:addClientTemplate(object_building_poi_shared_arena_gate_01_red_8m, "object/building/poi/shared_arena_gate_01_red_8m.iff")

--Arena Graveyard
object_building_poi_shared_arena_graveyard = SharedStaticObjectTemplate:new {
	clientTemplateFileName = "object/building/poi/shared_arena_graveyard.iff"
}
ObjectTemplates:addClientTemplate(object_building_poi_shared_arena_graveyard, "object/building/poi/shared_arena_graveyard.iff")
