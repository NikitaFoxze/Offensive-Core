/*
 * |>==================================<|
 * |   About: Example Desert location   |
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
	- Example_Desert_Init()
	- Example_Desert_CreateElements(sessionid)
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

#if defined _INC_EXAMPLE_LOC_DESERT
	#endinput
#endif
#define _INC_EXAMPLE_LOC_DESERT

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock Example_Desert_Init()
{
	Mode_AddLocation(MODE_EXAMPLE, EXAMPLE_LOC_DESERT, "Пустыня");
	Mode_SetLocationInfo(MODE_EXAMPLE, EXAMPLE_LOC_DESERT, "-");

	Mode_SetLocationGameMode(MODE_EXAMPLE, EXAMPLE_LOC_DESERT, 0);
	Mode_SetLocationWeather(MODE_EXAMPLE, EXAMPLE_LOC_DESERT, 0);
	Mode_SetLocationMinutes(MODE_EXAMPLE, EXAMPLE_LOC_DESERT, 0);
	Mode_SetLocationSeconds(MODE_EXAMPLE, EXAMPLE_LOC_DESERT, 0);
	Mode_SetLocationInterior(MODE_EXAMPLE, EXAMPLE_LOC_DESERT, 0);
	return 1;
}

stock Example_Desert_CreateElements(sessionid)
{
	// Tokens
	Example_SetTokens(sessionid, true);

	// Спавн
	Example_SetSpawnPos(sessionid, 10.0, 10.0, 15.0);
	return 1;
}