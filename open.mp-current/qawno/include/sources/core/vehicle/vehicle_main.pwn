/*
 * |>=======================<|
 * |   About: Vehicle main   |
 * |   Author: Foxze         |
 * |>=======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
	- OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
	- OnPlayerConnect(playerid)
	- OnPlayerUpdate(playerid)
	- OnVehicleSpawn(vehicleid)
	- OnVehicleDeath(vehicleid, killerid)
	- OnVehicleDamageStatusUpdate(vehicleid, playerid)

	# Technical #
	- CallUpdateVehicle()
 * Stock:
	- CreateVehicleEx(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, addsiren = 0)
	- DestroyVehicleEx(&vehicleid)

	- SetPlayerVehicle(playerid, status)
	- GetPlayerVehicle(playerid)

	- SetPlayerVehicleIDEx(playerid, vehicleid)
	- GetPlayerVehicleIDEx(playerid)

	- SetVehicleMode(vehicleid, modeid)
	- GetVehicleMode(vehicleid)

	- SetVehicleSession(vehicleid, sessionid)
	- GetVehicleSession(vehicleid)

	- SetVehicleID(vehicleid, id)
	- GetVehicleID(vehicleid)

	- SetVehicleTeam(vehicleid, teamid)
	- GetVehicleTeam(vehicleid)

	- SetVehicleVirtualWorldEx(vehicleid, virtualworld)
	- GetVehicleVirtualWorldEx(vehicleid)

	- SetVehicleInteriorEx(vehicleid, interior)
	- GetVehicleInteriorEx(vehicleid)

	- SetVehicleEngine(vehicleid, bool:type)
	- GetVehicleEngine(vehicleid)

	- SetVehicleFuel(vehicleid, fuel)
	- AddVehicleFuel(vehicleid, fuel)
	- TurnVehicleFuel(vehicleid, fuel)
	- GetVehicleFuel(vehicleid)

	- SetVehicleColorEx(vehicleid, color_1, color_2)
	- GetVehicleColorEx(vehicleid, num)

	- SetVehicleRespawnDelayEx(vehicleid, num)
	- GetVehicleRespawnDelayEx(vehicleid)

	- SetVehicleSiren(vehicleid, object)
	- GetVehicleSiren(vehicleid)

	- SetVehicleSpawnCoords(vehicleid, Float:x, Float:y, Float:z, Float:rotation)
	- GetVehicleSpawnCoords(vehicleid, &Float:x, &Float:y, &Float:z, &Float:rotation)

	- GiveVehiclePlayers(vehicleid, num)
	- GetVehiclePlayers(vehicleid)

	- SetVehicleDriverPlayer(vehicleid, playerid)
	- GetVehicleDriverPlayer(vehicleid)

	- EnterPlayerVehicle(playerid, status)
	- ExitPlayerVehicle(playerid)

	- GetVehicleDamageShotTimer(vehicleid)
	- GetVehicleFreeSeat(vehicleid)
	- GetVehicleNearest(playerid)
	- IsVehicleInvalided(vehicleid)
	- OnVehicleDeathPlayer(playerid, &killerid, &reason)
	- SetVehicleDamageShot(vehicleid, playerid, weaponid)
	- ResetVehicleDamageShot(vehicleid)
	- CheckIDVehicleCar(vehicleid)
	- CheckIDVehicleCopter(vehicleid)
	- CheckIDVehicleAir(vehicleid)
	- CheckIDVehicleBoat(vehicleid)
	- CheckIDVehicleMoto(vehicleid)
	- CheckIDVehicleBike(vehicleid)
	- IsPlayerAirVehicle(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_VEHICLE_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- e(playerid)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_VEHICLE_MAIN
	#endinput
#endif
#define _INC_VEHICLE_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	PLAYER_VEHICLE_NONE = 0,
	PLAYER_VEHICLE_DRIVER,
	PLAYER_VEHICLE_PASSENGER 
}

enum E_VEHICLE_INFO {
	e_Mode,
	e_Session,
	e_VehicleID,
	e_TeamID,
	e_Fuel,
	e_Color[2],
	e_RespawnDelay,
	e_Siren,
	e_VirtualWorld,
	e_Interior,
	Float:e_SpawnPosX,
	Float:e_SpawnPosY,
	Float:e_SpawnPosZ,
	Float:e_SpawnRotation,
	bool:e_Engine
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	vInfo[MAX_VEHICLES][E_VEHICLE_INFO],
	PlayersInVehicle[MAX_VEHICLES],
	TotalVehicles;

static
	ActivePlayerVehicleID[MAX_PLAYERS],
	StatusPlayerVehicle[MAX_PLAYERS],
	bool:ActivePlayerSpeedTD[MAX_PLAYERS char];

static
	PlayerText:TD_Speedometer[MAX_PLAYERS][VEHICLE_TD_SPEEDOMETER];

static
	DriverPlayerID[MAX_VEHICLES],
	LastDamagePlayerID[MAX_VEHICLES],
	LastDamageWeaponID[MAX_VEHICLES],
	LastDamageTimer[MAX_VEHICLES];

static const
	VehicleName[][VEHICLE_LENGTH_NAME] = {
	"Landstalker", "Bravura", "Buffalo", "Linerunner", "Pereniel", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus", "Voodoo", "Pony",
	"Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Mr Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
	"Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo", "RC Bandit",
	"Romero", "Packer", "Monster Truck", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee",
	"Caddy", "Solair", "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic", "Sanchez", "Sparrow", "Patriot",
	"Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer",
	"Maverick", "News Chopper", "Rancher", "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick", "Boxville",
	"Benson", "Mesa", "RC Goblin", "Hotring Racer", "Hotring Racer", "Bloodring Banger", "Rancher", "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle",
	"Cropdust", "Stunt", "Tanker", "RoadTrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
	"Fortune", "Cadrona", "FBI Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight", "Streak", "Vortex",
	"Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada",
	"Yosemite", "Windsor", "Monster Truck", "Monster Truck", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma",
	"Savanna", "Bandito", "Freight", "Trailer", "Kart", "Mower", "Duneride", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400",
	"Newsvan", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "Trailer", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "Police Car (LS)",
	"Police Car (SF)", "Police Car (LV)", "Police Ranger", "Picador", "S.W.A.T. Van", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage Trailer", "Luggage Trailer",
	"Stair Trailer", "Boxville", "Farm Plow", "Utility Trailer"
};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>--------------------<|
 * |   Create & destroy   |
 * |>--------------------<|
 */

stock CreateVehicleEx(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, addsiren = 0)
{
	if (TotalVehicles >= MAX_VEHICLES) {
		return INVALID_VEHICLE_ID;
	}

	new
		vehicleid = CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay, addsiren);

	SetVehicleID(vehicleid, vehicleid);
	SetVehicleSpawnCoords(vehicleid, x, y, z, rotation);
	SetVehicleColorEx(vehicleid, color1, color2);
	SetVehicleRespawnDelayEx(vehicleid, respawn_delay);
	SetVehicleSiren(vehicleid, addsiren);

	TotalVehicles++;
	return vehicleid;
}

stock DestroyVehicleEx(&vehicleid)
{
	if (!IsValidVehicle(vehicleid)) {
		return 0;
	}

	DestroyVehicle(vehicleid);
	ResetVehicleData(vehicleid);
	
	vehicleid = INVALID_VEHICLE_ID;

	TotalVehicles--;
	return 1;
}

/*
 * |>------------------<|
 * |   Player vehicle   |
 * |>------------------<|
 */

stock SetPlayerVehicle(playerid, status)
{
	StatusPlayerVehicle[playerid] = status;
	return 1;
}

stock GetPlayerVehicle(playerid)
{
	return StatusPlayerVehicle[playerid];
}

/*
 * |>-------------------------<|
 * |   Vehicle ID for player   |
 * |>-------------------------<|
 */

stock SetPlayerVehicleIDEx(playerid, vehicleid)
{
	ActivePlayerVehicleID[playerid] = vehicleid;
	return 1;
}

stock GetPlayerVehicleIDEx(playerid)
{
	return ActivePlayerVehicleID[playerid];
}

/*
 * |>------------------<|
 * |   Mode & session   |
 * |>------------------<|
 */

stock SetVehicleMode(vehicleid, modeid)
{
	vInfo[vehicleid][e_Mode] = modeid;
	return 1;
}

stock GetVehicleMode(vehicleid)
{
	return vInfo[vehicleid][e_Mode];
}

stock SetVehicleSession(vehicleid, sessionid)
{
	vInfo[vehicleid][e_Session] = sessionid;
	return 1;
}

stock GetVehicleSession(vehicleid)
{
	return vInfo[vehicleid][e_Session];
}

/*
 * |>--------------<|
 * |   Vehicle ID   |
 * |>--------------<|
 */

stock SetVehicleID(vehicleid, id)
{
	vInfo[vehicleid][e_VehicleID] = id;
	return 1;
}

stock GetVehicleID(vehicleid)
{
	return vInfo[vehicleid][e_VehicleID];
}

/*
 * |>--------<|
 * |   Team   |
 * |>--------<|
 */

stock SetVehicleTeam(vehicleid, teamid)
{
	vInfo[vehicleid][e_TeamID] = teamid;
	return 1;
}

stock GetVehicleTeam(vehicleid)
{
	return vInfo[vehicleid][e_TeamID];
}

/*
 * |>-----------------<|
 * |   Virtual world   |
 * |>-----------------<|
 */

stock SetVehicleVirtualWorldEx(vehicleid, virtualworld)
{
	vInfo[vehicleid][e_VirtualWorld] = virtualworld;
	SetVehicleVirtualWorld(vehicleid, virtualworld);
	return 1;
}

stock GetVehicleVirtualWorldEx(vehicleid)
{
	return vInfo[vehicleid][e_VirtualWorld];
}

/*
 * |>------------<|
 * |   Interior   |
 * |>------------<|
 */

stock SetVehicleInteriorEx(vehicleid, interior)
{
	vInfo[vehicleid][e_Interior] = interior;
	LinkVehicleToInterior(vehicleid, interior);
	return 1;
}

stock GetVehicleInteriorEx(vehicleid)
{
	return vInfo[vehicleid][e_Interior];
}

/*
 * |>----------<|
 * |   Engine   |
 * |>----------<|
 */

stock SetVehicleEngine(vehicleid, bool:type)
{
	vInfo[vehicleid][e_Engine] = type;
	return 1;
}

stock GetVehicleEngine(vehicleid)
{
	return vInfo[vehicleid][e_Engine];
}

/*
 * |>--------<|
 * |   Fuel   |
 * |>--------<|
 */

stock SetVehicleFuel(vehicleid, fuel)
{
	vInfo[vehicleid][e_Fuel] = fuel;
	return 1;
}

stock AddVehicleFuel(vehicleid, fuel)
{
	vInfo[vehicleid][e_Fuel] += fuel;
	return 1;
}

stock TurnVehicleFuel(vehicleid, fuel)
{
	vInfo[vehicleid][e_Fuel] -= fuel;
	return 1;
}

stock GetVehicleFuel(vehicleid)
{
	return vInfo[vehicleid][e_Fuel];
}

/*
 * |>---------<|
 * |   Color   |
 * |>---------<|
 */

stock SetVehicleColorEx(vehicleid, color_1, color_2)
{
	vInfo[vehicleid][e_Color][0] = color_1;
	vInfo[vehicleid][e_Color][1] = color_2;

	ChangeVehicleColours(vehicleid, color_1, color_2);
	return 1;
}

stock GetVehicleColorEx(vehicleid, num)
{
	return vInfo[vehicleid][e_Color][num];
}

/*
 * |>-----------------<|
 * |   Respawn delay   |
 * |>-----------------<|
 */

stock SetVehicleRespawnDelayEx(vehicleid, num)
{
	vInfo[vehicleid][e_RespawnDelay] = num;
	return 1;
}

stock GetVehicleRespawnDelayEx(vehicleid)
{
	return vInfo[vehicleid][e_RespawnDelay];
}

/*
 * |>---------<|
 * |   Siren   |
 * |>---------<|
 */

// Not implemented

stock SetVehicleSiren(vehicleid, object)
{
	vInfo[vehicleid][e_Siren] = object;
	return 1;
}

stock GetVehicleSiren(vehicleid)
{
	if (!vInfo[vehicleid][e_Siren]) {
		return 0;
	}

	return 1;
}

/*
 * |>----------------<|
 * |   Spawn coords   |
 * |>----------------<|
 */

stock SetVehicleSpawnCoords(vehicleid, Float:x, Float:y, Float:z, Float:rotation)
{
	vInfo[vehicleid][e_SpawnPosX] = x;
	vInfo[vehicleid][e_SpawnPosY] = y;
	vInfo[vehicleid][e_SpawnPosZ] = z;
	vInfo[vehicleid][e_SpawnRotation] = rotation;
	return 1;
}

stock GetVehicleSpawnCoords(vehicleid, &Float:x, &Float:y, &Float:z, &Float:rotation)
{
	x = vInfo[vehicleid][e_SpawnPosX];
	y = vInfo[vehicleid][e_SpawnPosY];
	z = vInfo[vehicleid][e_SpawnPosZ];
	rotation = vInfo[vehicleid][e_SpawnRotation];
	return 1;
}

/*
 * |>----------------------<|
 * |   Players in vehicle   |
 * |>----------------------<|
 */

stock GiveVehiclePlayers(vehicleid, num)
{
	PlayersInVehicle[vehicleid] += num;
	return 1;
}

stock GetVehiclePlayers(vehicleid)
{
	return PlayersInVehicle[vehicleid];
}

/*
 * |>---------------------<|
 * |   Driver in vehicle   |
 * |>---------------------<|
 */

stock SetVehicleDriverPlayer(vehicleid, playerid)
{
	DriverPlayerID[vehicleid] = playerid;
	return 1;
}

stock GetVehicleDriverPlayer(vehicleid)
{
	return DriverPlayerID[vehicleid];
}

/*
 * |>-------------------------------<|
 * |   Player enter & exit vehicle   |
 * |>-------------------------------<|
 */

stock EnterPlayerVehicle(playerid, status)
{
	switch (status) {
		case PLAYER_VEHICLE_DRIVER: {
			new
				vehicleid = GetPlayerVehicleID(playerid),
				modelid = GetVehicleModel(vehicleid);

			if (GetAdminVehicle(vehicleid)
			&& GetAdminLevel(playerid) == ADM_LEVEL_NONE) {
				RemovePlayerFromVehicle(playerid);
				TogglePlayerControllable(playerid, true);

				SCM(playerid, C_RED, ""T_ERROR"  "CT_WHITE"Данный транспорт доступен только для администрации.");
			}
			switch (modelid) {
				// Tank
				case 432:  {
					if (GetPlayerRank(playerid) < 30) {
						RemovePlayerFromVehicle(playerid);
						TogglePlayerControllable(playerid, true);
						SCM(playerid, C_RED, ""T_ERROR"  "CT_WHITE"Необходим ранг - "CT_YELLOW"30");
					}
				}
			}
			if (!CheckIDVehicleBike(modelid)) {
				if (GetVehicleFuel(vehicleid) < 1) {
					new
						engine, lights, alarm, bonnet,
						boot, objective, doors;

					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleEngine(vehicleid, false);
				}
				ShowPlayerSpeedometer(playerid, vehicleid);

				SCM(playerid, C_ORANGE, ""T_HINT" "CT_WHITE"Нажмите {f0cb16}ALT "CT_WHITE"("CT_YELLOW"/e"CT_WHITE") чтобы завести или заглушить двигатель.");
				CheckPlayerDinaHint(playerid, 9);
			}
			else {
				new
					engine, lights, alarm, bonnet,
					boot, objective, doors;

				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
			}
			SetVehicleDriverPlayer(vehicleid, playerid);

			SetPlayerVehicle(playerid, status);
			SetPlayerVehicleIDEx(playerid, vehicleid);

			GiveVehiclePlayers(vehicleid, 1);
		}
		case PLAYER_VEHICLE_PASSENGER: {
			new 
				vehicleid = GetPlayerVehicleID(playerid);

			SetPlayerVehicle(playerid, status);
			SetPlayerVehicleIDEx(playerid, vehicleid);
			GiveVehiclePlayers(vehicleid, 1);

			if (GetPlayerWeapon(playerid) == WEAPON_DEAGLE)  {
				SetPlayerArmedWeapon(playerid, WEAPON_FIST);
			}
		}
	}
	return 1;
}

stock ExitPlayerVehicle(playerid)
{
	switch (GetPlayerVehicle(playerid)) {
		case PLAYER_VEHICLE_DRIVER: {
			new 
				vehicleid = GetPlayerVehicleIDEx(playerid);
				
			SetPlayerVehicle(playerid, PLAYER_VEHICLE_NONE);
			
			if (vehicleid != INVALID_VEHICLE_ID) {
				if (!CheckIDVehicleBike(GetVehicleModel(vehicleid))) {
					HidePlayerSpeedometer(playerid);
				}

				new
					Float:playerHealth;

				GetPlayerHealth(playerid, playerHealth);

				if (playerHealth > 0.0) {
					GiveVehiclePlayers(vehicleid, -1);
					SetPlayerVehicleIDEx(playerid, INVALID_VEHICLE_ID);
					if (GetVehiclePlayers(vehicleid) == 0
					&& GetVehicleDamageShotTimer(vehicleid) > 0) {
						SetVehicleDriverPlayer(vehicleid, INVALID_PLAYER_ID);
						ResetVehicleDamageShot(vehicleid);
					}
				}
			}
		}
		case PLAYER_VEHICLE_PASSENGER: {
			new 
				vehicleid = GetPlayerVehicleIDEx(playerid);

			SetPlayerVehicle(playerid, PLAYER_VEHICLE_NONE);

			if (vehicleid != INVALID_VEHICLE_ID) {
				new 
					Float:playerHealth;

				GetPlayerHealth(playerid, playerHealth);

				if (playerHealth > 0.0) {
					GiveVehiclePlayers(vehicleid, -1);
					SetPlayerVehicleIDEx(playerid, INVALID_VEHICLE_ID);
					if (GetVehiclePlayers(vehicleid) == 0
					&& GetVehicleDamageShotTimer(vehicleid) > 0) {
						SetVehicleDriverPlayer(vehicleid, INVALID_PLAYER_ID);
						ResetVehicleDamageShot(vehicleid);
					}
				}
			}
		}
	}
	return 1;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

stock GetVehicleDamageShotTimer(vehicleid)
{
	return LastDamageTimer[vehicleid];
}

stock GetVehicleFreeSeat(vehicleid)
{
	if (GetVehiclePlayers(vehicleid) < GetVehicleSeats(GetVehicleModel(vehicleid))) {
		return GetVehiclePlayers(vehicleid);
	}
	return -1;
}

stock GetVehicleNearest(playerid)
{
	for (new i = 1, Float:x, Float:y, Float:z; i < MAX_VEHICLES; ++i) {
		if (IsVehicleStreamedIn(i, playerid)) {
			if (GetVehicleVirtualWorldEx(i) == GetPlayerVirtualWorldEx(playerid)
			&& GetVehicleInteriorEx(i) == GetPlayerInteriorEx(playerid)) {
				GetVehiclePos(i, x, y, z);

				if (IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z)) {
					return i;
				}
			}
		}
	}
	return 0;
}

stock IsVehicleInvalided(vehicleid)
{
	if (vehicleid == INVALID_VEHICLE_ID) {
		return 0;
	}
	return 1;
}

stock OnVehicleDeathPlayer(playerid, &killerid, &reason)
{
	if (GetPlayerVehicleIDEx(playerid) == INVALID_VEHICLE_ID) {
		return 0;
	}

	new 
		vehicleid = GetPlayerVehicleIDEx(playerid),
		killerid_2 = LastDamagePlayerID[vehicleid];

	if (killerid_2 != INVALID_PLAYER_ID
		&& IsPlayerOnServer(killerid_2)
		&& Mode_IsPlayerInPlayer(playerid, killerid_2) 
		&& GetPlayerTeamEx(killerid_2) != GetPlayerTeamEx(playerid)) {

		if (DriverPlayerID[vehicleid] == playerid) {
			DriverPlayerID[vehicleid] = INVALID_PLAYER_ID;
		}

		PlayersInVehicle[vehicleid]--;
		
		killerid = killerid_2;
		reason = LastDamageWeaponID[vehicleid];

		if (PlayersInVehicle[vehicleid] == 0) {
			ResetVehicleDamageShot(vehicleid);
		}
	}
	else {
		PlayersInVehicle[vehicleid]--;

		if (PlayersInVehicle[vehicleid] == 0) {
			ResetVehicleDamageShot(vehicleid);
		}
	}
	return 1;
}

stock SetVehicleDamageShot(vehicleid, playerid, weaponid)
{
	LastDamagePlayerID[vehicleid] = playerid;
	LastDamageWeaponID[vehicleid] = weaponid;
	LastDamageTimer[vehicleid] = VEHICLE_TIMER_LAST_DAMAGE;
	return 1;
}

stock ResetVehicleDamageShot(vehicleid)
{
	LastDamagePlayerID[vehicleid] = INVALID_PLAYER_ID;
	LastDamageWeaponID[vehicleid] = -1;

	LastDamageTimer[vehicleid] = 0;
	return 1;
}

stock CheckIDVehicleCar(vehicleid)
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch (modelid) {
		/* Light vehicles */
		case 400, 401, 402, 404, 405, 409, 410, 411, 412, 415, 419, 420, 421, 422, 424, 426, 429, 432, 434, 436, 438, 439, 441, 442, 444, 445, 451, 457, 458, 466, 467, 470, 474, 475, 477, 478, 479,
		480, 485, 486, 489, 490, 491, 492, 494, 495, 496, 500, 502, 503, 504, 505, 506, 507, 516, 517, 518, 525, 526, 527, 528, 529, 530, 531, 533, 534, 535, 536, 539, 540, 541, 542, 543, 545, 546,
		547, 549, 550, 551, 552, 554, 555, 556, 557, 558, 559, 560, 561, 562, 564, 565, 566, 567, 568, 571, 572, 574, 575, 576, 579, 580, 583, 585, 587, 589, 594, 596, 597, 598, 599, 600, 601, 602, 
		603, 604, 605, 606, 607, 608: return modelid;

		/* Trucks */ 
		case 403, 406, 407, 408, 413, 414, 416, 418, 423, 427, 428, 431, 433, 435, 437, 440, 443, 449, 450, 455, 456, 459, 482, 483, 498, 499, 508, 514, 515, 524, 532, 537, 538, 544, 569, 570, 573,
		578, 582, 584, 588, 590, 591, 609, 610: return modelid;
	}

	return 0;
}

stock CheckIDVehicleCopter(vehicleid) // Helicopters
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch (modelid) {
		case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return modelid;
	}
	return 0;
}

stock CheckIDVehicleAir(vehicleid) // Aircraft
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch (modelid) {
		case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return modelid;
	}
	return 0;
}

stock CheckIDVehicleBoat(vehicleid) // Boats
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch (modelid) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return modelid;
	}
	return 0;
}

stock CheckIDVehicleMoto(vehicleid) // Motorcycles
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch (modelid) {
		case 448, 461, 462, 463, 468, 471, 521, 522, 523, 581, 586: return modelid;
	}
	return 0;
}

stock CheckIDVehicleBike(vehicleid) // Bicycles
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch (modelid) {
		case 481, 509, 510: return modelid;	
	}
	return 0;
}

stock IsPlayerAirVehicle(playerid) // Airplanes and helicopters
{
	new
		modelid = GetVehicleModel(GetPlayerVehicleID(playerid));

	switch (modelid) {
		case 417, 425, 447, 460, 464, 465, 469, 476,
		487, 488, 497, 501, 511, 512, 513, 519, 520,
		548, 553, 563, 577, 592, 593: return modelid;
	}

	return 0;
}

public: CallUpdateVehicle()
{
	n_for(v, MAX_VEHICLES) {
		UpdateVehicleData(v);
	}
}

static UpdateVehicleData(vehicleid)
{
	// Mode_VehicleReInfo(vehicleid);

	new
		engine, lights, alarm, bonnet,
		boot, objective, doors;

	if (LastDamageTimer[vehicleid] > 0) {
		LastDamageTimer[vehicleid]--;
	}
	else {
		ResetVehicleDamageShot(vehicleid);
	}

	if (!CheckIDVehicleBike(vehicleid)) { 
		if (GetVehicleEngine(vehicleid)) {
			if (GetVehicleFuel(vehicleid) > 0) {
				TurnVehicleFuel(vehicleid, 1);
			}
			else {
				SetVehicleEngine(vehicleid, false);
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
			}
		}
	}
	return 1;
}

static GetVehicleSpeed(vehicleid)
{
	new
		Float:X, Float:Y, Float:Z;

	GetVehicleVelocity(vehicleid, X, Y,Z);
	return floatround(floatsqroot( X * X + Y * Y + Z * Z ) * 100.0);
}

static UpdatePlayerInVehicle(playerid)
{
	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) {
		return 1;
	}

	new
		vehicleid = GetPlayerVehicleID(playerid),
		Float:vehicleHealth;

	GetVehicleHealth(vehicleid, vehicleHealth);

	PlayerTextDrawSetString(playerid, TD_Speedometer[playerid][8], "%i_L", GetVehicleFuel(vehicleid));
	PlayerTextDrawSetString(playerid, TD_Speedometer[playerid][7], "%.0f%", vehicleHealth/10);
	PlayerTextDrawSetString(playerid, TD_Speedometer[playerid][4], "%i", GetVehicleSpeed(vehicleid));
	return 1;
}

static ShowPlayerSpeedometer(playerid, vehicleid = 400)
{
	if (ActivePlayerSpeedTD{playerid}) {
		return 1;
	}

	if (vehicleid == INVALID_VEHICLE_ID) {
		return 1;
	}

	ActivePlayerSpeedTD{playerid} = true;

	static
		str[VEHICLE_LENGTH_NAME];

	str[0] = EOS;

	strcopy(str, VehicleName[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400], VEHICLE_LENGTH_NAME);

	CreatePlayerVehSpeedometerTD(playerid, TD_Speedometer[playerid]);

	PlayerTextDrawSetString(playerid, TD_Speedometer[playerid][3], str);

	if (!GetVehicleEngine(vehicleid)) {
		PlayerTextDrawBackgroundColour(playerid, TD_Speedometer[playerid][0], 0xa31717FF);
	}
	else {
		PlayerTextDrawBackgroundColour(playerid, TD_Speedometer[playerid][0], 0x29a317FF);
	}

	n_for(i, VEHICLE_TD_SPEEDOMETER) {
		PlayerTextDrawShow(playerid, TD_Speedometer[playerid][i]);
	}
	return 1;
}

static HidePlayerSpeedometer(playerid)
{
	if (!ActivePlayerSpeedTD{playerid}) {
		return 1;
	}

	ActivePlayerSpeedTD{playerid} = false;

	n_for(i, VEHICLE_TD_SPEEDOMETER) {
		DestroyPlayerTD(playerid, TD_Speedometer[playerid][i]);
	}
	return 1;
}

/*
 * |>----------------<|
 * |     Commands     |
 * |>----------------<|
 */

CMD:e(playerid)
{
	if (GetPlayerState(playerid) != PLAYER_STATE_DRIVER) {
		return 1;
	}

	new
		engine, lights, alarm,
		bonnet, boot, objective, doors,
		vehicleid = GetPlayerVehicleID(playerid);

	if (CheckIDVehicleBike(vehicleid)) {
		return 1;
	}

	if (!CheckIDVehicleBike(vehicleid) || !CheckIDVehicleAir(vehicleid)) {
		if (GetVehicleFuel(vehicleid) <= 0) {
			SetVehicleEngine(vehicleid, false);
			GetVehicleParamsEx(vehicleid, engine,lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
			return 1;
		}
		else if (GetVehicleFuel(vehicleid) > 0) {
			if (!GetVehicleEngine(vehicleid)) {
				SetVehicleEngine(vehicleid, true);
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);
			}
			else {
				SetVehicleEngine(vehicleid, false);
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
			}
		}
	}
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetVehicleData(vehicleid)
{
	PlayersInVehicle[vehicleid] = 0;

	SetVehicleMode(vehicleid, 0);
	SetVehicleSession(vehicleid, 0);
	SetVehicleID(vehicleid, INVALID_VEHICLE_ID);
	SetVehicleTeam(vehicleid, 0);
	SetVehicleFuel(vehicleid, VEHICLE_FUEL);
	SetVehicleColorEx(vehicleid, -1, -1);
	SetVehicleRespawnDelayEx(vehicleid, VEHICLE_RESPAWN_TIME);
	SetVehicleSiren(vehicleid, 0);
	SetVehicleVirtualWorldEx(vehicleid, 0);
	SetVehicleInteriorEx(vehicleid, 0);
	SetVehicleSpawnCoords(vehicleid, 0.0, 0.0, 0.0, 0.0);
	SetVehicleEngine(vehicleid, false);

	SetVehicleDriverPlayer(vehicleid, INVALID_PLAYER_ID);
	ResetVehicleDamageShot(vehicleid);
	return 1;
}

static ResetPlayerVehicleData(playerid)
{
	ActivePlayerVehicleID[playerid] = INVALID_VEHICLE_ID;

	StatusPlayerVehicle[playerid] = PLAYER_VEHICLE_NONE;
	ActivePlayerSpeedTD{playerid} = false;
	return 1;
}

static ResetPlayerVehicleTDs(playerid)
{
	n_for(t, VEHICLE_TD_SPEEDOMETER) {
		TD_Speedometer[playerid][t] = INVALID_PLAYER_TEXT_DRAW;
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

public OnGameModeInit()
{
	n_for(v, MAX_VEHICLES) {
		ResetVehicleData(v);
	}

	SetTimer("CallUpdateVehicle", 10000, true);

	#if defined Veh_OnGameModeInit
		return Veh_OnGameModeInit();
	#else
		return 1;
	#endif
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if (newkeys & KEY_FIRE) {
		// Vehicle
		if (GetPlayerState(playerid) == PLAYER_STATE_DRIVER) {
			new
				vehicleid = GetPlayerVehicleID(playerid);

			if (!CheckIDVehicleBike(GetVehicleModel(vehicleid))) {
				new
					engine, lights, alarm,
					bonnet, boot, objective, doors;

				if (GetVehicleFuel(vehicleid) <= 0) {
					SetVehicleEngine(vehicleid, false);
					GetVehicleParamsEx(vehicleid, engine,lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
					return 1;
				}
				else if (GetVehicleFuel(vehicleid) > 0) {
					if (!GetVehicleEngine(vehicleid)) {
						SetVehicleEngine(vehicleid, true);
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);
					}
					else {
						SetVehicleEngine(vehicleid, false);
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
					}
				}

				// Speedometer
				if (!GetVehicleEngine(vehicleid)) {
					PlayerTextDrawBackgroundColour(playerid, TD_Speedometer[playerid][0], 0xa31717FF);
					PlayerTextDrawShow(playerid, TD_Speedometer[playerid][0]);
				}
				else {
					PlayerTextDrawBackgroundColour(playerid, TD_Speedometer[playerid][0], 0x29a317FF);
					PlayerTextDrawShow(playerid, TD_Speedometer[playerid][0]);
				}
			}
		}
	}

	// In transport H
	if (newkeys & KEY_CROUCH) {
		// Ejection player
		if (IsPlayerInAnyVehicle(playerid)
		&& CheckIDVehicleAir(GetPlayerVehicleID(playerid))) {
			new
				Float:posX, Float:posY, Float:posZ;

			GetPlayerPos(playerid, posX, posY, posZ);
			SetPlayerPosEx(playerid, posX, posY, posZ + 15.0, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
			GivePlayerWeapon(playerid, WEAPON_PARACHUTE, 1);

			// To prevent the player from pressing the H key again
			SetPlayerAntiKeys(playerid, KEY_CTRL_BACK);
			PlayerPlaySoundEx(playerid, 25601, 0.0, 0.0, 0.0);
		}
	}

	#if defined Veh_OnPlayerKeyStateChange
		return Veh_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}

/*
 * |>-----------------------<|
 * |   OnPlayerStateChange   |
 * |>-----------------------<|
 */

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	switch (newstate) {
		case PLAYER_STATE_DRIVER: {
			EnterPlayerVehicle(playerid, PLAYER_VEHICLE_DRIVER);
		}
		case PLAYER_STATE_PASSENGER: {
			EnterPlayerVehicle(playerid, PLAYER_VEHICLE_PASSENGER);
		}
	}
	switch (oldstate) {
		case PLAYER_STATE_DRIVER: {
			ExitPlayerVehicle(playerid);
		}
		case PLAYER_STATE_PASSENGER: {
			ExitPlayerVehicle(playerid);
		}
	}

	#if defined Veh_OnPlayerStateChange
		return Veh_OnPlayerStateChange(playerid, newstate, oldstate);
	#else
		return 1;
	#endif
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerVehicleData(playerid);
	ResetPlayerVehicleTDs(playerid);

	#if defined Veh_OnPlayerConnect
		return Veh_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>------------------<|
 * |   OnPlayerUpdate   |
 * |>------------------<|
 */

public OnPlayerUpdate(playerid)
{
	UpdatePlayerInVehicle(playerid);

	#if defined Veh_OnPlayerUpdate
		return Veh_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>------------------<|
 * |   OnVehicleSpawn   |
 * |>------------------<|
 */

public OnVehicleSpawn(vehicleid)
{
	SetVehicleEngine(vehicleid, false);
	SetVehicleFuel(vehicleid, VEHICLE_FUEL);

	SetVehicleDriverPlayer(vehicleid, INVALID_PLAYER_ID);
	ResetVehicleDamageShot(vehicleid);

	#if defined Veh_OnVehicleSpawn
		return Veh_OnVehicleSpawn(vehicleid);
	#else
		return 1;
	#endif
}

/*
 * |>------------------<|
 * |   OnVehicleDeath   |
 * |>------------------<|
 */

public OnVehicleDeath(vehicleid, killerid)
{
	#if defined Veh_OnVehicleDeath
		return Veh_OnVehicleDeath(vehicleid, killerid);
	#else
		return 1;
	#endif
}

/*
 * |>-------------------------------<|
 * |   OnVehicleDamageStatusUpdate   |
 * |>-------------------------------<|
 */

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	if (DriverPlayerID[vehicleid] != INVALID_PLAYER_ID) {
		if (!GetPlayerDamage(DriverPlayerID[vehicleid])) {
			new 
				Float:vehicleHealth;

			GetVehicleHealth(vehicleid, vehicleHealth);
			SetVehicleHealth(vehicleid, vehicleHealth);
		}
	}

	#if defined Veh_OnVehicleDamageStatusUp
		return Veh_OnVehicleDamageStatusUp(vehicleid, playerid);
	#else
		return 1;
	#endif
}

/*
 * |>-------<|
 * |   ALS   |
 * |>-------<|
 */

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit Veh_OnGameModeInit
#if defined Veh_OnGameModeInit
	forward Veh_OnGameModeInit();
#endif


#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif
#define OnPlayerKeyStateChange Veh_OnPlayerKeyStateChange
#if defined Veh_OnPlayerKeyStateChange
	forward Veh_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys);
#endif


#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange Veh_OnPlayerStateChange
#if defined Veh_OnPlayerStateChange
	forward Veh_OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate);
#endif


#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect Veh_OnPlayerConnect
#if defined Veh_OnPlayerConnect
	forward Veh_OnPlayerConnect(playerid);
#endif


#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif
#define OnPlayerUpdate Veh_OnPlayerUpdate
#if defined Veh_OnPlayerUpdate
	forward Veh_OnPlayerUpdate(playerid);
#endif


#if defined _ALS_OnVehicleSpawn
	#undef OnVehicleSpawn
#else
	#define _ALS_OnVehicleSpawn
#endif
#define OnVehicleSpawn Veh_OnVehicleSpawn
#if defined Veh_OnVehicleSpawn
	forward Veh_OnVehicleSpawn(vehicleid);
#endif


#if defined _ALS_OnVehicleDeath
	#undef OnVehicleDeath
#else
	#define _ALS_OnVehicleDeath
#endif
#define OnVehicleDeath Veh_OnVehicleDeath
#if defined Veh_OnVehicleDeath
	forward Veh_OnVehicleDeath(vehicleid, killerid);
#endif


#if defined _ALS_OnVehicleDamageStatusUpdat\
	|| defined _ALS_OnVehicleDamageStatusUpd
	#undef OnVehicleDamageStatusUpdate
#else
	#define _ALS_OnVehicleDamageStatusUpdat
	#define _ALS_OnVehicleDamageStatusUpd
#endif
#define OnVehicleDamageStatusUpdate Veh_OnVehicleDamageStatusUp
#if defined Veh_OnVehicleDamageStatusUp
	forward Veh_OnVehicleDamageStatusUp(vehicleid, playerid);
#endif