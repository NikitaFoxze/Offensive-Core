/*
 * |>======================<|
 * |   About: Weapon main   |
 * |   Author: Foxze        |
 * |>======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- IsValidWeaponEx(weaponid)
	- IsBulletWeaponEx(weaponid)
	- IsHighRateWeaponEx(weaponid)
	- GetWeaponNameRU(weaponid, weapon[], len)
	- GetPlayerColdWeapon(playerid, except_weapon = -1)
	- GetPlayerColdWeapon2(playerid, except_weapon = -1)
	- GetWeaponModelEx(weaponid)
	- GetWeaponIDEx(weaponid)
	- GetWeaponSlotEx(weaponid)
	- GivePlayerWeaponEx(playerid, weaponid, ammo)
	- ResetPlayerWeaponsEx(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
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

#if defined _INC_WEAPON_MAIN
	#endinput
#endif
#define _INC_WEAPON_MAIN

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static const
	WeaponNameRU[][MAX_LENGTH_WEAPON_NAME] = {
	"Ничего", "Кастет", "Клюшка", "Дубинка", "Нож",
	"Бита", "Лопата", "Кий", "Катана", "Бензопила",
	"Фаллоимитатор", "Фаллоимитатор", "Вибратор", "Вибратор", "Цветы", "Трость",
	"Граната", "Газ", "Молотов", "", "", "", "Пистолет",
	"Пистолет с глуш.", "Дигл", "Дробовик", "Обрез", "Боевой дробовик",
	"УЗИ", "МП5", "АК-47", "М4", "ТЕК-9", "Винтовка", "Снайперка",
	"РПГ", "РПГ с наведением", "Огнемет",
	"Миниган", "Взрывчатка", "Детонатор", "Баллончик",
	"Огнетушитель", "Фотокамера", "Ночные очки", "Тепловизор",
	"Парашют"
};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock IsValidWeaponEx(WEAPON:weaponid)
{
	return (WEAPON_FIST <= weaponid <= WEAPON_MOLOTOV || WEAPON_COLT45 <= weaponid <= WEAPON_PARACHUTE);
}

stock IsBulletWeaponEx(WEAPON:weaponid)
{
	return (WEAPON_COLT45 <= weaponid <= WEAPON_SNIPER) || weaponid == WEAPON_MINIGUN;
}

stock IsHighRateWeaponEx(WEAPON:weaponid)
{
	switch (weaponid) {
		case WEAPON_FLAMETHROWER, WEAPON_SPRAYCAN, WEAPON_FIREEXTINGUISHER,
		WEAPON_CARPARK, WEAPON_DROWN: {
			return 1;
		}
	}
	return 0;
}

stock GetWeaponNameRU(WEAPON:weaponid, weapon[], len = sizeof(weapon))
{
	if (!(WEAPON_FIST < weaponid < WEAPON_PARACHUTE + WEAPON_BRASSKNUCKLE)) {
		return WEAPON_FIST;
	}
	return strcopy(weapon, WeaponNameRU[weaponid], len);
}

stock GetPlayerColdWeapon(playerid, WEAPON:except_weapon = UNKNOWN_WEAPON)
{
	if (except_weapon == GetPlayerWeapon(playerid)) {
		return 0;
	}

	switch (GetPlayerWeapon(playerid)) {
		case WEAPON_BRASSKNUCKLE, WEAPON_GOLFCLUB, WEAPON_NIGHTSTICK,
		WEAPON_KNIFE, WEAPON_BAT, WEAPON_SHOVEL, WEAPON_POOLSTICK, WEAPON_KATANA, WEAPON_CANE: return 1;
		default: return 0;
	}
	return 1;
}

stock GetPlayerColdWeapon2(playerid, WEAPON:except_weapon = UNKNOWN_WEAPON)
{
	if (except_weapon == GetPlayerWeapon(playerid)) {
		return 0;
	}

	switch (GetPlayerWeapon(playerid)) {
		case WEAPON_FIST, WEAPON_BRASSKNUCKLE, WEAPON_GOLFCLUB, WEAPON_NIGHTSTICK, WEAPON_KNIFE,
		WEAPON_BAT, WEAPON_SHOVEL, WEAPON_POOLSTICK, WEAPON_KATANA, WEAPON_CANE: return 1;
		default: return 0;
	}
	return 1;
}

stock GetWeaponModelEx(WEAPON:weaponid)
{
	switch (weaponid) {
		case WEAPON_BRASSKNUCKLE: return 331;
		case WEAPON_GOLFCLUB: return 333;
		case WEAPON_NIGHTSTICK: return 334;
		case WEAPON_KNIFE: return 335;
		case WEAPON_BAT: return 336;
		case WEAPON_SHOVEL: return 337;
		case WEAPON_POOLSTICK: return 338;
		case WEAPON_KATANA: return 339;
		case WEAPON_CHAINSAW: return 341;
		case WEAPON_DILDO: return 321;
		case WEAPON_DILDO2: return 322;
		case WEAPON_VIBRATOR: return 323;
		case WEAPON_VIBRATOR2: return 324;
		case WEAPON_FLOWER: return 325;
		case WEAPON_CANE: return 326;
		case WEAPON_GRENADE: return 342;
		case WEAPON_TEARGAS: return 343;
		case WEAPON_MOLOTOV: return 344;
		case WEAPON_COLT45: return 346;
		case WEAPON_SILENCED: return 347;
		case WEAPON_DEAGLE: return 348;
		case WEAPON_SHOTGUN: return 349;
		case WEAPON_SAWEDOFF: return 350;
		case WEAPON_SHOTGSPA: return 351;
		case WEAPON_UZI: return 352;
		case WEAPON_MP5: return 353;
		case WEAPON_AK47: return 355;
		case WEAPON_M4: return 356;
		case WEAPON_TEC9: return 372;
		case WEAPON_RIFLE: return 357;
		case WEAPON_SNIPER: return 358;
		case WEAPON_ROCKETLAUNCHER: return 359;
		case WEAPON_HEATSEEKER: return 360;
		case WEAPON_FLAMETHROWER: return 361;
		case WEAPON_MINIGUN: return 362;
		case WEAPON_SATCHEL: return 363;
		case WEAPON_BOMB: return 364;
		case WEAPON_SPRAYCAN: return 365;
		case WEAPON_FIREEXTINGUISHER: return 366;
		case WEAPON_CAMERA: return 367;
		case WEAPON_NIGHT_VISION_GOGGLES: return 368;
		case WEAPON_THERMAL_GOGGLES: return 369;
		case WEAPON_PARACHUTE: return 371;
	}
	return 0;
}

stock GetWeaponIDEx(modelid)
{
	switch (modelid) {
		case 331: return WEAPON_BRASSKNUCKLE;
		case 333: return WEAPON_GOLFCLUB;
		case 334: return WEAPON_NIGHTSTICK;
		case 335: return WEAPON_KNIFE;
		case 336: return WEAPON_BAT;
		case 337: return WEAPON_SHOVEL;
		case 338: return WEAPON_POOLSTICK;
		case 339: return WEAPON_KATANA;
		case 341: return WEAPON_CHAINSAW;
		case 321: return WEAPON_DILDO;
		case 322: return WEAPON_DILDO2;
		case 323: return WEAPON_VIBRATOR;
		case 324: return WEAPON_VIBRATOR2;
		case 325: return WEAPON_FLOWER;
		case 326: return WEAPON_CANE;
		case 342: return WEAPON_GRENADE;
		case 343: return WEAPON_TEARGAS;
		case 344: return WEAPON_MOLOTOV;
		case 346: return WEAPON_COLT45;
		case 347: return WEAPON_SILENCED;
		case 348: return WEAPON_DEAGLE;
		case 349: return WEAPON_SHOTGUN;
		case 350: return WEAPON_SAWEDOFF;
		case 351: return WEAPON_SHOTGSPA;
		case 352: return WEAPON_UZI;
		case 353: return WEAPON_MP5;
		case 355: return WEAPON_AK47;
		case 356: return WEAPON_M4;
		case 372: return WEAPON_TEC9;
		case 357: return WEAPON_RIFLE;
		case 358: return WEAPON_SNIPER;
		case 359: return WEAPON_ROCKETLAUNCHER;
		case 360: return WEAPON_HEATSEEKER;
		case 361: return WEAPON_FLAMETHROWER;
		case 362: return WEAPON_MINIGUN;
		case 363: return WEAPON_SATCHEL;
		case 364: return WEAPON_BOMB;
		case 365: return WEAPON_SPRAYCAN;
		case 366: return WEAPON_FIREEXTINGUISHER;
		case 367: return WEAPON_CAMERA;
		case 368: return WEAPON_NIGHT_VISION_GOGGLES;
		case 369: return WEAPON_THERMAL_GOGGLES;
		case 371: return WEAPON_PARACHUTE;
	}
	return WEAPON_FIST;
}

stock GetWeaponSlotEx(WEAPON:weaponid)
{
	switch (weaponid) {
		case WEAPON_FIST, WEAPON_BRASSKNUCKLE: return WEAPON_SLOT_UNARMED;
		case WEAPON_GOLFCLUB..WEAPON_CHAINSAW: return WEAPON_SLOT_MELEE;
		case WEAPON_COLT..WEAPON_DEAGLE: return WEAPON_SLOT_PISTOL;
		case WEAPON_SHOTGUN..WEAPON_SHOTGSPA: return WEAPON_SLOT_SHOTGUN;
		case WEAPON_UZI, WEAPON_MP5, WEAPON_TEC9: return WEAPON_SLOT_MACHINE_GUN;
		case WEAPON_AK47, WEAPON_M4: return WEAPON_SLOT_ASSAULT_RIFLE;
		case WEAPON_RIFLE, WEAPON_SNIPER: return WEAPON_SLOT_LONG_RIFLE;
		case WEAPON_ROCKETLAUNCHER..WEAPON_MINIGUN: return WEAPON_SLOT_ARTILLERY;
		case WEAPON_GRENADE..WEAPON_MOLOTOV, WEAPON_SATCHEL: return WEAPON_SLOT_EXPLOSIVES;
		case WEAPON_SPRAYCAN..WEAPON_CAMERA: return WEAPON_SLOT_EQUIPMENT;
		case WEAPON_DILDO..WEAPON_CANE: return WEAPON_SLOT_GIFT;
		case WEAPON_NIGHT_VISION_GOGGLES..WEAPON_PARACHUTE: return WEAPON_SLOT_GADGET;
		case WEAPON_BOMB: return WEAPON_SLOT_DETONATOR;
	}
	return UNKNOWN_WEAPON_SLOT;
}

stock GivePlayerWeaponEx(playerid, WEAPON:weaponid, ammo)
{
	if (!IsValidWeaponEx(weaponid)) {
		return 1;
	}

	if (!Mode_GivePlayerWeapon(playerid, weaponid, ammo)) {
		return 1;
	}

	new
		WEAPON:dWeaponid,
		dAmmo;

	GetPlayerWeaponData(playerid, GetWeaponSlot(weaponid), dWeaponid, dAmmo);

	if (dWeaponid > WEAPON_FIST
	&& dAmmo > 0) {
		if (dWeaponid != weaponid)
			SetPlayerAmmo(playerid, dWeaponid, 0);
	}

	return GivePlayerWeapon(playerid, weaponid, ammo);
}

stock ResetPlayerWeaponsEx(playerid)
{
	ResetPlayerWeapons(playerid);
	return 1;
}