/*
 * |>============================<|
 * |   About: DM Jizzy location   |
 * |   Author: Foxze              |
 * |>============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- DM_Jizzy_Init()
	- DM_Jizzy_CreateElements(sessionid)
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

#if defined _INC_DM_LOC_JIZZY
	#endinput
#endif
#define _INC_DM_LOC_JIZZY

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_Jizzy_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_JIZZY, "Джизи");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_JIZZY, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_JIZZY, DM_GAME_MODE_DEAGLE);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_JIZZY, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_JIZZY, 8);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_JIZZY, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_JIZZY, 3);
	return 1;
}

stock DM_Jizzy_CreateElements(sessionid)
{
	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, -2636.3745, 1406.5156, 906.4609);
	DM_SetSpawnPos(sessionid, 1, -2666.7595, 1427.5782, 906.4609);
	DM_SetSpawnPos(sessionid, 2, -2641.9963, 1420.6669, 906.4609);
	DM_SetSpawnPos(sessionid, 3, -2667.7627, 1394.7880, 912.4114);
	DM_SetSpawnPos(sessionid, 4, -2647.2834, 1393.7124, 918.3582);
	DM_SetSpawnPos(sessionid, 5, -2659.7905, 1428.0496, 912.4114);
	return 1;
}