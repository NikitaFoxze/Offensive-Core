/*
 * |>=========================<|
 * |   About: Inventory head   |
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
	- (None)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_INVENTORY_HEAD
	#endinput
#endif
#define _INC_INVENTORY_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Core
#define INV_PLAYER_MAX_USES_ITEMS	(8)			// Max number of equippable items per player
#define INV_PLAYER_MAX_ITEMS		(72)		// Max items in player inventory
#define INV_PLAYER_MAX_BANNERS		(18)		// Max number of banners in player inventory

// TextDraw's
#define INV_TD_MAX_ITEMS			(36)		// Max TD item slots
#define INV_TD_MAX_BANNERS			(18)		// Max TD banner cells
#define INV_TD_MAX_COLUMN_ITEMS		(6)			// Max TD columns in items section
#define INV_TD_MAX_COLUMN_BANNERS	(6)			// Max TD pillars in banners section

// Categories of items
#define INV_PLAYER_DEST_SKINS		(1)
#define INV_PLAYER_DEST_HEAD		(2)
#define INV_PLAYER_DEST_HEADPHONES	(3)
#define INV_PLAYER_DEST_GLASSES		(4)
#define INV_PLAYER_DEST_MASKS		(5)
#define INV_PLAYER_DEST_WATCH		(6)
#define INV_PLAYER_DEST_CASES		(7)

// Length strings
#define INV_MAX_ITEM_NAME_LENGTH	(100 + 1)
#define INV_MAX_ITEM_INFO_LENGTH	(300 + 1)

// Cases
#define CASE_MAX_REWARDS			(8)			// Max reward amount per case
#define CASE_ITEMS_MALE				(86)		// Number of items in the list for men
#define CASE_ITEMS_FEMALE			(47)		// Number of items in the list for women