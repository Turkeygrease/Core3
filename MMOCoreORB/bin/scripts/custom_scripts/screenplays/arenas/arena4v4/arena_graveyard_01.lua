arena_graveyard_01 = ScreenPlay:new{
	deco = {
		--template,x,z,y,d
		{"object/static/vehicle/static_tie_fighter.iff", 50, 4.7, 35, 180},
		{"object/static/vehicle/static_sandcrawler.iff", -55, 0, 35, 90},

		--template, x, z, y, ow, ox, oy, oz
		{"object/tangible/furniture/all/outbreak_deathtrooper_pile.iff", 10, 0, 10, 0.382683, 0, 0.92388, 0},
	},
}
registerScreenPlay("arena_graveyard_01", false)

function arena_graveyard_01:start(pControl)
	dropObserver(EXITEDBUILDING, "WF_Instance_Handler", "onExit", pControl)
	print("starting graveyard")
	arena_graveyard_01:spawnObjects(pControl)
	arena_graveyard_01:spawnAreas(pControl)
end

--spawn objects from random deco table
function arena_graveyard_01:spawnObjects(pControl)
	local dataStr = tostring(SceneObject(pControl):getObjectID())
	local ctrl = SceneObject(pControl)
	local zone = ctrl:getZoneName()
	local x = ctrl:getWorldPositionX()
	local z = ctrl:getWorldPositionZ()
	local y = ctrl:getWorldPositionY()
	local idStr = "" --read deco string
	for k,v in ipairs(arena_graveyard_01.deco) do
		local pOB
		if (#v == 5) then
			pOB = spawnSceneObject(zone, v[1], x+v[2], z+v[3], y+v[4], 0, math.rad(v[5]))
		elseif (#v == 8) then	--zone,template, x, z
			pOB = spawnSceneObject(zone, v[1], x+v[2], z+v[3], y+v[4], 0, v[5], v[6], v[7], v[8])
		end

		idStr = idStr.."/"..tostring(SceneObject(pOB):getObjectID())
	end

	writeStringData(dataStr..":deco", idStr) --store layout-objects in instance string deco
	createObserver(OBJECTREMOVEDFROMZONE, "arena_graveyard_01", "despawnObject", pControl)
end

--despawn deco objects
function arena_graveyard_01:despawnObject(pControl)
	local dataStr = tostring(SceneObject(pControl):getObjectID())
	local list = readStringData(dataStr..":deco") --store layout-objects in instance string deco
	arena_handler:destroyListObjects(list,"/")
end

--spawn control areas
function arena_graveyard_01:spawnAreas(pControl)
	print("spawning GRAVEYARD arena control")
	--spawn Blue Area
	local control = SceneObject(pControl)
	local pArea = spawnSceneObject(control:getZoneName(), "object/active_area.iff", control:getWorldPositionX(), control:getWorldPositionZ(), control:getWorldPositionY(), 0, math.rad(0))
	if (pArea ~= nil) then
		local activeArea = LuaActiveArea(pArea)
		activeArea:setCellObjectID(0)
		activeArea:setRectangular(44, 44)
		createObserver(ENTEREDAREA, "arena_graveyard_01", "enter", pArea)
		createObserver(EXITEDAREA, "arena_graveyard_01", "exit", pArea)
	end

--[[
	pArea = spawnSceneObject(control:getZoneName(), "object/active_area.iff", control:getWorldPositionX(), control:getWorldPositionZ(), control:getWorldPositionY(), 0, math.rad(0))
	if (pArea ~= nil) then
		local activeArea = LuaActiveArea(pArea)
		activeArea:setCellObjectID(0)
		activeArea:setRectangular(22, 22)
		createObserver(ENTEREDAREA, "arena_4v4_handler", "enter", pArea)
		createObserver(EXITEDAREA, "arena_4v4_handler", "exit", pArea)
	end
]]
end

-- player entered area (removes pending task trap)
function arena_graveyard_01:enter(pArea, pSob)
	print("enter")
	if (SceneObject(pSob):isPlayerCreature()) then
		SceneObject(pSob):cancelPendingTask("arena_graveyard_01", "eject")
	end
	return 0
end

-- player has left area (sets pending task trap)
function arena_graveyard_01:exit(pArea, pSob)
	print("exit")
	if (SceneObject(pSob):isPlayerCreature()) then
		local pGhost = CreatureObject(pSob):getPlayerObject()
		if ((pGhost == nil) or (not PlayerObject(pGhost):isOnline())) then
			return false
		end
		SceneObject(pSob):addPendingTask(500, "arena_graveyard_01", "eject")
	end
	return 0
end

function arena_graveyard_01:eject(pPlayer)
	print("ejected")
	local ejected = SceneObject(pPlayer)
	if (ejected == nil) then
		return false
	end

	if (ejected:isPlayerCreature()) then
		SceneObject(pPlayer):switchZone("tatooine", WFnav:rndRng(3494, 5), 5, WFnav:rndRng(-4786, 5), 0)
	end
end


