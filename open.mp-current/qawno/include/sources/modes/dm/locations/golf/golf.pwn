/*
 * |>===========================<|
 * |   About: DM Golf location   |
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
	- DM_Golf_Init()
	- DM_Golf_CreateElements(sessionid)
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

#if defined _INC_DM_LOC_GOLF
	#endinput
#endif
#define _INC_DM_LOC_GOLF

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_Golf_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_GOLF, "Гольф");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_GOLF, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_GOLF, DM_GAME_MODE_NORMAL);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_GOLF, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_GOLF, 9);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_GOLF, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_GOLF, 0);
	return 1;
}

stock DM_Golf_CreateElements(sessionid)
{
	// Exit zone
	DM_SetExitZonePos(sessionid, 1116.0, 2719.0, 1459.0, 2864.0);

	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, 1146.8511, 2840.7112, 10.8203);
	DM_SetSpawnPos(sessionid, 1, 1158.8961, 2743.5889, 10.8281);
	DM_SetSpawnPos(sessionid, 2, 1217.7704, 2770.1914, 10.8203);
	DM_SetSpawnPos(sessionid, 3, 1278.6965, 2835.4556, 10.8125);
	DM_SetSpawnPos(sessionid, 4, 1396.3550, 2743.9644, 10.8203);
	DM_SetSpawnPos(sessionid, 5, 1350.1139, 2836.5676, 10.8203);
	return 1;
}