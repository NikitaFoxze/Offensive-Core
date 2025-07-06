/*
 * |>===============================<|
 * |   About: Second-password main   |
 * |   Author: Foxze                 |
 * |>===============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)
 * Stock:
	- SetPlayerSecondPassword(playerid, const password[])
	- GetPlayerSecondPassword(playerid)
	- UpdatePlayerSecPassTimer(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_SEC_PASSWORD_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- SecondPassword
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- SecondPassword
 */

#if defined _INC_SECOND_PASSWORD_MAIN
	#endinput
#endif
#define _INC_SECOND_PASSWORD_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_SEC_PASSWORD_INFO {
	// MySQL
	e_SecondPassword[MAX_LENGTH_SEC_PASSWORD]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_SEC_PASSWORD_INFO];

static
	PlayerText:TD_SecPass[MAX_PLAYERS][SEC_PASSWORD_TD_INPUT];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>-------------------<|
 * |   Second Password   |
 * |>-------------------<|
 */

stock SetPlayerSecondPassword(playerid, const password[])
{
	strcopy(pInfo[playerid][e_SecondPassword], password, MAX_LENGTH_SEC_PASSWORD);
	mysql_escape_string(password, pInfo[playerid][e_SecondPassword], MAX_LENGTH_SEC_PASSWORD);
	return 1;
}

stock GetPlayerSecondPassword(playerid)
{
	new
		str[MAX_LENGTH_SEC_PASSWORD];

	strcopy(str, pInfo[playerid][e_SecondPassword], MAX_LENGTH_SEC_PASSWORD);
	return str;
}

/*
 * |>----------<|
 * |   Update   |
 * |>----------<|
 */

stock UpdatePlayerSecPassTimer(playerid)
{
	if (!Interface_IsOpen(playerid, Interface:SecondPassword)) {
		return 1;
	}

	SetPVarInt(playerid, "SecondPasswordTimer", GetPVarInt(playerid, "SecondPasswordTimer") - 1);

	if (GetPVarInt(playerid, "SecondPasswordTimer") < 1) {
		SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Время для второго пароля закончилось.");
		KickPlayerEx(playerid);
	}
	else {
		PlayerTextDrawSetString(playerid, TD_SecPass[playerid][34], "Таймер:_00:%02d", GetPVarInt(playerid, "SecondPasswordTimer"));
	}
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerSecPassData(playerid)
{
	strcopy(pInfo[playerid][e_SecondPassword], DB_STRING_VALUE_NO, MAX_LENGTH_SEC_PASSWORD);
	mysql_escape_string(pInfo[playerid][e_SecondPassword], pInfo[playerid][e_SecondPassword], MAX_LENGTH_SEC_PASSWORD);
	return 1;
}

static ResetPlayerSecPassTDs(playerid)
{
	n_for(i, SEC_PASSWORD_TD_INPUT) {
		TD_SecPass[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	return 1;
}

/*
 * |>------------------<|
 * |     Interfaces     |
 * |>------------------<|
 */

/*
 * |>------------------------<|
 * |   Show second password   |
 * |>------------------------<|
 */

InterfaceCreate:SecondPassword(playerid)
{
	SetPlayerClickTD(playerid, true);

	SetPVarInt(playerid, "SecondPasswordTimer", 30);
	SetPVarString(playerid, "SecondPasswordString", "");

	CreatePlayerSecPassInputTD(playerid, TD_SecPass[playerid]);

	n_for(i, SEC_PASSWORD_TD_INPUT) {
		PlayerTextDrawShow(playerid, TD_SecPass[playerid][i]);
	}

	SelectTextDraw(playerid, TD_C_GREY);
	return 1;
}

InterfaceClose:SecondPassword(playerid)
{
	SetPlayerClickTD(playerid, false);

	DeletePVar(playerid, "SecondPasswordTimer");
	DeletePVar(playerid, "SecondPasswordString");

	n_for(i, SEC_PASSWORD_TD_INPUT) {
		DestroyPlayerTD(playerid, TD_SecPass[playerid][i]);
	}

	CancelSelectTextDraw(playerid);
	return 1;
}

InterfacePlayerClick:SecondPassword(playerid, PlayerText:playertextid)
{
	new
		string[MAX_LENGTH_SEC_PASSWORD];

	GetPVarString(playerid, "SecondPasswordString", string, MAX_LENGTH_SEC_PASSWORD);

	if (!GetPlayerLogged(playerid)) {
		if (playertextid == TD_SecPass[playerid][36]) {
			if (!strlen(string)) {
				return 1;
			}

			if (strlen(string) < 3) {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Меньше 3 цифр запрещено.");
				return 1;
			}

			SetPlayerSecondPassword(playerid, string);

			SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_SEC_PASS"` = '%s' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerSecondPassword(playerid), GetPlayerMySQLID(playerid));

			SCM(playerid, C_GREEN, ""T_PASS" "CT_WHITE"Второй пароль успешно создан!");
			Interface_Close(playerid, Interface:SecondPassword);
			Interface_Show(playerid, Interface:MainMenu);
			return 1;
		}
		else if (playertextid == TD_SecPass[playerid][31]) {
			strdel(string, strlen(string) - 1, strlen(string));
			SetPVarString(playerid, "SecondPasswordString", string);
			PlayerTextDrawSetString(playerid, TD_SecPass[playerid][38], string);
			return 1;
		}
		if (strlen(string) > 5) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Больше 6 цифр запрещено.");
			return 1;
		}

		else if (playertextid == TD_SecPass[playerid][12]) strcat(string, "1");
		else if (playertextid == TD_SecPass[playerid][13]) strcat(string, "2");
		else if (playertextid == TD_SecPass[playerid][14]) strcat(string, "3");
		else if (playertextid == TD_SecPass[playerid][15]) strcat(string, "4");
		else if (playertextid == TD_SecPass[playerid][16]) strcat(string, "5");
		else if (playertextid == TD_SecPass[playerid][17]) strcat(string, "6");
		else if (playertextid == TD_SecPass[playerid][18]) strcat(string, "7");
		else if (playertextid == TD_SecPass[playerid][19]) strcat(string, "8");
		else if (playertextid == TD_SecPass[playerid][20]) strcat(string, "9");

		SetPVarString(playerid, "SecondPasswordString", string);
		PlayerTextDrawSetString(playerid, TD_SecPass[playerid][38], string);
		return 1;
	}
	else {
		if (playertextid == TD_SecPass[playerid][36]) {
			if (!strlen(string)) {
				return 1;
			}
			
			if (strcmp(string, GetPlayerSecondPassword(playerid))) {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Неправильный пароль!");
				return 1;
			}

			KillPlayerLoggedTimer(playerid);
			Interface_Close(playerid, Interface:SecondPassword);

			SCM(playerid, C_GREEN, ""T_PASS" "CT_WHITE"Второй пароль успешно введён!");

			// Administrator
			CheckMySQLPlayerForAdmin(playerid);
			return 1;
		}
		else if (playertextid == TD_SecPass[playerid][31]) {
			strdel(string, strlen(string) - 1, strlen(string));
			SetPVarString(playerid, "SecondPasswordString", string);
			PlayerTextDrawSetString(playerid, TD_SecPass[playerid][38], string);
			return 1;
		}
		if (strlen(string) > 5) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Больше 6 цифр запрещено.");
			return 1;
		}

		else if (playertextid == TD_SecPass[playerid][12]) strcat(string, "1");
		else if (playertextid == TD_SecPass[playerid][13]) strcat(string, "2");
		else if (playertextid == TD_SecPass[playerid][14]) strcat(string, "3");
		else if (playertextid == TD_SecPass[playerid][15]) strcat(string, "4");
		else if (playertextid == TD_SecPass[playerid][16]) strcat(string, "5");
		else if (playertextid == TD_SecPass[playerid][17]) strcat(string, "6");
		else if (playertextid == TD_SecPass[playerid][18]) strcat(string, "7");
		else if (playertextid == TD_SecPass[playerid][19]) strcat(string, "8");
		else if (playertextid == TD_SecPass[playerid][20]) strcat(string, "9");

		SetPVarString(playerid, "SecondPasswordString", string);
		PlayerTextDrawSetString(playerid, TD_SecPass[playerid][38], string);
	}
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

DialogCreate:SecondPassword(playerid)
{
	if (!strcmp(GetPlayerSecondPassword(playerid), DB_STRING_VALUE_NO, true)) {
		Dialog_Open(playerid, Dialog:SecondPassword, DSL, "Второй пароль", "\
		"CT_ORANGE""T_NUM" "CT_WHITE"Создать\
		\n"CT_ORANGE""T_NUM" "CT_WHITE"Удалить", "Выбрать", "Выход");
	}
	else {
		Dialog_Open(playerid, Dialog:SecondPassword, DSL, "Второй пароль", "\
		"CT_ORANGE""T_NUM" "CT_WHITE"Поменять\
		\n"CT_ORANGE""T_NUM" "CT_WHITE"Удалить", "Выбрать", "Выход");
	}
	return 1;
}

DialogResponse:SecondPassword(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
		return 1;
	}

	switch (listitem) {
		case 0: {
			if (Mode_GetPlayerMode(playerid) != MODE_NONE 
			|| Interface_IsOpen(playerid, Interface:SecondPassword)) {

				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данную функцию можно изменить только в главном меню.");
				Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
				return 1;
			}
			Interface_Close(playerid, Interface:MainMenu);
			Interface_Show(playerid, Interface:SecondPassword);
		}
		case 1: {
			if (!strcmp(GetPlayerSecondPassword(playerid), DB_STRING_VALUE_NO, true)) {
				SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"У вас нет второго пароля.");
				Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
				return 1;
			}
			if (Mode_GetPlayerMode(playerid) != MODE_NONE
			|| Interface_IsOpen(playerid, Interface:SecondPassword)) {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данную функцию можно изменить только в главном меню.");
				Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
				return 1;
			}

			SetPlayerSecondPassword(playerid, DB_STRING_VALUE_NO);

			SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_SEC_PASS"` = '%s' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerSecondPassword(playerid), GetPlayerMySQLID(playerid));

			SCM(playerid, C_GREEN, ""T_PASS" "CT_WHITE"Второй пароль успешно удалён!");
			Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
		}
	}
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

stock MySQLUploadPlayerSecPassword(playerid)
{
	cache_get_value_name(0, DB_ACCOUNTS_SEC_PASS, pInfo[playerid][e_SecondPassword], MAX_LENGTH_SEC_PASSWORD);
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
	ResetPlayerSecPassData(playerid);
	ResetPlayerSecPassTDs(playerid);

	#if defined SecPass_OnPlayerConnect
		return SecPass_OnPlayerConnect(playerid);
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
#define OnPlayerConnect SecPass_OnPlayerConnect
#if defined SecPass_OnPlayerConnect
	forward SecPass_OnPlayerConnect(playerid);
#endif