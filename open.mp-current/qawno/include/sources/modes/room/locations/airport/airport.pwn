/*
 * |>================================<|
 * |   About: Room Airport location   |
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
	- Room_Airport_Init()
	- Room_Airport_CreateElements(roomid)
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

#if defined _INC_ROOM_LOC_AIRPORT
	#endinput
#endif
#define _INC_ROOM_LOC_AIRPORT

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock Room_Airport_Init()
{
	Mode_AddLocation(MODE_ROOM, ROOM_LOC_AIRPORT, "Аэропорт");
	Mode_SetLocationInfo(MODE_ROOM, ROOM_LOC_AIRPORT, "-");

	Mode_SetLocationGameMode(MODE_ROOM, ROOM_LOC_AIRPORT, 0);
	Mode_SetLocationWeather(MODE_ROOM, ROOM_LOC_AIRPORT, 0);
	Mode_SetLocationMinutes(MODE_ROOM, ROOM_LOC_AIRPORT, 0);
	Mode_SetLocationSeconds(MODE_ROOM, ROOM_LOC_AIRPORT, 0);
	Mode_SetLocationInterior(MODE_ROOM, ROOM_LOC_AIRPORT, 0);
	return 1;
}

stock Room_Airport_CreateElements(roomid)
{
	// Camera end match
	Room_SetCameraEndPos(roomid, 
		-1220.086547, -220.183471, 19.132827, 
		-1224.486328, -218.522354, 17.434967);
	Room_SetCameraEndLookAt(roomid, 
		-1172.826904, -238.026260, 37.370323, 
		-1177.226684, -236.365142, 35.672462);

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
			Room_SetCapturePointPos(roomid, 2537.6833, 2754.9055, 10.8203);
		}
		case ROOM_GAME_MODE_DATA: {
			// Teams
			Room_AddTeam(roomid, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(roomid, ROOM_TEAM_BRAVO, false);

			// Score
			Room_SetTeamScore(roomid, ROOM_TEAM_ALPHA, 1, 1);
			Room_SetTeamScore(roomid, ROOM_TEAM_BRAVO, 1, 1);

			// Компьютер
			Room_SetComputerPos(roomid, -1198.1711, -175.8038, 14.3355);
		}
	}

	// Spawns
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 0, -1243.9176, -140.5332, 14.1484);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 1, -1285.7964, -186.1428, 14.1484);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 2, -1299.9194, -163.2341, 14.1484);

	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 0, -1209.1721, -249.2576, 14.1484);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 1, -1159.6393, -225.3044, 14.8521);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 2, -1222.2473, -284.2713, 14.1484);
	return 1;
}