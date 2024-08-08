/*

	About: DM Home wheels location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_HomeWheels_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_HOMEONWHEELS
	#endinput
#endif
#define _INC_DM_LOC_HOMEONWHEELS

/*

	* Functions *

*/

stock DM_HomeWheels_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 0);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 7, 0);

	// Зона локации
	DM_SetExitZonePos(session_id, -52.0, 1316.0, 61.0, 1420.0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, -21.5425, 1391.7113, 9.1719);
	DM_SetSpawnPos(session_id, 1, 8.0184, 1385.8538, 9.1781);
	DM_SetSpawnPos(session_id, 2, 32.4650, 1358.4178, 9.1719);
	DM_SetSpawnPos(session_id, 3, -3.1167, 1337.3088, 9.1719);
	DM_SetSpawnPos(session_id, 4, -25.1340, 1354.6593, 9.1719);
	DM_SetSpawnPos(session_id, 5, -4.5781, 1377.3354, 9.1719);
	return 1;
}