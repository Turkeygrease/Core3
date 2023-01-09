--[[ By: Michael Simnitt aka Mindsoft
Date: dec/9/2018
Description: Screenplay Template
Distribution: This file and it's Contents were made for SWG Warfront, Permissions are currently limited to this server alone, any reproduction, use, or distribution without written consent from Michael Simnitt "the creator" is forbidden.
--]]


---------------------------------------------(First Declare a new Screenplay Object)
--*Note: make sure this name is unique or it will over-write existing screenplays with the same name or possibly be over-written by them
spName = ScreenPlay:new{
	--place constant screenplay data/methods here
}


---------------------------------------------(Second we must Register the Screenplay with the System)
--------------------------* this takes 2 arguments( Screenplays Unique Name , auto-start screenplay )
---------------------------* Note: if auto-start is true you must have a start function defined for the screenplay
registerScreenPlay("spName", false)


---------------------------------------------((optional) Declare auto-start function)
--------------------------* if auto-start is true this function will run when the screenplay handler starts
function spName:start()
	-------------place intializing logic here

	-------------example:
	self:spawnMobiles()
	self:spawnSceneObjects()
		--Note: -self- pointer can be used to refer to the called screenplay pointer we could have also used spName:spawnMobiles()
end

---------------------------------------------((optional) Custom Events)
--------------------------* place any custom methods/functions in this area

function spName:spawnMobiles() --common method used for spawning intitial mobiles
end

function spName:spawnSceneObjects() --common method used for spawning intial scen objects
end

--End note: Remember that each function is a method of your screenplay and MUST-BE prefaced with it's pointer, ie: spName:functionName()
