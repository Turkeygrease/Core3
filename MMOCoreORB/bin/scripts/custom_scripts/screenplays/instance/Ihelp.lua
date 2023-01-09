--[[ By: Michael Simnitt aka Mindsoft
Date: Oct/16/2018
Description: instance screenplay helper API
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]

---------------------------------------------------------Instance Helper
Ihelp = {}
-- get instance objects parent building
function Ihelp:getBuilding(pSceneObject)
	return SceneObject(SceneObject(pSceneObject):getParent()):getParent()
end

--spawn a list of static non-respawning mobiles in building , note: list = { template, x, z, y, facing, cell# }
function Ihelp:spawnList(pBuilding, list)
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	for i = 1, #list, 1 do
		local wp = list[i]
		local tmpTable = HelperFuncs:splitString(wp[1], "/") --Split WP-table from string
		wp[1] = tmpTable[math.random(#tmpTable)]
		spawnMobile(zone, wp[1], 0, wp[2], wp[3], wp[4], wp[5], bID+wp[6])
	end
end

--spawn a list of static respawning mobiles in building , note: list = { template, x, z, y, facing, cell# }
function Ihelp:spawnListWithRespawn(pBuilding, list, rMin, rMax)
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	for i = 1, #list, 1 do
		local wp = list[i]
		local tmpTable = HelperFuncs:splitString(wp[1], "/") --Split WP-table from string
		wp[1] = tmpTable[math.random(#tmpTable)]
		spawnMobile(zone, wp[1], (rMin + math.random(rMax-rMin)), wp[2], wp[3], wp[4], wp[5], bID+wp[6])-- 3-9min respawn
	end
end

--spawn a list of static non-respawning scaling-mobiles in building , note: list = { template, x, z, y, facing, cell#, st, sf, s/r, lc}
function Ihelp:spawnScaleLockList(pBuilding, list)
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local str = readStringData("WF_Instance_Handler:"..bID)
	for i = 1, #list, 1 do
		local wp = list[i]
		local tmpTable = HelperFuncs:splitString(wp[1], "/") --Split WP-table from string
		wp[1] = tmpTable[math.random(#tmpTable)]
		wp[10] = wp[10] or (wp[6]+1)
		local npc = spawnScaledMobile(zone, wp[1], 0, wp[2], wp[3], wp[4], wp[5], bID+wp[6], wp[7], wp[8], wp[9], wp[10])
		local pCell = getSceneObject(bID+wp[10])
		CreatureObject(npc):setScreenPlayState(wp[10], str)
 		createObserver(OBJECTDESTRUCTION, "Ihelp", "mobKilled", npc)
		SceneObject(pCell):setContainerInheritPermissionsFromParent(false)
		SceneObject(pCell):clearContainerDefaultDenyPermission(WALKIN)
		SceneObject(pCell):clearContainerDefaultAllowPermission(WALKIN)
	end
end

--process boss HAM phases
function Ihelp:boss_damage(pBoss, pPlayer)
	if (SceneObject(pBoss):getZoneName() == "")then
		return 0
	end
	local pBuilding = Ihelp:getBuilding(pBoss)
	local bID = SceneObject(pBuilding):getObjectID()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local sp = WF_Instance_Handler.instances[str].screenplay
	local phases = _G[sp].phases
	local leashDistance = _G[sp].leashDistance
	if (leashDistance and Ihelp:testLeash(pBoss, 0, -18, leashDistance)) then
		Ihelp:despawnBoss(pBoss)
	end

	local state = CreatureObject(pBoss):getScreenPlayState(str)+1
	if (phases[state] == nil) then
		dropObserver(DAMAGERECEIVED,"Ihelp","boss_damage", pBoss)
		return 0
	end
	local phase = phases[state]
	local damageTest = phase.damageLimit

	if (Ihelp:testDamage(pBoss, damageTest)) then
		local zone = SceneObject(pBuilding):getZoneName()
		local list = phase.spawns or {}
		local taunts = list.spawnTaunts
		local DDlist = CreatureObject(pBoss):getDamageDealerList() --damage threat map
		for i = 1, #list, 1 do
			local wp = list[i]
			local pAdd = spawnMobile(zone, wp[1], 0, wp[2], wp[3], wp[4], wp[5], bID+wp[6])
			writeData(str..":"..state..":"..bID..":"..i,SceneObject(pAdd):getObjectID())
			local target = DDlist[math.random(#DDlist)]
			CreatureObject(pAdd):engageCombat(target)
			if (taunts) then
				local taunt = taunts[math.random(#taunts)]
				spatialChat(pAdd, taunt)
			end
			if (wp.script) then
				wp:script(pAdd)
			end
		end
		spatialChat(pBoss, phase.taunt)
		CreatureObject(pBoss):setScreenPlayState(state, str)
		if (phase.script) then
			phase.script(pBoss)
		end
	end
	return 0
end

--process Custom-Named boss HAM phases (note: make sure that custom mobile name matches table)
function Ihelp:custom_named_boss_damage(pBoss, pPlayer)
	if (SceneObject(pBoss):getZoneName() == "")then
		return 0
	end
	local pBuilding = Ihelp:getBuilding(pBoss)
	local bID = SceneObject(pBuilding):getObjectID()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local sp = WF_Instance_Handler.instances[str].screenplay
	local bossName = SceneObject(pBoss):getCustomObjectName()
	if (bossName == "") then 
		bossName = SceneObject(pBoss):getObjectName()
	else
		bossName = string.gsub(bossName, "%s+", "_")
	end
	local phases = _G[sp][bossName].phases
	local leashDistance = _G[sp].leashDistance
	if (leashDistance and Ihelp:testLeash(pBoss, 0, -18, leashDistance)) then
		Ihelp:despawnNamedBoss(pBoss)
	end

	local state = CreatureObject(pBoss):getScreenPlayState(str)+1
	if (phases[state] == nil) then
		dropObserver(DAMAGERECEIVED,"Ihelp","boss_damage", pBoss)
		return 0
	end
	local phase = phases[state]
	local damageTest = phase.damageLimit

	if (Ihelp:testDamage(pBoss, damageTest)) then
		local zone = SceneObject(pBuilding):getZoneName()
		local list = phase.spawns or {}
		local taunts = list.spawnTaunts
		local DDlist = CreatureObject(pBoss):getDamageDealerList() --damage threat map
		for i = 1, #list, 1 do
			local wp = list[i]
			local pAdd = spawnMobile(zone, wp[1], 0, wp[2], wp[3], wp[4], wp[5], bID+wp[6])
			writeData(bossName..":"..state..":"..bID..":"..i,SceneObject(pAdd):getObjectID())
			local target = DDlist[math.random(#DDlist)]
			CreatureObject(pAdd):engageCombat(target)
			if (taunts) then
				local taunt = taunts[math.random(#taunts)]
				spatialChat(pAdd, taunt)
			end
			if (wp.script) then
				wp:script(pAdd)
			end
		end
		if (phase.taunt) then
			spatialChat(pBoss, phase.taunt)
		end
		CreatureObject(pBoss):setScreenPlayState(state, str)
		if (phase.script) then
			phase.script(pBoss)
		end
	end
	return 0
end

--Trigger Death Event
function Ihelp:notifyNamedBossTriggerDead(pTrigger, bossName)
	if (SceneObject(pTrigger):getZoneName() == "")then
		return 0
	end
	local pBuilding = Ihelp:getBuilding(pTrigger)
	local zone = SceneObject(pBuilding):getZoneName()
	local bID = SceneObject(pBuilding):getObjectID()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local sp = WF_Instance_Handler.instances[str].screenplay
	local wp = _G[sp][bossName].spawn
        local pBoss = spawnMobile(zone, wp[1],0,wp[2],wp[3],wp[4],wp[5],bID+wp[6])
	if (_G[sp][bossName].intro) then
		spatialChat(pBoss, _G[sp][bossName].intro)
	end
	if (_G[sp][bossName].script) then
		_G[sp][bossName]:script(pBoss)
	end
	createObserver(DAMAGERECEIVED,"Ihelp","custom_named_boss_damage", pBoss)
	createObserver(OBJECTDESTRUCTION, "Ihelp", "notifyNamedBossDead", pBoss)
	createEvent(wp[8]*1000, "Ihelp", "despawnNamedBoss", pBoss,"")--Boss Despawn Timer
	return 0
end

--Boss Death Event
function Ihelp:notifyNamedBossDead(pBoss, pPlayer)
	if (SceneObject(pBoss):getZoneName() == "")then
		return 0
	end
	local pBuilding = Ihelp:getBuilding(pBoss)
	local bossName = SceneObject(pBoss):getCustomObjectName()
	if (bossName == "") then
		bossName = SceneObject(pBoss):getObjectName()
	else
		bossName = string.gsub(bossName, "%s+", "_")	
	end
	Ihelp:resetNamedBoss(pBuilding, bossName)
	return 0
end

--locking cell mob killed
function Ihelp:mobKilled(pMob, pPlayer)
	if (SceneObject(pMob):getZoneName() == "")then
		return 0
	end
	local pBuilding = Ihelp:getBuilding(pMob)
	local bID = SceneObject(pBuilding):getObjectID()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local state = CreatureObject(pMob):getScreenPlayState(str)
	local pCell = getSceneObject(bID+state)
	if (pCell) then
		SceneObject(pCell):setContainerInheritPermissionsFromParent(true)
		BuildingObject(pBuilding):broadcastSpecificCellPermissions(SceneObject(pCell):getObjectID())
	end
	return 0
end

--test ham damage, return true if HAM damage is <= damagetest
function Ihelp:testDamage(pBoss, damageTest)
	local boss = CreatureObject(pBoss)
	local bossHealth = boss:getHAM(0) / boss:getMaxHAM(0)
	local bossAction = boss:getHAM(3) / boss:getMaxHAM(3)
	local bossMind = boss:getHAM(6) / boss:getMaxHAM(6)
	if ((bossHealth <= damageTest) or (bossAction <= damageTest) or (bossMind <= damageTest)) then
		return true
	end
	return false
end

--test leash distance, return true if past maxdistance
function Ihelp:testLeash(pBoss, bX, bY, maxDistance)
	local boss = CreatureObject(pBoss)
	local x = boss:getPositionX() - bX
	local y = boss:getPositionY() - bY
	local distance = (x*x) + (y*y)
	if (distance > (maxDistance * maxDistance)) then	
		return true
	end
	return false
end

--spawn/respawn boss trigger
function Ihelp:spawnNamedBossTrigger(pBuilding, bossName)
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local sp = WF_Instance_Handler.instances[str].screenplay
	local wp = _G[sp][bossName].trigger
	local pTrigger = spawnMobile(zone, wp[1],0,wp[2],wp[3],wp[4],wp[5],bID+wp[6])
        createObserver(OBJECTDESTRUCTION, sp, "notifyTrigger"..bossName.."Dead", pTrigger)
	return pTrigger
end

--despawn instance boss
function Ihelp:despawnBoss(pBoss)
	if ((not SceneObject(pBoss)) or CreatureObject(pBoss):isDead()) then
		return 0
	end
	local pBuilding = Ihelp:getBuilding(pBoss)
	local str = readStringData("WF_Instance_Handler:"..SceneObject(pBuilding):getObjectID())
	local sp = WF_Instance_Handler.instances[str].screenplay
	forcePeace(pBoss)
	SceneObject(pBoss):destroyObjectFromWorld()
	_G[sp]:resetScreenplayStatus(pBuilding)
	return 0
end

--despawn custom-named instance boss
function Ihelp:despawnNamedBoss(pBoss)
	if ((not SceneObject(pBoss)) or CreatureObject(pBoss):isDead()) then
		return 0
	end
	local pBuilding = Ihelp:getBuilding(pBoss)
	local str = readStringData("WF_Instance_Handler:"..SceneObject(pBuilding):getObjectID())
	local bossName = SceneObject(pBoss):getCustomObjectName()
	if (bossName == "") then
		bossName = SceneObject(pBoss):getObjectName()
	else
		bossName = string.gsub(bossName, "%s+", "_")	
	end
	forcePeace(pBoss)
	SceneObject(pBoss):destroyObjectFromWorld()
	Ihelp:resetNamedBoss(pBuilding, bossName)
	return 0
end

--despawn instance adds by count
function Ihelp:despawnAdds(pBuilding)
	local bID = SceneObject(pBuilding):getObjectID()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local sp = WF_Instance_Handler.instances[str].screenplay
	local phases = _G[sp].phases
	local counter = 0
	for state,phase in pairs(phases) do
		if (phase.spawns) then
			for i = 1, #phase.spawns, 1 do
				counter = counter + 1
				local add = readData(str..":"..state..":"..bID..":"..i)
				deleteData(str..":adds:"..bID..i)
				local pAdd = getSceneObject(add)
				if ((add ~= 0) and pAdd) then
					if not(CreatureObject(pAdd):isDead()) then
						forcePeace(pAdd)
						SceneObject(pAdd):destroyObjectFromWorld()
					end
				end
			end
		end
	end
	return 0
end

--despawn instance adds by count
function Ihelp:despawnNamedBossAdds(pBuilding, bossName)
	local bID = SceneObject(pBuilding):getObjectID()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local sp = WF_Instance_Handler.instances[str].screenplay
	local phases = _G[sp][bossName].phases
	local counter = 0
	for state,phase in pairs(phases) do
		if (phase.spawns) then
			for i = 1, #phase.spawns, 1 do
				counter = counter + 1
				local add = readData(bossName..":"..state..":"..bID..":"..i)
				deleteData(bossName..":adds:"..bID..i)
				local pAdd = getSceneObject(add)
				if ((add ~= 0) and pAdd) then
					if not(CreatureObject(pAdd):isDead()) then
						forcePeace(pAdd)
						SceneObject(pAdd):destroyObjectFromWorld()
					end
				end
			end
		end
	end
	return 0
end

--Reset Named Boss
function Ihelp:resetNamedBoss(pBuilding, bossName)
	local str = readStringData("WF_Instance_Handler:"..SceneObject(pBuilding):getObjectID())
	local sp = WF_Instance_Handler.instances[str].screenplay
	createEvent(6000, "Ihelp", "despawnNamedBossAdds", pBuilding, bossName)
	createEvent(_G[sp][bossName].spawn[7]*1000, "Ihelp", "spawnNamedBossTrigger", pBuilding, bossName)
	return 0
end

function Ihelp:chatEvent(pBoss, message)
	if (SceneObject(pBoss):getZoneName() == "") then
		return 0
	end
	spatialChat(pBoss, message)
	return 0
end

function Ihelp:chatEventMood(pCreo, messageString)
	--spatialChat(SceneObject, message, moodType, chat type)
	local message =  HelperFuncs:splitString(messageString, "/")
	spatialMoodChat(pCreo, message[1], message[2], message[3])
	if (message[4]) then
		CreatureObject(pCreo):doAnimation(message[4])
	end
	return 0
end

function Ihelp:destroy(pSob)
	if ((SceneObject(pSob) ~= nil) and (SceneObject(pSob):getZoneName() ~= "")) then
		SceneObject(pSob):destroyObjectFromWorld()
	end
	return 0
end
