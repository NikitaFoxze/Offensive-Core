/*

	About: TDM squad system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
	Stock:
		TDM_EnterPlayerRandomSquad(playerid)
		TDM_LeavePlayerSquad(playerid)
		TDM_UpdatePlayerSquad(playerid)
		TDM_UpdatePlSquadPlayers(playerid)
		TDM_SquadCheckSpecPlayers(playerid)
		TDM_SqGetPlayerList(playerid, num)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_SQUAD_SYSTEM
	#endinput
#endif
#define _INC_TDM_SQUAD_SYSTEM

/*

	* Vars *

*/

static
	active_cell_squad[MAX_PLAYERS],
	active_slot_squad[MAX_PLAYERS],
	active_list_squad[MAX_PLAYERS][TDM_MAX_SQUAD_PLAYERS - 1];

static
	player_squad[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][TDM_MAX_SQUADS][TDM_MAX_SQUAD_PLAYERS],
	players_squad[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][TDM_MAX_SQUADS];

/*

	* Functions *

*/

stock TDM_EnterPlayerRandomSquad(playerid)
{
	if(active_cell_squad[playerid] != -1)
		return 1;

	new
		index,
		session_id = M_GPS(playerid),
		team_id = GetPlayerTeamEx(playerid);

	n_for(i, TDM_MAX_SQUADS) {
		if(players_squad[session_id][team_id][i] >= TDM_MAX_SQUAD_PLAYERS)
			continue;

		index = i;
		break;
	}
	n_for(i, TDM_MAX_SQUAD_PLAYERS) {
		if(player_squad[session_id][team_id][index][i] > -1)
			continue;

		active_slot_squad[playerid] = i;
		player_squad[session_id][team_id][index][i] = playerid;
		break;
	}
	active_cell_squad[playerid] = index;
	players_squad[session_id][team_id][index]++;

	new
		str[150];

	f(str, "{ed9715}(Отряд) {FFFFFF}Выбран отряд: {27bfc4}%s", GetNameSquad(index));
	SCM(playerid, -1, str);

	n_for(i, players_squad[session_id][team_id][index]) {
		new
			p_squad = player_squad[session_id][team_id][index][i];
			
		if(!TDM_GetPlayerSelectTP(p_squad))
			continue;

		TDM_UpdatePlayerSquad(p_squad);
	}
	return 1;
}

stock TDM_LeavePlayerSquad(playerid)
{
	if(active_cell_squad[playerid] == -1)
		return 1;

	new
		cell = active_cell_squad[playerid],
		slot = active_slot_squad[playerid],
		session_id = M_GPS(playerid),
		team_id = GetPlayerTeamEx(playerid);

	players_squad[session_id][team_id][cell]--;

	player_squad[session_id][team_id][cell][slot] = player_squad[session_id][team_id][cell][players_squad[session_id][team_id][cell]];
	active_slot_squad[player_squad[session_id][team_id][cell][slot]] = slot;
	player_squad[session_id][team_id][cell][players_squad[session_id][team_id][cell]] = -1;

	active_cell_squad[playerid] = active_slot_squad[playerid] = -1;

	n_for(i, TDM_MAX_SQUAD_PLAYERS - 1)
		active_list_squad[playerid][i] = -1;

	n_for(i, players_squad[session_id][team_id][cell]) {
		new
			p_squad = player_squad[session_id][team_id][cell][i];
			
		if(!TDM_GetPlayerSelectTP(p_squad))
			continue;

		TDM_UpdatePlayerSquad(p_squad);
	}
	return 1;
}

stock TDM_UpdatePlayerSquad(playerid)
{
	if(active_cell_squad[playerid] == -1)
		return 1;

	new
		cell = active_cell_squad[playerid],
		session_id = M_GPS(playerid),
		team_id = GetPlayerTeamEx(playerid),
		td = 0;

	n_for(i, TDM_MAX_SQUAD_PLAYERS - 1)
		active_list_squad[playerid][i] = -1;

	for(new i = 0, list = 0; i < TDM_MAX_SQUAD_PLAYERS; i++) {
		if(player_squad[session_id][team_id][cell][i] == playerid)
			continue;

		if(player_squad[session_id][team_id][cell][i] > -1) {
			new 
				p_squad = player_squad[session_id][team_id][cell][i];

			active_list_squad[playerid][list] = p_squad;
			list++;

			TDM_UpdatePlTDSquadPlayers(playerid, td, p_squad);
		}
		else
			TDM_UpdatePlTDSquadPlayers(playerid, td, -1);

		td += 6;
	}

	if(TDM_GetPlayerCellSelectID(playerid) != -1
	&& TDM_GetPlayerCellSelectID(playerid) != -2) {
		SpecPl(playerid, true);
		TDM_HideSelectedPlayerTP(playerid);

		TDM_SetPlayerBaseCamera(playerid, team_id);
		TDM_ShowPlayerBaseColor(playerid);
	}
	return 1;
}

stock TDM_UpdatePlSquadPlayers(playerid)
{
	if(active_cell_squad[playerid] == -1)
		return 1;

	new
		cell = active_cell_squad[playerid],
		session_id = M_GPS(playerid),
		team_id = GetPlayerTeamEx(playerid),
		td_id = 0;

	n_for(i, TDM_MAX_SQUAD_PLAYERS) {
		if(player_squad[session_id][team_id][cell][i] == playerid) 
			continue;

		if(player_squad[session_id][team_id][cell][i] > -1) {
			new 
				p_squad = player_squad[session_id][team_id][cell][i];

			TDM_UpdatePlTDSquadPlayers(playerid, td_id, p_squad);
		}
		td_id += 6;
	}
	return 1;
}

stock TDM_SquadCheckSpecPlayers(playerid)
{
	if(Iter_Count(spec_squad_playerid[playerid]) > 0) {
		foreach(new p:spec_squad_playerid[playerid]) {
			TDM_HideSelectedPointTP(p);

			if(TDM_GetPlayerCellSelectID(p) != -1
			&& TDM_GetPlayerCellSelectID(p) != -2)
				SpecPl(p, true);

			TDM_HideSelectedPlayerTP(p, false);
			TDM_TimerSetPlayerBaseCamera(p);
			TDM_ShowPlayerBaseColor(p);
		}
		Iter_Clear(spec_squad_playerid[playerid]);
	}
	return 1;
}

stock TDM_SqGetPlayerList(playerid, num)
{
	return active_list_squad[playerid][num];
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock TDM_SqOnGameModeInit(session_id)
{
	Iter_Init(spec_squad_playerid);

	n_for(t, TDM_MAX_TEAMS) {
		n_for2(s, TDM_MAX_SQUADS) {
			n_for3(b, TDM_MAX_SQUAD_PLAYERS) {
				player_squad[session_id][t][s][b] = -1;
			}
			players_squad[session_id][t][s] = 0;
		}
	}
	return 1;
}

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	active_cell_squad[playerid] =
	active_slot_squad[playerid] = -1;

	n_for(i, TDM_MAX_SQUAD_PLAYERS - 1)
		active_list_squad[playerid][i] = -1;

	#if defined TDM_SqOnPlayerConnect
		return TDM_SqOnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	ALS
*/

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect TDM_SqOnPlayerConnect
#if defined TDM_SqOnPlayerConnect
	forward TDM_SqOnPlayerConnect(playerid);
#endif