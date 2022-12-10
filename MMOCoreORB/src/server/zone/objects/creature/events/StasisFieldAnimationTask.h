/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef STASISFIELDANIMATIONTASK_H_
#define STASISFIELDANIMATIONTASK_H_

#include "server/zone/objects/creature/CreatureObject.h"

namespace server {
namespace zone {
namespace objects {
namespace creature {
namespace events {

class StasisFieldAnimationTask : public Task {

	ManagedReference<CreatureObject*> player;
	int countDown;
	
public:
	StasisFieldAnimationTask(CreatureObject* player, int countDown) : Task() { 
		this->player = player;
		this->countDown = countDown;
	}

	void run() {
		if (player == nullptr)
			return;

		Locker locker(player);

		player->removePendingTask("stasis_animation");
		
		// If buff is still active, perform animation and reschedule
		if (countDown > 0) {
			countDown = countDown -1;
			player->playEffect("clienteffect/medic_stasis.cef", "");
			//reschedule( 9000 );
			Reference<Task*> stasisFieldAnimationTask = new StasisFieldAnimationTask(player, countDown); //crc,
			player->addPendingTask("stasis_animation", stasisFieldAnimationTask, 9000);
		}
	}
};

} // events
} // creature
} // objects
} // zone
} // server

using namespace server::zone::objects::creature::events;

#endif /*SHIELDSANIMATIONTASK_H_*/