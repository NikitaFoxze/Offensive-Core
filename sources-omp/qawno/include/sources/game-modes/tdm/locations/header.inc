/*

	About: TDM location header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		Float:GetAirRandomPos()
		TDM_GetNameLocation(location_id)
		TDM_GetInfoLocation(location_id)
		TDM_GetModeLocation(location_id)
Enums:
	E_TDM_LOC_INFO
Global var:
	adstr

	TDM_BaseTeamCount
	TDM_CapturePointCount
	TDM_CaptureFlagCount
	TDM_BagMoneyCount
	TDM_ShopCount
------------------------------------------------------------------------------*/

#if defined _INC_TDM_LOC_HEADER
	#endinput
#endif
#define _INC_TDM_LOC_HEADER

/*

	* Defines *

*/

// Locations
#define TDM_MAX_LOCATIONS	(9)

#define TDM_LOC_DESERT		(0)
#define TDM_LOC_DESERT2		(1)
#define TDM_LOC_AIRPORT		(2)
#define TDM_LOC_AIRPORT2	(3)
#define TDM_LOC_STADIUM		(4)
#define TDM_LOC_VILLAGE		(5)
#define TDM_LOC_GOLF		(6)
#define TDM_LOC_ZONE51		(7)
#define TDM_LOC_EXAMPLE		(8)

// Additional Elements (AE)
#define AE_OBJECT_COUNT			(100)	// Кол-во объектов
#define AE_3D_TEXT_COUNT		(50)	// Кол-во 3D текстов
#define AE_PICKUP_DOOR_COUNT	(50)	// Кол-во пикапов дверей
#define AE_PICKUP_COUNT			(50)	// Кол-во пикапов
#define AE_MAPICON_COUNT		(50)	// Кол-во иконок
#define AE_ACTOR_COUNT			(50)	// Кол-во актёров

#define TDM_AD_STRING_MAX_LENGTH	(200 + 1)

/*

	* Enums *

*/

enum E_TDM_LOC_INFO {
	LI_Name[50],
	LI_Info[500],
	LI_Mode
}

/*

	* Vars *

*/

static const
	TDM_Location[TDM_MAX_LOCATIONS][E_TDM_LOC_INFO] = {
	{
		"Пустыня",
		"-",
		TDM_MODE_CAPTURE
	},
	{
		"Пустыня",
		"-",
		TDM_MODE_CAPTURE_FLAG
	},
	{
		"Аэропорт",
		"-",
		TDM_MODE_CAPTURE
	},
	{
		"Аэропорт",
		"-",
		TDM_MODE_BATTLE_KILLS
	},
	{
		"Стадион",
		"-",
		TDM_MODE_SECRET_DATA
	},
	{
		"Городок",
		"-",
		TDM_MODE_SECRET_DATA
	},
	{
		"Гольф",
		"-",
		TDM_MODE_CAPTURE_FLAG
	},
	{
		"Зона 51",
		"-",
		TDM_MODE_BATTLE_KILLS
	},
	{
		"Пример",
		"-",
		TDM_MODE_CAPTURE
	}
};

new
	adstr[TDM_AD_STRING_MAX_LENGTH];

new
	Iterator:TDM_BaseTeamCount[TDM_MAX_GAME_SESSIONS]<TDM_MAX_TEAM_BASES>,
	Iterator:TDM_CapturePointCount[TDM_MAX_GAME_SESSIONS]<TDM_MAX_CAPTURE_POINTS>,
	Iterator:TDM_CaptureFlagCount[TDM_MAX_GAME_SESSIONS]<TDM_MAX_TEAMS>,
	Iterator:TDM_BagMoneyCount[TDM_MAX_GAME_SESSIONS]<TDM_MAX_TEAMS>,
	Iterator:TDM_ShopCount[TDM_MAX_GAME_SESSIONS]<TDM_MAX_TEAMS>;

stock
	Float:GetAirRandomPos()
	{
		new
			Float:r,
			ran = random(5);

		switch(ran) {
			case 0: r = 2.0;
			case 1: r = 3.0;
			case 2: r = 4.0;
			case 3: r = 5.0;
			case 4: r = 6.0;
		}
		return r;
	}

/*

	* Functions *

*/

stock TDM_GetNameLocation(location_id)
{
	new
		str[50];

	strcat(str, TDM_Location[location_id][LI_Name]);
	return str;
}

stock TDM_GetInfoLocation(location_id)
{
	new
		str[500];

	strcat(str, TDM_Location[location_id][LI_Info]);
	return str;
}

stock TDM_GetModeLocation(location_id)
{
	return TDM_Location[location_id][LI_Mode];
}