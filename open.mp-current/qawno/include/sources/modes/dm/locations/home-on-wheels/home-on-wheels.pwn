/*
 * |>==================================<|
 * |   About: DM Home wheels location   |
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
	- DM_HomeWheels_Init()
	- DM_HomeWheels_CreateElements(sessionid)
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

#if defined _INC_DM_LOC_HOMEONWHEELS
	#endinput
#endif
#define _INC_DM_LOC_HOMEONWHEELS

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_HomeWheels_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_HOMEWHEELS, "Дома на колёсах");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_HOMEWHEELS, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_HOMEWHEELS, DM_GAME_MODE_DEAGLE);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_HOMEWHEELS, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_HOMEWHEELS, 7);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_HOMEWHEELS, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_HOMEWHEELS, 0);
	return 1;
}

stock DM_HomeWheels_CreateElements(sessionid)
{
	// Exit zone
	DM_SetExitZonePos(sessionid, -52.0, 1316.0, 61.0, 1420.0);

	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, -21.5425, 1391.7113, 9.1719);
	DM_SetSpawnPos(sessionid, 1, 8.0184, 1385.8538, 9.1781);
	DM_SetSpawnPos(sessionid, 2, 32.4650, 1358.4178, 9.1719);
	DM_SetSpawnPos(sessionid, 3, -3.1167, 1337.3088, 9.1719);
	DM_SetSpawnPos(sessionid, 4, -25.1340, 1354.6593, 9.1719);
	DM_SetSpawnPos(sessionid, 5, -4.5781, 1377.3354, 9.1719);
	return 1;
}