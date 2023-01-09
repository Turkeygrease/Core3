qol_menu = {
	toolsMenu = {
		{ "Server Status","server"},
		{ "Group Tools", "group" },
		{ "Tools (Under Construction)", "tools" },
		{ "Player Perks (Under Construction)", "perks" },
	},
	devToolsMenu = {
		{ "[DEV] Instance Manager", "instance_manager" },
		{ "[DEV] Player Manager (Under Construction)", "player_manager" },
		{ "[DEV] Village Manager", "village" },
		{ "[DEV] Targeted Tools (Under Construction)", "targeted_tools" },
		{ "[DEV] Event Tools (Under Construction)", "event_tools" },
	},
}

-----------------------------------------		Menu Option Manager
--Show Main Menu
function qol_menu:main(pCreature)
	if (pCreature == nil) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "mainSuiCallback")

	sui.setTargetNetworkId(SceneObject(pCreature):getObjectID())

	sui.setTitle("Quality of Life Tools")
	sui.setPrompt("Select a tool group below to open it.\n\nUsage:\n /qol  (Main Menu)\n /qol server  (Server Status)\n /qol group  (Group Tools)\n /qol tools  (Player Tools)\n /qol perks  (Player Perks)")

	for i = 1, #self.toolsMenu, 1 do
		sui.add(self.toolsMenu[i][1], "")
	end

	if (CreatureObject(pCreature):hasSkill("admin_debug_03")) then
		for i = 1, #self.devToolsMenu, 1 do
			sui.add(self.devToolsMenu[i][1], "")
		end
	end

	sui.sendTo(pCreature)
end

--Main Menu Selection Handler
function qol_menu:mainSuiCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1
	if (chosenTool < 1) then
		return
	end

	if (chosenTool > #self.toolsMenu and CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		chosenTool = chosenTool - #self.toolsMenu
		self[self.devToolsMenu[chosenTool][2]]("",pPlayer)
	else
		self[self.toolsMenu[chosenTool][2]]("",pPlayer)
	end
end

--Default Option
function qol_menu:defaultSuiCallback(pPlayer, pSui, eventIndex)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	qol_menu:main(pPlayer)
end

-----------------------------------------	(Player Screens)	---------------------------------------------------------------------
-----------------------------------------		Server Status
function qol_menu:server(pPlayer)
	if (pPlayer == nil) then
		return
	end

	local curPhase = VillageJediManagerTownship:getCurrentPhase()
	local nextPhaseChange = VillageJediManagerTownship.getNextPhaseChangeTime()
	local phaseTimeLeft = VillageGmSui:getPhaseDuration()

	local msg = " \\#pcontrast1 Players Online:" .. " \\#pcontrast2 " .. getConnectionCount() .."\n \\#pcontrast1 Current Village Phase:" .. " \\#pcontrast2 " .. curPhase .. "\n\\#pcontrast1  Current Server Time:" .. " \\#pcontrast2 " .. os.date("%c")
	local msg = msg .. "\n \\#pcontrast1 Next Phase Change: " .. " \\#pcontrast2 " .. os.date("%c", nextPhaseChange)  .. "\n \\#pcontrast1 Phase Time Left: " .. " \\#pcontrast2 " .. phaseTimeLeft
	local suiManager = LuaSuiManager()
	suiManager:sendMessageBox(pPlayer, pPlayer, "(qol) Server Status:", msg, "@back", "qol_menu", "defaultSuiCallback")
end

-----------------------------------------		Group Manager
function qol_menu:group(pCreature)
	if (pCreature == nil) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "groupMainSuiCallback")

	sui.setTargetNetworkId(SceneObject(pCreature):getObjectID())

	sui.setTitle("(qol) Group Tools")
	sui.setPrompt("Select an option below to open it.")
	sui.add("View Group Stats", "")
	sui.add("Register Solo Group (not implemented yet)", "")
	sui.add("Registered Solo Groups (not implemented yet)", "")
	if not(CreatureObject(pCreature):checkCooldownRecovery("arena_4v4") and CreatureObject(pCreature):checkCooldownRecovery("arena_scrimmage")) then
		sui.add("Leave Arena Queue", "")
	else
		sui.add("Queue for 4v4 Arena", "")
		sui.add("Queue for Scrimmage Arena", "")
	end
	sui.sendTo(pCreature)
end

function qol_menu:groupMainSuiCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1
	if (chosenTool < 1) then
		qol_menu:main(pPlayer)
	end

	if (chosenTool == 1) then
		local msg = " \\#pcontrast1 Group Leader:\\#pcontrast2 "
		if (CreatureObject(pPlayer):isGrouped())then
			if (CreatureObject(pPlayer):getGroupMember(0) == pPlayer) then
				msg = msg.." You are group Leader"
			else
				msg = msg..CreatureObject(CreatureObject(pPlayer):getGroupMember(0)):getFirstName()
			end

			local playerCount = 0
			local rebelCount = 0
			local imperialCount = 0
		 	local groupSize = CreatureObject(pPlayer):getGroupSize()
			for i = 0, groupSize - 1, 1 do
				if (SceneObject(CreatureObject(pPlayer):getGroupMember(i)):isPlayerCreature()) then
					local pObject = CreatureObject(pPlayer):getGroupMember(i)
					playerCount = playerCount + 1
					if (CreatureObject(pObject):isRebel()) then--is rebel?
						rebelCount = rebelCount + 1
					elseif (CreatureObject(pObject):isImperial()) then--is imperial?
						imperialCount = imperialCount + 1
					end
				end
			end

			local pGhost = CreatureObject(pPlayer):getPlayerObject()

			if (pGhost == nil) then
				return
			end

			local groupLevel = PlayerObject(pGhost):getGroupLevel()
			local playerLevel = PlayerObject(pGhost):getLevel()
			local groupStatus = CreatureObject(pPlayer):getGroupLock()
			if (groupStatus) then groupStatus = "Locked" else groupStatus = "Un-Locked" end

			msg = msg.."\n \\#pcontrast1 Group Status: \\#pcontrast2 "..groupStatus
			msg = msg.."\n \\#pcontrast1 Group Level: \\#pcontrast2 "..math.floor(groupLevel)
			msg = msg.."\n \\#pcontrast1 Your Level: \\#pcontrast2 "..math.floor(playerLevel)
			msg = msg.."\n \\#pcontrast1 Group Count: \\#pcontrast2 "..math.floor(groupSize)
			msg = msg.."\n \\#pcontrast1 Group Player Count: \\#pcontrast2 "..playerCount
			msg = msg.."\n \\#pcontrast1 Imperial Player Count: \\#pcontrast2 "..imperialCount
			msg = msg.."\n \\#pcontrast1 Rebel Player Count: \\#pcontrast2 "..rebelCount
		else
			msg = "You are NOT grouped"
		end

		local suiManager = LuaSuiManager()
		suiManager:sendMessageBox(pPlayer, pPlayer, "(qol) Group Status:", msg, "@back", "qol_menu", "defaultSuiCallback")
	elseif (chosentTool == 2) then
		--qol_menu:group(pPlayer)
	elseif (chosentTool == 3) then
		--qol_menu:group(pPlayer)
	elseif (chosenTool == 4) then
		if not(CreatureObject(pPlayer):checkCooldownRecovery("arena_4v4")) then
			if (CreatureObject(pPlayer):isGrouped())then
				local ID = CreatureObject(pPlayer):getGroupID()
				local pGroup = getSceneObject(ID)
				local gOB = LuaGroupObject(pGroup)
				if (pPlayer ~= gOB:getLeader()) then
					CreatureObject(pPlayer):sendSystemMessage("Arena 8-Man: You Must be leader remove your group from Queue.")
					return 0
				end
				arena_handler:messageGroup(pGroup, "Arena 8-Man: Your leader has removed your group from Queue.")
			else
				CreatureObject(pPlayer):sendSystemMessage("Arena 8-Man: You have removed from Queue.")
			end
			CreatureObject(pPlayer):addCooldown("arena_4v4",1)
		elseif not(CreatureObject(pPlayer):checkCooldownRecovery("arena_scrimmage")) then
			if (CreatureObject(pPlayer):isGrouped())then
				local ID = CreatureObject(pPlayer):getGroupID()
				local pGroup = getSceneObject(ID)
				local gOB = LuaGroupObject(pGroup)
				if (pPlayer ~= gOB:getLeader()) then
					CreatureObject(pPlayer):sendSystemMessage("Arena Scrimmage: You Must be leader remove your group from Queue.")
					return 0
				end
				arena_handler:messageGroup(pGroup, "Arena Scrimmage: Your leader has removed your group from Queue.")
			else
				CreatureObject(pPlayer):sendSystemMessage("Arena Scrimmage: You have removed from Queue.")
			end
			CreatureObject(pPlayer):addCooldown("arena_scrimmage",1)
		else
			arena_TvT:queWaiting(pPlayer,"arena_4v4")
		end
	elseif (chosenTool == 5) then
		print("scrimmage arena chosen")
		--[[if not(CreatureObject(pPlayer):checkCooldownRecovery("ARENA_SCRIMMAGE")) then
			if (CreatureObject(pPlayer):isGrouped())then
				local ID = CreatureObject(pPlayer):getGroupID()
				local pGroup = getSceneObject(ID)
				local gOB = LuaGroupObject(pGroup)
				if (pPlayer ~= gOB:getLeader()) then
					CreatureObject(pPlayer):sendSystemMessage("Arena Scrimmage:You Must be leader remove your group from Queue.")
					return 0
				end
				arena_handler:messageGroup(pGroup, "Arena Scrimmage:Your leader has removed your group from Queue.")
			else
				CreatureObject(pPlayer):sendSystemMessage("Arena Scrimmage:You have removed from Queue.")
			end
			CreatureObject(pPlayer):addCooldown("ARENA_SCRIMMAGE",1)
		else]]
		if (CreatureObject(pPlayer):checkCooldownRecovery("arena_scrimmage")) then
			arena_TvT:queWaiting(pPlayer,"arena_scrimmage")
		end
	end
	qol_menu:main(pPlayer)
end

-----------------------------------------		Tools Manager
function qol_menu:tools(pCreature)
	if (pCreature == nil) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "toolsCallback")
	sui.setTargetNetworkId(SceneObject(pCreature):getObjectID())
	sui.setTitle("(qol) Player Tools")
	sui.setPrompt("Select a tool below to open it.")

	sui.add("Guild Info (not implemented yet)", "")
	sui.add("Lots", "")
	sui.add("Veteran Rewards", "")
	sui.add("Player Status (not implemented yet)", "")
	sui.sendTo(pCreature)
end

function qol_menu:toolsCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1
	if (chosenTool < 1) then
		qol_menu:main(pPlayer)
		return
	end

	if (chosenTool == 1) then
	elseif (chosenTool == 2) then
		CreatureObject(pPlayer):sendCommand("qol", "lots", pPlayer)
	elseif (chosenTool == 3) then
		CreatureObject(pPlayer):sendCommand("qol", "veteranrewards", pPlayer)
	end
	qol_menu:tools(pPlayer)
end

-----------------------------------------		Player Perks
function qol_menu:perks(pCreature)
	if (pCreature == nil) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "main")
	sui.setTargetNetworkId(SceneObject(pCreature):getObjectID())
	sui.setTitle("(qol) Player Perks")
	sui.setPrompt("Select a perk below to activate it.")
	sui.add("Request Shuttle (not implemented yet)", "")
	sui.add("Request Nova Shuttle (not implemented yet)", "")
	sui.sendTo(pCreature)
end

-----------------------------------------	(Developer Screens)	------------------------------------------------------------------
-----------------------------------------		Developer-Filtered-Menu
function qol_menu:dev(pCreature)
	if (pCreature == nil or not CreatureObject(pCreature):hasSkill("admin_debug_03")) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "devSuiCallback")

	sui.setTargetNetworkId(SceneObject(pCreature):getObjectID())

	sui.setTitle("Quality of Life \\#ff0000[DEV]\\#000000 Tools")
	sui.setPrompt("Select a tool group below to open it.")

	for i = 1, #qol_menu.devToolsMenu, 1 do
		sui.add(qol_menu.devToolsMenu[i][1], "")
	end

	sui.sendTo(pCreature)
end

function qol_menu:devSuiCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1
	if (chosenTool < 1) then
		qol_menu:main(pPlayer)
		return
	end

	self[self.devToolsMenu[chosenTool][2]]("",pPlayer)
end

-----------------------------------------		Instance Manager
function qol_menu:instance_manager(pPlayer)
	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "instance_managerCallback")

	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())

	sui.setTitle("Quality of Life \\#ff0000[DEV]\\#000000 Instance Manager")
	sui.setPrompt("Select a Zone below to view it's active instances.")

	for i = 1, #WF_Instance_Handler.zoneNames, 1 do
		sui.add(WF_Instance_Handler.zoneNames[i], "")
	end


	sui.sendTo(pPlayer)
end

function qol_menu:instance_managerCallback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end

	local chosenTool = args + 1
	if (chosenTool < 1) then
		qol_menu:dev(pPlayer)
		return
	end

	WFporter:manageInstances(pPlayer, "", WF_Instance_Handler.zoneNames[chosenTool])
end

-----------------------------------------		Player Manager
function qol_menu:player_manager(pPlayer)
	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end
	--[[
	local sui = SuiListBox.new("qol_menu", "devSuiCallback")

	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())

	sui.setTitle("Quality of Life \\#ff0000[DEV]\\#000000 Player Manager")
	sui.setPrompt("Select a tool group below to open it.")
	sui.add("Player Ban/Unban", "")
	sui.sendTo(pPlayer)
	]]
	--print("Player Manager Selected")
	qol_menu:dev(pPlayer)
end

function qol_menu:village(pPlayer)
	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end

	VillageGmSui:showMainPage(pPlayer)
end

-----------------------------------------		Targeted Tools
function qol_menu:targeted_tools(pPlayer)
	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "targeted_tools_callback")

	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())

	sui.setTitle("Quality of Life \\#ff0000[DEV]\\#000000 Targeted Tools")
	sui.setPrompt("Select a tool group below to open it.")

	sui.add("Snoop Lots", "")
	sui.add("Snoop Veteran Rewards", "")
	sui.add("Set Jedi Tef", "")
	sui.add("Lock Group", "")
	sui.add("Unlock Group", "")
	sui.add("Group With Target Creature", "")
	--[[sui.add("Un-Group Target Creature", "")
	sui.add("Force Group Combat on Target Creature", "")
	sui.add("Force Group With Target Creature", "")
	sui.add("Force Un-Group on Target Creature", "")
	sui.add("Force Disband Target Creature's Group", "")
	sui.add("Make Target Creature Leader", "")]]

	sui.sendTo(pPlayer)
end

function qol_menu:targeted_tools_callback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1
	if (chosenTool < 1) then
		qol_menu:dev(pPlayer)
		return
	end

	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end

	if (chosenTool == 1) then --snoop lots
		CreatureObject(pPlayer):sendCommand("snoop", "lots", pPlayer)
	elseif (chosenTool == 2) then --snoop vet rewards
		CreatureObject(pPlayer):sendCommand("snoop", "veteranrewards", pPlayer)
	elseif (chosenTool == 3) then --set jedi teff
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (pTarget and SceneObject(pTarget):isPlayerCreature()) then
			local pGhost = CreatureObject(pTarget):getPlayerObject()
			if (pGhost == nil) then
				return 0
			end
			LuaPlayerObject(pGhost):jediTef()
			CreatureObject(pPlayer):sendSystemMessage("Forcing Jedi Tef on Target.")
			CreatureObject(pTarget):sendSystemMessage("You now have Jedi Tef State.")
			TangibleObject(pTarget):setPvpStatusBit(OVERT)
		end
	elseif (chosenTool == 4) then --lock targets group
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (pTarget and SceneObject(pTarget):isCreatureObject() and not (pTarget == pPlayer)) then
			if (CreatureObject(pTarget):isGrouped()) then
				CreatureObject(pTarget):setGroupLock(1)
				CreatureObject(pPlayer):sendSystemMessage("Your Targets Group has been Locked.")
			end
		else
			if (CreatureObject(pPlayer):isGrouped()) then
				CreatureObject(pPlayer):setGroupLock(1)
				CreatureObject(pPlayer):sendSystemMessage("Your Group has been Locked.")
			end
		end
	elseif (chosenTool == 5) then --unlock targets group
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (pTarget and SceneObject(pTarget):isCreatureObject() and not (pTarget == pPlayer)) then
			if (CreatureObject(pTarget):isGrouped()) then
				CreatureObject(pTarget):setGroupLock(0)
				CreatureObject(pPlayer):sendSystemMessage("Your Targets Group has been Un-Locked.")
			end
		else
			if (CreatureObject(pPlayer):isGrouped()) then
				CreatureObject(pPlayer):setGroupLock(0)
				CreatureObject(pPlayer):sendSystemMessage("Your Group has been Un-Locked.")
			end
		end
	elseif (chosenTool == 6) then --group with target
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (pTarget and SceneObject(pTarget):isCreatureObject()) then
			if (CreatureObject(pTarget):isGrouped()) then
				CreatureObject(pPlayer):sendSystemMessage("Your Target is already in a group.")
				CreatureObject(pTarget):formGroupWithCreature(pPlayer)
			else
				CreatureObject(pPlayer):formGroupWithCreature(pTarget)
				CreatureObject(pPlayer):sendSystemMessage("Your Target has been Forced into your group.")
			end
		else
			CreatureObject(pPlayer):sendSystemMessage("You Must be targeted to a creature to force it into group.")
		end
	elseif (chosenTool == 7) then --ungroup target
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (pTarget and SceneObject(pTarget):isCreatureObject()) then
			if (CreatureObject(pTarget):isGrouped()) then
				CreatureObject(pPlayer):ungroupTargetCreature(pTarget)
				CreatureObject(pPlayer):sendSystemMessage("Your Target has been removed from thier group.")
			else
				CreatureObject(pPlayer):sendSystemMessage("Your Target is not in a group.")
			end
		else
			CreatureObject(pPlayer):sendSystemMessage("Creature Must be targeted to remove it from it's group.")
		end
	elseif (chosenTool == 8) then --force group combat
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (CreatureObject(pPlayer):isGrouped()) then
			if (pTarget and SceneObject(pTarget):isCreatureObject()) then
				CreatureObject(pPlayer):sendSystemMessage("Forcing Group Combat on Target.")
				local i = 0
				repeat
					local member = CreatureObject(pPlayer):getGroupMember(i)
					CreatureObject(member):engageCombat(pTarget)
					i = i + 1
				until (CreatureObject(pPlayer):getGroupSize() < i+1)
			else
				CreatureObject(pPlayer):sendSystemMessage("Cannot Force Group Combat on NULL Target.")
			end
		else
			if (pTarget and SceneObject(pTarget):isCreatureObject()) then
				CreatureObject(pPlayer):engageCombat(pTarget)
				CreatureObject(pPlayer):sendSystemMessage("Forcing Combat on Target.")
			else
				CreatureObject(pPlayer):sendSystemMessage("Cannot Force Combat on NULL Target.")
			end
		end
	elseif (chosenTool == 9) then --force group
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (pTarget and SceneObject(pTarget):isCreatureObject()) then
			if (CreatureObject(pTarget):isGrouped()) then
				CreatureObject(pPlayer):sendSystemMessage("Your Target is already in a group.")
			else
				if (CreatureObject(pPlayer):isGrouped()) then
					local gID = CreatureObject(pPlayer):getGroupID()
					print("Group ID: "..tostring(gID))
					local gOb = LuaGroupObject(getSceneObject(gID))
					print("GOB: ",gOb)
					gOb:forceAddMember(pTarget)
					CreatureObject(pPlayer):sendSystemMessage("Your Target has been Forced into your group.")
				else
					CreatureObject(pPlayer):formGroupWithCreature(pTarget)
					CreatureObject(pPlayer):sendSystemMessage("Your Target has been Forced into group with you.")
				end
			end
		else
			CreatureObject(pPlayer):sendSystemMessage("You Must be targeted to a creature to force it into group.")
		end
	elseif (chosenTool == 10) then --force ungroup
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (pTarget and SceneObject(pTarget):isCreatureObject()) then
			if (CreatureObject(pTarget):isGrouped()) then
				local gID = CreatureObject(pTarget):getGroupID()
				print("Group ID: "..tostring(gID))
				local gOb = LuaGroupObject(getSceneObject(gID))
				print("GOB: ",gOb)
				gOb:forceRemoveMember(pTarget)
				CreatureObject(pPlayer):sendSystemMessage("Your target has been removed from thier group.")
			else
				CreatureObject(pPlayer):sendSystemMessage("This creature is NOT in a group.")
			end
		else
			CreatureObject(pPlayer):sendSystemMessage("You Must be targeted to a creature to force it into group.")
		end
	elseif (chosenTool == 11) then --force disband
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (pTarget and SceneObject(pTarget):isCreatureObject()) then
			if (CreatureObject(pTarget):isGrouped()) then
				local gID = CreatureObject(pTarget):getGroupID()
				print("Group ID: "..tostring(gID))
				local gOb = LuaGroupObject(getSceneObject(gID))
				print("GOB: ",gOb)
				gOb:disband()
				CreatureObject(pPlayer):sendSystemMessage("Your targets group has been disbanded.")
			else
				CreatureObject(pPlayer):sendSystemMessage("This creature is NOT in a group.")
			end
		else
			CreatureObject(pPlayer):sendSystemMessage("You Must be targeted to a creature to disband thier group.")
		end
	elseif (chosenTool == 12) then --force leader
		local targetID = CreatureObject(pPlayer):getTargetID()
		local pTarget = getSceneObject(targetID)
		if (pTarget and SceneObject(pTarget):isCreatureObject()) then
			if (CreatureObject(pTarget):isGrouped()) then
				local gID = CreatureObject(pTarget):getGroupID()
				print("Group ID: "..tostring(gID))
				local gOb = LuaGroupObject(getSceneObject(gID))
				print("GOB: ",gOb)
				gOb:makeLeader(pTarget)
				CreatureObject(pPlayer):sendSystemMessage("Your target has been made thier groups leader.")
			else
				CreatureObject(pPlayer):sendSystemMessage("This creature is NOT in a group.")
			end
		else
			CreatureObject(pPlayer):sendSystemMessage("You Must be targeted to a creature to make them group leader.")
		end
	end

	qol_menu:targeted_tools(pPlayer)
end

-----------------------------------------		Event Tools
function qol_menu:event_tools(pPlayer)
	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "event_tools_callback")

	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())

	sui.setTitle("Quality of Life \\#ff0000[DEV]\\#000000 Event Tools")
	sui.setPrompt("Select a tool group below to open it.")

	sui.add("CreateNPC Tools Menu", "")
	sui.add("Firework (quick-show)", "")
	sui.add("PVP Event Tools", "")
	sui.add("Test Ques", "")
	sui.add("Force Arena On My Group", "")
	sui.add("test flatten 100", "")
	sui.add("test flatten 200", "")
	sui.add("test flatten 300", "")
	--sui.add("Test Group Observers on self", "")
	--sui.add("Test Lua Group", "")

	sui.sendTo(pPlayer)
end

function qol_menu:event_tools_callback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1
	if (chosenTool < 1) then
		qol_menu:dev(pPlayer)
		return
	end

	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end

	local dev = SceneObject(pPlayer)

	--npc tools menu
	if (chosenTool == 1) then
		StaffTools:openToolsSUI(pPlayer)
		return
	--instant firework event
	elseif (chosenTool == 2) then
		FireworkEvent:triggerFireworks(pPlayer, 60, 70, 20, 40, 50)
		playClientEffectLoc(SceneObject(pPlayer):getObjectID(), "clienteffect/droid_effect_confetti.cef", SceneObject(pPlayer):getZoneName(), SceneObject(pPlayer):getWorldPositionX(), SceneObject(pPlayer):getWorldPositionZ(), SceneObject(pPlayer):getWorldPositionY(), 0)
	--pvp event tools
	elseif (chosenTool == 3) then
		return qol_menu:pvp_event_tools(pPlayer)
	--test queues
	elseif (chosenTool == 4) then
		arena_TvT:queWaiting(pPlayer,"arena_4v4")
	--test arena on my group
	elseif (chosenTool == 5) then
		local pControl
		local winScore = 1
		local ct = 0
		if (CreatureObject(pPlayer):isGrouped()) then
			local gID = CreatureObject(pPlayer):getGroupID()
			local gOB = LuaGroupObject(getSceneObject(gID))
			local pList = gOB:getPlayerList()
			ct = #pList
			if (ct > 1) then
				local g1 = {}
				local g2 = {}
				local ct1
				local i
				if (ct == 2) then
					ct1 = math.floor(ct/2)
					i = 0
				else
					ct1 = math.floor(ct/2)+1
					i = 1
				end
				repeat
					i = i + 1
					local pGhost = CreatureObject(pList[i]):getPlayerObject()
					if (pGhost ~= nil) then
						if (PlayerObject(pGhost):isOnline() ) then
							print("player is online")
						else
							print("player is offline")
						end
					else
						print("nil player ghost")
					end
					table.insert(g1, pList[i])
				until(i == ct1)

				repeat
					i = i + 1
					local pGhost = CreatureObject(pList[i]):getPlayerObject()
					if (pGhost ~= nil) then
						if (PlayerObject(pGhost):isOnline()) then
							print("player is online")
						else
							print("player is offline")
						end
					else
						print("nil player ghost")
					end
					table.insert(g2, pList[i])
				until (i == ct)

				pControl = arena_TvT:build("arena_4v4", g1, g2)
				winScore = ct1
			else
				pControl = arena_TvT:build("arena_4v4", {pPlayer}, {})
			end
		else
			pControl = arena_TvT:build("arena_4v4",{pPlayer}, {})
			--pControl = arena_4v4:build({pPlayer}, {})
		end
		if (pControl ~= nil) then
			local dataStr = readStringData(tostring(SceneObject(pControl):getObjectID())..":dataStr")

			if (ct > 2) then
				--print("\nqol_menu", "tpDevToArena", pPlayer, SceneObject(pControl):getObjectID())
				createEvent(4000, "qol_menu", "tpDevToArena", pPlayer, SceneObject(pControl):getObjectID())
				writeData(dataStr..":winScore", winScore-1)
			else
				writeData(dataStr..":winScore", winScore)
			end
		end
	--100m arena
	elseif (chosenTool == 6) then
		local pControl = spawnSceneObject(SceneObject(pPlayer):getZoneName(), "object/building/poi/arena4v4_01.iff", SceneObject(pPlayer):getWorldPositionX(), SceneObject(pPlayer):getWorldPositionZ(), SceneObject(pPlayer):getWorldPositionY(), 0, 0)
		createEvent(180000, "qol_menu", "destroy", pControl, "")

		local redgate = spawnSceneObject(SceneObject(pControl):getZoneName(), "object/building/poi/arena_gate_01_red_8m.iff", SceneObject(pControl):getWorldPositionX()-36, SceneObject(pControl):getWorldPositionZ()-1, SceneObject(pControl):getWorldPositionY(), 0, math.rad(90))
		createEvent(30000, "qol_menu", "destroy", redgate, "")

		local bluegate = spawnSceneObject(SceneObject(pControl):getZoneName(), "object/building/poi/arena_gate_01_blue_8m.iff", SceneObject(pControl):getWorldPositionX()+36, SceneObject(pControl):getWorldPositionZ()-1, SceneObject(pControl):getWorldPositionY(), 0, math.rad(90))
		createEvent(30000, "qol_menu", "destroy", bluegate, "")
	--200m arena
	elseif (chosenTool == 7) then
		local pControl = spawnSceneObject(SceneObject(pPlayer):getZoneName(), "object/building/poi/arena_size_200.iff", SceneObject(pPlayer):getWorldPositionX(), SceneObject(pPlayer):getWorldPositionZ(), SceneObject(pPlayer):getWorldPositionY(), 0, 0)
		createEvent(180000, "qol_menu", "destroy", pControl, "")
	--300m arena
	elseif (chosenTool == 8) then
		local pControl = spawnSceneObject(SceneObject(pPlayer):getZoneName(), "object/building/poi/arena_size_300.iff", SceneObject(pPlayer):getWorldPositionX(), SceneObject(pPlayer):getWorldPositionZ(), SceneObject(pPlayer):getWorldPositionY(), 0, 0)
		createEvent(180000, "qol_menu", "destroy", pControl, "")
	--group observer tests
	elseif (chosenTool == 9) then
		dropObserver(JOINEDGROUP, "qol_menu", "testObsJoin", pPlayer)
		createObserver(JOINEDGROUP,"qol_menu","testObsJoin", pPlayer)
		dropObserver(LEFTGROUP, "qol_menu", "testObsLeave", pPlayer)
		createObserver(LEFTGROUP,"qol_menu","testObsLeave", pPlayer)
		if (CreatureObject(pPlayer):isGrouped()) then
			print("\n- Grouped")
			local gID = CreatureObject(pPlayer):getGroupID()
			print("Group ID: "..tostring(gID))
			local pGob = getSceneObject(gID)
			dropObserver(JOINEDGROUP, "qol_menu", "testObsJoinGroup", pGob)
			createObserver(JOINEDGROUP,"qol_menu","testObsJoinGroup", pGob)
			dropObserver(LEFTGROUP,"qol_menu","testObsLeaveGroup", pGob)
			createObserver(LEFTGROUP,"qol_menu","testObsLeaveGroup", pGob)
			dropObserver(GROUPDISBANDED,"qol_menu","testObsDisbandGroup", pGob)
			createObserver(GROUPDISBANDED,"qol_menu","testObsDisbandGroup", pGob)
		end
	--group debugging
	elseif (chosenTool == 10) then
		print("\n Testing Group Object:")
		if (CreatureObject(pPlayer):isGrouped()) then
			print("\n- Grouped")
			local gID = CreatureObject(pPlayer):getGroupID()
			print("Group ID: "..tostring(gID))
			local gOb = LuaGroupObject(getSceneObject(gID))
			print("GOB: ",gOb)
			print("Group Level: ", gOb:getGroupLevel())
			print("Group Size: ", gOb:getGroupSize())
			print("Group Players: ", gOb:getNumberOfPlayerMembers())
			print("Group Member(0): ", gOb:getGroupMember(), CreatureObject(gOb:getLeader()):getFirstName())
			print("Group Leader: ", gOb:getLeader(), CreatureObject(gOb:getLeader()):getFirstName())

			local groupList = gOb:getGroupList()
			print("groupList:",groupList, #groupList)
			local i = 1
			repeat
				print("Group Member:["..tostring(i).."]", groupList[i], CreatureObject(groupList[i]):getFirstName())
				i = i + 1
			until (i > #groupList)

			local playerList = gOb:getPlayerList()
			print("playerList:",playerList, #playerList)
			i = 1
			repeat
				print("Group Player:["..tostring(i).."]", playerList[i], CreatureObject(playerList[i]):getFirstName())
				i = i + 1
			until (i > #playerList)

			print("Locking Group")
			gOb:setGroupLock(1)
			print("Group Locked?: ", gOb:getGroupLock())
			print("Unlocking Group")
			gOb:setGroupLock(0)
			print("Group Locked?: ", gOb:getGroupLock())
			print("Group Has SL?: ", gOb:hasSquadLeader())
			print("Group Is Other Member Playing Music: ", gOb:isOtherMemberPlayingMusic())
			print("Group Band Song: ", gOb:getBandSong())
			
		else
			print("\n- Not Grouped")
		end
	end

	qol_menu:dev(pPlayer)
end

function qol_menu:tpDevToArena(pPlayer, controlID)
	local pControl = getSceneObject(tonumber(controlID))
	local control = SceneObject(pControl)
	local x = control:getWorldPositionX()
	local y = control:getWorldPositionY()
	local z = control:getWorldPositionZ()
	SceneObject(pPlayer):switchZone("arena_tatooine", x, z, y-30, 0)
end

---------------------------------------------TEST GROUP OBSERVER EVENTS
function qol_menu:testObsJoin(ob, ob2, ob3)
	print("\n Join",ob, ob2, ob3)
	print(CreatureObject(ob):getFirstName())
	print("joined")
	return 0
end

function qol_menu:testObsJoinGroup(ob, ob2, ob3)
	print("\n Join",ob, ob2, ob3)
	print(CreatureObject(ob2):getFirstName())
	print("Member joined group")
	return 0
end

function qol_menu:testObsLeave(ob, ob2, ob3)
	print("\n left group",ob, ob2, ob3)
	print(CreatureObject(ob):getFirstName())
	print("leaving")
	return 0
end

function qol_menu:testObsLeaveGroup(ob, ob2, ob3)
	print("\n member leave group",ob, ob2, ob3)
	print(CreatureObject(ob2):getFirstName())
	print("Member leaving Group")
	return 0
end

function qol_menu:testObsDisbandGroup(ob, ob2, ob3)
	print("\n Disband",ob, ob2, ob3)
	print("Disbanding group")
	return 0
end
-------------------------------------------------------------------

--Destroy Scene Object from world
function qol_menu:destroy(ob)
	print("destroying terrain mod")
	if (ob ~= nil and SceneObject(ob) ~= nil) then
		SceneObject(ob):destroyObjectFromWorld()
	end
end

-----------------------------------------		PVP Event Tools
function qol_menu:pvp_event_tools(pPlayer)
	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "pvp_event_tools_callback")

	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())

	sui.setTitle("Quality of Life \\#ff0000[DEV]\\#000000 Event Tools")
	sui.setPrompt("Select a tool group below to open it.")
	
	sui.add("PVP Imp (quick-shuttle)", "")
	sui.add("PVP Reb (quick-shuttle)", "")
	sui.add("Eisley PVP Event", "")

	sui.sendTo(pPlayer)
end

function qol_menu:pvp_event_tools_callback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1
	if (chosenTool < 1) then
		qol_menu:dev(pPlayer)
		return
	end

	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_debug_03")) then
		return
	end

	local dev = SceneObject(pPlayer)

	if (chosenTool == 1) then
		ShuttleDropoff:triggerFlyby(dev:getZoneName(), 1, dev:getWorldPositionX(), dev:getWorldPositionY(), dev:getDirectionAngle(), 10, "stormtrooper", 200)
	elseif (chosenTool == 2) then
		ShuttleDropoff:triggerFlyby(dev:getZoneName(), 3, dev:getWorldPositionX(), dev:getWorldPositionY(), dev:getDirectionAngle(), 10, "specforce_major", 200)
	elseif (chosenTool == 3) then
		eisley_pvp:start()
	end

	qol_menu:pvp_event_tools(pPlayer)
end


-----------------------------------------		CSR Tools
function qol_menu:csr_tools(pPlayer)
	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_base")) then
		return
	end

	local sui = SuiListBox.new("qol_menu", "csr_tools_callback")

	sui.setTargetNetworkId(SceneObject(pPlayer):getObjectID())

	sui.setTitle("Quality of Life \\#ff0000[DEV]\\#000000 Event Tools")
	sui.setPrompt("Select a tool group below to open it.")

	sui.add("CSR OPTION 1", "")

	sui.sendTo(pPlayer)
end

function qol_menu:csr_tools_callback(pPlayer, pSui, eventIndex, args)
	local cancelPressed = (eventIndex == 1)

	if (cancelPressed) then
		return
	end

	local chosenTool = args + 1
	if (chosenTool < 1) then
		qol_menu:csr_tools(pPlayer)
		return
	end

	if (pPlayer == nil or not CreatureObject(pPlayer):hasSkill("admin_base")) then
		return
	end

	local dev = SceneObject(pPlayer)

	if (chosenTool == 1) then
	
	end

	qol_menu:csr_tools(pPlayer)
end

