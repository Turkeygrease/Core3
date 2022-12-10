/*
				Copyright <SWGEmu>
		See file COPYING for copying conditions.*/

#ifndef STANDFASTANIMATIONTASK_H_
#define STANDFASTANIMATIONTASK_H_

#include "server/zone/objects/creature/CreatureObject.h"

namespace server {
namespace zone {
namespace objects {
namespace creature {
namespace events {

class StandFastAnimationTask : public Task {

	ManagedReference<CreatureObject*> player;
	int countDown;
	
public:
	StandFastAnimationTask(CreatureObject* player, int countDown) : Task() { 
		this->player = player;
		this->countDown = countDown;
	}

	void run() {
		if (player == nullptr)
			return;

		Locker locker(player);

		player->removePendingTask("Standfast_animation");
		
		// If buff is still active, perform animation and reschedule
		if (countDown > 0) {
			countDown = countDown -1;
			player->playEffect("clienteffect/commando_position_secured.cef", "");
			//reschedule( 9000 );
			Reference<Task*> standFastAnimationTask = new StandFastAnimationTask(player, countDown); //crc,
			player->addPendingTask("standfast_animation", standFastAnimationTask, 9000);
		}
	}
};

} // events
} // creature
} // objects
} // zone
} // server

using namespace server::zone::objects::creature::events;

#endif /*STANDFASTANIMATIONTASK_H_*/