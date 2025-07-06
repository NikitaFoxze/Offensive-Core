/*
 * |>============================<|
 * |   About: Drop-weapons main   |
 * |   Author: Foxze              |
 * |>============================<|
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
	- CreatePlayerDropWeapon(playerid)
	- DestroyPlayerDropWeapon(slotid, id = -1)
	- UpdatePlayerDropWeapons()
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_DROP_WEAPON_INFO
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

#if defined _INC_DROP_WEAPONS_MAIN
	#endinput
#endif
#define _INC_DROP_WEAPONS_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_DROP_WEAPON_INFO {
	e_Mode,
	e_Session,
	e_ObjectWeapon,
	Text3D:e_3DText,
	bool:e_Action,
	WEAPON:e_WeaponID,
	e_Ammo,
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
	pInfo[MAX_PLAYERS][DROP_WEAPONS_MAX][E_PLAYER_DROP_WEAPON_INFO];

static
	Float:GetPlayerRandom3DText() {
		new
			Float:r,
			ran = random(4);

		switch (ran) {
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

		switch (ran) {
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

		switch (ran) {
			case 0: r = 20.0;
			case 1: r = -40.0;
			case 2: r = 60.0;
			case 3: r = 90.0;
			case 4: r = -60.0;
		}
		return r;
	}

static const
	WEAPON_SLOT:ActiveDropWeapom[DROP_WEAPONS_MAX] = { WEAPON_SLOT_PISTOL, WEAPON_SLOT_SHOTGUN, WEAPON_SLOT_ASSAULT_RIFLE, WEAPON_SLOT_ARTILLERY, WEAPON_SLOT_EXPLOSIVES };

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
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock CreatePlayerDropWeapon(playerid)
{
	DestroyPlayerDropWeapon(playerid);

	new
		Float:randomPos[2][DROP_WEAPONS_MAX],
		randomAmount = DROP_WEAPONS_MAX;

	n_for(i, DROP_WEAPONS_MAX) {
		n_for2(s, 2)
			randomPos[s][i] = RandomDropWeaponInfo[s][i];
	}

	for (new WEAPON_SLOT:w; w < MAX_WEAPON_SLOTS; w++) {
		if (!IsActiveDropWeapon(w)) {
			continue;
		}

		new
			WEAPON:weaponid,
			ammo;

		GetPlayerWeaponData(playerid, w, weaponid, ammo);

		if (weaponid > WEAPON_FIST 
		&& ammo > 0) {
			n_for2(id, DROP_WEAPONS_MAX) {
				if (pInfo[playerid][id][e_Action]) {
					continue;
				}

				new
					Float:x, Float:y, Float:z;

				GetPlayerPos(playerid, x, y, z);
			
				new
					num = random(randomAmount);

				x += randomPos[0][num];
				y += randomPos[1][num];
				randomAmount--;
				randomPos[0][num] = randomPos[0][randomAmount];
				randomPos[1][num] = randomPos[1][randomAmount];

				pInfo[playerid][id][e_Mode] = Mode_GetPlayerMode(playerid);
				pInfo[playerid][id][e_Session] = Mode_GetPlayerSession(playerid);
				pInfo[playerid][id][e_Action] = true;
				pInfo[playerid][id][e_WeaponID] = weaponid;
				pInfo[playerid][id][e_Ammo] = ammo;
				pInfo[playerid][id][e_Timer] = DROP_WEAPONS_TIMER;
				pInfo[playerid][id][e_PosX] = x;
				pInfo[playerid][id][e_PosY] = y;
				pInfo[playerid][id][e_PosZ] = z;
				pInfo[playerid][id][e_VirtualWorld] = GetPlayerVirtualWorldEx(playerid);
				pInfo[playerid][id][e_Interior] = GetPlayerInteriorEx(playerid);
				pInfo[playerid][id][e_ObjectWeapon] = CreateDynamicObject(GetWeaponModelEx(weaponid), x, y, z - 1.0, 90.000, 0.000, GetPlayerRandomTurn() + GetPlayerRandomTurn2(), pInfo[playerid][id][e_VirtualWorld], pInfo[playerid][id][e_Interior]);

				CreateDropWeapon3DText(playerid, id);

				Iter_Add(TotalDropWeapons[playerid], id);

				Streamer_Update(playerid);
				break;
			}
		}
	}
	return 1;
}

stock DestroyPlayerDropWeapon(slotid, id = -1)
{
	if (id > -1) {
		DestroyDynamic3DTextLabel(pInfo[slotid][id][e_3DText]);
		DestroyDynamicObject(pInfo[slotid][id][e_ObjectWeapon]);

		ResetDropWeaponData(slotid, id);
	}
	else {
		foreach (new d:TotalDropWeapons[slotid]) {
			DestroyDynamic3DTextLabel(pInfo[slotid][d][e_3DText]);
			DestroyDynamicObject(pInfo[slotid][d][e_ObjectWeapon]);

			ResetDropWeaponData(slotid, d);
		}
		Iter_Clear(TotalDropWeapons[slotid]);
	}
	return 1;
}

stock UpdatePlayerDropWeapons(playerid)
{
	foreach (new d:TotalDropWeapons[playerid]) {
		if (pInfo[playerid][d][e_Timer] > 0) {
			pInfo[playerid][d][e_Timer]--;
			continue;
		}

		DestroyPlayerDropWeapon(playerid, d);

		new
			cur = d;

		Iter_SafeRemove(TotalDropWeapons[playerid], cur, d);
	}
	return 1;
}

static IsActiveDropWeapon(WEAPON_SLOT:slotid)
{
	n_for(w, DROP_WEAPONS_MAX) {
		if (ActiveDropWeapom[w] == slotid)
			return 1;
	}

	return 0;
}

static ChangePlayerDropWeapon(slotid, id, WEAPON:weaponid, ammo)
{
	pInfo[slotid][id][e_WeaponID] = weaponid;
	pInfo[slotid][id][e_Ammo] = ammo;

	new
		Float:posX, Float:posY, Float:posZ,
		Float:rotX, Float:rotY, Float:rotZ;

	GetDynamicObjectPos(pInfo[slotid][id][e_ObjectWeapon], posX, posY, posZ);
	GetDynamicObjectRot(pInfo[slotid][id][e_ObjectWeapon], rotX, rotY, rotZ);

	DestroyDynamicObject(pInfo[slotid][id][e_ObjectWeapon]);
	pInfo[slotid][id][e_ObjectWeapon] = CreateDynamicObject(GetWeaponModelEx(weaponid), posX, posY, posZ, rotX, rotY, rotZ, pInfo[slotid][id][e_VirtualWorld], pInfo[slotid][id][e_Interior]);

	CreateDropWeapon3DText(slotid, id, false);

	Mode_StreamerUpdate(M_GP(slotid), M_GPS(slotid));
	return 1;
}

static CreateDropWeapon3DText(slotid, id, bool:create = true)
{
	static
		str[75 - 4 + 1 + MAX_LENGTH_WEAPON_NAME];

	str[0] = EOS;

	new
		weaponName[MAX_LENGTH_WEAPON_NAME];

	GetWeaponNameRU(pInfo[slotid][id][e_WeaponID], weaponName, MAX_LENGTH_WEAPON_NAME);
	f(str, "{94e01e}%s\n{62d813}%i "CT_WHITE"шт.\n\n"CT_WHITE"Нажмите: {ebba1d}[ ALT ]", weaponName, pInfo[slotid][id][e_Ammo]);

	if (create) {
		pInfo[slotid][id][e_3DText] = CreateDynamic3DTextLabel(str, -1, pInfo[slotid][id][e_PosX], pInfo[slotid][id][e_PosY], pInfo[slotid][id][e_PosZ] - 1.0 + GetPlayerRandom3DText(), 7.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, pInfo[slotid][id][e_VirtualWorld], pInfo[slotid][id][e_Interior]);
	}
	else {
		UpdateDynamic3DTextLabelText(pInfo[slotid][id][e_3DText], -1, str);
	}
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerDropWeaponData(playerid)
{
	n_for(i, DROP_WEAPONS_MAX) {
		ResetDropWeaponData(playerid, i);
	}
	return 1;
}

static ResetDropWeaponData(slotid, id)
{
	pInfo[slotid][id][e_Mode] = MODE_NONE;
	pInfo[slotid][id][e_Session] = 0;

	pInfo[slotid][id][e_Action] = false;

	pInfo[slotid][id][e_WeaponID] = WEAPON_FIST;
	pInfo[slotid][id][e_Ammo] =
	pInfo[slotid][id][e_Timer] = 0;

	pInfo[slotid][id][e_PosX] =
	pInfo[slotid][id][e_PosY] =
	pInfo[slotid][id][e_PosZ] = 0.0;

	pInfo[slotid][id][e_VirtualWorld] =
	pInfo[slotid][id][e_Interior] = 0;

	pInfo[slotid][id][e_ObjectWeapon] = INVALID_DYNAMIC_OBJECT_ID;
	pInfo[slotid][id][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
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

public OnGameModeInit()
{
	Iter_Init(TotalDropWeapons);

	#if defined DropW_OnGameModeInit
		return DropW_OnGameModeInit();
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
	ResetPlayerDropWeaponData(playerid);

	#if defined DropW_OnPlayerConnect
		return DropW_OnPlayerConnect(playerid);
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
		// Picking up weapons
		if (GetPlayerDead(playerid) == PLAYER_DEATH_NONE) {
			m_for(M_GP(playerid), M_GPS(playerid), slotid) {
				foreach (new id:TotalDropWeapons[slotid]) {
					if (IsPlayerInRangeOfPoint(playerid, 1.0, pInfo[slotid][id][e_PosX], pInfo[slotid][id][e_PosY], pInfo[slotid][id][e_PosZ])) {
						new
							WEAPON:playerWeaponid,
							playerAmmo;

						GetPlayerWeaponData(playerid, GetWeaponSlot(pInfo[slotid][id][e_WeaponID]), playerWeaponid, playerAmmo);
						GivePlayerWeaponEx(playerid, pInfo[slotid][id][e_WeaponID], pInfo[slotid][id][e_Ammo]);

						if ((playerWeaponid > WEAPON_FIST
						&& playerAmmo > 0)
						&& playerWeaponid != pInfo[slotid][id][e_WeaponID]) {
							ChangePlayerDropWeapon(slotid, id, playerWeaponid, playerAmmo);
						}
						else {
							DestroyPlayerDropWeapon(slotid, id);

							new
								cur = id;

							Iter_SafeRemove(TotalDropWeapons[slotid], cur, id);
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
 * |>-------<|
 * |   ALS   |
 * |>-------<|
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
	forward DropW_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys);
#endif