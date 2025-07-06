/*
 * |>====================================<|
 * |   About: Second-password textdraws   |
 * |   Author: Foxze                      |
 * |>====================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- CreatePlayerSecPassInputTD(playerid, PlayerText:playerTD[])
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_SECOND_PASSWORD_TD
	#endinput
#endif
#define _INC_SECOND_PASSWORD_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define SEC_PASSWORD_TD_INPUT	(41)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>---------<|
 * |   Input   |
 * |>---------<|
 */

stock CreatePlayerSecPassInputTD(playerid, PlayerText:playerTD[])
{
	// Основной задний фон
	playerTD[0] = CreatePlayerTextDraw(playerid, 267.000000, 168.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.000000, 14.400000);
	PlayerTextDrawTextSize(playerid, playerTD[0], 362.000000, 0.000000);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], 0x212121FF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);

	// Задний фон цифр (введенных)
	playerTD[1] = CreatePlayerTextDraw(playerid, 268.000000, 168.800000, "_");
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[1], 361.000000, 0.000000);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawUseBox(playerid, playerTD[1], true);
	PlayerTextDrawBoxColour(playerid, playerTD[1], 0x2b2b2bFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 255);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);

	// Задний фон 1 цифры
	playerTD[2] = CreatePlayerTextDraw(playerid, 269.000000, 205.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[2], 291.000000, 0.000000);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawUseBox(playerid, playerTD[2], true);
	PlayerTextDrawBoxColour(playerid, playerTD[2], -858993494);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);

	// Задний фон 2 цифры
	playerTD[3] = CreatePlayerTextDraw(playerid, 303.000000, 205.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[3], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[3], 325.600000, 0.000000);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawUseBox(playerid, playerTD[3], true);
	PlayerTextDrawBoxColour(playerid, playerTD[3], -858993494);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 255);
	PlayerTextDrawSetProportional(playerid, playerTD[3], true);

	// Задний фон 3 цифры
	playerTD[4] = CreatePlayerTextDraw(playerid, 337.000000, 205.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[4], 360.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawUseBox(playerid, playerTD[4], true);
	PlayerTextDrawBoxColour(playerid, playerTD[4], -858993494);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 255);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);

	// Задний фон 4 цифры
	playerTD[5] = CreatePlayerTextDraw(playerid, 269.000000, 239.00000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[5], 291.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawUseBox(playerid, playerTD[5], true);
	PlayerTextDrawBoxColour(playerid, playerTD[5], -858993494);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);

	// Задний фон 5 цифры
	playerTD[6] = CreatePlayerTextDraw(playerid, 303.000000, 239.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[6], 325.600000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawUseBox(playerid, playerTD[6], true);
	PlayerTextDrawBoxColour(playerid, playerTD[6], -858993494);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);

	// Задний фон 6 цифры
	playerTD[7] = CreatePlayerTextDraw(playerid, 337.000000, 239.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[7], 360.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawUseBox(playerid, playerTD[7], true);
	PlayerTextDrawBoxColour(playerid, playerTD[7], -858993494);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 255);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);

	// Задний фон 7 цифры
	playerTD[8] = CreatePlayerTextDraw(playerid, 269.000000, 274.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[8], 291.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawUseBox(playerid, playerTD[8], true);
	PlayerTextDrawBoxColour(playerid, playerTD[8], -858993494);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 255);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);

	// Задний фон 8 цифры
	playerTD[9] = CreatePlayerTextDraw(playerid, 303.000000, 274.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[9], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[9], 325.600000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawUseBox(playerid, playerTD[9], true);
	PlayerTextDrawBoxColour(playerid, playerTD[9], -858993494);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 255);
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[9], true);

	// Задний фон 9 цифры
	playerTD[10] = CreatePlayerTextDraw(playerid, 337.000000, 274.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.000000, 2.400000);
	PlayerTextDrawTextSize(playerid, playerTD[10], 360.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[10], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawUseBox(playerid, playerTD[10], true);
	PlayerTextDrawBoxColour(playerid, playerTD[10], 0xb0b0b0FF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 255);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);

	// Черта делящая верх и низ
	playerTD[11] = CreatePlayerTextDraw(playerid, 267.000000, 196.200000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[11], 0.000000, -0.000000);
	PlayerTextDrawTextSize(playerid, playerTD[11], 362.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawUseBox(playerid, playerTD[11], true);
	PlayerTextDrawBoxColour(playerid, playerTD[11], 255);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 0x737373FF);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[11], true);

	// Кликабельный фон 1 цифры
	playerTD[12] = CreatePlayerTextDraw(playerid, 267.600000, 203.500000, "_");
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[12], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, playerTD[12], true);
	PlayerTextDrawSetProportional(playerid, playerTD[12], false);
	PlayerTextDrawTextSize(playerid, playerTD[12], 24.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[12], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[12], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 2 цифры
	playerTD[13] = CreatePlayerTextDraw(playerid, 301.600000, 203.500000, "_");
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, playerTD[13], true);
	PlayerTextDrawSetProportional(playerid, playerTD[13], false);
	PlayerTextDrawTextSize(playerid, playerTD[13], 25.300000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[13], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[13], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 3 цифры
	playerTD[14] = CreatePlayerTextDraw(playerid, 335.600000, 203.500000, "_");
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, playerTD[14], true);
	PlayerTextDrawSetProportional(playerid, playerTD[14], false);
	PlayerTextDrawTextSize(playerid, playerTD[14], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[14], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[14], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 4 цифры
	playerTD[15] = CreatePlayerTextDraw(playerid, 267.600000, 237.500000, "_");
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[15], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, playerTD[15], true);
	PlayerTextDrawSetProportional(playerid, playerTD[15], false);
	PlayerTextDrawTextSize(playerid, playerTD[15], 24.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[15], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[15], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 5 цифры
	playerTD[16] = CreatePlayerTextDraw(playerid, 301.600000, 237.500000, "_");
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[16], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[16], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, playerTD[16], true);
	PlayerTextDrawSetProportional(playerid, playerTD[16], false);
	PlayerTextDrawTextSize(playerid, playerTD[16], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[16], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[16], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 6 цифры
	playerTD[17] = CreatePlayerTextDraw(playerid, 335.600000, 237.500000, "_");
	PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[17], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[17], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[17], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, playerTD[17], true);
	PlayerTextDrawSetProportional(playerid, playerTD[17], false);
	PlayerTextDrawTextSize(playerid, playerTD[17], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[17], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[17], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 7 цифры
	playerTD[18] = CreatePlayerTextDraw(playerid, 267.600000, 272.400000, "_");
	PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[18], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[18], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[18], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, playerTD[18], true);
	PlayerTextDrawSetProportional(playerid, playerTD[18], false);
	PlayerTextDrawTextSize(playerid, playerTD[18], 24.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[18], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[18], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 8 цифры
	playerTD[19] = CreatePlayerTextDraw(playerid, 301.500000, 272.400000, "_");
	PlayerTextDrawFont(playerid, playerTD[19], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[19], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[19], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[19], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, playerTD[19], true);
	PlayerTextDrawSetProportional(playerid, playerTD[19], false);
	PlayerTextDrawTextSize(playerid, playerTD[19], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[19], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[19], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кликабельный фон 9 цифры
	playerTD[20] = CreatePlayerTextDraw(playerid, 335.600000, 272.400000, "_");
	PlayerTextDrawFont(playerid, playerTD[20], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[20], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[20], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[20], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[20], 0xb0b0b0FF);
	PlayerTextDrawSetSelectable(playerid, playerTD[20], true);
	PlayerTextDrawSetProportional(playerid, playerTD[20], false);
	PlayerTextDrawTextSize(playerid, playerTD[20], 25.500000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[20], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[20], 0.000000, 0.000000, 0.000000, 1000.000000);

	playerTD[21] = CreatePlayerTextDraw(playerid, 277.000000, 207.000000, "1");
	PlayerTextDrawLetterSize(playerid, playerTD[21], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[21], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[21], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[21], 255);
	PlayerTextDrawFont(playerid, playerTD[21], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[21], true);

	playerTD[22] = CreatePlayerTextDraw(playerid, 309.300000, 207.000000, "2");
	PlayerTextDrawLetterSize(playerid, playerTD[22], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[22], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[22], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[22], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[22], 255);
	PlayerTextDrawFont(playerid, playerTD[22], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[22], true);

	playerTD[23] = CreatePlayerTextDraw(playerid, 344.000000, 207.000000, "3");
	PlayerTextDrawLetterSize(playerid, playerTD[23], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[23], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[23], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[23], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[23], 255);
	PlayerTextDrawFont(playerid, playerTD[23], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[23], true);

	playerTD[24] = CreatePlayerTextDraw(playerid, 274.000000, 241.000000, "4");
	PlayerTextDrawLetterSize(playerid, playerTD[24], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[24], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[24], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[24], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[24], 255);
	PlayerTextDrawFont(playerid, playerTD[24], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[24], true);

	playerTD[25] = CreatePlayerTextDraw(playerid, 310.000000, 241.000000, "5");
	PlayerTextDrawLetterSize(playerid, playerTD[25], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[25], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[25], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[25], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[25], 255);
	PlayerTextDrawFont(playerid, playerTD[25], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[25], true);

	playerTD[26] = CreatePlayerTextDraw(playerid, 344.000000, 241.000000, "6");
	PlayerTextDrawLetterSize(playerid, playerTD[26], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[26], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[26], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[26], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[26], 255);
	PlayerTextDrawFont(playerid, playerTD[26], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[26], true);

	playerTD[27] = CreatePlayerTextDraw(playerid, 275.000000, 277.000000, "7");
	PlayerTextDrawLetterSize(playerid, playerTD[27], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[27], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[27], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[27], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[27], 255);
	PlayerTextDrawFont(playerid, playerTD[27], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[27], true);

	playerTD[28] = CreatePlayerTextDraw(playerid, 310.000000, 277.000000, "8");
	PlayerTextDrawLetterSize(playerid, playerTD[28], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[28], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[28], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[28], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[28], 255);
	PlayerTextDrawFont(playerid, playerTD[28], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[28], true);

	playerTD[29] = CreatePlayerTextDraw(playerid, 344.000000, 277.000000, "9");
	PlayerTextDrawLetterSize(playerid, playerTD[29], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[29], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[29], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[29], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[29], 255);
	PlayerTextDrawFont(playerid, playerTD[29], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[29], true);

	// Задний фон кнопки << (удалить)
	playerTD[30] = CreatePlayerTextDraw(playerid, 366.300000, 170.500000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[30], 0.000000, 2.300000);
	PlayerTextDrawTextSize(playerid, playerTD[30], 396.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[30], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[30], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[30], 0);
	PlayerTextDrawUseBox(playerid, playerTD[30], true);
	PlayerTextDrawBoxColour(playerid, playerTD[30], 0x2b2b2bFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[30], 255);
	PlayerTextDrawFont(playerid, playerTD[30], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[30], true);

	// Кликабельный фон кнопки << (удалить)
	playerTD[31] = CreatePlayerTextDraw(playerid, 365.000000, 169.000000, "_");
	PlayerTextDrawFont(playerid, playerTD[31], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[31], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[31], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[31], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[31], 0x212121FF);
	PlayerTextDrawSetProportional(playerid, playerTD[31], false);
	PlayerTextDrawSetSelectable(playerid, playerTD[31], true);
	PlayerTextDrawTextSize(playerid, playerTD[31], 32.300000, 26.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[31], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[31], 0.000000, 0.000000, 0.000000, 1000.000000);

	// Кнопка удалить
	playerTD[32] = CreatePlayerTextDraw(playerid, 369.000000, 173.400000, "<<");
	PlayerTextDrawLetterSize(playerid, playerTD[32], 0.400000, 1.600000);
	PlayerTextDrawAlignment(playerid, playerTD[32], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[32], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[32], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[32], 255);
	PlayerTextDrawFont(playerid, playerTD[32], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[32], true);

	// Задний фон таймера
	playerTD[33] = CreatePlayerTextDraw(playerid, 266.600000, 302.400000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[33], 0.000000, 2.000000);
	PlayerTextDrawTextSize(playerid, playerTD[33], 362.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[33], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[33], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[33], 0);
	PlayerTextDrawUseBox(playerid, playerTD[33], true);
	PlayerTextDrawBoxColour(playerid, playerTD[33], 0x2b2b2bFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[33], 255);
	PlayerTextDrawFont(playerid, playerTD[33], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[33], true);

	playerTD[34] = CreatePlayerTextDraw(playerid, 314.000000, 304.000000, "Таймер:_00:00");
	PlayerTextDrawLetterSize(playerid, playerTD[34], 0.300000, 1.500000);
	PlayerTextDrawAlignment(playerid, playerTD[34], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[34], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[34], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[34], 255);
	PlayerTextDrawFont(playerid, playerTD[34], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[34], true);

	// Задний фон кнопки Ввода
	playerTD[35] = CreatePlayerTextDraw(playerid, 266.600000, 325.200000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[35], 0.000000, 2.000000);
	PlayerTextDrawTextSize(playerid, playerTD[35], 362.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[35], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[35], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[35], 0);
	PlayerTextDrawUseBox(playerid, playerTD[35], true);
	PlayerTextDrawBoxColour(playerid, playerTD[35], 0xb0b0b0FF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[35], 255);
	PlayerTextDrawFont(playerid, playerTD[35], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[35], true);

	// Кликабельный фон кнопки Ввода
	playerTD[36] = CreatePlayerTextDraw(playerid, 265.300000, 322.800000, "_");
	PlayerTextDrawFont(playerid, playerTD[36], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[36], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[36], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[36], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[36], 0x2b2b2bFF);
	PlayerTextDrawSetProportional(playerid, playerTD[36], false);
	PlayerTextDrawSetSelectable(playerid, playerTD[36], true);
	PlayerTextDrawTextSize(playerid, playerTD[36], 98.000000, 23.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[36], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[36], 0.000000, 0.000000, 0.000000, 1000.000000);

	playerTD[37] = CreatePlayerTextDraw(playerid, 316.300000, 326.800000, "Ввод");
	PlayerTextDrawLetterSize(playerid, playerTD[37], 0.300000, 1.500000);
	PlayerTextDrawAlignment(playerid, playerTD[37], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[37], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[37], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[37], 255);
	PlayerTextDrawFont(playerid, playerTD[37], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[37], true);

	// Введённые цифры
	playerTD[38] = CreatePlayerTextDraw(playerid, 315.300000, 171.700000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[38], 0.300000, 1.500000);
	PlayerTextDrawAlignment(playerid, playerTD[38], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[38], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[38], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[38], 255);
	PlayerTextDrawFont(playerid, playerTD[38], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[38], true);

	// Задний фон текста Второй пароль
	playerTD[39] = CreatePlayerTextDraw(playerid, 267.000000, 144.300000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[39], 0.000000, 2.000000);
	PlayerTextDrawTextSize(playerid, playerTD[39], 362.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[39], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[39], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[39], 0);
	PlayerTextDrawUseBox(playerid, playerTD[39], true);
	PlayerTextDrawBoxColour(playerid, playerTD[39], 0x212121FF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[39], 255);
	PlayerTextDrawFont(playerid, playerTD[39], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[39], true);

	playerTD[40] = CreatePlayerTextDraw(playerid, 315.300000, 145.600000, "Второй_пароль");
	PlayerTextDrawLetterSize(playerid, playerTD[40], 0.200000, 1.500000);
	PlayerTextDrawAlignment(playerid, playerTD[40], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[40], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[40], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[40], 255);
	PlayerTextDrawFont(playerid, playerTD[40], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[40], true);
	return 1;
}