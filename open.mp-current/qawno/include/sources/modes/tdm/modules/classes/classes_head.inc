/*
 * |>===========================<|
 * |   About: TDM classes head   |
 * |   Author: Foxze             |
 * |>===========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
    - TDM_GetClassName(classid)
	- TDM_GetClassNeed(classid, needid, &Float:need)
	- TDM_GetClassWeaponID(classid, slot, num)
	- TDM_GetClassWeaponPrice(classid, slot, num)
	- TDM_GetClassAmmoPrice(classid, slot, num)
	- TDM_GetClassAmmoLimit(classid, slot)
	- TDM_GetClassSkin(teamid, classid, sexid)
	- TDM_GetClassAbilName(classid, abilityid)
	- TDM_GetClassAbilInfo(classid, abilityid)
	- TDM_GetClassAbilPrice(classid, abilityid)
	- TDM_GetClassAbilMPoints(classid, abilityid)
	- TDM_GetClassAbilMaxMPoints(classid, abilityid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_TDM_PLAYER_CLASS_ABIl_INFO
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_TDM_CLASSES_HEAD
	#endinput
#endif
#define _INC_TDM_CLASSES_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Core
#define TDM_MAX_PLAYER_CLASSES		(4)		// Max number of player classes
#define TDM_MAX_CLASS_ABILITIES		(1)		// Max number of class abilities

// Weapon
#define TDM_CLASS_MAX_WEAPONS		(4)		// Max weapons for classes
#define TDM_CLASS_MAX_WEAPON_SLOTS	(3)		// Max weapon slots for classes

// Needs
#define TDM_CLASS_MAX_NEEDS			(2)

// Max number of abilities
#define TDM_MAX_ASSAULT_ABILS	(1)
#define TDM_MAX_MEDIC_ABILS		(1)
#define TDM_MAX_ENGINEER_ABILS	(1)
#define TDM_MAX_RECON_ABILS		(1)

// Airdrop cause weapon
#define TDM_AIR_C_MAX_OBJ_WEAPON			(9)			// Max number of objects per container
#define TDM_AIR_C_MAX_WEAPON				(4)			// Max weapons in container
#define TDM_AIR_C_TIMER_WEAPON				(25)		// Timer before explosion
#define TDM_AIR_C_COLOR_NAME_WEAPON			"{57BEDB}"	// Color on container

// Airdrop cause medicament
#define TDM_AIR_C_MAX_OBJECT_MEDICAMENT			(7)			// Number of objects in the container
#define TDM_AIR_C_TIMER_MEDICAMENT				(30)		// Timer before explosion
#define TDM_AIR_C_COLOR_NAME_MEDICAMENT			"{57BEDB}"	// Color on container

// Health replenishment amount
#define TDM_AIR_C_SMALL_BOARD_MEDICAMENT		(2)
#define TDM_AIR_C_MIDDLE_BOARD_MEDICAMENT		(4)
#define TDM_AIR_C_LARGE_BOARD_MEDICAMENT		(6)

// Airdrop cause ammo
#define TDM_AIR_C_MAX_OBJECT_AMMO		(6)			// Number of objects in the container
#define TDM_AIR_C_TIMER_AMMO			(30)		// Timer before explosion
#define TDM_AIR_C_COLOR_NAME_AMMO		"{57BEDB}"	// Color on container

// Others
#define TDM_MAX_LENGTH_CLASS_NAME		(50)

#define TDM_MAX_LEN_CLASS_ABIL_NAME     (50)
#define TDM_MAX_LEN_CLASS_ABIL_INFO     (500)

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	TDM_CLASS_ASSAULT = 0,
	TDM_CLASS_MEDIC,
	TDM_CLASS_ENGINEER,
	TDM_CLASS_RECON
}

enum {
	TDM_CLASS_NEED_HEALTH = 0,
	TDM_CLASS_NEED_ARMOUR
}

// Player classes ability
enum E_TDM_PLAYER_CLASS_ABIl_INFO {
	e_Name[TDM_MAX_LEN_CLASS_ABIL_NAME],
	e_Info[TDM_MAX_LEN_CLASS_ABIL_INFO],
	e_Price,
	e_MatchPoints,
	e_MatchPointsMax,
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

/*
 * |>-------------------<|
 * |   Options classes   |
 * |>-------------------<|
 */

static const
	NameInfo[TDM_MAX_PLAYER_CLASSES][TDM_MAX_LENGTH_CLASS_NAME] = {
		"Штурмовик",
		"Медик",
		"Инженер",
		"Разведчик"
	};

// Health and Armour
static const
	Float:NeedsInfo[TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_NEEDS] = {
		{100.0, 30.0},	// Assault
		{100.0, 10.0},	// Medic
		{100.0, 40.0},	// Engineer
		{100.0, 10.0}	// Recon
	};

static const
	WEAPON:WeaponIDInfo[TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS][TDM_CLASS_MAX_WEAPON_SLOTS] = {
		// Assault
		{
			{WEAPON_AK47, WEAPON_M4, WEAPON_SHOTGSPA},
			{WEAPON_COLT45, WEAPON_SILENCED, WEAPON_DEAGLE},
			{WEAPON_GRENADE, WEAPON_TEARGAS, WEAPON_MOLOTOV},
			{WEAPON_BRASSKNUCKLE, WEAPON_KNIFE, WEAPON_KATANA}
		},
		// Medic
		{
			{WEAPON_MP5, WEAPON_SHOTGUN, WEAPON_UZI},
			{WEAPON_COLT45, WEAPON_SILENCED, WEAPON_DEAGLE},
			{WEAPON_TEARGAS, WEAPON_GRENADE, WEAPON_FIST},
			{WEAPON_BAT, WEAPON_KNIFE, WEAPON_POOLSTICK}
		},
		// Engineer
		{
			{WEAPON_AK47, WEAPON_SHOTGSPA, WEAPON_SAWEDOFF},
			{WEAPON_COLT45, WEAPON_SILENCED, WEAPON_DEAGLE},
			{WEAPON_TEARGAS, WEAPON_GRENADE, WEAPON_MOLOTOV},
			{WEAPON_KATANA, WEAPON_BAT, WEAPON_CHAINSAW}
		},
		// Recon
		{
			{WEAPON_SNIPER, WEAPON_RIFLE, WEAPON_FIST},
			{WEAPON_COLT45, WEAPON_SILENCED, WEAPON_FIST},
			{WEAPON_TEARGAS, WEAPON_MOLOTOV, WEAPON_FIST},
			{WEAPON_BRASSKNUCKLE, WEAPON_SHOVEL, WEAPON_POOLSTICK}
		}
	};

static const
	WeaponPriceInfo[TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS][TDM_CLASS_MAX_WEAPON_SLOTS] = {
		// Assault
		{
			{0, 30, 80},
			{0, 10, 50},
			{0, 15, 100},
			{0, 20, 35}
		},
		// Medic
		{
			{0, 25, 85},
			{0, 10, 60},
			{0, 30, 0},
			{0, 20, 40}
		},
		// Engineer
		{
			{0, 50, 100},
			{0, 10, 55},
			{0, 15, 70},
			{0, 30, 80}
		},
		// Recon
		{
			{0, 50, 0},
			{0, 20, 0},
			{0, 80, 0},
			{0, 25, 40}
		}
	};

static const
	AmmoPriceInfo[TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS][2] = {
		// Assault
		{
			{100, 1},
			{200, 1},
			{350, 1},
			{0, 0}
		},
		// Medic
		{
			{150, 1},
			{50, 1},
			{350, 1},
			{0, 0}
		},
		// Engineer
		{
			{100, 1},
			{200, 1},
			{350, 1},
			{0, 0}
		},
		// Recon
		{
			{250, 1},
			{50, 1},
			{350, 1},
			{0, 0}
		}
	};

static const
	AmmoLimitInfo[TDM_MAX_PLAYER_CLASSES][TDM_CLASS_MAX_WEAPONS] = {
		{ 700, 200, 50, 1 },	// Assault
		{ 700, 200, 50, 1 },	// Medic
		{ 700, 200, 50, 1 },	// Engineer
		{ 700, 200, 50, 1 }		// Recon
	};

// Male and Female skin
static const
	SkinInfo[TDM_MAX_TEAMS][TDM_MAX_PLAYER_CLASSES][2] = {
		// Neutral
		{
			{0, 0},			// Assault
			{0, 0},			// Medic
			{0, 0},			// Engineer
			{0, 0}			// Recon
		},
		// Military
		{
			{287, 191},		// Assault
			{276, 309},		// Medic
			{179, 191},		// Engineer
			{300, 306}		// Recon
		},
		// Rebel
		{
			{303, 193},		// Assault
			{275, 308},		// Medic
			{50, 190},		// Engineer
			{124, 193}		// Recon
		},
		// Bandit
		{
			{112, 190},		// Assault
			{70, 308},		// Medic
			{180, 192},		// Engineer
			{122, 226}		// Recon
		},
		// Marauder
		{
			{100, 195},		// Assault
			{274, 308},		// Medic
			{299, 298},		// Engineer
			{248, 93}		// Recon
		}
	};

static const
	AlibityInfo[TDM_MAX_PLAYER_CLASSES][TDM_MAX_CLASS_ABILITIES][E_TDM_PLAYER_CLASS_ABIl_INFO] = {
		// Assault
		{
			{"Аирдроп оружия", "Данная способность позволяет вызвать аирдроп с оружием.\nАирдроп прилетает через 10 секунд после вызова.", 10000, 1000, 2000}
		},
		// Medic
		{
			{"Аирдроп медикаментов", "Данная способность позволяет вызвать аирдроп с медикаментами.\nАирдроп прилетает через 10 секунд после вызова.", 10000, 1000, 2000}
		},
		// Engineer
		{
			{"Аирдроп патронов", "Данная способность позволяет вызвать аирдроп с патронами.\nАирдроп прилетает через 10 секунд после вызова.", 10000, 1000, 2000}
		},
		// Recon
		{
			{"Невидимость", "Данная способность позволяет стать невидимым на радарах.\nПосле смерти невидимость пропадает.", 10000, 1000, 0}
		}
	};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>--------<|
 * |   Core   |
 * |>--------<|
 */

stock TDM_GetClassName(classid)
{
	new
		str[TDM_MAX_LENGTH_CLASS_NAME];
	
	strcopy(str, NameInfo[classid], TDM_MAX_LENGTH_CLASS_NAME);
	return str;
}

stock TDM_GetClassNeed(classid, needid, &Float:need)
{
	need = NeedsInfo[classid][needid];
	return 1;
}

stock WEAPON:TDM_GetClassWeaponID(classid, slot, num)
{
	return WeaponIDInfo[classid][slot][num];
}

stock TDM_GetClassWeaponPrice(classid, slot, num)
{
	return WeaponPriceInfo[classid][slot][num];
}

stock TDM_GetClassAmmoPrice(classid, slot, num)
{
	return AmmoPriceInfo[classid][slot][num];
}

stock TDM_GetClassAmmoLimit(classid, slot)
{
	return AmmoLimitInfo[classid][slot];
}

stock TDM_GetClassSkin(teamid, classid, sexid)
{
	return SkinInfo[teamid][classid][sexid];
}

/*
 * |>-----------<|
 * |   Ability   |
 * |>-----------<|
 */

stock TDM_GetClassAbilName(classid, abilityid)
{
	new
		str[TDM_MAX_LEN_CLASS_ABIL_NAME];
	
	strcopy(str, AlibityInfo[classid][abilityid][e_Name], TDM_MAX_LEN_CLASS_ABIL_NAME);
	return str;
}

stock TDM_GetClassAbilInfo(classid, abilityid)
{
	new
		str[TDM_MAX_LEN_CLASS_ABIL_INFO];
	
	strcopy(str, AlibityInfo[classid][abilityid][e_Info], TDM_MAX_LEN_CLASS_ABIL_INFO);
	return str;
}

stock TDM_GetClassAbilPrice(classid, abilityid)
{
	return AlibityInfo[classid][abilityid][e_Price];
}

stock TDM_GetClassAbilMPoints(classid, abilityid)
{
	return AlibityInfo[classid][abilityid][e_MatchPoints];
}

stock TDM_GetClassAbilMaxMPoints(classid, abilityid)
{
	return AlibityInfo[classid][abilityid][e_MatchPointsMax];
}