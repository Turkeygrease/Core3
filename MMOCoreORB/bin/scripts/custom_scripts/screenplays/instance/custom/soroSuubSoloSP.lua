soroSuubSoloSP = ScreenPlay:new{
	deco = {
		{
			{"object/static/vehicle/static_tie_fighter.iff", 50, 4.7, 35, 180},
			{"object/static/vehicle/static_sandcrawler.iff", -55, 0, 35, 90},
		},
		{
			{"object/static/space/spacestation/mining_outpost_01.iff", -92.1, -17, -73, 90},
		},
		{
			{"object/static/space/spacestation/mining_outpost_01.iff", 99, -17, 70, 0},
		},
	},
}
registerScreenPlay("soroSuubSoloSP", false)

function soroSuubSoloSP:start(pControl, dataStr)
	soroSuubSoloSP:spawnObjects(pControl, dataStr)
end

function soroSuubSoloSP:spawnObjects(pControl, dataStr)
	--print("spawing objects",pControl)
	local ctrl = SceneObject(pControl)
	local zone = ctrl:getZoneName()
	local x = ctrl:getWorldPositionX()
	local z = ctrl:getWorldPositionZ()
	local y = ctrl:getWorldPositionY()
	local idStr = readStringData(dataStr..":deco") --read deco string
	local deco = soroSuubSoloSP.deco[math.random(#soroSuubSoloSP.deco)]

	for k,v in ipairs(deco) do
		local pOB = spawnSceneObject(zone, v[1], x+v[2], z+v[3], y+v[4], 0, math.rad(v[5]))
		idStr = idStr.."/"..tostring(SceneObject(pOB):getObjectID())
	end

	writeStringData(dataStr..":deco", idStr) --store layout-objects in instance string deco
end
