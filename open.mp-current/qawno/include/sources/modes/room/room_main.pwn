/*
 * |>=========================<|
 * |   About: Mode Room main   |
 * |   Author: Foxze           |
 * |>=========================<|
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
	- OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)

	# Technical #
 * Stock:
	- Room_CreateSession(roomid)
	- Room_DestroySession(roomid)
	- Room_CreateFirstSessions()

	- Room_CreateLocation(roomid)
	- Room_DestroyLocation(roomid)
	- Room_CreatePlayerLocation(playerid, roomid)
	- Room_DestroyPlayerLocation(playerid)

	- Room_UpdateModeData()
	- Room_UpdatePlayerData(playerid)

	- Room_EnterPlayerLobby(playerid, roomid)
	- Room_ExitPlayerLobby(playerid)

	- Room_SetTeamModeScore(roomid, teamid, num)
	- Room_GetTeamModeScore(roomid, teamid)
	- Room_GiveTeamModeScore(roomid, teamid, num)
	- Room_SetTeamModeMaxScore(roomid, teamid, num)
	- Room_GetTeamModeMaxScore(roomid, teamid)

	- Room_ShowPlayerTeamsScoreTD(playerid)
	- Room_HidePlayerTeamsScoreTD(playerid)

	- Room_SetPlayerTeam(playerid, roomid)
	- Room_ChangePlayerTeam(playerid, roomid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_ROOM_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- Room_InfoRoom
	- Room_SelectingTab
	- Room_ListRooms
	- Room_InputPassword
	- Room_SetPassword
	- Room_ChooseAccess
	- Room_SetWeaponMain
	- Room_SetWeaponSecondary
	- Room_SetWeaponThird
	- Room_SetWeapon
	- Room_Settings
	- Room_SelectMode
	- Room_SetCountPlayers
	- Room_SetTimer
	- Room_Create
	- Room_ChangeInputName
	- Room_InputName
	- Room_ConnectRoom
	- Room_ExcludePlayer
	- Room_ListLocations
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- Room_Lobby
 */

#if defined _INC_ROOM_MAIN
	#endinput
#endif
#define _INC_ROOM_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_ROOM_INFO {
	e_CreaterPlayerID,
	e_Status,
	e_Name[ROOM_MAX_NAME_LENGTH],
	e_NumberPlayers,
	e_MaxNumberPlayers,
	e_Location,
	e_GameMode,
	e_Minutes,
	WEAPON:e_Weapon[3],
	bool:e_Access,
	e_Password[ROOM_MAX_PASSWORD_LENGTH],
	e_LobbyMinutes,
	e_LobbySeconds,
	e_EndTimer,
	e_Players[GMS_MAX_SESSION_SLOTS],
	e_Teams[GMS_MAX_SESSION_SLOTS]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	rInfo[GMS_MAX_SESSIONS][E_ROOM_INFO];

static
	TOPPlayersData[GMS_MAX_SESSIONS][ROOM_MAX_TEAMS][MAX_PLAYERS][3],
	TOPPlayersName[GMS_MAX_SESSIONS][ROOM_MAX_TEAMS][MAX_PLAYERS][MAX_PLAYER_NAME],
	TOPTempVar[GMS_MAX_SESSIONS][ROOM_MAX_TEAMS];

static
	DialogFirstRoom[MAX_PLAYERS],
	DialogListRoomID[MAX_PLAYERS][22];

static
	PlayerText:TD_TopKillers[GMS_MAX_SESSIONS][ROOM_MAX_TEAMS][ROOM_MAX_TOP_KILLERS][ROOM_TD_TOP_KILLERS],
	PlayerText:TD_EndMatchStats[GMS_MAX_SESSIONS][ROOM_TD_END_MATCH_STATS],
	PlayerText:TD_MatchResult[GMS_MAX_SESSIONS][ROOM_MAX_TEAMS][ROOM_TD_MATCH_RESULT],
	PlayerText:TD_TeamScore[GMS_MAX_SESSIONS][ROOM_TD_TEAM_SCORE],
	PlayerText:TD_LobbyRoom[GMS_MAX_SESSIONS][ROOM_TD_LOBBY];

static
	PlayerBar:PlayerBarScoreMatch[MAX_PLAYERS][2];

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

stock Room_CreateSession(roomid)
{
	#pragma unused roomid
	return 1;
}

stock Room_DestroySession(roomid)
{
	ResetSessionData(roomid);
	return 1;
}

stock Room_CreateFirstSessions()
{
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Location create & destroy   |
 * |>-----------------------------<|
 */

stock Room_CreateLocation(roomid)
{
	Room_CreateElementsLocation(roomid);
	rInfo[roomid][e_Status] = ROOM_STATUS_GAME;
	return 1;
}

stock Room_DestroyLocation(roomid)
{
	Room_DestroyElementsLocation(roomid);
	return 1;
}

stock Room_CreatePlayerLocation(playerid, roomid)
{
	#pragma unused roomid

	if (!GetAdminSpectating(playerid)) {
		SetPlayerDamage(playerid, true);
		SetPlayerTeamEx(playerid, GetPVarInt(playerid, "RoomTeam"));
		SetPlayerSkinEx(playerid, GetPlayerInvSkin(playerid));

		SetPVarInt(playerid, "RoomID", -1);
		SetPVarInt(playerid, "RoomSlotID", -1);
		DeletePVar(playerid, "RoomTeam");
	}

	SettingsPlayerSpawn(playerid);

	Room_ShowPlElementsLocation(playerid);

	if (!GetAdminSpectating(playerid)) {
		ShowPlayerBaseIndicatorsTD(playerid);
		ShowPlayerNewGraphTD(playerid);
		CreatePlayerAfterDeadTD(playerid);

		CancelSelectTextDraw(playerid);
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, true);

		ShowPlayerNewGraphTD(playerid);
		ShowPlayerMatchStatsTD(playerid);

		PlayerSpawn(playerid);
	}
	return 1;
}

stock Room_DestroyPlayerLocation(playerid)
{
	new
		roomid = Mode_GetPlayerSession(playerid);

	HidePlayerResultMatch(playerid);

	Room_DestroyPlayerPoint(playerid);
	Room_DestroyPlayerComputer(playerid);

	Room_HidePlElementsLocation(playerid);

	// If the creator of the room exits, then everyone exits
	if (rInfo[roomid][e_CreaterPlayerID] == playerid) {
		rInfo[roomid][e_CreaterPlayerID] = INVALID_PLAYER_ID;
	}
	return 1;
}

/*
 * |>----------------------<|
 * |   Timers update data   |
 * |>----------------------<|
 */

stock Room_UpdateModeData(roomid)
{
	switch (rInfo[roomid][e_Status]) {
		case ROOM_STATUS_LOBBY: {
			if (rInfo[roomid][e_NumberPlayers] == rInfo[roomid][e_MaxNumberPlayers]) {
				if (rInfo[roomid][e_LobbySeconds]
				&& rInfo[roomid][e_LobbySeconds] < 61) {
					rInfo[roomid][e_LobbySeconds]--;
				}
				if (!rInfo[roomid][e_LobbySeconds]
				&& rInfo[roomid][e_LobbyMinutes] > 0) {
					rInfo[roomid][e_LobbyMinutes]--;
					rInfo[roomid][e_LobbySeconds] = 60;
				}

				m_for(MODE_NONE, 0, p) {
					if (GetPVarInt(p, "RoomID") != roomid) {
						continue;
					}

					PlayerTextDrawSetString(p, TD_LobbyRoom[p][7], "%02d:%02d", rInfo[roomid][e_LobbyMinutes], rInfo[roomid][e_LobbySeconds]);
				}

				if (!rInfo[roomid][e_LobbySeconds] 
				&& !rInfo[roomid][e_LobbyMinutes]) {
					Mode_DestroySessionLocation(MODE_ROOM, roomid);

					new
						locationid = rInfo[roomid][e_Location];

					Mode_SetLocationGameMode(MODE_ROOM, locationid, rInfo[roomid][e_GameMode]);
					Mode_SetLocationMinutes(MODE_ROOM, locationid, rInfo[roomid][e_Minutes]);

					Mode_CreateSessionLocation(MODE_ROOM, roomid, locationid);

					Mode_SetLocationGameMode(MODE_ROOM, locationid, 0);
					Mode_SetLocationMinutes(MODE_ROOM, locationid, 0);

					m_safe_for(MODE_NONE, 0, p) {
						if (GetPVarInt(p, "RoomID") != roomid) {
							continue;
						}

						SetPVarInt(p, "RoomEnteringGame", 1);

						Mode_LeavePlayer(p);
						Mode_EnterPlayer(p, MODE_ROOM, roomid);

						DeletePVar(p, "RoomEnteringGame");
					}
				}
			}
		}
		case ROOM_STATUS_GAME: {
			if (rInfo[roomid][e_CreaterPlayerID] == INVALID_PLAYER_ID) {
				rInfo[roomid][e_Status] = ROOM_STATUS_NONE;
				Mode_DestroySessionDelay(MODE_ROOM, roomid);
				return 1;
			}

			switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
				case ROOM_GAME_MODE_CAPTURE: Room_PointReInfo(roomid);
				case ROOM_GAME_MODE_DATA: Room_ComputerReInfo(roomid);
			}

			UpdateTeamScore(roomid);

			if (Mode_GetSessionActiveTimer(MODE_ROOM, roomid)) {
				if (Mode_GetSessionSeconds(MODE_ROOM, roomid) > 0
				&& Mode_GetSessionSeconds(MODE_ROOM, roomid) <= 60) {
					Mode_SetSessionSeconds(MODE_ROOM, roomid, Mode_GetSessionSeconds(MODE_ROOM, roomid) - 1);
				}

				if (Mode_GetSessionSeconds(MODE_ROOM, roomid) <= 0
				&& Mode_GetSessionMinutes(MODE_ROOM, roomid) > 0) {
					Mode_SetSessionMinutes(MODE_ROOM, roomid, Mode_GetSessionMinutes(MODE_ROOM, roomid) - 1);
					Mode_SetSessionSeconds(MODE_ROOM, roomid, 60);
				}

				if (Mode_GetSessionSeconds(MODE_ROOM, roomid) <= 0 
				&& Mode_GetSessionMinutes(MODE_ROOM, roomid) <= 0) {
					ShowLocationEndGame(roomid);
				}

				m_for(MODE_ROOM, roomid, p) {
					UpdatePlayerTeamScoreTD(p);
				}
			}
		}
		case ROOM_STATUS_END: {
			if (rInfo[roomid][e_EndTimer] > 0) {
				rInfo[roomid][e_EndTimer]--;

				if (rInfo[roomid][e_EndTimer] < 1) {
					rInfo[roomid][e_EndTimer] = 0;

					rInfo[roomid][e_Status] = ROOM_STATUS_NONE;
					Mode_DestroySessionDelay(MODE_ROOM, roomid);
				}
			}
		}
	}
	return 1;
}

stock Room_UpdatePlayerData(playerid)
{
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));

	if (!GetPlayerDead(playerid)) {
		if (!GetPlayerLastDamage(playerid)) {
			new 
				Float:hp;

			GetPlayerHealthEx(playerid, hp);

			if (hp < 100.0) {
				SetPlayerHealthEx(playerid, hp + 1);
			}
		}

		UpdatePlayerBelowHealth(playerid);
	}
	else {
		if (GetPlayerDead(playerid) == PLAYER_DEATH_KILLER) {
			UpdateBarTimeRespawn(playerid);
		}
		else {
			UpdatePlayerSpeedRespawn(playerid);
		}

		if (GetPlayerSpeedRespawn(playerid) <= 0) {
			Room_OnPlayerSpawn(playerid);
		}
	}
	Room_UpdatePlayerComputer(playerid);

	GivePlayerSecondTime(playerid);
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Player lobby enter & exit   |
 * |>-----------------------------<|
 */

stock Room_EnterPlayerLobby(playerid, roomid)
{
	if (rInfo[roomid][e_NumberPlayers] == rInfo[roomid][e_MaxNumberPlayers]) {
		SCM(playerid, C_LIGHT_BLUE, ""T_ROOM" "CT_WHITE"Данная комната переполнена.");
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}

	rInfo[roomid][e_NumberPlayers]++;
	SetPVarInt(playerid, "RoomID", roomid);
	Room_SetPlayerTeam(playerid, roomid);

	Interface_Close(playerid, Dialog:MM_SelectModes);

	Interface_Show(playerid, Interface:Room_Lobby);
	Dialog_Show(playerid, Dialog:Room_InfoRoom);

	n_for(p, rInfo[roomid][e_NumberPlayers]) {
		UpdatePlayerLobbyTD(rInfo[roomid][e_Players][p], roomid);
	}

	if (rInfo[roomid][e_NumberPlayers] == rInfo[roomid][e_MaxNumberPlayers]) {
		rInfo[roomid][e_LobbySeconds] = ROOM_LOBBY_TIMER;
	}
	return 1;
}

stock Room_ExitPlayerLobby(playerid)
{
	new
		roomEntering = GetPVarInt(playerid, "RoomEnteringGame");

	// If it is not entering the game after the timer
	if (!roomEntering) {
		new
			roomid = GetPVarInt(playerid, "RoomID"),
			slotid = GetPVarInt(playerid, "RoomSlotID");

		// If the creator of the room
		if (rInfo[roomid][e_CreaterPlayerID] == playerid) {
			n_for(p, rInfo[roomid][e_NumberPlayers]) {
				new 
					rplayerid = rInfo[roomid][e_Players][p];

				SetPVarInt(rplayerid, "RoomID", -1);
				SetPVarInt(rplayerid, "RoomSlotID", -1);
				DeletePVar(rplayerid, "RoomTeam");

				Interface_Close(rplayerid, Interface:Room_Lobby);
				Interface_Show(rplayerid, Dialog:MainMenu);
			}
			Mode_DestroySession(MODE_ROOM, roomid);
		}
		else {
			rInfo[roomid][e_NumberPlayers]--;
			rInfo[roomid][e_Players][slotid] = rInfo[roomid][e_Players][rInfo[roomid][e_NumberPlayers]];
			rInfo[roomid][e_Teams][slotid] = rInfo[roomid][e_Teams][rInfo[roomid][e_NumberPlayers]];
			rInfo[roomid][e_Players][rInfo[roomid][e_NumberPlayers]] = -1;
			rInfo[roomid][e_Teams][rInfo[roomid][e_NumberPlayers]] = 0;

			SetPVarInt(playerid, "RoomID", -1);
			SetPVarInt(playerid, "RoomSlotID", -1);
			DeletePVar(playerid, "RoomTeam");

			n_for(p, rInfo[roomid][e_NumberPlayers]) {
				UpdatePlayerLobbyTD(rInfo[roomid][e_Players][p], roomid);
				PlayerTextDrawSetString(rInfo[roomid][e_Players][p], TD_LobbyRoom[rInfo[roomid][e_Players][p]][7], "_");
			}

			Interface_Close(playerid, Interface:Room_Lobby);
			Interface_Show(playerid, Dialog:MainMenu);
		}
	}
	else {
		Interface_Close(playerid, Interface:Room_Lobby);
	}
	return 1;
}

/*
 * |>----------------<|
 * |   Result match   |
 * |>----------------<|
 */

static ShowPlayerResultMatch(playerid)
{
	if (GetPVarInt(playerid, "ActiveMatchResult")) {
		return 1;
	}

	new
		roomid = Mode_GetPlayerSession(playerid);

	SetPVarInt(playerid, "ActiveMatchResult", 1);

	new
		teams = Iter_Count(Room_ActiveTeams[roomid]),
		num = 0;

	foreach (new t:Room_ActiveTeams[roomid]) {
		if (IsCh(t)) {
			CreatePlayerResultScoreTD(playerid, t, false, num, teams);
		}
		else {
			if ((num + 1) == teams) {
				CreatePlayerResultScoreTD(playerid, t, true, num, teams);
			}
			else { 
				CreatePlayerResultScoreTD(playerid, t, false, num, teams);
			}
		}
		num++;
	}
	return 1;
}

static HidePlayerResultMatch(playerid)
{
	if (!GetPVarInt(playerid, "ActiveMatchResult")) {
		return 1;
	}

	DeletePVar(playerid, "ActiveMatchResult");

	new
		num = 0,
		roomid = Mode_GetPlayerSession(playerid);

	foreach (new t:Room_ActiveTeams[roomid]) {
		n_for(i, ROOM_TD_MATCH_RESULT) {
			DestroyPlayerTD(playerid, TD_MatchResult[playerid][num][i]);
		}
		n_for(i, ROOM_MAX_TOP_KILLERS) {
			n_for2(b, ROOM_TD_TOP_KILLERS) {
				DestroyPlayerTD(playerid, TD_TopKillers[playerid][num][i][b]);
			}
		}
		num++;
	}

	n_for(i, ROOM_TD_END_MATCH_STATS) {
		DestroyPlayerTD(playerid, TD_EndMatchStats[playerid][i]);
	}
	ResetTopPlayers(roomid);
	return 1;
}

/*
 * |>-------------<|
 * |   End match   |
 * |>-------------<|
 */

static ShowLocationEndGame(roomid)
{
	if (rInfo[roomid][e_Status] == ROOM_STATUS_END) {
		return 1;
	}

	rInfo[roomid][e_Status] = ROOM_STATUS_END;
	rInfo[roomid][e_EndTimer] = 15;

	// Top players
	foreach (new t:Room_ActiveTeams[roomid]) {
		m_for(MODE_ROOM, roomid, p) {
			if (GetAdminSpectating(p)) {
				continue;
			}
			
			if (GetPlayerTeamEx(p) != t) {
				continue;
			}

			TOPPlayersData[roomid][t][TOPTempVar[roomid][t]][0] = Mode_GetPlayerMatchKills(p);
			TOPPlayersData[roomid][t][TOPTempVar[roomid][t]][2] = Mode_GetPlayerMatchDeaths(p);
			GetPlayerName(p, TOPPlayersName[roomid][t][p], MAX_PLAYER_NAME);
			TOPPlayersData[roomid][t][TOPTempVar[roomid][t]++][1] = p;
		}
	}
	foreach (new t:Room_ActiveTeams[roomid]) {
		for (new i = 0, j = 0; i < TOPTempVar[roomid][t]; i++) {
			j = TOPPlayersData[roomid][t][i][0];

			for (new k = i - 1; k > -1; k--) {
				if (j > TOPPlayersData[roomid][t][k][0]) {
					TOPPlayersData[roomid][t][k][0] ^= TOPPlayersData[roomid][t][k + 1][0], TOPPlayersData[roomid][t][k + 1][0] ^= TOPPlayersData[roomid][t][k][0], TOPPlayersData[roomid][t][k][0] ^= TOPPlayersData[roomid][t][k + 1][0];
					TOPPlayersData[roomid][t][k][1] ^= TOPPlayersData[roomid][t][k + 1][1], TOPPlayersData[roomid][t][k + 1][1] ^= TOPPlayersData[roomid][t][k][1], TOPPlayersData[roomid][t][k][1] ^= TOPPlayersData[roomid][t][k + 1][1];
				}
			}
		}
	}
	//

	ShowMatchResult(roomid);

	m_for(MODE_ROOM, roomid, p) {
		if (!GetAdminSpectating(p)) {
			HidePlayerMatchEndElements(p);
		}
	}
	return 1;
}

static HidePlayerMatchEndElements(playerid)
{
	SpecPl(playerid, true);

	SetPlayerDamage(playerid, false);
	HidePlayerBaseIndicatorsTD(playerid);
	HidePlayerNewGraphTD(playerid);
	DestroyPlayerMatchStatsTD(playerid);
	DestroyPlayerBelowHealth(playerid);
	DestroyPlayerSpawnKill(playerid);
	ClearKillFeed(playerid);

	Room_DestroyPlayerPoint(playerid);
	Room_DestroyPlayerComputer(playerid);

	HidePlayerKillStrike(playerid);

	ShowPlayerResultMatch(playerid);
	Room_ShowCameraEndLocation(playerid);

	Mode_ResetPlayerMatchKills(playerid);
	Mode_ResetPlayerMatchDeaths(playerid);

	SetPlayerHealthEx(playerid, 100.0);
	return 1;
}

/*
 * |>--------------<|
 * |   Team score   |
 * |>--------------<|
 */

stock Room_SetTeamModeScore(roomid, teamid, num)
{
	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_BATTLE: Room_SetBattleTeamScore(roomid, teamid, num);
		case ROOM_GAME_MODE_CAPTURE: Room_SetCPTeamScore(roomid, teamid, num);
		case ROOM_GAME_MODE_DATA: Room_SetCompTeamScore(roomid, teamid, num);
	}
	return 1;
}

stock Room_GetTeamModeScore(roomid, teamid)
{
	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_BATTLE: return Room_GetBattleTeamScore(roomid, teamid);
		case ROOM_GAME_MODE_CAPTURE: return Room_GetCPTeamScore(roomid, teamid);
		case ROOM_GAME_MODE_DATA: return Room_GetCompTeamScore(roomid, teamid);
	}
	return 1;
}

stock Room_GiveTeamModeScore(roomid, teamid, num)
{
	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_BATTLE: Room_GiveBattleTeamScore(roomid, teamid, num);
		case ROOM_GAME_MODE_CAPTURE: Room_GiveCPTeamScore(roomid, teamid, num);
		case ROOM_GAME_MODE_DATA: Room_GiveCompTeamScore(roomid, teamid, num);
	}
	return 1;
}

stock Room_SetTeamModeMaxScore(roomid, teamid, num) 
{
	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_BATTLE: Room_SetBattleTeamMaxScore(roomid, teamid, num);
		case ROOM_GAME_MODE_CAPTURE: Room_SetCPTeamMaxScore(roomid, teamid, num);
		case ROOM_GAME_MODE_DATA: Room_SetCompTeamMaxScore(roomid, teamid, num);
	}
	return 1;
}

stock Room_GetTeamModeMaxScore(roomid, teamid) 
{
	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_BATTLE: return Room_GetBattleTeamMaxScore(roomid, teamid);
		case ROOM_GAME_MODE_CAPTURE: return Room_GetCPTeamMaxScore(roomid, teamid);
		case ROOM_GAME_MODE_DATA: return Room_GetCompTeamMaxScore(roomid, teamid);
	}
	return 1;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

static UpdateTeamScore(roomid)
{
	new
		endGame;

	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_BATTLE: {
			foreach (new t:Room_ActiveTeams[roomid]) {
				if (Room_GetTeamModeScore(roomid, t) >= Room_GetTeamModeMaxScore(roomid, t)) {
					endGame++;
				}
			}
		}
		case ROOM_GAME_MODE_CAPTURE: {
			new 
				point_team = Room_GetCapturePointColor(roomid);

			if (point_team) {
				Room_GiveTeamModeScore(roomid, point_team, 1);
			}
			foreach (new t:Room_ActiveTeams[roomid]) {
				if (Room_GetTeamModeScore(roomid, t) >= Room_GetTeamModeMaxScore(roomid, t)) {
					Room_SetTeamModeScore(roomid, t, Room_GetTeamModeMaxScore(roomid, t));

					m_for(MODE_ROOM, roomid, p) {
						UpdatePlayerTeamScoreTD(p);
					}
					
					endGame++;
				}
			}
		}
		case ROOM_GAME_MODE_DATA: {
			new 
				protectTeam = Room_GetComputerProtectTeam(roomid);

			if (!Room_GetTeamModeScore(roomid, protectTeam)) {
				endGame++;
			}
		}
	}

	if (endGame > 0) {
		ShowLocationEndGame(roomid);
	}
	return 1;
}

stock Room_ShowPlayerTeamsScoreTD(playerid)
{
	new
		roomid = Mode_GetPlayerSession(playerid),
		tdid = 0;

	foreach (new teamid:Room_ActiveTeamsScore[roomid]) {
		ShowPlayerTeamScoreTD(playerid, tdid, teamid, Room_GetTeamModeMaxScore(roomid, teamid));
		tdid++;
	}
	UpdatePlayerTeamScoreTD(playerid);
	return 1;
}

stock Room_HidePlayerTeamsScoreTD(playerid)
{
	new
		roomid = Mode_GetPlayerSession(playerid),
		barid = 0, 
		tdid = 0;

	foreach (new i:Room_ActiveTeamsScore[roomid]) {
		DestroyPlayerTD(playerid, TD_TeamScore[playerid][tdid]);
		DestroyPlayerTD(playerid, TD_TeamScore[playerid][tdid + 1]);

		DestroyPlayerProgressBar(playerid, PlayerBarScoreMatch[playerid][barid]);

		tdid += 2;
		barid++;
	}
	return 1;
}

static ShowPlayerTeamScoreTD(playerid, tdid, teamid, maxscore)
{
	new
		roomid = Mode_GetPlayerSession(playerid),
		teams = Iter_Count(Room_ActiveTeamsScore[roomid]),
		maxScore = floatround(maxscore);

	if (tdid + 1 <= teams) {
		if (IsCh(tdid + 1)) {
			CreatePlayerTeamScoreTD(playerid, tdid, -1, teamid, maxScore);
		}
		else {
			if (tdid + 1 == teams) {
				CreatePlayerTeamScoreTD(playerid, -1, tdid, teamid, maxScore);
			}
			else {
				CreatePlayerTeamScoreTD(playerid, tdid, -1, teamid, maxScore);
			}
		}
	}

	ShowPlayerProgressBar(playerid, PlayerBarScoreMatch[playerid][tdid]);
	return 1;
}

stock Room_SetPlayerTeam(playerid, roomid)
{
	new
		team[ROOM_MAX_TEAMS];

	n_for(t, ROOM_MAX_TEAMS) {
		n_for2(r, rInfo[roomid][e_NumberPlayers]) {
			if (rInfo[roomid][e_Teams][r] != t) {
				continue;
			}

			team[t]++;
		}
	}

	new
		mostTeam;

	n_for(t, ROOM_MAX_TEAMS) {
		if (team[t] >= mostTeam) {
			mostTeam = team[t];
		}
	}

	new
		lostTeam = mostTeam,
		index;

	n_for(t, ROOM_MAX_TEAMS) {
		if (team[t] <= lostTeam) {
			lostTeam = team[t];
			index = t;
		}
	}

	n_for(r, rInfo[roomid][e_MaxNumberPlayers]) {
		if (rInfo[roomid][e_Players][r] > -1) {
			continue;
		}

		rInfo[roomid][e_Players][r] = playerid;
		rInfo[roomid][e_Teams][r] = index;

		SetPVarInt(playerid, "RoomSlotID", r);
		SetPVarInt(playerid, "RoomTeam", index);
		break;
	}
	return 1;
}

stock Room_ChangePlayerTeam(playerid, roomid)
{
	new
		newTeam;

	for (new t = 1; t < ROOM_MAX_TEAMS; t++) {
		if (t == GetPVarInt(playerid, "RoomTeam")) {
			continue;
		}

		newTeam = t;
		break;
	}

	new
		players;

	n_for(r, rInfo[roomid][e_NumberPlayers]) {
		if (rInfo[roomid][e_Teams][r] != newTeam) {
			continue;
		}

		players++;
	}

	if (players < rInfo[roomid][e_MaxNumberPlayers] / 2) {
		rInfo[roomid][e_Teams][GetPVarInt(playerid, "RoomSlotID")] = newTeam;
		SetPVarInt(playerid, "RoomTeam", newTeam);

		n_for(p, rInfo[roomid][e_NumberPlayers]) {
			UpdatePlayerLobbyTD(rInfo[roomid][e_Players][p], roomid);
		}
	}
	return 1;
}

static UpdatePlayerLobbyTD(playerid, roomid)
{
	new
		team[ROOM_MAX_TEAMS] = {-1, ...};

	for (new m = 0, td = 20, num = 1; m < rInfo[roomid][e_MaxNumberPlayers]; m++, num++, td += 4) {
		new 
			cell = -1;

		if (!IsCh(num)) {
			new 
				teamRoom = ROOM_TEAM_ALPHA;

			for (new i = team[teamRoom] + 1; i < rInfo[roomid][e_NumberPlayers]; i++) {
				if (rInfo[roomid][e_Teams][i] != teamRoom) {
					continue;
				}

				cell = i;
				team[teamRoom] = i;
				break;
			}
		}
		else {
			new
				teamRoom = ROOM_TEAM_BRAVO;

			for (new i = team[teamRoom] + 1; i < rInfo[roomid][e_NumberPlayers]; i++) {
				if (rInfo[roomid][e_Teams][i] != teamRoom) {
					continue;
				}

				cell = i;
				team[teamRoom] = i;
				break;
			}
		}

		if (cell > -1) {
			new
				p = rInfo[roomid][e_Players][cell];

			// Background
			PlayerTextDrawBackgroundColour(playerid, TD_LobbyRoom[playerid][td], 690563583);
			PlayerTextDrawSetSelectable(playerid, TD_LobbyRoom[playerid][td], true);

			// Name
			PlayerTextDrawSetString(playerid, TD_LobbyRoom[playerid][td + 1], GetPlayerNameEx(p));
			PlayerTextDrawColour(playerid, TD_LobbyRoom[playerid][td + 1], -741092865);

			// Rank
			PlayerTextDrawSetString(playerid, TD_LobbyRoom[playerid][td + 2], "Ранг: %i", GetPlayerRank(p));
			PlayerTextDrawColour(playerid, TD_LobbyRoom[playerid][td + 2], -625128449);

			PlayerTextDrawColour(playerid, TD_LobbyRoom[playerid][td + 3], -741092865);

			for (new i = td; i < td + 4; i++) {
				PlayerTextDrawShow(playerid, TD_LobbyRoom[playerid][i]);
			}
		}
		else {
			PlayerTextDrawBackgroundColour(playerid, TD_LobbyRoom[playerid][td], 0x00000000);
			PlayerTextDrawSetSelectable(playerid, TD_LobbyRoom[playerid][td], false);
			PlayerTextDrawSetString(playerid, TD_LobbyRoom[playerid][td + 1], "_");
			PlayerTextDrawSetString(playerid, TD_LobbyRoom[playerid][td + 2], "_");
			PlayerTextDrawColour(playerid, TD_LobbyRoom[playerid][td + 3], 0x00000000);

			for (new i = td; i < td + 4; i++) {
				PlayerTextDrawShow(playerid, TD_LobbyRoom[playerid][i]);
			}
		}
	}
	return 1;
}

static ResetRoomData(roomid)
{
	rInfo[roomid][e_CreaterPlayerID] = INVALID_PLAYER_ID;

	rInfo[roomid][e_Name][0] =
	rInfo[roomid][e_Password][0] = EOS;

	rInfo[roomid][e_Status] = ROOM_STATUS_NONE;
	rInfo[roomid][e_NumberPlayers] =
	rInfo[roomid][e_MaxNumberPlayers] =
	rInfo[roomid][e_Location] =
	rInfo[roomid][e_GameMode] =
	rInfo[roomid][e_Minutes] =
	rInfo[roomid][e_EndTimer] =
	rInfo[roomid][e_LobbyMinutes] =
	rInfo[roomid][e_LobbySeconds] = 0;

	rInfo[roomid][e_Access] = false;

	n_for(i, 3) {
		rInfo[roomid][e_Weapon][i] = WEAPON_FIST;
	}

	n_for(i, GMS_MAX_SESSION_SLOTS) {
		rInfo[roomid][e_Players][i] = -1;
		rInfo[roomid][e_Teams][i] = 0;
	}
	return 1;
}

static ShowMatchResult(roomid)
{
	new 
		maxNumber,
		bool:winTeam[ROOM_MAX_TEAMS],
		bool:drawTeam[ROOM_MAX_TEAMS],
		rewardExp[3],
		rewardMoney[3];

	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_BATTLE: {
			foreach (new c:Room_ActiveTeams[roomid]) {
				if (Room_GetTeamModeScore(roomid, c) > maxNumber) {
					winTeam[c] = true;
					maxNumber = Room_GetTeamModeScore(roomid, c);

					foreach (new t:Room_ActiveTeams[roomid]) {
						if (t == c) {
							continue;
						}

						if (Room_GetTeamModeScore(roomid, t) < Room_GetTeamModeScore(roomid, c)) {
							winTeam[t] =
							drawTeam[t] = false;
						}
						else if (Room_GetTeamModeScore(roomid, t) == Room_GetTeamModeScore(roomid, c)) {
							drawTeam[c] = true;
						}
					}
				}
				else if (Room_GetTeamModeScore(roomid, c) == maxNumber) {
					winTeam[c] =
					drawTeam[c] = true;
				}
			}

			rewardExp[0] = 1000; 	// Win
			rewardExp[1] = 500; 	// Loss
			rewardExp[2] = 600; 	// Draw

			rewardMoney[0] = 800; 	// Win
			rewardMoney[1] = 300; 	// Loss
			rewardMoney[2] = 400; 	// Draw
		}
		case ROOM_GAME_MODE_CAPTURE: {
			foreach (new c:Room_ActiveTeams[roomid]) {
				if (Room_GetTeamModeScore(roomid, c) > maxNumber) {
					winTeam[c] = true;
					maxNumber = Room_GetTeamModeScore(roomid, c);

					foreach (new t:Room_ActiveTeams[roomid]) {
						if (t == c) {
							continue;
						}

						if (Room_GetTeamModeScore(roomid, t) < Room_GetTeamModeScore(roomid, c)) {
							winTeam[t] =
							drawTeam[t] = false;
						}
						else if (Room_GetTeamModeScore(roomid, t) == Room_GetTeamModeScore(roomid, c)) {
							drawTeam[c] = true;
						}
					}
				}
				else if (Room_GetTeamModeScore(roomid, c) == maxNumber) {
					winTeam[c] =
					drawTeam[c] = true;
				}
			}
			rewardExp[0] = 1000; 	// Win
			rewardExp[1] = 500; 	// Loss
			rewardExp[2] = 600; 	// Draw

			rewardMoney[0] = 800; 	// Win
			rewardMoney[1] = 300; 	// Loss
			rewardMoney[2] = 400; 	// Draw
		}
		case ROOM_GAME_MODE_DATA: {
			new
				protectTeam = Room_GetComputerProtectTeam(roomid);

			if (Room_GetTeamModeScore(roomid, protectTeam)) {
				winTeam[protectTeam] = true;
			}
			else {
				foreach (new c:Room_ActiveTeams[roomid]) {
					if (c == protectTeam) {
						continue;
					}

					winTeam[c] = true;
				}
			}
			rewardExp[0] = 1000; 	// Win
			rewardExp[1] = 500; 	// Loss
			rewardExp[2] = 600; 	// Draw

			rewardMoney[0] = 800; 	// Win
			rewardMoney[1] = 300; 	// Loss
			rewardMoney[2] = 400; 	// Draw
		}
	}
	m_for(MODE_ROOM, roomid, p) {
		if (GetAdminSpectating(p)) {
			continue;
		}
	
		if (drawTeam[GetPlayerTeamEx(p)]) {
			GivePlayerReward(p, rewardExp[2], rewardMoney[2], REWARD_MATCH, false);
			PlayerPlaySoundEx(p, 36203, 0.0, 0.0, 0.0);

			SCM(p, C_YELLOW, ""T_MATCH" Ничья!");
		}
		else if (winTeam[GetPlayerTeamEx(p)]) {
			GivePlayerReward(p, rewardExp[0], rewardMoney[0], REWARD_MATCH, false);
			GivePlayerWinningMatchs(p, 1);
			PlayerPlaySoundEx(p, 36203, 0.0, 0.0, 0.0);

			SCM(p, C_GREEN, ""T_MATCH" Победа!");
		}
		else {
			GivePlayerReward(p, rewardExp[1], rewardMoney[1], REWARD_MATCH, false);
			GivePlayerLosingMatchs(p, 1);
			PlayerPlaySoundEx(p, 36200, 0.0, 0.0, 0.0);

			SCM(p, C_RED, ""T_MATCH" Поражение!");
		}
	}
	return 1;
}

static UpdatePlayerTeamScoreTD(playerid)
{
	new
		roomid = Mode_GetPlayerSession(playerid),
		b = 1,
		t = 0;

	foreach (new i:Room_ActiveTeamsScore[roomid]) {
		new 
			str[15],
			teamScore = Room_GetTeamModeScore(roomid, i);

		switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
			case ROOM_GAME_MODE_BATTLE: {
				f(str, "%i", teamScore);
			}
			case ROOM_GAME_MODE_CAPTURE: {
				f(str, "%i/%i", teamScore, Room_GetTeamModeMaxScore(roomid, i));
			}
			case ROOM_GAME_MODE_DATA: {
				f(str, "%i/%i", teamScore, Room_GetTeamModeMaxScore(roomid, i));
			}
		}
		PlayerTextDrawSetString(playerid, TD_TeamScore[playerid][b], str);
		SetPlayerProgressBarValue(playerid, PlayerBarScoreMatch[playerid][t], floatround(teamScore));

		b += 2;
		t++;
	}
	return 1;
}

static SettingsPlayerSpawn(playerid)
{
	new 
		roomid = Mode_GetPlayerSession(playerid),
		skinid = Mode_GetPlayerSkin(playerid, MODE_ROOM),
		teamid = GetPlayerTeamEx(playerid);

	Mode_SetPlayerVirtualWorld(playerid, MODE_ROOM, roomid);
	Mode_SetPlayerInterior(playerid, MODE_ROOM, roomid);

	new
		Float:X, Float:Y, Float:Z,
		randomPos = random(3);

	Room_GetSpawnBasePos(roomid, teamid, randomPos, X, Y, Z);
	SetSpawnInfoEx(playerid, skinid, X, Y, Z + 0.3, 0.0);
	return 1;
}

static SetPlayerAmmunition(playerid) 
{
	new
		roomid = Mode_GetPlayerSession(playerid);

	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerArmourEx(playerid, 30.0);

	n_for(w, 3) {
		if (!rInfo[roomid][e_Weapon][w]) {
			continue;
		}

		GivePlayerWeaponEx(playerid, rInfo[roomid][e_Weapon][w], 100000);
	}

	SetPlayerSkinEx(playerid, GetPlayerSkinEx(playerid));
	SetPlayerColorEx(playerid, Room_GetTeamColorXB(GetPlayerTeamEx(playerid)));
	SetPlayerAttachInvItem(playerid);
	return 1;
}

static CheckList(playerid, listitem)
{
	if (listitem == 20) {
		DialogFirstRoom[playerid] += 20;
	}
	else { 
		DialogFirstRoom[playerid] -= 20;
	}

	if (DialogFirstRoom[playerid] < 0) {
		n_for(i, 22)
			DialogListRoomID[playerid][i] = 0;

		DialogFirstRoom[playerid] = 0;
		SetPVarInt(playerid, "RoomID", -1);
		Dialog_Show(playerid, Dialog:Room_ListRooms);
		return 1;
	}

	Dialog_Show(playerid, Dialog:Room_ListRooms);
	return 1;
}

static CreatePlayerTeamScoreTD(playerid, tdid = -1, onetdid = -1, teamid, maxscore)
{
	if (onetdid != -1) {
		switch (onetdid) {
			case 0: {
				PlayerBarScoreMatch[playerid][0] = CreatePlayerProgressBar(playerid, 284.00, 43.00, 84.50, 5.19, Room_GetTeamColorXB(teamid), maxscore, BAR_DIRECTION_RIGHT);
			}
		}
	}

	if (tdid != -1) {
		switch (tdid) {
			case 0: {
				PlayerBarScoreMatch[playerid][0] = CreatePlayerProgressBar(playerid, 233.00, 43.00, 84.50, 5.19, Room_GetTeamColorXB(teamid), maxscore, BAR_DIRECTION_LEFT);
			}
			case 1: {
				PlayerBarScoreMatch[playerid][1] = CreatePlayerProgressBar(playerid, 327.00, 43.00, 84.50, 5.19, Room_GetTeamColorXB(teamid), maxscore, BAR_DIRECTION_RIGHT);
			}
		}
	}

	Room_CreatePlayerTeamScoreTD(playerid, TD_TeamScore[playerid], tdid, onetdid, Room_GetTeamName(teamid), Room_GetTeamColorXB(teamid));
	return 1;
}

static ShowPlayerLobbyTD(playerid, roomid)
{
	new
		tdid = 0;

	Room_CreatePlayerLobbyTD(playerid, TD_LobbyRoom[playerid], 0.0, 0.0, true, tdid);

	PlayerTextDrawSetString(playerid, TD_LobbyRoom[playerid][4], "Комната \"%s\"", rInfo[roomid][e_Name]);
	PlayerTextDrawSetString(playerid, TD_LobbyRoom[playerid][5], Room_GetTeamName(ROOM_TEAM_ALPHA));
	PlayerTextDrawSetString(playerid, TD_LobbyRoom[playerid][6], Room_GetTeamName(ROOM_TEAM_BRAVO));

	// Players
	new
		Float:initialCoords[2] = {195.0, 170.0};

	for (new i = tdid, s = 1, num = 1; i < ROOM_TD_LOBBY; s++, num++) {
		Room_CreatePlayerLobbyTD(playerid, TD_LobbyRoom[playerid], initialCoords[0], initialCoords[1], false, tdid, num);

		i = tdid;

		if (s == 2) {
			s = 0;
			initialCoords[0] = 195.0;
			initialCoords[1] += 35.0;
		}
		else {
			initialCoords[0] += 126.0;
		}
	}
	return 1;
}

static CreatePlayerResultScoreTD(playerid, teamid, bool:activeTD, num, teams)
{
	new Float:pos_td_id[ROOM_MAX_TEAMS][2] = {
		{132.0, 112.0},
		{330.0, 112.0},
		{132.0, 257.0}
	};
	new Float:pos_td_one_id[ROOM_MAX_TEAMS][2] = {
		{220.0, 112.0},
		{0.0, 0.0},
		{220.0, 257.0}
	};

	new 
		Float:posTD[2],
		tdid = 0;

	if (!activeTD) {
		n_for(i, 2)
			posTD[i] = pos_td_id[num][i];
	}
	else { 
		n_for(i, 2)
			posTD[i] = pos_td_one_id[num][i];
	}

	// Match result
	Room_CreatePlayerMatchResultTD(playerid, TD_MatchResult[playerid][num], posTD[0], posTD[1]);

	n_for(i, ROOM_TD_MATCH_RESULT) {
		PlayerTextDrawShow(playerid, TD_MatchResult[playerid][num][i]);
	}

	// Player match stats
	if (teams == (num + 1)) {
		new
			Float:posStatsTD[2];

		if (!IsCh(teams)) {
			posStatsTD[0] = posTD[0];
			posStatsTD[1] = posTD[1];
		}
		else {
			posStatsTD[0] = pos_td_id[num - 1][0];
			posStatsTD[1] = pos_td_id[num - 1][1];
		}

		Room_CreatePlEndMatchStatsTD(playerid, TD_EndMatchStats[playerid], posStatsTD[0], posStatsTD[1]);

		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][1], "Ранг:_~y~%i", GetPlayerRank(playerid));
		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][2], "Убийств:_~b~%i", Mode_GetPlayerMatchKills(playerid));
		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][3], "Смертей:_~r~%i", Mode_GetPlayerMatchDeaths(playerid));
		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][5], "Получено всего EXP:_~y~+%i", Mode_GetPlayerMatchExp(playerid));
		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][6], "Получено всего денег:_~g~+$%i", Mode_GetPlayerMatchMoney(playerid));

		n_for(i, ROOM_TD_END_MATCH_STATS) {
			PlayerTextDrawShow(playerid, TD_EndMatchStats[playerid][i]);
		}
	}

	// Top killers
	tdid = 0;
	posTD[0] += 1.0;
	posTD[1] += 30.0;

	n_for(i, ROOM_MAX_TOP_KILLERS) {
		Room_CreatePlayerTopKillersTD(playerid, TD_TopKillers[playerid][num][tdid], posTD[0], posTD[1]);

		posTD[1] += 11.0;

		new
			roomid = Mode_GetPlayerSession(playerid);

		if (TOPPlayersData[roomid][teamid][i][1] > -1) {
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][0], "%i._%s", i + 1, TOPPlayersName[roomid][teamid][TOPPlayersData[roomid][teamid][i][1]]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][1], "%i", TOPPlayersData[roomid][teamid][i][0]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][2], "%i", TOPPlayersData[roomid][teamid][i][2]);

			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][0]);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][1]);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][2]);
		}
		tdid++;
	}
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetSessionData(roomid)
{
	Room_LocResetSessionData(roomid);

	ResetRoomData(roomid);
	ResetTopPlayers(roomid);
	return 1;
}

static ResetTopPlayers(roomid)
{
	n_for(t, ROOM_MAX_TEAMS) {
		n_for2(b, 5) {
			TOPPlayersData[roomid][t][b][0] =
			TOPPlayersData[roomid][t][b][1] =
			TOPPlayersData[roomid][t][b][2] = -1;
			TOPPlayersName[roomid][t][b][0] = EOS;
		}
		TOPTempVar[roomid][t] = 0;
	}
	return 1;
}

static ResetPlayerData(playerid)
{
	n_for(i, 22) {
		DialogListRoomID[playerid][i] = 0;
	}

	DialogFirstRoom[playerid] = 0;
	SetPVarInt(playerid, "RoomID", -1);
	SetPVarInt(playerid, "RoomSlotID", -1);
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(i, ROOM_TD_TEAM_SCORE) {
		TD_TeamScore[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(t, ROOM_MAX_TEAMS) {
		n_for2(i, ROOM_TD_MATCH_RESULT) {
			TD_MatchResult[playerid][t][i] = INVALID_PLAYER_TEXT_DRAW;
		}
	}

	n_for(i, ROOM_TD_END_MATCH_STATS) {
		TD_EndMatchStats[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(t, ROOM_MAX_TEAMS) {
		n_for2(i, ROOM_MAX_TOP_KILLERS) {
			n_for3(b, ROOM_TD_TOP_KILLERS) {
				TD_TopKillers[playerid][t][i][b] = INVALID_PLAYER_TEXT_DRAW;
			}
		}
	}

	n_for(i, ROOM_TD_LOBBY) {
		TD_LobbyRoom[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	return 1;
}

/*
 * |>------------------<|
 * |     Interfaces     |
 * |>------------------<|
 */

InterfaceCreate:Room_Lobby(playerid)
{
	new
		roomid = GetPVarInt(playerid, "RoomID");

	ShowPlayerLobbyTD(playerid, roomid);

	n_for(i, ROOM_TD_LOBBY) {
		PlayerTextDrawShow(playerid, TD_LobbyRoom[playerid][i]);
	}
	n_for(p, rInfo[roomid][e_NumberPlayers]) {
		UpdatePlayerLobbyTD(rInfo[roomid][e_Players][p], roomid);
	}
	return 1;
}

InterfaceClose:Room_Lobby(playerid)
{
	n_for(i, ROOM_TD_LOBBY) {
		DestroyPlayerTD(playerid, TD_LobbyRoom[playerid][i]);
	}
	return 1;
}

InterfacePlayerClick:Room_Lobby(playerid, PlayerText:playertextid)
{
	new
		roomid = GetPVarInt(playerid, "RoomID");

	if (playertextid == TD_LobbyRoom[playerid][10]) {
		Room_ExitPlayerLobby(playerid);
	}
	else if (playertextid == TD_LobbyRoom[playerid][13]) { 
		Dialog_Show(playerid, Dialog:Room_InfoRoom);
	}
	else if (playertextid == TD_LobbyRoom[playerid][16]) {
		if (strcmp(GetPlayerNameEx(roomid), GetPlayerNameEx(playerid), true)) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Доступ к параметрам имеется только у создателя комнаты!");
		}
		else {
			Dialog_Show(playerid, Dialog:Room_Settings);
		}
	}
	else if (playertextid == TD_LobbyRoom[playerid][19]) {
		Room_ChangePlayerTeam(playerid, roomid);
	}
	if (!Dialog_IsOpen(playerid)) {
		if (rInfo[playerid][e_Status]) {
			new 
				team[ROOM_MAX_TEAMS] = {-1, ...};

			for (new m = 0, num = 1, td = 20; m < rInfo[playerid][e_MaxNumberPlayers]; m++, num++, td += 4) {
				new 
					cell = -1;

				if (!IsCh(num)) {
					new 
						teamRoom = ROOM_TEAM_ALPHA;

					for (new i = team[teamRoom] + 1; i < rInfo[playerid][e_NumberPlayers]; i++) {
						if (rInfo[playerid][e_Teams][i] != teamRoom) {
							continue;
						}

						cell = i;
						team[teamRoom] = i;
						break;
					}
				}
				else {
					new 
						teamRoom = ROOM_TEAM_BRAVO;

					for (new i = team[teamRoom] + 1; i < rInfo[playerid][e_NumberPlayers]; i++) {
						if (rInfo[playerid][e_Teams][i] != teamRoom) {
							continue;
						}

						cell = i;
						team[teamRoom] = i;
						break;
					}
				}
				if (playertextid == TD_LobbyRoom[playerid][td]) {
					if (cell > -1) {
						SetPVarInt(playerid, "RoomLobbyPlayerID", cell);
						Dialog_Show(playerid, Dialog:Room_ExcludePlayer);
					}
				}
			}
		}
	}
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

/*
 * |>---------------<|
 * |   Information   |
 * |>---------------<|
 */

DialogCreate:Room_InfoRoom(playerid)
{
	static
		str[600];

	str[0] = EOS;

	new
		roomid = GetPVarInt(playerid, "RoomID"),
		weaponName1[MAX_LENGTH_WEAPON_NAME],
		weaponName2[MAX_LENGTH_WEAPON_NAME],
		weaponName3[MAX_LENGTH_WEAPON_NAME];

	// Weapon 1
	if (!rInfo[roomid][e_Weapon][0]) {
		weaponName1 = "Ничего";
	}
	else {
		GetWeaponNameRU(rInfo[roomid][e_Weapon][0], weaponName1, MAX_LENGTH_WEAPON_NAME);
	}

	// Weapon 2
	if (!rInfo[roomid][e_Weapon][1]) {
		weaponName2 = "Ничего";
	}
	else {
		GetWeaponNameRU(rInfo[roomid][e_Weapon][1], weaponName2, MAX_LENGTH_WEAPON_NAME);
	}

	// Weapon 3
	if (!rInfo[roomid][e_Weapon][2]) {
		weaponName3 = "Ничего";
	}
	else {
		GetWeaponNameRU(rInfo[roomid][e_Weapon][2], weaponName3, MAX_LENGTH_WEAPON_NAME);
	}

	f(str, "\
	"CT_GREY"Комната: "CT_WHITE"[{f0b111}%s"CT_WHITE"]\
	\n"CT_GREY"Создатель: "CT_WHITE"[{e3b030}%s"CT_WHITE"]\
	\n"CT_GREY"Локация: "CT_WHITE"[{3059e3}%s"CT_WHITE"]\
	\n"CT_GREY"Режим: "CT_WHITE"[{30d7e3}%s"CT_WHITE"]\
	\n"CT_GREY"Время: [{7de330}%i минут"CT_WHITE"]\
	\n"CT_GREY"Участников: "CT_WHITE"[{f0b111}%ivs%i"CT_WHITE"]\
	\n"CT_GREY"Оружие:\
	\n"CT_GREY"1 слот: "CT_WHITE"[{e37a30}%s"CT_WHITE"]\
	\n"CT_GREY"2 слот: "CT_WHITE"[{e37a30}%s"CT_WHITE"]\
	\n"CT_GREY"3 слот: "CT_WHITE"[{e37a30}%s"CT_WHITE"]",
	rInfo[roomid][e_Name], GetPlayerNameEx(roomid), Mode_GetLocationName(MODE_ROOM, rInfo[roomid][e_Location]), Mode_GetGameModeName(MODE_ROOM, rInfo[roomid][e_GameMode]), rInfo[roomid][e_Minutes], rInfo[roomid][e_MaxNumberPlayers] / 2, rInfo[roomid][e_MaxNumberPlayers] / 2, weaponName1, weaponName2, weaponName3);
	Dialog_Message(playerid, "{e39b30}Информация о комнате", str, "Понятно");
	return 1;
}

/*
 * |>------------------------<|
 * |   Select enter in room   |
 * |>------------------------<|
 */

DialogCreate:Room_SelectingTab(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SelectingTab, DSL, "{e39b30}Комната", ""CT_ORANGE""T_NUM" "CT_WHITE"Список комнат\n"CT_ORANGE""T_NUM" "CT_WHITE"Подключиться по названию\n"CT_ORANGE""T_NUM" "CT_WHITE"Создать комнату", "Выбрать", "Выйти");
	return 1;
}

DialogResponse:Room_SelectingTab(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Interface_Show(playerid, Interface:MM_SelectModes);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:Room_ListRooms);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:Room_ConnectRoom);
		}
		case 2: {
			Dialog_Show(playerid, Dialog:Room_InputName);
		}
	}
	return 1;
}

/*
 * |>-------------<|
 * |   List room   |
 * |>-------------<|
 */

DialogCreate:Room_ListRooms(playerid)
{
	static
		string[2048];

	string[0] = EOS;

	new
		start = DialogFirstRoom[playerid];

	strcat(string, "Название\tУчастников\tДоступ\n");

	new 
		index = 0;

	if (start > 0) {
		for (new i = 0, c = 0; i < GMS_MAX_SESSIONS && c < start; i++) {
			if (rInfo[i][e_Status] != ROOM_STATUS_LOBBY) {
				continue;
			}

			c++;
			index = i;
		}
	}

	new
		rooms;

	for (new i = index, l; i < GMS_MAX_SESSIONS; i++) {
		if (rInfo[i][e_Status] != ROOM_STATUS_LOBBY) {
			continue;
		}

		if (l > 20) {
			break;
		}
	
		f(string,
		"%s%s\
		\t%i/%i\
		\t%s\n",
		string, rInfo[i][e_Name],
		rInfo[i][e_NumberPlayers], rInfo[i][e_MaxNumberPlayers],
		rInfo[i][e_Access] ? "{d91616}Закрытый" : "{16d94a}Открытый");

		DialogListRoomID[playerid][l] = i;
		l++;
		rooms++;
	}

	if (!rooms) {
		SCM(playerid, C_LIGHT_BLUE, ""T_ROOM" "CT_WHITE"Список комнат пуст.");
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}

	if (rooms == 20) {
		f(string, "%s"CT_GREY"Далее >>>\n", string);
	}

	Dialog_Open(playerid, Dialog:Room_ListRooms, DSTH, "{e39b30}Список комнат", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_ListRooms(playerid, response, listitem, inputtext[])
{
	if (!response) {
		n_for(i, 22) {
			DialogListRoomID[playerid][i] = 0;
		}
		DialogFirstRoom[playerid] = 0;

		SetPVarInt(playerid, "RoomID", -1);
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}

	if (listitem == 20
	|| listitem == 21) {
		CheckList(playerid, listitem);
	}
	else {
		if (GetString(inputtext, "<<< Назад")) {
			return CheckList(playerid, 21);
		}

		new 
			roomid = DialogListRoomID[playerid][listitem];

		if (rInfo[roomid][e_Status] != ROOM_STATUS_LOBBY) {
			n_for(i, 22) {
				DialogListRoomID[playerid][i] = 0;
			}
			DialogFirstRoom[playerid] = 0;
			SetPVarInt(playerid, "RoomID", -1);

			SCM(playerid, C_LIGHT_BLUE, ""T_ROOM" "CT_WHITE"Данная комната уже не активна.");
			Dialog_Show(playerid, Dialog:Room_SelectingTab);
			return 1;
		}
		n_for(i, 22) {
			DialogListRoomID[playerid][i] = 0;
		}
		DialogFirstRoom[playerid] = 0;

		if (rInfo[roomid][e_Access]) {
			SetPVarInt(playerid, "RoomLobbyPlayerID2", roomid);
			Dialog_Show(playerid, Dialog:Room_InputPassword);
			return 1;
		}
		Room_EnterPlayerLobby(playerid, roomid);
	}
	return 1;
}

/*
 * |>----------------------------<|
 * |   Input password for enter   |
 * |>----------------------------<|
 */

DialogCreate:Room_InputPassword(playerid)
{
	Dialog_Open(playerid, Dialog:Room_InputPassword, DSI, "{e39b30}Ввод пароля", ""CT_WHITE"Для подключения, введите пароль от комнаты.", "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_InputPassword(playerid, response, listitem, inputtext[])
{
	if (!response) {
		n_for(i, 22) {
			DialogListRoomID[playerid][i] = 0;
		}
		DialogFirstRoom[playerid] = 0;

		DeletePVar(playerid, "RoomLobbyPlayerID2");
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}

	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:Room_InputPassword);
	}

	new
		roomid = GetPVarInt(playerid, "RoomLobbyPlayerID2");
	
	if (rInfo[roomid][e_Status] != ROOM_STATUS_LOBBY) {
		n_for(i, 22) {
			DialogListRoomID[playerid][i] = 0;
		}

		SetPVarInt(playerid, "RoomID", -1);
		DialogFirstRoom[playerid] = 0;

		SCM(playerid, C_LIGHT_BLUE, ""T_ROOM" "CT_WHITE"Данная комната уже не активна.");
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}
	if (strcmp(inputtext, rInfo[roomid][e_Password], true)) {
		Dialog_Show(playerid, Dialog:Room_InputPassword);

		SCM(playerid, C_RED, "Ошибка: неверный пароль!");
		return 1;
	}

	n_for(i, 22) {
		DialogListRoomID[playerid][i] = 0;
	}
	DialogFirstRoom[playerid] = 0;

	Room_EnterPlayerLobby(playerid, roomid);
	return 1;
}

/*
 * |>----------------<|
 * |   Set password   |
 * |>----------------<|
 */

DialogCreate:Room_SetPassword(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetPassword, DSI, "{e39b30}Создание пароля", "\
	"CT_WHITE"Для закрытого доступа в комнату придумайте пароль.\
	\n\n"CT_RED"Примечание:\
	\n"CT_GREY"1. Пароль должен содержать от 3 до 10 символов.\
	\n2. Пароль должен содержать только латинские символы и цифры.", "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_SetPassword(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:Room_Create);
		return 1;
	}

	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:Room_SetPassword);
	}

	for (new i = strlen(inputtext)-1; i != -1; i--) {
		switch (inputtext[i]) {
			case '0'..'9', 'a'..'z', 'A'..'Z': {
				continue;
			}
			default: {
				Dialog_Show(playerid, Dialog:Room_SetPassword);

				SCM(playerid, C_RED, "Ошибка: пароль должен содержать латинские символы и цифры!");
				return 1;
			}
		}
	}

	if (strlen(inputtext) < 3 || strlen(inputtext) > 10) {
		Dialog_Show(playerid, Dialog:Room_SetPassword);

		SCM(playerid, C_RED, "Ошибка: пароль слишком короткий или длинный!");
		return 1;
	}

	new
		roomid = GetPVarInt(playerid, "RoomID");

	rInfo[roomid][e_Access] = true;
	rInfo[roomid][e_Password][0] = EOS;
	strcopy(rInfo[roomid][e_Password], inputtext, ROOM_MAX_PASSWORD_LENGTH);

	Dialog_Show(playerid, Dialog:Room_Create);
	return 1;
}

/*
 * |>----------------<|
 * |   Select acces   |
 * |>----------------<|
 */

DialogCreate:Room_ChooseAccess(playerid)
{
	Dialog_Open(playerid, Dialog:Room_ChooseAccess, DSL, "{e39b30}Доступ", ""CT_ORANGE""T_NUM" {16d94a}Открытый\n"CT_ORANGE""T_NUM" {d91616}Закрытый", "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_ChooseAccess(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:Room_Create);
		return 1;
	}

	switch (listitem) {
		case 0: {
			new
				roomid = GetPVarInt(playerid, "RoomID");

			rInfo[roomid][e_Access] = false;
			rInfo[roomid][e_Password][0] = EOS;

			Dialog_Show(playerid, Dialog:Room_Create);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:Room_SetPassword);
		}
	}
	return 1;
}

/*
 * |>----------------<|
 * |   Set weapon 1   |
 * |>----------------<|
 */

DialogCreate:Room_SetWeaponMain(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetWeaponMain, DSL, "{e39b30}Оружие в 1 слоте", "\
	"CT_ORANGE""T_NUM" "CT_WHITE"Ничего\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"M4\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"AK-47\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Реактивный гранатомет\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Гранатомет с тепловым наведением\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Огнемёт\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Миниган\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Винтовка\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Снайперская винтовка",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetWeaponMain(playerid, response, listitem, inputtext[])
{
	if (response) {
		new
			WEAPON:weapon;

		switch (listitem) {
			case 0: weapon = WEAPON_FIST;
			case 1: weapon = WEAPON_M4;
			case 2: weapon = WEAPON_AK47;
			case 3: weapon = WEAPON_ROCKETLAUNCHER;
			case 4: weapon = WEAPON_HEATSEEKER;
			case 5: weapon = WEAPON_FLAMETHROWER;
			case 6: weapon = WEAPON_MINIGUN;
			case 7: weapon = WEAPON_RIFLE;
			case 8: weapon = WEAPON_SNIPER;
		}

		new
			roomid = GetPVarInt(playerid, "RoomID");

		rInfo[roomid][e_Weapon][0] = weapon;
	}

	Dialog_Show(playerid, Dialog:Room_SetWeapon);
	return 1;
}

/*
 * |>----------------<|
 * |   Set weapon 2   |
 * |>----------------<|
 */

DialogCreate:Room_SetWeaponSecondary(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetWeaponSecondary, DSL, "{e39b30}Оружие в 2 слоте", "\
	"CT_ORANGE""T_NUM" "CT_WHITE"Ничего\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Дробовик\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Боевой дробовик\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Обрез\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Узи\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"МП5\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Тек-9\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Пустынный орел\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Пистолет\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Пистолет с глушителем",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetWeaponSecondary(playerid, response, listitem, inputtext[])
{
	if (response) {
		new 
			WEAPON:weapon;

		switch (listitem) {
			case 0: weapon = WEAPON_FIST;
			case 1: weapon = WEAPON_SHOTGUN;
			case 2: weapon = WEAPON_SHOTGSPA;
			case 3: weapon = WEAPON_SAWEDOFF;
			case 4: weapon = WEAPON_UZI;
			case 5: weapon = WEAPON_MP5;
			case 6: weapon = WEAPON_TEC9;
			case 7: weapon = WEAPON_DEAGLE;
			case 8: weapon = WEAPON_COLT45;
			case 9: weapon = WEAPON_SILENCED;
		}

		new
			roomid = GetPVarInt(playerid, "RoomID");

		rInfo[roomid][e_Weapon][1] = weapon;
	}

	Dialog_Show(playerid, Dialog:Room_SetWeapon);
	return 1;
}

/*
 * |>----------------<|
 * |   Set weapon 3   |
 * |>----------------<|
 */

DialogCreate:Room_SetWeaponThird(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetWeaponThird, DSL, "{e39b30}Оружие в 3 слоте", "\
	"CT_ORANGE""T_NUM" "CT_WHITE"Ничего\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Граната\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Слезоточивый газ\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Коктейль Молотова\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Клюшка для гольфа\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Нож\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Катана\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Бейсбольная бита\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Лопата\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Кий\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Кастет\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Полицейская дубинка\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Бензопила",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetWeaponThird(playerid, response, listitem, inputtext[])
{
	if (response) {
		new 
			WEAPON:weapon;

		switch (listitem) {
			case 0: weapon = WEAPON_FIST;
			case 1: weapon = WEAPON_GRENADE;
			case 2: weapon = WEAPON_TEARGAS;
			case 3: weapon = WEAPON_MOLOTOV;
			case 4: weapon = WEAPON_GOLFCLUB;
			case 5: weapon = WEAPON_KNIFE;
			case 6: weapon = WEAPON_KATANA;
			case 7: weapon = WEAPON_BAT;
			case 8: weapon = WEAPON_SHOVEL;
			case 9: weapon = WEAPON_POOLSTICK;
			case 10: weapon = WEAPON_BRASSKNUCKLE;
			case 11: weapon = WEAPON_NIGHTSTICK;
			case 12: weapon = WEAPON_CHAINSAW;
		}

		new
			roomid = GetPVarInt(playerid, "RoomID");

		rInfo[roomid][e_Weapon][2] = weapon;
	}

	Dialog_Show(playerid, Dialog:Room_SetWeapon);
	return 1;
}

/*
 * |>---------------------<|
 * |   Select set weapon   |
 * |>---------------------<|
 */

DialogCreate:Room_SetWeapon(playerid)
{
	static 
		str[300];

	str[0] = EOS;

	new
		slot1[MAX_LENGTH_WEAPON_NAME],
		slot2[MAX_LENGTH_WEAPON_NAME],
		slot3[MAX_LENGTH_WEAPON_NAME];

	new
		roomid = GetPVarInt(playerid, "RoomID");

	// Weapon 1
	if (!rInfo[roomid][e_Weapon][0]) {
		slot1 = "{d91616}Ничего";
	}
	else {
		GetWeaponNameRU(rInfo[roomid][e_Weapon][0], slot1, MAX_LENGTH_WEAPON_NAME);
	}

	// Weapon 2
	if (!rInfo[roomid][e_Weapon][1]) {
		slot2 = "{d91616}Ничего";
	}
	else {
		GetWeaponNameRU(rInfo[roomid][e_Weapon][1], slot2, MAX_LENGTH_WEAPON_NAME);
	}

	// Weapon 3
	if (!rInfo[roomid][e_Weapon][2]) {
		slot3 = "{d91616}Ничего";
	}
	else {
		GetWeaponNameRU(rInfo[roomid][e_Weapon][2], slot3, MAX_LENGTH_WEAPON_NAME);
	}

	f(str, "Слот\tОружие\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Основной\t[ %s"CT_WHITE" ]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Вторичный\t[ %s"CT_WHITE" ]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Третий\t[ %s"CT_WHITE" ]",
	slot1, slot2, slot3);
	Dialog_Open(playerid, Dialog:Room_SetWeapon, DSTH, "{e39b30}Выбор оружия", str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetWeapon(playerid, response, listitem, inputtext[])
{
	if (!response) {
		new
			roomid = GetPVarInt(playerid, "RoomID");

		if (rInfo[roomid][e_Status] == ROOM_STATUS_LOBBY) {
			Dialog_Show(playerid, Dialog:Room_Settings);
		}
		else { 
			Dialog_Show(playerid, Dialog:Room_Create);
		}
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:Room_SetWeaponMain);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:Room_SetWeaponSecondary);
		}
		case 2: {
			Dialog_Show(playerid, Dialog:Room_SetWeaponThird);
		}
	}
	return 1;
}

/*
 * |>------------<|
 * |   Settings   |
 * |>------------<|
 */

DialogCreate:Room_Settings(playerid)
{
	static
		str[500];

	str[0] = EOS;

	new
		weapon[50],
		access[50],
		wcheck;

	new
		roomid = GetPVarInt(playerid, "RoomID");

	n_for(w, 3) {
		if (rInfo[roomid][e_Weapon][w]) {
			wcheck++;
			break;
		}
	}

	if (wcheck) {
		weapon = "{16d94a}Есть";
	}
	else { 
		weapon = "{d91616}Нет";
	}

	if (!rInfo[roomid][e_Access]) {
		access = "{16d94a}Открытый";
	}
	else { 
		access = "{d91616}Закрытый";
	}

	f(str, "Данные\tЗначения\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Локация\t[{3059e3}%s"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Режим\t[{30d7e3}%s"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Время\t[{7de330}%i минут"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Участников\t[{f0b111}%ivs%i"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие\t[%s"CT_WHITE"]",
	Mode_GetLocationName(MODE_ROOM, rInfo[roomid][e_Location]), Mode_GetGameModeName(MODE_ROOM, rInfo[roomid][e_GameMode]), rInfo[roomid][e_Minutes], rInfo[roomid][e_MaxNumberPlayers] / 2, rInfo[roomid][e_MaxNumberPlayers] / 2, weapon);
	Dialog_Open(playerid, Dialog:Room_Settings, DSTH, "{e39b30}Параметры", str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_Settings(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:Room_ListLocations);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:Room_SelectMode);
		}
		case 2: {
			Dialog_Show(playerid, Dialog:Room_SetTimer);
		}
		case 3: {
			Dialog_Show(playerid, Dialog:Room_SetCountPlayers);
		}
		case 4: {
			Dialog_Show(playerid, Dialog:Room_SetWeapon);
		}
	}
	return 1;
}

/*
 * |>--------------------<|
 * |   Select game-mode   |
 * |>--------------------<|
 */

DialogCreate:Room_SelectMode(playerid)
{
	static
		string[1000];

	string[0] = EOS;

	n_for(i, ROOM_MAX_MODES) {
		new 
			str[150];

		f(str, ""CT_ORANGE""T_NUM" "CT_WHITE"%s\n", Mode_GetGameModeName(MODE_ROOM, i));
		strcat(string, str);
	}

	Dialog_Open(playerid, Dialog:Room_SelectMode, DSL, "{e39b30}Список режимов комнаты", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SelectMode(playerid, response, listitem, inputtext[])
{
	new
		roomid = GetPVarInt(playerid, "RoomID");

	if (response) {
		Mode_SetSessionGameMode(MODE_ROOM, roomid, listitem);
		rInfo[roomid][e_GameMode] = listitem;
	}

	if (rInfo[roomid][e_Status] == ROOM_STATUS_LOBBY) {
		Dialog_Show(playerid, Dialog:Room_Settings);
	}
	else { 
		Dialog_Show(playerid, Dialog:Room_Create);
	}
	return 1;
}

/*
 * |>-----------------------<|
 * |   Set maximum players   |
 * |>-----------------------<|
 */

DialogCreate:Room_SetCountPlayers(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetCountPlayers, DSL, "{e39b30}Количество участников", ""CT_ORANGE""T_NUM" "CT_WHITE"1vs1\n"CT_ORANGE""T_NUM" "CT_WHITE"2vs2\n"CT_ORANGE""T_NUM" "CT_WHITE"3vs3\n"CT_ORANGE""T_NUM" "CT_WHITE"4vs4\n"CT_ORANGE""T_NUM" "CT_WHITE"5vs5", "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetCountPlayers(playerid, response, listitem, inputtext[])
{
	new
		roomid = GetPVarInt(playerid, "RoomID");

	if (response) {
		new 
			players;

		switch (listitem) {
			case 0: {
				players = 2;
			}
			case 1: {
				players = 4;
			}
			case 2: {
				players = 6;
			}
			case 3: {
				players = 8;
			}
			case 4: {
				players = 10;
			}
		}
		if (rInfo[roomid][e_Status] == ROOM_STATUS_LOBBY) {
			if (rInfo[roomid][e_NumberPlayers] > players) {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В комнате находится больше людей!");
			}
			else {
				rInfo[roomid][e_MaxNumberPlayers] = players;
			}
		}
		else {
			rInfo[roomid][e_MaxNumberPlayers] = players;
		}
	}

	if (rInfo[roomid][e_Status] == ROOM_STATUS_LOBBY) {
		Dialog_Show(playerid, Dialog:Room_Settings);
	}
	else {
		Dialog_Show(playerid, Dialog:Room_Create);
	}
	return 1;
}

/*
 * |>-------------<|
 * |   Set timer   |
 * |>-------------<|
 */

DialogCreate:Room_SetTimer(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetTimer, DSI, "{e39b30}Установить время игры", ""CT_WHITE"Введите число для установления количества минут игры:\n\n- Доступно от 10 до 60 минут", "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_SetTimer(playerid, response, listitem, inputtext[])
{
	new
		roomid = GetPVarInt(playerid, "RoomID");

	if (response) {
		if (!strlen(inputtext)) {
			return Dialog_Show(playerid, Dialog:Room_SetTimer);
		}

		for (new i = strlen(inputtext)-1; i != -1; i--) {
			switch (inputtext[i]) {
				case '0'..'9': {
					continue;
				}
				default: {
					return Dialog_Show(playerid, Dialog:Room_SetTimer);
				}
			}
		}

		if (strval(inputtext) < 10 || strval(inputtext) > 60) {
			return Dialog_Show(playerid, Dialog:Room_SetTimer);
		}

		rInfo[roomid][e_Minutes] = strval(inputtext);
	}

	if (rInfo[roomid][e_Status] == ROOM_STATUS_LOBBY) {
		Dialog_Show(playerid, Dialog:Room_Settings);
	}
	else {
		Dialog_Show(playerid, Dialog:Room_Create);
	}
	return 1;
}

/*
 * |>---------------<|
 * |   Create room   |
 * |>---------------<|
 */

DialogCreate:Room_Create(playerid)
{
	static 
		str[500];

	str[0] = EOS;

	new
		weapon[50],
		access[50],
		wcheck;

	new
		roomid = GetPVarInt(playerid, "RoomID");

	n_for(w, 3) {
		if (rInfo[roomid][e_Weapon][w]) {
			wcheck++;
			break;
		}
	}

	if (wcheck) {
		weapon = "{16d94a}Есть";
	}
	else {
		weapon = "{d91616}Нет";
	}

	if (!rInfo[roomid][e_Access]) {
		access = "{16d94a}Открытый";
	}
	else {
		access = "{d91616}Закрытый";
	}

	f(str, "Данные\tЗначения\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Название\t[{f0b111}%s"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Локация\t[{3059e3}%s"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Режим\t[{30d7e3}%s"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Время\t[{7de330}%i минут"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Участников\t[{f0b111}%ivs%i"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие\t[%s"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Доступ\t[%s"CT_WHITE"]\
	\n\t\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Создать комнату",
	rInfo[roomid][e_Name], Mode_GetLocationName(MODE_ROOM, rInfo[roomid][e_Location]), Mode_GetGameModeName(MODE_ROOM, rInfo[roomid][e_GameMode]), rInfo[roomid][e_Minutes], rInfo[roomid][e_MaxNumberPlayers] / 2, rInfo[roomid][e_MaxNumberPlayers] / 2, weapon, access);
	Dialog_Open(playerid, Dialog:Room_Create, DSTH, "{e39b30}Создание комнаты", str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_Create(playerid, response, listitem, inputtext[])
{
	new
		roomid = GetPVarInt(playerid, "RoomID");

	if (!response) {
		Mode_DestroySession(MODE_ROOM, roomid);

		SetPVarInt(playerid, "RoomID", -1);
		SetPVarInt(playerid, "RoomSlotID", -1);
		DeletePVar(playerid, "RoomTeam");

		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}

	switch (listitem) {
		case 0:{
			Dialog_Show(playerid, Dialog:Room_ChangeInputName);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:Room_ListLocations);
		}
		case 2: {
			Dialog_Show(playerid, Dialog:Room_SelectMode);
		}
		case 3: {
			Dialog_Show(playerid, Dialog:Room_SetTimer);
		}
		case 4: {
			Dialog_Show(playerid, Dialog:Room_SetCountPlayers);
		}
		case 5: {
			Dialog_Show(playerid, Dialog:Room_SetWeapon);
		}
		case 6: {
			Dialog_Show(playerid, Dialog:Room_ChooseAccess);
		}
		case 7: {
			Dialog_Show(playerid, Dialog:Room_Create);
		}
		case 8: {
			rInfo[roomid][e_Status] = ROOM_STATUS_LOBBY;
			rInfo[roomid][e_Players][0] = playerid;
			rInfo[roomid][e_Teams][0] = ROOM_TEAM_ALPHA;

			Interface_Show(playerid, Interface:Room_Lobby);
			CheckPlayerDinaHint(playerid, 17);
		}
	}
	return 1;
}

/*
 * |>---------------<|
 * |   Change name   |
 * |>---------------<|
 */

DialogCreate:Room_ChangeInputName(playerid)
{
	new
		string[500];

	f(string, ""CT_WHITE"Введите новое название комнаты.\
	\n\n"CT_RED"Примечание:\
	\n"CT_GREY"1. Название должно содержать от 3 до 10 символов.\
	\n2. Название должно содержать только латинские символы и цифры.");
	Dialog_Open(playerid, Dialog:Room_ChangeInputName, DSI, "{e39b30}Изменение названия", string, "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_ChangeInputName(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:Room_Create);
		return 1;
	}

	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:Room_ChangeInputName);
	}

	foreach (new r:Sessions[MODE_ROOM]) {
		if (rInfo[r][e_Status]) {
			if (!strcmp(inputtext, rInfo[r][e_Name], true)) {
				Dialog_Show(playerid, Dialog:Room_ChangeInputName);
				SCM(playerid, C_RED, "Ошибка: данное название уже занято!");
				return 1;
			}
		}
	}

	for (new i = strlen(inputtext)-1; i != -1; i--) {
		switch (inputtext[i]) {
			case '0'..'9', 'a'..'z', 'A'..'Z': {
				continue;
			}
			default: {
				Dialog_Show(playerid, Dialog:Room_ChangeInputName);
				SCM(playerid, C_RED, "Ошибка: название должно содержать латинские символы и цифры!");
				return 1;
			}
		}
	}

	if (strlen(inputtext) < 3 || strlen(inputtext) > 10) {
		Dialog_Show(playerid, Dialog:Room_ChangeInputName);

		SCM(playerid, C_RED, "Ошибка: название слишком короткое или длинное!");
		return 1;
	}

	new
		roomid = GetPVarInt(playerid, "RoomID");

	strcopy(rInfo[roomid][e_Name], inputtext, ROOM_MAX_NAME_LENGTH);

	Dialog_Show(playerid, Dialog:Room_Create);
	return 1;
}

/*
 * |>--------------<|
 * |   Input name   |
 * |>--------------<|
 */

DialogCreate:Room_InputName(playerid)
{
	new
		string[500];

	f(string, ""CT_WHITE"Введите название будущей комнаты.\
	\n\n"CT_RED"Примечание:\
	\n"CT_GREY"1. Название должно содержать от 3 до 10 символов.\
	\n2. Название должно содержать только латинские символы и цифры.");
	Dialog_Open(playerid, Dialog:Room_InputName, DSI, "{e39b30}Создание комнаты", string, "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_InputName(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}

	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:Room_InputName);
	}

	foreach (new r:Sessions[MODE_ROOM]) {
		if (rInfo[r][e_Status]) {
			if (!strcmp(inputtext, rInfo[r][e_Name], true)) {
				Dialog_Show(playerid, Dialog:Room_InputName);

				SCM(playerid, C_RED, "Ошибка: данное название уже занято!");
				return 1;
			}
		}
	}

	for (new i = strlen(inputtext)-1; i != -1; i--) {
		switch (inputtext[i]) {
			case '0'..'9', 'a'..'z', 'A'..'Z': {
				continue;
			}
			default: {
				Dialog_Show(playerid, Dialog:Room_InputName);

				SCM(playerid, C_RED, "Ошибка: название должно содержать латинские символы и цифры!");
				return 1;
			}
		}
	}

	if (strlen(inputtext) < 3 || strlen(inputtext) > 10) {
		Dialog_Show(playerid, Dialog:Room_InputName);

		SCM(playerid, C_RED, "Ошибка: название слишком короткое или длинное!");
		return 1;
	}

	new
		roomid = Mode_CreateSession(MODE_ROOM);

	SetPVarInt(playerid, "RoomID", roomid);
	SetPVarInt(playerid, "RoomSlotID", 0);
	SetPVarInt(playerid, "RoomTeam", ROOM_TEAM_ALPHA);

	strcopy(rInfo[roomid][e_Name], inputtext, ROOM_MAX_NAME_LENGTH);

	rInfo[roomid][e_CreaterPlayerID] = playerid;
	rInfo[roomid][e_NumberPlayers] = 1;
	rInfo[roomid][e_MaxNumberPlayers] = 2;
	rInfo[roomid][e_Location] =
	rInfo[roomid][e_GameMode] =
	rInfo[roomid][e_EndTimer] = 0;
	rInfo[roomid][e_Minutes] = 10;
	rInfo[roomid][e_Access] = false;
	rInfo[roomid][e_LobbyMinutes] = 0;
	rInfo[roomid][e_LobbySeconds] = ROOM_LOBBY_TIMER;
	Dialog_Show(playerid, Dialog:Room_Create);
	return 1;
}

/*
 * |>------------------------<|
 * |   Connect in room name   |
 * |>------------------------<|
 */

DialogCreate:Room_ConnectRoom(playerid)
{
	Dialog_Open(playerid, Dialog:Room_ConnectRoom, DSI, "{e39b30}Подключиться по названию", ""CT_WHITE"Для подключения, введите название комнаты", "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_ConnectRoom(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}

	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:Room_ConnectRoom);
	}

	foreach (new r:Sessions[MODE_ROOM]) {
		if (rInfo[r][e_Status] != ROOM_STATUS_LOBBY) {
			continue;
		}

		if (!strcmp(inputtext, rInfo[r][e_Name], true)) {
			n_for2(i, 22) {
				DialogListRoomID[playerid][i] = 0;
			}
			DialogFirstRoom[playerid] = 0;

			if (rInfo[r][e_Access]) {
				SetPVarInt(playerid, "RoomLobbyPlayerID2", r);
				Dialog_Show(playerid, Dialog:Room_InputPassword);
				return 1;
			}

			Room_EnterPlayerLobby(playerid, r);
			return 1;
		}
	}

	SCM(playerid, C_LIGHT_BLUE, ""T_ROOM" "CT_WHITE"Данной комнаты не существует.");
	Dialog_Show(playerid, Dialog:Room_ConnectRoom);
	return 1;
}

/*
 * |>---------------------------<|
 * |   Exclude player in lobby   |
 * |>---------------------------<|
 */

DialogCreate:Room_ExcludePlayer(playerid)
{
	Dialog_Open(playerid, Dialog:Room_ExcludePlayer, DSL, "Управление комнатой", ""CT_ORANGE""T_NUM" "CT_WHITE"Исключить игрока", "Выбрать", "Выйти");
	return 1;
}

DialogResponse:Room_ExcludePlayer(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	switch (listitem) {
		case 0: {
			new 
				id = GetPVarInt(playerid, "RoomLobbyPlayerID"),
				roomid = GetPVarInt(playerid, "RoomID");

			if (id < 0 
			|| roomid < 0) {
				DeletePVar(playerid, "RoomLobbyPlayerID");
				return 1;
			}

			if (rInfo[roomid][e_Players][id] == playerid) {
				SCM(playerid, C_LIGHT_BLUE, ""T_ROOM" "CT_WHITE"Нельзя исключить самого себя.");
				return 1;
			}

			if (rInfo[roomid][e_Players][id] > -1) {
				new 
					p = rInfo[roomid][e_Players][id];

				if (!IsPlayerOnServer(p)) {
					return 1;
				}

				Room_ExitPlayerLobby(p);
				SCM(p, C_LIGHT_BLUE, ""T_ROOM" "CT_WHITE"Создатель комнаты исключил Вас.");
			}
		}
	}
	DeletePVar(playerid, "RoomLobbyPlayerID");
	return 1;
}

/*
 * |>-------------------<|
 * |   Select location   |
 * |>-------------------<|
 */

DialogCreate:Room_ListLocations(playerid)
{
	static
		string[500];

	string[0] = EOS;

	foreach (new i:Locations[MODE_ROOM]) {
		new 
			str[150];

		f(str, ""CT_ORANGE""T_NUM" "CT_WHITE"%s\n", Mode_GetLocationName(MODE_ROOM, i));
		strcat(string, str);
	}

	Dialog_Open(playerid, Dialog:Room_ListLocations, DSL, "{e39b30}Список локаций", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_ListLocations(playerid, response, listitem, inputtext[])
{
	new
		roomid = GetPVarInt(playerid, "RoomID");

	if (response) {
		rInfo[roomid][e_Location] = listitem;
	}

	if (rInfo[roomid][e_Status] == ROOM_STATUS_LOBBY) {
		Dialog_Show(playerid, Dialog:Room_Settings);
	}
	else {
		Dialog_Show(playerid, Dialog:Room_Create);
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

stock Room_OnGameModeInit()
{
	// Reset sessions
	n_for(sessionid, GMS_MAX_SESSIONS) {
		ResetSessionData(sessionid);
	}

	// Initialization
	Iter_Init(Room_ActiveTeams);
	Iter_Init(Room_ActiveTeamsScore);

	Room_LocOnGameModeInit();

	Mode_Add(MODE_ROOM, "Комната", "Комната",
		.enableStatus = true,
		.maxSessions = GMS_MAX_SESSIONS,
		.sessionMaxPlayers = 10,
		.changeEnableStatus = true,
		.changeSession = false,
		.changeSessionLocation = false);

	Mode_SetInfo(MODE_ROOM, "-");

	Mode_AddGameMode(MODE_ROOM, ROOM_GAME_MODE_BATTLE, "Сражение");
	Mode_SetGameModeInfo(MODE_ROOM, ROOM_GAME_MODE_BATTLE,
		"- После каждого убитого противника понижаются очки его команды.\
		\n- Побеждает команда с наибольшим количеством очков команды.");

	Mode_AddGameMode(MODE_ROOM, ROOM_GAME_MODE_CAPTURE, "Захват");
	Mode_SetGameModeInfo(MODE_ROOM, ROOM_GAME_MODE_CAPTURE,
		"- Необходимо захватить и удерживать точку захвата.\
		\n- Чем больше захваченных точек, тем быстрее повышаются очки команды.\
		\n- Побеждает команда с наибольшим количеством очков команды.");

	Mode_AddGameMode(MODE_ROOM, ROOM_GAME_MODE_DATA, "Взлом");
	Mode_SetGameModeInfo(MODE_ROOM, ROOM_GAME_MODE_DATA,
		"- Необходимо взломать или деактивировать компьютер.\
		\n- Защищающая команда отбивает противников от компьютера.\
		\n- Нападающая команда взламывает компьютер.\
		\n\n- Если защищающие сохранили даже один компьютер до окончания матча,\
		\nто они считаются победителями, при взломе всех компьютеров проигрывают.\
		\n- Если нападающие взломали все компьютеры до конца матча,\
		\nто они считаются победителями, при взломе не всех компьютеров проигрывают.");

	// Sessions
	Mode_CreateFirstSessions(MODE_ROOM);
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
	ResetPlayerTDs(playerid);

	n_for(i, 22) {
		DialogListRoomID[playerid][i] = 0;
	}
	DialogFirstRoom[playerid] = 0;
	
	SetPVarInt(playerid, "RoomID", -1);
	SetPVarInt(playerid, "RoomSlotID", -1);

	#if defined Room_OnPlayerConnect
		return Room_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>-----------------<|
 * |   OnPlayerSpawn   |
 * |>-----------------<|
 */

stock Room_OnPlayerSpawn(playerid)
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

	SetPlayerAmmunition(playerid);
	SetPlayerSpawnKill(playerid);

	SetPlayerTeamEx(playerid, GetPlayerTeamEx(playerid));

	CheckPlayerDinaHint(playerid, 8);
	return 1;
}

/*
 * |>-----------------<|
 * |   OnPlayerDeath   |
 * |>-----------------<|
 */

stock Room_OnPlayerDeath(playerid, &killerid, &WEAPON:reason)
{
	new
		roomid = Mode_GetPlayerSession(playerid);

	CheckPlayerDamageBody(playerid);

	if (killerid != INVALID_PLAYER_ID) {
		// Reward
		new 
			killStrike = GetPlayerKillStrike(killerid) * 10;

		GivePlayerReward(killerid, 150 + killStrike, 100 + killStrike, REWARD_KILL);

		// Spectate
		AddPlayerSpecatingPlayer(killerid, playerid);

		// Technical
		Mode_GivePlayerMatchKills(killerid, 1);
	}

	SetPlayerDamage(playerid, false);
	Mode_GivePlayerMatchDeaths(playerid, 1);

	m_for(MODE_ROOM, roomid, p) {
		SendDeathMessageToPlayer(p, killerid, playerid, reason);
	}

	DestroyPlayerBelowHealth(playerid);
	Room_DestroyPlayerPoint(playerid);
	Room_DestroyPlayerComputer(playerid);

	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_BATTLE: {
			Room_GiveTeamModeScore(roomid, GetPlayerTeamEx(playerid), 1);
		}
	}

	if (killerid != INVALID_PLAYER_ID) {
		SetPlayerSpeedRespawn(playerid, ROOM_PLAYER_TIMER_RESPAWN);
	}
	else { 
		SetPlayerSpeedRespawn(playerid, TIMER_PLAYER_RESPAWN);
	}

	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
 * |>----------------------------<|
 * |   OnPlayerEnterDynamicArea   |
 * |>----------------------------<|
 */

stock Room_OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) 
{
	if (Room_LocOnPlEnterDynamicArea(playerid, areaid)) {
		return 1;
	}
	return 1;
}

/*
 * |>----------------------------<|
 * |   OnPlayerLeaveDynamicArea   |
 * |>----------------------------<|
 */

stock Room_OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)  
{
	if (Room_LocOnPlLeaveDynamicArea(playerid, areaid)) {
		return 1;
	}
	return 1;
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

stock Room_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 0;
	}

	if (Room_LocOnPlKeyStateChange(playerid, newkeys, oldkeys)) {
		return 1;
	}

	// Anti +C
	if ((newkeys & (KEY_FIRE | KEY_CROUCH)) == (KEY_FIRE | KEY_CROUCH) 
	&& (oldkeys & (KEY_FIRE | KEY_CROUCH)) != (KEY_FIRE | KEY_CROUCH)) {
		DeaglePlayerAntiC(playerid);
	}
	return 1;
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
#define OnPlayerConnect Room_OnPlayerConnect
#if defined Room_OnPlayerConnect
	forward Room_OnPlayerConnect(playerid);
#endif