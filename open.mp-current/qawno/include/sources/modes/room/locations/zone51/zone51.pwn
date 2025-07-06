/*
 * |>================================<|
 * |   About: Room Zone 51 location   |
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
	- Room_Zone51_Init()
	- Room_Zone51_CreateElements(roomid)
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

#if defined _INC_ROOM_LOC_ZONE51
	#endinput
#endif
#define _INC_ROOM_LOC_ZONE51

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock Room_Zone51_Init()
{
	Mode_AddLocation(MODE_ROOM, ROOM_LOC_ZONE51, "Зона 51");
	Mode_SetLocationInfo(MODE_ROOM, ROOM_LOC_ZONE51, "-");

	Mode_SetLocationGameMode(MODE_ROOM, ROOM_LOC_ZONE51, 0);
	Mode_SetLocationWeather(MODE_ROOM, ROOM_LOC_ZONE51, 0);
	Mode_SetLocationMinutes(MODE_ROOM, ROOM_LOC_ZONE51, 0);
	Mode_SetLocationSeconds(MODE_ROOM, ROOM_LOC_ZONE51, 0);
	Mode_SetLocationInterior(MODE_ROOM, ROOM_LOC_ZONE51, 0);
	return 1;
}

stock Room_Zone51_CreateElements(roomid)
{
	// Camera end match
	Room_SetCameraEndPos(roomid, 
		214.003524, 1891.262329, 17.891420, 
		213.996688, 1886.509521, 16.338624);
	Room_SetCameraEndLookAt(roomid, 
		214.071487, 1938.555786, 33.342823, 
		214.064651, 1933.802978, 31.790027);

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
			Room_SetComputerPos(roomid, 225.9585, 1862.0481, 13.1470);
		}
	}

	// Spawns
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 0, 219.9303, 1945.4268, 17.6406);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 1, 202.9738, 1944.5298, 17.6406);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 2, 193.3138, 1945.9279, 17.6406);

	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 0, 189.2908, 1845.3832, 17.6406);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 1, 210.6248, 1845.3871, 17.6406);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 2, 233.7936, 1845.2141, 17.6406);
	return 1;
}