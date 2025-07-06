/*
 * |>================================<|
 * |   About: TDM classes textdraws   |
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
	- TDM_CreatePlayerSelectClassTD(playerid, PlayerText:playerTD[])
	- TDM_CreatePlayerSelectedClassTD(playerid, PlayerText:playerTD[])
	- TDM_CreatePlClassSelectWeaponTD(playerid, PlayerText:playerTD[])
	- TDM_CreatePlayerClassBuyItemsTD(playerid, PlayerText:playerTD[])
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_TDM_CLASSES_TD
	#endinput
#endif
#define _INC_TDM_CLASSES_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define TDM_TD_SELECT_CLASS			(21)
#define TDM_TD_SELECTED_CLASS		(27)
#define TDM_TD_CLASS_SELECT_WEAPON	(16)
#define TDM_TD_CLASS_BUY_ITEMS		(23)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>----------------<|
 * |   Select class   |
 * |>----------------<|
 */

stock TDM_CreatePlayerSelectClassTD(playerid, PlayerText:playerTD[])
{
	// Задний белый фон
	playerTD[0] = CreatePlayerTextDraw(playerid, 158.0000, 176.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[0], 77.0000, 104.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон
	playerTD[1] = CreatePlayerTextDraw(playerid, 238.0000, 176.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[1], 77.0000, 104.0000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон
	playerTD[2] = CreatePlayerTextDraw(playerid, 318.0000, 176.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[2], 77.0000, 104.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[2], false);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон
	playerTD[3] = CreatePlayerTextDraw(playerid, 398.0000, 176.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[3], 77.0000, 104.0000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон
	playerTD[4] = CreatePlayerTextDraw(playerid, 159.0000, 177.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[4], 75.0000, 102.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 589505535);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[4], false);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон
	playerTD[5] = CreatePlayerTextDraw(playerid, 239.0000, 177.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[5], 75.0000, 102.0000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 589505535);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[5], false);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[5], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[5], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[5], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон
	playerTD[6] = CreatePlayerTextDraw(playerid, 319.0000, 177.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[6], 75.0000, 102.0000);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 589505535);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[6], false);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[6], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[6], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[6], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон
	playerTD[7] = CreatePlayerTextDraw(playerid, 399.0000, 177.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[7], 75.0000, 102.0000);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 589505535);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[7], false);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[7], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[7], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[7], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон выбора класса
	playerTD[8] = CreatePlayerTextDraw(playerid, 158.0000, 158.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[8], 317.0000, 15.0000);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 589505535);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[8], false);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[8], 287);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[8], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[9] = CreatePlayerTextDraw(playerid, 316.0000, 158.0000, "Выбор_класса");
	PlayerTextDrawLetterSize(playerid, playerTD[9], 0.3010, 1.4797);
	PlayerTextDrawTextSize(playerid, playerTD[9], 0.0000, 313.0000);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[9], -33686529);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 255);
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[9], true);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);

	// Задний белый фон назад
	playerTD[10] = CreatePlayerTextDraw(playerid, 158.0000, 282.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[10], 53.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[10], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[10], false);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[10], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[10], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон назад
	playerTD[11] = CreatePlayerTextDraw(playerid, 159.0000, 283.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[11], 51.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 589505535);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[11], false);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[11], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[11], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[11], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[12] = CreatePlayerTextDraw(playerid, 185.0000, 285.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, playerTD[12], 0.2796, 1.3552);
	PlayerTextDrawTextSize(playerid, playerTD[12], 15.0000, 50.0000);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[12], -1003277313);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 255);
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[12], true);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[12], true);

	playerTD[13] = CreatePlayerTextDraw(playerid, 161.0000, 176.0000, "Штурмовик");
	PlayerTextDrawLetterSize(playerid, playerTD[13], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[13], -690563841);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 255);
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[13], true);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);

	playerTD[14] = CreatePlayerTextDraw(playerid, 241.0000, 176.0000, "Медик");
	PlayerTextDrawLetterSize(playerid, playerTD[14], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], -690563841);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 255);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[14], true);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);

	playerTD[15] = CreatePlayerTextDraw(playerid, 321.0000, 176.0000, "Инженер");
	PlayerTextDrawLetterSize(playerid, playerTD[15], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[15], -690563841);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], 255);
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[15], true);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);

	playerTD[16] = CreatePlayerTextDraw(playerid, 401.0000, 176.0000, "Разведчик");
	PlayerTextDrawLetterSize(playerid, playerTD[16], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[16], -690563841);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], 255);
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[16], true);
	PlayerTextDrawSetShadow(playerid, playerTD[16], 0);

	playerTD[17] = CreatePlayerTextDraw(playerid, 231.0000, 265.0000, "Часов:_0");
	PlayerTextDrawLetterSize(playerid, playerTD[17], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD[17], -1108345857);
	PlayerTextDrawBackgroundColour(playerid, playerTD[17], 255);
	PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[17], true);
	PlayerTextDrawSetShadow(playerid, playerTD[17], 0);

	playerTD[18] = CreatePlayerTextDraw(playerid, 311.0000, 265.0000, "Часов:_0");
	PlayerTextDrawLetterSize(playerid, playerTD[18], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD[18], -1108345857);
	PlayerTextDrawBackgroundColour(playerid, playerTD[18], 255);
	PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[18], true);
	PlayerTextDrawSetShadow(playerid, playerTD[18], 0);

	playerTD[19] = CreatePlayerTextDraw(playerid, 391.0000, 265.0000, "Часов:_0");
	PlayerTextDrawLetterSize(playerid, playerTD[19], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, playerTD[19], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD[19], -1108345857);
	PlayerTextDrawBackgroundColour(playerid, playerTD[19], 255);
	PlayerTextDrawFont(playerid, playerTD[19], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[19], true);
	PlayerTextDrawSetShadow(playerid, playerTD[19], 0);

	playerTD[20] = CreatePlayerTextDraw(playerid, 471.0000, 265.0000, "Часов:_0");
	PlayerTextDrawLetterSize(playerid, playerTD[20], 0.1783, 1.3594);
	PlayerTextDrawAlignment(playerid, playerTD[20], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD[20], -1108345857);
	PlayerTextDrawBackgroundColour(playerid, playerTD[20], 255);
	PlayerTextDrawFont(playerid, playerTD[20], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[20], true);
	PlayerTextDrawSetShadow(playerid, playerTD[20], 0);
	return 1;
}

/*
 * |>------------------<|
 * |   Selected class   |
 * |>------------------<|
 */

stock TDM_CreatePlayerSelectedClassTD(playerid, PlayerText:playerTD[])
{
	// Задний белый фон
	playerTD[0] = CreatePlayerTextDraw(playerid, 271.0000, 131.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[0], 100.0000, 108.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон
	playerTD[1] = CreatePlayerTextDraw(playerid, 272.0000, 132.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[1], 98.0000, 106.0000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 303174399);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[1], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 287);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1.0000);

	// Название класса
	playerTD[2] = CreatePlayerTextDraw(playerid, 275.0000, 131.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.1746, 1.4795);
	PlayerTextDrawTextSize(playerid, playerTD[2], -73.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);

	// Задний зелёный фон шлем
	playerTD[3] = CreatePlayerTextDraw(playerid, 374.0000, 131.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[3], 26.0000, 29.0000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], -2136582657);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон шлема
	playerTD[4] = CreatePlayerTextDraw(playerid, 375.0000, 132.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[4], 24.0000, 27.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 303174399);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[4], false);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 19141);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, -90.0000, 0.0000, 1.0000);

	// Задний зелёный фон брон
	playerTD[5] = CreatePlayerTextDraw(playerid, 374.0000, 163.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[5], 26.0000, 29.0000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], -2136582657);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[5], false);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[5], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[5], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон брони
	playerTD[6] = CreatePlayerTextDraw(playerid, 375.0000, 164.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[6], 24.0000, 27.0000);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 303174399);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[6], false);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[6], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[6], 1242);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[6], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний жёлтый фон покупки
	playerTD[7] = CreatePlayerTextDraw(playerid, 271.0000, 242.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[7], 100.0000, 52.0000);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], -1500686849);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[7], false);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[7], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[7], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон покупки
	playerTD[8] = CreatePlayerTextDraw(playerid, 272.0000, 243.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[8], 98.0000, 50.0000);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 303174399);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[8], false);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[8], 287);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[8], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Оружие 1
	playerTD[9] = CreatePlayerTextDraw(playerid, 274.0000, 245.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[9], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], -1466330369);
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[9], false);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[9], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[9], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[9], 0.0000, 30.0000, 160.0000, 1.2999);

	// Оружие 2
	playerTD[10] = CreatePlayerTextDraw(playerid, 298.0000, 245.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[10], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[10], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], -1466330369);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[10], false);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[10], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[10], 348);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[10], 0.0000, 30.0000, 160.0000, 1.1000);

	// Оружие 3
	playerTD[11] = CreatePlayerTextDraw(playerid, 322.0000, 245.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[11], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], -1466330369);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[11], false);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[11], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[11], 342);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[11], 0.0000, -30.0000, 50.0000, 0.5000);

	// Оружие 4
	playerTD[12] = CreatePlayerTextDraw(playerid, 346.0000, 245.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[12], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[12], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], -1466330369);
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[12], false);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[12], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[12], 335);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[12], 0.0000, -30.0000, 0.6998, 0.8999);

	// Патроны 1
	playerTD[13] = CreatePlayerTextDraw(playerid, 274.0000, 269.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[13], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], -1367909889);
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[13], false);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[13], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[13], 2061);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[13], 0.0000, 0.0000, 0.0000, 1.2999);

	// Патроны 2
	playerTD[14] = CreatePlayerTextDraw(playerid, 298.0000, 269.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[14], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], -1367909889);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[14], false);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[14], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[14], 2061);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[14], 0.0000, 0.0000, 0.0000, 1.2999);

	// Патроны 3
	playerTD[15] = CreatePlayerTextDraw(playerid, 322.0000, 269.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[15], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[15], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], -1367909889);
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[15], false);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[15], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[15], 2061);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[15], 0.0000, 0.0000, 0.0000, 1.2999);

	// Патроны 4
	playerTD[16] = CreatePlayerTextDraw(playerid, 346.0000, 269.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[16], 22.0000, 22.0000);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[16], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], -1367909889);
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[16], false);
	PlayerTextDrawSetShadow(playerid, playerTD[16], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[16], false);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[16], 2061);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[16], 0.0000, 0.0000, 0.0000, 1.2999);

	// Кол-во патронов 1
	playerTD[17] = CreatePlayerTextDraw(playerid, 285.0000, 268.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[17], 0.1726, 1.0317);
	PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[17], -320017665);
	PlayerTextDrawBackgroundColour(playerid, playerTD[17], 255);
	PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[17], true);
	PlayerTextDrawSetShadow(playerid, playerTD[17], 0);

	// Кол-во патронов 2
	playerTD[18] = CreatePlayerTextDraw(playerid, 309.0000, 268.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[18], 0.1726, 1.0317);
	PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[18], -320017665);
	PlayerTextDrawBackgroundColour(playerid, playerTD[18], 255);
	PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[18], true);
	PlayerTextDrawSetShadow(playerid, playerTD[18], 0);

	// Кол-во патронов 3
	playerTD[19] = CreatePlayerTextDraw(playerid, 333.0000, 268.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[19], 0.1726, 1.0317);
	PlayerTextDrawAlignment(playerid, playerTD[19], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[19], -320017665);
	PlayerTextDrawBackgroundColour(playerid, playerTD[19], 255);
	PlayerTextDrawFont(playerid, playerTD[19], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[19], true);
	PlayerTextDrawSetShadow(playerid, playerTD[19], 0);

	// Кол-во патронов 4
	playerTD[20] = CreatePlayerTextDraw(playerid, 357.0000, 268.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[20], 0.1726, 1.0317);
	PlayerTextDrawAlignment(playerid, playerTD[20], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[20], -320017665);
	PlayerTextDrawBackgroundColour(playerid, playerTD[20], 255);
	PlayerTextDrawFont(playerid, playerTD[20], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[20], true);
	PlayerTextDrawSetShadow(playerid, playerTD[20], 0);

	// Задний белый фон назад
	playerTD[21] = CreatePlayerTextDraw(playerid, 271.0000, 297.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[21], 49.0000, 19.0000);
	PlayerTextDrawAlignment(playerid, playerTD[21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[21], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[21], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[21], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[21], false);
	PlayerTextDrawSetShadow(playerid, playerTD[21], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[21], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[21], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон назад
	playerTD[22] = CreatePlayerTextDraw(playerid, 272.0000, 298.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[22], 47.0000, 17.0000);
	PlayerTextDrawAlignment(playerid, playerTD[22], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[22], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[22], 303174399);
	PlayerTextDrawFont(playerid, playerTD[22], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[22], false);
	PlayerTextDrawSetShadow(playerid, playerTD[22], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[22], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[22], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[22], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[23] = CreatePlayerTextDraw(playerid, 296.0000, 298.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, playerTD[23], 0.2293, 1.6663);
	PlayerTextDrawTextSize(playerid, playerTD[23], 15.0000, 46.0000);
	PlayerTextDrawAlignment(playerid, playerTD[23], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[23], -63621633);
	PlayerTextDrawBackgroundColour(playerid, playerTD[23], 255);
	PlayerTextDrawFont(playerid, playerTD[23], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[23], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[23], true);
	PlayerTextDrawSetShadow(playerid, playerTD[23], 0);

	// Задний белый фон выбрать
	playerTD[24] = CreatePlayerTextDraw(playerid, 322.0000, 297.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[24], 49.0000, 19.0000);
	PlayerTextDrawAlignment(playerid, playerTD[24], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[24], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[24], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[24], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[24], false);
	PlayerTextDrawSetShadow(playerid, playerTD[24], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[24], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[24], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон выбрать
	playerTD[25] = CreatePlayerTextDraw(playerid, 323.0000, 298.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[25], 47.0000, 17.0000);
	PlayerTextDrawAlignment(playerid, playerTD[25], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[25], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[25], 303174399);
	PlayerTextDrawFont(playerid, playerTD[25], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[25], false);
	PlayerTextDrawSetShadow(playerid, playerTD[25], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[25], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[25], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[25], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[26] = CreatePlayerTextDraw(playerid, 347.0000, 298.0000, "Выбрать");
	PlayerTextDrawLetterSize(playerid, playerTD[26], 0.2293, 1.6663);
	PlayerTextDrawTextSize(playerid, playerTD[26], 15.0000, 46.0000);
	PlayerTextDrawAlignment(playerid, playerTD[26], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[26], -55888385);
	PlayerTextDrawBackgroundColour(playerid, playerTD[26], 255);
	PlayerTextDrawFont(playerid, playerTD[26], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetSelectable(playerid, playerTD[26], true);
	PlayerTextDrawSetProportional(playerid, playerTD[26], true);
	PlayerTextDrawSetShadow(playerid, playerTD[26], 0);
	return 1;
}

/*
 * |>-----------------<|
 * |   Select weapon   |
 * |>-----------------<|
 */

stock TDM_CreatePlClassSelectWeaponTD(playerid, PlayerText:playerTD[])
{
	// Задний белый фон 
	playerTD[0] = CreatePlayerTextDraw(playerid, 190.0000, 191.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[0], 80.0000, 69.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Задний белый фон 2
	playerTD[1] = CreatePlayerTextDraw(playerid, 273.0000, 191.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[1], 80.0000, 69.0000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Задний белый фон 3
	playerTD[2] = CreatePlayerTextDraw(playerid, 356.0000, 191.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[2], 80.0000, 69.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[2], false);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[2], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[2], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Задний чёрный фон 1
	playerTD[3] = CreatePlayerTextDraw(playerid, 191.0000, 192.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[3], 78.0000, 67.0000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 589505535);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[3], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 70.0000, 2.0000);

	// Задний чёрный фон 2
	playerTD[4] = CreatePlayerTextDraw(playerid, 274.0000, 192.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[4], 78.0000, 67.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 589505535);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[4], false);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 70.0000, 2.0000);

	// Задний чёрный фон 3
	playerTD[5] = CreatePlayerTextDraw(playerid, 357.0000, 192.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[5], 78.0000, 67.0000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 589505535);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[5], false);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[5], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[5], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[5], 0.0000, 0.0000, 70.0000, 2.0000);

	// Кол-во необходимых убийств / название оружия 1
	playerTD[6] = CreatePlayerTextDraw(playerid, 230.0000, 237.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.1546, 1.0317);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[6], -505290753);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);

	// Кол-во необходимых убийств / название оружия 2
	playerTD[7] = CreatePlayerTextDraw(playerid, 313.0000, 237.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.1546, 1.0317);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[7], -79740929);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 255);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);

	// Кол-во необходимых убийств / название оружия 3
	playerTD[8] = CreatePlayerTextDraw(playerid, 397.0000, 237.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.1546, 1.0317);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[8], -79740929);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 255);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);

	// Задний чёрный фон выбор
	playerTD[9] = CreatePlayerTextDraw(playerid, 190.0000, 170.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[9], 246.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 589505535);
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[9], false);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[9], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[9], 0.0000, 0.0000, 70.0000, 1000.0000);

	playerTD[10] = CreatePlayerTextDraw(playerid, 312.0000, 171.0000, "Выбор_оружия");
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.3426, 1.5834);
	PlayerTextDrawTextSize(playerid, playerTD[10], 0.0000, 233.0000);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[10], -909522945);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 255);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);

	// Задний чёрный фон убийств
	playerTD[11] = CreatePlayerTextDraw(playerid, 190.0000, 263.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[11], 246.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 589505535);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[11], false);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[11], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[11], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Кол-во убийств
	playerTD[12] = CreatePlayerTextDraw(playerid, 193.0000, 265.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[12], 0.2823, 1.3967);
	PlayerTextDrawTextSize(playerid, playerTD[12], 233.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[12], 919041791);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], -952879873);
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[12], true);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);

	// Задний белый фон назад
	playerTD[13] = CreatePlayerTextDraw(playerid, 190.0000, 284.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[13], 43.0000, 18.0000);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[13], false);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[13], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[13], 0.0000, 0.0000, 70.0000, 1000.0000);

	// Задний чёрный фон назад
	playerTD[14] = CreatePlayerTextDraw(playerid, 191.0000, 285.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[14], 41.0000, 16.0000);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 589505535);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[14], false);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[14], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[14], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[14], 0.0000, 0.0000, 70.0000, 1000.0000);

	playerTD[15] = CreatePlayerTextDraw(playerid, 212.0000, 286.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, playerTD[15], 0.2216, 1.4008);
	PlayerTextDrawTextSize(playerid, playerTD[15], 15.0000, 40.0000);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[15], -952879873);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], -952879873);
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetSelectable(playerid, playerTD[15], true);
	PlayerTextDrawSetProportional(playerid, playerTD[15], true);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);
	return 1;
}

/*
 * |>-------------------<|
 * |   Buy items class   |
 * |>-------------------<|
 */

stock TDM_CreatePlayerClassBuyItemsTD(playerid, PlayerText:playerTD[])
{
	// Задний белый фон 1
	playerTD[0] = CreatePlayerTextDraw(playerid, 170.0000, 201.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[0], 70.0000, 66.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон 2
	playerTD[1] = CreatePlayerTextDraw(playerid, 243.0000, 201.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[1], 70.0000, 66.0000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон 3
	playerTD[2] = CreatePlayerTextDraw(playerid, 316.0000, 201.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[2], 70.0000, 66.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[2], false);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон 4
	playerTD[3] = CreatePlayerTextDraw(playerid, 389.0000, 201.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[3], 70.0000, 66.0000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон 1
	playerTD[4] = CreatePlayerTextDraw(playerid, 171.0000, 202.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[4], 68.0000, 64.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 589505535);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[4], false);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон 2
	playerTD[5] = CreatePlayerTextDraw(playerid, 244.0000, 202.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[5], 68.0000, 64.0000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 589505535);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[5], false);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[5], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[5], 19141);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[5], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон 3
	playerTD[6] = CreatePlayerTextDraw(playerid, 317.0000, 202.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[6], 68.0000, 64.0000);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 589505535);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[6], false);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[6], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[6], 19141);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[6], 0.0000, 0.0000, 0.0000, 1.0000);

	// Задний чёрный фон 4
	playerTD[7] = CreatePlayerTextDraw(playerid, 390.0000, 202.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[7], 68.0000, 64.0000);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 589505535);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[7], false);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[7], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[7], 19141);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[7], 0.0000, 0.0000, 0.0000, 1.0000);

	playerTD[8] = CreatePlayerTextDraw(playerid, 205.0000, 202.0000, "Ничего");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, playerTD[8], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[8], -656877825);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 255);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);

	playerTD[9] = CreatePlayerTextDraw(playerid, 278.0000, 202.0000, "1_класс");
	PlayerTextDrawLetterSize(playerid, playerTD[9], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, playerTD[9], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[9], -656877825);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 255);
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[9], true);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);

	playerTD[10] = CreatePlayerTextDraw(playerid, 351.0000, 202.0000, "2_класс");
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, playerTD[10], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[10], -656877825);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 255);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);

	playerTD[11] = CreatePlayerTextDraw(playerid, 424.0000, 202.0000, "3_класс");
	PlayerTextDrawLetterSize(playerid, playerTD[11], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, playerTD[11], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[11], -656877825);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 255);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[11], true);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);

	// Цена 1
	playerTD[12] = CreatePlayerTextDraw(playerid, 205.0000, 252.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[12], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, playerTD[12], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[12], -651613697);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 255);
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[12], true);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);

	// Цена 2
	playerTD[13] = CreatePlayerTextDraw(playerid, 278.0000, 252.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[13], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, playerTD[13], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[13], -651613697);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 255);
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[13], true);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);

	// Цена 3
	playerTD[14] = CreatePlayerTextDraw(playerid, 351.0000, 252.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[14], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, playerTD[14], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[14], -651613697);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 255);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[14], true);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);

	// Цена 4
	playerTD[15] = CreatePlayerTextDraw(playerid, 424.0000, 252.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[15], 0.2373, 1.3386);
	PlayerTextDrawTextSize(playerid, playerTD[15], 0.0000, 61.0000);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[15], -651613697);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], 255);
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[15], true);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);

	// Задний чёрный фон выбора
	playerTD[16] = CreatePlayerTextDraw(playerid, 170.0000, 184.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[16], 289.0000, 14.0000);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[16], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], 589505535);
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[16], false);
	PlayerTextDrawSetShadow(playerid, playerTD[16], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[16], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[16], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Выбор чего-то
	playerTD[17] = CreatePlayerTextDraw(playerid, 314.0000, 182.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[17], 0.3356, 1.6580);
	PlayerTextDrawTextSize(playerid, playerTD[17], 0.0000, 278.0000);
	PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[17], -741092865);
	PlayerTextDrawBackgroundColour(playerid, playerTD[17], 255);
	PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[17], true);
	PlayerTextDrawSetShadow(playerid, playerTD[17], 0);

	// Задний чёрный фон денег
	playerTD[18] = CreatePlayerTextDraw(playerid, 170.0000, 270.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[18], 289.0000, 15.0000);
	PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[18], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[18], 589505535);
	PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[18], false);
	PlayerTextDrawSetShadow(playerid, playerTD[18], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[18], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[18], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кол-во денег
	playerTD[19] = CreatePlayerTextDraw(playerid, 173.0000, 269.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[19], 0.3356, 1.6580);
	PlayerTextDrawTextSize(playerid, playerTD[19], 278.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[19], 952579071);
	PlayerTextDrawBackgroundColour(playerid, playerTD[19], 255);
	PlayerTextDrawFont(playerid, playerTD[19], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[19], true);
	PlayerTextDrawSetShadow(playerid, playerTD[19], 0);

	// Задний белый фон назад
	playerTD[20] = CreatePlayerTextDraw(playerid, 170.0000, 288.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[20], 42.0000, 17.0000);
	PlayerTextDrawAlignment(playerid, playerTD[20], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[20], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[20], -1717986817);
	PlayerTextDrawFont(playerid, playerTD[20], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[20], false);
	PlayerTextDrawSetShadow(playerid, playerTD[20], 0);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[20], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[20], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон назад
	playerTD[21] = CreatePlayerTextDraw(playerid, 171.0000, 289.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[21], 40.0000, 15.0000);
	PlayerTextDrawAlignment(playerid, playerTD[21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[21], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[21], 589505535);
	PlayerTextDrawFont(playerid, playerTD[21], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[21], false);
	PlayerTextDrawSetShadow(playerid, playerTD[21], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[21], true);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[21], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[21], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[22] = CreatePlayerTextDraw(playerid, 191.0000, 289.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, playerTD[22], 0.2163, 1.4465);
	PlayerTextDrawTextSize(playerid, playerTD[22], 15.0000, 40.0000);
	PlayerTextDrawAlignment(playerid, playerTD[22], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[22], -952945409);
	PlayerTextDrawBackgroundColour(playerid, playerTD[22], 255);
	PlayerTextDrawFont(playerid, playerTD[22], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[22], true);
	PlayerTextDrawSetShadow(playerid, playerTD[22], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[22], true);
	return 1;
}