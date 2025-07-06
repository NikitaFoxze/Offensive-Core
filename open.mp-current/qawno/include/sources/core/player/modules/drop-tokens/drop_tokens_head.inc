/*
 * |>===========================<|
 * |   About: Drop-tokens head   |
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
	- Iterator:TotalDropTokens[MAX_PLAYERS]<DROP_TOKENS_MAX>
 */

#if defined _INC_DROP_TOKENS_HEAD
	#endinput
#endif
#define _INC_DROP_TOKENS_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define DROP_TOKENS_MAX					(2)		// Max number of tokens dropped
#define DROP_TOKENS_TIMER				(10)	// Timer until token is removed in seconds

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

new
	Iterator:TotalDropTokens[MAX_PLAYERS]<DROP_TOKENS_MAX>;