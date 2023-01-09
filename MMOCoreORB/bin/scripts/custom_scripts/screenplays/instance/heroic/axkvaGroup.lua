axkvaGroup = ScreenPlay:new {
	suinAdds = {
		"nightsister_ekomal",
		"nightsister_oxvul",
		"nightsister_doum",
		"nightsister_hurdem",
	}
}
registerScreenPlay("axkvaGroup", false)

--------------------------------------
--   Initialize screenplay           -
--------------------------------------
function axkvaGroup:start(pBuilding)
	--print("axkva started")
        createObserver(OBJECTREMOVEDFROMZONE, "axkvaGroup", "instanceRemoved", pBuilding)
	axkvaGroup:spawnMobiles(pBuilding)
	axkvaGroup:spawnSceneObjects(pBuilding)		
end

function axkvaGroup:spawnMobiles(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local pNandina = spawnMobile(zone, "nightsister_nandina", 0, -67.5, 14.3, 13.8, 101, bID+2)
	local pGorvo = spawnMobile("dathomir", "nightsister_gorvo_rancor", 3600, -67.5, 14.3, 26.4, 114, bID+2)
	CreatureObject(pGorvo):setMoodString("worried")

	--save boss data
	writeData(bID.."activeBoss",SceneObject(pNandina):getObjectID())
	writeData(bID.."gorvo",SceneObject(pGorvo):getObjectID())

	--create boss observers
	createEvent(30000, "Ihelp", "chatEventMood", pNandina, "You will not stop the ritual, My master will be freed!/18/67/point_accusingly")
        createObserver(OBJECTDESTRUCTION, "axkvaGroup", "notifyNandinaDead", pNandina)
        createObserver(OBJECTDESTRUCTION, "axkvaGroup", "notifyGorvoDead", pGorvo)
        createObserver(DEFENDERADDED, "axkvaGroup", "nandinaEngaged", pNandina)
        createObserver(DEFENDERADDED, "axkvaGroup", "nandinaEngaged", pGorvo)
	return 0
end

function axkvaGroup:spawnSceneObjects(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	spawnSceneObject("tatooine", "object/building/heroic/axkva_hall_fire.iff", 10, .2, 0.33, bID+1, 0)
	local door = spawnSceneObject(zone, "object/tangible/door/heroic_axkva_min_door_exit.iff", 34.35, 0, 0.35, bID+1, -1.571)
	SceneObject(door):setObjectMenuComponent("WFporter")
	writeStringData(SceneObject(door):getObjectID().."InstanceType","axkvaGroup")


	local crystal1 = spawnSceneObject("tatooine", "object/building/heroic/axkva_lelli_hi_crystal.iff", -83.7, 17.8, 17.2, bID+2, 0)
	local crystal4 = spawnSceneObject("tatooine", "object/building/heroic/axkva_min_crystal.iff",-83,17.8,19.7,bID+2, math.rad(90))
	local crystal3 = spawnSceneObject("tatooine", "object/building/heroic/axkva_suin_chalo_crystal.iff",-80.4, 17.8, 29.3, bID+2,0)
	local crystal2 = spawnSceneObject("tatooine", "object/building/heroic/axkva_kimaru_crystal.iff", -80, 17.8, 31.7,bID+2, 0)

	writeData(bID.."crystal1",SceneObject(crystal1):getObjectID())
	writeData(bID.."crystal2",SceneObject(crystal2):getObjectID())
	writeData(bID.."crystal3",SceneObject(crystal3):getObjectID())
	writeData(bID.."crystal4",SceneObject(crystal4):getObjectID())
end

--set observer to fire next storm
function axkvaGroup:scheduleStormObserver(pBoss)
	if (SceneObject(pBoss):getZoneName() == "") then
		return 0
	end
        createObserver(DAMAGERECEIVED, "axkvaGroup", "spawnStorm", pBoss)
end

function axkvaGroup:spawnStorm(pBoss)
	if ((SceneObject(pBoss):getZoneName() == "") or (CreatureObject(pBoss):isDead())) then
		return 0
	end
        dropObserver(DAMAGERECEIVED, "axkvaGroup", "spawnStorm", pBoss)
	if not(CreatureObject(pBoss):isInCombat()) then
        	createObserver(DAMAGERECEIVED, "axkvaGroup", "spawnStorm", pBoss)
		return 0
	end
	local zone = SceneObject(pBoss):getZoneName()
	local parentCell = SceneObject(pBoss):getParent()
	local parentID = SceneObject(parentCell):getObjectID()
	local threats = CreatureObject(pBoss):getActiveThreatList()
	local tPlayer = nil
	if (#threats > 0) then
		tPlayer = threats[math.random(#threats)]
	else
		tPlayer = AiAgent(pBoss):getTargetFromDefenders()
	end
	local x = SceneObject(tPlayer):getPositionX()
	local y = SceneObject(tPlayer):getPositionY()
	local z
	local i = 0
	local range = 5

	while ((z==nil) and (i < 10)) do
		i = i + 1
		local tries = 0
		while ((z ==nil) and (tries < 10)) do
			tries = tries + 1
			x = WFnav:rndRng(x, range)
			y = WFnav:rndRng(y, range)
			z = SceneObject(pBoss):getCellFloorCollision(x,y)
		end
		range = range + 2
	end

	if (z == nil) then
		createEvent(1000, "axkvaGroup", "spawnStorm", pBoss, "")
		return 0
	end
	local storm = spawnSceneObject(zone, "object/static/particle/pt_kimaru_force_storm.iff", x, z, y, parentID,0)
	createEvent((9+math.random(31)*1000), "Ihelp", "destroy", storm, "")
	createEvent(200, "axkvaGroup", "prtFollow", storm, SceneObject(tPlayer):getObjectID())
	createEvent((10+math.random(28)*1000), "axkvaGroup", "scheduleStormObserver", pBoss,"")
	return 0
end

function axkvaGroup:prtFollow(pPart,playerID)
	--validate
	if (SceneObject(pPart):getZoneName() == "") then
		return 0
	end
	local pPlayer = getSceneObject(playerID)
	if (CreatureObject(pPlayer):isDead()) then
		createEvent(2000, "Ihelp", "destroy", pPart, "")
		return 0
	end
	
	local pBuilding = Ihelp:getBuilding(pPart)
	local zone = SceneObject(pBuilding):getZoneName()
	local bID = SceneObject(pBuilding):getObjectID()
	local bossID = readData(bID.."activeBoss")
	local pBoss = getSceneObject(bossID)
	local playerTable = LuaCreatureObject(pBoss):getActiveThreatList() --damage threat map
	for i = 1, #playerTable, 1 do
		local tPlayer = playerTable[i]
		if (tPlayer ~= nil) then
			if (SceneObject(pPart):isInRangeWithObject3d(tPlayer,2)) then
				local dType = ((math.random(3)-1)*3)
				CreatureObject(tPlayer):inflictDamage(pBoss, dType, 50 + math.random(150), true);
				CreatureObject(tPlayer):playEffect("clienteffect/trap_electric_01.cef", "")
			end
		end
	end

	--get new x
	local x = SceneObject(pPart):getPositionX()
	if (x < SceneObject(pPlayer):getPositionX()) then
		x = x + .8
	else
		x = x - .8
	end

	--get new y
	local y = SceneObject(pPart):getPositionY()
	if (y < SceneObject(pPlayer):getPositionY()) then
		y = y + .8
	else
		y = y - .8
	end

	--get location info
	local z = SceneObject(pPart):getCellFloorCollision(x,y) or SceneObject(pPart):getPositionZ()
	local parentCell = SceneObject(pPlayer):getParent()
	if (parentCell == nil) then return 0 end
	local parentID = SceneObject(parentCell):getObjectID()

	--spawn animation particles
	SceneObject(pPart):teleport(x, z, y, parentID)
	local fire = spawnSceneObject(zone, "object/static/particle/pt_kimaru_force_storm.iff", x, z, y, parentID, math.rad(math.random(360)))

	--schedule events
	createEvent(2000, "Ihelp", "destroy", fire, "")
	createEvent(400, "axkvaGroup", "prtFollow", pPart, playerID)
	return 0
end

function axkvaGroup:instanceRemoved(pBuilding)
	local bID = SceneObject(pBuilding):getObjectID()
	deleteData(bID.."warden")
	deleteData(bID.."activeBoss")
	deleteStringData(bID.."activeBossAdds")
	deleteData(bID.."gorvo")
	deleteData(bID.."crystal1")
	deleteData(bID.."crystal2")
	deleteData(bID.."crystal3")
	deleteData(bID.."crystal4")
	return 0
end

--Nandina and Gorvo
function axkvaGroup:nandinaEngaged(pBoss, pPlayer)
	if (SceneObject(pBoss):getZoneName() == "") then return 0 end
	local pBuilding = Ihelp:getBuilding(pBoss)
	local bID = SceneObject(pBuilding):getObjectID()
	local pNandina = getSceneObject(readData(bID.."activeBoss"))
	local pGorvo = getSceneObject(readData(bID.."gorvo"))

	--remove intializing observers
        dropObserver(DEFENDERADDED, "axkvaGroup", "nandinaEngaged", pNandina)
        dropObserver(DEFENDERADDED, "axkvaGroup", "nandinaEngaged", pGorvo)

	--add sustained observers
        createObserver(DEFENDERADDED, "axkvaGroup", "nandinaAttacked", pNandina)
        createObserver(DEFENDERADDED, "axkvaGroup", "gorvoAttacked", pGorvo)

	CreatureObject(pNandina):engageCombat(pPlayer)
	CreatureObject(pGorvo):engageCombat(pPlayer)
	createEvent(5000, "axkvaGroup", "healGorvo", pGorvo, bID)
	createEvent(500, "Ihelp", "chatEventMood", pNandina, "Kill Them!/168/80/angry")
	return 0
end

function axkvaGroup:healGorvo(pGorvo, bID)
	if ((SceneObject(pGorvo):getZoneName() == "") or (CreatureObject(pGorvo):isDead())) then
		return 0
	end
	local pNandina = getSceneObject(readData(bID.."activeBoss"))
	if ((SceneObject(pNandina):getZoneName() == "") or CreatureObject(pGorvo):isDead() or CreatureObject(pNandina):isDead()) then
		return 0
	end
	if (SceneObject(pGorvo):isInRangeWithObject(pNandina, 10)) then
		local dType = ((math.random(3)-1)*3)
		CreatureObject(pGorvo):healDamage(20 + (math.random(30) * 1000), dType) --heal 21- 50k on random pool
		CreatureObject(pGorvo):clearDots()
		CreatureObject(pGorvo):playEffect("clienteffect/healing_healdamage.cef", "")
	end
	createEvent(500, "axkvaGroup", "healGorvo", pGorvo, bID) --heal 2 times per/second
	return 0
end

	--share aggro with gorvo
function axkvaGroup:nandinaAttacked(pNandina, pPlayer)
	if (SceneObject(pNandina):getZoneName() == "") then return 0 end
	local pBuilding = Ihelp:getBuilding(pNandina)
	local bID = SceneObject(pBuilding):getObjectID()
	local pGorvo = getSceneObject(readData(bID.."gorvo"))
	CreatureObject(pGorvo):engageCombat(pPlayer)
	return 0
end

	--share aggro with nandina
function axkvaGroup:gorvoAttacked(pGorvo, pPlayer)
	if (SceneObject(pGorvo):getZoneName() == "") then return 0 end
	local pBuilding = Ihelp:getBuilding(pGorvo)
	local bID = SceneObject(pBuilding):getObjectID()
	local pNandina = getSceneObject(readData(bID.."activeBoss"))
	CreatureObject(pNandina):engageCombat(pPlayer)
	return 0
end

	--nandina dead -check gorvo dead & increase his damage if not
function axkvaGroup:notifyNandinaDead(pNandina, pPlayer)
	if (SceneObject(pNandina):getZoneName() == "") then return 0 end
	local pBuilding = Ihelp:getBuilding(pNandina)
	local bID = SceneObject(pBuilding):getObjectID()
	local pGorvo = getSceneObject(readData(bID.."gorvo"))
	if not((pGorvo == nil) or CreatureObject(pGorvo):isDead()) then
		local level = CreatureObject(pGorvo):getLevel() * 1.5
		if (level > 499) then level = 499 end
		AiAgent(pGorvo):setLevel(level)	
		createEvent(300, "axkvaGroup", "gorvoGrow", pGorvo, 1.1)	
	else
		createEvent(5000, "axkvaGroup", "nandinaAndGorvoDead", pBuilding,"")
	end
        dropObserver(DEFENDERADDED, "axkvaGroup", "gorvoAttacked", pGorvo)

	return 0
end

function axkvaGroup:gorvoGrow(pGorvo, counter)
	counter = tonumber(counter)
	if (counter < 2) then
		CreatureObject(pGorvo):setHeight(counter,true)
		local gorvo = SceneObject(pGorvo)
		createEvent(150, "axkvaGroup", "gorvoGrow", pGorvo, counter+.04)
	end
	return 0
end

	--gorvo dead -check nandina dead
function axkvaGroup:notifyGorvoDead(pGorvo, pPlayer)
	if (SceneObject(pGorvo):getZoneName() == "") then return 0 end
	local pBuilding = Ihelp:getBuilding(pGorvo)
	local bID = SceneObject(pBuilding):getObjectID()
	local pNandina = getSceneObject(readData(bID.."activeBoss"))
	if ((pNandina == nil) or CreatureObject(pNandina):isDead()) then
		createEvent(5000, "axkvaGroup", "nandinaAndGorvoDead", pBuilding,"")
	end

	local pNandinaInv = CreatureObject(pNandina):getSlottedObject("inventory")
	if (pNandinaInv ~= nil) then
		createLoot(pNandinaInv, "power_crystals", 500, true)
	end

	dropObserver(DEFENDERADDED, "axkvaGroup", "nandinaAttacked", pNandina)
	return 0
end

	--complete nandina phase & que warden chatter
function axkvaGroup:nandinaAndGorvoDead(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
        local pWarden = spawnMobile(zone, "warden", 0, -62.3, 13.8, 30.1, 139, bID+2)
	createEvent( 7000,"axkvaGroup", "faceDirection", pWarden, -118)
	createEvent( 5000,"Ihelp", "chatEvent", pWarden, "You are too late, Nandina has broken the seal.")
	createEvent(12000, "Ihelp", "chatEventMood", pWarden, "Axkva Mins spirit has been released!/0/0/blame")
	createEvent(24000, "Ihelp", "destroy", pWarden, "")
	createEvent(28000, "axkvaGroup", "spawnEssence", pBuilding,"")
end

function axkvaGroup:spawnEssence(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local essence = spawnMobile(zone, "essence_of_axkva_min", 0, -79.1, 17.8, 23.8, 109, bID+2)
	createEvent( 3000,"Ihelp", "chatEvent", essence, "Nandina was a foolish child but she was right in one aspect. I will not be stopped by the likes of you!")
	createEvent( 7000,"axkvaGroup", "faceDirection", essence, -144)
	createEvent( 9000,"Ihelp", "chatEventMood", essence, "Lelli Hi! Destroy these interlopers!/0/0/blame")
	createEvent(10000,"axkvaGroup", "destroyCrystal", pBuilding, "1")
	createEvent(12000, "axkvaGroup", "spawnLelli", pBuilding,"")
	createEvent(16000, "Ihelp", "destroy", essence, "")
end

function axkvaGroup:destroyCrystal(pBuilding,crystalNum)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local pCrystal = getSceneObject(readData(bID.."crystal"..crystalNum))
	if (pCrystal) then
		SceneObject(pCrystal):playEffect("clienteffect/lair_damage_heavy.cef", "")
		SceneObject(pCrystal):playEffect("clienteffect/droid_effect_electric_fog.cef", "")

		createEvent(2000, "Ihelp", "destroy", pCrystal, "")
	end
end

--Lelli Hi
function axkvaGroup:spawnLelli(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
        local pLelli = spawnMobile(zone, "nightsister_lelli_hi", 0, -84.2, 17.9, 16.8, 97, bID+2)
	SceneObject(pLelli):playEffect("clienteffect/item_bugs_moths.cef", "")
	writeData(bID.."activeBoss",SceneObject(pLelli):getObjectID())
	CreatureObject(pLelli):setPvpStatusBitmask(0)
	createEvent(5000, "Ihelp", "chatEventMood", pLelli, "Your blood will buy much favor./168/80/beckon")
	createEvent(10000, "axkvaGroup", "setCreatureAttackable", pLelli, ATTACKABLE+ENEMY+AGGRESSIVE)
	createObserver(DEFENDERADDED, "axkvaGroup", "lelliEngaged", pLelli)
	createObserver(OBJECTDESTRUCTION, "axkvaGroup", "notifyLelliDead", pLelli)
	return 0
end

function axkvaGroup:lelliEngaged(pLelli, pPlayer)
	if ((SceneObject(pLelli):getZoneName() == "")) then return 0 end
	local pBuilding = Ihelp:getBuilding(pLelli)
        dropObserver(DEFENDERADDED, "axkvaGroup", "lelliEngaged", pLelli)
	axkvaGroup:lockBattleArena(pBuilding)
	createEvent(1000, "axkvaGroup", "lelliToggle", pLelli, "")
	return 0
end

function axkvaGroup:lelliToggle(pLelli)
	if (SceneObject(pLelli):getZoneName() == "") then return 0 end

	local lelli = SceneObject(pLelli)
	local zone = lelli:getZoneName()
	local parentCell = lelli:getParent()
	local parentID = SceneObject(parentCell):getObjectID()
	local x = SceneObject(pLelli):getPositionX()
	local z = SceneObject(pLelli):getPositionZ()
	local y = SceneObject(pLelli):getPositionY()

	local parentID = SceneObject(lelli:getParent()):getObjectID()
	if not(CreatureObject(pLelli):isInCombat()) then
		createObserver(DEFENDERADDED, "axkvaGroup", "lelliEngaged", pLelli)
		local pBuilding = Ihelp:getBuilding(pLelli)
		axkvaGroup:unlockBattleArena(pBuilding)
		TangibleObject(pLelli):setInvisible(false)
	elseif ((CreatureObject(pLelli):isDead()) or TangibleObject(pLelli):isInvisible() ) then
		TangibleObject(pLelli):setInvisible(false)
		createEvent((19 + math.random(31))*1000, "axkvaGroup", "lelliToggle", pLelli, "")--turn invis in 20-50s
	else
		TangibleObject(pLelli):setInvisible(true)
		CreatureObject(pLelli):clearDots()
		createEvent(2000, "axkvaGroup", "lelliMine", pLelli, "")
		createEvent((9 + math.random(11))*1000, "axkvaGroup", "lelliToggle", pLelli, "")--turn vis in 10-20s
		local pPart = spawnSceneObject(zone, "object/static/particle/particle_mine_warning.iff", x, z, y, parentID,0)
		local pPart2 = spawnSceneObject(zone, "object/static/particle/particle_magic_sparks.iff", x, z, y, parentID,0)
		createEvent(5000, "Ihelp", "destroy", pPart, "")
		createEvent(5000, "Ihelp", "destroy", pPart2, "")
	end
	
	lelli:_setObject(pLelli)
	lelli:switchZone(zone,x,z,y,parentID)
	CreatureObject(pLelli):playEffect("clienteffect/commando_position_secured.cef", "")
	
	return 0
end

function axkvaGroup:lelliMine(pLelli)
	if ((SceneObject(pLelli):getZoneName() == "") or not(CreatureObject(pLelli):isInCombat()) or (CreatureObject(pLelli):isDead()) or not(TangibleObject(pLelli):isInvisible())) then
		return 0
	end
	local lelli = SceneObject(pLelli)
	local zone = lelli:getZoneName()
	local parentCell = lelli:getParent()
	local parentID = SceneObject(parentCell):getObjectID()
	local threats = CreatureObject(pLelli):getActiveThreatList()
	local tPlayer = nil
	if (#threats > 0) then
		tPlayer = threats[math.random(#threats)]
	else
		tPlayer = AiAgent(pLelli):getTargetFromDefenders()
	end
	local x = SceneObject(tPlayer):getPositionX()
	local y = SceneObject(tPlayer):getPositionY()
	local z
	local i = 0
	local range = 3
	while ((z==nil) and (i < 10)) do
		i = i + 1
		local tries = 0
		while ((z ==nil) and (tries < 10)) do
			tries = tries + 1
			x = WFnav:rndRng(x, range)
			y = WFnav:rndRng(y, range)
			z = lelli:getCellFloorCollision(x,y)
		end
		range = range + 2
	end

	if (z == nil) then
		createEvent(1000, "axkvaGroup", "lelliMine", pLelli, parentID)
		return 0
	end
	--axkvaGroup:crystalPlaced(tPlayer)
	local pMine = spawnSceneObject(zone, "object/weapon/mine/wp_mine_xg.iff", x, z, y, parentID,0)
	createEvent((4+(math.random(4))*1000), "axkvaGroup", "mineExplode", pMine,parentID)
	createEvent((2+(math.random(4))*1000), "axkvaGroup", "lelliMine", pLelli,"")
	return 0
end

function axkvaGroup:mineExplode(pMine, parentID)
	if (SceneObject(pMine):getZoneName() ~= "")then
		local bID = SceneObject(Ihelp:getBuilding(pMine)):getObjectID()
		local pLelli = getSceneObject(readData(bID.."activeBoss"))
		if ((pLelli ==  nil) or not(CreatureObject(pLelli):isInCombat())) then
			createEvent(100, "Ihelp", "destroy", pMine, "")
			return 0
		end
		local mine = SceneObject(pMine)
		local zone = mine:getZoneName()
		local x = mine:getPositionX()
		local z = mine:getPositionZ()
		local y = mine:getPositionY()
		local pFire = spawnSceneObject(zone, "object/static/particle/pt_sm_explosion.iff", x, z, y, parentID,0)
		local targetList = CreatureObject(pLelli):getActiveThreatList() --damage threat map
		for i = 1, #targetList, 1 do
			local distance = SceneObject(targetList[i]):getDistanceTo(pMine)
			if (distance < 9) then
				local damage = 300
				local snareDuration = 4
				local snareStrength = 75
				local pPlayer = CreatureObject(targetList[i]):_getObject()
				if (distance < 6) then
					damage = 500
					snareDuration = 8
					snareStrength = 50
					if (distance < 3) then
						CreatureObject(pPlayer):setPosture(KNOCKEDDOWN)
						damage = 700
						snareDuration = 15
						snareStrength = 25
					end
				end
				applyCommandEffect(pPlayer, 5, snareDuration, snareStrength) --snare target
				local dType = ((math.random(3)-1)*3)
				CreatureObject(targetList[i]):inflictDamage(pLelli, dType, damage + math.random(199), true);
				SceneObject(pMine):playEffect("clienteffect/combat_grenade_proton.cef", "")
			end
		end
		createEvent(1000, "Ihelp", "destroy", pMine, "")
		createEvent(3000, "Ihelp", "destroy", pFire, "")
	end
	return 0
end

function axkvaGroup:notifyLelliDead(pBoss, pPlayer)
	if (SceneObject(pBoss):getZoneName() ~= "")then
		local pBuilding = Ihelp:getBuilding(pBoss)
		local bID = SceneObject(pBuilding):getObjectID()
		local zone = SceneObject(pBuilding):getZoneName()
		createEvent(15000,"axkvaGroup", "destroyCrystal", pBuilding, "2")
		createEvent(17000, "axkvaGroup", "spawnKimaru", pBuilding,"")
		local essence = spawnMobile(zone, "essence_of_axkva_min", 0, -79.1, 17.8, 23.8, 109, bID+2)
		createEvent( 5000,"Ihelp", "chatEvent", essence, "Well it appears Gethzerion has sent her best to stop me.")
		createEvent( 13000,"Ihelp", "chatEvent", essence, "Let us see how you fare against the greatest of the Nightsister Spellweavers. Your imprisonment ends now Kimaru!")
		createEvent(15000,"axkvaGroup", "faceDirection", essence, -8)
		createEvent(18000, "Ihelp", "destroy", essence, "")
		axkvaGroup:unlockBattleArena(pBuilding)
	end
	return 0
end

--Kimaru
function axkvaGroup:spawnKimaru(pBuilding)
	if (SceneObject(pBuilding):getZoneName() ~= "")then
		local bID = SceneObject(pBuilding):getObjectID()
		local zone = SceneObject(pBuilding):getZoneName()

		local pKimaru = spawnMobile(zone, "nightsister_kimaru", 0, -80.0, 17.8, 31.4, 101, bID+2)
		writeData(bID.."activeBoss",SceneObject(pKimaru):getObjectID())
		CreatureObject(pKimaru):setPvpStatusBitmask(0)
		SceneObject(pKimaru):playEffect("clienteffect/item_bugs_moths.cef", "")
		createEvent(1000, "Ihelp", "chatEventMood", pKimaru, "Such strange dreams I've had. Let me show you them../0/0/bob")
		createEvent(10000, "Ihelp", "chatEventMood", pKimaru, "Now it is you shall dream./168/80/tickle")
		createEvent(13000, "axkvaGroup", "setCreatureAttackable", pKimaru, ATTACKABLE+ENEMY+AGGRESSIVE)

        	createObserver(DEFENDERADDED, "axkvaGroup", "kimaruEngaged", pKimaru)
		createObserver(OBJECTDESTRUCTION, "axkvaGroup", "notifyKimaruDead", pKimaru)
	end
	return 0
end
		
function axkvaGroup:notifyKimaruDead(pBoss, pPlayer)
	if (SceneObject(pBoss):getZoneName() ~= "")then
		local pBuilding = Ihelp:getBuilding(pBoss)
		local bID = SceneObject(pBuilding):getObjectID()
		local zone = SceneObject(pBuilding):getZoneName()
		local essence = spawnMobile(zone, "essence_of_axkva_min", 0, -79.1, 17.8, 23.8, 109, bID+2)
		createEvent(9000,"Ihelp", "chatEvent", essence, "Perhaps she was not the greatest after all.")
		createEvent(16000,"axkvaGroup", "faceDirection", essence, -15)
		createEvent(18000,"Ihelp", "chatEvent", essence, "Suin Chalo, my general! Your queen needs you!")
		createEvent(21000,"axkvaGroup", "destroyCrystal", pBuilding, "3")
		createEvent(23000, "axkvaGroup", "spawnSuin", pBuilding,"")
		createEvent(25000, "Ihelp", "destroy", essence, "")
		axkvaGroup:unlockBattleArena(pBuilding)
	end
	return 0

end

function axkvaGroup:faceDirection(pSob, direction)
	if (SceneObject(pSob):getZoneName() == "") then return 0 end
	SceneObject(pSob):updateDirection(math.rad(direction))
	return 0
end

function axkvaGroup:kimaruEngaged(pKimaru, pPlayer)
	if ((SceneObject(pKimaru):getZoneName() == "")) then return 0 end
        dropObserver(DEFENDERADDED, "axkvaGroup", "kimaruEngaged", pKimaru)
	local pBuilding = Ihelp:getBuilding(pKimaru)
	axkvaGroup:lockBattleArena(pBuilding)
	createEvent(500, "Ihelp", "chatEventMood", pKimaru, "I will burn you!/168/80/angry")
	createEvent(2000, "axkvaGroup", "kimaruFire", pKimaru, "")
        createObserver(DAMAGERECEIVED, "axkvaGroup", "spawnStorm", pKimaru)
	return 0
end

function axkvaGroup:lockBattleArena(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "")then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local pWarden = spawnSceneObject(SceneObject(pBuilding):getZoneName(), "object/building/mustafar/structures/must_bandit_fence_8m.iff", -8.9, 1, 0.2, bID+1,math.rad(90))
	writeData(bID.."warden",SceneObject(pWarden):getObjectID())
	return 0
end

function axkvaGroup:unlockBattleArena(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "")then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local pWarden = getSceneObject(readData(bID.."warden"))
	deleteData(bID.."warden")

	if (pWarden) then
		createEvent(1000, "Ihelp", "destroy", pWarden, "")
	end
	return 0
end

function axkvaGroup:kimaruFire(pKimaru)
	if ((SceneObject(pKimaru):getZoneName() == "") or (CreatureObject(pKimaru):isDead())) then
		return 0
	elseif not(CreatureObject(pKimaru):isInCombat()) then
		local pBuilding = Ihelp:getBuilding(pKimaru)
		axkvaGroup:unlockBattleArena(pBuilding)
        	dropObserver(DAMAGERECEIVED, "axkvaGroup", "spawnStorm", pKimaru)
		createObserver(DEFENDERADDED, "axkvaGroup", "kimaruEngaged", pKimaru)
		return 0
	end
	local kimaru = SceneObject(pKimaru)
	local zone = kimaru:getZoneName()
	local parentCell = kimaru:getParent()
	local parentID = SceneObject(parentCell):getObjectID()
	local threats = CreatureObject(pKimaru):getActiveThreatList()
	local tPlayer = nil
	if (#threats > 0) then
		tPlayer = threats[math.random(#threats)]
	else
		tPlayer = AiAgent(pKimaru):getTargetFromDefenders()
	end
	local x = SceneObject(tPlayer):getPositionX()
	local y = SceneObject(tPlayer):getPositionY()
	local z
	local i = 0
	local range = 3
	while ((z==nil) and (i < 10)) do
		i = i + 1
		local tries = 0
		while ((z ==nil) and (tries < 10)) do
			tries = tries + 1
			x = WFnav:rndRng(x, range)
			y = WFnav:rndRng(y, range)
			z = kimaru:getCellFloorCollision(x,y)
		end
		range = range + 2
	end

	if (z == nil) then
		createEvent(1000, "axkvaGroup", "kimaruFire", pKimaru, parentID)
		return 0
	end

	local pMine = spawnSceneObject(zone, "object/static/particle/pt_kimaru_burn_patch_base.iff", x, z, y, parentID,0)
	local pFire = spawnSceneObject(zone, "object/static/particle/pt_kimaru_burn_patch.iff", x, z, y, parentID,0)
	createEvent(1500, "axkvaGroup", "kimaruFirePulse", pMine,parentID)
	createEvent((4+(math.random(9))*1000), "axkvaGroup", "kimaruFire", pKimaru,"")
	local life = (24+(math.random(36))*1000)
	createEvent(life, "Ihelp", "destroy", pMine, "")
	createEvent(life, "Ihelp", "destroy", pFire, "")
	return 0
end

function axkvaGroup:kimaruFirePulse(pMine)
	if (SceneObject(pMine):getZoneName() ~= "")then
		local bID = SceneObject(Ihelp:getBuilding(pMine)):getObjectID()
		local pBoss = getSceneObject(readData(bID.."activeBoss"))
		if ((pBoss ==  nil) or not(CreatureObject(pBoss):isInCombat())) then
			createEvent(100, "Ihelp", "destroy", pMine, "")
			return 0
		end
		local targetList = CreatureObject(pBoss):getActiveThreatList() --damage threat map
		for i = 1, #targetList, 1 do
			local distance = SceneObject(targetList[i]):getDistanceTo(pMine)
			if (distance < 3) then --target is less than 4m away
				local dType = ((math.random(3)-1)*3)
				CreatureObject(targetList[i]):inflictDamage(pBoss, dType, 200 + math.random(150), true);
				CreatureObject(targetList[i]):playEffect("clienteffect/dot_fire.cef", "")
			end
		end
		createEvent((5+math.random(5))*100, "axkvaGroup", "kimaruFirePulse", pMine, "")
	end
	return 0
end

--Suin Chalo
function axkvaGroup:spawnSuin(pBuilding)
	if (SceneObject(pBuilding):getZoneName() ~= "")then
		local bID = SceneObject(pBuilding):getObjectID()
		local zone = SceneObject(pBuilding):getZoneName()
		local pSuin = spawnMobile(zone, "nightsister_suin_chalo", 0, -80.6, 17.8, 29.0, 100, bID+2)
		writeData(bID.."activeBoss",SceneObject(pSuin):getObjectID())
		SceneObject(pSuin):playEffect("clienteffect/item_bugs_moths.cef", "")
		createEvent( 2000,"Ihelp", "chatEventMood", pSuin, "I have been too long without battle. Honor me warriors!/0/0/nod")
		createEvent( 8000, "axkvaGroup", "setCreatureAttackable", pSuin, ATTACKABLE+ENEMY+AGGRESSIVE)
		CreatureObject(pSuin):setPvpStatusBitmask(0)

		createObserver(DEFENDERADDED,"axkvaGroup","suinEngaged", pSuin)
		createObserver(OBJECTDESTRUCTION, "axkvaGroup", "notifySuinDead", pSuin)
	end
	return 0
end


function axkvaGroup:suinEngaged(pSuin, pPlayer)
	if ((SceneObject(pSuin):getZoneName() == "")) then return 0 end
        dropObserver(DEFENDERADDED, "axkvaGroup", "suinEngaged", pSuin)
        
	local pBuilding = Ihelp:getBuilding(pSuin)
	axkvaGroup:lockBattleArena(pBuilding)
	
	spatialChat(pSuin, "You will fall to my legion!")	
	createEvent((5+math.random(5))*1000, "axkvaGroup", "spawnSuinAdd", pSuin, "")
	return 0
end

function axkvaGroup:spawnSuinAdd(pSuin, pPlayer)
	local zone = SceneObject(pSuin):getZoneName()
	if ((zone == "") or (CreatureObject(pSuin):isDead()))then
		return 0
	end
	local suin = CreatureObject(pSuin)
	local pBuilding = Ihelp:getBuilding(pSuin)
	local bID = SceneObject(pBuilding):getObjectID()

	if not(suin:isInCombat()) then
		axkvaGroup:unlockBattleArena(pBuilding)
		createObserver(DEFENDERADDED,"axkvaGroup","suinEngaged", pSuin)
		axkvaGroup:despawnAddList(pBuilding)
		return 0
	end

	local addString = readStringData(bID.."activeBossAdds")
	local addList =  HelperFuncs:splitString(addString, "/")
	local addCount = 0
	addString = ""
	for i = 1, #addList,1 do
		local pAdd = getSceneObject(addList[i])
		if (pAdd) then
			if (CreatureObject(pAdd):isInCombat()) then
				addCount = addCount + 1
				addString = addString .."/"..addList[i]
			elseif not(CreatureObject(pAdd):isDead()) then
				createEvent(3000, "Ihelp", "destroy", pAdd, "")
			end
		end
	end
	if (addCount < 4) then
		local add = self.suinAdds[math.random(#self.suinAdds)]
        	local pSuinAdd = spawnMobile(zone, add, 0, suin:getPositionX(),suin:getPositionZ(),suin:getPositionY(), math.random(360), bID+2)
		addString = addString.."/"..tostring(SceneObject(pSuinAdd):getObjectID())
		writeStringData(bID.."activeBossAdds",addString)
		local threats = CreatureObject(pSuin):getActiveThreatList()
		local tPlayer = nil
		if (#threats > 0) then
			tPlayer = threats[math.random(#threats)]
		else
			tPlayer = AiAgent(pSuin):getTargetFromDefenders()
		end
		CreatureObject(pSuinAdd):engageCombat(tPlayer)
	end
	createEvent((25+math.random(35))*1000, "axkvaGroup", "spawnSuinAdd", pSuin,"")--every 16-40sec
	return 0
end

function axkvaGroup:notifySuinDead(pBoss, pPlayer)
	if (SceneObject(pBoss):getZoneName() == "") then return 0 end

	local pVictimInv = CreatureObject(pBoss):getSlottedObject("inventory")
	if (pVictimInv ~= nil) then
		createLoot(pVictimInv, "power_crystals", 400, true)
	end

	local pBuilding = Ihelp:getBuilding(pBoss)
	createEvent(12000, "axkvaGroup", "despawnAddList", pBuilding,"")
	createEvent(15000, "axkvaGroup", "preSpawnAxkva", pBuilding,"")
	axkvaGroup:unlockBattleArena(pBuilding)
	return 0
end

function axkvaGroup:preSpawnAxkva(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local essence = spawnMobile(zone, "essence_of_axkva_min", 0, -79.1, 17.8, 23.8, 109, bID+2)
	createEvent( 3000,"Ihelp", "chatEvent", essence, "I should have left you in your prison Suin, your failure is a blight on me.")
	createEvent( 8000,"Ihelp", "chatEvent", essence, "Good for you outsiders. This place has made them weak, I would have needed to find new commanders anyway.")
	createEvent(13000,"Ihelp", "chatEvent", essence, "Only one crystal left to shatter.")
	createEvent(14000,"axkvaGroup", "faceDirection", essence, -131)
	createEvent(23000,"Ihelp", "chatEvent", essence, "I throw off your chains Gethzerion!")
	createEvent(24000,"axkvaGroup", "destroyCrystal", pBuilding, "4")
	createEvent(25000, "Ihelp", "destroy", essence, "")
	createEvent(26000, "axkvaGroup", "spawnAxkva", pBuilding,"")
end

--Axkva Min
function axkvaGroup:spawnAxkva(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()

        local pAxkva = spawnMobile(zone, "axkva_min_heroic", 0, -82.9, 17.8, 19.1, 101, bID+2)
	writeData(bID.."activeBoss",SceneObject(pAxkva):getObjectID())
	SceneObject(pAxkva):playEffect("clienteffect/item_bugs_moths.cef", "")
	createObserver(OBJECTDESTRUCTION, "axkvaGroup", "notifyAxkvaDead", pAxkva)
	CreatureObject(pAxkva):setPvpStatusBitmask(0)

	local pWarden = spawnMobile(zone, "warden", 0, -62.3, 13.8, 30.1, 139, bID+2)
	createObserver(OBJECTDESTRUCTION, "axkvaGroup", "wardenDead", pWarden)
	SceneObject(pWarden):faceObject(pAxkva, true)

	createEvent( 1000, "Ihelp", "chatEventMood", pAxkva, "Freedom!/0/0/stretch")
	createEvent( 5000,"Ihelp","chatEventMood", pWarden, "You are not free yet, Gethzerion's power dominates this place./0/0/blame")
	createEvent(16000,"Ihelp", "chatEvent", pAxkva, "That crone does not know the true meaning of power!")
	createEvent(22000,"Ihelp", "chatEvent", pWarden, "We knew enough to trap you here.")
	createEvent(25000,"axkvaGroup", "engageWarden", pAxkva, SceneObject(pWarden):getObjectID())
	return 0
end

function axkvaGroup:engageWarden(pAxkva, wardenID)
	if (SceneObject(pAxkva):getZoneName() == "") then return 0 end

	local pWarden = getSceneObject(wardenID)
	if ((pWarden == nil) or (SceneObject(pWarden):getZoneName() == "")) then return 0 end

	CreatureObject(pWarden):setPvpStatusBitmask(ATTACKABLE)
	CreatureObject(pAxkva):engageCombat(pWarden)

	Ihelp:chatEvent(pAxkva, "I will not be taunted by some phantom. Begone!")
end

function axkvaGroup:wardenDead(pWarden, pPlayer)
	if (SceneObject(pWarden):getZoneName() == "") then return 0 end
	local pBuilding = Ihelp:getBuilding(pWarden)
	local bID = SceneObject(pBuilding):getObjectID()
	local pAxkva = getSceneObject(readData(bID.."activeBoss"))
	createEvent(5000,"Ihelp", "chatEvent", pAxkva, "Feel your Warden's destruction Gethzerion, and know that I come for you next.")
	createEvent(7000,"axkvaGroup", "testAxkva", pAxkva, "")
	return 0
end

function axkvaGroup:testAxkva(pAxkva, pPlayer)
	if ((SceneObject(pAxkva):getZoneName() == "") or (CreatureObject(pAxkva):isInCombat())) then
		createEvent(100, "axkvaGroup", "setCreatureAttackable", pAxkva,ATTACKABLE+ENEMY+AGGRESSIVE)
        	createObserver(DAMAGERECEIVED, "axkvaGroup", "axkvaEngaged", pAxkva)
		return 0
	end
	SceneObject(pAxkva):updateDirection(math.rad(103))
	createEvent(8000, "Ihelp", "chatEventMood", pAxkva, "As for the rest of you./0/0/wave")
	createEvent(14000,"Ihelp", "chatEventMood", pAxkva, "Your performance against my pitiful companions has amused me. Take this opportunity to flee, and hope we never meet again./0/0/shoo")
        createObserver(DEFENDERADDED, "axkvaGroup", "axkvaEngaged", pAxkva)
	createEvent(16000, "axkvaGroup", "setCreatureAttackable", pAxkva,ATTACKABLE)
	createEvent(37000, "axkvaGroup", "setCreatureAttackable", pAxkva,ATTACKABLE+ENEMY+AGGRESSIVE)
	return 0
end

function axkvaGroup:notifyAxkvaDead(pAxkva, pPlayer)
	if (SceneObject(pAxkva):getZoneName() == "") then return 0 end

	local pVictimInv = CreatureObject(pAxkva):getSlottedObject("inventory")
	if (pVictimInv ~= nil) then
		createLoot(pVictimInv, "power_crystals", 500, true)
	end

	local pBuilding = Ihelp:getBuilding(pAxkva)
	axkvaGroup:unlockBattleArena(pBuilding)
	createEvent(90000, "axkvaGroup", "despawnInstance", pBuilding,"")
	return 0
end

function axkvaGroup:axkvaEngaged(pAxkva, pPlayer)
	--print("pAxkva engaged")
	if ((SceneObject(pAxkva):getZoneName() == "")) then return 0 end
        dropObserver(DEFENDERADDED, "axkvaGroup", "axkvaEngaged", pAxkva)
        dropObserver(DAMAGERECEIVED, "axkvaGroup", "axkvaEngaged", pAxkva)

	spatialChat(pAxkva, "You choose to stay and die then. Have it your way!")	
       
	local pBuilding = Ihelp:getBuilding(pAxkva)
	axkvaGroup:lockBattleArena(pBuilding)
	
	createEvent(15000, "axkvaGroup", "axkvaScheduleSpecial", pAxkva, "")
	return 0
end

function axkvaGroup:axkvaScheduleSpecial(pAxkva)
	local zone = SceneObject(pAxkva):getZoneName()
	if (zone == "") then return 0 end
	local pBuilding = Ihelp:getBuilding(pAxkva)
	local axkva = SceneObject(pAxkva)
	local parentID = axkva:getParentID()
	if (CreatureObject(pAxkva):isInCombat())then
		local targets = CreatureObject(pAxkva):getThreatMap()
		local playersInRange = {}
		if (#targets < 1) then --make sure we got a valid table of threats, or grab highest threat defender
			targets = {AiAgent(pAxkva):getTargetFromDefenders()}
		end
		for i=1, #targets, 1 do	--test each targets range
			local distance = SceneObject(pAxkva):getDistanceTo(targets[i])
			if (distance < 10) then --if range < 10 insert to in-Range table
				table.insert(playersInRange, targets[i])
			end
		end
		if (#playersInRange > 2) then
			CreatureObject(pAxkva):playEffect("clienteffect/trap_electric_01.cef", "")
			local x = axkva:getPositionX()
			local y = axkva:getPositionY()
			local z = axkva:getPositionZ()
			local pPart = spawnSceneObject(zone, "object/static/particle/pt_axkvamin_lightning.iff",x,z,y,parentID,0)
			createEvent(8000, "Ihelp", "destroy", pPart, "")
			createEvent(4000, "axkvaGroup", "axkvaStormEvent", pPart, "")
			foreach(playersInRange,function(player)
				applyCommandEffect(player, 5, 5, 50) --snare target
			end)
		end

		local skill = math.random(3)
		--print("skill:",skill)
		local pTarget = targets[math.random(#targets)]
		if ((skill > 1)) then
			if (CreatureObject(pTarget):checkCooldownRecovery("AxkvaEncase") and CreatureObject(pTarget):checkCooldownRecovery("AxkvaGas")) then
				if (skill == 3)then
					CreatureObject(pTarget):addCooldown("AxkvaGas", (10+math.random(20))*1000)
					axkvaGroup:axkvaPoisonEvent(pTarget)
				else
					CreatureObject(pTarget):setPosture(KNOCKEDDOWN)
					applyCommandEffect(pTarget, 5, 5, 1)--root
					createEvent(1000, "axkvaGroup", "crystalPlaced", pTarget, "")
					CreatureObject(pTarget):addCooldown("AxkvaEncase", 60000)
				end
			end
		else
			createEvent(5000, "axkvaGroup", "axkvaScheduleSpecial", pAxkva, "")
			return 0
		end
			createEvent((4 + math.random(10)) *1000, "axkvaGroup", "axkvaScheduleSpecial", pAxkva, "")
	else
        	createObserver(DEFENDERADDED, "axkvaGroup", "axkvaEngaged", pAxkva)
		axkvaGroup:unlockBattleArena(pBuilding)
	end
	return 0
end

function axkvaGroup:axkvaPoisonEvent(pTarget)
	--print("started poison event")
	if ((pTarget == nil) or (SceneObject(pTarget):getZoneName() == "") or not(SceneObject(pTarget):isInside())) then return 0 end
	local zone = SceneObject(pTarget):getZoneName()
	if not(CreatureObject(pTarget):checkCooldownRecovery("AxkvaGas")) then
		local target = SceneObject(pTarget)
		local parentID = target:getParentID()
		local x = target:getPositionX()
		local y = target:getPositionY()
		local z = target:getPositionZ()
		local pPart = spawnSceneObject(zone,"object/static/particle/pt_contagion_debuff.iff",x,z,y,parentID,0)
		local pPart2 = spawnSceneObject(zone, "object/static/particle/pt_contagion_explode.iff", x, z, y, parentID,0)
		local pBuilding = Ihelp:getBuilding(pTarget)
		local bID = SceneObject(pBuilding):getObjectID()
		local pAxkva = getSceneObject(readData(bID.."activeBoss"))
		if (SceneObject(pAxkva):getZoneName() == "") then return 0 end
		axkvaGroup:damageThreatsInRange(pPart, pAxkva, 4,-1, 50, 200, false, "")
		createEvent(7000, "Ihelp", "destroy", pPart, "")
		createEvent(8000, "Ihelp", "destroy", pPart2, "")
		SceneObject(pPart2):playEffect("clienteffect/pl_force_regain_consciousness_self.cef", "")
		createEvent((15 + math.random(20))* 100, "axkvaGroup", "axkvaPoisonEvent", pTarget, "")
		createEvent(1005, "axkvaGroup", "axkvaPoisonPulse", pPart2, 4)
	else
		CreatureObject(pTarget):addCooldown("AxkvaGas", 20000)
	end
	return 0
end

function axkvaGroup:axkvaPoisonPulse(pPart, pulseCount)
	if ((SceneObject(pPart):getZoneName() == "") or (tonumber(pulseCount) < 1)) then return 0 end
	local pBuilding = Ihelp:getBuilding(pPart)
	local bID = SceneObject(pBuilding):getObjectID()
	local pAxkva = getSceneObject(readData(bID.."activeBoss"))
	if (SceneObject(pAxkva):getZoneName() == "") then return 0 end
	axkvaGroup:damageThreatsInRange(pPart, pAxkva, 4,-1, 20, 150, false, "")
	createEvent((9 + math.random(11))*100, "axkvaGroup", "axkvaPoisonPulse", pPart, pulseCount-1)
	return 0
end

function axkvaGroup:axkvaStormEvent(pPart)
	local zone = SceneObject(pPart):getZoneName()
	if (zone == "") then return 0 end
	local particle = SceneObject(pPart)
	local parentID = particle:getParentID()
	local x = particle:getPositionX()
	local y = particle:getPositionY()
	local z = particle:getPositionZ()
	local pPart2 = spawnSceneObject(zone,"object/static/particle/pt_axkvamin_lightning_base.iff",x,z,y,parentID,0)
	createEvent(10500, "Ihelp", "destroy", pPart2, "")
	axkvaGroup:axkvaStormPulse(pPart2, 4)
	return 0
end

function axkvaGroup:axkvaStormPulse(pPart, pulseCount)
	if ((SceneObject(pPart):getZoneName() == "") or (tonumber(pulseCount) < 1)) then return 0 end
	local pBuilding = Ihelp:getBuilding(pPart)
	local bID = SceneObject(pBuilding):getObjectID()
	local pAxkva = getSceneObject(readData(bID.."activeBoss"))
	if (SceneObject(pAxkva):getZoneName() == "") then return 0 end
	axkvaGroup:damageThreatsInRange(pPart, pAxkva, 8,-1, 500, 1000, false, "")
	createEvent(4000, "axkvaGroup", "axkvaStormPulse", pPart, pulseCount-1)
	SceneObject(pPart):playEffect("clienteffect/pl_force_resist_disease_self.cef", "")
	return 0
end

function axkvaGroup:crystalPlaced(pPlayer)
	local zone = SceneObject(pPlayer):getZoneName()
	if ((pPlayer == nil) or (zone == "")) then return 0 end
	applyCommandEffect(pPlayer, 5, 60, 30) --snare target
	local player = SceneObject(pPlayer)
	local parentID = player:getParentID()
	local x = player:getPositionX()
	local y = player:getPositionY()
	local z = player:getPositionZ()
	local crystal = spawnSceneObject(zone, "object/static/destructible/axkva_empty_crystal.iff",x,z,y,parentID,math.random(31)*.1)
	createObserver(OBJECTDESTRUCTION, "axkvaGroup", "crystalDestroyed", crystal)
	TangibleObject(crystal):setMaxCondition(40000)
	createEvent(1000, "axkvaGroup", "crystalPulse", crystal, SceneObject(pPlayer):getObjectID())
	createEvent(59000, "axkvaGroup", "crystalDestroyed", crystal, "")
end

function axkvaGroup:crystalPulse(pCrystal, targetID)
	if (pCrystal == nil) then return 0 end

	local zone = SceneObject(pCrystal):getZoneName()
	if (zone == "") then return 0 end

	local pTarget = getSceneObject(targetID)
	if ((pTarget == nil) or (CreatureObject(pTarget):isDead())) then
		axkvaGroup:crystalDestroyed(pCrystal)
		return 0
	end

	applyCommandEffect(pTarget, 5, 2, 1) --snare target

	local pBuilding = Ihelp:getBuilding(pCrystal)
	local bID = SceneObject(pBuilding):getObjectID()
	local pAxkva = getSceneObject(readData(bID.."activeBoss"))

	if ((pAxkva == nil) or (SceneObject(pAxkva):getZoneName() == "") or (CreatureObject(pAxkva):isDead())) then
		axkvaGroup:crystalDestroyed(pCrystal)
		return 0
	end

	local dType = ((math.random(2)-1)*3)
	local damage = (18 + math.random(25))*10
	CreatureObject(pTarget):inflictDamage(pAxkva, dType, damage, true)
	CreatureObject(pAxkva):healDamage((damage * 5), 6)
	CreatureObject(pAxkva):playEffect("clienteffect/healing_healdamage.cef", "head")

	local crystal = SceneObject(pCrystal)
	if (crystal:getDistanceTo(pTarget) > 1) then
		local parentID = crystal:getParentID()
		local x = crystal:getPositionX()
		local y = crystal:getPositionY()
		local z = crystal:getPositionZ()
		SceneObject(pTarget):teleport(x, z, y, parentID)
	end
	createEvent(2000, "axkvaGroup", "crystalPulse", pCrystal, targetID)
	return 0
end

function axkvaGroup:crystalDestroyed(pPart)
	if (pPart == nil) then return 0 end
	local zone = SceneObject(pPart):getZoneName()
	if (zone == "") then return 0 end
	dropObserver(OBJECTDESTRUCTION, "axkvaGroup", "crystalDestroyed", pPart)
	local particle = SceneObject(pPart)
	local parentID = particle:getParentID()
	local x = particle:getPositionX()
	local y = particle:getPositionY()
	local z = particle:getPositionZ()
	local pPart2 = spawnSceneObject(zone,"object/static/particle/pt_sm_explosion.iff",x,z,y,parentID,0)
	local pPart3 = spawnSceneObject(zone,"object/static/particle/pt_lair_evil_fire_large_red.iff",x,z,y,parentID,0)
	createEvent(1500, "Ihelp", "destroy", pPart, "")
	createEvent(3000, "Ihelp", "destroy", pPart2, "")
	createEvent(3000, "Ihelp", "destroy", pPart3, "")
	return 0
end

function axkvaGroup:damageThreatsInRange(pSob,pAttacker,range,dType,min,max,targetCef,cefLoc)
	cefLoc = cefLoc or ""
	local targets = CreatureObject(pAttacker):getThreatMap()
	local playersInRange = {}
	if (#targets < 1) then
		targets = {AiAgent(pAttacker):getTargetFromDefenders()}
	end
	for i=1, #targets, 1 do
		local distance = SceneObject(pSob):getDistanceTo(targets[i])
		if (distance < range) then
			if (dType < 0) then
				dType = ((math.random(3)-1)*3)
			end
			CreatureObject(targets[i]):inflictDamage(pAttacker, dType, min -1 + math.random(max-min), true)
			if (targetCef) then
				CreatureObject(targets[i]):playEffect(targetCef, cefLoc)
			end
		end
	end
	return 0
end

function axkvaGroup:setCreatureAttackable(pCreo, bitmask)
	if (SceneObject(pCreo):getZoneName() == "") then return 0 end
	CreatureObject(pCreo):setPvpStatusBitmask(bitmask)
end

function axkvaGroup:despawnInstance(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	WF_Instance_Handler:despawnBuilding(pBuilding)
	return 0
end

function axkvaGroup:despawnAddList(pBuilding)
	if (SceneObject(pBuilding):getZoneName() == "") then return 0 end
	local bID = SceneObject(pBuilding):getObjectID()
	local addString = readStringData(bID.."activeBossAdds")
	local addList =  HelperFuncs:splitString(addString, "/")
	for i = 1, #addList, 1 do
		local pSob = getSceneObject(addList[i])
		if (pSob) then
			if not(CreatureObject(pSob):isDead()) then
				if (CreatureObject(pSob):isInCombat()) then
					forcePeace(pSob)
				end
				Ihelp:destroy(pSob)
			end
		end
	end
	deleteStringData(bID.."activeBossAdds")
	return 0
end
