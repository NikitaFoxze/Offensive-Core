/*

	About: Example core system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerSpawn(playerid)
		OnPlayerDeath(playerid, &killerid, &reason)
	Stock:
		Example_CreateLocationPlayer(playerid, session_id)
		Example_DestroyLocationPlayer(playerid, reset)
		Example_CreateLocation(location_id, session_id, bool:start_server = false)
		Example_DestroyLocation(session_id)
		Example_LocationEndGame(session_id, nextlocation = -1)
		Example_ChangeLocation(session_id)
		Example_UpdatePlayer(playerid)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_EXAMPLE_CORE_SYSTEM
	#endinput
#endif
#define _INC_EXAMPLE_CORE_SYSTEM

/*

	* Functions *

*/

// Создаём игроку режим
stock Example_CreateLocationPlayer(playerid, session_id)
{
	if(Mode_GetPlayer(playerid) != MODE_EXAMPLE)
		Mode_EnteringPlayer(playerid, MODE_EXAMPLE, session_id);

	Mode_SetPlayerVirtualWorld(playerid, MODE_EXAMPLE, session_id);
	Mode_SetPlayerInterior(playerid, MODE_EXAMPLE, session_id);
	Mode_SetPlayerWeather(playerid, MODE_EXAMPLE, session_id);

	CancelSelectTextDraw(playerid);
	SetCameraBehindPlayer(playerid);

	SetPlayerBusy(playerid, GAME);
	SetPlayerDamage(playerid, true);

	SettingsPlayerSpawn(playerid);

	// Создаём элементы локации
	Example_ShowPlayerElementsLoc(playerid);

	if(!Adm_GetPlayerSpectating(playerid)) {
		// Заранее создаём все необходимые TextDraw's (необязательно)
		ShowPlayerTDBarHealth(playerid);
		ShowPlayerTDBarArmour(playerid);
		ShowTDPlayerFPSandPING(playerid);
		ShowTDPlayerStatsRound(playerid);
		ShowTDDeath(playerid);
		ShowTDDeadKiller(playerid);

		TogglePlayerControllable(playerid, true);

		SetPlayerTeamEx(playerid, NO_TEAM);
		SetPlayerSkinEx(playerid, Inv_GetPlayerSkin(playerid));

		CreatePlayerBaseIndicators(playerid);
		CreatePlayerFPSandPING(playerid);
		CreatePlayerStatsRound(playerid);

		PlayerSpawn(playerid);
	}

	Mode_SetPlayerTimer(playerid, MODE_EXAMPLE);
	return 1;
}

// Удаляем игроку режим
stock Example_DestroyLocationPlayer(playerid, reset)
{
	// Удаляем элементы локации
	Example_HidePlayerElementsLoc(playerid);

	SetPlayerKillStrike(playerid, 0);
	HidePlayerKillStrike(playerid);
	DestroyPlayerSpawnKill(playerid);
	Damage_DeletePlayerIndicator(playerid);
	DestroyPlayerBaseIndicators(playerid, false);
	DestroyPlayerFPSandPING(playerid, false);
	DestroyPlayerStatsRound(playerid, false);
	DestroyPlayerDeadKiller(playerid, 3, false);
	DestroyPlayerReward(playerid);
	Damage_ResetPlayerBody(playerid);
	DropT_DestroyPlayerToken(playerid);
	HidePlayerExitZone(playerid);
	ResetPlayerWeaponsEx(playerid);
	DestroyPlayerAttachedObjects(playerid);

	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerTeamEx(playerid, NONE);
	Mode_SetPlayerKill(playerid, 0);
	Mode_SetPlayerDeath(playerid, 0);

	Mode_SetPlayerExp(playerid, 0);
	Mode_SetPlayerMoney(playerid, 0);

	if(reset)
		Mode_LeavingPlayer(playerid);

	Mode_KillPlayerTimer(playerid, MODE_EXAMPLE);
	return 1;
}

// Создать локацию
stock Example_CreateLocation(location_id, session_id, bool:start_server = false) 
{
	// Удаление предыдущей локации
	if(!start_server) {
		m_for(MODE_EXAMPLE, session_id, p) {
			if(Adm_GetPlayerSpectating(p)) 
				continue;

			Mode_DestroyLocationPlayer(p);
		}
		Mode_DestroyLocation(MODE_EXAMPLE, session_id);
	}

	// Создание локации
	Mode_SetLocation(MODE_EXAMPLE, session_id, location_id);
	Mode_SetMode(MODE_EXAMPLE, session_id, 0);

	Example_CreateElementsLoc(session_id);

	m_for(MODE_EXAMPLE, session_id, p) {
		if(Adm_GetPlayerSpectating(p)) 
			continue;

		Mode_CreateLocationPlayer(p, MODE_EXAMPLE, session_id);
	}
	return 1;
}

// Удалить локацию
stock Example_DestroyLocation(session_id)
{
	Example_DestroyElementsLoc(session_id);
	return 1;
}

// Конец матча
stock Example_LocationEndGame(session_id, nextlocation = -1) 
{
	Mode_CreateLocation(MODE_EXAMPLE, session_id, nextlocation);

	m_for(MODE_EXAMPLE, session_id, p) {
		GameTextForPlayer(p, "~y~Смена локации", 3000, 3);
		if(Adm_GetPlayerSpectating(p)) 
			continue;

		if(GetPlayerDead(p)) {
			new
				Float:x, Float:y, Float:z;

			Example_GetSpawnPos(session_id, x, y, z);
			SetPlayerPosEx(p, x, y, z + 0.1, GetPlayerVirtualWorldEx(p), GetPlayerInteriorEx(p));
		}
	}
	return 1;
}

// Смена локации
stock Example_ChangeLocation(session_id) 
{
	Mode_CreateLocation(MODE_EXAMPLE, session_id, EXAMPLE_LOC_DESERT, true);
	return 1;
}

// Обновление данных игрока каждую секунду
publics Example_UpdatePlayer(playerid) 
{
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));
	UpdatePlayerKillStrike(playerid);
	UpdatePlayerNewRank(playerid);
	UpdatePlayerReward(playerid);
	UpdatePlayerSpawnKill(playerid);
	UpdatePlayerExitZone(playerid);
	UpdatePlayerFPSandPING(playerid);

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
	}
	else {
		if(GetPlayerDead(playerid) == PLAYER_DEATH_KILLER) 
			UpdateBarTimeRespawn(playerid);

		if(GetPlayerSpeedRespawn(playerid) < gettime())
			RespawnPlayerDeath(playerid);
	}

	SetPlayerSecondTime(playerid);
	UpdatePlayerTime(playerid);
	return 1;
}

// Общий таймер для обновление ланных локации/сессии
stock Example_UpdateTime(session_id)
{
	#pragma unused session_id

	return 1;
}

// Координаты спавна
static SettingsPlayerSpawn(playerid)
{
	new 
		Float:X, Float:Y, Float:Z,
		skin_id = Mode_GetPlayerSkin(playerid, MODE_EXAMPLE);

	new 
		session_id = Mode_GetPlayerSession(playerid);

	Mode_SetPlayerVirtualWorld(playerid, MODE_EXAMPLE, session_id);
	Mode_SetPlayerInterior(playerid, MODE_EXAMPLE, session_id);

	Example_GetSpawnPos(session_id, X, Y, Z);
	SetSpawnInfoEx(playerid, skin_id, X, Y, Z + 0.1, 0.0);
	return 1;
}

// Респавн после смерти
static RespawnPlayerDeath(playerid, bool:spawn = true, bool:iter_remove = true)
{
	switch(GetPlayerDead(playerid)) {
		case PLAYER_DEATH_INVALID: {
			RemovePlayerDead(playerid);

			if(spawn) {
				SpecPl(playerid, true);
				SpecPl(playerid, false);
			}
		}
		case PLAYER_DEATH_KILLER: {
			if(iter_remove) {
				if(Iter_Count(spec_dead_playerid[GetPlayerSpectating(playerid)]) > 0)
					Iter_Remove(spec_dead_playerid[GetPlayerSpectating(playerid)], playerid);
			}
			RemovePlayerDead(playerid);

			if(spawn)
				SpecPl(playerid, false);
		}
	}	
	return 1;
}

// Выдача оружия
static SetPlayerAmmunition(playerid) 
{
	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerArmourEx(playerid, 30.0);

	SetPlayerSkinEx(playerid, GetPlayerSkinEx(playerid));
	SetPlayerColorEx(playerid, 0xCCCCCCBB);

	Inv_SetPlayerAttachItem(playerid);

	GivePlayerWeaponEx(playerid, 24, 100000);
	GivePlayerWeaponEx(playerid, 31, 100000);
	GivePlayerWeaponEx(playerid, 25, 100000);
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock Example_OnGameModeInit(session_id)
{
	Example_LocOnGameModeInit(session_id);
	return 1;
}

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{

	#if defined Example_OnPlayerConnect
		return Example_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerSpawn
*/

stock Example_OnPlayerSpawn(playerid)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 1;

	if(Adm_GetPlayerSpectating(playerid))
		return 1;

	new
		session_id = Mode_GetPlayerSession(playerid);

	SettingsPlayerSpawn(playerid);
	RespawnPlayerDeath(playerid, false);

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, pInfo[playerid][pCredit]);
	ResetPlayerWeaponsEx(playerid);

	SetPlayerTeamEx(playerid, NO_TEAM);

	SetPlayerVirtualWorldEx(playerid, Mode_GetVirtualWorld(MODE_EXAMPLE, session_id));
	SetPlayerInteriorEx(playerid, Mode_GetInterior(MODE_EXAMPLE, session_id));

	SetPlayerAmmunition(playerid);
	SetPlayerSpawnKill(playerid);
	return 1;
}

/*
	OnPlayerDeath
*/

stock Example_OnPlayerDeath(playerid, &killerid, &reason)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 1;

	new 
		session_id = Mode_GetPlayerSession(playerid);

	CheckSpectatingPlayers(playerid, killerid);

	if(killerid != INVALID_PLAYER_ID)
		Iter_Add(spec_dead_playerid[killerid], playerid);

	Damage_CheckPlayerBody(playerid);

	SetPlayerDamage(playerid, false);
	Mode_SetPlayerDeath(playerid, 1);

	m_for(MODE_EXAMPLE, session_id, p)
		SendDeathMessageToPlayer(p, killerid, playerid, reason);

	if(Example_GetTokens(session_id))
		DropT_CreatePlayerToken(playerid);

	ShowDeadKiller(playerid, killerid);

	if(killerid != INVALID_PLAYER_ID) 
		SetPlayerSpeedRespawn(playerid, gettime() + EXAMPLE_PLAYER_TIMER_RESPAWN, false);
	else 
		SetPlayerSpeedRespawn(playerid, gettime() + MAX_PLAYER_TIMER_RESPAWN, false);

	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
	ALS
*/

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Example_OnPlayerConnect
#if defined Example_OnPlayerConnect
	forward Example_OnPlayerConnect(playerid);
#endif