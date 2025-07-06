/*
 * |>========================<|
 * |   About: TDM team main   |
 * |   Author: Foxze          |
 * |>========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- TDM_SetRandomPlayerTeam(playerid)
	- TDM_GetTeamName(teamid)
	- TDM_GetTeamColor(teamid)
	- TDM_GetTeamColorXB(teamid)
	- TDM_GetTeamColorXF(teamid)
	- TDM_GetTeamColorObject(teamid)
	- TDM_GetTeamColorVehicle(teamid, colorid)
	- TDM_IsTeam(teamid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_TDM_TEAM_INFO
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

#if defined _INC_TDM_TEAM_MAIN
	#endinput
#endif
#define _INC_TDM_TEAM_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_TDM_TEAM_INFO {
	e_ID,
	e_Name[TDM_MAX_LENGTH_TEAM_NAME],
	e_Color[10],
	e_ColorXB,
	e_ColorXF,
	e_ColorObject,
	e_ColorVehicle1,
	e_ColorVehicle2
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static const
	TeamInfo[TDM_MAX_TEAMS][E_TDM_TEAM_INFO] = 
	{
		{TDM_TEAM_NONE, "Нейтралы", 
		""CT_GREY"", 0xCCCCCCBB, 0xCCCCCCFF, 0xFF424242, -1, -1},

		{TDM_TEAM_MILITARY, "Военные", 
		"{2ECC2E}", 0x2ECC2EBB, 0x2ECC2EFF, 0xFF15ff00, 86, 0},

		{TDM_TEAM_REBEL, "Повстанцы", 
		"{E79918}", 0xE79918BB, 0xE79918FF, 0xFFf7ff00, 219, 0},

		{TDM_TEAM_BANDIT, "Бандиты", 
		"{de5757}", 0xde5757BB, 0xde5757FF, 0xFFff0000, 18, 0},

		{TDM_TEAM_MARAUDER, "Мародёры",
		"{cee83c}", 0xcee83cBB, 0xcee83cFF, 0xFFffe100, 194, 0}
	};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock TDM_SetRandomPlayerTeam(playerid) 
{
	new 
		sessionid = M_GPS(playerid),
		team[TDM_MAX_TEAMS];

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
	    if (tt == TDM_TEAM_NONE) {
			continue;
		}

		m_for(MODE_TDM, sessionid, p) {
		    if (GetPlayerTeamEx(p) != tt) {
				continue;
			}

		    team[tt]++;
		}
	}
	new 
		mostTeam;

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
	    if (tt == TDM_TEAM_NONE) {
			continue;
		}

	    if (team[tt] >= mostTeam) {
			mostTeam = team[tt];
		}
	}
	new 
		lostTeam = mostTeam, index;

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		if (tt == TDM_TEAM_NONE) {
			continue;
		}

	    if (team[tt] <= lostTeam) {
			lostTeam = team[tt];
			index = tt;
	    }
	}
	SetPlayerTeamEx(playerid, index);
	SetPlayerColorEx(playerid, TDM_GetTeamColorXB(GetPlayerTeamEx(playerid)));
	SCM(playerid, C_RED, ""T_TEAM" "CT_WHITE"Выбрана команда: %s%s", TDM_GetTeamColor(index), TDM_GetTeamName(index));
	return 1;
}

stock TDM_GetTeamName(teamid)
{
	new
		str[TDM_MAX_LENGTH_TEAM_NAME];

	teamid = CheckTeamID(teamid);
	
	strcopy(str, TeamInfo[teamid][e_Name], TDM_MAX_LENGTH_TEAM_NAME);
	return str;
}

stock TDM_GetTeamColor(teamid) 
{
	teamid = CheckTeamID(teamid);

	new
		str[10];

	teamid = CheckTeamID(teamid);
	
	strcopy(str, TeamInfo[teamid][e_Color]);
	return str;
}

stock TDM_GetTeamColorXB(teamid) 
{
	teamid = CheckTeamID(teamid);

	return TeamInfo[teamid][e_ColorXB];
}

stock TDM_GetTeamColorXF(teamid) 
{
	teamid = CheckTeamID(teamid);

	return TeamInfo[teamid][e_ColorXF];
}

stock TDM_GetTeamColorObject(teamid) 
{
	teamid = CheckTeamID(teamid);

	return TeamInfo[teamid][e_ColorObject];
}

stock TDM_GetTeamColorVehicle(teamid, colorid) 
{
	if (colorid < 0
	|| colorid > 1) {
		return 0;
	}

	teamid = CheckTeamID(teamid);

	if (colorid == 0) {
		return TeamInfo[teamid][e_ColorVehicle1];
	}
	else {
		return TeamInfo[teamid][e_ColorVehicle2];
	}
}

stock TDM_IsTeam(teamid)
{
	if (teamid < 0 
	|| teamid >= TDM_MAX_TEAMS) {
		return 0;
	}
	return 1;
}

static CheckTeamID(teamid)
{
	n_for(i, TDM_MAX_TEAMS) {
		if (TeamInfo[i][e_ID] == teamid) {
			return i;
		}
	}
	return 0;
}