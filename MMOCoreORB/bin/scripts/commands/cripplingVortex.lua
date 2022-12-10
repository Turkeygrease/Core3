CripplingVortexCommand = {
    name = "cripplingVortex",

  	damageMultiplier = 3.5,
	speedMultiplier = 3.0,
	healthCostMultiplier = 1.0,
	actionCostMultiplier = 1.0,
	mindCostMultiplier = 1.0,

	areaRange = 10,
 	areaAction = true,

	animation = "lower_posture_2hmelee_4",
	effectString = "clienteffect/entertainer_smoke_bomb_level_3",
	combatSpam = "cripplingVortex",

	stateEffects = {
		StateEffect( 
			BLIND_EFFECT, 
			{}, 
			{ "blind_defense" }, 
			{ "jedi_state_defense", "resistance_states" }, 
			100, 
			0, 
			10 
		),
		StateEffect( 
			STUN_EFFECT, 
			{}, 
			{ "stun_defense" }, 
			{ "jedi_state_defense", "resistance_states" }, 
			100, 
			0, 
			10 
		),
		StateEffect( 
			INTIMIDATE_EFFECT, 
			{}, 
			{ "intimidate_defense" }, 
			{ "jedi_state_defense", "resistance_states" }, 
			100, 
			0, 
			10 
		)
	},

	poolsToDamage = RANDOM_ATTRIBUTE,
	weaponType = MELEEWEAPON,
	--range = -1
}

AddCommand(CripplingVortexCommand)
