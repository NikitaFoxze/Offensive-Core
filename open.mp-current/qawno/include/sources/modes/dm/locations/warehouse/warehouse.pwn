/*
 * |>================================<|
 * |   About: DM Warehouse location   |
 * |   Author: Foxze                  |
 * |>================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- DM_WarehousePool_Init()
	- DM_Warehouse_CreateElements(sessionid)
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

#if defined _INC_DM_LOC_WAREHOUSE
	#endinput
#endif
#define _INC_DM_LOC_WAREHOUSE

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_WarehousePool_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_WAREHOUSE, "Склад");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_WAREHOUSE, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_WAREHOUSE, DM_GAME_MODE_NORMAL);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_WAREHOUSE, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_WAREHOUSE, 9);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_WAREHOUSE, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_WAREHOUSE, 0);
	return 1;
}

stock DM_Warehouse_CreateElements(sessionid)
{
	// Exit zone
	DM_SetExitZonePos(sessionid, 2097.0, -2361.0, 2285.0, -2174.0);

	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, 2220.3625, -2206.7083, 13.5469);
	DM_SetSpawnPos(sessionid, 1, 2221.5032, -2257.4958, 13.5547);
	DM_SetSpawnPos(sessionid, 2, 2174.5510, -2250.0488, 13.3034);
	DM_SetSpawnPos(sessionid, 3, 2240.1809, -2261.1460, 14.7647);
	DM_SetSpawnPos(sessionid, 4, 2140.3213, -2286.0417, 14.7757);
	DM_SetSpawnPos(sessionid, 5, 2134.5515, -2303.9446, 14.6987);
	return 1;
}