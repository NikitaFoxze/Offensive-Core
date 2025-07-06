/*
 * |>===============================<|
 * |   About: TDM Zone 51 location   |
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
	- TDM_Zone51_Init()
	- TDM_Zone51_CreateElements(sessionid)
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

#if defined _INC_TDM_LOC_ZONE51
	#endinput
#endif
#define _INC_TDM_LOC_ZONE51

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock TDM_Zone51_Init()
{
	Mode_AddLocation(MODE_TDM, TDM_LOC_ZONE51, "Зона 51");
	Mode_SetLocationInfo(MODE_TDM, TDM_LOC_ZONE51, "-");

	Mode_SetLocationGameMode(MODE_TDM, TDM_LOC_ZONE51, TDM_GAME_MODE_BATTLE_KILLS);
	Mode_SetLocationWeather(MODE_TDM, TDM_LOC_ZONE51, 0);
	Mode_SetLocationMinutes(MODE_TDM, TDM_LOC_ZONE51, 10);
	Mode_SetLocationSeconds(MODE_TDM, TDM_LOC_ZONE51, 0);
	Mode_SetLocationInterior(MODE_TDM, TDM_LOC_ZONE51, 0);
	return 1;
}

stock TDM_Zone51_CreateElements(sessionid)
{
	// Teams
	TDM_AddTeam(sessionid, TDM_TEAM_MILITARY, true);
	TDM_AddTeam(sessionid, TDM_TEAM_REBEL, true);

	// Score
	TDM_SetTeamScore(sessionid, TDM_TEAM_MILITARY, 0, 100);
	TDM_SetTeamScore(sessionid, TDM_TEAM_REBEL, 0, 100);

	// TOP players
	TDM_SetSpawnTopActor(sessionid, 0, 213.4783, 1905.8370, 17.6406, 356.2400);
	TDM_SetSpawnTopActor(sessionid, 1, 216.2217, 1904.3049, 17.6406, 356.2400);
	TDM_SetSpawnTopActor(sessionid, 2, 210.2355, 1904.0776, 17.6406, 356.2400);
	TDM_SetSpawnTopActor(sessionid, 3, 217.5923, 1902.1473, 17.6406, 359.0601);
	TDM_SetSpawnTopActor(sessionid, 4, 209.7822, 1902.2002, 17.6406, 359.0601);

	// Camera end match
	TDM_SetCameraEndPos(sessionid, 
		206.201202, 1915.101196, 28.017675, 
		206.341293, 1919.903076, 26.631195);
	TDM_SetCameraEndLookAt(sessionid, 
		204.414855, 1853.872924, 45.69752, 
		204.554946, 1858.674804, 44.311050);
	TDM_SetCameraEndPosTwo(sessionid, 
		214.922393, 1922.947875, 18.599996, 
		214.827713, 1917.948730, 18.596090);

	// Exit zone
	TDM_SetExitZonePos(sessionid, 99.0, 1798.0, 329.0, 1975.0);

	// Base team
	TDM_CreateBaseTeam(sessionid, TDM_TEAM_MILITARY, 246.0, 1814.5, 304.0, 1973.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_MILITARY, 254.512771, 1852.207397, 30.965898, 257.697052, 1855.711669, 29.3594854);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 0, 282.8874, 1882.6312, 17.6406);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 1, 258.3599, 1832.5182, 17.6406);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 2, 274.0488, 1949.5095, 17.6406);

	TDM_CreateBaseTeam(sessionid, TDM_TEAM_REBEL, 106.0, 1817.5, 155.0, 1935.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_REBEL, 175.997177, 1910.830810, 32.754978, 172.778961, 1907.411254, 31.037467);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 0, 161.9177, 1834.9467, 17.6481);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 1, 151.2212, 1884.1403, 18.1794);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 2, 180.1040, 1930.2965, 17.987);

	// Shop Teams
	TDM_CreateShopTeam(sessionid, TDM_TEAM_MILITARY, 284.7037, 1868.9059, 17.6481);
	TDM_CreateShopTeam(sessionid, TDM_TEAM_REBEL, 145.7049, 1875.4513, 17.8359);
	return 1;
}