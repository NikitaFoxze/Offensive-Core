/*

	About: Inventory header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		-
Enums:
	-
Global var:
	-
------------------------------------------------------------------------------*/

#if defined _INC_INVENTORY_HEADER
	#endinput
#endif
#define _INC_INVENTORY_HEADER

/*

	* Defines *

*/

#define INV_PLAYER_MAX_DEST_ITEMS	(8)			// Макс. кол-во надеваемых предметов у игрока
#define INV_PLAYER_MAX_ITEMS		(72)		// Макс. кол-во предметов в инвентаре игрока
#define INV_PLAYER_MAX_BANNERS		(18)		// Макс. кол-во баннеров в инвентаре игрока

#define INV_TD_MAX_ITEMS			(36)		// Макс. кол-во TD ячеек предметов
#define INV_TD_MAX_BANNERS			(18)		// Макс. кол-во TD ячеек баннеров
#define INV_TD_MAX_COLUMN_ITEMS		(6)			// Макс. кол-во TD столбов в разделе предметы
#define INV_TD_MAX_COLUMN_BANNERS	(6)			// Макс. кол-во TD столбов в разделе баннеры

#define INV_PLAYER_DEST_SKINS		(1)			// Скины
#define INV_PLAYER_DEST_HEAD		(2)			// Голова
#define INV_PLAYER_DEST_HEADPHONES	(3)			// Наушники
#define INV_PLAYER_DEST_GLASSES		(4)			// Очки
#define INV_PLAYER_DEST_MASKS		(5)			// Маски
#define INV_PLAYER_DEST_WATCH		(6)			// Часы
#define INV_PLAYER_DEST_CASES		(7)			// Кейсы

#define INV_MAX_ITEM_NAME_LENGTH	(100 + 1)
#define INV_MAX_ITEM_INFO_LENGTH	(300 + 1)

// Cases
#define CASE_MAX_REWARDS			(8)			// Макс. кол-во награды за кейс
#define CASE_ITEMS_MALE				(86)		// Кол-во предметов в списке у мужчин
#define CASE_ITEMS_FEMALE			(47)		// Кол-во предметов в списке у женщин