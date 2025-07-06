/*

	About: Damage system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnPlayerConnect(playerid)
		OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
		OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
	Stock:
		Damage_SetPlayerBody(playerid, issuerid, body)
		Damage_ResetPlayerBody(playerid)
		Damage_CheckPlayerBody(playerid)
		Damage_CreatePlayerIndicator(playerid, Float:amount, cell_ind, delete_id = -1)
		Damage_DeletePlayerIndicator(playerid, cell_ind = -1, bool:change = false)
		Damage_UdpatePlayerIndicator(playerid)
		Damage_SetPlayerNextSkill(playerid, weapon_id, cell_id, next_exp)
		Damage_GetPlayerNextSkill(playerid, weapon_id, cell_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DAMAGE_SYSTEM
	#endinput
#endif
#define _INC_DAMAGE_SYSTEM

/*

	* Vars *

*/

static const
	Float:d_InfoWeaponDamage[] = {

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

// Indicators damage

static 
	IND_PlayerTimer[MAX_PLAYERS][MAX_INDICATOR_TEXT],
	PlayerText3D:IND_Player3DText[MAX_PLAYERS][MAX_INDICATOR_TEXT],
	Float:IND_PlayerPosX[MAX_PLAYERS][MAX_INDICATOR_TEXT],
	Float:IND_PlayerPosY[MAX_PLAYERS][MAX_INDICATOR_TEXT],
	Float:IND_PlayerPosZ[MAX_PLAYERS][MAX_INDICATOR_TEXT],
	IND_PlayerIndicators[MAX_PLAYERS],
	IND_PlayerCell[MAX_PLAYERS],
	IND_PlayerDelete[MAX_PLAYERS];

// Body damage

static
	d_ActivePlayerDamageBody[MAX_PLAYERS],
	d_ActiveKillerDamageBody[MAX_PLAYERS];

// Next up skills

static
	d_WeaponSkill[MAX_PLAYERS][8],
	d_CloseFightSkill[MAX_PLAYERS][6];

/*

	* Functions *

*/

stock Damage_SetPlayerBody(playerid, issuerid, body)
{
	d_ActivePlayerDamageBody[playerid] = body;
	d_ActiveKillerDamageBody[playerid] = issuerid;
	return 1;
}

stock Damage_ResetPlayerBody(playerid) 
{
	d_ActivePlayerDamageBody[playerid] = 0;
	d_ActiveKillerDamageBody[playerid] = -1;
	return 1;
}

stock Damage_CheckPlayerBody(playerid)
{
	new
		killerid = d_ActiveKillerDamageBody[playerid];

	if(killerid > -1) {
		switch(d_ActivePlayerDamageBody[playerid]) {
			case 9: { // Head
				Mode_CheckQuestHead(killerid, Mode_GetPlayer(killerid));
			}
		}
		Damage_ResetPlayerBody(playerid);
	}
	return 1;
}

stock Damage_CreatePlayerIndicator(playerid, Float:amount, cell_ind, delete_id = -1)
{
	if(IND_PlayerCell[playerid] == -1)
		return 1;

	if(delete_id > -1)
		Damage_DeletePlayerIndicator(playerid, delete_id, true);

	new
		str[15];

	f(str, "-%.0f", amount);

	IND_Player3DText[playerid][cell_ind] = CreatePlayer3DTextLabel(playerid, str, 0xCCCCCCFF, IND_PlayerPosX[playerid][cell_ind], 
	IND_PlayerPosY[playerid][cell_ind], IND_PlayerPosZ[playerid][cell_ind], 500.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1);

	IND_PlayerTimer[playerid][cell_ind] = gettime() + INDICATOR_TEXT_TIMER;

	IND_PlayerCell[playerid] = -1;
	return 1;
}

stock Damage_DeletePlayerIndicator(playerid, cell_ind = -1, bool:change = false)
{
	if(cell_ind > -1) {
		IND_PlayerTimer[playerid][cell_ind] = 0;
		DestroyPlayerText3D(playerid, IND_Player3DText[playerid][cell_ind]);

		if(!change) {
			IND_PlayerPosX[playerid][cell_ind] =
			IND_PlayerPosY[playerid][cell_ind] =
			IND_PlayerPosZ[playerid][cell_ind] = 0.0;

			IND_PlayerIndicators[playerid]--;
		}
	}
	else {
		n_for(i, MAX_INDICATOR_TEXT) {
			if(IND_PlayerTimer[playerid][i] == 0)
				continue;

			DestroyPlayerText3D(playerid, IND_Player3DText[playerid][i]);

			IND_PlayerTimer[playerid][i] = 0;

			IND_PlayerPosX[playerid][i] =
			IND_PlayerPosY[playerid][i] =
			IND_PlayerPosZ[playerid][i] = 0.0;
		}
		IND_PlayerIndicators[playerid] = 0;
		IND_PlayerCell[playerid] = IND_PlayerDelete[playerid] = -1;
	}
	return 1;
}

stock Damage_UdpatePlayerIndicator(playerid)
{
	n_for(i, MAX_INDICATOR_TEXT) {
		if(IND_PlayerTimer[playerid][i] == 0)
			continue;

		if(IND_PlayerTimer[playerid][i] > gettime())
			continue;

		Damage_DeletePlayerIndicator(playerid, i);
	}
	return 1;
}

stock Damage_SetPlayerNextSkill(playerid, weapon_id, cell_id, next_exp)
{
	switch(weapon_id) {
		case 1: {
			if(next_exp > 0)
				d_CloseFightSkill[playerid][cell_id] += next_exp;
			else
				d_CloseFightSkill[playerid][cell_id] = 0;
		}
		case 2: {
			if(next_exp > 0)
				d_WeaponSkill[playerid][cell_id] += next_exp;
			else
				d_WeaponSkill[playerid][cell_id] = 0;
		}
	}
	return 1;
}

stock Damage_GetPlayerNextSkill(playerid, weapon_id, cell_id)
{
	switch(weapon_id) {
		case 1: return d_CloseFightSkill[playerid][cell_id];
		case 2: return d_WeaponSkill[playerid][cell_id];
	}
	return 0;
}

static SetPlayerPosIndicatorDamage(playerid)
{
	new
		cell_indicator;
	new
		most_ind;

	if(IND_PlayerIndicators[playerid] >= MAX_INDICATOR_TEXT) {

		n_for(i, MAX_INDICATOR_TEXT) {
			if(IND_PlayerTimer[playerid][i] >= most_ind) 
				most_ind = IND_PlayerTimer[playerid][i];
		}

		new
			lost_ind = most_ind, 
			index;

		n_for(i, MAX_INDICATOR_TEXT) {
			if(IND_PlayerTimer[playerid][i] <= lost_ind) {
				lost_ind = IND_PlayerTimer[playerid][i];
				index = i;
			}
		}
		cell_indicator = index;
		IND_PlayerDelete[playerid] = index;
		IND_PlayerCell[playerid] = index;
	}
	else {
		n_for(i, MAX_INDICATOR_TEXT) {
			if(IND_PlayerTimer[playerid][i] != 0) 
				continue;

			cell_indicator = i;
			IND_PlayerDelete[playerid] = -1;
			IND_PlayerCell[playerid] = i;

			IND_PlayerIndicators[playerid]++;
			break;
		}
	}

	new
		Float:fOriginX, Float:fOriginY, Float:fOriginZ,
		Float:fHitPosX, Float:fHitPosY, Float:fHitPosZ;

	GetPlayerLastShotVectors(playerid, fOriginX, fOriginY, fOriginZ, fHitPosX, fHitPosY, fHitPosZ);

	IND_PlayerPosX[playerid][cell_indicator] = fHitPosX;
	IND_PlayerPosY[playerid][cell_indicator] = fHitPosY;
	IND_PlayerPosZ[playerid][cell_indicator] = fHitPosZ;
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerData(playerid)
{
	Damage_ResetPlayerBody(playerid);

	n_for(i, sizeof(d_CloseFightSkill[]))
		d_CloseFightSkill[playerid][i] = 0;

	n_for(i, sizeof(d_WeaponSkill[]))
		d_WeaponSkill[playerid][i] = 0;

	n_for(i, MAX_INDICATOR_TEXT) {
		IND_PlayerTimer[playerid][i] = 0;

		IND_PlayerPosX[playerid][i] =
		IND_PlayerPosY[playerid][i] =
		IND_PlayerPosZ[playerid][i] = 0.0;
	}

	IND_PlayerIndicators[playerid] = 0;

	IND_PlayerCell[playerid] =
	IND_PlayerDelete[playerid] = -1;
	return 1;
}

static ResetPlayer3DTexts(playerid)
{
	n_for(i, MAX_INDICATOR_TEXT)
		IND_Player3DText[playerid][i] = PlayerText3D:INVALID_3DTEXT_ID;

	return 1;
}

/*

	* Callbacks *

*/

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);
	ResetPlayer3DTexts(playerid);

	#if defined Damage_OnPlayerConnect
		return Damage_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerDamage
*/

stock Damage_OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
	#pragma unused weapon
	if(!GetPlayerDamage(playerid))
		return 0;

	if(issuerid != INVALID_PLAYER_ID) {
		if(GetPlayerTeamEx(playerid) != GetPlayerTeamEx(issuerid) || GetPlayerTeamEx(playerid) == NO_TEAM) {
			SetPlayerShotEnemy(playerid, 1);
			Damage_CreatePlayerIndicator(issuerid, amount, IND_PlayerCell[issuerid], IND_PlayerDelete[issuerid]);

			switch(bodypart) {
				case 9: { // Голова
					SetPlayerShotHead(playerid, 1);
				}
			}
		}
	}
	return 1;
}

/*
	OnPlayerWeaponShot
*/

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch(hittype) {
		case BULLET_HIT_TYPE_PLAYER: {
			if(!GetPlayerDamage(hitid))
				return 0;

			if(IsBulletWeaponEx(weaponid))
				SetPlayerPosIndicatorDamage(playerid);
		}
		case BULLET_HIT_TYPE_VEHICLE: {
			if(IsBulletWeaponEx(weaponid)) {
				if(Veh_GetDriverPlayer(hitid) > -1) {
					if(GetPlayerTeamEx(Veh_GetDriverPlayer(hitid)) != GetPlayerTeamEx(playerid)) {
						if(!GetPlayerDamage(Veh_GetDriverPlayer(hitid))) 
							return 0;

						Veh_SetDamageShot(hitid, playerid, weaponid);

						PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);
						SetPlayerPosIndicatorDamage(playerid);
						Damage_CreatePlayerIndicator(playerid, d_InfoWeaponDamage[GetPlayerWeapon(playerid)], IND_PlayerCell[playerid], IND_PlayerDelete[playerid]);
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
	ALS
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
	forward Damage_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
#endif