/*
 * |>==================================<|
 * |   About: DM Dog Mansion location   |
 * |   Author: Foxze                    |
 * |>==================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- DM_DogMansion_Init()
	- DM_DogMansion_CreateElements(sessionid)
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

#if defined _INC_DM_LOC_DOGMANSION
	#endinput
#endif
#define _INC_DM_LOC_DOGMANSION

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_DogMansion_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_DOGMANSION, "Собачий особняк");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_DOGMANSION, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_DOGMANSION, DM_GAME_MODE_NORMAL);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_DOGMANSION, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_DOGMANSION, 8);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_DOGMANSION, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_DOGMANSION, 5);
	return 1;
}

stock DM_DogMansion_CreateElements(sessionid)
{
	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, 1263.0790, -784.2686, 1091.9063);
	DM_SetSpawnPos(sessionid, 1, 1274.0310, -808.0443, 1089.9375);
	DM_SetSpawnPos(sessionid, 2, 1291.5470, -814.0375, 1089.9375);
	DM_SetSpawnPos(sessionid, 3, 1279.9937, -810.4382, 1085.6328);
	DM_SetSpawnPos(sessionid, 4, 1292.7234, -825.9493, 1085.6328);
	DM_SetSpawnPos(sessionid, 5, 1232.8920, -836.4986, 1084.0078);
	return 1;
}