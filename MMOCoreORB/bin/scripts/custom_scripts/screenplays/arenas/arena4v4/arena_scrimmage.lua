-- 4/18/19 Scrimmage Arena Handler, By: Mindsoft

arena_scrimmage = ScreenPlay:new{
	inviteTimer = 300, --In Seconds how often to loop arena invites
	despawnTimer = 1800, --time from spawn until arena is destroyed if no win result first
	arenas = arena_4v4.arenas, --copy arenas from 4v4 table
}
registerScreenPlay("arena_scrimmage", true)

function arena_scrimmage:start()
	print("Arena 8-Man Handler has been started")
	createEvent(315500, "arena_scrimmage", "scheduleInvites", "", "")
end

--Looping event to schedule new Arenas
function arena_scrimmage:scheduleInvites()
	createEvent((arena_scrimmage.inviteTimer * 1000), "arena_scrimmage", "scheduleInvites", "", "")
	arena_scrimmage:broadcastInvites()
end

--Process Waitlist
function arena_scrimmage:broadcastInvites()
		--Broadcast for active Qued Players
	print("Broadcasting Scrimmage Arena Invites")

	local waitString = readStringData("WF_Arena:arena_scrimmage:waitingQue")
	deleteStringData("WF_Arena:arena_scrimmage:waitingQue")
	if (waitString == "") then
		print("Arena Scrimmage:waitlist empty")
		return 0 
	end

	local waitList = {}
	waitList = HelperFuncs:splitString(waitString, ",")
	local ques = {{},{},{}}--{healers}{squadleader}{dps}
	local lockedIDs = {}

	for inx, ptr in ipairs(waitList) do
		local pOB = getSceneObject(tonumber(ptr))
		local sOB = SceneObject(pOB)
		if(sOB and (not lockedIDs[ptr])) then
			if (sOB:isPlayerCreature()) then
				local creo = CreatureObject(pOB)
				if (arena_handler:validatePlayer(pOB)) then --validate player status
					if (creo:isGrouped()) then
						creo:sendSystemMessage("(Unable to Join Arena Solo: Joined Group)")
					else
						if not(creo:checkCooldownRecovery("arena_scrimmage")) then
							creo:addCooldown("arena_scrimmage", 0)
							lockedIDs[ptr] = true
							if (creo:hasSkill("force_discipline_healing_master")) then
								table.insert(ques[1],pOB)
							elseif (creo:hasSkill("outdoors_squadleader_master")) then
								table.insert(ques[2],pOB)
							else
								table.insert(ques[3],pOB)
							end
						end
					end
				end
			elseif (sOB:isGroupObject()) then
				local gOB = LuaGroupObject(pOB)
				local playerList = gOB:getPlayerList()
				local memberCount = #playerList
				if (memberCount < 1) then
					return 0
				elseif (memberCount < 2) then
					if (arena_handler:validatePlayer(playerList[1])) then --validate pet/npc Group Leader status
						local pCreo = gOB:getLeader()
						local creo = CreatureObject(pCreo)
						if not(creo:checkCooldownRecovery("arena_scrimmage") or lockedIDs[SceneObject(pCreo):getObjectID()]) then
							creo:addCooldown("arena_scrimmage", 0)
							lockedIDs[SceneObject(pCreo):getObjectID()] = true
							if (creo:hasSkill("force_discipline_healing_master")) then
								table.insert(ques[1],pCreo)
							elseif (creo:hasSkill("outdoors_squadleader_master")) then
								table.insert(ques[2],pCreo)
							else
								table.insert(ques[3],pCreo)
							end
							gOB:disband()
						end
					end
				elseif (arena_handler:validateGroup(gOB, memberCount, "a Scrimmage.")) then --validate group member status
					if not(CreatureObject(gOB:getLeader()):checkCooldownRecovery("arena_scrimmage")) then
						CreatureObject(gOB:getLeader()):addCooldown("arena_scrimmage", 0)
						lockedIDs[ptr] = true
						print("\nInviting Next Group:", inx, ptr, "Leader:"..CreatureObject(gOB:getLeader()):getFirstName())

						for place, pCreo in ipairs(playerList) do
							if not(lockedIDs[SceneObject(pCreo):getObjectID()]) then
								lockedIDs[SceneObject(pCreo):getObjectID()] = true
								local creo = CreatureObject(pCreo)
								if (creo:hasSkill("force_discipline_healing_master")) then
									table.insert(ques[1],pCreo)
								elseif (creo:hasSkill("outdoors_squadleader_master")) then
									table.insert(ques[2],pCreo)
								else
									table.insert(ques[3],pCreo)
								end
							end
						end
						gOB:disband()
					end
				else
					CreatureObject(gOB:getLeader()):sendSystemMessage("(Unable to Join Arena: Members with Invalid State)")
				end
			end
		end
	end

	local g1 = {}
	local g2 = {}

	if (#ques[2] >1) then --if 2 or more SL place in both groups
		table.insert(g1, table.remove(ques[2]))
		table.insert(g1, table.remove(ques[2]))
	elseif (#ques[2] == 1) then --if 1 SL place in first group
		table.insert(g1, table.remove(ques[2]))
		if (#ques[1] > 0) then --if 1 or more healer place in second group
			table.insert(g2, table.remove(ques[1]))
		end
	end

	local i = 0
	repeat
		i = i + 1
		while (#ques[i] > 0) do
			if (#g1 == #g2) then
				table.insert(g1, table.remove(ques[i]))
			else
				table.insert(g2, table.remove(ques[i]))
			end
		end
	until (i > 2)

	if (#g2 > 1) then
		if (#g1 > #g2) then
			local oddPlayer = table.remove(g1)
			CreatureObject(oddPlayer):sendSystemMessage("Scrimmage: ODD players (you will be Re-Queued).")
			arena_TvT:queWaiting(oddPlayer,"arena_scrimmage")
		end
	else --Insufficient players for match
		for place, pCreo in ipairs(g1) do
			CreatureObject(pCreo):sendSystemMessage("Scrimmage: Insufficient players (you will be Re-Queued).")
			arena_TvT:queWaiting(pCreo,"arena_scrimmage")
		end

		for place, pCreo in ipairs(g2) do
			CreatureObject(pCreo):sendSystemMessage("Scrimmage: Insufficient players (you will be Re-Queued).")
			arena_TvT:queWaiting(pCreo,"arena_scrimmage")
		end
		return 0
	end

	print("Building Scrimmage")

	local pArena = arena_TvT:build("arena_scrimmage", g1, g2)
	if (pArena) then
		print("created Scrimmage:",pArena)
		local dataStr = readStringData(tostring(SceneObject(pArena):getObjectID())..":dataStr")
		writeData(dataStr..":winScore", #g1)
	else --if failed put groups back in queue
		for place, pCreo in ipairs(g1) do
			CreatureObject(pCreo):sendSystemMessage("Scrimmage: Instance Failed (you will be Re-Queued).")
			arena_TvT:queWaiting(pCreo,"arena_scrimmage")
		end

		for place, pCreo in ipairs(g2) do
			CreatureObject(pCreo):sendSystemMessage("Scrimmage: Instance Failed (you will be Re-Queued).")
			arena_TvT:queWaiting(pCreo,"arena_scrimmage")
		end
		return 0
	end

	return pArena
end
