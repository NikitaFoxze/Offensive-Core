/*

	About: DM location header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_GetNameLocation(location_id)
		DM_GetInfoLocation(location_id)
		DM_GetModeLocation(location_id)
Enums:
	E_DM_LOC_INFO
Global var:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_HEADER
	#endinput
#endif
#define _INC_DM_LOC_HEADER

/*

	* Defines *

*/

#define DM_MAX_SPAWN_POS	(6)		// Кол-во места спавна

// Locations
#define DM_MAX_LOCATIONS	(10)	// Кол-во локаций
#define DM_LOC_DESERT		(0)
#define DM_LOC_GOLF			(1)
#define DM_LOC_MILITARYOIL	(2)
#define DM_LOC_HOMEWHEELS	(3)
#define DM_LOC_POOL			(4)
#define DM_LOC_WAREHOUSE	(5)
#define DM_LOC_DOGMANSION	(6)
#define DM_LOC_PALACESMOKE	(7)
#define DM_LOC_ATRIUM		(8)
#define DM_LOC_JIZZY		(9)

/*

	* Enums *

*/

enum E_DM_LOC_INFO {
	LI_Name[50],
	LI_Info[500],
	LI_Mode
}

/*

	* Vars *

*/

static const
	DM_Location[DM_MAX_LOCATIONS][E_DM_LOC_INFO] = {
	{
		"Пустыня",
		"-",
		DM_MODE_WEAPON_DEAGLE
	},
	{
		"Гольф",
		"-",
		DM_MODE_WEAPON_NORMAL
	},
	{
		"Военный нефтезавод",
		"-",
		DM_MODE_WEAPON_SNIPER
	},
	{
		"Дома на колёсах",
		"-",
		DM_MODE_WEAPON_DEAGLE
	},
	{
		"Бассейн",
		"-",
		DM_MODE_WEAPON_DEAGLE
	},
	{
		"Склад",
		"-",
		DM_MODE_WEAPON_NORMAL
	},
	{
		"Собачий особняк",
		"-",
		DM_MODE_WEAPON_NORMAL
	},
	{
		"Дворец дыма",
		"-",
		DM_MODE_WEAPON_DEAGLE
	},
	{
		"Атриум",
		"-",
		DM_MODE_WEAPON_NORMAL
	},
	{
		"Джизи",
		"-",
		DM_MODE_WEAPON_DEAGLE
	}
};

/*

	* Functions *

*/

stock DM_GetNameLocation(location_id)
{
	new
		str[50];

	strcat(str, DM_Location[location_id][LI_Name]);
	return str;
}

stock DM_GetInfoLocation(location_id)
{
	new
		str[50];

	strcat(str, DM_Location[location_id][LI_Info]);
	return str;
}

stock DM_GetModeLocation(location_id)
{
	return DM_Location[location_id][LI_Mode];
}