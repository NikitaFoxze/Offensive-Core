/*
 * |>==============================<|
 * |   About: Inventory textdraws   |
 * |   Author: Foxze                |
 * |>==============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- CreatePlayerInvBaseTD(playerid, PlayerText:playerTD[])
	- CreatePlayerInvCellItemTD(playerid, PlayerText:playerTD[], PlayerText:playerTD2[], Float:posX, Float:posY, tdid)
	- CreatePlayerInvCellBannerTD(playerid, PlayerText:playerTD[], PlayerText:playerTD2[], PlayerText:playerTD3[], Float:posX, Float:posY, tdid)
	- CreatePlayerInvActionCellTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
	- CreatePlayerInvOpenCaseTD(playerid, PlayerText:playerTD[], const caseName[], caseColor)
	- CreatePlayerInvOpeningCaseTD(playerid, PlayerText:playerTD[], const caseName[])
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_INVENTORY_TD
	#endinput
#endif
#define _INC_INVENTORY_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define INVENTORY_TD_BASE			(30)
#define INVENTORY_TD_ACTION_CELL	(5)
#define INVENTORY_TD_OPEN_CASE		(3)
#define INVENTORY_TD_OPENING_CASE	(15)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>--------<|
 * |   Base   |
 * |>--------<|
 */

stock CreatePlayerInvBaseTD(playerid, PlayerText:playerTD[])
{
	playerTD[0] = CreatePlayerTextDraw(playerid, 133.0000, 163.0000, "_"); // Задний чёрный фон персонаж
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.0000, 22.6665);
	PlayerTextDrawTextSize(playerid, playerTD[0], 256.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], 336860413);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);

	playerTD[1] = CreatePlayerTextDraw(playerid, 133.0000, 163.0000, "_"); // Задний фон персонажа
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.0000, 0.7998);
	PlayerTextDrawTextSize(playerid, playerTD[1], 256.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawUseBox(playerid, playerTD[1], true);
	PlayerTextDrawBoxColour(playerid, playerTD[1], 0xd9711cFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);

	playerTD[2] = CreatePlayerTextDraw(playerid, 195.0000, 160.0000, "Персонаж");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.2578, 1.2556);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[2], -286331649);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);

	playerTD[3] = CreatePlayerTextDraw(playerid, 262.0000, 163.0000, "_"); // Задний чёрный фон инвентаря
	PlayerTextDrawLetterSize(playerid, playerTD[3], 0.0000, 25.2665);
	PlayerTextDrawTextSize(playerid, playerTD[3], 477.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawUseBox(playerid, playerTD[3], true);
	PlayerTextDrawBoxColour(playerid, playerTD[3], 336860413);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[3], true);

	playerTD[4] = CreatePlayerTextDraw(playerid, 262.0000, 163.0000, "_"); // Задний фон инвентаря
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.0000, 0.7998);
	PlayerTextDrawTextSize(playerid, playerTD[4], 477.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawUseBox(playerid, playerTD[4], true);
	PlayerTextDrawBoxColour(playerid, playerTD[4], 0xd9711cFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);

	playerTD[5] = CreatePlayerTextDraw(playerid, 370.0000, 160.0000, "Инвентарь (предметы)");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.2578, 1.2556);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[5], -286331649);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);

	playerTD[6] = CreatePlayerTextDraw(playerid, 129.0000, 195.0000, "_"); // Скин
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], -1061109505);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 0x00000000);
	PlayerTextDrawSetProportional(playerid, playerTD[6], false);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawTextSize(playerid, playerTD[6], 137.0000, 160.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[6], 5);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[6], 0.0000, 0.0000, 0.0000, 1.0000);

	playerTD[7] = CreatePlayerTextDraw(playerid, 133.0000, 180.0000, "_"); // Задний чёрный фон головы
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 892613887);
	PlayerTextDrawSetSelectable(playerid, playerTD[7], true);
	PlayerTextDrawSetProportional(playerid, playerTD[7], false);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawTextSize(playerid, playerTD[7], 31.0000, 30.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[7], 19137);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[7], 50.0000, -130.0000, 100.0000, 1.0000);

	playerTD[8] = CreatePlayerTextDraw(playerid, 133.0000, 171.0000, "Голова");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.1473, 0.9693);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[8], -875836929);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);

	playerTD[9] = CreatePlayerTextDraw(playerid, 133.0000, 219.0000, "_"); // Задний чёрный фон наушников
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 892613887);
	PlayerTextDrawSetSelectable(playerid, playerTD[9], true);
	PlayerTextDrawSetProportional(playerid, playerTD[9], false);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawTextSize(playerid, playerTD[9], 31.0000, 30.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[9], 19421);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[9], 100.0000, 30.0000, 0.0000, 1.0000);

	playerTD[10] = CreatePlayerTextDraw(playerid, 133.0000, 210.0000, "Наушники");
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.1473, 0.9693);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[10], -875836929);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);

	playerTD[11] = CreatePlayerTextDraw(playerid, 133.0000, 258.0000, "_"); // Задний чёрный фон очков
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 892613887);
	PlayerTextDrawSetSelectable(playerid, playerTD[11], true);
	PlayerTextDrawSetProportional(playerid, playerTD[11], false);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawTextSize(playerid, playerTD[11], 31.0000, 30.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[11], 19010);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[11], 0.0000, 0.0000, 60.0000, 1.0000);

	playerTD[12] = CreatePlayerTextDraw(playerid, 133.0000, 249.0000, "Очки");
	PlayerTextDrawLetterSize(playerid, playerTD[12], 0.1473, 0.9693);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[12], -875836929);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[12], true);

	playerTD[13] = CreatePlayerTextDraw(playerid, 133.0000, 297.0000, "_"); // Задний чёрный фон маски
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 892613887);
	PlayerTextDrawSetSelectable(playerid, playerTD[13], true);
	PlayerTextDrawSetProportional(playerid, playerTD[13], false);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
	PlayerTextDrawTextSize(playerid, playerTD[13], 31.0000, 30.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[13], 18918);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[13], 120.0000, 160.0000, 0.0000, 1.0000);

	playerTD[14] = CreatePlayerTextDraw(playerid, 133.0000, 288.0000, "Маска");
	PlayerTextDrawLetterSize(playerid, playerTD[14], 0.1473, 0.9693);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], -875836929);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[14], true);

	playerTD[15] = CreatePlayerTextDraw(playerid, 133.0000, 336.0000, "_"); // Задний чёрный фон часов
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[15], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], 892613887);
	PlayerTextDrawSetSelectable(playerid, playerTD[15], true);
	PlayerTextDrawSetProportional(playerid, playerTD[15], false);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);
	PlayerTextDrawTextSize(playerid, playerTD[15], 31.0000, 30.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[15], 19039);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[15], 20.0000, 0.0000, 10.0000, 1.0000);

	playerTD[16] = CreatePlayerTextDraw(playerid, 133.0000, 327.0000, "Часы");
	PlayerTextDrawLetterSize(playerid, playerTD[16], 0.1473, 0.9693);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[16], -875836929);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[16], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[16], true);

	playerTD[17] = CreatePlayerTextDraw(playerid, 225.0000, 180.0000, "_"); // Задний чёрный фон скина
	PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[17], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[17], 892613887);
	PlayerTextDrawSetSelectable(playerid, playerTD[17], true);
	PlayerTextDrawSetProportional(playerid, playerTD[17], false);
	PlayerTextDrawSetShadow(playerid, playerTD[17], 0);
	PlayerTextDrawTextSize(playerid, playerTD[17], 31.0000, 30.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[17], 1);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[17], 0.0000, 0.0000, 0.0000, 1.0000);

	playerTD[18] = CreatePlayerTextDraw(playerid, 256.0000, 171.0000, "_"); // ID скина
	PlayerTextDrawLetterSize(playerid, playerTD[18], 0.1473, 0.9693);
	PlayerTextDrawTextSize(playerid, playerTD[18], 238.3332, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD[18], -875836929);
	PlayerTextDrawBackgroundColour(playerid, playerTD[18], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[18], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[18], true);

	playerTD[19] = CreatePlayerTextDraw(playerid, 225.0000, 219.0000, "_"); // Задний чёрный кубик баннера
	PlayerTextDrawFont(playerid, playerTD[19], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[19], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[19], 892613887);
	PlayerTextDrawSetSelectable(playerid, playerTD[19], true);
	PlayerTextDrawSetProportional(playerid, playerTD[19], false);
	PlayerTextDrawSetShadow(playerid, playerTD[19], 0);
	PlayerTextDrawTextSize(playerid, playerTD[19], 31.0000, 30.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[19], 19039);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[19], 20.0000, 0.0000, 10.0000, 1000.0000);

	playerTD[20] = CreatePlayerTextDraw(playerid, 256.0000, 210.0000, "Баннер");
	PlayerTextDrawLetterSize(playerid, playerTD[20], 0.1473, 0.9693);
	PlayerTextDrawAlignment(playerid, playerTD[20], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD[20], -875836929);
	PlayerTextDrawBackgroundColour(playerid, playerTD[20], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[20], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[20], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[20], true);

	playerTD[21] = CreatePlayerTextDraw(playerid, 227.0000, 221.0000, "ld_drv:naward"); // Спрайт баннера
	PlayerTextDrawTextSize(playerid, playerTD[21], 27.0000, 26.0000);
	PlayerTextDrawAlignment(playerid, playerTD[21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[21], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[21], 255);
	PlayerTextDrawFont(playerid, playerTD[21], TEXT_DRAW_FONT_SPRITE);
	PlayerTextDrawSetShadow(playerid, playerTD[21], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[21], false);

	playerTD[22] = CreatePlayerTextDraw(playerid, 342.0000, 379.0000, "_"); // Первый отсек
	PlayerTextDrawFont(playerid, playerTD[22], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[22], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[22], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[22], 10102203);
	PlayerTextDrawSetSelectable(playerid, playerTD[22], true);
	PlayerTextDrawSetProportional(playerid, playerTD[22], false);
	PlayerTextDrawSetShadow(playerid, playerTD[22], 0);
	PlayerTextDrawTextSize(playerid, playerTD[22], 23.0000, 10.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[22], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[22], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[23] = CreatePlayerTextDraw(playerid, 368.0000, 379.0000, "_"); // Второй отсек
	PlayerTextDrawFont(playerid, playerTD[23], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[23], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[23], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[23], 1717987003);
	PlayerTextDrawSetSelectable(playerid, playerTD[23], true);
	PlayerTextDrawSetProportional(playerid, playerTD[23], false);
	PlayerTextDrawSetShadow(playerid, playerTD[23], 0);
	PlayerTextDrawTextSize(playerid, playerTD[23], 23.0000, 10.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[23], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[23], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[24] = CreatePlayerTextDraw(playerid, 132.0000, 371.9035, "_"); // Задний белый фон закрыть
	PlayerTextDrawFont(playerid, playerTD[24], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[24], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[24], -1717986817);
	PlayerTextDrawBackgroundColour(playerid, playerTD[24], -1717986817);
	PlayerTextDrawSetSelectable(playerid, playerTD[24], true);
	PlayerTextDrawSetProportional(playerid, playerTD[24], false);
	PlayerTextDrawSetShadow(playerid, playerTD[24], 0);
	PlayerTextDrawTextSize(playerid, playerTD[24], 62.0000, 21.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[24], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[24], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[25] = CreatePlayerTextDraw(playerid, 133.0000, 373.0000, "_"); // Задний чёрный фон закрыть
	PlayerTextDrawFont(playerid, playerTD[25], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[25], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[25], 353703167);
	PlayerTextDrawBackgroundColour(playerid, playerTD[25], 353703167);
	PlayerTextDrawSetSelectable(playerid, playerTD[25], true);
	PlayerTextDrawSetProportional(playerid, playerTD[25], false);
	PlayerTextDrawSetShadow(playerid, playerTD[25], 0);
	PlayerTextDrawTextSize(playerid, playerTD[25], 60.0000, 19.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[25], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[25], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[26] = CreatePlayerTextDraw(playerid, 163.0000, 376.0000, "Закрыть");
	PlayerTextDrawLetterSize(playerid, playerTD[26], 0.2578, 1.2556);
	PlayerTextDrawTextSize(playerid, playerTD[26], 15.0000, 60.0000);
	PlayerTextDrawAlignment(playerid, playerTD[26], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[26], -517395969);
	PlayerTextDrawBackgroundColour(playerid, playerTD[26], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[26], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[26], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[26], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[26], true);

	playerTD[27] = CreatePlayerTextDraw(playerid, 195.0000, 372.0000, "_"); // Задний белый фон баннер
	PlayerTextDrawFont(playerid, playerTD[27], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[27], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[27], -1717986817);
	PlayerTextDrawBackgroundColour(playerid, playerTD[27], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[27], false);
	PlayerTextDrawSetShadow(playerid, playerTD[27], 0);
	PlayerTextDrawTextSize(playerid, playerTD[27], 62.0000, 21.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[27], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[27], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[28] = CreatePlayerTextDraw(playerid, 196.0000, 373.0000, "_"); // Задний чёрный фон банне
	PlayerTextDrawFont(playerid, playerTD[28], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[28], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[28], 353703167);
	PlayerTextDrawBackgroundColour(playerid, playerTD[28], 353703167);
	PlayerTextDrawSetSelectable(playerid, playerTD[28], true);
	PlayerTextDrawSetProportional(playerid, playerTD[28], false);
	PlayerTextDrawSetShadow(playerid, playerTD[28], 0);
	PlayerTextDrawTextSize(playerid, playerTD[28], 60.0000, 19.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[28], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[28], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[29] = CreatePlayerTextDraw(playerid, 225.6667, 375.5851, "Баннеры");
	PlayerTextDrawLetterSize(playerid, playerTD[29], 0.2578, 1.2556);
	PlayerTextDrawTextSize(playerid, playerTD[29], 15.0000, 60.0000);
	PlayerTextDrawAlignment(playerid, playerTD[29], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[29], 885302783);
	PlayerTextDrawBackgroundColour(playerid, playerTD[29], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[29], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[29], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[29], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[29], true);
	return 1;
}

/*
 * |>-------------<|
 * |   Cell item   |
 * |>-------------<|
 */

stock CreatePlayerInvCellItemTD(playerid, PlayerText:playerTD[], PlayerText:playerTD2[], Float:posX, Float:posY, tdid)
{
	// Item
	playerTD[tdid] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[tdid], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 0x919191BB);
	PlayerTextDrawSetProportional(playerid, playerTD[tdid], false);
	PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
	PlayerTextDrawTextSize(playerid, playerTD[tdid], 35.000000, 31.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[tdid], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[tdid], 0.000000, 0.000000, 0.000000, 1000.000000);
	PlayerTextDrawSetSelectable(playerid, playerTD[tdid], true);

	// Count
	playerTD2[tdid] = CreatePlayerTextDraw(playerid, posX + 34.0, posY - 1.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD2[tdid], 0.177999, 0.998518);
	PlayerTextDrawAlignment(playerid, playerTD2[tdid], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD2[tdid], 1499027967);
	PlayerTextDrawBackgroundColour(playerid, playerTD2[tdid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD2[tdid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD2[tdid], 0);
	PlayerTextDrawSetProportional(playerid, playerTD2[tdid], true);
	return 1;
}

/*
 * |>---------------<|
 * |   Cell banner   |
 * |>---------------<|
 */

stock CreatePlayerInvCellBannerTD(playerid, PlayerText:playerTD[], PlayerText:playerTD2[], PlayerText:playerTD3[], Float:posX, Float:posY, tdid)
{
	// Banner
	playerTD[tdid] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[tdid], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 0x919191BB);
	PlayerTextDrawSetProportional(playerid, playerTD[tdid], false);
	PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
	PlayerTextDrawTextSize(playerid, playerTD[tdid], 35.000000, 31.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[tdid], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[tdid], 0.000000, 0.000000, 0.000000, 1000.000000);
	PlayerTextDrawSetSelectable(playerid, playerTD[tdid], true);

	// Sprite
	playerTD2[tdid] = CreatePlayerTextDraw(playerid, posX + 2.0, posY + 2.0, "_");
	PlayerTextDrawTextSize(playerid, playerTD2[tdid], 31.0000, 27.0000);
	PlayerTextDrawAlignment(playerid, playerTD2[tdid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD2[tdid], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD2[tdid], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD2[tdid], 0);
	PlayerTextDrawSetProportional(playerid, playerTD2[tdid], false);
	PlayerTextDrawFont(playerid, playerTD2[tdid], TEXT_DRAW_FONT_SPRITE);

	// Count
	playerTD3[tdid] = CreatePlayerTextDraw(playerid, posX + 34.0, posY - 1.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD3[tdid], 0.177999, 0.998518);
	PlayerTextDrawAlignment(playerid, playerTD3[tdid], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD3[tdid], 1499027967);
	PlayerTextDrawBackgroundColour(playerid, playerTD3[tdid], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD3[tdid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD3[tdid], 0);
	PlayerTextDrawSetProportional(playerid, playerTD3[tdid], true);
	return 1;
}

/*
 * |>---------------<|
 * |   Action cell   |
 * |>---------------<|
 */

stock CreatePlayerInvActionCellTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
{
	playerTD[0] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 0x212121FF);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawTextSize(playerid, playerTD[0], 35.000000, 41.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.000000, 0.000000, 0.000000, 1000.000000);
	
	playerTD[1] = CreatePlayerTextDraw(playerid, posX + 18.0, posY - 1.0, "Использ.");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.130664, 1.056590);
	PlayerTextDrawTextSize(playerid, playerTD[1], 7.000000, 30.000000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[1], true);

	playerTD[2] = CreatePlayerTextDraw(playerid, posX + 18.0, posY - 1.0 + 10.0, "Передать");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.130664, 1.056590);
	PlayerTextDrawTextSize(playerid, playerTD[2], 7.000000, 30.000000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[2], true);

	playerTD[3] = CreatePlayerTextDraw(playerid, posX + 18.0, posY - 1.0 + 20.0, "Инфо.");
	PlayerTextDrawLetterSize(playerid, playerTD[3], 0.130664, 1.056590);
	PlayerTextDrawTextSize(playerid, playerTD[3], 7.000000, 30.000000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[3], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[3], true);

	playerTD[4] = CreatePlayerTextDraw(playerid, posX + 18.0, posY - 1.0 + 30.0, "Выкинуть");
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.130664, 1.056590);
	PlayerTextDrawTextSize(playerid, playerTD[4], 7.000000, 30.000000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
	return 1;
}

/*
 * |>-------------<|
 * |   Open case   |
 * |>-------------<|
 */

stock CreatePlayerInvOpenCaseTD(playerid, PlayerText:playerTD[], const caseName[], caseColor)
{
	// Кликабельный фон кнопки открыть
	playerTD[0] = CreatePlayerTextDraw(playerid, 269.666687, 325.488922, "_");
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 1313754879);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[0], true);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawTextSize(playerid, playerTD[0], 96.000000, 32.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.000000, 0.000000, 0.000000, 1000.000000);

	playerTD[1] = CreatePlayerTextDraw(playerid, 318.000000, 331.000000, "Открыть");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.332333, 1.906962);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawSetOutline(playerid, playerTD[1], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 48);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);

	playerTD[2] = CreatePlayerTextDraw(playerid, 318.000000, 310.000000, caseName);
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.241333, 1.707851);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[2], caseColor);
	PlayerTextDrawSetOutline(playerid, playerTD[2], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 32);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	return 1;
}

/*
 * |>----------------<|
 * |   Opening case   |
 * |>----------------<|
 */

stock CreatePlayerInvOpeningCaseTD(playerid, PlayerText:playerTD[], const caseName[])
{
	playerTD[0] = CreatePlayerTextDraw(playerid, 230.000000, 126.000000, "_"); // Основной задний фон
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.000000, 24.866649);
	PlayerTextDrawTextSize(playerid, playerTD[0], 414.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], 774781695);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);

	playerTD[1] = CreatePlayerTextDraw(playerid, 323.000000, 125.000000, caseName); // Текст
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.290666, 1.438222);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[1], -1515871233);
	PlayerTextDrawSetOutline(playerid, playerTD[1], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);

	playerTD[2] = CreatePlayerTextDraw(playerid, 230.000000, 322.000000, "_"); // Кликабельный фон Диалоговое окно
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 974263551);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[2], true);
	PlayerTextDrawSetProportional(playerid, playerTD[2], false);
	PlayerTextDrawTextSize(playerid, playerTD[2], 61.000000, 28.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[2], 0.000000, 0.000000, 0.000000, 1000.000000);

	playerTD[3] = CreatePlayerTextDraw(playerid, 353.000000, 322.000000, "_"); // Кликабельный фон Забрать
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 974263551);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[3], true);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawTextSize(playerid, playerTD[3], 61.000000, 28.000000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.000000, 0.000000, 0.000000, 1000.000000);

	playerTD[4] = CreatePlayerTextDraw(playerid, 260.000000, 327.000000, "Диалоговое окно"); 
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.151999, 1.716147);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[4], -842150913);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);

	playerTD[5] = CreatePlayerTextDraw(playerid, 384.000000, 326.000000, "Забрать");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.204999, 1.898665);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[5], -842150913);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);

	playerTD[6] = CreatePlayerTextDraw(playerid, 230.000000, 126.000000, "_"); // Задний фон текста
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.000000, 1.433331);
	PlayerTextDrawTextSize(playerid, playerTD[6], 414.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawUseBox(playerid, playerTD[6], true);
	PlayerTextDrawBoxColour(playerid, playerTD[6], 690563583);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);

	playerTD[7] = CreatePlayerTextDraw(playerid, 232.000000, 144.000000, "_"); // Текст 1
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.186333, 1.301333);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);

	playerTD[8] = CreatePlayerTextDraw(playerid, 232.000000, 157.000000, "_"); // Текст 2
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.186333, 1.301333);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);

	playerTD[9] = CreatePlayerTextDraw(playerid, 232.000000, 170.000000, "_"); // Текст 3
	PlayerTextDrawLetterSize(playerid, playerTD[9], 0.186333, 1.301333);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[9], true);

	playerTD[10] = CreatePlayerTextDraw(playerid, 232.000000, 183.000000, "_"); // Текст 4
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.186333, 1.301333);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[10], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);

	playerTD[11] = CreatePlayerTextDraw(playerid, 232.000000, 196.000000, "_"); // Текст 5
	PlayerTextDrawLetterSize(playerid, playerTD[11], 0.186333, 1.301333);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[11], true);

	playerTD[12] = CreatePlayerTextDraw(playerid, 232.000000, 209.000000, "_"); // Текст 6
	PlayerTextDrawLetterSize(playerid, playerTD[12], 0.186333, 1.301333);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[12], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[12], true);

	playerTD[13] = CreatePlayerTextDraw(playerid, 232.000000, 222.000000, "_"); // Текст 7
	PlayerTextDrawLetterSize(playerid, playerTD[13], 0.186333, 1.301333);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[13], true);

	playerTD[14] = CreatePlayerTextDraw(playerid, 232.000000, 235.000000, "_"); // Текст 8
	PlayerTextDrawLetterSize(playerid, playerTD[14], 0.186333, 1.301333);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
	PlayerTextDrawSetProportional(playerid, playerTD[14], true);
	return 1;
}