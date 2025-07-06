/*
 * |>========================<|
 * |   About: Mode TDM head   |
 * |   Author: Foxze          |
 * |>========================<|
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
	- Iterator:TDM_ActiveTeams[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>
	- Iterator:TDM_ActiveTeamsScore[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>
	- Iterator:TDM_SpecSquadPlayerid[MAX_PLAYERS]<MAX_PLAYERS>
 */

#if defined _INC_TDM_HEAD
	#endinput
#endif
#define _INC_TDM_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Core
#define TDM_MAX_PLAYERS				(100)	// Max players in session
#define TDM_MAX_VEHICLES			(100)	// Max transport

// Options
#define TDM_LOC_END_TIMER			(40)	// Timer after the end of the game
#define TDM_SHOP_MAX_ITEMS			(12)	// Max items in store
#define TDM_MAX_TEAM_BASES			(4)		// Max number of bases
#define TDM_MAX_CAPTURE_POINTS		(7)		// Max number of points
#define TDM_MAX_SCORE_CAPTURE		20		// Max point capture count
#define TDM_MAX_SCORE_FAST_POINT	12		// Max time point capture count

#define TDM_MAX_SCORE_COMPUTER		(10)	// Max computer capture count
#define TDM_MAX_COMPUTER_TIMER		(40)	// Timer after hacking computer
#define TDM_MAX_COMPUTERS			(3)		// Max number of computers

#define TDM_MAX_SHOP_BODY			(3)		// Max quantity of purchased clothes
#define TDM_MAX_QUESTS				(31)	// Max number of quests
#define TDM_MAX_QUESTS_PROGRESS		(3)		// Max number of quests in progress
#define TDM_MAX_CHANGE_MAP_LIST		(3)		// Max locations to choose from after match ends
#define TDM_PLAYER_TIMER_RESPAWN	(25)	// Player respawn timer after death

// Team
#define TDM_MAX_TEAMS	(5)

// Modes
#define TDM_MAX_MODES	(4)

// Squad
#define TDM_MAX_SQUADS				(20)	// Max squads
#define TDM_MAX_SQUAD_PLAYERS		(5)		// Max players in squad

// Airs
#define TDM_MAX_AIR_WEAPON			(50)	// Max number of aircraft with ammo
#define TDM_MAX_AIR_BOMB			(50)	// Max number of planes with bombs
#define TDM_MAX_AIR					(50)	// Max number of simple planes
#define TDM_MAX_PLAYER_AIR			(50)	// Max number of simple planes for a player

// Airdrop weapon
#define TDM_AIR_MAX_OBJECT_WEAPON				(9)			// Max number of objects per container
#define TDM_AIR_MAX_WEAPON						(4)			// Max weapons in container
#define TDM_AIR_TIMER_WEAPON					(30)		// Timer before explosion
#define TDM_AIR_COLOR_NAME_WEAPON				"{57BEDB}"	// Color on container

// Top killers
#define TDM_MAX_TOP_KILLERS			(10)

// Others
#define TDM_MAX_LENGTH_TEAM_NAME	(16)

#define TDM_MAX_LENGTH_MODE_NAME	(50)
#define TDM_MAX_LENGTH_MODE_INFO	(800)

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	TDM_GAME_STATUS_GAME = 1,
	TDM_GAME_STATUS_RESULT,
	TDM_GAME_STATUS_TOP_KILLS,
	TDM_GAME_STATUS_SELECT
}

enum {
	TDM_GAME_MODE_CAPTURE = 0,
	TDM_GAME_MODE_CAPTURE_FLAG,
	TDM_GAME_MODE_SECRET_DATA,
	TDM_GAME_MODE_BATTLE_KILLS
}

enum {
	TDM_TEAM_NONE = 0,
	TDM_TEAM_MILITARY,
	TDM_TEAM_REBEL,
	TDM_TEAM_BANDIT,
	TDM_TEAM_MARAUDER
}

enum {
	TDM_AIR_WEAPON = 1,
	TDM_AIR_MEDICAMENT,
	TDM_AIR_AMMO,
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

new
	Iterator:TDM_ActiveTeams[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>,
	Iterator:TDM_ActiveTeamsScore[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>;

new
	Iterator:TDM_SpecSquadPlayerid[MAX_PLAYERS]<MAX_PLAYERS>;