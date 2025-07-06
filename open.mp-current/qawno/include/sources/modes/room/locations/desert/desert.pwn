/*
 * |>===============================<|
 * |   About: Room Desert location   |
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
	- Room_Desert_Init()
	- Room_Desert_CreateElements(roomid)
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

#if defined _INC_ROOM_LOC_DESERT
	#endinput
#endif
#define _INC_ROOM_LOC_DESERT

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock Room_Desert_Init()
{
	Mode_AddLocation(MODE_ROOM, ROOM_LOC_DESERT, "Пустыня");
	Mode_SetLocationInfo(MODE_ROOM, ROOM_LOC_DESERT, "-");

	Mode_SetLocationGameMode(MODE_ROOM, ROOM_LOC_DESERT, 0);
	Mode_SetLocationWeather(MODE_ROOM, ROOM_LOC_DESERT, 0);
	Mode_SetLocationMinutes(MODE_ROOM, ROOM_LOC_DESERT, 0);
	Mode_SetLocationSeconds(MODE_ROOM, ROOM_LOC_DESERT, 0);
	Mode_SetLocationInterior(MODE_ROOM, ROOM_LOC_DESERT, 0);
	return 1;
}

stock Room_Desert_CreateElements(roomid)
{
	// Camera end match
	Room_SetCameraEndPos(roomid, 
		159.191696, 2426.700439, 18.412237, 
		154.704925, 2426.841796, 16.210220);
	Room_SetCameraEndLookAt(roomid, 
		216.687881, 2424.889648, 46.630187, 
		212.201110, 2425.031005, 44.428169);

	switch (Mode_GetSessionGameMode(MODE_ROOM, roomid)) {
		case ROOM_GAME_MODE_BATTLE: {
			// Teams
			Room_AddTeam(roomid, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(roomid, ROOM_TEAM_BRAVO, true);

			// Score
			Room_SetTeamScore(roomid, ROOM_TEAM_ALPHA, 0, 50);
			Room_SetTeamScore(roomid, ROOM_TEAM_BRAVO, 0, 50);
		}
		case ROOM_GAME_MODE_CAPTURE: {
			// Teams
			Room_AddTeam(roomid, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(roomid, ROOM_TEAM_BRAVO, true);

			// Score
			Room_SetTeamScore(roomid, ROOM_TEAM_ALPHA, 0, 100);
			Room_SetTeamScore(roomid, ROOM_TEAM_BRAVO, 0, 100);

			// Точка захвата
			Room_SetCapturePointPos(roomid, 160.2224, 2462.4822, 16.4766);
		}
		case ROOM_GAME_MODE_DATA: {
			// Teams
			Room_AddTeam(roomid, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(roomid, ROOM_TEAM_BRAVO, false);

			// Score
			Room_SetTeamScore(roomid, ROOM_TEAM_ALPHA, 1, 1);
			Room_SetTeamScore(roomid, ROOM_TEAM_BRAVO, 1, 1);

			// Компьютер
			Room_SetComputerPos(roomid, 157.6383, 2386.3525, 16.4844);
		}
	}

	// Spawns
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 0, 214.3125, 2452.6484, 16.4844);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 1, 214.6718, 2431.4436, 16.4765);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 2, 228.3091, 2432.3979, 16.4880);

	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 0, 111.8946, 2422.3647, 16.5159);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 1, 110.4891, 2443.4827, 16.4844);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 2, 103.6913, 2406.9138, 17.0684);
	return 1;
}