/*

	About: TDM Zone 51 location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		TDM_Zone51_CreateElements(session_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_LOC_ZONE51
	#endinput
#endif
#define _INC_TDM_LOC_ZONE51

/*

	* Functions *

*/

stock TDM_Zone51_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_TDM, session_id, Mode_GetBasicVirtualWorld(MODE_TDM, session_id));
	Mode_SetInterior(MODE_TDM, session_id, Mode_GetBasicInterior(MODE_TDM, session_id));
	
	// Погода
	Mode_SetWeather(MODE_TDM, session_id, 0);

	// Команды
	TDM_AddTeam(session_id, TDM_TEAM_MILITARY, true);
	TDM_AddTeam(session_id, TDM_TEAM_REBEL, true);

	// Счёт
	TDM_SetTeamChet(session_id, TDM_TEAM_MILITARY, 0, 100);
	TDM_SetTeamChet(session_id, TDM_TEAM_REBEL, 0, 100);

	// Время
	TDM_SetTimer(session_id, 10, 0);

	// Лучшие игроки
	TDM_SetSpawnTopBot(session_id, 0, 213.4783, 1905.8370, 17.6406, 356.2400);
	TDM_SetSpawnTopBot(session_id, 1, 216.2217, 1904.3049, 17.6406, 356.2400);
	TDM_SetSpawnTopBot(session_id, 2, 210.2355, 1904.0776, 17.6406, 356.2400);
	TDM_SetSpawnTopBot(session_id, 3, 217.5923, 1902.1473, 17.6406, 359.0601);
	TDM_SetSpawnTopBot(session_id, 4, 209.7822, 1902.2002, 17.6406, 359.0601);

	// Камера в конце матча
	TDM_SetCameraEndPos(session_id, 
		206.201202, 1915.101196, 28.017675, 
		206.341293, 1919.903076, 26.631195);
	TDM_SetCameraEndLookAt(session_id, 
		204.414855, 1853.872924, 45.69752, 
		204.554946, 1858.674804, 44.311050);
	TDM_SetCameraEndPosTwo(session_id, 
		214.922393, 1922.947875, 18.599996, 
		214.827713, 1917.948730, 18.596090);

	// Зона локации
	TDM_SetExitZonePos(session_id, 99.0, 1798.0, 329.0, 1975.0);

	// Базы команд
	TDM_CreateBaseTeam(session_id, TDM_TEAM_MILITARY, 246.0, 1814.5, 304.0, 1973.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_MILITARY, 254.512771, 1852.207397, 30.965898, 257.697052, 1855.711669, 29.3594854);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 0, 282.8874, 1882.6312, 17.6406);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 1, 258.3599, 1832.5182, 17.6406);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 2, 274.0488, 1949.5095, 17.6406);

	TDM_CreateBaseTeam(session_id, TDM_TEAM_REBEL, 106.0, 1817.5, 155.0, 1935.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_REBEL, 175.997177, 1910.830810, 32.754978, 172.778961, 1907.411254, 31.037467);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 0, 161.9177, 1834.9467, 17.6481);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 1, 151.2212, 1884.1403, 18.1794);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 2, 180.1040, 1930.2965, 17.987);

	// Магазины
	TDM_CreateShop(session_id, TDM_TEAM_MILITARY, 284.7037, 1868.9059, 17.6481);
	TDM_CreateShop(session_id, TDM_TEAM_REBEL, 145.7049, 1875.4513, 17.8359);
	return 1;
}
