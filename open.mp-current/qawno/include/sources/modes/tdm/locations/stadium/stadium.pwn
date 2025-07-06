/*
 * |>===============================<|
 * |   About: TDM Stadium location   |
 * |   Author: Foxze                 |
 * |>===============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- TDM_Stadium_Init()
	- TDM_Stadium_CreateElements(sessionid)
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

#if defined _INC_TDM_LOC_STADIUM
	#endinput
#endif
#define _INC_TDM_LOC_STADIUM

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock TDM_Stadium_Init()
{
	Mode_AddLocation(MODE_TDM, TDM_LOC_STADIUM, "Стадион");
	Mode_SetLocationInfo(MODE_TDM, TDM_LOC_STADIUM, "-");

	Mode_SetLocationGameMode(MODE_TDM, TDM_LOC_STADIUM, TDM_GAME_MODE_SECRET_DATA);
	Mode_SetLocationWeather(MODE_TDM, TDM_LOC_STADIUM, 0);
	Mode_SetLocationMinutes(MODE_TDM, TDM_LOC_STADIUM, 10);
	Mode_SetLocationSeconds(MODE_TDM, TDM_LOC_STADIUM, 0);
	Mode_SetLocationInterior(MODE_TDM, TDM_LOC_STADIUM, 0);
	return 1;
}

stock TDM_Stadium_CreateElements(sessionid)
{
	// Teams
	TDM_AddTeam(sessionid, TDM_TEAM_MILITARY, true);
	TDM_AddTeam(sessionid, TDM_TEAM_REBEL, false);

	// Score
	TDM_SetTeamScore(sessionid, TDM_TEAM_MILITARY, 1, 1);
	TDM_SetTeamScore(sessionid, TDM_TEAM_REBEL, 1, 1);

	// TOP players
	TDM_SetSpawnTopActor(sessionid, 0, 1389.1769, 2142.0859, 11.0234, 91.1574);
	TDM_SetSpawnTopActor(sessionid, 1, 1391.0818, 2143.8198, 11.0234, 91.1574);
	TDM_SetSpawnTopActor(sessionid, 2, 1391.7516, 2140.6196, 11.0234, 91.1574);
	TDM_SetSpawnTopActor(sessionid, 3, 1391.9286, 2146.7500, 11.0234, 91.1574);
	TDM_SetSpawnTopActor(sessionid, 4, 1392.5710, 2137.8098, 11.0234, 91.1574);

	// Camera end match
	TDM_SetCameraEndPos(sessionid, 
		1343.232910, 2150.631347, 15.996323, 
		1344.644409, 2154.986083, 13.985591);
	TDM_SetCameraEndLookAt(sessionid, 
		1329.303100, 2107.656982, 35.838806, 
		1330.714599, 2112.011718, 33.828075);
	TDM_SetCameraEndPosTwo(sessionid, 
		1373.622802, 2143.515136, 11.922683, 
		1378.619140, 2143.384765, 11.782076);

	// Exit zone
	TDM_SetExitZonePos(sessionid, 1250.0, 2059.0, 1424.0, 2222.0);

	// Base team
	TDM_CreateBaseTeam(sessionid, TDM_TEAM_MILITARY, 1290.0, 2183.5, 1417.0, 2223.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_MILITARY, 1280.348266, 2187.311279, 25.160736, 1284.698852, 2189.460449, 23.954833);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 0, 1410.9939, 2145.4214, 12.0156);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 1, 1411.0492, 2177.0005, 12.0156);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 2, 1354.8950, 2212.5613, 12.015);

	TDM_CreateBaseTeam(sessionid, TDM_TEAM_REBEL, 1256.0, 2058.5, 1397.0, 2105.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_REBEL, 1282.052001, 2068.955566, 23.713930, 1286.638183, 2070.133056, 22.107519);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 0, 1297.4147, 2088.5610, 10.8203);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 1, 1340.2692, 2072.2358, 12.3652);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 2, 1373.0745, 2070.3018, 11.6398);

	// Компьютеры
	TDM_CreateComputer(sessionid, TDM_TEAM_MILITARY, 0, 1347.3406, 2162.8215, 11.0156);

	// Shop Teams
	TDM_CreateShopTeam(sessionid, TDM_TEAM_MILITARY, 1295.9076, 2078.0413, 10.8203);
	TDM_CreateShopTeam(sessionid, TDM_TEAM_REBEL, 1406.5583, 2207.1733, 12.0156);
	return 1;
}