--PROTOTYPE PVP EVENT By: Mindsoft

eisley_pvp = ScreenPlay:new{
}
registerScreenPlay("eisley_pvp", false)

function eisley_pvp:start()
	print("eisley pvp event has been started")
	createEvent(100, "eisley_pvp", "broadcast", "", "A Rebel force is building outside of Mos Eisley on Tatooine") --Initial broadcast of event @ start
	createEvent(4 * 1000, "eisley_pvp", "broadcast", "", "Calling all available troops: Support Needed!") --broadcast call to arms 4s from start
	createEvent(10 * 1000, "eisley_pvp", "spawnInitalTroops", "", "") --first wave of troops 10sec from start
	createEvent(120 * 1000, "eisley_pvp", "spawnInitalTroops", "", "") --second wave of troops 2min from start
	createEvent(60 * 1000, "eisley_pvp", "callShuttles", "", "") --first wave of shuttles 1min from start
	createEvent(300 * 1000, "eisley_pvp", "callShuttles", "", "") --second wave of shuttles 5min from start
	createEvent(323 * 1000, "eisley_pvp", "callBosses", "", "") --spawn bosses 20seconds after second shuttle wave , 5m 20s from start
	createEvent(326 * 1000, "eisley_pvp", "broadcast", "", "Field Commanders have now landed at the Mos Eisley Battle") --broadcast bosses 3seconds after boss spawn
	createEvent(329 * 1000, "eisley_pvp", "broadcast", "", "Calling all available troops: Protect your commanders!") --broadcast call to arms 6seconds after boss spawn
end

function eisley_pvp:spawnInitalTroops()
	print("spawning initial units")
	local impList = {"endor_stormtrooper","endor_stormtrooper","endor_stormtrooper",} --add new list items here for imperial field waves
	local rebList = {"endor_rebtrooper","endor_rebtrooper","endor_rebtrooper",} --add new list items here for rebel field waves

	local x = 0
	local y = 0
	local z = 0
	local template = ""

	local i = 1
	repeat -- SPAWN IMPERIAL UNITS
		x = WFnav:rndRng(3610, 30)
		y = WFnav:rndRng(-4629, 30)
		z = WFnav:getZ("tatooine",x,y)
		template = impList[math.random(#impList)]
		--spawn imp mobile
		local pMob = spawnMobile("tatooine", template, 0, x, z, y, math.random(360), 0)
		AiAgent(pMob):setAITemplate("") --set to wander
		i = i + 1
	until i > 20

	i  = 1
	repeat -- SPAWN REBEL UNITS
		x = WFnav:rndRng(3699, 30)
		y = WFnav:rndRng(-4656, 30)
		z = WFnav:getZ("tatooine",x,y)
		template = rebList[math.random(#rebList)]
		--spawn reb mobile
		local pMob = spawnMobile("tatooine", template, 0, x, z, y, math.random(360), 0)
		AiAgent(pMob):setAITemplate("") --set to wander
		i = i + 1
	until i > 20
end


function eisley_pvp:broadcast(empty, msg)
	broadcastGalaxy(msg)
end

function eisley_pvp:callBosses(empty, count)
	--print("spawn luke")
	--spawnBossMobile(stringData) --TODO @Upgrade use boss tables and WFboss.lua system

	local pLuke = spawnMobile("tatooine", "gcw_luke", 0, 3694, 5, -4657, 101, 0)--TODO  Nexxus  edit npc string for luke
	writeData("eisleyPvpActiveRebelBoss",SceneObject(pLuke):getObjectID())
	CreatureObject(pLuke):setPvpStatusBitmask(0) --set to non-attackable
	createEvent(10000, "Ihelp", "chatEventMood", pLuke, "You Will not stop our advance Father!/168/80/beckon")
	createEvent(17000, "eisley_pvp", "setCreatureAttackable", pLuke, "")
	AiAgent(pLuke):setAITemplate("")
	createObserver(OBJECTDESTRUCTION, "eisley_pvp", "bossDeadRebel",pLuke)

	--print("spawn vader")
	--spawnBossMobile(stringData) --TODO @Upgrade use boss tables and WFboss.lua system

	local pVader = spawnMobile("tatooine", "gcw_vader", 0, 3608, 5, -4606, 101, 0)--TODO  Nexxus  edit npc string for vader
	writeData("eisleyPvpActiveImperialBoss",SceneObject(pVader):getObjectID())
	CreatureObject(pVader):setPvpStatusBitmask(0) --set to non-attackable
	createEvent(12000, "Ihelp", "chatEventMood", pVader, "Your precious Rebellion will fall before the might of the Empire./168/80/beckon")
	createEvent(17000, "eisley_pvp", "setCreatureAttackable", pVader, "")
	AiAgent(pVader):setAITemplate("")
	createObserver(OBJECTDESTRUCTION, "eisley_pvp", "bossDeadImperial",pVader)
end

function eisley_pvp:setCreatureAttackable(pCreo)
	if (SceneObject(pCreo):getZoneName() == "") then return 0 end
	CreatureObject(pCreo):setPvpStatusBitmask(ATTACKABLE+AGGRESSIVE)
end

function eisley_pvp:bossDeadRebel(pLuke)
	print("rebel boss dead")
	spatialChat(pVader, "Even if I fall the Rebellion never will!")	
	if (SceneObject(pLuke):getZoneName() == "") then return 0 end
	local pVader = getSceneObject(readData("eisleyPvpActiveImperialBoss"))
	if ((pVader == nil)) then
		print("Error:eisley_pvp:bossDeadImperial(pCreo), pVader is nil")
		return 0
	end
	forcePeace(pVader)
	CreatureObject(pVader):setPvpStatusBitmask(0)
	forcePeace(pVader)
	spatialChat(pVader, "The Emperor will be quite pleased with this outcome.")	
	eisley_pvp:inRangeRewardXP("tatooine", 3639, -4636, CreatureObject(pVader):getFaction() )
	createEvent(30000, "Ihelp", "destroy", pVader, "")
	createEvent(30000, "Ihelp", "destroy", pLuke, "")
	return 0
end

function eisley_pvp:bossDeadImperial(pVader)
	print("imperial boss dead")
	spatialChat(pVader, "My Master will not be pleased!")	
	if (SceneObject(pVader):getZoneName() == "") then return 0 end
	local pLuke = getSceneObject(readData("eisleyPvpActiveRebelBoss"))
	if ((pLuke == nil)) then
		print("Error:eisley_pvp:bossDeadImperial(pCreo), pLuke is nil")
		return 0
	end
	forcePeace(pLuke)
	CreatureObject(pLuke):setPvpStatusBitmask(0)
	forcePeace(pLuke)
	spatialChat(pLuke, "That's a WIN for the Rebellion!")	
	eisley_pvp:inRangeRewardXP("tatooine", 3639, -4636, CreatureObject(pLuke):getFaction() )
	createEvent(30000, "Ihelp", "destroy", pVader, "")
	createEvent(30000, "Ihelp", "destroy", pLuke, "")
	return 0
end

function eisley_pvp:inRangeRewardXP(planet, posX, posY, winningFaction )
	print("issuing pvp rewards",planet, posX, posY, winningFaction )
	local posZ = WFnav:getZ(planet, posX, posY)
	local pController = spawnSceneObject(planet, "object/tangible/furniture/all/outbreak_deathtrooper_pile.iff", posX, posZ, posY, 0, 0) --"object/tangible/theme_park/invisible_object.iff", posX, posZ, posY, 0, 0)
	if (pController == nil) then
		print("ERROR: eisley_pvp:inRangeRewardXP(planet,posX,posY,winningFaction), Rewards were unable to process due to nil pController.")
		return 0
	end
	createEvent(2 * 1000, "ShuttleDropoff", "destroyController", pController, "")

	local playerTable = SceneObject(pController):getPlayersInRange(110)
	--print("player table size",#playerTable)
	for i = 1, #playerTable, 1 do
		--print("testing player #",i,playerTable[i])
		local tPlayer = playerTable[i]
		if (tPlayer ~= nil and (SceneObject(tPlayer):getParentID() == 0)) then
			local creo = LuaCreatureObject(tPlayer)
			--print("player in range", creo, tPlayer)
			--test if valid player
			if (creo:isOvert() and ( creo:isRebel() or  creo:isImperial() )) then
				if (creo:getFaction() == winningFaction) then
					--print("player is winner")
					if (creo:hasSkill("force_title_jedi_rank_03")) then
						creo:awardExperience("force_rank_xp", 5000, true)
					else
						creo:awardExperience("gcw_skill_xp", 5000, true)
					end
				else
					--print("player is loser")
					if (creo:hasSkill("force_title_jedi_rank_03")) then
						creo:awardExperience("force_rank_xp", 2000, true)
					else
						creo:awardExperience("gcw_skill_xp", 2000, true)
					end
				end
			end
		end
	end
end

function eisley_pvp:callShuttles()
	print("calling pvp event shuttles")
	ShuttleDropoff:triggerFlyby("tatooine", 1, 3591, -4626, 130, 10, "endor_stormtrooper", 200) --imp 1
	ShuttleDropoff:triggerFlyby("tatooine", 1, 3623, -4576, 130, 10, "endor_stormtrooper", 200) --imp 2
	ShuttleDropoff:triggerFlyby("tatooine", 1, 3580, -4586, 130, 10, "endor_stormtrooper", 200) --imp 3

	ShuttleDropoff:triggerFlyby("tatooine", 3, 3729, -4630, 90, 10, "endor_rebtrooper", 200) --reb 1
	ShuttleDropoff:triggerFlyby("tatooine", 3, 3724, -4689, 90, 10, "endor_rebtrooper", 200) --reb 2
	ShuttleDropoff:triggerFlyby("tatooine", 3, 3694, -4657, 90, 10, "endor_rebtrooper", 200) --reb 3
end
