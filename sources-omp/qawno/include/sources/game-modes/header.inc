/*

	About: Game-modes core header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Mode_GetName(mode_id)
Enums:
	E_GMS_MODE_INFO
Global var:
	-
------------------------------------------------------------------------------*/

#if defined _INC_GAME_MODES_CORE_HEADER
	#endinput
#endif
#define _INC_GAME_MODES_CORE_HEADER

/*

	* Defines *

*/

#define GM_MAX_MODES			(5)		// Макс. кол-во игровых режимов
#define GM_MAX_SESSIONS			(1000)	// Макс. кол-во сессий в режимах
#define GM_MAX_SESSION_SLOTS	(1000)	// Макс. кол-во игроков в режимах

#define MODE_NONE				(0)		// Нет режима
#define MODE_ROOM				(1)		// Комната
#define MODE_TDM				(2)		// TDM
#define MODE_DM					(3)		// DM
#define MODE_EXAMPLE			(4)		// EXAMPLE

// Additional Elements (AE)
#define	MODE_AE_3D_TEXT_COUNT	(30)	// Кол-во 3D текстов

#define m_for(%0,%1,%2)			for(new pmf = 0, %2 = Mode_GetSessionSlot(%0, %1, 0); pmf < Mode_GetSessionPlayers(%0, %1) && %2 != -1; pmf++, %2 = Mode_GetSessionSlot(%0, %1, pmf))

#define m_leave_for(%0,%1,%2) \
	new f_players = Mode_GetSessionPlayers(%0, %1); \
	new f_playerid[MAX_PLAYERS]; \
	m_for(%0,%1,p_s) f_playerid[pmf] = p_s; \
	for(new ff_players = 0, %2 = f_playerid[0]; ff_players < f_players && %2 != -1; ff_players++, %2 = f_playerid[ff_players])

/*

	* Enums *

*/

enum E_GMS_MODE_INFO {
	GM_Name[50],
	GM_Info[300]
}

/*

	* Vars *

*/

static const
	Mode_Info[][E_GMS_MODE_INFO] = {
	{"None", "-"},
	{"Room", "-"},
	{"TDM", "-"},
	{"DM", "-"},
	{"Example", "-"}
};

/*

	* Functions *

*/

stock Mode_GetName(mode_id)
{
	new
		str[50];

	strcat(str, Mode_Info[mode_id][GM_Name]);
	return str;
}