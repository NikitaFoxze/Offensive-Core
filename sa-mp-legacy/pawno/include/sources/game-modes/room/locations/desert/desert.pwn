/*

	About: Room Desert location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Room_Desert_CreateElements(room_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_LOC_DESERT
	#endinput
#endif
#define _INC_ROOM_LOC_DESERT

/*

	* Functions *

*/

stock Room_Desert_CreateElements(room_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_ROOM, room_id, Mode_GetBasicVirtualWorld(MODE_ROOM, room_id));
	Mode_SetInterior(MODE_ROOM, room_id, Mode_GetBasicInterior(MODE_ROOM, room_id));

	// Погода
	Mode_SetWeather(MODE_ROOM, room_id, 0);

	// Камера в конце матча
	Room_SetCameraEndPos(room_id, 
		159.191696, 2426.700439, 18.412237, 
		154.704925, 2426.841796, 16.210220);
	Room_SetCameraEndLookAt(room_id, 
		216.687881, 2424.889648, 46.630187, 
		212.201110, 2425.031005, 44.428169);

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
			Room_SetCapturePointPos(room_id, 160.2224, 2462.4822, 16.4766);
		}
		case ROOM_MODE_SECRET_DATA: {
			// Команды
			Room_AddTeam(room_id, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(room_id, ROOM_TEAM_BRAVO, false);

			// Счёт
			Room_SetTeamChet(room_id, ROOM_TEAM_ALPHA, 1, 1);
			Room_SetTeamChet(room_id, ROOM_TEAM_BRAVO, 1, 1);

			// Компьютер
			Room_SetComputerPos(room_id, 157.6383, 2386.3525, 16.4844);
		}
	}

	// Спавны
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 0, 214.3125, 2452.6484, 16.4844);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 1, 214.6718, 2431.4436, 16.4765);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 2, 228.3091, 2432.3979, 16.4880);

	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 0, 111.8946, 2422.3647, 16.5159);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 1, 110.4891, 2443.4827, 16.4844);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 2, 103.6913, 2406.9138, 17.0684);
	return 1;
}