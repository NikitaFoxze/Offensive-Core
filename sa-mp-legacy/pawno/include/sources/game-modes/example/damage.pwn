/*

	About: Example damage system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnPlayerDamage(playerid, &Float:amount, issuerid, weaponid, bodypart)
	Stock:
		-
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_EXAMPLE_DAMAGE_SYSTEM
	#endinput
#endif
#define _INC_EXAMPLE_DAMAGE_SYSTEM

/*

	* Callbacks *

*/

/*
	OnPlayerDamage
*/

stock Example_OnPlayerDamage(playerid, issuerid, weaponid, Float:amount, bodypart)
{
	#pragma unused weaponid, amount

	if(issuerid != INVALID_PLAYER_ID)
		ShowPlayerBeDamage(playerid);

	if(issuerid != INVALID_PLAYER_ID) {
		PlayerPlaySoundEx(issuerid, 17802, 0.0, 0.0, 0.0);
		Damage_SetPlayerBody(playerid, issuerid, bodypart);
	}
	return 1;
}