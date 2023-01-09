gcw_transit_decoScreenPlay = ScreenPlay:new {
	numberOfActs = 1,
	
	screenplayName = "gcw_transit_decoScreenPlay",
	
}

registerScreenPlay("gcw_transit_decoScreenPlay", true)

function gcw_transit_decoScreenPlay:start()
	if (isZoneEnabled("corellia") and isZoneEnabled("tatooine") and isZoneEnabled("naboo")) then 
		self:spawnParticles()		
--		self:spawnMobiles()
	end
end

function gcw_transit_decoScreenPlay:spawnParticles()

spawnSceneObject("corellia","object/tangible/gcw/flip_banner_onpole_imperial.iff", -156.9, 28.0, -4698.4, 0,math.rad(80))
spawnSceneObject("corellia","object/tangible/gcw/flip_banner_onpole_rebel.iff", -156.9, 28.0, -4704.8, 0,math.rad(80))
spawnSceneObject("naboo","object/tangible/gcw/flip_banner_onpole_imperial.iff", -4863.0, 6.0, 4115.1, 0,math.rad(157))
spawnSceneObject("naboo","object/tangible/gcw/flip_banner_onpole_rebel.iff", -4856.5, 6.0, 4115.9, 0,math.rad(148))

end

function gcw_transit_decoScreenPlay:spawnMobiles()

--spawnMobile


end

