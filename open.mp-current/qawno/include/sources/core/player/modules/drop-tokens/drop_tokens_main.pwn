/*
 * |>===========================<|
 * |   About: Drop-tokens main   |
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
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
 * Stock:
	- CreatePlayerDropToken(playerid)
	- DestroyPlayerDropToken(slotid, id = -1)
	- UpdatePlayerDropTokens(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_DROP_TOKEN_INFO
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

#if defined _INC_DROP_TOKENS_MAIN
	#endinput
#endif
#define _INC_DROP_TOKENS_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_DROP_TOKEN_INFO {
	e_Mode,
	e_Session,
	e_PlayerName[MAX_PLAYER_NAME],
	bool:e_Action,
	Text3D:e_3DText,
	e_Pickup,
	e_Timer,
	e_VirtualWorld,
	e_Interior,
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static 
	pInfo[MAX_PLAYERS][DROP_TOKENS_MAX][E_PLAYER_DROP_TOKEN_INFO];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock CreatePlayerDropToken(playerid)
{
	new
		cell = 0;

	if (Iter_Count(TotalDropTokens[playerid]) < DROP_TOKENS_MAX) {
		n_for2(id, DROP_TOKENS_MAX) {
			if (pInfo[playerid][id][e_Action]) {
				continue;
			}

			cell = id;
			break;
		}
	}
	else {
		new
			leastTime = 0,
			index;

		foreach (new id:TotalDropTokens[playerid]) {
			if (pInfo[playerid][id][e_Timer] >= leastTime) {
				leastTime = pInfo[playerid][id][e_Timer];
				index = id;
			}
		}

		cell = index;
		DestroyPlayerDropToken(playerid, cell);
		Iter_Remove(TotalDropTokens[playerid], cell);
	}

	new
		Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	strcopy(pInfo[playerid][cell][e_PlayerName], GetPlayerNameEx(playerid), MAX_PLAYER_NAME);
	pInfo[playerid][cell][e_Mode] = Mode_GetPlayerMode(playerid);
	pInfo[playerid][cell][e_Session] = Mode_GetPlayerSession(playerid);
	pInfo[playerid][cell][e_Action] = true;
	pInfo[playerid][cell][e_Timer] = DROP_TOKENS_TIMER;
	pInfo[playerid][cell][e_PosX] = x;
	pInfo[playerid][cell][e_PosY] = y;
	pInfo[playerid][cell][e_PosZ] = z;
	pInfo[playerid][cell][e_VirtualWorld] = GetPlayerVirtualWorldEx(playerid);
	pInfo[playerid][cell][e_Interior] = GetPlayerInteriorEx(playerid);
	pInfo[playerid][cell][e_Pickup] = CreateDynamicPickup(1313, 1, x, y, z, pInfo[playerid][cell][e_VirtualWorld], pInfo[playerid][cell][e_Interior]);
	
	CreateDropToken3DText(playerid, cell);

	Iter_Add(TotalDropTokens[playerid], cell);
	return 1;
}

stock DestroyPlayerDropToken(slotid, id = -1)
{
	if (id > -1) {
		DestroyDynamic3DTextLabel(pInfo[slotid][id][e_3DText]);
		DestroyDynamicPickup(pInfo[slotid][id][e_Pickup]);

		ResetDropTokenData(slotid, id);
	}
	else {
		foreach (new d:TotalDropTokens[slotid]) {
			DestroyDynamic3DTextLabel(pInfo[slotid][d][e_3DText]);
			DestroyDynamicPickup(pInfo[slotid][d][e_Pickup]);

			ResetDropTokenData(slotid, d);
		}
		Iter_Clear(TotalDropTokens[slotid]);
	}
	return 1;
}

stock UpdatePlayerDropTokens(playerid)
{
	foreach (new d:TotalDropTokens[playerid]) {
		if (pInfo[playerid][d][e_Timer] > 0) {
			pInfo[playerid][d][e_Timer]--;
			continue;
		}

		DestroyPlayerDropToken(playerid, d);

		new
			cur = d;

		Iter_SafeRemove(TotalDropTokens[playerid], cur, d);
	}
	return 1;
}

static CreateDropToken3DText(slotid, id)
{
	static
		str[65 - 2 + MAX_PLAYER_NAME + 1];

	str[0] = EOS;

	f(str, ""CT_RED"Жетон\n"CT_YELLOW"%s\n\n"CT_WHITE"Нажмите: {ebba1d}[ ALT ]", pInfo[slotid][id][e_PlayerName]);
	pInfo[slotid][id][e_3DText] = CreateDynamic3DTextLabel(str, -1, pInfo[slotid][id][e_PosX], pInfo[slotid][id][e_PosY], pInfo[slotid][id][e_PosZ] + 0.5, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GetPlayerVirtualWorldEx(slotid), GetPlayerInteriorEx(slotid));
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerDropTokenData(playerid)
{
	n_for(i, DROP_TOKENS_MAX) {
		ResetDropTokenData(playerid, i);
	}
	return 1;
}

static ResetDropTokenData(slotid, id)
{
	pInfo[slotid][id][e_Mode] = MODE_NONE;
	pInfo[slotid][id][e_Session] = 0;
	pInfo[slotid][id][e_PlayerName] = EOS;

	pInfo[slotid][id][e_Action] = false;
	pInfo[slotid][id][e_Timer] = 0;

	pInfo[slotid][id][e_VirtualWorld] =
	pInfo[slotid][id][e_Interior] = 0;

	pInfo[slotid][id][e_PosX] =
	pInfo[slotid][id][e_PosY] =
	pInfo[slotid][id][e_PosZ] = 0.0;

	pInfo[slotid][id][e_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
	pInfo[slotid][id][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
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

public OnGameModeInit()
{
	Iter_Init(TotalDropTokens);

	#if defined DropT_OnGameModeInit
		return DropT_OnGameModeInit();
	#else
		return 1;
	#endif
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerDropTokenData(playerid);

	#if defined DropT_OnPlayerConnect
		return DropT_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	// ALT
	if (newkeys & KEY_WALK) {
		// Picking up tokens
		if (GetPlayerDead(playerid) == PLAYER_DEATH_NONE) {
			m_for(M_GP(playerid), M_GPS(playerid), slotid) {
				foreach (new id:TotalDropTokens[slotid]) {
					if (IsPlayerInRangeOfPoint(playerid, 1.5, pInfo[slotid][id][e_PosX], pInfo[slotid][id][e_PosY], pInfo[slotid][id][e_PosZ])) {
						GivePlayerReward(playerid, 150, 100, REWARD_TOKEN);
						PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

						CheckPlayerQuestProgress(playerid, MODE_DM, 3);
						CheckPlayerQuestProgress(playerid, MODE_DM, 7);
						CheckPlayerQuestProgress(playerid, MODE_DM, 12);

						DestroyPlayerDropToken(slotid, id);

						new
							cur = id;

						Iter_SafeRemove(TotalDropTokens[slotid], cur, id);
					}
				}
			}
		}
	}

	#if defined DropT_OnPlayerKeyStateChange
		return DropT_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}

/*
 * |>-------<|
 * |   ALS   |
 * |>-------<|
 */

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit DropT_OnGameModeInit
#if defined DropT_OnGameModeInit
	forward DropT_OnGameModeInit();
#endif


#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect DropT_OnPlayerConnect
#if defined DropT_OnPlayerConnect
	forward DropT_OnPlayerConnect(playerid);
#endif


#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange DropT_OnPlayerKeyStateChange
#if defined DropT_OnPlayerKeyStateChange
	forward DropT_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys);
#endif