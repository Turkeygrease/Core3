local ObjectManager = require("managers.object.object_manager")

endor_pvp = ScreenPlay:new {
	numberOfActs = 1,
  	questString = "endor_pvp",
  	states = {onleave = 1, overt = 2},
  	questdata = Object:new {
    	activePlayerName = "initial",
    	}
}
  
registerScreenPlay("endor_pvp", true)
  
function endor_pvp:start()
    	self:spawnActiveAreas()
end
  
function endor_pvp:spawnActiveAreas()
	local pSpawnArea = spawnSceneObject("endor", "object/active_area.iff", -3365, 200, 5223, 0, 0, 0, 0, 0)
    
	if (pSpawnArea ~= nil) then
		local activeArea = LuaActiveArea(pSpawnArea)
	        activeArea:setCellObjectID(0)
	        activeArea:setRadius(360)
--	        activeArea:setPvpZone(true) tool for double xp gains TODO is this even implemented??
	        createObserver(ENTEREDAREA, "endor_pvp", "notifySpawnArea", pSpawnArea)
	        createObserver(EXITEDAREA, "endor_pvp", "notifySpawnAreaLeave", pSpawnArea)
	    end
end
 
--checks if player enters the zone, and what to do with them.
function endor_pvp:notifySpawnArea(pActiveArea, pMovingObject)
	
	if (not SceneObject(pMovingObject):isCreatureObject()) then
		return 0
	end

--[[	if LuaCreatureObject(pMovingObject):hasSkill("admin_base") then 
		return 0 
	end

	if LuaSceneObject(pMovingObject):isOwned() then
		local player = LuaCreatureObject(pMovingObject):getOwner()
		LuaCreatureObject(player):sendSystemMessage("You may not be mounted while entering the PvP zone!")
		LuaCreatureObject(player):teleport(5281, 80.5, 6187, 0)
		LuaCreatureObject(pMovingObject):teleport(5281, 80.5, 6187, 0)
		print("owned object found",pMovingObject)
		return 0
	else
		print("player found",pMovingObject)
	end--]] 
	
	return ObjectManager.withCreatureObject(pMovingObject, function(player)
		if (player:isAiAgent()) then
			return 0
		end 

		if (player:isImperial() or player:isRebel()) then
			createEvent(1, "endor_pvp", "handlePvpZone", pMovingObject,"")
			player:sendSystemMessage("You have entered the Endor PvP zone!")

		else
			player:sendSystemMessage("You must be Rebel or Imperial to enter the PvP zone!")
			player:teleport(-3365, 200, 5675, 0)
		end
		return 0
	end)
end

--Handles the setting of factional status
function endor_pvp:handlePvpZone(pPlayer)
	ObjectManager.withCreatureAndPlayerObject(pPlayer, function(player, playerObject)
		deleteData(player:getObjectID() .. ":changingFactionStatus")
		if (CreatureObject(pPlayer):isCovert() or CreatureObject(pPlayer):isOnLeave()) then
			CreatureObject(pPlayer):setFactionStatus(2)
		end
	end)
	
end

--Simply sends a system message
function endor_pvp:notifySpawnAreaLeave(pActiveArea, pMovingObject)
	
	if (not SceneObject(pMovingObject):isCreatureObject()) then
		return 0
	end
	
	return ObjectManager.withCreatureObject(pMovingObject, function(player)
		if (player:isAiAgent()) then
			return 0
		end
		
		if (player:isImperial() or player:isRebel()) then
			player:sendSystemMessage("You have left the Endor PvP zone!")
		end
		return 0
	end)
end
