/*

	About: Room Zone 51 location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Room_Zone51_CreateElements(room_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_LOC_ZONE51
	#endinput
#endif
#define _INC_ROOM_LOC_ZONE51

/*

	* Functions *

*/

stock Room_Zone51_CreateElements(room_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_ROOM, room_id, Mode_GetBasicVirtualWorld(MODE_ROOM, room_id));
	Mode_SetInterior(MODE_ROOM, room_id, Mode_GetBasicInterior(MODE_ROOM, room_id));

	// Погода
	Mode_SetWeather(MODE_ROOM, room_id, 0);

	// Камера в конце матча
	Room_SetCameraEndPos(room_id, 
		214.003524, 1891.262329, 17.891420, 
		213.996688, 1886.509521, 16.338624);
	Room_SetCameraEndLookAt(room_id, 
		214.071487, 1938.555786, 33.342823, 
		214.064651, 1933.802978, 31.790027);

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
			Room_SetComputerPos(room_id, 225.9585, 1862.0481, 13.1470);
		}
	}

	// Спавны
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 0, 219.9303, 1945.4268, 17.6406);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 1, 202.9738, 1944.5298, 17.6406);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 2, 193.3138, 1945.9279, 17.6406);

	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 0, 189.2908, 1845.3832, 17.6406);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 1, 210.6248, 1845.3871, 17.6406);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 2, 233.7936, 1845.2141, 17.6406);
	return 1;
}