----------------------------------------------------------------Life Day Solo

life_day_solo_sp = ScreenPlay:new{
	--wp's for npc's with locking cells
	wps = { -- x      z      y      f  c
		{  22, -27.6,  -8.6,  -86, 1}, -- top entry
		{46.1, -47.2, -11.6, -174, 2}, -- top hall
		{82.8, -68.8, -41.2,   -5, 3}, -- first room
		{63.4, -66.4,-135.7,  -24, 6}, -- second hall
		{  92, -66.8,  -130,  159, 7}, -- second hall end
		{ 155, -66.4,   -98, -112, 8}, -- room of columns
		{  61, -47.7,-106.6,  -95,10}, -- final hall
	},
	--wp's for first npc filler set
	wpsFiller = {
		{ 23.7, -38.5, -33.1,   0, 2},
		{ 23.4, -42.3, -68.1,  46, 2},
		{ 43.3, -47.5, -44.4,-176, 2},
		{ 55.0, -68.4, -38.7,  77, 2},
		{ 89.3, -62.5, -19.6, -30, 3},
		{ 67.6, -76.9, -86.6,  34, 4},
		{136.5, -66.2,-116.6, -52, 8},
		{132.0, -66.6, -93.2, 135, 8},
	},
	--wp's for second npc filler set
	wpsFiller2 = {
		{ 155, -66.4,   -98,  80, 8},
		{94.9, -66.1,-110.9,  57, 5},
		{77.8, -75.6, -58.1, 178, 4},
		{77.1, -61.1,  -8.4, 121, 3},
		{49.1, -48.5, -64.9,  34, 2},
		{50.7, -51.4, -90.7,  -2,10},
		{94.0, -46.0,-106.1,-110, 5},
	},
	--wp's for bosses
	bossWP1 = { 191, -66.7, -102.3, -99,  9}, -- first boss
	bossWP2 = {  79, -46.6,   -142,  73, 11}, -- second boss

	--filler npc list (npc's will randomly spawn from this list)
	mobiles = {"holiday_wampa","holiday_tauntaun","holiday_boar"},--TODO (Nexxus) change filler mobile templates
}
registerScreenPlay("life_day_solo_sp", false)

function life_day_solo_sp:start(pBuilding)
	self:spawnMobiles(pBuilding)
	self:spawnSceneObjects(pBuilding)
	--print("(life_day_solo_sp) Instance Screenplay started with Building Pointer:("..tostring(pBuilding)..")")
end

--spawn initial mobiles, lock cells, and set up observers
function life_day_solo_sp:spawnMobiles(pBuilding)
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local npc
	local wp
	
	--Spawn npc's with locking cells
	for i = 0, #self.wps-1, 1 do
		i = i + 1
		wp = self.wps[i]
		npc = spawnMobile(zone, "holiday_baby_wampa", 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])--TODO (Nexxus) change trigger mobile template
 		createObserver(OBJECTDESTRUCTION, "Ihelp", "mobKilled", npc)
		CreatureObject(npc):setScreenPlayState((wp[5]+1), str)	
		local pCell = getSceneObject(bID+wp[5]+1)
		SceneObject(pCell):setContainerInheritPermissionsFromParent(false)
		SceneObject(pCell):clearContainerDefaultDenyPermission(WALKIN)
		SceneObject(pCell):clearContainerDefaultAllowPermission(WALKIN)
	end
	
	--spawn bosses
	wp = self.bossWP1
	npc = spawnMobile(zone, "holiday_tauntaun_boss", 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])--TODO (Nexxus) change boss 1 mobile template
 	createObserver(OBJECTDESTRUCTION, "life_day_solo_sp", "bossDead", npc)
 	createObserver(OBJECTDESTRUCTION, "Ihelp", "mobKilled", npc)
	CreatureObject(npc):setScreenPlayState(10, str)

	wp = self.bossWP2
	npc = spawnMobile(zone, "holiday_wampa_boss", 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])--TODO (Nexxus) change boss 2 mobile template
 	createObserver(OBJECTDESTRUCTION, "life_day_solo_sp", "finalBossDead", npc)

	--spawn filler mobs
	for i = 0, #self.wpsFiller-1, 1 do
		i = i + 1
		wp = self.wpsFiller[i]
		spawnMobile(zone, self.mobiles[math.random(#self.mobiles)], 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])
	end
end

--use this area to spawn decorations in the dungeon
function life_day_solo_sp:spawnSceneObjects(pBuilding)
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()

	--spawnSceneObject(zoneName, iffString, x, z, y, cellID, math.rad(facingDirection))
	local pContainer = spawnSceneObject(zone, "object/tangible/storyteller/prop/pr_lifeday_presents.iff", 56.2, -49, -29, bID+2, math.rad(-67))
	SceneObject(pContainer):setCustomObjectName("Missing Presents")
	SceneObject(pContainer):setObjectMenuComponent("life_day_mini_game")

	pContainer = spawnSceneObject(zone, "object/tangible/storyteller/prop/pr_lifeday_presents.iff", 51.6, -67.7, -47.7, bID+2, math.rad(18))
	SceneObject(pContainer):setCustomObjectName("Missing Presents")
	SceneObject(pContainer):setObjectMenuComponent("life_day_mini_game")

	pContainer = spawnSceneObject(zone, "object/tangible/storyteller/prop/pr_lifeday_presents.iff", 136.4, -66.1, -108.3, bID+8, math.rad(-97))
	SceneObject(pContainer):setCustomObjectName("Missing Presents")
	SceneObject(pContainer):setObjectMenuComponent("life_day_mini_game")
end

--first boss dead
function life_day_solo_sp:bossDead(boss)
	local pBuilding = SceneObject(SceneObject(boss):getParent()):getParent()
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local wp
	for i = 0, #self.wpsFiller2-1, 1 do
		i = i + 1
		wp = self.wpsFiller2[i]
		spawnMobile(zone, self.mobiles[math.random(#self.mobiles)], 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])
	end
	return 0
end

--instance complete schedule despawn
function life_day_solo_sp:finalBossDead(boss, pPlayer)
	local pBuilding = SceneObject(SceneObject(boss):getParent()):getParent()
 	createEvent(90000, "WF_Instance_Handler", "despawnBuilding", pBuilding, "")
	CreatureObject(pPlayer):sendSystemMessage("(This Instance will despawn in 90 Seconds)")
	return 0
end
