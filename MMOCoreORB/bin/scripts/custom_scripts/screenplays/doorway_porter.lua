doorway_porter = ScreenPlay:new{
	instanceDoorways = {
		--{zone, x, y, size, instanceString},
			--Note: instanceString is the string table table in script/screenplays/instances.lua (values & tests are set there)

		--{"tatooine", 0, 0, 5, "nova"}, --example tat doorway to nova open instance
		--{"tatooine", 10, 10, 5, "axkvaGroup"}, --example tat doorway to axkva group instance
		--{"tatooine", 20, 20, 5, "life_day_solo"}, --example tat doorway to holiday solo instance
	},
}
registerScreenPlay("doorway_porter", false) --set to true to activate screenplay on server load

function doorway_porter:start() --load in all doorway zones from table and set up observers
	local i = 1
	repeat
		local wp = self.instanceDoorways[i]
		local pSpawnArea = spawnSceneObject(wp[1], "object/active_area.iff", wp[2], WFnav:getZ(wp[1],wp[2],wp[3]), wp[3], 0, 0, 0, 0, 0)
		if (pSpawnArea ~= nil) then
			local activeArea = LuaActiveArea(pSpawnArea)
			activeArea:setCellObjectID(0)
			activeArea:setRadius(wp[4])
			createObserver(ENTEREDAREA, "doorway_porter", "enteredArea", pSpawnArea)
			writeStringData(SceneObject(pSpawnArea):getObjectID().."InstanceType",wp[5])
		end
	i = i + 1
	until i > #self.instanceDoorways
end

function doorway_porter:enteredArea(pSceneObject, pPlayer) --when player enter zone prompt for confirmation
	writeData(SceneObject(pPlayer):getObjectID().."usingObject",SceneObject(pSceneObject):getObjectID())
	local sui = SuiMessageBox.new("doorway_porter","confirmInstanceCallback")
	sui.setTitle("Confirm: [TRAVEL]")
	sui.setPrompt("Do you wish to enter this Instance?")
	sui.sendTo(pPlayer)

	return 0
end

function doorway_porter:confirmInstanceCallback(pPlayer, pSui, eventIndex) --evaluate player confirmation and port or exit accordingly
	if (eventIndex == 1 or pPlayer == nil) then return 0 end

	local pSceneObject = getSceneObject(readData(SceneObject(pPlayer):getObjectID().."usingObject"))
	if (pSceneObject == nil) then return 0 end

	deleteData(SceneObject(pPlayer):getObjectID().."usingObject") --free temp player memory
	WFporter:handleObjectMenuSelect(pSceneObject, pPlayer, 104)

	return 0
end
