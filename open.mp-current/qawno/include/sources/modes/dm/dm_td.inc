/*
 * |>=======================<|
 * |   About: DM textdraws   |
 * |   Author: Foxze         |
 * |>=======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- DM_CreatePlayerTopKillersTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:base, &tdid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_DM_TD
	#endinput
#endif
#define _INC_DM_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define DM_TD_TOP_KILLERS	(14)

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

stock DM_CreatePlayerTopKillersTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:base, &tdid)
{
	if (base) {
		// Основной задний фон
		playerTD[tdid] = CreatePlayerTextDraw(playerid, 523.0000, 356.0000, "_");
		PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.0000, 8.8665);
		PlayerTextDrawTextSize(playerid, playerTD[tdid], 621.0000, 0.0000);
		PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[tdid], 0xFFFFFFFF);
		PlayerTextDrawUseBox(playerid, playerTD[tdid], true);
		PlayerTextDrawBoxColour(playerid, playerTD[tdid], 640034559);
		PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
		PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_AHARONI_BOLD);
		PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
		PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
		tdid++;

		// Зданий фон текста 
		playerTD[tdid] = CreatePlayerTextDraw(playerid, 523.0000, 356.0000, "_");
		PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.0000, 1.4665);
		PlayerTextDrawTextSize(playerid, playerTD[tdid], 621.0000, 0.0000);
		PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[tdid], 0xFFFFFFFF);
		PlayerTextDrawUseBox(playerid, playerTD[tdid], true);
		PlayerTextDrawBoxColour(playerid, playerTD[tdid], 791621631);
		PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
		PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_AHARONI_BOLD);
		PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
		PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
		tdid++;

		playerTD[tdid] = CreatePlayerTextDraw(playerid, 573.0000, 354.0000, "Топ_убийц");
		PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.2766, 1.7825);
		PlayerTextDrawTextSize(playerid, playerTD[tdid], 0.0000, 75.0000);
		PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_CENTER);
		PlayerTextDrawColour(playerid, playerTD[tdid], -1162168065);
		PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
		PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_BANK_GOTHIC);
		PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
		PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
		tdid++;

		// Полоска
		playerTD[tdid] = CreatePlayerTextDraw(playerid, 600.0000, 370.0000, "_");
		PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.0000, 7.2999);
		PlayerTextDrawTextSize(playerid, playerTD[tdid], 599.0000, 0.0000);
		PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[tdid], 0xFFFFFFFF);
		PlayerTextDrawUseBox(playerid, playerTD[tdid], true);
		PlayerTextDrawBoxColour(playerid, playerTD[tdid], 791621631);
		PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
		PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_AHARONI_BOLD);
		PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
		PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
		tdid++;
		return 1;
	}

	// Ник
	playerTD[tdid] = CreatePlayerTextDraw(playerid, posX, posY, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.1519, 1.3717);
	PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[tdid], -606348801);
	PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
	PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
	PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
	tdid++;

	// Кол-во убийств
	playerTD[tdid] = CreatePlayerTextDraw(playerid, posX + 87.0, posY, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.1792, 1.3552);
	PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[tdid], -606348801);
	PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
	PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
	PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
	tdid++;
	return 1;
}