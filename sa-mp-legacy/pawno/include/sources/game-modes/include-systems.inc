/*

	About: Game-modes all include systems
	Author: Foxze

*/

#if defined _INC_GAME_MODES_ALL_SYSTEMS
	#endinput
#endif
#define _INC_GAME_MODES_ALL_SYSTEMS

/*

	* Includes *

*/

// Core
#include <sources/game-modes/system.pwn>

// Mode TDM
#include <sources/game-modes/tdm/system.pwn>
#include <sources/game-modes/tdm/team.pwn>
#include <sources/game-modes/tdm/squad.pwn>
#include <sources/game-modes/tdm/classes.pwn>
#include <sources/game-modes/tdm/damage.pwn>

#include <sources/game-modes/tdm/locations/system.pwn>

// Mode DM
#include <sources/game-modes/dm/system.pwn>
#include <sources/game-modes/dm/damage.pwn>

#include <sources/game-modes/dm/locations/system.pwn>

// Mode Room
#include <sources/game-modes/room/system.pwn>
#include <sources/game-modes/room/team.pwn>
#include <sources/game-modes/room/damage.pwn>

#include <sources/game-modes/room/locations/system.pwn>

// Mode None
#include <sources/game-modes/none/system.pwn>

// Mode Example
#include <sources/game-modes/example/system.pwn>
#include <sources/game-modes/example/damage.pwn>

#include <sources/game-modes/example/locations/system.pwn>