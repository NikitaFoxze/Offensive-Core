/*
 * |>==========================<|
 * |   About: Mini-games main   |
 * |   Author: Foxze            |
 * |>==========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)
	- OnPlayerDisconnect(playerid, reason)

	# Technical #
	- CallUpdatePlayerMiniGame(playerid)
 * Stock:
	- SetPlayerMGSettings(playerid, num)
	- SetPlayerMGNum(playerid, num)
	- GetPlayerMGNum(playerid)
	- SetPlayerMGCount(playerid, num)
	- GetPlayerMGCount(playerid)
	- SetPlayerMGValue(playerid, num)
	- GetPlayerMGValue(playerid)
	- SetPlayerMGTimer(playerid, num)
	- GetPlayerMGTimer(playerid)
	- SetPlayerMGTime(playerid, num)
	- GetPlayerMGTime(playerid)
	- ResetPlayerMGData(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_MINIGAME_INFO
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

#if defined _INC_MINI_GAMES_MAIN
	#endinput
#endif
#define _INC_MINI_GAMES_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_MINIGAME_INFO {
	e_Num,
	e_Count,
	e_Value,
	e_Timer,
	e_pTimer,
	e_Time
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_MINIGAME_INFO];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock SetPlayerMGSettings(playerid, num)
{
	new
		timer,
		count,
		value,
		ptime;

	Mode_SetPlayerMG(playerid, num, timer, count, value, ptime);

	pInfo[playerid][e_Num] = num;
	pInfo[playerid][e_Count] = count;
	pInfo[playerid][e_Value] = value;
	pInfo[playerid][e_Timer] = timer;
	pInfo[playerid][e_Time] = ptime;

	pInfo[playerid][e_pTimer] = SetPlayerTimer(playerid, "CallUpdatePlayerMiniGame", ptime, false);
	return 1;
}

stock SetPlayerMGNum(playerid, num)
{
	pInfo[playerid][e_Num] = num;
	return 1;
}

stock GetPlayerMGNum(playerid)
{
	return pInfo[playerid][e_Num];
}

stock SetPlayerMGCount(playerid, num)
{
	pInfo[playerid][e_Count] = num;
	return 1;
}

stock GetPlayerMGCount(playerid)
{
	return pInfo[playerid][e_Count];
}

stock SetPlayerMGValue(playerid, num)
{
	pInfo[playerid][e_Value] = num;
	return 1;
}

stock GetPlayerMGValue(playerid)
{
	return pInfo[playerid][e_Value];
}

stock SetPlayerMGTimer(playerid, num)
{
	pInfo[playerid][e_Timer] = num;
	return 1;
}

stock GetPlayerMGTimer(playerid)
{
	return pInfo[playerid][e_Timer];
}

stock SetPlayerMGTime(playerid, num)
{
	pInfo[playerid][e_Time] = num;
	return 1;
}

stock GetPlayerMGTime(playerid)
{
	return pInfo[playerid][e_Time];
}

public: CallUpdatePlayerMiniGame(playerid)
{
	Mode_UpdatePlayerMG(playerid);

	pInfo[playerid][e_pTimer] = SetPlayerTimer(playerid, "CallUpdatePlayerMiniGame", pInfo[playerid][e_Time], false);
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

stock ResetPlayerMGData(playerid)
{
	if (pInfo[playerid][e_Num] == 0) {
		return 1;
	}

	Mode_ResetPlayerMG(playerid);

	pInfo[playerid][e_Num] =
	pInfo[playerid][e_Count] =
	pInfo[playerid][e_Value] =
	pInfo[playerid][e_Timer] =
	pInfo[playerid][e_Time] = 0;

	KillTimer(pInfo[playerid][e_pTimer]);
	return 1;
}

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerMGData(playerid);

	#if defined MG_OnPlayerConnect
		return MG_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>----------------------<|
 * |   OnPlayerDisconnect   |
 * |>----------------------<|
 */

public OnPlayerDisconnect(playerid, reason)
{
	ResetPlayerMGData(playerid);

	#if defined MG_OnPlayerDisconnect
		return MG_OnPlayerDisconnect(playerid, reason);
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
#define OnPlayerConnect MG_OnPlayerConnect
#if defined MG_OnPlayerConnect
	forward MG_OnPlayerConnect(playerid);
#endif


#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect MG_OnPlayerDisconnect
#if defined MG_OnPlayerDisconnect
	forward MG_OnPlayerDisconnect(playerid, reason);
#endif