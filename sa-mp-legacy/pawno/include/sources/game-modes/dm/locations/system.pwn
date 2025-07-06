/*

	About: DM location system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	Stock:
		DM_CreateElementsLocation(session_id)
		DM_DestroyElementsLocation(session_id)
		DM_ShowPlayerElementsLocation(playerid)
		DM_HidePlayerElementsLocation(playerid)

		DM_SetTimer(session_id, minutes, seconds)
		DM_ResetTimer(session_id)
		DM_GetActiveTimer(session_id)

		DM_SetExitZonePos(session_id, Float:minx, Float:miny, Float:maxx, Float:maxy)
		DM_DestroyExitZone(session_id)
		DM_GetExitZone(session_id)
		DM_ResetExitZone(session_id)

		DM_SetSpawnPos(session_id, cell, Float:X, Float:Y, Float:Z)
		DM_GetSpawnPos(session_id, cell, &Float:X, &Float:Y, &Float:Z)
		DM_ResetSpawnPos(session_id)

		DM_SetTokens(session_id, bool:type)
		DM_GetTokens(session_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_SYSTEM
	#endinput
#endif
#define _INC_DM_LOC_SYSTEM

/*

	* Locations *

*/

#include <sources/game-modes/dm/locations/desert/desert.pwn>
#include <sources/game-modes/dm/locations/golf/golf.pwn>
#include <sources/game-modes/dm/locations/military-oil/military-oil.pwn>
#include <sources/game-modes/dm/locations/home-on-wheels/home-on-wheels.pwn>
#include <sources/game-modes/dm/locations/pool/pool.pwn>
#include <sources/game-modes/dm/locations/warehouse/warehouse.pwn>
#include <sources/game-modes/dm/locations/dog-mansion/dog-mansion.pwn>
#include <sources/game-modes/dm/locations/palace-smoke/palace-smoke.pwn>
#include <sources/game-modes/dm/locations/atrium/atrium.pwn>
#include <sources/game-modes/dm/locations/jizzy/jizzy.pwn>

/*

	* Vars *

*/

static
	bool:ActiveTimer[DM_MAX_GAME_SESSIONS];

static
	bool:ActiveExitZone[DM_MAX_GAME_SESSIONS],
	AreaExitZone[DM_MAX_GAME_SESSIONS],
	GangZoneExitZone[DM_MAX_GAME_SESSIONS];

static
	bool:ActiveTokens[DM_MAX_GAME_SESSIONS];

static
	Float:LocationSpawnPos[DM_MAX_GAME_SESSIONS][DM_MAX_SPAWN_POS][3];

/*

	* Functions *

*/

stock DM_CreateElementsLocation(session_id) 
{
	// Локации
	switch(Mode_GetLocation(MODE_DM, session_id)) {
		case DM_LOC_DESERT: DM_Desert_CreateElements(session_id);
		case DM_LOC_GOLF: DM_Golf_CreateElements(session_id);
		case DM_LOC_MILITARYOIL: DM_MilitaryOil_CreateElements(session_id);
		case DM_LOC_HOMEWHEELS: DM_HomeWheels_CreateElements(session_id);
		case DM_LOC_POOL: DM_Pool_CreateElements(session_id);
		case DM_LOC_WAREHOUSE: DM_Warehouse_CreateElements(session_id);
		case DM_LOC_DOGMANSION: DM_DogMansion_CreateElements(session_id);
		case DM_LOC_PALACESMOKE: DM_PalaceSmoke_CreateElements(session_id);
		case DM_LOC_ATRIUM: DM_Atrium_CreateElements(session_id);
		case DM_LOC_JIZZY: DM_Jizzy_CreateElements(session_id);
	}
	return 1;
}

stock DM_DestroyElementsLocation(session_id)
{
	// Время
	DM_ResetTimer(session_id);

	// Зона локации
	if(DM_GetExitZone(session_id))
		DM_DestroyExitZone(session_id);

	// Жетоны
	if(DM_GetTokens(session_id))
		DM_SetTokens(session_id, false);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, Mode_GetBasicInterior(MODE_DM, session_id));
	return 1;
}

stock DM_ShowPlayerElementsLocation(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	// Таймер
	if(DM_GetActiveTimer(session_id))
		Mode_CreatePlTDTimerSession(playerid);

	// Зона
	if(DM_GetExitZone(session_id))
		GangZoneShowForPlayer(playerid, GangZoneExitZone[session_id], 0xCCCCCC60);

	return 1;
}

stock DM_HidePlayerElementsLocation(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	// Таймер
	if(DM_GetActiveTimer(session_id)) 
		Mode_DestroyPlTDTimerSession(playerid);

	// Зона
	if(DM_GetExitZone(session_id))
		GangZoneHideForPlayer(playerid, GangZoneExitZone[session_id]);

	return 1;
}

/*
	Время
*/

stock DM_SetTimer(session_id, minutes, seconds)
{
	ActiveTimer[session_id] = true;

	Mode_SetMinutes(MODE_DM, session_id, minutes);
	Mode_SetSeconds(MODE_DM, session_id, seconds);
	return 1;
}

static DM_ResetTimer(session_id)
{
	ActiveTimer[session_id] = false;

	Mode_SetMinutes(MODE_DM, session_id, 0);
	Mode_SetSeconds(MODE_DM, session_id, 0);
	return 1;
}

stock DM_GetActiveTimer(session_id)
{
	return ActiveTimer[session_id];
}

/*
	Зона локации
*/

stock DM_SetExitZonePos(session_id, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	ActiveExitZone[session_id] = true;

	GangZoneExitZone[session_id] = GangZoneCreate(minx, miny, maxx, maxy);
	AreaExitZone[session_id] = CreateDynamicRectangle(minx, miny, maxx, maxy, Mode_GetVirtualWorld(MODE_DM, session_id), Mode_GetInterior(MODE_DM, session_id));
	return 1;
}

stock DM_DestroyExitZone(session_id)
{
	if(IsValidDynamicArea(AreaExitZone[session_id])) {
		GangZoneDestroy(GangZoneExitZone[session_id]);
		DestroyDynamicArea(AreaExitZone[session_id]);
	}

	DM_ResetExitZone(session_id);
	return 1;
}

stock DM_GetExitZone(session_id)
{
	return ActiveExitZone[session_id];
}

static DM_ResetExitZone(session_id)
{
	ActiveExitZone[session_id] = false;
	AreaExitZone[session_id] = INVALID_DYNAMIC_AREA_ID;
	GangZoneExitZone[session_id] = INVALID_GANG_ZONE;
	return 1;
}

stock DM_CreateElementEnterArea(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	if(DM_GetExitZone(session_id)) {
		if(GetPlayerZone(playerid)) {
			if(IsPlayerInDynamicArea(playerid, AreaExitZone[session_id])) {
				if(GetPlayerExitZone(playerid)) 
					HidePlayerExitZone(playerid);
			}
			else 
				ShowPlayerExitZone(playerid);
		}
	}
	return 1;
}

/*
	Места для спавна на локации
*/

stock DM_SetSpawnPos(session_id, cell, Float:X, Float:Y, Float:Z)
{
	LocationSpawnPos[session_id][cell][0] = X;
	LocationSpawnPos[session_id][cell][1] = Y;
	LocationSpawnPos[session_id][cell][2] = Z;
	return 1;
}

stock DM_GetSpawnPos(session_id, cell, &Float:X, &Float:Y, &Float:Z)
{
	X = LocationSpawnPos[session_id][cell][0];
	Y = LocationSpawnPos[session_id][cell][1];
	Z = LocationSpawnPos[session_id][cell][2];
	return 1;
}

stock DM_ResetSpawnPos(session_id)
{
	n_for(i, DM_MAX_SPAWN_POS) {
		LocationSpawnPos[session_id][i][0] =
		LocationSpawnPos[session_id][i][1] =
		LocationSpawnPos[session_id][i][2] = 0.0;
	}
	return 1;
}

/*
	Жетоны
*/

stock DM_SetTokens(session_id, bool:type)
{
	ActiveTokens[session_id] = type;
	return 1;
}

stock DM_GetTokens(session_id)
{
	return ActiveTokens[session_id];
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock DM_LocOnGameModeInit(session_id)
{
	DM_ResetTimer(session_id);
	DM_ResetExitZone(session_id);
	DM_ResetSpawnPos(session_id);
	return 1;
}

/*
	OnPlayerEnterDynamicArea
*/

stock DM_LocOnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 0;

	if(GetPlayerSpectating(playerid) > -1)
		return 0;

	if(GetPlayerDead(playerid))
		return 0;

	new 
		session_id = Mode_GetPlayerSession(playerid);

	if(DM_GetExitZone(session_id)) {
		if(GetPlayerZone(playerid)) {
			if(areaid == AreaExitZone[session_id]) {
				HidePlayerExitZone(playerid);
				return 1;
			}
		}
	}
	return 0;
}

/*
	OnPlayerLeaveDynamicArea
*/

stock DM_LocOnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 0;

	if(GetPlayerSpectating(playerid) > -1)
		return 0;

	new
		session_id = Mode_GetPlayerSession(playerid);

	if(DM_GetExitZone(session_id)) {
		if(GetPlayerZone(playerid)) {
			if(areaid == AreaExitZone[session_id]) {
				ShowPlayerExitZone(playerid);
				return 1;
			}
		}
	}
	return 0;
}