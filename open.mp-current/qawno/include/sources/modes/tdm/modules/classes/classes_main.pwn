/*
 * |>===========================<|
 * |   About: TDM classes main   |
 * |   Author: Foxze             |
 * |>===========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)

	# Technical #
	- TDM_CallClassAirCause(playerid, airtype, Float:x, Float:y, Float:z)
	- TDM_MySQLUploadPlayerClasses(playerid)
 * Stock:
	- TDM_SetPlayerFightSkill(playerid, FIGHT_STYLE:skillid, Float:exp)
	- TDM_GetPlayerFightSkill(playerid, FIGHT_STYLE:skillid, &Float:exp)

	- TDM_SetPlayerWeaponSkill(playerid, WEAPONSKILL:skillid, Float:exp)
	- TDM_GetPlayerWeaponSkill(playerid, WEAPONSKILL:skillid, &Float:exp)

	- TDM_GivePlayerClassKills(playerid, kills)
	- TDM_GetPlayerClassKills(playerid, classid)

	- TDM_GivePlayerClassDeaths(playerid, deaths)
	- TDM_GetPlayerClassDeaths(playerid, classid)

	- TDM_GetPlayerClassBody(playerid, typeid)
	- TDM_IsClass(classid)
	- TDM_ResetDialogClassAbils(playerid)
	- TDM_UpdateTimePlayerClass(playerid)
	- TDM_DestroyAllClassesAirdrop(sessionid)
	- TDM_UpdateClassesAirdrop(sessionid)
	- TDM_UpPlayerClassesAirdrop(playerid)
	- TDM_SetPlayerClassAmmunition(playerid)
	- TDM_PlayerClassAttachHead(playerid)

	- TDM_UpdatePlayerClassesData(playerid)
	- TDM_CallPlayerClassCommand(playerid, const cmdName[], const params[])

	- TDM_MySQLCreateNewStatsClass(playerid)
	- TDM_MySQLUploadPlayerClassData(playerid)
	- TDM_SavePlayerClassSkillWeapon(playerid, WEAPONSKILL:skillid)
	- TDM_SavePlayerClassSkillFight(playerid, FIGHT_STYLE:skillid)
	- TDM_SavePlayerClassWeapon(playerid, classid)
	- TDM_SavePlayerClassBody(playerid, classid)
	- TDM_SavePlayerClassAbilities(playerid, classid)
	- TDM_SavePlayerClasses(playerid)

	# Technical #
	- TDM_ClResetSessionData(sessionid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_TDM_PLAYER_CLASS_STATS_INFO
	- E_TDM_PLAYER_CLASS_WEAPON_INFO
	- E_TDM_PLAYER_C_USES_BODY_INFO
	- E_TDM_PLAYER_CLASS_BODY_INFO
	- E_TDM_PLAYER_CLASS_SKILLS_INFO
	- E_TDM_AIR_CAUSE_WEAPON_INFO
	- E_TDM_AIR_CAUSE_MEDIC_INFO
	- E_TDM_AIR_CAUSE_AMMO_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- TDM_ChooseStatsClass
	- TDM_ClassChooseStats
	- TDM_ClSkillsCFInfo
	- TDM_ClSkillsCloseFight
	- TDM_ClSkillsWeapon
	- TDM_PlayerClassStats
	- TDM_BuyListClAbility
	- TDM_BuyClassAbility
	- TDM_ListClassAbility
	- TDM_ClassAirdrop
	- TDM_ClassADInfo
	- TDM_ClassAD_1
	- TDM_ClassAD_2
	- TDM_ClassAD_3
	- TDM_ClassBuyAmmo
	- TDM_CauseWeapon
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- TDM_SelectedClass
	- TDM_SelectClass
 */

#if defined _INC_TDM_CLASSES_MAIN
	#endinput
#endif
#define _INC_TDM_CLASSES_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_TDM_PLAYER_CLASS_STATS_INFO {
	// MySQL
	e_Kills,
	e_Deaths,
	e_Hours,
	e_Minutes
}

enum E_TDM_PLAYER_CLASS_WEAPON_INFO {
	// MySQL
	WEAPON:e_Weapon,
	e_Ammo
}

enum E_TDM_PLAYER_C_USES_BODY_INFO {
	// MySQL
	e_Cap,
	e_Armour
}

enum E_TDM_PLAYER_CLASS_BODY_INFO {
	// MySQL
	e_Cap,
	e_Armour
}

enum E_TDM_PLAYER_CLASS_SKILLS_INFO {
	// MySQL
	Float:e_M4,
	Float:e_AK47,
	Float:e_Deagle,
	Float:e_Shotgun,
	Float:e_SawShotgun,
	Float:e_Uzi,
	Float:e_MP5,
	Float:e_Sniper,

	Float:e_Normal,
	Float:e_Boxing,
	Float:e_KungFu,
	Float:e_KneeHead,
	Float:e_GrabKick,
	Float:e_Elbow
}

enum E_TDM_AIR_CAUSE_WEAPON_INFO {
	e_ObjectAir,
	e_ObjectBox,
	//e_ObjectWeapon[TDM_AIR_C_MAX_OBJ_WEAPON],
	e_ObjectParachute,
	e_ObjectSmooke,
	e_Status,
	bool:e_Action,
	e_Type,
	e_Timer,
	e_VirtualWorld,
	e_Interior,
	WEAPON:e_Weapon[TDM_AIR_C_MAX_WEAPON],
	e_WeaponAmmo[TDM_AIR_C_MAX_WEAPON],
	Text3D:e_3DText,
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ
}

enum E_TDM_AIR_CAUSE_MEDIC_INFO {
	e_ObjectAir,
	e_ObjectBox,
	//Air_ObjectMedicament[TDM_AIR_C_MAX_OBJECT_MEDICAMENT],
	e_ObjectParachute,
	e_ObjectSmooke,
	e_Status,
	bool:e_Action,
	e_Type,
	e_Timer,
	e_VirtualWorld,
	e_Interior,
	Text3D:e_3DText,
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ
}

enum E_TDM_AIR_CAUSE_AMMO_INFO {
	e_ObjectAir,
	e_ObjectBox,
	//Air_ObjectAmmo[TDM_AIR_C_MAX_OBJECT_AMMO],
	e_ObjectParachute,
	e_ObjectSmooke,
	e_Status,
	bool:e_Action,
	e_Type,
	e_Timer,
	e_VirtualWorld,
	e_Interior,
	Text3D:e_3DText,
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
	pStatsInfo[MAX_PLAYERS][E_TDM_PLAYER_CLASS_STATS_INFO][TDM_MAX_PLAYER_CLASSES],
	pWeaponInfo[MAX_PLAYERS][E_TDM_PLAYER_CLASS_WEAPON_INFO][TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS],
	pBodyUsesInfo[MAX_PLAYERS][E_TDM_PLAYER_C_USES_BODY_INFO][TDM_MAX_PLAYER_CLASSES],
	pBodyInfo[MAX_PLAYERS][E_TDM_PLAYER_CLASS_BODY_INFO][TDM_MAX_PLAYER_CLASSES][TDM_MAX_SHOP_BODY],
	Float:pSkillInfo[MAX_PLAYERS][E_TDM_PLAYER_CLASS_SKILLS_INFO][TDM_MAX_PLAYER_CLASSES],
	pAbilsInfo[MAX_PLAYERS][TDM_MAX_PLAYER_CLASSES][TDM_MAX_CLASS_ABILITIES];

static
	PlayerAirMedicationID[MAX_PLAYERS],
	PlayerAirAmmoID[MAX_PLAYERS];

static
	PlayerAbilTimerMedicHP[MAX_PLAYERS],
	PlayerAbilTimerVehicle[MAX_PLAYERS];

static
	AirCauseWeapon[MAX_PLAYERS][E_TDM_AIR_CAUSE_WEAPON_INFO],
	AllCauseWeaponCount[GMS_MAX_SESSIONS],
	AllCauseWeaponAir[GMS_MAX_SESSIONS][MAX_PLAYERS];

static
	AirCauseMedication[MAX_PLAYERS][E_TDM_AIR_CAUSE_MEDIC_INFO],
	AllCauseMedicationCount[GMS_MAX_SESSIONS],
	AllCauseMedicationAir[GMS_MAX_SESSIONS][MAX_PLAYERS];

static
	AirCauseAmmo[MAX_PLAYERS][E_TDM_AIR_CAUSE_AMMO_INFO],
	AllCauseAmmoCount[GMS_MAX_SESSIONS],
	AllCauseAmmoAir[GMS_MAX_SESSIONS][MAX_PLAYERS];

static
	DialogListClassAbils[MAX_PLAYERS][TDM_MAX_CLASS_ABILITIES];

static
	PlayerText:TD_SelectClass[MAX_PLAYERS][TDM_TD_SELECT_CLASS],
	PlayerText:TD_SelectedClass[MAX_PLAYERS][TDM_TD_SELECTED_CLASS],
	PlayerText:TD_SelectWeapon[MAX_PLAYERS][TDM_TD_CLASS_SELECT_WEAPON],
	PlayerText:TD_Buy[MAX_PLAYERS][TDM_TD_CLASS_BUY_ITEMS];

static
	strBig[2048];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>---------------<|
 * |   Fight skill   |
 * |>---------------<|
 */

stock TDM_SetPlayerFightSkill(playerid, FIGHT_STYLE:skillid, Float:exp)
{
	new
		classid = GetPlayerCustomClass(playerid);

	switch (skillid) {
		case FIGHT_STYLE_NORMAL: pSkillInfo[playerid][e_Normal][classid] += exp;
		case FIGHT_STYLE_BOXING: pSkillInfo[playerid][e_Boxing][classid] += exp;
		case FIGHT_STYLE_KUNGFU: pSkillInfo[playerid][e_KungFu][classid] += exp;
		case FIGHT_STYLE_KNEEHEAD: pSkillInfo[playerid][e_KneeHead][classid] += exp;
		case FIGHT_STYLE_GRABKICK: pSkillInfo[playerid][e_GrabKick][classid] += exp;
		case FIGHT_STYLE_ELBOW: pSkillInfo[playerid][e_Elbow][classid] += exp;
	}
	TDM_SavePlayerClassSkillFight(playerid, skillid);
	return 1;
}

stock TDM_GetPlayerFightSkill(playerid, FIGHT_STYLE:skillid, &Float:exp)
{
	new
		classid = GetPlayerCustomClass(playerid);

	switch (skillid) {
		case FIGHT_STYLE_NORMAL: exp = pSkillInfo[playerid][e_Normal][classid];
		case FIGHT_STYLE_BOXING: exp = pSkillInfo[playerid][e_Boxing][classid];
		case FIGHT_STYLE_KUNGFU: exp = pSkillInfo[playerid][e_KungFu][classid];
		case FIGHT_STYLE_KNEEHEAD: exp = pSkillInfo[playerid][e_KneeHead][classid];
		case FIGHT_STYLE_GRABKICK: exp = pSkillInfo[playerid][e_GrabKick][classid];
		case FIGHT_STYLE_ELBOW: exp = pSkillInfo[playerid][e_Elbow][classid];
	}
	return 1;
}

/*
 * |>----------------<|
 * |   Weapon skill   |
 * |>----------------<|
 */

stock TDM_SetPlayerWeaponSkill(playerid, WEAPONSKILL:skillid, Float:exp)
{
	new
		classid = GetPlayerCustomClass(playerid);

	switch (skillid) {
		case WEAPONSKILL_M4: pSkillInfo[playerid][e_M4][classid] += exp;
		case WEAPONSKILL_AK47: pSkillInfo[playerid][e_AK47][classid] += exp;
		case WEAPONSKILL_DESERT_EAGLE: pSkillInfo[playerid][e_Deagle][classid] += exp;
		case WEAPONSKILL_SHOTGUN: pSkillInfo[playerid][e_Shotgun][classid] += exp;
		case WEAPONSKILL_SAWNOFF_SHOTGUN: pSkillInfo[playerid][e_SawShotgun][classid] += exp;
		case WEAPONSKILL_MICRO_UZI: pSkillInfo[playerid][e_Uzi][classid] += exp;
		case WEAPONSKILL_MP5: pSkillInfo[playerid][e_MP5][classid] += exp;
	}

	TDM_SavePlayerClassSkillWeapon(playerid, skillid);
	return 1;
}

stock TDM_GetPlayerWeaponSkill(playerid, WEAPONSKILL:skillid, &Float:exp)
{
	new
		classid = GetPlayerCustomClass(playerid);

	switch (skillid) {
		case WEAPONSKILL_M4: exp = pSkillInfo[playerid][e_M4][classid];
		case WEAPONSKILL_AK47: exp = pSkillInfo[playerid][e_AK47][classid];
		case WEAPONSKILL_DESERT_EAGLE: exp = pSkillInfo[playerid][e_Deagle][classid];
		case WEAPONSKILL_SHOTGUN: exp = pSkillInfo[playerid][e_Shotgun][classid];
		case WEAPONSKILL_SAWNOFF_SHOTGUN: exp = pSkillInfo[playerid][e_SawShotgun][classid];
		case WEAPONSKILL_MICRO_UZI: exp = pSkillInfo[playerid][e_Uzi][classid];
		case WEAPONSKILL_MP5: exp = pSkillInfo[playerid][e_MP5][classid];
		case WEAPONSKILL_SNIPERRIFLE: exp = pSkillInfo[playerid][e_Sniper][classid];
	}
	return 1;
}

/*
 * |>---------<|
 * |   Kills   |
 * |>---------<|
 */

stock TDM_GivePlayerClassKills(playerid, kills)
{
	if (Mode_GetPlayerMode(playerid) != MODE_TDM) {
		return 1;
	}

	new
		classid = GetPlayerCustomClass(playerid);

	if (classid == -1) {
		return 1;
	}

	pStatsInfo[playerid][e_Kills][classid] += kills;
	return 1;
}

stock TDM_GetPlayerClassKills(playerid, classid)
{
	return pStatsInfo[playerid][e_Kills][classid];
}

/*
 * |>----------<|
 * |   Deaths   |
 * |>----------<|
 */

stock TDM_GivePlayerClassDeaths(playerid, deaths)
{
	if (Mode_GetPlayerMode(playerid) != MODE_TDM) {
		return 1;
	}

	new
		classid = GetPlayerCustomClass(playerid);

	if (classid == -1) {
		return 1;
	}

	pStatsInfo[playerid][e_Deaths][classid] += deaths;
	return 1;
}

stock TDM_GetPlayerClassDeaths(playerid, classid)
{
	return pStatsInfo[playerid][e_Deaths][classid];
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

stock TDM_GetPlayerClassBody(playerid, typeid)
{
	new
		classid = GetPlayerCustomClass(playerid);

	switch (typeid) {
		case 1: {
			return pBodyUsesInfo[playerid][e_Cap][classid];
		}
		case 2: {
			return pBodyUsesInfo[playerid][e_Armour][classid];
		}
	}
	return 0;
}

stock TDM_IsClass(classid)
{
	if (classid < 0
	|| classid >= TDM_MAX_PLAYER_CLASSES) {
		return 0;
	}
	return 1;
}

stock TDM_ResetDialogClassAbils(playerid)
{
	n_for(i, TDM_MAX_CLASS_ABILITIES) {
		DialogListClassAbils[playerid][i] = -1;
	}
	return 1;
}

stock TDM_UpdateTimePlayerClass(playerid)
{
	if (Mode_GetPlayerMode(playerid) != MODE_TDM) {
		return 1;
	}

	new
		classid = GetPlayerCustomClass(playerid);

	if (classid == -1) {
		return 1;
	}

	if (pStatsInfo[playerid][e_Minutes][classid] < 60) {
		pStatsInfo[playerid][e_Minutes][classid]++;
	}
	else if (pStatsInfo[playerid][e_Minutes][classid] >= 60) {
		pStatsInfo[playerid][e_Hours][classid]++;
		pStatsInfo[playerid][e_Minutes][classid] = 0;
	}
	return 1;
}

stock TDM_DestroyAllClassesAirdrop(sessionid)
{
	// Weapon
	if (AllCauseWeaponCount[sessionid] > 0) {
		n_for(ii, AllCauseWeaponCount[sessionid]) {
			new
				i = AllCauseWeaponAir[sessionid][ii];

			switch (AirCauseWeapon[i][e_Status]) {
				case 1, 2: {
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectBox]);
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectAir]);
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectSmooke]);
				}
				case 3: {
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectBox]);
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectAir]);
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectSmooke]);
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectParachute]);
				}
				case 4: {
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectBox]);
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectAir]);
					DestroyDynamicObject(AirCauseWeapon[i][e_ObjectSmooke]);
				}
			}

			if (AirCauseWeapon[i][e_Action]) {
				DestroyDynamic3DTextLabel(AirCauseWeapon[i][e_3DText]);
			}
		}
	}
	ResetAllClassAirdrop(sessionid, TDM_AIR_WEAPON, -1, true);

	// Medication
	if (AllCauseMedicationCount[sessionid] > 0) {
		n_for(ii, AllCauseMedicationCount[sessionid]) {
			new 
				i = AllCauseMedicationAir[sessionid][ii];

			switch (AirCauseMedication[i][e_Status]) {
				case 1, 2: {
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectBox]);
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectAir]);
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectSmooke]);
				}
				case 3: {
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectBox]);
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectAir]);
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectSmooke]);
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectParachute]);
				}
				case 4: {
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectBox]);
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectAir]);
					DestroyDynamicObject(AirCauseMedication[i][e_ObjectSmooke]);
				}
			}
			if (AirCauseMedication[i][e_Action]) {
				DestroyDynamic3DTextLabel(AirCauseMedication[i][e_3DText]);
			}
		}
	}
	ResetAllClassAirdrop(sessionid, TDM_AIR_MEDICAMENT, -1, true);

	// Ammo
	if (AllCauseAmmoCount[sessionid] > 0) {
		n_for(ii, AllCauseAmmoCount[sessionid]) {
			new 
				i = AllCauseAmmoAir[sessionid][ii];

			switch (AirCauseAmmo[i][e_Status]) {
				case 1, 2: {
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectBox]);
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectAir]);
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectSmooke]);
				}
				case 3: {
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectBox]);
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectAir]);
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectSmooke]);
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectParachute]);
				}
				case 4: {
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectBox]);
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectAir]);
					DestroyDynamicObject(AirCauseAmmo[i][e_ObjectSmooke]);
				}
			}
			if (AirCauseAmmo[i][e_Action]) {
				DestroyDynamic3DTextLabel(AirCauseAmmo[i][e_3DText]);
			}
		}
	}
	ResetAllClassAirdrop(sessionid, TDM_AIR_AMMO, -1, true);
	return 1;
}

stock TDM_UpdateClassesAirdrop(sessionid)
{
	// Weapon
	if (AllCauseWeaponCount[sessionid] > 0) {
		r_for(ii, AllCauseWeaponCount[sessionid]) {
			new 
				i = AllCauseWeaponAir[sessionid][ii];

			switch (AirCauseWeapon[i][e_Status]) {
				// Undocking
				case 1: {
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirCauseWeapon[i][e_ObjectAir], ax, ay, az);
					if (ay > (AirCauseWeapon[i][e_PosY] - 50.0)) {
						AirCauseWeapon[i][e_Status] = 2;
						new
							Float:bx,
							Float:by,
							Float:bz;

						GetDynamicObjectPos(AirCauseWeapon[i][e_ObjectBox], bx, by, bz);
						StopDynamicObject(AirCauseWeapon[i][e_ObjectBox]);
						MoveDynamicObject(AirCauseWeapon[i][e_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
					}
				}
				// Falling towards the goal
				case 2: {
					AirCauseWeapon[i][e_Status] = 3;
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseWeapon[i][e_ObjectBox], bx, by, bz);

					AirCauseWeapon[i][e_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirCauseWeapon[i][e_VirtualWorld], AirCauseWeapon[i][e_Interior]);

					StopDynamicObject(AirCauseWeapon[i][e_ObjectBox]);
					MoveDynamicObject(AirCauseWeapon[i][e_ObjectBox], AirCauseWeapon[i][e_PosX] - 0.80000, AirCauseWeapon[i][e_PosY], AirCauseWeapon[i][e_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
					MoveDynamicObject(AirCauseWeapon[i][e_ObjectParachute], AirCauseWeapon[i][e_PosX] - 0.80000 + 0.0203, AirCauseWeapon[i][e_PosY] - 0.0138, AirCauseWeapon[i][e_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
					Mode_StreamerUpdate(MODE_TDM, sessionid);
				}
				// Stopping at the target
				case 3: {
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseWeapon[i][e_ObjectBox], bx, by, bz);
					if ((bx == AirCauseWeapon[i][e_PosX] - 0.80000) 
					&& (by == AirCauseWeapon[i][e_PosY]) 
					&& (bz == AirCauseWeapon[i][e_PosZ] - 0.30000)) {
						AirCauseWeapon[i][e_Status] = 4;
						AirCauseWeapon[i][e_Timer] = TDM_AIR_C_TIMER_WEAPON;
						AirCauseWeapon[i][e_Action] = true;

						DestroyDynamicObject(AirCauseWeapon[i][e_ObjectParachute]);
	/*
						AirCauseWeapon[i][e_ObjectWeapon][0] = CreateDynamicObject(356, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][e_ObjectWeapon][1] = CreateDynamicObject(2358, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][e_ObjectWeapon][2] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][e_ObjectWeapon][3] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][e_ObjectWeapon][4] = CreateDynamicObject(348, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][e_ObjectWeapon][5] = CreateDynamicObject(353, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][e_ObjectWeapon][6] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][e_ObjectWeapon][7] = CreateDynamicObject(342, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][e_ObjectWeapon][8] = CreateDynamicObject(342, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AttachDynamicObjectToObject(AirCauseWeapon[i][e_ObjectWeapon][8], AirCauseWeapon[i][e_ObjectBox], -0.1382, 0.0026, 0.8000, 0.0000, 0.0000, 50.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][e_ObjectWeapon][7], AirCauseWeapon[i][e_ObjectBox], -0.3000, 0.0000, 0.8000, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][e_ObjectWeapon][6], AirCauseWeapon[i][e_ObjectBox], 0.5976, 0.5976, 0.8799, 0.0000, 0.0000, 70.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][e_ObjectWeapon][5], AirCauseWeapon[i][e_ObjectBox], -0.4000, 0.4000, 0.7500, 80.0000, 0.0000, 90.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][e_ObjectWeapon][4], AirCauseWeapon[i][e_ObjectBox], 0.1000, -0.1732, 0.7500, 90.0000, 0.0000, 30.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][e_ObjectWeapon][3], AirCauseWeapon[i][e_ObjectBox], -0.0867, 0.4924, 0.8798, 0.0000, 0.0000, 80.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][e_ObjectWeapon][2], AirCauseWeapon[i][e_ObjectBox], 0.5160, -0.3343, 0.8798, 0.0000, 0.0000, -50.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][e_ObjectWeapon][1], AirCauseWeapon[i][e_ObjectBox], -0.4000, -0.5999, 0.8500, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][e_ObjectWeapon][0], AirCauseWeapon[i][e_ObjectBox], -0.5000, -0.3000, 0.8000, 50.0000, 0.0000, 0.0000, 1);
	*/
						Show3DTextAirCauseWeapon(i, bx, by, bz);
					}
				}
				// Delete
				case 4: {
					if (AirCauseWeapon[i][e_Timer] > 0) {
						AirCauseWeapon[i][e_Timer]--;
					}
					else {
						DestroyDynamic3DTextLabel(AirCauseWeapon[i][e_3DText]);
						DestroyDynamicObject(AirCauseWeapon[i][e_ObjectSmooke]);
						DestroyDynamicObject(AirCauseWeapon[i][e_ObjectBox]);
						DestroyDynamicObject(AirCauseWeapon[i][e_ObjectAir]);

						ResetAllClassAirdrop(sessionid, TDM_AIR_WEAPON, i, false);

						//for (new w = 0; w < TDM_AIR_C_MAX_OBJ_WEAPON; w++) DestroyDynamicObject(AirCauseWeapon[i][e_ObjectWeapon][w]);

						if (AllCauseWeaponCount[sessionid] > 0) 
							AllCauseWeaponCount[sessionid]--;

						AllCauseWeaponAir[sessionid][ii] = AllCauseWeaponAir[sessionid][AllCauseWeaponCount[sessionid]];
						AllCauseWeaponAir[sessionid][AllCauseWeaponCount[sessionid]] = -1;
					}
				}
			}
		}
	}

	// Medication
	if (AllCauseMedicationCount[sessionid] > 0) {
		r_for(ii, AllCauseMedicationCount[sessionid]) {
			new 
				i = AllCauseMedicationAir[sessionid][ii];

			switch (AirCauseMedication[i][e_Status]) {
				// Отстыковка
				case 1: {
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirCauseMedication[i][e_ObjectAir], ax, ay, az);
					if (ay > (AirCauseMedication[i][e_PosY] - 50.0)) {
						AirCauseMedication[i][e_Status] = 2;
						new
							Float:bx,
							Float:by,
							Float:bz;

						GetDynamicObjectPos(AirCauseMedication[i][e_ObjectBox], bx, by, bz);
						StopDynamicObject(AirCauseMedication[i][e_ObjectBox]);
						MoveDynamicObject(AirCauseMedication[i][e_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
					}
				}
				// Падение к цели
				case 2: {
					AirCauseMedication[i][e_Status] = 3;
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseMedication[i][e_ObjectBox], bx, by, bz);

					AirCauseMedication[i][e_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirCauseMedication[i][e_VirtualWorld], AirCauseMedication[i][e_Interior]);

					StopDynamicObject(AirCauseMedication[i][e_ObjectBox]);
					MoveDynamicObject(AirCauseMedication[i][e_ObjectBox], AirCauseMedication[i][e_PosX] - 0.80000, AirCauseMedication[i][e_PosY], AirCauseMedication[i][e_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
					MoveDynamicObject(AirCauseMedication[i][e_ObjectParachute], AirCauseMedication[i][e_PosX] - 0.80000 + 0.0203, AirCauseMedication[i][e_PosY] - 0.0138, AirCauseMedication[i][e_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
					Mode_StreamerUpdate(MODE_TDM, sessionid);
				}
				// Остановка у цели
				case 3: {
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseMedication[i][e_ObjectBox], bx, by, bz);
					if ((bx == AirCauseMedication[i][e_PosX] - 0.80000) 
					&& (by == AirCauseMedication[i][e_PosY]) 
					&& (bz == AirCauseMedication[i][e_PosZ] - 0.30000)) {
						AirCauseMedication[i][e_Status] = 4;
						AirCauseMedication[i][e_Timer] = TDM_AIR_C_TIMER_MEDICAMENT;
						AirCauseMedication[i][e_Action] = true;

						DestroyDynamicObject(AirCauseMedication[i][e_ObjectParachute]);
	/*
						AirCauseMedication[i][Air_ObjectMedicament][0] = CreateDynamicObject(11738, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][1] = CreateDynamicObject(11736, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][2] = CreateDynamicObject(11736, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][3] = CreateDynamicObject(11738, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][4] = CreateDynamicObject(11738, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][5] = CreateDynamicObject(11736, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][6] = CreateDynamicObject(11738, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][6], AirCauseMedication[i][e_ObjectBox], 0.0000, 0.0000, 0.7760, 0.0000, 0.0000, 20.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][5], AirCauseMedication[i][e_ObjectBox], 0.4000, 0.1732, 0.7749, 0.0000, 0.0000, -30.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][4], AirCauseMedication[i][e_ObjectBox], 0.4247, 0.6343, 0.7760, 0.0000, 0.0000, -50.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][3], AirCauseMedication[i][e_ObjectBox], -0.7000, 0.2000, 0.7760, 0.0000, 0.0000, 90.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][2], AirCauseMedication[i][e_ObjectBox], -0.1999, 0.3999, 0.7760, 0.0000, 0.0000, 10.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][1], AirCauseMedication[i][e_ObjectBox], -0.2794, -0.4160, 0.7749, 0.0000, 0.0000, 30.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][0], AirCauseMedication[i][e_ObjectBox], 0.5830, -0.4169, 0.7799, 0.0000, 0.0000, 60.0000, 1);
	*/
						Show3DTextAirCauseMedication(i, bx, by, bz);
					}
				}
				// Удаление
				case 4: {
					if (AirCauseMedication[i][e_Timer] > 0) {
						AirCauseMedication[i][e_Timer]--;
					}
					else {
						DestroyDynamic3DTextLabel(AirCauseMedication[i][e_3DText]);
						DestroyDynamicObject(AirCauseMedication[i][e_ObjectSmooke]);
						DestroyDynamicObject(AirCauseMedication[i][e_ObjectBox]);
						DestroyDynamicObject(AirCauseMedication[i][e_ObjectAir]);

						ResetAllClassAirdrop(sessionid, TDM_AIR_MEDICAMENT, i, false);

						//for (new w = 0; w < TDM_AIR_C_MAX_OBJECT_MEDICAMENT; w++) DestroyDynamicObject(AirCauseMedication[i][Air_ObjectMedicament][w]);

						if (AllCauseMedicationCount[sessionid] > 0) 
							AllCauseMedicationCount[sessionid]--;
							
						AllCauseMedicationAir[sessionid][ii] = AllCauseMedicationAir[sessionid][AllCauseMedicationCount[sessionid]];
						AllCauseMedicationAir[sessionid][AllCauseMedicationCount[sessionid]] = -1;
					}
				}
			}
		}
	}

	// Ammo
	if (AllCauseAmmoCount[sessionid] > 0) {
		r_for(ii, AllCauseAmmoCount[sessionid]) {
			new 
				i = AllCauseAmmoAir[sessionid][ii];

			switch (AirCauseAmmo[i][e_Status]) {
				// Отстыковка
				case 1: {
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirCauseAmmo[i][e_ObjectAir], ax, ay, az);
					if (ay > (AirCauseAmmo[i][e_PosY] - 50.0)) {
						AirCauseAmmo[i][e_Status] = 2;
						new
							Float:bx,
							Float:by,
							Float:bz;

						GetDynamicObjectPos(AirCauseAmmo[i][e_ObjectBox], bx, by, bz);
						StopDynamicObject(AirCauseAmmo[i][e_ObjectBox]);
						MoveDynamicObject(AirCauseAmmo[i][e_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
					}
				}
				// Падение к цели
				case 2: {
					AirCauseAmmo[i][e_Status] = 3;
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseAmmo[i][e_ObjectBox], bx, by, bz);

					AirCauseAmmo[i][e_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirCauseAmmo[i][e_VirtualWorld], AirCauseAmmo[i][e_Interior]);

					StopDynamicObject(AirCauseAmmo[i][e_ObjectBox]);
					MoveDynamicObject(AirCauseAmmo[i][e_ObjectBox], AirCauseAmmo[i][e_PosX] - 0.80000, AirCauseAmmo[i][e_PosY], AirCauseAmmo[i][e_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
					MoveDynamicObject(AirCauseAmmo[i][e_ObjectParachute], AirCauseAmmo[i][e_PosX] - 0.80000 + 0.0203, AirCauseAmmo[i][e_PosY] - 0.0138, AirCauseAmmo[i][e_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
					Mode_StreamerUpdate(MODE_TDM, sessionid);
				}
				// Остановка у цели
				case 3: {
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseAmmo[i][e_ObjectBox], bx, by, bz);
					if ((bx == AirCauseAmmo[i][e_PosX] - 0.80000) 
					&& (by == AirCauseAmmo[i][e_PosY]) 
					&& (bz == AirCauseAmmo[i][e_PosZ] - 0.30000)) {
						AirCauseAmmo[i][e_Status] = 4;
						AirCauseAmmo[i][e_Timer] = TDM_AIR_C_TIMER_AMMO;
						AirCauseAmmo[i][e_Action] = true;

						DestroyDynamicObject(AirCauseAmmo[i][e_ObjectParachute]);
	/*
						AirCauseAmmo[i][Air_ObjectAmmo][0] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][1] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][2] = CreateDynamicObject(2358, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][3] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][4] = CreateDynamicObject(2359, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][5] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][5], AirCauseAmmo[i][e_ObjectBox], -0.4576, -0.1101, 0.8799, 0.0000, 0.0000, 80.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][4], AirCauseAmmo[i][e_ObjectBox], -0.3342, 0.4939, 0.9499, 0.0000, 0.0000, 20.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][3], AirCauseAmmo[i][e_ObjectBox], 0.4519, -0.4110, 0.8799, 0.0000, 0.0000, -50.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][2], AirCauseAmmo[i][e_ObjectBox], -0.4000, -0.5999, 0.8500, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][1], AirCauseAmmo[i][e_ObjectBox], 0.4767, 0.6133, 1.1399, 0.0000, 0.0000, 30.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][0], AirCauseAmmo[i][e_ObjectBox], 0.4999, 0.6000, 0.8899, 0.0000, 0.0000, 0.0000, 1);
	*/
						Show3DTextAirCauseAmmo(i, bx, by, bz);
					}
				}
				// Удаление
				case 4: {
					if (AirCauseAmmo[i][e_Timer] > 0) {
						AirCauseAmmo[i][e_Timer]--;
					}
					else {
						DestroyDynamic3DTextLabel(AirCauseAmmo[i][e_3DText]);
						DestroyDynamicObject(AirCauseAmmo[i][e_ObjectSmooke]);
						DestroyDynamicObject(AirCauseAmmo[i][e_ObjectBox]);
						DestroyDynamicObject(AirCauseAmmo[i][e_ObjectAir]);

						ResetAllClassAirdrop(sessionid, TDM_AIR_AMMO, i, false);

						//for (new w = 0; w < TDM_AIR_C_MAX_OBJECT_AMMO; w++) DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectAmmo][w]);

						if (AllCauseAmmoCount[sessionid] > 0) 
							AllCauseAmmoCount[sessionid]--;

						AllCauseAmmoAir[sessionid][ii] = AllCauseAmmoAir[sessionid][AllCauseAmmoCount[sessionid]];
						AllCauseAmmoAir[sessionid][AllCauseAmmoCount[sessionid]] = -1;
					}
				}
			}
		}
	}
	return 1;
}

stock TDM_UpPlayerClassesAirdrop(playerid)
{
	// Airdrop medication
	if (PlayerAirMedicationID[playerid] > -1) {
		new
			id = PlayerAirMedicationID[playerid];

		if (IsPlayerInRangeOfPoint(playerid, 5.0, AirCauseMedication[id][e_PosX], AirCauseMedication[id][e_PosY], AirCauseMedication[id][e_PosZ])) {
			new
				Float:health;

			GetPlayerHealthEx(playerid, health);
			if (health < 100.0) {
				new
					str[50];

				switch (AirCauseMedication[id][e_Type]) {
					case 1: {
						SetPlayerHealthEx(playerid, health + TDM_AIR_C_SMALL_BOARD_MEDICAMENT);
						f(str, "\n~n~\n~n~\n~n~\n~n~~r~+%i", TDM_AIR_C_SMALL_BOARD_MEDICAMENT);
						GameTextForPlayer(playerid, str, 500, 5);
					}
					case 2: {
						SetPlayerHealthEx(playerid, health + TDM_AIR_C_MIDDLE_BOARD_MEDICAMENT);
						f(str, "\n~n~\n~n~\n~n~\n~n~~r~+%i", TDM_AIR_C_MIDDLE_BOARD_MEDICAMENT);
						GameTextForPlayer(playerid, str, 500, 5);
					}
					case 3: {
						SetPlayerHealthEx(playerid, health + TDM_AIR_C_LARGE_BOARD_MEDICAMENT);
						f(str, "\n~n~\n~n~\n~n~\n~n~~r~+%i", TDM_AIR_C_LARGE_BOARD_MEDICAMENT);
						GameTextForPlayer(playerid, str, 500, 5);
					}
				}
			}
		}
		else
			PlayerAirMedicationID[playerid] = -1;
	}

	// Airdrop ammo
	if (PlayerAirMedicationID[playerid] > -1) {
		new
			id = PlayerAirMedicationID[playerid];

		if (IsPlayerInRangeOfPoint(playerid, 5.0, AirCauseAmmo[id][e_PosX], AirCauseAmmo[id][e_PosY], AirCauseAmmo[id][e_PosZ])) {
			new
				weapon[7];

			weapon[0] = 2 + AirCauseAmmo[id][e_Type]; // Пистолеты
			weapon[1] = 1 + AirCauseAmmo[id][e_Type]; // Дробовики
			weapon[2] = 3 + AirCauseAmmo[id][e_Type]; // Узи, MP5, Тек9
			weapon[3] = 1 + AirCauseAmmo[id][e_Type]; // M4, AK-47
			weapon[4] = 0 + AirCauseAmmo[id][e_Type]; // Винтовки
			weapon[5] = 0 + AirCauseAmmo[id][e_Type]; // РПГ, Миниган
			weapon[6] = 0 + AirCauseAmmo[id][e_Type]; // Гранаты

			new
				WEAPON:weaponid = GetPlayerWeapon(playerid),
				string[60];

			switch (weaponid) {
				// Пистолеты
			case 22..24: {
					GivePlayerWeaponEx(playerid, weaponid, weapon[0]);
					f(string, "\n~n~\n~n~\n~n~~y~+%i", weapon[0]);
					GameTextForPlayer(playerid, string, 500, 5);
				}
				// Дробовики
			case 25..27: {
					GivePlayerWeaponEx(playerid, weaponid, weapon[1]);
					f(string, "\n~n~\n~n~\n~n~~y~+%i", weapon[1]);
					GameTextForPlayer(playerid, string, 500, 5);
				}
				// Узи, MP5, Тек9
			case 28, 29, 32: {
					GivePlayerWeaponEx(playerid, weaponid, weapon[2]);
					f(string, "\n~n~\n~n~\n~n~~y~+%i", weapon[2]);
					GameTextForPlayer(playerid, string, 500, 5);
				}
				// M4, AK-47
			case 30, 31: {
					GivePlayerWeaponEx(playerid, weaponid, weapon[3]);
					f(string, "\n~n~\n~n~\n~n~~y~+%i", weapon[3]);
					GameTextForPlayer(playerid, string, 500, 5);
				}
				// Винтовки
			case 33, 34: {
					GivePlayerWeaponEx(playerid, weaponid, weapon[4]);
					f(string, "\n~n~\n~n~\n~n~~y~+%i", weapon[4]);
					GameTextForPlayer(playerid, string, 500, 5);
				}
				// РПГ, Миниган
			case 35..38: {
					GivePlayerWeaponEx(playerid, weaponid, weapon[5]);

					f(string, "\n~n~\n~n~\n~n~~y~+%i", weapon[5]);
					GameTextForPlayer(playerid, string, 500, 5);
				}
				// Гранаты
			case 16..18, 39: {
					GivePlayerWeaponEx(playerid, weaponid, weapon[6]);
					f(string, "\n~n~\n~n~\n~n~~y~+%i", weapon[6]);
					GameTextForPlayer(playerid, string, 500, 5);
				}
			}
		}
		else {
			PlayerAirAmmoID[playerid] = -1;
		}
	}
	return 1;
}

stock TDM_SetPlayerClassAmmunition(playerid)
{
	new
		classid = GetPlayerCustomClass(playerid),
		teamid = GetPlayerTeamEx(playerid),
		sexid = GetPlayerSex(playerid);

	new
		Float:needHealth,
		Float:needArmour;

	TDM_GetClassNeed(classid, TDM_CLASS_NEED_HEALTH, needHealth);
	TDM_GetClassNeed(classid, TDM_CLASS_NEED_ARMOUR, needArmour);

	SetPlayerHealthEx(playerid, needHealth);
	SetPlayerArmourEx(playerid, needArmour);

	SetPlayerSkinEx(playerid, TDM_GetClassSkin(teamid, classid, sexid));

	n_for(w, TDM_CLASS_MAX_WEAPONS) {
		GivePlayerWeaponEx(playerid, WEAPON:pWeaponInfo[playerid][e_Weapon][classid][w], pWeaponInfo[playerid][e_Ammo][classid][w]);
	}

	SetPlayerAttachInvItem(playerid);
	SetPlayerAttachItem(playerid, GetPlayerSkinEx(playerid), pBodyUsesInfo[playerid][e_Cap][classid], pBodyUsesInfo[playerid][e_Armour][classid], GetPlayerInvHead(playerid));
	return 1;
}

static SetPlayerAttachItem(playerid, skinid, cap, armor, head)
{
	if (cap) {
		switch (skinid) {
			case 50: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.185000, -0.049000, -0.000000, -0.100000, -2.599998, -10.700004, 0.977999, 1.005000, 1.064999);
			case 70: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.149000, -0.000000, 0.006999, -0.900000, 0.200001, -10.500004, 0.974000, 0.981999, 1.046999);
			case 93: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.157000, -0.010000, 0.001999, -5.100000, 0.600000, -6.600002, 1.146001, 1.013999, 1.110999);
			case 100: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.161000, -0.029000, 0.000999, -0.900000, 0.000001, -16.300012, 0.974000, 1.073999, 1.115999);
			case 112: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.130999, -0.000000, -0.003000, -0.900000, 0.200001, -10.500004, 0.974000, 0.918999, 1.046999);
			case 122: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.134000, -0.015000, 0.000999, -0.900000, 0.000001, -16.300012, 0.974000, 1.033999, 1.045999);
			case 124: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.172999, -0.016000, 0.002999, -0.100000, -0.899998, -12.700006, 0.977999, 0.993000, 1.050999);
			case 179: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.112000, 0.000000, 0.000000, 0.000000, 0.000000, -9.900002, 1.000000, 1.000000, 1.125999);
			case 180: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.159000, -0.002000, -0.006000, -0.900000, 0.200001, -10.500004, 0.974000, 1.108999, 1.156999);
			case 190: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.170000, -0.016000, -0.000000, -0.900000, 0.200001, -10.500004, 0.977999, 1.098000, 1.050999);
			case 191: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.121999, -0.004000, -0.000999, 0.000000, 0.000000, 0.000000, 1.161000, 1.265000, 1.121001);
			case 192: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.161000, -0.029000, -0.001000, -0.900000, 0.000001, -16.300012, 0.974000, 1.138999, 1.115999);
			case 193: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.172999, -0.017000, 0.002999, -0.100000, -0.899998, -12.700006, 0.977999, 0.993000, 1.050999);
			case 195: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.178000, -0.023000, 0.000999, -5.100000, 0.600000, -6.600002, 1.270000, 1.162999, 1.163000);
			case 226: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.135000, -0.029000, -0.001000, -0.900000, 0.000001, -16.300012, 0.974000, 1.138999, 1.115999);
			case 248: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.195000, -0.009000, 0.000999, -5.100000, 0.600000, -6.600002, 1.270000, 1.162999, 1.163000);
			case 274: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.155000, -0.001000, 0.000999, -0.900000, 0.000001, -6.100005, 0.974000, 0.911999, 1.099999);
			case 275: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.156999, -0.002999, 0.001999, 0.000000, -1.399999, -8.900001, 1.000000, 0.905000, 1.000000);
			case 276: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.106999, 0.000000, 0.000999, 0.000000, 0.000000, 0.000000, 1.020000, 1.000000, 1.028000);
			case 287: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.086000, 0.013999, 0.006999, 0.000000, 0.000000, 0.000000, 1.097001, 1.000000, 1.087001);
			case 298: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.157000, -0.010000, -0.001000, -5.100000, 0.600000, -6.600002, 1.146001, 1.013999, 1.110999);
			case 299: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.179000, 0.005999, 0.000999, -0.900000, 0.000001, -9.399998, 1.147000, 1.118999, 1.163000);
			case 300: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.103000, 0.000000, 0.003000, -3.099999, -2.699999, -12.100000, 1.084000, 1.000000, 1.090000);
			case 303: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.156999, -0.002999, 0.001999, 0.000000, -1.399999, -8.900001, 1.000000, 0.905000, 1.000000);
			case 306: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.121999, -0.004000, -0.000999, 0.000000, 0.000000, 0.000000, 1.161000, 1.265000, 1.121001);
			case 308: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.147999, -0.007000, -0.000000, -0.900000, -0.899998, -5.400003, 0.977999, 1.053000, 1.050999);
			case 309: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.121999, -0.004000, -0.000999, 0.000000, 0.000000, 0.000000, 1.161000, 1.265000, 1.121001);
			default: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.086000, 0.013999, 0.006999, 0.000000, 0.000000, 0.000000, 1.097001, 1.000000, 1.087001);
		}
	}
	else {
		if (!head) {
			if (IsPlayerAttachedObjectSlotUsed(playerid, 0)) {
				RemovePlayerAttachedObject(playerid, 0);
			}
		}
	}
	if (armor) {
		switch (skinid) {
			case 50: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.108000, 0.056999, -0.003000, -2.099999, -1.099999, -3.299996, 0.983000, 1.246002, 1.167999);
			case 70: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.075000, 0.045999, 0.010000, -2.099999, -1.099999, 4.700003, 1.040000, 1.175000, 1.130999);
			case 93: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.063000, 0.060999, 0.001999, -2.099999, -1.099999, -3.999997, 1.106000, 1.027001, 1.037999);
			case 100: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.076000, 0.053999, -0.000000, -2.099999, -1.099999, -1.899997, 1.040000, 1.252000, 1.130999);
			case 112: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.052000, 0.060999, -0.000000, -2.099999, -1.099999, -5.199995, 1.040000, 1.238999, 1.130999);
			case 122: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.067000, 0.061999, -0.000000, -2.099999, -1.099999, -5.199995, 1.040000, 1.139999, 1.130999);
			case 124: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.101000, 0.067999, 0.001999, -2.099999, -1.099999, -3.299996, 0.983000, 1.071001, 1.118000);
			case 179: SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.082000, 0.052000, -0.005000, -1.399995, -2.799999, 0.599994, 1.057999, 1.292999, 1.133001);
			case 180: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.076000, 0.065999, -0.000000, -2.099999, -1.099999, -1.899997, 1.040000, 1.403000, 1.130999);
			case 190: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.106000, 0.054999, 0.001999, -2.099999, -1.099999, 4.700003, 1.040000, 1.225000, 1.083999);
			case 191: SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.103999, 0.056999, 0.005999, 0.000000, 0.000000, 0.000000, 1.000000, 1.047999, 0.982000);
			case 192: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.093000, 0.061999, 0.001999, -2.099999, -1.099999, 4.700003, 1.040000, 1.137000, 1.083999);
			case 193: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.096000, 0.048999, 0.001999, -2.099999, -1.099999, 4.700003, 1.040000, 1.054000, 1.083999);
			case 195: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.094000, 0.074999, 0.001999, -2.099999, -1.099999, -3.999997, 1.065000, 1.060001, 1.130999);
			case 226: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.068000, 0.056999, 0.001999, -2.099999, -1.099999, 4.700003, 1.040000, 1.042001, 1.083999);
			case 248: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.061000, 0.059999, 0.001999, -2.099999, -1.099999, -3.999997, 1.065000, 1.218001, 1.130999);
			case 274: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.075000, 0.043999, 0.007000, -2.099999, -1.099999, -1.899997, 1.040000, 1.252000, 1.130999);
			case 275: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.101000, 0.041999, 0.007000, -2.099999, -1.099999, -2.899996, 0.983000, 1.162001, 1.168000);
			case 276: SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.084999, 0.039000, -0.002000, 0.000000, -2.800000, -2.400000, 1.074000, 1.229999, 1.224000);
			case 287: SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.084000, 0.043000, 0.019000, -0.200011, -2.599999, -2.199999, 1.011000, 1.207003, 1.166001);
			case 298: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.063000, 0.056999, 0.001999, -2.099999, -1.099999, -3.999997, 1.106000, 1.074001, 1.037999);
			case 299: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.101000, 0.061999, 0.007000, -2.099999, -1.099999, -1.899997, 1.040000, 1.347000, 1.130999);
			case 300: SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.085999, 0.049999, 0.005999, 0.000000, 0.000000, 0.000000, 1.000000, 1.126000, 1.000000);
			case 303: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.074999, 0.042000, 0.012000, 0.000000, -0.000000, 0.999999, 1.036000, 1.227000, 1.124000);
			case 306: SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.085999, 0.056999, 0.005999, 0.000000, 0.000000, 0.000000, 1.000000, 0.998999, 1.000000);
			case 308: SetPlayerAttachedObject(playerid, 5, 19515, 1, 0.083000, 0.052999, 0.001999, -2.099999, -1.099999, 4.700003, 1.040000, 1.042001, 1.083999);
			case 309: SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.103999, 0.056999, 0.005999, 0.000000, 0.000000, 0.000000, 1.000000, 1.047999, 0.982000);
			default: SetPlayerAttachedObject(playerid, 5, 19142, 1, 0.084000, 0.043000, 0.019000, -0.200011, -2.599999, -2.199999, 1.011000, 1.207003, 1.166001);
		}
	}
	else {
		if (IsPlayerAttachedObjectSlotUsed(playerid, 5)) {
			RemovePlayerAttachedObject(playerid, 5);
		}
	}
	return 1;
}

stock TDM_PlayerClassAttachHead(playerid)
{
	new
		classid = GetPlayerCustomClass(playerid);

	if (classid != -1) {
		if (pBodyUsesInfo[playerid][e_Cap][classid]) {
			RemovePlayerAttachedObject(playerid, 0);

			switch (GetPlayerSkinEx(playerid)) {
				case 50: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.185000, -0.049000, -0.000000, -0.100000, -2.599998, -10.700004, 0.977999, 1.005000, 1.064999);
				case 70: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.149000, -0.000000, 0.006999, -0.900000, 0.200001, -10.500004, 0.974000, 0.981999, 1.046999);
				case 93: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.157000, -0.010000, 0.001999, -5.100000, 0.600000, -6.600002, 1.146001, 1.013999, 1.110999);
				case 100: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.161000, -0.029000, 0.000999, -0.900000, 0.000001, -16.300012, 0.974000, 1.073999, 1.115999);
				case 112: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.130999, -0.000000, -0.003000, -0.900000, 0.200001, -10.500004, 0.974000, 0.918999, 1.046999);
				case 122: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.134000, -0.015000, 0.000999, -0.900000, 0.000001, -16.300012, 0.974000, 1.033999, 1.045999);
				case 124: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.172999, -0.016000, 0.002999, -0.100000, -0.899998, -12.700006, 0.977999, 0.993000, 1.050999);
				case 179: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.112000, 0.000000, 0.000000, 0.000000, 0.000000, -9.900002, 1.000000, 1.000000, 1.125999);
				case 180: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.159000, -0.002000, -0.006000, -0.900000, 0.200001, -10.500004, 0.974000, 1.108999, 1.156999);
				case 190: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.170000, -0.016000, -0.000000, -0.900000, 0.200001, -10.500004, 0.977999, 1.098000, 1.050999);
				case 191: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.121999, -0.004000, -0.000999, 0.000000, 0.000000, 0.000000, 1.161000, 1.265000, 1.121001);
				case 192: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.161000, -0.029000, -0.001000, -0.900000, 0.000001, -16.300012, 0.974000, 1.138999, 1.115999);
				case 193: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.172999, -0.017000, 0.002999, -0.100000, -0.899998, -12.700006, 0.977999, 0.993000, 1.050999);
				case 195: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.178000, -0.023000, 0.000999, -5.100000, 0.600000, -6.600002, 1.270000, 1.162999, 1.163000);
				case 226: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.135000, -0.029000, -0.001000, -0.900000, 0.000001, -16.300012, 0.974000, 1.138999, 1.115999);
				case 248: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.195000, -0.009000, 0.000999, -5.100000, 0.600000, -6.600002, 1.270000, 1.162999, 1.163000);
				case 274: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.155000, -0.001000, 0.000999, -0.900000, 0.000001, -6.100005, 0.974000, 0.911999, 1.099999);
				case 275: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.156999, -0.002999, 0.001999, 0.000000, -1.399999, -8.900001, 1.000000, 0.905000, 1.000000);
				case 276: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.106999, 0.000000, 0.000999, 0.000000, 0.000000, 0.000000, 1.020000, 1.000000, 1.028000);
				case 287: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.086000, 0.013999, 0.006999, 0.000000, 0.000000, 0.000000, 1.097001, 1.000000, 1.087001);
				case 298: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.157000, -0.010000, -0.001000, -5.100000, 0.600000, -6.600002, 1.146001, 1.013999, 1.110999);
				case 299: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.179000, 0.005999, 0.000999, -0.900000, 0.000001, -9.399998, 1.147000, 1.118999, 1.163000);
				case 300: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.103000, 0.000000, 0.003000, -3.099999, -2.699999, -12.100000, 1.084000, 1.000000, 1.090000);
				case 303: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.156999, -0.002999, 0.001999, 0.000000, -1.399999, -8.900001, 1.000000, 0.905000, 1.000000);
				case 306: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.121999, -0.004000, -0.000999, 0.000000, 0.000000, 0.000000, 1.161000, 1.265000, 1.121001);
				case 308: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.147999, -0.007000, -0.000000, -0.900000, -0.899998, -5.400003, 0.977999, 1.053000, 1.050999);
				case 309: SetPlayerAttachedObject(playerid, 0, 19141, 2, 0.121999, -0.004000, -0.000999, 0.000000, 0.000000, 0.000000, 1.161000, 1.265000, 1.121001);
				default: SetPlayerAttachedObject(playerid, 0, 19107, 2, 0.086000, 0.013999, 0.006999, 0.000000, 0.000000, 0.000000, 1.097001, 1.000000, 1.087001);
			}
		}
	}
	return 1;
}

stock TDM_UpdatePlayerClassesData(playerid)
{
	if (PlayerAbilTimerVehicle[playerid] > 0) {
		PlayerAbilTimerVehicle[playerid]--;
	}

	if (PlayerAbilTimerMedicHP[playerid] > 0) {
		PlayerAbilTimerMedicHP[playerid]--;
	}
	return 1;
}

stock TDM_CallPlayerClassCommand(playerid, const cmdName[], const params[])
{
	if (!strcmp(cmdName, "rep", true)) {
		ClassRepairPlayerVehicle(playerid);
		return 1;
	}

	if (!strcmp(cmdName, "hp", true)) {
		ClassGivePlayerHealth(playerid, params);
		return 1;
	}
	return 1;
}

static ClassRepairPlayerVehicle(playerid)
{
	if (GetPlayerCustomClass(playerid) != TDM_CLASS_ENGINEER) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Требуется класс "CT_YELLOW"Инженер.");
		return 1;
	}

	if (IsPlayerInAnyVehicle(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В транспорте, чинить невозможно.");
		return 1;
	}

	if (!GetVehicleNearest(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Рядом нет ни одного транспорта.");
		return 1;
	}

	if (PlayerAbilTimerVehicle[playerid] > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Набор для починки ещё не готов.");
		return 1;	
	}

	new
		Float:health;

	GetVehicleHealth(GetVehicleNearest(playerid), health);

	if (health >= 600.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Самый ближний транспорт не очень сильно повреждён.");
		return 1;
	}

	GivePlayerReward(playerid, 100, 50, REWARD_REPAIR_VEHICLE);
	SetVehicleHealth(GetVehicleNearest(playerid), 1000.0);
	PlayerAbilTimerVehicle[playerid] = 10; 
	CheckPlayerQuestProgress(playerid, MODE_TDM, 14);

	ApplyAnimation(playerid, "WEAPONS", "SHP_G_LIFT_IN", 4.1, false, true, false, false, 0, SYNC_ALL);
	SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Транспорт успешно починен.");
	return 1;
}

static ClassGivePlayerHealth(playerid, const params[])
{
	if (GetPlayerCustomClass(playerid) != TDM_CLASS_MEDIC) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Требуется класс медик.");
		return 1;
	}

	new
		playerHP;

	if (sscanf(params, "u", playerHP)) {
		return SendPlayerMessageCMD(playerid, "/hp [id игрока]");
	}

	if (PlayerAbilTimerMedicHP[playerid] > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Набор для лечения ещё не собран.");
		return 1;
	}

	if (playerHP == playerid) {
		return 1;
	}

	if (!ProxDetectorS(3.0, playerid, playerHP)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Союзника рядом нет.");
		return 1;
	}

	if (GetPlayerTeamEx(playerHP) != GetPlayerTeamEx(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в вашей команде.");
		return 1;
	}

	new
		Float:health;

	GetPlayerHealthEx(playerHP, health);

	if (health >= 100.0) {
		return 1;
	}

	SetPlayerHealthEx(playerHP, 100.0);
	GivePlayerReward(playerid, 200, 150, REWARD_REPLENISH_HP);
	PlayerAbilTimerMedicHP[playerid] = 10; 
	CheckPlayerQuestProgress(playerid, MODE_TDM, 12);

	SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Союзник %s "T_PID" здоров!", GetPlayerNameEx(playerHP), playerHP);
	SCM(playerHP, C_GREEN, ""T_INFO" "CT_WHITE"Союзник %s "T_PID" вылечил Вас!", GetPlayerNameEx(playerid), playerid);
	return 1;
}

static SetPlayerClassAbility(playerid, abilityid)
{
	new
		classid = GetPlayerCustomClass(playerid);

	switch (classid) {
		// Assault
		case TDM_CLASS_ASSAULT: {
			switch (abilityid) {
				// Airdrop weapon
				case 0: {
					if (AirCauseWeapon[playerid][e_Status]) {
						Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
						SCM(playerid, C_ORANGE, ""T_AIRDROP" "CT_WHITE"Сейчас запрещено вызывать аирдроп.");
						return 1;
					}
					Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
				}
			}
		}
		// Medic
		case TDM_CLASS_MEDIC: {
			switch (abilityid) {
				// Airdrop medication
				case 0: {
					if (AirCauseMedication[playerid][e_Status]) {
						Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
						SCM(playerid, C_ORANGE, ""T_AIRDROP" "CT_WHITE"Сейчас запрещено вызывать аирдроп.");
						return 1;
					}
					Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
				}
			}
		}
		// Engineer
		case TDM_CLASS_ENGINEER: {
			switch (abilityid) {
				// Airdrop ammo
				case 0: {
					if (AirCauseAmmo[playerid][e_Status]) {
						Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
						SCM(playerid, C_ORANGE, ""T_AIRDROP" "CT_WHITE"Сейчас запрещено вызывать аирдроп.");
						return 1;
					}
					Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
				}
			}
		}
		// Recon
		case TDM_CLASS_RECON: {
			switch (abilityid) {
				// Invisibility on radar
				case 0: {
					if (GetPlayerInvisible(playerid)) {
						Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
						SCM(playerid, C_ORANGE, ""T_ABILITY" "CT_WHITE"Невидимость уже активирована.");
						return 1;
					}

					SetPlayerInvisible(playerid, true);
					SetPlayerColor(playerid, TDM_GetTeamColorXB(GetPlayerTeamEx(playerid)) & 0xFFFFFF00);
					Mode_GivePlayerMatchPoints(playerid, -TDM_GetClassAbilMPoints(classid, abilityid));

					SCM(playerid, C_ORANGE, ""T_ABILITY" "CT_WHITE"Невидимость успешно активирована.");
				}
			}
		}
	}
	return 1;
}

static GetPlayerClassMaxAbils(classid)
{
	new
		maxAbilities;

	switch (classid) {
		case TDM_CLASS_ASSAULT: maxAbilities = TDM_MAX_ASSAULT_ABILS;
		case TDM_CLASS_MEDIC: maxAbilities = TDM_MAX_MEDIC_ABILS;
		case TDM_CLASS_ENGINEER: maxAbilities = TDM_MAX_ENGINEER_ABILS;
		case TDM_CLASS_RECON: maxAbilities = TDM_MAX_RECON_ABILS;
	}
	return maxAbilities;
}

static InitialPlayerClassWeapon(playerid) 
{
	// Assault
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ASSAULT][0] = WEAPON_AK47; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ASSAULT][0] = 150;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ASSAULT][1] = WEAPON_COLT45; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ASSAULT][1] = 30;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ASSAULT][2] = WEAPON_GRENADE; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ASSAULT][2] = 3;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ASSAULT][3] = WEAPON_BRASSKNUCKLE; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ASSAULT][3] = 1;

	// Medic
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_MEDIC][0] = WEAPON_MP5; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_MEDIC][0] = 100;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_MEDIC][1] = WEAPON_COLT45; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_MEDIC][1] = 50;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_MEDIC][2] = WEAPON_TEARGAS; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_MEDIC][2] = 1;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_MEDIC][3] = WEAPON_BAT; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_MEDIC][3] = 1;

	// Engineer
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ENGINEER][0] = WEAPON_AK47; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ENGINEER][0] = 100;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ENGINEER][1] = WEAPON_COLT45; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ENGINEER][1] = 35;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ENGINEER][2] = WEAPON_TEARGAS; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ENGINEER][2] = 2;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ENGINEER][3] = WEAPON_KATANA; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ENGINEER][3] = 1;

	// Recon
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_RECON][0] = WEAPON_SNIPER; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_RECON][0] = 25;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_RECON][1] = WEAPON_COLT45; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_RECON][1] = 40;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_RECON][2] = WEAPON_TEARGAS; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_RECON][2] = 2;
	pWeaponInfo[playerid][e_Weapon][TDM_CLASS_RECON][3] = WEAPON_BRASSKNUCKLE; pWeaponInfo[playerid][e_Ammo][TDM_CLASS_RECON][3] = 1;
	return 1;
}

static ShowInfoClassTD(playerid)
{
	new
		classid = GetPlayerCustomClass2(playerid),
		teamid = GetPlayerTeamEx(playerid),
		sexid = GetPlayerSex(playerid);

	PlayerTextDrawSetString(playerid, TD_SelectedClass[playerid][2], TDM_GetClassName(classid));
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectedClass[playerid][1], TDM_GetClassSkin(teamid, classid, sexid));

	for (new i = 9, w = 0; w < TDM_CLASS_MAX_WEAPONS; i++, w++) {
		PlayerTextDrawSetPreviewModel(playerid, TD_SelectedClass[playerid][i], GetWeaponModelEx(WEAPON:pWeaponInfo[playerid][e_Weapon][classid][w]));
	}
	for (new i = 17, w = 0; w < TDM_CLASS_MAX_WEAPONS; i++, w++) {
		PlayerTextDrawSetString(playerid, TD_SelectedClass[playerid][i], "%i", pWeaponInfo[playerid][e_Ammo][classid][w]);
	}
	return 1;
}

static ShowInfoWeaponTD(playerid)
{
	new
		WEAPON:weapon[TDM_CLASS_MAX_WEAPON_SLOTS],
		classid = GetPlayerCustomClass2(playerid),
		slot = GetPVarInt(playerid, "TDM_SelectClassWeapon") - 1;

	n_for(c, TDM_CLASS_MAX_WEAPON_SLOTS) {
		weapon[c] = TDM_GetClassWeaponID(classid, slot, c);
	}

	for (new td = 3, c = 0; c < TDM_CLASS_MAX_WEAPON_SLOTS; td++, c++) {
		if (weapon[c] != WEAPON_FIST) {
			PlayerTextDrawSetPreviewModel(playerid, TD_SelectWeapon[playerid][td], GetWeaponModelEx(weapon[c]));

			new 
				str[100];

			if (pStatsInfo[playerid][e_Kills][classid] < TDM_GetClassWeaponPrice(classid, slot, c)) {
				f(str, "Требуется~n~%i_убийств", TDM_GetClassWeaponPrice(classid, slot, c));
				PlayerTextDrawColour(playerid, TD_SelectWeapon[playerid][td + 3], -79740929);
			}
			else {
				new
					weaponName[MAX_LENGTH_WEAPON_NAME];

				GetWeaponNameRU(weapon[c], weaponName, MAX_LENGTH_WEAPON_NAME);
				f(str, "~n~%s", weaponName);
				PlayerTextDrawColour(playerid, TD_SelectWeapon[playerid][td + 3], -505290753);
			}
			PlayerTextDrawSetString(playerid, TD_SelectWeapon[playerid][td + 3], str);

			if (WEAPON:pWeaponInfo[playerid][e_Weapon][classid][slot] == weapon[c]) {
				PlayerTextDrawBackgroundColour(playerid, TD_SelectWeapon[playerid][td - 3], 0x3cba40FF);
			}
			else { 
				PlayerTextDrawBackgroundColour(playerid, TD_SelectWeapon[playerid][td - 3], -1717986817);
			}
		}
		else {
			PlayerTextDrawSetSelectable(playerid, TD_SelectWeapon[playerid][td], false);
			PlayerTextDrawSetPreviewModel(playerid, TD_SelectWeapon[playerid][td], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_SelectWeapon[playerid][td], 0.000000, 0.000000, 0.000000, 1000.000000);
			PlayerTextDrawSetString(playerid, TD_SelectWeapon[playerid][td + 3], "_");
		}
	}
	PlayerTextDrawSetString(playerid, TD_SelectWeapon[playerid][12], "Убийств:_%i", pStatsInfo[playerid][e_Kills][classid]);
	return 1;
}

static ShowInfoBuyTD(playerid, type)
{
	new
		classid = GetPlayerCustomClass2(playerid);

	switch (type) {
		// Cap
		case 1: {
			PlayerTextDrawSetString(playerid, TD_Buy[playerid][17], "Выбор_шлема");
			if (pBodyInfo[playerid][e_Cap][classid][0] == 0) 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][13], "$10000");
			else 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][13], "_");

			if (pBodyInfo[playerid][e_Cap][classid][1] == 0) 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][14], "$20000");
			else 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][14], "_");

			if (pBodyInfo[playerid][e_Cap][classid][2] == 0) 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][15], "$40000");
			else 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][15], "_");

			PlayerTextDrawSetPreviewModel(playerid, TD_Buy[playerid][5], 19141);
			PlayerTextDrawSetPreviewModel(playerid, TD_Buy[playerid][6], 19141);
			PlayerTextDrawSetPreviewModel(playerid, TD_Buy[playerid][7], 19141);

			PlayerTextDrawSetPreviewRot(playerid, TD_Buy[playerid][5], 0.000000, -90.000000, 0.000000, 1.000000);
			PlayerTextDrawSetPreviewRot(playerid, TD_Buy[playerid][6], 0.000000, -90.000000, 0.000000, 1.000000);
			PlayerTextDrawSetPreviewRot(playerid, TD_Buy[playerid][7], 0.000000, -90.000000, 0.000000, 1.000000);

			if (pBodyUsesInfo[playerid][e_Cap][classid] == 0) 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][0], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][0], -1717986817);

			if (pBodyUsesInfo[playerid][e_Cap][classid] == 1) 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][1], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][1], -1717986817);

			if (pBodyUsesInfo[playerid][e_Cap][classid] == 2) 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][2], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][2], -1717986817);

			if (pBodyUsesInfo[playerid][e_Cap][classid] == 3) 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][3], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][3], -1717986817);
		}
		// Armour
		case 2: {
			PlayerTextDrawSetString(playerid, TD_Buy[playerid][17], "Выбор_бронежилета");
			if (pBodyInfo[playerid][e_Armour][classid][0] == 0) 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][13], "$15000");
			else 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][13], "_");

			if (pBodyInfo[playerid][e_Armour][classid][1] == 0) 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][14], "$30000");
			else 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][14], "_");

			if (pBodyInfo[playerid][e_Armour][classid][2] == 0) 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][15], "$60000");
			else 
				PlayerTextDrawSetString(playerid, TD_Buy[playerid][15], "_");

			PlayerTextDrawSetPreviewModel(playerid, TD_Buy[playerid][5], 1242);
			PlayerTextDrawSetPreviewModel(playerid, TD_Buy[playerid][6], 1242);
			PlayerTextDrawSetPreviewModel(playerid, TD_Buy[playerid][7], 1242);

			if (pBodyUsesInfo[playerid][e_Armour][classid] == 0) 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][0], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][0], -1717986817);

			if (pBodyUsesInfo[playerid][e_Armour][classid] == 1) 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][1], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][1], -1717986817);

			if (pBodyUsesInfo[playerid][e_Armour][classid] == 2) 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][2], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][2], -1717986817);
			
			if (pBodyUsesInfo[playerid][e_Armour][classid] == 3) 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][3], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColour(playerid, TD_Buy[playerid][3], -1717986817);
		}
	}

	PlayerTextDrawSetString(playerid, TD_Buy[playerid][19], "В наличии:_$%i", GetPlayerMoneyEx(playerid));
	return 1;
}

static DestroyPlayerClassBuyTD(playerid)
{
	n_for(i, TDM_TD_CLASS_BUY_ITEMS) {
		DestroyPlayerTD(playerid, TD_Buy[playerid][i]);
	}
	return 1;
}

static SetAirCause(playerid, airtype, type)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	new
		Float:x, 
		Float:y, 
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	switch (airtype) {
		case TDM_AIR_WEAPON: SetAirCauseWeapon(sessionid, playerid, type, x, y, z, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		case TDM_AIR_MEDICAMENT: SetAirCauseMedicament(sessionid, playerid, type, x, y, z, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		case TDM_AIR_AMMO: SetAirCauseAmmo(sessionid, playerid, type, x, y, z, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	}

	ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, true, false, false, false, 0);

	SCM(playerid, C_ORANGE, ""T_AIRDROP" "CT_WHITE"Аирдроп успешно вызван.");
	SetTimerEx("TDM_CallClassAirCause", 1000, false, "iifff", playerid, airtype, x, y, z);
	return 1;
}

public: TDM_CallClassAirCause(playerid, airtype, Float:x, Float:y, Float:z) 
{
	new 
		Float:r = 3.0;

	switch (airtype) {
		case TDM_AIR_WEAPON: AirCauseWeapon[playerid][e_ObjectSmooke] = CreateDynamicObject(18728, x, y, z - r, 0.00000, 0.00000, 0.00000, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		case TDM_AIR_MEDICAMENT: AirCauseMedication[playerid][e_ObjectSmooke] = CreateDynamicObject(18728, x, y, z - r, 0.00000, 0.00000, 0.00000, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		case TDM_AIR_AMMO: AirCauseAmmo[playerid][e_ObjectSmooke] = CreateDynamicObject(18728, x, y, z - r, 0.00000, 0.00000, 0.00000, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	}

	Mode_StreamerUpdate(MODE_TDM, Mode_GetPlayerSession(playerid));
	ApplyAnimation(playerid, "PED", "IDLE_tired", 4.1, false, true, true, false, 1);
	return 1;
}

static SetAirCauseWeapon(sessionid, id, type, Float:x, Float:y, Float:z, virtualworld, interior)
{
	AllCauseWeaponCount[sessionid]++;
	n_for(i, MAX_PLAYERS) {
		if (AllCauseWeaponAir[sessionid][i] > -1) {
			continue;
		}

		AllCauseWeaponAir[sessionid][i] = id;
		break;
	}

	AirCauseWeapon[id][e_Status] = 1;
	AirCauseWeapon[id][e_Action] = false;
	AirCauseWeapon[id][e_Type] = type;
	AirCauseWeapon[id][e_Timer] = 0;
	AirCauseWeapon[id][e_VirtualWorld] = virtualworld;
	AirCauseWeapon[id][e_Interior] = interior;
	AirCauseWeapon[id][e_PosX] = x;
	AirCauseWeapon[id][e_PosY] = y;
	AirCauseWeapon[id][e_PosZ] = z;
	SetAirWeaponAmmo(id, type);

	new 
		Float:r = GetAirRandomPos();

	AirCauseWeapon[id][e_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirCauseWeapon[id][e_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirCauseWeapon[id][e_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 75.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirCauseWeapon[id][e_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 75.0, 0.00000, 0.00000, 0.00000);
	return 1;
}

static SetAirCauseMedicament(sessionid, id, type, Float:x, Float:y, Float:z, virtualworld, interior)
{
	AllCauseMedicationCount[sessionid]++;
	n_for(i, MAX_PLAYERS) {
		if (AllCauseMedicationAir[sessionid][i] > -1) {
			continue;
		}

		AllCauseMedicationAir[sessionid][i] = id;
		break;
	}

	AirCauseMedication[id][e_Status] = 1;
	AirCauseMedication[id][e_Action] = false;
	AirCauseMedication[id][e_Type] = type;
	AirCauseMedication[id][e_Timer] = 0;
	AirCauseMedication[id][e_VirtualWorld] = virtualworld;
	AirCauseMedication[id][e_Interior] = interior;
	AirCauseMedication[id][e_PosX] = x;
	AirCauseMedication[id][e_PosY] = y;
	AirCauseMedication[id][e_PosZ] = z;

	new
		Float:r = GetAirRandomPos();

	AirCauseMedication[id][e_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirCauseMedication[id][e_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirCauseMedication[id][e_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 75.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirCauseMedication[id][e_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 75.0, 0.00000, 0.00000, 0.00000);
	return 1;
}

static SetAirCauseAmmo(sessionid, id, type, Float:x, Float:y, Float:z, virtualworld, interior) 
{
	AllCauseAmmoCount[sessionid]++;
	n_for(i, MAX_PLAYERS) {
		if (AllCauseAmmoAir[sessionid][i] > -1) {
			continue;
		}

		AllCauseAmmoAir[sessionid][i] = id;
		break;
	}

	AirCauseAmmo[id][e_Status] = 1;
	AirCauseAmmo[id][e_Action] = false;
	AirCauseAmmo[id][e_Type] = type;
	AirCauseAmmo[id][e_Timer] = 0;
	AirCauseAmmo[id][e_VirtualWorld] = virtualworld;
	AirCauseAmmo[id][e_Interior] = interior;
	AirCauseAmmo[id][e_PosX] = x;
	AirCauseAmmo[id][e_PosY] = y;
	AirCauseAmmo[id][e_PosZ] = z;

	new
		Float:r = GetAirRandomPos();

	AirCauseAmmo[id][e_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirCauseAmmo[id][e_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirCauseAmmo[id][e_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 75.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirCauseAmmo[id][e_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 75.0, 0.00000, 0.00000, 0.00000);
	return 1;
}

static SetAirWeaponAmmo(id, type)
{
	switch (type) {
		case 1: {
			AirCauseWeapon[id][e_Weapon][0] = WEAPON_AK47;
			AirCauseWeapon[id][e_Weapon][1] = WEAPON_COLT45;
			AirCauseWeapon[id][e_Weapon][2] = WEAPON_MP5;
			AirCauseWeapon[id][e_Weapon][3] = WEAPON_GRENADE;

			AirCauseWeapon[id][e_WeaponAmmo][0] = 200;
			AirCauseWeapon[id][e_WeaponAmmo][1] = 30;
			AirCauseWeapon[id][e_WeaponAmmo][2] = 80;
			AirCauseWeapon[id][e_WeaponAmmo][3] = 3;
		}
		case 2: {
			AirCauseWeapon[id][e_Weapon][0] = WEAPON_M4;
			AirCauseWeapon[id][e_Weapon][1] = WEAPON_DEAGLE;
			AirCauseWeapon[id][e_Weapon][2] = WEAPON_SAWEDOFF;
			AirCauseWeapon[id][e_Weapon][3] = WEAPON_GRENADE;

			AirCauseWeapon[id][e_WeaponAmmo][0] = 300;
			AirCauseWeapon[id][e_WeaponAmmo][1] = 50;
			AirCauseWeapon[id][e_WeaponAmmo][2] = 30;
			AirCauseWeapon[id][e_WeaponAmmo][3] = 10;
		}
		case 3: {
			AirCauseWeapon[id][e_Weapon][0] = WEAPON_M4;
			AirCauseWeapon[id][e_Weapon][1] = WEAPON_DEAGLE;
			AirCauseWeapon[id][e_Weapon][2] = WEAPON_UZI;
			AirCauseWeapon[id][e_Weapon][3] = WEAPON_GRENADE;

			AirCauseWeapon[id][e_WeaponAmmo][0] = 400;
			AirCauseWeapon[id][e_WeaponAmmo][1] = 70;
			AirCauseWeapon[id][e_WeaponAmmo][2] = 200;
			AirCauseWeapon[id][e_WeaponAmmo][3] = 15;
		}
	}
	return 1;
}

static ResetAllClassAirdrop(sessionid, type, cell, bool:all_reset)
{
	switch (type) {
		// Weapon
		case TDM_AIR_WEAPON: {
			if (cell == -1) {
				n_for(i, MAX_PLAYERS) {
					AirCauseWeapon[i][e_Action] = false;
					AirCauseWeapon[i][e_Status] =
					AirCauseWeapon[i][e_Timer] =
					AirCauseWeapon[i][e_Type] =
					AirCauseWeapon[i][e_VirtualWorld] =
					AirCauseWeapon[i][e_Interior] = 0;
					AirCauseWeapon[i][e_PosX] =
					AirCauseWeapon[i][e_PosY] =
					AirCauseWeapon[i][e_PosZ] = 0.0;
					n_for2(w, TDM_AIR_C_MAX_WEAPON) {
						AirCauseWeapon[i][e_Weapon][w] = WEAPON_FIST;
						AirCauseWeapon[i][e_WeaponAmmo][w] = 0;
					}
					AirCauseWeapon[i][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
					AirCauseWeapon[i][e_ObjectSmooke] =
					AirCauseWeapon[i][e_ObjectBox] =
					AirCauseWeapon[i][e_ObjectAir] =
					AirCauseWeapon[i][e_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
				}
			}
			else {
				AirCauseWeapon[cell][e_Action] = false;
				AirCauseWeapon[cell][e_Status] =
				AirCauseWeapon[cell][e_Timer] =
				AirCauseWeapon[cell][e_Type] =
				AirCauseWeapon[cell][e_VirtualWorld] =
				AirCauseWeapon[cell][e_Interior] = 0;
				AirCauseWeapon[cell][e_PosX] =
				AirCauseWeapon[cell][e_PosY] =
				AirCauseWeapon[cell][e_PosZ] = 0.0;
				n_for(w, TDM_AIR_C_MAX_WEAPON) {
					AirCauseWeapon[cell][e_Weapon][w] = WEAPON_FIST;
					AirCauseWeapon[cell][e_WeaponAmmo][w] = 0;
				}
				AirCauseWeapon[cell][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
				AirCauseWeapon[cell][e_ObjectSmooke] =
				AirCauseWeapon[cell][e_ObjectBox] =
				AirCauseWeapon[cell][e_ObjectAir] =
				AirCauseWeapon[cell][e_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
			}
			if (all_reset) {
				n_for(i, MAX_PLAYERS)
					AllCauseWeaponAir[sessionid][i] = -1;

				AllCauseWeaponCount[sessionid] = 0;
			}
		}
		// Medication
		case TDM_AIR_MEDICAMENT: {
			if (cell == -1) {
				n_for(i, MAX_PLAYERS) {
					AirCauseMedication[i][e_Action] = false;
					AirCauseMedication[i][e_Status] =
					AirCauseMedication[i][e_Timer] =
					AirCauseMedication[i][e_Type] =
					AirCauseMedication[i][e_VirtualWorld] =
					AirCauseMedication[i][e_Interior] = 0;
					AirCauseMedication[i][e_PosX] =
					AirCauseMedication[i][e_PosY] =
					AirCauseMedication[i][e_PosZ] = 0.0;

					AirCauseMedication[i][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
					AirCauseMedication[i][e_ObjectSmooke] =
					AirCauseMedication[i][e_ObjectBox] =
					AirCauseMedication[i][e_ObjectAir] =
					AirCauseMedication[i][e_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
				}
			}
			else {
				AirCauseMedication[cell][e_Action] = false;
				AirCauseMedication[cell][e_Status] =
				AirCauseMedication[cell][e_Timer] =
				AirCauseMedication[cell][e_Type] =
				AirCauseMedication[cell][e_VirtualWorld] =
				AirCauseMedication[cell][e_Interior] = 0;
				AirCauseMedication[cell][e_PosX] =
				AirCauseMedication[cell][e_PosY] =
				AirCauseMedication[cell][e_PosZ] = 0.0;

				AirCauseMedication[cell][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
				AirCauseMedication[cell][e_ObjectSmooke] =
				AirCauseMedication[cell][e_ObjectBox] =
				AirCauseMedication[cell][e_ObjectAir] =
				AirCauseMedication[cell][e_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
			}
			if (all_reset) {
				n_for(i, MAX_PLAYERS)
					AllCauseMedicationAir[sessionid][i] = -1;

				AllCauseMedicationCount[sessionid] = 0;
			}
		}
		// Ammo
		case TDM_AIR_AMMO: {
			if (cell == -1) {
				n_for(i, MAX_PLAYERS) {
					AirCauseAmmo[i][e_Action] = false;
					AirCauseAmmo[i][e_Status] =
					AirCauseAmmo[i][e_Timer] =
					AirCauseAmmo[i][e_Type] =
					AirCauseAmmo[i][e_VirtualWorld] =
					AirCauseAmmo[i][e_Interior] = 0;
					AirCauseAmmo[i][e_PosX] =
					AirCauseAmmo[i][e_PosY] =
					AirCauseAmmo[i][e_PosZ] = 0.0;

					AirCauseAmmo[i][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
					AirCauseAmmo[i][e_ObjectSmooke] =
					AirCauseAmmo[i][e_ObjectBox] =
					AirCauseAmmo[i][e_ObjectAir] =
					AirCauseAmmo[i][e_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
				}
			}
			else {
				AirCauseAmmo[cell][e_Action] = false;
				AirCauseAmmo[cell][e_Status] =
				AirCauseAmmo[cell][e_Timer] =
				AirCauseAmmo[cell][e_Type] =
				AirCauseAmmo[cell][e_VirtualWorld] =
				AirCauseAmmo[cell][e_Interior] = 0;
				AirCauseAmmo[cell][e_PosX] =
				AirCauseAmmo[cell][e_PosY] =
				AirCauseAmmo[cell][e_PosZ] = 0.0;

				AirCauseAmmo[cell][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
				AirCauseAmmo[cell][e_ObjectSmooke] =
				AirCauseAmmo[cell][e_ObjectBox] =
				AirCauseAmmo[cell][e_ObjectAir] =
				AirCauseAmmo[cell][e_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
			}
			if (all_reset) {
				n_for(i, MAX_PLAYERS) {
					AllCauseAmmoAir[sessionid][i] = -1;
				}
				AllCauseAmmoCount[sessionid] = 0;
			}
		}
	}
	return 1;
}

static Show3DTextAirCauseWeapon(id, Float:x, Float:y, Float:z) 
{
	new
		string[500],
		boxName[200],
		text[50],
		text2[50];

	text = "Вызвал:";
	text2 = "Нажмите";

	switch (AirCauseWeapon[id][e_Type]) {
		case 1: boxName = "Малый контейнер оружия";
		case 2: boxName = "Средний контейнер оружия";
		case 3: boxName = "Большой контейнер оружия";
	}

	f(string,
	""TDM_AIR_C_COLOR_NAME_WEAPON"%s \
	\n\n"CT_WHITE"%s {%06x}%s "T_PID" \
	\n\n{D42C21}%s {E5D110}[ ALT ]", 
	boxName, text, GetPlayerColorEx(id) >>> 8, GetPlayerNameEx(id), id, text2);

	AirCauseWeapon[id][e_3DText] = CreateDynamic3DTextLabel(string, -1, x, y, z, 11.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorldEx(id), GetPlayerInteriorEx(id));
	return 1;
}

static Show3DTextAirCauseMedication(id, Float:x, Float:y, Float:z)
{
	new
		string[300],
		boxName[100],
		text[50];

	text = "Вызвал:";
	switch (AirCauseMedication[id][e_Type]) {
		case 1: boxName = "Малый контейнер медикаментов";
		case 2: boxName = "Средний контейнер медикаментов";
		case 3: boxName = "Большой контейнер медикаментов";
	}

	f(string, 
	""TDM_AIR_C_COLOR_NAME_MEDICAMENT"%s \
	\n\n"CT_WHITE"%s {%06x}%s "T_PID"", 
	boxName, text, GetPlayerColorEx(id) >>> 8, GetPlayerNameEx(id), id);

	AirCauseMedication[id][e_3DText] = CreateDynamic3DTextLabel(string, -1, x, y, z, 11.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorldEx(id), GetPlayerInteriorEx(id));
	return 1;
}

static Show3DTextAirCauseAmmo(id, Float:x, Float:y, Float:z)
{
	new
		string[250],
		boxName[100],
		text[50];

	text = "Вызвал:";
	switch (AirCauseAmmo[id][e_Type]) {
		case 1: boxName = "Малый контейнер патронов";
		case 2: boxName = "Средний контейнер патронов";
		case 3: boxName = "Большой контейнер патронов";
	}

	f(string,
	""TDM_AIR_C_COLOR_NAME_AMMO"%s \
	\n\n"CT_WHITE"%s {%06x}%s "T_PID"", 
	boxName, text, GetPlayerColorEx(id) >>> 8, GetPlayerNameEx(id), id);

	AirCauseAmmo[id][e_3DText] = CreateDynamic3DTextLabel(string, -1, x, y, z, 11.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorldEx(id), GetPlayerInteriorEx(id));
	return 1;
}

/*
 * |>-------------<|
 * |     MySQL     |
 * |>-------------<|
 */

stock TDM_MySQLCreateNewStatsClass(playerid)
{
	static
		strFormat[6000],
		strData[1000],
		strData2[500];

	strFormat[0] =
	strData[0] =
	strData2[0] = EOS;

	InitialPlayerClassWeapon(playerid);

	// Core
	f(strFormat, "\
	INSERT INTO \
	`"DB_TDM"` \
	(\
	`"DB_TDM_ID"`,\
	`"DB_TDM_KILLS"`,\
	`"DB_TDM_DEATHS"`,\
	`"DB_TDM_ASSAULT_WEAPONS"`,\
	`"DB_TDM_ASSAULT_AMMO"`,\
	`"DB_TDM_MEDIC_WEAPONS"`,\
	`"DB_TDM_MEDIC_AMMO"`,\
	`"DB_TDM_ENGINEER_WEAPONS"`,\
	`"DB_TDM_ENGINEER_AMMO"`,\
	`"DB_TDM_RECON_WEAPONS"`,\
	`"DB_TDM_RECON_AMMO"`,\
	`"DB_TDM_USES_CAP"`,\
	`"DB_TDM_USES_ARMOUR"`,\
	`"DB_TDM_ASSAULT_CAPS"`,\
	`"DB_TDM_ASSAULT_ARMORS"`,\
	`"DB_TDM_MEDIC_CAPS"`,\
	`"DB_TDM_MEDIC_ARMOURS"`,\
	`"DB_TDM_ENGINEER_CAPS"`,\
	`"DB_TDM_ENGINEER_ARMOURS"`,\
	`"DB_TDM_RECON_CAPS"`,\
	`"DB_TDM_RECON_ARMOURS"`,\
	`"DB_TDM_ASSAULT_ABILITIES"`,\
	`"DB_TDM_MEDIC_ABILITIES"`,\
	`"DB_TDM_ENGINEER_ABILITIES"`,\
	`"DB_TDM_RECON_ABILITIES"`,\
	`"DB_TDM_SKILL_M4"`,\
	`"DB_TDM_SKILL_AK47"`,\
	`"DB_TDM_SKILL_DEAGLE"`,\
	`"DB_TDM_SKILL_SHOTGUN"`,\
	`"DB_TDM_SKILL_SAWSHOTGUN"`,\
	`"DB_TDM_SKILL_UZI"`,\
	`"DB_TDM_SKILL_MP5"`,\
	`"DB_TDM_SKILL_SNIPERRIFLE"`,\
	`"DB_TDM_SKILL_NORMAL"`,\
	`"DB_TDM_SKILL_BOXING"`,\
	`"DB_TDM_SKILL_KUNGFU"`,\
	`"DB_TDM_SKILL_KNEEHEAD"`,\
	`"DB_TDM_SKILL_GRABKICK"`,\
	`"DB_TDM_SKILL_ELBOW"`,\
	`"DB_TDM_PLAYED_HOURS"`,\
	`"DB_TDM_PLAYED_MINUTES"`\
	) \
	VALUES ");

	strcat(strFormat, "(");

	// DB_TDM_ID
	f(strData, "'%i',", GetPlayerMySQLID(playerid));
	strcat(strFormat, strData);
	
	strData[0] = EOS;

	// DB_TDM_KILLS & DB_TDM_DEATHS
	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		strcat(strData2, "0,");
	}

	// DB_TDM_KILLS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_DEATHS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_ASSAULT_WEAPONS
	n_for(w, TDM_CLASS_MAX_WEAPONS) {
		f(strData2, "%s%d,", strData2, pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ASSAULT][w]);
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_ASSAULT_AMMO
	n_for(w, TDM_CLASS_MAX_WEAPONS) {
		f(strData2, "%s%d,", strData2, pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ASSAULT][w]);
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_MEDIC_WEAPONS
	n_for(w, TDM_CLASS_MAX_WEAPONS) {
		f(strData2, "%s%d,", strData2, pWeaponInfo[playerid][e_Weapon][TDM_CLASS_MEDIC][w]);
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_MEDIC_AMMO
	n_for(w, TDM_CLASS_MAX_WEAPONS) {
		f(strData2, "%s%d,", strData2, pWeaponInfo[playerid][e_Ammo][TDM_CLASS_MEDIC][w]);
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_ENGINEER_WEAPONS
	n_for(w, TDM_CLASS_MAX_WEAPONS) {
		f(strData2, "%s%d,", strData2, pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ENGINEER][w]);
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_ENGINEER_AMMO
	n_for(w, TDM_CLASS_MAX_WEAPONS) {
		f(strData2, "%s%d,", strData2, pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ENGINEER][w]);
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_RECON_WEAPONS
	n_for(w, TDM_CLASS_MAX_WEAPONS) {
		f(strData2, "%s%d,", strData2, pWeaponInfo[playerid][e_Weapon][TDM_CLASS_RECON][w]);
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_RECON_AMMO
	n_for(w, TDM_CLASS_MAX_WEAPONS) {
		f(strData2, "%s%d,", strData2, pWeaponInfo[playerid][e_Ammo][TDM_CLASS_RECON][w]);
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_USES_CAP & DB_TDM_USES_ARMOUR
	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		strcat(strData2, "0,");
	}

	// DB_TDM_USES_CAP
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] = EOS;
	
	// DB_TDM_USES_ARMOUR
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// CAPS & ARMOUR
	n_for(i, TDM_MAX_SHOP_BODY) {
		strcat(strData2, "0,");
	}

	// DB_TDM_ASSAULT_CAPS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] = EOS;
	
	// DB_TDM_ASSAULT_ARMORS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_MEDIC_CAPS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_MEDIC_ARMOURS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_ENGINEER_CAPS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_TDM_ENGINEER_ARMOURS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] = EOS;

	// DB_TDM_RECON_CAPS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_TDM_RECON_ARMOURS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_ASSAULT_ABILITIES
	n_for(i, TDM_MAX_ASSAULT_ABILS) {
		strcat(strData2, "0,");
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;
	
	// DB_TDM_MEDIC_ABILITIES
	n_for(i, TDM_MAX_MEDIC_ABILS)
		strcat(strData2, "0,");

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;
	
	// DB_TDM_ENGINEER_ABILITIES
	n_for(i, TDM_MAX_ENGINEER_ABILS)
		strcat(strData2, "0,");

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;
	
	// DB_TDM_RECON_ABILITIES
	n_for(i, TDM_MAX_RECON_ABILS)
		strcat(strData2, "0,");

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// SKILLS
	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		strcat(strData2, "0.00,");
	}

	// DB_TDM_SKILL_M4
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_AK47
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_DEAGLE
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_SHOTGUN
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_SAWSHOTGUN
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_UZI
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_MP5
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_SNIPERRIFLE
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_NORMAL
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_BOXING
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_KUNGFU
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_KNEEHEAD
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_GRABKICK
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_TDM_SKILL_ELBOW
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_TDM_PLAYED_HOURS & DB_TDM_PLAYED_MINUTES
	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		strcat(strData2, "0,");
	}

	// DB_TDM_PLAYED_HOURS
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] = EOS;
	
	// DB_TDM_PLAYED_MINUTES
	f(strData, "'%s'", strData2);
	strcat(strFormat, strData);

	strcat(strFormat, ")");

	mysql_tquery(MySQLID, strFormat);
	return 1;
}

stock TDM_MySQLUploadPlayerClassData(playerid)
{
	static const
		queryFormat[] = "SELECT * FROM `"DB_TDM"` WHERE `"DB_TDM_ID"` = '%i' LIMIT 1";

	new
		query[sizeof(queryFormat) - 2 + MAX_LENGTH_NUM];

	mysql_format(MySQLID, query, sizeof(query), queryFormat, GetPlayerMySQLID(playerid));
	mysql_tquery(MySQLID, query, "TDM_MySQLUploadPlayerClasses", "i", playerid);
	return 1;
}

public: TDM_MySQLUploadPlayerClasses(playerid)
{
	static
		strFormat[30],
		strData[1000];

	strFormat[0] =
	strData[0] = EOS;

	// Kills & deaths
	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_PLAYER_CLASSES);

	cache_get_value_name(0, DB_TDM_KILLS, strData);
	sscanf(strData, strFormat, pStatsInfo[playerid][e_Kills]);

	strData[0] = EOS;

	cache_get_value_name(0, DB_TDM_DEATHS, strData);
	sscanf(strData, strFormat, pStatsInfo[playerid][e_Deaths]);

	strFormat[0] =
	strData[0] = EOS;

	// Played time
	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_PLAYER_CLASSES);

	cache_get_value_name(0, DB_TDM_PLAYED_HOURS, strData);
	sscanf(strData, strFormat, pStatsInfo[playerid][e_Hours]);

	strData[0] = EOS;

	cache_get_value_name(0, DB_TDM_PLAYED_MINUTES, strData);
	sscanf(strData, strFormat, pStatsInfo[playerid][e_Minutes]);

	strFormat[0] =
	strData[0] = EOS;

	// Weapon & ammo
	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_PLAYER_CLASSES);

	cache_get_value_name(0, DB_TDM_ASSAULT_WEAPONS, strData);
	sscanf(strData, strFormat, pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ASSAULT]);
	
	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_ASSAULT_AMMO, strData);
	sscanf(strData, strFormat, pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ASSAULT]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_MEDIC_WEAPONS, strData);
	sscanf(strData, strFormat, pWeaponInfo[playerid][e_Weapon][TDM_CLASS_MEDIC]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_MEDIC_AMMO, strData);
	sscanf(strData, strFormat, pWeaponInfo[playerid][e_Ammo][TDM_CLASS_MEDIC]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_ENGINEER_WEAPONS, strData);
	sscanf(strData, strFormat, pWeaponInfo[playerid][e_Weapon][TDM_CLASS_ENGINEER]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_ENGINEER_AMMO, strData);
	sscanf(strData, strFormat, pWeaponInfo[playerid][e_Ammo][TDM_CLASS_ENGINEER]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_RECON_WEAPONS, strData);
	sscanf(strData, strFormat, pWeaponInfo[playerid][e_Weapon][TDM_CLASS_RECON]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_RECON_AMMO, strData);
	sscanf(strData, strFormat, pWeaponInfo[playerid][e_Ammo][TDM_CLASS_RECON]);

	strFormat[0] =
	strData[0] = EOS;

	// Uses body
	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_PLAYER_CLASSES);

	cache_get_value_name(0, DB_TDM_USES_CAP, strData);
	sscanf(strData, strFormat, pBodyUsesInfo[playerid][e_Cap]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_USES_ARMOUR, strData);
	sscanf(strData, strFormat, pBodyUsesInfo[playerid][e_Armour]);

	strFormat[0] =
	strData[0] = EOS;

	// Body
	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_SHOP_BODY);

	cache_get_value_name(0, DB_TDM_ASSAULT_CAPS, strData);
	sscanf(strData, strFormat, pBodyInfo[playerid][e_Cap][TDM_CLASS_ASSAULT]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_ASSAULT_ARMORS, strData);
	sscanf(strData, strFormat, pBodyInfo[playerid][e_Armour][TDM_CLASS_ASSAULT]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_MEDIC_CAPS, strData);
	sscanf(strData, strFormat, pBodyInfo[playerid][e_Cap][TDM_CLASS_MEDIC]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_MEDIC_ARMOURS, strData);
	sscanf(strData, strFormat, pBodyInfo[playerid][e_Armour][TDM_CLASS_MEDIC]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_ENGINEER_CAPS, strData);
	sscanf(strData, strFormat, pBodyInfo[playerid][e_Cap][TDM_CLASS_ENGINEER]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_ENGINEER_ARMOURS, strData);
	sscanf(strData, strFormat, pBodyInfo[playerid][e_Armour][TDM_CLASS_ENGINEER]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_RECON_CAPS, strData);
	sscanf(strData, strFormat, pBodyInfo[playerid][e_Cap][TDM_CLASS_RECON]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_RECON_ARMOURS, strData);
	sscanf(strData, strFormat, pBodyInfo[playerid][e_Armour][TDM_CLASS_RECON]);

	strFormat[0] =
	strData[0] = EOS;

	// Abils
	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_ASSAULT_ABILS);

	cache_get_value_name(0, DB_TDM_ASSAULT_ABILITIES, strData);
	sscanf(strData, strFormat, pAbilsInfo[playerid][TDM_CLASS_ASSAULT]);

	strFormat[0] =
	strData[0] = EOS;

	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_MEDIC_ABILS);
	
	cache_get_value_name(0, DB_TDM_MEDIC_ABILITIES, strData);
	sscanf(strData, strFormat, pAbilsInfo[playerid][TDM_CLASS_MEDIC]);

	strFormat[0] =
	strData[0] = EOS;
	
	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_ENGINEER_ABILS);
	
	cache_get_value_name(0, DB_TDM_ENGINEER_ABILITIES, strData);
	sscanf(strData, strFormat, pAbilsInfo[playerid][TDM_CLASS_ENGINEER]);

	strFormat[0] =
	strData[0] = EOS;

	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_RECON_ABILS);
	
	cache_get_value_name(0, DB_TDM_RECON_ABILITIES, strData);
	sscanf(strData, strFormat, pAbilsInfo[playerid][TDM_CLASS_RECON]);

	strFormat[0] =
	strData[0] = EOS;

	// Skills weapon
	f(strFormat, "p<,>a<f>[%i]", TDM_MAX_PLAYER_CLASSES);

	cache_get_value_name(0, DB_TDM_SKILL_M4, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_M4]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_AK47, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_AK47]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_DEAGLE, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_Deagle]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_SHOTGUN, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_Shotgun]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_SAWSHOTGUN, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_SawShotgun]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_UZI, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_Uzi]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_MP5, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_MP5]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_SNIPERRIFLE, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_Sniper]);

	strFormat[0] =
	strData[0] = EOS;

	// Skills fight style
	f(strFormat, "p<,>a<f>[%i]", TDM_MAX_PLAYER_CLASSES);

	cache_get_value_name(0, DB_TDM_SKILL_NORMAL, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_Normal]);
	
	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_BOXING, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_Boxing]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_KUNGFU, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_KungFu]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_KNEEHEAD, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_KneeHead]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_GRABKICK, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_GrabKick]);

	strData[0] = EOS;
	
	cache_get_value_name(0, DB_TDM_SKILL_ELBOW, strData);
	sscanf(strData, strFormat, pSkillInfo[playerid][e_Elbow]);
	return 1;
}

stock TDM_SavePlayerClassSkillWeapon(playerid, WEAPONSKILL:skillid)
{
	new
		strSkill[(TDM_MAX_PLAYER_CLASSES * MAX_LENGTH_NUM) + (TDM_MAX_PLAYER_CLASSES * 2) + 1];

	switch (skillid) {
		case WEAPONSKILL_M4: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_M4], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_M4"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case WEAPONSKILL_AK47: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_AK47], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_AK47"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case WEAPONSKILL_DESERT_EAGLE: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_Deagle], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_DEAGLE"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case WEAPONSKILL_SHOTGUN: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_Shotgun], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_SHOTGUN"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case WEAPONSKILL_SAWNOFF_SHOTGUN: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_SawShotgun], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_SAWSHOTGUN"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case WEAPONSKILL_MICRO_UZI: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_Uzi], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_UZI"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case WEAPONSKILL_MP5: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_MP5], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_MP5"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case WEAPONSKILL_SNIPERRIFLE: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_Sniper], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_SNIPERRIFLE"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
	}
	return 1;
}

stock TDM_SavePlayerClassSkillFight(playerid, FIGHT_STYLE:skillid)
{
	new
		strSkill[(TDM_MAX_PLAYER_CLASSES * MAX_LENGTH_NUM) + (TDM_MAX_PLAYER_CLASSES * 2) + 1];

	switch (skillid) {
		case FIGHT_STYLE_NORMAL: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_Normal], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_NORMAL"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case FIGHT_STYLE_BOXING: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_Boxing], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_BOXING"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case FIGHT_STYLE_KUNGFU: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_KungFu], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_KUNGFU"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case FIGHT_STYLE_KNEEHEAD: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_KneeHead], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_KNEEHEAD"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case FIGHT_STYLE_GRABKICK: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_GrabKick], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_GRABKICK"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
		case FIGHT_STYLE_ELBOW: {
			FormatFloatArrayToSQL(pSkillInfo[playerid][e_Elbow], TDM_MAX_PLAYER_CLASSES, strSkill);
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_SKILL_ELBOW"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strSkill, GetPlayerMySQLID(playerid));
		}
	}
	return 1;
}

stock TDM_SavePlayerClassWeapon(playerid, classid)
{
	new
		strWeapon[(TDM_CLASS_MAX_WEAPONS * MAX_LENGTH_NUM) + (TDM_CLASS_MAX_WEAPONS * 2) + 1],
		strAmmo[(TDM_CLASS_MAX_WEAPONS * MAX_LENGTH_NUM) + (TDM_CLASS_MAX_WEAPONS * 2) + 1];

	FormatIntArrayToSQL(pWeaponInfo[playerid][e_Weapon][classid], TDM_CLASS_MAX_WEAPONS, strWeapon);
	FormatIntArrayToSQL(pWeaponInfo[playerid][e_Ammo][classid], TDM_CLASS_MAX_WEAPONS, strAmmo);

	switch (classid) {
		case TDM_CLASS_ASSAULT: {
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_ASSAULT_WEAPONS"` = '%s', `"DB_TDM_ASSAULT_AMMO"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strWeapon, strAmmo, GetPlayerMySQLID(playerid));
		}
		case TDM_CLASS_MEDIC: {
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_MEDIC_WEAPONS"` = '%s', `"DB_TDM_MEDIC_AMMO"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strWeapon, strAmmo, GetPlayerMySQLID(playerid));
		}
		case TDM_CLASS_ENGINEER: {
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_ENGINEER_WEAPONS"` = '%s', `"DB_TDM_ENGINEER_AMMO"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strWeapon, strAmmo, GetPlayerMySQLID(playerid));
		}
		case TDM_CLASS_RECON: {
			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_RECON_WEAPONS"` = '%s', `"DB_TDM_RECON_AMMO"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strWeapon, strAmmo, GetPlayerMySQLID(playerid));
		}
	}
	return 1;
}

stock TDM_SavePlayerClassBody(playerid, classid)
{
	new
		strCap[(TDM_MAX_SHOP_BODY * 2) + 1],
		strArmour[(TDM_MAX_SHOP_BODY * 2) + 1];
	
	new
		strUsesCap[(TDM_MAX_PLAYER_CLASSES * 2) + 1],
		strUsesArmour[(TDM_MAX_PLAYER_CLASSES * 2) + 1];

	FormatIntArrayToSQL(pBodyInfo[playerid][e_Cap][classid], TDM_MAX_SHOP_BODY, strCap);
	FormatIntArrayToSQL(pBodyInfo[playerid][e_Armour][classid], TDM_MAX_SHOP_BODY, strArmour);

	FormatIntArrayToSQL(pBodyUsesInfo[playerid][e_Cap], TDM_MAX_PLAYER_CLASSES, strUsesCap);
	FormatIntArrayToSQL(pBodyUsesInfo[playerid][e_Armour], TDM_MAX_PLAYER_CLASSES, strUsesArmour);

	switch (classid) {
		case TDM_CLASS_ASSAULT: {
			SQL("\
			UPDATE `"DB_TDM"` \
			SET \
			`"DB_TDM_ASSAULT_CAPS"` = '%s', \
			`"DB_TDM_ASSAULT_ARMORS"` = '%s', \
			`"DB_TDM_USES_CAP"` = '%s', \
			`"DB_TDM_USES_ARMOUR"` = '%s' \
			WHERE `"DB_TDM_ID"` = '%i'", strCap, strArmour, strUsesCap, strUsesArmour, GetPlayerMySQLID(playerid));
		}
		case TDM_CLASS_MEDIC: {
			SQL("\
			UPDATE `"DB_TDM"` \
			SET \
			`"DB_TDM_MEDIC_CAPS"` = '%s', \
			`"DB_TDM_MEDIC_ARMOURS"` = '%s', \
			`"DB_TDM_USES_CAP"` = '%s', \
			`"DB_TDM_USES_ARMOUR"` = '%s' \
			WHERE `"DB_TDM_ID"` = '%i'", strCap, strArmour, strUsesCap, strUsesArmour, GetPlayerMySQLID(playerid));
		}
		case TDM_CLASS_ENGINEER: {
			SQL("\
			UPDATE `"DB_TDM"` \
			SET \
			`"DB_TDM_ENGINEER_CAPS"` = '%s', \
			`"DB_TDM_ENGINEER_ARMOURS"` = '%s', \
			`"DB_TDM_USES_CAP"` = '%s', \
			`"DB_TDM_USES_ARMOUR"` = '%s' \
			WHERE `"DB_TDM_ID"` = '%i'", strCap, strArmour, strUsesCap, strUsesArmour, GetPlayerMySQLID(playerid));
		}
		case TDM_CLASS_RECON: {
			SQL("\
			UPDATE `"DB_TDM"` \
			SET `"DB_TDM_RECON_CAPS"` = '%s', \
			`"DB_TDM_RECON_ARMOURS"` = '%s', \
			`"DB_TDM_USES_CAP"` = '%s', \
			`"DB_TDM_USES_ARMOUR"` = '%s' \
			WHERE `"DB_TDM_ID"` = '%i'", strCap, strArmour, strUsesCap, strUsesArmour, GetPlayerMySQLID(playerid));
		}
	}
	return 1;
}

stock TDM_SavePlayerClassAbilities(playerid, classid)
{
	switch (classid) {
		case TDM_CLASS_ASSAULT: {
			new
				strAbils[(TDM_MAX_ASSAULT_ABILS * 2) + 1];

			FormatIntArrayToSQL(pAbilsInfo[playerid][classid], TDM_MAX_ASSAULT_ABILS, strAbils);

			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_ASSAULT_ABILITIES"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strAbils, GetPlayerMySQLID(playerid));
		}
		case TDM_CLASS_MEDIC: {
			new
				strAbils[(TDM_MAX_MEDIC_ABILS * 2) + 1];

			FormatIntArrayToSQL(pAbilsInfo[playerid][classid], TDM_MAX_MEDIC_ABILS, strAbils);

			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_MEDIC_ABILITIES"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strAbils, GetPlayerMySQLID(playerid));
		}
		case TDM_CLASS_ENGINEER: {
			new
				strAbils[(TDM_MAX_ENGINEER_ABILS * 2) + 1];

			FormatIntArrayToSQL(pAbilsInfo[playerid][classid], TDM_MAX_ENGINEER_ABILS, strAbils);

			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_ENGINEER_ABILITIES"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strAbils, GetPlayerMySQLID(playerid));
		}
		case TDM_CLASS_RECON: {
			new
				strAbils[(TDM_MAX_RECON_ABILS * 2) + 1];

			FormatIntArrayToSQL(pAbilsInfo[playerid][classid], TDM_MAX_RECON_ABILS, strAbils);

			SQL("UPDATE `"DB_TDM"` SET `"DB_TDM_RECON_ABILITIES"` = '%s' WHERE `"DB_TDM_ID"` = '%i'", strAbils, GetPlayerMySQLID(playerid));
		}
	}
	return 1;
}

stock TDM_SavePlayerClasses(playerid)
{
	static
		strHours[(TDM_MAX_PLAYER_CLASSES * MAX_LENGTH_NUM) + (TDM_MAX_PLAYER_CLASSES * 2) + 1],
		strMinutes[(TDM_MAX_PLAYER_CLASSES * MAX_LENGTH_NUM) + (TDM_MAX_PLAYER_CLASSES * 2) + 1],
		strKills[(TDM_MAX_PLAYER_CLASSES * MAX_LENGTH_NUM) + (TDM_MAX_PLAYER_CLASSES * 2) + 1],
		strDeaths[(TDM_MAX_PLAYER_CLASSES * MAX_LENGTH_NUM) + (TDM_MAX_PLAYER_CLASSES * 2) + 1];

	strHours[0] =
	strMinutes[0] =
	strKills[0] =
	strDeaths[0] = EOS;

	FormatIntArrayToSQL(pStatsInfo[playerid][e_Hours], TDM_MAX_PLAYER_CLASSES, strHours);
	FormatIntArrayToSQL(pStatsInfo[playerid][e_Minutes], TDM_MAX_PLAYER_CLASSES, strMinutes);
	FormatIntArrayToSQL(pStatsInfo[playerid][e_Kills], TDM_MAX_PLAYER_CLASSES, strKills);
	FormatIntArrayToSQL(pStatsInfo[playerid][e_Deaths], TDM_MAX_PLAYER_CLASSES, strDeaths);

	SQL("\
	UPDATE `"DB_TDM"` \
	SET \
	`"DB_TDM_PLAYED_HOURS"` = '%s', \
	`"DB_TDM_PLAYED_MINUTES"` = '%s', \
	`"DB_TDM_KILLS"` = '%s', \
	`"DB_TDM_DEATHS"` = '%s' \
	WHERE `"DB_TDM_ID"` = '%i'", strHours, strMinutes, strKills, strDeaths, GetPlayerMySQLID(playerid));
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

stock TDM_ClResetSessionData(sessionid)
{
	ResetAllClassAirdrop(sessionid, TDM_AIR_WEAPON, -1, true);
	ResetAllClassAirdrop(sessionid, TDM_AIR_MEDICAMENT, -1, true);
	ResetAllClassAirdrop(sessionid, TDM_AIR_AMMO, -1, true);
	return 1;
}

static ResetPlayerClassData(playerid)
{
	PlayerAirMedicationID[playerid] =
	PlayerAirAmmoID[playerid] = -1;

	// Stats
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		pStatsInfo[playerid][e_Kills][c] =
		pStatsInfo[playerid][e_Deaths][c] =
		pStatsInfo[playerid][e_Hours][c] =
		pStatsInfo[playerid][e_Minutes][c] = 0;
	}

	// Weapon
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		n_for2(w, TDM_CLASS_MAX_WEAPONS) {
			pWeaponInfo[playerid][e_Weapon][c][w] =
			pWeaponInfo[playerid][e_Ammo][c][w] = 0;
		}
	}

	// Skills
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		pSkillInfo[playerid][e_M4][c] =
		pSkillInfo[playerid][e_AK47][c] =
		pSkillInfo[playerid][e_Deagle][c] =
		pSkillInfo[playerid][e_Shotgun][c] =
		pSkillInfo[playerid][e_SawShotgun][c] =
		pSkillInfo[playerid][e_Uzi][c] =
		pSkillInfo[playerid][e_MP5][c] =
		pSkillInfo[playerid][e_Sniper][c] = 0.00;

		pSkillInfo[playerid][e_Normal][c] =
		pSkillInfo[playerid][e_Boxing][c] =
		pSkillInfo[playerid][e_KungFu][c] =
		pSkillInfo[playerid][e_KneeHead][c] =
		pSkillInfo[playerid][e_GrabKick][c] =
		pSkillInfo[playerid][e_Elbow][c] = 0.00;
	}

	PlayerAbilTimerMedicHP[playerid] = 
	PlayerAbilTimerVehicle[playerid] = 0;

	// Ability
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		n_for2(a, TDM_MAX_CLASS_ABILITIES) {
			pAbilsInfo[playerid][c][a] = 0;
		}
	}
	n_for(i, TDM_MAX_CLASS_ABILITIES) {
		DialogListClassAbils[playerid][i] = -1;
	}

	// Body
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		pBodyUsesInfo[playerid][e_Cap][c] =
		pBodyUsesInfo[playerid][e_Armour][c] = 0;

		n_for2(b, TDM_MAX_SHOP_BODY) {
			pBodyInfo[playerid][e_Cap][c][b] =
			pBodyInfo[playerid][e_Armour][c][b] = 0;
		}
	}
	return 1;
}

static ResetPlayerClassTDs(playerid)
{
	n_for(i, TDM_TD_SELECT_CLASS) {
		TD_SelectClass[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TDM_TD_SELECTED_CLASS) {
		TD_SelectedClass[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TDM_TD_CLASS_SELECT_WEAPON) {
		TD_SelectWeapon[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TDM_TD_CLASS_BUY_ITEMS) {
		TD_Buy[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

DialogCreate:TDM_ChooseStatsClass(playerid)
{
	Dialog_Open(playerid, Dialog:TDM_ChooseStatsClass, DSL, "Статистика классов", 
	""CT_ORANGE""T_NUM" "CT_WHITE"Штурмовик\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Медик\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Инженер\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Разведчик", 
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:TDM_ChooseStatsClass(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:ChoosePlayerStats);
		return 1;
	}

	switch (listitem) {
		case 0: SetPlayerCustomClass2(playerid, TDM_CLASS_ASSAULT);
		case 1: SetPlayerCustomClass2(playerid, TDM_CLASS_MEDIC);
		case 2: SetPlayerCustomClass2(playerid, TDM_CLASS_ENGINEER);
		case 3: SetPlayerCustomClass2(playerid, TDM_CLASS_RECON);
	}
	Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
	return 1;
}

DialogCreate:TDM_ClassChooseStats(playerid)
{
	new
		str[TDM_MAX_LENGTH_CLASS_NAME],
		classid = GetPlayerCustomClass2(playerid);

	f(str, "%s", TDM_GetClassName(classid));

	Dialog_Open(playerid, Dialog:TDM_ClassChooseStats, DSL, str, 
	""CT_ORANGE""T_NUM" "CT_WHITE"Статистика\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Способности\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Навыки оружия\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Навыки рукопашного боя", 
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:TDM_ClassChooseStats(playerid, response, listitem, inputtext[])
{
	if (!response) {
		if (!Interface_IsOpen(playerid, Interface:TDM_SelectedClass)) {
			SetPlayerCustomClass2(playerid, -1);

			// Dialog_Show(playerid, Dialog:TDM_ChooseStatsClass);
		}
		return 1;
	}

	switch (listitem) {
		case 0: Dialog_Show(playerid, Dialog:TDM_PlayerClassStats);
		case 1: {
			if (GetPlayerCheckPlayerid(playerid) > -1) {
				Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
			}
			else { 
				Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
			}
		}
		case 2: Dialog_Show(playerid, Dialog:TDM_ClSkillsWeapon);
		case 3: Dialog_Show(playerid, Dialog:TDM_ClSkillsCloseFight);
	}
	return 1;
}

DialogCreate:TDM_ClSkillsCFInfo(playerid)
{
	Dialog_Open(playerid, Dialog:TDM_ClSkillsCFInfo, DSM, "Рукопашный бой", ""CT_WHITE"Разные стили рукопашного боя можно прокачать в процессе борьбы с противником.\n10 очков дают +0.5 к урону.", "Хорошо", "");
	return 1;
}

DialogResponse:TDM_ClSkillsCFInfo(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:TDM_ClSkillsCloseFight);
	return 1;
}

DialogCreate:TDM_ClSkillsCloseFight(playerid)
{
	new
		playeridCheck;

	if (GetPlayerCheckPlayerid(playerid) > -1) {
		playeridCheck = GetPlayerCheckPlayerid(playerid);
	}
	else {
		playeridCheck = playerid;
	}

	if (!IsPlayerOnServer(playeridCheck)) {
		return 1;
	}

	if (!IsPlayerOnServer(playerid)) {
		return 1;
	}

	new
		str[100 + TDM_MAX_LENGTH_CLASS_NAME],
		classid = GetPlayerCustomClass2(playerid);

	f(str, "Навыки рукопашного боя "CT_GREY"%s", TDM_GetClassName(classid));

	new
		str1[30],
		str2[30],
		str3[30],
		str4[30],
		str5[30],
		str6[30];

	// Пиздец, да
	if (GetPlayerFightingStyle(playeridCheck) == FIGHT_STYLE_NORMAL)
		str1 = "{33FF33}Вкл";
	else
		str1 = ""CT_RED"Выкл";

	if (GetPlayerFightingStyle(playeridCheck) == FIGHT_STYLE_BOXING)
		str2 = "{33FF33}Вкл";
	else
		str2 = ""CT_RED"Выкл";

	if (GetPlayerFightingStyle(playeridCheck) == FIGHT_STYLE_KUNGFU)
		str3 = "{33FF33}Вкл";
	else
		str3 = ""CT_RED"Выкл";

	if (GetPlayerFightingStyle(playeridCheck) == FIGHT_STYLE_KNEEHEAD)
		str4 = "{33FF33}Вкл";
	else
		str4 = ""CT_RED"Выкл";

	if (GetPlayerFightingStyle(playeridCheck) == FIGHT_STYLE_GRABKICK)
		str5 = "{33FF33}Вкл";
	else
		str5 = ""CT_RED"Выкл";

	if (GetPlayerFightingStyle(playeridCheck) == FIGHT_STYLE_ELBOW)
		str6 = "{33FF33}Вкл";
	else
		str6 = ""CT_RED"Выкл";

	f(strBig,
	"Название\tСтатус\tПрогресс\n\
	"CT_ORANGE""T_NUM" "CT_WHITE"Информация\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Нормальный\t[%s"CT_WHITE"]\t[{EB8624}%.0f/100"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Бокс\t[%s"CT_WHITE"]\t[{EB8624}%.0f/100"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Кунг Фу\t[%s"CT_WHITE"]\t[{EB8624}%.0f/100"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Коленом\t[%s"CT_WHITE"]\t[{EB8624}%.0f/100"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Схватить Удар\t[%s"CT_WHITE"]\t[{EB8624}%.0f/100"CT_WHITE"]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Удар локтём\t[%s"CT_WHITE"]\t[{EB8624}%.0f/100"CT_WHITE"]",
	str1, pSkillInfo[playeridCheck][e_Normal][classid], str2, pSkillInfo[playeridCheck][e_Boxing][classid], str3, pSkillInfo[playeridCheck][e_KungFu][classid], str4, pSkillInfo[playeridCheck][e_KneeHead][classid], str5, pSkillInfo[playeridCheck][e_GrabKick][classid], str6, pSkillInfo[playeridCheck][e_Elbow][classid]);
	
	Dialog_Open(playerid, Dialog:TDM_ClSkillsCloseFight, DSTH, str, strBig, "Выбрать", "Назад");
	return 1;
}

DialogResponse:TDM_ClSkillsCloseFight(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
		return 1;
	}

	if (GetPlayerCheckPlayerid(playerid) > -1) {
		Dialog_Show(playerid, Dialog:TDM_ClSkillsCloseFight);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:TDM_ClSkillsCFInfo);
			return 1;
		}
		case 1: {
			SetPlayerFightingStyleEx(playerid, FIGHT_STYLE_NORMAL);
			SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Выбран стиль "CT_ORANGE"Нормальный");
		}
		case 2: {
			SetPlayerFightingStyleEx(playerid, FIGHT_STYLE_BOXING);
			SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Выбран стиль "CT_ORANGE"Бокс");
		}
		case 3: {
			SetPlayerFightingStyleEx(playerid, FIGHT_STYLE_KUNGFU);
			SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Выбран стиль "CT_ORANGE"Кунг Фу");
		}
		case 4: {
			SetPlayerFightingStyleEx(playerid, FIGHT_STYLE_KNEEHEAD);
			SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Выбран стиль "CT_ORANGE"Коленом");
		}
		case 5: {
			SetPlayerFightingStyleEx(playerid, FIGHT_STYLE_GRABKICK);
			SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Выбран стиль "CT_ORANGE"Схватить Удар");
		}
		case 6: {
			SetPlayerFightingStyleEx(playerid, FIGHT_STYLE_ELBOW);
			SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Выбран стиль "CT_ORANGE"Удар локтём");
		}
	}
	Dialog_Show(playerid, Dialog:TDM_ClSkillsCloseFight);
	return 1;
}

DialogCreate:TDM_ClSkillsWeapon(playerid)
{
	new
		playeridCheck;

	if (GetPlayerCheckPlayerid(playerid) > -1) {
		playeridCheck = GetPlayerCheckPlayerid(playerid);
	}
	else {
		playeridCheck = playerid;
	}

	if (!IsPlayerOnServer(playeridCheck)) {
		return 1;
	}

	if (!IsPlayerOnServer(playerid)) {
		return 1;
	}

	new
		str[100 + TDM_MAX_LENGTH_CLASS_NAME],
		classid = GetPlayerCustomClass2(playerid);

	f(str, "Навыки оружия "CT_GREY"%s", TDM_GetClassName(classid));

	f(strBig,
	""CT_RED"Информация:\
	\n\n"CT_WHITE"При стрельбе из определённого оружия прокачивается навык этого оружия.\
	\nОружие прокачивается при стрельбе и попадании в противника.\
	\n10 очков навыка оружия дают +0.3 к урону по игроку.\
	\n\n{e98e1f}Навыки оружия:\
	\n\n"CT_WHITE""CT_ORANGE""T_NUM" "CT_WHITE"M4 - {FFCC33}%.0f/100\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"AK-47 - {FFCC33}%.0f/100\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Дигл - {FFCC33}%.0f/100\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Дробовик - {FFCC33}%.0f/100\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Обрез - {FFCC33}%.0f/100\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Узи - {FFCC33}%.0f/100\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"МП5 - {FFCC33}%.0f/100\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Снайперская винтовка - {FFCC33}%.0f/100",
	pSkillInfo[playeridCheck][e_M4][classid], pSkillInfo[playeridCheck][e_AK47][classid], pSkillInfo[playeridCheck][e_Deagle][classid], pSkillInfo[playeridCheck][e_Shotgun][classid], pSkillInfo[playeridCheck][e_SawShotgun][classid], pSkillInfo[playeridCheck][e_Uzi][classid], pSkillInfo[playeridCheck][e_MP5][classid], pSkillInfo[playeridCheck][e_Sniper][classid]);
	
	Dialog_Open(playerid, Dialog:TDM_ClSkillsWeapon, DSM, str, strBig, "Назад", "");
	return 1;
}

DialogResponse:TDM_ClSkillsWeapon(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
	return 1;
}

DialogCreate:TDM_PlayerClassStats(playerid)
{
	new
		playeridCheck;

	if (GetPlayerCheckPlayerid(playerid) > -1) {
		playeridCheck = GetPlayerCheckPlayerid(playerid);
	}
	else {
		playeridCheck = playerid;
	}

	if (!IsPlayerOnServer(playeridCheck)) {
		return 1;
	}

	if (!IsPlayerOnServer(playerid)) {
		return 1;
	}

	new
		str[50 + TDM_MAX_LENGTH_CLASS_NAME],
		classid = GetPlayerCustomClass2(playerid),
		Float:text_health,
		Float:text_armour,
		text_ammo[4],
		text_weapon1[MAX_LENGTH_WEAPON_NAME],
		text_weapon2[MAX_LENGTH_WEAPON_NAME],
		text_weapon3[MAX_LENGTH_WEAPON_NAME],
		text_weapon4[MAX_LENGTH_WEAPON_NAME],
		text_hours[15], 
		text_minutes[15];

	TDM_GetClassNeed(classid, TDM_CLASS_NEED_HEALTH, text_health);
	TDM_GetClassNeed(classid, TDM_CLASS_NEED_ARMOUR, text_armour);

	n_for(i, TDM_CLASS_MAX_WEAPONS) {
		text_ammo[i] = pWeaponInfo[playeridCheck][e_Ammo][classid][i];
	}

	GetWeaponNameRU(WEAPON:pWeaponInfo[playeridCheck][e_Weapon][classid][0], text_weapon1, MAX_LENGTH_WEAPON_NAME);
	GetWeaponNameRU(WEAPON:pWeaponInfo[playeridCheck][e_Weapon][classid][1], text_weapon2, MAX_LENGTH_WEAPON_NAME);
	GetWeaponNameRU(WEAPON:pWeaponInfo[playeridCheck][e_Weapon][classid][2], text_weapon3, MAX_LENGTH_WEAPON_NAME);
	GetWeaponNameRU(WEAPON:pWeaponInfo[playeridCheck][e_Weapon][classid][3], text_weapon4, MAX_LENGTH_WEAPON_NAME);

	switch (pStatsInfo[playeridCheck][e_Hours][classid]) {
		case 1: text_hours = "час";
		case 2, 3, 4: text_hours = "часа";
		default: text_hours = "часов";
	}
	switch (pStatsInfo[playeridCheck][e_Minutes][classid]) {
		case 1: text_minutes = "минута";
		case 2, 3, 4: text_minutes = "минуты";
		default: text_minutes = "минут";
	}

	f(str, "Статистика "CT_GREY"%s", TDM_GetClassName(classid));

	f(strBig,
	""CT_GREY"Убийств: "CT_WHITE"[%i]\
	\n"CT_GREY"Смертей: "CT_WHITE"[%i]\
	\n"CT_GREY"Наиграно времени: "CT_WHITE"[%i %s %i %s]\
	\n\n{e98e1f}Оружие:\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"1 слот: {efce13}%s"CT_WHITE", патронов: {7ee21d}%i\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"2 слот: {efce13}%s"CT_WHITE", патронов: {7ee21d}%i\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"3 слот: {efce13}%s"CT_WHITE", патронов: {7ee21d}%i\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"4 слот: {efce13}%s"CT_WHITE", штук: {7ee21d}%i\
	\n\n"CT_RED"Здоровья: %.0f\
	\n{5a6577}Брони: %.0f",
	TDM_GetPlayerClassKills(playeridCheck, classid), TDM_GetPlayerClassDeaths(playeridCheck, classid), pStatsInfo[playeridCheck][e_Hours][classid], text_hours, pStatsInfo[playeridCheck][e_Minutes][classid], text_minutes,
	text_weapon1, text_ammo[0], text_weapon2, text_ammo[1], text_weapon3, text_ammo[2], text_weapon4, text_ammo[3], text_health, text_armour);
	
	Dialog_Open(playerid, Dialog:TDM_PlayerClassStats, DSM, str, strBig, "Назад", "");
	return 1;
}

DialogResponse:TDM_PlayerClassStats(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
	return 1;
}

DialogCreate:TDM_BuyListClAbility(playerid)
{
	static
		string[3000];

	string[0] = EOS;

	new
		str[100 + TDM_MAX_LENGTH_CLASS_NAME],
		classid;

	if (GetPlayerCustomClass2(playerid) != -1) {
		classid = GetPlayerCustomClass2(playerid);
	}
	else {
		if (GetPlayerCustomClass(playerid) != -1) {
			classid = GetPlayerCustomClass(playerid);
		}
	}

	f(str, "{1ad9c9}Покупка способностей %s", TDM_GetClassName(classid));
	strcat(string, "Название\tЦена\n");

	n_for(i, GetPlayerClassMaxAbils(classid)) {
		if (!pAbilsInfo[playerid][classid][i]) {
			f(string, "%s"CT_ORANGE""T_NUM" "CT_WHITE"%s\t{35b025}[$%i]\n", string, TDM_GetClassAbilName(classid, i), TDM_GetClassAbilPrice(classid, i));
		}
		else {
			f(string, "%s"CT_ORANGE""T_NUM" "CT_WHITE"%s\t \n", string, TDM_GetClassAbilName(classid, i));
		}
	}
	Dialog_Open(playerid, Dialog:TDM_BuyListClAbility, DSTH, str, string, "Выбрать", "Выйти");
	return 1;
}

DialogResponse:TDM_BuyListClAbility(playerid, response, listitem, inputtext[])
{
	if (!response) {
		if (GetPlayerCustomClass2(playerid) != -1) {
			Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
		}
		return 1;
	}

	SetPVarInt(playerid, "ClassAbilityID", listitem);
	Dialog_Show(playerid, Dialog:TDM_BuyClassAbility);
	return 1;
}

DialogCreate:TDM_BuyClassAbility(playerid)
{
	new
		classid,
		abilityid = GetPVarInt(playerid, "ClassAbilityID");

	if (GetPlayerCustomClass2(playerid) != -1) {
		classid = GetPlayerCustomClass2(playerid);
	}
	else {
		if (GetPlayerCustomClass(playerid) != -1) {
			classid = GetPlayerCustomClass(playerid);
		}
	}

	static
		string[1000];

	string[0] = EOS;

	new
		str[100 + TDM_MAX_LENGTH_CLASS_NAME];

	f(str, "{1ad9c9}Покупка способности %s", TDM_GetClassName(classid));
	f(string, "{d4d4d4}Способность: {d6a21e}%s\n{d4d4d4}Цена: {1ed630}$%i\n{d4d4d4}В наличии: {1ed630}$%i\n\n{a5d61e}Информация:\n{d4d4d4}%s", TDM_GetClassAbilName(classid, abilityid), TDM_GetClassAbilPrice(classid, abilityid), GetPlayerMoneyEx(playerid), TDM_GetClassAbilInfo(classid, abilityid));
	
	Dialog_Open(playerid, Dialog:TDM_BuyClassAbility, DSM, str, string, "Купить", "Назад");
	return 1;
}

DialogResponse:TDM_BuyClassAbility(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
		return 1;
	}

	new
		classid;

	if (GetPlayerCustomClass2(playerid) != -1) {
		classid = GetPlayerCustomClass2(playerid);
	}
	else {
		if (GetPlayerCustomClass(playerid) != -1) {
			classid = GetPlayerCustomClass(playerid);
		}
	}

	new
		abilityid = GetPVarInt(playerid, "ClassAbilityID");

	if (!pAbilsInfo[playerid][classid][abilityid]) {
		if (GetPlayerMoneyEx(playerid) < TDM_GetClassAbilPrice(classid, abilityid)) {
			Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно денег!");
			return 1;
		}
		else {
			GivePlayerMoneyEx(playerid, -TDM_GetClassAbilPrice(classid, abilityid));
			pAbilsInfo[playerid][classid][abilityid] = 1;

			SavePlayerMoney(playerid);
			TDM_SavePlayerClassAbilities(playerid, classid);

			Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
			SCM(playerid, C_GREEN, ""T_ABILITY" "CT_WHITE"Способность успешно приобретена!");
		}
	}
	else {
		Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Способность уже приобретена!");
	}
	return 1;
}

DialogCreate:TDM_ListClassAbility(playerid)
{
	static
		string[3000];

	string[0] = EOS;

	new
		str[100 + TDM_MAX_LENGTH_CLASS_NAME],
		num = 0,
		classid = GetPlayerCustomClass(playerid);

	n_for(i, TDM_MAX_CLASS_ABILITIES) {
		DialogListClassAbils[playerid][i] = -1;
	}

	n_for(i, GetPlayerClassMaxAbils(classid)) {
		if (pAbilsInfo[playerid][classid][i]) {
			DialogListClassAbils[playerid][num] = i;
			num++;
		}
	}

	f(str, "{1ad9c9}Способности %s", TDM_GetClassName(classid));

	if (num != 0) {
		strcat(string, "Название\tОчков матча\n");
	}

	n_for(i, num) {
		new
			abilityid = DialogListClassAbils[playerid][i];

		if (TDM_GetClassAbilMaxMPoints(classid, abilityid) != 0) {
			f(string, "%s"CT_ORANGE""T_NUM" "CT_WHITE"%s\t{d69c1e}%i-%i ОМ\n", string, TDM_GetClassAbilName(classid, abilityid), TDM_GetClassAbilMPoints(classid, abilityid), TDM_GetClassAbilMaxMPoints(classid, abilityid));
		}
		else {
			f(string, "%s"CT_ORANGE""T_NUM" "CT_WHITE"%s\t{d69c1e}%i ОМ\n", string, TDM_GetClassAbilName(classid, abilityid), TDM_GetClassAbilMPoints(classid, abilityid));
		}
	}

	if (num != 0) {
		strcat(string, " \n"CT_ORANGE""T_NUM" {5acc1d}Приобрести способность");
	}
	else { 
		strcat(string, ""CT_ORANGE""T_NUM" {5acc1d}Приобрести способность");
	}

	if (num != 0) {
		Dialog_Open(playerid, Dialog:TDM_ListClassAbility, DSTH, str, string, "Выбрать", "Выйти");
	}
	else {
		Dialog_Open(playerid, Dialog:TDM_ListClassAbility, DSL, str, string, "Выбрать", "Выйти");
	}
	return 1;
}

DialogResponse:TDM_ListClassAbility(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	new
		classid = GetPlayerCustomClass(playerid),
		num = 0;

	n_for(i, GetPlayerClassMaxAbils(classid)) {
		if (DialogListClassAbils[playerid][num] != -1) {
			num++;
		}
	}

	if (num != 0) {
		num++;
	}

	if (num != 0) {
		if (listitem == num - 1) {
			Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
			return 1;
		}
	}

	if (listitem == num) {
		Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
	}
	else {
		new
			abilityid = DialogListClassAbils[playerid][listitem];

		if (Mode_GetPlayerMatchPoints(playerid) < TDM_GetClassAbilMPoints(classid, abilityid)) {
			Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно очков матча!");
			return 1;
		}
		SetPlayerClassAbility(playerid, abilityid);
	}
	n_for(i, TDM_MAX_CLASS_ABILITIES) {
		DialogListClassAbils[playerid][i] = -1;
	}
	return 1;
}

DialogCreate:TDM_ClassAirdrop(playerid)
{
	switch (GetPlayerCustomClass(playerid)) {
		// Assualt
		case TDM_CLASS_ASSAULT: {
			Dialog_Open(playerid, Dialog:TDM_ClassAirdrop, DSTH, "Типы контейнеров для аирдропа", 
			"Название\tОчков матча\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Информация\
			\n"CT_ORANGE""T_NUM" "CT_GREY"Малый контейнер оружия\t{d69c1e}1000 ОМ\
			\n"CT_ORANGE""T_NUM" {CBAE15}Средний контейнер оружия\t{d69c1e}1500 ОМ\
			\n"CT_ORANGE""T_NUM" {CB1515}Большой контейнер оружия\t{d69c1e}2000 ОМ", 
			"Выбрать", "Выйти");
		}
		// Medic
		case TDM_CLASS_MEDIC: {
			Dialog_Open(playerid, Dialog:TDM_ClassAirdrop, DSTH, "Типы контейнеров для аирдропа", 
			"Название\tОчков матча\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Информация\
			\n"CT_ORANGE""T_NUM" "CT_GREY"Малый контейнер медикаментов\t{d69c1e}1000 ОМ\
			\n"CT_ORANGE""T_NUM" {CBAE15}Средний контейнер медикаментов\t{d69c1e}1500 ОМ\
			\n"CT_ORANGE""T_NUM" {CB1515}Большой контейнер медикаментов\t{d69c1e}2000 ОМ", 
			"Выбрать", "Выйти");
		}
		// Engineer
		case TDM_CLASS_ENGINEER: {
			Dialog_Open(playerid, Dialog:TDM_ClassAirdrop, DSTH, "Типы контейнеров для аирдропа", 
			"Название\tОчков матча\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Информация\
			\n"CT_ORANGE""T_NUM" "CT_GREY"Малый контейнер патронов\t{d69c1e}1000 ОМ\
			\n"CT_ORANGE""T_NUM" {CBAE15}Средний контейнер патронов\t{d69c1e}1500 ОМ\
			\n"CT_ORANGE""T_NUM" {CB1515}Большой контейнер патронов\t{d69c1e}2000 ОМ", 
			"Выбрать", "Выйти");
		}
	}
	return 1;
}

DialogResponse:TDM_ClassAirdrop(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	switch (listitem) {
		case 0: Dialog_Show(playerid, Dialog:TDM_ClassADInfo);
		case 1: Dialog_Show(playerid, Dialog:TDM_ClassAD_1);
		case 2: Dialog_Show(playerid, Dialog:TDM_ClassAD_2);
		case 3: Dialog_Show(playerid, Dialog:TDM_ClassAD_3);
	}
	return 1;
}

DialogCreate:TDM_ClassADInfo(playerid)
{
	switch (GetPlayerCustomClass(playerid)) {
		// Assault
		case TDM_CLASS_ASSAULT: {
			f(strBig, 
			""CT_WHITE"Класс штурмовик вызывает контейнер с оружием и патронами к нему.\
			\n"CT_GREY"Чтобы использовать прибывший контейнер, необходимо подойти к\
			\nнему и нажать на определённую клавишу. Дальше выбрать понравившийся оружие.\
			\n\n"CT_WHITE"Контейнер могут использовать все игроки.\
			\n\n"CT_WHITE"Взорвется через %i секунд после падения.", 
			TDM_AIR_C_TIMER_WEAPON);
		}
		// Medic
		case TDM_CLASS_MEDIC: {
			f(strBig, 
			""CT_WHITE"Класс медик вызывает контейнер с медикаментами.\
			\n"CT_GREY"Для использования прибывшего контейнера, необходимо подойти\
			\nк нему и у вас начнёт пополнятся здоровье.\
			\n\n"CT_WHITE"Контейнер могут использовать все игроки.\
			\n\nВзорвется через %i секунд после падения.", 
			TDM_AIR_C_TIMER_MEDICAMENT);
		}
		// Engineer
		case TDM_CLASS_ENGINEER: {
			f(strBig, 
			""CT_WHITE"Класс инженер вызывает контейнер с патронами.\
			\n"CT_GREY"Для использование прибывшего контейнера, необходимо подойти к нему и\
			\nоружие, которое у вас в руках, будет пополняться патронами.\
			\n\n"CT_WHITE"Контейнер могут использовать все игроки.\
			\n\nВзорвется через %i секунд после падения.", 
			TDM_AIR_C_TIMER_AMMO);
		}
	}
	Dialog_Open(playerid, Dialog:TDM_ClassADInfo, DSM, "Информация", strBig, "Назад", "");
	return 1;
}

DialogResponse:TDM_ClassADInfo(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
	return 1;
}

DialogCreate:TDM_ClassAD_1(playerid)
{
	switch (GetPlayerCustomClass(playerid)) {
		// Assault
		case TDM_CLASS_ASSAULT: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_1, DSM, "Малый контейнер оружия",
			""CT_RED"Информация:\
			\n\n{F7B536}Оружие в контейнере:\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"AK-47 "CT_WHITE"Патронов: "CT_YELLOW"200\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"Кольт "CT_WHITE"Патронов: "CT_YELLOW"30\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"MP5 "CT_WHITE"Патронов: "CT_YELLOW"80\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"Гранаты "CT_WHITE"Штук: "CT_YELLOW"3\n ",
			"Вызвать", "Назад");
		}
		// Medic
		case TDM_CLASS_MEDIC: {
			f(strBig, 
			""CT_RED"Информация:\
			\n\n"CT_WHITE"Данный контейнер пополняет раз в 1 секунду +%i здоровья.", 
			TDM_AIR_C_SMALL_BOARD_MEDICAMENT);

			Dialog_Open(playerid, Dialog:TDM_ClassAD_1, DSM, "Малый контейнер медикаментов", strBig, "Вызвать", "Назад");
		}
		// Engineer
		case TDM_CLASS_ENGINEER: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_1, DSM, "Малый контейнер патронов", 
			""CT_RED"Информация:\
			\n\n"CT_WHITE"Данный контейнер пополняет патроны оружия.", 
			"Вызвать", "Назад");
		}
	}
	return 1;
}

DialogResponse:TDM_ClassAD_1(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
	}

	new
		classid = GetPlayerCustomClass(playerid);

	if (Mode_GetPlayerMatchPoints(playerid) < TDM_GetClassAbilMPoints(classid, TDM_CLASS_ASSAULT)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно очков матча!");
		return 1;
	}

	switch (GetPlayerCustomClass(playerid)) {
		case TDM_CLASS_ASSAULT: SetAirCause(playerid, TDM_AIR_WEAPON, 1);
		case TDM_CLASS_MEDIC: SetAirCause(playerid, TDM_AIR_MEDICAMENT, 1);
		case TDM_CLASS_ENGINEER: SetAirCause(playerid, TDM_AIR_AMMO, 1);
	}
	Mode_GivePlayerMatchPoints(playerid, -TDM_GetClassAbilMPoints(classid, TDM_CLASS_ASSAULT));
	return 1;
}

DialogCreate:TDM_ClassAD_2(playerid)
{
	switch (GetPlayerCustomClass(playerid)) {
		// Assault
		case TDM_CLASS_ASSAULT: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_2, DSM, "Средний контейнер оружия",
			""CT_RED"Информация:\
			\n\n{F7B536}Оружие в контейнере:\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"M4 "CT_WHITE"Патронов: "CT_YELLOW"300\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"Дигл "CT_WHITE"Патронов: "CT_YELLOW"50\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"Обрез "CT_WHITE"Патронов: "CT_YELLOW"30\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"Гранаты "CT_WHITE"Штук: "CT_YELLOW"10\n ", 
			"Вызвать", "Назад");
		}
		// Medic
		case TDM_CLASS_MEDIC: {
			f(strBig, 
			""CT_RED"Информация:\
			\n\n"CT_WHITE"Данный контейнер пополняет раз в 1 секунду +%i здоровья.", 
			TDM_AIR_C_MIDDLE_BOARD_MEDICAMENT);

			Dialog_Open(playerid, Dialog:TDM_ClassAD_2, DSM, "Средний контейнер медикаментов", strBig, "Вызвать", "Назад");
		}
		// Engineer
		case TDM_CLASS_ENGINEER: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_2, DSM, "Средний контейнер патронов", 
			""CT_RED"Информация:\
			\n\n"CT_WHITE"Данный контейнер пополняет патроны оружия немного больше.", 
			"Вызвать", "Назад");
		}
	}
	return 1;
}

DialogResponse:TDM_ClassAD_2(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
	}

	new
		classid = GetPlayerCustomClass(playerid),
		priceAbil = TDM_GetClassAbilMPoints(classid, TDM_CLASS_ASSAULT) + 500;

	if (Mode_GetPlayerMatchPoints(playerid) < priceAbil) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно очков матча!");
		return 1;
	}

	switch (GetPlayerCustomClass(playerid)) {
		case TDM_CLASS_ASSAULT: SetAirCause(playerid, TDM_AIR_WEAPON, 2);
		case TDM_CLASS_MEDIC: SetAirCause(playerid, TDM_AIR_MEDICAMENT, 2);
		case TDM_CLASS_ENGINEER: SetAirCause(playerid, TDM_AIR_AMMO, 2);
	}
	Mode_GivePlayerMatchPoints(playerid, -priceAbil);
	return 1;
}

DialogCreate:TDM_ClassAD_3(playerid)
{
	switch (GetPlayerCustomClass(playerid)) {
		// Assault
		case TDM_CLASS_ASSAULT: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_3, DSM, "Большой контейнер оружия",
			""CT_RED"Информация:\
			\n\n{F7B536}Оружие в контейнере:\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"M4 "CT_WHITE"Патронов: "CT_YELLOW"400\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"Дигл "CT_WHITE"Патронов: "CT_YELLOW"70\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"Узи "CT_WHITE"Патронов: "CT_YELLOW"200\
			\n"CT_ORANGE""T_NUM" "CT_WHITE"Оружие: "CT_GREY"Гранаты "CT_WHITE"Штук: "CT_YELLOW"15\n ", "Вызвать", "Назад");
		}
		// Medic
		case TDM_CLASS_MEDIC: {
			f(strBig, 
			""CT_RED"Информация:\
			\n\n"CT_WHITE"Данный контейнер пополняет раз в 1 секунду +%i здоровья.", 
			TDM_AIR_C_LARGE_BOARD_MEDICAMENT);

			Dialog_Open(playerid, Dialog:TDM_ClassAD_3, DSM, "Большой контейнер медикаментов", strBig, "Вызвать", "Назад");
		}
		// Engineer
		case TDM_CLASS_ENGINEER: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_3, DSM, "Большой контейнер патронов", 
			""CT_RED"Информация:\
			\n\n"CT_WHITE"Данный контейнер пополняет патроны оружия намного больше.", 
			"Вызвать", "Назад");
		}
	}
	return 1;
}

DialogResponse:TDM_ClassAD_3(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
	}

	new
		classid = GetPlayerCustomClass(playerid);

	if (Mode_GetPlayerMatchPoints(playerid) < TDM_GetClassAbilMaxMPoints(classid, TDM_CLASS_ASSAULT)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно очков матча!");
		return 1;
	}

	switch (GetPlayerCustomClass(playerid)) {
		case TDM_CLASS_ASSAULT: SetAirCause(playerid, TDM_AIR_WEAPON, 3);
		case TDM_CLASS_MEDIC: SetAirCause(playerid, TDM_AIR_MEDICAMENT, 3);
		case TDM_CLASS_ENGINEER: SetAirCause(playerid, TDM_AIR_AMMO, 3);
	}
	Mode_GivePlayerMatchPoints(playerid, -TDM_GetClassAbilMaxMPoints(classid, TDM_CLASS_ASSAULT));
	return 1;
}

DialogCreate:TDM_ClassBuyAmmo(playerid)
{
	new
		str1[100],
		str2[300],
		weaponName[MAX_LENGTH_WEAPON_NAME],
		classid = GetPlayerCustomClass2(playerid),
		weapon = GetPVarInt(playerid, "TDM_BuyAmmo") - 1;

	GetWeaponNameRU(WEAPON:pWeaponInfo[playerid][e_Weapon][classid][weapon], weaponName, MAX_LENGTH_WEAPON_NAME);

	f(str1, "{7a916e}Покупка патронов для %s", weaponName);

	f(str2, 
	"{d4d4d4}Введите число патронов, которое хотите купить:\
	\n\nСтоимость одного патрона: {66d433}$%i\
	\n{d4d4d4}В наличии: {66d433}$%i", TDM_GetClassAmmoPrice(classid, weapon, 0), GetPlayerMoneyEx(playerid));

	Dialog_Open(playerid, Dialog:TDM_ClassBuyAmmo, DSI, str1, str2, "Купить", "Выйти");
	return 1;
}

DialogResponse:TDM_ClassBuyAmmo(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "TDM_BuyAmmo");
		return 1;
	}

	new
		classid = GetPlayerCustomClass2(playerid),
		weapon = GetPVarInt(playerid, "TDM_BuyAmmo") - 1;
		
	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
	}

	for (new i = strlen(inputtext) - 1; i != -1; i--) {
		switch (inputtext[i]) {
			case '0'..'9': {
				continue;
			}
			default: {
				return Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
			}	
		}
	}

	if (strval(inputtext) <= 0) {
		return Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
	}

	if (strval(inputtext) + pWeaponInfo[playerid][e_Ammo][classid][weapon] > TDM_GetClassAmmoLimit(classid, weapon)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Больше {d49333}%i патронов "CT_WHITE"запрещено покупать для данного оружия!", TDM_GetClassAmmoLimit(classid, weapon));
		Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
		return 1;
	}

	if (GetPlayerMoneyEx(playerid) < (TDM_GetClassAmmoPrice(classid, weapon, 0) * strval(inputtext))) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Не хватает денег!");
		Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
		return 1;
	}

	DeletePVar(playerid, "TDM_BuyAmmo");

	pWeaponInfo[playerid][e_Ammo][classid][weapon] += strval(inputtext);
	GivePlayerMoneyEx(playerid, -(TDM_GetClassAmmoPrice(classid, weapon, 0) * strval(inputtext)));
	TDM_SavePlayerClassWeapon(playerid, classid);
	ShowInfoClassTD(playerid);

	SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Успешно куплено "CT_ORANGE"%i "CT_WHITE"патронов", strval(inputtext));
	return 1;
}

DialogCreate:TDM_CauseWeapon(playerid)
{
	new
		check,
		airid = GetPVarInt(playerid, "TDM_LocAirID");

	DeletePVar(playerid, "TDM_LocAirID");

	n_for(w, TDM_AIR_C_MAX_WEAPON) {
		if (AirCauseWeapon[airid][e_Weapon][w]) {
			check++;
		}
	}

	if (check > 0) {
		TDM_SetPlayerIDAirdrop(playerid, airid);

		static 
			string[1000];

		string[0] = EOS;

		new
			str[500], 
			name[200];

		name = "Оружие\tПатроны\n";
		strcat(string, name);

		n_for(w, TDM_AIR_C_MAX_WEAPON) {
			if (w != (TDM_AIR_C_MAX_WEAPON - 1)) {
				if (!AirCauseWeapon[airid][e_Weapon][w]) {
					new 
						ww = w + 1;

					AirCauseWeapon[airid][e_Weapon][w] = AirCauseWeapon[airid][e_Weapon][ww];
					AirCauseWeapon[airid][e_WeaponAmmo][w] = AirCauseWeapon[airid][e_WeaponAmmo][ww];

					AirCauseWeapon[airid][e_Weapon][ww] = WEAPON_FIST;
					AirCauseWeapon[airid][e_WeaponAmmo][ww] = 0;
				}
			}
			if (AirCauseWeapon[airid][e_Weapon][w]) {
				new
					weaponName[MAX_LENGTH_WEAPON_NAME];

				GetWeaponNameRU(AirCauseWeapon[airid][e_Weapon][w], weaponName, MAX_LENGTH_WEAPON_NAME);

				f(str, "{C5F9FC}%s\t{DAB767}%i\n", weaponName, AirCauseWeapon[airid][e_WeaponAmmo][w]);
				strcat(string, str);
			}
		}
		Dialog_Open(playerid, Dialog:TDM_CauseWeapon, DSTH, "Оружие в контейнере", string, "Выбрать", "Назад");
	}
	else {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		Dialog_Message(playerid, "Оружие в контейнере", ""CT_WHITE"\tПусто", "Закрыть");
	}
	return 1;
}

DialogResponse:TDM_CauseWeapon(playerid, response, listitem, inputtext[])
{
	new
		airid = TDM_GetPlayerIDAirdrop(playerid);

	if (!AirCauseWeapon[airid][e_Action]) {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		return 1;
	}

	if (!response) {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		return 1;
	}

	n_for(w, TDM_AIR_C_MAX_WEAPON) {
		if (listitem != w) {
			continue;
		}
			
		GivePlayerWeaponEx(playerid, AirCauseWeapon[airid][e_Weapon][w], AirCauseWeapon[airid][e_WeaponAmmo][w]);
		AirCauseWeapon[airid][e_Weapon][w] = WEAPON_FIST;
		AirCauseWeapon[airid][e_WeaponAmmo][w] = 0;

		m_for(MODE_TDM, Mode_GetPlayerSession(playerid), p) {
			if (GetPlayerVirtualWorldEx(p) != AirCauseWeapon[airid][e_VirtualWorld]) {
				continue;
			}

			if (GetPlayerInteriorEx(p) != AirCauseWeapon[airid][e_Interior]) {
				continue;
			}

			if (TDM_GetPlayerIDAirdrop(p) != airid) {
				continue;
			}

			Dialog_Close(p);
			SetPVarInt(p, "TDM_LocAirID", airid);
			Dialog_Show(p, Dialog:TDM_CauseWeapon);
		}
		break;
	}
	return 1;
}

/*
 * |>------------------<|
 * |     Interfaces     |
 * |>------------------<|
 */

InterfaceCreate:TDM_SelectedClass(playerid)
{
	TDM_CreatePlayerSelectedClassTD(playerid, TD_SelectedClass[playerid]);
	ShowInfoClassTD(playerid);

	n_for(i, TDM_TD_SELECTED_CLASS) {
		PlayerTextDrawShow(playerid, TD_SelectedClass[playerid][i]);
	}
	return 1;
}

InterfaceClose:TDM_SelectedClass(playerid)
{
	if (GetPVarInt(playerid, "TDM_ClassBuy")) {
		DeletePVar(playerid, "TDM_SelectClassWeapon");
		DestroyPlayerClassBuyTD(playerid);
		return 1;
	}
	if (GetPVarInt(playerid, "TDM_SelectClassWeapon")) {
		DeletePVar(playerid, "TDM_SelectClassWeapon");

		n_for(i, TDM_TD_CLASS_SELECT_WEAPON) {
			DestroyPlayerTD(playerid, TD_SelectWeapon[playerid][i]);
		}
		return 1;
	}

	n_for(i, TDM_TD_SELECTED_CLASS) {
		DestroyPlayerTD(playerid, TD_SelectedClass[playerid][i]);
	}
	return 1;
}

InterfacePlayerClick:TDM_SelectedClass(playerid, PlayerText:playertextid)
{
	new
		pclass = GetPlayerCustomClass2(playerid);
		
	switch (GetPVarInt(playerid, "TDM_ClassBuy")) {
		// Cap
		case 1: {
			if (playertextid == TD_Buy[playerid][22]) {
				DeletePVar(playerid, "TDM_ClassBuy");

				n_for(i, TDM_TD_CLASS_BUY_ITEMS)
					DestroyPlayerTD(playerid, TD_Buy[playerid][i]);

				Interface_Show(playerid, Interface:TDM_SelectedClass);
				return 1;
			}
			else if (playertextid == TD_Buy[playerid][4]) {
				if (!pBodyUsesInfo[playerid][e_Cap][pclass]) 
					return 1;

				pBodyUsesInfo[playerid][e_Cap][pclass] = 0;
			}
			else if (playertextid == TD_Buy[playerid][5]) {
				if (pBodyUsesInfo[playerid][e_Cap][pclass] == 1) {
					return 1;
				}

				if (pBodyUsesInfo[playerid][e_Cap][pclass] != 1 
				&& pBodyInfo[playerid][e_Cap][pclass][0] == 1) {
					pBodyUsesInfo[playerid][e_Cap][pclass] = 1;
				}

				if (GetPlayerMoneyEx(playerid) < 10000 
				&& pBodyInfo[playerid][e_Cap][pclass][0] != 1) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно денег.");
					return 1;
				}
				if (!pBodyInfo[playerid][e_Cap][pclass][0]) {
					pBodyInfo[playerid][e_Cap][pclass][0] = 1;
					GivePlayerMoneyEx(playerid, -10000);

					SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Куплен шлем "CT_YELLOW"1 класса.");
				}
			}
			else if (playertextid == TD_Buy[playerid][6]) {
				if (pBodyUsesInfo[playerid][e_Cap][pclass] == 2) {
					return 1;
				}

				if (pBodyUsesInfo[playerid][e_Cap][pclass] != 2 
				&& pBodyInfo[playerid][e_Cap][pclass][1] == 1)
					pBodyUsesInfo[playerid][e_Cap][pclass] = 2;

				if (GetPlayerMoneyEx(playerid) < 20000 
				&& pBodyInfo[playerid][e_Cap][pclass][1] != 1) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно денег.");
					return 1;
				}
				if (!pBodyInfo[playerid][e_Cap][pclass][1]) {
					pBodyInfo[playerid][e_Cap][pclass][1] = 1;
					GivePlayerMoneyEx(playerid, -20000);

					SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Куплен шлем "CT_YELLOW"2 класса.");
				}
			}
			else if (playertextid == TD_Buy[playerid][7]) {
				if (pBodyUsesInfo[playerid][e_Cap][pclass] == 3) 
					return 1;

				if (pBodyUsesInfo[playerid][e_Cap][pclass] != 3 
				&& pBodyInfo[playerid][e_Cap][pclass][2] == 1)
					pBodyUsesInfo[playerid][e_Cap][pclass] = 3;

				if (GetPlayerMoneyEx(playerid) < 40000 
				&& pBodyInfo[playerid][e_Cap][pclass][2] != 1) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно денег.");
					return 1;
				}
				if (!pBodyInfo[playerid][e_Cap][pclass][2]) {
					pBodyInfo[playerid][e_Cap][pclass][2] = 1;
					GivePlayerMoneyEx(playerid, -40000);

					SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Куплен шлем "CT_YELLOW"3 класса.");
				}
			}
			TDM_SavePlayerClassBody(playerid, pclass);
			ShowInfoBuyTD(playerid, 1);

			n_for(i, 4)
				PlayerTextDrawShow(playerid, TD_Buy[playerid][i]); // Update background

			PlayerTextDrawSetString(playerid, TD_Buy[playerid][19], "В наличии:_$%i", GetPlayerMoneyEx(playerid));
			return 1;
		}
		// Armour
		case 2: {
			if (playertextid == TD_Buy[playerid][22]) {
				DeletePVar(playerid, "TDM_ClassBuy");

				n_for(i, TDM_TD_CLASS_BUY_ITEMS)
					DestroyPlayerTD(playerid, TD_Buy[playerid][i]);

				Interface_Show(playerid, Interface:TDM_SelectedClass);
				
				return 1;
			}
			else if (playertextid == TD_Buy[playerid][4]) {
				if (!pBodyUsesInfo[playerid][e_Armour][pclass]) 
					return 1;

				pBodyUsesInfo[playerid][e_Armour][pclass] = 0;
			}
			else if (playertextid == TD_Buy[playerid][5]) {
				if (pBodyUsesInfo[playerid][e_Armour][pclass] == 1) 
					return 1;

				if (pBodyUsesInfo[playerid][e_Armour][pclass] != 1 
				&& pBodyInfo[playerid][e_Armour][pclass][0] == 1)
					pBodyUsesInfo[playerid][e_Armour][pclass] = 1;

				if (GetPlayerMoneyEx(playerid) < 15000 
				&& pBodyInfo[playerid][e_Armour][pclass][0] != 1) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно денег.");
					return 1;
				}
				if (!pBodyInfo[playerid][e_Armour][pclass][0]) {
					pBodyInfo[playerid][e_Armour][pclass][0] = 1;
					GivePlayerMoneyEx(playerid, -15000);

					SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Куплен бронежилет "CT_YELLOW"1 класса.");
				}
			}
			else if (playertextid == TD_Buy[playerid][6]) {
				if (pBodyUsesInfo[playerid][e_Armour][pclass] == 2) 
					return 1;

				if (pBodyUsesInfo[playerid][e_Armour][pclass] != 2 
				&& pBodyInfo[playerid][e_Armour][pclass][1] == 1)
					pBodyUsesInfo[playerid][e_Armour][pclass] = 2;

				if (GetPlayerMoneyEx(playerid) < 30000 
				&& pBodyInfo[playerid][e_Armour][pclass][1] != 1) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно денег.");
					return 1;
				}
				if (!pBodyInfo[playerid][e_Armour][pclass][1]) {
					pBodyInfo[playerid][e_Armour][pclass][1] = 1;
					GivePlayerMoneyEx(playerid, -30000);

					SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Куплен бронежилет "CT_YELLOW"2 класса.");
				}
			}
			else if (playertextid == TD_Buy[playerid][7]) {
				if (pBodyUsesInfo[playerid][e_Armour][pclass] == 3) 
					return 1;

				if (pBodyUsesInfo[playerid][e_Armour][pclass] != 3 
				&& pBodyInfo[playerid][e_Armour][pclass][2] == 1)
					pBodyUsesInfo[playerid][e_Armour][pclass] = 3;

				if (GetPlayerMoneyEx(playerid) < 60000 
				&& pBodyInfo[playerid][e_Armour][pclass][2] != 1) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно денег.");
					return 1;
				}
				if (!pBodyInfo[playerid][e_Armour][pclass][2]) {
					pBodyInfo[playerid][e_Armour][pclass][2] = 1;
					GivePlayerMoneyEx(playerid, -60000);

					SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Куплен бронежилет "CT_YELLOW"3 класса.");
				}
			}
			TDM_SavePlayerClassBody(playerid, pclass);
			ShowInfoBuyTD(playerid, 2);

			n_for(i, 4)
				PlayerTextDrawShow(playerid, TD_Buy[playerid][i]); // Update background

			PlayerTextDrawSetString(playerid, TD_Buy[playerid][19], "В наличии:_$%i", GetPlayerMoneyEx(playerid));
			return 1;
		}
	}
	if (GetPVarInt(playerid, "TDM_SelectClassWeapon") > 0) {
		if (playertextid == TD_SelectWeapon[playerid][15]) {
			DeletePVar(playerid, "TDM_SelectClassWeapon");

			n_for(i, TDM_TD_CLASS_SELECT_WEAPON)
				DestroyPlayerTD(playerid, TD_SelectWeapon[playerid][i]);

			Interface_Show(playerid, Interface:TDM_SelectedClass);
			return 1;
		}
		switch (GetPVarInt(playerid, "TDM_SelectClassWeapon")) {
			// 1 cell
			case 1: {
				new 
					slot = 0;

				for (new td = 3, num = 0; num < TDM_CLASS_MAX_WEAPON_SLOTS; td++, num++) {
					if (playertextid == TD_SelectWeapon[playerid][td]) {
						if (WEAPON:pWeaponInfo[playerid][e_Weapon][pclass][slot] == TDM_GetClassWeaponID(pclass, slot, num)) 
							return 1;

						if (pStatsInfo[playerid][e_Kills][pclass] < TDM_GetClassWeaponPrice(pclass, slot, num)) {
							SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно убийств у класса персонажа.");
							return 1;
						}

						pWeaponInfo[playerid][e_Weapon][pclass][slot] = TDM_GetClassWeaponID(pclass, slot, num);
						break;
					}
				}
			}
			// 2 cell
			case 2: {
				new 
					slot = 1;

				for (new td = 3, num = 0; num < TDM_CLASS_MAX_WEAPON_SLOTS; td++, num++) {
					if (playertextid == TD_SelectWeapon[playerid][td]) {
						if (WEAPON:pWeaponInfo[playerid][e_Weapon][pclass][slot] == TDM_GetClassWeaponID(pclass, slot, num)) 
							return 1;

						if (pStatsInfo[playerid][e_Kills][pclass] < TDM_GetClassWeaponPrice(pclass, slot, num)) {
							SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно убийств у класса персонажа.");
							return 1;
						}

						pWeaponInfo[playerid][e_Weapon][pclass][slot] = TDM_GetClassWeaponID(pclass, slot, num);
						break;
					}
				}
			}
			// 3 cell
			case 3: {
				new 
					slot = 2;

				for (new td = 3, num = 0; num < TDM_CLASS_MAX_WEAPON_SLOTS; td++, num++) {
					if (playertextid == TD_SelectWeapon[playerid][td]) {
						if (WEAPON:pWeaponInfo[playerid][e_Weapon][pclass][slot] == TDM_GetClassWeaponID(pclass, slot, num)) 
							return 1;
						
						if (pStatsInfo[playerid][e_Kills][pclass] < TDM_GetClassWeaponPrice(pclass, slot, num)) {
							SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно убийств у класса персонажа.");
							return 1;
						}

						pWeaponInfo[playerid][e_Weapon][pclass][slot] = TDM_GetClassWeaponID(pclass, slot, num);
						break;
					}
				}
			}
			// 4 cell
			case 4: {
				new 
					slot = 3;

				for (new td = 3, num = 0; num < TDM_CLASS_MAX_WEAPON_SLOTS; td++, num++) {
					if (playertextid == TD_SelectWeapon[playerid][td]) {
						if (WEAPON:pWeaponInfo[playerid][e_Weapon][pclass][slot] == TDM_GetClassWeaponID(pclass, slot, num)) 
							return 1;

						if (pStatsInfo[playerid][e_Kills][pclass] < TDM_GetClassWeaponPrice(pclass, slot, num)) {
							SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно убийств у класса персонажа.");
							return 1;
						}

						pWeaponInfo[playerid][e_Weapon][pclass][slot] = TDM_GetClassWeaponID(pclass, slot, num);
						break;
					}
				}
			}
		}
		TDM_SavePlayerClassWeapon(playerid, pclass);
		ShowInfoWeaponTD(playerid);

		n_for(i, 3)
			PlayerTextDrawShow(playerid, TD_SelectWeapon[playerid][i]); // White background

		return 1;
	}
	else if (playertextid == TD_SelectedClass[playerid][9]) {
		n_for(i, TDM_TD_SELECTED_CLASS)
			DestroyPlayerTD(playerid, TD_SelectedClass[playerid][i]);

		SetPVarInt(playerid, "TDM_SelectClassWeapon", 1);
		TDM_CreatePlClassSelectWeaponTD(playerid, TD_SelectWeapon[playerid]);
		ShowInfoWeaponTD(playerid);

		n_for(i, TDM_TD_CLASS_SELECT_WEAPON)
			PlayerTextDrawShow(playerid, TD_SelectWeapon[playerid][i]);

		return 1;
	}
	else if (playertextid == TD_SelectedClass[playerid][10]) {
		n_for(i, TDM_TD_SELECTED_CLASS)
			DestroyPlayerTD(playerid, TD_SelectedClass[playerid][i]);

		SetPVarInt(playerid, "TDM_SelectClassWeapon", 2);
		TDM_CreatePlClassSelectWeaponTD(playerid, TD_SelectWeapon[playerid]);
		ShowInfoWeaponTD(playerid);

		n_for(i, TDM_TD_CLASS_SELECT_WEAPON)
			PlayerTextDrawShow(playerid, TD_SelectWeapon[playerid][i]);

		return 1;
	}
	else if (playertextid == TD_SelectedClass[playerid][11]) {
		n_for(i, TDM_TD_SELECTED_CLASS)
			DestroyPlayerTD(playerid, TD_SelectedClass[playerid][i]);

		SetPVarInt(playerid, "TDM_SelectClassWeapon", 3);
		TDM_CreatePlClassSelectWeaponTD(playerid, TD_SelectWeapon[playerid]);
		ShowInfoWeaponTD(playerid);

		n_for(i, TDM_TD_CLASS_SELECT_WEAPON)
			PlayerTextDrawShow(playerid, TD_SelectWeapon[playerid][i]);

		return 1;
	}
	else if (playertextid == TD_SelectedClass[playerid][12]) {
		n_for(i, TDM_TD_SELECTED_CLASS)
			DestroyPlayerTD(playerid, TD_SelectedClass[playerid][i]);

		SetPVarInt(playerid, "TDM_SelectClassWeapon", 4);
		TDM_CreatePlClassSelectWeaponTD(playerid, TD_SelectWeapon[playerid]);
		ShowInfoWeaponTD(playerid);

		n_for(i, TDM_TD_CLASS_SELECT_WEAPON)
			PlayerTextDrawShow(playerid, TD_SelectWeapon[playerid][i]);

		return 1;
	}
	// 1 cell
	else if (playertextid == TD_SelectedClass[playerid][13]) {
		new 
			playerClass = GetPlayerCustomClass2(playerid);

		if (pWeaponInfo[playerid][e_Ammo][playerClass][0] >= TDM_GetClassAmmoLimit(playerClass, 0)) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Ещё больше патронов запрещено покупать!");
			return 1;
		}
		SetPVarInt(playerid, "TDM_BuyAmmo", 1);
		Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
		return 1;
	}
	// 2 cell
	else if (playertextid == TD_SelectedClass[playerid][14]) {
		new 
			playerClass = GetPlayerCustomClass2(playerid);

		if (pWeaponInfo[playerid][e_Ammo][playerClass][1] >= TDM_GetClassAmmoLimit(playerClass, 1)) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Ещё больше патронов запрещено покупать!");
			return 1;
		}
		SetPVarInt(playerid, "TDM_BuyAmmo", 2);
		Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
		return 1;
	}
	// 3 cell
	else if (playertextid == TD_SelectedClass[playerid][15]) {
		new 
			playerClass = GetPlayerCustomClass2(playerid);

		if (pWeaponInfo[playerid][e_Ammo][playerClass][2] >= TDM_GetClassAmmoLimit(playerClass, 2)) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Ещё больше патронов запрещено покупать!");
			return 1;
		}
		SetPVarInt(playerid, "TDM_BuyAmmo", 3);
		Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
		return 1;
	}
	// 4 cell
	else if (playertextid == TD_SelectedClass[playerid][16]) 
		return 1;
		
	else if (playertextid == TD_SelectedClass[playerid][1]) 
		return Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);

	else if (playertextid == TD_SelectedClass[playerid][26]) {
		n_for(i, TDM_TD_SELECTED_CLASS)
			DestroyPlayerTD(playerid, TD_SelectedClass[playerid][i]);

		SetPlayerCustomClass(playerid, GetPlayerCustomClass2(playerid));
		SetPlayerCustomClass2(playerid, -1);
		ClosePlayerDialog(playerid);

		Interface_Show(playerid, Interface:TDM_SelectSpawn);

		SetPlayerInvisible(playerid, false);
		SetPlayerColorEx(playerid, TDM_GetTeamColorXB(GetPlayerTeamEx(playerid)));
		return 1;
	}
	else if (playertextid == TD_SelectedClass[playerid][23]) {
		SetPlayerCustomClass2(playerid, -1);

		n_for(i, TDM_TD_SELECTED_CLASS)
			DestroyPlayerTD(playerid, TD_SelectedClass[playerid][i]);

		ClosePlayerDialog(playerid);

		Interface_Show(playerid, Interface:TDM_SelectClass);
		return 1;
	}
	else if (playertextid == TD_SelectedClass[playerid][4]) {
		n_for(i, TDM_TD_SELECTED_CLASS)
			DestroyPlayerTD(playerid, TD_SelectedClass[playerid][i]);

		SetPVarInt(playerid, "TDM_ClassBuy", 1);
		TDM_CreatePlayerClassBuyItemsTD(playerid, TD_Buy[playerid]);
		ShowInfoBuyTD(playerid, 1);

		n_for(i, TDM_TD_CLASS_BUY_ITEMS)
			PlayerTextDrawShow(playerid, TD_Buy[playerid][i]);

		return 1;
	}
	else if (playertextid == TD_SelectedClass[playerid][6]) {
		n_for(i, TDM_TD_SELECTED_CLASS) {
			DestroyPlayerTD(playerid, TD_SelectedClass[playerid][i]);
		}

		SetPVarInt(playerid, "TDM_ClassBuy", 2);
		TDM_CreatePlayerClassBuyItemsTD(playerid, TD_Buy[playerid]);
		ShowInfoBuyTD(playerid, 2);

		n_for(i, TDM_TD_CLASS_BUY_ITEMS)
			PlayerTextDrawShow(playerid, TD_Buy[playerid][i]);

		return 1;
	}
	return 1;
}

InterfaceClick:TDM_SelectedClass(playerid, Text:clickedid)
{
	// Click escape
	if (clickedid == INVALID_TEXT_DRAW) {
		if (GetPVarInt(playerid, "TDM_SelectClassWeapon")) {
			DeletePVar(playerid, "TDM_SelectClassWeapon");

			n_for(i, TDM_TD_CLASS_SELECT_WEAPON)
				DestroyPlayerTD(playerid, TD_SelectWeapon[playerid][i]);

			Interface_Show(playerid, Interface:TDM_SelectedClass);
			SelectTextDraw(playerid, TD_C_GREY);
			return 1;
		}
		if (GetPVarInt(playerid, "TDM_ClassBuy")) {
			DeletePVar(playerid, "TDM_ClassBuy");

			n_for(i, TDM_TD_CLASS_BUY_ITEMS)
				DestroyPlayerTD(playerid, TD_Buy[playerid][i]);

			Interface_Show(playerid, Interface:TDM_SelectedClass);
			SelectTextDraw(playerid, TD_C_GREY);
			return 1;
		}
		SetPlayerCustomClass2(playerid, -1);
		Interface_Close(playerid, Interface:TDM_SelectedClass);
		ClosePlayerDialog(playerid);

		Interface_Show(playerid, Interface:TDM_SelectClass);
		SelectTextDraw(playerid, TD_C_GREY);
	}
	return 1;
}

InterfaceCreate:TDM_SelectClass(playerid)
{
	TDM_CreatePlayerSelectClassTD(playerid, TD_SelectClass[playerid]);

	// Skins
	PlayerTextDrawSetPreviewModel(playerid, TD_SelectClass[playerid][4],
	TDM_GetClassSkin(GetPlayerTeamEx(playerid), TDM_CLASS_ASSAULT, GetPlayerSex(playerid)));

	PlayerTextDrawSetPreviewModel(playerid, TD_SelectClass[playerid][5],
	TDM_GetClassSkin(GetPlayerTeamEx(playerid), TDM_CLASS_MEDIC, GetPlayerSex(playerid)));

	PlayerTextDrawSetPreviewModel(playerid, TD_SelectClass[playerid][6],
	TDM_GetClassSkin(GetPlayerTeamEx(playerid), TDM_CLASS_ENGINEER, GetPlayerSex(playerid)));

	PlayerTextDrawSetPreviewModel(playerid, TD_SelectClass[playerid][7],
	TDM_GetClassSkin(GetPlayerTeamEx(playerid), TDM_CLASS_RECON, GetPlayerSex(playerid)));

	// Played hours
	PlayerTextDrawSetString(playerid, TD_SelectClass[playerid][17],
	"Часов:_%i", pStatsInfo[playerid][e_Hours][TDM_CLASS_ASSAULT]);

	PlayerTextDrawSetString(playerid, TD_SelectClass[playerid][18],
	"Часов:_%i", pStatsInfo[playerid][e_Hours][TDM_CLASS_MEDIC]);

	PlayerTextDrawSetString(playerid, TD_SelectClass[playerid][19],
	"Часов:_%i", pStatsInfo[playerid][e_Hours][TDM_CLASS_ENGINEER]);

	PlayerTextDrawSetString(playerid, TD_SelectClass[playerid][20],
	"Часов:_%i", pStatsInfo[playerid][e_Hours][TDM_CLASS_RECON]);

	n_for(i, TDM_TD_SELECT_CLASS) {
		PlayerTextDrawShow(playerid, TD_SelectClass[playerid][i]);
	}
	return 1;
}

InterfaceClose:TDM_SelectClass(playerid)
{
	n_for(i, TDM_TD_SELECT_CLASS) {
		DestroyPlayerTD(playerid, TD_SelectClass[playerid][i]);
	}
	return 1;
}

InterfacePlayerClick:TDM_SelectClass(playerid, PlayerText:playertextid)
{
	if (playertextid == TD_SelectClass[playerid][12]) {
		n_for(i, TDM_TD_SELECT_CLASS)
			DestroyPlayerTD(playerid, TD_SelectClass[playerid][i]);

		Interface_Show(playerid, Interface:TDM_SelectSpawn);
		return 1;
	}
	else if (playertextid == TD_SelectClass[playerid][4])
		SetPlayerCustomClass2(playerid, TDM_CLASS_ASSAULT);

	else if (playertextid == TD_SelectClass[playerid][5])
		SetPlayerCustomClass2(playerid, TDM_CLASS_MEDIC);

	else if (playertextid == TD_SelectClass[playerid][6])
		SetPlayerCustomClass2(playerid, TDM_CLASS_ENGINEER);

	else if (playertextid == TD_SelectClass[playerid][7])
		SetPlayerCustomClass2(playerid, TDM_CLASS_RECON);
	else
		return 1;

	n_for(i, TDM_TD_SELECT_CLASS)
		DestroyPlayerTD(playerid, TD_SelectClass[playerid][i]);

	Interface_Close(playerid, Interface:TDM_SelectClass);
	Interface_Show(playerid, Interface:TDM_SelectedClass);

	CheckPlayerDinaHint(playerid, 11);
	return 1;
}

InterfaceClick:TDM_SelectClass(playerid, Text:clickedid)
{
	// Click escape
	if (clickedid == INVALID_TEXT_DRAW) {
		Interface_Close(playerid, Interface:TDM_SelectClass);

		Interface_Show(playerid, Interface:TDM_SelectSpawn);
		SelectTextDraw(playerid, TD_C_GREY);
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
	ResetPlayerClassData(playerid);
	ResetPlayerClassTDs(playerid);

	#if defined TDM_ClOnPlayerConnect
		return TDM_ClOnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

stock TDM_ClOnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	#pragma unused oldkeys
	
	new
		sessionid = Mode_GetPlayerSession(playerid);

	// ALT
	if (newkeys & KEY_WALK) {
		// Airdrop
		if (AllCauseWeaponCount[sessionid] > 0) {
			n_for(ii, AllCauseWeaponCount[sessionid]) {
				new 
					airid = AllCauseWeaponAir[sessionid][ii];

				if (AirCauseWeapon[airid][e_Action]) {
					if (AirCauseWeapon[airid][e_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) {
						continue;
					}

					if (AirCauseWeapon[airid][e_Interior] != GetPlayerInteriorEx(playerid)) {
						continue;
					}

					if (IsPlayerInRangeOfPoint(playerid, 3.0, AirCauseWeapon[airid][e_PosX], AirCauseWeapon[airid][e_PosY], AirCauseWeapon[airid][e_PosZ])) {
						SetPVarInt(playerid, "TDM_LocAirID", airid);
						Dialog_Show(playerid, Dialog:TDM_CauseWeapon);
						return 1;
					}
				}
			}
		}
	}

	return 0;
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
#define OnPlayerConnect TDM_ClOnPlayerConnect
#if defined TDM_ClOnPlayerConnect
	forward TDM_ClOnPlayerConnect(playerid);
#endif