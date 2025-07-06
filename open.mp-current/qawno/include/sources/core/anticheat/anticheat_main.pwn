/*
 * |>==================================<|
 * |   About: Anticheat main            |
 * |   Author: Internet forums, Foxze   |
 * |>==================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)
	- OnCheatDetected(playerid, ip_address[], type, code)
 * Stock:
	- SetAntiCheatSettingsPage(playerid, page)
	- UpdatePlayerAnticheatData(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- ACSettings
	- ACCheatEditCode
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_ANTICHEAT_MAIN
	#endinput
#endif
#define _INC_ANTICHEAT_MAIN

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define AC_MAX_CODES						(53)
#define AC_MAX_CODE_LENGTH					(3 + 1)
#define AC_MAX_CODE_NAME_LENGTH				(33 + 1)
#define AC_MAX_TRIGGER_TYPES				(3)
#define AC_MAX_TRIGGER_TYPE_NAME_LENGTH		(8 + 1)
#define AC_GLOBAL_TRIGGER_TYPE_PLAYER		(0)
#define AC_GLOBAL_TRIGGER_TYPE_IP			(1)
#define AC_CODE_TRIGGER_TYPE_DISABLED		(0)
#define AC_CODE_TRIGGER_TYPE_WARNING		(1)
#define AC_CODE_TRIGGER_TYPE_KICK			(2)
#define AC_TRIGGER_ANTIFLOOD_TIME			(5)
#define AC_MAX_CODES_ON_PAGE				(15)
#define AC_DIALOG_NEXT_PAGE_TEXT			">>>"
#define AC_DIALOG_PREVIOUS_PAGE_TEXT		"<<<"

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static const
	AC_CODE[AC_MAX_CODES][AC_MAX_CODE_LENGTH] = {
	"000",
	"001",
	"002",
	"003",
	"004",
	"005",
	"006",
	"007",
	"008",
	"009",
	"010",
	"011",
	"012",
	"013",
	"014",
	"015",
	"016",
	"017",
	"018",
	"019",
	"020",
	"021",
	"022",
	"023",
	"024",
	"025",
	"026",
	"027",
	"028",
	"029",
	"030",
	"031",
	"032",
	"033",
	"034",
	"035",
	"036",
	"037",
	"038",
	"039",
	"040",
	"041",
	"042",
	"043",
	"044",
	"045",
	"046",
	"047",
	"048",
	"049",
	"050",
	"051",
	"052"
};

static const
	AC_CODE_NAME[AC_MAX_CODES][AC_MAX_CODE_NAME_LENGTH] = {
	{"AirBreak (onfoot)"},
	{"AirBreak (in vehicle)"},
	{"Teleport (onfoot)"},
	{"Teleport (in vehicle)"},
	{"Teleport (into/between vehicles)"},
	{"Teleport (vehicle to player)"},
	{"Teleport (pickups)"},
	{"FlyHack (onfoot)"},
	{"FlyHack (in vehicle)"},
	{"SpeedHack (onfoot)"},
	{"SpeedHack (in vehicle)"},
	{"Health hack (in vehicle)"},
	{"Health hack (onfoot)"},
	{"Armour hack"},
	{"Money hack"},
	{"Weapon hack"},
	{"Ammo hack (add)"},
	{"Ammo hack (infinite)"},
	{"Special actions hack"},
	{"GodMode from bullets (onfoot)"},
	{"GodMode from bullets (in vehicle)"},
	{"Invisible hack"},
	{"Lagcomp-spoof"},
	{"Tuning hack"},
	{"Parkour mod"},
	{"Quick turn"},
	{"Rapid fire"},
	{"FakeSpawn"},
	{"FakeKill"},
	{"Pro Aim"},
	{"CJ run"},
	{"CarShot"},
	{"CarJack"},
	{"UnFreeze"},
	{"AFK Ghost"},
	{"Full Aiming"},
	{"Fake NPC"},
	{"Reconnect"},
	{"High ping"},
	{"Dialog hack"},
	{"Sandbox"},
	{"Invalid version"},
	{"Rcon hack"},
	{"Tuning crasher"},
	{"Invalid seat crasher"},
	{"Dialog crasher"},
	{"Attached object crasher"},
	{"Weapon Crasher"},
	{"Connects to one slot"},
	{"Flood callback functions"},
	{"Flood change seat"},
	{"DDos"},
	{"NOP's"}
};

static const
	AC_TRIGGER_TYPE_NAME[AC_MAX_TRIGGER_TYPES][AC_MAX_TRIGGER_TYPE_NAME_LENGTH] = {
		{"Отключён"},
		{"Warning"},
		{"Kick"}
	};

static 
	AC_CODE_TRIGGER_TYPE[AC_MAX_CODES] = {
	AC_CODE_TRIGGER_TYPE_KICK, // Airbreak (onfoot)
	AC_CODE_TRIGGER_TYPE_WARNING, // Airbreak (in vehicle)
	AC_CODE_TRIGGER_TYPE_KICK, // Teleport (onfoot)
	AC_CODE_TRIGGER_TYPE_WARNING, // Teleport (in vehicle)
	AC_CODE_TRIGGER_TYPE_WARNING, // Teleport (into/between vehicles)
	AC_CODE_TRIGGER_TYPE_WARNING, // Teleport (vehicle to player)
	AC_CODE_TRIGGER_TYPE_WARNING, // Teleport (pickups)
	AC_CODE_TRIGGER_TYPE_KICK, // FlyHack (onfoot)
	AC_CODE_TRIGGER_TYPE_WARNING, // FlyHack (in vehicle)
	AC_CODE_TRIGGER_TYPE_WARNING, // SpeedHack (onfoot)
	AC_CODE_TRIGGER_TYPE_WARNING, // SpeedHack (in vehicle)
	AC_CODE_TRIGGER_TYPE_WARNING, // Health hack (in vehicle)
	AC_CODE_TRIGGER_TYPE_WARNING, // Health hack (onfoot)
	AC_CODE_TRIGGER_TYPE_WARNING, // Armour hack
	AC_CODE_TRIGGER_TYPE_WARNING, // Money hack
	AC_CODE_TRIGGER_TYPE_KICK, // Weapon hack
	AC_CODE_TRIGGER_TYPE_KICK, // Ammo hack (add)
	AC_CODE_TRIGGER_TYPE_KICK, // Ammo hack (infinite)
	AC_CODE_TRIGGER_TYPE_KICK, // Special actions hack
	AC_CODE_TRIGGER_TYPE_WARNING, // GodMode from bullets (onfoot)
	AC_CODE_TRIGGER_TYPE_WARNING, // GodMode from bullets (in vehicle)
	AC_CODE_TRIGGER_TYPE_KICK, // Invisible hack
	AC_CODE_TRIGGER_TYPE_KICK, // Lagcomp-spoof
	AC_CODE_TRIGGER_TYPE_WARNING, // Tuning hack
	AC_CODE_TRIGGER_TYPE_WARNING, // Parkour mod
	AC_CODE_TRIGGER_TYPE_KICK, // Quick turn
	AC_CODE_TRIGGER_TYPE_KICK, // Rapid fire
	AC_CODE_TRIGGER_TYPE_KICK, // FakeSpawn
	AC_CODE_TRIGGER_TYPE_WARNING, // FakeKill
	AC_CODE_TRIGGER_TYPE_KICK, // Pro Aim
	AC_CODE_TRIGGER_TYPE_WARNING, // CJ run
	AC_CODE_TRIGGER_TYPE_KICK, // CarShot
	AC_CODE_TRIGGER_TYPE_WARNING, // CarJack
	AC_CODE_TRIGGER_TYPE_KICK, // UnFreeze
	AC_CODE_TRIGGER_TYPE_WARNING, // AFK Ghost
	AC_CODE_TRIGGER_TYPE_WARNING, // Full Aiming
	AC_CODE_TRIGGER_TYPE_KICK, // Fake NPC
	AC_CODE_TRIGGER_TYPE_KICK, // Reconnect
	AC_CODE_TRIGGER_TYPE_WARNING, // High Ping
	AC_CODE_TRIGGER_TYPE_WARNING, // Dialog Hack
	AC_CODE_TRIGGER_TYPE_KICK, // Sandbox
	AC_CODE_TRIGGER_TYPE_KICK, // Invalid Version
	AC_CODE_TRIGGER_TYPE_KICK, // Rcon hack
	AC_CODE_TRIGGER_TYPE_KICK, // Tuning crasher
	AC_CODE_TRIGGER_TYPE_KICK, // Invalid seat crasher
	AC_CODE_TRIGGER_TYPE_KICK, // Dialog crasher
	AC_CODE_TRIGGER_TYPE_KICK, // Attached object crasher
	AC_CODE_TRIGGER_TYPE_KICK, // Weapon crasher
	AC_CODE_TRIGGER_TYPE_KICK, // Connects to one slot
	AC_CODE_TRIGGER_TYPE_WARNING, // Flood callback functions
	AC_CODE_TRIGGER_TYPE_KICK, // Flood change seat
	AC_CODE_TRIGGER_TYPE_KICK, // DDos
	AC_CODE_TRIGGER_TYPE_WARNING // NOP`s
};

static
	AC_CODE_TRIGGERED_COUNT[AC_MAX_CODES] = {0, ...};

static
	pAntiCheatLastCodeTriggerTime[MAX_PLAYERS][AC_MAX_CODES],
	pAntiCheatSettingsPage[MAX_PLAYERS char],
	pAntiCheatSettingsMenuListData[MAX_PLAYERS][AC_MAX_CODES_ON_PAGE],
	pAntiCheatSettingsEditCodeId[MAX_PLAYERS];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

public: OnCheatDetected(playerid, ip_address[], type, code)
{
	if (type == AC_GLOBAL_TRIGGER_TYPE_PLAYER) {
		switch (code) {
			case 6, 5, 11, 22: return 1;
			// CarJack
			case 32: {
				new
					Float:x,
					Float:y,
					Float:z;

				AntiCheatGetPos(playerid, x, y, z);
				return SetPlayerPos(playerid, x, y, z);
			}
			// Sandbox
			case 40: {
				Dialog_Message(playerid, ""CT_RED"Античит", MAX_CONNECTS_MSG, "Ok");
				return KickPlayerEx(playerid);
			}
			// Invalid Version
			case 41: {
				Dialog_Message(playerid, ""CT_RED"Античит", UNKNOWN_CLIENT_MSG, "Ok");
				return KickPlayerEx(playerid);
			}
			default: {
				if (pAntiCheatLastCodeTriggerTime[playerid][code] > 0) {
					return 1;
				}

				pAntiCheatLastCodeTriggerTime[playerid][code] = AC_TRIGGER_ANTIFLOOD_TIME;
				AC_CODE_TRIGGERED_COUNT[code]++;

				new
					trigger_type = AC_CODE_TRIGGER_TYPE[code];

				if (trigger_type == AC_CODE_TRIGGER_TYPE_WARNING) {
					SendAdminsMessage(C_CARMINE, "[Античит]:"CT_WHITE" %s[%d] подозревается в использовании чит-программ: %s [Код: %03d]", GetPlayerNameEx(playerid), playerid, AC_CODE_NAME[code], code);
					AddAdminCheater(playerid);
				}
				if (trigger_type == AC_CODE_TRIGGER_TYPE_KICK) {
					SendAdminsMessage(C_CARMINE, "[Античит]:"CT_WHITE" %s[%d] был кикнут по подозрению в использовании чит-программ: %s [Код: %03d].", GetPlayerNameEx(playerid), playerid, AC_CODE_NAME[code], code);

					new
						str[300];

					f(str, KICK_MSG, code, code);
					Dialog_Message(playerid, ""CT_RED"Античит", str, "Ok");

					return KickPlayerEx(playerid);
				}
				if (trigger_type == AC_CODE_TRIGGER_TYPE_DISABLED) 
				return 1;
			}
		}
	}
	// AC_GLOBAL_TRIGGER_TYPE_IP
	else {
		AC_CODE_TRIGGERED_COUNT[code]++;

		SendAdminsMessage(0xCC0033FF, "[Античит]:"CT_WHITE" IP-адрес %s был заблокирован: %s [Код: %03d].", ip_address, AC_CODE_NAME[code], code);

		new
			str[300];

		f(str, KICK_MSG, code, code);
		Dialog_Message(playerid, ""CT_RED"Античит / Anti-cheat", str, "Ok");

		KickPlayerEx(playerid);
	}
	return 1;
}

stock SetAntiCheatSettingsPage(playerid, page)
{
	pAntiCheatSettingsPage{playerid} = page;
	return 1;
}

stock UpdatePlayerAnticheatData(playerid)
{
	n_for(i, AC_MAX_CODES) {
		if (pAntiCheatLastCodeTriggerTime[playerid][i] > 0) {
			pAntiCheatLastCodeTriggerTime[playerid][i]--;
		}
	}
	return 1;
}

 /*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

DialogCreate:ACSettings(playerid)
{
	static
		dialog_string[500 + 20 - 8 + (AC_MAX_CODE_LENGTH + AC_MAX_CODE_NAME_LENGTH + AC_MAX_TRIGGER_TYPE_NAME_LENGTH + 10)*AC_MAX_CODES_ON_PAGE];

	dialog_string[0] = EOS;

	new
		triggeredCount = 0,
		page = pAntiCheatSettingsPage{playerid},
		next = 0,
		index = 0;

	dialog_string = "Название\tНаказание\tКол-во срабатываний\n";

	for (new i = 0; i < AC_MAX_CODES; i++) {
		if (i >= (page * AC_MAX_CODES_ON_PAGE)
		&& i < (page * AC_MAX_CODES_ON_PAGE) + AC_MAX_CODES_ON_PAGE)
			next++;

		if (i >= (page - 1) * AC_MAX_CODES_ON_PAGE
		&& i < ((page - 1) * AC_MAX_CODES_ON_PAGE) + AC_MAX_CODES_ON_PAGE) {
			triggeredCount = AC_CODE_TRIGGERED_COUNT[i];

			f(dialog_string,
				"%s"CT_ORANGE""T_NUM" "CT_WHITE"[%s] %s\t%s\t"CT_RED"%d\n",
				dialog_string,
				AC_CODE[i],
				AC_CODE_NAME[i],
				AC_TRIGGER_TYPE_NAME[AC_CODE_TRIGGER_TYPE[i]],
				triggeredCount);

			pAntiCheatSettingsMenuListData[playerid][index++] = i;
		}
	}
	if (next)
		strcat(dialog_string, ""AC_DIALOG_NEXT_PAGE_TEXT"\n");

	if (page > 1)
		strcat(dialog_string, AC_DIALOG_PREVIOUS_PAGE_TEXT);

	Dialog_Open(playerid, Dialog:ACSettings, DSTH, "Настройки античита", dialog_string, "Выбрать", "Отмена");
	return 1;
}

DialogResponse:ACSettings(playerid, response, listitem, inputtext[])
{
	if (!response) {
		pAntiCheatSettingsPage{playerid} = 0;
		return 1;
	}

	if (!strcmp(inputtext, AC_DIALOG_NEXT_PAGE_TEXT))
		pAntiCheatSettingsPage{playerid}++;

	else if (!strcmp(inputtext, AC_DIALOG_PREVIOUS_PAGE_TEXT))
		pAntiCheatSettingsPage{playerid}--;

	else {
		pAntiCheatSettingsEditCodeId[playerid] = pAntiCheatSettingsMenuListData[playerid][listitem];
		return Dialog_Show(playerid, Dialog:ACCheatEditCode);
	}
	return Dialog_Show(playerid, Dialog:ACSettings);
}

DialogCreate:ACCheatEditCode(playerid)
{
	new
		code = pAntiCheatSettingsEditCodeId[playerid],
		dialog_header[22 - 4 + AC_MAX_CODE_LENGTH + AC_MAX_CODE_NAME_LENGTH],
		dialog_string[AC_MAX_TRIGGER_TYPE_NAME_LENGTH*AC_MAX_TRIGGER_TYPES];

	f(dialog_header, "Код: %s | Название: %s", AC_CODE[code], AC_CODE_NAME[code]);

	for (new i = 0; i < AC_MAX_TRIGGER_TYPES; i++) {
		strcat(dialog_string, AC_TRIGGER_TYPE_NAME[i]);

		if (i + 1 != AC_MAX_TRIGGER_TYPES)
			strcat(dialog_string, "\n");
	}

	Dialog_Open(playerid, Dialog:ACCheatEditCode, DSL, dialog_header, dialog_string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:ACCheatEditCode(playerid, response, listitem, inputtext[])
{
	if (!response) {
		pAntiCheatSettingsEditCodeId[playerid] = -1;
		return Dialog_Show(playerid, Dialog:ACSettings);
	}

	new
		item = pAntiCheatSettingsEditCodeId[playerid];

	if (AC_CODE_TRIGGER_TYPE[item] == listitem)
		return Dialog_Show(playerid, Dialog:ACSettings);

	AC_CODE_TRIGGER_TYPE[item] = listitem;
	return Dialog_Show(playerid, Dialog:ACSettings);
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
	n_for(i, AC_MAX_CODES) {
		pAntiCheatLastCodeTriggerTime[playerid][i] = -1;
	}

	pAntiCheatSettingsPage{playerid} = 0;
	pAntiCheatSettingsEditCodeId[playerid] = -1;

	#if defined AntiC_OnPlayerConnect
		return AntiC_OnPlayerConnect(playerid);
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
#define OnPlayerConnect AntiC_OnPlayerConnect
#if defined AntiC_OnPlayerConnect
	forward AntiC_OnPlayerConnect(playerid);
#endif