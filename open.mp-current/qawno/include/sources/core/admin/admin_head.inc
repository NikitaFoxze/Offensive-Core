/*
 * |>=====================<|
 * |   About: Admin head   |
 * |   Author: Foxze       |
 * |>=====================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- GetAdminLevelName(level)
	- GetAdminLevelInfo(level)
	- SendAdminsMessage2(color, string[])
	- GetAdminCommandName(commandid)
	- GetAdminCommandInfo(commandid)
	- GetAdminCommandLevel(commandid)
	- AddAdminCommands()
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_ADMIN_LEVEL_INFO
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
	- StrAdminMessage[ADM_MAX_LENGTH_MESSAGE]
	- Iterator:TotalAdmins<MAX_PLAYERS>
	- Iterator:AdminCountSpecPlayer[MAX_PLAYERS]<MAX_PLAYERS>
 */

#if defined _INC_ADMIN_HEAD
	#endinput
#endif
#define _INC_ADMIN_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define ADM_TD_MAX_CHEATERS		(10)
#define ADM_MAX_LENGTH_KEY		(5)

#define ADM_MAX_LEVELS			(6)
#define ADM_MAX_LENGTH_MESSAGE	(350)
#define ADM_MAX_COMMANDS		(68)

#define SendAdminsMessage(%0,%1,%2) format(StrAdminMessage, sizeof(StrAdminMessage), %1, %2), SendAdminsMessage2(%0, StrAdminMessage)

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	ADM_LEVEL_NONE = 0,
	ADM_LEVEL_JUNIOR,
	ADM_LEVEL_SENIOR,
	ADM_LEVEL_MAIN,
	ADM_LEVEL_SPECIAL,
	ADM_LEVEL_STEERING,
	ADM_LEVEL_FOUNDER
}

enum E_ADMIN_LEVEL_INFO {
	e_Name[MAX_LENGTH_ADM_LEVEL_NAME],
	e_Info[MAX_LENGTH_ADM_LEVEL_INFO]
}

enum E_ADMIN_COMMAND_INFO {
	e_Name[MAX_LENGTH_COMMAND_NAME],
	e_Info[MAX_LENGTH_COMMAND_INFO],
	e_Level
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

new
	StrAdminMessage[ADM_MAX_LENGTH_MESSAGE],

	Iterator:TotalAdmins<MAX_PLAYERS>,
	Iterator:AdminCountSpecPlayer[MAX_PLAYERS]<MAX_PLAYERS>;

static const
	AdminLevelInfo[ADM_MAX_LEVELS][E_ADMIN_LEVEL_INFO] = {
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

static const
	AdminCommandInfo[ADM_MAX_COMMANDS][E_ADMIN_COMMAND_INFO] = {
	// ADM_LEVEL_JUNIOR
	{"amenu", "меню для администрации", ADM_LEVEL_JUNIOR},
	{"a", "админ-чат", ADM_LEVEL_JUNIOR},
	{"ot", "ответ на репорт игроку", ADM_LEVEL_JUNIOR},
	{"sp", "слежка за игроком", ADM_LEVEL_JUNIOR},
	{"offsp", "прекратить слежку за игроком", ADM_LEVEL_JUNIOR},
	{"checkstats", "посмотреть статистику игрока", ADM_LEVEL_JUNIOR},
	{"aspawn", "заспавнить игрока", ADM_LEVEL_JUNIOR},
	{"slap", "подкинуть игрока", ADM_LEVEL_JUNIOR},
	{"jp", "получить Джет-пак", ADM_LEVEL_JUNIOR},
	{"admins", "администрация онлайн", ADM_LEVEL_JUNIOR},
	{"adminstats", "посмотреть свою статистику", ADM_LEVEL_JUNIOR},
	{"asend", "написать от имени администратора", ADM_LEVEL_JUNIOR},

	// ADM_LEVEL_SENIOR
	{"gethere", "телепортировать игрока к себе", ADM_LEVEL_SENIOR},
	{"gotos", "телепортироваться к игроку", ADM_LEVEL_SENIOR},
	{"getip", "узнать IP игрока", ADM_LEVEL_SENIOR},
	{"getwarn", "узнать есть ли у игрока предупреждения", ADM_LEVEL_SENIOR},
	{"z", "заморозить/разморозить игрока", ADM_LEVEL_SENIOR},
	{"weap", "забрать всё оружие у игрока", ADM_LEVEL_SENIOR},
	{"fixveh", "починить свой транспорт", ADM_LEVEL_SENIOR},
	{"fuelveh", "пополнить бензин в своём транспорте", ADM_LEVEL_SENIOR},
	{"rfixveh", "починить транспорт в радиусе", ADM_LEVEL_SENIOR},
	{"rfuelveh", "пополнить бензин в радиусе", ADM_LEVEL_SENIOR},

	// ADM_LEVEL_MAIN
	{"kick", "кикнуть игрока", ADM_LEVEL_MAIN},
	{"mute", "выдать бан-чата игроку", ADM_LEVEL_MAIN},
	{"unmute", "снять бан-чата игроку", ADM_LEVEL_MAIN},
	{"sethp", "выдать здоровье игроку", ADM_LEVEL_MAIN},
	{"setarmour", "выдать броню игроку", ADM_LEVEL_MAIN},
	{"rsethp", "выдать здоровье в радиусе", ADM_LEVEL_MAIN},
	{"rsetarmour", "выдать броню в радиусе", ADM_LEVEL_MAIN},
	{"veh", "создать транспорт", ADM_LEVEL_MAIN},
	{"delveh", "удалить созданный транспорт", ADM_LEVEL_MAIN},
	{"areferals", "посмотреть рефералы игрока", ADM_LEVEL_MAIN},

	// ADM_LEVEL_SPECIAL
	{"ban", "забанить игрока", ADM_LEVEL_SPECIAL},
	{"unban", "разбанить игрока", ADM_LEVEL_SPECIAL},
	{"sban", "тихо забанить игрока", ADM_LEVEL_SPECIAL},
	{"banoff", "забанить в оффлайне игрока", ADM_LEVEL_SPECIAL},
	{"skick", "тихо кикнуть игрока", ADM_LEVEL_SPECIAL},
	{"smute", "тихо выдать бан-чата игроку", ADM_LEVEL_SPECIAL},
	{"sunmute", "тихо снять бан-чата игроку", ADM_LEVEL_SPECIAL},
	{"givegun", "выдать оружие игроку", ADM_LEVEL_SPECIAL},
	{"rgivegun", "выдать оружие в радиусе", ADM_LEVEL_SPECIAL},
	{"warn", "выдать предупреждение игроку", ADM_LEVEL_SPECIAL},
	{"unwarn", "снять предупреждение игроку", ADM_LEVEL_SPECIAL},
	{"banlist", "открыть список забаненных", ADM_LEVEL_SPECIAL},

	// ADM_LEVEL_STEERING
	{"setskin", "выдать скин игроку", ADM_LEVEL_STEERING},
	{"rsetskin", "выдать скин в радиусе", ADM_LEVEL_STEERING},
	{"clearchat", "очистить чат", ADM_LEVEL_STEERING},
	{"aset", "выдать набор оружия игроку", ADM_LEVEL_STEERING},
	{"raset", "выдать набор оружия в радиусе", ADM_LEVEL_STEERING},
	{"warnoff", "выдать предупреждение игроку в оффлайн", ADM_LEVEL_STEERING},
	{"unwarnoff", "снять предупреждение игроку в оффлайн", ADM_LEVEL_STEERING},
	{"givemoney", "выдать денег игроку", ADM_LEVEL_STEERING},
	{"giverank", "выдать ранг игроку", ADM_LEVEL_STEERING},
	{"givemscore", "выдать очки матча игроку", ADM_LEVEL_STEERING},
	{"adamage", "вкл/выкл урон игроку", ADM_LEVEL_STEERING},
	{"astats", "посмотреть статистику администратора", ADM_LEVEL_STEERING},
	{"ao", "написать всем игрокам от имени сервера", ADM_LEVEL_STEERING},
	{"promos", "открыть меню промокодов", ADM_LEVEL_STEERING},
	{"acheat", "открыть меню античита", ADM_LEVEL_STEERING},

	// ADM_LEVEL_FOUNDER
	{"makeadmin", "выдать/снять права админстратора", ADM_LEVEL_FOUNDER},
	{"makeadminoff", "снять права администратора в оффлайне", ADM_LEVEL_FOUNDER},
	{"changeservername", "изменить название сервера", ADM_LEVEL_FOUNDER},
	{"awarn", "выдать выговор администратору", ADM_LEVEL_FOUNDER},
	{"aunwarn", "снять выговор админстратору", ADM_LEVEL_FOUNDER},
	{"modes", "настройка режимов", ADM_LEVEL_FOUNDER},
	{"setitem", "выдать игроку предмет", ADM_LEVEL_FOUNDER},
	{"setbanner", "выдать игроку баннер", ADM_LEVEL_FOUNDER},
	{"dreports", "удалить все репорты", ADM_LEVEL_FOUNDER}
};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock GetAdminLevelName(level)
{
	new
		str[MAX_LENGTH_ADM_LEVEL_NAME];

	strcopy(str, AdminLevelInfo[level - 1][e_Name], MAX_LENGTH_ADM_LEVEL_NAME);
	return str;
}

stock GetAdminLevelInfo(level)
{
	new
		str[MAX_LENGTH_ADM_LEVEL_INFO];

	strcopy(str, AdminLevelInfo[level - 1][e_Info], MAX_LENGTH_ADM_LEVEL_INFO);
	return str;
}

stock SendAdminsMessage2(color, const string[])
{
	foreach (new a:TotalAdmins) {
		SCM(a, color, string);
	}
	return 1;
}

stock GetAdminCommandName(commandid)
{
	new
		str[MAX_LENGTH_COMMAND_NAME];

	if (commandid < 0
	|| commandid >= ADM_MAX_COMMANDS) {
		return str;
	}

	strcopy(str, AdminCommandInfo[commandid][e_Name], MAX_LENGTH_COMMAND_NAME);
	return str;
}

stock GetAdminCommandInfo(commandid)
{
	new
		str[MAX_LENGTH_COMMAND_INFO];

	if (commandid < 0
	|| commandid >= ADM_MAX_COMMANDS) {
		return str;
	}

	strcopy(str, AdminCommandInfo[commandid][e_Info], MAX_LENGTH_COMMAND_INFO);
	return str;
}

stock GetAdminCommandLevel(commandid)
{
	if (commandid < 0
	|| commandid >= ADM_MAX_COMMANDS) {
		return 0;
	}

	return AdminCommandInfo[commandid][e_Level];
}

stock AddAdminCommands()
{
	n_for(i, ADM_MAX_COMMANDS) {
		switch(AdminCommandInfo[i][e_Level]) {
			case ADM_LEVEL_JUNIOR: {
				PC_SetFlags(GetAdminCommandName(i), CMD_FLAG_ADMIN | CMD_FLAG_ADMIN_JUNIOR);
			}
			case ADM_LEVEL_SENIOR: {
				PC_SetFlags(GetAdminCommandName(i), CMD_FLAG_ADMIN | CMD_FLAG_ADMIN_SENIOR);
			}
			case ADM_LEVEL_MAIN: {
				PC_SetFlags(GetAdminCommandName(i), CMD_FLAG_ADMIN | CMD_FLAG_ADMIN_MAIN);
			}
			case ADM_LEVEL_SPECIAL: {
				PC_SetFlags(GetAdminCommandName(i), CMD_FLAG_ADMIN | CMD_FLAG_ADMIN_SPECIAL);
			}
			case ADM_LEVEL_STEERING: {
				PC_SetFlags(GetAdminCommandName(i), CMD_FLAG_ADMIN | CMD_FLAG_ADMIN_STEERING);
			}
			case ADM_LEVEL_FOUNDER: {
				PC_SetFlags(GetAdminCommandName(i), CMD_FLAG_ADMIN | CMD_FLAG_ADMIN_FOUNDER);
			}
		}
	}
	return 1;
}