/*
 * |>=============================<|
 * |   About: DM Atrium location   |
 * |   Author: Foxze               |
 * |>=============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- DM_Atrium_Init()
	- DM_Atrium_CreateElements(sessionid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_DM_LOC_ATRIUM
	#endinput
#endif
#define _INC_DM_LOC_ATRIUM

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_Atrium_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_ATRIUM, "Атриум");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_ATRIUM, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_ATRIUM, DM_GAME_MODE_NORMAL);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_ATRIUM, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_ATRIUM, 8);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_ATRIUM, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_ATRIUM, 18);
	return 1;
}

stock DM_Atrium_CreateElements(sessionid)
{
	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, 1702.7311, -1650.7675, 20.2197);
	DM_SetSpawnPos(sessionid, 1, 1721.4229, -1671.3993, 20.2241);
	DM_SetSpawnPos(sessionid, 2, 1732.7911, -1644.6544, 20.2290);
	DM_SetSpawnPos(sessionid, 3, 1710.0437, -1667.6257, 23.7021);
	DM_SetSpawnPos(sessionid, 4, 1709.6578, -1659.3623, 27.1953);
	DM_SetSpawnPos(sessionid, 5, 1733.7649, -1654.5363, 27.2317);
	return 1;
}