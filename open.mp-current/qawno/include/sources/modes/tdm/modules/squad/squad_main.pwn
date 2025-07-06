/*
 * |>=========================<|
 * |   About: TDM squad main   |
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
 * Stock:
	- TDM_EnterPlayerRandomSquad(playerid)
	- TDM_LeavePlayerSquad(playerid)
	- TDM_UpdatePlayerSquad(playerid)
	- TDM_UpdatePlSquadPlayers(playerid)
	- TDM_SquadCheckSpecPlayers(playerid)
	- TDM_SqGetPlayerList(playerid, num)

	# Technical #
	- TDM_SqResetSessionData(sessionid)
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

#if defined _INC_TDM_SQUAD_MAIN
	#endinput
#endif
#define _INC_TDM_SQUAD_MAIN

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	PlayerActiveCellSquad[MAX_PLAYERS],
	PlayerActiveSlotSquad[MAX_PLAYERS],
	PlayerActiveListSquad[MAX_PLAYERS][TDM_MAX_SQUAD_PLAYERS - 1];

static
	SquadPlayerID[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][TDM_MAX_SQUADS][TDM_MAX_SQUAD_PLAYERS],
	SquadPlayers[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][TDM_MAX_SQUADS];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock TDM_EnterPlayerRandomSquad(playerid)
{
	if (PlayerActiveCellSquad[playerid] != -1) {
		return 1;
	}

	new
		index,
		sessionid = M_GPS(playerid),
		teamid = GetPlayerTeamEx(playerid);

	n_for(i, TDM_MAX_SQUADS) {
		if (SquadPlayers[sessionid][teamid][i] >= TDM_MAX_SQUAD_PLAYERS) {
			continue;
		}

		index = i;
		break;
	}
	n_for(i, TDM_MAX_SQUAD_PLAYERS) {
		if (SquadPlayerID[sessionid][teamid][index][i] > -1) {
			continue;
		}

		PlayerActiveSlotSquad[playerid] = i;
		SquadPlayerID[sessionid][teamid][index][i] = playerid;
		break;
	}
	PlayerActiveCellSquad[playerid] = index;
	SquadPlayers[sessionid][teamid][index]++;

	SCM(playerid, C_LIGHT_BLUE, ""T_SQUAD" "CT_WHITE"Выбран отряд: {27bfc4}%s", GetNameSquad(index));

	n_for(i, SquadPlayers[sessionid][teamid][index]) {
		new
			pSquad = SquadPlayerID[sessionid][teamid][index][i];
			
		if (!TDM_GetPlayerSelectSpawn(pSquad)) {
			continue;
		}

		TDM_UpdatePlayerSquad(pSquad);
	}
	return 1;
}

stock TDM_LeavePlayerSquad(playerid)
{
	if (PlayerActiveCellSquad[playerid] == -1) {
		return 1;
	}

	new
		cell = PlayerActiveCellSquad[playerid],
		slot = PlayerActiveSlotSquad[playerid],
		sessionid = M_GPS(playerid),
		teamid = GetPlayerTeamEx(playerid);

	SquadPlayers[sessionid][teamid][cell]--;

	SquadPlayerID[sessionid][teamid][cell][slot] = SquadPlayerID[sessionid][teamid][cell][SquadPlayers[sessionid][teamid][cell]];
	PlayerActiveSlotSquad[SquadPlayerID[sessionid][teamid][cell][slot]] = slot;
	SquadPlayerID[sessionid][teamid][cell][SquadPlayers[sessionid][teamid][cell]] = -1;

	PlayerActiveCellSquad[playerid] = PlayerActiveSlotSquad[playerid] = -1;

	n_for(i, TDM_MAX_SQUAD_PLAYERS - 1) {
		PlayerActiveListSquad[playerid][i] = -1;
	}

	n_for(i, SquadPlayers[sessionid][teamid][cell]) {
		new
			pSquad = SquadPlayerID[sessionid][teamid][cell][i];
			
		if (!TDM_GetPlayerSelectSpawn(pSquad)) {
			continue;
		}

		TDM_UpdatePlayerSquad(pSquad);
	}
	return 1;
}

stock TDM_UpdatePlayerSquad(playerid)
{
	if (PlayerActiveCellSquad[playerid] == -1) {
		return 1;
	}

	new
		cell = PlayerActiveCellSquad[playerid],
		sessionid = M_GPS(playerid),
		teamid = GetPlayerTeamEx(playerid),
		td = 0;

	n_for(i, TDM_MAX_SQUAD_PLAYERS - 1) {
		PlayerActiveListSquad[playerid][i] = -1;
	}

	for (new i = 0, list = 0; i < TDM_MAX_SQUAD_PLAYERS; i++) {
		if (SquadPlayerID[sessionid][teamid][cell][i] == playerid) {
			continue;
		}

		if (SquadPlayerID[sessionid][teamid][cell][i] > -1) {
			new 
				pSquad = SquadPlayerID[sessionid][teamid][cell][i];

			PlayerActiveListSquad[playerid][list] = pSquad;
			list++;

			TDM_UpdatePlSquadPlayersTD(playerid, td, pSquad);
		}
		else {
			TDM_UpdatePlSquadPlayersTD(playerid, td, -1);
		}
		td += 6;
	}

	if (TDM_GetPlayerSelectPlayerID(playerid) != -1
	&& TDM_GetPlayerSelectPlayerID(playerid) != -2) {
		SpecPl(playerid, true);
		TDM_HidePlayerSelectedSpawn(playerid);

		TDM_SetPlayerBaseCamera(playerid, teamid);
		TDM_ShowPlayerBaseColor(playerid);
	}
	return 1;
}

stock TDM_UpdatePlSquadPlayers(playerid)
{
	if (PlayerActiveCellSquad[playerid] == -1) {
		return 1;
	}

	new
		cell = PlayerActiveCellSquad[playerid],
		sessionid = M_GPS(playerid),
		teamid = GetPlayerTeamEx(playerid),
		tdid = 0;

	n_for(i, TDM_MAX_SQUAD_PLAYERS) {
		if (SquadPlayerID[sessionid][teamid][cell][i] == playerid) {
			continue;
		}

		if (SquadPlayerID[sessionid][teamid][cell][i] > -1) {
			new 
				pSquad = SquadPlayerID[sessionid][teamid][cell][i];

			TDM_UpdatePlSquadPlayersTD(playerid, tdid, pSquad);
		}
		tdid += 6;
	}
	return 1;
}

stock TDM_SquadCheckSpecPlayers(playerid)
{
	if (Iter_Count(TDM_SpecSquadPlayerid[playerid]) > 0) {
		foreach (new p:TDM_SpecSquadPlayerid[playerid]) {
			TDM_HidePlSelectedPointSpawn(p);

			if (TDM_GetPlayerSelectPlayerID(p) != -1
			&& TDM_GetPlayerSelectPlayerID(p) != -2)
				SpecPl(p, true);

			TDM_HidePlayerSelectedSpawn(p, false);
			TDM_TimerSetPlayerBaseCamera(p);
			TDM_ShowPlayerBaseColor(p);
		}
		Iter_Clear(TDM_SpecSquadPlayerid[playerid]);
	}
	return 1;
}

stock TDM_SqGetPlayerList(playerid, num)
{
	return PlayerActiveListSquad[playerid][num];
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

stock TDM_SqResetSessionData(sessionid)
{
	n_for2(t, TDM_MAX_TEAMS) {
		n_for3(s, TDM_MAX_SQUADS) {
			n_for4(b, TDM_MAX_SQUAD_PLAYERS) {
				SquadPlayerID[sessionid][t][s][b] = -1;
			}
			SquadPlayers[sessionid][t][s] = 0;
		}
	}
	return 1;
}

static ResetPlayerSquadData(playerid)
{
	PlayerActiveCellSquad[playerid] =
	PlayerActiveSlotSquad[playerid] = -1;

	n_for(i, TDM_MAX_SQUAD_PLAYERS - 1) {
		PlayerActiveListSquad[playerid][i] = -1;
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

stock TDM_SqOnGameModeInit()
{
	Iter_Init(TDM_SpecSquadPlayerid);
	return 1;
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerSquadData(playerid);

	#if defined TDM_SqOnPlayerConnect
		return TDM_SqOnPlayerConnect(playerid);
	#else
		return 1;
	#endif
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
#define OnPlayerConnect TDM_SqOnPlayerConnect
#if defined TDM_SqOnPlayerConnect
	forward TDM_SqOnPlayerConnect(playerid);
#endif