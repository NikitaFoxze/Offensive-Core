/*
 * |>=========================<|
 * |   About: None textdraws   |
 * |   Author: Foxze           |
 * |>=========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- None_CreatePlayerMainMenuTD(playerid, PlayerText:playerTD[])
	- None_CreatePlayerSelectModeTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:base, bool:returnMenu, const modeName[], const modeColor, &startTD)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_NONE_TD
	#endinput
#endif
#define _INC_NONE_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define NONE_TD_MAIN_MENU		(30)
#define NONE_TD_SELECT_MODE		(3 + (GMS_MAX_MODES * 3) + 3)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>-------------<|
 * |   Main menu   |
 * |>-------------<|
 */

stock None_CreatePlayerMainMenuTD(playerid, PlayerText:playerTD[])
{
	// Задний фон
	playerTD[0] = CreatePlayerTextDraw(playerid, 116.0000, 123.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], -1701143809);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawTextSize(playerid, playerTD[0], 89.0000, 25.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[1] = CreatePlayerTextDraw(playerid, 117.0000, 124.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], -468380161);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawTextSize(playerid, playerTD[1], 87.0000, 23.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[2] = CreatePlayerTextDraw(playerid, 160.0000, 126.0000, "Главное_меню");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.2338, 1.8530);
	PlayerTextDrawTextSize(playerid, playerTD[2], 0.0000, 86.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 48);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 1);

	// Задний фон
	playerTD[3] = CreatePlayerTextDraw(playerid, 116.0000, 155.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawTextSize(playerid, playerTD[3], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[4] = CreatePlayerTextDraw(playerid, 117.0000, 156.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 0x911111FF);
	PlayerTextDrawSetProportional(playerid, playerTD[4], false);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
	PlayerTextDrawTextSize(playerid, playerTD[4], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[5] = CreatePlayerTextDraw(playerid, 160.0000, 158.0000, "Играть");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[5], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[5], -218959617);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 0x00000020);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[5], true);

	// Задний фон
	playerTD[6] = CreatePlayerTextDraw(playerid, 116.0000, 182.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[6], false);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawTextSize(playerid, playerTD[6], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[6], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[6], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[7] = CreatePlayerTextDraw(playerid, 117.0000, 183.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 0x911111FF);
	PlayerTextDrawSetProportional(playerid, playerTD[7], false);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[7], true);
	PlayerTextDrawTextSize(playerid, playerTD[7], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[7], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[7], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[8] = CreatePlayerTextDraw(playerid, 160.0000, 185.0000, "Статистика");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[8], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[8], -353703681);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 0x00000020);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[8], true);

	// Задний фон
	playerTD[9] = CreatePlayerTextDraw(playerid, 116.0000, 209.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[9], false);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawTextSize(playerid, playerTD[9], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[9], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[9], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[10] = CreatePlayerTextDraw(playerid, 117.0000, 210.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[10], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 0x911111FF);
	PlayerTextDrawSetProportional(playerid, playerTD[10], false);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[10], true);
	PlayerTextDrawTextSize(playerid, playerTD[10], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[10], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[10], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[11] = CreatePlayerTextDraw(playerid, 160.0000, 212.0000, "Инвентарь");
	PlayerTextDrawLetterSize(playerid, playerTD[11], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[11], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[11], -353703681);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 0x00000020);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[11], true);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[11], true);

	 // Задний фон
	playerTD[12] = CreatePlayerTextDraw(playerid, 116.0000, 236.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[12], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[12], false);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
	PlayerTextDrawTextSize(playerid, playerTD[12], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[12], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[12], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[13] = CreatePlayerTextDraw(playerid, 117.0000, 237.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 0x8214a3FF);
	PlayerTextDrawSetProportional(playerid, playerTD[13], false);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[13], true);
	PlayerTextDrawTextSize(playerid, playerTD[13], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[13], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[13], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[14] = CreatePlayerTextDraw(playerid, 160.0000, 239.0000, "Торг._площадка");
	PlayerTextDrawLetterSize(playerid, playerTD[14], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[14], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[14], -353703681);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 0x00000020);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[14], true);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[14], true);

	// Задний фон
	playerTD[15] = CreatePlayerTextDraw(playerid, 116.0000, 263.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[15], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[15], false);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);
	PlayerTextDrawTextSize(playerid, playerTD[15], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[15], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[15], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[16] = CreatePlayerTextDraw(playerid, 117.0000, 264.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[16], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], 0x8214a3FF);
	PlayerTextDrawSetProportional(playerid, playerTD[16], false);
	PlayerTextDrawSetShadow(playerid, playerTD[16], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[16], true);
	PlayerTextDrawTextSize(playerid, playerTD[16], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[16], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[16], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[17] = CreatePlayerTextDraw(playerid, 160.0000, 266.0000, "Помощь");
	PlayerTextDrawLetterSize(playerid, playerTD[17], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[17], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[17], -353703681);
	PlayerTextDrawBackgroundColour(playerid, playerTD[17], 0x00000020);
	PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[17], true);
	PlayerTextDrawSetShadow(playerid, playerTD[17], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[17], true);

	// Задний фон
	playerTD[18] = CreatePlayerTextDraw(playerid, 116.0000, 290.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[18], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[18], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[18], false);
	PlayerTextDrawSetShadow(playerid, playerTD[18], 0);
	PlayerTextDrawTextSize(playerid, playerTD[18], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[18], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[18], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[19] = CreatePlayerTextDraw(playerid, 117.0000, 291.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[19], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[19], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[19], 0x8214a3FF);
	PlayerTextDrawSetProportional(playerid, playerTD[19], false);
	PlayerTextDrawSetShadow(playerid, playerTD[19], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[19], true);
	PlayerTextDrawTextSize(playerid, playerTD[19], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[19], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[19], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[20] = CreatePlayerTextDraw(playerid, 160.0000, 293.0000, "Донат");
	PlayerTextDrawLetterSize(playerid, playerTD[20], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[20], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[20], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[20], -353703681);
	PlayerTextDrawBackgroundColour(playerid, playerTD[20], 0x00000020);
	PlayerTextDrawFont(playerid, playerTD[20], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[20], true);
	PlayerTextDrawSetShadow(playerid, playerTD[20], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[20], true);

	// Задний фон
	playerTD[21] = CreatePlayerTextDraw(playerid, 116.0000, 317.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[21], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[21], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[21], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[21], false);
	PlayerTextDrawSetShadow(playerid, playerTD[21], 0);
	PlayerTextDrawTextSize(playerid, playerTD[21], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[21], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[21], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[22] = CreatePlayerTextDraw(playerid, 117.0000, 318.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[22], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[22], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[22], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[22], 0x118da8FF);
	PlayerTextDrawSetProportional(playerid, playerTD[22], false);
	PlayerTextDrawSetShadow(playerid, playerTD[22], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[22], true);
	PlayerTextDrawTextSize(playerid, playerTD[22], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[22], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[22], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[23] = CreatePlayerTextDraw(playerid, 160.0000, 320.0000, "Опции");
	PlayerTextDrawLetterSize(playerid, playerTD[23], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[23], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[23], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[23], -353703681);
	PlayerTextDrawBackgroundColour(playerid, playerTD[23], 0x00000020);
	PlayerTextDrawFont(playerid, playerTD[23], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[23], true);
	PlayerTextDrawSetShadow(playerid, playerTD[23], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[23], true);

	// Задний фон
	playerTD[24] = CreatePlayerTextDraw(playerid, 116.0000, 344.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[24], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[24], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[24], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[24], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[24], false);
	PlayerTextDrawSetShadow(playerid, playerTD[24], 0);
	PlayerTextDrawTextSize(playerid, playerTD[24], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[24], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[24], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[25] = CreatePlayerTextDraw(playerid, 117.0000, 345.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[25], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[25], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[25], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[25], 0x118da8FF);
	PlayerTextDrawSetProportional(playerid, playerTD[25], false);
	PlayerTextDrawSetShadow(playerid, playerTD[25], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[25], true);
	PlayerTextDrawTextSize(playerid, playerTD[25], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[25], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[25], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[26] = CreatePlayerTextDraw(playerid, 160.0000, 347.0000, "Безопасность");
	PlayerTextDrawLetterSize(playerid, playerTD[26], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[26], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[26], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[26], -353703681);
	PlayerTextDrawBackgroundColour(playerid, playerTD[26], 0x00000020);
	PlayerTextDrawFont(playerid, playerTD[26], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[26], true);
	PlayerTextDrawSetShadow(playerid, playerTD[26], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[26], true);

	// Задний фон
	playerTD[27] = CreatePlayerTextDraw(playerid, 116.0000, 371.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[27], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[27], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[27], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[27], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[27], false);
	PlayerTextDrawSetShadow(playerid, playerTD[27], 0);
	PlayerTextDrawTextSize(playerid, playerTD[27], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[27], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[27], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон
	playerTD[28] = CreatePlayerTextDraw(playerid, 117.0000, 372.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[28], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[28], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[28], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[28], 0x118da8FF);
	PlayerTextDrawSetProportional(playerid, playerTD[28], false);
	PlayerTextDrawSetShadow(playerid, playerTD[28], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[28], true);
	PlayerTextDrawTextSize(playerid, playerTD[28], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[28], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[28], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[29] = CreatePlayerTextDraw(playerid, 160.0000, 374.0000, "Промо-код");
	PlayerTextDrawLetterSize(playerid, playerTD[29], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[29], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[29], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[29], -353703681);
	PlayerTextDrawBackgroundColour(playerid, playerTD[29], 0x00000020);
	PlayerTextDrawFont(playerid, playerTD[29], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[29], true);
	PlayerTextDrawSetShadow(playerid, playerTD[29], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[29], true);
	return 1;
}

/*
 * |>---------------<|
 * |   Select mode   |
 * |>---------------<|
 */

stock None_CreatePlayerSelectModeTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:base, bool:returnMenu, const modeName[], const modeColor, &startTD)
{
	if (base) {
		// Задний фон
		playerTD[startTD] = CreatePlayerTextDraw(playerid, posX, posY, "_");
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], -1701143809);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 89.0000, 25.0000);
		PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
		startTD++;

		// Кликабельный фон
		playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 1.0, posY + 1.0, "_");
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], -468380161);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 87.0000, 23.0000);
		PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
		startTD++;

		playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 44.0, posY + 3.0, "Играть");
		PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.2337, 1.8530);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 0.0000, 85.0000);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
		PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 48);
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 1);
		startTD++;
		return 1;
	}

	if (returnMenu) {
		// Задний фон
		playerTD[startTD] = CreatePlayerTextDraw(playerid, posX, posY, "_");
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 0x3d3d3dFF);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 89.0000, 24.0000);
		PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
		startTD++;

		// Кликабельный фон
		playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 1.0, posY + 1.0, "_");
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 0xcf2323FF);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetSelectable(playerid, playerTD[startTD], true);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 87.0000, 22.0000);
		PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
		startTD++;

		playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 44.0, posY + 3.0, "Назад");
		PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.2404, 1.7740);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 16.0000, 88.0000);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
		PlayerTextDrawColour(playerid, playerTD[startTD], -353703681);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 80);
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetSelectable(playerid, playerTD[startTD], true);
		startTD++;
		return 1;
	}

	// Задний фон
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 0x3d3d3dFF);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 89.0000, 24.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
	startTD++;

	// Кликабельный фон
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 1.0, posY + 1.0, "_");
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], modeColor);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[startTD], true);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 87.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
	startTD++;

	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 44.0, posY + 3.0, modeName);
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.2404, 1.7740);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 16.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], -218959617);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 80);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[startTD], true);
	startTD++;
	return 1;
}