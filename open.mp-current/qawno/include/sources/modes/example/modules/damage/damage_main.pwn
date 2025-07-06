/*
 * |>==============================<|
 * |   About: Example damage main   |
 * |   Author: Foxze                |
 * |>==============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerDamage(playerid, &Float:amount, issuerid, weaponid, bodypart)
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

#if defined _INC_EXAMPLE_DAMAGE_MAIN
	#endinput
#endif
#define _INC_EXAMPLE_DAMAGE_MAIN

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

stock Example_OnPlayerDamage(playerid, issuerid, WEAPON:weaponid, Float:amount, bodypart)
{
	#pragma unused weaponid, amount

	if (issuerid != INVALID_PLAYER_ID) {
		SetPlayerLastDamage(playerid);
		PlayerPlaySoundEx(issuerid, 17802, 0.0, 0.0, 0.0);
		SetPlayerDamageBody(playerid, issuerid, bodypart);
	}
	return 1;
}