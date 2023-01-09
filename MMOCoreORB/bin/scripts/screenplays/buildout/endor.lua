endorGlobalBuildoutScreenPlay = ScreenPlay:new {
	numberOfActs = 1,

	screenplayName = "endorGlobalBuildoutScreenPlay"
}

registerScreenPlay("endorGlobalBuildoutScreenPlay", true)

function endorGlobalBuildoutScreenPlay:start()
	if (isZoneEnabled("endor")) then
		self:spawnSceneObjects()
	end
end

function endorGlobalBuildoutScreenPlay:spawnSceneObjects()

-- PvP City Center
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_wall_4x16_s02.iff", -3307.27, 200, 5160.24, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_arch_lg_s02.iff", -3307.37, 200, 5173.96, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_arch_sm_s02.iff", -3307.39, 200, 5183.89, 0, 0.707107, 0, -0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_arch_lg_s02.iff", -3307.39, 200, 5193.72, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_arch_lg_s02.iff", -3307.39, 200, 5193.72, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_wall_4x16_s02.iff", -3307.31, 200, 5207.74, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_wall_4x16_s02.iff", -3363.93, 200, 5207.78, 0, 0.707107, 0, -0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_arch_lg_s02.iff", -3363.9, 200, 5193.76, 0, 0.707107, 0, -0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_arch_sm_s02.iff", -3363.89, 200, 5184.12, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_arch_lg_s02.iff", -3363.91, 200, 5174.15, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_wall_4x16_s02.iff", -3363.84, 200, 5160.13, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_column_s01.iff", -3336.82, 200, 5183.67, 0, 1, 0, 0, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_column_s01.iff", -3349.1, 200, 5199.11, 0, 1, 0, 0, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_column_s01.iff", -3325.49, 200, 5199.06, 0, 1, 0, 0, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_column_s01.iff", -3325.95, 200, 5169.31, 0, 1, 0, 0, 0)
spawnSceneObject("endor", "object/static/structure/corellia/corl_imprv_column_s01.iff", -3348.44, 200, 5169.36, 0, 1, 0, 0, 0)

end
