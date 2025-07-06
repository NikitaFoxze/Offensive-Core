/*
 * |>==========================<|
 * |   About: Modes textdraws   |
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
	- Mode_CreatePlayerMatchPointsTD(playerid, PlayerText:playerTD)
	- Mode_CreatePlSessionTimerTD(playerid, PlayerText:playerTD)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_MODES_TD
	#endinput
#endif
#define _INC_MODES_TD

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>----------------<|
 * |   Match Points   |
 * |>----------------<|
 */

stock Mode_CreatePlayerMatchPointsTD(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 30.0000, 304.0000, "Очков матча:_0");
	PlayerTextDrawLetterSize(playerid, playerTD, 0.2081, 1.3840);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD, -325353729);
	PlayerTextDrawSetShadow(playerid, playerTD, 1);
	PlayerTextDrawSetOutline(playerid, playerTD, 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 153);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	return 1;
}

/*
 * |>-----------------<|
 * |   Session Timer   |
 * |>-----------------<|
 */

stock Mode_CreatePlSessionTimerTD(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 321.000000, 14.000000, "00:00");
	PlayerTextDrawLetterSize(playerid, playerTD, 0.329000, 1.467259);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD, 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD, 0);
	PlayerTextDrawSetOutline(playerid, playerTD, 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 13107);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	return 1;
}