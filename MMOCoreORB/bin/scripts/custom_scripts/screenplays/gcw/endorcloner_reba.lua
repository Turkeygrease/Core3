local ObjectManager = require("managers.object.object_manager")

endorcloner_reba = ScreenPlay:new {
	numberOfActs = 1,
  	questString = "endorcloner_reba",
  	states = {onleave = 1, overt = 2},
  	questdata = Object:new {
    	activePlayerName = "initial",
    	}
}
  
registerScreenPlay("endorcloner_reba", true)
  
function endorcloner_reba:start()
    	self:spawnActiveAreas()
	
end


  
function endorcloner_reba:spawnActiveAreas()
	local pSpawnArea = spawnSceneObject("endor", "object/active_area.iff", -3629, 200, 5272, 0, 0, 0, 0, 0)
    
	if (pSpawnArea ~= nil) then
		local activeArea = LuaActiveArea(pSpawnArea)
	        activeArea:setCellObjectID(0)
	        activeArea:setRadius(50)
	        createObserver(ENTEREDAREA, "endorcloner_reba", "notifySpawnArea", pSpawnArea)
	        createObserver(EXITEDAREA, "endorcloner_reba", "notifySpawnAreaLeave", pSpawnArea)
	    end
end
 
--checks if player enters the zone, and what to do with them.
function endorcloner_reba:notifySpawnArea(pActiveArea, pMovingObject)
	
	if (not SceneObject(pMovingObject):isCreatureObject()) then
		return 0
	end
	
	return ObjectManager.withCreatureObject(pMovingObject, function(player)
		if (player:isAiAgent()) then
			return 0
		end
		
		if (player:isImperial()) then
			player:sendSystemMessage("You can not enter this area while in combat")
			player:teleport(-3103, 200, 5277, 0)
	
		end
		return 0
	end)
end
--Simply sends a system message
function endorcloner_reba:notifySpawnAreaLeave(pActiveArea, pMovingObject)
	
	if (not SceneObject(pMovingObject):isCreatureObject()) then
		return 0
	end
	
	return ObjectManager.withCreatureObject(pMovingObject, function(player)
		if (player:isAiAgent()) then
			return 0
		end
		
		if (player:isImperial()) then
			player:sendSystemMessage("You are not the correct faction to enter this area")
		end
		return 0
	end)
end
