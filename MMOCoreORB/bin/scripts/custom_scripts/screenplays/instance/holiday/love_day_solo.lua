----------------------------------------------------------------Life Day Solo

love_day_solo_sp = ScreenPlay:new{

	lootLevel = 300,
	rewardGroups = {
		{"color_crystals","forage_food"},
		{"wearables_rare","clothing_attachments"},
	},
	specialRewards = {
		"object/tangible/furniture/decorative/heart_holo_lamp_01.iff",
		"object/tangible/furniture/decorative/heart_holo_lamp_02_fire.iff",
		"object/tangible/furniture/decorative/heart_holo_lamp_03_energy.iff",
	},
	rareRewards = {
		"object/tangible/painting/heroic_collage_01.iff",
		"object/tangible/painting/itho_power_poster_01.iff",
		"object/tangible/painting/force_strong_in_the_family_sign_01.iff",
		"object/tangible/painting/veteran_wall_vader_painting.iff",
	},
	rewardContainer = "object/tangible/furniture/reward_chest_gold.iff",

	--wp's for npc's with locking cells
	wps = { -- x      z       y      f    c
		{-23.8, -27.9,   -9.3,  170,  1}, -- top entry
		{-44.4, -47.2,  -12.2, -179,  2}, -- top hall
		{-67.3, -69.2,  -37.3,  -97,  3}, -- first room
		{-62.4, -66.3, -135.8,   20,  6}, -- second hall
		{-92.1, -66.1, -126.9,  167,  7}, -- second hall end
		{ -152, -66.3, -126.4,   20,  8}, -- room of columns
		{-50.6, -48.8,   -102,   -2, 10}, -- final hall
	},
	--wp's for first npc filler set
	wpsFiller = {
		--{ 23.7, -38.5, -33.1,   0, 2},
		{-24.5,  -40.5,    -46, -109, 2},
		{-47.9,  -48.5,  -63.3,   97, 2},
		{-51.4,    -49,  -29.4,   88, 2},
		{  -90,  -61.9,  -12.1,   77, 3},
		{-82.7,  -69.7,  -43.5,  -10, 3},
		{-66.4,  -75.3,  -62.6,  -63, 4},
		{  -91,  -76.3,  -84.4,   12, 4},
		{-63.5,  -76.4,  -85.8,  -45, 4},
		{-55.2,  -71.6, -113.9,    2, 6},
		{-86.5,  -66.8, -140.6,   77, 7},
		{-95.3,  -66.2, -109.6,  171, 5},
		{-115.5, -66.2, -105.9,  100, 8},
		{-136.5, -66.3, -117.3,   92, 8},
		{-134.3, -66.6,    -98,  119, 8},
		{  -157, -66.9, -103.1,   68, 8},
		{ -70.9, -46.4, -106.7,   82, 5},
		{ -92.6, -46.2, -104.2,  109, 5},
	},
	--wp's for second npc filler set
	wpsFiller2 = {
		--{ 155, -66.4,   -98,   80, 8},
		{-102.3,  -66, -108.1,  -87, 8},
		{-73.9, -66.3, -140.2,  -93, 7},
		{-62.6, -75.7,  -70.7,  176, 4},
		{  -95, -75.7,  -70.2,  121, 4},
		{-56.4, -68.2,  -36.2, -106, 2},
		{-87.3, -64.6,  -27.6,  168, 3},
		{-88.1, -62.6,  -19.8,  166, 3},
		{-44.2, -47.1,   -8.1, -104, 2},
		{-55.3, -49.2,  -31.1,    7, 2},
		{-45.3, -47.7,  -63.3,   12, 2},
		{-21.6, -41.7,  -69.4,  -87, 2},
		{-22.9, -27.7,   -8.9, -172, 1},
	},
	--wp's for bosses
	bossWP1 = { -188.9, -66.2, -103.2,  50,  9}, -- first boss
	bossWP2 = {  -77.2, -46.6,   -142, -91, 11}, -- second boss

	--filler npc list (npc's will randomly spawn from this list)
	mobiles = {"holiday_candy_graul","holiday_candy_pharple","holiday_cupid_baby"},
}
registerScreenPlay("love_day_solo_sp", false)

function love_day_solo_sp:start(pBuilding)
	self:spawnMobiles(pBuilding)
end

--spawn initial mobiles, lock cells, and set up observers
function love_day_solo_sp:spawnMobiles(pBuilding)
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local str = readStringData("WF_Instance_Handler:"..bID)
	local npc
	local wp
	
	--Spawn npc's with locking cells
	for i = 0, #self.wps-1, 1 do
		i = i + 1
		wp = self.wps[i]
		npc = spawnMobile(zone, self.mobiles[math.random(#self.mobiles)], 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])
 		createObserver(OBJECTDESTRUCTION, "Ihelp", "mobKilled", npc)
		CreatureObject(npc):setScreenPlayState((wp[5]+1), str)	
		local pCell = getSceneObject(bID+wp[5]+1)
		SceneObject(pCell):setContainerInheritPermissionsFromParent(false)
		SceneObject(pCell):clearContainerDefaultDenyPermission(WALKIN)
		SceneObject(pCell):clearContainerDefaultAllowPermission(WALKIN)
	end
	
	--spawn bosses
	wp = self.bossWP1
	npc = spawnMobile(zone, "holiday_candy_graul_boss", 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])
 	createObserver(OBJECTDESTRUCTION, "love_day_solo_sp", "bossDead", npc)
 	createObserver(OBJECTDESTRUCTION, "Ihelp", "mobKilled", npc)
	CreatureObject(npc):setScreenPlayState(10, str)

	wp = self.bossWP2
	npc = spawnMobile(zone, "holiday_cupid_boss", 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])
 	createObserver(OBJECTDESTRUCTION, "love_day_solo_sp", "finalBossDead", npc)

	--spawn filler mobs
	for i = 0, #self.wpsFiller-1, 1 do
		i = i + 1
		wp = self.wpsFiller[i]
		spawnMobile(zone, self.mobiles[math.random(#self.mobiles)], 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])
	end
end

--first boss dead
function love_day_solo_sp:bossDead(boss)
	local pBuilding = SceneObject(SceneObject(boss):getParent()):getParent()
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()
	local wp
	for i = 0, #self.wpsFiller2-1, 1 do
		i = i + 1
		wp = self.wpsFiller2[i]
		spawnMobile(zone, self.mobiles[math.random(#self.mobiles)], 0, wp[1], wp[2], wp[3], wp[4], bID+wp[5])
	end

	--spawnSceneObject(zoneName, iffString, x, z, y, cellID, math.rad(facingDirection))
	local pContainer = spawnSceneObject(zone, self.rewardContainer, -182.7, -65.8, -109.7, bID+9, math.rad(-33))
	SceneObject(pContainer):setCustomObjectName("Reward Chest")
	SceneObject(pContainer):setObjectMenuComponent("love_day_solo_sp")

	pContainer = spawnSceneObject(zone, self.rewardContainer, 15.8, -4, -3.3, bID+1, math.rad(-137))
	SceneObject(pContainer):setCustomObjectName("Reward Chest")
	SceneObject(pContainer):setObjectMenuComponent("love_day_solo_sp")
	return 0
end

--instance complete schedule despawn
function love_day_solo_sp:finalBossDead(boss, pPlayer)
	local pBuilding = SceneObject(SceneObject(boss):getParent()):getParent()
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(pBuilding):getZoneName()

 	createEvent(90000, "WF_Instance_Handler", "despawnBuilding", pBuilding, "")
	CreatureObject(pPlayer):sendSystemMessage("(This Instance will despawn in 90 Seconds)")

	--spawnSceneObject(zoneName, iffString, x, z, y, cellID, math.rad(facingDirection))
	local pContainer = spawnSceneObject(zone, self.rewardContainer, -92.8, -46.4, -146.6, bID+11, math.rad(39))
	SceneObject(pContainer):setCustomObjectName("Reward Chest")
	SceneObject(pContainer):setObjectMenuComponent("love_day_solo_sp")
	return 0
end

-------------------------------MENU 

-- Display Radial Options
function love_day_solo_sp:fillObjectMenuResponse(pSceneObject, pMenuResponse, pPlayer)
	if (pSceneObject == nil or pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return
	end

	local pGhost = CreatureObject(pPlayer):getPlayerObject()
	if (pGhost == nil) then
		return
	end

	local menuResponse = LuaObjectMenuResponse(pMenuResponse)
	menuResponse:addRadialMenuItem(103, 3, "Retrieve your Reward")
end

-- player selection processing
function love_day_solo_sp:handleObjectMenuSelect(pSceneObject, pPlayer, selectedID)
	if (pSceneObject == nil or pPlayer == nil) then
		return 0
	end

	if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
		CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
		return 0 
	end

	if not CreatureObject(pPlayer):isInRangeWithObject(pSceneObject, 6) then
		CreatureObject(pPlayer):sendSystemMessage("(You are not in range to use this object)")
		return 0
	end

	if not((selectedID == 103)) then
		return 0
	end

	local pInventory = CreatureObject(pPlayer):getSlottedObject("inventory")
	local inventory = LuaSceneObject(pInventory)
	  
         -- Insufficent Space
	if (SceneObject(pInventory):isContainerFullRecursive()) then
		CreatureObject(pPlayer):sendSystemMessage("You do not have enough inventory space")  
		return 0
	end

	local number = math.random(#self.rewardGroups + 1)
	if (number <= #self.rewardGroups) then
		local lootGroup = self.rewardGroups[number][math.random(#self.rewardGroups[number])]
		createLoot(pInventory, lootGroup, self.lootLevel, true)
	else
		local lootItem, pItem
		if (math.random(10) < 8) then
			lootItem = self.specialRewards[math.random(#self.specialRewards)]
		else
			lootItem = self.rareRewards[math.random(#self.rareRewards)]
		end
		pItem = giveItem(pInventory, lootItem, -1)
		if (pItem == nil) then
			CreatureObject(pPlayer):sendSystemMessage("*Error: Generate Item*")
			return 0
		end
		SceneObject(pItem):sendTo(pPlayer)
	end

	local msg = "(You recieve a Reward!)"
	CreatureObject(pPlayer):sendSystemMessage(msg)
	SceneObject(pSceneObject):destroyObjectFromWorld()
end
