--PROTOTYPE Arena Handler, By: Mindsoft

arena_4v4 = ScreenPlay:new{
	inviteTimer = 30, --In Seconds how often to loop arena invites
	despawnTimer = 1800, --time from spawn until arena is destroyed if no win result first
	gateTimer = 30, -- time from spawn until gates objects are destroyed
	wonDespawnTimer = 15, --Reshedule timer to despawn to this time if win result
	arenas = {
		{
			name = "(- Arena One -)", -- Arena Instance Name
			iff = "object/building/poi/arena4v4_01.iff", -- Building IFF
			areas = {"tatOne", "tatTwo", "tatThree", "tatFour"}, --Areas this arena instance can utilize for spawns --tat
			screenplay = "arena4v4_01",
			arenaControlArea = 36, -- int meters radius from center
			redStart = {-52, 0, 16}, -- x, y, size
			blueStart = {52, 0, 16},
			scoreboard = {0, 6.4, 36}, -- {x, z, y},
			winScore = 4,
			gateObjects = { -- {iff,x,z,y,f},
				{"object/building/poi/arena_gate_01_red_8m.iff",-36,-1,0,90}, --Red Gate
				{"object/building/poi/arena_gate_01_blue_8m.iff",36,-1,0,90}, --Blue Gate
			},
			layouts = { -- {iff,x,z,y,f}, Interiour Layouts
				{}, --Empty Template Layout
				{
					{"object/static/structure/naboo/nboo_imprv_short_curved_wall_large_s01.iff", -15, 0, -5.5, -45},
					{"object/static/structure/naboo/nboo_imprv_short_curved_wall_large_s01.iff", 15, 0, 5.5, 135},
				},
				{
					{"object/static/structure/naboo/nboo_imprv_short_curved_wall_large_s01.iff", 15, 0, 5, 270},
					{"object/static/structure/naboo/nboo_imprv_short_curved_wall_large_s01.iff", -15, 0, 5, 270},
					{"object/static/structure/naboo/nboo_imprv_short_curved_wall_large_s01.iff", 15, 0, -5, 90},
					{"object/static/structure/naboo/nboo_imprv_short_curved_wall_large_s01.iff", -15, 0, -5, 90},
				},
			},
		},
		{
			name = "(- Arena Two -)", -- Arena Instance Name
			iff = "object/building/poi/arena4v4_02.iff", -- Building IFF
			areas = {"tatOne", "tatTwo", "tatThree", "tatFour"}, --Areas this arena instance can utilize for spawns --tat
			screenplay = "arena4v4_01",
			arenaControlArea = 39, -- int meters radius from center
			redStart = {-55, 0, 16}, -- x, y, size
			blueStart = {55, 0, 16},
			scoreboard = {0, 6.4, 39}, -- {x, z, y},
			winScore = 4,
			gateObjects = { -- {iff,x,z,y,f},
				{"object/static/structure/military/arena_wall_strong_red_32_style_01.iff", -39, 0, 0, -90},--32
				{"object/static/structure/military/arena_wall_strong_blue_32_style_01.iff", 39, 0, 0, -90},--32
			},
			layouts = { -- {iff,x,z,y,f}, Interiour Layouts
				{
					--left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -21.5, 0, 0, -90},--16

					--top left
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", -6.8, 0, 7.425, -45},--8
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -15.85, 0, 13.85, -45},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", -27.7, 0, 27.7, -45},--32

					--top
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", 0, 0, 10.3, 0},--8
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 0, 0, 39, 0},--32

					--top right
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", 6.8, 0, 7.425, 45},--8
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 15.85, 0, 13.85, 45},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 27.7, 0, 27.7, 45},--32

					--right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 21.5, 0, 0, 90},--16

					--bottom right
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", 6.8, 0, -7.425, 135},--8
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 15.85, 0, -13.85, 135},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 27.7, 0, -27.7, 135},--32

					--bottom
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", 0, 0, -10.3, 180},--8
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 0, 0, -39, 180},--32

					--bottom left
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", -6.8, 0, -7.425, 225},--8
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -15.85, 0, -13.85, 225},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", -27.7, 0, -27.7, 225},--32
				},
				{
					--left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -21.5, 0, 0, -90},--16

					--top left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -15.85, 0, 13.85, -45},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", -27.7, 0, 27.7, -45},--32

					--top
					{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 0, 0, 39, 0},--32

					--top right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 15.85, 0, 13.85, 45},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 27.7, 0, 27.7, 45},--32

					--right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 21.5, 0, 0, 90},--16

					--bottom right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 15.85, 0, -13.85, 135},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 27.7, 0, -27.7, 135},--32

					--bottom
					{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 0, 0, -39, 180},--32

					--bottom left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -15.85, 0, -13.85, 225},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", -27.7, 0, -27.7, 225},--32
				},
				{
					--left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -19.5, 0, 0, -90},--16

					--top left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -13.85, 0, 13.85, -45},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", -27.7, 0, 27.7, -45},--32

					--top
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 0, 0, 19.5, 0},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 0, 0, 39, 0},--32

					--top right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 13.85, 0, 13.85, 45},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 27.7, 0, 27.7, 45},--32

					--right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 19.5, 0, 0, 90},--16

					--bottom right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 13.85, 0, -13.85, 135},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 27.7, 0, -27.7, 135},--32

					--bottom
					{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 0, 0, -39, 180},--32

					--bottom left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -13.85, 0, -13.85, 225},--16
					--{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", -27.7, 0, -27.7, 225},--32
				},
				{},--blank template layout
			},
		},
	},
}
registerScreenPlay("arena_4v4", true)

function arena_4v4:start()
	print("Arena 8-Man Handler has been started")
	createEvent(150000, "arena_4v4", "scheduleInvites", "", "")
end

--Looping event to schedule new Arenas
function arena_4v4:scheduleInvites()
	createEvent((arena_4v4.inviteTimer * 1000), "arena_4v4", "scheduleInvites", "", "")
	arena_4v4:broadcastInvites()
end
--[[
--Sort Player or Group into proper Que
function arena_4v4:queWaiting(pPlayer)
	if not(CreatureObject(pPlayer):checkCooldownRecovery("WF_ARENA_4v4")) then
		CreatureObject(pPlayer):sendSystemMessage("Arena 8-Man:You have already joined the Arena Queue.")
		return 0
	end

	if (not arena_4v4:validatePlayer(pPlayer)) then --validate player status
		return 0
	end

	local playerZone = SceneObject(pPlayer):getZoneName()
	if (not arena_handler.allowedQuePlanets[playerZone]) then
		CreatureObject(pPlayer):sendSystemMessage("Arena 8-Man:You Cannot join arenas from this zone.")
		return 0
	end

	local ID = ""
	if (CreatureObject(pPlayer):isGrouped()) then
		print("\n- Grouped")
		ID = CreatureObject(pPlayer):getGroupID()
		local gOB = LuaGroupObject(getSceneObject(ID))
		if (pPlayer ~= gOB:getLeader()) then
			CreatureObject(pPlayer):sendSystemMessage("Arena 8-Man:You Must be leader to Queue your group.")
			return 0
		end
		print("Group ID: "..tostring(ID))
		CreatureObject(pPlayer):sendSystemMessage("Arena 8-Man:Your group has been added to the Queue.")
		--TODO add group confirms? add group check/tests? add group Member Alerts.
	else
		print("\n- Not Grouped")
		ID = SceneObject(pPlayer):getObjectID()
		CreatureObject(pPlayer):sendSystemMessage("Arena 8-Man:You have been added to the Queue.")
	end

	CreatureObject(pPlayer):addCooldown("WF_ARENA_4v4",(arena_4v4.inviteTimer+1)*1000)

	print("Adding ID to Waiting Que: "..tostring(ID))
	local que = readStringData("WF_Arena:arena_4v4:waitingQue")
	if (que == "") then
		que = tostring(ID)
	else
		que = tostring(ID)..","..que
	end
	writeStringData("WF_Arena:arena_4v4:waitingQue",que)
	print("Waiting:", readStringData("WF_Arena:arena_4v4:waitingQue"))
end
]]
--Process Waitlist
function arena_4v4:broadcastInvites()
		--Broadcast for active Qued Players
	print("Broadcasting 4v4 Arena Invites")

	local waitString = readStringData("WF_Arena:arena_4v4:waitingQue")
	deleteStringData("WF_Arena:arena_4v4:waitingQue")
	if (waitString == "") then
		print("Arena 4v4:waitlist empty")
		return 0 
	end

	local waitList = {}
	waitList = HelperFuncs:splitString(waitString, ",")
	local ques = {{},{},{},{}}
	local lockedIDs = {}

	for inx, ptr in ipairs(waitList) do
		local pOB = getSceneObject(tonumber(ptr))
		local sOB = SceneObject(pOB)
		if(sOB and (not lockedIDs[ptr])) then
			if (sOB:isPlayerCreature()) then
				if (arena_4v4:validatePlayer(pOB)) then --validate player status
					if (CreatureObject(pOB):isGrouped()) then
						CreatureObject(pOB):sendSystemMessage("(Unable to Join Arena Solo: Joined Group)")
					else
						if not(CreatureObject(pOB):checkCooldownRecovery("WF_ARENA_4v4")) then
							CreatureObject(pOB):addCooldown("WF_ARENA_4v4",(arena_4v4.inviteTimer+1)*1000)
							table.insert(ques[1],tonumber(ptr))
							lockedIDs[ptr] = true
						end
					end
				end
			elseif (sOB:isGroupObject()) then
				local gOB = LuaGroupObject(pOB)
				local playerList = gOB:getPlayerList()
				local memberCount = #playerList
				if (memberCount < 1) then
					return 0
				elseif ((memberCount > 4) ) then
					CreatureObject(gOB:getLeader()):sendSystemMessage("(Unable to Join Arena: Group Size Invalid)")
				elseif (memberCount < 2) then
					if (arena_4v4:validatePlayer(playerList[1])) then --validate pet/npc Group Leader status
						if not(CreatureObject(gOB:getLeader()):checkCooldownRecovery("WF_ARENA_4v4")) then
							CreatureObject(gOB:getLeader()):addCooldown("WF_ARENA_4v4",(arena_4v4.inviteTimer+1)*1000)
							table.insert(ques[1],tonumber(ptr))
							lockedIDs[ptr] = true
						end
					end
				elseif (arena_4v4:validateGroup(gOB, memberCount)) then --validate group member status
					--if not(CreatureObject(gOB:getLeader()):checkCooldownRecovery("WF_ARENA_4v4")) then TODO
						CreatureObject(gOB:getLeader()):addCooldown("WF_ARENA_4v4",(arena_4v4.inviteTimer+1)*1000)
						if (memberCount == 4) then
							table.insert(ques[memberCount], {tonumber(ptr)})
							lockedIDs[ptr] = true
						else
							table.insert(ques[memberCount], tonumber(ptr))
							--lockedIDs[ptr] = true TODO
						end
						print("\nInviting Next Group:", inx, ptr, "Leader:"..CreatureObject(gOB:getLeader()):getFirstName())
					--end TODO
				else
					CreatureObject(gOB:getLeader()):sendSystemMessage("(Unable to Join Arena: Members with Invalid State)")
				end
			end
		end
	end

	--Trio and Solo
	while ((#ques[3] > 0) and (#ques[1] > 0)) do
		table.insert(ques[4], { table.remove(ques[1]), table.remove(ques[3]) })
	end

	--Duo and Duo
	while (#ques[2] > 1) do
		table.insert(ques[4], { table.remove(ques[2]), table.remove(ques[2]) })
	end

	--Duo and Solo and Solo
	while ((#ques[2] > 0) and (#ques[1] > 1)) do
		table.insert(ques[4], { table.remove(ques[1]), table.remove(ques[1]), table.remove(ques[2]) })
	end

	--Solo and Solo and Solo and Solo
	while (#ques[1] > 3) do
		table.insert(ques[4], { table.remove(ques[1]), table.remove(ques[1]), table.remove(ques[1]), table.remove(ques[1]) })
	end

	print("building arenas")
	--BUILD ARENAS
	while(#ques[4] > 1) do
		--get pointers for group 1
		local tmpGrp1 = {}
		local group1 = table.remove(ques[4])
		for _,grp in ipairs(group1) do
			local pGrp = getSceneObject(grp)
			if (SceneObject(pGrp):isGroupObject()) then
				local playerList = LuaGroupObject(pGrp):getPlayerList()
				for _,plr in ipairs(playerList) do
					table.insert(tmpGrp1, plr)
				end
			else
				table.insert(tmpGrp1, pGrp)
			end
		end

		--get pointers for group 2
		local tmpGrp2 = {}
		local group2 = table.remove(ques[4])
		for _,grp in ipairs(group2) do
			local pGrp = getSceneObject(grp)
			if (SceneObject(pGrp):isGroupObject()) then
				local playerList = LuaGroupObject(pGrp):getPlayerList()
				for _,plr in ipairs(playerList) do
					table.insert(tmpGrp2, plr)
				end
			else
				table.insert(tmpGrp2, pGrp)
			end
		end

		local pArena = arena_TvT:build("arena_4v4", tmpGrp1, tmpGrp2)
		if (pArena) then
			print("created Arena:",pArena)
		else --if failed put groups back in queue
			table.insert(ques[4], group1)
			table.insert(ques[4], group2)
			print("Failed To Create Arena:",pArena)
		end
	end
	
	local overFlow = {} --Storage table for un-matched players/groups

	for i = 1 , 3, 1 do
		for _,v in ipairs(ques[i]) do
			table.insert(overFlow, v)
		end
	end

	if (#ques[4] > 0) then
		for _,v in ipairs(ques[4][1]) do
			table.insert(overFlow, v)
		end
	end

	writeStringData("WF_Arena:arena_4v4:waitingQue",table.concat(overFlow,","))
end

--[[
--Get Next Available Random Arena from Screenplay
function arena_4v4:getArena(str)
	local arenaDespawn = arena_4v4.despawnTimer
	local gateDespawn = arena_4v4.gateTimer
	local play = _G[str]

	--Randomly Select arena and area
	local arenaOB = play.arenas[math.random(#play.arenas)] -- Get Random Arena
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
		createObserver(ENTEREDAREA, "arena_4v4", "enter", pRedArea)
		createObserver(EXITEDAREA, "arena_4v4", "exit", pRedArea)
	end

	--spawn Blue Area
	local blueArea = arenaOB.blueStart
	local pBlueArea = spawnSceneObject(arena[2], "object/active_area.iff", arena[3]+blueArea[1], arena[4], arena[5]+blueArea[2], 0, math.rad(0))	
	if (pBlueArea ~= nil) then
		local activeArea = LuaActiveArea(pBlueArea)
		activeArea:setCellObjectID(0)
		activeArea:setRectangular(blueArea[3]*2, blueArea[3]*2)
		createObserver(ENTEREDAREA, "arena_4v4", "enter", pBlueArea)
		createObserver(EXITEDAREA, "arena_4v4", "exit", pBlueArea)
	end

	--spawn Combat Area
	local pCombatArea = spawnSceneObject(arena[2], "object/active_area.iff", arena[3], arena[4], arena[5], 0, math.rad(0))
	if (pCombatArea ~= nil) then
		local combatAreaSize = arenaOB.arenaControlArea
		local activeArea = LuaActiveArea(pCombatArea)
		activeArea:setCellObjectID(0)
		activeArea:setRectangular(combatAreaSize*2, combatAreaSize*2)
		createObserver(ENTEREDAREA, "arena_4v4", "enter", pCombatArea)
		createObserver(EXITEDAREA, "arena_4v4", "exit", pCombatArea)
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


-- player entered area (removes pending task trap)
function arena_4v4:enter(pArea, pSob)
	if (SceneObject(pSob):isPlayerCreature()) then
		SceneObject(pSob):cancelPendingTask("arena_4v4", "eject")
	end
	return 0
end

-- player has left area (sets pending task trap)
function arena_4v4:exit(pArea, pSob)
	if (SceneObject(pSob):isPlayerCreature()) then
		SceneObject(pSob):addPendingTask(500, "arena_4v4", "eject")
	end
	return 0
end

-- attempt to eject player from zone (trap fired)
-- note: if off-line ensures login observer
function arena_4v4:eject(pPlayer)
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

--red team member death observer
function arena_4v4:redKilled(pPlayer, pKiller)
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
function arena_4v4:blueKilled(pPlayer, pKiller)
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

--Build Arena
function arena_4v4:build(g1, g2)
	local arenaTable = arena_4v4:getArena("arena_4v4")
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
			createEvent((math.random(5)+5)*100, "arena_4v4", "setTef", plr, "")
			createEvent(arena_4v4.gateTimer * 1000, "arena_handler", "playSound", plr, "sound/ui_combat_engaged_01_droid.snd") --Schedule Combat Announcer
			createEvent((240 + math.random(30)) * 1000, "arena_handler", "updateJediTEF", plr, "")

			dropObserver(PLAYERKILLED, "arena_4v4", "redKilled", plr)
			createObserver(PLAYERKILLED, "arena_4v4", "redKilled", plr)
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
			createEvent((math.random(5)+5)*100, "arena_4v4", "setTef", plr, "")
			createEvent(arena_4v4.gateTimer * 1000, "arena_handler", "playSound", plr, "sound/ui_combat_engaged_01_droid.snd") --Schedule Combat Announcer
			createEvent((240 + math.random(30)) * 1000, "arena_handler", "updateJediTEF", plr, "")

			dropObserver(PLAYERKILLED, "arena_4v4", "blueKilled", plr)
			createObserver(PLAYERKILLED, "arena_4v4", "blueKilled", plr)
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

	createEvent(arena_4v4.gateTimer * 1000, "arena_handler", "messageGroup", getSceneObject(group1), "Match Started")
	createEvent(arena_4v4.gateTimer * 1000, "arena_handler", "messageGroup", getSceneObject(group2), "Match Started")

	return pControl
end

function arena_4v4:setTef(pPlayer)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	LuaPlayerObject(pGhost):jediTef()
	TangibleObject(pPlayer):setPvpStatusBit(OVERT)
	return 0
end

--Que new ID
function arena_4v4:queID(val, str)
	print("Queueing:", val, str)
	local que = readStringData(val)
	if (que == "") then
		que = str
	else
		que = str..","..que
	end
	writeStringData(val, que)
end

--Player Ready Pop-Up
function arena_4v4:confirmPlayerReady(pPlayer) --when player enter zone prompt for confirmation
	print("running confirm player",pPlayer)
	if (not arena_4v4:validatePlayer(pPlayer)) then --validate player status
		CreatureObject(pPlayer):sendSystemMessage("(You been removed from the 8-Man Arena Queue)")
		return 0
	end

	local sui = SuiMessageBox.new("arena_4v4","confirmPlayerReadyCallback")
	local pSui = LuaSuiBoxPage(sui)
	print("LSB:",pSui)
	sui.setTitle("Confirm: [Join 8-Man Arena]")
	sui.setPrompt("Do you wish to enter 8-Man Arena Instance?")
	--createEvent(1000, "arena_4v4", "confirmPlayerReadyUpdate", pSui, 9) --TODO get pop up updates working
	sui.sendTo(pPlayer)

	return 0
end

--Update Player Ready Info
function arena_4v4:confirmPlayerReadyUpdate(sui,count) --when player enter zone prompt for confirmation
	print("count:",count,sui)
	if (tonumber(count) > 1) then
		print("creating new event", count)
		createEvent(1000, "arena_4v4", "confirmPlayerReadyUpdate", sui, count - 1)
	end
end

--Player Ready Pop-Up Callback
function arena_4v4:confirmPlayerReadyCallback(pPlayer, pSui, eventIndex) --evaluate player confirmation and port or exit accordingly
	print("player callback fired",pPlayer,pSui,eventIndex)
	if (eventIndex == 1 or pPlayer == nil) then return 0 end
	print("adding player to ready que:")

	if (not arena_4v4:validatePlayer(pPlayer)) then --validate player status
		CreatureObject(pPlayer):sendSystemMessage("(You been removed from the 8-Man Arena Queue)")
		return 0
	end

	local readyQue = readStringData("WF_Arena:4v4_readyQue")
	local ID = SceneObject(pPlayer):getObjectID()
	if (readyQue == "") then
		readyQue = ID
	else
		readyQue = ID..","..readyQue
	end

	writeStringData("WF_Arena:4v4_readyQue",readyQue)

	return 0
end

--Member Ready Pop-Up
function arena_4v4:confirmMemberReady(pPlayer) --when player enter zone prompt for confirmation
	print("running confirm player",pPlayer)
	local sui = SuiMessageBox.new("arena_4v4","confirmMemberReadyCallback")
	sui.setTitle("Confirm: [Join 8-Man Arena]")
	sui.setPrompt("Do you wish to enter 8-Man Arena Instance?")
	sui.sendTo(pPlayer)

	return 0
end

--Member Ready Pop-Up Callback
function arena_4v4:confirmMemberReadyCallback(pPlayer, pSui, eventIndex) --evaluate player confirmation and port or exit accordingly
	print("member callback fired",pPlayer,pSui,eventIndex)
	if (eventIndex == 1 or pPlayer == nil) then return 0 end
	print("adding Member to ready que:")
	local readyQue = readStringData("WF_Arena:4v4_readyQue")
	local ID = SceneObject(pPlayer):getObjectID()
	if (readyQue == "") then
		readyQue = ID
	else
		readyQue = ID..","..readyQue
	end

	writeStringData("WF_Arena:4v4_readyQue",readyQue)

	return 0
end
]]
--Validate creature for interactions valid factions = "rebel", "imperial", "gcw", (any other string defaults to neutral)
function arena_4v4:validatePlayer(pPlayer, faction)
	if (pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return false
	end

	local sob = SceneObject(pPlayer)
	local creo = CreatureObject(pPlayer)

	local pGhost = creo:getPlayerObject()
	if ((pGhost == nil) or (not PlayerObject(pGhost):isOnline())) then
		--return false TODO
	end

	if (creo:isInCombat() or creo:isIncapacitated() or creo:isDead()) then --check players combat state
		creo:sendSystemMessage("Arena:You cannot join Arenas in your current state.")
		return false
	end

	if (PlayerObject(pGhost):hasTef()) then --check if player has gcw/jedi/bh tef state
		creo:sendSystemMessage("Arena:You cannot join Arenas while in TEF state.")
		return false
	end

	local playerZone = sob:getZoneName()
	if (not arena_handler.allowedQuePlanets[playerZone]) then
		creo:sendSystemMessage("Arena:You Cannot join arenas from this zone.")
		return false
	end

	--Make sure player is outside or in player structure
	if (sob:getParentID() ~= 0) then
		local pBid = creo:getBuildingParentID()
		local pBld = getSceneObject(pBid)
		if (pBld and SceneObject(pBld):isBuildingObject()) then
			local ownerID = LuaBuildingObject(pBld):getOwnerID()
			if ((ownerID == 0) or (not SceneObject(getSceneObject(ownerID)):isPlayerCreature())) then
				creo:sendSystemMessage("Arena:You can only join Arenas while outdoors or in Player structure.")
				return false
			end
		else
			creo:sendSystemMessage("Arena:You cannot join Arenas from this location.")
			return false
		end
	end

	if (faction) then -- if faction provided test for match with players faction
		local pfac = creo:getFaction()
		if ((faction == "rebel") and (pfac ~= FACTIONREBEL)) then --test rebel
			return false
		elseif ((faction == "imperial") and (pfac ~= FACTIONIMPERIAL)) then --test imperial
			return false
		elseif ((faction == "gcw") and ((pfac ~= FACTIONREBEL) or (pfac ~= FACTIONIMPERIAL))) then --test for gcw faction
			return false
		elseif ((pfac == FACTIONREBEL) or (pfac == FACTIONIMPERIAL)) then --test neutral
			return false
		end
	end

	return true
end

function arena_4v4:validateGroup(gOB, max, faction)
	if ((gOB == nil) or (max < 1)) then
		return false
	end

	local pLeader = gOB:getLeader()
	local playerList = gOB:getPlayerList()
	local memCount = #playerList

	--Validate Group Size
	if ((memCount < 1) or (memCount > max)) then
		CreatureObject(pLeader):sendSystemMessage("Arena:Your Group is not the Correct Size to join this Arena.")
		return false
	end

	faction = faction or false
	local isValid = true
	local i = 0

	--Validate Group Members
	repeat
		i = i + 1
		CreatureObject(playerList[i]):sendSystemMessage("Arena:Your Group Leader has Queued for a 4v4 Arena.")
		isValid = isValid and arena_4v4:validatePlayer(playerList[i], faction)
	until ((i >= memCount) or (isValid == false))

	return isValid
end

--[[
		activeArea:setRectangular(10, 40)  --width,height
		--activeArea:setCircular(10)  --radius
		--activeArea:setRingular(10, 50)  --inner,outer


		print("Area Sizes:", combatAreaSize, redArea[3], blueArea[3])
		local inArea = activeArea:containsPoint(arena[3]+2, arena[5]+2)
		print("contains +2:",inArea)

		inArea = activeArea:containsPoint(arena[3]+30, arena[5]+30)
		print("contains +30:",inArea)

		local test = {}

		test = activeArea:getRandomPosition()
		if (test) then
			print("test:", test[1], test[2], test[3])
		else
			print("test is nil")
		end

		test = activeArea:getRandomPosition(1, 2)
		if (test) then
			print("test2:", test[1], test[2], test[3])
		else
			print("test2 is nil")
		end
]]
