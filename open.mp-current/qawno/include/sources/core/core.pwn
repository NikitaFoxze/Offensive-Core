/*
 * |>===========================<|
 * |   About: Core server main   |
 * |   Author: Foxze             |
 * |>===========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnGameModeExit()

	# Technical #
	- CallUpdateServer()
	- CallUpdateServer2()
 * Stock:
	# MySQL #
	- FormatIntArrayToSQL(vars[], varsSize, output[], outputSize = sizeof(output))
	- FormatFloatArrayToSQL(Float:vars[], varsSize, output[], outputSize = sizeof(output))
	
	# Datetime #
	- bool:IsLeapYear(year)
	- GetDaysInMonth(month, year)
	- bool:IsDatetimeExpired(const stringDatetime[], &days = 0)
	- ConvertStringDatetime(const stringDatetime[], &year, &month, &day, &hours, &minutes, &seconds)
	- AddToDatetime(const stringDatetime[], years = 0, months = 0, days = 0, hours = 0, minutes = 0, seconds = 0)
	- GetCurrentDatetime()
	- ShowDatetimeForPlayer(playerid, const mysqlDatetime[])

	# Regex #
	- IsStringIP(const string[])
	- IsStringEmail(const string[])
	- IsStringNum(const string[])

	# Others #
	- GetRandomKey(num)
	- GetRandomKeyStr(num)
	- GetRandomColorText(num)
	- SetIndicatorHealth(num)
	- GetIndicatorHealth()
	- GetNamePointABC(num)
	- GetNameSquad(num)
	- GetPlayerID(const playerName[], playerid)
	- GetNameID(const playerName[])
	- GetString(const stringOne[], const stringTwo[]) 
	- IsCh(num)
	- IsOSymbol(const string[], const symbol, first, end)
	- IsODomen(const string[])
	- HexToInt(const string[])
	- LoadMapObjects()
	- HEXResultColor(const color[], type)
	- GeneratePassword(size)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_RANDOM_KEYS_INFO
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
	- (None)
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
	- (None)
 */

#if defined _INC_CORE_SERVER_MAIN
	#endinput
#endif
#define _INC_CORE_SERVER_MAIN

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Dialogue styles
#if !defined DSM
	#define DSM	DIALOG_STYLE_MSGBOX
#endif

#if !defined DSI
	#define DSI DIALOG_STYLE_INPUT
#endif

#if !defined DSL
	#define DSL DIALOG_STYLE_LIST
#endif

#if !defined DSP
	#define DSP DIALOG_STYLE_PASSWORD
#endif

#if !defined DST
	#define DST DIALOG_STYLE_TABLIST
#endif

#if !defined DSTH
	#define DSTH DIALOG_STYLE_TABLIST_HEADERS
#endif

// Message
#if !defined SCM
	#define SCM SendClientMessage
#endif

#if !defined SCMTA
	#define SCMTA SendClientMessageToAll
#endif

// Admin reason
#if !defined MAX_LENGTH_ADM_REASON
	#define MAX_LENGTH_ADM_REASON (50)
#endif

#if !defined MAX_STR_ADM_REASON
	#define MAX_STR_ADM_REASON "50"
#endif

// PM
#if !defined MAX_LENGTH_PLAYER_PM
	#define MAX_LENGTH_PLAYER_PM (100)
#endif

#if !defined MAX_STR_PLAYER_PM
	#define MAX_STR_PLAYER_PM "100"
#endif

// IP
#if !defined MAX_LENGTH_IP
	#define MAX_LENGTH_IP (16)
#endif

#if !defined MAX_STR_IP
	#define MAX_STR_IP "16"
#endif

// Datetime
#if !defined MAX_LENGTH_DATETIME
	#define MAX_LENGTH_DATETIME (20)
#endif

#if !defined MAX_STR_DATETIME
	#define MAX_STR_DATETIME "20"
#endif

// EMail
#if !defined MINIMAL_LENGTH_EMAIL
	#define MINIMAL_LENGTH_EMAIL 10
#endif

#if !defined MAXIMAL_LENGTH_EMAIL
	#define MAXIMAL_LENGTH_EMAIL 42
#endif

// Number
#if !defined MAX_LENGTH_NUM
	#define MAX_LENGTH_NUM (11)
#endif

#if !defined MAX_STR_NUM
	#define MAX_STR_NUM "11"
#endif

// Promocode
#if !defined MAX_LENGTH_PROMOCODE
	#define MAX_LENGTH_PROMOCODE (16)
#endif

#if !defined MAX_STR_PROMOCODE
	#define MAX_STR_PROMOCODE "16"
#endif

// Password
#if !defined MAX_LENGTH_PASSWORD
	#define MAX_LENGTH_PASSWORD (65)
#endif

#if !defined MAX_STR_PASSWORD
	#define MAX_STR_PASSWORD "65"
#endif

// Seconds password
#if !defined MAX_LENGTH_SEC_PASSWORD
	#define MAX_LENGTH_SEC_PASSWORD (19)
#endif

#if !defined MAX_STR_SEC_PASSWORD
	#define MAX_STR_SEC_PASSWORD "19"
#endif

// Nick color
#if !defined MAX_LENGTH_COLOR_NICK
	#define MAX_LENGTH_COLOR_NICK (15)
#endif

#if !defined MAX_STR_COLOR_NICK
	#define MAX_STR_COLOR_NICK "15"
#endif

// Player name
#if defined MAX_PLAYER_NAME
	#undef MAX_PLAYER_NAME
#endif
#define MAX_PLAYER_NAME 24

#if !defined MAX_STR_PLAYER_NAME
	#define MAX_STR_PLAYER_NAME "24"
#endif

// Admin level name
#if !defined MAX_LENGTH_ADM_LEVEL_NAME
	#define MAX_LENGTH_ADM_LEVEL_NAME (20)
#endif

#if !defined MAX_STR_ADM_LEVEL_NAME
	#define MAX_STR_ADM_LEVEL_NAME "20"
#endif

// Admin level info
#if !defined MAX_LENGTH_ADM_LEVEL_INFO
	#define MAX_LENGTH_ADM_LEVEL_INFO (100)
#endif

#if !defined MAX_STR_ADM_LEVEL_INFO
	#define MAX_STR_ADM_LEVEL_INFO "100"
#endif

// Command
#if !defined MAX_LENGTH_COMMAND_NAME
	#define MAX_LENGTH_COMMAND_NAME (20)
#endif

#if !defined MAX_STR_COMMAND_NAME
	#define MAX_STR_COMMAND_NAME "20"
#endif

// Command info
#if !defined MAX_LENGTH_COMMAND_INFO
	#define MAX_LENGTH_COMMAND_INFO (100)
#endif

#if !defined MAX_STR_COMMAND_INFO
	#define MAX_STR_COMMAND_INFO "100"
#endif

// Sex
#if !defined SEX_MALE
	#define SEX_MALE (0)
#endif

#if !defined SEX_FEMALE
	#define SEX_FEMALE (1)
#endif

// Spectate
#if !defined PLAYER_SPECTATE_INVALID
	#define PLAYER_SPECTATE_INVALID (0)
#endif

#if !defined PLAYER_SPECTATE_PLAYER
	#define PLAYER_SPECTATE_PLAYER (1)
#endif

#if !defined PLAYER_SPECTATE_VEHICLE
	#define PLAYER_SPECTATE_VEHICLE (2)
#endif

// Report sending text
#if !defined MAX_LENGTH_REPORT_TEXT
	#define MAX_LENGTH_REPORT_TEXT (250)
#endif

#if !defined MAX_STR_REPORT_TEXT
	#define MAX_STR_REPORT_TEXT "250"
#endif

// Player indicator health bar
// No indicator
#if !defined PLAYER_IND_HEALTH_NONE
	#define PLAYER_IND_HEALTH_NONE (0)
#endif

// Indicator from weapon-config
#if !defined PLAYER_IND_HEALTH_WC
	#define PLAYER_IND_HEALTH_WC (1)
#endif

// Custom indicator
#if !defined PLAYER_IND_HEALTH_CUSTOM
	#define PLAYER_IND_HEALTH_CUSTOM (2)
#endif

// Max ban
#if !defined MAX_PLAYER_DAYS_BAN
	#define MAX_PLAYER_DAYS_BAN (30)
#endif

#if !defined MAX_STR_PLAYER_DAYS_BAN
	#define MAX_STR_PLAYER_DAYS_BAN "30"
#endif

// Server name
#if !defined MAX_LENGTH_SERVER_NAME
	#define MAX_LENGTH_SERVER_NAME (40)
#endif

#if !defined MAX_STR_SERVER_NAME
	#define MAX_STR_SERVER_NAME "40"
#endif

// Hash
#if !defined BCRYPT_COST
	#define BCRYPT_COST 12
#endif

// Weather
#if !defined MINIMAL_WEATHER_ID
	#define MINIMAL_WEATHER_ID 0
#endif

#if !defined MAXIMAL_WEATHER_ID
	#define MAXIMAL_WEATHER_ID 22
#endif

// Others
#define public:%0(%1) forward%0(%1); public%0(%1)

#if !defined GivePVarInt
	#define GivePVarInt(%0,%1,%2) SetPVarInt(%0,%1,(GetPVarInt(%0,%1) + %2))
#endif

#if !defined random_ex
	#define random_ex(%0,%1,%2) %0 + (random((%1 - %0) / %2 + 1) * %2)
#endif

#if !defined SetPlayerTimer
	#define SetPlayerTimer(%0,%1,%2,%3)	SetTimerEx(%1,%2,%3,"i",%0)
#endif

#if !defined n_for
	#define n_for(%0,%1) for (new %0 = 0, jjj = %1; %0 < jjj; %0++)
#endif

#if !defined n_for2
	#define n_for2(%0,%1) for (new %0 = 0, yyy = %1; %0 < yyy; %0++)
#endif

#if !defined n_for3
	#define n_for3(%0,%1) for (new %0 = 0, zzz = %1; %0 < zzz; %0++)
#endif

#if !defined n_for4
	#define n_for4(%0,%1) for (new %0 = 0, fff = %1; %0 < fff; %0++)
#endif

#if !defined n_for5
	#define n_for5(%0,%1) for (new %0 = 0, ggg = %1; %0 < ggg; %0++)
#endif

#if !defined r_for
	#define r_for(%0,%1) for (new %0 = %1 - 1; %0 != -1; %0--)
#endif

#if !defined f
	#define f(%1, format(%1,sizeof(%1),
#endif

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

// Flags commands
enum (<<= 1)
{
	// Admin
	CMD_FLAG_ADMIN = 1,
	CMD_FLAG_ADMIN_JUNIOR,
	CMD_FLAG_ADMIN_SENIOR,
	CMD_FLAG_ADMIN_MAIN,
	CMD_FLAG_ADMIN_SPECIAL,
	CMD_FLAG_ADMIN_STEERING,
	CMD_FLAG_ADMIN_FOUNDER,

	// Premium
	CMD_FLAG_PREMIUM,
	CMD_FLAG_PREMIUM_SILVER,

	// Modes
	CMD_FLAG_MODE_NONE,
	CMD_FLAG_MODE_ROOM,
	CMD_FLAG_MODE_TDM,
	CMD_FLAG_MODE_DM
}

// Deaths player
enum {
	PLAYER_DEATH_NONE = 0,
	PLAYER_DEATH_INVALID,
	PLAYER_DEATH_KILLER
}

// Random keys
enum E_RANDOM_KEYS_INFO {
	e_Key,
	e_KeyStr[3]
}

enum E_PLAYER_STATE_TEXT_DRAW {
	bool:e_Created,
	bool:e_Shown
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	ServerUpdateSecond,
	IndicatorPlayerHealth;

static
	Text:TD_LogoServer[3],
	Text:TD_BelowHealth[8],
	Text:TD_BlackStripe[2];

static const 
	NameCapturePointABC[20][5] = {
	"A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L",
	"M", "N", "O", "P", "Q", "R",
	"S", "T"
};

static const 
	NameSquad[20][30] = {
	"Альфа", "Браво", "Чарли", "Дельта", "Эхо", "Фокстрот", "Оскар", "Хотель", "Сиерра", "Джулиет", 
	"Стрелок", "Непоседы", "Улыбка", "Смайлики", "Пингвины", "Червячки", "Торнадо", "Пупсы", "Интеграл", "Мамонты"
};

static const
	KEY:RandomKeys[MAX_COUNT_RANDOM_KEYS][E_RANDOM_KEYS_INFO] = {
		{KEY_YES, "Y"},
		{KEY_NO, "N"},
		{KEY_CTRL_BACK, "H"}
	},
	RandomColorText[MAX_COUNT_RANDOM_COLOR][5] = {
		{"~r~"},
		{"~g~"},
		{"~b~"},
		{"~w~"},
		{"~y~"},
		{"~p~"}
	};

static const
	Domains[][] = { 
		"ru", "com", "ру", "рф", "su", "net", "info", "pro", "org", "biz", "tel", "name", "xxx" 
	};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>------------------------<|
 * |   Timers update server   |
 * |>------------------------<|
 */

public: CallUpdateServer()
{
	if (ServerUpdateSecond < 59) {
		ServerUpdateSecond++;
	}
	else {
		ServerUpdateSecond = 0;
	}

	switch (ServerUpdateSecond) {
		case 59: {}
	}

	Mode_UpdateModesData();

	foreach (Player, p) {
		UpdatePlayerInAFK(p);
	}

	new
		h, m, s;

	gettime(h, m, s);
	SetWorldTime(h);
	return 1;
}

public: CallUpdateServer2()
{
	Mode_UpdateModesData2();
	return 1;
}

/*
 * |>----------------------<|
 * |   Working with MySQL   |
 * |>----------------------<|
 */

stock FormatIntArrayToSQL(vars[], varsSize, output[], outputSize = sizeof(output))
{
	n_for(i, varsSize) {
		format(output, outputSize, "%s%d,", output, vars[i]);
	}
	return 1;
}

stock FormatFloatArrayToSQL(Float:vars[], varsSize, output[], outputSize = sizeof(output))
{
	n_for(i, varsSize) {
		format(output, outputSize, "%s%.2f,", output, vars[i]);
	}
	return 1;
}

/*
 * |>-------------------------<|
 * |   Working with datetime   |
 * |>-------------------------<|
 */

stock bool:IsLeapYear(year)
{
	return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
}

stock GetDaysInMonth(month, year)
{
	switch(month)
	{
		case 1, 3, 5, 7, 8, 10, 12: {
			return 31;
		}
		case 4, 6, 9, 11: {
			return 30;
		}
		case 2: {
			return IsLeapYear(year) ? 29 : 28;
		}
	}
	return 0;
}

stock bool:IsDatetimeExpired(const stringDatetime[], &days = 0)
{
	new
		nowYear, nowMonth, nowDay, nowHour, nowMinute, nowSecond,
		targetYear, targetMonth, targetDay, targetHour, targetMinute, targetSecond;

	getdate(nowYear, nowMonth, nowDay);
	gettime(nowHour, nowMinute, nowSecond);

	if(!ConvertStringDatetime(stringDatetime, targetYear, targetMonth, targetDay, targetHour, targetMinute, targetSecond)) {
		days = 0;
		return true;
	}

	days = GetDateDifference(nowYear, nowMonth, nowDay, targetYear, targetMonth, targetDay);

	// Year
	if(nowYear > targetYear) {
		return true;
	}
	if(nowYear < targetYear) {
		return false;
	}

	// Month
	if(nowMonth > targetMonth) {
		return true;
	}
	if(nowMonth < targetMonth) {
		return false;
	}

	// Day
	if(nowDay > targetDay) {
		return true;
	}
	if(nowDay < targetDay) {
		return false;
	}

	// Hour
	if(nowHour > targetHour) {
		return true;
	}
	if(nowHour < targetHour) {
		return false;
	}

	// Minute
	if(nowMinute > targetMinute) {
		return true;
	}
	if(nowMinute < targetMinute) {
		return false;
	}

	return (nowSecond >= targetSecond);
}

static GetDateDifference(nowYear, nowMonth, nowDay, targetYear, targetMonth, targetDay)
{
	new
		totalDays = 0;

	if(nowYear > targetYear
	|| (nowYear == targetYear && nowMonth > targetMonth)
	|| (nowYear == targetYear && nowMonth == targetMonth && nowDay > targetDay)) {
		return 0;
	}

	// Year
	for(new year = nowYear; year < targetYear; year++) {
		totalDays += IsLeapYear(year) ? 366 : 365;
	}

	// Month
	if(nowYear == targetYear) {
		for(new month = nowMonth; month < targetMonth; month++) {
			totalDays += GetDaysInMonth(month, targetYear);
		}
	}
	else {
		for(new month = nowMonth; month <= 12; month++) {
			totalDays += GetDaysInMonth(month, nowYear);
		}
		for(new month = 1; month < targetMonth; month++) {
			totalDays += GetDaysInMonth(month, targetYear);
		}
	}

	// Days
	totalDays += targetDay - nowDay;
	return totalDays;
}

stock ConvertStringDatetime(const stringDatetime[], &year, &month, &day, &hours, &minutes, &seconds)
{
	if(strlen(stringDatetime) < MAX_LENGTH_DATETIME - 1) {
		return 0;
	}

	new
		datePart[11],
		timePart[9],
		temp[5], pos = 0;

	/* Date (format: YYYY-MM-DD) */
	strmid(datePart, stringDatetime, 0, 10);
	
	// Year
	strmid(temp, datePart, pos, pos + 4);
	year = strval(temp);
	pos += 5; // Skip '-'
		
	// Month
	strmid(temp, datePart, pos, pos + 2);
	month = strval(temp);
	pos += 3; // Skip '-'
		
	// Day
	strmid(temp, datePart, pos, pos + 2);
	day = strval(temp);
		
	/* Time (format: HH:MM:SS) */
	strmid(timePart, stringDatetime, 11, 19);
	pos = 0;
		
	// Hours
	strmid(temp, timePart, pos, pos + 2);
	hours = strval(temp);
	pos += 3; // Skip ':'
		
	// Minutes
	strmid(temp, timePart, pos, pos + 2);
	minutes = strval(temp);
	pos += 3; // Skip ':'
		
	// Seconds
	strmid(temp, timePart, pos, pos + 2);
	seconds = strval(temp);
	return 1;
}

stock AddToDatetime(const stringDatetime[], years = 0, months = 0, days = 0, hours = 0, minutes = 0, seconds = 0)
{
	new
		output[MAX_LENGTH_DATETIME],
		nowYear, nowMonth, nowDay, nowHours, nowMinutes, nowSeconds;

	ConvertStringDatetime(stringDatetime, nowYear, nowMonth, nowDay, nowHours, nowMinutes, nowSeconds);

	nowSeconds += seconds;
	nowMinutes += seconds / 60;
	nowSeconds %= 60;

	nowMinutes += minutes;
	nowHours += nowMinutes / 60;
	nowMinutes %= 60;

	nowHours += hours;
	nowDay += nowHours / 24;
	nowHours %= 24;

	nowDay += days;

	nowMonth += months;
	nowYear += years + (nowMonth - 1) / 12;
	nowMonth = (nowMonth - 1) % 12 + 1;

	while(nowDay > GetDaysInMonth(nowMonth, nowYear)) {
		nowDay -= GetDaysInMonth(nowMonth, nowYear);
		nowMonth++;

		if(nowMonth > 12) {
			nowMonth = 1;
			nowYear++;
		}
	}

	f(output, "%04d-%02d-%02d %02d:%02d:%02d", nowYear, nowMonth, nowDay, nowHours, nowMinutes, nowSeconds);
	return output;
}

stock GetCurrentDatetime()
{
	new
		output[MAX_LENGTH_DATETIME],
		year, month, day, hours, minutes, seconds;

	getdate(year, month, day);
	gettime(hours, minutes, seconds);

	f(output, "%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hours, minutes, seconds);
	return output;
}

stock ShowDatetimeForPlayer(playerid, const mysqlDatetime[])
{
	#pragma unused playerid

	new
		year, month, day, hour, minute, second,
		output[MAX_LENGTH_DATETIME + 3],
		language = 0;

	if(sscanf(mysqlDatetime, "p<->iii p<:>iii", year, month, day, hour, minute, second)) {
		strcopy(output, mysqlDatetime, MAX_LENGTH_DATETIME);
		return output;
	}

	switch(language) {
		// Russian (DD.MM.YYYY HH:MM:CC)
		case 0: {
			f(output, "%02d.%02d.%04d %02d:%02d:%02d", day, month, year, hour, minute, second);
		}
		// American (MM/DD/YYYY HH:MM:CC AM/PM)
		case 1: {
			new
				ampm[3];

			if(hour < 12) {
				ampm = "AM";
			}
			else {
				ampm = "PM";

				if(hour > 12) {
					hour -= 12;
				}
			}
			f(output, "%02d/%02d/%04d %02d:%02d:%02d %s", month, day, year, hour, minute, second, ampm);
		}
		// (YYYY-MM-DD HH:MM:SS)
		default: {
			f(output, "%04d-%02d-%02d %02d:%02d:%02d", year, month, day, hour, minute, second);
		}
	}
	return output;
}

/*
 * |>---------<|
 * |   Regex   |
 * |>---------<|
 */

stock IsStringIP(const string[])
{
	new
		Regex:strRegex = Regex_New("([1-9]{1})([0-9]{0,2})\\.([0-9]{1,3})\\.([0-9|\\*]){1,3}\\.([0-9|\\*]){1,3}"),
		check = Regex_Check(string, strRegex);

	Regex_Delete(strRegex);
	return check;
}

stock IsStringEmail(const string[])
{
	if(!(MINIMAL_LENGTH_EMAIL <= strlen(string) <= MAXIMAL_LENGTH_EMAIL)) {
		return 0;
	}

	new
		Regex:strRegex = Regex_New("([A-Za-z0-9]{1})([A-Za-z0-9_\\.\\-]{3,30})@([a-z]{2,6})\\.([a-z]{2,4})"),
		check = Regex_Check(string, strRegex);

	Regex_Delete(strRegex);
	return check;
}

stock IsStringNum(const string[])
{
	new
		Regex:strRegex = Regex_New("^[0-9]+$"),
		check = Regex_Check(string, strRegex);

	Regex_Delete(strRegex);
	return check;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

stock GetRandomKey(num)
{
	return RandomKeys[num][e_Key];
}

stock GetRandomKeyStr(num)
{
	return RandomKeys[num][e_KeyStr];
}

stock GetRandomColorText(num)
{
	return RandomColorText[num];
}

stock SetIndicatorHealth(num)
{
	IndicatorPlayerHealth = num;
	return 1;
}

stock GetIndicatorHealth()
{
	return IndicatorPlayerHealth;
}

stock GetNamePointABC(num)
{
	new
		str[5];

	strcopy(str, NameCapturePointABC[num]);
	return str;
}

stock GetNameSquad(num)
{
	new
		str[30];

	strcopy(str, NameSquad[num]);
	return str;
}

stock GetPlayerID(const playerName[], playerid)
{
	return sscanf(playerName, "u", playerid);
}

stock GetNameID(const playerName[])
{
	new
		playerid = INVALID_PLAYER_ID;

	sscanf(playerName, "u", playerid);

	if (IsPlayerOnServer(playerid)) {
		return playerid;
	}
	return INVALID_PLAYER_ID;
}

stock GetString(const stringOne[], const stringTwo[])
{
	return !strcmp(stringOne, stringTwo, false);
}

stock getfloat(...)
{
	if (getarg(0) - floatround(getarg(0), floatround_round) != 0.0) {
		return true;
	}
	return false;
}

stock strtok(const string[], &index)
{
	new 
		length = strlen(string);
	
	while ((index < length) && (string[index] <= ' ')) {
		index++;
	}

	new 
		offset = index,
		result[20];

	while ((index < length) && (string[index] > ' ') && ((index - offset) < (sizeof(result) - 1))) {
		result[index - offset] = string[index];
		index++;
	}

	result[index - offset] = EOS;
	return result;
}

stock IsCh(num)
{
	if (num % 2 == 0) {
		return 1;
	}
	return 0;
}

stock IsOSymbol(const string[], const symbol, first, end)
{
	if (first < 0) {
		first = 0;
	}

	if (end >= strlen(string)) {
		end = strlen(string) - 1;
	}

	for (new i = first; i <= end; i ++) {
		if (string[i] == symbol) {
			return 1;
		}
	}
	return 0;
}

stock IsODomen(const string[])
{
	n_for(i, sizeof(Domains)) {
		new
			find = strfind(string, Domains[i], true);

		if (find != -1) {
			if (IsOSymbol(string, '.', find - 2, find)) {
				return 1;
			}
		}
	}
	return 0;
}

stock HexToInt(const string[])
{
	if (string[0] == 0) {
		return 0;
	}

	new
		i, cur = 1, res = 0;

	for (i = strlen(string); i > 0; i--) {
		if (string[i - 1] < 58) {
			res = res + cur * (string[i - 1] - 48);
		}
		else { 
			res = res + cur * (string[i - 1] - 65 + 10);
		}
		cur = cur * 16;
	}
	return res;
}

stock HEXResultColor(const color[], type)
{
	new
		str[15];

	switch (type) {
		case 1: { // FF
			f(str, "0x%sFF", color);
		}
		case 2: { // AA
			f(str, "0x%sAA", color);
		}
		case 3: { // BB
			f(str, "0x%sBB", color);
		}
	}
	return str;
}

stock GeneratePassword(size)
{
	new
		numbers[10][] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"},
		password[128];

	if (size > sizeof(password)) {
		size = sizeof(password);
	}
	
	n_for(i, size) {
		switch (random(4)) {
			case 0: strcat(password, numbers[random(sizeof(numbers))]);
			case 1: strcat(password, numbers[random(sizeof(numbers))]);
			case 2: strcat(password, numbers[random(sizeof(numbers))]);
			case 3: strcat(password, numbers[random(sizeof(numbers))]);
		}
	}
	return password;
}

stock ShowPlayerLogoServerTD(playerid)
{
	n_for(i, sizeof(TD_LogoServer)) {
		TextDrawShowForPlayer(playerid, TD_LogoServer[i]);
	}
	return 1;
}

stock HidePlayerLogoServerTD(playerid)
{
	n_for(i, sizeof(TD_LogoServer)) {
		TextDrawHideForPlayer(playerid, TD_LogoServer[i]);
	}
	return 1;
}

stock ShowPlayerBelowHealthTD(playerid, startTD, finishTD = 8)
{
	for (new i = startTD; i < finishTD; i++) {
		TextDrawShowForPlayer(playerid, TD_BelowHealth[i]);
	}
	return 1;
}

stock HidePlayerBelowHealthTD(playerid, startTD, finishTD = 8)
{
	for (new i = startTD; i < finishTD; i++) {
		TextDrawHideForPlayer(playerid, TD_BelowHealth[i]);
	}
	return 1;
}

stock ShowPlayerBlackStripeTD(playerid)
{
	n_for(i, sizeof(TD_BlackStripe)) {
		TextDrawShowForPlayer(playerid, TD_BlackStripe[i]);
	}
	return 1;
}

stock HidePlayerBlackStripeTD(playerid)
{
	n_for(i, sizeof(TD_BlackStripe)) {
		TextDrawHideForPlayer(playerid, TD_BlackStripe[i]);
	}
	return 1;
}

stock LoadMapObjects()
{
	new
		tmpobjid,
		objectWorld = -1,
		objectInt = -1;

	if (tmpobjid) {
		tmpobjid = tmpobjid + 1 - 2;
	}

	#include <map-objects/desert>
	#include <map-objects/airport>
	#include <map-objects/stadium>
	#include <map-objects/village>
	#include <map-objects/golf>
	#include <map-objects/military-oil>
	#include <map-objects/swimming-pool>
	#include <map-objects/warehouse>
	#include <map-objects/ghetto>
	#include <map-objects/bf>
	#include <map-objects/afghan>

	#include <map-objects/i-dog-mansion>
	#include <map-objects/i-palace-smoke>
	#include <map-objects/i-atrium>
	#include <map-objects/i-jizzie>
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

stock Core_OnGameModeInit()
{
	// Nex-ac
	EnableAntiCheat(12, 0);	// Health (onfoot)
	EnableAntiCheat(13, 0);	// Armour
	EnableAntiCheat(15, 0);	// Weapon
	EnableAntiCheat(27, 0);	// FakeSpawn
	EnableAntiCheat(28, 0);	// FakeKill
	EnableAntiCheat(38, 0);	// Ping

	// Weapon-config
	SetVehiclePassengerDamage(true);		// Destroying transport if there is a passenger there
	SetDisableSyncBugs(true);				// Improved synchronization
	SetDamageFeed(false);					// Show information when damage occurs
	SetVehicleUnoccupiedDamage(false);		// Destroy transport if there is no one there
	SetRespawnTime(3000);					// Time until respawn after death (shouldn't work!)

	// Player health indicator
	SetIndicatorHealth(PLAYER_IND_HEALTH_WC);

	// Objects
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 4000, -1);
	LoadMapObjects();

	// TextDraw's 
	// Logo server
	TD_LogoServer[0] = TextDrawCreate(585.0000, 5.0000, "OFFENSIVE");
	TextDrawLetterSize(TD_LogoServer[0], 0.4329, 1.7201);
	TextDrawAlignment(TD_LogoServer[0], TEXT_DRAW_ALIGN_CENTER);
	TextDrawColour(TD_LogoServer[0], -136586497);
	TextDrawBackgroundColour(TD_LogoServer[0], 606348543);
	TextDrawFont(TD_LogoServer[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_LogoServer[0], true);
	TextDrawSetShadow(TD_LogoServer[0], 1);
	TextDrawSetOutline(TD_LogoServer[0], 0);

	TD_LogoServer[1] = TextDrawCreate(551.0000, 22.0000, "Box");
	TextDrawLetterSize(TD_LogoServer[1], 0.0000, 0.8999);
	TextDrawTextSize(TD_LogoServer[1], 620.0000, 0.0000);
	TextDrawAlignment(TD_LogoServer[1], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_LogoServer[1], 1130251775);
	TextDrawUseBox(TD_LogoServer[1], true);
	TextDrawBoxColour(TD_LogoServer[1], -646184705);
	TextDrawBackgroundColour(TD_LogoServer[1], 255);
	TextDrawFont(TD_LogoServer[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_LogoServer[1], true);
	TextDrawSetShadow(TD_LogoServer[1], 0);
	TextDrawSetOutline(TD_LogoServer[1], 0);

	TD_LogoServer[2] = TextDrawCreate(586.0000, 19.0000, "CORE");
	TextDrawLetterSize(TD_LogoServer[2], 0.2533, 1.3839);
	TextDrawAlignment(TD_LogoServer[2], TEXT_DRAW_ALIGN_CENTER);
	TextDrawColour(TD_LogoServer[2], -437918721);
	TextDrawBackgroundColour(TD_LogoServer[2], 16);
	TextDrawFont(TD_LogoServer[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	TextDrawSetProportional(TD_LogoServer[2], true);
	TextDrawSetShadow(TD_LogoServer[2], 1);
	TextDrawSetOutline(TD_LogoServer[2], 0);

	// Black stripe
	TD_BlackStripe[0] = TextDrawCreate(0.000000, 0.000000, "_"); // Top stripe
	TextDrawLetterSize(TD_BlackStripe[0], 0.000000, 3.799993);
	TextDrawTextSize(TD_BlackStripe[0], 645.000000, 0.000000);
	TextDrawAlignment(TD_BlackStripe[0], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BlackStripe[0], 0xFFFFFFFF);
	TextDrawUseBox(TD_BlackStripe[0], true);
	TextDrawBoxColour(TD_BlackStripe[0], 255);
	TextDrawSetShadow(TD_BlackStripe[0], 0);
	TextDrawSetOutline(TD_BlackStripe[0], 0);
	TextDrawBackgroundColour(TD_BlackStripe[0], 255);
	TextDrawFont(TD_BlackStripe[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_BlackStripe[0], true);

	TD_BlackStripe[1] = TextDrawCreate(0.000000, 400.000000, "_"); // Bottom stripe
	TextDrawLetterSize(TD_BlackStripe[1], 0.000000, 5.233336);
	TextDrawTextSize(TD_BlackStripe[1], 645.333312, 0.000000);
	TextDrawAlignment(TD_BlackStripe[1], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BlackStripe[1], 0xFFFFFFFF);
	TextDrawUseBox(TD_BlackStripe[1], true);
	TextDrawBoxColour(TD_BlackStripe[1], 255);
	TextDrawSetShadow(TD_BlackStripe[1], 0);
	TextDrawSetOutline(TD_BlackStripe[1], 0);
	TextDrawBackgroundColour(TD_BlackStripe[1], 255);
	TextDrawFont(TD_BlackStripe[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_BlackStripe[1], true);

	// The player has low health.
	TD_BelowHealth[0] = TextDrawCreate(-14.000000, -2.000000, "_");
	TextDrawLetterSize(TD_BelowHealth[0], 0.000000, 52.933341);
	TextDrawTextSize(TD_BelowHealth[0], 650.000000, 0.000000);
	TextDrawAlignment(TD_BelowHealth[0], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[0], 80);
	TextDrawUseBox(TD_BelowHealth[0], true);
	TextDrawBoxColour(TD_BelowHealth[0], 48);
	TextDrawSetShadow(TD_BelowHealth[0], 0);
	TextDrawSetOutline(TD_BelowHealth[0], 0);
	TextDrawBackgroundColour(TD_BelowHealth[0], 255);
	TextDrawFont(TD_BelowHealth[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_BelowHealth[0], true);

	TD_BelowHealth[1] = TextDrawCreate(235.000000, 118.000000, "particle:shad_heli");
	TextDrawLetterSize(TD_BelowHealth[1], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[1], 449.000000, -215.000000);
	TextDrawAlignment(TD_BelowHealth[1], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[1], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[1], 0);
	TextDrawSetOutline(TD_BelowHealth[1], 0);
	TextDrawBackgroundColour(TD_BelowHealth[1], 255);
	TextDrawFont(TD_BelowHealth[1], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[1], false);

	TD_BelowHealth[2] = TextDrawCreate(387.000000, 437.000000, "particle:shad_heli");
	TextDrawLetterSize(TD_BelowHealth[2], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[2], 427.000000, -126.000000);
	TextDrawAlignment(TD_BelowHealth[2], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[2], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[2], 0);
	TextDrawSetOutline(TD_BelowHealth[2], 0);
	TextDrawBackgroundColour(TD_BelowHealth[2], 255);
	TextDrawFont(TD_BelowHealth[2], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[2], false);

	TD_BelowHealth[3] = TextDrawCreate(-138.000000, 289.000000, "particle:shad_heli");
	TextDrawLetterSize(TD_BelowHealth[3], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[3], 476.000000, 113.000000);
	TextDrawAlignment(TD_BelowHealth[3], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[3], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[3], 0);
	TextDrawSetOutline(TD_BelowHealth[3], 0);
	TextDrawBackgroundColour(TD_BelowHealth[3], 255);
	TextDrawFont(TD_BelowHealth[3], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[3], false);

	TD_BelowHealth[4] = TextDrawCreate(460.000000, 176.000000, "particle:shad_ped");
	TextDrawLetterSize(TD_BelowHealth[4], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[4], 182.000000, 118.000000);
	TextDrawAlignment(TD_BelowHealth[4], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[4], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[4], 0);
	TextDrawSetOutline(TD_BelowHealth[4], 0);
	TextDrawBackgroundColour(TD_BelowHealth[4], 255);
	TextDrawFont(TD_BelowHealth[4], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[4], false);

	TD_BelowHealth[5] = TextDrawCreate(243.000000, 289.000000, "particle:shad_ped");
	TextDrawLetterSize(TD_BelowHealth[5], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[5], 248.000000, 124.000000);
	TextDrawAlignment(TD_BelowHealth[5], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[5], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[5], 0);
	TextDrawSetOutline(TD_BelowHealth[5], 0);
	TextDrawBackgroundColour(TD_BelowHealth[5], 255);
	TextDrawFont(TD_BelowHealth[5], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[5], false);

	TD_BelowHealth[6] = TextDrawCreate(71.000000, 133.000000, "particle:shad_ped");
	TextDrawLetterSize(TD_BelowHealth[6], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[6], 224.000000, 140.000000);
	TextDrawAlignment(TD_BelowHealth[6], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[6], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[6], 0);
	TextDrawSetOutline(TD_BelowHealth[6], 0);
	TextDrawBackgroundColour(TD_BelowHealth[6], 255);
	TextDrawFont(TD_BelowHealth[6], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[6], false);

	TD_BelowHealth[7] = TextDrawCreate(-158.000000, 156.000000, "particle:shad_heli");
	TextDrawLetterSize(TD_BelowHealth[7], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[7], 452.000000, -194.000000);
	TextDrawAlignment(TD_BelowHealth[7], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[7], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[7], 0);
	TextDrawSetOutline(TD_BelowHealth[7], 0);
	TextDrawBackgroundColour(TD_BelowHealth[7], 255);
	TextDrawFont(TD_BelowHealth[7], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[7], false);

	// Timers
	SetTimer("CallUpdateServer", 1000, true);
	SetTimer("CallUpdateServer2", 500, true);
	return 1;
}

/*
 * |>------------------<|
 * |   OnGameModeExit   |
 * |>------------------<|
 */

stock Core_OnGameModeExit()
{
	new
		year, month, day;

	getdate(year, month, day);
	return 1;
}