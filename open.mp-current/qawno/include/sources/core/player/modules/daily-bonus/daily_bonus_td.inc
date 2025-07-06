/*
 * |>================================<|
 * |   About: Daily-bonus textdraws   |
 * |   Author: Foxze                  |
 * |>================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- CreatePlayerDailyBonusRewardTD(playerid, PlayerText:playerTD[])
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_DAILY_BONUS_TD
	#endinput
#endif
#define _INC_DAILY_BONUS_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define DAILY_BONUS_TD_REWARD	(11)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>----------<|
 * |   Reward   |
 * |>----------<|
 */

stock CreatePlayerDailyBonusRewardTD(playerid, PlayerText:playerTD[])
{
	// Задний жёлтый фон
	playerTD[0] = CreatePlayerTextDraw(playerid, 273.0000, 170.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], -1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], -1147842305);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawTextSize(playerid, playerTD[0], 90.0000, 90.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон
	playerTD[1] = CreatePlayerTextDraw(playerid, 273.6665, 170.8296, "_");
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], -1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawTextSize(playerid, playerTD[1], 89.0000, 88.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон кнопки забрать
	playerTD[2] = CreatePlayerTextDraw(playerid, 273.0000, 262.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], -1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[2], false);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawTextSize(playerid, playerTD[2], 90.0000, 21.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон кнопки забрать
	playerTD[3] = CreatePlayerTextDraw(playerid, 274.0000, 263.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], -1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 303174399);
	PlayerTextDrawSetSelectable(playerid, playerTD[3], true);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawTextSize(playerid, playerTD[3], 88.0000, 19.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[4] = CreatePlayerTextDraw(playerid, 318.0000, 264.0000, "Забрать");
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.3379, 1.6871);
	PlayerTextDrawTextSize(playerid, playerTD[4], 15.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[4], -1145325057);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 255);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);

	// Задний чёрный фон бонус
	playerTD[5] = CreatePlayerTextDraw(playerid, 273.0000, 152.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], -1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[5], false);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawTextSize(playerid, playerTD[5], 90.0000, 16.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[5], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[5], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[6] = CreatePlayerTextDraw(playerid, 318.0000, 151.0000, "Ежедневный_бонус");
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.1939, 1.8156);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[6], -303174657);
	PlayerTextDrawSetOutline(playerid, playerTD[6], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 80);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);

	// Кол-во дней
	playerTD[7] = CreatePlayerTextDraw(playerid, 360.0000, 242.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.2386, 1.5874);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD[7], 1637533439);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 80);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);

	// EXP
	playerTD[8] = CreatePlayerTextDraw(playerid, 319.0000, 174.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.2375, 1.8156);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[8], -409396993);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 80);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);

	// Деньги
	playerTD[9] = CreatePlayerTextDraw(playerid, 319.0000, 190.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[9], 0.2375, 1.8156);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[9], 649482239);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 80);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[9], true);

	// Gold coins
	playerTD[10] = CreatePlayerTextDraw(playerid, 319.0000, 206.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.2375, 1.8156);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[10], -371844865);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 80);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);
	return 1;
}