/*
 * |>=========================<|
 * |   About: Mode None main   |
 * |   Author: Foxze           |
 * |>=========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnPlayerConnect(playerid)
	- OnPlayerSpawn(playerid)
	- OnPlayerDeath(playerid, killerid, WEAPON:reason)
 * Stock:
	- None_CreateSession(sessionid)
	- None_DestroySession(sessionid)
	- None_CreateFirstSessions()

	- None_CreateLocation(sessionid)
	- None_DestroyLocation(sessionid)
	- None_CreatePlayerLocation(playerid, sessionid)
	- None_DestroyPlayerLocation(playerid)

	- None_UpdatePlayerData(playerid)

	- None_SetPlayerOptions(playerid)

	- ShowPlayerMainMenu(playerid)
	- EnterPlayerMainMenu(playerid)
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
	- (None)
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- MainMenu
	- MM_SelectModes
 */

#if defined _INC_NONE_MAIN
	#endinput
#endif
#define _INC_NONE_MAIN

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	PlayerCreatedModeidTD[MAX_PLAYERS][GMS_MAX_MODES],
	PlayerCreatedModesTD[MAX_PLAYERS];

static
	PlayerText:TD_MainMenu[MAX_PLAYERS][NONE_TD_MAIN_MENU],
	PlayerText:TD_SelectMode[MAX_PLAYERS][NONE_TD_SELECT_MODE];

static
	ObjectOnShip[GMS_MAX_SESSIONS][15],
	ActorOnShip[GMS_MAX_SESSIONS][3],

	PlayerObjectOnShip[MAX_PLAYERS],
	PlayerVehicleOnShip[MAX_PLAYERS];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>----------------------------<|
 * |   Session create & destroy   |
 * |>----------------------------<|
 */

stock None_CreateSession(sessionid)
{
	None_CreateLocation(sessionid);
	return 1;
}

stock None_DestroySession(sessionid)
{
	ResetSessionData(sessionid);
	return 1;
}

stock None_CreateFirstSessions()
{
	n_for(i, GMS_MAX_SESSIONS) {
		Mode_CreateSession(MODE_NONE);
	}
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Location create & destroy   |
 * |>-----------------------------<|
 */

stock None_CreateLocation(sessionid)
{
	new
		worldid = Mode_GetSessionVirtualWorld(MODE_NONE, sessionid),
		interiorid = Mode_GetSessionInterior(MODE_NONE, sessionid);

	// Objects
	ObjectOnShip[sessionid][0] = CreateDynamicObject(10771, 3549.93433, 2295.48657, 5.58360, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ObjectOnShip[sessionid][1] = CreateDynamicObject(10772, 3551.35376, 2295.33740, 17.39470, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ObjectOnShip[sessionid][2] = CreateDynamicObject(10770, 3553.15405, 2287.96753, 38.53816, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ObjectOnShip[sessionid][3] = CreateDynamicObject(11237, 3550.29004, 2287.94287, 38.24121, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ObjectOnShip[sessionid][4] = CreateDynamicObject(18649, 3566.98560, 2287.89453, 47.90260, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ObjectOnShip[sessionid][5] = CreateDynamicObject(8874, 3540.72803, 2295.93872, 22.22697, 0.00000, 0.00000, 156.00000, worldid, interiorid);
	ObjectOnShip[sessionid][6] = CreateDynamicObject(19294, 3462.13672, 2285.72290, 17.36524, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ObjectOnShip[sessionid][7] = CreateDynamicObject(19294, 3462.03125, 2305.28540, 17.36569, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ObjectOnShip[sessionid][8] = CreateDynamicObject(18647, 3493.14453, 2304.88086, 17.39010, 0.00000, 0.00000, 90.00000, worldid, interiorid);
	ObjectOnShip[sessionid][9] = CreateDynamicObject(931, 3537.68091, 2294.50830, 18.36260, 0.00000, 1.00000, 0.00000, worldid, interiorid);
	ObjectOnShip[sessionid][10] = CreateDynamicObject(3789, 3510.32178, 2305.93481, 17.68780, 0.00000, 0.00000, -33.00000, worldid, interiorid);
	ObjectOnShip[sessionid][11] = CreateDynamicObject(3789, 3513.90894, 2306.31274, 17.68780, 0.00000, 0.00000, -69.00000, worldid, interiorid);
	ObjectOnShip[sessionid][12] = CreateDynamicObject(3791, 3517.62793, 2306.63184, 17.80560, 0.00000, 0.00000, -164.00000, worldid, interiorid);
	ObjectOnShip[sessionid][13] = CreateDynamicObject(19294, 3440.42505, 2310.86133, 15.72336, 0.00000, 0.00000, 0.00000, worldid, interiorid);
	ObjectOnShip[sessionid][14] = CreateDynamicObject(19294, 3440.44531, 2280.11841, 15.72403, 0.00000, 0.00000, 0.00000, worldid, interiorid);

	// Actors
	ActorOnShip[sessionid][0] = CreateDynamicActor(191, 3506.8464, 2305.5649, 18.3745 + 1.0, 4.4027, .worldid = worldid, .interiorid = interiorid); // Communicates 1
	ActorOnShip[sessionid][1] = CreateDynamicActor(287, 3506.7939, 2306.7275, 18.3745 + 1.0, 177.9065, .worldid = worldid, .interiorid = interiorid); // Communicates 2
	ActorOnShip[sessionid][2] = CreateDynamicActor(287, 3486.8884, 2289.9583, 18.3677 + 1.0, 203.2894, .worldid = worldid, .interiorid = interiorid); // Stands next to the helicopter

	ApplyDynamicActorAnimation(ActorOnShip[sessionid][0], "PED", "IDLE_CHAT", 4.1, true, false, false, false, 0);
	ApplyDynamicActorAnimation(ActorOnShip[sessionid][1], "MISC", "Idle_Chat_02", 4.1, true, false, false, false, 0);
	ApplyDynamicActorAnimation(ActorOnShip[sessionid][2], "RYDER", "RYD_BECKON_01", 4.1, true, false, false, false, 0);
	return 1;
}

stock None_DestroyLocation(sessionid)
{
	n_for(i, sizeof(ObjectOnShip[])) {
		DestroyDynamicObject(ObjectOnShip[sessionid][i]);
	}

	n_for(i, sizeof(ActorOnShip[])) {
		DestroyDynamicActor(ActorOnShip[sessionid][i]);
	}
	return 1;
}

stock None_CreatePlayerLocation(playerid, sessionid)
{
	if (!GetAdminSpectating(playerid)) {
		new
			worldid = Mode_GetSessionVirtualWorld(MODE_NONE, sessionid),
			interiorid = Mode_GetSessionInterior(MODE_NONE, sessionid);

		// Object
		PlayerObjectOnShip[playerid] = CreatePlayerObject(playerid, 19544, 3492.27490, 2295.77979, 17.37200, 0.00000, 0.00000, 90.00000, 100.0);

		// Vehicle
		PlayerVehicleOnShip[playerid] = CreateVehicleEx(548, 3491.6301, 2287.7439, 20.0765, 90.0000, 107, -1, 100);

		SetVehicleVirtualWorldEx(PlayerVehicleOnShip[playerid], worldid);
		SetVehicleInteriorEx(PlayerVehicleOnShip[playerid], interiorid);

		EnableHealthBarForPlayer(playerid, false);
		SettingsPlayerSpawn(playerid);

		if (!GetPlayerLogged(playerid)) {
			SpecPl(playerid, false);

			ShowPlayerMainMenu(playerid);
			SpawnPlayerLoaded(playerid);
		}
		else {
			// Skip <spawn> button
			SpecPl(playerid, true);
			SpecPl(playerid, false);
		}

		SetPlayerCameraMainMenu(playerid);
		SetPlayerAnimation(playerid);
	}
	return 1;
}

stock None_DestroyPlayerLocation(playerid)
{
	if (!GetAdminSpectating(playerid)) {
		SetPlayerClickTD(playerid, false);

		if (IsValidPlayerObject(playerid, PlayerObjectOnShip[playerid])) {
			DestroyPlayerObject(playerid, PlayerObjectOnShip[playerid]);
		}

		DestroyVehicleEx(PlayerVehicleOnShip[playerid]);
	}

	DestroyPlayerMainMenuTD(playerid);
	return 1;
}

/*
 * |>----------------------<|
 * |   Timers update data   |
 * |>----------------------<|
 */

stock None_UpdatePlayerData(playerid)
{
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));

	UpdatePlayerSecPassTimer(playerid);

	GivePlayerSecondTime(playerid);
	return 1;
}

/*
 * |>-------------------<|
 * |   Close inventory   |
 * |>-------------------<|
 */

stock None_SetPlayerOptions(playerid)
{
	SetPlayerSkinEx(playerid, Mode_GetPlayerSkin(playerid, MODE_NONE));
	SetPlayerAttachInvItem(playerid);

	SetPlayerAnimation(playerid);
	return 1;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

stock ShowPlayerMainMenu(playerid)
{
	PreloadAllAnimLibs(playerid);

	SetPlayerCameraMainMenu(playerid);

	SetPlayerClickTD(playerid, true);
	SetPlayerCanSpectating(playerid, true);
	SetPlayerDamage(playerid, false);

	SetPlayerColorEx(playerid, 0xCCCCCC00);

	if (GetPlayerLogged(playerid)) {
		if (CheckPlayerDailyBonus(playerid)) {
			return 1;
		}
	}

	EnterPlayerMainMenu(playerid);
	return 1;
}

stock EnterPlayerMainMenu(playerid)
{
	Interface_Show(playerid, Interface:MainMenu);
	SelectTextDraw(playerid, TD_C_GREY);

	// First entrance
	if (GetPlayerLogged(playerid)) {
		SetPlayerLogged(playerid, false);

		// Admin
		if (GetAdminLevel(playerid) != ADM_LEVEL_NONE) {
			Iter_Add(TotalAdmins, playerid);
		}
		
		// Premium
		if (GetPlayerPremium(playerid) != PREMIUM_LEVEL_NONE) {
			CheckPremiumAccount(playerid);
		}
	}

	if (GetPlayerCanSpectating(playerid)) {
		SetPlayerCanSpectating(playerid, false);
	}

	PlayerPlaySoundEx(playerid, 0, 0.0, 0.0, 0.0);
	CheckPlayerDinaHint(playerid, 3, 1);

	SpawnPlayerLoaded(playerid);
	SetPlayerAnimation(playerid);
	return 1;
}

static DestroyPlayerMainMenuTD(playerid)
{
	if (Interface_IsOpen(playerid, Interface:Inventory)) {
		Interface_Close(playerid, Interface:Inventory);
	}

	if (Interface_IsOpen(playerid, Interface:TradingPlatform)) {
		Interface_Close(playerid, Interface:TradingPlatform);
	}

	if (Interface_IsOpen(playerid, Interface:SecondPassword)) {
		Interface_Close(playerid, Interface:SecondPassword);
	}

	if (Interface_IsOpen(playerid, Interface:MainMenu)) {
		Interface_Close(playerid, Interface:MainMenu);
	}

	if (Interface_IsOpen(playerid, Interface:MM_SelectModes)) {
		Interface_Close(playerid, Interface:MM_SelectModes);
	}

	if (Interface_IsOpen(playerid, Interface:Room_Lobby)) {
		Room_ExitPlayerLobby(playerid);
	}

	ClosePlayerDialog(playerid);
	return 1;
}

static SetPlayerCameraMainMenu(playerid)
{
	if (GetSpecPl(playerid)) {
		InterpolateCameraPos(playerid, 3470.421875, 2295.754150, 18.701770,3470.421875, 2295.754150, 18.701770, 1000);
		InterpolateCameraLookAt(playerid, 3475.421142, 2295.762451, 18.779893, 3475.421142, 2295.762451, 18.779893, 1000);
	}
	else {
		SetPlayerCameraPos(playerid, 3470.421875, 2295.754150, 18.701770);
		SetPlayerCameraLookAt(playerid, 3475.421142, 2295.762451, 18.779893);
	}
	return 1;
}

static SetPlayerAnimation(playerid)
{
	new
		randomAnim = random(4);

	switch (randomAnim) {
		case 0: {
			ApplyAnimation(playerid, "DEALER", "DEALER_IDLE", 4.1, true, false, false, false, 0);
		}
		case 1: {
			ApplyAnimation(playerid, "PED", "FACGUM", 4.1, true, false, false, false, 0);
		}
		case 2: {
			ApplyAnimation(playerid, "PED", "FIGHTIDLE", 4.1, true, false, false, false, 0);
		}
		case 3: {
			ApplyAnimation(playerid, "PED", "XPRESSSCRATCH", 4.1, true, false, false, false, 0);
		}
	}
	return 1;
}

static SpawnPlayerLoaded(playerid)
{
	if (GetPlayerLogged(playerid)) {
		return 0;
	}

	SetPlayerPosEx(playerid, 3474.8198, 2295.6914, 18.3677 + 0.3, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
	SetPlayerFacingAngle(playerid, 90.0957);

	SetPlayerSkinEx(playerid, Mode_GetPlayerSkin(playerid, MODE_NONE));
	SetPlayerAttachInvItem(playerid);
	return 1;
}

static SettingsPlayerSpawn(playerid)
{
	new
		skinid = Mode_GetPlayerSkin(playerid, MODE_NONE);

	Mode_SetPlayerVirtualWorld(playerid, MODE_NONE, 0);
	Mode_SetPlayerInterior(playerid, MODE_NONE, 0);

	if (GetPlayerLogged(playerid)) {		
		SetSpawnInfoEx(playerid, skinid, 3474.8198, 2295.6914 - 10.0, 18.3677 + 0.3, 90.0957);
	}
	else {
		SetSpawnInfoEx(playerid, skinid, 3474.8198, 2295.6914, 18.3677 + 0.3, 90.0957);
	}
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetSessionData(sessionid)
{
	n_for(i, sizeof(ObjectOnShip[])) {
		ObjectOnShip[sessionid][i] = INVALID_DYNAMIC_OBJECT_ID;
	}

	n_for(i, sizeof(ActorOnShip[])) {
		ActorOnShip[sessionid][i] = INVALID_DYNAMIC_ACTOR_ID;
	}
	return 1;
}

static ResetPlayerData(playerid)
{
	n_for(i, GMS_MAX_MODES) {
		PlayerCreatedModeidTD[playerid][i] = -1;
	}
	PlayerCreatedModesTD[playerid] = 0;

	PlayerObjectOnShip[playerid] = INVALID_OBJECT_ID;
	PlayerVehicleOnShip[playerid] = INVALID_VEHICLE_ID;
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(i, NONE_TD_MAIN_MENU) {
		TD_MainMenu[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, NONE_TD_SELECT_MODE) {
		TD_SelectMode[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	return 1;
}

/*
 * |>------------------<|
 * |     Interfaces     |
 * |>------------------<|
 */

InterfaceCreate:MainMenu(playerid)
{
	None_CreatePlayerMainMenuTD(playerid, TD_MainMenu[playerid]);

	n_for(i, NONE_TD_MAIN_MENU) {
		PlayerTextDrawShow(playerid, TD_MainMenu[playerid][i]);
	}
	return 1;
}

InterfaceClose:MainMenu(playerid)
{
	n_for(i, NONE_TD_MAIN_MENU) {
		DestroyPlayerTD(playerid, TD_MainMenu[playerid][i]);
	}
	return 1;
}

InterfacePlayerClick:MainMenu(playerid, PlayerText:playertextid)
{
	if (playertextid == TD_MainMenu[playerid][5]) {
		Interface_Close(playerid, Interface:MainMenu);
		Interface_Show(playerid, Interface:MM_SelectModes);

		CheckPlayerDinaHint(playerid, 6);
		return 1;
	}
	else if (playertextid == TD_MainMenu[playerid][8]) {
		return Dialog_Show(playerid, Dialog:ChoosePlayerStats);
	}
	else if (playertextid == TD_MainMenu[playerid][11]) {
		Interface_Close(playerid, Interface:MainMenu);
		Interface_Show(playerid, Interface:Inventory);

		CheckPlayerDinaHint(playerid, 4);
		return 1;
	}
	else if (playertextid == TD_MainMenu[playerid][14]) {
		Interface_Close(playerid, Interface:MainMenu);
		Interface_Show(playerid, Interface:TradingPlatform);

		CheckPlayerDinaHint(playerid, 5);
		return 1;
	}
	else if (playertextid == TD_MainMenu[playerid][17]) {
		return Dialog_Show(playerid, Dialog:Help);
	}
	else if (playertextid == TD_MainMenu[playerid][20]) {
		return Dialog_Show(playerid, Dialog:Donate);
	}
	else if (playertextid == TD_MainMenu[playerid][23]) {
		return Dialog_Show(playerid, Dialog:PlayerOptions);
	}
	else if (playertextid == TD_MainMenu[playerid][26]) {
		return Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
	}
	else if (playertextid == TD_MainMenu[playerid][29]) {
		if (GetPlayerRank(playerid) < LIMIT_RANK_PROMOCODE) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Для активации промо-кода требуется %i ранг!", LIMIT_RANK_PROMOCODE);
			Dialog_Show(playerid, Dialog:PlayerMenu);
			
			return 1;
		}
		if (strcmp(GetPlayerPromoCode(playerid), DB_STRING_VALUE_NO, true)) {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы уже активировали промо-код!");
			Dialog_Show(playerid, Dialog:PlayerMenu);
			
			return 1;
		}
		Dialog_Show(playerid, Dialog:UsePlayerPromoCode);
		return 1;
	}
	return 1;
}

InterfaceClick:MainMenu(playerid, Text:clickedid)
{
	if (clickedid == INVALID_TEXT_DRAW) {
		SelectTextDraw(playerid, TD_C_GREY);
	}
	return 1;
}

InterfaceCreate:MM_SelectModes(playerid)
{
	static const
		colorList[10] = {
			0x1ddb26FF, 0x1ddb8cFF, 0x1ddbcfFF, 0x1d82dbFF, 0x761ddbFF,
			0xd51ddbFF, 0xdb1d79FF, 0xd8db1dFF, 0xdb591dFF, 0xdb3c1dFF
		};

	new
		Float:initialCoords[2] = {116.0, 123.0};

	new
		tdid = 0,
		modeidTD = 0,
		colorid = 0;

	None_CreatePlayerSelectModeTD(playerid, TD_SelectMode[playerid],
	initialCoords[0], initialCoords[1],
	.base = true,
	.returnMenu = false,
	.modeName = " ",
	.modeColor = -1,
	.startTD = tdid);

	initialCoords[1] += 32.0;

	foreach (new modeid:Modes) {
		if (modeid == MODE_NONE) {
			continue;
		}

		if (!Mode_GetEnableStatus(modeid)) {
			continue;
		}

		PlayerCreatedModeidTD[playerid][modeidTD] = modeid;
		PlayerCreatedModesTD[playerid]++;
		modeidTD++;

		None_CreatePlayerSelectModeTD(playerid, TD_SelectMode[playerid],
		initialCoords[0], initialCoords[1],
		.base = false,
		.returnMenu = false,
		.modeName = Mode_GetShortName(modeid),
		.modeColor = colorList[colorid],
		.startTD = tdid);
	
		initialCoords[1] += 27.0;
		colorid++;

		if (colorid >= 9) {
			colorid = 0;
		}
	}

	None_CreatePlayerSelectModeTD(playerid, TD_SelectMode[playerid],
	initialCoords[0], initialCoords[1],
	.base = false,
	.returnMenu = true,
	.modeName = " ",
	.modeColor = -1,
	.startTD = tdid);

	n_for(i, 6 + (PlayerCreatedModesTD[playerid] * 3)) {
		PlayerTextDrawShow(playerid, TD_SelectMode[playerid][i]);
	}
	return 1;
}

InterfaceClose:MM_SelectModes(playerid)
{
	n_for(i, 6 + (PlayerCreatedModesTD[playerid] * 3)) {
		DestroyPlayerTD(playerid, TD_SelectMode[playerid][i]);
	}

	n_for(i, GMS_MAX_MODES) {
		PlayerCreatedModeidTD[playerid][i] = -1;
	}
	PlayerCreatedModesTD[playerid] = 0;
	return 1;
}

InterfacePlayerClick:MM_SelectModes(playerid, PlayerText:playertextid)
{
	new
		returnMenuTD = 2 + (PlayerCreatedModesTD[playerid] * 3) + 3;

	if (playertextid == TD_SelectMode[playerid][returnMenuTD]) {
		Interface_Close(playerid, Interface:MM_SelectModes);
		Interface_Show(playerid, Interface:MainMenu);
		return 1;
	}

	for(new i = 5, b = 0; b < PlayerCreatedModesTD[playerid]; i += 3, b++) {
		if (playertextid == TD_SelectMode[playerid][i]) {
			new
				modeid = PlayerCreatedModeidTD[playerid][b];

			switch (modeid) {
				case MODE_ROOM: {
					if (!Mode_GetEnableStatus(MODE_ROOM)) {
						return 1;
					}

					Interface_Close(playerid, Interface:MM_SelectModes);

					Dialog_Show(playerid, Dialog:Room_SelectingTab);
					CheckPlayerDinaHint(playerid, 16);
					return 1;
				}
				default: {
					SetPVarInt(playerid, "SelectedMode", modeid);
					Dialog_Show(playerid, Dialog:Mode_SelectPlaySession);
					return 1;
				}
			}
		}
	}
	return 1;
}

InterfaceClick:MM_SelectModes(playerid, Text:clickedid)
{
	if (clickedid == INVALID_TEXT_DRAW) {
		SelectTextDraw(playerid, TD_C_GREY);
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

stock None_OnGameModeInit()
{
	// Reset sessions
	n_for(sessionid, GMS_MAX_SESSIONS) {
		ResetSessionData(sessionid);
	}

	// Initialization
	Mode_Add(MODE_NONE, "None", "None",
		.enableStatus = true,
		.maxSessions = 1,
		.sessionMaxPlayers = GMS_MAX_SESSION_SLOTS,
		.changeEnableStatus = false,
		.changeSession = false,
		.changeSessionLocation = false);

	Mode_SetInfo(MODE_NONE, "-");

	// Sessions
	Mode_CreateFirstSessions(MODE_NONE);
	return 1;
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);
	ResetPlayerTDs(playerid);

	#if defined None_OnPlayerConnect
		return None_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>-----------------<|
 * |   OnPlayerSpawn   |
 * |>-----------------<|
 */

stock None_OnPlayerSpawn(playerid)
{
	SetPlayerCameraMainMenu(playerid);

	if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
		if (GetPlayerSpecatingPlayers(GetPlayerSpectating(playerid)) > 0) {
			AddPlayerSpecatingPlayer(GetPlayerSpectating(playerid), playerid);
		}
	}

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		RemovePlayerDead(playerid);
		WC_PlayerDeathRespawn(playerid);
		return 1;
	}

	SpawnPlayerLoaded(playerid);
	SetPlayerAnimation(playerid);
	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
 * |>-----------------<|
 * |   OnPlayerDeath   |
 * |>-----------------<|
 */

stock None_OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	#pragma unused killerid, reason

	SettingsPlayerSpawn(playerid);
	return 1;
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
#define OnPlayerConnect None_OnPlayerConnect
#if defined None_OnPlayerConnect
	forward None_OnPlayerConnect(playerid);
#endif