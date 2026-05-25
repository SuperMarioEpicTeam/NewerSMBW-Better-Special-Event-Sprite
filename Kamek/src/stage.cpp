#include <game.h>
#include <common.h>
#include <stage.h>
#include <actors.h>

#ifdef __KAMEK_TIMEKEEPER_H
#include <timekeeper.h>
#else
#include <gamescene.h>
#endif

extern bool SlowedDownTimeAlt;

int dScStage_c::newOnDelete() {
	//Level-Special Related...
	if (exitingStage) {
		//Reset some values here....
		SlowedDownTimeAlt = false;
	}

	return this->onDelete_orig();
}