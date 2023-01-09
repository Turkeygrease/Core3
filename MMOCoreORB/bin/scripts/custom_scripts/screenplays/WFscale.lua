--[[ By: Michael Simnitt aka Mindsoft
Date: Aug/14/2018
Description: Scalable Mobile Event Screenplay and Handler Utilities
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]
---------------------------------------------(Scalable Event Screenplay & Spawns)
WFscale = ScreenPlay:new{
	["waypoints1"] = { --{Planet, X, Z, Y, Facing direction, Cell id, RaNGe}
		{"dathomir", -201.6, 27.9, -1628.3, 102, 0},
		{"dathomir", -146.3, 34.6, -1486.9, math.random(360), 0},
		{"dathomir", 48.3, 33.8, -1548.7, math.random(360), 0},
		{"dathomir", -50.4, 24.1, -1723.4, -35, 0},
	},

	--test boss table
	boss = {
		stringData = "WFscale.boss", --   <---(*FIELD REQUIRED*) string pointer to this table
		wpList = "WFscale.waypoints1", --string pointer to the waypoint list OR table of waypoints in {p,x,z,y,f,c,rng} format
		spawnRange = false, --if false spawns at initial x,z,y , if int spawns random(+/-)int x,y from initial x,y 
		respawnTimer = false, --if false no respawn, if int>0 respawns in int seconds
		respawns = false, --if false unlimited respawns, if int>0 respawns int times (uses sharedData)
		despawn = false, --if false no despawn, if int>0 despawn in int seconds
		intro = "Hello youngling...", --if false no intro, if string spatials intro when engaged
		broadcast = false, --if false no broadcast, if string broadcast that string, ie: broadcast = "boss spawned",
		taunts = { --if false no taunts, if table uses taunts
			"You can't hurt me..",
			"Do you think that will save you?",
			"You should run now, child!",
		},
		spawnEvent = false, --if false use default, if function run function instead of default
		deathEvent = false,--if false use default, if function run function instead of default
		aiTemplate = "idlewander", --if false no template change, if string set as current ai template
		addEvent = false, --if false use default, if  function run function instead of default
		adds = { --if false no add, if table run table[i] at HAM/#table intervals, ie:2 lists in table is 66%HAM and 33%HAM
			--#SubType, #toSpawn, #range, spawns1,..spawn3
			{0, 2, 10, "chuba","kwi"},
			{0, 0, 5, "purbole", "kamurith_snapper","rancor"},
		},
		triggerEvent = false, --if false use default, if function run function instead of default
		trigger = false, --if false no trigger, if string pointer to the trigger NPC table to be spawned
	},
	
	genericNPC = { --use to easily set up npc with wander
		stringData = "WFscale.genericNPC", --   <---(*FIELD REQUIRED*)
		aiTemplate = "idlewander",
		spawnRange = 2, --if false spawns at initial x,z,y , if int spawns random(+/-)int x,y from initial x,y 
	},

	--test group boss spawnlist
	spawnList3 = "purbole/chuba/large_chuba/kwi/bolma",
}
registerScreenPlay("WFscale", false)

--Spawn Quest givers and triggers.
function WFscale:start()
	--dath test spawnlist mixed
	local spawnList = {"purbole", "kamurith_snapper", "mature_reptilian_flier", "kwi", "kinad_baz_nitch", "shear_mite_broodling", "ancient_reptilian_flier", "gaping_spider_recluse_queen", "gaping_spider_recluse","rancor", "spiderclan_stalker", "singing_mountain_clan_initiate", "bolma", "nightsister_ranger", "gaping_spider"}

	--dath test spawnlist harder
	local spawnList2 = "singing_mountain_clan_initiate/rancor/gaping_spider/gaping_spider_recluse_queen"

	--spawnScaledMobile(Planet,Template,Respawn,X,Z,Y,Direction,CellID, ScaleType or ScaleTable, ScaleFactor, Scale-or-Range )

	-- (Forced Spawn) Type:0 , spawn pre-scaled mobiles , from spawn list (table)
	local mob = spawnScaledMobile("dathomir", spawnList, 1200, 3203, 57.3, 1521.3, math.random(360), 0, 0, .02, 30)
	mob = spawnScaledMobile("dathomir", spawnList, 1200, 3200.9, 62.8, 1605.5, math.random(360), 0, 0, .1, 30)
	mob = spawnScaledMobile("dathomir", spawnList, 1200, 3101, 62.2, 1516.9, math.random(360), 0, 0, .15, 30)
	mob = spawnScaledMobile("dathomir", spawnList2, 1200, 3139.6, 63.7, 1588.5, math.random(360), 0, 0, .2, 30)
	mob = spawnScaledMobile("dathomir", spawnList2, 1200, 3044.7, 64.7, 1443.9, math.random(360), 0, 0, .25, 30)

	-- (Forced Spawn) Type:0 , spawn pre-scaled mobiles , from template (string) , scale:0.3 , (Max-Reccomended)
	mob = spawnScaledMobile("dathomir", "gaping_spider_recluse", 1200, 3248.6, 62.2, 1585, math.random(360), 0, 0, .3, 30)

	-- (Forced Spawn) Type:0 , spawn pre-scaled mobiles , from spawn list (string) , scale:0.5 , (Forced *no scale given)
	mob = spawnScaledMobile("dathomir", "purbole/mature_reptilian_flier/kamurith_snapper", 1200, 3229.4, 132.8, 1727.9, math.random(360), 0, 0, .5)

	-- (Forced Spawn) Type:0 , spawn pre-scaled mobiles , from spawn list (table) , scale:5.5 , (Forced *-1 scale given)
	mob = spawnScaledMobile("dathomir", spawnList, 1200, 3287, 64, 1642, math.random(360), 0, 0, 5.5, -1)

	-- (Group Scaled Spawn) Type:1 , PGS-scaled mobiles , from spawn list (string) , scale:0.5 , (Range *is scale given)
	mob = spawnScaledMobile("dathomir", spawnList2, 1200, 3475.9, 26.4, 1586.2, math.random(360), 0, 1, .1, 70)
	mob = spawnScaledMobile("dathomir", spawnList2, 1200, 3391.9, 22.9, 1583.8, math.random(360), 0, 1, .15, 70)
	mob = spawnScaledMobile("dathomir", spawnList2, 1200, 3428.2, 24.4, 1442.7, math.random(360), 0, 1, .2, 70)
	mob = spawnScaledMobile("dathomir", spawnList2, 1200, 3474.9, 19.6, 1312.4, math.random(360), 0, 1, .25, 70)
	mob = spawnScaledMobile("dathomir", WFscale.spawnList3, 1200, 3442.8, 54.8, 1501.2, math.random(360), 0, 1, 1, 70)

	-- (Area Scaled Spawn) Type:2+Table , PGS-scaled mobiles , from template (string) , scale:0.3 , (Range *is scale given)
	mob = spawnScaledMobile("dathomir", "rancor/purbole/bolma", 1200, 470.3, 34.8, 2925.7, 60, 0, {2, self.genericNPC}, .3, 90)

	-- (Area Scaled Spawn) Type:2+Table , PGS-scaled mobiles , from spawn list (string) , scale:0.2 , (Range *is scale given)
	mob = spawnScaledMobile("dathomir", spawnList2, 900, -190.3, 26.8, -1654.1, 77, 0, {2, self.boss}, .2, 90)
end

---------------------------------------------(Scalable Group Damage Reaction) (Type:1)
function WFscale:groupAttackTest(pMob, pPlayer, dmg)
	if not(SceneObject(pPlayer):isCreatureObject()) then
		print("\nERROR: Scalable Mobile Group Event Activated By Non-Creature-Object\n")
		return 0
	end

	if not(SceneObject(pPlayer):isPlayerCreature()) then
		if (SceneObject(pPlayer):isAiAgent() and not AiAgent(pPlayer):isPet()) then
			return 0
		elseif not (SceneObject(AiAgent( pPlayer ):getOwner()):isPlayerCreature()) then
			print("-Error Non-Player-Owned Pet AI-Agent: Scaling Terminated,  Owner Name: "..SceneObject(AiAgent(pPlayer):getOwner()):getDisplayedName())
			return 0
		else
			local owner = AiAgent(pPlayer):getOwner()
			pPlayer = owner
		end
	end
	dropObserver(DAMAGERECEIVED, "WFscale", "groupAttackTest",pMob)
	local str = readStringData(SceneObject(pMob):getObjectID() .. ":ScaledRespawn")
	local arr = {}
	arr = HelperFuncs:splitString(str, ",")
	local range = tonumber(arr[11]) or 35 --set default range to 35 (temp fix for AT_XT TODO)
	local pgs = getGroupScale(pPlayer, pMob, range) --Get pgs(Player Group Scale) Value
	local scaleFactor = tonumber(arr[10]) or .05 --set default scaleFactor to .05 (temp fix for AT_XT TODO)
	local mod = 1 + (scaleFactor * pgs) --adjust for base and add scaled PGS modifier
	local name = SceneObject(pMob):getObjectName()
	if (name == "") then
		name = SceneObject(pMob):getCustomObjectName()
		name = string.gsub(name, " %(Scalable%)", "")
	end
	CreatureObject(pMob):setCustomObjectName(name..getScaledRank(mod))
	scaleMobile(pMob,mod)
	return 0
end

---------------------------------------------(Scalable Area Damage Reaction) (Type:2)
function WFscale:areaAttackTest(pMob, pPlayer, dmg)--TODO
	if not(SceneObject(pPlayer):isCreatureObject()) then
		print("\nERROR: Scalable Mobile Group Event Activated By Non-Creature-Object\n")
		return 0
	end

	if (SceneObject(pPlayer):isPlayerCreature()) then --TODO bad logic arrangement in nested if
		--print("\n*Activated Area By Player Object")
	elseif (SceneObject(pPlayer):isAiAgent() and not AiAgent(pPlayer):isPet()) then
		return 0
	elseif not (SceneObject(AiAgent( pPlayer ):getOwner()):isPlayerCreature()) then
		print("-Error Non-Player-Owned Pet AI-Agent: Scaling Terminated,  Owner Name: "..SceneObject(AiAgent(pPlayer):getOwner()):getDisplayedName())
		return 0
	end

	dropObserver(DAMAGERECEIVED, "WFscale", "areaAttackTest",pMob)
	local str = readStringData(SceneObject(pMob):getObjectID() .. ":ScaledRespawn")
	--print("-Reading Scaled Mobile String: "..str)
	local arr = {}
	arr = HelperFuncs:splitString(str, ",")
	local range = tonumber(arr[11]) or 35 --set default range to 35 (temp fix for AT_XT TODO)
	local playerTable = SceneObject(pMob):getPlayersInRange(range)
	--print("-Players in Area: "..tostring(#playerTable))
	local pgs = 0
	local i = 1
	repeat
		local pMember = playerTable[i]
		if (WFplayerTest(pMember, false, pMob, range, true)) then
			pgs = pgs + 1
		end
		i = i + 1
	until i > #playerTable

	local scaleFactor = tonumber(arr[10]) or .05 --set default scaleFactor to .05 (temp fix for AT_XT TODO)
	local mod = 1 + (scaleFactor * pgs) --adjust for base and add scaled PGS modifier
	local name = SceneObject(pMob):getObjectName()
	if (name == "") then
		name = SceneObject(pMob):getCustomObjectName()
		name = string.gsub(name, " %(Scalable%)", "")
	end
	CreatureObject(pMob):setCustomObjectName(name..getScaledRank(mod))
	scaleMobile(pMob,mod)
	return 0
end

---------------------------------------------(Scalable Schedule Respawn)
function WFscale:scaledMobileRespawn(pMob, pKiller)
	dropObserver(DAMAGERECEIVED, pMob)
	dropObserver(OBJECTDESTRUCTION, "WFscale", "scaledMobileRespawn",pMob)
	local str = readStringData(SceneObject(pMob):getObjectID() .. ":ScaledRespawn")
	local stringData = readStringData(SceneObject(pMob):getObjectID() .. ":scaledStringData")
	local arr = {}
	arr = HelperFuncs:splitString(str, ",")
	local respawn = tonumber(arr[3])
	if (stringData ~= "") then
		str = str..","..stringData
		deleteStringData(SceneObject(pMob):getObjectID() .. ":scaledStringData")
	end
	if (respawn > 0) then
		createEvent(respawn*1000,"WFscale","scaledMobileRespawnEvent",pMob,str)
	end
	deleteStringData(SceneObject(pMob):getObjectID() .. ":ScaledRespawn")
	return 0
end

---------------------------------------------(Scalable Respawn)
function WFscale:scaledMobileRespawnEvent(pMob, msg)
	local arr = {}
	arr = HelperFuncs:splitString(msg, ",")
	arr[9] = tonumber(arr[9])
	if (arr[12]) then --check for a spawn location table string pointer
		arr[9] = {arr[9],arr[12]}
	end
	spawnScaledMobile(arr[1],arr[2],tonumber(arr[3]),tonumber(arr[4]),tonumber(arr[5]),tonumber(arr[6]),tonumber(arr[7]),tonumber(arr[8]),arr[9],tonumber(arr[10]),tonumber(arr[11]))
end



--***************************************** ( Scalable Tools ) *****************************************



-- 	mob = spawnScaledMobile("tatooine", "chuba", -1, 3467, 5, -4827, 90, 0,.3,30)
function spawnScaledMobile(p,t,r,x,z,y,f,c,scaleType,scaleFactor,scale)
	local storedSpawn = t
	local spawnList = {}
	if(type(t)=="table")then
		storedSpawn = table.concat(storedSpawn,"/")
		spawnList = t --Table passed-in so set Spawn-List to Table
	else
		spawnList = HelperFuncs:splitString(t, "/") --Split Spawn-List from string
	end

	t=(spawnList[math.random(#spawnList)]) --Choose Mobile Template from List of templates
	if (c == 0) then
		z = WFnav:getZ(p,x,y)
	end
	local pMob = spawnMobile(p,t,-1,x,z,y,f,c)
	if (pMob == nil) then
		print("\nERROR: in spawnScaledMobile, Mobile not spawned\n")
		return
	end

	local mob = CreatureObject(pMob)
	if (mob==nil) then
		print("\nERROR: in spawnScaledMobile, Mobile not CreatureObject\n")
		SceneObject(pMob):destroyObjectFromWorld()
		return
	end

	local obTable = false --check for a table in scale type (advanced controls)
	local stringData = false
	local control, func
	if (type(scaleType) == "table") then
		obTable = scaleType
		scaleType = obTable[1]
		if (type(obTable[2])=="table") then --controller is a table
			control = obTable[2]
			writeStringData(SceneObject(pMob):getObjectID() .. ":scaledStringData", obTable[2].stringData)
		else
			func = load('return '..obTable[2]) --controller is a string pointer to table
			control = func()
			writeStringData(SceneObject(pMob):getObjectID() .. ":scaledStringData", obTable[2])
		end
		--print("**spawnScaledMobile: ScaleType TABLE found, found ScaleType: "..tostring(scaleType))
		if (control.aiTemplate) then
			--print("AI Template found: "..control.aiTemplate)
			AiAgent(pMob):setAiTemplate("")
			--AiAgent(pMob):setAiTemplate(control.aiTemplate)
		end
	end

	if (readStringData(SceneObject(pMob):getObjectID() .. ":scaledStringData") ~="") then
		stringData = readStringData(SceneObject(pMob):getObjectID() .. ":scaledStringData")
		func = load('return '..stringData)
		control = func()
		if (control) then
			if (control.wpList) then --waypoint Table Found
				local way = false
				if (type(control.wpList)=="table") then -- table of wp's found
					way = control.wpList[math.random(#control.wpList)]
				else --assumes is string pointer to table of wp's
					--print("-String Pointer to Waypoints List:"..control.wpList)
					func = load('return '..control.wpList)
					local ways = func()
					if (type(ways[1]) == "table") then -- test for single waypoint instead of list
						way = ways[math.random(#ways)]
					else
						way = ways
					end
				end
				--print("-Randomly Selected Waypoint: "..table.concat(way, ","))
				p=way[1]; x=way[2]; z=way[3]; y=way[4]; f=way[5]; c=way[6]
			end
			if (control.aiTemplate) then
				--TODO AiAgent(pMob):setAiTemplate(control.aiTemplate)
			end
		end
	end

	--print("*Spawned Scaling Mobile info, Type:"..t.."  Planet:"..p.."  ScaleType:"..scaleType.."  PassedTable:"..tostring(obTable == true))

	local shouldScale = false -- initialize scale flag (true = mobile should be scaled now)
	local scaledRank = " (Scalable)" --initialize default name for scalable mobiles
	local respawn = false -- initialize respawn flag (true = a respawn should be set up)

	-- Get Scale Type and Set up Observers+Events+Data-Handling
	if (scaleType == 0) then --Pre-Scaled and Over-Ride
		shouldScale = true

	elseif (scaleType == 1) then --Group Scaled (group members in Range)
		if (type(scale) ~= "number") then
			print("\nERROR: Expected (number got "..type(scale)..") for \"Range\" in spawnScaledMobile type=1\n")
		end
		createObserver(DAMAGERECEIVED, "WFscale", "groupAttackTest",pMob)--setup group Scaling
		shouldScale = false --scaling will be handled by observer callback

	elseif (scaleType == 2) then --Area Range (Range + LOS)
		createObserver(DAMAGERECEIVED, "WFscale", "areaAttackTest",pMob)--setup group Scaling
		shouldScale = false --scaling will be handled by observer callback
		respawn = true

	elseif (scaleType == 3) then --Cell (group Members in range + LOS Area)
		--TODO
	elseif (scaleType == 4) then --Boss Trigger (Pass Back for External Control)
		--TODO
		return pMob --TODO respawn and name must be handled on recieving end
	else
		print("\nERROR: in spawnScaledMobile Scale Type "..tostring(scaleType).."\n")
		SceneObject(pMob):destroyObjectFromWorld()
		return
	end

	if (shouldScale) then
		local mod = scaleFactor --Used for Over-riding scale
		if (scale ~= -1 and scale) then --If scale was passed (DO NOT) over-ride
			mod = 1 + (scaleFactor * scale) --adjust for base and add scaled modifier
			scaledRank = getScaledRank(mod)
		else
			scale = -1
			if (scaleFactor > 10) then
				scaledRank = "(EPIC "..tostring(scaleFactor-10)..")"
			else
				scaledRank = "(Scaled "..tostring(scaleFactor)..")"
			end
		end

		--print("-Scaled String: "..scaledRank.."\tScaled Int: "..getScaledRank(mod,true))
		scaleMobile(pMob,mod)
	end
	mob:setCustomObjectName(SceneObject(pMob):getDisplayedName()..scaledRank)

	if (respawn or (r > 0)) then
		local spawnString = p..","..storedSpawn..","..r..","..x..","..z..","..y..","..f..","..c..","
		spawnString = spawnString..scaleType..","..scaleFactor..","..scale
		writeStringData(SceneObject(pMob):getObjectID() .. ":ScaledRespawn",(spawnString))
		if (r > 0) then
			createObserver(OBJECTDESTRUCTION, "WFscale", "scaledMobileRespawn",pMob)
		end
	end
	return pMob
end

--return rank string, or if returnInt = true return rank int
function getScaledRank(mod,returnInt)
	if (mod == nil or mod < 0) then
		return 0
	end

	local adjMod = mod - 1 --adjust for base
	local scaledRank = "()" -- Rank String
	local rank = 0; -- Rank Integer

	if (adjMod > 9) then --if scale forced over limits
		scaledRank = " (EPIC "..tostring(mod)..")"
		rank = 5
	elseif (adjMod > 6.39) then
		scaledRank = " (Legendary "..tostring(mod)..")"
		rank = 4
	elseif (adjMod > 4.79) then
		scaledRank = " (Elite "..tostring(mod)..")"
		rank = 3
	elseif (adjMod > 3.19) then
		scaledRank = " (Hard "..tostring(mod)..")"
		rank = 2
	elseif (adjMod > 1.59) then
		scaledRank = " (Heavy "..tostring(mod)..")"
		rank = 1
	else
		scaledRank = " (Adept "..tostring(mod)..")"
		rank = 0
	end

	if (returnInt) then --if bool returnInt == true, return int intstead of string
		return rank --Return Rank Integer
	end
	return scaledRank --Return Rank String
end

--scale moble using mod
function scaleMobile(pMob,mod)
	local mob = CreatureObject(pMob)
	if (mob == nil or mod == nil or mod < 0) then
		print("\nERROR: (nil creature or mod, or invalid mod) in scaleMobile (Mobile not Scaled)\n")
		return 0
	end

	local level = mob:getLevel()
	local scaledLevel = math.floor(level+mod*((500-level)/80))
	if scaledLevel > 500 then
		scaledLevel = 500
	end
	AiAgent(pMob):setLevel(scaledLevel)
	--print("-Scaling NPC: -Template Level: "..level.."  Mod: "..tostring(mod).."  Final Level: "..tostring(mob:getLevel()))
	local i = 0
	repeat
		mob:setMaxHAM(i,mob:getMaxHAM(i) * mod)
		mob:setHAM(i, mob:getMaxHAM(i))
		i = i + 1
	until i == 9
	return 0
end

--Return the PGS
function getGroupScale(pPlayer, pMob, range, testCell, testLOS, testFaction)--TODO add tests
	local pgs = 0
	if (SceneObject(pPlayer):isPlayerCreature() and CreatureObject(pPlayer):isGrouped())then
		player = CreatureObject(pPlayer)
		if (player == nil) then
			print("\nERROR: in getGroupScale, player = nil\n")
			return 0
		end
		local groupSize = player:getGroupSize()
		--print("\n*Calculating group Scale, Range: "..tostring(range).." , GroupSize: "..tostring(groupSize))
		local i = 0
		repeat
			local pMember = player:getGroupMember(i)
			if (WFplayerTest(pMember, false, pMob, range, false)) then
				pgs = pgs + 1
			end
			i = i + 1
		until i >= groupSize
	end
	--print("\n-Returning PGS, Valid Members in Range: "..tostring(pgs).."\n")
	return pgs
end

--Test if is validPlayerObject, bool isInCombat, isInRangeOfCreature, if aiHasLos to creature
function WFplayerTest(pPlayer, checkCombat, pSob, range, checkLOS)
	if (pPlayer ~= nil and SceneObject(pPlayer):isPlayerCreature()) then
		creo = CreatureObject(pPlayer)
		if (creo:isDead() or creo:isIncapacitated() or (checkCombat and creo:isInCombat())) then
			return false
		end
		local pGhost = creo:getPlayerObject()
		if ((pGhost ~= nil) and PlayerObject(pGhost):isOnline()) then
			if ((pSob and range) and not(SceneObject(pPlayer):getDistanceTo(pSob) <= range)) then
				return false
			elseif (checkLOS) then
				if not(SceneObject(pSob):isAiAgent()) then
					print("\nERROR: NON-AiAgent Attempt to check LOS in WFplayerTest\n")
					return false
				elseif not(AiAgent(pSob):checkLineOfSight(pPlayer)) then
					return false
				end
			end
			return true
		end
	end
	return false
end

--[[
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]
