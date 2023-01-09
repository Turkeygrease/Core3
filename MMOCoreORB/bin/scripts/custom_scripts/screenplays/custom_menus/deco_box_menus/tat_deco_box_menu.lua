tat_deco_box_menu = {
	decoTables = {
		{
			"object/tangible/furniture/tatooine/frn_tatt_chair_cantina_seat.iff",
			"object/tangible/furniture/tatooine/frn_tato_vase_style_01.iff",
			"object/tangible/furniture/tatooine/frn_tatt_table_cantina_table_1.iff",
			"object/tangible/furniture/tatooine/frn_tato_table_small_style_01.iff",
			"object/tangible/furniture/tatooine/frn_tato_tbl_cafe_table_style_01.iff",
			"object/tangible/furniture/tatooine/frn_tato_meat_rack.iff",
		},{
			"object/tangible/furniture/tatooine/frn_tatt_chair_cantina_seat_2.iff",
			"object/tangible/furniture/tatooine/frn_tato_vase_style_02.iff",
			"object/tangible/furniture/tatooine/frn_tatt_table_cantina_table_2.iff",
			"object/tangible/furniture/tatooine/frn_tato_table_small_style_02.iff",
			"object/tangible/furniture/tatooine/frn_tato_chair_cafe_style_02.iff",
			"object/tangible/furniture/tatooine/frn_tato_fruit_stand_small_style_01_no_collision.iff",
			"object/tangible/furniture/modern/rug_rect_lg_s01.iff",
		},{
			"object/tangible/furniture/tatooine/frn_tatt_chair_cantina_seat_3.iff",
			"object/tangible/furniture/tatooine/frn_tatt_table_cantina_table_3.iff",
			"object/tangible/furniture/tatooine/frn_tato_table_small_style_03.iff",
			"object/tangible/furniture/tatooine/frn_tato_fruit_stand_large_style_01_no_collision.iff",
			"object/tangible/furniture/tatooine/frn_tato_cafe_parasol.iff",
			"object/tangible/furniture/modern/rug_oval_m_s02.iff",
		},
	},
}

function tat_deco_box_menu:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
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

function tat_deco_box_menu:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
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

		local itemIFF = tat_deco_box_menu:getDeco()
		if (itemIFF == nil) then
			return 0
		end

		local pItem = giveItem(pInventory, itemIFF, -1)
		if (pItem == nil) then
			return 0
		end

		SceneObject(pSceneObject):destroyObjectFromWorld()
		SceneObject(pSceneObject):destroyObjectFromDatabase()
	end
end

function tat_deco_box_menu:getDeco()
	local i = 1
	local found = nil
	while (i <= #tat_deco_box_menu.decoTables and not found) do
		local pick = math.random(0,#tat_deco_box_menu.decoTables[i])+1
		if (pick > #tat_deco_box_menu.decoTables[i]) then
			if (i == #tat_deco_box_menu.decoTables) then
				found = tat_deco_box_menu.decoTables[i][pick-1]
			else
				i = i + 1
			end
		else
			found = tat_deco_box_menu.decoTables[i][pick]
		end
	end
	return found
end
