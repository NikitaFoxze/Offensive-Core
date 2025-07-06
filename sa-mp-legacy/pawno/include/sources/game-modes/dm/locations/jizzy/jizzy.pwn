/*

	About: DM Jizzy location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_Jizzy_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_JIZZY
	#endinput
#endif
#define _INC_DM_LOC_JIZZY

/*

	* Functions *

*/

stock DM_Jizzy_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 3);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 8, 0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, -2636.3745, 1406.5156, 906.4609);
	DM_SetSpawnPos(session_id, 1, -2666.7595, 1427.5782, 906.4609);
	DM_SetSpawnPos(session_id, 2, -2641.9963, 1420.6669, 906.4609);
	DM_SetSpawnPos(session_id, 3, -2667.7627, 1394.7880, 912.4114);
	DM_SetSpawnPos(session_id, 4, -2647.2834, 1393.7124, 918.3582);
	DM_SetSpawnPos(session_id, 5, -2659.7905, 1428.0496, 912.4114);
	return 1;
}