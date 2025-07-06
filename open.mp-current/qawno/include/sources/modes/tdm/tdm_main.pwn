/*
 * |>========================<|
 * |   About: Mode TDM main   |
 * |   Author: Foxze          |
 * |>========================<|
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
	- OnPlayerText(playerid, text[])
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
	- OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
	- OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnVehicleSpawn(vehicleid)

	# Technical #
	- TDM_CallPlayerBaseCamera2(playerid)
 * Stock:
	- TDM_CreateSession(sessionid)
	- TDM_DestroySession(sessionid)
	- TDM_CreateFirstSessions()

	- TDM_CreateLocation(sessionid, locationid)
	- TDM_DestroyLocation(sessionid)
	- TDM_CreatePlayerLocation(playerid, sessionid)
	- TDM_DestroyPlayerLocation(playerid)

	- TDM_UpdateModeData(sessionid)
	- TDM_UpdatePlayerData(playerid)

	- TDM_GetPlayerSelectSpawn(playerid)
	- TDM_GetPlayerSelectPlayerID(playerid)
	- TDM_HidePlayerSelectedSpawn(playerid, bool:iterremove = true)
	- TDM_HidePlSelectedPointSpawn(playerid)
	- TDM_ChangePointCameraForPlayer(sessionid, pointid)
	- TDM_ShowPlayerBaseColor(playerid)
	- TDM_UpdatePlSquadPlayersTD(playerid, tdid, playerSquad = -1)
	- TDM_TimerSetPlayerBaseCamera(playerid)

	- TDM_GivePlayerExplosive(playerid, num)
	- TDM_ResetPlayerExplosive(playerid)
	- TDM_GetPlayerExplosive(playerid)

	- TDM_GiveTeamModeScore(sessionid, teamid, num)
	- TDM_GetTeamScore(sessionid, teamid)
	- TDM_GiveTeamScore(sessionid, teamid, num)
	- TDM_GiveTeamModeMaxScore(sessionid, teamid, num)
	- TDM_ResetTeamModeMaxScore(sessionid, teamid)
	- TDM_GetTeamMaxScore(sessionid, teamid)
	- TDM_ShowPlayerTeamsScoreTD(playerid)
	- TDM_DestroyPlayerTeamsScoreTD(playerid)

	- TDM_CallPlayerCommand(playerid, const cmdName[], const params[])
	- TDM_UpdatePlayerMG(playerid)
	- TDM_UpdatePlayerSpecStatus(playerid, spectedid)
	- TDM_GivePlayerWeapon(playerid, WEAPON:weaponid, ammo)
	- TDM_SetTextTeamMatch(const sessionid, const text[], teamid = 0, timer = 4)
	- TDM_GetStatusGame(sessionid)
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
	- TDM_SelectTeam
	- TDM_SelectSpawn
	- TDM_SelectNextLoc
 */

#if defined _INC_TDM_MAIN
	#endinput
#endif
#define _INC_TDM_MAIN

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	LocationGameStatus[GMS_MAX_SESSIONS],
	LocationEndTimer[GMS_MAX_SESSIONS];

static
	TOPPlayersData[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][MAX_PLAYERS][3],
	TOPPlayersName[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][MAX_PLAYERS][MAX_PLAYER_NAME],
	TOPTempVar[GMS_MAX_SESSIONS][TDM_MAX_TEAMS];

static
	ChangeLocationList[GMS_MAX_SESSIONS][TDM_MAX_CHANGE_MAP_LIST],
	NotSelectedLocations[GMS_MAX_SESSIONS][GMS_MAX_LOCATIONS],
	SelectVoteLocation[GMS_MAX_SESSIONS][TDM_MAX_CHANGE_MAP_LIST];

static
	TimerMatchText[GMS_MAX_SESSIONS][TDM_MAX_TEAMS];

static
	TOPActorKills[GMS_MAX_SESSIONS][5],
	Text3D:TOPActor3DText[GMS_MAX_SESSIONS][5],

	TOPActorData[GMS_MAX_SESSIONS][MAX_PLAYERS][3],
	TOPActorName[GMS_MAX_SESSIONS][MAX_PLAYERS][MAX_PLAYER_NAME],
	TOPActorTeam[GMS_MAX_SESSIONS][MAX_PLAYERS],
	TOPActorSkin[GMS_MAX_SESSIONS][MAX_PLAYERS],
	TOPActorTempVar[GMS_MAX_SESSIONS];

static
	PlayerSelectPointID[MAX_PLAYERS],
	PlayerSelectPointTD[MAX_PLAYERS],
	PlayerSelectSquadPlayerID[MAX_PLAYERS],
	PlayerSelectSquadPlayerTD[MAX_PLAYERS],
	PlayerTimerChooseSpawn[MAX_PLAYERS],
	IncludeSpawnInVehiclePlayer[MAX_PLAYERS];

static
	bool:PlayerActiveSelectSpawn[MAX_PLAYERS char],
	bool:PlayerActiveSelectSpawnTD[MAX_PLAYERS char],
	bool:PlayerActiveNextLocationTD[MAX_PLAYERS char],
	bool:PlayerActiveMatchTextTD[MAX_PLAYERS char],

	PlayerTimerSetCameraBase[MAX_PLAYERS],
	PlayerTimerUpdateSelectSpawn[MAX_PLAYERS],
	PlayerExplosives[MAX_PLAYERS],

	PlayerSelectVoteLocation[MAX_PLAYERS],
	PlayerActiveChangeTeamTimer[MAX_PLAYERS];

static
	PlayerText:TD_TopKillers[MAX_PLAYERS][TDM_MAX_TEAMS][TDM_MAX_TOP_KILLERS][TDM_TD_TOP_KILLERS],
	PlayerText:TD_EndMatchStats[MAX_PLAYERS][TDM_TD_END_MATCH_STATS],
	PlayerText:TD_MatchResult[MAX_PLAYERS][TDM_MAX_TEAMS][TDM_TD_MATCH_RESULT],

	PlayerText:TD_TNextLocation[MAX_PLAYERS],
	PlayerText:TD_TextTeamMatch[MAX_PLAYERS][TDM_MAX_TEAMS],

	PlayerText:TD_SelectSpawn[MAX_PLAYERS][TDM_TD_SELECT_SPAWN],
	PlayerText:TD_SelectPlayer[MAX_PLAYERS][TDM_TD_SELECT_PLAYER],
	PlayerText:TD_SelectPoint[MAX_PLAYERS][TDM_TD_SELECT_POINT],
	PlayerText:TD_SelectTeam[MAX_PLAYERS][TDM_TD_SELECT_TEAM],

	PlayerText:TD_SelectNextLocation[MAX_PLAYERS][TDM_TD_SELECT_NEXT_LOCATION],
	PlayerText:TD_TeamScore[MAX_PLAYERS][TDM_TD_TEAM_SCORE];

static
	PlayerBar:PlayerBarScoreMatch[MAX_PLAYERS][TDM_MAX_TEAMS];

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

stock TDM_CreateSession(sessionid)
{
	new
		locationid = Iter_Random(Locations[MODE_TDM]);

	Mode_DestroySessionLocation(MODE_TDM, sessionid);
	Mode_CreateSessionLocation(MODE_TDM, sessionid, locationid);
	return 1;
}

stock TDM_DestroySession(sessionid)
{
	ResetSessionData(sessionid);
	return 1;
}

stock TDM_CreateFirstSessions()
{
	n_for(i, 3) {
		Mode_CreateSession(MODE_TDM);
	}
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Location create & destroy   |
 * |>-----------------------------<|
 */

stock TDM_CreateLocation(sessionid, locationid)
{
	LocationGameStatus[sessionid] = TDM_GAME_STATUS_GAME;
	
	TDM_CreateElementsLocation(sessionid, locationid);
	TDM_CreateLocAE(sessionid, locationid);
	return 1;
}

stock TDM_DestroyLocation(sessionid)
{
	TDM_DestroyElementsLocation(sessionid);
	TDM_DestroyLocAE(sessionid);
	return 1;
}

stock TDM_CreatePlayerLocation(playerid, sessionid)
{
	#pragma unused sessionid

	SetPlayerCustomClass(playerid, TDM_CLASS_ASSAULT);
	SetPlayerCustomClass2(playerid, -1);

	if (!GetAdminSpectating(playerid)) {
		TDM_SetRandomPlayerTeam(playerid);
		TDM_EnterPlayerRandomSquad(playerid);
	}

	TDM_ShowPlayerElementsLocation(playerid);

	if (!GetAdminSpectating(playerid)) {
		ShowPlayerNewGraphTD(playerid);
		CreatePlayerAfterDeadTD(playerid);

		PlayerSpawn(playerid);
		ShowPlayerInfoLocation(playerid);
		ShowGoalLocation(playerid);
	}
	return 1;
}

stock TDM_DestroyPlayerLocation(playerid)
{
	if (PlayerActiveSelectSpawn{playerid}) {
		HidePlayerSelectSpawn(playerid, false);
	}

	TDM_HidePlayerElementsLocation(playerid);

	if (Interface_IsOpen(playerid, Interface:TDM_SelectSpawn)) {
		Interface_Close(playerid, Interface:TDM_SelectSpawn);
	}

	TDM_LeavePlayerSquad(playerid);
	TDM_SetPlayerBagMoney(playerid, false);
	TDM_ResetPlayerExplosive(playerid);

	DestroyPlayerNextLocation(playerid);
	DestroyPlSelectNextLocationTD(playerid);
	DestroyPlTextTeamMatchTD(playerid, GetPlayerTeamEx(playerid));
	HidePlayerMatchResult(playerid);

	IncludeSpawnInVehiclePlayer[playerid] = -1;

	// Save MySQL data
	TDM_SavePlayerClasses(playerid);
	return 1;
}

/*
 * |>----------------------<|
 * |   Timers update data   |
 * |>----------------------<|
 */

stock TDM_UpdateModeData(sessionid)
{
	if (Mode_GetSessionActiveTimer(MODE_TDM, sessionid)) {
		if (Mode_GetSessionSeconds(MODE_TDM, sessionid) > 0
		&& Mode_GetSessionSeconds(MODE_TDM, sessionid) <= 60) {
			Mode_SetSessionSeconds(MODE_TDM, sessionid, Mode_GetSessionSeconds(MODE_TDM, sessionid) - 1);
		}

		if (Mode_GetSessionSeconds(MODE_TDM, sessionid) <= 0
		&& Mode_GetSessionMinutes(MODE_TDM, sessionid) > 0) {
			Mode_SetSessionMinutes(MODE_TDM, sessionid, Mode_GetSessionMinutes(MODE_TDM, sessionid) - 1);
			Mode_SetSessionSeconds(MODE_TDM, sessionid, 60);
		}
	}
	else {
		if (Mode_GetSessionSeconds(MODE_TDM, sessionid) < 60) {
			Mode_SetSessionSeconds(MODE_TDM, sessionid, Mode_GetSessionSeconds(MODE_TDM, sessionid) + 1);
		}
		else {
			Mode_SetSessionSeconds(MODE_TDM, sessionid, 0);
		}
	}

	if (LocationGameStatus[sessionid] != TDM_GAME_STATUS_GAME) {
		if (LocationEndTimer[sessionid] > 0) {
			LocationEndTimer[sessionid]--;

			m_for(MODE_TDM, sessionid, p) {
				if (GetPlayerDead(p) != PLAYER_DEATH_NONE) {
					continue;
				}

				if (GetPlayerSpectating(p) != INVALID_PLAYER_ID) {
					continue;
				}

				UpdatePlayerNextLocation(p);
			}

			switch (LocationGameStatus[sessionid]) {
				case TDM_GAME_STATUS_RESULT: {
					if (LocationEndTimer[sessionid] == 25) {
						LocationGameStatus[sessionid] = TDM_GAME_STATUS_TOP_KILLS;

						m_for(MODE_TDM, sessionid, p) {
							if (GetPlayerDead(p) != PLAYER_DEATH_NONE) {
								continue;
							}

							if (GetPlayerSpectating(p) != INVALID_PLAYER_ID) {
								continue;
							}

							HidePlayerMatchResult(p);
							TDM_ShowCameraEndLocationTwo(p, 1);
						}
					}
				}
				case TDM_GAME_STATUS_TOP_KILLS: {
					if (LocationEndTimer[sessionid] == 10) {
						LocationGameStatus[sessionid] = TDM_GAME_STATUS_SELECT;
						RandomLocationList(sessionid);

						m_for(MODE_TDM, sessionid, p) {
							if (GetPlayerDead(p) != PLAYER_DEATH_NONE) {
								continue;
							}

							if (GetAdminSpectating(p)) {
								continue;
							}

							TDM_ShowCameraEndLocationThree(p, 1);
							CreatePlayerNextLocationTD(p);
							SelectTextDraw(p, TD_C_GREY);
						}
					}
				}
				case TDM_GAME_STATUS_SELECT: {
					if (LocationEndTimer[sessionid] < 1) {
						new
							maxNumber = 0,
							arrayIndex = 0;

						n_for(i, TDM_MAX_CHANGE_MAP_LIST) {
							if (SelectVoteLocation[sessionid][i] < maxNumber) {
								continue;
							}

							maxNumber = SelectVoteLocation[sessionid][i];
							arrayIndex = ChangeLocationList[sessionid][i];
						}
						n_for(i, TDM_MAX_CHANGE_MAP_LIST) {
							SelectVoteLocation[sessionid][i] = 0;
						}

						m_for(MODE_TDM, sessionid, p) {
							if (GetAdminSpectating(p)) {
								continue;
							}

							if (GetPlayerDead(p) != PLAYER_DEATH_NONE) {
								continue;
							}

							DestroyPlayerNextLocation(p);
							DestroyPlSelectNextLocationTD(p);
							CancelSelectTextDraw(p);
						}

						HideResultMatch(sessionid);
						Mode_DestroySessionLocation(MODE_TDM, sessionid);
						Mode_CreateSessionLocation(MODE_TDM, sessionid, arrayIndex);
					}
					else {
						m_for(MODE_TDM, sessionid, p) {
							if (GetAdminSpectating(p)) {
								continue;
							}

							if (GetPlayerDead(p) != PLAYER_DEATH_NONE) {
								continue;
							}

							UpdatePlTDCellsVoiceLocation(p);
						}
					}
				}
			}
		}
	}
	else {
		if (Mode_GetSessionActiveTimer(MODE_TDM, sessionid)) {
			if (Mode_GetSessionSeconds(MODE_TDM, sessionid) <= 0
			&& Mode_GetSessionMinutes(MODE_TDM, sessionid) <= 0) {
				ShowLocationEndGame(sessionid);
			}
		}

		if (TDM_GetActiveTeams(sessionid)) {
			m_for(MODE_TDM, sessionid, p) {
				UpdatePlayerTeamScoreTD(p);
			}
			UpdateTeamsScore(sessionid);
		}
	}

	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE) {
		TDM_CapturePointReInfo(sessionid);
	}

	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_SECRET_DATA) {
		TDM_ComputerReInfo(sessionid);
	}

	if (TDM_GetFastPoint(sessionid)) {
		TDM_CheckStartFastPoint(sessionid);
		TDM_FastPointReInfo(sessionid);
	}

	TDM_UpdateAE(Mode_GetSessionLocation(MODE_TDM, sessionid), sessionid);

	// Тексты командам
	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		if (TimerMatchText[sessionid][tt]) {
			TimerMatchText[sessionid][tt]--;
			if (TimerMatchText[sessionid][tt] < 1) {
				m_for(MODE_TDM, sessionid, p) {
					if (GetPlayerTeamEx(p) != tt) {
						continue;
					}

					if (PlayerActiveSelectSpawn{p}) {
						continue;
					}

					if (!PlayerActiveMatchTextTD{p}) {
						continue;
					}

					DestroyPlTextTeamMatchTD(p, GetPlayerTeamEx(p));
				}
			}
		}
	}

	switch (Mode_GetSessionSeconds(MODE_TDM, sessionid)) {
		case 60: {
			if (LocationGameStatus[sessionid] == TDM_GAME_STATUS_GAME) {
				if (TDM_GetAirDropWeapon(sessionid)) {
					TDM_SetWeaponAirs(sessionid);
				}
				
				if (TDM_GetAirBomb(sessionid)) {
					TDM_SetBombAirs(sessionid);
				}
			}
		}
	}
	return 1;
}

stock TDM_UpdatePlayerData(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	TDM_UpdatePlayerClassesData(playerid);
	
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));
	TDM_UpdatePlayerAE(playerid);
	UpdatePlayerDropWeapons(playerid);

	// Change team
	if (PlayerActiveChangeTeamTimer[playerid] > 0) {
		PlayerActiveChangeTeamTimer[playerid]--;
	}

	// Choose spawn
	if (PlayerTimerChooseSpawn[playerid] > 0) {
		PlayerTimerChooseSpawn[playerid]--;
	}

	// Capture points in the selection of dislocation
	if (PlayerActiveSelectSpawn{playerid}) {
		if (Interface_IsOpen(playerid, Interface:TDM_SelectSpawn)) {
			if (PlayerTimerUpdateSelectSpawn[playerid] > 0) {
				PlayerTimerUpdateSelectSpawn[playerid]--;
			}
			else {
				PlayerTimerUpdateSelectSpawn[playerid] = 3;

				new 
					tt = 2;

				foreach (new g:TDM_CapturePointCount[sessionid]) {
					// Square of a point
					PlayerTextDrawBackgroundColour(playerid, TD_SelectPoint[playerid][tt], TDM_GetTeamColorXF(TDM_GetCapturePointTeam(sessionid, g)));
					PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][tt]); 
					tt += 2;

					// Point status
					if (TDM_GetCapturePointTeam(sessionid, g) != GetPlayerTeamEx(playerid)) {
						PlayerTextDrawSetString(playerid, TD_SelectPoint[playerid][tt], "ЗАХВАТИТЬ");
					}
					else {
						if (!TDM_GetCapturePointRed(sessionid, g)) {
							PlayerTextDrawSetString(playerid, TD_SelectPoint[playerid][tt], "ЗАЩИЩАТЬ");
						}
						else { 
							PlayerTextDrawSetString(playerid, TD_SelectPoint[playerid][tt], "ТЕРЯЕМ");
						}
					}
					PlayerTextDrawColour(playerid, TD_SelectPoint[playerid][tt], TDM_GetTeamColorXF(TDM_GetCapturePointTeam(sessionid, g)));
					PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][tt]);

					// Point name
					PlayerTextDrawColour(playerid, TD_SelectPoint[playerid][tt + 1], TDM_GetTeamColorXF(TDM_GetCapturePointTeam(sessionid, g)));
					PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][tt + 1]);
					tt += 4;
				}
			}
			TDM_UpdatePlSquadPlayers(playerid);
		}
	}

	// TD's of death
	if (GetPlayerDead(playerid) == PLAYER_DEATH_NONE) {
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
			TDM_OnPlayerSpawn(playerid);
		}
	}

	// Computers
	TDM_UpdatePlayerComputer(playerid);

	// Airdrop of player classes
	TDM_UpPlayerClassesAirdrop(playerid);

	// Timer
	GivePlayerSecondTime(playerid);
	switch (GetPlayerSecondTime(playerid)) {
		case 60: {
			TDM_UpdateTimePlayerClass(playerid);
		}
	}
	return 1;
}

/*
 * |>-----------------------<|
 * |   Player select spawn   |
 * |>-----------------------<|
 */

static ShowPlayerSelectSpawn(playerid)
{
	HidePlayerExitZone(playerid);

	PlayerActiveSelectSpawn{playerid} = true;
	SetPlayerActionZone(playerid, false);
	SetPlayerDamage(playerid, false);
	SetPlayerClickTD(playerid, true);

	SpecPl(playerid, true);

	Interface_Show(playerid, Interface:TDM_SelectSpawn);

	TDM_SetPlayerBaseCamera(playerid, GetPlayerTeamEx(playerid));
	TDM_ShowPlayerBaseColor(playerid);

	CheckPlayerDinaHint(playerid, 7);
	return 1;
}

static HidePlayerSelectSpawn(playerid, bool:spectate = true)
{
	if (spectate) {
		SpecPl(playerid, false);
	}
	else {
		PlayerActiveSelectSpawn{playerid} = false;
	}

	SetPlayerClickTD(playerid, false);
	PlayerTimerUpdateSelectSpawn[playerid] = 0;

	PlayerTimerChooseSpawn[playerid] = 0;
	TDM_HidePlayerSelectedSpawn(playerid);
	TDM_HidePlSelectedPointSpawn(playerid);

	if (Interface_IsOpen(playerid, Interface:TDM_SelectSpawn)) {
		Interface_Close(playerid, Interface:TDM_SelectSpawn);
	}

	if (Interface_IsOpen(playerid, Interface:TDM_SelectTeam)) {
		Interface_Close(playerid, Interface:TDM_SelectTeam);
	}

	if (Interface_IsOpen(playerid, Interface:TDM_SelectClass)) {
		Interface_Close(playerid, Interface:TDM_SelectClass);
	}

	if (Interface_IsOpen(playerid, Interface:TDM_SelectedClass)) {
		Interface_Close(playerid, Interface:TDM_SelectedClass);
	}

	CancelSelectTextDraw(playerid);
	return 1;
}

static ShowPlayerSelectPointTD(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid),
		point;

	foreach (new g:TDM_CapturePointCount[sessionid]) {
		point++;
	}

	if (point) {
		for (new i = 0, td = 0; i < point; i++) {
			n_for(b, 6) {
				PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][td]);
				td++;
			}
		}
	}
	return 1;
}

static DestroyPlayerSelectPointTD(playerid, bool:hide = true)
{
	new
		sessionid = Mode_GetPlayerSession(playerid),
		point;

	foreach (new g:TDM_CapturePointCount[sessionid]) {
		point++;
	}

	if (point > 0) {
		if (hide) {
			for (new i = 0, td = 0; i < point; i++) {
				n_for(b, 6) {
					PlayerTextDrawHide(playerid, TD_SelectPoint[playerid][td]);
					td++;
				}
			}
		}
		else {
			for (new i = 0, td = 0; i < point; i++) {
				n_for(b, 6) {
					DestroyPlayerTD(playerid, TD_SelectPoint[playerid][td]);
					td++;
				}
			}
		}
	}
	return 1;
}

stock TDM_GetPlayerSelectSpawn(playerid)
{
	return PlayerActiveSelectSpawn{playerid};
}

stock TDM_GetPlayerSelectPlayerID(playerid)
{
	return PlayerSelectSquadPlayerID[playerid];
}

static ShowPlayerSelectPlayerTD(playerid)
{
	new
		td = 0;

	n_for(i, 4) {
		n_for2(b, 6) {
			PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][td]);
			td++;
		}
	}
	n_for(i, 3) {
		PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][td]);
		td++;
	}
	return 1;
}

static DestroyPlayerSelectPlayerTD(playerid, bool:hide = true)
{
	new
		td;

	if (hide) {
		n_for(i, 4) {
			n_for2(b, 6) {
				PlayerTextDrawHide(playerid, TD_SelectPlayer[playerid][td]);
				td++;
			}
		}
		n_for(i, 3) {
			PlayerTextDrawHide(playerid, TD_SelectPlayer[playerid][td]);
			td++;
		}
	}
	else {
		n_for(i, 4) {
			n_for2(b, 6) {
				DestroyPlayerTD(playerid, TD_SelectPlayer[playerid][td]);
				td++;
			}
		}
		n_for(i, 3) {
			DestroyPlayerTD(playerid, TD_SelectPlayer[playerid][td]);
			td++;
		}
	}
	return 1;
}

stock TDM_HidePlayerSelectedSpawn(playerid, bool:iterremove = true)
{
	if (PlayerSelectSquadPlayerID[playerid] == -2) {
		if (Interface_IsOpen(playerid, Interface:TDM_SelectSpawn)) {
			PlayerTextDrawBackgroundColour(playerid, TD_SelectPlayer[playerid][24], -1717986817);
			PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][24]);
		}
	}
	else if (PlayerSelectSquadPlayerID[playerid] != -1 
	&& PlayerSelectSquadPlayerID[playerid] != -2) {
		if (iterremove) {
			Iter_Remove(TDM_SpecSquadPlayerid[PlayerSelectSquadPlayerID[playerid]], playerid);
		}

		if (Interface_IsOpen(playerid, Interface:TDM_SelectSpawn)) {
			PlayerTextDrawBackgroundColour(playerid, TD_SelectPlayer[playerid][PlayerSelectSquadPlayerTD[playerid]], -1717986817);
			PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][PlayerSelectSquadPlayerTD[playerid]]);
		}
	}
	SetPlayerSpectating(playerid, INVALID_PLAYER_ID);
	SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_INVALID);

	PlayerSelectSquadPlayerID[playerid] = -1;
	PlayerSelectSquadPlayerTD[playerid] = 0;
	return 1;
}

stock TDM_HidePlSelectedPointSpawn(playerid)
{
	if (PlayerSelectPointID[playerid] != -1) {
		if (Interface_IsOpen(playerid, Interface:TDM_SelectSpawn)) {
			PlayerTextDrawBackgroundColour(playerid, TD_SelectPoint[playerid][PlayerSelectPointTD[playerid]], -1717986817);
			PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][PlayerSelectPointTD[playerid]]);
		}
	}

	PlayerSelectPointID[playerid] = -1;
	PlayerSelectPointTD[playerid] = 0;
	return 1;
}

stock TDM_ChangePointCameraForPlayer(sessionid, pointid)
{
	m_for(MODE_TDM, sessionid, p) {
		if (!PlayerActiveSelectSpawn{p}) {
			continue;
		}

		if (PlayerSelectPointID[p] != pointid) {
			continue;
		}

		if (GetPlayerTeamEx(p) == TDM_GetCapturePointTeam(sessionid, pointid)) {
			continue;
		}

		TDM_HidePlSelectedPointSpawn(p);

		TDM_SetPlayerBaseCamera(p, GetPlayerTeamEx(p));
		TDM_ShowPlayerBaseColor(p);
	}
	return 1;
}

stock TDM_ShowPlayerBaseColor(playerid)
{
	PlayerSelectSquadPlayerID[playerid] = -2;
	PlayerSelectSquadPlayerTD[playerid] = 24;

	if (Interface_IsOpen(playerid, Interface:TDM_SelectSpawn)) {
		PlayerTextDrawBackgroundColour(playerid, TD_SelectPlayer[playerid][24], 0x3cba40FF);
		PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][24]);
	}
	return 1;
}

stock TDM_UpdatePlSquadPlayersTD(playerid, tdid, playerSquad = -1)
{
	if (playerSquad <= -1) {
		PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][tdid + 2], "_");
		PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][tdid + 4], "_");
		PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][tdid + 5], "Нет");
		return 1;
	}

	PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][tdid + 2], GetPlayerNameEx(playerSquad));
	PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][tdid + 4], "%s", TDM_GetClassName(GetPlayerCustomClass(playerSquad)));

	if (GetPlayerDead(playerSquad) != PLAYER_DEATH_NONE
	|| PlayerActiveSelectSpawn{playerSquad}) {
		PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][tdid + 5], "Мёртв");
	}
	else {
		if (GetPlayerLastDamage(playerSquad)) {
			PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][tdid + 5], "В_бою");
		}
		else {
			PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][tdid + 5], "_");
		}
	}
	return 1;
}

stock TDM_TimerSetPlayerBaseCamera(playerid)
{
	KillTimer(PlayerTimerSetCameraBase[playerid]);

	PlayerTimerSetCameraBase[playerid] = SetPlayerTimer(playerid, "TDM_CallPlayerBaseCamera2", 300, false);
	return 1;
}

public: TDM_CallPlayerBaseCamera2(playerid)
{
	SpecPl(playerid, true);
	TDM_SetPlayerBaseCamera(playerid, GetPlayerTeamEx(playerid));
	TDM_ShowPlayerBaseColor(playerid);
	return 1;
}

/*
 * |>---------------------<|
 * |   Player explosives   |
 * |>---------------------<|
 */

stock TDM_GivePlayerExplosive(playerid, num)
{
	PlayerExplosives[playerid] += num;
	return 1;
}

stock TDM_ResetPlayerExplosive(playerid)
{
	PlayerExplosives[playerid] = 0;
	return 1;
}

stock TDM_GetPlayerExplosive(playerid)
{
	return PlayerExplosives[playerid];
}

/*
 * |>--------------<|
 * |   Team score   |
 * |>--------------<|
 */

stock TDM_GiveTeamModeScore(sessionid, teamid, num)
{
	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		case TDM_GAME_MODE_CAPTURE: TDM_GiveCPTeamScore(sessionid, teamid, num);
		case TDM_GAME_MODE_CAPTURE_FLAG: TDM_GiveFlagTeamScore(sessionid, teamid, num);
		case TDM_GAME_MODE_SECRET_DATA: TDM_GiveCompTeamScore(sessionid, teamid, num);
		case TDM_GAME_MODE_BATTLE_KILLS: TDM_GiveBattleTeamScore(sessionid, teamid, num);
	}
	return 1;
}

stock TDM_ResetTeamModeScore(sessionid, teamid)
{
	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		case TDM_GAME_MODE_CAPTURE: TDM_ResetCPTeamScore(sessionid, teamid);
		case TDM_GAME_MODE_CAPTURE_FLAG: TDM_ResetFlagTeamScore(sessionid, teamid);
		case TDM_GAME_MODE_SECRET_DATA: TDM_ResetCompTeamScore(sessionid, teamid);
		case TDM_GAME_MODE_BATTLE_KILLS: TDM_ResetBattleTeamScore(sessionid, teamid);
	}
	return 1;
}

stock TDM_GetTeamScore(sessionid, teamid)
{
	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		case TDM_GAME_MODE_CAPTURE: return TDM_GetCPTeamScore(sessionid, teamid);
		case TDM_GAME_MODE_CAPTURE_FLAG: return TDM_GetFlagTeamScore(sessionid, teamid);
		case TDM_GAME_MODE_SECRET_DATA: return TDM_GetCompTeamScore(sessionid, teamid);
		case TDM_GAME_MODE_BATTLE_KILLS: return TDM_GetBattleTeamScore(sessionid, teamid);
	}
	return 1;
}

stock TDM_GiveTeamScore(sessionid, teamid, num)
{
	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		case TDM_GAME_MODE_CAPTURE: TDM_GiveCPTeamScore(sessionid, teamid, num);
		case TDM_GAME_MODE_CAPTURE_FLAG: TDM_GiveFlagTeamScore(sessionid, teamid, num);
		case TDM_GAME_MODE_SECRET_DATA: TDM_GiveCompTeamScore(sessionid, teamid, num);
		case TDM_GAME_MODE_BATTLE_KILLS: TDM_GiveBattleTeamScore(sessionid, teamid, num);
	}
	return 1;
}

stock TDM_GiveTeamModeMaxScore(sessionid, teamid, num)
{
	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		case TDM_GAME_MODE_CAPTURE: TDM_GiveCPTeamMaxScore(sessionid, teamid, num);
		case TDM_GAME_MODE_CAPTURE_FLAG: TDM_GiveFlagTeamMaxScore(sessionid, teamid, num);
		case TDM_GAME_MODE_SECRET_DATA: TDM_GiveCompTeamMaxScore(sessionid, teamid, num);
		case TDM_GAME_MODE_BATTLE_KILLS: TDM_GiveBattleTeamMaxScore(sessionid, teamid, num);
	}
	return 1;
}

stock TDM_ResetTeamModeMaxScore(sessionid, teamid)
{
	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		case TDM_GAME_MODE_CAPTURE: TDM_ResetCPTeamMaxScore(sessionid, teamid);
		case TDM_GAME_MODE_CAPTURE_FLAG: TDM_ResetFlagTeamMaxScore(sessionid, teamid);
		case TDM_GAME_MODE_SECRET_DATA: TDM_ResetCompTeamMaxScore(sessionid, teamid);
		case TDM_GAME_MODE_BATTLE_KILLS: TDM_ResetBattleTeamMaxScore(sessionid, teamid);
	}
	return 1;
}

stock TDM_GetTeamMaxScore(sessionid, teamid)
{
	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		case TDM_GAME_MODE_CAPTURE: return TDM_GetCPTeamMaxScore(sessionid, teamid);
		case TDM_GAME_MODE_CAPTURE_FLAG: return TDM_GetFlagTeamMaxScore(sessionid, teamid);
		case TDM_GAME_MODE_SECRET_DATA: return TDM_GetCompTeamMaxScore(sessionid, teamid);
		case TDM_GAME_MODE_BATTLE_KILLS: return TDM_GetBattleTeamMaxScore(sessionid, teamid);
	}
	return 1;
}

stock TDM_ShowPlayerTeamsScoreTD(playerid)
{
	new
		tdid = 0,
		sessionid = M_GPS(playerid);

	foreach (new teamid:TDM_ActiveTeamsScore[sessionid]) {
		ShowPlayerTeamScoreTD(playerid, tdid, teamid, TDM_GetTeamMaxScore(sessionid, teamid));
		tdid++;
	}
	UpdatePlayerTeamScoreTD(playerid);
	return 1;
}

static ShowPlayerTeamScoreTD(playerid, tdid, teamid, maxscore)
{
	new
		sessionid = Mode_GetPlayerSession(playerid),
		maxScore = floatround(maxscore),
		teams = Iter_Count(TDM_ActiveTeamsScore[sessionid]);

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

stock TDM_DestroyPlayerTeamsScoreTD(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid),
		tdid, 
		barid;

	foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
		DestroyPlayerTD(playerid, TD_TeamScore[playerid][tdid]);
		DestroyPlayerTD(playerid, TD_TeamScore[playerid][tdid + 1]);

		DestroyPlayerProgressBar(playerid, PlayerBarScoreMatch[playerid][barid]);

		tdid += 2;
		barid++;
	}
	return 1;
}

static UpdatePlayerTeamScoreTD(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid),
		b = 1, 
		ttd;
		
	foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
		new 
			str[15];

		switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
			case TDM_GAME_MODE_CAPTURE: {
				f(str, "%i", TDM_GetTeamScore(sessionid, tt));
			}
			case TDM_GAME_MODE_CAPTURE_FLAG: {
				f(str, "%i/%i", TDM_GetTeamScore(sessionid, tt), TDM_GetTeamMaxScore(sessionid, tt));
			}
			case TDM_GAME_MODE_SECRET_DATA: {
				f(str, "%i/%i", TDM_GetTeamScore(sessionid, tt), TDM_GetTeamMaxScore(sessionid, tt));
			}
			case TDM_GAME_MODE_BATTLE_KILLS: {
				f(str, "%i", TDM_GetTeamScore(sessionid, tt));
			}
		}
		PlayerTextDrawSetString(playerid, TD_TeamScore[playerid][b], str);
		SetPlayerProgressBarValue(playerid, PlayerBarScoreMatch[playerid][ttd], floatround(TDM_GetTeamScore(sessionid, tt)));

		b += 2;
		ttd++;
	}
	return 1;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

stock TDM_CallPlayerCommand(playerid, const cmdName[], const params[])
{
	TDM_CallPlayerClassCommand(playerid, cmdName, params);
	TDM_LocCallPlayerCommand(playerid, cmdName, params);
	return 1;
}

stock TDM_UpdatePlayerMG(playerid)
{
	TDM_LocUpdatePlayerMG(playerid);
	return 1;
}

stock TDM_UpdatePlayerSpecStatus(playerid, spectedid)
{
	if (PlayerSelectSquadPlayerID[playerid] != -1 
	&& PlayerSelectSquadPlayerID[playerid] != -2) {
		if (Mode_IsPlayerInPlayer(playerid, spectedid)
		&& GetPlayerDead(spectedid) == PLAYER_DEATH_NONE
		&& !PlayerActiveSelectSpawn{spectedid}) {
			UpdateSpectatingPlayer(playerid, spectedid);
		}
	}
	return 1;
}

stock TDM_GivePlayerWeapon(playerid, WEAPON:weaponid, ammo)
{
	new
		WEAPON:dWeaponid,
		dAmmo = ammo - ammo;

	GetPlayerWeaponData(playerid, GetWeaponSlot(weaponid), dWeaponid, dAmmo);

	if (dWeaponid > WEAPON_FIST 
	&& dAmmo > 0) {
		if (dWeaponid == weaponid) {
			if (dAmmo > 2000) {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Извините, но патронов и так много.");
				return 0;
			}
		}
	}
	return 1;
}

stock TDM_SetTextTeamMatch(const sessionid, const text[], teamid = 0, timer = 4)
{
	if (teamid != TDM_TEAM_NONE) {
		TimerMatchText[sessionid][teamid] = timer;
	}
	else {
		foreach (new tt:TDM_ActiveTeams[sessionid]) {
			TimerMatchText[sessionid][tt] = timer;
		}
	}

	m_for(MODE_TDM, sessionid, p) {
		if (GetAdminSpectating(p)) {
			continue;
		}

		if (teamid != TDM_TEAM_NONE
		&& GetPlayerTeamEx(p) != teamid) {
			continue;
		}

		if (PlayerActiveSelectSpawn{p}) {
			continue;
		}

		if (PlayerActiveMatchTextTD{p}) {
			DestroyPlTextTeamMatchTD(p, GetPlayerTeamEx(p));
		}

		UpdatePlayerTextTeamMatchTD(p, text);
	}
	return 1;
}

stock TDM_GetStatusGame(sessionid)
{
	return LocationGameStatus[sessionid];
}

static ShowLocationEndGame(sessionid) 
{
	LocationGameStatus[sessionid] = TDM_GAME_STATUS_RESULT;
	LocationEndTimer[sessionid] = TDM_LOC_END_TIMER;

	// Top kills by teams
	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		m_for(MODE_TDM, sessionid, p) {
			if (GetAdminSpectating(p)) {
				continue;
			}

			if (GetPlayerTeamEx(p) != tt) {
				continue;
			}

			TOPPlayersData[sessionid][tt][TOPTempVar[sessionid][tt]][0] = Mode_GetPlayerMatchKills(p);
			TOPPlayersData[sessionid][tt][TOPTempVar[sessionid][tt]][2] = Mode_GetPlayerMatchDeaths(p);
			GetPlayerName(p, TOPPlayersName[sessionid][tt][p], MAX_PLAYER_NAME);
			TOPPlayersData[sessionid][tt][TOPTempVar[sessionid][tt]++][1] = p;
		}
	}
	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		for (new i = 0, j = 0; i < TOPTempVar[sessionid][tt]; i++) {
			j = TOPPlayersData[sessionid][tt][i][0];

			for (new k = i - 1; k > -1; k--) {
				if (j > TOPPlayersData[sessionid][tt][k][0]) {
					TOPPlayersData[sessionid][tt][k][0] ^= TOPPlayersData[sessionid][tt][k + 1][0], TOPPlayersData[sessionid][tt][k + 1][0] ^= TOPPlayersData[sessionid][tt][k][0], TOPPlayersData[sessionid][tt][k][0] ^= TOPPlayersData[sessionid][tt][k + 1][0];
					TOPPlayersData[sessionid][tt][k][1] ^= TOPPlayersData[sessionid][tt][k + 1][1], TOPPlayersData[sessionid][tt][k + 1][1] ^= TOPPlayersData[sessionid][tt][k][1], TOPPlayersData[sessionid][tt][k][1] ^= TOPPlayersData[sessionid][tt][k + 1][1];
				}
			}
		}
	}

	// Top 5 Kills
	m_for(MODE_TDM, sessionid, p) {
		if (GetAdminSpectating(p)) {
			continue;
		}

		TOPActorData[sessionid][TOPActorTempVar[sessionid]][0] = Mode_GetPlayerMatchKills(p);
		TOPActorData[sessionid][TOPActorTempVar[sessionid]][2] = Mode_GetPlayerMatchDeaths(p);
		GetPlayerName(p, TOPActorName[sessionid][p], MAX_PLAYER_NAME);
		TOPActorData[sessionid][TOPActorTempVar[sessionid]++][1] = p;

		TOPActorTeam[sessionid][p] = GetPlayerTeamEx(p);
		TOPActorSkin[sessionid][p] = TDM_GetClassSkin(GetPlayerTeamEx(p), GetPlayerCustomClass(p), GetPlayerSex(p));
	}
	for (new i = 0, j = 0; i < TOPActorTempVar[sessionid]; i++) {
		j = TOPActorData[sessionid][i][0];

		for (new k = i - 1; k > -1; k--) {
			if (j > TOPActorData[sessionid][k][0]) {
				TOPActorData[sessionid][k][0] ^= TOPActorData[sessionid][k + 1][0], TOPActorData[sessionid][k + 1][0] ^= TOPActorData[sessionid][k][0], TOPActorData[sessionid][k][0] ^= TOPActorData[sessionid][k + 1][0];
				TOPActorData[sessionid][k][1] ^= TOPActorData[sessionid][k + 1][1], TOPActorData[sessionid][k + 1][1] ^= TOPActorData[sessionid][k][1], TOPActorData[sessionid][k][1] ^= TOPActorData[sessionid][k + 1][1];
			}
		}
	}

	// Actors top 5 kills
	n_for(actorid, 5) {
		if (TOPActorData[sessionid][actorid][1] > -1) {
			new
				Float:X, Float:Y, Float:Z, Float:Angle,
				actorid2 = TOPActorData[sessionid][actorid][1];

			TDM_GetSpawnTopActor(sessionid, actorid2, X, Y, Z, Angle);

			TOPActorKills[sessionid][actorid] = CreateDynamicActor(TOPActorSkin[sessionid][actorid], X, Y, Z, Angle, true, 100.0, Mode_GetSessionVirtualWorld(MODE_TDM, sessionid), Mode_GetSessionInterior(MODE_TDM, sessionid));

			switch (actorid) {
				case 0: ApplyDynamicActorAnimation(TOPActorKills[sessionid][actorid], "BENCHPRESS", "GYM_BP_CELEBRATE", 4.0, 1, 0, 0, 0, 0);
				case 1: ApplyDynamicActorAnimation(TOPActorKills[sessionid][actorid], "PED", "XPRESSSCRATCH", 4.0, 1, 0, 0, 0, 0);
				case 2: ApplyDynamicActorAnimation(TOPActorKills[sessionid][actorid], "PED", "IDLE_HBHB", 4.0, 1, 0, 0, 0, 0);
				case 3: ApplyDynamicActorAnimation(TOPActorKills[sessionid][actorid], "PED", "IDLE_TIRED", 4.0, 1, 0, 0, 0, 0);
				case 4: ApplyDynamicActorAnimation(TOPActorKills[sessionid][actorid], "PED", "SHOT_PARTIAL", 4.0, 1, 0, 0, 0, 0);
			}

			new
				str[100];

			f(str, ""CT_WHITE"%i Место\n%s%s\n"CT_WHITE"Убийств: {d91616}%i", actorid + 1, TDM_GetTeamColor(TOPActorTeam[sessionid][actorid]), TOPActorName[sessionid][actorid], TOPActorData[sessionid][actorid][0]);
			TOPActor3DText[sessionid][actorid] = CreateDynamic3DTextLabel(str, C_WHITE, X, Y, Z + 0.2, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, Mode_GetSessionVirtualWorld(MODE_TDM, sessionid), Mode_GetSessionInterior(MODE_TDM, sessionid));
		}
	}

	ShowMatchResult(sessionid);

	m_for(MODE_TDM, sessionid, p) {
		if (!GetAdminSpectating(p)) {
			HidePlayerMatchEndElements(p);
		}
	}

	Mode_StreamerUpdate(MODE_TDM, sessionid);
	return 1;
}

static ShowMatchResult(sessionid)
{
	new
		modeid = Mode_GetSessionGameMode(MODE_TDM, sessionid),
		maxNumber,
		bool:winTeam[TDM_MAX_TEAMS],
		bool:drawTeam[TDM_MAX_TEAMS],
		rewardExp[3],
		rewardMoney[3];

	switch (modeid) {
		case TDM_GAME_MODE_CAPTURE: {
			foreach (new c:TDM_ActiveTeamsScore[sessionid]) {
				if (TDM_GetTeamScore(sessionid, c) > maxNumber) {
					winTeam[c] = true;
					maxNumber = TDM_GetTeamScore(sessionid, c);

					foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
						if (tt == c) {
							continue;
						}

						if (TDM_GetTeamScore(sessionid, tt) < TDM_GetTeamScore(sessionid, c)) {
							winTeam[tt] =
							drawTeam[tt] = false;
						}
						else if (TDM_GetTeamScore(sessionid, tt) == TDM_GetTeamScore(sessionid, c)) {
							drawTeam[c] = true;
						}
					}
				}
				else if (TDM_GetTeamScore(sessionid, c) == maxNumber) {
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
		case TDM_GAME_MODE_CAPTURE_FLAG: {
			foreach (new c:TDM_ActiveTeamsScore[sessionid]) {
				if (TDM_GetTeamScore(sessionid, c) > maxNumber) {
					winTeam[c] = true;
					maxNumber = TDM_GetTeamScore(sessionid, c);

					foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
						if (tt == c) {
							continue;
						}

						if (TDM_GetTeamScore(sessionid, tt) < TDM_GetTeamScore(sessionid, c)) {
							winTeam[tt] =
							drawTeam[tt] = false;
						}
						else if (TDM_GetTeamScore(sessionid, tt) == TDM_GetTeamScore(sessionid, c)) {
							drawTeam[c] = true;
						}
					}
				}
				else if (TDM_GetTeamScore(sessionid, c) == maxNumber) {
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
		case TDM_GAME_MODE_SECRET_DATA: {
			new
				bool:checkTeamScore,
				bool:checkWinProtectTeam;

			foreach (new tt:TDM_ActiveTeams[sessionid]) {
				if (!TDM_CheckTeamScore(sessionid, tt)) {
					checkTeamScore = true;
				}
			}

			if (checkTeamScore) {
				foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
					if (TDM_GetTeamScore(sessionid, tt) < 1) {
						winTeam[tt] = false;
					}
					else {
						winTeam[tt] =
						checkWinProtectTeam = true;
					}
				}
				if (checkWinProtectTeam) {
					foreach (new tt:TDM_ActiveTeams[sessionid]) {
						if (!TDM_CheckTeamScore(sessionid, tt)) {
							winTeam[tt] = false;
						}
					}
				}
				else {
					foreach (new tt:TDM_ActiveTeams[sessionid]) {
						if (!TDM_CheckTeamScore(sessionid, tt)) {
							winTeam[tt] = true;
						}
					}
				}
			}
			else {
				foreach (new c:TDM_ActiveTeamsScore[sessionid]) {
					if (TDM_GetTeamScore(sessionid, c) > maxNumber) {
						winTeam[c] = true;
						maxNumber = TDM_GetTeamScore(sessionid, c);

						foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
							if (tt == c) {
								continue;
							}

							if (TDM_GetTeamScore(sessionid, tt) < TDM_GetTeamScore(sessionid, c)) {
								winTeam[tt] =
								drawTeam[tt] = false;
							}
							else if (TDM_GetTeamScore(sessionid, tt) == TDM_GetTeamScore(sessionid, c)) {
								drawTeam[c] = true;
							}
						}
					}
					else if (TDM_GetTeamScore(sessionid, c) == maxNumber) {
						winTeam[c] =
						drawTeam[c] = true;
					}
				}
			}
			rewardExp[0] = 1000; 	// Win
			rewardExp[1] = 500; 	// Loss
			rewardExp[2] = 600; 	// Draw

			rewardMoney[0] = 800; 	// Win
			rewardMoney[1] = 300; 	// Loss
			rewardMoney[2] = 400; 	// Draw
		}
		case TDM_GAME_MODE_BATTLE_KILLS: {
			foreach (new c:TDM_ActiveTeamsScore[sessionid]) {
				if (TDM_GetTeamScore(sessionid, c) > maxNumber) {
					winTeam[c] = true;
					maxNumber = TDM_GetTeamScore(sessionid, c);

					foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
						if (tt == c) {
							continue;
						}

						if (TDM_GetTeamScore(sessionid, tt) < TDM_GetTeamScore(sessionid, c)) {
							winTeam[tt] =
							drawTeam[tt] = false;
						}
						else if (TDM_GetTeamScore(sessionid, tt) == TDM_GetTeamScore(sessionid, c)) {
							drawTeam[c] = true;
						}
					}
				}
				else if (TDM_GetTeamScore(sessionid, c) == maxNumber) {
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
	}
	m_for(MODE_TDM, sessionid, p) {
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

static HideResultMatch(sessionid)
{
	n_for(actorid, 5) {
		if (IsValidDynamicActor(TOPActorKills[sessionid][actorid])) {
			DestroyDynamicActor(TOPActorKills[sessionid][actorid]);
		}

		if (IsValidDynamic3DTextLabel(TOPActor3DText[sessionid][actorid])) {
			DestroyDynamic3DTextLabel(TOPActor3DText[sessionid][actorid]);
		}
	}

	ResetTopPlayers(sessionid);
	ResetTopActors(sessionid);
	return 1;
}

static ShowGoalLocation(playerid) 
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		case TDM_GAME_MODE_CAPTURE: {
			SCM(playerid, C_ORANGE, ""T_MATCH" "CT_WHITE"Захватывайте точки!");
		}
		case TDM_GAME_MODE_CAPTURE_FLAG: {
			SCM(playerid, C_ORANGE, ""T_MATCH" "CT_WHITE"Присвойте флаги противника!");
		}
		case TDM_GAME_MODE_SECRET_DATA: {
			SCM(playerid, C_ORANGE, ""T_MATCH" "CT_WHITE"Взломайте/деактивируйте компьютеры!");
		}
		case TDM_GAME_MODE_BATTLE_KILLS: {
			SCM(playerid, C_ORANGE, ""T_MATCH" "CT_WHITE"Одолейте все силы противника!");
		}
	}
	return 1;
}

static UpdateTeamsScore(sessionid) 
{
	new 
		bool:endGame;

	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		case TDM_GAME_MODE_CAPTURE: {
			foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
				if (TDM_GetTeamScore(sessionid, tt) < TDM_GetTeamMaxScore(sessionid, tt)) {
					TDM_GiveTeamScore(sessionid, tt, 1);

					TDM_GiveCPPointTeam(sessionid, tt);

					if (TDM_GetTeamScore(sessionid, tt) >= TDM_GetTeamMaxScore(sessionid, tt)) {
						m_for(MODE_TDM, sessionid, p) 
							UpdatePlayerTeamScoreTD(p);

						endGame = true;
					}
				}
			}
		}
		case TDM_GAME_MODE_CAPTURE_FLAG: {
			foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
				if (TDM_GetTeamScore(sessionid, tt) >= TDM_GetTeamMaxScore(sessionid, tt)) {
					endGame = true;
				}
			}
		}
		case TDM_GAME_MODE_SECRET_DATA: {
			foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
				if (TDM_GetTeamScore(sessionid, tt) < 1) {
					endGame = true;
				}
			}
		}
		case TDM_GAME_MODE_BATTLE_KILLS: {
			foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
				if (TDM_GetTeamScore(sessionid, tt) >= TDM_GetTeamMaxScore(sessionid, tt)) {
					endGame = true;
				}
			}
		}
	}

	if (endGame) {
		ShowLocationEndGame(sessionid);
	}
	return 1;
}

static CreatePlayerNextLocation(playerid)
{
	if (GetPVarInt(playerid, "TDM_ActiveNextLocation") == 1) {
		return 1;
	}

	SetPVarInt(playerid, "TDM_ActiveNextLocation", 1);

	TDM_CreatePlTimerNextLocationTD(playerid, TD_TNextLocation[playerid]);
	PlayerTextDrawShow(playerid, TD_TNextLocation[playerid]);
	return 1;
}

static DestroyPlayerNextLocation(playerid)
{
	if (GetPVarInt(playerid, "TDM_ActiveNextLocation") != 1) {
		return 1;
	}

	PlayerSelectVoteLocation[playerid] = -1;
	DeletePVar(playerid, "TDM_ActiveNextLocation");
	DestroyPlayerTD(playerid, TD_TNextLocation[playerid]);
	return 1;
}

static UpdatePlayerNextLocation(playerid)
{
	if (GetPVarInt(playerid, "TDM_ActiveNextLocation") != 1) {
		return 1;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	PlayerTextDrawSetString(playerid, TD_TNextLocation[playerid], "Следующая_локация_через:_~y~%i_", LocationEndTimer[sessionid]);
	return 1;
}

static HidePlayerMatchEndElements(playerid)
{
	ResetPlayerMGData(playerid);
	HidePlayerExitZone(playerid);

	SetPlayerDamage(playerid, false);

	if (PlayerActiveSelectSpawn{playerid}) {
		HidePlayerSelectSpawn(playerid, false);
	}
	else {
		DestroyPlayerBelowHealth(playerid);
		HidePlayerBaseIndicatorsTD(playerid);
		Mode_DestroyPlayerMatchPointsTD(playerid);
		HidePlayerNewGraphTD(playerid);
		DestroyPlayerMatchStatsTD(playerid);
	}

	HidePlayerKillStrike(playerid);
	ClearKillFeed(playerid);
	DestroyPlayerSpawnKill(playerid);

	Interface_Close(playerid, Interface:TDM_SelectSpawn);

	if (GetPlayerDead(playerid) == PLAYER_DEATH_NONE) {
		CreatePlayerNextLocation(playerid);

		SpecPl(playerid, true);
		ShowPlayerMatchResult(playerid);
		TDM_ShowCameraEndLocation(playerid, 1);

		Mode_ResetPlayerMacthPoints(playerid);
		Mode_ResetPlayerMatchKills(playerid);
		Mode_ResetPlayerMatchDeaths(playerid);
	}
	SetPlayerHealthEx(playerid, 100.0);
	return 1;
}

static ShowPlayerTextTeamMatchTD(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		if (GetPlayerTeamEx(playerid) != tt) {
			continue;
		}

		TDM_CreatePlayerTextTeamMatchTD(playerid, TD_TextTeamMatch[playerid][tt]);
	}
	return 1;
}

static UpdatePlayerTextTeamMatchTD(playerid, const text[])
{
	if (PlayerActiveMatchTextTD{playerid}) {
		return 1;
	}

	new
		playerTeam = GetPlayerTeamEx(playerid);

	PlayerActiveMatchTextTD{playerid} = true;
	ShowPlayerTextTeamMatchTD(playerid);
	PlayerTextDrawSetString(playerid, TD_TextTeamMatch[playerid][playerTeam], text);
	PlayerTextDrawShow(playerid, TD_TextTeamMatch[playerid][playerTeam]);
	return 1;
}

static DestroyPlTextTeamMatchTD(playerid, playerTeam)
{
	if (!PlayerActiveMatchTextTD{playerid}) {
		return 1;
	}

	PlayerActiveMatchTextTD{playerid} = false;
	DestroyPlayerTD(playerid, TD_TextTeamMatch[playerid][playerTeam]);
	return 1;
}

static UpdatePlCellsNextLocationTD(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	for (new td = 4, i = 0; i < TDM_MAX_CHANGE_MAP_LIST; td += 4, i++) {
		PlayerTextDrawSetString(playerid, TD_SelectNextLocation[playerid][td], "%s", Mode_GetLocationName(MODE_TDM, ChangeLocationList[sessionid][i]));
	
		new
			modeName[GMS_MAX_LENGTH_GAME_MODE_NAME];

		f(modeName, "%s", Mode_GetGameModeName(MODE_TDM, Mode_GetLocationGameMode(MODE_TDM, ChangeLocationList[sessionid][i])));
	
		for (new text = strlen(modeName) - 1; text != -1; text--) {
			switch (modeName[text]) {
				case ' ': modeName[text] = '_';
			}
		}

		PlayerTextDrawSetString(playerid, TD_SelectNextLocation[playerid][td + 1], "%s", modeName);
		PlayerTextDrawSetString(playerid, TD_SelectNextLocation[playerid][td + 2], "Голосов:_%i", SelectVoteLocation[sessionid][i]);
	}
	return 1;
}

static UpdatePlTDCellsVoiceLocation(playerid)
{
	if (!PlayerActiveNextLocationTD{playerid}) {
		return 1;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	for (new td = 6, i = 0; i < TDM_MAX_CHANGE_MAP_LIST; td += 4, i++) {
		PlayerTextDrawSetString(playerid, TD_SelectNextLocation[playerid][td], "Голосов:_%i", SelectVoteLocation[sessionid][i]);
	}
	return 1;
}

static CreatePlayerNextLocationTD(playerid)
{
	if (PlayerActiveNextLocationTD{playerid}) {
		return 1;
	}

	Interface_Show(playerid, Interface:TDM_SelectNextLoc);
	return 1;
}

static DestroyPlSelectNextLocationTD(playerid)
{
	if (!PlayerActiveNextLocationTD{playerid}) {
		return 1;
	}

	Interface_Close(playerid, Interface:TDM_SelectNextLoc);
	return 1;
}

static ShowPlSelectNextLocationTD(playerid)
{
	new
		td = 0;

	TDM_CreatePlayerSelectNextLocTD(playerid, TD_SelectNextLocation[playerid], 0.0, 0.0, false, td);

	new
		Float:initialCoords[2] = {230.0, 135.0};

	for (new s = 1; td < TDM_TD_SELECT_NEXT_LOCATION; s++) {
		TDM_CreatePlayerSelectNextLocTD(playerid, TD_SelectNextLocation[playerid], initialCoords[0], initialCoords[1], true, td);
		initialCoords[0] += 60.0;
	}
	return 1;
}

static RandomLocationList(sessionid)
{
	new
		amountLocations = Iter_Count(Locations[MODE_TDM]),
		randomLocation;

	n_for(i, amountLocations) {
		NotSelectedLocations[sessionid][i] = i;
	}
	n_for(i, TDM_MAX_CHANGE_MAP_LIST) {
		amountLocations--;
		randomLocation = random_ex(0, amountLocations, 1);
		ChangeLocationList[sessionid][i] = NotSelectedLocations[sessionid][randomLocation];
		NotSelectedLocations[sessionid][randomLocation] = NotSelectedLocations[sessionid][amountLocations];
	}
	return 1;
}

static SettingsPlayerSpawn(playerid)
{
	new
		Float:X, Float:Y, Float:Z,
		skinid = Mode_GetPlayerSkin(playerid, MODE_TDM),
		sessionid = Mode_GetPlayerSession(playerid),
		randomPos = random(3);
	
	Mode_SetPlayerVirtualWorld(playerid, MODE_TDM, sessionid);
	Mode_SetPlayerInterior(playerid, MODE_TDM, sessionid);
	
	TDM_GetBaseSpawn(sessionid, GetPlayerTeamEx(playerid), randomPos, X, Y, Z);
	SetSpawnInfoEx(playerid, skinid, X, Y, Z + 0.3, 0.0);
	return 1;
}

static SetPlayerAmmunition(playerid)
{
	TDM_SetPlayerClassAmmunition(playerid);

	if (GetPlayerPremium(playerid) != PREMIUM_LEVEL_NONE) {
		GivePlayerWeaponEx(playerid, WEAPON_ROCKETLAUNCHER, 10);
	}
	
	SetPlayerColorEx(playerid, TDM_GetTeamColorXB(GetPlayerTeamEx(playerid)));
	return 1;
}

static ResetTopPlayers(sessionid)
{
	n_for(tt, TDM_MAX_TEAMS) {
		n_for2(b, 10) {
			TOPPlayersData[sessionid][tt][b][0] =
			TOPPlayersData[sessionid][tt][b][1] =
			TOPPlayersData[sessionid][tt][b][2] = -1;
			TOPPlayersName[sessionid][tt][b][0] = EOS;
		}
		TOPTempVar[sessionid][tt] = 0;
	}
	return 1;
}

static ResetTopActors(sessionid)
{
	n_for(b, 5) {
		TOPActor3DText[sessionid][b] = INVALID_DYNAMIC_3D_TEXT_ID;

		TOPActorData[sessionid][b][0] =
		TOPActorData[sessionid][b][1] =
		TOPActorData[sessionid][b][2] = -1;
		TOPActorName[sessionid][b][0] = EOS;
		TOPActorTeam[sessionid][b] =
		TOPActorSkin[sessionid][b] = 0;
	}
	TOPActorTempVar[sessionid] = 0;
	return 1;
}

static ShowPlayerMatchResult(playerid)
{
	if (GetPVarInt(playerid, "ActiveMatchResult")) {
		return 1;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	SetPVarInt(playerid, "ActiveMatchResult", 1);
	
	new 
		teams = Iter_Count(TDM_ActiveTeams[sessionid]),
		num;

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		if (IsCh(tt)) {
			CreatePlayerResultScoreTD(playerid, tt, false, num, teams);
		}
		else { 
			if ((num + 1) == teams) {
				CreatePlayerResultScoreTD(playerid, tt, true, num, teams);
			}
			else { 
				CreatePlayerResultScoreTD(playerid, tt, false, num, teams);
			}
		}
		num++;
	}
	return 1;
}

static HidePlayerMatchResult(playerid)
{
	if (!GetPVarInt(playerid, "ActiveMatchResult")) {
		return 1;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	DeletePVar(playerid, "ActiveMatchResult");

	new
		num;

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		n_for(i, TDM_TD_MATCH_RESULT) {
			DestroyPlayerTD(playerid, TD_MatchResult[playerid][num][i]);
		}

		n_for(i, TDM_MAX_TOP_KILLERS) {
			n_for2(b, TDM_TD_TOP_KILLERS) {
				DestroyPlayerTD(playerid, TD_TopKillers[playerid][num][i][b]);
			}
		}
		num++;
	}
	n_for(i, TDM_TD_END_MATCH_STATS) {
		DestroyPlayerTD(playerid, TD_EndMatchStats[playerid][i]);
	}
	return 1;
}

static CreatePlayerTeamScoreTD(playerid, tdid = -1, onetdid = -1, teamid, maxscore)
{
	if (onetdid != -1) {
		switch (onetdid) {
			case 0: {
				PlayerBarScoreMatch[playerid][0] = CreatePlayerProgressBar(playerid, 284.00, 43.00, 84.50, 5.19, TDM_GetTeamColorXB(teamid), maxscore, BAR_DIRECTION_RIGHT);
			}
			case 2: {
				PlayerBarScoreMatch[playerid][2] = CreatePlayerProgressBar(playerid, 284.00, 65.00, 84.50, 5.19, TDM_GetTeamColorXB(teamid), maxscore, BAR_DIRECTION_RIGHT);
			}
		}
	}

	if (tdid != -1) {
		switch (tdid) {
			case 0: {
				PlayerBarScoreMatch[playerid][0] = CreatePlayerProgressBar(playerid, 233.00, 43.00, 84.50, 5.19, TDM_GetTeamColorXB(teamid), maxscore, BAR_DIRECTION_LEFT);
			}
			case 1: {
				PlayerBarScoreMatch[playerid][1] = CreatePlayerProgressBar(playerid, 327.00, 43.00, 84.50, 5.19, TDM_GetTeamColorXB(teamid), maxscore, BAR_DIRECTION_RIGHT);
			}
			case 2: {
				PlayerBarScoreMatch[playerid][2] = CreatePlayerProgressBar(playerid, 233.00, 65.00, 84.50, 5.19, TDM_GetTeamColorXB(teamid), maxscore, BAR_DIRECTION_LEFT);
			}
			case 3: {
				PlayerBarScoreMatch[playerid][3] = CreatePlayerProgressBar(playerid, 327.00, 65.00, 84.50, 5.19, TDM_GetTeamColorXB(teamid), maxscore, BAR_DIRECTION_RIGHT);
			}
		}
	}

	TDM_CreatePlayerTeamScoreTD(playerid, TD_TeamScore[playerid], tdid, onetdid, TDM_GetTeamName(teamid), TDM_GetTeamColorXB(teamid));
	return 1;
}

static CreatePlayerSelectPointTD(playerid) 
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Coordinates of square TD's depending on their number
	static const
		Float:posTD[][][] = {
		{
			{300.0, 305.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0}
		},
		{
			{270.0, 305.0},
			{328.0, 305.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0}
		},
		{
			{242.0, 305.0},
			{300.0, 305.0},
			{358.0, 305.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0}
		},
		{
			{212.0, 305.0},
			{270.0, 305.0},
			{328.0, 305.0},
			{386.0, 305.0},
			{0.0, 0.0},
			{0.0, 0.0},
			{0.0, 0.0}
		},
		{
			{184.0, 305.0},
			{242.0, 305.0},
			{300.0, 305.0},
			{358.0, 305.0},
			{416.0, 305.0},
			{0.0, 0.0},
			{0.0, 0.0}
		},
		{
			{156.0, 305.0},
			{214.0, 305.0},
			{272.0, 305.0},
			{330.0, 305.0},
			{388.0, 305.0},
			{446.0, 305.0},
			{0.0, 0.0}
		},
		{
			{124.0, 305.0},
			{182.0, 305.0},
			{240.0, 305.0},
			{298.0, 305.0},
			{356.0, 305.0},
			{414.0, 305.0},
			{472.0, 305.0}
		}
	};

	new
		point;

	foreach (new g:TDM_CapturePointCount[sessionid]) {
		point++;
	}

	if (point > 0) {
		for (new i = 0, td = 0, points = point - 1; i < point; i++) {
			new
				pointStatus[50];

			if (TDM_GetCapturePointTeam(sessionid, i) != GetPlayerTeamEx(playerid)) {
				strcopy(pointStatus, "ЗАХВАТИТЬ");
			}
			else {
				if (!TDM_GetCapturePointRed(sessionid, i)) {
					strcopy(pointStatus, "ЗАЩИЩАТЬ");
				}
				else {
					strcopy(pointStatus, "ТЕРЯЕМ");
				}
			}

			TDM_CreatePlayerSelectPointTD(playerid, TD_SelectPoint[playerid],
			posTD[points][i][0], posTD[points][i][1], td,
			GetNamePointABC(i), TDM_GetCapturePointName(sessionid, i), pointStatus,
			TDM_GetTeamColorXF(TDM_GetCapturePointTeam(sessionid, i)));
		}
	}
	return 1;
}

static CreateSelectSpawnPlayerTD(playerid)
{
	new
		Float:initialCoords[2] = {157.0, 361.0},
		td = 0;

	n_for(i, 5) {
		if (i == 4) {
			TDM_CreatePlayerSelectPlayerTD(playerid, TD_SelectPlayer[playerid], initialCoords[0], initialCoords[1], .base = true, .startTD = td);
			break;
		}

		TDM_CreatePlayerSelectPlayerTD(playerid, TD_SelectPlayer[playerid], initialCoords[0], initialCoords[1], .base = false, .startTD = td);
		initialCoords[0] += 69.0;
	}
	return 1;
}

static CreatePlayerSelectTeamTD(playerid, tdid = -1, onetdid = -1, teamid)
{
	new
		players;

	m_for(MODE_TDM, Mode_GetPlayerSession(playerid), p) {
		if (GetAdminSpectating(p)) {
			continue;
		}

		if (GetPlayerTeamEx(p) != teamid) {
			continue;
		}

		players++;
	}

	TDM_CreatePlayerSelectTeamTD(playerid, TD_SelectTeam[playerid], tdid, onetdid, TDM_GetTeamName(teamid), players, TDM_GetTeamColorXF(teamid));
	return 1;
}

static CreatePlayerResultScoreTD(playerid, teamid, bool:activeTD, num, teams)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	static const
		Float:pos_td_id[TDM_MAX_TEAMS][2] = 
		{
			{132.0, 112.0},
			{330.0, 112.0},
			{132.0, 257.0},
			{330.0, 257.0},
			{0.0, 0.0}
		},
		Float:pos_td_one_id[TDM_MAX_TEAMS][2] = {
			{220.0, 112.0},
			{0.0, 0.0},
			{220.0, 257.0},
			{0.0, 0.0},
			{0.0, 0.0}
		};

	new
		Float:posTD[2],
		tdid;

	if (!activeTD) {
		n_for(i, 2) {
			posTD[i] = pos_td_id[num][i];
		}
	}
	else {
		n_for(i, 2) {
			posTD[i] = pos_td_one_id[num][i];
		}
	}

	// Match result
	TDM_CreatePlayerMatchResultTD(playerid, TD_MatchResult[playerid][num], posTD[0], posTD[1]);

	PlayerTextDrawBackgroundColour(playerid, TD_MatchResult[playerid][num][1], TDM_GetTeamColorXB(teamid));
	PlayerTextDrawBackgroundColour(playerid, TD_MatchResult[playerid][num][2], TDM_GetTeamColorXB(teamid));
	PlayerTextDrawBackgroundColour(playerid, TD_MatchResult[playerid][num][3], TDM_GetTeamColorXB(teamid));
	PlayerTextDrawBackgroundColour(playerid, TD_MatchResult[playerid][num][4], TDM_GetTeamColorXB(teamid));

	PlayerTextDrawSetString(playerid, TD_MatchResult[playerid][num][8], TDM_GetTeamName(teamid));
	PlayerTextDrawColour(playerid, TD_MatchResult[playerid][num][8], TDM_GetTeamColorXF(teamid));

	n_for(i, TDM_TD_MATCH_RESULT) {
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

		TDM_CreatePlayerEndMatchStatsTD(playerid, TD_EndMatchStats[playerid], posStatsTD[0], posStatsTD[1]);

		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][1], "Ранг:_~y~%i", GetPlayerRank(playerid));
		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][2], "Убийств:_~b~%i", Mode_GetPlayerMatchKills(playerid));
		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][3], "Смертей:_~r~%i", Mode_GetPlayerMatchDeaths(playerid));
		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][5], "Получено всего EXP:_~y~+%i", Mode_GetPlayerMatchExp(playerid));
		PlayerTextDrawSetString(playerid, TD_EndMatchStats[playerid][6], "Получено всего денег:_~g~+$%i", Mode_GetPlayerMatchMoney(playerid));

		n_for(i, TDM_TD_END_MATCH_STATS) {
			PlayerTextDrawShow(playerid, TD_EndMatchStats[playerid][i]);
		}
	}

	// Top killers
	tdid = 0;
	posTD[0] += 1.0;
	posTD[1] += 30.0;

	n_for(i, TDM_MAX_TOP_KILLERS) {
		TDM_CreatePlayerTopKillersTD(playerid, TD_TopKillers[playerid][num][tdid], posTD[0], posTD[1]);

		posTD[1] += 11.0;

		if (TOPPlayersData[sessionid][teamid][i][1] > -1) {
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][0], "%i._%s", i + 1, TOPPlayersName[sessionid][teamid][TOPPlayersData[sessionid][teamid][i][1]]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][1], "%i", TOPPlayersData[sessionid][teamid][i][0]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][2], "%i", TOPPlayersData[sessionid][teamid][i][2]);

			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][0]);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][1]);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][2]);
		}
		tdid++;
	}
	return 1;
}

static ShowPlayerInfoLocation(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (LocationGameStatus[sessionid] != TDM_GAME_STATUS_GAME) {
		return 1;
	}

	static 
		string[600];

	string[0] = EOS;

	new
		locationid = Mode_GetSessionLocation(MODE_TDM, sessionid);

	f(string, ""CT_WHITE"Локация: {E58315}%s\n"CT_WHITE"Режим: {D0740B}%s\n\n"CT_WHITE"%s", Mode_GetLocationName(MODE_TDM, locationid), Mode_GetGameModeName(MODE_TDM, Mode_GetLocationGameMode(MODE_TDM, locationid)), Mode_GetGameModeInfo(MODE_TDM, Mode_GetSessionGameMode(MODE_TDM, sessionid)));
	Dialog_Message(playerid, ""CT_YELLOW"Информация о локации", string, "Хорошо");
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetSessionData(sessionid)
{
	TDM_ClResetSessionData(sessionid);
	TDM_SqResetSessionData(sessionid);
	TDM_LocResetSessionData(sessionid);

	LocationGameStatus[sessionid] =
	LocationEndTimer[sessionid] = 0;

	n_for(i, TDM_MAX_CHANGE_MAP_LIST) {
		ChangeLocationList[sessionid][i] =
		SelectVoteLocation[sessionid][i] = 0;
	}

	n_for(i, GMS_MAX_LOCATIONS) {
		NotSelectedLocations[sessionid][i] = 0;
	}

	n_for(i, TDM_MAX_TEAMS) {
		TimerMatchText[sessionid][i] = 0;
	}

	ResetTopPlayers(sessionid);
	ResetTopActors(sessionid);
	return 1;
}

static ResetPlayerData(playerid)
{	
	PlayerSelectPointID[playerid] = -1;
	PlayerSelectPointTD[playerid] = 0;
	PlayerSelectSquadPlayerID[playerid] = -1;
	PlayerSelectSquadPlayerTD[playerid] = 0;
	PlayerTimerChooseSpawn[playerid] = 0;
	IncludeSpawnInVehiclePlayer[playerid] = -1;

	PlayerSelectVoteLocation[playerid] = -1;

	PlayerExplosives[playerid] =
	PlayerTimerUpdateSelectSpawn[playerid] =
	PlayerTimerSetCameraBase[playerid] =
	PlayerActiveChangeTeamTimer[playerid] = 0;

	PlayerActiveSelectSpawn{playerid} =
	PlayerActiveSelectSpawnTD{playerid} =
	PlayerActiveMatchTextTD{playerid} =
	PlayerActiveNextLocationTD{playerid} = false;
	return 1;
}

static ResetPlayerTDs(playerid)
{
	TD_TNextLocation[playerid] = INVALID_PLAYER_TEXT_DRAW;

	n_for(tt, TDM_MAX_TEAMS) {
		n_for2(i, TDM_MAX_TOP_KILLERS) {
			n_for3(b, TDM_TD_TOP_KILLERS) {
				TD_TopKillers[playerid][tt][i][b] = INVALID_PLAYER_TEXT_DRAW;
			}
		}
	}

	n_for(i, TDM_TD_SELECT_NEXT_LOCATION) {
		TD_SelectNextLocation[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TDM_TD_END_MATCH_STATS) {
		TD_EndMatchStats[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(tt, TDM_MAX_TEAMS) {
		n_for2(i, TDM_TD_MATCH_RESULT) {
			TD_MatchResult[playerid][tt][i] = INVALID_PLAYER_TEXT_DRAW;
		}
	}

	n_for(i, TDM_TD_TEAM_SCORE) {
		TD_TeamScore[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TDM_TD_SELECT_SPAWN) {
		TD_SelectSpawn[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TDM_TD_SELECT_PLAYER) {
		TD_SelectPlayer[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TDM_TD_SELECT_POINT) {
		TD_SelectPoint[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TDM_MAX_TEAMS) {
		TD_TextTeamMatch[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TDM_TD_SELECT_TEAM) {
		TD_SelectTeam[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	return 1;
}

/*
 * |>------------------<|
 * |     Interfaces     |
 * |>------------------<|
 */

InterfaceCreate:TDM_SelectTeam(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	new
		tdid,
		teams = Iter_Count(TDM_ActiveTeams[sessionid]);

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		if ((tdid + 1) <= teams) {
			if (IsCh(tdid + 1)) {
				CreatePlayerSelectTeamTD(playerid, tdid, -1, tt);
			}
			else {
				if ((tdid + 1) == teams) {
					CreatePlayerSelectTeamTD(playerid, -1, tdid, tt);
				}
				else { 
					CreatePlayerSelectTeamTD(playerid, tdid, -1, tt);
				}
			}
		}
		tdid++;
	}
	return 1;
}

InterfaceClose:TDM_SelectTeam(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid),
		teams = Iter_Count(TDM_ActiveTeams[sessionid]);

	if (!teams) {
		return 1;
	}

	DestroyPlayerTD(playerid, TD_SelectTeam[playerid][0]);
	DestroyPlayerTD(playerid, TD_SelectTeam[playerid][1]);
	DestroyPlayerTD(playerid, TD_SelectTeam[playerid][2]);

	for (new k = 0, c = 3; k < TDM_MAX_TEAMS; k++) {
		if (!TDM_CheckTeam(sessionid, k)) {
			continue;
		}

		DestroyPlayerTD(playerid, TD_SelectTeam[playerid][c]);
		DestroyPlayerTD(playerid, TD_SelectTeam[playerid][c + 1]);
		DestroyPlayerTD(playerid, TD_SelectTeam[playerid][c + 2]);
		DestroyPlayerTD(playerid, TD_SelectTeam[playerid][c + 3]);
		c += 4;
	}
	return 1;
}

InterfacePlayerClick:TDM_SelectTeam(playerid, PlayerText:playertextid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (playertextid == TD_SelectTeam[playerid][2]) {
		Interface_Close(playerid, Interface:TDM_SelectTeam);

		Interface_Show(playerid, Interface:TDM_SelectSpawn);
		TDM_ShowPlayerBaseColor(playerid);
		return 1;
	}

	new
		c = 4;

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		if (tt == TDM_TEAM_NONE) {
			continue;
		}

		if (playertextid == TD_SelectTeam[playerid][c]) {
			if (PlayerActiveChangeTeamTimer[playerid] > 0) {
				SCM(playerid, C_RED, ""T_TEAM" "CT_WHITE"Вы слишком часто меняете команду.");
				return 1;
			}
			if (GetPlayerTeamEx(playerid) == tt) {
				SCM(playerid, C_RED, ""T_TEAM" "CT_WHITE"Вы уже находитесь в этой команде.");
				return 1;
			}

			new
				teams[TDM_MAX_TEAMS];

			foreach (new i:TDM_ActiveTeams[sessionid]) {
				if (i == TDM_TEAM_NONE) {
					continue;
				}

				m_for(MODE_TDM, sessionid, p) {
					if (GetPlayerTeamEx(p) != i) {
						continue;
					}

					teams[i]++;
				}
			}
			new
				mostTeams,
				index = -1;

			foreach (new i:TDM_ActiveTeams[sessionid]) {
				if (i == TDM_TEAM_NONE) {
					continue;
				}

				if (teams[i] >= mostTeams) {
					mostTeams = teams[i];
					index = i;
				}
			}
			new
				amount_team;

			foreach (new i:TDM_ActiveTeams[sessionid]) {
				if (i == TDM_TEAM_NONE) {
					continue;
				}

				if (teams[i] == mostTeams) {
					amount_team++;
				}
			}		
			if (amount_team > 1) {
				index = -1;
			}

			if (index == tt) {
				SCM(playerid, C_RED, ""T_TEAM" "CT_WHITE"В данной команде достаточно игроков.");
				return 1;
			}
			TDM_LeavePlayerSquad(playerid);

			SetPlayerTeamEx(playerid, tt);
			SetPlayerColorEx(playerid, TDM_GetTeamColorXB(GetPlayerTeamEx(playerid)));

			// Change character
			PlayerActiveChangeTeamTimer[playerid] = 60;

			SCM(playerid, C_RED, ""T_TEAM" "CT_WHITE"Выбрана команда: %s%s", TDM_GetTeamColor(tt), TDM_GetTeamName(tt));
			TDM_EnterPlayerRandomSquad(playerid);
			break;
		}
		c += 4;
	}
	TDM_HidePlSelectedPointSpawn(playerid);

	if (PlayerSelectSquadPlayerID[playerid] != -1
	&& PlayerSelectSquadPlayerID[playerid] != -2) {
		SpecPl(playerid, true);
	}

	TDM_HidePlayerSelectedSpawn(playerid);

	Interface_Close(playerid, Interface:TDM_SelectTeam);

	Interface_Show(playerid, Interface:TDM_SelectSpawn);
	TDM_SetPlayerBaseCamera(playerid, GetPlayerTeamEx(playerid));
	TDM_ShowPlayerBaseColor(playerid);
	return 1;
}

InterfaceClick:TDM_SelectTeam(playerid, Text:clickedid)
{
	// Click escape
	if (clickedid == INVALID_TEXT_DRAW) {
		Interface_Close(playerid, Interface:TDM_SelectTeam);

		Interface_Show(playerid, Interface:TDM_SelectSpawn);
		SelectTextDraw(playerid, TD_C_GREY);
		return 1;
	}
	return 1;
}

static UpdatePlayerSelectSpawnTD(playerid)
{
	// Дерьмовый код, надо переделать

	// Короче, если выбрана база
	if (PlayerSelectSquadPlayerID[playerid] == -2) {
		PlayerTextDrawBackgroundColour(playerid, TD_SelectPlayer[playerid][24], 0x3cba40FF);
		PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][24]);
		return 1;
	}

	// Если выбран игрок из отряда
	if (PlayerSelectSquadPlayerID[playerid] != -1
	&& PlayerSelectSquadPlayerID[playerid] != -2) {
		PlayerTextDrawBackgroundColour(playerid, TD_SelectPlayer[playerid][PlayerSelectSquadPlayerTD[playerid]], 0x3cba40FF);
		PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][PlayerSelectSquadPlayerTD[playerid]]);
		return 1;
	}

	// Если выбрана точка захвата
	if (PlayerSelectPointID[playerid] != -1) {
		PlayerTextDrawBackgroundColour(playerid, TD_SelectPoint[playerid][PlayerSelectPointTD[playerid]], 0x3cba40FF);
		PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][PlayerSelectPointTD[playerid]]);
		return 1;
	}

	return 1;
}

InterfaceCreate:TDM_SelectSpawn(playerid)
{
	PlayerActiveSelectSpawnTD{playerid} = true;

	// Create
	TDM_CreatePlayerSelectSpawnTD(playerid, TD_SelectSpawn[playerid]);
	CreateSelectSpawnPlayerTD(playerid);
	CreatePlayerSelectPointTD(playerid);

	// Show
	n_for(i, TDM_TD_SELECT_SPAWN) {
		PlayerTextDrawShow(playerid, TD_SelectSpawn[playerid][i]);
	}

	ShowPlayerSelectPlayerTD(playerid);
	ShowPlayerSelectPointTD(playerid);

	// Update
	TDM_UpdatePlayerSquad(playerid);
	UpdatePlayerSelectSpawnTD(playerid);	

	SelectTextDraw(playerid, TD_C_GREY);
	return 1;
}

InterfaceClose:TDM_SelectSpawn(playerid)
{
	if (!PlayerActiveSelectSpawnTD{playerid}) {
		return 1;
	}

	PlayerActiveSelectSpawnTD{playerid} = false;

	n_for(i, TDM_TD_SELECT_SPAWN) {
		DestroyPlayerTD(playerid, TD_SelectSpawn[playerid][i]);
	}
	DestroyPlayerSelectPlayerTD(playerid, false);
	DestroyPlayerSelectPointTD(playerid, false);
	return 1;
}

InterfacePlayerClick:TDM_SelectSpawn(playerid, PlayerText:playertextid)
{
	if (!PlayerActiveSelectSpawn{playerid}) {
		return 1;
	}

	new
		sessionid = M_GPS(playerid);

	if (playertextid == TD_SelectSpawn[playerid][2]) {
		if (PlayerSelectSquadPlayerID[playerid] == -2) {
			new
				Float:X, Float:Y, Float:Z,
				randomPos = random(3);

			TDM_GetBaseSpawn(sessionid, GetPlayerTeamEx(playerid), randomPos, X, Y, Z);
			SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, MODE_TDM), X, Y, Z + 0.3, 0.0);

			HidePlayerSelectSpawn(playerid);
		}
		if (PlayerSelectSquadPlayerID[playerid] != -1 
		&& PlayerSelectSquadPlayerID[playerid] != -2) {
			new 
				Float:X, Float:Y, Float:Z, Float:Angle;
				
			GetPlayerPos(PlayerSelectSquadPlayerID[playerid], X, Y, Z);
			GetPlayerFacingAngle(PlayerSelectSquadPlayerID[playerid], Angle);
			
			SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, MODE_TDM), X, Y + 0.5, Z + 0.3, Angle);

			HidePlayerSelectSpawn(playerid);
		}
		if (PlayerSelectPointID[playerid] != -1) {
			new 
				Float:X, Float:Y, Float:Z,
				randomPos = random(3),
				pointid = PlayerSelectPointID[playerid];

			TDM_LocGetCapturePointSpawn(sessionid, pointid, randomPos, X, Y, Z);
			SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, Mode_GetPlayerMode(playerid)), X, Y, Z + 0.3, 0.0);

			HidePlayerSelectSpawn(playerid);
		}
		return 1;
	}
	else if (playertextid == TD_SelectSpawn[playerid][5]) {
		Interface_Close(playerid, Interface:TDM_SelectSpawn);
		Interface_Show(playerid, Interface:TDM_SelectClass);

		CheckPlayerDinaHint(playerid, 10);
		return 1;
	}
	else if (playertextid == TD_SelectSpawn[playerid][8]) {
		SetPVarInt(playerid, "QuestModeProgress", MODE_TDM);
		Dialog_Show(playerid, Dialog:QuestsListProgress);

		CheckPlayerDinaHint(playerid, 12);
		return 1;
	}
	else if (playertextid == TD_SelectSpawn[playerid][11]) {
		Interface_Close(playerid, Interface:TDM_SelectSpawn);
		Interface_Show(playerid, Interface:TDM_SelectTeam);
		return 1;
	}

	if (playertextid == TD_SelectPlayer[playerid][25]) {
		if (PlayerSelectSquadPlayerID[playerid] != -2) {
			if (PlayerTimerChooseSpawn[playerid] > 0) {
				return 1;
			}
			else {
				PlayerTimerChooseSpawn[playerid] += 2;
			}

			SetCameraBehindPlayer(playerid);
			TDM_HidePlSelectedPointSpawn(playerid);

			if (PlayerSelectSquadPlayerID[playerid] != -1 
			&& PlayerSelectSquadPlayerID[playerid] != -2) {
				SpecPl(playerid, true);
			}

			TDM_HidePlayerSelectedSpawn(playerid);

			TDM_SetPlayerBaseCamera(playerid, GetPlayerTeamEx(playerid));
			TDM_ShowPlayerBaseColor(playerid);
		}
		else {
			SetCameraBehindPlayer(playerid);

			new
				Float:X, Float:Y, Float:Z,
				randomPos = random(3);

			TDM_GetBaseSpawn(sessionid, GetPlayerTeamEx(playerid), randomPos, X, Y, Z);
			SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, MODE_TDM), X, Y, Z + 0.3, 0.0);

			HidePlayerSelectSpawn(playerid);
		}
		return 1;
	}

	new
		tt = 1;

	n_for(i, 4) {
		if (playertextid == TD_SelectPlayer[playerid][tt]) {
			new
				playerSquad = TDM_SqGetPlayerList(playerid, i);

			if (playerSquad > -1) {
				if (IsPlayerOnServer(playerSquad)
				&& Mode_IsPlayerInPlayer(playerid, playerSquad)
				&& GetPlayerDead(playerSquad) == PLAYER_DEATH_NONE
				&& !PlayerActiveSelectSpawn{playerSquad}) {
					if (PlayerSelectSquadPlayerID[playerid] != playerSquad) {
						if (PlayerTimerChooseSpawn[playerid] > 0) {
							return 1;
						}
						else {
							PlayerTimerChooseSpawn[playerid] += 2;
						}

						SetCameraBehindPlayer(playerid);
						TDM_HidePlSelectedPointSpawn(playerid);
						TDM_HidePlayerSelectedSpawn(playerid);

						PlayerSelectSquadPlayerID[playerid] = playerSquad;
						PlayerSelectSquadPlayerTD[playerid] = tt - 1;

						SetPlayerSpectating(playerid, playerSquad);
						UpdateSpectatingPlayer(playerid, playerSquad);

						PlayerTextDrawBackgroundColour(playerid, TD_SelectPlayer[playerid][PlayerSelectSquadPlayerTD[playerid]], 0x3cba40FF);
						PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][PlayerSelectSquadPlayerTD[playerid]]);

						Iter_Add(TDM_SpecSquadPlayerid[playerSquad], playerid);
					}
					else {
						if (GetPlayerLastDamage(playerSquad)) {
							SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Союзник находится под обстрелом!");
						}
						else {
							if (IsPlayerInAnyVehicle(playerSquad)) {
								if (GetVehicleFreeSeat(GetPlayerVehicleID(playerSquad)) == -1) {
									SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В транспорте союзника нету места!");
								}
								else {
									new 
										Float:X, Float:Y, Float:Z, Float:Angle;
										
									GetPlayerPos(playerSquad, X, Y, Z);
									GetPlayerFacingAngle(playerSquad, Angle);

									IncludeSpawnInVehiclePlayer[playerid] = playerSquad;
									SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, Mode_GetPlayerMode(playerid)), X, Y + 0.5, Z + 0.3, Angle);
									HidePlayerSelectSpawn(playerid);
								}
							}
							else {
								new 
									Float:X, Float:Y, Float:Z, Float:Angle;
									
								GetPlayerPos(playerSquad, X, Y, Z);
								GetPlayerFacingAngle(playerSquad, Angle);

								SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, Mode_GetPlayerMode(playerid)), X, Y + 0.5, Z + 0.3, Angle);
								HidePlayerSelectSpawn(playerid);
							}
						}
					}
				}
				break;
			}
			return 1;
		}
		tt += 6;
	}

	tt = 1;
	foreach (new g:TDM_CapturePointCount[sessionid]) {
		if (playertextid == TD_SelectPoint[playerid][tt]) {
			if (TDM_GetCapturePointTeam(sessionid, g) != GetPlayerTeamEx(playerid)) {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Точка не принадлежит вашей команде!");
			}
			else {
				if (PlayerSelectPointID[playerid] != g) {
					if (PlayerTimerChooseSpawn[playerid] > 0) {
						return 1;
					}
					else { 
						PlayerTimerChooseSpawn[playerid] += 2;
					}

					SetCameraBehindPlayer(playerid);
					TDM_HidePlSelectedPointSpawn(playerid);

					if (PlayerSelectSquadPlayerID[playerid] != -1 
					&& PlayerSelectSquadPlayerID[playerid] != -2) {
						SpecPl(playerid, true);
					}
						
					TDM_HidePlayerSelectedSpawn(playerid);
					TDM_SetPlayerCPointCamera(playerid, g);

					PlayerSelectPointID[playerid] = g;
					PlayerSelectPointTD[playerid] = tt - 1;

					PlayerTextDrawBackgroundColour(playerid, TD_SelectPoint[playerid][tt - 1], 0x3cba40FF);
					PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][tt - 1]);
				}
				else {
					new 
						Float:X, Float:Y, Float:Z,
						randomPos = random(3),
						pointid = PlayerSelectPointID[playerid];

					TDM_LocGetCapturePointSpawn(sessionid, pointid, randomPos, X, Y, Z);
					SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, MODE_TDM), X, Y, Z + 0.3, 0.0);

					HidePlayerSelectSpawn(playerid);
				}
			}
			return 1;
		}
		tt += 6;
	}
	return 1;
}

InterfaceClick:TDM_SelectSpawn(playerid, Text:clickedid)
{
	// Click escape
	if (clickedid == INVALID_TEXT_DRAW) {
		SelectTextDraw(playerid, TD_C_GREY);
		return 1;
	}
	return 1;
}

InterfaceCreate:TDM_SelectNextLoc(playerid)
{
	PlayerActiveNextLocationTD{playerid} = true;
	ShowPlSelectNextLocationTD(playerid);
	UpdatePlCellsNextLocationTD(playerid);

	n_for(i, TDM_TD_SELECT_NEXT_LOCATION) {
		PlayerTextDrawShow(playerid, TD_SelectNextLocation[playerid][i]);
	}
	return 1;
}

InterfaceClose:TDM_SelectNextLoc(playerid)
{
	PlayerActiveNextLocationTD{playerid} = false;

	n_for(i, TDM_TD_SELECT_NEXT_LOCATION) {
		DestroyPlayerTD(playerid, TD_SelectNextLocation[playerid][i]);
	}
	return 1;
}

InterfacePlayerClick:TDM_SelectNextLoc(playerid, PlayerText:playertextid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (LocationGameStatus[sessionid] == TDM_GAME_STATUS_SELECT) {
		if (LocationEndTimer[sessionid] > 0) {
			for (new i = 3, cell = 0; cell < TDM_MAX_CHANGE_MAP_LIST; i += 4, cell++) {
				if (playertextid == TD_SelectNextLocation[playerid][i]) {
					if (PlayerSelectVoteLocation[playerid] > -1) {
						SelectVoteLocation[sessionid][PlayerSelectVoteLocation[playerid]]--;
					}

					PlayerSelectVoteLocation[playerid] = -1;

					SelectVoteLocation[sessionid][cell]++;
					PlayerSelectVoteLocation[playerid] = cell;

					UpdatePlTDCellsVoiceLocation(playerid);
					return 1;
				}
			}
		}
	}
	return 1;
}

InterfaceClick:TDM_SelectNextLoc(playerid, Text:clickedid)
{
	// Click escape
	if (clickedid == INVALID_TEXT_DRAW) {
		SelectTextDraw(playerid, TD_C_GREY);
		return 1;
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

stock TDM_OnGameModeInit()
{
	// Reset sessions
	n_for(sessionid, GMS_MAX_SESSIONS) {
		ResetSessionData(sessionid);
	}

	// Initialization
	Iter_Init(TDM_ActiveTeams);
	Iter_Init(TDM_ActiveTeamsScore);

	TDM_SqOnGameModeInit();
	TDM_LocOnGameModeInit();

	Mode_Add(MODE_TDM, "TDM", "TeamDeathMatch",
		.enableStatus = true,
		.maxSessions = 10,
		.sessionMaxPlayers = 100,
		.changeEnableStatus = true,
		.changeSession = true,
		.changeSessionLocation = true);

	Mode_SetInfo(MODE_TDM, "-");

	Mode_AddGameMode(MODE_TDM, TDM_GAME_MODE_CAPTURE, "Захват");
	Mode_SetGameModeInfo(MODE_TDM, TDM_GAME_MODE_CAPTURE,
		"- Необходимо захватить и удерживать точку захвата.\
		\n- Чем больше захваченных точек, тем быстрее повышаются очки команды.\
		\n- Побеждает команда с наибольшим количеством очков команды.");

	Mode_AddGameMode(MODE_TDM, TDM_GAME_MODE_CAPTURE_FLAG, "Захват флага");
	Mode_SetGameModeInfo(MODE_TDM, TDM_GAME_MODE_CAPTURE_FLAG,
		"- Необходимо присвоить вражеский флаг и доставить его на свою базу.\
		\n- Доставленный флаг повышает очко команде.\
		\n- Побеждает команда с наибольшим количеством очков команды.");

	Mode_AddGameMode(MODE_TDM, TDM_GAME_MODE_SECRET_DATA, "Взлом");
	Mode_SetGameModeInfo(MODE_TDM, TDM_GAME_MODE_SECRET_DATA,
		"- Необходимо взломать или деактивировать компьютер.\
		\n- Защищающая команда отбивает противников от компьютера.\
		\n- Нападающая команда взламывает компьютер.\
		\n\n- Если защищающие сохранили даже один компьютер до окончания матча,\
		\nто они считаются победителями, при взломе всех компьютеров проигрывают.\
		\n- Если нападающие взломали все компьютеры до конца матча,\
		\nто они считаются победителями, при взломе не всех компьютеров проигрывают.");

	Mode_AddGameMode(MODE_TDM, TDM_GAME_MODE_BATTLE_KILLS, "Сражение");
	Mode_SetGameModeInfo(MODE_TDM, TDM_GAME_MODE_BATTLE_KILLS,
		"- После каждого убитого противника понижаются очки его команды.\
		\n- Побеждает команда с наибольшим количеством очков команды.");

	// Sessions
	Mode_CreateFirstSessions(MODE_TDM);
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

	#if defined TDM_OnPlayerConnect
		return TDM_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>-----------------<|
 * |   OnPlayerSpawn   |
 * |>-----------------<|
 */

stock TDM_OnPlayerSpawn(playerid)
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

	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (!PlayerActiveSelectSpawn{playerid}) {
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, GetPlayerMoneyEx(playerid));

		TDM_SetPlayerBagMoney(playerid, false);
		HidePlayerBaseIndicatorsTD(playerid);
		Mode_DestroyPlayerMatchPointsTD(playerid);
		HidePlayerNewGraphTD(playerid);
		DestroyPlayerMatchStatsTD(playerid);

		DestroyPlTextTeamMatchTD(playerid, GetPlayerTeamEx(playerid));
	}
	else {
		ResetPlayerWeaponsEx(playerid);
		SetPlayerAmmunition(playerid);

		ShowPlayerBaseIndicatorsTD(playerid);
		Mode_ShowPlayerMatchPointsTD(playerid);
		ShowPlayerNewGraphTD(playerid);
		ShowPlayerMatchStatsTD(playerid);

		SetPlayerActionZone(playerid, true);

		if (IncludeSpawnInVehiclePlayer[playerid] > -1) {
			SetPlayerDamage(playerid, true);

			new 
				playerSquad = IncludeSpawnInVehiclePlayer[playerid];

			IncludeSpawnInVehiclePlayer[playerid] = -1;
			PutPlayerInVehicle(playerid, GetPlayerVehicleID(playerSquad), GetVehicleFreeSeat(GetPlayerVehicleID(playerSquad)));
		}
		else {
			if (LocationGameStatus[sessionid] == TDM_GAME_STATUS_GAME) {
				SetPlayerSpawnKill(playerid);
			}
		}

		TDM_SpawnPlayerElementArea(playerid);

		// Dina
		CheckPlayerDinaHint(playerid, 8);
	}
	if (LocationGameStatus[sessionid] != TDM_GAME_STATUS_GAME) {
		CreatePlayerNextLocation(playerid);
		SpecPl(playerid, true);

		switch (LocationGameStatus[sessionid]) {
			case TDM_GAME_STATUS_RESULT: {
				ShowPlayerMatchResult(playerid);
				TDM_ShowCameraEndLocation(playerid, 0);
			}
			case TDM_GAME_STATUS_TOP_KILLS: {
				HidePlayerMatchResult(playerid);
				TDM_ShowCameraEndLocationTwo(playerid, 0);
			}
			case TDM_GAME_STATUS_SELECT: {
				TDM_ShowCameraEndLocationThree(playerid, 0);
				CreatePlayerNextLocationTD(playerid);
				SelectTextDraw(playerid, TD_C_GREY);
			}
		}
		HidePlayerExitZone(playerid);

		Mode_ResetPlayerMacthPoints(playerid);
		Mode_ResetPlayerMatchKills(playerid);
		Mode_ResetPlayerMatchDeaths(playerid);
	}
	else {
		if (PlayerActiveSelectSpawn{playerid}) {
			PlayerActiveSelectSpawn{playerid} = false;
		}
		else {
			ShowPlayerSelectSpawn(playerid);
		}
	}
	SetPlayerHealth(playerid, 100.0);
	SetPlayerTeamEx(playerid, GetPlayerTeamEx(playerid));
	return 0;
}

/*
 * |>-----------------<|
 * |   OnPlayerDeath   |
 * |>-----------------<|
 */

stock TDM_OnPlayerDeath(playerid, &killerid, &WEAPON:reason)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	CheckSpectatingPlayers(playerid, killerid);

	if (killerid != INVALID_PLAYER_ID) {
		AddPlayerSpecatingPlayer(killerid, playerid);

		if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE) {
			TDM_GiveTeamScore(sessionid, GetPlayerTeamEx(killerid), 1);
		}
	}

	CheckPlayerDamageBody(playerid);

	SetPlayerInvisible(playerid, false);
	SetPlayerDamage(playerid, false);
	CreatePlayerDropWeapon(playerid);

	Mode_GivePlayerMatchDeaths(playerid, 1);

	m_for(MODE_TDM, sessionid, p) {
		SendDeathMessageToPlayer(p, killerid, playerid, reason);
	}

	DestroyPlayerBelowHealth(playerid);

	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_BATTLE_KILLS) {
		if (TDM_GetTeamScore(sessionid, GetPlayerTeamEx(killerid)) < TDM_GetTeamMaxScore(sessionid, GetPlayerTeamEx(killerid))) {
			TDM_GiveTeamScore(sessionid, GetPlayerTeamEx(killerid), 1);
		}
	}

	if (killerid != INVALID_PLAYER_ID) {
		// Reward
		new 
			killStrike = GetPlayerKillStrike(killerid) * 10;

		if (!TDM_GetPlayerBagMoney(playerid)) {
			GivePlayerReward(killerid, 250 + killStrike, 150 + killStrike, REWARD_KILL);
		}
		else if (TDM_GetPlayerBagMoney(playerid)) {
			GivePlayerReward(killerid, 300 + killStrike, 200 + killStrike, REWARD_BAG_OF_MONEY);
		}

		// Quests
		CheckPlayerQuestProgress(killerid, MODE_TDM, sessionid);
		if (GetPlayerCustomClass(killerid) == TDM_CLASS_ASSAULT) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 2);
			CheckPlayerQuestProgress(killerid, MODE_TDM, 13);
		}
		if (GetPlayerCustomClass(killerid) == TDM_CLASS_MEDIC) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 3);
		}

		if (GetPlayerCustomClass(killerid) == TDM_CLASS_ENGINEER) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 4);
		}

		if (GetPlayerCustomClass(killerid) == TDM_CLASS_RECON) {
			if (GetPlayerWeapon(killerid) == WEAPON_SNIPER) {
				CheckPlayerQuestProgress(killerid, MODE_TDM, 5);
				CheckPlayerQuestProgress(killerid, MODE_TDM, 15);
				CheckPlayerQuestProgress(killerid, MODE_TDM, 25);
			}
		}
		if (GetPlayerWeapon(killerid) == WEAPON_KNIFE) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 8);
		}
		if (GetPlayerColdWeapon(killerid, WEAPON_KNIFE)) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 9);
		}

		CheckPlayerQuestProgress(killerid, MODE_TDM, 11);

		if (GetPlayerWeapon(killerid) == WEAPON_KATANA) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 17);
		}

		if (GetPlayerColdWeapon(killerid, WEAPON_KATANA)) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 18);
		}

		if (IsPlayerAirVehicle(killerid)) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 22);
		}

		if (GetPlayerVehicleID(killerid) == 432) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 23);
		}

		if (GetPlayerWeapon(killerid) == WEAPON_DEAGLE) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 27);
		}

		if (GetPlayerWeapon(killerid) == WEAPON_ROCKETLAUNCHER) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 28);
		}

		if (GetPlayerVehicleID(killerid) == 432) {
			CheckPlayerQuestProgress(killerid, MODE_TDM, 30);
		}

		// Technical
		Mode_GivePlayerMatchKills(killerid, 1);
	}
	SetPlayerQuestProgress(playerid, MODE_TDM, 10, 0);
	SetPlayerQuestProgress(playerid, MODE_TDM, 11, 0);

	TDM_LocOnPlayerDeath(playerid, killerid, reason);

	if (killerid != INVALID_PLAYER_ID) {
		SetPlayerSpeedRespawn(playerid, TDM_PLAYER_TIMER_RESPAWN);
	}
	else {
		SetPlayerSpeedRespawn(playerid, TIMER_PLAYER_RESPAWN);
	}

	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
 * |>----------------<|
 * |   OnPlayerText   |
 * |>----------------<|
 */

stock TDM_OnPlayerText(playerid, text[])
{
	static
		str[200];

	str[0] = EOS;

	// Radio
	if (text[0] == '!') {
		strdel(text, 0, 1);
		
		f(str, ""T_RADIO" {FFCC33}[Р: %i] "CT_YELLOW"%s "T_PID": "CT_WHITE"%s", GetPlayerRank(playerid), GetPlayerNameEx(playerid), playerid, text);
		m_for(M_GP(playerid), M_GPS(playerid), p) {
			if (GetPlayerTeamEx(p) != GetPlayerTeamEx(playerid)) {
				continue;
			}

			SCMEX(p, C_TOMATO, str, true);
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

stock TDM_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 0;
	}

	if (TDM_ClOnPlayerKeyStateChange(playerid, newkeys, oldkeys)) {
		return 1;
	}

	if (TDM_LocOnPlayerKeyStateChange(playerid, newkeys, oldkeys)) {
		return 1;
	}

	// Anti +C
	if ((newkeys & (KEY_FIRE | KEY_CROUCH)) == (KEY_FIRE | KEY_CROUCH)
	&& (oldkeys & (KEY_FIRE | KEY_CROUCH)) != (KEY_FIRE | KEY_CROUCH)) {
		DeaglePlayerAntiC(playerid);
		return 1;
	}

	// H
	if (newkeys & KEY_CTRL_BACK) {
		// Player class abilities
		if (KEY:GetPlayerAntiKeys(playerid) == KEY_CTRL_BACK) {
			if (!PlayerActiveSelectSpawn{playerid} 
			&& !IsPlayerInAnyVehicle(playerid)) {
				Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
				return 1;
			}
		}
		else {
			SetPlayerAntiKeys(playerid, UNKNOWN_KEY);
			return 1;
		}
	}
	return 0;
}

/*
 * |>-------------------------------<|
 * |   OnPlayerPickUpDynamicPickup   |
 * |>-------------------------------<|
 */

stock TDM_OnPlPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	if (TDM_LocOnPlPickUpDynamicPickup(playerid, pickupid)) {
		return 1;
	}
	return 0;
}

/*
 * |>----------------------------<|
 * |   OnPlayerEnterDynamicArea   |
 * |>----------------------------<|
 */

stock TDM_OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	TDM_LocOnPlEnterDynamicArea(playerid, areaid);
	return 0;
}

/*
 * |>----------------------------<|
 * |   OnPlayerLeaveDynamicArea   |
 * |>----------------------------<|
 */

stock TDM_OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	TDM_LocOnPlLeaveDynamicArea(playerid, areaid);
	return 0;
}

/*
 * |>------------------<|
 * |   OnVehicleSpawn   |
 * |>------------------<|
 */

public OnVehicleSpawn(vehicleid) 
{
	TDM_VehicleSetSettings(vehicleid);

	#if defined TDM_OnVehicleSpawn
		return TDM_OnVehicleSpawn(vehicleid);
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
#define OnPlayerConnect TDM_OnPlayerConnect
#if defined TDM_OnPlayerConnect
	forward TDM_OnPlayerConnect(playerid);
#endif


#if defined _ALS_OnVehicleSpawn
	#undef OnVehicleSpawn
#else
	#define _ALS_OnVehicleSpawn
#endif
#define OnVehicleSpawn TDM_OnVehicleSpawn
#if defined TDM_OnVehicleSpawn
	forward TDM_OnVehicleSpawn(vehicleid);
#endif