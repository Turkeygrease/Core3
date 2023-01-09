local ObjectManager = require("managers.object.object_manager")

endorcloner_rebb = ScreenPlay:new {
	numberOfActs = 1,
  	questString = "endorcloner_rebb",
  	states = {onleave = 1, overt = 2},
  	questdata = Object:new {
    	activePlayerName = "initial",
    	}
}
  
registerScreenPlay("endorcloner_rebb", true)
  
function endorcloner_rebb:start()
    	self:spawnActiveAreas()
	
end


  
function endorcloner_rebb:spawnActiveAreas()
	local pSpawnArea = spawnSceneObject("endor", "object/active_area.iff", -3588, 200, 5215, 0, 0, 0, 0, 0)
    
	if (pSpawnArea ~= nil) then
		local activeArea = LuaActiveArea(pSpawnArea)
	        activeArea:setCellObjectID(0)
	        activeArea:setRadius(15)
	        createObserver(ENTEREDAREA, "endorcloner_rebb", "notifySpawnArea", pSpawnArea)
	        createObserver(EXITEDAREA, "endorcloner_rebb", "notifySpawnAreaLeave", pSpawnArea)
	    end
end
 
--checks if player enters the zone, and what to do with them.
function endorcloner_rebb:notifySpawnArea(pActiveArea, pMovingObject)
	
	if (not SceneObject(pMovingObject):isCreatureObject()) then
		return 0
	end
	
	return ObjectManager.withCreatureObject(pMovingObject, function(player)
		if (player:isAiAgent()) then
			return 0
		end
		
		if (player:isImperial()) or (player:isInCombat()) then
			player:sendSystemMessage("You can not enter this area while in combat")
			player:teleport(-3568, 200, 5268, 0)
	
		end
		return 0
	end)
end
--Simply sends a system message
function endorcloner_rebb:notifySpawnAreaLeave(pActiveArea, pMovingObject)
	
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
