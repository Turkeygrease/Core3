--PROTOTYPE Arena Handler, By: Mindsoft

arena_4v4 = ScreenPlay:new{
	inviteTimer = 30, --In Seconds how often to loop arena invites
	despawnTimer = 1800, --time from spawn until arena is destroyed if no win result first
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

					--top
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", 0, 0, 10.3, 0},--8

					--top right
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", 6.8, 0, 7.425, 45},--8
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 15.85, 0, 13.85, 45},--16

					--right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 21.5, 0, 0, 90},--16

					--bottom right
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", 6.8, 0, -7.425, 135},--8
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 15.85, 0, -13.85, 135},--16

					--bottom
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", 0, 0, -10.3, 180},--8

					--bottom left
					{"object/static/structure/military/military_wall_strong_rebl_style_01.iff", -6.8, 0, -7.425, 225},--8
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -15.85, 0, -13.85, 225},--16
				},
				{
					--left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -21.5, 0, 0, -90},--16

					--top left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -15.85, 0, 13.85, -45},--16

					--top
					{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 0, 0, 39, 0},--32

					--top right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 15.85, 0, 13.85, 45},--16

					--right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 21.5, 0, 0, 90},--16

					--bottom right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 15.85, 0, -13.85, 135},--16

					--bottom
					{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 0, 0, -39, 180},--32

					--bottom left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -15.85, 0, -13.85, 225},--16
				},
				{
					--left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -19.5, 0, 0, -90},--16

					--top left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -13.85, 0, 13.85, -45},--16

					--top
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 0, 0, 19.5, 0},--16

					--top right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 13.85, 0, 13.85, 45},--16

					--right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 19.5, 0, 0, 90},--16

					--bottom right
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", 13.85, 0, -13.85, 135},--16

					--bottom
					{"object/static/structure/military/military_wall_strong_rebl_32_style_01.iff", 0, 0, -39, 180},--32

					--bottom left
					{"object/static/structure/military/military_wall_strong_rebl_16_style_01.iff", -13.85, 0, -13.85, 225},--16
				},
				--{},--blank template layout
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
				if (arena_handler:validatePlayer(pOB)) then --validate player status
					if (CreatureObject(pOB):isGrouped()) then
						CreatureObject(pOB):sendSystemMessage("(Unable to Join Arena Solo: Joined Group)")
					else
						if not(CreatureObject(pOB):checkCooldownRecovery("arena_4v4")) then
							CreatureObject(pOB):addCooldown("arena_4v4",(arena_4v4.inviteTimer+1)*1000)
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
					if (arena_handler:validatePlayer(playerList[1])) then --validate pet/npc Group Leader status
						if not(CreatureObject(gOB:getLeader()):checkCooldownRecovery("arena_4v4")) then
							CreatureObject(gOB:getLeader()):addCooldown("arena_4v4",(arena_4v4.inviteTimer+1)*1000)
							table.insert(ques[1],tonumber(ptr))
							lockedIDs[ptr] = true
						end
					end
				elseif (arena_handler:validateGroup(gOB, memberCount, "a 4v4 Arena.")) then --validate group member status
					if not(CreatureObject(gOB:getLeader()):checkCooldownRecovery("arena_4v4")) then
						CreatureObject(gOB:getLeader()):addCooldown("arena_4v4",(arena_4v4.inviteTimer+1)*1000)
						if (memberCount == 4) then
							table.insert(ques[memberCount], {tonumber(ptr)})
							lockedIDs[ptr] = true
						else
							table.insert(ques[memberCount], tonumber(ptr))
							lockedIDs[ptr] = true
						end
						print("\nInviting Next Group:", inx, ptr, "Leader:"..CreatureObject(gOB:getLeader()):getFirstName())
					end
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
