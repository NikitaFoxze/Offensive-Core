/*

	About: TDM Example location
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		TDM_Example_CreateElements(session_id)
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_LOC_EXAMPLE
	#endinput
#endif
#define _INC_TDM_LOC_EXAMPLE

/*

	* Functions *

*/

stock TDM_Example_CreateElements(session_id)
{
	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_TDM, session_id, Mode_GetBasicVirtualWorld(MODE_TDM, session_id));
	Mode_SetInterior(MODE_TDM, session_id, Mode_GetBasicInterior(MODE_TDM, session_id));

	// Погода
	Mode_SetWeather(MODE_TDM, session_id, 0);

	// Команды
	TDM_AddTeam(session_id, TDM_TEAM_MILITARY, true);
	TDM_AddTeam(session_id, TDM_TEAM_REBEL, true);
	TDM_AddTeam(session_id, TDM_TEAM_BANDIT, true);
	TDM_AddTeam(session_id, TDM_TEAM_MARAUDER, true);

	// Счёт
	TDM_SetTeamChet(session_id, TDM_TEAM_MILITARY, 0, 1000);
	TDM_SetTeamChet(session_id, TDM_TEAM_REBEL, 0, 1000);
	TDM_SetTeamChet(session_id, TDM_TEAM_BANDIT, 0, 1000);
	TDM_SetTeamChet(session_id, TDM_TEAM_MARAUDER, 0, 1000);

	// Время
	TDM_SetTimer(session_id, 30, 0);

	// Лучшие игроки
	TDM_SetSpawnTopBot(session_id, 0, 1885.3085, -2388.3430, 13.5547, 269.9020);
	TDM_SetSpawnTopBot(session_id, 1, 1883.6346, -2389.4019, 13.5547, 269.5493);
	TDM_SetSpawnTopBot(session_id, 2, 1881.6953, -2386.3438, 13.5547, 270.1133);
	TDM_SetSpawnTopBot(session_id, 3, 1878.8070, -2390.8601, 13.5547, 268.9854);
	TDM_SetSpawnTopBot(session_id, 4, 1877.7831, -2384.6487, 13.5547, 272.3694);

	// Камера в конце матча
	TDM_SetCameraEndPos(session_id,
		1956.599853, -2292.645996, 21.267581, 
		1956.569824, -2287.756835, 20.221462);
	TDM_SetCameraEndLookAt(session_id,
		1956.854370, -2334.380126, 30.197145, 
		1956.824340, -2329.490966, 29.151025);
	TDM_SetCameraEndPosTwo(session_id,
		1899.463012, -2388.139892, 13.946519, 
		1894.474975, -2388.470214, 13.844182);

	// Зона локации
	TDM_SetExitZonePos(session_id, 1801.0, -2470.0, 2077.0, -2170.0);

	// Базы команд
	TDM_CreateBaseTeam(session_id, TDM_TEAM_MILITARY, 1884.0, -2257.0, 1945.0, -2178.0);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_MILITARY, 1948.834472, -2260.612548, 23.300148, 1945.205566, -2257.356933, 22.189947);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 0, 1908.6810, -2236.6765, 13.5469);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 1, 1920.6259, -2238.8569, 13.5469);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MILITARY, 2, 1933.3898, -2238.3435, 13.5469);

	TDM_CreateBaseTeam(session_id, TDM_TEAM_REBEL, 1985.0, -2270.0, 2057.0, -2226.0);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_REBEL, 1975.833129, -2273.779052, 22.672546, 1979.582641, -2270.780517, 21.276508);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 0, 2001.0570, -2239.5996, 13.5469);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 1, 2000.0155, -2249.1338, 13.5469);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_REBEL, 2, 2000.5426, -2261.0430, 13.5469);

	TDM_CreateBaseTeam(session_id, TDM_TEAM_BANDIT, 1984.0, -2336.0, 2056.0, -2292.0);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_BANDIT, 1974.012451, -2341.493896, 22.720512, 1977.850219, -2338.586425, 21.371803);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_BANDIT, 0, 2002.2716, -2307.1824, 13.5469);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_BANDIT, 1, 2001.9371, -2317.0061, 13.5469);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_BANDIT, 2, 2001.0249, -2329.9858, 13.5469);

	TDM_CreateBaseTeam(session_id, TDM_TEAM_MARAUDER, 1984.0, -2403.0, 2056.0, -2359.0);
	TDM_SetCameraBaseTeam(session_id, TDM_TEAM_MARAUDER, 1973.218505, -2401.808837, 23.546085, 1977.258544, -2399.295898, 22.008893);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MARAUDER, 0, 2003.9453, -2374.1028, 13.5469);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MARAUDER, 1, 2003.9731, -2383.3804, 13.5469);
	TDM_SetSpawnBaseTeam(session_id, TDM_TEAM_MARAUDER, 2, 2003.4860, -2391.8682, 13.5469);

	// Точки
	TDM_CreateCapturePoint(session_id, 0, "Точка 1", 1957.8914, -2371.5308, 13.5469, 1911.0, -2403.0, 1964.0, -2355.0);
	TDM_SetCameraCapturePoint(session_id, 0, 1973.842041, -2393.959960, 24.683383, 1971.116577, -2390.056396, 23.155523);
	TDM_SetSpawnCapturePoint(session_id, 0, 0, 1964.6163, -2371.5935, 13.5469);
	TDM_SetSpawnCapturePoint(session_id, 0, 1, 1951.2612, -2374.4536, 13.5469);
	TDM_SetSpawnCapturePoint(session_id, 0, 2, 1956.7277, -2363.7258, 13.5469);

	TDM_CreateCapturePoint(session_id, 1, "Точка 2", 1955.0411, -2285.6721, 13.5469, 1913.0, -2315.0, 1962.0, -2267.0);
	TDM_SetCameraCapturePoint(session_id, 1, 1974.395263, -2264.385986, 26.074945, 1971.257080, -2267.842041, 24.284034);
	TDM_SetSpawnCapturePoint(session_id, 1, 0, 1955.7418, -2292.8623, 13.5469);
	TDM_SetSpawnCapturePoint(session_id, 1, 1, 1950.3687, -2283.3633, 13.5469);
	TDM_SetSpawnCapturePoint(session_id, 1, 2, 1960.8149, -2280.6516, 13.5469);

	// Мешки с деньгами
	TDM_CreateBagMoney(session_id, TDM_TEAM_MILITARY, 1893.1827, -2244.4636, 13.5469);
	TDM_CreateBagMoney(session_id, TDM_TEAM_REBEL, 2002.3143, -2230.6094, 13.5469);
	TDM_CreateBagMoney(session_id, TDM_TEAM_BANDIT, 2004.0563, -2334.8459, 13.5469);
	TDM_CreateBagMoney(session_id, TDM_TEAM_MARAUDER, 1996.8668, -2403.9026, 13.5469);

	// Магазины
	TDM_CreateShop(session_id, TDM_TEAM_MILITARY, 1923.7739, -2232.5764, 13.5469);
	TDM_CreateShop(session_id, TDM_TEAM_REBEL, 2003.8550, -2250.0881, 13.5469);
	TDM_CreateShop(session_id, TDM_TEAM_BANDIT, 2004.2003, -2317.7825, 13.5469);
	TDM_CreateShop(session_id, TDM_TEAM_MARAUDER, 2003.4261, -2398.8323, 13.5469);

	// Временные точки
	TDM_CreatePosFastPoint(session_id, 0, 1927.2081, -2309.9180, 13.5469);
	TDM_CreatePosFastPoint(session_id, 1, 1910.5441, -2293.6743, 13.5469);
	TDM_CreatePosFastPoint(session_id, 2, 1967.3385, -2298.3398, 13.5469);
	TDM_CreatePosFastPoint(session_id, 3, 1976.9441, -2328.2476, 13.5469);
	TDM_CreatePosFastPoint(session_id, 4, 1977.0898, -2350.1375, 13.5469);
	return 1;
}