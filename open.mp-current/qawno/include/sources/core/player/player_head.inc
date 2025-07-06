/*
 * |>======================<|
 * |   About: Player head   |
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
	- SendPlayersMessage2(color, const string[])
	- GetPlayerCommandName(commandid)
	- GetPlayerCommandInfo(commandid)
	- GetPlayerCommandLevel(commandid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_COMMAND_INFO
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_PLAYER_HEAD
	#endinput
#endif
#define _INC_PLAYER_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Death
#define MAX_TEXTS_PLAYER_AFTER_DEAD		(10)
#define MAX_LENGTH_PLAYER_AFTER_DEAD	(50)

// Animations
#define MAX_PLAYER_ANIMATIONS			(49)
#define MAX_LENGTH_PLAYER_ANIMATIONS	(60)

// Referal
#define PLAYER_RANK_BONUS_REFERAL		(15)

// Commands
#define PLAYER_MAX_COMMANDS				(16)

// Others
#define PLAYER_MAX_LENGTH_MESSAGE		(350)

#define SendPlayersMessage(%0,%1,%2) format(StrPlayerMessage, sizeof(StrPlayerMessage), %1, %2), SendPlayersMessage2(%0, StrPlayerMessage)

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_COMMAND_INFO {
	e_Name[MAX_LENGTH_COMMAND_NAME],
	e_Info[MAX_LENGTH_COMMAND_INFO]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

new
	StrPlayerMessage[PLAYER_MAX_LENGTH_MESSAGE];

static const
	PlayerCommandInfo[PLAYER_MAX_COMMANDS][E_PLAYER_COMMAND_INFO] = {
	{"leave", "выйти из режима"},
	{"menu", "открыть главное меню"},
	{"stats", "открыть свою статистику"},
	{"donate", "открыть донат"},
	{"o", "написать в основной чат"},
	{"e", "завести/заглушить транспорт"},
	{"anims", "открыть список анимаций"},
	{"referals", "открыть список рефералов"},
	{"me", "действие от 3 лица"},
	{"cmds", "открыть список команд"},
	{"report", "написать администраторам"},
	{"photo", "получить фотоаппарат"},
	{"piss", "пописать"},
	{"pm", "написать личное сообщение"},
	{"blacklist", "открыть чёрный список"},
	{"bug", "сообщить про баг"}
};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock SendPlayersMessage2(color, const string[])
{
	foreach (new p:Player) {
		if (GetPlayerLogged(p)) {
			continue;
		}

		SCM(p, color, string);
	}
	return 1;
}

stock GetPlayerCommandName(commandid)
{
	new
		str[MAX_LENGTH_COMMAND_NAME];

	if (commandid < 0
	|| commandid >= PLAYER_MAX_COMMANDS) {
		return str;
	}

	strcopy(str, PlayerCommandInfo[commandid][e_Name], MAX_LENGTH_COMMAND_NAME);
	return str;
}

stock GetPlayerCommandInfo(commandid)
{
	new
		str[MAX_LENGTH_COMMAND_INFO];

	if (commandid < 0
	|| commandid >= PLAYER_MAX_COMMANDS) {
		return str;
	}

	strcopy(str, PlayerCommandInfo[commandid][e_Info], MAX_LENGTH_COMMAND_INFO);
	return str;
}

stock GetPlayerCommandLevel(commandid)
{
	if (commandid < 0
	|| commandid >= PLAYER_MAX_COMMANDS) {
		return 0;
	}

	return PlayerCommandInfo[commandid][e_Level];
}