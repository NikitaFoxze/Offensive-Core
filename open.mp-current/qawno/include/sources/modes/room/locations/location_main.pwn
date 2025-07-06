/*
 * |>=============================<|
 * |   About: Room location main   |
 * |   Author: Foxze               |
 * |>=============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnPlayerConnect(playerid)
	- OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
 * Stock:
	- Room_InitialLocations()

	- Room_CreateElementsLocation(roomid)
	- Room_DestroyElementsLocation(roomid)
	- Room_ShowPlElementsLocation(playerid)
	- Room_HidePlElementsLocation(playerid)

	- Room_CreatePointFlag(roomid, worldid, interiorid)
	- Room_DestroyPointFlag(roomid)
	- Room_ResetPointFlag(roomid)

	- Room_SetCapturePointPos(roomid, Float:X, Float:Y, Float:Z)
	- Room_ResetCapturePointPos(roomid)
	- Room_MovePointFlag(roomid, type)
	- Room_ChangeColorPointFlag(roomid, teamid)
	- Room_CreatePlayerPoint(playerid) 
	- Room_DestroyPlayerPoint(playerid)
	- Room_GetCapturePointColor(roomid)
	- Room_CreateObjectPointFlag(roomid)
	- Room_DestroyObjectPointFlag(roomid)

	- Room_SetCPTeamScore(roomid, teamid, num)
	- Room_GiveCPTeamScore(roomid, teamid, num)
	- Room_GetCPTeamScore(roomid, teamid)
	- Room_GiveCPPointTeam(roomid, teamid)
	- Room_SetCPTeamMaxScore(roomid, teamid, num)
	- Room_GetCPTeamMaxScore(roomid, teamid)
	- Room_PointReInfo(roomid)

	- Room_CreateComputer(roomid, worldid, interiorid)
	- Room_DestroyComputer(roomid)
	- Room_ResetComputer(roomid)
	- Room_SetComputerPos(roomid, Float:X, Float:Y, Float:Z)
	- Room_ResetComputerPos(roomid)
	- Room_GetComputerProtectTeam(roomid)
	- Room_CreatePlayerComputer(playerid)
	- Room_DestroyPlayerComputer(playerid)
	- Room_UpdatePlayerComputer(playerid)

	- Room_SetCompTeamScore(roomid, teamid, num)
	- Room_GiveCompTeamScore(roomid, teamid, num)
	- Room_GetCompTeamScore(roomid, teamid)
	- Room_SetCompTeamMaxScore(roomid, teamid, num)
	- Room_GetCompTeamMaxScore(roomid, teamid)
	- Room_ComputerReInfo(roomid)

	- Room_SetBattleTeamScore(roomid, teamid, num)
	- Room_GiveBattleTeamScore(roomid, teamid, num)
	- Room_GetBattleTeamScore(roomid, teamid)
	- Room_SetBattleTeamMaxScore(roomid, teamid, num)
	- Room_GetBattleTeamMaxScore(roomid, teamid)

	- Room_ShowCameraEndLocation(playerid)
	- Room_SetCameraEndPos(roomid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
	- Room_SetCameraEndLookAt(roomid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
	- Room_ResetCameraEndPos(roomid)

	- Room_AddTeam(roomid, teamid, bool:score)
	- Room_RemoveTeam(roomid, teamid)
	- Room_CheckTeam(roomid, teamid)
	- Room_CheckTeamScore(roomid, teamid)
	- Room_GetActiveTeams(roomid)

	- Room_SetTeamScore(roomid, teamid, score, maxscore)
	- Room_ResetTeamsScore(roomid)
	- Room_GetTeamsScore(roomid)

	- Room_SetSpawnBasePos(roomid, teamid, cell, Float:X, Float:Y, Float:Z)
	- Room_GetSpawnBasePos(roomid, teamid, cell, &Float:X, &Float:Y, &Float:Z)

	# Technical #
	- Room_LocResetSessionData(roomid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_ROOM_BATTLE_INFO
	- E_ROOM_CAPTURE_POINT_INFO
	- E_ROOM_COMPUTER_INFO
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

#if defined _INC_ROOM_LOC_MAIN
	#endinput
#endif
#define _INC_ROOM_LOC_MAIN

/*
 * |>-----------------<|
 * |     Locations     |
 * |>-----------------<|
 */

#include <sources/modes/room/locations/desert/desert.pwn>
#include <sources/modes/room/locations/zone51/zone51.pwn>
#include <sources/modes/room/locations/military-oil/military-oil.pwn>
#include <sources/modes/room/locations/airport/airport.pwn>
#include <sources/modes/room/locations/stadium/stadium.pwn>

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_ROOM_BATTLE_INFO {
	e_Score[ROOM_MAX_TEAMS],
	e_MaxScore[ROOM_MAX_TEAMS]
}

enum E_ROOM_CAPTURE_POINT_INFO {
	e_ObjectPos,
	e_ObjectFlag,
	e_Sphere,
	e_MapIcon,
	Text3D:e_3DText,
	e_Color,
	bool:e_Red,
	e_ScoreBar,
	e_CaptureTeam,
	e_Property,
	e_Score[ROOM_MAX_TEAMS],
	e_MaxScore[ROOM_MAX_TEAMS]
}

enum E_ROOM_COMPUTER_INFO {
	e_ObjectComputer,
	bool:e_ActionCapture,
    bool:e_Red,
	e_Status,
	e_ScoreBar,
	e_Timer,
	e_MapIcon,
	Text3D:e_3DText,
	Text3D:e_3DTextClick,
	e_ProtectTeam,
	e_PlayerID,
	e_Score[ROOM_MAX_TEAMS],
	e_MaxScore[ROOM_MAX_TEAMS]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	ModeBattle[GMS_MAX_SESSIONS][E_ROOM_BATTLE_INFO],
	ModeCapturePoint[GMS_MAX_SESSIONS][E_ROOM_CAPTURE_POINT_INFO],
	ModeComputer[GMS_MAX_SESSIONS][E_ROOM_COMPUTER_INFO];

static
	bool:ActiveTeamScore[GMS_MAX_SESSIONS];

static
	PlayerActivePointCapture[MAX_PLAYERS],
	PlayerActiveComputerCapture[MAX_PLAYERS];

static
	PlayerBar:PlayerBarPointCapture[MAX_PLAYERS],
	PlayerBar:PlayerBarComputerCapture[MAX_PLAYERS];

static
	PlayerText:TD_CapturePoint[MAX_PLAYERS] = {INVALID_PLAYER_TEXT_DRAW, ...},
	PlayerText:TD_HackComputer[MAX_PLAYERS] = {INVALID_PLAYER_TEXT_DRAW, ...};

static
	Float:SpawnBaseTeamPos[GMS_MAX_SESSIONS][ROOM_MAX_TEAMS][3][3],
	Float:CapturePointPos[GMS_MAX_SESSIONS][3],
	Float:ComputerPos[GMS_MAX_SESSIONS][3],
	Float:CameraEndLocationPos[GMS_MAX_SESSIONS][4][3];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>----------------------------<|
 * |   Initialization locations   |
 * |>----------------------------<|
 */

stock Room_InitialLocations()
{
	Room_Desert_Init();
	Room_Zone51_Init();
	Room_MilitOil_Init();
	Room_Airport_Init();
	Room_Stadium_Init();
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Location create & destroy   |
 * |>-----------------------------<|
 */

stock Room_CreateElementsLocation(roomid)
{
	// Locations
	switch (Mode_GetSessionLocation(MODE_ROOM, roomid)) {
		case ROOM_LOC_DESERT: Room_Desert_CreateElements(roomid);
		case ROOM_LOC_ZONE51: Room_Zone51_CreateElements(roomid);
		case ROOM_LOC_MILITARYOIL: Room_MilitOil_CreateElements(roomid);
		case ROOM_LOC_AIRPORT: Room_Airport_CreateElements(roomid);
		case ROOM_LOC_STADIUM: Room_Stadium_CreateElements(roomid);
	}

	new 
		worldid = Mode_GetSessionVirtualWorld(MODE_ROOM, roomid),
		interiorid = Mode_GetSessionInterior(MODE_ROOM, roomid);

	// Game-mode
	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_CAPTURE: Room_CreatePointFlag(roomid, worldid, interiorid);
		case ROOM_GAME_MODE_DATA: Room_CreateComputer(roomid, worldid, interiorid);
	}
	return 1;
}

stock Room_DestroyElementsLocation(roomid)
{
	// Game-mode
	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_CAPTURE: Room_DestroyPointFlag(roomid);
		case ROOM_GAME_MODE_DATA: Room_DestroyComputer(roomid);
	}

	// Score
	Room_ResetTeamsScore(roomid);

	// Camera end match
	Room_ResetCameraEndPos(roomid);
	return 1;
}

stock Room_ShowPlElementsLocation(playerid)
{
	new 
		roomid = Mode_GetPlayerSession(playerid);

	Mode_SetPlayerVirtualWorld(playerid, MODE_ROOM, roomid);
	Mode_SetPlayerInterior(playerid, MODE_ROOM, roomid);
	Mode_SetPlayerWeather(playerid, MODE_ROOM, roomid);

	// Score
	if (Room_GetTeamsScore(roomid)) {
		Room_ShowPlayerTeamsScoreTD(playerid);
	}

	// Timer
	Mode_ShowPlSessionTimerTD(playerid);
	return 1;
}

stock Room_HidePlElementsLocation(playerid)
{
	new 
		roomid = Mode_GetPlayerSession(playerid);

	// Game-mode
	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_CAPTURE: {
			Room_DestroyPlayerPoint(playerid);
		}
		case ROOM_GAME_MODE_DATA: {
			Room_DestroyPlayerComputer(playerid);
		}
	}

	// Score
	if (Room_GetTeamsScore(roomid)) {
		Room_HidePlayerTeamsScoreTD(playerid);
	}
	return 1;
}

/*
 * |>--------------<|
 * |   Point flag   |
 * |>--------------<|
 */

stock Room_CreatePointFlag(roomid, worldid, interiorid)
{
	ModeCapturePoint[roomid][e_Color] = ROOM_TEAM_NONE;

	ModeCapturePoint[roomid][e_Sphere] = CreateDynamicSphere(CapturePointPos[roomid][0], CapturePointPos[roomid][1], CapturePointPos[roomid][2], 10.0, worldid, interiorid);
	ModeCapturePoint[roomid][e_MapIcon] = CreateDynamicMapIcon(CapturePointPos[roomid][0], CapturePointPos[roomid][1], CapturePointPos[roomid][2], 19, 0, worldid, interiorid, -1, 150.0);
	ModeCapturePoint[roomid][e_ObjectPos] = CreateDynamicObject(16101, CapturePointPos[roomid][0], CapturePointPos[roomid][1], CapturePointPos[roomid][2] - 3.5, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ModeCapturePoint[roomid][e_3DText] = CreateDynamic3DTextLabel("_", -1, CapturePointPos[roomid][0], CapturePointPos[roomid][1], CapturePointPos[roomid][2] + 1.0, 30000.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, worldid, interiorid);
	return 1;
}

stock Room_DestroyPointFlag(roomid)
{
	DestroyDynamicArea(ModeCapturePoint[roomid][e_Sphere]);
	DestroyDynamicMapIcon(ModeCapturePoint[roomid][e_MapIcon]);
	DestroyDynamicObject(ModeCapturePoint[roomid][e_ObjectPos]);
	DestroyDynamic3DTextLabel(ModeCapturePoint[roomid][e_3DText]);

	if (IsValidDynamicObject(ModeCapturePoint[roomid][e_ObjectFlag])) {
		DestroyDynamicObject(ModeCapturePoint[roomid][e_ObjectFlag]);
	}

	Room_ResetPointFlag(roomid);
	return 1;
}

stock Room_ResetPointFlag(roomid)
{
	ModeCapturePoint[roomid][e_Color] = ROOM_TEAM_NONE;
	ModeCapturePoint[roomid][e_CaptureTeam] = ROOM_TEAM_NONE;
	ModeCapturePoint[roomid][e_Red] = false;
	ModeCapturePoint[roomid][e_Property] = ROOM_TEAM_NONE;
	ModeCapturePoint[roomid][e_ScoreBar] = 0;

	n_for(i, ROOM_MAX_TEAMS) {
		ModeCapturePoint[roomid][e_Score][i] =
		ModeCapturePoint[roomid][e_MaxScore][i] = 0;
	}

	ModeCapturePoint[roomid][e_Sphere] = INVALID_DYNAMIC_AREA_ID;
	ModeCapturePoint[roomid][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
	ModeCapturePoint[roomid][e_ObjectPos] =
	ModeCapturePoint[roomid][e_ObjectFlag] = INVALID_DYNAMIC_OBJECT_ID;
	ModeCapturePoint[roomid][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

	Room_ResetCapturePointPos(roomid);
	return 1;
}

stock Room_SetCapturePointPos(roomid, Float:X, Float:Y, Float:Z)
{
	CapturePointPos[roomid][0] = X;
	CapturePointPos[roomid][1] = Y;
	CapturePointPos[roomid][2] = Z;
	return 1;
}

stock Room_ResetCapturePointPos(roomid)
{
	CapturePointPos[roomid][0] =
	CapturePointPos[roomid][1] =
	CapturePointPos[roomid][2] = 0.0;
	return 1;
}

stock Room_CreateObjectPointFlag(roomid)
{
	new 
		worldid = Mode_GetSessionVirtualWorld(MODE_ROOM, roomid),
		interiorid = Mode_GetSessionInterior(MODE_ROOM, roomid);

	if (!IsValidDynamicObject(ModeCapturePoint[roomid][e_ObjectFlag])) {
		ModeCapturePoint[roomid][e_ObjectFlag] = CreateDynamicObject(19306, CapturePointPos[roomid][0] - 0.2 + 0.09 + 0.05, CapturePointPos[roomid][1] + 0.03, CapturePointPos[roomid][2] - 1.5, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	}

	Mode_StreamerUpdate(MODE_ROOM, roomid);
	return 1;
}

stock Room_DestroyObjectPointFlag(roomid)
{
	if (IsValidDynamicObject(ModeCapturePoint[roomid][e_ObjectFlag])) {
		DestroyDynamicObject(ModeCapturePoint[roomid][e_ObjectFlag]);
	}
	return 1;
}

stock Room_MovePointFlag(roomid, type)
{
	if (!IsValidDynamicObject(ModeCapturePoint[roomid][e_ObjectFlag])) {
		return 1;
	}

	new
		Float:X, Float:Y, Float:Z;
		
	GetDynamicObjectPos(ModeCapturePoint[roomid][e_ObjectFlag], X, Y, Z);

	switch (type) {
		case 0: {
			MoveDynamicObject(ModeCapturePoint[roomid][e_ObjectFlag], X, Y, Z + 0.8, 5.0, 0.00000, 0.00000, 0.00000);
		}
		case 1: {
			MoveDynamicObject(ModeCapturePoint[roomid][e_ObjectFlag], X, Y, Z - 0.8, 5.0, 0.00000, 0.00000, 0.00000);
		}
	}
	return 1;
}

stock Room_ChangeColorPointFlag(roomid, teamid)
{
	if (IsValidDynamicObject(ModeCapturePoint[roomid][e_ObjectFlag])) {
		SetDynamicObjectMaterial(ModeCapturePoint[roomid][e_ObjectFlag], 1, -1, "none", "none", Room_GetTeamColorObject(teamid));
	}
	return 1;
}

stock Room_CreatePlayerPoint(playerid) 
{
	new
		roomid = Mode_GetPlayerSession(playerid);

	PlayerActivePointCapture[playerid] = 0;

	PlayerBarPointCapture[playerid] = CreatePlayerProgressBar(playerid, 285.00, 279.00, 75.50, 7.19, 0xCCCCCC00, ROOM_MAX_SCORE_CAPTURE.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarColour(playerid, PlayerBarPointCapture[playerid], Room_GetTeamColorXB(ModeCapturePoint[roomid][e_Property]));
	SetPlayerProgressBarValue(playerid, PlayerBarPointCapture[playerid], floatround(ModeCapturePoint[roomid][e_ScoreBar]));
	ShowPlayerProgressBar(playerid, PlayerBarPointCapture[playerid]);

	Room_CreatePlayerCaptPointTD(playerid, TD_CapturePoint[playerid]);

	PlayerTextDrawSetString(playerid, TD_CapturePoint[playerid], "Точка: ~y~%s", GetNamePointABC(0));
	PlayerTextDrawShow(playerid, TD_CapturePoint[playerid]);
	return 1;
}

stock Room_DestroyPlayerPoint(playerid) 
{
	if (PlayerActivePointCapture[playerid] > -1) {
		DestroyPlayerProgressBar(playerid, PlayerBarPointCapture[playerid]);
		DestroyPlayerTD(playerid, TD_CapturePoint[playerid]);

		PlayerActivePointCapture[playerid] = -1;
	}
	return 1;
}

stock Room_GetCapturePointColor(roomid)
{
	return ModeCapturePoint[roomid][e_Color];
}

stock Room_SetCPTeamScore(roomid, teamid, num)
{
	ModeCapturePoint[roomid][e_Score][teamid] = num;
	return 1;
}

stock Room_GiveCPTeamScore(roomid, teamid, num)
{
	ModeCapturePoint[roomid][e_Score][teamid] += num;
	return 1;
}

stock Room_GetCPTeamScore(roomid, teamid)
{
	return ModeCapturePoint[roomid][e_Score][teamid];
}

stock Room_GiveCPPointTeam(roomid, teamid)
{
	if (ModeCapturePoint[roomid][CP_Color] == teamid) {
		Room_GiveTeamScore(teamid, 1);
	}
	return 1;
}

stock Room_SetCPTeamMaxScore(roomid, teamid, num)
{
	if (num) {
		ModeCapturePoint[roomid][e_MaxScore][teamid] = num;
	}
	else {
		ModeCapturePoint[roomid][e_MaxScore][teamid] = 0;
	}
	return 1;
}

stock Room_GetCPTeamMaxScore(roomid, teamid)
{
	return ModeCapturePoint[roomid][e_MaxScore][teamid];
}

stock Room_PointReInfo(roomid) 
{
	new 
		team[ROOM_MAX_TEAMS];

	foreach (new t:Room_ActiveTeams[roomid]) {
		m_for(MODE_ROOM, roomid, p) {
			if (GetPlayerSpectating(p) != INVALID_PLAYER_ID) {
				continue;
			}

			if (PlayerActivePointCapture[p] != 0) {
				continue;
			}

			if (GetPlayerTeamEx(p) == t) {
				team[t]++;
			}
		}
	}

	new 
		mostPlayers,
		winTeam = -1,
		worseTeam = -1,
		bool:draw;

	foreach (new t:Room_ActiveTeams[roomid]) {
		if (team[t] > 0) {
			if (team[t] >= mostPlayers) {
				if (draw) {
					draw = false;
				}

				if (team[t] == mostPlayers) {
					if (winTeam != -1) {
						draw = true;
					}
				}

				mostPlayers = team[t];
				winTeam = t;
			}
			else
				worseTeam = t;
		}
	}

	if (mostPlayers == 0) {
		if (ModeCapturePoint[roomid][e_Color] != ROOM_TEAM_NONE) {
			if (ModeCapturePoint[roomid][e_Score] < ROOM_MAX_SCORE_CAPTURE) {
				ModeCapturePoint[roomid][e_Score]++;
				Room_MovePointFlag(roomid, 0);
			}
		}
		else {
			if (ModeCapturePoint[roomid][e_Score] > 0) {
				ModeCapturePoint[roomid][e_Score]--;
				Room_MovePointFlag(roomid, 1);
			}
			else {
				ModeCapturePoint[roomid][e_Color] = ROOM_TEAM_NONE;
				ModeCapturePoint[roomid][e_Property] = ROOM_TEAM_NONE;
				Room_DestroyObjectPointFlag(roomid);
			}
		}

		if (ModeCapturePoint[roomid][e_Red]) {
			ModeCapturePoint[roomid][e_Red] = false;
			ModeCapturePoint[roomid][e_CaptureTeam] = ROOM_TEAM_NONE;
		}
	}
	else {
		if (draw) {
			foreach (new t:Room_ActiveTeams[roomid]) {
				if (team[t] == mostPlayers) {
					if (t != ModeCapturePoint[roomid][e_Color]) {
						ModeCapturePoint[roomid][e_Red] = true;
						ModeCapturePoint[roomid][e_CaptureTeam] = t;
						break;
					}
				}
			}
		}
		else {
			if (worseTeam != -1) {
				if (worseTeam != ModeCapturePoint[roomid][e_Color]) {
					if (winTeam == ModeCapturePoint[roomid][e_Color]) {
						ModeCapturePoint[roomid][e_Red] = true;
					}
				}
			}
			if (winTeam != -1) {
				if (winTeam != ModeCapturePoint[roomid][e_Color]) {
					ModeCapturePoint[roomid][e_Red] = true;
					ModeCapturePoint[roomid][e_CaptureTeam] = winTeam;

					if (ModeCapturePoint[roomid][e_Property] != winTeam) {
						if (ModeCapturePoint[roomid][e_Score] > 0) {
							ModeCapturePoint[roomid][e_Score]--;
							Room_MovePointFlag(roomid, 1);
						}
						if (ModeCapturePoint[roomid][e_Score] <= 0) {
							if (ModeCapturePoint[roomid][e_Color] != ROOM_TEAM_NONE) {
								m_for(MODE_ROOM, roomid, p) {
									if (GetPlayerSpectating(p) != INVALID_PLAYER_ID) {
										continue;
									}
									
									if (PlayerActivePointCapture[p]) {
										continue;
									}
									
									if (GetPlayerTeamEx(p) != winTeam) {
										continue;
									}

									GivePlayerReward(p, 150, 50, REWARD_CAPTURE_POINT);
									PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);
								}
							}

							ModeCapturePoint[roomid][e_Score] = 0;
							ModeCapturePoint[roomid][e_Color] = ROOM_TEAM_NONE;
							ModeCapturePoint[roomid][e_Property] = winTeam;
							Room_DestroyObjectPointFlag(roomid);
						}
					}
					else {
						if (ModeCapturePoint[roomid][e_Score] < ROOM_MAX_SCORE_CAPTURE) {
							ModeCapturePoint[roomid][e_Score]++;

							Room_CreateObjectPointFlag(roomid);
							Room_ChangeColorPointFlag(roomid, winTeam);
							Room_MovePointFlag(roomid, 0);
				
							if (ModeCapturePoint[roomid][e_Score] >= ROOM_MAX_SCORE_CAPTURE) {
								ModeCapturePoint[roomid][e_Red] = false;
								ModeCapturePoint[roomid][e_Color] = winTeam;
								ModeCapturePoint[roomid][e_CaptureTeam] = ROOM_TEAM_NONE;
								ModeCapturePoint[roomid][e_Score] = ROOM_MAX_SCORE_CAPTURE;

								m_for(MODE_ROOM, roomid, p) {
									if (GetPlayerSpectating(p) != INVALID_PLAYER_ID) {
										continue;
									}
									
									if (PlayerActivePointCapture[p] != 0) {
										continue;
									}
									
									if (GetPlayerTeamEx(p) != winTeam) {
										continue;
									}

									GivePlayerReward(p, 400, 250, REWARD_CAPTURE_POINT);
									PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);

									CheckPlayerDinaHint(p, 13);
								}
							}
						}
					}
				}
				else {
					if (ModeCapturePoint[roomid][e_Score] < ROOM_MAX_SCORE_CAPTURE) {
						ModeCapturePoint[roomid][e_Score]++;
						Room_MovePointFlag(roomid, 0);
					}
					if (worseTeam == -1) {
						if (ModeCapturePoint[roomid][e_Red]) {
							ModeCapturePoint[roomid][e_Red] = false;
							ModeCapturePoint[roomid][e_CaptureTeam] = ROOM_TEAM_NONE;
						}
					}
				}
			}
		}
	}

	new 
		str[130];

	if (!ModeCapturePoint[roomid][e_Red]) {
		f(str, "%s[ Точка %s ]", Room_GetTeamColor(ModeCapturePoint[roomid][e_Color]), GetNamePointABC(0));
	}
	else {
		f(str, "%s[ Точка %s ]\n\n{D53032}Захватывают %s%s", Room_GetTeamColor(ModeCapturePoint[roomid][e_Color]), GetNamePointABC(0), Room_GetTeamColor(ModeCapturePoint[roomid][e_CaptureTeam]), Room_GetTeamName(ModeCapturePoint[roomid][e_CaptureTeam]));
	}
	UpdateDynamic3DTextLabelText(ModeCapturePoint[roomid][e_3DText], 0x000000FF, str);

	m_for(MODE_ROOM, roomid, p) {
		if (!PlayerActivePointCapture[p]) {
			SetPlayerProgressBarColour(p, PlayerBarPointCapture[p], Room_GetTeamColorXB(ModeCapturePoint[roomid][e_Property]));
			SetPlayerProgressBarValue(p, PlayerBarPointCapture[p], floatround(ModeCapturePoint[roomid][e_Score]));
		}
	}
	return 1;
}

/*
 * |>------------<|
 * |   Computer   |
 * |>------------<|
 */

stock Room_CreateComputer(roomid, worldid, interiorid)
{
	ModeComputer[roomid][e_ProtectTeam] = ROOM_TEAM_ALPHA;
	ModeComputer[roomid][e_Status] = ROOM_TEAM_ALPHA;
	ModeComputer[roomid][e_PlayerID] = -1;

	ModeComputer[roomid][e_MapIcon] = CreateDynamicMapIcon(ComputerPos[roomid][0], ComputerPos[roomid][1], ComputerPos[roomid][2], 16, 0, worldid, interiorid, -1, 150.0);
	ModeComputer[roomid][e_ObjectComputer] = CreateDynamicObject(3388, ComputerPos[roomid][0] - 0.1, ComputerPos[roomid][1], ComputerPos[roomid][2] - 1.7, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ModeComputer[roomid][e_3DText] = CreateDynamic3DTextLabel("_", -1, ComputerPos[roomid][0], ComputerPos[roomid][1], ComputerPos[roomid][2] + 2.0, 400.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, worldid, interiorid);
	ModeComputer[roomid][e_3DTextClick] = CreateDynamic3DTextLabel("{10B3EA}Компьютер\n\n{D42C21}Нажмите {E5D110}[ ALT ]", -1, ComputerPos[roomid][0] - 1.2, ComputerPos[roomid][1], ComputerPos[roomid][2], 13.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, worldid, interiorid);
	return 1;
}

stock Room_DestroyComputer(roomid)
{
	DestroyDynamicMapIcon(ModeComputer[roomid][e_MapIcon]);
	DestroyDynamicObject(ModeComputer[roomid][e_ObjectComputer]);
	DestroyDynamic3DTextLabel(ModeComputer[roomid][e_3DText]);
	DestroyDynamic3DTextLabel(ModeComputer[roomid][e_3DTextClick]);

	Room_ResetComputer(roomid);
	return 1;
}

stock Room_ResetComputer(roomid)
{
	ModeComputer[roomid][e_ActionCapture] =
	ModeComputer[roomid][e_Red] = false;
	ModeComputer[roomid][e_Status] =
	ModeComputer[roomid][e_ScoreBar] =
	ModeComputer[roomid][e_Timer] = 0;
	ModeComputer[roomid][e_ProtectTeam] = ROOM_TEAM_NONE;
	ModeComputer[roomid][e_PlayerID] = -1;

	n_for(i, ROOM_MAX_TEAMS) {
		ModeComputer[roomid][e_Score][i] =
		ModeComputer[roomid][e_MaxScore][i] = 0;
	}

	ModeComputer[roomid][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
	ModeComputer[roomid][e_ObjectComputer] = INVALID_DYNAMIC_OBJECT_ID;

	ModeComputer[roomid][e_3DText] =
	ModeComputer[roomid][e_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;

	Room_ResetComputerPos(roomid);
	return 1;
}

stock Room_SetComputerPos(roomid, Float:X, Float:Y, Float:Z)
{
	ComputerPos[roomid][0] = X;
	ComputerPos[roomid][1] = Y;
	ComputerPos[roomid][2] = Z;
	return 1;
}

stock Room_ResetComputerPos(roomid)
{
	ComputerPos[roomid][0] =
	ComputerPos[roomid][1] =
	ComputerPos[roomid][2] = 0.0;
	return 1;
}

stock Room_CreatePlayerComputer(playerid) 
{
	new
		roomid = M_GPS(playerid);

	ModeComputer[roomid][e_Red] = true;
	ModeComputer[roomid][e_PlayerID] = playerid;
	PlayerActiveComputerCapture[playerid] = 0;

	if (ModeComputer[roomid][e_ProtectTeam] != GetPlayerTeamEx(playerid)) {
		ModeComputer[roomid][e_ScoreBar] = 0;
	}
	else { 
		ModeComputer[roomid][e_ScoreBar] = ROOM_MAX_SCORE_COMPUTER;
	}

	Room_CreatePlayerHackCompTD(playerid, TD_HackComputer[playerid]);

	PlayerTextDrawSetString(playerid, TD_HackComputer[playerid], "%s ~w~- Компьютер: ~y~%i", Room_GetTeamName(ModeComputer[roomid][e_ProtectTeam]), 1);
	PlayerTextDrawColour(playerid, TD_HackComputer[playerid], Room_GetTeamColorXB(ModeComputer[roomid][e_ProtectTeam]));
	PlayerTextDrawShow(playerid, TD_HackComputer[playerid]);

	PlayerBarComputerCapture[playerid] = CreatePlayerProgressBar(playerid, 281.00, 250.00, 84.50, 7.19, 0xC7DBFFAA, 10.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarValue(playerid, PlayerBarComputerCapture[playerid], floatround(ModeComputer[roomid][e_ScoreBar]));
	ShowPlayerProgressBar(playerid, PlayerBarComputerCapture[playerid]);
	return 1;
}

stock Room_DestroyPlayerComputer(playerid) 
{
	new
		roomid = Mode_GetPlayerSession(playerid);

	if (PlayerActiveComputerCapture[playerid] > -1) {
		ModeComputer[roomid][e_Red] = false;
		ModeComputer[roomid][e_PlayerID] = -1;

		DestroyPlayerProgressBar(playerid, PlayerBarComputerCapture[playerid]);
		DestroyPlayerTD(playerid, TD_HackComputer[playerid]);

		PlayerActiveComputerCapture[playerid] = -1;

		if (ModeComputer[roomid][e_ProtectTeam] != GetPlayerTeamEx(playerid)) {
			ModeComputer[roomid][e_ScoreBar] = 0;
		}
		else { 
			ModeComputer[roomid][e_ScoreBar] = ROOM_MAX_SCORE_COMPUTER;
		}
	}
	return 1;
}

stock Room_GetComputerProtectTeam(roomid)
{
	return ModeComputer[roomid][e_ProtectTeam];
}

stock Room_SetCompTeamScore(roomid, teamid, num)
{
	ModeComputer[roomid][e_Score][teamid] = num;
	return 1;
}

stock Room_GiveCompTeamScore(roomid, teamid, num)
{
	ModeComputer[roomid][e_Score][teamid] += num;
	return 1;
}

stock Room_GetCompTeamScore(roomid, teamid)
{
	return ModeComputer[roomid][e_Score][teamid];
}

stock Room_SetCompTeamMaxScore(roomid, teamid, num)
{
	if (num)
		ModeComputer[roomid][e_MaxScore][teamid] = num;
	else
		ModeComputer[roomid][e_MaxScore][teamid] = 0;
		
	return 1;
}

stock Room_GetCompTeamMaxScore(roomid, teamid)
{
	return ModeComputer[roomid][e_MaxScore][teamid];
}

stock Room_ComputerReInfo(roomid)
{
	new 
		team = ModeComputer[roomid][e_ProtectTeam];

	if (!ModeComputer[roomid][e_ActionCapture]) {
		if (ModeComputer[roomid][e_Status] != team) {
			if (ModeComputer[roomid][e_Timer] > 0) {
				ModeComputer[roomid][e_Timer]--;

				if (ModeComputer[roomid][e_Timer] <= 0) {
					ModeComputer[roomid][e_Score][team]++;

					new 
						player = ModeComputer[roomid][e_PlayerID];

					if (player > -1) {
						if (PlayerActiveComputerCapture[player] == 0) {
							Room_DestroyPlayerComputer(player);
						}
					}
					ModeComputer[roomid][e_Timer] = 0;
					ModeComputer[roomid][e_ActionCapture] = true;
					ModeComputer[roomid][e_Red] = false;
					ModeComputer[roomid][e_PlayerID] = -1;
				}
			}
		}
	
		new 
			string[100];

		if (ModeComputer[roomid][e_Status] != ModeComputer[roomid][e_ProtectTeam]) {
			f(string, "Компьютер взламывается\nВремя: %i\n\n"CT_WHITE"[%s%s"CT_WHITE"]", ModeComputer[roomid][e_Timer], Room_GetTeamColor(team), Room_GetTeamName(team));
			UpdateDynamic3DTextLabelText(ModeComputer[roomid][e_3DText], 0xDE2B2BFF, string);
		}
		else {
			f(string, "Компьютер не взломан\n\n"CT_WHITE"[%s%s"CT_WHITE"]", Room_GetTeamColor(team), Room_GetTeamName(team));
			UpdateDynamic3DTextLabelText(ModeComputer[roomid][e_3DText], 0x3CDB39FF, string);
		}
	}
	else {
		new 
			string[100];

		f(string, "Компьютер взломан\n\n"CT_WHITE"[%s%s"CT_WHITE"]", Room_GetTeamColor(team), Room_GetTeamName(team));
		UpdateDynamic3DTextLabelText(ModeComputer[roomid][e_3DText], 0xDE2B2BFF, string);
	}
	return 1;
}

stock Room_UpdatePlayerComputer(playerid)
{
	if (PlayerActiveComputerCapture[playerid] > -1) {
	    new 
			roomid = Mode_GetPlayerSession(playerid);

		if (IsPlayerInRangeOfPoint(playerid, 1.3, ComputerPos[roomid][0], ComputerPos[roomid][1], ComputerPos[roomid][2])) {
		    if (GetPlayerTeamEx(playerid) != ModeComputer[roomid][e_ProtectTeam]) {
		        if (ModeComputer[roomid][e_ScoreBar] < ROOM_MAX_SCORE_COMPUTER) {
					ModeComputer[roomid][e_ScoreBar]++;
					SetPlayerProgressBarValue(playerid, PlayerBarComputerCapture[playerid], floatround(ModeComputer[roomid][e_ScoreBar]));

					if (ModeComputer[roomid][e_ScoreBar] >= ROOM_MAX_SCORE_COMPUTER) {
						Room_DestroyPlayerComputer(playerid);

						ModeComputer[roomid][e_ScoreBar] = ROOM_MAX_SCORE_COMPUTER;
						ModeComputer[roomid][e_Status] = GetPlayerTeamEx(playerid);
						ModeComputer[roomid][e_Timer] = ROOM_MAX_COMPUTER_TIMER;
						ModeComputer[roomid][e_Red] = false;
						ModeComputer[roomid][e_PlayerID] = -1;

						GivePlayerReward(playerid, 300, 200, REWARD_HACK);
						PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

						CheckPlayerDinaHint(playerid, 14);

						m_for(MODE_ROOM, roomid, p) {
							if (GetPlayerTeamEx(p) != ModeComputer[roomid][e_ProtectTeam]) {
								continue;
							}

							SCM(p, C_RED, ""T_MATCH" Компьютер взломали, деактивируйте взлом!");
						}
					}
				}
			}
		    else {
		        if (ModeComputer[roomid][e_ScoreBar] > 0) {
					ModeComputer[roomid][e_ScoreBar]--;
					SetPlayerProgressBarValue(playerid, PlayerBarComputerCapture[playerid], floatround(ModeComputer[roomid][e_ScoreBar]));

					if (ModeComputer[roomid][e_ScoreBar] <= 0) {
						Room_DestroyPlayerComputer(playerid);

						ModeComputer[roomid][e_ScoreBar] = 0;
						ModeComputer[roomid][e_Status] = GetPlayerTeamEx(playerid);
						ModeComputer[roomid][e_Timer] = 0;
						ModeComputer[roomid][e_Red] = false;
						ModeComputer[roomid][e_PlayerID] = -1;

						GivePlayerReward(playerid, 300, 200, REWARD_HACK);
						PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

						m_for(MODE_ROOM, roomid, p) {
							if (GetPlayerTeamEx(p) == ModeComputer[roomid][e_ProtectTeam]) {
								continue;
							}

							SCM(p, C_RED, ""T_MATCH" Взлом компьютера деактивировали!");
						}
					}
				}
			}
		}
		else {
		    ModeComputer[roomid][e_Red] = false;
		    ModeComputer[roomid][e_PlayerID] = -1;

			Room_DestroyPlayerComputer(playerid);
		}
	}
	return 1;
}

/*
 * |>----------<|
 * |   Battle   |
 * |>----------<|
 */

stock Room_SetBattleTeamScore(roomid, teamid, num)
{
	ModeBattle[roomid][e_Score][teamid] = num;
	return 1;
}

stock Room_GiveBattleTeamScore(roomid, teamid, num)
{
	ModeBattle[roomid][e_Score][teamid] += num;
	return 1;
}

stock Room_GetBattleTeamScore(roomid, teamid)
{
	return ModeBattle[roomid][e_Score][teamid];
}

stock Room_SetBattleTeamMaxScore(roomid, teamid, num)
{
	if (num)
		ModeBattle[roomid][e_MaxScore][teamid] = num;
	else
		ModeBattle[roomid][e_MaxScore][teamid] = 0;
		
	return 1;
}

stock Room_GetBattleTeamMaxScore(roomid, teamid)
{
	return ModeBattle[roomid][e_MaxScore][teamid];
}

/*
 * |>--------------------<|
 * |   Camera end match   |
 * |>--------------------<|
 */

stock Room_ShowCameraEndLocation(playerid)
{
	new
		roomid = Mode_GetPlayerSession(playerid);

	InterpolateCameraPos(playerid, CameraEndLocationPos[roomid][0][0], CameraEndLocationPos[roomid][0][1], CameraEndLocationPos[roomid][0][2], CameraEndLocationPos[roomid][1][0], CameraEndLocationPos[roomid][1][1], CameraEndLocationPos[roomid][1][2], 5000);
	InterpolateCameraLookAt(playerid, CameraEndLocationPos[roomid][2][0], CameraEndLocationPos[roomid][2][1], CameraEndLocationPos[roomid][2][2], CameraEndLocationPos[roomid][3][0], CameraEndLocationPos[roomid][3][1], CameraEndLocationPos[roomid][3][2], 5000);
	return 1;
}

stock Room_SetCameraEndPos(roomid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraPos от и до
	CameraEndLocationPos[roomid][0][0] = X;
	CameraEndLocationPos[roomid][0][1] = Y;
	CameraEndLocationPos[roomid][0][2] = Z;

	CameraEndLocationPos[roomid][2][0] = X2;
	CameraEndLocationPos[roomid][2][1] = Y2;
	CameraEndLocationPos[roomid][2][2] = Z2;
	return 1;
}

stock Room_SetCameraEndLookAt(roomid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraLookAt от и до
	CameraEndLocationPos[roomid][1][0] = X;
	CameraEndLocationPos[roomid][1][1] = Y;
	CameraEndLocationPos[roomid][1][2] = Z;

	CameraEndLocationPos[roomid][3][0] = X2;
	CameraEndLocationPos[roomid][3][1] = Y2;
	CameraEndLocationPos[roomid][3][2] = Z2;
	return 1;
}

stock Room_ResetCameraEndPos(roomid)
{
	n_for(i, sizeof(CameraEndLocationPos[])) {
		CameraEndLocationPos[roomid][i][0] =
		CameraEndLocationPos[roomid][i][1] =
		CameraEndLocationPos[roomid][i][2] = 0.0;
	}
	return 1;
}

/*
 * |>--------<|
 * |   Team   |
 * |>--------<|
 */

stock Room_AddTeam(roomid, teamid, bool:score)
{
	Iter_Add(Room_ActiveTeams[roomid], teamid);

	if (score) {
		Iter_Add(Room_ActiveTeamsScore[roomid], teamid);
	}
	return 1;
}

stock Room_RemoveTeam(roomid, teamid)
{
	if (teamid != -1) {
		Iter_Remove(Room_ActiveTeams[roomid], teamid);

		if (Iter_Contains(Room_ActiveTeamsScore[roomid], teamid)) {
			Iter_Remove(Room_ActiveTeamsScore[roomid], teamid);
		}
	}
	else {
		Iter_Clear(Room_ActiveTeams[roomid]);

		if (Iter_Count(Room_ActiveTeamsScore[roomid])) {
			Iter_Clear(Room_ActiveTeamsScore[roomid]);
		}
	}
	return 1;
}

stock Room_CheckTeam(roomid, teamid)
{
	return Iter_Contains(Room_ActiveTeams[roomid], teamid);
}

stock Room_CheckTeamScore(roomid, teamid)
{
	return Iter_Contains(Room_ActiveTeamsScore[roomid], teamid);
}

stock Room_GetActiveTeams(roomid)
{
	return Iter_Count(Room_ActiveTeamsScore[roomid]);
}

/*
 * |>--------------<|
 * |   Team score   |
 * |>--------------<|
 */

stock Room_SetTeamScore(roomid, teamid, score, maxscore)
{
	if (!ActiveTeamScore[roomid]) {
		ActiveTeamScore[roomid] = true;
	}

	Room_SetTeamModeScore(roomid, teamid, score);
	Room_SetTeamModeMaxScore(roomid, teamid, maxscore);
	return 1;
}

stock Room_ResetTeamsScore(roomid)
{
	ActiveTeamScore[roomid] = false;

	foreach (new t:Room_ActiveTeams[roomid]) {
		Room_SetTeamModeMaxScore(roomid, t, 0);
		Room_SetTeamModeScore(roomid, t, 0);
	}
	return 1;
}

stock Room_GetTeamsScore(roomid)
{
	return ActiveTeamScore[roomid];
}

/*
 * |>-------------------<|
 * |   Spawn positions   |
 * |>-------------------<|
 */

stock Room_SetSpawnBasePos(roomid, teamid, cell, Float:X, Float:Y, Float:Z)
{
	SpawnBaseTeamPos[roomid][teamid][cell][0] = X;
	SpawnBaseTeamPos[roomid][teamid][cell][1] = Y;
	SpawnBaseTeamPos[roomid][teamid][cell][2] = Z;
	return 1;
}

stock Room_GetSpawnBasePos(roomid, teamid, cell, &Float:X, &Float:Y, &Float:Z)
{
	X = SpawnBaseTeamPos[roomid][teamid][cell][0];
	Y = SpawnBaseTeamPos[roomid][teamid][cell][1];
	Z = SpawnBaseTeamPos[roomid][teamid][cell][2];
	return 1;
}

static ResetSpawnBasePos(roomid)
{
	n_for(i, ROOM_MAX_TEAMS) {
		n_for2(b, 3) {
			SpawnBaseTeamPos[roomid][i][b][0] =
			SpawnBaseTeamPos[roomid][i][b][1] =
			SpawnBaseTeamPos[roomid][i][b][2] = 0.0;
		}
	}
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

stock Room_LocResetSessionData(roomid)
{
	ResetSpawnBasePos(roomid);

	Room_ResetPointFlag(roomid);
	Room_ResetCapturePointPos(roomid);

	Room_ResetComputer(roomid);
	Room_ResetComputerPos(roomid);

	Room_ResetCameraEndPos(roomid);
	return 1;
}

static ResetPlayerData(playerid)
{
	PlayerActivePointCapture[playerid] =
	PlayerActiveComputerCapture[playerid] = -1;
	return 1;
}

static ResetPlayerTDs(playerid)
{
	TD_CapturePoint[playerid] = INVALID_PLAYER_TEXT_DRAW;
	TD_HackComputer[playerid] = INVALID_PLAYER_TEXT_DRAW;
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

stock Room_LocOnGameModeInit()
{
	Room_InitialLocations();
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

	#if defined Room_LocOnPlayerConnect
		return Room_LocOnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>----------------------------<|
 * |   OnPlayerEnterDynamicArea   |
 * |>----------------------------<|
 */

stock Room_LocOnPlEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid) 
{
	if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
		return 0;
	}

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 0;
	}

	new
		roomid = Mode_GetPlayerSession(playerid);

	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_CAPTURE: {
			if (PlayerActivePointCapture[playerid] == -1) {
				if (areaid == ModeCapturePoint[roomid][e_Sphere]) {
					Room_CreatePlayerPoint(playerid);
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
 * |>----------------------------<|
 * |   OnPlayerLeaveDynamicArea   |
 * |>----------------------------<|
 */

stock Room_LocOnPlLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)  
{
	if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
		return 0;
	}

	new
		roomid = Mode_GetPlayerSession(playerid);
		
	if (areaid == ModeCapturePoint[roomid][e_Sphere]) {
		if (PlayerActivePointCapture[playerid] > -1) {
			Room_DestroyPlayerPoint(playerid);
		}
		return 1;
	}
	return 0;
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

stock Room_LocOnPlKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	#pragma unused oldkeys

	// ALT
	if (newkeys & KEY_WALK) {
		new 
			roomid = Mode_GetPlayerSession(playerid);

		switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
			case ROOM_GAME_MODE_DATA: {
				if (IsPlayerInRangeOfPoint(playerid, 1.3, ComputerPos[roomid][0], ComputerPos[roomid][1], ComputerPos[roomid][2])) {
					if (GetPlayerTeamEx(playerid) != ModeComputer[roomid][e_Status]) {
						if (!ModeComputer[roomid][e_ActionCapture]) {
							if (!ModeComputer[roomid][e_Red]) {
								Room_CreatePlayerComputer(playerid);
							}
						}
					}
					else {
						if (!ModeComputer[roomid][e_ActionCapture]) {
							if (GetPlayerTeamEx(playerid) == ModeComputer[roomid][e_ProtectTeam]) {
								SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Вы должны защищать компьютер!");
							}
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
 * |>-------<|
 * |   ALS   |
 * |>-------<|
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