/*
 * |>=================================<|
 * |   About: TDM location textdraws   |
 * |   Author: Foxze                   |
 * |>=================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- TDM_CreatePlayerCaptPointTD(playerid, &PlayerText:playerTD)
	- TDM_CreatePlayerHackCompTD(playerid, &PlayerText:playerTD)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_TDM_LOC_TD
	#endinput
#endif
#define _INC_TDM_LOC_TD

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>-----------------<|
 * |   Capture point   |
 * |>-----------------<|
 */

stock TDM_CreatePlayerCaptPointTD(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 321.0000, 277.0000, "_"); 
	PlayerTextDrawLetterSize(playerid, playerTD, 0.1576, 1.1022);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD, 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 255);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	PlayerTextDrawSetShadow(playerid, playerTD, 0);
	return 1;
}

/*
 * |>-----------------<|
 * |   Hack computer   |
 * |>-----------------<|
 */

stock TDM_CreatePlayerHackCompTD(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 321.000000, 241.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD, 0.136333, 0.840887);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD, 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD, 0);
	PlayerTextDrawSetOutline(playerid, playerTD, 0);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 255);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	return 1;
}