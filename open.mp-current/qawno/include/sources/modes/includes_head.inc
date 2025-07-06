/*
 * |>=================================<|
 * |   About: Modes all include head   |
 * |   Author: Foxze                   |
 * |>=================================<|
 */

#if defined _INC_MODES_ALL_HEAD
	#endinput
#endif
#define _INC_MODES_ALL_HEAD

/*
 * |>----------------<|
 * |     Includes     |
 * |>----------------<|
 */

// Core
#include <sources/modes/modes_head>
#include <sources/modes/modes_td>

// Mode None
#include <sources/modes/none/none_head>
#include <sources/modes/none/none_td>

// Mode TDM
#include <sources/modes/tdm/tdm_head>
#include <sources/modes/tdm/tdm_td>
#include <sources/modes/tdm/modules/classes/classes_head>
#include <sources/modes/tdm/modules/classes/classes_td>
#include <sources/modes/tdm/locations/location_head>
#include <sources/modes/tdm/locations/location_td>

// Mode DM
#include <sources/modes/dm/dm_head>
#include <sources/modes/dm/dm_td>
#include <sources/modes/dm/locations/location_head>

// Mode Room
#include <sources/modes/room/room_head>
#include <sources/modes/room/room_td>
#include <sources/modes/room/locations/location_head>
#include <sources/modes/room/locations/location_td>

// Mode Example
#include <sources/modes/example/example_head>
#include <sources/modes/example/locations/location_head>