/*

	About: Drop-tokens system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	Stock:
		DropT_CreatePlayerToken(playerid)
		DropT_DestroyPlayerToken(slotid, id = -1)
		DropT_UpdateTime()
Enums:
	E_PLAYER_DROP_TOKEN_INFO
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DROP_TOKENS_SYSTEM
	#endinput
#endif
#define _INC_DROP_TOKENS_SYSTEM

/*

	* Enums *

*/

enum E_PLAYER_DROP_TOKEN_INFO {
	TOKEN_Mode,
	TOKEN_Session,
	TOKEN_PlayerName[MAX_PLAYER_NAME],
	bool:TOKEN_Action,
	Text3D:TOKEN_3DText,
	TOKEN_Pickup,
	TOKEN_Timer,
	TOKEN_VirtualWorld,
	TOKEN_Interior,
	Float:TOKEN_PosX,
	Float:TOKEN_PosY,
	Float:TOKEN_PosZ
}

/*

	* Vars *

*/

static 
	dt_PlayerInfo[MAX_PLAYERS][DROP_TOKENS_MAX][E_PLAYER_DROP_TOKEN_INFO];

/*

	* Functions *

*/

stock DropT_CreatePlayerToken(playerid)
{
	new
		cell = 0;

	if(Iter_Count(PlayerDropTokens[playerid]) < DROP_TOKENS_MAX) {
		n_for2(id, DROP_TOKENS_MAX) {
			if(dt_PlayerInfo[playerid][id][TOKEN_Action])
				continue;

			cell = id;
			break;
		}
	}
	else {
		new
			least_time = gettime(),
			index;

		foreach(new id:PlayerDropTokens[playerid]) {
			if(dt_PlayerInfo[playerid][id][TOKEN_Timer] >= least_time) {
				least_time = dt_PlayerInfo[playerid][id][TOKEN_Timer];
				index = id;
			}
		}

		cell = index;
		DropT_DestroyPlayerToken(playerid, cell);
		Iter_Remove(PlayerDropTokens[playerid], cell);
	}

	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	strins(dt_PlayerInfo[playerid][cell][TOKEN_PlayerName], NameEx(playerid), 0);
	dt_PlayerInfo[playerid][cell][TOKEN_Mode] = Mode_GetPlayer(playerid);
	dt_PlayerInfo[playerid][cell][TOKEN_Session] = Mode_GetPlayerSession(playerid);
	dt_PlayerInfo[playerid][cell][TOKEN_Action] = true;
	dt_PlayerInfo[playerid][cell][TOKEN_Timer] = gettime() + DROP_TOKENS_TIMER;
	dt_PlayerInfo[playerid][cell][TOKEN_PosX] = x;
	dt_PlayerInfo[playerid][cell][TOKEN_PosY] = y;
	dt_PlayerInfo[playerid][cell][TOKEN_PosZ] = z;
	dt_PlayerInfo[playerid][cell][TOKEN_VirtualWorld] = GetPlayerVirtualWorldEx(playerid);
	dt_PlayerInfo[playerid][cell][TOKEN_Interior] = GetPlayerInteriorEx(playerid);
	dt_PlayerInfo[playerid][cell][TOKEN_Pickup] = CreateDynamicPickup(1313, 1, x, y, z, dt_PlayerInfo[playerid][cell][TOKEN_VirtualWorld], dt_PlayerInfo[playerid][cell][TOKEN_Interior]);
	
	CreateDropToken3DText(playerid, cell);

	Iter_Add(PlayerDropTokens[playerid], cell);
	return 1;
}

stock DropT_DestroyPlayerToken(slotid, id = -1)
{
	if(id > -1) {
		DestroyDynamic3DTextLabel(dt_PlayerInfo[slotid][id][TOKEN_3DText]);
		DestroyDynamicPickup(dt_PlayerInfo[slotid][id][TOKEN_Pickup]);

		ResetDropToken(slotid, id);
	}
	else {
		foreach(new d:PlayerDropTokens[slotid]) {
			DestroyDynamic3DTextLabel(dt_PlayerInfo[slotid][d][TOKEN_3DText]);
			DestroyDynamicPickup(dt_PlayerInfo[slotid][d][TOKEN_Pickup]);

			ResetDropToken(slotid, d);
		}
		Iter_Clear(PlayerDropTokens[slotid]);
	}
	return 1;
}

stock DropT_PlayerUpdate(playerid)
{
	foreach(new d:PlayerDropTokens[playerid]) {
		if(dt_PlayerInfo[playerid][d][TOKEN_Timer] > gettime()) 
			continue;

		DropT_DestroyPlayerToken(playerid, d);

		new
			cur = d;

		Iter_SafeRemove(PlayerDropTokens[playerid], cur, d);
	}
	return 1;
}

static CreateDropToken3DText(slotid, id)
{
	static
		str[DROP_TOKENS_STRING_MAX_LENGTH - 2 + 1 + MAX_PLAYER_NAME];

	str[0] = EOS;

	new
		player_name[MAX_PLAYER_NAME];

	strcat(player_name, dt_PlayerInfo[slotid][id][TOKEN_PlayerName]);

	f(str, "{CC0033}Жетон\n{FFFF33}%s\n\n{FFFFFF}Нажмите: {ebba1d}[ ALT ]", player_name);
	dt_PlayerInfo[slotid][id][TOKEN_3DText] = CreateDynamic3DTextLabel(str, -1, dt_PlayerInfo[slotid][id][TOKEN_PosX], dt_PlayerInfo[slotid][id][TOKEN_PosY], dt_PlayerInfo[slotid][id][TOKEN_PosZ] + 0.5, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, GetPlayerVirtualWorldEx(slotid), GetPlayerInteriorEx(slotid));
	return 1;
}

/*

	* Reset *

*/

static ResetDropToken(slotid, id)
{
	dt_PlayerInfo[slotid][id][TOKEN_Mode] = MODE_NONE;
	dt_PlayerInfo[slotid][id][TOKEN_Session] = 0;
	dt_PlayerInfo[slotid][id][TOKEN_PlayerName] = EOS;

	dt_PlayerInfo[slotid][id][TOKEN_Action] = false;
	dt_PlayerInfo[slotid][id][TOKEN_Timer] = 0;

	dt_PlayerInfo[slotid][id][TOKEN_VirtualWorld] =
	dt_PlayerInfo[slotid][id][TOKEN_Interior] = 0;

	dt_PlayerInfo[slotid][id][TOKEN_PosX] =
	dt_PlayerInfo[slotid][id][TOKEN_PosY] =
	dt_PlayerInfo[slotid][id][TOKEN_PosZ] = 0.0;

	dt_PlayerInfo[slotid][id][TOKEN_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
	dt_PlayerInfo[slotid][id][TOKEN_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
}

static ResetPlayerData(playerid)
{
	n_for(i, DROP_TOKENS_MAX)
		ResetDropToken(playerid, i);

	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

public OnGameModeInit()
{
	Iter_Init(PlayerDropTokens);

	#if defined DropT_OnGameModeInit
		return DropT_OnGameModeInit();
	#else
		return 1;
	#endif
}

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);

	#if defined DropT_OnPlayerConnect
		return DropT_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerKeyStateChange
*/

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	// ALT
	if(newkeys & KEY_WALK) {
		// Подбирание жетонов
		if(!GetPlayerDead(playerid)) {
			m_for(M_GP(playerid), M_GPS(playerid), slotid) {
				foreach(new id:PlayerDropTokens[slotid]) {
					if(IsPlayerInRangeOfPoint(playerid, 1.5, dt_PlayerInfo[slotid][id][TOKEN_PosX], dt_PlayerInfo[slotid][id][TOKEN_PosY], dt_PlayerInfo[slotid][id][TOKEN_PosZ])) {
						SetPlayerFee(playerid, 150, 100, REPLEN_TOKEN);
						PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

						Quest_CheckPlayerProgress(playerid, MODE_DM, 3);
						Quest_CheckPlayerProgress(playerid, MODE_DM, 7);
						Quest_CheckPlayerProgress(playerid, MODE_DM, 12);

						DropT_DestroyPlayerToken(slotid, id);

						new
							cur = id;

						Iter_SafeRemove(PlayerDropTokens[slotid], cur, id);
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
	ALS
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
	forward DropT_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif