/*

	About: TDM Village location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		TDM_Village_CreateElements(session_id)
		TDM_Village_VehSetSettings(vehicleid)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_LOC_VILLAGE
	#endinput
#endif
#define _INC_TDM_LOC_VILLAGE

/*

	* Functions *

*/

stock TDM_Village_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_TDM, session_id, Mode_GetBasicVirtualWorld(MODE_TDM, session_id));
	Mode_SetInterior(MODE_TDM, session_id, Mode_GetBasicInterior(MODE_TDM, session_id));
	
	// Погода
	Mode_SetWeather(MODE_TDM, session_id, 0);

	// Команды
	TDM_AddTeam(session_id, TDM_TEAM_MILITARY, true);
	TDM_AddTeam(session_id, TDM_TEAM_REBEL, false);

	// Счёт
	TDM_SetTeamChet(session_id, TDM_TEAM_MILITARY, 3, 3);
	TDM_SetTeamChet(session_id, TDM_TEAM_REBEL, 3, 3);

	// Время
	TDM_SetTimer(session_id, 20, 0);

	// Лучшие игроки
	TDM_SetSpawnTopBot(session_id, 0, -2402.1113, 2332.4780, 4.9844, 12.5336);
	TDM_SetSpawnTopBot(session_id, 1, -2399.1506, 2331.9771, 4.9844, 13.4735);
	TDM_SetSpawnTopBot(session_id, 2, -2403.5195, 2329.9368, 4.9844, 11.5935);
	TDM_SetSpawnTopBot(session_id, 3, -2395.7351, 2329.8364, 4.9844, 13.7869);
	TDM_SetSpawnTopBot(session_id, 4, -2403.7979, 2328.9851, 4.9844, 16.6069);

	// Камера в конце матча
	TDM_SetCameraEndPos(session_id, 
		-2381.519775, 2382.202880, 7.308733, 
		-2383.801025, 2378.735107, 4.521088);
	TDM_SetCameraEndLookAt(session_id, 
		-2348.792236, 2431.948486, 47.297271, 
		-2351.073486, 2428.480712, 44.509628);
	TDM_SetCameraEndPosTwo(session_id, 
		-2402.455078, 2347.967041, 5.865367, 
		-2401.626464, 2343.038818, 6.025496);

	// Зона локации
	TDM_SetExitZonePos(session_id, -2654.0, 2185.0, -2166.0, 2557.0);

	// Базы команд
	TDM_CreateBaseTeam(session_id, TDM_TEAM_MILITARY, -2345.0, 2222.5, -2193.0, 2378.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_MILITARY, -2280.572021, 2257.641113, 19.862329, -2278.521972, 2261.921386, 18.28875);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 0, -2272.4468, 2289.2644, 4.8202);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 1, -2273.5935, 2305.3271, 4.8202);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 2, -2276.5022, 2323.2368, 4.9687);

	TDM_CreateBaseTeam(session_id, TDM_TEAM_REBEL, -2659.0, 2238.5, -2574.0, 2417.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_REBEL, -2620.433105, 2337.044433, 18.651931, -2619.822753, 2332.433105, 16.817903);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 0, -2621.7336, 2293.0354, 8.2887);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 1, -2621.5317, 2306.6819, 8.2813);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 2, -2620.4482, 2300.2493, 8.2813);

	// Компьютеры
	TDM_CreateComputer(session_id, TDM_TEAM_MILITARY, 0, -2484.3323, 2530.0037, 18.0812);
	TDM_CreateComputer(session_id, TDM_TEAM_MILITARY, 1, -2363.9675, 2389.9050, 6.7877);
	TDM_CreateComputer(session_id, TDM_TEAM_MILITARY, 2, -2446.3311, 2250.1360, 4.9499);

	// Магазины
	TDM_CreateShop(session_id, TDM_TEAM_MILITARY, -2280.9236, 2294.7451, 4.9606);
	TDM_CreateShop(session_id, TDM_TEAM_REBEL, -2622.9436, 2311.7607, 8.2813);

	// Транспорт
	TDM_SetVehicle(session_id, true);
	CreateVehicleLoccation(session_id);
	return 1;
}

stock TDM_Village_VehSetSettings(vehicleid)
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
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 0, 478, -2419.4331, 2482.2659, 12.8531, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 1, 542, -2549.4468, 2391.8645, 14.4319, 135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 2, 549, -2472.7390, 2283.6028, 4.6557, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 3, 557, -2496.7939, 2286.4951, 5.0171, 0.0000);

	// Военные
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 4, 427, -2252.6987, 2288.1069, 4.8061, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 5, 471, -2263.5779, 2284.4116, 4.1940, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 6, 471, -2260.8184, 2284.4116, 4.1940, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 7, 497, -2227.6555, 2326.7446, 7.6467, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 8, 528, -2251.6304, 2297.0239, 4.7977, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 9, 568, -2214.8083, 2349.2556, 4.6789, 40.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 10, 470, -2251.6680, 2309.0188, 4.5417, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 11, 470, -2251.6680, 2317.9580, 4.5417, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 12, 470, -2251.6680, 2326.9431, 4.5417, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 13, 470, -2251.6680, 2336.0688, 4.5417, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 14, 424, -2251.2546, 2303.0354, 4.4669, 90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 15, 430, -2325.6416, 2300.0610, 0.6345, 900.0000);

	// Повстанцы
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 16, 487, -2620.1519, 2263.4880, 10.0566, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 17, 559, -2627.1318, 2280.3767, 7.8635, -69.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 18, 559, -2627.1318, 2287.9399, 7.8635, -69.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 19, 562, -2633.5549, 2291.9238, 7.9442, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 20, 402, -2627.3228, 2315.6909, 7.9850, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 21, 406, -2634.9783, 2324.7820, 9.5896, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 22, 413, -2634.9297, 2319.5298, 8.3711, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 23, 413, -2634.7463, 2329.8921, 8.4251, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 24, 562, -2633.5549, 2283.9700, 7.9442, -90.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 25, 463, -2609.1606, 2285.6121, 7.8348, 62.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 26, 495, -2608.2085, 2316.4561, 8.5619, 0.0000);
	return 1;
}
