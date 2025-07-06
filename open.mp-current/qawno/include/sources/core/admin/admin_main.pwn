/*
 * |>=====================<|
 * |   About: Admin main   |
 * |   Author: Foxze       |
 * |>=====================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- PC_OnInit()
	- OnPlayerConnect(playerid)
	- OnPlayerDisconnect(playerid, reason)
	- OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
	- OnPlayerCommandReceived(playerid, cmd[], params[], flags)

	# Technical #
	- CallTimerAdminUpdateSpec(playerid)
	- MySQLCreateNewAdmin(playerid)
	- MySQLCreateAdminBackpack(playerid)
	- MySQLAllListAdminsLoaded(playerid)
	- MySQLCheckPlayerBanned(playerid)
	- MySQLCheckBanned(playerid)
	- MySQLCheckListBannedPlayers(playerid)
	- MySQLCheckUnBanInfoPlayer(playerid)
	- MySQLCheckAdminUnWarn(playerid, const playerName[])
	- MySQLCheckAdminWarn(playerid, const playerName[])
	- MySQLCheckMakeAdminOff(playerid, const playerName[])
	- MySQLCheckStatsAdmin(playerid, const playerName[])
	- MySQLCheckUnWarnOffBanned(playerid, const playerName[])
	- MySQLCheckUnWarnOffIsPlayer(playerid, const playerName[])
	- MySQLCheckWarnOffBanned(playerid, const reason[], const playerName[])
	- MySQLCheckWarnOffAdmin(playerid, const reason[], const playerName[])
	- MySQLCheckWarnOffIsPlayer(playerid, const reason[], const playerName[])
	- MySQLCheckBanOffBanned(playerid, days, const reason[], const playerName[])
	- MySQLCheckBanOffAdmin(playerid, days, const reason[], const playerName[])
	- MySQLCheckBanOffIsPlayer(playerid, days, const reason[], const playerName[])
	- MySQLCheckUnBanPlayer(playerid, const playerName[])
	- MySQLCheckAdminReferals(playerid, const playerName[])
	- MySQLCheckPlayerForAdmin(playerid)
 * Stock:
	- SetAdminMySQLID(playerid, num)
	- GetAdminMySQLID(playerid)

	- SetAdminLevel(playerid, levelid)
	- GetAdminLevel(playerid)

	- GiveAdminReputation(playerid, reputations)
	- ResetAdminReputation(playerid)
	- GetAdminReputation(playerid)

	- SetAdminKey(playerid, const key[])
	- GetAdminKey(playerid)

	- GiveAdminReprimands(playerid, reprimands)
	- ResetAdminReprimands(playerid)
	- GetAdminReprimands(playerid)

	- GiveAdminKicks(playerid, kicks)
	- ResetAdminKicks(playerid)
	- GetAdminKicks(playerid)

	- GiveAdminBans(playerid, bans)
	- ResetAdminBans(playerid)
	- GetAdminBans(playerid)

	- GiveAdminUnBans(playerid, unbans)
	- ResetAdminUnBans(playerid)
	- GetAdminUnBans(playerid)

	- GiveAdminMuts(playerid, muts)
	- ResetAdminMuts(playerid)
	- GetAdminMuts(playerid)

	- GiveAdminUnMuts(playerid, unmuts)
	- ResetAdminUnMuts(playerid)
	- GetAdminUnMuts(playerid)

	- GiveAdminWarns(playerid, warns)
	- ResetAdminWarns(playerid)
	- GetAdminWarns(playerid)

	- GiveAdminUnWarns(playerid, unwarns)
	- ResetAdminUnWarns(playerid)
	- GetAdminUnWarns(playerid)

	- SetAdminRegDatetime(playerid, const datetime[])
	- GetAdminRegDatetime(playerid)

	- UpdatePlayerAdminData(playerid)
	- GetAdminVehicle(vehicleid)
	- UpdateAdminSpectating(playerid)
	- UpdateAdminTDSpec(playerid, spectedid)
	- SetAdminSpectating(playerid, bool:type)
	- GetAdminSpectating(playerid)
	- StopAdminsSpectating(playerid)
	- StopAdminSpectating(playerid, bool:remove = true)
	- IsAdminsSpecPlayer(playerid)
	- AddAdminCheater(playerid)
	- GetAdminLevel(playerid)
	- GetPlayersNotAdminsMode(modeid, sessionid)
	- CheckMySQLPlayerForAdmin(playerid)

	- MySQLUploadAdminData(playerid)
	- SetAdminORMData(playerid)
	- SavePlayerAdminData(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_ADMIN_INFO
	- E_ADMIN_CHEATER_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- amenu(playerid)
	- a(playerid, params[])
	- ot(playerid)
	- sp(playerid, params[])
	- offsp(playerid)
	- checkstats(playerid, params[])
	- aspawn(playerid, params[])
	- slap(playerid, params[])
	- jp(playerid)
	- admins(playerid)
	- adminstats(playerid)
	- asend(playerid, params[])
	- gethere(playerid, params[])
	- gotos(playerid, params[])
	- getip(playerid, params[])
	- getwarn(playerid, params[])
	- z(playerid, params[])
	- weap(playerid, params[])
	- fixveh(playerid)
	- fuelveh(playerid)
	- rfixveh(playerid, params[])
	- rfuelveh(playerid, params[])
	- kick(playerid, params[])
	- mute(playerid, params[])
	- unmute(playerid, params[])
	- sethp(playerid, params[])
	- setarmour(playerid, params[])
	- rsethp(playerid, params[])
	- rsetarmour(playerid, params[])
	- veh(playerid, params[])
	- delveh(playerid)
	- areferals(playerid, params[])
	- ban(playerid, params[])
	- unban(playerid, params[])
	- sban(playerid, params[])
	- banoff(playerid, params[])
	- skick(playerid, params[])
	- smute(playerid, params[])
	- sunmute(playerid, params[])
	- givegun(playerid, params[])
	- rgivegun(playerid, params[])
	- warn(playerid, params[])
	- unwarn(playerid, params[])
	- banlist(playerid)
	- setskin(playerid, params[])
	- rsetskin(playerid, params[])
	- aset(playerid, params[])
	- raset(playerid, params[])
	- clearchat(playerid)
	- warnoff(playerid, params[])
	- unwarnoff(playerid, params[])
	- givemoney(playerid, params[])
	- giverank(playerid, params[])
	- givemscore(playerid, params[])
	- adamage(playerid, params[])
	- astats(playerid, params[])
	- ao(playerid, params[])
	- promos(playerid)
	- acheat(playerid)
	- makeadmin(playerid, params[])
	- makeadminoff(playerid, params[])
	- awarn(playerid, params[])
	- aunwarn(playerid, params[])
	- changeservername(playerid, params[])
	- modes(playerid)
	- setitem(playerid, params[])
	- setbanner(playerid, params[])
	- givegold(playerid, params[])
	- givecheat(playerid, params[])
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- AdminLogin
	- AdminListBan
	- AdminUnBan
	- AdminCommands
	- AdminStats
	- AdminWarnPlayer
	- AdminKickPlayer
	- AdminBanPlayer
	- AdminOnline
	- AdminMenu
	- AdminServerOptions
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- AdminSpectate
 */

#if defined _INC_ADMIN_MAIN
	#endinput
#endif
#define _INC_ADMIN_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_ADMIN_INFO {
	// MySQL
	ORM:e_ORM_ID,
	e_ID,
	e_Level,
	e_Reputation,
	e_Key[ADM_MAX_LENGTH_KEY],
	e_Reprimands,
	e_Kicks,
	e_Bans,
	e_UnBans,
	e_Muts,
	e_UnMuts,
	e_Warns,
	e_UnWarns,
	e_RegDatetime[MAX_LENGTH_DATETIME]
}

enum E_ADMIN_CHEATER_INFO {
	e_TDCheat
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_ADMIN_INFO];

static
	DialogFirstBL[MAX_PLAYERS],
	DialogUnbanName[MAX_PLAYERS][MAX_PLAYER_NAME];

static
	TotalCheaters,
	Float:CheatersInfo[ADM_TD_MAX_CHEATERS][E_ADMIN_CHEATER_INFO],
	Text:TD_Cheaters[10];

static
	bool:ActiveAdminSpectating[MAX_PLAYERS char],
	PlayerText:TD_AdminSpectating[MAX_PLAYERS][ADMIN_TD_SPECTATING];

static
	AdminVehicleID[MAX_PLAYERS],
	bool:ActiveVehicleAdmin[MAX_VEHICLES char];

static
	strBig[2048];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>------------<|
 * |   ID MySQL   |
 * |>------------<|
 */

stock SetAdminMySQLID(playerid, num)
{
	pInfo[playerid][e_ID] = num;
	return 1;
}

stock GetAdminMySQLID(playerid)
{
	return pInfo[playerid][e_ID];
}

/*
 * |>---------<|
 * |   Level   |
 * |>---------<|
 */

stock SetAdminLevel(playerid, levelid)
{
	pInfo[playerid][e_Level] = levelid;
}

stock GetAdminLevel(playerid)
{
	return pInfo[playerid][e_Level];
}

/*
 * |>--------------<|
 * |   Reputation   |
 * |>--------------<|
 */

stock GiveAdminReputation(playerid, reputations)
{
	pInfo[playerid][e_Reputation] += reputations;
	return 1;
}

stock ResetAdminReputation(playerid)
{
    pInfo[playerid][e_Reputation] = 0;
    return 1;
}

stock GetAdminReputation(playerid)
{
	return pInfo[playerid][e_Reputation];
}

/*
 * |>-------<|
 * |   Key   |
 * |>-------<|
 */

stock SetAdminKey(playerid, const key[])
{
	strcopy(pInfo[playerid][e_Key], key, ADM_MAX_LENGTH_KEY);
	return 1;
}

stock GetAdminKey(playerid)
{
	new
		str[ADM_MAX_LENGTH_KEY];

	strcopy(str, pInfo[playerid][e_Key], ADM_MAX_LENGTH_KEY);
	return str;
}

/*
 * |>--------------<|
 * |   Reprimands   |
 * |>--------------<|
 */

stock GiveAdminReprimands(playerid, reprimands)
{
	pInfo[playerid][e_Reprimands] += reprimand;
	return 1;
}

stock ResetAdminReprimands(playerid)
{
    pInfo[playerid][e_Reprimands] = 0;
    return 1;
}

stock GetAdminReprimands(playerid)
{
	return pInfo[playerid][e_Reprimands];
}

/*
 * |>---------<|
 * |   Kicks   |
 * |>---------<|
 */

stock GiveAdminKicks(playerid, kicks)
{
	pInfo[playerid][e_Kicks] += kicks;
	return 1;
}

stock ResetAdminKicks(playerid)
{
    pInfo[playerid][e_Kicks] = 0;
    return 1;
}

stock GetAdminKicks(playerid)
{
	return pInfo[playerid][e_Kicks];
}

/*
 * |>--------<|
 * |   Bans   |
 * |>--------<|
 */

stock GiveAdminBans(playerid, bans)
{
	pInfo[playerid][e_Bans] += bans;
	return 1;
}

stock ResetAdminBans(playerid)
{
    pInfo[playerid][e_Bans] = 0;
    return 1;
}

stock GetAdminBans(playerid)
{
	return pInfo[playerid][e_Bans];
}

/*
 * |>----------<|
 * |   UnBans   |
 * |>----------<|
 */

stock GiveAdminUnBans(playerid, unbans)
{
	pInfo[playerid][e_UnBans] += unbans;
	return 1;
}

stock ResetAdminUnBans(playerid)
{
    pInfo[playerid][e_UnBans] = 0;
    return 1;
}

stock GetAdminUnBans(playerid)
{
	return pInfo[playerid][e_UnBans];
}

/*
 * |>--------<|
 * |   Muts   |
 * |>--------<|
 */

stock GiveAdminMuts(playerid, muts)
{
	pInfo[playerid][e_Muts] += muts;
	return 1;
}

stock ResetAdminMuts(playerid)
{
    pInfo[playerid][e_Muts] = 0;
    return 1;
}

stock GetAdminMuts(playerid)
{
	return pInfo[playerid][e_Muts];
}

/*
 * |>----------<|
 * |   UnMuts   |
 * |>----------<|
 */

stock GiveAdminUnMuts(playerid, unmuts)
{
	pInfo[playerid][e_UnMuts] += unmuts;
	return 1;
}

stock ResetAdminUnMuts(playerid)
{
    pInfo[playerid][e_UnMuts] = 0;
    return 1;
}

stock GetAdminUnMuts(playerid)
{
	return pInfo[playerid][e_UnMuts];
}

/*
 * |>---------<|
 * |   Warns   |
 * |>---------<|
 */

stock GiveAdminWarns(playerid, warns)
{
	pInfo[playerid][e_Warns] += warns;
	return 1;
}

stock ResetAdminWarns(playerid)
{
    pInfo[playerid][e_Warns] = 0;
    return 1;
}

stock GetAdminWarns(playerid)
{
	return pInfo[playerid][e_Warns];
}

/*
 * |>---------<|
 * |   Warns   |
 * |>---------<|
 */

stock GiveAdminUnWarns(playerid, unwarns)
{
	pInfo[playerid][e_UnWarns] += unwarns;
	return 1;
}

stock ResetAdminUnWarns(playerid)
{
    pInfo[playerid][e_UnWarns] = 0;
    return 1;
}

stock GetAdminUnWarns(playerid)
{
	return pInfo[playerid][e_UnWarns];
}

/*
 * |>------------<|
 * |   Datetime   |
 * |>------------<|
 */

stock SetAdminRegDatetime(playerid, const datetime[])
{
	strcopy(pInfo[playerid][e_RegDatetime], datetime, MAX_LENGTH_DATETIME);
	return 1;
}

stock GetAdminRegDatetime(playerid)
{
	new
		str[MAX_LENGTH_DATETIME];

	strcopy(str, pInfo[playerid][e_RegDatetime], MAX_LENGTH_DATETIME);
	return str;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

stock UpdatePlayerAdminData(playerid)
{
	UpdatePlayerReportData(playerid);
	return 1;
}

stock GetAdminVehicle(vehicleid)
{
	return ActiveVehicleAdmin{vehicleid};
}

stock UpdateAdminSpectating(playerid)
{
	SetPlayerTimer(playerid, "CallTimerAdminUpdateSpec", 300, false);
	return 1;
}

stock UpdateAdminTDSpec(playerid, spectedid)
{
	PlayerTextDrawSetString(playerid, TD_AdminSpectating[playerid][15], "%s_"T_PID"", GetPlayerNameEx(spectedid), spectedid);
	PlayerTextDrawSetString(playerid, TD_AdminSpectating[playerid][16], "Mode/Session:_%s/%i", Mode_GetShortName(Mode_GetPlayerMode(spectedid)), Mode_GetPlayerSession(spectedid));

	new
		Float:health, Float:armour,
		weaponName[MAX_LENGTH_WEAPON_NAME];

	GetPlayerHealth(spectedid, health);
	GetPlayerArmour(spectedid, armour);
	GetWeaponName(GetPlayerWeapon(spectedid), weaponName, MAX_LENGTH_WEAPON_NAME);

	PlayerTextDrawSetString(playerid, TD_AdminSpectating[playerid][17], "Health/Armour:_%.0f/%.0f", health, armour);
	PlayerTextDrawSetString(playerid, TD_AdminSpectating[playerid][18], "Speed:_%i", GetPlayerSpeed(spectedid));
	PlayerTextDrawSetString(playerid, TD_AdminSpectating[playerid][19], "Weapon:_%s", weaponName);
	PlayerTextDrawSetString(playerid, TD_AdminSpectating[playerid][20], "Ammo:_%i", GetPlayerAmmo(spectedid));
	PlayerTextDrawSetString(playerid, TD_AdminSpectating[playerid][21], "Warns:_%i", GetPlayerWarns(playerid));
	PlayerTextDrawSetString(playerid, TD_AdminSpectating[playerid][22], "Ping:_%i", GetPlayerPing(spectedid));
	PlayerTextDrawSetString(playerid, TD_AdminSpectating[playerid][23], "FPS:_%i", GetPlayerFPS(spectedid));
	return 1;
}

stock SetAdminSpectating(playerid, bool:type)
{
	ActiveAdminSpectating{playerid} = type;
	return 1;
}

stock GetAdminSpectating(playerid)
{
	return ActiveAdminSpectating{playerid};
}

stock StopAdminsSpectating(playerid)
{
	Iter_Clear(AdminCountSpecPlayer[playerid]);
	return 1;
}

stock StopAdminSpectating(playerid, bool:remove = true)
{
	if (remove) {
		if (Iter_Count(AdminCountSpecPlayer[GetPlayerSpectating(playerid)])) {
			Iter_Remove(AdminCountSpecPlayer[GetPlayerSpectating(playerid)], playerid);
		}
	}

	SetPlayerSpectating(playerid, INVALID_PLAYER_ID);
	SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_INVALID);

	Mode_LeavePlayer(playerid);

	SetAdminSpectating(playerid, false);
	SetPlayerCanSpectating(playerid, false);

	Interface_Close(playerid, Interface:AdminSpectate);

	SpecPl(playerid, false);
	Mode_EnterPlayer(playerid, MODE_NONE, playerid);
	return 1;
}

stock IsAdminsSpecPlayer(playerid)
{
	if (Iter_Count(AdminCountSpecPlayer[playerid])) {
		return 1;
	}
	return 0;
}

stock AddAdminCheater(playerid)
{
	if (pInfo[playerid][e_Level])
		return 0;

	n_for(i, ADM_TD_MAX_CHEATERS) {
		if (CheatersInfo[i][e_TDCheat] == playerid)
			return 0;
	}
	CheatersInfo[TotalCheaters][e_TDCheat] = playerid;

	TextDrawSetString(TD_Cheaters[TotalCheaters], "%i", playerid);

	TotalCheaters++;

	if (TotalCheaters > 9)
		TotalCheaters = 0;
	
	return 1;
}

public: CallTimerAdminUpdateSpec(playerid)
{
	foreach (new p:AdminCountSpecPlayer[playerid]) {
		if (GetPlayerVehicleIDEx(playerid) != INVALID_VEHICLE_ID) {
			SetPlayerSpecStatus(p, PLAYER_SPECTATE_PLAYER);
			PlayerSpectateVehicle(p, GetPlayerVehicleID(playerid));
		}
		else {
			SetPlayerSpecStatus(p, PLAYER_SPECTATE_VEHICLE);
			PlayerSpectatePlayer(p, playerid);
		}	
	}
	return 1;
}

public: MySQLAllListAdminsLoaded(playerid)
{
	new
		totalMembers = cache_num_rows();

	if (totalMembers) {
		static
			bigstring[1500];

		bigstring[0] = EOS;

		new
			string[100],
			admin,
			membername[MAX_PLAYER_NAME],
			accountid,
			Data[50];

		if (strlen(bigstring) < 1)
			strcat(bigstring, ""CT_GREY"№\tУровень адм.\tНик\t\t\t\tДата поступления\n\n"CT_WHITE"");

		n_for(i, totalMembers) {
			cache_get_value_name(i, DB_ADMINS_NICKNAME, membername, MAX_PLAYER_NAME);
			cache_get_value_name_int(i, DB_ADMINS_LEVEL, admin);
			cache_get_value_name(i, DB_ADMINS_REG_DATETIME, Data);
			cache_get_value_name_int(i, DB_ADMINS_ID, accountid);

			f(bigstring, "%s%d\t%d\t\t%s\t\t\t%s\n", bigstring, accountid, admin, membername, Data);
		}
		f(string, ""CT_WHITE"Всего "CT_YELLOW"%d "CT_WHITE"администраторов", totalMembers);
		Dialog_Message(playerid, string, bigstring, "Хорошо");
	}
	else {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Администраторы не найдены.");
		Dialog_Show(playerid, Dialog:AdminMenu);
	}
	return 1;
}

stock GetPlayersNotAdminsMode(modeid, sessionid)
{
	new
		players;

	m_for(modeid, sessionid, p) {
		if (GetAdminSpectating(p)) {
			continue;
		}

		players++;
	}
	return players;
}

stock CheckMySQLPlayerForAdmin(playerid)
{
	static
		queryFormat[] = "SELECT * FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'";

	new
		query[sizeof(queryFormat) - 2 + MAX_PLAYER_NAME];

	mysql_format(MySQLID, query, sizeof(query), queryFormat, GetPlayerNameEx(playerid));
	mysql_tquery(MySQLID, query, "MySQLCheckPlayerForAdmin", "d", playerid);
	return 0;
}

static SetPlayerBan(const playerName[], const adminName[], const days, const reason[])
{
	SQL("INSERT INTO `"DB_BANS"` (`"DB_BANS_PLAYER_NICKNAME"`, `"DB_BANS_ADMIN_NICKNAME"`, `"DB_BANS_REASON"`, `"DB_BANS_UNBAN_DATETIME"`) VALUES ('%s', '%s', %s, '%s')", playerName, adminName, reason, AddToDatetime(GetCurrentDatetime(), .days = days));
	return 1;
}

static CheckBanned(playerid, listitem)
{
	if (listitem == 20) {
		DialogFirstBL[playerid] += 20;
	}
	else {
		DialogFirstBL[playerid] -= 20;
	}

	if (DialogFirstBL[playerid] < 0) {
		DialogFirstBL[playerid] = 0;

		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Больше нет забаненных");
		Dialog_Show(playerid, Dialog:AdminMenu);
		return 1;
	}

	static const
		queryFormat[] = "SELECT `"DB_BANS_PLAYER_NICKNAME"` FROM `"DB_BANS"` ORDER BY `"DB_BANS_ID"` DESC LIMIT %i , 20";

	new
		query[sizeof(queryFormat) - 2 + MAX_LENGTH_NUM];

	mysql_format(MySQLID, query, sizeof(query), queryFormat, DialogFirstBL[playerid]);
	mysql_tquery(MySQLID, query, "MySQLCheckBanned", "d", playerid);
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetAdminData(playerid)
{
	pInfo[playerid][e_ORM_ID]		= ORM:0;
	pInfo[playerid][e_ID]			= -1;

	pInfo[playerid][e_Level]		=
	pInfo[playerid][e_Reputation]	=
	pInfo[playerid][e_Reprimands]	=
	pInfo[playerid][e_Kicks]		=
	pInfo[playerid][e_Bans]			=
	pInfo[playerid][e_UnBans]		=
	pInfo[playerid][e_Muts]			=
	pInfo[playerid][e_UnMuts]		=
	pInfo[playerid][e_Warns]		=
	pInfo[playerid][e_UnWarns]		= 0;

	pInfo[playerid][e_Key][0]			=
	pInfo[playerid][e_RegDatetime][0]	= EOS;
	return 1;
}

static ResetAdminTDs(playerid)
{
	n_for(i, ADMIN_TD_SPECTATING) {
		TD_AdminSpectating[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	return 1;
}

/*
 * |>-------------<|
 * |     MySQL     |
 * |>-------------<|
 */

stock MySQLUploadAdminData(playerid)
{
	cache_get_value_name_int(0, DB_ADMINS_LEVEL, pInfo[playerid][e_Level]);
	cache_get_value_name_int(0, DB_ADMINS_REPUTATION, pInfo[playerid][e_Reputation]);
	cache_get_value_name(0, DB_ADMINS_KEY, pInfo[playerid][e_Key], ADM_MAX_LENGTH_KEY);
	cache_get_value_name_int(0, DB_ADMINS_REPRIMANDS, pInfo[playerid][e_Reprimands]);
	cache_get_value_name_int(0, DB_ADMINS_KICKS, pInfo[playerid][e_Kicks]);
	cache_get_value_name_int(0, DB_ADMINS_BANS, pInfo[playerid][e_Bans]);
	cache_get_value_name_int(0, DB_ADMINS_UNBANS, pInfo[playerid][e_UnBans]);
	cache_get_value_name_int(0, DB_ADMINS_MUTS, pInfo[playerid][e_Muts]);
	cache_get_value_name_int(0, DB_ADMINS_UNMUTS, pInfo[playerid][e_UnMuts]);
	cache_get_value_name_int(0, DB_ADMINS_WARNS, pInfo[playerid][e_Warns]);
	cache_get_value_name_int(0, DB_ADMINS_UNWARNS, pInfo[playerid][e_UnWarns]);
	cache_get_value_name(0, DB_ADMINS_REG_DATETIME, pInfo[playerid][e_RegDatetime], MAX_LENGTH_DATETIME);
	cache_get_value_name_int(0, DB_ADMINS_ID, pInfo[playerid][e_ID]);
	return 1;
}

public: MySQLCreateAdminBackpack(playerid)
{
	pInfo[playerid][e_ID] = cache_insert_id();
}

stock SetAdminORMData(playerid)
{
	pInfo[playerid][e_ORM_ID] = orm_create(DB_ADMINS);

	new
		ORM:orm = pInfo[playerid][e_ORM_ID];
	
	orm_addvar_int(orm, pInfo[playerid][e_ID], DB_ADMINS_ID);

	orm_addvar_int(orm, pInfo[playerid][e_Level], DB_ADMINS_LEVEL);
	orm_addvar_int(orm, pInfo[playerid][e_Reputation], DB_ADMINS_REPUTATION);
	orm_addvar_int(orm, pInfo[playerid][e_Reprimands], DB_ADMINS_REPRIMANDS);
	orm_addvar_int(orm, pInfo[playerid][e_Kicks], DB_ADMINS_KICKS);
	orm_addvar_int(orm, pInfo[playerid][e_Bans], DB_ADMINS_BANS);
	orm_addvar_int(orm, pInfo[playerid][e_UnBans], DB_ADMINS_UNBANS);
	orm_addvar_int(orm, pInfo[playerid][e_Muts], DB_ADMINS_MUTS);
	orm_addvar_int(orm, pInfo[playerid][e_UnMuts], DB_ADMINS_UNMUTS);
	orm_addvar_int(orm, pInfo[playerid][e_Warns], DB_ADMINS_WARNS);
	orm_addvar_int(orm, pInfo[playerid][e_UnWarns], DB_ADMINS_UNWARNS);

	orm_setkey(orm, DB_ADMINS_ID);
	return 1;
}

stock SavePlayerAdminData(playerid)
{
	if (pInfo[playerid][e_ORM_ID] != ORM:0) {
		orm_update(pInfo[playerid][e_ORM_ID]);
	}
	return 1;
}

public: MySQLCreateNewAdmin(playerid)
{
	if (GetAdminLevel(playerid) == ADM_LEVEL_NONE) {
		if (cache_num_rows()) {
			SQL("DELETE FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", GetPlayerNameEx(playerid));

			ResetAdminData(playerid);
			Iter_Remove(TotalAdmins, playerid);

			orm_destroy(pInfo[playerid][e_ORM_ID]);

			Mode_ReduceAdmin(Mode_GetPlayerMode(playerid), Mode_GetPlayerSession(playerid));
		}
		return 1;
	}

	if (!cache_num_rows()) {
		strcopy(pInfo[playerid][e_Key], GeneratePassword(4), ADM_MAX_LENGTH_KEY);
		SetAdminRegDatetime(playerid, GetCurrentDatetime());

		static const
			queryFormat[] = "\
			INSERT INTO \
			`"DB_ADMINS"` \
			(\
			`"DB_ADMINS_NICKNAME"`, \
			`"DB_ADMINS_KEY"`, \
			`"DB_ADMINS_LEVEL"`, \
			`"DB_ADMINS_REG_DATETIME"`\
			) \
			VALUES \
			(\
			'%s',\
			'%s',\
			'%i',\
			'%s'\
			)";

		new
			query[sizeof(queryFormat) - 8 + MAX_PLAYER_NAME + ADM_MAX_LENGTH_KEY + MAX_LENGTH_NUM + MAX_LENGTH_DATETIME];

		mysql_format(MySQLID, query, sizeof(query), queryFormat,
		GetPlayerNameEx(playerid),
		pInfo[playerid][e_Key],
		pInfo[playerid][e_Level],
		pInfo[playerid][e_RegDatetime]);

		mysql_tquery(MySQLID, query, "MySQLCreateAdminBackpack", "i", playerid);

		GivePlayerInvItem(playerid, 399, 1);
		GivePlayerInvItem(playerid, 407, 1);
		GivePlayerInvItem(playerid, 277, 1);
		GivePlayerInvItem(playerid, 278, 1);
		GivePlayerInvItem(playerid, 279, 1);

		Iter_Add(TotalAdmins, playerid);

		SetAdminORMData(playerid);

		Mode_AddAdmin(Mode_GetPlayerMode(playerid), Mode_GetPlayerSession(playerid));

		SCM(playerid, C_RED, ""T_PASS" "CT_WHITE"Ваш личный пароль для администрирования: "CT_RED"%s (запомните его и сделайте скриншот на F8)", pInfo[playerid][e_Key]);
		return 1;
	}

	SQL("UPDATE `"DB_ADMINS"` SET `"DB_ADMINS_LEVEL"` = '%i' WHERE `"DB_ADMINS_ID"` = '%i'", GetAdminLevel(playerid), GetAdminMySQLID(playerid));
	return 1;
}

public: MySQLCheckListBannedPlayers(playerid)
{
	new
		accounts = cache_num_rows();

	if (!accounts) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Список забаненных пуст");
		Dialog_Show(playerid, Dialog:AdminMenu);
		return 1;
	}

	new
		playerName[MAX_PLAYER_NAME];
	
	n_for(i, accounts) {
		cache_get_value_name(i, DB_BANS_PLAYER_NICKNAME, playerName, MAX_PLAYER_NAME);
		f(strBig, "%s%s\n", strBig, playerName);
	}

	if (accounts == 20) {
		f(strBig, "%s"CT_GREY">>>\n", strBig);
	}

	Dialog_Show(playerid, Dialog:AdminListBan);
	return 1;
}

public: MySQLCheckUnBanInfoPlayer(playerid)
{
	if (!cache_num_rows()) {
		SCM(playerid, C_WHITE, "Игрок "CT_YELLOW"%s "CT_WHITE"не забанен", DialogUnbanName[playerid]);
		return 1;
	}

	new
		adminName[MAX_PLAYER_NAME],
		reason[MAX_LENGTH_ADM_REASON],
		unbanDatetime[MAX_LENGTH_DATETIME];

	cache_get_value_name(0, DB_BANS_ADMIN_NICKNAME, adminName, MAX_PLAYER_NAME);
	cache_get_value_name(0, DB_BANS_REASON, reason, MAX_LENGTH_ADM_REASON);
	cache_get_value_name(0, DB_BANS_UNBAN_DATETIME, unbanDatetime, MAX_LENGTH_DATETIME);

	new
		str[300];

	f(str, ""CT_WHITE"Админ: \t"CT_YELLOW"%s\
	\n"CT_WHITE"Причина: \t"CT_RED"%s\
	\n"CT_WHITE"Дата разблокировки: \t{FF0000}%s", adminName, reason, ShowDatetimeForPlayer(playerid, unbanDatetime));

	Dialog_Open(playerid, Dialog:AdminUnBan, DSM, DialogUnbanName[playerid], str, "Разбан", "Отмена");
	return 1;
}

public: MySQLCheckAdminUnWarn(playerid, const playerName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный игрок не администратор.");
		return 1;
	}

	new
		IDMySQL,
		adminReprimands;

	cache_get_value_name_int(0, DB_ADMINS_REPRIMANDS, adminReprimands);
	cache_get_value_name_int(0, DB_ADMINS_ID, IDMySQL);

	if (adminReprimands > 0) {
		adminReprimands--;

		SQL("UPDATE `"DB_ADMINS"` SET `"DB_ADMINS_REPRIMANDS"` = '%i' WHERE `"DB_ADMINS_ID"` = '%i'", adminReprimands, IDMySQL);

		new 
			player = GetNameID(playerName);

		if (player != INVALID_PLAYER_ID) {
			pInfo[player][e_Reprimands]++;
			SCM(player, C_CARMINE, "Администратор %s убрал вам выговор [%i из 3]", GetPlayerNameEx(playerid), adminReprimands);
		}
		SCM(playerid, C_CARMINE, "Администратору %s убран выговор [%i из 3]", playerName, adminReprimands);
	}
	return 1;
}

public: MySQLCheckAdminWarn(playerid, const playerName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный игрок не администратор.");
		return 1;
	}

	new
		IDMySQL,
		adminReprimands;

	cache_get_value_name_int(0, DB_ADMINS_REPRIMANDS, adminReprimands);
	cache_get_value_name_int(0, DB_ADMINS_ID, IDMySQL);

	adminReprimands++;

	SQL("UPDATE `"DB_ADMINS"` SET `"DB_ADMINS_REPRIMANDS"` = '%i' WHERE `"DB_ADMINS_ID"` = '%i'", adminReprimands, IDMySQL);

	new
		player = GetNameID(playerName);
	
	if (player != INVALID_PLAYER_ID) {
		pInfo[player][e_Reprimands]++;
		SCM(player, C_CARMINE, "Администратор %s выдал вам выговор [%i из 3]", GetPlayerNameEx(playerid), adminReprimands);
	}
	SCM(playerid, C_CARMINE, "Администратору %s выдан выговор [%i из 3]", playerName, adminReprimands);

	if (adminReprimands >= 3) {
		SCM(playerid, C_CARMINE, "У администратора %s выговоров уже [%i из 3] уберите его с админки", playerName, adminReprimands);
	}
	return 1;
}

public: MySQLCheckMakeAdminOff(playerid, const playerName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не найден.");
		return 1;
	}

	new
		IDMySQL,
		adminLevel;

	cache_get_value_name_int(0, DB_ADMINS_LEVEL, adminLevel);
	cache_get_value_name_int(0, DB_ADMINS_ID, IDMySQL);

	if (adminLevel > 0) {
		SQL("DELETE FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", playerName);
		SCM(playerid, C_CARMINE, "Игроку %s сняты админ права.", playerName);
	}
	return 1;
}

public: MySQLCheckStatsAdmin(playerid, const playerName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не найден.");
		return 1;
	}

	new 
		level,
		reputation,
		reprimands,
		kicks,
		bans,
		unbans,
		muts,
		unmuts,
		warns,
		unwarns,
		adatetime[MAX_LENGTH_DATETIME],
		id;

	cache_get_value_name_int(0, DB_ADMINS_LEVEL, level);
	cache_get_value_name_int(0, DB_ADMINS_REPUTATION, reputation);
	cache_get_value_name_int(0, DB_ADMINS_REPRIMANDS, reprimands);
	cache_get_value_name_int(0, DB_ADMINS_KICKS, kicks);
	cache_get_value_name_int(0, DB_ADMINS_BANS, bans);
	cache_get_value_name_int(0, DB_ADMINS_UNBANS, unbans);
	cache_get_value_name_int(0, DB_ADMINS_MUTS, muts);
	cache_get_value_name_int(0, DB_ADMINS_UNMUTS, unmuts);
	cache_get_value_name_int(0, DB_ADMINS_WARNS, warns);
	cache_get_value_name_int(0, DB_ADMINS_UNWARNS, unwarns);
	cache_get_value_name(0, DB_ADMINS_REG_DATETIME, adatetime, MAX_LENGTH_DATETIME);
	cache_get_value_name_int(0, DB_ADMINS_ID, id);

	static
		str[1500];

	str[0] = EOS;

	f(str, ""CT_GREY"Админ: "CT_YELLOW"[%s]\
	\n\n"CT_GREY"Уровень: "CT_WHITE"[%i] (%s)\
	\n"CT_GREY"Репутация: "CT_WHITE"[%i]\
	\n"CT_GREY"Выговоров: "CT_WHITE"[%i]\
	\n"CT_GREY"Кикнуто: "CT_WHITE"[%i]\
	\n"CT_GREY"Забанено: "CT_WHITE"[%i]\
	\n"CT_GREY"Разбанено: "CT_WHITE"[%i]\
	\n"CT_GREY"Мутов: "CT_WHITE"[%i]\
	\n"CT_GREY"Убрано мутов: "CT_WHITE"[%i]\
	\n"CT_GREY"Варнов: "CT_WHITE"[%i]\
	\n"CT_GREY"Убрано варнов: "CT_WHITE"[%i]\
	\n"CT_GREY"Дата выдачи админ прав: "CT_WHITE"[%s]", playerName, level, GetAdminLevelName(level), reputation, reprimands, kicks, bans, unbans, muts, unmuts, warns, unwarns, adatetime);
	Dialog_Message(playerid, "Статистика администратора", str, "Закрыть");
	return 1;
}

public: MySQLCheckUnWarnOffBanned(playerid, const playerName[])
{
	if (cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный игрок забанен.");
		return 1;
	}

	new
		query[150];
	
	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ACCOUNTS"` WHERE BINARY `"DB_ACCOUNTS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckUnWarnOffIsPlayer", "is["MAX_STR_PLAYER_NAME"]", playerid, playerName);
	return 1;
}

public: MySQLCheckUnWarnOffIsPlayer(playerid, const playerName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не найден.");
		return 1;
	}

	new
		IDMySQL,
		Warns;

	cache_get_value_name_int(0, DB_ACCOUNTS_WARNS, Warns);
	cache_get_value_name_int(0, DB_ACCOUNTS_ID, IDMySQL);

	if (Warns > 0) {
		Warns--;
		SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_WARNS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", Warns, IDMySQL);

		pInfo[playerid][e_Warns]++;
		SCM(playerid, C_CARMINE, "Игроку %s снято предупреждение [%i из 3]", playerName, Warns);
	}
	return 1;
}

public: MySQLCheckWarnOffBanned(playerid, const reason[], const playerName[])
{
	if (cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный игрок забанен.");
		return 1;
	}

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckWarnOffAdmin", "is["MAX_STR_ADM_REASON"]s["MAX_STR_PLAYER_NAME"]", playerid, reason, playerName);
	return 1;
}

public: MySQLCheckWarnOffAdmin(playerid, const reason[], const playerName[])
{
	if (cache_num_rows()) {
		new
			adminLevel;

		cache_get_value_name_int(0, DB_ADMINS_LEVEL, adminLevel);
		
		if (pInfo[playerid][e_Level] < adminLevel) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный администратор выше вас по должности.");
			return 1;
		}
	}

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ACCOUNTS"` WHERE BINARY `"DB_ACCOUNTS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckWarnOffIsPlayer", "is["MAX_STR_ADM_REASON"]s["MAX_STR_PLAYER_NAME"]", playerid, reason, playerName);
	return 1;
}

public: MySQLCheckWarnOffIsPlayer(playerid, const reason[], const playerName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не найден.");
		return 1;
	}

	new
		IDMySQL,
		Warns;

	cache_get_value_name_int(0, DB_ACCOUNTS_WARNS, Warns);
	cache_get_value_name_int(0, DB_ACCOUNTS_ID, IDMySQL);

	if (Warns != 3) {
		Warns++;
		SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_WARNS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", Warns, IDMySQL);

		pInfo[playerid][e_Warns]++;
		SCM(playerid, C_CARMINE, "Игроку %s выдано предупреждение [%i из 3]. Причина: %s", playerName, Warns, reason);
	}
	if (Warns >= 3) {
		Warns = 0;
		SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_WARNS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", Warns, IDMySQL);

		SetPlayerBan(playerName, GetPlayerNameEx(playerid), 3, "Warns: 3");
	}
	return 1;
}

public: MySQLCheckBanOffBanned(playerid, days, const reason[], const playerName[])
{
	if (cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный игрок уже забанен.");
		return 1;
	}

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckBanOffAdmin", "iis["MAX_STR_ADM_REASON"]s["MAX_STR_PLAYER_NAME"]", playerid, days, reason, playerName);
	return 1;
}

public: MySQLCheckBanOffAdmin(playerid, days, const reason[], const playerName[])
{
	if (cache_num_rows()) {
		new
			adminLevel;

		cache_get_value_name_int(0, DB_ADMINS_LEVEL, adminLevel);
		if (pInfo[playerid][e_Level] < adminLevel) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный администратор выше вас по должности.");
			return 1;
		}
	}

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ACCOUNTS"` WHERE BINARY `"DB_ACCOUNTS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckBanOffIsPlayer", "iis["MAX_STR_ADM_REASON"]s["MAX_STR_PLAYER_NAME"]", playerid, days, reason, playerName);
	return 1;
}

public: MySQLCheckBanOffIsPlayer(playerid, days, const reason[], const playerName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не найден.");
		return 1;
	}

	pInfo[playerid][e_Bans]++;
	SCM(playerid, C_CARMINE, "Игрок %s забанен на %i дней. Причина: %s", playerName, days, reason);
	SetPlayerBan(playerName, GetPlayerNameEx(playerid), days, reason);
	return 1;
}

public: MySQLCheckUnBanPlayer(playerid, const playerName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный игрок не забанен.");
		return 1;
	}

	mysql_escape_string(playerName, DialogUnbanName[playerid], MAX_PLAYER_NAME);
	Dialog_Show(playerid, Dialog:AdminUnBan);
	return 1;
}

public: MySQLCheckAdminReferals(playerid, const playerName[])
{
	if (!cache_num_rows()) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не найден.");
	}
	else {
		SetCheckNameReferal(playerid, playerName);
		Dialog_Show(playerid, Dialog:ListReferals);
	}
	return 1;
}

public: MySQLCheckPlayerForAdmin(playerid)
{
	if (cache_num_rows()) {
		TogglePlayerControllable(playerid, false);
		MySQLUploadAdminData(playerid);
		Dialog_Show(playerid, Dialog:AdminLogin);
		SetPlayerLoggedTimer(playerid, 60000);
	}
	else {
		ConnectPlayerServer(playerid);
	}
	return 1;
}

public: MySQLCheckPlayerBanned(playerid)
{
	if (!cache_num_rows()) {
		return 1;
	}

	SQL("DELETE FROM `"DB_BANS"` WHERE BINARY `"DB_BANS_PLAYER_NICKNAME"` = '%s'", DialogUnbanName[playerid]);

	SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Игрок разбанен!");
	pInfo[playerid][e_UnBans]++;
	return 1;
}

public: MySQLCheckBanned(playerid)
{
	new
		name[MAX_PLAYER_NAME],
		accounts;

	accounts = cache_num_rows();

	if (!accounts) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Больше нет забаненных");
		return 1;
	}

	n_for(i, accounts) {
		cache_get_value_name(0, DB_ADMINS_NICKNAME, name, MAX_PLAYER_NAME);
		f(strBig, "%s%s\n", strBig, name);
	}

	if (accounts == 20) {
		strcat(strBig, ""CT_GREY"Далее >>>\n");
	}

	if (DialogFirstBL[playerid]) {
		strcat(strBig, ""CT_GREY"<<< Назад");
	}
	Dialog_Show(playerid, Dialog:AdminListBan);
	return 1;
}

/*
 * |>----------------<|
 * |     Commands     |
 * |>----------------<|
 */

// Test

CMD:admintest(playerid)
{
	pInfo[playerid][e_Level] = ADM_LEVEL_FOUNDER;

	new
		str[39 - 2 + DB_MAX_LENGTH_TABLE_NAME + DB_MAX_LENGTH_FIELD_NAME + MAX_PLAYER_NAME + 1];

	mysql_format(MySQLID, str, sizeof(str), "SELECT * FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", GetPlayerNameEx(playerid));
	mysql_tquery(MySQLID, str, "MySQLCreateNewAdminTEST", "i", playerid);

	SCM(playerid, C_CARMINE, "АДМИНКА ВЫДАНА!");
	return 1;
}

public: MySQLCreateNewAdminTEST(playerid)
{
	if (!cache_num_rows()) {
		strcopy(pInfo[playerid][e_Key], GeneratePassword(4), ADM_MAX_LENGTH_KEY);
		SetAdminRegDatetime(playerid, GetCurrentDatetime());

		static const
			queryFormat[] = "\
			INSERT INTO \
			`"DB_ADMINS"` \
			(\
			`"DB_ADMINS_NICKNAME"`, \
			`"DB_ADMINS_KEY"`, \
			`"DB_ADMINS_LEVEL"`, \
			`"DB_ADMINS_REG_DATETIME"`\
			) \
			VALUES \
			(\
			'%s',\
			'%s',\
			'%i',\
			'%s'\
			)";

		new
			query[sizeof(queryFormat) - 8 + MAX_PLAYER_NAME + ADM_MAX_LENGTH_KEY + MAX_LENGTH_NUM + MAX_LENGTH_DATETIME];

		mysql_format(MySQLID, query, sizeof(query), queryFormat,
		GetPlayerNameEx(playerid),
		pInfo[playerid][e_Key],
		pInfo[playerid][e_Level],
		pInfo[playerid][e_RegDatetime]);

		mysql_tquery(MySQLID, query, "MySQLCreateAdminBackpack", "i", playerid);

		GivePlayerInvItem(playerid, 399, 1);
		GivePlayerInvItem(playerid, 407, 1);
		GivePlayerInvItem(playerid, 277, 1);
		GivePlayerInvItem(playerid, 278, 1);
		GivePlayerInvItem(playerid, 279, 1);

		Iter_Add(TotalAdmins, playerid);

		SetAdminORMData(playerid);

		Mode_AddAdmin(Mode_GetPlayerMode(playerid), Mode_GetPlayerSession(playerid));

		SCM(playerid, C_RED, ""T_PASS" "CT_WHITE"Ваш личный пароль для администрирования: "CT_RED"%s (запомните его и сделайте скриншот на F8)", pInfo[playerid][e_Key]);
	}
	return 1;
}

CMD:amenu(playerid)
{
	Dialog_Show(playerid, Dialog:AdminMenu);
	return 1;
}

CMD:a(playerid, params[])
{
	if (sscanf(params, "s[150]", params[0])) {
		return SendPlayerMessageCMD(playerid, "/a [текст]");
	}

	SendAdminsMessage(C_CARMINE, "[A]: [%s] %s "T_PID": %s", GetAdminLevelName(pInfo[playerid][e_Level]), GetPlayerNameEx(playerid), playerid, params[0]);
	return 1;
}

CMD:sp(playerid, params[])
{
	new
		playerSpec;

	if (sscanf(params, "u", playerSpec)) {
		return SendPlayerMessageCMD(playerid, "/sp [id игрока]");
	}

	if (!IsPlayerOnServer(playerSpec)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (GetPlayerVehicleIDEx(playerid) != INVALID_VEHICLE_ID) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В транспорте запрещено начинать слежку.");
		return 1;
	}

	if (GetSpecPl(playerSpec) 
	|| GetPlayerSpectating(playerSpec) != INVALID_PLAYER_ID) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок находится в режиме слежки.");
		return 1;
	}

	if (GetPlayerCanSpectating(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Сейчас Вам запрещено следить за кем-то.");
		return 1;
	}

	if (playerSpec == playerid) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"За самим собой запрещено следить.");
		return 1;
	}

	if (!GetAdminSpectating(playerid)) {
		Iter_Add(AdminCountSpecPlayer[playerSpec], playerid);

		SetPlayerSpectating(playerid, playerSpec);

		Mode_LeavePlayer(playerid);
		SetAdminSpectating(playerid, true);

		Mode_EnterPlayer(playerid, Mode_GetPlayerMode(playerSpec), Mode_GetPlayerSession(playerSpec));

		SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorldEx(playerSpec));
		SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(playerSpec));

		SpecPl(playerid, true);

		if (IsPlayerInAnyVehicle(playerSpec)) {
			SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_PLAYER);
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(playerSpec));
		}
		else {
			SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_VEHICLE);
			PlayerSpectatePlayer(playerid, playerSpec);
		}

		Interface_Show(playerid, Interface:AdminSpectate);
		SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" начал слежку за %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSpec), playerSpec);
	}
	else {
		if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID)
			Iter_Remove(AdminCountSpecPlayer[GetPlayerSpectating(playerid)], playerid);

		Iter_Add(AdminCountSpecPlayer[playerSpec], playerid);

		SetPlayerSpectating(playerid, playerSpec);

		if (!Mode_IsPlayerInPlayer(playerid, playerSpec)) {
			Mode_LeavePlayer(playerid);
			Mode_EnterPlayer(playerid, Mode_GetPlayerMode(playerSpec), Mode_GetPlayerSession(playerSpec));
		}

		SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorldEx(playerSpec));
		SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(playerSpec));

		if (IsPlayerInAnyVehicle(playerSpec)) {
			SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_PLAYER);
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(playerSpec));
		}
		else {
			SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_INVALID);
			PlayerSpectatePlayer(playerid, playerSpec);
		}
		SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" начал слежку за %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSpec), playerSpec);
	}
	return 1;
}

CMD:offsp(playerid)
{
	if (GetAdminSpectating(playerid)) {
		StopAdminSpectating(playerid);
	}
	return 1;
}

CMD:checkstats(playerid, params[])
{
	new
		playerStats;

	if (sscanf(params, "u", playerStats)) {
		return SendPlayerMessageCMD(playerid, "/checkstats [id игрока]");
	}

	if (!IsPlayerOnServer(playerStats)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	SetPlayerIDStats(playerid, playerStats);
	Dialog_Show(playerid, Dialog:ChoosePlayerStats);
	return 1;
}

CMD:aspawn(playerid, params[])
{
	new
		playerSpawn;

	if (sscanf(params, "u", playerSpawn)) {
		return SendPlayerMessageCMD(playerid, "/aspawn [id игрока]");
	}

	if (!IsPlayerOnServer(playerSpawn)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (Mode_GetPlayerMode(playerSpawn) == MODE_NONE
	&& GetSpecPl(playerid)) {
		SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Сейчас игрока нельзя заспавнить.");
		return 1;
	}

	PlayerSpawn(playerSpawn);
	return 1;
}

CMD:slap(playerid, params[])
{
	new
		playerSlap;

	if (sscanf(params, "u", playerSlap)) {
		return SendPlayerMessageCMD(playerid, "/slap [id игрока]");
	}

	if (!IsPlayerOnServer(playerSlap)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	new
		Float:slapX, Float:slapY, Float:slapZ;

	GetPlayerPos(playerSlap, slapX, slapY, slapZ);
	SetPlayerPosEx(playerid, slapX, slapY, slapZ + 5.0, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	PlayerPlaySoundEx(playerSlap, 1130, slapX, slapY, slapZ + 5);

	SCM(playerSlap, C_CARMINE, "Администратор %s "T_PID" подкинул вас.", GetPlayerNameEx(playerid), playerid);
	return 1;
}

CMD:jp(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return 1;
}

CMD:admins(playerid)
{
	Dialog_Show(playerid, Dialog:AdminOnline);
	return 1;
}

CMD:adminstats(playerid)
{
	Dialog_Show(playerid, Dialog:AdminStats);
	return 1;
}

CMD:asend(playerid, params[])
{
	new
		playerSend, text[100];

	if (sscanf(params, "us[100]", playerSend, text)) {
		return SendPlayerMessageCMD(playerid, "/asend [id игрока] [сообщение]");
	}

	if (!IsPlayerOnServer(playerSend)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	SCM(playerSend, C_ORANGE, "[Администратор] %s "T_PID": %s", GetPlayerNameEx(playerid), playerid, text);
	SCM(playerid, C_ORANGE, "[Игроку] %s "T_PID": %s", GetPlayerNameEx(playerSend), playerSend, text);
	return 1;
}

CMD:gethere(playerid, params[])
{
	new
		playerGethere;

	if (sscanf(params, "u", playerGethere)) {
		return SendPlayerMessageCMD(playerid, "/gethere [id игрока]");
	}

	if (!IsPlayerOnServer(playerGethere)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (GetSpecPl(playerGethere)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"На данный момент игрок занят.");
		return 1;
	}

	if (GetPlayerSpectating(playerGethere) != INVALID_PLAYER_ID) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок за кем-то следит.");
		return 1;
	}

	if (!Mode_IsPlayerInPlayer(playerid, playerGethere)) {
		Mode_LeavePlayer(playerGethere);
		Mode_EnterPlayer(playerGethere, Mode_GetPlayerMode(playerid), Mode_GetPlayerSession(playerid));
	}

	SetPlayerVirtualWorldEx(playerGethere, GetPlayerVirtualWorldEx(playerid));
	SetPlayerInteriorEx(playerGethere, GetPlayerInteriorEx(playerid));

	new
		Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);
	SetPlayerPosEx(playerGethere, x + 0.5, y + 0.5, z + 0.5, GetPlayerVirtualWorldEx(playerGethere), GetPlayerInteriorEx(playerGethere));

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" телепортировал к себе %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerGethere), playerGethere);
	return 1;
}

CMD:gotos(playerid, params[])
{
	new
		playerGotos;

	if (sscanf(params, "u", playerGotos)) {
		return SendPlayerMessageCMD(playerid, "/gotos [id игрока]");
	}

	if (!IsPlayerOnServer(playerGotos)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (GetSpecPl(playerGotos)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"На данный момент игрок занят.");
		return 1;
	}

	if (GetPlayerSpectating(playerGotos) != INVALID_PLAYER_ID) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок за кем-то следит.");
		return 1;
	}

	if (!Mode_IsPlayerInPlayer(playerid, playerGotos)) {
		Mode_LeavePlayer(playerid);
		Mode_EnterPlayer(playerid, Mode_GetPlayerMode(playerGotos), Mode_GetPlayerSession(playerGotos));
	}

	SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorldEx(playerGotos));
	SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(playerGotos));

	new
		Float:x, Float:y, Float:z;

	GetPlayerPos(playerGotos, x, y, z);
	SetPlayerPosEx(playerid, x + 0.5, y + 0.5, z + 0.5, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" телепортировался к %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerGotos), playerGotos);
	return 1;
}

CMD:getip(playerid, params[])
{
	new
		playerIP;
	
	if (sscanf(params, "u", playerIP)) {
		return SendPlayerMessageCMD(playerid, "/getip [id игрока]");
	}

	if (!IsPlayerOnServer(playerIP)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	SCM(playerid, C_YELLOW, "%s: "CT_WHITE"Reg-IP [%s] IP [%s]", GetPlayerNameEx(playerIP), GetPlayerIPReg(playerIP), GetPlayerIPLast(playerIP));
	return 1;
}

CMD:getwarn(playerid, params[])
{
	new
		playerWarn;

	if (sscanf(params, "u", playerWarn)) {
		return SendPlayerMessageCMD(playerid, "/getwarn [id игрока]");
	}

	if (!IsPlayerOnServer(playerWarn)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	SCM(playerid, C_YELLOW, "%s: "CT_WHITE"Warns [%i]", GetPlayerNameEx(playerWarn), GetPlayerWarns(playerWarn));
	return 1;
}

CMD:z(playerid, params[])
{
	new
		playerFreeze;

	if (sscanf(params, "u", playerFreeze)) {
		return SendPlayerMessageCMD(playerid, "/z [id игрока]");
	}

	if (!IsPlayerOnServer(playerFreeze)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (IsPlayerControllable(playerFreeze)) {
		TogglePlayerControllable(playerFreeze, false);
		PlayerPlaySoundEx(playerFreeze, 40404, 0.0, 0.0, 0.0);

		SCM(playerFreeze, C_CARMINE, "Администратор %s "T_PID" заморозил вас.", GetPlayerNameEx(playerid), playerid);
		SCM(playerid, C_CARMINE, "Заморозка игрока %s "T_PID" прошла успешно.", GetPlayerNameEx(playerFreeze), playerFreeze);

		SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" заморозил %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerFreeze), playerFreeze);
	}
	else {
		TogglePlayerControllable(playerFreeze, true);
		PlayerPlaySoundEx(playerFreeze, 40404, 0.0, 0.0, 0.0);

		SCM(playerFreeze, C_CARMINE, "Администратор %s "T_PID" разморозил вас.", GetPlayerNameEx(playerid), playerid);
		SCM(playerid, C_CARMINE, "Разморозка игрока %s "T_PID" прошла успешно.", GetPlayerNameEx(playerFreeze), playerFreeze);

		SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" разморозил %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerFreeze), playerFreeze);
	}
	return 1;
}

CMD:weap(playerid, params[])
{
	new
		playerWeap;

	if (sscanf(params, "u", playerWeap)) {
		return SendPlayerMessageCMD(playerid, "/weap [id игрока]");
	}

	if (!IsPlayerOnServer(playerWeap)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	ResetPlayerWeaponsEx(playerWeap);

	SCM(playerWeap, C_CARMINE, "Администратор %s "T_PID" забрал у вас всё оружие.", GetPlayerNameEx(playerid), playerid);
	SCM(playerid, C_CARMINE, "Обнуление оружия у %s "T_PID" прошло успешно.", GetPlayerNameEx(playerWeap), playerWeap);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" забрал оружие %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerWeap), playerWeap);
	return 1;
}

CMD:fixveh(playerid)
{
	if (!IsPlayerInAnyVehicle(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы должны находится в транспорте.");
		return 1;
	}

	new
		vehicle = GetPlayerVehicleID(playerid);

	RepairVehicle(vehicle);
	return 1;
}

CMD:fuelveh(playerid)
{
	if (!IsPlayerInAnyVehicle(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы должны находится в транспорте.");
		return 1;
	}

	new
		vehicle = GetPlayerVehicleID(playerid);
	
	SetVehicleFuel(vehicle, VEHICLE_FUEL);
	return 1;
}

CMD:rfixveh(playerid, params[])
{
	new
		Float:radius;

	if (sscanf(params, "f", radius)) {
		return SendPlayerMessageCMD(playerid, "/rfixveh [радиус]");
	}
	
	if (radius < 1.0 
	|| radius > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	new
		vehicles;

	for (new i = 0, Float:x, Float:y, Float:z; i < MAX_VEHICLES; ++i) {
		if (!IsVehicleStreamedIn(i, playerid)) {
			continue;
		}

		if (GetVehicleVirtualWorld(i) != GetPlayerVirtualWorldEx(playerid)) {
			continue;
		}

		GetVehiclePos(i, x, y, z);
		if (!IsPlayerInRangeOfPoint(playerid, radius, x, y, z)) {
			continue;
		}
	
		vehicles++;
		RepairVehicle(i);

		foreach (Player, p) {
			if (!IsPlayerOnServer(p)) {
				continue;
			}
			
			if (IsPlayerInAnyVehicle(p)) {
				if (GetPlayerVehicleID(p) == i) {
					SCM(p, C_CARMINE, "Администратор %s "T_PID" починил транпорт.", GetPlayerNameEx(playerid), playerid, params[1]);
				}
			}
		}
	}
	SCM(playerid, C_CARMINE, "Вы починили %i транспорта", vehicles);
	return 1;
}

CMD:rfuelveh(playerid, params[])
{
	new
		Float:radius;

	if (sscanf(params, "f", radius)) {
		return SendPlayerMessageCMD(playerid, "/rfuelveh [радиус]");
	}

	if (radius < 1.0 
	|| radius > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	new
		vehicles;

	for (new i = 0, Float:x, Float:y, Float:z; i < MAX_VEHICLES; ++i) {
		if (!IsVehicleStreamedIn(i, playerid)) {
			continue;
		}

		if (GetVehicleVirtualWorld(i) != GetPlayerVirtualWorldEx(playerid)) {
			continue;
		}

		GetVehiclePos(i, x, y, z);

		if (!IsPlayerInRangeOfPoint(playerid, radius, x, y, z)) {
			continue;
		}

		vehicles++;
		SetVehicleFuel(i, VEHICLE_FUEL);

		foreach (Player, p) {
			if (!IsPlayerOnServer(p)) {
				continue;
			}
			
			if (IsPlayerInAnyVehicle(p)) {
				if (GetPlayerVehicleID(p) == i) {
					SCM(p, C_CARMINE, "Администратор %s "T_PID" пополнил бензин в транпорте.", GetPlayerNameEx(playerid), playerid, params[1]);
				}
			}
		}
	}
	SCM(playerid, C_CARMINE, "Бензин пополнен в %i транспорта", vehicles);
	return 1;
}

CMD:kick(playerid, params[])
{
	new
		playerKick, reason[MAX_LENGTH_ADM_REASON];

	if (sscanf(params, "us["MAX_STR_ADM_REASON"]", playerKick, reason)) {
		return SendPlayerMessageCMD(playerid, "/kick [id игрока] [причина]");
	}

	if (!IsPlayerOnServer(playerKick)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	pInfo[playerid][e_Kicks]++;

	KickPlayerEx(playerKick);

	SendPlayersMessage(C_CARMINE, "Администратор %s "T_PID" кикнул %s "T_PID" по причине: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerKick), playerKick, reason);
	return 1;
}

CMD:mute(playerid, params[])
{
	new
		playerMute, minutes, reason[MAX_LENGTH_ADM_REASON];

	if (sscanf(params, "uis["MAX_STR_ADM_REASON"]", playerMute, minutes, reason)) {
		return SendPlayerMessageCMD(playerid, "/mute [id игрока] [минут] [причина]");
	}
	
	if (minutes < 1 
	|| minutes > 20) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Меньше 0 и больше 20 минут запрещается!");
		return 1;
	}

	if (strlen(reason) > MAX_LENGTH_ADM_REASON) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Больше "MAX_STR_ADM_REASON" символов запрещено вводить.");
		return 1;
	}

	if (!IsPlayerOnServer(playerMute)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (GetPlayerMute(playerMute) > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок уже заткнут.");
		return 1;
	}

	pInfo[playerid][e_Muts]++;

	SetPlayerMute(playerMute, minutes);
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_MUTED_MINUTES"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerMute(playerMute), GetPlayerMySQLID(playerMute));

	SendPlayersMessage(C_CARMINE, "Администратор %s "T_PID" заткнул игрока %s "T_PID" на %i минут. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerMute), playerMute, minutes, reason);
	return 1;
}

CMD:unmute(playerid, params[])
{
	new
		playerUnmute;

	if (sscanf(params, "u", playerUnmute)) {
		return SendPlayerMessageCMD(playerid, "/unmute [id игрока]");
	}

	if (GetPlayerMute(playerUnmute) <= 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"У данного игрока нет мута.");
		return 1;
	}

	if (!IsPlayerOnServer(playerUnmute)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	pInfo[playerid][e_UnMuts]++;

	SetPlayerMute(playerUnmute, 0);
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_MUTED_MINUTES"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerMute(playerUnmute), GetPlayerMySQLID(playerUnmute));

	SendPlayersMessage(C_CARMINE, "Администратор %s "T_PID" снял мут у игрока %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerUnmute), playerUnmute);
	return 1;
}

CMD:sethp(playerid, params[])
{
	new
		playerHP, Float:health;

	if (sscanf(params, "uf", playerHP, health)) {
		return SendPlayerMessageCMD(playerid, "/sethp [id игрока] [здоровье]");
	}
	
	if (health < 0.0 
	|| health > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Меньше 0 и больше 100 запрещается!");
		return 1;
	}

	if (!IsPlayerOnServer(playerHP)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	SetPlayerHealthEx(playerHP, health);

	SCM(playerHP, C_CARMINE, "Администратор %s "T_PID" выдал %i здоровья", GetPlayerNameEx(playerid), playerid, health);
	SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано %i здоровья", GetPlayerNameEx(playerHP), playerHP, health);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал здоровье %s "T_PID" Здоровья: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerHP), playerHP, health);
	return 1;
}

CMD:setarmour(playerid, params[])
{
	new
		playerArm, Float:armour;

	if (sscanf(params, "uf", playerArm, armour)) {
		return SendPlayerMessageCMD(playerid, "/setarmour [id игрока] [броня]");
	}
	
	if (armour < 0.0 
	|| armour > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Меньше 0 и больше 100 запрещается!");
		return 1;
	}

	if (!IsPlayerOnServer(playerArm)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	SetPlayerArmourEx(playerArm, armour);

	SCM(playerArm, C_CARMINE, "Администратор %s "T_PID" выдал {3366FF}%i брони", GetPlayerNameEx(playerid), playerid, armour);
	SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано {3366FF}%i брони", GetPlayerNameEx(playerArm), playerArm, armour);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал броню %s "T_PID" Брони: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerArm), playerArm, armour);
	return 1;
}

CMD:rsethp(playerid, params[])
{
	new
		Float:radius, Float:health;
	
	if (sscanf(params, "ff", radius, health)) {
		return SendPlayerMessageCMD(playerid, "/rsethp [радиус] [здоровья]");
	}
	
	if (radius < 1.0 
	|| radius > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	if (health < 0.0 
	|| health > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Здоровья меньше 0 и больше 100 запрещается!");
		return 1;
	}

	new
		players,
		Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (Player, p) {
		if (!IsPlayerOnServer(p)) {
			continue;
		}

		if (Mode_GetPlayerMode(p) != Mode_GetPlayerMode(playerid)) {
			continue;
		}

		if (IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			SetPlayerHealthEx(p, health);
			players++;

			SCM(p, C_CARMINE, "Администратор %s "T_PID" выдал %i здоровья", GetPlayerNameEx(playerid), playerid, health);
		}
	}
	SCM(playerid, C_CARMINE, "Выдано %i игрокам заданное здоровье", players);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал здоровье в радиусе %i Здоровья: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(params[0]), params[0], radius, health);
	return 1;
}

CMD:rsetarmour(playerid, params[])
{
	new
		Float:radius, Float:armour;
	
	if (sscanf(params, "ff", radius, armour)) {
		return SendPlayerMessageCMD(playerid, "/rsetarmour [радиус] [броня]");
	}
	
	if (radius < 1.0 
	|| radius > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	if (armour < 0.0 
	|| armour > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Брони меньше 0 и больше 100 запрещается!");
		return 1;
	}

	new
		players,
		Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (Player, p) {
		if (!IsPlayerOnServer(p)) {
			continue;
		}

		if (Mode_GetPlayerMode(p) != Mode_GetPlayerMode(playerid)) {
			continue;
		}

		if (IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			SetPlayerArmourEx(p, armour);
			players++;

			SCM(p, C_CARMINE,  "Администратор %s "T_PID" выдал {3366FF}%i брони", GetPlayerNameEx(playerid), playerid, armour);
		}
	}
	SCM(playerid, C_CARMINE, "Выдано %i игрокам заданная броня", players);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал броню в радиусе %i Брони: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(params[0]), params[0], radius, armour);
	return 1;
}

CMD:veh(playerid, params[])
{
	new
		vehicleid, colour1, colour2;

	if (sscanf(params, "iii", vehicleid, colour1, colour2)) {
		return SendPlayerMessageCMD(playerid, "/veh [id машины] [id цвета №1] [id цвета №2]");
	}
	
	if (vehicleid < 400 
	|| vehicleid > 611) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"ID машины должен быть от 400 до 611!");
		return 1;
	}

	if (colour1 < 0 
	|| colour1 > 255) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"ID цвета машины должен быть от 0 до 255!");
		return 1;
	}

	if (colour2 < 0 
	|| colour2 > 255) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"ID цвета машины должен быть от 0 до 255!");
		return 1;
	}

	RemovePlayerFromVehicle(playerid);
	TogglePlayerControllable(playerid, true);

	if (AdminVehicleID[playerid] != INVALID_VEHICLE_ID) {
		ActiveVehicleAdmin{AdminVehicleID[playerid]} = false;
		DestroyVehicleEx(AdminVehicleID[playerid]);
	}

	new
		Float:X, Float:Y, Float:Z, Float:Angle;

	GetPlayerFacingAngle(playerid, Angle);
	GetPlayerPos(playerid, X, Y, Z);

	AdminVehicleID[playerid] = CreateVehicle(vehicleid, X, Y, Z, Angle, colour1, colour2, VEHICLE_RESPAWN_TIME);

	new
		veh_id = AdminVehicleID[playerid];

	SetVehicleVirtualWorld(veh_id, GetPlayerVirtualWorldEx(playerid));
	LinkVehicleToInterior(veh_id, GetPlayerInteriorEx(playerid));
	SetVehicleFuel(veh_id, VEHICLE_FUEL);

	ActiveVehicleAdmin{veh_id} = true;
	PutPlayerInVehicle(playerid, veh_id, 0);

	if (CheckIDVehicleBike(GetVehicleModel(veh_id))) {
		new 
			engine, lights, alarm, bonnet,
			boot, objective, doors;

		GetVehicleParamsEx(veh_id, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(veh_id, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
	}
	SCM(playerid, C_CARMINE, "Транспорт ID: %i создан. Для удаления транспорта введите: "CT_YELLOW"/delveh", vehicleid);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" создал транспорт", GetPlayerNameEx(playerid), playerid);
	return 1;
}

CMD:delveh(playerid)
{
	if (AdminVehicleID[playerid] == INVALID_VEHICLE_ID) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Нет созданного транспорта.");
		return 1;
	}

	ActiveVehicleAdmin{AdminVehicleID[playerid]} = false;
	DestroyVehicleEx(AdminVehicleID[playerid]);

	SCM(playerid, C_CARMINE, "Транспорт успешно удален.");

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" удалил транспорт", GetPlayerNameEx(playerid), playerid);
	return 1;
}

CMD:areferals(playerid, params[])
{
	new
		playerName[MAX_PLAYER_NAME];

	if (sscanf(params, "s["MAX_STR_PLAYER_NAME"]", playerName)) {
		return SendPlayerMessageCMD(playerid, "/areferals [ник игрока]");
	}

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ACCOUNTS"` WHERE BINARY `"DB_ACCOUNTS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckAdminReferals", "is["MAX_STR_PLAYER_NAME"]", playerid, playerName);
	return 1;
}

CMD:ban(playerid, params[])
{
	new
		playerBan, days, reason[MAX_LENGTH_ADM_REASON];

	if (sscanf(params, "uis["MAX_STR_ADM_REASON"]", playerBan, days, reason)) {
		return SendPlayerMessageCMD(playerid, "/ban [id игрока] [дней] [причина]");
	}
	
	if (days < 0 
	|| days > MAX_PLAYER_DAYS_BAN) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Возможно только от 1 дня до "MAX_STR_PLAYER_DAYS_BAN" дней.");
		return 1;
	}

	if (!IsPlayerOnServer(playerBan)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (pInfo[playerid][e_Level] < pInfo[playerBan][e_Level]) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный администратор выше вас по должности.");
		return 1;
	}

	pInfo[playerid][e_Bans]++;

	SetPlayerBan(GetPlayerNameEx(playerBan), GetPlayerNameEx(playerid), days, reason);
	KickPlayerEx(playerBan);

	SendPlayersMessage(C_CARMINE, "Администратор %s "T_PID" забанил %s "T_PID" на %i дней. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerBan), playerBan, days, reason);
	return 1;
}

CMD:unban(playerid, params[])
{
	new
		playerName[MAX_PLAYER_NAME];

	if (sscanf(params, "s["MAX_STR_PLAYER_NAME"]", playerName)) {
		return SendPlayerMessageCMD(playerid, "/unban [ник игрока]");
	}

	mysql_escape_string(playerName, playerName, MAX_PLAYER_NAME);

	new
		query[60 + MAX_PLAYER_NAME];
	
	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_BANS"` WHERE BINARY `"DB_BANS_PLAYER_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckUnBanPlayer", "is["MAX_STR_PLAYER_NAME"]", playerid, playerName);
	return 1;
}

CMD:sban(playerid, params[])
{
	new
		playerSBan, days, reason[MAX_LENGTH_ADM_REASON];

	if (sscanf(params, "uis["MAX_STR_ADM_REASON"]", playerSBan, days, reason)) {
		return SendPlayerMessageCMD(playerid, "/sban [id игрока] [дней] [причина]");
	}

	if (!IsPlayerOnServer(playerSBan)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (pInfo[playerid][e_Level] < pInfo[playerSBan][e_Level]) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный администратор выше вас по уровню.");
		return 1;
	}

	if (days < 1 
	|| days > MAX_PLAYER_DAYS_BAN) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Возможно только от 1 дня до "MAX_STR_PLAYER_DAYS_BAN" дней.");
		return 1;
	}

	pInfo[playerid][e_Bans]++;

	SCM(playerSBan, C_CARMINE, "Администратор %s "T_PID" забанил %s "T_PID" на %i дней. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSBan), playerSBan, days, reason);
	SCM(playerid, C_CARMINE, "Администратор %s "T_PID" забанил %s "T_PID" на %i дней. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSBan), playerSBan, days, reason);

	SetPlayerBan(GetPlayerNameEx(playerSBan), GetPlayerNameEx(playerid), days, reason);
	KickPlayerEx(playerSBan);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" по тихому забанил %s "T_PID" по причине %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSBan), playerSBan, reason);
	return 1;
}

CMD:banoff(playerid, params[])
{
	new
		playerName[MAX_PLAYER_NAME], days, reason[MAX_LENGTH_ADM_REASON];

	if (sscanf(params, "s["MAX_STR_PLAYER_NAME"]is["MAX_STR_ADM_REASON"]", playerName, days, reason)) {
		return SendPlayerMessageCMD(playerid, "/banoff [ник игрока] [дней] [причина]");
	}
	
	if (days < 1 
	|| days > 30) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Возможно только от 1 дня до 30 дней.");
		return 1;
	}

	new
		player = GetNameID(playerName);

	if (player != INVALID_PLAYER_ID) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок в сети.");
		return 1;
	}

	mysql_escape_string(playerName, playerName, MAX_PLAYER_NAME);

	new
		query[150];
	
	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_BANS"` WHERE BINARY `"DB_BANS_PLAYER_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckBanOffBanned", "iis["MAX_STR_ADM_REASON"]s["MAX_STR_PLAYER_NAME"]", playerid, days, reason, playerName);
	return 1;
}

CMD:skick(playerid, params[])
{
	new
		playerid_SKick, reason[MAX_LENGTH_ADM_REASON];

	if (sscanf(params, "us["MAX_STR_ADM_REASON"]", playerid_SKick, reason)) {
		return SendPlayerMessageCMD(playerid, "/skick [id игрока] [причина]");
	}

	if (!IsPlayerOnServer(playerid_SKick)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	pInfo[playerid][e_Kicks]++;

	SCM(playerid_SKick, C_CARMINE, "Администратор %s "T_PID" кикнул по %s "T_PID" по причине: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerid_SKick), playerid_SKick, reason);
	SCM(playerid, C_CARMINE, "Администратор %s "T_PID" кикнул %s "T_PID" по причине: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerid_SKick), playerid_SKick, reason);

	KickPlayerEx(playerid_SKick);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" по тихому кикнул %s "T_PID" по причине %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerid_SKick), playerid_SKick, reason);
	return 1;
}

CMD:smute(playerid, params[])
{
	new
		playerSMute, minutes, reason[MAX_LENGTH_ADM_REASON];

	if (sscanf(params, "uis["MAX_STR_ADM_REASON"]", playerSMute, minutes, reason)) {
		return SendPlayerMessageCMD(playerid, "/smute [id игрока] [минут] [причина]");
	}
	
	if (minutes < 1 
	|| minutes > 20) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Меньше 0 и больше 20 минут запрещается!");
		return 1;
	}

	if (strlen(reason) > 29) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Больше 30 символов запрещено вводить.");
		return 1;
	}

	if (!IsPlayerOnServer(playerSMute)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (GetPlayerMute(playerSMute) > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок уже заткнут.");
		return 1;
	}

	pInfo[playerid][e_Muts]++;

	SetPlayerMute(playerSMute, minutes);
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_MUTED_MINUTES"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerMute(playerSMute), GetPlayerMySQLID(playerSMute));

	SCM(playerSMute, C_CARMINE, "Администратор %s "T_PID" заткнул игрока %s "T_PID" на %i минут. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSMute), playerSMute, minutes, reason);
	SCM(playerid, C_CARMINE, "Администратор %s "T_PID" заткнул игрока %s "T_PID" на %i минут. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSMute), playerSMute, minutes, reason);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" по тихому выдал мут %s "T_PID" по причине %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSMute), playerSMute, reason);
	return 1;
}

CMD:sunmute(playerid, params[])
{
	new
		playerSUnmute;

	if (sscanf(params, "u", playerSUnmute)) {
		return SendPlayerMessageCMD(playerid, "/sunmute [id игрока]");
	}

	if (GetPlayerMute(playerSUnmute) <= 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"У данного игрока нет мута.");
		return 1;
	}

	if (!IsPlayerOnServer(playerSUnmute)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	pInfo[playerid][e_UnMuts]++;

	SetPlayerMute(playerSUnmute, 0);
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_MUTED_MINUTES"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerMute(playerSUnmute), GetPlayerMySQLID(playerSUnmute));

	SCM(playerSUnmute, C_CARMINE, "Администратор %s "T_PID" убрал мут у игрока %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSUnmute), playerSUnmute);
	SCM(playerid, C_CARMINE, "Администратор %s "T_PID" убрал мут у игрока %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSUnmute), playerSUnmute);
	return 1;
}

CMD:givegun(playerid, params[])
{
	new
		playerGun, WEAPON:weaponid, ammo;

	if (sscanf(params, "uii", playerGun, weaponid, ammo)) {
		return SendPlayerMessageCMD(playerid, "/givegun [id игрока] [id оружия] [кол-во патронов]");
	}

	if (!IsPlayerOnServer(playerGun)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (weaponid < WEAPON_FIST 
	|| weaponid > WEAPON_PARACHUTE) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"ID оружия меньше 1 и больше 47 запрещено!");
		return 1;
	}

	if (ammo < 1 
	|| ammo > 500) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Меньше 1 и больше 500 патронов запрещено!");
		return 1;
	}

	GivePlayerWeaponEx(playerGun, weaponid, ammo);

	new
		weaponName[MAX_LENGTH_WEAPON_NAME];

	GetWeaponNameRU(weaponid, weaponName, MAX_LENGTH_WEAPON_NAME);
	SCM(playerGun, C_CARMINE, "Администратор %s "T_PID" выдал вам оружие %s патронов: %i", GetPlayerNameEx(playerid), playerid, weaponName, ammo);
	SCM(playerid, C_CARMINE, "Выдано игроку %s "T_PID" оружие %s патронов: %i", GetPlayerNameEx(playerGun), playerGun, weaponName, ammo);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал оружие %s "T_PID" Оружие: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerGun), playerGun, weaponName);
	return 1;
}

CMD:rgivegun(playerid, params[])
{
	new
		Float:radius, WEAPON:weaponid, ammo;

	if (sscanf(params, "fii", radius, weaponid, ammo)) {
		return SendPlayerMessageCMD(playerid, "/rgivegun [радиус] [id оружия] [кол-во патронов]");
	}
	
	if (radius < 1.0 
	|| radius > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	if (weaponid < WEAPON_FIST 
	|| weaponid > WEAPON_PARACHUTE) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Оружие меньше 1 и больше 43 запрещается!");
		return 1;
	}

	new
		players,
		Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	new 
		weaponName[MAX_LENGTH_WEAPON_NAME];

	GetWeaponNameRU(weaponid, weaponName, MAX_LENGTH_WEAPON_NAME);

	foreach (Player, p) {
		if (!IsPlayerOnServer(p)) {
			continue;
		}

		if (Mode_GetPlayerMode(p) != Mode_GetPlayerMode(playerid)) {
			continue;
		}

		if (IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			GivePlayerWeaponEx(p, weaponid, ammo);
			players++;
		
			SCM(p, C_CARMINE, "Администратор %s "T_PID" выдал оружие %s патронов: %i", GetPlayerNameEx(playerid), playerid, weaponName, ammo);
		}
	}
	SCM(playerid, C_CARMINE, "Выдано %i игрокам заданное оружие", players);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал оружие в радиусе %i Оружие: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(params[0]), params[0], radius, weaponName);
	return 1;
}

CMD:warn(playerid, params[])
{
	new
		playerWarn, reason[MAX_LENGTH_ADM_REASON];

	if (sscanf(params, "us["MAX_STR_ADM_REASON"]", playerWarn, reason)) {
		return SendPlayerMessageCMD(playerid, "/warn [id игрока] [причина]");
	}

	if (!IsPlayerOnServer(playerWarn)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (pInfo[playerid][e_Level] < pInfo[playerWarn][e_Level]) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный администратор выше вас по должности.");
		return 1;
	}

	GivePlayerWarns(playerWarn, 1);

	if (GetPlayerWarns(playerWarn) != 3) {
		pInfo[playerid][e_Warns]++;

		SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_WARNS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerWarns(playerWarn), GetPlayerMySQLID(playerWarn));

		SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано предупреждение [%i из 3]. Причина: %s", GetPlayerNameEx(playerWarn), playerWarn, GetPlayerWarns(playerWarn), reason);
		SCM(playerWarn, C_CARMINE, "Администратор %s "T_PID" выдал вам предупреждение [%i из 3]. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerWarns(playerWarn), reason);

		SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал предупреждение %s "T_PID" по причине: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerWarn), playerWarn, reason);
		return 1;
	}
	else if (GetPlayerWarns(playerWarn) == 3) {
		pInfo[playerid][e_Warns]++;

		SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано предупреждение [%i из 3]. Причина: %s", GetPlayerNameEx(playerWarn), playerWarn, GetPlayerWarns(playerWarn), reason);
		SCM(playerWarn, C_CARMINE, "Администратор %s "T_PID" выдал вам предупреждение [%i из 3]. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerWarns(playerWarn), reason);

		SetPlayerBan(GetPlayerNameEx(playerWarn), GetPlayerNameEx(playerid), 3, "Warns: 3");
		
		SCM(playerWarn, C_CARMINE, ""T_INFO" Вы получили бан на 3 дня за 3 предупреждения.");
		ResetPlayerWarns(playerWarn);

		SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_WARNS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerWarns(playerWarn), GetPlayerMySQLID(playerWarn));

		KickPlayerEx(playerWarn);

		SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал предупреждение %s "T_PID" по причине: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerWarn), playerWarn, reason);
		return 1;
	}

	GivePlayerWarns(playerWarn, -1);
	SCM(playerWarn, C_RED, ""T_ERROR" "CT_WHITE"У данного игрока уже 3 предупреждения.");
	return 1;
}

CMD:unwarn(playerid, params[])
{
	new
		playerUnwarn;

	if (sscanf(params, "u", playerUnwarn)) {
		return SendPlayerMessageCMD(playerid, "/unwarn [id игрока]");
	}
	
	if (pInfo[playerid][e_Level] < pInfo[playerUnwarn][e_Level]) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный администратор выше вас по уровню.");
		return 1;
	}

	if (!IsPlayerOnServer(playerUnwarn)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (GetPlayerWarns(playerUnwarn) > 0) {
		pInfo[playerid][e_UnWarns]++;

		GivePlayerWarns(playerUnwarn, -1);
		SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_WARNS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerWarns(playerUnwarn), GetPlayerMySQLID(playerUnwarn));

		SCM(playerid, C_CARMINE, "Снято предупреждение у игрока %s "T_PID" [%i из 3].", GetPlayerNameEx(playerUnwarn), playerUnwarn, GetPlayerWarns(playerUnwarn));
		SCM(playerUnwarn, C_CARMINE, "Администратор %s "T_PID" убрал предупреждение [%i из 3].", GetPlayerNameEx(playerid), playerid, GetPlayerWarns(playerUnwarn));
		return 1;
	}

	SCM(playerUnwarn, C_RED, ""T_ERROR" "CT_WHITE"У данного игрока 0 предупреждений.");

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" снял предупреждение %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerUnwarn), playerUnwarn);
	return 1;
}

CMD:banlist(playerid)
{
	new
		query[250];

	mysql_format(MySQLID, query, sizeof(query), "SELECT `"DB_BANS_PLAYER_NICKNAME"` FROM `"DB_BANS"` ORDER BY `"DB_BANS_ID"` DESC LIMIT 0 , 20");
	mysql_tquery(MySQLID, query, "MySQLCheckListBannedPlayers", "d", playerid);
	return 1;
}

CMD:setskin(playerid, params[])
{
	new
		playerSkin, skinid;

	if (sscanf(params, "ui", playerSkin, skinid)) {
		return SendPlayerMessageCMD(playerid, "/setskin [id игрока] [id скина]");
	}
	
	if (skinid < 0 
	|| skinid > 289) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Скин меньше 0 и больше 289 запрещается!");
		return 1;
	}

	if (!IsPlayerOnServer(playerSkin)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	SetPlayerSkinEx(playerSkin, skinid);

	SCM(playerSkin, C_CARMINE, "Администратор %s "T_PID" выдал скин %i", GetPlayerNameEx(playerid), playerid, skinid);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" установил скин %s "T_PID" Скин: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSkin), playerSkin, skinid);

	DestroyPlayerAttachedObjects(playerid);
	SetPlayerAttachInvItem(playerid);
	return 1;
}

CMD:rsetskin(playerid, params[])
{
	new
		Float:radius, skinid;
	
	if (sscanf(params, "fi", radius, skinid)) {
		return SendPlayerMessageCMD(playerid, "/rsetskin [радиус] [id скина]");
	}
	
	if (radius < 1.0 
	|| radius > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	if (skinid < 0 
	|| skinid > 289) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Скин меньше 0 и больше 289 запрещается!");
		return 1;
	}

	new
		players,
		Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (Player, p) {
		if (!IsPlayerOnServer(p)) {
			continue;
		}

		if (Mode_GetPlayerMode(p) != Mode_GetPlayerMode(playerid)) {
			continue;
		}

		if (IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			SetPlayerSkinEx(p, skinid);
			players++;

			SCM(p, C_CARMINE, "Администратор %s "T_PID" выдал скин %i", GetPlayerNameEx(playerid), playerid, skinid);
		}
	}
	SCM(playerid, C_CARMINE, "Выдано %i игрокам скин", players);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" установил скин в радиусе %i Скин: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(params[0]), radius, skinid);
	return 1;
}

CMD:aset(playerid, params[])
{
	new
		playerSet;

	if (sscanf(params, "u", playerSet)) {
		return SendPlayerMessageCMD(playerid, "/aset [id игрока]");
	}

	if (!IsPlayerOnServer(playerSet)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	SetPlayerHealthEx(playerSet, 100.0);
	SetPlayerArmourEx(playerSet, 100.0);
	GivePlayerWeaponEx(playerSet, WEAPON_GRENADE, 50);
	GivePlayerWeaponEx(playerSet, WEAPON_UZI, 500);
	GivePlayerWeaponEx(playerSet, WEAPON_M4, 500);

	SCM(playerSet, C_CARMINE, "Администратор %s "T_PID" выдал набор оружия", GetPlayerNameEx(playerid), playerid);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал набор оружия %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerSet), playerSet);
	return 1;
}

CMD:raset(playerid, params[])
{
	new
		Float:radius;
	
	if (sscanf(params, "f", radius)) {
		return SendPlayerMessageCMD(playerid, "/raset [радиус]");
	}
	
	if (radius < 1.0 
	|| radius > 100.0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	new
		players,
		Float:x, Float:y, Float:z;

	GetPlayerPos(playerid, x, y, z);

	foreach (Player, p) {
		if (!IsPlayerOnServer(p)) {
			continue;
		}

		if (Mode_GetPlayerMode(p) != Mode_GetPlayerMode(playerid)) {
			continue;
		}

		if (IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			SetPlayerHealthEx(p, 100.0);
			SetPlayerArmourEx(p, 100.0);
			GivePlayerWeaponEx(p, WEAPON_GRENADE, 50);
			GivePlayerWeaponEx(p, WEAPON_UZI, 500);
			GivePlayerWeaponEx(p, WEAPON_M4, 500);
			players++;

			SCM(p, C_CARMINE, "Администратор %s "T_PID" выдал набор оружия", GetPlayerNameEx(playerid), playerid);
		}
	}

	SCM(playerid, C_CARMINE, "Выдано %i игрокам набор оружия", players);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал набор оружия в радиусе %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(params[0]), params[0], radius);
	return 1;
}

CMD:clearchat(playerid)
{
	n_for(i, 17) {
		SendClientMessageToAll(C_WHITE, " ");
	}

	SendPlayersMessage2(C_YELLOW, ""T_INFO" "CT_WHITE"Чат очищен администрацией.");
	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" очистил чат", GetPlayerNameEx(playerid), playerid);
	return 1;
}

CMD:warnoff(playerid, params[])
{
	new
		playerName[MAX_PLAYER_NAME], reason[MAX_LENGTH_ADM_REASON];

	if (sscanf(params, "s["MAX_STR_PLAYER_NAME"]s["MAX_STR_ADM_REASON"]", playerName, reason)) {
		return SendPlayerMessageCMD(playerid, "/warnoff [ник игрока] [причина]");
	}
	
	new
		playerID = GetNameID(playerName);
	
	if (playerID != INVALID_PLAYER_ID) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок в сети.");
		return 1;
	}

	new
		query[150];
	
	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_BANS"` WHERE BINARY `"DB_BANS_PLAYER_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckWarnOffBanned", "is["MAX_STR_ADM_REASON"]s["MAX_STR_PLAYER_NAME"]", playerid, reason, playerName);
	return 1;
}

CMD:unwarnoff(playerid, params[])
{
	new
		playerName[MAX_PLAYER_NAME];
	
	if (sscanf(params, "s["MAX_STR_PLAYER_NAME"]", playerName)) {
		return SendPlayerMessageCMD(playerid, "/unwarnoff [ник игрока]");
	}
	
	new
		player = GetNameID(playerName);

	if (player != INVALID_PLAYER_ID) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок в сети.");
		return 1;
	}

	new
		query[150];
	
	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_BANS"` WHERE BINARY `"DB_BANS_PLAYER_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckUnWarnOffBanned", "is["MAX_STR_PLAYER_NAME"]", playerid, playerName);
	return 1;
}

CMD:givemoney(playerid, params[])
{
	new
		playerMoney, money;

	if (sscanf(params, "ui", playerMoney, money)) {
		return SendPlayerMessageCMD(playerid, "/givemoney [id игрока] [кол-во денег]");
	}

	if (!IsPlayerOnServer(playerMoney)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	GivePlayerMoneyEx(playerMoney, money);

	SCM(playerMoney, C_CARMINE, "Администратор %s "T_PID" выдал вам +$%i", GetPlayerNameEx(playerid), playerid, money);
	SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано +$%i", GetPlayerNameEx(playerMoney), playerMoney, money);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал деньги %s "T_PID" Денег: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerMoney), playerMoney, money);
	return 1;
}

CMD:giverank(playerid, params[])
{
	new
		playerRank, rank;

	if (sscanf(params, "ui", playerRank, rank)) {
		return SendPlayerMessageCMD(playerid, "/giverank [id игрока] [ранг]");
	}

	if (!IsPlayerOnServer(playerRank)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	ResetPlayerExp(playerRank);
	GivePlayerRank(playerRank, rank);

	SCM(playerRank, C_CARMINE, "Администратор %s "T_PID" выдал вам +%i к рангу", GetPlayerNameEx(playerid), playerid, rank);
	SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано +%i к рангу", GetPlayerNameEx(playerRank), playerRank, rank);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал ранг %s "T_PID" Ранг: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerRank), playerRank, rank);
	return 1;
}

CMD:givemscore(playerid, params[])
{
	new
		playerScore, point;

	if (sscanf(params, "ui", playerScore, point)) {
		return SendPlayerMessageCMD(playerid, "/givemscore [id игрока] [очков матча]");
	}

	if (!IsPlayerOnServer(playerScore)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	Mode_GivePlayerMatchPoints(playerScore, point);

	SCM(playerScore, C_CARMINE, "Администратор %s "T_PID" выдал вам +%i очков матча", GetPlayerNameEx(playerid), playerid, point);
	SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано +%i очков матча", GetPlayerNameEx(playerScore), playerScore, point);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал матч очков %s "T_PID" Матч очков: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerScore), playerScore, point);
	return 1;
}

CMD:adamage(playerid, params[])
{
	new
		playerDamage;

	if (sscanf(params, "u", playerDamage)) {
		return SendPlayerMessageCMD(playerid, "/adamage [id игрока]");
	}

	if (!IsPlayerOnServer(playerDamage)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (GetPlayerDamage(playerDamage)) {
		SetPlayerDamage(playerDamage, false);
		SCM(playerDamage, C_CARMINE, "Администратор %s "T_PID" отключил вам урон.", GetPlayerNameEx(playerid), playerid);
		SCM(playerid, C_CARMINE, "Игроку %s "T_PID" отключён урон.", GetPlayerNameEx(playerDamage), playerDamage);

		SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" отключил урон %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerDamage), playerDamage);
	}
	else {
		SetPlayerDamage(playerDamage, true);
		SCM(playerDamage, C_CARMINE, "Администратор %s "T_PID" включил вам урон.", GetPlayerNameEx(playerid), playerid);
		SCM(playerid, C_CARMINE, "Игроку %s "T_PID" включён урон.", GetPlayerNameEx(playerDamage), playerDamage);

		SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" включил урон %s "T_PID"", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerDamage), playerDamage);
	}
	return 1;
}

CMD:astats(playerid, params[])
{
	new
		playerName[MAX_PLAYER_NAME];

	if (sscanf(params, "s["MAX_STR_PLAYER_NAME"]", playerName)) {
		return SendPlayerMessageCMD(playerid, "/astats [ник игрока]");
	}

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckStatsAdmin", "is["MAX_STR_PLAYER_NAME"]", playerid, playerName);
	return 1;
}

CMD:ao(playerid, params[])
{
	new
		text[150];

	if (sscanf(params, "s[150]", text)) {
		return SendPlayerMessageCMD(playerid, "/ao [текст]");
	}

	SendPlayersMessage2(C_BLUE, "");
	SendPlayersMessage(C_BLUE, "[Сервер] "CT_WHITE"%s", text);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" написал в чат сервера", GetPlayerNameEx(playerid), playerid);
	return 1;
}

CMD:promos(playerid)
{
	Dialog_Show(playerid, Dialog:SelectOptionPromoCode);
	return 1;
}

CMD:acheat(playerid)
{
	SetAntiCheatSettingsPage(playerid, 1);
	Dialog_Show(playerid, Dialog:ACSettings);
	return 1;
}

CMD:makeadmin(playerid, params[])
{
	new
		playerAdmin, level;

	if (sscanf(params, "ui", playerAdmin, level)) {
		return SendPlayerMessageCMD(playerid, "/makeadmin [id игрока] [уровень]");
	}

	if (!IsPlayerOnServer(playerAdmin)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (level < 0 
	|| level > ADM_MAX_LEVELS) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Уровень админки не может быть больше %i.", ADM_MAX_LEVELS);
		return 1;
	}

	if (level == 0
	&& GetAdminLevel(playerAdmin) == ADM_LEVEL_NONE) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не является администратором.");
		return 1;
	}

	pInfo[playerAdmin][e_Level] = level;

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", GetPlayerNameEx(playerAdmin));
	mysql_tquery(MySQLID, query, "MySQLCreateNewAdmin", "i", playerAdmin);

	if (level > 0) {
		SCM(playerid, C_CARMINE, "Вы назначили игрока "CT_YELLOW"%s "T_PID" - %s.", GetPlayerNameEx(playerAdmin), playerAdmin, GetAdminLevelName(pInfo[playerAdmin][e_Level]));
		SCM(playerAdmin, C_CARMINE, "Администратор "CT_YELLOW"%s "T_PID" назначил Вас - %s.", GetPlayerNameEx(playerid), playerid, GetAdminLevelName(pInfo[playerAdmin][e_Level]));
	}
	else {
		SCM(playerid, C_CARMINE, "Вы сняли игрока%s "T_PID" с админ прав.", GetPlayerNameEx(playerAdmin), playerAdmin);
		SCM(playerAdmin, C_CARMINE, "Администратор %s "T_PID" снял вас с админ прав.", GetPlayerNameEx(playerid), playerid);

		if (GetAdminSpectating(playerid)) {
			StopAdminSpectating(playerid);
		}
	}
	return 1;
}

CMD:makeadminoff(playerid, params[])
{
	new
		playerName[MAX_PLAYER_NAME];

	if (sscanf(params, "s["MAX_STR_PLAYER_NAME"]", playerName)) {
		return SendPlayerMessageCMD(playerid, "/makeadminoff [ник игрока]");
	}
	
	new
		player = GetNameID(playerName);

	if (player != INVALID_PLAYER_ID) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок в сети.");
		return 1;
	}

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckMakeAdminOff", "is["MAX_STR_PLAYER_NAME"]", playerid, playerName);
	return 1;
}

CMD:awarn(playerid, params[])
{
	new
		playerName[MAX_PLAYER_NAME];

	if (sscanf(params, "s["MAX_STR_PLAYER_NAME"]", playerName)) {
		return SendPlayerMessageCMD(playerid, "/awarn [ник игрока]");
	}

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckAdminWarn", "is["MAX_STR_PLAYER_NAME"]", playerid, playerName);
	return 1;
}

CMD:aunwarn(playerid, params[])
{
	new
		playerName[MAX_PLAYER_NAME];

	if (sscanf(params, "s["MAX_STR_PLAYER_NAME"]", playerName)) {
		return SendPlayerMessageCMD(playerid, "/unawarn [ник игрока]");
	}

	new 
		query[150];
	
	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ADMINS"` WHERE BINARY `"DB_ADMINS_NICKNAME"` = '%s'", playerName);
	mysql_tquery(MySQLID, query, "MySQLCheckAdminUnWarn", "is["MAX_STR_PLAYER_NAME"]", playerid, playerName);
	return 1;
}

CMD:changeservername(playerid, params[])
{
	new
		serverName[MAX_LENGTH_SERVER_NAME];

	if (sscanf(params, "s["MAX_STR_SERVER_NAME"]", serverName)) {
		return SendPlayerMessageCMD(playerid, "/changeservername [название]");
	}
	
	if (strlen(serverName) < 1 
	|| strlen(serverName) > MAX_LENGTH_SERVER_NAME) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Название меньше 1 и больше "MAX_STR_SERVER_NAME" букв запрещается!");
		return 1;
	}

	new
		str[100];

	f(str, "hostname %s", serverName);
	SendRconCommand(str);

	SCM(playerid, C_CARMINE, "Название сервера: "CT_YELLOW"%s", params[0]);
	return 1;
}

CMD:modes(playerid)
{
	Dialog_Show(playerid, Dialog:Mode_SelectMode);
	return 1;
}

CMD:setitem(playerid, params[])
{
	new
		playerItem, itemid, count;

	if (sscanf(params, "uii", playerItem, itemid, count)) {
		return SendPlayerMessageCMD(playerid, "/setitem [id игрока] [id предмета] [кол-во]");
	}

	if (!IsPlayerOnServer(playerItem)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (itemid >= GetInvMaxItems() 
	|| itemid < 1) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данного предмета не существует!");
		return 1;
	}

	if (count < 1) {
		return 1;
	}
	
	if (!CheckPlayerInvFullItem(playerItem, itemid, count)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"У игрока недостаточно места в инвентаре!");
		return 1;
	}

	GivePlayerInvItem(playerItem, itemid, count);

	SCM(playerid, C_CARMINE, "Игроку %s успешно выдан предмет %s в кол-ве %i", GetPlayerNameEx(playerItem), GetInvNameItem(itemid), count);
	SCM(playerItem, C_CARMINE, "Администратор %s выдал Вам предмет %s в кол-ве %i", GetPlayerNameEx(playerid), GetInvNameItem(itemid), count);
	return 1;
}

CMD:setbanner(playerid, params[])
{
	new
		playerBanner, bannerid, count;

	if (sscanf(params, "uii", playerBanner, bannerid, count)) {
		return SendPlayerMessageCMD(playerid, "/setbanner [id игрока] [id баннера] [кол-во]");
	}

	if (!IsPlayerOnServer(playerBanner)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (bannerid >= GetInvMaxBanners()
	|| bannerid < 1) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данного баннера не существует!");
		return 1;
	}

	if (count < 1) {
		return 1;
	}
	
	if (!CheckPlayerInvFullBanner(playerBanner, bannerid, count)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"У игрока недостаточно места в инвентаре!");
		return 1;
	}

	GivePlayerInvBanner(playerBanner, bannerid, count);

	SCM(playerid, C_CARMINE, "Игроку %s успешно выдан баннер %s в кол-ве %i", GetPlayerNameEx(playerBanner), GetInvNameBanner(bannerid), count);
	SCM(playerBanner, C_CARMINE, "Администратор %s выдал Вам баннер %s в кол-ве %i", GetPlayerNameEx(playerid), GetInvNameBanner(bannerid), count);
	return 1;
}

CMD:givegold(playerid, params[])
{
	new
		playerdGold, goldCoins;

	if (sscanf(params, "ui", playerdGold, goldCoins)) {
		return SendPlayerMessageCMD(playerid, "/givegold [id игрока] [goldCoins]");
	}

	if (!IsPlayerOnServer(playerdGold)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	GivePlayerGoldCoins(playerdGold, goldCoins);

	SCM(playerdGold, C_CARMINE, "Администратор %s "T_PID" выдал вам +%i GoldCoins", GetPlayerNameEx(playerid), playerid, goldCoins);
	SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано +%i GoldCoins", GetPlayerNameEx(playerdGold), playerdGold, goldCoins);

	SendAdminsMessage(C_CARMINE, "[A]: %s "T_PID" выдал Gold coins %s "T_PID" Gold coins: %i", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerdGold), playerdGold, goldCoins);
	return 1;
}

CMD:givecheat(playerid, params[])
{
	new
		playerECheat;

	if (sscanf(params, "u", playerECheat)) {
		return SendPlayerMessageCMD(playerid, "/givecheat [id игрока]");
	}

	if (!IsPlayerOnServer(playerECheat)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	n_for(i, 52)
		EnableAntiCheatForPlayer(playerECheat, i, 0);

	return 1;
}

/*
 * |>------------------<|
 * |     Interfaces     |
 * |>------------------<|
 */

/*
 * |>------------------<|
 * |   Admin spectate   |
 * |>------------------<|
 */

InterfaceCreate:AdminSpectate(playerid)
{
	CreatePlayerAdminSpectatingTD(playerid, TD_AdminSpectating[playerid]);
	
	n_for(i, ADMIN_TD_SPECTATING) {
		PlayerTextDrawShow(playerid, TD_AdminSpectating[playerid][i]);
	}

	SetPlayerClickTD(playerid, true);
	SelectTextDraw(playerid, TD_C_GREY);
	return 1;
}

InterfaceClose:AdminSpectate(playerid)
{
	n_for(i, ADMIN_TD_SPECTATING) {
		DestroyPlayerTD(playerid, TD_AdminSpectating[playerid][i]);
	}
	return 1;
}

InterfacePlayerClick:AdminSpectate(playerid, PlayerText:playertextid)
{
	if (playertextid == TD_AdminSpectating[playerid][1]) {
		SetPlayerIDStats(playerid, GetPlayerSpectating(playerid));
		Dialog_Show(playerid, Dialog:ChoosePlayerStats);
		return 1;
	}
	else if (playertextid == TD_AdminSpectating[playerid][2]) {
		Dialog_Show(playerid, Dialog:AdminBanPlayer);
	}
	else if (playertextid == TD_AdminSpectating[playerid][3]) {
		Dialog_Show(playerid, Dialog:AdminKickPlayer);
		return 1;
	}
	else if (playertextid == TD_AdminSpectating[playerid][4]) {
		new
			playerSpectating = GetPlayerSpectating(playerid),
			Float:slapX, Float:slapY, Float:slapZ;

		GetPlayerPos(playerSpectating, slapX, slapY, slapZ);
		
		SetPlayerPosEx(playerSpectating, slapX, slapY, slapZ + 5.0, 
		GetPlayerVirtualWorldEx(playerSpectating), GetPlayerInteriorEx(playerSpectating));
		
		PlayerPlaySoundEx(playerSpectating, 1130, slapX, slapY, slapZ + 5);
		SCM(playerSpectating, C_CARMINE, "Администратор %s "T_PID" подкинул Вас.", GetPlayerNameEx(playerid), playerid);
		return 1;
	}
	else if (playertextid == TD_AdminSpectating[playerid][5]) {
		new
			playerSpectating = GetPlayerSpectating(playerid);

		PlayerSpawn(playerSpectating);
		SCM(playerSpectating, C_CARMINE, "Администратор %s "T_PID" заспавнил Вас.", GetPlayerNameEx(playerid), playerid);
		return 1;
	}
	else if (playertextid == TD_AdminSpectating[playerid][6]) {
		if (GetAdminSpectating(playerid)) {
			StopAdminSpectating(playerid);
		}
		return 1;
	}
	else if (playertextid == TD_AdminSpectating[playerid][24]) {
		new
			playerSpectating = GetPlayerSpectating(playerid);

		if (GetAdminSpectating(playerid)) {
			if (GetPlayerVehicleIDEx(playerSpectating) != INVALID_VEHICLE_ID) {
				SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_PLAYER);
				PlayerSpectateVehicle(playerid, GetPlayerVehicleID(playerSpectating));
			}
			else {
				SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_VEHICLE);
				PlayerSpectatePlayer(playerid, playerSpectating);
			}
			UpdateAdminTDSpec(playerid, playerSpectating);
		}
		return 1;
	}
	return 1;
}

InterfaceClick:AdminSpectate(playerid, Text:clickedid)
{
	// Click escape
	if (clickedid == INVALID_TEXT_DRAW) {
		if (GetAdminSpectating(playerid)) {
			if (GetPlayerClickTD(playerid)) {
				SetPlayerClickTD(playerid, false);
				CancelSelectTextDraw(playerid);
				return 1;
			}
		}
	}
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

/*
 * |>---------------<|
 * |   Admin login   |
 * |>---------------<|
 */

DialogCreate:AdminLogin(playerid)
{
	new
		string[300];

	f(string, "{d4d4d4}Аккаунт {FFCC33}%s {d4d4d4}является администратором "CT_YELLOW"%i {d4d4d4}уровня.\
	\nВведите пароль от администрирования:\
	\n\n{4ecc47}* У Вас есть 60 секунд для входа в администрирование.", GetPlayerNameEx(playerid), GetAdminLevel(playerid));

	Dialog_Open(playerid, Dialog:AdminLogin, DSP, "{ff6d00}Вход в админ панель", string, "Ввод", "Выйти");
	return 1;
}

DialogResponse:AdminLogin(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Kick(playerid);
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:AdminLogin);
		return 1;
	}
	
	if (strcmp(pInfo[playerid][e_Key], inputtext, true)) {
		SCM(playerid, C_RED, "Ошибка: неверный пароль!");
		Dialog_Show(playerid, Dialog:AdminLogin);
		return 1;
	}

	KillPlayerLoggedTimer(playerid);

	SCM(playerid, C_GREEN, "Авторизация на администрирование прошла успешно!");
	SendAdminsMessage(C_CARMINE, "[A]: %s %s "T_PID" вошел в систему администрирования!", GetAdminLevelName(pInfo[playerid][e_Level]), GetPlayerNameEx(playerid), playerid);

	n_for(i, ADM_TD_MAX_CHEATERS) {
		TextDrawShowForPlayer(playerid, TD_Cheaters[i]);
	}

	n_for(i, 52) {
		EnableAntiCheatForPlayer(playerid, i, 0);
	}

	SetAdminORMData(playerid);

	ConnectPlayerServer(playerid);
	Mode_AddAdmin(Mode_GetPlayerMode(playerid), Mode_GetPlayerSession(playerid));
	return 1;
}

/*
 * |>-----------------------<|
 * |   List banned players   |
 * |>-----------------------<|
 */

DialogCreate:AdminListBan(playerid)
{
	Dialog_Open(playerid, Dialog:AdminListBan, DSL, "Список забаненых", strBig, "Выбор", "Назад");
	return 1;
}

DialogResponse:AdminListBan(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DialogUnbanName[playerid][0] = EOS;
		DialogFirstBL[playerid] = 0;
		Dialog_Show(playerid, Dialog:AdminMenu);
		return 1;
	}

	if (listitem == 20 
	|| listitem == 21) {
		CheckBanned(playerid, listitem);
	}
	else {
		strmid(DialogUnbanName[playerid], inputtext, 0, strlen(inputtext));
		
		if (GetString(inputtext, "<<< Назад")) {
			return CheckBanned(playerid, 21);
		}

		Dialog_Show(playerid, Dialog:AdminUnBan);

		//cache_delete(result);
	}
	return 1;
}

/*
 * |>----------------------<|
 * |   Admin unban player   |
 * |>----------------------<|
 */

DialogCreate:AdminUnBan(playerid)
{
	new 
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_BANS"` WHERE BINARY `"DB_BANS_PLAYER_NICKNAME"` = '%s' LIMIT 1", DialogUnbanName[playerid]);
	mysql_tquery(MySQLID, query, "MySQLCheckUnBanInfoPlayer", "i", playerid);
	return 1;
}

DialogResponse:AdminUnBan(playerid, response, listitem, inputtext[])
{
	if (!response) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок уже разбанен");
		return 1;
	}

	new
		query[150];

	mysql_format(MySQLID, query, sizeof(query), "SELECT `"DB_BANS_PLAYER_NICKNAME"` FROM `"DB_BANS"` WHERE BINARY `"DB_BANS_PLAYER_NICKNAME"` = '%s' LIMIT 1", DialogUnbanName[playerid]);
	mysql_tquery(MySQLID, query, "MySQLCheckPlayerBanned", "i", playerid);
	return 1;
}

/*
 * |>-----------------------<|
 * |   List admin commands   |
 * |>-----------------------<|
 */

DialogResponse:Adm_CommandsLvl(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:AdminCommands);
	return 1;
}

DialogCreate:AdminCommands(playerid)
{
	static
		strMain[500];

	strMain[0] = EOS;

	n_for(i, ADM_MAX_LEVELS) {
		f(strMain, "%s"CT_ORANGE""T_NUM" "CT_WHITE"%s [%i]\n", strMain, GetAdminLevelName(i + 1), i + 1);
	}

	Dialog_Open(playerid, Dialog:AdminCommands, DSL, "Команды администраторов", strMain, "Выбрать", "Назад");
	return 1;
}

DialogResponse:AdminCommands(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:AdminMenu);
		return 1;
	}

	static
		strHead[50],
		strMain[1500];

	strHead[0] =
	strMain[0] = EOS;

	new
		levelSelected = listitem + 1;

	f(strHead, "Команды уровня [%i]", levelSelected);

	n_for(i, ADM_MAX_COMMANDS) {
		if (GetAdminCommandLevel(i) == levelSelected) {
			f(strMain, "%s"CT_GREY"/%s "CT_WHITE"- %s.\n", strMain, GetAdminCommandName(i), GetAdminCommandInfo(i));
		}
	}
	
	Dialog_Open(playerid, Dialog:Adm_CommandsLvl, DSM, strHead, strMain, "Назад", "");
	return 1;
}

/*
 * |>---------------<|
 * |   Admin stats   |
 * |>---------------<|
 */

DialogCreate:AdminStats(playerid)
{
	static
		string[1000];

	string[0] = EOS;

	f(string, ""CT_GREY"Админ: "CT_YELLOW"[%s]\
	\n\n"CT_GREY"Уровень: "CT_WHITE"[%i] (%s)\
	\n"CT_GREY"Репутация: "CT_WHITE"[%i]\
	\n"CT_GREY"Выговоров: "CT_WHITE"[%i]\
	\n"CT_GREY"Кикнуто: "CT_WHITE"[%i]\
	\n"CT_GREY"Забанено: "CT_WHITE"[%i]\
	\n"CT_GREY"Разбанено: "CT_WHITE"[%i]\
	\n"CT_GREY"Мутов: "CT_WHITE"[%i]\
	\n"CT_GREY"Убрано мутов: "CT_WHITE"[%i]\
	\n"CT_GREY"Варнов: "CT_WHITE"[%i]\
	\n"CT_GREY"Убрано варнов: "CT_WHITE"[%i]\
	\n\n"CT_GREY"Дата выдачи админ прав: "CT_WHITE"[%s]\
	\n"CT_GREY"Последний заход на сервер: "CT_WHITE"[%s]", GetPlayerNameEx(playerid), pInfo[playerid][e_Level], GetAdminLevelName(pInfo[playerid][e_Level]), pInfo[playerid][e_Reputation], pInfo[playerid][e_Reprimands], pInfo[playerid][e_Kicks], pInfo[playerid][e_Bans], 
	pInfo[playerid][e_UnBans], pInfo[playerid][e_Muts], pInfo[playerid][e_UnMuts], 
	pInfo[playerid][e_Warns], pInfo[playerid][e_UnWarns],
	ShowDatetimeForPlayer(playerid, pInfo[playerid][e_RegDatetime]), ShowDatetimeForPlayer(playerid, GetPlayerLastDatetime(playerid)));
	Dialog_Message(playerid, "Статистика администратора", string, "Закрыть");
	return 1;
}

/*
 * |>---------------------<|
 * |   Admin warn player   |
 * |>---------------------<|
 */

DialogCreate:AdminWarnPlayer(playerid)
{
	Dialog_Open(playerid, Dialog:AdminWarnPlayer, DSI, "Выдать предупреждение игроку", 
	""CT_WHITE"Введите в строчку причину.\
	\n\nМаксимум 30 символов!",
	"Выдать", "Закрыть");
	return 1;
}

DialogResponse:AdminWarnPlayer(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	if (GetPlayerSpectating(playerid) == INVALID_PLAYER_ID) {
		return 1;
	}
	
	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:AdminWarnPlayer);
	}
	
	if (strlen(inputtext) > MAX_LENGTH_ADM_REASON) {
		return Dialog_Show(playerid, Dialog:AdminWarnPlayer);
	}

	new
		playerWarn = GetPlayerSpectating(playerid);

	GivePlayerWarns(playerWarn, 1);

	if (GetPlayerWarns(playerWarn) != 3) {
		pInfo[playerid][e_Warns]++;

		SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_WARNS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerWarns(playerWarn), GetPlayerMySQLID(playerWarn));

		SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано предупреждение [%i из 3]. Причина: %s", GetPlayerNameEx(playerWarn), playerWarn, GetPlayerWarns(playerWarn), inputtext);
		SCM(playerWarn, C_CARMINE, "Администратор %s "T_PID" выдал вам предупреждение [%i из 3]. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerWarns(playerWarn), inputtext);
		return 1;
	}
	else if (GetPlayerWarns(playerWarn) == 3) {
		pInfo[playerid][e_Warns]++;

		SCM(playerid, C_CARMINE, "Игроку %s "T_PID" выдано предупреждение [%i из 3]. Причина: %s", GetPlayerNameEx(playerWarn),playerWarn, GetPlayerWarns(playerWarn), inputtext);
		SCM(playerWarn, C_CARMINE, "Администратор %s "T_PID" выдал вам предупреждение [%i из 3]. Причина: %s", GetPlayerNameEx(playerid), playerid, GetPlayerWarns(playerWarn), inputtext);

		SetPlayerBan(GetPlayerNameEx(playerWarn), GetPlayerNameEx(playerid), 3, "Warns: 3");

		SCM(playerWarn, C_CARMINE, ""T_INFO" Вы получили бан на 3 дня за 3 предупреждения.");
		ResetPlayerWarns(playerWarn);

		SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_WARNS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerWarns(playerWarn), GetPlayerMySQLID(playerWarn));
		KickPlayerEx(playerWarn);
		return 1;
	}
	GivePlayerWarns(playerWarn, -1);
	SCM(playerWarn, C_RED, ""T_ERROR" "CT_WHITE"У данного игрока уже 3 предупреждения.");
	return 1;
}

/*
 * |>---------------------<|
 * |   Admin kick player   |
 * |>---------------------<|
 */

DialogCreate:AdminKickPlayer(playerid)
{
	Dialog_Open(playerid, Dialog:AdminKickPlayer, DSI, "Кикнуть игрока", 
	""CT_WHITE"Введите в строчку причину.\
	\n\nМаксимум "MAX_STR_ADM_REASON" символов!",
	"Кикнуть", "Закрыть");
	return 1;
}

DialogResponse:AdminKickPlayer(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	if (GetPlayerSpectating(playerid) == INVALID_PLAYER_ID) {
		return 1;
	}
	
	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:AdminKickPlayer);
		return 1;
	}

	if (strlen(inputtext) > MAX_LENGTH_ADM_REASON) {
		Dialog_Show(playerid, Dialog:AdminKickPlayer);
		return 1;
	}

	new
		strParams[MAX_LENGTH_NUM + 1 + MAX_LENGTH_ADM_REASON + 1];

	f(strParams, "%i %s", GetPlayerSpectating(playerid), inputtext);

	callcmd::kick(playerid, strParams);
	return 1;
}

/*
 * |>--------------------<|
 * |   Admin ban player   |
 * |>--------------------<|
 */

DialogCreate:AdminBanPlayer(playerid)
{
	Dialog_Open(playerid, Dialog:AdminBanPlayer, DSI, "Забанить игрока", 
	""CT_WHITE"Введите в строчку кол-во дней и причину.\
	\nВводить через запятую без пробелов ( 10,Чит ).\
	\n\nМаксимум "MAX_STR_ADM_REASON" символов!",
	"Бан", "Закрыть");
	return 1;
}

DialogResponse:AdminBanPlayer(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	if (GetPlayerSpectating(playerid) == INVALID_PLAYER_ID) {
		return 1;
	}

	if (!strlen(inputtext)) {
		return Dialog_Show(playerid, Dialog:AdminBanPlayer);
	}

	if (strlen(inputtext) > MAX_LENGTH_ADM_REASON) {
		return Dialog_Show(playerid, Dialog:AdminBanPlayer);
	}

	new 
		days, 
		reason[MAX_LENGTH_ADM_REASON];

	sscanf(inputtext, "p<,>ds["MAX_STR_ADM_REASON"]", days, reason);

	new
		strParams[(MAX_LENGTH_NUM * 2) + 2 + MAX_LENGTH_ADM_REASON + 1];

	f(strParams, "%i %i %s", GetPlayerSpectating(playerid), days, reason);

	callcmd::ban(playerid, strParams);
	return 1;
}

/*
 * |>----------------------<|
 * |   List admins online   |
 * |>----------------------<|
 */

DialogCreate:AdminOnline(playerid)
{
	static
		string[1500];

	string[0] = EOS;

	foreach (new p:TotalAdmins) {
		new
			str[200];

		f(str, ""CT_YELLOW"%s "T_PID" "CT_WHITE"[уровень: "CT_YELLOW"%i (%s)"CT_WHITE"]\n", GetPlayerNameEx(p), p, pInfo[p][e_Level], GetAdminLevelName(pInfo[p][e_Level]));
		strcat(string, str);
	}
	Dialog_Open(playerid, Dialog:AdminOnline, DSM, "Администрация в сети", string, "Назад", "");
	return 1;
}

DialogResponse:AdminOnline(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:AdminMenu);
	return 1;
}

/*
 * |>--------------<|
 * |   Admin menu   |
 * |>--------------<|
 */

DialogCreate:AdminMenu(playerid)
{
	Dialog_Open(playerid, Dialog:AdminMenu, DSL, "Панель администратора", "\
	"CT_ORANGE""T_NUM" "CT_WHITE"Команды администраторов\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Администрация в сети\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Список администраторов\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Список забаненых\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Очистить чат\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Заспавниться\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Починить транспорт\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Настройки сервера",
	"Выбрать", "Выход");
	return 1;
}

DialogResponse:AdminMenu(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:AdminCommands);
		}
		case 1: {
			callcmd::admins(playerid);
		}
		case 2: {
			// Total admins
			mysql_pquery(MySQLID, "\
			SELECT "DB_ADMINS_ID", "DB_ADMINS_NICKNAME", "DB_ADMINS_LEVEL", "DB_ADMINS_REG_DATETIME" \
			FROM "DB_ADMINS" \
			WHERE BINARY "DB_ADMINS_LEVEL" > 0 \
			ORDER BY "DB_ADMINS_LEVEL" DESC",
			"MySQLAllListAdminsLoaded", "d", playerid);
		}
		case 3: {
			callcmd::banlist(playerid);
		}
		case 4: {
			callcmd::clearchat(playerid);
			Dialog_Show(playerid, Dialog:AdminMenu);
		}
		case 5: {
			new
				strParams[MAX_LENGTH_NUM + 1];

			f(strParams, "%i", playerid);

			callcmd::aspawn(playerid, strParams);
		}
		case 6: {
			callcmd::fixveh(playerid);
			Dialog_Show(playerid, Dialog:AdminMenu);
		}
		case 7: {
			Dialog_Show(playerid, Dialog:AdminServerOptions);
		}
	}
	return 1;
}

/*
 * |>------------------<|
 * |   Server options   |
 * |>------------------<|
 */

DialogCreate:AdminServerOptions(playerid)
{
	Dialog_Open(playerid, Dialog:AdminServerOptions, DSL, "Настройки сервера",
	""CT_ORANGE""T_NUM" "CT_WHITE"Режимы\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Античит\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Промо-коды",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:AdminServerOptions(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:AdminMenu);
        return 1;
    }

	switch (listitem) {
		case 0: {
			callcmd::modes(playerid);
		}
		case 1: {
			callcmd::acheat(playerid);
		}
		case 2: {
			callcmd::promos(playerid);
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
 * |>------------------<|
 * |   OnGameModeInit   |
 * |>------------------<|
 */

public OnGameModeInit()
{
	// Iterators
	Iter_Init(AdminCountSpecPlayer);

	// Vehicles
	n_for(i, MAX_VEHICLES) {
		ActiveVehicleAdmin{i} = false;
	}

	// TextDraws cheaters
	n_for(i, ADM_TD_MAX_CHEATERS) {
		CheatersInfo[i][e_TDCheat] = INVALID_PLAYER_ID;
	}

	TotalCheaters = 0;

	new
		Float:DrawPos = 184.0;
	
	n_for(i, 10) {
		if (i > 0) {
			DrawPos += 30.0;
		}

		TD_Cheaters[i] = TextDrawCreate(DrawPos, 427.0, "-1");
		TextDrawLetterSize(TD_Cheaters[i], 0.3215, 1.3925);
		TextDrawTextSize(TD_Cheaters[i], -31.0000, 0.0000);
		TextDrawAlignment(TD_Cheaters[i], TEXT_DRAW_ALIGN_LEFT);
		TextDrawColour(TD_Cheaters[i], 0xef8100FF);
		TextDrawSetOutline(TD_Cheaters[i], 1);
		TextDrawBackgroundColour(TD_Cheaters[i], 96);
		TextDrawFont(TD_Cheaters[i], TEXT_DRAW_FONT_AHARONI_BOLD);
		TextDrawSetProportional(TD_Cheaters[i], true);
		TextDrawSetShadow(TD_Cheaters[i], 0);
	}

	#if defined Adm_OnGameModeInit
		return Adm_OnGameModeInit();
	#else
		return 1;
	#endif
}

/*
 * |>-------------<|
 * |   PC_OnInit   |
 * |>-------------<|
 */

stock Admin_PC_OnInit()
{
	AddAdminCommands();
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetAdminData(playerid);
	ResetAdminTDs(playerid);

	ActiveAdminSpectating{playerid} = false;

	AdminVehicleID[playerid] = INVALID_VEHICLE_ID;

	DialogFirstBL[playerid] = 0;
	DialogUnbanName[playerid][0] = EOS;

	#if defined Adm_OnPlayerConnect
		return Adm_OnPlayerConnect(playerid);
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
	n_for(i, ADM_TD_MAX_CHEATERS) {
		if (CheatersInfo[i][e_TDCheat] == playerid) {
			TextDrawSetString(TD_Cheaters[i], "-1");

			TotalCheaters++;

			if (TotalCheaters > 9) {
				TotalCheaters = 0;
			}
		}
	}

	if (AdminVehicleID[playerid] != INVALID_VEHICLE_ID) {
		ActiveVehicleAdmin[AdminVehicleID[playerid]] = false;
		DestroyVehicleEx(AdminVehicleID[playerid]);
	}

	// MySQL data
	if (GetAdminLevel(playerid) != ADM_LEVEL_NONE) {
		SavePlayerAdminData(playerid);
		orm_destroy(pInfo[playerid][e_ORM_ID]);
	}

	#if defined Adm_OnPlayerDisconnect
		return Adm_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}

/*
 * |>--------------------<|
 * |   OnPlayerClickMap   |
 * |>--------------------<|
 */

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if (GetAdminLevel(playerid) != ADM_LEVEL_NONE) {
		new
			vehicleid = GetPlayerVehicleIDEx(playerid);

		if (vehicleid != INVALID_VEHICLE_ID
		&& GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
			SetVehiclePos(vehicleid, fX, fY, fZ + 0.5);
		}
		else {
			SetPlayerPosEx(playerid, fX, fY, fZ, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		}
	}

	#if defined Adm_OnPlayerClickMap
		return Adm_OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ);
	#else
		return 1;
	#endif
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

stock Adm_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	#pragma unused oldkeys

	if (GetAdminSpectating(playerid)) {
		if (newkeys & KEY_FIRE) {
			SetPlayerClickTD(playerid, true);
			SelectTextDraw(playerid, TD_C_GREY);
		}
		return 1;
	}
	return 0;
}

/*
 * |>---------------------------<|
 * |   OnPlayerCommandReceived   |
 * |>---------------------------<|
 */

stock Adm_OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	#pragma unused cmd, params

	if (flags & CMD_FLAG_ADMIN) {
		if (((flags & CMD_FLAG_ADMIN_JUNIOR) && GetAdminLevel(playerid) < ADM_LEVEL_JUNIOR)
		|| ((flags & CMD_FLAG_ADMIN_SENIOR) && GetAdminLevel(playerid) < ADM_LEVEL_SENIOR)
		|| ((flags & CMD_FLAG_ADMIN_MAIN) && GetAdminLevel(playerid) < ADM_LEVEL_MAIN)
		|| ((flags & CMD_FLAG_ADMIN_SPECIAL) && GetAdminLevel(playerid) < ADM_LEVEL_SPECIAL)
		|| ((flags & CMD_FLAG_ADMIN_STEERING) && GetAdminLevel(playerid) < ADM_LEVEL_STEERING)
		|| ((flags & CMD_FLAG_ADMIN_FOUNDER) && GetAdminLevel(playerid) < ADM_LEVEL_FOUNDER)) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"У Вас недостаточно прав для данной команды.");
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

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Adm_OnGameModeInit
#if defined Adm_OnGameModeInit
	forward Adm_OnGameModeInit();
#endif


#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Adm_OnPlayerConnect
#if defined Adm_OnPlayerConnect
	forward Adm_OnPlayerConnect(playerid);
#endif


#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect Adm_OnPlayerDisconnect
#if defined Adm_OnPlayerDisconnect
	forward Adm_OnPlayerDisconnect(playerid, reason);
#endif


#if defined _ALS_OnPlayerClickMap
	#undef OnPlayerClickMap
#else
	#define _ALS_OnPlayerClickMap
#endif
#define OnPlayerClickMap Adm_OnPlayerClickMap
#if defined Adm_OnPlayerClickMap
	forward Adm_OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ);
#endif