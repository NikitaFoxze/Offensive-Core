/*

	About: Drop-weapons header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		-
Enums:
	-
Global var:
	PlayerDropWeapons
------------------------------------------------------------------------------*/

#if defined _INC_DROP_WEAPONS_HEADER
	#endinput
#endif
#define _INC_DROP_WEAPONS_HEADER

/*

	* Defines *

*/

#define DROP_WEAPONS_MAX				(5)		// Макс. кол-во слотов оружия в дропе
#define DROP_WEAPON_STRING_MAX_LENGTH	(70)

/*

	* Vars *

*/

new
	Iterator:PlayerDropWeapons[MAX_PLAYERS]<DROP_WEAPONS_MAX>;
