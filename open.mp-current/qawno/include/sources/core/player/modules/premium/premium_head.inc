/*
 * |>=======================<|
 * |   About: Premium head   |
 * |   Author: Foxze         |
 * |>=======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- GetPremiumCommandName(commandid)
	- GetPremiumCommandInfo(commandid)
	- GetPremiumCommandLevel(commandid)
	- AddPremiumCommands()
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PREMIUM_COMMAND_INFO
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_PREMIUM_HEAD
	#endinput
#endif
#define _INC_PREMIUM_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define PREMIUM_MAX_COMMANDS	(3)

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	PREMIUM_LEVEL_NONE = 0,
	PREMIUM_LEVEL_SILVER
}

enum E_PREMIUM_COMMAND_INFO {
	e_Name[MAX_LENGTH_COMMAND_NAME],
	e_Info[MAX_LENGTH_COMMAND_INFO],
	e_Level
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static const
	PremiumCommandInfo[PREMIUM_MAX_COMMANDS][E_PREMIUM_COMMAND_INFO] = {
	// PREMIUM_LEVEL_SILVER
	{"v", "чат между владельцами премиум аккаунтов", PREMIUM_LEVEL_SILVER},
	{"color", "установить личный цвет своего ника", PREMIUM_LEVEL_SILVER},
	{"adms", "посмотреть администраторов онлайн", PREMIUM_LEVEL_SILVER}
};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock GetPremiumCommandName(commandid)
{
	new
		str[MAX_LENGTH_COMMAND_NAME];

	if (commandid < 0
	|| commandid >= PREMIUM_MAX_COMMANDS) {
		return str;
	}

	strcopy(str, PremiumCommandInfo[commandid][e_Name], MAX_LENGTH_COMMAND_NAME);
	return str;
}

stock GetPremiumCommandInfo(commandid)
{
	new
		str[MAX_LENGTH_COMMAND_INFO];

	if (commandid < 0
	|| commandid >= PREMIUM_MAX_COMMANDS) {
		return str;
	}

	strcopy(str, PremiumCommandInfo[commandid][e_Info], MAX_LENGTH_COMMAND_INFO);
	return str;
}

stock GetPremiumCommandLevel(commandid)
{
	if (commandid < 0
	|| commandid >= PREMIUM_MAX_COMMANDS) {
		return 0;
	}

	return PremiumCommandInfo[commandid][e_Level];
}

stock AddPremiumCommands()
{
	n_for(i, PREMIUM_MAX_COMMANDS) {
		switch(PremiumCommandInfo[i][e_Level]) {
			case PREMIUM_LEVEL_SILVER: {
				PC_SetFlags(GetPremiumCommandName(i), CMD_FLAG_PREMIUM | CMD_FLAG_PREMIUM_SILVER);
			}
		}
	}
	return 1;
}