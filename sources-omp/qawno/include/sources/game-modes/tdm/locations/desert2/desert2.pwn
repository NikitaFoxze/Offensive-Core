/*

	About: TDM Desert 2 location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		TDM_Desert2_CreateElements(session_id)
		TDM_Desert2_VehSetSettings(vehicleid)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_LOC_DESERT2
	#endinput
#endif
#define _INC_TDM_LOC_DESERT2

/*

	* Functions *

*/

stock TDM_Desert2_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_TDM, session_id, Mode_GetBasicVirtualWorld(MODE_TDM, session_id));
	Mode_SetInterior(MODE_TDM, session_id, Mode_GetBasicInterior(MODE_TDM, session_id));

	// Погода
	Mode_SetWeather(MODE_TDM, session_id, 0);

	// Команды
	TDM_AddTeam(session_id, TDM_TEAM_MILITARY, true);
	TDM_AddTeam(session_id, TDM_TEAM_REBEL, true);

	// Счёт
	TDM_SetTeamChet(session_id, TDM_TEAM_MILITARY, 0, 10);
	TDM_SetTeamChet(session_id, TDM_TEAM_REBEL, 0, 10);

	// Время
	TDM_SetTimer(session_id, 20, 0);

	// Лучшие игроки
	TDM_SetSpawnTopActor(session_id, 0, 196.32857, 2475.43604, 16.45367, 6.8112);
	TDM_SetSpawnTopActor(session_id, 1, 195.54019, 2474.86890, 16.45367, 6.8112);
	TDM_SetSpawnTopActor(session_id, 2, 197.45180, 2474.30249, 16.45367, 6.8112);
	TDM_SetSpawnTopActor(session_id, 3, 194.31660, 2473.62231, 16.45367, 6.8112);
	TDM_SetSpawnTopActor(session_id, 4, 198.91211, 2472.33813, 16.45367, 6.8112);

	// Камера в конце матча
	TDM_SetCameraEndPos(session_id, 
		154.029602, 2499.467773, 22.915037, 
		149.823303, 2497.032470, 21.741718);
	TDM_SetCameraEndLookAt(session_id, 
		217.976776, 2536.490722, 40.752727, 
		213.770477, 2534.055419, 39.579406);
	TDM_SetCameraEndPosTwo(session_id, 
		195.996307, 2480.556152, 16.584621, 
		-60.711090, 2539.641113, 47.315921);

	// Зона локации
	TDM_SetExitZonePos(session_id, -130.0, 2450.0, 453.0, 2562.0);

	// Базы команд
	TDM_CreateBaseTeam(session_id, TDM_TEAM_MILITARY, 273.0, 2474.5, 449.0, 2560.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_MILITARY, 430.988555, 2486.470214, 27.413524, 427.213745, 2489.658203, 26.647027);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 0, 422.4922, 2548.2712, 16.2652);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 1, 424.4905, 2532.2964, 16.5949);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 2, 403.8871, 2537.4629, 16.5457);

	TDM_CreateBaseTeam(session_id, TDM_TEAM_REBEL, -141.0, 2457.5, -7.0, 2562.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_REBEL, -80.960792, 2459.604492, 27.782730, -78.204315, 2463.644531, 26.743741);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 0, -107.4959, 2479.3669, 16.1576);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 1, -106.3020, 2513.2000, 16.9136);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 2, -85.3646, 2530.1316, 16.4844);
	
	// Флаги
	TDM_CreateCaptureFlag(session_id, TDM_TEAM_MILITARY, 350.2473, 2542.6023, 16.7386);
	TDM_CreateCaptureFlag(session_id, TDM_TEAM_REBEL, -37.2217, 2501.7051, 16.4844);

	// Магазины
	TDM_CreateShop(session_id, TDM_TEAM_MILITARY, 411.6464, 2533.1694, 16.5649);
	TDM_CreateShop(session_id, TDM_TEAM_REBEL, -57.8058, 2502.9097, 16.4844);

	// Транспорт
	TDM_SetVehicle(session_id, true);
	CreateVehicleLoccation(session_id);
	return 1;
}

stock TDM_Desert2_VehSetSettings(vehicleid)
{
	if(Veh_GetTeam(vehicleid) == TDM_TEAM_NONE)
		Veh_SetColor(vehicleid, random(127), random(127));
	else
		Veh_SetColor(vehicleid, TDM_ShowTeamColorVehicle(Veh_GetTeam(vehicleid), 0), TDM_ShowTeamColorVehicle(Veh_GetTeam(vehicleid), 1));

	LinkVehicleToInterior(vehicleid, Mode_GetInterior(MODE_TDM, Veh_GetSession(vehicleid)));
	SetVehicleVirtualWorld(vehicleid, Mode_GetVirtualWorld(MODE_TDM, Veh_GetSession(vehicleid)));
	
	Veh_SetEngine(vehicleid, false);
	Veh_SetFuel(vehicleid, VEHICLE_FUEL);
	return 1;
}

static CreateVehicleLoccation(session_id) 
{
	// Нейтралы
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 0, 468, 36.8387, 2529.7009, 16.0638, -120.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 1, 468, 52.0672, 2469.8157, 16.0813, 84.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 2, 468, 135.9356, 2471.9019, 16.0544, -91.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 3, 468, 169.3685, 2533.2651, 16.3288, -63.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 4, 468, 263.8025, 2536.6321, 16.3818, 120.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 5, 468, 151.7063, 2535.4565, 16.2725, 98.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 6, 578, 128.2036, 2479.7991, 16.9279, 91.0000);

	// Военные
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 7, 500, 431.1617, 2494.1550, 16.4576, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 8, 500, 430.2391, 2498.7861, 16.4576, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 9, 500, 431.2508, 2503.7520, 16.4576, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 10, 500, 431.0899, 2508.8860, 16.4576, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 11, 469, 413.9103, 2486.9790, 16.3266, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 12, 468, 401.4933, 2525.6843, 16.0414, 84.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 13, 468, 407.2737, 2524.2422, 16.0414, 84.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 14, 468, 394.2991, 2535.7551, 16.1194, 18.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 15, 468, 393.4302, 2539.2883, 16.1194, 27.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 16, 468, 392.2469, 2543.0396, 16.1194, 12.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 17, 470, 414.8146, 2516.2659, 16.1968, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 18, 470, 414.6774, 2512.4739, 16.1968, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 19, 470, 414.5771, 2508.4800, 16.1968, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 20, 470, 422.7014, 2519.9470, 16.1968, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 21, 470, 422.7831, 2523.9187, 16.1968, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 22, 528, 388.3275, 2527.3369, 16.4879, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 23, 515, 340.1640, 2544.5781, 17.7319, 900.0000);

	// Повстанцы
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 24, 413, -58.7114, 2527.6472, 16.4716, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 25, 413, -56.5699, 2523.3381, 16.4716, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 26, 413, -58.2156, 2518.6514, 16.4716, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 27, 424, -27.4541, 2485.3840, 16.1652, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 28, 424, -31.5062, 2481.7017, 16.1652, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 29, 424, -27.1510, 2478.0881, 16.1652, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 30, 424, -31.6824, 2489.2729, 16.1652, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 31, 424, -27.0708, 2492.2622, 16.1652, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 32, 444, -77.4722, 2488.7878, 16.5018, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 33, 468, -62.4271, 2500.3254, 16.0585, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 34, 468, -65.0478, 2507.6396, 16.0585, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 35, 468, -65.5774, 2504.7551, 16.0585, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 36, 468, -65.0858, 2501.9006, 16.0585, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 37, 469, -74.6626, 2505.0864, 16.3266, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 38, 500, -51.8093, 2478.6072, 16.4810, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 39, 500, -56.3265, 2478.7251, 16.4810, 0.0000);
	return 1;
}