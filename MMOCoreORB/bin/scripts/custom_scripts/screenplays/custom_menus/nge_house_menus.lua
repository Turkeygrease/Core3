bespin_house_menu = {}
function bespin_house_menu:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	local creo = CreatureObject(pPlayer)
	menuResponse:addRadialMenuItem(20, 3, "(Not Yet Implemented)")
end

function bespin_house_menu:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (selectedID == 20) then
		if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
			CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
			return 0 
		end

		local creo = CreatureObject(pPlayer)
	end
end


relaxation_house_menu = {}
function relaxation_house_menu:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local creo = CreatureObject(pPlayer)
	local sno = SceneObject(pSceneObject)
	local pGhost = creo:getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local response = LuaObjectMenuResponse(pMenuResponse)
	if (creo:checkCooldownRecovery("effect_object_used")) then
		local fishEffect = readStringData(sno:getObjectID().."fishEffect")-- Fish Effect Type
		if (fishEffect == "") then
			response:addRadialMenuItem(101, 3, "Fish Effect [OFF]")
		else
			response:addRadialMenuItem(101, 3, "Fish Effect ["..fishEffect.."]")
			response:addRadialMenuItemToRadialID(101,102,3,"Turn Fish Off")
		end
		response:addRadialMenuItemToRadialID(101,103,3,"Geonosian")
		response:addRadialMenuItemToRadialID(101,104,3,"Blue Fish")

		local lightEffect = readData(sno:getObjectID().."lightEffect")-- Pool Lights Effect Status
		if (lightEffect == 0) then
			response:addRadialMenuItem(110, 3, "Pool Lights [OFF]")
			response:addRadialMenuItemToRadialID(110,111,3,"Gold")
			response:addRadialMenuItemToRadialID(110,112,3,"Green")
			response:addRadialMenuItemToRadialID(110,113,3,"Magenta")
			response:addRadialMenuItemToRadialID(110,114,3,"Purple")
			response:addRadialMenuItemToRadialID(110,115,3,"Red")
			response:addRadialMenuItemToRadialID(110,116,3,"Royal Blue")
			response:addRadialMenuItemToRadialID(110,117,3,"Rainbow")
			response:addRadialMenuItemToRadialID(110,118,3,"Cyan")
		else
			response:addRadialMenuItem(110, 3, "Pool Lights [ON]")
			response:addRadialMenuItemToRadialID(110,119,3,"Turn lights OFF")
		end

		local lightEffect2 = readData(sno:getObjectID().."lightEffect2")-- Jacuzzi Light Effect Status
		if (lightEffect2 == 0) then
			response:addRadialMenuItem(120, 3, "Jacuzzi [OFF]")
			response:addRadialMenuItemToRadialID(120,121,3,"Blue Jacuzzi Lights")
			response:addRadialMenuItemToRadialID(120,122,3,"Red Jacuzzi Lights")
			response:addRadialMenuItemToRadialID(120,123,3,"Yellow Jacuzzi Lights")
		else
			response:addRadialMenuItem(120, 3, "Jacuzzi [ON]")
			response:addRadialMenuItemToRadialID(120,124,3,"Turn Jacuzzi OFF")
		end

		local lightEffect3 = readData(sno:getObjectID().."lightEffect3")-- Room Lights Effect Status
		if (lightEffect3 == 0) then
			response:addRadialMenuItem(130, 3, "Room Lights [OFF]")
			response:addRadialMenuItemToRadialID(130,131,3,"Gold")
			response:addRadialMenuItemToRadialID(130,132,3,"Green")
			response:addRadialMenuItemToRadialID(130,133,3,"Magenta")
			response:addRadialMenuItemToRadialID(130,134,3,"Purple")
			response:addRadialMenuItemToRadialID(130,135,3,"Red")
			response:addRadialMenuItemToRadialID(130,136,3,"Royal Blue")
		else
			response:addRadialMenuItem(130, 3, "Room Lights [ON]")
			response:addRadialMenuItemToRadialID(130,137,3,"Turn lights OFF")
		end
	end
end

function relaxation_house_menu:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if ((pSceneObject == nil) or (not menu_helper:validateUser(pPlayer))) then
		return 0
	end

	local sno = SceneObject(pSceneObject)
	local snoID = sno:getObjectID()
	local pBld = SceneObject(sno:getParent()):getParent()
	local lbob = LuaBuildingObject(pBld)
	if (lbob:getOwnerID() ~= SceneObject(pPlayer):getObjectID()) then
		CreatureObject(pPlayer):sendSystemMessage("(You must be the building owner to use this panel)")
		return 0
	end

	if ((selectedID > 101) and (selectedID < 110)) then
		local fishEffect = ""
		menu_helper:destroyList(readStringData(snoID.."fishList"))
		if (selectedID == 102) then
			deleteStringData(snoID.."fishEffect")-- Delete Fish Effect Type from memory
		else
			local cellID = SceneObject(lbob:getCell(1)):getObjectID()
			local zone = sno:getZoneName()
			local fish,fish2
			if (selectedID == 103) then --template x z y cell dw dx dy dz
				fish = spawnSceneObject(zone, "object/static/particle/pt_geonosian_aquarium_fish.iff", 0, -0.8, 2, cellID, math.rad(math.random(360)))
				fish2 = spawnSceneObject(zone, "object/static/particle/pt_geonosian_aquarium_fish.iff", 0, -0.8, -2, cellID, math.rad(math.random(360)))
				fishEffect = "Geonosian"
			elseif (selectedID == 104) then
				fish = spawnSceneObject(zone, "object/static/particle/pt_flocking_bluefish.iff", 0, 1.5, 2, cellID, math.rad(math.random(360)))
				fish2 = spawnSceneObject(zone, "object/static/particle/pt_flocking_bluefish.iff", 0, 1.5, -2, cellID, math.rad(math.random(360)))
				fishEffect = "Blue Fish"
			end
			writeStringData(snoID.."fishList", tostring(SceneObject(fish):getObjectID())..","..tostring(SceneObject(fish2):getObjectID()))
		end
		writeStringData(snoID.."fishEffect",fishEffect)
	elseif ((selectedID > 110) and (selectedID < 119)) then -- Pool Lights
		local template = ""
		if (selectedID == 111) then
			template = "object/tangible/furniture/effect_control/water_wf_01_gold.iff"
		elseif (selectedID == 112) then
			template = "object/tangible/furniture/effect_control/water_wf_01_green.iff"
		elseif (selectedID == 113) then
			template = "object/tangible/furniture/effect_control/water_wf_01_magenta.iff"
		elseif (selectedID == 114) then
			template = "object/tangible/furniture/effect_control/water_wf_01_purple.iff"
		elseif (selectedID == 115) then
			template = "object/tangible/furniture/effect_control/water_wf_01_red.iff"
		elseif (selectedID == 116) then
			template = "object/tangible/furniture/effect_control/water_wf_01_blue.iff"
		elseif (selectedID == 117) then
			template = "object/tangible/furniture/effect_control/water_wf_01_rainbow.iff"
		elseif (selectedID == 118) then
			template = "object/tangible/furniture/effect_control/water_wf_01_cyan.iff"
		end

		local cellID = SceneObject(lbob:getCell(1)):getObjectID()
		local zone = sno:getZoneName()
		if (template ~= "") then
			local light = spawnSceneObject(zone, template, 0, 0.84, 0, cellID, 0)
			writeData(snoID.."lightEffect",1)
			writeStringData(snoID.."lightList", tostring(SceneObject(light):getObjectID()))
		end
	elseif (selectedID == 119) then
		deleteData(snoID.."lightEffect")
		menu_helper:destroyList(readStringData(snoID.."lightList"))
	elseif ((selectedID > 120) and (selectedID < 124)) then -- Jacuzzi Light
		local template = ""
		if (selectedID == 121) then
			template = "object/static/particle/particle_newbie_wall_mech_lights_blue.iff"
		elseif (selectedID == 122) then
			template = "object/static/particle/particle_newbie_wall_mech_lights_red.iff"
		elseif (selectedID == 123) then
			template = "object/static/particle/particle_newbie_wall_mech_lights_yellow.iff"
		end

		local cellID = SceneObject(lbob:getCell(1)):getObjectID()
		local zone = sno:getZoneName()
		if (template ~= "") then
			local steam = spawnSceneObject(zone, "object/static/particle/pt_waterfall_mist_small.iff", 0, 0.9, -5.4, cellID, 0)
			local light = spawnSceneObject(zone, template, -0.1, 1.245, -6.0, cellID, math.rad(0))
			local light2 = spawnSceneObject(zone, template, 0, 1.245, -5.3, cellID, math.rad(270))
			local light3 = spawnSceneObject(zone, template, 0.1, 1.245, -6.0, cellID, math.rad(180))
			writeData(snoID.."lightEffect2",1)
			writeStringData(snoID.."lightList2", tostring(SceneObject(light):getObjectID())..","..tostring(SceneObject(light2):getObjectID())..","..tostring(SceneObject(light3):getObjectID())..","..tostring(SceneObject(steam):getObjectID()))
		end
	elseif (selectedID == 124) then
		deleteData(snoID.."lightEffect2")
		menu_helper:destroyList(readStringData(snoID.."lightList2"))
	elseif ((selectedID > 130) and (selectedID < 137)) then -- Room Lights
		local template = ""
		if (selectedID == 131) then
			template = "object/static/particle/pt_light_streetlamp_gold_arena_01.iff"
		elseif (selectedID == 132) then
			template = "object/static/particle/pt_light_streetlamp_green_arena_01.iff"
		elseif (selectedID == 133) then
			template = "object/static/particle/pt_light_streetlamp_magenta_01.iff"
		elseif (selectedID == 134) then
			template = "object/static/particle/pt_light_streetlamp_purple_01.iff"
		elseif (selectedID == 135) then
			template = "object/static/particle/pt_light_streetlamp_red_arena_01.iff"
		elseif (selectedID == 136) then
			template = "object/static/particle/pt_light_streetlamp_royalblue_01.iff"
		end

		local cellID = SceneObject(lbob:getCell(1)):getObjectID()
		local zone = sno:getZoneName()
		if (template ~= "") then
			local light = spawnSceneObject(zone, template, 0, 0, 5.4, cellID, 0)
			local light2 = spawnSceneObject(zone, template, 0, 0, -5.4, cellID, 0)
			writeData(snoID.."lightEffect3",1)
			writeStringData(snoID.."lightList3", tostring(SceneObject(light):getObjectID())..","..tostring(SceneObject(light2):getObjectID()))
		end
	elseif (selectedID == 137) then
		deleteData(snoID.."lightEffect3")
		menu_helper:destroyList(readStringData(snoID.."lightList3"))
	end
	writeStringData(snoID.."listStrings", "fishList,lightList,lightList2,lightList3")
	writeStringData(snoID.."memoryStrings", "fishEffect")
	writeStringData(snoID.."memoryData", "lightEffect,lightEffect2,lightEffect3")
	dropObserver(OBJECTREMOVEDFROMZONE, "menu_helper", "cleanUpMenuAll",pSceneObject)
	createObserver(OBJECTREMOVEDFROMZONE, "menu_helper", "cleanUpMenuAll",pSceneObject)
end


sandcrawler_house_menu = {}
function sandcrawler_house_menu:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	local creo = CreatureObject(pPlayer)
	menuResponse:addRadialMenuItem(20, 3, "(Not Yet Implemented)")
end

function sandcrawler_house_menu:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (selectedID == 20) then
		if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
			CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
			return 0 
		end

		local creo = CreatureObject(pPlayer)
	end
end


jabbas_house_menu = {}
function jabbas_house_menu:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	local creo = CreatureObject(pPlayer)
	menuResponse:addRadialMenuItem(20, 3, "(Not Yet Implemented)")
end

function jabbas_house_menu:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (selectedID == 20) then
		if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
			CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
			return 0 
		end

		local creo = CreatureObject(pPlayer)
	end
end

tree_house_menu = {}
function tree_house_menu:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	local creo = CreatureObject(pPlayer)
	menuResponse:addRadialMenuItem(20, 3, "(Not Yet Implemented)")
end

function tree_house_menu:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (selectedID == 20) then
		if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
			CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
			return 0 
		end

		local creo = CreatureObject(pPlayer)
	end
end
