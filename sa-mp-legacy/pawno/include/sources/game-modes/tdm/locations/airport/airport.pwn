/*

	About: TDM Airport location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		TDM_Airport_CreateElements(session_id)
		TDM_Airport_VehSetSettings(vehicleid)
		TDM_Airport_AirWeaponTimer(session_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_LOC_AIRPORT
	#endinput
#endif
#define _INC_TDM_LOC_AIRPORT

/*

	* Vars *

*/

static const
	Float:WeaponAirCoord[15][3] = {
	/*0*/	{-1690.1676, -531.9948, 14.1484},
	/*1*/	{-1687.2960, -212.7648, 14.1484},
	/*2*/	{-1492.3505, -162.5066, 14.1484},
	/*3*/	{-1320.5916, -8.1501, 14.1484},
	/*4*/	{-1334.9513, -155.0330, 14.1484},
	/*5*/	{-1202.2651, -299.7994, 14.1484},
	/*6*/	{-1175.1692, -358.5218, 14.1440},
	/*7*/	{-1219.9542, -463.9906, 14.1484},
	/*8*/	{-1377.0194, -422.6200, 14.1440},
	/*9*/	{-1480.1072, -437.5554, 6.8977},
	/*10*/	{-1554.3070, -364.7477, 6.9067},
	/*11*/	{-1287.6537, -405.6176, 14.1440},
	/*12*/	{-1199.2141, -201.5787, 14.1484},
	/*13*/	{-1213.5291, 26.1940, 14.1484},
	/*14*/	{-1548.3488, -614.8937, 14.1484}
};

static const
	WeaponAirPriority[4][8] = {
	/*0*/	{0, 1, 2, 3, 12, 13, 14},
	/*1*/	{4, 5, 6, 7},
	/*2*/	{0, 1, 2, 3, 8, 9, 10, 11},
	/*3*/	{12, 13, 14, 4, 5, 6, 7}
	};

static const
	WeaponAirPriorityCount[4] = {7, 4, 8, 7};

/*

	* Functions *

*/

stock TDM_Airport_CreateElements(session_id)
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
	TDM_SetTeamChet(session_id, TDM_TEAM_MILITARY, 0, 2500);
	TDM_SetTeamChet(session_id, TDM_TEAM_REBEL, 0, 2500);

	// Время
	TDM_SetTimer(session_id, 20, 0);

	// Лучшие игроки
	TDM_SetSpawnTopBot(session_id, 0, -1168.3767, -274.9376, 14.1484, 68.5738);
	TDM_SetSpawnTopBot(session_id, 1, -1165.9050, -273.0405, 14.1484, 96.1473);
	TDM_SetSpawnTopBot(session_id, 2, -1163.8888, -277.0248, 14.1484, 103.0407);
	TDM_SetSpawnTopBot(session_id, 3, -1162.2628, -270.9858, 14.1440, 94.2673);
	TDM_SetSpawnTopBot(session_id, 4, -1160.0897, -279.4976, 14.1484, 90.8206);

	// Камера в конце матча
	TDM_SetCameraEndPos(session_id, 
		-1234.053344, -160.941665, 26.267044, 
		-1234.158691, -165.636001, 24.548885);
	TDM_SetCameraEndLookAt(session_id, 
		-1232.185058, -77.700927, 56.733654, 
		-1232.290405, -82.395271, 55.015495);
	TDM_SetCameraEndPosTwo(session_id, 
		-1184.558715, -276.270446, 15.463514, 
		-1179.560058, -276.264129, 15.350243);

	// Зона локации
	TDM_SetExitZonePos(session_id, -1780.0, -708.0, -1059.0, 356.0);

	// Базы команд
	TDM_CreateBaseTeam(session_id, TDM_TEAM_MILITARY, -1492.0, -697.5, -1225.0, -495.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_MILITARY, -1277.947265, -591.610534, 31.265817, -1282.489868, -593.422973, 30.226829);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 0, -1321.1002, -626.3129, 14.1440);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 1, -1338.2107, -626.3992, 14.1440);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 2, -1357.0900, -626.5923, 14.1484);

	TDM_CreateBaseTeam(session_id, TDM_TEAM_REBEL, -1467.0, -22.5, -1267.0, 185.5);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_REBEL, -1448.086791, -47.144100, 30.983095, -1446.234375, -42.740242, 29.508480);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 0, -1430.5302, 5.6994, 14.1484);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 1, -1427.8984, 9.0066, 14.1484);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 2, -1426.0576, 13.3216, 14.1484);

	// Точки
	TDM_CreateCapturePoint(session_id, 0, "Центр", -1226.6515, -215.5127, 14.4521, -1258.0, -282.5, -1139.0, -169.5);
	TDM_SetCameraCapturePoint(session_id, 0, -1219.314575, -175.978073, 28.438119, -1220.160888, -180.625320, 26.798948);
	TDM_SetSpawnCapturePoint(session_id, 0, 0, -1207.5579, -231.6659, 14.1484);
	TDM_SetSpawnCapturePoint(session_id, 0, 1, -1243.6300, -206.7113, 14.1440);
	TDM_SetSpawnCapturePoint(session_id, 0, 2, -1248.7437, -229.8036, 14.1484);

	TDM_CreateCapturePoint(session_id, 1, "Вход", -1508.7021, -393.7450, 7.3813, -1554.0, -434.5, -1435.0, -321.5);
	TDM_SetCameraCapturePoint(session_id, 1, -1511.250610, -349.446716, 30.169897, -1510.937988, -353.934204, 27.987100);
	TDM_SetSpawnCapturePoint(session_id, 1, 0, -1489.1442, -371.4198, 15.4122);
	TDM_SetSpawnCapturePoint(session_id, 1, 1, -1531.9280, -381.0473, 10.1533);
	TDM_SetSpawnCapturePoint(session_id, 1, 2, -1513.9098, -417.7115, 7.0173);

	// Мешки с деньгами
	TDM_CreateBagMoney(session_id, TDM_TEAM_MILITARY, -1448.6886, -689.9402, 14.1812);
	TDM_CreateBagMoney(session_id, TDM_TEAM_REBEL, -1372.4095, 133.8545, 14.1484);

	// Магазины
	TDM_CreateShop(session_id, TDM_TEAM_MILITARY, -1341.9039, -612.2584, 14.1484);
	TDM_CreateShop(session_id, TDM_TEAM_REBEL, -1417.5964, -0.4539, 14.1484);

	// Транспорт
	TDM_SetVehicle(session_id, true);
	CreateVehicleLoccation(session_id);

	// Airs
	TDM_SetAirDropWeapon(session_id, true);
	return 1;
}

stock TDM_Airport_VehSetSettings(vehicleid)
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

stock TDM_Airport_AirWeaponTimer(session_id)
{
	new
		virtualworld = Mode_GetVirtualWorld(MODE_TDM, session_id),
		interior = Mode_GetInterior(MODE_TDM, session_id);

	new
		index_priority_id = TDM_GetWeaponAirBextPriority(session_id) - 1;

	n_for(i, WeaponAirPriorityCount[index_priority_id]) {
		new
			weapon_air = WeaponAirPriority[index_priority_id][i];
	
		if(!TDM_IsValidAirWeapon(session_id, weapon_air)) {
			SetAirWeapon(session_id, weapon_air, 
			WeaponAirCoord[weapon_air][0], WeaponAirCoord[weapon_air][1], WeaponAirCoord[weapon_air][2], 
			virtualworld, interior);
		}
	}

	if(index_priority_id + 2 > sizeof(WeaponAirPriorityCount))
		TDM_SetWeaponAirNextPriority(session_id, 0);

	return 1;
}

static CreateVehicleLoccation(session_id)
{
	// Нейтралы
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 0, 550, -1258.9934, 164.5934, 13.9311, -215.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 1, 561, -1282.2468, -19.7140, 13.9285, -69.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 2, 562, -1314.8669, -182.5691, 13.7743, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 3, 565, -1147.7938, -174.9570, 13.7163, 91.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 4, 566, -1215.9065, -293.0107, 13.8304, 113.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 5, 573, -1299.2819, -361.6685, 14.6140, 120.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 6, 568, -1194.0287, -459.6021, 13.7895, -149.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 7, 585, -1388.0508, -217.4241, 13.7043, -69.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 8, 589, -1480.0157, -193.0722, 13.7308, 20.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 9, 602, -1588.0975, -204.8042, 13.8696, -14.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 10, 603, -1676.1160, -273.7426, 13.8994, 127.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 11, 461, -1631.9336, -407.7329, 13.6192, -120.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 12, 487, -1657.0256, -571.2980, 14.2044, -105.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 13, 445, -1601.0874, -673.2568, 13.9330, -44.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 14, 451, -1557.3887, -407.8419, 5.3353, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 15, 480, -1417.8420, -375.9248, 14.0532, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_NONE, 16, 470, -1439.3694, -547.6930, 13.8657, -164.0000);

	// Военные
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 17, 470, -1434.3866, -546.3400, 13.8657, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 18, 470, -1429.6586, -545.0541, 13.8657, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 19, 470, -1424.8029, -543.6694, 13.8657, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 20, 470, -1420.3656, -542.3866, 13.8657, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 21, 470, -1364.9319, -527.9664, 13.8657, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 22, 470, -1359.9297, -526.6636, 13.8657, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 23, 470, -1355.2483, -525.3157, 13.8657, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 24, 470, -1350.3229, -523.9161, 13.8657, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 25, 470, -1345.6566, -522.5847, 13.8657, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 26, 432, -1400.3252, -539.7975, 14.0792, -142.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 27, 432, -1382.0547, -534.9199, 14.0792, -178.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 28, 433, -1393.0472, -539.2227, 14.5174, -171.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 29, 433, -1387.4178, -538.3652, 14.5174, -164.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 30, 470, -1246.0654, -597.4921, 13.8657, 105.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 31, 470, -1244.8448, -602.2195, 13.8657, 105.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 32, 470, -1243.3931, -606.9935, 13.8657, 105.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 33, 470, -1242.1066, -611.8243, 13.8657, 105.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 34, 470, -1247.3987, -592.8828, 13.8657, 105.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 35, 470, -1237.3506, -634.5561, 13.8657, 76.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 36, 470, -1238.5897, -639.4594, 13.8657, 76.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 37, 470, -1239.8519, -644.5791, 13.8657, 76.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 38, 470, -1240.9905, -649.4224, 13.8657, 76.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 39, 470, -1242.1278, -654.7349, 13.8657, 76.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 40, 557, -1332.7662, -667.6361, 14.1877, -178.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 41, 557, -1349.9497, -667.5859, 14.1877, -178.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 42, 560, -1304.8856, -661.8819, 13.7232, -11.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 43, 568, -1305.5203, -639.3546, 13.8984, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 44, 560, -1304.8323, -654.3561, 13.7232, -11.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 45, 560, -1304.6788, -646.7095, 13.7232, -11.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 46, 599, -1377.9852, -639.9034, 14.2386, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 47, 563, -1396.5402, -648.3986, 15.9613, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 48, 563, -1282.1163, -647.0283, 15.9805, 0.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_MILITARY, 49, 411, -1377.7814, -656.0976, 13.7981, 0.0000);

	// Повстанцы
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 50, 402, -1427.3541, 18.3950, 13.8068, -120.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 51, 402, -1423.8298, 21.8335, 13.8068, -120.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 52, 402, -1420.4270, 25.6890, 13.8068, -120.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 53, 402, -1437.5206, 8.4466, 13.8068, -156.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 54, 402, -1441.1892, 4.6568, 13.8068, -156.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 55, 402, -1445.2806, 0.7252, 13.8068, -156.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 56, 563, -1383.1045, 51.9305, 16.3806, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 57, 563, -1470.3691, -35.5788, 16.3699, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 58, 424, -1418.7229, 82.2442, 13.8167, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 59, 424, -1414.9122, 85.8226, 13.8167, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 60, 424, -1411.3630, 89.1565, 13.8167, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 61, 424, -1408.1021, 92.2286, 13.8167, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 62, 424, -1404.8710, 95.1149, 13.8167, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 63, 422, -1514.6021, -11.6232, 13.9791, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 64, 578, -1509.1260, -4.6395, 14.5927, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 65, 422, -1511.0060, -8.3472, 13.9791, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 66, 587, -1505.6245, -2.1068, 13.8276, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 67, 587, -1502.1796, 1.4965, 13.8276, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 68, 557, -1476.4244, 26.7310, 14.1366, 135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 69, 549, -1445.0461, 57.5484, 13.8197, -47.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 70, 558, -1476.9432, -1.6876, 13.6902, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 71, 558, -1477.8191, 4.8657, 13.6946, 47.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 72, 558, -1416.8119, 58.3178, 13.7087, -135.0000);
	TDM_CreateVehicle(session_id, TDM_TEAM_REBEL, 73, 558, -1423.6687, 59.2186, 13.6937, 47.0000);
	return 1;
}
