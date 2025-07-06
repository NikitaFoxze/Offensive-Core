/*

	About: DM core header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_GetModeName(mode_id)
Enums:
	E_DM_MODE_INFO
Global var:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_CORE_HEADER
	#endinput
#endif
#define _INC_DM_CORE_HEADER

/*

	* Defines *

*/

#define DM_MAX_PLAYERS				(10)	// Макс. игроков
#define DM_MAX_GAME_SESSIONS		(7)		// Кол-во сессий

#define DM_MAX_QUESTS				(15)	// Макс. кол-во квестов
#define DM_MAX_QUESTS_PROGRESS		(3)		// Макс. кол-во квестов в процессе
#define DM_PLAYER_TIMER_RESPAWN		(15)	// Таймер респавна игрока после смерти

#define DM_MAX_MODES				(3)		// Кол-во режимов
#define DM_MODE_WEAPON_NORMAL		(0)		// Набор: Дигл, M4, Дробовик
#define DM_MODE_WEAPON_DEAGLE		(1)		// Набор: Дигл +c
#define DM_MODE_WEAPON_SNIPER		(2)		// Набор: Снайперка

#define DM_LOC_GAME_STATUS_GAME		(1)		// Игра

#define DM_TEAM_NONE				(0)		// Нейтралы

/*

	* Enums *

*/

enum E_DM_MODE_INFO {
	dm_mName[50],
	dm_mInfo[300]
}

/*

	* Vars *

*/

static const
	DM_MInfo[DM_MAX_MODES][E_DM_MODE_INFO] = {
		// DM_MODE_WEAPON_NORMAL
		{
			"Стандартный",
			"-"
		},
		// DM_MODE_WEAPON_DEAGLE
		{
			"+C",
			"-"
		},
		// DM_MODE_WEAPON_SNIPER
		{
			"Снайпер",
			"-"
		}
	};

/*

	* Functions *

*/

stock DM_GetModeName(mode_id)
{
	new
		str[50];

	strcat(str, DM_MInfo[mode_id][dm_mName]);
	return str;
}