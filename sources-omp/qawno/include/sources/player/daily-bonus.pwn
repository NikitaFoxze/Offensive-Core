/*

	About: Daily-bonus system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnPlayerConnect(playerid)
	Stock:
		DailyB_CheckPlayer(playerid)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	DailyBonus
------------------------------------------------------------------------------*/

#if defined _INC_DAILY_BONUS_SYSTEM
	#endinput
#endif
#define _INC_DAILY_BONUS_SYSTEM

/*

	* Vars *

*/

static
	PlayerText:TD_DailyBonus[MAX_PLAYERS][11];

static const
	DailyBonusRewardInfo[MAX_DAILY_DAYS][3] = {
		// Награда за посещение сервера
		// Опыт, кредиты, Gold coins

		/* 0 */ {300, 150, 5},
		/* 1 */ {400, 300, 7},
		/* 2 */ {500, 350, 10},
		/* 3 */ {700, 400, 13},
		/* 4 */ {1000, 500, 17},
		/* 5 */ {2000, 1000, 20},
		/* 6 */ {2600, 1500, 25},
		/* 7 */ {3000, 2000, 30},
		/* 8 */ {4000, 3500, 35},
		/* 9 */ {6000, 4100, 40}
	};

/*

	* Functions *

*/

stock DailyB_CheckPlayer(playerid)
{
	if(pInfo[playerid][pBDays] < MAX_DAILY_DAYS) {
		if(gettime() > pInfo[playerid][pBData]) {
			Interface_Show(playerid, Interface:DailyBonus);
			return 1;
		}
	}
	return 0;
}

static ShowTDPlayerDailyBonus(playerid)
{
	// Задний жёлтый фон
	TD_DailyBonus[playerid][0] = CreatePlayerTextDraw(playerid, 273.0000, 170.0000, "_");
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][0], -1);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][0], -1147842305);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][0], false);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][8], 0);
	PlayerTextDrawTextSize(playerid, TD_DailyBonus[playerid][0], 90.0000, 90.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_DailyBonus[playerid][0], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_DailyBonus[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон
	TD_DailyBonus[playerid][1] = CreatePlayerTextDraw(playerid, 273.6665, 170.8296, "_");
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][1], -1);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][1], 303174399);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][1], false);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][1], 0);
	PlayerTextDrawTextSize(playerid, TD_DailyBonus[playerid][1], 89.0000, 88.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_DailyBonus[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_DailyBonus[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний белый фон кнопки забрать
	TD_DailyBonus[playerid][2] = CreatePlayerTextDraw(playerid, 273.0000, 262.0000, "_");
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][2], -1);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][2], -1717986817);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][2], false);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][2], 0);
	PlayerTextDrawTextSize(playerid, TD_DailyBonus[playerid][2], 90.0000, 21.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_DailyBonus[playerid][2], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_DailyBonus[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон кнопки забрать
	TD_DailyBonus[playerid][3] = CreatePlayerTextDraw(playerid, 274.0000, 263.0000, "_");
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][3], -1);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][3], 303174399);
	PlayerTextDrawSetSelectable(playerid, TD_DailyBonus[playerid][3], true);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][3], false);
	PlayerTextDrawTextSize(playerid, TD_DailyBonus[playerid][3], 88.0000, 19.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_DailyBonus[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_DailyBonus[playerid][3], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_DailyBonus[playerid][4] = CreatePlayerTextDraw(playerid, 318.0000, 264.0000, "Забрать");
	PlayerTextDrawLetterSize(playerid, TD_DailyBonus[playerid][4], 0.3379, 1.6871);
	PlayerTextDrawTextSize(playerid, TD_DailyBonus[playerid][4], 15.0000, 88.0000);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][4], -1145325057);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][4], 255);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][4], 0);
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][4], true);
	PlayerTextDrawSetSelectable(playerid, TD_DailyBonus[playerid][4], true);

	// Задний чёрный фон бонус
	TD_DailyBonus[playerid][5] = CreatePlayerTextDraw(playerid, 273.0000, 152.0000, "_");
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][5], -1);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][5], 303174399);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][5], false);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][5], 0);
	PlayerTextDrawTextSize(playerid, TD_DailyBonus[playerid][5], 90.0000, 16.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_DailyBonus[playerid][5], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_DailyBonus[playerid][5], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_DailyBonus[playerid][6] = CreatePlayerTextDraw(playerid, 318.0000, 151.0000, "Ежедневный_бонус");
	PlayerTextDrawLetterSize(playerid, TD_DailyBonus[playerid][6], 0.1939, 1.8156);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][6], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][6], -303174657);
	PlayerTextDrawSetOutline(playerid, TD_DailyBonus[playerid][6], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][6], 80);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][6], 0);
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][6], true);

	// Кол-во дней
	TD_DailyBonus[playerid][7] = CreatePlayerTextDraw(playerid, 360.0000, 242.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_DailyBonus[playerid][7], 0.2386, 1.5874);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][7], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][7], 1637533439);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][7], 80);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][7], 0);
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][7], true);

	// Опыт
	TD_DailyBonus[playerid][8] = CreatePlayerTextDraw(playerid, 319.0000, 174.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_DailyBonus[playerid][8], 0.2375, 1.8156);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][8], -409396993);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][8], 80);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][8], 0);
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][8], true);

	// Кредиты
	TD_DailyBonus[playerid][9] = CreatePlayerTextDraw(playerid, 319.0000, 190.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_DailyBonus[playerid][9], 0.2375, 1.8156);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][9], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][9], 649482239);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][9], 80);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][9], 0);
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][9], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][9], true);

	// Gold coins
	TD_DailyBonus[playerid][10] = CreatePlayerTextDraw(playerid, 319.0000, 206.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_DailyBonus[playerid][10], 0.2375, 1.8156);
	PlayerTextDrawAlignment(playerid, TD_DailyBonus[playerid][10], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DailyBonus[playerid][10], -371844865);
	PlayerTextDrawBackgroundColour(playerid, TD_DailyBonus[playerid][10], 80);
	PlayerTextDrawSetShadow(playerid, TD_DailyBonus[playerid][10], 0);
	PlayerTextDrawFont(playerid, TD_DailyBonus[playerid][10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DailyBonus[playerid][10], true);
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerTDs(playerid)
{
	n_for(i, sizeof(TD_DailyBonus[]))
		TD_DailyBonus[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

/*

	* Interfaces *

*/

InterfaceCreate:DailyBonus(playerid)
{
	static
		str[25];
	
	str[0] = EOS;

	new
		num = pInfo[playerid][pBDays],
		nums = pInfo[playerid][pBDays] - 1;

	ShowTDPlayerDailyBonus(playerid);

	f(str, "День:_%i", num);
	PlayerTextDrawSetString(playerid, TD_DailyBonus[playerid][7], str);
	str[0] = EOS;

	f(str, "+%i опыта", DailyBonusRewardInfo[nums][0]);
	PlayerTextDrawSetString(playerid, TD_DailyBonus[playerid][8], str);
	str[0] = EOS;

	f(str, "+%i кредитов", DailyBonusRewardInfo[nums][1]);
	PlayerTextDrawSetString(playerid, TD_DailyBonus[playerid][9], str);
	str[0] = EOS;

	f(str, "+%i Gold coins", DailyBonusRewardInfo[nums][2]);
	PlayerTextDrawSetString(playerid, TD_DailyBonus[playerid][10], str);

	n_for(i, sizeof(TD_DailyBonus[]))
		PlayerTextDrawShow(playerid, TD_DailyBonus[playerid][i]);

	SelectTextDraw(playerid, 0xAFAFAFAA);
	return 1;
}

InterfaceClose:DailyBonus(playerid)
{
	n_for(i, sizeof(TD_DailyBonus[]))
		DestroyPlayerTD(playerid, TD_DailyBonus[playerid][i]);

	return 1;
}

InterfacePlayerClick:DailyBonus(playerid, PlayerText:playertextid)
{
	if(playertextid == TD_DailyBonus[playerid][4]) {
		new
			nums = pInfo[playerid][pBDays] - 1;

		SetPlayerExp(playerid, DailyBonusRewardInfo[nums][0]);
		SetPlayerCredit(playerid, DailyBonusRewardInfo[nums][1]);
		SetPlayerGoldCoins(playerid, DailyBonusRewardInfo[nums][2]);

		pInfo[playerid][pBDays]++;
		pInfo[playerid][pBData] = gettime() + 1 * 60 * 60 * 24;

		static 
			query[150];
		
		query[0] = EOS;

		mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `BData` = '%i' WHERE `ID` = '%d'", pInfo[playerid][pBData], GetPlayerpID(playerid));
		mysql_tquery(MysqlID, query);
		query[0] = EOS;

		mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `BDays` = '%i' WHERE `ID` = '%d'", pInfo[playerid][pBDays], GetPlayerpID(playerid));
		mysql_tquery(MysqlID, query);

		Interface_Close(playerid, Interface:DailyBonus);

		EnterPlayerMainMenu(playerid);
	}
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerTDs(playerid);

	#if defined DailyB_OnPlayerConnect
		return DailyB_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	ALS
*/

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect DailyB_OnPlayerConnect
#if defined DailyB_OnPlayerConnect
	forward DailyB_OnPlayerConnect(playerid);
#endif