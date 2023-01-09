modern_deco_box_menu = {}
function modern_deco_box_menu:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	menuResponse:addRadialMenuItem(20, 3, "Open Deco Box (consumes item)")
end

function modern_deco_box_menu:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	if (selectedID == 20) then
		if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
			CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
			return 0 
		end

		local creo = CreatureObject(pPlayer)
		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
		if (pInventory == nil) then
			return 0
		end

		local oid = SceneObject(pSceneObject):getObjectID()
		local pItem = SceneObject(pInventory):getContainerObjectById(oid)
		if (pItem == nil or (pItem ~= pSceneObject)) then
			CreatureObject(pPlayer):sendSystemMessage("(This Object Must be in your inventory to use)")
			return 0
		end

		createLoot(pInventory, "modern_deco_box_group", 1, true)
		SceneObject(pSceneObject):destroyObjectFromWorld()
		SceneObject(pSceneObject):destroyObjectFromDatabase()
	end
end
