/*
 * |>=====================================<|
 * |   About: Room Military oil location   |
 * |   Author: Foxze                       |
 * |>=====================================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- Room_MilitOil_Init()
	- Room_MilitOil_CreateElements(roomid)
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

#if defined _INC_ROOM_LOC_MILITARYOIL
	#endinput
#endif
#define _INC_ROOM_LOC_MILITARYOIL

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock Room_MilitOil_Init()
{
	Mode_AddLocation(MODE_ROOM, ROOM_LOC_MILITARYOIL, "Военный нефтезавод");
	Mode_SetLocationInfo(MODE_ROOM, ROOM_LOC_MILITARYOIL, "-");

	Mode_SetLocationGameMode(MODE_ROOM, ROOM_LOC_MILITARYOIL, 0);
	Mode_SetLocationWeather(MODE_ROOM, ROOM_LOC_MILITARYOIL, 0);
	Mode_SetLocationMinutes(MODE_ROOM, ROOM_LOC_MILITARYOIL, 0);
	Mode_SetLocationSeconds(MODE_ROOM, ROOM_LOC_MILITARYOIL, 0);
	Mode_SetLocationInterior(MODE_ROOM, ROOM_LOC_MILITARYOIL, 0);
	return 1;
}

stock Room_MilitOil_CreateElements(roomid)
{
	// Camera end match
	Room_SetCameraEndPos(roomid, 
		2600.109619, 2749.778320, 30.494262, 
		2603.959960, 2752.503173, 28.836019);
	Room_SetCameraEndLookAt(roomid, 
		2541.895996, 2708.587158, 55.563564, 
		2545.746337, 2711.312011, 53.905319);

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
			Room_SetComputerPos(roomid, 2592.9761, 2782.0381, 10.9844);
		}
	}

	// Spawns
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 0, 2611.1255, 2703.5613, 25.8222);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 1, 2619.3328, 2705.3918, 25.8222);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_ALPHA, 2, 2627.0776, 2704.9333, 25.8222);

	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 0, 2561.9434, 2816.6782, 27.8203);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 1, 2590.5879, 2830.4063, 27.8203);
	Room_SetSpawnBasePos(roomid, ROOM_TEAM_BRAVO, 2, 2609.4629, 2825.2205, 27.8203);
	return 1;
}