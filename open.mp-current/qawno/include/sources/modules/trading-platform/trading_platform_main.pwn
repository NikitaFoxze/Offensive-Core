/*
 * |>================================<|
 * |   About: Trading-platform main   |
 * |   Author: Foxze                  |
 * |>================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)
 * Stock:
	- (None)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_TP_TD_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- TP_BuyItemInfo
	- TP_BuyItem
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- TradingPlatform
 */

#if defined _INC_TRADING_PLATFORM_MAIN
	#endinput
#endif
#define _INC_TRADING_PLATFORM_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_TP_TD_INFO {
	e_BuyItems,
	e_Block,
	e_Page,
	bool:e_ActiveSelected,
	e_ItemID[TRAD_PLAT_MAX_SHOW_ITEMS],
	e_Money[TRAD_PLAT_MAX_SHOW_ITEMS],
	e_GoldCoins[TRAD_PLAT_MAX_SHOW_ITEMS]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_TP_TD_INFO];

static
	PlayerText:TD_SelectCategoryItems[MAX_PLAYERS][TRAD_PLAT_TD_SELECT_CATEGORY],
	PlayerText:TD_SelectPageItems[MAX_PLAYERS][TRAD_PLAT_TD_SELECT_PAGE],
	PlayerText:TD_Blocks[MAX_PLAYERS][TRAD_PLAT_TD_BLOCKS],
	PlayerText:TD_Item[MAX_PLAYERS][TRAD_PLAT_TD_ITEM];

static
	PlayerStatus[MAX_PLAYERS];

static const
	HeadNameBlock[TRAD_PLAT_MAX_BLOCKS_HEAD][TRAD_PLAT_MAX_LEN_BLOCK_NAME] = {"Банданы", "Шапки", "Кепки", "Шляпы", "Каски"};

static const
	GlassesNameBlock[TRAD_PLAT_MAX_BLOCKS_GLASSES][TRAD_PLAT_MAX_LEN_BLOCK_NAME] = {"Модные", "С_блеском", "Авиаторские"};

static const
	MaskNameBlock[TRAD_PLAT_MAX_BLOCKS_MASK][TRAD_PLAT_MAX_LEN_BLOCK_NAME] = {"Хоккейные", "Разные"};

static const
	WatchNameBlock[TRAD_PLAT_MAX_BLOCKS_WATCH][TRAD_PLAT_MAX_LEN_BLOCK_NAME] = {"Дорогие", "Разные"};

static const
	SkinNameBlock[TRAD_PLAT_MAX_BLOCKS_SKINS][TRAD_PLAT_MAX_LEN_BLOCK_NAME] = {"Мужские", "Женские"};

static const
	BannerNameBlock[TRAD_PLAT_MAX_BLOCKS_BANNERS][TRAD_PLAT_MAX_LEN_BLOCK_NAME] = {"Значки", "Разное"};

static const
	ListHeadBandana[19][3] = { // Банданы

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
	ListHeadHat[8][3] = { // Шапки

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
	ListHeadCap[19][3] = { // Кепки

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
	ListHeadHat2[32][3] = { // Шляпы

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
	ListHeadHelmet[13][3] = { // Каски

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
	ListHeadPhones[4][3] = { // Headphone

	{413, 100000, 0},
	{414, 100000, 0},
	{415, 100000, 0},
	{416, 100000, 0}
};

static const
	ListGlassesStylish[3][3] = { // Модные очки

	{417, 40000, 0},
	{419, 50000, 0},
	{418, 60000, 0}
};

static const
	ListGlassesShine[11][3] = { // С блеском очки

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
	ListGlassesAviator[10][3] = { // Авиаторские очки

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
	ListMaskHockey[3][3] = { // Хоккейные маски

	{454, 50000, 0},
	{455, 50000, 0},
	{456, 50000, 0}
};

static const
	ListMaskOther[13][3] = { // Разные маски

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
	ListWatchCostly[5][3] = { // Дорогие часы

	{461, 90000, 0},
	{460, 100000, 0},
	{463, 100000, 0},
	{459, 130000, 0},
	{462, 130000, 0}
};

static const
	ListWatchOther[10][3] = { // Разные часы

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
	ListCases[3][3] = { // Cases

	{312, 60000, 0},
	{313, 100000, 0},
	{314, 150000, 0}
};

static const
	ListBannerBadge[9][3] = { // Banners значков

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
	ListBannerOther[14][3] = { // Разные баннеры

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
	ListMaleSkin[102][3] = { // Мужские скины

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
	ListFemaleSkin[47][3] = { // Женские скины

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
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

static CreatePlayerSlotItemsTD(playerid, itemid, td, modelid, price, goldCoins) 
{
	static const 
		Float:posTD[TRAD_PLAT_MAX_SHOW_ITEMS][2] = {
		{231.0, 149.0},
		{313.0, 149.0},
		{395.0, 149.0},
		{231.0, 232.0},
		{313.0, 232.0},
		{395.0, 232.0}
	};

	switch (pInfo[playerid][e_BuyItems]) {
		// Banners
		case 7: {
			CreatePlayerTPItemTD(playerid, TD_Item[playerid], posTD[itemid][0], posTD[itemid][1], true, td);

			PlayerTextDrawSetString(playerid, TD_Item[playerid][td + 2], GetInvBannerModel(modelid));
			PlayerTextDrawShow(playerid, TD_Item[playerid][td + 2]);
		}
		default: {
			CreatePlayerTPItemTD(playerid, TD_Item[playerid], posTD[itemid][0], posTD[itemid][1], false, td);

			new
				Float:x, Float:y, Float:z;

			GetInvPosItem(modelid, x, y, z);
			PlayerTextDrawSetPreviewModel(playerid, TD_Item[playerid][td], GetInvModelItem(modelid));
			PlayerTextDrawSetPreviewRot(playerid, TD_Item[playerid][td], x, y, z, 1.0000);
		}
	}

	static
		str[50];

	str[0] = EOS;

	if (price > 0) {
		f(str, "$%i", price);
	}

	if (goldCoins > 0 && price > 0) {
		f(str, "%s ~w~или ~y~%i GL", str, goldCoins);
	}
	else if (goldCoins > 0 && price < 1) {
		f(str, "~y~%i GL", goldCoins);
	}

	PlayerTextDrawSetString(playerid, TD_Item[playerid][td + 1], str);

	PlayerTextDrawShow(playerid, TD_Item[playerid][td]);
	PlayerTextDrawShow(playerid, TD_Item[playerid][td + 1]);
	return 1;
}

static ShowPlayerBlockItemsTD(playerid, changeSlot, bool:transText = false)
{
	if (!transText) {
		if (pInfo[playerid][e_Block] == changeSlot) {
			return 1;
		}
	}

	new
		tdid;

	for (new i = 0, td = 0; i < pInfo[playerid][e_Block]; i++, td += 2) {
		tdid = td;
	}

	PlayerTextDrawBackgroundColour(playerid, TD_Blocks[playerid][tdid], 757935615);
	PlayerTextDrawShow(playerid, TD_Blocks[playerid][tdid]);

	pInfo[playerid][e_Block] = changeSlot;

	for (new i = 0, td = 0; i < pInfo[playerid][e_Block]; i++, td += 2) {
		tdid = td;
	}

	PlayerTextDrawBackgroundColour(playerid, TD_Blocks[playerid][tdid], 0x0e5408FF);
	PlayerTextDrawShow(playerid, TD_Blocks[playerid][tdid]);

	new
		size;

	GetSlotItemTP(playerid, size);
	ShowPlayerNextSlotItemsTD(playerid, size);
	return 1;
}

static ShowPlayerMaxPageTD(playerid, number, bool:text)
{
	new
		page_max, s;

	n_for(i, number) {
		s += 6;
		if (s < number) {
			page_max++;
		}
		else if (s >= number) {
			page_max++;
			break;
		}
	}

	if (text) {
		PlayerTextDrawSetString(playerid, TD_SelectPageItems[playerid][6], "%i/%i", pInfo[playerid][e_Page], page_max);
	}
	else {
		return page_max;
	}
	return 1;
}

static DestroyPlayerItemsTD(playerid)
{
	if (GetPVarInt(playerid, "TP_ActiveTD") > 0) {
		switch (pInfo[playerid][e_BuyItems]) {
			case 7: { // Banners
				for (new i = 0, td = 0; i < GetPVarInt(playerid, "TP_ActiveTD"); i++, td += 3) {
					DestroyPlayerTD(playerid, TD_Item[playerid][td]);
					DestroyPlayerTD(playerid, TD_Item[playerid][td + 1]);
					DestroyPlayerTD(playerid, TD_Item[playerid][td + 2]);
				}
			}
			default: {
				for (new i = 0, td = 0; i < GetPVarInt(playerid, "TP_ActiveTD"); i++, td += 2) {
					DestroyPlayerTD(playerid, TD_Item[playerid][td]);
					DestroyPlayerTD(playerid, TD_Item[playerid][td + 1]);
				}
			}
		}
	}
	DeletePVar(playerid, "TP_ActiveTD");
	return 1;
}

static ShowPlayerNextSlotItemsTD(playerid, number)
{
	DestroyPlayerItemsTD(playerid);

	new
		items;

	if (pInfo[playerid][e_Page] > 1) {
		items = (pInfo[playerid][e_Page] - 1) * 6;
	}
	else {
		items = pInfo[playerid][e_Page];
	}

	if ((items + 6) <= number) {
		new
			size;

		if (pInfo[playerid][e_Page] > 1) {
			items++;
		}

		switch (pInfo[playerid][e_BuyItems]) {
			case 7: { // Banners
				for (new i = 0, td = 0, t = 0; i < TRAD_PLAT_MAX_SHOW_ITEMS; i++, t++, td += 3) {
					GetSlotItemTP(playerid, size, items - 1, pInfo[playerid][e_ItemID][i], pInfo[playerid][e_Money][i], pInfo[playerid][e_GoldCoins][i]);
					CreatePlayerSlotItemsTD(playerid, t, td, pInfo[playerid][e_ItemID][i], pInfo[playerid][e_Money][i], pInfo[playerid][e_GoldCoins][i]);
					SetPVarInt(playerid, "TP_ActiveTD", i + 1);
					items++;
				}
			}
			default: {
				for (new i = 0, td = 0, t = 0; i < TRAD_PLAT_MAX_SHOW_ITEMS; i++, t++, td += 2) {
					GetSlotItemTP(playerid, size, items - 1, pInfo[playerid][e_ItemID][i], pInfo[playerid][e_Money][i], pInfo[playerid][e_GoldCoins][i]);
					CreatePlayerSlotItemsTD(playerid, t, td, pInfo[playerid][e_ItemID][i], pInfo[playerid][e_Money][i], pInfo[playerid][e_GoldCoins][i]);
					SetPVarInt(playerid, "TP_ActiveTD", i + 1);
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

		if (pInfo[playerid][e_Page] == 1) {
			cycle = size;
		}
		else {
			cycle = number - items;
			items++;
		}

		switch (pInfo[playerid][e_BuyItems]) {
			case 7: { // Banners
				for (new i = 0, td = 0, t = 0; i < cycle; i++, t++, td += 3) {
					GetSlotItemTP(playerid, size, items - 1, pInfo[playerid][e_ItemID][i], pInfo[playerid][e_Money][i], pInfo[playerid][e_GoldCoins][i]);
					CreatePlayerSlotItemsTD(playerid, t, td, pInfo[playerid][e_ItemID][i], pInfo[playerid][e_Money][i], pInfo[playerid][e_GoldCoins][i]);
					SetPVarInt(playerid, "TP_ActiveTD", i + 1);
					items++;
				}
			}
			default: {
				for (new i = 0, td = 0, t = 0; i < cycle; i++, t++, td += 2) {
					GetSlotItemTP(playerid, size, items - 1, pInfo[playerid][e_ItemID][i], pInfo[playerid][e_Money][i], pInfo[playerid][e_GoldCoins][i]);
					CreatePlayerSlotItemsTD(playerid, t, td, pInfo[playerid][e_ItemID][i], pInfo[playerid][e_Money][i], pInfo[playerid][e_GoldCoins][i]);
					SetPVarInt(playerid, "TP_ActiveTD", i + 1);
					items++;
				}	
			}
		}
	}
	ShowPlayerMaxPageTD(playerid, number, true);
	return 1;
}

static GetSlotItemTP(playerid, &size = 0, itemid = 0, &itemModel = 0, &price = 0, &goldCoins = 0)
{
	switch (pInfo[playerid][e_BuyItems]) {
		case 0: { // Head
			switch (pInfo[playerid][e_Block]) {
				case 1: { // Банданы
					itemModel = ListHeadBandana[itemid][0];
					price = ListHeadBandana[itemid][1];
					goldCoins = ListHeadBandana[itemid][2];
					size = sizeof(ListHeadBandana);
				}
				case 2: { // Шапки
					itemModel = ListHeadHat[itemid][0];
					price = ListHeadHat[itemid][1];
					goldCoins = ListHeadHat[itemid][2];
					size = sizeof(ListHeadHat);
				}
				case 3: { // Кепки
					itemModel = ListHeadCap[itemid][0];
					price = ListHeadCap[itemid][1];
					goldCoins = ListHeadCap[itemid][2];
					size = sizeof(ListHeadCap);
				}
				case 4: { // Шляпы
					itemModel = ListHeadHat2[itemid][0];
					price = ListHeadHat2[itemid][1];
					goldCoins = ListHeadHat2[itemid][2];
					size = sizeof(ListHeadHat2);
				}
				case 5: { // Каски
					itemModel = ListHeadHelmet[itemid][0];
					price = ListHeadHelmet[itemid][1];
					goldCoins = ListHeadHelmet[itemid][2];
					size = sizeof(ListHeadHelmet);
				}
			}
		}
		case 1: { // Headphone
			switch (pInfo[playerid][e_Block]) {
				case 1: { // Headphone
					itemModel = ListHeadPhones[itemid][0];
					price = ListHeadPhones[itemid][1];
					goldCoins = ListHeadPhones[itemid][2];
					size = sizeof(ListHeadPhones);
				}
			}
		}
		case 2: { // Glasses
			switch (pInfo[playerid][e_Block]) {
				case 1: { // Модные
					itemModel = ListGlassesStylish[itemid][0];
					price = ListGlassesStylish[itemid][1];
					goldCoins = ListGlassesStylish[itemid][2];
					size = sizeof(ListGlassesStylish);
				}
				case 2: { // С блеском
					itemModel = ListGlassesShine[itemid][0];
					price = ListGlassesShine[itemid][1];
					goldCoins = ListGlassesShine[itemid][2];
					size = sizeof(ListGlassesShine);
				}
				case 3: { // Авиаторские
					itemModel = ListGlassesAviator[itemid][0];
					price = ListGlassesAviator[itemid][1];
					goldCoins = ListGlassesAviator[itemid][2];
					size = sizeof(ListGlassesAviator);
				}
			}
		}
		case 3: { // Маски
			switch (pInfo[playerid][e_Block]) {
				case 1: { // Хоккейные
					itemModel = ListMaskHockey[itemid][0];
					price = ListMaskHockey[itemid][1];
					goldCoins = ListMaskHockey[itemid][2];
					size = sizeof(ListMaskHockey);
				}
				case 2: { // Разные
					itemModel = ListMaskOther[itemid][0];
					price = ListMaskOther[itemid][1];
					goldCoins = ListMaskOther[itemid][2];
					size = sizeof(ListMaskOther);
				}
			}
		}
		case 4: { // Watch
			switch (pInfo[playerid][e_Block]) {
				case 1: { // Дорогие
					itemModel = ListWatchCostly[itemid][0];
					price = ListWatchCostly[itemid][1];
					goldCoins = ListWatchCostly[itemid][2];
					size = sizeof(ListWatchCostly);
				}
				case 2: { // Разные
					itemModel = ListWatchOther[itemid][0];
					price = ListWatchOther[itemid][1];
					goldCoins = ListWatchOther[itemid][2];
					size = sizeof(ListWatchOther);
				}
			}
		}
		case 5: { // Skins
			switch (pInfo[playerid][e_Block]) {
				case 1: { // Мужские
					itemModel = ListMaleSkin[itemid][0];
					price = ListMaleSkin[itemid][1];
					goldCoins = ListMaleSkin[itemid][2];
					size = sizeof(ListMaleSkin);
				}
				case 2: { // Женские
					itemModel = ListFemaleSkin[itemid][0];
					price = ListFemaleSkin[itemid][1];
					goldCoins = ListFemaleSkin[itemid][2];
					size = sizeof(ListFemaleSkin);
				}
			}	
		}
		case 6: { // Cases
			switch (pInfo[playerid][e_Block]) {
				case 1: { // Cases
					itemModel = ListCases[itemid][0];
					price = ListCases[itemid][1];
					goldCoins = ListCases[itemid][2];
					size = sizeof(ListCases);
				}
			}
		}
		case 7: { // Banners
			switch (pInfo[playerid][e_Block]) {
				case 1: { // Значки
					itemModel = ListBannerBadge[itemid][0];
					price = ListBannerBadge[itemid][1];
					goldCoins = ListBannerBadge[itemid][2];
					size = sizeof(ListBannerBadge);
				}
				case 2: { // Разное
					itemModel = ListBannerOther[itemid][0];
					price = ListBannerOther[itemid][1];
					goldCoins = ListBannerOther[itemid][2];
					size = sizeof(ListBannerOther);
				}
			}
		}
	}
	return 1;
}

static ShowPlayerBuyItemTD(playerid, itemsid, page = 1, block = 1, bool:perevod_text = false)
{
	CreatePlayerTPSelectPageTD(playerid, TD_SelectPageItems[playerid]);

	new
		Float:posTD[2] = {155.0, 149.0};

	pInfo[playerid][e_BuyItems] = itemsid;
	pInfo[playerid][e_Page] = page;

	new
		tdid = 0;

	switch (itemsid) {
		case 0: { // Head
			PlayerTextDrawSetString(playerid, TD_SelectPageItems[playerid][4], "Меню_-_Голова");

			n_for(i, TRAD_PLAT_MAX_BLOCKS_HEAD) {
				CreatePlayerTPBlocksTD(playerid, TD_Blocks[playerid], posTD[0], posTD[1], HeadNameBlock[i], tdid);
				posTD[1] += 16.0;
			}
		}
		case 1: { // Headphone
			PlayerTextDrawSetString(playerid, TD_SelectPageItems[playerid][4], "Меню_-_Наушники");

			CreatePlayerTPBlocksTD(playerid, TD_Blocks[playerid], posTD[0], posTD[1], "Наушники", tdid);
		}
		case 2: { // Glasses
			PlayerTextDrawSetString(playerid, TD_SelectPageItems[playerid][4], "Меню_-_Очки");

			n_for(i, TRAD_PLAT_MAX_BLOCKS_GLASSES) {
				CreatePlayerTPBlocksTD(playerid, TD_Blocks[playerid], posTD[0], posTD[1], GlassesNameBlock[i], tdid);
				posTD[1] += 16.0;
			}
		}
		case 3: { // Mask
			PlayerTextDrawSetString(playerid, TD_SelectPageItems[playerid][4], "Меню_-_Маски");

			n_for(i, TRAD_PLAT_MAX_BLOCKS_MASK) {
				CreatePlayerTPBlocksTD(playerid, TD_Blocks[playerid], posTD[0], posTD[1], MaskNameBlock[i], tdid);
				posTD[1] += 16.0;
			}
		}
		case 4: { // Watch
			PlayerTextDrawSetString(playerid, TD_SelectPageItems[playerid][4], "Меню_-_Часы");

			n_for(i, TRAD_PLAT_MAX_BLOCKS_WATCH) {
				CreatePlayerTPBlocksTD(playerid, TD_Blocks[playerid], posTD[0], posTD[1], WatchNameBlock[i], tdid);
				posTD[1] += 16.0;
			}
		}
		case 5: { // Skins
			PlayerTextDrawSetString(playerid, TD_SelectPageItems[playerid][4], "Меню_-_Скины");

			n_for(i, TRAD_PLAT_MAX_BLOCKS_SKINS) {
				CreatePlayerTPBlocksTD(playerid, TD_Blocks[playerid], posTD[0], posTD[1], SkinNameBlock[i], tdid);
				posTD[1] += 16.0;
			}
		}
		case 6: { // Cases
			PlayerTextDrawSetString(playerid, TD_SelectPageItems[playerid][4], "Меню_-_Кейсы");

			CreatePlayerTPBlocksTD(playerid, TD_Blocks[playerid], posTD[0], posTD[1], "Кейсы", tdid);
		}
		case 7: { // Banners
			PlayerTextDrawSetString(playerid, TD_SelectPageItems[playerid][4], "Меню_-_Баннеры");

			n_for(i, TRAD_PLAT_MAX_BLOCKS_BANNERS) {
				CreatePlayerTPBlocksTD(playerid, TD_Blocks[playerid], posTD[0], posTD[1], BannerNameBlock[i], tdid);
				posTD[1] += 16.0;
			}
		}
	}

	n_for(i, tdid) {
		PlayerTextDrawShow(playerid, TD_Blocks[playerid][i]);
	}

	SetPVarInt(playerid, "TP_TDBlocks", tdid);

	ShowPlayerBlockItemsTD(playerid, block, perevod_text);

	n_for(i, TRAD_PLAT_TD_SELECT_PAGE) {
		PlayerTextDrawShow(playerid, TD_SelectPageItems[playerid][i]);
	}
	return 1;
}

static ShowBuyTradingPlatform(playerid, itemsid)
{
	n_for(i, TRAD_PLAT_TD_SELECT_CATEGORY) {
		DestroyPlayerTD(playerid, TD_SelectCategoryItems[playerid][i]);
	}

	pInfo[playerid][e_ActiveSelected] = true;
	ShowPlayerBuyItemTD(playerid, itemsid);
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerTDData(playerid)
{
	pInfo[playerid][e_BuyItems] = -1;
	pInfo[playerid][e_Block] = 0;
	pInfo[playerid][e_Page] = 0;
	pInfo[playerid][e_ActiveSelected] = false;

	n_for(i, TRAD_PLAT_MAX_SHOW_ITEMS) {
		pInfo[playerid][e_ItemID][i] =
		pInfo[playerid][e_Money][i] =
		pInfo[playerid][e_GoldCoins][i] = 0;
	}
	return 1;
}

static ResetPlayerData(playerid)
{
	PlayerStatus[playerid] = 0;
	ResetPlayerTDData(playerid);
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(i, TRAD_PLAT_TD_SELECT_PAGE) {
		TD_SelectPageItems[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TRAD_PLAT_TD_BLOCKS) {
		TD_Blocks[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TRAD_PLAT_TD_ITEM) {
		TD_Item[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, TRAD_PLAT_TD_SELECT_CATEGORY) {
		TD_SelectCategoryItems[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	return 1;
}

/*
 * |>------------------<|
 * |     Interfaces     |
 * |>------------------<|
 */

InterfaceCreate:TradingPlatform(playerid)
{
	PlayerStatus[playerid] = 1;

	switch (PlayerStatus[playerid]) {
		// Выбор раздела
		case 1: {
			CreatePlayerTPSelectCategoryTD(playerid, TD_SelectCategoryItems[playerid]);

			n_for(i, TRAD_PLAT_TD_SELECT_CATEGORY) {
				PlayerTextDrawShow(playerid, TD_SelectCategoryItems[playerid][i]);
			}
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
	switch (PlayerStatus[playerid]) {
		// Выбор раздела
		case 1: {
			n_for(i, TRAD_PLAT_TD_SELECT_CATEGORY) {
				DestroyPlayerTD(playerid, TD_SelectCategoryItems[playerid][i]);
			}
		}
		// Выбор предмета
		case 2: {
			n_for(i, TRAD_PLAT_TD_SELECT_PAGE) {
				DestroyPlayerTD(playerid, TD_SelectPageItems[playerid][i]);
			}

			n_for(i, GetPVarInt(playerid, "TP_TDBlocks")) {
				DestroyPlayerTD(playerid, TD_Blocks[playerid][i]);
			}

			DestroyPlayerItemsTD(playerid);
		}
	}

	PlayerStatus[playerid] = 0;

	DeletePVar(playerid, "TP_TDBlocks");
	DeletePVar(playerid, "TP_ItemBuy");
	DeletePVar(playerid, "TP_ItemPrice");
	DeletePVar(playerid, "TP_ItemGL");

	ResetPlayerTDData(playerid);
	ClosePlayerDialog(playerid);
	return 1;
}

InterfacePlayerClick:TradingPlatform(playerid, PlayerText:playertextid)
{
	switch (PlayerStatus[playerid]) {
		// Выбор раздела
		case 1: {
			if (playertextid == TD_SelectCategoryItems[playerid][22]) {
				Interface_Close(playerid, Interface:TradingPlatform);
				Interface_Show(playerid, Interface:MainMenu);
				return 1;
			}
			for (new td = 3, num = 0; num < 8; td += 2, num++) {
				if (playertextid == TD_SelectCategoryItems[playerid][td]) {
					PlayerStatus[playerid] = 2;
					ShowBuyTradingPlatform(playerid, num);
					break;
				}
			}
			return 1;
		}
		// Выбор предмета
		case 2: {
			if (pInfo[playerid][e_ActiveSelected]) {
				switch (pInfo[playerid][e_BuyItems]) {
					// Banners
					case 7: {
						for (new td = 0, num = 0; num < 6; td += 3, num++) {
							if (playertextid == TD_Item[playerid][td]) {
								SetPVarInt(playerid, "TP_ItemNum", num);
								Dialog_Show(playerid, Dialog:TP_BuyItemInfo);
								return 1;
							}
						}
					}
					default: {
						for (new td = 0, num = 0; num < 6; td += 2, num++) {
							if (playertextid == TD_Item[playerid][td]) {
								SetPVarInt(playerid, "TP_ItemNum", num);
								Dialog_Show(playerid, Dialog:TP_BuyItemInfo);
								return 1;
							}
						}
					}
				}
			}

			if (playertextid == TD_SelectPageItems[playerid][4]) {
				Interface_Close(playerid, Interface:TradingPlatform);
				Interface_Show(playerid, Interface:TradingPlatform);
				return 1;
			}
			else if (playertextid == TD_SelectPageItems[playerid][5]) {
				new 
					size;

				GetSlotItemTP(playerid, size);

				if (pInfo[playerid][e_Page] == ShowPlayerMaxPageTD(playerid, size, false))
					return 1;

				pInfo[playerid][e_Page]++;
				ShowPlayerNextSlotItemsTD(playerid, size);
				return 1;
			}
			else if (playertextid == TD_SelectPageItems[playerid][7]) {
				if (pInfo[playerid][e_Page] == 1) 
					return 1;

				pInfo[playerid][e_Page]--;

				new 
					size;
					
				GetSlotItemTP(playerid, size);
				ShowPlayerNextSlotItemsTD(playerid, size);
				return 1;
			}

			if (playertextid == TD_Blocks[playerid][0]) {
				pInfo[playerid][e_Page] = 1;
				ShowPlayerBlockItemsTD(playerid, 1);
				return 1;
			}
			else if (playertextid == TD_Blocks[playerid][2]) {
				pInfo[playerid][e_Page] = 1;
				ShowPlayerBlockItemsTD(playerid, 2);
				return 1;
			}
			else if (playertextid == TD_Blocks[playerid][4]) {
				pInfo[playerid][e_Page] = 1;
				ShowPlayerBlockItemsTD(playerid, 3);
				return 1;
			}
			else if (playertextid == TD_Blocks[playerid][6]) {
				pInfo[playerid][e_Page] = 1;
				ShowPlayerBlockItemsTD(playerid, 4);
				return 1;
			}
			else if (playertextid == TD_Blocks[playerid][8]) {
				pInfo[playerid][e_Page] = 1;
				ShowPlayerBlockItemsTD(playerid, 5);
				return 1;
			}
			return 1;
		}
	}
	return 1;
}

InterfaceClick:TradingPlatform(playerid, Text:clickedid)
{
	if (clickedid == INVALID_TEXT_DRAW) {
		switch (PlayerStatus[playerid]) {
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
		SelectTextDraw(playerid, TD_C_GREY);
	}
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

DialogCreate:TP_BuyItemInfo(playerid)
{
	new
		itemid = GetPVarInt(playerid, "TP_ItemNum");

	DeletePVar(playerid, "TP_ItemNum");

	if (pInfo[playerid][e_BuyItems] != 7) { // Banners
		if (!IsInvItemForPlayer(playerid, pInfo[playerid][e_ItemID][itemid])) {
			return 1;
		}
	}

	SetPVarInt(playerid, "TP_ItemBuy", pInfo[playerid][e_ItemID][itemid]);
	SetPVarInt(playerid, "TP_ItemPrice", pInfo[playerid][e_Money][itemid]);
	SetPVarInt(playerid, "TP_ItemGL", pInfo[playerid][e_GoldCoins][itemid]);

	static
		str[300],
		price[50],
		inStock[50];

	str[0] = price[0] = inStock[0] = EOS;

	new
		money = pInfo[playerid][e_Money][itemid],
		goldCoins = pInfo[playerid][e_GoldCoins][itemid];

	if (money > 0) {
		f(price, "{18a826}$%i", money);
		f(inStock, "{18a826}$%i", GetPlayerMoneyEx(playerid));
	}
	if (goldCoins > 0 && money > 0) {
		f(price, "%s "CT_WHITE"или {ccc321}%i GL", price, goldCoins);
		f(inStock, "%s "CT_WHITE"и {ccc321}%i GL", inStock, GetPlayerGoldCoins(playerid));
	}
	else if (goldCoins > 0 && money < 1) {
		f(price, "{ccc321}%i GL", goldCoins); 
		f(inStock, "{ccc321}%i GL", GetPlayerGoldCoins(playerid));
	}

	switch (pInfo[playerid][e_BuyItems]) {
		case 7: { // Banners
			f(str, ""CT_WHITE"Баннер: {cc8418}%s\n"CT_WHITE"Стоимость: %s\n"CT_WHITE"В наличии: %s\n\n"CT_GREY"Информация:\n"CT_WHITE"%s",
			GetInvNameBanner(pInfo[playerid][e_ItemID][itemid]), price, inStock, GetInvInfoBanner(pInfo[playerid][e_ItemID][itemid]));
			
			Dialog_Open(playerid, Dialog:TP_BuyItemInfo, DSM, "Покупка на торговой площадке", str, "Купить", "Выйти");
		}
		default: {
			f(str, ""CT_WHITE"Предмет: {cc8418}%s\n"CT_WHITE"Стоимость: %s\n"CT_WHITE"В наличии: %s\n\n"CT_GREY"Информация:\n"CT_WHITE"%s", GetInvNameItem(pInfo[playerid][e_ItemID][itemid]), price, inStock, GetInvInfoItem(pInfo[playerid][e_ItemID][itemid]));
			Dialog_Open(playerid, Dialog:TP_BuyItemInfo, DSM, "Покупка на торговой площадке", str, "Купить", "Выйти");
		}
	}

	pInfo[playerid][e_ActiveSelected] = false;
	return 1;
}

DialogResponse:TP_BuyItemInfo(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "TP_ItemBuy");
		DeletePVar(playerid, "TP_ItemPrice");
		DeletePVar(playerid, "TP_ItemGL");
		pInfo[playerid][e_ActiveSelected] = true;
		return 1;
	}

	new
		itemid = GetPVarInt(playerid, "TP_ItemBuy"),
		itemMoney = GetPVarInt(playerid, "TP_ItemPrice"),
		itemGoldCoins = GetPVarInt(playerid, "TP_ItemGL");

	if (itemGoldCoins > 0 && itemMoney > 0) {
		Dialog_Show(playerid, Dialog:TP_BuyItem);
		return 1;
	}

	static
		str[90 - 2 + 1 + INV_MAX_ITEM_NAME_LENGTH];

	str[0] = EOS;
	
	if (itemGoldCoins > 0 && itemMoney < 1) {
		if (GetPlayerGoldCoins(playerid) - itemGoldCoins < 0) {
			switch (pInfo[playerid][e_BuyItems]) {
				case 7: { // Banners
					Dialog_Message(playerid, "Покупка баннера", ""CT_RED"Ошибка: недостаточно {FF0033}GoldCoins", "Хорошо");
				}
				default: {
					Dialog_Message(playerid, "Покупка предмета", ""CT_RED"Ошибка: недостаточно {FF0033}GoldCoins", "Хорошо");
				}
			}
			pInfo[playerid][e_ActiveSelected] = true;
			return 1;
		}

		GivePlayerGoldCoins(playerid, -itemGoldCoins);
		switch (pInfo[playerid][e_BuyItems]) {
			case 7: { // Banners
				GivePlayerInvBanner(playerid, itemid, 1);

				f(str, ""CT_WHITE"Баннер: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", GetInvNameBanner(itemid));
				
				Dialog_Message(playerid, "Покупка баннера", str, "Хорошо");
			}
			default: {
				switch (itemid) {
					case 312..314: GivePlayerInvItem(playerid, itemid, 60); // Cases
					default: GivePlayerInvItem(playerid, itemid, 1);
				}

				f(str, ""CT_WHITE"Предмет: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", GetInvNameItem(itemid));
				Dialog_Message(playerid, "Покупка предмета", str, "Хорошо");
			}
		}
	}
	else if (itemGoldCoins < 1 && itemMoney > 0) {
		if (GetPlayerMoneyEx(playerid) - itemMoney < 0) {
			switch (pInfo[playerid][e_BuyItems]) {
				case 7: { // Banners
					Dialog_Message(playerid, "Покупка баннера", ""CT_RED"Ошибка: недостаточно денег", "Хорошо");
				}
				default: {
					Dialog_Message(playerid, "Покупка предмета", ""CT_RED"Ошибка: недостаточно денег", "Хорошо");
				}
			}
			pInfo[playerid][e_ActiveSelected] = true;
			return 1;
		}

		GivePlayerMoneyEx(playerid, -itemMoney);
		switch (pInfo[playerid][e_BuyItems]) {
			case 7: { // Banners
				GivePlayerInvBanner(playerid, itemid, 1);

				f(str, ""CT_WHITE"Баннер: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", GetInvNameBanner(itemid));
				Dialog_Message(playerid, "Покупка баннера", str, "Хорошо");
			}
			default: {
				switch (itemid) {
					case 312..314: GivePlayerInvItem(playerid, itemid, 60); // Cases
					default: GivePlayerInvItem(playerid, itemid, 1);
				}

				f(str, ""CT_WHITE"Предмет: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", GetInvNameItem(itemid));
				Dialog_Message(playerid, "Покупка предмета", str, "Хорошо");
			}
		}
	}

	pInfo[playerid][e_ActiveSelected] = true;
	DeletePVar(playerid, "TP_ItemBuy");
	DeletePVar(playerid, "TP_ItemPrice");
	DeletePVar(playerid, "TP_ItemGL");
	return 1;
}

DialogCreate:TP_BuyItem(playerid)
{
	switch (pInfo[playerid][e_BuyItems]) {
		case 7: { // Banners
			Dialog_Open(playerid, Dialog:TP_BuyItem, DSL, "Покупка баннера", ""CT_ORANGE""T_NUM" "CT_WHITE"За деньги\n"CT_ORANGE""T_NUM" "CT_WHITE"За GoldCoins", "Купить", "Назад");
		}
		default: {
			Dialog_Open(playerid, Dialog:TP_BuyItem, DSL, "Покупка предмета", ""CT_ORANGE""T_NUM" "CT_WHITE"За деньги\n"CT_ORANGE""T_NUM" "CT_WHITE"За GoldCoins", "Купить", "Назад");
		}
	}
	return 1;
}

DialogResponse:TP_BuyItem(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "TP_ItemBuy");
		DeletePVar(playerid, "TP_ItemPrice");
		DeletePVar(playerid, "TP_ItemGL");
		pInfo[playerid][e_ActiveSelected] = true;
		return 1;
	}

	new 
		itemid = GetPVarInt(playerid, "TP_ItemBuy"), 
		itemMoney = GetPVarInt(playerid, "TP_ItemPrice"), 
		itemGoldCoins = GetPVarInt(playerid, "TP_ItemGL");
		
	DeletePVar(playerid, "TP_ItemBuy");
	DeletePVar(playerid, "TP_ItemPrice");
	DeletePVar(playerid, "TP_ItemGL");

	static 
		str[90 - 2 + 1 + INV_MAX_ITEM_NAME_LENGTH];

	str[0] = EOS;

	switch (listitem) {
		case 0: {
			if (GetPlayerMoney(playerid) - itemMoney < 0) {
				switch (pInfo[playerid][e_BuyItems]) {
					case 7: { // Banners
						Dialog_Message(playerid, "Покупка баннера", ""CT_RED"Ошибка: недостаточно денег", "Хорошо");
					}
					default: {
						Dialog_Message(playerid, "Покупка предмета", ""CT_RED"Ошибка: недостаточно денег", "Хорошо");
					}
				}
				pInfo[playerid][e_ActiveSelected] = true;
				return 1;
			}
			
			GivePlayerMoneyEx(playerid, -itemMoney);
			switch (pInfo[playerid][e_BuyItems]) {
				case 7: { // Banners
					GivePlayerInvBanner(playerid, itemid, 1);

					f(str, ""CT_WHITE"Баннер: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", GetInvNameBanner(itemid));
					Dialog_Message(playerid, "Покупка баннера", str, "Хорошо");
				}
				default: {
					switch (itemid) {
						case 312..314: GivePlayerInvItem(playerid, itemid, 60); // Cases
						default: GivePlayerInvItem(playerid, itemid, 1);
					}

					f(str, ""CT_WHITE"Предмет: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", GetInvNameItem(itemid));
					Dialog_Message(playerid, "Покупка предмета", str, "Хорошо");
				}
			}
		}
		case 1: {
			if (GetPlayerGoldCoins(playerid) - itemGoldCoins < 0) {
				switch (pInfo[playerid][e_BuyItems]) {
					case 7: { // Banners
						Dialog_Message(playerid, "Покупка баннера", ""CT_RED"Ошибка: недостаточно {FF0033}GoldCoins", "Хорошо");
					}
					default: {
						Dialog_Message(playerid, "Покупка предмета", ""CT_RED"Ошибка: недостаточно {FF0033}GoldCoins", "Хорошо");
					}
				}
				pInfo[playerid][e_ActiveSelected] = true;
				return 1;
			}

			GivePlayerGoldCoins(playerid, -itemGoldCoins);
			switch (pInfo[playerid][e_BuyItems]) {
				case 7: { // Banners
					GivePlayerInvBanner(playerid, itemid, 1);

					f(str, ""CT_WHITE"Баннер: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", GetInvNameBanner(itemid));
					Dialog_Message(playerid, "Покупка баннера", str, "Хорошо");
				}
				default: {
					switch (itemid) {
						case 312..314: GivePlayerInvItem(playerid, itemid, 60); // Cases
						default: GivePlayerInvItem(playerid, itemid, 1);
					}

					f(str, ""CT_WHITE"Предмет: {cc8418}%s\n{18a826}Успешно куплен и добавлен в инвентарь!", GetInvNameItem(itemid));
					Dialog_Message(playerid, "Покупка предмета", str, "Хорошо");
				}
			}
		}
	}
	pInfo[playerid][e_ActiveSelected] = true;
	return 1;
}

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
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
 * |>-------<|
 * |   ALS   |
 * |>-------<|
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