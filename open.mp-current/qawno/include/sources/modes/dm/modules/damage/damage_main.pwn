/*
 * |>=========================<|
 * |   About: DM damage main   |
 * |   Author: Foxze           |
 * |>=========================<|
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

#if defined _INC_DM_DAMAGE_MAIN
	#endinput
#endif
#define _INC_DM_DAMAGE_MAIN

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

stock DM_OnPlayerDamage(playerid, &Float:amount, issuerid, WEAPON:weaponid, bodypart)
{
	if (issuerid != INVALID_PLAYER_ID) {
		SetPlayerLastDamage(playerid);
		PlayerPlaySoundEx(issuerid, 17802, 0.0, 0.0, 0.0);
		SetPlayerDamageBody(playerid, issuerid, bodypart);

		new
			sessionid = Mode_GetPlayerSession(issuerid);

		if (Mode_GetSessionGameMode(MODE_DM, sessionid) == DM_GAME_MODE_SNIPER) {
			if (weaponid == WEAPON_SNIPER) {
				amount = 0.0;
			}
			return 1;
		}
	}
	return 1;
}