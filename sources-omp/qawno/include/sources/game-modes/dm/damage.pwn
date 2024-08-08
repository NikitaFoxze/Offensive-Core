/*

	About: DM damage system
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

#if defined _INC_DM_DAMAGE_SYSTEM
	#endinput
#endif
#define _INC_DM_DAMAGE_SYSTEM

/*

	* Callbacks *

*/

/*
	OnPlayerDamage
*/

stock DM_OnPlayerDamage(playerid, &Float:amount, issuerid, weaponid, bodypart)
{
	if(issuerid != INVALID_PLAYER_ID)
		ShowPlayerBeDamage(playerid);

	if(issuerid != INVALID_PLAYER_ID) {
		PlayerPlaySoundEx(issuerid, 17802, 0.0, 0.0, 0.0);
		Damage_SetPlayerBody(playerid, issuerid, bodypart);

		new
			session_id = Mode_GetPlayerSession(issuerid);

		if(DM_GetModeLocation(Mode_GetLocation(MODE_DM, session_id)) == DM_MODE_WEAPON_SNIPER) {
			if(weaponid == 34) 
				amount = 0.0;

			return 1;
		}
	}

	//amount = amount;
	return 1;
}