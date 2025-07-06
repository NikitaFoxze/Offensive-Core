/*
 * |>======================<|
 * |   About: Modes main    |
 * |   Author: Foxze        |
 * |>======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnPlayerConnect(playerid)
	- OnPlayerSpawn(playerid)
	- OnPlayerDeath(playerid, &killerid, &WEAPON:reason)
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
	- OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
	- OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnPlayerEnterPlayerGangZone(playerid, zoneid)
	- OnPlayerLeavePlayerGangZone(playerid, zoneid)
	- OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
	- OnPlayerCommandReceived(playerid, cmd[], params[], flags)

	# Technical #
	- Mode_CallDestroySession(modeid, sessionid)
 * Stock:
	# Mode #
	- Mode_Add(modeid, const shortName[], const fullName[], sessionMaxPlayers, bool:changeEnableStatus, bool:changeSession = true, bool:changeSessionLocation = true)
	- Mode_GetShortName(modeid)
	- Mode_GetFullName(modeid)
	- Mode_GetEnableStatus(modeid)
	- Mode_GetMaxSessions(modeid)
	- Mode_GetMaxSessionPlayers(modeid)
	- Mode_GetChangeEnableStatus(modeid)
	- Mode_GetChangeSession(modeid)
	- Mode_GetChangeSessionLocation(modeid)

	- Mode_SetInfo(modeid, const info[])
	- Mode_GetInfo(modeid)

	- Mode_SetVirtualWorld(modeid, worldid)
	- Mode_GetVirtualWorld(modeid)

	- Mode_SetInterior(modeid, interiorid)
	- Mode_GetInterior(modeid)

	# Session #
	- Mode_CreateSession(modeid, locationOne = GMS_LOCATION_UNKNOWN)
	- Mode_DestroySession(modeid, sessionid = -1)
	- Mode_DestroySessionDelay(modeid, sessionid = -1)
	- Mode_CreateFirstSessions(modeid)
	- Mode_GetLocationOne(modeid, sessionid)

	- Mode_SetSessionLocation(modeid, sessionid, locationid)
	- Mode_GetSessionLocation(modeid, sessionid)

	- Mode_SetSessionGameMode(modeid, sessionid, gamemodeid)
	- Mode_GetSessionGameMode(modeid, sessionid)

	- Mode_SetSessionWeather(modeid, sessionid, weatherid)
	- Mode_GetSessionWeather(modeid, sessionid)

	- Mode_SetSessionMinutes(modeid, sessionid, minutes)
	- Mode_GetSessionMinutes(modeid, sessionid)
	- Mode_SetSessionSeconds(modeid, sessionid, seconds)
	- Mode_GetSessionSeconds(modeid, sessionid)
	- Mode_SetSessionActiveTimer(modeid, sessionid, bool:type)
	- Mode_GetSessionActiveTimer(modeid, sessionid)

	- Mode_GetSessionVirtualWorld(modeid, sessionid)

	- Mode_SetSessionInterior(modeid, sessionid, interiorid)
	- Mode_GetSessionInterior(modeid, sessionid)

	# Location #
	- Mode_AddLocation(modeid, locationid, const name[])
	- Mode_GetLocationName(modeid, locationid)

	- Mode_SetLocationInfo(modeid, locationid, const info[])
	- Mode_GetLocationInfo(modeid, locationid)

	- Mode_SetLocationGameMode(modeid, locationid, gamemodeid)
	- Mode_GetLocationGameMode(modeid, locationid)

	- Mode_SetLocationWeather(modeid, locationid, weatherid)
	- Mode_GetLocationWeather(modeid, locationid)

	- Mode_SetLocationMinutes(modeid, locationid, minutes)
	- Mode_GetLocationMinutes(modeid, locationid)
	- Mode_SetLocationSeconds(modeid, locationid, seconds)
	- Mode_GetLocationSeconds(modeid, locationid)

	- Mode_SetLocationInterior(modeid, locationid, interiorid)
	- Mode_GetLocationInterior(modeid, locationid)

	# Game-mode #
	- Mode_AddGameMode(modeid, gamemodeid, const name[])
	- Mode_GetGameModeName(modeid, gamemodeid)

	- Mode_SetGameModeInfo(modeid, gamemodeid, const info[])
	- Mode_GetGameModeInfo(modeid, gamemodeid)

	# Player #
	- Mode_SetPlayerMode(playerid, modeid)
	- Mode_GetPlayerMode(playerid)
	- M_GP(playerid)

	- Mode_SetPlayerSession(playerid, sessionid)
	- Mode_GetPlayerSession(playerid)
	- M_GPS(playerid)

	- Mode_SetPlayerSlot(playerid, slotid)
	- Mode_GetPlayerSlot(playerid)
	- M_GPSlot(playerid)

	- Mode_SetPlayerVirtualWorld(playerid, modeid, sessionid)
	- Mode_SetPlayerInterior(playerid, modeid, sessionid)
	- Mode_SetPlayerWeather(playerid, modeid, sessionid)

	- Mode_GetPlayers(modeid)
	- Mode_GetAdmins(modeid)
	- Mode_GetSessionPlayers(modeid)
	- Mode_GetSessionAdmins(modeid)
	- Mode_GetSessionSlot(modeid, sessionid, slotid)

	- Mode_EnterPlayer(playerid, modeid, sessionid) 
	- Mode_LeavePlayer(playerid)

	- Mode_AddAdmin(modeid, sessionid)
	- Mode_ReduceAdmin(modeid, sessionid)

	- Mode_CreateSessionLocation(modeid, sessionid, locationid)
	- Mode_DestroySessionLocation(modeid, sessionid)
	- Mode_CreatePlayerLocation(playerid, modeid, sessionid, bool:set = true)
	- Mode_DestroyPlayerLocation(playerid, bool:reset = true)

	- Mode_UpdateModesData()
	- Mode_UpdateModesData2()

	- Mode_GetMaxQuestsProgress(modeid)
	- Mode_GetMaxQuests(modeid)
	- Mode_CheckQuestHead(playerid, modeid)

	- Mode_GivePlayerMatchKills(playerid, kills)
	- Mode_ResetPlayerMatchKills(playerid)
	- Mode_GetPlayerMatchKills(playerid)

	- Mode_GivePlayerMatchDeaths(playerid, deaths)
	- Mode_ResetPlayerMatchDeaths(playerid)
	- Mode_GetPlayerMatchDeaths(playerid)

	- Mode_GivePlayerMatchPoints(playerid, points)
	- Mode_ResetPlayerMacthPoints(playerid)
	- Mode_GetPlayerMatchPoints(playerid)

	- Mode_GivePlayerMatchExp(playerid, exp)
	- Mode_ResetPlayerMatchExp(playerid)
	- Mode_GetPlayerMatchExp(playerid)

	- Mode_GivePlayerMatchMoney(playerid, money)
	- Mode_ResetPlayerMatchMoney(playerid)
	- Mode_GetPlayerMatchMoney(playerid)

	- Mode_CreatePlAEElements(playerid)
	- Mode_DestroyPlAEElements(playerid)

	- Mode_SetPlAEValues(playerid)
	- Mode_ResetPlAEValues(playerid)

	- Mode_SetAEValue(modeid, sessionid, cell, value)
	- Mode_GetAEValue(modeid, sessionid, cell)
	- Mode_SetAEFloatValues(modeid, sessionid, cell, Float:X, Float:Y, Float:Z)
	- Mode_GetAEFloatValues(modeid, sessionid, cell, num)

	- Mode_SetPlAEValue(playerid, cell, value)
	- Mode_GetPlAEValue(playerid, cell)
	- Mode_SetPlAEFloatValue(playerid, cell, Float:X, Float:Y, Float:Z)
	- Mode_GetPlAEFloatValue(playerid, cell, &Float:X, &Float:Y, &Float:Z)

	- Mode_CreatePlAE3DText(playerid, cell, const name[], color, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid_2, vehicleid, lost)
	- Mode_DestroyPlAE3DText(playerid, cell = -1)
	- Mode_ResetPlAE3DTexts(playerid, cell = -1)
	- Mode_UpdatePlAE3DText(playerid, cell, color, text[])

	- Mode_CreatePlAEObject(p_object, cell, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
	- Mode_DestroyPlAEObject(playerid, cell = -1)
	- Mode_SetPlAEObjectMaterial(playerid, cell, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0)
	- Mode_MovePlAEObject(playerid, cell, Float:x, Float:y, Float:z, Float:speed, Float:rx = -1000.0, Float:ry = -1000.0, Float:rz = -1000.0)
	- Mode_GetPlAEObjectPos(playerid, cell, &Float:x, &Float:y, &Float:z)

	- Mode_ShowPlayerMatchPointsTD(playerid)
	- Mode_DestroyPlayerMatchPointsTD(playerid)

	- Mode_ShowPlSessionTimerTD(playerid) 
	- Mode_DestroyPlSessionTimerTD(playerid)

	- Mode_UpdatePlayerMG(playerid)
	- Mode_SetPlayerKeyAE3DText(playerid, modeid, locationid, p3dtext, textid)
	- Mode_GetPlayerSkin(playerid, modeid)
	- Mode_GetModeTimeRespawn(modeid)
	- Mode_SetAddSpeedRespawn(playerid)
	- Mode_UpdatePlayerData(playerid)
	- Mode_GivePlayerReward(playerid, exp, money)
	- Mode_SetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
	- Mode_ResetPlayerMG(playerid)
	- Mode_UpdateSpectateStatus(playerid, spectedid)
	- Mode_GivePlayerWeapon(playerid, WEAPON:weaponid, ammo)

	- Mode_IsPlayerInPlayer(playerid, playerid_2)
	- Mode_SendPlayerChatText(playerid, const text[])
	- Mode_CheckOnPlayerKey(playerid)
	- Mode_StreamerUpdate(modeid, sessionid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_GMS_INFO
	- E_GMS_MODE_INFO
	- E_GMS_SESSION_INFO
	- E_GMS_LOCATION_INFO
	- E_PLAYER_GMS_AE_3DTEXT_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- rep(playerid)
	- hp(playerid, params[])
	- accode(playerid)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- Mode_SelectPlaySession
	- Mode_SelectMode
	- Mode_SelectSettingsMode
	- Mode_InfoMode
	- Mode_SelectSession
	- Mode_SelectSettingsSession
	- Mode_InfoSession
	- Mode_ChangeSessionLocation
	- Mode_ChangeSessionWeather
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_MODES_MAIN
	#endinput
#endif
#define _INC_MODES_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_GMS_INFO {
	e_Mode,
	e_Session,
	e_Slot,

	e_MatchKills,
	e_MatchDeaths,
	e_MatchExp,
	e_MatchMoney,
	e_MatchPoints
}

enum E_GMS_MODE_INFO {
	e_ShortName[GMS_MAX_LENGTH_MODE_SHORT_NAME],
	e_FullName[GMS_MAX_LENGTH_MODE_FULL_NAME],
	e_Info[GMS_MAX_LENGTH_MODE_INFO],
	e_MaxSessions,
	e_SessionMaxPlayers,
	bool:e_EnableStatus,
	bool:e_ActiveEnableStatus,
	bool:e_ActiveChangeSession,
	bool:e_ActiveChangeSessionLocation,
	e_VirtualWorld,
	e_Interior
}

enum E_GMS_SESSION_INFO {
	e_LocationOne,
	e_Location,
	e_GameMode,
	e_Weather,
	e_Minutes,
	e_Seconds,
	bool:e_ActiveTimer,
	e_Interior
}

enum E_GMS_LOCATION_INFO {
	e_Name[GMS_MAX_LENGTH_LOC_NAME],
	e_Info[GMS_MAX_LENGTH_LOC_INFO],
	e_GameMode,
	e_Weather,
	e_Minutes,
	e_Seconds,
	e_Interior
}

enum E_GMS_GAME_MODE_INFO {
	e_Name[GMS_MAX_LENGTH_GAME_MODE_NAME],
	e_Info[GMS_MAX_LENGTH_GAME_MODE_INFO]
}

enum E_PLAYER_GMS_AE_3DTEXT_INFO {
	e_Name[GMS_MAX_LEN_AE_3DTEXT_NAME],
	e_Color,
	e_TypeClick, // 0 - No / 1 - ALT
	Text3D:e_3DText,
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ,
	Float:e_Radius,
	e_PlayerID,
	e_VehicleID,
	e_LOST,
	bool:e_Created
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_GMS_INFO];

static
	modeInfo[GMS_MAX_MODES][E_GMS_MODE_INFO],
	sessionInfo[GMS_MAX_MODES][GMS_MAX_SESSIONS][E_GMS_SESSION_INFO],
	locInfo[GMS_MAX_MODES][GMS_MAX_LOCATIONS][E_GMS_LOCATION_INFO],
	gamemodeInfo[GMS_MAX_MODES][GMS_MAX_GAME_MODES][E_GMS_GAME_MODE_INFO];

static
	PlayersInMode[GMS_MAX_MODES],
	AdminsInMode[GMS_MAX_MODES],

	PlayersInSession[GMS_MAX_MODES][GMS_MAX_SESSIONS],
	AdminsInSession[GMS_MAX_MODES][GMS_MAX_SESSIONS];

static
	SessionSlot[GMS_MAX_MODES][GMS_MAX_SESSIONS][GMS_MAX_SESSION_SLOTS];

static
	PlayerDialogModes[MAX_PLAYERS][GMS_MAX_MODES],
	PlayerDialogSessions[MAX_PLAYERS][GMS_MAX_SESSIONS],
	PlayerDialogLocations[MAX_PLAYERS][GMS_MAX_LOCATIONS];

static
	PlayerAE3DText[MAX_PLAYERS][GMS_MAX_PLAYER_AE_3DTEXTS][E_PLAYER_GMS_AE_3DTEXT_INFO];

static
	PlayerText:TD_MatchPoints[MAX_PLAYERS] = {PlayerText:INVALID_PLAYER_TEXT_DRAW, ...};

static
	PlayerText:TD_SessionTimer[MAX_PLAYERS] = {PlayerText:INVALID_PLAYER_TEXT_DRAW, ...};

static
	PlayerAEObject[MAX_PLAYERS][GMS_MAX_PLAYER_AE_OBJECTS];

static
	ModeAEValue[GMS_MAX_MODES][GMS_MAX_SESSIONS][GMS_MAX_AE_VALUES],
	Float:ModeAEFloatValue[GMS_MAX_MODES][GMS_MAX_SESSIONS][GMS_MAX_AE_VALUES][3],

	PlayerAEValue[MAX_PLAYERS][GMS_MAX_AE_VALUES],
	Float:PlayerAEFloatValue[MAX_PLAYERS][GMS_MAX_AE_VALUES][3];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>------------<|
 * |   Add mode   |
 * |>------------<|
 */

stock Mode_Add(modeid, const shortName[], const fullName[], bool:enableStatus, sessionMaxPlayers, maxSessions, bool:changeEnableStatus, bool:changeSession, bool:changeSessionLocation)
{
	// Name
	strcopy(modeInfo[modeid][e_ShortName], shortName, GMS_MAX_LENGTH_MODE_SHORT_NAME);
	strcopy(modeInfo[modeid][e_FullName], fullName, GMS_MAX_LENGTH_MODE_FULL_NAME);

	modeInfo[modeid][e_EnableStatus] = enableStatus;
	modeInfo[modeid][e_MaxSessions] = maxSessions;
	modeInfo[modeid][e_SessionMaxPlayers] = sessionMaxPlayers;
	modeInfo[modeid][e_ActiveEnableStatus] = changeEnableStatus;
	modeInfo[modeid][e_ActiveChangeSession] = changeSession;
	modeInfo[modeid][e_ActiveChangeSessionLocation] = changeSessionLocation;

	// Virtual world & interior
	modeInfo[modeid][e_VirtualWorld] = modeid * 1000;
	modeInfo[modeid][e_Interior] = 0;

	// Iterator
	Iter_Add(Modes, modeid);
	return 1;
}

stock Mode_GetShortName(modeid)
{
	new
		str[GMS_MAX_LENGTH_MODE_SHORT_NAME];

	strcopy(str, modeInfo[modeid][e_ShortName], GMS_MAX_LENGTH_MODE_SHORT_NAME);
	return str;
}

stock Mode_GetFullName(modeid)
{
	new
		str[GMS_MAX_LENGTH_MODE_FULL_NAME];

	strcopy(str, modeInfo[modeid][e_FullName], GMS_MAX_LENGTH_MODE_FULL_NAME);
	return str;
}

stock Mode_GetEnableStatus(modeid)
{
	return modeInfo[modeid][e_EnableStatus];
}

stock Mode_GetMaxSessions(modeid)
{
	return modeInfo[modeid][e_MaxSessions];
}

stock Mode_GetMaxSessionPlayers(modeid)
{
	return modeInfo[modeid][e_SessionMaxPlayers];
}

stock Mode_GetChangeEnableStatus(modeid)
{
	return modeInfo[modeid][e_ActiveEnableStatus];
}

stock Mode_GetChangeSession(modeid)
{
	return modeInfo[modeid][e_ActiveChangeSession];
}

stock Mode_GetChangeSessionLocation(modeid)
{
	return modeInfo[modeid][e_ActiveChangeSessionLocation];
}

/*
 * |>-------------<|
 * |   Info mode   |
 * |>-------------<|
 */

stock Mode_SetInfo(modeid, const info[])
{
	strcopy(modeInfo[modeid][e_Info], info, GMS_MAX_LENGTH_MODE_INFO);
	return 1;
}

stock Mode_GetInfo(modeid)
{
	new
		str[GMS_MAX_LENGTH_MODE_INFO];

	strcopy(str, modeInfo[modeid][e_Info], GMS_MAX_LENGTH_MODE_INFO);
	return str;
}

/*
 * |>----------------------<|
 * |   Virtual world mode   |
 * |>----------------------<|
 */

stock Mode_SetVirtualWorld(modeid, worldid)
{
	modeInfo[modeid][e_VirtualWorld] = worldid;
	return 1;
}

stock Mode_GetVirtualWorld(modeid, worldid)
{
	return modeInfo[modeid][e_VirtualWorld];
}

/*
 * |>-----------------<|
 * |   Interior mode   |
 * |>-----------------<|
 */

stock Mode_SetInterior(modeid, interiorid)
{
	modeInfo[modeid][e_Interior] = interiorid;
	return 1;
}

stock Mode_GetInterior(modeid)
{
	return modeInfo[modeid][e_Interior];
}

/*
 * |>----------------------------<|
 * |   Create & destroy session   |
 * |>----------------------------<|
 */

stock Mode_CreateSession(modeid, locationOne = GMS_LOCATION_UNKNOWN)
{
	new
		sessionid;

	// Finding a free value
	n_for(i, GMS_MAX_SESSIONS) {
		if (!Iter_Contains(Sessions[modeid], i)) {
			Iter_Add(Sessions[modeid], i);
			sessionid = i;
			break;
		}
	}

	// Parameters
	sessionInfo[modeid][sessionid][e_LocationOne] = locationOne;

	// Custom
	CustomCreateSession(modeid, sessionid);
	return sessionid;
}

stock Mode_DestroySession(modeid, sessionid = -1)
{
	if (sessionid != -1) {
		if (!Iter_Contains(Sessions[modeid], sessionid)) {
			return 1;
		}

		DestroySingleSession(modeid, sessionid, true);
		return 1;
	}

	foreach (new s:Sessions[modeid]) {
		DestroySingleSession(modeid, s, false);
	}

	Iter_Clear(Sessions[modeid]);
	return 1;
}

stock Mode_DestroySessionDelay(modeid, sessionid = -1)
{
	SetTimerEx("Mode_CallDestroySession", 1000, false, "ii", modeid, sessionid);
	return 1;
}

public: Mode_CallDestroySession(modeid, sessionid)
{
	Mode_DestroySession(modeid, sessionid);
	return 1;
}

static DestroySingleSession(modeid, sessionid, bool:removeIterator)
{
	// Players
	m_safe_for(modeid, sessionid, p) {
		Mode_LeavePlayer(p);
		Mode_EnterPlayer(p, MODE_NONE, 0);
	}

	// Session
	Mode_DestroySessionLocation(modeid, sessionid);
	ResetSessionCoreData(modeid, sessionid);

	// Custom
	CustomDestroySingleSession(modeid, sessionid);

	// Iterator
	if (removeIterator) {
		Iter_Remove(Sessions[modeid], sessionid);
	}
	return 1;
}

stock Mode_CreateFirstSessions(modeid)
{
	// Custom
	CustomCreateFirstSessions(modeid);
	return 1;
}

// Parameter indicating whether there will be only one location in the session
stock Mode_GetLocationOne(modeid, sessionid)
{
	return sessionInfo[modeid][sessionid][e_LocationOne];
}

/*
 * |>--------------------<|
 * |   Location session   |
 * |>--------------------<|
 */

stock Mode_SetSessionLocation(modeid, sessionid, locationid)
{
	sessionInfo[modeid][sessionid][e_Location] = locationid;
	return 1;
}

stock Mode_GetSessionLocation(modeid, sessionid)
{
	return sessionInfo[modeid][sessionid][e_Location];
}

/*
 * |>---------------------<|
 * |   Game-mode session   |
 * |>---------------------<|
 */

stock Mode_SetSessionGameMode(modeid, sessionid, gamemodeid)
{
	sessionInfo[modeid][sessionid][e_GameMode] = gamemodeid;
	return 1;
}

stock Mode_GetSessionGameMode(modeid, sessionid)
{
	return sessionInfo[modeid][sessionid][e_GameMode];
}

/*
 * |>-------------------<|
 * |   Weather session   |
 * |>-------------------<|
 */

stock Mode_SetSessionWeather(modeid, sessionid, weatherid)
{
	sessionInfo[modeid][sessionid][e_Weather] = weatherid;

	m_for(modeid, sessionid, p) {
		SetPlayerWeatherEx(p, weatherid);
	}
	return 1;
}

stock Mode_GetSessionWeather(modeid, sessionid)
{
	return sessionInfo[modeid][sessionid][e_Weather];
}

/*
 * |>-----------------------------<|
 * |   Minutes & seconds session   |
 * |>-----------------------------<|
 */

stock Mode_SetSessionMinutes(modeid, sessionid, minutes)
{
	sessionInfo[modeid][sessionid][e_Minutes] = minutes;
	return 1;
}

stock Mode_GetSessionMinutes(modeid, sessionid)
{
	return sessionInfo[modeid][sessionid][e_Minutes];
}

stock Mode_SetSessionSeconds(modeid, sessionid, seconds)
{
	sessionInfo[modeid][sessionid][e_Seconds] = seconds;
	return 1;
}

stock Mode_GetSessionSeconds(modeid, sessionid)
{
	return sessionInfo[modeid][sessionid][e_Seconds];
}

stock Mode_SetSessionActiveTimer(modeid, sessionid, bool:type)
{
	sessionInfo[modeid][sessionid][e_ActiveTimer] = type;
	return 1;
}

stock Mode_GetSessionActiveTimer(modeid, sessionid)
{
	return sessionInfo[modeid][sessionid][e_ActiveTimer];
}

/*
 * |>-------------------------<|
 * |   Virtual world session   |
 * |>-------------------------<|
 */

stock Mode_GetSessionVirtualWorld(modeid, sessionid)
{
	return modeInfo[modeid][e_VirtualWorld] + sessionid;
}

/*
 * |>--------------------<|
 * |   Interior session   |
 * |>--------------------<|
 */

stock Mode_SetSessionInterior(modeid, sessionid, interiorid)
{
	sessionInfo[modeid][sessionid][e_Interior] = interiorid;
	return 1;
}

stock Mode_GetSessionInterior(modeid, sessionid)
{
	return sessionInfo[modeid][sessionid][e_Interior];
}

/*
 * |>----------------<|
 * |   Add location   |
 * |>----------------<|
 */

stock Mode_AddLocation(modeid, locationid, const name[])
{
	strcopy(locInfo[modeid][locationid][e_Name], name, GMS_MAX_LENGTH_LOC_NAME);

	// Iterator
	Iter_Add(Locations[modeid], locationid);
	return 1;
}

stock Mode_GetLocationName(modeid, locationid)
{
	new
		str[GMS_MAX_LENGTH_LOC_NAME];

	strcopy(str, locInfo[modeid][locationid][e_Name], GMS_MAX_LENGTH_LOC_NAME);
	return str;
}

/*
 * |>-----------------<|
 * |   Info location   |
 * |>-----------------<|
 */

stock Mode_SetLocationInfo(modeid, locationid, const info[])
{
	strcopy(locInfo[modeid][locationid][e_Info], info, GMS_MAX_LENGTH_LOC_INFO);
	return 1;
}

stock Mode_GetLocationInfo(modeid, locationid)
{
	new
		str[GMS_MAX_LENGTH_LOC_INFO];

	strcopy(str, locInfo[modeid][locationid][e_Info], GMS_MAX_LENGTH_LOC_INFO);
	return str;
}

/*
 * |>----------------------<|
 * |   Game-mode location   |
 * |>----------------------<|
 */

stock Mode_SetLocationGameMode(modeid, locationid, gamemodeid)
{
	locInfo[modeid][locationid][e_GameMode] = gamemodeid;
	return 1;
}

stock Mode_GetLocationGameMode(modeid, locationid)
{
	return locInfo[modeid][locationid][e_GameMode];
}

/*
 * |>--------------------<|
 * |   Weather location   |
 * |>--------------------<|
 */

stock Mode_SetLocationWeather(modeid, locationid, weatherid)
{
	locInfo[modeid][locationid][e_Weather] = weatherid;
	return 1;
}

stock Mode_GetLocationWeather(modeid, locationid)
{
	return locInfo[modeid][locationid][e_Weather];
}

/*
 * |>------------------------------<|
 * |   Minutes & seconds location   |
 * |>------------------------------<|
 */

stock Mode_SetLocationMinutes(modeid, locationid, minutes)
{
	locInfo[modeid][locationid][e_Minutes] = minutes;
	return 1;
}

stock Mode_GetLocationMinutes(modeid, locationid)
{
	return locInfo[modeid][locationid][e_Minutes];
}

stock Mode_SetLocationSeconds(modeid, locationid, seconds)
{
	locInfo[modeid][locationid][e_Seconds] = seconds;
	return 1;
}

stock Mode_GetLocationSeconds(modeid, locationid)
{
	return locInfo[modeid][locationid][e_Seconds];
}

/*
 * |>---------------------<|
 * |   Interior location   |
 * |>---------------------<|
 */

stock Mode_SetLocationInterior(modeid, locationid, interiorid)
{
	locInfo[modeid][locationid][e_Interior] = interiorid;
	return 1;
}

stock Mode_GetLocationInterior(modeid, locationid)
{
	return locInfo[modeid][locationid][e_Interior];
}

/*
 * |>-----------------<|
 * |   Add game-mode   |
 * |>-----------------<|
 */

stock Mode_AddGameMode(modeid, gamemodeid, const name[])
{
	strcopy(gamemodeInfo[modeid][gamemodeid][e_Name], name, GMS_MAX_LENGTH_GAME_MODE_NAME);

	// Iterator
	Iter_Add(GameModes[modeid], gamemodeid);
	return 1;
}

stock Mode_GetGameModeName(modeid, gamemodeid)
{
	new
		str[GMS_MAX_LENGTH_GAME_MODE_NAME];

	strcopy(str, gamemodeInfo[modeid][gamemodeid][e_Name], GMS_MAX_LENGTH_GAME_MODE_NAME);
	return str;
}

/*
 * |>------------------<|
 * |   Info game-mode   |
 * |>------------------<|
 */

stock Mode_SetGameModeInfo(modeid, gamemodeid, const info[])
{
	strcopy(gamemodeInfo[modeid][gamemodeid][e_Info], info, GMS_MAX_LENGTH_GAME_MODE_INFO);
	return 1;
}

stock Mode_GetGameModeInfo(modeid, gamemodeid)
{
	new
		str[GMS_MAX_LENGTH_GAME_MODE_INFO];

	strcopy(str, gamemodeInfo[modeid][gamemodeid][e_Info], GMS_MAX_LENGTH_GAME_MODE_INFO);
	return str;
}

/*
 * |>--------------------------------<|
 * |   Player mode & session & slot   |
 * |>--------------------------------<|
 */

stock Mode_SetPlayerMode(playerid, modeid)
{
	pInfo[playerid][e_Mode] = modeid;
	return 1;
}

stock Mode_GetPlayerMode(playerid)
{
	return pInfo[playerid][e_Mode];
}

stock M_GP(playerid)
{
	return pInfo[playerid][e_Mode];
}

stock Mode_SetPlayerSession(playerid, sessionid)
{
	pInfo[playerid][e_Session] = sessionid;
	return 1;
}

stock Mode_GetPlayerSession(playerid)
{
	return pInfo[playerid][e_Session];
}

stock M_GPS(playerid)
{
	return pInfo[playerid][e_Session];
}

stock Mode_SetPlayerSlot(playerid, slotid)
{
	pInfo[playerid][e_Slot] = slotid;
	return 1;
}

stock Mode_GetPlayerSlot(playerid)
{
	return pInfo[playerid][e_Slot];
}

stock M_GPSlot(playerid)
{
	return pInfo[playerid][e_Slot];
}

/*
 * |>---------------------------------------------<|
 * |   Player virtual world & interior & weather   |
 * |>---------------------------------------------<|
 */

stock Mode_SetPlayerVirtualWorld(playerid, modeid, sessionid)
{
	SetPlayerVirtualWorldEx(playerid, Mode_GetSessionVirtualWorld(modeid, sessionid));
	return 1;
}

stock Mode_SetPlayerInterior(playerid, modeid, sessionid)
{
	SetPlayerInteriorEx(playerid, Mode_GetSessionInterior(modeid, sessionid));
	return 1;
}

stock Mode_SetPlayerWeather(playerid, modeid, sessionid)
{
	SetPlayerWeatherEx(playerid, Mode_GetSessionWeather(modeid, sessionid));
	return 1;
}

/*
 * |>--------------------------------------<|
 * |   Players & admins in mode & session   |
 * |>--------------------------------------<|
 */

stock Mode_GetPlayers(modeid)
{
	return PlayersInMode[modeid];
}

stock Mode_GetAdmins(modeid)
{
	return AdminsInMode[modeid];
}

stock Mode_GetSessionPlayers(modeid, sessionid)
{
	return PlayersInSession[modeid][sessionid];
}

stock Mode_GetSessionAdmins(modeid, sessionid)
{
	return AdminsInSession[modeid][sessionid];
}

stock Mode_GetSessionSlot(modeid, sessionid, slotid)
{
	return SessionSlot[modeid][sessionid][slotid];
}

/*
 * |>-----------------------------<|
 * |   Player mode enter & leave   |
 * |>-----------------------------<|
 */

stock Mode_EnterPlayer(playerid, modeid, sessionid) 
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	if (Mode_GetPlayerMode(playerid) != -1) {
		return 0;
	}

	// Add
	PlayersInMode[modeid]++;
	PlayersInSession[modeid][sessionid]++;

	// Admin
	if (GetAdminLevel(playerid) != ADM_LEVEL_NONE) {
		Mode_AddAdmin(modeid, sessionid);
	}

	// Entering
	n_for(i, GMS_MAX_SESSION_SLOTS) {
		if (SessionSlot[modeid][sessionid][i] != INVALID_PLAYER_ID) {
			continue;
		}

		SessionSlot[modeid][sessionid][i] = playerid;
		pInfo[playerid][e_Slot] = i;
		break;
	}

	pInfo[playerid][e_Mode] = modeid;
	pInfo[playerid][e_Session] = sessionid;

	// Create location
	Mode_CreatePlayerLocation(playerid, modeid, sessionid);

	// Admins
	if (IsAdminsSpecPlayer(playerid)) {
		foreach (new p:AdminCountSpecPlayer[playerid]) {
			Mode_EnterPlayer(p, modeid, sessionid);
		}
	}
	return 1;
}

stock Mode_LeavePlayer(playerid)
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	if (Mode_GetPlayerMode(playerid) == -1) {
		return 0;
	}

	new
		modeid = pInfo[playerid][e_Mode],
		sessionid = pInfo[playerid][e_Session],
		slotid = pInfo[playerid][e_Slot];

	// Destroy location
	Mode_DestroyPlayerLocation(playerid);

	// Reduce
	PlayersInMode[modeid]--;
	PlayersInSession[modeid][sessionid]--;

	// Admin
	if (GetAdminLevel(playerid) != ADM_LEVEL_NONE) {
		Mode_ReduceAdmin(modeid, sessionid);
	}

	// Leaving
	SessionSlot[modeid][sessionid][slotid] = SessionSlot[modeid][sessionid][PlayersInSession[modeid][sessionid]];
	pInfo[SessionSlot[modeid][sessionid][slotid]][e_Slot] = slotid;
	SessionSlot[modeid][sessionid][PlayersInSession[modeid][sessionid]] = INVALID_PLAYER_ID;

	pInfo[playerid][e_Mode] = -1;
	pInfo[playerid][e_Session] =
	pInfo[playerid][e_Slot] = 0;

	// Admins
	if (IsAdminsSpecPlayer(playerid)) {
		foreach (new p:AdminCountSpecPlayer[playerid]) {
			Mode_LeavePlayer(p);
		}
	}
	return 1;
}

/*
 * |>---------------------------<|
 * |   Admin mode add & reduce   |
 * |>---------------------------<|
 */

stock Mode_AddAdmin(modeid, sessionid)
{
	AdminsInMode[modeid]++;
	AdminsInSession[modeid][sessionid]++;
	return 1;
}

stock Mode_ReduceAdmin(modeid, sessionid)
{
	AdminsInMode[modeid]--;
	AdminsInSession[modeid][sessionid]--;
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Location create & destroy   |
 * |>-----------------------------<|
 */

stock Mode_CreateSessionLocation(modeid, sessionid, locationid)
{
	if (Mode_GetSessionLocation(modeid, sessionid) != GMS_LOCATION_UNKNOWN) {
		return 0;
	}

	// Creating a location
	Mode_SetSessionLocation(modeid, sessionid, locationid);
	Mode_SetSessionGameMode(modeid, sessionid, Mode_GetLocationGameMode(modeid, locationid));
	Mode_SetSessionWeather(modeid, sessionid, Mode_GetLocationWeather(modeid, locationid));
	Mode_SetSessionMinutes(modeid, sessionid, Mode_GetLocationMinutes(modeid, locationid));
	Mode_SetSessionSeconds(modeid, sessionid, Mode_GetLocationSeconds(modeid, locationid));

	if (Mode_GetSessionMinutes(modeid, sessionid) > 0
	|| Mode_GetSessionSeconds(modeid, sessionid) > 0) {
		Mode_SetSessionActiveTimer(modeid, sessionid, true);
	}

	Mode_SetSessionInterior(modeid, sessionid, Mode_GetLocationInterior(modeid, locationid));

	// Custom
	CustomCreateSessionLocation(modeid, sessionid, locationid);

	// Players
	m_for(modeid, sessionid, p) {
		Mode_CreatePlayerLocation(p, modeid, sessionid);
	}
	return 1;
}

stock Mode_DestroySessionLocation(modeid, sessionid)
{
	if (Mode_GetSessionLocation(modeid, sessionid) == GMS_LOCATION_UNKNOWN) {
		return 0;
	}

	// Players
	m_for(modeid, sessionid, p) {
		Mode_DestroyPlayerLocation(p);
	}

	// Custom
	CustomDestroySessionLocation(modeid, sessionid);

	Mode_SetSessionLocation(modeid, sessionid, GMS_LOCATION_UNKNOWN);
	Mode_SetSessionGameMode(modeid, sessionid, 0);
	Mode_SetSessionWeather(modeid, sessionid, 0);
	Mode_SetSessionMinutes(modeid, sessionid, 0);
	Mode_SetSessionSeconds(modeid, sessionid, 0);
	Mode_SetSessionActiveTimer(modeid, sessionid, false);
	Mode_SetSessionInterior(modeid, sessionid, 0);
	return 1;
}

stock Mode_CreatePlayerLocation(playerid, modeid, sessionid)
{
	Mode_SetPlayerVirtualWorld(playerid, modeid, sessionid);
	Mode_SetPlayerInterior(playerid, modeid, sessionid);
	Mode_SetPlayerWeather(playerid, modeid, sessionid);

	CreatePlayerBaseIndicatorsTD(playerid);
	CreatePlayerNetGraphTD(playerid);

	// Indicator health weapon-config
	if (GetIndicatorHealth() == PLAYER_IND_HEALTH_WC) {
		EnableHealthBarForPlayer(playerid, true);
	}
	else {
		EnableHealthBarForPlayer(playerid, false);
	}

	// Custom
	CustomCreatePlayerLocation(playerid, modeid, sessionid);

	Mode_CreatePlAEElements(playerid);
	return 1;
}

stock Mode_DestroyPlayerLocation(playerid)
{
	new
		modeid = Mode_GetPlayerMode(playerid);

	if (!GetAdminSpectating(playerid)) {	
		PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
		ClosePlayerDialog(playerid);
	}

	Mode_DestroyPlAEElements(playerid);

	// Custom
	CustomDestroyPlayerLocation(playerid, modeid);

	Mode_SetPlayerVirtualWorld(playerid, MODE_NONE, 0);
	Mode_SetPlayerInterior(playerid, MODE_NONE, 0);
	Mode_SetPlayerWeather(playerid, MODE_NONE, 0);

	Mode_ResetPlayerMatchKills(playerid);
	Mode_ResetPlayerMatchDeaths(playerid);
	Mode_ResetPlayerMacthPoints(playerid);
	Mode_ResetPlayerMatchExp(playerid);
	Mode_ResetPlayerMatchMoney(playerid);

	Mode_DestroyPlayerMatchPointsTD(playerid);
	Mode_DestroyPlSessionTimerTD(playerid);

	DestroyPlayerBaseIndicatorsTD(playerid);
	DestroyPlayerNetGraphTD(playerid);

	DestroyPlayerAttachedObjects(playerid);
	DestroyPlayerMatchStatsTD(playerid);
	DestroyPlayerBelowHealth(playerid);
	DestroyPlayerSpawnKill(playerid);
	DestroyPlayerReward(playerid);
	DeletePlayerDamageIndicator(playerid);
	DestroyPlayerDropWeapon(playerid);
	DestroyPlayerDropToken(playerid);

	HidePlayerKillStrike(playerid);
	HidePlayerExitZone(playerid);

	ResetPlayerWeaponsEx(playerid);
	ResetPlayerKillStrike(playerid);
	ResetPlayerDamageBody(playerid);
	ResetPlayerMGData(playerid);
	ClosePlayerDialog(playerid);
	ClearKillFeed(playerid);
	CheckSpectatingPlayers(playerid, INVALID_PLAYER_ID);
	
	SetPlayerActionZone(playerid, false);
	SetPlayerCustomClass(playerid, -1);
	SetPlayerCustomClass2(playerid, -1);

	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerTeamEx(playerid, 0);
	SetPlayerColorEx(playerid, 0xCCCCCC00);

	// Save MySQL data
	SavePlayerData(playerid);
	SavePlayerQuests(playerid, modeid);
	return 1;
}

/*
 * |>-----------------<|
 * |   Timers update   |
 * |>-----------------<|
 */

stock Mode_UpdateModesData()
{
	foreach (new s:Sessions[MODE_ROOM]) {
		Room_UpdateModeData(s);
	}

	foreach (new s:Sessions[MODE_TDM]) {
		TDM_UpdateModeData(s);
	}

	foreach (new s:Sessions[MODE_DM]) {
		DM_UpdateModeData(s);
	}

	foreach (new s:Sessions[MODE_EXAMPLE]) {
		Example_UpdateModeData(s);
	}
	return 1;
}

stock Mode_UpdateModesData2()
{
	foreach (new s:Sessions[MODE_TDM]) {
		TDM_UpdateAirData(s);
	}
	return 1;
}

/*
 * |>----------<|
 * |   Quests   |
 * |>----------<|
 */

stock Mode_GetMaxQuestsProgress(modeid)
{
	// Custom
	return CustomGetMaxQuestsProgress(modeid);
}

stock Mode_GetMaxQuests(modeid)
{
	// Custom
	return CustomGetMaxQuests(modeid);
}

stock Mode_CheckQuestHead(playerid, modeid)
{
	// Custom
	CustomCheckQuestHead(playerid, modeid);
	return 1;
}

/*
 * |>----------------------<|
 * |   Player match kills   |
 * |>----------------------<|
 */

stock Mode_GivePlayerMatchKills(playerid, kills)
{
	pInfo[playerid][e_MatchKills] += kills;
	return 1;
}

stock Mode_ResetPlayerMatchKills(playerid)
{
	pInfo[playerid][e_MatchKills] = 0;
	return 1;
}

stock Mode_GetPlayerMatchKills(playerid) 
{
	return pInfo[playerid][e_MatchKills];
}

/*
 * |>-----------------------<|
 * |   Player match deaths   |
 * |>-----------------------<|
 */

stock Mode_GivePlayerMatchDeaths(playerid, deaths)
{
	pInfo[playerid][e_MatchDeaths] += deaths;
	return 1;
}

stock Mode_ResetPlayerMatchDeaths(playerid)
{
	pInfo[playerid][e_MatchDeaths] = 0;
	return 1;
}

stock Mode_GetPlayerMatchDeaths(playerid)
{
	return pInfo[playerid][e_MatchDeaths];
}

/*
 * |>-----------------------<|
 * |   Player match points   |
 * |>-----------------------<|
 */

stock Mode_GivePlayerMatchPoints(playerid, points)
{
	pInfo[playerid][e_MatchPoints] += points;
	Mode_UpdatePlayerMatchPointsTD(playerid);
	return 1;
}

stock Mode_ResetPlayerMacthPoints(playerid)
{
	pInfo[playerid][e_MatchPoints] = 0;
	return 1;
}

stock Mode_GetPlayerMatchPoints(playerid)
{
	return pInfo[playerid][e_MatchPoints];
}

/*
 * |>--------------------<|
 * |   Player match exp   |
 * |>--------------------<|
 */

stock Mode_GivePlayerMatchExp(playerid, exp)
{
	pInfo[playerid][e_MatchExp] += exp;
	return 1;
}

stock Mode_ResetPlayerMatchExp(playerid)
{
	pInfo[playerid][e_MatchExp] = 0;
	return 1;
}

stock Mode_GetPlayerMatchExp(playerid)
{
	return pInfo[playerid][e_MatchExp];
}

/*
 * |>----------------------<|
 * |   Player match money   |
 * |>----------------------<|
 */

stock Mode_GivePlayerMatchMoney(playerid, money)
{
	pInfo[playerid][e_MatchMoney] += money;
	return 1;
}

stock Mode_ResetPlayerMatchMoney(playerid)
{
	pInfo[playerid][e_MatchMoney] = 0;
	return 1;
}

stock Mode_GetPlayerMatchMoney(playerid)
{
	return pInfo[playerid][e_MatchMoney];
}

/*
 * |>---------------------------------------<|
 * |   Additional Elements (AE) for player   |
 * |>---------------------------------------<|
 */

stock Mode_CreatePlAEElements(playerid)
{
	Mode_SetPlAEValues(playerid);
	return 1;
}

stock Mode_DestroyPlAEElements(playerid)
{
	Mode_ResetPlAEValues(playerid);
	Mode_DestroyPlAEObject(playerid);
	Mode_DestroyPlAE3DText(playerid);
	return 1;
}

/*
 * |>----------<|
 * |   Values   |
 * |>----------<|
 */

stock Mode_SetPlAEValues(playerid)
{
	new
		modeid = Mode_GetPlayerMode(playerid),
		sessionid = Mode_GetPlayerSession(playerid);

	n_for(i, GMS_MAX_AE_VALUES) {
		PlayerAEValue[playerid][i] = ModeAEValue[modeid][sessionid][i];
	}

	n_for(i, GMS_MAX_AE_VALUES) {
		PlayerAEFloatValue[playerid][i][0] = ModeAEFloatValue[modeid][sessionid][i][0];
		PlayerAEFloatValue[playerid][i][1] = ModeAEFloatValue[modeid][sessionid][i][1];
		PlayerAEFloatValue[playerid][i][2] = ModeAEFloatValue[modeid][sessionid][i][2];
	}
	return 1;
}

stock Mode_ResetPlAEValues(playerid)
{
	n_for(i, GMS_MAX_AE_VALUES) {
		PlayerAEValue[playerid][i] = 0;
	}

	n_for(i, GMS_MAX_AE_VALUES) {
		PlayerAEFloatValue[playerid][i][0] =
		PlayerAEFloatValue[playerid][i][1] =
		PlayerAEFloatValue[playerid][i][2] = 0.0;
	}
	return 1;
}

stock Mode_SetAEValue(modeid, sessionid, cell, value)
{
	ModeAEValue[modeid][sessionid][cell] = value;
	return 1;
}

stock Mode_GetAEValue(modeid, sessionid, cell)
{
	return ModeAEValue[modeid][sessionid][cell];
}

stock Mode_SetAEFloatValues(modeid, sessionid, cell, Float:X, Float:Y, Float:Z)
{
	ModeAEFloatValue[modeid][sessionid][cell][0] = X;
	ModeAEFloatValue[modeid][sessionid][cell][1] = Y;
	ModeAEFloatValue[modeid][sessionid][cell][2] = Z;
	return 1;
}

stock Mode_GetAEFloatValues(modeid, sessionid, cell, num)
{
	return ModeAEFloatValue[modeid][sessionid][cell][num];
}

stock Mode_SetPlAEValue(playerid, cell, value)
{
	PlayerAEValue[playerid][cell] = value;
	return 1;
}

stock Mode_GetPlAEValue(playerid, cell)
{
	return PlayerAEValue[playerid][cell];
}

stock Mode_SetPlAEFloatValue(playerid, cell, Float:X, Float:Y, Float:Z)
{
	PlayerAEFloatValue[playerid][cell][0] = X;
	PlayerAEFloatValue[playerid][cell][1] = Y;
	PlayerAEFloatValue[playerid][cell][2] = Z;
	return 1;
}

stock Mode_GetPlAEFloatValue(playerid, cell, &Float:X, &Float:Y, &Float:Z)
{
	X = PlayerAEFloatValue[playerid][cell][0];
	Y = PlayerAEFloatValue[playerid][cell][1];
	Z = PlayerAEFloatValue[playerid][cell][2];
	return 1;
}

/*
 * |>-----------<|
 * |   3D Text   |
 * |>-----------<|
 */

stock Mode_CreatePlAE3DText(playerid, cell, const name[], color, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid_2, vehicleid, lost)
{
	if (PlayerAE3DText[playerid][cell][e_Created]) {
		return 0;
	}

	strins(PlayerAE3DText[playerid][cell][e_Name], name, 0);
	PlayerAE3DText[playerid][cell][e_Color] = color;
	PlayerAE3DText[playerid][cell][e_TypeClick] = typeclick;
	PlayerAE3DText[playerid][cell][e_PosX] = pos_x;
	PlayerAE3DText[playerid][cell][e_PosY] = pos_y;
	PlayerAE3DText[playerid][cell][e_PosZ] = pos_z;
	PlayerAE3DText[playerid][cell][e_Radius] = radius;
	PlayerAE3DText[playerid][cell][e_PlayerID] = playerid;
	PlayerAE3DText[playerid][cell][e_VehicleID] = vehicleid;
	PlayerAE3DText[playerid][cell][e_LOST] = lost;
	PlayerAE3DText[playerid][cell][e_Created] = true;

	PlayerAE3DText[playerid][cell][e_3DText] = CreateDynamic3DTextLabel(name, color, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid_2, vehicleid, lost, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	return 1;
}

stock Mode_DestroyPlAE3DText(playerid, cell = -1)
{
	if (cell == -1) {
		n_for(i, GMS_MAX_PLAYER_AE_3DTEXTS) {
			if (!PlayerAE3DText[playerid][i][e_Created]) {
				continue;
			}

			DestroyDynamic3DTextLabel(PlayerAE3DText[playerid][i][e_3DText]);
			Mode_ResetPlAE3DTexts(playerid, i);
		}
	}
	else {
		if (!PlayerAE3DText[playerid][cell][e_Created])
			return 0;

		DestroyDynamic3DTextLabel(PlayerAE3DText[playerid][cell][e_3DText]);
		Mode_ResetPlAE3DTexts(playerid, cell);
	}
	return 1;
}

stock Mode_ResetPlAE3DTexts(playerid, cell = -1)
{
	if (cell == -1) {
		n_for(i, GMS_MAX_PLAYER_AE_3DTEXTS) {
			PlayerAE3DText[playerid][i][e_Name][0] = EOS;
			PlayerAE3DText[playerid][i][e_Color] =
			PlayerAE3DText[playerid][i][e_TypeClick] = 0;
			PlayerAE3DText[playerid][i][e_PosX] =
			PlayerAE3DText[playerid][i][e_PosY] =
			PlayerAE3DText[playerid][i][e_PosZ] =
			PlayerAE3DText[playerid][i][e_Radius] = 0.0;
			PlayerAE3DText[playerid][i][e_PlayerID] =
			PlayerAE3DText[playerid][i][e_VehicleID] = -1;
			PlayerAE3DText[playerid][i][e_LOST] = 0;
			PlayerAE3DText[playerid][i][e_Created] = false;
			PlayerAE3DText[playerid][i][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		}
	}
	else {
		PlayerAE3DText[playerid][cell][e_Name][0] = EOS;
		PlayerAE3DText[playerid][cell][e_Color] =
		PlayerAE3DText[playerid][cell][e_TypeClick] = 0;
		PlayerAE3DText[playerid][cell][e_PosX] =
		PlayerAE3DText[playerid][cell][e_PosY] =
		PlayerAE3DText[playerid][cell][e_PosZ] =
		PlayerAE3DText[playerid][cell][e_Radius] = 0.0;
		PlayerAE3DText[playerid][cell][e_PlayerID] =
		PlayerAE3DText[playerid][cell][e_VehicleID] = -1;
		PlayerAE3DText[playerid][cell][e_LOST] = 0;
		PlayerAE3DText[playerid][cell][e_Created] = false;
		PlayerAE3DText[playerid][cell][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
	}
	return 1;
}

stock Mode_UpdatePlAE3DText(playerid, cell, color, text[])
{
	if (!PlayerAE3DText[playerid][cell][e_Created]) {
		return 0;
	}

	PlayerAE3DText[playerid][cell][e_Name][0] = EOS;

	strins(PlayerAE3DText[playerid][cell][e_Name], text, 0);
	UpdateDynamic3DTextLabelText(PlayerAE3DText[playerid][cell][e_3DText], color, text);
	return 1;
}

/*
 * |>----------<|
 * |   Object   |
 * |>----------<|
 */

stock Mode_CreatePlAEObject(p_object, cell, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
{
	if (IsValidDynamicObject(PlayerAEObject[p_object][cell])) {
		return 0;
	}

	PlayerAEObject[p_object][cell] = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
	return 1;
}

stock Mode_DestroyPlAEObject(playerid, cell = -1)
{
	if (cell == -1) {
		n_for(i, GMS_MAX_PLAYER_AE_OBJECTS) {
			if (!IsValidDynamicObject(PlayerAEObject[playerid][i])) {
				continue;
			}

			DestroyDynamicObject(PlayerAEObject[playerid][i]);
			PlayerAEObject[playerid][i] = INVALID_DYNAMIC_OBJECT_ID;
		}
	}
	else {
		if (!IsValidDynamicObject(PlayerAEObject[playerid][cell]))
			return 0;

		DestroyDynamicObject(PlayerAEObject[playerid][cell]);
		PlayerAEObject[playerid][cell] = INVALID_DYNAMIC_OBJECT_ID;
	}
	return 1;
}

stock Mode_SetPlAEObjectMaterial(playerid, cell, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0)
{
	if (!IsValidDynamicObject(PlayerAEObject[playerid][cell])) {
		return 0;
	}

	SetDynamicObjectMaterial(PlayerAEObject[playerid][cell], materialindex, modelid, txdname, texturename, materialcolor);
	return 1;
}

stock Mode_MovePlAEObject(playerid, cell, Float:x, Float:y, Float:z, Float:speed, Float:rx = -1000.0, Float:ry = -1000.0, Float:rz = -1000.0)
{
	if (!IsValidDynamicObject(PlayerAEObject[playerid][cell])) {
		return 0;
	}

	MoveDynamicObject(PlayerAEObject[playerid][cell], x, y, z, speed, rx, ry, rz);
	return 1;
}

stock Mode_GetPlAEObjectPos(playerid, cell, &Float:x, &Float:y, &Float:z)
{
	if (!IsValidDynamicObject(PlayerAEObject[playerid][cell])) {
		return 0;
	}

	GetDynamicObjectPos(PlayerAEObject[playerid][cell], x, y, z);
	return 1;
}

/*
 * |>----------------<|
 * |   Match points   |
 * |>----------------<|
 */

stock Mode_ShowPlayerMatchPointsTD(playerid)
{
	if (!IsValidPlayerTextDraw(playerid, TD_MatchPoints[playerid])) {
		Mode_CreatePlayerMatchPointsTD(playerid, TD_MatchPoints[playerid]);
	}

	PlayerTextDrawShow(playerid, TD_MatchPoints[playerid]);
	Mode_UpdatePlayerMatchPointsTD(playerid);
	return 1;
}

stock Mode_DestroyPlayerMatchPointsTD(playerid)
{
	if (!IsValidPlayerTextDraw(playerid, TD_MatchPoints[playerid])) {
		return 0;
	}

	DestroyPlayerTD(playerid, TD_MatchPoints[playerid]);
	return 1;
}

static Mode_UpdatePlayerMatchPointsTD(playerid)
{
	if (!IsPlayerTextDrawVisible(playerid, TD_MatchPoints[playerid])) {
		return 0;
	}

	PlayerTextDrawSetString(playerid, TD_MatchPoints[playerid], "Очков матча:_%i", pInfo[playerid][e_MatchPoints]);
	return 1;
}

/*
 * |>-----------------<|
 * |   Session timer   |
 * |>-----------------<|
 */

stock Mode_ShowPlSessionTimerTD(playerid) 
{
	if (!IsValidPlayerTextDraw(playerid, TD_SessionTimer[playerid])) {
		Mode_CreatePlSessionTimerTD(playerid, TD_SessionTimer[playerid]);
	}

	PlayerTextDrawShow(playerid, TD_SessionTimer[playerid]);
	return 1;
}

stock Mode_DestroyPlSessionTimerTD(playerid)
{
	if (!IsValidPlayerTextDraw(playerid, TD_SessionTimer[playerid])) {
		return 0;
	}

	DestroyPlayerTD(playerid, TD_SessionTimer[playerid]);
	return 1;
}

static Mode_UpdatePlSessionTimerTD(playerid)
{
	if (!IsPlayerTextDrawVisible(playerid, TD_SessionTimer[playerid])) {
		return 0;
	}

	new
		modeid = Mode_GetPlayerMode(playerid),
		sessionid = Mode_GetPlayerSession(playerid);

	new
		str[10];

	f(str, "%02d:%02d", Mode_GetSessionMinutes(modeid, sessionid), Mode_GetSessionSeconds(modeid, sessionid));
	PlayerTextDrawSetString(playerid, TD_SessionTimer[playerid], str);
	return 1;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

stock Mode_UpdatePlayerMG(playerid)
{
	// Custom
	CustomUpdatePlayerMG(playerid, Mode_GetPlayerMode(playerid));
	return 1;
}

stock Mode_SetPlayerKeyAE3DText(playerid, modeid, locationid, p3dtext, textid)
{
	// Custom
	CustomSetPlayerKeyAE3DText(playerid, modeid, locationid, p3dtext, textid);
	return 1;
}

stock Mode_GetPlayerSkin(playerid, modeid)
{
	new 
		skinid;

	// Custom
	CustomGetPlayerSkin(playerid, modeid, skinid);
	return skinid;
}

stock Mode_GetModeTimeRespawn(modeid)
{
	// Custom
	return CustomGetModeTimeRespawn(modeid);
}

stock Mode_SetAddSpeedRespawn(playerid)
{
	GivePlayerSpeedRespawn(playerid, -1);
	UpdateBarTimeRespawn(playerid);

	if (GetPlayerSpeedRespawn(playerid) <= 0) {
		if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
			Mode_OnPlayerSpawn(playerid);
		}
	}
	return 1;
}

stock Mode_UpdatePlayerData(playerid)
{
	// Custom
	CustomUpdatePlayerData(playerid, Mode_GetPlayerMode(playerid));

	Mode_UpdatePlSessionTimerTD(playerid);
	return 1;
}

stock Mode_GivePlayerReward(playerid, exp, money)
{
	// Custom
	CustomGivePlayerReward(playerid, Mode_GetPlayerMode(playerid), exp, money);
	return 1;
}

stock Mode_SetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
{
	// Custom
	CustomSetPlayerMG(playerid, Mode_GetPlayerMode(playerid), num, timer, count, value, ptime);
	return 1;
}

stock Mode_ResetPlayerMG(playerid)
{
	// Custom
	CustomResetPlayerMG(playerid, Mode_GetPlayerMode(playerid));
	return 1;
}

stock Mode_UpdateSpectateStatus(playerid, spectedid)
{
	// Custom
	if (CustomUpdateSpectateStatus(playerid, Mode_GetPlayerMode(playerid), spectedid)) {
		return 1;
	}

	return 0;
}

stock Mode_GivePlayerWeapon(playerid, WEAPON:weaponid, ammo)
{
	// Custom
	if (!CustomGivePlayerWeapon(playerid, Mode_GetPlayerMode(playerid), weaponid, ammo)) {
		return 0;
	}

	return 1;
}

stock Mode_IsPlayerInPlayer(playerid, playerid2)
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	if (!IsPlayerInvalided(playerid2)) {
		return 0;
	}

	if (Mode_GetPlayerMode(playerid) == Mode_GetPlayerMode(playerid2)
	&& Mode_GetPlayerSession(playerid) == Mode_GetPlayerSession(playerid2)) {
		return 1;
	}
	else {
		return 0;
	}
}

stock Mode_SendPlayerChatText(playerid, const text[])
{
	static
		str[200];

	str[0] = EOS;

	f(str, "{FFCC33}[Р: %i]:{%06x}%s(%d): "CT_WHITE"%s", GetPlayerRank(playerid), GetPlayerColorEx(playerid) >>> 8, GetPlayerNameEx(playerid), playerid, text);

	m_for(M_GP(playerid), M_GPS(playerid), p) {
		if (GetPlayerLogged(p)) {
			continue;
		}

		SCMEX(p, C_WHITE, str, true);
	}
	return 1;
}

stock Mode_CheckOnPlayerKey(playerid)
{
	m_for(M_GP(playerid), M_GPS(playerid), p) {
		n_for(i, GMS_MAX_PLAYER_AE_3DTEXTS) {
			if (!PlayerAE3DText[p][i][e_Created]) {
				continue;
			}
				
			if (!PlayerAE3DText[p][i][e_TypeClick]) {
				continue;
			}

			if (IsPlayerInRangeOfPoint(playerid, 1.3, PlayerAE3DText[p][i][e_PosX], PlayerAE3DText[p][i][e_PosY], PlayerAE3DText[p][i][e_PosZ])) {
				Mode_SetPlayerKeyAE3DText(playerid, M_GP(playerid), Mode_GetSessionLocation(M_GP(playerid), M_GPS(playerid)), p, i);
				break;
			}
		}
	}
	return 1;
}

stock Mode_StreamerUpdate(modeid, sessionid)
{
	m_for(modeid, sessionid, p) {
		Streamer_Update(p);
	}
	return 1;
}

/*
 * |>--------------<|
 * |     Custom     |
 * |>--------------<|
 */

static CustomCreateSession(modeid, sessionid)
{
	switch (modeid) {
		case MODE_NONE: None_CreateSession(sessionid);
		case MODE_ROOM: Room_CreateSession(sessionid);
		case MODE_TDM: TDM_CreateSession(sessionid);
		case MODE_DM: DM_CreateSession(sessionid);
		case MODE_EXAMPLE: Example_CreateSession(sessionid);
	}
	return 1;
}

static CustomDestroySingleSession(modeid, sessionid)
{
	switch (modeid) {
		case MODE_NONE: None_DestroySession(sessionid);
		case MODE_ROOM: Room_DestroySession(sessionid);
		case MODE_TDM: TDM_DestroySession(sessionid);
		case MODE_DM: DM_DestroySession(sessionid);
		case MODE_EXAMPLE: Example_DestroySession(sessionid);
	}
	return 1;
}

static CustomCreateFirstSessions(modeid)
{
	switch (modeid) {
		case MODE_NONE: None_CreateFirstSessions();
		case MODE_ROOM:	Room_CreateFirstSessions();
		case MODE_TDM: TDM_CreateFirstSessions();
		case MODE_DM: DM_CreateFirstSessions();
		case MODE_EXAMPLE: Example_CreateFirstSessions();
	}
	return 1;
}

static CustomCreateSessionLocation(modeid, sessionid, locationid)
{
	switch (modeid) {
		case MODE_NONE: None_CreateLocation(sessionid);
		case MODE_ROOM: Room_CreateLocation(sessionid);
		case MODE_TDM: TDM_CreateLocation(sessionid, locationid);
		case MODE_DM: DM_CreateLocation(sessionid, locationid);
		case MODE_EXAMPLE: Example_CreateLocation(sessionid, locationid);
	}
	return 1;
}

static CustomDestroySessionLocation(modeid, sessionid)
{
	switch (modeid) {
		case MODE_NONE: None_DestroyLocation(sessionid);
		case MODE_ROOM: Room_DestroyLocation(sessionid);
		case MODE_TDM: TDM_DestroyLocation(sessionid);
		case MODE_DM: DM_DestroyLocation(sessionid);
		case MODE_EXAMPLE: Example_DestroyLocation(sessionid);
	}
	return 1;
}

static CustomCreatePlayerLocation(playerid, modeid, sessionid)
{
	switch (modeid) {
		case MODE_NONE: None_CreatePlayerLocation(playerid, sessionid);
		case MODE_ROOM: Room_CreatePlayerLocation(playerid, sessionid);
		case MODE_TDM: TDM_CreatePlayerLocation(playerid, sessionid);
		case MODE_DM: DM_CreatePlayerLocation(playerid, sessionid);
		case MODE_EXAMPLE: Example_CreatePlayerLocation(playerid, sessionid);
	}
	return 1;
}

static CustomDestroyPlayerLocation(playerid, modeid)
{
	switch (modeid) {
		case MODE_NONE: None_DestroyPlayerLocation(playerid);
		case MODE_ROOM: Room_DestroyPlayerLocation(playerid);
		case MODE_TDM: TDM_DestroyPlayerLocation(playerid);
		case MODE_DM: DM_DestroyPlayerLocation(playerid);
		case MODE_EXAMPLE: Example_DestroyPlayerLocation(playerid);
	}
	return 1;
}

static CustomGetMaxQuestsProgress(modeid)
{
	switch (modeid) {
		case MODE_TDM: return TDM_MAX_QUESTS_PROGRESS;
		case MODE_DM: return DM_MAX_QUESTS_PROGRESS;
	}
	return 0;
}

static CustomGetMaxQuests(modeid)
{
	switch (modeid) {
		case MODE_TDM: return TDM_MAX_QUESTS;
		case MODE_DM: return DM_MAX_QUESTS;
	}
	return 0;
}

static CustomCheckQuestHead(playerid, modeid)
{
	switch (modeid) {
		case MODE_TDM: {
			CheckPlayerQuestProgress(playerid, MODE_TDM, 26);
		}
		case MODE_DM: {
			CheckPlayerQuestProgress(playerid, MODE_DM, 1);
			CheckPlayerQuestProgress(playerid, MODE_DM, 13);
		}
	}
	return 1;
}

static CustomUpdatePlayerMG(playerid, modeid)
{
	switch (modeid) {
		case MODE_TDM: TDM_UpdatePlayerMG(playerid);
	}
	return 1;
}

static CustomSetPlayerKeyAE3DText(playerid, modeid, locationid, p3dtext, textid)
{
	switch (modeid) {
		case MODE_TDM: TDM_SetPlayerKeyMode3DText(playerid, locationid, p3dtext, textid);
	}
	return 1;
}

static CustomGetPlayerSkin(playerid, modeid, &skinid)
{
	switch (modeid) {
		case MODE_TDM: skinid = TDM_GetClassSkin(GetPlayerTeamEx(playerid), GetPlayerCustomClass(playerid), GetPlayerSex(playerid));
		default: skinid = GetPlayerInvSkin(playerid);
	}
	return 1;
}

static CustomGetModeTimeRespawn(modeid)
{
	switch (modeid) {
		case MODE_ROOM: return ROOM_PLAYER_TIMER_RESPAWN;
		case MODE_TDM: return TDM_PLAYER_TIMER_RESPAWN;
		case MODE_DM: return DM_PLAYER_TIMER_RESPAWN;
		case MODE_EXAMPLE: return EXAMPLE_PLAYER_TIMER_RESPAWN;
		default: return TIMER_PLAYER_RESPAWN;
	}
	return 1;
}

static CustomUpdatePlayerData(playerid, modeid)
{
	switch (modeid) {
		case MODE_NONE: None_UpdatePlayerData(playerid);
		case MODE_ROOM: Room_UpdatePlayerData(playerid);
		case MODE_TDM: TDM_UpdatePlayerData(playerid);
		case MODE_DM: DM_UpdatePlayerData(playerid);
		case MODE_EXAMPLE: Example_UpdatePlayerData(playerid);
	}
	return 1;
}

static CustomGivePlayerReward(playerid, modeid, exp, money)
{
	switch (modeid) {
		case MODE_ROOM: {
			Mode_GivePlayerMatchExp(playerid, exp);
			Mode_GivePlayerMatchMoney(playerid, money);

			Mode_GivePlayerMatchPoints(playerid, money);
		}
		case MODE_TDM: {
			Mode_GivePlayerMatchExp(playerid, exp);
			Mode_GivePlayerMatchMoney(playerid, money);

			Mode_GivePlayerMatchPoints(playerid, money);
		}
	}
	return 1;
}

static CustomSetPlayerMG(playerid, modeid, num, &timer, &count, &value, &ptime)
{
	switch (modeid) {
		case MODE_TDM: TDM_LocSetPlayerMG(playerid, num, timer, count, value, ptime);
	}
	return 1;
}

static CustomResetPlayerMG(playerid, modeid)
{
	switch (modeid) {
		case MODE_TDM: TDM_LocResetPlayerMG(playerid);
	}
	return 1;
}

static CustomUpdateSpectateStatus(playerid, modeid, spectedid)
{
	switch (modeid) {
		case MODE_TDM: return TDM_UpdatePlayerSpecStatus(playerid, spectedid);
	}
	return 0;
}

static CustomGivePlayerWeapon(playerid, modeid, WEAPON:weaponid, ammo)
{
	switch (modeid) {
		case MODE_TDM: return TDM_GivePlayerWeapon(playerid, weaponid, ammo);
	}
	return 1;
}

static CustomCallPlayerCommand(playerid, modeid, const cmdName[], const params[])
{
	switch(modeid) {
		case MODE_TDM: return TDM_CallPlayerCommand(playerid, cmdName, params);
	}
	return 0;
}

static CustomOnGameModeInit()
{
	None_OnGameModeInit();
	Room_OnGameModeInit();
	TDM_OnGameModeInit();
	DM_OnGameModeInit();
	Example_OnGameModeInit();
	return 1;
}

static CustomOnPlayerSpawn(playerid, modeid)
{
	switch (modeid) {
		case MODE_NONE: None_OnPlayerSpawn(playerid);
		case MODE_ROOM: Room_OnPlayerSpawn(playerid);
		case MODE_TDM: TDM_OnPlayerSpawn(playerid);
		case MODE_DM: DM_OnPlayerSpawn(playerid);
		case MODE_EXAMPLE: Example_OnPlayerSpawn(playerid);
	}
	return 1;
}

static CustomOnPlayerDeath(playerid, modeid, &killerid, &WEAPON:reason)
{
	switch (modeid) {
		case MODE_NONE: None_OnPlayerDeath(playerid, killerid, reason);
		case MODE_ROOM: Room_OnPlayerDeath(playerid, killerid, reason);
		case MODE_TDM: TDM_OnPlayerDeath(playerid, killerid, reason);
		case MODE_DM: DM_OnPlayerDeath(playerid, killerid, reason);
		case MODE_EXAMPLE: Example_OnPlayerDeath(playerid, killerid, reason);
	}
	return 1;
}

static CustomOnPlayerKeyStateChange(playerid, modeid, KEY:newkeys, KEY:oldkeys)
{
	switch (modeid) {
		case MODE_ROOM: return Room_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
		case MODE_TDM: return TDM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
		case MODE_DM: return DM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	}
	return 0;
}

static CustomOnPlPickUpDynamicPickup(playerid, modeid, STREAMER_TAG_PICKUP:pickupid)
{
	switch (modeid) {
		case MODE_TDM: return TDM_OnPlPickUpDynamicPickup(playerid, pickupid);
	}
	return 0;
}

static CustomOnPlayerEnterDynamicArea(playerid, modeid, STREAMER_TAG_AREA:areaid)
{
	switch (modeid) {
		case MODE_ROOM: Room_OnPlayerEnterDynamicArea(playerid, areaid);
		case MODE_TDM: TDM_OnPlayerEnterDynamicArea(playerid, areaid);
	}
	return 0;
}

static CustomOnPlayerLeaveDynamicArea(playerid, modeid, STREAMER_TAG_AREA:areaid)
{
	switch (modeid) {
		case MODE_ROOM: Room_OnPlayerLeaveDynamicArea(playerid, areaid);
		case MODE_TDM: TDM_OnPlayerLeaveDynamicArea(playerid, areaid);
	}
	return 0;
}

static CustomOnPlayerEnterPlayerGZ(playerid, modeid, zoneid)
{
	switch (modeid) {
		case MODE_DM: DM_LocOnPlayerEnterPlayerGZ(playerid, zoneid);
	}
	return 0;
}

static CustomOnPlayerLeavePlayerGZ(playerid, modeid, zoneid)
{
	switch (modeid) {
		case MODE_DM: DM_LocOnPlayerLeavePlayerGZ(playerid, zoneid);
	}
	return 0;
}

static CustomOnPlayerDamage(&playerid, modeid, &Float:amount, &issuerid, &WEAPON:weapon, &bodypart)
{
	switch (modeid) {
		case MODE_ROOM: Room_OnPlayerDamage(playerid, amount, issuerid);
		case MODE_TDM: TDM_OnPlayerDamage(playerid, amount, issuerid, weapon, bodypart);
		case MODE_DM: DM_OnPlayerDamage(playerid, amount, issuerid, weapon, bodypart);
		case MODE_EXAMPLE: Example_OnPlayerDamage(playerid, issuerid, weapon, amount, bodypart);
	}
	return 1;
}

static CustomOnPlayerText(playerid, modeid, text[])
{
	switch (modeid) {
		case MODE_TDM: return TDM_OnPlayerText(playerid, text);
	}
	return 0;
}

static CustomOnPlayerCommandReceived(playerid, modeid, cmd[], params[], flags)
{
	#pragma unused cmd, params

	if ((flags & CMD_FLAG_MODE_NONE)
	&& modeid != MODE_NONE) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данная команда работает только в главном меню!");
		return 1;
	}

	if ((flags & CMD_FLAG_MODE_ROOM)
	&& modeid != MODE_ROOM) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данная команда работает только в режиме Комнаты!");
		return 1;
	}

	if ((flags & CMD_FLAG_MODE_TDM)
	&& modeid != MODE_TDM) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данная команда работает только в TDM режиме!");
		return 1;
	}

	if ((flags & CMD_FLAG_MODE_DM)
	&& modeid != MODE_DM) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данная команда работает только в DM режиме!");
		return 1;
	}

	return 0;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetModeCoreData(modeid)
{
	modeInfo[modeid][e_ShortName][0] =
	modeInfo[modeid][e_FullName][0] =
	modeInfo[modeid][e_Info][0] = EOS;

	modeInfo[modeid][e_EnableStatus] =
	modeInfo[modeid][e_ActiveEnableStatus] =
	modeInfo[modeid][e_ActiveChangeSession] =
	modeInfo[modeid][e_ActiveChangeSessionLocation] = false;

	modeInfo[modeid][e_MaxSessions] =
	modeInfo[modeid][e_SessionMaxPlayers] =
	modeInfo[modeid][e_VirtualWorld] =
	modeInfo[modeid][e_Interior] = 0;

	PlayersInMode[modeid] =
	AdminsInMode[modeid] = 0;
	return 1;
}

static ResetModeLocationData(modeid)
{
	n_for2(locid, GMS_MAX_LOCATIONS) {
		locInfo[modeid][locid][e_Name][0] =
		locInfo[modeid][locid][e_Info][0] = EOS;

		locInfo[modeid][locid][e_GameMode] =
		locInfo[modeid][locid][e_Weather] =
		locInfo[modeid][locid][e_Minutes] =
		locInfo[modeid][locid][e_Seconds] =
		locInfo[modeid][locid][e_Interior] = 0;
	}
	return 1;
}

static ResetModeGameModesData(modeid)
{
	n_for2(gamemodeid, GMS_MAX_GAME_MODES) {
		gamemodeInfo[modeid][gamemodeid][e_Name][0] =
		gamemodeInfo[modeid][gamemodeid][e_Info][0] = EOS;
	}
	return 1;
}

static ResetSessionCoreData(modeid, sessionid)
{
	sessionInfo[modeid][sessionid][e_Location] =
	sessionInfo[modeid][sessionid][e_LocationOne] = GMS_LOCATION_UNKNOWN;

	sessionInfo[modeid][sessionid][e_ActiveTimer] = false;

	sessionInfo[modeid][sessionid][e_GameMode] =
	sessionInfo[modeid][sessionid][e_Weather] =
	sessionInfo[modeid][sessionid][e_Minutes] =
	sessionInfo[modeid][sessionid][e_Seconds] =
	sessionInfo[modeid][sessionid][e_Interior] = 0;

	PlayersInSession[modeid][sessionid] =
	AdminsInSession[modeid][sessionid] = 0;

	// AE
	n_for3(i, GMS_MAX_AE_VALUES) {
		ModeAEValue[modeid][sessionid][i] = 0;
	}

	n_for4(i, GMS_MAX_AE_VALUES) {
		ModeAEFloatValue[modeid][sessionid][i][0] =
		ModeAEFloatValue[modeid][sessionid][i][1] =
		ModeAEFloatValue[modeid][sessionid][i][2] = 0.0;
	}

	// Slots
	n_for5(sl, GMS_MAX_SESSION_SLOTS) {
		SessionSlot[modeid][sessionid][sl] = INVALID_PLAYER_ID;
	}
	return 1;
}

static ResetModesData()
{
	// Modes
	n_for(modeid, GMS_MAX_MODES) {
		ResetModeCoreData(modeid);
		ResetModeLocationData(modeid);
		ResetModeGameModesData(modeid);

		// Sessions
		n_for2(sessionid, GMS_MAX_SESSIONS) {
			ResetSessionCoreData(modeid, sessionid);
		}
	}
	return 1;
}

static ResetPlayerModeData(playerid)
{
	pInfo[playerid][e_Mode] = -1;
	pInfo[playerid][e_Session] =
	pInfo[playerid][e_Slot] = 0;

	pInfo[playerid][e_MatchKills] =
	pInfo[playerid][e_MatchDeaths] =
	pInfo[playerid][e_MatchExp] =
	pInfo[playerid][e_MatchMoney] =
	pInfo[playerid][e_MatchPoints] = 0;

	n_for(i, GMS_MAX_MODES) {
		PlayerDialogModes[playerid][i] = -1;
	}

	n_for(i, GMS_MAX_SESSIONS) {
		PlayerDialogSessions[playerid][i] = -1;
	}

	n_for(i, GMS_MAX_LOCATIONS) {
		PlayerDialogLocations[playerid][i] = GMS_LOCATION_UNKNOWN;
	}

	Mode_ResetPlAE3DTexts(playerid);
	Mode_ResetPlAEValues(playerid);

	n_for(i, GMS_MAX_PLAYER_AE_OBJECTS) {
		PlayerAEObject[playerid][i] = INVALID_DYNAMIC_OBJECT_ID;
	}
	return 1;
}

static ResetPlayerTDs(playerid)
{
	TD_MatchPoints[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
	TD_SessionTimer[playerid] = PlayerText:INVALID_PLAYER_TEXT_DRAW;
	return 1;
}

/*
 * |>----------------<|
 * |     Commands     |
 * |>----------------<|
 */

CMD:rep(playerid)
{
	// Custom
	if (CustomCallPlayerCommand(playerid, Mode_GetPlayerMode(playerid), "rep", "No")) {
		return 1;
	}

	SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Сейчас Вам недоступна команда.");
	return 1;
}

CMD:hp(playerid, params[])
{
	// Custom
	if (CustomCallPlayerCommand(playerid, Mode_GetPlayerMode(playerid), "hp", params)) {
		return 1;
	}

	SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Сейчас Вам недоступна команда.");
	return 1;
}

CMD:accode(playerid)
{
	// Custom
	if (CustomCallPlayerCommand(playerid, Mode_GetPlayerMode(playerid), "accode", "No")) {
		return 1;
	}

	SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Сейчас Вам недоступна команда.");
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

/*
 * |>-----------------------<|
 * |   Select play session   |
 * |>-----------------------<|
 */

DialogCreate:Mode_SelectPlaySession(playerid)
{
	new
		modeid = GetPVarInt(playerid, "SelectedMode");

	if (!modeInfo[modeid][e_EnableStatus]) {
		DeletePVar(playerid, "SelectedMode");
		return 1;
	}

	n_for(i, GMS_MAX_SESSIONS) {
		PlayerDialogSessions[playerid][i] = -1;
	}

	static
		strHead[200],
		strMain[2048];

	strHead[0] =
	strMain[0] = EOS;

	new
		index = 0;

	f(strHead, "Сессии [Режим: %s]", Mode_GetShortName(modeid));

	strMain = "Локация\tИгровой режим\tИгроков\n";

	foreach (new i:Sessions[modeid]) {
		PlayerDialogSessions[playerid][index] = i;
		index++;

		new
			locationid = Mode_GetSessionLocation(modeid, i);

		f(strMain, "%s\
		"CT_ORANGE"%i. "CT_WHITE"%s\
		\t{d9ae21}%s\
		\t"CT_GREY"%i/%i\n", strMain, index, Mode_GetLocationName(modeid, locationid), Mode_GetGameModeName(modeid, Mode_GetLocationGameMode(modeid, locationid)), GetPlayersNotAdminsMode(modeid, i), Mode_GetMaxSessionPlayers(modeid));
	}
	Dialog_Open(playerid, Dialog:Mode_SelectPlaySession, DSTH, strHead, strMain, "Выбрать", "Выйти");
	return 1;
}

DialogResponse:Mode_SelectPlaySession(playerid, response, listitem, inputtext[])
{
	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		sessionid = PlayerDialogSessions[playerid][listitem];

	if (!response) {
		DeletePVar(playerid, "SelectedMode");
		return 1;
	}

	if (!Iter_Contains(Modes, modeid)) {
		DeletePVar(playerid, "SelectedMode");
		return 1;
	}

	if (!Iter_Contains(Sessions[modeid], sessionid)) {
		Dialog_Show(playerid, Dialog:Mode_SelectSession);
		return 1;
	}

	if (GetPlayersNotAdminsMode(modeid, sessionid) >= Mode_GetMaxSessionPlayers(modeid)) {
		Dialog_Show(playerid, Dialog:Mode_SelectPlaySession);
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данная сессия уже заполнена.");
		return 1;
	}

	DeletePVar(playerid, "SelectedMode");

	Mode_LeavePlayer(playerid);
	Mode_EnterPlayer(playerid, modeid, sessionid);
	return 1;
}

/*
 * |>----------------------------<|
 * |   Select mode for settings   |
 * |>----------------------------<|
 */

DialogCreate:Mode_SelectMode(playerid)
{
	n_for(i, GMS_MAX_MODES) {
		PlayerDialogModes[playerid][i] = -1;
	}

	static
		strMain[1000];

	strMain[0] = EOS;

	new
		index = 0;

	strcat(strMain, "Название\tСтатус\n");

	foreach (new i:Modes) {
		PlayerDialogModes[playerid][index] = i;
		index++;

		f(strMain, "%s"CT_ORANGE"%i. "CT_WHITE"%s - %s\t%s\n",
		strMain, i + 1,
		Mode_GetFullName(i), Mode_GetShortName(i),
		Mode_GetEnableStatus(i) ? ""CT_GREEN"[Активен]" : ""CT_RED"[Отключён]");
	}

	Dialog_Open(playerid, Dialog:Mode_SelectMode, DSTH, "[Выбор режима]", strMain, "Выбрать", "Выйти");
	return 1;
}

DialogResponse:Mode_SelectMode(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	new
		modeid = PlayerDialogModes[playerid][listitem];

	if (!Iter_Contains(Modes, modeid)) {
		Dialog_Show(playerid, Dialog:Mode_SelectMode);
		return 1;
	}

	SetPVarInt(playerid, "SelectedMode", modeid);
	Dialog_Show(playerid, Dialog:Mode_SelectSettingsMode);
	return 1;
}

/*
 * |>----------------------------<|
 * |   Select settings for mode   |
 * |>----------------------------<|
 */

DialogCreate:Mode_SelectSettingsMode(playerid)
{
	static
		strHead[200],
		strMain[500];

	strHead[0] =
	strMain[0] = EOS;

	new
		modeid = GetPVarInt(playerid, "SelectedMode");

	f(strHead, "[Настройка режима] [Режим: %s]", Mode_GetShortName(modeid));

	f(strMain,
	""CT_ORANGE"1. "CT_WHITE"Информация\
	\n"CT_ORANGE"2. %s%s\
	\n"CT_ORANGE"3. %sНастройка сессий",
	Mode_GetChangeEnableStatus(modeid) ? ""CT_WHITE"" : ""CT_GREY"",
	Mode_GetEnableStatus(modeid) ? "Отключить режим" : "Включить режим",
	(Mode_GetEnableStatus(modeid) && Mode_GetChangeSession(modeid)) ? ""CT_WHITE"" : ""CT_GREY"");

	Dialog_Open(playerid, Dialog:Mode_SelectSettingsMode, DSL, strHead, strMain, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Mode_SelectSettingsMode(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "SelectedMode");
		Dialog_Show(playerid, Dialog:Mode_SelectMode);
		return 1;
	}

	new
		modeid = GetPVarInt(playerid, "SelectedMode");

	if (!Iter_Contains(Modes, modeid)) {
		DeletePVar(playerid, "SelectedMode");
		Dialog_Show(playerid, Dialog:Mode_SelectMode);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:Mode_InfoMode);
		}
		case 1: {
			if (!Mode_GetChangeEnableStatus(modeid)) {
				Dialog_Show(playerid, Dialog:Mode_SelectSettingsMode);
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный режим нельзя включать/выключать.");
				return 1;
			}

			modeInfo[modeid][e_EnableStatus] = !modeInfo[modeid][e_EnableStatus];

			if (modeInfo[modeid][e_EnableStatus]) {
				Mode_CreateFirstSessions(modeid);
				SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" включил режим %s", GetPlayerNameEx(playerid), playerid, Mode_GetShortName(modeid));
			}
			else {
				Mode_DestroySession(modeid, -1);
				SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" отключил режим %s", GetPlayerNameEx(playerid), playerid, Mode_GetShortName(modeid));
			}

			Dialog_Show(playerid, Dialog:Mode_SelectSettingsMode);
		}
		case 2: {
			if (!Mode_GetEnableStatus(modeid)) {
				Dialog_Show(playerid, Dialog:Mode_SelectSettingsMode);
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В данный момент режим отключён.");
				return 1;
			}

			if (!Mode_GetChangeSession(modeid)) {
				Dialog_Show(playerid, Dialog:Mode_SelectSettingsMode);
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В данном режиме нельзя изменять сессии.");
				return 1;
			}

			Dialog_Show(playerid, Dialog:Mode_SelectSession);
		}
	}
	return 1;
}

/*
 * |>-------------<|
 * |   Info mode   |
 * |>-------------<|
 */

DialogCreate:Mode_InfoMode(playerid)
{
	static
		strHead[200],
		strMain[1000];

	strHead[0] =
	strMain[0] = EOS;

	new
		modeid = GetPVarInt(playerid, "SelectedMode");

	f(strHead, "[Информация] [Режим: %s]", Mode_GetShortName(modeid));

	f(strMain,
	""CT_WHITE"Название режима: "CT_LIGHT_BLUE"[%s - %s]\
	\n"CT_WHITE"Статус: %s\
	\n"CT_WHITE"Сессий: "CT_ORANGE"[%i]\
	\n"CT_WHITE"Локаций: "CT_YELLOW"[%i]\
	\n\
	\n"CT_WHITE"Игроков: "CT_GREEN"[%i]\
	\n"CT_WHITE"Администрации: "CT_CARMINE"[%i]",
	Mode_GetFullName(modeid), Mode_GetShortName(modeid),
	Mode_GetEnableStatus(modeid) ? ""CT_GREEN"[Активен]" : ""CT_RED"[Отключён]",
	Iter_Count(Sessions[modeid]), Iter_Count(Locations[modeid]),
	Mode_GetPlayers(modeid), Mode_GetAdmins(modeid));

	Dialog_Open(playerid, Dialog:Mode_InfoMode, DSM, strHead, strMain, "Выйти", "");
	return 1;
}

DialogResponse:Mode_InfoMode(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:Mode_SelectSettingsMode);
	return 1;
}

/*
 * |>-------------------------------<|
 * |   Select session for settings   |
 * |>-------------------------------<|
 */

DialogCreate:Mode_SelectSession(playerid)
{
	n_for(i, GMS_MAX_SESSIONS) {
		PlayerDialogSessions[playerid][i] = -1;
	}

	static
		strHead[200],
		strMain[1000];

	strHead[0] =
	strMain[0] = EOS;

	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		index = 0;

	f(strHead, "[Выбор сессии] [Режим: %s]", Mode_GetShortName(modeid));

	f(strMain, ""CT_ORANGE"1. "CT_WHITE"Добавить сессию\n");

	foreach (new i:Sessions[modeid]) {
		PlayerDialogSessions[playerid][index] = i;
		index++;

		f(strMain, "%s"CT_ORANGE"%i. "CT_WHITE"Сессия [%i]\n", strMain, index + 1, i);
	}

	Dialog_Open(playerid, Dialog:Mode_SelectSession, DSL, strHead, strMain, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Mode_SelectSession(playerid, response, listitem, inputtext[])
{
	new
		modeid = GetPVarInt(playerid, "SelectedMode");

	if (!Iter_Contains(Modes, modeid)) {
		DeletePVar(playerid, "SelectedMode");
		Dialog_Show(playerid, Dialog:Mode_SelectMode);
		return 1;
	}

	if (!response) {
		Dialog_Show(playerid, Dialog:Mode_SelectSettingsMode);
		return 1;
	}

	// Add session
	if (listitem == 0) {
		if (Iter_Count(Sessions[modeid]) >= Mode_GetMaxSessions(modeid)) {
			Dialog_Show(playerid, Dialog:Mode_SelectSession);
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В данном режиме уже максимум сессий.");
			return 1;
		}

		Mode_CreateSession(modeid);
		Dialog_Show(playerid, Dialog:Mode_SelectSession);

		SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" добавил новую сессию в режиме %s", GetPlayerNameEx(playerid), playerid, Mode_GetShortName(modeid));
		return 1;
	}

	new
		sessionid = PlayerDialogSessions[playerid][listitem - 1];

	if (!Iter_Contains(Sessions[modeid], sessionid)) {
		Dialog_Show(playerid, Dialog:Mode_SelectSession);
		return 1;
	}

	SetPVarInt(playerid, "SelectedSession", sessionid);
	Dialog_Show(playerid, Dialog:Mode_SelectSettingsSession);
	return 1;
}

/*
 * |>-------------------------------<|
 * |   Select settings for session   |
 * |>-------------------------------<|
 */

DialogCreate:Mode_SelectSettingsSession(playerid)
{
	static
		strHead[200],
		strMain[500];

	strHead[0] =
	strMain[0] = EOS;

	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		sessionid = GetPVarInt(playerid, "SelectedSession");

	f(strHead, "[Настройка сессии] [Режим: %s] [Сессия: %i]", Mode_GetShortName(modeid), sessionid);

	f(strMain,
	""CT_ORANGE"1. "CT_WHITE"Информация\
	\n"CT_ORANGE"2. "CT_WHITE"Отключить сессию\
	\n"CT_ORANGE"3. %sИзменить локацию\
	\n"CT_ORANGE"4. "CT_WHITE"Изменить погоду",
	Mode_GetChangeSessionLocation(modeid) ? ""CT_WHITE"" : ""CT_GREY"");

	Dialog_Open(playerid, Dialog:Mode_SelectSettingsSession, DSL, strHead, strMain, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Mode_SelectSettingsSession(playerid, response, listitem, inputtext[])
{
	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		sessionid = GetPVarInt(playerid, "SelectedSession");

	if (!Iter_Contains(Modes, modeid)) {
		DeletePVar(playerid, "SelectedMode");
		DeletePVar(playerid, "SelectedSession");
		Dialog_Show(playerid, Dialog:Mode_SelectMode);
		return 1;
	}

	if (!response) {
		DeletePVar(playerid, "SelectedSession");
		Dialog_Show(playerid, Dialog:Mode_SelectSession);
		return 1;
	}

	if (!Iter_Contains(Sessions[modeid], sessionid)) {
		DeletePVar(playerid, "SelectedSession");
		Dialog_Show(playerid, Dialog:Mode_SelectSession);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:Mode_InfoSession);
		}
		case 1: {
			Mode_DestroySession(modeid, sessionid);
			Dialog_Show(playerid, Dialog:Mode_SelectSession);

			SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" удалил сессию %i в режиме %s", GetPlayerNameEx(playerid), playerid, sessionid, Mode_GetShortName(modeid));
		}
		case 2: {
			if (!Mode_GetChangeSessionLocation(modeid)) {
				Dialog_Show(playerid, Dialog:Mode_SelectSettingsSession);
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В данном режиме нельзя изменять локации в сессии.");
				return 1;
			}

			Dialog_Show(playerid, Dialog:Mode_ChangeSessionLocation);
		}
		case 3: {
			Dialog_Show(playerid, Dialog:Mode_ChangeSessionWeather);
		}
	}
	return 1;
}

/*
 * |>----------------<|
 * |   Info session   |
 * |>----------------<|
 */

DialogCreate:Mode_InfoSession(playerid)
{
	static
		strHead[200],
		strMain[1000];

	strHead[0] =
	strMain[0] = EOS;

	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		sessionid = GetPVarInt(playerid, "SelectedSession");

	f(strHead, "[Информация] [Режим: %s] [Сессия: %i]", Mode_GetShortName(modeid), sessionid);

	f(strMain,
	""CT_WHITE"Название режима: "CT_LIGHT_BLUE"[%s - %s]\
	\n"CT_WHITE"Номер сессии: "CT_GREY"[№%i]\
	\n"CT_WHITE"Локация: "CT_ORANGE"[%s]\
	\n"CT_WHITE"Режим: "CT_YELLOW"[%s]\
	\n\
	\n"CT_WHITE"Игроков: "CT_GREEN"[%i]\
	\n"CT_WHITE"Администрации: "CT_CARMINE"[%i]", Mode_GetFullName(modeid), Mode_GetShortName(modeid), sessionid, Mode_GetLocationName(modeid, Mode_GetSessionLocation(modeid, sessionid)), Mode_GetGameModeName(modeid, Mode_GetSessionGameMode(modeid, sessionid)), Mode_GetSessionPlayers(modeid, sessionid), Mode_GetSessionAdmins(modeid, sessionid));

	Dialog_Open(playerid, Dialog:Mode_InfoSession, DSM, strHead, strMain, "Выйти", "");
	return 1;
}

DialogResponse:Mode_InfoSession(playerid, response, listitem, inputtext[])
{
	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		sessionid = GetPVarInt(playerid, "SelectedSession");

	if (!Iter_Contains(Modes, modeid)) {
		DeletePVar(playerid, "SelectedMode");
		Dialog_Show(playerid, Dialog:Mode_SelectMode);
		return 1;
	}

	if (!Iter_Contains(Sessions[modeid], sessionid)) {
		DeletePVar(playerid, "SelectedSession");
		Dialog_Show(playerid, Dialog:Mode_SelectSession);
		return 1;
	}

	Dialog_Show(playerid, Dialog:Mode_SelectSettingsSession);
	return 1;
}

/*
 * |>--------------------------------<|
 * |   Change location for settings   |
 * |>--------------------------------<|
 */

DialogCreate:Mode_ChangeSessionLocation(playerid)
{
	n_for(i, GMS_MAX_LOCATIONS) {
		PlayerDialogLocations[playerid][i] = GMS_LOCATION_UNKNOWN;
	}

	static
		strHead[200],
		strMain[1000];

	strHead[0] =
	strMain[0] = EOS;

	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		sessionid = GetPVarInt(playerid, "SelectedSession"),
		index = 0;

	f(strHead, "[Смена локации] [Режим: %s] [Сессия: %i]", Mode_GetShortName(modeid), sessionid);

	strcat(strMain, "Название\tИгровой режим\n");

	foreach (new i:Locations[modeid]) {
		PlayerDialogLocations[playerid][index] = i;
		index++;

		f(strMain, "%s"CT_ORANGE"%i. "CT_WHITE"%s\t{E09B0B}%s\n", strMain, i + 1, Mode_GetLocationName(modeid, i), Mode_GetGameModeName(modeid, Mode_GetLocationGameMode(modeid, i)));
	}

	Dialog_Open(playerid, Dialog:Mode_ChangeSessionLocation, DSTH, strHead, strMain, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Mode_ChangeSessionLocation(playerid, response, listitem, inputtext[])
{
	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		sessionid = GetPVarInt(playerid, "SelectedSession"),
		locationid = PlayerDialogLocations[playerid][listitem];

	if (!Iter_Contains(Modes, modeid)) {
		DeletePVar(playerid, "SelectedMode");
		DeletePVar(playerid, "SelectedSession");
		Dialog_Show(playerid, Dialog:Mode_SelectMode);
		return 1;
	}

	if (!Iter_Contains(Sessions[modeid], sessionid)) {
		DeletePVar(playerid, "SelectedSession");
		Dialog_Show(playerid, Dialog:Mode_SelectSession);
		return 1;
	}

	if (!response) {
		Dialog_Show(playerid, Dialog:Mode_SelectSettingsSession);
		return 1;
	}

	if (!Iter_Contains(Locations[modeid], locationid)) {
		Dialog_Show(playerid, Dialog:Mode_ChangeSessionLocation);
		return 1;
	}

	DeletePVar(playerid, "SelectedMode");
	DeletePVar(playerid, "SelectedSession");

	Mode_DestroySessionLocation(modeid, sessionid);
	Mode_CreateSessionLocation(modeid, sessionid, locationid);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" изменил локацию в сессии %i в режиме %s", GetPlayerNameEx(playerid), playerid, sessionid, Mode_GetShortName(modeid));
	return 1;
}

/*
 * |>---------------------------------------<|
 * |   Change session weather for settings   |
 * |>---------------------------------------<|
 */

DialogCreate:Mode_ChangeSessionWeather(playerid)
{
	static
		strHead[200];

	strHead[0] = EOS;

	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		sessionid = GetPVarInt(playerid, "SelectedSession");

	f(strHead, "[Смена погоды] [Режим: %s] [Сессия: %i]", Mode_GetShortName(modeid), sessionid);

	Dialog_Open(playerid, Dialog:Mode_ChangeSessionWeather, DSI, strHead,
	""CT_WHITE"Введите ID погоды для изменения её в сессии:\
	\n\nПримечание: ID погоды должно быть от 0 до 22.",
	"Ввод", "Назад");
	return 1;
}

DialogResponse:Mode_ChangeSessionWeather(playerid, response, listitem, inputtext[])
{
	new
		modeid = GetPVarInt(playerid, "SelectedMode"),
		sessionid = GetPVarInt(playerid, "SelectedSession");

	if (!Iter_Contains(Modes, modeid)) {
		DeletePVar(playerid, "SelectedMode");
		DeletePVar(playerid, "SelectedSession");
		Dialog_Show(playerid, Dialog:Mode_SelectMode);
		return 1;
	}

	if (!Iter_Contains(Sessions[modeid], sessionid)) {
		DeletePVar(playerid, "SelectedSession");
		Dialog_Show(playerid, Dialog:Mode_SelectSession);
		return 1;
	}

	if (!response) {
		Dialog_Show(playerid, Dialog:Mode_SelectSettingsSession);
		return 1;
	}

	if (!IsStringNum(inputtext)) {
		Dialog_Show(playerid, Dialog:Mode_ChangeSessionWeather);
		return 1;
	}

	new
		weatherid = strval(inputtext);

	if (weatherid < MINIMAL_WEATHER_ID
	|| weatherid > MAXIMAL_WEATHER_ID) {
		Dialog_Show(playerid, Dialog:Mode_ChangeSessionWeather);
		return 1;
	}

	Mode_SetSessionWeather(modeid, sessionid, weatherid);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" изменил погоду в сессии %i в режиме %s", GetPlayerNameEx(playerid), playerid, sessionid, Mode_GetShortName(modeid));
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

stock Mode_OnGameModeInit()
{
	ResetModesData();

	Iter_Init(Sessions);
	Iter_Init(Locations);
	Iter_Init(GameModes);

	// Custom
	CustomOnGameModeInit();

	// Log
	print("--------------------------------------");
	print(" Инициализация режимов...");
	print(" ");

	new
		iterEnd = Iter_Last(Modes);

	foreach (new modeid:Modes) {
		printf(" %s:", Mode_GetFullName(modeid));
		printf("\t- Статус: %s", Mode_GetEnableStatus(modeid) ? "Активен" : "Отключён");
		printf("\t- Сессий: %i", Iter_Count(Sessions[modeid]));
		printf("\t- Локаций: %i", Iter_Count(Locations[modeid]));
		
		if (iterEnd != modeid) {
			print(" ");
		}
	}

	print("--------------------------------------\n");
	return 1;
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerModeData(playerid);
	ResetPlayerTDs(playerid);

	#if defined Mode_OnPlayerConnect
		return Mode_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>-----------------<|
 * |   OnPlayerSpawn   |
 * |>-----------------<|
 */

stock Mode_OnPlayerSpawn(playerid)
{
	// Custom
	CustomOnPlayerSpawn(playerid, Mode_GetPlayerMode(playerid));
	return 1;
}

/*
 * |>-----------------<|
 * |   OnPlayerDeath   |
 * |>-----------------<|
 */

stock Mode_OnPlayerDeath(playerid, &killerid, &WEAPON:reason)
{
	// Custom
	CustomOnPlayerDeath(playerid, Mode_GetPlayerMode(playerid), killerid, reason);
	return 1;
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

stock Mode_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	// Custom
	return CustomOnPlayerKeyStateChange(playerid, Mode_GetPlayerMode(playerid), newkeys, oldkeys);
}

/*
 * |>-------------------------------<|
 * |   OnPlayerPickUpDynamicPickup   |
 * |>-------------------------------<|
 */

stock Mode_OnPlPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	// Custom
	return CustomOnPlPickUpDynamicPickup(playerid, Mode_GetPlayerMode(playerid), pickupid);
}

/*
 * |>----------------------------<|
 * |   OnPlayerEnterDynamicArea   |
 * |>----------------------------<|
 */

stock Mode_OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	// Custom
	CustomOnPlayerEnterDynamicArea(playerid, Mode_GetPlayerMode(playerid), areaid);
	return 0;
}

/*
 * |>----------------------------<|
 * |   OnPlayerLeaveDynamicArea   |
 * |>----------------------------<|
 */

stock Mode_OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	// Custom
	CustomOnPlayerLeaveDynamicArea(playerid, Mode_GetPlayerMode(playerid), areaid);
	return 0;
}

/*
 * |>-------------------------------<|
 * |   OnPlayerEnterPlayerGangZone   |
 * |>-------------------------------<|
 */

stock Mode_OnPlayerEnterPlayerGZ(playerid, zoneid)
{
	// Custom
	CustomOnPlayerEnterPlayerGZ(playerid, Mode_GetPlayerMode(playerid), zoneid);
    return 0;
}

/*
 * |>-------------------------------<|
 * |   OnPlayerLeavePlayerGangZone   |
 * |>-------------------------------<|
 */

stock Mode_OnPlayerLeavePlayerGZ(playerid, zoneid)
{
	// Custom
	CustomOnPlayerLeavePlayerGZ(playerid, Mode_GetPlayerMode(playerid), zoneid);
    return 0;
}

/*
 * |>------------------<|
 * |   OnPlayerDamage   |
 * |>------------------<|
 */

stock Mode_OnPlayerDamage(&playerid, &Float:amount, &issuerid, &WEAPON:weapon, &bodypart)
{
	// Custom
	CustomOnPlayerDamage(playerid, Mode_GetPlayerMode(playerid), amount, issuerid, weapon, bodypart);
	return 1;
}

/*
 * |>----------------<|
 * |   OnPlayerText   |
 * |>----------------<|
 */

stock Mode_OnPlayerText(playerid, text[])
{
	// Custom
	if (CustomOnPlayerText(playerid, Mode_GetPlayerMode(playerid), text)) {
		return 1;
	}
	
	return 0;
}

/*
 * |>---------------------------<|
 * |   OnPlayerCommandReceived   |
 * |>---------------------------<|
 */

stock Mode_OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	// Custom
	if (CustomOnPlayerCommandReceived(playerid, Mode_GetPlayerMode(playerid), cmd, params, flags)) {
		return 1;
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
#define OnPlayerConnect Mode_OnPlayerConnect
#if defined Mode_OnPlayerConnect
	forward Mode_OnPlayerConnect(playerid);
#endif