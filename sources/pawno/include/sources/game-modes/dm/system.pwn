/*

	About: DM core system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerSpawn(playerid)
		OnPlayerDeath(playerid, &killerid, &reason)
		OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
		
		DM_UpdatePlayer(playerid)
	Stock:
		DM_CreateLocationPlayer(playerid, session_id, set)
		DM_DestroyLocationPlayer(playerid, reset)
		DM_CreateLocation(location_id, session_id, bool:start_server = false)
		DM_DestroyLocation(session_id)
		DM_LocationEndGame(session_id, nextlocation = -1)
		DM_ChangeLocation(session_id)
		DM_UpdateTime(session_id)
Enums:
	-
Commands:
	-
Dialogs:
	DM_SelectPlaySession
	DM_SelectSession
	DM_SelectLocation
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_CORE_SYSTEM
	#endinput
#endif
#define _INC_DM_CORE_SYSTEM

/*

	* Vars *

*/

static
	players_Data[DM_MAX_GAME_SESSIONS][MAX_PLAYERS][3],
	players_Name[DM_MAX_GAME_SESSIONS][MAX_PLAYERS][MAX_PLAYER_NAME],
	tempVar[DM_MAX_GAME_SESSIONS];

static
	dm_location_game_status[DM_MAX_GAME_SESSIONS];

static
	PlayerText:TD_TopKillers[MAX_PLAYERS][14];

/*

	* Functions *

*/

stock DM_CreateLocationPlayer(playerid, session_id, set)
{
	if(set)
		Mode_EnteringPlayer(playerid, MODE_DM, session_id);

	Mode_SetPlayerVirtualWorld(playerid, MODE_DM, session_id);
	Mode_SetPlayerInterior(playerid, MODE_DM, session_id);
	Mode_SetPlayerWeather(playerid, MODE_DM, session_id);

	SetPlayerZone(playerid, false);
	SetPlayerBusy(playerid, GAME);
	SetPlayerDamage(playerid, true);

	SettingsPlayerSpawn(playerid);

	DM_ShowPlayerElementsLocation(playerid);

	if(!Adm_GetPlayerSpectating(playerid)) {		
		ShowPlayerTDBarHealth(playerid);
		ShowPlayerTDBarArmour(playerid);
		ShowTDPlayerFPSandPING(playerid);
		ShowTDPlayerStatsRound(playerid);
		ShowTDDeath(playerid);
		ShowTDDeadKiller(playerid);

		ShowTDTopKillers(playerid);

		n_for(i, sizeof(TD_TopKillers[]))
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][i]);

		TogglePlayerControllable(playerid, true);

		CancelSelectTextDraw(playerid);
		SetCameraBehindPlayer(playerid);

		SetPlayerTeamEx(playerid, NO_TEAM);
		SetPlayerSkinEx(playerid, Inv_GetPlayerSkin(playerid));

		CreatePlayerBaseIndicators(playerid);
		CreatePlayerFPSandPING(playerid);
		CreatePlayerStatsRound(playerid);

		PlayerSpawn(playerid);
	}

	Mode_SetPlayerTimer(playerid, MODE_DM);
	return 1;
}

stock DM_DestroyLocationPlayer(playerid, reset)
{
	SetPlayerZone(playerid, false);

	DM_HidePlayerElementsLocation(playerid);

	SetPlayerKillStrike(playerid, 0);
	HidePlayerKillStrike(playerid);
	DestroyPlayerSpawnKill(playerid);
	Damage_DeletePlayerIndicator(playerid);
	DestroyPlayerBaseIndicators(playerid, false);
	DestroyPlayerFPSandPING(playerid, false);
	DestroyPlayerStatsRound(playerid, false);
	DestroyPlayerDeadKiller(playerid, 3, false);
	DestroyTDTopKillers(playerid);
	DestroyPlayerReward(playerid);
	Damage_ResetPlayerBody(playerid);
	DropT_DestroyPlayerToken(playerid);
	HidePlayerExitZone(playerid);
	ResetPlayerWeaponsEx(playerid);
	DestroyPlayerAttachedObjects(playerid);

	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerTeamEx(playerid, DM_TEAM_NONE);
	Mode_SetPlayerKill(playerid, 0);
	Mode_SetPlayerDeath(playerid, 0);

	Mode_SetPlayerExp(playerid, 0);
	Mode_SetPlayerMoney(playerid, 0);

	if(reset)
		Mode_LeavingPlayer(playerid);

	Mode_KillPlayerTimer(playerid, MODE_DM);
	return 1;
}

stock DM_CreateLocation(location_id, session_id, bool:start_server = false)
{
	// Удаление предыдущей локации
	if(!start_server) {
		m_for(MODE_DM, session_id, p) {
			if(Adm_GetPlayerSpectating(p)) 
				continue;

			Mode_DestroyLocationPlayer(p, false);
		}
		Mode_DestroyLocation(MODE_DM, session_id);
	}

	// Создание локации
	Mode_SetLocation(MODE_DM, session_id, location_id);
	Mode_SetMode(MODE_DM, session_id, DM_GetModeLocation(location_id));
	dm_location_game_status[session_id] = DM_LOC_GAME_STATUS_GAME;

	DM_CreateElementsLocation(session_id);

	m_for(MODE_DM, session_id, p) {
		if(Adm_GetPlayerSpectating(p)) 
			continue;

		Mode_CreateLocationPlayer(p, MODE_DM, session_id, false);
	}
	return 1;
}

stock DM_DestroyLocation(session_id)
{
	DM_DestroyElementsLocation(session_id);
	return 1;
}

stock DM_LocationEndGame(session_id, nextlocation = -1)
{
	dm_location_game_status[session_id] = DM_LOC_GAME_STATUS_GAME;

	if(nextlocation == -1)
		DM_ChangeLocation(session_id);
	else
		Mode_CreateLocation(MODE_DM, session_id, nextlocation);

	m_for(MODE_DM, session_id, p) {
		GameTextForPlayer(p, "~y~Смена локации", 3000, 3);
		if(Adm_GetPlayerSpectating(p)) 
			continue;

		if(GetPlayerDead(p)) {
			new
				Float:x, Float:y, Float:z,
				spawn = random(DM_MAX_SPAWN_POS);

			DM_GetSpawnPos(session_id, spawn, x, y, z);
			SetPlayerPosEx(p, x, y, z + 0.1, GetPlayerVirtualWorldEx(p), GetPlayerInteriorEx(p));
		}
	}
	return 1;
}

stock DM_ChangeLocation(session_id)
{
	new 
		location_id = random(DM_MAX_LOCATIONS);

	if(location_id == Mode_GetLocation(MODE_DM, session_id)) 
		return DM_ChangeLocation(session_id);

	Mode_CreateLocation(MODE_DM, session_id, location_id, true);
	return 1;
}

publics DM_UpdatePlayer(playerid)
{
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));
	UpdatePlayerKillStrike(playerid);
	UpdatePlayerNewRank(playerid);
	UpdatePlayerReward(playerid);
	UpdatePlayerSpawnKill(playerid);
	UpdatePlayerExitZone(playerid);
	UpdatePlayerFPSandPING(playerid);
	DropT_PlayerUpdate(playerid);

	if(!GetPlayerDead(playerid)) {
		if(GetPlayerBeDamage(playerid)) {
			if(GetPlayerBeDamageTimer(playerid) < gettime())
				HidePlayerBeDamage(playerid);
		}
		else {
			new 
				Float:hp;

			GetPlayerHealthEx(playerid, hp);
			if(hp < 100.0) 
				SetPlayerHealthEx(playerid, hp + 1);
		}
	}
	else {
		if(GetPlayerDead(playerid) == PLAYER_DEATH_KILLER) 
			UpdateBarTimeRespawn(playerid);

		if(GetPlayerSpeedRespawn(playerid) < gettime())
			DM_OnPlayerSpawn(playerid);
	}

	SetPlayerSecondTime(playerid);
	UpdatePlayerTime(playerid);
	return 1;
}

stock DM_UpdateTime(session_id)
{
	if(dm_location_game_status[session_id] == DM_LOC_GAME_STATUS_GAME) {
		UpdateTDTopKillers(session_id);

		if(DM_GetActiveTimer(session_id)) {
			if(Mode_GetSeconds(MODE_DM, session_id) > 0 
			&& Mode_GetSeconds(MODE_DM, session_id) <= 60) 
				Mode_SetSeconds(MODE_DM, session_id, Mode_GetSeconds(MODE_DM, session_id) - 1);

			if(!Mode_GetSeconds(MODE_DM, session_id) 
			&& Mode_GetMinutes(MODE_DM, session_id) > 0) {
				Mode_SetMinutes(MODE_DM, session_id, Mode_GetMinutes(MODE_DM, session_id) - 1);
				Mode_SetSeconds(MODE_DM, session_id, 60);
			}
			
			new 
				str[15];

			m_for(MODE_DM, session_id, p) {
				f(str, "%02d:%02d", Mode_GetMinutes(MODE_DM, session_id), Mode_GetSeconds(MODE_DM, session_id));
				Mode_UpdatePlTDTimerSession(p, str);
			}

			if(!Mode_GetSeconds(MODE_DM, session_id) 
			&& !Mode_GetMinutes(MODE_DM, session_id)) 
				DM_LocationEndGame(session_id);
		}
	}
	return 1;
}

static UpdateTDTopKillers(session_id)
{
	m_for(MODE_DM, session_id, p) {
		if(Adm_GetPlayerSpectating(p)) 
			continue;

		players_Data[session_id][tempVar[session_id]][0] = Mode_GetPlayerKills(p);
		players_Data[session_id][tempVar[session_id]][2] = Mode_GetPlayerDeaths(p);

		GetPlayerName(p, players_Name[session_id][p], MAX_PLAYER_NAME);
		players_Data[session_id][tempVar[session_id]++][1] = p;
	}
	for(new i = 0, j = 0; i < tempVar[session_id]; i++) {
		j = players_Data[session_id][i][0];

		for(new k = i - 1; k > -1; k--) {
			if(j > players_Data[session_id][k][0]) {
				players_Data[session_id][k][0] ^= players_Data[session_id][k + 1][0], players_Data[session_id][k + 1][0] ^= players_Data[session_id][k][0], players_Data[session_id][k][0] ^= players_Data[session_id][k + 1][0];
				players_Data[session_id][k][1] ^= players_Data[session_id][k + 1][1], players_Data[session_id][k + 1][1] ^= players_Data[session_id][k][1], players_Data[session_id][k][1] ^= players_Data[session_id][k + 1][1];
			}
		}
	}

	m_for(MODE_DM, session_id, p) {
		if(Adm_GetPlayerSpectating(p)) 
			continue;

		UpdatePlayerTDTopKillers(p);
	}

	ResetTopPlayers(session_id);
	return 1;
}

static UpdatePlayerTDTopKillers(playerid)
{
	new 
		str[30],
		session_id = M_GPS(playerid);

	for(new i = 0, td = 4; i < 5; i++, td += 2) {
		if(players_Data[session_id][i][1] > -1) {
			f(str, "%i._%s", i + 1, players_Name[session_id][players_Data[session_id][i][1]]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][td], str);
			str[0] = EOS;

			f(str, "%i", players_Data[session_id][i][0]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][td + 1], str);
			str[0] = EOS;

			if(players_Data[session_id][i][1] == playerid) {
				PlayerTextDrawColor(playerid, TD_TopKillers[playerid][td], 0xd9832eFF);
				PlayerTextDrawShow(playerid, TD_TopKillers[playerid][td]);

				PlayerTextDrawColor(playerid, TD_TopKillers[playerid][td + 1], 0xd9832eFF);
				PlayerTextDrawShow(playerid, TD_TopKillers[playerid][td + 1]);
			}
			else {
				PlayerTextDrawColor(playerid, TD_TopKillers[playerid][td], -606348801);
				PlayerTextDrawShow(playerid, TD_TopKillers[playerid][td]);

				PlayerTextDrawColor(playerid, TD_TopKillers[playerid][td + 1], -606348801);
				PlayerTextDrawShow(playerid, TD_TopKillers[playerid][td + 1]);	
			}
		}
	}
	return 1;
}

static ShowTDTopKillers(playerid)
{
	// Основной задний фон
	TD_TopKillers[playerid][0] = CreatePlayerTextDraw(playerid, 523.0000, 356.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_TopKillers[playerid][0], 0.0000, 8.8665);
	PlayerTextDrawTextSize(playerid, TD_TopKillers[playerid][0], 621.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_TopKillers[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_TopKillers[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TD_TopKillers[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TD_TopKillers[playerid][0], 640034559);
	PlayerTextDrawBackgroundColor(playerid, TD_TopKillers[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_TopKillers[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_TopKillers[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_TopKillers[playerid][0], 0);

	// Зданий фон текста 
	TD_TopKillers[playerid][1] = CreatePlayerTextDraw(playerid, 523.0000, 356.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_TopKillers[playerid][1], 0.0000, 1.4665);
	PlayerTextDrawTextSize(playerid, TD_TopKillers[playerid][1], 621.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_TopKillers[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_TopKillers[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, TD_TopKillers[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, TD_TopKillers[playerid][1], 791621631);
	PlayerTextDrawBackgroundColor(playerid, TD_TopKillers[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_TopKillers[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TD_TopKillers[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_TopKillers[playerid][1], 0);

	TD_TopKillers[playerid][2] = CreatePlayerTextDraw(playerid, 573.0000, 354.0000, "Топ_убийц");
	PlayerTextDrawLetterSize(playerid, TD_TopKillers[playerid][2], 0.2766, 1.7825);
	PlayerTextDrawTextSize(playerid, TD_TopKillers[playerid][2], 0.0000, 75.0000);
	PlayerTextDrawAlignment(playerid, TD_TopKillers[playerid][2], 2);
	PlayerTextDrawColor(playerid, TD_TopKillers[playerid][2], -1162168065);
	PlayerTextDrawBackgroundColor(playerid, TD_TopKillers[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_TopKillers[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TD_TopKillers[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_TopKillers[playerid][2], 0);

	// Полоска
	TD_TopKillers[playerid][3] = CreatePlayerTextDraw(playerid, 600.0000, 370.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_TopKillers[playerid][3], 0.0000, 7.2999);
	PlayerTextDrawTextSize(playerid, TD_TopKillers[playerid][3], 599.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_TopKillers[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_TopKillers[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, TD_TopKillers[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, TD_TopKillers[playerid][3], 791621631);
	PlayerTextDrawBackgroundColor(playerid, TD_TopKillers[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_TopKillers[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, TD_TopKillers[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TD_TopKillers[playerid][3], 0);

	new
		Float:initialcoords[2] = {524.0, 372.0},
		td = 4;

	n_for(i, 5) {
		// Ник
		TD_TopKillers[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0], initialcoords[1], "_");
		PlayerTextDrawLetterSize(playerid, TD_TopKillers[playerid][td], 0.1519, 1.3717);
		PlayerTextDrawAlignment(playerid, TD_TopKillers[playerid][td], 1);
		PlayerTextDrawColor(playerid, TD_TopKillers[playerid][td], -606348801);
		PlayerTextDrawBackgroundColor(playerid, TD_TopKillers[playerid][td], 255);
		PlayerTextDrawFont(playerid, TD_TopKillers[playerid][td], 1);
		PlayerTextDrawSetProportional(playerid, TD_TopKillers[playerid][td], 1);
		PlayerTextDrawSetShadow(playerid, TD_TopKillers[playerid][td], 0);
		td++;

		// Кол-во убийств
		TD_TopKillers[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 87.0, initialcoords[1], "_");
		PlayerTextDrawLetterSize(playerid, TD_TopKillers[playerid][td], 0.1792, 1.3552);
		PlayerTextDrawAlignment(playerid, TD_TopKillers[playerid][td], 2);
		PlayerTextDrawColor(playerid, TD_TopKillers[playerid][td], -606348801);
		PlayerTextDrawBackgroundColor(playerid, TD_TopKillers[playerid][td], 255);
		PlayerTextDrawFont(playerid, TD_TopKillers[playerid][td], 2);
		PlayerTextDrawSetProportional(playerid, TD_TopKillers[playerid][td], 1);
		PlayerTextDrawSetShadow(playerid, TD_TopKillers[playerid][td], 0);
		td++;

		initialcoords[1] += 11.0;
	}
	return 1;
}

static DestroyTDTopKillers(playerid)
{
	n_for(i, sizeof(TD_TopKillers[]))
		DestroyPlayerTD(playerid, TD_TopKillers[playerid][i]);

	return 1;
}

static SettingsPlayerSpawn(playerid)
{
	new
		Float:X, Float:Y, Float:Z,
		skin_id = Mode_GetPlayerSkin(playerid, MODE_DM);

	new
		session_id = Mode_GetPlayerSession(playerid),
		spawn = random(DM_MAX_SPAWN_POS);

	Mode_SetPlayerVirtualWorld(playerid, MODE_DM, session_id);
	Mode_SetPlayerInterior(playerid, MODE_DM, session_id);

	DM_GetSpawnPos(session_id, spawn, X, Y, Z);
	SetSpawnInfoEx(playerid, skin_id, X, Y, Z + 0.1, 0.0);
	return 1;
}

static SetPlayerAmmunition(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerArmourEx(playerid, 30.0);

	SetPlayerSkinEx(playerid, GetPlayerSkinEx(playerid));
	SetPlayerColorEx(playerid, 0xCCCCCCBB);

	Inv_SetPlayerAttachItem(playerid);

	switch(Mode_GetMode(MODE_DM, session_id)) {
		case DM_MODE_WEAPON_NORMAL: {
			GivePlayerWeaponEx(playerid, 24, 100000);
			GivePlayerWeaponEx(playerid, 31, 100000);
			GivePlayerWeaponEx(playerid, 25, 100000);
		}
		case DM_MODE_WEAPON_DEAGLE:
			GivePlayerWeaponEx(playerid, 24, 100000);
		case DM_MODE_WEAPON_SNIPER:
			GivePlayerWeaponEx(playerid, 34, 100000);
	}
	return 1;
}

static ResetTopPlayers(session_id)
{
	n_for(b, 5) {
		players_Data[session_id][b][0] =
		players_Data[session_id][b][1] =
		players_Data[session_id][b][2] = -1;
		players_Name[session_id][b][0] = EOS;
	}
	tempVar[session_id] = 0;
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerTDs(playerid)
{
	n_for(i, sizeof(TD_TopKillers[]))
		TD_TopKillers[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

/*

	* Dialogs *

*/

DialogCreate:DM_SelectPlaySession(playerid)
{
	static 
		str[1500];

	str[0] = EOS;

	str = "Локация\tРежим\tИгроков\n";
	n_for(i, DM_MAX_GAME_SESSIONS) {
		new
			loc_id = Mode_GetLocation(MODE_DM, i);

		f(str, "\
		%s\
		"C_N"%i. {FFFFFF}%s\
		\t{d9ae21}%s\
		\t{CCCCCC}%i/%i\n", str, i + 1,  DM_GetNameLocation(loc_id), DM_GetModeName(DM_GetModeLocation(loc_id)), Adm_GetPlayersNotAdminsMode(MODE_DM, i), DM_MAX_PLAYERS);
	}
	Dialog_Open(playerid, Dialog:DM_SelectPlaySession, DSTH, "Сессии", str, "Войти", "Выйти");
	return 1;
}

DialogResponse:DM_SelectPlaySession(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	n_for(i, DM_MAX_GAME_SESSIONS) {
		if(listitem == i) {
			if(Adm_GetPlayersNotAdminsMode(MODE_DM, i) >= DM_MAX_PLAYERS) {
				Dialog_Show(playerid, Dialog:DM_SelectPlaySession);

				SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данная сессия уже заполнена.");
				return 1;
			}
			Mode_DestroyLocationPlayer(playerid);
			Mode_CreateLocationPlayer(playerid, MODE_DM, i);
			break;
		}
	}
	return 1;
}

DialogCreate:DM_SelectSession(playerid)
{
	static 
		string[1000];

	string[0] = EOS;

	n_for(i, DM_MAX_GAME_SESSIONS) {
		new 
			str[150];

		f(str, ""C_N"%i. {FFFFFF}Сессия [%i]\n", i + 1, i);
		strcat(string, str);
	}
	Dialog_Open(playerid, Dialog:DM_SelectSession, DSL, "Список сессий (Режим: DM)", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:DM_SelectSession(playerid, response, listitem, inputtext[])
{
	if(response) {
		SetPVarInt(playerid, "SessionMode_PVar", listitem);
		Dialog_Show(playerid, Dialog:DM_SelectLocation);
	}
	else
		Dialog_Show(playerid, Dialog:Adm_SelectMode);

	return 1;
}

DialogCreate:DM_SelectLocation(playerid)
{
	static
		string[1000];

	string[0] = EOS;

	n_for(i, DM_MAX_LOCATIONS) {
		new 
			str[150];

		f(str, ""C_N"%i. {FFFFFF}%s\n", i + 1, DM_GetNameLocation(i));
		strcat(string, str);
	}
	Dialog_Open(playerid, Dialog:DM_SelectLocation, DSL, "Список локаций (Режим: DM)", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:DM_SelectLocation(playerid, response, listitem, inputtext[])
{
	if(response) {
		new 
			session_id = GetPVarInt(playerid, "SessionMode_PVar");

		if(dm_location_game_status[session_id] != DM_LOC_GAME_STATUS_GAME) 
			return Dialog_Show(playerid, Dialog:DM_SelectLocation);

		if(Mode_GetLocation(MODE_DM, session_id) == listitem) 
			return Dialog_Show(playerid, Dialog:DM_SelectLocation);

		DM_LocationEndGame(session_id, listitem);
	}
	else {
		DeletePVar(playerid, "SessionMode_PVar");
		Dialog_Show(playerid, Dialog:DM_SelectSession);
	}
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock DM_OnGameModeInit(session_id)
{
	dm_location_game_status[session_id] = 0;

	ResetTopPlayers(session_id);
	return 1;
}

/*
	OnPlayerConnect
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
	OnPlayerSpawn
*/

stock DM_OnPlayerSpawn(playerid)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 1;

	if(Adm_GetPlayerSpectating(playerid))
		return 1;

	if(GetPlayerSpectating(playerid) > -1) {
		if(Iter_Count(spec_dead_playerid[GetPlayerSpectating(playerid)]) > 0)
			Iter_Remove(spec_dead_playerid[GetPlayerSpectating(playerid)], playerid);
	}

	if(GetPlayerDead(playerid)) {
		RemovePlayerDead(playerid);

		SpecPl(playerid, true);
		SpecPl(playerid, false);
		return 1;
	}

	new
		session_id = Mode_GetPlayerSession(playerid);

	SettingsPlayerSpawn(playerid);

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, pInfo[playerid][pCredit]);
	ResetPlayerWeaponsEx(playerid);

	SetPlayerTeamEx(playerid, NO_TEAM);

	SetPlayerVirtualWorldEx(playerid, Mode_GetVirtualWorld(MODE_DM, session_id));
	SetPlayerInteriorEx(playerid, Mode_GetInterior(MODE_DM, session_id));

	SetPlayerAmmunition(playerid);
	SetPlayerSpawnKill(playerid);

	DM_CreateElementEnterArea(playerid);
	SetPlayerZone(playerid, true);

	Dina_CheckPlayerHint(playerid, 8);
	return 1;
}

/*
	OnPlayerDeath
*/

stock DM_OnPlayerDeath(playerid, &killerid, &reason)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 1;

	new
		session_id = Mode_GetPlayerSession(playerid);

	CheckSpectatingPlayers(playerid, killerid);

	if(killerid != INVALID_PLAYER_ID)
		Iter_Add(spec_dead_playerid[killerid], playerid);

	Damage_CheckPlayerBody(playerid);

	SetPlayerDamage(playerid, false);
	Mode_SetPlayerDeath(playerid, 1);

	m_for(MODE_DM, session_id, p)
		SendDeathMessageToPlayer(p, killerid, playerid, reason);

	DestroyPlayerBelowHealth(playerid);

	if(DM_GetTokens(session_id))
		DropT_CreatePlayerToken(playerid);

	SetPlayerHealthEx(killerid, 100.0);

	// Квесты
	if(killerid != INVALID_PLAYER_ID) {
		Quest_CheckPlayerProgress(killerid, MODE_DM, 0);
		Quest_CheckPlayerProgress(killerid, MODE_DM, 2);

		if(GetPlayerWeapon(killerid) == 24) 
			Quest_CheckPlayerProgress(killerid, MODE_DM, 4);

		if(GetPlayerWeapon(killerid) == 31) 
			Quest_CheckPlayerProgress(killerid, MODE_DM, 5);

		if(GetPlayerWeapon(killerid) == 34) 
			Quest_CheckPlayerProgress(killerid, MODE_DM, 6);

		Quest_CheckPlayerProgress(killerid, MODE_DM, 8);

		if(GetPlayerColdWeapon2(killerid)) 
			Quest_CheckPlayerProgress(killerid, MODE_DM, 9);

		if(GetPlayerWeapon(killerid) == 25 
		|| GetPlayerWeapon(killerid) == 27) 
			Quest_CheckPlayerProgress(killerid, MODE_DM, 10);

		Quest_CheckPlayerProgress(killerid, MODE_DM, 11);

		if(GetPlayerWeapon(killerid) == 24) 
			Quest_CheckPlayerProgress(killerid, MODE_DM, 14);
	}
	Quest_SetPlayerProgress(playerid, MODE_DM, 8, 0);
	//

	ShowDeadKiller(playerid, killerid);

	if(killerid != INVALID_PLAYER_ID) 
		SetPlayerSpeedRespawn(playerid, gettime() + DM_PLAYER_TIMER_RESPAWN, false);
	else 
		SetPlayerSpeedRespawn(playerid, gettime() + MAX_PLAYER_TIMER_RESPAWN, false);

	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
	OnPlayerEnterDynamicArea
*/

stock DM_OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(DM_LocOnPlayerEnterDynamicArea(playerid, areaid))
		return 1;

	return 0;
}

/*
	OnPlayerLeaveDynamicArea
*/

stock DM_OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(DM_LocOnPlayerLeaveDynamicArea(playerid, areaid))
		return 1;

	return 0;
}

/*
	OnPlayerKeyStateChange
*/

stock DM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	#pragma unused oldkeys

	if(GetPlayerDead(playerid))
		return 0;

	new
		session_id = Mode_GetPlayerSession(playerid);

	// Anti +C
	if(Mode_GetMode(MODE_DM, session_id) != DM_MODE_WEAPON_DEAGLE) {
		if(newkeys == 65410 || newkeys == 130) {
			DeaglePlayerAntiC(playerid);
			return 1;
		}
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
#define OnPlayerConnect DM_OnPlayerConnect
#if defined DM_OnPlayerConnect
	forward DM_OnPlayerConnect(playerid);
#endif