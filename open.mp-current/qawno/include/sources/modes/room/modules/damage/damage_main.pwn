/*
 * |>===========================<|
 * |   About: Room damage main   |
 * |   Author: Foxze             |
 * |>===========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerDamage(playerid, &Float:amount, issuerid)
 * Stock:
	- (None)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_ROOM_DAMAGE_MAIN
	#endinput
#endif
#define _INC_ROOM_DAMAGE_MAIN

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>------------------<|
 * |   OnPlayerDamage   |
 * |>------------------<|
 */

stock Room_OnPlayerDamage(playerid, &Float:amount, issuerid)
{
	#pragma unused amount

	if (issuerid != INVALID_PLAYER_ID && GetPlayerTeamEx(playerid) == GetPlayerTeamEx(issuerid)) {
		return 1;
	}

	if (issuerid != INVALID_PLAYER_ID) {
		SetPlayerLastDamage(playerid);
		PlayerPlaySoundEx(issuerid, 17802, 0.0, 0.0, 0.0);
	}
	return 1;
}