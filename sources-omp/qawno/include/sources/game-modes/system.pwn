/*

	About: Game-modes core system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
		OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
		OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
		OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart) 
	Stock:
		Mode_SetPlayer(playerid, mode_id)
		Mode_GetPlayer(playerid)
		M_GP(playerid)
		Mode_SetPlayerSession(playerid, session_id)
		Mode_GetPlayerSession(playerid) 
		M_GPS(playerid)
		Mode_SetPlayerSlot(playerid, slot_id)
		Mode_GetPlayerSlot(playerid)
		M_GPSlot(playerid)
		Mode_SetPlayerVirtualWorld(playerid, mode_id, session_id)
		Mode_SetPlayerInterior(playerid, mode_id, session_id)
		Mode_SetPlayerWeather(playerid, mode_id, session_id)
		Mode_SetPlayerKill(playerid, kills)
		Mode_GetPlayerKills(playerid)
		Mode_SetPlayerDeath(playerid, deaths)
		Mode_GetPlayerDeaths(playerid) 
		Mode_SetPlayerMatchPoint(playerid, points)
		Mode_GetPlayerMatchPoints(playerid)
		Mode_SetPlayerExp(playerid, exp)
		Mode_GetPlayerExp(playerid) 
		Mode_SetPlayerMoney(playerid, money)
		Mode_GetPlayerMoney(playerid)
		Mode_IsPlayerInPlayer(playerid, playerid_2)
		Mode_SendText(playerid, text[])
		Mode_CheckOnPlayerKey(playerid)
		Mode_CreatePlAEElements(playerid)
		Mode_DestroyPlAEElements(playerid)
		Mode_SetPlAEValues(playerid)
		Mode_ResetPlAEValues(playerid)
		Mode_SetAEValue(mode_id, session_id, cell, value)
		Mode_GetAEValue(mode_id, session_id, cell)
		Mode_SetAEFloatValues(mode_id, session_id, cell, Float:X, Float:Y, Float:Z)
		Mode_GetAEFloatValues(mode_id, session_id, cell, num)
		Mode_SetPlAEValue(playerid, cell, value)
		Mode_GetPlAEValue(playerid, cell)
		Mode_SetPlAEFloatValue(playerid, cell, Float:X, Float:Y, Float:Z)
		Mode_GetPlAEFloatValue(playerid, cell, &Float:X, &Float:Y, &Float:Z) 
		Mode_CreatePlAE3DText(p_3dtext, cell, name[150], color, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid, vehicleid, lost)
		Mode_DestroyPlAE3DText(playerid, cell = -1)
		Mode_ResetPlAE3DTexts(playerid, cell = -1)
		Mode_UpdatePlAE3DText(playerid, cell, color, text[])
		Mode_CreateAE3DText(playerid, p_3dtext = -1, cell = -1)
		Mode_HidePlAE3DText(playerid, p_3dtext = -1, cell = -1)
		Mode_CreatePlAEObject(p_object, cell, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
		Mode_DestroyPlAEObject(playerid, cell = -1)
		Mode_SetPlAEObjectMaterial(playerid, cell, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0)
		Mode_MovePlAEObject(playerid, cell, Float:x, Float:y, Float:z, Float:speed, Float:rx = -1000.0, Float:ry = -1000.0, Float:rz = -1000.0)
		Mode_GetPlAEObjectPos(playerid, cell, &Float:x, &Float:y, &Float:z)
		Mode_EnteringPlayer(playerid, mode_id, session_id)
		Mode_LeavingPlayer(playerid)
		Mode_SetPlKeyAd3DText(playerid, mode_id, location_id, p_3dtext, text_id)
		Mode_OnPlayerDeath(playerid, &killerid, &reason)
		Mode_OnPlayerSpawn(playerid)
		Mode_LeavePlayer(playerid)
		Mode_ErrorTextCMD(playerid, mode_id)
		Mode_GetPlayerSkin(playerid, mode_id)
		Mode_SetAddSpeedRespawn(playerid)
		Mode_SetPlayerTimer(playerid, mode_id)
		Mode_KillPlayerTimer(playerid, mode_id)
		Mode_SetPlayerFee(playerid, exp, credit)
		Mode_SetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
		Mode_ResetPlayerMG(playerid)
		Mode_UpdatePlayerMG(playerid)
		Mode_ShowDeadKiller(playerid, killerid)
		Mode_UpdateSpectateStatus(playerid, spectedid)
		Mode_GivePlayerWeapon(playerid, weaponid, ammo)
		Mode_CreatePlayerMatchPoints(playerid)
		Mode_DestroyPlayerMatchPoints(playerid, bool:hide = true)
		Mode_ShowTDMatchPoints(playerid)
		Mode_CreatePlTDTimerSession(playerid)
		Mode_DestroyPlTDTimerSession(playerid)
		Mode_UpdatePlTDTimerSession(playerid, str[])
		Mode_OnPlayerText(playerid, text[])
		Mode_SetVirtualWorld(mode_id, session_id, world_id)
		Mode_GetVirtualWorld(mode_id, session_id)
		Mode_SetInterior(mode_id, session_id, interior_id)
		Mode_GetInterior(mode_id, session_id)
		Mode_SetWeather(mode_id, session_id, weather_id)
		Mode_GetWeather(mode_id, session_id)
		Mode_SetMode(mode_id, session_id, gamemode_id)
		Mode_GetMode(mode_id, session_id)
		Mode_GetPlayers(mode_id)
		Mode_GiveSessionPlayers(mode_id, session_id, num)
		Mode_SetSessionPlayers(mode_id, session_id, num)
		Mode_GetSessionPlayers(mode_id, session_id)
		Mode_SetSessionSlot(mode_id, session_id, slot_id, num)
		Mode_GetSessionSlot(mode_id, session_id, slot_id)
		Mode_SetMinutes(mode_id, session_id, num)
		Mode_GetMinutes(mode_id, session_id)
		Mode_SetSeconds(mode_id, session_id, num)
		Mode_GetSeconds(mode_id, session_id)
		Mode_GetMaxQuestsProgress(mode_id)
		Mode_GetMaxQuests(mode_id)
		Mode_CheckQuestHead(playerid, mode_id) 
		Mode_SetLocation(mode_id, session_id, loc_id)
		Mode_GetLocation(mode_id, session_id)
		Mode_GetModeTimeRespawn(mode_id)
		Mode_GetBasicVirtualWorld(mode_id, session_id)  
		Mode_GetBasicInterior(mode_id, session_id)
		Mode_CreateLocation(mode_id, session_id, location_id, bool:start_server = false)
		Mode_DestroyLocation(mode_id, session_id)
		Mode_CreateLocationPlayer(playerid, mode_id, session_id, bool:set = true)
		Mode_DestroyLocationPlayer(playerid, bool:reset = true)
		Mode_ChangeLocationSessions() 
		Mode_UpdateTime()
		Mode_UpdateTime_2()
Enums:
	E_GMS_PLAYER_MODE_TIMER_INFO
	E_GMS_PLAYER_MODE_INFO
	E_GMS_AP_PLAYER_3D_TEXT_INFO
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_GAME_MODES_CORE_SYSTEM
	#endinput
#endif
#define _INC_GAME_MODES_CORE_SYSTEM

/*

	* Enums *

*/

enum E_GMS_PLAYER_MODE_TIMER_INFO {
	GMT_None,
	GMT_Room,
	GMT_TDM,
	GMT_DM,
	GMT_Example
}

enum E_GMS_PLAYER_MODE_INFO {
	m_Mode,
	m_ModeSession,
	m_SessionSlot
}

enum E_GMS_AP_PLAYER_3D_TEXT_INFO {
	dt_Name[150],
	dt_Color,
	dt_TypeClick, // 0 - No / 1 - ALT
	Text3D:dt_3DText,
	Float:dt_PosX,
	Float:dt_PosY,
	Float:dt_PosZ,
	Float:dt_Radius,
	dt_PlayerID,
	dt_VehicleID,
	dt_LOST,
	bool:dt_Created
}

/*

	* Vars *

*/

static
	Mode_PlayerTimer[MAX_PLAYERS][E_GMS_PLAYER_MODE_TIMER_INFO];

static
	mPInfo[MAX_PLAYERS][E_GMS_PLAYER_MODE_INFO];

static
	players_in_mode[GM_MAX_MODES],
	players_in_session_mode[GM_MAX_MODES][GM_MAX_SESSIONS],
	slots_in_session_mode[GM_MAX_MODES][GM_MAX_SESSIONS][GM_MAX_SESSION_SLOTS];

static
	vworld_in_mode[GM_MAX_MODES][GM_MAX_SESSIONS],
	interior_in_mode[GM_MAX_MODES][GM_MAX_SESSIONS],
	weather_in_mode[GM_MAX_MODES][GM_MAX_SESSIONS],
	location_in_mode[GM_MAX_MODES][GM_MAX_SESSIONS],
	mode_in_session[GM_MAX_MODES][GM_MAX_SESSIONS];

static
	minutes_in_session_mode[GM_MAX_MODES][GM_MAX_SESSIONS],
	seconds_in_session_mode[GM_MAX_MODES][GM_MAX_SESSIONS];

static
	player_kills_match[MAX_PLAYERS],
	player_deaths_match[MAX_PLAYERS],
	player_exp_match[MAX_PLAYERS],
	player_money_match[MAX_PLAYERS];

static
	player_points_match[MAX_PLAYERS],
	ActionPlayerTDMatchPoints[MAX_PLAYERS],
	PlayerText:TD_MatchPoints[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

static
	PlayerText:TD_TimerSession[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...};

static
	AP_Player3DText[MAX_PLAYERS][MODE_AE_3D_TEXT_COUNT][E_GMS_AP_PLAYER_3D_TEXT_INFO];

static
	AdPlayerObject[MAX_PLAYERS][30];

static
	mode_ad_value[GM_MAX_MODES][GM_MAX_SESSIONS][30],
	Float:mode_ad_floatvalue[GM_MAX_MODES][GM_MAX_SESSIONS][30][3],

	AdPlayerValue[MAX_PLAYERS][30],
	Float:AdPlayerFloatValue[MAX_PLAYERS][30][3];

/*

	* Functions *

*/

stock Mode_SetPlayer(playerid, mode_id)
{
	mPInfo[playerid][m_Mode] = mode_id;
	return 1;
}

stock Mode_GetPlayer(playerid)
{
	return mPInfo[playerid][m_Mode];
}

stock M_GP(playerid)
{
	return mPInfo[playerid][m_Mode];
}

stock Mode_SetPlayerSession(playerid, session_id)
{
	mPInfo[playerid][m_ModeSession] = session_id;
	return 1;
}

stock Mode_GetPlayerSession(playerid)
{
	return mPInfo[playerid][m_ModeSession];
}

stock M_GPS(playerid)
{
	return mPInfo[playerid][m_ModeSession];
}

stock Mode_SetPlayerSlot(playerid, slot_id)
{
	mPInfo[playerid][m_SessionSlot] = slot_id;
	return 1;
}

stock Mode_GetPlayerSlot(playerid)
{
	return mPInfo[playerid][m_SessionSlot];
}

stock M_GPSlot(playerid)
{
	return mPInfo[playerid][m_SessionSlot];
}

stock Mode_SetPlayerVirtualWorld(playerid, mode_id, session_id)
{
	SetPlayerVirtualWorldEx(playerid, vworld_in_mode[mode_id][session_id]);
	return 1;
}

stock Mode_SetPlayerInterior(playerid, mode_id, session_id)
{
	SetPlayerInteriorEx(playerid, interior_in_mode[mode_id][session_id]);
	return 1;
}

stock Mode_SetPlayerWeather(playerid, mode_id, session_id)
{
	SetPlayerWeatherEx(playerid, weather_in_mode[mode_id][session_id]);
	return 1;
}

stock Mode_SetVirtualWorld(mode_id, session_id, world_id)
{
	vworld_in_mode[mode_id][session_id] = world_id;
	return 1;
}

stock Mode_GetVirtualWorld(mode_id, session_id)
{
	return vworld_in_mode[mode_id][session_id];
}

stock Mode_SetInterior(mode_id, session_id, interior_id)
{
	interior_in_mode[mode_id][session_id] = interior_id;
	return 1;
}

stock Mode_GetInterior(mode_id, session_id)
{
	return interior_in_mode[mode_id][session_id];
}

stock Mode_SetWeather(mode_id, session_id, weather_id)
{
	weather_in_mode[mode_id][session_id] = weather_id;

	m_for(mode_id, session_id, p)
		SetPlayerWeatherEx(p, weather_id);

	return 1;
}

stock Mode_GetWeather(mode_id, session_id)
{
	return weather_in_mode[mode_id][session_id];
}

stock Mode_SetMode(mode_id, session_id, gamemode_id)
{
	mode_in_session[mode_id][session_id] = gamemode_id;
	return 1;
}

stock Mode_GetMode(mode_id, session_id)
{
	return mode_in_session[mode_id][session_id];
}

/*
	Players in mode
*/

stock Mode_GetPlayers(mode_id)
{
	return players_in_mode[mode_id];
}

/*
	Players in session
*/

stock Mode_GiveSessionPlayers(mode_id, session_id, num)
{
	players_in_session_mode[mode_id][session_id] += num;
	return 1;
}

stock Mode_SetSessionPlayers(mode_id, session_id, num)
{
	players_in_session_mode[mode_id][session_id] = num;
	return 1;
}

stock Mode_GetSessionPlayers(mode_id, session_id)
{
	return players_in_session_mode[mode_id][session_id];
}

/*
	Slot player in session
*/

stock Mode_SetSessionSlot(mode_id, session_id, slot_id, num)
{
	slots_in_session_mode[mode_id][session_id][slot_id] = num;
	return 1;
}

stock Mode_GetSessionSlot(mode_id, session_id, slot_id)
{
	return slots_in_session_mode[mode_id][session_id][slot_id];
}

/*
	Minutes and seconds in session
*/

stock Mode_SetMinutes(mode_id, session_id, num)
{
	minutes_in_session_mode[mode_id][session_id] = num;
	return 1;
}

stock Mode_GetMinutes(mode_id, session_id) 
{
	return minutes_in_session_mode[mode_id][session_id];
}

stock Mode_SetSeconds(mode_id, session_id, num)
{
	seconds_in_session_mode[mode_id][session_id] = num;
	return 1;
}

stock Mode_GetSeconds(mode_id, session_id) 
{
	return seconds_in_session_mode[mode_id][session_id];
}

stock Mode_GetMaxQuestsProgress(mode_id)
{
	switch(mode_id) {
		case MODE_TDM: return TDM_MAX_QUESTS_PROGRESS;
		case MODE_DM: return DM_MAX_QUESTS_PROGRESS;
	}
	return 0;
}

stock Mode_GetMaxQuests(mode_id)
{
	switch(mode_id) {
		case MODE_TDM: return TDM_MAX_QUESTS;
		case MODE_DM: return DM_MAX_QUESTS;
	}
	return 0;
}

stock Mode_CheckQuestHead(playerid, mode_id) 
{
	switch(mode_id) {
		case MODE_TDM: {
			Quest_CheckPlayerProgress(playerid, MODE_TDM, 26);
		}
		case MODE_DM: {
			Quest_CheckPlayerProgress(playerid, MODE_DM, 1);
			Quest_CheckPlayerProgress(playerid, MODE_DM, 13);
		}
	}

	return 1;
}

stock Mode_SetPlayerKill(playerid, kills)
{
	if(kills)
		player_kills_match[playerid] += kills;
	else 
		player_kills_match[playerid] = 0;

	return 1;
}

stock Mode_GetPlayerKills(playerid) 
{
	return player_kills_match[playerid];
}

stock Mode_SetPlayerDeath(playerid, deaths)
{
	if(deaths)
		player_deaths_match[playerid] += deaths;
	else 
		player_deaths_match[playerid] = 0;

	return 1;
}

stock Mode_GetPlayerDeaths(playerid)
{
	return player_deaths_match[playerid];
}

stock Mode_SetPlayerMatchPoint(playerid, points)
{
	if(points)
		player_points_match[playerid] += points;
	else 
		player_points_match[playerid] = 0;

	Mode_UpdatePlayerMatchPoints(playerid);
	return 1;
}

stock Mode_GetPlayerMatchPoints(playerid)
{
	return player_points_match[playerid];
}

stock Mode_SetPlayerExp(playerid, exp)
{
	if(exp)
		player_exp_match[playerid] += exp;
	else 
		player_exp_match[playerid] = 0;

	return 1;
}

stock Mode_GetPlayerExp(playerid)
{
	return player_exp_match[playerid];
}

stock Mode_SetPlayerMoney(playerid, money)
{
	if(money)
		player_money_match[playerid] += money;
	else 
		player_money_match[playerid] = 0;

	return 1;
}

stock Mode_GetPlayerMoney(playerid)
{
	return player_money_match[playerid];
}

stock Mode_IsPlayerInPlayer(playerid, playerid_2)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	if(!IsPlayerInvalided(playerid_2))
		return 0;

	if(Mode_GetPlayer(playerid) == Mode_GetPlayer(playerid_2)
	&& Mode_GetPlayerSession(playerid) == Mode_GetPlayerSession(playerid_2))
		return 1;
	else
		return 0;
}

stock Mode_SendText(playerid, text[])
{
	static
		str[200];

	str[0] = EOS;

	f(str, "{FFCC33}[Р: %i]:{%06x}%s(%d): {FFFFFF}%s", GetPlayerRank(playerid), GetPlayerColorEx(playerid) >>> 8, NameEx(playerid), playerid, text);

	m_for(M_GP(playerid), M_GPS(playerid), p) {
		if(GetPlayerLogged(p)) 
			continue;

		SCMEX(p, -1, str, true);
	}
	return 1;
}

stock Mode_CheckOnPlayerKey(playerid)
{
	m_for(M_GP(playerid), M_GPS(playerid), p) {
		n_for(i, MODE_AE_3D_TEXT_COUNT) {
			if(!AP_Player3DText[p][i][dt_Created])
				continue;
				
			if(!AP_Player3DText[p][i][dt_TypeClick])
				continue;

			if(IsPlayerInRangeOfPoint(playerid, 1.3, AP_Player3DText[p][i][dt_PosX], AP_Player3DText[p][i][dt_PosY], AP_Player3DText[p][i][dt_PosZ])) {
				Mode_SetPlKeyAd3DText(playerid, M_GP(playerid), Mode_GetLocation(M_GP(playerid), M_GPS(playerid)), p, i);
				break;
			}
		}
	}
	return 1;
}

/*
	Additional Elements (AE) for player
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

stock Mode_SetPlAEValues(playerid)
{
	new
		mode_id = Mode_GetPlayer(playerid),
		session_id = Mode_GetPlayerSession(playerid);

	n_for(i, sizeof(AdPlayerValue[]))
		AdPlayerValue[playerid][i] = mode_ad_value[mode_id][session_id][i];

	n_for(i, sizeof(AdPlayerFloatValue[])) {
		AdPlayerFloatValue[playerid][i][0] = mode_ad_floatvalue[mode_id][session_id][i][0];
		AdPlayerFloatValue[playerid][i][1] = mode_ad_floatvalue[mode_id][session_id][i][1];
		AdPlayerFloatValue[playerid][i][2] = mode_ad_floatvalue[mode_id][session_id][i][2];
	}
	return 1;
}

stock Mode_ResetPlAEValues(playerid)
{
	n_for(i, sizeof(AdPlayerValue[]))
		AdPlayerValue[playerid][i] = 0;

	n_for(i, sizeof(AdPlayerFloatValue[])) {
		AdPlayerFloatValue[playerid][i][0] =
		AdPlayerFloatValue[playerid][i][1] =
		AdPlayerFloatValue[playerid][i][2] = 0.0;
	}
	return 1;
}

stock Mode_SetAEValue(mode_id, session_id, cell, value)
{
	mode_ad_value[mode_id][session_id][cell] = value;
	return 1;
}

stock Mode_GetAEValue(mode_id, session_id, cell)
{
	return mode_ad_value[mode_id][session_id][cell];
}

stock Mode_SetAEFloatValues(mode_id, session_id, cell, Float:X, Float:Y, Float:Z)
{
	mode_ad_floatvalue[mode_id][session_id][cell][0] = X;
	mode_ad_floatvalue[mode_id][session_id][cell][1] = Y;
	mode_ad_floatvalue[mode_id][session_id][cell][2] = Z;
	return 1;
}

stock Mode_GetAEFloatValues(mode_id, session_id, cell, num)
{
	return mode_ad_floatvalue[mode_id][session_id][cell][num];
}

stock Mode_SetPlAEValue(playerid, cell, value)
{
	AdPlayerValue[playerid][cell] = value;
	return 1;
}

stock Mode_GetPlAEValue(playerid, cell)
{
	return AdPlayerValue[playerid][cell];
}

stock Mode_SetPlAEFloatValue(playerid, cell, Float:X, Float:Y, Float:Z)
{
	AdPlayerFloatValue[playerid][cell][0] = X;
	AdPlayerFloatValue[playerid][cell][1] = Y;
	AdPlayerFloatValue[playerid][cell][2] = Z;
	return 1;
}

stock Mode_GetPlAEFloatValue(playerid, cell, &Float:X, &Float:Y, &Float:Z)
{
	X = AdPlayerFloatValue[playerid][cell][0];
	Y = AdPlayerFloatValue[playerid][cell][1];
	Z = AdPlayerFloatValue[playerid][cell][2];
	return 1;
}

/*
	3D Text
*/

stock Mode_CreatePlAE3DText(playerid, cell, const name[], color, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid_2, vehicleid, lost)
{
	if(AP_Player3DText[playerid][cell][dt_Created])
		return 0;

	strins(AP_Player3DText[playerid][cell][dt_Name], name, 0);
	AP_Player3DText[playerid][cell][dt_Color] = color;
	AP_Player3DText[playerid][cell][dt_TypeClick] = typeclick;
	AP_Player3DText[playerid][cell][dt_PosX] = pos_x;
	AP_Player3DText[playerid][cell][dt_PosY] = pos_y;
	AP_Player3DText[playerid][cell][dt_PosZ] = pos_z;
	AP_Player3DText[playerid][cell][dt_Radius] = radius;
	AP_Player3DText[playerid][cell][dt_PlayerID] = playerid;
	AP_Player3DText[playerid][cell][dt_VehicleID] = vehicleid;
	AP_Player3DText[playerid][cell][dt_LOST] = lost;
	AP_Player3DText[playerid][cell][dt_Created] = true;

	AP_Player3DText[playerid][cell][dt_3DText] = CreateDynamic3DTextLabel(name, color, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid_2, vehicleid, lost, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	return 1;
}

stock Mode_DestroyPlAE3DText(playerid, cell = -1)
{
	if(cell == -1) {
		n_for(i, MODE_AE_3D_TEXT_COUNT) {
			if(!AP_Player3DText[playerid][i][dt_Created])
				continue;

			DestroyDynamic3DTextLabel(AP_Player3DText[playerid][i][dt_3DText]);
			Mode_ResetPlAE3DTexts(playerid, i);
		}
	}
	else {
		if(!AP_Player3DText[playerid][cell][dt_Created])
			return 0;

		DestroyDynamic3DTextLabel(AP_Player3DText[playerid][cell][dt_3DText]);
		Mode_ResetPlAE3DTexts(playerid, cell);
	}
	return 1;
}

stock Mode_ResetPlAE3DTexts(playerid, cell = -1)
{
	if(cell == -1) {
		n_for(i, MODE_AE_3D_TEXT_COUNT) {
			AP_Player3DText[playerid][i][dt_Name][0] = EOS;
			AP_Player3DText[playerid][i][dt_Color] =
			AP_Player3DText[playerid][i][dt_TypeClick] = 0;
			AP_Player3DText[playerid][i][dt_PosX] =
			AP_Player3DText[playerid][i][dt_PosY] =
			AP_Player3DText[playerid][i][dt_PosZ] =
			AP_Player3DText[playerid][i][dt_Radius] = 0.0;
			AP_Player3DText[playerid][i][dt_PlayerID] =
			AP_Player3DText[playerid][i][dt_VehicleID] = -1;
			AP_Player3DText[playerid][i][dt_LOST] = 0;
			AP_Player3DText[playerid][i][dt_Created] = false;
			AP_Player3DText[playerid][i][dt_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		}
	}
	else {
		AP_Player3DText[playerid][cell][dt_Name][0] = EOS;
		AP_Player3DText[playerid][cell][dt_Color] =
		AP_Player3DText[playerid][cell][dt_TypeClick] = 0;
		AP_Player3DText[playerid][cell][dt_PosX] =
		AP_Player3DText[playerid][cell][dt_PosY] =
		AP_Player3DText[playerid][cell][dt_PosZ] =
		AP_Player3DText[playerid][cell][dt_Radius] = 0.0;
		AP_Player3DText[playerid][cell][dt_PlayerID] =
		AP_Player3DText[playerid][cell][dt_VehicleID] = -1;
		AP_Player3DText[playerid][cell][dt_LOST] = 0;
		AP_Player3DText[playerid][cell][dt_Created] = false;
		AP_Player3DText[playerid][cell][dt_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
	}
	return 1;
}

stock Mode_UpdatePlAE3DText(playerid, cell, color, text[])
{
	if(!AP_Player3DText[playerid][cell][dt_Created])
		return 0;

	AP_Player3DText[playerid][cell][dt_Name][0] = EOS;

	strins(AP_Player3DText[playerid][cell][dt_Name], text, 0);

	UpdateDynamic3DTextLabelText(AP_Player3DText[playerid][cell][dt_3DText], color, text);
	return 1;
}

/*
	Object
*/

stock Mode_CreatePlAEObject(p_object, cell, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
{
	if(IsValidDynamicObject(AdPlayerObject[p_object][cell]))
		return 0;

	AdPlayerObject[p_object][cell] = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
	return 1;
}

stock Mode_DestroyPlAEObject(playerid, cell = -1)
{
	if(cell == -1) {
		n_for(i, sizeof(AdPlayerObject[])) {
			if(!IsValidDynamicObject(AdPlayerObject[playerid][i]))
				continue;

			DestroyDynamicObject(AdPlayerObject[playerid][i]);
			AdPlayerObject[playerid][i] = INVALID_DYNAMIC_OBJECT_ID;
		}
	}
	else {
		if(!IsValidDynamicObject(AdPlayerObject[playerid][cell]))
			return 0;

		DestroyDynamicObject(AdPlayerObject[playerid][cell]);
		AdPlayerObject[playerid][cell] = INVALID_DYNAMIC_OBJECT_ID;
	}
	return 1;
}

stock Mode_SetPlAEObjectMaterial(playerid, cell, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0)
{
	if(!IsValidDynamicObject(AdPlayerObject[playerid][cell]))
		return 0;

	SetDynamicObjectMaterial(AdPlayerObject[playerid][cell], materialindex, modelid, txdname, texturename, materialcolor);
	return 1;
}

stock Mode_MovePlAEObject(playerid, cell, Float:x, Float:y, Float:z, Float:speed, Float:rx = -1000.0, Float:ry = -1000.0, Float:rz = -1000.0)
{
	if(!IsValidDynamicObject(AdPlayerObject[playerid][cell]))
		return 0;

	MoveDynamicObject(AdPlayerObject[playerid][cell], x, y, z, speed, rx, ry, rz);
	return 1;
}

stock Mode_GetPlAEObjectPos(playerid, cell, &Float:x, &Float:y, &Float:z)
{
	if(!IsValidDynamicObject(AdPlayerObject[playerid][cell]))
		return 0;

	GetDynamicObjectPos(AdPlayerObject[playerid][cell], x, y, z);
	return 1;
}

/*
	Game-modes
*/

stock Mode_EnteringPlayer(playerid, mode_id, session_id) 
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	players_in_mode[mode_id]++;
	players_in_session_mode[mode_id][session_id]++;

	switch(mode_id) {
		case MODE_ROOM: {
			if(Adm_GetPlayerSpectating(playerid)) {
				n_for(i, GM_MAX_SESSION_SLOTS) {
					if(slots_in_session_mode[mode_id][session_id][i] > -1) 
						continue;

					slots_in_session_mode[mode_id][session_id][i] = playerid;
					mPInfo[playerid][m_SessionSlot] = i;
					break;
				}
			}
		}
		default: {
			n_for(i, GM_MAX_SESSION_SLOTS) {
				if(slots_in_session_mode[mode_id][session_id][i] > -1)
					continue;

				slots_in_session_mode[mode_id][session_id][i] = playerid;
				mPInfo[playerid][m_SessionSlot] = i;
				break;
			}
		}
	}

	mPInfo[playerid][m_Mode] = mode_id;
	mPInfo[playerid][m_ModeSession] = session_id;
	return 1;
}

stock Mode_LeavingPlayer(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	if(Mode_GetPlayer(playerid) == -1)
		return 0;

	new
		mode_id = mPInfo[playerid][m_Mode],
		session_id = mPInfo[playerid][m_ModeSession],
		session_slot = mPInfo[playerid][m_SessionSlot];

	players_in_mode[mode_id]--;
	players_in_session_mode[mode_id][session_id]--;

	slots_in_session_mode[mode_id][session_id][session_slot] = slots_in_session_mode[mode_id][session_id][players_in_session_mode[mode_id][session_id]];
	mPInfo[slots_in_session_mode[mode_id][session_id][session_slot]][m_SessionSlot] = session_slot;
	slots_in_session_mode[mode_id][session_id][players_in_session_mode[mode_id][session_id]] = -1;

	mPInfo[playerid][m_Mode] = -1;
	mPInfo[playerid][m_ModeSession] =
	mPInfo[playerid][m_SessionSlot] = 0;
	return 1;
}

stock Mode_SetLocation(mode_id, session_id, loc_id)
{
	location_in_mode[mode_id][session_id] = loc_id;
	return 1;
}

stock Mode_GetLocation(mode_id, session_id)
{
	return location_in_mode[mode_id][session_id];
}

stock Mode_ErrorTextCMD(playerid, mode_id)
{
	switch(mode_id) {
		case MODE_NONE: {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данная команда работает только в главном меню!");
		}
		case MODE_ROOM: {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данная команда работает только в режиме Комнаты!");
		}
		case MODE_TDM: {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данная команда работает только в TDM режиме!");
		}
		case MODE_DM: {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данная команда работает только в DM режиме!");
		}
		case MODE_EXAMPLE: {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данная команда работает только в EXAMPLE режиме!");
		}
	}
	return 0;
}

stock Mode_UpdatePlayerMG(playerid)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_TDM: TDM_UpdatePlayerMG(playerid);
	}
	return 1;
}

stock Mode_SetPlKeyAd3DText(playerid, mode_id, location_id, p_3dtext, text_id)
{
	switch(mode_id) {
		case MODE_TDM: TDM_SetPlKeyAE3DText(playerid, location_id, p_3dtext, text_id);
	}
	return 1;
}

stock Mode_OnPlayerDeath(playerid, &killerid, &reason)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_NONE: None_OnPlayerDeath(playerid, killerid, reason);
		case MODE_ROOM: Room_OnPlayerDeath(playerid, killerid, reason);
		case MODE_TDM: TDM_OnPlayerDeath(playerid, killerid, reason);
		case MODE_DM: DM_OnPlayerDeath(playerid, killerid, reason);
		case MODE_EXAMPLE: Example_OnPlayerDeath(playerid, killerid, reason);
	}
	return 1;
}

stock Mode_OnPlayerSpawn(playerid)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_NONE: None_OnPlayerSpawn(playerid);
		case MODE_ROOM: Room_OnPlayerSpawn(playerid);
		case MODE_TDM: TDM_OnPlayerSpawn(playerid);
		case MODE_DM: DM_OnPlayerSpawn(playerid);
		case MODE_EXAMPLE: Example_OnPlayerSpawn(playerid);
	}
	return 1;
}

stock Mode_LeavePlayer(playerid)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_ROOM: Room_ExitPlayer(playerid, Mode_GetPlayerSession(playerid));
		default: {
			Mode_DestroyLocationPlayer(playerid);
			Mode_CreateLocationPlayer(playerid, MODE_NONE, 0);
		}
	}
	return 1;
}

stock Mode_GetPlayerSkin(playerid, mode_id)
{
	new 
		skin_id;

	switch(mode_id) {
		case MODE_TDM: skin_id = TDM_GetClassSkin(GetPlayerTeamEx(playerid), GetPlayerCustomClass(playerid), GetPlayerSex(playerid) - 1);
		default: skin_id = Inv_GetPlayerSkin(playerid);
	}
	return skin_id;
}

stock Mode_GetModeTimeRespawn(mode_id)
{
	switch(mode_id) {
		case MODE_ROOM: return ROOM_PLAYER_TIMER_RESPAWN;
		case MODE_TDM: return TDM_PLAYER_TIMER_RESPAWN;
		case MODE_DM: return DM_PLAYER_TIMER_RESPAWN;
		case MODE_EXAMPLE: return EXAMPLE_PLAYER_TIMER_RESPAWN;
		default: return 15;
	}
	return 1;
}

stock Mode_SetAddSpeedRespawn(playerid)
{
	SetPlayerSpeedRespawn(playerid, 1, true);
	UpdateBarTimeRespawn(playerid);

	if(GetPlayerSpeedRespawn(playerid) < gettime()) {
		if(GetPlayerSpectating(playerid) > -1) {
			Mode_OnPlayerSpawn(playerid);
		}
	}
	return 1;
}

stock Mode_GetBasicVirtualWorld(mode_id, session_id)
{
	new
		world_id = session_id;

	switch(mode_id) {
		case MODE_NONE: world_id = 0;
		case MODE_ROOM:	world_id += 1000;
		case MODE_TDM: world_id += 2000;
		case MODE_DM: world_id += 3000;
		case MODE_EXAMPLE: world_id += 4000;
	}
	return world_id;
}

stock Mode_GetBasicInterior(mode_id, session_id)
{
	new
		interior_id = session_id;

	switch(mode_id) {
		case MODE_NONE: interior_id = 0;
		case MODE_ROOM:	interior_id = 0;
		case MODE_TDM: interior_id = 0;
		case MODE_DM: interior_id = interior_in_mode[mode_id][session_id];
		case MODE_EXAMPLE: interior_id = 0;
	}
	return interior_id;
}

stock Mode_CreateLocation(mode_id, session_id, location_id, bool:start_server = false)
{
	switch(mode_id) {
		case MODE_ROOM: Room_CreateLocation(session_id);
		case MODE_TDM: TDM_CreateLocation(location_id, session_id, start_server);
		case MODE_DM: DM_CreateLocation(location_id, session_id, start_server);
		case MODE_EXAMPLE: Example_CreateLocation(location_id, session_id, start_server);
	}
	return 1;
}

stock Mode_DestroyLocation(mode_id, session_id)
{
	switch(mode_id) {
		case MODE_ROOM: Room_DestroyLocation(session_id);
		case MODE_TDM: TDM_DestroyLocation(session_id);
		case MODE_DM: DM_DestroyLocation(session_id);
		case MODE_EXAMPLE: Example_DestroyLocation(session_id);
	}
	return 1;
}

stock Mode_CreateLocationPlayer(playerid, mode_id, session_id, bool:set = true)
{
	PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
	ClosePlayerDialog(playerid);

	switch(mode_id) {
		case MODE_NONE: None_CreateLocationPlayer(playerid, session_id, set);
		case MODE_ROOM: Room_CreateLocationPlayer(playerid, session_id, set);
		case MODE_TDM: TDM_CreateLocationPlayer(playerid, session_id, set);
		case MODE_DM: DM_CreateLocationPlayer(playerid, session_id, set);
		case MODE_EXAMPLE: Example_CreateLocationPlayer(playerid, session_id);
	}

	Mode_CreatePlAEElements(playerid);

	if(Adm_IsAdminsSpecPlayer(playerid)) {
		foreach(new p:spec_admin_playerid[playerid])
			Mode_CreateLocationPlayer(p, mode_id, session_id, set);
	}
	return 1;
}

stock Mode_DestroyLocationPlayer(playerid, bool:reset = true)
{
	Mode_DestroyPlAEElements(playerid);

	switch(Mode_GetPlayer(playerid)) {
		case MODE_NONE: None_DestroyLocationPlayer(playerid, reset);
		case MODE_ROOM: Room_DestroyLocationPlayer(playerid, reset);
		case MODE_TDM: TDM_DestroyLocationPlayer(playerid, reset);
		case MODE_DM: DM_DestroyLocationPlayer(playerid, reset);
		case MODE_EXAMPLE: Example_DestroyLocationPlayer(playerid, reset);
	}

	if(reset) {
		Mode_SetPlayerVirtualWorld(playerid, MODE_NONE, 0);
		Mode_SetPlayerInterior(playerid, MODE_NONE, 0);
		Mode_SetPlayerWeather(playerid, MODE_NONE, 0);
	}

	ResetPlayerMG(playerid);
	ClosePlayerDialog(playerid);
	ClearKillFeed(playerid);
	CheckSpectatingPlayers(playerid, INVALID_PLAYER_ID);
	Mode_SetPlayerWeather(playerid, MODE_NONE, 0);
	DeletePVar(playerid, "Room_Exit_PVar");

	if(Adm_IsAdminsSpecPlayer(playerid)) {
		foreach(new p:spec_admin_playerid[playerid])
			Mode_DestroyLocationPlayer(p, reset);
	}
	return 1;
}

stock Mode_ChangeLocationSessions()
{
	n_for(i, TDM_MAX_GAME_SESSIONS)
		TDM_ChangeLocation(i);

	n_for(i, DM_MAX_GAME_SESSIONS)
		DM_ChangeLocation(i);

	n_for(i, EXAMPLE_MAX_GAME_SESSIONS)
		Example_ChangeLocation(EXAMPLE_LOC_DESERT);

	return 1;
}

stock Mode_SetPlayerTimer(playerid, mode_id)
{
	switch(mode_id) {
		case MODE_NONE: Mode_PlayerTimer[playerid][GMT_None] = SetPlayerTimer(playerid, "None_UpdatePlayer", 1000, true);
		case MODE_ROOM: Mode_PlayerTimer[playerid][GMT_Room] = SetPlayerTimer(playerid, "Room_UpdatePlayer", 1000, true);
		case MODE_TDM: Mode_PlayerTimer[playerid][GMT_TDM] = SetPlayerTimer(playerid, "TDM_UpdatePlayer", 1000, true);
		case MODE_DM: Mode_PlayerTimer[playerid][GMT_DM] = SetPlayerTimer(playerid, "DM_UpdatePlayer", 1000, true);
		case MODE_EXAMPLE: Mode_PlayerTimer[playerid][GMT_Example] = SetPlayerTimer(playerid, "Example_UpdatePlayer", 1000, true);
	}
	return 1;
}

stock Mode_KillPlayerTimer(playerid, mode_id)
{
	switch(mode_id) {
		case MODE_NONE: KillTimer(Mode_PlayerTimer[playerid][GMT_None]);
		case MODE_ROOM: KillTimer(Mode_PlayerTimer[playerid][GMT_Room]);
		case MODE_TDM: KillTimer(Mode_PlayerTimer[playerid][GMT_TDM]);
		case MODE_DM: KillTimer(Mode_PlayerTimer[playerid][GMT_DM]);
		case MODE_EXAMPLE: KillTimer(Mode_PlayerTimer[playerid][GMT_Example]);
	}
	return 1;
}

stock Mode_SetPlayerFee(playerid, exp, credit)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_ROOM: {
			Mode_SetPlayerExp(playerid, exp);
			Mode_SetPlayerMoney(playerid, credit);

			Mode_SetPlayerMatchPoint(playerid, credit);
		}
		case MODE_TDM: {
			Mode_SetPlayerExp(playerid, exp);
			Mode_SetPlayerMoney(playerid, credit);

			Mode_SetPlayerMatchPoint(playerid, credit);
		}
	}
	return 1;
}

stock Mode_SetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_TDM: TDM_LocSetPlayerMG(playerid, num, timer, count, value, ptime);
	}
	return 1;
}

stock Mode_ResetPlayerMG(playerid)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_TDM: TDM_LocResetPlayerMG(playerid);
	}
	return 1;
}

stock Mode_ShowDeadKiller(playerid, killerid) 
{
	new 
		kstrike = GetPlayerKillStrike(killerid) * 10;

	switch(Mode_GetPlayer(killerid)) {
		case MODE_ROOM: SetPlayerFee(killerid, 150 + kstrike, 100 + kstrike, REPLEN_KILL);
		case MODE_TDM: {
			if(!TDM_GetPlayerBagMoney(playerid))
				SetPlayerFee(killerid, 250 + kstrike, 150 + kstrike, REPLEN_KILL);
			else if(TDM_GetPlayerBagMoney(playerid))
				SetPlayerFee(killerid, 300 + kstrike, 200 + kstrike, REPLEN_BAG_OF_CREDITS);
		}
		case MODE_DM: SetPlayerFee(killerid, 200 + kstrike, 150 + kstrike, REPLEN_KILL);
		case MODE_EXAMPLE: SetPlayerFee(killerid, 250 + kstrike, 150 + kstrike, REPLEN_KILL);
	}
	return 1;
}

stock Mode_UpdateSpectateStatus(playerid, spectedid)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_TDM: return TDM_UpdateSpecStatus(playerid, spectedid);
	}
	return 0;
}

stock Mode_GivePlayerWeapon(playerid, weaponid, ammo)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_TDM: return TDM_GivePlayerWeapon(playerid, weaponid, ammo);
	}
	return 1;
}

stock Mode_UpdateTime()
{
	Room_UpdateTime();

	n_for(i, TDM_MAX_GAME_SESSIONS)
		TDM_UpdateTime(i);

	n_for(i, DM_MAX_GAME_SESSIONS)
		DM_UpdateTime(i);

	n_for(i, EXAMPLE_MAX_GAME_SESSIONS)
		Example_UpdateTime(i);

	return 1;
}

stock Mode_UpdateTime_2()
{
	n_for(i, TDM_MAX_GAME_SESSIONS)
		TDM_UpdateAir(i);

	return 1;
}

/*
	TextDraws's
*/

stock Mode_CreatePlayerMatchPoints(playerid)
{
	if(ActionPlayerTDMatchPoints[playerid] == TD_DESTROYED
	|| ActionPlayerTDMatchPoints[playerid] == TD_SHOWN)
		return 0;

	ActionPlayerTDMatchPoints[playerid] = TD_SHOWN;
	Mode_UpdatePlayerMatchPoints(playerid);
	PlayerTextDrawShow(playerid, TD_MatchPoints[playerid]);
	return 1;
}

stock Mode_DestroyPlayerMatchPoints(playerid, bool:hide = true)
{
	if(ActionPlayerTDMatchPoints[playerid] == TD_DESTROYED)
		return 0;

	if(hide) {
		if(ActionPlayerTDMatchPoints[playerid] != TD_HIDDEN) {
			ActionPlayerTDMatchPoints[playerid] = TD_HIDDEN;
			PlayerTextDrawHide(playerid, TD_MatchPoints[playerid]);
		}
	}
	else {
		ActionPlayerTDMatchPoints[playerid] = TD_DESTROYED;
		DestroyPlayerTD(playerid, TD_MatchPoints[playerid]);
	}
	return 1;
}

static Mode_UpdatePlayerMatchPoints(playerid)
{
	if(ActionPlayerTDMatchPoints[playerid] != TD_SHOWN)
		return 0;

	new
		str[30];

	f(str, "Очков матча:_%i", player_points_match[playerid]);
	PlayerTextDrawSetString(playerid, TD_MatchPoints[playerid], str);
	return 1;
}

stock Mode_ShowTDMatchPoints(playerid) 
{
	ActionPlayerTDMatchPoints[playerid] = TD_CREATED;

	TD_MatchPoints[playerid] = CreatePlayerTextDraw(playerid, 30.0000, 304.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_MatchPoints[playerid], 0.2081, 1.3840);
	PlayerTextDrawAlignment(playerid, TD_MatchPoints[playerid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MatchPoints[playerid], -325353729);
	PlayerTextDrawSetShadow(playerid, TD_MatchPoints[playerid], 1);
	PlayerTextDrawSetOutline(playerid, TD_MatchPoints[playerid], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_MatchPoints[playerid], 153);
	PlayerTextDrawFont(playerid, TD_MatchPoints[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MatchPoints[playerid], true);
	return 1;
}

stock Mode_CreatePlTDTimerSession(playerid) 
{
	TD_TimerSession[playerid] = CreatePlayerTextDraw(playerid, 321.000000, 14.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_TimerSession[playerid], 0.329000, 1.467259);
	PlayerTextDrawAlignment(playerid, TD_TimerSession[playerid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_TimerSession[playerid], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TimerSession[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TD_TimerSession[playerid], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_TimerSession[playerid], 13107);
	PlayerTextDrawFont(playerid, TD_TimerSession[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_TimerSession[playerid], true);
	PlayerTextDrawShow(playerid, TD_TimerSession[playerid]);
	return 1;
}

stock Mode_DestroyPlTDTimerSession(playerid)
{
	DestroyPlayerTD(playerid, TD_TimerSession[playerid]);
	return 1;
}

stock Mode_UpdatePlTDTimerSession(playerid, str[])
{
	PlayerTextDrawSetString(playerid, TD_TimerSession[playerid], str);
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerTDs(playerid)
{
	TD_MatchPoints[playerid] = PlayerText:INVALID_TEXT_DRAW;
	TD_TimerSession[playerid] = PlayerText:INVALID_TEXT_DRAW;
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock Mode_OnGameModeInit()
{
	n_for(i, MAX_PLAYERS)
		Room_OnGameModeInit(i);

	n_for(i, TDM_MAX_GAME_SESSIONS)
		TDM_OnGameModeInit(i);

	n_for(i, DM_MAX_GAME_SESSIONS)
		DM_OnGameModeInit(i);

	n_for(i, EXAMPLE_MAX_GAME_SESSIONS)
		Example_OnGameModeInit(i);
	
	// Игровые режимы
	n_for(m, GM_MAX_MODES) {
		players_in_mode[m] = 0;

		// Сессия
		n_for2(s, GM_MAX_SESSIONS) {
			players_in_session_mode[m][s] =
			vworld_in_mode[m][s] =
			interior_in_mode[m][s] =
			weather_in_mode[m][s] =
			location_in_mode[m][s] =
			mode_in_session[m][s] =
			minutes_in_session_mode[m][s] =
			seconds_in_session_mode[m][s] = 0;

			n_for3(i, sizeof(mode_ad_value[][]))
				mode_ad_value[m][s][i] = 0;

			n_for4(i, sizeof(mode_ad_floatvalue[][])) {
				mode_ad_floatvalue[m][s][i][0] =
				mode_ad_floatvalue[m][s][i][1] =
				mode_ad_floatvalue[m][s][i][2] = 0.0;
			}

			// Слоты
			n_for5(sl, GM_MAX_SESSION_SLOTS)
				slots_in_session_mode[m][s][sl] = -1;
		}
	}

	Mode_ChangeLocationSessions();
	return 1;
}

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerTDs(playerid);
	
	mPInfo[playerid][m_Mode] = -1;
	mPInfo[playerid][m_ModeSession] =
	mPInfo[playerid][m_SessionSlot] = 0;

	player_kills_match[playerid] =
	player_deaths_match[playerid] =
	player_exp_match[playerid] =
	player_money_match[playerid] =
	player_points_match[playerid] = 0;

	ActionPlayerTDMatchPoints[playerid] = TD_DESTROYED;

	Mode_ResetPlAE3DTexts(playerid);
	Mode_ResetPlAEValues(playerid);

	n_for(i, sizeof(AdPlayerObject[]))
		AdPlayerObject[playerid][i] = INVALID_DYNAMIC_OBJECT_ID;

	#if defined Mode_OnPlayerConnect
		return Mode_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerClickPlayerTextDraw
*/

stock Mode_OnPlayerClickPTextDraw(playerid, PlayerText:playertextid)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_TDM: return TDM_OnPlayerClickPTextDraw(playerid, playertextid);
	}
	return 0;
}

/*
	OnPlayerKeyStateChange
*/

stock Mode_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_ROOM: return Room_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
		case MODE_TDM: return TDM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
		case MODE_DM: return DM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	}
	return 0;
}

/*
	OnPlayerPickUpDynamicPickup
*/

stock Mode_OnPlPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_TDM: return TDM_OnPlPickUpDynamicPickup(playerid, pickupid);
	}
	return 0;
}

/*
	OnPlayerEnterDynamicArea
*/

stock Mode_OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_ROOM: Room_OnPlayerEnterDynamicArea(playerid, areaid);
		case MODE_TDM: TDM_OnPlayerEnterDynamicArea(playerid, areaid);
		case MODE_DM: DM_OnPlayerEnterDynamicArea(playerid, areaid);
	}
	return 0;
}

/*
	OnPlayerLeaveDynamicArea
*/

stock Mode_OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_ROOM: Room_OnPlayerLeaveDynamicArea(playerid, areaid);
		case MODE_TDM: TDM_OnPlayerLeaveDynamicArea(playerid, areaid);
		case MODE_DM: DM_OnPlayerLeaveDynamicArea(playerid, areaid);
	}
	return 0;
}

/*
	OnPlayerDamage
*/

stock Mode_OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_ROOM: Room_OnPlayerDamage(playerid, amount, issuerid);
		case MODE_TDM: TDM_OnPlayerDamage(playerid, amount, issuerid, weapon, bodypart);
		case MODE_DM: DM_OnPlayerDamage(playerid, amount, issuerid, weapon, bodypart);
		case MODE_EXAMPLE: Example_OnPlayerDamage(playerid, issuerid, weapon, amount, bodypart);
	}
	return 1;
}

/*
	OnPlayerText
*/

stock Mode_OnPlayerText(playerid, text[])
{
	switch(Mode_GetPlayer(playerid)) {
		case MODE_TDM: return TDM_OnPlayerText(playerid, text);
	}
	return 0;
}

/*
	ALS
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