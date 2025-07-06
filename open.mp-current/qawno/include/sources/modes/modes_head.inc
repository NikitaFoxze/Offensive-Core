/*
 * |>=====================<|
 * |   About: Modes head   |
 * |   Author: Foxze       |
 * |>=====================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- bool:IsValidMode(modeid)
	- bool:IsValidSession(modeid, sessionid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
	- Iterator:Modes[GMS_MAX_MODES]
	- Iterator:Sessions[GMS_MAX_MODES]<GMS_MAX_SESSIONS>
	- Iterator:Locations[GMS_MAX_MODES]<GMS_MAX_LOCATIONS>
	- Iterator:GameModes[GMS_MAX_MODES]<GMS_MAX_GAME_MODES>
 */

#if defined _INC_MODES_HEAD
	#endinput
#endif
#define _INC_MODES_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Core
#define GMS_MAX_MODES			(5)			// Max number of game modes
#define GMS_MAX_SESSIONS		MAX_PLAYERS	// Max number of sessions in modes
#define GMS_MAX_SESSION_SLOTS	MAX_PLAYERS	// Max number of players in modes
#define GMS_MAX_LOCATIONS		(30)		// Max number of locations in modes
#define GMS_MAX_GAME_MODES		(10)		// MAx number of game-modes in modes

// Additional Elements (AE)
#define GMS_MAX_AE_VALUES				(30)

#define	GMS_MAX_PLAYER_AE_3DTEXTS		(30)
#define GMS_MAX_PLAYER_AE_OBJECTS		(30)

// Location
#define GMS_LOCATION_UNKNOWN			(-1)

// Others
#define GMS_MAX_LENGTH_GAME_MODE_NAME	(50)

#define GMS_MAX_LENGTH_MODE_SHORT_NAME	(30)
#define GMS_MAX_LENGTH_MODE_FULL_NAME	(50)

#define GMS_MAX_LENGTH_MODE_NAME		(50)
#define GMS_MAX_LENGTH_MODE_INFO		(300)

#define GMS_MAX_LENGTH_LOC_NAME			(50)
#define GMS_MAX_LENGTH_LOC_INFO			(500)

#define GMS_MAX_LENGTH_GAME_MODE_NAME	(50)
#define GMS_MAX_LENGTH_GAME_MODE_INFO	(500)

#define GMS_MAX_LEN_AE_3DTEXT_NAME		(150)

#define m_for(%0,%1,%2) \
	if (IsValidMode(%0) && IsValidSession(%0, %1)) \
	for \
	(new pmf = 0, %2 = Mode_GetSessionSlot(%0, %1, 0); \
	pmf < Mode_GetSessionPlayers(%0, %1) && %2 != INVALID_PLAYER_ID; \
	pmf++, %2 = Mode_GetSessionSlot(%0, %1, pmf))

#define m_safe_for(%0,%1,%2) \
	new f_players = Mode_GetSessionPlayers(%0, %1); \
	new f_playerid[MAX_PLAYERS]; \
	m_for(%0,%1,p_s) f_playerid[pmf] = p_s; \
	for \
	(new ff_players = 0, %2 = f_playerid[0]; \
	ff_players < f_players && %2 != INVALID_PLAYER_ID; \
	ff_players++, %2 = f_playerid[ff_players])

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	MODE_NONE = 0,
	MODE_ROOM,
	MODE_TDM,
	MODE_DM,
	MODE_EXAMPLE
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

new
	Iterator:Modes<GMS_MAX_MODES>,
	Iterator:Sessions[GMS_MAX_MODES]<GMS_MAX_SESSIONS>,
	Iterator:Locations[GMS_MAX_MODES]<GMS_MAX_LOCATIONS>,
	Iterator:GameModes[GMS_MAX_MODES]<GMS_MAX_GAME_MODES>;

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock bool:IsValidMode(modeid)
{
	if (modeid != -1) {
		return true;
	}
	return false;
}

stock bool:IsValidSession(modeid, sessionid)
{
	if (IsValidMode(modeid)) {
		if (Iter_Contains(Sessions[modeid], sessionid)) {
			return true;
		}
	}
	return false;
}