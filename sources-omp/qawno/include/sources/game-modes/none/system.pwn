/*

	About: None core system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerSpawn(playerid)
		OnPlayerDeath(playerid, killerid, reason)
		
		StartPlayerCameraMainMenu2(playerid)
		None_UpdatePlayer(playerid) 
	Stock:
		EnterPlayerMainMenu(playerid)
		ShowPlayerMainMenu(playerid)
		DestroyPlayerTDInMainMenu(playerid, bool:work = false)
		StartPlayerCameraMainMenu(playerid)
		ShowPlayerSelectModes(playerid)
		None_CreateLocationPlayer(playerid, session_id, set)
		None_DestroyLocationPlayer(playerid, reset)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	MainMenu
	MM_SelectModes
------------------------------------------------------------------------------*/

#if defined _INC_NONE_CORE_SYSTEM
	#endinput
#endif
#define _INC_NONE_CORE_SYSTEM

/*

	* Vars *

*/

static
	PlayerCameraMainMenu[MAX_PLAYERS];

static
	PlayerText:TD_MainMenu[MAX_PLAYERS][30],
	PlayerText:TD_MMConnect[MAX_PLAYERS][15];

static
	MainMenu_Actors[10];

/*

	* Functions *

*/

stock EnterPlayerMainMenu(playerid)
{
	// Interfaces
	Interface_Show(playerid, Interface:MainMenu);
	SelectTextDraw(playerid, 0xAFAFAFAA);

	if(GetPlayerLogged(playerid)) {
		SetPlayerLogged(playerid, false);

		if(Adm_GetPlayerLevel(playerid) > 0) 
			Iter_Add(admin_players, playerid);
		
		if(GetPlayerPremium(playerid))
			CheckPremiumAccount(playerid);
	}

	if(GetPlayerCarabSpectating(playerid))
		SetPlayerCarabSpectating(playerid, false);

	PlayerPlaySoundEx(playerid, 0, 0.0, 0.0, 0.0);
	Dina_CheckPlayerHint(playerid, 3, 1);
	return 1;
}

stock ShowPlayerMainMenu(playerid)
{
	Mode_SetPlayer(playerid, MODE_NONE);

	PreloadAllAnimLibs(playerid);
	StartPlayerCameraMainMenu(playerid);

	SetPlayerClickTD(playerid, true);
	SetPlayerCarabSpectating(playerid, true);
	SetPlayerDamage(playerid, false);
	SetPlayerBusy(playerid, MAIN_MENU);

	Mode_SetPlayerVirtualWorld(playerid, MODE_NONE, 0);
	Mode_SetPlayerInterior(playerid, MODE_NONE, 0);
	Mode_SetPlayerWeather(playerid, MODE_NONE, 0);

	SetPlayerColorEx(playerid, 0xCCCCCC00);

	if(GetPlayerLogged(playerid)) {
		if(DailyB_CheckPlayer(playerid))
			return 1;
	}

	EnterPlayerMainMenu(playerid);
	return 1;
}

stock DestroyPlayerTDInMainMenu(playerid, bool:work = false)
{
	if(Interface_IsOpen(playerid, Interface:Inventory))
		Interface_Close(playerid, Interface:Inventory);

	if(Interface_IsOpen(playerid, Interface:TradingPlatform))
		Interface_Close(playerid, Interface:TradingPlatform);

	if(Interface_IsOpen(playerid, Interface:SecondPassword))
		Interface_Close(playerid, Interface:SecondPassword);

	if(Interface_IsOpen(playerid, Interface:MainMenu))
		Interface_Close(playerid, Interface:MainMenu);

	if(Interface_IsOpen(playerid, Interface:MM_SelectModes))
		Interface_Close(playerid, Interface:MM_SelectModes);

	if(Interface_IsOpen(playerid, Interface:Room_Lobby)) {
		if(!work)
			Room_ExitPlayer(playerid, GetPVarInt(playerid, "Room_World_PVar"), true);
	}

	ClosePlayerDialog(playerid);
	return 1;
}

stock StartPlayerCameraMainMenu(playerid)
{
	KillTimer(PlayerCameraMainMenu[playerid]);
	
	InterpolateCameraPos(playerid, 3375.232910, 2321.071777, 19.390857, 3375.232910, 2321.071777, 19.390857, 1000);
	InterpolateCameraLookAt(playerid, 3380.231689, 2321.063476, 19.279409, 3380.231689, 2321.063476, 19.279409, 1000);

	PlayerCameraMainMenu[playerid] = SetPlayerTimer(playerid, "StartPlayerCameraMainMenu2", 500, false);
	return 1;
}

publics StartPlayerCameraMainMenu2(playerid)
{
	SetPlayerCameraPos(playerid, 3375.232910, 2321.071777, 19.390857);
	SetPlayerCameraLookAt(playerid, 3380.231689, 2321.063476, 19.279409);
	return 1;
}

stock ShowPlayerSelectModes(playerid)
{
	n_for(i, sizeof(TD_MMConnect[]))
		PlayerTextDrawShow(playerid, TD_MMConnect[playerid][i]);

	return 1;
}

publics None_UpdatePlayer(playerid)
{
	UpdateSpectatingStatus(playerid, GetPlayerSpectating(playerid));
	UpdatePlayerNewRank(playerid);

	SecPass_UpdatePlayerTimer(playerid);

	SetPlayerSecondTime(playerid);
	UpdatePlayerTime(playerid);
	return 1;
}

stock None_CreateLocationPlayer(playerid, session_id, set)
{
	if(set)
		Mode_EnteringPlayer(playerid, MODE_NONE, session_id);

	if(!GetPlayerLogged(playerid)) {
		if(Adm_GetPlayerSpectating(playerid))
			SetPlayerBusy(playerid, NONE);
		else {
			SpecPl(playerid, true);
			ShowPlayerMainMenu(playerid);
		}
	}

	Mode_SetPlayerWeather(playerid, MODE_NONE, session_id);
	Mode_SetPlayerTimer(playerid, MODE_NONE);
	return 1;
}

stock None_DestroyLocationPlayer(playerid, reset)
{
	if(Adm_GetPlayerSpectating(playerid)) {
		if(GetPlayerBusy(playerid) == MAIN_MENU) {
			DestroyPlayerTDInMainMenu(playerid);
		}
	}
	else {
		SetPlayerClickTD(playerid, false);
		DestroyPlayerTDInMainMenu(playerid);
	}

	if(reset)
		Mode_LeavingPlayer(playerid);

	Mode_KillPlayerTimer(playerid, MODE_NONE);
	return 1;
}

static SettingsPlayerSpawn(playerid)
{
	new 
		Float:X, Float:Y, Float:Z,
		skin_id = Mode_GetPlayerSkin(playerid, MODE_NONE);

	GetPlayerPos(playerid, X, Y, Z);

	Mode_SetPlayerVirtualWorld(playerid, MODE_NONE, 0);
	Mode_SetPlayerInterior(playerid, MODE_NONE, 0);
		
	SetSpawnInfoEx(playerid, skin_id, X, Y, Z + 0.3, 0.0);
	return 1;
}

/*

	* TextDraws *

*/

static ShowPlayerTDMainMenu(playerid)
{
	// Задний фон
	TD_MainMenu[playerid][0] = CreatePlayerTextDraw(playerid, 116.0000, 123.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][0], -1701143809);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][0], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][0], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][0], 89.0000, 25.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][0], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][1] = CreatePlayerTextDraw(playerid, 117.0000, 124.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][1], -468380161);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][1], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][1], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][1], 87.0000, 23.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][2] = CreatePlayerTextDraw(playerid, 160.0000, 126.0000, "Главное_меню");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][2], 0.2338, 1.8530);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][2], 0.0000, 86.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][2], 48);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][2], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][2], 1);

	// Задний фон
	TD_MainMenu[playerid][3] = CreatePlayerTextDraw(playerid, 116.0000, 155.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][3], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][3], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][3], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][3], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][4] = CreatePlayerTextDraw(playerid, 117.0000, 156.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][4], 0x911111FF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][4], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][4], true);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][4], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][4], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][4], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][5] = CreatePlayerTextDraw(playerid, 160.0000, 158.0000, "Играть");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][5], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][5], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][5], -218959617);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][5], 0x00000020);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][5], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][5], true);

	// Задний фон
	TD_MainMenu[playerid][6] = CreatePlayerTextDraw(playerid, 116.0000, 182.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][6], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][6], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][6], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][6], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][6], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][6], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][7] = CreatePlayerTextDraw(playerid, 117.0000, 183.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][7], 0x911111FF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][7], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][7], true);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][7], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][7], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][7], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][8] = CreatePlayerTextDraw(playerid, 160.0000, 185.0000, "Статистика");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][8], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][8], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][8], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][8], 0x00000020);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][8], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][8], true);

	// Задний фон
	TD_MainMenu[playerid][9] = CreatePlayerTextDraw(playerid, 116.0000, 209.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][9], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][9], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][9], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][9], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][9], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][9], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][9], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][10] = CreatePlayerTextDraw(playerid, 117.0000, 210.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][10], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][10], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][10], 0x911111FF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][10], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][10], true);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][10], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][10], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][10], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][11] = CreatePlayerTextDraw(playerid, 160.0000, 212.0000, "Инвентарь");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][11], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][11], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][11], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][11], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][11], 0x00000020);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][11], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][11], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][11], true);

	 // Задний фон
	TD_MainMenu[playerid][12] = CreatePlayerTextDraw(playerid, 116.0000, 236.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][12], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][12], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][12], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][12], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][12], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][12], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][12], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][12], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][13] = CreatePlayerTextDraw(playerid, 117.0000, 237.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][13], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][13], 0x8214a3FF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][13], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][13], true);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][13], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][13], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][13], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][14] = CreatePlayerTextDraw(playerid, 160.0000, 239.0000, "Торг._площадка");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][14], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][14], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][14], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][14], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][14], 0x00000020);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][14], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][14], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][14], true);

	// Задний фон
	TD_MainMenu[playerid][15] = CreatePlayerTextDraw(playerid, 116.0000, 263.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][15], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][15], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][15], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][15], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][15], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][15], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][15], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][15], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][16] = CreatePlayerTextDraw(playerid, 117.0000, 264.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][16], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][16], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][16], 0x8214a3FF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][16], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][16], true);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][16], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][16], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][16], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][17] = CreatePlayerTextDraw(playerid, 160.0000, 266.0000, "Помощь");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][17], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][17], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][17], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][17], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][17], 0x00000020);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][17], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][17], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][17], true);

	// Задний фон
	TD_MainMenu[playerid][18] = CreatePlayerTextDraw(playerid, 116.0000, 290.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][18], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][18], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][18], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][18], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][18], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][18], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][18], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][18], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][19] = CreatePlayerTextDraw(playerid, 117.0000, 291.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][19], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][19], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][19], 0x8214a3FF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][19], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][19], true);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][19], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][19], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][19], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][20] = CreatePlayerTextDraw(playerid, 160.0000, 293.0000, "Донат");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][20], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][20], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][20], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][20], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][20], 0x00000020);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][20], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][20], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][20], true);

	// Задний фон
	TD_MainMenu[playerid][21] = CreatePlayerTextDraw(playerid, 116.0000, 317.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][21], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][21], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][21], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][21], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][21], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][21], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][21], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][21], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][22] = CreatePlayerTextDraw(playerid, 117.0000, 318.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][22], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][22], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][22], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][22], 0x118da8FF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][22], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][22], true);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][22], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][22], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][22], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][23] = CreatePlayerTextDraw(playerid, 160.0000, 320.0000, "Опции");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][23], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][23], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][23], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][23], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][23], 0x00000020);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][23], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][23], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][23], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][23], true);

	// Задний фон
	TD_MainMenu[playerid][24] = CreatePlayerTextDraw(playerid, 116.0000, 344.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][24], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][24], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][24], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][24], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][24], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][24], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][24], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][24], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][24], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][25] = CreatePlayerTextDraw(playerid, 117.0000, 345.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][25], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][25], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][25], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][25], 0x118da8FF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][25], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][25], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][25], true);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][25], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][25], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][25], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][26] = CreatePlayerTextDraw(playerid, 160.0000, 347.0000, "Безопасность");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][26], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][26], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][26], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][26], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][26], 0x00000020);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][26], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][26], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][26], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][26], true);

	// Задний фон
	TD_MainMenu[playerid][27] = CreatePlayerTextDraw(playerid, 116.0000, 371.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][27], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][27], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][27], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][27], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][27], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][27], 0);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][27], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][27], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][27], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MainMenu[playerid][28] = CreatePlayerTextDraw(playerid, 117.0000, 372.0000, "_");
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][28], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][28], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][28], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][28], 0x118da8FF);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][28], false);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][28], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][28], true);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][28], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MainMenu[playerid][28], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MainMenu[playerid][28], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MainMenu[playerid][29] = CreatePlayerTextDraw(playerid, 160.0000, 374.0000, "Промо-код");
	PlayerTextDrawLetterSize(playerid, TD_MainMenu[playerid][29], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MainMenu[playerid][29], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MainMenu[playerid][29], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MainMenu[playerid][29], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MainMenu[playerid][29], 0x00000020);
	PlayerTextDrawFont(playerid, TD_MainMenu[playerid][29], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MainMenu[playerid][29], true);
	PlayerTextDrawSetShadow(playerid, TD_MainMenu[playerid][29], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MainMenu[playerid][29], true);
	return 1;
}

stock ShowTDMMConnect(playerid)
{
	// Задний фон
	TD_MMConnect[playerid][0] = CreatePlayerTextDraw(playerid, 116.0000, 123.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][0], -1701143809);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][0], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][0], 0);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][0], 89.0000, 25.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][0], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MMConnect[playerid][1] = CreatePlayerTextDraw(playerid, 117.0000, 124.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][1], -468380161);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][1], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][1], 0);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][1], 87.0000, 23.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MMConnect[playerid][2] = CreatePlayerTextDraw(playerid, 160.0000, 126.0000, "Играть");
	PlayerTextDrawLetterSize(playerid, TD_MMConnect[playerid][2], 0.2337, 1.8530);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][2], 0.0000, 85.0000);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][2], 48);
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][2], true);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][2], 1);

	// Задний фон
	TD_MMConnect[playerid][3] = CreatePlayerTextDraw(playerid, 116.0000, 155.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][3], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][3], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][3], 0);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][3], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MMConnect[playerid][4] = CreatePlayerTextDraw(playerid, 117.0000, 156.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][4], 0x31cf23FF);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][4], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MMConnect[playerid][4], true);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][4], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][4], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][4], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MMConnect[playerid][5] = CreatePlayerTextDraw(playerid, 160.0000, 158.0000, "TDM");
	PlayerTextDrawLetterSize(playerid, TD_MMConnect[playerid][5], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][5], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][5], -218959617);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][5], 80);
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][5], true);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MMConnect[playerid][5], true);

	// Задний фон
	TD_MMConnect[playerid][6] = CreatePlayerTextDraw(playerid, 116.0000, 182.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][6], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][6], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][6], 0);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][6], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][6], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][6], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MMConnect[playerid][7] = CreatePlayerTextDraw(playerid, 117.0000, 183.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][7], 0xcf9323FF);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][7], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MMConnect[playerid][7], true);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][7], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][7], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][7], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MMConnect[playerid][8] = CreatePlayerTextDraw(playerid, 160.0000, 185.0000, "DM");
	PlayerTextDrawLetterSize(playerid, TD_MMConnect[playerid][8], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][8], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][8], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][8], 80);
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][8], true);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MMConnect[playerid][8], true);

	// Задний фон
	TD_MMConnect[playerid][9] = CreatePlayerTextDraw(playerid, 116.0000, 209.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][9], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][9], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][9], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][9], 0);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][9], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][9], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][9], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MMConnect[playerid][10] = CreatePlayerTextDraw(playerid, 117.0000, 210.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][10], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][10], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][10], 0x23cfcfFF);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][10], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MMConnect[playerid][10], true);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][10], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][10], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][10], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MMConnect[playerid][11] = CreatePlayerTextDraw(playerid, 160.0000, 212.0000, "Комната");
	PlayerTextDrawLetterSize(playerid, TD_MMConnect[playerid][11], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][11], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][11], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][11], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][11], 80);
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][11], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][11], true);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MMConnect[playerid][11], true);

	// Задний фон
	TD_MMConnect[playerid][12] = CreatePlayerTextDraw(playerid, 116.0000, 236.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][12], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][12], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][12], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][12], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][12], 0);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][12], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][12], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][12], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	TD_MMConnect[playerid][13] = CreatePlayerTextDraw(playerid, 117.0000, 237.0000, "_");
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][13], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][13], 0xcf2323FF);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][13], false);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MMConnect[playerid][13], true);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][13], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_MMConnect[playerid][13], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_MMConnect[playerid][13], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_MMConnect[playerid][14] = CreatePlayerTextDraw(playerid, 160.0000, 239.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, TD_MMConnect[playerid][14], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, TD_MMConnect[playerid][14], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_MMConnect[playerid][14], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_MMConnect[playerid][14], -353703681);
	PlayerTextDrawBackgroundColour(playerid, TD_MMConnect[playerid][14], 80);
	PlayerTextDrawFont(playerid, TD_MMConnect[playerid][14], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_MMConnect[playerid][14], true);
	PlayerTextDrawSetShadow(playerid, TD_MMConnect[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, TD_MMConnect[playerid][14], true);
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerData(playerid)
{
	PlayerCameraMainMenu[playerid] = 0;
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(i, sizeof(TD_MainMenu[]))
		TD_MainMenu[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_MMConnect[]))
		TD_MMConnect[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

/*

	* Interfaces *

*/

InterfaceCreate:MainMenu(playerid)
{
	ShowPlayerTDMainMenu(playerid);

	n_for(i, sizeof(TD_MainMenu[]))
		PlayerTextDrawShow(playerid, TD_MainMenu[playerid][i]);

	return 1;
}

InterfaceClose:MainMenu(playerid)
{
	n_for(i, sizeof(TD_MainMenu[]))
		DestroyPlayerTD(playerid, TD_MainMenu[playerid][i]);

	return 1;
}

InterfacePlayerClick:MainMenu(playerid, PlayerText:playertextid)
{
	if(playertextid == TD_MainMenu[playerid][5]) {
		Interface_Close(playerid, Interface:MainMenu);
		Interface_Show(playerid, Interface:MM_SelectModes);

		Dina_CheckPlayerHint(playerid, 6);
		return 1;
	}
	else if(playertextid == TD_MainMenu[playerid][8])
		return Dialog_Show(playerid, Dialog:ChoosePlayerStats);

	else if(playertextid == TD_MainMenu[playerid][11]) {
		Interface_Close(playerid, Interface:MainMenu);
		Interface_Show(playerid, Interface:Inventory);

		Dina_CheckPlayerHint(playerid, 4);
		return 1;
	}
	else if(playertextid == TD_MainMenu[playerid][14]) {
		Interface_Close(playerid, Interface:MainMenu);
		Interface_Show(playerid, Interface:TradingPlatform);

		Dina_CheckPlayerHint(playerid, 5);
		return 1;
	}
	else if(playertextid == TD_MainMenu[playerid][17])
		return Dialog_Show(playerid, Dialog:Help);

	else if(playertextid == TD_MainMenu[playerid][20])
		return Dialog_Show(playerid, Dialog:PlayerDonate);

	else if(playertextid == TD_MainMenu[playerid][23])
		return Dialog_Show(playerid, Dialog:PlayerOptions);

	else if(playertextid == TD_MainMenu[playerid][26])
		return Dialog_Show(playerid, Dialog:PlayerChangeSecurity);

	else if(playertextid == TD_MainMenu[playerid][29]) {
		if(GetPlayerRank(playerid) < 10) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Для активации промо-кода требуется 10 ранг!");
			if(GetPlayerBusy(playerid) != MAIN_MENU) 
				Dialog_Show(playerid, Dialog:PlayerMenu);
			
			return 1;
		}
		if(pInfo[playerid][pPromoCode] == 1) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы уже активировали промо-код!");
			if(GetPlayerBusy(playerid) != MAIN_MENU) 
				Dialog_Show(playerid, Dialog:PlayerMenu);
			
			return 1;
		}
		Dialog_Show(playerid, Dialog:PlayerPromoCode);
		return 1;
	}
	return 1;
}

InterfaceClick:MainMenu(playerid, Text:clickedid)
{
	if(clickedid == INVALID_TEXT_DRAW)
		SelectTextDraw(playerid, 0xAFAFAFAA);

	return 1;
}

InterfaceCreate:MM_SelectModes(playerid)
{
	ShowTDMMConnect(playerid);

	n_for(i, sizeof(TD_MMConnect[]))
		PlayerTextDrawShow(playerid, TD_MMConnect[playerid][i]);

	return 1;
}

InterfaceClose:MM_SelectModes(playerid)
{
	n_for(i, sizeof(TD_MMConnect[]))
		DestroyPlayerTD(playerid, TD_MMConnect[playerid][i]);

	return 1;
}

InterfacePlayerClick:MM_SelectModes(playerid, PlayerText:playertextid)
{
	if(playertextid == TD_MMConnect[playerid][5])
		Dialog_Show(playerid, Dialog:TDM_SelectPlaySession);

	else if(playertextid == TD_MMConnect[playerid][8])
		Dialog_Show(playerid, Dialog:DM_SelectPlaySession);

	else if(playertextid == TD_MMConnect[playerid][11]) {
		Interface_Close(playerid, Interface:MM_SelectModes);

		Dialog_Show(playerid, Dialog:Room_SelectingTab);
		Dina_CheckPlayerHint(playerid, 16);
	}
	else if(playertextid == TD_MMConnect[playerid][14]) {
		Interface_Close(playerid, Interface:MM_SelectModes);
		Interface_Show(playerid, Interface:MainMenu);
	}
	return 1;
}

InterfaceClick:MM_SelectModes(playerid, Text:clickedid)
{
	if(clickedid == INVALID_TEXT_DRAW)
		SelectTextDraw(playerid, 0xAFAFAFAA);

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
	// Главное меню
	CreateDynamicObject(10771, 3549.93433, 2295.48657, 5.58360,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(10772, 3551.35376, 2295.33740, 17.39470,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(10770, 3553.15405, 2287.96753, 38.53816,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11237, 3550.29004, 2287.94287, 38.24121,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11146, 3540.89673, 2296.05493, 12.43900,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11145, 3487.01123, 2295.56470, 4.41330,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(11149, 3543.81348, 2290.36157, 12.07200,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3884, 3441.86328, 2306.72363, 16.88660,   0.00000, 0.00000, 26.00000);
	CreateDynamicObject(18647, 3440.32349, 2308.06030, 12.31760,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18647, 3440.32129, 2282.87549, 12.32960,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18649, 3566.98560, 2287.89453, 47.90260,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(8874, 3574.05200, 2298.77710, 22.22697,   0.00000, 0.00000, 156.00000);
	CreateDynamicObject(8874, 3574.51831, 2275.95483, 22.69646,   0.00000, 0.00000, -33.00000);
	CreateDynamicObject(8874, 3446.24585, 2288.09985, 3.93471,   0.00000, 0.00000, 149.00000);
	CreateDynamicObject(8874, 3446.24585, 2301.63916, 3.93470,   0.00000, 0.00000, -33.00000);
	CreateDynamicObject(19294, 3462.13672, 2285.72290, 17.36524,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19294, 3462.03125, 2305.28540, 17.36569,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(18647, 3493.14453, 2304.88086, 17.39010,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3787, 3445.28076, 2307.11743, 17.92180,   0.00000, 0.00000, 16.00000);
	CreateDynamicObject(3791, 3446.37744, 2284.23779, 17.82670,   0.00000, 0.00000, -76.00000);
	CreateDynamicObject(3791, 3449.07349, 2284.60596, 17.82670,   0.00000, 0.00000, -164.00000);
	CreateDynamicObject(2969, 3448.49316, 2284.34009, 18.38650,   0.00000, 0.00000, -280.00000);
	CreateDynamicObject(2969, 3449.63281, 2284.89404, 18.38650,   0.00000, 0.00000, -216.00000);
	CreateDynamicObject(3789, 3464.27539, 2284.05933, 17.67240,   0.00000, 0.00000, -40.00000);
	CreateDynamicObject(3789, 3467.95142, 2284.64185, 17.67240,   0.00000, 0.00000, 40.00000);
	CreateDynamicObject(964, 3451.85400, 2306.01343, 17.31620,   0.00000, 0.00000, -135.00000);
	CreateDynamicObject(964, 3453.69531, 2306.02197, 17.31620,   0.00000, 0.00000, -62.00000);
	CreateDynamicObject(964, 3449.75366, 2306.23877, 17.31620,   0.00000, 0.00000, -207.00000);
	CreateDynamicObject(3066, 3468.95776, 2306.39575, 18.20561,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(3066, 3477.21094, 2284.53955, 18.15568,   0.00000, 0.00000, 90.00000);
	CreateDynamicObject(931, 3537.68091, 2294.50830, 18.36262,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(3789, 3510.32178, 2305.93481, 17.68780,   0.00000, 0.00000, -33.00000);
	CreateDynamicObject(3789, 3513.90894, 2306.31274, 17.68780,   0.00000, 0.00000, -69.00000);
	CreateDynamicObject(3791, 3517.62793, 2306.63184, 17.80560,   0.00000, 0.00000, -164.00000);
	CreateDynamicObject(19294, 3440.42505, 2310.86133, 15.72336,   0.00000, 0.00000, 0.00000);
	CreateDynamicObject(19294, 3440.44531, 2280.11841, 15.72403,   0.00000, 0.00000, 0.00000);

	// Транспорт
	AddStaticVehicleEx(476, 3594.8989, 2294.4805, 19.0463, -40.0000, 107, -1, 100);
	AddStaticVehicleEx(476, 3607.5903, 2293.4414, 19.0463, -40.0000, 107, -1, 100);
	AddStaticVehicleEx(476, 3620.3574, 2292.3728, 19.0463, -40.0000, 107, -1, 100);
	AddStaticVehicleEx(548, 3491.6301, 2287.7439, 20.0765, 90.0000, 107, -1, 100);
	AddStaticVehicleEx(473, 3453.0857, 2286.1794, 0.1750, 90.0000, 107, -1, 100);

	// Актёры
	MainMenu_Actors[0] = CreateActor(287, 3456.4619, 2283.7263, 18.3727 + 1.0, 175.5436); // Курит
	MainMenu_Actors[1] = CreateActor(287, 3448.7393, 2283.1563, 18.3727 + 1.0, 89.4179); // Сидит в ящиках
	MainMenu_Actors[2] = CreateActor(191, 3506.8464, 2305.5649, 18.3745 + 1.0, 4.4027); // Общается 1
	MainMenu_Actors[3] = CreateActor(287, 3506.7939, 2306.7275, 18.3745 + 1.0, 177.9065); // Общается 2
	MainMenu_Actors[4] = CreateActor(287, 3486.8884, 2289.9583, 18.3677 + 1.0, 203.2894); // Стоит рядом с вертолётом
	MainMenu_Actors[5] = CreateActor(191, 3450.3262, 2283.6790, 3.1969 + 1.0, 0.7938); // Лежит внизу корабля

	ApplyActorAnimation(MainMenu_Actors[0], "SMOKING", "M_smkstnd_loop", 4.1, true, false, false, false, 0);
	ApplyActorAnimation(MainMenu_Actors[1], "BD_FIRE", "M_smklean_loop", 4.1, true, false, false, false, 0);
	ApplyActorAnimation(MainMenu_Actors[2], "PED", "IDLE_CHAT", 4.1, true, false, false, false, 0);
	ApplyActorAnimation(MainMenu_Actors[3], "MISC", "Idle_Chat_02", 4.1, true, false, false, false, 0);
	ApplyActorAnimation(MainMenu_Actors[4], "RYDER", "RYD_BECKON_01", 4.1, true, false, false, false, 0);
	ApplyActorAnimation(MainMenu_Actors[5], "BEACH", "Lay_Bac_Loop", 4.1, true, false, false, false, 0);

	#if defined ModeNone_OnGameModeInit
		return ModeNone_OnGameModeInit();
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

	#if defined None_OnPlayerConnect
		return None_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerSpawn
*/

stock None_OnPlayerSpawn(playerid)
{
	if(GetPlayerSpectating(playerid) > -1) {
		if(Iter_Count(spec_dead_playerid[GetPlayerSpectating(playerid)]) > 0)
			Iter_Remove(spec_dead_playerid[GetPlayerSpectating(playerid)], playerid);
	}

	if(GetPlayerDead(playerid)) {
		RemovePlayerDead(playerid);

		SpecPl(playerid, true);
		SpecPl(playerid, false);
		return 1;
	}

	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
	OnPlayerDeath
*/

stock None_OnPlayerDeath(playerid, killerid, reason)
{
	#pragma unused killerid, reason

	SettingsPlayerSpawn(playerid);
	return 1;
}

/*
	ALS
*/

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit ModeNone_OnGameModeInit
#if defined ModeNone_OnGameModeInit
	forward ModeNone_OnGameModeInit();
#endif


#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect None_OnPlayerConnect
#if defined None_OnPlayerConnect
	forward None_OnPlayerConnect(playerid);
#endif
