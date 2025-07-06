/*
 * |>=========================<|
 * |   About: Room team main   |
 * |   Author: Foxze           |
 * |>=========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- Room_GetTeamName(teamid)
	- Room_GetTeamColor(teamid)
	- Room_GetTeamColorXB(teamid)
	- Room_GetTeamColorXF(teamid)
	- Room_GetTeamColorObject(teamid)
	- Room_GetTeamColorVehicle(teamid, colorid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_ROOM_TEAM_INFO
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

#if defined _INC_ROOM_TEAM_MAIN
	#endinput
#endif
#define _INC_ROOM_TEAM_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_ROOM_TEAM_INFO {
	e_ID,
	e_Name[ROOM_MAX_TEAM_NAME_LENGTH],
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
	room_TeamInfo[ROOM_MAX_TEAMS][E_ROOM_TEAM_INFO] =
	{
		{ROOM_TEAM_NONE, "Нейтралы", 
		""CT_GREY"", 0xCCCCCCBB, 0xCCCCCCFF, 0xFF424242, -1, -1},

		{ROOM_TEAM_ALPHA, "Альфа", 
		"{2acadb}", 0x2acadbBB, 0x2acadbFF, 0xFF22a4d4, -1, -1},

		{ROOM_TEAM_BRAVO, "Браво", 
		"{db2a2a}", 0xdb2a2aBB, 0xdb2a2aFF, 0xFFd42222, -1, -1}
	};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock Room_GetTeamName(teamid)
{
	static
		str[ROOM_MAX_TEAM_NAME_LENGTH];

	str[0] = EOS;

	teamid = CheckTeamID(teamid);

	strcopy(str, room_TeamInfo[teamid][e_Name], ROOM_MAX_TEAM_NAME_LENGTH);
	return str;
}

stock Room_GetTeamColor(teamid)
{
	static
		str[10];

	str[0] = EOS;

	teamid = CheckTeamID(teamid);

	strcopy(str, room_TeamInfo[teamid][e_Color]);
	return str;
}

stock Room_GetTeamColorXB(teamid)
{
	teamid = CheckTeamID(teamid);

	return room_TeamInfo[teamid][e_ColorXB];
}

stock Room_GetTeamColorXF(teamid)
{
	teamid = CheckTeamID(teamid);

	return room_TeamInfo[teamid][e_ColorXF];
}

stock Room_GetTeamColorObject(teamid)
{
	teamid = CheckTeamID(teamid);

	return room_TeamInfo[teamid][e_ColorObject];
}

stock Room_GetTeamColorVehicle(teamid, colorid)
{
	if (colorid < 0
	|| colorid > 1) {
		return 0;
	}

	teamid = CheckTeamID(teamid);

	if (colorid == 0) {
		return room_TeamInfo[teamid][e_ColorVehicle1];
	}
	else {
		return room_TeamInfo[teamid][e_ColorVehicle2];
	}
}

static CheckTeamID(teamid)
{
	n_for(i, ROOM_MAX_TEAMS) {
		if (room_TeamInfo[i][e_ID] == teamid) {
			return i;
		}
	}
	return 0;
}