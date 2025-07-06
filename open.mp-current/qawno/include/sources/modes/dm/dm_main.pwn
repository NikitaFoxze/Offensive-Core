/*
 * |>=======================<|
 * |   About: Mode DM main   |
 * |   Author: Foxze         |
 * |>=======================<|
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
	- OnPlayerEnterPlayerGangZone(playerid, zoneid)
	- OnPlayerLeavePlayerGangZone(playerid, zoneid)
 * Stock:
	- DM_CreateSession(sessionid)
	- DM_DestroySession(sessionid)
	- DM_CreateFirstSessions()

	- DM_CreateLocation(sessionid, locationid)
	- DM_DestroyLocation(sessionid)
	- DM_CreatePlayerLocation(playerid, sessionid)
	- DM_DestroyPlayerLocation(playerid)

	- DM_UpdateModeData(sessionid)
	- DM_UpdatePlayerData(playerid)
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

#if defined _INC_DM_MAIN
	#endinput
#endif
#define _INC_DM_MAIN

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	TOPPlayersData[GMS_MAX_SESSIONS][MAX_PLAYERS][3],
	TOPPlayersName[GMS_MAX_SESSIONS][MAX_PLAYERS][MAX_PLAYER_NAME],
	TOPTempVar[GMS_MAX_SESSIONS];

static
	LocationGameStatus[GMS_MAX_SESSIONS];

static
	PlayerText:TD_TopKillers[MAX_PLAYERS][DM_TD_TOP_KILLERS];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>----------------------------<|
 * |   Session create & destroy   |
 * |>----------------------------<|
 */

stock DM_CreateSession(sessionid)
{
	new 
		locationid = Iter_Random(Locations[MODE_DM]);

	Mode_DestroySessionLocation(MODE_DM, sessionid);
	Mode_CreateSessionLocation(MODE_DM, sessionid, locationid);
	return 1;
}

stock DM_DestroySession(sessionid)
{
	ResetSessionData(sessionid);
	return 1;
}

stock DM_CreateFirstSessions()
{
	n_for(i, 7) {
		Mode_CreateSession(MODE_DM);
	}
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Location create & destroy   |
 * |>-----------------------------<|
 */

stock DM_CreateLocation(sessionid, locationid)
{
	LocationGameStatus[sessionid] = DM_LOC_GAME_STATUS_GAME;

	DM_CreateElementsLocation(sessionid, locationid);
	return 1;
}

stock DM_DestroyLocation(sessionid)
{
	DM_DestroyElementsLocation(sessionid);
	return 1;
}

stock DM_CreatePlayerLocation(playerid, sessionid)
{
	#pragma unused sessionid

	SetPlayerActionZone(playerid, false);
	SetPlayerDamage(playerid, true);

	SettingsPlayerSpawn(playerid);

	DM_ShowPlayerElementsLocation(playerid);

	if (!GetAdminSpectating(playerid)) {
		ShowPlayerBaseIndicatorsTD(playerid);
		ShowPlayerNewGraphTD(playerid);
		CreatePlayerAfterDeadTD(playerid);

		CreatePlayerTopKillersTD(playerid);

		n_for(i, DM_TD_TOP_KILLERS) {
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][i]);
		}

		TogglePlayerControllable(playerid, true);

		CancelSelectTextDraw(playerid);
		SetCameraBehindPlayer(playerid);

		SetPlayerTeamEx(playerid, NO_TEAM);
		SetPlayerSkinEx(playerid, GetPlayerInvSkin(playerid));

		ShowPlayerNewGraphTD(playerid);
		ShowPlayerMatchStatsTD(playerid);

		PlayerSpawn(playerid);
	}
	return 1;
}

stock DM_DestroyPlayerLocation(playerid)
{
	DM_HidePlayerElementsLocation(playerid);

	DestroyTopKillersTD(playerid);
	return 1;
}

/*
 * |>----------------------<|
 * |   Timers update data   |
 * |>----------------------<|
 */

stock DM_UpdateModeData(sessionid)
{
	if (LocationGameStatus[sessionid] != DM_LOC_GAME_STATUS_GAME) {
		return 1;
	}

	UpdateTopKillersTD(sessionid);

	if (Mode_GetSessionActiveTimer(MODE_DM, sessionid)) {
		if (Mode_GetSessionSeconds(MODE_DM, sessionid) > 0 
		&& Mode_GetSessionSeconds(MODE_DM, sessionid) <= 60) {
			Mode_SetSessionSeconds(MODE_DM, sessionid, Mode_GetSessionSeconds(MODE_DM, sessionid) - 1);
		}

		if (Mode_GetSessionSeconds(MODE_DM, sessionid) <= 0
		&& Mode_GetSessionMinutes(MODE_DM, sessionid) > 0) {
			Mode_SetSessionMinutes(MODE_DM, sessionid, Mode_GetSessionMinutes(MODE_DM, sessionid) - 1);
			Mode_SetSessionSeconds(MODE_DM, sessionid, 60);
		}

		if (Mode_GetSessionSeconds(MODE_DM, sessionid) <= 0
		&& Mode_GetSessionMinutes(MODE_DM, sessionid) <= 0) {
			ShowLocationEndGame(sessionid);
		}
	}
	return 1;
}

stock DM_UpdatePlayerData(playerid)
{
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));
	UpdatePlayerDropTokens(playerid);

	if (GetPlayerDead(playerid) == PLAYER_DEATH_NONE) {
		if (!GetPlayerLastDamage(playerid)) {
			new 
				Float:hp;

			GetPlayerHealthEx(playerid, hp);

			if (hp < 100.0) {
				SetPlayerHealthEx(playerid, hp + 1);
			}
		}
	}
	else {
		if (GetPlayerDead(playerid) == PLAYER_DEATH_KILLER) {
			UpdateBarTimeRespawn(playerid);
		}
		else {
			UpdatePlayerSpeedRespawn(playerid);
		}

		if (GetPlayerSpeedRespawn(playerid) <= 0) {
			DM_OnPlayerSpawn(playerid);
		}
	}

	GivePlayerSecondTime(playerid);
	return 1;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

static ShowLocationEndGame(sessionid)
{
	LocationGameStatus[sessionid] = DM_LOC_GAME_STATUS_GAME;

	new 
		locationid = Iter_Random(Locations[MODE_DM]);

	Mode_DestroySessionLocation(MODE_DM, sessionid);
	Mode_CreateSessionLocation(MODE_DM, sessionid, locationid);

	m_for(MODE_DM, sessionid, p) {
		GameTextForPlayer(p, "~y~Смена локации", 3000, 3);

		if (GetAdminSpectating(p)) {
			continue;
		}

		if (GetPlayerDead(p) == PLAYER_DEATH_NONE) {
			continue;
		}

		new
			Float:x, Float:y, Float:z,
			spawn = random(DM_MAX_SPAWN_POS);

		DM_GetSpawnPos(sessionid, spawn, x, y, z);
		SetPlayerPosEx(p, x, y, z + 0.1, GetPlayerVirtualWorldEx(p), GetPlayerInteriorEx(p));
	}
	return 1;
}

static UpdateTopKillersTD(sessionid)
{
	m_for(MODE_DM, sessionid, p) {
		if (GetAdminSpectating(p)) {
			continue;
		}

		TOPPlayersData[sessionid][TOPTempVar[sessionid]][0] = Mode_GetPlayerMatchKills(p);
		TOPPlayersData[sessionid][TOPTempVar[sessionid]][2] = Mode_GetPlayerMatchDeaths(p);

		GetPlayerName(p, TOPPlayersName[sessionid][p], MAX_PLAYER_NAME);
		TOPPlayersData[sessionid][TOPTempVar[sessionid]++][1] = p;
	}
	for (new i = 0, j = 0; i < TOPTempVar[sessionid]; i++) {
		j = TOPPlayersData[sessionid][i][0];

		for (new k = i - 1; k > -1; k--) {
			if (j > TOPPlayersData[sessionid][k][0]) {
				TOPPlayersData[sessionid][k][0] ^= TOPPlayersData[sessionid][k + 1][0], TOPPlayersData[sessionid][k + 1][0] ^= TOPPlayersData[sessionid][k][0], TOPPlayersData[sessionid][k][0] ^= TOPPlayersData[sessionid][k + 1][0];
				TOPPlayersData[sessionid][k][1] ^= TOPPlayersData[sessionid][k + 1][1], TOPPlayersData[sessionid][k + 1][1] ^= TOPPlayersData[sessionid][k][1], TOPPlayersData[sessionid][k][1] ^= TOPPlayersData[sessionid][k + 1][1];
			}
		}
	}

	m_for(MODE_DM, sessionid, p) {
		if (GetAdminSpectating(p)) {
			continue;
		}

		UpdatePlayerTopKillersTD(p);
	}

	ResetTopPlayersData(sessionid);
	return 1;
}

static UpdatePlayerTopKillersTD(playerid)
{
	new
		sessionid = M_GPS(playerid);

	for (new i = 0, tdid = 4; i < 5; i++, tdid += 2) {
		if (TOPPlayersData[sessionid][i][1] > -1) {
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][tdid], "%i._%s", i + 1, TOPPlayersName[sessionid][TOPPlayersData[sessionid][i][1]]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][tdid + 1], "%i", TOPPlayersData[sessionid][i][0]);

			if (TOPPlayersData[sessionid][i][1] == playerid) {
				PlayerTextDrawColour(playerid, TD_TopKillers[playerid][tdid], 0xd9832eFF);
				PlayerTextDrawShow(playerid, TD_TopKillers[playerid][tdid]);

				PlayerTextDrawColour(playerid, TD_TopKillers[playerid][tdid + 1], 0xd9832eFF);
				PlayerTextDrawShow(playerid, TD_TopKillers[playerid][tdid + 1]);
			}
			else {
				PlayerTextDrawColour(playerid, TD_TopKillers[playerid][tdid], -606348801);
				PlayerTextDrawShow(playerid, TD_TopKillers[playerid][tdid]);

				PlayerTextDrawColour(playerid, TD_TopKillers[playerid][tdid + 1], -606348801);
				PlayerTextDrawShow(playerid, TD_TopKillers[playerid][tdid + 1]);	
			}
		}
	}
	return 1;
}

static CreatePlayerTopKillersTD(playerid)
{
	new
		tdid = 0;

	DM_CreatePlayerTopKillersTD(playerid, TD_TopKillers[playerid], 0.0, 0.0, true, tdid);

	new
		Float:initialCoords[2] = {524.0, 372.0};

	n_for(i, 5) {
		DM_CreatePlayerTopKillersTD(playerid, TD_TopKillers[playerid], initialCoords[0], initialCoords[1], false, tdid);
		initialCoords[1] += 11.0;
	}
	return 1;
}

static DestroyTopKillersTD(playerid)
{
	n_for(i, DM_TD_TOP_KILLERS) {
		DestroyPlayerTD(playerid, TD_TopKillers[playerid][i]);
	}
	return 1;
}

static SettingsPlayerSpawn(playerid)
{
	new
		Float:X, Float:Y, Float:Z,
		skinid = Mode_GetPlayerSkin(playerid, MODE_DM);

	new
		sessionid = Mode_GetPlayerSession(playerid),
		spawn = random(DM_MAX_SPAWN_POS);

	Mode_SetPlayerVirtualWorld(playerid, MODE_DM, sessionid);
	Mode_SetPlayerInterior(playerid, MODE_DM, sessionid);

	DM_GetSpawnPos(sessionid, spawn, X, Y, Z);
	SetSpawnInfoEx(playerid, skinid, X, Y, Z + 0.1, 0.0);
	return 1;
}

static SetPlayerAmmunition(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerArmourEx(playerid, 30.0);

	SetPlayerSkinEx(playerid, GetPlayerSkinEx(playerid));
	SetPlayerColorEx(playerid, 0xCCCCCCBB);

	SetPlayerAttachInvItem(playerid);

	switch (Mode_GetSessionGameMode(MODE_DM, sessionid)) {
		case DM_GAME_MODE_NORMAL: {
			GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 100000);
			GivePlayerWeaponEx(playerid, WEAPON_M4, 100000);
			GivePlayerWeaponEx(playerid, WEAPON_SHOTGUN, 100000);
		}
		case DM_GAME_MODE_DEAGLE: {
			GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 100000);
		}
		case DM_GAME_MODE_SNIPER: {
			GivePlayerWeaponEx(playerid, WEAPON_SNIPER, 100000);
		}
	}
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetSessionData(sessionid)
{
	DM_LocResetSessionData(sessionid);

	LocationGameStatus[sessionid] = 0;
	ResetTopPlayersData(sessionid);
	return 1;
}

static ResetTopPlayersData(sessionid)
{
	n_for(b, 5) {
		TOPPlayersData[sessionid][b][0] =
		TOPPlayersData[sessionid][b][1] =
		TOPPlayersData[sessionid][b][2] = -1;
		TOPPlayersName[sessionid][b][0] = EOS;
	}
	TOPTempVar[sessionid] = 0;
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(i, DM_TD_TOP_KILLERS) {
		TD_TopKillers[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
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

stock DM_OnGameModeInit()
{
	// Reset sessions
	n_for(sessionid, GMS_MAX_SESSIONS) {
		ResetSessionData(sessionid);
	}

	// Initialization
	DM_LocOnGameModeInit();

	Mode_Add(MODE_DM, "DM", "DeathMatch",
		.enableStatus = true,
		.maxSessions = 20,
		.sessionMaxPlayers = 10,
		.changeEnableStatus = true,
		.changeSession = true,
		.changeSessionLocation = true);

	Mode_SetInfo(MODE_DM, "-");

	Mode_AddGameMode(MODE_DM, DM_GAME_MODE_NORMAL, "Стандартный");
	Mode_SetGameModeInfo(MODE_DM, DM_GAME_MODE_NORMAL,
		"-");

	Mode_AddGameMode(MODE_DM, DM_GAME_MODE_DEAGLE, "+C");
	Mode_SetGameModeInfo(MODE_DM, DM_GAME_MODE_DEAGLE,
		"-");

	Mode_AddGameMode(MODE_DM, DM_GAME_MODE_SNIPER, "Снайпер");
	Mode_SetGameModeInfo(MODE_DM, DM_GAME_MODE_SNIPER,
		"-");

	// Sessions
	Mode_CreateFirstSessions(MODE_DM);
	return 1;
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerTDs(playerid);

	#if defined DM_OnPlayerConnect
		return DM_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>-----------------<|
 * |   OnPlayerSpawn   |
 * |>-----------------<|
 */

stock DM_OnPlayerSpawn(playerid)
{
	if (GetAdminSpectating(playerid)) {
		return 1;
	}

	if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
		if (GetPlayerSpecatingPlayers(GetPlayerSpectating(playerid)) > 0) {
			RemovePlayerSpectatingPlayer(GetPlayerSpectating(playerid), playerid);
		}
	}

	// Respawn
	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		RemovePlayerDead(playerid);
		WC_PlayerDeathRespawn(playerid);
		return 1;
	}

	SettingsPlayerSpawn(playerid);

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, GetPlayerMoneyEx(playerid));
	ResetPlayerWeaponsEx(playerid);

	SetPlayerTeamEx(playerid, NO_TEAM);

	SetPlayerAmmunition(playerid);
	SetPlayerSpawnKill(playerid);

	DM_SpawnPlayerInArea(playerid);
	SetPlayerActionZone(playerid, true);

	CheckPlayerDinaHint(playerid, 8);
	return 1;
}

/*
 * |>-----------------<|
 * |   OnPlayerDeath   |
 * |>-----------------<|
 */

stock DM_OnPlayerDeath(playerid, &killerid, &WEAPON:reason)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	CheckSpectatingPlayers(playerid, killerid);

	if (killerid != INVALID_PLAYER_ID) {
		AddPlayerSpecatingPlayer(killerid, playerid);
	}

	CheckPlayerDamageBody(playerid);

	SetPlayerDamage(playerid, false);
	Mode_GivePlayerMatchDeaths(playerid, 1);

	m_for(MODE_DM, sessionid, p) {
		SendDeathMessageToPlayer(p, killerid, playerid, reason);
	}

	DestroyPlayerBelowHealth(playerid);

	if (DM_GetTokens(sessionid)) {
		CreatePlayerDropToken(playerid);
	}

	SetPlayerHealthEx(killerid, 100.0);

	if (killerid != INVALID_PLAYER_ID) {
		// Reward
		new 
			killStrike = GetPlayerKillStrike(killerid) * 10;

		GivePlayerReward(killerid, 200 + killStrike, 150 + killStrike, REWARD_KILL);

		// Quests
		CheckPlayerQuestProgress(killerid, MODE_DM, 0);
		CheckPlayerQuestProgress(killerid, MODE_DM, 2);

		if (GetPlayerWeapon(killerid) == WEAPON_DEAGLE) {
			CheckPlayerQuestProgress(killerid, MODE_DM, 4);
		}

		if (GetPlayerWeapon(killerid) == WEAPON_M4) {
			CheckPlayerQuestProgress(killerid, MODE_DM, 5);
		}

		if (GetPlayerWeapon(killerid) == WEAPON_SNIPER) {
			CheckPlayerQuestProgress(killerid, MODE_DM, 6);
		}

		CheckPlayerQuestProgress(killerid, MODE_DM, 8);

		if (GetPlayerColdWeapon2(killerid)) {
			CheckPlayerQuestProgress(killerid, MODE_DM, 9);
		}

		if (GetPlayerWeapon(killerid) == WEAPON_SHOTGUN 
		|| GetPlayerWeapon(killerid) == WEAPON_SHOTGSPA) {
			CheckPlayerQuestProgress(killerid, MODE_DM, 10);
		}

		CheckPlayerQuestProgress(killerid, MODE_DM, 11);

		if (GetPlayerWeapon(killerid) == WEAPON_DEAGLE) {
			CheckPlayerQuestProgress(killerid, MODE_DM, 14);
		}

		// Technical
		Mode_GivePlayerMatchKills(killerid, 1);
	}
	SetPlayerQuestProgress(playerid, MODE_DM, 8, 0);

	if (killerid != INVALID_PLAYER_ID) {
		SetPlayerSpeedRespawn(playerid, DM_PLAYER_TIMER_RESPAWN);
	}
	else { 
		SetPlayerSpeedRespawn(playerid, TIMER_PLAYER_RESPAWN);
	}

	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

stock DM_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	#pragma unused oldkeys

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 0;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Anti +C
	if (Mode_GetSessionGameMode(MODE_DM, sessionid) != DM_GAME_MODE_DEAGLE) {
		if ((newkeys & (KEY_FIRE | KEY_CROUCH)) == (KEY_FIRE | KEY_CROUCH)
		&& (oldkeys & (KEY_FIRE | KEY_CROUCH)) != (KEY_FIRE | KEY_CROUCH)) {
			DeaglePlayerAntiC(playerid);
			return 1;
		}
	}
	return 0;
}

/*
 * |>-------------------------------<|
 * |   OnPlayerEnterPlayerGangZone   |
 * |>-------------------------------<|
 */

stock DM_OnPlayerEnterPlayerGZ(playerid, zoneid)
{
	DM_LocOnPlayerEnterPlayerGZ(playerid, zoneid);
    return 0;
}

/*
 * |>-------------------------------<|
 * |   OnPlayerLeavePlayerGangZone   |
 * |>-------------------------------<|
 */

stock DM_OnPlayerLeavePlayerGZ(playerid, zoneid)
{
	DM_LocOnPlayerLeavePlayerGZ(playerid, zoneid);
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
#define OnPlayerConnect DM_OnPlayerConnect
#if defined DM_OnPlayerConnect
	forward DM_OnPlayerConnect(playerid);
#endif