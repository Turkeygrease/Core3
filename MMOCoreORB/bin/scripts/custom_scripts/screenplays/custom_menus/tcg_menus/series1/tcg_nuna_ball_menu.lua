tcg_nuna_ball_menu = {}
function tcg_nuna_ball_menu:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	local creo = CreatureObject(pPlayer)
	if (creo:isOvert() and ( creo:isRebel() or  creo:isImperial() )) then
		if (creo:hasSkill("force_title_jedi_rank_03")) then
			menuResponse:addRadialMenuItem(20, 3, "Grant XP (500 FRS)")
		else
			menuResponse:addRadialMenuItem(20, 3, "Grant XP (500 GCW)")
		end
	else
		menuResponse:addRadialMenuItem(20, 3, "Grant XP (2000 General Combat)")
	end
end

function tcg_nuna_ball_menu:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (selectedID == 20) then
		if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
			CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
			return 0 
		end

		local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
		if (pInventory == nil) then return 0 end

		local oid = SceneObject(pSceneObject):getObjectID()
		local pItem = SceneObject(pInventory):getContainerObjectById(oid)
		if (pItem == nil or (pItem ~= pSceneObject)) then
			CreatureObject(pPlayer):sendSystemMessage("(This Object Must be in your inventory to use)")
			return 0
		end

		local creo = CreatureObject(pPlayer)
		if (creo:isOvert() and ( creo:isRebel() or  creo:isImperial() )) then
			if (creo:hasSkill("force_title_jedi_rank_03")) then
				creo:awardExperience("force_rank_xp", 500, true)
			else
				creo:awardExperience("gcw_skill_xp", 500, true)
			end
		else
			creo:awardExperience("combat_general", 2000, true)
		end

		SceneObject(pSceneObject):destroyObjectFromWorld()
		SceneObject(pSceneObject):destroyObjectFromDatabase()
	end
end
