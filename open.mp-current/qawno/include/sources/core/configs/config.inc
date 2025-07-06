/*
 * |>========================<|
 * |   About: Config server   |
 * |   Author: Foxze          |
 * |>========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
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

#if defined _INC_CONFIG_SERVER
	#endinput
#endif
#define _INC_CONFIG_SERVER

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Players
#undef MAX_PLAYERS
#define MAX_PLAYERS (300)

// Vehicles
#undef MAX_VEHICLES
#define MAX_VEHICLES (2000)

// Server names
#define SERVER_VERSION				"2.0"
#define SERVER_CLIENT				"omp"

#define SERVER_NAME					"Offensive"	
#define SERVER_NAME_CORE			"Offensive-Core"
#define SERVER_LANGUAGES			"RU"
#define SERVER_MODES				"TDM DM PvP"
#define SERVER_MAP					"San Andreas"
#define SERVER_SITE					"open.mp"
#define SERVER_VK					"vk.com/vk"

/*
 * |>----------<|
 * |   Player   |
 * |>----------<|
 */

// Player Start Bonus
#define PLAYER_INITIAL_RANK			(1)			// Player initial rank
#define PLAYER_INITIAL_MONEY		(300)		// Player initial money
#define PLAYER_INITIAL_BANNER		(1)			// Player initial banner

// Referal
#define PLAYER_REFERAL_EXP			(5000)		// Reward referal exp
#define PLAYER_REFERAL_MONEY		(30000)		// Reward referal money

// Damage indicator
#define MAX_PLAYER_INDICATOR_DAMAGE		(20)	// Max number of hit indicators
#define TIMER_PLAYER_INDICATOR_DAMAGE	(2)		// Hit indicator decay timer in seconds

// Others data
#define MAX_PLAYERS_IN_BLACKLIST	(30)		// Max number of people in blacklist
#define MAX_PLAYER_DAILY_DAYS		(10)		// Max days to receive daily bonus
#define MAX_PLAYER_ATTACH_ITEM		(10)		// Max number of items equipped on the player
#define TIMER_PLAYER_SPAWNKILL		(3)			// SpawnKill timer for player
#define TIMER_PLAYER_RESPAWN		(3)			// Player respawn timer after death
#define LIMIT_RANK_PROMOCODE		(10)		// Promocode limit rank

/*
 * |>----------<|
 * |   Server   |
 * |>----------<|
 */

// Report
#define MAX_REPORTS					(5000)
#define LIMIT_MINUTES_SEND_REPORT	(60)

#define MAX_WEAPON_SLOTS			(WEAPON_SLOT:13)
#define MAX_COUNT_RANDOM_KEYS		(3)
#define MAX_COUNT_RANDOM_COLOR		(6)

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>------------------<|
 * |   OnGameModeInit   |
 * |>------------------<|
 */

public OnGameModeInit()
{
	// long_call_time 0 (crashdetect)
	DisableCrashDetectLongCall();

	// Server parameters
	SendRconCommand("name "SERVER_NAME_CORE"");
	SendRconCommand("website "SERVER_SITE"");
	SendRconCommand("language "SERVER_LANGUAGES"");
	SendRconCommand("game.map "SERVER_MAP"");
	SetGameModeText(""SERVER_MODES"");

	// Game parameters
	ManualVehicleEngineAndLights();					// Remove automatic engine start in transport
	DisableInteriorEnterExits();					// Removes yellow arrows
	ShowNameTags(true);								// Shows tags with player names
	AllowInteriorWeapons(true);						// Allows the use of weapons in interiors
	EnableStuntBonusForAll(false);					// Remove bonuses for tricks
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	SetNameTagDrawDistance(30.0);
	LimitPlayerMarkerRadius(1000.0);
	EnableVehicleFriendlyFire();

	#if defined Config_OnGameModeInit
		return Config_OnGameModeInit();
	#else
		return 1;
	#endif
}

/*
 * |>-------<|
 * |   ALS   |
 * |>-------<|
 */

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Config_OnGameModeInit
#if defined Config_OnGameModeInit
	forward Config_OnGameModeInit();
#endif