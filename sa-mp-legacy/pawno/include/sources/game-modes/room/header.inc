/*

	About: Room core header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Room_GetModeName(mode_id)
Enums:
	E_ROOM_MODE_INFO
Global var:
	Room_ActiveTeams
	Room_ActiveTeamsChet
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_CORE_HEADER
	#endinput
#endif
#define _INC_ROOM_CORE_HEADER

/*

	* Defines *

*/

// Core
#define ROOM_MAX_PLAYERS			(10)	// Макс. игроков в комнате
#define ROOM_LOBBY_TIMER			(10)	// Время до раунда
#define ROOM_PLAYER_TIMER_RESPAWN	(15)	// Таймер респавна игрока после смерти
#define ROOM_MAX_CHET_CAPTURE		10		// Макс. счёт захвата точки
#define ROOM_MAX_CHET_COMPUTER		(10)	// Макс. счёт захвата компьютера
#define ROOM_MAX_COMPUTER_TIMER		(40)	// Время после взлома компьютера

// Modes
#define ROOM_MAX_MODES				(3)		// Макс. режимов

#define ROOM_MODE_BATTLE			(0)		// Режим сражение
#define ROOM_MODE_CAPTURE			(1)		// Режим захват
#define ROOM_MODE_SECRET_DATA		(2)		// Режим взлом

// Status
#define ROOM_STATUS_LOBBY			(1)		// Статус создания
#define ROOM_STATUS_GAME			(2)		// Статус игры
#define ROOM_STATUS_END				(3)		// Статус окончания игры

// Teams
#define ROOM_MAX_TEAMS				(3)		// Макс. команд

#define ROOM_TEAM_NONE				(0)		// Команда нейтралы
#define ROOM_TEAM_ALPHA				(1)		// Команда альфа
#define ROOM_TEAM_BRAVO				(2)		// Команда браво

#define ROOM_MAX_NAME_LENGTH		(10 + 1)
#define ROOM_MAX_PASSWORD_LENGTH	(10 + 1)
#define ROOM_MAX_TEAM_NAME_LENGTH	(15 + 1)

/*

	* Enums *

*/

enum E_ROOM_MODE_INFO {
	room_mName[50],
	room_mInfo[800],
}

/*

	* Vars *

*/

static const
	Room_MInfo[ROOM_MAX_MODES][E_ROOM_MODE_INFO] = {
		// ROOM_MODE_BATTLE
		{
			"Сражение",
			"- После каждого убитого противника понижаются очки его команды. \
			\n- Побеждает команда с наибольшим количеством очков команды."
		},
		// ROOM_MODE_CAPTURE
		{
			"Захват",
			"- Необходимо захватить и удерживать точку захвата. \
			\n- Чем больше захваченных точек, тем быстрее повышаются очки команды. \
			\n- Побеждает команда с наибольшим количеством очков команды."
		},
		// ROOM_MODE_SECRET_DATA
		{
			"Взлом",
			"- Необходимо захватить и удерживать точку захвата. \
			\n- Чем больше захваченных точек, тем быстрее повышаются очки команды. \
			\n- Побеждает команда с наибольшим количеством очков команды."
		}
	};

new
	Iterator:Room_ActiveTeams[MAX_PLAYERS]<ROOM_MAX_TEAMS>,
	Iterator:Room_ActiveTeamsChet[MAX_PLAYERS]<ROOM_MAX_TEAMS>;


/*

	* Functions *

*/

stock Room_GetModeName(mode_id)
{
	new
		str[50];

	f(str, "%s", Room_MInfo[mode_id][room_mName]);
	return str;
}