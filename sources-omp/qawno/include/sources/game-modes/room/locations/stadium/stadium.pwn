/*

	About: Room Stadium location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Room_Stadium_CreateElements(room_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_LOC_STADIUM
	#endinput
#endif
#define _INC_ROOM_LOC_STADIUM

/*

	* Functions *

*/

stock Room_Stadium_CreateElements(room_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_ROOM, room_id, Mode_GetBasicVirtualWorld(MODE_ROOM, room_id));
	Mode_SetInterior(MODE_ROOM, room_id, Mode_GetBasicInterior(MODE_ROOM, room_id));

	// Погода
	Mode_SetWeather(MODE_ROOM, room_id, 0);

	// Камера в конце матча
	Room_SetCameraEndPos(room_id, 
		1347.344726, 2153.420166, 14.011373, 
		1347.082763, 2148.479003, 13.293050);
	Room_SetCameraEndLookAt(room_id, 
		1350.362060, 2210.346191, 22.287055, 
		1350.100097, 2205.405029, 21.568733);

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
			Room_SetCapturePointPos(room_id, 1344.9479, 2154.9741, 11.0156);
		}
		case ROOM_MODE_SECRET_DATA: {
			// Команды
			Room_AddTeam(room_id, ROOM_TEAM_ALPHA, true);
			Room_AddTeam(room_id, ROOM_TEAM_BRAVO, false);

			// Счёт
			Room_SetTeamChet(room_id, ROOM_TEAM_ALPHA, 1, 1);
			Room_SetTeamChet(room_id, ROOM_TEAM_BRAVO, 1, 1);

			// Компьютер
			Room_SetComputerPos(room_id, 1349.4266, 2162.2366, 11.0156);
		}
	}

	// Спавны
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 0, 1372.1973, 2070.1335, 11.6054);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 1, 1357.0533, 2069.6353, 11.6680);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 2, 1337.3434, 2069.4324, 11.6447);

	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 0, 1309.5184, 2212.7375, 12.0156);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 1, 1342.8336, 2212.9741, 12.0156);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 2, 1367.6766, 2213.0518, 12.0156);
	return 1;
}