/*

	About: DM Palace smoke location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_PalaceSmoke_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_PALACESMOKE
	#endinput
#endif
#define _INC_DM_LOC_PALACESMOKE

/*

	* Functions *

*/

stock DM_PalaceSmoke_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 2);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 7, 0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, 2572.2146, -1284.3903, 1065.3672);
	DM_SetSpawnPos(session_id, 1, 2558.0400, -1299.0900, 1060.9844);
	DM_SetSpawnPos(session_id, 2, 2555.0859, -1283.3650, 1054.6470);
	DM_SetSpawnPos(session_id, 3, 2567.8992, -1302.5155, 1054.6406);
	DM_SetSpawnPos(session_id, 4, 2541.6260, -1288.6812, 1054.6406);
	DM_SetSpawnPos(session_id, 5, 2530.9465, -1306.0892, 1054.6406);
	return 1;
}