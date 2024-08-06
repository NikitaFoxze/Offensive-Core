/*

	About: TDM core system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerSpawn(playerid)
		OnPlayerDeath(playerid, &killerid, &reason)
		OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
		OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
		OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
		OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnVehicleSpawn(vehicleid)
		
		TDM_SetPlayerBaseCamera2(playerid)
		TDM_UpdatePlayer(playerid)
	Stock:
		TDM_GetPlayerSelectTP(playerid)
		TDM_ShowTDSelectPlayer(playerid)
		TDM_DestroyTDSelectPlayer(playerid, bool:hide = true)
		TDM_CreateLocation(location_id, session_id, bool:start_server = false)
		TDM_DestroyLocation(session_id)
		TDM_CreateLocationPlayer(playerid, session_id, set)
		TDM_DestroyLocationPlayer(playerid, reset)
		TDM_UpdateTime(session_id)
		TDM_UpdatePlayerMG(playerid)
		TDM_CreateNPC()
		TDM_SetPlayerExplosive(playerid, num)
		TDM_GetPlayerExplosive(playerid)
		TDM_GetPlayerCellSelectID(playerid)
		TDM_UpdateSpecStatus(playerid, spectedid)
		TDM_GivePlayerWeapon(playerid, weaponid, ammo)
		TDM_UpdatePlTDSquadPlayers(playerid, td_id, player_squad = -1, bool:all_update)
		TDM_TimerSetPlayerBaseCamera(playerid)
		TDM_UpdatePlayerTDTeamChet(playerid)
		TDM_SetTeamModeChet(session_id, team_id, num)
		TDM_GetTeamChet(session_id, team_id)
		TDM_GiveTeamChet(session_id, team_id, num)
		TDM_SetTeamModeMaxChet(session_id, team_id, num)
		TDM_GetTeamMaxChet(session_id, team_id)
		TDM_ShowPlayerTDTeamsChet(playerid)
		TDM_ShowPlayerTDTeamChet(playerid, td_id, team_id, maxchet)
		TDM_DestroyPlayerTDTeamsChet(playerid)
		TDM_HideSelectedPlayerTP(playerid, bool:iterremove = true)
		TDM_HideSelectedPointTP(playerid)
		TDM_ChangeLocation(session_id)
		TDM_SetTextTeamMatch(session_id, text[], team_id = 0, timer = 4)
		TDM_ChangePointCameraForPlayer(session_id, point_id)
		TDM_ShowPlayerBaseColor(playerid)
		TDM_OnPlayerText(playerid, text[])
Enums:
	-
Commands:
	-
Dialogs:
	TDM_SelectPlaySession
	TDM_SelectSession
	TDM_SelectLocation
Interfaces:
	TDM_SelectTeam
	TDM_SelectTP
------------------------------------------------------------------------------*/

#if defined _INC_TDM_CORE_SYSTEM
	#endinput
#endif
#define _INC_TDM_CORE_SYSTEM

/*

	* Vars *

*/

static
	tdm_location_game_status[TDM_MAX_GAME_SESSIONS],
	tdm_location_end_timer[TDM_MAX_GAME_SESSIONS],
	tdm_next_location[TDM_MAX_GAME_SESSIONS];

static
	players_Data[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][MAX_PLAYERS][3],
	players_Name[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][MAX_PLAYERS][MAX_PLAYER_NAME],
	tempVar[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS];

static
	change_map_list[TDM_MAX_GAME_SESSIONS][TDM_MAX_CHANGE_MAP_LIST],
	not_selected_maps[TDM_MAX_GAME_SESSIONS][TDM_MAX_LOCATIONS],
	select_vote_location[TDM_MAX_GAME_SESSIONS][TDM_MAX_CHANGE_MAP_LIST];

static
	npc_top_kills[TDM_MAX_GAME_SESSIONS][5],
	Text3D:npc_3DText[TDM_MAX_GAME_SESSIONS][5],

	bots_Data[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS][3],
	bots_Name[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS][MAX_PLAYER_NAME],
	bots_Team[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS],
	bots_Skin[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS],
	bots_Accs[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS][5],
	bots_Cap[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS],
	bots_Armor[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS],
	bots_tempVar[TDM_MAX_GAME_SESSIONS];

static
	ActiveCellSelectPoint[MAX_PLAYERS],
	ActiveCellSelectPointTD[MAX_PLAYERS],
	ActiveCellSelectPlayerID[MAX_PLAYERS],
	ActiveCellSelectPlayerTD[MAX_PLAYERS],
	TimerChooseFromSpawn[MAX_PLAYERS],
	IncludeSpawnInVehiclePlayer[MAX_PLAYERS];

static
	bool:ActionPlayerSelectTP[MAX_PLAYERS char],
	bool:ActionPlayerTDNextLocation[MAX_PLAYERS char],
	bool:ActionPlayerTextRound[MAX_PLAYERS char],

	text_round_timer[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS],
	TimerSetCameraBase[MAX_PLAYERS],
	UpdateTimerSelectTP[MAX_PLAYERS],
	PlayerExplosives[MAX_PLAYERS],
	ActionPlayerTDSelectTP[MAX_PLAYERS],

	PlayerSelectVoteLocation[MAX_PLAYERS],
	ActiveChangeTeamTimer[MAX_PLAYERS];

static
	PlayerText:TD_TopKillers[MAX_PLAYERS][TDM_MAX_TEAMS][10][3],
	PlayerText:TD_EndRoundStats[MAX_PLAYERS][7],
	PlayerText:TD_ResultRound[MAX_PLAYERS][TDM_MAX_TEAMS][9],

	PlayerText:TD_TNextLocation[MAX_PLAYERS],
	PlayerText:TD_TextTeamMatch[MAX_PLAYERS][TDM_MAX_TEAMS],

	PlayerText:TD_SelectSpawn[MAX_PLAYERS][12],
	PlayerText:TD_SelectPlayer[MAX_PLAYERS][27],
	PlayerText:TD_SelectPoint[MAX_PLAYERS][42],
	PlayerText:TD_SelectTeam[MAX_PLAYERS][19],

	PlayerText:TD_SelectNextLocation[MAX_PLAYERS][15],
	PlayerText:TD_ChetLocation[MAX_PLAYERS][8];

static
	PlayerBar:PlayerChetLocation[MAX_PLAYERS][TDM_MAX_TEAMS];

/*

	* Functions *

*/

stock TDM_GetPlayerSelectTP(playerid)
{
	return ActionPlayerSelectTP{playerid};
}

stock TDM_ShowTDSelectPlayer(playerid)
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

stock TDM_DestroyTDSelectPlayer(playerid, bool:hide = true)
{
	new
		td;

	if(hide) {
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

stock TDM_CreateLocation(location_id, session_id, bool:start_server = false)
{
	// Удаление предыдущей локации
	if(!start_server) {
		m_for(MODE_TDM, session_id, p) {
			if(Adm_GetPlayerSpectating(p)) 
				continue;

			Mode_DestroyLocationPlayer(p, false);
		}
		Mode_DestroyLocation(MODE_TDM, session_id);
	}

	// Создание локации
	Mode_SetLocation(MODE_TDM, session_id, location_id);
	Mode_SetMode(MODE_TDM, session_id, TDM_GetModeLocation(location_id));
	tdm_location_game_status[session_id] = TDM_LOC_GAME_STATUS_GAME;
	
	TDM_CreateElementsLocation(session_id);
	TDM_CreateAEElementsLoc(session_id);

	m_for(MODE_TDM, session_id, p) {
		if(Adm_GetPlayerSpectating(p)) 
			continue;

		Mode_CreateLocationPlayer(p, MODE_TDM, session_id, false);
	}
	return 1;
}

stock TDM_DestroyLocation(session_id)
{
	TDM_DestroyElementsLocation(session_id);
	TDM_DestroyAEElementsLoc(session_id);
	return 1;
}

stock TDM_CreateLocationPlayer(playerid, session_id, set)
{
	if(set)
		Mode_EnteringPlayer(playerid, MODE_TDM, session_id);

	Mode_SetPlayerVirtualWorld(playerid, MODE_TDM, session_id);
	Mode_SetPlayerInterior(playerid, MODE_TDM, session_id);
	Mode_SetPlayerWeather(playerid, MODE_TDM, session_id);

	SetPlayerBusy(playerid, GAME);
	SetPlayerCustomClass(playerid, TDM_C_ASSAULT);
	SetPlayerCustomClass2(playerid, -1);

	if(!Adm_GetPlayerSpectating(playerid)) {
		TDM_SetRandomPlayerTeam(playerid);
		TDM_EnterPlayerRandomSquad(playerid);
	}

	switch(tdm_location_game_status[session_id]) {
		case TDM_LOC_GAME_STATUS_GAME: {
			if(!Adm_GetPlayerSpectating(playerid))
				CreatePlayerSelectSpawn(playerid);
		}
	}

	TDM_ShowPlayerElementsLocation(playerid);

	if(!Adm_GetPlayerSpectating(playerid)) {
		Mode_ShowTDMatchPoints(playerid);
		ShowTDPlayerFPSandPING(playerid);
		ShowTDPlayerStatsRound(playerid);
		ShowTDDeath(playerid);
		ShowTDDeadKiller(playerid);

		PlayerSpawn(playerid);
		ShowPlayerInfoLocation(playerid);
		ShowGoalLocation(playerid);
	}

	Mode_SetPlayerTimer(playerid, MODE_TDM);
	return 1;
}

stock TDM_DestroyLocationPlayer(playerid, reset)
{
	if(ActionPlayerSelectTP{playerid})
		HidePlayerSelectSpawn(playerid, false);

	TDM_HidePlayerElementsLocation(playerid);

	Mode_DestroyPlAE3DText(playerid);

	if(!Adm_GetPlayerSpectating(playerid))
		Interface_Closing(playerid, Interface:TDM_SelectTP, true);

	SetPlayerInvisible(playerid, false);
	SetPlayerKillStrike(playerid, 0);
	HidePlayerKillStrike(playerid);
	DestroyPlayerSpawnKill(playerid);
	Damage_DeletePlayerIndicator(playerid);
	DestroyPlayerBaseIndicators(playerid, false);
	Mode_DestroyPlayerMatchPoints(playerid, false);
	DestroyPlayerFPSandPING(playerid, false);
	DestroyPlayerStatsRound(playerid, false);
	DestroyPlayerDeadKiller(playerid, 3, false);
	DropW_DestroyPlayerWeapon(playerid);
	DestroyPlayerBelowHealth(playerid);
	DestroyPlayerReward(playerid);
	DestroyPlTDTextTeamMatch(playerid, GetPlayerTeamEx(playerid));
	HidePlayerResultRound(playerid);
	DestroyPlayerNextLocation(playerid);
	DestroyTDSelectNextLocation(playerid);
	Damage_ResetPlayerBody(playerid);
	HidePlayerExitZone(playerid);
	ResetPlayerWeaponsEx(playerid);
	DestroyPlayerAttachedObjects(playerid);

	SetPlayerHealthEx(playerid, 100.0);
	TDM_LeavePlayerSquad(playerid);
	SetPlayerTeamEx(playerid, TDM_TEAM_NONE);
	SetPlayerColorEx(playerid, 0xCCCCCC00);
	SetPlayerCustomClass(playerid, -1);
	SetPlayerCustomClass2(playerid, -1);
	Mode_SetPlayerMatchPoint(playerid, 0);
	Mode_SetPlayerKill(playerid, 0);
	Mode_SetPlayerDeath(playerid, 0);
	TDM_SetPlayerBagMoney(playerid, false);
	TDM_SetPlayerExplosive(playerid, 0);
	IncludeSpawnInVehiclePlayer[playerid] = -1;

	Mode_SetPlayerExp(playerid, 0);
	Mode_SetPlayerMoney(playerid, 0);

	if(reset)
		Mode_LeavingPlayer(playerid);

	Mode_KillPlayerTimer(playerid, MODE_TDM);
	return 1;
}

stock TDM_UpdateTime(session_id)
{
	if(TDM_GetActiveTimer(session_id)) {
		if(Mode_GetMinutes(MODE_TDM, session_id) > 0) {
			if(Mode_GetSeconds(MODE_TDM, session_id) > 0
			&& Mode_GetSeconds(MODE_TDM, session_id) <= 60)
				Mode_SetSeconds(MODE_TDM, session_id, Mode_GetSeconds(MODE_TDM, session_id) - 1);

			if(!Mode_GetSeconds(MODE_TDM, session_id)
			&& Mode_GetMinutes(MODE_TDM, session_id) > 0) {
				Mode_SetMinutes(MODE_TDM, session_id, Mode_GetMinutes(MODE_TDM, session_id) - 1);
				Mode_SetSeconds(MODE_TDM, session_id, 60);
			}
		}
	}
	else {
		if(Mode_GetSeconds(MODE_TDM, session_id) < 60) 
			Mode_SetSeconds(MODE_TDM, session_id, Mode_GetSeconds(MODE_TDM, session_id) + 1);
		else
			Mode_SetSeconds(MODE_TDM, session_id, 0);
	}

	if(tdm_location_game_status[session_id] != TDM_LOC_GAME_STATUS_GAME) {
		if(tdm_location_end_timer[session_id] > 0) {
			tdm_location_end_timer[session_id]--;

			m_for(MODE_TDM, session_id, p) {
				if(GetPlayerDead(p))
					continue;

				if(GetPlayerSpectating(p) > -1) 
					continue;

				UpdatePlayerNextLocation(p);
			}

			switch(tdm_location_game_status[session_id]) {
				case TDM_LOC_GAME_STATUS_RESULT: {
					if(tdm_next_location[session_id] == -1) {
						if(tdm_location_end_timer[session_id] == 25) {
							tdm_location_game_status[session_id] = TDM_LOC_GAME_STATUS_TOP_KILLS;
	
							m_for(MODE_TDM, session_id, p) {
								if(GetPlayerDead(p)) 
									continue;

								if(GetPlayerSpectating(p) > -1) 
									continue;

								HidePlayerResultRound(p);
								TDM_ShowCameraEndLocationTwo(p, 1);
							}
						}
					}
					else {
						if(!tdm_location_end_timer[session_id]) {
							HideResultMatch(session_id);
							Mode_CreateLocation(MODE_TDM, session_id, tdm_next_location[session_id]);
						}
					}
				}
				case TDM_LOC_GAME_STATUS_TOP_KILLS: {
					if(tdm_next_location[session_id] == -1) {
						if(tdm_location_end_timer[session_id] == 10) {
							tdm_location_game_status[session_id] = TDM_LOC_GAME_STATUS_SELECT;
							RandomLocationList(session_id);

							m_for(MODE_TDM, session_id, p) {
								if(GetPlayerDead(p)) 
									continue;

								if(Adm_GetPlayerSpectating(p))
									continue;

								TDM_ShowCameraEndLocationThree(p, 1);
								CreateTDPlayerNextLocation(p);
								SelectTextDraw(p, TD_CLICK_COLOR_GREY);
							}
						}
					}
					else {
						if(tdm_location_end_timer[session_id] == 10) {
							tdm_location_game_status[session_id] = TDM_LOC_GAME_STATUS_SELECT;
							RandomLocationList(session_id);

							m_for(MODE_TDM, session_id, p) {
								if(GetPlayerDead(p)) 
									continue;

								if(Adm_GetPlayerSpectating(p)) 
									continue;

								TDM_ShowCameraEndLocationThree(p, 1);
								CreateTDPlayerNextLocation(p);
								SelectTextDraw(p, TD_CLICK_COLOR_GREY);
							}
						}
					}
				}
				case TDM_LOC_GAME_STATUS_SELECT: {
					if(tdm_location_end_timer[session_id] < 1) {
						new
							max_number = 0,
							array_index = 0;

						n_for(i, TDM_MAX_CHANGE_MAP_LIST) {
							if(select_vote_location[session_id][i] <= max_number)
								continue;

							max_number = select_vote_location[session_id][i];
							array_index = change_map_list[session_id][i];
						}
						n_for(i, TDM_MAX_CHANGE_MAP_LIST)
							select_vote_location[session_id][i] = 0;

						m_for(MODE_TDM, session_id, p) {
							if(Adm_GetPlayerSpectating(p)) 
								continue;

							if(GetPlayerDead(p))
								continue;

							DestroyPlayerNextLocation(p);
							DestroyTDSelectNextLocation(p);
							CancelSelectTextDraw(p);
						}

						HideResultMatch(session_id);
						Mode_CreateLocation(MODE_TDM, session_id, array_index);
					}
					else {
						m_for(MODE_TDM, session_id, p) {
							if(Adm_GetPlayerSpectating(p)) 
								continue;

							if(GetPlayerDead(p)) 
								continue;

							UpdatePlTDCellsVoiceLocation(p);
						}
					}
				}
			}
		}
	}
	else {
		if(TDM_GetActiveTimer(session_id)) {
			new 
				str[15];

			m_for(MODE_TDM, session_id, p) {
				f(str, "%02d:%02d", Mode_GetMinutes(MODE_TDM, session_id), Mode_GetSeconds(MODE_TDM, session_id));
				Mode_UpdatePlTDTimerSession(p, str);
			}

			if(!Mode_GetSeconds(MODE_TDM, session_id)
			&& !Mode_GetMinutes(MODE_TDM, session_id))
				LocationEndGame(session_id);
		}

		if(TDM_GetActiveTeams(session_id)) {
			m_for(MODE_TDM, session_id, p) 
				TDM_UpdatePlayerTDTeamChet(p);

			UpdateTeamsChet(session_id);
		}
	}

	if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE)
		TDM_PointReInfo(session_id);

	if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_SECRET_DATA)
		TDM_ComputerReInfo(session_id);

	if(TDM_GetFastPoint(session_id)) {
		TDM_CheckStartFastPoint(session_id);
		TDM_FastPointReInfo(session_id);
	}

	TDM_UpdateAEElement(Mode_GetLocation(MODE_TDM, session_id), session_id);

	// Тексты командам
	foreach(new tt:TDM_ActiveTeams[session_id]) {
		if(text_round_timer[session_id][tt]) {
			text_round_timer[session_id][tt]--;
			if(text_round_timer[session_id][tt] < 1) {
				m_for(MODE_TDM, session_id, p) {
					if(GetPlayerTeamEx(p) != tt)
						continue;

					if(ActionPlayerSelectTP{p})
						continue;

					if(!ActionPlayerTextRound{p})
						continue;

					DestroyPlTDTextTeamMatch(p, GetPlayerTeamEx(p));
				}
			}
		}
	}

	switch(Mode_GetSeconds(MODE_TDM, session_id)) {
		case 60: {
			if(tdm_location_game_status[session_id] == TDM_LOC_GAME_STATUS_GAME) {
				if(TDM_GetAirDropWeapon(session_id))
					TDM_SetWeaponAirs(session_id);
				
				if(TDM_GetAirBomb(session_id))
					TDM_SetBombAirs(session_id);
			}
		}
	}
	return 1;
}

stock TDM_UpdatePlayerMG(playerid)
{
	TDM_LocUpdatePlayerMG(playerid);
	return 1;
}

stock TDM_CreateNPC()
{
	new
		str[MAX_PLAYER_NAME];

	n_for(session_id, TDM_MAX_GAME_SESSIONS) {
		n_for2(npcid, 5) {
			str[0] = EOS;
			f(str, "TDM_NPC_TOP_%i_%i", session_id, npcid);

			npc_top_kills[session_id][npcid] = FCNPC_Create(str);
			FCNPC_Spawn(npc_top_kills[session_id][npcid], 0, 0.0, 0.0, 0.0);
			FCNPC_Stop(npc_top_kills[session_id][npcid]);
			FCNPC_StopAttack(npc_top_kills[session_id][npcid]);
			FCNPC_SetWeapon(npc_top_kills[session_id][npcid], 0);
			FCNPC_SetAmmo(npc_top_kills[session_id][npcid], 0);
			FCNPC_SetQuaternion(npc_top_kills[session_id][npcid], 0.0, 0.0, 0.0, 0.0);
			FCNPC_SetAngle(npc_top_kills[session_id][npcid], 0.0);
			FCNPC_SetInterior(npc_top_kills[session_id][npcid], 0);
			FCNPC_SetVirtualWorld(npc_top_kills[session_id][npcid], 0);
			SetPlayerColor(npc_top_kills[session_id][npcid], 0xCCCCCC00);
		}
	}
	return 1;
}

stock TDM_SetPlayerExplosive(playerid, num)
{
	if(num)
		PlayerExplosives[playerid] += num;
	else
		PlayerExplosives[playerid] = 0;

	return 1;
}

stock TDM_GetPlayerExplosive(playerid)
{
	return PlayerExplosives[playerid];
}

stock TDM_GetPlayerCellSelectID(playerid)
{
	return ActiveCellSelectPlayerID[playerid];
}

stock TDM_UpdateSpecStatus(playerid, spectedid)
{
	if(ActiveCellSelectPlayerID[playerid] != -1 
	&& ActiveCellSelectPlayerID[playerid] != -2) {
		if(Mode_IsPlayerInPlayer(playerid, spectedid)
		&& !GetPlayerDead(spectedid)
		&& !ActionPlayerSelectTP{spectedid})
			UpdateSpectatingPlayer(playerid, spectedid);
	}
	return 1;
}

stock TDM_GivePlayerWeapon(playerid, weaponid, ammo)
{
	new
		d_weaponid,
		d_ammo = ammo - ammo;

	GetPlayerWeaponData(playerid, GetWeaponSlot(weaponid), d_weaponid, d_ammo);

	if(d_weaponid > 0 
	&& d_ammo > 0) {
		if(d_weaponid == weaponid) {
			if(d_ammo > 2000) {
				SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Извините, но патронов и так много.");
				return 0;
			}
		}
	}
	return 1;
}

stock TDM_UpdatePlTDSquadPlayers(playerid, td_id, player_squad = -1)
{
	if(player_squad > -1) {
		new
			str[100];

		PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][td_id + 2], NameEx(player_squad));
		
		f(str, "%s", TDM_GetClassName(GetPlayerCustomClass(player_squad)));
		PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][td_id + 4], str);
		str[0] = EOS;

		if(GetPlayerDead(player_squad) 
		|| ActionPlayerSelectTP{player_squad})
			PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][td_id + 5], "Мёртв");
		else {
			if(GetPlayerBeDamage(player_squad))
				PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][td_id + 5], "В_бою");
			else
				PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][td_id + 5], "_");
		}
	}
	else {
		PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][td_id + 2], "_");
		PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][td_id + 4], "_");
		PlayerTextDrawSetString(playerid, TD_SelectPlayer[playerid][td_id + 5], "Нет");
	}
	return 1;
}

stock TDM_TimerSetPlayerBaseCamera(playerid)
{
	KillTimer(TimerSetCameraBase[playerid]);

	TimerSetCameraBase[playerid] = SetPlayerTimer(playerid, "TDM_SetPlayerBaseCamera2", 300, false);
	return 1;
}

publics TDM_SetPlayerBaseCamera2(playerid)
{
	SpecPl(playerid, true);
	TDM_SetPlayerBaseCamera(playerid, GetPlayerTeamEx(playerid));
	TDM_ShowPlayerBaseColor(playerid);
	return 1;
}

stock TDM_UpdatePlayerTDTeamChet(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid),
		b = 1, 
		ttd;
		
	foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
		new 
			str[15];

		switch(Mode_GetMode(MODE_TDM, session_id)) {
			case TDM_MODE_CAPTURE: {
				f(str, "%i", TDM_GetTeamChet(session_id, tt));
			}
			case TDM_MODE_CAPTURE_FLAG: {
				f(str, "%i/%i", TDM_GetTeamChet(session_id, tt), TDM_GetTeamMaxChet(session_id, tt));
			}
			case TDM_MODE_SECRET_DATA: {
				f(str, "%i/%i", TDM_GetTeamChet(session_id, tt), TDM_GetTeamMaxChet(session_id, tt));
			}
			case TDM_MODE_BATTLE_KILLS: {
				f(str, "%i", TDM_GetTeamChet(session_id, tt));
			}
		}
		PlayerTextDrawSetString(playerid, TD_ChetLocation[playerid][b], str);
		SetPlayerProgressBarValue(playerid, PlayerChetLocation[playerid][ttd], floatround(TDM_GetTeamChet(session_id, tt)));

		b += 2;
		ttd++;
	}
	return 1;
}

stock TDM_SetTeamModeChet(session_id, team_id, num)
{
	switch(Mode_GetMode(MODE_TDM, session_id)) {
		case TDM_MODE_CAPTURE: TDM_SetCPTeamChet(session_id, team_id, num);
		case TDM_MODE_CAPTURE_FLAG: TDM_SetFlagTeamChet(session_id, team_id, num);
		case TDM_MODE_SECRET_DATA: TDM_SetCompTeamChet(session_id, team_id, num);
		case TDM_MODE_BATTLE_KILLS: TDM_SetBattleTeamChet(session_id, team_id, num);
	}
	return 1;
}

stock TDM_GetTeamChet(session_id, team_id)
{
	switch(Mode_GetMode(MODE_TDM, session_id)) {
		case TDM_MODE_CAPTURE: return TDM_GetCPTeamChet(session_id, team_id);
		case TDM_MODE_CAPTURE_FLAG: return TDM_GetFlagTeamChet(session_id, team_id);
		case TDM_MODE_SECRET_DATA: return TDM_GetCompTeamChet(session_id, team_id);
		case TDM_MODE_BATTLE_KILLS: return TDM_GetBattleTeamChet(session_id, team_id);
	}
	return 1;
}

stock TDM_GiveTeamChet(session_id, team_id, num)
{
	switch(Mode_GetMode(MODE_TDM, session_id)) {
		case TDM_MODE_CAPTURE: TDM_SetCPTeamChet(session_id, team_id, num);
		case TDM_MODE_CAPTURE_FLAG: TDM_SetFlagTeamChet(session_id, team_id, num);
		case TDM_MODE_SECRET_DATA: TDM_SetCompTeamChet(session_id, team_id, num);
		case TDM_MODE_BATTLE_KILLS: TDM_SetBattleTeamChet(session_id, team_id, num);
	}
	return 1;
}

stock TDM_SetTeamModeMaxChet(session_id, team_id, num)
{
	switch(Mode_GetMode(MODE_TDM, session_id)) {
		case TDM_MODE_CAPTURE: TDM_SetCPTeamMaxChet(session_id, team_id, num);
		case TDM_MODE_CAPTURE_FLAG: TDM_SetFlagTeamMaxChet(session_id, team_id, num);
		case TDM_MODE_SECRET_DATA: TDM_SetCompTeamMaxChet(session_id, team_id, num);
		case TDM_MODE_BATTLE_KILLS: TDM_SetBattleTeamMaxChet(session_id, team_id, num);
	}
	return 1;
}

stock TDM_GetTeamMaxChet(session_id, team_id) 
{
	switch(Mode_GetMode(MODE_TDM, session_id)) {
		case TDM_MODE_CAPTURE: return TDM_GetCPTeamMaxChet(session_id, team_id);
		case TDM_MODE_CAPTURE_FLAG: return TDM_GetFlagTeamMaxChet(session_id, team_id);
		case TDM_MODE_SECRET_DATA: return TDM_GetCompTeamMaxChet(session_id, team_id);
		case TDM_MODE_BATTLE_KILLS: return TDM_GetBattleTeamMaxChet(session_id, team_id);
	}
	return 1;
}

stock TDM_ShowPlayerTDTeamsChet(playerid)
{
	new
		td_id = 0,
		session_id = M_GPS(playerid);

	foreach(new team_id:TDM_ActiveTeamsChet[session_id]) {
		TDM_ShowPlayerTDTeamChet(playerid, td_id, team_id, TDM_GetTeamMaxChet(session_id, team_id));
		td_id++;
	}
	TDM_UpdatePlayerTDTeamChet(playerid);
	return 1;
}

stock TDM_ShowPlayerTDTeamChet(playerid, td_id, team_id, maxchet)
{
	new
		session_id = Mode_GetPlayerSession(playerid),
		max_chet = floatround(maxchet),
		teams = Iter_Count(TDM_ActiveTeamsChet[session_id]);

	if(td_id + 1 <= teams) {
		if(IsCh(td_id + 1))
			CreatePlayerTDTeamChet(playerid, td_id, -1, team_id, max_chet);
		else {
			if(td_id + 1 == teams) 
				CreatePlayerTDTeamChet(playerid, -1, td_id, team_id, max_chet);
			else 
				CreatePlayerTDTeamChet(playerid, td_id, -1, team_id, max_chet);
		}
	}

	ShowPlayerProgressBar(playerid, PlayerChetLocation[playerid][td_id]);
	return 1;
}

stock TDM_DestroyPlayerTDTeamsChet(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid),
		td_id, 
		bar_id;

	foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
		DestroyPlayerTD(playerid, TD_ChetLocation[playerid][td_id]);
		DestroyPlayerTD(playerid, TD_ChetLocation[playerid][td_id + 1]);

		DestroyPlayerProgressBar(playerid, PlayerChetLocation[playerid][bar_id]);

		td_id += 2;
		bar_id++;
	}
	return 1;
}

stock TDM_HideSelectedPlayerTP(playerid, bool:iterremove = true)
{
	if(ActiveCellSelectPlayerID[playerid] == -2) {
		PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][24], -1717986817);

		if(Interface_IsOpen(playerid, Interface:TDM_SelectTP))
			PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][24]);
	}
	else if(ActiveCellSelectPlayerID[playerid] != -1 
	&& ActiveCellSelectPlayerID[playerid] != -2) {
		if(iterremove)
			Iter_Remove(spec_squad_playerid[ActiveCellSelectPlayerID[playerid]], playerid);

		PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][ActiveCellSelectPlayerTD[playerid]], -1717986817);

		if(Interface_IsOpen(playerid, Interface:TDM_SelectTP))
			PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][ActiveCellSelectPlayerTD[playerid]]);
	}
	SetPlayerSpectating(playerid, -1);
	SetPlayerSpecStatus(playerid, 0);

	ActiveCellSelectPlayerID[playerid] = -1;
	ActiveCellSelectPlayerTD[playerid] = 0;
	return 1;
}

stock TDM_HideSelectedPointTP(playerid)
{
	if(ActiveCellSelectPoint[playerid] != -1) {
		PlayerTextDrawBackgroundColor(playerid, TD_SelectPoint[playerid][ActiveCellSelectPointTD[playerid]], -1717986817);

		if(Interface_IsOpen(playerid, Interface:TDM_SelectTP))
			PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][ActiveCellSelectPointTD[playerid]]);
	}

	ActiveCellSelectPoint[playerid] = -1;
	ActiveCellSelectPointTD[playerid] = 0;
	return 1;
}

stock TDM_ChangeLocation(session_id)
{
	new
		location_id = random(TDM_MAX_LOCATIONS);

	if(location_id == Mode_GetLocation(MODE_TDM, session_id)) 
		return TDM_ChangeLocation(session_id);

	Mode_CreateLocation(MODE_TDM, session_id, location_id, true);
	return 1;
}

stock TDM_SetTextTeamMatch(session_id, text[], team_id = 0, timer = 4)
{
	if(team_id != TDM_TEAM_NONE)
		text_round_timer[session_id][team_id] = timer;
	else {
		foreach(new tt:TDM_ActiveTeams[session_id]) 
			text_round_timer[session_id][tt] = timer;
	}

	m_for(MODE_TDM, session_id, p) {
		if(Adm_GetPlayerSpectating(p))
			continue;

		if(team_id != TDM_TEAM_NONE
		&& GetPlayerTeamEx(p) != team_id)
			continue;

		if(ActionPlayerSelectTP{p})
			continue;

		if(ActionPlayerTextRound{p})
			DestroyPlTDTextTeamMatch(p, GetPlayerTeamEx(p));

		UpdatePlayerTDTextTeamMatch(p, text);
	}
	return 1;
}

stock TDM_ChangePointCameraForPlayer(session_id, point_id)
{
	m_for(MODE_TDM, session_id, p) {
		if(!ActionPlayerSelectTP{p})
			continue;

		if(ActiveCellSelectPoint[p] != point_id)
			continue;

		if(GetPlayerTeamEx(p) == TDM_GetPointTeam(session_id, point_id))
			continue;

		TDM_HideSelectedPointTP(p);

		TDM_SetPlayerBaseCamera(p, GetPlayerTeamEx(p));
		TDM_ShowPlayerBaseColor(p);
	}
	return 1;
}

stock TDM_ShowPlayerBaseColor(playerid)
{
	ActiveCellSelectPlayerID[playerid] = -2;
	ActiveCellSelectPlayerTD[playerid] = 24;

	PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][24], 0x3cba40FF);

	if(Interface_IsOpen(playerid, Interface:TDM_SelectTP))
		PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][24]);
	
	return 1;
}

stock TDM_GetStatusGame(session_id)
{
	return tdm_location_game_status[session_id];
}

publics TDM_UpdatePlayer(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);
	
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));
	UpdatePlayerKillStrike(playerid);
	UpdatePlayerNewRank(playerid);
	UpdatePlayerReward(playerid);
	UpdatePlayerSpawnKill(playerid);
	UpdatePlayerExitZone(playerid);
	UpdatePlayerFPSandPING(playerid);
	TDM_UpdatePlAEElements(playerid);
	DroW_PlayerUpdate(playerid);

	// Точки захвата в выборе дислокации
	if(ActionPlayerSelectTP{playerid}) {
		if(Interface_IsOpen(playerid, Interface:TDM_SelectTP)) {
			if(UpdateTimerSelectTP[playerid] < gettime()) { 
				UpdateTimerSelectTP[playerid] = gettime() + 3;

				new 
					tt = 2;

				foreach(new g:TDM_CapturePointCount[session_id]) {
					// Квадрат точки
					PlayerTextDrawBackgroundColor(playerid, TD_SelectPoint[playerid][tt], TDM_ShowTeamColorXF(TDM_GetPointTeam(session_id, g)));
					PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][tt]); 
					tt += 2;

					// Статус точки
					if(TDM_GetPointTeam(session_id, g) != GetPlayerTeamEx(playerid)) 
						PlayerTextDrawSetString(playerid, TD_SelectPoint[playerid][tt], "ЗАХВАТИТЬ");
					else {
						if(!TDM_GetPointRed(session_id, g)) 
							PlayerTextDrawSetString(playerid, TD_SelectPoint[playerid][tt], "ЗАЩИЩАТЬ");
						else 
							PlayerTextDrawSetString(playerid, TD_SelectPoint[playerid][tt], "ТЕРЯЕМ");
					}
					PlayerTextDrawColor(playerid, TD_SelectPoint[playerid][tt], TDM_ShowTeamColorXF(TDM_GetPointTeam(session_id, g)));
					PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][tt]);

					// Название точки
					PlayerTextDrawColor(playerid, TD_SelectPoint[playerid][tt + 1], TDM_ShowTeamColorXF(TDM_GetPointTeam(session_id, g)));
					PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][tt + 1]);
					tt += 4;
				}
			}
			TDM_UpdatePlSquadPlayers(playerid);
		}
	}

	// TD's смерти
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
			TDM_OnPlayerSpawn(playerid);
	}

	// Компьютеры
	TDM_UpdatePlayerComputer(playerid);

	// Аирдроп классов игроков
	TDM_UpPlayerClassesAirdrop(playerid);

	// Время
	SetPlayerSecondTime(playerid);
	switch(GetPlayerSecondTime(playerid)) {
		case 60: {
			TDM_UpdateTimePlayerClass(playerid);
		}
	}
	UpdatePlayerTime(playerid);
	return 1;
}

static LocationEndGame(session_id, next_location = -1) 
{
	tdm_next_location[session_id] = next_location;
	tdm_location_game_status[session_id] = TDM_LOC_GAME_STATUS_RESULT;

	if(tdm_next_location[session_id] == -1) 
		tdm_location_end_timer[session_id] = TDM_LOC_END_TIMER;
	else 
		tdm_location_end_timer[session_id] = TDM_LOC_END_TIMER / 2;

	// Топ убийств по командам
	foreach(new tt:TDM_ActiveTeams[session_id]) {
		m_for(MODE_TDM, session_id, p) {
			if(Adm_GetPlayerSpectating(p)) 
				continue;

			if(GetPlayerTeamEx(p) != tt) 
				continue;

			players_Data[session_id][tt][tempVar[session_id][tt]][0] = Mode_GetPlayerKills(p);
			players_Data[session_id][tt][tempVar[session_id][tt]][2] = Mode_GetPlayerDeaths(p);
			GetPlayerName(p, players_Name[session_id][tt][p], MAX_PLAYER_NAME);
			players_Data[session_id][tt][tempVar[session_id][tt]++][1] = p;
		}
	}
	foreach(new tt:TDM_ActiveTeams[session_id]) {
		for(new i = 0, j = 0; i < tempVar[session_id][tt]; i++) {
			j = players_Data[session_id][tt][i][0];

			for(new k = i - 1; k > -1; k--) {
				if(j > players_Data[session_id][tt][k][0]) {
					players_Data[session_id][tt][k][0] ^= players_Data[session_id][tt][k + 1][0], players_Data[session_id][tt][k + 1][0] ^= players_Data[session_id][tt][k][0], players_Data[session_id][tt][k][0] ^= players_Data[session_id][tt][k + 1][0];
					players_Data[session_id][tt][k][1] ^= players_Data[session_id][tt][k + 1][1], players_Data[session_id][tt][k + 1][1] ^= players_Data[session_id][tt][k][1], players_Data[session_id][tt][k][1] ^= players_Data[session_id][tt][k + 1][1];
				}
			}
		}
	}

	// Топ 5 убийств в общем
	m_for(MODE_TDM, session_id, p) {
		if(Adm_GetPlayerSpectating(p)) 
			continue;

		bots_Data[session_id][bots_tempVar[session_id]][0] = Mode_GetPlayerKills(p);
		bots_Data[session_id][bots_tempVar[session_id]][2] = Mode_GetPlayerDeaths(p);
		GetPlayerName(p, bots_Name[session_id][p], MAX_PLAYER_NAME);
		bots_Data[session_id][bots_tempVar[session_id]++][1] = p;

		bots_Team[session_id][p] = GetPlayerTeamEx(p);

		if(GetPlayerSex(p) == SEX_MALE)
			bots_Skin[session_id][p] = TDM_GetClassSkin(GetPlayerTeamEx(p), GetPlayerCustomClass(p), 0);

		else if(GetPlayerSex(p) == SEX_FEMALE)
			bots_Skin[session_id][p] = TDM_GetClassSkin(GetPlayerTeamEx(p), GetPlayerCustomClass(p), 1);

		bots_Accs[session_id][p][0] = Inv_GetPlayerHead(p);
		bots_Accs[session_id][p][1] = Inv_GetPlayerHeadphones(p);
		bots_Accs[session_id][p][2] = Inv_GetPlayerGlasses(p);
		bots_Accs[session_id][p][3] = Inv_GetPlayerMask(p);
		bots_Accs[session_id][p][4] = Inv_GetPlayerWatch(p);

		bots_Cap[session_id][p] = TDM_GetPlayerClassWearning(p, 1);
		bots_Armor[session_id][p] = TDM_GetPlayerClassWearning(p, 2);
	}
	for(new i = 0, j = 0; i < bots_tempVar[session_id]; i++) {
		j = bots_Data[session_id][i][0];

		for(new k = i - 1; k > -1; k--) {
			if(j > bots_Data[session_id][k][0]) {
				bots_Data[session_id][k][0] ^= bots_Data[session_id][k + 1][0], bots_Data[session_id][k + 1][0] ^= bots_Data[session_id][k][0], bots_Data[session_id][k][0] ^= bots_Data[session_id][k + 1][0];
				bots_Data[session_id][k][1] ^= bots_Data[session_id][k + 1][1], bots_Data[session_id][k + 1][1] ^= bots_Data[session_id][k][1], bots_Data[session_id][k][1] ^= bots_Data[session_id][k + 1][1];
			}
		}
	}

	// Боты топ 5 убийств
	n_for(npcid, 5) {
		if(bots_Data[session_id][npcid][1] > -1) {
			new
				Float:X, Float:Y, Float:Z, Float:Angle,
				bot_id = bots_Data[session_id][npcid][1];

			TDM_GetSpawnTopBot(session_id, npcid, X, Y, Z, Angle);

			FCNPC_SetPosition(npc_top_kills[session_id][npcid], X, Y, Z);
			FCNPC_SetSkin(npc_top_kills[session_id][npcid], bots_Skin[session_id][bot_id]);
			FCNPC_Stop(npc_top_kills[session_id][npcid]);
			FCNPC_StopAttack(npc_top_kills[session_id][npcid]);
			FCNPC_SetWeapon(npc_top_kills[session_id][npcid], 0);
			FCNPC_SetAmmo(npc_top_kills[session_id][npcid], 0);
			FCNPC_SetQuaternion(npc_top_kills[session_id][npcid], 0.0, 0.0, 0.0, 0.0);
			FCNPC_SetAngle(npc_top_kills[session_id][npcid], Angle);
			FCNPC_SetInterior(npc_top_kills[session_id][npcid], Mode_GetInterior(MODE_TDM, session_id));
			FCNPC_SetVirtualWorld(npc_top_kills[session_id][npcid], Mode_GetVirtualWorld(MODE_TDM, session_id));
			SetPlayerColor(npc_top_kills[session_id][npcid], 0xCCCCCC00);

			n_for2(i, 5) {
				if(!bots_Accs[session_id][bot_id][i])
					continue;

				GiveAttachPlayerItem(npc_top_kills[session_id][npcid], bots_Accs[session_id][bot_id][i]);
			}
			TDM_SetPlayerAttachItem(npc_top_kills[session_id][npcid], bots_Skin[session_id][bot_id], bots_Cap[session_id][bot_id], bots_Armor[session_id][bot_id], bots_Accs[session_id][bot_id][0]);

			switch(npcid) {
				case 0: FCNPC_SetAnimation(npc_top_kills[session_id][npcid], 46, 4.0, 1, 0, 0, 0, 0);
				case 1: FCNPC_SetAnimation(npc_top_kills[session_id][npcid], 1288, 4.0, 1, 0, 0, 0, 0);
				case 2: FCNPC_SetAnimation(npc_top_kills[session_id][npcid], 1187, 4.0, 1, 0, 0, 0, 0);
				case 3: FCNPC_SetAnimation(npc_top_kills[session_id][npcid], 1191, 4.0, 1, 0, 0, 0, 0);
				case 4: FCNPC_SetAnimation(npc_top_kills[session_id][npcid], 41, 4.0, 1, 0, 0, 0, 0);
			}

			new
				str[100];

			f(str, "{FFFFFF}%i Место\n%s%s\n{FFFFFF}Убийств: {d91616}%i", npcid + 1, TDM_ShowTeamColor(bots_Team[session_id][bot_id]), bots_Name[session_id][bot_id], bots_Data[session_id][npcid][0]);
			npc_3DText[session_id][npcid] = CreateDynamic3DTextLabel(str, -1, 0.0, 0.0, -1.0, 50.0, npc_top_kills[session_id][npcid], INVALID_VEHICLE_ID, Mode_GetVirtualWorld(MODE_TDM, session_id), Mode_GetInterior(MODE_TDM, session_id));
		}
	}

	ShowResultRound(session_id);

	m_for(MODE_TDM, session_id, p) {
		if(!Adm_GetPlayerSpectating(p))
			HidePlayerElementsEndRound(p);
	}
	return 1;
}

static ShowResultRound(session_id)
{
	new
		mode_id = Mode_GetMode(MODE_TDM, session_id),
		max_number,
		bool:win_team[TDM_MAX_TEAMS],
		bool:draw_team[TDM_MAX_TEAMS],
		reward_exp[3],
		reward_money[3];

	switch(mode_id) {
		case TDM_MODE_CAPTURE: {
			foreach(new c:TDM_ActiveTeamsChet[session_id]) {
				if(TDM_GetTeamChet(session_id, c) > max_number) {
					win_team[c] = true;
					max_number = TDM_GetTeamChet(session_id, c);

					foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
						if(tt == c) 
							continue;

						if(TDM_GetTeamChet(session_id, tt) < TDM_GetTeamChet(session_id, c)) {
							win_team[tt] =
							draw_team[tt] = false;
						}
						else if(TDM_GetTeamChet(session_id, tt) == TDM_GetTeamChet(session_id, c))
							draw_team[c] = true;
					}
				}
				else if(TDM_GetTeamChet(session_id, c) == max_number) {
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
		case TDM_MODE_CAPTURE_FLAG: {
			foreach(new c:TDM_ActiveTeamsChet[session_id]) {
				if(TDM_GetTeamChet(session_id, c) > max_number) {
					win_team[c] = true;
					max_number = TDM_GetTeamChet(session_id, c);

					foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
						if(tt == c) 
							continue;

						if(TDM_GetTeamChet(session_id, tt) < TDM_GetTeamChet(session_id, c)) {
							win_team[tt] =
							draw_team[tt] = false;
						}
						else if(TDM_GetTeamChet(session_id, tt) == TDM_GetTeamChet(session_id, c))
							draw_team[c] = true;
					}
				}
				else if(TDM_GetTeamChet(session_id, c) == max_number) {
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
		case TDM_MODE_SECRET_DATA: {
			new
				bool:check_team_chet,
				bool:check_win_protect_team;

			foreach(new tt:TDM_ActiveTeams[session_id]) {
				if(!TDM_CheckTeamChet(session_id, tt))
					check_team_chet = true;
			}

			if(check_team_chet) {
				foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
					if(TDM_GetTeamChet(session_id, tt) < 1)
						win_team[tt] = false;
					else {
						win_team[tt] =
						check_win_protect_team = true;
					}
				}
				if(check_win_protect_team) {
					foreach(new tt:TDM_ActiveTeams[session_id]) {
						if(!TDM_CheckTeamChet(session_id, tt))
							win_team[tt] = false;
					}
				}
				else {
					foreach(new tt:TDM_ActiveTeams[session_id]) {
						if(!TDM_CheckTeamChet(session_id, tt))
							win_team[tt] = true;
					}
				}
			}
			else {
				foreach(new c:TDM_ActiveTeamsChet[session_id]) {
					if(TDM_GetTeamChet(session_id, c) > max_number) {
						win_team[c] = true;
						max_number = TDM_GetTeamChet(session_id, c);

						foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
							if(tt == c) 
								continue;

							if(TDM_GetTeamChet(session_id, tt) < TDM_GetTeamChet(session_id, c)) {
								win_team[tt] =
								draw_team[tt] = false;
							}
							else if(TDM_GetTeamChet(session_id, tt) == TDM_GetTeamChet(session_id, c))
								draw_team[c] = true;
						}
					}
					else if(TDM_GetTeamChet(session_id, c) == max_number) {
						win_team[c] =
						draw_team[c] = true;
					}
				}
			}
			reward_exp[0] = 1000; 	// Победа
			reward_exp[1] = 500; 	// Поражение
			reward_exp[2] = 600; 	// Ничья

			reward_money[0] = 800; 	// Победа
			reward_money[1] = 300; 	// Поражение
			reward_money[2] = 400; 	// Ничья
		}
		case TDM_MODE_BATTLE_KILLS: {
			foreach(new c:TDM_ActiveTeamsChet[session_id]) {
				if(TDM_GetTeamChet(session_id, c) > max_number) {
					win_team[c] = true;
					max_number = TDM_GetTeamChet(session_id, c);

					foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
						if(tt == c) 
							continue;

						if(TDM_GetTeamChet(session_id, tt) < TDM_GetTeamChet(session_id, c)) {
							win_team[tt] =
							draw_team[tt] = false;
						}
						else if(TDM_GetTeamChet(session_id, tt) == TDM_GetTeamChet(session_id, c))
							draw_team[c] = true;
					}
				}
				else if(TDM_GetTeamChet(session_id, c) == max_number) {
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
	}
	m_for(MODE_TDM, session_id, p) {
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

static HideResultMatch(session_id)
{
	n_for(npcid, 5) {
		FCNPC_SetPosition(npc_top_kills[session_id][npcid], 0.0, 0.0, 0.0);
		FCNPC_SetSkin(npc_top_kills[session_id][npcid], 0);
		FCNPC_Stop(npc_top_kills[session_id][npcid]);
		FCNPC_StopAttack(npc_top_kills[session_id][npcid]);
		FCNPC_SetWeapon(npc_top_kills[session_id][npcid], 0);
		FCNPC_SetAmmo(npc_top_kills[session_id][npcid], 0);
		FCNPC_SetQuaternion(npc_top_kills[session_id][npcid], 0.0, 0.0, 0.0, 0.0);
		FCNPC_SetAngle(npc_top_kills[session_id][npcid], 0.0);
		FCNPC_SetInterior(npc_top_kills[session_id][npcid], 0);
		FCNPC_SetVirtualWorld(npc_top_kills[session_id][npcid], 0);
		SetPlayerColor(npc_top_kills[session_id][npcid], 0xCCCCCC00);

		FCNPC_ResetAnimation(npc_top_kills[session_id][npcid]);
		RemoveAttachPlayerItem(npc_top_kills[session_id][npcid]);

		if(IsValidDynamic3DTextLabel(npc_3DText[session_id][npcid]))
			DestroyDynamic3DTextLabel(npc_3DText[session_id][npcid]);
	}

	ResetTopPlayers(session_id);
	ResetTopBots(session_id);
	return 1;
}

static ShowGoalLocation(playerid) 
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	switch(Mode_GetMode(MODE_TDM, session_id)) {
		case TDM_MODE_CAPTURE: {
			SCM(playerid, -1, "{FBAC32}(Локация) {FFFFFF}Захватывайте точки!");
		}
		case TDM_MODE_CAPTURE_FLAG: {
			SCM(playerid, -1, "{FBAC32}(Локация) {FFFFFF}Присвойте флаги противника!");
		}
		case TDM_MODE_SECRET_DATA: {
			SCM(playerid, -1, "{FBAC32}(Локация) {FFFFFF}Взломайте/деактивируйте компьютеры!");
		}
		case TDM_MODE_BATTLE_KILLS: {
			SCM(playerid, -1, "{FBAC32}(Локация) {FFFFFF}Одолейте все силы противника!");
		}
	}
	return 1;
}

static UpdateTeamsChet(session_id) 
{
	new 
		bool:endgame;

	switch(Mode_GetMode(MODE_TDM, session_id)) {
		case TDM_MODE_CAPTURE: {
			foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
				if(TDM_GetTeamChet(session_id, tt) < TDM_GetTeamMaxChet(session_id, tt)) {
					TDM_GiveTeamChet(session_id, tt, 1);

					TDM_GiveCPPointTeam(session_id, tt);

					if(TDM_GetTeamChet(session_id, tt) >= TDM_GetTeamMaxChet(session_id, tt)) {
						TDM_SetTeamChet(session_id, tt, TDM_GetTeamMaxChet(session_id, tt), TDM_GetTeamMaxChet(session_id, tt)); 

						m_for(MODE_TDM, session_id, p) 
							TDM_UpdatePlayerTDTeamChet(p);

						endgame = true;
					}
				}
			}
		}
		case TDM_MODE_CAPTURE_FLAG: {
			foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
				if(TDM_GetTeamChet(session_id, tt) >= TDM_GetTeamMaxChet(session_id, tt)) 
					endgame = true;
			}
		}
		case TDM_MODE_SECRET_DATA: {
			foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
				if(TDM_GetTeamChet(session_id, tt) < 1) 
					endgame = true;
			}
		}
		case TDM_MODE_BATTLE_KILLS: {
			foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
				if(TDM_GetTeamChet(session_id, tt) >= TDM_GetTeamMaxChet(session_id, tt))
					endgame = true;
			}
		}
	}

	if(endgame)
		LocationEndGame(session_id);

	return 1;
}

static ShowPlayerTDSelectPoint(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid),
		point;

	foreach(new g:TDM_CapturePointCount[session_id]) 
		point++;

	if(point) {
		for(new i = 0, td = 0; i < point; i++) {
			n_for(b, 6) {
				PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][td]);
				td++;
			}
		}
	}
	return 1;
}

static DestroyPlayerTDSelectPoint(playerid, bool:hide = true)
{
	new
		session_id = Mode_GetPlayerSession(playerid),
		point;

	foreach(new g:TDM_CapturePointCount[session_id]) 
		point++;

	if(point > 0) {
		if(hide) {
			for(new i = 0, td = 0; i < point; i++) {
				n_for(b, 6) {
					PlayerTextDrawHide(playerid, TD_SelectPoint[playerid][td]);
					td++;
				}
			}
		}
		else {
			for(new i = 0, td = 0; i < point; i++) {
				n_for(b, 6) {
					DestroyPlayerTD(playerid, TD_SelectPoint[playerid][td]);
					td++;
				}
			}
		}
	}
	return 1;
}

static ShowPlayerSelectSpawn(playerid)
{
	HidePlayerExitZone(playerid);

	ActionPlayerSelectTP{playerid} = true;
	SetPlayerZone(playerid, false);
	SetPlayerDamage(playerid, false);
	SetPlayerClickTD(playerid, true);

	SpecPl(playerid, true);

	Interface_Show(playerid, Interface:TDM_SelectTP);
	SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);

	TDM_SetPlayerBaseCamera(playerid, GetPlayerTeamEx(playerid));
	TDM_ShowPlayerBaseColor(playerid);

	Dina_CheckPlayerHint(playerid, 7);
	return 1;
}

static HidePlayerSelectSpawn(playerid, bool:spectate = true)
{
	if(spectate)
		SpecPl(playerid, false);
	else
		ActionPlayerSelectTP{playerid} = false;

	SetPlayerClickTD(playerid, false);
	UpdateTimerSelectTP[playerid] = 0;

	TimerChooseFromSpawn[playerid] = 0;
	TDM_HideSelectedPlayerTP(playerid);
	TDM_HideSelectedPointTP(playerid);

	if(Interface_IsOpen(playerid, Interface:TDM_SelectTP))
		Interface_Closing(playerid, Interface:TDM_SelectTP, true);

	if(Interface_IsOpen(playerid, Interface:TDM_SelectTeam))
		Interface_Close(playerid, Interface:TDM_SelectTeam);

	if(Interface_IsOpen(playerid, Interface:TDM_SelectClass))
		Interface_Close(playerid, Interface:TDM_SelectClass);

	if(Interface_IsOpen(playerid, Interface:TDM_SelectedClass))
		Interface_Close(playerid, Interface:TDM_SelectedClass);

	CancelSelectTextDraw(playerid);
	return 1;
}

static CreatePlayerNextLocation(playerid)
{
	ShowTDTimerNextLocation(playerid);
	SetPVarInt(playerid, "TNextLocationTDM_PVar", 1);
	PlayerTextDrawShow(playerid, TD_TNextLocation[playerid]);
	return 1;
}

static DestroyPlayerNextLocation(playerid)
{
	if(GetPVarInt(playerid, "TNextLocationTDM_PVar") != 1)
		return 1;

	PlayerSelectVoteLocation[playerid] = -1;
	DeletePVar(playerid, "TNextLocationTDM_PVar");
	DestroyPlayerTD(playerid, TD_TNextLocation[playerid]);
	return 1;
}

static UpdatePlayerNextLocation(playerid)
{
	if(GetPVarInt(playerid, "TNextLocationTDM_PVar") != 1)
		return 1;

	new
		session_id = Mode_GetPlayerSession(playerid);

	new
		str[35];

	f(str, "Следующая_локация_через:_~y~%i_", tdm_location_end_timer[session_id]);
	PlayerTextDrawSetString(playerid, TD_TNextLocation[playerid], str);
	return 1;
}

static ShowTDTimerNextLocation(playerid)
{
	// Таймер
	TD_TNextLocation[playerid] = CreatePlayerTextDraw(playerid, 320.0000, 95.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_TNextLocation[playerid], 0.2085, 1.3178);
	PlayerTextDrawTextSize(playerid, TD_TNextLocation[playerid], 0.0000, 137.0000);
	PlayerTextDrawAlignment(playerid, TD_TNextLocation[playerid], 2);
	PlayerTextDrawColor(playerid, TD_TNextLocation[playerid], -1);
	PlayerTextDrawUseBox(playerid, TD_TNextLocation[playerid], 1);
	PlayerTextDrawBoxColor(playerid, TD_TNextLocation[playerid], 1768516095);
	PlayerTextDrawBackgroundColor(playerid, TD_TNextLocation[playerid], 1768515993);
	PlayerTextDrawFont(playerid, TD_TNextLocation[playerid], 2);
	PlayerTextDrawSetProportional(playerid, TD_TNextLocation[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TD_TNextLocation[playerid], 0);
	return 1;
}

static CreatePlayerSelectSpawn(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	if(tdm_location_game_status[session_id] != TDM_LOC_GAME_STATUS_GAME)
		return 1;

	ActionPlayerTDSelectTP[playerid] = TD_CREATED;
	
	CreatePlayerTDSelectSpawnGui(playerid);
	TDM_CreateTDSelectSpawnPlayer(playerid);
	CreatePlayerTDSelectPoint(playerid);

	TDM_ShowPlayerBaseColor(playerid);
	return 1;
}

static HidePlayerElementsEndRound(playerid)
{
	ResetPlayerMG(playerid);
	HidePlayerExitZone(playerid);

	SetPlayerDamage(playerid, false);

	if(ActionPlayerSelectTP{playerid})
		HidePlayerSelectSpawn(playerid, false);
	else {
		DestroyPlayerBelowHealth(playerid);
		DestroyPlayerBaseIndicators(playerid, false);
		Mode_DestroyPlayerMatchPoints(playerid);
		DestroyPlayerFPSandPING(playerid);
		DestroyPlayerStatsRound(playerid);
	}
	SetPlayerKillStrike(playerid, 0);
	HidePlayerKillStrike(playerid);
	ClearKillFeed(playerid);
	DestroyPlayerSpawnKill(playerid);
	Interface_Closing(playerid, Interface:TDM_SelectTP, false);

	if(!GetPlayerDead(playerid)) {
		SpecPl(playerid, true);
		ShowPlayerResultRound(playerid);
		TDM_ShowCameraEndLocation(playerid, 1);

		Mode_SetPlayerMatchPoint(playerid, 0);
		Mode_SetPlayerKill(playerid, 0);
		Mode_SetPlayerDeath(playerid, 0);
	}
	SetPlayerHealthEx(playerid, 100.0);
	return 1;
}

static ShowPlayerTDTextTeamMatch(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	foreach(new tt:TDM_ActiveTeams[session_id]) {
		if(GetPlayerTeamEx(playerid) != tt) 
			continue;

		TD_TextTeamMatch[playerid][tt] = CreatePlayerTextDraw(playerid, 326.000000, 108.000000, "_");
		PlayerTextDrawLetterSize(playerid, TD_TextTeamMatch[playerid][tt], 0.310666, 1.711999);
		PlayerTextDrawAlignment(playerid, TD_TextTeamMatch[playerid][tt], 2);
		PlayerTextDrawColor(playerid, TD_TextTeamMatch[playerid][tt], -858993409);
		PlayerTextDrawSetShadow(playerid, TD_TextTeamMatch[playerid][tt], 0);
		PlayerTextDrawSetOutline(playerid, TD_TextTeamMatch[playerid][tt], 1);
		PlayerTextDrawBackgroundColor(playerid, TD_TextTeamMatch[playerid][tt], 48);
		PlayerTextDrawFont(playerid, TD_TextTeamMatch[playerid][tt], 2);
		PlayerTextDrawSetProportional(playerid, TD_TextTeamMatch[playerid][tt], 1);
		PlayerTextDrawSetShadow(playerid, TD_TextTeamMatch[playerid][tt], 0);
	}
	return 1;
}

static UpdatePlayerTDTextTeamMatch(playerid, text[])
{
	if(ActionPlayerTextRound{playerid}) 
		return 1;

	ActionPlayerTextRound{playerid} = true;
	ShowPlayerTDTextTeamMatch(playerid);
	PlayerTextDrawSetString(playerid, TD_TextTeamMatch[playerid][GetPlayerTeamEx(playerid)], text);
	PlayerTextDrawShow(playerid, TD_TextTeamMatch[playerid][GetPlayerTeamEx(playerid)]);
	return 1;
}

static DestroyPlTDTextTeamMatch(playerid, player_team)
{
	if(!ActionPlayerTextRound{playerid})
		return 1;

	ActionPlayerTextRound{playerid} = false;
	DestroyPlayerTD(playerid, TD_TextTeamMatch[playerid][player_team]);
	return 1;
}

static UpdatePlTDCellsNextLocation(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	for(new td = 4, i = 0; i < TDM_MAX_CHANGE_MAP_LIST; td += 4, i++) {
		new
			str[100];

		f(str, "%s", TDM_GetNameLocation(change_map_list[session_id][i]));
		PlayerTextDrawSetString(playerid, TD_SelectNextLocation[playerid][td], str);
		str[0] = EOS;
	
		new
			name_mode[50];

		f(name_mode, "%s", TDM_GetModeName(TDM_GetModeLocation(change_map_list[session_id][i])));
	
		for(new text = strlen(name_mode) - 1; text != -1; text--) {
			switch(name_mode[text]) {
				case ' ': name_mode[text] = '_';
			}
		}

		f(str, "%s", name_mode);
		PlayerTextDrawSetString(playerid, TD_SelectNextLocation[playerid][td + 1], str);
		str[0] = EOS;

		f(str, "Голосов:_%i", select_vote_location[session_id][i]);
		PlayerTextDrawSetString(playerid, TD_SelectNextLocation[playerid][td + 2], str);
	}
	return 1;
}

static UpdatePlTDCellsVoiceLocation(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	for(new td = 6, i = 0; i < TDM_MAX_CHANGE_MAP_LIST; td += 4, i++) {
		new 
			str[100];

		f(str, "Голосов:_%i", select_vote_location[session_id][i]);
		PlayerTextDrawSetString(playerid, TD_SelectNextLocation[playerid][td], str);
	}
	return 1;
}

static CreateTDPlayerNextLocation(playerid)
{
	if(ActionPlayerTDNextLocation{playerid})
		return 1;

	ActionPlayerTDNextLocation{playerid} = true;
	ShowPlTDSelectNextLocation(playerid);
	UpdatePlTDCellsNextLocation(playerid);

	n_for(i, sizeof(TD_SelectNextLocation[]))
		PlayerTextDrawShow(playerid, TD_SelectNextLocation[playerid][i]);

	return 1;
}

static DestroyTDSelectNextLocation(playerid)
{
	if(!ActionPlayerTDNextLocation{playerid})
		return 1;

	ActionPlayerTDNextLocation{playerid} = false;

	n_for(i, sizeof(TD_SelectNextLocation[]))
		DestroyPlayerTD(playerid, TD_SelectNextLocation[playerid][i]);

	return 1;
}

static RandomLocationList(session_id)
{
	new
		amount_maps = TDM_MAX_LOCATIONS,
		random_map;

	n_for(i, amount_maps)
		not_selected_maps[session_id][i] = i;

	n_for(i, TDM_MAX_CHANGE_MAP_LIST) {
		amount_maps--;
		random_map = random_ex(0, amount_maps, 1);
		change_map_list[session_id][i] = not_selected_maps[session_id][random_map];
		not_selected_maps[session_id][random_map] = not_selected_maps[session_id][amount_maps];
	}
	return 1;
}

static SettingsPlayerSpawn(playerid)
{
	new
		Float:X, Float:Y, Float:Z,
		skin_id = Mode_GetPlayerSkin(playerid, MODE_TDM),
		session_id = Mode_GetPlayerSession(playerid),
		random_pos = random(3);
	
	Mode_SetPlayerVirtualWorld(playerid, MODE_TDM, session_id);
	Mode_SetPlayerInterior(playerid, MODE_TDM, session_id);
	
	TDM_GetBaseSpawn(session_id, GetPlayerTeamEx(playerid), random_pos, X, Y, Z);
	SetSpawnInfoEx(playerid, skin_id, X, Y, Z + 0.3, 0.0);
	return 1;
}

static SetPlayerAmmunition(playerid)
{
	TDM_SetPlayerClassAmmunition(playerid);

	if(GetPlayerPremium(playerid))
		GivePlayerWeaponEx(playerid, 35, 10);
	
	SetPlayerColorEx(playerid, TDM_ShowTeamColorXB(GetPlayerTeamEx(playerid)));
	return 1;
}

static ResetTopPlayers(session_id)
{
	n_for(tt, TDM_MAX_TEAMS) {
		n_for2(b, 10) {
			players_Data[session_id][tt][b][0] =
			players_Data[session_id][tt][b][1] =
			players_Data[session_id][tt][b][2] = -1;
			players_Name[session_id][tt][b][0] = EOS;
		}
		tempVar[session_id][tt] = 0;
	}
	return 1;
}

static ResetTopBots(session_id)
{
	n_for(b, 5) {
		npc_3DText[session_id][b] = INVALID_DYNAMIC_3D_TEXT_ID;

		bots_Data[session_id][b][0] =
		bots_Data[session_id][b][1] =
		bots_Data[session_id][b][2] = -1;
		bots_Name[session_id][b][0] = EOS;
		bots_Team[session_id][b] =
		bots_Skin[session_id][b] = 0;

		n_for2(i, 5)
			bots_Accs[session_id][b][i] = 0;

		bots_Cap[session_id][b] =
		bots_Armor[session_id][b] = 0;
	}
	bots_tempVar[session_id] = 0;
	return 1;
}

static ShowPlayerResultRound(playerid)
{
	if(GetPVarInt(playerid, "ResultRound_PVar"))
		return 1;

	new
		session_id = Mode_GetPlayerSession(playerid);

	SetPVarInt(playerid, "ResultRound_PVar", 1);
	
	new 
		teams = Iter_Count(TDM_ActiveTeams[session_id]),
		num;

	foreach(new tt:TDM_ActiveTeams[session_id]) {
		// Делится
		if(IsCh(tt)) 
			CreatePlayerTDResultChet(playerid, tt, false, num, teams);
		// Не делится
		else { 
			if((num + 1) == teams) 
				CreatePlayerTDResultChet(playerid, tt, true, num, teams);
			else 
				CreatePlayerTDResultChet(playerid, tt, false, num, teams);
		}
		num++;
	}
	CreatePlayerNextLocation(playerid);
	return 1;
}

static HidePlayerResultRound(playerid)
{
	if(!GetPVarInt(playerid, "ResultRound_PVar"))
		return 1;

	new
		session_id = Mode_GetPlayerSession(playerid);

	DeletePVar(playerid, "ResultRound_PVar");

	new
		num;

	foreach(new tt:TDM_ActiveTeams[session_id]) {
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

	Mode_SetPlayerExp(playerid, 0);
	Mode_SetPlayerMoney(playerid, 0);
	return 1;
}

/*

	* TextDraws *

*/

static CreatePlayerTDTeamChet(playerid, td_id = -1, one_td_id = -1, team_id, maxchet)
{
	new
		str[50];

	f(str, "%s", TDM_GetTeamName(team_id));

	if(one_td_id != -1) {
		switch(one_td_id) {
			case 0: {
				PlayerChetLocation[playerid][0] = CreatePlayerProgressBar(playerid, 284.00, 43.00, 84.50, 5.19, TDM_ShowTeamColorXB(team_id), maxchet, BAR_DIRECTION_RIGHT);

				// Название команды
				TD_ChetLocation[playerid][0] = CreatePlayerTextDraw(playerid, 324.000000, 29.000000, str);
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][0], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][0], 2);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][0], TDM_ShowTeamColorXB(team_id));
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
			case 2: {
				PlayerChetLocation[playerid][2] = CreatePlayerProgressBar(playerid, 284.00, 65.00, 84.50, 5.19, TDM_ShowTeamColorXB(team_id), maxchet, BAR_DIRECTION_RIGHT);

				TD_ChetLocation[playerid][4] = CreatePlayerTextDraw(playerid, 324.000000, 51.000000, str);
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][4], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][4], 2);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][4], TDM_ShowTeamColorXB(team_id));
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][4], 1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][4], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][4], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][4], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][4], 1);

				TD_ChetLocation[playerid][5] = CreatePlayerTextDraw(playerid, 323.000000, 62.000000, "_");
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][5], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][5], 2);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][5], -1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][5], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][5], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][5], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][5], 1);
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][5], 0);

				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][4]), PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][5]);
			}
		}
	}

	if(td_id != -1) {
		switch(td_id) {
			case 0: {
				PlayerChetLocation[playerid][0] = CreatePlayerProgressBar(playerid, 317.00, 43.00, 84.50, 5.19, TDM_ShowTeamColorXB(team_id), maxchet, BAR_DIRECTION_LEFT);

				// Название команды
				TD_ChetLocation[playerid][0] = CreatePlayerTextDraw(playerid, 316.000000, 29.000000, str);
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][0], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][0], 3);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][0], TDM_ShowTeamColorXB(team_id));
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

				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][0]), PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][1]);
			}
			case 1: {
				PlayerChetLocation[playerid][1] = CreatePlayerProgressBar(playerid, 327.00, 43.00, 84.50, 5.19, TDM_ShowTeamColorXB(team_id), maxchet, BAR_DIRECTION_RIGHT);

				TD_ChetLocation[playerid][2] = CreatePlayerTextDraw(playerid, 326.000000, 29.000000, str);
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][2], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][2], 1);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][2], TDM_ShowTeamColorXB(team_id));
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][2], 1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][2], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][2], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][2], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][2], 1);

				TD_ChetLocation[playerid][3] = CreatePlayerTextDraw(playerid, 327.000000, 40.000000, "_");
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][3], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][3], 1);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][3], -1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][3], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][3], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][3], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][3], 1);
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][3], 0);

				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][2]), PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][3]);
			}
			case 2: {
				PlayerChetLocation[playerid][2] = CreatePlayerProgressBar(playerid, 317.00, 65.00, 84.50, 5.19, TDM_ShowTeamColorXB(team_id), maxchet, BAR_DIRECTION_LEFT);

				TD_ChetLocation[playerid][4] = CreatePlayerTextDraw(playerid, 316.000000, 51.000000, str);
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][4], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][4], 3);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][4], TDM_ShowTeamColorXB(team_id));
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][4], 1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][4], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][4], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][4], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][4], 1);

				TD_ChetLocation[playerid][5] = CreatePlayerTextDraw(playerid, 316.000000, 62.000000, "_");
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][5], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][5], 3);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][5], -1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][5], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][5], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][5], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][5], 1);
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][5], 0);

				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][4]), PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][5]);
			}
			case 3: {
				PlayerChetLocation[playerid][3] = CreatePlayerProgressBar(playerid, 327.00, 65.00, 84.50, 5.19, TDM_ShowTeamColorXB(team_id), maxchet, BAR_DIRECTION_RIGHT);

				TD_ChetLocation[playerid][6] = CreatePlayerTextDraw(playerid, 326.000000, 51.000000, str);
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][6], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][6], 1);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][6], TDM_ShowTeamColorXB(team_id));
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][6], 1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][6], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][6], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][6], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][6], 1);

				TD_ChetLocation[playerid][7] = CreatePlayerTextDraw(playerid, 327.000000, 62.000000, "_");
				PlayerTextDrawLetterSize(playerid, TD_ChetLocation[playerid][7], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, TD_ChetLocation[playerid][7], 1);
				PlayerTextDrawColor(playerid, TD_ChetLocation[playerid][7], -1);
				PlayerTextDrawSetOutline(playerid, TD_ChetLocation[playerid][7], 0);
				PlayerTextDrawBackgroundColor(playerid, TD_ChetLocation[playerid][7], 255);
				PlayerTextDrawFont(playerid, TD_ChetLocation[playerid][7], 2);
				PlayerTextDrawSetProportional(playerid, TD_ChetLocation[playerid][7], 1);
				PlayerTextDrawSetShadow(playerid, TD_ChetLocation[playerid][7], 0);

				PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][6]), PlayerTextDrawShow(playerid, TD_ChetLocation[playerid][7]);
			}
		}
	}
	return 1;
}

static CreatePlayerTDSelectSpawnGui(playerid)
{
	// Белый фон начать
	TD_SelectSpawn[playerid][0] = CreatePlayerTextDraw(playerid, 168.0000, 417.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][0], 45.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][0], -1717986817);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectSpawn[playerid][0], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectSpawn[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон начать
	TD_SelectSpawn[playerid][1] = CreatePlayerTextDraw(playerid, 169.0000, 418.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][1], 43.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][1], 303174399);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SelectSpawn[playerid][1], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectSpawn[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectSpawn[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_SelectSpawn[playerid][2] = CreatePlayerTextDraw(playerid, 191.0000, 419.0000, "Начать");
	PlayerTextDrawLetterSize(playerid, TD_SelectSpawn[playerid][2], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][2], 15.0000, 42.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][2], 2);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][2], -949919233);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SelectSpawn[playerid][2], true);

	// Белый фон смена персонажа
	TD_SelectSpawn[playerid][3] = CreatePlayerTextDraw(playerid, 218.0000, 417.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][3], 112.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][3], -1717986817);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectSpawn[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectSpawn[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон смена персонажа
	TD_SelectSpawn[playerid][4] = CreatePlayerTextDraw(playerid, 219.0000, 418.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][4], 110.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][4], 303174399);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SelectSpawn[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectSpawn[playerid][4], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectSpawn[playerid][4], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_SelectSpawn[playerid][5] = CreatePlayerTextDraw(playerid, 274.0000, 419.0000, "Смена_персонажа");
	PlayerTextDrawLetterSize(playerid, TD_SelectSpawn[playerid][5], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][5], 15.0000, 110.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][5], 2);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][5], 1636288511);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][5], 255);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][5], 2);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SelectSpawn[playerid][5], true);

	// Белый фон квестов
	TD_SelectSpawn[playerid][6] = CreatePlayerTextDraw(playerid, 336.0000, 417.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][6], 45.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][6], 1);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][6], -1717986817);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][6], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectSpawn[playerid][6], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectSpawn[playerid][6], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон квестов
	TD_SelectSpawn[playerid][7] = CreatePlayerTextDraw(playerid, 337.0000, 418.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][7], 43.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][7], 1);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][7], 303174399);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SelectSpawn[playerid][7], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectSpawn[playerid][7], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectSpawn[playerid][7], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_SelectSpawn[playerid][8] = CreatePlayerTextDraw(playerid, 359.0000, 419.0000, "Квесты");
	PlayerTextDrawLetterSize(playerid, TD_SelectSpawn[playerid][8], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][8], 15.0000, 44.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][8], 2);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][8], -910794241);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][8], 255);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SelectSpawn[playerid][8], true);

	// Белый фон смена команды
	TD_SelectSpawn[playerid][9] = CreatePlayerTextDraw(playerid, 386.0000, 417.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][9], 101.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][9], 1);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][9], -1717986817);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][9], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectSpawn[playerid][9], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectSpawn[playerid][9], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон смена команжды
	TD_SelectSpawn[playerid][10] = CreatePlayerTextDraw(playerid, 387.0000, 418.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][10], 99.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][10], 1);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][10], 303174399);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SelectSpawn[playerid][10], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectSpawn[playerid][10], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectSpawn[playerid][10], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_SelectSpawn[playerid][11] = CreatePlayerTextDraw(playerid, 437.0000, 419.0000, "Смена_команды");
	PlayerTextDrawLetterSize(playerid, TD_SelectSpawn[playerid][11], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, TD_SelectSpawn[playerid][11], 15.0000, 98.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectSpawn[playerid][11], 2);
	PlayerTextDrawColor(playerid, TD_SelectSpawn[playerid][11], -1429773825);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectSpawn[playerid][11], 255);
	PlayerTextDrawFont(playerid, TD_SelectSpawn[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, TD_SelectSpawn[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, TD_SelectSpawn[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SelectSpawn[playerid][11], true);
	return 1;
}

static CreatePlayerTDSelectPoint(playerid) 
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	// Координаты квадратных точек TD's в зависимости от их количества
	static const
		Float:pos_td[][][] = {
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

	foreach(new g:TDM_CapturePointCount[session_id])
		point++;

	if(point > 0) {
		for(new i = 0, td = 0, points = point - 1; i < point; i++) {
			// Белый фон точки
			TD_SelectPoint[playerid][td] = CreatePlayerTextDraw(playerid, pos_td[points][i][0], pos_td[points][i][1], "");
			PlayerTextDrawTextSize(playerid, TD_SelectPoint[playerid][td], 55.0000, 49.0000);
			PlayerTextDrawAlignment(playerid, TD_SelectPoint[playerid][td], 1);
			PlayerTextDrawColor(playerid, TD_SelectPoint[playerid][td], -1);
			PlayerTextDrawBackgroundColor(playerid, TD_SelectPoint[playerid][td], -1717986817);
			PlayerTextDrawFont(playerid, TD_SelectPoint[playerid][td], 5);
			PlayerTextDrawSetProportional(playerid, TD_SelectPoint[playerid][td], 0);
			PlayerTextDrawSetShadow(playerid, TD_SelectPoint[playerid][td], 0);
			PlayerTextDrawSetPreviewModel(playerid, TD_SelectPoint[playerid][td], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_SelectPoint[playerid][td], 0.0000, 0.0000, 0.0000, 1000.0000);
			td++;

			// Кликабельный фон
			TD_SelectPoint[playerid][td] = CreatePlayerTextDraw(playerid, pos_td[points][i][0] + 1.0, pos_td[points][i][1] + 1.0, "");
			PlayerTextDrawTextSize(playerid, TD_SelectPoint[playerid][td], 53.0000, 47.0000);
			PlayerTextDrawAlignment(playerid, TD_SelectPoint[playerid][td], 1);
			PlayerTextDrawColor(playerid, TD_SelectPoint[playerid][td], -1);
			PlayerTextDrawBackgroundColor(playerid, TD_SelectPoint[playerid][td], 303174399);
			PlayerTextDrawFont(playerid, TD_SelectPoint[playerid][td], 5);
			PlayerTextDrawSetProportional(playerid, TD_SelectPoint[playerid][td], 0);
			PlayerTextDrawSetShadow(playerid, TD_SelectPoint[playerid][td], 0);
			PlayerTextDrawSetSelectable(playerid, TD_SelectPoint[playerid][td], true);
			PlayerTextDrawSetPreviewModel(playerid, TD_SelectPoint[playerid][td], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_SelectPoint[playerid][td], 0.0000, 0.0000, 0.0000, 1000.0000);
			td++;

			// Задний фон точки
			TD_SelectPoint[playerid][td] = CreatePlayerTextDraw(playerid, pos_td[points][i][0] + 14.0, pos_td[points][i][1] + 3.0, "");
			PlayerTextDrawTextSize(playerid, TD_SelectPoint[playerid][td], 27.0000, 21.0000);
			PlayerTextDrawAlignment(playerid, TD_SelectPoint[playerid][td], 1);
			PlayerTextDrawColor(playerid, TD_SelectPoint[playerid][td], -1);
			PlayerTextDrawBackgroundColor(playerid, TD_SelectPoint[playerid][td], TDM_ShowTeamColorXF(TDM_GetPointTeam(session_id, i)));
			PlayerTextDrawFont(playerid, TD_SelectPoint[playerid][td], 5);
			PlayerTextDrawSetProportional(playerid, TD_SelectPoint[playerid][td], 0);
			PlayerTextDrawSetShadow(playerid, TD_SelectPoint[playerid][td], 0);
			PlayerTextDrawSetPreviewModel(playerid, TD_SelectPoint[playerid][td], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_SelectPoint[playerid][td], 0.0000, 0.0000, 0.0000, 1000.0000);
			td++;

			// Точка
			TD_SelectPoint[playerid][td] = CreatePlayerTextDraw(playerid, pos_td[points][i][0] + 28.0, pos_td[points][i][1] + 4.0, GetNamePoint(i));
			PlayerTextDrawLetterSize(playerid, TD_SelectPoint[playerid][td], 0.4170, 1.8157);
			PlayerTextDrawAlignment(playerid, TD_SelectPoint[playerid][td], 2);
			PlayerTextDrawColor(playerid, TD_SelectPoint[playerid][td], -101058561);
			PlayerTextDrawSetOutline(playerid, TD_SelectPoint[playerid][td], 1);
			PlayerTextDrawBackgroundColor(playerid, TD_SelectPoint[playerid][td], 144);
			PlayerTextDrawFont(playerid, TD_SelectPoint[playerid][td], 2);
			PlayerTextDrawSetProportional(playerid, TD_SelectPoint[playerid][td], 1);
			PlayerTextDrawSetShadow(playerid, TD_SelectPoint[playerid][td], 0);
			td++;

			new
				str[50];

			if(TDM_GetPointTeam(session_id, i) != GetPlayerTeamEx(playerid)) 
				str = "ЗАХВАТИТЬ";
			else {
				if(!TDM_GetPointRed(session_id, i))
					str = "ЗАЩИЩАТЬ";
				else 
					str = "ТЕРЯЕМ";
			}

			// Статус точки
			TD_SelectPoint[playerid][td] = CreatePlayerTextDraw(playerid, pos_td[points][i][0] + 28.0, pos_td[points][i][1] + 23.0, str);
			PlayerTextDrawLetterSize(playerid, TD_SelectPoint[playerid][td], 0.2186, 1.4174);
			PlayerTextDrawTextSize(playerid, TD_SelectPoint[playerid][td], 0.0000, 51.0000);
			PlayerTextDrawAlignment(playerid, TD_SelectPoint[playerid][td], 2);
			PlayerTextDrawColor(playerid, TD_SelectPoint[playerid][td], TDM_ShowTeamColorXF(TDM_GetPointTeam(session_id, i)));
			PlayerTextDrawBackgroundColor(playerid, TD_SelectPoint[playerid][td], 80);
			PlayerTextDrawFont(playerid, TD_SelectPoint[playerid][td], 1);
			PlayerTextDrawSetProportional(playerid, TD_SelectPoint[playerid][td], 1);
			PlayerTextDrawSetShadow(playerid, TD_SelectPoint[playerid][td], 0);
			td++;
			str[0] = EOS;

			f(str, "%s", TDM_GetPointName(session_id, i));

			// Название точки 
			TD_SelectPoint[playerid][td] = CreatePlayerTextDraw(playerid, pos_td[points][i][0] + 28.0, pos_td[points][i][1] + 33.0, str);
			PlayerTextDrawLetterSize(playerid, TD_SelectPoint[playerid][td], 0.1956, 1.5128);
			PlayerTextDrawTextSize(playerid, TD_SelectPoint[playerid][td], 0.0000, 51.0000);
			PlayerTextDrawAlignment(playerid, TD_SelectPoint[playerid][td], 2);
			PlayerTextDrawColor(playerid, TD_SelectPoint[playerid][td], TDM_ShowTeamColorXF(TDM_GetPointTeam(session_id, i)));
			PlayerTextDrawBackgroundColor(playerid, TD_SelectPoint[playerid][td], 80);
			PlayerTextDrawFont(playerid, TD_SelectPoint[playerid][td], 1);
			PlayerTextDrawSetProportional(playerid, TD_SelectPoint[playerid][td], 1);
			PlayerTextDrawSetShadow(playerid, TD_SelectPoint[playerid][td], 0);
			td++;
			str[0] = EOS;
		}
	}
	return 1;
}

static ShowPlTDSelectNextLocation(playerid)
{
	// Основной задний фон
	TD_SelectNextLocation[playerid][0] = CreatePlayerTextDraw(playerid, 226.0000, 117.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectNextLocation[playerid][0], 188.0000, 78.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectNextLocation[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_SelectNextLocation[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectNextLocation[playerid][0], 976894719);
	PlayerTextDrawFont(playerid, TD_SelectNextLocation[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectNextLocation[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectNextLocation[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectNextLocation[playerid][0], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectNextLocation[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Основной задний фон
	TD_SelectNextLocation[playerid][1] = CreatePlayerTextDraw(playerid, 226.0000, 117.0000, "");
	PlayerTextDrawTextSize(playerid, TD_SelectNextLocation[playerid][1], 188.0000, 14.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectNextLocation[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_SelectNextLocation[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectNextLocation[playerid][1], 757935615);
	PlayerTextDrawFont(playerid, TD_SelectNextLocation[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, TD_SelectNextLocation[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TD_SelectNextLocation[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectNextLocation[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SelectNextLocation[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_SelectNextLocation[playerid][2] = CreatePlayerTextDraw(playerid, 320.9997, 116.0000, "Выбор_локации");
	PlayerTextDrawLetterSize(playerid, TD_SelectNextLocation[playerid][2], 0.2596, 1.5377);
	PlayerTextDrawTextSize(playerid, TD_SelectNextLocation[playerid][2], 0.0000, 167.0000);
	PlayerTextDrawAlignment(playerid, TD_SelectNextLocation[playerid][2], 2);
	PlayerTextDrawColor(playerid, TD_SelectNextLocation[playerid][2], -505290753);
	PlayerTextDrawBackgroundColor(playerid, TD_SelectNextLocation[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_SelectNextLocation[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TD_SelectNextLocation[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_SelectNextLocation[playerid][2], 0);

	new
		Float:initialcoords[2] = {230.0, 135.0};

	for(new td = 3, s = 1; td < sizeof(TD_SelectNextLocation[]); td++, s++) {
		// Чёрный фон
		TD_SelectNextLocation[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0], initialcoords[1], "");
		PlayerTextDrawTextSize(playerid, TD_SelectNextLocation[playerid][td], 58.0000, 55.0000);
		PlayerTextDrawAlignment(playerid, TD_SelectNextLocation[playerid][td], 1);
		PlayerTextDrawColor(playerid, TD_SelectNextLocation[playerid][td], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectNextLocation[playerid][td], 303174399);
		PlayerTextDrawFont(playerid, TD_SelectNextLocation[playerid][td], 5);
		PlayerTextDrawSetProportional(playerid, TD_SelectNextLocation[playerid][td], 0);
		PlayerTextDrawSetShadow(playerid, TD_SelectNextLocation[playerid][td], 0);
		PlayerTextDrawSetSelectable(playerid, TD_SelectNextLocation[playerid][td], true);
		PlayerTextDrawSetPreviewModel(playerid, TD_SelectNextLocation[playerid][td], 0);
		PlayerTextDrawSetPreviewRot(playerid, TD_SelectNextLocation[playerid][td], 0.0000, 0.0000, 0.0000, 1000.0000);
		td++;

		// Название локации
		TD_SelectNextLocation[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 29.0, initialcoords[1] + 2.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_SelectNextLocation[playerid][td], 0.1940, 1.5377);
		PlayerTextDrawTextSize(playerid, TD_SelectNextLocation[playerid][td], 0.0000, 51.0000);
		PlayerTextDrawAlignment(playerid, TD_SelectNextLocation[playerid][td], 2);
		PlayerTextDrawColor(playerid, TD_SelectNextLocation[playerid][td], -394258433);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectNextLocation[playerid][td], -394258433);
		PlayerTextDrawFont(playerid, TD_SelectNextLocation[playerid][td], 2);
		PlayerTextDrawSetProportional(playerid, TD_SelectNextLocation[playerid][td], 1);
		PlayerTextDrawSetShadow(playerid, TD_SelectNextLocation[playerid][td], 0);
		td++;

		// Название режима
		TD_SelectNextLocation[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 29.0, initialcoords[1] + 19.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_SelectNextLocation[playerid][td], 0.1743, 1.5294);
		PlayerTextDrawTextSize(playerid, TD_SelectNextLocation[playerid][td], 0.0000, 51.0000);
		PlayerTextDrawAlignment(playerid, TD_SelectNextLocation[playerid][td], 2);
		PlayerTextDrawColor(playerid, TD_SelectNextLocation[playerid][td], -648201473);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectNextLocation[playerid][td], -394258433);
		PlayerTextDrawFont(playerid, TD_SelectNextLocation[playerid][td], 2);
		PlayerTextDrawSetProportional(playerid, TD_SelectNextLocation[playerid][td], 1);
		PlayerTextDrawSetShadow(playerid, TD_SelectNextLocation[playerid][td], 0);
		td++;

		// Голосов
		TD_SelectNextLocation[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 29.0, initialcoords[1] + 37.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_SelectNextLocation[playerid][td], 0.1940, 1.5377);
		PlayerTextDrawTextSize(playerid, TD_SelectNextLocation[playerid][td], 0.0000, 51.0000);
		PlayerTextDrawAlignment(playerid, TD_SelectNextLocation[playerid][td], 2);
		PlayerTextDrawColor(playerid, TD_SelectNextLocation[playerid][td], -2139062017);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectNextLocation[playerid][td], -394258433);
		PlayerTextDrawFont(playerid, TD_SelectNextLocation[playerid][td], 2);
		PlayerTextDrawSetProportional(playerid, TD_SelectNextLocation[playerid][td], 1);
		PlayerTextDrawSetShadow(playerid, TD_SelectNextLocation[playerid][td], 0);

		initialcoords[0] += 60.0;
	}
	return 1;
}

static TDM_CreateTDSelectSpawnPlayer(playerid)
{
	new
		Float:initialcoords[2] = {157.0, 361.0},
		td = 0;

	n_for(i, 5) {
		if(i == 4) {
			// Белый фон группа
			TD_SelectPlayer[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0], initialcoords[1], "");
			PlayerTextDrawTextSize(playerid, TD_SelectPlayer[playerid][td], 66.0000, 50.0000);
			PlayerTextDrawAlignment(playerid, TD_SelectPlayer[playerid][td], 1);
			PlayerTextDrawColor(playerid, TD_SelectPlayer[playerid][td], -1);
			PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][td], -1717986817);
			PlayerTextDrawFont(playerid, TD_SelectPlayer[playerid][td], 5);
			PlayerTextDrawSetProportional(playerid, TD_SelectPlayer[playerid][td], 0);
			PlayerTextDrawSetShadow(playerid, TD_SelectPlayer[playerid][td], 0);
			PlayerTextDrawSetSelectable(playerid, TD_SelectPlayer[playerid][td], false);
			PlayerTextDrawSetPreviewModel(playerid, TD_SelectPlayer[playerid][td], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_SelectPlayer[playerid][td], 0.0000, 0.0000, 0.0000, 1000.0000);
			td++;

			// Кликабельный фон группа
			TD_SelectPlayer[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 1.0, initialcoords[1] + 1.0, "");
			PlayerTextDrawTextSize(playerid, TD_SelectPlayer[playerid][td], 64.0000, 48.0000);
			PlayerTextDrawAlignment(playerid, TD_SelectPlayer[playerid][td], 1);
			PlayerTextDrawColor(playerid, TD_SelectPlayer[playerid][td], -1);
			PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][td], 303174399);
			PlayerTextDrawFont(playerid, TD_SelectPlayer[playerid][td], 5);
			PlayerTextDrawSetProportional(playerid, TD_SelectPlayer[playerid][td], 0);
			PlayerTextDrawSetShadow(playerid, TD_SelectPlayer[playerid][td], 0);
			PlayerTextDrawSetSelectable(playerid, TD_SelectPlayer[playerid][td], true);
			PlayerTextDrawSetPreviewModel(playerid, TD_SelectPlayer[playerid][td], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_SelectPlayer[playerid][td], 0.0000, 0.0000, 0.0000, 1000.0000);
			td++;

			// По умолчанию
			TD_SelectPlayer[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 33.0, initialcoords[1] + 16.0, "На_базе");
			PlayerTextDrawLetterSize(playerid, TD_SelectPlayer[playerid][td], 0.1853, 1.5460);
			PlayerTextDrawAlignment(playerid, TD_SelectPlayer[playerid][td], 2);
			PlayerTextDrawColor(playerid, TD_SelectPlayer[playerid][td], -606348801);
			PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][td], 255);
			PlayerTextDrawFont(playerid, TD_SelectPlayer[playerid][td], 2);
			PlayerTextDrawSetProportional(playerid, TD_SelectPlayer[playerid][td], 1);
			PlayerTextDrawSetShadow(playerid, TD_SelectPlayer[playerid][td], 0);
			break;
		}

		// Белый фон группа
		TD_SelectPlayer[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0], initialcoords[1], "");
		PlayerTextDrawTextSize(playerid, TD_SelectPlayer[playerid][td], 66.0000, 50.0000);
		PlayerTextDrawAlignment(playerid, TD_SelectPlayer[playerid][td], 1);
		PlayerTextDrawColor(playerid, TD_SelectPlayer[playerid][td], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][td], -1717986817);
		PlayerTextDrawFont(playerid, TD_SelectPlayer[playerid][td], 5);
		PlayerTextDrawSetProportional(playerid, TD_SelectPlayer[playerid][td], 0);
		PlayerTextDrawSetShadow(playerid, TD_SelectPlayer[playerid][td], 0);
		PlayerTextDrawSetSelectable(playerid, TD_SelectPlayer[playerid][td], false);
		PlayerTextDrawSetPreviewModel(playerid, TD_SelectPlayer[playerid][td], 0);
		PlayerTextDrawSetPreviewRot(playerid, TD_SelectPlayer[playerid][td], 0.0000, 0.0000, 0.0000, 1000.0000);
		td++;

		// Кликабельный фон группа
		TD_SelectPlayer[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 1.0, initialcoords[1] + 1.0, "");
		PlayerTextDrawTextSize(playerid, TD_SelectPlayer[playerid][td], 64.0000, 48.0000);
		PlayerTextDrawAlignment(playerid, TD_SelectPlayer[playerid][td], 1);
		PlayerTextDrawColor(playerid, TD_SelectPlayer[playerid][td], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][td], 303174399);
		PlayerTextDrawFont(playerid, TD_SelectPlayer[playerid][td], 5);
		PlayerTextDrawSetProportional(playerid, TD_SelectPlayer[playerid][td], 0);
		PlayerTextDrawSetShadow(playerid, TD_SelectPlayer[playerid][td], 0);
		PlayerTextDrawSetSelectable(playerid, TD_SelectPlayer[playerid][td], true);
		PlayerTextDrawSetPreviewModel(playerid, TD_SelectPlayer[playerid][td], 0);
		PlayerTextDrawSetPreviewRot(playerid, TD_SelectPlayer[playerid][td], 0.0000, 0.0000, 0.0000, 1000.0000);
		td++;

		// Ник
		TD_SelectPlayer[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 33.0, initialcoords[1] + 26.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_SelectPlayer[playerid][td], 0.1509, 2.3798);
		PlayerTextDrawTextSize(playerid, TD_SelectPlayer[playerid][td], 0.0000, 203.0000);
		PlayerTextDrawAlignment(playerid, TD_SelectPlayer[playerid][td], 2);
		PlayerTextDrawColor(playerid, TD_SelectPlayer[playerid][td], -842150913);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][td], 255);
		PlayerTextDrawFont(playerid, TD_SelectPlayer[playerid][td], 1);
		PlayerTextDrawSetProportional(playerid, TD_SelectPlayer[playerid][td], 1);
		PlayerTextDrawSetShadow(playerid, TD_SelectPlayer[playerid][td], 0);
		td++;

		// Полоска
		TD_SelectPlayer[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 1.0, initialcoords[1] + 25.0, "");
		PlayerTextDrawTextSize(playerid, TD_SelectPlayer[playerid][td], 65.0000, 1.0000);
		PlayerTextDrawAlignment(playerid, TD_SelectPlayer[playerid][td], 1);
		PlayerTextDrawColor(playerid, TD_SelectPlayer[playerid][td], -1);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][td], -1717986817);
		PlayerTextDrawFont(playerid, TD_SelectPlayer[playerid][td], 5);
		PlayerTextDrawSetProportional(playerid, TD_SelectPlayer[playerid][td], 0);
		PlayerTextDrawSetShadow(playerid, TD_SelectPlayer[playerid][td], 0);
		PlayerTextDrawSetPreviewModel(playerid, TD_SelectPlayer[playerid][td], 0);
		PlayerTextDrawSetPreviewRot(playerid, TD_SelectPlayer[playerid][td], 0.0000, 0.0000, 0.0000, 1000.0000);
		td++;

		// Класс персонажа
		TD_SelectPlayer[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 33.0, initialcoords[1], "_");
		PlayerTextDrawLetterSize(playerid, TD_SelectPlayer[playerid][td], 0.1854, 1.5460);
		PlayerTextDrawAlignment(playerid, TD_SelectPlayer[playerid][td], 2);
		PlayerTextDrawColor(playerid, TD_SelectPlayer[playerid][td], -842150913);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][td], 255);
		PlayerTextDrawFont(playerid, TD_SelectPlayer[playerid][td], 2);
		PlayerTextDrawSetProportional(playerid, TD_SelectPlayer[playerid][td], 1);
		PlayerTextDrawSetShadow(playerid, TD_SelectPlayer[playerid][td], 0);
		td++;

		// Статус
		TD_SelectPlayer[playerid][td] = CreatePlayerTextDraw(playerid, initialcoords[0] + 33.0, initialcoords[1] + 11.0, "_");
		PlayerTextDrawLetterSize(playerid, TD_SelectPlayer[playerid][td], 0.1764, 1.4921);
		PlayerTextDrawAlignment(playerid, TD_SelectPlayer[playerid][td], 2);
		PlayerTextDrawColor(playerid, TD_SelectPlayer[playerid][td], -842150913);
		PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][td], 255);
		PlayerTextDrawFont(playerid, TD_SelectPlayer[playerid][td], 2);
		PlayerTextDrawSetProportional(playerid, TD_SelectPlayer[playerid][td], 1);
		PlayerTextDrawSetShadow(playerid, TD_SelectPlayer[playerid][td], 0);
		td++;

		initialcoords[0] += 69.0;
	}
	return 1;
}

static CreatePlayerTDSelectTeam(playerid, idtd = -1, oneidtd = -1, idteam)
{
	new
		str[50],
		str2[50];

	f(str, "%s", TDM_GetTeamName(idteam));

	new
		players;

	m_for(MODE_TDM, Mode_GetPlayerSession(playerid), p) {
		if(Adm_GetPlayerSpectating(p))
			continue;

		if(GetPlayerTeamEx(p) != idteam)
			continue;

		players++;
	}
	f(str2, "Людей:_%i", players);

	// Кликабельные
	if(oneidtd != -1) {
		switch(oneidtd) {
			case 0: {
				// Задний белый фон назад
				TD_SelectTeam[playerid][0] = CreatePlayerTextDraw(playerid, 289.0000, 129.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][0], 55.0000, 16.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][0], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][0], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][0], -1717986817);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][0], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][0], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][0], 0);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][0], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][0]);

				// Задний чёрный фон назад
				TD_SelectTeam[playerid][1] = CreatePlayerTextDraw(playerid, 290.0000, 130.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][1], 53.0000, 14.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][1], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][1], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][1], 303174399);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][1], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][1], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][1], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][1], true);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][1], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][1]);

				TD_SelectTeam[playerid][2] = CreatePlayerTextDraw(playerid, 317.0000, 130.0000, "Назад");
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][2], 0.2630, 1.4340);
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][2], 12.0000, 52.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][2], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][2], -330419713);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][2], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][2], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][2], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][2], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][2], true);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][2]);

				// Задний фон цвета команд
				TD_SelectTeam[playerid][3] = CreatePlayerTextDraw(playerid, 318.0000, 150.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][3], 90.0000, 90.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][3], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][3], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][3], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][3], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][3], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][3], 0);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][3], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][3]);

				// Задний чёрный фон
				TD_SelectTeam[playerid][4] = CreatePlayerTextDraw(playerid, 319.0000, 151.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][4], 88.0000, 88.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][4], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][4], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][4], 303174399);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][4], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][4], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][4], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][4], true);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][4], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][4], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][4]);

				// Название команды
				TD_SelectTeam[playerid][5] = CreatePlayerTextDraw(playerid, 363.0000, 176.0000, str);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][5], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][5], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][5], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][5], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][5], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][5], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][5], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][5]);

				// Кол-во людей в команде
				TD_SelectTeam[playerid][6] = CreatePlayerTextDraw(playerid, 363.0000, 194.0000, str2);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][6], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][6], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][6], -505290753);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][6], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][6], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][6], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][6], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][6]);

			}
			case 2: {
				// Задний фон цвета команд
				TD_SelectTeam[playerid][11] = CreatePlayerTextDraw(playerid, 318.0000, 245.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][11], 90.0000, 90.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][11], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][11], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][11], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][11], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][11], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][11], 0);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][11], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][11], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][11]);

				// Задний чёрный фон
				TD_SelectTeam[playerid][12] = CreatePlayerTextDraw(playerid, 319.0000, 246.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][12], 88.0000, 88.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][12], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][12], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][12], 303174399);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][12], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][12], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][12], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][12], true);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][12], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][12], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][12]);

				// Название команды
				TD_SelectTeam[playerid][13] = CreatePlayerTextDraw(playerid, 363.0000, 271.0000, str);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][13], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][13], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][13], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][13], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][13], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][13], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][13], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][13]);

				// Кол-во людей в команде
				TD_SelectTeam[playerid][14] = CreatePlayerTextDraw(playerid, 363.0000, 289.0000, str2);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][14], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][14], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][14], -505290753);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][14], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][14], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][14], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][14], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][14]);
			}
		}
	}

	if(idtd != -1) {
		switch(idtd) {
			case 0: {
				// Задний белый фон назад
				TD_SelectTeam[playerid][0] = CreatePlayerTextDraw(playerid, 289.0000, 129.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][0], 55.0000, 16.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][0], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][0], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][0], -1717986817);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][0], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][0], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][0], 0);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][0], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][0]);

				// Задний чёрный фон назад
				TD_SelectTeam[playerid][1] = CreatePlayerTextDraw(playerid, 290.0000, 130.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][1], 53.0000, 14.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][1], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][1], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][1], 303174399);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][1], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][1], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][1], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][1], true);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][1], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][1]);

				TD_SelectTeam[playerid][2] = CreatePlayerTextDraw(playerid, 317.0000, 130.0000, "Назад");
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][2], 0.2630, 1.4340);
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][2], 12.0000, 52.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][2], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][2], -330419713);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][2], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][2], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][2], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][2], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][2], true);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][2]);

				// Задний фон цвета команд
				TD_SelectTeam[playerid][3] = CreatePlayerTextDraw(playerid, 223.0000, 150.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][3], 90.0000, 90.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][3], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][3], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][3], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][3], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][3], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][3], 0);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][3], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][3]);

				// Задний чёрный фон
				TD_SelectTeam[playerid][4] = CreatePlayerTextDraw(playerid, 224.0000, 151.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][4], 88.0000, 88.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][4], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][4], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][4], 303174399);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][4], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][4], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][4], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][4], true);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][4], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][4], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][4]);

				// Название команды
				TD_SelectTeam[playerid][5] = CreatePlayerTextDraw(playerid, 268.0000, 176.0000, str);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][5], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][5], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][5], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][5], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][5], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][5], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][5], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][5]);

				// Кол-во людей в команде
				TD_SelectTeam[playerid][6] = CreatePlayerTextDraw(playerid, 268.0000, 194.0000, str2);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][6], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][6], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][6], -505290753);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][6], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][6], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][6], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][6], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][6]);
			}
			case 1: {
				// Задний фон цвета команд
				TD_SelectTeam[playerid][7] = CreatePlayerTextDraw(playerid, 318.0000, 150.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][7], 90.0000, 90.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][7], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][7], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][7], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][7], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][7], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][7], 0);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][7], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][7], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][7]);
				
				// Задний чёрный фон
				TD_SelectTeam[playerid][8] = CreatePlayerTextDraw(playerid, 319.0000, 151.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][8], 88.0000, 88.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][8], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][8], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][8], 303174399);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][8], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][8], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][8], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][8], true);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][8], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][8], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][8]);

				// Название команды
				TD_SelectTeam[playerid][9] = CreatePlayerTextDraw(playerid, 363.0000, 176.0000, str);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][9], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][9], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][9], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][9], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][9], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][9], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][9], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][9]);

				// Кол-во людей в команде
				TD_SelectTeam[playerid][10] = CreatePlayerTextDraw(playerid, 363.0000, 194.0000, str2);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][10], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][10], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][10], -505290753);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][10], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][10], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][10], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][10], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][10]);
			}
			case 2: {
				// Задний фон цвета команд
				TD_SelectTeam[playerid][11] = CreatePlayerTextDraw(playerid, 223.0000, 245.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][11], 90.0000, 90.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][11], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][11], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][11], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][11], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][11], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][11], 0);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][11], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][11], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][11]);

				// Задний чёрный фон
				TD_SelectTeam[playerid][12] = CreatePlayerTextDraw(playerid, 224.0000, 246.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][12], 88.0000, 88.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][12], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][12], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][12], 303174399);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][12], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][12], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][12], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][12], true);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][12], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][12], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][12]);

				// Название команды
				TD_SelectTeam[playerid][13] = CreatePlayerTextDraw(playerid, 268.0000, 271.0000, str);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][13], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][13], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][13], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][13], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][13], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][13], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][13], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][13]);

				// Кол-во людей в команде
				TD_SelectTeam[playerid][14] = CreatePlayerTextDraw(playerid, 268.0000, 289.0000, str2);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][14], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][14], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][14], -505290753);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][14], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][14], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][14], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][14], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][14]);
			}
			case 3: {
				// Задний фон цвета команд
				TD_SelectTeam[playerid][15] = CreatePlayerTextDraw(playerid, 318.0000, 245.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][15], 90.0000, 90.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][15], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][15], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][15], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][15], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][15], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][15], 0);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][15], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][15], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][15]);
				
				// Задний чёрный фон
				TD_SelectTeam[playerid][16] = CreatePlayerTextDraw(playerid, 319.0000, 246.0000, "");
				PlayerTextDrawTextSize(playerid, TD_SelectTeam[playerid][16], 88.0000, 88.0000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][16], 1);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][16], -1);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][16], 303174399);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][16], 5);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][16], 0);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][16], 0);
				PlayerTextDrawSetSelectable(playerid, TD_SelectTeam[playerid][16], true);
				PlayerTextDrawSetPreviewModel(playerid, TD_SelectTeam[playerid][16], 0);
				PlayerTextDrawSetPreviewRot(playerid, TD_SelectTeam[playerid][16], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][16]);

				// Название команды
				TD_SelectTeam[playerid][17] = CreatePlayerTextDraw(playerid, 363.0000, 271.0000, str);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][17], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][17], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][17], TDM_ShowTeamColorXF(idteam));
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][17], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][17], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][17], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][17], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][17]);

				// Кол-во людей в команде
				TD_SelectTeam[playerid][18] = CreatePlayerTextDraw(playerid, 363.0000, 289.0000, str2);
				PlayerTextDrawLetterSize(playerid, TD_SelectTeam[playerid][18], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, TD_SelectTeam[playerid][18], 2);
				PlayerTextDrawColor(playerid, TD_SelectTeam[playerid][18], -505290753);
				PlayerTextDrawBackgroundColor(playerid, TD_SelectTeam[playerid][18], 255);
				PlayerTextDrawFont(playerid, TD_SelectTeam[playerid][18], 2);
				PlayerTextDrawSetProportional(playerid, TD_SelectTeam[playerid][18], 1);
				PlayerTextDrawSetShadow(playerid, TD_SelectTeam[playerid][18], 0);
				PlayerTextDrawShow(playerid, TD_SelectTeam[playerid][18]);
			}
		}
	}
	return 1;
}

static CreatePlayerTDResultChet(playerid, team_id, bool:td_id, num, teams)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

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
		Float:pos_td[2],
		tdid;

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
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], TDM_ShowTeamColorXB(team_id));
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
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], TDM_ShowTeamColorXB(team_id));
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
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], TDM_ShowTeamColorXB(team_id));
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
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], TDM_ShowTeamColorXB(team_id));
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

	// Название команды
	TD_ResultRound[playerid][num][tdid] = CreatePlayerTextDraw(playerid, pos_td[0] + 98.0, pos_td[1] + 1.0, TDM_GetTeamName(team_id));
	PlayerTextDrawLetterSize(playerid, TD_ResultRound[playerid][num][tdid], 0.2369, 1.4133);
	PlayerTextDrawAlignment(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawColor(playerid, TD_ResultRound[playerid][num][tdid], TDM_ShowTeamColorXF(team_id));
	PlayerTextDrawBackgroundColor(playerid, TD_ResultRound[playerid][num][tdid], 255);
	PlayerTextDrawFont(playerid, TD_ResultRound[playerid][num][tdid], 2);
	PlayerTextDrawSetProportional(playerid, TD_ResultRound[playerid][num][tdid], 1);
	PlayerTextDrawSetShadow(playerid, TD_ResultRound[playerid][num][tdid], 0);
	tdid++;

	n_for(i, sizeof(TD_ResultRound[][]))
		PlayerTextDrawShow(playerid, TD_ResultRound[playerid][num][i]);

	// Статистика
	static
		str[150];

	str[0] = EOS;

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

	n_for(i, 10) {
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

		if(players_Data[session_id][team_id][i][1] > -1) {
			f(str, "%i._%s", i + 1, players_Name[session_id][team_id][players_Data[session_id][team_id][i][1]]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][0], str);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][0]);
			str[0] = EOS;

			f(str, "%i", players_Data[session_id][team_id][i][0]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][1], str);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][1]);
			str[0] = EOS;	

			f(str, "%i", players_Data[session_id][team_id][i][2]);
			PlayerTextDrawSetString(playerid, TD_TopKillers[playerid][num][tdid][2], str);
			PlayerTextDrawShow(playerid, TD_TopKillers[playerid][num][tdid][2]);
			str[0] = EOS;
		}
		tdid++;
	}
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerData(playerid)
{
	ActionPlayerTDSelectTP[playerid] = TD_DESTROYED;
	
	ActiveCellSelectPoint[playerid] = -1;
	ActiveCellSelectPointTD[playerid] = 0;
	ActiveCellSelectPlayerID[playerid] = -1;
	ActiveCellSelectPlayerTD[playerid] = 0;
	TimerChooseFromSpawn[playerid] = 0;
	IncludeSpawnInVehiclePlayer[playerid] = -1;

	PlayerSelectVoteLocation[playerid] = -1;

	PlayerExplosives[playerid] =
	UpdateTimerSelectTP[playerid] =
	TimerSetCameraBase[playerid] =
	ActiveChangeTeamTimer[playerid] = 0;

	ActionPlayerSelectTP{playerid} =
	ActionPlayerTextRound{playerid} =
	ActionPlayerTDNextLocation{playerid} = false;
	return 1;
}

static ResetPlayerTDs(playerid)
{
	TD_TNextLocation[playerid] = PlayerText:INVALID_TEXT_DRAW;

	n_for(tt, TDM_MAX_TEAMS) {
		n_for2(i, sizeof(TD_TopKillers[][])) {
			n_for3(b, sizeof(TD_TopKillers[][][])) {
				TD_TopKillers[playerid][tt][i][b] = PlayerText:INVALID_TEXT_DRAW;
			}
		}
	}

	n_for(i, sizeof(TD_SelectNextLocation[]))
		TD_SelectNextLocation[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_EndRoundStats[]))
		TD_EndRoundStats[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(tt, TDM_MAX_TEAMS) {
		n_for2(i, sizeof(TD_ResultRound[][])) {
			TD_ResultRound[playerid][tt][i] = PlayerText:INVALID_TEXT_DRAW;
		}
	}

	n_for(i, sizeof(TD_ChetLocation[]))
		TD_ChetLocation[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_SelectSpawn[]))
		TD_SelectSpawn[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_SelectPlayer[]))
		TD_SelectPlayer[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_SelectPoint[]))
		TD_SelectPoint[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_TextTeamMatch[]))
		TD_TextTeamMatch[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_SelectTeam[]))
		TD_SelectTeam[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

/*

	* Interfaces *

*/

InterfaceCreate:TDM_SelectTeam(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	new
		td_id,
		teams = Iter_Count(TDM_ActiveTeams[session_id]);

	foreach(new tt:TDM_ActiveTeams[session_id]) {
		if((td_id + 1) <= teams) {
			if(IsCh(td_id + 1))
				CreatePlayerTDSelectTeam(playerid, td_id, -1, tt);
			else {
				if((td_id + 1) == teams) 
					CreatePlayerTDSelectTeam(playerid, -1, td_id, tt);
				else 
					CreatePlayerTDSelectTeam(playerid, td_id, -1, tt);
			}
		}
		td_id++;
	}
	return 1;
}

InterfaceClose:TDM_SelectTeam(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid),
		teams = Iter_Count(TDM_ActiveTeams[session_id]);

	if(!teams)
		return 1;

	DestroyPlayerTD(playerid, TD_SelectTeam[playerid][0]);
	DestroyPlayerTD(playerid, TD_SelectTeam[playerid][1]);
	DestroyPlayerTD(playerid, TD_SelectTeam[playerid][2]);

	for(new k = 0, c = 3; k < TDM_MAX_TEAMS; k++) {
		if(!TDM_CheckTeam(session_id, k)) 
			continue;

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
		session_id = Mode_GetPlayerSession(playerid);

	if(playertextid == TD_SelectTeam[playerid][2]) {
		Interface_Close(playerid, Interface:TDM_SelectTeam);

		Interface_Show(playerid, Interface:TDM_SelectTP);
		TDM_ShowPlayerBaseColor(playerid);
		return 1;
	}

	new
		c = 4;

	foreach(new tt:TDM_ActiveTeams[session_id]) {
		if(tt == TDM_TEAM_NONE)
			continue;

		if(playertextid == TD_SelectTeam[playerid][c]) {
			if(ActiveChangeTeamTimer[playerid] > gettime()) {
				SCM(playerid, -1, "{CC0033}(Команда) {FFFFFF}Вы слишком часто меняете команду.");
				return 1;
			}
			if(GetPlayerTeamEx(playerid) == tt) {
				SCM(playerid, -1, "{CC0033}(Команда) {FFFFFF}Вы уже находитесь в этой команде.");
				return 1;
			}

			new
				teams[TDM_MAX_TEAMS];

			foreach(new i:TDM_ActiveTeams[session_id]) {
				if(i == TDM_TEAM_NONE)
					continue;

				m_for(MODE_TDM, session_id, p) {
					if(GetPlayerTeamEx(p) != i) 
						continue;

					teams[i]++;
				}
			}
			new
				most_teams,
				index = -1;

			foreach(new i:TDM_ActiveTeams[session_id]) {
				if(i == TDM_TEAM_NONE)
					continue;

				if(teams[i] >= most_teams) {
					most_teams = teams[i];
					index = i;
				}
			}
			new
				amount_team;

			foreach(new i:TDM_ActiveTeams[session_id]) {
				if(i == TDM_TEAM_NONE)
					continue;

				if(teams[i] == most_teams)
					amount_team++;
			}		
			if(amount_team > 1)
				index = -1;

			if(index == tt) {
				SCM(playerid, -1, "{CC0033}(Баланс) {FFFFFF}В данной команде достаточно игроков.");
				return 1;
			}
			TDM_LeavePlayerSquad(playerid);

			SetPlayerTeamEx(playerid, tt);
			SetPlayerColorEx(playerid, TDM_ShowTeamColorXB(GetPlayerTeamEx(playerid)));

			// Смена персонажа
			ActiveChangeTeamTimer[playerid] = gettime() + 3 * 60;

			new
				string[100];

			f(string, "{ed9715}(Команда) {FFFFFF}Выбрана команда: %s%s", TDM_ShowTeamColor(tt), TDM_GetTeamName(tt));
			SCM(playerid, -1, string);
			TDM_EnterPlayerRandomSquad(playerid);
			break;
		}
		c += 4;
	}
	TDM_HideSelectedPointTP(playerid);

	if(ActiveCellSelectPlayerID[playerid] != -1
	&& ActiveCellSelectPlayerID[playerid] != -2)
		SpecPl(playerid, true);

	TDM_HideSelectedPlayerTP(playerid);

	Interface_Close(playerid, Interface:TDM_SelectTeam);

	Interface_Show(playerid, Interface:TDM_SelectTP);
	TDM_SetPlayerBaseCamera(playerid, GetPlayerTeamEx(playerid));
	TDM_ShowPlayerBaseColor(playerid);
	return 1;
}

InterfaceClick:TDM_SelectTeam(playerid, Text:clickedid)
{
	// Click escape
	if(_:clickedid == INVALID_TEXT_DRAW) {
		Interface_Close(playerid, Interface:TDM_SelectTeam);

		Interface_Show(playerid, Interface:TDM_SelectTP);
		SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);
		return 1;
	}
	return 1;
}

InterfaceCreate:TDM_SelectTP(playerid)
{
	ActionPlayerTDSelectTP[playerid] = TD_SHOWN;

	n_for(i, sizeof(TD_SelectSpawn[]))
		PlayerTextDrawShow(playerid, TD_SelectSpawn[playerid][i]);

	TDM_ShowTDSelectPlayer(playerid);
	ShowPlayerTDSelectPoint(playerid);

	TDM_UpdatePlayerSquad(playerid);
	return 1;
}

InterfaceClosing:TDM_SelectTP(playerid, bool:hide)
{
	if(ActionPlayerTDSelectTP[playerid] == TD_DESTROYED)
		return 1;

	if(hide) {
		ActionPlayerTDSelectTP[playerid] = TD_HIDDEN;
		
		n_for(i, sizeof(TD_SelectSpawn[]))
			PlayerTextDrawHide(playerid, TD_SelectSpawn[playerid][i]);

		TDM_DestroyTDSelectPlayer(playerid);
		DestroyPlayerTDSelectPoint(playerid);
	}
	else {
		ActionPlayerTDSelectTP[playerid] = TD_DESTROYED;

		n_for(i, sizeof(TD_SelectSpawn[]))
			DestroyPlayerTD(playerid, TD_SelectSpawn[playerid][i]);

		TDM_DestroyTDSelectPlayer(playerid, false);
		DestroyPlayerTDSelectPoint(playerid, false);
	}
	return 1;
}

InterfacePlayerClick:TDM_SelectTP(playerid, PlayerText:playertextid)
{
	if(!ActionPlayerSelectTP{playerid})
		return 1;

	new
		session_id = M_GPS(playerid);

	if(playertextid == TD_SelectSpawn[playerid][2]) {
		if(ActiveCellSelectPlayerID[playerid] == -2) {
			new
				Float:X, Float:Y, Float:Z,
				random_pos = random(3);

			TDM_GetBaseSpawn(session_id, GetPlayerTeamEx(playerid), random_pos, X, Y, Z);
			SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, MODE_TDM), X, Y, Z + 0.3, 0.0);

			HidePlayerSelectSpawn(playerid);
		}
		if(ActiveCellSelectPlayerID[playerid] != -1 
		&& ActiveCellSelectPlayerID[playerid] != -2) {
			new 
				Float:X, Float:Y, Float:Z, Float:Angle;
				
			GetPlayerPos(ActiveCellSelectPlayerID[playerid], X, Y, Z);
			GetPlayerFacingAngle(ActiveCellSelectPlayerID[playerid], Angle);
			
			SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, MODE_TDM), X, Y + 0.5, Z + 0.3, Angle);

			HidePlayerSelectSpawn(playerid);
		}
		if(ActiveCellSelectPoint[playerid] != -1) {
			new 
				Float:X, Float:Y, Float:Z,
				random_pos = random(3),
				point_id = ActiveCellSelectPoint[playerid];

			TDM_LocGetCapturePointSpawn(session_id, point_id, random_pos, X, Y, Z);
			SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, Mode_GetPlayer(playerid)), X, Y, Z + 0.3, 0.0);

			HidePlayerSelectSpawn(playerid);
		}
		return 1;
	}
	else if(playertextid == TD_SelectSpawn[playerid][5]) {
		Interface_Closing(playerid, Interface:TDM_SelectTP, true);
		Interface_Show(playerid, Interface:TDM_SelectClass);

		Dina_CheckPlayerHint(playerid, 10);
		return 1;
	}
	else if(playertextid == TD_SelectSpawn[playerid][8]) {
		SetPVarInt(playerid, "Quest_Mode_Progress_PVar", MODE_TDM);
		Dialog_Show(playerid, Dialog:Quest_ListProgress);

		Dina_CheckPlayerHint(playerid, 12);
		return 1;
	}
	else if(playertextid == TD_SelectSpawn[playerid][11]) {
		Interface_Closing(playerid, Interface:TDM_SelectTP, true);
		Interface_Show(playerid, Interface:TDM_SelectTeam);
		return 1;
	}

	if(playertextid == TD_SelectPlayer[playerid][25]) {
		if(ActiveCellSelectPlayerID[playerid] != -2) {
			if(TimerChooseFromSpawn[playerid] > gettime()) 
				return 1;
			else 
				TimerChooseFromSpawn[playerid] = gettime() + 2;

			SetCameraBehindPlayer(playerid);
			TDM_HideSelectedPointTP(playerid);

			if(ActiveCellSelectPlayerID[playerid] != -1 
			&& ActiveCellSelectPlayerID[playerid] != -2)
				SpecPl(playerid, true);

			TDM_HideSelectedPlayerTP(playerid);

			TDM_SetPlayerBaseCamera(playerid, GetPlayerTeamEx(playerid));
			TDM_ShowPlayerBaseColor(playerid);
		}
		else {
			SetCameraBehindPlayer(playerid);

			new
				Float:X, Float:Y, Float:Z,
				random_pos = random(3);

			TDM_GetBaseSpawn(session_id, GetPlayerTeamEx(playerid), random_pos, X, Y, Z);
			SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, MODE_TDM), X, Y, Z + 0.3, 0.0);

			HidePlayerSelectSpawn(playerid);
		}
		return 1;
	}

	new
		tt = 1;

	n_for(i, 4) {
		if(playertextid == TD_SelectPlayer[playerid][tt]) {
			new
				player_squad = TDM_SqGetPlayerList(playerid, i);

			if(player_squad > -1) {
				if(IsPlayerOnServer(player_squad)
				&& Mode_IsPlayerInPlayer(playerid, player_squad)
				&& !GetPlayerDead(player_squad)
				&& !ActionPlayerSelectTP{player_squad}) {
					if(ActiveCellSelectPlayerID[playerid] != player_squad) {
						if(TimerChooseFromSpawn[playerid] > gettime()) 
							return 1;
						else
							TimerChooseFromSpawn[playerid] = gettime() + 2;

						SetCameraBehindPlayer(playerid);
						TDM_HideSelectedPointTP(playerid);
						TDM_HideSelectedPlayerTP(playerid);

						ActiveCellSelectPlayerID[playerid] = player_squad;
						ActiveCellSelectPlayerTD[playerid] = tt - 1;

						SetPlayerSpectating(playerid, player_squad);
						UpdateSpectatingPlayer(playerid, player_squad);

						PlayerTextDrawBackgroundColor(playerid, TD_SelectPlayer[playerid][ActiveCellSelectPlayerTD[playerid]], 0x3cba40FF);
						PlayerTextDrawShow(playerid, TD_SelectPlayer[playerid][ActiveCellSelectPlayerTD[playerid]]);

						Iter_Add(spec_squad_playerid[player_squad], playerid);
					}
					else {
						if(GetPlayerBeDamage(player_squad)) {
							SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Союзник находится под обстрелом!");
						}
						else {
							if(IsPlayerInAnyVehicle(player_squad)) {
								if(Veh_GetFreeSeat(GetPlayerVehicleID(player_squad)) == -1) {
									SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}В транспорте союзника нету места!");
								}
								else {
									new 
										Float:X, Float:Y, Float:Z, Float:Angle;
										
									GetPlayerPos(player_squad, X, Y, Z);
									GetPlayerFacingAngle(player_squad, Angle);

									IncludeSpawnInVehiclePlayer[playerid] = player_squad;
									SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, Mode_GetPlayer(playerid)), X, Y + 0.5, Z + 0.3, Angle);
									HidePlayerSelectSpawn(playerid);
								}
							}
							else {
								new 
									Float:X, Float:Y, Float:Z, Float:Angle;
									
								GetPlayerPos(player_squad, X, Y, Z);
								GetPlayerFacingAngle(player_squad, Angle);

								SetSpawnInfoEx(playerid, Mode_GetPlayerSkin(playerid, Mode_GetPlayer(playerid)), X, Y + 0.5, Z + 0.3, Angle);
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
	foreach(new g:TDM_CapturePointCount[session_id]) {
		if(playertextid == TD_SelectPoint[playerid][tt]) {
			if(TDM_GetPointTeam(session_id, g) != GetPlayerTeamEx(playerid)) {
				SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Точка не принадлежит вашей команде!");
			}
			else {
				if(ActiveCellSelectPoint[playerid] != g) {
					if(TimerChooseFromSpawn[playerid] > gettime()) 
						return 1;
					else 
						TimerChooseFromSpawn[playerid] = gettime() + 2;

					SetCameraBehindPlayer(playerid);
					TDM_HideSelectedPointTP(playerid);

					if(ActiveCellSelectPlayerID[playerid] != -1 
					&& ActiveCellSelectPlayerID[playerid] != -2)
						SpecPl(playerid, true);
						
					TDM_HideSelectedPlayerTP(playerid);
					TDM_SetPlayerPointCamera(playerid, g);

					ActiveCellSelectPoint[playerid] = g;
					ActiveCellSelectPointTD[playerid] = tt - 1;

					PlayerTextDrawBackgroundColor(playerid, TD_SelectPoint[playerid][tt - 1], 0x3cba40FF);
					PlayerTextDrawShow(playerid, TD_SelectPoint[playerid][tt - 1]);
				}
				else {
					new 
						Float:X, Float:Y, Float:Z,
						random_pos = random(3),
						point_id = ActiveCellSelectPoint[playerid];

					TDM_LocGetCapturePointSpawn(session_id, point_id, random_pos, X, Y, Z);
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

/*

	* Dialogs *

*/

DialogCreate:TDM_SelectPlaySession(playerid)
{
	new
		str[1500];

	str = "Локация\tРежим\tИгроков\n";
	n_for(i, TDM_MAX_GAME_SESSIONS) {
		new
			loc_id = Mode_GetLocation(MODE_TDM, i);

		f(str, "%s\
		"C_N"%i. {FFFFFF}%s\
		\t{d9ae21}%s\
		\t{CCCCCC}%i/%i\n", str, i + 1, TDM_GetNameLocation(loc_id), TDM_GetModeName(TDM_GetModeLocation(loc_id)), Adm_GetPlayersNotAdminsMode(MODE_TDM, i), TDM_MAX_PLAYERS);
	}
	Dialog_Open(playerid, Dialog:TDM_SelectPlaySession, DSTH, "Сессии", str, "Войти", "Выйти");
	return 1;
}

DialogResponse:TDM_SelectPlaySession(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	n_for(i, TDM_MAX_GAME_SESSIONS) {
		if(listitem == i) {
			if(Adm_GetPlayersNotAdminsMode(MODE_TDM, i) >= TDM_MAX_PLAYERS) {
				Dialog_Show(playerid, Dialog:TDM_SelectPlaySession);
				SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данная сессия уже заполнена.");
				return 1;
			}
			Mode_DestroyLocationPlayer(playerid);
			Mode_CreateLocationPlayer(playerid, MODE_TDM, i);
			break;
		}
	}
	return 1;
}

DialogCreate:TDM_SelectSession(playerid)
{
	new
		string[1000];

	string[0] = EOS;
	n_for(i, TDM_MAX_GAME_SESSIONS) {
		new 
			str[200];

		f(str, ""C_N"%i. {FFFFFF}Сессия [%i]\n", i + 1, i);
		strcat(string, str);
	}
	Dialog_Open(playerid, Dialog:TDM_SelectSession, DSL, "Список сессий (Режим: TDM)", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:TDM_SelectSession(playerid, response, listitem, inputtext[])
{
	if(response) {
		SetPVarInt(playerid, "SessionMode_PVar", listitem);
		Dialog_Show(playerid, Dialog:TDM_SelectLocation);
	}
	else 
		Dialog_Show(playerid, Dialog:Adm_SelectMode);

	return 1;
}

DialogCreate:TDM_SelectLocation(playerid)
{
	new
		string[1000];

	string[0] = EOS;
	strcat(string, "Название\tРежим\n");

	n_for(i, TDM_MAX_LOCATIONS) {
		new
			str[150];

		f(str, ""C_N"%i. {FFFFFF}%s\t{E09B0B}%s\n", i + 1, TDM_GetNameLocation(i), TDM_GetModeName(TDM_GetModeLocation(i)));
		strcat(string, str);
	}
	Dialog_Open(playerid, Dialog:TDM_SelectLocation, DSTH, "Список локаций (Режим: TDM)", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:TDM_SelectLocation(playerid, response, listitem, inputtext[])
{
	if(response) {
		new 
			session_id = GetPVarInt(playerid, "SessionMode_PVar");
			
		if(tdm_location_game_status[session_id] != TDM_LOC_GAME_STATUS_GAME) 
			return Dialog_Show(playerid, Dialog:TDM_SelectLocation);

		if(Mode_GetLocation(MODE_TDM, session_id) == listitem) 
			return Dialog_Show(playerid, Dialog:TDM_SelectLocation);

		LocationEndGame(session_id, listitem);
	}
	else {
		DeletePVar(playerid, "SessionMode_PVar");
		Dialog_Show(playerid, Dialog:TDM_SelectSession);
	}

	return 1;
}

stock ShowPlayerInfoLocation(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	if(tdm_location_game_status[session_id] != TDM_LOC_GAME_STATUS_GAME) 
		return 1;

	static 
		string[600];

	string[0] = EOS;

	new
		loc_id = Mode_GetLocation(MODE_TDM, session_id);

	f(string, "{FFFFFF}Локация: {E58315}%s\n{FFFFFF}Режим: {D0740B}%s\n\n{FFFFFF}%s", TDM_GetNameLocation(loc_id), TDM_GetModeName(TDM_GetModeLocation(loc_id)), TDM_GetModeInfo(TDM_GetModeLocation(loc_id)));
	Dialog_Message(playerid, "{FFFF33}Информация о локации", string, "Хорошо");
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock TDM_OnGameModeInit(session_id)
{
	TDM_ClOnGameModeInit(session_id);
	TDM_SqOnGameModeInit(session_id);
	TDM_LocOnGameModeInit(session_id);

	Iter_Init(TDM_ActiveTeams);
	Iter_Init(TDM_ActiveTeamsChet);

	tdm_location_game_status[session_id] =
	tdm_location_end_timer[session_id] = 0;
	tdm_next_location[session_id] = -1;

	n_for(i, TDM_MAX_CHANGE_MAP_LIST) {
		change_map_list[session_id][i] =
		select_vote_location[session_id][i] = 0;
	}

	n_for(i, TDM_MAX_LOCATIONS)
		not_selected_maps[session_id][i] = 0;

	n_for(i, TDM_MAX_TEAMS)
		text_round_timer[session_id][i] = 0;

	ResetTopPlayers(session_id);
	ResetTopBots(session_id);
	return 1;
}

/*
	OnPlayerConnect
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
	OnPlayerSpawn
*/

stock TDM_OnPlayerSpawn(playerid)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 1;

	if(Adm_GetPlayerSpectating(playerid))
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

	new
		session_id = Mode_GetPlayerSession(playerid);

	if(!ActionPlayerSelectTP{playerid}) {
		ResetPlayerMoney(playerid);
		GivePlayerMoney(playerid, pInfo[playerid][pCredit]);

		TDM_SetPlayerBagMoney(playerid, false);
		DestroyPlayerBaseIndicators(playerid, false);
		Mode_DestroyPlayerMatchPoints(playerid);
		DestroyPlayerFPSandPING(playerid);
		DestroyPlayerStatsRound(playerid);

		DestroyPlTDTextTeamMatch(playerid, GetPlayerTeamEx(playerid));
	}
	else {
		ResetPlayerWeaponsEx(playerid);
		SetPlayerAmmunition(playerid);

		CreatePlayerBaseIndicators(playerid);
		Mode_CreatePlayerMatchPoints(playerid);
		CreatePlayerFPSandPING(playerid);
		CreatePlayerStatsRound(playerid);

		SetPlayerZone(playerid, true);

		if(IncludeSpawnInVehiclePlayer[playerid] > -1) {
			SetPlayerDamage(playerid, true);

			new 
				player_squad = IncludeSpawnInVehiclePlayer[playerid];

			IncludeSpawnInVehiclePlayer[playerid] = -1;
			PutPlayerInVehicle(playerid, GetPlayerVehicleID(player_squad), Veh_GetFreeSeat(GetPlayerVehicleID(player_squad)));
		}
		else 
			if(tdm_location_game_status[session_id] == TDM_LOC_GAME_STATUS_GAME)
				SetPlayerSpawnKill(playerid);

		TDM_CreateElementEnterArea(playerid);

		// Dina
		Dina_CheckPlayerHint(playerid, 8);
	}
	if(tdm_location_game_status[session_id] != TDM_LOC_GAME_STATUS_GAME) {
		SpecPl(playerid, true);

		switch(tdm_location_game_status[session_id]) {
			case TDM_LOC_GAME_STATUS_RESULT: {
				ShowPlayerResultRound(playerid);
				TDM_ShowCameraEndLocation(playerid, 0);
			}
			case TDM_LOC_GAME_STATUS_TOP_KILLS: {
				HidePlayerResultRound(playerid);
				TDM_ShowCameraEndLocationTwo(playerid, 0);
			}
			case TDM_LOC_GAME_STATUS_SELECT: {
				TDM_ShowCameraEndLocationThree(playerid, 0);
				CreateTDPlayerNextLocation(playerid);
				SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);
			}
		}
		HidePlayerExitZone(playerid);

		Mode_SetPlayerMatchPoint(playerid, 0);
		Mode_SetPlayerKill(playerid, 0);
		Mode_SetPlayerDeath(playerid, 0);
	}
	else {
		if(ActionPlayerSelectTP{playerid})
			ActionPlayerSelectTP{playerid} = false;
		else
			ShowPlayerSelectSpawn(playerid);
	}
	SetPlayerHealth(playerid, 100.0);
	SetPlayerTeamEx(playerid, GetPlayerTeamEx(playerid));
	return 1;
}

/*
	OnPlayerDeath
*/

stock TDM_OnPlayerDeath(playerid, &killerid, &reason)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	if(GetPlayerBusy(playerid) == GAME) {
		CheckSpectatingPlayers(playerid, killerid);

		if(killerid != INVALID_PLAYER_ID) {
			Iter_Add(spec_dead_playerid[killerid], playerid);

			if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE)
				TDM_GiveTeamChet(session_id, GetPlayerTeamEx(killerid), 1);
		}

		Damage_CheckPlayerBody(playerid);

		SetPlayerInvisible(playerid, false);
		SetPlayerDamage(playerid, false);
		DropW_CreatePlayerWeapon(playerid);

		Mode_SetPlayerDeath(playerid, 1);

		m_for(MODE_TDM, session_id, p) 
			SendDeathMessageToPlayer(p, killerid, playerid, reason);

		DestroyPlayerBelowHealth(playerid);

		if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_BATTLE_KILLS) {
			if(TDM_GetTeamChet(session_id, GetPlayerTeamEx(killerid)) < TDM_GetTeamMaxChet(session_id, GetPlayerTeamEx(killerid)))
				TDM_GiveTeamChet(session_id, GetPlayerTeamEx(killerid), 1);
		}

		// Quests
		if(killerid != INVALID_PLAYER_ID) {
			Quest_CheckPlayerProgress(killerid, MODE_TDM, session_id);
			if(GetPlayerCustomClass(killerid) == TDM_C_ASSAULT) {
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 2);
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 13);
			}
			if(GetPlayerCustomClass(killerid) == TDM_C_MEDIC) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 3);

			if(GetPlayerCustomClass(killerid) == TDM_C_ENGINEER) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 4);

			if(GetPlayerCustomClass(killerid) == TDM_C_RECON) {
				if(GetPlayerWeapon(killerid) == 34) {
					Quest_CheckPlayerProgress(killerid, MODE_TDM, 5);
					Quest_CheckPlayerProgress(killerid, MODE_TDM, 15);
					Quest_CheckPlayerProgress(killerid, MODE_TDM, 25);
				}
			}
			if(GetPlayerWeapon(killerid) == 4) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 8);
			if(GetPlayerColdWeapon(killerid, 4)) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 9);

			Quest_CheckPlayerProgress(killerid, MODE_TDM, 11);

			if(GetPlayerWeapon(killerid) == 8) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 17);

			if(GetPlayerColdWeapon(killerid, 8)) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 18);

			if(IsPlayerAirVehicle(killerid)) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 22);

			if(GetPlayerVehicleID(killerid) == 432) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 23);

			if(GetPlayerWeapon(killerid) == 24) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 27);

			if(GetPlayerWeapon(killerid) == 35) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 28);

			if(GetPlayerVehicleID(killerid) == 432) 
				Quest_CheckPlayerProgress(killerid, MODE_TDM, 30);
		}
		Quest_SetPlayerProgress(playerid, MODE_TDM, 10, 0);
		Quest_SetPlayerProgress(playerid, MODE_TDM, 11, 0);

		// Show death player
		ShowDeadKiller(playerid, killerid);

		TDM_LocOnPlayerDeath(playerid, killerid, reason);
	}
	if(killerid != INVALID_PLAYER_ID) 
		SetPlayerSpeedRespawn(playerid, gettime() + TDM_PLAYER_TIMER_RESPAWN, false);
	else 
		SetPlayerSpeedRespawn(playerid, gettime() + MAX_PLAYER_TIMER_RESPAWN, false);

	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
	OnPlayerKeyStateChange
*/

stock TDM_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(GetPlayerDead(playerid))
		return 0;

	if(TDM_ClOnPlayerKeyStateChange(playerid, newkeys, oldkeys))
		return 1;

	if(TDM_LocOnPlayerKeyStateChange(playerid, newkeys, oldkeys))
		return 1;

	// Anti +C
	if(newkeys == 65410 
	|| newkeys == 130) {
		DeaglePlayerAntiC(playerid);
		return 1;
	}

	// H
	if(newkeys & KEY_CTRL_BACK) {
		// Способности классов
		if(GetPlayerAntiKeys(playerid) == KEY_CTRL_BACK) {
			if(!ActionPlayerSelectTP{playerid} 
			&& !IsPlayerInAnyVehicle(playerid)) {
				Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
				return 1;
			}
		}
		else {
			SetPlayerAntiKeys(playerid, -1);
			return 1;
		}
	}
	return 0;
}

/*
	OnPlayerClickPlayerTextDraw
*/

stock TDM_OnPlayerClickPTextDraw(playerid, PlayerText:playertextid)
{
	if(Mode_GetPlayer(playerid) != MODE_TDM)
		return 1;

	new
		session_id = Mode_GetPlayerSession(playerid);

	if(tdm_location_game_status[session_id] == TDM_LOC_GAME_STATUS_SELECT) {
		if(tdm_location_end_timer[session_id] > 0) {
			for(new i = 3, cell = 0; cell < TDM_MAX_CHANGE_MAP_LIST; i += 4, cell++) {
				if(playertextid == TD_SelectNextLocation[playerid][i]) {
					if(PlayerSelectVoteLocation[playerid] > -1) 
						select_vote_location[session_id][PlayerSelectVoteLocation[playerid]]--;

					PlayerSelectVoteLocation[playerid] = -1;

					select_vote_location[session_id][cell]++;
					PlayerSelectVoteLocation[playerid] = cell;

					UpdatePlTDCellsVoiceLocation(playerid);
					return 1;
				}
			}
		}
	}
	return 1;
}

/*
	OnPlayerPickUpDynamicPickup
*/

stock TDM_OnPlPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	if(TDM_LocOnPlPickUpDynamicPickup(playerid, pickupid))
		return 1;

	return 0;
}

/*
	OnPlayerEnterDynamicArea
*/

stock TDM_OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	TDM_LocOnPlEnterDynamicArea(playerid, areaid);
	return 0;
}

/*
	OnPlayerLeaveDynamicArea
*/

stock TDM_OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	TDM_LocOnPlLeaveDynamicArea(playerid, areaid);
	return 0;
}

/*
	OnVehicleSpawn
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
	OnPlayerText
*/

stock TDM_OnPlayerText(playerid, text[])
{
	static
		str[200];

	str[0] = EOS;

	// Рация
	if(text[0] == '!') {
		strdel(text, 0, 1);
		
		f(str, "{CC0033}(Рация) {FFCC33}[Р: %i] {FFFF33}%s (ID:%d): {FFFFFF}%s", GetPlayerRank(playerid), NameEx(playerid), playerid, text);
		m_for(M_GP(playerid), M_GPS(playerid), p) {
			if(GetPlayerTeamEx(p) != GetPlayerTeamEx(playerid)) 
				continue;

			SCMEX(p, -1, str, true);
		}
		return 1;
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
