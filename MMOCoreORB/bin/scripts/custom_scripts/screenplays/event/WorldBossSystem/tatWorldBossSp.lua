--[[ By: Michael Simnitt aka Mindsoft
Date: 12/6/2018
Description: world boss screenplay adds and enviroment for tatooine world boss in mos espa 
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]

tatWorldBossSp = ScreenPlay:new{
	planet = "tatooine",
	spawns = {
		{"tusken_raider",-2918,5,2009},
		{"tusken_raider",-2905,5,2021},
		{"tusken_raider",-2938,5,2008},

		{"tusken_raider",-2906,5,1962},
		{"tusken_raider",-2880,5,1956},
		{"tusken_raider",-2900,5,1946},

		{"tusken_bantha",-2948,5,1971},
		{"bh_tusken_carnage_champion",-2954,5,1974.4},
		{"tusken_bantha",-2945,5,1985},

		{"tusken_bantha",-2961,5,1955},
		{"tusken_raider",-2988,5,1959},
		{"tusken_bantha",-2985,5,1948},

		{"tusken_bantha",-2995,5,1980},
		{"tusken_raider",-2982,5,1978},
		{"tusken_bantha",-2972,5,1990},
	},
}
registerScreenPlay("tatWorldBossSp", false)

function tatWorldBossSp:start()
	print("\n\ntatWorldBossSp has been started\n\n")
	self:spawnMobiles()
end

function tatWorldBossSp:spawnMobiles()
	i = 1
	repeat
		local sp = self.spawns[i]
		pMob = spawnMobile(self.planet,sp[1],0,sp[2],sp[3],sp[4],math.random(360),0)
		if (pMob ~= nil) then
			AiAgent(pMob):setAITemplate("")
			createEvent(3600000, "tatWorldBossSp", "despawnMobile", pMob, 5) --1hr despawns timer
		end
		i = i + 1
	until (i > #self.spawns)
end

function tatWorldBossSp:despawnMobile(pMob, count)
	if ((not SceneObject(pMob)) or CreatureObject(pMob):isDead()) then --return if invalid or dead
		return 0
	end

	local val = tonumber(count)-1
	if ((val > 0) and CreatureObject(pMob):isInCombat()) then --if cycles remain and is in combat cycle again
		createEvent(120000, "tatWorldBossSp", "despawnMobile", pMob, val)
		return 0
	end
	
	forcePeace(pMob)
	SceneObject(pMob):destroyObjectFromWorld()
	return 0
end
