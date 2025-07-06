/*
 * |>===========================<|
 * |   About: DM location main   |
 * |   Author: Foxze             |
 * |>===========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnPlayerConnect(playerid)
	- OnPlayerEnterPlayerGangZone(playerid, zoneid)
	- OnPlayerLeavePlayerGangZone(playerid, zoneid)
 * Stock:
	- DM_InitialLocations()

	- DM_CreateElementsLocation(sessionid, locationid)
	- DM_DestroyElementsLocation(sessionid)
	- DM_ShowPlayerElementsLocation(playerid)
	- DM_HidePlayerElementsLocation(playerid)

	- DM_SetExitZonePos(sessionid, Float:minx, Float:miny, Float:maxx, Float:maxy)
	- DM_DestroyExitZone(sessionid)

	- DM_SpawnPlayerInArea(playerid)

	- DM_SetSpawnPos(sessionid, cell, Float:X, Float:Y, Float:Z)
	- DM_GetSpawnPos(sessionid, cell, &Float:X, &Float:Y, &Float:Z)

	- DM_SetTokens(sessionid, bool:type)
	- DM_GetTokens(sessionid)

	# Technical #
	- DM_LocResetSessionData(sessionid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_DM_EXIT_ZONE_INFO
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

#if defined _INC_DM_LOC_MAIN
	#endinput
#endif
#define _INC_DM_LOC_MAIN

/*
 * |>-----------------<|
 * |     Locations     |
 * |>-----------------<|
 */

#include <sources/modes/dm/locations/desert/desert.pwn>
#include <sources/modes/dm/locations/golf/golf.pwn>
#include <sources/modes/dm/locations/military-oil/military-oil.pwn>
#include <sources/modes/dm/locations/home-on-wheels/home-on-wheels.pwn>
#include <sources/modes/dm/locations/pool/pool.pwn>
#include <sources/modes/dm/locations/warehouse/warehouse.pwn>
#include <sources/modes/dm/locations/dog-mansion/dog-mansion.pwn>
#include <sources/modes/dm/locations/palace-smoke/palace-smoke.pwn>
#include <sources/modes/dm/locations/atrium/atrium.pwn>
#include <sources/modes/dm/locations/jizzy/jizzy.pwn>

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_DM_EXIT_ZONE_INFO {
	bool:e_Enabled,
	Float:e_PosMinX,
	Float:e_PosMinY,
	Float:e_PosMaxX,
	Float:e_PosMaxY
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	ezInfo[GMS_MAX_SESSIONS][E_DM_EXIT_ZONE_INFO],
	PlayerExitZone[MAX_PLAYERS];

static
	bool:ActiveTokens[GMS_MAX_SESSIONS];

static
	Float:LocationSpawnPos[GMS_MAX_SESSIONS][DM_MAX_SPAWN_POS][3];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>----------------------------<|
 * |   Initialization locations   |
 * |>----------------------------<|
 */

stock DM_InitialLocations()
{
	DM_Desert_Init();
	DM_Golf_Init();
	DM_MilitaryOil_Init();
	DM_HomeWheels_Init();
	DM_Pool_Init();
	DM_WarehousePool_Init();
	DM_DogMansion_Init();
	DM_PalaceSmoke_Init();
	DM_Atrium_Init();
	DM_Jizzy_Init();
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Create & destroy elements   |
 * |>-----------------------------<|
 */

stock DM_CreateElementsLocation(sessionid, locationid) 
{
	switch (locationid) {
		case DM_LOC_DESERT: DM_Desert_CreateElements(sessionid);
		case DM_LOC_GOLF: DM_Golf_CreateElements(sessionid);
		case DM_LOC_MILITARYOIL: DM_MilitaryOil_CreateElements(sessionid);
		case DM_LOC_HOMEWHEELS: DM_HomeWheels_CreateElements(sessionid);
		case DM_LOC_POOL: DM_Pool_CreateElements(sessionid);
		case DM_LOC_WAREHOUSE: DM_Warehouse_CreateElements(sessionid);
		case DM_LOC_DOGMANSION: DM_DogMansion_CreateElements(sessionid);
		case DM_LOC_PALACESMOKE: DM_PalaceSmoke_CreateElements(sessionid);
		case DM_LOC_ATRIUM: DM_Atrium_CreateElements(sessionid);
		case DM_LOC_JIZZY: DM_Jizzy_CreateElements(sessionid);
	}
	return 1;
}

stock DM_DestroyElementsLocation(sessionid)
{
	// Exit zone
	if (GetExitZoneGZ(sessionid)) {
		DM_DestroyExitZone(sessionid);
	}

	// Tokens
	if (DM_GetTokens(sessionid)) {
		DM_SetTokens(sessionid, false);
	}
	return 1;
}

stock DM_ShowPlayerElementsLocation(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Timer
	if (Mode_GetSessionActiveTimer(MODE_DM, sessionid)) {
		Mode_ShowPlSessionTimerTD(playerid);
	}

	// Exit zone
	if (GetExitZoneGZ(sessionid)) {
		ShowPlayerExitZoneGZ(playerid);
	}
	return 1;
}

stock DM_HidePlayerElementsLocation(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Exit zone
	if (GetExitZoneGZ(sessionid)) {
		HidePlayerExitZoneGZ(playerid);
	}
	return 1;
}

/*
 * |>-------------<|
 * |   Exit zone   |
 * |>-------------<|
 */

stock DM_SetExitZonePos(sessionid, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	ezInfo[sessionid][e_Enabled] = true;

	ezInfo[sessionid][e_PosMinX] = minx;
	ezInfo[sessionid][e_PosMinY] = miny;
	ezInfo[sessionid][e_PosMaxX] = maxx;
	ezInfo[sessionid][e_PosMaxY] = maxy;
	return 1;
}

stock DM_DestroyExitZone(sessionid)
{
	ResetExitZoneGZ(sessionid);
	return 1;
}

static ShowPlayerExitZoneGZ(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	PlayerExitZone[playerid] = CreatePlayerGangZone(playerid, ezInfo[sessionid][e_PosMinX], ezInfo[sessionid][e_PosMinY], ezInfo[sessionid][e_PosMaxX], ezInfo[sessionid][e_PosMaxY]);
	PlayerGangZoneShow(playerid, PlayerExitZone[playerid], 0xCCCCCC60);
	UsePlayerGangZoneCheck(playerid, PlayerExitZone[playerid], true);
	return 1;
}

static HidePlayerExitZoneGZ(playerid)
{
	PlayerGangZoneDestroy(playerid, PlayerExitZone[playerid]);
	PlayerExitZone[playerid] = INVALID_GANG_ZONE;
	return 1;
}

static GetExitZoneGZ(sessionid)
{
	return ezInfo[sessionid][e_Enabled];
}

static ResetExitZoneGZ(sessionid)
{
	ezInfo[sessionid][e_Enabled] = false;
	ezInfo[sessionid][e_PosMinX] =
	ezInfo[sessionid][e_PosMinY] =
	ezInfo[sessionid][e_PosMaxX] =
	ezInfo[sessionid][e_PosMaxY] = 0.0;
	return 1;
}

stock DM_SpawnPlayerInArea(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (!GetExitZoneGZ(sessionid)) {
		return 1;
	}

	if (!GetPlayerActionZone(playerid)) {
		return 1;
	}

	if (IsPlayerInPlayerGangZone(playerid, PlayerExitZone[playerid])) {
		if (GetPlayerExitZone(playerid)) {
			HidePlayerExitZone(playerid);
		}
	}
	else {
		ShowPlayerExitZone(playerid);
	}
	return 1;
}

/*
 * |>-------------------<|
 * |   Spawn positions   |
 * |>-------------------<|
 */

stock DM_SetSpawnPos(sessionid, cell, Float:X, Float:Y, Float:Z)
{
	LocationSpawnPos[sessionid][cell][0] = X;
	LocationSpawnPos[sessionid][cell][1] = Y;
	LocationSpawnPos[sessionid][cell][2] = Z;
	return 1;
}

stock DM_GetSpawnPos(sessionid, cell, &Float:X, &Float:Y, &Float:Z)
{
	X = LocationSpawnPos[sessionid][cell][0];
	Y = LocationSpawnPos[sessionid][cell][1];
	Z = LocationSpawnPos[sessionid][cell][2];
	return 1;
}

static ResetSpawnPos(sessionid)
{
	n_for(i, DM_MAX_SPAWN_POS) {
		LocationSpawnPos[sessionid][i][0] =
		LocationSpawnPos[sessionid][i][1] =
		LocationSpawnPos[sessionid][i][2] = 0.0;
	}
	return 1;
}

/*
 * |>----------<|
 * |   Tokens   |
 * |>----------<|
 */

stock DM_SetTokens(sessionid, bool:type)
{
	ActiveTokens[sessionid] = type;
	return 1;
}

stock DM_GetTokens(sessionid)
{
	return ActiveTokens[sessionid];
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

stock DM_LocResetSessionData(sessionid)
{
	ResetExitZoneGZ(sessionid);
	ResetSpawnPos(sessionid);
	return 1;
}

static ResetPlayerData(playerid)
{
	PlayerExitZone[playerid] = INVALID_GANG_ZONE;
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

stock DM_LocOnGameModeInit()
{
	DM_InitialLocations();
	return 1;
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);

	#if defined DM_LocOnPlayerConnect
		return DM_LocOnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>-------------------------------<|
 * |   OnPlayerEnterPlayerGangZone   |
 * |>-------------------------------<|
 */

stock DM_LocOnPlayerEnterPlayerGZ(playerid, zoneid)
{
	if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
		return 0;
	}

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 0;
	}

	new 
		sessionid = Mode_GetPlayerSession(playerid);

	if (GetExitZoneGZ(sessionid)) {
		if (GetPlayerActionZone(playerid)) {
			if (zoneid == PlayerExitZone[playerid]) {
				HidePlayerExitZone(playerid);
				return 1;
			}
		}
	}
    return 0;
}

/*
 * |>-------------------------------<|
 * |   OnPlayerLeavePlayerGangZone   |
 * |>-------------------------------<|
 */

stock DM_LocOnPlayerLeavePlayerGZ(playerid, zoneid)
{
	if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
		return 0;
	}

	new 
		sessionid = Mode_GetPlayerSession(playerid);

	if (GetExitZoneGZ(sessionid)) {
		if (GetPlayerActionZone(playerid)) {
			if (zoneid == PlayerExitZone[playerid]) {
				ShowPlayerExitZone(playerid);
				return 1;
			}
		}
	}
    return 0;
}

/*
 * |>-------<|
 * |   ALS   |
 * |>-------<|
 */

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect DM_LocOnPlayerConnect
#if defined DM_LocOnPlayerConnect
	forward DM_LocOnPlayerConnect(playerid);
#endif