/*
 * |>===========================<|
 * |   About: Daily-bonus main   |
 * |   Author: Foxze             |
 * |>===========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)
 * Stock:
	- GivePlayerDailyBonusDays(playerid, days)
	- GetPlayerDailyBonusDays(playerid)
	- SetPlayerDailyBonusDatetime(playerid, const stringDatetime[])
	- GetPlayerDailyBonusDatetime(playerid)
	- CheckPlayerDailyBonus(playerid)

	- MySQLUploadPlayerDailyBonus(playerid)
	- SavePlayerDailyBonus(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_DAILY_BONUS_INFO
	- E_DAILY_BONUS_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- DailyBonus
 */

#if defined _INC_DAILY_BONUS_MAIN
	#endinput
#endif
#define _INC_DAILY_BONUS_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_DAILY_BONUS_INFO {
	// MySQL
	e_Days,
	e_Datetime[MAX_LENGTH_DATETIME],
}

enum E_DAILY_BONUS_INFO {
	e_Exp,
	e_Money,
    e_GoldCoins
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_DAILY_BONUS_INFO];

static
	PlayerText:TD_DailyBonus[MAX_PLAYERS][11];

static const
	dbInfo[MAX_PLAYER_DAILY_DAYS][E_DAILY_BONUS_INFO] = {
		// Exp, Money, Gold coins

		/* 0 */ {300, 150, 5},
		/* 1 */ {400, 300, 7},
		/* 2 */ {500, 350, 10},
		/* 3 */ {700, 400, 13},
		/* 4 */ {1000, 500, 17},
		/* 5 */ {2000, 1000, 20},
		/* 6 */ {2600, 1500, 25},
		/* 7 */ {3000, 2000, 30},
		/* 8 */ {4000, 3500, 35},
		/* 9 */ {6000, 4100, 40}
};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>--------------------<|
 * |   Daily bonus days   |
 * |>--------------------<|
 */

stock GivePlayerDailyBonusDays(playerid, days)
{
	pInfo[playerid][e_Days] += days;
	return 1;
}

stock GetPlayerDailyBonusDays(playerid)
{
	return pInfo[playerid][e_Days];
}

/*
 * |>------------------------<|
 * |   Daily bonus datetime   |
 * |>------------------------<|
 */

stock SetPlayerDailyBonusDatetime(playerid, const stringDatetime[])
{
	strcopy(pInfo[playerid][e_Datetime], stringDatetime, MAX_LENGTH_DATETIME);
	return 1;
}

stock GetPlayerDailyBonusDatetime(playerid)
{
	new
		str[MAX_LENGTH_DATETIME];

	strcopy(str, pInfo[playerid][e_Datetime], MAX_LENGTH_DATETIME);
	return str;
}

/*
 * |>--------------------------<|
 * |   Check player for bonus   |
 * |>--------------------------<|
 */

stock CheckPlayerDailyBonus(playerid)
{
	if (GetPlayerDailyBonusDays(playerid) < MAX_PLAYER_DAILY_DAYS) {
		if(IsDatetimeExpired(GetPlayerDailyBonusDatetime(playerid))) {
			Interface_Show(playerid, Interface:DailyBonus);
			return 1;
		}
	}
	return 0;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerDailyBonusData(playerid)
{
	pInfo[playerid][e_Days]			= 0;
	pInfo[playerid][e_Datetime][0]	= EOS;
	return 1;
}

static ResetPlayerDailyBonusTDs(playerid)
{
	n_for(i, DAILY_BONUS_TD_REWARD) {
		TD_DailyBonus[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	return 1;
}

/*
 * |>------------------<|
 * |     Interfaces     |
 * |>------------------<|
 */

/*
 * |>--------------------<|
 * |   Show daily bonus   |
 * |>--------------------<|
 */

InterfaceCreate:DailyBonus(playerid)
{
	new
		day = GetPlayerDailyBonusDays(playerid),
		dayIndex = GetPlayerDailyBonusDays(playerid) - 1;

	CreatePlayerDailyBonusRewardTD(playerid, TD_DailyBonus[playerid]);

	PlayerTextDrawSetString(playerid, TD_DailyBonus[playerid][7], "День:_%i", day);
	PlayerTextDrawSetString(playerid, TD_DailyBonus[playerid][8], "+%i EXP", dbInfo[dayIndex][e_Exp]);
	PlayerTextDrawSetString(playerid, TD_DailyBonus[playerid][9], "+$%i", dbInfo[dayIndex][e_Money]);
	PlayerTextDrawSetString(playerid, TD_DailyBonus[playerid][10], "+%i Gold coins", dbInfo[dayIndex][e_GoldCoins]);

	n_for(i, DAILY_BONUS_TD_REWARD) {
		PlayerTextDrawShow(playerid, TD_DailyBonus[playerid][i]);
	}

	SelectTextDraw(playerid, TD_C_GREY);
	return 1;
}

InterfaceClose:DailyBonus(playerid)
{
	n_for(i, DAILY_BONUS_TD_REWARD) {
		DestroyPlayerTD(playerid, TD_DailyBonus[playerid][i]);
	}
	return 1;
}

InterfacePlayerClick:DailyBonus(playerid, PlayerText:playertextid)
{
	if (playertextid == TD_DailyBonus[playerid][4]) {
		new
			dayIndex = GetPlayerDailyBonusDays(playerid) - 1;

		GivePlayerExp(playerid, dbInfo[dayIndex][e_Exp]);
		GivePlayerMoneyEx(playerid, dbInfo[dayIndex][e_Money]);
		GivePlayerGoldCoins(playerid, dbInfo[dayIndex][e_GoldCoins]);

		GivePlayerDailyBonusDays(playerid, 1);
		SetPlayerDailyBonusDatetime(playerid, AddToDatetime(GetCurrentDatetime(), .days = 1));

		SavePlayerDailyBonus(playerid);

		Interface_Close(playerid, Interface:DailyBonus);

		EnterPlayerMainMenu(playerid);
	}
	return 1;
}

/*
 * |>-------------<|
 * |     MySQL     |
 * |>-------------<|
 */

stock MySQLUploadPlayerDailyBonus(playerid)
{
	cache_get_value_name_int(0, DB_ACCOUNTS_DBONUS_DAYS, pInfo[playerid][e_Days]);
	cache_get_value_name(0, DB_ACCOUNTS_DBONUS_DATETIME, pInfo[playerid][e_Datetime], MAX_LENGTH_DATETIME);
	return 1;
}

stock SavePlayerDailyBonus(playerid)
{
	SQL("\
	UPDATE `"DB_ACCOUNTS"` \
	SET \
	`"DB_ACCOUNTS_DBONUS_DAYS"` = '%i', \
	`"DB_ACCOUNTS_DBONUS_DATETIME"` = '%s', \
	`"DB_ACCOUNTS_EXP"` = '%i', \
	`"DB_ACCOUNTS_MONEY"` = '%i', \
	`"DB_ACCOUNTS_GOLD_COINS"` = '%i' \
	WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerDailyBonusDays(playerid), GetPlayerDailyBonusDatetime(playerid), GetPlayerExp(playerid), GetPlayerMoneyEx(playerid), GetPlayerGoldCoins(playerid), GetPlayerMySQLID(playerid));
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
	ResetPlayerDailyBonusData(playerid);
	ResetPlayerDailyBonusTDs(playerid);

	#if defined DailyB_OnPlayerConnect
		return DailyB_OnPlayerConnect(playerid);
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
#define OnPlayerConnect DailyB_OnPlayerConnect
#if defined DailyB_OnPlayerConnect
	forward DailyB_OnPlayerConnect(playerid);
#endif