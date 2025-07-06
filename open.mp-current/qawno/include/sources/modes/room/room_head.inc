/*
 * |>=========================<|
 * |   About: Mode Room head   |
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
	- Iterator:Room_ActiveTeams[MAX_PLAYERS]<ROOM_MAX_TEAMS>
	- Iterator:Room_ActiveTeamsScore[MAX_PLAYERS]<ROOM_MAX_TEAMS>
 */

#if defined _INC_ROOM_HEAD
	#endinput
#endif
#define _INC_ROOM_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Core
#define ROOM_MAX_PLAYERS			(10)	// Max players in room
#define ROOM_LOBBY_TIMER			(10)	// Timer before match
#define ROOM_PLAYER_TIMER_RESPAWN	(15)	// Player respawn timer after death
#define ROOM_MAX_SCORE_CAPTURE		10		// Max point capture count
#define ROOM_MAX_SCORE_COMPUTER		(10)	// Max computer capture count
#define ROOM_MAX_COMPUTER_TIMER		(40)	// Timer after hacking computer

// Modes
#define ROOM_MAX_MODES				(3)		// Max modes

// Teams
#define ROOM_MAX_TEAMS				(3)		// Max commands

// Top killers
#define ROOM_MAX_TOP_KILLERS		(5)

// Others
#define ROOM_MAX_NAME_LENGTH		(11)
#define ROOM_MAX_PASSWORD_LENGTH	(11)
#define ROOM_MAX_TEAM_NAME_LENGTH	(16)

#define ROOM_MAX_LENGTH_MODE_NAME	(50)
#define ROOM_MAX_LENGTH_MODE_INFO	(800)

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	ROOM_GAME_MODE_BATTLE = 0,
	ROOM_GAME_MODE_CAPTURE,
	ROOM_GAME_MODE_DATA
}

enum {
	ROOM_STATUS_NONE = 0,
	ROOM_STATUS_LOBBY,
	ROOM_STATUS_GAME,
	ROOM_STATUS_END
}

enum {
	ROOM_TEAM_NONE = 0,
	ROOM_TEAM_ALPHA,
	ROOM_TEAM_BRAVO
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

new
	Iterator:Room_ActiveTeams[MAX_PLAYERS]<ROOM_MAX_TEAMS>,
	Iterator:Room_ActiveTeamsScore[MAX_PLAYERS]<ROOM_MAX_TEAMS>;