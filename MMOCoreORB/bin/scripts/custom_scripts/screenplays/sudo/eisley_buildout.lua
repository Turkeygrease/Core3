eisleyBuildout = ScreenPlay:new{

        screenplayName = "eisleyBuildout",

	planet = "tatooine",

}


registerScreenPlay("eisleyBuildout", true)


function eisleyBuildout:start()

        self:spawnMobiles()
        self:spawnSceneObjects()

end



function eisleyBuildout:spawnMobiles()

        -- GCW trainers
        local pNpc = spawnMobile(self.planet, "trainer_gcwbh",300,-1.6,0.4,-9.5,139,1280131)
	self:setMoodString(pNpc, "npc_sitting_chair")
        pNpc = spawnMobile(self.planet, "trainer_gcwcommando",300,7.7,0.4,-9.5,-131,1280131)
	self:setMoodString(pNpc, "npc_sitting_chair")
        pNpc = spawnMobile(self.planet, "trainer_gcwbrawler",300,4.3,0.4,-4.5,-178,1280131)
	self:setMoodString(pNpc, "npc_sitting_chair")
        pNpc = spawnMobile(self.planet, "trainer_gcwmedic",300,4.4,0.4,-3.6,1,1280131)
	self:setMoodString(pNpc, "npc_sitting_chair")
        pNpc = spawnMobile(self.planet, "trainer_gcwsmuggler",300,1.3,0.4,-4.4,-178,1280131)
	self:setMoodString(pNpc, "npc_sitting_chair")
        pNpc = spawnMobile(self.planet, "trainer_gcwsl",300,1.4,0.4,-3.5,1,1280131)
	self:setMoodString(pNpc, "npc_sitting_chair")
        pNpc = spawnMobile(self.planet, "trainer_gcwranger",300,-6.2,0.4,-7.4,-3,1280131)
	self:setMoodString(pNpc, "npc_sitting_chair")

	-- Old man
	pNpc = spawnMobile(self.planet, "old_man_start",300,3399.2,5,-4850.0,-109,0)
        self:setMoodString(pNpc, "npc_sitting_chair")

        -- Trainers outside
        spawnMobile(self.planet, "trainer_artisan",0,3466,5,-4839.2,132,0)
        pNpc = spawnMobile(self.planet, "trainer_bountyhunter",0,3357.1,5,-4839.6,64,0)
        self:setMoodString(pNpc, "npc_sitting_chair")

        spawnMobile(self.planet, "trainer_brawler",0,3496.8,5,-4756.4,171,0)
        pNpc = spawnMobile(self.planet, "trainer_carbine",0,3538.3,5,-4692.7,218,0)
        self:setMoodString(pNpc, "npc_sitting_chair")

        spawnMobile(self.planet, "trainer_entertainer",0,3454.6,5,-4779.7,57,0)
        spawnMobile(self.planet, "trainer_marksman",0,3501,5,-4759.3,-104,0)
        spawnMobile(self.planet, "trainer_marksman",0,3552,5,-4710,215,0)
        spawnMobile(self.planet, "trainer_medic",0,3522,5,-4774,200,0)

        spawnMobile(self.planet, "trainer_musician",0,3397.8,5,-4796.5,-68,0)
        pNpc =  spawnMobile(self.planet, "trainer_pistol",0,3358.6,5,-4841.3,36,0)
        self:setMoodString(pNpc, "npc_sitting_chair")

        spawnMobile(self.planet, "trainer_rifleman",0,3426,5,-4917,0,0)

        spawnMobile(self.planet, "trainer_scout",0,3519.76,5,-4786.9,77,0)
        pNpc = spawnMobile(self.planet, "trainer_smuggler",0,3401,5,-4879,340,0)
        self:setMoodString(pNpc, "worried")

        -- Spynet operative
	spawnMobile(self.planet, "informant_npc_lvl_1",0,3492.1,5,-4780.5,-52,0)


	-- Vendors
	spawnMobile(self.planet, "pve_loot_vendor", -1, -2.4, 1, 10.2, -177, 1280132)
	spawnMobile(self.planet, "pvp_loot_vendor", -1, -5.2, 1, 10.2, -177, 1280132)


        -- Imperial fighters
        local pNpc = spawnMobile(self.planet, "stormtrooper",60,3430,5,-4908,-170,0)
        self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "stormtrooper",60,3424,5,-4906,-170,0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "stormtrooper",60,3421,5,-4904,-170,0)
	self:setMoodString(pNpc, "neutral")
	Npc = spawnMobile(self.planet, "stormtrooper",60,3419,5,-4901,-170,0)
	self:setMoodString(pNpc, "neutral")
	Npc = spawnMobile(self.planet, "stormtrooper",60,3517,5,-4851,-100,0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "stormtrooper",60,3516,5,-4862,-90,0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "stormtrooper",60,3516,5,-4867,-80,0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "stormtrooper",60,3510,5,-4868,-80,0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "stormtrooper",60,3502,5,-4899,120,0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "stormtrooper",60,3500,5,-4903,120,0)
	self:setMoodString(pNpc, "neutral")

       -- Reb fighters closest to starport
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3499, 5, -4840, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3492, 5, -4855, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3501, 5, -4866, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3510, 5, -4856, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3527, 5, -4849, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3528, 5, -4860, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3517, 5, -4871, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3506, 5, -4871, 10, 0)
	self:setMoodString(pNpc, "neutral")

	-- Reb fighters in front of shuttle port
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3496, 5, -4887, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3488, 5, -4893, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3490, 5, -4905, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3505, 5, -4888, 10, 0)
	self:setMoodString(pNpc, "neutral")

	-- Reb fighters to the right of the bank
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3438, 5, -4898, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3434, 5, -4895, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3429, 5, -4895, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3428, 5, -4885, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3407, 5, -4912, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3410, 5, -4919, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3416, 5, -4917, 10, 0)
	self:setMoodString(pNpc, "neutral")
	pNpc = spawnMobile(self.planet, "rebel_trooper", 60, 3422, 5, -4917, 10, 0)
	self:setMoodString(pNpc, "neutral")

	-- NPC's behind Starport
	spawnMobile(self.planet, "commoner_tatooine",60,3702.2,5,-4757.8,158.22,0)
	spawnMobile(self.planet, "junk_dealer", 0, 3706.4, 5, -4822.6, 92, 0)
	spawnMobile(self.planet, "businessman",60,3703.7,5,-4838.8,31.4813,0)

	-- Random droids
        pNpc = spawnMobile(self.planet, "r5",60,3489.4,5,-4832.5,44,0)
	self:setMoodString(pNpc, "calm")
	pNpc = spawnMobile(self.planet, "r4",60,3466.08,4,-4883.93,56.7343,0)
	self:setMoodString(pNpc, "calm")

--trainers Future add?? TODO Waypoints
       --[[ spawnMobile(self.planet, "trainer_tailor", 0, -148, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_chef", 0, -145, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_carbine", 0, -142, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_pistol", 0, -139, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_rifleman", 0, -136, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_1hsword", 0, -133, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_2hsword", 0, -130, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_polearm", 0, -127, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_smuggler", 0, -124, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_squadleader", 0, -121, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_unarmed", 0, -118, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_bountyhunter", 0, -115, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_artisan", 0, -112, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_armorsmith", 0, -108, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_weaponsmith", 0, -104, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_merchant", 0, -100, 40, 3292, 180, 0)
        spawnMobile(self.planet, "trainer_architect", 0, -94, 40, 3292, 180, 0)
--commerce trainers
        spawnMobile(self.planet, "trainer_politician", 0, 1524, 40, 546, 90, 0)
        spawnMobile(self.planet, "trainer_medic", 0, 1524, 40, 549, 90, 0)
        spawnMobile(self.planet, "trainer_doctor", 0, 1524, 40, 553, 90, 0)
        spawnMobile(self.planet, "trainer_combatmedic", 0, 1524, 40, 556, 90, 0)
--ENT trainers
        spawnMobile(self.planet, "trainer_entertainer", 0, 2256, 0, -4451, -90, 0)
        spawnMobile(self.planet, "trainer_dancer", 0, 2256, 0, -4453, -90, 0)
        spawnMobile(self.planet, "trainer_musician", 0, 2256, 0, -4456, -90, 0)
        spawnMobile(self.planet, "trainer_imagedesigner", 0, 2256, 0, -4459, -90, 0)
]]

end

function eisleyBuildout:spawnSceneObjects()

	-- Starship crafting station
	spawnSceneObject(self.planet, "object/tangible/crafting/station/public_space_station.iff", 3455.7, 5, -4822.9, 0, math.rad(125) )

        -- Contest winner (2018 custom content)
        -- spawnSceneObject(self.planet, "object/tangible/item/entertainer_console/backdrop_comp_winner_2018.iff", 3454, 6, -4798.4, 0, math.rad(128))

	-- City signage
	spawnSceneObject(self.planet, "object/static/worldbuilding/sign/star_port_sign_01_fixed.iff", 3541.2, 5, -4812.2, 0, 1, 0, 0, 0)
	spawnSceneObject(self.planet, "object/static/worldbuilding/sign/cantina_sign_eisley_01.iff", 3456.1, 5, -4791.8, 0, math.rad(171))
	spawnSceneObject(self.planet, "object/static/worldbuilding/sign/thm_sign_cloning.iff", 3243.23, 5, -4657.19, 0, 0.953717, 0, 0.300706, 0)
	spawnSceneObject(self.planet, "object/static/worldbuilding/sign/thm_sign_medcenter.iff", 3529.26, 5, -4776.71, 0, 0.887011, 0, -0.461749, 0)
	spawnSceneObject(self.planet, "object/static/worldbuilding/sign/thm_sign_bank.iff", 3468.3, 5, -4933.2, 0, 0.945518, 0, 0.325568, 0)
	spawnSceneObject(self.planet, "object/static/worldbuilding/sign/garage_sign_01.iff", 3536.6, 5, -4856.5, 0, math.rad(-130))
	spawnSceneObject(self.planet, "object/static/worldbuilding/sign/cantina_sign_eisley_01.iff", 3415.3, 5, -4874.4, 0, math.rad(-111))
  spawnSceneObject(self.planet, "object/static/worldbuilding/sign/shuttle_port_sign_01_fixed.iff", 3513.5, 5, -4889.2, 0, math.rad(-99))
	spawnSceneObject(self.planet, "object/static/worldbuilding/sign/war_room_sign_01.iff", 3493.9, 5, -4754.5, 0, 0.887011, 0, -0.461749, 0)

	-- Ships fighting over Eisley
        spawnSceneObject(self.planet,"object/static/space/ship/cargo_freighter.iff", 3485.5, 70.0, -4841.6, 0, 0, 0, 0, 0)
        spawnSceneObject(self.planet,"object/static/particle/particle_distant_ships_dogfight_tb_vs_bw_3.iff", 3485.5, 0.0, -4841.6, 0, 0, 0, 0, 0)
        spawnSceneObject(self.planet,"object/static/particle/particle_distant_ships_dogfight_t_vs_x_3.iff", 3523.7, 0.0, -4836.5, 0, 0, 0, 0, 0)
        spawnSceneObject(self.planet,"object/static/particle/particle_distant_ships_dogfight_ti_vs_aw_3.iff", 3504.1, 0.0, -4800, 0, 0, 0, 0, 0)
        spawnSceneObject(self.planet,"object/static/particle/particle_distant_ships_imperial.iff", 3457, 0.0, -4798, 0, 0, 0, 0, 0)
        spawnSceneObject(self.planet,"object/static/particle/particle_distant_ships_imperial.iff", 3462, 0.0, -4755, 0, 0, 0, 0, 0)
	spawnSceneObject(self.planet,"object/static/particle/particle_distant_ships_rebel.iff", 3450, 0.0, -4820, 0, 0, 0, 0, 0)

end
