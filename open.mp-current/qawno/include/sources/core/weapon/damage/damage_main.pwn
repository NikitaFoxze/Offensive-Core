/*
 * |>======================<|
 * |   About: Damage main   |
 * |   Author: Foxze        |
 * |>======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)
	- OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
	- OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
 * Stock:
	- SetPlayerDamageBody(playerid, issuerid, body)
	- ResetPlayerDamageBody(playerid)
	- CheckPlayerDamageBody(playerid)
	- CreatePlayerDamageIndicator(playerid, Float:amount, cellInd, deleteid = -1)
	- DeletePlayerDamageIndicator(playerid, cellInd = -1, bool:change = false)
	- UdpatePlayerDamageIndicator(playerid)
	- SetPlayerDamageNextSkill(playerid, weapon_id, cellid, next_exp)
	- GetPlayerDamageNextSkill(playerid, weapon_id, cellid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_INDICATOR_DAMAGE
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

#if defined _INC_DAMAGE_MAIN
	#endinput
#endif
#define _INC_DAMAGE_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_INDICATOR_DAMAGE {
	e_Cell,
	e_Deleting,
	e_Total,
	e_Timer[MAX_PLAYER_INDICATOR_DAMAGE],
	PlayerText3D:e_3DText[MAX_PLAYER_INDICATOR_DAMAGE],
	Float:e_PosX[MAX_PLAYER_INDICATOR_DAMAGE],
	Float:e_PosY[MAX_PLAYER_INDICATOR_DAMAGE],
	Float:e_PosZ[MAX_PLAYER_INDICATOR_DAMAGE]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static const
	Float:InfoWeaponDamage[] = {
	1.0, // 0 - Fist
	1.0, // 1 - Brass knuckles
	1.0, // 2 - Golf club
	1.0, // 3 - Nitestick
	1.0, // 4 - Knife
	1.0, // 5 - Bat
	1.0, // 6 - Shovel
	1.0, // 7 - Pool cue
	1.0, // 8 - Katana
	1.0, // 9 - Chainsaw
	1.0, // 10 - Dildo
	1.0, // 11 - Dildo 2
	1.0, // 12 - Vibrator
	1.0, // 13 - Vibrator 2
	1.0, // 14 - Flowers
	1.0, // 15 - Cane
	82.5, // 16 - Grenade
	0.0, // 17 - Teargas
	1.0, // 18 - Molotov
	9.9, // 19 - Vehicle M4 (custom)
	46.2, // 20 - Vehicle minigun (custom)
	0.0, // 21 - None
	8.25, // 22 - Colt 45
	13.2, // 23 - Silenced
	46.2, // 24 - Deagle
	3.3, // 25 - Shotgun
	3.3, // 26 - Sawed-off
	4.95, // 27 - Spas
	6.6, // 28 - UZI
	8.25, // 29 - MP5
	9.9, // 30 - AK47
	9.9, // 31 - M4
	6.6, // 32 - Tec9
	24.75, // 33 - Cuntgun
	41.25, // 34 - Sniper
	82.5, // 35 - Rocket launcher
	82.5, // 36 - Heatseeker
	1.0, // 37 - Flamethrower
	46.2, // 38 - Minigun
	82.5, // 39 - Satchel
	0.0, // 40 - Detonator
	0.33, // 41 - Spraycan
	0.33, // 42 - Fire extinguisher
	0.0, // 43 - Camera
	0.0, // 44 - Night vision
	0.0, // 45 - Infrared
	0.0, // 46 - Parachute
	0.0, // 47 - Fake pistol
	2.64, // 48 - Pistol whip (custom)
	9.9, // 49 - Vehicle
	330.0, // 50 - Helicopter blades
	82.5, // 51 - Explosion
	1.0, // 52 - Car park (custom)
	1.0, // 53 - Drowning
	165.0  // 54 - Splat
};

static
	indInfo[MAX_PLAYERS][E_PLAYER_INDICATOR_DAMAGE];

static
	ActivePlayerDamageBody[MAX_PLAYERS],
	ActiveKillerDamageBody[MAX_PLAYERS];

static
	WeaponSkill[MAX_PLAYERS][8],
	CloseFightSkill[MAX_PLAYERS][6];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock SetPlayerDamageBody(playerid, issuerid, body)
{
	ActivePlayerDamageBody[playerid] = body;
	ActiveKillerDamageBody[playerid] = issuerid;
	return 1;
}

stock ResetPlayerDamageBody(playerid) 
{
	ActivePlayerDamageBody[playerid] = 0;
	ActiveKillerDamageBody[playerid] = INVALID_PLAYER_ID;
	return 1;
}

stock CheckPlayerDamageBody(playerid)
{
	new
		killerid = ActiveKillerDamageBody[playerid];

	if (killerid != INVALID_PLAYER_ID) {
		switch (ActivePlayerDamageBody[playerid]) {
			case 9: { // Head
				Mode_CheckQuestHead(killerid, Mode_GetPlayerMode(killerid));
			}
		}
		ResetPlayerDamageBody(playerid);
	}
	return 1;
}

stock CreatePlayerDamageIndicator(playerid, Float:amount, cellInd, deleteid = -1)
{
	if (indInfo[playerid][e_Cell] == -1) {
		return 1;
	}

	if (deleteid > -1) {
		DeletePlayerDamageIndicator(playerid, deleteid, true);
	}

	new
		str[15];

	f(str, "-%.0f", amount);

	indInfo[playerid][e_3DText][cellInd] = CreatePlayer3DTextLabel(playerid, str, 0xCCCCCCFF, indInfo[playerid][e_PosX][cellInd], 
	indInfo[playerid][e_PosY][cellInd], indInfo[playerid][e_PosZ][cellInd], 500.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, true);

	indInfo[playerid][e_Timer][cellInd] = TIMER_PLAYER_INDICATOR_DAMAGE;

	indInfo[playerid][e_Cell] = -1;
	return 1;
}

stock DeletePlayerDamageIndicator(playerid, cellInd = -1, bool:change = false)
{
	if (cellInd > -1) {
		indInfo[playerid][e_Timer][cellInd] = 0;
		DestroyPlayerText3D(playerid, indInfo[playerid][e_3DText][cellInd]);

		if (!change) {
			indInfo[playerid][e_PosX][cellInd] =
			indInfo[playerid][e_PosY][cellInd] =
			indInfo[playerid][e_PosZ][cellInd] = 0.0;

			indInfo[playerid][e_Total]--;
		}
	}
	else {
		n_for(i, MAX_PLAYER_INDICATOR_DAMAGE) {
			if (indInfo[playerid][e_Timer][i] == 0) {
				continue;
			}

			DestroyPlayerText3D(playerid, indInfo[playerid][e_3DText][i]);

			indInfo[playerid][e_Timer][i] = 0;

			indInfo[playerid][e_PosX][i] =
			indInfo[playerid][e_PosY][i] =
			indInfo[playerid][e_PosZ][i] = 0.0;
		}
		indInfo[playerid][e_Total] = 0;
		indInfo[playerid][e_Cell] = indInfo[playerid][e_Deleting] = -1;
	}
	return 1;
}

stock UdpatePlayerDamageIndicator(playerid)
{
	n_for(i, MAX_PLAYER_INDICATOR_DAMAGE) {
		if (indInfo[playerid][e_Timer][i] == 0) {
			continue;
		}

		if (indInfo[playerid][e_Timer][i] > 0) {
			indInfo[playerid][e_Timer][i]--;
		}

		if (indInfo[playerid][e_Timer][i] <= 0) {
			DeletePlayerDamageIndicator(playerid, i);
		}
	}
	return 1;
}

stock SetPlayerDamageNextSkill(playerid, skillid, cellid, next_exp)
{
	switch (skillid) {
		case 1: {
			if (next_exp > 0) {
				CloseFightSkill[playerid][cellid] += next_exp;
			}
			else {
				CloseFightSkill[playerid][cellid] = 0;
			}
		}
		case 2: {
			if (next_exp > 0) {
				WeaponSkill[playerid][cellid] += next_exp;
			}
			else {
				WeaponSkill[playerid][cellid] = 0;
			}
		}
	}
	return 1;
}

stock GetPlayerDamageNextSkill(playerid, skillid, cellid)
{
	switch (skillid) {
		case 1: {
			return CloseFightSkill[playerid][cellid];
		}
		case 2: {
			return WeaponSkill[playerid][cellid];
		}
	}
	return 0;
}

static SetPlayerPosIndicatorDamage(playerid)
{
	new
		cellIndicator,
		mostInd;

	if (indInfo[playerid][e_Total] >= MAX_PLAYER_INDICATOR_DAMAGE) {
		n_for(i, MAX_PLAYER_INDICATOR_DAMAGE) {
			if (indInfo[playerid][e_Timer][i] >= mostInd) {
				mostInd = indInfo[playerid][e_Timer][i];
			}
		}

		new
			lostInd = mostInd, 
			index;

		n_for(i, MAX_PLAYER_INDICATOR_DAMAGE) {
			if (indInfo[playerid][e_Timer][i] <= lostInd) {
				lostInd = indInfo[playerid][e_Timer][i];
				index = i;
			}
		}
		cellIndicator = index;
		indInfo[playerid][e_Deleting] = index;
		indInfo[playerid][e_Cell] = index;
	}
	else {
		n_for(i, MAX_PLAYER_INDICATOR_DAMAGE) {
			if (indInfo[playerid][e_Timer][i] > 0) {
				continue;
			}

			cellIndicator = i;
			indInfo[playerid][e_Deleting] = -1;
			indInfo[playerid][e_Cell] = i;

			indInfo[playerid][e_Total]++;
			break;
		}
	}

	new
		Float:fOriginX, Float:fOriginY, Float:fOriginZ,
		Float:fHitPosX, Float:fHitPosY, Float:fHitPosZ;

	GetPlayerLastShotVectors(playerid, fOriginX, fOriginY, fOriginZ, fHitPosX, fHitPosY, fHitPosZ);

	indInfo[playerid][e_PosX][cellIndicator] = fHitPosX;
	indInfo[playerid][e_PosY][cellIndicator] = fHitPosY;
	indInfo[playerid][e_PosZ][cellIndicator] = fHitPosZ;
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerDamageData(playerid)
{
	ResetPlayerDamageBody(playerid);

	n_for(i, sizeof(CloseFightSkill[])) {
		CloseFightSkill[playerid][i] = 0;
	}

	n_for(i, sizeof(WeaponSkill[])) {
		WeaponSkill[playerid][i] = 0;
	}

	n_for(i, MAX_PLAYER_INDICATOR_DAMAGE) {
		indInfo[playerid][e_Timer][i] = 0;

		indInfo[playerid][e_PosX][i] =
		indInfo[playerid][e_PosY][i] =
		indInfo[playerid][e_PosZ][i] = 0.0;
	}

	indInfo[playerid][e_Total] = 0;

	indInfo[playerid][e_Cell] =
	indInfo[playerid][e_Deleting] = -1;
	return 1;
}

static ResetPlayerDamage3DTexts(playerid)
{
	n_for(i, MAX_PLAYER_INDICATOR_DAMAGE) {
		indInfo[playerid][e_3DText][i] = INVALID_PLAYER_3DTEXT_ID;
	}
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
	ResetPlayerDamageData(playerid);
	ResetPlayerDamage3DTexts(playerid);

	#if defined Damage_OnPlayerConnect
		return Damage_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>------------------<|
 * |   OnPlayerDamage   |
 * |>------------------<|
 */

stock Damage_OnPlayerDamage(&playerid, &Float:amount, &issuerid, &WEAPON:weapon, &bodypart)
{
	#pragma unused weapon

	if (!GetPlayerDamage(playerid)) {
		return 0;
	}

	if (issuerid != INVALID_PLAYER_ID) {
		if (GetPlayerTeamEx(playerid) != GetPlayerTeamEx(issuerid)
		|| GetPlayerTeamEx(playerid) == NO_TEAM) {
			GivePlayerShotsEnemy(playerid, 1);
			CreatePlayerDamageIndicator(issuerid, amount, indInfo[issuerid][e_Cell], indInfo[issuerid][e_Deleting]);

			switch (bodypart) {
				case 9: { // Head
					GivePlayerShotsHead(playerid, 1);
				}
			}
		}
	}
	return 1;
}

/*
 * |>----------------------<|
 * |   OnPlayerWeaponShot   |
 * |>----------------------<|
 */

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch (hittype) {
		case BULLET_HIT_TYPE_PLAYER: {
			if (!GetPlayerDamage(hitid)) {
				return 0;
			}

			if (IsBulletWeaponEx(weaponid)) {
				SetPlayerPosIndicatorDamage(playerid);
			}
		}
		case BULLET_HIT_TYPE_VEHICLE: {
			if (IsBulletWeaponEx(weaponid)) {
				if (GetVehicleDriverPlayer(hitid) != INVALID_PLAYER_ID) {
					if (GetPlayerTeamEx(GetVehicleDriverPlayer(hitid)) != GetPlayerTeamEx(playerid)) {
						if (!GetPlayerDamage(GetVehicleDriverPlayer(hitid))) {
							return 0;
						}

						SetVehicleDamageShot(hitid, playerid, weaponid);

						PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);
						SetPlayerPosIndicatorDamage(playerid);
						CreatePlayerDamageIndicator(playerid, InfoWeaponDamage[GetPlayerWeapon(playerid)], indInfo[playerid][e_Cell], indInfo[playerid][e_Deleting]);
					}
				}
			}
		}
	}

	#if defined Damage_OnPlayerWeaponShot
		return Damage_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
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
#define OnPlayerConnect Damage_OnPlayerConnect
#if defined Damage_OnPlayerConnect
	forward Damage_OnPlayerConnect(playerid);
#endif


#if defined _ALS_OnPlayerWeaponShot
	#undef OnPlayerWeaponShot
#else
	#define _ALS_OnPlayerWeaponShot
#endif
#define OnPlayerWeaponShot Damage_OnPlayerWeaponShot
#if defined Damage_OnPlayerWeaponShot
	forward Damage_OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ);
#endif