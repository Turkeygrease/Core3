WFnav = ScreenPlay:new{
	spawnTable = { "dathomir", "endor", "tatooine", "corellia", "naboo", "rori", "yavin4", "lok", "dantooine", "talus", "dungeon1", "dungeon2", "arena_tatooine"},
}
registerScreenPlay("WFnav", false)--leave false, screenplay started by AA_man.lua

function WFnav:start()
	local i = 1
	repeat
		if (isZoneEnabled(WFnav.spawnTable[i])) then
			local pMob = spawnMobile(WFnav.spawnTable[i],"r2",1,-3 + math.random(600)*.01,0,-3 + math.random(600)*.01,1,0)
			TangibleObject(pMob):setInvisible(true)
			--print("-Creating WFnav:"..WFnav.spawnTable[i])
			writeData("WFnav:"..WFnav.spawnTable[i],SceneObject(pMob):getObjectID()) 
		end
		i = i + 1
	until i > #WFnav.spawnTable
end

--return Terrain Height @ params
function WFnav:getZ(planet,x,y)
	return getTerrainHeight(WFnav:getNav(planet), x, y)--Return terrain height
end

--return Nav Object from Planet String Name
function WFnav:getNav(planet)
	return getSceneObject(readData("WFnav:"..planet))--Return nav SceneObject
end

--return value +/- random range
function WFnav:rndRng(origValue, range)
	return (origValue - range + (math.random(range*200)*.01))
end
