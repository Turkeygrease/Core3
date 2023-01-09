local ObjectManager = require("managers.object.object_manager")

endorcloner_impb = ScreenPlay:new {
	numberOfActs = 1,
  	questString = "endorcloner_impb",
  	states = {onleave = 1, overt = 2},
  	questdata = Object:new {
    	activePlayerName = "initial",
    	}
}
  
registerScreenPlay("endorcloner_impb", true)
  
function endorcloner_impb:start()
    	self:spawnActiveAreas()
	
end


  
function endorcloner_impb:spawnActiveAreas()
	local pSpawnArea = spawnSceneObject("endor", "object/active_area.iff", -3138, 200, 5226, 0, 0, 0, 0, 0)
    
	if (pSpawnArea ~= nil) then
		local activeArea = LuaActiveArea(pSpawnArea)
	        activeArea:setCellObjectID(0)
	        activeArea:setRadius(19)
	        createObserver(ENTEREDAREA, "endorcloner_impb", "notifySpawnArea", pSpawnArea)
	        createObserver(EXITEDAREA, "endorcloner_impb", "notifySpawnAreaLeave", pSpawnArea)
	    end
end
 
--checks if player enters the zone, and what to do with them.
function endorcloner_impb:notifySpawnArea(pActiveArea, pMovingObject)
	
	if (not SceneObject(pMovingObject):isCreatureObject()) then
		return 0
	end
	
	return ObjectManager.withCreatureObject(pMovingObject, function(player)
		if (player:isAiAgent()) then
			return 0
		end
		
		if (player:isRebel()) or (player:isInCombat()) then
			player:sendSystemMessage("You can not enter this area while in combat")
			player:teleport(-3162, 200, 5275, 0)
	
		end
		return 0
	end)
end
--Simply sends a system message
function endorcloner_impb:notifySpawnAreaLeave(pActiveArea, pMovingObject)
	
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
