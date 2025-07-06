/*
 * |>=====================================<|
 * |   About: Trading-platform textdraws   |
 * |   Author: Foxze                       |
 * |>=====================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- CreatePlayerTPSelectCategoryTD(playerid, PlayerText:playerTD[])
	- CreatePlayerTPSelectPageTD(playerid, PlayerText:playerTD[])
	- CreatePlayerTPBlocksTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, const blockName[], &tdid)
	- CreatePlayerTPItemTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:sprite, tdid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_TRADING_PLATFORM_TD
	#endinput
#endif
#define _INC_TRADING_PLATFORM_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define TRAD_PLAT_TD_SELECT_CATEGORY	(23)
#define TRAD_PLAT_TD_SELECT_PAGE		(8)
#define TRAD_PLAT_TD_BLOCKS				(20)
#define TRAD_PLAT_TD_ITEM				(18)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>-------------------<|
 * |   Select category   |
 * |>-------------------<|
 */

stock CreatePlayerTPSelectCategoryTD(playerid, PlayerText:playerTD[])
{
	// Основной задний фон
	playerTD[0] = CreatePlayerTextDraw(playerid, 154.0000, 103.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.0000, 29.6331);
	PlayerTextDrawTextSize(playerid, playerTD[0], 476.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], 606348543);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);

	// Задний фон торг. пл.
	playerTD[1] = CreatePlayerTextDraw(playerid, 154.0000, 103.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.0000, 1.2661);
	PlayerTextDrawTextSize(playerid, playerTD[1], 476.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawUseBox(playerid, playerTD[1], true);
	PlayerTextDrawBoxColour(playerid, playerTD[1], 336860415);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 255);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);

	playerTD[2] = CreatePlayerTextDraw(playerid, 315.0000, 102.0000, "Торговая_площадка");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.3025, 1.2640);
	PlayerTextDrawTextSize(playerid, playerTD[2], 0.0000, 463.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[2], -1431656193);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);

	// Задний чёрный фон головы
	playerTD[3] = CreatePlayerTextDraw(playerid, 199.0000, 140.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 808464639);
	PlayerTextDrawSetSelectable(playerid, playerTD[3], true);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawTextSize(playerid, playerTD[3], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 19137);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 50.0000, -130.0000, 70.0000, 1.0000);

	playerTD[4] = CreatePlayerTextDraw(playerid, 200.0000, 139.0000, "Голова");
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 255);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);

	// Задний чёрный фон наушников
	playerTD[5] = CreatePlayerTextDraw(playerid, 279.0000, 140.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 808464639);
	PlayerTextDrawSetSelectable(playerid, playerTD[5], true);
	PlayerTextDrawSetProportional(playerid, playerTD[5], false);
	PlayerTextDrawTextSize(playerid, playerTD[5], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[5], 19421);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[5], 100.0000, 30.0000, 0.0000, 1.0000);

	playerTD[6] = CreatePlayerTextDraw(playerid, 280.0000, 139.0000, "Наушники");
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);

	// Задний чёрный фон очков
	playerTD[7] = CreatePlayerTextDraw(playerid, 359.0000, 140.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 808464639);
	PlayerTextDrawSetSelectable(playerid, playerTD[7], true);
	PlayerTextDrawSetProportional(playerid, playerTD[7], false);
	PlayerTextDrawTextSize(playerid, playerTD[7], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[7], 19010);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[7], 0.0000, 0.0000, 60.0000, 1.0000);

	playerTD[8] = CreatePlayerTextDraw(playerid, 360.0000, 139.0000, "Очки");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[8], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 255);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);

	// Задний чёрный фон масков
	playerTD[9] = CreatePlayerTextDraw(playerid, 199.0000, 213.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 808464639);
	PlayerTextDrawSetSelectable(playerid, playerTD[9], true);
	PlayerTextDrawSetProportional(playerid, playerTD[9], false);
	PlayerTextDrawTextSize(playerid, playerTD[9], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[9], 18918);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[9], 120.0000, 160.0000, 0.0000, 1.0000);

	playerTD[10] = CreatePlayerTextDraw(playerid, 200.0000, 212.0000, "Маски");
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[10], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 255);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);

	// Задний чёрный фон часов
	playerTD[11] = CreatePlayerTextDraw(playerid, 279.0000, 213.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 808464639);
	PlayerTextDrawSetSelectable(playerid, playerTD[11], true);
	PlayerTextDrawSetProportional(playerid, playerTD[11], false);
	PlayerTextDrawTextSize(playerid, playerTD[11], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[11], 19039);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[11], 20.0000, 0.0000, 10.0000, 1.0000);

	playerTD[12] = CreatePlayerTextDraw(playerid, 280.0000, 212.0000, "Часы"); 
	PlayerTextDrawLetterSize(playerid, playerTD[12], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[12], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 255);
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[12], true);

	// Задний чёрный фон скинов
	playerTD[13] = CreatePlayerTextDraw(playerid, 359.0000, 213.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 808464639);
	PlayerTextDrawSetSelectable(playerid, playerTD[13], true);
	PlayerTextDrawSetProportional(playerid, playerTD[13], false);
	PlayerTextDrawTextSize(playerid, playerTD[13], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[13], 294);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[13], 10.0000, 0.0000, -20.0000, 1.0000);

	playerTD[14] = CreatePlayerTextDraw(playerid, 360.0000, 212.0000, "Скины");
	PlayerTextDrawLetterSize(playerid, playerTD[14], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 255);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[14], true);

	// Задний чёрный фон кейсов
	playerTD[15] = CreatePlayerTextDraw(playerid, 240.0000, 285.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[15], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], 808464639);
	PlayerTextDrawSetSelectable(playerid, playerTD[15], true);
	PlayerTextDrawSetProportional(playerid, playerTD[15], false);
	PlayerTextDrawTextSize(playerid, playerTD[15], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[15], 964);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[15], -30.0000, 0.0000, -30.0000, 1.2000);

	playerTD[16] = CreatePlayerTextDraw(playerid, 241.0000, 284.0000, "Кейсы");
	PlayerTextDrawLetterSize(playerid, playerTD[16], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[16], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], 255);
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[16], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[16], true);

	// Задний чёрный фон баннеров
	playerTD[17] = CreatePlayerTextDraw(playerid, 321.0000, 285.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[17], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[17], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[17], 808464639);
	PlayerTextDrawSetSelectable(playerid, playerTD[17], true);
	PlayerTextDrawSetProportional(playerid, playerTD[17], false);
	PlayerTextDrawTextSize(playerid, playerTD[17], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[17], 964);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[17], -30.0000, 0.0000, -30.0000, 1000.0000);

	playerTD[18] = CreatePlayerTextDraw(playerid, 322.0000, 284.0000, "Баннеры");
	PlayerTextDrawLetterSize(playerid, playerTD[18], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[18], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[18], 255);
	PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[18], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[18], true);

	// Спрайт баннеров
	playerTD[19] = CreatePlayerTextDraw(playerid, 327.0000, 300.0000, "ld_shtr:ship");
	PlayerTextDrawTextSize(playerid, playerTD[19], 62.0000, 44.0000);
	PlayerTextDrawAlignment(playerid, playerTD[19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[19], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[19], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[19], 255);
	PlayerTextDrawFont(playerid, playerTD[19], TEXT_DRAW_FONT_SPRITE);
	PlayerTextDrawSetProportional(playerid, playerTD[19], false);

	// Задний белый фон назад
	playerTD[20] = CreatePlayerTextDraw(playerid, 154.0000, 351.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[20], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[20], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[20], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[20], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[20], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[20], false);
	PlayerTextDrawTextSize(playerid, playerTD[20], 42.0000, 19.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[20], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[20], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон назад
	playerTD[21] = CreatePlayerTextDraw(playerid, 155.0000, 352.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[21], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[21], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[21], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[21], 589505535);
	PlayerTextDrawSetSelectable(playerid, playerTD[21], true);
	PlayerTextDrawSetProportional(playerid, playerTD[21], false);
	PlayerTextDrawTextSize(playerid, playerTD[21], 40.0000, 17.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[21], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[21], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[22] = CreatePlayerTextDraw(playerid, 175.0000, 353.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, playerTD[22], 0.2293, 1.3594);
	PlayerTextDrawTextSize(playerid, playerTD[22], 15.0000, 40.0000);
	PlayerTextDrawAlignment(playerid, playerTD[22], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[22], -953010945);
	PlayerTextDrawBackgroundColour(playerid, playerTD[22], 255);
	PlayerTextDrawFont(playerid, playerTD[22], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[22], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[22], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[22], true);
	return 1;
}

/*
 * |>---------------<|
 * |   Select page   |
 * |>---------------<|
 */

stock CreatePlayerTPSelectPageTD(playerid, PlayerText:playerTD[])
{
	// Основной задний фон
	playerTD[0] = CreatePlayerTextDraw(playerid, 155.0000, 120.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.0000, 25.2999);
	PlayerTextDrawTextSize(playerid, playerTD[0], 475.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], 606348543);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);

	// Задний фон торг. пл.
	playerTD[1] = CreatePlayerTextDraw(playerid, 155.0000, 120.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.0000, 1.2665);
	PlayerTextDrawTextSize(playerid, playerTD[1], 475.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawUseBox(playerid, playerTD[1], true);
	PlayerTextDrawBoxColour(playerid, playerTD[1], 336860415);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 255);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);

	playerTD[2] = CreatePlayerTextDraw(playerid, 316.0000, 119.0000, "Торговая площадка");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.3026, 1.2640);
	PlayerTextDrawTextSize(playerid, playerTD[2], 0.0000, 463.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[2], -1431656193);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);

	// Задний фон блоков
	playerTD[3] = CreatePlayerTextDraw(playerid, 155.0000, 150.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[3], 0.0000, 21.9665);
	PlayerTextDrawTextSize(playerid, playerTD[3], 226.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawUseBox(playerid, playerTD[3], true);
	PlayerTextDrawBoxColour(playerid, playerTD[3], 336860415);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 255);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[3], true);

	// Меню - куда
	playerTD[4] = CreatePlayerTextDraw(playerid, 154.0000, 135.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.1753, 1.2142);
	PlayerTextDrawTextSize(playerid, playerTD[4], 225.0000, 10.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xc73234FF);
	PlayerTextDrawUseBox(playerid, playerTD[4], true);
	PlayerTextDrawBoxColour(playerid, playerTD[4], 0);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);

	// Далее
	playerTD[5] = CreatePlayerTextDraw(playerid, 460.0000, 333.0000, ">");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.4000, 1.6000);
	PlayerTextDrawTextSize(playerid, playerTD[5], 474.3332, 10.0000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], -1212697089);
	PlayerTextDrawUseBox(playerid, playerTD[5], true);
	PlayerTextDrawBoxColour(playerid, playerTD[5], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[5], true);

	// Кол-во страниц
	playerTD[6] = CreatePlayerTextDraw(playerid, 440.0000, 334.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.2966, 1.3759);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[6], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);

	// Назад
	playerTD[7] = CreatePlayerTextDraw(playerid, 409.0000, 333.0000, "<");
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.4000, 1.6000);
	PlayerTextDrawTextSize(playerid, playerTD[7], 422.0000, 10.0000);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], -1212697089);
	PlayerTextDrawUseBox(playerid, playerTD[7], true);
	PlayerTextDrawBoxColour(playerid, playerTD[7], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 255);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[7], true);
	return 1;
}

/*
 * |>----------<|
 * |   Blocks   |
 * |>----------<|
 */

stock CreatePlayerTPBlocksTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, const blockName[], &tdid)
{
	// Click
	playerTD[tdid] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[tdid], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 757935615);
	PlayerTextDrawSetSelectable(playerid, playerTD[tdid], true);
	PlayerTextDrawSetProportional(playerid, playerTD[tdid], false);
	PlayerTextDrawTextSize(playerid, playerTD[tdid], 71.0000, 15.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[tdid], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[tdid], 0.0000, 0.0000, 0.0000, 1000.0000);
	tdid++;

	// Name
	playerTD[tdid] = CreatePlayerTextDraw(playerid, posX + 1.0, posY, blockName);
	PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.2033, 1.4133);
	PlayerTextDrawTextSize(playerid, playerTD[tdid], -16.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[tdid], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
	PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
	tdid++;
	return 1;
}

/*
 * |>--------<|
 * |   Item   |
 * |>--------<|
 */

stock CreatePlayerTPItemTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:sprite, tdid)
{
	// Click
	playerTD[tdid] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[tdid], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 1111638783);
	PlayerTextDrawSetSelectable(playerid, playerTD[tdid], true);
	PlayerTextDrawSetProportional(playerid, playerTD[tdid], false);
	PlayerTextDrawTextSize(playerid, playerTD[tdid], 78.0000, 78.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[tdid], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[tdid], 0.0, 0.0, 0.0, 1000.0000);

	// Price
	playerTD[tdid + 1] = CreatePlayerTextDraw(playerid, posX + 77.0, posY + 67.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[tdid + 1], 0.1592, 1.0399);
	PlayerTextDrawAlignment(playerid, playerTD[tdid + 1], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD[tdid + 1], 142945535);
	PlayerTextDrawBackgroundColour(playerid, playerTD[tdid + 1], 255);
	PlayerTextDrawFont(playerid, playerTD[tdid + 1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[tdid + 1], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[tdid + 1], true);

	if (sprite) {
		// Sprite
		playerTD[tdid + 2] = CreatePlayerTextDraw(playerid, posX + 3.0, posY + 3.0, "_");
		PlayerTextDrawTextSize(playerid, playerTD[tdid + 2], 72.0000, 60.0000);
		PlayerTextDrawAlignment(playerid, playerTD[tdid + 2], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[tdid + 2], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[tdid + 2], 255);
		PlayerTextDrawSetShadow(playerid, playerTD[tdid + 2], 0);
		PlayerTextDrawFont(playerid, playerTD[tdid + 2], TEXT_DRAW_FONT_SPRITE);
		PlayerTextDrawSetProportional(playerid, playerTD[tdid + 2], false);
		PlayerTextDrawShow(playerid, playerTD[tdid + 2]);
	}
	return 1;
}