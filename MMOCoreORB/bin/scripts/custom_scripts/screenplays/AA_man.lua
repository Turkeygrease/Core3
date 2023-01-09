AA_man = ScreenPlay:new{}
registerScreenPlay("AA_man", true)

function AA_man:start()
	print("\n Altered Archive Manager: Started \n")

	-- ** Start Screenplays that must run first or in a specific order in the list below **
		--NOTE: make sure to set false in registration, ie: registerScreenPlay("spName", false)

	--WFnav must be loaded before other custom content, it creates needed planetary nav's
	WFnav:start()
end
