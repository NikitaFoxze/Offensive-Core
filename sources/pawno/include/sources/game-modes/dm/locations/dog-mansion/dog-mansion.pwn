/*

	About: DM Dog mansion location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_DogMansion_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_DOGMANSION
	#endinput
#endif
#define _INC_DM_LOC_DOGMANSION

/*

	* Functions *

*/

stock DM_DogMansion_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 5);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 8, 0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, 1263.0790, -784.2686, 1091.9063);
	DM_SetSpawnPos(session_id, 1, 1274.0310, -808.0443, 1089.9375);
	DM_SetSpawnPos(session_id, 2, 1291.5470, -814.0375, 1089.9375);
	DM_SetSpawnPos(session_id, 3, 1279.9937, -810.4382, 1085.6328);
	DM_SetSpawnPos(session_id, 4, 1292.7234, -825.9493, 1085.6328);
	DM_SetSpawnPos(session_id, 5, 1232.8920, -836.4986, 1084.0078);
	return 1;
}