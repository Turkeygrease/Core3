-- By:Nexxus
--Description:Vendor for PvP Currency Xp

-- ??? TODO add required faction standing as a test???

---------------------------------------------(Screenplay & Spawns)
PvpCurrencyVendor_screenplay = ScreenPlay:new{}
registerScreenPlay("PvpCurrencyVendor_screenplay", true)

--Spawn Quest givers and triggers.
function PvpCurrencyVendor_screenplay:start()
end


----------------------------------------------(Vendor Handler)
PvpCurrencyVendor_convo_handler = conv_handler:new {
	["QuestString"] = "PvpCurrencyVendor_convo_handler",
	["CurrencyType"] = "Experience",
	["CurrencyData"] = "pvp_xp",
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
			"Galactic PvP Exchange",
			"Purchase Loot Boxes with PvP Currency",
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
--			{"Clothing Attachment Loot Box",500,"clothing_attachments"},
--			{"Armor Attachment Loot Box",500,"armor_attachments"},
			{"Janta Loot Box",1000,"vendor_hide"},
			{"Nightsister Loot Box",1000,"vendor_layer"},
		},
		--[[Tier 2]]{
--			{"Mandalorian Armor Schematic Loot Box",2000,"mando_loot"},
			{"Infiltrator Schematic (Imp) Loot Box",2000,"infiltrator_armor_loot"},
			{"Spec Force Armor Schematic (Reb) Loot Box",2000,"spec_force_armor_loot"},
		},
		--[[Tier 3]]{
			{"Warfront PvP BRONZE Loot Box",10000,"vendor_bronze_a"},
			{"Saber Schematic Loot Box",15000,"fifth_gen"},
			{"Ranged Weapon Schematic Loot Box",15000,"vendor_pvp_ranged_schem"},
			{"Melee Weapon Schematic Loot Box",15000,"vendor_pvp_melee_schem"},
			{"GCW REBEL Entertainer Buff Bronze Loot Box",20000,"pvpent_band_reb_t1"},
			{"GCW IMPERIAL Entertainer Buff Bronze Loot Box",20000,"pvpent_band_imp_t1"},
			{"GCW REBEL Medical Buff Bronze Loot Box",20000,"pvpbuff_band_reb_t1"},
			{"GCW IMPERIAL Medical Buff Bronze Loot Box",20000,"pvpbuff_band_imp_t1"},
		},
		--[[Tier 4]]{
			{"Warfront PvP SILVER Loot Box",25000,"vendor_silver_a"},
--			{"Ranged Weapon Component Loot Box",25000,"vendor_pvp_ranged_comps"},
--			{"Melee Weapon Component  Loot Box",25000,"vendor_pvp_melee_comps"},
--			{"Combat Medic Component  Loot Box",25000,"vendor_pvp_cm_comps"},
			{"Tier 4 Lightsaber Damage Crystal Loot Box",25000,"power_crystals"},
			{"GCW REBEL Entertainer Buff Silver Loot Box",30000,"pvpent_band_reb_t2"},
			{"GCW IMPERIAL Entertainer Buff Silver Loot Box",30000,"pvpent_band_imp_t2"},
			{"GCW REBEL Medical Buff Silver Loot Box",30000,"pvpbuff_band_reb_t2"},
			{"GCW IMPERIAL Medical Buff Silver Loot Box",30000,"pvpbuff_band_imp_t2"},
		},
		--[[Tier 5]]{
			{"Warfront PvP GOLD Loot Box",30000,"vendor_gold_a"},
--			{"Tier 5 Lightsaber Damage Crystal Loot Box",30000,"power_crystals"},
			{"GCW REBEL Entertainer Buff Gold Loot Box",40000,"pvpent_band_reb_t3"},
			{"GCW IMPERIAL Entertainer Buff Gold Loot Box",40000,"pvpent_band_imp_t3"},
			{"GCW REBEL Medical Buff Gold Loot Box",40000,"pvpbuff_band_reb_t3"},
			{"GCW IMPERIAL Medical Buff Gold Loot Box",40000,"pvpbuff_band_imp_t3"},
		},
	}
}
-----------------------------------------------(RUN SCREEN HANDLER)
function PvpCurrencyVendor_convo_handler:runScreenHandlers(conversationTemplate, conversingPlayer, conversingNPC, selectedOption, conversationScreen)
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

