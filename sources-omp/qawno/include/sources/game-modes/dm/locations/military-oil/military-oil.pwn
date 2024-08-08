/*

	About: DM Military oil location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		DM_MilitaryOil_CreateElements(session_id)
Enums:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DM_LOC_MILITARYOIL
	#endinput
#endif

#define _INC_DM_LOC_MILITARYOIL

/*

	* Functions *

*/

stock DM_MilitaryOil_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_DM, session_id, Mode_GetBasicVirtualWorld(MODE_DM, session_id));
	Mode_SetInterior(MODE_DM, session_id, 0);

	// Погода
	Mode_SetWeather(MODE_DM, session_id, 0);

	// Время
	DM_SetTimer(session_id, 7, 0);

	// Зона локации
	DM_SetExitZonePos(session_id, 2490.0, 2612.0, 2782.0, 2884.0);

	// Жетоны
	DM_SetTokens(session_id, true);

	// Места спавна
	DM_SetSpawnPos(session_id, 0, 2553.0779, 2828.5454, 27.8203);
	DM_SetSpawnPos(session_id, 1, 2628.4141, 2767.3938, 23.8222);
	DM_SetSpawnPos(session_id, 2, 2613.6714, 2707.3394, 25.8222);
	DM_SetSpawnPos(session_id, 3, 2518.4944, 2721.7681, 10.8203);
	DM_SetSpawnPos(session_id, 4, 2567.7339, 2694.8098, 22.9507);
	DM_SetSpawnPos(session_id, 5, 2657.6345, 2824.5725, 36.3222);
	return 1;
}