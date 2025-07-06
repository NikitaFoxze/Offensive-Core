/*
 * |>========================<|
 * |   About: TDM textdraws   |
 * |   Author: Foxze          |
 * |>========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- TDM_CreatePlayerTopKillersTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
	- TDM_CreatePlayerEndMatchStatsTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
	- TDM_CreatePlayerMatchResultTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
	- TDM_CreatePlTimerNextLocationTD(playerid, &PlayerText:playerTD)
	- TDM_CreatePlayerTextTeamMatchTD(playerid, &PlayerText:playerTD)
	- TDM_CreatePlayerSelectSpawnTD(playerid, PlayerText:playerTD[])
	- TDM_CreatePlayerSelectPlayerTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:base, &startTD)
	- TDM_CreatePlayerSelectPointTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, &startTD, const pointNameABC[], const pointName[], const pointStatus[], teamColorXF)
	- TDM_CreatePlayerSelectTeamTD(playerid, PlayerText:playerTD[], tdid, onetdid, const teamName[], people, teamColorXF)
	- TDM_CreatePlayerSelectNextLocTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:locInfo, &startTD)
	- TDM_CreatePlayerTeamScoreTD(playerid, PlayerText:playerTD[], tdid, onetdid, const teamName[], teamColorXB)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_TDM_TD
	#endinput
#endif
#define _INC_TDM_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define TDM_TD_TOP_KILLERS				(3)
#define TDM_TD_END_MATCH_STATS			(7)
#define TDM_TD_MATCH_RESULT				(9)
#define TDM_TD_SELECT_SPAWN				(12)
#define TDM_TD_SELECT_PLAYER			(27)
#define TDM_TD_SELECT_POINT				(42)
#define TDM_TD_SELECT_TEAM				(19)
#define TDM_TD_SELECT_NEXT_LOCATION		(15)
#define TDM_TD_TEAM_SCORE				(8)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>---------------<|
 * |   Top killers   |
 * |>---------------<|
 */

stock TDM_CreatePlayerTopKillersTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
{
	playerTD[0] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.1356, 1.2888);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], -909522945);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);

	playerTD[1] = CreatePlayerTextDraw(playerid, posX + 122.0, posY, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.2375, 1.2929);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[1], -909522945);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 255);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);

	playerTD[2] = CreatePlayerTextDraw(playerid, posX + 170.0, posY, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.2375, 1.2929);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[2], -909522945);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	return 1;
}

/*
 * |>-------------------<|
 * |   End match stats   |
 * |>-------------------<|
 */

stock TDM_CreatePlayerEndMatchStatsTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
{
	// Задний фон статистики
	playerTD[0] = CreatePlayerTextDraw(playerid, posX, posY + 144.0, "_");
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 0x303030FF);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawTextSize(playerid, playerTD[0], 214.0000, 31.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 10000.0000);

	// Ранг
	playerTD[1] = CreatePlayerTextDraw(playerid, posX + 3.0, posY + 143.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.1846, 1.2183);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 255);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);

	// Убийств
	playerTD[2] = CreatePlayerTextDraw(playerid, posX + 3.0, posY + 153.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.1846, 1.2183);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);

	// Смертей
	playerTD[3] = CreatePlayerTextDraw(playerid, posX + 3.0, posY + 163.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[3], 0.1846, 1.2183);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 255);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[3], true);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);

	// Полоска
	playerTD[4] = CreatePlayerTextDraw(playerid, posX + 66.0, posY + 144.0, "_");
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 2021161215);
	PlayerTextDrawSetProportional(playerid, playerTD[4], false);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawTextSize(playerid, playerTD[4], -2.0000, 31.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 10000.0000);

	// Всего EXP
	playerTD[5] = CreatePlayerTextDraw(playerid, posX + 69.0, posY + 143.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.1846, 1.2183);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);

	// Всего Денег
	playerTD[6] = CreatePlayerTextDraw(playerid, posX + 69.0, posY + 153.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.1846, 1.2183);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	return 1;
}

/*
 * |>----------------<|
 * |   Match result   |
 * |>----------------<|
 */

stock TDM_CreatePlayerMatchResultTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
{
	// Задний фон
	playerTD[0] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 0x303030FF);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawTextSize(playerid, playerTD[0], 196.0000, 141.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 10000.0000);

	// Первая полоса сверху
	playerTD[1] = CreatePlayerTextDraw(playerid, posX, posY + 16.0, "_");
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawTextSize(playerid, playerTD[1], 196.0000, 2.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Второвая полоса сверху
	playerTD[2] = CreatePlayerTextDraw(playerid, posX, posY + 27.0, "_");
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_PREVIEW); 
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawSetProportional(playerid, playerTD[2], false);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawTextSize(playerid, playerTD[2], 196.0000, 2.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[2], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Ники и убийства
	playerTD[3] = CreatePlayerTextDraw(playerid, posX + 100.0, posY + 17.0, "_");
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawTextSize(playerid, playerTD[3], 2.0000, 123.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Убийства и смерти
	playerTD[4] = CreatePlayerTextDraw(playerid, posX + 146.0, posY + 17.0, "_");
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawSetProportional(playerid, playerTD[4], false);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawTextSize(playerid, playerTD[4], 2.0000, 123.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[5] = CreatePlayerTextDraw(playerid, posX + 49.0, posY + 16.0, "Профессионалы");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.2196, 1.2100);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[5], -909522945);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);

	playerTD[6] = CreatePlayerTextDraw(playerid, posX + 124.0, posY + 16.0, "Убийств");
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.2196, 1.2100);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[6], -909522945);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);

	playerTD[7] = CreatePlayerTextDraw(playerid, posX + 171.0, posY + 16.0, "Смертей");
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.2196, 1.2100);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[7], -909522945);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 255);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);

	// Название команды
	playerTD[8] = CreatePlayerTextDraw(playerid, posX + 98.0, posY + 1.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.2369, 1.4133);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 255);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	return 1;
}

/*
 * |>-----------------------<|
 * |   Timer next location   |
 * |>-----------------------<|
 */

stock TDM_CreatePlTimerNextLocationTD(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 320.0000, 95.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD, 0.2085, 1.3178);
	PlayerTextDrawTextSize(playerid, playerTD, 0.0000, 137.0000);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD, 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD, true);
	PlayerTextDrawBoxColour(playerid, playerTD, 1768516095);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 1768515993);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	PlayerTextDrawSetShadow(playerid, playerTD, 0);
	return 1;
}

/*
 * |>-------------------<|
 * |   Text team match   |
 * |>-------------------<|
 */

stock TDM_CreatePlayerTextTeamMatchTD(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 326.000000, 108.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD, 0.310666, 1.711999);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD, -858993409);
	PlayerTextDrawSetShadow(playerid, playerTD, 0);
	PlayerTextDrawSetOutline(playerid, playerTD, 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 48);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	PlayerTextDrawSetShadow(playerid, playerTD, 0);
	return 1;
}

/*
 * |>----------------<|
 * |   Select spawn   |
 * |>----------------<|
 */

stock TDM_CreatePlayerSelectSpawnTD(playerid, PlayerText:playerTD[])
{
	// Белый фон начать
	playerTD[0] = CreatePlayerTextDraw(playerid, 168.0000, 417.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[0], false);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
	PlayerTextDrawTextSize(playerid, playerTD[0], 45.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон начать
	playerTD[1] = CreatePlayerTextDraw(playerid, 169.0000, 418.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[1], false);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[1], true);
	PlayerTextDrawTextSize(playerid, playerTD[1], 43.0000, 20.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[2] = CreatePlayerTextDraw(playerid, 191.0000, 419.0000, "Начать");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, playerTD[2], 15.0000, 42.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[2], -949919233);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[2], true);

	// Белый фон смена персонажа
	playerTD[3] = CreatePlayerTextDraw(playerid, 218.0000, 417.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[3], false);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
	PlayerTextDrawTextSize(playerid, playerTD[3], 112.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон смена персонажа
	playerTD[4] = CreatePlayerTextDraw(playerid, 219.0000, 418.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[4], false);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
	PlayerTextDrawTextSize(playerid, playerTD[4], 110.0000, 20.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[5] = CreatePlayerTextDraw(playerid, 274.0000, 419.0000, "Смена_персонажа");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, playerTD[5], 15.0000, 110.0000);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[5], 1636288511);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[5], true);

	// Белый фон квестов
	playerTD[6] = CreatePlayerTextDraw(playerid, 336.0000, 417.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[6], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[6], false);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
	PlayerTextDrawTextSize(playerid, playerTD[6], 45.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[6], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[6], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон квестов
	playerTD[7] = CreatePlayerTextDraw(playerid, 337.0000, 418.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[7], false);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[7], true);
	PlayerTextDrawTextSize(playerid, playerTD[7], 43.0000, 20.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[7], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[7], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[8] = CreatePlayerTextDraw(playerid, 359.0000, 419.0000, "Квесты");
	PlayerTextDrawLetterSize(playerid, playerTD[8], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, playerTD[8], 15.0000, 44.0000);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[8], -910794241);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 255);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[8], true);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[8], true);

	// Белый фон смена команды
	playerTD[9] = CreatePlayerTextDraw(playerid, 386.0000, 417.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[9], false);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawTextSize(playerid, playerTD[9], 101.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[9], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[9], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Кликабельный фон смена команжды
	playerTD[10] = CreatePlayerTextDraw(playerid, 387.0000, 418.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[10], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[10], false);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[10], true);
	PlayerTextDrawTextSize(playerid, playerTD[10], 99.0000, 20.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[10], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[10], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[11] = CreatePlayerTextDraw(playerid, 437.0000, 419.0000, "Смена_команды");
	PlayerTextDrawLetterSize(playerid, playerTD[11], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, playerTD[11], 15.0000, 98.0000);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[11], -1429773825);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 255);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[11], true);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[11], true);
	return 1;
}

/*
 * |>-----------------<|
 * |   Select player   |
 * |>-----------------<|
 */

stock TDM_CreatePlayerSelectPlayerTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:base, &startTD)
{
	// Spawn base
	if (base) {
		// Белый фон группа
		playerTD[startTD] = CreatePlayerTextDraw(playerid, posX, posY, "_");
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], -1717986817);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetSelectable(playerid, playerTD[startTD], false);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 66.0000, 50.0000);
		PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
		startTD++;

		// Кликабельный фон группа
		playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 1.0, posY + 1.0, "_");
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 303174399);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetSelectable(playerid, playerTD[startTD], true);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 64.0000, 48.0000);
		PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
		startTD++;

		// Base
		playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 33.0, posY + 16.0, "На_базе");
		PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.1853, 1.5460);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
		PlayerTextDrawColour(playerid, playerTD[startTD], -606348801);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 255);
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		startTD++;
		return 1;
	}

	// Spawn player

	// Белый фон группа
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[startTD], false);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 66.0000, 50.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
	startTD++;

	// Кликабельный фон группа
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 1.0, posY + 1.0, "_");
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[startTD], true);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 64.0000, 48.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
	startTD++;

	// Ник
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 33.0, posY + 26.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.1509, 2.3798);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 0.0000, 203.0000);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], -842150913);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 255);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	startTD++;

	// Полоска
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 1.0, posY + 25.0, "_");
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 65.0000, 1.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
	startTD++;

	// Класс персонажа
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 33.0, posY, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.1854, 1.5460);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], -842150913);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 255);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	startTD++;

	// Статус
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 33.0, posY + 11.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.1764, 1.4921);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], -842150913);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 255);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	startTD++;
	return 1;
}

/*
 * |>------------------------<|
 * |   Select capture point   |
 * |>------------------------<|
 */

stock TDM_CreatePlayerSelectPointTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, &startTD, const pointNameABC[], const pointName[], const pointStatus[], teamColorXF)
{
	// Белый фон точки
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 55.0000, 49.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
	startTD++;

	// Кликабельный фон
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 1.0, posY + 1.0, "_");
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[startTD], true);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 53.0000, 47.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
	startTD++;

	// Задний фон точки
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 14.0, posY + 3.0, "_");
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], teamColorXF);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 27.0000, 21.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
	startTD++;

	// Точка
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 28.0, posY + 4.0, pointNameABC);
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.4170, 1.8157);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], -101058561);
	PlayerTextDrawSetOutline(playerid, playerTD[startTD], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 144);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	startTD++;

	// Статус точки
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 28.0, posY + 23.0, pointStatus);
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.2186, 1.4174);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 0.0000, 51.0000);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], teamColorXF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 80);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	startTD++;

	// Название точки 
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 28.0, posY + 33.0, pointName);
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.1956, 1.5128);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 0.0000, 51.0000);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], teamColorXF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 80);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	startTD++;
	return 1;
}

/*
 * |>---------------<|
 * |   Select team   |
 * |>---------------<|
 */

stock TDM_CreatePlayerSelectTeamTD(playerid, PlayerText:playerTD[], tdid, onetdid, const teamName[], people, teamColorXF)
{
	if (onetdid != -1) {
		switch (onetdid) {
			case 0: {
				// Задний белый фон назад
				playerTD[0] = CreatePlayerTextDraw(playerid, 289.0000, 129.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[0], -1717986817);
				PlayerTextDrawSetProportional(playerid, playerTD[0], false);
				PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
				PlayerTextDrawTextSize(playerid, playerTD[0], 55.0000, 16.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[0]);

				// Задний чёрный фон назад
				playerTD[1] = CreatePlayerTextDraw(playerid, 290.0000, 130.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[1], 303174399);
				PlayerTextDrawSetProportional(playerid, playerTD[1], false);
				PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[1], true);
				PlayerTextDrawTextSize(playerid, playerTD[1], 53.0000, 14.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[1]);

				playerTD[2] = CreatePlayerTextDraw(playerid, 317.0000, 130.0000, "Назад");
				PlayerTextDrawLetterSize(playerid, playerTD[2], 0.2630, 1.4340);
				PlayerTextDrawTextSize(playerid, playerTD[2], 12.0000, 52.0000);
				PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[2], -330419713);
				PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
				PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[2], true);
				PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[2], true);
				PlayerTextDrawShow(playerid, playerTD[2]);

				// Задний фон цвета команд
				playerTD[3] = CreatePlayerTextDraw(playerid, 318.0000, 150.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[3], teamColorXF);
				PlayerTextDrawSetProportional(playerid, playerTD[3], false);
				PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
				PlayerTextDrawTextSize(playerid, playerTD[3], 90.0000, 90.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[3]);

				// Задний чёрный фон
				playerTD[4] = CreatePlayerTextDraw(playerid, 319.0000, 151.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[4], 303174399);
				PlayerTextDrawSetProportional(playerid, playerTD[4], false);
				PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
				PlayerTextDrawTextSize(playerid, playerTD[4], 88.0000, 88.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[4]);

				// Название команды
				playerTD[5] = CreatePlayerTextDraw(playerid, 363.0000, 176.0000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[5], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[5], teamColorXF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
				PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[5], true);
				PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
				PlayerTextDrawShow(playerid, playerTD[5]);

				// Кол-во людей в команде
				playerTD[6] = CreatePlayerTextDraw(playerid, 363.0000, 194.0000, "Людей:_%i", people);
				PlayerTextDrawLetterSize(playerid, playerTD[6], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[6], -505290753);
				PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
				PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[6], true);
				PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
				PlayerTextDrawShow(playerid, playerTD[6]);

			}
			case 2: {
				// Задний фон цвета команд
				playerTD[11] = CreatePlayerTextDraw(playerid, 318.0000, 245.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[11], teamColorXF);
				PlayerTextDrawSetProportional(playerid, playerTD[11], false);
				PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
				PlayerTextDrawTextSize(playerid, playerTD[11], 90.0000, 90.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[11], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[11], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[11]);

				// Задний чёрный фон
				playerTD[12] = CreatePlayerTextDraw(playerid, 319.0000, 246.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[12], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[12], 303174399);
				PlayerTextDrawSetProportional(playerid, playerTD[12], false);
				PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[12], true);
				PlayerTextDrawTextSize(playerid, playerTD[12], 88.0000, 88.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[12], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[12], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[12]);

				// Название команды
				playerTD[13] = CreatePlayerTextDraw(playerid, 363.0000, 271.0000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[13], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[13], teamColorXF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[13], 255);
				PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[13], true);
				PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
				PlayerTextDrawShow(playerid, playerTD[13]);

				// Кол-во людей в команде
				playerTD[14] = CreatePlayerTextDraw(playerid, 363.0000, 289.0000, "Людей:_%i", people);
				PlayerTextDrawLetterSize(playerid, playerTD[14], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[14], -505290753);
				PlayerTextDrawBackgroundColour(playerid, playerTD[14], 255);
				PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[14], true);
				PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
				PlayerTextDrawShow(playerid, playerTD[14]);
			}
		}
	}

	if (tdid != -1) {
		switch (tdid) {
			case 0: {
				// Задний белый фон назад
				playerTD[0] = CreatePlayerTextDraw(playerid, 289.0000, 129.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[0], -1717986817);
				PlayerTextDrawSetProportional(playerid, playerTD[0], false);
				PlayerTextDrawSetShadow(playerid, playerTD[0], 0);
				PlayerTextDrawTextSize(playerid, playerTD[0], 55.0000, 16.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[0], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[0], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[0]);

				// Задний чёрный фон назад
				playerTD[1] = CreatePlayerTextDraw(playerid, 290.0000, 130.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[1], 303174399);
				PlayerTextDrawSetProportional(playerid, playerTD[1], false);
				PlayerTextDrawSetShadow(playerid, playerTD[1], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[1], true);
				PlayerTextDrawTextSize(playerid, playerTD[1], 53.0000, 14.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[1], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[1], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[1]);

				playerTD[2] = CreatePlayerTextDraw(playerid, 317.0000, 130.0000, "Назад");
				PlayerTextDrawLetterSize(playerid, playerTD[2], 0.2630, 1.4340);
				PlayerTextDrawTextSize(playerid, playerTD[2], 12.0000, 52.0000);
				PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[2], -330419713);
				PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
				PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[2], true);
				PlayerTextDrawSetShadow(playerid, playerTD[2], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[2], true);
				PlayerTextDrawShow(playerid, playerTD[2]);

				// Задний фон цвета команд
				playerTD[3] = CreatePlayerTextDraw(playerid, 223.0000, 150.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[3], teamColorXF);
				PlayerTextDrawSetProportional(playerid, playerTD[3], false);
				PlayerTextDrawSetShadow(playerid, playerTD[3], 0);
				PlayerTextDrawTextSize(playerid, playerTD[3], 90.0000, 90.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[3], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[3], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[3]);

				// Задний чёрный фон
				playerTD[4] = CreatePlayerTextDraw(playerid, 224.0000, 151.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[4], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[4], 303174399);
				PlayerTextDrawSetProportional(playerid, playerTD[4], false);
				PlayerTextDrawSetShadow(playerid, playerTD[4], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[4], true);
				PlayerTextDrawTextSize(playerid, playerTD[4], 88.0000, 88.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[4]);

				// Название команды
				playerTD[5] = CreatePlayerTextDraw(playerid, 268.0000, 176.0000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[5], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[5], teamColorXF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
				PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[5], true);
				PlayerTextDrawSetShadow(playerid, playerTD[5], 0);
				PlayerTextDrawShow(playerid, playerTD[5]);

				// Кол-во людей в команде
				playerTD[6] = CreatePlayerTextDraw(playerid, 268.0000, 194.0000, "Людей:_%i", people);
				PlayerTextDrawLetterSize(playerid, playerTD[6], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[6], -505290753);
				PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
				PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[6], true);
				PlayerTextDrawSetShadow(playerid, playerTD[6], 0);
				PlayerTextDrawShow(playerid, playerTD[6]);
			}
			case 1: {
				// Задний фон цвета команд
				playerTD[7] = CreatePlayerTextDraw(playerid, 318.0000, 150.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[7], teamColorXF);
				PlayerTextDrawSetProportional(playerid, playerTD[7], false);
				PlayerTextDrawSetShadow(playerid, playerTD[7], 0);
				PlayerTextDrawTextSize(playerid, playerTD[7], 90.0000, 90.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[7], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[7], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[7]);
				
				// Задний чёрный фон
				playerTD[8] = CreatePlayerTextDraw(playerid, 319.0000, 151.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[8], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[8], 303174399);
				PlayerTextDrawSetProportional(playerid, playerTD[8], false);
				PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[8], true);
				PlayerTextDrawTextSize(playerid, playerTD[8], 88.0000, 88.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[8], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[8], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[8]);

				// Название команды
				playerTD[9] = CreatePlayerTextDraw(playerid, 363.0000, 176.0000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[9], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[9], teamColorXF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[9], 255);
				PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[9], true);
				PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
				PlayerTextDrawShow(playerid, playerTD[9]);

				// Кол-во людей в команде
				playerTD[10] = CreatePlayerTextDraw(playerid, 363.0000, 194.0000, "Людей:_%i", people);
				PlayerTextDrawLetterSize(playerid, playerTD[10], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[10], -505290753);
				PlayerTextDrawBackgroundColour(playerid, playerTD[10], 255);
				PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[10], true);
				PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
				PlayerTextDrawShow(playerid, playerTD[10]);
			}
			case 2: {
				// Задний фон цвета команд
				playerTD[11] = CreatePlayerTextDraw(playerid, 223.0000, 245.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[11], teamColorXF);
				PlayerTextDrawSetProportional(playerid, playerTD[11], false);
				PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
				PlayerTextDrawTextSize(playerid, playerTD[11], 90.0000, 90.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[11], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[11], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[11]);

				// Задний чёрный фон
				playerTD[12] = CreatePlayerTextDraw(playerid, 224.0000, 246.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[12], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[12], 303174399);
				PlayerTextDrawSetProportional(playerid, playerTD[12], false);
				PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[12], true);
				PlayerTextDrawTextSize(playerid, playerTD[12], 88.0000, 88.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[12], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[12], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[12]);

				// Название команды
				playerTD[13] = CreatePlayerTextDraw(playerid, 268.0000, 271.0000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[13], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[13], teamColorXF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[13], 255);
				PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[13], true);
				PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
				PlayerTextDrawShow(playerid, playerTD[13]);

				// Кол-во людей в команде
				playerTD[14] = CreatePlayerTextDraw(playerid, 268.0000, 289.0000, "Людей:_%i", people);
				PlayerTextDrawLetterSize(playerid, playerTD[14], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[14], -505290753);
				PlayerTextDrawBackgroundColour(playerid, playerTD[14], 255);
				PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[14], true);
				PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
				PlayerTextDrawShow(playerid, playerTD[14]);
			}
			case 3: {
				// Задний фон цвета команд
				playerTD[15] = CreatePlayerTextDraw(playerid, 318.0000, 245.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[15], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[15], teamColorXF);
				PlayerTextDrawSetProportional(playerid, playerTD[15], false);
				PlayerTextDrawSetShadow(playerid, playerTD[15], 0);
				PlayerTextDrawTextSize(playerid, playerTD[15], 90.0000, 90.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[15], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[15], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[15]);
				
				// Задний чёрный фон
				playerTD[16] = CreatePlayerTextDraw(playerid, 319.0000, 246.0000, "_");
				PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_PREVIEW);
				PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[16], 0xFFFFFFFF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[16], 303174399);
				PlayerTextDrawSetProportional(playerid, playerTD[16], false);
				PlayerTextDrawSetShadow(playerid, playerTD[16], 0);
				PlayerTextDrawSetSelectable(playerid, playerTD[16], true);
				PlayerTextDrawTextSize(playerid, playerTD[16], 88.0000, 88.0000);
				PlayerTextDrawSetPreviewModel(playerid, playerTD[16], 0);
				PlayerTextDrawSetPreviewRot(playerid, playerTD[16], 0.0000, 0.0000, 0.0000, 1000.0000);
				PlayerTextDrawShow(playerid, playerTD[16]);

				// Название команды
				playerTD[17] = CreatePlayerTextDraw(playerid, 363.0000, 271.0000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[17], 0.2743, 1.6912);
				PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[17], teamColorXF);
				PlayerTextDrawBackgroundColour(playerid, playerTD[17], 255);
				PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[17], true);
				PlayerTextDrawSetShadow(playerid, playerTD[17], 0);
				PlayerTextDrawShow(playerid, playerTD[17]);

				// Кол-во людей в команде
				playerTD[18] = CreatePlayerTextDraw(playerid, 363.0000, 289.0000, "Людей:_%i", people);
				PlayerTextDrawLetterSize(playerid, playerTD[18], 0.2396, 1.6000);
				PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[18], -505290753);
				PlayerTextDrawBackgroundColour(playerid, playerTD[18], 255);
				PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[18], true);
				PlayerTextDrawSetShadow(playerid, playerTD[18], 0);
				PlayerTextDrawShow(playerid, playerTD[18]);
			}
		}
	}
	return 1;
}

/*
 * |>------------------------<|
 * |   Select next location   |
 * |>------------------------<|
 */

stock TDM_CreatePlayerSelectNextLocTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:locInfo, &startTD)
{
	if(!locInfo) {
		// Основной задний фон
		playerTD[startTD] = CreatePlayerTextDraw(playerid, 226.0000, 117.0000, "_");
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 976894719);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 188.0000, 78.0000);
		PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
		startTD++;

		// Основной задний фон
		playerTD[startTD] = CreatePlayerTextDraw(playerid, 226.0000, 117.0000, "_");
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 757935615);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 188.0000, 14.0000);
		PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
		PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
		startTD++;

		playerTD[startTD] = CreatePlayerTextDraw(playerid, 320.9997, 116.0000, "Выбор_локации");
		PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.2596, 1.5377);
		PlayerTextDrawTextSize(playerid, playerTD[startTD], 0.0000, 167.0000);
		PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
		PlayerTextDrawColour(playerid, playerTD[startTD], -505290753);
		PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 255);
		PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
		PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
		PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
		startTD++;
		return 1;
	}

	// Чёрный фон
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[startTD], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], false);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[startTD], true);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 58.0000, 55.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[startTD], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[startTD], 0.0000, 0.0000, 0.0000, 1000.0000);
	startTD++;

	// Название локации
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 29.0, posY + 2.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.1940, 1.5377);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 0.0000, 51.0000);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], -394258433);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], -394258433);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	startTD++;

	// Название режима
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 29.0, posY + 19.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.1743, 1.5294);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 0.0000, 51.0000);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], -648201473);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], -394258433);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	startTD++;

	// Голосов
	playerTD[startTD] = CreatePlayerTextDraw(playerid, posX + 29.0, posY + 37.0, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[startTD], 0.1940, 1.5377);
	PlayerTextDrawTextSize(playerid, playerTD[startTD], 0.0000, 51.0000);
	PlayerTextDrawAlignment(playerid, playerTD[startTD], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[startTD], -2139062017);
	PlayerTextDrawBackgroundColour(playerid, playerTD[startTD], -394258433);
	PlayerTextDrawFont(playerid, playerTD[startTD], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[startTD], true);
	PlayerTextDrawSetShadow(playerid, playerTD[startTD], 0);
	startTD++;
	return 1;
}

/*
 * |>--------------<|
 * |   Team score   |
 * |>--------------<|
 */

stock TDM_CreatePlayerTeamScoreTD(playerid, PlayerText:playerTD[], tdid, onetdid, const teamName[], teamColorXB)
{
	if (onetdid != -1) {
		switch (onetdid) {
			case 0: {
				// Название команды
				playerTD[0] = CreatePlayerTextDraw(playerid, 324.000000, 29.000000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[0], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[0], teamColorXB);
				PlayerTextDrawSetShadow(playerid, playerTD[0], 1);
				PlayerTextDrawSetOutline(playerid, playerTD[0], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
				PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[0], true);

				// Score
				playerTD[1] = CreatePlayerTextDraw(playerid, 323.000000, 40.000000, "_");
				PlayerTextDrawLetterSize(playerid, playerTD[1], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
				PlayerTextDrawSetOutline(playerid, playerTD[1], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[1], 255);
				PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[1], true);
				PlayerTextDrawSetShadow(playerid, playerTD[1], 0);

				PlayerTextDrawShow(playerid, playerTD[0]);
				PlayerTextDrawShow(playerid, playerTD[1]);
			}
			case 2: {
				playerTD[4] = CreatePlayerTextDraw(playerid, 324.000000, 51.000000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[4], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[4], teamColorXB);
				PlayerTextDrawSetShadow(playerid, playerTD[4], 1);
				PlayerTextDrawSetOutline(playerid, playerTD[4], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[4], 255);
				PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[4], true);

				playerTD[5] = CreatePlayerTextDraw(playerid, 323.000000, 62.000000, "_");
				PlayerTextDrawLetterSize(playerid, playerTD[5], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
				PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
				PlayerTextDrawSetOutline(playerid, playerTD[5], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
				PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[5], true);
				PlayerTextDrawSetShadow(playerid, playerTD[5], 0);

				PlayerTextDrawShow(playerid, playerTD[4]);
				PlayerTextDrawShow(playerid, playerTD[5]);
			}
		}
	}

	if (tdid != -1) {
		switch (tdid) {
			case 0: {
				// Название команды
				playerTD[0] = CreatePlayerTextDraw(playerid, 316.000000, 29.000000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[0], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_RIGHT);
				PlayerTextDrawColour(playerid, playerTD[0], teamColorXB);
				PlayerTextDrawSetShadow(playerid, playerTD[0], 1);
				PlayerTextDrawSetOutline(playerid, playerTD[0], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
				PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[0], true);

				// Score
				playerTD[1] = CreatePlayerTextDraw(playerid, 316.000000, 40.000000, "_");
				PlayerTextDrawLetterSize(playerid, playerTD[1], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_RIGHT);
				PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
				PlayerTextDrawSetOutline(playerid, playerTD[1], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[1], 255);
				PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[1], true);
				PlayerTextDrawSetShadow(playerid, playerTD[1], 0);

				PlayerTextDrawShow(playerid, playerTD[0]);
				PlayerTextDrawShow(playerid, playerTD[1]);
			}
			case 1: {
				playerTD[2] = CreatePlayerTextDraw(playerid, 326.000000, 29.000000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[2], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[2], teamColorXB);
				PlayerTextDrawSetShadow(playerid, playerTD[2], 1);
				PlayerTextDrawSetOutline(playerid, playerTD[2], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
				PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[2], true);

				playerTD[3] = CreatePlayerTextDraw(playerid, 327.000000, 40.000000, "_");
				PlayerTextDrawLetterSize(playerid, playerTD[3], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
				PlayerTextDrawSetOutline(playerid, playerTD[3], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[3], 255);
				PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[3], true);
				PlayerTextDrawSetShadow(playerid, playerTD[3], 0);

				PlayerTextDrawShow(playerid, playerTD[2]);
				PlayerTextDrawShow(playerid, playerTD[3]);
			}
			case 2: {
				playerTD[4] = CreatePlayerTextDraw(playerid, 316.000000, 51.000000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[4], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_RIGHT);
				PlayerTextDrawColour(playerid, playerTD[4], teamColorXB);
				PlayerTextDrawSetShadow(playerid, playerTD[4], 1);
				PlayerTextDrawSetOutline(playerid, playerTD[4], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[4], 255);
				PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[4], true);

				playerTD[5] = CreatePlayerTextDraw(playerid, 316.000000, 62.000000, "_");
				PlayerTextDrawLetterSize(playerid, playerTD[5], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_RIGHT);
				PlayerTextDrawColour(playerid, playerTD[5], 0xFFFFFFFF);
				PlayerTextDrawSetOutline(playerid, playerTD[5], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
				PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[5], true);
				PlayerTextDrawSetShadow(playerid, playerTD[5], 0);

				PlayerTextDrawShow(playerid, playerTD[4]);
				PlayerTextDrawShow(playerid, playerTD[5]);
			}
			case 3: {
				playerTD[6] = CreatePlayerTextDraw(playerid, 326.000000, 51.000000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[6], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[6], teamColorXB);
				PlayerTextDrawSetShadow(playerid, playerTD[6], 1);
				PlayerTextDrawSetOutline(playerid, playerTD[6], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
				PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[6], true);

				playerTD[7] = CreatePlayerTextDraw(playerid, 327.000000, 62.000000, "_");
				PlayerTextDrawLetterSize(playerid, playerTD[7], 0.296999, 1.081482);
				PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
				PlayerTextDrawSetOutline(playerid, playerTD[7], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[7], 255);
				PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[7], true);
				PlayerTextDrawSetShadow(playerid, playerTD[7], 0);

				PlayerTextDrawShow(playerid, playerTD[6]);
				PlayerTextDrawShow(playerid, playerTD[7]);
			}
		}
	}
	return 1;
}