require("../custom_scripts/screenplays/mindsoft/bf_tools_convo_api")

table.getn = function(tbl)
	local count = 0
	for k,v in pairs(tbl) do count = count + 1 end
	return count
end
	

glowieTrialExpansion = ScreenPlay:new { 
	numberOfActs = 1, 
	screenplayName = "glowieTrialExpansion" --add screenplay name for squad control.
}

registerScreenPlay("glowieTrialExpansion", true) --register screenplay<glowieTrialExpansion> and start<true> on load.

function glowieTrialExpansion:start() --The :start() function is the "beginning" for all screenplays.
	writeData("glowieTrialLastFaction",0)
	glowieTrialExpansion.repeater()
end

--Choose a faction:
function glowieTrialExpansion:chooseFaction()
	local fTable = {

	--Add New Factions Here:
	"imp","reb","neutral"

	}
	
	local fListCount = table.getn(fTable)
	local fChoice = math.random(1,fListCount)
	local fPrevious = readData("glowieTrialLastFaction")
	while fPrevious == fChoice do
		fChoice = math.random(1,fListCount)
	end
	writeData("glowieTrialLastFaction",fChoice)
	fChoice = (fTable[fChoice])
	return(fChoice)
end

--Choose A mobile from the (factions) list:
function glowieTrialExpansion:chooseMobile(mFaction)
	local mTable = {
		["imp"] = {
		"glowie_imp_a",
		"glowie_imp_b",
		"glowie_imp_c"

		},

		["reb"] = {
		"glowie_reb_a",
		"glowie_reb_b",
		"glowie_reb_c"

		},
		["neutral"] = {
		"dark_jedi_sentinel",
		"dark_jedi_knight",
		"enhanced_gaping_spider"

		}
	}

	local mListcount = table.getn(mTable[mFaction])
	local mChoice = math.random(1,mListcount)
	mChoice = (mTable[mFaction][mChoice])
	return(mChoice)
end

--Choose a location to spawn the selected mobile:
function glowieTrialExpansion:chooseLocation(lFaction)
	--Add waypoints here.
	---(note:make sure to place in proper faction).
	local lTable = {
		["imp"] = {
			{-812, 84, -1979}, -- blue leaf
			{-833, 84, -2133},  -- blue leaf
			{-3209, 72, -2973}, -- Massassi
			{-3052, 72, -2799}, -- Massassi
			{5090, 73, 5530}, --<-- exar
			{4980, 86, 5445}, --<-- exar
			{5182, 83, 5555} --<-- exar
		},
		["reb"] = {
			{-812, 84, -1979}, -- blue leaf
			{-833, 84, -2133},  -- blue leaf
			{-3209, 72, -2973}, -- Massassi
			{-3052, 72, -2799}, -- Massassi
			{5090, 73, 5530}, --<-- exar
			{4980, 86, 5445}, --<-- exar
			{5182, 83, 5555} --<-- exar
		},
		["neutral"] = {
			{-812, 84, -1979}, -- blue leaf
			{-833, 84, -2133},  -- blue leaf
			{-3209, 72, -2973}, -- Massassi
			{-3052, 72, -2799}, -- Massassi
			{5090, 73, 5530}, --<-- exar
			{4980, 86, 5445}, --<-- exar
			{5182, 83, 5555} --<-- exar
		}
	}
	local lListcount = table.getn(lTable[lFaction])
	local lChoice = math.random(1,lListcount)
	lChoice = (lTable[lFaction][lChoice])
	return(lChoice)
end

function glowieTrialExpansion:spawnAdds(pBoss,pPlayer)
	if not LuaSceneObject(pPlayer):isCreature() then
		return 0
	end
	local player = LuaCreatureObject(pPlayer)
	local boss = LuaCreatureObject(pBoss)
	if (boss ~= nil) then
		local bossHealth = boss:getHAM(0)
		local bossAction = boss:getHAM(3)
		local bossMind = boss:getHAM(6)
		local bossMaxHealth = boss:getMaxHAM(0)
		local bossMaxAction = boss:getMaxHAM(3)
		local bossMaxMind = boss:getMaxHAM(6)
		local xBoss = boss:getPositionX()
		local yBoss = boss:getPositionY() 
		if (bossHealth <= (bossMaxHealth *0.5)) or (bossAction <= (bossMaxAction * 0.5)) or (bossMind <= (bossMaxMind *0.5)) then
			local spawnList = {}			
			if boss:isRebel() then
				spawnList = {
					"fbase_rebel_army_captain",
					"fbase_rebel_army_captain_hard"
				}
			elseif boss:isImperial() then
				spawnList = {
					"fbase_scout_trooper",
					"fbase_stormtrooper_captain"
				}
			else
				spawnList = {
					"cavern_spider",
					"gaping_spider_hunter"
				}
			end
		--lspawnMobile=function(zoneName, spawnList, respawnTimer, x, z, y, heading, parentID, spawnRange, spawnCount)
		listID = lspawnMobile("yavin4", spawnList, -1, xBoss, 0, yBoss, math.random(1,360), 0, 4, math.random(1,5))
		for k,v in pairs(listID) do
			CreatureObject(v):engageCombat(pPlayer)
		end
		dropObserver(DAMAGERECEIVED,pBoss)
		end
	end
	return 0
end





--Process Selection and Spawn Logic:
function glowieTrialExpansion:control(...)
	local finalFaction = glowieTrialExpansion.chooseFaction()--get faction.
	local finalMobile = glowieTrialExpansion.chooseMobile(_,finalFaction)--get mobile.
	local finalLocation = glowieTrialExpansion.chooseLocation(_,finalFaction)--get location.
	local x,z,y = finalLocation[1],finalLocation[2],finalLocation[3]--set variables for location.
	local pBoss = rspawnMobile("yavin4", finalMobile, 0, x, z, y, math.random(1,360), 0, 6)--spawn.
	createObserver(OBJECTDESTRUCTION, "glowieTrialExpansion", "timerSet", pBoss)--set observer for death.
	createObserver(DAMAGERECEIVED, "glowieTrialExpansion", "spawnAdds",pBoss)--setup adds
	return pBoss
end

--randomize respawn.
function glowieTrialExpansion:timerSet(pBoss,pPlayer)--set min to 1 and max to 2 for instaspawn.
	createObserver(LOOTCREATURE , "glowieTrialExpansion", "looted", pBoss)
	dropObserver(OBJECTDESTRUCTION,pBoss)
	local min = (5*60)--set minimum spawn time here (in seconds). Warfront standard is 10-20mins
	local max = (20*60)--set maximum spawn time here (in seconds).
	local timer = math.random(min*10,max*10)
	--glowieTrialExpansion:control()
	createEvent(timer,"glowieTrialExpansion","control",timer,"")
	return 0
end

function glowieTrialExpansion:looted(pBoss,pPlayer)
			dropObserver(LOOTCREATURE, pBoss )
-- Get some information about the player and npc quest giver.
			local creature = LuaCreatureObject(pPlayer)
			local npcCreature = LuaCreatureObject(pBoss)
			local isNpcImperial = npcCreature:isImperial()
 			local isImperial = creature:isImperial()
			local isNpcRebel = npcCreature:isRebel()
 			local isRebel = creature:isRebel()
			local Boss = LuaSceneObject(pBoss)
	local bossName = Boss:getDisplayedName()
	if creature:hasScreenPlayState( 64 , "glowie_expansion_quest") then
		--if npc is not neutral
		if (npcCreature:isNeutral() == false) then
		--Player is imp and Npc is not
			if isImperial and (isImperial ~= isNpcImperial) then
				--set the kill stat for npc if there is a match.
				if (bossName ==  "Master Zhi") then -- and creature:hasScreenPlayState( 4 , "glowie_expansion_quest_kills") then --reb c
					bf_tools:rewardGroupAll( pPlayer, "screenplay", 8, "glowie_expansion_quest_kills", 4, "imperial" )
				elseif (bossName ==  "Triv Eno") then --and creature:hasScreenPlayState( 2 , "glowie_expansion_quest_kills") then --reb b
					bf_tools:rewardGroupAll( pPlayer, "screenplay", 4, "glowie_expansion_quest_kills", 2 , "imperial")
				elseif ( bossName == "Sal Boca") then --reb a
					bf_tools:rewardGroupAll( pPlayer, "screenplay", 2, "glowie_expansion_quest_kills", {64,"glowie_expansion_quest"}, "imperial" )
				end

		--Player is reb and Npc is not
			elseif isRebel and (isRebel ~= isNpcRebel) then
				--set the kill stat for npc if there is a match.
				if (bossName ==  "Inquisitor Sihv") then --and creature:hasScreenPlayState( 32 , "glowie_expansion_quest_kills") then --imp c
					bf_tools:rewardGroupAll( pPlayer, "screenplay", 64, "glowie_expansion_quest_kills", 32, "rebel" )
				elseif (bossName ==  "Agent Kayn") then --and creature:hasScreenPlayState( 16 , "glowie_expansion_quest_kills") then --imp b
					bf_tools:rewardGroupAll( pPlayer, "screenplay", 32, "glowie_expansion_quest_kills", 16 , "rebel")
				elseif ( bossName == "Commander Larn" ) then --imp a
					bf_tools:rewardGroupAll( pPlayer, "screenplay", 16, "glowie_expansion_quest_kills", {64,"glowie_expansion_quest"}, "rebel" )
				end
			end
		else
			--NPC is Neutral code
				--goes here	
		end
	end
	return 0
end

--set number of spawns.
function glowieTrialExpansion:repeater()
	local setSpawns = 4 --set number of simultaneous spawn cycles here.
	local p = 0
	repeat
		glowieTrialExpansion:control()
		p = p + 1
	until p == setSpawns
end
