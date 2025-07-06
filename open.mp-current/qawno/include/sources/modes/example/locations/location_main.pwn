/*
 * |>================================<|
 * |   About: Example location main   |
 * |   Author: Foxze                  |
 * |>================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
 * Stock:
	- Example_InitialLocations()

	- Example_CreateElementsLoc(sessionid, locationid)
	- Example_DestroyElementsLoc(sessionid)

	- Example_ShowPlayerElementsLoc(playerid)
	- Example_HidePlayerElementsLoc(playerid)

	- Example_SetTokens(sessionid, bool:type)
	- Example_GetTokens(sessionid)

	- Example_SetSpawnPos(sessionid, Float:X, Float:Y, Float:Z)
	- Example_GetSpawnPos(sessionid, &Float:X, &Float:Y, &Float:Z)
	- Example_ResetSpawnPos(sessionid)

	# Technical #
	- Example_LocResetSessionData(sessionid)
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

#if defined _INC_EXAMPLE_LOC_MAIN
	#endinput
#endif
#define _INC_EXAMPLE_LOC_MAIN

/*
 * |>-----------------<|
 * |     Locations     |
 * |>-----------------<|
 */

#include <sources/modes/example/locations/desert/desert.pwn>

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	bool:ActiveTokens[GMS_MAX_SESSIONS];

static
	Float:LocationSpawnPos[GMS_MAX_SESSIONS][3];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

// Initialization locations
stock Example_InitialLocations()
{
	Example_Desert_Init();
	return 1;
}

// Create location elements
stock Example_CreateElementsLoc(sessionid, locationid)
{
	// Location
	switch (locationid) {
		case EXAMPLE_LOC_DESERT: Example_Desert_CreateElements(sessionid);
	}
	return 1;
}

// Remove location elements
stock Example_DestroyElementsLoc(sessionid)
{
	// Tokens
	if (Example_GetTokens(sessionid)) {
		Example_SetTokens(sessionid, false);
	}
	return 1;
}

// Show the player elements of the mode/location
stock Example_ShowPlayerElementsLoc(playerid)
{
	#pragma unused playerid
	
	return 1;
}

// Hide mode/location elements for the player
stock Example_HidePlayerElementsLoc(playerid)
{
	#pragma unused playerid

	return 1;
}

// Tokens

stock Example_SetTokens(sessionid, bool:type)
{
	ActiveTokens[sessionid] = type;
	return 1;
}

stock Example_GetTokens(sessionid)
{
	return ActiveTokens[sessionid];
}

// Spawn coordinates

stock Example_SetSpawnPos(sessionid, Float:X, Float:Y, Float:Z)
{
	LocationSpawnPos[sessionid][0] = X;
	LocationSpawnPos[sessionid][1] = Y;
	LocationSpawnPos[sessionid][2] = Z;
	return 1;
}

stock Example_GetSpawnPos(sessionid, &Float:X, &Float:Y, &Float:Z)
{
	X = LocationSpawnPos[sessionid][0];
	Y = LocationSpawnPos[sessionid][1];
	Z = LocationSpawnPos[sessionid][2];
	return 1;
}

stock Example_ResetSpawnPos(sessionid)
{
	LocationSpawnPos[sessionid][0] =
	LocationSpawnPos[sessionid][1] =
	LocationSpawnPos[sessionid][2] = 0.0;
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

stock Example_LocResetSessionData(sessionid)
{
	Example_ResetSpawnPos(sessionid);
	return 1;
}

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>------------------<|
 * |   OnGameModeInit   |
 * |>------------------<|
 */

stock Example_LocOnGameModeInit()
{
	Example_InitialLocations();
	return 1;
}