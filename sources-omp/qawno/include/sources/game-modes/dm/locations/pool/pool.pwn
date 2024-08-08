/*

	About: DM Pool location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_Pool_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_POOL
	#endinput
#endif
#define _INC_DM_LOC_POOL

/*

	* Functions *

*/

stock DM_Pool_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 0);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 7, 0);

	// Зона локации
	DM_SetExitZonePos(session_id, 1690.0, 2716.0, 1923.0, 2888.0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, 1769.1963, 2771.4551, 10.8359);
	DM_SetSpawnPos(session_id, 1, 1767.9481, 2856.0032, 10.8283);
	DM_SetSpawnPos(session_id, 2, 1823.2061, 2821.1333, 10.8296);
	DM_SetSpawnPos(session_id, 3, 1808.4742, 2736.3042, 10.8359);
	DM_SetSpawnPos(session_id, 4, 1716.7808, 2747.4055, 10.8359);
	DM_SetSpawnPos(session_id, 5, 1716.1667, 2874.4885, 10.8359);
	return 1;
}