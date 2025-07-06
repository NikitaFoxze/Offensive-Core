/*

	About: Example location header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Example_GetNameLocation(location_id)
		Example_GetInfoLocation(location_id)
Enums:
	E_EXAMPLE_LOC_INFO
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_EXAMPLE_LOC_HEADER
	#endinput
#endif
#define _INC_EXAMPLE_LOC_HEADER

/*

	* Defines *

*/

// Locations
#define EXAMPLE_MAX_LOCATIONS	(1)		// Кол-во локаций

#define EXAMPLE_LOC_DESERT		(0)

/*

	* Enums *

*/

enum E_EXAMPLE_LOC_INFO {
	LI_Name[50],
	LI_Info[500],
	LI_Mode
}

/*

	* Vars *

*/

static const
	EXAMPLE_Location[DM_MAX_LOCATIONS][E_EXAMPLE_LOC_INFO] = {
	{
		"Пустыня", 
		"-"
	}
};

/*

	* Functions *

*/

stock Example_GetNameLocation(location_id)
{
	new
		str[50];

	strcat(str, EXAMPLE_Location[location_id][LI_Name]);
	return str;
}

stock Example_GetInfoLocation(location_id)
{
	new
		str[50];

	strcat(str, EXAMPLE_Location[location_id][LI_Info]);
	return str;
}