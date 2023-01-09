wf_new_years_event = ScreenPlay:new{
	mainEventLength = 120,
	mainEventCount = 360,
	finaleLength = 30,
	finaleCount = 200,
	launchRadius = 200,

			-- (x, z, y)
	["tatooine"] = {3529,5, -4800}, --Mos Eisley
	["naboo"] = {-4930, 6, 4081}, --Theed
	["corellia"] = {-200, 28, -4732}, --Coronet
}
registerScreenPlay("wf_new_years_event", true)

function wf_new_years_event:start()
	--local time = os.time{year=2018, month=12, day=27, hour=22, min= 33, sec= 55} - os.time()
	local time = os.time{year=2018, month=12, day=31, hour=9, min= 59, sec= 54} - os.time()
	if (time < 1) then
		print("\nTime for New-Years event has past expired (not scheduling)")
		return
	end
	print("\nWarfront New Years Event Screenplay Scheduled:")
	print("Time Until Event Fires",VillageGmSui:getTimeString(time*1000),"\n")
	createEvent(time * 1000, "wf_new_years_event", "startShow", "", 1)
end

function wf_new_years_event:startShow(empty, count)
	print("\nNew-Year-Event Status, Hours Remaining", 25-count, " \n")
	self:startNavFireworks(WFnav:getNav("tatooine"))
	self:startNavFireworks(WFnav:getNav("naboo"))
	self:startNavFireworks(WFnav:getNav("corellia"))
	if (tonumber(count) > 25) then
		return
	end
	createEvent(3600000, "wf_new_years_event", "startShow", "", count + 1)
end

function wf_new_years_event:startNavFireworks(pNav)
	local spawnPlanet = SceneObject(pNav):getZoneName()
	local navID = SceneObject(pNav):getObjectID()

	writeData(navID .. ":FireworkEvent:mainEventLength", self.mainEventLength)
	writeData(navID .. ":FireworkEvent:mainEventCount", self.mainEventCount)
	writeData(navID .. ":FireworkEvent:finaleLength", self.finaleLength)
	writeData(navID .. ":FireworkEvent:finaleCount", self.finaleCount)
	writeData(navID .. ":FireworkEvent:launchRadius", self.launchRadius)
	writeData(navID .. ":FireworkEvent:heading", math.random(360))
	writeData(navID .. ":FireworkEvent:spawnPointX", self[spawnPlanet][1])
	writeData(navID .. ":FireworkEvent:spawnPointZ", self[spawnPlanet][2])
	writeData(navID .. ":FireworkEvent:spawnPointY", self[spawnPlanet][3])
	
	writeStringData(navID .. ":FireworkEvent:spawnPlanet", spawnPlanet)
	FireworkEvent:startEvent(pNav)
end
