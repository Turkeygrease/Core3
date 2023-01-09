color_pick_menu = {}

function color_pick_menu:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local response = LuaObjectMenuResponse(pMenuResponse)

	local creo = CreatureObject(pPlayer)
	response:addRadialMenuItem(10, 3, "Pick UP")

	response:addRadialMenuItem(51, 1, "@ui_radial:item_rotate") -- Rotate
	response:addRadialMenuItemToRadialID(51, 52, 3, "@ui_radial:item_rotate_left") -- Rotate Left
	response:addRadialMenuItemToRadialID(51, 53, 3, "@ui_radial:item_rotate_right") -- Rotate Right

	response:addRadialMenuItem(54, 1, "@ui_radial:item_move") -- Move
	response:addRadialMenuItemToRadialID(54, 55, 3, "@ui_radial:item_move_forward") -- Move Forward
	response:addRadialMenuItemToRadialID(54, 56, 3, "@ui_radial:item_move_back") -- Move Back
	response:addRadialMenuItemToRadialID(54, 57, 3, "@ui_radial:item_move_up") -- Move Up
	response:addRadialMenuItemToRadialID(54, 58, 3, "@ui_radial:item_move_down") -- Move Down

	response:addRadialMenuItem(100, 1, "Change Color")
	response:addRadialMenuItemToRadialID(100,101,3,"Set Color 1")
	response:addRadialMenuItemToRadialID(100,102,3,"Set Color 2")
	response:addRadialMenuItemToRadialID(100,103,3,"Set Color 3")
end

function color_pick_menu:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end
	
	if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
		CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
		return 0 
	end

	if (selectedID == 101) then
		local creo = CreatureObject(pPlayer)
		print("Setting Color 1")
		TangibleObject(pSceneObject):setCustomizationVariable("/private/index_color_1", math.random(32))
	elseif (selectedID == 102) then
		local creo = CreatureObject(pPlayer)
		print("Setting Color 2")
		TangibleObject(pSceneObject):setCustomizationVariable("/private/index_color_2", math.random(32))
	elseif (selectedID == 103) then
		local creo = CreatureObject(pPlayer)
		print("Setting Color 3")
		TangibleObject(pSceneObject):setCustomizationVariable("/private/index_color_3", math.random(32))
	end
end

