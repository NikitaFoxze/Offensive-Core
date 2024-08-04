/*

	About: DM Atrium location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_Atrium_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_ATRIUM
	#endinput
#endif
#define _INC_DM_LOC_ATRIUM

/*

	* Functions *

*/

stock DM_Atrium_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 18);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 8, 0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, 1702.7311, -1650.7675, 20.2197);
	DM_SetSpawnPos(session_id, 1, 1721.4229, -1671.3993, 20.2241);
	DM_SetSpawnPos(session_id, 2, 1732.7911, -1644.6544, 20.2290);
	DM_SetSpawnPos(session_id, 3, 1710.0437, -1667.6257, 23.7021);
	DM_SetSpawnPos(session_id, 4, 1709.6578, -1659.3623, 27.1953);
	DM_SetSpawnPos(session_id, 5, 1733.7649, -1654.5363, 27.2317);
	return 1;
}