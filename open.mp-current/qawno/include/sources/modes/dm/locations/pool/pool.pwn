/*
 * |>===========================<|
 * |   About: DM Pool location   |
 * |   Author: Foxze             |
 * |>===========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- DM_Pool_Init()
	- DM_Pool_CreateElements(sessionid)
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

#if defined _INC_DM_LOC_POOL
	#endinput
#endif
#define _INC_DM_LOC_POOL

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_Pool_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_POOL, "Бассейн");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_POOL, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_POOL, DM_GAME_MODE_DEAGLE);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_POOL, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_POOL, 7);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_POOL, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_POOL, 0);
	return 1;
}

stock DM_Pool_CreateElements(sessionid)
{
	// Exit zone
	DM_SetExitZonePos(sessionid, 1690.0, 2716.0, 1923.0, 2888.0);

	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, 1769.1963, 2771.4551, 10.8359);
	DM_SetSpawnPos(sessionid, 1, 1767.9481, 2856.0032, 10.8283);
	DM_SetSpawnPos(sessionid, 2, 1823.2061, 2821.1333, 10.8296);
	DM_SetSpawnPos(sessionid, 3, 1808.4742, 2736.3042, 10.8359);
	DM_SetSpawnPos(sessionid, 4, 1716.7808, 2747.4055, 10.8359);
	DM_SetSpawnPos(sessionid, 5, 1716.1667, 2874.4885, 10.8359);
	return 1;
}