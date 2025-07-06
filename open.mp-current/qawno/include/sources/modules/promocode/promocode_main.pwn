/*
 * |>=========================<|
 * |   About: Promocode main   |
 * |   Author: Foxze           |
 * |>=========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)

	# Techical #
	- MySQLUploadPlayerPromoCode(playerid)
	- MySQLPromoCodesList(playerid)
	- MySQLCreatePromoCode(playerid, promocodeName[])
	- MySQLCheckPromoCode(playerid, promocodeName[])
	- MySQLCreatePromoCodeBackpack()
	- MySQLPromoCodeDelete(playerid, promocodeName[])
 * Stock:
	- SetPlayerPromoCode(playerid, const promocodeName[])
	- GetPlayerPromoCode(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_PROMOCODE_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- CreatePromoCode
	- DeletePromoCode
	- SelectOptionPromoCode
	- UsePlayerPromoCode
	- ListPromoCode
	- CreatePromoCodeGC
	- CreatePromoCodeMoney
	- CreatePromoCodeSelectDP
	- CreatePromoCodePeople
	- CreatePromoCodeDays
	- CreatePromoCodeName
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_PROMOCODE_MAIN
	#endinput
#endif
#define _INC_PROMOCODE_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_PROMOCODE_INFO {
	// MySQL
	e_PromoCode[MAX_LENGTH_PROMOCODE]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_PROMOCODE_INFO];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock SetPlayerPromoCode(playerid, const promocodeName[])
{
	strcopy(pInfo[playerid][e_PromoCode], promocodeName, MAX_LENGTH_PROMOCODE);
	mysql_escape_string(pInfo[playerid][e_PromoCode], pInfo[playerid][e_PromoCode], MAX_LENGTH_PROMOCODE);
	return 1;
}

stock GetPlayerPromoCode(playerid)
{
	new
		str[MAX_LENGTH_PROMOCODE];

	strcopy(str, pInfo[playerid][e_PromoCode], MAX_LENGTH_PROMOCODE);
	return str;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerPromoCodeData(playerid)
{
	pInfo[playerid][e_PromoCode][0] = EOS;
	mysql_escape_string(DB_STRING_VALUE_NO, pInfo[playerid][e_PromoCode], MAX_LENGTH_PROMOCODE);
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

/*
 * |>----------<|
 * |   Create   |
 * |>----------<|
 */

DialogCreate:CreatePromoCode(playerid)
{
	new
		promocodeName[MAX_LENGTH_PROMOCODE],
		promocodeDays = GetPVarInt(playerid, "PromoCodeDays"),
		promocodePeople = GetPVarInt(playerid, "PromoCodePeople"),
		promocodeMoney = GetPVarInt(playerid, "PromoCodeMoney"),
		promocodeGoldCoins = GetPVarInt(playerid, "PromoCodeGoldCoins");

	GetPVarString(playerid, "PromoCodeName", promocodeName, MAX_LENGTH_PROMOCODE);

	static
		str[136 + MAX_LENGTH_PROMOCODE + (MAX_LENGTH_NUM * 4) + 1];

	str[0] = EOS;

	f(str, "\
	"CT_WHITE"Создать промо-код "CT_YELLOW"%s\
	\n"CT_WHITE"Выдача денег: $%i\
	\nВыдача Gold coins: %i\
	\n\nПромо-код действует на %i дней или %i человек.",
	promocodeName, promocodeMoney, promocodeGoldCoins, promocodeDays, promocodePeople);

	Dialog_Open(playerid, Dialog:CreatePromoCode, DSM, "Создание промо-кода", str, "Создать", "Назад");
	return 1;
}

DialogResponse:CreatePromoCode(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "PromoCodeGoldCoins");
		Dialog_Show(playerid, Dialog:CreatePromoCodeGC);
		return 1;
	}

	new
		promocodeName[MAX_LENGTH_PROMOCODE],
		query[39 - 2 + DB_MAX_LENGTH_TABLE_NAME + DB_MAX_LENGTH_FIELD_NAME + MAX_LENGTH_PROMOCODE + 1];

	GetPVarString(playerid, "PromoCodeName", promocodeName, MAX_LENGTH_PROMOCODE);

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_PROMOCODES"` WHERE BINARY `"DB_PROMOCODES_CODE"` = '%s'", promocodeName);
	mysql_tquery(MySQLID, query, "MySQLCreatePromoCode", "is", playerid, promocodeName);
	return 1;
}

/*
 * |>----------<|
 * |   Delete   |
 * |>----------<|
 */

DialogCreate:DeletePromoCode(playerid)
{
	Dialog_Open(playerid, Dialog:DeletePromoCode, DSI, "Удаление промо-кода",
	""CT_WHITE"Введите название промо-кода:",
	"Далее", "Назад");
	return 1;
}

DialogResponse:DeletePromoCode(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:SelectOptionPromoCode);
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:DeletePromoCode);
		return 1;
	}

	new
		query[39 - 2 + DB_MAX_LENGTH_TABLE_NAME + DB_MAX_LENGTH_FIELD_NAME + MAX_LENGTH_PROMOCODE + 1];
	
	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_PROMOCODES"` WHERE BINARY `"DB_PROMOCODES_CODE"` = '%s'", inputtext);
	mysql_tquery(MySQLID, query, "MySQLPromoCodeDelete", "is", playerid, inputtext);
	return 1;
}

/*
 * |>----------<|
 * |   Option   |
 * |>----------<|
 */

DialogCreate:SelectOptionPromoCode(playerid)
{
	Dialog_Open(playerid, Dialog:SelectOptionPromoCode, DSL, "Промо-коды", "\
	"CT_ORANGE""T_NUM" "CT_WHITE"Список промо-кодов\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Создать промо-код\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Удалить промо-код",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:SelectOptionPromoCode(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:AdminServerOptions);
		return 1;
	}

	switch (listitem) {
		case 0: {
			new
				query[16 + DB_MAX_LENGTH_TABLE_NAME + 1];
			
			mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_PROMOCODES"`");
			mysql_tquery(MySQLID, query, "MySQLPromoCodesList", "i", playerid);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:CreatePromoCodeName);
		}
		case 2: {
			Dialog_Show(playerid, Dialog:DeletePromoCode);
		}
	}
	return 1;
}

/*
 * |>------------------------<|
 * |   Player use PromoCode   |
 * |>------------------------<|
 */

DialogCreate:UsePlayerPromoCode(playerid)
{
	Dialog_Open(playerid, Dialog:UsePlayerPromoCode, DSI, "Активировать промо-код",
	""CT_WHITE"Активируйте промо-код:",
	"Ввод", "Выход");
	return 1;
}

DialogResponse:UsePlayerPromoCode(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:UsePlayerPromoCode);
		return 1;
	}

	new
		query[39 - 2 + DB_MAX_LENGTH_TABLE_NAME + DB_MAX_LENGTH_FIELD_NAME + MAX_LENGTH_PROMOCODE + 1];
	
	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_PROMOCODES"` WHERE BINARY `"DB_PROMOCODES_CODE"` = '%s'", inputtext);
	mysql_tquery(MySQLID, query, "MySQLCheckPromoCode", "is", playerid, inputtext);
	return 1;
}

/*
 * |>--------<|
 * |   List   |
 * |>--------<|
 */

DialogCreate:ListPromoCode(playerid)
{
	static
		str[2000];

	str[0] = EOS;

	GetPVarString(playerid, "PromoCodesList", str, sizeof(str));
	DeletePVar(playerid, "PromoCodesList");

	Dialog_Open(playerid, Dialog:ListPromoCode, DSL, "Список промо-кодов", str, "Назад", "");
	return 1;
}

DialogResponse:ListPromoCode(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:SelectOptionPromoCode);
	return 1;
}

/*
 * |>---------------------<|
 * |   Create: GoldCoins   |
 * |>---------------------<|
 */

DialogCreate:CreatePromoCodeGC(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoCodeGC, DSI, "Создание промо-кода",
	""CT_WHITE"Введите кол-во gold coins, которое будет выдано при вводе промо-кода:\
	\nИспользуйте до 30 Gold coins",
	"Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoCodeGC(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "PromoCodeMoney");
		Dialog_Show(playerid, Dialog:CreatePromoCodeMoney);
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:CreatePromoCodeGC);
		return 1;
	}

	if (strval(inputtext) < 1 || strval(inputtext) > 30) {
		Dialog_Show(playerid, Dialog:CreatePromoCodeGC);
		return 1;
	}

	SetPVarInt(playerid, "PromoCodeGoldCoins", strval(inputtext));
	Dialog_Show(playerid, Dialog:CreatePromoCode);
	return 1;
}

/*
 * |>-----------------<|
 * |   Create: money   |
 * |>-----------------<|
 */

DialogCreate:CreatePromoCodeMoney(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoCodeMoney, DSI, "Создание промо-кода", 
	""CT_WHITE"Введите кол-во денег, которое будет выдано при вводе промо-кода:\
	\nИспользуйте до $100.000",
	"Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoCodeMoney(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "PromoCodePeople");
		DeletePVar(playerid, "PromoCodeDays");

		Dialog_Show(playerid, Dialog:CreatePromoCodeSelectDP);
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:CreatePromoCodeMoney);
		return 1;
	}

	if (strval(inputtext) < 1 || strval(inputtext) > 100000) {
		Dialog_Show(playerid, Dialog:CreatePromoCodeMoney);
		return 1;
	}

	SetPVarInt(playerid, "PromoCodeMoney", strval(inputtext));
	Dialog_Show(playerid, Dialog:CreatePromoCodeGC);
	return 1;
}

/*
 * |>---------------------------------<|
 * |   Create: select days or people   |
 * |>---------------------------------<|
 */

DialogCreate:CreatePromoCodeSelectDP(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoCodeSelectDP, DSL, "Создание промо-кода",
	""CT_ORANGE""T_NUM" "CT_WHITE"Кол-во дней\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Кол-во людей",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:CreatePromoCodeSelectDP(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "PromoCodeName");
		Dialog_Show(playerid, Dialog:CreatePromoCodeName);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:CreatePromoCodePeople);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:CreatePromoCodeDays);
		}
	}
	return 1;
}

/*
 * |>------------------<|
 * |   Create: people   |
 * |>------------------<|
 */

DialogCreate:CreatePromoCodePeople(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoCodePeople, DSI, "Создание промо-кода",
	""CT_WHITE"На какое кол-во дней создать промо-код?\
	\nИспользуйте от 1 до 7 дней",
	"Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoCodePeople(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "PromoCodePeople");
		DeletePVar(playerid, "PromoCodeDays");
		Dialog_Show(playerid, Dialog:CreatePromoCodeSelectDP);
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:CreatePromoCodePeople);
		return 1;
	}

	if (strval(inputtext) < 1 || strval(inputtext) > 7) {
		Dialog_Show(playerid, Dialog:CreatePromoCodePeople);
		return 1;
	}

	SetPVarInt(playerid, "PromoCodeDays", strval(inputtext));
	SetPVarInt(playerid, "PromoCodePeople", 0);

	Dialog_Show(playerid, Dialog:CreatePromoCodeMoney);
	return 1;
}

/*
 * |>----------------<|
 * |   Create: days   |
 * |>----------------<|
 */

DialogCreate:CreatePromoCodeDays(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoCodeDays, DSI, "Создание промо-кода",
	""CT_WHITE"На сколько человек создать промо-код?\
	\nИспользуйте от 1 до 500",
	"Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoCodeDays(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "PromoCodePeople");
		DeletePVar(playerid, "PromoCodeDays");
		Dialog_Show(playerid, Dialog:CreatePromoCodeSelectDP);
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:CreatePromoCodeDays);
		return 1;
	}

	if (strval(inputtext) < 1 || strval(inputtext) > 500) {
		Dialog_Show(playerid, Dialog:CreatePromoCodeDays);
		return 1;
	}

	SetPVarInt(playerid, "PromoCodePeople", strval(inputtext));
	SetPVarInt(playerid, "PromoCodeDays", -1);

	Dialog_Show(playerid, Dialog:CreatePromoCodeMoney);
	return 1;
}

/*
 * |>----------------<|
 * |   Create: name   |
 * |>----------------<|
 */

DialogCreate:CreatePromoCodeName(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoCodeName, DSI, "Создание промо-кода",
	""CT_WHITE"Введите название промо-кода:\
	\nИспользуйте от 3 до 16 символов\
	\n\n"CT_GREY"Пример: #"SERVER_NAME"",
	"Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoCodeName(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:SelectOptionPromoCode);
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:CreatePromoCodeName);
		return 1;
	}

	if (strlen(inputtext) < 3 || strlen(inputtext) > MAX_LENGTH_PROMOCODE) {
		Dialog_Show(playerid, Dialog:CreatePromoCodeName);
		return 1;
	}

	SetPVarString(playerid, "PromoCodeName", inputtext);
	Dialog_Show(playerid, Dialog:CreatePromoCodeSelectDP);
	return 1;
}

/*
 * |>-------------<|
 * |     MySQL     |
 * |>-------------<|
 */

/*
 * |>----------------------<|
 * |   Upload player data   |
 * |>----------------------<|
 */

stock MySQLUploadPlayerPromoCode(playerid)
{
	cache_get_value_name(0, DB_ACCOUNTS_PROMO_CODE, pInfo[playerid][e_PromoCode], MAX_LENGTH_PROMOCODE);
	return 1;
}

/*
 * |>-------------------<|
 * |   PromoCodes list   |
 * |>-------------------<|
 */

public: MySQLPromoCodesList(playerid)
{
	if (!cache_num_rows()) {
		SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Список промо-кодов отсутствует.");
		return 1;
	}

	static
		str[2000];

	str[0] = EOS;

	n_for(i, cache_num_rows()) {
		new
			promocodeMoney, promocodeGoldCoins, promocodeClick, promocodeName[MAX_LENGTH_PROMOCODE];

		cache_get_value_name(i, DB_PROMOCODES_CODE, promocodeName, MAX_LENGTH_PROMOCODE);
		cache_get_value_name_int(i, DB_PROMOCODES_MONEY, promocodeMoney);
		cache_get_value_name_int(i, DB_PROMOCODES_DONATE, promocodeGoldCoins);
		cache_get_value_name_int(i, DB_PROMOCODES_CLICK, promocodeClick);

		f(str, "\
		%s"CT_ORANGE""T_NUM"%i. "CT_WHITE"Название: %s \
		| Денег: +%i \
		| Gold Coins: +%i \
		| Кликов: %i\n",
		str, i + 1, promocodeName, promocodeMoney, promocodeGoldCoins, promocodeClick);
	}

	SetPVarString(playerid, "PromoCodesList", str);
	Dialog_Show(playerid, Dialog:ListPromoCode);
	return 1;
}

/*
 * |>----------<|
 * |   Create   |
 * |>----------<|
 */

public: MySQLCreatePromoCode(playerid, promocodeName[])
{
	if (cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный промо-код уже существует!");
		return 1;
	}

	new
		promocodeDays = GetPVarInt(playerid, "PromoCodeDays"),
		promocodePeople = GetPVarInt(playerid, "PromoCodePeople"),
		promocodeMoney = GetPVarInt(playerid, "PromoCodeMoney"),
		promocodeGoldCoins = GetPVarInt(playerid, "PromoCodeGoldCoins"),
		promocodeClick = GetPVarInt(playerid, "PromoCodeClick");

	static const
		queryFormat[] = "\
		INSERT INTO `"DB_PROMOCODES"` \
		(`"DB_PROMOCODES_CODE"`, `"DB_PROMOCODES_MONEY"`, `"DB_PROMOCODES_DONATE"`, `"DB_PROMOCODES_CLICK"`, \
		`"DB_PROMOCODES_DAYS"`, `"DB_PROMOCODES_PEOPLE"`, `"DB_PROMOCODES_DATETIME"`) \
		VALUES ('%s', '%i', '%i', '%i', '%i', '%i', '%s'";

	new
		query[sizeof(queryFormat) - 14 + MAX_LENGTH_PROMOCODE + (MAX_LENGTH_NUM * 5) + MAX_LENGTH_DATETIME];

	mysql_format(MySQLID, query, sizeof(query), queryFormat,
	promocodeName, promocodeMoney, promocodeGoldCoins,
	promocodeClick, promocodeDays, promocodePeople, AddToDatetime(GetCurrentDatetime(), .days = promocodeDays));

	mysql_tquery(MySQLID, query, "MySQLCreatePromoCodeBackpack");

	new
		str[151 - 10 + MAX_LENGTH_PROMOCODE + (MAX_LENGTH_NUM * 4) + 1];

	f(str, "\
	"CT_WHITE"Промо-код "CT_YELLOW"%s "CT_WHITE"успешно создан\
	\n"CT_WHITE"Выдача денег: %i$\
	\nВыдача Gold coins: %i\
	\n\nПромо-код действует на %i дней или %i человек.",
	promocodeName, promocodeMoney, promocodeGoldCoins, promocodeDays, promocodePeople);
	Dialog_Message(playerid, "Промо-код", str, "Хорошо");

	DeletePVar(playerid, "PromoCodeName");
	DeletePVar(playerid, "PromoCodeDays");
	DeletePVar(playerid, "PromoCodePeople");
	DeletePVar(playerid, "PromoCodeMoney");
	DeletePVar(playerid, "PromoCodeGoldCoins");
	DeletePVar(playerid, "PromoCodeClick");
	return 1;
}

/*
 * |>-----------------<|
 * |   Back IP MySQL   |
 * |>-----------------<|
 */

public: MySQLCreatePromoCodeBackpack()
{
	cache_insert_id();
	return 1;
}

/*
 * |>----------<|
 * |   Delete   |
 * |>----------<|
 */

public: MySQLPromoCodeDelete(playerid, promocodeName[])
{
	if (!cache_num_rows()) {
		Dialog_Show(playerid, Dialog:DeletePromoCode);
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данного промо-кода не существует!");
		return 1;
	}

	SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Промо-код успешно удалён");
	SQL("DELETE FROM `"DB_PROMOCODES"` WHERE BINARY `"DB_PROMOCODES_CODE"` = '%s'", promocodeName);
	return 1;
}

/*
 * |>---------<|
 * |   Check   |
 * |>---------<|
 */

public: MySQLCheckPromoCode(playerid, promocodeName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данного промо-кода не существует!");
		Dialog_Show(playerid, Dialog:UsePlayerPromoCode);
		return 1;
	}

	new
		promocodeMoney, promocodeGoldCoins, promocodeClick, 
		promocodeDays, promocodePeople, promocodeDatetime[MAX_LENGTH_DATETIME];

	cache_get_value_name_int(0, DB_PROMOCODES_MONEY, promocodeMoney);
	cache_get_value_name_int(0, DB_PROMOCODES_DONATE, promocodeGoldCoins);
	cache_get_value_name_int(0, DB_PROMOCODES_CLICK, promocodeClick);
	cache_get_value_name_int(0, DB_PROMOCODES_DAYS, promocodeDays);
	cache_get_value_name_int(0, DB_PROMOCODES_PEOPLE, promocodePeople);
	cache_get_value_name(0, DB_PROMOCODES_DATETIME, promocodeDatetime, MAX_LENGTH_DATETIME);

	if (promocodeDays != -1) {
		if (IsDatetimeExpired(promocodeDatetime)) {
			SQL("DELETE FROM `"DB_PROMOCODES"` WHERE BINARY `"DB_PROMOCODES_CODE"` = '%s'", promocodeName);

			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данного промо-кода не существует!");
			Dialog_Show(playerid, Dialog:UsePlayerPromoCode);
			return 1;
		}
	}

	SCM(playerid, C_GREEN, "");
	SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Промо-код успешно активирован!");
	SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Получено денег: "CT_GREEN"+$%i "CT_WHITE"и gold coins: "CT_ORANGE"+%i", promocodeMoney, promocodeGoldCoins);

	SetPlayerPromoCode(playerid, promocodeName);

	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_PROMO_CODE"` = '%s' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerPromoCode(playerid), GetPlayerMySQLID(playerid));
	SQL("UPDATE `"DB_PROMOCODES"` SET `"DB_PROMOCODES_PEOPLE"` = '%i', `"DB_PROMOCODES_CLICK"` = '%i' WHERE BINARY `"DB_PROMOCODES_CODE"` = '%s'", promocodePeople, promocodeClick + 1, promocodeName);

	if (promocodePeople > 0) {
		promocodePeople--;

		if (promocodePeople == 0
		&& promocodeDays == -1) {
			SQL("DELETE FROM `"DB_PROMOCODES"` WHERE BINARY `"DB_PROMOCODES_CODE"`= '%s'", promocodeName);
		}
	}
	return 1;
}

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerPromoCodeData(playerid);

	#if defined PromoCode_OnPlayerConnect
		return PromoCode_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
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
#define OnPlayerConnect PromoCode_OnPlayerConnect
#if defined PromoCode_OnPlayerConnect
	forward PromoCode_OnPlayerConnect(playerid);
#endif