/*

	About: Example location system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
	Stock:
		Example_CreateElementsLoc(session_id)
		Example_DestroyElementsLoc(session_id)
		Example_ShowPlayerElementsLoc(playerid)
		Example_HidePlayerElementsLoc(playerid)
		Example_SetTokens(session_id, bool:type)
		Example_GetTokens(session_id)
		Example_SetSpawnPos(session_id, Float:X, Float:Y, Float:Z)
		Example_GetSpawnPos(session_id, &Float:X, &Float:Y, &Float:Z)
		Example_ResetSpawnPos(session_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_EXAMPLE_LOC_SYSTEM
	#endinput
#endif
#define _INC_EXAMPLE_LOC_SYSTEM

/*

	* Locations *

*/

#include <sources/game-modes/example/locations/desert/desert.pwn>

/*

	* Vars *

*/

static
	bool:ActiveTokens[EXAMPLE_MAX_GAME_SESSIONS];

static
	Float:LocationSpawnPos[EXAMPLE_MAX_GAME_SESSIONS][3];

/*

	* Functions *

*/

// Создать элементы локации
stock Example_CreateElementsLoc(session_id)
{
	// Локации
	switch(Mode_GetLocation(MODE_EXAMPLE, session_id)) {
		case EXAMPLE_LOC_DESERT: Example_Desert_CreateElements(session_id);
	}
	return 1;
}

// Удалить элементы локации
stock Example_DestroyElementsLoc(session_id)
{
	// Жетоны
	if(Example_GetTokens(session_id))
		Example_SetTokens(session_id, false);

	// Погода
	Mode_SetWeather(MODE_EXAMPLE, session_id, 0);

	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_EXAMPLE, session_id, Mode_GetBasicVirtualWorld(MODE_EXAMPLE, session_id));
	Mode_SetInterior(MODE_EXAMPLE, session_id, Mode_GetBasicInterior(MODE_EXAMPLE, session_id));
	return 1;
}

// Показать игроку элементы режима/локации
stock Example_ShowPlayerElementsLoc(playerid)
{
	#pragma unused playerid
	
	return 1;
}

// Скрыть игроку элементы режима/локации
stock Example_HidePlayerElementsLoc(playerid)
{
	#pragma unused playerid

	return 1;
}

// Жетоны

stock Example_SetTokens(session_id, bool:type)
{
	ActiveTokens[session_id] = type;
	return 1;
}

stock Example_GetTokens(session_id)
{
	return ActiveTokens[session_id];
}

// Координаты спавна

stock Example_SetSpawnPos(session_id, Float:X, Float:Y, Float:Z)
{
	LocationSpawnPos[session_id][0] = X;
	LocationSpawnPos[session_id][1] = Y;
	LocationSpawnPos[session_id][2] = Z;
	return 1;
}

stock Example_GetSpawnPos(session_id, &Float:X, &Float:Y, &Float:Z)
{
	X = LocationSpawnPos[session_id][0];
	Y = LocationSpawnPos[session_id][1];
	Z = LocationSpawnPos[session_id][2];
	return 1;
}

stock Example_ResetSpawnPos(session_id)
{
	LocationSpawnPos[session_id][0] =
	LocationSpawnPos[session_id][1] =
	LocationSpawnPos[session_id][2] = 0.0;
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock Example_LocOnGameModeInit(session_id)
{
	Example_ResetSpawnPos(session_id);
	return 1;
}