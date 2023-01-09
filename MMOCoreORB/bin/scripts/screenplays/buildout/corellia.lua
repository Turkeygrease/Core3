corelliaGlobalBuildoutScreenPlay = ScreenPlay:new {
	numberOfActs = 1,

	screenplayName = "corelliaGlobalBuildoutScreenPlay"
}

registerScreenPlay("corelliaGlobalBuildoutScreenPlay", true)

function corelliaGlobalBuildoutScreenPlay:start()
	if (isZoneEnabled("corellia")) then
		self:spawnSceneObjects()
	end
end

function corelliaGlobalBuildoutScreenPlay:spawnSceneObjects()

-- CNET
spawnSceneObject("corellia", "object/static/worldbuilding/sign/thm_sign_starport.iff", -131.298, 28, -4701.37, 0, 0.997564, 0, 0.0697565, 0)
spawnSceneObject("corellia", "object/static/worldbuilding/sign/thm_sign_bank.iff", -68.2116, 28, -4630.28, 0, 0.707107, 0, -0.707107, 0)
spawnSceneObject("corellia", "object/static/worldbuilding/sign/thm_sign_shuttleport.iff", -10.5892, 28, -4409.25, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/static/worldbuilding/sign/thm_sign_medcenter.iff", -89.8739, 28, -4410.14, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/static/worldbuilding/sign/thm_sign_medcenter.iff", -90.033, 28, -4470.11, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/static/worldbuilding/sign/thm_sign_cantina.iff", -358.936, 29, -4536.22, 0, 0.707107, 0, -0.707107, 0)
spawnSceneObject("corellia", "object/static/worldbuilding/sign/thm_sign_cloning.iff", -478.871, 28, -4478.02, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/static/worldbuilding/sign/thm_sign_shuttleport.iff", -316.415, 31.5996, -4634.77, 0, 0.707107, 0, -0.707107, 0)
spawnSceneObject("corellia", "object/static/worldbuilding/sign/thm_sign_garage.iff", -241.777, 28, -4804.27, 0, 0.707107, 0, 0.707107, 0)
spawnSceneObject("corellia", "object/static/structure/military/military_column_strong_imperial_style_01.iff", -157.917, 28, -4841.94, 0, -4.37114e-08, 0, 1, 0)
spawnSceneObject("corellia", "object/static/structure/military/military_column_strong_imperial_style_01.iff", -167.83, 28, -4842.1, 0, -4.37114e-08, 0, 1, 0)
spawnSceneObject("corellia", "object/static/structure/military/military_column_strong_imperial_style_01.iff", -181.922, 28, -4841.83, 0, -4.37114e-08, 0, 1, 0)
spawnSceneObject("corellia", "object/static/structure/military/military_column_strong_imperial_style_01.iff", -189.991, 28, -4842, 0, -4.37114e-08, 0, 1, 0)
spawnSceneObject("corellia", "object/building/military/military_base_gate_house_imperial.iff", -176.016, 28, -4784.73, 0, -1.49012e-07, 0, 1, 0)
spawnSceneObject("corellia", "object/building/military/military_base_gate_house_imperial.iff", -15.2511, 28, -4731.98, 0, 0.707107, 0, -0.707107, 0)
spawnSceneObject("corellia", "object/static/structure/corellia/corl_stair_medium_s01.iff", -199.588, 28, -4708.27, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/static/structure/corellia/corl_stair_medium_s01.iff", -199.698, 27.9, -4745.2, 0, -1.49012e-07, 0, 1, 0)
spawnSceneObject("corellia", "object/static/structure/corellia/corl_imprv_bridge_insert_s01.iff", -199.745, 35.3, -4732.93, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/static/structure/corellia/corl_imprv_bridge_insert_s01.iff", -199.712, 35.3, -4720.8, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/static/structure/corellia/corl_imprv_bridge_lg_s02.iff", -199.739, 36, -4726.85, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/static/structure/military/military_column_strong_imperial_style_01.iff", -141.903, 28, -4777.83, 0, -4.37114e-08, 0, 1, 0)
spawnSceneObject("corellia", "object/static/structure/military/military_column_strong_imperial_style_01.iff", -157.957, 28, -4786.05, 0, -4.37114e-08, 0, 1, 0)
spawnSceneObject("corellia", "object/static/structure/military/military_column_strong_imperial_style_01.iff", -194.058, 28, -4785.86, 0, -4.37114e-08, 0, 1, 0)
spawnSceneObject("corellia", "object/static/structure/military/military_column_strong_imperial_style_01.iff", -205.997, 28, -4778.06, 0, -4.37114e-08, 0, 1, 0)
spawnSceneObject("corellia", "object/static/vehicle/static_lambda_shuttle.iff", -135.304, 28, -4858.68, 0, -0.382684, 0, 0.923879, 0)

-- Halloween
--[[spawnSceneObject("corellia", "object/tangible/event_perk/halloween_sith_o_lantern_01.iff", -130.397, 28.4473, -4726.53, 0, -0.382684, 0, -0.92388, 0)
spawnSceneObject("corellia", "object/tangible/event_perk/halloween_sith_o_lantern_03.iff", -129.51, 28.4473, -4720.58, 0, 0.766044, 0, 0.642788, 0)
spawnSceneObject("corellia", "object/static/particle/pt_halloween_ghost_fog.iff", -168.327, 28, -4738.57, 0, 0.92388, 0, 0.382683, 0)
spawnSceneObject("corellia", "object/static/particle/pt_halloween_ghost_fog.iff", -157.639, 28, -4713.96, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/static/particle/pt_halloween_ghost_fog.iff", -147.969, 28, -4723.41, 0, 1, 0, 0, 0)
spawnSceneObject("corellia", "object/tangible/storyteller/prop/pr_scarecrow_01.iff", -165.62, 28, -4724.34, 0, 0.642788, 0, 0.766044, 0)
spawnSceneObject("corellia", "object/static/particle/pt_lair_evil_fire_large_red.iff", -165.62, 28, -4724.34, 0, 0.642788, 0, 0.766044, 0)
]]
end
