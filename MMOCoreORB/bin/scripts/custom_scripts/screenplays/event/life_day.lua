wf_life_day_event = ScreenPlay:new{
	planets = {
		["tatooine"] = {
			cities = {
				{
					-- {x, y, min, max, count, respawnTimer, despawnTimer}
					wp = {3529, -4800, 500, 800, 3, 60, 300},
				},
			},
		},
		["naboo"] = {
			cities = {
				{
					-- {x, y, min, max, count, respawnTimer, despawnTimer}
					wp = {-5074, 4245, 500, 800, 3, 60, 300},
				},
			},
		},
		["corellia"] = {
			cities = {
				{
					-- {x, y, min, max, count, respawnTimer, despawnTimer}
					wp = {-202, -4469, 500, 800, 3, 60, 300},
				},
			},
		},
	},
}
registerScreenPlay("wf_life_day_event", false)

function wf_life_day_event:start()
	print("Warfront Lifeday Event Screenplay Started")
	self:spawnPresents()
end

function wf_life_day_event:spawnPresents()
	for planet,planetTable in pairs(self.planets) do
		print("\nSpawning Presents for Planet: "..planet)
		for cityIndex, cityTable in ipairs(planetTable.cities) do
			local wp = cityTable.wp -- {x, y, min, max, count, respawnTimer, despawnTimer}
			local i = 1
			local pSob
			repeat
				local spawn = getSpawnArea(planet, wp[1], wp[2], wp[3], wp[4], 20, 10)
				if (spawn == nil) then
					printLuaError("Trigger Mobile could not find a spawn point, Rescheduling spawn event.")
					local pNav = WFnav:getNav(planet)
					createEvent(1000, "wf_life_day_event", "respawnPresent", pNav, cityIndex)
					return false
				end

				pSob = spawnSceneObject(planet, "object/tangible/storyteller/prop/pr_lifeday_presents.iff",spawn[1],spawn[2],spawn[3],0, math.random(360))
				SceneObject(pSob):setCustomObjectName("Missing Presents")
				SceneObject(pSob):setObjectMenuComponent("life_day_mini_game")
				createEvent(wp[7]*1000, "wf_life_day_event", "despawnPresent", pSob, "")
				writeData(SceneObject(pSob):getObjectID()..":cityIndex", cityIndex)
				createObserver(OBJECTREMOVEDFROMZONE, "wf_life_day_event", "triggerDead",pSob)
				i = i + 1
			until (i >wp[5])
			print("# of Triggers spawned: "..tostring(i-1).."\n")
		end
	end
end

function wf_life_day_event:despawnPresent(pSob)
	if not(SceneObject(pSob)) then
		return
	end
	SceneObject(pSob):destroyObjectFromWorld()
end

function wf_life_day_event:respawnPresent(pNav, cityIndex)
	local zoneName = SceneObject(pNav):getZoneName()
	local cityTable = self.planets[SceneObject(pNav):getZoneName()].cities[tonumber(cityIndex)]
	local wp = cityTable.wp -- wp={x, y, min, max, count, respawnTimer, despawnTimer}

	local spawn = getSpawnArea(zoneName, wp[1], wp[2], wp[3], wp[4], 20, 10)
	if (spawn == nil) then
		printLuaError("Trigger Mobile could not find a spawn point, Rescheduling spawn event.")
		local pNav = WFnav:getNav(zoneName)
		createEvent(1000, "wf_life_day_event", "respawnPresent", pNav, cityIndex)
		return false
	end

	local pSob = spawnSceneObject(zoneName, "object/tangible/storyteller/prop/pr_lifeday_presents.iff",spawn[1],spawn[2],spawn[3],0, math.random(360))
	SceneObject(pSob):setCustomObjectName("Missing Presents")
	SceneObject(pSob):setObjectMenuComponent("life_day_mini_game")
	createEvent((wp[7]+math.random(5))*1000, "wf_life_day_event", "despawnPresent", pSob, cityIndex)
	writeData(SceneObject(pSob):getObjectID()..":cityIndex", cityIndex)
	createObserver(OBJECTREMOVEDFROMZONE, "wf_life_day_event", "triggerDead",pSob)
	return true
end

function wf_life_day_event:triggerDead(pSob)
	if not(SceneObject(pSob)) then
		return
	end

	local zoneName = SceneObject(pSob):getZoneName()
	if (zoneName == "") then
		return
	end
	
	local cityIndex = readData(SceneObject(pSob):getObjectID()..":cityIndex")
	deleteData(SceneObject(pSob):getObjectID()..":cityIndex")

	local pNav = WFnav:getNav(zoneName)
	local respawnTimer = self.planets[SceneObject(pNav):getZoneName()].cities[tonumber(cityIndex)].wp[6]
	createEvent((respawnTimer+math.random(5))*1000, "wf_life_day_event", "respawnPresent", pNav, cityIndex)

	return 0
end

----------------------------------      LIFE-DAY MINI-GAME    ---------------------------------
life_day_mini_game = {
	lootLevel = 500,
	lootStrings = {
		"Gold",
		"Silver",
		"Copper",
	},
	rewardGroups = {
		{"tusken_dot_group", "buff_band_t3", "ig_tissue", "krayt_pearls"},
		{"vendor_hide", "lootcollectiontierdiamond"},
		{"color_crystals", "clothing_attachments", "junk"},
	},
}

function life_day_mini_game:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)

	menuResponse:addRadialMenuItem(101, 3, "Select the Red Present")
	menuResponse:addRadialMenuItem(102, 3, "Select the Green Present")
	menuResponse:addRadialMenuItem(103, 3, "Select the Gold Present")
end

-- player selection processing
function life_day_mini_game:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return
	end

	if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
		CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
		return 0 
	end

	if not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 6) then
		CreatureObject(pPlayer):sendSystemMessage("(You are not in range to use this object)")
		return 0
	end

	if not((selectedID > 100) and (selectedID < 104)) then
		return 0
	end


	local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
	local inventory = LuaSceneObject(pInventory)
	  
         -- Insufficent Space
	if (SceneObject(pInventory):isContainerFullRecursive()) then
		CreatureObject(pPlayer):sendSystemMessage("You do not have enough inventory space")  
		return 0
	end

	local number = math.random(3) + 100
	if (number == selectedID) then
		--high reward
		number = 1
	elseif (number > selectedID) then
		if ((selectedID + 1) == number) then
			--medium reward
			number = 2
		else
			--low reward
			number = 3
		end
	else
		if ((number + 1) == selectedID) then
			if (selectedID == 102) then
				--low reward
				number = 3
			else
				--medium reward
				number = 2
			end
		else
			--low reward
			number = 3
		end
	end

	local lootGroup = self.rewardGroups[number][math.random(#self.rewardGroups[number])]
	createLoot(pInventory, lootGroup, self.lootLevel, true)
	local msg = "(You recieve a "..self.lootStrings[number].." Reward Gift!)"
	CreatureObject(pPlayer):sendSystemMessage(msg)
	SceneObject(pSceneObject):destroyObjectFromWorld()
end
