/*

	About: Admin header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		GetAdminNameLevel(level)
Enums:
	E_ADMIN_LEVEL_INFO
Global vars:
	admin_players
	spec_admin_playerid
------------------------------------------------------------------------------*/

#if defined _INC_ADMIN_HEADER
	#endinput
#endif
#define _INC_ADMIN_HEADER

/*

	* Defines *

*/

#define ADM_TD_MAX_CHEATERS		(10)	// Макс. читеров на TD

// Admin levels
#define ADM_MAX_LEVELS		(6)

#define ADM_LEVEL_JUNIOR	(1)
#define ADM_LEVEL_SENIOR	(2)
#define ADM_LEVEL_MAIN		(3)
#define ADM_LEVEL_SPECIAL	(4)
#define ADM_LEVEL_STEERING	(5)
#define ADM_LEVEL_FOUNDER	(6)

/*

	* Enums *

*/

enum E_ADMIN_LEVEL_INFO {
	adm_Name[50],
	adm_Info[500],
}

/*

	* Vars *

*/

static const
	Adm_LevelInfo[ADM_MAX_LEVELS][E_ADMIN_LEVEL_INFO] = {
	{
		"Мл. администратор",
		"-"
	},
	{
		"Cт. администратор",
		"-"
	},
	{
		"Гл. администратор",
		"-"
	},
	{
		"Спец. администратор",
		"-"
	},
	{
		"Рук. администратор",
		"-"
	},
	{
		"Основатель",
		"-"
	}
};

new
	Iterator:admin_players<MAX_PLAYERS>,
	Iterator:spec_admin_playerid[MAX_PLAYERS]<MAX_PLAYERS>;

/*

	* Functions *

*/

stock GetAdminNameLevel(level)
{
	new
		str[50];

	strcat(str, Adm_LevelInfo[level - 1][adm_Name]);
	return str;
}