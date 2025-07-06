/*
 * |>============================<|
 * |   About: Vehicle textdraws   |
 * |   Author: Foxze              |
 * |>============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- CreatePlayerVehSpeedometerTD(playerid, PlayerText:playerTD[])
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_VEHICLE_TD
	#endinput
#endif
#define _INC_VEHICLE_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define VEHICLE_TD_SPEEDOMETER	(10)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>---------------<|
 * |   Speedometer   |
 * |>---------------<|
 */

stock CreatePlayerVehSpeedometerTD(playerid, PlayerText:playerTD[])
{
	// Задний фон двигатель
	playerTD[0] = CreatePlayerTextDraw(playerid, 517.0000, 419.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawBackgroundColour(playerid, playerTD[0], 698554367);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawTextSize(playerid, playerTD[0], 101.0000, 3.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Основной задний фон
	playerTD[1] = CreatePlayerTextDraw(playerid, 517.0000, 360.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawBackgroundColour(playerid, playerTD[1], 606348543);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawTextSize(playerid, playerTD[1], 101.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Полоска
	playerTD[2] = CreatePlayerTextDraw(playerid, 517.0000, 373.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawBackgroundColour(playerid, playerTD[2], 1077952767);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[2], false);
	PlayerTextDrawTextSize(playerid, playerTD[2], 101.0000, 2.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Название транспорта
	playerTD[3] = CreatePlayerTextDraw(playerid, 568.0000, 359.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[3], 0.2242, 1.4714);
	PlayerTextDrawTextSize(playerid, playerTD[3], 0.0000, 93.0000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[3], -589505793);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 255);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[3], true);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);

	// Скорость
	playerTD[4] = CreatePlayerTextDraw(playerid, 568.0000, 382.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.4663, 2.7904);
	PlayerTextDrawTextSize(playerid, playerTD[4], 0.0000, 96.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[4], -239757313);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 255);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);

	// Капля
	playerTD[5] = CreatePlayerTextDraw(playerid, 594.0000, 390.0000, "hud:radar_centre");
	PlayerTextDrawTextSize(playerid, playerTD[5], 16.0000, 13.0000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], 1332724991);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_SPRITE);
	PlayerTextDrawSetProportional(playerid, playerTD[5], false);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);

	// Плюсик
	playerTD[6] = CreatePlayerTextDraw(playerid, 525.0000, 391.0000, "hud:radar_hostpital");
	PlayerTextDrawTextSize(playerid, playerTD[6], 12.0000, 11.0000);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], -1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_SPRITE);
	PlayerTextDrawSetProportional(playerid, playerTD[6], false);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);

	// Здоровья
	playerTD[7] = CreatePlayerTextDraw(playerid, 534.0000, 403.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.2386, 1.6413);
	PlayerTextDrawTextSize(playerid, playerTD[7], 0.0000, 96.0000);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[7], -636415489);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 255);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);

	// Бензина
	playerTD[8] = CreatePlayerTextDraw(playerid, 603.0000, 403.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.2386, 1.6413);
	PlayerTextDrawTextSize(playerid, playerTD[8], 0.0000, 96.0000);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[8], 292477695);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 255);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	return 1;
}