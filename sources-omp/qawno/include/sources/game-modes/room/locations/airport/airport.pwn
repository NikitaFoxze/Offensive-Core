/*

	About: Room Airport location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Room_Airport_CreateElements(room_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_LOC_AIRPORT
	#endinput
#endif
#define _INC_ROOM_LOC_AIRPORT

/*

	* Functions *

*/

stock Room_Airport_CreateElements(room_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_ROOM, room_id, Mode_GetBasicVirtualWorld(MODE_ROOM, room_id));
	Mode_SetInterior(MODE_ROOM, room_id, Mode_GetBasicInterior(MODE_ROOM, room_id));

	// Погода
	Mode_SetWeather(MODE_ROOM, room_id, 0);

	// Камера в конце матча
	Room_SetCameraEndPos(room_id, 
		-1220.086547, -220.183471, 19.132827, 
		-1224.486328, -218.522354, 17.434967);
	Room_SetCameraEndLookAt(room_id, 
		-1172.826904, -238.026260, 37.370323, 
		-1177.226684, -236.365142, 35.672462);

	switch(Room_GetMode(room_id)) {
		case ROOM_MODE_BATTLE: {
			// Команды
			Room_AddTeam(room_id, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(room_id, ROOM_TEAM_BRAVO, true);

			// Счёт
			Room_SetTeamChet(room_id, ROOM_TEAM_ALPHA, 0, 50);
			Room_SetTeamChet(room_id, ROOM_TEAM_BRAVO, 0, 50);
		}
		case ROOM_MODE_CAPTURE: {
			// Команды
			Room_AddTeam(room_id, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(room_id, ROOM_TEAM_BRAVO, true);

			// Счёт
			Room_SetTeamChet(room_id, ROOM_TEAM_ALPHA, 0, 100);
			Room_SetTeamChet(room_id, ROOM_TEAM_BRAVO, 0, 100);

			// Точка захвата
			Room_SetCapturePointPos(room_id, 2537.6833, 2754.9055, 10.8203);
		}
		case ROOM_MODE_SECRET_DATA: {
			// Команды
			Room_AddTeam(room_id, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(room_id, ROOM_TEAM_BRAVO, false);

			// Счёт
			Room_SetTeamChet(room_id, ROOM_TEAM_ALPHA, 1, 1);
			Room_SetTeamChet(room_id, ROOM_TEAM_BRAVO, 1, 1);

			// Компьютер
			Room_SetComputerPos(room_id, -1198.1711, -175.8038, 14.3355);
		}
	}

	// Спавны
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 0, -1243.9176, -140.5332, 14.1484);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 1, -1285.7964, -186.1428, 14.1484);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 2, -1299.9194, -163.2341, 14.1484);

	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 0, -1209.1721, -249.2576, 14.1484);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 1, -1159.6393, -225.3044, 14.8521);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 2, -1222.2473, -284.2713, 14.1484);
	return 1;
}