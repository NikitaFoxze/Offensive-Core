/*

	About: Room location system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	Stock:
		Room_CreateElementsLocation(room_id)
		Room_DestroyElementsLocation(room_id)
		Room_ShowPlElementsLocation(playerid)
		Room_HidePlElementsLocation(playerid)

		Room_CreatePointFlag(room_id, world_id, interior_id)
		Room_DestroyPointFlag(room_id)
		Room_ResetPointFlag(room_id)
		Room_SetCapturePointPos(room_id, Float:X, Float:Y, Float:Z)
		Room_ResetCapturePointPos(room_id)
		Room_MovePointFlag(room_id, type)
		Room_ChangeColorPointFlag(room_id, team_id)
		Room_CreatePlayerPoint(playerid) 
		Room_DestroyPlayerPoint(playerid)
		Room_GetCapturePointColor(room_id)
		Room_CreateObjectPointFlag(room_id)
		Room_DestroyObjectPointFlag(room_id)
		Room_SetCPTeamChet(room_id, team_id, num)
		Room_GiveCPTeamChet(room_id, team_id, num)
		Room_GetCPTeamChet(room_id, team_id)
		Room_GiveCPPointTeam(room_id, team_id)
		Room_SetCPTeamMaxChet(room_id, team_id, num)
		Room_GetCPTeamMaxChet(room_id, team_id)
		Room_PointReInfo(room_id)

		Room_CreateComputer(room_id, world_id, interior_id)
		Room_DestroyComputer(room_id)
		Room_ResetComputer(room_id)
		Room_SetComputerPos(room_id, Float:X, Float:Y, Float:Z)
		Room_ResetComputerPos(room_id)
		Room_GetComputerProtectTeam(room_id)
		Room_CreatePlayerComputer(playerid)
		Room_DestroyPlayerComputer(playerid)
		Room_UpdatePlayerComputer(playerid)
		Room_SetCompTeamChet(room_id, team_id, num)
		Room_GiveCompTeamChet(room_id, team_id, num)
		Room_GetCompTeamChet(room_id, team_id)
		Room_SetCompTeamMaxChet(room_id, team_id, num)
		Room_GetCompTeamMaxChet(room_id, team_id)
		Room_ComputerReInfo(room_id)

		Room_SetBattleTeamChet(room_id, team_id, num)
		Room_GiveBattleTeamChet(room_id, team_id, num)
		Room_GetBattleTeamChet(room_id, team_id)
		Room_SetBattleTeamMaxChet(room_id, team_id, num)
		Room_GetBattleTeamMaxChet(room_id, team_id)

		Room_ShowCameraEndLocation(playerid)
		Room_SetCameraEndPos(room_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
		Room_SetCameraEndLookAt(room_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
		Room_ResetCameraEndPos(room_id)

		Room_AddTeam(room_id, team_id, bool:chet)
		Room_RemoveTeam(room_id, team_id)
		Room_CheckTeam(room_id, team_id)
		Room_CheckTeamChet(room_id, team_id)
		Room_GetActiveTeams(room_id)

		Room_SetTeamChet(room_id, team_id, chet, maxchet)
		Room_ResetTeamsChet(room_id)
		Room_GetTeamsChet(room_id)

		Room_SetSpawnBasePos(room_id, team_id, cell, Float:X, Float:Y, Float:Z)
		Room_GetSpawnBasePos(room_id, team_id, cell, &Float:X, &Float:Y, &Float:Z)
Enums:
	E_ROOM_BATTLE_INFO
	E_ROOM_CAPTURE_POINT_INFO
	E_ROOM_COMPUTER_INFO
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_LOC_SYSTEM
	#endinput
#endif
#define _INC_ROOM_LOC_SYSTEM

/*

	* Locations *

*/

#include <sources/game-modes/room/locations/desert/desert.pwn>
#include <sources/game-modes/room/locations/zone51/zone51.pwn>
#include <sources/game-modes/room/locations/military-oil/military-oil.pwn>
#include <sources/game-modes/room/locations/airport/airport.pwn>
#include <sources/game-modes/room/locations/stadium/stadium.pwn>

/*

	* Enums *

*/

enum E_ROOM_BATTLE_INFO {
	R_Chet[ROOM_MAX_TEAMS],
	R_MaxChet[ROOM_MAX_TEAMS]
}

enum E_ROOM_CAPTURE_POINT_INFO {
	R_ObjectPos,
	R_ObjectFlag,
	R_Sphere,
	R_MapIcon,
	Text3D:R_3DText,
	R_Color,
	bool:R_Red,
	R_ChetBar,
	R_CaptureTeam,
	R_Property,
	R_Chet[ROOM_MAX_TEAMS],
	R_MaxChet[ROOM_MAX_TEAMS]
}

enum E_ROOM_COMPUTER_INFO {
	R_ObjectComputer,
	bool:R_ActionCapture,
    bool:R_Red,
	R_Status,
	R_ChetBar,
	R_Timer,
	R_MapIcon,
	Text3D:R_3DText,
	Text3D:R_3DTextClick,
	R_ProtectTeam,
	R_PlayerID,
	R_Chet[ROOM_MAX_TEAMS],
	R_MaxChet[ROOM_MAX_TEAMS]
}

/*

	* Vars *

*/

static
	Mode_Battle[MAX_PLAYERS][E_ROOM_BATTLE_INFO],
	Mode_CapturePoint[MAX_PLAYERS][E_ROOM_CAPTURE_POINT_INFO],
	Mode_Computer[MAX_PLAYERS][E_ROOM_COMPUTER_INFO];

static
	bool:ActiveTeamChet[MAX_PLAYERS];

static
	GangZonePlayerCapture[MAX_PLAYERS],
	ComputerPlayerCapture[MAX_PLAYERS];

static
	Float:SpawnBasePos[MAX_PLAYERS][ROOM_MAX_TEAMS][3][3],
	Float:CapturePointPos[MAX_PLAYERS][3],
	Float:ComputerPos[MAX_PLAYERS][3],
	Float:CameraEndLocationPos[MAX_PLAYERS][4][3];

/*

	* Functions *

*/

stock Room_CreateElementsLocation(room_id)
{
	// Локации
	switch(Mode_GetLocation(MODE_ROOM, room_id)) {
		case ROOM_LOC_DESERT: Room_Desert_CreateElements(room_id);
		case ROOM_LOC_ZONE51: Room_Zone51_CreateElements(room_id);
		case ROOM_LOC_MILITARYOIL: Room_MilitOil_CreateElements(room_id);
		case ROOM_LOC_AIRPORT: Room_Airport_CreateElements(room_id);
		case ROOM_LOC_STADIUM: Room_Stadium_CreateElements(room_id);
	}

	new 
		world_id = Mode_GetVirtualWorld(MODE_ROOM, room_id),
		interior_id = Mode_GetInterior(MODE_ROOM, room_id);

	// Режим
	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_CAPTURE: Room_CreatePointFlag(room_id, world_id, interior_id);
		case ROOM_MODE_SECRET_DATA: Room_CreateComputer(room_id, world_id, interior_id);
	}
	return 1;
}

stock Room_DestroyElementsLocation(room_id)
{
	// Режим
	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_CAPTURE: Room_DestroyPointFlag(room_id);
		case ROOM_MODE_SECRET_DATA: Room_DestroyComputer(room_id);
	}

	// Счёт
	Room_ResetTeamsChet(room_id);

	// Камера в конце матча
	Room_ResetCameraEndPos(room_id);

	// Погода
	Mode_SetWeather(MODE_ROOM, room_id, 0);

	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_ROOM, room_id, Mode_GetBasicVirtualWorld(MODE_ROOM, room_id));
	Mode_SetInterior(MODE_ROOM, room_id, Mode_GetBasicInterior(MODE_ROOM, room_id));
	return 1;
}

stock Room_ShowPlElementsLocation(playerid)
{
	new 
		room_id = Mode_GetPlayerSession(playerid);

	Mode_SetPlayerVirtualWorld(playerid, MODE_ROOM, room_id);
	Mode_SetPlayerInterior(playerid, MODE_ROOM, room_id);
	Mode_SetPlayerWeather(playerid, MODE_ROOM, room_id);

	// Счёт
	if(Room_GetTeamsChet(room_id))
		Room_ShowPlayerTDTeamsChet(playerid);

	// Таймер
	Mode_CreatePlTDTimerSession(playerid);
	return 1;
}

stock Room_HidePlElementsLocation(playerid)
{
	new 
		room_id = Mode_GetPlayerSession(playerid);

	// Режим
	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_CAPTURE: {
			Room_DestroyPlayerPoint(playerid);
		}
		case ROOM_MODE_SECRET_DATA: {
			Room_DestroyPlayerComputer(playerid);
		}
	}

	// Счёт
	if(Room_GetTeamsChet(room_id))
		Room_DestroyPlayerTDTeamsChet(playerid);

	// Таймер
	Mode_DestroyPlTDTimerSession(playerid);
	return 1;
}

/*
	Point flag
*/

stock Room_CreatePointFlag(room_id, world_id, interior_id)
{
	Mode_CapturePoint[room_id][R_Color] = ROOM_TEAM_NONE;

	Mode_CapturePoint[room_id][R_Sphere] = CreateDynamicSphere(CapturePointPos[room_id][0], CapturePointPos[room_id][1], CapturePointPos[room_id][2], 10.0, world_id, interior_id);
	Mode_CapturePoint[room_id][R_MapIcon] = CreateDynamicMapIcon(CapturePointPos[room_id][0], CapturePointPos[room_id][1], CapturePointPos[room_id][2], 19, 0, world_id, interior_id, -1, 150.0);
	Mode_CapturePoint[room_id][R_ObjectPos] = CreateDynamicObject(16101, CapturePointPos[room_id][0], CapturePointPos[room_id][1], CapturePointPos[room_id][2] - 3.5, 0.00000, 0.00000, 0.00000, world_id, interior_id);
	Mode_CapturePoint[room_id][R_3DText] = CreateDynamic3DTextLabel("_", -1, CapturePointPos[room_id][0], CapturePointPos[room_id][1], CapturePointPos[room_id][2] + 1.0, 30000.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world_id, interior_id);
	return 1;
}

stock Room_DestroyPointFlag(room_id)
{
	DestroyDynamicArea(Mode_CapturePoint[room_id][R_Sphere]);
	DestroyDynamicMapIcon(Mode_CapturePoint[room_id][R_MapIcon]);
	DestroyDynamicObject(Mode_CapturePoint[room_id][R_ObjectPos]);
	DestroyDynamic3DTextLabel(Mode_CapturePoint[room_id][R_3DText]);

	if(IsValidDynamicObject(Mode_CapturePoint[room_id][R_ObjectFlag]))
		DestroyDynamicObject(Mode_CapturePoint[room_id][R_ObjectFlag]);

	Room_ResetPointFlag(room_id);
	return 1;
}

stock Room_ResetPointFlag(room_id)
{
	Mode_CapturePoint[room_id][R_Color] = ROOM_TEAM_NONE;
	Mode_CapturePoint[room_id][R_CaptureTeam] = ROOM_TEAM_NONE;
	Mode_CapturePoint[room_id][R_Red] = false;
	Mode_CapturePoint[room_id][R_Property] = ROOM_TEAM_NONE;
	Mode_CapturePoint[room_id][R_ChetBar] = 0;

	n_for(i, ROOM_MAX_TEAMS) {
		Mode_CapturePoint[room_id][R_Chet][i] =
		Mode_CapturePoint[room_id][R_MaxChet][i] = 0;
	}

	Mode_CapturePoint[room_id][R_Sphere] = INVALID_DYNAMIC_AREA_ID;
	Mode_CapturePoint[room_id][R_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
	Mode_CapturePoint[room_id][R_ObjectPos] =
	Mode_CapturePoint[room_id][R_ObjectFlag] = INVALID_DYNAMIC_OBJECT_ID;
	Mode_CapturePoint[room_id][R_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

	Room_ResetCapturePointPos(room_id);
	return 1;
}

stock Room_SetCapturePointPos(room_id, Float:X, Float:Y, Float:Z)
{
	CapturePointPos[room_id][0] = Float:X;
	CapturePointPos[room_id][1] = Float:Y;
	CapturePointPos[room_id][2] = Float:Z;
	return 1;
}

stock Room_ResetCapturePointPos(room_id)
{
	CapturePointPos[room_id][0] =
	CapturePointPos[room_id][1] =
	CapturePointPos[room_id][2] = 0.0;
	return 1;
}

stock Room_CreateObjectPointFlag(room_id)
{
	new 
		world_id = Mode_GetVirtualWorld(MODE_ROOM, room_id),
		interior_id = Mode_GetInterior(MODE_ROOM, room_id);

	if(!IsValidDynamicObject(Mode_CapturePoint[room_id][R_ObjectFlag]))
		Mode_CapturePoint[room_id][R_ObjectFlag] = CreateDynamicObject(19306, CapturePointPos[room_id][0] - 0.2 + 0.09 + 0.05, CapturePointPos[room_id][1] + 0.03, CapturePointPos[room_id][2] - 1.5, 0.00000, 0.00000, 0.00000, world_id, interior_id);
	
	Streamer_UP(MODE_ROOM, room_id);
	return 1;
}

stock Room_DestroyObjectPointFlag(room_id)
{
	if(IsValidDynamicObject(Mode_CapturePoint[room_id][R_ObjectFlag]))
		DestroyDynamicObject(Mode_CapturePoint[room_id][R_ObjectFlag]);

	return 1;
}

stock Room_MovePointFlag(room_id, type)
{
	if(!IsValidDynamicObject(Mode_CapturePoint[room_id][R_ObjectFlag]))
		return 1;

	new
		Float:X, Float:Y, Float:Z;
		
	GetDynamicObjectPos(Mode_CapturePoint[room_id][R_ObjectFlag], X, Y, Z);

	switch(type) {
		case 0: MoveDynamicObject(Mode_CapturePoint[room_id][R_ObjectFlag], X, Y, Z + 0.8, 5.0, 0.00000, 0.00000, 0.00000);
		case 1: MoveDynamicObject(Mode_CapturePoint[room_id][R_ObjectFlag], X, Y, Z - 0.8, 5.0, 0.00000, 0.00000, 0.00000);
	}
	return 1;
}

stock Room_ChangeColorPointFlag(room_id, team_id)
{
	if(IsValidDynamicObject(Mode_CapturePoint[room_id][R_ObjectFlag]))
		SetDynamicObjectMaterial(Mode_CapturePoint[room_id][R_ObjectFlag], 1, -1, "none", "none", Room_ShowTeamColorObject(team_id));
	
	return 1;
}

stock Room_CreatePlayerPoint(playerid) 
{
	new
		room_id = Mode_GetPlayerSession(playerid);

	GangZonePlayerCapture[playerid] = 0;

	GangZoneCaptureBar[playerid] = CreatePlayerProgressBar(playerid, 285.00, 279.00, 75.50, 7.19, 0xCCCCCC00, ROOM_MAX_CHET_CAPTURE.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarColour(playerid, GangZoneCaptureBar[playerid], Room_ShowTeamColorXB(Mode_CapturePoint[room_id][R_Property]));
	SetPlayerProgressBarValue(playerid, GangZoneCaptureBar[playerid], floatround(Mode_CapturePoint[room_id][R_ChetBar]));
	ShowPlayerProgressBar(playerid, GangZoneCaptureBar[playerid]);

	ShowTDGangZoneCapture(playerid);

	new 
		str[20];

	f(str, "Точка: ~y~%s", GetNamePoint(0));
	PlayerTextDrawSetString(playerid, TD_GangZone[playerid], str);
	PlayerTextDrawShow(playerid, TD_GangZone[playerid]);
	return 1;
}

static ShowTDGangZoneCapture(playerid) 
{
	TD_GangZone[playerid] = CreatePlayerTextDraw(playerid, 321.0000, 277.0000, "_"); 
	PlayerTextDrawLetterSize(playerid, TD_GangZone[playerid], 0.1576, 1.1022);
	PlayerTextDrawAlignment(playerid, TD_GangZone[playerid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_GangZone[playerid], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_GangZone[playerid], 255);
	PlayerTextDrawFont(playerid, TD_GangZone[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_GangZone[playerid], true);
	PlayerTextDrawSetShadow(playerid, TD_GangZone[playerid], 0);
	return 1;
}

stock Room_DestroyPlayerPoint(playerid) 
{
	if(GangZonePlayerCapture[playerid] > -1) {
		DestroyPlayerProgressBar(playerid, GangZoneCaptureBar[playerid]);
		DestroyPlayerTD(playerid, TD_GangZone[playerid]);

		GangZonePlayerCapture[playerid] = -1;
	}
	return 1;
}

stock Room_GetCapturePointColor(room_id)
{
	return Mode_CapturePoint[room_id][R_Color];
}

stock Room_SetCPTeamChet(room_id, team_id, num)
{
	Mode_CapturePoint[room_id][R_Chet][team_id] = num;
	return 1;
}

stock Room_GiveCPTeamChet(room_id, team_id, num)
{
	Mode_CapturePoint[room_id][R_Chet][team_id] += num;
	return 1;
}

stock Room_GetCPTeamChet(room_id, team_id)
{
	return Mode_CapturePoint[room_id][R_Chet][team_id];
}

stock Room_GiveCPPointTeam(room_id, team_id)
{
	if(Mode_CapturePoint[room_id][CP_Color] == team_id)
		Room_GiveTeamChet(team_id, 1);

	return 1;
}

stock Room_SetCPTeamMaxChet(room_id, team_id, num)
{
	if(num)
		Mode_CapturePoint[room_id][R_MaxChet][team_id] = num;
	else
		Mode_CapturePoint[room_id][R_MaxChet][team_id] = 0;
		
	return 1;
}

stock Room_GetCPTeamMaxChet(room_id, team_id)
{
	return Mode_CapturePoint[room_id][R_MaxChet][team_id];
}

stock Room_PointReInfo(room_id) 
{
	new 
		team[ROOM_MAX_TEAMS];

	foreach(new t:Room_ActiveTeams[room_id]) {
		m_for(MODE_ROOM, room_id, p) {
			if(GetPlayerSpectating(p) > -1) 
				continue;

			if(GangZonePlayerCapture[p] != 0) 
				continue;

			if(GetPlayerTeamEx(p) == t) 
				team[t]++;
		}
	}

	new 
		most_players,
		win_team = -1,
		worse_team = -1,
		bool:draw;

	foreach(new t:Room_ActiveTeams[room_id]) {
		if(team[t] > NONE) {
			if(team[t] >= most_players) {
				if(draw) 
					draw = false;

				if(team[t] == most_players) {
					if(win_team != -1)
						draw = true;
				}

				most_players = team[t];
				win_team = t;
			}
			else
				worse_team = t;
		}
	}

	if(most_players == NONE) {
		if(Mode_CapturePoint[room_id][R_Color] != ROOM_TEAM_NONE) {
			if(Mode_CapturePoint[room_id][R_Chet] < ROOM_MAX_CHET_CAPTURE) {
				Mode_CapturePoint[room_id][R_Chet]++;
				Room_MovePointFlag(room_id, 0);
			}
		}
		else {
			if(Mode_CapturePoint[room_id][R_Chet] > 0) {
				Mode_CapturePoint[room_id][R_Chet]--;
				Room_MovePointFlag(room_id, 1);
			}
			else {
				Mode_CapturePoint[room_id][R_Color] = ROOM_TEAM_NONE;
				Mode_CapturePoint[room_id][R_Property] = ROOM_TEAM_NONE;
				Room_DestroyObjectPointFlag(room_id);
			}
		}

		if(Mode_CapturePoint[room_id][R_Red]) {
			Mode_CapturePoint[room_id][R_Red] = false;
			Mode_CapturePoint[room_id][R_CaptureTeam] = ROOM_TEAM_NONE;
		}
	}
	else {
		if(draw) {
			foreach(new t:Room_ActiveTeams[room_id]) {
				if(team[t] == most_players) {
					if(t != Mode_CapturePoint[room_id][R_Color]) {
						Mode_CapturePoint[room_id][R_Red] = true;
						Mode_CapturePoint[room_id][R_CaptureTeam] = t;
						break;
					}
				}
			}
		}
		else {
			if(worse_team != -1) {
				if(worse_team != Mode_CapturePoint[room_id][R_Color]) {
					if(win_team == Mode_CapturePoint[room_id][R_Color])
						Mode_CapturePoint[room_id][R_Red] = true;
				}
			}
			if(win_team != -1) {
				if(win_team != Mode_CapturePoint[room_id][R_Color]) {
					Mode_CapturePoint[room_id][R_Red] = true;
					Mode_CapturePoint[room_id][R_CaptureTeam] = win_team;

					if(Mode_CapturePoint[room_id][R_Property] != win_team) {
						if(Mode_CapturePoint[room_id][R_Chet] > 0) {
							Mode_CapturePoint[room_id][R_Chet]--;
							Room_MovePointFlag(room_id, 1);
						}
						if(Mode_CapturePoint[room_id][R_Chet] <= 0) {
							if(Mode_CapturePoint[room_id][R_Color] != ROOM_TEAM_NONE) {
								m_for(MODE_ROOM, room_id, p) {
									if(GetPlayerSpectating(p) > -1) 
										continue;
									
									if(GangZonePlayerCapture[p]) 
										continue;
									
									if(GetPlayerTeamEx(p) != win_team) 
										continue;

									SetPlayerFee(p, 150, 50, REPLEN_CAPTURE);
									PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);
								}
							}

							Mode_CapturePoint[room_id][R_Chet] = 0;
							Mode_CapturePoint[room_id][R_Color] = ROOM_TEAM_NONE;
							Mode_CapturePoint[room_id][R_Property] = win_team;
							Room_DestroyObjectPointFlag(room_id);
						}
					}
					else {
						if(Mode_CapturePoint[room_id][R_Chet] < ROOM_MAX_CHET_CAPTURE) {
							Mode_CapturePoint[room_id][R_Chet]++;

							Room_CreateObjectPointFlag(room_id);
							Room_ChangeColorPointFlag(room_id, win_team);
							Room_MovePointFlag(room_id, 0);
				
							if(Mode_CapturePoint[room_id][R_Chet] >= ROOM_MAX_CHET_CAPTURE) {
								Mode_CapturePoint[room_id][R_Red] = false;
								Mode_CapturePoint[room_id][R_Color] = win_team;
								Mode_CapturePoint[room_id][R_CaptureTeam] = ROOM_TEAM_NONE;
								Mode_CapturePoint[room_id][R_Chet] = ROOM_MAX_CHET_CAPTURE;

								m_for(MODE_ROOM, room_id, p) {
									if(GetPlayerSpectating(p) > -1) 
										continue;
									
									if(GangZonePlayerCapture[p] != 0) 
										continue;
									
									if(GetPlayerTeamEx(p) != win_team) 
										continue;

									SetPlayerFee(p, 400, 250, REPLEN_CAPTURE);
									PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);

									Dina_CheckPlayerHint(p, 13);
								}
							}
						}
					}
				}
				else {
					if(Mode_CapturePoint[room_id][R_Chet] < ROOM_MAX_CHET_CAPTURE) {
						Mode_CapturePoint[room_id][R_Chet]++;
						Room_MovePointFlag(room_id, 0);
					}
					if(worse_team == -1) {
						if(Mode_CapturePoint[room_id][R_Red]) {
							Mode_CapturePoint[room_id][R_Red] = false;
							Mode_CapturePoint[room_id][R_CaptureTeam] = ROOM_TEAM_NONE;
						}
					}
				}
			}
		}
	}

	new 
		str[130];

	if(!Mode_CapturePoint[room_id][R_Red])
		f(str, "%s[ Точка %s ]", Room_ShowTeamColor(Mode_CapturePoint[room_id][R_Color]), GetNamePoint(0));
	else
		f(str, "%s[ Точка %s ]\n\n{D53032}Захватывают %s%s", Room_ShowTeamColor(Mode_CapturePoint[room_id][R_Color]), GetNamePoint(0), Room_ShowTeamColor(Mode_CapturePoint[room_id][R_CaptureTeam]), Room_GetTeamName(Mode_CapturePoint[room_id][R_CaptureTeam]));
	
	UpdateDynamic3DTextLabelText(Mode_CapturePoint[room_id][R_3DText], 0x000000FF, str);

	m_for(MODE_ROOM, room_id, p) {
		if(!GangZonePlayerCapture[p]) {
			SetPlayerProgressBarColour(p, GangZoneCaptureBar[p], Room_ShowTeamColorXB(Mode_CapturePoint[room_id][R_Property]));
			SetPlayerProgressBarValue(p, GangZoneCaptureBar[p], floatround(Mode_CapturePoint[room_id][R_Chet]));
		}
	}
	return 1;
}

/*
	Computer
*/

stock Room_CreateComputer(room_id, world_id, interior_id)
{
	Mode_Computer[room_id][R_ProtectTeam] = ROOM_TEAM_ALPHA;
	Mode_Computer[room_id][R_Status] = ROOM_TEAM_ALPHA;
	Mode_Computer[room_id][R_PlayerID] = -1;

	Mode_Computer[room_id][R_MapIcon] = CreateDynamicMapIcon(ComputerPos[room_id][0], ComputerPos[room_id][1], ComputerPos[room_id][2], 16, 0, world_id, interior_id, -1, 150.0);
	Mode_Computer[room_id][R_ObjectComputer] = CreateDynamicObject(3388, ComputerPos[room_id][0] - 0.1, ComputerPos[room_id][1], ComputerPos[room_id][2] - 1.7, 0.00000, 0.00000, 0.00000, world_id, interior_id);
	Mode_Computer[room_id][R_3DText] = CreateDynamic3DTextLabel("_", -1, ComputerPos[room_id][0], ComputerPos[room_id][1], ComputerPos[room_id][2] + 2.0, 400.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, world_id, interior_id);
	Mode_Computer[room_id][R_3DTextClick] = CreateDynamic3DTextLabel("{10B3EA}Компьютер\n\n{D42C21}Нажмите {E5D110}[ ALT ]", -1, ComputerPos[room_id][0] - 1.2, ComputerPos[room_id][1], ComputerPos[room_id][2], 13.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, world_id, interior_id);
	return 1;
}

stock Room_DestroyComputer(room_id)
{
	DestroyDynamicMapIcon(Mode_Computer[room_id][R_MapIcon]);
	DestroyDynamicObject(Mode_Computer[room_id][R_ObjectComputer]);
	DestroyDynamic3DTextLabel(Mode_Computer[room_id][R_3DText]);
	DestroyDynamic3DTextLabel(Mode_Computer[room_id][R_3DTextClick]);

	Room_ResetComputer(room_id);
	return 1;
}

stock Room_ResetComputer(room_id)
{
	Mode_Computer[room_id][R_ActionCapture] =
	Mode_Computer[room_id][R_Red] = false;
	Mode_Computer[room_id][R_Status] =
	Mode_Computer[room_id][R_ChetBar] =
	Mode_Computer[room_id][R_Timer] = 0;
	Mode_Computer[room_id][R_ProtectTeam] = ROOM_TEAM_NONE;
	Mode_Computer[room_id][R_PlayerID] = -1;

	n_for(i, ROOM_MAX_TEAMS) {
		Mode_Computer[room_id][R_Chet][i] =
		Mode_Computer[room_id][R_MaxChet][i] = 0;
	}

	Mode_Computer[room_id][R_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
	Mode_Computer[room_id][R_ObjectComputer] = INVALID_DYNAMIC_OBJECT_ID;

	Mode_Computer[room_id][R_3DText] =
	Mode_Computer[room_id][R_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;

	Room_ResetComputerPos(room_id);
	return 1;
}

stock Room_SetComputerPos(room_id, Float:X, Float:Y, Float:Z)
{
	ComputerPos[room_id][0] = Float:X;
	ComputerPos[room_id][1] = Float:Y;
	ComputerPos[room_id][2] = Float:Z;
	return 1;
}

stock Room_ResetComputerPos(room_id)
{
	ComputerPos[room_id][0] =
	ComputerPos[room_id][1] =
	ComputerPos[room_id][2] = 0.0;
	return 1;
}

stock Room_CreatePlayerComputer(playerid) 
{
	new
		room_id = M_GPS(playerid);

	Mode_Computer[room_id][R_Red] = true;
	Mode_Computer[room_id][R_PlayerID] = playerid;
	ComputerPlayerCapture[playerid] = 0;

	if(Mode_Computer[room_id][R_ProtectTeam] != GetPlayerTeamEx(playerid))
		Mode_Computer[room_id][R_ChetBar] = 0;
	else 
		Mode_Computer[room_id][R_ChetBar] = ROOM_MAX_CHET_COMPUTER;

	new
		str[100];

	ShowTDHackComputer(playerid);

	f(str, "%s ~w~- Компьютер: ~y~%i", Room_GetTeamName(Mode_Computer[room_id][R_ProtectTeam]), 1);
	PlayerTextDrawColour(playerid, TD_ComputerHack[playerid], Room_ShowTeamColorXB(Mode_Computer[room_id][R_ProtectTeam]));
	PlayerTextDrawSetString(playerid, TD_ComputerHack[playerid], str);
	PlayerTextDrawShow(playerid, TD_ComputerHack[playerid]);

	ComputerCaptureBar[playerid] = CreatePlayerProgressBar(playerid, 281.00, 250.00, 84.50, 7.19, 0xC7DBFFAA, 10.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarValue(playerid, ComputerCaptureBar[playerid], floatround(Mode_Computer[room_id][R_ChetBar]));
	ShowPlayerProgressBar(playerid, ComputerCaptureBar[playerid]);
	return 1;
}

static ShowTDHackComputer(playerid) 
{
	TD_ComputerHack[playerid] = CreatePlayerTextDraw(playerid, 321.000000, 241.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_ComputerHack[playerid], 0.136333, 0.840887);
	PlayerTextDrawAlignment(playerid, TD_ComputerHack[playerid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_ComputerHack[playerid], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_ComputerHack[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TD_ComputerHack[playerid], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_ComputerHack[playerid], 255);
	PlayerTextDrawFont(playerid, TD_ComputerHack[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_ComputerHack[playerid], true);
	return 1;
}

stock Room_DestroyPlayerComputer(playerid) 
{
	new
		room_id = Mode_GetPlayerSession(playerid);

	if(ComputerPlayerCapture[playerid] > -1) {
		Mode_Computer[room_id][R_Red] = false;
		Mode_Computer[room_id][R_PlayerID] = -1;

		DestroyPlayerProgressBar(playerid, ComputerCaptureBar[playerid]);
		DestroyPlayerTD(playerid, TD_ComputerHack[playerid]);

		ComputerPlayerCapture[playerid] = -1;

		if(Mode_Computer[room_id][R_ProtectTeam] != GetPlayerTeamEx(playerid))
			Mode_Computer[room_id][R_ChetBar] = 0;
		else 
			Mode_Computer[room_id][R_ChetBar] = ROOM_MAX_CHET_COMPUTER;
	}
	return 1;
}

stock Room_GetComputerProtectTeam(room_id)
{
	return Mode_Computer[room_id][R_ProtectTeam];
}

stock Room_SetCompTeamChet(room_id, team_id, num)
{
	Mode_Computer[room_id][R_Chet][team_id] = num;
	return 1;
}

stock Room_GiveCompTeamChet(room_id, team_id, num)
{
	Mode_Computer[room_id][R_Chet][team_id] += num;
	return 1;
}

stock Room_GetCompTeamChet(room_id, team_id)
{
	return Mode_Computer[room_id][R_Chet][team_id];
}

stock Room_SetCompTeamMaxChet(room_id, team_id, num)
{
	if(num)
		Mode_Computer[room_id][R_MaxChet][team_id] = num;
	else
		Mode_Computer[room_id][R_MaxChet][team_id] = 0;
		
	return 1;
}

stock Room_GetCompTeamMaxChet(room_id, team_id)
{
	return Mode_Computer[room_id][R_MaxChet][team_id];
}

stock Room_ComputerReInfo(room_id)
{
	new 
		team = Mode_Computer[room_id][R_ProtectTeam];

	if(!Mode_Computer[room_id][R_ActionCapture]) {
		if(Mode_Computer[room_id][R_Status] != team) {
			if(Mode_Computer[room_id][R_Timer] > 0) {
				Mode_Computer[room_id][R_Timer]--;

				if(Mode_Computer[room_id][R_Timer] <= 0) {
					Mode_Computer[room_id][R_Chet][team]++;

					new 
						player = Mode_Computer[room_id][R_PlayerID];

					if(player > -1) {
						if(ComputerPlayerCapture[player] == 0)
							Room_DestroyPlayerComputer(player);
					}
					Mode_Computer[room_id][R_Timer] = 0;
					Mode_Computer[room_id][R_ActionCapture] = true;
					Mode_Computer[room_id][R_Red] = false;
					Mode_Computer[room_id][R_PlayerID] = -1;
				}
			}
		}
	
		new 
			string[100];

		if(Mode_Computer[room_id][R_Status] != Mode_Computer[room_id][R_ProtectTeam]) {
			f(string, "Компьютер взламывается\nВремя: %i\n\n{FFFFFF}[%s%s{FFFFFF}]", Mode_Computer[room_id][R_Timer], Room_ShowTeamColor(team), Room_GetTeamName(team));
			UpdateDynamic3DTextLabelText(Mode_Computer[room_id][R_3DText], 0xDE2B2BFF, string);
		}
		else {
			f(string, "Компьютер не взломан\n\n{FFFFFF}[%s%s{FFFFFF}]", Room_ShowTeamColor(team), Room_GetTeamName(team));
			UpdateDynamic3DTextLabelText(Mode_Computer[room_id][R_3DText], 0x3CDB39FF, string);
		}
	}
	else {
		new 
			string[100];

		f(string, "Компьютер взломан\n\n{FFFFFF}[%s%s{FFFFFF}]", Room_ShowTeamColor(team), Room_GetTeamName(team));
		UpdateDynamic3DTextLabelText(Mode_Computer[room_id][R_3DText], 0xDE2B2BFF, string);
	}
	return 1;
}

stock Room_UpdatePlayerComputer(playerid)
{
	if(ComputerPlayerCapture[playerid] > -1) {
	    new 
			room_id = Mode_GetPlayerSession(playerid);

		if(IsPlayerInRangeOfPoint(playerid, 1.3, ComputerPos[room_id][0], ComputerPos[room_id][1], ComputerPos[room_id][2])) {
		    if(GetPlayerTeamEx(playerid) != Mode_Computer[room_id][R_ProtectTeam]) {
		        if(Mode_Computer[room_id][R_ChetBar] < ROOM_MAX_CHET_COMPUTER) {
					Mode_Computer[room_id][R_ChetBar]++;
					SetPlayerProgressBarValue(playerid, ComputerCaptureBar[playerid], floatround(Mode_Computer[room_id][R_ChetBar]));

					if(Mode_Computer[room_id][R_ChetBar] >= ROOM_MAX_CHET_COMPUTER) {
						Room_DestroyPlayerComputer(playerid);

						Mode_Computer[room_id][R_ChetBar] = ROOM_MAX_CHET_COMPUTER;
						Mode_Computer[room_id][R_Status] = GetPlayerTeamEx(playerid);
						Mode_Computer[room_id][R_Timer] = ROOM_MAX_COMPUTER_TIMER;
						Mode_Computer[room_id][R_Red] = false;
						Mode_Computer[room_id][R_PlayerID] = -1;

						SetPlayerFee(playerid, 300, 200, REPLEN_HACK);
						PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

						Dina_CheckPlayerHint(playerid, 14);

						m_for(MODE_ROOM, room_id, p) {
							if(GetPlayerTeamEx(p) != Mode_Computer[room_id][R_ProtectTeam]) continue;

							new 
								str[150];

							f(str, "{E61414}(Взлом) {FFFFFF}Компьютер {FFFFFF}взломали, деактивируйте взлом!");
							SCM(p, -1, str);
						}
					}
				}
			}
		    else {
		        if(Mode_Computer[room_id][R_ChetBar] > 0) {
					Mode_Computer[room_id][R_ChetBar]--;
					SetPlayerProgressBarValue(playerid, ComputerCaptureBar[playerid], floatround(Mode_Computer[room_id][R_ChetBar]));

					if(Mode_Computer[room_id][R_ChetBar] <= 0) {
						Room_DestroyPlayerComputer(playerid);

						Mode_Computer[room_id][R_ChetBar] = 0;
						Mode_Computer[room_id][R_Status] = GetPlayerTeamEx(playerid);
						Mode_Computer[room_id][R_Timer] = 0;
						Mode_Computer[room_id][R_Red] = false;
						Mode_Computer[room_id][R_PlayerID] = -1;

						SetPlayerFee(playerid, 300, 200, REPLEN_HACK);
						PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

						m_for(MODE_ROOM, room_id, p) {
							if(GetPlayerTeamEx(p) == Mode_Computer[room_id][R_ProtectTeam]) continue;

							new 
								str[150];

							f(str, "{E61414}(Взлом) {FFFFFF}Взлом компьютера {FFFFFF}деактивировали!");
							SCM(p, -1, str);
						}
					}
				}
			}
		}
		else {
		    Mode_Computer[room_id][R_Red] = false;
		    Mode_Computer[room_id][R_PlayerID] = -1;

			Room_DestroyPlayerComputer(playerid);
		}
	}
	return 1;
}

/*
	Battle
*/

stock Room_SetBattleTeamChet(room_id, team_id, num)
{
	Mode_Battle[room_id][R_Chet][team_id] = num;
	return 1;
}

stock Room_GiveBattleTeamChet(room_id, team_id, num)
{
	Mode_Battle[room_id][R_Chet][team_id] += num;
	return 1;
}

stock Room_GetBattleTeamChet(room_id, team_id)
{
	return Mode_Battle[room_id][R_Chet][team_id];
}

stock Room_SetBattleTeamMaxChet(room_id, team_id, num)
{
	if(num)
		Mode_Battle[room_id][R_MaxChet][team_id] = num;
	else
		Mode_Battle[room_id][R_MaxChet][team_id] = 0;
		
	return 1;
}

stock Room_GetBattleTeamMaxChet(room_id, team_id)
{
	return Mode_Battle[room_id][R_MaxChet][team_id];
}

/*
	Camera end match
*/

stock Room_ShowCameraEndLocation(playerid)
{
	new
		room_id = Mode_GetPlayerSession(playerid);

	InterpolateCameraPos(playerid, CameraEndLocationPos[room_id][0][0], CameraEndLocationPos[room_id][0][1], CameraEndLocationPos[room_id][0][2], CameraEndLocationPos[room_id][1][0], CameraEndLocationPos[room_id][1][1], CameraEndLocationPos[room_id][1][2], 5000);
	InterpolateCameraLookAt(playerid, CameraEndLocationPos[room_id][2][0], CameraEndLocationPos[room_id][2][1], CameraEndLocationPos[room_id][2][2], CameraEndLocationPos[room_id][3][0], CameraEndLocationPos[room_id][3][1], CameraEndLocationPos[room_id][3][2], 5000);
	return 1;
}

stock Room_SetCameraEndPos(room_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraPos от и до
	CameraEndLocationPos[room_id][0][0] = X;
	CameraEndLocationPos[room_id][0][1] = Y;
	CameraEndLocationPos[room_id][0][2] = Z;

	CameraEndLocationPos[room_id][2][0] = X2;
	CameraEndLocationPos[room_id][2][1] = Y2;
	CameraEndLocationPos[room_id][2][2] = Z2;
	return 1;
}

stock Room_SetCameraEndLookAt(room_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraLookAt от и до
	CameraEndLocationPos[room_id][1][0] = X;
	CameraEndLocationPos[room_id][1][1] = Y;
	CameraEndLocationPos[room_id][1][2] = Z;

	CameraEndLocationPos[room_id][3][0] = X2;
	CameraEndLocationPos[room_id][3][1] = Y2;
	CameraEndLocationPos[room_id][3][2] = Z2;
	return 1;
}

stock Room_ResetCameraEndPos(room_id)
{
	n_for(i, sizeof(CameraEndLocationPos[])) {
		CameraEndLocationPos[room_id][i][0] =
		CameraEndLocationPos[room_id][i][1] =
		CameraEndLocationPos[room_id][i][2] = 0.0;
	}
	return 1;
}

/*
	Team
*/

stock Room_AddTeam(room_id, team_id, bool:chet)
{
	Iter_Add(Room_ActiveTeams[room_id], team_id);

	if(chet)
		Iter_Add(Room_ActiveTeamsChet[room_id], team_id);

	return 1;
}

stock Room_RemoveTeam(room_id, team_id)
{
	if(team_id != -1) {
		Iter_Remove(Room_ActiveTeams[room_id], team_id);

		if(Iter_Contains(Room_ActiveTeamsChet[room_id], team_id))
			Iter_Remove(Room_ActiveTeamsChet[room_id], team_id);
	}
	else {
		Iter_Clear(Room_ActiveTeams[room_id]);

		if(Iter_Count(Room_ActiveTeamsChet[room_id]))
			Iter_Clear(Room_ActiveTeamsChet[room_id]);
	}
	return 1;
}

stock Room_CheckTeam(room_id, team_id)
{
	return Iter_Contains(Room_ActiveTeams[room_id], team_id);
}

stock Room_CheckTeamChet(room_id, team_id)
{
	return Iter_Contains(Room_ActiveTeamsChet[room_id], team_id);
}

stock Room_GetActiveTeams(room_id)
{
	return Iter_Count(Room_ActiveTeamsChet[room_id]);
}

/*
	Счёт команды
*/

stock Room_SetTeamChet(room_id, team_id, chet, maxchet)
{
	if(!ActiveTeamChet[room_id])
		ActiveTeamChet[room_id] = true;

	Room_SetTeamModeChet(room_id, team_id, chet);
	Room_SetTeamModeMaxChet(room_id, team_id, maxchet);
	return 1;
}

stock Room_ResetTeamsChet(room_id)
{
	ActiveTeamChet[room_id] = false;

	foreach(new t:Room_ActiveTeams[room_id]) {
		Room_SetTeamModeMaxChet(room_id, t, 0);
		Room_SetTeamModeChet(room_id, t, 0);
	}
	return 1;
}

stock Room_GetTeamsChet(room_id)
{
	return ActiveTeamChet[room_id];
}

/*
	Спавн
*/

stock Room_SetSpawnBasePos(room_id, team_id, cell, Float:X, Float:Y, Float:Z)
{
	SpawnBasePos[room_id][team_id][cell][0] = X;
	SpawnBasePos[room_id][team_id][cell][1] = Y;
	SpawnBasePos[room_id][team_id][cell][2] = Z;
	return 1;
}

stock Room_GetSpawnBasePos(room_id, team_id, cell, &Float:X, &Float:Y, &Float:Z)
{
	X = SpawnBasePos[room_id][team_id][cell][0];
	Y = SpawnBasePos[room_id][team_id][cell][1];
	Z = SpawnBasePos[room_id][team_id][cell][2];
	return 1;
}

static ResetSpawnBasePos(room_id)
{
	n_for(i, ROOM_MAX_TEAMS) {
		n_for2(b, 3) {
			SpawnBasePos[room_id][i][b][0] =
			SpawnBasePos[room_id][i][b][1] =
			SpawnBasePos[room_id][i][b][2] = 0.0;
		}
	}
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerData(playerid)
{
	GangZonePlayerCapture[playerid] =
	ComputerPlayerCapture[playerid] = -1;
	return 1;
}

/*

	* Callbacks *

*/

/*
    OnGameModeInit
*/

stock Room_LocOnGameModeInit(room_id)
{
	ResetSpawnBasePos(room_id);

	Room_ResetPointFlag(room_id);
	Room_ResetCapturePointPos(room_id);

	Room_ResetComputer(room_id);
	Room_ResetComputerPos(room_id);

	Room_ResetCameraEndPos(room_id);
	return 1;
}

/*
    OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);

	#if defined Room_LocOnPlayerConnect
		return Room_LocOnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
    OnPlayerEnterDynamicArea
*/

stock Room_LocOnPlEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) 
{
	if(GetPlayerBusy(playerid) != GAME)
		return 0;

	if(GetPlayerSpectating(playerid) > -1)
		return 0;

	if(GetPlayerDead(playerid))
		return 0;

	new
		room_id = Mode_GetPlayerSession(playerid);

	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_CAPTURE: {
			if(GangZonePlayerCapture[playerid] == -1) {
				if(areaid == Mode_CapturePoint[room_id][R_Sphere]) {
					Room_CreatePlayerPoint(playerid);
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
    OnPlayerLeaveDynamicArea
*/

stock Room_LocOnPlLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)  
{
	if(GetPlayerBusy(playerid) != GAME)
		return 0;

	if(GetPlayerSpectating(playerid) > -1)
		return 0;

	new
		room_id = Mode_GetPlayerSession(playerid);
		
	if(areaid == Mode_CapturePoint[room_id][R_Sphere]) {
		if(GangZonePlayerCapture[playerid] > -1)
			Room_DestroyPlayerPoint(playerid);

		return 1;
	}
	return 0;
}

/*
    OnPlayerKeyStateChange
*/

stock Room_LocOnPlKeyStateChange(playerid, newkeys, oldkeys)
{
	#pragma unused oldkeys

	// ALT
	if(newkeys & KEY_WALK) {
		new 
			room_id = Mode_GetPlayerSession(playerid);

		switch(Room_GetMode(room_id)) {
			case ROOM_MODE_SECRET_DATA: {
				if(IsPlayerInRangeOfPoint(playerid, 1.3, ComputerPos[room_id][0], ComputerPos[room_id][1], ComputerPos[room_id][2])) {
					if(GetPlayerTeamEx(playerid) != Mode_Computer[room_id][R_Status]) {
						if(!Mode_Computer[room_id][R_ActionCapture]) {
							if(!Mode_Computer[room_id][R_Red]) {
								Room_CreatePlayerComputer(playerid);
							}
						}
					}
					else {
						if(!Mode_Computer[room_id][R_ActionCapture]) {
							if(GetPlayerTeamEx(playerid) == Mode_Computer[room_id][R_ProtectTeam])
								SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Вы должны защищать компьютер!");
						}
					}
					return 1;
				}
			}
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
#define OnPlayerConnect Room_LocOnPlayerConnect
#if defined Room_LocOnPlayerConnect
	forward Room_LocOnPlayerConnect(playerid);
#endif