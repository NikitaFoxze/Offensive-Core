/*
 * |>===========================<|
 * |   About: DM location head   |
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

#if defined _INC_DM_LOC_HEAD
	#endinput
#endif
#define _INC_DM_LOC_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Spawn
#define DM_MAX_SPAWN_POS	(6)		// Number of spawn positions

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	DM_LOC_DESERT = 0,
	DM_LOC_GOLF,
	DM_LOC_MILITARYOIL,
	DM_LOC_HOMEWHEELS,
	DM_LOC_POOL,
	DM_LOC_WAREHOUSE,
	DM_LOC_DOGMANSION,
	DM_LOC_PALACESMOKE,
	DM_LOC_ATRIUM,
	DM_LOC_JIZZY
}