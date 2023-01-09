endor_pvp_event = ScreenPlay:new {
	numberOfActs = 1,

}
spHelper = require("screenplayHelper")
registerScreenPlay("endor_pvp_event", true)
local ObjectManager = require("managers.object.object_manager")  print("Object manager loaded for Endor PvP")

--------------------------------------
--   Initialize screenplay           -
--------------------------------------
function endor_pvp_event:start()
	if (isZoneEnabled("endor")) then
		self:spawnMobiles()		
 	end
end

function endor_pvp_event:spawnMobiles()
	local pTrigger = spawnMobile("endor", "death_watch_bloodguard", 3600, -3324, 200, 5214, 1, 0)
	spawnMobile("endor", "death_watch_battle_droid", 3600, -3347, 200, 5214, 1, 0)
	if (pTrigger ~= nil ) then	
        createObserver(OBJECTDESTRUCTION, "endor_pvp_event", "notifyTriggerDead", pTrigger)
	end
	writeData("endor_pvp_event:spawnState",0)	
	return 0
end
	

function endor_pvp_event:notifyTriggerDead(pTrigger, pPlayer)
        local pWarden = spawnMobile("endor", "endor_warden", 0, -3337, 200, 5235, 179, 0) print("Killed Trigger--Speaker spawn Endor PvP encounter")
	ObjectManager.withCreatureObject(pWarden, function(oBoss)
		writeData("warden", oBoss:getObjectID())			
		spatialChat(pWarden, "You fools! This is Mandalorian territory! Prepare to face our best, only one faction will stand when this is over... You have 60 seconds to prepare.")	
		createEvent(60000, "endor_pvp_event", "spawnBoss1", pBoss1,"")
	end)
	return 0

end

function endor_pvp_event:spawnBoss1(pBoss1, pPlayer)
        local pBoss1 = spawnMobile("endor", "endor_b1", 0, -3458, 200, 5181, 90, 0) print("spawned Endor Boss 1")
--[[	spawnMobile("endor", "endor_stormtrooper", 3600, -3408, 200, 5166, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3408, 200, 5171, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3408, 200, 5176, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3408, 200, 5181, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3408, 200, 5186, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3408, 200, 5191, -90, 0)

	spawnMobile("endor", "endor_stormtrooper", 3600, -3423, 200, 5166, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3423, 200, 5171, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3423, 200, 5176, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3423, 200, 5181, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3423, 200, 5186, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3423, 200, 5191, -90, 0)
]]
	spawnMobile("endor", "endor_stormtrooper", 3600, -3438, 200, 5166, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3438, 200, 5171, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3438, 200, 5176, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3438, 200, 5181, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3438, 200, 5186, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3438, 200, 5191, -90, 0)

	spawnMobile("endor", "endor_stormtrooper", 3600, -3453, 200, 5166, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3453, 200, 5171, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3453, 200, 5176, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3453, 200, 5181, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3453, 200, 5186, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3453, 200, 5191, -90, 0)

	spawnMobile("endor", "endor_rebtrooper", 3600, -3475, 200, 5166, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3475, 200, 5171, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3475, 200, 5176, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3475, 200, 5181, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3475, 200, 5186, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3475, 200, 5191, 90, 0)

	spawnMobile("endor", "endor_rebtrooper", 3600, -3460, 200, 5166, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3460, 200, 5171, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3460, 200, 5176, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3460, 200, 5181, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3460, 200, 5186, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3460, 200, 5191, 90, 0)


	ObjectManager.withCreatureObject(pBoss1, function(oBoss)
		writeData("endorboss1", oBoss:getObjectID())			
		spatialChat(pBoss1, "You are Weak!")	
		createObserver(OBJECTDESTRUCTION, "endor_pvp_event", "notifyBoss1Dead", pBoss1)
		createEvent(1800000, "endor_pvp_event", "despawnBoss1", pBoss1,"")		
	end)
	return 0
end

function endor_pvp_event:notifyBoss1Dead(pBoss1, pPlayer)
	writeData("endor_pvp_event:spawnState", 1)
	createEvent(8000, "endor_pvp_event", "spawnBoss2", pBoss2,"")
	return 0
end

function endor_pvp_event:despawnBoss1(pBoss1, pPlayer)
	forcePeace(pBoss1)
	spHelper.destroy(readData("endorboss1"),true)
	writeData("endor_pvp_event:spawnState", 0)
	createEvent(6000, "endor_pvp_event", "despawnAdd", pAdd,"")
	return 0
end

function endor_pvp_event:spawnBoss2(pBoss2, pPlayer)
        local pBoss2 = spawnMobile("endor", "endor_b2", 0, -3225, 200, 5181, -90, 0) print("Startup Endor PvP encounter")
	spawnMobile("endor", "endor_stormtrooper", 3600, -3199, 200, 5166, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3199, 200, 5171, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3199, 200, 5176, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3199, 200, 5181, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3199, 200, 5186, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3199, 200, 5191, -90, 0)

	spawnMobile("endor", "endor_stormtrooper", 3600, -3214, 200, 5166, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3214, 200, 5171, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3214, 200, 5176, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3214, 200, 5181, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3214, 200, 5186, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3214, 200, 5191, -90, 0)

	spawnMobile("endor", "endor_rebtrooper", 3600, -3235, 200, 5166, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3235, 200, 5171, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3235, 200, 5176, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3235, 200, 5181, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3235, 200, 5186, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3235, 200, 5191, 90, 0)

	spawnMobile("endor", "endor_rebtrooper", 3600, -3250, 200, 5166, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3250, 200, 5171, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3250, 200, 5176, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3250, 200, 5181, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3250, 200, 5186, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3250, 200, 5191, 90, 0)

--[[	spawnMobile("endor", "endor_rebtrooper", 3600, -3265, 200, 5166, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3265, 200, 5171, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3265, 200, 5176, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3265, 200, 5181, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3265, 200, 5186, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3265, 200, 5191, 90, 0)

	spawnMobile("endor", "endor_rebtrooper", 3600, -3280, 200, 5166, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3280, 200, 5171, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3280, 200, 5176, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3280, 200, 5181, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3280, 200, 5186, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3280, 200, 5191, 90, 0)
]]
	ObjectManager.withCreatureObject(pBoss2, function(oBoss)
		writeData("endorboss2", oBoss:getObjectID())			
		spatialChat(pBoss2, "Death is but a touch away")	
		createObserver(OBJECTDESTRUCTION, "endor_pvp_event", "notifyBoss2Dead", pBoss2)
		createEvent(1800000, "endor_pvp_event", "despawnBoss2", pBoss2,"")		
	end)
	return 0
end

function endor_pvp_event:notifyBoss2Dead(pBoss2, pPlayer)
	writeData("endor_pvp_event:spawnState", 2)
	createEvent(8000, "endor_pvp_event", "spawnBoss3", pBoss3,"")
	spatialChat(pWarden, "Your deaths await, head north!") 
	return 0

end

function endor_pvp_event:despawnBoss2(pBoss2, pPlayer)
	forcePeace(pBoss2)
	spHelper.destroy(readData("endorboss2"),true)
	writeData("endor_pvp_event:spawnState", 0)
	createEvent(6000, "endor_pvp_event", "despawnAdd", pAdd,"")
	return 0
end

function endor_pvp_event:spawnBoss3(pBoss3, pPlayer)
        local pBoss3 = spawnMobile("endor", "endor_b3", 0, -3336, 200, 5332, 180, 0) print("Startup Endor PvP encounter")
	spawnMobile("endor", "endor_rebtrooper", 3600, -3319, 200, 5308, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3324, 200, 5319, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3329, 200, 5319, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3334, 200, 5319, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3339, 200, 5319, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3344, 200, 5319, 1, 0)

	spawnMobile("endor", "endor_rebtrooper", 3600, -3319, 200, 5308, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3324, 200, 5308, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3329, 200, 5308, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3334, 200, 5308, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3339, 200, 5308, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3344, 200, 5308, 1, 0)

--[[	spawnMobile("endor", "endor_rebtrooper", 3600, -3319, 200, 5293, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3324, 200, 5293, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3329, 200, 5293, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3334, 200, 5293, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3339, 200, 5293, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3344, 200, 5293, 1, 0)

	spawnMobile("endor", "endor_rebtrooper", 3600, -3319, 200, 5278, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3324, 200, 5278, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3329, 200, 5278, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3334, 200, 5278, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3339, 200, 5278, 1, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3344, 200, 5278, 1, 0)
]]
	spawnMobile("endor", "endor_stormtrooper", 3600, -3319, 200, 5345, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3324, 200, 5345, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3329, 200, 5345, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3334, 200, 5345, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3339, 200, 5345, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3344, 200, 5345, 179, 0)

	spawnMobile("endor", "endor_stormtrooper", 3600, -3319, 200, 5360, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3324, 200, 5360, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3329, 200, 5360, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3334, 200, 5360, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3339, 200, 5360, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3344, 200, 5360, 179, 0)
--[[
	spawnMobile("endor", "endor_stormtrooper", 3600, -3319, 200, 5375, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3324, 200, 5375, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3329, 200, 5375, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3334, 200, 5375, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3339, 200, 5375, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3344, 200, 5375, 179, 0)

	spawnMobile("endor", "endor_stormtrooper", 3600, -3319, 200, 5390, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3324, 200, 5390, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3329, 200, 5390, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3334, 200, 5390, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3339, 200, 5390, 179, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3344, 200, 5390, 179, 0)
--]]
	ObjectManager.withCreatureObject(pBoss3, function(oBoss)
		writeData("endorboss3", oBoss:getObjectID())			
		spatialChat(pBoss3, "My Brothers failed, I will not")	
		createObserver(DAMAGERECEIVED,"endor_pvp_event","boss_damage", pBoss3)
		createObserver(OBJECTDESTRUCTION, "endor_pvp_event", "notifyBoss3Dead", pBoss3)
		createEvent(1800000, "endor_pvp_event", "despawnBoss3", pBoss3,"")		
	end)
	return 0
end

function endor_pvp_event:notifyBoss3Dead(pBoss3, pPlayer)
	writeData("endor_pvp_event:spawnState", 4)
	createEvent(8000, "endor_pvp_event", "spawnBoss4", pBoss4,"")
	return 0

end

function endor_pvp_event:despawnBoss3(pBoss3, pPlayer)
	forcePeace(pBoss3)
	spHelper.destroy(readData("endorboss3"),true)
	writeData("endor_pvp_event:spawnState", 0)
	createEvent(6000, "endor_pvp_event", "despawnAdd", pAdd,"")
	return 0
end



function endor_pvp_event:spawnBoss4(pBoss4, pPlayer)
        local pBoss4 = spawnMobile("endor", "endor_b4", 0, -3332, 200, 5030, 1, 0) print("Startup Endor PvP encounter")
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5010, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5015, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5020, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5025, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5030, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5035, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5040, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5045, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5050, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3350, 200, 5055, 90, 0)

	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5010, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5015, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5020, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5025, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5030, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5035, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5040, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5045, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5050, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3365, 200, 5055, 90, 0)

	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5010, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5015, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5020, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5025, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5030, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5035, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5040, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5045, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5050, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3380, 200, 5055, 90, 0)

--[[	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5010, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5015, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5020, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5025, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5030, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5035, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5040, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5045, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5050, 90, 0)
	spawnMobile("endor", "endor_rebtrooper", 3600, -3395, 200, 5055, 90, 0)
]]
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5010, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5015, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5020, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5025, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5030, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5035, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5040, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5045, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5050, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3315, 200, 5055, -90, 0)

	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5010, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5015, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5020, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5025, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5030, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5035, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5040, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5045, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5050, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3300, 200, 5055, -90, 0)

	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5010, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5015, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5020, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5025, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5030, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5035, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5040, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5045, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5050, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3285, 200, 5055, -90, 0)

--[[	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5010, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5015, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5020, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5025, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5030, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5035, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5040, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5045, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5050, -90, 0)
	spawnMobile("endor", "endor_stormtrooper", 3600, -3270, 200, 5055, -90, 0)
]]
	ObjectManager.withCreatureObject(pBoss4, function(oBoss)
		writeData("endorboss4", oBoss:getObjectID())			
		spatialChat(pBoss4, "This is it! Who will lay claim to Endor's lost city? My money is on Mandalore!")	
		createObserver(OBJECTDESTRUCTION, "endor_pvp_event", "notifyBoss4Dead", pBoss4)
		createEvent(1800000, "endor_pvp_event", "despawnBoss4", pBoss4,"")		
	end)
	return 0
end

function endor_pvp_event:notifyBoss4Dead(pBoss4, pPlayer)
	spHelper.destroy(readData("warden"),true)
	createEvent(60000, "endor_pvp_event", "despawnAdd", pAdd,"")
	writeData("endor_pvp_event:spawnState", 0)
--	createEvent(120000, "endor_pvp_event", "removeFromLair", pPlayer, "")


	return 0
end

function endor_pvp_event:despawnBoss4(pBoss4, pPlayer)
	forcePeace(pBoss4)
	spHelper.destroy(readData("endorboss4"),true)
	writeData("endor_pvp_event:spawnState", 0)
	createEvent(6000, "endor_pvp_event", "despawnAdd", pAdd,"")
	return 0
end
 
function endor_pvp_event:despawnAdd(pAdd, pAddTwo, pAddThree, player)
	forcePeace(pAdd)
	forcePeace(pAddTwo)
	forcePeace(pAddThree)
	spHelper.destroy(readData("countadd"),true)
	spHelper.destroy(readData("countadd2"),true)
	spHelper.destroy(readData("countadd3"),true)


	return 0
end

function endor_pvp_event:boss_damage(pBoss3, pPlayer)

	local player = LuaCreatureObject(pPlayer)
	local boss = LuaCreatureObject(pBoss3)
	if (boss ~= nil) then
		local bossHealth = boss:getHAM(0)
		local bossAction = boss:getHAM(3)
		local bossMind = boss:getHAM(6)
		local bossMaxHealth = boss:getMaxHAM(0)
		local bossMaxAction = boss:getMaxHAM(3)
		local bossMaxMind = boss:getMaxHAM(6)

		local x1 = -80.6
		local y1 = 29.0
		local x2 = boss:getPositionX()
		local y2 = boss:getPositionY() 

		local distance = ((x2 - x1)*(x2 - x1)) + ((y2 - y1)*(y2 - y1))
		local maxDistance = 175
		
		if distance > (maxDistance * maxDistance) then
			spatialChat(pBoss, "There is no place to run")
			forcePeace(pBoss)
			forcePeace(pBoss)
			forcePeace(pBoss)			
		end

		if (((bossHealth <= (bossMaxHealth *0.5)) or (bossAction <= (bossMaxAction * 0.5)) or (bossMind <= (bossMaxMind *0.5))) and readData("endor_pvp_event:spawnState") == 2) then
			spatialChat(pBoss3, "My minions will purify you")
			writeData("endor_pvp_event:spawnState",3)
			local pAdd = spawnMobile("endor", "death_watch_battle_droid", 0, -3317, 200, 5330, 180, 0)
			ObjectManager.withCreatureObject(pAdd, function(firstTime)
			writeData("countadd", firstTime:getObjectID())
				firstTime:engageCombat(pPlayer)
			end)
			spatialChat(pAdd, "Your souls will be consumed")
	
			local pAddTwo = spawnMobile("endor", "death_watch_mine_rat", 0, -3353, 200, 5330, 180, 0)
			ObjectManager.withCreatureObject(pAddTwo, function(secondTime)
			writeData("countadd2", secondTime:getObjectID())
				secondTime:engageCombat(pPlayer)
			end)
			spatialChat(pAddTwo, "this one is almost mine")
		
			local pAddThree = spawnMobile("endor", "death_watch_mine_rat", 0, -3337, 200, 5349, 180, 0)
			ObjectManager.withCreatureObject(pAddThree, function(thirdTime)
			writeData("countadd3", thirdTime:getObjectID())
				thirdTime:engageCombat(pPlayer)
			end)				
			spatialChat(pAddThree, "gurp gurp gurp")
		
		end	
	
	end
	return 0
end
--[[
function endor_pvp_event:removeFromLair(pPlayer)
	if (pPlayer == nil) then
		return 0
	end

	local playerID = SceneObject(pPlayer):getObjectID()

	if (CreatureObject(pPlayer):isGrouped()) then
		local groupSize = CreatureObject(pPlayer):getGroupSize()

		for i = 0, groupSize - 1, 1 do
			local pMember = CreatureObject(pPlayer):getGroupMember(i)
			if pMember ~= nil then
				if CreatureObject(pMember):getParentID() > 1 then
					createEvent(5000, "endor_pvp_event", "teleportPlayer", pMember, "")
				end
			end
		end
	else
		createEvent(5000, "endor_pvp_event", "teleportPlayer", pPlayer, "")
	end
	return 0
end

function endor_pvp_event:teleportPlayer(pPlayer)
	if (pPlayer == nil) then
		return 0
	end

	local creatureID = SceneObject(pPlayer):getObjectID()
	local parentID = SceneObject(pPlayer):getParentID()
	if (readData(creatureID .. ":teleportedFromLair") == 1) then
		return 0
	end

	writeData(creatureID .. ":teleportedFromLair", 1)
	CreatureObject(pPlayer):teleport(-3959.0, 124.0, -55.0, 0)
	return 0
end
]]
function endor_pvp_event:resetScreenplayStatus(pPlayer)
	writeData("endor_pvp_event:spawnState", 1)
	return 0	
end




