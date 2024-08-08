/*

	About: DM Desert location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_Desert_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_DESERT
	#endinput
#endif
#define _INC_DM_LOC_DESERT

/*

	* Functions *

*/

stock DM_Desert_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 0);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 8, 0);

	// Зона локации
	DM_SetExitZonePos(session_id, 20.0, 2344.0, 380.0, 2475.0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, 277.6578, 2424.0000, 16.4825);
	DM_SetSpawnPos(session_id, 1, 222.6676, 2461.3718, 16.4844);
	DM_SetSpawnPos(session_id, 2, 162.4950, 2452.5112, 16.4759);
	DM_SetSpawnPos(session_id, 3, 104.6303, 2407.0576, 17.1137);
	DM_SetSpawnPos(session_id, 4, 186.3553, 2390.8767, 16.4844);
	DM_SetSpawnPos(session_id, 5, 228.7337, 2385.5715, 16.4844);
	return 1;
}