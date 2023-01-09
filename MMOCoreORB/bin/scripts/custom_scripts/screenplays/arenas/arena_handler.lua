-- 3/11/19 Arena Handler, By: Mindsoft
arena_handler = ScreenPlay:new{
	allowedQuePlanets = { ["dantooine"]=true, ["tatooine"]=true, ["lok"]=true, ["rori"]=true, ["dathomir"]=true, ["talus"]=true, ["yavin4"]=true, ["corellia"]=true, ["naboo"]=true,["endor"]=true },

	areas = {
		tat = {
			zone = "tatooine",
			xStart = -8000,
			xEnd = 8000,
			yStart = 8000,
			yEnd = 7000,
			size = 1000,
		},

		tatOne = {
			zone = "arena_tatooine",
			xStart = -8000,
			xEnd = 0,
			yStart = 8000,
			yEnd = 0,
			size = 1000,
		},
		tatTwo = {
			zone = "arena_tatooine",
			xStart = 0,
			xEnd = 8000,
			yStart = 8000,
			yEnd = 0,
			size = 1000,
		},
		tatThree = {
			zone = "arena_tatooine",
			xStart = -8000,
			xEnd = 0,
			yStart = 0,
			yEnd = -8000,
			size = 1000,
		},
		tatFour = {
			zone = "arena_tatooine",
			xStart = 0,
			xEnd = 8000,
			yStart = 0,
			yEnd = -8000,
			size = 1000,
		},
	},
}
registerScreenPlay("arena_handler", true)

-- Start Handler
function arena_handler:start()
end

-- Get next free arena index in area, return as spawn-table {area,zone,x,z,y,index}
function arena_handler:getArena(areaName)
	local area = arena_handler.areas[areaName]
	local size = area.size
	local x = area.xStart + (.5 * size)
	local y = area.yStart - (.5 * size)
	local xMax = area.xEnd
	local yMax = area.yEnd
	local z = 0
	local index = 1
	local continue = true
	local data = 0
	while (continue == true) do
		local data = readData(areaName..":inx:"..tostring(index))
		if (data ~= 0) then
			x = x + size
			index = index + 1
			if (x > xMax) then
				x = area.xStart + (.5 * size)
				y = y - size
				if (y < yMax) then
					continue = false
				end
			end
		else
			local tbl = {areaName, area.zone, x, WFnav:getZ(area.zone, x, y), y, index}
			return tbl
		end
	end
	return false
end

-- Destroy List Objects
function arena_handler:destroyListObjects(list,delim)
	local tbl = {}
	tbl = HelperFuncs:splitString(list, delim)
	for k,v in ipairs(tbl) do
		Ihelp:destroy(getSceneObject(tonumber(v)))
	end
end

function arena_handler:unlockGroup(pGroup)
	LuaGroupObject(pGroup):setGroupLock(0)
	return 0
end

function arena_handler:setTef(pPlayer)
	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	LuaPlayerObject(pGhost):jediTef()
	TangibleObject(pPlayer):setPvpStatusBit(OVERT)
	return 0
end

-- Arena object and memory cleanup
function arena_handler:destroyArena(pControl) --clean up arena instance objects and memory
	print("destroying arena",pControl)
	local dataStr = readStringData(tostring(SceneObject(pControl):getObjectID())..":dataStr")
	local idStr = readStringData(dataStr..":deco") --read deco string
	deleteStringData(dataStr..":deco")
	deleteData(dataStr)
	deleteStringData(tostring(SceneObject(pControl):getObjectID())..":dataStr")

	--clean up areas
	local area = readData(dataStr..":combatArea")
	Ihelp:destroy(getSceneObject(area))

	area = readData(dataStr..":redArea")
	Ihelp:destroy(getSceneObject(area))

	area = readData(dataStr..":blueArea")
	Ihelp:destroy(getSceneObject(area))

	local g1 = readData(dataStr..":g1")
	deleteData(dataStr..":g1")
	local pG1 = getSceneObject(g1)
	if (pG1 ~= nil) then
		createEvent((2+math.random(5)), "arena_handler","unlockGroup", pG1, "")
	end

	local g2 = readData(dataStr..":g2")
	deleteData(dataStr..":g2")
	local pG2 = getSceneObject(g2)
	if (pG2 ~= nil) then
		createEvent((2+math.random(5)), "arena_handler","unlockGroup", pG2, "")
	end

	deleteData(dataStr..":combatArea")
	deleteData(dataStr..":redArea")
	deleteData(dataStr..":blueArea")
	deleteData(dataStr..":winScore")

	-- clean-up layout
	arena_handler:destroyListObjects(idStr,"/")

	-- clean-up scoreboard
	local pSB = getSceneObject(readData(dataStr..":SB"))
	deleteData(dataStr..":SB")
	arena_handler:destroyScoreboard(pSB)

	return 0
end

-- Initialize Scoreboard
function arena_handler:initializeScoreboard(time, pSBControl, zone, x, z, y) --Initialize Scoreboard objects and memory
	local timeNum = tonumber(time)
	local minutes = math.floor(timeNum / 60)
	local minutesX10 = math.floor(minutes/10)
	local minutesX1 = minutes - minutesX10 * 10

	local seconds = timeNum - (minutes*60)
	local secondsX10 = math.floor(seconds/10)
	local secondsX1 = seconds - secondsX10 * 10

	local minObX10 = spawnSceneObject(zone, "object/tangible/furniture/decorative/scoreboard_number_"..tonumber(minutesX10).."_01.iff", x-1.2, z, y, 0, math.rad(180))
	local minObX1 = spawnSceneObject(zone, "object/tangible/furniture/decorative/scoreboard_number_"..tonumber(minutesX1).."_01.iff", x-.6, z, y, 0, math.rad(180))
	local secObX10 = spawnSceneObject(zone, "object/tangible/furniture/decorative/scoreboard_number_"..tonumber(secondsX10).."_01.iff", x+.6, z, y, 0, math.rad(180))
	local secObX1 = spawnSceneObject(zone, "object/tangible/furniture/decorative/scoreboard_number_"..tonumber(secondsX1).."_01.iff", x+1.2, z, y, 0, math.rad(180))

	local redObX10 = spawnSceneObject(zone, "object/tangible/furniture/decorative/scoreboard_number_"..tonumber(0).."_01.iff", x-3.1, z-1.2, y, 0, math.rad(180))
	local redObX1 = spawnSceneObject(zone, "object/tangible/furniture/decorative/scoreboard_number_"..tonumber(0).."_01.iff", x-2.5, z-1.2, y, 0, math.rad(180))

	local blueObX10 = spawnSceneObject(zone, "object/tangible/furniture/decorative/scoreboard_number_"..tonumber(0).."_01.iff", x+2.5, z-1.2, y, 0, math.rad(180))
	local blueObX1 = spawnSceneObject(zone, "object/tangible/furniture/decorative/scoreboard_number_"..tonumber(0).."_01.iff", x+3.1, z-1.2, y, 0, math.rad(180))

	local dataStr = tostring(SceneObject(pSBControl):getObjectID())..":"

	dataStr = dataStr.."object:"
	--Write shared object memory
	writeData(dataStr.."minX10", SceneObject(minObX10):getObjectID())
	writeData(dataStr.."minX1", SceneObject(minObX1):getObjectID())
	writeData(dataStr.."secX10", SceneObject(secObX10):getObjectID())
	writeData(dataStr.."secX1", SceneObject(secObX1):getObjectID())
	writeData(dataStr.."redX10", SceneObject(redObX10):getObjectID())
	writeData(dataStr.."redX1", SceneObject(redObX1):getObjectID())
	writeData(dataStr.."blueX10", SceneObject(blueObX10):getObjectID())
	writeData(dataStr.."blueX1", SceneObject(blueObX1):getObjectID())

	if (timeNum > 0) then
		arena_handler:setScoreboard(pSBControl, time)
	end
end

--set scoreboard and update
function arena_handler:setScoreboard(pSBControl, time)
	if (pSBControl) then
		time = tonumber(time) or 0
		if (time > 0) then
			local dataStr = tostring(SceneObject(pSBControl):getObjectID())..":"
			local timeLeft = readData(dataStr.."timeLeft")
			if (timeLeft < 1) then
				--arena_handler:updateScoreboard(pSBControl, time)
				createEvent(1, "arena_handler","updateScoreboard", pSBControl, time)--tostring(timeNum-1))
			end
		end
		writeData(tostring(SceneObject(pSBControl):getObjectID())..":".."timeLeft", time)--update scoreboard with despawn timer(30 sec)
	end
end

-- Update Scoreboard
function arena_handler:updateScoreboard(pControl, time) --Update Scoreboard objects and memory
	local dataStr = tostring(SceneObject(pControl):getObjectID())..":"

	local timeNum = tonumber(time)
	if (timeNum == nil) then
		timeNum = tonumber(readData(dataStr.."timeLeft"))
	end

	--calc minutes
	local minutes = math.floor(timeNum / 60)
	local minutesX10 = math.floor(minutes/10)
	local minutesX1 = math.floor(minutes - minutesX10 * 10)

	--calc seconds
	local seconds = timeNum - (minutes*60)
	local secondsX10 = math.floor(seconds/10)
	local secondsX1 = math.floor(seconds - secondsX10 * 10)

	--store object values from memory
	local curMinX10 = readData(dataStr.."minX10")
	local curMinX1 = readData(dataStr.."minX1")
	local curSecX10 = readData(dataStr.."secX10")
	local curSecX1 = readData(dataStr.."secX1")

	--data string for objects use
	local dataObStr = dataStr.."object:"

	--Adjust minX10
	if (curMinX10 ~= minutesX10) then
		writeData(dataStr.."minX10", minutesX10)
		local temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(minutesX10).."_01.iff"
		local pSob = getSceneObject(readData(dataObStr.."minX10"))
		local ob = SceneObject(pSob)
		if (ob ~= nil) then
			local minObX10 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
			writeData(dataObStr.."minX10", SceneObject(minObX10):getObjectID())
			Ihelp:destroy(pSob)
		end
	end

	--Adjust minX1
	if (curMinX1 ~= minutesX1) then
		writeData(dataStr.."minX1", minutesX1)
		local temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(minutesX1).."_01.iff"
		local pSob = getSceneObject(readData(dataObStr.."minX1"))
		local ob = SceneObject(pSob)
		if (ob ~= nil) then
			local minObX1 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
			writeData(dataObStr.."minX1", SceneObject(minObX1):getObjectID())
			Ihelp:destroy(pSob)
		end
	end

	--Adjust secX10
	if (curSecX10 ~= secondsX10) then
		writeData(dataStr.."secX10", secondsX10)
		local temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(secondsX10).."_01.iff"
		local pSob = getSceneObject(readData(dataObStr.."secX10"))
		local ob = SceneObject(pSob)
		if (ob ~= nil) then
			local secObX10 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
			writeData(dataObStr.."secX10", SceneObject(secObX10):getObjectID())
			Ihelp:destroy(pSob)
		end
	end

	--Adjust secX1
	if (curSecX1 ~= secondsX1) then
		writeData(dataStr.."secX1", secondsX1)
		local temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(secondsX1).."_01.iff"
		local pSob = getSceneObject(readData(dataObStr.."secX1"))
		local ob = SceneObject(pSob)
		if (ob ~= nil) then
			local secObX1 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
			writeData(dataObStr.."secX1", SceneObject(secObX1):getObjectID())
			Ihelp:destroy(pSob)
		end
	end

	if (timeNum > 0) then
		createEvent(1000, "arena_handler","updateScoreboard", pControl, "")--tostring(timeNum-1))
		writeData(dataStr.."timeLeft", timeNum - 1)
	end
end

--Play music/sound message on player
function arena_handler:playSound(pPlayer, snd)
	if (pPlayer and snd) then
		CreatureObject(pPlayer):playMusicMessage(snd) -- Play Music Message on Player
	end
end

--return red team score for for scoreboard controler object
function arena_handler:getRedScore(pControl)
	local dataStr = tostring(SceneObject(pControl):getObjectID())..":"
	local redX10 = readData(dataStr.."redX10")
	local redX1 = readData(dataStr.."redX1")
	return ((redX10 * 10) + redX1)
end

--return blue team score for for scoreboard controler object
function arena_handler:getBlueScore(pControl)
	local dataStr = tostring(SceneObject(pControl):getObjectID())..":"
	local blueX10 = readData(dataStr.."blueX10")
	local blueX1 = readData(dataStr.."blueX1")
	return ((blueX10 * 10) + blueX1)
end

-- Increase Red Score by 1
function arena_handler:incrementRedScore(pControl)
	local dataStr = tostring(SceneObject(pControl):getObjectID())..":"
	local dataObStr = dataStr.."object:"
	local redX10 = readData(dataStr.."redX10")
	local redX1 = readData(dataStr.."redX1")
	if (redX1+1 > 9) then
		writeData(dataStr.."redX10",redX10+1)
		writeData(dataStr.."redX1",0)

		local redObX1 = readData(dataObStr.."redX1")
		local temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(redX10+1).."_01.iff"
		local pSob = getSceneObject(readData(dataObStr.."redX10"))
		local ob = SceneObject(pSob)
		local redObX10 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
		writeData(dataObStr.."redX10", SceneObject(redObX10):getObjectID())
		Ihelp:destroy(pSob)

		temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(0).."_01.iff"
		pSob = getSceneObject(readData(dataObStr.."redX1"))
		ob = SceneObject(pSob)
		redObX1 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
		writeData(dataObStr.."redX1", SceneObject(redObX1):getObjectID())
		Ihelp:destroy(pSob)
	else
		writeData(dataStr.."redX1",redX1+1)
		local redObX1 = readData(dataObStr.."redX1")
		local temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(redX1+1).."_01.iff"
		local pSob = getSceneObject(redObX1)
		local ob = SceneObject(pSob)
		redObX1 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
		writeData(dataObStr.."redX1", SceneObject(redObX1):getObjectID())
		Ihelp:destroy(pSob)
	end

	return 0
end

-- Increase Blue Score by 1
function arena_handler:incrementBlueScore(pControl)
	local dataStr = tostring(SceneObject(pControl):getObjectID())..":"
	local dataObStr = dataStr.."object:"
	local blueX10 = readData(dataStr.."blueX10")
	local blueX1 = readData(dataStr.."blueX1")
	if (blueX1+1 > 9) then
		writeData(dataStr.."blueX10",blueX10+1)
		writeData(dataStr.."blueX1",0)

		local blueObX1 = readData(dataObStr.."blueX1")

		local temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(blueX10+1).."_01.iff"
		local pSob = getSceneObject(readData(dataObStr.."blueX10"))
		local ob = SceneObject(pSob)
		local blueObX10 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
		writeData(dataObStr.."blueX10", SceneObject(blueObX10):getObjectID())
		Ihelp:destroy(pSob)

		temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(0).."_01.iff"
		pSob = getSceneObject(readData(dataObStr.."blueX1"))
		ob = SceneObject(pSob)
		blueObX1 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
		writeData(dataObStr.."blueX1", SceneObject(blueObX1):getObjectID())
		Ihelp:destroy(pSob)
	else
		writeData(dataStr.."blueX1",blueX1+1)
		local blueObX1 = readData(dataObStr.."blueX1")
		local temp = "object/tangible/furniture/decorative/scoreboard_number_"..tostring(blueX1+1).."_01.iff"
		local pSob = getSceneObject(readData(dataObStr.."blueX1"))
		local ob = SceneObject(pSob)
		local blueObX1 = spawnSceneObject(ob:getZoneName(), temp, ob:getWorldPositionX(), ob:getWorldPositionZ(), ob:getWorldPositionY(), 0, math.rad(180))
		writeData(dataObStr.."blueX1", SceneObject(blueObX1):getObjectID())
		Ihelp:destroy(pSob)
	end

	return 0
end

function arena_handler:messageGroup(pGroup, str)
	if ((pGroup == nil) or (str == nil)) then
		return 0
	end

	local gOB = LuaGroupObject(pGroup)
	local pList = gOB:getPlayerList()

	for k,v in pairs(pList) do
		CreatureObject(v):sendSystemMessage(str)
	end
	return 0
end

function arena_handler:updateJediTEF(pPlayer)
	if (pPlayer == nil or (not SceneObject(pPlayer):isPlayerCreature()) or CreatureObject(pPlayer):isDead()) then
		return 0
	end

	local zone = CreatureObject(pPlayer):getZoneName()
	if (string.find(zone, "arena") ~= nil) then
		local pGhost = CreatureObject(pPlayer):getPlayerObject()
		if (pGhost ~= nil) then
			LuaPlayerObject(pGhost):jediTef()
			createEvent((240 + math.random(30)) * 1000, "arena_handler", "updateJediTEF", pPlayer, "")
		end
	end
	return 0
end

-- Scoreboard memory and object Clean-up
function arena_handler:destroyScoreboard(pControl) --clean up Scoreboard objects and memory
	if ((pControl == nil) or (SceneObject(pControl) == nil)) then
		print("ERROR: NIL SCENE OBJECT, in- arena_handler:destroyScoreboard")
		return 0
	end

	local dataStr = tostring(SceneObject(pControl):getObjectID())..":"

	--destroy shared value memory
	deleteData(dataStr.."minX10")
	deleteData(dataStr.."minX1")
	deleteData(dataStr.."secX10")
	deleteData(dataStr.."secX1")
	deleteData(dataStr.."redX10")
	deleteData(dataStr.."redX1")
	deleteData(dataStr.."blueX10")
	deleteData(dataStr.."blueX1")

	--update data string for objects use
	dataStr = dataStr.."object:"

	--locally store shared object memory
	local MinX10 = readData(dataStr.."minX10")
	local MinX1 = readData(dataStr.."minX1")
	local SecX10 = readData(dataStr.."secX10")
	local SecX1 = readData(dataStr.."secX1")
	local redX10 = readData(dataStr.."redX10")
	local redX1 = readData(dataStr.."redX1")
	local blueX10 = readData(dataStr.."blueX10")
	local blueX1 = readData(dataStr.."blueX1")

	--destroy shared object memory
	deleteData(dataStr.."minX10")
	deleteData(dataStr.."minX1")
	deleteData(dataStr.."secX10")
	deleteData(dataStr.."secX1")
	deleteData(dataStr.."redX10")
	deleteData(dataStr.."redX1")
	deleteData(dataStr.."blueX10")
	deleteData(dataStr.."blueX1")

	--destroy objects
	Ihelp:destroy(getSceneObject(MinX10))
	Ihelp:destroy(getSceneObject(MinX1))
	Ihelp:destroy(getSceneObject(SecX10))
	Ihelp:destroy(getSceneObject(SecX1))
	Ihelp:destroy(getSceneObject(redX10))
	Ihelp:destroy(getSceneObject(redX1))
	Ihelp:destroy(getSceneObject(blueX10))
	Ihelp:destroy(getSceneObject(blueX1))
	Ihelp:destroy(pControl)
end

-- Scoreboard memory and object Clean-up
function arena_handler:onLoggedIn(pPlayer) --clean up Scoreboard objects and memory
	local zone = CreatureObject(pPlayer):getZoneName()
	if (string.find(zone, "arena") ~= nil) then
		local arenaID = readData(tostring(SceneObject(pPlayer):getObjectID())..":BoundArena")
		local pArena = getSceneObject(arenaID)
		if not(pArena and CreatureObject(pPlayer):isInRangeWithObject(pArena, 950)) then
			arena_handler:ejectPlayer(pPlayer)
		else
			createEvent(20, "arena_handler", "updateJediTEF", pPlayer, "")--slight pause before updating tef
		end
	else
 		dropObserver(LOGGEDIN, "arena_handler", "onLoggedIn", pPlayer)
	end
	return 0
end

-- Eject Player from Arena Zone to staging areas
function arena_handler:ejectPlayer(pPlayer)
	SceneObject(pPlayer):switchZone("tatooine", WFnav:rndRng(3494, 5), 5, WFnav:rndRng(-4786, 5), 0)
	--TODO add staging areas
	dropObserver(LOGGEDIN, "arena_handler", "onLoggedIn", pPlayer)
end

--Validate creature for interactions valid factions = "rebel", "imperial", "gcw", (any other string defaults to neutral)
function arena_handler:validatePlayer(pPlayer, faction)
	if (pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return false
	end

	local sob = SceneObject(pPlayer)
	local creo = CreatureObject(pPlayer)

	local pGhost = creo:getPlayerObject()
	if ((pGhost == nil) or (not PlayerObject(pGhost):isOnline())) then
		return false
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

function arena_handler:validateGroup(gOB, max, str, faction)
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
		CreatureObject(playerList[i]):sendSystemMessage("Arena:Your Group Leader has Queued for "..str)
		isValid = isValid and arena_handler:validatePlayer(playerList[i], faction)
	until ((i >= memCount) or (isValid == false))

	return isValid
end
