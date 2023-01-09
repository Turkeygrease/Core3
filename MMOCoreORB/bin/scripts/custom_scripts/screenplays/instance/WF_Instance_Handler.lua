--[[ By: Michael Simnitt aka Mindsoft
Date: Sep/24/2018
Description: Instance Handler
Distribution: This file and its Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]


---------------------------------------------(Instance Handler Event Screenplay & Spawn tables)

WF_Instance_Handler = ScreenPlay:new{
	heroics = false, --set to true when we get the heroic files done
	instances = require("instances"),
	zones = {
		dungeon1 = {
			instanceWidth = 1000,
			instanceHeight = 1000,
			defaultExitPoint = {"tatooine", 3498, 5, -4800, 0},
			zoneHeight = 16000,
			zoneWidth = 16000,
		},
		dungeon2 = {
			instanceWidth = 1000,
			instanceHeight = 1000,
			defaultExitPoint = {"tatooine", 3498, 5, -4800, 0},
			zoneHeight = 16000,
			zoneWidth = 16000,
		},
		
	},
	zoneNames = {
		"dungeon1",
		"dungeon2",
	},
}
registerScreenPlay("WF_Instance_Handler", true)

function WF_Instance_Handler:start() --WFporter:spawnPorter(p,t,r,x,z,y,f,c,name,instance,data)
	local pR2
	if (self.heroics) then
		--Heroic Dailies
		pR2 = WFporter:spawnPorter("tatooine", "r4", 1, 3534.3, 5, -4835.5, 43, 0, "Axkva Min Instance (TEST)", "axkva")
		pR2 = WFporter:spawnPorter("tatooine", "r4", 1, 3523.4, 5, -4771.7, 171, 0, "Exar Kun Instance (TEST)", "exar")
		pR2 = WFporter:spawnPorter("tatooine", "r3", 1, 3499.2, 5, -4812.2, 55, 0, "IG88 Instance (TEST)","ig88")
		--pR2 = WFporter:spawnPorter("tatooine", "r3", 1, 3519.7, 5, -4789.9, 80, 0, "Tusken Army Instance (TEST)","ta")

		--Mustifar Droid Instances
		pR2 = WFporter:spawnPorter("tatooine", "r5", 1, 3493.2, 5, -4772, 122, 0, "Decrepid Droid Factory (TEST)", "ddf")
		pR2 = WFporter:spawnPorter("tatooine", "r4", 1, 3534.4, 5, -4814.2, -54, 0, "Working Droid Factory (TEST)", "wdf")
		pR2 = WFporter:spawnPorter("tatooine", "r2", 1, 3534.7, 5, -4818, -148, 0, "Old Republic Facility (TEST)", "orf")

		--Mustifar Creature Instances
		pR2 = WFporter:spawnPorter("tatooine", "r3", 1, 3511.3, 5, -4779.1, -19, 0, "Mustifar Escape Tunnel (TEST)", "met")
		pR2 = WFporter:spawnPorter("tatooine", "r3", 1, 3486.8, 5, -4799.9, -30, 0, "Mustifar Lava Cave (TEST)", "lavaCave")

		--Obiwan + Chapter 8
		pR2 = WFporter:spawnPorter("tatooine", "r5", 1, 3503.3, 5, -4757.2, -176, 0, "Lair of the Crystal (TEST)", "lotc")
		pR2 = WFporter:spawnPorter("tatooine", "r3", 1, 3509.2, 5, -4799, -153, 0, "Uplink Cave (TEST)", "uplink")
	end

	--Vanilla Buildings
	--WFporter:spawnPorter("tatooine", "r4", 1, 3512.2, 5, -4818.5, 63, 0, "Corellian Corvette Instance(TEST)", "corvette")--pve
	--WFporter:spawnPorter("tatooine", "r5", 1, 3534.3, 5, -4789, -58, 0, "Theed Palace Instance GGC(TEST)", "theedPalace")--grpVgrp
	--WFporter:spawnPorter("tatooine", "r3", 1, 3502.5, 5, -4814.4, 20, 0, "War Room Instance (TEST)", "warRoom")--solo / group

	-- Imperial Corvette
		--WFporter:spawnPorter("tatooine", "r4", 1, 3535.6, 5, -4775.7, -167, 0, "Imp War Corvette", "corvette")

	-- Rebel Corvette
		--WFporter:spawnPorter("tatooine", "r3", 1, 3543.1, 5, -4780.6, -79, 0, "Rebel War Corvette", "corvette")

	-- PVP Corvette
		--WFporter:spawnPorter("tatooine", "r3", 1, 3502.5, 5, -4814.4, 20, 0, "GCW Corvette", "gcwCorvette")--pvp  only

	-- Nova Orion Public (open)
		WF_Instance_Handler:spawnOpen("nova") --spawn Nova Orion open world instance
	-- Heroic Public Cloner (open)
		WF_Instance_Handler:spawnOpen("neutralHeroicCloner")
	-- Heroic Imperial Cloner (open)
		WF_Instance_Handler:spawnOpen("impHeroicCloner")
	-- Heroic Rebel Cloner (open)
		WF_Instance_Handler:spawnOpen("rebHeroicCloner")

	-- Arena Graveyard
		-- (open area instance)
		--WFporter:spawnPorter("tatooine", "r5", 1, 3541.2, 5, -4815.7, -67, 0, "Graveyard [test]", "arena_graveyard")
		--WF_Instance_Handler:spawnOpen("arena_graveyard") --spawn Nova Orion open world instance


	-- Test Instances
		-- Test Ranch House (solo)
		--WFporter:spawnPorter("tatooine", "r4", 1, 3530.4, 5, -4775.3, -169, 0, "Ranch House(Solo [test])", "tatRanchHouse")
		-- Test Daily Dungeon (solo)
		WFporter:spawnPorter("tatooine", "r2", 1, 10.3, 0.4, -2.5, -89, 1280131, "Daily Dungeon(Solo [test])", "soloSPtest")
		-- Test Theed (group)
		--WFporter:spawnPorter("tatooine", "r5", 1, 3534.3, 5, -4789, -58, 0, "Theed Palace(Group [test])", "theedPalace")
	-- IG-88 Heroic
		-- (open Heroic)
		WFporter:spawnPorter("lok", "r2", 1, -7668, 91.8, 3507, 90, 0, "IG-88 (Open Arena)", "ig88Open")
		WF_Instance_Handler:spawnOpen("ig88Open") --spawn Nova Orion open world instance

		-- (Group Heroic)
		WFporter:spawnPorter("tatooine", "r3", 1, 10.3, 0.4, -4.2, -90, 1280131, "IG-88 (Group 4+)", "ig88Group")
	-- Axkva Min Heroic
		-- (Group Heroic)
		local door = spawnSceneObject("tatooine", "object/tangible/door/heroic_axkva_min_door.iff", -90.6, -101, -98.45, 4115629, math.rad(180))
		SceneObject(door):setObjectMenuComponent("WFporter")
		writeStringData(SceneObject(door):getObjectID().."InstanceType","axkvaGroup")

		--WFporter:spawnPorter("tatooine", "r5", 1, 3529.4, 5, -4775.3, -169, 0, "Axkva Min (Group 6+)", "axkvaGroup")

	-- Holiday GMF
		-- (open dungeon)
		WF_Instance_Handler:spawnOpen("moonFestivalOpen") --spawn GMF open world instance
		pR2 = WFporter:spawnPorter("tatooine", "undead_scout_trooper_m", 1, 3541.2, 5, -4815.7, -67, 0, "Holiday Event (Open)", "moonFestivalOpen")
		CreatureObject(pR2):setPvpStatusBitmask(0) --set to non-attackable

		-- (solo dungeon)
		--WFporter:spawnPorter("tatooine", "r5", 1, 3529.4, 5, -4775.3, -169, 0, "Holiday Event (Solo)", "moonFestivalSolo") --TODO

	-- Life Day (solo)
		pR2 = WFporter:spawnPorter("tatooine", "holiday_baby_wampa", 1, 3535.5, 5, -4778.5, 175, 0, "Holiday Event (Solo)", "life_day_solo")
		CreatureObject(pR2):setPvpStatusBitmask(0) --set to non-attackable

	-- Love Day (solo)
		pR2 = WFporter:spawnPorter("tatooine", "candy_graul", 1, 3540.8, 5, -4809.2, -82, 0, "Holiday Event (Solo)", "love_day_solo")
		CreatureObject(pR2):setPvpStatusBitmask(0) --set to non-attackable

	-- SoroSuub (solo)	
		--WFporter:spawnPorter("tatooine", "r2", 1, 10.3, 0.4, -5.9, -89, 1280131, "SoroSuub(Solo [test])", "soroSuubSolo")
		WF_Instance_Handler:spawnOpen("soroSuubSolo")

	-- ISD test
		WFporter:spawnPorter("tatooine", "r5", 1, 10.3, 0.4, -3.4, -89, 1280131, "Imperial Cloner [Test]", "impHeroicCloner")
		WFporter:spawnPorter("tatooine", "r5", 1, 10.3, 0.4, -1.7, -92, 1280131, "Rebel Cloner [Test]", "rebHeroicCloner")

end

function WF_Instance_Handler:spawnOpen(instanceType)
	local openInstance = readData("WF_Instance_Handler:openInstance:"..instanceType)
	if ((openInstance == 0) or (SceneObject(getSceneObject(openInstance)):getZoneName() == "")) then
		local data = WF_Instance_Handler.instances[instanceType]
		local nav = WFnav:getNav(data.zone)
		openInstance = WF_Instance_Handler:spawnInstance(instanceType, nav)
		if not(openInstance) then
			print("ERROR: Open World Instance Failed to Spawn @ WF_Instance_Handler.spawnOpen, Instance Failed to Create")
			return 0
		end
		writeData("WF_Instance_Handler:openInstance:"..instanceType,SceneObject(openInstance):getObjectID())
		print("[Instance Manager] Open Word Instance of type("..instanceType..") has been spawned")
	else
		print("ERROR: Open World Instance Failed to Spawn @ WF_Instance_Handler.spawnOpen, Instance already Exists")
	end
	return openInstance
end

-- build instance at first available spot in the zone
function WF_Instance_Handler:spawnInstance(str, pPlayer)
	local data = WF_Instance_Handler.instances[str]
	local iff = data.iff

	if (type(iff) == "table") then
		iff = iff[math.random(#iff)]
	end

	local pID = SceneObject(pPlayer):getObjectID()
	local gID
	if (CreatureObject(pPlayer):isGrouped()) then
		gID = math.floor(CreatureObject(pPlayer):getGroupID())
	else
		gID = pID
	end

	local zone = data.zone
	local width = WF_Instance_Handler.zones[zone].instanceWidth
	local height = WF_Instance_Handler.zones[zone].instanceHeight
	local zoneHeight = WF_Instance_Handler.zones[zone].zoneHeight
	local zoneWidth = WF_Instance_Handler.zones[zone].zoneWidth
	local vOffset = 500
	local hOffset = width * -1
	local found = 1
	local i = 0
	while ( found ~= 0 ) do
		i = i + 1
		hOffset = hOffset + width
		if (hOffset > zoneWidth) then
			hOffset = 0
			vOffset = vOffset + height
			if (vOffset > zoneHeight) then
				return 0
			end
		end
		found = readData("WF_Instance_Handler:"..zone..":inx"..i)
		--print("reading: "..tostring(i).." , Building ID found: "..tostring(found))
	end

	local pBuilding = spawnSceneObject(zone, iff,(-1 *(.5*zoneWidth))+hOffset, 0, (-1*(.5*zoneHeight))+vOffset, 0, 0, 0, 0, 0)
	if (pBuilding == nil) then
		return false
	end
	local buildingID = SceneObject(pBuilding):getObjectID()

	if (data.lockedCells) then
		foreach(data.lockedCells, function(cell)
			local pCell = BuildingObject(pBuilding):getCell(cell)
			if pCell ~= nil then
				SceneObject(pCell):setContainerInheritPermissionsFromParent(false)
				SceneObject(pCell):clearContainerDefaultDenyPermission(WALKIN)
				SceneObject(pCell):clearContainerDefaultAllowPermission(WALKIN)
			end
		end)
	end

	--print("Instance Building ID ("..tostring(buildingID)..") SAVED to Instance ID ("..tostring(i)..") , Group ID: "..tostring(gID))
	--print("hOffset: "..tostring(hOffset).." , vOffset: "..tostring(vOffset))
	writeStringData("WF_Instance_Handler:"..buildingID, str) --store instance type under building id
	writeData("WF_Instance_Handler:"..zone..":inx"..i, buildingID) --store building id under zone index
	writeData("WF_Instance_Handler:"..buildingID..":inx", i) --store zone index under building id
	writeData("WF_Instance_Handler:"..buildingID, gID) --store group id under building id
	createObserver(EXITEDBUILDING, "WF_Instance_Handler", "onExit", pBuilding)
	createObserver(ENTEREDBUILDING, "WF_Instance_Handler", "playerEntered", pBuilding)
	if (data.lockoutTimer) then
		createEvent(data.lockoutTimer, "WF_Instance_Handler", "despawnBuilding", pBuilding, "")
	end

	if not(data.noExit) then
		local loadCell
		if (data.playerSpawn) then
			loadCell = data.playerSpawn
		elseif (data.factionSpawns.exit) then
			loadCell = data.factionSpawns.exit
		end
		if (loadCell) then
			local pCell
			if (type(loadCell[4]) == "string") then
				loadCell[4] = BuildingObject(pBuilding):getNamedCell(loadCell[4])
			else
				pCell = BuildingObject(pBuilding):getCell(loadCell[4])
			end
			local cellID = SceneObject(pCell):getObjectID()
			local prtr = WFporter:spawnPorter(zone,"r2",-1,loadCell[1],loadCell[2],loadCell[3],45,cellID,"EXIT",str,"",pBuilding)
		end
	end
	if (data.screenplay) then
		local func = load('return '..data.screenplay)
		local SP = func()
		if (SP) then
			SP:start(pBuilding)
		end
	end
	return pBuilding
end

function WF_Instance_Handler:playerEntered(pBuilding, pPlayer)
	if (SceneObject(pPlayer):isPlayerCreature()) then
		dropObserver(LOGGEDIN, "WF_Instance_Handler", "onLoggedIn", pPlayer)
		createObserver(LOGGEDIN, "WF_Instance_Handler", "onLoggedIn", pPlayer, 1)
	end
	return 0
end

--get count of player group members in building
function WF_Instance_Handler:getGroupMembersInside(pBuilding, pPlayer)
	local playerCount = 0
 	local groupSize = CreatureObject(pPlayer):getGroupSize()
	for i = 0, groupSize - 1, 1 do
		if (SceneObject(CreatureObject(pPlayer):getGroupMember(i)):isPlayerCreature()) then
			playerCount = playerCount + 1
		end
	end
	return playerCount
end

--get count of players in building
function WF_Instance_Handler:getPlayerCountInside(pBuilding)
	local playerCount = 0
	for i = 1, BuildingObject(pBuilding):getTotalCellNumber(), 1 do
		local pCell = BuildingObject(pBuilding):getCell(i)
		if (pCell ~= nil) then
			for j = 1, SceneObject(pCell):getContainerObjectsSize(), 1 do
				local pObject = SceneObject(pCell):getContainerObject(j - 1)
				if (pObject ~= nil) then
					if SceneObject(pObject):isPlayerCreature() then
						playerCount = playerCount + 1
					end
				end
			end
		end
	end
	return playerCount
end

--get count of guild members in building
function WF_Instance_Handler:getGuildMembersInside(pBuilding, guildID) --TODO
	local playerCount = 0
	for i = 1, BuildingObject(pBuilding):getTotalCellNumber(), 1 do
		local pCell = BuildingObject(pBuilding):getCell(i)
		if (pCell ~= nil) then
			for j = 1, SceneObject(pCell):getContainerObjectsSize(), 1 do
				local pObject = SceneObject(pCell):getContainerObject(j - 1)
				if (pObject ~= nil) then
					if SceneObject(pObject):isPlayerCreature() then
						playerCount = playerCount + 1
					end
				end
			end
		end
	end
	return playerCount
end

--get building stats
function WF_Instance_Handler:getBuildingStats(pBuilding) --Developer Tool TODO add SUI
	local count = {
		instanceZone = SceneObject(pBuilding):getZoneName(),
		instanceType = readStringData("WF_Instance_Handler:"..SceneObject(pBuilding):getObjectID()), -- read instance type
		playerCount = 0,
		rebelCount = 0,
		imperialCount = 0,
		buildingCovertCount = 0,
		buildingOvertCount = 0,
		buildingPetCount = 0,
		buildingCreatureCount = 0,
		buildingCellCount = BuildingObject(pBuilding):getTotalCellNumber(),
		buildingObjectCount = 0,
	}
	for i = 1, count.buildingCellCount, 1 do
		local pCell = BuildingObject(pBuilding):getCell(i)
		if (pCell ~= nil) then
			for j = 1, SceneObject(pCell):getContainerObjectsSize(), 1 do
				local pObject = SceneObject(pCell):getContainerObject(j - 1)
				if (pObject ~= nil) then
					if (SceneObject(pObject):isCreatureObject()) then--is creature object
						count.buildingCreatureCount = count.buildingCreatureCount + 1
						if SceneObject(pObject):isPlayerCreature() then --is player?
							count.playerCount = count.playerCount + 1
							if (CreatureObject(pObject):isRebel()) then--is rebel?
								count.rebelCount = count.rebelCount + 1
							elseif (CreatureObject(pObject):isImperial()) then--is imperial?
								count.imperialCount = count.imperialCount + 1
							end
							if (CreatureObject(pObject):isOvert()) then--is overt?
								count.buildingOvertCount = count.buildingOvertCount + 1
							elseif (CreatureObject(pObject):isCovert()) then--is covert?
								count.buildingCovertCount = count.buildingCovertCount + 1
							end
						elseif (SceneObject(pObject):isAiAgent() and AiAgent(pObject):isPet()) then
							count.buildingPetCount = count.buildingPetCount + 1
						end
					else -- non creature object
						count.buildingObjectCount = count.buildingObjectCount + 1
					end
				end
			end
		end
	end
	return count
end

-- clean-up data+objects+spawns+players+instance
function WF_Instance_Handler:despawnBuilding(pBuilding)
	dropObserver(EXITEDBUILDING, "WF_Instance_Handler", "onExit", pBuilding)
	if (not(SceneObject(pBuilding)) or (SceneObject(pBuilding):getZoneName() == "")) then
		return 0
	end
	local buildingID = SceneObject(pBuilding):getObjectID()
	local instanceID = readData("WF_Instance_Handler:"..buildingID..":inx")
	local str = readStringData("WF_Instance_Handler:"..buildingID) -- get instance type
	local zone = SceneObject(pBuilding):getZoneName()
	local gID = readData("WF_Instance_Handler:"..buildingID) -- get group id
	local msg = "(Instance Timer Expired)\nYou have been ejected from the instance"
	for i = 1, BuildingObject(pBuilding):getTotalCellNumber(), 1 do
		local pCell = BuildingObject(pBuilding):getCell(i)
		if (pCell ~= nil) then
			for j = 1, SceneObject(pCell):getContainerObjectsSize(), 1 do
				local pObject
				if (SceneObject(pCell):getContainerObjectsSize() > (j-1)) then
					pObject = SceneObject(pCell):getContainerObject(j - 1)
				end
				if (pObject ~= nil) then
					if SceneObject(pObject):isPlayerCreature() then
						CreatureObject(pObject):sendSystemMessage(msg)
						createEvent(500, "WF_Instance_Handler" , "ejectPlayer", pObject, str)
					else -- clean up non-child and non-player objects
						if(SceneObject(pObject):isAiAgent() and not AiAgent(pObject):isPet()) then
							--print("Destroying Instance Object: "..SceneObject(pObject):getDisplayedName())
							forcePeace(pObject)
							SceneObject(pObject):destroyObjectFromWorld(true)
						end
					end
				end
			end
		end
	end
	deleteData("WF_Instance_Handler:"..zone..":inx"..instanceID)
	deleteStringData("WF_Instance_Handler:"..buildingID)
	deleteData("WF_Instance_Handler:"..buildingID)
	deleteData("WF_Instance_Handler:groupBuilding"..gID)
	deleteData("WF_Instance_Handler:"..buildingID..":inx")
	createEvent(1000, "WF_Instance_Handler", "destroyBuilding", pBuilding, instanceID)
end

-- eject player from instance
function WF_Instance_Handler:ejectPlayer(pPlayer, str)
	local zone = SceneObject(pPlayer):getZoneName()
	if (zone == "") then
		zone = "dungeon1" --default dungeon1
	end
	local data = WF_Instance_Handler.instances[str] or WF_Instance_Handler.instances["nova"] --default nova orion
	local exit
	if (data and data.exitPoint)then
		exit = data.exitPoint
	else
		exit = WF_Instance_Handler.zones[zone].defaultExitPoint  --{p, x, z, y, c},
	end

	CreatureObject(pPlayer):addCooldown("WF_Instance_Exit",5)
	SceneObject(pPlayer):switchZone(exit[1], WFnav:rndRng(exit[2],3), exit[3], WFnav:rndRng(exit[4],3), exit[5])
	CreatureObject(pPlayer):sendSystemMessage("(You have left the instance)")
end

--Player who was in an arena logged in (crash/restart/exploit)-FIX
function WF_Instance_Handler:onLoggedIn(pPlayer)
	local zone = CreatureObject(pPlayer):getZoneName()
	if (string.find(zone, "dungeon") ~= nil) then
		if (CreatureObject(pPlayer):getParentID() == 0) then
			WF_Instance_Handler:ejectPlayer(pPlayer)
		end
	else
 		dropObserver(LOGGEDIN, "WF_Instance_Handler", "onLoggedIn", pPlayer)
	end
	return 0
end

--player exited building
function WF_Instance_Handler:onExit(sceneObject, pCreature, cellID)
	if (sceneObject == nil or not SceneObject(pCreature):isPlayerCreature()) then
		return 0
	end

	if (CreatureObject(pCreature):isIncapacitated()) then
		CreatureObject(pCreature):sendSystemMessage("(Incap State Found)")
		return 0
	elseif (CreatureObject(pCreature):isDead()) then
		--CreatureObject(pCreature):sendSystemMessage("(Cloning to Nova Orion)")
		return 0
	end

	if not(CreatureObject(pCreature):checkCooldownRecovery("WF_Instance_Exit")) then
		return 0
	end
	local str = readStringData("WF_Instance_Handler:"..SceneObject(sceneObject):getObjectID())

	CreatureObject(pCreature):addCooldown("WF_Instance_Exit",5)
	createEvent(4, "WF_Instance_Handler", "ejectPlayer", pCreature, str)
	return 0
end

-- remove instance from zone
function WF_Instance_Handler:destroyBuilding(pBuilding, instanceID)
	SceneObject(pBuilding):destroyObjectFromWorld(true)
end
