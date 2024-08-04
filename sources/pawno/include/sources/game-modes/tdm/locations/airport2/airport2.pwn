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
	TDM_SetSpawnTopBot(session_id, 0, 196.32857, 2475.43604, 16.45367, 6.8112);
	TDM_SetSpawnTopBot(session_id, 1, 195.54019, 2474.86890, 16.45367, 6.8112);
	TDM_SetSpawnTopBot(session_id, 2, 197.45180, 2474.30249, 16.45367, 6.8112);
	TDM_SetSpawnTopBot(session_id, 3, 194.31660, 2473.62231, 16.45367, 6.8112);
	TDM_SetSpawnTopBot(session_id, 4, 198.91211, 2472.33813, 16.45367, 6.8112);

	// Камера в конце матча
	TDM_SetCameraEndPos(session_id, 
		-1230.385253, -209.638626, 21.693603, 
		-1226.051269, -207.511749, 20.392353);
	TDM_SetCameraEndLookAt(session_id, 
		-1269.864868, -229.015655, 33.548595, 
		-1265.530883, -226.888778, 32.247344);
	TDM_SetCameraEndPosTwo(session_id, 
		195.996307, 2480.556152, 16.584621, 
		196.222152, 2475.561523, 16.542434);

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