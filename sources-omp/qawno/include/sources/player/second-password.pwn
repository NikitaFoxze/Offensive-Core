/*

	About: Second-password system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnPlayerConnect(playerid)
	Stock:
		SecPass_UpdatePlayerTimer(playerid)

Enums:
	-
Commands:
	-
Dialogs:
	PlayerSecondPassword
Interfaces:
	SecondPassword
------------------------------------------------------------------------------*/

#if defined _INC_SECOND_PASSWORD_SYSTEM
	#endinput
#endif
#define _INC_SECOND_PASSWORD_SYSTEM

/*

	* Vars *

*/

static
	PlayerText:TD_SecPass[MAX_PLAYERS][41];

/*

	* Functions *

*/

stock SecPass_UpdatePlayerTimer(playerid)
{
	if(!Interface_IsOpen(playerid, Interface:SecondPassword))
		return 1;

	SetPVarInt(playerid, "TimerSecPass_PVar", GetPVarInt(playerid, "TimerSecPass_PVar") - 1);

	if(GetPVarInt(playerid, "TimerSecPass_PVar") < 1) {
		SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Время для второго пароля закончилось.");
		KickEx(playerid);
	}
	else {
		static
			string[25];

		string[0] = EOS;

		f(string, "Таймер:_00:%02d", GetPVarInt(playerid, "TimerSecPass_PVar"));
		PlayerTextDrawSetString(playerid, TD_SecPass[playerid][34], string);
	}
	return 1;
}

static ShowPlayerTDSecondPass(playerid)
{
	// Основной задний фон
	TD_SecPass[playerid][0] = CreatePlayerTextDraw(playerid, 267.000000, 168.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][0], 0.000000, 14.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][0], 362.000000, 0.000000);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][0], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][0], 0x212121FF);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][0], 255);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][0], true);

	// Задний фон цифр (введенных)
	TD_SecPass[playerid][1] = CreatePlayerTextDraw(playerid, 268.000000, 168.800000, "_");
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][1], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][1], 361.000000, 0.000000);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][1], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][1], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][1], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][1], 0x2b2b2bFF);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][1], true);

	// Задний фон 1 цифры
	TD_SecPass[playerid][2] = CreatePlayerTextDraw(playerid, 269.000000, 205.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][2], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][2], 291.000000, 0.000000);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][2], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][2], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][2], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][2], -858993494);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][2], 255);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][2], true);

	// Задний фон 2 цифры
	TD_SecPass[playerid][3] = CreatePlayerTextDraw(playerid, 303.000000, 205.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][3], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][3], 325.600000, 0.000000);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][3], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][3], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][3], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][3], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][3], -858993494);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][3], 255);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][3], true);

	// Задний фон 3 цифры
	TD_SecPass[playerid][4] = CreatePlayerTextDraw(playerid, 337.000000, 205.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][4], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][4], 360.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][4], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][4], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][4], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][4], -858993494);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][4], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][4], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][4], true);

	// Задний фон 4 цифры
	TD_SecPass[playerid][5] = CreatePlayerTextDraw(playerid, 269.000000, 239.00000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][5], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][5], 291.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][5], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][5], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][5], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][5], -858993494);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][5], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][5], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][5], true);

	// Задний фон 5 цифры
	TD_SecPass[playerid][6] = CreatePlayerTextDraw(playerid, 303.000000, 239.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][6], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][6], 325.600000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][6], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][6], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][6], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][6], -858993494);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][6], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][6], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][6], true);

	// Задний фон 6 цифры
	TD_SecPass[playerid][7] = CreatePlayerTextDraw(playerid, 337.000000, 239.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][7], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][7], 360.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][7], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][7], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][7], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][7], -858993494);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][7], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][7], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][7], true);

	// Задний фон 7 цифры
	TD_SecPass[playerid][8] = CreatePlayerTextDraw(playerid, 269.000000, 274.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][8], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][8], 291.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][8], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][8], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][8], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][8], -858993494);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][8], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][8], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][8], true);

	// Задний фон 8 цифры
	TD_SecPass[playerid][9] = CreatePlayerTextDraw(playerid, 303.000000, 274.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][9], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][9], 325.600000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][9], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][9], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][9], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][9], -858993494);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][9], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][9], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][9], true);

	// Задний фон 9 цифры
	TD_SecPass[playerid][10] = CreatePlayerTextDraw(playerid, 337.000000, 274.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][10], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][10], 360.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][10], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][10], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][10], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][10], 0xb0b0b0FF);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][10], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][10], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][10], true);

	// Черта делящая верх и низ
	TD_SecPass[playerid][11] = CreatePlayerTextDraw(playerid, 267.000000, 196.200000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][11], 0.000000, -0.000000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][11], 362.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][11], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][11], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][11], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][11], 255);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][11], 0x737373FF);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][11], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][11], true);

	// Кликабельный фон 1 цифры
	TD_SecPass[playerid][12] = CreatePlayerTextDraw(playerid, 267.600000, 203.500000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][12], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][12], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][12], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][12], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][12], true);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][12], false);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][12], 24.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][12], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][12], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 2 цифры
	TD_SecPass[playerid][13] = CreatePlayerTextDraw(playerid, 301.600000, 203.500000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][13], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][13], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][13], true);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][13], false);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][13], 25.300000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][13], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][13], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 3 цифры
	TD_SecPass[playerid][14] = CreatePlayerTextDraw(playerid, 335.600000, 203.500000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][14], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][14], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][14], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][14], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][14], true);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][14], false);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][14], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][14], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][14], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 4 цифры
	TD_SecPass[playerid][15] = CreatePlayerTextDraw(playerid, 267.600000, 237.500000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][15], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][15], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][15], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][15], true);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][15], false);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][15], 24.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][15], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][15], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 5 цифры
	TD_SecPass[playerid][16] = CreatePlayerTextDraw(playerid, 301.600000, 237.500000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][16], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][16], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][16], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][16], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][16], true);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][16], false);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][16], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][16], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][16], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 6 цифры
	TD_SecPass[playerid][17] = CreatePlayerTextDraw(playerid, 335.600000, 237.500000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][17], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][17], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][17], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][17], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][17], true);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][17], false);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][17], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][17], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][17], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 7 цифры
	TD_SecPass[playerid][18] = CreatePlayerTextDraw(playerid, 267.600000, 272.400000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][18], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][18], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][18], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][18], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][18], true);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][18], false);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][18], 24.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][18], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][18], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 8 цифры
	TD_SecPass[playerid][19] = CreatePlayerTextDraw(playerid, 301.500000, 272.400000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][19], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][19], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][19], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][19], true);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][19], false);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][19], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][19], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][19], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 9 цифры
	TD_SecPass[playerid][20] = CreatePlayerTextDraw(playerid, 335.600000, 272.400000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][20], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][20], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][20], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][20], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][20], true);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][20], false);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][20], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][20], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][20], 0.000000, 0.000000, 0.000000, 1000.000000);

	TD_SecPass[playerid][21] = CreatePlayerTextDraw(playerid, 277.000000, 207.000000, "1");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][21], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][21], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][21], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][21], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][21], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][21], true);

	TD_SecPass[playerid][22] = CreatePlayerTextDraw(playerid, 309.300000, 207.000000, "2");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][22], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][22], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][22], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][22], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][22], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][22], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][22], true);

	TD_SecPass[playerid][23] = CreatePlayerTextDraw(playerid, 344.000000, 207.000000, "3");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][23], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][23], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][23], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][23], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][23], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][23], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][23], true);

	TD_SecPass[playerid][24] = CreatePlayerTextDraw(playerid, 274.000000, 241.000000, "4");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][24], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][24], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][24], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][24], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][24], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][24], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][24], true);

	TD_SecPass[playerid][25] = CreatePlayerTextDraw(playerid, 310.000000, 241.000000, "5");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][25], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][25], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][25], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][25], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][25], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][25], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][25], true);

	TD_SecPass[playerid][26] = CreatePlayerTextDraw(playerid, 344.000000, 241.000000, "6");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][26], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][26], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][26], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][26], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][26], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][26], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][26], true);

	TD_SecPass[playerid][27] = CreatePlayerTextDraw(playerid, 275.000000, 277.000000, "7");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][27], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][27], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][27], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][27], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][27], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][27], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][27], true);

	TD_SecPass[playerid][28] = CreatePlayerTextDraw(playerid, 310.000000, 277.000000, "8");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][28], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][28], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][28], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][28], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][28], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][28], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][28], true);

	TD_SecPass[playerid][29] = CreatePlayerTextDraw(playerid, 344.000000, 277.000000, "9");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][29], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][29], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][29], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][29], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][29], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][29], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][29], true);

	// Задний фон кнопки << (удалить)
	TD_SecPass[playerid][30] = CreatePlayerTextDraw(playerid, 366.300000, 170.500000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][30], 0.000000, 2.300000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][30], 396.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][30], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][30], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][30], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][30], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][30], 0x2b2b2bFF);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][30], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][30], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][30], true);

	// Кликабельный фон кнопки << (удалить)
	TD_SecPass[playerid][31] = CreatePlayerTextDraw(playerid, 365.000000, 169.000000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][31], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][31], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][31], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][31], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][31], 0x212121FF);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][31], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][31], true);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][31], 32.300000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][31], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][31], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кнопка удалить
	TD_SecPass[playerid][32] = CreatePlayerTextDraw(playerid, 369.000000, 173.400000, "<<");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][32], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][32], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][32], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][32], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][32], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][32], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][32], true);

	// Задний фон таймера
	TD_SecPass[playerid][33] = CreatePlayerTextDraw(playerid, 266.600000, 302.400000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][33], 0.000000, 2.000000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][33], 362.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][33], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][33], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][33], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][33], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][33], 0x2b2b2bFF);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][33], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][33], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][33], true);

	TD_SecPass[playerid][34] = CreatePlayerTextDraw(playerid, 314.000000, 304.000000, "Таймер:_00:00");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][34], 0.300000, 1.500000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][34], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][34], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][34], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][34], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][34], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][34], true);

	// Задний фон кнопки Ввода
	TD_SecPass[playerid][35] = CreatePlayerTextDraw(playerid, 266.600000, 325.200000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][35], 0.000000, 2.000000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][35], 362.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][35], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][35], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][35], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][35], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][35], 0xb0b0b0FF);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][35], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][35], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][35], true);

	// Кликабельный фон кнопки Ввода
	TD_SecPass[playerid][36] = CreatePlayerTextDraw(playerid, 265.300000, 322.800000, "_");
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][36], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][36], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][36], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][36], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][36], 0x2b2b2bFF);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][36], 0);
	PlayerTextDrawSetSelectable(playerid, TD_SecPass[playerid][36], true);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][36], 98.000000, 23.000000);
	PlayerTextDrawSetPreviewModel(playerid, TD_SecPass[playerid][36], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_SecPass[playerid][36], 0.000000, 0.000000, 0.000000, 1000.000000);

	TD_SecPass[playerid][37] = CreatePlayerTextDraw(playerid, 316.300000, 326.800000, "Ввод");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][37], 0.300000, 1.500000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][37], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][37], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][37], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][37], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][37], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][37], true);

	// Введённые цифры
	TD_SecPass[playerid][38] = CreatePlayerTextDraw(playerid, 315.300000, 171.700000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][38], 0.300000, 1.500000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][38], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][38], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][38], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][38], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][38], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][38], true);

	// Задний фон текста Второй пароль
	TD_SecPass[playerid][39] = CreatePlayerTextDraw(playerid, 267.000000, 144.300000, "_");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][39], 0.000000, 2.000000);
	PlayerTextDrawTextSize(playerid, TD_SecPass[playerid][39], 362.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][39], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][39], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][39], 0);
	PlayerTextDrawUseBox(playerid, TD_SecPass[playerid][39], true);
	PlayerTextDrawBoxColour(playerid, TD_SecPass[playerid][39], 0x212121FF);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][39], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][39], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][39], true);

	TD_SecPass[playerid][40] = CreatePlayerTextDraw(playerid, 315.300000, 145.600000, "Второй_пароль");
	PlayerTextDrawLetterSize(playerid, TD_SecPass[playerid][40], 0.200000, 1.500000);
	PlayerTextDrawAlignment(playerid, TD_SecPass[playerid][40], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_SecPass[playerid][40], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_SecPass[playerid][40], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_SecPass[playerid][40], 255);
	PlayerTextDrawFont(playerid, TD_SecPass[playerid][40], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_SecPass[playerid][40], true);
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerTDs(playerid)
{
	n_for(i, sizeof(TD_SecPass[]))
		TD_SecPass[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

/*

	* Interfaces *

*/

InterfaceCreate:SecondPassword(playerid)
{
	SetPlayerClickTD(playerid, true);

	SetPVarInt(playerid, "TimerSecPass_PVar", 30);
	SetPVarString(playerid, "StringSecPass_PVar", "");

	ShowPlayerTDSecondPass(playerid);

	n_for(i, sizeof(TD_SecPass[]))
		PlayerTextDrawShow(playerid, TD_SecPass[playerid][i]);

	SelectTextDraw(playerid, 0xAFAFAFAA);
	return 1;
}

InterfaceClose:SecondPassword(playerid)
{
	SetPlayerClickTD(playerid, false);

	DeletePVar(playerid, "TimerSecPass_PVar");
	DeletePVar(playerid, "StringSecPass_PVar");

	n_for(i, sizeof(TD_SecPass[]))
		DestroyPlayerTD(playerid, TD_SecPass[playerid][i]);

	CancelSelectTextDraw(playerid);
	return 1;
}

InterfacePlayerClick:SecondPassword(playerid, PlayerText:playertextid)
{
	if(!GetPlayerLogged(playerid)) {
		new
			string[20];

		GetPVarString(playerid, "StringSecPass_PVar", string, sizeof(string));
		if(playertextid == TD_SecPass[playerid][36]) {
			if(!strlen(string))
				return 1;

			if(strlen(string) < 3) {
				SCM(playerid, -1, "{CC0033}(Пароль) {FFFFFF}Меньше 3 цифр запрещено.");
				return 1;
			}

			pInfo[playerid][pSecondPassword][0] = EOS;
			mysql_escape_string(string, pInfo[playerid][pSecondPassword]);

			new
				query[150];

			mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Second_password` = '%s' WHERE `ID` = '%d'", pInfo[playerid][pSecondPassword], GetPlayerpID(playerid));
			mysql_tquery(MysqlID, query);

			SCM(playerid, -1, "{57D643}(Информация) {FFFFFF}Второй пароль успешно создан.");
			Interface_Close(playerid, Interface:SecondPassword);
			Interface_Show(playerid, Interface:MainMenu);
			return 1;
		}
		else if(playertextid == TD_SecPass[playerid][31]) {
			strdel(string, strlen(string) - 1, strlen(string));
			SetPVarString(playerid, "StringSecPass_PVar", string);
			PlayerTextDrawSetString(playerid, TD_SecPass[playerid][38], string);
			return 1;
		}
		if(strlen(string) > 5) {
			SCM(playerid, -1, "{CC0033}(Пароль) {FFFFFF}Больше 6 цифр запрещено.");
			return 1;
		}

		else if(playertextid == TD_SecPass[playerid][12]) strcat(string, "1");
		else if(playertextid == TD_SecPass[playerid][13]) strcat(string, "2");
		else if(playertextid == TD_SecPass[playerid][14]) strcat(string, "3");
		else if(playertextid == TD_SecPass[playerid][15]) strcat(string, "4");
		else if(playertextid == TD_SecPass[playerid][16]) strcat(string, "5");
		else if(playertextid == TD_SecPass[playerid][17]) strcat(string, "6");
		else if(playertextid == TD_SecPass[playerid][18]) strcat(string, "7");
		else if(playertextid == TD_SecPass[playerid][19]) strcat(string, "8");
		else if(playertextid == TD_SecPass[playerid][20]) strcat(string, "9");

		SetPVarString(playerid, "StringSecPass_PVar", string);
		PlayerTextDrawSetString(playerid, TD_SecPass[playerid][38], string);
		return 1;
	}
	else {
		new
			string[20];

		GetPVarString(playerid, "StringSecPass_PVar", string, sizeof(string));
		if(playertextid == TD_SecPass[playerid][36]) {
			if(!strlen(string)) 
				return 1;
			
			if(strcmp(string, pInfo[playerid][pSecondPassword])) {
				SCM(playerid, -1, "{CC0033}(Пароль) {FFFFFF}Неправильный пароль!");
				return 1;
			}
			KillPlayerLoggedTimer(playerid);
			Interface_Close(playerid, Interface:SecondPassword);

			SCM(playerid, -1, "{57D643}(Информация) {FFFFFF}Второй пароль успешно введён.");
			if(Adm_CheckPlayerForAdmin(playerid))
				return 1;

			ConnectPlayerServer(playerid);
			return 1;
		}
		else if(playertextid == TD_SecPass[playerid][31]) {
			strdel(string, strlen(string) - 1, strlen(string));
			SetPVarString(playerid, "StringSecPass_PVar", string);
			PlayerTextDrawSetString(playerid, TD_SecPass[playerid][38], string);
			return 1;
		}
		if(strlen(string) > 5) {
			SCM(playerid, -1, "{CC0033}(Пароль) {FFFFFF}Больше 6 цифр запрещено.");
			return 1;
		}

		else if(playertextid == TD_SecPass[playerid][12]) strcat(string, "1");
		else if(playertextid == TD_SecPass[playerid][13]) strcat(string, "2");
		else if(playertextid == TD_SecPass[playerid][14]) strcat(string, "3");
		else if(playertextid == TD_SecPass[playerid][15]) strcat(string, "4");
		else if(playertextid == TD_SecPass[playerid][16]) strcat(string, "5");
		else if(playertextid == TD_SecPass[playerid][17]) strcat(string, "6");
		else if(playertextid == TD_SecPass[playerid][18]) strcat(string, "7");
		else if(playertextid == TD_SecPass[playerid][19]) strcat(string, "8");
		else if(playertextid == TD_SecPass[playerid][20]) strcat(string, "9");

		SetPVarString(playerid, "StringSecPass_PVar", string);
		PlayerTextDrawSetString(playerid, TD_SecPass[playerid][38], string);
	}
	return 1;
}

/*

	* Dialogs *

*/

DialogCreate:PlayerSecondPassword(playerid)
{
	if(!strcmp(pInfo[playerid][pSecondPassword], "No Second Password", true)) {
		Dialog_Open(playerid, Dialog:PlayerSecondPassword, DSL, "Второй пароль", "\
		"C_N"• {FFFFFF}Создать \
		\n"C_N"• {FFFFFF}Удалить", "Выбрать", "Выход");
	}
	else {
		Dialog_Open(playerid, Dialog:PlayerSecondPassword, DSL, "Второй пароль", "\
		"C_N"• {FFFFFF}Поменять \
		\n"C_N"• {FFFFFF}Удалить", "Выбрать", "Выход");
	}
	return 1;
}

DialogResponse:PlayerSecondPassword(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				if(Mode_GetPlayer(playerid) != MODE_NONE 
				|| GetPlayerBusy(playerid) != MAIN_MENU 
				|| Interface_IsOpen(playerid, Interface:SecondPassword)) {

					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данную функцию можно изменить только в главном меню.");
					Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
					return 1;
				}
				Interface_Close(playerid, Interface:MainMenu);
				Interface_Show(playerid, Interface:SecondPassword);
			}
			case 1: {
				if(!strcmp(pInfo[playerid][pSecondPassword], "No Second Password", true)) {
					SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}У вас нет второго пароля.");
					Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
					return 1;
				}
				if(Mode_GetPlayer(playerid) != MODE_NONE 
				|| GetPlayerBusy(playerid) != MAIN_MENU 
				|| Interface_IsOpen(playerid, Interface:SecondPassword)) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данную функцию можно изменить только в главном меню.");
					Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
					return 1;
				}

				pInfo[playerid][pSecondPassword][0] = EOS;
				mysql_escape_string("No Second Password", pInfo[playerid][pSecondPassword]);

				new
					query[150];

				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Second_password` = '%s' WHERE `ID` = '%d'", pInfo[playerid][pSecondPassword], GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);

				SCM(playerid, -1, "{57D643}(Информация) {FFFFFF}Второй пароль успешно удалён.");
				Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
			}
		}
	}
	else {
		if(GetPlayerBusy(playerid) != MAIN_MENU)
			Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
	}
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerTDs(playerid);

	#if defined SecPass_OnPlayerConnect
		return SecPass_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	ALS
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