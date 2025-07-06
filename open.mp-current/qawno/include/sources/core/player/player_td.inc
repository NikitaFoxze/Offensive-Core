/*
 * |>===========================<|
 * |   About: Player textdraws   |
 * |   Author: Foxze             |
 * |>===========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- CreatePlayerKillStrikeTD(playerid, &PlayerText:playerTD)
	- CreatePlayerSpawnKillTD(playerid, &PlayerText:playerTD)
	- CreatePlayerNewRankTD(playerid, &PlayerText:playerTD)
	- CreatePlayerAfterDeadTD2(playerid, &PlayerText:playerTD)
	- CreatePlayerExitZoneTD(playerid, PlayerText:playerTD[])
	- CreatePlayerDeadKillerTD2(playerid, PlayerText:playerTD[])
	- CreatePlayerStatsMatchTD(playerid, PlayerText:playerTD[], playerRank, playerKills, playerDeaths)
	- CreatePlayerNetGraphTD2(playerid, PlayerText:playerTD[])
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
    - (None)
 */

#if defined _INC_PLAYER_TD
	#endinput
#endif
#define _INC_PLAYER_TD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define PLAYER_TD_EXIT_ZONE		(5)
#define PLAYER_TD_DEAD_KILLER	(17)
#define PLAYER_TD_MATCH_STATS	(3)
#define PLAYER_TD_NET_GRAPH		(3)

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>---------------<|
 * |   Kill strike   |
 * |>---------------<|
 */

stock CreatePlayerKillStrikeTD(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 317.000000, 364.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD, 0.249666, 1.010963);
	PlayerTextDrawTextSize(playerid, playerTD, 0.000000, 74.000000);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD, -653192773);
	PlayerTextDrawSetShadow(playerid, playerTD, 0);
	PlayerTextDrawUseBox(playerid, playerTD, true);
	PlayerTextDrawBoxColour(playerid, playerTD, 187);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 255);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	return 1;
}

/*
 * |>--------------<|
 * |   Spawn kill   |
 * |>--------------<|
 */

stock CreatePlayerSpawnKillTD(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 320.000000, 343.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD, 0.282332, 1.558518);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD, 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD, true);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 80);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	return 1;
}

/*
 * |>------------<|
 * |   New rank   |
 * |>------------<|
 */

stock CreatePlayerNewRankTD(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 326.000000, 80.000000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD, 0.278999, 1.263999);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD, 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, playerTD, 0);
	PlayerTextDrawSetOutline(playerid, playerTD, 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 48);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	return 1;
}

/*
 * |>--------------<|
 * |   After dead   |
 * |>--------------<|
 */

stock CreatePlayerAfterDeadTD2(playerid, &PlayerText:playerTD)
{
	playerTD = CreatePlayerTextDraw(playerid, 318.0000, 115.0000, "Убит_в_бою");
	PlayerTextDrawLetterSize(playerid, playerTD, 0.3429, 1.7451);
	PlayerTextDrawAlignment(playerid, playerTD, TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD, -534633729);
	PlayerTextDrawSetOutline(playerid, playerTD, 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD, 255);
	PlayerTextDrawFont(playerid, playerTD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD, true);
	PlayerTextDrawSetShadow(playerid, playerTD, 0);
	return 1;
}

/*
 * |>-------------<|
 * |   Exit zone   |
 * |>-------------<|
 */

stock CreatePlayerExitZoneTD(playerid, PlayerText:playerTD[])
{
	// Основной задний фон
	playerTD[0] = CreatePlayerTextDraw(playerid, 0.0000, 0.0000, "Box");
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.0000, 50.6665);
	PlayerTextDrawTextSize(playerid, playerTD[0], 646.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], 80);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);

	playerTD[1] = CreatePlayerTextDraw(playerid, 320.0000, 195.0000, "Выход_из_боевой_зоны");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.2749, 1.4548);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[1], -1136573953);
	PlayerTextDrawSetOutline(playerid, playerTD[1], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 21);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);

	playerTD[2] = CreatePlayerTextDraw(playerid, 320.0000, 215.0000, "Вернитесь_обратно!");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.2749, 1.4548);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[2], -1339019009);
	PlayerTextDrawSetOutline(playerid, playerTD[2], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 32);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);

	playerTD[3] = CreatePlayerTextDraw(playerid, 320.0000, 250.0000, "Смерть_наступит_через:_10");
	PlayerTextDrawLetterSize(playerid, playerTD[3], 0.2749, 1.4548);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[3], -1037621249);
	PlayerTextDrawSetOutline(playerid, playerTD[3], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 32);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[3], true);

	playerTD[4] = CreatePlayerTextDraw(playerid, 311.0000, 237.0000, "_");
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[4], -579241473);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 0x00000000);
	PlayerTextDrawTextSize(playerid, playerTD[4], 15.0000, 13.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[4], 1254);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[4], 0.0000, 0.0000, 0.0000, 1.0000);
	return 1;
}

/*
 * |>---------------<|
 * |   Dead killer   |
 * |>---------------<|
 */

stock CreatePlayerDeadKillerTD2(playerid, PlayerText:playerTD[])
{
	// Задний фон ника
	playerTD[0] = CreatePlayerTextDraw(playerid, 240.0000, 311.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.0000, 0.9666);
	PlayerTextDrawTextSize(playerid, playerTD[0], 400.6666, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], -620362002);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);

	// Ник
	playerTD[1] = CreatePlayerTextDraw(playerid, 241.0000, 308.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.2643, 1.4257);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], -488447745);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 128);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 1);

	// Задний фон хп и брони
	playerTD[2] = CreatePlayerTextDraw(playerid, 240.0000, 325.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.0000, 5.8333);
	PlayerTextDrawTextSize(playerid, playerTD[2], 291.3333, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[2], true);
	PlayerTextDrawBoxColour(playerid, playerTD[2], 1145194478);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 255);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);

	playerTD[3] = CreatePlayerTextDraw(playerid, 266.0000, 326.0000, "Здоровье:");
	PlayerTextDrawLetterSize(playerid, playerTD[3], 0.1916, 1.4216);
	PlayerTextDrawAlignment(playerid, playerTD[3], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[3], -690563841);
	PlayerTextDrawBackgroundColour(playerid, playerTD[3], 16);
	PlayerTextDrawFont(playerid, playerTD[3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[3], true);

	// Здоровье
	playerTD[4] = CreatePlayerTextDraw(playerid, 265.0000, 338.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[4], 0.2613, 1.4050);
	PlayerTextDrawTextSize(playerid, playerTD[4], 0.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, playerTD[4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[4], -651745281);
	PlayerTextDrawBackgroundColour(playerid, playerTD[4], 16);
	PlayerTextDrawFont(playerid, playerTD[4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[4], true);

	playerTD[5] = CreatePlayerTextDraw(playerid, 266.0000, 350.0000, "Броня:");
	PlayerTextDrawLetterSize(playerid, playerTD[5], 0.1916, 1.4216);
	PlayerTextDrawAlignment(playerid, playerTD[5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[5], -690563841);
	PlayerTextDrawBackgroundColour(playerid, playerTD[5], 16);
	PlayerTextDrawFont(playerid, playerTD[5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[5], true);

	// Броня
	playerTD[6] = CreatePlayerTextDraw(playerid, 265.0000, 362.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[6], 0.2613, 1.4050);
	PlayerTextDrawTextSize(playerid, playerTD[6], 0.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, playerTD[6], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[6], 1168234239);
	PlayerTextDrawBackgroundColour(playerid, playerTD[6], 16);
	PlayerTextDrawFont(playerid, playerTD[6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[6], true);

	// Задний фон ранга
	playerTD[7] = CreatePlayerTextDraw(playerid, 296.0000, 325.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[7], 0.0000, 5.8333);
	PlayerTextDrawTextSize(playerid, playerTD[7], 401.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[7], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[7], true);
	PlayerTextDrawBoxColour(playerid, playerTD[7], 1145194478);
	PlayerTextDrawBackgroundColour(playerid, playerTD[7], 255);
	PlayerTextDrawFont(playerid, playerTD[7], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[7], true);

	// Картинка
	playerTD[8] = CreatePlayerTextDraw(playerid, 340.0000, 325.0000, "_");
	PlayerTextDrawTextSize(playerid, playerTD[8], 54.0000, 52.0000);
	PlayerTextDrawAlignment(playerid, playerTD[8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[8], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, playerTD[8], 255);
	PlayerTextDrawFont(playerid, playerTD[8], TEXT_DRAW_FONT_SPRITE);
	PlayerTextDrawSetProportional(playerid, playerTD[8], false);

	playerTD[9] = CreatePlayerTextDraw(playerid, 317.0000, 336.0000, "Ранг:");
	PlayerTextDrawLetterSize(playerid, playerTD[9], 0.1916, 1.4216);
	PlayerTextDrawAlignment(playerid, playerTD[9], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[9], -690563841);
	PlayerTextDrawBackgroundColour(playerid, playerTD[9], 16);
	PlayerTextDrawFont(playerid, playerTD[9], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[9], true);

	// Ранг
	playerTD[10] = CreatePlayerTextDraw(playerid, 316.0000, 348.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[10], 0.2613, 1.4050);
	PlayerTextDrawTextSize(playerid, playerTD[10], 0.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, playerTD[10], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[10], -35964161);
	PlayerTextDrawBackgroundColour(playerid, playerTD[10], 16);
	PlayerTextDrawFont(playerid, playerTD[10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[10], true);

	// Задний фон оружия
	playerTD[11] = CreatePlayerTextDraw(playerid, 305.0000, 383.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[11], 0.0000, 4.9333);
	PlayerTextDrawTextSize(playerid, playerTD[11], 401.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[11], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[11], true);
	PlayerTextDrawBoxColour(playerid, playerTD[11], 1145194478);
	PlayerTextDrawBackgroundColour(playerid, playerTD[11], 255);
	PlayerTextDrawFont(playerid, playerTD[11], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[11], true);

	// Объект оружия
	playerTD[12] = CreatePlayerTextDraw(playerid, 316.0000, 382.0000, "_");
	PlayerTextDrawAlignment(playerid, playerTD[12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[12], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, playerTD[12], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, playerTD[12], false);
	PlayerTextDrawBackgroundColour(playerid, playerTD[12], 0x00000000);
	PlayerTextDrawTextSize(playerid, playerTD[12], 70.0000, 47.0000);
	PlayerTextDrawSetPreviewModel(playerid, playerTD[12], 356);
	PlayerTextDrawSetPreviewRot(playerid, playerTD[12], 0.0000, 30.0000, 900.0000, 2.0000);

	// Название оружия
	playerTD[13] = CreatePlayerTextDraw(playerid, 353.0000, 414.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[13], 0.1750, 1.5004);
	PlayerTextDrawAlignment(playerid, playerTD[13], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[13], -690563841);
	PlayerTextDrawBackgroundColour(playerid, playerTD[13], 16);
	PlayerTextDrawFont(playerid, playerTD[13], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[13], true);

	// Задний фон таймера
	playerTD[14] = CreatePlayerTextDraw(playerid, 240.0000, 383.0000, "_");
	PlayerTextDrawLetterSize(playerid, playerTD[14], 0.0000, 4.9333);
	PlayerTextDrawTextSize(playerid, playerTD[14], 300.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[14], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[14], true);
	PlayerTextDrawBoxColour(playerid, playerTD[14], 1145194478);
	PlayerTextDrawBackgroundColour(playerid, playerTD[14], 255);
	PlayerTextDrawFont(playerid, playerTD[14], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[14], true);

	playerTD[15] = CreatePlayerTextDraw(playerid, 270.0000, 400.0000, "Спавн_через:");
	PlayerTextDrawLetterSize(playerid, playerTD[15], 0.1916, 1.4216);
	PlayerTextDrawAlignment(playerid, playerTD[15], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[15], -690563841);
	PlayerTextDrawBackgroundColour(playerid, playerTD[15], 16);
	PlayerTextDrawFont(playerid, playerTD[15], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[15], true);

	playerTD[16] = CreatePlayerTextDraw(playerid, 270.0000, 385.0000, "Клик_на_ЛКМ");
	PlayerTextDrawLetterSize(playerid, playerTD[16], 0.1726, 1.4216);
	PlayerTextDrawAlignment(playerid, playerTD[16], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, playerTD[16], -692027393);
	PlayerTextDrawBackgroundColour(playerid, playerTD[16], 16);
	PlayerTextDrawFont(playerid, playerTD[16], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[16], true);
	return 1;
}

/*
 * |>---------------<|
 * |   Match stats   |
 * |>---------------<|
 */

stock CreatePlayerStatsMatchTD(playerid, PlayerText:playerTD[], playerRank, playerKills, playerDeaths)
{
	playerTD[0] = CreatePlayerTextDraw(playerid, 30.0000, 268.0000, "Ранг: %i", playerRank);
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.2081, 1.3839);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], -34978049);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 153);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);
	PlayerTextDrawSetShadow(playerid, playerTD[0], 1);

	playerTD[1] = CreatePlayerTextDraw(playerid, 30.0000, 280.0000, "Убийств: %i", playerKills);
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.2081, 1.3840);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[1], 2121985279);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 153);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);

	playerTD[2] = CreatePlayerTextDraw(playerid, 30.0000, 292.000, "Смертей: %i", playerDeaths);
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.2081, 1.3840);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], -327254273);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 153);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	return 1;
}

/*
 * |>-------------<|
 * |   Net Graph   |
 * |>-------------<|
 */

stock CreatePlayerNetGraphTD2(playerid, PlayerText:playerTD[])
{
	playerTD[0] = CreatePlayerTextDraw(playerid, 487.0000, 103.0000, "Box");
	PlayerTextDrawLetterSize(playerid, playerTD[0], 0.0000, 0.8999);
	PlayerTextDrawTextSize(playerid, playerTD[0], 620.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, playerTD[0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, playerTD[0], true);
	PlayerTextDrawBoxColour(playerid, playerTD[0], 0x00000000);
	PlayerTextDrawBackgroundColour(playerid, playerTD[0], 255);
	PlayerTextDrawFont(playerid, playerTD[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, playerTD[0], true);

	// FPS
	playerTD[1] = CreatePlayerTextDraw(playerid, 540.0000, 100.0000, "FPS:_~g~60");
	PlayerTextDrawLetterSize(playerid, playerTD[1], 0.2506, 1.3634);
	PlayerTextDrawAlignment(playerid, playerTD[1], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, playerTD[1], -960051969);
	PlayerTextDrawSetShadow(playerid, playerTD[1], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[1], 128);
	PlayerTextDrawFont(playerid, playerTD[1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[1], true);

	// PING
	playerTD[2] = CreatePlayerTextDraw(playerid, 560.0000, 100.0000, "Ping:_~r~50");
	PlayerTextDrawLetterSize(playerid, playerTD[2], 0.2506, 1.3634);
	PlayerTextDrawAlignment(playerid, playerTD[2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, playerTD[2], -960051969);
	PlayerTextDrawSetShadow(playerid, playerTD[2], 1);
	PlayerTextDrawBackgroundColour(playerid, playerTD[2], 128);
	PlayerTextDrawFont(playerid, playerTD[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, playerTD[2], true);
	return 1;
}