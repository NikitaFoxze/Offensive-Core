/*

	About: TDM team system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		TDM_SetRandomPlayerTeam(playerid)
		TDM_GetTeamName(team_id)
		TDM_ShowTeamColor(team_id)
		TDM_ShowTeamColorXB(team_id)
		TDM_ShowTeamColorXF(team_id)
		TDM_ShowTeamColorObject(team_id)
		TDM_ShowTeamColorVehicle(team_id, color_id)
		TDM_IsTeam(team_id)
Enums:
	E_TDM_TEAM_INFO
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_TEAM_SYSTEM
	#endinput
#endif
#define _INC_TDM_TEAM_SYSTEM

/*

	* Enums *

*/

enum E_TDM_TEAM_INFO {
	T_ID,
	T_Name[TDM_MAX_TEAM_NAME_LENGTH],
	T_Color[10],
	T_ColorXB,
	T_ColorXF,
	T_ColorObject,
	T_ColorVehicle1,
	T_ColorVehicle2
}

/*

	* Vars *

*/

static const
	tdm_TeamInfo[TDM_MAX_TEAMS][E_TDM_TEAM_INFO] = 
	{
		{TDM_TEAM_NONE, "Нейтралы", 
		"{CCCCCC}", 0xCCCCCCBB, 0xCCCCCCFF, 0xFF424242, -1, -1},

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

	* Functions *

*/

stock TDM_SetRandomPlayerTeam(playerid) 
{
	new 
		session_id = M_GPS(playerid),
		team[TDM_MAX_TEAMS];

	foreach(new tt:TDM_ActiveTeams[session_id]) {
	    if(tt == TDM_TEAM_NONE) 
			continue;

		m_for(MODE_TDM, session_id, p) {
		    if(GetPlayerTeamEx(p) != tt) 
				continue;

		    team[tt]++;
		}
	}
	new 
		most_team;

	foreach(new tt:TDM_ActiveTeams[session_id]) {
	    if(tt == TDM_TEAM_NONE) 
			continue;

	    if(team[tt] >= most_team) 
			most_team = team[tt];
	}
	new 
		lost_team = most_team, index;

	foreach(new tt:TDM_ActiveTeams[session_id]) {
		if(tt == TDM_TEAM_NONE) 
			continue;

	    if(team[tt] <= lost_team) {
			lost_team = team[tt];
			index = tt;
	    }
	}
	SetPlayerTeamEx(playerid, index);
	SetPlayerColorEx(playerid, TDM_ShowTeamColorXB(GetPlayerTeamEx(playerid)));

	new 
		str[50 + TDM_MAX_TEAM_NAME_LENGTH];

	f(str, "{ed9715}(Команда) {FFFFFF}Выбрана команда: %s%s", TDM_ShowTeamColor(index), TDM_GetTeamName(index));
	SCM(playerid, -1, str);
	return 1;
}

stock TDM_GetTeamName(team_id)
{
	new
		str[TDM_MAX_TEAM_NAME_LENGTH];

	team_id = CheckTeamID(team_id);
	
	strcat(str, tdm_TeamInfo[team_id][T_Name]);
	return str;
}

stock TDM_ShowTeamColor(team_id) 
{
	team_id = CheckTeamID(team_id);

	new
		str[10];

	team_id = CheckTeamID(team_id);
	
	strcat(str, tdm_TeamInfo[team_id][T_Color]);
	return str;
}

stock TDM_ShowTeamColorXB(team_id) 
{
	team_id = CheckTeamID(team_id);

	return tdm_TeamInfo[team_id][T_ColorXB];
}

stock TDM_ShowTeamColorXF(team_id) 
{
	team_id = CheckTeamID(team_id);

	return tdm_TeamInfo[team_id][T_ColorXF];
}

stock TDM_ShowTeamColorObject(team_id) 
{
	team_id = CheckTeamID(team_id);

	return tdm_TeamInfo[team_id][T_ColorObject];
}

stock TDM_ShowTeamColorVehicle(team_id, color_id) 
{
	if(color_id < 0
	|| color_id > 1)
		return 0;

	team_id = CheckTeamID(team_id);

	if(color_id == 0)
		return tdm_TeamInfo[team_id][T_ColorVehicle1];
	else
		return tdm_TeamInfo[team_id][T_ColorVehicle2];
}

stock TDM_IsTeam(team_id)
{
	if(team_id < 0 
	|| team_id >= TDM_MAX_TEAMS) 
		return 0;

	return 1;
}

static CheckTeamID(team_id)
{
	n_for(i, TDM_MAX_TEAMS) {
		if(tdm_TeamInfo[i][T_ID] == team_id)
			return i;
	}

	return 0;
}