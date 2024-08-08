/*

	About: Vehicle system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
		OnPlayerStateChange(playerid, newstate, oldstate)
		OnPlayerConnect(playerid)
		OnPlayerUpdate(playerid)
		OnVehicleSpawn(vehicleid)
		OnVehicleDeath(vehicleid, killerid)
		OnVehicleDamageStatusUpdate(vehicleid, playerid)
		Veh_Update()
	Stock:
		CreateVehicleEx(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, addsiren = 0)
		DestroyVehicleEx(&vehicleid)
		IsVehicleInvalided(vehicleid)
		SetPlayerVehicle(playerid, bool:type)
		GetPlayerVehicle(playerid)
		SetPlayerVehicleIDEx(playerid, vehicle_id)
		GetPlayerVehicleIDEx(playerid)
		Veh_SetMode(vehicleid, mode_id)
		Veh_GetMode(vehicleid)
		Veh_SetSession(vehicleid, session_id)
		Veh_GetSession(vehicleid)
		Veh_SetID(vehicleid, id)
		Veh_GetID(vehicleid)
		Veh_SetTeam(vehicleid, team_id)
		Veh_GetTeam(vehicleid)
		Veh_SetVirtualWorld(vehicleid, virtualworld)
		Veh_GetVirtualWorld(vehicleid)
		Veh_SetInterior(vehicleid, interior)
		Veh_GetInterior(vehicleid)
		Veh_SetEngine(vehicleid, bool:type)
		Veh_GetEngine(vehicleid)
		Veh_SetFuel(vehicleid, fuel)
		Veh_AddFuel(vehicleid, fuel)
		Veh_TurnFuel(vehicleid, fuel)
		Veh_GetFuel(vehicleid)
		Veh_SetColor(vehicleid, color_1, color_2)
		Veh_GetColor(vehicleid, num)
		Veh_SetRespawnDelay(vehicleid, num)
		Veh_GetRespawnDelay(vehicleid)
		Veh_SetSiren(vehicleid, object)
		Veh_GetSiren(vehicleid)
		Veh_SetSpawnCoords(vehicleid, Float:x, Float:y, Float:z, Float:rotation)
		Veh_GetSpawnCoords(vehicleid, &Float:x, &Float:y, &Float:z, &Float:rotation)
		Veh_GivePlayers(vehicleid, num)
		Veh_GetPlayers(vehicleid)
		Veh_SetDriverPlayer(vehicleid, playerid)
		Veh_GetDriverPlayer(vehicleid)
		Veh_GetDamageShotTimer(vehicleid)
		Veh_GetFreeSeat(vehicleid)
		Veh_GetNearest(playerid)
		Veh_DeathPlayer(playerid, &killerid, &reason)
		Veh_SetDamageShot(vehicleid, playerid, weaponid)
		Veh_ResetDamageShot(vehicleid)
		CheckIDVehicleCar(vehicleid)
		CheckIDVehicleCopter(vehicleid)
		CheckIDVehicleAir(vehicleid)
		CheckIDVehicleBoat(vehicleid)
		CheckIDVehicleMoto(vehicleid)
		CheckIDVehicleBike(vehicleid)
		IsPlayerAirVehicle(playerid)
Enums:
	E_VEHICLE_INFO
Commands:
	e(playerid)
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_VEHICLE_SYSTEM
	#endinput
#endif
#define _INC_VEHICLE_SYSTEM

/*

	* Enums *

*/

enum E_VEHICLE_INFO {
	v_Mode,
	v_Session,
	v_VehicleID,
	v_TeamID,
	v_Fuel,
	v_Color[2],
	v_RespawnDelay,
	v_Siren,
	v_VirtualWorld,
	v_Interior,
	Float:v_X,
	Float:v_Y,
	Float:v_Z,
	Float:v_Rotation,
	bool:v_Engine
}

/*

	* Vars *

*/

static
	vInfo[MAX_VEHICLES][E_VEHICLE_INFO],
	vPlayersInVehicle[MAX_VEHICLES],
	vCountVehicles;

static
	vActivePlayerVehicleID[MAX_PLAYERS],
	bool:vActivePlayerVehicle[MAX_PLAYERS char],
	bool:vActivePlayerTDSpeed[MAX_PLAYERS char];

static
	PlayerText:TD_vSpeedometer[MAX_PLAYERS][10];

static
	VEH_DriverPlayerID[MAX_VEHICLES],
	VEH_OldDamagePlayerID[MAX_VEHICLES],
	VEH_OldDamageWeaponID[MAX_VEHICLES],
	VEH_OldDamageTimer[MAX_VEHICLES];

static const
	vCarname[][VEHICLE_STRING_NAME_LENGTH] = {
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

static const
	vMaxSeats[] = {
	3,1,1,1,3,3,0,1,1,3,1,1,1,3,1,1,3,1,3,1,3,
	3,1,1,1,0,3,3,3,1,0,8,0,1,1,15,1,8,3,1,3,0,
	1,1,1,3,0,1,0,1,15,1,0,0,0,1,1,1,3,3,1,1,1,
	1,1,1,3,3,1,1,3,1,0,0,1,1,0,1,1,3,1,0,3,1,
	0,0,0,3,1,1,3,1,3,0,1,1,1,3,3,1,1,1,1,1,1,
	1,1,3,1,0,0,1,0,0,1,1,3,1,1,0,0,1,1,1,1,1,
	1,1,1,3,0,0,0,1,1,1,1,2,2,0,3,1,1,1,1,1,3,
	3,1,1,3,3,1,0,1,1,1,1,1,1,3,3,1,1,0,1,3,3,
	0,15,1,0,0,1,0,1,1,1,1,3,3,1,3,0,15,3,1,1,1,
	1,15,15,1,1,1,0,3,3,3,1,1,1,1,1,3,1,15,15,15,3,
	15,15
};

/*

	* Functions *

*/

stock CreateVehicleEx(vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1, color2, respawn_delay, addsiren = 0)
{
	if(vCountVehicles >= MAX_VEHICLES)
		return INVALID_VEHICLE_ID;

	new
		vehicleid = CreateVehicle(vehicletype, x, y, z, rotation, color1, color2, respawn_delay, addsiren);

	Veh_SetID(vehicleid, vehicleid);
	Veh_SetSpawnCoords(vehicleid, x, y, z, rotation);
	Veh_SetColor(vehicleid, color1, color2);
	Veh_SetRespawnDelay(vehicleid, respawn_delay);
	Veh_SetSiren(vehicleid, addsiren);

	vCountVehicles++;
	return vehicleid;
}

stock DestroyVehicleEx(&vehicleid)
{
	if(!IsValidVehicle(vehicleid))
		return 0;

	DestroyVehicle(vehicleid);
	ResetVehicle(vehicleid);
	
	vehicleid = INVALID_VEHICLE_ID;

	vCountVehicles--;
	return 1;
}

stock IsVehicleInvalided(vehicleid)
{
	if(vehicleid == INVALID_VEHICLE_ID)
		return 0;

	return 1;
}

stock SetPlayerVehicle(playerid, bool:type)
{
	vActivePlayerVehicle[playerid] = type;
	return 1;
}

stock GetPlayerVehicle(playerid)
{
	return vActivePlayerVehicle[playerid];
}

stock SetPlayerVehicleIDEx(playerid, vehicle_id)
{
	vActivePlayerVehicleID[playerid] = vehicle_id;
	return 1;
}

stock GetPlayerVehicleIDEx(playerid)
{
	return vActivePlayerVehicleID[playerid];
}

stock Veh_SetMode(vehicleid, mode_id)
{
	vInfo[vehicleid][v_Mode] = mode_id;
	return 1;
}

stock Veh_GetMode(vehicleid)
{
	return vInfo[vehicleid][v_Mode];
}

stock Veh_SetSession(vehicleid, session_id)
{
	vInfo[vehicleid][v_Session] = session_id;
	return 1;
}

stock Veh_GetSession(vehicleid)
{
	return vInfo[vehicleid][v_Session];
}

stock Veh_SetID(vehicleid, id)
{
	vInfo[vehicleid][v_VehicleID] = id;
	return 1;
}

stock Veh_GetID(vehicleid)
{
	return vInfo[vehicleid][v_VehicleID];
}

stock Veh_SetTeam(vehicleid, team_id)
{
	vInfo[vehicleid][v_TeamID] = team_id;
	return 1;
}

stock Veh_GetTeam(vehicleid)
{
	return vInfo[vehicleid][v_TeamID];
}

stock Veh_SetVirtualWorld(vehicleid, virtualworld)
{
	vInfo[vehicleid][v_VirtualWorld] = virtualworld;
	SetVehicleVirtualWorld(vehicleid, virtualworld);
	return 1;
}

stock Veh_GetVirtualWorld(vehicleid)
{
	return vInfo[vehicleid][v_VirtualWorld];
}

stock Veh_SetInterior(vehicleid, interior)
{
	vInfo[vehicleid][v_Interior] = interior;
	LinkVehicleToInterior(vehicleid, interior);
	return 1;
}

stock Veh_GetInterior(vehicleid)
{
	return vInfo[vehicleid][v_Interior];
}

stock Veh_SetEngine(vehicleid, bool:type)
{
	vInfo[vehicleid][v_Engine] = type;
	return 1;
}

stock Veh_GetEngine(vehicleid)
{
	return vInfo[vehicleid][v_Engine];
}

stock Veh_SetFuel(vehicleid, fuel)
{
	vInfo[vehicleid][v_Fuel] = fuel;
	return 1;
}

stock Veh_AddFuel(vehicleid, fuel)
{
	vInfo[vehicleid][v_Fuel] += fuel;
	return 1;
}

stock Veh_TurnFuel(vehicleid, fuel)
{
	vInfo[vehicleid][v_Fuel] -= fuel;
	return 1;
}

stock Veh_GetFuel(vehicleid)
{
	return vInfo[vehicleid][v_Fuel];
}

stock Veh_SetColor(vehicleid, color_1, color_2)
{
	vInfo[vehicleid][v_Color][0] = color_1;
	vInfo[vehicleid][v_Color][1] = color_2;

	ChangeVehicleColor(vehicleid, color_1, color_2);
	return 1;
}

stock Veh_GetColor(vehicleid, num)
{
	return vInfo[vehicleid][v_Color][num];
}

stock Veh_SetRespawnDelay(vehicleid, num)
{
	vInfo[vehicleid][v_RespawnDelay] = num;
	return 1;
}

stock Veh_GetRespawnDelay(vehicleid)
{
	return vInfo[vehicleid][v_RespawnDelay];
}

// Не реализовано

stock Veh_SetSiren(vehicleid, object)
{
	vInfo[vehicleid][v_Siren] = object;
	return 1;
}

stock Veh_GetSiren(vehicleid)
{
	if(!vInfo[vehicleid][v_Siren])
		return 0;
	else 
		return 1;

	return 0;
}

//

stock Veh_SetSpawnCoords(vehicleid, Float:x, Float:y, Float:z, Float:rotation)
{
	vInfo[vehicleid][v_X] = x;
	vInfo[vehicleid][v_Y] = y;
	vInfo[vehicleid][v_Z] = z;
	vInfo[vehicleid][v_Rotation] = rotation;
	return 1;
}

stock Veh_GetSpawnCoords(vehicleid, &Float:x, &Float:y, &Float:z, &Float:rotation)
{
	x = vInfo[vehicleid][v_X];
	y = vInfo[vehicleid][v_Y];
	z = vInfo[vehicleid][v_Z];
	rotation = vInfo[vehicleid][v_Rotation];
	return 1;
}

stock Veh_GivePlayers(vehicleid, num)
{
	vPlayersInVehicle[vehicleid] += num;
	return 1;
}

stock Veh_GetPlayers(vehicleid)
{
	return vPlayersInVehicle[vehicleid];
}

stock Veh_SetDriverPlayer(vehicleid, playerid)
{
	VEH_DriverPlayerID[vehicleid] = playerid;
	return 1;
}

stock Veh_GetDriverPlayer(vehicleid)
{
	return VEH_DriverPlayerID[vehicleid];
}

stock Veh_GetDamageShotTimer(vehicleid)
{
	return VEH_OldDamageTimer[vehicleid];
}

stock Veh_GetFreeSeat(vehicleid)
{
	if(Veh_GetPlayers(vehicleid) < GetVehicleMaxSeat(vehicleid) + 1)
		return Veh_GetPlayers(vehicleid);
	else
		return -1;
}

stock Veh_GetNearest(playerid)
{
	for(new i = 1, Float:x, Float:y, Float:z; i < MAX_VEHICLES; ++i) {
		if(IsVehicleStreamedIn(i, playerid)) {
			if(GetVehicleVirtualWorld(i) == GetPlayerVirtualWorldEx(playerid)) {
				GetVehiclePos(i, x, y, z);

				if(IsPlayerInRangeOfPoint(playerid, 3.0, x, y, z)) 
					return i;
			}
		}
	}
	return 0;
}

stock Veh_DeathPlayer(playerid, &killerid, &reason)
{
	if(GetPlayerVehicleIDEx(playerid) > -1) {
		new 
			vehicleid = GetPlayerVehicleIDEx(playerid),
			killerid_2 = VEH_OldDamagePlayerID[vehicleid];

		if(killerid_2 > -1 && IsPlayerOnServer(killerid_2) && Mode_IsPlayerInPlayer(playerid, killerid_2) 
			&& GetPlayerTeamEx(killerid_2) != GetPlayerTeamEx(playerid)) {

			SetPlayerVehicleIDEx(playerid, -1);
			SetPlayerVehicle(playerid, false);

			if(VEH_DriverPlayerID[vehicleid] == playerid)
				VEH_DriverPlayerID[vehicleid] = -1;

			vPlayersInVehicle[vehicleid]--;
			
			killerid = killerid_2;
			reason = VEH_OldDamageWeaponID[vehicleid];

			if(vPlayersInVehicle[vehicleid] == 0)
				Veh_ResetDamageShot(vehicleid);
		}
		else {
			vPlayersInVehicle[vehicleid]--;

			if(vPlayersInVehicle[vehicleid] == 0)
				Veh_ResetDamageShot(vehicleid);
		}
	}
	return 1;
}

stock Veh_SetDamageShot(vehicleid, playerid, weaponid)
{
	VEH_OldDamagePlayerID[vehicleid] = playerid;
	VEH_OldDamageWeaponID[vehicleid] = weaponid;
	VEH_OldDamageTimer[vehicleid] = gettime() + VEHICLE_TIMER_OLD_DAMAGE;
	return 1;
}

stock Veh_ResetDamageShot(vehicleid)
{
	VEH_OldDamagePlayerID[vehicleid] =
	VEH_OldDamageWeaponID[vehicleid] = -1;

	VEH_OldDamageTimer[vehicleid] = 0;
	return 1;
}

stock CheckIDVehicleCar(vehicleid)
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch(modelid) {
		/* Лёгкие машины */
		case 400, 401, 402, 404, 405, 409, 410, 411, 412, 415, 419, 420, 421, 422, 424, 426, 429, 432, 434, 436, 438, 439, 441, 442, 444, 445, 451, 457, 458, 466, 467, 470, 474, 475, 477, 478, 479,
		480, 485, 486, 489, 490, 491, 492, 494, 495, 496, 500, 502, 503, 504, 505, 506, 507, 516, 517, 518, 525, 526, 527, 528, 529, 530, 531, 533, 534, 535, 536, 539, 540, 541, 542, 543, 545, 546,
		547, 549, 550, 551, 552, 554, 555, 556, 557, 558, 559, 560, 561, 562, 564, 565, 566, 567, 568, 571, 572, 574, 575, 576, 579, 580, 583, 585, 587, 589, 594, 596, 597, 598, 599, 600, 601, 602, 
		603, 604, 605, 606, 607, 608: return modelid;

		/* Грузовики */ 
		case 403, 406, 407, 408, 413, 414, 416, 418, 423, 427, 428, 431, 433, 435, 437, 440, 443, 449, 450, 455, 456, 459, 482, 483, 498, 499, 508, 514, 515, 524, 532, 537, 538, 544, 569, 570, 573,
		578, 582, 584, 588, 590, 591, 609, 610: return modelid;
	}

	return 0;
}

stock CheckIDVehicleCopter(vehicleid) // Вертолёты
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch(modelid) {
		case 417, 425, 447, 465, 469, 487, 488, 497, 501, 548, 563: return modelid;
	}
	return 0;
}

stock CheckIDVehicleAir(vehicleid) // Самолёты
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch(modelid) {
		case 460, 464, 476, 511, 512, 513, 519, 520, 553, 577, 592, 593: return modelid;
	}
	return 0;
}

stock CheckIDVehicleBoat(vehicleid) // Катера
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch(modelid) {
		case 430, 446, 452, 453, 454, 472, 473, 484, 493, 595: return modelid;
	}
	return 0;
}

stock CheckIDVehicleMoto(vehicleid) // Мотоциклы
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch(modelid) {
		case 448, 461, 462, 463, 468, 471, 521, 522, 523, 581, 586: return modelid;
	}
	return 0;
}

stock CheckIDVehicleBike(vehicleid) // Велосипеды
{
	new
		modelid = GetVehicleModel(vehicleid);

	switch(modelid) {
		case 481, 509, 510: return modelid;	
	}
	return 0;
}

stock IsPlayerAirVehicle(playerid) // Самолёты и вертолёты
{
	new
		modelid = GetVehicleModel(GetPlayerVehicleID(playerid));

	switch(modelid) {
		case 417, 425, 447, 460, 464, 465, 469, 476,
		487, 488, 497, 501, 511, 512, 513, 519, 520,
		548, 553, 563, 577, 592, 593: return modelid;
	}

	return 0;
}

publics Veh_Update()
{
	n_for(v, MAX_VEHICLES)
		UpdateVehicleInfo(v);
}

static UpdateVehicleInfo(vehicleid)
{
	//Mode_VehicleReInfo(vehicleid);

	new
		engine,
		lights,
		alarm,
		bonnet,
		boot,
		objective,
		doors;

	if(VEH_OldDamageTimer[vehicleid] < gettime())
		Veh_ResetDamageShot(vehicleid);

	if(!CheckIDVehicleBike(vehicleid)) { 
		if(Veh_GetEngine(vehicleid)) {
			if(Veh_GetFuel(vehicleid) > 0) 
				Veh_TurnFuel(vehicleid, 1);
			else {
				Veh_SetEngine(vehicleid, false);
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
		Float:X,
		Float:Y,
		Float:Z;

	GetVehicleVelocity(vehicleid, X, Y,Z);
	return floatround(floatsqroot( X * X + Y * Y + Z * Z ) * 100.0);
}

static UpdatePlayerInVehicle(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return 1;

	static
		str_fuel[5 + 1],
		str_health[3 + 1],
		str_speed[5 + 1];

	str_fuel[0] =
	str_health[0] =
	str_speed[0] = EOS;

	new
		vehicleid = GetPlayerVehicleID(playerid),
		Float:HealthVehicle;

	f(str_fuel, "%i_L", Veh_GetFuel(vehicleid)); // Fuel
	PlayerTextDrawSetString(playerid, TD_vSpeedometer[playerid][8], str_fuel);

	GetVehicleHealth(vehicleid, HealthVehicle);
	f(str_health, "%.0f%", HealthVehicle/10); // Health
	PlayerTextDrawSetString(playerid, TD_vSpeedometer[playerid][7], str_health);

	f(str_speed, "%i", GetVehicleSpeed(vehicleid)); // Speed
	PlayerTextDrawSetString(playerid, TD_vSpeedometer[playerid][4], str_speed);
	return 1;
}

static GetVehicleMaxSeat(vehicleid)
{
	new
		model = GetVehicleModel(vehicleid) - 400;

	if(model >= 0) 
		return vMaxSeats[model];

	return -1;
}

static ShowPlayerSpeedometer(playerid, vehicleid = 400)
{
	if(vActivePlayerTDSpeed{playerid})
		return 1;

	if(vehicleid == -1)
		return 1;

	vActivePlayerTDSpeed{playerid} = true;

	static
		str[VEHICLE_STRING_NAME_LENGTH];

	str[0] = EOS;

	strcat(str, vCarname[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400]);

	ShowTDSpeedometer(playerid);
	PlayerTextDrawSetString(playerid, TD_vSpeedometer[playerid][3], str);

	if(!Veh_GetEngine(vehicleid))
		PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][0], 0xa31717FF);
	else
		PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][0], 0x29a317FF);

	n_for(i, sizeof(TD_vSpeedometer[]))
		PlayerTextDrawShow(playerid, TD_vSpeedometer[playerid][i]);
	
	return 1;
}

static HidePlayerSpeedometer(playerid, vehicleid)
{
	if(!vActivePlayerTDSpeed{playerid})
		return 1;

	if(vehicleid == -1)
		return 1;

	vActivePlayerTDSpeed{playerid} = false;

	if(!CheckIDVehicleBike(vehicleid)) {
		n_for(i, sizeof(TD_vSpeedometer[]))
			DestroyPlayerTD(playerid, TD_vSpeedometer[playerid][i]);
	}
	return 1;
}

/*

	* TextDraws *

*/

static ShowTDSpeedometer(playerid)
{
	TD_vSpeedometer[playerid][0] = CreatePlayerTextDraw(playerid, 517.0000, 419.0000, "_"); // Задний фон двигатель
	PlayerTextDrawFont(playerid, TD_vSpeedometer[playerid][0], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_vSpeedometer[playerid][0], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][0], 698554367);
	PlayerTextDrawSetShadow(playerid, TD_vSpeedometer[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, TD_vSpeedometer[playerid][0], false);
	PlayerTextDrawTextSize(playerid, TD_vSpeedometer[playerid][0], 101.0000, 3.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_vSpeedometer[playerid][0], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_vSpeedometer[playerid][0], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_vSpeedometer[playerid][1] = CreatePlayerTextDraw(playerid, 517.0000, 360.0000, "_"); // Основной задний фон
	PlayerTextDrawFont(playerid, TD_vSpeedometer[playerid][1], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_vSpeedometer[playerid][1], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][1], 606348543);
	PlayerTextDrawSetShadow(playerid, TD_vSpeedometer[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, TD_vSpeedometer[playerid][1], false);
	PlayerTextDrawTextSize(playerid, TD_vSpeedometer[playerid][1], 101.0000, 60.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_vSpeedometer[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_vSpeedometer[playerid][1], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_vSpeedometer[playerid][2] = CreatePlayerTextDraw(playerid, 517.0000, 373.0000, "_"); // Полоска
	PlayerTextDrawFont(playerid, TD_vSpeedometer[playerid][2], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_vSpeedometer[playerid][2], TEXT_DRAW_ALIGN_LEFT);
    PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][2], 1077952767);
	PlayerTextDrawSetShadow(playerid, TD_vSpeedometer[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, TD_vSpeedometer[playerid][2], false);
	PlayerTextDrawTextSize(playerid, TD_vSpeedometer[playerid][2], 101.0000, 2.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_vSpeedometer[playerid][2], 0);
	PlayerTextDrawSetPreviewRot(playerid, TD_vSpeedometer[playerid][2], 0.0000, 0.0000, 0.0000, 1000.0000);

	TD_vSpeedometer[playerid][3] = CreatePlayerTextDraw(playerid, 568.0000, 359.0000, "_"); // Название транспорта
	PlayerTextDrawLetterSize(playerid, TD_vSpeedometer[playerid][3], 0.2242, 1.4714);
	PlayerTextDrawTextSize(playerid, TD_vSpeedometer[playerid][3], 0.0000, 93.0000);
	PlayerTextDrawAlignment(playerid, TD_vSpeedometer[playerid][3], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_vSpeedometer[playerid][3], -589505793);
	PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][3], 255);
	PlayerTextDrawFont(playerid, TD_vSpeedometer[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_vSpeedometer[playerid][3], true);
	PlayerTextDrawSetShadow(playerid, TD_vSpeedometer[playerid][3], 0);

	TD_vSpeedometer[playerid][4] = CreatePlayerTextDraw(playerid, 568.0000, 382.0000, "_"); // Скорость
	PlayerTextDrawLetterSize(playerid, TD_vSpeedometer[playerid][4], 0.4663, 2.7904);
	PlayerTextDrawTextSize(playerid, TD_vSpeedometer[playerid][4], 0.0000, 96.0000);
	PlayerTextDrawAlignment(playerid, TD_vSpeedometer[playerid][4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_vSpeedometer[playerid][4], -239757313);
	PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][4], 255);
	PlayerTextDrawFont(playerid, TD_vSpeedometer[playerid][4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_vSpeedometer[playerid][4], true);
	PlayerTextDrawSetShadow(playerid, TD_vSpeedometer[playerid][4], 0);

	TD_vSpeedometer[playerid][5] = CreatePlayerTextDraw(playerid, 594.0000, 390.0000, "hud:radar_centre"); // Капля
	PlayerTextDrawTextSize(playerid, TD_vSpeedometer[playerid][5], 16.0000, 13.0000);
	PlayerTextDrawAlignment(playerid, TD_vSpeedometer[playerid][5], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_vSpeedometer[playerid][5], 1332724991);
	PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][5], 255);
	PlayerTextDrawFont(playerid, TD_vSpeedometer[playerid][5], TEXT_DRAW_FONT_SPRITE);
	PlayerTextDrawSetProportional(playerid, TD_vSpeedometer[playerid][5], false);
	PlayerTextDrawSetShadow(playerid, TD_vSpeedometer[playerid][5], 0);

	TD_vSpeedometer[playerid][6] = CreatePlayerTextDraw(playerid, 525.0000, 391.0000, "hud:radar_hostpital"); // Плюсик
	PlayerTextDrawTextSize(playerid, TD_vSpeedometer[playerid][6], 12.0000, 11.0000);
	PlayerTextDrawAlignment(playerid, TD_vSpeedometer[playerid][6], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_vSpeedometer[playerid][6], -1);
	PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][6], 255);
	PlayerTextDrawFont(playerid, TD_vSpeedometer[playerid][6], TEXT_DRAW_FONT_SPRITE);
	PlayerTextDrawSetProportional(playerid, TD_vSpeedometer[playerid][6], false);
	PlayerTextDrawSetShadow(playerid, TD_vSpeedometer[playerid][6], 0);

	TD_vSpeedometer[playerid][7] = CreatePlayerTextDraw(playerid, 534.0000, 403.0000, "_"); // Здоровья
	PlayerTextDrawLetterSize(playerid, TD_vSpeedometer[playerid][7], 0.2386, 1.6413);
	PlayerTextDrawTextSize(playerid, TD_vSpeedometer[playerid][7], 0.0000, 96.0000);
	PlayerTextDrawAlignment(playerid, TD_vSpeedometer[playerid][7], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_vSpeedometer[playerid][7], -636415489);
	PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][7], 255);
	PlayerTextDrawFont(playerid, TD_vSpeedometer[playerid][7], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_vSpeedometer[playerid][7], true);
	PlayerTextDrawSetShadow(playerid, TD_vSpeedometer[playerid][7], 0);

	TD_vSpeedometer[playerid][8] = CreatePlayerTextDraw(playerid, 603.0000, 403.0000, "_"); // Бензина
	PlayerTextDrawLetterSize(playerid, TD_vSpeedometer[playerid][8], 0.2386, 1.6413);
	PlayerTextDrawTextSize(playerid, TD_vSpeedometer[playerid][8], 0.0000, 96.0000);
	PlayerTextDrawAlignment(playerid, TD_vSpeedometer[playerid][8], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_vSpeedometer[playerid][8], 292477695);
	PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][8], 255);
	PlayerTextDrawFont(playerid, TD_vSpeedometer[playerid][8], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_vSpeedometer[playerid][8], true);
	PlayerTextDrawSetShadow(playerid, TD_vSpeedometer[playerid][8], 0);
	return 1;
}

/*

	* Commands *

*/

CMD:e(playerid)
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
		return 1;

	new
		engine,
		lights,
		alarm,
		bonnet,
		boot,
		objective,
		doors,
		vehicleid = GetPlayerVehicleID(playerid);

	if(CheckIDVehicleBike(vehicleid)) 
		return 1;

	if(!CheckIDVehicleBike(vehicleid) || !CheckIDVehicleAir(vehicleid)) {
		if(Veh_GetFuel(vehicleid) <= 0) {
			Veh_SetEngine(vehicleid, false);
			GetVehicleParamsEx(vehicleid, engine,lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
			return 1;
		}
		else if(Veh_GetFuel(vehicleid) > 0) {
			if(!Veh_GetEngine(vehicleid)) {
				Veh_SetEngine(vehicleid, true);
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);
			}
			else {
				Veh_SetEngine(vehicleid, false);
				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
			}
		}
	}
	return 1;
}

/*

	* Reset *

*/

static ResetVehicle(vehicleid)
{
	vPlayersInVehicle[vehicleid] = 0;

	Veh_SetMode(vehicleid, 0);
	Veh_SetSession(vehicleid, 0);
	Veh_SetID(vehicleid, INVALID_VEHICLE_ID);
	Veh_SetTeam(vehicleid, 0);
	Veh_SetFuel(vehicleid, VEHICLE_FUEL);
	Veh_SetColor(vehicleid, -1, -1);
	Veh_SetRespawnDelay(vehicleid, VEHICLE_RESPAWN_TIME);
	Veh_SetSiren(vehicleid, 0);
	Veh_SetVirtualWorld(vehicleid, 0);
	Veh_SetInterior(vehicleid, 0);
	Veh_SetSpawnCoords(vehicleid, 0.0, 0.0, 0.0, 0.0);
	Veh_SetEngine(vehicleid, false);

	Veh_SetDriverPlayer(vehicleid, INVALID_PLAYER_ID);
	Veh_ResetDamageShot(vehicleid);
	return 1;
}

static ResetPlayerData(playerid)
{
	vActivePlayerVehicleID[playerid] = -1;

	vActivePlayerVehicle{playerid} =
	vActivePlayerTDSpeed{playerid} = false;
	return 1;
}

static ResetPlayerTDs(playerid)
{
	n_for(t, sizeof(TD_vSpeedometer[]))
		TD_vSpeedometer[playerid][t] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

public OnGameModeInit()
{
	n_for(v, MAX_VEHICLES)
		ResetVehicle(v);

	SetTimer("Veh_Update", 10000, true);

	#if defined Veh_OnGameModeInit
		return Veh_OnGameModeInit();
	#else
		return 1;
	#endif
}

/*
	OnPlayerKeyStateChange
*/

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_FIRE) {
		// Транспорт
		if(GetPlayerState(playerid) == 2) {
			new
				vehicleid = GetPlayerVehicleID(playerid);

			if(!CheckIDVehicleBike(GetVehicleModel(vehicleid))) {
				new
					engine, lights, alarm, bonnet, boot, objective, doors;

				if(Veh_GetFuel(vehicleid) <= 0) {
					Veh_SetEngine(vehicleid, false);
					GetVehicleParamsEx(vehicleid, engine,lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
					return 1;
				}
				else if(Veh_GetFuel(vehicleid) > 0) {
					if(!Veh_GetEngine(vehicleid)) {
						Veh_SetEngine(vehicleid, true);
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, VEHICLE_PARAMS_ON, alarm, doors, bonnet, boot, objective);
					}
					else {
						Veh_SetEngine(vehicleid, false);
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, VEHICLE_PARAMS_OFF, alarm, doors, bonnet, boot, objective);
					}
				}
				
				// Спидометр
				if(!Veh_GetEngine(vehicleid)) { // Двигатель
					PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][0], 0xa31717FF);
					PlayerTextDrawShow(playerid, TD_vSpeedometer[playerid][0]);
				}
				else {
					PlayerTextDrawBackgroundColour(playerid, TD_vSpeedometer[playerid][0], 0x29a317FF);
					PlayerTextDrawShow(playerid, TD_vSpeedometer[playerid][0]);
				}
			}
		}
	}

	if(newkeys & KEY_CROUCH) { // В транспорте H
		// Катапультирование
		if(IsPlayerInAnyVehicle(playerid)
		&& CheckIDVehicleAir(GetPlayerVehicleID(playerid))) {
			new
				Float:pX,
				Float:pY,
				Float:pZ;

			GetPlayerPos(playerid, pX, pY, pZ);
			SetPlayerPosEx(playerid, pX, pY, pZ + 15.0, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
			GivePlayerWeapon(playerid, 46, 1);

			// Чтобы у игрока ещё раз не сработала клавиша H
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
	OnPlayerStateChange
*/

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	switch(newstate) {
		case PLAYER_STATE_DRIVER: {
			new
				vehicleid = GetPlayerVehicleID(playerid),
				model = GetVehicleModel(vehicleid);

			if(Adm_GetVehicle(vehicleid)) {
				if(Adm_GetPlayerLevel(playerid) < 1) {
					RemovePlayerFromVehicle(playerid);
					TogglePlayerControllable(playerid, true);

					SCM(playerid, COLOR_ERROR, "(Ошибка)  {FFFFFF}Данный транспорт доступен только для администрации.");
				}
			}
			switch(model) {
				case 432: 
				{
					if(GetPlayerRank(playerid) < 30) {
						RemovePlayerFromVehicle(playerid);
						TogglePlayerControllable(playerid, true);
						SCM(playerid, COLOR_ERROR, "(Ошибка)  {FFFFFF}Необходим ранг {FFFF33}30");
					}
				}
			}
			if(!CheckIDVehicleBike(model)) {
				if(Veh_GetFuel(vehicleid) < 1) {
					new
						engine,
						lights,
						alarm,
						bonnet,
						boot,
						objective,
						doors;

					GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_OFF, lights, alarm, doors, bonnet, boot, objective);
					Veh_SetEngine(vehicleid, false);
				}
				ShowPlayerSpeedometer(playerid, vehicleid);

				SCM(playerid, -1, "{e8891c}(Подсказка) {FFFFFF}Нажмите {f0cb16}ALT {FFFFFF}({FFFF33}/e{FFFFFF}) чтобы завести или заглушить двигатель.");
				Dina_CheckPlayerHint(playerid, 9);
			}
			else {
				new
					engine,
					lights,
					alarm,
					bonnet,
					boot,
					objective,
					doors;

				GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(vehicleid, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
			}
			Veh_SetDriverPlayer(vehicleid, playerid);
			SetPlayerVehicle(playerid, true);
			SetPlayerVehicleIDEx(playerid, vehicleid);
			Veh_GivePlayers(vehicleid, 1);
		}
		case PLAYER_STATE_PASSENGER: {
			new 
				vehicleid = GetPlayerVehicleID(playerid);

			SetPlayerVehicle(playerid, true);
			SetPlayerVehicleIDEx(playerid, vehicleid);
			Veh_GivePlayers(vehicleid, 1);

			if(GetPlayerWeapon(playerid) == 24) 
				SetPlayerArmedWeapon(playerid, 0);
		}
	}
	switch(oldstate) {
		case PLAYER_STATE_DRIVER: {
			new 
				vehicleid = GetPlayerVehicleIDEx(playerid);
				
			SetPlayerVehicle(playerid, false);
			
			if(vehicleid > -1) {
				if(!CheckIDVehicleBike(GetVehicleModel(vehicleid)))
					HidePlayerSpeedometer(playerid, vehicleid);

				new
					Float:player_health;

				GetPlayerHealth(playerid, player_health);
				if(player_health > 0.0) {
					Veh_GivePlayers(vehicleid, -1);
					SetPlayerVehicleIDEx(playerid, -1);
					if(Veh_GetPlayers(vehicleid) == 0) {
						if(Veh_GetDamageShotTimer(vehicleid) > 0) {
							Veh_SetDriverPlayer(vehicleid, -1);
							Veh_ResetDamageShot(vehicleid);
						}
					}
				}
			}
		}
		case PLAYER_STATE_PASSENGER: {
			new 
				vehicleid = GetPlayerVehicleIDEx(playerid);

			SetPlayerVehicle(playerid, false);

			if(vehicleid > -1) {
				new 
					Float:player_health;

				GetPlayerHealth(playerid, player_health);
				if(player_health > 0.0) {
					Veh_GivePlayers(vehicleid, -1);
					SetPlayerVehicleIDEx(playerid, -1);
					if(Veh_GetPlayers(vehicleid) == 0) {
						if(Veh_GetDamageShotTimer(vehicleid) > 0) {
							Veh_SetDriverPlayer(vehicleid, -1);
							Veh_ResetDamageShot(vehicleid);
						}
					}
				}
			}
		}
	}

	#if defined Veh_OnPlayerStateChange
		return Veh_OnPlayerStateChange(playerid, newstate, oldstate);
	#else
		return 1;
	#endif
}

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);
	ResetPlayerTDs(playerid);

	#if defined Veh_OnPlayerConnect
		return Veh_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerUpdate
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
	OnVehicleSpawn
*/

public OnVehicleSpawn(vehicleid)
{
	Veh_SetEngine(vehicleid, false);
	Veh_SetFuel(vehicleid, VEHICLE_FUEL);

	Veh_SetDriverPlayer(vehicleid, -1);
	Veh_ResetDamageShot(vehicleid);

	#if defined Veh_OnVehicleSpawn
		return Veh_OnVehicleSpawn(vehicleid);
	#else
		return 1;
	#endif
}

/*
	OnVehicleDeath
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
	OnVehicleDamageStatusUpdate
*/

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	if(VEH_DriverPlayerID[vehicleid] > -1) {
		if(!GetPlayerDamage(VEH_DriverPlayerID[vehicleid])) {
			new 
				Float:veh_health;

			GetVehicleHealth(vehicleid, veh_health);
			SetVehicleHealth(vehicleid, veh_health);
		}
	}

	#if defined Veh_OnVehicleDamageStatusUp
		return Veh_OnVehicleDamageStatusUp(vehicleid, playerid);
	#else
		return 1;
	#endif
}

/*
	ALS
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
	forward Veh_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif


#if defined _ALS_OnPlayerStateChange
	#undef OnPlayerStateChange
#else
	#define _ALS_OnPlayerStateChange
#endif
#define OnPlayerStateChange Veh_OnPlayerStateChange
#if defined Veh_OnPlayerStateChange
	forward Veh_OnPlayerStateChange(playerid, newstate, oldstate);
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