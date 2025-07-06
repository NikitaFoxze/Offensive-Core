/*

	About: Room damage system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnPlayerDamage(playerid, &Float:amount, issuerid)
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

#if defined _INC_ROOM_DAMAGE_SYSTEM
	#endinput
#endif
#define _INC_ROOM_DAMAGE_SYSTEM

/*

	* Callbacks *

*/

/*
	OnPlayerDamage
*/

stock Room_OnPlayerDamage(playerid, &Float:amount, issuerid)
{
	#pragma unused amount

	if(issuerid != INVALID_PLAYER_ID && GetPlayerTeamEx(playerid) == GetPlayerTeamEx(issuerid)) return 1;

	if(issuerid != INVALID_PLAYER_ID)
		ShowPlayerBeDamage(playerid);

	if(issuerid != INVALID_PLAYER_ID) 
		PlayerPlaySoundEx(issuerid, 17802, 0.0, 0.0, 0.0);

	return 1;
}