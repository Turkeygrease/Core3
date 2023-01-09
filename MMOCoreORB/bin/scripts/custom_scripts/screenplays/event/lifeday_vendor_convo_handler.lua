-- By:Nexxus
--Description:Life Day Vendor

-- ??? TODO add required faction standing as a test???

---------------------------------------------(Screenplay & Spawns)
lifeday_vendor_screenplay = ScreenPlay:new{}
registerScreenPlay("lifeday_vendor_screenplay", true)

--Spawn Quest givers and triggers.
function lifeday_vendor_screenplay:start()
	spawnMobile("tatooine", "lifeday_vendor", 90, 3460.6, 5, -4803.2, 36, 0)
end


----------------------------------------------(Vendor Handler)
lifeday_vendor_convo_handler = conv_handler:new {
	["QuestString"] = "lifeday_vendor_convo_handler",
	["CurrencyType"] = "Experience",
	["CurrencyData"] = "holiday_xp",
	["lootType"] = 0,


		--(faction, skill, screenplay, screenplay-state, raceID)
	tests = {"0","0","0",-1,-1},

	groupTable = {
		"Holiday Paintings and Deco", "Reserved",
	},

	groupSuiTables = {
		--Group Select Screen title/prompt
		{
			"lifeday_vend",
			"Items",
		},

		--Group Sui Prompts
		{
			"Get Your Warfront Holiday Paintings and Decorations Here",
			"Reserved",
		},
	},

	itemsByGroup = {
			-- Name: , Price: , IFF:
		--[[Paintings]]{
			{"Warfront 2018 Contest Winner- Ile Couwas",1000,"object/tangible/item/entertainer_console/backdrop_comp_winner_2018.iff"},
			{"Painting Mos Eisley",1000,"object/tangible/item/entertainer_console/backdrop_eisley.iff"},
			{"Painting Dewback",1000,"object/tangible/item/entertainer_console/backdrop_dewback.iff"},
			{"Painting Theed",1000,"object/tangible/item/entertainer_console/backdrop_theed.iff"},
			{"Painting Tusken",1000,"object/tangible/item/entertainer_console/backdrop_tusken.iff"},
			{"Painting Coronet 1",1000,"object/tangible/item/entertainer_console/backdrop_cnet_s01.iff"},
			{"Painting Coronet 2",1000,"object/tangible/item/entertainer_console/backdrop_cnet_s02.iff"},
			{"Life Day Fireplace 1",1000,"object/tangible/storyteller/prop/pr_lifeday_fireplace_01.iff"},
			{"Life Day Fireplace 2",1000,"object/tangible/storyteller/prop/pr_lifeday_fireplace_02.iff"},
			{"Life Day Presents",1000,"object/tangible/storyteller/prop/pr_lifeday_presents.iff"},
--			{"Tauntaun Ride",1000,"object/mobile/tcg_tauntaun_ride.iff"},
--			{"Wampa Skin Rug",1000,"object/ngible/tcg/series3/decorative_wompa_skin_rug.iff"},
			{"Stuffed Wampa",1000,"object/tangible/tcg/series4/decorative_stuffed_wampa.iff"},
		},
		--[[Life Day Deco]]{
--			{"New Item 1",0,"object/.iff"},
		},
	}
}
-----------------------------------------------(RUN SCREEN HANDLER)
function lifeday_vendor_convo_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
	if (SWGTD_handler:validatePlayer(conversingPlayer, self.tests)==false) then	--TODO add clonescreens for return data from tests
		local conversation = LuaConversationTemplate( conversationTemplate )
		return conversation:getScreen("error")
	end
	writeStringData(SceneObject(conversingPlayer):getObjectID() .. ":SWGTD_purchase_QuestString",(self.QuestString))
	local quest = {
		["player"] = conversingPlayer,
		["target"] = conversingNPC,
		["purchase"] = function(...) SWGTD_handler:categoryChoice(...) end
	}
-- Generic Handler Call
	return SWGTD_handler:generic_runScreenHandlers( conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen, quest)
end
