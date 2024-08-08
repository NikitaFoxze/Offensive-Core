/*

	About: DM Golf location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_Golf_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_GOLF
	#endinput
#endif
#define _INC_DM_LOC_GOLF

/*

	* Functions *

*/

stock DM_Golf_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 0);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 9, 0);

	// Зона локации
	DM_SetExitZonePos(session_id, 1116.0, 2719.0, 1459.0, 2864.0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, 1146.8511, 2840.7112, 10.8203);
	DM_SetSpawnPos(session_id, 1, 1158.8961, 2743.5889, 10.8281);
	DM_SetSpawnPos(session_id, 2, 1217.7704, 2770.1914, 10.8203);
	DM_SetSpawnPos(session_id, 3, 1278.6965, 2835.4556, 10.8125);
	DM_SetSpawnPos(session_id, 4, 1396.3550, 2743.9644, 10.8203);
	DM_SetSpawnPos(session_id, 5, 1350.1139, 2836.5676, 10.8203);
	return 1;
}