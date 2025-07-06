/*
 * |>============================<|
 * |   About: Drop-weapons head   |
 * |   Author: Foxze              |
 * |>============================<|
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
	- Iterator:TotalDropWeapons[MAX_PLAYERS]<DROP_WEAPONS_MAX>
 */

#if defined _INC_DROP_WEAPONS_HEAD
	#endinput
#endif
#define _INC_DROP_WEAPONS_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define DROP_WEAPONS_MAX		(5)		// Max weapon slots in drop
#define DROP_WEAPONS_TIMER		(30)	// Timer until weapon is removed in seconds

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

new
	Iterator:TotalDropWeapons[MAX_PLAYERS]<DROP_WEAPONS_MAX>;
