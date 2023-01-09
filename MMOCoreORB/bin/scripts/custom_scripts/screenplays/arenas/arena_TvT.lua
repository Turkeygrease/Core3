arena_TvT = ScreenPlay:new{
	gateTimer = 30, -- time from spawn until gates objects are destroyed
	wonDespawnTimer = 15, --Reshedule timer to despawn to this time if win result
	arenas = {},
}
registerScreenPlay("arena_TvT", false)

function arena_TvT:start()
	print("Arena [Team Vs Team] Handler has been started")
end

--mhealer, sLeader, dps
--Sort Player or Group into proper Que
function arena_TvT:queWaiting(pPlayer, spString)
	print("tvt que:",pPlayer,spString)
	if not(CreatureObject(pPlayer):checkCooldownRecovery(spString)) then
		CreatureObject(pPlayer):sendSystemMessage("Arena: You have already joined the Arena Queue.")
		return 0
	end

	local SP = _G[spString]

	if (not arena_handler:validatePlayer(pPlayer)) then --validate player status
		return 0
	end

	local playerZone = SceneObject(pPlayer):getZoneName()
	if (not arena_handler.allowedQuePlanets[playerZone]) then
		CreatureObject(pPlayer):sendSystemMessage("Arena: You Cannot join arenas from this zone.")
		return 0
	end

	local ID = ""
	if (CreatureObject(pPlayer):isGrouped()) then
		ID = CreatureObject(pPlayer):getGroupID()
		local gOB = LuaGroupObject(getSceneObject(ID))
		if (pPlayer ~= gOB:getLeader()) then
			CreatureObject(pPlayer):sendSystemMessage("Arena: You Must be leader to Queue your group.")
			return 0
		end
		CreatureObject(pPlayer):sendSystemMessage("Arena: Your group has been added to the Queue.")
	else
		ID = SceneObject(pPlayer):getObjectID()
		CreatureObject(pPlayer):sendSystemMessage("Arena: You have been added to the Queue.")
	end

	CreatureObject(pPlayer):addCooldown(spString, (SP.inviteTimer+1)*1000)

	print("Adding ID to Waiting Que: "..tostring(ID))
	local que = readStringData("WF_Arena:"..spString..":waitingQue")
	if (que == "") then
		que = tostring(ID)
	else
		que = tostring(ID)..","..que
	end
	writeStringData("WF_Arena:"..spString..":waitingQue", que)
	print("Waiting:", readStringData("WF_Arena:"..spString..":waitingQue"))
end

--Build Arena
function arena_TvT:build(spString, g1, g2)
	print("build:",spString,g1,g2)
	local arenaTable = arena_TvT:getArena(spString)
	if (arenaTable == false) then
		return false
	end

	local arenaOB = arenaTable.arenaOB
	local pControl = arenaTable.control
	local controlID = SceneObject(pControl):getObjectID()
	local arena = arenaTable.arena
	local dataStr = arenaTable.dataStr
	local group1 = 0
	local group2 = 0

	--Start Screenplay
	_G[arenaOB.screenplay]:start(pControl,dataStr)
	print(" * LOADING ARENA:",tostring(arena[3]),tostring(arena[4]),tostring(arena[5]),tostring(arena[6])," * ")

	--red group builder
	local leader = false
	for inx, plr in ipairs(g1) do
		local sOB = SceneObject(plr)
		if (sOB:isPlayerCreature()) then
			--disband from old group if grouped
			if (CreatureObject(plr):isGrouped()) then
				local gID = CreatureObject(plr):getGroupID()
				local gOb = LuaGroupObject(getSceneObject(gID))
				if (gOb:getNumberOfPlayerMembers() < 3) then
					gOb:disband()
				else
					CreatureObject(plr):ungroupTargetCreature(plr)
				end
			end

			--form blue group
			if (leader and (leader ~= plr)) then
				CreatureObject(leader):formGroupWithCreature(plr)
			else
				leader = plr
			end

			local pID = tostring(sOB:getObjectID())
			writeData(pID..":BoundArena", controlID) --store controller id on player id
			createEvent((math.random(5)+5)*100, "arena_handler", "setTef", plr, "")
			createEvent(arena_TvT.gateTimer * 1000, "arena_handler", "playSound", plr, "sound/ui_combat_engaged_01_droid.snd") --Schedule Combat Announcer
			createEvent((240 + math.random(30)) * 1000, "arena_handler", "updateJediTEF", plr, "")

			dropObserver(PLAYERKILLED, "arena_TvT", "redKilled", plr)
			createObserver(PLAYERKILLED, "arena_TvT", "redKilled", plr)
			dropObserver(LOGGEDIN, "arena_handler", "onLoggedIn", plr)
			createObserver(LOGGEDIN, "arena_handler", "onLoggedIn", plr, 1)

			deleteStringData(pID..":arenaReturn")
			if (sOB:getParentID() == 0) then --store players world position for return OUTSIDE
				local msg = sOB:getZoneName()..","..tostring(sOB:getWorldPositionX())..","..tostring(sOB:getWorldPositionZ())..","..tostring(sOB:getWorldPositionY())..",0"
				writeStringData(pID..":arenaReturn", msg)
			else --store players cell position for return INSIDE
				local pBid = CreatureObject(plr):getBuildingParentID()
				local pBld = getSceneObject(pBid)
				if (pBld and SceneObject(pBld):isBuildingObject()) then
					local ownerID = LuaBuildingObject(pBld):getOwnerID()
					if ((ownerID ~= 0) and SceneObject(getSceneObject(ownerID)):isPlayerCreature()) then
						local msg = sOB:getZoneName()..","..tostring(sOB:getPositionX())..","..tostring(sOB:getPositionZ())..","..tostring(sOB:getPositionY())..","..tostring(sOB:getParentID())
						writeStringData(pID..":arenaReturn", msg)
					end
				end
			end
			sOB:switchZone(arena[2], WFnav:rndRng((arena[3]+arenaOB.redStart[1]), 10), arena[4], WFnav:rndRng((arena[5]+arenaOB.blueStart[2]), 10), 0)
		end
	end

	if (not leader) then
		return 0
	end
	group1 = CreatureObject(leader):getGroupID()
	CreatureObject(leader):setGroupLock(1)

	--blue group builder
	leader = false
	for inx, plr in ipairs(g2) do
		local sOB = SceneObject(plr)
		if (sOB:isPlayerCreature()) then
			--disband from old group if grouped
			if (CreatureObject(plr):isGrouped()) then
				local gID = CreatureObject(plr):getGroupID()
				local gOb = LuaGroupObject(getSceneObject(gID))
				if (gOb:getNumberOfPlayerMembers() < 3) then
					gOb:disband()
				else
					CreatureObject(plr):ungroupTargetCreature(plr)
				end
			end

			--form blue group
			if (leader) then
				CreatureObject(leader):formGroupWithCreature(plr)
			else
				leader = plr
			end
			local pID = tostring(sOB:getObjectID())
			writeData(pID..":BoundArena", controlID) --store controller id on player id
			createEvent((math.random(5)+5)*100, "arena_handler", "setTef", plr, "")
			createEvent(arena_TvT.gateTimer * 1000, "arena_handler", "playSound", plr, "sound/ui_combat_engaged_01_droid.snd") --Schedule Combat Announcer
			createEvent((240 + math.random(30)) * 1000, "arena_handler", "updateJediTEF", plr, "")

			dropObserver(PLAYERKILLED, "arena_TvT", "blueKilled", plr)
			createObserver(PLAYERKILLED, "arena_TvT", "blueKilled", plr)
			dropObserver(LOGGEDIN, "arena_handler", "onLoggedIn", plr)
			createObserver(LOGGEDIN, "arena_handler", "onLoggedIn", plr, 1)


			deleteStringData(pID..":arenaReturn")
			if (sOB:getParentID() == 0) then --store players world position for return OUTSIDE
				local msg = sOB:getZoneName()..","..tostring(sOB:getWorldPositionX())..","..tostring(sOB:getWorldPositionZ())..","..tostring(sOB:getWorldPositionY())..",0"
				writeStringData(pID..":arenaReturn", msg)
			else --store players cell position for return INSIDE
				local pBid = CreatureObject(plr):getBuildingParentID()
				local pBld = getSceneObject(pBid)
				if (pBld and SceneObject(pBld):isBuildingObject()) then
					local ownerID = LuaBuildingObject(pBld):getOwnerID()
					if ((ownerID ~= 0) and SceneObject(getSceneObject(ownerID)):isPlayerCreature()) then
						local msg = sOB:getZoneName()..","..tostring(sOB:getPositionX())..","..tostring(sOB:getPositionZ())..","..tostring(sOB:getPositionY())..","..tostring(sOB:getParentID())
						writeStringData(pID..":arenaReturn", msg)
					end
				end
			end
			sOB:switchZone(arena[2], WFnav:rndRng((arena[3]+arenaOB.blueStart[1]), 10), arena[4], WFnav:rndRng((arena[5]+arenaOB.blueStart[2]), 10), 0)
		end
	end
	if (leader) then
		group2 = CreatureObject(leader):getGroupID()
		CreatureObject(leader):setGroupLock(1)
	end

	writeData(dataStr..":g1", group1) --store group1 in instance string g1
	writeData(dataStr..":g2", group2) --store group2 in instance string g2

	createEvent(arena_TvT.gateTimer * 1000, "arena_handler", "messageGroup", getSceneObject(group1), "Match Started")
	createEvent(arena_TvT.gateTimer * 1000, "arena_handler", "messageGroup", getSceneObject(group2), "Match Started")

	return pControl
end

--Get Next Available Random Arena from Screenplay
function arena_TvT:getArena(handlerStr)
	local handler = _G[handlerStr]
	local arenaDespawn = handler.despawnTimer
	local gateDespawn = arena_TvT.gateTimer


	--Randomly Select arena and area
	local arenaOB = handler.arenas[math.random(#handler.arenas)] -- Get Random Arena
	local areaName = arenaOB.areas[math.random(#arenaOB.areas)] -- Get Random Area

	--Get Free Index in area
	local arena = arena_handler:getArena(areaName) -- Get Open Arena Index in Area
	if (arena == false) then
		print("\nERROR: arena not found")
		--arena not found--TODO Add in Cyclical area test
		return false
	end

	--spawn arena
	local pControl = spawnSceneObject(arena[2], arenaOB.iff, arena[3], arena[4], arena[5], 0, 0) --Spawn Arena Object
	createObserver(OBJECTREMOVEDFROMZONE, "arena_handler", "destroyArena", pControl)
	SceneObject(pControl):addPendingTask((arenaDespawn + gateDespawn + 2) * 1000, "Ihelp", "destroy")--Handle instance removal and cleanup

	--spawn gates
	local gateOB = arenaOB.gateObjects -- Get Gate Objects
	for k, v in ipairs(gateOB) do -- Spawn Gate Objects
		local gate = spawnSceneObject(arena[2], v[1], arena[3]+v[2], arena[4]+v[3], arena[5]+v[4], 0, math.rad(v[5]))
		createEvent((gateDespawn) * 1000, "Ihelp", "destroy", gate, "") --Set Gate Objects Despawn
	end

	--spawn Red Area
	local redArea = arenaOB.redStart
	local pRedArea = spawnSceneObject(arena[2], "object/active_area.iff", arena[3]+redArea[1], arena[4], arena[5]+redArea[2], 0, math.rad(0))
	if (pRedArea ~= nil) then
		local activeArea = LuaActiveArea(pRedArea)
		activeArea:setCellObjectID(0)
		activeArea:setRectangular(redArea[3]*2, redArea[3]*2)
		createObserver(ENTEREDAREA, "arena_TvT", "enter", pRedArea)
		createObserver(EXITEDAREA, "arena_TvT", "exit", pRedArea)
	end

	--spawn Blue Area
	local blueArea = arenaOB.blueStart
	local pBlueArea = spawnSceneObject(arena[2], "object/active_area.iff", arena[3]+blueArea[1], arena[4], arena[5]+blueArea[2], 0, math.rad(0))	
	if (pBlueArea ~= nil) then
		local activeArea = LuaActiveArea(pBlueArea)
		activeArea:setCellObjectID(0)
		activeArea:setRectangular(blueArea[3]*2, blueArea[3]*2)
		createObserver(ENTEREDAREA, "arena_TvT", "enter", pBlueArea)
		createObserver(EXITEDAREA, "arena_TvT", "exit", pBlueArea)
	end

	--spawn Combat Area
	local pCombatArea = spawnSceneObject(arena[2], "object/active_area.iff", arena[3], arena[4], arena[5], 0, math.rad(0))
	if (pCombatArea ~= nil) then
		local combatAreaSize = arenaOB.arenaControlArea
		local activeArea = LuaActiveArea(pCombatArea)
		activeArea:setCellObjectID(0)
		activeArea:setRectangular(combatAreaSize*2, combatAreaSize*2)
		createObserver(ENTEREDAREA, "arena_TvT", "enter", pCombatArea)
		createObserver(EXITEDAREA, "arena_TvT", "exit", pCombatArea)
	end

	--spawn Scoreboard Controller
	local SB = arenaOB.scoreboard
	local pSBControl = spawnSceneObject(arena[2], "object/tangible/theme_park/invisible_object.iff", arena[3]+SB[1], arena[4]+SB[2], arena[5]+SB[3], 0, math.rad(180))
	arena_handler:initializeScoreboard(gateDespawn, pSBControl, arena[2], arena[3]+SB[1], arena[4]+SB[2], arena[5]+SB[3])
	createEvent((gateDespawn+1) * 1000, "arena_handler", "setScoreboard", pSBControl, arenaDespawn) --Schedule Scoreboard Activation

	--Select Random Layout
	local layout = arenaOB.layouts[math.random(#arenaOB.layouts)]
	local idStr = ""
	for k, v in ipairs(layout) do -- Spawn Layout Objects
		local layOb = spawnSceneObject(arena[2], v[1], arena[3]+v[2], arena[4]+v[3], arena[5]+v[4], 0, math.rad(v[5]))
		if (idStr == "") then
			idStr = tostring(SceneObject(layOb):getObjectID())
		else
			idStr = idStr.."/"..tostring(SceneObject(layOb):getObjectID()) --Store object id in deco string for clean-up
		end
	end

	--Saved Data to shared memory
	local dataStr = areaName..":inx:"..tostring(arena[6]) --instance string
	writeData(dataStr, SceneObject(pControl):getObjectID()) --store building id in instance string
	writeStringData(tostring(SceneObject(pControl):getObjectID())..":dataStr", dataStr) --store instance string in building id
	deleteData(dataStr..":g1") --clear group1 in instance string g1
	deleteData(dataStr..":g2") --clear group2 in instance string g2
	writeStringData(dataStr..":deco", idStr) --store layout-objects in instance string deco
	writeData(dataStr..":SB", SceneObject(pSBControl):getObjectID()) --store Scoreboard Controller in instance string SB
	writeData(dataStr..":combatArea", SceneObject(pCombatArea):getObjectID()) --store Combat Area in instance string combatArea
	writeData(dataStr..":redArea", SceneObject(pRedArea):getObjectID()) --store Red Spawn Area in instance string redArea
	writeData(dataStr..":blueArea", SceneObject(pBlueArea):getObjectID()) --store Blue Spawn Area in instance string blueArea
	writeData(dataStr..":winScore", arenaOB.winScore) --store Blue Spawn Area in instance string blueArea

	return {["control"]= pControl, ["arenaOB"]= arenaOB, ["arena"]= arena, ["dataStr"]= dataStr}
end

--red team member death observer
function arena_TvT:redKilled(pPlayer, pKiller)
	print("red Player killed", pPlayer, pKiller)
	local controlID = readData(tostring(SceneObject(pPlayer):getObjectID())..":BoundArena")
	local dataStr = readStringData(tostring(controlID)..":dataStr")
	local pSBControl = getSceneObject(readData(dataStr..":SB"))

	if (pSBControl) then
		local pControl = getSceneObject(controlID)
		local winScore = readData(dataStr..":winScore")
		local blueScore = arena_handler:getBlueScore(pSBControl)

		if (winScore > blueScore+1) then
			arena_handler:incrementBlueScore(pSBControl)
		elseif (pControl) then
			arena_handler:incrementBlueScore(pSBControl)
			local redGroup = getSceneObject(readData(dataStr..":g1"))
			arena_handler:messageGroup(redGroup, "Your Team Has Lost The Match.")
			local blueGroup = getSceneObject(readData(dataStr..":g2"))
			arena_handler:messageGroup(blueGroup, "Your Team Has Won The Match!")

			SceneObject(pControl):cancelPendingTask("Ihelp", "destroy") --Remove Current Destroy Task
			SceneObject(pControl):addPendingTask(16000, "Ihelp", "destroy")--Rechedule Arena Despawn (30 sec)
			arena_handler:setScoreboard(pSBControl, arena_TvT.wonDespawnTimer)
		end
	end
	return 0
end

--blue team member death observer
function arena_TvT:blueKilled(pPlayer, pKiller)
	print("Blue Player killed", pPlayer, pKiller)
	local controlID = readData(tostring(SceneObject(pPlayer):getObjectID())..":BoundArena")
	local dataStr = readStringData(tostring(controlID)..":dataStr")
	local pSBControl = getSceneObject(readData(dataStr..":SB"))

	if (pSBControl) then
		local pControl = getSceneObject(controlID)
		local winScore = readData(dataStr..":winScore")
		local redScore = arena_handler:getRedScore(pSBControl)

		if (winScore > redScore+1) then
			arena_handler:incrementRedScore(pSBControl)
		elseif (pControl) then
			arena_handler:incrementRedScore(pSBControl)
			local blueGroup = getSceneObject(readData(dataStr..":g2"))
			arena_handler:messageGroup(blueGroup, "Your Team Has Lost The Match.")
			local redGroup = getSceneObject(readData(dataStr..":g1"))
			arena_handler:messageGroup(redGroup, "Your Team Has Won The Match!")

			SceneObject(pControl):cancelPendingTask("Ihelp", "destroy") --Remove Current Destroy Task
			SceneObject(pControl):addPendingTask(16000, "Ihelp", "destroy") --Schedule Arena Despawn (30 sec)
			arena_handler:setScoreboard(pSBControl, arena_TvT.wonDespawnTimer)
		end
	end

	return 0
end

-- player entered area (removes pending task trap)
function arena_TvT:enter(pArea, pSob)
	if (SceneObject(pSob):isPlayerCreature()) then
		SceneObject(pSob):cancelPendingTask("arena_TvT", "eject")
	end
	return 0
end

-- player has left area (sets pending task trap)
function arena_TvT:exit(pArea, pSob)
	if (SceneObject(pSob):isPlayerCreature()) then
		SceneObject(pSob):addPendingTask(500, "arena_TvT", "eject")
	end
	return 0
end

-- attempt to eject player from zone (trap fired)
-- note: if off-line ensures login observer
function arena_TvT:eject(pPlayer)
	local ejected = SceneObject(pPlayer)
	if (ejected:isPlayerCreature()) then
		local pGhost = CreatureObject(pPlayer):getPlayerObject()
		if (pGhost == nil) then
			return false
		end

		if (not PlayerObject(pGhost):isOnline()) then 
			dropObserver(LOGGEDIN, "arena_handler", "onLoggedIn", pPlayer)
			createObserver(LOGGEDIN, "arena_handler", "onLoggedIn", pPlayer, 1)
		end

		if (hasObserver(PLAYERKILLED, pPlayer)) then
			dropObserver(PLAYERKILLED, "arena_TvT", "redKilled", pPlayer)
			dropObserver(PLAYERKILLED, "arena_TvT", "blueKilled", pPlayer)
		end

		local sobID = ejected:getObjectID()
		local controlID = readData(tostring(sobID)..":BoundArena")

		if ((controlID ~= 0) and (CreatureObject(pPlayer):isGrouped())) then
			local dataStr = readStringData(tostring(controlID)..":dataStr")
			local pSBControl = getSceneObject(readData(dataStr..":SB"))
			local gID = CreatureObject(pPlayer):getGroupID()
			local teamGroup
			if (pSBControl) then
				local SBdataStr = tostring(SceneObject(pSBControl):getObjectID())..":"
				local timeLeft = readData(SBdataStr.."timeLeft")
				local g1 = readData(dataStr..":g1")
				local g2 = readData(dataStr..":g2")
				if (timeLeft > 0) then
					local winScore = readData(dataStr..":winScore")
					if (gID == g1) then--(group1:hasMemberObject(pPlayer)) then
						teamGroup = LuaGroupObject(getSceneObject(g1))
						local blueScore = arena_handler:getBlueScore(pSBControl)
						if (winScore > blueScore) then
							arena_TvT:redKilled(pPlayer)
						end
					elseif (gID == g2) then
						teamGroup = LuaGroupObject(getSceneObject(g2))
						local redScore = arena_handler:getRedScore(pSBControl)
						if (winScore > redScore) then
							arena_TvT:blueKilled(pPlayer)
						end
					end
				end
				if ((not PlayerObject(pGhost):isOnline()) and teamGroup) then
					teamGroup:setGroupLock(0)
					local pList = teamGroup:getPlayerList()
					if (#pList > 2) then
						CreatureObject(pPlayer):ungroupTargetCreature(pPlayer)
						teamGroup:setGroupLock(1)
					elseif (#pList == 2) then
						teamGroup:disband()
						local pSob
						if (pList[1] == pPLayer) then
							pSob = pList[2]
						else
							pSob = pList[1]
						end

						if (SceneObject(getSceneObject(controlID)):getZoneName() == SceneObject(pSob):getZoneName()) then
							CreatureObject(pSob):teleport(1, 1, 1, 0)
						end

						if (gID == g1) then
							arena_TvT:redKilled(pSob)
						elseif (gID == g2) then
							arena_TvT:blueKilled(pSob)
						end
					end
				end
			end
		end
		deleteData(tostring(sobID)..":BoundArena")
		if (CreatureObject(pPlayer):isDead()) then
			CreatureObject(pPlayer):removeBuff("pvpDeathDebuff")
			CreatureObject(pPlayer):addCooldown("arena_death",300000) --5 min timer for free insurance
			SceneObject(pPlayer):switchZone("tatooine", WFnav:rndRng(3494, 5), 5, WFnav:rndRng(-4786, 5), 0)
		else
			local wpString = readStringData(tostring(sobID)..":arenaReturn")
			deleteStringData(tostring(sobID)..":arenaReturn")
			local WP = HelperFuncs:splitString(wpString, ",")
			if (WP[1]) then
				SceneObject(pPlayer):switchZone(WP[1], WP[2], WP[3], WP[4], WP[5])
			else
				SceneObject(pPlayer):switchZone("tatooine", WFnav:rndRng(3494, 5), 5, WFnav:rndRng(-4786, 5), 0)
			end
		end
	end
end
