------------------------------(Warfront tools for player objects)							-- (this code belongs soley to WarfrontEMU)
bf_tools = Object:new {}

function bf_tools:inRangeReward( object, range, iff )
	local playerTable = SceneObject(object):getPlayersInRange(range)
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]

		if (tPlayer ~= nil) then

			local pInventory = SceneObject(tPlayer):getSlottedObject("inventory")

		 	if (pInventory == nil) then
				return 0
			end

			CreatureObject(tPlayer):sendSystemMessage("You have been rewarded: ")
			giveItem(pInventory, iff, -1, true)
		end
	end
end

--Reward players of faction in range of object
--@ object : sceneObject , @ range : range in meters , @ faction : takes string of (pvp,rebel,imperial,rebOvert,impOvert) , @ iff: iff
function bf_tools:factionInRangeReward( object, range, faction, iff )
	local playerTable = SceneObject(object):getPlayersInRange(range)
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]
		if (tPlayer ~= nil) then
			local creo = LuaCreatureObject(tPlayer)
			--test if valid player
			if (faction == "pvp" and creo:isOvert() and ( creo:isRebel() or  creo:isImperial() ) ) then
			elseif (faction == "rebel" and creo:isRebel() ) then
			elseif (faction == "imperial" and creo:isImperial() ) then
			elseif (faction == "rebOvert" and creo:isRebel() and creo:isOvert() ) then
			elseif (faction == "impOvert" and creo:isImperial() and creo:isOvert() ) then

			else	--invalid player found
				goto continue
			end

			--valid player found
			local pInventory = SceneObject(tPlayer):getSlottedObject("inventory")

		 	if (pInventory == nil) then
				return 0
			end

			creo:sendSystemMessage("You have been rewarded: ")
			giveItem(pInventory, iff, -1, true)
			::continue::
		end
	end
end

function bf_tools:inRangeLoot( object, range, lootGroup )
	local playerTable = SceneObject(object):getPlayersInRange(range)
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]

		if (tPlayer ~= nil) then

			local pInventory = SceneObject(tPlayer):getSlottedObject("inventory")

		 	if (pInventory == nil) then
				return 0
			end

			CreatureObject(tPlayer):sendSystemMessage("You have been found rewarded: ")
			createLoot(pInventory, lootGroup, 0, true)
		end
	end
end

--Reward loot group to players of faction in range of object
--@ object : sceneObject , @ range : range in meters , @ faction : takes string of (pvp,rebel,imperial,rebOvert,impOvert) , @ lootGroup : lootGroup
function bf_tools:factionInRangeLoot( object, range, faction, lootGroup )
	local playerTable = SceneObject(object):getPlayersInRange(range)
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]
		if (tPlayer ~= nil) then
			local creo = LuaCreatureObject(tPlayer)
			--test if valid player
			if (faction == "pvp" and creo:isOvert() and ( creo:isRebel() or  creo:isImperial() ) ) then
			elseif (faction == "rebel" and creo:isRebel() ) then
			elseif (faction == "imperial" and creo:isImperial() ) then
			elseif (faction == "rebOvert" and creo:isRebel() and creo:isOvert() ) then
			elseif (faction == "impOvert" and creo:isImperial() and creo:isOvert() ) then

			else	--invalid player found
				goto continue
			end

			--valid player found
			local pInventory = SceneObject(tPlayer):getSlottedObject("inventory")

		 	if (pInventory == nil) then
				return 0
			end

			creo:sendSystemMessage("You have been found rewarded: ")
			createLoot(pInventory, lootGroup, 0, true)
			::continue::
		end
	end
end

function bf_tools:inRangeRewardXP( object, range, xpType, xp )
	local playerTable = SceneObject(object):getPlayersInRange(range)
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]

		if (tPlayer ~= nil) then
			CreatureObject(tPlayer):awardExperience(xpType, xp, true)
		end
	end
end

--Reward players of faction in range of object
--@ object : sceneObject , @ range : range in meters , @ faction : takes string of (pvp,rebel,imperial,rebOvert,impOvert) , @ xpType: xp type , @ xp: xp amount
function bf_tools:factionInRangeRewardXP( object, range, faction, xpType, xp )
	local playerTable = SceneObject(object):getPlayersInRange(range)
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]
		if (tPlayer ~= nil) then
			local creo = LuaCreatureObject(tPlayer)
			--test if valid player
			if (faction == "pvp" and creo:isOvert() and ( creo:isRebel() or  creo:isImperial() ) ) then
			elseif (faction == "rebel" and creo:isRebel() ) then
			elseif (faction == "imperial" and creo:isImperial() ) then
			elseif (faction == "rebOvert" and creo:isRebel() and creo:isOvert() ) then
			elseif (faction == "impOvert" and creo:isImperial() and creo:isOvert() ) then

			else	--invalid player found
				goto continue
			end
			--valid player found
			creo:awardExperience(xpType, xp, true)
			::continue::
		end
	end
end

function bf_tools:inRangeRewardSpam( object, range, iff, count )
	local playerTable = SceneObject(object):getPlayersInRange(range)
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]

		if (tPlayer ~= nil) then

			local pInventory = SceneObject(tPlayer):getSlottedObject("inventory")

		 	if (pInventory == nil) then
				return 0
			end

			CreatureObject(tPlayer):sendSystemMessage("You have been rewarded: X"..tostring(count))
			for c = 1, count, 1 do
				giveItem(pInventory, iff, -1, true)
			end
		end
	end
end

--Reward players of faction in range of object
--@ object : sceneObject , @ range : range in meters , @ faction : takes string of (pvp,rebel,imperial,rebOvert,impOvert) , @ iff: iff , @ count: # of iff to give
function bf_tools:factionInRangeRewardSpam( object, range, faction, iff, count )
	local playerTable = SceneObject(object):getPlayersInRange(range)
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]
		if (tPlayer ~= nil) then
			local creo = LuaCreatureObject(tPlayer)
			--test if valid player
			if (faction == "pvp" and creo:isOvert() and ( creo:isRebel() or  creo:isImperial() ) ) then
			elseif (faction == "rebel" and creo:isRebel() ) then
			elseif (faction == "imperial" and creo:isImperial() ) then
			elseif (faction == "rebOvert" and creo:isRebel() and creo:isOvert() ) then
			elseif (faction == "impOvert" and creo:isImperial() and creo:isOvert() ) then

			else	--invalid player found
				goto continue
			end

			--valid player found
			local pInventory = SceneObject(tPlayer):getSlottedObject("inventory")

		 	if (pInventory == nil) then
				return 0
			end

			creo:sendSystemMessage("You have been rewarded: X"..tostring(count))
			for c = 1, count, 1 do
				giveItem(pInventory, iff, -1, true)
			end

			::continue::
		end
	end
end

function bf_tools:inRangeLootSpam( object, range, lootGroup, count )
	local playerTable = SceneObject(object):getPlayersInRange(range)
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]

		if (tPlayer ~= nil) then

			local pInventory = SceneObject(tPlayer):getSlottedObject("inventory")

		 	if (pInventory == nil) then
				return 0
			end

			CreatureObject(tPlayer):sendSystemMessage("You have been found rewarded: X"..tostring(count))
			for c = 1, count, 1 do
				createLoot(pInventory, lootGroup, 0, true)
			end
		end
	end
end
