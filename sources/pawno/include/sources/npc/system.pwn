/*

	About: NPC system
	Author: Neuty, Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		NPC_Go_MainMenu()
		NPC_PlanesFly()
	Stock:
		NPC_MainMenuSpawn()
		NPC_OnReachDestination(npcid)
Enums:
	E_NPC_INFO
	E_NPC_GUARD_INFO
	E_NPC_HELI_INFO
	E_NPC_BOAT_INFO
Commands:
	-
Dialogs:
	-
Interfaces:
	-
--------------------------------------------------------------------------------*/

#if defined _INC_NPC_SYSTEM
	#endinput
#endif
#define _INC_NPC_SYSTEM

/*

	* Enums *

*/

enum E_NPC_INFO {
	npc_Name[MAX_PLAYER_NAME],
	npc_Skin,
	Float:npc_X,
	Float:npc_Y,
	Float:npc_Z,
	Float:npc_A,
	weaponnpcid,
	npc_interior,
	npc_virtualworld,
	npc_ID,
	npc_State
}

enum E_NPC_GUARD_INFO {
	Float:g_x,
	Float:g_y,
	Float:g_z,
	g_ID
}

enum E_NPC_HELI_INFO {
	Float:h_x,
	Float:h_y,
	Float:h_z,
	h_ID
}

enum E_NPC_BOAT_INFO {
	Float:b_x,
	Float:b_y,
	Float:b_z,
	b_ID
}

/*

	* Vars *

*/

static const
	npc_mainmenuInfo[][E_NPC_INFO] = {

	{"NPC_Guard", 287,3463.5134, 2297.5210, 18.3727, 90.6087, 31, 1},
	{"NPC_Helicopter", 287,3489.6255, 2457.5085, 40.5556, 90.0000, 0, 1},
	{"NPC_Boat", 179, 3471.1765, 2304.6655, 0.1723, 90.0000, 0, 1},
	{"NPC_Pilot1", 287, 3322.0518, 2304.6826, 48.3756, 0.0, 0, 1},
	{"NPC_Pilot2", 287, 3322.0518, 2317.8386, 48.3756, 0.0, 0, 1}
};

static const
	npc_guardInfo[][E_NPC_GUARD_INFO] = {

	{3463.5134, 2297.5210, 18.3727},
	{3516.0024, 2299.1670, 18.3677},
	{3516.2170, 2291.6541, 18.3727},
	{3463.7021, 2291.7966, 18.3727}
};

static const
	npc_heliInfo[][E_NPC_HELI_INFO] = {

	{3120.7808, 2321.6296, 40.5556}, // Спавн
	{3760.4468, 2321.6296, 40.5556}, // 1ая точка
	{3741.5291, 2335.1201, 40.5556}, // Смена позиции и средства
	{3120.7808, 2335.1201, 40.5556}, // 2ая точка
	{3449.9224, 2480.0686, 40.5556}, // Смена позиции
	{3449.9224, 2106.3931, 40.5556}, // 3ая точка
	{3848.4536, 2269.2026, 40.5556}, // Смена позиции и средства
	{3120.7808, 2269.2026, 40.5556} // 4ая точка
};

static const
	npc_boatInfo[][E_NPC_BOAT_INFO] = {

	{3471.1765, 2304.6655, 0.1723},
	{3396.1111, 2304.6655, 0.1723},
	{3395.5466, 2320.9922, 0.1723},
	{3679.8899, 2320.9922, 0.1723},
	{3681.1074, 2266.7756, 0.1723},
	{3409.7815, 2266.7756, 0.1723},
	{3409.8015, 2304.6655, 0.1723}
};

static
	npc_helicopter,
	npc_boat,
	npc_plane[2],
	planes_checker;

/*

	* Functions *

*/

stock NPC_MainMenuSpawn()
{
	n_for(npcid, sizeof(npc_mainmenuInfo))
	{
		npc_mainmenuInfo[npcid][npc_interior] = Mode_GetBasicInterior(MODE_NONE, 0);
		npc_mainmenuInfo[npcid][npc_virtualworld] = Mode_GetBasicVirtualWorld(MODE_NONE, 0);

		npc_mainmenuInfo[npcid][npc_ID] = FCNPC_Create(npc_mainmenuInfo[npcid][npc_Name]);
		FCNPC_Spawn(npc_mainmenuInfo[npcid][npc_ID], npc_mainmenuInfo[npcid][npc_Skin], npc_mainmenuInfo[npcid][npc_X], npc_mainmenuInfo[npcid][npc_Y], npc_mainmenuInfo[npcid][npc_Z]);
		FCNPC_Stop(npc_mainmenuInfo[npcid][npc_ID]);
		FCNPC_StopAttack(npc_mainmenuInfo[npcid][npc_ID]);
		FCNPC_SetWeapon(npc_mainmenuInfo[npcid][npc_ID],npc_mainmenuInfo[npcid][weaponnpcid]);
		FCNPC_SetAmmo(npc_mainmenuInfo[npcid][npc_ID], 50);
		FCNPC_SetQuaternion(npc_mainmenuInfo[npcid][npc_ID], 0.0, 0.0, 0.0, 0.0);
		FCNPC_SetAngle(npc_mainmenuInfo[npcid][npc_ID], npc_mainmenuInfo[npcid][npc_A]);
		FCNPC_SetInterior(npc_mainmenuInfo[npcid][npc_ID], npc_mainmenuInfo[npcid][npc_interior]);
		FCNPC_SetVirtualWorld(npc_mainmenuInfo[npcid][npc_ID], npc_mainmenuInfo[npcid][npc_virtualworld]);
		SetPlayerColor(npc_mainmenuInfo[npcid][npc_ID], 0xCCCCCC00);
	}
	SetPVarInt(npc_mainmenuInfo[0][npc_ID], "npc_guard", 1);

	new
		engine,
		lights,
		alarm,
		bonnet,
		boot,
		objective,
		doors;
	
	npc_helicopter = CreateVehicle(417,npc_heliInfo[0][h_x],npc_heliInfo[0][h_y],npc_heliInfo[0][h_z],-90.0000,-1,-1,-1);
	FCNPC_PutInVehicle(npc_mainmenuInfo[1][npc_ID],npc_helicopter,0), SetPVarInt(npc_mainmenuInfo[1][npc_ID],"npc_heli",1);
	GetVehicleParamsEx(npc_helicopter, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(npc_helicopter, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);

	npc_boat = CreateVehicle(473,npc_boatInfo[0][b_x],npc_boatInfo[0][b_y],npc_boatInfo[0][b_z],90.0000,-1,-1,-1);
	FCNPC_PutInVehicle(npc_mainmenuInfo[2][npc_ID],npc_boat,0), SetPVarInt(npc_mainmenuInfo[2][npc_ID],"npc_boat",1);
	GetVehicleParamsEx(npc_boat, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(npc_boat, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
	
	npc_plane[0] = CreateVehicle(476,3322.0518,2312.2488,48.3756,90.0000,107,-1,-1);
	FCNPC_PutInVehicle(npc_mainmenuInfo[3][npc_ID],npc_plane[0],0), SetPVarInt(npc_mainmenuInfo[3][npc_ID],"npc_pilot1",1);
	GetVehicleParamsEx(npc_plane[0], engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(npc_plane[0], VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
	FCNPC_SetVehicleGearState(npc_mainmenuInfo[3][npc_ID], 1);

	npc_plane[1] = CreateVehicle(476,3322.0518,2327.8965,48.3756,90.0000,107,-1,-1);
	FCNPC_PutInVehicle(npc_mainmenuInfo[4][npc_ID],npc_plane[1],0), SetPVarInt(npc_mainmenuInfo[4][npc_ID],"npc_pilot2",1);
	GetVehicleParamsEx(npc_plane[1], engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(npc_plane[1], VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
	FCNPC_SetVehicleGearState(npc_mainmenuInfo[4][npc_ID], 1);

	SetTimer("NPC_Go_MainMenu", 1000, false);
}

publics NPC_Go_MainMenu()
{
	FCNPC_GoTo(npc_mainmenuInfo[0][npc_ID],npc_guardInfo[0][g_x],npc_guardInfo[0][g_y],npc_guardInfo[0][g_z],FCNPC_MOVE_TYPE_WALK,FCNPC_MOVE_SPEED_WALK,0,0,0.0,true,0.0,0);
	FCNPC_GoTo(npc_mainmenuInfo[1][npc_ID],npc_heliInfo[0][h_x],npc_heliInfo[0][h_y],npc_heliInfo[0][h_z],3,2.1,0,0,0.0,true,0.0,0);
	FCNPC_GoTo(npc_mainmenuInfo[2][npc_ID],npc_boatInfo[0][b_x],npc_boatInfo[0][b_y],npc_boatInfo[0][b_z],3,1.5,0,0,0.0,true,0.0,0);
	FCNPC_GoTo(npc_mainmenuInfo[3][npc_ID],3322.0518,2312.2488,48.3756,3,2.5,0,0,0.0,true,0.0,0);
	FCNPC_GoTo(npc_mainmenuInfo[4][npc_ID],3322.0518,2327.8965,48.3756,3,2.5,0,0,0.0,true,0.0,0);
}

publics NPC_PlanesFly()
{
	planes_checker = 0;
	FCNPC_SetPosition(npc_mainmenuInfo[3][npc_ID],3322.0518,2312.2488,48.3756), SetPVarInt(npc_mainmenuInfo[3][npc_ID],"npc_point",0);
	FCNPC_SetPosition(npc_mainmenuInfo[4][npc_ID],3322.0518,2327.8965,48.3756), SetPVarInt(npc_mainmenuInfo[4][npc_ID],"npc_point",0);
	SetVehicleVirtualWorld(npc_plane[0],0), SetPlayerVirtualWorld(npc_mainmenuInfo[3][npc_ID],0);
	SetVehicleVirtualWorld(npc_plane[1],0), SetPlayerVirtualWorld(npc_mainmenuInfo[4][npc_ID],0);
	FCNPC_GoTo(npc_mainmenuInfo[3][npc_ID],3322.0518,2312.2488,48.3756,3,2.1,0,0,0.0,true,0.0,0);
	FCNPC_GoTo(npc_mainmenuInfo[4][npc_ID],3322.0518,2327.8965,48.3756,3,2.1,0,0,0.0,true,0.0,0);
}

/*

	* Callbacks *

*/

/*
	FCNPC_OnReachDestination
*/

stock NPC_OnReachDestination(npcid)
{
	new
		point = GetPVarInt(npcid,"npc_point");

	if(GetPVarInt(npcid,"npc_guard") == 1)
	{
		if(point < sizeof(npc_guardInfo) -1) 
			point = point + 1, SetPVarInt(npcid,"npc_point",point);
		else 
			point = 0, SetPVarInt(npcid,"npc_point",0);
		
		FCNPC_GoTo(npcid,npc_guardInfo[point][g_x],npc_guardInfo[point][g_y],npc_guardInfo[point][g_z],FCNPC_MOVE_TYPE_WALK,FCNPC_MOVE_SPEED_WALK,0,0,0.0,true,0.0,0);
	}
	if(GetPVarInt(npcid,"npc_heli") == 1)
	{
		new
			engine,
			lights,
			alarm,
			bonnet,
			boot,
			objective,
			doors;

		switch(point) {
			case 0: {
				point = 1, SetPVarInt(npcid,"npc_point",point);
				FCNPC_GoTo(npcid,npc_heliInfo[point][h_x],npc_heliInfo[point][h_y],npc_heliInfo[point][h_z],3,2.1, false, 0, 0.0, true, 0.0, 0);
				FCNPC_SetQuaternion(npcid,0.701057,0.092295,-0.092295,0.701057); // Вперёд
			}
			case 1: {
				DestroyVehicleEx(npc_helicopter);
				npc_helicopter = CreateVehicle(548,npc_heliInfo[2][h_x],npc_heliInfo[2][h_y],npc_heliInfo[2][h_z],90.0000,-1,-1,-1);
				FCNPC_PutInVehicle(npc_mainmenuInfo[1][npc_ID],npc_helicopter,0);
				point = 3, SetPVarInt(npcid,"npc_point",point);
				FCNPC_GoTo(npcid,npc_heliInfo[point][h_x],npc_heliInfo[point][h_y],npc_heliInfo[point][h_z],3,2.1, false, 0, 0.0, true, 0.0, 0);
				FCNPC_SetQuaternion(npcid,-0.701057,-0.092295,-0.092295,0.701057); // Назад

				GetVehicleParamsEx(npc_helicopter, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(npc_helicopter, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
			}
			case 3: {
				FCNPC_SetPosition(npcid,npc_heliInfo[4][h_x],npc_heliInfo[4][h_y],npc_heliInfo[4][h_z]);
				point = 5, SetPVarInt(npcid,"npc_point",point);
				FCNPC_GoTo(npcid,npc_heliInfo[point][h_x],npc_heliInfo[point][h_y],npc_heliInfo[point][h_z],3,2.1, false, 0, 0.0, true, 0.0, 0);
				FCNPC_SetQuaternion(npcid,-0.000000,0.000000,-0.130526,0.991444); // Слева на право
				// FCNPC_SetQuaternion(npcid,0.991444,0.130526,0.000000,0.000000); // Справо на лево
			}
			case 5: {
				DestroyVehicleEx(npc_helicopter);
				npc_helicopter = CreateVehicle(417,npc_heliInfo[6][h_x],npc_heliInfo[6][h_y],npc_heliInfo[6][h_z],90.0000,-1,-1,-1);
				FCNPC_PutInVehicle(npc_mainmenuInfo[1][npc_ID],npc_helicopter,0);
				point = 7, SetPVarInt(npcid,"npc_point",point);
				FCNPC_GoTo(npcid,npc_heliInfo[point][h_x],npc_heliInfo[point][h_y],npc_heliInfo[point][h_z],3,2.1, false, 0, 0.0, true, 0.0, 0);
				FCNPC_SetQuaternion(npcid,-0.701057,-0.092295,-0.092295,0.701057); // Назад

				GetVehicleParamsEx(npc_helicopter, engine, lights, alarm, doors, bonnet, boot, objective);
				SetVehicleParamsEx(npc_helicopter, VEHICLE_PARAMS_ON, lights, alarm, doors, bonnet, boot, objective);
			}
			case 7: {
				FCNPC_SetPosition(npcid,npc_heliInfo[0][h_x],npc_heliInfo[0][h_y],npc_heliInfo[0][h_z]);
				point = 1, SetPVarInt(npcid,"npc_point",point);
				FCNPC_GoTo(npcid,npc_heliInfo[point][h_x],npc_heliInfo[point][h_y],npc_heliInfo[point][h_z],3,2.1, false, 0, 0.0, true, 0.0, 0);
				FCNPC_SetQuaternion(npcid,0.701057,0.092295,-0.092295,0.701057); // Вперёд
			}
		}
	}
	if(GetPVarInt(npcid,"npc_boat") == 1)
	{
		if(point < sizeof(npc_boatInfo) -1) {
			point = point + 1;
			SetPVarInt(npcid,"npc_point",point);
		}
		else { 
			point = 0;
			SetPVarInt(npcid,"npc_point",0);
		}
		
		FCNPC_GoTo(npcid,npc_boatInfo[point][b_x],npc_boatInfo[point][b_y],npc_boatInfo[point][b_z],3,1.5,0,0,0.0,true,0.0,0);
	}
	if(GetPVarInt(npcid,"npc_pilot1") == 1)
	{
		if(point == 0)
		{
			point = 1;
			SetPVarInt(npcid,"npc_point",point);
			FCNPC_GoTo(npcid,3873.0212,2312.2488,48.3756,3,2.1,0,0,0.0,true,0.0,0);
		}
		else if(point == 1)
		{
			planes_checker++;
			SetVehicleVirtualWorld(npc_plane[0],1);
			SetPlayerVirtualWorld(npcid,1);

			if(planes_checker == 2)
				SetTimer("NPC_PlanesFly",40000,0);
		}
	}
	if(GetPVarInt(npcid,"npc_pilot2") == 1)
	{
		if(point == 0)
		{
			point = 1;
			SetPVarInt(npcid,"npc_point",point);
			FCNPC_GoTo(npcid,3873.0212,2327.8965,48.3756,3,2.1,0,0,0.0,true,0.0,0);
		}
		else if(point == 1)
		{
			planes_checker++;
			SetVehicleVirtualWorld(npc_plane[1],1), SetPlayerVirtualWorld(npcid,1);

			if(planes_checker == 2)
				SetTimer("NPC_PlanesFly",40000,0);
		}
	}
	return 1;
}