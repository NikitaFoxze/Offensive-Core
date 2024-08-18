/*

	About: Trading-platform system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnPlayerConnect(playerid)
	Stock:
		-
Enums:
	E_PLAYER_TP_TD_INFO
Commands:
	-
Dialogs:
	TP_BuyItemInfo
	TP_BuyItem
Interfaces:
	TradingPlatform
------------------------------------------------------------------------------*/

#if defined _INC_TRADING_PLATFORM_SYSTEM
	#endinput
#endif
#define _INC_TRADING_PLATFORM_SYSTEM

/*

	* Enums *

*/

enum E_PLAYER_TP_TD_INFO {
	TP_BuyItems,
	TP_Block,
	TP_Page,
	bool:TP_ActiveSelect,
	TP_ItemID[TRADING_PLAT_MAX_HOW_ITEMS],
	TP_Credits[TRADING_PLAT_MAX_HOW_ITEMS],
	TP_GoldCoins[TRADING_PLAT_MAX_HOW_ITEMS]
}

/*

	* Vars *

*/

static
	TP_PlayerInfo[MAX_PLAYERS][E_PLAYER_TP_TD_INFO];

static
	PlayerText:TD_BTradingPlatform[MAX_PLAYERS][8],
	PlayerText:TD_TPBlocks[MAX_PLAYERS][20],
	PlayerText:TD_TPItem[MAX_PLAYERS][18],
	PlayerText:TD_TradingPlatform[MAX_PLAYERS][23];

static
	StatusTradingPlatform[MAX_PLAYERS];

static const
	TP_HeadBandana[19][3] = { // Банданы

	{351, 15000, 0},
	{352, 15000, 0},
	{356, 20000, 0},
	{357, 20000, 0},
	{358, 20000, 0},
	{365, 20000, 0},
	{367, 20000, 0},
	{353, 26000, 0},
	{354, 30000, 0},
	{359, 40000, 0},
	{355, 50000, 0},
	{362, 50000, 0},
	{368, 50000, 0},
	{363, 60000, 0},
	{364, 60000, 0},
	{361, 70000, 0},
	{360, 80000, 0},
	{366, 100000, 0},
	{369, 100000, 0}
};

static const
	TP_HeadHat[8][3] = { // Шапки

	{342, 30000, 0},
	{343, 30000, 0},
	{344, 40000, 0},
	{345, 40000, 0},
	{347, 50000, 0},
	{348, 60000, 0},
	{349, 65000, 0},
	{346, 90000, 0}
};

static const
	TP_HeadCap[19][3] = { // Кепки

	{330, 5000, 0},
	{331, 5000, 0},
	{332, 5000, 0},
	{325, 6000, 0},
	{335, 10000, 0},
	{323, 15000, 0},
	{326, 20000, 0},
	{333, 30000, 0},
	{341, 40000, 0},
	{322, 45000, 0},
	{334, 50000, 0},
	{339, 55000, 0},
	{340, 57000, 0},
	{324, 70000, 0},
	{338, 80000, 0},
	{319, 90000, 0},
	{320, 95000, 0},
	{321, 95000, 0},
	{336, 100000, 0}
};

static const
	TP_HeadHat2[32][3] = { // Шляпы

	{398, 10000, 0},
	{370, 20000, 0},
	{371, 30000, 0},
	{400, 35000, 0},
	{401, 36000, 0},
	{402, 38000, 0},
	{403, 39000, 0},
	{385, 40000, 0},
	{386, 45000, 0},
	{387, 46000, 0},
	{388, 47000, 0},
	{389, 48000, 0},
	{393, 50000, 0},
	{390, 55000, 0},
	{391, 60000, 0},
	{392, 60000, 0},
	{382, 70000, 0},
	{383, 70000, 0},
	{410, 81000, 0},
	{395, 80000, 0},
	{396, 80000, 0},
	{394, 90000, 0},
	{397, 90000, 0},
	{404, 95000, 0},
	{405, 95000, 0},
	{399, 100000, 0},
	{406, 110000, 0},
	{407, 110000, 0},
	{408, 110000, 0},
	{409, 130000, 0},
	{411, 500000, 0},
	{412, 1000000, 0}
};

static const
	TP_HeadHelmet[13][3] = { // Каски

	{384, 9000, 0},
	{378, 10000, 0},
	{379, 11000, 0},
	{380, 12000, 0},
	{381, 13000, 0},
	{372, 15000, 0},
	{374, 16000, 0},
	{373, 17000, 0},
	{375, 20000, 0},
	{317, 50000, 0},
	{318, 50000, 0},
	{377, 90000, 0},
	{376, 100000, 0}
};

static const
	TP_HeadPhones[4][3] = { // Наушники

	{413, 100000, 0},
	{414, 100000, 0},
	{415, 100000, 0},
	{416, 100000, 0}
};

static const
	TP_GlassesStylish[3][3] = { // Модные очки

	{417, 40000, 0},
	{419, 50000, 0},
	{418, 60000, 0}
};

static const
	TP_GlassesShine[11][3] = { // С блеском очки

	{429, 1000, 0},
	{421, 2000, 0},
	{420, 3000, 0},
	{442, 3500, 0},
	{422, 5000, 0},
	{423, 6000, 0},
	{426, 8000, 0},
	{427, 8000, 0},
	{424, 9000, 0},
	{428, 10000, 0},
	{425, 13000, 0}
};

static const
	TP_GlassesAviator[10][3] = { // Авиаторские очки

	{430, 15000, 0},
	{431, 17000, 0},
	{432, 20000, 0},
	{437, 20000, 0},
	{433, 25000, 0},
	{438, 26000, 0},
	{439, 26000, 0},
	{434, 30000, 0},
	{435, 30000, 0},
	{436, 35000, 0}
};

static const
	TP_MaskHockey[3][3] = { // Хоккейные маски

	{454, 50000, 0},
	{455, 50000, 0},
	{456, 50000, 0}
};

static const
	TP_MaskOther[13][3] = { // Разные маски

	{444, 60000, 0},
	{450, 65000, 0},
	{451, 66000, 0},
	{452, 67000, 0},
	{445, 70000, 0},
	{446, 80000, 0},
	{448, 85000, 0},
	{443, 90000, 0},
	{449, 90000, 0},
	{447, 100000, 0},
	{458, 110000, 0},
	{457, 110000, 0},
	{453, 2000000, 0}
};

static const
	TP_WatchCostly[5][3] = { // Дорогие часы

	{461, 90000, 0},
	{460, 100000, 0},
	{463, 100000, 0},
	{459, 130000, 0},
	{462, 130000, 0}
};

static const
	TP_WatchOther[10][3] = { // Разные часы

	{466, 5000, 0},
	{464, 10000, 0},
	{465, 15000, 0},
	{467, 20000, 0},
	{470, 40000, 0},
	{471, 40000, 0},
	{468, 50000, 0},
	{473, 60000, 0},
	{469, 70000, 0},
	{472, 80000, 0}
};

static const
	TP_Case[3][3] = { // Кейсы

	{312, 60000, 0},
	{313, 100000, 0},
	{314, 150000, 0}
};

static const
	TP_BannerBadge[9][3] = { // Баннеры значков

	{3, 10000, 0},
	{4, 15000, 0},
	{5, 20000, 0},
	{6, 50000, 0},
	{7, 55000, 0},
	{8, 60000, 0},
	{9, 100000, 0},
	{10, 105000, 0},
	{11, 110000, 0}
};

static const
	TP_BannerOther[14][3] = { // Разные баннеры

	{25, 3000, 0},
	{12, 5000, 0},
	{13, 6000, 0},
	{14, 10000, 0},
	{15, 20000, 0},
	{16, 30000, 0},
	{17, 50000, 0},
	{19, 60000, 0},
	{20, 60000, 0},
	{21, 200000, 0},
	{18, 300000, 0},
	{23, 500000, 0},
	{22, 1000000, 0},
	{24, 1500000, 0}
};

static const
	TP_MaleSkin[102][3] = { // Мужские скины

	{78, 5000, 0},
	{79, 5000, 0},
	{200, 5000, 0},
	{134, 6000, 0},
	{137, 6000, 0},
	{162, 7000, 0},
	{8, 7000, 0},
	{6, 8000, 0},
	{20, 9000, 0},
	{7, 10000, 0},
	{16, 11000, 0},
	{14, 15000, 0},
	{15, 15000, 0},
	{21, 16000, 0},
	{22, 16000, 0},
	{23, 17000, 0},
	{27, 18000, 0},
	{42, 19000, 0},
	{72, 20000, 0},
	{303, 21000, 0},
	{304, 21000, 0},
	{305, 21000, 0},
	{4, 23000, 0},
	{5, 25000, 0},
	{19, 26000, 0},
	{35, 26000, 0},
	{36, 26000, 0},
	{37, 27000, 0},
	{17, 30000, 0},
	{18, 31000, 0},
	{24, 35000, 0},
	{25, 35000, 0},
	{28, 36000, 0},
	{45, 37000, 0},
	{29, 39000, 0},
	{30, 40000, 0},
	{34, 41000, 0},
	{48, 42000, 0},
	{60, 42000, 0},
	{47, 48000, 0},
	{46, 50000, 0},
	{66, 51000, 0},
	{67, 52000, 0},
	{73, 54000, 0},
	{125, 58000, 0},
	{167, 60000, 0},
	{102, 61000, 0},
	{104, 61000, 0},
	{105, 63000, 0},
	{106, 63000, 0},
	{107, 63000, 0},
	{108, 65000, 0},
	{109, 65000, 0},
	{110, 65000, 0},
	{114, 67000, 0},
	{115, 67000, 0},
	{116, 67000, 0},
	{173, 67000, 0},
	{174, 67000, 0},
	{175, 67000, 0},
	{26, 70000, 0},
	{154, 71000, 0},
	{59, 73000, 0},
	{61, 74000, 0},
	{133, 74000, 0},
	{43, 75000, 0},
	{44, 76000, 0},
	{32, 80000, 0},
	{33, 85000, 0},
	{70, 86000, 0},
	{68, 90000, 0},
	{96, 90000, 0},
	{97, 90000, 0},
	{98, 91000, 0},
	{80, 93000, 0},
	{81, 93000, 0},
	{82, 95000, 0},
	{83, 95000, 0},
	{84, 95000, 0},
	{111, 96000, 0},
	{112, 96000, 0},
	{86, 100000, 0},
	{187, 105000, 0},
	{123, 110000, 0},
	{149, 110000, 0},
	{119, 115000, 0},
	{132, 120000, 0},
	{94, 130000, 0},
	{95, 130000, 0},
	{127, 135000, 0},
	{113, 140000, 0},
	{204, 140000, 0},
	{165, 144000, 0},
	{163, 145000, 0},
	{142, 150000, 0},
	{100, 150000, 0},
	{220, 160000, 0},
	{221, 165000, 0},
	{241, 1000000, 0},
	{249, 2000000, 0},
	{285, 3000000, 0},
	{294, 5000000, 0}
};

static const
	TP_FemaleSkin[47][3] = { // Женские скины

	{10, 5000, 0},
	{38, 6000, 0},
	{39, 7000, 0},
	{54, 8000, 0},
	{9, 10000, 0},
	{77, 11000, 0},
	{87, 12000, 0},
	{88, 13000, 0},
	{63, 14000, 0},
	{11, 15000, 0},
	{69, 17000, 0},
	{12, 20000, 0},
	{93, 24000, 0},
	{31, 25000, 0},
	{193, 26000, 0},
	{205, 28000, 0},
	{75, 35000, 0},
	{40, 40000, 0},
	{64, 50000, 0},
	{76, 55000, 0},
	{130, 65000, 0},
	{172, 66000, 0},
	{131, 70000, 0},
	{190, 75000, 0},
	{191, 76000, 0},
	{192, 78000, 0},
	{194, 79000, 0},
	{150, 80000, 0},
	{151, 90000, 0},
	{13, 95000, 0},
	{201, 96000, 0},
	{224, 97000, 0},
	{263, 98000, 0},
	{65, 100000, 0},
	{233, 110000, 0},
	{152, 125000, 0},
	{238, 126000, 0},
	{91, 130000, 0},
	{129, 140000, 0},
	{306, 145000, 0},
	{169, 150000, 0},
	{214, 200000, 0},
	{215, 300000, 0},
	{216, 400000, 0},
	{298, 500000, 0},
	{195, 1000000, 0},
	{219, 2000000, 0}
};

/*

	* Functions *

*/

static ShowTDTradingPlatform(playerid) 
{
	// Основной задний фон
	TD_TradingPlatform[playerid][0] = CreatePlayerTextDraw(playerid, 154.0000, 103.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][0], 0.0000, 29.6331);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][0], 476.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, TD_TradingPlatform[playerid][0], true);
	PlayerTextDrawBoxColour(playerid, TD_TradingPlatform[playerid][0], 606348543);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][0], true);

	// Задний фон торг. пл.
	TD_TradingPlatform[playerid][1] = CreatePlayerTextDraw(playerid, 154.0000, 103.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][1], 0.0000, 1.2661);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][1], 476.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][1], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][1], 0);
	PlayerTextDrawUseBox(playerid, TD_TradingPlatform[playerid][1], true);
	PlayerTextDrawBoxColour(playerid, TD_TradingPlatform[playerid][1], 336860415);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][1], true);

	TD_TradingPlatform[playerid][2] = CreatePlayerTextDraw(playerid, 315.0000, 102.0000, "Торговая_площадка");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][2], 0.3025, 1.2640);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][2], 0.0000, 463.0000);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][2], -1431656193);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][2], true);

	// Задний чёрный фон головы
	TD_TradingPlatform[playerid][3] = CreatePlayerTextDraw(playerid, 199.0000, 140.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][3], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][3], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][3], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][3], 808464639);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][3], true);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][3], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][3], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][3], 19137);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][3], 50.0000, -130.0000, 70.0000, 1.0000);

	TD_TradingPlatform[playerid][4] = CreatePlayerTextDraw(playerid, 200.0000, 139.0000, "Голова");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][4], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][4], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][4], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][4], true);

	// Задний чёрный фон наушников
	TD_TradingPlatform[playerid][5] = CreatePlayerTextDraw(playerid, 279.0000, 140.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][5], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][5], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][5], 808464639);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][5], true);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][5], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][5], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][5], 19421);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][5], 100.0000, 30.0000, 0.0000, 1.0000);

	TD_TradingPlatform[playerid][6] = CreatePlayerTextDraw(playerid, 280.0000, 139.0000, "Наушники");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][6], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][6], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][6], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][6], true);

	// Задний чёрный фон очков
	TD_TradingPlatform[playerid][7] = CreatePlayerTextDraw(playerid, 359.0000, 140.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][7], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][7], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][7], 808464639);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][7], true);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][7], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][7], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][7], 19010);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][7], 0.0000, 0.0000, 60.0000, 1.0000);

	TD_TradingPlatform[playerid][8] = CreatePlayerTextDraw(playerid, 360.0000, 139.0000, "Очки");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][8], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][8], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][8], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][8], true);

	// Задний чёрный фон масков
	TD_TradingPlatform[playerid][9] = CreatePlayerTextDraw(playerid, 199.0000, 213.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][9], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][9], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][9], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][9], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][9], 808464639);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][9], true);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][9], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][9], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][9], 18918);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][9], 120.0000, 160.0000, 0.0000, 1.0000);

	TD_TradingPlatform[playerid][10] = CreatePlayerTextDraw(playerid, 200.0000, 212.0000, "Маски");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][10], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][10], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][10], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][10], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][10], true);

	// Задний чёрный фон часов
	TD_TradingPlatform[playerid][11] = CreatePlayerTextDraw(playerid, 279.0000, 213.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][11], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][11], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][11], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][11], 808464639);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][11], true);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][11], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][11], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][11], 19039);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][11], 20.0000, 0.0000, 10.0000, 1.0000);

	TD_TradingPlatform[playerid][12] = CreatePlayerTextDraw(playerid, 280.0000, 212.0000, "Часы"); 
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][12], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][12], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][12], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][12], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][12], true);

	// Задний чёрный фон скинов
	TD_TradingPlatform[playerid][13] = CreatePlayerTextDraw(playerid, 359.0000, 213.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][13], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][13], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][13], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][13], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][13], 808464639);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][13], true);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][13], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][13], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][13], 294);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][13], 10.0000, 0.0000, -20.0000, 1.0000);

	TD_TradingPlatform[playerid][14] = CreatePlayerTextDraw(playerid, 360.0000, 212.0000, "Скины");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][14], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][14], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][14], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][14], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][14], true);

	// Задний чёрный фон кейсов
	TD_TradingPlatform[playerid][15] = CreatePlayerTextDraw(playerid, 240.0000, 285.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][15], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][15], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][15], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][15], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][15], 808464639);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][15], true);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][15], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][15], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][15], 964);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][15], -30.0000, 0.0000, -30.0000, 1.2000);

	TD_TradingPlatform[playerid][16] = CreatePlayerTextDraw(playerid, 241.0000, 284.0000, "Кейсы");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][16], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][16], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][16], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][16], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][16], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][16], true);

	// Задний чёрный фон баннеров
	TD_TradingPlatform[playerid][17] = CreatePlayerTextDraw(playerid, 321.0000, 285.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][17], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][17], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][17], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][17], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][17], 808464639);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][17], true);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][17], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][17], 74.0000, 65.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][17], 964);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][17], -30.0000, 0.0000, -30.0000, 1000.0000);

	TD_TradingPlatform[playerid][18] = CreatePlayerTextDraw(playerid, 322.0000, 284.0000, "Баннеры");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][18], 0.2134, 1.0937);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][18], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][18], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][18], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][18], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][18], true);

	// Спрайт баннеров
	TD_TradingPlatform[playerid][19] = CreatePlayerTextDraw(playerid, 327.0000, 300.0000, "ld_shtr:ship");
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][19], 62.0000, 44.0000);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][19], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][19], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][19], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][19], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][19], TEXT_DRAW_FONT_SPRITE);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][19], false);

	// Задний белый фон назад
	TD_TradingPlatform[playerid][20] = CreatePlayerTextDraw(playerid, 154.0000, 351.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][20], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][20], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][20], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][20], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][20], -1717986817);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][20], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][20], 42.0000, 19.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][20], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][20], 0.0000, 0.0000, 0.0000, 1000.0000);

	// Задний чёрный фон назад
	TD_TradingPlatform[playerid][21] = CreatePlayerTextDraw(playerid, 155.0000, 352.0000, "_");
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][21], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][21], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][21], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][21], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][21], 589505535);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][21], true);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][21], false);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][21], 40.0000, 17.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TradingPlatform[playerid][21], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_TradingPlatform[playerid][21], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_TradingPlatform[playerid][22] = CreatePlayerTextDraw(playerid, 175.0000, 353.0000, "Назад");
	PlayerTextDrawLetterSize(playerid, TD_TradingPlatform[playerid][22], 0.2293, 1.3594);
	PlayerTextDrawTextSize(playerid, TD_TradingPlatform[playerid][22], 15.0000, 40.0000);
	PlayerTextDrawAlignment(playerid, TD_TradingPlatform[playerid][22], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_TradingPlatform[playerid][22], -953010945);
	PlayerTextDrawBackgroundColour(playerid, TD_TradingPlatform[playerid][22], 255);
	PlayerTextDrawFont(playerid, TD_TradingPlatform[playerid][22], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TradingPlatform[playerid][22], 0);
	PlayerTextDrawSetProportional(playerid, TD_TradingPlatform[playerid][22], true);
	PlayerTextDrawSetSelectable(playerid, TD_TradingPlatform[playerid][22], true);
	return 1;
}

static ShowTDSlotItemsTP(playerid, item_id, td, model_id, price, goldcoins) 
{
	// Координаты ячеек покупаемых предметов TD's
	static const 
		Float:pos_td[TRADING_PLAT_MAX_HOW_ITEMS][2] = {
		{231.0, 149.0},
		{313.0, 149.0},
		{395.0, 149.0},
		{231.0, 232.0},
		{313.0, 232.0},
		{395.0, 232.0}
	};

	TD_TPItem[playerid][td] = CreatePlayerTextDraw(playerid, pos_td[item_id][0], pos_td[item_id][1], "_"); // Кликабельный фон 1
	PlayerTextDrawFont(playerid, TD_TPItem[playerid][td], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_TPItem[playerid][td], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_TPItem[playerid][td], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TPItem[playerid][td], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_TPItem[playerid][td], 1111638783);
	PlayerTextDrawSetSelectable(playerid, TD_TPItem[playerid][td], true);
	PlayerTextDrawSetProportional(playerid, TD_TPItem[playerid][td], false);
	PlayerTextDrawTextSize(playerid, TD_TPItem[playerid][td], 78.0000, 78.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_TPItem[playerid][td], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_TPItem[playerid][td], 0.0, 0.0, 0.0, 1000.0000);

	TD_TPItem[playerid][td + 1] = CreatePlayerTextDraw(playerid, pos_td[item_id][0] + 77.0, pos_td[item_id][1] + 67.0, "_"); // Цена 1
	PlayerTextDrawLetterSize(playerid, TD_TPItem[playerid][td + 1], 0.1592, 1.0399);
	PlayerTextDrawAlignment(playerid, TD_TPItem[playerid][td + 1], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, TD_TPItem[playerid][td + 1], 142945535);
	PlayerTextDrawBackgroundColour(playerid, TD_TPItem[playerid][td + 1], 255);
	PlayerTextDrawFont(playerid, TD_TPItem[playerid][td + 1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_TPItem[playerid][td + 1], 0);
	PlayerTextDrawSetProportional(playerid, TD_TPItem[playerid][td + 1], true);

	switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
		case 7: { // Баннеры
			TD_TPItem[playerid][td + 2] = CreatePlayerTextDraw(playerid, pos_td[item_id][0] + 3.0, pos_td[item_id][1] + 3.0, Inv_GetBannerModel(model_id)); // Спрайт
			PlayerTextDrawTextSize(playerid, TD_TPItem[playerid][td + 2], 72.0000, 60.0000);
			PlayerTextDrawAlignment(playerid, TD_TPItem[playerid][td + 2], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPItem[playerid][td + 2], 0xFFFFFFFF);
			PlayerTextDrawBackgroundColour(playerid, TD_TPItem[playerid][td + 2], 255);
			PlayerTextDrawSetShadow(playerid, TD_TPItem[playerid][td + 2], 0);
			PlayerTextDrawFont(playerid, TD_TPItem[playerid][td + 2], TEXT_DRAW_FONT_SPRITE);
			PlayerTextDrawSetProportional(playerid, TD_TPItem[playerid][td + 2], false);
			PlayerTextDrawShow(playerid, TD_TPItem[playerid][td + 2]);
		}
		default: {
			PlayerTextDrawSetPreviewModel(playerid, TD_TPItem[playerid][td], Inv_GetModelItem(model_id));

			new
				Float:x, Float:y, Float:z;

			Inv_GetPosItem(model_id, x, y, z);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPItem[playerid][td], x, y, z, 1.0000);
		}
	}
	PlayerTextDrawShow(playerid, TD_TPItem[playerid][td]);

	static
		str[50];

	str[0] = EOS;

	if(price > 0)
		f(str, "%i$", price);

	if(goldcoins > 0 && price > 0)
		f(str, "%s ~w~или ~y~%i GL", str, goldcoins);
	else if(goldcoins > 0 && price < 1)
		f(str, "~y~%i GL", goldcoins);

	PlayerTextDrawSetString(playerid, TD_TPItem[playerid][td + 1], str);
	PlayerTextDrawShow(playerid, TD_TPItem[playerid][td + 1]);
	return 1;
}

static ShowBlockItemsTP(playerid, change_slot, bool:trans_text = false)
{
	if(!trans_text) {
		if(TP_PlayerInfo[playerid][TP_Block] == change_slot) 
			return 1;
	}

	new
		td_id;

	for(new i = 0, td = 0; i < TP_PlayerInfo[playerid][TP_Block]; i++, td += 2)
		td_id = td;

	PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][td_id], 757935615);
	PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][td_id]);

	TP_PlayerInfo[playerid][TP_Block] = change_slot;

	for(new i = 0, td = 0; i < TP_PlayerInfo[playerid][TP_Block]; i++, td += 2)
		td_id = td;

	PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][td_id], 0x0e5408FF);
	PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][td_id]);

	new
		size;

	GetSlotItemTP(playerid, size);
	ShowNextSlotItemsTP(playerid, size);
	return 1;
}

static ShowMaxPageTP(playerid, number, bool:text)
{
	new
		page_max,
		s;

	n_for(i, number) {
		s += 6;
		if(s < number)
			page_max++;
		else if(s >= number) {
			page_max++;
			break;
		}
	}
	if(text) {
		new
			str[10];

		f(str, "%i/%i", TP_PlayerInfo[playerid][TP_Page], page_max);
		PlayerTextDrawSetString(playerid, TD_BTradingPlatform[playerid][6], str);
	}
	else
		return page_max;
	
	return 1;
}

static DestroyPlayerTDItemsTP(playerid)
{
	if(GetPVarInt(playerid, "TP_TD_PVar") > 0) {
		switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
			case 7: { // Баннеры
				for(new i = 0, td = 0; i < GetPVarInt(playerid, "TP_TD_PVar"); i++, td += 3) {
					DestroyPlayerTD(playerid, TD_TPItem[playerid][td]);
					DestroyPlayerTD(playerid, TD_TPItem[playerid][td + 1]);
					DestroyPlayerTD(playerid, TD_TPItem[playerid][td + 2]);
				}
			}
			default: {
				for(new i = 0, td = 0; i < GetPVarInt(playerid, "TP_TD_PVar"); i++, td += 2) {
					DestroyPlayerTD(playerid, TD_TPItem[playerid][td]);
					DestroyPlayerTD(playerid, TD_TPItem[playerid][td + 1]);
				}
			}
		}
	}
	DeletePVar(playerid, "TP_TD_PVar");
	return 1;
}

static ShowNextSlotItemsTP(playerid, number)
{
	DestroyPlayerTDItemsTP(playerid);

	new
		items;

	if(TP_PlayerInfo[playerid][TP_Page] > 1)
		items = (TP_PlayerInfo[playerid][TP_Page] - 1) * 6;
	else
		items = TP_PlayerInfo[playerid][TP_Page];

	if((items + 6) <= number) {
		new
			size;

		if(TP_PlayerInfo[playerid][TP_Page] > 1)
			items++;

		switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
			case 7: { // Баннеры
				for(new i = 0, td = 0, t = 0; i < TRADING_PLAT_MAX_HOW_ITEMS; i++, t++, td += 3) {
					GetSlotItemTP(playerid, size, items - 1, TP_PlayerInfo[playerid][TP_ItemID][i], TP_PlayerInfo[playerid][TP_Credits][i], TP_PlayerInfo[playerid][TP_GoldCoins][i]);
					ShowTDSlotItemsTP(playerid, t, td, TP_PlayerInfo[playerid][TP_ItemID][i], TP_PlayerInfo[playerid][TP_Credits][i], TP_PlayerInfo[playerid][TP_GoldCoins][i]);
					SetPVarInt(playerid, "TP_TD_PVar", i + 1);
					items++;
				}
			}
			default: {
				for(new i = 0, td = 0, t = 0; i < TRADING_PLAT_MAX_HOW_ITEMS; i++, t++, td += 2) {
					GetSlotItemTP(playerid, size, items - 1, TP_PlayerInfo[playerid][TP_ItemID][i], TP_PlayerInfo[playerid][TP_Credits][i], TP_PlayerInfo[playerid][TP_GoldCoins][i]);
					ShowTDSlotItemsTP(playerid, t, td, TP_PlayerInfo[playerid][TP_ItemID][i], TP_PlayerInfo[playerid][TP_Credits][i], TP_PlayerInfo[playerid][TP_GoldCoins][i]);
					SetPVarInt(playerid, "TP_TD_PVar", i + 1);
					items++;
				}
			}
		}
	}
	else {
		new
			cycle,
			size;

		GetSlotItemTP(playerid, size);

		if(TP_PlayerInfo[playerid][TP_Page] == 1) 
			cycle = size;
		else {
			cycle = number - items;
			items++;
		}

		switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
			case 7: { // Баннеры
				for(new i = 0, td = 0, t = 0; i < cycle; i++, t++, td += 3) {
					GetSlotItemTP(playerid, size, items - 1, TP_PlayerInfo[playerid][TP_ItemID][i], TP_PlayerInfo[playerid][TP_Credits][i], TP_PlayerInfo[playerid][TP_GoldCoins][i]);
					ShowTDSlotItemsTP(playerid, t, td, TP_PlayerInfo[playerid][TP_ItemID][i], TP_PlayerInfo[playerid][TP_Credits][i], TP_PlayerInfo[playerid][TP_GoldCoins][i]);
					SetPVarInt(playerid, "TP_TD_PVar", i + 1);
					items++;
				}
			}
			default: {
				for(new i = 0, td = 0, t = 0; i < cycle; i++, t++, td += 2) {
					GetSlotItemTP(playerid, size, items - 1, TP_PlayerInfo[playerid][TP_ItemID][i], TP_PlayerInfo[playerid][TP_Credits][i], TP_PlayerInfo[playerid][TP_GoldCoins][i]);
					ShowTDSlotItemsTP(playerid, t, td, TP_PlayerInfo[playerid][TP_ItemID][i], TP_PlayerInfo[playerid][TP_Credits][i], TP_PlayerInfo[playerid][TP_GoldCoins][i]);
					SetPVarInt(playerid, "TP_TD_PVar", i + 1);
					items++;
				}	
			}
		}
	}

	ShowMaxPageTP(playerid, number, true);
	return 1;
}

static GetSlotItemTP(playerid, &size = 0, item_id = 0, &model_item = 0, &price = 0, &goldcoins = 0)
{
	switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
		case 0: { // Голова
			switch(TP_PlayerInfo[playerid][TP_Block]) {
				case 1: { // Банданы
					model_item = TP_HeadBandana[item_id][0];
					price = TP_HeadBandana[item_id][1];
					goldcoins = TP_HeadBandana[item_id][2];
					size = sizeof(TP_HeadBandana);
				}
				case 2: { // Шапки
					model_item = TP_HeadHat[item_id][0];
					price = TP_HeadHat[item_id][1];
					goldcoins = TP_HeadHat[item_id][2];
					size = sizeof(TP_HeadHat);
				}
				case 3: { // Кепки
					model_item = TP_HeadCap[item_id][0];
					price = TP_HeadCap[item_id][1];
					goldcoins = TP_HeadCap[item_id][2];
					size = sizeof(TP_HeadCap);
				}
				case 4: { // Шляпы
					model_item = TP_HeadHat2[item_id][0];
					price = TP_HeadHat2[item_id][1];
					goldcoins = TP_HeadHat2[item_id][2];
					size = sizeof(TP_HeadHat2);
				}
				case 5: { // Каски
					model_item = TP_HeadHelmet[item_id][0];
					price = TP_HeadHelmet[item_id][1];
					goldcoins = TP_HeadHelmet[item_id][2];
					size = sizeof(TP_HeadHelmet);
				}
			}
		}
		case 1: { // Наушники
			switch(TP_PlayerInfo[playerid][TP_Block]) {
				case 1: { // Наушники
					model_item = TP_HeadPhones[item_id][0];
					price = TP_HeadPhones[item_id][1];
					goldcoins = TP_HeadPhones[item_id][2];
					size = sizeof(TP_HeadPhones);
				}
			}
		}
		case 2: { // Очки
			switch(TP_PlayerInfo[playerid][TP_Block]) {
				case 1: { // Модные
					model_item = TP_GlassesStylish[item_id][0];
					price = TP_GlassesStylish[item_id][1];
					goldcoins = TP_GlassesStylish[item_id][2];
					size = sizeof(TP_GlassesStylish);
				}
				case 2: { // С блеском
					model_item = TP_GlassesShine[item_id][0];
					price = TP_GlassesShine[item_id][1];
					goldcoins = TP_GlassesShine[item_id][2];
					size = sizeof(TP_GlassesShine);
				}
				case 3: { // Авиаторские
					model_item = TP_GlassesAviator[item_id][0];
					price = TP_GlassesAviator[item_id][1];
					goldcoins = TP_GlassesAviator[item_id][2];
					size = sizeof(TP_GlassesAviator);
				}
			}
		}
		case 3: { // Маски
			switch(TP_PlayerInfo[playerid][TP_Block]) {
				case 1: { // Хоккейные
					model_item = TP_MaskHockey[item_id][0];
					price = TP_MaskHockey[item_id][1];
					goldcoins = TP_MaskHockey[item_id][2];
					size = sizeof(TP_MaskHockey);
				}
				case 2: { // Разные
					model_item = TP_MaskOther[item_id][0];
					price = TP_MaskOther[item_id][1];
					goldcoins = TP_MaskOther[item_id][2];
					size = sizeof(TP_MaskOther);
				}
			}
		}
		case 4: { // Часы
			switch(TP_PlayerInfo[playerid][TP_Block]) {
				case 1: { // Дорогие
					model_item = TP_WatchCostly[item_id][0];
					price = TP_WatchCostly[item_id][1];
					goldcoins = TP_WatchCostly[item_id][2];
					size = sizeof(TP_WatchCostly);
				}
				case 2: { // Разные
					model_item = TP_WatchOther[item_id][0];
					price = TP_WatchOther[item_id][1];
					goldcoins = TP_WatchOther[item_id][2];
					size = sizeof(TP_WatchOther);
				}
			}
		}
		case 5: { // Скины
			switch(TP_PlayerInfo[playerid][TP_Block]) {
				case 1: { // Мужские
					model_item = TP_MaleSkin[item_id][0];
					price = TP_MaleSkin[item_id][1];
					goldcoins = TP_MaleSkin[item_id][2];
					size = sizeof(TP_MaleSkin);
				}
				case 2: { // Женские
					model_item = TP_FemaleSkin[item_id][0];
					price = TP_FemaleSkin[item_id][1];
					goldcoins = TP_FemaleSkin[item_id][2];
					size = sizeof(TP_FemaleSkin);
				}
			}	
		}
		case 6: { // Кейсы
			switch(TP_PlayerInfo[playerid][TP_Block]) {
				case 1: { // Кейсы
					model_item = TP_Case[item_id][0];
					price = TP_Case[item_id][1];
					goldcoins = TP_Case[item_id][2];
					size = sizeof(TP_Case);
				}
			}
		}
		case 7: { // Баннеры
			switch(TP_PlayerInfo[playerid][TP_Block]) {
				case 1: { // Значки
					model_item = TP_BannerBadge[item_id][0];
					price = TP_BannerBadge[item_id][1];
					goldcoins = TP_BannerBadge[item_id][2];
					size = sizeof(TP_BannerBadge);
				}
				case 2: { // Разное
					model_item = TP_BannerOther[item_id][0];
					price = TP_BannerOther[item_id][1];
					goldcoins = TP_BannerOther[item_id][2];
					size = sizeof(TP_BannerOther);
				}
			}
		}
	}
	return 1;
}

static ShowBuyTDTradingPlatform(playerid, items_id, page = 1, block = 1, bool:perevod_text = false)
{
	ShowTDBuyTradingPlatform(playerid);
	TP_PlayerInfo[playerid][TP_BuyItems] = items_id;
	TP_PlayerInfo[playerid][TP_Page] = page;

	switch(items_id) {
		case 0: { // Голова
			PlayerTextDrawSetString(playerid, TD_BTradingPlatform[playerid][4], "Меню_-_Голова");
			TD_TPBlocks[playerid][0] = CreatePlayerTextDraw(playerid, 155.0000, 149.0000, "_"); // Кликабельный фон 1
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][0], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][0], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][0], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][0], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][0], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][1] = CreatePlayerTextDraw(playerid, 156.0000, 149.0000, "Банданы");
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][1], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][1], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][1], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][1], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][1], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][1], true);

			TD_TPBlocks[playerid][2] = CreatePlayerTextDraw(playerid, 155.0000, 165.0000, "_"); // Кликабельный фон 2
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][2], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][2], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][2], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][2], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][2], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][3] = CreatePlayerTextDraw(playerid, 156.0000, 165.0000, "Шапки"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][3], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][3], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][3], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][3], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][3], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][3], true);

			TD_TPBlocks[playerid][4] = CreatePlayerTextDraw(playerid, 155.0000, 181.0000, "_"); // Кликабельный фон 3
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][4], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][4], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][4], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][4], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][4], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][4], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][4], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][4], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][4], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][4], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][5] = CreatePlayerTextDraw(playerid, 156.0000, 181.0000, "Кепки"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][5], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][5], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][5], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][5], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][5], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][5], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][5], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][5], true);

			TD_TPBlocks[playerid][6] = CreatePlayerTextDraw(playerid, 155.0000, 197.0000, "_"); // Кликабельный фон 4
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][6], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][6], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][6], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][6], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][6], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][6], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][6], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][6], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][6], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][6], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][7] = CreatePlayerTextDraw(playerid, 156.0000, 197.0000, "Шляпы"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][7], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][7], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][7], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][7], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][7], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][7], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][7], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][7], true);
		
			TD_TPBlocks[playerid][8] = CreatePlayerTextDraw(playerid, 155.0000, 213.0000, "_"); // Кликабельный фон 5
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][8], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][8], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][8], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][8], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][8], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][8], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][8], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][8], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][8], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][8], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][9] = CreatePlayerTextDraw(playerid, 156.0000, 213.0000, "Каски"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][9], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][9], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][9], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][9], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][9], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][9], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][9], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][9], true);

			SetPVarInt(playerid, "TP_TDBlocks_PVar", 10);

			n_for(i, 10)
				PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][i]);
		}
		case 1: { // Наушники
			PlayerTextDrawSetString(playerid, TD_BTradingPlatform[playerid][4], "Меню_-_Наушники");
			TD_TPBlocks[playerid][0] = CreatePlayerTextDraw(playerid, 155.0000, 149.0000, "_"); // Кликабельный фон 1
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][0], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][0], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][0], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][0], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][0], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][1] = CreatePlayerTextDraw(playerid, 156.0000, 149.0000, "Наушники");
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][1], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][1], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][1], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][1], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][1], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][1], true);

			SetPVarInt(playerid, "TP_TDBlocks_PVar", 2);

			n_for(i, 2)
				PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][i]);
		}
		case 2: { // Очки
			PlayerTextDrawSetString(playerid, TD_BTradingPlatform[playerid][4], "Меню_-_Очки");
			TD_TPBlocks[playerid][0] = CreatePlayerTextDraw(playerid, 155.0000, 149.0000, "_"); // Кликабельный фон 1
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][0], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][0], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][0], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][0], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][0], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][1] = CreatePlayerTextDraw(playerid, 156.0000, 149.0000, "Модные");
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][1], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][1], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][1], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][1], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][1], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][1], true);

			TD_TPBlocks[playerid][2] = CreatePlayerTextDraw(playerid, 155.0000, 165.0000, "_"); // Кликабельный фон 2
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][2], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][2], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][2], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][2], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][2], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][3] = CreatePlayerTextDraw(playerid, 156.0000, 165.0000, "С_блеском"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][3], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][3], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][3], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][3], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][3], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][3], true);

			TD_TPBlocks[playerid][4] = CreatePlayerTextDraw(playerid, 155.0000, 181.0000, "_"); // Кликабельный фон 3
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][4], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][4], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][4], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][4], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][4], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][4], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][4], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][4], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][4], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][4], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][5] = CreatePlayerTextDraw(playerid, 156.0000, 181.0000, "Авиаторские"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][5], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][5], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][5], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][5], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][5], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][5], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][5], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][5], true);

			SetPVarInt(playerid, "TP_TDBlocks_PVar", 6);

			n_for(i, 6)
				PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][i]);
		}
		case 3: { // Маска
			PlayerTextDrawSetString(playerid, TD_BTradingPlatform[playerid][4], "Меню_-_Маски");
			TD_TPBlocks[playerid][0] = CreatePlayerTextDraw(playerid, 155.0000, 149.0000, "_"); // Кликабельный фон 1
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][0], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][0], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][0], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][0], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][0], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][1] = CreatePlayerTextDraw(playerid, 156.0000, 149.0000, "Хоккейные");
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][1], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][1], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][1], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][1], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][1], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][1], true);

			TD_TPBlocks[playerid][2] = CreatePlayerTextDraw(playerid, 155.0000, 165.0000, "_"); // Кликабельный фон 2
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][2], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][2], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][2], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][2], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][2], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][3] = CreatePlayerTextDraw(playerid, 156.0000, 165.0000, "Разные"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][3], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][3], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][3], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][3], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][3], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][3], true);

			SetPVarInt(playerid, "TP_TDBlocks_PVar", 4);

			n_for(i, 4)
				PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][i]);
		}
		case 4: { // Часы
			PlayerTextDrawSetString(playerid, TD_BTradingPlatform[playerid][4], "Меню_-_Часы");
			TD_TPBlocks[playerid][0] = CreatePlayerTextDraw(playerid, 155.0000, 149.0000, "_"); // Кликабельный фон 1
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][0], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][0], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][0], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][0], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][0], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][1] = CreatePlayerTextDraw(playerid, 156.0000, 149.0000, "Дорогие");
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][1], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][1], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][1], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][1], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][1], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][1], true);

			TD_TPBlocks[playerid][2] = CreatePlayerTextDraw(playerid, 155.0000, 165.0000, "_"); // Кликабельный фон 2
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][2], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][2], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][2], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][2], true);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][2], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][3] = CreatePlayerTextDraw(playerid, 156.0000, 165.0000, "Разные"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][3], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][3], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][3], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][3], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][3], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][3], true);

			SetPVarInt(playerid, "TP_TDBlocks_PVar", 4);

			n_for(i, 4)
				PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][i]);
		}
		case 5: { // Скины
			PlayerTextDrawSetString(playerid, TD_BTradingPlatform[playerid][4], "Меню_-_Скины");
			TD_TPBlocks[playerid][0] = CreatePlayerTextDraw(playerid, 155.0000, 149.0000, "_"); // Кликабельный фон 1
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][0], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][0], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][0], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][0], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][0], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][1] = CreatePlayerTextDraw(playerid, 156.0000, 149.0000, "Мужские");
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][1], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][1], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][1], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][1], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][1], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][1], true);

			TD_TPBlocks[playerid][2] = CreatePlayerTextDraw(playerid, 155.0000, 165.0000, "_"); // Кликабельный фон 2
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][2], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][2], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][2], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][2], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][2], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][3] = CreatePlayerTextDraw(playerid, 156.0000, 165.0000, "Женские"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][3], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][3], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][3], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][3], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][3], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][3], true);

			SetPVarInt(playerid, "TP_TDBlocks_PVar", 4);

			n_for(i, 4)
				PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][i]);
		}
		case 6: { // Кейсы
			PlayerTextDrawSetString(playerid, TD_BTradingPlatform[playerid][4], "Меню_-_Кейсы");
			TD_TPBlocks[playerid][0] = CreatePlayerTextDraw(playerid, 155.0000, 149.0000, "_"); // Кликабельный фон 1
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][0], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][0], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][0], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][0], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][0], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][1] = CreatePlayerTextDraw(playerid, 156.0000, 149.0000, "Кейсы");
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][1], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][1], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][1], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][1], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][1], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][1], true);

			SetPVarInt(playerid, "TP_TDBlocks_PVar", 2);

			n_for(i, 2)
				PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][i]);
		}
		case 7: { // Баннеры
			PlayerTextDrawSetString(playerid, TD_BTradingPlatform[playerid][4], "Меню_-_Баннеры");
			TD_TPBlocks[playerid][0] = CreatePlayerTextDraw(playerid, 155.0000, 149.0000, "_"); // Кликабельный фон 1
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][0], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][0], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][0], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][0], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][0], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][0], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][0], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][1] = CreatePlayerTextDraw(playerid, 156.0000, 149.0000, "Значки");
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][1], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][1], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][1], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][1], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][1], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][1], true);

			TD_TPBlocks[playerid][2] = CreatePlayerTextDraw(playerid, 155.0000, 165.0000, "_"); // Кликабельный фон 2
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_FONT_PREVIEW);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][2], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][2], 0xFFFFFFFF);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][2], 757935615);
			PlayerTextDrawSetSelectable(playerid, TD_TPBlocks[playerid][2], true);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][2], false);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][2], 71.0000, 15.0000);
			PlayerTextDrawSetPreviewModel(playerid, TD_TPBlocks[playerid][2], 0);
			PlayerTextDrawSetPreviewRot(playerid, TD_TPBlocks[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

			TD_TPBlocks[playerid][3] = CreatePlayerTextDraw(playerid, 156.0000, 165.0000, "Разное"); 
			PlayerTextDrawLetterSize(playerid, TD_TPBlocks[playerid][3], 0.2033, 1.4133);
			PlayerTextDrawTextSize(playerid, TD_TPBlocks[playerid][3], -16.0000, 0.0000);
			PlayerTextDrawAlignment(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_ALIGN_LEFT);
			PlayerTextDrawColour(playerid, TD_TPBlocks[playerid][3], -1212697089);
			PlayerTextDrawBackgroundColour(playerid, TD_TPBlocks[playerid][3], 255);
			PlayerTextDrawFont(playerid, TD_TPBlocks[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
			PlayerTextDrawSetShadow(playerid, TD_TPBlocks[playerid][3], 0);
			PlayerTextDrawSetProportional(playerid, TD_TPBlocks[playerid][3], true);

			SetPVarInt(playerid, "TP_TDBlocks_PVar", 4);

			n_for(i, 4)
				PlayerTextDrawShow(playerid, TD_TPBlocks[playerid][i]);
		}
	}

	ShowBlockItemsTP(playerid, block, perevod_text);

	n_for(i, sizeof(TD_BTradingPlatform[]))
		PlayerTextDrawShow(playerid, TD_BTradingPlatform[playerid][i]);
	
	return 1;
}

static ShowBuyTradingPlatform(playerid, items_id)
{
	n_for(i, sizeof(TD_TradingPlatform[]))
		DestroyPlayerTD(playerid, TD_TradingPlatform[playerid][i]);

	TP_PlayerInfo[playerid][TP_ActiveSelect] = true;
	ShowBuyTDTradingPlatform(playerid, items_id);
	return 1;
}

static ShowTDBuyTradingPlatform(playerid)
{
	// Основной задний фон
	TD_BTradingPlatform[playerid][0] = CreatePlayerTextDraw(playerid, 155.0000, 120.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_BTradingPlatform[playerid][0], 0.0000, 25.2999);
	PlayerTextDrawTextSize(playerid, TD_BTradingPlatform[playerid][0], 475.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_BTradingPlatform[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_BTradingPlatform[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_BTradingPlatform[playerid][0], 0);
	PlayerTextDrawUseBox(playerid, TD_BTradingPlatform[playerid][0], true);
	PlayerTextDrawBoxColour(playerid, TD_BTradingPlatform[playerid][0], 606348543);
	PlayerTextDrawBackgroundColour(playerid, TD_BTradingPlatform[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_BTradingPlatform[playerid][0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_BTradingPlatform[playerid][0], true);

	// Задний фон торг. пл.
	TD_BTradingPlatform[playerid][1] = CreatePlayerTextDraw(playerid, 155.0000, 120.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_BTradingPlatform[playerid][1], 0.0000, 1.2665);
	PlayerTextDrawTextSize(playerid, TD_BTradingPlatform[playerid][1], 475.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_BTradingPlatform[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_BTradingPlatform[playerid][1], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_BTradingPlatform[playerid][1], 0);
	PlayerTextDrawUseBox(playerid, TD_BTradingPlatform[playerid][1], true);
	PlayerTextDrawBoxColour(playerid, TD_BTradingPlatform[playerid][1], 336860415);
	PlayerTextDrawBackgroundColour(playerid, TD_BTradingPlatform[playerid][1], 255);
	PlayerTextDrawFont(playerid, TD_BTradingPlatform[playerid][1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_BTradingPlatform[playerid][1], true);

	TD_BTradingPlatform[playerid][2] = CreatePlayerTextDraw(playerid, 316.0000, 119.0000, "Торговая площадка");
	PlayerTextDrawLetterSize(playerid, TD_BTradingPlatform[playerid][2], 0.3026, 1.2640);
	PlayerTextDrawTextSize(playerid, TD_BTradingPlatform[playerid][2], 0.0000, 463.0000);
	PlayerTextDrawAlignment(playerid, TD_BTradingPlatform[playerid][2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_BTradingPlatform[playerid][2], -1431656193);
	PlayerTextDrawBackgroundColour(playerid, TD_BTradingPlatform[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_BTradingPlatform[playerid][2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_BTradingPlatform[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, TD_BTradingPlatform[playerid][2], true);

	// Задний фон блоков
	TD_BTradingPlatform[playerid][3] = CreatePlayerTextDraw(playerid, 155.0000, 150.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_BTradingPlatform[playerid][3], 0.0000, 21.9665);
	PlayerTextDrawTextSize(playerid, TD_BTradingPlatform[playerid][3], 226.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_BTradingPlatform[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_BTradingPlatform[playerid][3], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_BTradingPlatform[playerid][3], 0);
	PlayerTextDrawUseBox(playerid, TD_BTradingPlatform[playerid][3], true);
	PlayerTextDrawBoxColour(playerid, TD_BTradingPlatform[playerid][3], 336860415);
	PlayerTextDrawBackgroundColour(playerid, TD_BTradingPlatform[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_BTradingPlatform[playerid][3], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_BTradingPlatform[playerid][3], true);

	// Меню - куда
	TD_BTradingPlatform[playerid][4] = CreatePlayerTextDraw(playerid, 154.0000, 135.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_BTradingPlatform[playerid][4], 0.1753, 1.2142);
	PlayerTextDrawTextSize(playerid, TD_BTradingPlatform[playerid][4], 225.0000, 10.0000);
	PlayerTextDrawAlignment(playerid, TD_BTradingPlatform[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_BTradingPlatform[playerid][4], 0xc73234FF);
	PlayerTextDrawUseBox(playerid, TD_BTradingPlatform[playerid][4], true);
	PlayerTextDrawBoxColour(playerid, TD_BTradingPlatform[playerid][4], 0);
	PlayerTextDrawFont(playerid, TD_BTradingPlatform[playerid][4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetShadow(playerid, TD_BTradingPlatform[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, TD_BTradingPlatform[playerid][4], true);
	PlayerTextDrawSetSelectable(playerid, TD_BTradingPlatform[playerid][4], true);

	// Далее
	TD_BTradingPlatform[playerid][5] = CreatePlayerTextDraw(playerid, 460.0000, 333.0000, ">");
	PlayerTextDrawLetterSize(playerid, TD_BTradingPlatform[playerid][5], 0.4000, 1.6000);
	PlayerTextDrawTextSize(playerid, TD_BTradingPlatform[playerid][5], 474.3332, 10.0000);
	PlayerTextDrawAlignment(playerid, TD_BTradingPlatform[playerid][5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_BTradingPlatform[playerid][5], -1212697089);
	PlayerTextDrawUseBox(playerid, TD_BTradingPlatform[playerid][5], true);
	PlayerTextDrawBoxColour(playerid, TD_BTradingPlatform[playerid][5], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_BTradingPlatform[playerid][5], 255);
	PlayerTextDrawFont(playerid, TD_BTradingPlatform[playerid][5], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, TD_BTradingPlatform[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, TD_BTradingPlatform[playerid][5], true);
	PlayerTextDrawSetSelectable(playerid, TD_BTradingPlatform[playerid][5], true);

	// Кол-во страниц
	TD_BTradingPlatform[playerid][6] = CreatePlayerTextDraw(playerid, 440.0000, 334.0000, "_");
	PlayerTextDrawLetterSize(playerid, TD_BTradingPlatform[playerid][6], 0.2966, 1.3759);
	PlayerTextDrawAlignment(playerid, TD_BTradingPlatform[playerid][6], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_BTradingPlatform[playerid][6], -1212697089);
	PlayerTextDrawBackgroundColour(playerid, TD_BTradingPlatform[playerid][6], 255);
	PlayerTextDrawFont(playerid, TD_BTradingPlatform[playerid][6], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, TD_BTradingPlatform[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, TD_BTradingPlatform[playerid][6], true);

	// Назад
	TD_BTradingPlatform[playerid][7] = CreatePlayerTextDraw(playerid, 409.0000, 333.0000, "<");
	PlayerTextDrawLetterSize(playerid, TD_BTradingPlatform[playerid][7], 0.4000, 1.6000);
	PlayerTextDrawTextSize(playerid, TD_BTradingPlatform[playerid][7], 422.0000, 10.0000);
	PlayerTextDrawAlignment(playerid, TD_BTradingPlatform[playerid][7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_BTradingPlatform[playerid][7], -1212697089);
	PlayerTextDrawUseBox(playerid, TD_BTradingPlatform[playerid][7], true);
	PlayerTextDrawBoxColour(playerid, TD_BTradingPlatform[playerid][7], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_BTradingPlatform[playerid][7], 255);
	PlayerTextDrawFont(playerid, TD_BTradingPlatform[playerid][7], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetShadow(playerid, TD_BTradingPlatform[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, TD_BTradingPlatform[playerid][7], true);
	PlayerTextDrawSetSelectable(playerid, TD_BTradingPlatform[playerid][7], true);
	return 1;	
}

/*

	* Reset *

*/

static ResetPlayerTDData(playerid)
{
	TP_PlayerInfo[playerid][TP_BuyItems] = -1;
	TP_PlayerInfo[playerid][TP_Block] = 0;
	TP_PlayerInfo[playerid][TP_Page] = 0;
	TP_PlayerInfo[playerid][TP_ActiveSelect] = false;

	n_for(i, TRADING_PLAT_MAX_HOW_ITEMS) {
		TP_PlayerInfo[playerid][TP_ItemID][i] =
		TP_PlayerInfo[playerid][TP_Credits][i] =
		TP_PlayerInfo[playerid][TP_GoldCoins][i] = 0;
	}
	return 1;
}


static ResetPlayerData(playerid)
{
	StatusTradingPlatform[playerid] = 0;

	ResetPlayerTDData(playerid);
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(i, sizeof(TD_BTradingPlatform[]))
		TD_BTradingPlatform[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_TPBlocks[]))
		TD_TPBlocks[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_TPItem[]))
		TD_TPItem[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	n_for(i, sizeof(TD_TradingPlatform[]))
		TD_TradingPlatform[playerid][i] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

/*

	* Interfaces *

*/

InterfaceCreate:TradingPlatform(playerid)
{
	StatusTradingPlatform[playerid] = 1;

	switch(StatusTradingPlatform[playerid]) {
		// Выбор раздела
		case 1: {
			ShowTDTradingPlatform(playerid);

			n_for(i, sizeof(TD_TradingPlatform[]))
				PlayerTextDrawShow(playerid, TD_TradingPlatform[playerid][i]);
		}
		// Выбор предмета
		case 2: {
			ShowBuyTradingPlatform(playerid, 0);
		}
	}
	return 1;
}

InterfaceClose:TradingPlatform(playerid)
{
	switch(StatusTradingPlatform[playerid]) {
		// Выбор раздела
		case 1: {
			n_for(i, sizeof(TD_TradingPlatform[]))
				DestroyPlayerTD(playerid, TD_TradingPlatform[playerid][i]);
		}
		// Выбор предмета
		case 2: {
			n_for(i, sizeof(TD_BTradingPlatform[]))
				DestroyPlayerTD(playerid, TD_BTradingPlatform[playerid][i]);

			n_for(i, GetPVarInt(playerid, "TP_TDBlocks_PVar"))
				DestroyPlayerTD(playerid, TD_TPBlocks[playerid][i]);

			DestroyPlayerTDItemsTP(playerid);
		}
	}

	StatusTradingPlatform[playerid] = 0;

	DeletePVar(playerid, "TP_TDBlocks_PVar");
	DeletePVar(playerid, "TP_ItemBuy_PVar");
	DeletePVar(playerid, "TP_ItemPrice_PVar");
	DeletePVar(playerid, "TP_ItemGL_PVar");

	ResetPlayerTDData(playerid);
	ClosePlayerDialog(playerid);
	return 1;
}

InterfacePlayerClick:TradingPlatform(playerid, PlayerText:playertextid)
{
	switch(StatusTradingPlatform[playerid]) {
		// Выбор раздела
		case 1: {
			if(playertextid == TD_TradingPlatform[playerid][22]) {
				Interface_Close(playerid, Interface:TradingPlatform);
				Interface_Show(playerid, Interface:MainMenu);
				return 1;
			}
			for(new td = 3, num = 0; num < 8; td += 2, num++) {
				if(playertextid == TD_TradingPlatform[playerid][td]) {
					StatusTradingPlatform[playerid] = 2;
					ShowBuyTradingPlatform(playerid, num);
					break;
				}
			}
			return 1;
		}
		// Выбор предмета
		case 2: {
			if(TP_PlayerInfo[playerid][TP_ActiveSelect]) {
				switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
					// Баннеры
					case 7: {
						for(new td = 0, num = 0; num < 6; td += 3, num++) {
							if(playertextid == TD_TPItem[playerid][td]) {
								SetPVarInt(playerid, "TP_ItemNum_PVar", num);
								Dialog_Show(playerid, Dialog:TP_BuyItemInfo);
								return 1;
							}
						}
					}
					default: {
						for(new td = 0, num = 0; num < 6; td += 2, num++) {
							if(playertextid == TD_TPItem[playerid][td]) {
								SetPVarInt(playerid, "TP_ItemNum_PVar", num);
								Dialog_Show(playerid, Dialog:TP_BuyItemInfo);
								return 1;
							}
						}
					}
				}
			}

			if(playertextid == TD_BTradingPlatform[playerid][4]) {
				Interface_Close(playerid, Interface:TradingPlatform);
				Interface_Show(playerid, Interface:TradingPlatform);
				return 1;
			}
			else if(playertextid == TD_BTradingPlatform[playerid][5]) {
				new 
					size;

				GetSlotItemTP(playerid, size);

				if(TP_PlayerInfo[playerid][TP_Page] == ShowMaxPageTP(playerid, size, false))
					return 1;

				TP_PlayerInfo[playerid][TP_Page]++;
				ShowNextSlotItemsTP(playerid, size);
				return 1;
			}
			else if(playertextid == TD_BTradingPlatform[playerid][7]) {
				if(TP_PlayerInfo[playerid][TP_Page] == 1) 
					return 1;

				TP_PlayerInfo[playerid][TP_Page]--;

				new 
					size;
					
				GetSlotItemTP(playerid, size);
				ShowNextSlotItemsTP(playerid, size);
				return 1;
			}

			if(playertextid == TD_TPBlocks[playerid][0]) {
				TP_PlayerInfo[playerid][TP_Page] = 1;
				ShowBlockItemsTP(playerid, 1);
				return 1;
			}
			else if(playertextid == TD_TPBlocks[playerid][2]) {
				TP_PlayerInfo[playerid][TP_Page] = 1;
				ShowBlockItemsTP(playerid, 2);
				return 1;
			}
			else if(playertextid == TD_TPBlocks[playerid][4]) {
				TP_PlayerInfo[playerid][TP_Page] = 1;
				ShowBlockItemsTP(playerid, 3);
				return 1;
			}
			else if(playertextid == TD_TPBlocks[playerid][6]) {
				TP_PlayerInfo[playerid][TP_Page] = 1;
				ShowBlockItemsTP(playerid, 4);
				return 1;
			}
			else if(playertextid == TD_TPBlocks[playerid][8]) {
				TP_PlayerInfo[playerid][TP_Page] = 1;
				ShowBlockItemsTP(playerid, 5);
				return 1;
			}
			return 1;
		}
	}
	return 1;
}

InterfaceClick:TradingPlatform(playerid, Text:clickedid)
{
	if(clickedid == INVALID_TEXT_DRAW) {
		switch(StatusTradingPlatform[playerid]) {
			// Выбор раздела
			case 1: {
				Interface_Close(playerid, Interface:TradingPlatform);
				Interface_Show(playerid, Interface:MainMenu);
			}
			// Выбор предмета
			case 2: {
				Interface_Close(playerid, Interface:TradingPlatform);
				Interface_Show(playerid, Interface:TradingPlatform);
			}
		}
		SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);
	}
	return 1;
}

/*

	* Dialogs *

*/

DialogCreate:TP_BuyItemInfo(playerid)
{
	new
		item_id = GetPVarInt(playerid, "TP_ItemNum_PVar");

	DeletePVar(playerid, "TP_ItemNum_PVar");

	if(TP_PlayerInfo[playerid][TP_BuyItems] != 7) { // Баннеры
		if(!Inv_IsItemForPlayer(playerid, TP_PlayerInfo[playerid][TP_ItemID][item_id])) 
			return 1;
	}

	SetPVarInt(playerid, "TP_ItemBuy_PVar", TP_PlayerInfo[playerid][TP_ItemID][item_id]);
	SetPVarInt(playerid, "TP_ItemPrice_PVar", TP_PlayerInfo[playerid][TP_Credits][item_id]);
	SetPVarInt(playerid, "TP_ItemGL_PVar", TP_PlayerInfo[playerid][TP_GoldCoins][item_id]);

	static
		str[300],
		price[50],
		in_stock[50];

	str[0] = price[0] = in_stock[0] = EOS;

	new
		credits = TP_PlayerInfo[playerid][TP_Credits][item_id],
		goldcoins = TP_PlayerInfo[playerid][TP_GoldCoins][item_id];

	if(credits > 0) {
		f(price, "{18a826}%i$", credits);
		f(in_stock, "{18a826}%i$", pInfo[playerid][pCredit]);
	}
	if(goldcoins > 0 && credits > 0) {
		f(price, "%s {FFFFFF}или {ccc321}%i GL", price, goldcoins);
		f(in_stock, "%s {FFFFFF}и {ccc321}%i GL", in_stock, pInfo[playerid][pGoldCoin]);
	}
	else if(goldcoins > 0 && credits < 1) {
		f(price, "{ccc321}%i GL", goldcoins); 
		f(in_stock, "{ccc321}%i GL", pInfo[playerid][pGoldCoin]);
	}

	switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
		case 7: { // Баннеры
			f(str, "{FFFFFF}Баннер: {cc8418}%s\n{FFFFFF}Стоимость: %s\n{FFFFFF}В наличии: %s\n\n{CCCCCC}Информация:\n{FFFFFF}%s",
			Inv_GetNameBanner(TP_PlayerInfo[playerid][TP_ItemID][item_id]), price, in_stock, Inv_GetInfoBanner(TP_PlayerInfo[playerid][TP_ItemID][item_id]));
			
			Dialog_Open(playerid, Dialog:TP_BuyItemInfo, DSM, "Покупка на торговой площадке", str, "Купить", "Выйти");
		}
		default: {
			f(str, "{FFFFFF}Предмет: {cc8418}%s\n{FFFFFF}Стоимость: %s\n{FFFFFF}В наличии: %s\n\n{CCCCCC}Информация:\n{FFFFFF}%s", Inv_GetNameItem(TP_PlayerInfo[playerid][TP_ItemID][item_id]), price, in_stock, Inv_GetInfoItem(TP_PlayerInfo[playerid][TP_ItemID][item_id]));
			Dialog_Open(playerid, Dialog:TP_BuyItemInfo, DSM, "Покупка на торговой площадке", str, "Купить", "Выйти");
		}
	}

	TP_PlayerInfo[playerid][TP_ActiveSelect] = false;
	return 1;
}

DialogResponse:TP_BuyItemInfo(playerid, response, listitem, inputtext[])
{
	if(!response) {
		DeletePVar(playerid, "TP_ItemBuy_PVar");
		DeletePVar(playerid, "TP_ItemPrice_PVar");
		DeletePVar(playerid, "TP_ItemGL_PVar");
		TP_PlayerInfo[playerid][TP_ActiveSelect] = true;
		return 1;
	}

	new
		item_id = GetPVarInt(playerid, "TP_ItemBuy_PVar"),
		item_credits = GetPVarInt(playerid, "TP_ItemPrice_PVar"),
		item_goldcoins = GetPVarInt(playerid, "TP_ItemGL_PVar");

	if(item_goldcoins > 0 && item_credits > 0) {
		Dialog_Show(playerid, Dialog:TP_BuyItem);
		return 1;
	}

	static
		str[90 - 2 + 1 + INV_MAX_ITEM_NAME_LENGTH];

	str[0] = EOS;
	
	if(item_goldcoins > 0 && item_credits < 1) {
		if(pInfo[playerid][pGoldCoin] - item_goldcoins < 0) {
			switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
				case 7: { // Баннеры
					Dialog_Message(playerid, "Покупка баннера", "{CC0033}Ошибка: недостаточно {FF0033}GoldCoins", "Хорошо");
				}
				default: {
					Dialog_Message(playerid, "Покупка предмета", "{CC0033}Ошибка: недостаточно {FF0033}GoldCoins", "Хорошо");
				}
			}
			TP_PlayerInfo[playerid][TP_ActiveSelect] = true;
			return 1;
		}

		SetPlayerGoldCoins(playerid, -item_goldcoins);
		switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
			case 7: { // Баннеры
				Inv_SetPlayerBanner(playerid, item_id, 1);

				f(str, "{FFFFFF}Баннер: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", Inv_GetNameBanner(item_id));
				
				Dialog_Message(playerid, "Покупка баннера", str, "Хорошо");
			}
			default: {
				switch(item_id) {
					case 312..314: Inv_SetPlayerItem(playerid, item_id, 60); // Кейсы
					default: Inv_SetPlayerItem(playerid, item_id, 1);
				}

				f(str, "{FFFFFF}Предмет: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", Inv_GetNameItem(item_id));
				Dialog_Message(playerid, "Покупка предмета", str, "Хорошо");
			}
		}
	}
	else if(item_goldcoins < 1 && item_credits > 0) {
		if(pInfo[playerid][pCredit] - item_credits < 0) {
			switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
				case 7: { // Баннеры
					Dialog_Message(playerid, "Покупка баннера", "{CC0033}Ошибка: недостаточно кредитов", "Хорошо");
				}
				default: {
					Dialog_Message(playerid, "Покупка предмета", "{CC0033}Ошибка: недостаточно кредитов", "Хорошо");
				}
			}
			TP_PlayerInfo[playerid][TP_ActiveSelect] = true;
			return 1;
		}

		SetPlayerCredit(playerid, -item_credits);
		switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
			case 7: { // Баннеры
				Inv_SetPlayerBanner(playerid, item_id, 1);

				f(str, "{FFFFFF}Баннер: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", Inv_GetNameBanner(item_id));
				Dialog_Message(playerid, "Покупка баннера", str, "Хорошо");
			}
			default: {
				switch(item_id) {
					case 312..314: Inv_SetPlayerItem(playerid, item_id, 60); // Кейсы
					default: Inv_SetPlayerItem(playerid, item_id, 1);
				}

				f(str, "{FFFFFF}Предмет: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", Inv_GetNameItem(item_id));
				Dialog_Message(playerid, "Покупка предмета", str, "Хорошо");
			}
		}
	}

	TP_PlayerInfo[playerid][TP_ActiveSelect] = true;
	DeletePVar(playerid, "TP_ItemBuy_PVar");
	DeletePVar(playerid, "TP_ItemPrice_PVar");
	DeletePVar(playerid, "TP_ItemGL_PVar");
	return 1;
}

DialogCreate:TP_BuyItem(playerid)
{
	switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
		case 7: { // Баннеры
			Dialog_Open(playerid, Dialog:TP_BuyItem, DSL, "Покупка баннера", ""C_N"• {FFFFFF}За кредиты\n"C_N"• {FFFFFF}За GoldCoins", "Купить", "Назад");
		}
		default: {
			Dialog_Open(playerid, Dialog:TP_BuyItem, DSL, "Покупка предмета", ""C_N"• {FFFFFF}За кредиты\n"C_N"• {FFFFFF}За GoldCoins", "Купить", "Назад");
		}
	}
	return 1;
}

DialogResponse:TP_BuyItem(playerid, response, listitem, inputtext[])
{
	if(!response) {
		DeletePVar(playerid, "TP_ItemBuy_PVar");
		DeletePVar(playerid, "TP_ItemPrice_PVar");
		DeletePVar(playerid, "TP_ItemGL_PVar");
		TP_PlayerInfo[playerid][TP_ActiveSelect] = true;
		return 1;
	}

	new 
		item_id = GetPVarInt(playerid, "TP_ItemBuy_PVar"), 
		item_credits = GetPVarInt(playerid, "TP_ItemPrice_PVar"), 
		item_goldcoins = GetPVarInt(playerid, "TP_ItemGL_PVar");
		
	DeletePVar(playerid, "TP_ItemBuy_PVar");
	DeletePVar(playerid, "TP_ItemPrice_PVar");
	DeletePVar(playerid, "TP_ItemGL_PVar");

	static 
		str[90 - 2 + 1 + INV_MAX_ITEM_NAME_LENGTH];

	str[0] = EOS;

	switch(listitem) {
		case 0: {
			if(pInfo[playerid][pCredit] - item_credits < 0) {
				switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
					case 7: { // Баннеры
						Dialog_Message(playerid, "Покупка баннера", "{CC0033}Ошибка: недостаточно кредитов", "Хорошо");
					}
					default: {
						Dialog_Message(playerid, "Покупка предмета", "{CC0033}Ошибка: недостаточно кредитов", "Хорошо");
					}
				}
				TP_PlayerInfo[playerid][TP_ActiveSelect] = true;
				return 1;
			}
			
			SetPlayerCredit(playerid, -item_credits);
			switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
				case 7: { // Баннеры
					Inv_SetPlayerBanner(playerid, item_id, 1);

					f(str, "{FFFFFF}Баннер: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", Inv_GetNameBanner(item_id));
					Dialog_Message(playerid, "Покупка баннера", str, "Хорошо");
				}
				default: {
					switch(item_id) {
						case 312..314: Inv_SetPlayerItem(playerid, item_id, 60); // Кейсы
						default: Inv_SetPlayerItem(playerid, item_id, 1);
					}

					f(str, "{FFFFFF}Предмет: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", Inv_GetNameItem(item_id));
					Dialog_Message(playerid, "Покупка предмета", str, "Хорошо");
				}
			}
		}
		case 1: {
			if(pInfo[playerid][pGoldCoin] - item_goldcoins < 0) {
				switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
					case 7: { // Баннеры
						Dialog_Message(playerid, "Покупка баннера", "{CC0033}Ошибка: недостаточно {FF0033}GoldCoins", "Хорошо");
					}
					default: {
						Dialog_Message(playerid, "Покупка предмета", "{CC0033}Ошибка: недостаточно {FF0033}GoldCoins", "Хорошо");
					}
				}
				TP_PlayerInfo[playerid][TP_ActiveSelect] = true;
				return 1;
			}

			SetPlayerGoldCoins(playerid, -item_goldcoins);
			switch(TP_PlayerInfo[playerid][TP_BuyItems]) {
				case 7: { // Баннеры
					Inv_SetPlayerBanner(playerid, item_id, 1);

					f(str, "{FFFFFF}Баннер: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", Inv_GetNameBanner(item_id));
					Dialog_Message(playerid, "Покупка баннера", str, "Хорошо");
				}
				default: {
					switch(item_id) {
						case 312..314: Inv_SetPlayerItem(playerid, item_id, 60); // Кейсы
						default: Inv_SetPlayerItem(playerid, item_id, 1);
					}

					f(str, "{FFFFFF}Предмет: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", Inv_GetNameItem(item_id));
					Dialog_Message(playerid, "Покупка предмета", str, "Хорошо");
				}
			}
		}
	}
	TP_PlayerInfo[playerid][TP_ActiveSelect] = true;
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
	ResetPlayerData(playerid);
	ResetPlayerTDs(playerid);

	#if defined TradingP_OnPlayerConnect
		return TradingP_OnPlayerConnect(playerid);
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
#define OnPlayerConnect TradingP_OnPlayerConnect
#if defined TradingP_OnPlayerConnect
	forward TradingP_OnPlayerConnect(playerid);
#endif
