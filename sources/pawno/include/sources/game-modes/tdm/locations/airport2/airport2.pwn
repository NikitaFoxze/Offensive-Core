/*

	About: TDM Airport 2 location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		TDM_Airport2_CreateElements(session_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_LOC_AIRPORT2
	#endinput
#endif
#define _INC_TDM_LOC_AIRPORT2

/*

	* Functions *

*/

stock TDM_Airport2_CreateElements(session_id)
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
	TDM_SetTeamChet(session_id, TDM_TEAM_MILITARY, 0, 50);
	TDM_SetTeamChet(session_id, TDM_TEAM_REBEL, 0, 50);

	// Время
	TDM_SetTimer(session_id, 10, 0);

	// Лучшие игроки
	TDM_SetSpawnTopBot(session_id, 0, -1168.3767, -274.9376, 14.1484, 68.5738);
	TDM_SetSpawnTopBot(session_id, 1, -1165.9050, -273.0405, 14.1484, 96.1473);
	TDM_SetSpawnTopBot(session_id, 2, -1163.8888, -277.0248, 14.1484, 103.0407);
	TDM_SetSpawnTopBot(session_id, 3, -1162.2628, -270.9858, 14.1440, 94.2673);
	TDM_SetSpawnTopBot(session_id, 4, -1160.0897, -279.4976, 14.1484, 90.8206);

	// Камера в конце матча
	TDM_SetCameraEndPos(session_id, 
		-1230.385253, -209.638626, 21.693603, 
		-1226.051269, -207.511749, 20.392353);
	TDM_SetCameraEndLookAt(session_id, 
		-1269.864868, -229.015655, 33.548595, 
		-1265.530883, -226.888778, 32.247344);
	TDM_SetCameraEndPosTwo(session_id, 
		-1184.558715, -276.270446, 15.463514, 
		-1179.560058, -276.264129, 15.350243);

	// Зона локации
	TDM_SetExitZonePos(session_id, -1453.0, -379.0, -1055.0, -56.0);

	// Базы команд
	TDM_CreateBaseTeam(session_id, TDM_TEAM_MILITARY, -1310.0, -215.5, -1201.0, -132.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_MILITARY, -1308.366333, -210.777572, 25.659154, -1306.669677, -206.259841, 24.350864);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 0, -1297.0111, -179.2232, 14.1484);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 1, -1271.9191, -118.0250, 14.1440);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 2, -1348.5477, -212.5527, 14.8883);

	TDM_CreateBaseTeam(session_id, TDM_TEAM_REBEL, -1246.0, -328.5, -1137.0, -245.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_REBEL, -1238.748168, -275.685363, 23.13533, -1235.348266, -279.197204, 22.082763);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 0, -1254.6067, -326.8659, 14.1484);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 1, -1208.6014, -298.5283, 14.1484);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 2, -1156.4420, -303.2933, 14.1484);

	// Магазины
	TDM_CreateShop(session_id, TDM_TEAM_MILITARY, -1300.2150, -161.5442, 14.1484);
	TDM_CreateShop(session_id, TDM_TEAM_REBEL, -1203.5620, -309.3369, 14.1484);
	return 1;
}
