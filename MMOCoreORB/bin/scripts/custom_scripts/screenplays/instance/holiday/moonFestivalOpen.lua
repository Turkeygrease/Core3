moonFestivalOpen = ScreenPlay:new {
	instance = "moonFestivalOpen",
	staticMobiles = {			-- t	   x    z     y     f   c
		{"undead_trooper_m/undead_trooper_f",	 0.2, -12, 25.7,  136,  5}, --undead
		{"undead_trooper_m/undead_trooper_f",    6.1, -12, 25.9, -147,  5}, --undead
		{"undead_trooper_m/undead_trooper_f",	 3.1, -12, 40.9,   13,  5}, --undead
		{"undead_trooper_m/undead_trooper_f",    4.2, -12, 40.9,  -16,  5}, --undead
		{"undead_trooper_m/undead_trooper_f",    -12, -12, 46.6,   81,  5}, --undead
		{"undead_trooper_elite",		 5.9, -12, 68.2,   27,  5}, --undead hard
		{"undead_trooper_m/undead_trooper_f",	 6.6, -12,   53,  173,  5}, --undead
		{"undead_trooper_m/undead_trooper_f",	 0.3, -12, 53.3, -171,  5}, --undead
		{"undead_scout_trooper_m",		19.4, -12, 51.7,  173,  5}, --undead med
		{"undead_trooper_m/undead_trooper_f",	25.8, -12, 50.5, -122,  5}, --undead
		{"undead_trooper_m/undead_trooper_f",	24.1, -12, 44.2,   63,  5}, --undead
		{"undead_scout_trooper_m",	       -24.4, -12, 46.9,   90,  6}, --undead med
		{"undead_trooper_m/undead_trooper_f",  -44.8, -20, 48.3,   98,  6}, --undead
		{"undead_trooper_m/undead_trooper_f",  -44.8, -20, 45.8,   74,  6}, --undead
		{"event_cavern_spider",		       -58.6, -20, 48.4,   98,  7}, --spider1
		{"event_cavern_spider",		       -55.7, -20, 31.3,   13,  7}, --spider1
		{"event_cavern_spider",		       -70.9, -20, 40.1,  -72,  7}, --spider1
		{"event_cavern_spider",		       -73.3, -20,   63,   92,  7}, --spider1
		{"event_cavern_spider",		       -53.9, -20,   63, -168,  7}, --spider1
		{"event_cavern_spider",		       -66.8, -20, 59.8,  133,  7}, --spider1
		{"event_cavern_spider",		       -68.9, -20, 28.7,   28,  7}, --spider1
		{"event_cavern_spider",			 -48, -20, 81.4, -112,  9}, --spider1
		{"event_cavern_spider",			 -55, -20, 74.8,   52,  9}, --spider1
		{"event_cavern_spider",			 -65, -20, 74.5,  -29,  9}, --spider1
		{"event_cavern_spider",			 -70, -20,   88, -164,  9}, --spider1
		{"event_cavern_spider",		       -54.8, -20,   88, -136,  9}, --spider1
		{"undead_scout_trooper_m",		22.9, -12, 35.5,  132, 10}, --undead
		{"undead_trooper_m/undead_trooper_f",     35, -12,   37,   13, 10}, --undead
		{"undead_scout_trooper_m",		  40, -12, 57.9,  150, 10}, --undead
		{"undead_scout_trooper_m",		  40, -12, 81.7, -166, 10}, --undead
		{"undead_trooper_m/undead_trooper_f",   23.7, -12, 12.6,   94, 14}, --undead
		{"undead_trooper_m/undead_trooper_f",   17.9, -12, 25.1,  102, 14}, --undead
		{"undead_trooper_m/undead_trooper_f",   18.8, -12, 15.5,   84, 14}, --undead
		{"undead_trooper_m/undead_trooper_f",   16.4, -12,    0,   91, 14}, --undead
		{"undead_trooper_m/undead_trooper_f",   37.1, -12,  8.2, -128, 14}, --undead
		{"undead_trooper_m/undead_trooper_f",   38.9, -12, 23.8,   95, 14}, --undead
		{"undead_scout_trooper_m",		57.1, -12,   .5,  -85, 14}, --undead
		{"undead_scout_trooper_m",		58.1, -12, 21.2, -167, 14}, --undead
		{"undead_scout_trooper_m",		12.6, -12,  2.8,   88, 15}, --undead
		{"undead_trooper_m/undead_trooper_f",  -22.7, -20, -3.0,  169, 16}, --undead
		{"undead_trooper_m/undead_trooper_f",  -21.3, -20, -1.7,   -2, 16}, --undead
		{"undead_trooper_m/undead_trooper_f",  -13.0, -20, -2.9,  172, 16}, --undead
		{"undead_trooper_m/undead_trooper_f",  -10.0, -20, -2.7,   89, 16}, --undead
		{"undead_trooper_m/undead_trooper_f",	-9.9, -20,  8.5, -110, 16}, --undead
		{"undead_trooper_m/undead_trooper_f",  -13.9, -20,  7.8,  171, 16}, --undead
		{"undead_trooper_m/undead_trooper_f",  -19.7, -20,  9.1,    2, 16}, --undead
		{"undead_scout_trooper_m",	       -23.2, -20,  8.9,  -98, 16}, --undead
		{"undead_scout_trooper_m",	       -19.6, -20, -3.3,  176, 16}, --undead
		{"undead_trooper_elite",	       -15.7, -20,  2.6,  -79, 16}, --undead
		{"undead_trooper_elite",		69.4, -12, 59.7,  -15, 12}, --undead
		{"undead_scout_trooper_m",		69.0, -12, 57.9,  174, 12}, --undead
		{"undead_trooper_m/undead_trooper_f",	60.7, -12, 59.6,   32, 12}, --undead
		{"undead_trooper_m/undead_trooper_f",	53.1, -12, 57.7, -170, 12}, --undead
		{"undead_trooper_m/undead_trooper_f",	46.8, -12, 59.7,   -5, 12}, --undead
		{"undead_trooper_m/undead_trooper_f",	44.6, -12, 53.1,    1, 12}, --undead
		{"undead_trooper_m/undead_trooper_f",	50.1, -12, 84.7,   -9, 11}, --undead
		{"undead_trooper_m/undead_trooper_f",	50.9, -12, 81.2,  178, 11}, --undead
		{"undead_trooper_m/undead_trooper_f",	57.7, -12, 81.2,  175, 11}, --undead
		{"undead_trooper_m/undead_trooper_f",	67.3, -12, 84.7,  -17, 11}, --undead
		{"undead_scout_trooper_m",		73.7, -12, 81.2, -176, 11}, --undead
		{"undead_trooper_elite",		71.6, -12, 84.7,    8, 11}, --undead
		{"undead_scout_trooper_m",		21.9, -20,120.0,  -30, 13}, --undead
		{"undead_trooper_m/undead_trooper_f",	13.5, -20,127.3,   56, 13}, --undead
		{"undead_scout_trooper_m",		18.3, -20,145.9,   42, 13}, --undead
		{"undead_trooper_m/undead_trooper_f",	38.7, -20,121.8,   92, 13}, --undead
		{"undead_trooper_m/undead_trooper_f",	38.2, -20,127.6,  122, 13}, --undead
		{"undead_trooper_m/undead_trooper_f",	41.7, -20,133.4,   73, 13}, --undead
		{"undead_trooper_elite",		36.4, -20,145.9,  -10, 13}, --undead
		{"undead_trooper_m/undead_trooper_f",	32.8, -20,125.4,   38, 13}, --undead
		{"undead_scout_trooper_m",		26.7, -20,131.9,  -40, 13}, --undead
		{"undead_trooper_m/undead_trooper_f",  -31.1, -20, 71.8,   41, 18}, --undead
		{"undead_trooper_m/undead_trooper_f",	 -30, -20, 22.4, -118, 18}, --undead
		{"undead_trooper_m/undead_trooper_f",  -35.2, -20, 95.4,  113, 19}, --undead
		{"undead_trooper_m/undead_trooper_f",  -22.8, -20, 94.5,    3, 19}, --undead
		{"undead_trooper_m/undead_trooper_f",    -17, -20,112.9, -171, 19}, --undead
		{"undead_scout_trooper_m",	       -16.4, -20,103.9,  148, 19}, --undead
		{"undead_scout_trooper_m",	       -14.7, -20, 84.5,   37, 20}, --undead
		{"undead_scout_trooper_m",		-3.8, -20, 73.3,   13, 21}, --undead
		{"undead_scout_trooper_m",		-2.1, -20, 67.9,   42, 21}, --undead
		{"undead_trooper_m/undead_trooper_f",	-7.5, -20, 76.6,   99, 21}, --undead
		{"undead_trooper_m/undead_trooper_f",	 7.9, -20, 70.8,  130, 22}, --undead


	},
--boss and add tables
	Outbreak_Containment_Officer = {    --t      x    z   y    f  c  rspwn dspwn --Note: timers are in seconds
		spawn = {"event_scientist_boss", -55.3, -20, 13, -95, 8, 1800, 1800},
					--t      x    z     y   f  c 
		trigger = {"event_scientist", -75.2, -20, 12.9, 89, 8},
		intro = "What are you doing here? This area has been quarentined!",
		phases = {
			[1] = {
				damageLimit = 0.8, --%value of max H,A,M
				taunt = "Do not the let infection Spread!",
				spawns = {		--t	x    z      y     f  c
					{"event_scientist", -58.9, -20,  17.9, -160, 8},
					{"event_scientist", -51.7, -20,   7.7, 	-63, 8},
					{"droideka", -70.6, -20,   5.7,   12, 8},
					spawnTaunts = {"Sterilizing area..", "Careful not to touch them!", "You sure this is safe?"},
				},
			},
			[2] = {
				damageLimit = 0.5, --%value of max H,A,M
				taunt = "Quickly they must not escape!",
				spawns = {	   --t	    x     z      y    f  c
					{"event_scientist",	-77.3,  -20,  10.6,  84, 8},
					{"event_scientist", -77.4,  -20,  15.6,  86, 8},
					{"event_scientist", -61.9,  -20,    18,-167, 8},
					{"droideka",   -59,  -20,   8.5, -38, 8},
					spawnTaunts = {"Kill them!", "Take cover!", "I give you mercy.."},
				},
			},
			[4] = {
				damageLimit = 0.1, --%value of max H,A,M
				taunt = "This cannot be, if the virus escapes we are all doomed!",
				spawns = {		--t     x    z     y     f  c
					{"event_scientist", -54.5, -20, 20.2, -179, 8},
					{"event_scientist", -54.3, -20,    5,    0, 8},
					{"droideka", 	    -74.2, -20,  8.9,   55, 8},
					{"droideka", 	    -74.2, -20, 17.7,  102, 8},
					spawnTaunts = {"Don't let them touch you!", "Securing the Bio-Hazard."},
				},
			},
		},
	},
	Mutant_Spider_Queen = {		 --t    x    z     y     f  c  rspwn dspwn --Note: timers are in seconds
		spawn = {"event_spider_boss", -75, -20,   82,  155, 9, 1800, 1800},
					--t   x    z     y     f  c 
		trigger = {"gmf_broodling", -75, -20,   82,  155, 9},
		intro = "(Hissing) My young will devour our flesh!",
		phases = {
			[1] = {
				damageLimit = 0.75, --%value of max H,A,M
				taunt = "Slumber in my web!",
				spawns = {	     --t      x    z      y     f  c
					{"gmf_broodling", -74.5, -20,  75.3,   98, 9},
					{"gmf_broodling", -74.5, -20,    86,  142, 9},
					{"gmf_broodling", -71.6, -20,    81, -142, 9},
				},
			},
			[2] = {
				damageLimit = 0.5, --%value of max H,A,M
				taunt = "My young MUST have nourishment..",
				spawns = {	   --t	    x    z     y    f  c
					{"gmf_broodling", -58, -20, 74.5,  84, 9},
					{"gmf_broodling", -68, -20, 74.5,  86, 9},
					{"gmf_broodling", -59, -20,   87, 162, 9},
					{"gmf_broodling", -68, -20,   87, 162, 9},
				},
			},
			[4] = {
				damageLimit = 0.2, --%value of max H,A,M
				taunt = "Protect me my children!",
				spawns = {	    --t       x    z     y     f  c
					{"gmf_broodling",   -58, -20, 74.5,   84, 9},
					{"gmf_broodling",   -68, -20, 74.5,   86, 9},
					{"gmf_broodling",   -59, -20,	87,  162, 9},
					{"gmf_broodling",   -68, -20,	87,  162, 9},
					{"gmf_broodling", -74.5, -20, 75.3,   98, 9},
					{"gmf_broodling", -74.5, -20,   86,  142, 9},
					{"gmf_broodling", -71.6, -20,   81, -142, 9},
				},
			},
		},
	},
	Undead_Mutant_Rancor = {    --t    x    z     y     f   c  rspwn dspwn --Note: timers are in seconds
		spawn = {"undead_rancor", 57, -12, 10.8,  -94, 14, 1800, 1800},
					      --t   x    z     y     f   c 
		trigger = {"undead_trooper_elite", 57, -12, 10.8,  -94, 14}, --undead
		intro = "(Snarling)!",
		phases = {
			[1] = {
				damageLimit = 0.9, --%value of max H,A,M
				spawns = {	     --t	       x    z      y     f   c
					{"undead_trooper_m",	    48.5, -12,     0,   12, 14},
					{"undead_trooper_f",	    60.7, -12,   1.4,  -43, 14},
					{"undead_scout_trooper_m",  51.9, -12,  21.7,  171, 14},
					{"undead_trooper_f",	    25.5, -12,   2.6,   79, 14},
				},
			},
			[2] = {
				damageLimit = 0.6, --%value of max H,A,M
				spawns = {	   --t		       x    z     y     f   c
					{"undead_trooper_f", 	    33.9, -12, 19.3,  109, 14},
					{"undead_trooper_elite",      41, -12, 11.1,   96, 14},
					{"undead_trooper_m",        49.2, -12,  6.8,   11, 14},
					{"undead_scout_trooper_m",  61.2, -12, 21.6, -159, 14},
				},
			},
			[4] = {
				damageLimit = 0.3, --%value of max H,A,M
				spawns = {	    --t		        x    z     y     f   c
					{"undead_trooper_f",	     24.1, -12, 24.7,  113, 14},
					{"undead_trooper_m",	     26.9, -12, 14.3,  102, 14},
					{"undead_trooper_elite",     25.7, -12,  4.5,   91, 14},
					{"undead_trooper_elite",     35.9, -12, -2.9,   57, 14},
					{"undead_trooper_m", 	     62.5, -12,  1.9,  -27, 14},
					{"undead_scout_trooper_m",   49.4, -12, 13.7,  126, 14},
					{"undead_trooper_f",	     49.2, -12,  8.4,    0, 14},
				},
			},
		},
	},
}
registerScreenPlay("moonFestivalOpen", false)

--------------------------------------
--   Initialize screenplay           -
--------------------------------------
function moonFestivalOpen:start(pBuilding)
	--spawn deco
	moonFestivalDeco:spawnDeco(pBuilding)
	--spawn static respawning mobiles
	Ihelp:spawnListWithRespawn(pBuilding, self.staticMobiles, 180, 600)--(bldg,list,respawnMin,respawnMax)
	--spawn named boss triggers
	Ihelp:spawnNamedBossTrigger(pBuilding, "Outbreak_Containment_Officer")
	Ihelp:spawnNamedBossTrigger(pBuilding, "Mutant_Spider_Queen")
	Ihelp:spawnNamedBossTrigger(pBuilding, "Undead_Mutant_Rancor")
end
------------------------------DEATH EVENTS
--Trigger Death Event NOTE: function name must be in format ("notifyTrigger"..bossName.."Dead")
function moonFestivalOpen:notifyTriggerOutbreak_Containment_OfficerDead(pTrigger, pPlayer)
	Ihelp:notifyNamedBossTriggerDead(pTrigger, "Outbreak_Containment_Officer")
	return 0
end
function moonFestivalOpen:notifyTriggerMutant_Spider_QueenDead(pTrigger, pPlayer)
	Ihelp:notifyNamedBossTriggerDead(pTrigger, "Mutant_Spider_Queen")
	return 0
end
function moonFestivalOpen:notifyTriggerUndead_Mutant_RancorDead(pTrigger, pPlayer)
	Ihelp:notifyNamedBossTriggerDead(pTrigger, "Undead_Mutant_Rancor")
	return 0
end

