/*

	About: DM Warehouse location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_Warehouse_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_WAREHOUSE
	#endinput
#endif
#define _INC_DM_LOC_WAREHOUSE

/*

	* Functions *

*/

stock DM_Warehouse_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 0);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 9, 0);

	// Зона локации
	DM_SetExitZonePos(session_id, 2097.0, -2361.0, 2285.0, -2174.0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, 2220.3625, -2206.7083, 13.5469);
	DM_SetSpawnPos(session_id, 1, 2221.5032, -2257.4958, 13.5547);
	DM_SetSpawnPos(session_id, 2, 2174.5510, -2250.0488, 13.3034);
	DM_SetSpawnPos(session_id, 3, 2240.1809, -2261.1460, 14.7647);
	DM_SetSpawnPos(session_id, 4, 2140.3213, -2286.0417, 14.7757);
	DM_SetSpawnPos(session_id, 5, 2134.5515, -2303.9446, 14.6987);
	return 1;
}