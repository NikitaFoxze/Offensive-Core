/*
 * |>===================================<|
 * |   About: DM Military oil location   |
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
	- DM_MilitaryOil_Init()
	- DM_MilitaryOil_CreateElements(sessionid)
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

#if defined _INC_DM_LOC_MILITARYOIL
	#endinput
#endif

#define _INC_DM_LOC_MILITARYOIL

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock DM_MilitaryOil_Init()
{
	Mode_AddLocation(MODE_DM, DM_LOC_MILITARYOIL, "Военный нефтезавод");
	Mode_SetLocationInfo(MODE_DM, DM_LOC_MILITARYOIL, "-");

	Mode_SetLocationGameMode(MODE_DM, DM_LOC_MILITARYOIL, DM_GAME_MODE_SNIPER);
	Mode_SetLocationWeather(MODE_DM, DM_LOC_MILITARYOIL, 0);
	Mode_SetLocationMinutes(MODE_DM, DM_LOC_MILITARYOIL, 7);
	Mode_SetLocationSeconds(MODE_DM, DM_LOC_MILITARYOIL, 0);
	Mode_SetLocationInterior(MODE_DM, DM_LOC_MILITARYOIL, 0);
	return 1;
}

stock DM_MilitaryOil_CreateElements(sessionid)
{
	// Exit zone
	DM_SetExitZonePos(sessionid, 2490.0, 2612.0, 2782.0, 2884.0);

	// Tokens
	DM_SetTokens(sessionid, true);

	// Spawn positions
	DM_SetSpawnPos(sessionid, 0, 2553.0779, 2828.5454, 27.8203);
	DM_SetSpawnPos(sessionid, 1, 2628.4141, 2767.3938, 23.8222);
	DM_SetSpawnPos(sessionid, 2, 2613.6714, 2707.3394, 25.8222);
	DM_SetSpawnPos(sessionid, 3, 2518.4944, 2721.7681, 10.8203);
	DM_SetSpawnPos(sessionid, 4, 2567.7339, 2694.8098, 22.9507);
	DM_SetSpawnPos(sessionid, 5, 2657.6345, 2824.5725, 36.3222);
	return 1;
}