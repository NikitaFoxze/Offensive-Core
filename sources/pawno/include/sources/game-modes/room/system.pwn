/*

	About: Room core system
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

		Room_UpdatePlayer(playerid)
	Stock:
		Room_CreateLocation(room_id)
		Room_DestroyLocation(room_id)
		Room_ShowPlayerResultRound(playerid)
		Room_HidePlayerResultRound(playerid)
		Room_LocationEndGame(room_id)
		Room_UpdateTeamChet(room_id)
		Room_SetTeamModeChet(room_id, team_id, num)
		Room_GetTeamModeChet(room_id, team_id)
		Room_GiveTeamModeChet(room_id, team_id, num)
		Room_SetTeamModeMaxChet(room_id, team_id, num)
		Room_GetTeamModeMaxChet(room_id, team_id)

		Room_ShowPlayerTDTeamsChet(playerid)
		Room_DestroyPlayerTDTeamsChet(playerid)
		Room_ShowPlayerTDTeamChet(playerid, td_id, team_id, maxchet)
		Room_SetPlayerTeam(playerid, room_id)
		Room_ChangePlayerTeam(playerid, room_id)
		Room_UpdateTD(playerid, room_id)
		Room_Destroy(room_id)
		Room_Reset(room_id)
		Room_CallPlayer(playerid, room_id)
		Room_ExitPlayer(playerid, room_id, bool:type = false)
		Room_UpdateInfo()
		Room_CreateLocationPlayer(playerid, room_id, bool:set)
		Room_DestroyLocationPlayer(playerid, reset)
		Room_UpdateTime()
		Room_GetMode(room_id)
Enums:
	E_ROOM_INFO
Commands:
	-
Dialogs:
	Room_InfoRoom
	Room_SelectingTab
	Room_ListRooms
	Room_InputPassword
	Room_SetPassword
	Room_ChooseAccess
	Room_SetWeaponMain
	Room_SetWeaponSecondary
	Room_SetWeaponThird
	Room_SetWeapon
	Room_Settings
	Room_SelectMode
	Room_SetCountPlayers
	Room_SetTimer
	Room_Create
	Room_ChangeInputName
	Room_InputName
	Room_ConnectRoom
	Room_ExcludePlayer
	Room_ListLocations
Interfaces:
	Room_Lobby
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_CORE_SYSTEM
	#endinput
#endif
#define _INC_ROOM_CORE_SYSTEM

/*

	* Enums *

*/

enum E_ROOM_INFO {
	R_Status,
	R_Name[ROOM_MAX_NAME_LENGTH],
	R_NumberPlayers,
	R_Mode,
	R_Weapon[3],
	bool:R_Access,
	R_Password[ROOM_MAX_PASSWORD_LENGTH],
	R_LobbyMinutes,
	R_LobbySeconds,
	R_EndTimer,
	R_Players[ROOM_MAX_PLAYERS],
	R_Teams[ROOM_MAX_PLAYERS],
	R_Cell
}

/*

	* Vars *

*/

static
	RoomInfo[MAX_PLAYERS][E_ROOM_INFO];

static
	R_CountRooms,
	R_CountRoom[MAX_PLAYERS] = {-1, ...};

static
	players_Data[MAX_PLAYERS][ROOM_MAX_TEAMS][MAX_PLAYERS][3],
	players_Name[MAX_PLAYERS][ROOM_MAX_TEAMS][MAX_PLAYERS][MAX_PLAYER_NAME],
	tempVar[MAX_PLAYERS][ROOM_MAX_TEAMS];

static
	FirstRoom[MAX_PLAYERS],
	ListIDRoom[MAX_PLAYERS][22];

static
	PlayerText:TD_TopKillers[MAX_PLAYERS][ROOM_MAX_TEAMS][10][3],
	PlayerText:TD_EndRoundStats[MAX_PLAYERS][7],
	PlayerText:TD_ResultRound[MAX_PLAYERS][ROOM_MAX_TEAMS][9],
	PlayerText:TD_ChetLocation[MAX_PLAYERS][4],
	PlayerText:TD_Room[MAX_PLAYERS][60],
	PlayerBar:PlayerChetLocation[MAX_PLAYERS][2];

/*

	* Functions *

*/

stock Room_CreateLocation(room_id)
{
	Room_CreateElementsLocation(room_id);
	return 1;
}

stock Room_DestroyLocation(room_id)
{
	Room_DestroyElementsLocation(room_id);
	return 1;
}

stock Room_ShowPlayerResultRound(playerid)
{
	if(GetPVarInt(playerid, "ResultRound_PVar"))
		return 1;

	new
		room_id = Mode_GetPlayerSession(playerid);

	SetPVarInt(playerid, "ResultRound_PVar", 1);

	new
		teams = Iter_Count(Room_ActiveTeams[room_id]),
		num = 0;

	foreach(new t:Room_ActiveTeams[room_id]) {
		if(IsCh(t)) 
			Room_CreateTDResultChet(playerid, t, false, num, teams);
		else {
			if((num + 1) == teams) 
				Room_CreateTDResultChet(playerid, t, true, num, teams);
			else 
				Room_CreateTDResultChet(playerid, t, false, num, teams);
		}
		num++;
	}
	return 1;
}

stock Room_HidePlayerResultRound(playerid)
{
	if(!GetPVarInt(playerid, "ResultRound_PVar"))
		return 1;

	DeletePVar(playerid, "ResultRound_PVar");

	new
		num = 0,
		room_id = Mode_GetPlayerSession(playerid);

	foreach(new t:Room_ActiveTeams[room_id]) {
		n_for(i, sizeof(TD_ResultRound[][]))
			DestroyPlayerTD(playerid, TD_ResultRound[playerid][num][i]);

		n_for(i, sizeof(TD_TopKillers[][])) {
			n_for2(b, sizeof(TD_TopKillers[][][]))
				DestroyPlayerTD(playerid, TD_TopKillers[playerid][num][i][b]);
		}
		num++;
	}

	n_for(i, sizeof(TD_EndRoundStats[]))
		DestroyPlayerTD(playerid, TD_EndRoundStats[playerid][i]);

	ResetTopPlayers(room_id);

	Mode_SetPlayerExp(playerid, 0);
	Mode_SetPlayerMoney(playerid, 0);
	return 1;
}

stock Room_LocationEndGame(room_id)
{
	if(RoomInfo[room_id][R_Status] == ROOM_STATUS_END)
		return 1;

	RoomInfo[room_id][R_Status] = ROOM_STATUS_END;
	RoomInfo[room_id][R_EndTimer] = 15;

	// Топ игроков
	foreach(new t:Room_ActiveTeams[room_id]) {
		m_for(MODE_ROOM, room_id, p) {
			if(Adm_GetPlayerSpectating(p)) 
				continue;
			
			if(GetPlayerTeamEx(p) != t) 
				continue;

			players_Data[room_id][t][tempVar[room_id][t]][0] = Mode_GetPlayerKills(p);
			players_Data[room_id][t][tempVar[room_id][t]][2] = Mode_GetPlayerDeaths(p);
			GetPlayerName(p, players_Name[room_id][t][p], MAX_PLAYER_NAME);
			players_Data[room_id][t][tempVar[room_id][t]++][1] = p;
		}
	}
	foreach(new t:Room_ActiveTeams[room_id]) {
		for(new i = 0, j = 0; i < tempVar[room_id][t]; i++) {
			j = players_Data[room_id][t][i][0];

			for(new k = i - 1; k > -1; k--) {
				if(j > players_Data[room_id][t][k][0]) {
					players_Data[room_id][t][k][0] ^= players_Data[room_id][t][k + 1][0], players_Data[room_id][t][k + 1][0] ^= players_Data[room_id][t][k][0], players_Data[room_id][t][k][0] ^= players_Data[room_id][t][k + 1][0];
					players_Data[room_id][t][k][1] ^= players_Data[room_id][t][k + 1][1], players_Data[room_id][t][k + 1][1] ^= players_Data[room_id][t][k][1], players_Data[room_id][t][k][1] ^= players_Data[room_id][t][k + 1][1];
				}
			}
		}
	}
	//

	ShowResultRound(room_id);

	m_for(MODE_ROOM, room_id, p) {
		if(!Adm_GetPlayerSpectating(p))
			HidePlayerElementsEndRound(p);
	}
	return 1;
}

stock Room_UpdateTeamChet(room_id)
{
	new
		endgame;

	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_BATTLE: {
			foreach(new t:Room_ActiveTeams[room_id]) {
				if(Room_GetTeamModeChet(room_id, t) >= Room_GetTeamModeMaxChet(room_id, t)) 
					endgame++;
			}
		}
		case ROOM_MODE_CAPTURE: {
			new 
				point_team = Room_GetCapturePointColor(room_id);

			if(point_team) 
				Room_GiveTeamModeChet(room_id, point_team, 1);

			foreach(new t:Room_ActiveTeams[room_id]) {
				if(Room_GetTeamModeChet(room_id, t) >= Room_GetTeamModeMaxChet(room_id, t)) {
					Room_SetTeamModeChet(room_id, t, Room_GetTeamModeMaxChet(room_id, t));

					m_for(MODE_ROOM, room_id, p) 
						UpdatePlayerTDTeamChet(p);
					
					endgame++;
				}
			}
		}
		case ROOM_MODE_SECRET_DATA: {
			new 
				protect_team = Room_GetComputerProtectTeam(room_id);

			if(!Room_GetTeamModeChet(room_id, protect_team))
				endgame++;
		}
	}

	if(endgame > 0)
		Room_LocationEndGame(room_id);

	return 1;
}

/*
	Счёт команд игроков
*/

stock Room_SetTeamModeChet(room_id, team_id, num)
{
	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_BATTLE: Room_SetBattleTeamChet(room_id, team_id, num);
		case ROOM_MODE_CAPTURE: Room_SetCPTeamChet(room_id, team_id, num);
		case ROOM_MODE_SECRET_DATA: Room_SetCompTeamChet(room_id, team_id, num);
	}
	return 1;
}

stock Room_GetTeamModeChet(room_id, team_id)
{
	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_BATTLE: return Room_GetBattleTeamChet(room_id, team_id);
		case ROOM_MODE_CAPTURE: return Room_GetCPTeamChet(room_id, team_id);
		case ROOM_MODE_SECRET_DATA: return Room_GetCompTeamChet(room_id, team_id);
	}
	return 1;
}

stock Room_GiveTeamModeChet(room_id, team_id, num)
{
	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_BATTLE: Room_GiveBattleTeamChet(room_id, team_id, num);
		case ROOM_MODE_CAPTURE: Room_GiveCPTeamChet(room_id, team_id, num);
		case ROOM_MODE_SECRET_DATA: Room_GiveCompTeamChet(room_id, team_id, num);
	}
	return 1;
}

stock Room_SetTeamModeMaxChet(room_id, team_id, num) 
{
	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_BATTLE: Room_SetBattleTeamMaxChet(room_id, team_id, num);
		case ROOM_MODE_CAPTURE: Room_SetCPTeamMaxChet(room_id, team_id, num);
		case ROOM_MODE_SECRET_DATA: Room_SetCompTeamMaxChet(room_id, team_id, num);
	}
	return 1;
}

stock Room_GetTeamModeMaxChet(room_id, team_id) 
{
	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_BATTLE: return Room_GetBattleTeamMaxChet(room_id, team_id);
		case ROOM_MODE_CAPTURE: return Room_GetCPTeamMaxChet(room_id, team_id);
		case ROOM_MODE_SECRET_DATA: return Room_GetCompTeamMaxChet(room_id, team_id);
	}
	return 1;
}

stock Room_ShowPlayerTDTeamsChet(playerid)
{
	new
		room_id = Mode_GetPlayerSession(playerid),
		td_id = 0;

	foreach(new team_id:Room_ActiveTeamsChet[room_id]) {
		Room_ShowPlayerTDTeamChet(playerid, td_id, team_id, Room_GetTeamModeMaxChet(room_id, team_id));
		td_id++;
	}
	UpdatePlayerTDTeamChet(playerid);
	return 1;
}

stock Room_DestroyPlayerTDTeamsChet(playerid)
{
	new
		room_id = Mode_GetPlayerSession(playerid),
		bar_id = 0, 
		td_id = 0;

	foreach(new i:Room_ActiveTeamsChet[room_id]) {
		DestroyPlayerTD(playerid, TD_ChetLocation[playerid][td_id]);
		DestroyPlayerTD(playerid, TD_ChetLocation[playerid][td_id + 1]);

		DestroyPlayerProgressBar(playerid, PlayerChetLocation[playerid][bar_id]);

		td_id += 2;
		bar_id++;
	}
	return 1;
}

stock Room_ShowPlayerTDTeamChet(playerid, td_id, team_id, maxchet)
{
	new
		room_id = Mode_GetPlayerSession(playerid),
		teams = Iter_Count(Room_ActiveTeamsChet[room_id]),
		max_chet = floatround(maxchet);

	if(td_id + 1 <= teams) {
		if(IsCh(td_id + 1))
			Room_CreateTDTeamChet(playerid, td_id, -1, team_id, max_chet);
		else {
			if(td_id + 1 == teams) 
				Room_CreateTDTeamChet(playerid, -1, td_id, team_id, max_chet);
			else 
				Room_CreateTDTeamChet(playerid, td_id, -1, team_id, max_chet);
		}
	}

	ShowPlayerProgressBar(playerid, PlayerChetLocation[playerid][td_id]);
	return 1;
}

stock Room_SetPlayerTeam(playerid, room_id)
{
	new
		team[ROOM_MAX_TEAMS];

	n_for(t, ROOM_MAX_TEAMS) {
		n_for2(r, Mode_GetSessionPlayers(MODE_ROOM, room_id)) {
			if(RoomInfo[room_id][R_Teams][r] != t) 
				continue;

			team[t]++;
		}
	}

	new
		most_team;

	n_for(t, ROOM_MAX_TEAMS) {
		if(team[t] >= most_team)
			most_team = team[t];
	}

	new
		lost_team = most_team,
		index;

	n_for(t, ROOM_MAX_TEAMS) {
		if(team[t] <= lost_team) {
			lost_team = team[t];
			index = t;
		}
	}

	n_for(r, RoomInfo[room_id][R_NumberPlayers]) {
		if(RoomInfo[room_id][R_Players][r] > -1)
			continue;

		RoomInfo[room_id][R_Players][r] = playerid;
		RoomInfo[room_id][R_Teams][r] = index;

		SetPVarInt(playerid, "Room_Slot_PVar", r);
		SetPVarInt(playerid, "Room_Team_PVar", index);
		break;
	}
	return 1;
}

stock Room_ChangePlayerTeam(playerid, room_id)
{
	new
		new_team;

	for(new t = 1; t < ROOM_MAX_TEAMS; t++) {
		if(t == GetPVarInt(playerid, "Room_Team_PVar")) 
			continue;

		new_team = t;
		break;
	}

	new
		players;

	n_for(r, Mode_GetSessionPlayers(MODE_ROOM, room_id)) {
		if(RoomInfo[room_id][R_Teams][r] != new_team) 
			continue;

		players++;
	}

	if(players < RoomInfo[room_id][R_NumberPlayers] / 2) {
		RoomInfo[room_id][R_Teams][GetPVarInt(playerid, "Room_Slot_PVar")] = new_team;
		SetPVarInt(playerid, "Room_Team_PVar", new_team);

		n_for(p, Mode_GetSessionPlayers(MODE_ROOM, room_id))
			Room_UpdateTD(RoomInfo[room_id][R_Players][p], room_id);
	}
	return 1;
}

stock Room_UpdateTD(playerid, room_id)
{
	new
		team[ROOM_MAX_TEAMS] = {-1, ...};

	for(new m = 0, td = 20, num = 1; m < RoomInfo[room_id][R_NumberPlayers]; m++, num++, td += 4) {
		new 
			cell = -1;

		if(!IsCh(num)) {
			new 
				team_room = ROOM_TEAM_ALPHA;

			for(new i = team[team_room] + 1; i < Mode_GetSessionPlayers(MODE_ROOM, room_id); i++) {
				if(RoomInfo[room_id][R_Teams][i] != team_room) 
					continue;

				cell = i;
				team[team_room] = i;
				break;
			}
		}
		else {
			new
				team_room = ROOM_TEAM_BRAVO;

			for(new i = team[team_room] + 1; i < Mode_GetSessionPlayers(MODE_ROOM, room_id); i++) {
				if(RoomInfo[room_id][R_Teams][i] != team_room) 
					continue;

				cell = i;
				team[team_room] = i;
				break;
			}
		}

		if(cell > -1) {
			new
				p = RoomInfo[room_id][R_Players][cell],
				str[50];

			PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][td], 690563583);
			PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][td], true);

			PlayerTextDrawSetString(playerid, TD_Room[playerid][td + 1], NameEx(p));
			PlayerTextDrawColor(playerid, TD_Room[playerid][td + 1], -741092865);

			f(str, "Ранг: %i", GetPlayerRank(p));
			PlayerTextDrawSetString(playerid, TD_Room[playerid][td + 2], str);
			PlayerTextDrawColor(playerid, TD_Room[playerid][td + 2], -625128449);

			PlayerTextDrawColor(playerid, TD_Room[playerid][td + 3], -741092865);

			for(new i = td; i < td + 4; i++) 
				PlayerTextDrawShow(playerid, TD_Room[playerid][i]);
		}
		else {
			PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][td], 0x00000000);
			PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][td], false);
			PlayerTextDrawSetString(playerid, TD_Room[playerid][td + 1], "_");
			PlayerTextDrawSetString(playerid, TD_Room[playerid][td + 2], "_");
			PlayerTextDrawColor(playerid, TD_Room[playerid][td + 3], 0x00000000);

			for(new i = td; i < td + 4; i++) 
				PlayerTextDrawShow(playerid, TD_Room[playerid][i]);
		}
	}
	return 1;
}

stock Room_Destroy(room_id)
{
	if(RoomInfo[room_id][R_Status]) {
		if(RoomInfo[room_id][R_Status] != ROOM_STATUS_LOBBY)
			Mode_DestroyLocation(MODE_ROOM, room_id);

		new
			cell = RoomInfo[room_id][R_Cell];

		R_CountRooms--;
		R_CountRoom[cell] = R_CountRoom[R_CountRooms];
		RoomInfo[R_CountRoom[cell]][R_Cell] = cell;
		R_CountRoom[R_CountRooms] = -1;
	}
	Room_Reset(room_id);

	Mode_SetLocation(MODE_ROOM, room_id, 0);
	Mode_SetMode(MODE_ROOM, room_id, 0);
	Mode_SetMinutes(MODE_ROOM, room_id, 0);
	Mode_SetSeconds(MODE_ROOM, room_id, 0);

	n_for(i, ROOM_MAX_PLAYERS)
		Mode_SetSessionSlot(MODE_ROOM, room_id, i, -1);

	Mode_SetSessionPlayers(MODE_ROOM, room_id, 0);
	return 1;
}

stock Room_Reset(room_id)
{
	RoomInfo[room_id][R_Name][0] =
	RoomInfo[room_id][R_Password][0] = EOS;

	RoomInfo[room_id][R_Status] =
	RoomInfo[room_id][R_NumberPlayers] =
	RoomInfo[room_id][R_Mode] =
	RoomInfo[room_id][R_EndTimer] =
	RoomInfo[room_id][R_LobbyMinutes] =
	RoomInfo[room_id][R_LobbySeconds] = 0;

	RoomInfo[room_id][R_Access] = false;
	RoomInfo[room_id][R_Cell] = -1;

	n_for(i, 3)
		RoomInfo[room_id][R_Weapon][i] = 0;

	n_for(i, ROOM_MAX_PLAYERS) {
		RoomInfo[room_id][R_Players][i] = -1;
		RoomInfo[room_id][R_Teams][i] = 0;
	}
	return 1;
}

stock Room_CallPlayer(playerid, room_id)
{
	if(Mode_GetSessionPlayers(MODE_ROOM, room_id) == RoomInfo[room_id][R_NumberPlayers]) {
		SCM(playerid, -1, "{289bd4}(Комната) {FFFFFF}Данная комната переполнена.");
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}

	Mode_GiveSessionPlayers(MODE_ROOM, room_id, 1);
	SetPVarInt(playerid, "Room_World_PVar", room_id);
	Room_SetPlayerTeam(playerid, room_id);

	Interface_Close(playerid, Dialog:MM_SelectModes);

	Interface_Show(playerid, Interface:Room_Lobby);
	Dialog_Show(playerid, Dialog:Room_InfoRoom);

	n_for(p, Mode_GetSessionPlayers(MODE_ROOM, room_id))
		Room_UpdateTD(RoomInfo[room_id][R_Players][p], room_id);

	if(Mode_GetSessionPlayers(MODE_ROOM, room_id) == RoomInfo[room_id][R_NumberPlayers]) 
		RoomInfo[room_id][R_LobbySeconds] = ROOM_LOBBY_TIMER;

	return 1;
}

// Очень тупой код или гениальный
// Чтобы что-то поменять, нужно переписывать всю систему
stock Room_ExitPlayer(playerid, room_id, bool:type = false)
{
	new 
		slot_id = GetPVarInt(playerid, "Room_Slot_PVar");

	// Смотрим статус комнаты игрока (ещё определяем создал ли он её)
	switch(RoomInfo[playerid][R_Status]) {
		// Игрок не создавал никаких комнат
		case 0: {
			// Игрок в лобби
			if(RoomInfo[room_id][R_Status] == ROOM_STATUS_LOBBY) {
				Mode_GiveSessionPlayers(MODE_ROOM, room_id, -1);
				RoomInfo[room_id][R_Players][slot_id] = RoomInfo[room_id][R_Players][Mode_GetSessionPlayers(MODE_ROOM, room_id)];
				RoomInfo[room_id][R_Teams][slot_id] = RoomInfo[room_id][R_Teams][Mode_GetSessionPlayers(MODE_ROOM, room_id)];
				RoomInfo[room_id][R_Players][Mode_GetSessionPlayers(MODE_ROOM, room_id)] = -1;
				RoomInfo[room_id][R_Teams][Mode_GetSessionPlayers(MODE_ROOM, room_id)] = 0;

				SetPVarInt(playerid, "Room_World_PVar", -1);
				SetPVarInt(playerid, "Room_Slot_PVar", -1);

				n_for(p, Mode_GetSessionPlayers(MODE_ROOM, room_id)) {
					Room_UpdateTD(RoomInfo[room_id][R_Players][p], room_id);
					PlayerTextDrawSetString(RoomInfo[room_id][R_Players][p], TD_Room[RoomInfo[room_id][R_Players][p]][7], "_");
				}
				Interface_Close(playerid, Interface:Room_Lobby);

				if(!type)
					Interface_Show(playerid, Dialog:MainMenu);
			}
			// Игрок уже в процессе игры
			else {
				if(!type) {
					Mode_DestroyLocationPlayer(playerid);
					Mode_CreateLocationPlayer(playerid, MODE_NONE, 0);
				}
			}
		}
		// Дальше, если комната игрока
		case ROOM_STATUS_LOBBY: {
			n_for(p, Mode_GetSessionPlayers(MODE_ROOM, room_id)) {
				new 
					r_playerid = RoomInfo[room_id][R_Players][p];

				SetPVarInt(r_playerid, "Room_World_PVar", -1);
				SetPVarInt(r_playerid, "Room_Slot_PVar", -1);

				Interface_Close(r_playerid, Interface:Room_Lobby);

				if(r_playerid == playerid && type) 
					continue;

				if(Adm_GetPlayerSpectating(r_playerid)) 
					continue;

				Interface_Show(r_playerid, Dialog:MainMenu);
			}
			Room_Destroy(playerid);
		}
		case ROOM_STATUS_GAME, ROOM_STATUS_END: {
			m_leave_for(MODE_ROOM, room_id, p) {
				if(p == playerid && type) 
					continue;

				if(Adm_GetPlayerSpectating(p)) 
					continue;

				if(Adm_IsAdminsSpecPlayer(p)) {
					foreach(new i:spec_admin_playerid[p])
						SetPVarInt(i, "Room_Exit_PVar", 2);
				}

				Mode_DestroyLocationPlayer(p);
				Mode_CreateLocationPlayer(p, MODE_NONE, 0);
			}
			Room_Destroy(playerid);
		}
	}
	return 1;
}

stock Room_UpdateInfo()
{
	if(!R_CountRooms)
		return 1;

	n_for(r, R_CountRooms) {
		new
			room_id = R_CountRoom[r];

		switch(RoomInfo[room_id][R_Status]) {
			case ROOM_STATUS_LOBBY: {
				if(Mode_GetSessionPlayers(MODE_ROOM, room_id) == RoomInfo[room_id][R_NumberPlayers]) {
					if(RoomInfo[room_id][R_LobbySeconds]
					&& RoomInfo[room_id][R_LobbySeconds] < 61) 
						RoomInfo[room_id][R_LobbySeconds]--;
					if(!RoomInfo[room_id][R_LobbySeconds]
					&& RoomInfo[room_id][R_LobbyMinutes] > 0) {
						RoomInfo[room_id][R_LobbyMinutes]--;
						RoomInfo[r][R_LobbySeconds] = 60;
					}

					m_for(MODE_NONE, 0, p) {
						if(GetPVarInt(p, "Room_World_PVar") != room_id) 
							continue;

						new 
							str[15];
							
						f(str, "%02d:%02d", RoomInfo[room_id][R_LobbyMinutes], RoomInfo[room_id][R_LobbySeconds]);
						PlayerTextDrawSetString(p, TD_Room[p][7], str);
					}

					if(!RoomInfo[room_id][R_LobbySeconds] 
					&& !RoomInfo[room_id][R_LobbyMinutes]) {
						n_for2(h, RoomInfo[room_id][R_NumberPlayers]) {
							Mode_SetSessionSlot(MODE_ROOM, room_id, h, RoomInfo[room_id][R_Players][h]);

							RoomInfo[room_id][R_Players][h] = -1;
							RoomInfo[room_id][R_Teams][h] = 0;
						}

						Mode_CreateLocation(MODE_ROOM, room_id, 0);
						RoomInfo[room_id][R_Status] = ROOM_STATUS_GAME;

						m_leave_for(MODE_NONE, 0, p) {
							if(GetPVarInt(p, "Room_World_PVar") != room_id) 
								continue;

							Interface_Close(p, Interface:Room_Lobby);
							Mode_CreateLocationPlayer(p, MODE_ROOM, room_id);
						}
					}
				}
			}
			case ROOM_STATUS_GAME: {
				switch(Room_GetMode(room_id)) {
					case ROOM_MODE_CAPTURE: Room_PointReInfo(room_id);
					case ROOM_MODE_SECRET_DATA: Room_ComputerReInfo(room_id);
				}

				Room_UpdateTeamChet(room_id);

				if(Mode_GetSeconds(MODE_ROOM, room_id) 
				&& Mode_GetSeconds(MODE_ROOM, room_id) < 61) 
					Mode_SetSeconds(MODE_ROOM, room_id, Mode_GetSeconds(MODE_ROOM, room_id) - 1);

				if(!Mode_GetSeconds(MODE_ROOM, room_id)
				&& Mode_GetMinutes(MODE_ROOM, room_id)) {
					Mode_SetMinutes(MODE_ROOM, room_id, Mode_GetMinutes(MODE_ROOM, room_id) - 1);
					Mode_SetSeconds(MODE_ROOM, room_id, 60);
				}

				if(!Mode_GetSeconds(MODE_ROOM, room_id) 
				&& !Mode_GetMinutes(MODE_ROOM, room_id)) 
					Room_LocationEndGame(room_id);

				new 
					str[15];

				f(str, "%02d:%02d", Mode_GetMinutes(MODE_ROOM, room_id), Mode_GetSeconds(MODE_ROOM, room_id));

				m_for(MODE_ROOM, room_id, p) {
					UpdatePlayerTDTeamChet(p);
					Mode_UpdatePlTDTimerSession(p, str);
				}
			}
			case ROOM_STATUS_END: {
				if(RoomInfo[room_id][R_EndTimer] > 0) {
					RoomInfo[room_id][R_EndTimer]--;

					if(RoomInfo[room_id][R_EndTimer] < 1) {
						RoomInfo[room_id][R_EndTimer] = 0;

						m_leave_for(MODE_ROOM, room_id, p) {
							if(Adm_GetPlayerSpectating(p)) 
								continue;

							Mode_DestroyLocationPlayer(p);
							Mode_CreateLocationPlayer(p, MODE_NONE, 0);
						}
						Room_Destroy(room_id);
					}
				}
			}
		}
	}
	return 1;
}

publics Room_UpdatePlayer(playerid)
{
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));
	UpdatePlayerKillStrike(playerid);
	UpdatePlayerNewRank(playerid);
	UpdatePlayerReward(playerid);
	UpdatePlayerSpawnKill(playerid);
	UpdatePlayerFPSandPING(playerid);

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

		UpdatePlayerBelowHealth(playerid);
	}
	else {
		if(GetPlayerDead(playerid) == PLAYER_DEATH_KILLER) 
			UpdateBarTimeRespawn(playerid);

		if(GetPlayerSpeedRespawn(playerid) < gettime()) 
			Room_OnPlayerSpawn(playerid);
	}

	Room_UpdatePlayerComputer(playerid);

	SetPlayerSecondTime(playerid);
	UpdatePlayerTime(playerid);
	return 1;
}

stock Room_CreateLocationPlayer(playerid, room_id, bool:set)
{
	if(!Adm_GetPlayerSpectating(playerid)) {
		DestroyPlayerTDInMainMenu(playerid, true);
		SetPlayerClickTD(playerid, false);

		if(set)
			Mode_LeavingPlayer(playerid);

		Mode_KillPlayerTimer(playerid, MODE_NONE);
	}
	else {
		Mode_DestroyLocationPlayer(playerid, set);

		if(set)
			Mode_EnteringPlayer(playerid, MODE_ROOM, room_id);
	}
	
	if(set)
		Mode_SetPlayer(playerid, MODE_ROOM);

	SetPlayerBusy(playerid, GAME);
	SetPlayerDamage(playerid, true);

	if(!Adm_GetPlayerSpectating(playerid)) {
		if(set) {
			Mode_SetPlayerSession(playerid, GetPVarInt(playerid, "Room_World_PVar"));
			Mode_SetPlayerSlot(playerid, GetPVarInt(playerid, "Room_Slot_PVar"));
		}

		SetPlayerTeamEx(playerid, GetPVarInt(playerid, "Room_Team_PVar"));
		SetPlayerSkinEx(playerid, Inv_GetPlayerSkin(playerid));

		SetPVarInt(playerid, "Room_World_PVar", -1);
		SetPVarInt(playerid, "Room_Slot_PVar", -1);
		DeletePVar(playerid, "Room_Team_PVar");
	}

	SettingsPlayerSpawn(playerid);

	Room_ShowPlElementsLocation(playerid);

	if(!Adm_GetPlayerSpectating(playerid)) {
		ShowPlayerTDBarHealth(playerid);
		ShowPlayerTDBarArmour(playerid);
		ShowTDPlayerFPSandPING(playerid);
		ShowTDPlayerStatsRound(playerid);
		ShowTDDeath(playerid);
		ShowTDDeadKiller(playerid);

		CancelSelectTextDraw(playerid);
		SetCameraBehindPlayer(playerid);
		TogglePlayerControllable(playerid, true);

		CreatePlayerBaseIndicators(playerid);
		CreatePlayerFPSandPING(playerid);
		CreatePlayerStatsRound(playerid);

		PlayerSpawn(playerid);
	}

	Mode_SetPlayerTimer(playerid, MODE_ROOM);
	return 1;
}

stock Room_DestroyLocationPlayer(playerid, reset)
{
	new
		room_id = Mode_GetPlayerSession(playerid);

	switch(GetPVarInt(playerid, "Room_Exit_PVar")) {
		case 0: {
			if(Adm_GetPlayerSpectating(playerid))
				Room_ExitPlayer(playerid, room_id, true);
		}
		case 1: Room_ExitPlayer(playerid, room_id, true);
	}

	SetPlayerKillStrike(playerid, 0);
	HidePlayerKillStrike(playerid);
	DestroyPlayerSpawnKill(playerid);
	Damage_DeletePlayerIndicator(playerid);
	DestroyPlayerBaseIndicators(playerid, false);
	DestroyPlayerFPSandPING(playerid, false);
	DestroyPlayerStatsRound(playerid, false);
	DestroyPlayerDeadKiller(playerid, 3, false);
	DestroyPlayerBelowHealth(playerid);
	DestroyPlayerReward(playerid);
	Room_HidePlayerResultRound(playerid);
	ResetPlayerWeaponsEx(playerid);
	DestroyPlayerAttachedObjects(playerid);

	Room_DestroyPlayerPoint(playerid);
	Room_DestroyPlayerComputer(playerid);

	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerTeamEx(playerid, ROOM_TEAM_NONE);
	SetPlayerColorEx(playerid, 0xCCCCCC00);

	Mode_SetPlayerKill(playerid, 0);
	Mode_SetPlayerDeath(playerid, 0);

	Room_HidePlElementsLocation(playerid);

	if(reset)
	{
		if(RoomInfo[room_id][R_Status]) 
			Mode_LeavingPlayer(playerid);
		else {
			Mode_SetPlayer(playerid, -1);
			Mode_SetPlayerSession(playerid, 0);
			Mode_SetPlayerSlot(playerid, 0);
		}
	}
	Mode_KillPlayerTimer(playerid, MODE_ROOM);
	return 1;
}

stock Room_UpdateTime()
{
	Room_UpdateInfo();
	return 1;
}

stock Room_GetMode(room_id)
{
	return RoomInfo[room_id][R_Mode];
}

static ShowResultRound(room_id)
{
	new 
		max_number,
		bool:win_team[ROOM_MAX_TEAMS],
		bool:draw_team[ROOM_MAX_TEAMS],
		reward_exp[3],
		reward_money[3];

	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_BATTLE: {
			foreach(new c:Room_ActiveTeams[room_id]) {
				if(Room_GetTeamModeChet(room_id, c) > max_number) {
					win_team[c] = true;
					max_number = Room_GetTeamModeChet(room_id, c);

					foreach(new t:Room_ActiveTeams[room_id]) {
						if(t == c) 
							continue;

						if(Room_GetTeamModeChet(room_id, t) < Room_GetTeamModeChet(room_id, c)) {
							win_team[t] =
							draw_team[t] = false;
						}
						else if(Room_GetTeamModeChet(room_id, t) == Room_GetTeamModeChet(room_id, c))
							draw_team[c] = true;
					}
				}
				else if(Room_GetTeamModeChet(room_id, c) == max_number) {
					win_team[c] =
					draw_team[c] = true;
				}
			}

			reward_exp[0] = 1000; 	// Победа
			reward_exp[1] = 500; 	// Поражение
			reward_exp[2] = 600; 	// Ничья

			reward_money[0] = 800; 	// Победа
			reward_money[1] = 300; 	// Поражение
			reward_money[2] = 400; 	// Ничья
		}
		case ROOM_MODE_CAPTURE: {
			foreach(new c:Room_ActiveTeams[room_id]) {
				if(Room_GetTeamModeChet(room_id, c) > max_number) {
					win_team[c] = true;
					max_number = Room_GetTeamModeChet(room_id, c);

					foreach(new t:Room_ActiveTeams[room_id]) {
						if(t == c) 
							continue;

						if(Room_GetTeamModeChet(room_id, t) < Room_GetTeamModeChet(room_id, c)) {
							win_team[t] =
							draw_team[t] = false;
						}
						else if(Room_GetTeamModeChet(room_id, t) == Room_GetTeamModeChet(room_id, c))
							draw_team[c] = true;
					}
				}
				else if(Room_GetTeamModeChet(room_id, c) == max_number) {
					win_team[c] =
					draw_team[c] = true;
				}
			}
			reward_exp[0] = 1000; 	// Победа
			reward_exp[1] = 500; 	// Поражение
			reward_exp[2] = 600; 	// Ничья

			reward_money[0] = 800; 	// Победа
			reward_money[1] = 300; 	// Поражение
			reward_money[2] = 400; 	// Ничья
		}
		case ROOM_MODE_SECRET_DATA: {
			new
				protect_team = Room_GetComputerProtectTeam(room_id);

			if(Room_GetTeamModeChet(room_id, protect_team))
				win_team[protect_team] = true;
			else {
				foreach(new c:Room_ActiveTeams[room_id]) {
					if(c == protect_team)
						continue;

					win_team[c] = true;
				}
			}
			reward_exp[0] = 1000; 	// Победа
			reward_exp[1] = 500; 	// Поражение
			reward_exp[2] = 600; 	// Ничья

			reward_money[0] = 800; 	// Победа
			reward_money[1] = 300; 	// Поражение
			reward_money[2] = 400; 	// Ничья
		}
	}
	m_for(MODE_ROOM, room_id, p) {
		if(Adm_GetPlayerSpectating(p))
			continue;
	
		if(draw_team[GetPlayerTeamEx(p)]) {
			SetPlayerFee(p, reward_exp[2], reward_money[2], REPLEN_ROUND, false);
			PlayerPlaySoundEx(p, 36203, 0.0, 0.0, 0.0);

			SCM(p, -1, "{e3af2b}Ничья!");
		}
		else if(win_team[GetPlayerTeamEx(p)]) {
			SetPlayerFee(p, reward_exp[0], reward_money[0], REPLEN_ROUND, false);
			SetPlayerWinRound(p, 1);
			PlayerPlaySoundEx(p, 36203, 0.0, 0.0, 0.0);

			SCM(p, -1, "{1ad94d}Победа!");
		}
		else {
			SetPlayerFee(p, reward_exp[1], reward_money[1], REPLEN_ROUND, false);
			SetPlayerLossRound(p, 1);
			PlayerPlaySoundEx(p, 36200, 0.0, 0.0, 0.0);

			SCM(p, -1, "{e32b2b}Поражение!");
		}
	}
	return 1;
}

static UpdatePlayerTDTeamChet(playerid)
{
	new
		room_id = Mode_GetPlayerSession(playerid),
		b = 1,
		t = 0,
		team_chet = 0;

	foreach(new i:Room_ActiveTeamsChet[room_id]) {
		new 
			str[15];

		switch(Room_GetMode(room_id)) {
			case ROOM_MODE_BATTLE: {
				f(str, "%i", Room_GetTeamModeChet(room_id, i));
			}
			case ROOM_MODE_CAPTURE: {
				f(str, "%i/%i", Room_GetTeamModeChet(room_id, i), Room_GetTeamModeMaxChet(room_id, i));
			}
			case ROOM_MODE_SECRET_DATA: {
				f(str, "%i/%i", Room_GetTeamModeChet(room_id, i), Room_GetTeamModeMaxChet(room_id, i));
			}
		}
		PlayerTextDrawSetString(playerid, TD_ChetLocation[playerid][b], str);
		SetPlayerProgressBarValue(playerid, PlayerChetLocation[playerid][t], floatround(team_chet));

		b += 2;
		t++;
	}
	return 1;
}

static SettingsPlayerSpawn(playerid)
{
	new 
		room_id = Mode_GetPlayerSession(playerid),
		skin_id = Mode_GetPlayerSkin(playerid, MODE_ROOM),
		team_id = GetPlayerTeamEx(playerid);

	Mode_SetPlayerVirtualWorld(playerid, MODE_ROOM, room_id);
	Mode_SetPlayerInterior(playerid, MODE_ROOM, room_id);

	new
		Float:X, Float:Y, Float:Z,
		random_pos = random(3);

	Room_GetSpawnBasePos(room_id, team_id, random_pos, X, Y, Z);
	SetSpawnInfoEx(playerid, skin_id, X, Y, Z + 0.3, 0.0);
	return 1;
}

static SetPlayerAmmunition(playerid) 
{
	new
		room_id = Mode_GetPlayerSession(playerid);

	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerArmourEx(playerid, 30.0);

	n_for(w, 3) {
		if(!RoomInfo[room_id][R_Weapon][w]) 
			continue;

		GivePlayerWeaponEx(playerid, RoomInfo[room_id][R_Weapon][w], 100000);
	}

	SetPlayerSkinEx(playerid, GetPlayerSkinEx(playerid));
	SetPlayerColorEx(playerid, Room_ShowTeamColorXB(GetPlayerTeamEx(playerid)));
	Inv_SetPlayerAttachItem(playerid);
	return 1;
}

static CheckList(playerid, listitem)
{
	if(listitem == 20) 
		FirstRoom[playerid] += 20;
	else 
		FirstRoom[playerid] -= 20;

	if(FirstRoom[playerid] < 0) {
		n_for(i, 22)
			ListIDRoom[playerid][i] = 0;

		FirstRoom[playerid] = 0;
		SetPVarInt(playerid, "Room_World_PVar", -1);
		Dialog_Show(playerid, Dialog:Room_ListRooms);
		return 1;
	}

	Dialog_Show(playerid, Dialog:Room_ListRooms);
	return 1;
}

static Room_CreateTDTeamChet(playerid, td_id = -1, td_one_id = -1, team_id, maxchet)
{
	new
		str[50];

	f(str, "%s", Room_GetTeamName(team_id));
	if(td_one_id != -1) {
		switch(td_one_id) {
			case 0: {
				PlayerChetLocation[playerid][0] = CreatePlayerProgressBar(playerid, 284.00, 43.00, 84.50, 5.19, Room_ShowTeamColorXB(team_id), maxchet, BAR_DIRECTION_RIGHT);

				// Название команды
				TD_ChetLocation[playerid][0] = CreatePlayerTextDraw(playerid, 324.000000, 29.000000, str);
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][0], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][0], 2);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][0], Room_ShowTeamColorXB(team_id));
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][0], 1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][0], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][0], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][0], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][0], 1);

				// Счёт
				TD_ChetLocation[playerid][1] = CreatePlayerTextDraw(playerid, 323.000000, 40.000000, "_");
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][1], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][1], 2);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][1], -1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][1], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][1], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][1], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][1], 1);
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][1], 0);

				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][0]), PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][1]);
			}
		}
	}

	if(td_id != -1) {
		switch(td_id) {
			case 0: {
				PlayerChetLocation[playerid][0] = CreatePlayerProgressBar(playerid, 317.00, 43.00, 84.50, 5.19, Room_ShowTeamColorXB(team_id), maxchet, BAR_DIRECTION_LEFT);

				// Название команды
				TD_ChetLocation[playerid][0] = CreatePlayerTextDraw(playerid, 316.000000, 29.000000, str);
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][0], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][0], 3);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][0], Room_ShowTeamColorXB(team_id));
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][0], 1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][0], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][0], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][0], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][0], 1);

				// Счёт
				TD_ChetLocation[playerid][1] = CreatePlayerTextDraw(playerid, 316.000000, 40.000000, "_");
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][1], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][1], 3);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][1], -1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][1], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][1], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][1], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][1], 1);
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][1], 0);

				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][0]);
				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][1]);
			}
			case 1: {
				PlayerChetLocation[playerid][1] = CreatePlayerProgressBar(playerid, 327.00, 43.00, 84.50, 5.19, Room_ShowTeamColorXB(team_id), maxchet, BAR_DIRECTION_RIGHT);

				// Название команды
				TD_ChetLocation[playerid][2] = CreatePlayerTextDraw(playerid, 326.000000, 29.000000, str);
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][2], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][2], 1);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][2], Room_ShowTeamColorXB(team_id));
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][2], 1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][2], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][2], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][2], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][2], 1);

				// Счёт
				TD_ChetLocation[playerid][3] = CreatePlayerTextDraw(playerid, 327.000000, 40.000000, "_");
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][3], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][3], 1);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][3], -1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][3], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][3], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][3], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][3], 1);
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][3], 0);

				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][2]);
				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][3]);
			}
		}
	}
	return 1;
}

static Room_ShowTD(playerid, room_id)
{
	// Основной задний фон
	TD_Room[playerid][0] = CreatePlayerTextDraw(playerid, 195.0000, 150.0000, "Box");
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][0], 0.0000, 21.5000);
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][0], 441.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, TD_Room[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, TD_Room[playerid][0], 1162167807);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_Room[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][0], 0);

	// Фон названия комнаты
	TD_Room[playerid][1] = CreatePlayerTextDraw(playerid, 195.0000, 131.0000, "Box");
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][1], 0.0000, 1.5333);
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][1], 441.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, TD_Room[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, TD_Room[playerid][1], 606348543);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_Room[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][1], 0);

	// Фон названия команд
	TD_Room[playerid][2] = CreatePlayerTextDraw(playerid, 195.0000, 150.0000, "Box");
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][2], 0.0000, 1.9000);
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][2], 441.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, TD_Room[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, TD_Room[playerid][2], 808464639);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_Room[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][2], 0);

	// Делящая полоска
	TD_Room[playerid][3] = CreatePlayerTextDraw(playerid, 321.0000, 170.0000, "Box");
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][3], 0.0000, 19.3000);
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][3], 315.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, TD_Room[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, TD_Room[playerid][3], 808464639);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_Room[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][3], 0);

	new
		str[20 + ROOM_MAX_NAME_LENGTH];

	f(str, "Комната \"%s\"", RoomInfo[room_id][R_Name]);
	// Название комнаты
	TD_Room[playerid][4] = CreatePlayerTextDraw(playerid, 320.0000, 130.0000, str);
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][4], 0.2723, 1.4548);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][4], 2);
	PlayerTextDrawColor(playerid, TD_Room[playerid][4], -505290753);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][4], 255);
	PlayerTextDrawFont(playerid, TD_Room[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][4], 0);

	TD_Room[playerid][5] = CreatePlayerTextDraw(playerid, 255.0000, 150.0000, Room_GetTeamName(ROOM_TEAM_ALPHA));
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][5], 0.2866, 1.6207);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][5], 2);
	PlayerTextDrawColor(playerid, TD_Room[playerid][5], 1079894015);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][5], 255);
	PlayerTextDrawFont(playerid, TD_Room[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][5], 0);

	TD_Room[playerid][6] = CreatePlayerTextDraw(playerid, 380.0000, 150.0000, Room_GetTeamName(ROOM_TEAM_BRAVO));
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][6], 0.2866, 1.6207);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][6], 2);
	PlayerTextDrawColor(playerid, TD_Room[playerid][6], -547660801);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][6], 255);
	PlayerTextDrawFont(playerid, TD_Room[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][6], 0);

	// Время
	TD_Room[playerid][7] = CreatePlayerTextDraw(playerid, 318.0000, 151.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][7], 0.3253, 1.6041);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][7], 2);
	PlayerTextDrawColor(playerid, TD_Room[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][7], 255);
	PlayerTextDrawFont(playerid, TD_Room[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][7], 0);

	// Белый фон выхода
	TD_Room[playerid][8] = CreatePlayerTextDraw(playerid, 194.0000, 347.0000, "");
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][8], 45.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][8], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][8], -1717986817);
	PlayerTextDrawFont(playerid, TD_Room[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][8], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Room[playerid][8], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Room[playerid][8], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Чёрный фон выхода
	TD_Room[playerid][9] = CreatePlayerTextDraw(playerid, 195.0000, 348.0000, "");
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][9], 43.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][9], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][9], 303174399);
	PlayerTextDrawFont(playerid, TD_Room[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][9], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Room[playerid][9], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Room[playerid][9], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_Room[playerid][10] = CreatePlayerTextDraw(playerid, 217.0000, 349.0000, "Выйти");
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][10], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][10], 15.0000, 42.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][10], 2);
	PlayerTextDrawColor(playerid, TD_Room[playerid][10], -76911105);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][10], -1);
	PlayerTextDrawFont(playerid, TD_Room[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][10], true);

	// Белый фон инфо
	TD_Room[playerid][11] = CreatePlayerTextDraw(playerid, 242.0000, 347.0000, "");
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][11], 45.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][11], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][11], -1717986817);
	PlayerTextDrawFont(playerid, TD_Room[playerid][11], 5);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][11], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Room[playerid][11], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Room[playerid][11], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Чёрный фон ифно
	TD_Room[playerid][12] = CreatePlayerTextDraw(playerid, 243.0000, 348.0000, "");
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][12], 43.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][12], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][12], 303174399);
	PlayerTextDrawFont(playerid, TD_Room[playerid][12], 5);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][12], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Room[playerid][12], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Room[playerid][12], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_Room[playerid][13] = CreatePlayerTextDraw(playerid, 265.0000, 349.0000, "Инфо");
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][13], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][13], 15.0000, 42.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][13], 2);
	PlayerTextDrawColor(playerid, TD_Room[playerid][13], -741977345);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][13], -1);
	PlayerTextDrawFont(playerid, TD_Room[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][13], true);

	// Белый фон параметров
	TD_Room[playerid][14] = CreatePlayerTextDraw(playerid, 290.0000, 347.0000, "");
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][14], 77.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][14], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][14], -1717986817);
	PlayerTextDrawFont(playerid, TD_Room[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][14], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Room[playerid][14], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Room[playerid][14], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Чёрный фон параметров
	TD_Room[playerid][15] = CreatePlayerTextDraw(playerid, 291.0000, 348.0000, "");
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][15], 75.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][15], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][15], 303174399);
	PlayerTextDrawFont(playerid, TD_Room[playerid][15], 5);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][15], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Room[playerid][15], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Room[playerid][15], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_Room[playerid][16] = CreatePlayerTextDraw(playerid, 328.0000, 349.0000, "Параметры");
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][16], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][16], 15.0000, 76.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][16], 2);
	PlayerTextDrawColor(playerid, TD_Room[playerid][16], 1422643711);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][16], -1);
	PlayerTextDrawFont(playerid, TD_Room[playerid][16], 2);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][16], true);

	// Белый фон команды
	TD_Room[playerid][17] = CreatePlayerTextDraw(playerid, 370.0000, 347.0000, "");
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][17], 72.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][17], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][17], -1717986817);
	PlayerTextDrawFont(playerid, TD_Room[playerid][17], 5);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][17], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_Room[playerid][17], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Room[playerid][17], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Чёрный фон команды
	TD_Room[playerid][18] = CreatePlayerTextDraw(playerid, 371.0000, 348.0000, "");
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][18], 70.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][18], 1);
	PlayerTextDrawColor(playerid, TD_Room[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][18], 303174399);
	PlayerTextDrawFont(playerid, TD_Room[playerid][18], 5);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][18], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][18], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_Room[playerid][18], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_Room[playerid][18], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_Room[playerid][19] = CreatePlayerTextDraw(playerid, 406.0000, 349.0000, "Команда");
	PlayerTextDrawLetterSize(playerid, TD_Room[playerid][19], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, TD_Room[playerid][19], 15.0000, 70.0000);
	PlayerTextDrawAlignment(playerid, TD_Room[playerid][19], 2);
	PlayerTextDrawColor(playerid, TD_Room[playerid][19], 2127647487);
	PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][19], -1);
	PlayerTextDrawFont(playerid, TD_Room[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, TD_Room[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, TD_Room[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][19], true);

	Room_ShowPlayersTD(playerid);
	return 1;
}

static Room_ShowPlayersTD(playerid)
{
	new
		Float:initialcoords[2] = {195.0, 170.0};

	for(new i = 20, s = 1, num = 1; i < sizeof(TD_Room[]); i++, s++, num++) {
		TD_Room[playerid][i] = CreatePlayerTextDraw(playerid, initialcoords[0], initialcoords[1], "");
		PlayerTextDrawTextSize(playerid, TD_Room[playerid][i], 120.0000, 33.0000);
		PlayerTextDrawAlignment(playerid, TD_Room[playerid][i], 1);
		PlayerTextDrawColor(playerid, TD_Room[playerid][i], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][i], 0x00000000);
		PlayerTextDrawFont(playerid, TD_Room[playerid][i], 5);
		PlayerTextDrawSetProportional(playerid, TD_Room[playerid][i], 0);
		PlayerTextDrawSetShadow(playerid, TD_Room[playerid][i], 0);
		PlayerTextDrawSetPreviewModel(playerid, TD_Room[playerid][i], 0);
		PlayerTextDrawSetPreviewRot(playerid, TD_Room[playerid][i], 0.0000, 0.0000, 0.0000, 1000.0000);
		PlayerTextDrawSetSelectable(playerid, TD_Room[playerid][i], true);
		i++;

		// Ник
		TD_Room[playerid][i] = CreatePlayerTextDraw(playerid, initialcoords[0] + 2.0, initialcoords[1], "_");
		PlayerTextDrawLetterSize(playerid, TD_Room[playerid][i], 0.1760, 1.4008);
		PlayerTextDrawAlignment(playerid, TD_Room[playerid][i], 1);
		PlayerTextDrawColor(playerid, TD_Room[playerid][i], 0x00000000);
		PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][i], 255);
		PlayerTextDrawFont(playerid, TD_Room[playerid][i], 2);
		PlayerTextDrawSetProportional(playerid, TD_Room[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TD_Room[playerid][i], 0);
		i++;

		// Ранг
		TD_Room[playerid][i] = CreatePlayerTextDraw(playerid, initialcoords[0] + 2.0, initialcoords[1] + 12.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_Room[playerid][i], 0.1896, 1.3469);
		PlayerTextDrawAlignment(playerid, TD_Room[playerid][i], 1);
		PlayerTextDrawColor(playerid, TD_Room[playerid][i], 0x00000000);
		PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][i], 255);
		PlayerTextDrawFont(playerid, TD_Room[playerid][i], 2);
		PlayerTextDrawSetProportional(playerid, TD_Room[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TD_Room[playerid][i], 0);
		i++;

		new
			str[3];

		f(str, "%i", num);

		// Номер
		TD_Room[playerid][i] = CreatePlayerTextDraw(playerid, initialcoords[0] + 118.0, initialcoords[1] - 1.0, str);
		PlayerTextDrawLetterSize(playerid, TD_Room[playerid][i], 0.2396, 1.2142);
		PlayerTextDrawAlignment(playerid, TD_Room[playerid][i], 3);
		PlayerTextDrawColor(playerid, TD_Room[playerid][i], 0x00000000);
		PlayerTextDrawBackgroundColor(playerid, TD_Room[playerid][i], 255);
		PlayerTextDrawFont(playerid, TD_Room[playerid][i], 2);
		PlayerTextDrawSetProportional(playerid, TD_Room[playerid][i], 1);
		PlayerTextDrawSetShadow(playerid, TD_Room[playerid][i], 0);

		if(s == 2) {
			s = 0;
			initialcoords[0] = 195.0;
			initialcoords[1] += 35.0;
		}
		else 
			initialcoords[0] += 126.0;
	}
	return 1;
}

static Room_CreateTDResultChet(playerid, team_id, bool:td_id, num, teams)
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
		Float:pos_td[2],
		tdid = 0;

	if(!td_id) {
		n_for(i, 2)
			pos_td[i] = pos_td_id[num][i];
	}
	else { 
		n_for(i, 2)
			pos_td[i] = pos_td_one_id[num][i];
	}

	// Задний фон
	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0], pos_td[1], "");
	PlayerTextDrawTextSize(playerid, TD_ResultRound[playerid][num][tdid], 196.0000, 141.0000);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], 0x303030FF);
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 5);
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_ResultRound[playerid][num][tdid], 0.0000, 0.0000, 0.0000, 10000.0000);
	tdid++;

	// Первая полоса сверху
	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0], pos_td[1] + 16.0, "");
	PlayerTextDrawTextSize(playerid, TD_ResultRound[playerid][num][tdid], 196.0000, 2.0000);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], Room_ShowTeamColorXB(team_id));
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 5);
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_ResultRound[playerid][num][tdid], 0.0000, 0.0000, 0.0000, 1000.0000);
	tdid++;

	// Второвая полоса сверху
	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0], pos_td[1] + 27.0, "");
	PlayerTextDrawTextSize(playerid, TD_ResultRound[playerid][num][tdid], 196.0000, 2.0000);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], Room_ShowTeamColorXB(team_id));
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 5); 
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_ResultRound[playerid][num][tdid], 0.0000, 0.0000, 0.0000, 1000.0000);
	tdid++;

	// Ники и убийства
	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0] + 100.0, pos_td[1] + 17.0, "");
	PlayerTextDrawTextSize(playerid, TD_ResultRound[playerid][num][tdid], 2.0000, 123.0000);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], Room_ShowTeamColorXB(team_id));
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 5);
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_ResultRound[playerid][num][tdid], 0.0000, 0.0000, 0.0000, 1000.0000);
	tdid++;

	// Убийства и смерти
	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0] + 146.0, pos_td[1] + 17.0, "");
	PlayerTextDrawTextSize(playerid, TD_ResultRound[playerid][num][tdid], 2.0000, 123.0000);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], Room_ShowTeamColorXB(team_id));
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 5);
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_ResultRound[playerid][num][tdid], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_ResultRound[playerid][num][tdid], 0.0000, 0.0000, 0.0000, 1000.0000);
	tdid++;

	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0] + 49.0, pos_td[1] + 16.0, "Профессионалы");
	PlayerTextDrawLetterSize(playerid, TD_ResultRound[playerid][num][tdid], 0.2196, 1.2100);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], -909522945);
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], 255);
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	tdid++;

	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0] + 124.0, pos_td[1] + 16.0, "Убийств");
	PlayerTextDrawLetterSize(playerid, TD_ResultRound[playerid][num][tdid], 0.2196, 1.2100);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], -909522945);
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], 255);
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	tdid++;

	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0] + 171.0, pos_td[1] + 16.0, "Смертей");
	PlayerTextDrawLetterSize(playerid, TD_ResultRound[playerid][num][tdid], 0.2196, 1.2100);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], -909522945);
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], 255);
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	tdid++;

	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0] + 98.0, pos_td[1] + 1.0, Room_GetTeamName(team_id)); // Название команды
	PlayerTextDrawLetterSize(playerid, TD_ResultRound[playerid][num][tdid], 0.2369, 1.4133);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], Room_ShowTeamColorXF(team_id));
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], 255);
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	tdid++;

	n_for(i, sizeof(TD_ResultRound[][]))
		PlayerTextDrawShow(playerid, TD_ResultRound[playerid][num][i]);

	// Статистика
	new
		str[150];

	if(teams == (num + 1)) {
		new
			Float:pos_td_stats[2];

		if(!IsCh(teams)) {
			pos_td_stats[0] = pos_td[0];
			pos_td_stats[1] = pos_td[1];
		}
		else {
			pos_td_stats[0] = pos_td_id[num - 1][0];
			pos_td_stats[1] = pos_td_id[num - 1][1];
		}

		// Задний фон статистики
		TD_EndRoundStats[playerid][0] = CreatePlayerTextDraw(playerid, pos_td_stats[0], pos_td_stats[1] + 144.0, "");
		PlayerTextDrawTextSize(playerid, TD_EndRoundStats[playerid][0], 214.0000, 31.0000);
		PlayerTextDrawAlignment(playerid, TD_EndRoundStats[playerid][0], 1);
		PlayerTextDrawColor(playerid, TD_EndRoundStats[playerid][0], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_EndRoundStats[playerid][0], 0x303030FF);
		PlayerTextDrawFont(playerid, TD_EndRoundStats[playerid][0], 5);
		PlayerTextDrawSetProportional(playerid, TD_EndRoundStats[playerid][0], 0);
		PlayerTextDrawSetShadow(playerid, TD_EndRoundStats[playerid][0], 0);
		PlayerTextDrawSetPreviewModel(playerid, TD_EndRoundStats[playerid][0], 0);
		PlayerTextDrawSetPreviewRot(playerid, TD_EndRoundStats[playerid][0], 0.0000, 0.0000, 0.0000, 10000.0000);

		// Ранг
		TD_EndRoundStats[playerid][1] = CreatePlayerTextDraw(playerid, pos_td_stats[0] + 3.0, pos_td_stats[1] + 143.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_EndRoundStats[playerid][1], 0.1846, 1.2183);
		PlayerTextDrawAlignment(playerid, TD_EndRoundStats[playerid][1], 1);
		PlayerTextDrawColor(playerid, TD_EndRoundStats[playerid][1], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_EndRoundStats[playerid][1], 255);
		PlayerTextDrawFont(playerid, TD_EndRoundStats[playerid][1], 2);
		PlayerTextDrawSetProportional(playerid, TD_EndRoundStats[playerid][1], 1);
		PlayerTextDrawSetShadow(playerid, TD_EndRoundStats[playerid][1], 0);

		// Убийств
		TD_EndRoundStats[playerid][2] = CreatePlayerTextDraw(playerid, pos_td_stats[0] + 3.0, pos_td_stats[1] + 153.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_EndRoundStats[playerid][2], 0.1846, 1.2183);
		PlayerTextDrawAlignment(playerid, TD_EndRoundStats[playerid][2], 1);
		PlayerTextDrawColor(playerid, TD_EndRoundStats[playerid][2], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_EndRoundStats[playerid][2], 255);
		PlayerTextDrawFont(playerid, TD_EndRoundStats[playerid][2], 2);
		PlayerTextDrawSetProportional(playerid, TD_EndRoundStats[playerid][2], 1);
		PlayerTextDrawSetShadow(playerid, TD_EndRoundStats[playerid][2], 0);

		// Смертей
		TD_EndRoundStats[playerid][3] = CreatePlayerTextDraw(playerid, pos_td_stats[0] + 3.0, pos_td_stats[1] + 163.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_EndRoundStats[playerid][3], 0.1846, 1.2183);
		PlayerTextDrawAlignment(playerid, TD_EndRoundStats[playerid][3], 1);
		PlayerTextDrawColor(playerid, TD_EndRoundStats[playerid][3], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_EndRoundStats[playerid][3], 255);
		PlayerTextDrawFont(playerid, TD_EndRoundStats[playerid][3], 2);
		PlayerTextDrawSetProportional(playerid, TD_EndRoundStats[playerid][3], 1);
		PlayerTextDrawSetShadow(playerid, TD_EndRoundStats[playerid][3], 0);

		// Полоска
		TD_EndRoundStats[playerid][4] = CreatePlayerTextDraw(playerid, pos_td_stats[0] + 66.0, pos_td_stats[1] + 144.0, "");
		PlayerTextDrawTextSize(playerid, TD_EndRoundStats[playerid][4], -2.0000, 31.0000);
		PlayerTextDrawAlignment(playerid, TD_EndRoundStats[playerid][4], 1);
		PlayerTextDrawColor(playerid, TD_EndRoundStats[playerid][4], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_EndRoundStats[playerid][4], 2021161215);
		PlayerTextDrawFont(playerid, TD_EndRoundStats[playerid][4], 5);
		PlayerTextDrawSetProportional(playerid, TD_EndRoundStats[playerid][4], 0);
		PlayerTextDrawSetShadow(playerid, TD_EndRoundStats[playerid][4], 0);
		PlayerTextDrawSetPreviewModel(playerid, TD_EndRoundStats[playerid][4], 0);
		PlayerTextDrawSetPreviewRot(playerid, TD_EndRoundStats[playerid][4], 0.0000, 0.0000, 0.0000, 10000.0000);

		// Всего опыта
		TD_EndRoundStats[playerid][5] = CreatePlayerTextDraw(playerid, pos_td_stats[0] + 69.0, pos_td_stats[1] + 143.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_EndRoundStats[playerid][5], 0.1846, 1.2183);
		PlayerTextDrawAlignment(playerid, TD_EndRoundStats[playerid][5], 1);
		PlayerTextDrawColor(playerid, TD_EndRoundStats[playerid][5], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_EndRoundStats[playerid][5], 255);
		PlayerTextDrawFont(playerid, TD_EndRoundStats[playerid][5], 2);
		PlayerTextDrawSetProportional(playerid, TD_EndRoundStats[playerid][5], 1);
		PlayerTextDrawSetShadow(playerid, TD_EndRoundStats[playerid][5], 0);

		// Всего кредитов
		TD_EndRoundStats[playerid][6] = CreatePlayerTextDraw(playerid, pos_td_stats[0] + 69.0, pos_td_stats[1] + 153.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_EndRoundStats[playerid][6], 0.1846, 1.2183);
		PlayerTextDrawAlignment(playerid, TD_EndRoundStats[playerid][6], 1);
		PlayerTextDrawColor(playerid, TD_EndRoundStats[playerid][6], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_EndRoundStats[playerid][6], 255);
		PlayerTextDrawFont(playerid, TD_EndRoundStats[playerid][6], 2);
		PlayerTextDrawSetProportional(playerid, TD_EndRoundStats[playerid][6], 1);
		PlayerTextDrawSetShadow(playerid, TD_EndRoundStats[playerid][6], 0);

		f(str, "Ранг:_~y~%i", GetPlayerRank(playerid));
		PlayerTextDrawSetString(playerid, TD_EndRoundStats[playerid][1], str);
		str[0] = EOS;

		f(str, "Убийств:_~b~%i", Mode_GetPlayerKills(playerid));
		PlayerTextDrawSetString(playerid, TD_EndRoundStats[playerid][2], str);
		str[0] = EOS;

		f(str, "Смертей:_~r~%i", Mode_GetPlayerDeaths(playerid));
		PlayerTextDrawSetString(playerid, TD_EndRoundStats[playerid][3], str);
		str[0] = EOS;

		f(str, "Получено всего опыта:_~y~+%i", Mode_GetPlayerExp(playerid));
		PlayerTextDrawSetString(playerid, TD_EndRoundStats[playerid][5], str);
		str[0] = EOS;

		f(str, "Получено всего кредитов:_~g~+%i$", Mode_GetPlayerMoney(playerid));
		PlayerTextDrawSetString(playerid, TD_EndRoundStats[playerid][6], str);
		str[0] = EOS;

		n_for(i, sizeof(TD_EndRoundStats[]))
			PlayerTextDrawShow(playerid, TD_EndRoundStats[playerid][i]);
	}

	// Топ
	tdid = 0;
	pos_td[0] += 1.0;
	pos_td[1] += 30.0;

	n_for(i, 5) {
		TD_TopKillers[playerid][num][tdid][0] = CreatePlayerTextDraw(playerid, pos_td[0], pos_td[1], "_");
		PlayerTextDrawLetterSize(playerid, TD_TopKillers[playerid][num][tdid][0], 0.1356, 1.2888);
		PlayerTextDrawAlignment(playerid, TD_TopKillers[playerid][num][tdid][0], 1);
		PlayerTextDrawColor(playerid, TD_TopKillers[playerid][num][tdid][0], -909522945);
		PlayerTextDrawBackgroundColor(playerid, TD_TopKillers[playerid][num][tdid][0], 255);
		PlayerTextDrawFont(playerid, TD_TopKillers[playerid][num][tdid][0], 2);
		PlayerTextDrawSetProportional(playerid, TD_TopKillers[playerid][num][tdid][0], 1);
		PlayerTextDrawSetShadow(playerid, TD_TopKillers[playerid][num][tdid][0], 0);

		TD_TopKillers[playerid][num][tdid][1] = CreatePlayerTextDraw(playerid, pos_td[0] + 122.0, pos_td[1], "_");
		PlayerTextDrawLetterSize(playerid, TD_TopKillers[playerid][num][tdid][1], 0.2375, 1.2929);
		PlayerTextDrawAlignment(playerid, TD_TopKillers[playerid][num][tdid][1], 2);
		PlayerTextDrawColor(playerid, TD_TopKillers[playerid][num][tdid][1], -909522945);
		PlayerTextDrawBackgroundColor(playerid, TD_TopKillers[playerid][num][tdid][1], 255);
		PlayerTextDrawFont(playerid, TD_TopKillers[playerid][num][tdid][1], 2);
		PlayerTextDrawSetProportional(playerid, TD_TopKillers[playerid][num][tdid][1], 1);
		PlayerTextDrawSetShadow(playerid, TD_TopKillers[playerid][num][tdid][1], 0);

		TD_TopKillers[playerid][num][tdid][2] = CreatePlayerTextDraw(playerid, pos_td[0] + 170.0, pos_td[1], "_");
		PlayerTextDrawLetterSize(playerid, TD_TopKillers[playerid][num][tdid][2], 0.2375, 1.2929);
		PlayerTextDrawAlignment(playerid, TD_TopKillers[playerid][num][tdid][2], 2);
		PlayerTextDrawColor(playerid, TD_TopKillers[playerid][num][tdid][2], -909522945);
		PlayerTextDrawBackgroundColor(playerid, TD_TopKillers[playerid][num][tdid][2], 255);
		PlayerTextDrawFont(playerid, TD_TopKillers[playerid][num][tdid][2], 2);
		PlayerTextDrawSetProportional(playerid, TD_TopKillers[playerid][num][tdid][2], 1);
		PlayerTextDrawSetShadow(playerid, TD_TopKillers[playerid][num][tdid][2], 0);

		pos_td[1] += 11.0;

		new
			room_id = Mode_GetPlayerSession(playerid);

		if(players_Data[room_id][team_id][i][1] > -1) {
			f(str, "%i._%s", i + 1, players_Name[room_id][team_id][players_Data[room_id][team_id][i][1]]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][0], str);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][0]);
			str[0] = EOS;

			f(str, "%i", players_Data[room_id][team_id][i][0]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][1], str);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][1]);
			str[0] = EOS;

			f(str, "%i", players_Data[room_id][team_id][i][2]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][2], str);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][2]);
			str[0] = EOS;
		}
		tdid++;
	}
	return 1;
}

static HidePlayerElementsEndRound(playerid)
{
	SpecPl(playerid, true);

	SetPlayerDamage(playerid, false);
	DestroyPlayerBaseIndicators(playerid, false);
	DestroyPlayerFPSandPING(playerid, false);
	DestroyPlayerStatsRound(playerid, false);
	DestroyPlayerBelowHealth(playerid);
	DestroyPlayerSpawnKill(playerid);
	ClearKillFeed(playerid);

	Room_DestroyPlayerPoint(playerid);
	Room_DestroyPlayerComputer(playerid);

	SetPlayerKillStrike(playerid, 0);
	HidePlayerKillStrike(playerid);

	Room_ShowPlayerResultRound(playerid);
	Room_ShowCameraEndLocation(playerid);

	Mode_SetPlayerKill(playerid, 0);
	Mode_SetPlayerDeath(playerid, 0);

	SetPlayerHealthEx(playerid, 100.0);
	return 1;
}

/*

	* Reset *

*/

static ResetTopPlayers(room_id)
{
	n_for(t, ROOM_MAX_TEAMS) {
		n_for2(b, 5) {
			players_Data[room_id][t][b][0] =
			players_Data[room_id][t][b][1] =
			players_Data[room_id][t][b][2] = -1;
			players_Name[room_id][t][b][0] = EOS;
		}
		tempVar[room_id][t] = 0;
	}
	return 1;
}

static ResetPlayerData(playerid)
{
	n_for(i, 22)
		ListIDRoom[playerid][i] = 0;

	FirstRoom[playerid] = 0;
	SetPVarInt(playerid, "Room_World_PVar", -1);
	SetPVarInt(playerid, "Room_Slot_PVar", -1);
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(i, sizeof(TD_ChetLocation[]))
		TD_ChetLocation[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(t, ROOM_MAX_TEAMS) {
		n_for2(i, sizeof(TD_ResultRound[][])) {
			TD_ResultRound[playerid][t][i] = PlayerText:INVALID_TEXT_DRAW;
		}
	}

	n_for(i, sizeof(TD_EndRoundStats[]))
		TD_EndRoundStats[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(t, ROOM_MAX_TEAMS) {
		n_for2(i, sizeof(TD_TopKillers[][])) {
			n_for3(b, sizeof(TD_TopKillers[][][])) {
				TD_TopKillers[playerid][t][i][b] = PlayerText:INVALID_TEXT_DRAW;
			}
		}
	}

	n_for(i, sizeof(TD_Room[]))
		TD_Room[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

/*

	* Interfaces *

*/

InterfaceCreate:Room_Lobby(playerid)
{
	new
		room_id = GetPVarInt(playerid, "Room_World_PVar");

	Room_ShowTD(playerid, room_id);

	n_for(i, sizeof(TD_Room[]))
		PlayerTextDrawShow(playerid, TD_Room[playerid][i]);

	n_for(p, Mode_GetSessionPlayers(MODE_ROOM, room_id))
		Room_UpdateTD(RoomInfo[room_id][R_Players][p], room_id);

	return 1;
}

InterfaceClose:Room_Lobby(playerid)
{
	n_for(i, sizeof(TD_Room[]))
		DestroyPlayerTD(playerid, TD_Room[playerid][i]);

	return 1;
}

InterfacePlayerClick:Room_Lobby(playerid, PlayerText:playertextid)
{
	new
		room_id = GetPVarInt(playerid, "Room_World_PVar");

	if(playertextid == TD_Room[playerid][10]) 
		Room_ExitPlayer(playerid, room_id);

	else if(playertextid == TD_Room[playerid][13]) 
		Dialog_Show(playerid, Dialog:Room_InfoRoom);

	else if(playertextid == TD_Room[playerid][16]) {
		if(strcmp(NameEx(room_id), NameEx(playerid), true)) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Доступ к параметрам имеется только у создателя комнаты!");
		}
		else
			Dialog_Show(playerid, Dialog:Room_Settings);
	}
	else if(playertextid == TD_Room[playerid][19]) 
		Room_ChangePlayerTeam(playerid, room_id);

	if(!Dialog_IsOpen(playerid)) {
		if(RoomInfo[playerid][R_Status]) {
			new 
				team[ROOM_MAX_TEAMS] = {-1, ...};

			for(new m = 0, num = 1, td = 20; m < RoomInfo[playerid][R_NumberPlayers]; m++, num++, td += 4) {
				new 
					cell = -1;

				if(!IsCh(num)) {
					new 
						team_room = ROOM_TEAM_ALPHA;

					for(new i = team[team_room] + 1; i < Mode_GetSessionPlayers(MODE_ROOM, playerid); i++) {
						if(RoomInfo[playerid][R_Teams][i] != team_room) 
							continue;

						cell = i;
						team[team_room] = i;
						break;
					}
				}
				else {
					new 
						team_room = ROOM_TEAM_BRAVO;

					for(new i = team[team_room] + 1; i < Mode_GetSessionPlayers(MODE_ROOM, playerid); i++) {
						if(RoomInfo[playerid][R_Teams][i] != team_room) 
							continue;

						cell = i;
						team[team_room] = i;
						break;
					}
				}
				if(playertextid == TD_Room[playerid][td]) {
					if(cell > -1) {
						SetPVarInt(playerid, "PlayerIDRoom_PVar", cell);
						Dialog_Show(playerid, Dialog:Room_ExcludePlayer);
					}
				}
			}
		}
	}
	return 1;
}

/*

	* Dialogs *

*/

DialogCreate:Room_InfoRoom(playerid)
{
	static
		str[600];

	str[0] = EOS;

	new
		room_id = GetPVarInt(playerid, "Room_World_PVar"),
		weapon1[50],
		weapon2[50],
		weapon3[50];

	if(!RoomInfo[room_id][R_Weapon][0])
		weapon1 = "Ничего";
	else
		GetWeaponNameRU(RoomInfo[room_id][R_Weapon][0], weapon1, sizeof(weapon1));

	if(!RoomInfo[room_id][R_Weapon][1])
		weapon2 = "Ничего";
	else
		GetWeaponNameRU(RoomInfo[room_id][R_Weapon][1], weapon2, sizeof(weapon2));

	if(!RoomInfo[room_id][R_Weapon][2])
		weapon3 = "Ничего";
	else
		GetWeaponNameRU(RoomInfo[room_id][R_Weapon][2], weapon3, sizeof(weapon3));

	f(str, "\
	{CCCCCC}Комната: {FFFFFF}[{f0b111}%s{FFFFFF}] \
	\n{CCCCCC}Создатель: {FFFFFF}[{e3b030}%s{FFFFFF}] \
	\n{CCCCCC}Локация: {FFFFFF}[{3059e3}%s{FFFFFF}] \
	\n{CCCCCC}Режим: {FFFFFF}[{30d7e3}%s{FFFFFF}] \
	\n{CCCCCC}Время: [{7de330}%i минут{FFFFFF}] \
	\n{CCCCCC}Участников: {FFFFFF}[{f0b111}%ivs%i{FFFFFF}] \
	\n{CCCCCC}Оружие: \
	\n{CCCCCC}1 слот: {FFFFFF}[{e37a30}%s{FFFFFF}] \
	\n{CCCCCC}2 слот: {FFFFFF}[{e37a30}%s{FFFFFF}] \
	\n{CCCCCC}3 слот: {FFFFFF}[{e37a30}%s{FFFFFF}]",
	RoomInfo[room_id][R_Name], NameEx(room_id), Room_GetNameLocation(Mode_GetLocation(MODE_ROOM, room_id)), Room_GetModeName(Room_GetMode(room_id)), Mode_GetMinutes(MODE_ROOM, room_id), RoomInfo[room_id][R_NumberPlayers] / 2, RoomInfo[room_id][R_NumberPlayers] / 2, weapon1, weapon2, weapon3);
	Dialog_Message(playerid, "{e39b30}Информация о комнате", str, "Понятно");
	return 1;
}

DialogCreate:Room_SelectingTab(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SelectingTab, DSL, "{e39b30}Комната", ""C_N"• {FFFFFF}Список комнат\n"C_N"• {FFFFFF}Подключиться по названию\n"C_N"• {FFFFFF}Создать комнату", "Выбрать", "Выйти");
	return 1;
}

DialogResponse:Room_SelectingTab(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:Room_ListRooms);
			case 1: Dialog_Show(playerid, Dialog:Room_ConnectRoom);
			case 2: Dialog_Show(playerid, Dialog:Room_InputName);
		}
	}
	else
		Interface_Show(playerid, Interface:MM_SelectModes);

	return 1;
}

DialogCreate:Room_ListRooms(playerid)
{
	static
		string[1000];

	string[0] = EOS;

	new
		start = FirstRoom[playerid],
		str[80];

	str = "Название\tУчастников\tДоступ\n";
	strcat(string, str);

	new 
		index = 0;

	if(start > 0) {
		for(new i = 0, c = 0; i < R_CountRooms && c < start; i++) {
			new 
				r = R_CountRoom[i];
			
			if(RoomInfo[r][R_Status] != ROOM_STATUS_LOBBY) 
				continue;

			c++;
			index = i;
		}
	}

	new
		rooms;

	for(new rr = index, l; rr < R_CountRooms; rr++) {
		new 
			r = R_CountRoom[rr];

		if(RoomInfo[r][R_Status] != ROOM_STATUS_LOBBY) 
			continue;
		
		if(l > 20) 
			break;

		new 
			access[50];

		if(!RoomInfo[r][R_Access]) 
			access = "{16d94a}Открытый";
		else 
			access = "{d91616}Закрытый";

		f(string, "%s%s\t%i/%i\t%s\n", string, RoomInfo[r][R_Name], Mode_GetSessionPlayers(MODE_ROOM, r), RoomInfo[r][R_NumberPlayers], access);

		ListIDRoom[playerid][l] = r;
		l++;
		rooms++;
	}

	if(!rooms) {
		SCM(playerid, -1, "{289bd4}(Комната) {FFFFFF}Список комнат пуст.");
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		return 1;
	}

	if(rooms == 20)
		f(string, "%s{CCCCCC}Далее >>>\n", string);

	Dialog_Open(playerid, Dialog:Room_ListRooms, DSTH, "{e39b30}Список комнат", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_ListRooms(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(listitem == 20
		|| listitem == 21)
			CheckList(playerid, listitem);
		else {
			if(GetString(inputtext, "<<< Назад")) 
				return CheckList(playerid, 21);

			new 
				room_id = ListIDRoom[playerid][listitem];

			if(RoomInfo[room_id][R_Status] != ROOM_STATUS_LOBBY) {
				n_for(i, 22)
					ListIDRoom[playerid][i] = 0;
				
				SetPVarInt(playerid, "Room_World_PVar", -1);
				FirstRoom[playerid] = 0;

				SCM(playerid, -1, "{289bd4}(Комната) {FFFFFF}Данная комната уже не активна.");
				Dialog_Show(playerid, Dialog:Room_SelectingTab);
				return 1;
			}
			n_for(i, 22)
				ListIDRoom[playerid][i] = 0;
			
			FirstRoom[playerid] = 0;

			if(RoomInfo[room_id][R_Access]) {
				SetPVarInt(playerid, "PlayerIDRoom2_PVar", room_id);
				Dialog_Show(playerid, Dialog:Room_InputPassword);
				return 1;
			}
			Room_CallPlayer(playerid, room_id);
		}
	}
	else {
		n_for(i, 22)
			ListIDRoom[playerid][i] = 0;
		
		FirstRoom[playerid] = 0;

		SetPVarInt(playerid, "Room_World_PVar", -1);
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
	}
	return 1;
}

DialogCreate:Room_InputPassword(playerid)
{
	Dialog_Open(playerid, Dialog:Room_InputPassword, DSI, "{e39b30}Ввод пароля", "{FFFFFF}Для подключения, введите пароль от комнаты.", "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_InputPassword(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Room_InputPassword);

		new
			room_id = GetPVarInt(playerid, "PlayerIDRoom2_PVar");
		
		if(RoomInfo[room_id][R_Status] != ROOM_STATUS_LOBBY) {
			n_for(i, 22)
				ListIDRoom[playerid][i] = 0;
			
			SetPVarInt(playerid, "Room_World_PVar", -1);
			FirstRoom[playerid] = 0;

			SCM(playerid, -1, "{289bd4}(Комната) {FFFFFF}Данная комната уже не активна.");
			Dialog_Show(playerid, Dialog:Room_SelectingTab);
			return 1;
		}
		if(strcmp(inputtext, RoomInfo[room_id][R_Password], true)) {
			Dialog_Show(playerid, Dialog:Room_InputPassword);

			SCM(playerid, -1, "{CC0033}Ошибка: неверный пароль");
			return 1;
		}

		n_for(i, 22)
			ListIDRoom[playerid][i] = 0;
		
		FirstRoom[playerid] = 0;

		Room_CallPlayer(playerid, room_id);
	}
	else {
		n_for(i, 22)
			ListIDRoom[playerid][i] = 0;
		
		FirstRoom[playerid] = 0;

		DeletePVar(playerid, "PlayerIDRoom2_PVar");
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
	}
	return 1;
}

DialogCreate:Room_SetPassword(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetPassword, DSI, "{e39b30}Создание пароля", "\
	{FFFFFF}Для закрытого доступа в комнату придумайте пароль. \
	\n\n{CC0033}Примечание: \
	\n{CCCCCC}1. Пароль должен содержать от 3 до 10 символов. \
	\n2. Пароль должен содержать только латинские символы и цифры.", "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_SetPassword(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Room_SetPassword);

		for(new i = strlen(inputtext)-1; i != -1; i--) {
			switch(inputtext[i]) {
				case '0'..'9', 'a'..'z', 'A'..'Z': continue;
				default: {
					Dialog_Show(playerid, Dialog:Room_SetPassword);

					SCM(playerid, -1, "{CC0033}Ошибка: пароль должен содержать латинские символы и цифры!");
					return 1;
				}
			}
		}
		if(strlen(inputtext) < 3) {
			Dialog_Show(playerid, Dialog:Room_SetPassword);

			SCM(playerid, -1, "{CC0033}Ошибка: пароль слишком короткий!");
			return 1;
		}
		else if(strlen(inputtext) > 10) {
			Dialog_Show(playerid, Dialog:Room_SetPassword);

			SCM(playerid, -1, "{CC0033}Ошибка: пароль слишком длинный!");
			return 1;
		}
		RoomInfo[playerid][R_Access] = true;
		RoomInfo[playerid][R_Password][0] = EOS;
		strins(RoomInfo[playerid][R_Password], inputtext, 0);

		Dialog_Show(playerid, Dialog:Room_Create);
	}
	else 
		Dialog_Show(playerid, Dialog:Room_Create);

	return 1;
}

DialogCreate:Room_ChooseAccess(playerid)
{
	Dialog_Open(playerid, Dialog:Room_ChooseAccess, DSL, "{e39b30}Доступ", ""C_N"• {16d94a}Открытый\n"C_N"• {d91616}Закрытый", "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_ChooseAccess(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				RoomInfo[playerid][R_Access] = false;
				RoomInfo[playerid][R_Password][0] = EOS;

				Dialog_Show(playerid, Dialog:Room_Create);
			}
			case 1: Dialog_Show(playerid, Dialog:Room_SetPassword);
		}
	}
	else 
		Dialog_Show(playerid, Dialog:Room_Create);

	return 1;
}

DialogCreate:Room_SetWeaponMain(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetWeaponMain, DSL, "{e39b30}Оружие в 1 слоте", "\
	"C_N"• {FFFFFF}Ничего \
	\n"C_N"• {FFFFFF}M4 \
	\n"C_N"• {FFFFFF}AK-47 \
	\n"C_N"• {FFFFFF}Реактивный гранатомет \
	\n"C_N"• {FFFFFF}Гранатомет с тепловым наведением \
	\n"C_N"• {FFFFFF}Огнемёт \
	\n"C_N"• {FFFFFF}Миниган \
	\n"C_N"• {FFFFFF}Винтовка \
	\n"C_N"• {FFFFFF}Снайперская винтовка",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetWeaponMain(playerid, response, listitem, inputtext[])
{
	if(response) {
		new
			weapon;

		switch(listitem) {
			case 0: weapon = 0;
			case 1: weapon = 31;
			case 2: weapon = 30;
			case 3: weapon = 35;
			case 4: weapon = 36;
			case 5: weapon = 37;
			case 6: weapon = 38;
			case 7: weapon = 33;
			case 8: weapon = 34;
		}
		RoomInfo[playerid][R_Weapon][0] = weapon;
	}
	Dialog_Show(playerid, Dialog:Room_SetWeapon);
	return 1;
}

DialogCreate:Room_SetWeaponSecondary(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetWeaponSecondary, DSL, "{e39b30}Оружие в 2 слоте", "\
	"C_N"• {FFFFFF}Ничего \
	\n"C_N"• {FFFFFF}Дробовик \
	\n"C_N"• {FFFFFF}Боевой дробовик \
	\n"C_N"• {FFFFFF}Обрез \
	\n"C_N"• {FFFFFF}Узи \
	\n"C_N"• {FFFFFF}МП5 \
	\n"C_N"• {FFFFFF}Тек-9 \
	\n"C_N"• {FFFFFF}Пустынный орел \
	\n"C_N"• {FFFFFF}Пистолет \
	\n"C_N"• {FFFFFF}Пистолет с глушителем",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetWeaponSecondary(playerid, response, listitem, inputtext[])
{
	if(response) {
		new 
			weapon;

		switch(listitem) {
			case 0: weapon = 0;
			case 1: weapon = 25;
			case 2: weapon = 27;
			case 3: weapon = 26;
			case 4: weapon = 28;
			case 5: weapon = 29;
			case 6: weapon = 32;
			case 7: weapon = 24;
			case 8: weapon = 22;
			case 9: weapon = 23;
		}
		RoomInfo[playerid][R_Weapon][1] = weapon;
	}
	Dialog_Show(playerid, Dialog:Room_SetWeapon);
	return 1;
}

DialogCreate:Room_SetWeaponThird(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetWeaponThird, DSL, "{e39b30}Оружие в 3 слоте", "\
	"C_N"• {FFFFFF}Ничего \
	\n"C_N"• {FFFFFF}Граната \
	\n"C_N"• {FFFFFF}Слезоточивый газ \
	\n"C_N"• {FFFFFF}Коктейль Молотова \
	\n"C_N"• {FFFFFF}Клюшка для гольфа \
	\n"C_N"• {FFFFFF}Нож \
	\n"C_N"• {FFFFFF}Катана \
	\n"C_N"• {FFFFFF}Бейсбольная бита \
	\n"C_N"• {FFFFFF}Лопата \
	\n"C_N"• {FFFFFF}Кий \
	\n"C_N"• {FFFFFF}Кастет \
	\n"C_N"• {FFFFFF}Полицейская дубинка \
	\n"C_N"• {FFFFFF}Бензопила",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetWeaponThird(playerid, response, listitem, inputtext[])
{
	if(response) {
		new 
			weapon;

		switch(listitem) {
			case 0: weapon = 0;
			case 1: weapon = 16;
			case 2: weapon = 17;
			case 3: weapon = 18;
			case 4: weapon = 2;
			case 5: weapon = 4;
			case 6: weapon = 8;
			case 7: weapon = 5;
			case 8: weapon = 6;
			case 9: weapon = 7;
			case 10: weapon = 1;
			case 11: weapon = 3;
			case 12: weapon = 9;
		}
		RoomInfo[playerid][R_Weapon][2] = weapon;
	}
	Dialog_Show(playerid, Dialog:Room_SetWeapon);
	return 1;
}

DialogCreate:Room_SetWeapon(playerid)
{
	static 
		str[300];

	str[0] = EOS;

	new
		slot1[50],
		slot2[50],
		slot3[50];

	if(!RoomInfo[playerid][R_Weapon][0])
		slot1 = "{d91616}Ничего";
	else
		GetWeaponNameRU(RoomInfo[playerid][R_Weapon][0], slot1, sizeof(slot1));

	if(!RoomInfo[playerid][R_Weapon][1])
		slot2 = "{d91616}Ничего";
	else
		GetWeaponNameRU(RoomInfo[playerid][R_Weapon][1], slot2, sizeof(slot2));

	if(!RoomInfo[playerid][R_Weapon][2])
		slot3 = "{d91616}Ничего";
	else
		GetWeaponNameRU(RoomInfo[playerid][R_Weapon][2], slot3, sizeof(slot3));

	f(str, "Слот\tОружие \
	\n"C_N"• {FFFFFF}Основной\t[ %s{FFFFFF} ] \
	\n"C_N"• {FFFFFF}Вторичный\t[ %s{FFFFFF} ] \
	\n"C_N"• {FFFFFF}Третий\t[ %s{FFFFFF} ]",
	slot1, slot2, slot3);
	Dialog_Open(playerid, Dialog:Room_SetWeapon, DSTH, "{e39b30}Выбор оружия", str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetWeapon(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:Room_SetWeaponMain);
			case 1: Dialog_Show(playerid, Dialog:Room_SetWeaponSecondary);
			case 2: Dialog_Show(playerid, Dialog:Room_SetWeaponThird);
		}
	}
	else {
		if(RoomInfo[playerid][R_Status] == ROOM_STATUS_LOBBY)
			Dialog_Show(playerid, Dialog:Room_Settings);
		else 
			Dialog_Show(playerid, Dialog:Room_Create);
	}

	return 1;
}

DialogCreate:Room_Settings(playerid)
{
	static
		str[500];

	str[0] = EOS;

	new
		weapon[50],
		access[50],
		wproverka;

	n_for(w, 3) {
		if(RoomInfo[playerid][R_Weapon][w]) {
			wproverka++;
			break;
		}
	}

	if(wproverka) 
		weapon = "{16d94a}Есть";
	else 
		weapon = "{d91616}Нет";

	if(!RoomInfo[playerid][R_Access]) 
		access = "{16d94a}Открытый";
	else 
		access = "{d91616}Закрытый";

	f(str, "Данные\tЗначения \
	\n"C_N"• {FFFFFF}Локация\t[{3059e3}%s{FFFFFF}] \
	\n"C_N"• {FFFFFF}Режим\t[{30d7e3}%s{FFFFFF}] \
	\n"C_N"• {FFFFFF}Время\t[{7de330}%i минут{FFFFFF}] \
	\n"C_N"• {FFFFFF}Участников\t[{f0b111}%ivs%i{FFFFFF}] \
	\n"C_N"• {FFFFFF}Оружие\t[%s{FFFFFF}]",
	Room_GetNameLocation(Mode_GetLocation(MODE_ROOM, playerid)), Room_GetModeName(Room_GetMode(playerid)), Mode_GetMinutes(MODE_ROOM, playerid), RoomInfo[playerid][R_NumberPlayers] / 2, RoomInfo[playerid][R_NumberPlayers] / 2, weapon);
	Dialog_Open(playerid, Dialog:Room_Settings, DSTH, "{e39b30}Параметры", str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_Settings(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	switch(listitem) {
		case 0: Dialog_Show(playerid, Dialog:Room_ListLocations);
		case 1: Dialog_Show(playerid, Dialog:Room_SelectMode);
		case 2: Dialog_Show(playerid, Dialog:Room_SetTimer);
		case 3: Dialog_Show(playerid, Dialog:Room_SetCountPlayers);
		case 4: Dialog_Show(playerid, Dialog:Room_SetWeapon);
	}
	return 1;
}

DialogCreate:Room_SelectMode(playerid)
{
	static
		string[1000];

	string[0] = EOS;

	n_for(i, ROOM_MAX_MODES) {
		new 
			str[150];

		f(str, ""C_N"%i. {FFFFFF}%s\n", i + 1, Room_GetModeName(i));
		strcat(string, str);
	}

	Dialog_Open(playerid, Dialog:Room_SelectMode, DSL, "{e39b30}Список режимов комнаты", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SelectMode(playerid, response, listitem, inputtext[])
{
	if(response) {
		Mode_SetMode(MODE_ROOM, playerid, listitem);
		RoomInfo[playerid][R_Mode] = listitem;
	}

	if(RoomInfo[playerid][R_Status] == ROOM_STATUS_LOBBY)
		Dialog_Show(playerid, Dialog:Room_Settings);
	else 
		Dialog_Show(playerid, Dialog:Room_Create);

	return 1;
}

DialogCreate:Room_SetCountPlayers(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetCountPlayers, DSL, "{e39b30}Количество участников", ""C_N"• {FFFFFF}1vs1\n"C_N"• {FFFFFF}2vs2\n"C_N"• {FFFFFF}3vs3\n"C_N"• {FFFFFF}4vs4\n"C_N"• {FFFFFF}5vs5", "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_SetCountPlayers(playerid, response, listitem, inputtext[])
{
	if(response) {
		new 
			players;

		switch(listitem) {
			case 0: players = 2;
			case 1: players = 4;
			case 2: players = 6;
			case 3: players = 8;
			case 4: players = 10;
		}
		if(RoomInfo[playerid][R_Status] == ROOM_STATUS_LOBBY) {
			if(Mode_GetSessionPlayers(MODE_ROOM, playerid) > players)
				SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}В комнате находится больше людей!");
			else
				RoomInfo[playerid][R_NumberPlayers] = players;
		}
		else
			RoomInfo[playerid][R_NumberPlayers] = players;
	}
	
	if(RoomInfo[playerid][R_Status] == ROOM_STATUS_LOBBY)
		Dialog_Show(playerid, Dialog:Room_Settings);
	else
		Dialog_Show(playerid, Dialog:Room_Create);

	return 1;
}

DialogCreate:Room_SetTimer(playerid)
{
	Dialog_Open(playerid, Dialog:Room_SetTimer, DSI, "{e39b30}Установить время игры", "{FFFFFF}Введите число для установления количества минут игры:\n\n- Доступно от 10 до 60 минут", "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_SetTimer(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext))
			return Dialog_Show(playerid, Dialog:Room_SetTimer);

		for(new i = strlen(inputtext)-1; i != -1; i--) {
			switch(inputtext[i]) {
				case '0'..'9': continue;
				default: return Dialog_Show(playerid, Dialog:Room_SetTimer);
			}
		}
		if(strval(inputtext) < 10 || strval(inputtext) > 60)
			return Dialog_Show(playerid, Dialog:Room_SetTimer);

		Mode_SetMinutes(MODE_ROOM, playerid, strval(inputtext));
	}

	if(RoomInfo[playerid][R_Status] == ROOM_STATUS_LOBBY)
		Dialog_Show(playerid, Dialog:Room_Settings);
	else
		Dialog_Show(playerid, Dialog:Room_Create);

	return 1;
}

DialogCreate:Room_Create(playerid)
{
	static 
		str[500];

	str[0] = EOS;

	new
		weapon[50],
		access[50],
		wproverka;

	n_for(w, 3) {
		if(RoomInfo[playerid][R_Weapon][w]) {
			wproverka++;
			break;
		}
	}

	if(wproverka)
		weapon = "{16d94a}Есть";
	else
		weapon = "{d91616}Нет";

	if(!RoomInfo[playerid][R_Access])
		access = "{16d94a}Открытый";
	else
		access = "{d91616}Закрытый";

	f(str, "Данные\tЗначения \
	\n"C_N"• {FFFFFF}Название\t[{f0b111}%s{FFFFFF}] \
	\n"C_N"• {FFFFFF}Локация\t[{3059e3}%s{FFFFFF}] \
	\n"C_N"• {FFFFFF}Режим\t[{30d7e3}%s{FFFFFF}] \
	\n"C_N"• {FFFFFF}Время\t[{7de330}%i минут{FFFFFF}] \
	\n"C_N"• {FFFFFF}Участников\t[{f0b111}%ivs%i{FFFFFF}] \
	\n"C_N"• {FFFFFF}Оружие\t[%s{FFFFFF}] \
	\n"C_N"• {FFFFFF}Доступ\t[%s{FFFFFF}] \
	\n\t \
	\n"C_N"• {FFFFFF}Создать комнату",
	RoomInfo[playerid][R_Name], Room_GetNameLocation(Mode_GetLocation(MODE_ROOM, playerid)), Room_GetModeName(Room_GetMode(playerid)), Mode_GetMinutes(MODE_ROOM, playerid), RoomInfo[playerid][R_NumberPlayers] / 2, RoomInfo[playerid][R_NumberPlayers] / 2, weapon, access);
	Dialog_Open(playerid, Dialog:Room_Create, DSTH, "{e39b30}Создание комнаты", str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_Create(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:Room_ChangeInputName);
			case 1: Dialog_Show(playerid, Dialog:Room_ListLocations);
			case 2: Dialog_Show(playerid, Dialog:Room_SelectMode);
			case 3: Dialog_Show(playerid, Dialog:Room_SetTimer);
			case 4: Dialog_Show(playerid, Dialog:Room_SetCountPlayers);
			case 5: Dialog_Show(playerid, Dialog:Room_SetWeapon);
			case 6: Dialog_Show(playerid, Dialog:Room_ChooseAccess);
			case 7: Dialog_Show(playerid, Dialog:Room_Create);
			case 8: {
				SetPVarInt(playerid, "Room_World_PVar", playerid);
				SetPVarInt(playerid, "Room_Slot_PVar", 0);
				SetPVarInt(playerid, "Room_Team_PVar", ROOM_TEAM_ALPHA);

				RoomInfo[playerid][R_Status] = ROOM_STATUS_LOBBY;
				RoomInfo[playerid][R_Players][0] = playerid;
				RoomInfo[playerid][R_Teams][0] = ROOM_TEAM_ALPHA;
				Mode_GiveSessionPlayers(MODE_ROOM, playerid, 1);

				R_CountRooms++;

				n_for(i, MAX_PLAYERS) {
					if(R_CountRoom[i] > -1) 
						continue;

					R_CountRoom[i] = playerid;
					RoomInfo[playerid][R_Cell] = i;
					break;
				}
				Interface_Show(playerid, Interface:Room_Lobby);

				Dina_CheckPlayerHint(playerid, 17);
			}
		}
	}
	else {
		Room_Destroy(playerid);
		Dialog_Show(playerid, Dialog:Room_SelectingTab);
	}
	return 1;
}

DialogCreate:Room_ChangeInputName(playerid)
{
	new
		string[500];

	f(string, "{FFFFFF}Введите новое название комнаты. \
	\n\n{CC0033}Примечание: \
	\n{CCCCCC}1. Название должно содержать от 3 до 10 символов. \
	\n2. Название должно содержать только латинские символы и цифры.");
	Dialog_Open(playerid, Dialog:Room_ChangeInputName, DSI, "{e39b30}Изменение названия", string, "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_ChangeInputName(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Room_ChangeInputName);

		n_for(r, MAX_PLAYERS) {
			if(RoomInfo[r][R_Status]) {
				if(!strcmp(inputtext, RoomInfo[r][R_Name], true)) {
					Dialog_Show(playerid, Dialog:Room_ChangeInputName);
					SCM(playerid, -1, "{CC0033}Ошибка: данное название уже занято!");
					return 1;
				}
			}
		}
		for(new i = strlen(inputtext)-1; i != -1; i--) {
			switch(inputtext[i]) {
				case '0'..'9', 'a'..'z', 'A'..'Z': continue;
				default: {
					Dialog_Show(playerid, Dialog:Room_ChangeInputName);

					SCM(playerid, -1, "{CC0033}Ошибка: название должно содержать латинские символы и цифры!");
					return 1;
				}
			}
		}
		if(strlen(inputtext) < 3) {
			Dialog_Show(playerid, Dialog:Room_ChangeInputName);

			SCM(playerid, -1, "{CC0033}Ошибка: название слишком короткое!");
			return 1;
		}
		else if(strlen(inputtext) > 10) {
			Dialog_Show(playerid, Dialog:Room_ChangeInputName);

			SCM(playerid, -1, "{CC0033}Ошибка: название слишком длинное!");
			return 1;
		}
		RoomInfo[playerid][R_Name][0] = EOS;
		strins(RoomInfo[playerid][R_Name], inputtext, 0);

		Dialog_Show(playerid, Dialog:Room_Create);
	}
	else 
		Dialog_Show(playerid, Dialog:Room_Create);

	return 1;
}

DialogCreate:Room_InputName(playerid)
{
	new
		string[500];

	f(string, "{FFFFFF}Введите название будущей комнаты. \
	\n\n{CC0033}Примечание: \
	\n{CCCCCC}1. Название должно содержать от 3 до 10 символов. \
	\n2. Название должно содержать только латинские символы и цифры.");
	Dialog_Open(playerid, Dialog:Room_InputName, DSI, "{e39b30}Создание комнаты", string, "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_InputName(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Room_InputName);

		n_for(r, MAX_PLAYERS) {
			if(RoomInfo[r][R_Status]) {
				if(!strcmp(inputtext, RoomInfo[r][R_Name], true)) {
					Dialog_Show(playerid, Dialog:Room_InputName);

					SCM(playerid, -1, "{CC0033}Ошибка: данное название уже занято!");
					return 1;
				}
			}
		}
		for(new i = strlen(inputtext)-1; i != -1; i--) {
			switch(inputtext[i]) {
				case '0'..'9', 'a'..'z', 'A'..'Z': continue;
				default: {
					Dialog_Show(playerid, Dialog:Room_InputName);

					SCM(playerid, -1, "{CC0033}Ошибка: название должно содержать латинские символы и цифры!");
					return 1;
				}
			}
		}
		if(strlen(inputtext) < 3) {
			Dialog_Show(playerid, Dialog:Room_InputName);

			SCM(playerid, -1, "{CC0033}Ошибка: название слишком короткое!");
			return 1;
		}
		else if(strlen(inputtext) > 10) {
			Dialog_Show(playerid, Dialog:Room_InputName);

			SCM(playerid, -1, "{CC0033}Ошибка: название слишком длинное!");
			return 1;
		}
		RoomInfo[playerid][R_Name][0] = EOS;
		strins(RoomInfo[playerid][R_Name], inputtext, 0);
		RoomInfo[playerid][R_NumberPlayers] = 2;
		RoomInfo[playerid][R_Mode] =
		RoomInfo[playerid][R_EndTimer] = 0;
		RoomInfo[playerid][R_Access] = false;
		RoomInfo[playerid][R_LobbyMinutes] =
		RoomInfo[playerid][R_LobbySeconds] = 0;
		Dialog_Show(playerid, Dialog:Room_Create);

		Mode_SetLocation(MODE_ROOM, playerid, 0);
		Mode_SetMode(MODE_ROOM, playerid, 0);
		Mode_SetMinutes(MODE_ROOM, playerid, 10);
		Mode_SetSeconds(MODE_ROOM, playerid, 0);
	}
	else
		Dialog_Show(playerid, Dialog:Room_SelectingTab);

	return 1;
}

DialogCreate:Room_ConnectRoom(playerid)
{
	Dialog_Open(playerid, Dialog:Room_ConnectRoom, DSI, "{e39b30}Подключиться по названию", "{FFFFFF}Для подключения, введите название комнаты", "Ввод", "Назад");
	return 1;
}

DialogResponse:Room_ConnectRoom(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Room_ConnectRoom);

		n_for(r, MAX_PLAYERS) {
			if(RoomInfo[r][R_Status] != ROOM_STATUS_LOBBY) 
				continue;

			if(!strcmp(inputtext, RoomInfo[r][R_Name], true)) {
				n_for2(i, 22)
					ListIDRoom[playerid][i] = 0;

				FirstRoom[playerid] = 0;

				if(RoomInfo[r][R_Access]) {
					SetPVarInt(playerid, "PlayerIDRoom2_PVar", r);
					Dialog_Show(playerid, Dialog:Room_InputPassword);
					return 1;
				}

				Room_CallPlayer(playerid, r);
				return 1;
			}
		}
		SCM(playerid, -1, "{289bd4}(Комната) {FFFFFF}Данной комнаты не существует.");
		Dialog_Show(playerid, Dialog:Room_ConnectRoom);
	}
	else
		Dialog_Show(playerid, Dialog:Room_SelectingTab);

	return 1;
}

DialogCreate:Room_ExcludePlayer(playerid)
{
	Dialog_Open(playerid, Dialog:Room_ExcludePlayer, DSL, "Управление комнатой", ""C_N"• {FFFFFF}Исключить игрока", "Выбрать", "Выйти");
	return 1;
}

DialogResponse:Room_ExcludePlayer(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	switch(listitem) {
		case 0: {
			new 
				id = GetPVarInt(playerid, "PlayerIDRoom_PVar"),
				room_id = GetPVarInt(playerid, "Room_World_PVar");

			if(id < 0 
			|| room_id < 0) {
				DeletePVar(playerid, "PlayerIDRoom_PVar");
				return 1;
			}

			if(RoomInfo[room_id][R_Players][id] == playerid) {
				SCM(playerid, -1, "{289bd4}(Комната) {FFFFFF}Нельзя исключить самого себя.");
				return 1;
			}

			if(RoomInfo[room_id][R_Players][id] > -1) {
				new 
					p = RoomInfo[room_id][R_Players][id];

				if(!IsPlayerOnServer(p))
					return 1;

				Room_ExitPlayer(p, GetPVarInt(p, "Room_World_PVar"));
				SCM(p, -1, "{289bd4}(Комната) {FFFFFF}Создатель комнаты исключил Вас.");
			}
		}
	}
	DeletePVar(playerid, "PlayerIDRoom_PVar");
	return 1;
}

DialogCreate:Room_ListLocations(playerid)
{
	new
		string[500];

	n_for(i, ROOM_MAX_LOCATIONS) {
		new 
			str[150];

		f(str, ""C_N"%i. {FFFFFF}%s\n", i + 1, Room_GetNameLocation(i));
		strcat(string, str);
	}

	Dialog_Open(playerid, Dialog:Room_ListLocations, DSL, "{e39b30}Список локаций", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Room_ListLocations(playerid, response, listitem, inputtext[])
{
	if(response)
		Mode_SetLocation(MODE_ROOM, playerid, listitem);

	if(RoomInfo[playerid][R_Status] == ROOM_STATUS_LOBBY)
		Dialog_Show(playerid, Dialog:Room_Settings);
	else
		Dialog_Show(playerid, Dialog:Room_Create);

	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock Room_OnGameModeInit(room_id)
{
	Room_LocOnGameModeInit(room_id);

	Iter_Init(Room_ActiveTeams);
	Iter_Init(Room_ActiveTeamsChet);

	R_CountRooms = 0;
	n_for(i, MAX_PLAYERS)
		R_CountRoom[i] = -1;

	Room_Reset(room_id);
	ResetTopPlayers(room_id);
	return 1;
}

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);
	ResetPlayerTDs(playerid);

	n_for(i, 22)
		ListIDRoom[playerid][i] = 0;

	FirstRoom[playerid] = 0;
	SetPVarInt(playerid, "Room_World_PVar", -1);
	SetPVarInt(playerid, "Room_Slot_PVar", -1);

	#if defined Room_OnPlayerConnect
		return Room_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerSpawn
*/

stock Room_OnPlayerSpawn(playerid)
{
	if(Adm_GetPlayerSpectating(playerid))
		return 1;
	
	if(GetPlayerBusy(playerid) != GAME)
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

	SettingsPlayerSpawn(playerid);

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, pInfo[playerid][pCredit]);
	ResetPlayerWeaponsEx(playerid);

	SetPlayerAmmunition(playerid);
	SetPlayerSpawnKill(playerid);

	SetPlayerTeamEx(playerid, GetPlayerTeamEx(playerid));

	Dina_CheckPlayerHint(playerid, 8);
	return 1;
}

/*
	OnPlayerDeath
*/

stock Room_OnPlayerDeath(playerid, &killerid, &reason)
{
	if(GetPlayerBusy(playerid) == GAME) {
		new
			room_id = Mode_GetPlayerSession(playerid);

		Damage_CheckPlayerBody(playerid);

		if(killerid != INVALID_PLAYER_ID)
			Iter_Add(spec_dead_playerid[killerid], playerid);

		SetPlayerDamage(playerid, false);
		Mode_SetPlayerDeath(playerid, 1);

		m_for(MODE_ROOM, room_id, p) 
			SendDeathMessageToPlayer(p, killerid, playerid, reason);

		DestroyPlayerBelowHealth(playerid);
		Room_DestroyPlayerPoint(playerid);
		Room_DestroyPlayerComputer(playerid);

		switch(Room_GetMode(room_id)) {
			case ROOM_MODE_BATTLE: {
				Room_GiveTeamModeChet(room_id, GetPlayerTeamEx(playerid), 1);
			}
		}
		
		ShowDeadKiller(playerid, killerid);
	}
	if(killerid != INVALID_PLAYER_ID) 
		SetPlayerSpeedRespawn(playerid, gettime() + ROOM_PLAYER_TIMER_RESPAWN, false);
	else 
		SetPlayerSpeedRespawn(playerid, gettime() + MAX_PLAYER_TIMER_RESPAWN, false);
	
	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
	OnPlayerEnterDynamicArea
*/

stock Room_OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) 
{
	if(Room_LocOnPlEnterDynamicArea(playerid, areaid))
		return 1;

	return 1;
}

/*
	OnPlayerLeaveDynamicArea
*/

stock Room_OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)  
{
	if(Room_LocOnPlLeaveDynamicArea(playerid, areaid))
		return 1;

	return 1;
}

/*
	OnPlayerKeyStateChange
*/

stock Room_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerDead(playerid))
		return 0;

	if(Room_LocOnPlKeyStateChange(playerid, newkeys, oldkeys))
		return 1;

	// Anti +C
	if(newkeys == 65410 
	|| newkeys == 130)
		DeaglePlayerAntiC(playerid);

	return 1;
}

/*
	ALS
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