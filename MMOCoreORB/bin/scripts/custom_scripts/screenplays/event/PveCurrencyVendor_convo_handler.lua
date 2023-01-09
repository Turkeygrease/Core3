-- By:Nexxus
--Description:Vendor for PvE Currency Xp

-- ??? TODO add required faction standing as a test???

---------------------------------------------(Screenplay & Spawns)
PveCurrencyVendor_screenplay = ScreenPlay:new{}
registerScreenPlay("PveCurrencyVendor_screenplay", true)

--Spawn Quest givers and triggers.
function PveCurrencyVendor_screenplay:start()
end


----------------------------------------------(Vendor Handler)
PveCurrencyVendor_convo_handler = conv_handler:new {
	["QuestString"] = "PveCurrencyVendor_convo_handler",
	["CurrencyType"] = "Experience",
	["CurrencyData"] = "pve_xp",
	["lootType"] = 1,
 	["lootWeight"] = 500,


		--(faction, skill, screenplay, screenplay-state, raceID) 
	tests = {"0","0","0",-1,-1},

	groupTable = {
		"Tier 1", "Tier 2", "Tier 3", "Tier 4", "Tier 5", 
	},

	groupSuiTables = {
		--Group Select Screen title/prompt
		{
			"Galactic PvE Exchange",
			"Purchase Loot Boxes with PvE Currency",
		},

		--Group Sui Prompts
		{
			"Tier 1",
			"Tier 2",
			"Tier 3",
			"Tier 4",
			"Tier 5",
		},
	},

	itemsByGroup = {
			-- Name: , Price: , IFF:
		--[[Tier 1]]{
--			{"Clothing Attachment Loot Box",2000,"clothing_attachments"},
--			{"Armor Attachment Loot Box",2000,"armor_attachments"},
			{"Janta Loot Box",7000,"vendor_hide"},
			{"Nightsister Loot Box",7000,"vendor_layer"},
		},
		--[[Tier 2]]{
--			{"Mandalorian Armor Schematic Loot Box",10000,"mando_loot"},
			{"Infiltrator Schematic (Imp) Loot Box",10000,"infiltrator_armor_loot"},
			{"Spec Force Armor Schematic (Reb) Loot Box",10000,"spec_force_armor_loot"},
		},
		--[[Tier 3]]{
			{"Warfront PvE Bronze Loot Box",40000,"vendor_bronze_a"},
			{"PvE Entertainer Buff Bronze Loot Box",40000,"ent_band_t1"},
			{"PvE Medical Buff Bronze Loot Box",40000,"buff_band_t1"},
			{"Saber Schematic Loot Box",40000,"fifth_gen"},
			{"Ranged Weapon Schematic Loot Box",40000,"vendor_pvp_ranged_schem"},
			{"Melee Weapon Schematic Loot Box",40000,"vendor_pvp_melee_schem"},
		},
		--[[Tier 4]]{
			{"Warfront PvE Silver Loot Box",65000,"vendor_silver_a"},
			{"PvE Entertainer Buff Silver Loot Box",65000,"ent_band_t2"},
			{"PvE Medical Buff Silver Loot Box",65000,"buff_band_t2"},
--			{"Ranged Weapon Component Loot Box",65000,"vendor_pvp_ranged_comps"},
--			{"Melee Weapon Component  Loot Box",65000,"vendor_pvp_melee_comps"},
--			{"Combat Medic Component  Loot Box",65000,"vendor_pvp_cm_comps"},
			{"Tier 4 Lightsaber Damage Crystal Loot Box",65000,"power_crystals"},
		},
		--[[Tier 5]]{
			{"Warfront PvE Gold Loot Box",75000,"vendor_gold_b"},
--			{"Tier 5 Lightsaber Damage Crystal Loot Box",75000,"power_crystals"},
			{"PvE Entertainer Buff Gold Loot Box",85000,"ent_band_t3"},
			{"PvE Medical Buff Gold Loot Box",85000,"buff_band_t3"},
		},
	}
}
-----------------------------------------------(RUN SCREEN HANDLER)
function PveCurrencyVendor_convo_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
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

