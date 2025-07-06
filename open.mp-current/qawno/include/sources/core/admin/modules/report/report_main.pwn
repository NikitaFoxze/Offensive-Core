/*
 * |>======================<|
 * |   About: Report main   |
 * |   Author: Foxze        |
 * |>======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnPlayerConnect(playerid)
	- OnPlayerDisconnect(playerid, reason)
 * Stock:
	- UpdatePlayerReportData(playerid)
	- CloseReportDialogAnswer(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_REPORT_INFO
	- E_REPORT_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- report(playerid)
	- ot(playerid)
	- dreports(playerid)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- ReportSending
	- ReportAnswerEvalution
	- ReportAnswer
	- ReportAnswerFromAdmin
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_REPORT_MAIN
	#endinput
#endif
#define _INC_REPORT_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_REPORT_INFO {
	e_ID,
	e_EstimateAdmin,
	bool:e_Active,
	e_ReTimer
}

enum E_REPORT_INFO {
	e_ID,
	bool:e_Status,
	e_Text[MAX_LENGTH_REPORT_TEXT]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_REPORT_INFO],
	rInfo[MAX_REPORTS][E_REPORT_INFO];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock UpdatePlayerReportData(playerid)
{
	if (pInfo[playerid][e_ReTimer] > 0)
		pInfo[playerid][e_ReTimer]--;

	return 1;
}

static GetTotalReports()
{
	new
		number_reports = 0;

	n_for(i, MAX_REPORTS) {
		if (rInfo[i][e_ID] == INVALID_PLAYER_ID) {
			continue;
		}

		number_reports++;
	}
	return number_reports;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerReportData(playerid)
{
	pInfo[playerid][e_ID] =
	pInfo[playerid][e_EstimateAdmin] = INVALID_PLAYER_ID;

	pInfo[playerid][e_ReTimer] = 0;
	pInfo[playerid][e_Active] = false;
	return 1;
}

static ResetReportData(reportid)
{
	rInfo[reportid][e_ID] = INVALID_PLAYER_ID;
	rInfo[reportid][e_Status] = false;
	rInfo[reportid][e_Text][0] = EOS;
	return 1;
}

static ResetAllReportsData() {
	n_for(i, MAX_REPORTS)
		ResetReportData(i);

	foreach (Player, p) {
		if (!IsPlayerOnServer(p)) {
			continue;
		}

		if (GetPlayerLogged(p)) {
			continue;
		}

		pInfo[p][e_Active] = false;
	}
	return 1;
}

/*
 * |>----------------<|
 * |     Commands     |
 * |>----------------<|
 */

CMD:report(playerid)
{
	if (!Iter_Count(TotalAdmins)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Администрации нет в сети.");
		return 1;
	}

	if (pInfo[playerid][e_Active]) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы уже отправили одно сообщение администрации.");
		return 1;
	}

	Dialog_Show(playerid, Dialog:ReportSending);
	return 1;
}

CMD:ot(playerid)
{
	n_for(i, MAX_REPORTS) {
		if (rInfo[i][e_ID] != INVALID_PLAYER_ID) {
			if (rInfo[i][e_Status]) {
				continue;
			}

			Dialog_Show(playerid, Dialog:ReportAnswer);

			pInfo[playerid][e_ID] = i;
			rInfo[i][e_Status] = true;

			SCM(rInfo[i][e_ID], C_GREEN, ""T_REPORT" Администратор %s "T_PID" принялся за ваш репорт!", GetPlayerNameEx(playerid), playerid);
			return 1;
		}
	}

	SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Сейчас нет вопросов в репорт!");
	return 1;
}

CMD:dreports(playerid)
{
	ResetAllReportsData();
	SendAdminsMessage(C_CARMINE, "{cc1836}[A]: %s [%i] очистил все репорты!", GetPlayerNameEx(playerid), playerid);
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

/*
 * |>----------------------<|
 * |   Player send report   |
 * |>----------------------<|
 */

DialogCreate:ReportSending(playerid)
{
	if (pInfo[playerid][e_ReTimer] > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Писать в репорт можно раз в %i минут!", LIMIT_MINUTES_SEND_REPORT);
		return 1;
	}

	Dialog_Open(playerid, Dialog:ReportSending, DSI, "Репорт", "\
	"CT_WHITE"Вы собираетесь написать сообщение Администрации.\
	\n"CT_RED"Запрещено:\
	\n"CT_GREY"1. Флуд, оскорбления, оффтоп\
	\n"CT_GREY"2. Просьбы (Дайте денег, дайте админку, дайте..)\
	\n"CT_GREY"3. Ложные сообщения\
	\n\n"CT_RED"За нарушение правил администрация сервера может:\
	\n"CT_GREY"1. Предупредить (Warn)\
	\n"CT_GREY"2. Кикнуть с сервера (Kick)\
	\n"CT_GREY"3. Заблокировать аккаунт (Ban)\
	\n\n"CT_YELLOW"Помните!\
	\n"CT_GREY"Мы всегда готовы помочь если вы соблюдаете правила.\
	\n"CT_GREY"Данные правила установлены для всех игроков.\
	\n\n"CT_GREY"Если вам долго не отвечают, подождите пару минут\
	\n"CT_GREY"Прежде чем задавать вопрос в репорт, попробуйте найти решение с помощью /help\
	\n"CT_WHITE"Спасибо за понимание, с уважением Администрация "SERVER_NAME".\n\n",
	"Отправить", "Закрыть");
	return 1;
}

DialogResponse:ReportSending(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:ReportSending);
	}
	
	n_for(i, MAX_REPORTS) {
		if (rInfo[i][e_ID] == INVALID_PLAYER_ID) {
			rInfo[i][e_ID] = playerid;
			strmid(rInfo[i][e_Text], (inputtext), 0, strlen(inputtext), MAX_LENGTH_REPORT_TEXT);

			new
				adminid = pInfo[playerid][e_EstimateAdmin];

			SendAdminsMessage(C_CARMINE, ""CT_RED"(Жалоба) "CT_WHITE"От "CT_YELLOW"%s "T_PID": "CT_WHITE"%s. Уже %d жалоб!", GetPlayerNameEx(playerid), playerid, inputtext, GetTotalReports());

			GameTextForPlayer(adminid, "~y~ReportSending+", 3000, 1);

			SCM(playerid, C_GREY, ""T_REPORT" Вы отправили жалобу: %s", inputtext);
			SCM(playerid, C_GREY, ""T_REPORT" На ваш вопрос ответит администрация. Вы %d в очереди!", GetTotalReports());

			GameTextForPlayer(playerid, "~g~Successful", 2000, 1);
			pInfo[playerid][e_ReTimer] = LIMIT_MINUTES_SEND_REPORT;
			pInfo[playerid][e_Active] = true;
			break;
		}
	}
	return 1;
}

/*
 * |>------------------------<|
 * |   Player choose answer   |
 * |>------------------------<|
 */

DialogCreate:ReportAnswerEvalution(playerid)
{
	Dialog_Open(playerid, Dialog:ReportAnswerEvalution, DSL, "Оцените работу администратора!", 
	""CT_GREEN"Хороший ответ\
	\n"CT_RED"Плохой ответ",
	"Выбрать", "");
	return 1;
}

DialogResponse:ReportAnswerEvalution(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return Dialog_Show(playerid, Dialog:ReportAnswerEvalution);
	}

	new
		adminid = pInfo[playerid][e_EstimateAdmin],
		answer;

	switch (listitem) {
		case 0: {
			GiveAdminReputation(adminid, 1);
			answer++;
		}
		case 1: {
			GiveAdminReputation(adminid, -1);
			answer--;
		}
	}

	if (IsPlayerOnServer(adminid)) {
		SQL("UPDATE `"DB_ADMINS"` SET `"DB_ADMINS_REPUTATION"` = '%i' WHERE `"DB_ADMINS_ID"` = '%i'", GetAdminReputation(playerid), GetAdminMySQLID(playerid));

		if (answer > 0) {
			SCM(adminid, C_GREEN, ""T_REPORT" Игроку %s "T_PID" понравился ваш ответ", GetPlayerNameEx(playerid), playerid);
		}
		else {
			SCM(adminid, C_RED, ""T_REPORT" Игроку %s "T_PID" не понравился ваш ответ", GetPlayerNameEx(playerid), playerid);
		}
	}
	SCM(playerid, C_YELLOW, ""T_REPORT" "CT_WHITE"Спасибо за ваш отзыв!");
	pInfo[playerid][e_ID] = INVALID_PLAYER_ID;
	return 1;
}

/*
 * |>---------------------------------<|
 * |   Acceptance of report by admin   |
 * |>---------------------------------<|
 */

DialogCreate:ReportAnswer(playerid)
{
	new 
		str[250],
		reportid = pInfo[playerid][e_ID];

	f(str, ""CT_WHITE"Жалоба/Вопрос от "CT_YELLOW"%s "T_PID"\n\n"CT_GREY"%s\n", GetPlayerNameEx(rInfo[reportid][e_ID]), rInfo[reportid][e_ID], rInfo[reportid][e_Text]);

	Dialog_Open(playerid, Dialog:ReportAnswer, DSI, "Репорт", str, "Принять", "Отмена");
	return 1;
}

stock CloseReportDialogAnswer(playerid)
{
	if (pInfo[playerid][e_ID] == INVALID_PLAYER_ID) {
		return 1;
	}

	new
		reportid = pInfo[playerid][e_ID];

	rInfo[reportid][e_Status] = false;
	pInfo[playerid][e_ID] = INVALID_PLAYER_ID;

	if (IsPlayerOnServer(rInfo[reportid][e_ID])) {
		SCM(rInfo[reportid][e_ID], C_RED, ""T_REPORT" Администратор %s "T_PID" отказался отвечать на вашу жалобу. Ожидайте ответа!", GetPlayerNameEx(playerid), playerid);
	}
	return 1;
}

DialogResponse:ReportAnswer(playerid, response, listitem, inputtext[])
{
	new
		reportid = pInfo[playerid][e_ID];

	if (!response) {
		rInfo[reportid][e_Status] = false;
		pInfo[playerid][e_ID] = INVALID_PLAYER_ID;
		
		SCM(playerid, C_RED, ""T_REPORT" "CT_WHITE"Вы не ответили игроку! Ваша репутацию понижена!");
		SCM(rInfo[reportid][e_ID], C_RED, ""T_REPORT" Администратор %s "T_PID" отказался отвечать на вашу жалобу. Ожидайте ответа!", GetPlayerNameEx(playerid), playerid);

		GiveAdminReputation(playerid, -1);

		SQL("UPDATE `"DB_ADMINS"` SET `"DB_ADMINS_REPUTATION"` = '%i' WHERE `"DB_ADMINS_ID"` = '%i'", GetAdminReputation(playerid), GetAdminMySQLID(playerid));
		return 1;
	}

	if (!IsPlayerOnServer(rInfo[reportid][e_ID])) {
		ResetReportData(reportid);
		pInfo[playerid][e_ID] = INVALID_PLAYER_ID;

		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок вышел из игры.");
		return 1;
	}

	if (!strlen(inputtext) || strlen(inputtext) >= MAX_LENGTH_REPORT_TEXT) {
		Dialog_Show(playerid, Dialog:ReportAnswer);

		SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Много символов, или нет символов.");
		return 1;
	}

	SetPVarString(playerid, "PlayerReportText", rInfo[reportid][e_Text]);
	SetPVarString(playerid, "PlayerReportAnswer", inputtext);
	Dialog_Show(rInfo[reportid][e_ID], Dialog:ReportAnswerFromAdmin);

	SCM(rInfo[reportid][e_ID], C_GREY, ""T_REPORT" Администратор %s "T_PID": "CT_WHITE"%s", GetPlayerNameEx(playerid), playerid, inputtext);

	pInfo[rInfo[reportid][e_ID]][e_Active] = false;
	pInfo[rInfo[reportid][e_ID]][e_EstimateAdmin] = playerid;

	pInfo[playerid][e_ID] = INVALID_PLAYER_ID;
	ResetReportData(playerid);
	return 1;
}

/*
 * |>-----------------------------------<|
 * |   Admin report response to player   |
 * |>-----------------------------------<|
 */

DialogCreate:ReportAnswerFromAdmin(playerid)
{
	new
		str[100 + MAX_LENGTH_REPORT_TEXT + MAX_PLAYER_NAME + MAX_LENGTH_REPORT_TEXT],
		text_report[MAX_LENGTH_REPORT_TEXT],
		answer_report[MAX_LENGTH_REPORT_TEXT];

	GetPVarString(playerid, "PlayerReportText", text_report, sizeof(text_report));
	GetPVarString(playerid, "PlayerReportAnswer", answer_report, sizeof(answer_report));

	DeletePVar(playerid, "PlayerReportText");
	DeletePVar(playerid, "PlayerReportAnswer");

	f(str, ""CT_WHITE"Ответ от администратора!\
	\n\n"CT_WHITE"Ваш вопрос: "CT_GREY"%s\
	\n"CT_WHITE"%s: "CT_GREY"%s\n\n", text_report, GetPlayerNameEx(playerid), answer_report);

	Dialog_Open(playerid, Dialog:ReportAnswerFromAdmin, DSM, "Репорт", str, "Спасибо", "");
	return 1;
}

DialogResponse:ReportAnswerFromAdmin(playerid, response, listitem, inputtext[])
{
	new
		adminid = pInfo[playerid][e_EstimateAdmin];

	if (adminid == playerid) {
		return 1;
	}

	Dialog_Show(playerid, Dialog:ReportAnswerEvalution);
	return 1;
}

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>------------------<|
 * |   OnGameModeInit   |
 * |>------------------<|
 */

public OnGameModeInit()
{
	n_for(i, MAX_REPORTS)
		ResetReportData(i);

	#if defined Report_OnGameModeInit
		return Report_OnGameModeInit();
	#else
		return 1;
	#endif
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerReportData(playerid);

	#if defined Report_OnPlayerConnect
		return Report_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>----------------------<|
 * |   OnPlayerDisconnect   |
 * |>----------------------<|
 */

public OnPlayerDisconnect(playerid, reason)
{
	n_for(i, MAX_REPORTS) {
		if (rInfo[i][e_ID] == playerid)
			ResetReportData(i);
	}

	#if defined Report_OnPlayerDisconnect
		return Report_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}

/*
 * |>-------<|
 * |   ALS   |
 * |>-------<|
 */

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Report_OnGameModeInit
#if defined Report_OnGameModeInit
	forward Report_OnGameModeInit();
#endif


#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Report_OnPlayerConnect
#if defined Report_OnPlayerConnect
	forward Report_OnPlayerConnect(playerid);
#endif


#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect Report_OnPlayerDisconnect
#if defined Report_OnPlayerDisconnect
	forward Report_OnPlayerDisconnect(playerid, reason);
#endif