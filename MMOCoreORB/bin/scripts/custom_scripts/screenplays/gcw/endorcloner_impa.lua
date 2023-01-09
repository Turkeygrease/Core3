local ObjectManager = require("managers.object.object_manager")

endorcloner_impa = ScreenPlay:new {
	numberOfActs = 1,
  	questString = "endorcloner_impa",
  	states = {onleave = 1, overt = 2},
  	questdata = Object:new {
    	activePlayerName = "initial",
    	}
}
  
registerScreenPlay("endorcloner_impa", true)
  
function endorcloner_impa:start()
    	self:spawnActiveAreas()
	
end


  
function endorcloner_impa:spawnActiveAreas()
	local pSpawnArea = spawnSceneObject("endor", "object/active_area.iff", -3103, 200, 5277, 0, 0, 0, 0, 0)
    
	if (pSpawnArea ~= nil) then
		local activeArea = LuaActiveArea(pSpawnArea)
	        activeArea:setCellObjectID(0)
	        activeArea:setRadius(47)
	        createObserver(ENTEREDAREA, "endorcloner_impa", "notifySpawnArea", pSpawnArea)
	        createObserver(EXITEDAREA, "endorcloner_impa", "notifySpawnAreaLeave", pSpawnArea)
	    end
end
 
--checks if player enters the zone, and what to do with them.
function endorcloner_impa:notifySpawnArea(pActiveArea, pMovingObject)
	
	if (not SceneObject(pMovingObject):isCreatureObject()) then
		return 0
	end
	
	return ObjectManager.withCreatureObject(pMovingObject, function(player)
		if (player:isAiAgent()) then
			return 0
		end
		
		if (player:isRebel()) then
			player:sendSystemMessage("You can not enter this area while in combat")
			player:teleport(-3629, 200, 5272, 0)
	
		end
		return 0
	end)
end
--Simply sends a system message
function endorcloner_impa:notifySpawnAreaLeave(pActiveArea, pMovingObject)
	
	if (not SceneObject(pMovingObject):isCreatureObject()) then
		return 0
	end
	
	return ObjectManager.withCreatureObject(pMovingObject, function(player)
		if (player:isAiAgent()) then
			return 0
		end
		
		if (player:isRebel()) then
			player:sendSystemMessage("You are not the correct faction to enter this area")
		end
		return 0
	end)
end
