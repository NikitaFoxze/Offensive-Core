/*

	About: Weapon system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		IsValidWeaponEx(weaponid)
		IsBulletWeaponEx(weaponid)
		IsHighRateWeaponEx(weaponid)
		GetWeaponNameRU(weaponid, weapon[], len)
		GetPlayerColdWeapon(playerid, except_weapon = -1)
		GetPlayerColdWeapon2(playerid, except_weapon = -1)
		GetWeaponModel(weaponid)
		GetWeaponID(weaponid)
		GetWeaponSlot(weaponid)
		GivePlayerWeaponEx(playerid, weaponid, ammo)
		ResetPlayerWeaponsEx(playerid)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_WEAPON_SYSTEM
	#endinput
#endif
#define _INC_WEAPON_SYSTEM

/*

	* Vars *

*/

static const
	w_WeaponNames_RU[][WEAPON_NAME_MAX_LENGTH] = {
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

	* Functions *

*/

stock IsValidWeaponEx(weaponid)
{
	return (0 <= weaponid <= 18 || 22 <= weaponid <= 46);
}

stock IsBulletWeaponEx(weaponid)
{
	return (WEAPON_COLT45 <= weaponid <= WEAPON_SNIPER) || weaponid == WEAPON_MINIGUN;
}

stock IsHighRateWeaponEx(weaponid)
{
	switch(weaponid) {
		case WEAPON_FLAMETHROWER, WEAPON_DROWN, 52,
			WEAPON_SPRAYCAN, WEAPON_FIREEXTINGUISHER: {
			return 1;
		}
	}
	return 0;
}

stock GetWeaponNameRU(weaponid, weapon[], len)
{
	if(!(0 < weaponid < 47)) 
		return 0;

	return strcat(weapon, w_WeaponNames_RU[weaponid], len);
}

stock GetPlayerColdWeapon(playerid, except_weapon = -1)
{
	if(except_weapon == GetPlayerWeapon(playerid)) 
		return 0;

	switch(GetPlayerWeapon(playerid)) {
		case 1, 2, 3, 4, 5, 6, 7, 8, 15: return 1;
		default: return 0;
	}
	return 1;
}

stock GetPlayerColdWeapon2(playerid, except_weapon = -1)
{
	if(except_weapon == GetPlayerWeapon(playerid))
		return 0;

	switch(GetPlayerWeapon(playerid)) {
		case 0, 1, 2, 3, 4, 5, 6, 7, 8, 15: return 1;
		default: return 0;
	}
	return 1;
}

stock GetWeaponModel(weaponid)
{
	switch(weaponid) {
		case 1: return 331;
		case 2: return 333;
		case 3: return 334;
		case 4: return 335;
		case 5: return 336;
		case 6: return 337;
		case 7: return 338;
		case 8: return 339;
		case 9: return 341;
		case 10: return 321;
		case 11: return 322;
		case 12: return 323;
		case 13: return 324;
		case 14: return 325;
		case 15: return 326;
		case 16: return 342;
		case 17: return 343;
		case 18: return 344;
		case 22: return 346;
		case 23: return 347;
		case 24: return 348;
		case 25: return 349;
		case 26: return 350;
		case 27: return 351;
		case 28: return 352;
		case 29: return 353;
		case 30: return 355;
		case 31: return 356;
		case 32: return 372;
		case 33: return 357;
		case 34: return 358;
		case 35: return 359;
		case 36: return 360;
		case 37: return 361;
		case 38: return 362;
		case 39: return 363;
		case 40: return 364;
		case 41: return 365;
		case 42: return 366;
		case 43: return 367;
		case 44: return 368;
		case 45: return 369;
		case 46: return 371;
		default: return -1;
	}
	return -1;
}

stock GetWeaponID(weaponid)
{
	switch(weaponid) {
		case 331: return 1;
		case 333: return 2;
		case 334: return 3;
		case 335: return 4;
		case 336: return 5;
		case 337: return 6;
		case 338: return 7;
		case 339: return 8;
		case 341: return 9;
		case 321: return 10;
		case 322: return 11;
		case 323: return 12;
		case 324: return 13;
		case 325: return 14;
		case 326: return 15;
		case 342: return 16;
		case 343: return 17;
		case 344: return 18;
		case 346: return 22;
		case 347: return 23;
		case 348: return 24;
		case 349: return 25;
		case 350: return 26;
		case 351: return 27;
		case 352: return 28;
		case 353: return 29;
		case 355: return 30;
		case 356: return 31;
		case 372: return 32;
		case 357: return 33;
		case 358: return 34;
		case 359: return 35;
		case 360: return 36;
		case 361: return 37;
		case 362: return 38;
		case 363: return 39;
		case 364: return 40;
		case 365: return 41;
		case 366: return 42;
		case 367: return 43;
		case 368: return 44;
		case 369: return 45;
		case 371: return 46;
		default: return -1;
	}
	return -1;
}

stock GetWeaponSlot(weaponid)
{
	switch(weaponid) {
		case 0, 1: return 0;
		case 2..9: return 1;
		case 22..24: return 2;
		case 25..27: return 3;
		case 28, 29, 32: return 4;
		case 30, 31: return 5;
		case 33, 34: return 6;
		case 35..38: return 7;
		case 16..18, 39: return 8;
		case 41..43: return 9;
		case 10..15: return 10;
		case 44..46: return 11;
		case 40: return 12;
		default: return -1;
	}
	return -1;
}

stock GivePlayerWeaponEx(playerid, weaponid, ammo)
{
	if(!IsValidWeaponEx(weaponid))
		return 1;

	if(!Mode_GivePlayerWeapon(playerid, weaponid, ammo))
		return 1;

	new
		d_weaponid,
		d_ammo;

	GetPlayerWeaponData(playerid, GetWeaponSlot(weaponid), d_weaponid, d_ammo);

	if(d_weaponid > 0
	&& d_ammo > 0) {
		if(d_weaponid != weaponid)
			SetPlayerAmmo(playerid, d_weaponid, 0);
	}

	return GivePlayerWeapon(playerid, weaponid, ammo);
}

stock ResetPlayerWeaponsEx(playerid)
{
	ResetPlayerWeapons(playerid);
	return 1;
}