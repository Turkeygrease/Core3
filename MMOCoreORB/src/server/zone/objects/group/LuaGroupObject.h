/*
 * LuaGroupObject.h
 *
 *  Created on: 1/31/2019
 *      Author: Mindsoft
 */

#ifndef LUAGROUPOBJECT_H_
#define LUAGROUPOBJECT_H_

#include "server/zone/objects/scene/LuaSceneObject.h"
#include "server/zone/objects/creature/CreatureObject.h"

namespace server {
namespace zone {
namespace objects {
namespace group {
	class GroupObject;

	class LuaGroupObject : public LuaSceneObject {
	public:
		// Constants
		static const char className[];
		static Luna<LuaGroupObject>::RegType Register[];

		// Initialize the pointer
		LuaGroupObject(lua_State *L);
		~LuaGroupObject();

		int _setObject(lua_State* L);
		// Methods we will need to use
		int getGroupLevel(lua_State *L);
		int getGroupSize(lua_State *L);
		int getNumberOfPlayerMembers(lua_State *L);
		int getGroupMember(lua_State *L);
		int getLeader(lua_State *L);
		int getGroupList(lua_State *L);
		int getPlayerList(lua_State *L);
		int getGroupLock(lua_State *L);
		int setGroupLock(lua_State *L);
		int hasMemberObject(lua_State *L);
		int hasMemberID(lua_State *L);
		int hasSquadLeader(lua_State *L);
		int isOtherMemberPlayingMusic(lua_State *L);
		int getBandSong(lua_State *L);
		int forceAddMember(lua_State *L);
		int forceRemoveMember(lua_State *L);
		int disband(lua_State *L);
		int makeLeader(lua_State *L);

	private:
		// The pointer to the 'real object' defined in object.cc
		GroupObject* realObject;
	};
}
}
}
}

using namespace server::zone::objects::group;

#endif /* LUAGROUPOBJECT_H_ */
