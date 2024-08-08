/*

	About: Admin system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerDisconnect(playerid, reason)
		OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
		
		Call_AdmUpdateSpec(playerid)
		BanPlayer(name[], nameadmin[], days, reason[])
		OnAllAdminsLoaded(playerid)
		MysqlCheckBanned(playerid)
		UploadPlayerAdminID(playerid)
		Call_UpdateAdmin(playerid)
	Stock:
		Adm_SendMessages(color, stringru[])
		Adm_GetVehicle(vehicleid)
		Adm_UpdateSpectating(playerid)
		Adm_UpdateTDSpec(playerid, spectedid)
		Adm_SetPlayerSpectating(playerid, bool:type)
		Adm_GetPlayerSpectating(playerid)
		Adm_StopPlayersSpectating(playerid)
		Adm_HidePlayerSpectating(playerid, bool:remove = true)
		Adm_IsAdminsSpecPlayer(playerid)
		Adm_AddCheater(playerid)
		Adm_GetPlayerLevel(playerid)
		Adm_ErrorTextForAdmin(playerid)
		Adm_ErrorTextForPlayer(playerid)
		Adm_GetPlayersNotAdminsMode(mode_id, session_id)
		Adm_CheckPlayerForAdmin(playerid)
		Adm_UploadPlayerData(playerid) 
		UAD(playerid, const field[], data)
		DialogAdm_AnswerClose(playerid)
Enums:
	E_ADMIN_INFO
	E_CHEATER_INFO
Commands:
	report(playerid)
	amenu(playerid)
	a(playerid, params[])
	ot(playerid)
	sp(playerid, params[])
	offsp(playerid)
	checkstats(playerid, params[])
	aspawn(playerid, params[])
	slap(playerid, params[])
	jp(playerid, params[])
	admins(playerid)
	adminstats(playerid)
	asend(playerid, params[])
	gethere(playerid, params[])
	gotos(playerid, params[])
	getip(playerid, params[])
	getwarn(playerid, params[])
	z(playerid, params[])
	weap(playerid, params[])
	fixveh(playerid)
	fuelveh(playerid)
	rfixveh(playerid, params[])
	rfuelveh(playerid, params[])
	kick(playerid, params[])
	mute(playerid, params[])
	unmute(playerid, params[])
	sethp(playerid, params[])
	setarmour(playerid, params[])
	rsethp(playerid, params[])
	rsetarmour(playerid, params[])
	veh(playerid, params[])
	delveh(playerid)
	areferals(playerid, params[])
	ban(playerid, params[])
	unban(playerid, params[])
	sban(playerid, params[])
	banoff(playerid, params[])
	skick(playerid, params[])
	smute(playerid, params[])
	sunmute(playerid, params[])
	givegun(playerid, params[])
	rgivegun(playerid, params[])
	warn(playerid, params[])
	unwarn(playerid, params[])
	setskin(playerid, params[])
	rsetskin(playerid, params[])
	aset(playerid, params[])
	raset(playerid, params[])
	clearchat(playerid, params[])
	warnoff(playerid, params[])
	unwarnoff(playerid, params[])
	givemoney(playerid, params[])
	giverank(playerid, params[])
	givempoint(playerid, params[])
	adamage(playerid, params[])
	astats(playerid, params[])
	ao(playerid, params[])
	makeadmin(playerid, params[])
	makeadminoff(playerid, params[])
	awarn(playerid, params[])
	aunwarn(playerid, params[])
	changeservername(playerid, params[])
	mp(playerid)
	setitem(playerid, params[])
	setbanner(playerid, params[])
	dreports(playerid)
	givegold(playerid, params[])
	givecheat(playerid, params[])
Dialogs:
	Report
	Adm_AnswerEvalution
	Adm_Answer
	Adm_AnswerFromAdmin
	Adm_Login
	Adm_ListBan
	Adm_UnBan
	Adm_Commands
	Adm_Stats
	Adm_WarnPlayer
	Adm_KickPlayer
	Adm_BanPlayer
	Adm_Online
	Adm_Menu
	Adm_SelectMode
Interfaces:
	AdminSpectate
------------------------------------------------------------------------------*/

#if defined _INC_ADMIN_SYSTEM
	#endinput
#endif
#define _INC_ADMIN_SYSTEM

/*

	* Enums *

*/

enum E_ADMIN_INFO {
	ADM_ID,
	ADM_Level,
	ADM_Reputation,
	ADM_Key[5],
	ADM_Reprimands,
	ADM_Kicks,
	ADM_Bans,
	ADM_UnBans,
	ADM_Muts,
	ADM_UnMuts,
	ADM_Warns,
	ADM_UnWarns,
	ADM_Data[120]
}

enum E_CHEATER_INFO {
	td_cheat1
}

/*

	* Vars *

*/

static
	adm_PlayerInfo[MAX_PLAYERS][E_ADMIN_INFO];

static
	aCountReports[MAX_REPORTS] = {-1,...},
	aSlotReport[MAX_REPORTS] = {-1,...},
	aTextReport[MAX_REPORTS][250],

	aReport_Playerid[MAX_PLAYERS] = {-1,...},
	aEstimate_ReportAdmin[MAX_PLAYERS],
	aActionPlayerReportSend[MAX_PLAYERS],
	aPlayerReReport[MAX_PLAYERS];

static
	aDialogFirstBL[MAX_PLAYERS],
	aUnbanName[MAX_PLAYERS][MAX_PLAYER_NAME];

static
	PlayerText:TD_aPlayerSpec[MAX_PLAYERS][26],
	Text:TD_aCheaters[10];

static
	Float:aCheaters[ADM_TD_MAX_CHEATERS][E_CHEATER_INFO],
	aCheaters1;

static
	bool:aActivePlayerSpec[MAX_PLAYERS char];

static
	aAdminVehicle[MAX_PLAYERS],
	bool:aActiveAdminVehicle[MAX_VEHICLES char];

/*

	* Functions *

*/

stock Adm_SendMessages(color, string[])
{
	foreach(new a:admin_players) {
		SCM(a, color, string);
	}
	return 1;
}

stock Adm_GetVehicle(vehicleid)
{
	return aActiveAdminVehicle{vehicleid};
}

stock Adm_UpdateSpectating(playerid)
{
	SetPlayerTimer(playerid, "Call_AdmUpdateSpec", 300, false);
	return 1;
}

stock Adm_UpdateTDSpec(playerid, spectedid)
{
	static
		str[100];

	str[0] = EOS;

	f(str, "%s_[%i]", NameEx(spectedid), spectedid);
	PlayerTextDrawSetString(playerid, TD_aPlayerSpec[playerid][15], str);
	str[0] = EOS;

	f(str, "Mode/Session:_%s/%i", Mode_GetName(Mode_GetPlayer(spectedid)), Mode_GetPlayerSession(spectedid));
	PlayerTextDrawSetString(playerid, TD_aPlayerSpec[playerid][16], str);
	str[0] = EOS;

	new
		Float:health,
		Float:armour,
		weapon[WEAPON_NAME_MAX_LENGTH];

	GetPlayerHealth(spectedid, health);
	GetPlayerArmour(spectedid, armour);

	f(str, "Health/Armour:_%.0f/%.0f", health, armour);
	PlayerTextDrawSetString(playerid, TD_aPlayerSpec[playerid][17], str);
	str[0] = EOS;

	f(str, "Speed:_%i", GetPlayerSpeed(spectedid));
	PlayerTextDrawSetString(playerid, TD_aPlayerSpec[playerid][18], str);
	str[0] = EOS;

	GetWeaponName(GetPlayerWeapon(spectedid), weapon, sizeof(weapon));
	f(str, "Weapon:_%s", weapon);
	PlayerTextDrawSetString(playerid, TD_aPlayerSpec[playerid][19], str);
	str[0] = EOS;

	f(str, "Ammo:_%i", GetPlayerAmmo(spectedid));
	PlayerTextDrawSetString(playerid, TD_aPlayerSpec[playerid][20], str);
	str[0] = EOS;

	f(str, "Warns:_%i", pInfo[spectedid][pWarn]);
	PlayerTextDrawSetString(playerid, TD_aPlayerSpec[playerid][21], str);
	str[0] = EOS;

	f(str, "Ping:_%i", GetPlayerPing(spectedid));
	PlayerTextDrawSetString(playerid, TD_aPlayerSpec[playerid][22], str);
	str[0] = EOS;

	f(str, "FPS:_%i", GetPlayerFPS(spectedid));
	PlayerTextDrawSetString(playerid, TD_aPlayerSpec[playerid][23], str);
	str[0] = EOS;
	return 1;
}

stock Adm_SetPlayerSpectating(playerid, bool:type)
{
	aActivePlayerSpec{playerid} = type;
	return 1;
}

stock Adm_GetPlayerSpectating(playerid)
{
	return aActivePlayerSpec{playerid};
}

stock Adm_StopPlayersSpectating(playerid)
{
	Iter_Clear(spec_admin_playerid[playerid]);
	return 1;
}

stock Adm_HidePlayerSpectating(playerid, bool:remove = true)
{
	if(remove) {
		if(Iter_Count(spec_admin_playerid[GetPlayerSpectating(playerid)]))
			Iter_Remove(spec_admin_playerid[GetPlayerSpectating(playerid)], playerid);
	}

	SetPlayerSpectating(playerid, -1);
	SetPlayerSpecStatus(playerid, 0);

	SetPVarInt(playerid, "Room_Exit_PVar", 1);
	Mode_DestroyLocationPlayer(playerid);

	Adm_SetPlayerSpectating(playerid, false);
	SetPlayerCarabSpectating(playerid, false);

	Interface_Close(playerid, Interface:AdminSpectate);

	SpecPl(playerid, false);
	Mode_CreateLocationPlayer(playerid, MODE_NONE, 0);
	return 1;
}

stock Adm_IsAdminsSpecPlayer(playerid)
{
	if(Iter_Count(spec_admin_playerid[playerid]))
		return 1;
	
	return 0;
}

stock Adm_AddCheater(playerid)
{
	if(adm_PlayerInfo[playerid][ADM_Level])
		return 0;

	n_for(i, ADM_TD_MAX_CHEATERS) {
		if(aCheaters[i][td_cheat1] == playerid)
			return 0;
	}
	aCheaters[aCheaters1][td_cheat1] = playerid;

	new
		str[50];

	f(str, "%i", playerid);
	TextDrawSetString(TD_aCheaters[aCheaters1], str);

	aCheaters1++;

	if(aCheaters1 > 9)
		aCheaters1 = 0;
	
	return 1;
}

publics Call_AdmUpdateSpec(playerid)
{
	foreach(new p:spec_admin_playerid[playerid]) {
		if(GetPlayerVehicleIDEx(playerid) != -1) {
			SetPlayerSpecStatus(p, 1);
			PlayerSpectateVehicle(p, GetPlayerVehicleID(playerid));
		}
		else {
			SetPlayerSpecStatus(p, 2);
			PlayerSpectatePlayer(p, playerid);
		}	
	}
	return 1;
}

publics BanPlayer(name[], nameadmin[], days, reason[])
{
	new
		query[200];

	mysql_format(MysqlID, query, sizeof(query), "INSERT INTO `"T_BANS"` (`Name`, `BanAdmin`, `BanSeconds`, `BanReason`) VALUES ('%s', '%s', %i, '%s')",
	name, nameadmin, gettime() + days * 60 * 60 * 24, reason);

	mysql_tquery(MysqlID, query);
	return 1;
}

publics OnAllAdminsLoaded(playerid)
{
	new
		totalMembers = cache_num_rows();

	if(totalMembers) {
		new
			string[100],
			bigstring[1500],
			admin,
			membername[MAX_PLAYER_NAME],
			accountid,
			Data[50];

		if(strlen(bigstring) < 1)
			strcat(bigstring, "{CCCCCC}№\tУровень адм.\tНик\t\t\t\tДата поступления\n\n{FFFFFF}");

		n_for(i, totalMembers) {
			cache_get_value_name(i, "Name", membername, MAX_PLAYER_NAME);
			cache_get_value_name_int(i, "Level", admin);
			cache_get_value_name(i, "Data", Data);
			cache_get_value_name_int(i, "ID", accountid);

			f(bigstring, "%s%d\t%d\t\t%s\t\t\t%s\n", bigstring, accountid, admin, membername, Data);
		}
		f(string, "{FFFFFF}Всего {FFFF33}%d {FFFFFF}администраторов", totalMembers);
		Dialog_Message(playerid, string, bigstring, "Хорошо");
	}
	else {
		SCM(playerid, -1, "{CCCCCC}(Ошибка) {FFFFFF}Администраторы не найдены.");
		Dialog_Show(playerid, Dialog:Adm_Menu);
	}
	return 1;
}

publics MysqlCheckBanned(playerid)
{
	new
		Names[MAX_PLAYER_NAME],
		accounts;

	cache_get_row_count(accounts);
	if(!accounts) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Больше нет забаненных");
		return 1;
	}

	n_for(i, accounts) {
		cache_get_value_name(0, "Name", Names, MAX_PLAYER_NAME);
		f(stringer, "%s%s\n", stringer, Names);
	}

	if(accounts == 20)
		strcat(stringer, "{CCCCCC}Далее >>>\n");

	if(aDialogFirstBL[playerid])
		strcat(stringer, "{CCCCCC}<<< Назад");

	Dialog_Show(playerid, Dialog:Adm_ListBan);
	return 1;
}

stock Adm_GetPlayerLevel(playerid)
{
	return adm_PlayerInfo[playerid][ADM_Level];
}

stock Adm_ErrorTextForAdmin(playerid)
{
	SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}У вас недостаточно прав.");
	return 1;
}

stock Adm_ErrorTextForPlayer(playerid)
{
	SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данная команда только для администраторов.");
	return 0;
}

stock Adm_GetPlayersNotAdminsMode(mode_id, session_id)
{
	new
		players;

	m_for(mode_id, session_id, p) {
		if(Adm_GetPlayerSpectating(p))
			continue;

		players++;
	}
	return players;
}

stock Adm_CheckPlayerForAdmin(playerid)
{
	new
		query[100];

	mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", NameEx(playerid));
	mysql_query(MysqlID, query, true);

	new
		num_rows;

	cache_get_row_count(num_rows);
	if(num_rows) {
		TogglePlayerControllable(playerid, false);
		SetPlayerBusy(playerid, ADMIN_PASS);
		Adm_UploadPlayerData(playerid);
		Dialog_Show(playerid, Dialog:Adm_Login);
		SetPlayerLoggedTimer(playerid, 60000);
		return 1;
	}
	return 0;
}

static NumberReports()
{
	new
		number = 0;

	n_for(i, MAX_REPORTS) {
		if(aCountReports[i] == -1)
			continue;

		number++;
	}
	return number;
}

static IsBannedName(name[])
{
	new
		query[150];

	mysql_format(MysqlID, query, sizeof(query), "SELECT `Name` FROM `"T_BANS"` WHERE BINARY `Name` = '%s' LIMIT 1", name);

	new
		Cache:result = mysql_query(MysqlID, query),
		i;

	cache_get_row_count(i);
	cache_delete(result);
	return i;
}

static UnBanName(name[])
{
	new
		string[150];

	if(IsBannedName(name)) {
		mysql_format(MysqlID, string, sizeof(string), "DELETE FROM `"T_BANS"` WHERE BINARY `Name` = '%s'", name);
		mysql_tquery(MysqlID, string);
	}
	return 1;
}

static CheckBanned(playerid, listitem)
{
	if(listitem == 20)
		aDialogFirstBL[playerid] += 20;
	else
		aDialogFirstBL[playerid] -= 20;

	if(aDialogFirstBL[playerid] < 0) {
		aDialogFirstBL[playerid] = 0;

		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Больше нет забаненных");
		Dialog_Show(playerid, Dialog:Adm_Menu);
		return 1;
	}

	new
		query[300];

	mysql_format(MysqlID, query, sizeof(query), "SELECT `Name` FROM `"T_BANS"` ORDER BY `ID` DESC LIMIT %i , 20", aDialogFirstBL[playerid]);
	mysql_tquery(MysqlID, query, "MysqlCheckBanned", "d", playerid);
	return 1;
}

static ShowTDPlayerSP(playerid)
{
	// Задний фон 1
	TD_aPlayerSpec[playerid][0] = CreatePlayerTextDraw(playerid, 63.0000, 167.0000, "Box");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][0], 0.0000, 12.7333);
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][0], 140.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_aPlayerSpec[playerid][0], true);
	PlayerTextDrawBoxColour(playerid, TD_aPlayerSpec[playerid][0], -580583169);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][0], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][0], 0);

	// Статистика
	TD_aPlayerSpec[playerid][1] = CreatePlayerTextDraw(playerid, 63.0000, 168.0000, "_");
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][1], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][1], 976894719);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][1], false);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, TD_aPlayerSpec[playerid][1], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_aPlayerSpec[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_aPlayerSpec[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Забанить
	TD_aPlayerSpec[playerid][2] = CreatePlayerTextDraw(playerid, 63.0000, 187.0000, "_");
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][2], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][2], 976894719);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][2], false);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, TD_aPlayerSpec[playerid][2], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_aPlayerSpec[playerid][2], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_aPlayerSpec[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кикнуть
	TD_aPlayerSpec[playerid][3] = CreatePlayerTextDraw(playerid, 63.0000, 206.0000, "_");
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][3], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][3], 976894719);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][3], false);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, TD_aPlayerSpec[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_aPlayerSpec[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_aPlayerSpec[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Подкинуть
	TD_aPlayerSpec[playerid][4] = CreatePlayerTextDraw(playerid, 63.0000, 225.0000, "_");
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][4], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][4], 976894719);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][4], false);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_aPlayerSpec[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_aPlayerSpec[playerid][4], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_aPlayerSpec[playerid][4], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Спавн
	TD_aPlayerSpec[playerid][5] = CreatePlayerTextDraw(playerid, 63.0000, 244.0000, "_");
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][5], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][5], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][5], 976894719);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][5], false);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TD_aPlayerSpec[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_aPlayerSpec[playerid][5], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_aPlayerSpec[playerid][5], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Выход
	TD_aPlayerSpec[playerid][6] = CreatePlayerTextDraw(playerid, 63.0000, 263.0000, "_");
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][6], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][6], 976894719);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][6], false);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, TD_aPlayerSpec[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_aPlayerSpec[playerid][6], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_aPlayerSpec[playerid][6], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Статистика
	TD_aPlayerSpec[playerid][7] = CreatePlayerTextDraw(playerid, 102.0000, 170.0000, "Stats");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][7], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][7], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][7], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, TD_aPlayerSpec[playerid][7], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][7], 48);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][7], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][7], 0);

	// Забанить
	TD_aPlayerSpec[playerid][8] = CreatePlayerTextDraw(playerid, 102.0000, 189.0000, "Ban");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][8], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][8], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, TD_aPlayerSpec[playerid][8], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][8], 48);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][8], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][8], 0);

	// Кикнуть
	TD_aPlayerSpec[playerid][9] = CreatePlayerTextDraw(playerid, 102.0000, 208.0000, "Kick");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][9], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][9], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][9], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, TD_aPlayerSpec[playerid][9], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][9], 48);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][9], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][9], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][9], 0);

	// Подкинуть
	TD_aPlayerSpec[playerid][10] = CreatePlayerTextDraw(playerid, 102.0000, 227.0000, "Slap");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][10], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][10], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][10], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, TD_aPlayerSpec[playerid][10], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][10], 48);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][10], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][10], 0);

	// Спавн
	TD_aPlayerSpec[playerid][11] = CreatePlayerTextDraw(playerid, 102.0000, 246.0000, "Spawn");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][11], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][11], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][11], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, TD_aPlayerSpec[playerid][11], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][11], 48);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][11], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][11], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][11], 0);

	// Выход
	TD_aPlayerSpec[playerid][12] = CreatePlayerTextDraw(playerid, 102.0000, 265.0000, "Exit");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][12], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][12], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][12], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, TD_aPlayerSpec[playerid][12], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][12], 48);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][12], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][12], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][12], 0);

	// Задний фон 2
	TD_aPlayerSpec[playerid][13] = CreatePlayerTextDraw(playerid, 477.0000, 295.0000, "Box");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][13], 0.0000, 11.5999);
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][13], 570.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][13], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_aPlayerSpec[playerid][13], true);
	PlayerTextDrawBoxColour(playerid, TD_aPlayerSpec[playerid][13], 976894719);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][13], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][13], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][13], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][13], 0);

	// Задний фон 2
	TD_aPlayerSpec[playerid][14] = CreatePlayerTextDraw(playerid, 477.0000, 295.0000, "Box");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][14], 0.0000, 1.5000);
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][14], 570.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][14], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_aPlayerSpec[playerid][14], true);
	PlayerTextDrawBoxColour(playerid, TD_aPlayerSpec[playerid][14], -580583169);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][14], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][14], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][14], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][14], 0);

	// Nick
	TD_aPlayerSpec[playerid][15] = CreatePlayerTextDraw(playerid, 477.0000, 292.0000, "Nikita_Foxze_[300]");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][15], 0.1695, 1.8696);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][15], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][15], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][15], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][15], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][15], 0);

	// Mode/Session
	TD_aPlayerSpec[playerid][16] = CreatePlayerTextDraw(playerid, 477.0000, 311.0000, "Mode/Session:_TDM/1");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][16], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][16], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][16], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][16], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][16], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][16], 0);

	// Health/Armour
	TD_aPlayerSpec[playerid][17] = CreatePlayerTextDraw(playerid, 477.0000, 322.0000, "Health/Armour:_100./100.0");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][17], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][17], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][17], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][17], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][17], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][17], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][17], 0);

	// Speed
	TD_aPlayerSpec[playerid][18] = CreatePlayerTextDraw(playerid, 477.0000, 333.0000, "Speed:_1000");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][18], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][18], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][18], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][18], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][18], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][18], 0);

	// Weapon
	TD_aPlayerSpec[playerid][19] = CreatePlayerTextDraw(playerid, 477.0000, 344.0000, "Weapon:_Deagle");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][19], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][19], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][19], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][19], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][19], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][19], 0);

	// Ammo
	TD_aPlayerSpec[playerid][20] = CreatePlayerTextDraw(playerid, 477.0000, 354.0000, "Ammo:_1000");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][20], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][20], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][20], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][20], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][20], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][20], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][20], 0);

	// Warns
	TD_aPlayerSpec[playerid][21] = CreatePlayerTextDraw(playerid, 477.0000, 365.0000, "Warns:_3");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][21], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][21], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][21], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][21], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][21], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][21], 0);

	// Ping
	TD_aPlayerSpec[playerid][22] = CreatePlayerTextDraw(playerid, 477.0000, 376.0000, "Ping:_300");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][22], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][22], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][22], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][22], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][22], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][22], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][22], 0);

	// FPS
	TD_aPlayerSpec[playerid][23] = CreatePlayerTextDraw(playerid, 477.0000, 387.0000, "FPS:_100");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][23], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][23], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][23], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][23], 255);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][23], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][23], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][23], 0);

	// Задний фон обновления данных
	TD_aPlayerSpec[playerid][24] = CreatePlayerTextDraw(playerid, 476.0000, 404.0000, "_");
	PlayerTextDrawTextSize(playerid, TD_aPlayerSpec[playerid][24], 57.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][24], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][24], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][24], 976894719);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][24], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][24], false);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][24], 0);
	PlayerTextDrawSetSelectable(playerid, TD_aPlayerSpec[playerid][24], true);
	PlayerTextDrawSetPreviewModel(playerid, TD_aPlayerSpec[playerid][24], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_aPlayerSpec[playerid][24], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Обновление даннхы
	TD_aPlayerSpec[playerid][25] = CreatePlayerTextDraw(playerid, 484.0000, 406.0000, "UPDATE");
	PlayerTextDrawLetterSize(playerid, TD_aPlayerSpec[playerid][25], 0.2583, 1.7949);
	PlayerTextDrawAlignment(playerid, TD_aPlayerSpec[playerid][25], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_aPlayerSpec[playerid][25], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, TD_aPlayerSpec[playerid][25], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_aPlayerSpec[playerid][25], 48);
	PlayerTextDrawFont(playerid, TD_aPlayerSpec[playerid][25], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_aPlayerSpec[playerid][25], true);
	PlayerTextDrawSetShadow(playerid, TD_aPlayerSpec[playerid][25], 0);
	return 1;
}

/*

	* MySQL *

*/

stock Adm_UploadPlayerData(playerid)
{
	cache_get_value_name_int(0, "Level", adm_PlayerInfo[playerid][ADM_Level]);
	cache_get_value_name_int(0, "Reputation", adm_PlayerInfo[playerid][ADM_Reputation]);
	cache_get_value_name(0, "Key", adm_PlayerInfo[playerid][ADM_Key], 5);
	cache_get_value_name_int(0, "Reprimands", adm_PlayerInfo[playerid][ADM_Reprimands]);
	cache_get_value_name_int(0, "Kicks", adm_PlayerInfo[playerid][ADM_Kicks]);
	cache_get_value_name_int(0, "Bans", adm_PlayerInfo[playerid][ADM_Bans]);
	cache_get_value_name_int(0, "Unbans", adm_PlayerInfo[playerid][ADM_UnBans]);
	cache_get_value_name_int(0, "Muts", adm_PlayerInfo[playerid][ADM_Muts]);
	cache_get_value_name_int(0, "Unmuts", adm_PlayerInfo[playerid][ADM_UnMuts]);
	cache_get_value_name_int(0, "Warns", adm_PlayerInfo[playerid][ADM_Warns]);
	cache_get_value_name_int(0, "Unwarns", adm_PlayerInfo[playerid][ADM_UnWarns]);
	cache_get_value_name(0, "Data", adm_PlayerInfo[playerid][ADM_Data]);
	cache_get_value_name_int(0, "ID", adm_PlayerInfo[playerid][ADM_ID]);
	return 1;
}

publics UploadPlayerAdminID(playerid)
{
	adm_PlayerInfo[playerid][ADM_ID] = cache_insert_id();
}

stock UAD(playerid, const field[], data)
{
	new
		query[200];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ADMINS"` SET `%s` = '%d' WHERE `ID` = '%d' LIMIT 1", field, data, adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, query);
	return 1;
}

publics Call_UpdateAdmin(playerid)
{
	new
		str[600],
		num_rows;

	cache_get_row_count(num_rows);
	
	if(adm_PlayerInfo[playerid][ADM_Level]) {
		if(!num_rows) {
			strcat(adm_PlayerInfo[playerid][ADM_Key], GeneratePassword(4));

			mysql_format(MysqlID, str, sizeof(str), "INSERT INTO `"T_ADMINS"` (`Name`, `Level`, `Reputation`, `Key`, `Reprimands`, `Kicks`, `Bans`, `Unbans`, `Muts`, `Unmuts`, `Warns`, `Unwarns`, `Data`) VALUES ('%s', '%i', '%i', '%s', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', Now() + INTERVAL %i DAY)",
			NameEx(playerid), adm_PlayerInfo[playerid][ADM_Level], adm_PlayerInfo[playerid][ADM_Reputation], adm_PlayerInfo[playerid][ADM_Key], 
			adm_PlayerInfo[playerid][ADM_Reprimands], adm_PlayerInfo[playerid][ADM_Kicks], adm_PlayerInfo[playerid][ADM_Bans], adm_PlayerInfo[playerid][ADM_UnBans],
			adm_PlayerInfo[playerid][ADM_Muts], adm_PlayerInfo[playerid][ADM_UnMuts], adm_PlayerInfo[playerid][ADM_Warns], adm_PlayerInfo[playerid][ADM_UnWarns], 
			adm_PlayerInfo[playerid][ADM_Data]);

			mysql_tquery(MysqlID, str, "UploadPlayerAdminID", "i", playerid);
			str[0] = EOS;

			f(str, "{CC0033}(Пароль) {FFFFFF}Ваш личный пароль для администрирования: {CC0033}%s {CC0033}(запомните его и сделайте скриншот на F8)", adm_PlayerInfo[playerid][ADM_Key]);
			SCM(playerid, -1, str);

			Inv_SetPlayerItem(playerid, 399, 1);
			Inv_SetPlayerItem(playerid, 407, 1);
			Inv_SetPlayerItem(playerid, 277, 1);
			Inv_SetPlayerItem(playerid, 278, 1);
			Inv_SetPlayerItem(playerid, 279, 1);

			Iter_Add(admin_players, playerid);
			return 1;
		}
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Level` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Level], adm_PlayerInfo[playerid][ADM_ID]);
		mysql_tquery(MysqlID, str);
	}
	else {
		if(num_rows) {
			mysql_format(MysqlID, str, sizeof(str), "DELETE FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", NameEx(playerid));
			mysql_tquery(MysqlID, str);

			ResetPlayerData(playerid);
			Iter_Remove(admin_players, playerid);
		}
	}
	return 1;
}

/*

	* Reset *

*/

static ReportReset(i)
{
	aCountReports[i] =
	aSlotReport[i] = -1;
	aTextReport[i][0] = EOS;
	return 1;
}

static ReportResetAll() {
	n_for(j, MAX_REPORTS)
		ReportReset(j);

	foreach(Player, p) {
		if(!IsPlayerOnServer(p))
			continue;

		if(GetPlayerLogged(p))
			continue;

		aActionPlayerReportSend[p] = -1;
	}
	return 1;
}

static ResetPlayerData(playerid)
{
	adm_PlayerInfo[playerid][ADM_ID] = -1;
	adm_PlayerInfo[playerid][ADM_Level] =
	adm_PlayerInfo[playerid][ADM_Reputation] =
	adm_PlayerInfo[playerid][ADM_Reprimands] =
	adm_PlayerInfo[playerid][ADM_Kicks] =
	adm_PlayerInfo[playerid][ADM_Bans] =
	adm_PlayerInfo[playerid][ADM_UnBans] =
	adm_PlayerInfo[playerid][ADM_Muts] =
	adm_PlayerInfo[playerid][ADM_UnMuts] =
	adm_PlayerInfo[playerid][ADM_Warns] =
	adm_PlayerInfo[playerid][ADM_UnWarns] = 0;

	adm_PlayerInfo[playerid][ADM_Key][0] =
	adm_PlayerInfo[playerid][ADM_Data][0] = EOS;
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(i, sizeof(TD_aPlayerSpec[]))
		TD_aPlayerSpec[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	
	return 1;
}

/*

	* Commands *

*/

// Flags

flags:amenu(CMD_FLAG_ADMIN)
flags:a(CMD_FLAG_ADMIN)
flags:ot(CMD_FLAG_ADMIN)
flags:sp(CMD_FLAG_ADMIN)
flags:offsp(CMD_FLAG_ADMIN)
flags:checkstats(CMD_FLAG_ADMIN)
flags:aspawn(CMD_FLAG_ADMIN)
flags:slap(CMD_FLAG_ADMIN)
flags:jp(CMD_FLAG_ADMIN)
flags:admins(CMD_FLAG_ADMIN)
flags:adminstats(CMD_FLAG_ADMIN)
flags:asend(CMD_FLAG_ADMIN)
flags:gethere(CMD_FLAG_ADMIN)
flags:gotos(CMD_FLAG_ADMIN)
flags:getip(CMD_FLAG_ADMIN)
flags:getwarn(CMD_FLAG_ADMIN)
flags:z(CMD_FLAG_ADMIN)
flags:weap(CMD_FLAG_ADMIN)
flags:fixveh(CMD_FLAG_ADMIN)
flags:fuelveh(CMD_FLAG_ADMIN)
flags:rfixveh(CMD_FLAG_ADMIN)
flags:rfuelveh(CMD_FLAG_ADMIN)
flags:kick(CMD_FLAG_ADMIN)
flags:mute(CMD_FLAG_ADMIN)
flags:unmute(CMD_FLAG_ADMIN)
flags:sethp(CMD_FLAG_ADMIN)
flags:setarmour(CMD_FLAG_ADMIN)
flags:rsethp(CMD_FLAG_ADMIN)
flags:rsetarmour(CMD_FLAG_ADMIN)
flags:veh(CMD_FLAG_ADMIN)
flags:delveh(CMD_FLAG_ADMIN)
flags:areferals(CMD_FLAG_ADMIN)
flags:ban(CMD_FLAG_ADMIN)
flags:unban(CMD_FLAG_ADMIN)
flags:sban(CMD_FLAG_ADMIN)
flags:banoff(CMD_FLAG_ADMIN)
flags:skick(CMD_FLAG_ADMIN)
flags:smute(CMD_FLAG_ADMIN)
flags:sunmute(CMD_FLAG_ADMIN)
flags:givegun(CMD_FLAG_ADMIN)
flags:rgivegun(CMD_FLAG_ADMIN)
flags:warn(CMD_FLAG_ADMIN)
flags:unwarn(CMD_FLAG_ADMIN)
flags:setskin(CMD_FLAG_ADMIN)
flags:rsetskin(CMD_FLAG_ADMIN)
flags:aset(CMD_FLAG_ADMIN)
flags:raset(CMD_FLAG_ADMIN)
flags:clearchat(CMD_FLAG_ADMIN)
flags:warnoff(CMD_FLAG_ADMIN)
flags:unwarnoff(CMD_FLAG_ADMIN)
flags:givemoney(CMD_FLAG_ADMIN)
flags:giverank(CMD_FLAG_ADMIN)
flags:givempoint(CMD_FLAG_ADMIN)
flags:adamage(CMD_FLAG_ADMIN)
flags:astats(CMD_FLAG_ADMIN)
flags:ao(CMD_FLAG_ADMIN)
flags:makeadmin(CMD_FLAG_ADMIN)
flags:makeadminoff(CMD_FLAG_ADMIN)
flags:awarn(CMD_FLAG_ADMIN)
flags:aunwarn(CMD_FLAG_ADMIN)
flags:changeservername(CMD_FLAG_ADMIN)
flags:mp(CMD_FLAG_ADMIN)
flags:setitem(CMD_FLAG_ADMIN)
flags:setbanner(CMD_FLAG_ADMIN)
flags:dreports(CMD_FLAG_ADMIN)
flags:givegold(CMD_FLAG_ADMIN)
flags:givecheat(CMD_FLAG_ADMIN)

// Cmds

// Test

CMD:admintest(playerid)
{
	adm_PlayerInfo[playerid][ADM_Level] = ADM_LEVEL_FOUNDER;

	new
		str[300];

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", NameEx(playerid));
	mysql_tquery(MysqlID, str, "Call_UpdateAdminTEST", "i", playerid);
	str[0] = EOS;

	SCM(playerid, -1, "АДМИНКА ВЫДАНА!");
	return 1;
}

publics Call_UpdateAdminTEST(playerid)
{
	new 
		str[600],
		num_rows;

	cache_get_row_count(num_rows);
	
	if(!num_rows) {
		strcat(adm_PlayerInfo[playerid][ADM_Key], GeneratePassword(4));

		mysql_format(MysqlID, str, sizeof(str), "INSERT INTO `"T_ADMINS"` (`Name`, `Level`, `Reputation`, `Key`, `Reprimands`, `Kicks`, `Bans`, `Unbans`, `Muts`, `Unmuts`, `Warns`, `Unwarns`, `Data`) VALUES ('%s', '%i', '%i', '%s', '%i', '%i', '%i', '%i', '%i', '%i', '%i', '%i', Now() + INTERVAL %i DAY)",
		NameEx(playerid), adm_PlayerInfo[playerid][ADM_Level], adm_PlayerInfo[playerid][ADM_Reputation], adm_PlayerInfo[playerid][ADM_Key], 
		adm_PlayerInfo[playerid][ADM_Reprimands], adm_PlayerInfo[playerid][ADM_Kicks], adm_PlayerInfo[playerid][ADM_Bans], adm_PlayerInfo[playerid][ADM_UnBans],
		adm_PlayerInfo[playerid][ADM_Muts], adm_PlayerInfo[playerid][ADM_UnMuts], adm_PlayerInfo[playerid][ADM_Warns], adm_PlayerInfo[playerid][ADM_UnWarns], 
		adm_PlayerInfo[playerid][ADM_Data]);

		mysql_tquery(MysqlID, str, "UploadPlayerAdminID", "i", playerid);
		str[0] = EOS;

		f(str, "{CC0033}(Пароль) {FFFFFF}Ваш личный пароль для администрирования: {CC0033}%s {CC0033}(запомните его и сделайте скриншот на F8)", adm_PlayerInfo[playerid][ADM_Key]);
		SCM(playerid, -1, str);

		Inv_SetPlayerItem(playerid, 399, 1);
		Inv_SetPlayerItem(playerid, 407, 1);
		Inv_SetPlayerItem(playerid, 277, 1);
		Inv_SetPlayerItem(playerid, 278, 1);
		Inv_SetPlayerItem(playerid, 279, 1);

		Iter_Add(admin_players, playerid);
		return 1;
	}
	return 1;
}

//

CMD:report(playerid)
{
	if(!Iter_Count(admin_players)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Администрации нет в сети.");
		return 1;
	}
	if(aActionPlayerReportSend[playerid] == 1) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы уже отправили одно сообщение администрации.");
		return 1;
	}

	Dialog_Show(playerid, Dialog:Report);
	return 1;
}

CMD:amenu(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);
	
	Dialog_Show(playerid, Dialog:Adm_Menu);
	return 1;
}

CMD:a(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(isnull(params)) 
		return InformationTextCMD(playerid, "/a [текст]");

	static 
		str[300];

	str[0] = EOS;

	f(str, "{cc1836}[A]: {FFCC33}[%s] {FFFF33}%s (ID:%i): {FFFFFF}%s", GetAdminNameLevel(adm_PlayerInfo[playerid][ADM_Level]), NameEx(playerid), playerid, params);

	Adm_SendMessages(0xcc1836FF, str);
	return 1;
}

CMD:ot(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	n_for(i, MAX_REPORTS) {
		if(aCountReports[i] != -1) {
			if(aSlotReport[i] == 1) 
				continue;

			Dialog_Show(playerid, Dialog:Adm_Answer);

			static 
				str[93 - 4 + 1 + MAX_PLAYER_NAME + 3];
			
			str[0] = EOS;

			aReport_Playerid[playerid] = i;
			aSlotReport[i] = 1;

			f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}принялся за ваш репорт!", NameEx(playerid), playerid);
			SCM(aCountReports[i], -1, str);
			return 1;
		}
	}

	SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Сейчас нет вопросов в репорт!");
	return 1;
}

CMD:sp(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/sp [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(GetPlayerVehicleIDEx(playerid) > -1) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}В транспорте запрещено начинать слежку.");
		return 1;
	}
	if(GetSpecPl(params[0]) 
	|| GetPlayerSpectating(params[0]) > -1) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок находится в режиме слежки.");
		return 1;
	}
	if(GetPlayerCarabSpectating(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Сейчас Вам запрещено следить за кем-то.");
		return 1;
	}
	if(params[0] == playerid) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}За самим собой запрещено следить.");
		return 1;
	}

	if(!Adm_GetPlayerSpectating(playerid)) {
		Iter_Add(spec_admin_playerid[params[0]], playerid);

		SetPlayerSpectating(playerid, params[0]);

		Mode_DestroyLocationPlayer(playerid);
		Adm_SetPlayerSpectating(playerid, true);
		Mode_CreateLocationPlayer(playerid, Mode_GetPlayer(params[0]), Mode_GetPlayerSession(params[0]));

		SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorldEx(params[0]));
		SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(params[0]));

		SpecPl(playerid, true);

		if(IsPlayerInAnyVehicle(params[0])) {
			SetPlayerSpecStatus(playerid, 1);
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(params[0]));
		}
		else {
			SetPlayerSpecStatus(playerid, 2);
			PlayerSpectatePlayer(playerid, params[0]);
		}

		Interface_Show(playerid, Interface:AdminSpectate);

		new 
			strru[70 - 8 + 1 + MAX_PLAYER_NAME * 2 + 6];

		f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}начал слежку за {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
		Adm_SendMessages(0xcc1836FF, strru);
	}
	else {
		if(GetPlayerSpectating(playerid) > -1)
			Iter_Remove(spec_admin_playerid[GetPlayerSpectating(playerid)], playerid);

		Iter_Add(spec_admin_playerid[params[0]], playerid);

		SetPlayerSpectating(playerid, params[0]);

		if(!Mode_IsPlayerInPlayer(playerid, params[0])) {
			Mode_DestroyLocationPlayer(playerid);
			Mode_CreateLocationPlayer(playerid, Mode_GetPlayer(params[0]), Mode_GetPlayerSession(params[0]));
		}

		SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorldEx(params[0]));
		SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(params[0]));

		if(IsPlayerInAnyVehicle(params[0])) {
			SetPlayerSpecStatus(playerid, 1);
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(params[0]));
		}
		else {
			SetPlayerSpecStatus(playerid, 2);
			PlayerSpectatePlayer(playerid, params[0]);
		}

		new
			strru[70 - 8 + 1 + MAX_PLAYER_NAME * 2 + 6];

		f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}начал слежку за {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
		Adm_SendMessages(0xcc1836FF, strru);
	}
	return 1;
}

CMD:offsp(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(Adm_GetPlayerSpectating(playerid)) 
		Adm_HidePlayerSpectating(playerid);
	
	return 1;
}

CMD:checkstats(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/checkstats [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	SetPlayerIDStats(playerid, params[0]);
	Dialog_Show(playerid, Dialog:ChoosePlayerStats);
	return 1;
}

CMD:aspawn(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/aspawn [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(Mode_GetPlayer(params[0]) == MODE_NONE 
	|| GetPlayerBusy(params[0]) != GAME) {
		SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Игрок должен находиться в каком-нибудь режиме.");
		return 1;
	}

	PlayerSpawn(params[0]);
	return 1;
}

CMD:slap(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/slap [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	new
		string[90 - 4 + 1 + MAX_PLAYER_NAME];

	new
		Float:Slap_x,
		Float:Slap_y,
		Float:Slap_z;

	GetPlayerPos(params[0], Slap_x, Slap_y, Slap_z);
	SetPlayerPosEx(playerid, Slap_x, Slap_y, Slap_z + 5.0, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	PlayerPlaySoundEx(params[0], 1130, Slap_x, Slap_y, Slap_z + 5);

	f(string, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}подкинул вас.", NameEx(playerid), playerid);
	SCM(params[0], -1, string);
	return 1;
}

CMD:jp(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	return 1;
}

CMD:admins(playerid)
{
	if(Adm_GetPlayerLevel(playerid) >= ADM_LEVEL_JUNIOR || GetPlayerPremium(playerid))
		Dialog_Show(playerid, Dialog:Adm_Online);
	else
		Adm_ErrorTextForAdmin(playerid);

	return 1;
}

CMD:adminstats(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	Dialog_Show(playerid, Dialog:Adm_Stats);
	return 1;
}

CMD:asend(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_JUNIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "is[100]", params[0], params[1])) 
		return InformationTextCMD(playerid, "/asend [id игрока] [сообщение]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	static 
		str[300];

	str[0] = EOS;
	
	f(str, "{e3871e}[Администратор] %s [%i]: %s", NameEx(playerid), playerid, params[1]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{e3871e}[Игроку] %s [%i]: %s", NameEx(params[0]), params[0], params[1]);
	SCM(playerid, -1, str);
	return 1;
}

CMD:gethere(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/gethere [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(GetPlayerBusy(params[0]) != GAME) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}На данный момент игрок занят.");
		return 1;
	}
	if(GetPlayerSpectating(params[0]) > -1) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок за кем-то следит.");
		return 1;
	}

	if(!Mode_IsPlayerInPlayer(playerid, params[0])) {
		Mode_DestroyLocationPlayer(params[0]);
		Mode_CreateLocationPlayer(params[0], Mode_GetPlayer(playerid), Mode_GetPlayerSession(playerid));
	}

	SetPlayerVirtualWorldEx(params[0], GetPlayerVirtualWorldEx(playerid));
	SetPlayerInteriorEx(params[0], GetPlayerInteriorEx(playerid));

	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);
	SetPlayerPosEx(params[0], x + 0.5, y + 0.5, z + 0.5, GetPlayerVirtualWorldEx(params[0]), GetPlayerInteriorEx(params[0]));

	new
		strru[75 - 8 + 1 + MAX_PLAYER_NAME * 2 + 6];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}телепортировал к себе {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:gotos(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/gotos [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(GetPlayerBusy(params[0]) != GAME) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}На данный момент игрок занят.");
		return 1;
	}
	if(GetPlayerSpectating(params[0]) > -1) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок за кем-то следит.");
		return 1;
	}

	if(!Mode_IsPlayerInPlayer(playerid, params[0])) {
		Mode_DestroyLocationPlayer(playerid);
		Mode_CreateLocationPlayer(playerid, Mode_GetPlayer(params[0]), Mode_GetPlayerSession(params[0]));
	}

	SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorldEx(params[0]));
	SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(params[0]));

	new
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(params[0], x, y, z);
	SetPlayerPosEx(playerid, x + 0.5, y + 0.5, z + 0.5, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));

	new
		strru[75 - 8 + 1 + MAX_PLAYER_NAME * 2 + 6];

	f(strru,"{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}телепортировался к {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:getip(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);
	
	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/getip [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	new
		str[150];
	
	f(str, "{FFFF33}%s: {FFFFFF}Reg-IP [%s] IP [%s]", NameEx(params[0]), pInfo[params[0]][pIP], pInfo[params[0]][pOldIP]);
	SCM(playerid, -1, str);
	return 1;
}

CMD:getwarn(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/getwarn [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	new
		str[30 - 4 + 1 + MAX_PLAYER_NAME + 3];
	
	f(str, "{FFFF33}%s: {FFFFFF}Warns [%i]", NameEx(params[0]), pInfo[params[0]][pWarn]);
	SCM(playerid, -1, str);
	return 1;
}

CMD:z(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/z [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	static 
		str[90 - 4 + 1 + MAX_PLAYER_NAME + 3];

	str[0] = EOS;
	
	if(!GetPVarInt(params[0], "Z_PVar")) {
		SetPVarInt(params[0], "Z_PVar", 1);

		TogglePlayerControllable(params[0], false);
		PlayerPlaySoundEx(params[0], 40404, 0.0, 0.0, 0.0);

		f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}заморозил вас.", NameEx(playerid), playerid);
		SCM(params[0], -1, str);
		str[0] = EOS;

		f(str, "{CC0033}(Информация) {FFFFFF}Заморозка игрока {FFFF33}%s (ID:%i) {FFFFFF}прошла успешно.", NameEx(params[0]), params[0]);
		SCM(playerid, -1, str);
		str[0] = EOS;

		new 
			strru[65 - 8 + 1 + MAX_PLAYER_NAME * 2 + 6];

		f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}заморозил {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
		Adm_SendMessages(0xcc1836FF, strru);
	}
	else {
		DeletePVar(params[0], "Z_PVar");

		TogglePlayerControllable(params[0], true);
		PlayerPlaySoundEx(params[0], 40404, 0.0, 0.0, 0.0);

		f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}разморозил вас.", NameEx(playerid), playerid);
		SCM(params[0], -1, str);
		str[0] = EOS;

		f(str, "{CC0033}(Информация) {FFFFFF}Разморозка игрока {FFFF33}%s (ID:%i) {FFFFFF}прошла успешно.", NameEx(params[0]), params[0]);
		SCM(playerid, -1, str);
		str[0] = EOS;

		new 
			strru[65 - 8 + 1 + MAX_PLAYER_NAME * 2 + 6];
		
		f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}разморозил {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
		Adm_SendMessages(0xcc1836FF, strru);
	}
	return 1;
}

CMD:weap(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/weap [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	ResetPlayerWeaponsEx(params[0]);

	new
		str[150];

	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}забрал у вас всё оружие.", NameEx(playerid), playerid);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{CC0033}(Информация) {FFFFFF}Обнуление оружия у {FFFF33}%s (ID:%i) {FFFFFF}прошло успешно.", NameEx(params[0]), params[0]);
	SCM(playerid, -1, str);

	new
		strru[67 - 8 + 1 + MAX_PLAYER_NAME * 2 + 6];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}забрал оружие {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:fixveh(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(!IsPlayerInAnyVehicle(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы должны находится в транспорте.");
		return 1;
	}
	new
		vehicle = GetPlayerVehicleID(playerid);

	RepairVehicle(vehicle);
	return 1;
}

CMD:fuelveh(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);

	if(!IsPlayerInAnyVehicle(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы должны находится в транспорте.");
		return 1;
	}

	new
		vehicle = GetPlayerVehicleID(playerid);
	
	Veh_SetFuel(vehicle, VEHICLE_FUEL);
	return 1;
}

CMD:rfixveh(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);

	new
		Float:radius;

	if(sscanf(params, "f", radius)) 
		return InformationTextCMD(playerid, "/rfixveh [радиус]");
	
	if(radius < 1 
	|| radius > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	new
		vehicles,
		str[150];

	for(new i = 0, Float:x, Float:y, Float:z; i < MAX_VEHICLES; ++i) {
		if(!IsVehicleStreamedIn(i, playerid))
			continue;

		if(GetVehicleVirtualWorld(i) != GetPlayerVirtualWorldEx(playerid))
			continue;

		GetVehiclePos(i, x, y, z);
		if(!IsPlayerInRangeOfPoint(playerid, radius, x, y, z))
			continue;
	
		vehicles++;
		RepairVehicle(i);

		foreach(Player, p) {
			if(!IsPlayerOnServer(p)) 
				continue;
			
			if(IsPlayerInAnyVehicle(p)) {
				if(GetPlayerVehicleID(p) == i) {
					f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}починил транпорт.", NameEx(playerid), playerid, params[1]);
					SCM(p, -1, str);
					str[0] = EOS;
				}
			}
		}
	}
	f(str, "{CC0033}(Информация) {FFFFFF}Вы починили {FFFF33}%i {FFFFFF}транспорта", vehicles);
	SCM(playerid, -1, str);
	return 1;
}

CMD:rfuelveh(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SENIOR)
		return Adm_ErrorTextForAdmin(playerid);

	new
		Float:radius;

	if(sscanf(params, "f", radius)) 
		return InformationTextCMD(playerid, "/rfuelveh [радиус]");

	if(radius < 1 
	|| radius > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	new
		vehicles,
		str[150];

	for(new i = 0, Float:x, Float:y, Float:z; i < MAX_VEHICLES; ++i) {
		if(!IsVehicleStreamedIn(i, playerid))
			continue;

		if(GetVehicleVirtualWorld(i) != GetPlayerVirtualWorldEx(GetPlayerVirtualWorldEx(playerid)))
			continue;

		GetVehiclePos(i, x, y, z);

		if(!IsPlayerInRangeOfPoint(playerid, radius, x, y, z))
			continue;

		vehicles++;
		Veh_SetFuel(i, VEHICLE_FUEL);

		foreach(Player, p) {
			if(!IsPlayerOnServer(p)) 
				continue;
			
			if(IsPlayerInAnyVehicle(p)) {
				if(GetPlayerVehicleID(p) == i) {
					f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}пополнил бензин в транпорте.", NameEx(playerid), playerid, params[1]);
					SCM(p, -1, str);
					str[0] = EOS;
				}
			}
		}
	}

	f(str, "{CC0033}(Информация) {FFFFFF}Бензин пополнен в {FFFF33}%i {FFFFFF}транспорта", vehicles);
	SCM(playerid, -1, str);
	return 1;
}

CMD:kick(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "is[16]", params[0], params[1])) 
		return InformationTextCMD(playerid, "/kick [id игрока] [причина]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	adm_PlayerInfo[playerid][ADM_Kicks]++;

	new
		str[200];
	
	mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Kicks` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Kicks], adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, str);
	str[0] = EOS;

	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;
		
		f(str, "{FF6347}Администратор %s (ID:%i) кикнул %s (ID:%i) по причине: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
		SCM(p, -1, str);
		str[0] = EOS;
	}

	KickEx(params[0]);

	new
		strru[250];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}кикнул {e8c22c}%s [%i] {FFFFFF}по причине %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:mute(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "iis[30]", params[0], params[1], params[2])) 
		return InformationTextCMD(playerid, "/mute [id игрока] [минут] [причина]");
	
	if(params[1] < 1 
	|| params[1] > 20) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Меньше 0 и больше 20 минут запрещается!");
		return 1;
	}
	if(strlen(params[2]) > 29) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Больше 30 символов запрещено вводить.");
		return 1;
	}
	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(pInfo[params[0]][pMute] > gettime()) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок уже заткнут.");
		return 1;
	}

	adm_PlayerInfo[playerid][ADM_Muts]++;

	new
		str[200];
	
	mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Muts` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Muts], adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, str);
	str[0] = EOS;

	pInfo[params[0]][pMute] = gettime() + params[1] * 60;

	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;

		f(str, "{FF6347}Администратор %s (ID:%i) заткнул игрока %s (ID:%i) на %i минут. Причина: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1], params[2]);
		SCM(p, -1, str);
		str[0] = EOS;
	}

	new
		strru[250];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал мут {e8c22c}%s [%i] {FFFFFF}по причине %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[2]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:unmute(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/unmute [id игрока]");

	if(pInfo[params[0]][pMute] < gettime()) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}У данного игрока нет мута.");
		return 1;
	}
	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	adm_PlayerInfo[playerid][ADM_UnMuts]++;

	new
		str[150];
	
	mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Unmuts` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_UnMuts], adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, str);
	str[0] = EOS;

	pInfo[params[0]][pMute] = 0;

	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;

		f(str, "{FF6347}Администратор %s (ID:%i) снял мут у игрока %s (ID:%i)", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
		SCM(p, -1, str);
		str[0] = EOS;
	}
	return 1;
}

CMD:sethp(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "ii", params[0], params[1])) 
		return InformationTextCMD(playerid, "/sethp [id игрока] [здоровье]");
	
	if(params[1] < 0 
	|| params[1] > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Меньше 0 и больше 100 запрещается!");
		return 1;
	}
	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	SetPlayerHealthEx(params[0], params[1]);

	new
		str[200];
	
	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал {CC0033}%i {FFFFFF}здоровья", NameEx(playerid), playerid, params[1]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}выдано {CC0033}%i {FFFFFF}здоровья", NameEx(params[0]), params[0], params[1]);
	SCM(playerid, -1, str);

	new
		strru[250];
	
	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал здоровье {e8c22c}%s [%i] {FFFFFF}Здоровья: %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:setarmour(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "ii", params[0], params[1])) 
		return InformationTextCMD(playerid, "/setarmour [id игрока] [броня]");
	
	if(params[1] < 0 
	|| params[1] > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Меньше 0 и больше 100 запрещается!");
		return 1;
	}
	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	SetPlayerArmourEx(params[0], params[1]);

	new
		str[200];
	
	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал {3366FF}%i {FFFFFF}брони", NameEx(playerid), playerid, params[1]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}выдано {3366FF}%i {FFFFFF}брони", NameEx(params[0]), params[0], params[1]);
	SCM(playerid, -1, str);

	new
		strru[250];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал броню {e8c22c}%s [%i] {FFFFFF}Брони: %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:rsethp(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);
	
	new
		Float:radius;
	
	if(sscanf(params, "fi", radius, params[1])) 
		return InformationTextCMD(playerid, "/rsethp [радиус] [здоровья]");
	
	if(radius < 1 
	|| radius > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}
	if(params[1] < 0 
	|| params[1] > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Здоровья меньше 0 и больше 100 запрещается!");
		return 1;
	}

	new
		players,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	new
		str[200];
	
	foreach(Player, p) {
		if(!IsPlayerOnServer(p))
			continue;

		if(Mode_GetPlayer(p) != Mode_GetPlayer(playerid))
			continue;

		if(GetPlayerBusy(p) != GAME)
			continue;

		if(IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			SetPlayerHealthEx(p, params[1]);
			players++;

			f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал {CC0033}%i {FFFFFF}здоровья", NameEx(playerid), playerid, params[1]);
			SCM(p, -1, str);
			str[0] = EOS;
		}
	}

	f(str, "{CC0033}(Информация) {FFFFFF}Выдано {FFFF33}%i {FFFFFF}игрокам заданное здоровье", players);
	SCM(playerid, -1, str);

	new
		strru[250];
	
	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал здоровье в радиусе %i {FFFFFF}Здоровья: %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], radius, params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:rsetarmour(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);

	new
		Float:radius;
	
	if(sscanf(params, "fi", radius, params[1])) 
		return InformationTextCMD(playerid, "/rsetarmour [радиус] [броня]");
	
	if(radius < 1 
	|| radius > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}
	if(params[1] < 0 
	|| params[1] > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Брони меньше 0 и больше 100 запрещается!");
		return 1;
	}

	new
		players,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	new
		str[200];
	
	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;

		if(Mode_GetPlayer(p) != Mode_GetPlayer(playerid))
			continue;

		if(GetPlayerBusy(p) != GAME)
			continue;

		if(IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			SetPlayerArmourEx(p, params[1]);
			players++;

			f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал {3366FF}%i {FFFFFF}брони", NameEx(playerid), playerid, params[1]);
			SCM(p, -1, str);
			str[0] = EOS;
		}
	}

	f(str, "{CC0033}(Информация) {FFFFFF}Выдано {FFFF33}%i {FFFFFF}игрокам заданная броня", players);
	SCM(playerid, -1, str);

	new
		strru[250];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал броню в радиусе %i {FFFFFF}Брони: %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], radius, params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:veh(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params,"iii", params[0], params[1], params[2])) 
		return InformationTextCMD(playerid, "/veh [id машины] [id цвета №1] [id цвета №2]");
	
	if(params[0] < 400 
	|| params[0] > 611) 
		return SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}ID машины должен быть от 400 до 611!");

	if(params[1] < 0 
	|| params[1] > 255) 
		return SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}ID цвета машины должен быть от 0 до 255!");

	if(params[2] < 0 
	|| params[2] > 255) 
		return SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}ID цвета машины должен быть от 0 до 255!");

	RemovePlayerFromVehicle(playerid);
	TogglePlayerControllable(playerid, true);

	if(aAdminVehicle[playerid] != INVALID_VEHICLE_ID) {
		aActiveAdminVehicle{aAdminVehicle[playerid]} = false;
		DestroyVehicleEx(aAdminVehicle[playerid]);
	}

	new
		Float:X,
		Float:Y,
		Float:Z,
		Float:Angle;

	GetPlayerFacingAngle(playerid, Angle);
	GetPlayerPos(playerid, X, Y, Z);

	aAdminVehicle[playerid] = CreateVehicle(params[0], X, Y, Z, Angle, params[1], params[2], VEHICLE_RESPAWN_TIME);

	new
		veh_id = aAdminVehicle[playerid];

	SetVehicleVirtualWorld(veh_id, GetPlayerVirtualWorldEx(playerid));
	LinkVehicleToInterior(veh_id, GetPlayerInteriorEx(playerid));
	Veh_SetFuel(veh_id, VEHICLE_FUEL);

	aActiveAdminVehicle{veh_id} = true;
	PutPlayerInVehicle(playerid, veh_id, 0);

	if(CheckIDVehicleBike(GetVehicleModel(veh_id))) {
		new 
			engine,
			lights,
			alarm,
			bonnet,
			boot,
			objective,
			doors;

		GetVehicleParamsEx(veh_id, engine, lights, alarm, doors, bonnet, boot, objective);
		SetVehicleParamsEx(veh_id, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
	}

	new
		str[150];

	f(str, "{CC0033}(Информация) {FFFFFF}Транспорт ID: %i создан. Для удаления транспорта введите: {FFFF33}/delveh", params[0]);
	SCM(playerid, -1, str);

	new
		strru[150];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}создал транспорт", NameEx(playerid), playerid);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:delveh(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);

	if(aAdminVehicle[playerid] == INVALID_VEHICLE_ID) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Нет созданного транспорта.");
		return 1;
	}

	aActiveAdminVehicle{aAdminVehicle[playerid]} = false;
	DestroyVehicleEx(aAdminVehicle[playerid]);

	SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Транспорт успешно удален.");

	new
		strru[150];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}удалил транспорт", NameEx(playerid), playerid);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:areferals(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_MAIN)
		return Adm_ErrorTextForAdmin(playerid);

	new
		Namep[MAX_PLAYER_NAME];

	if(sscanf(params, "s[24]", Namep)) 
		return InformationTextCMD(playerid, "/areferals [ник игрока]");

	new
		query[150];

	mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s'", Namep);
	mysql_query(MysqlID, query, true);

	new
		num_rows;

	cache_get_row_count(num_rows);
	if(!num_rows) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не найден.");
		return 1;
	}
	query[0] = EOS;

	SetCheckNameReferal(playerid, Namep);
	Dialog_Show(playerid, Dialog:Referals);
	return 1;
}

CMD:ban(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "iis[50]", params[0], params[1], params[2])) 
		return InformationTextCMD(playerid, "/ban [id игрока] [дней] [причина]");
	
	if(params[1] < 0 
	|| params[1] > 30) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Возможно только от 1 дня до 30 дней.");
		return 1;
	}
	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(adm_PlayerInfo[playerid][ADM_Level] < adm_PlayerInfo[params[0]][ADM_Level]) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный администратор выше вас по должности.");
		return 1;
	}

	adm_PlayerInfo[playerid][ADM_Bans]++;
	
	new
		query[150];
	
	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ADMINS"` SET `Bans` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Bans], adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, query);

	new 
		str[200];
	
	foreach(Player, p) {
		if(!IsPlayerOnServer(p))
			continue;

		new
			dName[10];
		
		switch(params[1]) {
			case 1, 21: dName = "день";
			case 2, 3, 4, 22, 23, 24: dName = "дня";
			case 5..20, 25..30: dName = "дней";
		}

		f(str, "{FF6347}Администратор %s (ID:%i) забанил %s (ID:%i) на %i %s. Причина: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1], dName, params[2]);
		SCM(p, -1, str);
		str[0] = EOS;
	}

	BanPlayer(NameEx(params[0]), NameEx(playerid), params[1], params[2]);
	KickEx(params[0]);

	new 
		strru[250];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}забанил {e8c22c}%s [%i] {FFFFFF}по причине %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[2]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:unban(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	new
		name[MAX_PLAYER_NAME];

	if(sscanf(params, "s[25]", name)) 
		return InformationTextCMD(playerid, "/unban [ник игрока]");

	mysql_escape_string(name, name);

	new
		str[60 + MAX_PLAYER_NAME];
	
	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_BANS"` WHERE BINARY `Name` = '%s'", name);

	new
		num_rowsss,
		Cache:result = mysql_query(MysqlID, str, true);
	
	cache_get_row_count(num_rowsss);
	if(!num_rowsss) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный игрок не забанен.");
		return 1;
	}
	mysql_escape_string(name, aUnbanName[playerid]);

	Dialog_Show(playerid, Dialog:Adm_UnBan);

	cache_delete(result);
	return 1;
}

CMD:sban(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "iis[50]", params[0], params[1], params[2])) 
		return InformationTextCMD(playerid, "/sban [id игрока] [дней] [причина]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(adm_PlayerInfo[playerid][ADM_Level] < adm_PlayerInfo[params[0]][ADM_Level]) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный администратор выше вас по уровню.");
		return 1;
	}
	if(params[1] < 1 
	|| params[1] > 30) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Возможно только от 1 дня до 30 дней.");
		return 1;
	}

	adm_PlayerInfo[playerid][ADM_Bans]++;

	new
		str[200];
	
	mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Bans` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Bans], adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, str);

	str[0] = EOS;

	new
		dName[10];
	
	switch(params[1]) {
		case 1, 21: dName = "день";
		case 2, 3, 4, 22, 23, 24: dName = "дня";
		case 5..20, 25..30: dName = "дней";
	}

	f(str, "{FF6347}Администратор %s (ID:%i) забанил %s (ID:%i) на %i %s. Причина: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1], dName, params[2]);
	SCM(params[0], -1, str);

	str[0] = EOS;

	f(str, "{FF6347}Администратор %s (ID:%i) забанил %s (ID:%i) на %i %s. Причина: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1], dName, params[2]);
	SCM(playerid, -1, str);

	BanPlayer(NameEx(params[0]), NameEx(playerid), params[1], params[2]);
	KickEx(params[0]);

	new 
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}по тихому забанил {e8c22c}%s [%i] {FFFFFF}по причине %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[2]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:banoff(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	new
		name[MAX_PLAYER_NAME],
		day,
		reason[50];

	if(sscanf(params, "s[25]is[50]", name, day, reason)) 
		return InformationTextCMD(playerid, "/banoff [ник игрока] [дней] [причина]");
	
	if(day < 1 
	|| day > 30) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Возможно только от 1 дня до 30 дней.");
		return 1;
	}

	new
		player = GetNameID(name);

	if(player != INVALID_PLAYER_ID) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок в сети.");
		return 1;
	}

	mysql_escape_string(name, name);

	new
		str[200];
	
	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_BANS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rowsss;
	
	cache_get_row_count(num_rowsss);
	if(num_rowsss) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный игрок уже забанен.");
		return 1;
	}
	str[0] = EOS;

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rowss;
	
	cache_get_row_count(num_rowss);
	if(num_rowss) {
		new
			AdminLevel;

		cache_get_value_name_int(0, "Level", AdminLevel);
		if(adm_PlayerInfo[playerid][ADM_Level] < AdminLevel) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный администратор выше вас по должности.");
			return 1;
		}
	}
	str[0] = EOS;

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rows;
	
	cache_get_row_count(num_rows);
	if(!num_rows) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не найден.");
		return 1;
	}
	str[0] = EOS;

	adm_PlayerInfo[playerid][ADM_Bans]++;
	mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Bans` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Bans], adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, str);
	str[0] = EOS;

	f(str, "{FF6347}Игрок %s забанен на %i дней. Причина: %s", name, day, reason);
	SCM(playerid, -1, str);

	BanPlayer(name, NameEx(playerid), day, reason);
	return 1;
}

CMD:skick(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "is[50]", params[0], params[1])) 
		return InformationTextCMD(playerid, "/skick [id игрока] [причина]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	adm_PlayerInfo[playerid][ADM_Kicks]++;
	
	new 
		str[200];
	
	mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Kicks` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Kicks], adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, str);
	str[0] = EOS;

	f(str, "{FF6347}Администратор %s (ID:%i) кикнул по %s (ID:%i) по причине: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{FF6347}Администратор %s (ID:%i) кикнул %s (ID:%i) по причине: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	SCM(playerid, -1, str);

	KickEx(params[0]);

	new 
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}по тихому кикнул {e8c22c}%s [%i] {FFFFFF}по причине %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:smute(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "iis[50]", params[0], params[1], params[2])) 
		return InformationTextCMD(playerid, "/smute [id игрока] [минут] [причина]");
	
	if(params[1] < 1 
	|| params[1] > 20) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Меньше 0 и больше 20 минут запрещается!");
		return 1;
	}
	if(strlen(params[2]) > 29) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Больше 30 символов запрещено вводить.");
		return 1;
	}
	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(pInfo[params[0]][pMute] > gettime()) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок уже заткнут.");
		return 1;
	}

	adm_PlayerInfo[playerid][ADM_Muts]++;
	
	new
		str[200];
	
	mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Muts` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Muts], adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, str);
	str[0] = EOS;

	pInfo[params[0]][pMute] = gettime() + params[1] * 60;

	f(str, "{FF6347}Администратор %s (ID:%i) заткнул игрока %s (ID:%i) на %i минут. Причина: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1], params[2]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{FF6347}Администратор %s (ID:%i) заткнул игрока %s (ID:%i) на %i минут. Причина: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1], params[2]);
	SCM(playerid, -1, str);

	new 
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}по тихому выдал мут {e8c22c}%s [%i] {FFFFFF}по причине %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[2]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:sunmute(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/sunmute [id игрока]");

	if(pInfo[params[0]][pMute] < gettime()) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}У данного игрока нет мута.");
		return 1;
	}
	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	adm_PlayerInfo[playerid][ADM_UnMuts]++;
	
	new
		str[200];
	
	mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Unmuts` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_UnMuts], adm_PlayerInfo[playerid][ADM_ID]);
	mysql_tquery(MysqlID, str);
	str[0] = EOS;

	pInfo[params[0]][pMute] = 0;

	f(str, "{FF6347}Администратор %s (ID:%i) убрал мут у игрока %s (ID:%i)", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{FF6347}Администратор %s (ID:%i) убрал мут у игрока %s (ID:%i)", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
	SCM(playerid, -1, str);
	return 1;
}

CMD:givegun(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "iii", params[0], params[1], params[2])) 
		return InformationTextCMD(playerid, "/givegun [id игрока] [id оружия] [кол-во патронов]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(params[1] < 1 
	|| params[1] > 43) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}ID оружия меньше 1 и больше 43 запрещено!");
		return 1;
	}
	if(params[2] < 1 
	|| params[2] > 500) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Меньше 1 и больше 500 патронов запрещено!");
		return 1;
	}

	GivePlayerWeaponEx(params[0], params[1], params[2]);

	new
		str[300],
		nameweapon[100];

	GetWeaponNameRU(params[1], nameweapon, sizeof(nameweapon));
	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал вам оружие {59F320}%s {FFFFFF}патронов: {59F320}%i", NameEx(playerid), playerid, nameweapon, params[2]);

	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{CC0033}(Информация) {FFFFFF}Выдано игроку {FFFF33}%s (ID:%i) {FFFFFF}оружие {59F320}%s {FFFFFF}патронов: {59F320}%i", NameEx(params[0]), params[0], nameweapon, params[2]);
	SCM(playerid, -1, str);

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал оружие {e8c22c}%s [%i] {FFFFFF}Оружие: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], nameweapon);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:rgivegun(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	new
		Float:radius;

	if(sscanf(params, "fii", radius, params[1], params[2])) 
		return InformationTextCMD(playerid, "/rgivegun [радиус] [id оружия] [кол-во патронов]");
	
	if(radius < 1 
	|| radius > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}
	if(params[1] < 1 
	|| params[1] > 43) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Оружие меньше 1 и больше 43 запрещается!");
		return 1;
	}

	new
		players,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	new
		str[300];
	
	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;

		if(Mode_GetPlayer(p) != Mode_GetPlayer(playerid)) 
			continue;

		if(GetPlayerBusy(p) != GAME) 
			continue;

		if(IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			GivePlayerWeaponEx(p, params[1], params[2]);
			players++;

			new 
				nameweapon[100];
			
			GetWeaponNameRU(params[2], nameweapon, sizeof(nameweapon));
			f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал оружие {3366FF}%s {FFFFFF}патронов: {59F320}%i", NameEx(playerid), playerid, nameweapon, params[2]);
		
			SCM(p, -1, str);
			str[0] = EOS;
		}
	}

	f(str, "{CC0033}(Информация) {FFFFFF}Выдано {FFFF33}%i {FFFFFF}игрокам заданное оружие", players);
	SCM(playerid, -1, str);

	new
		nameweapon[100];
	
	GetWeaponName(params[2], nameweapon, sizeof(nameweapon));

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал оружие в радиусе %i {FFFFFF}Оружие: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], radius, nameweapon);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:warn(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "is[100]", params[0], params[1])) 
		return InformationTextCMD(playerid, "/warn [id игрока] [причина]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(adm_PlayerInfo[playerid][ADM_Level] < adm_PlayerInfo[params[0]][ADM_Level]) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный администратор выше вас по должности.");
		return 1;
	}

	pInfo[params[0]][pWarn]++;

	new
		str[300];
	
	if(pInfo[params[0]][pWarn] != 3) {
		adm_PlayerInfo[playerid][ADM_Warns]++;
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Warns` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Warns], adm_PlayerInfo[playerid][ADM_ID]);
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", pInfo[params[0]][pWarn], GetPlayerpID(params[0]));
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		f(str, "{FF6347}Игроку %s (ID:%i) выдано предупреждение [%i из 3]. Причина: %s", NameEx(params[0]), params[0], pInfo[params[0]][pWarn], params[1]);
		SCM(playerid, -1, str);
		str[0] = EOS;

		f(str, "{FF6347}Администратор %s (ID:%i) выдал вам предупреждение [%i из 3]. Причина: %s", NameEx(playerid), playerid, pInfo[params[0]][pWarn], params[1]);
		SCM(params[0], -1, str);

		new
			strru[300];

		f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал warn {e8c22c}%s [%i] {FFFFFF}по причине: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
		Adm_SendMessages(0xcc1836FF, strru);
		return 1;
	}
	else if(pInfo[params[0]][pWarn] == 3) {
		adm_PlayerInfo[playerid][ADM_Warns]++;
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Warns` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Warns], adm_PlayerInfo[playerid][ADM_ID]);
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", pInfo[params[0]][pWarn], GetPlayerpID(params[0]));
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		f(str, "{FF6347}Игроку %s (ID:%i) выдано предупреждение [%i из 3]. Причина: %s", NameEx(params[0]), params[0], pInfo[params[0]][pWarn], params[1]);
		SCM(playerid, -1, str);
		str[0] = EOS;

		f(str, "{FF6347}Администратор %s (ID:%i) выдал вам предупреждение [%i из 3]. Причина: %s", NameEx(playerid), playerid, pInfo[params[0]][pWarn], params[1]);
		SCM(params[0], -1, str);
		str[0] = EOS;

		BanPlayer(NameEx(params[0]), NameEx(playerid), 3, "Warns: 3");
		
		SCM(params[0], -1, "{CC0033}(Бан) {FFFFFF}Вы получили бан на 3 дня за 3 предупреждения.");
		pInfo[params[0]][pWarn] = 0;

		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", pInfo[params[0]][pWarn], GetPlayerpID(params[0]));
		mysql_tquery(MysqlID, str);

		KickEx(params[0]);

		new
			strru[300];

		f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал warn {e8c22c}%s [%i] {FFFFFF}по причине: %s", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
		Adm_SendMessages(0xcc1836FF, strru);
		return 1;
	}

	pInfo[params[0]][pWarn]--;
	SCM(params[0], COLOR_ERROR, "(Ошибка) {FFFFFF}У данного игрока уже 3 предупреждения.");
	return 1;
}

CMD:unwarn(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_SPECIAL)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/unwarn [id игрока]");
	
	if(adm_PlayerInfo[playerid][ADM_Level] < adm_PlayerInfo[params[0]][ADM_Level]) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный администратор выше вас по уровню.");
		return 1;
	}
	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	new
		str[300];
	
	if(pInfo[params[0]][pWarn] > 0) {
		adm_PlayerInfo[playerid][ADM_UnWarns]++;
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Unwarns` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_UnWarns], adm_PlayerInfo[playerid][ADM_ID]);
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		pInfo[params[0]][pWarn]--;
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", pInfo[params[0]][pWarn], str, GetPlayerpID(params[0]));
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		f(str, "{FF6347}Снято предупреждение у игрока %s (ID:%i) [%i из 3].", NameEx(params[0]), params[0], pInfo[params[0]][pWarn]);
		SCM(playerid, -1, str);
		str[0] = EOS;

		f(str, "{FF6347}Администратор %s (ID:%i) убрал предупреждение [%i из 3].", NameEx(playerid), playerid, pInfo[params[0]][pWarn]);
		SCM(params[0], -1, str);
		return 1;
	}

	SCM(params[0], COLOR_ERROR, "(Ошибка) {FFFFFF}У данного игрока 0 предупреждений.");

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}снял warn {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:setskin(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "ii", params[0], params[1])) 
		return InformationTextCMD(playerid, "/setskin [id игрока] [id скина]");
	
	if(params[1] < 0 
	|| params[1] > 289) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Скин меньше 0 и больше 289 запрещается!");
		return 1;
	}
	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	SetPlayerSkinEx(params[0], params[1]);

	new
		str[150];

	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал скин {FFFF33}%i", NameEx(playerid), playerid, params[1]);
	SCM(params[0], -1, str);

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}установил скин {e8c22c}%s [%i] {FFFFFF}Скин: %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	Adm_SendMessages(0xcc1836FF, strru);

	DestroyPlayerAttachedObjects(playerid);
	Inv_SetPlayerAttachItem(playerid);
	return 1;
}

CMD:rsetskin(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	new
		Float:radius;
	
	if(sscanf(params, "fi", radius, params[1])) 
		return InformationTextCMD(playerid, "/rsetskin [радиус] [id скина]");
	
	if(radius < 1 
	|| radius > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}
	if(params[1] < 0 
	|| params[1] > 289) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Скин меньше 0 и больше 289 запрещается!");
		return 1;
	}

	new
		players,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	new
		str[200];
	
	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;

		if(Mode_GetPlayer(p) != Mode_GetPlayer(playerid)) 
			continue;

		if(GetPlayerBusy(p) != GAME) 
			continue;

		if(IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			SetPlayerSkinEx(p, params[1]);
			players++;

			f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал скин {FFFF33}%i", NameEx(playerid), playerid, params[1]);
			SCM(p, -1, str);
			str[0] = EOS;
		}
	}

	f(str, "{CC0033}(Информация) {FFFFFF}Выдано {FFFF33}%i {FFFFFF}игрокам скин", players);
	SCM(playerid, -1, str);

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}установил скин в радиусе %i {FFFFFF}Скин: %i", NameEx(playerid), playerid, NameEx(params[0]), radius, params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:aset(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/aset [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	SetPlayerHealthEx(params[0], 100.0);
	SetPlayerArmourEx(params[0], 100.0);
	GivePlayerWeaponEx(params[0], 16, 50);
	GivePlayerWeaponEx(params[0], 28, 500);
	GivePlayerWeaponEx(params[0], 31, 500);

	new
		str[200];
	
	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал набор оружия", NameEx(playerid), playerid);
	SCM(params[0], -1, str);

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал набор оружия {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:raset(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);
	
	new
		Float:radius;
	
	if(sscanf(params, "f", radius)) 
		return InformationTextCMD(playerid, "/raset [радиус]");
	
	if(radius < 1 
	|| radius > 100) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Радиус меньше 1 и больше 100 запрещается!");
		return 1;
	}

	new
		players,
		Float:x,
		Float:y,
		Float:z;

	GetPlayerPos(playerid, x, y, z);

	new
		str[200];
	
	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;

		if(Mode_GetPlayer(p) != Mode_GetPlayer(playerid))
			continue;

		if(GetPlayerBusy(p) != GAME)
			continue;

		if(IsPlayerInRangeOfPoint(p, radius, x, y, z)) {
			SetPlayerHealthEx(p, 100.0);
			SetPlayerArmourEx(p, 100.0);
			GivePlayerWeaponEx(p, 16, 50);
			GivePlayerWeaponEx(p, 28, 500);
			GivePlayerWeaponEx(p, 31, 500);
			players++;

			f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал набор оружия", NameEx(playerid), playerid);
			SCM(p, -1, str);
			str[0] = EOS;
		}
	}

	f(str, "{CC0033}(Информация) {FFFFFF}Выдано {FFFF33}%i {FFFFFF}игрокам набор оружия", players);
	SCM(playerid, -1, str);

	new
		strru[250];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал набор оружия в радиусе %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], radius);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:clearchat(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	n_for(i, 17)
		SendClientMessageToAll(-1, " ");
	
	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;
		
		SCM(p, COLOR_INFO, "(Информация) {FFFFFF}Чат очищен администрацией.");
	}

	new 
		strru[250];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}очистил чат", NameEx(playerid), playerid);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:warnoff(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	new
		name[MAX_PLAYER_NAME],
		reason[50];

	if(sscanf(params, "s[25]s[50]", name, reason)) 
		return InformationTextCMD(playerid, "/warnoff [ник игрока] [причина]");
	
	new
		player = GetNameID(name);
	
	if(player != INVALID_PLAYER_ID) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок в сети.");
		return 1;
	}

	new
		str[300];
	
	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_BANS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rowsss;
	
	cache_get_row_count(num_rowsss);
	if(num_rowsss) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный игрок забанен.");
		return 1;
	}
	str[0] = EOS;

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rowss;
	
	cache_get_row_count(num_rowss);
	if(num_rowss) {
		new
			AdminLevel;

		cache_get_value_name_int(0, "Level", AdminLevel);
		
		if(adm_PlayerInfo[playerid][ADM_Level] < AdminLevel) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный администратор выше вас по уровню.");
			return 1;
		}
	}
	str[0] = EOS;

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rows;
	
	cache_get_row_count(num_rows);
	
	if(!num_rows) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не найден.");
		return 1;
	}
	str[0] = EOS;

	new
		IDMySQL,
		Warns;

	cache_get_value_name_int(0, "Warn", Warns);
	cache_get_value_name_int(0, "ID", IDMySQL);

	if(Warns != 3) {
		Warns++;
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", Warns, IDMySQL);
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		adm_PlayerInfo[playerid][ADM_Warns]++;
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Warns` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Warns], adm_PlayerInfo[playerid][ADM_ID]);
		mysql_tquery(MysqlID, str);

		f(str, "{FF6347}Игроку %s выдано предупреждение [%i из 3]. Причина: %s", name, Warns, reason);
		SCM(playerid, -1, str);
		str[0] = EOS;
	}
	if(Warns >= 3) {
		Warns = 0;
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", Warns, IDMySQL);
		mysql_tquery(MysqlID, str);

		BanPlayer(name, NameEx(playerid), 3, "Warns: 3");
	}
	return 1;
}

CMD:unwarnoff(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	new
		name[MAX_PLAYER_NAME];
	
	if(sscanf(params, "s[24]", name)) 
		return InformationTextCMD(playerid, "/unwarnoff [ник игрока]");
	
	new
		player = GetNameID(params[0]);

	if(player != INVALID_PLAYER_ID) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок в сети.");
		return 1;
	}

	new
		str[300];
	
	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_BANS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rowsss;
	
	cache_get_row_count(num_rowsss);
	if(num_rowsss) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный игрок забанен.");
		return 1;
	}
	str[0] = EOS;

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rowss;
	
	cache_get_row_count(num_rowss);
	if(num_rowss) {
		new
			AdminLevel;

		cache_get_value_name_int(0, "Level", AdminLevel);
		
		if(adm_PlayerInfo[playerid][ADM_Level] < AdminLevel) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный администратор выше вас по уровню.");
			return 1;
		}
	}
	str[0] = EOS;

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rows;

	cache_get_row_count(num_rows);
	if(!num_rows) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не найден.");
		return 1;
	}

	new
		IDMySQL,
		Warns;

	cache_get_value_name_int(0, "Warn", Warns);
	cache_get_value_name_int(0, "ID", IDMySQL);
	str[0] = EOS;

	if(Warns > 0) {
		Warns--;
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", Warns, IDMySQL);
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		adm_PlayerInfo[playerid][ADM_Warns]++;
		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Unwarns` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_UnWarns], adm_PlayerInfo[playerid][ADM_ID]);
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		f(str, "{FF6347}Игроку %s снято предупреждение [%i из 3]", name, Warns);
		SCM(playerid, -1, str);
	}
	return 1;
}

CMD:givemoney(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "ii", params[0], params[1])) 
		return InformationTextCMD(playerid, "/givemoney [id игрока] [кредитов]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	SetPlayerCredit(params[0], params[1]);

	new
		str[200];

	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал вам {33FF00}+%i$", NameEx(playerid), playerid, params[1]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}выдано {33FF00}+%i$", NameEx(params[0]), params[0], params[1]);
	SCM(playerid, -1, str);

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал кредитов {e8c22c}%s [%i] {FFFFFF}Кредитов: %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:giverank(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "ii", params[0], params[1])) 
		return InformationTextCMD(playerid, "/giverank [id игрока] [ранг]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	pInfo[playerid][pExp] = 0;
	SetPlayerRank(params[0], params[1]);

	new
		str[300];

	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал вам {FFFF33}+%i {FFFFFF}к рангу", NameEx(playerid), playerid, params[1]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}выдано {FFFF33}+%i {FFFFFF}к рангу", NameEx(params[0]), params[0], params[1]);
	SCM(playerid, -1, str);

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал ранг {e8c22c}%s [%i] {FFFFFF}Ранг: %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:givempoint(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "ii", params[0], params[1])) 
		return InformationTextCMD(playerid, "/givempoint [id игрока] [очков матча]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	Mode_SetPlayerMatchPoint(params[0], params[1]);

	new
		str[300];

	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал вам {FFFF33}+%i {FFFFFF}очков раунда", NameEx(playerid), playerid, params[1]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}выдано {FFFF33}+%i {FFFFFF}очков раунда", NameEx(params[0]), params[0], params[1]);
	SCM(playerid, -1, str);

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал раунд очков {e8c22c}%s [%i] {FFFFFF}Раунд очков: %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:adamage(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/adamage [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	new 
		str[200];

	if(GetPlayerDamage(params[0])) {
		SetPlayerDamage(params[0], false);
		f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}отключил вам урон.", NameEx(playerid), playerid);
		SCM(params[0], -1, str);
		str[0] = EOS;

		f(str, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}отключён урон.", NameEx(params[0]), params[0]);
		SCM(playerid, -1, str);

		new 
			strru[300];

		f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}отключил урон {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
		Adm_SendMessages(0xcc1836FF, strru);
	}
	else {
		SetPlayerDamage(params[0], true);
		f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}включил вам урон.", NameEx(playerid), playerid);
		SCM(params[0], -1, str);
		str[0] = EOS;

		f(str, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}включён урон.", NameEx(params[0]), params[0]);
		SCM(playerid, -1, str);

		new 
			strru[300];

		f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}включил урон {e8c22c}%s [%i]", NameEx(playerid), playerid, NameEx(params[0]), params[0]);
		Adm_SendMessages(0xcc1836FF, strru);
	}
	return 1;
}

CMD:astats(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	new
		name[MAX_PLAYER_NAME];

	if(sscanf(params, "s[24]", name)) 
		return InformationTextCMD(playerid, "/astats [ник игрока]");

	new
		str[3500];

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rows;

	cache_get_row_count(num_rows);
	if(!num_rows) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не найден.");
		return 1;
	}
	str[0] = EOS;

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
		adata[50],
		id;

	cache_get_value_name_int(0, "Level", level);
	cache_get_value_name_int(0, "Reputation", reputation);
	cache_get_value_name_int(0, "Reprimands", reprimands);
	cache_get_value_name_int(0, "Kicks", kicks);
	cache_get_value_name_int(0, "Bans", bans);
	cache_get_value_name_int(0, "Unbans", unbans);
	cache_get_value_name_int(0, "Muts", muts);
	cache_get_value_name_int(0, "Unmuts", unmuts);
	cache_get_value_name_int(0, "Warns", warns);
	cache_get_value_name_int(0, "Unwarns", unwarns);
	cache_get_value_name(0, "Data", adata);
	cache_get_value_name_int(0, "ID", id);

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		data[50],
		num_rowss;

	cache_get_row_count(num_rowss);
	if(num_rowss) 
		cache_get_value_name(0, "Old_data", data, sizeof(data));

	str[0] = EOS;

	f(str, "{CCCCCC}Админ: {FFFF33}[%s] \
	\n\n{CCCCCC}Уровень: {FFFFFF}[%i] (%s) \
	\n{CCCCCC}Репутация: {FFFFFF}[%i] \
	\n{CCCCCC}Выговоров: {FFFFFF}[%i] \
	\n{CCCCCC}Кикнуто: {FFFFFF}[%i] \
	\n{CCCCCC}Забанено: {FFFFFF}[%i] \
	\n{CCCCCC}Разбанено: {FFFFFF}[%i] \
	\n{CCCCCC}Мутов: {FFFFFF}[%i] \
	\n{CCCCCC}Убрано мутов: {FFFFFF}[%i] \
	\n{CCCCCC}Варнов: {FFFFFF}[%i] \
	\n{CCCCCC}Убрано варнов: {FFFFFF}[%i] \
	\n{CCCCCC}Дата выдачи админ прав: {FFFFFF}[%s] \
	\n{CCCCCC}Последний заход на сервер: {FFFFFF}[%s]", name, level, GetAdminNameLevel(level), reputation, reprimands, kicks, bans, unbans, muts, unmuts, warns, unwarns, adata, data);
	Dialog_Message(playerid, "Статистика администратора", str, "Закрыть");
	return 1;
}

CMD:ao(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "s[100]", params[0])) 
		return InformationTextCMD(playerid, "/ao [текст]");

	new
		str[300];

	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;

		if(GetPlayerLogged(p)) 
			continue;

		SCM(p, -1, "");
		f(str, "{2943ee}[Сервер] {FFFFFF}%s", params[0]);
		SCM(p, -1, str);
		str[0] = EOS;
	}

	new
		strru[300];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}написал в чат сервера", NameEx(playerid), playerid);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:makeadmin(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_FOUNDER)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "ii", params[0], params[1])) 
		return InformationTextCMD(playerid, "/makeadmin [id игрока] [уровень]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(params[1] < 0 
	|| params[1] > ADM_MAX_LEVELS) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Уровень админки не может быть больше 6.");
		return 1;
	}

	adm_PlayerInfo[params[0]][ADM_Level] = params[1];

	new
		str[300];

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", NameEx(params[0]));
	mysql_tquery(MysqlID, str, "Call_UpdateAdmin", "i", params[0]);
	str[0] = EOS;

	if(params[1] > 0) {
		f(str, "{CC0033}(Информация) {FFFFFF}Вы назначили игрока {FFFF33}%s (ID:%i) {33FF00}%s{FFFFFF}.", NameEx(params[0]), params[0], GetAdminNameLevel(adm_PlayerInfo[params[0]][ADM_Level]));
		SCM(playerid, -1, str);
		str[0] = EOS;

		f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}назначил Вас {33FF00}%s{FFFFFF}.", NameEx(playerid), playerid, GetAdminNameLevel(adm_PlayerInfo[params[0]][ADM_Level]));
		SCM(params[0], -1, str);
	}
	else {
		f(str, "{CC0033}(Информация) {FFFFFF}Вы сняли игрока {FFFF33}%s (ID:%i) {FFFFFF}с админ прав.", NameEx(params[0]), params[0]);
		SCM(playerid, -1, str);
		str[0] = EOS;

		f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}снял вас с админ прав.", NameEx(playerid), playerid);
		SCM(params[0], -1, str);

		if(Adm_GetPlayerSpectating(playerid))
			Adm_HidePlayerSpectating(playerid);
	}
	return 1;
}

CMD:makeadminoff(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_FOUNDER)
		return Adm_ErrorTextForAdmin(playerid);

	new
		name[MAX_PLAYER_NAME];

	if(sscanf(params, "s[24]", name))
		return InformationTextCMD(playerid, "/makeadminoff [ник игрока]");
	
	new
		player = GetNameID(params[0]);

	if(player != INVALID_PLAYER_ID) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок в сети.");
		return 1;
	}

	new
		str[200];

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rows;

	cache_get_row_count(num_rows);
	if(!num_rows) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не найден.");
		return 1;
	}
	str[0] = EOS;

	new
		IDMySQL,
		AdminLevel;

	cache_get_value_name_int(0, "Level", AdminLevel);
	cache_get_value_name_int(0, "ID", IDMySQL);

	if(AdminLevel > 0) {
		mysql_format(MysqlID, str, sizeof(str), "DELETE FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", name);
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		f(str, "{FF6347}Игроку %s сняты админ права", name);
		SCM(playerid, -1, str);
	}
	return 1;
}

CMD:awarn(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	new
		name[MAX_PLAYER_NAME];

	if(sscanf(params, "s[25]", name))
		return InformationTextCMD(playerid, "/awarn [ник игрока]");

	new
		str[300];

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new
		num_rowss;
	
	cache_get_row_count(num_rowss);
	if(!num_rowss) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный игрок не администратор.");
		return 1;
	}
	str[0] = EOS;

	new
		IDMySQL,
		AdminReprimands;

	cache_get_value_name_int(0, "Reprimands", AdminReprimands);
	cache_get_value_name_int(0, "ID", IDMySQL);

	AdminReprimands++;

	mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Reprimands` = '%i' WHERE `ID` = '%d'", AdminReprimands, IDMySQL);
	mysql_tquery(MysqlID, str);
	str[0] = EOS;

	new
		player = GetNameID(name);
	
	if(player != INVALID_PLAYER_ID) {
		adm_PlayerInfo[player][ADM_Reprimands]++;

		f(str, "{FF6347}Администратор %s выдал вам выговор [%i из 3]", NameEx(playerid), AdminReprimands);
		SCM(player, -1, str);
		str[0] = EOS;
	}

	f(str, "{FF6347}Администратору %s выдан выговор [%i из 3]", name, AdminReprimands);
	SCM(playerid, -1, str);
	str[0] = EOS;

	if(AdminReprimands >= 3) {
		f(str, "{FF6347}У администратора %s выговоров уже [%i из 3] уберите его с админки", name, AdminReprimands);
		SCM(playerid, -1, str);
	}
	return 1;
}

CMD:aunwarn(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	new
		name[MAX_PLAYER_NAME];

	if(sscanf(params, "s[25]", name)) 
		return InformationTextCMD(playerid, "/unawarn [ник игрока]");

	new 
		str[300];
	
	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_ADMINS"` WHERE BINARY `Name` = '%s'", name);
	mysql_query(MysqlID, str, true);

	new 
		num_rowss;
	
	cache_get_row_count(num_rowss);
	if(!num_rowss) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный игрок не администратор.");
		return 1;
	}
	str[0] = EOS;

	new
		IDMySQL,
		AdminReprimands;

	cache_get_value_name_int(0, "Reprimands", AdminReprimands);
	cache_get_value_name_int(0, "ID", IDMySQL);

	if(AdminReprimands > 0) {
		AdminReprimands--;

		mysql_format(MysqlID, str, sizeof(str), "UPDATE `"T_ADMINS"` SET `Reprimands` = '%i' WHERE `ID` = '%d'", AdminReprimands, IDMySQL);
		mysql_tquery(MysqlID, str);
		str[0] = EOS;

		new 
			player = GetNameID(name);

		if(player != INVALID_PLAYER_ID) {
			adm_PlayerInfo[player][ADM_Reprimands]++;

			f(str,"{FF6347}Администратор %s убрал вам выговор [%i из 3]", NameEx(playerid), AdminReprimands);
			SCM(player, -1, str);
			str[0] = EOS;
		}

		f(str, "{FF6347}Администратору %s убран выговор [%i из 3]", name, AdminReprimands);
		SCM(playerid, -1, str);
		str[0] = EOS;
	}
	return 1;
}

CMD:changeservername(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_FOUNDER)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "s[41]", params[0])) 
		return InformationTextCMD(playerid, "/changeservername [название]");
	
	if(params[0] < 1 
	|| params[0] > 40) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Название меньше 1 и больше 40 букв запрещается!");
		return 1;
	}

	new
		it[64],
		name[100];

	sscanf(params[0], "s[64]", it);
	f(name, "hostname %s", it);
	SendRconCommand(name);

	new
		str[150];
	
	f(str, "{CC0033}(Информация) {FFFFFF}Название сервера: {FFFF33}%s", params[0]);
	SCM(playerid, -1, str);
	return 1;
}

CMD:mp(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_FOUNDER)
		return Adm_ErrorTextForAdmin(playerid);

	Dialog_Show(playerid, Dialog:Adm_SelectMode);
	return 1;
}

CMD:setitem(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_FOUNDER)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "iii", params[0], params[1], params[2])) 
		return InformationTextCMD(playerid, "/setitem [id игрока] [id предмета] [кол-во]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(params[1] >= Inv_GetMaxItems() 
	|| params[1] < 1) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данного предмета не существует!");
		return 1;
	}
	if(params[2] < 1) 
		return 1;
	
	if(!Inv_CheckPlayerFullItem(params[0], params[1], params[2])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}У игрока недостаточно места в инвентаре!");
		return 1;
	}

	Inv_SetPlayerItem(params[0], params[1], params[2]);

	new
		str[250];

	f(str, "{d69722}Игроку %s успешно выдан предмет %s в кол-ве %i", NameEx(params[0]), Inv_GetNameItem(params[1]), params[2]);
	SCM(playerid, -1, str);
	str[0] = EOS;

	f(str, "{d69722}Администратор %s выдал Вам предмет %s в кол-ве %i", NameEx(playerid), Inv_GetNameItem(params[1]), params[2]);
	SCM(params[0], -1, str);
	return 1;
}

CMD:setbanner(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_FOUNDER)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "iii", params[0], params[1], params[2])) 
		return InformationTextCMD(playerid, "/setbanner [id игрока] [id баннера] [кол-во]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}
	if(params[1] >= Inv_GetMaxBanners()
	|| params[1] < 1) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данного баннера не существует!");
		return 1;
	}
	if(params[2] < 1) 
		return 1;
	
	if(!Inv_CheckPlayerFullBanner(params[0], params[1], params[2])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}У игрока недостаточно места в инвентаре!");
		return 1;
	}

	Inv_SetPlayerBanner(params[0], params[1], params[2]);

	new
		str[250];

	f(str, "{d69722}Игроку %s успешно выдан баннер %s в кол-ве %i", NameEx(params[0]), Inv_GetNameBanner(params[1]), params[2]);
	SCM(playerid, -1, str);
	str[0] = EOS;

	f(str, "{d69722}Администратор %s выдал Вам баннер %s в кол-ве %i", NameEx(playerid), Inv_GetNameBanner(params[1]), params[2]);
	SCM(params[0], -1, str);
	return 1;
}

CMD:dreports(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	ReportResetAll();

	new
		str[100];

	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;

		if(adm_PlayerInfo[p][ADM_Level] < 1) 
			continue;

		f(str, "{CC0033}(Админ-чат) {FFFFFF}Репорты очищены!");
		SCM(p, -1, str);
		str[0] = EOS;
	}
	return 1;
}

CMD:givegold(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "ii", params[0], params[1])) 
		return InformationTextCMD(playerid, "/givegold [id игрока] [goldcoins]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	SetPlayerGoldCoins(params[0], params[1]);

	new
		str[200];

	f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}выдал вам {f0ce26}+%i GoldCoins", NameEx(playerid), playerid, params[1]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}выдано {f0ce26}+%i GoldCoins", NameEx(params[0]), params[0], params[1]);
	SCM(playerid, -1, str);

	new 
		strru[250];

	f(strru, "{cc1836}[A]: {e8c22c}%s [%i] {FFFFFF}выдал Gold coins {e8c22c}%s [%i] {FFFFFF}Gold coins: %i", NameEx(playerid), playerid, NameEx(params[0]), params[0], params[1]);
	Adm_SendMessages(0xcc1836FF, strru);
	return 1;
}

CMD:givecheat(playerid, params[])
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForAdmin(playerid);

	if(sscanf(params, "ii", params[0], params[1])) 
		return InformationTextCMD(playerid, "/givecheat [id игрока]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	n_for(i, 52)
		EnableAntiCheatForPlayer(params[0], params[1], 0);

	return 1;
}

/*

	* Interfaces *

*/

InterfaceCreate:AdminSpectate(playerid)
{
	ShowTDPlayerSP(playerid);
	
	n_for(i, sizeof(TD_aPlayerSpec[]))
		PlayerTextDrawShow(playerid, TD_aPlayerSpec[playerid][i]);
	
	SetPlayerClickTD(playerid, true);
	SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);
	return 1;
}

InterfaceClose:AdminSpectate(playerid)
{
	n_for(i, sizeof(TD_aPlayerSpec[]))
		DestroyPlayerTD(playerid, TD_aPlayerSpec[playerid][i]);

	return 1;
}

InterfacePlayerClick:AdminSpectate(playerid, PlayerText:playertextid)
{
	if(playertextid == TD_aPlayerSpec[playerid][1]) {
		SetPlayerIDStats(playerid, GetPlayerSpectating(playerid));
		Dialog_Show(playerid, Dialog:ChoosePlayerStats);
		return 1;
	}
	else if(playertextid == TD_aPlayerSpec[playerid][2]) {
		if(Adm_GetPlayerLevel(playerid) < 4) 
			return Adm_ErrorTextForAdmin(playerid);

		if(Adm_GetPlayerLevel(playerid) < adm_PlayerInfo[GetPlayerSpectating(playerid)][ADM_Level]) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный администратор выше вас по уровню.");
			return 1;
		}
		Dialog_Show(playerid, Dialog:Adm_BanPlayer);
	}
	else if(playertextid == TD_aPlayerSpec[playerid][3]) {
		if(Adm_GetPlayerLevel(playerid) < 3) 
			return Adm_ErrorTextForAdmin(playerid);
		
		if(Adm_GetPlayerLevel(playerid) < adm_PlayerInfo[GetPlayerSpectating(playerid)][ADM_Level]) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный администратор выше вас по уровню.");
			return 1;
		}
		Dialog_Show(playerid, Dialog:Adm_KickPlayer);
		return 1;
	}
	else if(playertextid == TD_aPlayerSpec[playerid][4]) {
		new 
			string[200],
			Float:Slap_x,
			Float:Slap_y,
			Float:Slap_z;

		GetPlayerPos(GetPlayerSpectating(playerid), Slap_x, Slap_y, Slap_z);
		
		SetPlayerPosEx(GetPlayerSpectating(playerid), Slap_x, Slap_y, Slap_z + 5.0, 
		GetPlayerVirtualWorldEx(GetPlayerSpectating(playerid)), GetPlayerInteriorEx(GetPlayerSpectating(playerid)));
		
		PlayerPlaySoundEx(GetPlayerSpectating(playerid), 1130, Slap_x, Slap_y, Slap_z + 5);

		f(string, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}подкинул Вас.", NameEx(playerid), playerid);
		SCM(GetPlayerSpectating(playerid), -1, string);
		return 1;
	}
	else if(playertextid == TD_aPlayerSpec[playerid][5]) {
		PlayerSpawn(GetPlayerSpectating(playerid));

		new 
			string[200];
		
		f(string, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%i) {FFFFFF}заспавнил Вас.", NameEx(playerid), playerid);
		SCM(GetPlayerSpectating(playerid), -1, string);
		return 1;
	}
	else if(playertextid == TD_aPlayerSpec[playerid][6]) {
		if(Adm_GetPlayerSpectating(playerid))
			Adm_HidePlayerSpectating(playerid);

		return 1;
	}
	else if(playertextid == TD_aPlayerSpec[playerid][24]) {
		if(Adm_GetPlayerSpectating(playerid)) {
			if(GetPlayerVehicleIDEx(GetPlayerSpectating(playerid)) != -1) {
				SetPlayerSpecStatus(playerid, 1);
				PlayerSpectateVehicle(playerid, GetPlayerVehicleID(GetPlayerSpectating(playerid)));
			}
			else {
				SetPlayerSpecStatus(playerid, 2);
				PlayerSpectatePlayer(playerid, GetPlayerSpectating(playerid));
			}
			Adm_UpdateTDSpec(playerid, GetPlayerSpectating(playerid));
		}
		return 1;
	}
	return 1;
}

/*

	* Dialogs *

*/

DialogCreate:Report(playerid)
{
	if(aPlayerReReport[playerid] > gettime()) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Писать в репорт можно раз в минуту!");
		return 1;
	}

	static
		sctring[1500];

	sctring[0] = EOS;

	strcat(sctring, "{FFFFFF}Вы собираетесь написать сообщение Администрации.");
	strcat(sctring, "\n{CC0033}Запрещено:");
	strcat(sctring, "\n{CCCCCC}1. Флуд, оскорбления, оффтоп");
	strcat(sctring, "\n{CCCCCC}2. Просьбы (Дайте денег, дайте админку, дайте..)");
	strcat(sctring, "\n{CCCCCC}3. Ложные сообщения");
	strcat(sctring, "\n\n{CC0033}За нарушение правил администрация сервера может:");
	strcat(sctring, "\n{CCCCCC}1. Предупредить (Warn)");
	strcat(sctring, "\n{CCCCCC}2. Кикнуть с сервера (Kick)");
	strcat(sctring, "\n{CCCCCC}3. Заблокировать аккаунт (Ban)");
	strcat(sctring, "\n\n{FFFF33}Помните!");
	strcat(sctring, "\n{CCCCCC}Мы всегда готовы помочь если вы соблюдаете правила.");
	strcat(sctring, "\n{CCCCCC}Данные правила установлены для всех игроков.");
	strcat(sctring, "\n\n{CCCCCC}Если вам долго не отвечают, подождите пару минут");
	strcat(sctring, "\n{CCCCCC}Прежде чем задавать вопрос в репорт, попробуйте найти решение с помощью /help.");
	strcat(sctring, "\n{FFFFFF}Спасибо за понимание, с уважением Администрация "SERVER_NAME".\n\n");

	Dialog_Open(playerid, Dialog:Report, DSI, "Репорт", sctring, "Отправить", "Закрыть");
	return 1;
}

DialogResponse:Report(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Report);
		
		n_for(i, MAX_REPORTS) {
			if(aCountReports[i] == -1) {
				aCountReports[i] = playerid;
				strmid(aTextReport[i], (inputtext), 0, strlen(inputtext), 250);

				new
					strigatik[700],
					strru[300],
					adminid = aEstimate_ReportAdmin[playerid];

				f(strru, "{CC0033}(Жалоба) {FFFFFF}От {FFFF33}%s (ID:%d): {FFFFFF}%s. Уже %d жалоб!", NameEx(playerid), playerid, inputtext, NumberReports());
				Adm_SendMessages(0xcc1836FF, strru);

				if(adm_PlayerInfo[adminid][ADM_Level]) 
					GameTextForPlayer(adminid, "~y~Report++", 3000, 1);

				f(strigatik, "{CC0033}(Информация) {FFFFFF}Вы отправили жалобу: %s", inputtext);
				SCM(playerid, -1, strigatik);

				f(strigatik, "{CC0033}(Информация) {FFFFFF}На ваш вопрос ответит администрация. Вы %d в очереди!", NumberReports());
				SCM(playerid, -1, strigatik);

				GameTextForPlayer(playerid, "~g~Successful", 2000, 1);
				aPlayerReReport[playerid] = gettime() + 60;
				aActionPlayerReportSend[playerid] = 1;
				break;
			}
		}
	}
	return 1;
}

DialogCreate:Adm_AnswerEvalution(playerid)
{
	Dialog_Open(playerid, Dialog:Adm_AnswerEvalution, DSL, "Оцените работу администратора!", 
	"{BFE54C}Хороший ответ \
	\n{CC0033}Плохой ответ", "Выбрать", "");
	return 1;
}

DialogResponse:Adm_AnswerEvalution(playerid, response, listitem, inputtext[])
{
	if(!response)
		return Dialog_Show(playerid, Dialog:Adm_AnswerEvalution);

	new
		adminid = aEstimate_ReportAdmin[playerid],
		otvet;

	switch(listitem) {
		case 0: {
			adm_PlayerInfo[adminid][ADM_Reputation]++;
			otvet++;
		}
		case 1: { 
			adm_PlayerInfo[adminid][ADM_Reputation]--;
			otvet--;
		}
	}

	if(IsPlayerOnServer(adminid)) {
		if(adm_PlayerInfo[adminid][ADM_Level]) {
			new
				querys[150];

			mysql_format(MysqlID, querys, sizeof(querys), "UPDATE `"T_ADMINS"` SET `Reputation` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Reputation], adm_PlayerInfo[playerid][ADM_ID]);
			mysql_tquery(MysqlID, querys);

			new
				string[600];
			
			if(otvet > 0) {
				f(string, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}понравился ваш ответ", NameEx(playerid), playerid);
				SCM(adminid, -1, string);
			}
			else {
				f(string, "{CC0033}(Информация) {FFFFFF}Игроку {FFFF33}%s (ID:%i) {FFFFFF}не понравился ваш ответ", NameEx(playerid), playerid);
				SCM(adminid, -1, string);
			}
		}
	}
	SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Спасибо за ваш отзыв!");
	aReport_Playerid[playerid] = -1;
	return 1;
}

DialogCreate:Adm_Answer(playerid)
{
	new 
		str[250],
		player_report = aReport_Playerid[playerid];

	f(str, "{FFFFFF}Жалоба/Вопрос от {FFFF33}%s (ID:%i)\n\n{CCCCCC}%s\n", NameEx(aCountReports[player_report]), aCountReports[player_report], aTextReport[player_report]);

	Dialog_Open(playerid, Dialog:Adm_Answer, DSI, "Репорт", str, "Принять", "Отмена");
	return 1;
}

stock DialogAdm_AnswerClose(playerid)
{
	if(aReport_Playerid[playerid] > -1) {
		new
			i = aReport_Playerid[playerid];

		aSlotReport[i] = -1;
		aReport_Playerid[playerid] = -1;

		if(IsPlayerOnServer(aCountReports[i])) {
			new 
				str[200];

			f(str, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%d) {FFFFFF}отказался отвечать на вашу жалобу. Ожидайте ответа!", NameEx(playerid), playerid);
			SCM(aCountReports[i], -1, str);
		}
	}
	return 1;
}

DialogResponse:Adm_Answer(playerid, response, listitem, inputtext[])
{
	new 
		player_report = aReport_Playerid[playerid];
	
	if(!response) {
		aSlotReport[player_report] = -1;
		aReport_Playerid[playerid] = -1;

		new 
			fmt_msg[200];
		
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы не ответили игроку! Ваша репутацию понижена!");
		
		f(fmt_msg, "{CC0033}(Информация) {FFFFFF}Администратор {FFFF33}%s (ID:%d) {FFFFFF}отказался отвечать на вашу жалобу. Ожидайте ответа!", NameEx(playerid), playerid);
		SCM(aCountReports[player_report], -1, fmt_msg);

		adm_PlayerInfo[playerid][ADM_Reputation]--;

		new 
			querys[150];
		
		mysql_format(MysqlID, querys, sizeof(querys), "UPDATE `"T_ADMINS"` SET `Reputation` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Reputation], adm_PlayerInfo[playerid][ADM_ID]);
		mysql_tquery(MysqlID, querys);
		return 1;
	}
	if(!IsPlayerOnServer(aCountReports[player_report])) {
		ReportReset(player_report);
		aReport_Playerid[playerid] = -1;

		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок вышел из игры");
		return 1;
	}
	if(!strlen(inputtext) || strlen(inputtext) >= 130) {
		Dialog_Show(playerid, Dialog:Adm_Answer);

		SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Много символов, или нет символов");
		return 1;
	}

	SetPVarString(playerid, "PlayerReportText_PVar", aTextReport[player_report]);
	SetPVarString(playerid, "PlayerReportAnswer_PVar", inputtext);
	Dialog_Show(aCountReports[player_report], Dialog:Adm_AnswerFromAdmin);

	new
		string[150];

	f(string, "{CC0033}(Ответ) {FFFFFF}Администратор {FFFF33}%s(ID:%d): {FFFFFF}%s", NameEx(playerid), playerid, inputtext);
	SCM(aCountReports[player_report], -1, string);

	aActionPlayerReportSend[aCountReports[player_report]] = -1;
	aEstimate_ReportAdmin[aCountReports[player_report]] = playerid;

	aReport_Playerid[playerid] = -1;
	ReportReset(playerid);
	return 1;
}

DialogCreate:Adm_AnswerFromAdmin(playerid)
{
	new
		str[100 + 300],
		text_report[150],
		answer_report[150];

	GetPVarString(playerid, "PlayerReportText_PVar", text_report, sizeof(text_report));
	GetPVarString(playerid, "PlayerReportAnswer_PVar", answer_report, sizeof(answer_report));

	DeletePVar(playerid, "PlayerReportText_PVar");
	DeletePVar(playerid, "PlayerReportAnswer_PVar");

	f(str, "{FFFFFF}Ответ от администратора! \
	\n\n{FFFFFF}Ваш вопрос: {CCCCCC}%s \
	\n{FFFFFF}%s: {CCCCCC}%s\n\n", text_report, NameEx(playerid), answer_report);

	Dialog_Open(playerid, Dialog:Adm_AnswerFromAdmin, DSM, "Репорт", str, "Спасибо", "");
	return 1;
}

DialogResponse:Adm_AnswerFromAdmin(playerid, response, listitem, inputtext[])
{
	new
		adminid = aEstimate_ReportAdmin[playerid];

	if(adminid == playerid) 
		return 1;

	Dialog_Show(playerid, Dialog:Adm_AnswerEvalution);
	return 1;
}

DialogCreate:Adm_Login(playerid)
{
	new
		string[300];

	f(string, "{d4d4d4}Аккаунт {FFCC33}%s {d4d4d4}является администратором {FFFF33}%i {d4d4d4}уровня. \
	\nВведите пароль от администрирования: \
	\n\n{4ecc47}* У Вас есть 60 секунд для входа в администрирование.", NameEx(playerid), Adm_GetPlayerLevel(playerid));

	Dialog_Open(playerid, Dialog:Adm_Login, DSP, "{ff6d00}Вход в админ панель", string, "Ввод", "Выйти");
	return 1;
}

DialogResponse:Adm_Login(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Adm_Login);
		
		if(strcmp(adm_PlayerInfo[playerid][ADM_Key], inputtext, true)) {
			SCM(playerid, -1, "{CC0033}Ошибка: неверный пароль!");
			Dialog_Show(playerid, Dialog:Adm_Login);
			return 1;
		}
		KillPlayerLoggedTimer(playerid);

		SCM(playerid, -1, "{57D643}(Информация) {FFFFFF}Авторизация на администрирование прошла успешно.");

		new
			strru[200];

		f(strru, "{cc1836}[A]: %s {e8c22c}%s [%i] {FFFFFF}вошел в систему администрирование!", GetAdminNameLevel(adm_PlayerInfo[playerid][ADM_Level]), NameEx(playerid), playerid);
		Adm_SendMessages(0xcc1836FF, strru);

		n_for(i, ADM_TD_MAX_CHEATERS)
			TextDrawShowForPlayer(playerid, TD_aCheaters[i]);

		n_for(i, 52)
			EnableAntiCheatForPlayer(playerid, i, 0);

		ConnectPlayerServer(playerid);
	}
	else
		Kick(playerid);
	
	return 1;
}

DialogCreate:Adm_ListBan(playerid)
{
	Dialog_Open(playerid, Dialog:Adm_ListBan, DSL, "Список забаненых", stringer, "Выбор", "Назад");
	return 1;
}

DialogResponse:Adm_ListBan(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(listitem == 20 
		|| listitem == 21) 
			CheckBanned(playerid, listitem);
		else {
			strmid(aUnbanName[playerid], inputtext, 0, strlen(inputtext));
			
			if(GetString(inputtext, "<<< Назад")) 
				return CheckBanned(playerid, 21);

			Dialog_Show(playerid, Dialog:Adm_UnBan);

			//cache_delete(result);
		}
	}
	else {
		aUnbanName[playerid][0] = EOS;
		aDialogFirstBL[playerid] = 0;
		Dialog_Show(playerid, Dialog:Adm_Menu);
	}
	return 1;
}

DialogCreate:Adm_UnBan(playerid)
{
	new 
		query[300],
		seconds,
		reason[50],
		admin[MAX_PLAYER_NAME],
		Names[MAX_PLAYER_NAME];

	mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_BANS"` WHERE BINARY `Name` = '%s' LIMIT 1", aUnbanName[playerid]);
	mysql_query(MysqlID, query);

	new 
		account;
	
	cache_get_row_count(account);
	
	if(account) {
		cache_get_value_name(0, "Name", Names, MAX_PLAYER_NAME);
		cache_get_value_name(0, "BanAdmin", admin, MAX_PLAYER_NAME);
		cache_get_value_name(0, "BanReason", reason, sizeof(reason));
		cache_get_value_name_int(0, "BanSeconds", seconds);

		new
			times = gettime(),
			rutima[10],
			dima;

		if(floatround((seconds-times) / 60 / 60 / 24 ) > 1) {
			rutima = "дней";
			dima = floatround((seconds - times) / 60 / 60 / 24, floatround_ceil);
		}
		else {
			rutima = "час(ов)";
			dima = floatround((seconds - times) / 60 / 60, floatround_ceil);
		}

		new
			str[300];

		f(str, "{FFFFFF}Админ: \t{FFFF33}%s \
		\n{FFFFFF}Причина: \t{CC0033}%s \
		\n{FFFFFF}До разблокировки: \t{FF0000}%d %s", admin, reason, dima, rutima);

		Dialog_Open(playerid, Dialog:Adm_UnBan, DSM, aUnbanName[playerid], str, "Разбан", "Отмена");
	}
	else {
		new
			str[100];

		f(str, "Игрок {FFFF33}%s {FFFFFF}не забанен", aUnbanName[playerid]);
		SCM(playerid, -1, str);
	}
	return 1;
}

DialogResponse:Adm_UnBan(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(IsBannedName(aUnbanName[playerid])) {
			UnBanName(aUnbanName[playerid]);
			SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Игрок разбанен");
			adm_PlayerInfo[playerid][ADM_UnBans]++;
			
			new 
				querys[150];
			
			mysql_format(MysqlID, querys, sizeof(querys), "UPDATE `"T_ADMINS"` SET `Unbans` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_UnBans], adm_PlayerInfo[playerid][ADM_ID]);
			mysql_tquery(MysqlID, querys);
		}
		else {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок уже разбанен");
		}
	}
	return 1;
}

DialogResponse:Adm_CommandsLvl(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:Adm_Commands);
	return 1;
}

DialogCreate:Adm_Commands(playerid)
{
	Dialog_Open(playerid, Dialog:Adm_Commands, DSL, "Команды администраторов", "\
	"C_N"• {FFFFFF}Младший администратор [1] \
	\n"C_N"• {FFFFFF}Cтарший администратор [2] \
	\n"C_N"• {FFFFFF}Главный администратор [3] \
	\n"C_N"• {FFFFFF}Специальный администратор [4] \
	\n"C_N"• {FFFFFF}Руководящий администратор [5] \
	\n"C_N"• {FFFFFF}Основатель [6]",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:Adm_Commands(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			// Младший администратор
			case 0: {
				Dialog_Open(playerid, Dialog:Adm_CommandsLvl, DSM, "Команды уровня [1]",
				"{CCCCCC}/amenu {FFFFFF}- меню для администрации. \
				\n{CCCCCC}/a {FFFFFF}- админ-чат. \
				\n{CCCCCC}/ot {FFFFFF}- ответ на репорт игроку. \
				\n{CCCCCC}/sp {FFFFFF}- слежка за игроком. \
				\n{CCCCCC}/offsp {FFFFFF}- прекратить слежку за игроком. \
				\n{CCCCCC}/checkstats {FFFFFF}- посмотреть статистику игрока. \
				\n{CCCCCC}/aspawn {FFFFFF}- заспавнить игрока. \
				\n{CCCCCC}/slap {FFFFFF}- подкинуть игрока. \
				\n{CCCCCC}/jp {FFFFFF}- получить Джет-пак. \
				\n{CCCCCC}/admins {FFFFFF}- администрация онлайн. \
				\n{CCCCCC}/adminstats {FFFFFF}- посмотреть свою статистику. \
				\n{CCCCCC}/asend {FFFFFF}- написать от имени администратора.",
				"Назад", "");
			}
			// Cтарший администратор
			case 1: {
				Dialog_Open(playerid, Dialog:Adm_CommandsLvl, DSM, "Команды уровня [2]",
				"{CCCCCC}/gethere {FFFFFF}- телепортировать игрока к себе. \
				\n{CCCCCC}/gotos {FFFFFF}- телепортироваться к игроку. \
				\n{CCCCCC}/getip {FFFFFF}- узнать IP игрока. \
				\n{CCCCCC}/getwarn {FFFFFF}- узнать есть ли у игрока предупреждения. \
				\n{CCCCCC}/z {FFFFFF}- заморозить/разморозить игрока. \
				\n{CCCCCC}/weap {FFFFFF}- забрать оружие у игрока. \
				\n{CCCCCC}/fixveh {FFFFFF}- починить свой транспорт. \
				\n{CCCCCC}/fuelveh {FFFFFF}- пополнить бензин в своём транспорте. \
				\n{CCCCCC}/rfixveh {FFFFFF}- починить транспорт в радиусе. \
				\n{CCCCCC}/rfuelveh {FFFFFF}- пополнить бензин в радиусе.",
				"Назад", "");
			}
			// Главный администратор
			case 2: {
				Dialog_Open(playerid, Dialog:Adm_CommandsLvl, DSM, "Команды уровня [3]",
				"{CCCCCC}/kick {FFFFFF}- кикнуть игрока. \
				\n{CCCCCC}/mute {FFFFFF}- выдать бан-чата игроку. \
				\n{CCCCCC}/unmute {FFFFFF}- снять бан-чата игроку. \
				\n{CCCCCC}/sethp {FFFFFF}- выдать здоровье игроку. \
				\n{CCCCCC}/setarmour {FFFFFF}- выдать броню игроку. \
				\n{CCCCCC}/rsethp {FFFFFF}- выдать здоровье в радиусе. \
				\n{CCCCCC}/rsetarmour {FFFFFF}- выдать броню в радиусе. \
				\n{CCCCCC}/veh {FFFFFF}- создать транспорт. \
				\n{CCCCCC}/delveh {FFFFFF}- удалить созданный транспорт. \
				\n{CCCCCC}/areferals {FFFFFF}- посмотреть рефералы игрока.",
				"Назад", "");
			}
			// Специальный администратор
			case 3: {
				Dialog_Open(playerid, Dialog:Adm_CommandsLvl, DSM, "Команды уровня [4]",
				"{CCCCCC}/ban {FFFFFF}- забанить игрока. \
				\n{CCCCCC}/unban {FFFFFF}- разбанить игрока. \
				\n{CCCCCC}/sban {FFFFFF}- тихо забанить игрока. \
				\n{CCCCCC}/banoff {FFFFFF}- забанить в оффлайне игрока. \
				\n{CCCCCC}/skick {FFFFFF}- тихо кикнуть игрока. \
				\n{CCCCCC}/smute {FFFFFF}- тихо выдать бан-чата игроку. \
				\n{CCCCCC}/sunmute {FFFFFF}- тихо снять бан-чата игроку. \
				\n{CCCCCC}/givegun {FFFFFF}- выдать оружие игроку. \
				\n{CCCCCC}/rgivegun {FFFFFF}- выдать оружие в радиусе. \
				\n{CCCCCC}/warn {FFFFFF}- выдать предупреждение игроку. \
				\n{CCCCCC}/unwarn {FFFFFF}- снять предупреждение игроку.",
				"Назад", "");
			}
			// Руководящий администратор
			case 4: {
				Dialog_Open(playerid, Dialog:Adm_CommandsLvl, DSM, "Команды уровня [5]",
				"{CCCCCC}/setskin {FFFFFF}- выдать скин игроку. \
				\n{CCCCCC}/rsetskin {FFFFFF}- выдать скин в радиусе. \
				\n{CCCCCC}/clearchat {FFFFFF}- очистить чат. \
				\n{CCCCCC}/aset {FFFFFF}- выдать набор оружия игроку. \
				\n{CCCCCC}/raset {FFFFFF}- выдать набор оружия в радиусе. \
				\n{CCCCCC}/warnoff {FFFFFF}- выдать предупреждение игроку в оффлайн. \
				\n{CCCCCC}/unwarnoff {FFFFFF}- снять предупреждение игроку в оффлайн. \
				\n{CCCCCC}/givemoney {FFFFFF}- выдать кредиты игроку. \
				\n{CCCCCC}/giverank {FFFFFF}- выдать ранг игроку. \
				\n{CCCCCC}/giverpoint {FFFFFF}- выдать очки раунда игроку. \
				\n{CCCCCC}/adamage {FFFFFF}- вкл/выкл урон игроку. \
				\n{CCCCCC}/astats {FFFFFF}- посмотреть статистику администратора. \
				\n{CCCCCC}/ao {FFFFFF}- написать всем игрокам от имени сервера.",
				"Назад", "");
			}
			// Основатель
			case 5: {
				Dialog_Open(playerid, Dialog:Adm_CommandsLvl, DSM, "Команды уровня [6]",
				"{CCCCCC}/makeadmin {FFFFFF}- выдать/снять права админстратора. \
				\n{CCCCCC}/makeadminoff {FFFFFF}- снять права администратора в оффлайне. \
				\n{CCCCCC}/changeservername {FFFFFF}- изменить название сервера. \
				\n{CCCCCC}/awarn {FFFFFF}- выдать выговор администратору. \
				\n{CCCCCC}/aunwarn {FFFFFF}- снять выговор админстратору. \
				\n{CCCCCC}/serversettings {FFFFFF}- открыть настройки сервера. \
				\n{CCCCCC}/mp {FFFFFF}- сменить локацию. \
				\n{CCCCCC}/setitem {FFFFFF}- выдать игроку предмет. \
				\n{CCCCCC}/setbanner {FFFFFF}- выдать игроку баннер. \
				\n{CCCCCC}/dreports {FFFFFF}- удалить все репорты.",
				"Назад", "");
			}
		}
	}
	else 
		Dialog_Show(playerid, Dialog:Adm_Menu);
	
	return 1;
}

DialogCreate:Adm_Stats(playerid)
{
	static
		string[1000];

	string[0] = EOS;

	f(string, "{CCCCCC}Админ: {FFFF33}[%s] \
	\n\n{CCCCCC}Уровень: {FFFFFF}[%i] (%s) \
	\n{CCCCCC}Репутация: {FFFFFF}[%i] \
	\n{CCCCCC}Выговоров: {FFFFFF}[%i] \
	\n{CCCCCC}Кикнуто: {FFFFFF}[%i] \
	\n{CCCCCC}Забанено: {FFFFFF}[%i] \
	\n{CCCCCC}Разбанено: {FFFFFF}[%i] \
	\n{CCCCCC}Мутов: {FFFFFF}[%i] \
	\n{CCCCCC}Убрано мутов: {FFFFFF}[%i] \
	\n{CCCCCC}Варнов: {FFFFFF}[%i] \
	\n{CCCCCC}Убрано варнов: {FFFFFF}[%i] \
	\n\n{CCCCCC}Дата выдачи админ прав: {FFFFFF}[%s] \
	\n{CCCCCC}Последний заход на сервер: {FFFFFF}[%s]", NameEx(playerid), adm_PlayerInfo[playerid][ADM_Level], GetAdminNameLevel(adm_PlayerInfo[playerid][ADM_Level]), adm_PlayerInfo[playerid][ADM_Reputation], adm_PlayerInfo[playerid][ADM_Reprimands], adm_PlayerInfo[playerid][ADM_Kicks], adm_PlayerInfo[playerid][ADM_Bans], 
	adm_PlayerInfo[playerid][ADM_UnBans], adm_PlayerInfo[playerid][ADM_Muts], adm_PlayerInfo[playerid][ADM_UnMuts], 
	adm_PlayerInfo[playerid][ADM_Warns], adm_PlayerInfo[playerid][ADM_UnWarns], adm_PlayerInfo[playerid][ADM_Data], pInfo[playerid][pOldData]);
	Dialog_Message(playerid, "Статистика администратора", string, "Закрыть");
	return 1;
}

DialogCreate:Adm_WarnPlayer(playerid)
{
	Dialog_Open(playerid, Dialog:Adm_WarnPlayer, DSI, "Выдать предупреждение игроку", 
	"{FFFFFF}Введите в строчку причину. \
	\n\nМаксимум 30 символов!", "Выдать", "Закрыть");
	return 1;
}

DialogResponse:Adm_WarnPlayer(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(GetPlayerSpectating(playerid) == INVALID_PLAYER_ID 
		|| GetPlayerSpectating(playerid) == -1) 
			return 1;
		
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Adm_WarnPlayer);
		
		if(strlen(inputtext) > 30) 
			return Dialog_Show(playerid, Dialog:Adm_WarnPlayer);

		pInfo[GetPlayerSpectating(playerid)][pWarn]++;

		if(pInfo[GetPlayerSpectating(playerid)][pWarn] != 3) {
			adm_PlayerInfo[playerid][ADM_Warns]++;

			new
				querys[150];

			mysql_format(MysqlID, querys, sizeof(querys), "UPDATE `"T_ADMINS"` SET `Warns` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Warns], adm_PlayerInfo[playerid][ADM_ID]);
			mysql_tquery(MysqlID, querys);

			new
				query[150];

			mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", pInfo[GetPlayerSpectating(playerid)][pWarn], GetPlayerpID(GetPlayerSpectating(playerid)));
			mysql_tquery(MysqlID, query);

			new
				string[250],
				strings[250];

			f(string, "{FF6347}Игроку %s (ID:%i) выдано предупреждение [%i из 3]. Причина: %s", NameEx(GetPlayerSpectating(playerid)), GetPlayerSpectating(playerid), pInfo[GetPlayerSpectating(playerid)][pWarn], inputtext);
			SCM(playerid, -1, string);

			f(strings, "{FF6347}Администратор %s (ID:%i) выдал вам предупреждение [%i из 3]. Причина: %s", NameEx(playerid), playerid, pInfo[GetPlayerSpectating(playerid)][pWarn], inputtext);
			SCM(GetPlayerSpectating(playerid), -1, strings);
			return 1;
		}
		else if(pInfo[GetPlayerSpectating(playerid)][pWarn] == 3) {
			adm_PlayerInfo[playerid][ADM_Warns]++;

			new
				querys[150];
			
			mysql_format(MysqlID, querys, sizeof(querys), "UPDATE `"T_ADMINS"` SET `Warns` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Warns], adm_PlayerInfo[playerid][ADM_ID]);
			mysql_tquery(MysqlID, querys);

			new
				query[150];
			
			mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", pInfo[GetPlayerSpectating(playerid)][pWarn], GetPlayerpID(GetPlayerSpectating(playerid)));
			mysql_tquery(MysqlID, query);

			new
				string[250],
				strings[250];
			
			f(string, "{FF6347}Игроку %s (ID:%i) выдано предупреждение [%i из 3]. Причина: %s", NameEx(GetPlayerSpectating(playerid)), GetPlayerSpectating(playerid), pInfo[GetPlayerSpectating(playerid)][pWarn], inputtext);
			SCM(playerid, -1, string);

			f(strings, "{FF6347}Администратор %s (ID:%i) выдал вам предупреждение [%i из 3]. Причина: %s", NameEx(playerid), playerid, pInfo[GetPlayerSpectating(playerid)][pWarn], inputtext);
			SCM(GetPlayerSpectating(playerid), -1, strings);

			BanPlayer(NameEx(GetPlayerSpectating(playerid)), NameEx(playerid), 3, "Warns: 3");

			SCM(GetPlayerSpectating(playerid), -1, "{CC0033}(Бан) {FFFFFF}Вы получили бан на 3 дня за 3 предупреждения.");
			pInfo[GetPlayerSpectating(playerid)][pWarn] = 0;

			new
				queryg[150];

			mysql_format(MysqlID, queryg, sizeof(queryg), "UPDATE `"T_ACCOUNTS"` SET `Warn` = '%i' WHERE `ID` = '%d'", pInfo[GetPlayerSpectating(playerid)][pWarn], GetPlayerpID(GetPlayerSpectating(playerid)));
			mysql_tquery(MysqlID, queryg);

			KickEx(GetPlayerSpectating(playerid));
			return 1;
		}

		pInfo[GetPlayerSpectating(playerid)][pWarn]--;

		SCM(GetPlayerSpectating(playerid), COLOR_ERROR, "(Ошибка) {FFFFFF}У данного игрока уже 3 предупреждения.");
	}
	return 1;
}

DialogCreate:Adm_KickPlayer(playerid)
{
	Dialog_Open(playerid, Dialog:Adm_KickPlayer, DSI, "Кикнуть игрока", 
	"{FFFFFF}Введите в строчку причину. \
	\n\nМаксимум 30 символов!", "Кикнуть", "Закрыть");
	return 1;
}

DialogResponse:Adm_KickPlayer(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(GetPlayerSpectating(playerid) == INVALID_PLAYER_ID 
		|| GetPlayerSpectating(playerid) == -1) 
			return 1;
		
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Adm_KickPlayer);

		if(strlen(inputtext) > 30) 
			return Dialog_Show(playerid, Dialog:Adm_KickPlayer);

		adm_PlayerInfo[playerid][ADM_Kicks]++;

		new
			query[150];
		
		mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ADMINS"` SET `Kicks` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Kicks], adm_PlayerInfo[playerid][ADM_ID]);
		mysql_tquery(MysqlID, query);

		new
			string[250];

		string[0] = EOS;

		foreach(Player, p) {
			if(!IsPlayerOnServer(p)) 
				continue;

			string[0] = EOS;
			
			f(string, "{FF6347}Администратор %s (ID:%i) кикнул %s (ID:%i) по причине: %s", NameEx(playerid), playerid, NameEx(GetPlayerSpectating(playerid)), GetPlayerSpectating(playerid), inputtext);
			SCM(p, -1, string);
		}

		KickEx(GetPlayerSpectating(playerid));
	}
	return 1;
}

DialogCreate:Adm_BanPlayer(playerid)
{
	Dialog_Open(playerid, Dialog:Adm_BanPlayer, DSI, "Забанить игрока", 
	"{FFFFFF}Введите в строчку кол-во дней и причину. \
	\nВводить через запятую без пробелов ( 10,Чит ). \
	\n\nМаксимум 30 символов!", "Бан", "Закрыть");
	return 1;
}

DialogResponse:Adm_BanPlayer(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(GetPlayerSpectating(playerid) == INVALID_PLAYER_ID 
		|| GetPlayerSpectating(playerid) == -1) 
			return 1;

		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:Adm_BanPlayer);

		if(strlen(inputtext) > 30) 
			return Dialog_Show(playerid, Dialog:Adm_BanPlayer);

		new 
			days, 
			reason[30];

		sscanf(inputtext, "p<,>ds[30]", days, reason);

		if(days < 0 
		|| days > 30) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Возможно только от 1 дня до 30 дней.");
			Dialog_Show(playerid, Dialog:Adm_BanPlayer);
			return 1;
		}

		adm_PlayerInfo[playerid][ADM_Bans]++;

		new
			query[150];
		
		mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ADMINS"` SET `Bans` = '%i' WHERE `ID` = '%d'", adm_PlayerInfo[playerid][ADM_Bans], adm_PlayerInfo[playerid][ADM_ID]);
		mysql_tquery(MysqlID, query);

		static
			string[250];

		string[0] = EOS;

		foreach(Player, p) {
			if(!IsPlayerOnServer(p)) 
				continue;

			string[0] = EOS;
			
			new 
				dName[10];
			
			switch(days) {
				case 1,21: dName = "день";
				case 2,3,4,22,23,24: dName = "дня";
				case 5..20,25..30: dName = "дней";
			}
			f(string, "{FF6347}Администратор %s (ID:%i) забанил %s (ID:%i) на %i %s. Причина: %s", NameEx(playerid), playerid, NameEx(GetPlayerSpectating(playerid)), GetPlayerSpectating(playerid), days, dName, reason);
			SCM(p, -1, string);
		}

		BanPlayer(NameEx(GetPlayerSpectating(playerid)), NameEx(playerid), days, reason);
		KickEx(GetPlayerSpectating(playerid));
	}
	return 1;
}

DialogCreate:Adm_Online(playerid)
{
	new
		sctring[1300];

	foreach(new p:admin_players) {
		new
			str[200];

		f(str, "{FFFF33}%s (ID:%i) {FFFFFF}[уровень: {FFFF33}%i (%s){FFFFFF}]\n", NameEx(p), p, adm_PlayerInfo[p][ADM_Level], GetAdminNameLevel(adm_PlayerInfo[p][ADM_Level]));
		strcat(sctring, str);
	}
	Dialog_Open(playerid, Dialog:Adm_Online, DSM, "Администрация в сети", sctring, "Назад", "");
	return 1;
}

DialogResponse:Adm_Online(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:Adm_Menu);
	return 1;
}

DialogCreate:Adm_Menu(playerid)
{
	Dialog_Open(playerid, Dialog:Adm_Menu, DSL, "Панель администратора", "\
	"C_N"• {FFFFFF}Команды администраторов \
	\n"C_N"• {FFFFFF}Администрация в сети \
	\n"C_N"• {FFFFFF}Список администраторов \
	\n"C_N"• {FFFFFF}Список забаненых \
	\n"C_N"• {FFFFFF}Очистить чат \
	\n"C_N"• {FFFFFF}Заспавниться \
	\n"C_N"• {FFFFFF}Починить транспорт \
	\n"C_N"• {FFFFFF}Настройки сервера",
	"Выбрать", "Выход");
	return 1;
}

DialogResponse:Adm_Menu(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:Adm_Commands);
			case 1: Dialog_Show(playerid, Dialog:Adm_Online);
			case 2: mysql_pquery(MysqlID, "SELECT ID, Name, Level, Data FROM admins WHERE BINARY Level > 0 ORDER BY Level DESC", "OnAllAdminsLoaded", "d", playerid);
			case 3: {
				if(Adm_GetPlayerLevel(playerid) < 4) {
					Adm_ErrorTextForAdmin(playerid);
					Dialog_Show(playerid, Dialog:Adm_Menu);
					return 1;
				}

				new 
					Cache:result = mysql_query(MysqlID, "SELECT `Name` FROM `"T_BANS"` ORDER BY `ID` DESC LIMIT 0 , 20"),
					accounts;
				
				cache_get_row_count(accounts);

				if(!accounts) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Список забаненных пуст");
					Dialog_Show(playerid, Dialog:Adm_Menu);
					return 1;
				}

				new
					Names[MAX_PLAYER_NAME];
				
				n_for(i, accounts) {
					cache_get_value_name(i, "Name", Names, MAX_PLAYER_NAME);
					f(stringer, "%s%s\n", stringer, Names);
				}
				if(accounts == 20) 
					f(stringer, "%s{CCCCCC}>>>\n", stringer);
				
				cache_delete(result);

				Dialog_Show(playerid, Dialog:Adm_ListBan);
			}
			case 4: {
				n_for(i, 17)
					SendClientMessageToAll(-1, " ");
				
				foreach(Player, p) {
					if(!IsPlayerOnServer(p)) 
						continue;
					
					SCM(p, COLOR_INFO, "(Информация) {FFFFFF}Чат очищен администрацией.");
				}
				Dialog_Show(playerid, Dialog:Adm_Menu);
			}
			case 5: {
				if(Mode_GetPlayer(playerid) == MODE_NONE 
				|| GetPlayerBusy(playerid) != GAME) {
					SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Необходимо находиться в каком-нибудь режиме.");
					Dialog_Show(playerid, Dialog:Adm_Menu);
					return 1;
				}
				PlayerSpawn(playerid);
			}
			case 6: {
				if(Adm_GetPlayerLevel(playerid) < 2) 
					return Adm_ErrorTextForAdmin(playerid);
				
				if(!IsPlayerInAnyVehicle(playerid)) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы должны находится в транспорте.");
					Dialog_Show(playerid, Dialog:Adm_Menu);
					return 1;
				}
				new 
					vehicle = GetPlayerVehicleID(playerid);
				
				RepairVehicle(vehicle);
				Dialog_Show(playerid, Dialog:Adm_Menu);
			}
			case 7: {
				Dialog_Show(playerid, Dialog:ServerOptions);
			}
		}
	}
	return 1;
}

DialogCreate:Adm_SelectMode(playerid)
{
	DeletePVar(playerid, "SessionMode_PVar");
	Dialog_Open(playerid, Dialog:Adm_SelectMode, DSL, "Список режимов", ""C_N"• {FFFFFF}Режим: TDM\n"C_N"• {FFFFFF}Режим: DM", "Выбрать", "Выход");
	return 1;
}

DialogResponse:Adm_SelectMode(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:TDM_SelectSession);
			case 1: Dialog_Show(playerid, Dialog:DM_SelectSession);
		}
	}
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

public OnGameModeInit()
{
	Iter_Init(spec_admin_playerid);

	n_for(i, MAX_VEHICLES)
		aActiveAdminVehicle{i} = false;

	n_for(i, MAX_REPORTS) {
		aTextReport[i][0] = EOS;
		aSlotReport[i] =
		aCountReports[i] = 0;
	}

	// TextDraws cheaters
	n_for(i, ADM_TD_MAX_CHEATERS)
		aCheaters[i][td_cheat1] = -1;

	aCheaters1 = 0;

	new
		Float:DrawPos = 184.0;
	
	n_for(i, 10) {
		if(i > 0) 
			DrawPos += 30.0;

		TD_aCheaters[i] = TextDrawCreate(DrawPos, 427.0, "-1");
		TextDrawLetterSize(TD_aCheaters[i], 0.3215, 1.3925);
		TextDrawTextSize(TD_aCheaters[i], -31.0000, 0.0000);
		TextDrawAlignment(TD_aCheaters[i], TEXT_DRAW_ALIGN_LEFT);
		TextDrawColour(TD_aCheaters[i], 0xef8100FF);
		TextDrawSetOutline(TD_aCheaters[i], 1);
		TextDrawBackgroundColour(TD_aCheaters[i], 96);
		TextDrawFont(TD_aCheaters[i], TEXT_DRAW_FONT_AHARONI_BOLD);
		TextDrawSetProportional(TD_aCheaters[i], true);
		TextDrawSetShadow(TD_aCheaters[i], 0);
	}
	//

	#if defined Admin_OnGameModeInit
		return Admin_OnGameModeInit();
	#else
		return 1;
	#endif
}

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);
	ResetPlayerTDs(playerid);

	aActivePlayerSpec{playerid} = false;

	aAdminVehicle[playerid] = INVALID_VEHICLE_ID;

	// Report
	aPlayerReReport[playerid] =
	aActionPlayerReportSend[playerid] = 0;
	aReport_Playerid[playerid] = -1;

	aDialogFirstBL[playerid] = 0;
	aUnbanName[playerid][0] = EOS;

	#if defined Admin_OnPlayerConnect
		return Admin_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerDisconnect
*/

public OnPlayerDisconnect(playerid, reason)
{
	n_for(i, ADM_TD_MAX_CHEATERS) {
		if(aCheaters[i][td_cheat1] == playerid) {
			TextDrawSetString(TD_aCheaters[i], "-1");

			aCheaters1++;

			if(aCheaters1 > 9) 
				aCheaters1 = 0;
		}
	}

	n_for(i, MAX_REPORTS) {
		if(aCountReports[i] == playerid)
			ReportReset(i);
	}

	if(aAdminVehicle[playerid] != INVALID_VEHICLE_ID) {
		aActiveAdminVehicle[aAdminVehicle[playerid]] = false;
		DestroyVehicleEx(aAdminVehicle[playerid]);
	}

	#if defined Admin_OnPlayerDisconnect
		return Admin_OnPlayerDisconnect(playerid, reason);
	#else
		return 1;
	#endif
}

/*
	OnPlayerClickMap
*/

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(adm_PlayerInfo[playerid][ADM_Level]) {
		new
			vehicleid = GetPlayerVehicleIDEx(playerid);

		if(vehicleid > 0
		&& GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			SetVehiclePos(vehicleid, fX, fY, fZ + 0.5);
		else
			SetPlayerPosEx(playerid, fX, fY, fZ, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	}

	#if defined Admin_OnPlayerClickMap
		return Admin_OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ);
	#else
		return 1;
	#endif
}

/*
	ALS
*/

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Admin_OnGameModeInit
#if defined Admin_OnGameModeInit
	forward Admin_OnGameModeInit();
#endif


#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Admin_OnPlayerConnect
#if defined Admin_OnPlayerConnect
	forward Admin_OnPlayerConnect(playerid);
#endif


#if defined _ALS_OnPlayerDisconnect
	#undef OnPlayerDisconnect
#else
	#define _ALS_OnPlayerDisconnect
#endif
#define OnPlayerDisconnect Admin_OnPlayerDisconnect
#if defined Admin_OnPlayerDisconnect
	forward Admin_OnPlayerDisconnect(playerid, reason);
#endif


#if defined _ALS_OnPlayerClickMap
	#undef OnPlayerClickMap
#else
	#define _ALS_OnPlayerClickMap
#endif
#define OnPlayerClickMap Admin_OnPlayerClickMap
#if defined Admin_OnPlayerClickMap
	forward Admin_OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ);
#endif