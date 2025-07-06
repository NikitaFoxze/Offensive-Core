/*

	About: Drop-weapons system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	Stock:
		DropW_CreatePlayerWeapon(playerid)
		DropW_DestroyPlayerWeapon(slotid, id = -1)
		DropW_UpdateTime()
Enums:
	E_PLAYER_DROP_WEAPON_INFO
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DROP_WEAPONS_SYSTEM
	#endinput
#endif
#define _INC_DROP_WEAPONS_SYSTEM

/*

	* Enums *

*/

enum E_PLAYER_DROP_WEAPON_INFO {
	WEAPON_Mode,
	WEAPON_Session,
	WEAPON_ObjectWeapon,
	Text3D:WEAPON_3DText,
	bool:WEAPON_Action,
	WEAPON_WeaponID,
	WEAPON_Ammo,
	WEAPON_Timer,
	WEAPON_VirtualWorld,
	WEAPON_Interior,
	Float:WEAPON_PosX,
	Float:WEAPON_PosY,
	Float:WEAPON_PosZ
}

/*

	* Vars *

*/

static
	dw_PlayerInfo[MAX_PLAYERS][DROP_WEAPONS_MAX][E_PLAYER_DROP_WEAPON_INFO];

static
	Float:GetPlayerRandom3DText() {
		new
			Float:r,
			ran = random(4);

		switch(ran) {
			case 0: r = 0.1;
			case 1: r = 0.2;
			case 2: r = 0.3;
			case 3: r = 0.4;
		}
		return r;
	}

static
	Float:GetPlayerRandomTurn() {
		new
			Float:r,
			ran = random(5);

		switch(ran) {
			case 0: r = 30.0;
			case 1: r = -35.0;
			case 2: r = 50.0;
			case 3: r = 100.0;
			case 4: r = -50.0;
		}
		return r;
	}

static
	Float:GetPlayerRandomTurn2() {
		new
			Float:r,
			ran = random(5);

		switch(ran) {
			case 0: r = 20.0;
			case 1: r = -40.0;
			case 2: r = 60.0;
			case 3: r = 90.0;
			case 4: r = -60.0;
		}
		return r;
	}

static const
	ActiveDropWeapom[DROP_WEAPONS_MAX] = { 2, 3, 5, 7, 8 };

static const
	Float:RandomDropWeaponInfo[2][DROP_WEAPONS_MAX] = {
	{ // X
		0.60,
		-0.60,
		0.0,
		-0.130,
		0.120
	},
	{ // Y
		0.60,
		-0.60,
		0.60,
		-0.130,
		-0.120
	}
};

/*

	* Functions *

*/

stock DropW_CreatePlayerWeapon(playerid)
{
	DropW_DestroyPlayerWeapon(playerid);

	new
		Float:random_pos[2][DROP_WEAPONS_MAX],
		amount_random = DROP_WEAPONS_MAX;

	n_for(i, DROP_WEAPONS_MAX) {
		n_for2(s, 2)
			random_pos[s][i] = RandomDropWeaponInfo[s][i];
	}

	n_for(w, MAX_PLAYER_WEAPON_SLOTS) {
		if(!IsActiveDropWeapon(w))
			continue;

		new
			weapon,
			ammo;

		GetPlayerWeaponData(playerid, w, weapon, ammo);

		if(weapon > 0 && ammo > 0) {
			n_for2(id, DROP_WEAPONS_MAX) {
				if(dw_PlayerInfo[playerid][id][WEAPON_Action])
					continue;

				new
					Float:x,
					Float:y,
					Float:z;

				GetPlayerPos(playerid, x, y, z);
			
				new
					num = random(amount_random);

				x += random_pos[0][num];
				y += random_pos[1][num];
				amount_random--;
				random_pos[0][num] = random_pos[0][amount_random];
				random_pos[1][num] = random_pos[1][amount_random];

				dw_PlayerInfo[playerid][id][WEAPON_Mode] = Mode_GetPlayer(playerid);
				dw_PlayerInfo[playerid][id][WEAPON_Session] = Mode_GetPlayerSession(playerid);
				dw_PlayerInfo[playerid][id][WEAPON_Action] = true;
				dw_PlayerInfo[playerid][id][WEAPON_WeaponID] = weapon;
				dw_PlayerInfo[playerid][id][WEAPON_Ammo] = ammo;
				dw_PlayerInfo[playerid][id][WEAPON_Timer] = gettime() + 30;
				dw_PlayerInfo[playerid][id][WEAPON_PosX] = x;
				dw_PlayerInfo[playerid][id][WEAPON_PosY] = y;
				dw_PlayerInfo[playerid][id][WEAPON_PosZ] = z;
				dw_PlayerInfo[playerid][id][WEAPON_VirtualWorld] = GetPlayerVirtualWorldEx(playerid);
				dw_PlayerInfo[playerid][id][WEAPON_Interior] = GetPlayerInteriorEx(playerid);
				dw_PlayerInfo[playerid][id][WEAPON_ObjectWeapon] = CreateDynamicObject(GetWeaponModel(weapon), x, y, z - 1.0, 90.000, 0.000, GetPlayerRandomTurn() + GetPlayerRandomTurn2(), dw_PlayerInfo[playerid][id][WEAPON_VirtualWorld], dw_PlayerInfo[playerid][id][WEAPON_Interior]);

				CreateDropWeapon3DText(playerid, id);

				Iter_Add(PlayerDropWeapons[playerid], id);

				Streamer_Update(playerid);
				break;
			}
		}
	}
	return 1;
}

stock DropW_DestroyPlayerWeapon(slotid, id = -1)
{
	if(id > -1) {
		DestroyDynamic3DTextLabel(dw_PlayerInfo[slotid][id][WEAPON_3DText]);
		DestroyDynamicObject(dw_PlayerInfo[slotid][id][WEAPON_ObjectWeapon]);

		ResetDropWeapon(slotid, id);
	}
	else {
		foreach(new d:PlayerDropWeapons[slotid]) {
			DestroyDynamic3DTextLabel(dw_PlayerInfo[slotid][d][WEAPON_3DText]);
			DestroyDynamicObject(dw_PlayerInfo[slotid][d][WEAPON_ObjectWeapon]);

			ResetDropWeapon(slotid, d);
		}
		Iter_Clear(PlayerDropWeapons[slotid]);
	}
	return 1;
}

stock DroW_PlayerUpdate(playerid)
{
	foreach(new d:PlayerDropWeapons[playerid]) {
		if(dw_PlayerInfo[playerid][d][WEAPON_Timer] > gettime())
			continue;

		DropW_DestroyPlayerWeapon(playerid, d);

		new
			cur = d;

		Iter_SafeRemove(PlayerDropWeapons[playerid], cur, d);
	}
	return 1;
}

static IsActiveDropWeapon(weaponid)
{
	new
		number = 0;

	n_for(w, DROP_WEAPONS_MAX) {
		if(ActiveDropWeapom[w] == weaponid) {
			number++;
			break;
		}
	}

	if(number == 0) 
		return 0;
	else 
		return 1;
}

static ChangePlayerDropWeapon(slotid, id, weaponid, ammo)
{
	dw_PlayerInfo[slotid][id][WEAPON_WeaponID] = weaponid;
	dw_PlayerInfo[slotid][id][WEAPON_Ammo] = ammo;

	new
		Float:PosX, Float:PosY, Float:PosZ,
		Float:RotX, Float:RotY, Float:RotZ;

	GetDynamicObjectPos(dw_PlayerInfo[slotid][id][WEAPON_ObjectWeapon], PosX, PosY, PosZ);
	GetDynamicObjectRot(dw_PlayerInfo[slotid][id][WEAPON_ObjectWeapon], RotX, RotY, RotZ);

	DestroyDynamicObject(dw_PlayerInfo[slotid][id][WEAPON_ObjectWeapon]);
	dw_PlayerInfo[slotid][id][WEAPON_ObjectWeapon] = CreateDynamicObject(GetWeaponModel(weaponid), PosX, PosY, PosZ, RotX, RotY, RotZ, dw_PlayerInfo[slotid][id][WEAPON_VirtualWorld], dw_PlayerInfo[slotid][id][WEAPON_Interior]);

	CreateDropWeapon3DText(slotid, id, false);

	Streamer_UP(M_GP(slotid), M_GPS(slotid));
	return 1;
}

static CreateDropWeapon3DText(slotid, id, bool:create = true)
{
	static
		str[DROP_WEAPON_STRING_MAX_LENGTH - 4 + 1 + WEAPON_NAME_MAX_LENGTH];

	str[0] = EOS;

	new
		weaponname[WEAPON_NAME_MAX_LENGTH];

	GetWeaponNameRU(dw_PlayerInfo[slotid][id][WEAPON_WeaponID], weaponname, sizeof(weaponname));
	f(str, "{94e01e}%s\n{62d813}%i {FFFFFF}шт.\n\n{FFFFFF}Нажмите: {ebba1d}[ ALT ]", weaponname, dw_PlayerInfo[slotid][id][WEAPON_Ammo]);

	if(create) 
		dw_PlayerInfo[slotid][id][WEAPON_3DText] = CreateDynamic3DTextLabel(str, -1, dw_PlayerInfo[slotid][id][WEAPON_PosX], dw_PlayerInfo[slotid][id][WEAPON_PosY], dw_PlayerInfo[slotid][id][WEAPON_PosZ] - 1.0 + GetPlayerRandom3DText(), 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, dw_PlayerInfo[slotid][id][WEAPON_VirtualWorld], dw_PlayerInfo[slotid][id][WEAPON_Interior]);
	else 
		UpdateDynamic3DTextLabelText(dw_PlayerInfo[slotid][id][WEAPON_3DText], -1, str);
	
	return 1;
}

/*

	* Reset *

*/

static ResetDropWeapon(slotid, id)
{
	dw_PlayerInfo[slotid][id][WEAPON_Mode] = MODE_NONE;
	dw_PlayerInfo[slotid][id][WEAPON_Session] = 0;

	dw_PlayerInfo[slotid][id][WEAPON_Action] = false;

	dw_PlayerInfo[slotid][id][WEAPON_WeaponID] =
	dw_PlayerInfo[slotid][id][WEAPON_Ammo] =
	dw_PlayerInfo[slotid][id][WEAPON_Timer] = 0;

	dw_PlayerInfo[slotid][id][WEAPON_PosX] =
	dw_PlayerInfo[slotid][id][WEAPON_PosY] =
	dw_PlayerInfo[slotid][id][WEAPON_PosZ] = 0.0;

	dw_PlayerInfo[slotid][id][WEAPON_VirtualWorld] =
	dw_PlayerInfo[slotid][id][WEAPON_Interior] = 0;

	dw_PlayerInfo[slotid][id][WEAPON_ObjectWeapon] = INVALID_DYNAMIC_OBJECT_ID;
	dw_PlayerInfo[slotid][id][WEAPON_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
	return 1;
}

static ResetPlayerData(playerid)
{
	n_for(i, DROP_WEAPONS_MAX)
		ResetDropWeapon(playerid, i);

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
	Iter_Init(PlayerDropWeapons);

	#if defined DropW_OnGameModeInit
		return DropW_OnGameModeInit();
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

	#if defined DropW_OnPlayerConnect
		return DropW_OnPlayerConnect(playerid);
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
		// Дроп оружия
		if(!GetPlayerDead(playerid)) {
			m_for(M_GP(playerid), M_GPS(playerid), slotid) {
				foreach(new id:PlayerDropWeapons[slotid]) {
					if(IsPlayerInRangeOfPoint(playerid, 1.0, dw_PlayerInfo[slotid][id][WEAPON_PosX], dw_PlayerInfo[slotid][id][WEAPON_PosY], dw_PlayerInfo[slotid][id][WEAPON_PosZ])) {
						new 
							player_weapon, 
							player_ammo;

						GetPlayerWeaponData(playerid, GetWeaponSlot(dw_PlayerInfo[slotid][id][WEAPON_WeaponID]), player_weapon, player_ammo);
						GivePlayerWeaponEx(playerid, dw_PlayerInfo[slotid][id][WEAPON_WeaponID], dw_PlayerInfo[slotid][id][WEAPON_Ammo]);

						if((player_weapon > 0
						&& player_ammo > 0)
						&& player_weapon != dw_PlayerInfo[slotid][id][WEAPON_WeaponID]) 
							ChangePlayerDropWeapon(slotid, id, player_weapon, player_ammo);
						else {
							DropW_DestroyPlayerWeapon(slotid, id);

							new
								cur = id;

							Iter_SafeRemove(PlayerDropWeapons[slotid], cur, id);
						}
					}
				}
			}
		}
	}

	#if defined DropW_OnPlayerKeyStateChange
		return DropW_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
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
#define OnGameModeInit DropW_OnGameModeInit
#if defined DropW_OnGameModeInit
	forward DropW_OnGameModeInit();
#endif


#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect DropW_OnPlayerConnect
#if defined DropW_OnPlayerConnect
	forward DropW_OnPlayerConnect(playerid);
#endif


#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange DropW_OnPlayerKeyStateChange
#if defined DropW_OnPlayerKeyStateChange
	forward DropW_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif