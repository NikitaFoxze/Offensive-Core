/*

	About: TDM classes system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerKeyStateChange(playerid, newkeys, oldkeys)

		TDM_UploadPlayerClasses(playerid)
	Stock:
		TDM_SetPlayerSkill(playerid, skill_id, style_id, Float:exp)
		TDM_GetPlayerSkill(playerid, skill_id, style_id, &Float:exp)
		TDM_GetPlayerClassWearning(playerid, type_id)
		TDM_GetClassSkin(team_id, class_id, sex_id)
		TDM_GetClassName(class_id)
		TDM_IsClass(class_id)
		TDM_SetPlayerClassKill(playerid, kills)
		TDM_GetPlayerClassKills(playerid, class_id)
		TDM_SetPlayerClassDeaths(playerid, deaths)
		TDM_GetPlayerClassDeaths(playerid, class_id)
		TDM_RemoveClassAbilities(playerid)
		TDM_UpdateTimePlayerClass(playerid)
		TDM_DestroyPlayerClTDBuy(playerid)
		TDM_DestroyAllClassesAirdrop(session_id)
		TDM_UpdateClassesAirdrop(session_id)
		TDM_ShowPlayerClassesAirdrop(playerid)
		TDM_HidePlayerClassesAirdrop(playerid)
		TDM_UpPlayerClassesAirdrop(playerid)
		TDM_SetPlayerClassAmmunition(playerid)
		TDM_SetPlayerAttachItem(playerid, skin_id, cap, armor, head)
		TDM_PlayerClassAttachHead(playerid)
		TDM_UploadPlayerDataClasses(playerid)
		TDM_SavePlClassKillsDeaths(playerid)
		TDM_SavePlayerClassSkills(playerid)
		TDM_SavePlayerClassWeapon(playerid)
		TDM_SavePlayerClassBody(playerid)
		TDM_SavePlayerClassAbilities(playerid)
		TDM_SavePlayerClassTime(playerid)
		TDM_CreateNewUserStatsClass(playerid, query[1000], str[6000])
		TDM_SavePlayerClasses(playerid)
Enums:
	E_TDM_AIR_CAUSE_WEAPON_INFO
	E_TDM_AIR_CAUSE_MEDIC_INFO
	E_TDM_AIR_CAUSE_AMMO_INFO
	E_TDM_PLAYER_CLASS_ABIl_INFO
	E_TDM_PLAYER_CLASS_STATS_INFO
	E_TDM_PLAYER_CLASS_WEAPON_INFO
	E_TDM_PLAYER_BODY_INFO
	E_TDM_PLAYER_CLASS_BODY_INFO
	E_TDM_PLAYER_CLASS_SKILLS_INFO
Commands:
	rep(playerid)
	hp(playerid, params[])
Dialogs:
	TDM_ChooseStatsClass
	TDM_ClassChooseStats
	TDM_ClSkillsCFInfo
	TDM_ClSkillsCloseFight
	TDM_ClSkillsWeapon
	TDM_PlayerClassStats
	TDM_BuyListClAbility
	TDM_BuyClassAbility
	TDM_ListClassAbility
	TDM_ClassAirdrop
	TDM_ClassADInfo
	TDM_ClassAD_1
	TDM_ClassAD_2
	TDM_ClassAD_3
	TDM_ClassBuyAmmo
	PlayerCauseWeapon
Interfaces:
	TDM_SelectedClass
	TDM_SelectClass
------------------------------------------------------------------------------*/

#if defined _INC_TDM_CLASSES_SYSTEM
	#endinput
#endif
#define _INC_TDM_CLASSES_SYSTEM

/*

	* Enums *

*/

enum E_TDM_AIR_CAUSE_WEAPON_INFO {
	Air_ObjectAir,
	Air_ObjectBox,
	//Air_ObjectWeapon[TDM_AIR_C_MAX_OBJ_WEAPON],
	Air_ObjectParachute,
	Air_ObjectSmooke,
	Air_Status,
	bool:Air_Action,
	Air_Type,
	Air_Timer,
	Air_VirtualWorld,
	Air_Interior,
	Air_Weapon[TDM_AIR_C_MAX_WEAPON],
	Air_WeaponAmmo[TDM_AIR_C_MAX_WEAPON],
	Text3D:Air_3DText,
	Float:Air_PosX,
	Float:Air_PosY,
	Float:Air_PosZ
}

enum E_TDM_AIR_CAUSE_MEDIC_INFO {
	Air_ObjectAir,
	Air_ObjectBox,
	//Air_ObjectMedicament[TDM_AIR_C_MAX_OBJECT_MEDICAMENT],
	Air_ObjectParachute,
	Air_ObjectSmooke,
	Air_Status,
	bool:Air_Action,
	Air_Type,
	Air_Timer,
	Air_VirtualWorld,
	Air_Interior,
	Text3D:Air_3DText,
	Float:Air_PosX,
	Float:Air_PosY,
	Float:Air_PosZ
}

enum E_TDM_AIR_CAUSE_AMMO_INFO {
	Air_ObjectAir,
	Air_ObjectBox,
	//Air_ObjectAmmo[TDM_AIR_C_MAX_OBJECT_AMMO],
	Air_ObjectParachute,
	Air_ObjectSmooke,
	Air_Status,
	bool:Air_Action,
	Air_Type,
	Air_Timer,
	Air_VirtualWorld,
	Air_Interior,
	Text3D:Air_3DText,
	Float:Air_PosX,
	Float:Air_PosY,
	Float:Air_PosZ
}

// Player classes ability
enum E_TDM_PLAYER_CLASS_ABIl_INFO {
	CA_Name[50],
	CA_Info[500],
	CA_Price,
	CA_MatchPoints,
	CA_MatchPointsMax,
}

enum E_TDM_PLAYER_CLASS_STATS_INFO {
	cKills,
	cDeaths,
	cHours,
	cMinutes
}

enum E_TDM_PLAYER_CLASS_WEAPON_INFO {
	CW_Weapon,
	CW_Ammo
}

enum E_TDM_PLAYER_BODY_INFO {
	B_Cap,
	B_Armor
}

enum E_TDM_PLAYER_CLASS_BODY_INFO {
	B_CapClass,
	B_ArmorClass
}

enum E_TDM_PLAYER_CLASS_SKILLS_INFO {
	Float:S_M4,
	Float:S_AK47,
	Float:S_Deagle,
	Float:S_Shotgun,
	Float:S_SawShotgun,
	Float:S_Uzi,
	Float:S_MP5,
	Float:S_Sniper,

	Float:S_Normal,
	Float:S_Boxing,
	Float:S_KungFu,
	Float:S_KneeHead,
	Float:S_GrabKick,
	Float:S_Elbow
}

/*

	* Vars *

*/

static
	player_air_medication_id[MAX_PLAYERS],
	player_air_ammo_id[MAX_PLAYERS];

static
	AirCauseWeapon[MAX_PLAYERS][E_TDM_AIR_CAUSE_WEAPON_INFO],
	AllCauseWeaponCount[TDM_MAX_GAME_SESSIONS],
	AllCauseWeaponAir[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS];

static
	AirCauseMedication[MAX_PLAYERS][E_TDM_AIR_CAUSE_MEDIC_INFO],
	AllCauseMedicationCount[TDM_MAX_GAME_SESSIONS],
	AllCauseMedicationAir[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS];

static
	AirCauseAmmo[MAX_PLAYERS][E_TDM_AIR_CAUSE_AMMO_INFO],
	AllCauseAmmoCount[TDM_MAX_GAME_SESSIONS],
	AllCauseAmmoAir[TDM_MAX_GAME_SESSIONS][MAX_PLAYERS];

static
	AbilityMedicHPTimer[MAX_PLAYERS],
	AbilityEngineerVehicleTimer[MAX_PLAYERS];

static
	PlayerClassAbilities[MAX_PLAYERS][TDM_MAX_PLAYER_CLASSES][TDM_MAX_CLASS_ABILITIES],
	DialogListClassAbilities[MAX_PLAYERS][TDM_MAX_CLASS_ABILITIES];

static
	PlayerClass[MAX_PLAYERS][E_TDM_PLAYER_CLASS_STATS_INFO][TDM_MAX_PLAYER_CLASSES],
	PlayerCWeapon[MAX_PLAYERS][E_TDM_PLAYER_CLASS_WEAPON_INFO][TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS],
	PlayerBody[MAX_PLAYERS][E_TDM_PLAYER_BODY_INFO][TDM_MAX_PLAYER_CLASSES],
	PlayerBodyC[MAX_PLAYERS][E_TDM_PLAYER_CLASS_BODY_INFO][TDM_MAX_PLAYER_CLASSES][TDM_MAX_SHOP_BODY],
	Float:PlayerSkill[MAX_PLAYERS][E_TDM_PLAYER_CLASS_SKILLS_INFO][TDM_MAX_PLAYER_CLASSES];

static
	PlayerText:TD_cSelectClass[MAX_PLAYERS][21],
	PlayerText:TD_cSelectedClass[MAX_PLAYERS][27],
	PlayerText:TD_cSelectWeapon[MAX_PLAYERS][16],
	PlayerText:TD_cBuy[MAX_PLAYERS][23];

/*
	Options classes
*/

static const
	ClassesName[TDM_MAX_PLAYER_CLASSES][50] = {
		"Штурмовик", "Медик", "Инженер", "Разведчик"
	};

// Health and Armour
static const
	Float:ClassesNeeds[TDM_MAX_PLAYER_CLASSES][2] = {
		{100.0, 30.0},	// Штурмовик
		{100.0, 10.0},	// Медик
		{100.0, 40.0},	// Инженер
		{100.0, 10.0}	// Разведчик
	};

static const
	ClassesWeaponID[TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS][TDM_CLASS_MAX_WEAPON_SLOTS] = {
		{ {30, 31, 27}, {22, 23, 24}, {16, 17, 18}, {1, 4, 8} },	// Штурмовик
		{ {29, 25, 28}, {22, 23, 24}, {17, 16, 0}, {5, 4, 7} },		// Медик
		{ {30, 27, 26}, {22, 23, 24}, {17, 16, 18}, {8, 5, 9} },	// Инженер
		{ {34, 33, 0}, {22, 23, 0}, {17, 18, 0}, {1, 6, 7} }		// Разведчик
	};

static const
	ClassesWeaponPrice[TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS][TDM_CLASS_MAX_WEAPON_SLOTS] = {
		{ {0, 30, 80}, {0, 10, 50}, {0, 15, 100}, {0, 20, 35} },	// Штурмовик
		{ {0, 25, 85}, {0, 10, 60}, {0, 30, 0}, {0, 20, 40} },		// Медик
		{ {0, 50, 100}, {0, 10, 55}, {0, 15, 70}, {0, 30, 80} },	// Инженер
		{ {0, 50, 0}, {0, 20, 0}, {0, 80, 0}, {0, 25, 40} }			// Разведчик
	};

static const
	ClassesAmmoPrice[TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS][2] = {
		{ {100, 1}, {200, 1}, {350, 1}, {0, 0} },	// Штурмовик
		{ {150, 1}, {50, 1}, {350, 1}, {0, 0} },	// Медик
		{ {100, 1}, {200, 1}, {350, 1}, {0, 0} },	// Инженер
		{ {250, 1}, {50, 1}, {350, 1}, {0, 0} }		// Разведчик
	};

static const
	ClassesAmmoLimit[TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS] = {
		{ 700, 200, 50, 1 },	// Штурмовик
		{ 700, 200, 50, 1 },	// Медик
		{ 700, 200, 50, 1 },	// Инженер
		{ 700, 200, 50, 1 }		// Разведчик
	};

// Male and Female skin
static const
	ClassesSkin[TDM_MAX_TEAMS][TDM_MAX_PLAYER_CLASSES][2] = {
		// Нейтралы
		{
			{0, 0},			// Штурмовик
			{0, 0},			// Медик
			{0, 0},			// Инженер
			{0, 0}			// Разведчик
		},
		// Военные
		{
			{287, 191},		// Штурмовик
			{276, 309},		// Медик
			{179, 191},		// Инженер
			{300, 306}		// Разведчик
		},
		// Повстанцы
		{
			{303, 193},		// Штурмовик
			{275, 308},		// Медик
			{50, 190},		// Инженер
			{124, 193}		// Разведчик
		},
		// Бандиты
		{
			{112, 190},		// Штурмовик
			{70, 308},		// Медик
			{180, 192},		// Инженер
			{122, 226}		// Разведчик
		},
		// Мародёры
		{
			{100, 195},		// Штурмовик
			{274, 308},		// Медик
			{299, 298},		// Инженер
			{248, 93}		// Разведчик
		}
	};

static const
	ClassesAlibity[TDM_MAX_PLAYER_CLASSES][TDM_MAX_CLASS_ABILITIES][E_TDM_PLAYER_CLASS_ABIl_INFO] = {
		// Штурмовик
		{
			{"Аирдроп оружия", "Данная способность позволяет вызвать аирдроп с оружием.\nАирдроп прилетает через 10 секунд после вызова.", 10000, 1000, 2000}
		},
		// Медик
		{
			{"Аирдроп медикаментов", "Данная способность позволяет вызвать аирдроп с медикаментами.\nАирдроп прилетает через 10 секунд после вызова.", 10000, 1000, 2000}
		},
		// Инженер
		{
			{"Аирдроп патронов", "Данная способность позволяет вызвать аирдроп с патронами.\nАирдроп прилетает через 10 секунд после вызова.", 10000, 1000, 2000}
		},
		// Разведчик
		{
			{"Невидимость", "Данная способность позволяет стать невидимым на радарах.\nПосле смерти невидимость пропадает.", 10000, 1000, 0}
		}
	};

/*

	* Functions *

*/

stock TDM_SetPlayerSkill(playerid, skill_id, style_id, Float:exp)
{
	new
		class_id = GetPlayerCustomClass(playerid);

	switch(skill_id) {
		// Рукопашный бой
		case 1: {
			switch(style_id) {
				case FIGHT_STYLE_NORMAL: PlayerSkill[playerid][S_Normal][class_id] += exp;
				case FIGHT_STYLE_BOXING: PlayerSkill[playerid][S_Boxing][class_id] += exp;
				case FIGHT_STYLE_KUNGFU: PlayerSkill[playerid][S_KungFu][class_id] += exp;
				case FIGHT_STYLE_KNEEHEAD: PlayerSkill[playerid][S_KneeHead][class_id] += exp;
				case FIGHT_STYLE_GRABKICK: PlayerSkill[playerid][S_GrabKick][class_id] += exp;
				case FIGHT_STYLE_ELBOW: PlayerSkill[playerid][S_Elbow][class_id] += exp;
			}
		}
		// Оружие
		case 2: {
			switch(style_id) {
				case WEAPONSKILL_M4: PlayerSkill[playerid][S_M4][class_id] += exp;
				case WEAPONSKILL_AK47: PlayerSkill[playerid][S_AK47][class_id] += exp;
				case WEAPONSKILL_DESERT_EAGLE: PlayerSkill[playerid][S_Deagle][class_id] += exp;
				case WEAPONSKILL_SHOTGUN: PlayerSkill[playerid][S_Shotgun][class_id] += exp;
				case WEAPONSKILL_SAWNOFF_SHOTGUN: PlayerSkill[playerid][S_SawShotgun][class_id] += exp;
				case WEAPONSKILL_MICRO_UZI: PlayerSkill[playerid][S_Uzi][class_id] += exp;
				case WEAPONSKILL_MP5: PlayerSkill[playerid][S_MP5][class_id] += exp;
				case WEAPONSKILL_SNIPERRIFLE: PlayerSkill[playerid][S_Sniper][class_id] += exp;
			}
		}
	}
	TDM_SavePlayerClassSkills(playerid);
	return 1;
}

stock TDM_GetPlayerSkill(playerid, skill_id, style_id, &Float:exp)
{
	new
		class_id = GetPlayerCustomClass(playerid);

	switch(skill_id) {
		// Рукопашный бой
		case 1: {
			switch(style_id) {
				case FIGHT_STYLE_NORMAL: exp = PlayerSkill[playerid][S_Normal][class_id];
				case FIGHT_STYLE_BOXING: exp = PlayerSkill[playerid][S_Boxing][class_id];
				case FIGHT_STYLE_KUNGFU: exp = PlayerSkill[playerid][S_KungFu][class_id];
				case FIGHT_STYLE_KNEEHEAD: exp = PlayerSkill[playerid][S_KneeHead][class_id];
				case FIGHT_STYLE_GRABKICK: exp = PlayerSkill[playerid][S_GrabKick][class_id];
				case FIGHT_STYLE_ELBOW: exp = PlayerSkill[playerid][S_Elbow][class_id];
			}
		}
		// Оружие
		case 2: {
			switch(style_id) {
				case WEAPONSKILL_M4: exp = PlayerSkill[playerid][S_M4][class_id];
				case WEAPONSKILL_AK47: exp = PlayerSkill[playerid][S_AK47][class_id];
				case WEAPONSKILL_DESERT_EAGLE: exp = PlayerSkill[playerid][S_Deagle][class_id];
				case WEAPONSKILL_SHOTGUN: exp = PlayerSkill[playerid][S_Shotgun][class_id];
				case WEAPONSKILL_SAWNOFF_SHOTGUN: exp = PlayerSkill[playerid][S_SawShotgun][class_id];
				case WEAPONSKILL_MICRO_UZI: exp = PlayerSkill[playerid][S_Uzi][class_id];
				case WEAPONSKILL_MP5: exp = PlayerSkill[playerid][S_MP5][class_id];
				case WEAPONSKILL_SNIPERRIFLE: exp = PlayerSkill[playerid][S_Sniper][class_id];
			}
		}
	}
	return 1;
}

stock TDM_GetPlayerClassWearning(playerid, type_id)
{
	switch(type_id) {
		case 1: return PlayerBody[playerid][B_Cap][GetPlayerCustomClass(playerid)];
		case 2: return PlayerBody[playerid][B_Armor][GetPlayerCustomClass(playerid)];
	}
	return 0;
}

stock TDM_GetClassSkin(team_id, class_id, sex_id)
{
	return ClassesSkin[team_id][class_id][sex_id];
}

stock TDM_GetClassName(class_id)
{
	new
		str[50];
	
	strcat(str, ClassesName[class_id]);
	return str;
}

stock TDM_IsClass(class_id)
{
	if(class_id < 0
	|| class_id >= TDM_MAX_PLAYER_CLASSES)
		return 0;

	return 1;
}

stock TDM_SetPlayerClassKill(playerid, kills)
{
	if(Mode_GetPlayer(playerid) != MODE_TDM)
		return 1;

	if(GetPlayerCustomClass(playerid) == -1)
		return 1;

	PlayerClass[playerid][cKills][GetPlayerCustomClass(playerid)] = PlayerClass[playerid][cKills][GetPlayerCustomClass(playerid)] + kills;
	return 1;
}

stock TDM_GetPlayerClassKills(playerid, class_id)
{
	return PlayerClass[playerid][cKills][class_id];
}

stock TDM_SetPlayerClassDeaths(playerid, deaths)
{
	if(Mode_GetPlayer(playerid) != MODE_TDM)
		return 1;

	if(GetPlayerCustomClass(playerid) == -1)
		return 1;

	PlayerClass[playerid][cDeaths][GetPlayerCustomClass(playerid)] = PlayerClass[playerid][cDeaths][GetPlayerCustomClass(playerid)] + deaths;
	return 1;
}

stock TDM_GetPlayerClassDeaths(playerid, class_id)
{
	return PlayerClass[playerid][cDeaths][class_id];
}

stock TDM_RemoveClassAbilities(playerid)
{
	n_for(i, TDM_MAX_CLASS_ABILITIES)
		DialogListClassAbilities[playerid][i] = -1;

	return 1;
}

stock TDM_UpdateTimePlayerClass(playerid)
{
	if(Mode_GetPlayer(playerid) != MODE_TDM)
		return 1;

	if(GetPlayerCustomClass(playerid) == -1)
		return 1;

	if(PlayerClass[playerid][cMinutes][GetPlayerCustomClass(playerid)] < 60)
		PlayerClass[playerid][cMinutes][GetPlayerCustomClass(playerid)]++;

	else if(PlayerClass[playerid][cMinutes][GetPlayerCustomClass(playerid)] >= 60) {
		PlayerClass[playerid][cHours][GetPlayerCustomClass(playerid)]++;
		PlayerClass[playerid][cMinutes][GetPlayerCustomClass(playerid)] = 0;
	}
	return 1;
}

stock TDM_DestroyPlayerClTDBuy(playerid)
{
	n_for(i, sizeof(TD_cBuy[]))
		DestroyPlayerTD(playerid, TD_cBuy[playerid][i]);

	return 1;
}

stock TDM_DestroyAllClassesAirdrop(session_id)
{
	// Оружие
	if(AllCauseWeaponCount[session_id] > 0) {
		n_for(ii, AllCauseWeaponCount[session_id]) {
			new
				i = AllCauseWeaponAir[session_id][ii];

			switch(AirCauseWeapon[i][Air_Status]) {
				case 1, 2: {
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectBox]);
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectAir]);
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectSmooke]);
				}
				case 3: {
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectBox]);
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectAir]);
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectSmooke]);
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectParachute]);
				}
				case 4: {
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectBox]);
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectAir]);
					DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectSmooke]);
				}
			}

			if(AirCauseWeapon[i][Air_Action]) 
				DestroyDynamic3DTextLabel(AirCauseWeapon[i][Air_3DText]);
		}
	}
	ResetAllClassAirdrop(session_id, TDM_AIR_WEAPON, -1, true);

	// Медикаменты
	if(AllCauseMedicationCount[session_id] > 0) {
		n_for(ii, AllCauseMedicationCount[session_id]) {
			new 
				i = AllCauseMedicationAir[session_id][ii];

			switch(AirCauseMedication[i][Air_Status]) {
				case 1, 2: {
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectBox]);
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectAir]);
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectSmooke]);
				}
				case 3: {
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectBox]);
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectAir]);
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectSmooke]);
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectParachute]);
				}
				case 4: {
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectBox]);
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectAir]);
					DestroyDynamicObject(AirCauseMedication[i][Air_ObjectSmooke]);
				}
			}
			if(AirCauseMedication[i][Air_Action])
				DestroyDynamic3DTextLabel(AirCauseMedication[i][Air_3DText]);
		}
	}
	ResetAllClassAirdrop(session_id, TDM_AIR_MEDICAMENT, -1, true);

	// Патроны
	if(AllCauseAmmoCount[session_id] > 0) {
		n_for(ii, AllCauseAmmoCount[session_id]) {
			new 
				i = AllCauseAmmoAir[session_id][ii];

			switch(AirCauseAmmo[i][Air_Status]) {
				case 1, 2: {
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectBox]);
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectAir]);
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectSmooke]);
				}
				case 3: {
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectBox]);
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectAir]);
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectSmooke]);
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectParachute]);
				}
				case 4: {
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectBox]);
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectAir]);
					DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectSmooke]);
				}
			}
			if(AirCauseAmmo[i][Air_Action])
				DestroyDynamic3DTextLabel(AirCauseAmmo[i][Air_3DText]);
		}
	}
	ResetAllClassAirdrop(session_id, TDM_AIR_AMMO, -1, true);
	return 1;
}

stock TDM_UpdateClassesAirdrop(session_id)
{
	// Оружие
	if(AllCauseWeaponCount[session_id] > 0) {
		r_for(ii, AllCauseWeaponCount[session_id]) {
			new 
				i = AllCauseWeaponAir[session_id][ii];

			switch(AirCauseWeapon[i][Air_Status]) {
				// Отстыковка
				case 1: {
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirCauseWeapon[i][Air_ObjectAir], ax, ay, az);
					if(ay > (AirCauseWeapon[i][Air_PosY] - 50.0)) {
						AirCauseWeapon[i][Air_Status] = 2;
						new
							Float:bx,
							Float:by,
							Float:bz;

						GetDynamicObjectPos(AirCauseWeapon[i][Air_ObjectBox], bx, by, bz);
						StopDynamicObject(AirCauseWeapon[i][Air_ObjectBox]);
						MoveDynamicObject(AirCauseWeapon[i][Air_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
					}
				}
				// Падение к цели
				case 2: {
					AirCauseWeapon[i][Air_Status] = 3;
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseWeapon[i][Air_ObjectBox], bx, by, bz);

					AirCauseWeapon[i][Air_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirCauseWeapon[i][Air_VirtualWorld], AirCauseWeapon[i][Air_Interior]);

					StopDynamicObject(AirCauseWeapon[i][Air_ObjectBox]);
					MoveDynamicObject(AirCauseWeapon[i][Air_ObjectBox], AirCauseWeapon[i][Air_PosX] - 0.80000, AirCauseWeapon[i][Air_PosY], AirCauseWeapon[i][Air_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
					MoveDynamicObject(AirCauseWeapon[i][Air_ObjectParachute], AirCauseWeapon[i][Air_PosX] - 0.80000 + 0.0203, AirCauseWeapon[i][Air_PosY] - 0.0138, AirCauseWeapon[i][Air_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
					Streamer_UP(MODE_TDM, session_id);
				}
				// Остановка у цели
				case 3: {
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseWeapon[i][Air_ObjectBox], bx, by, bz);
					if((bx == AirCauseWeapon[i][Air_PosX] - 0.80000) 
					&& (by == AirCauseWeapon[i][Air_PosY]) 
					&& (bz == AirCauseWeapon[i][Air_PosZ] - 0.30000)) {
						AirCauseWeapon[i][Air_Status] = 4;
						AirCauseWeapon[i][Air_Timer] = gettime() + TDM_AIR_C_TIMER_WEAPON;
						AirCauseWeapon[i][Air_Action] = true;

						DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectParachute]);
	/*
						AirCauseWeapon[i][Air_ObjectWeapon][0] = CreateDynamicObject(356, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][Air_ObjectWeapon][1] = CreateDynamicObject(2358, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][Air_ObjectWeapon][2] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][Air_ObjectWeapon][3] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][Air_ObjectWeapon][4] = CreateDynamicObject(348, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][Air_ObjectWeapon][5] = CreateDynamicObject(353, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][Air_ObjectWeapon][6] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][Air_ObjectWeapon][7] = CreateDynamicObject(342, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseWeapon[i][Air_ObjectWeapon][8] = CreateDynamicObject(342, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AttachDynamicObjectToObject(AirCauseWeapon[i][Air_ObjectWeapon][8], AirCauseWeapon[i][Air_ObjectBox], -0.1382, 0.0026, 0.8000, 0.0000, 0.0000, 50.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][Air_ObjectWeapon][7], AirCauseWeapon[i][Air_ObjectBox], -0.3000, 0.0000, 0.8000, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][Air_ObjectWeapon][6], AirCauseWeapon[i][Air_ObjectBox], 0.5976, 0.5976, 0.8799, 0.0000, 0.0000, 70.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][Air_ObjectWeapon][5], AirCauseWeapon[i][Air_ObjectBox], -0.4000, 0.4000, 0.7500, 80.0000, 0.0000, 90.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][Air_ObjectWeapon][4], AirCauseWeapon[i][Air_ObjectBox], 0.1000, -0.1732, 0.7500, 90.0000, 0.0000, 30.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][Air_ObjectWeapon][3], AirCauseWeapon[i][Air_ObjectBox], -0.0867, 0.4924, 0.8798, 0.0000, 0.0000, 80.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][Air_ObjectWeapon][2], AirCauseWeapon[i][Air_ObjectBox], 0.5160, -0.3343, 0.8798, 0.0000, 0.0000, -50.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][Air_ObjectWeapon][1], AirCauseWeapon[i][Air_ObjectBox], -0.4000, -0.5999, 0.8500, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirCauseWeapon[i][Air_ObjectWeapon][0], AirCauseWeapon[i][Air_ObjectBox], -0.5000, -0.3000, 0.8000, 50.0000, 0.0000, 0.0000, 1);
	*/
						Show3DTextAirCauseWeapon(i, bx, by, bz);
					}
				}
				// Удаление
				case 4: {
					if(AirCauseWeapon[i][Air_Timer] < gettime()) {
						DestroyDynamic3DTextLabel(AirCauseWeapon[i][Air_3DText]);
						DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectSmooke]);
						DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectBox]);
						DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectAir]);

						ResetAllClassAirdrop(session_id, TDM_AIR_WEAPON, i, false);

						//for(new w = 0; w < TDM_AIR_C_MAX_OBJ_WEAPON; w++) DestroyDynamicObject(AirCauseWeapon[i][Air_ObjectWeapon][w]);

						if(AllCauseWeaponCount[session_id] > 0) 
							AllCauseWeaponCount[session_id]--;

						AllCauseWeaponAir[session_id][ii] = AllCauseWeaponAir[session_id][AllCauseWeaponCount[session_id]];
						AllCauseWeaponAir[session_id][AllCauseWeaponCount[session_id]] = -1;
					}
				}
			}
		}
	}

	// Медикаменты
	if(AllCauseMedicationCount[session_id] > 0) {
		r_for(ii, AllCauseMedicationCount[session_id]) {
			new 
				i = AllCauseMedicationAir[session_id][ii];

			switch(AirCauseMedication[i][Air_Status]) {
				// Отстыковка
				case 1: {
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirCauseMedication[i][Air_ObjectAir], ax, ay, az);
					if(ay > (AirCauseMedication[i][Air_PosY] - 50.0)) {
						AirCauseMedication[i][Air_Status] = 2;
						new
							Float:bx,
							Float:by,
							Float:bz;

						GetDynamicObjectPos(AirCauseMedication[i][Air_ObjectBox], bx, by, bz);
						StopDynamicObject(AirCauseMedication[i][Air_ObjectBox]);
						MoveDynamicObject(AirCauseMedication[i][Air_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
					}
				}
				// Падение к цели
				case 2: {
					AirCauseMedication[i][Air_Status] = 3;
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseMedication[i][Air_ObjectBox], bx, by, bz);

					AirCauseMedication[i][Air_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirCauseMedication[i][Air_VirtualWorld], AirCauseMedication[i][Air_Interior]);

					StopDynamicObject(AirCauseMedication[i][Air_ObjectBox]);
					MoveDynamicObject(AirCauseMedication[i][Air_ObjectBox], AirCauseMedication[i][Air_PosX] - 0.80000, AirCauseMedication[i][Air_PosY], AirCauseMedication[i][Air_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
					MoveDynamicObject(AirCauseMedication[i][Air_ObjectParachute], AirCauseMedication[i][Air_PosX] - 0.80000 + 0.0203, AirCauseMedication[i][Air_PosY] - 0.0138, AirCauseMedication[i][Air_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
					Streamer_UP(MODE_TDM, session_id);
				}
				// Остановка у цели
				case 3: {
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseMedication[i][Air_ObjectBox], bx, by, bz);
					if((bx == AirCauseMedication[i][Air_PosX] - 0.80000) 
					&& (by == AirCauseMedication[i][Air_PosY]) 
					&& (bz == AirCauseMedication[i][Air_PosZ] - 0.30000)) {
						AirCauseMedication[i][Air_Status] = 4;
						AirCauseMedication[i][Air_Timer] = gettime() + TDM_AIR_C_TIMER_MEDICAMENT;
						AirCauseMedication[i][Air_Action] = true;

						DestroyDynamicObject(AirCauseMedication[i][Air_ObjectParachute]);
	/*
						AirCauseMedication[i][Air_ObjectMedicament][0] = CreateDynamicObject(11738, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][1] = CreateDynamicObject(11736, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][2] = CreateDynamicObject(11736, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][3] = CreateDynamicObject(11738, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][4] = CreateDynamicObject(11738, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][5] = CreateDynamicObject(11736, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseMedication[i][Air_ObjectMedicament][6] = CreateDynamicObject(11738, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][6], AirCauseMedication[i][Air_ObjectBox], 0.0000, 0.0000, 0.7760, 0.0000, 0.0000, 20.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][5], AirCauseMedication[i][Air_ObjectBox], 0.4000, 0.1732, 0.7749, 0.0000, 0.0000, -30.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][4], AirCauseMedication[i][Air_ObjectBox], 0.4247, 0.6343, 0.7760, 0.0000, 0.0000, -50.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][3], AirCauseMedication[i][Air_ObjectBox], -0.7000, 0.2000, 0.7760, 0.0000, 0.0000, 90.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][2], AirCauseMedication[i][Air_ObjectBox], -0.1999, 0.3999, 0.7760, 0.0000, 0.0000, 10.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][1], AirCauseMedication[i][Air_ObjectBox], -0.2794, -0.4160, 0.7749, 0.0000, 0.0000, 30.0000, 1);
						AttachDynamicObjectToObject(AirCauseMedication[i][Air_ObjectMedicament][0], AirCauseMedication[i][Air_ObjectBox], 0.5830, -0.4169, 0.7799, 0.0000, 0.0000, 60.0000, 1);
	*/
						Show3DTextAirCauseMedication(i, bx, by, bz);
					}
				}
				// Удаление
				case 4: {
					if(AirCauseMedication[i][Air_Timer] < gettime()) {
						DestroyDynamic3DTextLabel(AirCauseMedication[i][Air_3DText]);
						DestroyDynamicObject(AirCauseMedication[i][Air_ObjectSmooke]);
						DestroyDynamicObject(AirCauseMedication[i][Air_ObjectBox]);
						DestroyDynamicObject(AirCauseMedication[i][Air_ObjectAir]);

						ResetAllClassAirdrop(session_id, TDM_AIR_MEDICAMENT, i, false);

						//for(new w = 0; w < TDM_AIR_C_MAX_OBJECT_MEDICAMENT; w++) DestroyDynamicObject(AirCauseMedication[i][Air_ObjectMedicament][w]);

						if(AllCauseMedicationCount[session_id] > 0) 
							AllCauseMedicationCount[session_id]--;
							
						AllCauseMedicationAir[session_id][ii] = AllCauseMedicationAir[session_id][AllCauseMedicationCount[session_id]];
						AllCauseMedicationAir[session_id][AllCauseMedicationCount[session_id]] = -1;
					}
				}
			}
		}
	}

	// Патроны
	if(AllCauseAmmoCount[session_id] > 0) {
		r_for(ii, AllCauseAmmoCount[session_id]) {
			new 
				i = AllCauseAmmoAir[session_id][ii];

			switch(AirCauseAmmo[i][Air_Status]) {
				// Отстыковка
				case 1: {
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirCauseAmmo[i][Air_ObjectAir], ax, ay, az);
					if(ay > (AirCauseAmmo[i][Air_PosY] - 50.0)) {
						AirCauseAmmo[i][Air_Status] = 2;
						new
							Float:bx,
							Float:by,
							Float:bz;

						GetDynamicObjectPos(AirCauseAmmo[i][Air_ObjectBox], bx, by, bz);
						StopDynamicObject(AirCauseAmmo[i][Air_ObjectBox]);
						MoveDynamicObject(AirCauseAmmo[i][Air_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
					}
				}
				// Падение к цели
				case 2: {
					AirCauseAmmo[i][Air_Status] = 3;
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseAmmo[i][Air_ObjectBox], bx, by, bz);

					AirCauseAmmo[i][Air_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirCauseAmmo[i][Air_VirtualWorld], AirCauseAmmo[i][Air_Interior]);

					StopDynamicObject(AirCauseAmmo[i][Air_ObjectBox]);
					MoveDynamicObject(AirCauseAmmo[i][Air_ObjectBox], AirCauseAmmo[i][Air_PosX] - 0.80000, AirCauseAmmo[i][Air_PosY], AirCauseAmmo[i][Air_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
					MoveDynamicObject(AirCauseAmmo[i][Air_ObjectParachute], AirCauseAmmo[i][Air_PosX] - 0.80000 + 0.0203, AirCauseAmmo[i][Air_PosY] - 0.0138, AirCauseAmmo[i][Air_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
					Streamer_UP(MODE_TDM, session_id);
				}
				// Остановка у цели
				case 3: {
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirCauseAmmo[i][Air_ObjectBox], bx, by, bz);
					if((bx == AirCauseAmmo[i][Air_PosX] - 0.80000) 
					&& (by == AirCauseAmmo[i][Air_PosY]) 
					&& (bz == AirCauseAmmo[i][Air_PosZ] - 0.30000)) {
						AirCauseAmmo[i][Air_Status] = 4;
						AirCauseAmmo[i][Air_Timer] = gettime() + TDM_AIR_C_TIMER_AMMO;
						AirCauseAmmo[i][Air_Action] = true;

						DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectParachute]);
	/*
						AirCauseAmmo[i][Air_ObjectAmmo][0] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][1] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][2] = CreateDynamicObject(2358, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][3] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][4] = CreateDynamicObject(2359, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirCauseAmmo[i][Air_ObjectAmmo][5] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][5], AirCauseAmmo[i][Air_ObjectBox], -0.4576, -0.1101, 0.8799, 0.0000, 0.0000, 80.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][4], AirCauseAmmo[i][Air_ObjectBox], -0.3342, 0.4939, 0.9499, 0.0000, 0.0000, 20.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][3], AirCauseAmmo[i][Air_ObjectBox], 0.4519, -0.4110, 0.8799, 0.0000, 0.0000, -50.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][2], AirCauseAmmo[i][Air_ObjectBox], -0.4000, -0.5999, 0.8500, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][1], AirCauseAmmo[i][Air_ObjectBox], 0.4767, 0.6133, 1.1399, 0.0000, 0.0000, 30.0000, 1);
						AttachDynamicObjectToObject(AirCauseAmmo[i][Air_ObjectAmmo][0], AirCauseAmmo[i][Air_ObjectBox], 0.4999, 0.6000, 0.8899, 0.0000, 0.0000, 0.0000, 1);
	*/
						Show3DTextAirCauseAmmo(i, bx, by, bz);
					}
				}
				// Удаление
				case 4: {
					if(AirCauseAmmo[i][Air_Timer] < gettime()) {
						DestroyDynamic3DTextLabel(AirCauseAmmo[i][Air_3DText]);
						DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectSmooke]);
						DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectBox]);
						DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectAir]);

						ResetAllClassAirdrop(session_id, TDM_AIR_AMMO, i, false);

						//for(new w = 0; w < TDM_AIR_C_MAX_OBJECT_AMMO; w++) DestroyDynamicObject(AirCauseAmmo[i][Air_ObjectAmmo][w]);

						if(AllCauseAmmoCount[session_id] > 0) 
							AllCauseAmmoCount[session_id]--;

						AllCauseAmmoAir[session_id][ii] = AllCauseAmmoAir[session_id][AllCauseAmmoCount[session_id]];
						AllCauseAmmoAir[session_id][AllCauseAmmoCount[session_id]] = -1;
					}
				}
			}
		}
	}
	return 1;
}

stock TDM_UpPlayerClassesAirdrop(playerid)
{
	// Аирдроп медикаментов
	if(player_air_medication_id[playerid] > -1) {
		new
			id = player_air_medication_id[playerid];

		if(IsPlayerInRangeOfPoint(playerid, 5.0, AirCauseMedication[id][Air_PosX], AirCauseMedication[id][Air_PosY], AirCauseMedication[id][Air_PosZ])) {
			new
				Float:health;

			GetPlayerHealthEx(playerid, health);
			if(health < 100.0) {
				new
					str[50];

				switch(AirCauseMedication[id][Air_Type]) {
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
			player_air_medication_id[playerid] = -1;
	}

	// Аирдроп патронов
	if(player_air_medication_id[playerid] > -1) {
		new
			id = player_air_medication_id[playerid];

		if(IsPlayerInRangeOfPoint(playerid, 5.0, AirCauseAmmo[id][Air_PosX], AirCauseAmmo[id][Air_PosY], AirCauseAmmo[id][Air_PosZ])) {
			new
				weapon[7];

			weapon[0] = 2 + AirCauseAmmo[id][Air_Type]; // Пистолеты
			weapon[1] = 1 + AirCauseAmmo[id][Air_Type]; // Дробовики
			weapon[2] = 3 + AirCauseAmmo[id][Air_Type]; // Узи, MP5, Тек9
			weapon[3] = 1 + AirCauseAmmo[id][Air_Type]; // M4, AK-47
			weapon[4] = 0 + AirCauseAmmo[id][Air_Type]; // Винтовки
			weapon[5] = 0 + AirCauseAmmo[id][Air_Type]; // РПГ, Миниган
			weapon[6] = 0 + AirCauseAmmo[id][Air_Type]; // Гранаты

			new
				weaponid = GetPlayerWeapon(playerid),
				string[60];

			switch(weaponid) {
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
		else
			player_air_ammo_id[playerid] = -1;
	}
	return 1;
}

stock TDM_SetPlayerClassAmmunition(playerid)
{
	new
		class_id = GetPlayerCustomClass(playerid);

	SetPlayerHealthEx(playerid, ClassesNeeds[class_id][0]);
	SetPlayerArmourEx(playerid, ClassesNeeds[class_id][1]);

	if(GetPlayerSex(playerid) == SEX_MALE)
		SetPlayerSkinEx(playerid, ClassesSkin[GetPlayerTeamEx(playerid)][class_id][0]);
	else
		SetPlayerSkinEx(playerid, ClassesSkin[GetPlayerTeamEx(playerid)][class_id][1]);

	n_for(w, TDM_CLASS_MAX_WEAPONS)
		GivePlayerWeaponEx(playerid, PlayerCWeapon[playerid][CW_Weapon][class_id][w], PlayerCWeapon[playerid][CW_Ammo][class_id][w]);
	
	Inv_SetPlayerAttachItem(playerid);
	TDM_SetPlayerAttachItem(playerid, GetPlayerSkinEx(playerid), PlayerBody[playerid][B_Cap][class_id], PlayerBody[playerid][B_Armor][class_id], Inv_GetPlayerHead(playerid));
	return 1;
}

stock TDM_SetPlayerAttachItem(playerid, skin_id, cap, armor, head)
{
	if(cap) {
		switch(skin_id) {
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
		if(!head) {
			if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
				RemovePlayerAttachedObject(playerid, 0);
		}
	}
	if(armor) {
		switch(skin_id) {
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
		if(IsPlayerAttachedObjectSlotUsed(playerid, 5))
			RemovePlayerAttachedObject(playerid, 5);
	}
	return 1;
}

stock TDM_PlayerClassAttachHead(playerid)
{
	if(GetPlayerCustomClass(playerid) > -1) {
		if(PlayerBody[playerid][B_Cap][GetPlayerCustomClass(playerid)]) {
			RemovePlayerAttachedObject(playerid, 0);

			switch(GetPlayerSkinEx(playerid)) {
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

static SetPlayerClassAbility(playerid, ability_id)
{
	new
		class_id = GetPlayerCustomClass(playerid);

	switch(class_id) {
		// Штурмовик
		case TDM_C_ASSAULT: {
			switch(ability_id) {
				// Аирдроп оружия
				case 0: {
					if(AirCauseWeapon[playerid][Air_Status]) {
						Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
						SCM(playerid, -1, "{d15021}(Аирдроп) {FFFFFF}Сейчас запрещено вызывать аирдроп.");
						return 1;
					}
					Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
				}
			}
		}
		// Медик
		case TDM_C_MEDIC: {
			switch(ability_id) {
				// Аирдроп медикаментов
				case 0: {
					if(AirCauseMedication[playerid][Air_Status]) {
						Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
						SCM(playerid, -1, "{d15021}(Аирдроп) {FFFFFF}Сейчас запрещено вызывать аирдроп.");
						return 1;
					}
					Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
				}
			}
		}
		// Инженер
		case TDM_C_ENGINEER: {
			switch(ability_id) {
				// Аирдроп боеприпасов
				case 0: {
					if(AirCauseAmmo[playerid][Air_Status]) {
						Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
						SCM(playerid, -1, "{d15021}(Аирдроп) {FFFFFF}Сейчас запрещено вызывать аирдроп.");
						return 1;
					}
					Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
				}
			}
		}
		// Разведчик
		case TDM_C_RECON: {
			switch(ability_id) {
				// Невидимость на радаре
				case 0: {
					if(GetPlayerInvisible(playerid)) {
						Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
						SCM(playerid, -1, "{d15021}(Способность) {FFFFFF}Невидимость уже активирована.");
						return 1;
					}

					SetPlayerInvisible(playerid, true);
					SetPlayerColor(playerid, TDM_ShowTeamColorXB(GetPlayerTeamEx(playerid)) & 0xFFFFFF00);
					Mode_SetPlayerMatchPoint(playerid, -ClassesAlibity[class_id][ability_id][CA_MatchPoints]);

					SCM(playerid, -1, "{d15021}(Способность) {FFFFFF}Невидимость успешно активирована.");
				}
			}
		}
	}
	return 1;
}

static GetPlayerClassMaxAbilities(class_id)
{
	new
		max_abilities;

	switch(class_id) {
		case TDM_C_ASSAULT: max_abilities = TDM_MAX_ASSAULT_ABILS;
		case TDM_C_MEDIC: max_abilities = TDM_MAX_MEDIC_ABILS;
		case TDM_C_ENGINEER: max_abilities = TDM_MAX_ENGINEER_ABILS;
		case TDM_C_RECON: max_abilities = TDM_MAX_RECON_ABILS;
	}
	return max_abilities;
}

static SetStandardClassWeapon(playerid) 
{
	// Штурмовик
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_ASSAULT][0] = 30, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ASSAULT][0] = 150;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_ASSAULT][1] = 22, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ASSAULT][1] = 30;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_ASSAULT][2] = 16, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ASSAULT][2] = 3;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_ASSAULT][3] = 1, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ASSAULT][3] = 1;

	// Медик
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_MEDIC][0] = 29, PlayerCWeapon[playerid][CW_Ammo][TDM_C_MEDIC][0] = 100;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_MEDIC][1] = 22, PlayerCWeapon[playerid][CW_Ammo][TDM_C_MEDIC][1] = 50;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_MEDIC][2] = 17, PlayerCWeapon[playerid][CW_Ammo][TDM_C_MEDIC][2] = 1;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_MEDIC][3] = 5, PlayerCWeapon[playerid][CW_Ammo][TDM_C_MEDIC][3] = 1;

	// Инженер
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_ENGINEER][0] = 30, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ENGINEER][0] = 100;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_ENGINEER][1] = 22, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ENGINEER][1] = 35;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_ENGINEER][2] = 17, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ENGINEER][2] = 2;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_ENGINEER][3] = 8, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ENGINEER][3] = 1;

	// Разведчик
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_RECON][0] = 34, PlayerCWeapon[playerid][CW_Ammo][TDM_C_RECON][0] = 25;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_RECON][1] = 22, PlayerCWeapon[playerid][CW_Ammo][TDM_C_RECON][1] = 40;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_RECON][2] = 17, PlayerCWeapon[playerid][CW_Ammo][TDM_C_RECON][2] = 2;
	PlayerCWeapon[playerid][CW_Weapon][TDM_C_RECON][3] = 1, PlayerCWeapon[playerid][CW_Ammo][TDM_C_RECON][3] = 1;
	return 1;
}

static ShowInfoClass(playerid)
{
	new
		str[50],
		class_id = GetPlayerCustomClass2(playerid);

	PlayerTextDrawSetString(playerid, TD_cSelectedClass[playerid][2], ClassesName[class_id]);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][1], ClassesSkin[GetPlayerTeamEx(playerid)][class_id][GetPlayerSex(playerid) - 1]);

	for(new i = 9, w = 0; w < TDM_CLASS_MAX_WEAPONS; i++, w++) 
		PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][i], GetWeaponModel(PlayerCWeapon[playerid][CW_Weapon][class_id][w]));

	for(new i = 17, w = 0; w < TDM_CLASS_MAX_WEAPONS; i++, w++) {
		f(str, "%i", PlayerCWeapon[playerid][CW_Ammo][class_id][w]);
		PlayerTextDrawSetString(playerid, TD_cSelectedClass[playerid][i], str);
		str[0] = EOS;
	}
	return 1;
}

static ShowInfoWeapon(playerid)
{
	new
		weapon[TDM_CLASS_MAX_WEAPON_SLOTS],
		class_id = GetPlayerCustomClass2(playerid),
		slot = GetPVarInt(playerid, "SelectWeapon_PVar") - 1;

	n_for(c, TDM_CLASS_MAX_WEAPON_SLOTS)
		weapon[c] = ClassesWeaponID[class_id][slot][c];

	for(new td = 3, c = 0; c < TDM_CLASS_MAX_WEAPON_SLOTS; td++, c++) {
		if(weapon[c] != 0) {
			PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][td], GetWeaponModel(weapon[c]));

			new 
				str[100];

			if(PlayerClass[playerid][cKills][class_id] < ClassesWeaponPrice[class_id][slot][c]) {
				f(str, "Требуется~n~%i_убийств", ClassesWeaponPrice[class_id][slot][c]);
				PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][td + 3], -79740929);
			}
			else {
				new
					weapon_name[WEAPON_NAME_MAX_LENGTH];

				GetWeaponNameRU(weapon[c], weapon_name, sizeof(weapon_name));
				f(str, "~n~%s", weapon_name);
				PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][td + 3], -505290753);
			}
			PlayerTextDrawSetString(playerid, TD_cSelectWeapon[playerid][td + 3], str);

			if(PlayerCWeapon[playerid][CW_Weapon][class_id][slot] == weapon[c]) 
				PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][td - 3], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][td - 3], -1717986817);
		}
		else {
			PlayerTextDrawSetSelectable(playerid, TD_cSelectWeapon[playerid][td], false);
			PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][td], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][td], 0.000000, 0.000000, 0.000000, 1000.000000);
			PlayerTextDrawSetString(playerid, TD_cSelectWeapon[playerid][td + 3], "_");
		}
	}

	new
		str[50];

	f(str, "Убийств:_%i", PlayerClass[playerid][cKills][class_id]);
	PlayerTextDrawSetString(playerid, TD_cSelectWeapon[playerid][12], str);
	return 1;
}

static ShowInfoBuy(playerid, type)
{
	new
		class_id = GetPlayerCustomClass2(playerid);

	switch(type) {
		// Шлем
		case 1: {
			PlayerTextDrawSetString(playerid, TD_cBuy[playerid][17], "Выбор_шлема");
			if(PlayerBodyC[playerid][B_CapClass][class_id][0] == 0) 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][13], "$10000");
			else 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][13], "_");

			if(PlayerBodyC[playerid][B_CapClass][class_id][1] == 0) 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][14], "$20000");
			else 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][14], "_");

			if(PlayerBodyC[playerid][B_CapClass][class_id][2] == 0) 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][15], "$40000");
			else 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][15], "_");

			PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][5], 19141);
			PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][6], 19141);
			PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][7], 19141);

			PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][5], 0.000000, -90.000000, 0.000000, 1.000000);
			PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][6], 0.000000, -90.000000, 0.000000, 1.000000);
			PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][7], 0.000000, -90.000000, 0.000000, 1.000000);

			if(PlayerBody[playerid][B_Cap][class_id] == 0) 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][0], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][0], -1717986817);

			if(PlayerBody[playerid][B_Cap][class_id] == 1) 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][1], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][1], -1717986817);

			if(PlayerBody[playerid][B_Cap][class_id] == 2) 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][2], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][2], -1717986817);

			if(PlayerBody[playerid][B_Cap][class_id] == 3) 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][3], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][3], -1717986817);
		}
		// Бронежилет
		case 2: {
			PlayerTextDrawSetString(playerid, TD_cBuy[playerid][17], "Выбор_бронежилета");
			if(PlayerBodyC[playerid][B_ArmorClass][class_id][0] == 0) 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][13], "$15000");
			else 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][13], "_");

			if(PlayerBodyC[playerid][B_ArmorClass][class_id][1] == 0) 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][14], "$30000");
			else 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][14], "_");

			if(PlayerBodyC[playerid][B_ArmorClass][class_id][2] == 0) 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][15], "$60000");
			else 
				PlayerTextDrawSetString(playerid, TD_cBuy[playerid][15], "_");

			PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][5], 1242);
			PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][6], 1242);
			PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][7], 1242);

			if(PlayerBody[playerid][B_Armor][class_id] == 0) 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][0], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][0], -1717986817);

			if(PlayerBody[playerid][B_Armor][class_id] == 1) 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][1], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][1], -1717986817);

			if(PlayerBody[playerid][B_Armor][class_id] == 2) 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][2], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][2], -1717986817);
			
			if(PlayerBody[playerid][B_Armor][class_id] == 3) 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][3], 0x3cba40FF);
			else 
				PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][3], -1717986817);
		}
	}

	new
		string[300];

	f(string, "Денег:_$%i", GetPlayerCredits(playerid));
	PlayerTextDrawSetString(playerid, TD_cBuy[playerid][19], string);
	return 1;
}

static SetAirCause(playerid, airtype, type)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	new
		Float:x, 
		Float:y, 
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	switch(airtype) {
		case TDM_AIR_WEAPON: SetAirCauseWeapon(session_id, playerid, type, x, y, z, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		case TDM_AIR_MEDICAMENT: SetAirCauseMedicament(session_id, playerid, type, x, y, z, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		case TDM_AIR_AMMO: SetAirCauseAmmo(session_id, playerid, type, x, y, z, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	}

	ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 1, 0, 0, 0, 0);

	SCM(playerid, -1, "{DCAE28}(Аирдроп) {FFFFFF}Аирдроп успешно вызван.");
	SetTimerEx("TDM_ClTimerAirCause", 1000, false, "iifff", playerid, airtype, x, y, z);
	return 1;
}

publics TDM_ClTimerAirCause(playerid, airtype, Float:x, Float:y, Float:z) 
{
	new 
		Float:r = 3.0;

	switch(airtype) {
		case TDM_AIR_WEAPON: AirCauseWeapon[playerid][Air_ObjectSmooke] = CreateDynamicObject(18728, x, y, z - r, 0.00000, 0.00000, 0.00000, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		case TDM_AIR_MEDICAMENT: AirCauseMedication[playerid][Air_ObjectSmooke] = CreateDynamicObject(18728, x, y, z - r, 0.00000, 0.00000, 0.00000, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		case TDM_AIR_AMMO: AirCauseAmmo[playerid][Air_ObjectSmooke] = CreateDynamicObject(18728, x, y, z - r, 0.00000, 0.00000, 0.00000, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	}

	Streamer_UP(MODE_TDM, Mode_GetPlayerSession(playerid));
	ApplyAnimation(playerid, "PED", "IDLE_tired", 4.1, 0, 1, 1, 0, 1);
	return 1;
}

static SetAirCauseWeapon(session_id, id, type, Float:x, Float:y, Float:z, virtualworld, interior)
{
	AllCauseWeaponCount[session_id]++;
	n_for(i, MAX_PLAYERS) {
		if(AllCauseWeaponAir[session_id][i] > -1) 
			continue;

		AllCauseWeaponAir[session_id][i] = id;
		break;
	}

	AirCauseWeapon[id][Air_Status] = 1;
	AirCauseWeapon[id][Air_Action] = false;
	AirCauseWeapon[id][Air_Type] = type;
	AirCauseWeapon[id][Air_Timer] = 0;
	AirCauseWeapon[id][Air_VirtualWorld] = virtualworld;
	AirCauseWeapon[id][Air_Interior] = interior;
	AirCauseWeapon[id][Air_PosX] = x;
	AirCauseWeapon[id][Air_PosY] = y;
	AirCauseWeapon[id][Air_PosZ] = z;
	SetAirWeaponAmmo(id, type);

	new 
		Float:r = GetAirRandomPos();

	AirCauseWeapon[id][Air_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirCauseWeapon[id][Air_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirCauseWeapon[id][Air_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 75.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirCauseWeapon[id][Air_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 75.0, 0.00000, 0.00000, 0.00000);
	return 1;
}

static SetAirCauseMedicament(session_id, id, type, Float:x, Float:y, Float:z, virtualworld, interior)
{
	AllCauseMedicationCount[session_id]++;
	n_for(i, MAX_PLAYERS) {
		if(AllCauseMedicationAir[session_id][i] > -1)
			continue;

		AllCauseMedicationAir[session_id][i] = id;
		break;
	}

	AirCauseMedication[id][Air_Status] = 1;
	AirCauseMedication[id][Air_Action] = false;
	AirCauseMedication[id][Air_Type] = type;
	AirCauseMedication[id][Air_Timer] = 0;
	AirCauseMedication[id][Air_VirtualWorld] = virtualworld;
	AirCauseMedication[id][Air_Interior] = interior;
	AirCauseMedication[id][Air_PosX] = x;
	AirCauseMedication[id][Air_PosY] = y;
	AirCauseMedication[id][Air_PosZ] = z;

	new
		Float:r = GetAirRandomPos();

	AirCauseMedication[id][Air_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirCauseMedication[id][Air_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirCauseMedication[id][Air_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 75.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirCauseMedication[id][Air_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 75.0, 0.00000, 0.00000, 0.00000);
	return 1;
}

static SetAirCauseAmmo(session_id, id, type, Float:x, Float:y, Float:z, virtualworld, interior) 
{
	AllCauseAmmoCount[session_id]++;
	n_for(i, MAX_PLAYERS) {
		if(AllCauseAmmoAir[session_id][i] > -1) 
			continue;

		AllCauseAmmoAir[session_id][i] = id;
		break;
	}

	AirCauseAmmo[id][Air_Status] = 1;
	AirCauseAmmo[id][Air_Action] = false;
	AirCauseAmmo[id][Air_Type] = type;
	AirCauseAmmo[id][Air_Timer] = 0;
	AirCauseAmmo[id][Air_VirtualWorld] = virtualworld;
	AirCauseAmmo[id][Air_Interior] = interior;
	AirCauseAmmo[id][Air_PosX] = x;
	AirCauseAmmo[id][Air_PosY] = y;
	AirCauseAmmo[id][Air_PosZ] = z;

	new
		Float:r = GetAirRandomPos();

	AirCauseAmmo[id][Air_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirCauseAmmo[id][Air_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirCauseAmmo[id][Air_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 75.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirCauseAmmo[id][Air_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 75.0, 0.00000, 0.00000, 0.00000);
	return 1;
}

static SetAirWeaponAmmo(id, type)
{
	switch(type) {
		case 1: {
			AirCauseWeapon[id][Air_Weapon][0] = 30;
			AirCauseWeapon[id][Air_Weapon][1] = 22;
			AirCauseWeapon[id][Air_Weapon][2] = 29;
			AirCauseWeapon[id][Air_Weapon][3] = 16;

			AirCauseWeapon[id][Air_WeaponAmmo][0] = 200;
			AirCauseWeapon[id][Air_WeaponAmmo][1] = 30;
			AirCauseWeapon[id][Air_WeaponAmmo][2] = 80;
			AirCauseWeapon[id][Air_WeaponAmmo][3] = 3;
		}
		case 2: {
			AirCauseWeapon[id][Air_Weapon][0] = 31;
			AirCauseWeapon[id][Air_Weapon][1] = 24;
			AirCauseWeapon[id][Air_Weapon][2] = 26;
			AirCauseWeapon[id][Air_Weapon][3] = 16;

			AirCauseWeapon[id][Air_WeaponAmmo][0] = 300;
			AirCauseWeapon[id][Air_WeaponAmmo][1] = 50;
			AirCauseWeapon[id][Air_WeaponAmmo][2] = 30;
			AirCauseWeapon[id][Air_WeaponAmmo][3] = 10;
		}
		case 3: {
			AirCauseWeapon[id][Air_Weapon][0] = 31;
			AirCauseWeapon[id][Air_Weapon][1] = 24;
			AirCauseWeapon[id][Air_Weapon][2] = 28;
			AirCauseWeapon[id][Air_Weapon][3] = 16;

			AirCauseWeapon[id][Air_WeaponAmmo][0] = 400;
			AirCauseWeapon[id][Air_WeaponAmmo][1] = 70;
			AirCauseWeapon[id][Air_WeaponAmmo][2] = 200;
			AirCauseWeapon[id][Air_WeaponAmmo][3] = 15;
		}
	}
	return 1;
}

static ResetAllClassAirdrop(session_id, type, cell, bool:all_reset)
{
	switch(type) {
		// Оружие
		case TDM_AIR_WEAPON: {
			if(cell == -1) {
				n_for(i, MAX_PLAYERS) {
					AirCauseWeapon[i][Air_Action] = false;
					AirCauseWeapon[i][Air_Status] =
					AirCauseWeapon[i][Air_Timer] =
					AirCauseWeapon[i][Air_Type] =
					AirCauseWeapon[i][Air_VirtualWorld] =
					AirCauseWeapon[i][Air_Interior] = 0;
					AirCauseWeapon[i][Air_PosX] =
					AirCauseWeapon[i][Air_PosY] =
					AirCauseWeapon[i][Air_PosZ] = 0.0;
					n_for2(w, TDM_AIR_C_MAX_WEAPON) {
						AirCauseWeapon[i][Air_Weapon][w] =
						AirCauseWeapon[i][Air_WeaponAmmo][w] = 0;
					}
					AirCauseWeapon[i][Air_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
					AirCauseWeapon[i][Air_ObjectSmooke] =
					AirCauseWeapon[i][Air_ObjectBox] =
					AirCauseWeapon[i][Air_ObjectAir] =
					AirCauseWeapon[i][Air_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
				}
			}
			else {
				AirCauseWeapon[cell][Air_Action] = false;
				AirCauseWeapon[cell][Air_Status] =
				AirCauseWeapon[cell][Air_Timer] =
				AirCauseWeapon[cell][Air_Type] =
				AirCauseWeapon[cell][Air_VirtualWorld] =
				AirCauseWeapon[cell][Air_Interior] = 0;
				AirCauseWeapon[cell][Air_PosX] =
				AirCauseWeapon[cell][Air_PosY] =
				AirCauseWeapon[cell][Air_PosZ] = 0.0;
				n_for(w, TDM_AIR_C_MAX_WEAPON) {
					AirCauseWeapon[cell][Air_Weapon][w] =
					AirCauseWeapon[cell][Air_WeaponAmmo][w] = 0;
				}
				AirCauseWeapon[cell][Air_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
				AirCauseWeapon[cell][Air_ObjectSmooke] =
				AirCauseWeapon[cell][Air_ObjectBox] =
				AirCauseWeapon[cell][Air_ObjectAir] =
				AirCauseWeapon[cell][Air_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
			}
			if(all_reset) {
				n_for(i, MAX_PLAYERS)
					AllCauseWeaponAir[session_id][i] = -1;

				AllCauseWeaponCount[session_id] = 0;
			}
		}
		// Медикаменты
		case TDM_AIR_MEDICAMENT: {
			if(cell == -1) {
				n_for(i, MAX_PLAYERS) {
					AirCauseMedication[i][Air_Action] = false;
					AirCauseMedication[i][Air_Status] =
					AirCauseMedication[i][Air_Timer] =
					AirCauseMedication[i][Air_Type] =
					AirCauseMedication[i][Air_VirtualWorld] =
					AirCauseMedication[i][Air_Interior] = 0;
					AirCauseMedication[i][Air_PosX] =
					AirCauseMedication[i][Air_PosY] =
					AirCauseMedication[i][Air_PosZ] = 0.0;

					AirCauseMedication[i][Air_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
					AirCauseMedication[i][Air_ObjectSmooke] =
					AirCauseMedication[i][Air_ObjectBox] =
					AirCauseMedication[i][Air_ObjectAir] =
					AirCauseMedication[i][Air_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
				}
			}
			else {
				AirCauseMedication[cell][Air_Action] = false;
				AirCauseMedication[cell][Air_Status] =
				AirCauseMedication[cell][Air_Timer] =
				AirCauseMedication[cell][Air_Type] =
				AirCauseMedication[cell][Air_VirtualWorld] =
				AirCauseMedication[cell][Air_Interior] = 0;
				AirCauseMedication[cell][Air_PosX] =
				AirCauseMedication[cell][Air_PosY] =
				AirCauseMedication[cell][Air_PosZ] = 0.0;

				AirCauseMedication[cell][Air_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
				AirCauseMedication[cell][Air_ObjectSmooke] =
				AirCauseMedication[cell][Air_ObjectBox] =
				AirCauseMedication[cell][Air_ObjectAir] =
				AirCauseMedication[cell][Air_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
			}
			if(all_reset) {
				n_for(i, MAX_PLAYERS)
					AllCauseMedicationAir[session_id][i] = -1;

				AllCauseMedicationCount[session_id] = 0;
			}
		}
		// Патроны
		case TDM_AIR_AMMO: {
			if(cell == -1) {
				n_for(i, MAX_PLAYERS) {
					AirCauseAmmo[i][Air_Action] = false;
					AirCauseAmmo[i][Air_Status] =
					AirCauseAmmo[i][Air_Timer] =
					AirCauseAmmo[i][Air_Type] =
					AirCauseAmmo[i][Air_VirtualWorld] =
					AirCauseAmmo[i][Air_Interior] = 0;
					AirCauseAmmo[i][Air_PosX] =
					AirCauseAmmo[i][Air_PosY] =
					AirCauseAmmo[i][Air_PosZ] = 0.0;

					AirCauseAmmo[i][Air_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
					AirCauseAmmo[i][Air_ObjectSmooke] =
					AirCauseAmmo[i][Air_ObjectBox] =
					AirCauseAmmo[i][Air_ObjectAir] =
					AirCauseAmmo[i][Air_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
				}
			}
			else {
				AirCauseAmmo[cell][Air_Action] = false;
				AirCauseAmmo[cell][Air_Status] =
				AirCauseAmmo[cell][Air_Timer] =
				AirCauseAmmo[cell][Air_Type] =
				AirCauseAmmo[cell][Air_VirtualWorld] =
				AirCauseAmmo[cell][Air_Interior] = 0;
				AirCauseAmmo[cell][Air_PosX] =
				AirCauseAmmo[cell][Air_PosY] =
				AirCauseAmmo[cell][Air_PosZ] = 0.0;

				AirCauseAmmo[cell][Air_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
				AirCauseAmmo[cell][Air_ObjectSmooke] =
				AirCauseAmmo[cell][Air_ObjectBox] =
				AirCauseAmmo[cell][Air_ObjectAir] =
				AirCauseAmmo[cell][Air_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
			}
			if(all_reset) {
				n_for(i, MAX_PLAYERS)
					AllCauseAmmoAir[session_id][i] = -1;

				AllCauseAmmoCount[session_id] = 0;
			}
		}
	}
	return 1;
}

static Show3DTextAirCauseWeapon(id, Float:x, Float:y, Float:z) 
{
	new
		string[500],
		namebox[200],
		text[50],
		text2[100];

	text = "Вызвал:";
	text2 = "Нажмите";


	switch(AirCauseWeapon[id][Air_Type]) {
		case 1: namebox = TDM_AIR_C_SMALL_RUS_NAME_WEAPON;
		case 2: namebox = TDM_AIR_C_MIDDLE_RUS_NAME_WEAPON;
		case 3: namebox = TDM_AIR_C_LARGE_RUS_NAME_WEAPON;
	}

	f(string,
	""TDM_AIR_C_COLOR_NAME_WEAPON"%s \
	\n\n{FFFFFF}%s {%06x}%s (ID:%i) \
	\n\n{D42C21}%s {E5D110}[ ALT ]", 
	namebox, text, GetPlayerColorEx(id) >>> 8, NameEx(id), id, text2);

	AirCauseWeapon[id][Air_3DText] = CreateDynamic3DTextLabel(string, -1, x, y, z, 11.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorldEx(id), GetPlayerInteriorEx(id));
	return 1;
}

static Show3DTextAirCauseMedication(id, Float:x, Float:y, Float:z)
{
	new
		string[300],
		namebox[100],
		text[100];

	text = "Вызвал:";
	switch(AirCauseMedication[id][Air_Type]) {
		case 1: namebox = TDM_AIR_C_SMALL_RUS_NAME_MEDICAMENT;
		case 2: namebox = TDM_AIR_C_MIDDLE_RUS_NAME_MEDICAMENT;
		case 3: namebox = TDM_AIR_C_LARGE_RUS_NAME_MEDICAMENT;
	}

	f(string, 
	""TDM_AIR_C_COLOR_NAME_MEDICAMENT"%s \
	\n\n{FFFFFF}%s {%06x}%s (ID:%i)", 
	namebox, text, GetPlayerColorEx(id) >>> 8, NameEx(id), id);

	AirCauseMedication[id][Air_3DText] = CreateDynamic3DTextLabel(string, -1, x, y, z, 11.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorldEx(id), GetPlayerInteriorEx(id));
	return 1;
}

static Show3DTextAirCauseAmmo(id, Float:x, Float:y, Float:z)
{
	new
		string[250],
		namebox[100],
		text[100];

	text = "Вызвал:";
	switch(AirCauseAmmo[id][Air_Type]) {
		case 1: namebox = TDM_AIR_C_SMALL_RUS_NAME_AMMO;
		case 2: namebox = TDM_AIR_C_MIDDLE_RUS_NAME_AMMO;
		case 3: namebox = TDM_AIR_C_LARGE_RUS_NAME_AMMO;
	}

	f(string,
	""TDM_AIR_C_COLOR_NAME_AMMO"%s \
	\n\n{FFFFFF}%s {%06x}%s (ID:%i)", 
	namebox, text, GetPlayerColorEx(id) >>> 8, NameEx(id), id);

	AirCauseAmmo[id][Air_3DText] = CreateDynamic3DTextLabel(string, -1, x, y, z, 11.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorldEx(id), GetPlayerInteriorEx(id));
	return 1;
}

/*

	* TextDraws *

*/

static ShowPlayerTDSelectWeapon(playerid)
{
	// Задний белый фон 
	TD_cSelectWeapon[playerid][0] = CreatePlayerTextDraw(playerid, 190.0000, 191.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][0], 80.0000, 69.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][0], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][0], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][0], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Задний белый фон 2
	TD_cSelectWeapon[playerid][1] = CreatePlayerTextDraw(playerid, 273.0000, 191.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][1], 80.0000, 69.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][1], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][1], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][1], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Задний белый фон 3
	TD_cSelectWeapon[playerid][2] = CreatePlayerTextDraw(playerid, 356.0000, 191.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][2], 80.0000, 69.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][2], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][2], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][2], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Задний чёрный фон 1
	TD_cSelectWeapon[playerid][3] = CreatePlayerTextDraw(playerid, 191.0000, 192.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][3], 78.0000, 67.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][3], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectWeapon[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][3], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][3], 0.0000, 0.0000, 70.0000, 2.0000);

	// Задний чёрный фон 2
	TD_cSelectWeapon[playerid][4] = CreatePlayerTextDraw(playerid, 274.0000, 192.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][4], 78.0000, 67.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][4], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectWeapon[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][4], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][4], 0.0000, 0.0000, 70.0000, 2.0000);

	// Задний чёрный фон 3
	TD_cSelectWeapon[playerid][5] = CreatePlayerTextDraw(playerid, 357.0000, 192.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][5], 78.0000, 67.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][5], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][5], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectWeapon[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][5], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][5], 0.0000, 0.0000, 70.0000, 2.0000);

	// Кол-во необходимых убийств / название оружия 1
	TD_cSelectWeapon[playerid][6] = CreatePlayerTextDraw(playerid, 230.0000, 237.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cSelectWeapon[playerid][6], 0.1546, 1.0317);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][6], 2);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][6], -505290753);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][6], 255);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][6], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][6], 0);

	// Кол-во необходимых убийств / название оружия 2
	TD_cSelectWeapon[playerid][7] = CreatePlayerTextDraw(playerid, 313.0000, 237.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cSelectWeapon[playerid][7], 0.1546, 1.0317);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][7], 2);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][7], -79740929);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][7], 255);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][7], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][7], 0);

	// Кол-во необходимых убийств / название оружия 3
	TD_cSelectWeapon[playerid][8] = CreatePlayerTextDraw(playerid, 397.0000, 237.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cSelectWeapon[playerid][8], 0.1546, 1.0317);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][8], 2);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][8], -79740929);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][8], 255);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][8], 0);

	// Задний чёрный фон выбор
	TD_cSelectWeapon[playerid][9] = CreatePlayerTextDraw(playerid, 190.0000, 170.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][9], 246.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][9], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][9], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][9], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][9], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][9], 0.0000, 0.0000, 70.0000, 1000.0000);

	TD_cSelectWeapon[playerid][10] = CreatePlayerTextDraw(playerid, 312.0000, 171.0000, "Выбор_оружия");
	PlayerTextDrawLetterSize(playerid, TD_cSelectWeapon[playerid][10], 0.3426, 1.5834);
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][10], 0.0000, 233.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][10], 2);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][10], -909522945);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][10], 255);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][10], 0);

	// Задний чёрный фон убийств
	TD_cSelectWeapon[playerid][11] = CreatePlayerTextDraw(playerid, 190.0000, 263.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][11], 246.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][11], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][11], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][11], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][11], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][11], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][11], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Кол-во убийств
	TD_cSelectWeapon[playerid][12] = CreatePlayerTextDraw(playerid, 193.0000, 265.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cSelectWeapon[playerid][12], 0.2823, 1.3967);
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][12], 233.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][12], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][12], 919041791);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][12], -952879873);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][12], 0);

	// Задний белый фон назад
	TD_cSelectWeapon[playerid][13] = CreatePlayerTextDraw(playerid, 190.0000, 284.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][13], 43.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][13], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][13], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][13], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][13], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][13], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][13], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Задний чёрный фон назад
	TD_cSelectWeapon[playerid][14] = CreatePlayerTextDraw(playerid, 191.0000, 285.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][14], 41.0000, 16.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][14], 1);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][14], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectWeapon[playerid][14], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectWeapon[playerid][14], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectWeapon[playerid][14], 0.0000, 0.0000, 70.0000, 1000.0000);

	TD_cSelectWeapon[playerid][15] = CreatePlayerTextDraw(playerid, 212.0000, 286.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, TD_cSelectWeapon[playerid][15], 0.2216, 1.4008);
	PlayerTextDrawTextSize(playerid, TD_cSelectWeapon[playerid][15], 15.0000, 40.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectWeapon[playerid][15], 2);
	PlayerTextDrawColor(playerid, TD_cSelectWeapon[playerid][15], -952879873);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectWeapon[playerid][15], -952879873);
	PlayerTextDrawFont(playerid, TD_cSelectWeapon[playerid][15], 2);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectWeapon[playerid][15], true);
	PlayerTextDrawSetProportional(playerid, TD_cSelectWeapon[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectWeapon[playerid][15], 0);
	return 1;
}

static TDM_ShowPlayerTDSelectClass(playerid)
{
	new
		str[100];
	
	// Задний белый фон
	TD_cSelectClass[playerid][0] = CreatePlayerTextDraw(playerid, 158.0000, 176.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][0], 77.0000, 104.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][0], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][0], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон
	TD_cSelectClass[playerid][1] = CreatePlayerTextDraw(playerid, 238.0000, 176.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][1], 77.0000, 104.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][1], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон
	TD_cSelectClass[playerid][2] = CreatePlayerTextDraw(playerid, 318.0000, 176.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][2], 77.0000, 104.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][2], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][2], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон
	TD_cSelectClass[playerid][3] = CreatePlayerTextDraw(playerid, 398.0000, 176.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][3], 77.0000, 104.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][3], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон
	TD_cSelectClass[playerid][4] = CreatePlayerTextDraw(playerid, 159.0000, 177.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][4], 75.0000, 102.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][4], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectClass[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][4], ClassesSkin[GetPlayerTeamEx(playerid)][0][GetPlayerSex(playerid) - 1]);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][4], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон
	TD_cSelectClass[playerid][5] = CreatePlayerTextDraw(playerid, 239.0000, 177.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][5], 75.0000, 102.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][5], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][5], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectClass[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][5], ClassesSkin[GetPlayerTeamEx(playerid)][1][GetPlayerSex(playerid) - 1]);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][5], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон
	TD_cSelectClass[playerid][6] = CreatePlayerTextDraw(playerid, 319.0000, 177.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][6], 75.0000, 102.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][6], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][6], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectClass[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][6], ClassesSkin[GetPlayerTeamEx(playerid)][2][GetPlayerSex(playerid) - 1]);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][6], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон
	TD_cSelectClass[playerid][7] = CreatePlayerTextDraw(playerid, 399.0000, 177.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][7], 75.0000, 102.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][7], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][7], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectClass[playerid][7], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][7], ClassesSkin[GetPlayerTeamEx(playerid)][3][GetPlayerSex(playerid) - 1]);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][7], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон выбора класса
	TD_cSelectClass[playerid][8] = CreatePlayerTextDraw(playerid, 158.0000, 158.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][8], 317.0000, 15.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][8], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][8], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][8], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][8], 287);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][8], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_cSelectClass[playerid][9] = CreatePlayerTextDraw(playerid, 316.0000, 158.0000, "Выбор_класса");
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][9], 0.3010, 1.4797);
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][9], 0.0000, 313.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][9], 2);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][9], -33686529);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][9], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][9], 0);

	// Задний белый фон назад
	TD_cSelectClass[playerid][10] = CreatePlayerTextDraw(playerid, 158.0000, 282.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][10], 53.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][10], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][10], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][10], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][10], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][10], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон назад
	TD_cSelectClass[playerid][11] = CreatePlayerTextDraw(playerid, 159.0000, 283.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][11], 51.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][11], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][11], 589505535);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][11], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectClass[playerid][11], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectClass[playerid][11], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectClass[playerid][11], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_cSelectClass[playerid][12] = CreatePlayerTextDraw(playerid, 185.0000, 285.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][12], 0.2796, 1.3552);
	PlayerTextDrawTextSize(playerid, TD_cSelectClass[playerid][12], 15.0000, 50.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][12], 2);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][12], -1003277313);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][12], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectClass[playerid][12], true);

	TD_cSelectClass[playerid][13] = CreatePlayerTextDraw(playerid, 161.0000, 176.0000, "Штурмовик");
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][13], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][13], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][13], -690563841);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][13], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][13], 0);

	TD_cSelectClass[playerid][14] = CreatePlayerTextDraw(playerid, 241.0000, 176.0000, "Медик");
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][14], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][14], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][14], -690563841);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][14], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][14], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][14], 0);

	TD_cSelectClass[playerid][15] = CreatePlayerTextDraw(playerid, 321.0000, 176.0000, "Инженер");
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][15], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][15], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][15], -690563841);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][15], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][15], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][15], 0);

	TD_cSelectClass[playerid][16] = CreatePlayerTextDraw(playerid, 401.0000, 176.0000, "Разведчик");
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][16], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][16], 1);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][16], -690563841);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][16], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][16], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][16], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][16], 0);

	f(str, "Часов:_%i", PlayerClass[playerid][cHours][TDM_C_ASSAULT]);
	TD_cSelectClass[playerid][17] = CreatePlayerTextDraw(playerid, 231.0000, 265.0000, str);
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][17], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][17], 3);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][17], -1108345857);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][17], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][17], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][17], 0);
	str[0] = EOS;

	f(str, "Часов:_%i", PlayerClass[playerid][cHours][TDM_C_MEDIC]);
	TD_cSelectClass[playerid][18] = CreatePlayerTextDraw(playerid, 311.0000, 265.0000, str);
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][18], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][18], 3);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][18], -1108345857);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][18], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][18], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][18], 0);
	str[0] = EOS;

	f(str, "Часов:_%i", PlayerClass[playerid][cHours][TDM_C_ENGINEER]);
	TD_cSelectClass[playerid][19] = CreatePlayerTextDraw(playerid, 391.0000, 265.0000, str);
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][19], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][19], 3);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][19], -1108345857);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][19], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][19], 0);
	str[0] = EOS;

	f(str, "Часов:_%i", PlayerClass[playerid][cHours][TDM_C_RECON]);
	TD_cSelectClass[playerid][20] = CreatePlayerTextDraw(playerid, 471.0000, 265.0000, str);
	PlayerTextDrawLetterSize(playerid, TD_cSelectClass[playerid][20], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, TD_cSelectClass[playerid][20], 3);
	PlayerTextDrawColor(playerid, TD_cSelectClass[playerid][20], -1108345857);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectClass[playerid][20], 255);
	PlayerTextDrawFont(playerid, TD_cSelectClass[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectClass[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectClass[playerid][20], 0);
	return 1;
}

static ShowPlayerTDSelectedClass(playerid)
{
	// Задний белый фон
	TD_cSelectedClass[playerid][0] = CreatePlayerTextDraw(playerid, 271.0000, 131.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][0], 100.0000, 108.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][0], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][0], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон
	TD_cSelectedClass[playerid][1] = CreatePlayerTextDraw(playerid, 272.0000, 132.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][1], 98.0000, 106.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][1], 303174399);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][1], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][1], 287);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][1], 0.0000, 0.0000, 0.0000, 1.0000);

	// Название класса
	TD_cSelectedClass[playerid][2] = CreatePlayerTextDraw(playerid, 275.0000, 131.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cSelectedClass[playerid][2], 0.1746, 1.4795);
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][2], -73.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][2], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][2], 0);

	// Задний зелёный фон шлем
	TD_cSelectedClass[playerid][3] = CreatePlayerTextDraw(playerid, 374.0000, 131.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][3], 26.0000, 29.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][3], -2136582657);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон шлема
	TD_cSelectedClass[playerid][4] = CreatePlayerTextDraw(playerid, 375.0000, 132.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][4], 24.0000, 27.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][4], 303174399);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][4], 19141);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][4], 0.0000, -90.0000, 0.0000, 1.0000);

	// Задний зелёный фон брон
	TD_cSelectedClass[playerid][5] = CreatePlayerTextDraw(playerid, 374.0000, 163.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][5], 26.0000, 29.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][5], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][5], -2136582657);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][5], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][5], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][5], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон брони
	TD_cSelectedClass[playerid][6] = CreatePlayerTextDraw(playerid, 375.0000, 164.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][6], 24.0000, 27.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][6], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][6], 303174399);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][6], 1242);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][6], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний жёлтый фон покупки
	TD_cSelectedClass[playerid][7] = CreatePlayerTextDraw(playerid, 271.0000, 242.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][7], 100.0000, 52.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][7], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][7], -1500686849);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][7], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][7], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][7], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон покупки
	TD_cSelectedClass[playerid][8] = CreatePlayerTextDraw(playerid, 272.0000, 243.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][8], 98.0000, 50.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][8], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][8], 303174399);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][8], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][8], 287);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][8], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Оружие 1
	TD_cSelectedClass[playerid][9] = CreatePlayerTextDraw(playerid, 274.0000, 245.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][9], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][9], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][9], -1466330369);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][9], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][9], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][9], 0.0000, 30.0000, 160.0000, 1.2999);

	// Оружие 2
	TD_cSelectedClass[playerid][10] = CreatePlayerTextDraw(playerid, 298.0000, 245.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][10], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][10], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][10], -1466330369);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][10], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][10], 348);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][10], 0.0000, 30.0000, 160.0000, 1.1000);

	// Оружие 3
	TD_cSelectedClass[playerid][11] = CreatePlayerTextDraw(playerid, 322.0000, 245.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][11], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][11], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][11], -1466330369);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][11], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][11], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][11], 342);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][11], 0.0000, -30.0000, 50.0000, 0.5000);

	// Оружие 4
	TD_cSelectedClass[playerid][12] = CreatePlayerTextDraw(playerid, 346.0000, 245.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][12], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][12], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][12], -1466330369);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][12], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][12], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][12], 335);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][12], 0.0000, -30.0000, 0.6998, 0.8999);

	// Патроны 1
	TD_cSelectedClass[playerid][13] = CreatePlayerTextDraw(playerid, 274.0000, 269.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][13], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][13], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][13], -1367909889);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][13], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][13], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][13], 2061);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][13], 0.0000, 0.0000, 0.0000, 1.2999);

	// Патроны 2
	TD_cSelectedClass[playerid][14] = CreatePlayerTextDraw(playerid, 298.0000, 269.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][14], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][14], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][14], -1367909889);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][14], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][14], 2061);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][14], 0.0000, 0.0000, 0.0000, 1.2999);

	// Патроны 3
	TD_cSelectedClass[playerid][15] = CreatePlayerTextDraw(playerid, 322.0000, 269.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][15], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][15], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][15], -1367909889);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][15], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][15], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][15], 2061);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][15], 0.0000, 0.0000, 0.0000, 1.2999);

	// Патроны 4
	TD_cSelectedClass[playerid][16] = CreatePlayerTextDraw(playerid, 346.0000, 269.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][16], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][16], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][16], -1367909889);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][16], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][16], false);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][16], 2061);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][16], 0.0000, 0.0000, 0.0000, 1.2999);

	// Кол-во патронов 1
	TD_cSelectedClass[playerid][17] = CreatePlayerTextDraw(playerid, 285.0000, 268.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cSelectedClass[playerid][17], 0.1726, 1.0317);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][17], 2);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][17], -320017665);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][17], 255);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][17], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][17], 0);

	// Кол-во патронов 2
	TD_cSelectedClass[playerid][18] = CreatePlayerTextDraw(playerid, 309.0000, 268.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cSelectedClass[playerid][18], 0.1726, 1.0317);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][18], 2);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][18], -320017665);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][18], 255);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][18], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][18], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][18], 0);

	// Кол-во патронов 3
	TD_cSelectedClass[playerid][19] = CreatePlayerTextDraw(playerid, 333.0000, 268.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cSelectedClass[playerid][19], 0.1726, 1.0317);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][19], 2);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][19], -320017665);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][19], 255);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][19], 0);

	// Кол-во патронов 4
	TD_cSelectedClass[playerid][20] = CreatePlayerTextDraw(playerid, 357.0000, 268.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cSelectedClass[playerid][20], 0.1726, 1.0317);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][20], 2);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][20], -320017665);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][20], 255);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][20], 0);

	// Задний белый фон назад
	TD_cSelectedClass[playerid][21] = CreatePlayerTextDraw(playerid, 271.0000, 297.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][21], 49.0000, 19.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][21], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][21], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][21], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][21], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][21], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][21], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон назад
	TD_cSelectedClass[playerid][22] = CreatePlayerTextDraw(playerid, 272.0000, 298.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][22], 47.0000, 17.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][22], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][22], 303174399);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][22], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][22], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][22], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][22], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][22], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_cSelectedClass[playerid][23] = CreatePlayerTextDraw(playerid, 296.0000, 298.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, TD_cSelectedClass[playerid][23], 0.2293, 1.6663);
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][23], 15.0000, 46.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][23], 2);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][23], -63621633);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][23], 255);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][23], 2);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][23], true);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][23], 0);

	// Задний белый фон выбрать
	TD_cSelectedClass[playerid][24] = CreatePlayerTextDraw(playerid, 322.0000, 297.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][24], 49.0000, 19.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][24], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][24], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][24], -1717986817);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][24], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][24], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][24], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][24], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][24], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон выбрать
	TD_cSelectedClass[playerid][25] = CreatePlayerTextDraw(playerid, 323.0000, 298.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][25], 47.0000, 17.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][25], 1);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][25], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][25], 303174399);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][25], 5);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][25], 0);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][25], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][25], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cSelectedClass[playerid][25], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cSelectedClass[playerid][25], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_cSelectedClass[playerid][26] = CreatePlayerTextDraw(playerid, 347.0000, 298.0000, "Выбрать");
	PlayerTextDrawLetterSize(playerid, TD_cSelectedClass[playerid][26], 0.2293, 1.6663);
	PlayerTextDrawTextSize(playerid, TD_cSelectedClass[playerid][26], 15.0000, 46.0000);
	PlayerTextDrawAlignment(playerid, TD_cSelectedClass[playerid][26], 2);
	PlayerTextDrawColor(playerid, TD_cSelectedClass[playerid][26], -55888385);
	PlayerTextDrawBackgroundColor(playerid, TD_cSelectedClass[playerid][26], 255);
	PlayerTextDrawFont(playerid, TD_cSelectedClass[playerid][26], 2);
	PlayerTextDrawSetSelectable(playerid, TD_cSelectedClass[playerid][26], true);
	PlayerTextDrawSetProportional(playerid, TD_cSelectedClass[playerid][26], 1);
	PlayerTextDrawSetShadow(playerid, TD_cSelectedClass[playerid][26], 0);
	return 1;
}

static ShowPlayerTDBuy(playerid)
{
	// Задний белый фон 1
	TD_cBuy[playerid][0] = CreatePlayerTextDraw(playerid, 170.0000, 201.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][0], 70.0000, 66.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][0], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][0], -1717986817);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][0], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][0], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][0], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон 2
	TD_cBuy[playerid][1] = CreatePlayerTextDraw(playerid, 243.0000, 201.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][1], 70.0000, 66.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][1], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][1], -1717986817);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон 3
	TD_cBuy[playerid][2] = CreatePlayerTextDraw(playerid, 316.0000, 201.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][2], 70.0000, 66.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][2], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][2], -1717986817);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][2], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон 4
	TD_cBuy[playerid][3] = CreatePlayerTextDraw(playerid, 389.0000, 201.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][3], 70.0000, 66.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][3], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][3], -1717986817);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][3], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон 1
	TD_cBuy[playerid][4] = CreatePlayerTextDraw(playerid, 171.0000, 202.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][4], 68.0000, 64.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][4], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][4], 589505535);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cBuy[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][4], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][4], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон 2
	TD_cBuy[playerid][5] = CreatePlayerTextDraw(playerid, 244.0000, 202.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][5], 68.0000, 64.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][5], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][5], 589505535);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cBuy[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][5], 19141);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][5], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон 3
	TD_cBuy[playerid][6] = CreatePlayerTextDraw(playerid, 317.0000, 202.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][6], 68.0000, 64.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][6], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][6], 589505535);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cBuy[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][6], 19141);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][6], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон 4
	TD_cBuy[playerid][7] = CreatePlayerTextDraw(playerid, 390.0000, 202.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][7], 68.0000, 64.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][7], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][7], 589505535);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cBuy[playerid][7], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][7], 19141);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][7], 0.0000, 0.0000, 0.0000, 1.0000);

	TD_cBuy[playerid][8] = CreatePlayerTextDraw(playerid, 205.0000, 202.0000, "Ничего");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][8], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][8], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][8], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][8], -656877825);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][8], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][8], 0);

	TD_cBuy[playerid][9] = CreatePlayerTextDraw(playerid, 278.0000, 202.0000, "1_класс");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][9], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][9], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][9], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][9], -656877825);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][9], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][9], 0);

	TD_cBuy[playerid][10] = CreatePlayerTextDraw(playerid, 351.0000, 202.0000, "2_класс");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][10], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][10], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][10], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][10], -656877825);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][10], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][10], 0);

	TD_cBuy[playerid][11] = CreatePlayerTextDraw(playerid, 424.0000, 202.0000, "3_класс");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][11], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][11], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][11], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][11], -656877825);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][11], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][11], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][11], 0);

	// Цена 1
	TD_cBuy[playerid][12] = CreatePlayerTextDraw(playerid, 205.0000, 252.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][12], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][12], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][12], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][12], -651613697);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][12], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][12], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][12], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][12], 0);

	// Цена 2
	TD_cBuy[playerid][13] = CreatePlayerTextDraw(playerid, 278.0000, 252.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][13], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][13], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][13], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][13], -651613697);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][13], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][13], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][13], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][13], 0);

	// Цена 3
	TD_cBuy[playerid][14] = CreatePlayerTextDraw(playerid, 351.0000, 252.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][14], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][14], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][14], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][14], -651613697);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][14], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][14], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][14], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][14], 0);

	// Цена 4
	TD_cBuy[playerid][15] = CreatePlayerTextDraw(playerid, 424.0000, 252.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][15], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][15], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][15], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][15], -651613697);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][15], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][15], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][15], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][15], 0);

	// Задний чёрный фон выбора
	TD_cBuy[playerid][16] = CreatePlayerTextDraw(playerid, 170.0000, 184.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][16], 289.0000, 14.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][16], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][16], 589505535);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][16], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][16], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][16], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][16], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Выбор чего-то
	TD_cBuy[playerid][17] = CreatePlayerTextDraw(playerid, 314.0000, 182.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][17], 0.3356, 1.6580);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][17], 0.0000, 278.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][17], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][17], -741092865);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][17], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][17], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][17], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][17], 0);

	// Задний чёрный фон кредитов
	TD_cBuy[playerid][18] = CreatePlayerTextDraw(playerid, 170.0000, 270.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][18], 289.0000, 15.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][18], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][18], 589505535);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][18], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][18], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][18], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][18], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кол-во денег
	TD_cBuy[playerid][19] = CreatePlayerTextDraw(playerid, 173.0000, 269.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][19], 0.3356, 1.6580);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][19], 278.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][19], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][19], 952579071);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][19], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][19], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][19], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][19], 0);

	// Задний белый фон назад
	TD_cBuy[playerid][20] = CreatePlayerTextDraw(playerid, 170.0000, 288.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][20], 42.0000, 17.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][20], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][20], -1717986817);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][20], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][20], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][20], 0);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][20], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][20], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон назад
	TD_cBuy[playerid][21] = CreatePlayerTextDraw(playerid, 171.0000, 289.0000, "");
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][21], 40.0000, 15.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][21], 1);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][21], 589505535);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][21], 5);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cBuy[playerid][21], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_cBuy[playerid][21], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_cBuy[playerid][21], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_cBuy[playerid][22] = CreatePlayerTextDraw(playerid, 191.0000, 289.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, TD_cBuy[playerid][22], 0.2163, 1.4465);
	PlayerTextDrawTextSize(playerid, TD_cBuy[playerid][22], 15.0000, 40.0000);
	PlayerTextDrawAlignment(playerid, TD_cBuy[playerid][22], 2);
	PlayerTextDrawColor(playerid, TD_cBuy[playerid][22], -952945409);
	PlayerTextDrawBackgroundColor(playerid, TD_cBuy[playerid][22], 255);
	PlayerTextDrawFont(playerid, TD_cBuy[playerid][22], 2);
	PlayerTextDrawSetProportional(playerid, TD_cBuy[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, TD_cBuy[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, TD_cBuy[playerid][22], true);
	return 1;
}

/*

	* MySQL *

*/

stock TDM_UploadPlayerDataClasses(playerid)
{
	new
		query[150];

	mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_TDM_STATS"` WHERE `ID` = '%i' LIMIT 1", GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query, "TDM_UploadPlayerClasses", "i", playerid);
	return 1;
}

publics TDM_UploadPlayerClasses(playerid)
{
	static
		str2[400];

	str2[0] = EOS;

	new
		str[50];

	// Убийств и смертей
	f(str, "p<,>a<i>[%i]", TDM_MAX_PLAYER_CLASSES);
	cache_get_value_name(0, "Kills", str2, sizeof(str2)), sscanf(str2, str, PlayerClass[playerid][cKills]), str2[0] = EOS;
	cache_get_value_name(0, "Deaths", str2, sizeof(str2)), sscanf(str2, str, PlayerClass[playerid][cDeaths]), str[0] = str2[0] = EOS;

	// Время
	f(str, "p<,>a<i>[%i]", TDM_MAX_PLAYER_CLASSES);
	cache_get_value_name(0, "Hours", str2, sizeof(str2)), sscanf(str2, str, PlayerClass[playerid][cHours]), str2[0] = EOS;
	cache_get_value_name(0, "Minutes", str2, sizeof(str2)), sscanf(str2, str, PlayerClass[playerid][cMinutes]), str[0] = str2[0] = EOS;

	// Оружие и патроны
	f(str, "p<,>a<i>[%i]", TDM_MAX_PLAYER_CLASSES);
	cache_get_value_name(0, "Assault_weapons", str2, sizeof(str2)), sscanf(str2, str, PlayerCWeapon[playerid][CW_Weapon][TDM_C_ASSAULT]), str2[0] = EOS;
	cache_get_value_name(0, "Assault_ammo", str2, sizeof(str2)), sscanf(str2, str, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ASSAULT]), str2[0] = EOS;
	cache_get_value_name(0, "Medic_weapons", str2, sizeof(str2)), sscanf(str2, str, PlayerCWeapon[playerid][CW_Weapon][TDM_C_MEDIC]), str2[0] = EOS;
	cache_get_value_name(0, "Medic_ammo", str2, sizeof(str2)), sscanf(str2, str, PlayerCWeapon[playerid][CW_Ammo][TDM_C_MEDIC]), str2[0] = EOS;
	cache_get_value_name(0, "Engineer_weapons", str2, sizeof(str2)), sscanf(str2, str, PlayerCWeapon[playerid][CW_Weapon][TDM_C_ENGINEER]), str2[0] = EOS;
	cache_get_value_name(0, "Engineer_ammo", str2, sizeof(str2)), sscanf(str2, str, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ENGINEER]), str2[0] = EOS;
	cache_get_value_name(0, "Recon_weapons", str2, sizeof(str2)), sscanf(str2, str, PlayerCWeapon[playerid][CW_Weapon][TDM_C_RECON]), str2[0] = EOS;
	cache_get_value_name(0, "Recon_ammo", str2, sizeof(str2)), sscanf(str2, str, PlayerCWeapon[playerid][CW_Ammo][TDM_C_RECON]), str[0] = str2[0] = EOS;

	// Надето из одежды
	f(str, "p<,>a<i>[%i]", TDM_MAX_PLAYER_CLASSES);
	cache_get_value_name(0, "Uses_Cap", str2, sizeof(str2)), sscanf(str2, str, PlayerBody[playerid][B_Cap]), str2[0] = EOS;
	cache_get_value_name(0, "Uses_Armor", str2, sizeof(str2)), sscanf(str2, str, PlayerBody[playerid][B_Armor]), str[0] = str2[0] = EOS;

	// Одежда
	f(str, "p<,>a<i>[%i]", TDM_MAX_SHOP_BODY);
	cache_get_value_name(0, "Assault_caps", str2, sizeof(str2)), sscanf(str2, str, PlayerBodyC[playerid][B_CapClass][TDM_C_ASSAULT]), str2[0] = EOS;
	cache_get_value_name(0, "Assault_armors", str2, sizeof(str2)), sscanf(str2, str, PlayerBodyC[playerid][B_ArmorClass][TDM_C_ASSAULT]), str2[0] = EOS;
	cache_get_value_name(0, "Medic_caps", str2, sizeof(str2)), sscanf(str2, str, PlayerBodyC[playerid][B_CapClass][TDM_C_MEDIC]), str2[0] = EOS;
	cache_get_value_name(0, "Medic_armors", str2, sizeof(str2)), sscanf(str2, str, PlayerBodyC[playerid][B_ArmorClass][TDM_C_MEDIC]), str2[0] = EOS;
	cache_get_value_name(0, "Engineer_caps", str2, sizeof(str2)), sscanf(str2, str, PlayerBodyC[playerid][B_CapClass][TDM_C_ENGINEER]), str2[0] = EOS;
	cache_get_value_name(0, "Engineer_armors", str2, sizeof(str2)), sscanf(str2, str, PlayerBodyC[playerid][B_ArmorClass][TDM_C_ENGINEER]), str2[0] = EOS;
	cache_get_value_name(0, "Recon_caps", str2, sizeof(str2)), sscanf(str2, str, PlayerBodyC[playerid][B_CapClass][TDM_C_RECON]), str2[0] = EOS;
	cache_get_value_name(0, "Recon_armors", str2, sizeof(str2)), sscanf(str2, str, PlayerBodyC[playerid][B_ArmorClass][TDM_C_RECON]), str[0] = str2[0] = EOS;

	// Способности
	f(str, "p<,>a<i>[%i]", TDM_MAX_ASSAULT_ABILS);
	cache_get_value_name(0, "Assault_abilities", str2, sizeof(str2)), sscanf(str2, str, PlayerClassAbilities[playerid][TDM_C_ASSAULT]), str[0] = str2[0] = EOS;
	f(str, "p<,>a<i>[%i]", TDM_MAX_MEDIC_ABILS);
	cache_get_value_name(0, "Medic_abilities", str2, sizeof(str2)), sscanf(str2, str, PlayerClassAbilities[playerid][TDM_C_MEDIC]), str[0] = str2[0] = EOS;
	f(str, "p<,>a<i>[%i]", TDM_MAX_ENGINEER_ABILS);
	cache_get_value_name(0, "Engineer_abilities", str2, sizeof(str2)), sscanf(str2, str, PlayerClassAbilities[playerid][TDM_C_ENGINEER]), str[0] = str2[0] = EOS;
	f(str, "p<,>a<i>[%i]", TDM_MAX_RECON_ABILS);
	cache_get_value_name(0, "Recon_abilities", str2, sizeof(str2)), sscanf(str2, str, PlayerClassAbilities[playerid][TDM_C_RECON]), str[0] = str2[0] = EOS;

	// Навыки оружия
	f(str, "p<,>a<f>[%i]", TDM_MAX_PLAYER_CLASSES);
	cache_get_value_name(0, "Skill_M4", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_M4]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_AK47", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_AK47]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_Deagle", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_Deagle]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_Shotgun", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_Shotgun]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_SawShotgun", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_SawShotgun]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_Uzi", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_Uzi]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_MP5", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_MP5]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_SniperRifle", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_Sniper]), str[0] = str2[0] = EOS;

	// Навыки рукопашного боя
	f(str, "p<,>a<f>[%i]", TDM_MAX_PLAYER_CLASSES);
	cache_get_value_name(0, "Skill_Normal", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_Normal]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_Boxing", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_Boxing]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_KungFu", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_KungFu]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_KneeHead", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_KneeHead]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_GrabKick", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_GrabKick]), str2[0] = EOS;
	cache_get_value_name(0, "Skill_Elbow", str2, sizeof(str2)), sscanf(str2, str, PlayerSkill[playerid][S_Elbow]), str[0] = str2[0] = EOS;
	return 1;
}

stock TDM_SavePlClassKillsDeaths(playerid)
{
	new
		str[100],
		str2[100];

	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		f(str, "%s%d,", str, TDM_GetPlayerClassKills(playerid, i));
		f(str2, "%s%d,", str2, TDM_GetPlayerClassDeaths(playerid, i));
	}

	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Kills` = '%s', `Deaths` = '%s' WHERE `ID` = '%d'", str, str2, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock TDM_SavePlayerClassSkills(playerid)
{
	new
		str1[100],
		str2[100],
		str3[100],
		str4[100],
		str5[100],
		str6[100],
		str7[100],
		str8[100];

	// Навыки оружия
	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		f(str1, "%s%.2f,", str1, PlayerSkill[playerid][S_M4][i]);
		f(str2, "%s%.2f,", str2, PlayerSkill[playerid][S_AK47][i]);
		f(str3, "%s%.2f,", str3, PlayerSkill[playerid][S_Deagle][i]);
		f(str4, "%s%.2f,", str4, PlayerSkill[playerid][S_Shotgun][i]);
		f(str5, "%s%.2f,", str5, PlayerSkill[playerid][S_SawShotgun][i]);
		f(str6, "%s%.2f,", str6, PlayerSkill[playerid][S_Uzi][i]);
		f(str7, "%s%.2f,", str7, PlayerSkill[playerid][S_MP5][i]);
		f(str8, "%s%.2f,", str8, PlayerSkill[playerid][S_Sniper][i]);
	}

	new
		query[500];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Skill_M4` = '%s', `Skill_AK47` = '%s', `Skill_Deagle` = '%s', `Skill_Shotgun` = '%s', `Skill_SawShotgun` = '%s', `Skill_Uzi` = '%s', `Skill_MP5` = '%s', `Skill_SniperRifle` = '%s' WHERE `ID` = '%d'",
	str1, str2, str3, str4, str5, str6, str7, str8, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	query[0] = EOS;

	// Навыки рукопашного боя
	new
		fstr1[100],
		fstr2[100],
		fstr3[100],
		fstr4[100],
		fstr5[100],
		fstr6[100];

	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		f(fstr1, "%s%.2f,", fstr1, PlayerSkill[playerid][S_Normal][i]);
		f(fstr2, "%s%.2f,", fstr2, PlayerSkill[playerid][S_Boxing][i]);
		f(fstr3, "%s%.2f,", fstr3, PlayerSkill[playerid][S_KungFu][i]);
		f(fstr4, "%s%.2f,", fstr4, PlayerSkill[playerid][S_KneeHead][i]);
		f(fstr5, "%s%.2f,", fstr5, PlayerSkill[playerid][S_GrabKick][i]);
		f(fstr6, "%s%.2f,", fstr6, PlayerSkill[playerid][S_Elbow][i]);
	}

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Skill_Normal` = '%s', `Skill_Boxing` = '%s', `Skill_KungFu` = '%s', `Skill_KneeHead` = '%s', `Skill_GrabKick` = '%s', `Skill_Elbow` = '%s' WHERE `ID` = '%d'",
	fstr1, fstr2, fstr3, fstr4, fstr5, fstr6, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock TDM_SavePlayerClassWeapon(playerid)
{
	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		new
			string[100], 
			strings[100];

		n_for2(w, TDM_CLASS_MAX_WEAPONS) {
			f(string, "%s%d,", string, PlayerCWeapon[playerid][CW_Weapon][i][w]);
			f(strings, "%s%d,", strings, PlayerCWeapon[playerid][CW_Ammo][i][w]);
		}
	
		new
			query[250];

		switch(i) {
			case TDM_C_ASSAULT: {
				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Assault_weapons` = '%s', `Assault_ammo` = '%s' WHERE `ID` = '%d'", string, strings, GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);
			}
			case TDM_C_MEDIC: {
				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Medic_weapons` = '%s', `Medic_ammo` = '%s' WHERE `ID` = '%d'", string, strings, GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);
			}
			case TDM_C_ENGINEER: {
				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Engineer_weapons` = '%s', `Engineer_ammo` = '%s' WHERE `ID` = '%d'", string, strings, GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);
			}
			case TDM_C_RECON: {
				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Recon_weapons` = '%s', `Recon_ammo` = '%s' WHERE `ID` = '%d'", string, strings, GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);
			}
		}
	}
	return 1;
}

stock TDM_SavePlayerClassBody(playerid)
{
	static
		query[300],
		string[100],
		string2[100];

	query[0] = string[0] = string2[0] = EOS;

	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		f(string, "%s%d,", string, PlayerBody[playerid][B_Cap][i]);
		f(string2, "%s%d,", string2, PlayerBody[playerid][B_Armor][i]);
	}

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Uses_Cap` = '%s', `Uses_Armor` = '%s' WHERE `ID` = '%d'", string, string2, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);

	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		query[0] = string[0] = string2[0] = EOS;

		switch(i) {
			case TDM_C_ASSAULT: {
				n_for2(w, TDM_MAX_SHOP_BODY) {
					f(string, "%s%d,", string, PlayerBodyC[playerid][B_CapClass][i][w]);
					f(string2, "%s%d,", string2, PlayerBodyC[playerid][B_ArmorClass][i][w]);
				}

				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Assault_caps` = '%s', `Assault_armors` = '%s' WHERE `ID` = '%d'", string, string2, GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);
			}
			case TDM_C_MEDIC: {
				n_for2(w, TDM_MAX_SHOP_BODY) {
					f(string, "%s%d,", string, PlayerBodyC[playerid][B_CapClass][i][w]);
					f(string2, "%s%d,", string2, PlayerBodyC[playerid][B_ArmorClass][i][w]);
				}

				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Medic_caps` = '%s', `Medic_armors` = '%s' WHERE `ID` = '%d'", string, string2, GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);
			}
			case TDM_C_ENGINEER: {
				n_for2(w, TDM_MAX_SHOP_BODY) {
					f(string, "%s%d,", string, PlayerBodyC[playerid][B_CapClass][i][w]);
					f(string2, "%s%d,", string2, PlayerBodyC[playerid][B_ArmorClass][i][w]);
				}

				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Engineer_caps` = '%s', `Engineer_armors` = '%s' WHERE `ID` = '%d'", string, string2, GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);
			}
			case TDM_C_RECON: {
				n_for2(w, TDM_MAX_SHOP_BODY) {
					f(string, "%s%d,", string, PlayerBodyC[playerid][B_CapClass][i][w]);
					f(string2, "%s%d,", string2, PlayerBodyC[playerid][B_ArmorClass][i][w]);
				}

				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Recon_caps` = '%s', `Recon_armors` = '%s' WHERE `ID` = '%d'", string, string2, GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);
			}
		}
	}
	return 1;
}

stock TDM_SavePlayerClassAbilities(playerid)
{
	new
		string[100],
		query[250];

	// Штурмовик
	n_for(i, TDM_MAX_ASSAULT_ABILS)
		f(string, "%s%d,", string, PlayerClassAbilities[playerid][TDM_C_ASSAULT][i]);

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Assault_abilities` = '%s' WHERE `ID` = '%d'", string, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	string[0] = query[0] = EOS;

	// Медик
	n_for(i, TDM_MAX_MEDIC_ABILS)
		f(string, "%s%d,", string, PlayerClassAbilities[playerid][TDM_C_MEDIC][i]);

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Medic_abilities` = '%s' WHERE `ID` = '%d'", string, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	string[0] = query[0] = EOS;

	// Инженер
	n_for(i, TDM_MAX_ENGINEER_ABILS)
		f(string, "%s%d,", string, PlayerClassAbilities[playerid][TDM_C_ENGINEER][i]);

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Engineer_abilities` = '%s' WHERE `ID` = '%d'", string, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	string[0] = query[0] = EOS;

	// Разведчик
	n_for(i, TDM_MAX_RECON_ABILS)
		f(string, "%s%d,", string, PlayerClassAbilities[playerid][TDM_C_RECON][i]);

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Recon_abilities` = '%s' WHERE `ID` = '%d'", string, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock TDM_SavePlayerClassTime(playerid)
{
	new
		str[100],
		str2[100];

	n_for(i, TDM_MAX_PLAYER_CLASSES) {
		f(str, "%s%d,", str, PlayerClass[playerid][cHours][i]);
		f(str2, "%s%d,", str2, PlayerClass[playerid][cMinutes][i]);
	}

	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `Hours` = '%s', `Minutes` = '%s' WHERE `ID` = '%d'", str, str2, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock TDM_CreateNewUserStatsClass(playerid, query[1000], str[6000])
{
	new
		text[200];

	SetStandardClassWeapon(playerid);

	// Core
	f(str, "INSERT INTO `"T_TDM_STATS"` (\
	`ID`,`Kills`,`Deaths`,`Assault_weapons`,`Assault_ammo`,`Medic_weapons`,`Medic_ammo`,`Engineer_weapons`,`Engineer_ammo`,`Recon_weapons`,`Recon_ammo`,`Uses_Cap`,`Uses_Armor`,\
	`Assault_caps`,`Assault_armors`,`Medic_caps`,`Medic_armors`,`Engineer_caps`,`Engineer_armors`,`Recon_caps`,`Recon_armors`,\
	`Assault_abilities`,`Medic_abilities`,`Engineer_abilities`,`Recon_abilities`,\
	`Skill_M4`,`Skill_AK47`,`Skill_Deagle`,`Skill_Shotgun`,`Skill_SawShotgun`,`Skill_Uzi`,`Skill_MP5`,`Skill_SniperRifle`,`Skill_Normal`,`Skill_Boxing`,`Skill_KungFu`,`Skill_KneeHead`,`Skill_GrabKick`,`Skill_Elbow`,\
	`Hours`,`Minutes`) VALUES ");
	strcat(str, "(");

	f(query, "'%i',", GetPlayerpID(playerid)), strcat(str, query), query[0] = EOS; // ID

	// Kills and Deaths
	n_for(i, TDM_MAX_PLAYER_CLASSES)
		strcat(text, "0,");

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Kills
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS; // Deaths

	// Assault_weapons
	n_for(w, TDM_CLASS_MAX_WEAPONS)
		f(text, "%s%d,", text, PlayerCWeapon[playerid][CW_Weapon][TDM_C_ASSAULT][w]);

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;

	// Assault_ammo
	n_for(w, TDM_CLASS_MAX_WEAPONS)
		f(text, "%s%d,", text, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ASSAULT][w]);

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;

	// Medic_weapons
	n_for(w, TDM_CLASS_MAX_WEAPONS)
		f(text, "%s%d,", text, PlayerCWeapon[playerid][CW_Weapon][TDM_C_MEDIC][w]);

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;

	// Medic_ammo
	n_for(w, TDM_CLASS_MAX_WEAPONS)
		f(text, "%s%d,", text, PlayerCWeapon[playerid][CW_Ammo][TDM_C_MEDIC][w]);

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;

	// Engineer_weapons
	n_for(w, TDM_CLASS_MAX_WEAPONS)
		f(text, "%s%d,", text, PlayerCWeapon[playerid][CW_Weapon][TDM_C_ENGINEER][w]);

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;

	// Engineer_ammo
	n_for(w, TDM_CLASS_MAX_WEAPONS)
		f(text, "%s%d,", text, PlayerCWeapon[playerid][CW_Ammo][TDM_C_ENGINEER][w]);

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;

	// Recon_weapons
	n_for(w, TDM_CLASS_MAX_WEAPONS)
		f(text, "%s%d,", text, PlayerCWeapon[playerid][CW_Weapon][TDM_C_RECON][w]);

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;

	// Recon_ammo
	n_for(w, TDM_CLASS_MAX_WEAPONS)
		f(text, "%s%d,", text, PlayerCWeapon[playerid][CW_Ammo][TDM_C_RECON][w]);

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;

	// Uses Cap and Armor
	n_for(i, TDM_MAX_PLAYER_CLASSES)
		strcat(text, "0,");

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Cap
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS; // Armor

	// Purchased Cap and Armor
	n_for(i, TDM_MAX_SHOP_BODY)
		strcat(text, "0,");

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Assault_caps
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Assault_armors
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Medic_caps
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Medic_armors
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Engineer_caps
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Engineer_armors
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Recon_caps
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS; // Recon_armors

	// Assault_abilities
	n_for(i, TDM_MAX_ASSAULT_ABILS)
		strcat(text, "0,");

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;
	
	// Medic_abilities
	n_for(i, TDM_MAX_MEDIC_ABILS)
		strcat(text, "0,");

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;
	
	// Engineer_abilities
	n_for(i, TDM_MAX_ENGINEER_ABILS)
		strcat(text, "0,");

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;
	
	// Recon_abilities
	n_for(i, TDM_MAX_RECON_ABILS)
		strcat(text, "0,");

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS;

	// Skills
	n_for(i, TDM_MAX_PLAYER_CLASSES)
		strcat(text, "0.00,");

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_M4
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_AK47
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_Deagle
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_Shotgun
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_SawShotgun
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_Uzi
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_MP5
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_SniperRifle
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_Normal
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_Boxing
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_KungFu
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_KneeHead
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Skill_GrabKick
	f(query, "'%s',", text), strcat(str, query), query[0] = EOS, text[0] = EOS; // Skill_Elbow

	// Hours and Minutes
	n_for(i, TDM_MAX_PLAYER_CLASSES)
		strcat(text, "0,");

	f(query, "'%s',", text), strcat(str, query), query[0] = EOS; // Hours
	f(query, "'%s'", text), strcat(str, query), query[0] = EOS, text[0] = EOS; // Minutes

	strcat(str, ")");
	mysql_tquery(MysqlID, str);
	return 1;
}

stock TDM_SavePlayerClasses(playerid)
{
	TDM_SavePlayerClassTime(playerid);
	TDM_SavePlClassKillsDeaths(playerid);
	TDM_SavePlayerClassSkills(playerid);
	TDM_SavePlayerClassWeapon(playerid);
	TDM_SavePlayerClassBody(playerid);
	TDM_SavePlayerClassAbilities(playerid);
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerData(playerid)
{
	player_air_medication_id[playerid] =
	player_air_ammo_id[playerid] = -1;

	// Классы персонажей
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		PlayerClass[playerid][cKills][c] =
		PlayerClass[playerid][cDeaths][c] =
		PlayerClass[playerid][cHours][c] =
		PlayerClass[playerid][cMinutes][c] = 0;
	}

	// Оружие классов
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		n_for2(w, TDM_CLASS_MAX_WEAPONS) {
			PlayerCWeapon[playerid][CW_Weapon][c][w] =
			PlayerCWeapon[playerid][CW_Ammo][c][w] = 0;
		}
	}

	// Навыки
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		PlayerSkill[playerid][S_M4][c] =
		PlayerSkill[playerid][S_AK47][c] =
		PlayerSkill[playerid][S_Deagle][c] =
		PlayerSkill[playerid][S_Shotgun][c] =
		PlayerSkill[playerid][S_SawShotgun][c] =
		PlayerSkill[playerid][S_Uzi][c] =
		PlayerSkill[playerid][S_MP5][c] =
		PlayerSkill[playerid][S_Sniper][c] = 0.00;

		PlayerSkill[playerid][S_Normal][c] =
		PlayerSkill[playerid][S_Boxing][c] =
		PlayerSkill[playerid][S_KungFu][c] =
		PlayerSkill[playerid][S_KneeHead][c] =
		PlayerSkill[playerid][S_GrabKick][c] =
		PlayerSkill[playerid][S_Elbow][c] = 0.00;
	}

	AbilityMedicHPTimer[playerid] = 
	AbilityEngineerVehicleTimer[playerid] = 0;

	// Способности классов
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		n_for2(a, TDM_MAX_CLASS_ABILITIES)
			PlayerClassAbilities[playerid][c][a] = 0;
	}
	n_for(i, TDM_MAX_CLASS_ABILITIES)
		DialogListClassAbilities[playerid][i] = -1;

	// Тело
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		PlayerBody[playerid][B_Cap][c] =
		PlayerBody[playerid][B_Armor][c] = 0;
	}
	n_for(c, TDM_MAX_PLAYER_CLASSES) {
		n_for2(b, TDM_MAX_SHOP_BODY) {
			PlayerBodyC[playerid][B_CapClass][c][b] =
			PlayerBodyC[playerid][B_ArmorClass][c][b] = 0;
		}
	}
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(i, sizeof(TD_cSelectClass[]))
		TD_cSelectClass[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_cSelectedClass[]))
		TD_cSelectedClass[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_cSelectWeapon[]))
		TD_cSelectWeapon[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_cBuy[]))
		TD_cBuy[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

/*

	* Commands *

*/

flags:rep(CMD_FLAG_MODE_TDM)
flags:hp(CMD_FLAG_MODE_TDM)

CMD:rep(playerid)
{
	if(GetPlayerCustomClass(playerid) != TDM_C_ENGINEER) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Требуется класс {FFFF33}Инженер.");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}В транспорте, чинить невозможно.");
		return 1;
	}
	if(!Veh_GetNearest(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Рядом нет ни одного транспорта.");
		return 1;
	}
	if(AbilityEngineerVehicleTimer[playerid] > gettime()) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Набор для починки ещё не готов.");
		return 1;	
	}

	new
		Float:Health;

	GetVehicleHealth(Veh_GetNearest(playerid), Health);

	if(Health >= 600.0) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Самый ближний транспорт не очень сильно повреждён.");
		return 1;
	}
	else {
		SetPlayerFee(playerid, 100, 50, REPLEN_ENGINEER_VEHICLE);
		SetVehicleHealth(Veh_GetNearest(playerid), 1000.0);
		AbilityEngineerVehicleTimer[playerid] = gettime() + 10; 
		Quest_CheckPlayerProgress(playerid, MODE_TDM, 14);

		ApplyAnimation(playerid, "WEAPONS", "SHP_G_LIFT_IN", 4.1, 0, 0, 0, 0, 0, 1);
		SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Транспорт успешно починен.");
	}
	return 1;
}

CMD:hp(playerid, params[])
{
	if(GetPlayerCustomClass(playerid) != TDM_C_MEDIC) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Требуется класс медик.");
		return 1;
	}

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/hp [id игрока]");

	if(AbilityMedicHPTimer[playerid] > gettime()) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Набор для лечения ещё не собран.");
		return 1;
	}

	if(params[0] == playerid) 
		return 1;

	if(!ProxDetectorS(3.0, playerid, params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Союзника рядом нет.");
		return 1;
	}
	if(GetPlayerTeamEx(params[0]) != GetPlayerTeamEx(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в вашей команде.");
		return 1;
	}

	new
		Float:health;

	GetPlayerHealthEx(params[0], health);

	if(health < 100.0) {
		SetPlayerHealthEx(params[0], 100.0);
		SetPlayerFee(playerid, 200, 150, REPLEN_MEDIC_HP);
		AbilityMedicHPTimer[playerid] = gettime() + 10; 
		Quest_CheckPlayerProgress(playerid, MODE_TDM, 12);

		new
			str[300];

		f(str, "{CC0033}(Информация) {FFFFFF}Союзник {FFFF33}%s (ID:%i) {FFFFFF}здоров!", NameEx(params[0]), params[0]);
		SCM(playerid, -1, str);
		str[0] = EOS;

		f(str, "{CC0033}(Информация) {FFFFFF}Союзник {FFFF33}%s (ID:%i) {FFFFFF}вылечил Вас!", NameEx(playerid), playerid);
		SCM(params[0], -1, str);
	}
	return 1;
}

/*

	* Dialogs *

*/

DialogCreate:TDM_ChooseStatsClass(playerid)
{
	Dialog_Open(playerid, Dialog:TDM_ChooseStatsClass, DSL, "Статистика классов", 
	""C_N"• {FFFFFF}Штурмовик \
	\n"C_N"• {FFFFFF}Медик \
	\n"C_N"• {FFFFFF}Инженер \
	\n"C_N"• {FFFFFF}Разведчик", 
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:TDM_ChooseStatsClass(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: SetPlayerCustomClass2(playerid, TDM_C_ASSAULT);
			case 1: SetPlayerCustomClass2(playerid, TDM_C_MEDIC);
			case 2: SetPlayerCustomClass2(playerid, TDM_C_ENGINEER);
			case 3: SetPlayerCustomClass2(playerid, TDM_C_RECON);
		}
		Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
	}
	else
		Dialog_Show(playerid, Dialog:ChoosePlayerStats);

	return 1;
}

DialogCreate:TDM_ClassChooseStats(playerid)
{
	new
		str[50],
		class_id = GetPlayerCustomClass2(playerid);

	f(str, "%s", ClassesName[class_id]);

	Dialog_Open(playerid, Dialog:TDM_ClassChooseStats, DSL, str, 
	""C_N"• {FFFFFF}Статистика \
	\n"C_N"• {FFFFFF}Способности \
	\n"C_N"• {FFFFFF}Навыки оружия \
	\n"C_N"• {FFFFFF}Навыки рукопашного боя", 
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:TDM_ClassChooseStats(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:TDM_PlayerClassStats);
			case 1: {
				if(GetPlayerCheckPlayerid(playerid) > -1) 
					Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
				else 
					Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
			}
			case 2: Dialog_Show(playerid, Dialog:TDM_ClSkillsWeapon);
			case 3: Dialog_Show(playerid, Dialog:TDM_ClSkillsCloseFight);
		}
	}
	else {
		if(!Interface_IsOpen(playerid, Interface:TDM_SelectedClass)) {
			SetPlayerCustomClass2(playerid, -1);

			// Dialog_Show(playerid, Dialog:TDM_ChooseStatsClass);
		}
	}
	return 1;
}

DialogCreate:TDM_ClSkillsCFInfo(playerid)
{
	Dialog_Open(playerid, Dialog:TDM_ClSkillsCFInfo, DSM, "Рукопашный бой", "{FFFFFF}Разные стили рукопашного боя можно прокачать в процессе борьбы с противником.\n10 очков дают +0.5 к урону.", "Хорошо", "");
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
		check_playerid;

	if(GetPlayerCheckPlayerid(playerid) > -1)
		check_playerid = GetPlayerCheckPlayerid(playerid);
	else
		check_playerid = playerid;

	if(!IsPlayerOnServer(check_playerid))
		return 1;

	if(!IsPlayerOnServer(playerid))
		return 1;

	new
		str[100],
		class_id = GetPlayerCustomClass2(playerid);

	f(str, "Навыки рукопашного боя {CCCCCC}%s", ClassesName[class_id]);

	new
		str1[30],
		str2[30],
		str3[30],
		str4[30],
		str5[30],
		str6[30];

	// Пиздец, да
	if(GetPlayerFightingStyle(check_playerid) == FIGHT_STYLE_NORMAL)
		str1 = "{33FF33}Вкл";
	else
		str1 = "{CC0033}Выкл";

	if(GetPlayerFightingStyle(check_playerid) == FIGHT_STYLE_BOXING)
		str2 = "{33FF33}Вкл";
	else
		str2 = "{CC0033}Выкл";

	if(GetPlayerFightingStyle(check_playerid) == FIGHT_STYLE_KUNGFU)
		str3 = "{33FF33}Вкл";
	else
		str3 = "{CC0033}Выкл";

	if(GetPlayerFightingStyle(check_playerid) == FIGHT_STYLE_KNEEHEAD)
		str4 = "{33FF33}Вкл";
	else
		str4 = "{CC0033}Выкл";

	if(GetPlayerFightingStyle(check_playerid) == FIGHT_STYLE_GRABKICK)
		str5 = "{33FF33}Вкл";
	else
		str5 = "{CC0033}Выкл";

	if(GetPlayerFightingStyle(check_playerid) == FIGHT_STYLE_ELBOW)
		str6 = "{33FF33}Вкл";
	else
		str6 = "{CC0033}Выкл";

	f(stringer,
	"Название\tСтатус\tПрогресс\n\
	"C_N"• {FFFFFF}Информация\
	\n"C_N"• {FFFFFF}Нормальный\t[%s{FFFFFF}]\t[{EB8624}%.0f/100{FFFFFF}] \
	\n"C_N"• {FFFFFF}Бокс\t[%s{FFFFFF}]\t[{EB8624}%.0f/100{FFFFFF}] \
	\n"C_N"• {FFFFFF}Кунг Фу\t[%s{FFFFFF}]\t[{EB8624}%.0f/100{FFFFFF}] \
	\n"C_N"• {FFFFFF}Коленом\t[%s{FFFFFF}]\t[{EB8624}%.0f/100{FFFFFF}] \
	\n"C_N"• {FFFFFF}Схватить Удар\t[%s{FFFFFF}]\t[{EB8624}%.0f/100{FFFFFF}] \
	\n"C_N"• {FFFFFF}Удар локтём\t[%s{FFFFFF}]\t[{EB8624}%.0f/100{FFFFFF}]",
	str1, PlayerSkill[check_playerid][S_Normal][class_id], str2, PlayerSkill[check_playerid][S_Boxing][class_id], str3, PlayerSkill[check_playerid][S_KungFu][class_id], str4, PlayerSkill[check_playerid][S_KneeHead][class_id], str5, PlayerSkill[check_playerid][S_GrabKick][class_id], str6, PlayerSkill[check_playerid][S_Elbow][class_id]);
	
	Dialog_Open(playerid, Dialog:TDM_ClSkillsCloseFight, DSTH, str, stringer, "Выбрать", "Назад");
	return 1;
}

DialogResponse:TDM_ClSkillsCloseFight(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(GetPlayerCheckPlayerid(playerid) > -1) {
			Dialog_Show(playerid, Dialog:TDM_ClSkillsCloseFight);
			return 1;
		}
		switch(listitem) {
			case 0: {
				Dialog_Show(playerid, Dialog:TDM_ClSkillsCFInfo);
				return 1;
			}
			case 1: {
				SetPlayerStyleMelee(playerid, FIGHT_STYLE_NORMAL);
				SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Выбран стиль {F5A938}Нормальный");
			}
			case 2: {
				SetPlayerStyleMelee(playerid, FIGHT_STYLE_BOXING);
				SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Выбран стиль {F5A938}Бокс");
			}
			case 3: {
				SetPlayerStyleMelee(playerid, FIGHT_STYLE_KUNGFU);
				SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Выбран стиль {F5A938}Кунг Фу");
			}
			case 4: {
				SetPlayerStyleMelee(playerid, FIGHT_STYLE_KNEEHEAD);
				SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Выбран стиль {F5A938}Коленом");
			}
			case 5: {
				SetPlayerStyleMelee(playerid, FIGHT_STYLE_GRABKICK);
				SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Выбран стиль {F5A938}Схватить Удар");
			}
			case 6: {
				SetPlayerStyleMelee(playerid, FIGHT_STYLE_ELBOW);
				SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Выбран стиль {F5A938}Удар локтём");
			}
		}
		Dialog_Show(playerid, Dialog:TDM_ClSkillsCloseFight);
	}
	else
		Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
	
	return 1;
}

DialogCreate:TDM_ClSkillsWeapon(playerid)
{
	new
		check_playerid;

	if(GetPlayerCheckPlayerid(playerid) > -1)
		check_playerid = GetPlayerCheckPlayerid(playerid);
	else
		check_playerid = playerid;

	if(!IsPlayerOnServer(check_playerid)) 
		return 1;

	if(!IsPlayerOnServer(playerid)) 
		return 1;

	new
		str[100],
		class_id = GetPlayerCustomClass2(playerid);

	f(str, "Навыки оружия {CCCCCC}%s", ClassesName[class_id]);

	f(stringer,
	"{CC0033}Информация: \
	\n\n{FFFFFF}При стрельбе из определённого оружия прокачивается навык этого оружия. \
	\nОружие прокачивается при стрельбе и попадании в противника. \
	\n10 очков навыка оружия дают +0.3 к урону по игроку. \
	\n\n{e98e1f}Навыки оружия: \
	\n\n{FFFFFF}"C_N"• {FFFFFF}M4 - {FFCC33}%.0f/100 \
	\n"C_N"• {FFFFFF}AK-47 - {FFCC33}%.0f/100 \
	\n"C_N"• {FFFFFF}Дигл - {FFCC33}%.0f/100 \
	\n"C_N"• {FFFFFF}Дробовик - {FFCC33}%.0f/100 \
	\n"C_N"• {FFFFFF}Обрез - {FFCC33}%.0f/100 \
	\n"C_N"• {FFFFFF}Узи - {FFCC33}%.0f/100 \
	\n"C_N"• {FFFFFF}МП5 - {FFCC33}%.0f/100 \
	\n"C_N"• {FFFFFF}Снайперская винтовка - {FFCC33}%.0f/100",
	PlayerSkill[check_playerid][S_M4][class_id], PlayerSkill[check_playerid][S_AK47][class_id], PlayerSkill[check_playerid][S_Deagle][class_id], PlayerSkill[check_playerid][S_Shotgun][class_id], PlayerSkill[check_playerid][S_SawShotgun][class_id], PlayerSkill[check_playerid][S_Uzi][class_id], PlayerSkill[check_playerid][S_MP5][class_id], PlayerSkill[check_playerid][S_Sniper][class_id]);
	
	Dialog_Open(playerid, Dialog:TDM_ClSkillsWeapon, DSM, str, stringer, "Назад", "");
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
		check_playerid;

	if(GetPlayerCheckPlayerid(playerid) > -1)
		check_playerid = GetPlayerCheckPlayerid(playerid);
	else
		check_playerid = playerid;

	if(!IsPlayerOnServer(check_playerid))
		return 1;

	if(!IsPlayerOnServer(playerid))
		return 1;

	new
		str[50],
		class_id = GetPlayerCustomClass2(playerid),
		Float:text_health,
		Float:text_armour,
		text_ammo[4],
		text_weapon1[50],
		text_weapon2[50],
		text_weapon3[50],
		text_weapon4[50],
		text_hours[15], 
		text_minutes[15];

	text_health = ClassesNeeds[class_id][0];
	text_armour = ClassesNeeds[class_id][1];

	n_for(i, TDM_CLASS_MAX_WEAPONS)
		text_ammo[i] = PlayerCWeapon[check_playerid][CW_Ammo][class_id][i];

	GetWeaponNameRU(PlayerCWeapon[check_playerid][CW_Weapon][class_id][0], text_weapon1, sizeof(text_weapon1));
	GetWeaponNameRU(PlayerCWeapon[check_playerid][CW_Weapon][class_id][1], text_weapon2, sizeof(text_weapon2));
	GetWeaponNameRU(PlayerCWeapon[check_playerid][CW_Weapon][class_id][2], text_weapon3, sizeof(text_weapon3));
	GetWeaponNameRU(PlayerCWeapon[check_playerid][CW_Weapon][class_id][3], text_weapon4, sizeof(text_weapon4));

	switch(PlayerClass[check_playerid][cHours][class_id]) {
		case 1: text_hours = "час";
		case 2, 3, 4: text_hours = "часа";
		default: text_hours = "часов";
	}
	switch(PlayerClass[check_playerid][cMinutes][class_id]) {
		case 1: text_minutes = "минута";
		case 2, 3, 4: text_minutes = "минуты";
		default: text_minutes = "минут";
	}

	f(str, "Статистика {CCCCCC}%s", ClassesName[class_id]);

	f(stringer,
	"{CCCCCC}Убийств: {FFFFFF}[%i] \
	\n{CCCCCC}Смертей: {FFFFFF}[%i] \
	\n{CCCCCC}Наиграно времени: {FFFFFF}[%i %s %i %s] \
	\n\n{e98e1f}Оружие: \
	\n"C_N"• {FFFFFF}1 слот: {efce13}%s{FFFFFF}, патронов: {7ee21d}%i \
	\n"C_N"• {FFFFFF}2 слот: {efce13}%s{FFFFFF}, патронов: {7ee21d}%i \
	\n"C_N"• {FFFFFF}3 слот: {efce13}%s{FFFFFF}, патронов: {7ee21d}%i \
	\n"C_N"• {FFFFFF}4 слот: {efce13}%s{FFFFFF}, штук: {7ee21d}%i \
	\n\n{CC0033}Здоровья: %.0f \
	\n{5a6577}Брони: %.0f",
	TDM_GetPlayerClassKills(check_playerid, class_id), TDM_GetPlayerClassDeaths(check_playerid, class_id), PlayerClass[check_playerid][cHours][class_id], text_hours, PlayerClass[check_playerid][cMinutes][class_id], text_minutes,
	text_weapon1, text_ammo[0], text_weapon2, text_ammo[1], text_weapon3, text_ammo[2], text_weapon4, text_ammo[3], text_health, text_armour);
	
	Dialog_Open(playerid, Dialog:TDM_PlayerClassStats, DSM, str, stringer, "Назад", "");
	return 1;
}

DialogResponse:TDM_PlayerClassStats(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);
	return 1;
}

DialogCreate:TDM_BuyListClAbility(playerid)
{
	new
		string[3000],
		str[100],
		class_id;

	if(GetPlayerCustomClass2(playerid) != -1)
		class_id = GetPlayerCustomClass2(playerid);
	else {
		if(GetPlayerCustomClass(playerid) != -1)
			class_id = GetPlayerCustomClass(playerid);
	}

	f(str, "{1ad9c9}Покупка способностей %s", ClassesName[class_id]);
	strcat(string, "Название\tЦена\n");

	n_for(i, GetPlayerClassMaxAbilities(class_id)) {
		if(!PlayerClassAbilities[playerid][class_id][i])
			f(string, "%s"C_N"• {FFFFFF}%s\t{35b025}[$%i]\n", string, ClassesAlibity[class_id][i][CA_Name], ClassesAlibity[class_id][i][CA_Price]);
		else 
			f(string, "%s"C_N"• {FFFFFF}%s\t \n", string, ClassesAlibity[class_id][i][CA_Name]);
	}
	Dialog_Open(playerid, Dialog:TDM_BuyListClAbility, DSTH, str, string, "Выбрать", "Выйти");
	return 1;
}

DialogResponse:TDM_BuyListClAbility(playerid, response, listitem, inputtext[])
{
	if(response) {
		SetPVarInt(playerid, "PlayerClassAbility_PVar", listitem);
		Dialog_Show(playerid, Dialog:TDM_BuyClassAbility);
	}
	else
		if(GetPlayerCustomClass2(playerid) != -1)
			Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);

	return 1;
}

DialogCreate:TDM_BuyClassAbility(playerid)
{
	new
		class_id,
		ability_id = GetPVarInt(playerid, "PlayerClassAbility_PVar");

	if(GetPlayerCustomClass2(playerid) != -1)
		class_id = GetPlayerCustomClass2(playerid);
	else {
		if(GetPlayerCustomClass(playerid) != -1)
			class_id = GetPlayerCustomClass(playerid);
	}

	new
		string[1000],
		str[100];

	f(str, "{1ad9c9}Покупка способности %s", ClassesName[class_id]);
	f(string, "{d4d4d4}Способность: {d6a21e}%s\n{d4d4d4}Цена: {1ed630}%i$\n{d4d4d4}В наличии: {1ed630}%i$\n\n{a5d61e}Информация:\n{d4d4d4}%s", ClassesAlibity[class_id][ability_id][CA_Name], ClassesAlibity[class_id][ability_id][CA_Price], GetPlayerCredits(playerid), ClassesAlibity[class_id][ability_id][CA_Info]);
	
	Dialog_Open(playerid, Dialog:TDM_BuyClassAbility, DSM, str, string, "Купить", "Назад");
	return 1;
}

DialogResponse:TDM_BuyClassAbility(playerid, response, listitem, inputtext[])
{
	new
		class_id;

	if(GetPlayerCustomClass2(playerid) != -1)
		class_id = GetPlayerCustomClass2(playerid);
	else {
		if(GetPlayerCustomClass(playerid) != -1)
			class_id = GetPlayerCustomClass(playerid);
	}

	if(response) {
		new
			ability_id = GetPVarInt(playerid, "PlayerClassAbility_PVar");

		if(!PlayerClassAbilities[playerid][class_id][ability_id]) {
			if(GetPlayerCredits(playerid) < ClassesAlibity[class_id][ability_id][CA_Price]) {
				Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
				SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно кредитов!");
				return 1;
			}
			else {
				SetPlayerCredit(playerid, -ClassesAlibity[class_id][ability_id][CA_Price]);
				PlayerClassAbilities[playerid][class_id][ability_id] = 1;

				SavePlayerCredit(playerid);
				TDM_SavePlayerClassAbilities(playerid);

				Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
				SCM(playerid, -1, "{1ad943}(Покупка) {FFFFFF}Способность успешно приобретена!");
			}
		}
		else {
			Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Способность уже приобретена!");
		}
	}
	else
		Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);

	return 1;
}

DialogCreate:TDM_ListClassAbility(playerid)
{
	new
		string[3000],
		str[100],
		num = 0,
		class_id = GetPlayerCustomClass(playerid);

	n_for(i, TDM_MAX_CLASS_ABILITIES)
		DialogListClassAbilities[playerid][i] = -1;

	n_for(i, GetPlayerClassMaxAbilities(class_id)) {
		if(PlayerClassAbilities[playerid][class_id][i]) {
			DialogListClassAbilities[playerid][num] = i;
			num++;
		}
	}

	f(str, "{1ad9c9}Способности %s", ClassesName[class_id]);

	if(num != 0)
		strcat(string, "Название\tОчков раунда\n");

	n_for(i, num) {
		if(ClassesAlibity[class_id][DialogListClassAbilities[playerid][i]][CA_MatchPointsMax] != 0) 
			f(string, "%s"C_N"• {FFFFFF}%s\t{d69c1e}%i-%i ОР\n", string, ClassesAlibity[class_id][DialogListClassAbilities[playerid][i]][CA_Name], ClassesAlibity[class_id][DialogListClassAbilities[playerid][i]][CA_MatchPoints], ClassesAlibity[class_id][DialogListClassAbilities[playerid][i]][CA_MatchPointsMax]);
		else 
			f(string, "%s"C_N"• {FFFFFF}%s\t{d69c1e}%i ОР\n", string, ClassesAlibity[class_id][DialogListClassAbilities[playerid][i]][CA_Name], ClassesAlibity[class_id][DialogListClassAbilities[playerid][i]][CA_MatchPoints]);
	}

	if(num != 0)
		strcat(string, " \n"C_N"• {5acc1d}Приобрести способность");
	else 
		strcat(string, ""C_N"• {5acc1d}Приобрести способность");

	if(num != 0)
		Dialog_Open(playerid, Dialog:TDM_ListClassAbility, DSTH, str, string, "Выбрать", "Выйти");
	else 
		Dialog_Open(playerid, Dialog:TDM_ListClassAbility, DSL, str, string, "Выбрать", "Выйти");

	return 1;
}

DialogResponse:TDM_ListClassAbility(playerid, response, listitem, inputtext[])
{
	if(response) {
		new
			class_id = GetPlayerCustomClass(playerid),
			num = 0;

		n_for(i, GetPlayerClassMaxAbilities(class_id)) {
			if(DialogListClassAbilities[playerid][num] != -1)
				num++;
		}

		if(num != 0)
			num++;

		if(num != 0) {
			if(listitem == num - 1) {
				Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
				return 1;
			}
		}

		if(listitem == num) 
			Dialog_Show(playerid, Dialog:TDM_BuyListClAbility);
		else {
			if(Mode_GetPlayerMatchPoints(playerid) < ClassesAlibity[class_id][DialogListClassAbilities[playerid][listitem]][CA_MatchPoints]) {
				Dialog_Show(playerid, Dialog:TDM_ListClassAbility);
				SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно очков раунда!");
				return 1;
			}
			SetPlayerClassAbility(playerid, DialogListClassAbilities[playerid][listitem]);
		}
		n_for(i, TDM_MAX_CLASS_ABILITIES)
			DialogListClassAbilities[playerid][i] = -1;
	}
	return 1;
}

DialogCreate:TDM_ClassAirdrop(playerid)
{
	switch(GetPlayerCustomClass(playerid)) {
		// Штурмовик
		case TDM_C_ASSAULT: {
			Dialog_Open(playerid, Dialog:TDM_ClassAirdrop, DSTH, "Типы контейнеров для аирдропа", 
			"Название\tОчков раунда \
			\n"C_N"• {FFFFFF}Информация \
			\n"C_N"• {CCCCCC}"TDM_AIR_C_SMALL_RUS_NAME_WEAPON"\t{d69c1e}1000 ОР \
			\n"C_N"• {CBAE15}"TDM_AIR_C_MIDDLE_RUS_NAME_WEAPON"\t{d69c1e}1500 ОР \
			\n"C_N"• {CB1515}"TDM_AIR_C_LARGE_RUS_NAME_WEAPON"\t{d69c1e}2000 ОР", 
			"Выбрать", "Выйти");
		}
		// Медик
		case TDM_C_MEDIC: {
			Dialog_Open(playerid, Dialog:TDM_ClassAirdrop, DSTH, "Типы контейнеров для аирдропа", 
			"Название\tОчков раунда \
			\n"C_N"• {FFFFFF}Информация \
			\n"C_N"• {CCCCCC}"TDM_AIR_C_SMALL_RUS_NAME_MEDICAMENT"\t{d69c1e}1000 ОР \
			\n"C_N"• {CBAE15}"TDM_AIR_C_MIDDLE_RUS_NAME_MEDICAMENT"\t{d69c1e}1500 ОР \
			\n"C_N"• {CB1515}"TDM_AIR_C_LARGE_RUS_NAME_MEDICAMENT"\t{d69c1e}2000 ОР", 
			"Выбрать", "Выйти");
		}
		// Инженер
		case TDM_C_ENGINEER: {
			Dialog_Open(playerid, Dialog:TDM_ClassAirdrop, DSTH, "Типы контейнеров для аирдропа", 
			"Название\tОчков раунда \
			\n"C_N"• {FFFFFF}Информация \
			\n"C_N"• {CCCCCC}"TDM_AIR_C_SMALL_RUS_NAME_AMMO"\t{d69c1e}1000 ОР \
			\n"C_N"• {CBAE15}"TDM_AIR_C_LARGE_RUS_NAME_AMMO"\t{d69c1e}1500 ОР \
			\n"C_N"• {CB1515}"TDM_AIR_C_LARGE_RUS_NAME_AMMO"\t{d69c1e}2000 ОР", 
			"Выбрать", "Выйти");
		}
	}
	return 1;
}

DialogResponse:TDM_ClassAirdrop(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:TDM_ClassADInfo);
			case 1: Dialog_Show(playerid, Dialog:TDM_ClassAD_1);
			case 2: Dialog_Show(playerid, Dialog:TDM_ClassAD_2);
			case 3: Dialog_Show(playerid, Dialog:TDM_ClassAD_3);
		}
	}
	return 1;
}

DialogCreate:TDM_ClassADInfo(playerid)
{
	switch(GetPlayerCustomClass(playerid)) {
		// Штурмовик
		case TDM_C_ASSAULT: {
			f(stringer, 
			"{FFFFFF}Класс штурмовик вызывает контейнер с оружием и патронами к нему. \
			\n{CCCCCC}Чтобы использовать прибывший контейнер, необходимо подойти к \
			\nнему и нажать на определённую клавишу. Дальше выбрать понравившийся оружие. \
			\n\n{FFFFFF}Контейнер могут использовать все игроки. \
			\n\n{FFFFFF}Взорвется через %i секунд после падения.", 
			TDM_AIR_C_TIMER_WEAPON);
		}
		// Медик
		case TDM_C_MEDIC: {
			f(stringer, 
			"{FFFFFF}Класс медик вызывает контейнер с медикаментами. \
			\n{CCCCCC}Для использования прибывшего контейнера, необходимо подойти \
			\nк нему и у вас начнёт пополнятся здоровье. \
			\n\n{FFFFFF}Контейнер могут использовать все игроки. \
			\n\nВзорвется через %i секунд после падения.", 
			TDM_AIR_C_TIMER_MEDICAMENT);
		}
		// Инженер
		case TDM_C_ENGINEER: {
			f(stringer, 
			"{FFFFFF}Класс инженер вызывает контейнер с патронами. \
			\n{CCCCCC}Для использование прибывшего контейнера, необходимо подойти к нему и \
			\nоружие, которое у вас в руках, будет пополняться патронами. \
			\n\n{FFFFFF}Контейнер могут использовать все игроки. \
			\n\nВзорвется через %i секунд после падения.", 
			TDM_AIR_C_TIMER_AMMO);
		}
	}
	Dialog_Open(playerid, Dialog:TDM_ClassADInfo, DSM, "Информация", stringer, "Назад", "");
	return 1;
}

DialogResponse:TDM_ClassADInfo(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);
	return 1;
}

DialogCreate:TDM_ClassAD_1(playerid)
{
	switch(GetPlayerCustomClass(playerid)) {
		// Штурмовик
		case TDM_C_ASSAULT: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_1, DSM, ""TDM_AIR_C_SMALL_RUS_NAME_WEAPON"",
			"{CC0033}Информация: \
			\n\n{F7B536}Оружие в контейнере: \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}AK-47 {FFFFFF}Патронов: {FFFF33}200 \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}Кольт {FFFFFF}Патронов: {FFFF33}30 \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}MP5 {FFFFFF}Патронов: {FFFF33}80 \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}Гранаты {FFFFFF}Штук: {FFFF33}3\n ",
			"Вызвать", "Назад");
		}
		// Медик
		case TDM_C_MEDIC: {
			f(stringer, 
			"{CC0033}Информация: \
			\n\n{FFFFFF}Данный контейнер пополняет раз в 1 секунду +%i здоровья.", 
			TDM_AIR_C_SMALL_BOARD_MEDICAMENT);

			Dialog_Open(playerid, Dialog:TDM_ClassAD_1, DSM, ""TDM_AIR_C_SMALL_RUS_NAME_MEDICAMENT"", stringer, "Вызвать", "Назад");
		}
		// Инженер
		case TDM_C_ENGINEER: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_1, DSM, ""TDM_AIR_C_SMALL_RUS_NAME_AMMO"", 
			"{CC0033}Информация: \
			\n\n{FFFFFF}Данный контейнер пополняет патроны оружия.", 
			"Вызвать", "Назад");
		}
	}
	return 1;
}

DialogResponse:TDM_ClassAD_1(playerid, response, listitem, inputtext[])
{
	new
		class_id = GetPlayerCustomClass(playerid);

	if(Mode_GetPlayerMatchPoints(playerid) < ClassesAlibity[class_id][0][CA_MatchPoints]) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно очков раунда!");
		return 1;
	}

	if(!response) return Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);

	switch(GetPlayerCustomClass(playerid)) {
		case TDM_C_ASSAULT: SetAirCause(playerid, TDM_AIR_WEAPON, 1);
		case TDM_C_MEDIC: SetAirCause(playerid, TDM_AIR_MEDICAMENT, 1);
		case TDM_C_ENGINEER: SetAirCause(playerid, TDM_AIR_AMMO, 1);
	}
	Mode_SetPlayerMatchPoint(playerid, -ClassesAlibity[class_id][0][CA_MatchPoints]);
	return 1;
}

DialogCreate:TDM_ClassAD_2(playerid)
{
	switch(GetPlayerCustomClass(playerid)) {
		// Штурмовик
		case TDM_C_ASSAULT: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_2, DSM, ""TDM_AIR_C_MIDDLE_RUS_NAME_WEAPON"",
			"{CC0033}Информация: \
			\n\n{F7B536}Оружие в контейнере: \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}M4 {FFFFFF}Патронов: {FFFF33}300 \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}Дигл {FFFFFF}Патронов: {FFFF33}50 \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}Обрез {FFFFFF}Патронов: {FFFF33}30 \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}Гранаты {FFFFFF}Штук: {FFFF33}10\n ", 
			"Вызвать", "Назад");
		}
		// Медик
		case TDM_C_MEDIC: {
			f(stringer, 
			"{CC0033}Информация: \
			\n\n{FFFFFF}Данный контейнер пополняет раз в 1 секунду +%i здоровья.", 
			TDM_AIR_C_MIDDLE_BOARD_MEDICAMENT);

			Dialog_Open(playerid, Dialog:TDM_ClassAD_2, DSM, ""TDM_AIR_C_MIDDLE_RUS_NAME_MEDICAMENT"", stringer, "Вызвать", "Назад");
		}
		// Инженер
		case TDM_C_ENGINEER: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_2, DSM, ""TDM_AIR_C_MIDDLE_RUS_NAME_AMMO"", 
			"{CC0033}Информация: \
			\n\n{FFFFFF}Данный контейнер пополняет патроны оружия немного больше.", 
			"Вызвать", "Назад");
		}
	}
	return 1;
}

DialogResponse:TDM_ClassAD_2(playerid, response, listitem, inputtext[])
{
	new
		class_id = GetPlayerCustomClass(playerid),
		c_price = ClassesAlibity[class_id][0][CA_MatchPoints] + 500;

	if(Mode_GetPlayerMatchPoints(playerid) < c_price) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно очков раунда!");
		return 1;
	}

	if(!response) return Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);

	switch(GetPlayerCustomClass(playerid)) {
		case TDM_C_ASSAULT: SetAirCause(playerid, TDM_AIR_WEAPON, 2);
		case TDM_C_MEDIC: SetAirCause(playerid, TDM_AIR_MEDICAMENT, 2);
		case TDM_C_ENGINEER: SetAirCause(playerid, TDM_AIR_AMMO, 2);
	}
	Mode_SetPlayerMatchPoint(playerid, -c_price);
	return 1;
}

DialogCreate:TDM_ClassAD_3(playerid)
{
	switch(GetPlayerCustomClass(playerid)) {
		// Штурмовик
		case TDM_C_ASSAULT: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_3, DSM, ""TDM_AIR_C_LARGE_RUS_NAME_WEAPON"",
			"{CC0033}Информация: \
			\n\n{F7B536}Оружие в контейнере: \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}M4 {FFFFFF}Патронов: {FFFF33}400 \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}Дигл {FFFFFF}Патронов: {FFFF33}70 \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}Узи {FFFFFF}Патронов: {FFFF33}200 \
			\n"C_N"• {FFFFFF}Оружие: {CCCCCC}Гранаты {FFFFFF}Штук: {FFFF33}15\n ", "Вызвать", "Назад");
		}
		// Медик
		case TDM_C_MEDIC: {
			f(stringer, 
			"{CC0033}Информация: \
			\n\n{FFFFFF}Данный контейнер пополняет раз в 1 секунду +%i здоровья.", 
			TDM_AIR_C_LARGE_BOARD_MEDICAMENT);

			Dialog_Open(playerid, Dialog:TDM_ClassAD_3, DSM, ""TDM_AIR_C_LARGE_RUS_NAME_MEDICAMENT"", stringer, "Вызвать", "Назад");
		}
		// Инженер
		case TDM_C_ENGINEER: {
			Dialog_Open(playerid, Dialog:TDM_ClassAD_3, DSM, ""TDM_AIR_C_LARGE_RUS_NAME_AMMO"", 
			"{CC0033}Информация: \
			\n\n{FFFFFF}Данный контейнер пополняет патроны оружия намного больше.", 
			"Вызвать", "Назад");
		}
	}
	return 1;
}

DialogResponse:TDM_ClassAD_3(playerid, response, listitem, inputtext[])
{
	new
		class_id = GetPlayerCustomClass(playerid);

	if(Mode_GetPlayerMatchPoints(playerid) < ClassesAlibity[class_id][0][CA_MatchPointsMax]) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно очков раунда!");
		return 1;
	}

	if(!response) return Dialog_Show(playerid, Dialog:TDM_ClassAirdrop);

	switch(GetPlayerCustomClass(playerid)) {
		case TDM_C_ASSAULT: SetAirCause(playerid, TDM_AIR_WEAPON, 3);
		case TDM_C_MEDIC: SetAirCause(playerid, TDM_AIR_MEDICAMENT, 3);
		case TDM_C_ENGINEER: SetAirCause(playerid, TDM_AIR_AMMO, 3);
	}
	Mode_SetPlayerMatchPoint(playerid, -ClassesAlibity[class_id][0][CA_MatchPointsMax]);
	return 1;
}

DialogCreate:TDM_ClassBuyAmmo(playerid)
{
	new
		str1[100],
		str2[300],
		weapon_name[100],
		class_id = GetPlayerCustomClass2(playerid),
		weapon = GetPVarInt(playerid, "TDM_BuyAmmo_PVar") - 1;

	GetWeaponNameRU(PlayerCWeapon[playerid][CW_Weapon][class_id][weapon], weapon_name, sizeof(weapon_name));
	f(str1, "{7a916e}Покупка патронов для %s", weapon_name);
	f(str2, 
	"{d4d4d4}Введите число патронов, которое хотите купить: \
	\n\nСтоимость одного патрона: {66d433}%i$ \
	\n{d4d4d4}В наличии: {66d433}%i$", ClassesAmmoPrice[class_id][weapon][0], GetPlayerCredits(playerid));

	Dialog_Open(playerid, Dialog:TDM_ClassBuyAmmo, DSI, str1, str2, "Купить", "Выйти");
	return 1;
}

DialogResponse:TDM_ClassBuyAmmo(playerid, response, listitem, inputtext[])
{
	if(response) {
		new
			class_id = GetPlayerCustomClass2(playerid),
			weapon = GetPVarInt(playerid, "TDM_BuyAmmo_PVar") - 1;
			
		if(!strlen(inputtext)) return Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);

		for(new i = strlen(inputtext) - 1; i != -1; i--) {
			switch(inputtext[i]) {
				case '0'..'9': continue;
				default: return Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
			}
		}

		if(strval(inputtext) <= 0) return Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);

		if(strval(inputtext) + PlayerCWeapon[playerid][CW_Ammo][class_id][weapon] > ClassesAmmoLimit[class_id][weapon]) {
			new
				str[100];

			f(str, "{CC0033}(Ошибка) {FFFFFF}Больше {d49333}%i патронов {FFFFFF}запрещено покупать для данного оружия!", ClassesAmmoLimit[class_id][weapon]);
			SCM(playerid, -1, str);

			Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
			return 1;
		}
		if(GetPlayerCredits(playerid) < (ClassesAmmoPrice[class_id][weapon][0] * strval(inputtext))) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Не хватает кредитов!");
			Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
			return 1;
		}

		DeletePVar(playerid, "TDM_BuyAmmo_PVar");

		PlayerCWeapon[playerid][CW_Ammo][class_id][weapon] += strval(inputtext);
		SetPlayerCredit(playerid, -(ClassesAmmoPrice[class_id][weapon][0] * strval(inputtext)));
		TDM_SavePlayerClassWeapon(playerid);
		ShowInfoClass(playerid);

		new
			str[100];

		f(str, "{CC0033}(Патроны) {FFFFFF}Успешно куплено {d49333}%i {FFFFFF}патронов", strval(inputtext));
		SCM(playerid, -1, str);
	}
	else
		DeletePVar(playerid, "TDM_BuyAmmo_PVar");

	return 1;
}

DialogCreate:PlayerCauseWeapon(playerid)
{
	new
		proverka,
		air_id = GetPVarInt(playerid, "TDM_LocAirID_PVar");

	DeletePVar(playerid, "TDM_LocAirID_PVar");

	n_for(w, TDM_AIR_C_MAX_WEAPON) {
		if(AirCauseWeapon[air_id][Air_Weapon][w]) 
			proverka++;
	}

	if(proverka > 0) {
		TDM_SetPlayerIDAirdrop(playerid, air_id);

		static 
			string[1000];

		string[0] = EOS;

		new
			str[500], 
			name[200];

		name = "Оружие\tПатроны\n";
		strcat(string, name);

		n_for(w, TDM_AIR_C_MAX_WEAPON) {
			if(w != (TDM_AIR_C_MAX_WEAPON - 1)) {
				if(!AirCauseWeapon[air_id][Air_Weapon][w]) {
					new 
						ww = w + 1;

					AirCauseWeapon[air_id][Air_Weapon][w] = AirCauseWeapon[air_id][Air_Weapon][ww];
					AirCauseWeapon[air_id][Air_WeaponAmmo][w] = AirCauseWeapon[air_id][Air_WeaponAmmo][ww];

					AirCauseWeapon[air_id][Air_Weapon][ww] =
					AirCauseWeapon[air_id][Air_WeaponAmmo][ww] = 0;
				}
			}
			if(AirCauseWeapon[air_id][Air_Weapon][w]) {
				new
					weapon[WEAPON_NAME_MAX_LENGTH];

				GetWeaponNameRU(AirCauseWeapon[air_id][Air_Weapon][w], weapon, sizeof(weapon));

				f(str, "{C5F9FC}%s\t{DAB767}%i\n", weapon, AirCauseWeapon[air_id][Air_WeaponAmmo][w]);
				strcat(string, str);
			}
		}
		Dialog_Open(playerid, Dialog:PlayerCauseWeapon, DSTH, "Оружие в контейнере", string, "Выбрать", "Назад");
	}
	else {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		Dialog_Message(playerid, "Оружие в контейнере", "{FFFFFF}\tПусто", "Закрыть");
	}
	return 1;
}

DialogResponse:PlayerCauseWeapon(playerid, response, listitem, inputtext[])
{
	new
		air_id = TDM_GetPlayerIDAirdrop(playerid);

	if(!AirCauseWeapon[air_id][Air_Action]) {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		return 1;
	}

	if(response) {
		n_for(w, TDM_AIR_C_MAX_WEAPON) {
			if(listitem != w)
				continue;
				
			GivePlayerWeaponEx(playerid, AirCauseWeapon[air_id][Air_Weapon][w], AirCauseWeapon[air_id][Air_WeaponAmmo][w]);
			AirCauseWeapon[air_id][Air_Weapon][w] =
			AirCauseWeapon[air_id][Air_WeaponAmmo][w] = 0;

			m_for(MODE_TDM, Mode_GetPlayerSession(playerid), p) {
				if(GetPlayerVirtualWorldEx(p) != AirCauseWeapon[air_id][Air_VirtualWorld]) 
					continue;

				if(GetPlayerInteriorEx(p) != AirCauseWeapon[air_id][Air_Interior]) 
					continue;

				if(TDM_GetPlayerIDAirdrop(p) != air_id) 
					continue;

				Dialog_Close(p);
				SetPVarInt(p, "TDM_LocAirID_PVar", air_id);
				Dialog_Show(p, Dialog:PlayerCauseWeapon);
			}
			break;
		}
	}
	else
		TDM_SetPlayerIDAirdrop(playerid, -1);

	return 1;
}

/*

	* Interfaces *

*/

InterfaceCreate:TDM_SelectedClass(playerid)
{
	ShowPlayerTDSelectedClass(playerid);
	ShowInfoClass(playerid);

	n_for(i, sizeof(TD_cSelectedClass[]))
		PlayerTextDrawShow(playerid, TD_cSelectedClass[playerid][i]);

	return 1;
}

InterfaceClose:TDM_SelectedClass(playerid)
{
	if(GetPVarInt(playerid, "Buy_PVar")) {
		DeletePVar(playerid, "SelectWeapon_PVar");
		TDM_DestroyPlayerClTDBuy(playerid);
		return 1;
	}
	if(GetPVarInt(playerid, "SelectWeapon_PVar")) {
		DeletePVar(playerid, "SelectWeapon_PVar");

		n_for(i, sizeof(TD_cSelectWeapon[]))
			DestroyPlayerTD(playerid, TD_cSelectWeapon[playerid][i]);

		return 1;
	}

	n_for(i, sizeof(TD_cSelectedClass[]))
		DestroyPlayerTD(playerid, TD_cSelectedClass[playerid][i]);

	return 1;
}

InterfacePlayerClick:TDM_SelectedClass(playerid, PlayerText:playertextid)
{
	new
		pclass = GetPlayerCustomClass2(playerid);
		
	switch(GetPVarInt(playerid, "Buy_PVar")) {
		// Шлем
		case 1: {
			if(playertextid == TD_cBuy[playerid][22]) {
				DeletePVar(playerid, "Buy_PVar");

				n_for(i, sizeof(TD_cBuy[]))
					DestroyPlayerTD(playerid, TD_cBuy[playerid][i]);

				Interface_Show(playerid, Interface:TDM_SelectedClass);
				return 1;
			}
			else if(playertextid == TD_cBuy[playerid][4]) {
				if(!PlayerBody[playerid][B_Cap][pclass]) 
					return 1;

				PlayerBody[playerid][B_Cap][pclass] = 0;
			}
			else if(playertextid == TD_cBuy[playerid][5]) {
				if(PlayerBody[playerid][B_Cap][pclass] == 1)
					return 1;

				if(PlayerBody[playerid][B_Cap][pclass] != 1 
				&& PlayerBodyC[playerid][B_CapClass][pclass][0] == 1)
					PlayerBody[playerid][B_Cap][pclass] = 1;

				if(GetPlayerCredits(playerid) < 10000 
				&& PlayerBodyC[playerid][B_CapClass][pclass][0] != 1) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно кредитов.");
					return 1;
				}
				if(!PlayerBodyC[playerid][B_CapClass][pclass][0]) {
					PlayerBodyC[playerid][B_CapClass][pclass][0] = 1;
					SetPlayerCredit(playerid, -10000);

					SCM(playerid, -1, "{CC0033}(Покупка) {FFFFFF}Куплен шлем {FFFF33}1 класса.");
				}
			}
			else if(playertextid == TD_cBuy[playerid][6]) {
				if(PlayerBody[playerid][B_Cap][pclass] == 2)
					return 1;

				if(PlayerBody[playerid][B_Cap][pclass] != 2 
				&& PlayerBodyC[playerid][B_CapClass][pclass][1] == 1)
					PlayerBody[playerid][B_Cap][pclass] = 2;

				if(GetPlayerCredits(playerid) < 20000 
				&& PlayerBodyC[playerid][B_CapClass][pclass][1] != 1) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно кредитов.");
					return 1;
				}
				if(!PlayerBodyC[playerid][B_CapClass][pclass][1]) {
					PlayerBodyC[playerid][B_CapClass][pclass][1] = 1;
					SetPlayerCredit(playerid, -20000);

					SCM(playerid, -1, "{CC0033}(Покупка) {FFFFFF}Куплен шлем {FFFF33}2 класса.");
				}
			}
			else if(playertextid == TD_cBuy[playerid][7]) {
				if(PlayerBody[playerid][B_Cap][pclass] == 3) 
					return 1;

				if(PlayerBody[playerid][B_Cap][pclass] != 3 
				&& PlayerBodyC[playerid][B_CapClass][pclass][2] == 1)
					PlayerBody[playerid][B_Cap][pclass] = 3;

				if(GetPlayerCredits(playerid) < 40000 
				&& PlayerBodyC[playerid][B_CapClass][pclass][2] != 1) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно кредитов.");
					return 1;
				}
				if(!PlayerBodyC[playerid][B_CapClass][pclass][2]) {
					PlayerBodyC[playerid][B_CapClass][pclass][2] = 1;
					SetPlayerCredit(playerid, -40000);

					SCM(playerid, -1, "{CC0033}(Покупка) {FFFFFF}Куплен шлем {FFFF33}3 класса.");
				}
			}
			TDM_SavePlayerClassBody(playerid);
			ShowInfoBuy(playerid, 1);

			n_for(i, 4)
				PlayerTextDrawShow(playerid, TD_cBuy[playerid][i]); // Обновление заднего фона

			new 
				string[100];

			format(string, sizeof(string), "Денег:_$%i", GetPlayerCredits(playerid));
			PlayerTextDrawSetString(playerid, TD_cBuy[playerid][19], string);
			return 1;
		}
		// Бронежилет
		case 2: {
			if(playertextid == TD_cBuy[playerid][22]) {
				DeletePVar(playerid, "Buy_PVar");

				n_for(i, sizeof(TD_cBuy[]))
					DestroyPlayerTD(playerid, TD_cBuy[playerid][i]);

				Interface_Show(playerid, Interface:TDM_SelectedClass);
				
				return 1;
			}
			else if(playertextid == TD_cBuy[playerid][4]) {
				if(!PlayerBody[playerid][B_Armor][pclass]) 
					return 1;

				PlayerBody[playerid][B_Armor][pclass] = 0;
			}
			else if(playertextid == TD_cBuy[playerid][5]) {
				if(PlayerBody[playerid][B_Armor][pclass] == 1) 
					return 1;

				if(PlayerBody[playerid][B_Armor][pclass] != 1 
				&& PlayerBodyC[playerid][B_ArmorClass][pclass][0] == 1)
					PlayerBody[playerid][B_Armor][pclass] = 1;

				if(GetPlayerCredits(playerid) < 15000 
				&& PlayerBodyC[playerid][B_ArmorClass][pclass][0] != 1) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно кредитов.");
					return 1;
				}
				if(!PlayerBodyC[playerid][B_ArmorClass][pclass][0]) {
					PlayerBodyC[playerid][B_ArmorClass][pclass][0] = 1;
					SetPlayerCredit(playerid, -15000);

					SCM(playerid, -1, "{CC0033}(Покупка) {FFFFFF}Куплен бронежилет {FFFF33}1 класса.");
				}
			}
			else if(playertextid == TD_cBuy[playerid][6]) {
				if(PlayerBody[playerid][B_Armor][pclass] == 2) 
					return 1;

				if(PlayerBody[playerid][B_Armor][pclass] != 2 
				&& PlayerBodyC[playerid][B_ArmorClass][pclass][1] == 1)
					PlayerBody[playerid][B_Armor][pclass] = 2;

				if(GetPlayerCredits(playerid) < 30000 
				&& PlayerBodyC[playerid][B_ArmorClass][pclass][1] != 1) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно кредитов.");
					return 1;
				}
				if(!PlayerBodyC[playerid][B_ArmorClass][pclass][1]) {
					PlayerBodyC[playerid][B_ArmorClass][pclass][1] = 1;
					SetPlayerCredit(playerid, -30000);

					SCM(playerid, -1, "{CC0033}(Покупка) {FFFFFF}Куплен бронежилет {FFFF33}2 класса.");
				}
			}
			else if(playertextid == TD_cBuy[playerid][7]) {
				if(PlayerBody[playerid][B_Armor][pclass] == 3) 
					return 1;

				if(PlayerBody[playerid][B_Armor][pclass] != 3 
				&& PlayerBodyC[playerid][B_ArmorClass][pclass][2] == 1)
					PlayerBody[playerid][B_Armor][pclass] = 3;

				if(GetPlayerCredits(playerid) < 60000 
				&& PlayerBodyC[playerid][B_ArmorClass][pclass][2] != 1) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно кредитов.");
					return 1;
				}
				if(!PlayerBodyC[playerid][B_ArmorClass][pclass][2]) {
					PlayerBodyC[playerid][B_ArmorClass][pclass][2] = 1;
					SetPlayerCredit(playerid, -60000);

					SCM(playerid, -1, "{CC0033}(Покупка) {FFFFFF}Куплен бронежилет {FFFF33}3 класса.");
				}
			}
			TDM_SavePlayerClassBody(playerid);
			ShowInfoBuy(playerid, 2);

			n_for(i, 4)
				PlayerTextDrawShow(playerid, TD_cBuy[playerid][i]); // Обновление заднего фона

			new 
				string[100];

			format(string, sizeof(string), "Денег:_$%i", GetPlayerCredits(playerid));
			PlayerTextDrawSetString(playerid, TD_cBuy[playerid][19], string);
			return 1;
		}
	}
	if(GetPVarInt(playerid, "SelectWeapon_PVar") > 0) {
		if(playertextid == TD_cSelectWeapon[playerid][15]) {
			DeletePVar(playerid, "SelectWeapon_PVar");

			n_for(i, sizeof(TD_cSelectWeapon[]))
				DestroyPlayerTD(playerid, TD_cSelectWeapon[playerid][i]);

			Interface_Show(playerid, Interface:TDM_SelectedClass);
			return 1;
		}
		switch(GetPVarInt(playerid, "SelectWeapon_PVar")) {
			// 1 ячейка
			case 1: {
				new 
					slot = 0;

				for(new td = 3, num = 0; num < TDM_CLASS_MAX_WEAPON_SLOTS; td++, num++) {
					if(playertextid == TD_cSelectWeapon[playerid][td]) {
						if(PlayerCWeapon[playerid][CW_Weapon][pclass][slot] == ClassesWeaponID[pclass][slot][num]) 
							return 1;

						if(PlayerClass[playerid][cKills][pclass] < ClassesWeaponPrice[pclass][slot][num]) {
							SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно убийств у класса персонажа.");
							return 1;
						}

						PlayerCWeapon[playerid][CW_Weapon][pclass][slot] = ClassesWeaponID[pclass][slot][num];
						break;
					}
				}
			}
			// 2 ячейка
			case 2: {
				new 
					slot = 1;

				for(new td = 3, num = 0; num < TDM_CLASS_MAX_WEAPON_SLOTS; td++, num++) {
					if(playertextid == TD_cSelectWeapon[playerid][td]) {
						if(PlayerCWeapon[playerid][CW_Weapon][pclass][slot] == ClassesWeaponID[pclass][slot][num]) 
							return 1;

						if(PlayerClass[playerid][cKills][pclass] < ClassesWeaponPrice[pclass][slot][num]) {
							SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно убийств у класса персонажа.");
							return 1;
						}

						PlayerCWeapon[playerid][CW_Weapon][pclass][slot] = ClassesWeaponID[pclass][slot][num];
						break;
					}
				}
			}
			// 3 ячейка
			case 3: {
				new 
					slot = 2;

				for(new td = 3, num = 0; num < TDM_CLASS_MAX_WEAPON_SLOTS; td++, num++) {
					if(playertextid == TD_cSelectWeapon[playerid][td]) {
						if(PlayerCWeapon[playerid][CW_Weapon][pclass][slot] == ClassesWeaponID[pclass][slot][num]) 
							return 1;
						
						if(PlayerClass[playerid][cKills][pclass] < ClassesWeaponPrice[pclass][slot][num]) {
							SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно убийств у класса персонажа.");
							return 1;
						}

						PlayerCWeapon[playerid][CW_Weapon][pclass][slot] = ClassesWeaponID[pclass][slot][num];
						break;
					}
				}
			}
			// 4 ячейка
			case 4: {
				new 
					slot = 3;

				for(new td = 3, num = 0; num < TDM_CLASS_MAX_WEAPON_SLOTS; td++, num++) {
					if(playertextid == TD_cSelectWeapon[playerid][td]) {
						if(PlayerCWeapon[playerid][CW_Weapon][pclass][slot] == ClassesWeaponID[pclass][slot][num]) 
							return 1;

						if(PlayerClass[playerid][cKills][pclass] < ClassesWeaponPrice[pclass][slot][num]) {
							SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно убийств у класса персонажа.");
							return 1;
						}

						PlayerCWeapon[playerid][CW_Weapon][pclass][slot] = ClassesWeaponID[pclass][slot][num];
						break;
					}
				}
			}
		}
		TDM_SavePlayerClassWeapon(playerid);
		ShowInfoWeapon(playerid);

		n_for(i, 3)
			PlayerTextDrawShow(playerid, TD_cSelectWeapon[playerid][i]); // Задний белый фон

		return 1;
	}
	else if(playertextid == TD_cSelectedClass[playerid][9]) {

		n_for(i, sizeof(TD_cSelectedClass[]))
			DestroyPlayerTD(playerid, TD_cSelectedClass[playerid][i]);

		SetPVarInt(playerid, "SelectWeapon_PVar", 1);
		ShowPlayerTDSelectWeapon(playerid);
		ShowInfoWeapon(playerid);

		n_for(i, sizeof(TD_cSelectWeapon[]))
			PlayerTextDrawShow(playerid, TD_cSelectWeapon[playerid][i]);

		return 1;
	}
	else if(playertextid == TD_cSelectedClass[playerid][10]) {
		n_for(i, sizeof(TD_cSelectedClass[]))
			DestroyPlayerTD(playerid, TD_cSelectedClass[playerid][i]);

		SetPVarInt(playerid, "SelectWeapon_PVar", 2);
		ShowPlayerTDSelectWeapon(playerid);
		ShowInfoWeapon(playerid);

		n_for(i, sizeof(TD_cSelectWeapon[]))
			PlayerTextDrawShow(playerid, TD_cSelectWeapon[playerid][i]);

		return 1;
	}
	else if(playertextid == TD_cSelectedClass[playerid][11]) {
		n_for(i, sizeof(TD_cSelectedClass[]))
			DestroyPlayerTD(playerid, TD_cSelectedClass[playerid][i]);

		SetPVarInt(playerid, "SelectWeapon_PVar", 3);
		ShowPlayerTDSelectWeapon(playerid);
		ShowInfoWeapon(playerid);

		n_for(i, sizeof(TD_cSelectWeapon[]))
			PlayerTextDrawShow(playerid, TD_cSelectWeapon[playerid][i]);

		return 1;
	}
	else if(playertextid == TD_cSelectedClass[playerid][12]) {
		n_for(i, sizeof(TD_cSelectedClass[]))
			DestroyPlayerTD(playerid, TD_cSelectedClass[playerid][i]);

		SetPVarInt(playerid, "SelectWeapon_PVar", 4);
		ShowPlayerTDSelectWeapon(playerid);
		ShowInfoWeapon(playerid);

		n_for(i, sizeof(TD_cSelectWeapon[]))
			PlayerTextDrawShow(playerid, TD_cSelectWeapon[playerid][i]);

		return 1;
	}
	// 1 ячейка
	else if(playertextid == TD_cSelectedClass[playerid][13]) {
		new 
			playerclass = GetPlayerCustomClass2(playerid);

		if(PlayerCWeapon[playerid][CW_Ammo][playerclass][0] >= ClassesAmmoLimit[playerclass][0]) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Ещё больше патронов запрещено покупать!");
			return 1;
		}
		SetPVarInt(playerid, "TDM_BuyAmmo_PVar", 1);
		Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
		return 1;
	}
	// 2 ячейка
	else if(playertextid == TD_cSelectedClass[playerid][14]) {
		new 
			playerclass = GetPlayerCustomClass2(playerid);

		if(PlayerCWeapon[playerid][CW_Ammo][playerclass][1] >= ClassesAmmoLimit[playerclass][1]) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Ещё больше патронов запрещено покупать!");
			return 1;
		}
		SetPVarInt(playerid, "TDM_BuyAmmo_PVar", 2);
		Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
		return 1;
	}
	// 3 ячейка
	else if(playertextid == TD_cSelectedClass[playerid][15]) {
		new 
			playerclass = GetPlayerCustomClass2(playerid);

		if(PlayerCWeapon[playerid][CW_Ammo][playerclass][2] >= ClassesAmmoLimit[playerclass][2]) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Ещё больше патронов запрещено покупать!");
			return 1;
		}
		SetPVarInt(playerid, "TDM_BuyAmmo_PVar", 3);
		Dialog_Show(playerid, Dialog:TDM_ClassBuyAmmo);
		return 1;
	}
	// 4 ячейка
	else if(playertextid == TD_cSelectedClass[playerid][16]) 
		return 1;
		
	else if(playertextid == TD_cSelectedClass[playerid][1]) 
		return Dialog_Show(playerid, Dialog:TDM_ClassChooseStats);

	else if(playertextid == TD_cSelectedClass[playerid][26]) {
		n_for(i, sizeof(TD_cSelectedClass[]))
			DestroyPlayerTD(playerid, TD_cSelectedClass[playerid][i]);

		SetPlayerCustomClass(playerid, GetPlayerCustomClass2(playerid));
		SetPlayerCustomClass2(playerid, -1);
		ClosePlayerDialog(playerid);

		Interface_Show(playerid, Interface:TDM_SelectTP);

		SetPlayerInvisible(playerid, false);
		SetPlayerColorEx(playerid, TDM_ShowTeamColorXB(GetPlayerTeamEx(playerid)));
		return 1;
	}
	else if(playertextid == TD_cSelectedClass[playerid][23]) {
		SetPlayerCustomClass2(playerid, -1);

		n_for(i, sizeof(TD_cSelectedClass[]))
			DestroyPlayerTD(playerid, TD_cSelectedClass[playerid][i]);

		ClosePlayerDialog(playerid);

		Interface_Show(playerid, Interface:TDM_SelectClass);
		return 1;
	}
	else if(playertextid == TD_cSelectedClass[playerid][4]) {
		n_for(i, sizeof(TD_cSelectedClass[]))
			DestroyPlayerTD(playerid, TD_cSelectedClass[playerid][i]);

		SetPVarInt(playerid, "Buy_PVar", 1);
		ShowPlayerTDBuy(playerid);
		ShowInfoBuy(playerid, 1);

		n_for(i, sizeof(TD_cBuy[]))
			PlayerTextDrawShow(playerid, TD_cBuy[playerid][i]);

		return 1;
	}
	else if(playertextid == TD_cSelectedClass[playerid][6]) {
		n_for(i, sizeof(TD_cSelectedClass[]))
			DestroyPlayerTD(playerid, TD_cSelectedClass[playerid][i]);

		SetPVarInt(playerid, "Buy_PVar", 2);
		ShowPlayerTDBuy(playerid);
		ShowInfoBuy(playerid, 2);

		n_for(i, sizeof(TD_cBuy[]))
			PlayerTextDrawShow(playerid, TD_cBuy[playerid][i]);

		return 1;
	}
	return 1;
}

InterfaceClick:TDM_SelectedClass(playerid, Text:clickedid)
{
	// Click escape
	if(_:clickedid == INVALID_TEXT_DRAW) {
		if(GetPVarInt(playerid, "SelectWeapon_PVar")) {
			DeletePVar(playerid, "SelectWeapon_PVar");

			n_for(i, sizeof(TD_cSelectWeapon[]))
				DestroyPlayerTD(playerid, TD_cSelectWeapon[playerid][i]);

			Interface_Show(playerid, Interface:TDM_SelectedClass);
			SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);
			return 1;
		}
		if(GetPVarInt(playerid, "Buy_PVar")) {
			DeletePVar(playerid, "Buy_PVar");

			n_for(i, sizeof(TD_cBuy[]))
				DestroyPlayerTD(playerid, TD_cBuy[playerid][i]);

			Interface_Show(playerid, Interface:TDM_SelectedClass);
			SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);
			return 1;
		}
		SetPlayerCustomClass2(playerid, -1);
		Interface_Close(playerid, Interface:TDM_SelectedClass);
		ClosePlayerDialog(playerid);

		Interface_Show(playerid, Interface:TDM_SelectClass);
		SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);
	}
	return 1;
}

InterfaceCreate:TDM_SelectClass(playerid)
{
	TDM_ShowPlayerTDSelectClass(playerid);

	n_for(i, sizeof(TD_cSelectClass[]))
		PlayerTextDrawShow(playerid, TD_cSelectClass[playerid][i]);

	return 1;
}

InterfaceClose:TDM_SelectClass(playerid)
{
	n_for(i, sizeof(TD_cSelectClass[]))
		DestroyPlayerTD(playerid, TD_cSelectClass[playerid][i]);

	return 1;
}

InterfacePlayerClick:TDM_SelectClass(playerid, PlayerText:playertextid)
{
	if(playertextid == TD_cSelectClass[playerid][12]) {
		n_for(i, sizeof(TD_cSelectClass[]))
			DestroyPlayerTD(playerid, TD_cSelectClass[playerid][i]);

		Interface_Show(playerid, Interface:TDM_SelectTP);
		return 1;
	}
	else if(playertextid == TD_cSelectClass[playerid][4])
		SetPlayerCustomClass2(playerid, TDM_C_ASSAULT);

	else if(playertextid == TD_cSelectClass[playerid][5])
		SetPlayerCustomClass2(playerid, TDM_C_MEDIC);

	else if(playertextid == TD_cSelectClass[playerid][6])
		SetPlayerCustomClass2(playerid, TDM_C_ENGINEER);

	else if(playertextid == TD_cSelectClass[playerid][7])
		SetPlayerCustomClass2(playerid, TDM_C_RECON);
	else
		return 1;

	n_for(i, sizeof(TD_cSelectClass[]))
		DestroyPlayerTD(playerid, TD_cSelectClass[playerid][i]);

	Interface_Close(playerid, Interface:TDM_SelectClass);
	Interface_Show(playerid, Interface:TDM_SelectedClass);

	Dina_CheckPlayerHint(playerid, 11);
	return 1;
}

InterfaceClick:TDM_SelectClass(playerid, Text:clickedid)
{
	// Click escape
	if(_:clickedid == INVALID_TEXT_DRAW) {
		Interface_Close(playerid, Interface:TDM_SelectClass);

		Interface_Show(playerid, Interface:TDM_SelectTP);
		SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);
	}
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock TDM_ClOnGameModeInit(session_id)
{
	ResetAllClassAirdrop(session_id, TDM_AIR_WEAPON, -1, true);
	ResetAllClassAirdrop(session_id, TDM_AIR_MEDICAMENT, -1, true);
	ResetAllClassAirdrop(session_id, TDM_AIR_AMMO, -1, true);
	return 1;
}

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);
	ResetPlayerTDs(playerid);

	#if defined TDM_ClOnPlayerConnect
		return TDM_ClOnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerKeyStateChange
*/

stock TDM_ClOnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	#pragma unused oldkeys
	
	new
		session_id = Mode_GetPlayerSession(playerid);

	// ALT
	if(newkeys & KEY_WALK) {
		// Аирдроп оружия игрока
		if(AllCauseWeaponCount[session_id] > 0) {
			n_for(ii, AllCauseWeaponCount[session_id]) {
				new 
					air_id = AllCauseWeaponAir[session_id][ii];

				if(AirCauseWeapon[air_id][Air_Action]) {
					if(AirCauseWeapon[air_id][Air_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) 
						continue;

					if(AirCauseWeapon[air_id][Air_Interior] != GetPlayerInteriorEx(playerid)) 
						continue;

					if(IsPlayerInRangeOfPoint(playerid, 3.0, AirCauseWeapon[air_id][Air_PosX], AirCauseWeapon[air_id][Air_PosY], AirCauseWeapon[air_id][Air_PosZ])) {
						SetPVarInt(playerid, "TDM_LocAirID_PVar", air_id);
						Dialog_Show(playerid, Dialog:PlayerCauseWeapon);
						return 1;
					}
				}
			}
		}
	}

	return 0;
}

/*
	ALS
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