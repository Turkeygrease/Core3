--[[ By: Michael Simnitt aka Mindsoft
Date: Oct/5/2018
Description: solo instance screenplay test
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]


---------------------------------------------(Solo Test Instance Event Screenplay & Spawn tables)
--spawnScaledMobile(Planet,Template,Respawn,X,Z,Y,Direction,CellID, ScaleType, ScaleFactor, Scale-or-Range )

-----------------------------------------------------------------Theed test

myInstancePlayName = ScreenPlay:new{}
registerScreenPlay("myInstancePlayName", false)
function myInstancePlayName:start(pBuilding)
	--print("(myInstancePlayName) Instance Screenplay started with Building Pointer:("..tostring(pBuilding)..")")
end

theedTestSP = ScreenPlay:new{
	scaleLockList = {
			--templateList, x,  z,  y,   f,  c, st, sf, rg/sc, lockCell
		{"gnarled_rancor",      0, 12, 45,   0,  7,  0,  5,   nil,  8},
		{"rancor/bull_rancor", 36, 12, 45, -90,  8,  1, .8,    70,  9},
		{"rancor/bull_rancor",-36, 12, 45,  90,  9,  1, .8,    70, 10},
	},

	spawnList = {
		  			--(t,  x, z,   y,    f, c)
		{"nightsister_rancor_tamer" , 19, 12, 78, -141, 4},
		{"nightsister_rancor_tamer" ,-22, 12, 75,  127, 5},
	},
}
registerScreenPlay("theedTestSP", false)
function theedTestSP:start(pBuilding)
	Ihelp:spawnScaleLockList(pBuilding, theedTestSP.scaleLockList)
	Ihelp:spawnList(pBuilding, theedTestSP.spawnList)

	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local mob = spawnScaledMobile(zone, "enraged_rancor", 0, 0, 12, 20, 0, bID+10, 2, 5, 90)
	createObserver(OBJECTDESTRUCTION, "theedTestSP", "triggerDead", mob)
end

function theedTestSP:triggerDead(trigger)
	local pBuilding = SceneObject(SceneObject(trigger):getParent()):getParent()
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local boss = spawnScaledMobile(zone, "boss_chuba", 0, 0, 19, -3, 0, bID+10, 0, 20)
	createObserver(OBJECTDESTRUCTION, "soloSPtest", "bossDead", boss)
	return 0
end

----------------------------------------------------------------Nova test

novaTestSP = ScreenPlay:new{}
registerScreenPlay("novaTestSP", false)
function novaTestSP:start(pBuilding)
	print("(novaTestSP) Instance Screenplay started with Building Pointer:("..tostring(pBuilding)..")", SceneObject(pBuilding):getObjectID())
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()

	--spawn greeter
	local pNpc = spawnMobile(zone, "bib_fortuna", 0, 9.3, -0.5, -1.1, 75, bID+1)
 	CreatureObject(pNpc):clearOptionBit(CONVERSABLE)
	writeData("NovaGreet",SceneObject(pNpc):getObjectID())

	createObserver(ENTEREDBUILDING, "novaTestSP", "onEnter", pBuilding)
	dropObserver(EXITEDBUILDING, "WF_Instance_Handler", "onExit", pBuilding)
	createObserver(EXITEDBUILDING, "novaTestSP", "onExit", pBuilding)

	local charter = spawnMobile(zone, "nova_hutt_charter", 0, 33.9, 0.8, -37.8, 37, bID+8)
	SceneObject(charter):setObjectMenuComponent("novaCharter")
end

function novaTestSP:onEnter(pBuilding, pPlayer)
	if (SceneObject(pPlayer):isPlayerCreature()) then
		local pMobile = getSceneObject(readData("NovaGreet"))
		if (pMobile and CreatureObject(pMobile):checkCooldownRecovery("NovaGreet")) then
	 		spatialChat(pMobile, "Welcome to Nova Orion!")
			CreatureObject(pMobile):addCooldown("NovaGreet", 180000)
		end
	end
	return 0
end

function novaTestSP:onExit(pBuilding, pPlayer)
	if (SceneObject(pPlayer):isPlayerCreature()) then
		local pGhost = CreatureObject(pPlayer):getPlayerObject()
		if (pGhost == nil) then
			return 0
		end

		if (PlayerObject(pGhost):hasTef()) then
			CreatureObject(pPlayer):sendSystemMessage("(You cannot Remain in Nova Orion while in TEF state)")
			WF_Instance_Handler:ejectPlayer(pPlayer)
			return 0
		end
	end
	return 0
end

novaCharter = {}
function novaCharter:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	if (PlayerObject(pGhost):hasTef()) then
		CreatureObject(pPlayer):sendSystemMessage("(You cannot do this while in TEF state)")
		return
	end

	local response = LuaObjectMenuResponse(pMenuResponse)

	response:addRadialMenuItem(101, 1, "Tatooine")
	response:addRadialMenuItemToRadialID(101,102,3,"Mos Eisley [0 Credits]")
	response:addRadialMenuItemToRadialID(101,103,3,"Mos Espa [2000 Credits]")
	response:addRadialMenuItemToRadialID(101,104,3,"Mos Entha [2000 Credits]")
	response:addRadialMenuItemToRadialID(101,105,3,"Bestine [2000 Credits]")

	response:addRadialMenuItem(106, 1, "Corellia")
	response:addRadialMenuItemToRadialID(106,107,3,"Coronet [2000 Credits]")
	response:addRadialMenuItemToRadialID(106,108,3,"Tyrena [2000 Credits]")
	response:addRadialMenuItemToRadialID(106,109,3,"Kor Vella [2000 Credits]")
	response:addRadialMenuItemToRadialID(106,110,3,"Doaba Guerfel [2000 Credits]")

	response:addRadialMenuItem(111, 1, "Naboo")
	response:addRadialMenuItemToRadialID(111,112,3,"Theed [2000 Credits]")
	response:addRadialMenuItemToRadialID(111,113,3,"Keren [2000 Credits]")
	response:addRadialMenuItemToRadialID(111,114,3,"Moenia [2000 Credits]")
	response:addRadialMenuItemToRadialID(111,115,3,"Kaadara [2000 Credits]")
end

-- player selection processing
function novaCharter:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (selectedID < 101) then
		return
	end

	if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
		CreatureObject(pPlayer):sendSystemMessage("(You cannot do this action in your current state)")
		return 0 
	end

	if not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 6) then
		CreatureObject(pPlayer):sendSystemMessage("(You are not in range to use this object)")
		return 0
	end

	local value = selectedID-101
	local position = {"tatooine",1,1,1}
	if (value == 1) then --mos eisley
		WF_Instance_Handler:ejectPlayer(pPlayer, "nova")
		return 0
	end

	local cost = 2000
	local player = CreatureObject(pPlayer)
	if (player == nil) then return 0 end

	if ((player:getCashCredits() + player:getBankCredits()) < cost) then
		player:sendSystemMessage("(You do not have enough credits for this transaction)")
		return 0
	end

	if (player:getCashCredits() >= 2000) then
		player:subtractCashCredits(cost)
	else
		local fromBank = cost - player:getCashCredits()
		player:subtractCashCredits(cost);
		player:setBankCredits(player:getBankCredits() - fromBank)
	end

	if (value == 2) then --mos epsa
		position = {"tatooine",-2814,5,2086}
	elseif (value == 3) then --mos entha
		position = {"tatooine",1243,7,3045}
	elseif (value == 4) then --bestine
		position = {"tatooine",-1386,12,-3590}

	elseif (value == 6) then --coronet
		position = {"corellia",-40,28,-4719}
	elseif (value == 7) then --tyrena
		position = {"corellia",-4980,21,-2213}
	elseif (value == 8) then --kor vella
		position = {"corellia",-3151,31,2904}
	elseif (value == 9) then --doaba guerfel
		position = {"corellia",3366,308,5621}

	elseif (value == 11) then --theed
		position = {"naboo",-4858,6,4166}
	elseif (value == 12) then --keren
		position = {"naboo",1343,13,2753}
	elseif (value == 13) then --moenia
		position = {"naboo",4710,4.2,-4658}
	elseif (value == 14) then --kaadara
		position = {"naboo",5307,-192,6680}

	else
		print("Error: in novaCharter, option value selected not in table",value)
		return 0
	end

	player:sendSystemMessage("(Charter to "..position[1]:gsub("^%l", string.upper).." purchased)")
 	LuaSceneObject(pPlayer):switchZone(position[1], WFnav:rndRng(position[2],2), position[3], WFnav:rndRng(position[4],2), 0)
end
----------------------------------------------------------------Daily test

soloSPtest = ScreenPlay:new{
	wps = { -- x      z      y      f  c
		{-0.5,    .3,   3.1,    1, 2}, -- top entry
		{ 3.6,   0.3,  -3.9, -101, 3}, -- top hall
		{-4.4,  -6.8,  -6.7,    0, 5}, -- first room
		{-5.4,  -6.8, -14.7,    0, 6}, -- second room
		{ 5.8,  -6.8,  -4.8,  180, 7}, -- third room
	},
	bossWP1 = {-2.5, -13.8, -13.8,  0, 9}, -- bottom boss
	mobiles = { -- 1 template for each spawn point, each table is another set of spawn options
		{"test_henchman","test_assassin","test_thug","test_henchman","test_enforcer","test_bh"},
		{"test_enforcer","test_henchman","test_assassin","test_thug","test_henchman","ig_test_droid"},
	},
}
registerScreenPlay("soloSPtest", false)
function soloSPtest:start(pBuilding)
	soloSPtest:spawnMobiles(pBuilding)
	--spawnSceneObjects()
	--startUpTests()
	--print("(soloSPtest) Instance Screenplay started with Building Pointer:("..tostring(pBuilding)..")")
end

function soloSPtest:spawnMobiles(pBuilding)
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local choice = math.random(#self.mobiles)
	local npc
	local wp
	for i = 0, #self.wps-1, 1 do
		i = i + 1
		wp = self.wps[i]
		npc = spawnMobile(zone, self.mobiles[choice][i], 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])
 		createObserver(OBJECTDESTRUCTION, "Ihelp", "mobKilled", npc)
		CreatureObject(npc):setScreenPlayState((wp[5]+1), str)	
		local pCell = getSceneObject(bID+wp[5]+1)
		SceneObject(pCell):setContainerInheritPermissionsFromParent(false)
		SceneObject(pCell):clearContainerDefaultDenyPermission(WALKIN)
		SceneObject(pCell):clearContainerDefaultAllowPermission(WALKIN)
	end
	wp = self.bossWP1
	npc = spawnMobile(zone, self.mobiles[choice][6], 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])
 	createObserver(OBJECTDESTRUCTION, "soloSPtest", "bossDead", npc)
end

function soloSPtest:bossDead(boss)
	local pBuilding = SceneObject(SceneObject(boss):getParent()):getParent()
	local bID = SceneObject(pBuilding):getObjectID()
	local instanceID = readData("WF_Instance_Handler:"..bID..":inx")
 	createEvent(90000, "WF_Instance_Handler", "despawnBuilding", pBuilding, "")
	return 0
end

function soloSPtest:spawnSceneObjects()
end

function soloSPtest:startUpTests()
end

function soloSPtest:instanceCleanUp()
end

function soloSPtest:instanceComplete()
end

function soloSPtest:instanceAborted()
end
