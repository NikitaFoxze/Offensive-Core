/*

	About: TDM core header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		TDM_GetModeName(mode_id)
		TDM_GetModeInfo(mode_id)
Enums:
	E_TDM_MODE_INFO
Global var:
	TDM_ActiveTeams
	TDM_ActiveTeamsChet
	spec_squad_playerid
------------------------------------------------------------------------------*/

#if defined _INC_TDM_CORE_HEADER
	#endinput
#endif
#define _INC_TDM_CORE_HEADER

/*

	* Defines *

*/

// Core
#define TDM_MAX_PLAYERS				(100)	// Макс. игроков в сессии
#define TDM_MAX_VEHICLES			(100)	// Макс. транспорта
#define TDM_MAX_GAME_SESSIONS		(3)		// Кол-во сессий

// Others
#define TDM_LOC_END_TIMER			(40)	// Время после окончания игры
#define TDM_SHOP_MAX_ITEMS			(12)	// Макс. предметов в 
#define TDM_MAX_TEAM_BASES			(4)		// Макс. кол-во баз
#define TDM_MAX_CAPTURE_POINTS		(7)		// Макс. кол-во точек
#define TDM_MAX_CHET_CAPTURE		20		// Макс. счёт захвата точки
#define TDM_MAX_CHET_FAST_POINT		12		// Макс. счёт захвата временной точки

#define TDM_MAX_CHET_COMPUTER		(10)	// Макс. счёт захвата компьютера
#define TDM_MAX_COMPUTER_TIMER		(40)	// Время после взлома компьютера
#define TDM_MAX_COMPUTERS			(3)		// Макс. кол-во компьютеров

#define TDM_CLASS_MAX_WEAPONS		(4)		// Макс. кол-во оружия у классов
#define TDM_CLASS_MAX_WEAPON_SLOTS	(3)		// Макс. код-во слотов оружия у классов

#define TDM_MAX_SHOP_BODY			(3)		// Макс. кол-во покупаемой одежды
#define TDM_MAX_QUESTS				(31)	// Макс. кол-во квестов
#define TDM_MAX_QUESTS_PROGRESS		(3)		// Макс. кол-во квестов в процессе
#define TDM_MAX_CHANGE_MAP_LIST		(3)		// Макс. кол-во локаций при выборе после конца раунда
#define TDM_PLAYER_TIMER_RESPAWN	(25)	// Таймер респавна игрока после смерти

#define TDM_LOC_GAME_STATUS_GAME		(1)		// Игра
#define TDM_LOC_GAME_STATUS_RESULT		(2)		// Итоги
#define TDM_LOC_GAME_STATUS_TOP_KILLS	(3)		// Топ убийств
#define TDM_LOC_GAME_STATUS_SELECT		(4)		// Выбор локации

// Classes
#define TDM_MAX_PLAYER_CLASSES		(4)		// Макс. кол-во классов игрока

#define TDM_C_ASSAULT			(0)		// Штурмовик
#define TDM_C_MEDIC				(1)		// Медик
#define TDM_C_ENGINEER			(2)		// Инженер
#define TDM_C_RECON				(3)		// Разведчик

#define TDM_MAX_CLASS_ABILITIES		(1)		// Макс. кол-во способностей классов

#define TDM_MAX_ASSAULT_ABILS	(1)		// Макс. кол-во способностей штурмовика
#define TDM_MAX_MEDIC_ABILS		(1)		// Макс. кол-во способностей медика
#define TDM_MAX_ENGINEER_ABILS	(1)		// Макс. кол-во способностей инженера
#define TDM_MAX_RECON_ABILS		(1)		// Макс. кол-во способностей разведчика

// Team
#define TDM_MAX_TEAMS		(5)		// Макс. команд
#define TDM_TEAM_NONE		(0)		// Команда нейтралы
#define TDM_TEAM_MILITARY	(1)		// Команда военные
#define TDM_TEAM_REBEL		(2)		// Команда повстанцы
#define TDM_TEAM_BANDIT		(3)		// Команда бандиты
#define TDM_TEAM_MARAUDER	(4)		// Команда мародёры

// Modes
#define TDM_MAX_MODES			(4)		// Макс. режимов
#define TDM_MODE_CAPTURE		(0)		// Захват
#define TDM_MODE_CAPTURE_FLAG	(1)		// Захват флага
#define TDM_MODE_SECRET_DATA	(2)		// Взлом
#define TDM_MODE_BATTLE_KILLS	(3)		// Сражение

// Squad
#define TDM_MAX_SQUADS				(20)	// Макс. отрядов
#define TDM_MAX_SQUAD_PLAYERS		(5)		// Макс. игроков в отряде

// Airs
#define MAX_AIR_WEAPON			(50)	// Макс. кол-во самолётов с патронами
#define MAX_AIR_BOMB			(50)	// Макс. кол-во самолётов с бомбами
#define MAX_AIR					(50)	// Макс. кол-во простых самолётов
#define MAX_PLAYER_AIR			(50)	// Макс. кол-во простых самолётов для игрока

// Airdrops cause
#define TDM_AIR_WEAPON				(1)		// Аирдроп оружия
#define TDM_AIR_MEDICAMENT			(2)		// Аирдроп медикаментов
#define TDM_AIR_AMMO				(3)		// Аирдроп патронов

// Airdrop weapon
#define TDM_AIR_MAX_OBJECT_WEAPON				(9)			// Макс. кол-во объектов на контейнере
#define TDM_AIR_MAX_WEAPON						(4)			// Макс. кол-во оружия в контейнере
#define TDM_AIR_TIMER_WEAPON					(30)		// Время до взрыва
#define TDM_AIR_COLOR_NAME_WEAPON				"{57BEDB}"	// Цвет на контейнере

// Airdrop cause weapon
#define TDM_AIR_C_MAX_OBJ_WEAPON			(9)			// Макс. кол-во объектов на контейнере
#define TDM_AIR_C_MAX_WEAPON				(4)			// Макс. кол-во оружия в контейнере
#define TDM_AIR_C_TIMER_WEAPON				(25)		// Время до взрыва
#define TDM_AIR_C_COLOR_NAME_WEAPON			"{57BEDB}"	// Цвет на контейнере

#define TDM_AIR_C_SMALL_RUS_NAME_WEAPON		"Малый контейнер оружия"		// Название малого контейнера
#define TDM_AIR_C_MIDDLE_RUS_NAME_WEAPON	"Средний контейнер оружия"		// Название среднего контейнера
#define TDM_AIR_C_LARGE_RUS_NAME_WEAPON		"Большой контейнер оружия"		// Название большого контейнера

// Airdrop cause medicament
#define TDM_AIR_C_MAX_OBJECT_MEDICAMENT			(7)			// Количество объектов на контейнере
#define TDM_AIR_C_TIMER_MEDICAMENT				(30)		// Время до взрыва
#define TDM_AIR_C_COLOR_NAME_MEDICAMENT			"{57BEDB}"	// Цвет на контейнере

#define TDM_AIR_C_SMALL_BOARD_MEDICAMENT		(2)			// Количество пополнения здоровья
#define TDM_AIR_C_MIDDLE_BOARD_MEDICAMENT		(4)			// Количество пополнения здоровья
#define TDM_AIR_C_LARGE_BOARD_MEDICAMENT		(6)			// Количество пополнения здоровья

#define TDM_AIR_C_SMALL_RUS_NAME_MEDICAMENT		"Малый контейнер медикаментов"		// Название малого контейнера
#define TDM_AIR_C_MIDDLE_RUS_NAME_MEDICAMENT	"Средний контейнер медикаментов"	// Название среднего контейнера
#define TDM_AIR_C_LARGE_RUS_NAME_MEDICAMENT		"Большой контейнер медикаментов"	// Название большого контейнера

// Airdrop cause ammo
#define TDM_AIR_C_MAX_OBJECT_AMMO		(6)			// Количество объектов на контейнере
#define TDM_AIR_C_TIMER_AMMO			(30)		// Время до взрыва
#define TDM_AIR_C_COLOR_NAME_AMMO		"{57BEDB}"	// Цвет на контейнере

#define TDM_AIR_C_SMALL_RUS_NAME_AMMO	"Малый контейнер патронов"		// Название малого контейнера
#define TDM_AIR_C_MIDDLE_RUS_NAME_AMMO	"Средний контейнер патронов"	// Название среднего контейнера
#define TDM_AIR_C_LARGE_RUS_NAME_AMMO	"Большой контейнер патронов"	// Название большого контейнера

#define TDM_MAX_TEAM_NAME_LENGTH	(15 + 1)

/*

	* Enums *

*/

enum E_TDM_MODE_INFO {
	tdm_mName[50],
	tdm_mInfo[800],
}

/*

	* Vars *

*/

static const
	TDM_MInfo[TDM_MAX_MODES][E_TDM_MODE_INFO] =
	{
		// TDM_MODE_CAPTURE
		{
			"Захват",
			"- Необходимо захватить и удерживать точку захвата. \
			\n- Чем больше захваченных точек, тем быстрее повышаются очки команды. \
			\n- Побеждает команда с наибольшим количеством очков команды."
		},
		// TDM_MODE_CAPTURE_FLAG
		{
			"Захват флага",
			"- Необходимо присвоить вражеский флаг и доставить его на свою базу. \
			\n- Доставленный флаг повышает очко команде. \
			\n- Побеждает команда с наибольшим количеством очков команды."
		},
		// TDM_MODE_SECRET_DATA
		{
			"Взлом",
			"- Необходимо взломать или деактивировать компьютер. \
			\n- Защищающая команда отбивает противников от компьютера. \
			\n- Нападающая команда взламывает компьютер. \
			\n\n- Если защищающие сохранили даже один компьютер до окончания матча, \
			\nто они считаются победителями, при взломе всех компьютеров проигрывают. \
			\n- Если нападающие взломали все компьютеры до конца раунда, \
			\nто они считаются победителями, при взломе не всех компьютеров проигрывают."
		},
		// TDM_MODE_BATTLE_KILLS
		{
			"Сражение",
			"- После каждого убитого противника понижаются очки его команды. \
			\n- Побеждает команда с наибольшим количеством очков команды."
		}
	};

new
	Iterator:TDM_ActiveTeams[TDM_MAX_GAME_SESSIONS]<TDM_MAX_TEAMS>,
	Iterator:TDM_ActiveTeamsChet[TDM_MAX_GAME_SESSIONS]<TDM_MAX_TEAMS>;

new
	Iterator:spec_squad_playerid[MAX_PLAYERS]<MAX_PLAYERS>;

/*

	* Functions *

*/

stock TDM_GetModeName(mode_id)
{
	new
		str[50];

	strcat(str, TDM_MInfo[mode_id][tdm_mName]);
	return str;
}

stock TDM_GetModeInfo(mode_id)
{
	new
		str[800];

	strcat(str, TDM_MInfo[mode_id][tdm_mInfo]);
	return str;
}