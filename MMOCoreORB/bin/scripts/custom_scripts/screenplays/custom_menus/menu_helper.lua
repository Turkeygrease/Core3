menu_helper = {}

--Destroy list Objects using given delimiter
function menu_helper:destroyList(list, delim)
	if (list ~= "") then
		delim = delim or ","
		local tbl = HelperFuncs:splitString(list, delim)
		for k,v in ipairs(tbl) do
			Ihelp:destroy(getSceneObject(tonumber(v)))
		end
	end
end

--Destroy Data Memory saved on menu object
function menu_helper:cleanUpData(sob)
	if (sob == nil) then
		return 0
	end

	local sobID = SceneObject(sob):getObjectID()
	local list = readStringData(sobID.."memoryData")
	if (list ~= "") then
		deleteStringData(sobID.."memoryData")
		local tbl = HelperFuncs:splitString(list, ",")
		for k,v in ipairs(tbl) do
			print("destroying Memory Data: "..v)
			deleteData(sobID..v)
		end
	end
	return 0
end

--Destroy String Memory saved on menu object
function menu_helper:cleanUpStrings(sob)
	if (sob == nil) then
		return 0
	end

	local sobID = SceneObject(sob):getObjectID()
	local list = readStringData(sobID.."memoryStrings")
	if (list ~= "") then
		deleteStringData(sobID.."memoryStrings")
		local tbl = HelperFuncs:splitString(list, ",")
		for k,v in ipairs(tbl) do
			print("destroying Memory String: "..v)
			deleteStringData(sobID..v)
		end
	end
	return 0
end

--Destroy All Objects in Objects' listStrings
function menu_helper:cleanUpLists(pSob)
	if (pSob == nil) then
		return 0
	end

	local sobID = SceneObject(pSob):getObjectID()
	local list = readStringData(sobID.."listStrings")
	if (list ~= "") then
		local tbl = HelperFuncs:splitString(list, ",")
		for k,v in ipairs(tbl) do
			print("destroying List: "..v)
			local str = sobID..v
			local tbl = readStringData(str)
			deleteStringData(str)
			menu_helper:destroyList(tbl, ",")
		end
	end
	return 0
end

--Destroy Memory and Objects saved on menu object
function menu_helper:cleanUpMenuAll(pSob)
	print("cleaning up")
	menu_helper:cleanUpData(pSob)
	menu_helper:cleanUpStrings(pSob)
	--menu_helper:cleanUpDataObjects(pSob) TODO
	menu_helper:cleanUpLists(pSob)
	return 0
end

function menu_helper:validateUser(pPlayer)
	if (pPlayer == nil or not(SceneObject(pPlayer):isPlayerCreature())) then
		return false
	end

	local creo = CreatureObject(pPlayer)
	if not(creo:checkCooldownRecovery("effect_object_used")) then
		creo:sendSystemMessage("(You must wait before you can perform this action again.)")
		return false
	end

	creo:addCooldown("effect_object_used", 3000)

	if (CreatureObject(pPlayer):isInCombat() or CreatureObject(pPlayer):isIncapacitated() or CreatureObject(pPlayer):isDead()) then
		CreatureObject(pPlayer):sendSystemMessage("(You cannot use this in your current state)")
		return ralse 
	end
	return true
end

--Destroy object and memory @data(str)
function menu_helper:destroyDataObject(str)
	print("destroying object",str)
	local obID = readData(str)
	deleteData(str)
	print("ob Id: "..tostring(obID))
	if (obID ~= 0) then
		local pSob = getSceneObject(obID)
		if (pSob) then
			print("object destroyed",pSob)
			SceneObject(pSob):destroyObjectFromWorld()
			SceneObject(pSob):destroyObjectFromDatabase()
		end
	end
end
