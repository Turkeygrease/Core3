--[[ By: Michael Simnitt aka Mindsoft
Date: Sep/27/2018
Description: Instance Porter Handler
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]


---------------------------------------------(Instance Porter Handler)
WFporter = {}
function WFporter:spawnPorter(p,t,r,x,z,y,f,c,name,instance)
	local porter = spawnMobile(p, t, r, x, z, y, f, c)
	SceneObject(porter):setCustomObjectName(name)
	writeStringData(SceneObject(porter):getObjectID().."InstanceType",instance)
	SceneObject(porter):setObjectMenuComponent("WFporter")
	return porter
end

-- player radial menu options
function WFporter:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	if (PlayerObject(pGhost):hasTef()) then
		CreatureObject(pPlayer):sendSystemMessage("(You cannot join Instances while in TEF state)")
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	local zone = SceneObject(pSceneObject):getZoneName()
	local str = readStringData(SceneObject(pSceneObject):getObjectID().."InstanceType")-- porter type
	local option = WF_Instance_Handler.instances[str].groupType or "solo"
	if (string.find(zone, "dungeon") ~= nil) then
		menuResponse:addRadialMenuItem(103, 3, "[Exit] Leave Instance")

		local pBuilding = SceneObject(SceneObject(pSceneObject):getParent()):getParent()
		local buildingID = SceneObject(pBuilding):getObjectID()
		local str = readStringData("WF_Instance_Handler:"..buildingID) -- get instance type
		local data = WF_Instance_Handler.instances[str]
		if (data.groupType == "solo") then
			menuResponse:addRadialMenuItem(107, 3, "[QUIT] Abandon Instance")
		elseif (data.groupType == "group") then
			--TODO add group abandon
		end

		if (CreatureObject(pPlayer):hasSkill("admin_base")) then
			menuResponse:addRadialMenuItem(105, 3, "[DEV] Get Instance Stat Report")
		end
	else
		if (CreatureObject(pPlayer):hasSkill("admin_base")) then
			menuResponse:addRadialMenuItem(106, 3, "[DEV] Manage Instances")
			menuResponse:addRadialMenuItem(108, 3, "[DEV] Manage Group Instance")
		end

		local pI = readData("WF_Instance_Handler:playerInstance"..SceneObject(pPlayer):getObjectID())
		local msg = "Create Instance"
		if (option == "open") then
			local openInstance = readData("WF_Instance_Handler:openInstance:"..str)
			if (getSceneObject(openInstance)) then
				menuResponse:addRadialMenuItem(104, 3, "Join Open Instance")
				return
			end
		elseif ((option == "group") and CreatureObject(pPlayer):isGrouped()) then
			if not(CreatureObject(pPlayer):getGroupMember(0) == pPlayer) then
				msg = "Join Instance"
			end
		end

		if (pI == 0) then
			menuResponse:addRadialMenuItem(104, 3, msg)
		elseif (getSceneObject(pI)) then
			if (SceneObject(getSceneObject(pI)):getZoneName() == "") then
				writeData("WF_Instance_Handler:playerInstance"..SceneObject(pPlayer):getObjectID(),0)
				menuResponse:addRadialMenuItem(104, 3, msg)
			else
				local pItype = readStringData("WF_Instance_Handler:"..pI) -- get player last Instance type
				if (str == pItype) then
					menuResponse:addRadialMenuItem(104, 3, "Return to Instance")
				else
					menuResponse:addRadialMenuItem(109, 3, "[View MY locking Instance]")
				end
			end
		else
			writeData("WF_Instance_Handler:playerInstance"..SceneObject(pPlayer):getObjectID(),0)
			menuResponse:addRadialMenuItem(104, 3, msg)
		end
	end
end

-- player selection processing
function WFporter:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
		CreatureObject(pPlayer):sendSystemMessage("(You cannot join Instances in your current state)")
		return 0 
	end

	if not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 6) then
		CreatureObject(pPlayer):sendSystemMessage("(You are not in range to use this object)")
		return 0
	end

	local str = readStringData(SceneObject(pSceneObject):getObjectID().."InstanceType")
	if (selectedID == 103) then
		WF_Instance_Handler:ejectPlayer(pPlayer, str)
	elseif (selectedID == 104) then
		local tests = WF_Instance_Handler.instances[str].tests
		if  (tests and not (WFtest:testAll(pPlayer, WF_Instance_Handler.instances[str].tests, true))) then
			return 0
		end
		local option = WF_Instance_Handler.instances[str].groupType or "solo"
		WFporter[option](pSceneObject, pPlayer, str)
	elseif (selectedID == 107) then
		local pBuilding = SceneObject(SceneObject(pSceneObject):getParent()):getParent()
		local buildingID = SceneObject(pBuilding):getObjectID()
		local str = readStringData("WF_Instance_Handler:"..buildingID) -- get instance type
		if (WF_Instance_Handler.instances[str].groupType == "solo") then
			WFporter:confirmAbandonSolo(pPlayer, pSceneObject, pBuilding)
		end
	elseif (selectedID == 109) then
		WFporter:viewLockingInstance(pPlayer, pSceneObject, str)
	elseif (CreatureObject(pPlayer):hasSkill("admin_base")) then
		if (selectedID == 105) then
			local pBuilding = SceneObject(SceneObject(pSceneObject):getParent()):getParent() --get building porter is in
			WFporter:viewInstance(pBuilding, pPlayer)
		elseif (selectedID == 106) then
			CreatureObject(pPlayer):sendSystemMessage("(Opening Instance Manager)")
			WFporter:manageInstances(pPlayer, str)
			--WFporter:moveToInstance(getSceneObject(281475035886730), pPlayer, "nova")
		elseif (selectedID == 108) then
			WFporter:viewGroup(pSceneObject, pPlayer, str)
		end
	end
end

--porter for group instances/quests
function WFporter.group(pPorter, pPlayer, instanceType) -- (timed lifespan)
	if not(CreatureObject(pPlayer):isGrouped())then
		CreatureObject(pPlayer):sendSystemMessage("(You must be in a group to join this instance type)")
		return 0
	end
	--print("group ID:"..tostring(CreatureObject(pPlayer):getGroupID()))
	local playerCount = 0
 	local groupSize = CreatureObject(pPlayer):getGroupSize()
	for i = 0, groupSize - 1, 1 do
		if (SceneObject(CreatureObject(pPlayer):getGroupMember(i)):isPlayerCreature()) then
			playerCount = playerCount + 1
		end
	end

	local minPlayerCount = WF_Instance_Handler.instances[instanceType].minPlayerCount or 2
	if (playerCount < minPlayerCount) then
		CreatureObject(pPlayer):sendSystemMessage("(Your Group must have at least "..tostring(minPlayerCount).." players for this instance)")
		return 0
	end

	local msg = "(Exiting Group Instance Creation)"
	local move
	local pID = SceneObject(pPlayer):getObjectID() -- get Player id
	local pGID = math.floor(CreatureObject(pPlayer):getGroupID()) -- get Player Group ID
	local gBID = readData("WF_Instance_Handler:groupBuilding"..pGID) -- get Group Building ID
	local gBuildingType = readStringData("WF_Instance_Handler:"..gBID) --get group Instance Type
	local gI = readData("WF_Instance_Handler:groupBuilding"..pGID) -- get Group last Instance building ID
	local pI = readData("WF_Instance_Handler:playerInstance"..pID) -- get Player last Instance building ID
	local pItype = readStringData("WF_Instance_Handler:"..pI) -- get player last Instance type

	if ((pI == 0) or (SceneObject(getSceneObject(pI)):getZoneName() == "")) then
		if not(CreatureObject(pPlayer):checkCooldownRecovery("WF_Instance_Handler:"..instanceType)) then
			msg = "(Your remaining Lockout for this instance is..)\n"..CreatureObject(pPlayer):getCooldownString("WF_Instance_Handler:"..instanceType)
		elseif ((gI == 0) or (SceneObject(getSceneObject(gI)):getZoneName() == "")) then
			move = "create"
		elseif (gBuildingType == instanceType) then
			msg = "(Joining Group Instance)"
			move = gI
			local cooldown = WF_Instance_Handler.instances[instanceType].cooldownTimer or WF_Instance_Handler.instances[instanceType].lockoutTimer
			CreatureObject(pPlayer):addCooldown("WF_Instance_Handler:"..instanceType, cooldown)
		else
			msg = "(Your Group already has an active Instance)"
		end
	elseif (pItype ~= instanceType) then
		msg = "(You already have an active Instance)"
	elseif (pI == gI) then
		msg = "(Rejoining Group Instance)"
		move = pI
	else
		msg = "(You already have an active Instance with another Group)"
	end

	if (move) then
		if (move == "create") then
			if (CreatureObject(pPlayer):getGroupMember(0) == pPlayer) then
				local newInstance = WF_Instance_Handler:spawnInstance(instanceType, pPlayer)
				if not(newInstance) then
					CreatureObject(pPlayer):sendSystemMessage("(Could not create a new Group Instance)")
					return 0
				end
				msg = "(Creating a new Group Instance)"
				writeData("WF_Instance_Handler:groupBuilding"..pGID, SceneObject(newInstance):getObjectID())
				local cooldown = WF_Instance_Handler.instances[instanceType].cooldownTimer or WF_Instance_Handler.instances[instanceType].lockoutTimer
				CreatureObject(pPlayer):addCooldown("WF_Instance_Handler:"..instanceType, cooldown)
				WFporter:moveToInstance(newInstance, pPlayer, instanceType)
				writeData("WF_Instance_Handler:playerInstance"..pID,SceneObject(newInstance):getObjectID())
			else
				msg = "(ONLY the Group Leader can start a new Group Instance)"
			end
		else
			local maxPlayerCount = WF_Instance_Handler.instances[instanceType].maxPlayerCount or 8
			local InstanceMemberCount = 0
			--TODO add member count test

			WFporter:moveToInstance(getSceneObject(move), pPlayer, instanceType)
			writeData("WF_Instance_Handler:playerInstance"..pID, move)
		end
	end
	CreatureObject(pPlayer):sendSystemMessage(msg)
end

--porter for solo instances/quests
function WFporter.solo(pPorter, pPlayer, instanceType) -- (timed lifespan)
	local pID = SceneObject(pPlayer):getObjectID()
	local pI = readData("WF_Instance_Handler:playerInstance"..pID) -- get Player last Instance building ID
	local pItype = readStringData("WF_Instance_Handler:"..pI) -- get player last Instance type
	
	if ((pI == 0) or (SceneObject(getSceneObject(pI)):getZoneName() == "")) then
		if not(CreatureObject(pPlayer):checkCooldownRecovery("WF_Instance_Handler:"..instanceType)) then
			CreatureObject(pPlayer):sendSystemMessage("(Your remaining Lockout for this instance is..)")
			CreatureObject(pPlayer):sendSystemMessage(CreatureObject(pPlayer):getCooldownString("WF_Instance_Handler:"..instanceType))
			return 0
		end
		CreatureObject(pPlayer):sendSystemMessage("(Creating new Solo Instance)")
		local newInstance = WF_Instance_Handler:spawnInstance(instanceType, pPlayer)
		if not(newInstance) then
			CreatureObject(pPlayer):sendSystemMessage("[Instance Planet Full]: Solo Instance was NOT created.")
			return 0
		end
		writeData("WF_Instance_Handler:playerInstance"..pID, SceneObject(newInstance):getObjectID())
		local cooldown = WF_Instance_Handler.instances[instanceType].cooldownTimer or WF_Instance_Handler.instances[instanceType].lockoutTimer
		CreatureObject(pPlayer):addCooldown("WF_Instance_Handler:"..instanceType, cooldown)
		WFporter:moveToInstance(newInstance, pPlayer, instanceType)
	elseif (pItype == instanceType) then
		WFporter:moveToInstance(getSceneObject(pI), pPlayer, instanceType)
		CreatureObject(pPlayer):sendSystemMessage("(You have been returned to your Solo Instance)")
	else
		CreatureObject(pPlayer):sendSystemMessage("(You already have an active Instance)")
	end
end

--porter for open instances/quests/events/perks
function WFporter.open(pPorter, pPlayer, instanceType) -- (lifespan = server reset)
	local openInstance = readData("WF_Instance_Handler:openInstance:"..instanceType)
	if ((openInstance == 0) or (SceneObject(getSceneObject(openInstance)):getZoneName() == "")) then
		CreatureObject(pPlayer):sendSystemMessage("(This Instance is not available at this time)")
	else
		WFporter:moveToInstance(getSceneObject(openInstance), pPlayer, instanceType)	
	end
end

function WFporter.static(pPorter, pPlayer, instanceType) --TODO persistant instances (permanent lifespan)

end

function WFporter.dynamicStatic(pPorter, pPlayer, instanceType) --TODO semi persistant instances (timed lifespan > server reset)

end

--move player to existing instance
function WFporter:moveToInstance(pBuilding, pPlayer)
	--print("WFporter:moveToInstance- is running")
	local instanceType = readStringData("WF_Instance_Handler:"..SceneObject(pBuilding):getObjectID())
	local bID = SceneObject(pBuilding):getObjectID()
	local pID = SceneObject(pPlayer):getObjectID()
	local data = WF_Instance_Handler.instances[instanceType]
	--print("data: "..tostring(data).. "instanceType:"..tostring(instanceType))
	local loadCell
	if (data.playerSpawn) then
		loadCell = data.playerSpawn
	elseif (CreatureObject(pPlayer):getFaction() == FACTIONIMPERIAL) then
		loadCell = data.factionSpawns.imperial
	elseif (CreatureObject(pPlayer):getFaction() == FACTIONREBEL) then
		loadCell = data.factionSpawns.rebel
	else
		loadCell = data.factionSpawns.neutral
	end

	local cellID
	if (type(loadCell[4]) == "string") then
		--print("Named Cell Found!: "..loadCell[4])
		cellID = BuildingObject(pBuilding):getNamedCell(loadCell[4])
		--print("Returned Cell ID"..tostring(loadCell[4]))
	elseif (loadCell[4] == 0) then
		local zone = SceneObject(pBuilding):getZoneName()
		local ctrl = SceneObject(pBuilding)
		local x = ctrl:getWorldPositionX()
		local z = ctrl:getWorldPositionZ()
		local y = ctrl:getWorldPositionY()
		SceneObject(pPlayer):switchZone(zone, x+loadCell[1], z+loadCell[2], y+loadCell[3], 0)
		return
	else
		local pCell = BuildingObject(pBuilding):getCell(loadCell[4])
		if (pCell == nil) then
			return
		end
		cellID = SceneObject(pCell):getObjectID()
	end

	local zone = SceneObject(getSceneObject(bID)):getZoneName()
	SceneObject(pPlayer):switchZone(zone, loadCell[1], loadCell[2], loadCell[3], cellID)
	--dropObserver(LOGGEDIN, "WF_Instance_Handler", "onLoggedIn", pPlayer)
	--createObserver(LOGGEDIN, "WF_Instance_Handler", "onLoggedIn", pPlayer, 1)
end


function WFporter:confirmAbandonSolo(pPlayer, pSceneObject, instanceType)
	local sui = SuiMessageBox.new("WFporter","confirmAbandonSoloCallback")
	if (pSceneObject == nil) then
			sui.setTargetNetworkId(0)
		else
			sui.setTargetNetworkId(SceneObject(pSceneObject):getObjectID())
	end
	sui.setTitle("Confirm: [Abandon] Solo Instance")
	sui.setPrompt("Are you sure you want to abandon this Instance?\n\n  This action will:\n1) Destroy the Instance.\n2) Release your Solo Instance lock.\n3) Eject you from the Instance.")
	sui.sendTo(pPlayer)
end

function WFporter:confirmAbandonSoloCallback(pPlayer, pSui, eventIndex, args)
	if (eventIndex == 0) then
		local pI = readData("WF_Instance_Handler:playerInstance"..SceneObject(pPlayer):getObjectID())
		local pBuilding = SceneObject(SceneObject(pPlayer):getParent()):getParent()
		if (pI == SceneObject(pBuilding):getObjectID()) then	
			createEvent(5, "WF_Instance_Handler", "despawnBuilding", pBuilding, "")
		end
	end
end

function WFporter:defaultCallback(pPlayer, pSui, eventIndex, args, d1, d2)
	--print("default callback")
	--print(pPlayer, pSui, eventIndex, args, d1, d2)
end

function WFporter:viewInstance(pBuilding, pPlayer)
	local sui = SuiListBox.new("WFporter","defaultCallback")
	sui.setTitle("Instance Report:")
	sui.setPrompt("Building ID: "..tostring(SceneObject(pBuilding):getObjectID()).."\nInstance ID: "..tostring(readData("WF_Instance_Handler:"..SceneObject(pBuilding):getObjectID()..":inx")))
	local stats = WF_Instance_Handler:getBuildingStats(pBuilding)
	local msg
	for k,v in pairs(stats) do
		msg = k..": "..v
		sui.add(msg, v)
	end
	sui.sendTo(pPlayer)
end

function WFporter:viewGroup(pSceneObject, pPlayer, str)
	local sui = SuiListBox.new("WFporter","viewGroupCallback")
	sui.setTitle("Instance Group Report:")
	sui.setTargetNetworkId(SceneObject(pSceneObject):getObjectID())
	sui.setForceCloseDistance(16)
	local groupSize = CreatureObject(pPlayer):getGroupSize()
	local playerCount = 0
	for i = 0, groupSize - 1, 1 do
		if (SceneObject(CreatureObject(pPlayer):getGroupMember(i)):isPlayerCreature()) then
			local pMember = CreatureObject(pPlayer):getGroupMember(i)
			playerCount = playerCount + 1
			sui.add(CreatureObject(pMember):getFirstName().."  ID: "..SceneObject(pMember):getObjectID().." Locked:"..tostring(not CreatureObject(pMember):checkCooldownRecovery("WF_Instance_Handler:"..str)), SceneObject(pMember):getObjectID())
		end
	end
	local prompt = "(Select Player to Inspect/Edit)\n"
	prompt = prompt.."\nInstance Type: "..str
	prompt = prompt.."\nGroup ID: "..CreatureObject(pPlayer):getGroupID()
	prompt = prompt.."\nGroup Size: "..groupSize
	if (groupSize == 0) then
		prompt = prompt.."\n\n     (You are NOT Grouped)"
		sui.add(CreatureObject(pPlayer):getFirstName().."  ID: "..SceneObject(pPlayer):getObjectID().." Locked:"..tostring(not CreatureObject(pPlayer):checkCooldownRecovery("WF_Instance_Handler:"..str)), SceneObject(pPlayer):getObjectID())
	else
		prompt = prompt.."\nGroup Leader: "..CreatureObject(CreatureObject(pPlayer):getGroupMember(i)):getFirstName()
		prompt = prompt.."\nPlayer Count: "..playerCount
	end
	sui.setPrompt(prompt)
	sui.sendTo(pPlayer)
end

function WFporter:viewGroupCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)
	if (cancelPressed or args == nil or tonumber(args) < 0) then
		return
	end

	local pPageData = LuaSuiBoxPage(pSui):getSuiPageData()
	if (pPageData == nil) then
		return
	end

	local suiPageData = LuaSuiPageData(pPageData)
	local menuOption = suiPageData:getStoredData(tostring(args))
	local porter = suiPageData:getTargetNetworkId()
	local pTarget = getSceneObject(menuOption)

	local pID = SceneObject(pTarget):getObjectID() -- get Player id
	local pGID = math.floor(CreatureObject(pTarget):getGroupID()) -- get Player Group ID
	local gI = readData("WF_Instance_Handler:groupBuilding"..pGID) -- get Group last Instance building ID
	local gItype = readStringData("WF_Instance_Handler:"..gI) --get group Instance Type
	local pI = readData("WF_Instance_Handler:playerInstance"..pID) -- get Player last Instance building ID
	local pItype = readStringData("WF_Instance_Handler:"..pI) -- get player last Instance type
	local piZone = "N/A"
	local giZone = "N/A"
	if (pGID == 0) then pGID = "Not Grouped" end

	if (gI == 0 or not(getSceneObject(gI))) then 
		gI = "N/A"
	else
		giZone = SceneObject(getSceneObject(gI)):getZoneName()
	end
	if (gItype == "") then gItype = "N/A" end

	if (pI == 0 or not(getSceneObject(pI))) then
		pI = "N/A"
	else
		piZone = SceneObject(getSceneObject(pI)):getZoneName()
	end
	if (pItype == "") then pItype = "N/A" end

	local msg = "Name:("..SceneObject(pTarget):getDisplayedName()..")"
	msg = msg.."\n  Last Instance:("..pI..")  Type:("..pItype..")  In-Zone:("..piZone..")"
	msg = msg.."\n\nGroup ID:("..pGID..")"
	msg = msg.."\n  Last Group Instance:("..gI..")  Type:("..gItype..")  In-Zone:("..giZone..")"

	local sui = SuiListBox.new("WFporter","viewGroupCallbackPlayer")
	sui.setTargetNetworkId(porter)
	sui.setTitle("Instance Player Management:")
	sui.setPrompt(msg)
	sui.add("[Unlock] Player for this Instance", "viewGroupCallbackPlayerOp1")
	sui.add("[Abort] Players Locking Instance", "viewGroupCallbackPlayerOp2")
	sui.sendTo(pPlayer)
	sui.add("targetID", menuOption)
end

function WFporter:viewGroupCallbackPlayer(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)
	if (cancelPressed or args == nil) then
		return
	end

	local pPageData = LuaSuiBoxPage(pSui):getSuiPageData()
	if (pPageData == nil) then
		return
	end

	local suiPageData = LuaSuiPageData(pPageData)
	local pPorter = getSceneObject(suiPageData:getTargetNetworkId())

	if(tonumber(args) < 0) then
		local str = readStringData(SceneObject(pPorter):getObjectID().."InstanceType")
		WFporter:viewGroup(pPorter, pPlayer, str)
		return
	end

	local menuOption = suiPageData:getStoredData(tostring(args))
	local targetID = suiPageData:getStoredData(tostring(2))
	WFporter[menuOption](pPorter, pPlayer, targetID)
end

function WFporter.viewGroupCallbackPlayerOp1(pPorter, pPlayer, targetID)
	local str = readStringData(SceneObject(pPorter):getObjectID().."InstanceType")
	local pTarget = getSceneObject(tonumber(targetID))
	CreatureObject(pTarget):addCooldown("WF_Instance_Handler:"..str, 0)
	CreatureObject(pTarget):sendSystemMessage("(Instance type:"..str.." Has been Reset)")
	CreatureObject(pPlayer):sendSystemMessage("(Players Instance type:"..str.." Has been Reset)")
	WFporter:viewGroup(pPorter, pPlayer, str)
end

function WFporter.viewGroupCallbackPlayerOp2(pPorter, pPlayer, targetID)
	local pTarget = getSceneObject(tonumber(targetID))
	local tI = readData("WF_Instance_Handler:playerInstance"..targetID) --target last instance ID
	local tItype = readStringData("WF_Instance_Handler:"..tI) --target last Instance type
	local sui = SuiMessageBox.new("WFporter","managedAbandonInstanceCallback")
	sui.setTitle("Confirm: [Abandon] Instance")
	sui.setPrompt("Are you sure you want to abandon Locking Instance?\n\n  This action will:\n1) Destroy the Instance.\n2) Release your Instance lock.\n3) Eject any Players inside the Instance.")
	sui.sendTo(pTarget)
	CreatureObject(pPlayer):sendSystemMessage("(Players Instance type:"..tItype.." Abort Confirm Sent)")
	WFporter:viewGroup(pPorter, pPlayer, tItype)
end

function WFporter:managedAbandonInstanceCallback(pPlayer, pSui, eventIndex, args)
	if (eventIndex == 0) then
		local pI = readData("WF_Instance_Handler:playerInstance"..SceneObject(pPlayer):getObjectID())
		local pBuilding = getSceneObject(pI)
		createEvent(5, "WF_Instance_Handler", "despawnBuilding", pBuilding, "")
		deleteData("WF_Instance_Handler:playerInstance"..SceneObject(pPlayer):getObjectID())
	end
end

function WFporter:manageInstances(pPlayer, str, zone)
	local data
	if not(zone) then
		data = WF_Instance_Handler.instances[str]
		zone = data.zone
	end

	local pID = SceneObject(pPlayer):getObjectID() -- get Player id
	local pGID = math.floor(CreatureObject(pPlayer):getGroupID())
	local gI = readData("WF_Instance_Handler:groupBuilding"..pGID) -- get Group last Instance building ID
	local gItype = readStringData("WF_Instance_Handler:"..gI) --get group Instance Type
	local pI = readData("WF_Instance_Handler:playerInstance"..pID) -- get Player last Instance building ID
	local pItype = readStringData("WF_Instance_Handler:"..pI) -- get player last Instance type

	if (pGID == 0) then pGID = "Not Grouped" end
	if (gI == 0) then gI = "N/A" end
	if (gItype == "") then gItype = "N/A" end
	if (pI == 0) then pI = "N/A" end
	if (pItype == "") then pItype = "N/A" end


	local width = WF_Instance_Handler.zones[zone].instanceWidth
	local height = WF_Instance_Handler.zones[zone].instanceHeight
	local zoneHeight = WF_Instance_Handler.zones[zone].zoneHeight
	local zoneWidth = WF_Instance_Handler.zones[zone].zoneWidth
	local vOffset = 0
	local hOffset = width * -1
	local limit = false
	local buildings = {}
	local count = 0
	local i = 0
	local sui = SuiListBox.new("WFporter","manageInstancesCallback")
	while ( limit ~= true) do
		i = i + 1
		hOffset = hOffset + width
		if (hOffset > zoneWidth) then
			hOffset = 0
			vOffset = vOffset + height
			if (vOffset > zoneHeight) then
				limit = true
			end
		end
		local msg = ""
		local buildingID = readData("WF_Instance_Handler:"..zone..":inx"..i)
		if (buildingID ~= 0) then
			count = count + 1
			local iType = readStringData("WF_Instance_Handler:"..buildingID)
			sui.add("INX:("..i..")  ID:("..buildingID..")  Type:"..iType, buildingID)
		end
	end

	sui.setTitle("Instance Zone Management:")
	local msg = "Name:("..SceneObject(pPlayer):getDisplayedName()..")\n  Last Instance:("..pI..")  Type:("..pItype..")"
	msg = msg.."\n\nGroup ID:("..pGID..")\n  Last Group Instance:("..gI..")  Type:("..gItype..")"
	msg = msg.."\n\nInstances Active in Zone:("..zone..")"
	sui.setPrompt(msg)
	sui.sendTo(pPlayer)
end

function WFporter:manageInstancesCallback(pPlayer, pSui, eventIndex, args)
	--print("player inspect op2 ran")
	local cancelPressed = (eventIndex == 1)
	if (cancelPressed or args == nil) then
		return
	end

	local pPageData = LuaSuiBoxPage(pSui):getSuiPageData()
	if (pPageData == nil) then
		return
	end

	local suiPageData = LuaSuiPageData(pPageData)
	local pBuilding = getSceneObject(suiPageData:getStoredData(tostring(args)))
	if (pBuilding == nil) then return end

	WFporter:viewInstance(pBuilding, pPlayer)
end

function WFporter:viewLockingInstance(pPlayer, pSceneObject, instanceType)
	local sui = SuiMessageBox.new("WFporter","defaultCallback")
	sui.setTitle("Instance Status:")

	local pID = SceneObject(pPlayer):getObjectID() -- get Player id
	local pI = readData("WF_Instance_Handler:playerInstance"..pID) -- get Player last Instance building ID
	local pItype = readStringData("WF_Instance_Handler:"..pI) -- get player last Instance type
	local piZone = "N/A"

	if (pI == 0 or not(getSceneObject(pI))) then
		pI = "N/A"
	else
		piZone = SceneObject(getSceneObject(pI)):getZoneName()
	end
	if (pItype == "") then pItype = "N/A" end

	local msg = "Name:("..SceneObject(pPlayer):getDisplayedName()..")"
	msg = msg.."\n  Last Instance:("..pI..")  Type:("..pItype..")  In-Zone:("..piZone..")"
	sui.setPrompt(msg)
	sui.sendTo(pPlayer)
end

