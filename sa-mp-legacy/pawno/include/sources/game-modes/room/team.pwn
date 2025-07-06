/*

	About: Room team system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Room_GetTeamName(team_id)
		Room_ShowTeamColor(team_id)
		Room_ShowTeamColorXB(team_id)
		Room_ShowTeamColorXF(team_id)
		Room_ShowTeamColorObject(team_id)
		Room_ShowTeamColorVehicle(team_id, color_id)
Enums:
	E_ROOM_TEAM_INFO
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_TEAM_SYSTEM
	#endinput
#endif
#define _INC_ROOM_TEAM_SYSTEM

/*

	* Enums *

*/

enum E_ROOM_TEAM_INFO {
	T_ID,
	T_Name[ROOM_MAX_TEAM_NAME_LENGTH],
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
	room_TeamInfo[ROOM_MAX_TEAMS][E_ROOM_TEAM_INFO] =
	{
		{ROOM_TEAM_NONE, "Нейтралы", 
		"{CCCCCC}", 0xCCCCCCBB, 0xCCCCCCFF, 0xFF424242, -1, -1},

		{ROOM_TEAM_ALPHA, "Альфа", 
		"{2acadb}", 0x2acadbBB, 0x2acadbFF, 0xFF22a4d4, -1, -1},

		{ROOM_TEAM_BRAVO, "Браво", 
		"{db2a2a}", 0xdb2a2aBB, 0xdb2a2aFF, 0xFFd42222, -1, -1}
	};

/*

	* Functions *

*/

stock Room_GetTeamName(team_id)
{
	static
		str[ROOM_MAX_TEAM_NAME_LENGTH];

	str[0] = EOS;

	team_id = CheckTeamID(team_id);

	strcat(str, room_TeamInfo[team_id][T_Name]);
	return str;
}

stock Room_ShowTeamColor(team_id)
{
	static
		str[10];

	str[0] = EOS;

	team_id = CheckTeamID(team_id);

	strcat(str, room_TeamInfo[team_id][T_Color]);
	return str;
}

stock Room_ShowTeamColorXB(team_id)
{
	team_id = CheckTeamID(team_id);

	return room_TeamInfo[team_id][T_ColorXB];
}

stock Room_ShowTeamColorXF(team_id)
{
	team_id = CheckTeamID(team_id);

	return room_TeamInfo[team_id][T_ColorXF];
}

stock Room_ShowTeamColorObject(team_id)
{
	team_id = CheckTeamID(team_id);

	return room_TeamInfo[team_id][T_ColorObject];
}

stock Room_ShowTeamColorVehicle(team_id, color_id)
{
	if(color_id < 0
	|| color_id > 1)
		return 0;

	team_id = CheckTeamID(team_id);

	if(color_id == 0)
		return room_TeamInfo[team_id][T_ColorVehicle1];
	else
		return room_TeamInfo[team_id][T_ColorVehicle2];
}

static CheckTeamID(team_id)
{
	n_for(i, ROOM_MAX_TEAMS) {
		if(room_TeamInfo[i][T_ID] == team_id)
			return i;
	}

	return 0;
}