WFtest = { --tests: isImp, isReb, isCovert, isOvert, isFaction, isCovertFaction

	alerts = {
		isOnLeave = "You Must be on leave to perfom this action",
		isNotOnLeave = "You Must Not be on-leave to perform this action",
		isImp = "You Must be Imperial to perform this action",
		isImpCovert = "You Must be Imperial and Covert to perform this action",
		isImpOvert = "You Must be Imperial and Overt to perform this action",
		isReb = "You Must be Rebel to perform this action",
		isRebCovert = "You Must be Rebel and Covert to perform this action",
		isRebOvert = "You Must be Rebel and Overt to perform this action",
		isOvert = "You Must be Overt to perform this action",
		isCovert = "You Must be Covert to perform this action",
		isFaction = "You Must be Factioned to perform this action",
		isFactionReady ="You Must be Factioned and NOT on-leave to perform this action",
		isCovertFaction = "You Must be Covert & Factioned to perform this action",
		isOvertFaction = "You Must be Overt & Factioned to perform this action",
	},
}

--returns true if on leave
function WFtest.isOnleave(pPlayer)
	return CreatureObject(pPlayer):isOnLeave()
end

--returns true if not on leave
function WFtest.isNotOnleave(pPlayer)
	return not(CreatureObject(pPlayer):isOnLeave())
end

--returns true if Imperial
function WFtest.isImp(pPlayer)
	return CreatureObject(pPlayer):isImperial()
end

--returns true if Imperial Covert
function WFtest.isImp(pPlayer)
	return (CreatureObject(pPlayer):isImperial() and CreatureObject(pPlayer):isCovert())
end

--returns true if Imperial Overt
function WFtest.isImp(pPlayer)
	return (CreatureObject(pPlayer):isImperial() and CreatureObject(pPlayer):isOvert())
end

--returns true if Rebel
function WFtest.isReb(pPlayer)
	return CreatureObject(pPlayer):isRebel()
end

--returns true if Rebel Covert
function WFtest.isRebCovert(pPlayer)
	return (CreatureObject(pPlayer):isRebel() and CreatureObject(pPlayer):isCovert())
end

--returns true if Rebel Overt
function WFtest.isRebOvert(pPlayer)
	return (CreatureObject(pPlayer):isRebel() and CreatureObject(pPlayer):isOvert())
end

--returns true if Overt
function WFtest.isOvert(pPlayer)
	return CreatureObject(pPlayer):isOvert()
end

--returns true if Covert
function WFtest.isCovert(pPlayer)
	return CreatureObject(pPlayer):isCovert()
end

--returns true if (covert or overt) and (imperial or rebel)
function WFtest.isFactionReady(pPlayer)
	return (WFtest:isNotOnleave(pPlayer) and WFtest:isFaction(pPlayer))
end

--returns true if Rebel or Imperial
function WFtest.isFaction(pPlayer)
	return (CreatureObject(pPlayer):isImperial() or CreatureObject(pPlayer):isRebel())
end

--returns true if Rebel or Imperial and Covert
function WFtest.isCovertFaction(pPlayer)
	return ((CreatureObject(pPlayer):isCovert()) and (CreatureObject(pPlayer):isImperial() or CreatureObject(pPlayer):isRebel()))
end

--returns true if Rebel or Imperial and Covert
function WFtest.isOvertFaction(pPlayer)
	return ((CreatureObject(pPlayer):isOvert()) and (CreatureObject(pPlayer):isImperial() or CreatureObject(pPlayer):isRebel()))
end

--@data = table, or stringTable   @boolAlert = bool alert player on fail
function WFtest:testAll(pPlayer, data, boolAlert)
	--print("testAll- pPlayer: "..tostring(pPlayer).." , data: "..tostring(data).." , boolAlert: "..tostring(boolAlert))
	if ((data == nil)or(pPlayer == nil)) then return false end
	if not(SceneObject(pPlayer):isPlayerCreature()) then return false end
	if (type(data) == "string") then --check for test string table and convert to table
		data = HelperFuncs:splitString(data, "/") --Split WP-table from string
	end
	local test = true
	if (type(data) == "table") then --if valid test table
		local i = 0
		while (test and (i< #data)) do
			i = i + 1
			local testString = data[i]
			--print("Wftest- Testing teststring: "..tostring(testString))
			if not(WFtest[testString](pPlayer)) then
				--print("test failed")
				if (boolAlert) then --alert player they failed
					local msg = WFtest.alerts[testString] or "(Requirements NOT met)"
					CreatureObject(pPlayer):sendSystemMessage(msg)
				end
				test = false
				--print(tostring(testString)..": "..tostring(test))
			end
		end
	else
		return false
	end
	--print("returning: "..tostring(test))
	return test
end
