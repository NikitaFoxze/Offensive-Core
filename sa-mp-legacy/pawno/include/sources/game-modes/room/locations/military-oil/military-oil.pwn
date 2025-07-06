/*

	About: Room Military oil location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Room_MilitOil_CreateElements(room_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_LOC_MILITARYOIL
	#endinput
#endif
#define _INC_ROOM_LOC_MILITARYOIL

/*

	* Functions *

*/

stock Room_MilitOil_CreateElements(room_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_ROOM, room_id, Mode_GetBasicVirtualWorld(MODE_ROOM, room_id));
	Mode_SetInterior(MODE_ROOM, room_id, Mode_GetBasicInterior(MODE_ROOM, room_id));

	// Погода
	Mode_SetWeather(MODE_ROOM, room_id, 0);

	// Камера в конце матча
	Room_SetCameraEndPos(room_id, 
		2600.109619, 2749.778320, 30.494262, 
		2603.959960, 2752.503173, 28.836019);
	Room_SetCameraEndLookAt(room_id, 
		2541.895996, 2708.587158, 55.563564, 
		2545.746337, 2711.312011, 53.905319);

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
			Room_SetComputerPos(room_id, 2592.9761, 2782.0381, 10.9844);
		}
	}

	// Спавны
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 0, 2611.1255, 2703.5613, 25.8222);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 1, 2619.3328, 2705.3918, 25.8222);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_ALPHA, 2, 2627.0776, 2704.9333, 25.8222);

	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 0, 2561.9434, 2816.6782, 27.8203);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 1, 2590.5879, 2830.4063, 27.8203);
	Room_SetSpawnBasePos(room_id, ROOM_TEAM_BRAVO, 2, 2609.4629, 2825.2205, 27.8203);
	return 1;
}