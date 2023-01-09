moonFestivalSolo = ScreenPlay:new {
	instance = "moonFestivalSolo",
	--leashDistance = 75, --not needed for this screenplay, commented to save power
	phases = {
		[1] = {
			damageLimit = 0.9, --%value of max H,A,M
			taunt = "Enemy Survival Chance = 87%",
			spawns = {		--t	x    z      y    f  c
				{"ig_battle_droid", -20.0, 0.0,  43.2, 177, 1},
				{"ig_battle_droid",  20.0, 0.0,  43.2, 177, 1},
				{"ig_battle_droid",  20.0, 0.0, -23.0,   0, 1},
				{"ig_battle_droid", -20.0, 0.0, -23.0,   0, 1},
				spawnTaunts = {"Target found Sir!", "Rodger, Rodger!", "Locating Target..", "Target Locked Sir!"},
			},
			--script = false, --not needed for this screenplay, commented to save power --TODO add functionality for this
		},
		[2] = {
			damageLimit = 0.7, --%value of max H,A,M
			taunt = "Enemy Survival Chance = 73%",
			spawns = {	   --t	    x    z      y    f  c
				{"ig_droideka",	-20.0, 0.0,  43.2, 177, 1},
				{"ig_droideka",  20.0, 0.0,  43.2, 177, 1},
				{"ig_droideka",  20.0, 0.0, -23.0,   0, 1},
				{"ig_droideka", -20.0, 0.0, -23.0,   0, 1},
				spawnTaunts = {"Target Found!", "Locating Target..", "Target Locked."},
			},
		},
		[4] = {
			damageLimit = 0.6, --%value of max H,A,M
			taunt = "Enemy Survival Chance = 53%",
			spawns = {	   --t	    x    z      y    f  c
				{"ig_droideka",	-20.0, 0.0,  43.2, 177, 1},
				{"ig_droideka",  20.0, 0.0,  43.2, 177, 1},
				{"ig_droideka",  20.0, 0.0, -23.0,   0, 1},
				{"ig_droideka", -20.0, 0.0, -23.0,   0, 1},
				spawnTaunts = {"Target Found!", "Enemy Identified!", "Locating Target..", "Target Locked."},
			},
		},
		[8] = {
			damageLimit = 0.5, --%value of max H,A,M
			taunt = "Enemy Survival Chance = 42%",
			spawns = {	   --t	    x    z      y    f  c
				{"ig_droideka",	-20.0, 0.0,  43.2, 177, 1},
				{"ig_droideka",  20.0, 0.0,  43.2, 177, 1},
				{"ig_droideka",  20.0, 0.0, -23.0,   0, 1},
				{"ig_droideka", -20.0, 0.0, -23.0,   0, 1},
				spawnTaunts = {"Destroy them!", "Enemy Identified!", "Target Pending..", "Target verified."},
			},
		},
		[16] = {
			damageLimit = 0.4, --%value of max H,A,M
			taunt = "Enemy Survival Chance = 17%",
			spawns = {		     --t      x    z     y    f  c
				{"ig_elite_battle_droid", -13.0, 0.0, 10.0, 177, 1},
				{"ig_elite_battle_droid",  13.0, 0.0, 10.0, 177, 1},
				spawnTaunts = {"Bio-Organism Identified!", "Enemy Locked!", "Command invoked..", "Target Identified."},
			},
		},
		[32] = {
			damageLimit = 0.01, --%value of max H,A,M
			taunt = "ERROR COMMAND SYmoonFestivalDeco:spawnDeco(pBuilding)STEM OFFLINE tokenizer = incomplete type, index = -1, delimeter = incomplete type command = incomplete type fullCommand = incomplete type arguments = incomplete type Core::run Core 21 No locals.",
		},
	},
}
registerScreenPlay("moonFestivalSolo", false)

--------------------------------------
--   Initialize screenplay           -
--------------------------------------
function moonFestivalSolo:start(pBuilding)
	print("Moon Festival Solo ScreenPlay Started",pBuilding)
	moonFestivalDeco:spawnDeco(pBuilding)
	--self:spawnMobiles(pBuilding)
end
--Spawn Initial Mobiles
function moonFestivalSolo:spawnMobiles(pBuilding)
	local bID = SceneObject(pBuilding):getObjectID()
	local zone = SceneObject(getSceneObject(bID)):getZoneName()
	local pTrigger = spawnMobile(zone, "ig_mouse_droid", 0, 0, 0, 0, -99, bID+1)
        createObserver(OBJECTDESTRUCTION, "moonFestivalSolo", "notifyTriggerDead", pTrigger)
	return 0
end
--Trigger Death Event
function moonFestivalSolo:notifyTriggerDead(pTrigger, pPlayer)
	local pBuilding = Ihelp:getBuilding(pTrigger)
	local zone = SceneObject(pBuilding):getZoneName()
	local bID = SceneObject(pBuilding):getObjectID()
        local pBoss = spawnMobile(zone, "ig88_npc_boss", 0, 0, 0, -18, 0, bID+1)
	spatialChat(pBoss, "You dare disturb our endless slumber!")	
	createObserver(DAMAGERECEIVED,"Ihelp","boss_damage", pBoss)
	createObserver(OBJECTDESTRUCTION, "moonFestivalSolo", "notifyBossDead", pBoss)
	createEvent(1800000, "Ihelp", "despawnBoss", pBoss,"")--Boss Despawn Timer
	return 0
end
--Boss Death Event
function moonFestivalSolo:notifyBossDead(pBoss, pPlayer)
	local pBuilding = Ihelp:getBuilding(pBoss)
	moonFestivalSolo:resetScreenplayStatus(pBuilding)
	return 0
end
--Reset Instance Screenplay
function moonFestivalSolo:resetScreenplayStatus(pBuilding)
	createEvent(6000, "Ihelp", "despawnAdds", pBuilding, "")
	createEvent(180000, "moonFestivalSolo","spawnMobiles", pBuilding, "")--Trigger Respawn Timer
	return 0	
end
