/*
 * |>=========================<|
 * |   About: Room textdraws   |
 * |   Author: Foxze           |
 * |>=========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- Room_CreatePlayerTopKillersTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
	- Room_CreatePlEndMatchStatsTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
	- Room_CreatePlayerMatchResultTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
	- Room_CreatePlayerTeamScoreTD(playerid, PlayerText:playerTD[], tdid, onetdid, const teamName[], teamColorXB)
	- Room_CreatePlayerLobbyTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:base, &tdid, playerNum = 0)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_ROOM_TD
	#endinput
#endif
#define _INC_ROOM_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define ROOM_TD_TOP_KILLERS			(3)
#define ROOM_TD_END_MATCH_STATS		(7)
#define ROOM_TD_MATCH_RESULT		(9)
#define ROOM_TD_TEAM_SCORE			(4)
#define ROOM_TD_LOBBY				(60)

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

stock Room_CreatePlayerTopKillersTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
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

stock Room_CreatePlEndMatchStatsTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
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

stock Room_CreatePlayerMatchResultTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY)
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
 * |>--------------<|
 * |   Team score   |
 * |>--------------<|
 */

stock Room_CreatePlayerTeamScoreTD(playerid, PlayerText:playerTD[], tdid, onetdid, const teamName[], teamColorXB)
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
				// Название команды
				playerTD[2] = CreatePlayerTextDraw(playerid, 326.000000, 29.000000, teamName);
				PlayerTextDrawLetterSize(playerid, playerTD[2], 0.322999, 1.259852);
				PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
				PlayerTextDrawColour(playerid, playerTD[2], teamColorXB);
				PlayerTextDrawSetShadow(playerid, playerTD[2], 1);
				PlayerTextDrawSetOutline(playerid, playerTD[2], 0);
				PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
				PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
				PlayerTextDrawSetProportional(playerid, playerTD[2], true);

				// Score
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
		}
	}
	return 1;
}

/*
 * |>---------<|
 * |   Lobby   |
 * |>---------<|
 */

stock Room_CreatePlayerLobbyTD(playerid, PlayerText:playerTD[], Float:posX, Float:posY, bool:base, &tdid, playerNum = 0)
{
	if(!base) {
		// Background
		playerTD[tdid] = CreatePlayerTextDraw(playerid, posX, posY, "_");
		PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_PREVIEW);
		PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[tdid], 0xFFFFFFFF);
		PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 0x00000000);
		PlayerTextDrawSetProportional(playerid, playerTD[tdid], false);
		PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
		PlayerTextDrawTextSize(playerid, playerTD[tdid], 120.0000, 33.0000);
		PlayerTextDrawSetPreviewModel(playerid, playerTD[tdid], 0);
		PlayerTextDrawSetPreviewRot(playerid, playerTD[tdid], 0.0000, 0.0000, 0.0000, 1000.0000);
		PlayerTextDrawSetSelectable(playerid, playerTD[tdid], true);
		tdid++;

		// Ник
		playerTD[tdid] = CreatePlayerTextDraw(playerid, posX + 2.0, posY, "_");
		PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.1760, 1.4008);
		PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[tdid], 0x00000000);
		PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
		PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_BANK_GOTHIC);
		PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
		PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
		tdid++;

		// Ранг
		playerTD[tdid] = CreatePlayerTextDraw(playerid, posX + 2.0, posY + 12.0, "_");
		PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.1896, 1.3469);
		PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_LEFT);
		PlayerTextDrawColour(playerid, playerTD[tdid], 0x00000000);
		PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
		PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_BANK_GOTHIC);
		PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
		PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
		tdid++;

		// Номер
		playerTD[tdid] = CreatePlayerTextDraw(playerid, posX + 118.0, posY - 1.0, "%i", playerNum);
		PlayerTextDrawLetterSize(playerid, playerTD[tdid], 0.2396, 1.2142);
		PlayerTextDrawAlignment(playerid, playerTD[tdid], TEXT_DRAW_ALIGN_RIGHT);
		PlayerTextDrawColour(playerid, playerTD[tdid], 0x00000000);
		PlayerTextDrawBackgroundColour(playerid, playerTD[tdid], 255);
		PlayerTextDrawFont(playerid, playerTD[tdid], TEXT_DRAW_FONT_BANK_GOTHIC);
		PlayerTextDrawSetProportional(playerid, playerTD[tdid], true);
		PlayerTextDrawSetShadow(playerid, playerTD[tdid], 0);
		tdid++;
		return 1;
	}

	// Основной задний фон
	playerTD[0] = CreatePlayerTextDraw(playerid, 195.0000, 150.0000, "Box");
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.0000, 21.5000);
	PlayerTextDrawTextSize(playerid, playerTD[0], 441.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], 1162167807);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 0);

	// Фон названия комнаты
	playerTD[1] = CreatePlayerTextDraw(playerid, 195.0000, 131.0000, "Box");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.0000, 1.5333);
	PlayerTextDrawTextSize(playerid, playerTD[1], 441.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[1], true);
	PlayerTextDrawBoxColour(playerid, playerTD[1], 606348543);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 255);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 0);

	// Фон названия команд
	playerTD[2] = CreatePlayerTextDraw(playerid, 195.0000, 150.0000, "Box");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.0000, 1.9000);
	PlayerTextDrawTextSize(playerid, playerTD[2], 441.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[2], true);
	PlayerTextDrawBoxColour(playerid, playerTD[2], 808464639);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 0);

	// Делящая полоска
	playerTD[3] = CreatePlayerTextDraw(playerid, 321.0000, 170.0000, "Box");
	PlayerTextDrawLetterSize(playerid, playerTD[3], 0.0000, 19.3000);
	PlayerTextDrawTextSize(playerid, playerTD[3], 315.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[3], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[3], true);
	PlayerTextDrawBoxColour(playerid, playerTD[3], 808464639);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 255);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[3], true);
	PlayerTextDrawSetShadow(playerid, playerTD[3], 0);

	// Название комнаты
	playerTD[4] = CreatePlayerTextDraw(playerid, 320.0000, 130.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.2723, 1.4548);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[4], -505290753);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 255);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);
	PlayerTextDrawSetShadow(playerid, playerTD[4], 0);

	// Название команды 1
	playerTD[5] = CreatePlayerTextDraw(playerid, 255.0000, 150.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.2866, 1.6207);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[5], 1079894015);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 255);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);
	PlayerTextDrawSetShadow(playerid, playerTD[5], 0);

	// Название команды 1
	playerTD[6] = CreatePlayerTextDraw(playerid, 380.0000, 150.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.2866, 1.6207);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[6], -547660801);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 255);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);
	PlayerTextDrawSetShadow(playerid, playerTD[6], 0);

	// Timer
	playerTD[7] = CreatePlayerTextDraw(playerid, 318.0000, 151.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.3253, 1.6041);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 255);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);
	PlayerTextDrawSetShadow(playerid, playerTD[7], 0);

	// Белый фон выхода
	playerTD[8] = CreatePlayerTextDraw(playerid, 194.0000, 347.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[8], false);
	PlayerTextDrawSetShadow(playerid, playerTD[8], 0);
	PlayerTextDrawTextSize(playerid, playerTD[8], 45.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[8], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[8], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Чёрный фон выхода
	playerTD[9] = CreatePlayerTextDraw(playerid, 195.0000, 348.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[9], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[9], false);
	PlayerTextDrawSetShadow(playerid, playerTD[9], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[9], true);
	PlayerTextDrawTextSize(playerid, playerTD[9], 43.0000, 20.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[9], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[9], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[10] = CreatePlayerTextDraw(playerid, 217.0000, 349.0000, "Выйти");
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, playerTD[10], 15.0000, 42.0000);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[10], -76911105);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], -1);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);
	PlayerTextDrawSetShadow(playerid, playerTD[10], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[10], true);

	// Белый фон инфо
	playerTD[11] = CreatePlayerTextDraw(playerid, 242.0000, 347.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[11], false);
	PlayerTextDrawSetShadow(playerid, playerTD[11], 0);
	PlayerTextDrawTextSize(playerid, playerTD[11], 45.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[11], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[11], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Чёрный фон ифно
	playerTD[12] = CreatePlayerTextDraw(playerid, 243.0000, 348.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[12], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[12], false);
	PlayerTextDrawSetShadow(playerid, playerTD[12], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[12], true);
	PlayerTextDrawTextSize(playerid, playerTD[12], 43.0000, 20.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[12], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[12], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[13] = CreatePlayerTextDraw(playerid, 265.0000, 349.0000, "Инфо");
	PlayerTextDrawLetterSize(playerid, playerTD[13], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, playerTD[13], 15.0000, 42.0000);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[13], -741977345);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[13], true);
	PlayerTextDrawSetShadow(playerid, playerTD[13], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[13], true);

	// Белый фон параметров
	playerTD[14] = CreatePlayerTextDraw(playerid, 290.0000, 347.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[14], false);
	PlayerTextDrawSetShadow(playerid, playerTD[14], 0);
	PlayerTextDrawTextSize(playerid, playerTD[14], 77.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[14], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[14], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Чёрный фон параметров
	playerTD[15] = CreatePlayerTextDraw(playerid, 291.0000, 348.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[15], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[15], false);
	PlayerTextDrawSetShadow(playerid, playerTD[15], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[15], true);
	PlayerTextDrawTextSize(playerid, playerTD[15], 75.0000, 20.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[15], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[15], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[16] = CreatePlayerTextDraw(playerid, 328.0000, 349.0000, "Параметры");
	PlayerTextDrawLetterSize(playerid, playerTD[16], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, playerTD[16], 15.0000, 76.0000);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[16], 1422643711);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[16], true);
	PlayerTextDrawSetShadow(playerid, playerTD[16], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[16], true);

	// Белый фон команды
	playerTD[17] = CreatePlayerTextDraw(playerid, 370.0000, 347.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[17], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[17], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[17], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[17], -1717986817);
	PlayerTextDrawSetProportional(playerid, playerTD[17], false);
	PlayerTextDrawSetShadow(playerid, playerTD[17], 0);
	PlayerTextDrawTextSize(playerid, playerTD[17], 72.0000, 22.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[17], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[17], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Чёрный фон команды
	playerTD[18] = CreatePlayerTextDraw(playerid, 371.0000, 348.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[18], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[18], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[18], 303174399);
	PlayerTextDrawSetProportional(playerid, playerTD[18], false);
	PlayerTextDrawSetShadow(playerid, playerTD[18], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[18], true);
	PlayerTextDrawTextSize(playerid, playerTD[18], 70.0000, 20.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[18], 0);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[18], 0.0000, 0.0000, 0.0000, 1000.0000);

	playerTD[19] = CreatePlayerTextDraw(playerid, 406.0000, 349.0000, "Команда");
	PlayerTextDrawLetterSize(playerid, playerTD[19], 0.2396, 1.8198);
	PlayerTextDrawTextSize(playerid, playerTD[19], 15.0000, 70.0000);
	PlayerTextDrawAlignment(playerid, playerTD[19], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[19], 2127647487);
	PlayerTextDrawBackgroundColour(playerid, playerTD[19], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[19], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[19], true);
	PlayerTextDrawSetShadow(playerid, playerTD[19], 0);
	PlayerTextDrawSetSelectable(playerid, playerTD[19], true);

	tdid = 20;
	return 1;
}