/*
 * |>==============================<|
 * |   About: TDM Desert location   |
 * |   Author: Foxze                |
 * |>==============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnPlayerDeath(playerid, killerid, WEAPON:reason)
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
 * Stock:
	- TDM_Desert_Init()
	- TDM_Desert_CreateElements(sessionid)
	- TDM_Desert_CreateAE(sessionid)
	- TDM_Desert_DestroyAE(sessionid)
	- TDM_Desert_SetPlayerKeyDPickup(playerid, pickupid)
	- TDM_Desert_SetPlayerKeyOPickup(playerid, pickupid)
	- TDM_Desert_SetPlayerKey3DText(playerid, textid)
	- TDM_Desert_UpdateAE(sessionid)
	- TDM_Desert_UpdatePlayerAE(playerid)
	- TDM_Desert_UpdatePlayerMG(playerid)
	- TDM_Desert_SetPlKeyMode3DText(playerid, p_3dtext, textid)
	- TDM_Desert_CheckStartFastPoint(sessionid)
	- TDM_Desert_AirWeaponTimer(sessionid)
	- TDM_Desert_AirBombTimer(sessionid)
	- TDM_Desert_SetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
	- TDM_Desert_ResetPlayerMG(playerid)
	- TDM_Desert_VehSetSettings(vehicleid)
	- TDM_Desert_CallAccode(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_TDM_AE_LOC_DESERT
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- TDM_Desert_BuyC4
	- TDM_Desert_Nuc
	- TDM_Desert_Accode
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_TDM_LOC_DESERT
	#endinput
#endif
#define _INC_TDM_LOC_DESERT

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

/*
 * |>---------------<|
 * |   AE location   |
 * |>---------------<|
 */

// Objects
enum {
	tdm_des_oCrane = 0,
	tdm_des_oCrane_2,
	tdm_des_oCraneC4,

	tdm_des_oBridge,
	tdm_des_oBridge_2,
	tdm_des_oBridgeC41,
	tdm_des_oBridgeC42,
	tdm_des_oBridgeC43,
	tdm_des_oBridgeHill1,
	tdm_des_oBridgeHill2,
	tdm_des_oBridgeHill3,
	tdm_des_oBridgeHill4,

	tdm_des_oSputnikDoorStart,
	tdm_des_oSputnikDoorStartC41,
	tdm_des_oSputnikDoorStartC42,

	tdm_des_oSputnik1Plattform,
	tdm_des_oSputnik1UnsichWand1,
	tdm_des_oSputnik1UnsichWand2,
	tdm_des_oSputnik1UnsichWand3,
	tdm_des_oSputnik1UnsichWand4,
	tdm_des_oSputnik1UnsichWand5,
	tdm_des_oSputnik1UnsichWand6,
	tdm_des_oSputnik1Ballon,
	tdm_des_oSputnik1Column1,
	tdm_des_oSputnik1Column2,
	tdm_des_oSputnik1Column3,
	tdm_des_oSputnik1Column4,
	tdm_des_oSputnik1Flame,

	tdm_des_oSputnik2Plattform,
	tdm_des_oSputnik2UnsichWand1,
	tdm_des_oSputnik2UnsichWand2,
	tdm_des_oSputnik2UnsichWand3,
	tdm_des_oSputnik2UnsichWand4,
	tdm_des_oSputnik2UnsichWand5,
	tdm_des_oSputnik2UnsichWand6,
	tdm_des_oSputnik2Ballon,
	tdm_des_oSputnik2Column1,
	tdm_des_oSputnik2Column2,
	tdm_des_oSputnik2Column3,
	tdm_des_oSputnik2Column4,
	tdm_des_oSputnik2Flame,

	tdm_des_oNucRocket,
	tdm_des_oNucRocketWing1,
	tdm_des_oNucRocketWing2,
	tdm_des_oNucRocketWing3,
	tdm_des_oNucRocketFlame,

	tdm_des_oNucRebelHill1,
	tdm_des_oNucRebelHill2,
	tdm_des_oNucRebelHill3,
	tdm_des_oNucRebelHill4,
	tdm_des_oNucRebelHill5,
	tdm_des_oNucRebelHill6,
	tdm_des_oNucRebelHill7,
	tdm_des_oNucRebelHill8,
	tdm_des_oNucRebelHill9,
	tdm_des_oNucRebelHill10,

	tdm_des_oNucMilitaryHill1,
	tdm_des_oNucMilitaryHill2,
	tdm_des_oNucMilitaryHill3,
	tdm_des_oNucMilitaryHill4,
	tdm_des_oNucMilitaryHill5,
	tdm_des_oNucMilitaryHill6,

	tdm_des_oLast // Last ID AE Object
}

// 3DTexts
enum {
	tdm_des_3dCraneC4 = 0,
	tdm_des_3dBridgeDetonator,
	tdm_des_3dBridgeDetonator2,
	tdm_des_3dSputnikStart,
	tdm_des_3dSubmarineNucStart,

	tdm_des_3dLast // Last ID AE 3DText
}

// Pickup Doors
enum {
	tdm_des_pdEnterCrane = 0,
	tdm_des_pdExitCrane,
	tdm_des_pdEnterHillC4,
	tdm_des_pdExitHillC4,
	tdm_des_pdEnterSubmarine,
	tdm_des_pdExitSubmarine,

	tdm_des_pdLast // Last ID AE Pickup Door
}

// Pickup Others
enum {
	tdm_des_opCraneParachute = 0,
	tdm_des_opCraneC4,
	tdm_des_opHillC4,
	tdm_des_opHillParachute,
	tdm_des_opBridgeC41,
	tdm_des_opBridgeC42,
	tdm_des_opBridgeC43,
	tdm_des_opDoorStartSputC4,

	tdm_des_opLast // Last ID AE Pickup Other
}

// Map Icons
enum {
	tdm_des_miHillC4 = 0,
	tdm_des_miSubmarine,
	tdm_des_miPosDropNuc,

	tdm_des_miLast // Last ID AE Map Icon
}

/*
 * |>--------------------------<|
 * |   AE location for player   |
 * |>--------------------------<|
 */

// Values
enum {
	tdm_des_pvAccodeStatus = 0,
	tdm_des_pvAccodeTimer,
	tdm_des_pvAccodeAttach,

	tdm_des_pvLast // Last ID AE Player Value
}

// Floats
enum {
	tdm_des_pfPosAccode = 0,

	tdm_des_pfLast // Last ID AE Player Float
}

// Objects
enum {
	tdm_des_poAccodeSmoke = 0,
	tdm_des_poAccodeParachute,

	tdm_des_poLast // Last ID AE Player Object
}

// 3D Texts
enum {
	tdm_des_ptAccodeDrop = 0,

	tdm_des_ptLast // Last ID AE Player 3DText
}

// Mini Games
enum {
	tdm_des_pgStartSputnik = 1,

	tdm_des_pgLast // Last ID AE Player Mini Game
}

/*
 * |>----------------------<|
 * |   Others AE location   |
 * |>----------------------<|
 */

enum E_TDM_AE_LOC_DESERT {
	e_SputnikDoorCountC4,
	e_SputnikDoorStatus,
	e_SputnikDoorTimer,
	bool:e_SputnikLaunchStatus,
	e_SputnikTeamActive[TDM_MAX_TEAMS],

	e_NucMisStatus,
	e_NucMisTimer,
	e_NucMisStartTeam,
	e_NucMisTeamActive[TDM_MAX_TEAMS],

	e_BridgeCountC4,
	e_BridgeTimer,
	e_BridgeStatus,

	e_CraneStatus,
	e_CraneTimer,
	e_TimeStorm
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	AEInfo[GMS_MAX_SESSIONS][E_TDM_AE_LOC_DESERT];

/*
 * |>------------------<|
 * |   Airdrop weapon   |
 * |>------------------<|
 */

static const
	Float:WeaponAirCoord[24][3] = {
	/*0*/	{-42.9905, 2022.0603, 17.6406},
	/*1*/	{-30.1462, 2428.6406, 16.1953},
	/*2*/	{193.9620, 2510.2236, 16.5368},
	/*3*/	{36.5517, 2019.6238, 17.6406},
	/*4*/	{447.5320, 2314.8003, 36.7641},
	/*5*/	{164.9228, 2348.4604, 16.2075},
	/*6*/	{-502.8551, 2531.6807, 53.5156},
	/*7*/	{253.2521, 2116.5681, 17.2800},
	/*8*/	{362.5110, 2407.1106, 16.4844},
	/*9*/	{-918.5957, 2739.0713, 46.2109},
	/*10*/	{-1526.0316, 2635.8394, 55.8359},
	/*11*/	{142.3264, 1697.5404, 17.6406},
	/*12*/	{249.9779, 2382.3660, 16.4844},
	/*13*/	{-43.2763, 2359.3806, 29.5050},
	/*14*/	{-414.9455, 2207.1455, 42.4297},
	/*15*/	{-607.4191, 2040.8291, 60.3828},
	/*16*/	{-801.7055, 2042.4430, 60.3818},
	/*17*/	{-100.8875, 2565.8274, 18.3414},
	/*18*/	{45.0191, 2588.0762, 16.4921},
	/*19*/	{-123.7685, 1165.8707, 19.7422},
	/*20*/	{-240.6348, 1086.6826, 19.7422},
	/*21*/	{205.8126, 2590.3040, 16.4152},
	/*22*/	{316.7929, 2644.9546, 16.1929},
	/*23*/	{359.5221, 2534.1997, 16.6933}
	};

static const
	WeaponAirPriority[5][14] = {
	/*0*/	{0, 1, 2, 3, 9, 10, 11, 12, 13},
	/*1*/	{4, 5, 6, 7, 8, 14, 15, 16, 17, 18},
	/*2*/	{0, 1, 2, 3, 9, 10, 11, 12, 13, 19, 20, 21, 22, 23},
	/*3*/	{4, 5, 6, 7, 8, 14, 15, 16, 17, 18},
	/*4*/	{0, 1, 2, 3, 9, 10, 11, 12, 13, 19, 20, 21, 22, 23}
	};

static const
	WeaponAirPriorityCount[5] = {9, 10, 14, 10};

/*
 * |>------------<|
 * |   Air bomb   |
 * |>------------<|
 */

static const
	Float:BombAirCoord[18][3] = {
	/*0*/	{267.0777, 2484.9954, 16.4844},
	/*1*/	{247.9302, 2499.8384, 16.4844},
	/*2*/	{241.7020, 2523.2134, 16.7200},
	/*3*/	{201.1266, 2554.1682, 16.5940},
	/*4*/	{177.3073, 2522.5918, 16.7430},
	/*5*/	{144.9922, 2484.1042, 16.4844},
	/*6*/	{140.1063, 2436.5557, 16.4766},
	/*7*/	{173.5551, 2391.2983, 16.4844},
	/*8*/	{210.4270, 2418.3359, 16.4766},
	/*9*/	{259.4088, 2449.9722, 16.4844},
	/*10*/	{337.0767, 2420.6055, 16.5395},
	/*11*/	{111.0147, 2485.1770, 16.4922},
	/*12*/	{55.4425, 2507.0901, 16.4844},
	/*13*/	{91.4414, 2533.3428, 16.6060},
	/*14*/	{34.6625, 2553.0330, 16.5632},
	/*15*/	{19.3580, 2488.4146, 16.4922},
	/*16*/	{34.6625, 2553.0330, 16.5632},
	/*17*/	{60.7352, 2351.7537, 17.8009}
	};

static const
	BombAirPriority[8][3] = {
	/*0*/	{0, 1, 2},
	/*1*/	{3, 4},
	/*2*/	{5, 6},
	/*3*/	{7, 8},
	/*4*/	{9, 10},
	/*5*/	{11, 12},
	/*6*/	{13, 14},
	/*7*/	{15, 16, 17}
	};

static const
	BombAirPriorityCount[8] = {3, 2, 2, 2, 2, 2, 3};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock TDM_Desert_Init()
{
	Mode_AddLocation(MODE_TDM, TDM_LOC_DESERT, "Пустыня");
	Mode_SetLocationInfo(MODE_TDM, TDM_LOC_DESERT, "-");

	Mode_SetLocationGameMode(MODE_TDM, TDM_LOC_DESERT, TDM_GAME_MODE_CAPTURE);
	Mode_SetLocationWeather(MODE_TDM, TDM_LOC_DESERT, 0);
	Mode_SetLocationMinutes(MODE_TDM, TDM_LOC_DESERT, 30);
	Mode_SetLocationSeconds(MODE_TDM, TDM_LOC_DESERT, 0);
	Mode_SetLocationInterior(MODE_TDM, TDM_LOC_DESERT, 0);
	return 1;
}

stock TDM_Desert_CreateElements(sessionid)
{
	// Teams
	TDM_AddTeam(sessionid, TDM_TEAM_MILITARY, true);
	TDM_AddTeam(sessionid, TDM_TEAM_REBEL, true);

	// Score
	TDM_SetTeamScore(sessionid, TDM_TEAM_MILITARY, 0, 5000);
	TDM_SetTeamScore(sessionid, TDM_TEAM_REBEL, 0, 5000);

	// TOP players
	TDM_SetSpawnTopActor(sessionid, 0, 196.32857, 2475.43604, 16.45367, 6.8112);
	TDM_SetSpawnTopActor(sessionid, 1, 195.54019, 2474.86890, 16.45367, 6.8112);
	TDM_SetSpawnTopActor(sessionid, 2, 197.45180, 2474.30249, 16.45367, 6.8112);
	TDM_SetSpawnTopActor(sessionid, 3, 194.31660, 2473.62231, 16.45367, 6.8112);
	TDM_SetSpawnTopActor(sessionid, 4, 198.91211, 2472.33813, 16.45367, 6.8112);

	// Camera end match
	TDM_SetCameraEndPos(sessionid,
		107.932250, 2502.225341, 29.646366, 
		102.999031, 2502.215576, 28.831947);
	TDM_SetCameraEndLookAt(sessionid,
		164.952621, 2502.338867, 39.059833, 
		160.019409, 2502.329101, 38.245414);
	TDM_SetCameraEndPosTwo(sessionid,
		195.996307, 2480.556152, 16.584621, 
		196.222152, 2475.561523, 16.542434);

	// Exit zone
	TDM_SetExitZonePos(sessionid, -1636.0, 1016.0, 820.0, 3000.0);

	// Base team
	TDM_CreateBaseTeam(sessionid, TDM_TEAM_MILITARY, 77.0, 1774.5, 419.0, 2107.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_MILITARY, 270.663909, 1941.726684, 33.320667, 275.561248, 1941.804077, 32.315582);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 0, 370.3253, 1953.1808, 17.6406);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 1, 369.9148, 1989.7644, 17.6406);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_MILITARY, 2, 368.8501, 1901.5978, 17.6406);

	TDM_CreateBaseTeam(sessionid, TDM_TEAM_REBEL, -373.0, 2571.5, -129.0, 2816.5);
	TDM_SetCameraBaseTeam(sessionid, TDM_TEAM_REBEL, -187.079696, 2730.565917, 78.506530, -190.508651, 2727.300781, 76.900115);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 0, -227.3568, 2693.4761, 62.6875);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 1, -222.4010, 2693.0413, 62.6875);
	TDM_SetSpawnBaseTeam(sessionid, TDM_TEAM_REBEL, 2, -217.9580, 2693.8604, 62.6875);

	// Capture point
	TDM_CreateCapturePoint(sessionid, 0, "Точка связи", -302.4767, 1569.2217, 75.3594, -409.0, 1497.5, -244.0, 1639.5);
	TDM_SetCameraCapturePoint(sessionid, 0, -264.606475, 1570.758666, 90.658561, -269.280853, 1570.619873, 88.889152);
	TDM_SetSpawnCapturePoint(sessionid, 0, 0, -315.9427, 1547.5751, 75.5625);
	TDM_SetSpawnCapturePoint(sessionid, 0, 1, -334.0713, 1535.0952, 75.5625);
	TDM_SetSpawnCapturePoint(sessionid, 0, 2, -359.1111, 1509.3750, 75.5625);

	TDM_CreateCapturePoint(sessionid, 1, "Холм", -786.6165, 2423.8970, 157.1736, -841.0, 2369.5, -741.0, 2469.5);
	TDM_SetCameraCapturePoint(sessionid, 1, -750.102355, 2411.944824, 167.846435, -754.677673, 2413.341064, 166.391647);
	TDM_SetSpawnCapturePoint(sessionid, 1, 0, -805.3485, 2446.1904, 157.0099);
	TDM_SetSpawnCapturePoint(sessionid, 1, 1, -795.1803, 2388.6482, 154.7446);
	TDM_SetSpawnCapturePoint(sessionid, 1, 2, -808.9329, 2354.0171, 150.3425);

	TDM_CreateCapturePoint(sessionid, 2, "Завод", 188.1856, 1414.8960, 10.5859, 98.0, 1330.5, 296.0, 1492.5);
	TDM_SetCameraCapturePoint(sessionid, 2, 208.714508, 1436.979492, 22.991571, 205.547164, 1433.625610, 21.063016);
	TDM_SetSpawnCapturePoint(sessionid, 2, 0, 183.7255, 1449.3325, 10.5912);
	TDM_SetSpawnCapturePoint(sessionid, 2, 1, 151.1145, 1429.8418, 10.5912);
	TDM_SetSpawnCapturePoint(sessionid, 2, 2, 191.3027, 1364.7394, 10.5859);

	TDM_CreateCapturePoint(sessionid, 3, "Посёлок", -1480.3412, 2628.8938, 58.7813, -1620.0, 2508.5, -1413.0, 2720.5);
	TDM_SetCameraCapturePoint(sessionid, 3, -1509.667846, 2690.689697, 76.6040958, -1508.293334, 2686.207031, 74.867118);
	TDM_SetSpawnCapturePoint(sessionid, 3, 0, -1456.9384, 2637.8655, 55.8359);
	TDM_SetSpawnCapturePoint(sessionid, 3, 1, -1516.1038, 2647.0801, 55.8359);
	TDM_SetSpawnCapturePoint(sessionid, 3, 2, -1495.1565, 2694.4475, 55.8359);

	TDM_CreateCapturePoint(sessionid, 4, "Городок", -156.7254, 1128.6364, 19.7422, -286.0, 1059.5, 37.0, 1212.5);
	TDM_SetCameraCapturePoint(sessionid, 4, -125.082633, 1149.019287, 38.87693, -128.990310, 1146.647216, 36.851215);
	TDM_SetSpawnCapturePoint(sessionid, 4, 0, -137.3072, 1127.5858, 19.7500);
	TDM_SetSpawnCapturePoint(sessionid, 4, 1, -182.8865, 1136.6201, 19.7422);
	TDM_SetSpawnCapturePoint(sessionid, 4, 2, -164.7743, 1089.2604, 19.7422);

	TDM_CreateCapturePoint(sessionid, 5, "Забр. аэропорт", 404.8093, 2533.9197, 16.5460, 270.0, 2424.5, 454.0, 2563.5);
	TDM_SetCameraCapturePoint(sessionid, 5, 358.685333, 2503.660400, 38.952449, 362.812042, 2505.806640, 37.118423);
	TDM_SetSpawnCapturePoint(sessionid, 5, 0, 430.7227, 2537.0481, 16.2809);
	TDM_SetSpawnCapturePoint(sessionid, 5, 1, 424.0277, 2551.6064, 16.2379);
	TDM_SetSpawnCapturePoint(sessionid, 5, 2, 349.1419, 2541.6536, 16.7440);

	TDM_CreateCapturePoint(sessionid, 6, "Дамба", -702.0461, 2063.1096, 60.3828, -885.0, 1940.5, -528.0, 2123.5);
	TDM_SetCameraCapturePoint(sessionid, 6, -652.127014, 2081.228027, 80.707351, -656.539978, 2079.609130, 79.002899);
	TDM_SetSpawnCapturePoint(sessionid, 6, 0, -724.3215, 2054.2026, 60.1875);
	TDM_SetSpawnCapturePoint(sessionid, 6, 1, -723.7000, 2075.4514, 60.3828);
	TDM_SetSpawnCapturePoint(sessionid, 6, 2, -670.8249, 2067.6960, 60.1865);

	// Bags money
	TDM_CreateBagMoney(sessionid, TDM_TEAM_MILITARY, 232.4966, 1758.8607, 17.6481);
	TDM_CreateBagMoney(sessionid, TDM_TEAM_REBEL, -138.7366, 2700.9189, 62.2577);

	// Shop Teams
	TDM_CreateShopTeam(sessionid, TDM_TEAM_MILITARY, 372.5359, 1929.4442, 17.6406);
	TDM_CreateShopTeam(sessionid, TDM_TEAM_REBEL, -217.0599, 2714.7234, 62.6875);

	// Fast points
	TDM_CreatePosFastPoint(sessionid, 0, 155.6453, 2428.5925, 16.5994);
	TDM_CreatePosFastPoint(sessionid, 1, -310.1534, 1754.0260, 42.7789);
	TDM_CreatePosFastPoint(sessionid, 2, 371.2654, 2249.8960, 40.1970);
	TDM_CreatePosFastPoint(sessionid, 3, -334.1882, 1527.7136, 75.3594);
	TDM_CreatePosFastPoint(sessionid, 4, -413.3142, 2233.7168, 42.4297);

	// Vehicle
	TDM_SetActiveVehicle(sessionid, true);
	CreateVehicleLocation(sessionid);

	// Airs
	TDM_SetAirDropWeapon(sessionid, true);
	TDM_SetAirBomb(sessionid, true);
	return 1;
}

stock TDM_Desert_CreateAE(sessionid)
{
	// Number of AE
	TDM_SetNumberAE(sessionid,
		.objects = tdm_des_oLast,
		.texts3d =  tdm_des_3dLast,
		.pickupsdoor =  tdm_des_pdLast,
		.otherpickups =  tdm_des_opLast,
		.mapicons =  tdm_des_miLast,
		.actors = 0
	);

	AEInfo[sessionid][e_BridgeStatus] = 1;
	AEInfo[sessionid][e_CraneStatus] = 1;
	AEInfo[sessionid][e_TimeStorm] = (Mode_GetSessionMinutes(MODE_TDM, sessionid) / 2) - random(3);

	/* Objects */
	TDM_CreateAEObject(sessionid, tdm_des_oCrane, 1383, 258.39450, 2466.38452, 48.01590,	  0.00000, 0.00000, 0.00000); // Кран
	TDM_CreateAEObject(sessionid, tdm_des_oCrane_2, 1384, 258.34158, 2466.40576, 80.22040,   0.00000, 0.00000, 0.00000); // Кран
	TDM_CreateAEObject(sessionid, tdm_des_oBridge, 16037, -1143.6914, 2696.7832, 48.7418,   -360.1200, 0.0000, 186.5800); // Мост
	TDM_CreateAEObject(sessionid, tdm_des_oBridge_2, 16610, -1024.4032, 2710.6006, 48.4263,   -360.1200, 0.0000, 186.6800); // Мост
	TDM_CreateAEObject(sessionid, tdm_des_oSputnikDoorStart, 2634, -359.59381, 1592.23315, 77.08000,   2.00000, 0.00000, 90.00000); // Дверь запуска спутника

	// Sputniks
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1Plattform, 11420, -361.169921, 1560.450927, 74.219390, -0.900059, 0.300037, 18.999698); // Платформа спутника 1
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oSputnik1Plattform, 0, 14776, "genintintcarint3", "concretebigc256", 0x00000000);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1UnsichWand1, 19362, -363.514038, 1558.963256, 77.485519, -0.900059, 0.300037, 18.999698); // Стенка спутника 1
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik1UnsichWand1, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1UnsichWand2, 19362, -361.588592, 1558.039306, 77.481246, 0.300000, 0.900072, 108.994934); // Стенка спутника 1
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik1UnsichWand2, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1UnsichWand3, 19362, -360.500762, 1559.978759, 77.539413, -0.900059, 0.300037, 18.999698); // Стенка спутника 1
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik1UnsichWand3, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1UnsichWand4, 19362, -362.568878, 1560.885498, 77.523979, 0.300000, 0.900072, 108.994934); // Стенка спутника 1
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik1UnsichWand4, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1UnsichWand5, 19362, -362.054565, 1559.500732, 79.312828, 1.200000, -89.399818, 18.000005); // Стенка спутника 1
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik1UnsichWand5, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1UnsichWand6, 19362, -362.019348, 1559.434204, 75.740043, -0.399999, -88.899833, 18.100008); // Стенка спутника 1
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik1UnsichWand6, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1Ballon, 3054, -362.108306, 1559.581665, 76.710472, -0.900059, 180.300018, 18.999698); // Шар спутника 1
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oSputnik1Ballon, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oSputnik1Ballon, 1, 16322, "a51_stores", "wtmetal3", 0x00000000);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1Column1, 16023, -362.313659, 1560.140625, 76.281608, 14.301827, 0.216097, 19.316852); // Опора спутника 1
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1Column2, 16023, -361.890289, 1558.946533, 76.366058, 16.097709, -0.418800, -160.516418); // Опора спутника 1
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1Column3, 16023, -361.554046, 1559.682495, 76.331550, 14.891777, -1.029150, -70.361343); // Опора спутника 1
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik1Column4, 16023, -362.611846, 1559.310424, 76.269882, 15.504376, 0.831857, 109.150497); // Опора спутника 1

	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2Plattform, 11420, -371.039703, 1552.827636, 74.219390, -0.900057, 0.300044, 18.999698); // Платформа спутника 2
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oSputnik2Plattform, 0, 14776, "genintintcarint3", "concretebigc256", 0x00000000);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2UnsichWand1, 19362, -373.383819, 1551.339965, 77.485519, -0.900057, 0.300044, 18.999698); // Стенка спутника 2
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik2UnsichWand1, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2UnsichWand2, 19362, -371.458374, 1550.416015, 77.481246, 0.300007, 0.900069, 108.994911); // Стенка спутника 2
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik2UnsichWand2, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2UnsichWand3, 19362, -370.370544, 1552.355468, 77.539413, -0.900057, 0.300044, 18.999698); // Стенка спутника 2
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik2UnsichWand3, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2UnsichWand4, 19362, -372.438659, 1553.262207, 77.523979, 0.300007, 0.900069, 108.994911); // Стенка спутника 2
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik2UnsichWand4, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2UnsichWand5, 19362, -371.924346, 1551.877441, 79.312828, 1.200002, -89.399810, 18.000005); // Стенка спутника 2
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik2UnsichWand5, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2UnsichWand6, 19362, -371.889129, 1551.810913, 75.740043, -0.399996, -88.899826, 18.100008); // Стенка спутника 2
	TDM_SetAEObjectMaterialText(sessionid, tdm_des_oSputnik2UnsichWand6, 0, "None", 10, "Arial", 20, 0, 0x00000000, 0x00000000, 0);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2Ballon, 3054, -371.978088, 1551.958374, 76.710472, -0.900057, 180.300018, 18.999698); // Шар спутника 2
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oSputnik2Ballon, 0, 16322, "a51_stores", "wtmetal3", 0x00000000);
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oSputnik2Ballon, 1, 16322, "a51_stores", "wtmetal3", 0x00000000);
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2Column1, 16023, -372.183441, 1552.517333, 76.281608, 14.301829, 0.216104, 19.316846); // Опора спутника 2
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2Column2, 16023, -371.760070, 1551.323242, 76.366058, 16.097707, -0.418808, -160.516372); // Опора спутника 2
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2Column3, 16023, -371.423828, 1552.059204, 76.331550, 14.891769, -1.029148, -70.361335); // Опора спутника 2
	TDM_CreateAEObject(sessionid, tdm_des_oSputnik2Column4, 16023, -372.481628, 1551.687133, 76.269882, 15.504383, 0.831855, 109.150474); // Опора спутника 2

	// Nuclear missile
	CreateNucMis(sessionid);

	/* 3DTexts */
	adstr[0] = EOS;
	f(adstr, "{e32020}Детонатор\n\n{e3a019}Установлено взрывчаток: {c9e320}%i/3\n\n{D42C21}Нажмите {E5D110}[ ALT ]", AEInfo[sessionid][e_BridgeCountC4]);
	TDM_CreateAE3DText(sessionid, tdm_des_3dBridgeDetonator, adstr, -1, 1, -957.8976, 2725.7922, 45.9846, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Детонатор на мосту
	TDM_CreateAE3DText(sessionid, tdm_des_3dBridgeDetonator2, adstr, -1, 1, -1211.4103, 2694.7617, 46.2704, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Детонатор 2 на мосту
	TDM_CreateAE3DText(sessionid, tdm_des_3dSubmarineNucStart, "{e6c41e}Запустить ядерную ракету\n\n{D42C21}Нажмите {E5D110}[ ALT ]", -1, 1, 619.8011, 1777.0144, 1352.2152, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, 1); // Запуск ядерной ракеты в подлодке

	/* Pickups door */
	TDM_CreateAEPickupDoor(sessionid, tdm_des_pdEnterCrane, "{eb5910}Кран\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 19132, 1, 1, 258.4377, 2464.3936, 20.5422, -1, -1, 258.3066, 2460.1997, 86.0596, 355.6158, -1, -1); // Кран
	TDM_CreateAEPickupDoor(sessionid, tdm_des_pdExitCrane, "{eb5910}Выход\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 19132, 1, 1, 258.2637, 2459.1592, 86.0596, -1, -1, 258.3753, 2462.8899, 20.5422, 178.5832, -1, -1); // Кран
	TDM_CreateAEPickupDoor(sessionid, tdm_des_pdEnterHillC4, "{db541f}Холм\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 19133, 1, 1, -185.4451, 1864.0576, 51.4806, -1, -1, -181.5102, 1878.7111, 115.1974, 357.2218, -1, -1); // Холм с взрывчатками
	TDM_CreateAEPickupDoor(sessionid, tdm_des_pdExitHillC4, "{db541f}Спуск\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 19133, 1, 1, -181.7714, 1877.2783, 115.0288, -1, -1, -185.5491, 1861.8993, 51.3615, 179.1920, -1, -1); // Холм с взрывчатками
	TDM_CreateAEPickupDoor(sessionid, tdm_des_pdEnterSubmarine, "{1edce6}Подлодка\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 19133, 1, 1, 272.9376, 2985.8306, 5.6658, -1, -1, 618.5721, 1794.2104, 1352.1832, 179.3818, -1, 1); // Подлодка
	TDM_CreateAEPickupDoor(sessionid, tdm_des_pdExitSubmarine, "{1edce6}Выход\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 19133, 1, 1, 619.8766, 1792.9167, 1352.2177, -1, 1, 267.9674, 2985.8823, 6.1392, 91.2852, -1, -1); // Подлодка

	/* Pickups others */
	TDM_CreateAEOtherPickup(sessionid, tdm_des_opCraneParachute, "{0fd1d1}Парашют", 1310, 1, 0, 258.3467, 2514.7004, 86.5239, -1, -1); // Парашют для крана
	TDM_CreateAEOtherPickup(sessionid, tdm_des_opCraneC4, "{eb1010}Заложить взрывчатку\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 1654, 1, 1, 253.2200, 2465.2839, 16.4766, -1, -1); // Взрывчатка для крана
	TDM_CreateAEOtherPickup(sessionid, tdm_des_opHillC4, "{d91c1c}Взрывчатки\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 1654, 1, 1, -184.7181, 1885.6678, 115.7031, -1, -1); // Холм с взрывчатками
	TDM_CreateAEOtherPickup(sessionid, tdm_des_opHillParachute, "{0fd1d1}Парашют", 1310, 1, 0, -182.6281, 1900.0745, 114.4307, -1, -1); // Холм с взрывчатками
	TDM_CreateAEOtherPickup(sessionid, tdm_des_opBridgeC41, "{eb1010}Заложить взрывчатку\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 1654, 1, 1, -1007.0461, 2719.5740, 46.0501, -1, -1); // Взрывчатка для моста
	TDM_CreateAEOtherPickup(sessionid, tdm_des_opBridgeC42, "{eb1010}Заложить взрывчатку\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 1654, 1, 1, -1080.6251, 2696.9841, 45.8726, -1, -1); // Взрывчатка 2 для моста
	TDM_CreateAEOtherPickup(sessionid, tdm_des_opBridgeC43, "{eb1010}Заложить взрывчатку\n\n{D42C21}Нажмите {E5D110}[ ALT ]", 1654, 1, 1, -1170.3379, 2700.6296, 46.0374, -1, -1); // Взрывчатка 3 для моста
	adstr[0] = EOS;
	f(adstr, "{1ae8c6}Дверь\n\n{e3a019}Установлено взрывчаток: {c9e320}%i/2\n\n{D42C21}Нажмите {E5D110}[ ALT ]", AEInfo[sessionid][e_SputnikDoorCountC4]);
	TDM_CreateAEOtherPickup(sessionid, tdm_des_opDoorStartSputC4, adstr, 1654, 1, 1, -360.5948, 1592.2469, 76.8104, -1, -1); // Взрывчатка для двери запуска спутника

	/* MapIcons */
	TDM_CreateAEMapIcon(sessionid, tdm_des_miHillC4, -184.7181, 1885.6678, 115.7031, 36, -1, -1, -1, -1, 5000.0, MAPICON_GLOBAL); // Холм с взрывчатками
	TDM_CreateAEMapIcon(sessionid, tdm_des_miSubmarine, 255.8151, 2985.9751, 5.7037, 9, -1, -1, -1, -1, 5000.0, MAPICON_GLOBAL); // Подлодка

	/* Values */
	Mode_SetAEValue(MODE_TDM, sessionid, tdm_des_pvAccodeStatus, 0);
	Mode_SetAEFloatValues(MODE_TDM, sessionid, tdm_des_pfPosAccode, 0.0, 0.0, 0.0);
	return 1;
}

stock TDM_Desert_DestroyAE(sessionid)
{
	ResetLocationAEData(sessionid);
	return 1;
}

stock TDM_Desert_SetPlayerKeyDPickup(playerid, pickupid)
{
	#pragma unused playerid, pickupid

	return 1;
}

stock TDM_Desert_SetPlayerKeyOPickup(playerid, pickupid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	switch (pickupid) {
		// Парашют на кране
		case tdm_des_opCraneParachute: {
			GivePlayerWeaponEx(playerid, WEAPON_PARACHUTE, 1);
		}
		// Взрывчатка для крана
		case tdm_des_opCraneC4: {
			if (AEInfo[sessionid][e_CraneStatus]) {
				if (!TDM_GetPlayerExplosive(playerid)) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"У Вас нет взрывчатки!");
				}
				else {
					TDM_GivePlayerExplosive(playerid, -1);

					AEInfo[sessionid][e_CraneStatus] = 2;
					AEInfo[sessionid][e_CraneTimer] += 15;

					TDM_DestroyAEOtherPickup(sessionid, tdm_des_opCraneC4);

					ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, true, false, false, true, 0, SYNC_ALL);

					TDM_CreateAEObject(sessionid, tdm_des_oCraneC4, 1654, 253.96291, 2465.30444, 15.68820,   -16.00000, 0.00000, -90.00000); // Взрывчатка

					adstr[0] = EOS;
					f(adstr, "{d9941c}Взрыв через: {db1414}%i {d9941c}секунд", AEInfo[sessionid][e_CraneTimer]);
					TDM_CreateAE3DText(sessionid, tdm_des_3dCraneC4, adstr, -1, 0, 253.96291, 2465.30444, 15.68820, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Таймер

					Streamer_Update(playerid);

					StartPlayerTimerClearAnim(playerid, 1000);
				}
			}
		}
		// Взрывчатки на холме
		case tdm_des_opHillC4: {
			Dialog_Show(playerid, Dialog:TDM_Desert_BuyC4);
		}
		// Парашют на холме с взрывчаткой
		case tdm_des_opHillParachute: {
			GivePlayerWeaponEx(playerid, WEAPON_PARACHUTE, 1);
		}
		// Взрывчатки для моста
		case tdm_des_opBridgeC41, tdm_des_opBridgeC42, tdm_des_opBridgeC43: {
			if (AEInfo[sessionid][e_BridgeStatus]) {
				if (!TDM_GetPlayerExplosive(playerid)) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"У Вас нет взрывчатки!");
				}
				else {
					TDM_GivePlayerExplosive(playerid, -1);
					AEInfo[sessionid][e_BridgeCountC4]++;

					TDM_DestroyAEOtherPickup(sessionid, pickupid);

					ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, true, false, false, true, 0, SYNC_ALL);

					switch (pickupid) {
						case 4: TDM_CreateAEObject(sessionid, tdm_des_oBridgeC41, 1654, -1007.0994, 2720.4270, 45.2329,   -33.0000, 0.0000, 0.0000); // Взрывчатка
						case 5: TDM_CreateAEObject(sessionid, tdm_des_oBridgeC42, 1654, -1080.5458, 2696.1907, 44.9671,   -90.0000, 4.0000, -215.0000); // Взрывчатка 2
						case 6: TDM_CreateAEObject(sessionid, tdm_des_oBridgeC43, 1654, -1170.4159, 2701.4700, 45.2444,   0.0000, 0.0000, 0.0000); // Взрывчатка 3
					}

					adstr[0] = EOS;
					f(adstr, "{e32020}Детонатор\n\n{e3a019}Установлено взрывчаток: {c9e320}%i/3\n\n{D42C21}Нажмите {E5D110}[ ALT ]", AEInfo[sessionid][e_BridgeCountC4]);
					TDM_UpdateAE3DText(sessionid, tdm_des_3dBridgeDetonator, 0xFFFFFFFF, adstr);
					TDM_UpdateAE3DText(sessionid, tdm_des_3dBridgeDetonator2, 0xFFFFFFFF, adstr);

					Streamer_Update(playerid);

					SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Взрывчатка заложена: {cf1919}%i/3", AEInfo[sessionid][e_BridgeCountC4]);

					StartPlayerTimerClearAnim(playerid, 1000);
				}
			}
		}
		// Взрывчатки для двери запуска спутника
		case tdm_des_opDoorStartSputC4: {
			if (AEInfo[sessionid][e_SputnikDoorStatus] == 0) {
				if (!TDM_GetPlayerExplosive(playerid)) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"У Вас нет взрывчатки!");
				}
				else {
					TDM_GivePlayerExplosive(playerid, -1);
					AEInfo[sessionid][e_SputnikDoorCountC4]++;

					ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, true, false, false, true, 0, SYNC_ALL);

					switch (AEInfo[sessionid][e_SputnikDoorCountC4]) {
						case 1: TDM_CreateAEObject(sessionid, tdm_des_oSputnikDoorStartC41, 1654, -359.82309, 1592.80371, 77.17060,   0.00000, 0.00000, -90.00000); // Взрывчатка
						case 2: TDM_CreateAEObject(sessionid, tdm_des_oSputnikDoorStartC42, 1654, -359.80951, 1591.73340, 77.17060,   0.00000, 0.00000, -90.00000); // Взрывчатка 2
					}

					adstr[0] = EOS;
					f(adstr, "{1ae8c6}Дверь\n\n{e3a019}Установлено взрывчаток: {c9e320}%i/2\n\n{D42C21}Нажмите {E5D110}[ ALT ]", AEInfo[sessionid][e_SputnikDoorCountC4]);
					TDM_UpdateAE3DTextOP(sessionid, tdm_des_opDoorStartSputC4, 0xFFFFFFFF, adstr);

					Streamer_Update(playerid);

					StartPlayerTimerClearAnim(playerid, 1000);

					if (AEInfo[sessionid][e_SputnikDoorCountC4] >= 2) {
						AEInfo[sessionid][e_SputnikDoorStatus] = 1;
						AEInfo[sessionid][e_SputnikDoorTimer] += 10;

						adstr[0] = EOS;
						f(adstr, "{d9941c}Взрыв через: {db1414}%i {d9941c}секунд", AEInfo[sessionid][e_SputnikDoorTimer]);
						TDM_UpdateAE3DTextOP(sessionid, tdm_des_opDoorStartSputC4, 0xFFFFFFFF, adstr);
					}
				}
			}
		}
	}
	return 1;
}

stock TDM_Desert_SetPlayerKey3DText(playerid, textid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	switch (textid) {
		// Взорвать мост
		case tdm_des_3dBridgeDetonator, tdm_des_3dBridgeDetonator2: {
			if (AEInfo[sessionid][e_BridgeStatus] == 1) {
				if (AEInfo[sessionid][e_BridgeCountC4] < 3) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"На мосту недостаточно взрывчатки %i/3!", AEInfo[sessionid][e_BridgeCountC4]);
				}
				else {
					ApplyAnimation(playerid, "PED", "FLEE_LKAROUND_01", 4.0, true, false, false, true, 0, SYNC_ALL);

					AEInfo[sessionid][e_BridgeStatus] = 2;
					AEInfo[sessionid][e_BridgeTimer] += 15;
					
					adstr[0] = EOS;
					f(adstr, "{e32020}Детонатор\n\n{d9941c}Взрыв через: {db1414}%i {d9941c}секунд", AEInfo[sessionid][e_BridgeTimer]);
					TDM_UpdateAE3DText(sessionid, tdm_des_3dBridgeDetonator, 0xFFFFFFFF, adstr);
					TDM_UpdateAE3DText(sessionid, tdm_des_3dBridgeDetonator2, 0xFFFFFFFF, adstr);

					StartPlayerTimerClearAnim(playerid, 1000);
				}
			}
		}
		// Мини игра для запуска спутника
		case tdm_des_3dSputnikStart: {
			if (!AEInfo[sessionid][e_SputnikTeamActive][GetPlayerTeamEx(playerid)]) {
				if (TDM_GetCapturePointTeam(sessionid, 0) == GetPlayerTeamEx(playerid)) {
					if (GetPlayerCustomClass(playerid) == TDM_CLASS_ENGINEER) {
						if (GetPlayerMGNum(playerid) != tdm_des_pgStartSputnik) {
							if (!AEInfo[sessionid][e_SputnikLaunchStatus]) {
								SetPlayerMGSettings(playerid, tdm_des_pgStartSputnik);
							}
							else {
								SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Спутник уже запускают!");
							}
						}
					}
					else {
						SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Необходим класс инженера!");
					}
				}
				else {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Необходимо захватить Точку связи!");
				}
			}
			else {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Союзный спутник уже запущен.");
			}
		}
		// Запуск ядерной ракеты в подлодке
		case tdm_des_3dSubmarineNucStart: {
			Dialog_Show(playerid, Dialog:TDM_Desert_Nuc);
		}
	}
	return 1;
}

stock TDM_Desert_UpdateAE(sessionid)
{
	// Спутник
	if (AEInfo[sessionid][e_SputnikDoorStatus] == 1) {
		if (AEInfo[sessionid][e_SputnikDoorTimer] > 0) {
			AEInfo[sessionid][e_SputnikDoorTimer]--;

			adstr[0] = EOS;
			f(adstr, "{d9941c}Взрыв через: {db1414}%i {d9941c}секунд", AEInfo[sessionid][e_SputnikDoorTimer]);
			TDM_UpdateAE3DTextOP(sessionid, tdm_des_opDoorStartSputC4, 0xFFFFFFFF, adstr);
		}
		else {
			AEInfo[sessionid][e_SputnikDoorStatus] = 2;
			AEInfo[sessionid][e_SputnikDoorTimer] = 0;

			TDM_DestroyAEObject(sessionid, tdm_des_oSputnikDoorStartC41);
			TDM_DestroyAEObject(sessionid, tdm_des_oSputnikDoorStartC42);

			TDM_DestroyAEOtherPickup(sessionid, tdm_des_opDoorStartSputC4);

			TDM_MoveAEObject(sessionid, tdm_des_oSputnikDoorStart, -360.7550, 1592.4312, 75.7866, 15.0, -84.0000, -33.0000, 47.0000);

			m_for(MODE_TDM, sessionid, p) {
				CreateExplosionForPlayer(p, -360.5948, 1592.2469, 76.8104, 12, 5.0);
			}

			TDM_CreateAE3DText(sessionid, tdm_des_3dSputnikStart, "{10B3EA}Запуск спутника\n\n{D42C21}Нажмите {E5D110}[ ALT ]", -1, 1, -358.3776, 1592.2042, 76.7327, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Мини-игра
		}
	}

	// Ядерная ракета
	if (AEInfo[sessionid][e_NucMisStatus]) {
		switch (AEInfo[sessionid][e_NucMisStatus]) {
			// Запуск ядерной ракеты
			case 1: {
				if (AEInfo[sessionid][e_NucMisTimer] > 0) {
					AEInfo[sessionid][e_NucMisTimer]--;

					adstr[0] = EOS;
					f(adstr, "{d9941c}Запуск через: {db1414}%i {d9941c}секунд", AEInfo[sessionid][e_NucMisTimer]);
					TDM_UpdateAE3DText(sessionid, tdm_des_3dSubmarineNucStart, 0xFFFFFFFF, adstr);
				}
				else {
					AEInfo[sessionid][e_NucMisStatus] = 2;
					AEInfo[sessionid][e_NucMisTimer] = 0;
					TDM_UpdateAE3DText(sessionid, tdm_des_3dSubmarineNucStart, 0xFFFFFFFF, "{e6c41e}Запустить ядерную ракету\n\n{D42C21}Нажмите {E5D110}[ ALT ]");

					TDM_MoveAEObject(sessionid, tdm_des_oNucRocket, 259.645019, 2992.598388, 239.823944, 25.0, -0.000045, 0.000021, -81.999954);
					TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing1, 259.597381, 2989.420410, 251.679641, 25.0, 43.499977, 0.000065, 1.599753);
					TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing2, 262.233398, 2994.344482, 251.681472, 25.0, 43.499980, 2.399944, 123.799880);
					TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing3, 256.798156, 2992.711181, 251.573440, 25.0, 43.499984, -0.000022, 91.599647);

					TDM_CreateAEObject(sessionid, tdm_des_oNucRocketFlame, 18692, 259.603027, 2992.959960, -87.345024, -176.999969, 0.000000, 2.500000);
					TDM_MoveAEObject(sessionid, tdm_des_oNucRocketFlame, 259.603027, 2992.959960, 239.684921, 25.0, -3.000030, 179.999908, -177.499755);

					if (AEInfo[sessionid][e_NucMisStartTeam] == TDM_TEAM_MILITARY)
						TDM_CreateAEMapIcon(sessionid, tdm_des_miPosDropNuc, -117.81070, 2730.59644, 49.94920, 23, -1, -1, -1, -1, 5000.0, MAPICON_GLOBAL); // Падение ядерной ракеты
					else if (AEInfo[sessionid][e_NucMisStartTeam] == TDM_TEAM_REBEL)
						TDM_CreateAEMapIcon(sessionid, tdm_des_miPosDropNuc, -33.03316, 1763.66467, 6.92517, 23, -1, -1, -1, -1, 5000.0, MAPICON_GLOBAL); // Падение ядерной ракеты

					m_for(MODE_TDM, sessionid, p) {
						if (AEInfo[sessionid][e_NucMisStartTeam] == GetPlayerTeamEx(p)) {
							SCM(p, C_EMERLAND, ""T_MATCH" Запущена союзная ядерная ракета!");
						}
						else {
							SCM(p, C_EMERLAND, ""T_MATCH" Запущена вражеская ядерная ракета!");
						}
					}
				}
			}
			case 2: {
				new
					Float:x,
					Float:y,
					Float:z;

				TDM_GetAEObjectPos(sessionid, tdm_des_oNucRocket, x, y, z);

				if (x == 259.645019 
				&& y == 2992.598388 
				&& z == 239.823944) {
					AEInfo[sessionid][e_NucMisStatus] = 3;

					TDM_StopAEObject(sessionid, tdm_des_oNucRocket);
					TDM_StopAEObject(sessionid, tdm_des_oNucRocketWing1);
					TDM_StopAEObject(sessionid, tdm_des_oNucRocketWing2);
					TDM_StopAEObject(sessionid, tdm_des_oNucRocketWing3);
					TDM_StopAEObject(sessionid, tdm_des_oNucRocketFlame);

					if (AEInfo[sessionid][e_NucMisStartTeam] == TDM_TEAM_MILITARY) {
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocket, 30.949661, 2824.454101, 234.015670, 100.0, 8.167953, 89.890258, -147.084503);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing1, 20.969505, 2818.043212, 230.860046, 100.0, 46.579864, -177.427719, 121.034324);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing2, 22.399785, 2815.846191, 235.791809, 100.0, -23.827238, -62.642955, 81.779457);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing3, 19.538206, 2820.462646, 234.142395, 100.0, -1.207247, -88.704299, 76.415145);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketFlame, 31.043579, 2824.565917, 234.376861, 100.0, -86.066467, 317.265655, -99.761985);
					}
					else if (AEInfo[sessionid][e_NucMisStartTeam] == TDM_TEAM_REBEL) {
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocket, 58.558448, 1910.803833, 240.964019, 100.0, 56.648487, 91.839805, -116.989273);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing1, 55.606391, 1899.122436, 238.620254, 100.0, 26.839530, -120.494369, 115.855117);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing2, 53.799720, 1899.878173, 243.850952, 100.0, -46.982460, -8.684837, 146.529464);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing3, 51.751045, 1901.073730, 238.693923, 100.0, -34.740264, -51.062980, 120.192977);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketFlame, 58.346446, 1911.054687, 241.173767, 100.0, -38.699478, 273.705780, -110.793968);
					}
				}
			}
			case 3: {
				new
					Float:x,
					Float:y,
					Float:z;

				TDM_GetAEObjectPos(sessionid, tdm_des_oNucRocket, x, y, z);

				if (AEInfo[sessionid][e_NucMisStartTeam] == TDM_TEAM_MILITARY) {
					if (x == 30.949661 
					&& y == 2824.454101 
					&& z == 234.015670) {
						AEInfo[sessionid][e_NucMisStatus] = 4;

						TDM_StopAEObject(sessionid, tdm_des_oNucRocket);
						TDM_StopAEObject(sessionid, tdm_des_oNucRocketWing1);
						TDM_StopAEObject(sessionid, tdm_des_oNucRocketWing2);
						TDM_StopAEObject(sessionid, tdm_des_oNucRocketWing3);
						TDM_StopAEObject(sessionid, tdm_des_oNucRocketFlame);

						TDM_MoveAEObject(sessionid, tdm_des_oNucRocket, -91.126106, 2739.143066, 67.415969, 80.0, 27.673606, 129.074050, -142.866409);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing1, -94.368614, 2731.457519, 58.411426, 80.0, 8.563535, -157.092895, 127.899238);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing2, -95.854965, 2728.709716, 63.041267, 80.0, -64.771476, -75.563308, 89.029296);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing3, -98.186180, 2732.826416, 59.904335, 80.0, -41.563312, -100.782157, 88.608299);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketFlame, -91.321960, 2739.200195, 67.747825, 80.0, -44.319477, 326.354248, -74.031501);
					}
				}
				else if (AEInfo[sessionid][e_NucMisStartTeam] == TDM_TEAM_REBEL) {
					if (x == 58.558448 
					&& y == 1910.803833 
					&& z == 240.964019) {
						AEInfo[sessionid][e_NucMisStatus] = 4;

						TDM_StopAEObject(sessionid, tdm_des_oNucRocket);
						TDM_StopAEObject(sessionid, tdm_des_oNucRocketWing1);
						TDM_StopAEObject(sessionid, tdm_des_oNucRocketWing2);
						TDM_StopAEObject(sessionid, tdm_des_oNucRocketWing3);
						TDM_StopAEObject(sessionid, tdm_des_oNucRocketFlame);
						
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocket, -12.458232, 1784.565551, 26.724061, 80.0, 56.357509, 186.117538, 151.316268);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing1, -13.057003, 1774.333129, 19.971139, 80.0, -20.758401, -116.900619, 107.839485);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing2, -18.059331, 1774.531005, 22.447614, 80.0, -64.720100, 79.040443, -143.610534);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketWing3, -15.747154, 1776.997680, 17.887842, 80.0, -79.761322, -11.071502, 149.044357);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRocketFlame, -12.751257, 1784.814697, 26.786476, 80.0, 0.449079, 303.450469, -108.049255);
					}
				}
			}
			case 4: {
				new
					Float:x,
					Float:y,
					Float:z;

				TDM_GetAEObjectPos(sessionid, tdm_des_oNucRocket, x, y, z);

				if (AEInfo[sessionid][e_NucMisStartTeam] == TDM_TEAM_MILITARY) {
					if (x == -91.126106 
					&& y == 2739.143066 
					&& z == 67.415969) {
						AEInfo[sessionid][e_NucMisStatus] =
						AEInfo[sessionid][e_NucMisTimer] =
						AEInfo[sessionid][e_NucMisStartTeam] = 0;

						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocket);
						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocketWing1);
						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocketWing2);
						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocketWing3);
						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocketFlame);

						TDM_DestroyAEMapIcon(sessionid, tdm_des_miPosDropNuc);

						TDM_CreateAEObject(sessionid, tdm_des_oNucMilitaryHill1, 16121, -117.81070, 2730.59644, 29.94920,   0.00000, 0.00000, -18.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucMilitaryHill2, 16121, -93.69714, 2761.83862, 36.40813,   0.00000, 0.00000, -127.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucMilitaryHill3, 16112, -127.33970, 2670.45288, 19.73460,   0.00000, 2.00000, 0.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucMilitaryHill4, 16116, -71.12023, 2714.49609, 30.91233,   0.00000, 0.00000, 127.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucMilitaryHill5, 16305, -83.52567, 2727.70215, 41.76585,   0.00000, 0.00000, 0.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucMilitaryHill6, 16305, -100.60416, 2734.92139, 41.54580,   0.00000, 0.00000, 0.00000);

						TDM_MoveAEObject(sessionid, tdm_des_oNucMilitaryHill1, -117.81070, 2730.59644, 49.94920, 30.0, 0.00000, 0.00000, -18.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucMilitaryHill2, -93.69714, 2761.83862, 56.40813, 30.0, 0.00000, 0.00000, -127.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucMilitaryHill3, -127.33970, 2670.45288, 39.73460, 30.0, 0.00000, 2.00000, 0.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucMilitaryHill4, -71.12023, 2714.49609, 50.91233, 30.0, 0.00000, 0.00000, 127.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucMilitaryHill5, -83.52567, 2727.70215, 61.76585, 30.0, 0.00000, 0.00000, 0.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucMilitaryHill6, -100.60416, 2734.92139, 61.54580, 30.0, 0.00000, 0.00000, 0.00000);

						m_for(MODE_TDM, sessionid, p) {
							CreateExplosionForPlayer(p, -117.81070, 2730.59644, 49.94920, 6, 50.0);
							CreateExplosionForPlayer(p, -121.7999, 2748.5891, 68.1260, 6, 50.0);
							CreateExplosionForPlayer(p, -94.6343, 2691.8931, 49.7594, 6, 50.0);

							if (GetAdminSpectating(p)) {
								continue;
							}

							if (GetSpecPl(p)) {
								continue;
							}

							if (GetPlayerDead(p) != PLAYER_DEATH_NONE) {
								continue;
							}
							
							if (IsPlayerInRangeOfPoint(p, 60.0, -117.81070, 2730.59644, 49.94920)
							|| AEInfo[sessionid][e_NucMisStartTeam] != GetPlayerTeamEx(p)) {
								SetPlayerArmourEx(p, 0.0);
								SetPlayerHealthEx(p, 0.0);

								SCM(p, C_EMERLAND, ""T_MATCH" Вас убила ядерная ракета!");
							}
						}

						CreateNucMis(sessionid);
					}
				}
				else if (AEInfo[sessionid][e_NucMisStartTeam] == TDM_TEAM_REBEL) {
					if (x == -12.458232 
					&& y == 1784.565551 
					&& z == 26.724061) {
						AEInfo[sessionid][e_NucMisStatus] =
						AEInfo[sessionid][e_NucMisTimer] =
						AEInfo[sessionid][e_NucMisStartTeam] = 0;

						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocket);
						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocketWing1);
						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocketWing2);
						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocketWing3);
						TDM_DestroyAEObject(sessionid, tdm_des_oNucRocketFlame);

						TDM_DestroyAEMapIcon(sessionid, tdm_des_miPosDropNuc);
						
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill1, 16118, -33.03316, 1763.66467, -10.000,   357.00000, 0.00000, 18.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill2, 16121, -4.73642, 1804.81128, -10.000,   357.00000, 0.00000, -105.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill3, 16112, 14.00677, 1720.26794, -10.000,   356.85840, 0.00000, 3.14159);
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill4, 16133, 8.05360, 1759.62671, -10.000,   0.00000, 0.00000, -33.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill5, 16112, 52.39893, 1770.00696, -10.000,   357.00000, 0.00000, -62.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill6, 16112, 21.79420, 1840.12024, -10.000,   357.00000, 0.00000, 142.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill7, 16112, -44.40110, 1829.66260, -10.000,   357.00000, 0.00000, -33.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill8, 16305, -11.65872, 1760.65063, -10.000,   0.00000, 0.00000, 0.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill9, 16305, -4.87764, 1781.46350, -10.000,   0.00000, 0.00000, -91.00000);
						TDM_CreateAEObject(sessionid, tdm_des_oNucRebelHill10, 16305, -21.09365, 1778.56824, -10.000,   0.00000, 0.00000, 113.00000);

						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill1, -33.03316, 1763.66467, 6.92517, 30.0, 357.00000, 0.00000, 18.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill2, -4.73642, 1804.81128, 10.54056, 30.0, 357.00000, 0.00000, -105.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill3, 14.00677, 1720.26794, 14.10537, 30.0, 356.85840, 0.00000, 3.14159);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill4, 8.05360, 1759.62671, 10.80862, 30.0, 0.00000, 0.00000, -33.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill5, 52.39893, 1770.00696, 6.60170, 30.0, 357.00000, 0.00000, -62.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill6, 21.79420, 1840.12024, 8.32591, 30.0, 357.00000, 0.00000, 142.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill7, -44.40110, 1829.66260, 8.32590, 30.0, 357.00000, 0.00000, -33.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill8, -11.65872, 1760.65063, 18.91520, 30.0, 0.00000, 0.00000, 0.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill9, -4.87764, 1781.46350, 18.91520, 30.0, 0.00000, 0.00000, -91.00000);
						TDM_MoveAEObject(sessionid, tdm_des_oNucRebelHill10, -21.09365, 1778.56824, 18.91520, 30.0, 0.00000, 0.00000, 113.00000);

						m_for(MODE_TDM, sessionid, p) {
							CreateExplosionForPlayer(p, -33.03316, 1763.66467, 6.92517, 6, 50.0);
							CreateExplosionForPlayer(p, -46.7900, 1795.5148, 17.6461, 6, 50.0);
							CreateExplosionForPlayer(p, 22.4664, 1797.9855, 17.6406, 6, 50.0);

							if (GetAdminSpectating(p)) {
								continue;
							}

							if (GetSpecPl(p)) {
								continue;
							}

							if (GetPlayerDead(p) != PLAYER_DEATH_NONE) {
								continue;
							}

							if (IsPlayerInRangeOfPoint(p, 60.0, -33.03316, 1763.66467, 6.92517)
							|| AEInfo[sessionid][e_NucMisStartTeam] != GetPlayerTeamEx(p)) {
								SetPlayerArmourEx(p, 0.0);
								SetPlayerHealthEx(p, 0.0);

								SCM(p, C_EMERLAND, ""T_MATCH" Вас убила ядерная ракета!");
							}
						}

						CreateNucMis(sessionid);
					}
				}
			}
		}
	}

	// Мост
	if (AEInfo[sessionid][e_BridgeStatus] == 2) {
		if (AEInfo[sessionid][e_BridgeTimer] > 0) {
			AEInfo[sessionid][e_BridgeTimer]--;

			adstr[0] = EOS;
			f(adstr, "{e32020}Детонатор\n\n{d9941c}Взрыв через: {db1414}%i {d9941c}секунд", AEInfo[sessionid][e_BridgeTimer]);
			TDM_UpdateAE3DText(sessionid, tdm_des_3dBridgeDetonator, 0xFFFFFFFF, adstr);
			TDM_UpdateAE3DText(sessionid, tdm_des_3dBridgeDetonator2, 0xFFFFFFFF, adstr);
		}
		else {
			AEInfo[sessionid][e_BridgeStatus] = 3;
			AEInfo[sessionid][e_BridgeTimer] = 0;

			TDM_DestroyAEObject(sessionid, tdm_des_oBridgeC41);
			TDM_DestroyAEObject(sessionid, tdm_des_oBridgeC42);
			TDM_DestroyAEObject(sessionid, tdm_des_oBridgeC43);

			TDM_CreateAEObject(sessionid, tdm_des_oBridgeHill1, 16304, -964.47858, 2713.41675, 42.93823,   6.00000, -8.00000, 0.00000); // Горка
			TDM_CreateAEObject(sessionid, tdm_des_oBridgeHill2, 16305, -967.93066, 2725.84619, 43.45265,   0.00000, 0.00000, 0.00000); // Горка 2
			TDM_CreateAEObject(sessionid, tdm_des_oBridgeHill3, 16305, -1206.16101, 2685.54883, 43.71730,   0.00000, 0.00000, 127.00000); // Горка 3
			TDM_CreateAEObject(sessionid, tdm_des_oBridgeHill4, 16305, -1202.47522, 2693.65625, 42.99990,   0.00000, 0.00000, 40.00000); // Горка 4

			TDM_MoveAEObject(sessionid, tdm_des_oBridge, -1143.26013, 2694.96582, 36.25655, 5.0, -350.00000, -10.00000, 187.00000);
			TDM_MoveAEObject(sessionid, tdm_des_oBridge_2, -1023.94476, 2709.08398, 35.43292, 5.0, -340.00000, 12.00000, 187.00000);
			TDM_MoveAEObject(sessionid, tdm_des_oBridgeHill1, -964.47858, 2713.41675, 45.93823, 3.0, 6.00000, -8.00000, 0.00000);
			TDM_MoveAEObject(sessionid, tdm_des_oBridgeHill2, -967.93066, 2725.84619, 46.45265, 3.0, 0.00000, 0.00000, 0.00000);
			TDM_MoveAEObject(sessionid, tdm_des_oBridgeHill3, -1206.16101, 2685.54883, 46.71730, 3.0, 0.00000, 0.00000, 127.00000);
			TDM_MoveAEObject(sessionid, tdm_des_oBridgeHill4, -1202.47522, 2693.65625, 45.99990, 3.0, 0.00000, 0.00000, 40.00000);

			m_for(MODE_TDM, sessionid, p) {
				CreateExplosionForPlayer(p, -1007.0994, 2720.4270, 45.2329, 6, 10.0);
				CreateExplosionForPlayer(p, -1080.5458, 2696.1907, 44.9671, 6, 10.0);
				CreateExplosionForPlayer(p, -1170.4159, 2701.4700, 45.2444, 6, 10.0);
			}
			Mode_StreamerUpdate(MODE_TDM, sessionid);

			adstr[0] = EOS;
			f(adstr, "{e32020}Детонатор\n\n{e3a019}Мост взорван");
			TDM_UpdateAE3DText(sessionid, tdm_des_3dBridgeDetonator, 0xFFFFFFFF, adstr);
			TDM_UpdateAE3DText(sessionid, tdm_des_3dBridgeDetonator2, 0xFFFFFFFF, adstr);
		}
	}

	// Кран
	if (AEInfo[sessionid][e_CraneStatus] == 2) {
		if (AEInfo[sessionid][e_CraneTimer] > 0) {
			AEInfo[sessionid][e_CraneTimer]--;

			adstr[0] = EOS;
			f(adstr, "{d9941c}Взрыв через: {db1414}%i {d9941c}секунд", AEInfo[sessionid][e_CraneTimer]);
			TDM_UpdateAE3DText(sessionid, tdm_des_3dCraneC4, 0xFFFFFFFF, adstr);
		}
		else {
			TDM_DestroyAEObject(sessionid, tdm_des_oCraneC4);
			TDM_DestroyAE3DText(sessionid, tdm_des_3dCraneC4);

			AEInfo[sessionid][e_CraneStatus] = 3;
			AEInfo[sessionid][e_CraneTimer] = 0;

			TDM_DestroyAEPickupDoor(sessionid, tdm_des_pdEnterCrane);
			TDM_DestroyAEPickupDoor(sessionid, tdm_des_pdExitCrane);

			TDM_DestroyAEOtherPickup(sessionid, tdm_des_opCraneParachute);

			TDM_MoveAEObject(sessionid, tdm_des_oCrane, 258.45969, 2468.25366, 22.24070, 10.0, -9.00000, -70.00000, 0.00000);
			TDM_MoveAEObject(sessionid, tdm_des_oCrane_2, 227.90410, 2470.22900, 32.87280, 22.0, -22.00000, -68.00000, 0.00000);

			m_for(MODE_TDM, sessionid, p)
				CreateExplosionForPlayer(p, 253.2200, 2465.2839, 16.4766, 6, 10.0);

			Mode_StreamerUpdate(MODE_TDM, sessionid);
		}
	}

	// Шторм
	if (AEInfo[sessionid][e_TimeStorm]) {
		if (Mode_GetSessionMinutes(MODE_TDM, sessionid) == AEInfo[sessionid][e_TimeStorm]) {
			if (Mode_GetSessionWeather(MODE_TDM, sessionid) != 19) {
				AEInfo[sessionid][e_TimeStorm] -= 5;

				Mode_SetSessionWeather(MODE_TDM, sessionid, 19);

				m_for(MODE_TDM, sessionid, p)
					SCM(p, C_EMERLAND, ""T_MATCH" Началась песчаная буря!");
			}
			else {
				AEInfo[sessionid][e_TimeStorm] = 0;

				Mode_SetSessionWeather(MODE_TDM, sessionid, 0);

				m_for(MODE_TDM, sessionid, p)
					SCM(p, C_EMERLAND, ""T_MATCH" Закончилась песчаная буря!");
			}
		}
	}
	return 1;
}

stock TDM_Desert_UpdatePlayerAE(playerid)
{
	// Аирдроп кодов доступа
	if (Mode_GetPlAEValue(playerid, tdm_des_pvAccodeStatus) == 1) {
		new
			Float:oX, Float:oY, Float:oZ,
			Float:vX, Float:vY, Float:vZ;

		Mode_GetPlAEObjectPos(playerid, 1, oX, oY, oZ);
		Mode_GetPlAEFloatValue(playerid, tdm_des_pfPosAccode, vX, vY, vZ);

		if (oX == vX 
		&& oY == vY
		&& (oZ - 6.0) == vZ) {
			Mode_SetPlAEValue(playerid, tdm_des_pvAccodeStatus, 2);
			Mode_SetPlAEValue(playerid, tdm_des_pvAccodeTimer, 15);

			adstr[0] = EOS;
			f(adstr, "{e6c41e}Коды доступа\n\n"CT_WHITE"Вызвал: {%06x}%s\n\n{D42C21}Нажмите {E5D110}[ ALT ]", GetPlayerColorEx(playerid) >>> 8, GetPlayerNameEx(playerid));
			Mode_CreatePlAE3DText(playerid, tdm_des_ptAccodeDrop, adstr, -1, 1, vX, vY, vZ, 10.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0); // Коды доступа для запуска ядерной ракеты
		}
	}
	else if (Mode_GetPlAEValue(playerid, tdm_des_pvAccodeStatus) == 2) {
		if (Mode_GetPlAEValue(playerid, tdm_des_pvAccodeTimer) > 0) {
			Mode_SetPlAEValue(playerid, tdm_des_pvAccodeTimer, Mode_GetPlAEValue(playerid, tdm_des_pvAccodeTimer) - 1);
		}
		else {
			Mode_SetPlAEValue(playerid, tdm_des_pvAccodeStatus, 0);
			Mode_SetPlAEValue(playerid, tdm_des_pvAccodeTimer, 0);

			Mode_SetPlAEFloatValue(playerid, tdm_des_pfPosAccode, 0.0, 0.0, 0.0);

			Mode_DestroyPlAEObject(playerid, tdm_des_poAccodeSmoke);
			Mode_DestroyPlAEObject(playerid, tdm_des_poAccodeParachute);
			Mode_DestroyPlAE3DText(playerid, tdm_des_ptAccodeDrop);

			Streamer_Update(playerid);
		}
	}
	return 1;
}

stock TDM_Desert_UpdatePlayerMG(playerid) 
{
	switch (GetPlayerMGNum(playerid)) {
		// Запуск спутника
		case tdm_des_pgStartSputnik: {
			if (GetPlayerMGTimer(playerid) > 0) {
				SetPlayerMGTimer(playerid, GetPlayerMGTimer(playerid) - 1);
			}
			else {
				ResetPlayerMGData(playerid);
				SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Вы не смогли запустить спутник.");
			}
		}
	}
	return 1;
}

stock TDM_Desert_SetPlKeyMode3DText(playerid, p_3dtext, textid)
{
	switch (textid) {
		// Аирдроп кодов доступа для запуска ядерной ракеты
		case 0: {
			if (!Mode_GetPlAEValue(playerid, tdm_des_pvAccodeAttach)) {
				if (IsPlayerAttachedObjectSlotUsed(playerid, 8)) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы уже переносите предмет на спине!");
				}
				else {
					Mode_SetPlAEValue(p_3dtext, tdm_des_pvAccodeStatus, 0);
					Mode_SetPlAEValue(p_3dtext, tdm_des_pvAccodeTimer, 0);

					Mode_SetPlAEFloatValue(p_3dtext, tdm_des_pfPosAccode, 0.0, 0.0, 0.0);

					Mode_DestroyPlAEObject(p_3dtext, tdm_des_poAccodeSmoke);
					Mode_DestroyPlAEObject(p_3dtext, tdm_des_poAccodeParachute);
					Mode_DestroyPlAE3DText(p_3dtext, tdm_des_ptAccodeDrop);

					Mode_SetPlAEValue(playerid, tdm_des_pvAccodeAttach, 1);
					SetPlayerAttachedObject(playerid, 8, 1210, 1, 0.163000, -0.060000, -0.005000, 0.000000, 0.000000, 18.299999, 0.708000, 0.907000, 0.772000);

					SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Коды доступа у Вас, теперь спешите на подлодку!");
				}
			}
		}
	}
	return 1;
}

static CreateNucMis(sessionid)
{
	TDM_CreateAEObject(sessionid, tdm_des_oNucRocket, 17049, 259.645019, 2992.598388, -87.206001, 0.000000, 0.000015, -82.000091); // Ракета
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oNucRocket, 0, 3113, "carrierxr", "ws_shipmetal1", 0x00000000);
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oNucRocket, 1, 10810, "ap_build4e", "redwhite_stripe", 0x00000000);
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oNucRocket, 2, 10839, "aircarpkbarier_sfse", "chevron_red_64HVa", 0x00000000);
	TDM_CreateAEObject(sessionid, tdm_des_oNucRocketWing1, 19362, 259.597381, 2989.420410, -75.350303, 43.499977, 0.000002, 1.599798); // Крыло
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oNucRocketWing1, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	TDM_CreateAEObject(sessionid, tdm_des_oNucRocketWing2, 19362, 262.233398, 2994.344482, -75.348464, 43.499954, 2.399979, 123.800010); // Крыло
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oNucRocketWing2, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	TDM_CreateAEObject(sessionid, tdm_des_oNucRocketWing3, 19362, 256.798156, 2992.711181, -75.456504, 43.499958, -0.000020, 91.599784); // Крыло
	TDM_SetAEObjectMaterial(sessionid, tdm_des_oNucRocketWing3, 0, 1560, "7_11_door", "cj_sheetmetal2", 0x00000000);
	return 1;
}

stock TDM_Desert_CheckStartFastPoint(sessionid)
{
	if (Mode_GetSessionActiveTimer(MODE_TDM, sessionid)) {
		if (Mode_GetSessionMinutes(MODE_TDM, sessionid) == 5
		|| Mode_GetSessionMinutes(MODE_TDM, sessionid) == 10
		|| Mode_GetSessionMinutes(MODE_TDM, sessionid) == 15
		|| Mode_GetSessionMinutes(MODE_TDM, sessionid) == 20
		|| Mode_GetSessionMinutes(MODE_TDM, sessionid) == 25) {
			TDM_StartFastPoint(sessionid);
		}
	}
	return 1;
}

stock TDM_Desert_AirWeaponTimer(sessionid)
{
	new
		virtualworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid),
		interior = Mode_GetSessionInterior(MODE_TDM, sessionid);

	new
		indexPriorityID = TDM_GetWeaponAirBextPriority(sessionid) - 1;

	n_for(i, WeaponAirPriorityCount[indexPriorityID]) {
		new
			weaponAir = WeaponAirPriority[indexPriorityID][i];

		if (!TDM_IsValidAirWeapon(sessionid, weaponAir)) {
			SetAirWeapon(sessionid, weaponAir, 
			WeaponAirCoord[weaponAir][0], WeaponAirCoord[weaponAir][1], WeaponAirCoord[weaponAir][2], 
			virtualworld, interior);
		}
	}

	if (indexPriorityID + 2 > sizeof(WeaponAirPriorityCount)) {
		TDM_SetWeaponAirNextPriority(sessionid, 0);
	}
	return 1;
}

stock TDM_Desert_AirBombTimer(sessionid)
{
	new
		virtualworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid),
		interior = Mode_GetSessionInterior(MODE_TDM, sessionid);

	new
		indexPriorityID = TDM_GetBombAirBextPriority(sessionid) - 1;

	n_for(i, BombAirPriorityCount[indexPriorityID]) {
		new
			bombAir = BombAirPriority[indexPriorityID][i];

		if (!TDM_IsValidAirBomb(sessionid, bombAir)) {
			SetAirBomb(sessionid, bombAir, 
			BombAirCoord[bombAir][0], BombAirCoord[bombAir][1], BombAirCoord[bombAir][2], 
			virtualworld, interior);
		}
	}

	if (indexPriorityID + 2 == sizeof(BombAirPriorityCount)) {
		TDM_SetBombAirNextPriority(sessionid, 0);
	}
	return 1;
}

stock TDM_Desert_SetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
{
	new
		sessionid = M_GPS(playerid);

	switch (num) {
		// Start sputnik
		case tdm_des_pgStartSputnik: {
			AEInfo[sessionid][e_SputnikLaunchStatus] = true;

			new 
				letter_value = random(MAX_COUNT_RANDOM_KEYS);

			TogglePlayerControllable(playerid, false);
			f(adstr, "%s%s", GetRandomColorText(random(MAX_COUNT_RANDOM_COLOR)), GetRandomKeyStr(letter_value));
			GameTextForPlayer(playerid, adstr, 2000, 3);

			timer = 2;
			count = 0;
			value = GetRandomKey(letter_value);
			ptime = 1000;
		}
	}
	return 1;
}

stock TDM_Desert_ResetPlayerMG(playerid)
{
	new
		sessionid = M_GPS(playerid);

	switch (GetPlayerMGNum(playerid)) {
		// Start sputnik
		case tdm_des_pgStartSputnik: {
			AEInfo[sessionid][e_SputnikLaunchStatus] = false;
			TogglePlayerControllable(playerid, true);
		}
	}
	return 1;
}

stock TDM_Desert_VehSetSettings(vehicleid)
{
	if (GetVehicleTeam(vehicleid) == TDM_TEAM_NONE) {
		SetVehicleColorEx(vehicleid, random(127), random(127));
	}
	else {
		SetVehicleColorEx(vehicleid, TDM_GetTeamColorVehicle(GetVehicleTeam(vehicleid), 0), TDM_GetTeamColorVehicle(GetVehicleTeam(vehicleid), 1));
	}

	LinkVehicleToInterior(vehicleid, Mode_GetSessionInterior(MODE_TDM, GetVehicleSession(vehicleid)));
	SetVehicleVirtualWorld(vehicleid, Mode_GetSessionVirtualWorld(MODE_TDM, GetVehicleSession(vehicleid)));
	
	SetVehicleEngine(vehicleid, false);
	SetVehicleFuel(vehicleid, VEHICLE_FUEL);
	return 1;
}

static CreateVehicleLocation(sessionid)
{
	// Neutral
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 0, 403, 331.5397, 2545.3743, 17.2763, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 1, 405, 368.2422, 2582.2869, 16.2526, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 2, 405, 204.2236, 2664.6619, 16.2205, -149.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 3, 411, 258.7526, 2904.7268, 6.6175, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 4, 411, 112.8547, 2794.1531, 78.7506, 55.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 5, 419, 149.1882, 2529.3867, 16.5213, 91.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 6, 424, 181.1442, 2469.3384, 16.1365, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 7, 424, 191.9978, 2382.3528, 16.1568, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 8, 428, 305.7481, 2435.9756, 16.5292, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 9, 434, 40.3206, 2440.5369, 16.4374, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 10, 434, 17.3084, 2455.3748, 16.3985, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 11, 439, -34.0116, 2340.2388, 23.9240, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 12, 445, -97.2633, 2503.6663, 16.2390, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 13, 458, 23.2817, 2533.6948, 16.2584, 142.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 14, 461, -544.4664, 2569.6533, 52.9961, -90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 15, 466, -520.8271, 2575.7273, 53.0900, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 16, 474, -817.3181, 2758.5371, 45.4940, 28.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_NONE, 17, 477, -869.8672, 2755.6182, 45.5985, 900.0000);

	// Military
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 18, 470, -1472.9172, 2594.5530, 55.5728, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 19, 470, 350.9038, 1868.1245, 17.4911, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 20, 470, 345.1603, 1868.1245, 17.4479, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 21, 470, 339.5924, 1868.1245, 17.4192, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 22, 470, 334.0981, 1868.1245, 17.3986, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 23, 470, 350.2862, 1828.1464, 17.3707, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 24, 470, 344.8227, 1828.1464, 17.3854, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 25, 470, 339.0518, 1828.1464, 17.3581, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 26, 470, 333.9356, 1828.1464, 17.3634, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 27, 470, 277.3404, 1947.7617, 17.3624, -90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 28, 470, 277.3404, 1952.5709, 17.3624, -90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 29, 470, 277.3404, 1957.5056, 17.3624, -90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 30, 470, 277.3404, 1962.9048, 17.3624, -90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 31, 495, 285.3964, 1938.1357, 17.8497, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 32, 495, 267.7966, 1938.1357, 17.8497, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 33, 560, 273.6802, 1938.0863, 17.2168, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 34, 560, 279.4135, 1938.0863, 17.2168, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 35, 563, 368.0856, 1874.3418, 19.3969, -90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 36, 563, 284.6008, 2047.0232, 19.3710, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 37, 599, 292.5746, 1851.2422, 17.7284, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 38, 568, 396.1913, 1999.9320, 17.3346, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 39, 568, 385.5298, 1999.7864, 17.3346, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 40, 548, 207.0410, 1931.4232, 24.9211, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 41, 497, 233.8460, 1965.1110, 18.0053, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 42, 471, 201.8265, 1858.7776, 12.4831, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 43, 468, 225.1827, 1866.8071, 12.7043, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 44, 471, 203.8183, 1858.6578, 12.4831, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 45, 471, 205.8206, 1858.6564, 12.4831, 0.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 46, 468, 225.1250, 1864.6292, 12.7043, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 47, 468, 225.2088, 1862.4373, 12.7043, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_MILITARY, 48, 468, 225.2127, 1860.3970, 12.7043, 90.0000);

	// Rebel
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 49, 402, -244.7392, 2712.1973, 62.3754, 200.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 50, 402, -237.0803, 2712.1973, 62.3754, 200.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 51, 402, -229.6074, 2712.1973, 62.3754, 200.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 52, 402, -213.6447, 2712.1973, 62.3754, 200.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 53, 402, -206.7567, 2712.1973, 62.3754, 200.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 54, 402, -199.6473, 2712.1973, 62.3754, 200.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 55, 468, -217.9112, 2728.1265, 62.2663, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 56, 468, -222.4986, 2728.1265, 62.2663, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 57, 415, -199.3200, 2739.6597, 62.3749, -20.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 58, 415, -206.4017, 2739.6597, 62.3749, -20.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 59, 415, -213.9060, 2739.6597, 62.3749, -20.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 60, 415, -229.8157, 2739.6597, 62.3749, -20.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 61, 415, -237.3771, 2739.6597, 62.3749, -20.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 62, 415, -244.7428, 2739.6597, 62.3749, -20.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 63, 487, -206.7987, 2726.0505, 63.9403, -90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 64, 487, -237.9904, 2726.0505, 63.9403, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 65, 495, -191.3575, 2757.9038, 62.9121, 76.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 66, 495, -183.1648, 2751.9419, 62.9121, 40.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 67, 476, -273.5981, 2627.2722, 63.3771, -90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 68, 468, -323.6600, 2737.0408, 62.2558, 90.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 69, 580, -228.4481, 2609.0706, 62.3690, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 70, 580, -234.4445, 2609.0706, 62.3690, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 71, 587, -210.1274, 2609.2698, 62.3817, 900.0000);
	TDM_CreateVehicle(sessionid, TDM_TEAM_REBEL, 72, 578, -178.7629, 2661.5015, 63.2531, 0.0000);
	return 1;
}

stock TDM_Desert_CallAccode(playerid)
{
	if (GetPlayerInteriorEx(playerid)) {
		return 1;
	}

	if (Mode_GetPlAEValue(playerid, tdm_des_pvAccodeStatus)) {
		return 1;
	}

	Dialog_Show(playerid, Dialog:TDM_Desert_Accode);
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetLocationAEData(sessionid)
{
	AEInfo[sessionid][e_SputnikDoorCountC4] =
	AEInfo[sessionid][e_SputnikDoorStatus] =
	AEInfo[sessionid][e_SputnikDoorTimer] = 0;
	AEInfo[sessionid][e_SputnikLaunchStatus] = false;

	n_for(i, TDM_MAX_TEAMS) {
		AEInfo[sessionid][e_SputnikTeamActive][i] = 0;
	}

	AEInfo[sessionid][e_NucMisStatus] =
	AEInfo[sessionid][e_NucMisTimer] =
	AEInfo[sessionid][e_NucMisStartTeam] = 0;

	n_for(i, TDM_MAX_TEAMS) {
		AEInfo[sessionid][e_NucMisTeamActive][i] = 0;
	}

	AEInfo[sessionid][e_BridgeCountC4] =
	AEInfo[sessionid][e_BridgeTimer] =
	AEInfo[sessionid][e_BridgeStatus] = 0;

	AEInfo[sessionid][e_CraneStatus] =
	AEInfo[sessionid][e_CraneTimer] = 0;

	AEInfo[sessionid][e_TimeStorm] = 0;
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

DialogCreate:TDM_Desert_BuyC4(playerid)
{
	adstr[0] = EOS;
	f(adstr, ""CT_WHITE"Необходимо: {e0bc3a}500 ОМ\n"CT_WHITE"В наличии: {e0bc3a}%i ОМ\n"CT_WHITE"Хотите взять одну взрывчатку?", Mode_GetPlayerMatchPoints(playerid));
	Dialog_Open(playerid, Dialog:TDM_Desert_BuyC4, DSM, "{e03a3a}Взрывчатки", adstr, "Да", "Нет");
	return 1;
}

DialogResponse:TDM_Desert_BuyC4(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	if (TDM_GetPlayerExplosive(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Взрывчатка уже имеется!");
		return 1;	
	}

	if (Mode_GetPlayerMatchPoints(playerid) < 500) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно очков матча!");
		return 1;
	}

	TDM_GivePlayerExplosive(playerid, 1);
	Mode_GivePlayerMatchPoints(playerid, -500);

	SCM(playerid, C_GREEN, ""T_INFO" Взрывчатка успешна куплена!");
	return 1;
}

DialogCreate:TDM_Desert_Nuc(playerid)
{
	new
		str[600];
	
	f(str, "\
	{e6851e}Запуск ядерной ракеты\
	\n\n"CT_WHITE"Стоимость: {e6d21e}600 ОМ\
	\n"CT_WHITE"В наличии: {e6d21e}%i ОМ\
	\n\n{a1a1a1}Информация:\
	\n"CT_WHITE"- Ядерная ракета сотрёт с лица земли только врагов.\
	\n\n{a1a1a1}Требуется:\
	\n"CT_WHITE"- Запустить союзный спутник, он находится в Точке связи.\
	\n- Забрать коды доступа /accode.\
	\n- Вернуться на подлодку и запустить ядерную ракету.",
	Mode_GetPlayerMatchPoints(playerid));

	Dialog_Open(playerid, Dialog:TDM_Desert_Nuc, DSM, "Запуск ядерной ракеты", str, "Запустить", "Отмена");
	return 1;
}

DialogResponse:TDM_Desert_Nuc(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (AEInfo[sessionid][e_SputnikTeamActive][GetPlayerTeamEx(playerid)]) {
		if (!AEInfo[sessionid][e_NucMisTeamActive][GetPlayerTeamEx(playerid)]) {
			if (!AEInfo[sessionid][e_NucMisStatus]) {
				if (Mode_GetPlAEValue(playerid, tdm_des_pvAccodeAttach)) {
					if (Mode_GetPlayerMatchPoints(playerid) >= 600) {
						Mode_SetPlAEValue(playerid, tdm_des_pvAccodeAttach, 0);
						RemovePlayerAttachedObject(playerid, 8);

						AEInfo[sessionid][e_NucMisStatus] = 1;
						AEInfo[sessionid][e_NucMisTimer] += 10;
						AEInfo[sessionid][e_NucMisStartTeam] = GetPlayerTeamEx(playerid);

						adstr[0] = EOS;
						f(adstr, "{d9941c}Запуск через: {db1414}%i {d9941c}секунд", AEInfo[sessionid][e_NucMisTimer]);
						TDM_UpdateAE3DText(sessionid, tdm_des_3dSubmarineNucStart, 0xFFFFFFFF, adstr);
					}
					else {
						SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно очков матча!");
					}
				}
				else {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Необходимо иметь коды доступа!");
				}
			}
			else {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Ядерная ракета уже запущена!");
			}
		}
		else {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Ваша команда больше не может запускать ядерную ракету!");
		}
	}
	else {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Союзный спутник не запущен!");
		SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Спутник находится на Точке связи.");
	}
	return 1;
}

DialogCreate:TDM_Desert_Accode(playerid)
{
	f(adstr, "\
	{eda618}Вызвать аирдроп кодов доступа\
	\n\n"CT_WHITE"Стоимость: {e6d21e}300 ОМ\
	\n"CT_WHITE"В наличии: {e6d21e}%i ОМ\
	\n\n{a1a1a1}Информация:\
	\n"CT_WHITE"- При помощи кодов доступа можно запустить ядерную ракету на подлодке.\
	\n- Коды доступа теряются после смерти.", 
	Mode_GetPlayerMatchPoints(playerid));

	Dialog_Open(playerid, Dialog:TDM_Desert_Accode, DSM, "Вызвать аирдроп кодов доступа", adstr, "Вызвать", "Отмена");
	return 1;
}

DialogResponse:TDM_Desert_Accode(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}
	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (AEInfo[sessionid][e_SputnikTeamActive][GetPlayerTeamEx(playerid)]) {
		if (!AEInfo[sessionid][e_NucMisTeamActive][GetPlayerTeamEx(playerid)]) {
			if (Mode_GetPlayerMatchPoints(playerid) >= 300) {
				new 
					Float:x, Float:y, Float:z;

				GetPlayerPos(playerid, x, y, z);
				
				Mode_SetPlAEValue(playerid, tdm_des_pvAccodeStatus, 1);
				Mode_SetPlAEFloatValue(playerid, tdm_des_pfPosAccode, x, y, z);

				Mode_CreatePlAEObject(playerid, tdm_des_poAccodeSmoke, 18728, x, y, z - 3.0, 0.00000, 0.00000, 0.00000, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid)); // Дым
				Mode_CreatePlAEObject(playerid, tdm_des_poAccodeParachute, 18849, x, y, z + 50.0, 0.00000, 0.00000, 0.00000, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid)); // Мешок с парашютом
				Mode_MovePlAEObject(playerid, tdm_des_poAccodeParachute, x, y, z + 6.0, 8.0, 0.00000, 0.00000, 0.00000);

				ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, true, false, false, false, 0);
				Streamer_Update(playerid);
				StartPlayerTimerClearAnim(playerid, 1000);
			}
			else {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно очков матча!");
			}
		}
		else {
			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Ваша команда больше не может запускать ядерную ракету!");
		}
	}
	else {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Союзный спутник не запущен!");
		SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Спутник находится на Точке связи.");
	}
	return 1;
}

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>------------------<|
 * |   OnGameModeInit   |
 * |>------------------<|
 */

stock TDM_Desert_OnGameModeInit(sessionid)
{
	ResetLocationAEData(sessionid);
	return 1;
}

/*
 * |>-----------------<|
 * |   OnPlayerDeath   |
 * |>-----------------<|
 */

stock TDM_Desert_OnPlayerDeath(playerid, killerid, WEAPON:reason) 
{
	#pragma unused killerid, reason

	Mode_SetPlAEValue(playerid, tdm_des_pvAccodeAttach, 0);
	return 1;
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

stock TDM_Desert_OnPlayerKeySC(playerid, KEY:newkeys, KEY:oldkeys)
{
	#pragma unused oldkeys

	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Mini-games
	switch (GetPlayerMGNum(playerid)) {
		// Start sputnik
		case tdm_des_pgStartSputnik: {
			new 
				bool:check_key;

			n_for(i, MAX_COUNT_RANDOM_KEYS) {
				if (newkeys == KEY:GetRandomKey(i)) {
					check_key = true;
					break;
				}
			}
			if (check_key) {
				if (newkeys == KEY:GetPlayerMGValue(playerid)) {
					if (GetPlayerMGCount(playerid) < 8) {
						new 
							letterValue = random(MAX_COUNT_RANDOM_KEYS);

						f(adstr, "%s%s", GetRandomColorText(random(MAX_COUNT_RANDOM_COLOR)), GetRandomKeyStr(letterValue));
						GameTextForPlayer(playerid, adstr, 2000, 3);

						SetPlayerMGTimer(playerid, 2);
						SetPlayerMGValue(playerid, GetRandomKey(letterValue));
						SetPlayerMGCount(playerid, GetPlayerMGCount(playerid) + 1);
					}
					else {
						ResetPlayerMGData(playerid);
						AEInfo[sessionid][e_SputnikTeamActive][GetPlayerTeamEx(playerid)] = 1;

						SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Союзный спутник успешно запущен! Используйте команду /accode");
						
						m_for(MODE_TDM, sessionid, p) {
							if (GetPlayerTeamEx(p) == GetPlayerTeamEx(playerid)) {
								SCM(p, C_EMERLAND, ""T_MATCH" Запущен союзный спутник!");
							}
						}

						if (GetPlayerTeamEx(playerid) == TDM_TEAM_MILITARY) {
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1UnsichWand1, -363.514038, 1558.963256, 1077.485519, 3.0, -0.900059, 0.300037, 18.999698);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1UnsichWand2, -361.588592, 1558.039306, 1077.481246, 3.0, 0.300000, 0.900072, 108.994934);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1UnsichWand3, -360.500762, 1559.978759, 1077.539413, 3.0, -0.900059, 0.300037, 18.999698);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1UnsichWand4, -362.568878, 1560.885498, 1077.523979, 3.0, 0.300000, 0.900072, 108.994934);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1UnsichWand5, -362.054565, 1559.500732, 1079.312828, 3.0, 1.200000, -89.399818, 18.000005);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1UnsichWand6, -362.019348, 1559.434204, 1075.740043, 3.0, -0.399999, -88.899833, 18.100008);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1Ballon, -362.108306, 1559.581665, 1076.710472, 3.0, -0.900059, 180.300018, 18.999698);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1Column1, -362.313659, 1560.140625, 1076.281608, 3.0, 14.301827, 0.216097, 19.316852);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1Column2, -361.890289, 1558.946533, 1076.366058, 3.0, 16.097709, -0.418800, -160.516418);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1Column3, -361.554046, 1559.682495, 1076.331550, 3.0, 14.891777, -1.029150, -70.361343);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1Column4, -362.611846, 1559.310424, 1076.269882, 3.0, 15.504376, 0.831857, 109.150497);

							TDM_CreateAEObject(sessionid, tdm_des_oSputnik1Flame, 18692, -362.324462, 1559.976684, 77.182815, -177.300262, -1.899999, 4.900002);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik1Flame, -362.324462, 1559.976684, 1077.182815, 3.0, -177.300262, -1.899999, 4.900002);
						}
						else if (GetPlayerTeamEx(playerid) == TDM_TEAM_REBEL) {
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2UnsichWand1, -373.383819, 1551.339965, 1077.485519, 3.0, -0.900057, 0.300044, 18.999698);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2UnsichWand2, -371.458374, 1550.416015, 1077.481246, 3.0, 0.300007, 0.900069, 108.994911);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2UnsichWand3, -370.370544, 1552.355468, 1077.539413, 3.0, -0.900057, 0.300044, 18.999698);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2UnsichWand4, -372.438659, 1553.262207, 1077.523979, 3.0, 0.300007, 0.900069, 108.994911);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2UnsichWand5, -371.924346, 1551.877441, 1079.312828, 3.0, 1.200002, -89.399810, 18.000005);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2UnsichWand6, -371.889129, 1551.810913, 1075.740043, 3.0, -0.399996, -88.899826, 18.100008);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2Ballon, -371.978088, 1551.958374, 1076.710472, 3.0, -0.900057, 180.300018, 18.999698);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2Column1, -372.183441, 1552.517333, 1076.281608, 3.0, 14.301829, 0.216104, 19.316846);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2Column2, -371.760070, 1551.323242, 1076.366058, 3.0, 16.097707, -0.418808, -160.516372);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2Column3, -371.423828, 1552.059204, 1076.331550, 3.0, 14.891769, -1.029148, -70.361335);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2Column4, -372.481628, 1551.687133, 1076.269882, 3.0, 15.504383, 0.831855, 109.150474);

							TDM_CreateAEObject(sessionid, tdm_des_oSputnik2Flame, 18692, -372.194244, 1552.353393, 77.182815, -2.699737, 178.099990, -175.099990);
							TDM_MoveAEObject(sessionid, tdm_des_oSputnik2Flame, -372.194244, 1552.353393, 1077.182815, 3.0, -2.699737, 178.099990, -175.099990);
						}
					}
				}
				else {
					ResetPlayerMGData(playerid);
					SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Вы не смогли запустить спутник.");
				}
			}
			return 1;
		}
	}
	return 0;
}