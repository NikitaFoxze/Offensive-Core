/*
 * |>==========================<|
 * |   About: Admin textdraws   |
 * |   Author: Foxze            |
 * |>==========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- CreatePlayerAdminSpectatingTD(playerid, PlayerText:playerTD[])
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_ADMIN_TD
	#endinput
#endif
#define _INC_ADMIN_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define ADMIN_TD_SPECTATING		(26)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>--------------<|
 * |   Spectating   |
 * |>--------------<|
 */

stock CreatePlayerAdminSpectatingTD(playerid, PlayerText:playerTD[])
{
	// Задний фон 1
	playerTD[0] = CreatePlayerTextDraw(playerid, 63.0000, 167.0000, "Box");
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.0000, 12.7333);
	PlayerTextDrawTextSize(playerid, playerTD[0], 140.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], -580583169);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);

	// Статистика
	playerTD[1] = CreatePlayerTextDraw(playerid, 63.0000, 168.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[1], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 976894719);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[1], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Забанить
	playerTD[2] = CreatePlayerTextDraw(playerid, 63.0000, 187.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[2], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 976894719);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[2], false);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[2], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кикнуть
	playerTD[3] = CreatePlayerTextDraw(playerid, 63.0000, 206.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[3], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 976894719);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[3], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Подкинуть
	playerTD[4] = CreatePlayerTextDraw(playerid, 63.0000, 225.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[4], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 976894719);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[4], false);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Спавн
	playerTD[5] = CreatePlayerTextDraw(playerid, 63.0000, 244.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[5], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 976894719);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[5], false);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[5], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[5], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[5], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Выход
	playerTD[6] = CreatePlayerTextDraw(playerid, 63.0000, 263.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[6], 77.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 976894719);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[6], false);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[6], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[6], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[6], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Статистика
	playerTD[7] = CreatePlayerTextDraw(playerid, 102.0000, 170.0000, "Stats");
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, playerTD[7], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 48);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);

	// Забанить
	playerTD[8] = CreatePlayerTextDraw(playerid, 102.0000, 189.0000, "Ban");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, playerTD[8], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 48);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);

	// Кикнуть
	playerTD[9] = CreatePlayerTextDraw(playerid, 102.0000, 208.0000, "Kick");
	PlayerTextDrawLetterSize(playerid, playerTD[9], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, playerTD[9], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 48);
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[9], true);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);

	// Подкинуть
	playerTD[10] = CreatePlayerTextDraw(playerid, 102.0000, 227.0000, "Slap");
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[10], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, playerTD[10], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 48);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);

	// Спавн
	playerTD[11] = CreatePlayerTextDraw(playerid, 102.0000, 246.0000, "Spawn");
	PlayerTextDrawLetterSize(playerid, playerTD[11], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, playerTD[11], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 48);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[11], true);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);

	// Выход
	playerTD[12] = CreatePlayerTextDraw(playerid, 102.0000, 265.0000, "Exit");
	PlayerTextDrawLetterSize(playerid, playerTD[12], 0.2766, 1.3801);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[12], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, playerTD[12], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 48);
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[12], true);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);

	// Задний фон 2
	playerTD[13] = CreatePlayerTextDraw(playerid, 477.0000, 295.0000, "Box");
	PlayerTextDrawLetterSize(playerid, playerTD[13], 0.0000, 11.5999);
	PlayerTextDrawTextSize(playerid, playerTD[13], 570.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[13], true);
	PlayerTextDrawBoxColour(playerid, playerTD[13], 976894719);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 255);
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[13], true);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);

	// Задний фон 2
	playerTD[14] = CreatePlayerTextDraw(playerid, 477.0000, 295.0000, "Box");
	PlayerTextDrawLetterSize(playerid, playerTD[14], 0.0000, 1.5000);
	PlayerTextDrawTextSize(playerid, playerTD[14], 570.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[14], true);
	PlayerTextDrawBoxColour(playerid, playerTD[14], -580583169);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 255);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[14], true);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);

	// Nick
	playerTD[15] = CreatePlayerTextDraw(playerid, 477.0000, 292.0000, "Nikita_Foxze_[300]");
	PlayerTextDrawLetterSize(playerid, playerTD[15], 0.1695, 1.8696);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[15], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], 255);
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[15], true);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);

	// Mode/Session
	playerTD[16] = CreatePlayerTextDraw(playerid, 477.0000, 311.0000, "Mode/Session:_TDM/1");
	PlayerTextDrawLetterSize(playerid, playerTD[16], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[16], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], 255);
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[16], true);
	PlayerTextDrawSetShadow(playerid, playerTD[16], 0);

	// Health/Armour
	playerTD[17] = CreatePlayerTextDraw(playerid, 477.0000, 322.0000, "Health/Armour:_100./100.0");
	PlayerTextDrawLetterSize(playerid, playerTD[17], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[17], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[17], 255);
	PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[17], true);
	PlayerTextDrawSetShadow(playerid, playerTD[17], 0);

	// Speed
	playerTD[18] = CreatePlayerTextDraw(playerid, 477.0000, 333.0000, "Speed:_1000");
	PlayerTextDrawLetterSize(playerid, playerTD[18], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[18], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[18], 255);
	PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[18], true);
	PlayerTextDrawSetShadow(playerid, playerTD[18], 0);

	// Weapon
	playerTD[19] = CreatePlayerTextDraw(playerid, 477.0000, 344.0000, "Weapon:_Deagle");
	PlayerTextDrawLetterSize(playerid, playerTD[19], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, playerTD[19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[19], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[19], 255);
	PlayerTextDrawFont(playerid, playerTD[19], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[19], true);
	PlayerTextDrawSetShadow(playerid, playerTD[19], 0);

	// Ammo
	playerTD[20] = CreatePlayerTextDraw(playerid, 477.0000, 354.0000, "Ammo:_1000");
	PlayerTextDrawLetterSize(playerid, playerTD[20], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, playerTD[20], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[20], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[20], 255);
	PlayerTextDrawFont(playerid, playerTD[20], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[20], true);
	PlayerTextDrawSetShadow(playerid, playerTD[20], 0);

	// Warns
	playerTD[21] = CreatePlayerTextDraw(playerid, 477.0000, 365.0000, "Warns:_3");
	PlayerTextDrawLetterSize(playerid, playerTD[21], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, playerTD[21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[21], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[21], 255);
	PlayerTextDrawFont(playerid, playerTD[21], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[21], true);
	PlayerTextDrawSetShadow(playerid, playerTD[21], 0);

	// Ping
	playerTD[22] = CreatePlayerTextDraw(playerid, 477.0000, 376.0000, "Ping:_300");
	PlayerTextDrawLetterSize(playerid, playerTD[22], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, playerTD[22], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[22], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[22], 255);
	PlayerTextDrawFont(playerid, playerTD[22], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[22], true);
	PlayerTextDrawSetShadow(playerid, playerTD[22], 0);

	// FPS
	playerTD[23] = CreatePlayerTextDraw(playerid, 477.0000, 387.0000, "FPS:_100");
	PlayerTextDrawLetterSize(playerid, playerTD[23], 0.2026, 1.3302);
	PlayerTextDrawAlignment(playerid, playerTD[23], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[23], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[23], 255);
	PlayerTextDrawFont(playerid, playerTD[23], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[23], true);
	PlayerTextDrawSetShadow(playerid, playerTD[23], 0);

	// Задний фон обновления данных
	playerTD[24] = CreatePlayerTextDraw(playerid, 476.0000, 404.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[24], 57.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, playerTD[24], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[24], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[24], 976894719);
	PlayerTextDrawFont(playerid, playerTD[24], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[24], false);
	PlayerTextDrawSetShadow(playerid, playerTD[24], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[24], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[24], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[24], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Обновление даннхы
	playerTD[25] = CreatePlayerTextDraw(playerid, 484.0000, 406.0000, "UPDATE");
	PlayerTextDrawLetterSize(playerid, playerTD[25], 0.2583, 1.7949);
	PlayerTextDrawAlignment(playerid, playerTD[25], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[25], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, playerTD[25], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[25], 48);
	PlayerTextDrawFont(playerid, playerTD[25], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[25], true);
	PlayerTextDrawSetShadow(playerid, playerTD[25], 0);
	return 1;
}