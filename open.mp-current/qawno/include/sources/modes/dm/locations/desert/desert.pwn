/*
 * |>=============================<|
 * |   About: DM Desert location   |
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
	- DM_Desert_Init()
	- DM_Desert_CreateElements(sessionid)
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

#if defined _INC_DM_LOC_DESERT
	#endinput
#endif
#define _INC_DM_LOC_DESERT

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_Desert_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_DESERT, "Пустыня");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_DESERT, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_DESERT, DM_GAME_MODE_DEAGLE);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_DESERT, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_DESERT, 8);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_DESERT, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_DESERT, 0);
	return 1;
}

stock DM_Desert_CreateElements(sessionid)
{
	// Exit zone
	DM_SetExitZonePos(sessionid, 20.0, 2344.0, 380.0, 2475.0);

	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, 277.6578, 2424.0000, 16.4825);
	DM_SetSpawnPos(sessionid, 1, 222.6676, 2461.3718, 16.4844);
	DM_SetSpawnPos(sessionid, 2, 162.4950, 2452.5112, 16.4759);
	DM_SetSpawnPos(sessionid, 3, 104.6303, 2407.0576, 17.1137);
	DM_SetSpawnPos(sessionid, 4, 186.3553, 2390.8767, 16.4844);
	DM_SetSpawnPos(sessionid, 5, 228.7337, 2385.5715, 16.4844);
	return 1;
}