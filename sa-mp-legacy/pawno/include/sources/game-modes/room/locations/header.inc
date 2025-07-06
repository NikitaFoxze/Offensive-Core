/*

	About: Room location header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Room_GetNameLocation(location_id)
		Room_GetInfoLocation(location_id)
Enums:
	E_ROOM_LOC_INFO
Global var:
	Room_ActiveTeams
	Room_ActiveTeamsChet
------------------------------------------------------------------------------*/

#if defined _INC_ROOM_LOC_HEADER
	#endinput
#endif
#define _INC_ROOM_LOC_HEADER

/*

	* Defines *

*/

// Locations
#define ROOM_MAX_LOCATIONS 		(5)	// Кол-во локаций

#define ROOM_LOC_DESERT 		(0)
#define ROOM_LOC_ZONE51 		(1)
#define ROOM_LOC_MILITARYOIL	(2)
#define ROOM_LOC_AIRPORT 		(3)
#define ROOM_LOC_STADIUM 		(4)

/*

	* Enums *

*/

enum E_ROOM_LOC_INFO {
	LI_Name[50],
	LI_Info[300]
}

/*

	* Vars *

*/

static const 
	Room_Location[ROOM_MAX_LOCATIONS][E_ROOM_LOC_INFO] = {
		{
			"Пустыня", 
			"-"
		},
		{
			"Зона 51", 
			"-"
		},
		{
			"Военный нефтезавод", 
			"-"
		},
		{
			"Аэропорт", 
			"-"
		},
		{
			"Стадион", 
			"-"
		}
	};

/*

	* Functions *

*/

stock Room_GetNameLocation(location_id)
{
	new
		str[50];

	strcat(str, Room_Location[location_id][LI_Name]);
	return str;
}

stock Room_GetInfoLocation(location_id)
{
	new
		str[300];

	strcat(str, Room_Location[location_id][LI_Info]);
	return str;
}