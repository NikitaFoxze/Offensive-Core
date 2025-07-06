/*
 * |>===================================<|
 * |   About: DM Palace smoke location   |
 * |   Author: Foxze                     |
 * |>===================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- DM_PalaceSmoke_Init()
	- DM_PalaceSmoke_CreateElements(sessionid)
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

#if defined _INC_DM_LOC_PALACESMOKE
	#endinput
#endif
#define _INC_DM_LOC_PALACESMOKE

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_PalaceSmoke_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_PALACESMOKE, "Дворец дыма");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_PALACESMOKE, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_PALACESMOKE, DM_GAME_MODE_DEAGLE);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_PALACESMOKE, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_PALACESMOKE, 7);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_PALACESMOKE, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_PALACESMOKE, 2);
	return 1;
}

stock DM_PalaceSmoke_CreateElements(sessionid)
{
	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, 2572.2146, -1284.3903, 1065.3672);
	DM_SetSpawnPos(sessionid, 1, 2558.0400, -1299.0900, 1060.9844);
	DM_SetSpawnPos(sessionid, 2, 2555.0859, -1283.3650, 1054.6470);
	DM_SetSpawnPos(sessionid, 3, 2567.8992, -1302.5155, 1054.6406);
	DM_SetSpawnPos(sessionid, 4, 2541.6260, -1288.6812, 1054.6406);
	DM_SetSpawnPos(sessionid, 5, 2530.9465, -1306.0892, 1054.6406);
	return 1;
}