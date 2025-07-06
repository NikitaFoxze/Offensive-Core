/*
 * |>===========================<|
 * |   About: Mode Example main  |
 * |   Author: Foxze             |
 * |>===========================<|
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
 * Stock:
	- Example_CreateSession(sessionid)
	- Example_DestroySession(sessionid)
	- Example_CreateFirstSessions()

	- Example_CreatePlayerLocation(playerid, sessionid)
	- Example_DestroyPlayerLocation(playerid)
	- Example_CreateLocation(sessionid, locationid)
	- Example_DestroyLocation(sessionid)

	- Example_UpdatePlayerData(playerid)
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

#if defined _INC_EXAMPLE_MAIN
	#endinput
#endif
#define _INC_EXAMPLE_MAIN

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

stock Example_CreateSession(sessionid)
{
	Mode_DestroySessionLocation(MODE_EXAMPLE, sessionid);
	Mode_CreateSessionLocation(MODE_EXAMPLE, sessionid, EXAMPLE_LOC_DESERT);
	return 1;
}

stock Example_DestroySession(sessionid)
{
	ResetSessionData(sessionid);
	return 1;
}

stock Example_CreateFirstSessions()
{
	Mode_CreateSession(MODE_EXAMPLE);
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Location create & destroy   |
 * |>-----------------------------<|
 */

// Create a mode for the player
stock Example_CreatePlayerLocation(playerid, sessionid)
{
	#pragma unused sessionid

	CancelSelectTextDraw(playerid);
	SetCameraBehindPlayer(playerid);

	SetPlayerDamage(playerid, true);

	SettingsPlayerSpawn(playerid);

	// Create location elements
	Example_ShowPlayerElementsLoc(playerid);

	if (!GetAdminSpectating(playerid)) {
		// Create all necessary TextDraw's in advance (optional)
		ShowPlayerBaseIndicatorsTD(playerid);
		ShowPlayerNewGraphTD(playerid);
		CreatePlayerAfterDeadTD(playerid);

		TogglePlayerControllable(playerid, true);

		SetPlayerTeamEx(playerid, NO_TEAM);
		SetPlayerSkinEx(playerid, GetPlayerInvSkin(playerid));

		ShowPlayerNewGraphTD(playerid);
		ShowPlayerMatchStatsTD(playerid);

		PlayerSpawn(playerid);
	}
	return 1;
}

// Remove the player's mode
stock Example_DestroyPlayerLocation(playerid)
{
	// Remove location elements
	Example_HidePlayerElementsLoc(playerid);
	return 1;
}

// Create location
stock Example_CreateLocation(sessionid, locationid) 
{
	Example_CreateElementsLoc(sessionid, locationid);
	return 1;
}

// Delete location
stock Example_DestroyLocation(sessionid)
{
	Example_DestroyElementsLoc(sessionid);
	return 1;
}

/*
 * |>----------------------<|
 * |   Timers update data   |
 * |>----------------------<|
 */

// Update player data every second
stock Example_UpdatePlayerData(playerid) 
{
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));

	if (GetPlayerDead(playerid) == PLAYER_DEATH_NONE) {
		if (!GetPlayerLastDamage(playerid)) {
			new 
				Float:hp;

			GetPlayerHealthEx(playerid, hp);

			if (hp < 100.0) {
				SetPlayerHealthEx(playerid, hp + 1);
			}
		}
	}
	else {
		if (GetPlayerDead(playerid) == PLAYER_DEATH_KILLER) {
			UpdateBarTimeRespawn(playerid);
		}
		else {
			UpdatePlayerSpeedRespawn(playerid);
		}

		if (GetPlayerSpeedRespawn(playerid) <= 0) {
			RespawnPlayerDeath(playerid);
		}
	}

	GivePlayerSecondTime(playerid);
	return 1;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

// End of the match
stock ShowLocationEndGame(sessionid, nextlocation = -1) 
{
	Mode_DestroySessionLocation(MODE_EXAMPLE, sessionid);
	Mode_CreateSessionLocation(MODE_EXAMPLE, sessionid, nextlocation);

	m_for(MODE_EXAMPLE, sessionid, p) {
		GameTextForPlayer(p, "~y~Смена локации", 3000, 3);
		if (GetAdminSpectating(p)) {
			continue;
		}

		if (GetPlayerDead(p) == PLAYER_DEATH_NONE) {
			new
				Float:x, Float:y, Float:z;

			Example_GetSpawnPos(sessionid, x, y, z);
			SetPlayerPosEx(p, x, y, z + 0.1, GetPlayerVirtualWorldEx(p), GetPlayerInteriorEx(p));
		}
	}
	return 1;
}

// General timer for updating location/session data
stock Example_UpdateModeData(sessionid)
{
	#pragma unused sessionid

	return 1;
}

// Spawn coordinates
static SettingsPlayerSpawn(playerid)
{
	new 
		Float:X, Float:Y, Float:Z,
		skinid = Mode_GetPlayerSkin(playerid, MODE_EXAMPLE);

	new 
		sessionid = Mode_GetPlayerSession(playerid);

	Mode_SetPlayerVirtualWorld(playerid, MODE_EXAMPLE, sessionid);
	Mode_SetPlayerInterior(playerid, MODE_EXAMPLE, sessionid);

	Example_GetSpawnPos(sessionid, X, Y, Z);
	SetSpawnInfoEx(playerid, skinid, X, Y, Z + 0.1, 0.0);
	return 1;
}

// Respawn after death
static RespawnPlayerDeath(playerid, bool:spawn = true, bool:iter_remove = true)
{
	switch (GetPlayerDead(playerid)) {
		case PLAYER_DEATH_INVALID: {
			RemovePlayerDead(playerid);

			if (spawn) {
				SpecPl(playerid, true);
				SpecPl(playerid, false);
			}
		}
		case PLAYER_DEATH_KILLER: {
			if (iter_remove) {
				if (GetPlayerSpecatingPlayers(GetPlayerSpectating(playerid)) > 0) {
					RemovePlayerSpectatingPlayer(GetPlayerSpectating(playerid), playerid);
				}
			}
			RemovePlayerDead(playerid);

			if (spawn) {
				SpecPl(playerid, false);
			}
		}
	}	
	return 1;
}

// Issuance of weapons
static SetPlayerAmmunition(playerid) 
{
	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerArmourEx(playerid, 30.0);

	SetPlayerSkinEx(playerid, GetPlayerSkinEx(playerid));
	SetPlayerColorEx(playerid, 0xCCCCCCBB);

	SetPlayerAttachInvItem(playerid);

	GivePlayerWeaponEx(playerid, WEAPON_DEAGLE, 100000);
	GivePlayerWeaponEx(playerid, WEAPON_M4, 100000);
	GivePlayerWeaponEx(playerid, WEAPON_SHOTGUN, 100000);
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetSessionData(sessionid)
{
	Example_LocResetSessionData(sessionid);
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

stock Example_OnGameModeInit()
{
	// Reset sessions
	n_for(sessionid, GMS_MAX_SESSIONS) {
		ResetSessionData(sessionid);
	}

	// Initialization
	Example_LocOnGameModeInit();

	Mode_Add(MODE_EXAMPLE, "Example", "Example",
		.enableStatus = true,
		.maxSessions = 1,
		.sessionMaxPlayers = 10,
		.changeEnableStatus = true,
		.changeSession = false,
		.changeSessionLocation = false);

	Mode_SetInfo(MODE_EXAMPLE, "-");

	// Sessions
	Mode_CreateFirstSessions(MODE_EXAMPLE);
	return 1;
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
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
 * |>-----------------<|
 * |   OnPlayerSpawn   |
 * |>-----------------<|
 */

stock Example_OnPlayerSpawn(playerid)
{
	if (GetAdminSpectating(playerid))
		return 1;

	new
		sessionid = Mode_GetPlayerSession(playerid);

	SettingsPlayerSpawn(playerid);
	RespawnPlayerDeath(playerid, false);

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, GetPlayerMoneyEx(playerid));
	ResetPlayerWeaponsEx(playerid);

	SetPlayerTeamEx(playerid, NO_TEAM);

	SetPlayerVirtualWorldEx(playerid, Mode_GetSessionVirtualWorld(MODE_EXAMPLE, sessionid));
	SetPlayerInteriorEx(playerid, Mode_GetSessionInterior(MODE_EXAMPLE, sessionid));

	SetPlayerAmmunition(playerid);
	SetPlayerSpawnKill(playerid);
	return 1;
}

/*
 * |>-----------------<|
 * |   OnPlayerDeath   |
 * |>-----------------<|
 */

stock Example_OnPlayerDeath(playerid, &killerid, &WEAPON:reason)
{
	new 
		sessionid = Mode_GetPlayerSession(playerid);

	CheckSpectatingPlayers(playerid, killerid);

	if (killerid != INVALID_PLAYER_ID) {
		// Reward
		new 
			killStrike = GetPlayerKillStrike(killerid) * 10;

		GivePlayerReward(killerid, 250 + killStrike, 150 + killStrike, REWARD_KILL);

		// Spectate
		AddPlayerSpecatingPlayer(killerid, playerid);

		// Technical
		Mode_GivePlayerMatchKills(killerid, 1);
	}

	CheckPlayerDamageBody(playerid);

	SetPlayerDamage(playerid, false);
	Mode_GivePlayerMatchDeaths(playerid, 1);

	m_for(MODE_EXAMPLE, sessionid, p)
		SendDeathMessageToPlayer(p, killerid, playerid, reason);

	if (Example_GetTokens(sessionid))
		CreatePlayerDropToken(playerid);

	if (killerid != INVALID_PLAYER_ID) 
		SetPlayerSpeedRespawn(playerid, EXAMPLE_PLAYER_TIMER_RESPAWN);
	else 
		SetPlayerSpeedRespawn(playerid, TIMER_PLAYER_RESPAWN);

	SettingsPlayerSpawn(playerid);
	return 1;
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
#define OnPlayerConnect Example_OnPlayerConnect
#if defined Example_OnPlayerConnect
	forward Example_OnPlayerConnect(playerid);
#endif