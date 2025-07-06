/*
 * |>============================<|
 * |   About: TDM Golf location   |
 * |   Author: Foxze              |
 * |>============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- TDM_Golf_Init()
	- TDM_Golf_CreateElements(sessionid)
	- TDM_Golf_VehSetSettings(vehicleid)
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

#if defined _INC_TDM_LOC_GOLF
	#endinput
#endif
#define _INC_TDM_LOC_GOLF

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock TDM_Golf_Init()
{
	Mode_AddLocation(MODE_TDM, TDM_LOC_GOLF, "Гольф");
	Mode_SetLocationInfo(MODE_TDM, TDM_LOC_GOLF, "-");

	Mode_SetLocationGameMode(MODE_TDM, TDM_LOC_GOLF, TDM_GAME_MODE_CAPTURE_FLAG);
	Mode_SetLocationWeather(MODE_TDM, TDM_LOC_GOLF, 0);
	Mode_SetLocationMinutes(MODE_TDM, TDM_LOC_GOLF, 20);
	Mode_SetLocationSeconds(MODE_TDM, TDM_LOC_GOLF, 0);
	Mode_SetLocationInterior(MODE_TDM, TDM_LOC_GOLF, 0);
	return 1;
}

stock TDM_Golf_CreateElements(sessionid)
{
	// Teams
	TDM_AddTeam(sessionid, TDM_TEAM_MILITARY, true);
	TDM_AddTeam(sessionid, TDM_TEAM_REBEL, true);

	// Score
	TDM_SetTeamScore(sessionid, TDM_TEAM_MILITARY, 0, 10);
	TDM_SetTeamScore(sessionid, TDM_TEAM_REBEL, 0, 10);

	// TOP players
	TDM_SetSpawnTopActor(sessionid, 0, 1358.4762, 2833.9839, 10.8203, 180.4818);
	TDM_SetSpawnTopActor(sessionid, 1, 1355.5365, 2836.2363, 10.8203, 180.1684);
	TDM_SetSpawnTopActor(sessionid, 2, 1360.9481, 2835.6326, 10.8203, 180.1684);
	TDM_SetSpawnTopActor(sessionid, 3, 1353.5803, 2837.9731, 10.8203, 180.1684);
	TDM_SetSpawnTopActor(sessionid, 4, 1362.9001, 2837.9211, 10.8203, 180.1684);

	// Camera end match
	TDM_SetCameraEndPos(sessionid, 
		1244.462402, 2806.970703, 14.556577, 
		1248.839111, 2804.649169, 13.882078);
	TDM_SetCameraEndLookAt(sessionid, 
		1187.799804, 2837.024902, 23.288904, 
		1192.176513, 2834.703369, 22.614404);
	TDM_SetCameraEndPosTwo(sessionid, 
		1360.658691, 2848.389404, 12.033515, 
		1360.154785, 2843.415283, 11.974923);

	// Exit zone
	TDM_SetExitZonePos(sessionid, 1116.0, 2719.0, 1459.0, 2864.0);

	// Base team
	TDM_CreateBaseTeam(sessionid, TDM_TEAM_MILITARY, 1117.0, 2725.5, 1192.0, 2863.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_MILITARY, 1191.161010, 2763.211181, 25.787965, 1187.292724, 2765.922119, 24.148794);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 0, 1130.7357, 2821.7314, 10.8203);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 1, 1126.6777, 2776.4463, 10.8517);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 2, 1139.3954, 2752.9590, 10.8203);

	TDM_CreateBaseTeam(sessionid, TDM_TEAM_REBEL, 1375.0, 2722.5, 1450.0, 2860.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_REBEL, 1348.438842, 2806.139648, 22.369346, 1352.661621, 2803.997802, 20.762935);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 0, 1424.3649, 2774.0354, 14.8203);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 1, 1412.9264, 2815.2532, 10.8203);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 2, 1412.5946, 2743.0137, 10.8203);

	// Flags
	TDM_CreateCaptureFlag(sessionid, TDM_TEAM_MILITARY, 1171.7899, 2786.4756, 10.8203);
	TDM_CreateCaptureFlag(sessionid, TDM_TEAM_REBEL, 1363.3289, 2791.4871, 10.82034);

	// Shop Teams
	TDM_CreateShopTeam(sessionid, TDM_TEAM_MILITARY, 1144.3766, 2796.1787, 10.8125);
	TDM_CreateShopTeam(sessionid, TDM_TEAM_REBEL, 1407.1703, 2785.6472, 10.8203);

	// Vehicle
	TDM_SetActiveVehicle(sessionid, true);
	CreateVehicleLocation(sessionid);
	return 1;
}

stock TDM_Golf_VehSetSettings(vehicleid)
{
	if (GetVehicleTeam(vehicleid) == TDM_TEAM_NONE)
		SetVehicleColorEx(vehicleid, random(127), random(127));
	else
		SetVehicleColorEx(vehicleid, TDM_GetTeamColorVehicle(GetVehicleTeam(vehicleid), 0), TDM_GetTeamColorVehicle(GetVehicleTeam(vehicleid), 1));

	LinkVehicleToInterior(vehicleid, Mode_GetSessionInterior(MODE_TDM, GetVehicleSession(vehicleid)));
	SetVehicleVirtualWorld(vehicleid, Mode_GetSessionVirtualWorld(MODE_TDM, GetVehicleSession(vehicleid)));
	
	SetVehicleEngine(vehicleid, false);
	SetVehicleFuel(vehicleid, VEHICLE_FUEL);
	return 1;
}

static CreateVehicleLocation(sessionid)
{
	// Military
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 0, 471, 1151.0288, 2758.7668, 10.1761, -90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 1, 471, 1152.2816, 2760.7913, 10.1761, -90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 2, 471, 1150.9271, 2762.8303, 10.1761, -90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 3, 471, 1143.9233, 2830.0715, 10.1761, -90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 4, 471, 1144.0297, 2825.6101, 10.1761, -90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 5, 471, 1145.7448, 2827.7727, 10.1761, -90.0000, -1, -1);

	// Rebel
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 6, 471, 1384.6238, 2823.6238, 10.1666, 90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 7, 471, 1382.5150, 2821.7227, 10.1666, 90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 8, 471, 1384.4109, 2819.6824, 10.1666, 90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 9, 471, 1392.4192, 2771.6226, 10.1666, 90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 10, 471, 1391.0781, 2769.2903, 10.1666, 90.0000, -1, -1);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 11, 471, 1392.3300, 2767.0295, 10.1666, 90.0000, -1, -1);
	return 1;
}