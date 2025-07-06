/*
 * |>=================================<|
 * |   About: Modes all include main   |
 * |   Author: Foxze                   |
 * |>=================================<|
 */

#if defined _INC_MODES_ALL_MAIN
	#endinput
#endif
#define _INC_MODES_ALL_MAIN

/*
 * |>----------------<|
 * |     Includes     |
 * |>----------------<|
 */

// Core
#include <sources/modes/modes_main.pwn>

// Mode TDM
#include <sources/modes/tdm/tdm_main.pwn>

#include <sources/modes/tdm/modules/classes/classes_main.pwn>
#include <sources/modes/tdm/modules/team/team_main.pwn>
#include <sources/modes/tdm/modules/squad/squad_main.pwn>
#include <sources/modes/tdm/modules/damage/damage_main.pwn>

#include <sources/modes/tdm/locations/location_main.pwn>

// Mode DM
#include <sources/modes/dm/dm_main.pwn>
#include <sources/modes/dm/modules/damage/damage_main.pwn>

#include <sources/modes/dm/locations/location_main.pwn>

// Mode Room
#include <sources/modes/room/room_main.pwn>
#include <sources/modes/room/modules/team/team_main.pwn>
#include <sources/modes/room/modules/damage/damage_main.pwn>

#include <sources/modes/room/locations/location_main.pwn>

// Mode None
#include <sources/modes/none/none_main.pwn>

// Mode Example
#include <sources/modes/example/example_main.pwn>
#include <sources/modes/example/modules/damage/damage_main.pwn>

#include <sources/modes/example/locations/location_main.pwn>