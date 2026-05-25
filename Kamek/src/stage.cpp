#include <game.h>
#include <common.h>
#include <stage.h>
#include <actors.h>
#include <gamescene.h>

extern bool SlowedDownTimeAlt;

int dScStage_c::newOnDelete() {
	//Level-Special Related...
	if (exitingStage) {
		//Reset some values here....
		SlowedDownTimeAlt = false;
	}

	return this->onDelete_orig();
}