/*
 * |>=================================<|
 * |   About: TDM Airport 2 location   |
 * |   Author: Foxze                   |
 * |>=================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- TDM_Airport2_Init()
	- TDM_Airport2_CreateElements(sessionid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_TDM_LOC_AIRPORT2
	#endinput
#endif
#define _INC_TDM_LOC_AIRPORT2

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock TDM_Airport2_Init()
{
	Mode_AddLocation(MODE_TDM, TDM_LOC_AIRPORT2, "Аэропорт");
	Mode_SetLocationInfo(MODE_TDM, TDM_LOC_AIRPORT2, "-");

	Mode_SetLocationGameMode(MODE_TDM, TDM_LOC_AIRPORT2, TDM_GAME_MODE_BATTLE_KILLS);
	Mode_SetLocationWeather(MODE_TDM, TDM_LOC_AIRPORT2, 0);
	Mode_SetLocationMinutes(MODE_TDM, TDM_LOC_AIRPORT2, 10);
	Mode_SetLocationSeconds(MODE_TDM, TDM_LOC_AIRPORT2, 0);
	Mode_SetLocationInterior(MODE_TDM, TDM_LOC_AIRPORT2, 0);
	return 1;
}

stock TDM_Airport2_CreateElements(sessionid)
{
	// Teams
	TDM_AddTeam(sessionid, TDM_TEAM_MILITARY, true);
	TDM_AddTeam(sessionid, TDM_TEAM_REBEL, true);

	// Score
	TDM_SetTeamScore(sessionid, TDM_TEAM_MILITARY, 0, 50);
	TDM_SetTeamScore(sessionid, TDM_TEAM_REBEL, 0, 50);

	// TOP players
	TDM_SetSpawnTopActor(sessionid, 0, -1168.3767, -274.9376, 14.1484, 68.5738);
	TDM_SetSpawnTopActor(sessionid, 1, -1165.9050, -273.0405, 14.1484, 96.1473);
	TDM_SetSpawnTopActor(sessionid, 2, -1163.8888, -277.0248, 14.1484, 103.0407);
	TDM_SetSpawnTopActor(sessionid, 3, -1162.2628, -270.9858, 14.1440, 94.2673);
	TDM_SetSpawnTopActor(sessionid, 4, -1160.0897, -279.4976, 14.1484, 90.8206);

	// Camera end match
	TDM_SetCameraEndPos(sessionid, 
		-1230.385253, -209.638626, 21.693603, 
		-1226.051269, -207.511749, 20.392353);
	TDM_SetCameraEndLookAt(sessionid, 
		-1269.864868, -229.015655, 33.548595, 
		-1265.530883, -226.888778, 32.247344);
	TDM_SetCameraEndPosTwo(sessionid, 
		-1184.558715, -276.270446, 15.463514, 
		-1179.560058, -276.264129, 15.350243);

	// Exit zone
	TDM_SetExitZonePos(sessionid, -1453.0, -379.0, -1055.0, -56.0);

	// Base team
	TDM_CreateBaseTeam(sessionid, TDM_TEAM_MILITARY, -1310.0, -215.5, -1201.0, -132.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_MILITARY, -1308.366333, -210.777572, 25.659154, -1306.669677, -206.259841, 24.350864);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 0, -1297.0111, -179.2232, 14.1484);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 1, -1271.9191, -118.0250, 14.1440);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 2, -1348.5477, -212.5527, 14.8883);

	TDM_CreateBaseTeam(sessionid, TDM_TEAM_REBEL, -1246.0, -328.5, -1137.0, -245.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_REBEL, -1238.748168, -275.685363, 23.13533, -1235.348266, -279.197204, 22.082763);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 0, -1254.6067, -326.8659, 14.1484);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 1, -1208.6014, -298.5283, 14.1484);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 2, -1156.4420, -303.2933, 14.1484);

	// Shop Teams
	TDM_CreateShopTeam(sessionid, TDM_TEAM_MILITARY, -1300.2150, -161.5442, 14.1484);
	TDM_CreateShopTeam(sessionid, TDM_TEAM_REBEL, -1203.5620, -309.3369, 14.1484);
	return 1;
}