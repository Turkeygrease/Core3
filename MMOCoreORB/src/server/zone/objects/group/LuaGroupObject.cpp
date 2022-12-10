/*
 * LuaGroupObject.cpp
 *
 *  Created on: 1/31/2019
 *      Author: Mindsoft
 */

#include "LuaGroupObject.h"
#include "server/zone/objects/group/GroupObject.h"

const char LuaGroupObject::className[] = "LuaGroupObject";

Luna<LuaGroupObject>::RegType LuaGroupObject::Register[] = {
		{ "_setObject", &LuaGroupObject::_setObject },
		{ "_getObject", &LuaSceneObject::_getObject },
		{ "getGroupLevel", &LuaGroupObject::getGroupLevel },
		{ "getGroupSize", &LuaGroupObject::getGroupSize },
		{ "getNumberOfPlayerMembers", &LuaGroupObject::getNumberOfPlayerMembers },
		{ "getGroupMember", &LuaGroupObject::getGroupMember },
		{ "getLeader", &LuaGroupObject::getLeader },
		{ "getGroupList", &LuaGroupObject::getGroupList },
		{ "getPlayerList", &LuaGroupObject::getPlayerList },
		{ "getGroupLock", &LuaGroupObject::getGroupLock },
		{ "setGroupLock", &LuaGroupObject::setGroupLock },
		{ "hasMemberObject", &LuaGroupObject::hasMemberObject },
		{ "hasMemberID", &LuaGroupObject::hasMemberID },
		{ "hasSquadLeader", &LuaGroupObject::hasSquadLeader },
		{ "isOtherMemberPlayingMusic", &LuaGroupObject::isOtherMemberPlayingMusic },
		{ "forceAddMember", &LuaGroupObject::forceAddMember },
		{ "forceRemoveMember", &LuaGroupObject::forceRemoveMember },
		{ "disband", &LuaGroupObject::disband },
		{ "makeLeader", &LuaGroupObject::makeLeader },
		{ 0, 0 }
};

LuaGroupObject::LuaGroupObject(lua_State *L) : LuaSceneObject(L) {
#ifdef DYNAMIC_CAST_LUAOBJECTS
	realObject = dynamic_cast<GroupObject*>(_getRealSceneObject());

	assert(!_getRealSceneObject() || realObject != nullptr);
#else
	realObject = static_cast<GroupObject*>(lua_touserdata(L, 1));
#endif
}

LuaGroupObject::~LuaGroupObject() {
}

int LuaGroupObject::_setObject(lua_State* L) {
	LuaSceneObject::_setObject(L);

#ifdef DYNAMIC_CAST_LUAOBJECTS
	realObject = dynamic_cast<GroupObject*>(_getRealSceneObject());

	assert(!_getRealSceneObject() || realObject != nullptr);
#else
	realObject = static_cast<GroupObject*>(lua_touserdata(L, -1));
#endif

	return 0;
}

int LuaGroupObject::getGroupLevel(lua_State* L) {
	int groupLevel = realObject->getGroupLevel();
	lua_pushinteger(L, groupLevel);	

	return 1;
}

int LuaGroupObject::getGroupSize(lua_State* L) {
	int playerCount = realObject->getGroupSize();
	lua_pushinteger(L, playerCount);	

	return 1;
}

int LuaGroupObject::getNumberOfPlayerMembers(lua_State* L) {
	int playerCount = realObject->getNumberOfPlayerMembers();
	lua_pushinteger(L, playerCount);	

	return 1;
}

int LuaGroupObject::getGroupMember(lua_State* L) {
	int i = lua_tonumber(L, -1);

	if (i < 0)
		i = 0;

	if (realObject->getGroupSize() < i) {
		lua_pushnil(L);
		return 1;
	}

	CreatureObject* creo = realObject->getGroupMember(i);

	if (creo == nullptr) {
		realObject->info("LuaGroupObject::getGroupMember GroupMember is NULL.");
		lua_pushnil(L);
	} else {
		creo->_setUpdated(true);
		lua_pushlightuserdata(L, creo);
	}

	return 1;
}

int LuaGroupObject::getLeader(lua_State* L) {
	lua_pushlightuserdata(L, realObject->getLeader());	

	return 1;
}

int LuaGroupObject::getGroupList(lua_State* L) {
	GroupList* groupList = realObject->getGroupList();
	if (groupList == nullptr){
		lua_pushnil(L);
	}else{
		lua_newtable(L);
		int count = 0;
		for (int i = 0; i < groupList->size(); i++) {
			CreatureObject* member = groupList->get(i).get();
			if (member == nullptr)
				continue;

			count++;
			lua_pushlightuserdata(L, member);
			lua_rawseti(L, -2, count);
		}
	}
	return 1;
}

int LuaGroupObject::getPlayerList(lua_State* L) {
	GroupList* groupList = realObject->getGroupList();
	if (groupList == nullptr){
		lua_pushnil(L);
	}else{
		lua_newtable(L);
		int count = 0;
		for (int i = 0; i < groupList->size(); i++) {
			CreatureObject* member = groupList->get(i).get();
			if (member == nullptr || !member->isPlayerCreature())
				continue;

			count++;
			lua_pushlightuserdata(L, member);
			lua_rawseti(L, -2, count);
		}
	}
	return 1;
}

int LuaGroupObject::getGroupLock(lua_State* L) {
	lua_pushboolean(L, realObject->getGroupLock());
	return 1;
}

int LuaGroupObject::setGroupLock(lua_State* L) {
	bool newState = lua_tonumber(L, -1);
	Locker locker(realObject);
	realObject->setGroupLock(newState);
	return 1;
}

int LuaGroupObject::hasMemberObject(lua_State* L) {
	CreatureObject* creo = (CreatureObject*) lua_touserdata(L, -1);
	lua_pushboolean(L, realObject->hasMember(creo));
	return 1;
}

int LuaGroupObject::hasMemberID(lua_State* L) {
	uint64 creoID = lua_tointeger(L, -1);
	lua_pushboolean(L, realObject->hasMember(creoID));
	return 1;
}

int LuaGroupObject::hasSquadLeader(lua_State* L) {
	lua_pushboolean(L, realObject->hasSquadLeader());
	return 1;
}

int LuaGroupObject::isOtherMemberPlayingMusic(lua_State* L) {
	CreatureObject* groupMember = (CreatureObject*) lua_touserdata(L, -1);
	lua_pushboolean(L, realObject->isOtherMemberPlayingMusic(groupMember));
	return 1;
}

int LuaGroupObject::forceAddMember(lua_State* L) {
	CreatureObject* newMember = (CreatureObject*) lua_touserdata(L, -1);
	Locker locker(realObject);
	realObject->addMember(newMember);
	return 0;
}

int LuaGroupObject::forceRemoveMember(lua_State* L) {
	CreatureObject* groupMember = (CreatureObject*) lua_touserdata(L, -1);
	Locker locker(realObject);
	realObject->removeMember(groupMember);
	return 0;
}

int LuaGroupObject::disband(lua_State* L) {
	realObject->notifyObservers(ObserverEventType::GROUPDISBANDED);
	Locker locker(realObject);
	realObject->disband();
	return 0;
}

int LuaGroupObject::makeLeader(lua_State* L) {
	CreatureObject* groupMember = (CreatureObject*) lua_touserdata(L, -1);
	realObject->makeLeader(groupMember);
	return 0;
}
