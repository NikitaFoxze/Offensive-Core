/*

	About: Example Desert location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Example_Desert_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_EXAMPLE_LOC_DESERT
	#endinput
#endif
#define _INC_EXAMPLE_LOC_DESERT

/*

	* Functions *

*/

stock Example_Desert_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, Mode_GetBasicInterior(MODE_DM, session_id));

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Жетоны
	Example_SetTokens(session_id, true);

	// Спавн
	Example_SetSpawnPos(session_id, 10.0, 10.0, 15.0);
	return 1;
}