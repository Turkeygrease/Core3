lokGlobalBuildoutScreenPlay = ScreenPlay:new {
	numberOfActs = 1,

	screenplayName = "lokGlobalBuildoutScreenPlay"
}

registerScreenPlay("lokGlobalBuildoutScreenPlay", true)

function lokGlobalBuildoutScreenPlay:start()
	if (isZoneEnabled("lok")) then
		self:spawnSceneObjects()
	end
end

function lokGlobalBuildoutScreenPlay:spawnSceneObjects()

--- IG88 Arena Entrance 
spawnSceneObject("lok", "object/static/structure/general/lucky_despot_debris_aft_hull.iff", -7692.78, 91.9733, 3464.06, 0, 1, 0, 0, 0)
spawnSceneObject("lok", "object/static/structure/tatooine/wall_archway_tatooine_large_style_01.iff", -7673.97, 91.0186, 3507.71, 0, 1, 0, 0, 0)
spawnSceneObject("lok", "object/static/structure/tatooine/wall_pristine_tatooine_tall_style_01.iff", -7673.94, 90.6621, 3519.45, 0, 1, 0, 0, 0)
spawnSceneObject("lok", "object/static/structure/tatooine/wall_pristine_tatooine_tall_style_01.iff", -7682.43, 90.6642, 3526.94, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("lok", "object/static/structure/tatooine/wall_pristine_tatooine_tall_style_01.iff", -7693.29, 90.6472, 3526.93, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("lok", "object/static/structure/general/lucky_despot_debris_lg_engine_s01.iff", -7710.05, 90.0781, 3520.16, 0, 0.996195, 0, 0.0871557, 0)
spawnSceneObject("lok", "object/static/structure/general/lucky_despot_debris_nose_cone.iff", -7694.41, 92.2378, 3518.54, 0, 0.664463, 0.241845, -0.298836, -0.640856)
spawnSceneObject("lok", "object/tangible/dungeon/death_watch_bunker/invulnerable_debris.iff", -7683.05, 92.0434, 3514.64, 0, 0.92388, 0, 0.382683, 0)
spawnSceneObject("lok", "object/building/kashyyyk/wall_modular_restraining_wall_door.iff", -7674.25, 94.1192, 3509, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("lok", "object/building/kashyyyk/wall_modular_restraining_wall_door.iff", -7674.25, 91.1486, 3509.01, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("lok", "object/building/kashyyyk/wall_modular_restraining_wall_door.iff", -7674.25, 94.1199, 3507.68, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("lok", "object/building/kashyyyk/wall_modular_restraining_wall_door.iff", -7674.25, 91.15, 3507.68, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("lok", "object/building/kashyyyk/wall_modular_restraining_wall_door.iff", -7674.25, 94.12, 3506.35, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("lok", "object/building/kashyyyk/wall_modular_restraining_wall_door.iff", -7674.25, 91.1499, 3506.34, 0, 0.707107, 0, 0.707107, 0)

end
