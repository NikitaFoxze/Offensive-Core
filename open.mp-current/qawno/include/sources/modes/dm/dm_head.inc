/*
 * |>=======================<|
 * |   About: Mode DM head   |
 * |   Author: Foxze         |
 * |>=======================<|
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

#if defined _INC_DM_HEAD
	#endinput
#endif
#define _INC_DM_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Core
#define DM_MAX_PLAYERS				(10)	// Max players

// Quests
#define DM_MAX_QUESTS				(15)	// Max number of quests
#define DM_MAX_QUESTS_PROGRESS		(3)		// Max number of quests in progress
#define DM_PLAYER_TIMER_RESPAWN		(15)	// Player respawn timer after death

// Game modes
#define DM_MAX_MODES				(3)		// Number of modes

// Status game
#define DM_LOC_GAME_STATUS_GAME		(1)		// Game

// Team
#define DM_TEAM_NONE				(0)		// Neutral

// Others
#define DM_MAX_LENGTH_MODE_NAME		(50)
#define DM_MAX_LENGTH_MODE_INFO		(300)

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	DM_GAME_MODE_NORMAL = 0,
	DM_GAME_MODE_DEAGLE,
	DM_GAME_MODE_SNIPER
}