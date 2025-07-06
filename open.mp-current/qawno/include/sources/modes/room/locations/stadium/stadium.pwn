/*
 * |>================================<|
 * |   About: Room Stadium location   |
 * |   Author: Foxze                  |
 * |>================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- Room_Stadium_Init()
	- Room_Stadium_CreateElements(roomid)
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

#if defined _INC_ROOM_LOC_STADIUM
	#endinput
#endif
#define _INC_ROOM_LOC_STADIUM

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock Room_Stadium_Init()
{
	Mode_AddLocation(MODE_ROOM, ROOM_LOC_STADIUM, "Стадион");
	Mode_SetLocationInfo(MODE_ROOM, ROOM_LOC_STADIUM, "-");

	Mode_SetLocationGameMode(MODE_ROOM, ROOM_LOC_STADIUM, 0);
	Mode_SetLocationWeather(MODE_ROOM, ROOM_LOC_STADIUM, 0);
	Mode_SetLocationMinutes(MODE_ROOM, ROOM_LOC_STADIUM, 0);
	Mode_SetLocationSeconds(MODE_ROOM, ROOM_LOC_STADIUM, 0);
	Mode_SetLocationInterior(MODE_ROOM, ROOM_LOC_STADIUM, 0);
	return 1;
}

stock Room_Stadium_CreateElements(roomid)
{
	// Camera end match
	Room_SetCameraEndPos(roomid, 
		1347.344726, 2153.420166, 14.011373, 
		1347.082763, 2148.479003, 13.293050);
	Room_SetCameraEndLookAt(roomid, 
		1350.362060, 2210.346191, 22.287055, 
		1350.100097, 2205.405029, 21.568733);

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
			Room_SetCapturePointPos(roomid, 1344.9479, 2154.9741, 11.0156);
		}
		case ROOM_GAME_MODE_DATA: {
			// Teams
			Room_AddTeam(roomid, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(roomid, ROOM_TEAM_BRAVO, false);

			// Score
			Room_SetTeamScore(roomid, ROOM_TEAM_ALPHA, 1, 1);
			Room_SetTeamScore(roomid, ROOM_TEAM_BRAVO, 1, 1);

			// Компьютер
			Room_SetComputerPos(roomid, 1349.4266, 2162.2366, 11.0156);
		}
	}

	// Spawns
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 0, 1372.1973, 2070.1335, 11.6054);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 1, 1357.0533, 2069.6353, 11.6680);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 2, 1337.3434, 2069.4324, 11.6447);

	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 0, 1309.5184, 2212.7375, 12.0156);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 1, 1342.8336, 2212.9741, 12.0156);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 2, 1367.6766, 2213.0518, 12.0156);
	return 1;
}