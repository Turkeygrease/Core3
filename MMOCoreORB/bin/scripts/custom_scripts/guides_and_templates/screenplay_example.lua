screenplay_example = ScreenPlay:new{}
registerScreenPlay("screenplay_example", false) --set this value to true and restart the server to test this script

function screenplay_example:start()
	print("\n\n Starting Example Screenplay \n\n")
	self:spawnMobiles()
	self:spawnSceneObjects()
end

function screenplay_example:spawnMobiles()
	--spawnMobile(zoneName, templateString, respawnTimer, x, z, y, facingDirection, cellID)
	spawnMobile("tatooine", "imperial_probe_drone", 300, 3528, 5, -4801, 45, 0)
end

function screenplay_example:spawnSceneObjects()
	--spawnSceneObject(zoneName, iffString, x, z, y, cellID, math.rad(facingDirection))
	spawnSceneObject("tatooine", "object/static/structure/general/droid_probedroid_powerdown.iff", 3529, 5, -4801, 0, math.rad(90))

	--spawnSceneObject(zoneName, iffString, x, z, y, cellID, dw, dx, dy, dz)
	spawnSceneObject("tatooine", "object/static/structure/general/droid_probedroid_powerdown.iff", 3531, 5, -4801, 0, 0, 0, 0, 0)
end
