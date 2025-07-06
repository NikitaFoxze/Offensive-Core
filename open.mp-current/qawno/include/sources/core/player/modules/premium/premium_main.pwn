/*
 * |>=======================<|
 * |   About: Premium main   |
 * |   Author: Foxze         |
 * |>=======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- PC_OnInit()
	- OnPlayerConnect(playerid)
	- OnPlayerCommandReceived(playerid, cmd[], params[], flags)
 * Stock:
	- SetPlayerPremium(playerid, level)
    - GetPlayerPremium(playerid)
    - SetPlayerPremiumDatetime(playerid, const datetime[])
    - GetPlayerPremiumDatetime(playerid)
    - CheckPremiumAccount(playerid)
    - SetPlayerNicknameColor(playerid, const color[])
    - GetPlayerNicknameColor(playerid)

    - MySQLUploadPlayerPremium(playerid)
	- SavePlayerPremium(playerid)
	- SavePlayerNickColor(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_PREMIUM_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- v(playerid, params[])
	- color(playerid)
	- adms(playerid)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- BuyPremium
    - ChangeNicknameColor
    - InputNicknameColor
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_PREMIUM_MAIN
	#endinput
#endif
#define _INC_PREMIUM_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_PREMIUM_INFO {
	// MySQL
	e_Premium,
	e_PremiumDatetime[MAX_LENGTH_DATETIME],
	e_NickColor[MAX_LENGTH_COLOR_NICK]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_PREMIUM_INFO];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>-----------<|
 * |   Premium   |
 * |>-----------<|
 */

stock SetPlayerPremium(playerid, level)
{
	pInfo[playerid][e_Premium] = level;
	return 1;
}

stock GetPlayerPremium(playerid)
{
	return pInfo[playerid][e_Premium];
}

/*
 * |>--------------------<|
 * |   Premium datetime   |
 * |>--------------------<|
 */

stock SetPlayerPremiumDatetime(playerid, const datetime[])
{
	strcopy(pInfo[playerid][e_PremiumDatetime], datetime, MAX_LENGTH_DATETIME);
	return 1;
}

stock GetPlayerPremiumDatetime(playerid)
{
	new
		str[MAX_LENGTH_DATETIME];

	strcopy(str, pInfo[playerid][e_PremiumDatetime], MAX_LENGTH_DATETIME);
	return str;
}

/*
 * |>-----------------<|
 * |   Check premium   |
 * |>-----------------<|
 */

stock CheckPremiumAccount(playerid)
{
	new
		daysRemaining;

	if (!IsDatetimeExpired(GetPlayerPremiumDatetime(playerid), daysRemaining)) {
		SCM(playerid, C_LIGHT_BLUE, ""T_PREMIUM" "CT_WHITE"Осталось дней: %i", daysRemaining);
	}
	else {
		SetPlayerPremium(playerid, PREMIUM_LEVEL_NONE);
		SetPlayerPremiumDatetime(playerid, DB_STRING_VALUE_NO);
		SetPlayerNicknameColor(playerid, DB_STRING_VALUE_NO);

		SCM(playerid, C_LIGHT_BLUE, ""T_PREMIUM" "CT_WHITE"Ваш Премиум подошёл к конку :(");
	}
	return 1;
}

/*
 * |>------------------<|
 * |   Nickname color   |
 * |>------------------<|
 */

stock SetPlayerNicknameColor(playerid, const color[])
{
	strcopy(pInfo[playerid][e_NickColor], color, MAX_LENGTH_COLOR_NICK);
    mysql_escape_string(color, pInfo[playerid][e_NickColor], MAX_LENGTH_COLOR_NICK);
	return 1;
}

stock GetPlayerNicknameColor(playerid)
{
	new
		str[MAX_LENGTH_COLOR_NICK];

	strcopy(str, pInfo[playerid][e_NickColor], MAX_LENGTH_COLOR_NICK);
	return str;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerPremiumData(playerid)
{
	pInfo[playerid][e_Premium]				= PREMIUM_LEVEL_NONE;
	pInfo[playerid][e_PremiumDatetime][0]	= EOS;

	pInfo[playerid][e_NickColor][0]			= EOS;

	mysql_escape_string(DB_STRING_VALUE_NO, pInfo[playerid][e_NickColor], MAX_LENGTH_COLOR_NICK);
	return 1;
}

/*
 * |>----------------<|
 * |     Commands     |
 * |>----------------<|
 */

CMD:v(playerid, params[])
{
	if (isnull(params)) {
		return SendPlayerMessageCMD(playerid, "/v [текст]");
	}

	if (GetPlayerAntiFloodChat(playerid) > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Не флуди!");
		return 1;
	}

	static
		string[300];

	string[0] = EOS;

	f(string, "{eb972a}[Premium]:{%06x}%s(%d): "CT_WHITE"%s", GetPlayerColorEx(playerid) >>> 8, GetPlayerNameEx(playerid), playerid, params);

	foreach (Player, p) {
		if (!IsPlayerOnServer(p)) {
			continue;
		}

		if (GetPlayerPremium(playerid) == PREMIUM_LEVEL_NONE) {
			continue;
		}

		SCMEX(p, C_WHITE, string, true);
	}
	SetPlayerAntiFloodChat(playerid);
	return 1;
}

CMD:color(playerid)
{
	Dialog_Show(playerid, Dialog:ChangeNicknameColor);
	return 1;
}

CMD:adms(playerid)
{
	Dialog_Show(playerid, Dialog:AdminOnline);
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

/*
 * |>---------------<|
 * |   Buy premium   |
 * |>---------------<|
 */

DialogCreate:BuyPremium(playerid)
{
	static
		str[650];

	str[0] = EOS;
	
	f(str,
	""CT_WHITE"Покупка: {eba82d}Премиум аккаунт\
	\n"CT_WHITE"Стоимость: {ebdb2d}250 GoldCoins\
	\n"CT_WHITE"На счету: {ebdb2d}%i GoldCoins\
	\n\n"CT_WHITE"Возможности:\
	\n{2deb66}• "CT_WHITE"Чат между владельцами премиум аккаунтов (/v).\
	\n{2deb66}• "CT_WHITE"Просмотр онлайн администрации (/adms).\
	\n{2deb66}• "CT_WHITE"Установка личного цвета своего ника (/color).\
	\n{2deb66}• "CT_WHITE"Все анти-флуды не будут действовать.\
	\n{2deb66}• "CT_WHITE"Получения оружие РПГ в TDM режиме.\
	\n{2deb66}• "CT_WHITE"Получение x2 EXP.\
	\n\n{eb2d2d}• "CT_WHITE"Премиум аккаунт будет действовать целый месяц после покупки!", GetPlayerGoldCoins(playerid));
	Dialog_Open(playerid, Dialog:Donate, DSM, "Покупка Премиум аккаунта", str, "Купить", "Назад");
	return 1;
}

DialogResponse:BuyPremium(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:Donate);
		return 1;
	}

	if (GetPlayerPremium(playerid) != PREMIUM_LEVEL_NONE) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы уже обладаете Премиум аккаунтом!");
		Dialog_Show(playerid, Dialog:Donate);
		return 1;
	}

	if (GetPlayerGoldCoins(playerid) < 250) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Необходимо иметь 250 GoldCoins!");
		Dialog_Show(playerid, Dialog:Donate);
		return 1;
	}

	GivePlayerGoldCoins(playerid, -250);
	SetPlayerPremium(playerid, PREMIUM_LEVEL_SILVER);
	SetPlayerPremiumDatetime(playerid, AddToDatetime(GetCurrentDatetime(), .days = 30));

	SavePlayerPremium(playerid);

	SCM(playerid, C_LIGHT_BLUE, ""T_PREMIUM" "CT_WHITE"Премиум аккаунт успешно приобретён на 30 дней!");
	Dialog_Show(playerid, Dialog:Donate);
	return 1;
}

/*
 * |>-------------------------<|
 * |   Change nickname color   |
 * |>-------------------------<|
 */

DialogCreate:ChangeNicknameColor(playerid)
{
	Dialog_Open(playerid, Dialog:ChangeNicknameColor, DSL, "Изменение цвета ника",
	""CT_ORANGE""T_NUM" "CT_WHITE"Изменить цвет\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Сбросить цвет",
	"Выбрать", "Выйти");
	return 1;
}

DialogResponse:ChangeNicknameColor(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:InputNicknameColor);
		}
		case 1: {
			if (Mode_GetPlayerMode(playerid) != MODE_NONE) {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данную функцию можно изменить только в главном меню.");
				return 1;
			}

			if (!strcmp(GetPlayerNicknameColor(playerid), DB_STRING_VALUE_NO, true)) {
				return 1;
			}

			SetPlayerNicknameColor(playerid, DB_STRING_VALUE_NO);
			SetPlayerColorEx(playerid, 0xCCCCCC00);
			SavePlayerNickColor(playerid);
		}
	}
	return 1;
}

/*
 * |>------------------------<|
 * |   Input nickname color   |
 * |>------------------------<|
 */

DialogCreate:InputNicknameColor(playerid)
{
	Dialog_Open(playerid, Dialog:InputNicknameColor, DSI, "Изменение цвета ника",
	""CT_WHITE"Введите RGB цвет.\
	\nЦвета можно найти на сайте {eb901a}https://colorscheme.ru",
	"Изменить", "Выйти");
	return 1;
}

DialogResponse:InputNicknameColor(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:InputNicknameColor);
	}
	
	for (new i = strlen(inputtext) - 1; i != -1; i--) {
		switch (inputtext[i]) {
			case '0'..'9', 'a'..'z', 'A'..'Z': {
				continue;
			}
			default: {
				SCM(playerid, C_RED, "Ошибка: цвет должен содержать латинские символы и цифры!");
				Dialog_Show(playerid, Dialog:InputNicknameColor);
				return 1;
			}
		}
	}
	if (strlen(inputtext) < 1 || strlen(inputtext) > 6) {
		SCM(playerid, C_RED, "Ошибка: символов должно быть не меньше 1 и не больше 6!");
		Dialog_Show(playerid, Dialog:InputNicknameColor);
		return 1;	
	}	

	SetPlayerNicknameColor(playerid, inputtext);
	SetPlayerColorEx(playerid, HexToInt(HEXResultColor(pInfo[playerid][e_NickColor], 1)));
	SavePlayerNickColor(playerid);
	return 1;
}

/*
 * |>-------------<|
 * |     MySQL     |
 * |>-------------<|
 */

stock MySQLUploadPlayerPremium(playerid)
{
	cache_get_value_name_int(0, DB_ACCOUNTS_PREMIUM, pInfo[playerid][e_Premium]);
	cache_get_value_name(0, DB_ACCOUNTS_PREMIUM_DATETIME, pInfo[playerid][e_PremiumDatetime], MAX_LENGTH_DATETIME);
	cache_get_value_name(0, DB_ACCOUNTS_NICK_COLOR, pInfo[playerid][e_NickColor], MAX_LENGTH_COLOR_NICK);
	return 1;
}

stock SavePlayerPremium(playerid)
{
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_PREMIUM"` = '%i', `"DB_ACCOUNTS_PREMIUM_DATETIME"` = '%s', `"DB_ACCOUNTS_GOLD_COINS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerPremium(playerid), GetPlayerPremiumDatetime(playerid), GetPlayerGoldCoins(playerid), GetPlayerMySQLID(playerid));
	return 1;
}

stock SavePlayerNickColor(playerid)
{
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_NICK_COLOR"` = '%s' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerNicknameColor(playerid), GetPlayerMySQLID(playerid));
	return 1;
}

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>-------------<|
 * |   PC_OnInit   |
 * |>-------------<|
 */

stock Premium_PC_OnInit()
{
	AddPremiumCommands();
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerPremiumData(playerid);

	#if defined Premium_OnPlayerConnect
		return Premium_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>---------------------------<|
 * |   OnPlayerCommandReceived   |
 * |>---------------------------<|
 */

stock Premium_OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	#pragma unused cmd, params

	if (flags & CMD_FLAG_PREMIUM) {
		if ((flags & CMD_FLAG_PREMIUM_SILVER) && GetPlayerPremium(playerid) < PREMIUM_LEVEL_SILVER) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы не являетесь премиум аккаунтом "CT_GREEN"/donate");
			return 1;
		}
	}
	return 0;
}

/*
 * |>-------<|
 * |   ALS   |
 * |>-------<|
 */

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Premium_OnPlayerConnect
#if defined Premium_OnPlayerConnect
	forward Premium_OnPlayerConnect(playerid);
#endif