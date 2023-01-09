glowie_expansion_quest_screenplay = ScreenPlay:new {
	numberOfActs = 1,
	questString = "glowie_expansion_quest",
	states = {
		started_yes = 2, --has player accepted the quest
		finished_short = 4, --has player finished the pvp questline
		finished_long = 8, --has player finished the neutral questline
		complete = 16,
		has_reset = 32,
		started_short = 64,
		started_long = 128
	},

	questStringTwo = "glowie_expansion_quest_kills",
	statestwo = {
		reb_boss_one = 2, --Flags for Bosses Killed
		reb_boss_two = 4,
		reb_boss_three = 8,
		imp_boss_one = 16,
		imp_boss_two = 32,
		imp_boss_three = 64, 
		side_started = 128 -- Picked up quest from neutral
		
	}

}

registerScreenPlay("glowie_expansion_quest_screenplay", true)

-----------------------------

function glowie_expansion_quest_screenplay:start()

	printf("glowie_expansion_quest_screenplay.screenplaystart\n")

	--Spawn Initial Triggers for Rebel/Imperial Restus Expansion Quest Givers
	spawnMobile("tatooine", "quest_glowie_trigger_imp", 1, -1261, 12, -3607, -160, 0 )
	spawnMobile("tatooine", "quest_glowie_trigger_rebel", 1, 81, 52, -5310, -160, 0)

	--spawn PVP Triggers for Rebel/Imperial glowie Expansion Quest Givers
	spawnMobile("yavin4", "quest_glowie_pvp_trigger_imp", 1, -6937, 73, -5658, -179, 0 )
	spawnMobile("yavin4", "quest_glowie_pvp_trigger_rebel", 1, -312, 35, 4839, 90, 0)

	--spawn Neutral PVP Trigger for Rebel/Imperial glowie Expansion Quest Giver
end

-------------------------------------------


--  (----------)                  -  Sample quest conversation handlers  -                                 (---------)


glowie_expansion_quest_convo_handler = Object:new {}

function glowie_expansion_quest_convo_handler:getNextConversationScreen(conversationTemplate, conversingPlayer, selectedOption)
	local creature = LuaCreatureObject(conversingPlayer)
	local convosession = creature:getConversationSession()
	local conversation = LuaConversationTemplate(conversationTemplate)
	local lastConversationScreen = nil
	local nextConversationScreen

	if ( conversation ~= nil ) then
		-- checking to see if we have a next screen
		if ( convosession ~= nil ) then
			 local session = LuaConversationSession(convosession)
			 if ( session ~= nil ) then
			 	lastConversationScreen = session:getLastConversationScreen()
			 end
		end
		if ( lastConversationScreen == nil ) then
			local creature = LuaCreatureObject(conversingPlayer)
			local hasAccepted = creature:hasScreenPlayState(glowie_expansion_quest_screenplay.states.started_yes, glowie_expansion_quest_screenplay.questString)
			if ( hasAccepted == false ) then
				nextConversationScreen = conversation:getScreen("first_screen")
					-- if the quest is Has been RESET
				if  ( creature:hasScreenPlayState(glowie_expansion_quest_screenplay.states.has_reset, glowie_expansion_quest_screenplay.questString) ) then

					nextConversationScreen = conversation:getScreen("has_reset")
				end
			else

				--[[	   states:
						started_yes = 2,
						finished_short = 4,
						finished_long = 8,
						complete = 16,
						has_reset = 32
						started_short = 64
						started_long = 128
				]]


			--if player		
			
			-- if the quest is already completed and rewarded
				if ( creature:hasScreenPlayState(glowie_expansion_quest_screenplay.states.complete, glowie_expansion_quest_screenplay.questString) ) then
					print("already completed")
					nextConversationScreen = conversation:getScreen("complete")

			-- if the player has completed the pvp quest line
				elseif  ( creature:hasScreenPlayState(glowie_expansion_quest_screenplay.states.finished_short, glowie_expansion_quest_screenplay.questString) ) then
					nextConversationScreen = conversation:getScreen("finished_short")

				-- if the quest is already completed long
					if  ( creature:hasScreenPlayState(glowie_expansion_quest_screenplay.states.finished_long, glowie_expansion_quest_screenplay.questString) ) then
						nextConversationScreen = conversation:getScreen("finished_long")
					end

			-- if player has started pvp quest line
				elseif ( creature:hasScreenPlayState(glowie_expansion_quest_screenplay.states.started_short, glowie_expansion_quest_screenplay.questString) ) then
					nextConversationScreen = conversation:getScreen("started_short")
						--[[ questStringTwo flags : statestwo
						reb_boss_one = 2, --Flags for Bosses Killed
						reb_boss_two = 4,
						reb_boss_three = 8,
						imp_boss_one = 16,
						imp_boss_two = 32,
						imp_boss_three = 64, 
						side_started = 128 -- Picked up quest from neutral
						]]

				-- if the quest is still in progress
				else
					nextConversationScreen = conversation:getScreen("finished_no")
				end
			end
		else
			local luaLastConversationScreen = LuaConversationScreen(lastConversationScreen)
			local optionLink = luaLastConversationScreen:getOptionLink(selectedOption)
			nextConversationScreen = conversation:getScreen(optionLink)
		end
	end

	return nextConversationScreen
end

function glowie_expansion_quest_convo_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)

	local conversation = LuaConversationTemplate(conversationTemplate)
	local screen = LuaConversationScreen(conversationScreen)
	local screenID = screen:getScreenID()
	local player = LuaCreatureObject(conversingPlayer)

	-- Get some information about the player and npc quest giver.
			local creature = LuaCreatureObject(conversingPlayer)
			local npcCreature = LuaCreatureObject(conversingNPC)
			local isNpcImperial = npcCreature:isImperial()
 			local isImperial = creature:isImperial()
			local isNpcRebel = npcCreature:isRebel()
 			local isRebel = creature:isRebel()
			local playerObjPointer = creature:getPlayerObject()
 			local playerObj = LuaPlayerObject(playerObjPointer)

	if (isNpcImperial ~= isImperial)or(isNpcRebel ~= isRebel) then
		if (isImperial ~= true) and (isRebel ~=true)then
			conversationScreen = conversation:getScreen("reject_neutral")
		else
			conversationScreen = conversation:getScreen("reject_opposite")
		end
	elseif ( screenID == "started_kill") then
		player:setScreenPlayState( glowie_expansion_quest_screenplay.states.started_short , glowie_expansion_quest_screenplay.questString)

	elseif (screenID == "reb_taskmaster_logic_a") then
		if ( player:hasScreenPlayState(glowie_expansion_quest_screenplay.statestwo.imp_boss_three, glowie_expansion_quest_screenplay.questStringTwo) ) then
			 player:setScreenPlayState(glowie_expansion_quest_screenplay.states.finished_short, glowie_expansion_quest_screenplay.questString)
			conversationScreen = conversation:getScreen("finished_short")

		elseif ( player:hasScreenPlayState(glowie_expansion_quest_screenplay.statestwo.imp_boss_two, glowie_expansion_quest_screenplay.questStringTwo) ) then
			conversationScreen = conversation:getScreen("started_kill_three")

		elseif ( player:hasScreenPlayState(glowie_expansion_quest_screenplay.statestwo.imp_boss_one, glowie_expansion_quest_screenplay.questStringTwo) ) then
			conversationScreen = conversation:getScreen("started_kill_two")

		else
			conversationScreen = conversation:getScreen("started_kill_one")
		end

	elseif (screenID == "imp_taskmaster_logic_a") then
		if ( player:hasScreenPlayState(glowie_expansion_quest_screenplay.statestwo.reb_boss_three, glowie_expansion_quest_screenplay.questStringTwo) ) then
			 player:setScreenPlayState(glowie_expansion_quest_screenplay.states.finished_short, glowie_expansion_quest_screenplay.questString)
			nextConversationScreen = conversation:getScreen("finished_short")

		elseif ( player:hasScreenPlayState(glowie_expansion_quest_screenplay.statestwo.reb_boss_two, glowie_expansion_quest_screenplay.questStringTwo) ) then
			conversationScreen = conversation:getScreen("started_kill_three")

		elseif ( player:hasScreenPlayState(glowie_expansion_quest_screenplay.statestwo.reb_boss_one, glowie_expansion_quest_screenplay.questStringTwo) ) then
			conversationScreen = conversation:getScreen("started_kill_two")

		else
			conversationScreen = conversation:getScreen("started_kill_one")
		end

	elseif (screenID == "reward_short" ) then
		local pGhost = CreatureObject(conversingPlayer):getPlayerObject()

		if (pGhost ~= nil) then
			PlayerObject(pGhost):awardBadge(12) 
			PlayerObject(pGhost):awardBadge(13)
			PlayerObject(pGhost):awardBadge(14)
			PlayerObject(pGhost):awardBadge(15)
			PlayerObject(pGhost):awardBadge(16)
			PlayerObject(pGhost):awardBadge(17)
			PlayerObject(pGhost):awardBadge(18)
			PlayerObject(pGhost):awardBadge(19)
			PlayerObject(pGhost):awardBadge(23)
			PlayerObject(pGhost):awardBadge(26)
			PlayerObject(pGhost):awardBadge(28)
			PlayerObject(pGhost):awardBadge(30)
			PlayerObject(pGhost):awardBadge(38)
			PlayerObject(pGhost):awardBadge(39)
			PlayerObject(pGhost):awardBadge(75)
			PlayerObject(pGhost):awardBadge(81)
			PlayerObject(pGhost):awardBadge(87)
			PlayerObject(pGhost):awardBadge(105)
			PlayerObject(pGhost):awardBadge(106)
			PlayerObject(pGhost):awardBadge(107)
			PlayerObject(pGhost):awardBadge(108)
		end

		local pInventory = CreatureObject(conversingPlayer):getSlottedObject("inventory")
		
		if (SceneObject(pInventory):isContainerFullRecursive()) then
 			creature:sendSystemMessage("Full Inventory") 
 			return 0 
		end

		if isImperial then
			giveItem(pInventory, "object/tangible/deed/vehicle_deed/barc_speeder_imperial_deed.iff", -1)
		elseif isRebel then
			giveItem(pInventory, "object/tangible/deed/vehicle_deed/barc_speeder_rebel_deed.iff", -1)		
		end
		player:setScreenPlayState( glowie_expansion_quest_screenplay.states.complete , glowie_expansion_quest_screenplay.questString)

	elseif ( screenID == "started_yes" ) then
		player:setScreenPlayState( glowie_expansion_quest_screenplay.states.started_yes , glowie_expansion_quest_screenplay.questString)

	elseif ( screenID == "quest_status" ) then
		conversationScreen = screen:cloneScreen()

		local clonedConversation = LuaConversationScreen(conversationScreen)
		local thisState = player:getScreenPlayState(glowie_expansion_quest_screenplay.questString)

		if ( thisState ~= 0 ) then
			clonedConversation:setCustomDialogText("You are on stage " .. thisState .. " of this quest")
		else
			clonedConversation:setCustomDialogText("You are not yet on this quest")
		end

	elseif ( screenID == "quest_reset")  then

		player:removeScreenPlayState(glowie_expansion_quest_screenplay.states.started_yes, glowie_expansion_quest_screenplay.questString)
		player:removeScreenPlayState(glowie_expansion_quest_screenplay.states.started_short , glowie_expansion_quest_screenplay.questString)
		player:removeScreenPlayState(glowie_expansion_quest_screenplay.states.finished_short , glowie_expansion_quest_screenplay.questString)
		player:removeScreenPlayState(glowie_expansion_quest_screenplay.states.finished_long, glowie_expansion_quest_screenplay.questString)
		player:removeScreenPlayState(glowie_expansion_quest_screenplay.states.complete, glowie_expansion_quest_screenplay.questString)
		
		player:removeScreenPlayState(glowie_expansion_quest_screenplay.statestwo.reb_boss_one, glowie_expansion_quest_screenplay.questStringTwo)
		player:removeScreenPlayState(glowie_expansion_quest_screenplay.statestwo.reb_boss_two, glowie_expansion_quest_screenplay.questStringTwo)
		player:removeScreenPlayState(glowie_expansion_quest_screenplay.statestwo.reb_boss_three, glowie_expansion_quest_screenplay.questStringTwo)

		player:removeScreenPlayState(glowie_expansion_quest_screenplay.statestwo.imp_boss_one, glowie_expansion_quest_screenplay.questStringTwo)
		player:removeScreenPlayState(glowie_expansion_quest_screenplay.statestwo.imp_boss_two, glowie_expansion_quest_screenplay.questStringTwo)
		player:removeScreenPlayState(glowie_expansion_quest_screenplay.statestwo.imp_boss_three, glowie_expansion_quest_screenplay.questStringTwo)

		player:removeScreenPlayState(glowie_expansion_quest_screenplay.states.has_reset, glowie_expansion_quest_screenplay.questString)

	end

	return conversationScreen
end
