--Copyright (C) 2010 <SWGEmu>


--This File is part of Core3.

--This program is free software; you can redistribute 
--it and/or modify it under the terms of the GNU Lesser 
--General Public License as published by the Free Software
--Foundation; either version 2 of the License, 
--or (at your option) any later version.

--This program is distributed in the hope that it will be useful, 
--but WITHOUT ANY WARRANTY; without even the implied warranty of 
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
--See the GNU Lesser General Public License for
--more details.

--You should have received a copy of the GNU Lesser General 
--Public License along with this program; if not, write to
--the Free Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA

--Linking Engine3 statically or dynamically with other modules 
--is making a combined work based on Engine3. 
--Thus, the terms and conditions of the GNU Lesser General Public License 
--cover the whole combination.

--In addition, as a special exception, the copyright holders of Engine3 
--give you permission to combine Engine3 program with free software 
--programs or libraries that are released under the GNU LGPL and with 
--code included in the standard release of Core3 under the GNU LGPL 
--license (or modified versions of such code, with unchanged license). 
--You may copy and distribute such a system following the terms of the 
--GNU LGPL for Engine3 and the licenses of the other code concerned, 
--provided that you include the source code of that other code when 
--and as the GNU LGPL requires distribution of source code.

--Note that people who make modified versions of Engine3 are not obligated 
--to grant this special exception for their modified versions; 
--it is their choice whether to do so. The GNU Lesser General Public License 
--gives permission to release a modified version without this exception; 
--this exception also makes it possible to release a modified version 


object_building_content_nova_orion_station_shared_chapter_8_space_station_decorated = object_building_content_nova_orion_station_shared_chapter_8_space_station_decorated:new {
	planetMapCategory = "cloningfacility",
	facilityType = CLONER_STANDARD,
	skillMods = {
		{"private_medical_rating", 130},
		{"private_safe_logout", 1},
		{"private_med_wound_mind", 20},
		{"private_buff_mind", 110},
		{"private_med_battle_fatigue", 5},
	},

	childObjects = {
		{templateFile = "object/tangible/terminal/terminal_insurance.iff", x = -9.6, z = .8, y = -55.8, ox = 0, oy = 0, oz = 0, ow = 1, cellid = 14, containmentType = -1},
		{templateFile = "object/tangible/terminal/terminal_elevator_up.iff", x = 38.8696, z = -0.992546, y = -1.55026, ow = 1, ox = 0, oz = 0, oy = 0, cellid = 27, containmentType = -1},
		{templateFile = "object/tangible/terminal/terminal_elevator_up.iff", x = 38.8696, z = -30.9922, y = -1.55026, ow = 1, ox = 0, oz = 0, oy = 0, cellid = 27, containmentType = -1}, 
		{templateFile = "object/tangible/terminal/terminal_elevator_down.iff", x = 39.068, z = -0.992546, y = -1.54586, ow = 1, ox = 0, oz = 0, oy = 0, cellid = 27, containmentType = -1}, 
		{templateFile = "object/tangible/terminal/terminal_elevator_down.iff", x = 39.068, z = 29.0075, y = -1.54586, ow = 1, ox = 0, oz = 0, oy = 0, cellid = 27, containmentType = -1}, 
			
	},
	spawningPoints = {
		{ x = -12.9, z = .6, y = -48.4, ow = 0.704268, ox = 0, oz = 0, oy = 0.709934, cellid = 14 },
		{ x = -16.3, z = .6, y = -50, ow = 0.704268, ox = 0, oz = 0, oy = 0.709934, cellid = 14 },
		{ x = -18.2, z = .6, y = -46.7, ow = 0.704268, ox = 0, oz = 0, oy = 0.709934, cellid = 14 },
		{ x = -15.5, z = .6, y = -47.7, ow = 0.704268, ox = 0, oz = 0, oy = 0.709934, cellid = 14 },
	},
	templateType = CLONINGBUILDING
}

ObjectTemplates:addTemplate(object_building_content_nova_orion_station_shared_chapter_8_space_station_decorated, "object/building/content/nova_orion_station/chapter_8_space_station_decorated.iff")
