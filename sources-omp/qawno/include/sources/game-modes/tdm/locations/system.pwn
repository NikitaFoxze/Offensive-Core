/*

	About: TDM location system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnGameModeInit()
		OnPlayerConnect(playerid)
		OnPlayerSpawn(playerid)
		OnPlayerDeath(playerid, killerid, reason)
		OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
		OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
		OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
	Stock:
		TDM_CreateAEObject(session_id, cell, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
		TDM_DestroyAEObject(session_id, cell = -1)
		TDM_GetAEObjectPos(session_id, cell, &Float:x, &Float:y, &Float:z)
		TDM_SetAEObjectMaterial(session_id, cell, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0)
		TDM_SetAEObjectMaterialText(session_id, cell, materialindex, const text[], materialsize = OBJECT_MATERIAL_SIZE_256x128, const fontface[] = "Arial", fontsize = 24, bold = 1, fontcolor = 0xFFFFFFFF, backcolor = 0, textalignment = 0)
		TDM_MoveAEObject(session_id, cell, Float:x, Float:y, Float:z, Float:speed, Float:rx = -1000.0, Float:ry = -1000.0, Float:rz = -1000.0)
		TDM_StopAEObject(session_id, cell)
		
		TDM_CreateAE3DText(session_id, cell, const name[], color, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid, vehicleid, lost)
		TDM_DestroyAE3DText(session_id, cell = -1)
		TDM_UpdateAE3DText(session_id, cell, color, const text[])
		
		TDM_CreateAEPickupDoor(session_id, cell, const name[], id, style, typeclick, Float:enterpos_x, Float:enterpos_y, Float:enterpos_z, enter_virtualworld, enter_interior, Float:exitpos_x, Float:exitpos_y, Float:exitpos_z, Float:exitpos_a, exit_virtualworld, exit_interior)
		TDM_DestroyAEPickupDoor(session_id, cell = -1)
		TDM_SetPlayerPosAEDoor(playerid, pickup_id)

		TDM_CreateAEOtherPickup(session_id, cell, const name[], id, style, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, virtualworld, interior)
		TDM_DestroyAEOtherPickup(session_id, cell = -1)
		TDM_UpdateAE3DTextOP(session_id, cell, color, const text[])

		TDM_CreateAEMapIcon(session_id, cell, Float:x, Float:y, Float:z, type, color, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_MAP_ICON_SD, style = MAPICON_LOCAL, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
		TDM_DestroyAEMapIcon(session_id, cell = -1)

		TDM_CreateAEActor(session_id, cell, modelid, Float:x, Float:y, Float:z, Float:r, invulnerable = true, Float:health = 100.0, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_ACTOR_SD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
		TDM_DestroyAEActor(session_id, cell = -1)

		TDM_SetAEElements(session_id, objects, texts3d, pickupsdoor, otherpickups, mapicons, actors)

		TDM_AddTeam(session_id, team_id, bool:chet)
		TDM_RemoveTeam(session_id, team_id)
		TDM_CheckTeam(session_id, team_id)
		TDM_CheckTeamChet(session_id, team_id)
		TDM_GetActiveTeams(session_id)

		TDM_CreateBaseTeam(session_id, team_id, Float:minx, Float:miny, Float:maxx, Float:maxy)
		TDM_DestroyBaseTeam(session_id, team_id)
		TDM_ResetBaseTeam(session_id, team_id)
		TDM_SetCameraBaseTeam(session_id, team_id, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
		TDM_SetSpawnBaseTeam(session_id, team_id, cell, Float:x, Float:y, Float:z)
		TDM_GetBaseSpawn(session_id, base_id, random_pos, &Float:X, &Float:Y, &Float:Z)
		TDM_SetPlayerBaseCamera(playerid, team_id)
		
		TDM_CreateCapturePoint(session_id, cell, const name[], Float:x, Float:y, Float:z, Float:minx, Float:miny, Float:maxx, Float:maxy)
		TDM_DestroyCapturePoint(session_id, cell)
		TDM_ResetCapturePoint(session_id, point_id)
		TDM_GetGangZonePlayer(playerid, &point_id)
		TDM_SetCameraCapturePoint(session_id, cell, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
		TDM_SetSpawnCapturePoint(session_id, cell, cell2, Float:x, Float:y, Float:z)
		TDM_SetPlayerPointCamera(playerid, point_id)
		TDM_LocGetCapturePointSpawn(session_id, point_id, random_pos, &Float:X, &Float:Y, &Float:Z)
		TDM_SetCPTeamChet(session_id, team_id, num)
		TDM_GetCPTeamChet(session_id, team_id)
		TDM_SetCPTeamMaxChet(session_id, team_id, num)
		TDM_GetCPTeamMaxChet(session_id, team_id)
		TDM_GiveCPPointTeam(session_id, team_id)
		TDM_GetPointTeam(session_id, point_id)
		TDM_GetPointRed(session_id, point_id)
		TDM_GetPointName(session_id, point_id)
		TDM_PointReInfo(session_id)

		TDM_CreateComputer(session_id, team_id, cell, Float:x, Float:y, Float:z)
		TDM_DestroyComputer(session_id, team_id)
		TDM_ResetComputer(session_id, team_id, comp_id)
		TDM_SetCompTeamChet(session_id, team_id, num)
		TDM_GetCompTeamChet(session_id, team_id)
		TDM_SetCompTeamMaxChet(session_id, team_id, num)
		TDM_GetCompTeamMaxChet(session_id, team_id)
		TDM_ComputerReInfo(session_id)
		TDM_UpdatePlayerComputer(playerid)

		TDM_CreateCaptureFlag(session_id, team_id, Float:x, Float:y, Float:z)
		TDM_DestroyCaptureFlag(session_id, team_id)
		TDM_ResetCaptureFlag(session_id, team_id)
		TDM_SetFlagTeamChet(session_id, team_id, num)
		TDM_GetFlagTeamChet(session_id, team_id)
		TDM_SetFlagTeamMaxChet(session_id, team_id, num)
		TDM_GetFlagTeamMaxChet(session_id, team_id)

		TDM_SetBattleTeamChet(session_id, team_id, num)
		TDM_GetBattleTeamChet(session_id, team_id)
		TDM_SetBattleTeamMaxChet(session_id, team_id, num)
		TDM_GetBattleTeamMaxChet(session_id, team_id)

		TDM_CreateBagMoney(session_id, team_id, Float:x, Float:y, Float:z, virtualworld = -1, interior = -1)
		TDM_DestroyBagMoney(session_id, team_id)
		TDM_ResetBagMoney(session_id, team_id)
		TDM_GetBagMoney(session_id)
		TDM_SetPlayerBagMoney(playerid, bool:type)
		TDM_GetPlayerBagMoney(playerid)

		TDM_CreateShop(session_id, team_id, Float:x, Float:y, Float:z, virtualworld = -1, interior = -1)
		TDM_DestroyShop(session_id, team_id)
		TDM_ResetShop(session_id, team_id)
		TDM_GetShops(session_id)

		TDM_CreateFastPoint(session_id, Float:x, Float:y, Float:z)
		TDM_DestroyFastPoint(session_id, all = 0)
		TDM_ResetFastPoint(session_id, all)
		TDM_CreatePosFastPoint(session_id, cell, Float:x, Float:y, Float:z)
		TDM_GetFastPoint(session_id)
		TDM_StartFastPoint(session_id)
		TDM_FastPointReInfo(session_id)
		TDM_UpdateAirFastPoint(session_id)
		TDM_CheckStartFastPoint(session_id)

		TDM_CreateVehicle(session_id, team_id, cell, vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1 = -1, color2 = -1, respawn_delay = VEHICLE_RESPAWN_TIME, addsiren = 0)
		TDM_DestroyVehicle(session_id, cell)
		TDM_GetVehicleID(session_id, cell)
		TDM_SetVehicle(session_id, bool:type)
		TDM_GetVehicle(session_id)

		TDM_SetTeamChet(session_id, team_id, chet, maxchet)
		TDM_ResetTeamsChet(session_id)
		TDM_GetTeamsChet(session_id)

		TDM_SetTimer(session_id, minutes, seconds)
		TDM_GetActiveTimer(session_id)
		TDM_GetPresetMinutesTimer(session_id)
		TDM_GetPresetSecondsTimer(session_id)

		TDM_SetExitZonePos(session_id, Float:minx, Float:miny, Float:maxx, Float:maxy)
		TDM_DestroyExitZone(session_id)
		TDM_GetExitZone(session_id)

		TDM_SetSpawnTopActor(session_id, cell, Float:X, Float:Y, Float:Z, Float:Angle)
		TDM_GetSpawnTopActor(session_id, cell, &Float:X, &Float:Y, &Float:Z, &Float:Angle)
		
		SetAirBomb(session_id, id, Float:x, Float:y, Float:z, virtualworld, interior)
		SetAirWeapon(session_id, id, Float:x, Float:y, Float:z, virtualworld, interior)
		Create3DTextAirWeapon(session_id, id, Float:x, Float:y, Float:z)
		TDM_SetWeaponAirNextPriority(session_id, num)
		TDM_GetWeaponAirBextPriority(session_id)
		TDM_SetBombAirNextPriority(session_id, num)
		TDM_GetBombAirBextPriority(session_id)
		TDM_SetBombAirs(session_id)
		TDM_SetWeaponAirs(session_id)
		TDM_IsValidAirWeapon(session_id, air_id)
		TDM_IsValidAirBomb(session_id, air_id)
		TDM_SetAirDropWeapon(session_id, bool:type)
		TDM_GetAirDropWeapon(session_id)
		TDM_SetAirBomb(session_id, bool:type)
		TDM_GetAirBomb(session_id)
		TDM_UpdateAir(session_id)

		TDM_SetPlayerIDAirdrop(playerid, air_id)
		TDM_GetPlayerIDAirdrop(playerid)

		TDM_ShowCameraEndLocation(playerid, type)
		TDM_ShowCameraEndLocationTwo(playerid, type)
		TDM_ShowCameraEndLocationThree(playerid, type)
		TDM_SetCameraEndPos(session_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
		TDM_SetCameraEndLookAt(session_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
		TDM_SetCameraEndPosTwo(session_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
		TDM_ResetCameraEndPos(session_id)

		TDM_CreateElementsLocation(session_id)
		TDM_DestroyElementsLocation(session_id)
		TDM_ShowPlayerElementsLocation(playerid)
		TDM_HidePlayerElementsLocation(playerid)
		TDM_CreateAEElementsLoc(session_id)
		TDM_DestroyAEElementsLoc(session_id)
		TDM_CreateElementEnterArea(playerid)

		TDM_SetPlayerKeyPickupDoor(playerid, location_id, pickup_id)
		TDM_SetPlayerKeyOtherPickup(playerid, location_id, pickup_id)
		TDM_SetPlayerKey3DText(playerid, location_id, text_id)
		TDM_UpdateAEElement(location_id, session_id)
		TDM_UpdatePlAEElements(playerid)
		TDM_VehicleSetSettings(vehicleid)
		TDM_SetPlKeyAE3DText(playerid, location_id, p_3dtext, text_id)
		TDM_LocSetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
		TDM_LocResetPlayerMG(playerid)
		TDM_LocUpdatePlayerMG(playerid)
Enums:
	E_TDM_AIR_DROP_WEAPON_INFO
	E_TDM_AIR_BOMB_INFO
	E_TDM_AIR_FAST_POINT_INFO
	E_TDM_SHOP_PRICE_INFO
	E_TDM_CAPTURE_POINT_INFO
	E_TDM_COMPUTER_INFO
	E_TDM_CAPTURE_FLAG_INFO
	E_TDM_BAG_MONEY_INFO
	E_TDM_SHOP_INFO
	E_TDM_FAST_POINT_INFO
	E_TDM_BASE_TEAM_INFO
	E_TDM_AE_3D_TEXT_INFO
	E_TDM_AE_PICKUP_DOOR_INFO
	E_TDM_AE_OTHER_PICKUP_INFO
Commands:
	-
Dialogs:
	TDM_Shop
	AirdropWeapon
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_LOC_SYSTEM
	#endinput
#endif
#define _INC_TDM_LOC_SYSTEM

/*

	* Locations *

*/

#include <sources/game-modes/tdm/locations/desert/desert.pwn>
#include <sources/game-modes/tdm/locations/desert2/desert2.pwn>
#include <sources/game-modes/tdm/locations/airport/airport.pwn>
#include <sources/game-modes/tdm/locations/airport2/airport2.pwn>
#include <sources/game-modes/tdm/locations/stadium/stadium.pwn>
#include <sources/game-modes/tdm/locations/village/village.pwn>
#include <sources/game-modes/tdm/locations/golf/golf.pwn>
#include <sources/game-modes/tdm/locations/zone51/zone51.pwn>
#include <sources/game-modes/tdm/locations/example/example.pwn>

/*

	* Enums *

*/

enum E_TDM_AIR_DROP_WEAPON_INFO {
	Air_ObjectAir,
	Air_ObjectBox,
	//Air_ObjectWeapon[TDM_AIR_MAX_OBJECT_WEAPON],
	Air_ObjectParachute,
	Text3D:Air_3DText,
	Air_Status,
	bool:Air_Action,
	Air_Timer,
	Air_VirtualWorld,
	Air_Interior,
	Air_Weapon[TDM_AIR_MAX_WEAPON],
	Air_WeaponAmmo[TDM_AIR_C_MAX_WEAPON],
	Float:Air_PosX,
	Float:Air_PosY,
	Float:Air_PosZ
}

enum E_TDM_AIR_BOMB_INFO {
	Air_ObjectAir,
	Air_ObjectBomb,
	Air_Status,
	Air_Timer,
	Air_VirtualWorld,
	Air_Interior,
	Float:Air_PosX,
	Float:Air_PosY,
	Float:Air_PosZ
}

enum E_TDM_AIR_FAST_POINT_INFO {
	Air_ObjectAir,
	Air_ObjectBox,
	Air_ObjectParachute,
	Air_Status,
	Air_Timer,
	Air_VirtualWorld,
	Air_Interior,
	Float:Air_PosX,
	Float:Air_PosY,
	Float:Air_PosZ
}

enum E_TDM_CAPTURE_POINT_INFO {
	CP_Name[50],
	Float:CP_PosX,
	Float:CP_PosY,
	Float:CP_PosZ,
	Float:CP_Minx,
	Float:CP_Miny,
	Float:CP_Maxx,
	Float:CP_Maxy,
	CP_GangZone,
	CP_Object[5],
	Text3D:CP_3DText,
	CP_Sphere,
	CP_Color,
	CP_Chet,
	CP_Property,
	bool:CP_Red,
	CP_CaptureTeam,
	CP_MapIcon,
	CP_VirtualWorld,
	CP_Interior
}

enum E_TDM_COMPUTER_INFO {
	bool:COMP_Enabled,
	bool:COMP_ActionCapture,
	bool:COMP_Red,
	COMP_Status,
	COMP_Chet,
	COMP_Timer,
	COMP_ObjectSmoke,
	Text3D:COMP_3DText,
	Text3D:COMP_3DTextClick,
	COMP_MapIcon,
	COMP_VirtualWorld,
	COMP_Interior,
	COMP_ProtectTeam,
	COMP_PlayerID
}

enum E_TDM_CAPTURE_FLAG_INFO {
	FLAG_Object[2],
	FLAG_ObjectFlag,
	FLAG_ObjectSmoke,
	Text3D:FLAG_3DTextClick,
	Text3D:FLAG_3DTextCapture,
	FLAG_Status,
	FLAG_PlayerID,
	FLAG_MapIcon,
	FLAG_VirtualWorld,
	FLAG_Interior
}

enum E_TDM_BAG_MONEY_INFO {
	BG_Team,
	BG_Pickup,
	BG_MapIcon,
	Text3D:BG_3DText,
	BG_VirtualWorld,
	BG_Interior	
}

enum E_TDM_SHOP_PRICE_INFO {
	sp_ItemID,
	sp_Count,
	sp_Price
}

enum E_TDM_SHOP_INFO {
	WP_Team,
	WP_Pickup,
	WP_MapIcon,
	WP_ObjectSmoke,
	Text3D:WP_3DText,
	WP_VirtualWorld,
	WP_Interior
}

enum E_TDM_FAST_POINT_INFO {
	FP_Status,
	FP_Timer,
	Float:FP_PosX,
	Float:FP_PosY,
	Float:FP_PosZ,
	FP_Object[8],
	Text3D:FP_3DText,
	FP_Sphere,
	FP_Color,
	FP_Chet,
	FP_Property,
	bool:FP_Red,
	FP_CaptureTeam,
	FP_MapIcon,
	FP_VirtualWorld,
	FP_Interior
}

enum E_TDM_BASE_TEAM_INFO {
	BT_GangZone,
	BT_Color,
	BT_VirtualWorld,
	BT_Interior
}

/*
	Additional Elements (AE)
*/

enum E_TDM_AE_3D_TEXT_INFO {
	dt_Name[150],
	Text3D:dt_3DText,
	dt_Color,
	dt_TypeClick, // 0 - No / 1 - ALT
	Float:dt_PosX,
	Float:dt_PosY,
	Float:dt_PosZ,
	Float:dt_Radius,
	dt_PlayerID,
	dt_VehicleID,
	dt_LOST,
	bool:dt_Created
}

enum E_TDM_AE_PICKUP_DOOR_INFO {
	tp_Name[150],
	tp_Pickup,
	Text3D:tp_3DText,
	tp_TypeClick, // 0 - No / 1 - ALT
	Float:tp_EnterPos_X,
	Float:tp_EnterPos_Y,
	Float:tp_EnterPos_Z,
	tp_EnterVirtualWorld,
	tp_EnterInterior,
	Float:tp_ExitPos_X,
	Float:tp_ExitPos_Y,
	Float:tp_ExitPos_Z,
	Float:tp_ExitPos_A,
	tp_ExitVirtualWorld,
	tp_ExitInterior,
	bool:tp_Created
}

enum E_TDM_AE_OTHER_PICKUP_INFO {
	op_Name[150],
	Text3D:op_3DText,
	op_Pickup,
	op_TypeClick, // 0 - No / 1 - ALT
	Float:op_PosX,
	Float:op_PosY,
	Float:op_PosZ,
	op_VirtualWorld,
	op_Interior,
	bool:op_Created
}

/*

	* Vars *

*/

static
	bool:ActiveExitZone[TDM_MAX_GAME_SESSIONS],
	AreaExitZone[TDM_MAX_GAME_SESSIONS];

static
	bool:ActiveTimer[TDM_MAX_GAME_SESSIONS],
	PresetMinutesTimer[TDM_MAX_GAME_SESSIONS],
	PresetSecondsTimer[TDM_MAX_GAME_SESSIONS];

static
	bool:ActiveTeamChet[TDM_MAX_GAME_SESSIONS];

static
	Float:ActorsTopKillsPos[TDM_MAX_GAME_SESSIONS][5][4],
	Float:CameraEndLocationPos[TDM_MAX_GAME_SESSIONS][4][3],
	Float:CameraEndLocationPosTwo[TDM_MAX_GAME_SESSIONS][2][3];

static
	v_Vehicle[TDM_MAX_GAME_SESSIONS][TDM_MAX_VEHICLES],
	bool:ActiveVehicles[TDM_MAX_GAME_SESSIONS];

static
	bool:ActiveAirDropWeapon[TDM_MAX_GAME_SESSIONS],
	bool:ActiveAirBomb[TDM_MAX_GAME_SESSIONS];

static
	TDM_PlayerIDAirWeapon[MAX_PLAYERS];

static
	AirBomb[TDM_MAX_GAME_SESSIONS][MAX_AIR_BOMB][E_TDM_AIR_BOMB_INFO],
	AirBombNextPriority[TDM_MAX_GAME_SESSIONS],
	AllAirsBomb[TDM_MAX_GAME_SESSIONS],
	AllAirBomb[TDM_MAX_GAME_SESSIONS][MAX_AIR_BOMB];

static
	AirWeapon[TDM_MAX_GAME_SESSIONS][MAX_AIR_WEAPON][E_TDM_AIR_DROP_WEAPON_INFO],
	AirWeaponNextPriority[TDM_MAX_GAME_SESSIONS],
	AllAirsWeapon[TDM_MAX_GAME_SESSIONS],
	AllAirWeapon[TDM_MAX_GAME_SESSIONS][MAX_AIR_WEAPON];

static
	AirFastPoint[TDM_MAX_GAME_SESSIONS][E_TDM_AIR_FAST_POINT_INFO],
	FastPoint[TDM_MAX_GAME_SESSIONS][E_TDM_FAST_POINT_INFO],
	ActiveFastPoint[TDM_MAX_GAME_SESSIONS],
	FastPointPlayerCapture[MAX_PLAYERS];

static
	PriceShopTeam[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][TDM_SHOP_MAX_ITEMS][E_TDM_SHOP_PRICE_INFO],
	RebateShopTeam[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS];

static
	AE_Object[TDM_MAX_GAME_SESSIONS][AE_OBJECT_COUNT],
	AE_TotalNumberObjects[TDM_MAX_GAME_SESSIONS];

static
	AE_3DTextInfo[TDM_MAX_GAME_SESSIONS][AE_3D_TEXT_COUNT][E_TDM_AE_3D_TEXT_INFO],
	AE_TotalNumber3DTexts[TDM_MAX_GAME_SESSIONS];

static
	AE_PickupDoorInfo[TDM_MAX_GAME_SESSIONS][AE_PICKUP_DOOR_COUNT][E_TDM_AE_PICKUP_DOOR_INFO],
	AE_TotalNumberPickupsDoor[TDM_MAX_GAME_SESSIONS];

static
	AE_OtherPickupInfo[TDM_MAX_GAME_SESSIONS][AE_PICKUP_COUNT][E_TDM_AE_OTHER_PICKUP_INFO],
	AE_TotalNumberOtherPickups[TDM_MAX_GAME_SESSIONS];

static
	AE_MapIcon[TDM_MAX_GAME_SESSIONS][AE_MAPICON_COUNT],
	AE_TotalNumberMapIcons[TDM_MAX_GAME_SESSIONS];

static
	AE_Actor[TDM_MAX_GAME_SESSIONS][AE_ACTOR_COUNT],
	AE_TotalNumberActors[TDM_MAX_GAME_SESSIONS];

static
	Float:CameraBasePos[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][2][3],
	Float:SpawnBasePos[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][3][3],
	Float:CameraPointPos[TDM_MAX_GAME_SESSIONS][TDM_MAX_CAPTURE_POINTS][2][3],
	Float:SpawnPointPos[TDM_MAX_GAME_SESSIONS][TDM_MAX_CAPTURE_POINTS][3][3],
	Float:PosComputers[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][TDM_MAX_COMPUTERS][3],
	Float:PosCaptureFlag[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][3],
	Float:PosBagMoney[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][3],
	Float:PosShop[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][3],
	Float:PosFastPoint[TDM_MAX_GAME_SESSIONS][5][3];

static
	TDM_BaseTeam[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][E_TDM_BASE_TEAM_INFO];

static
	TDM_CapturePoint[TDM_MAX_GAME_SESSIONS][TDM_MAX_CAPTURE_POINTS][E_TDM_CAPTURE_POINT_INFO],
	CP_TeamChet[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS],
	CP_TeamMaxChet[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS],
	GangZonePlayerCapture[MAX_PLAYERS];

static
	TDM_Computer[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][TDM_MAX_COMPUTERS][E_TDM_COMPUTER_INFO],
	COMP_TeamChet[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS],
	COMP_TeamMaxChet[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS],
	ComputerPlayerCapture[MAX_PLAYERS],
	ComputerPlayerTeam[MAX_PLAYERS];

static
	TDM_CaptureFlag[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][E_TDM_CAPTURE_FLAG_INFO],
	FLAG_TeamChet[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS],
	FLAG_TeamMaxChet[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS],
	ActionPlayerCaptureFlag[MAX_PLAYERS];

static
	BATTLE_TeamChet[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS],
	BATTLE_TeamMaxChet[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS];

static
	TDM_BagMoney[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][E_TDM_BAG_MONEY_INFO],
	bool:PlayerMoneyBag[MAX_PLAYERS char];

static
	TDM_Shop[TDM_MAX_GAME_SESSIONS][TDM_MAX_TEAMS][E_TDM_SHOP_INFO];

static const
	PriceShop[TDM_SHOP_MAX_ITEMS][E_TDM_SHOP_PRICE_INFO] = {
		{31, 50, 500},		// М4
		{30, 50, 300},		// AK-47
		{24, 30, 400},		// Дигл
		{22, 30, 100},		// Кольт
		{29, 50, 150},		// МП5
		{26, 18, 600},		// Обрез
		{28, 40, 450},		// Узи
		{33, 10, 500},		// Винтовка
		{35, 5, 1000},		// РПГ
		{16, 5, 100},		// Граната
		{100, 100, 600},	// Здоровье
		{101, 100, 700}		// Броня
	};

/*

	* Functions *

*/

/*
	Additional Elements (AE)
*/

/*
	Object
*/

stock TDM_CreateAEObject(session_id, cell, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
{
	if(IsValidDynamicObject(AE_Object[session_id][cell]))
		return 0;

	if(worldid == -1)
		worldid = Mode_GetVirtualWorld(MODE_TDM, session_id);
	if(interiorid == -1)
		interiorid = Mode_GetInterior(MODE_TDM, session_id);

	AE_Object[session_id][cell] = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
	return 1;
}

stock TDM_DestroyAEObject(session_id, cell = -1)
{
	if(cell == -1) {
		n_for(i, AE_TotalNumberObjects[session_id]) {
			if(IsValidDynamicObject(AE_Object[session_id][i]))
				DestroyDynamicObject(AE_Object[session_id][i]);

			TDM_ResetAEObject(session_id, i);
		}
		AE_TotalNumberObjects[session_id] = 0;
	}
	else {
		if(IsValidDynamicObject(AE_Object[session_id][cell]))
			DestroyDynamicObject(AE_Object[session_id][cell]);
		
		TDM_ResetAEObject(session_id, cell);
	}
	return 1;
}

static TDM_ResetAEObject(session_id, cell)
{
	if(cell == -1) {
		n_for(i, AE_OBJECT_COUNT)
			AE_Object[session_id][i] = INVALID_DYNAMIC_OBJECT_ID;
	}
	else
		AE_Object[session_id][cell] = INVALID_DYNAMIC_OBJECT_ID;

	return 1;
}

stock TDM_GetAEObjectPos(session_id, cell, &Float:x, &Float:y, &Float:z)
{
	if(IsValidDynamicObject(AE_Object[session_id][cell]))
		GetDynamicObjectPos(AE_Object[session_id][cell], x, y, z);

	return 1;
}

stock TDM_SetAEObjectMaterial(session_id, cell, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0)
{
	if(IsValidDynamicObject(AE_Object[session_id][cell]))
		SetDynamicObjectMaterial(AE_Object[session_id][cell], materialindex, modelid, txdname, texturename, materialcolor);

	return 1;
}

stock TDM_SetAEObjectMaterialText(session_id, cell, materialindex, const text[], materialsize = OBJECT_MATERIAL_SIZE_256x128, const fontface[] = "Arial", fontsize = 24, bold = 1, fontcolor = 0xFFFFFFFF, backcolor = 0, textalignment = 0)
{
	if(IsValidDynamicObject(AE_Object[session_id][cell]))
		SetDynamicObjectMaterialText(AE_Object[session_id][cell], materialindex, text, materialsize, fontface, fontsize, bold, fontcolor, backcolor, textalignment);

	return 1;
}

stock TDM_MoveAEObject(session_id, cell, Float:x, Float:y, Float:z, Float:speed, Float:rx = -1000.0, Float:ry = -1000.0, Float:rz = -1000.0)
{
	if(IsValidDynamicObject(AE_Object[session_id][cell]))
		MoveDynamicObject(AE_Object[session_id][cell], x, y, z, speed, rx, ry, rz);

	return 1;
}

stock TDM_StopAEObject(session_id, cell)
{
	if(IsValidDynamicObject(AE_Object[session_id][cell]))
		StopDynamicObject(AE_Object[session_id][cell]);

	return 1;
}

/*
	3D Text
*/

stock TDM_CreateAE3DText(session_id, cell, const name[], color, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid, vehicleid, lost, virtualworld = -1, interiorid = -1)
{
	if(AE_3DTextInfo[session_id][cell][dt_Created])
		return 0;

	if(virtualworld == -1)
		virtualworld = Mode_GetVirtualWorld(MODE_TDM, session_id);
	if(interiorid == -1)
		interiorid = Mode_GetInterior(MODE_TDM, session_id);

	strins(AE_3DTextInfo[session_id][cell][dt_Name], name, 0);
	AE_3DTextInfo[session_id][cell][dt_Color] = color;
	AE_3DTextInfo[session_id][cell][dt_TypeClick] = typeclick;
	AE_3DTextInfo[session_id][cell][dt_PosX] = pos_x;
	AE_3DTextInfo[session_id][cell][dt_PosY] = pos_y;
	AE_3DTextInfo[session_id][cell][dt_PosZ] = pos_z;
	AE_3DTextInfo[session_id][cell][dt_Radius] = radius;
	AE_3DTextInfo[session_id][cell][dt_PlayerID] = playerid;
	AE_3DTextInfo[session_id][cell][dt_VehicleID] = vehicleid;
	AE_3DTextInfo[session_id][cell][dt_LOST] = lost;
	AE_3DTextInfo[session_id][cell][dt_Created] = true;
	AE_3DTextInfo[session_id][cell][dt_3DText] = CreateDynamic3DTextLabel(name, color, pos_x, pos_y, pos_z, radius, playerid, vehicleid, lost, virtualworld, interiorid);
	return 1;
}

stock TDM_DestroyAE3DText(session_id, cell = -1)
{
	if(cell == -1) {
		n_for(i, AE_TotalNumber3DTexts[session_id]) {
			if(AE_3DTextInfo[session_id][i][dt_Created]) {
				DestroyDynamic3DTextLabel(AE_3DTextInfo[session_id][i][dt_3DText]);
				TDM_ResetAE3DText(session_id, i);
			}
		}
		AE_TotalNumber3DTexts[session_id] = 0;
	}
	else {
		if(AE_3DTextInfo[session_id][cell][dt_Created]) {
			DestroyDynamic3DTextLabel(AE_3DTextInfo[session_id][cell][dt_3DText]);
			TDM_ResetAE3DText(session_id, cell);
		}
	}
	return 1;
}

static TDM_ResetAE3DText(session_id, cell)
{
	if(cell == -1) {
		n_for(i, AE_3D_TEXT_COUNT) {
			AE_3DTextInfo[session_id][i][dt_Name][0] = EOS;
			AE_3DTextInfo[session_id][i][dt_Color] =
			AE_3DTextInfo[session_id][i][dt_TypeClick] = 0;
			AE_3DTextInfo[session_id][i][dt_PosX] =
			AE_3DTextInfo[session_id][i][dt_PosY] =
			AE_3DTextInfo[session_id][i][dt_PosZ] =
			AE_3DTextInfo[session_id][i][dt_Radius] = 0.0;
			AE_3DTextInfo[session_id][i][dt_PlayerID] =
			AE_3DTextInfo[session_id][i][dt_VehicleID] = -1;
			AE_3DTextInfo[session_id][i][dt_LOST] = 0;
			AE_3DTextInfo[session_id][i][dt_Created] = false;

			AE_3DTextInfo[session_id][i][dt_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		}
	}
	else {
		AE_3DTextInfo[session_id][cell][dt_Name][0] = EOS;
		AE_3DTextInfo[session_id][cell][dt_Color] =
		AE_3DTextInfo[session_id][cell][dt_TypeClick] = 0;
		AE_3DTextInfo[session_id][cell][dt_PosX] =
		AE_3DTextInfo[session_id][cell][dt_PosY] =
		AE_3DTextInfo[session_id][cell][dt_PosZ] =
		AE_3DTextInfo[session_id][cell][dt_Radius] = 0.0;
		AE_3DTextInfo[session_id][cell][dt_PlayerID] =
		AE_3DTextInfo[session_id][cell][dt_VehicleID] = -1;
		AE_3DTextInfo[session_id][cell][dt_LOST] = 0;
		AE_3DTextInfo[session_id][cell][dt_Created] = false;

		AE_3DTextInfo[session_id][cell][dt_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
	}
	return 1;
}

stock TDM_UpdateAE3DText(session_id, cell, color, const text[])
{
	if(AE_3DTextInfo[session_id][cell][dt_Created]) {
		AE_3DTextInfo[session_id][cell][dt_Name][0] = EOS;

		strins(AE_3DTextInfo[session_id][cell][dt_Name], text, 0);
		UpdateDynamic3DTextLabelText(AE_3DTextInfo[session_id][cell][dt_3DText], color, text);
	}
	return 1;
}

/*
	Pickup door
*/

stock TDM_CreateAEPickupDoor(session_id, cell, const name[], id, style, typeclick, Float:enterpos_x, Float:enterpos_y, Float:enterpos_z, enter_virtualworld, enter_interior, Float:exitpos_x, Float:exitpos_y, Float:exitpos_z, Float:exitpos_a, exit_virtualworld, exit_interior)
{
	if(AE_PickupDoorInfo[session_id][cell][tp_Created])
		return 0;

	if(enter_virtualworld == -1)
		enter_virtualworld = Mode_GetVirtualWorld(MODE_TDM, session_id);
	if(enter_interior == -1)
		enter_interior = Mode_GetInterior(MODE_TDM, session_id);

	if(exit_virtualworld == -1)
		exit_virtualworld = Mode_GetVirtualWorld(MODE_TDM, session_id);
	if(exit_interior == -1)
		exit_interior = Mode_GetInterior(MODE_TDM, session_id);

	strins(AE_PickupDoorInfo[session_id][cell][tp_Name], name, 0);
	AE_PickupDoorInfo[session_id][cell][tp_TypeClick] = typeclick;
	AE_PickupDoorInfo[session_id][cell][tp_EnterPos_X] = enterpos_x;
	AE_PickupDoorInfo[session_id][cell][tp_EnterPos_Y] = enterpos_y;
	AE_PickupDoorInfo[session_id][cell][tp_EnterPos_Z] = enterpos_z;
	AE_PickupDoorInfo[session_id][cell][tp_EnterVirtualWorld] = enter_virtualworld;
	AE_PickupDoorInfo[session_id][cell][tp_EnterInterior] = enter_interior;
	AE_PickupDoorInfo[session_id][cell][tp_ExitPos_X] = exitpos_x;
	AE_PickupDoorInfo[session_id][cell][tp_ExitPos_Y] = exitpos_y;
	AE_PickupDoorInfo[session_id][cell][tp_ExitPos_Z] = exitpos_z;
	AE_PickupDoorInfo[session_id][cell][tp_ExitPos_A] = exitpos_a;
	AE_PickupDoorInfo[session_id][cell][tp_ExitVirtualWorld] = exit_virtualworld;
	AE_PickupDoorInfo[session_id][cell][tp_ExitInterior] = exit_interior;
	AE_PickupDoorInfo[session_id][cell][tp_Created] = true;
	AE_PickupDoorInfo[session_id][cell][tp_Pickup] = CreateDynamicPickup(id, style, enterpos_x, enterpos_y, enterpos_z, enter_virtualworld, enter_interior);
	AE_PickupDoorInfo[session_id][cell][tp_3DText] = CreateDynamic3DTextLabel(name, 0xFFFFFFFF, enterpos_x, enterpos_y, enterpos_z, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, enter_virtualworld, enter_interior);
	return 1;
}

stock TDM_DestroyAEPickupDoor(session_id, cell = -1)
{
	if(cell == -1) {
		n_for(i, AE_TotalNumberPickupsDoor[session_id]) {
			if(AE_PickupDoorInfo[session_id][i][tp_Created]) {
				DestroyDynamicPickup(AE_PickupDoorInfo[session_id][i][tp_Pickup]);
				DestroyDynamic3DTextLabel(AE_PickupDoorInfo[session_id][i][tp_3DText]);
	
				TDM_ResetAEPickupDoor(session_id, i);
			}
		}
		AE_TotalNumberPickupsDoor[session_id] = 0;
	}
	else {
		if(AE_PickupDoorInfo[session_id][cell][tp_Created]) {
			DestroyDynamicPickup(AE_PickupDoorInfo[session_id][cell][tp_Pickup]);
			DestroyDynamic3DTextLabel(AE_PickupDoorInfo[session_id][cell][tp_3DText]);

			TDM_ResetAEPickupDoor(session_id, cell);
		}
	}
	return 1;
}

static TDM_ResetAEPickupDoor(session_id, cell)
{
	if(cell == -1) {
		n_for(i, AE_PICKUP_DOOR_COUNT) {
			AE_PickupDoorInfo[session_id][i][tp_Name][0] = EOS;
			AE_PickupDoorInfo[session_id][i][tp_TypeClick] = 0;
			AE_PickupDoorInfo[session_id][i][tp_EnterPos_X] =
			AE_PickupDoorInfo[session_id][i][tp_EnterPos_Y] =
			AE_PickupDoorInfo[session_id][i][tp_EnterPos_Z] = 0.0;
			AE_PickupDoorInfo[session_id][i][tp_EnterVirtualWorld] =
			AE_PickupDoorInfo[session_id][i][tp_EnterInterior] = 0;
			AE_PickupDoorInfo[session_id][i][tp_ExitPos_X] =
			AE_PickupDoorInfo[session_id][i][tp_ExitPos_Y] =
			AE_PickupDoorInfo[session_id][i][tp_ExitPos_Z] =
			AE_PickupDoorInfo[session_id][i][tp_ExitPos_A] = 0.0;
			AE_PickupDoorInfo[session_id][i][tp_ExitVirtualWorld] =
			AE_PickupDoorInfo[session_id][i][tp_ExitInterior] = 0;
			AE_PickupDoorInfo[session_id][i][tp_Created] = false;
			AE_PickupDoorInfo[session_id][i][tp_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
			AE_PickupDoorInfo[session_id][i][tp_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		}
	}
	else {
		AE_PickupDoorInfo[session_id][cell][tp_Name][0] = EOS;
		AE_PickupDoorInfo[session_id][cell][tp_TypeClick] = 0;
		AE_PickupDoorInfo[session_id][cell][tp_EnterPos_X] =
		AE_PickupDoorInfo[session_id][cell][tp_EnterPos_Y] =
		AE_PickupDoorInfo[session_id][cell][tp_EnterPos_Z] = 0.0;
		AE_PickupDoorInfo[session_id][cell][tp_EnterVirtualWorld] =
		AE_PickupDoorInfo[session_id][cell][tp_EnterInterior] = 0;
		AE_PickupDoorInfo[session_id][cell][tp_ExitPos_X] =
		AE_PickupDoorInfo[session_id][cell][tp_ExitPos_Y] =
		AE_PickupDoorInfo[session_id][cell][tp_ExitPos_Z] =
		AE_PickupDoorInfo[session_id][cell][tp_ExitPos_A] = 0.0;
		AE_PickupDoorInfo[session_id][cell][tp_ExitVirtualWorld] =
		AE_PickupDoorInfo[session_id][cell][tp_ExitInterior] = 0;
		AE_PickupDoorInfo[session_id][cell][tp_Created] = false;
		AE_PickupDoorInfo[session_id][cell][tp_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
		AE_PickupDoorInfo[session_id][cell][tp_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
	}
	return 1;
}

stock TDM_SetPlayerPosAEDoor(playerid, pickup_id)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	SetPlayerPosEx(playerid, AE_PickupDoorInfo[session_id][pickup_id][tp_ExitPos_X], AE_PickupDoorInfo[session_id][pickup_id][tp_ExitPos_Y], AE_PickupDoorInfo[session_id][pickup_id][tp_ExitPos_Z], AE_PickupDoorInfo[session_id][pickup_id][tp_ExitVirtualWorld], AE_PickupDoorInfo[session_id][pickup_id][tp_ExitInterior], false);
	SetPlayerFacingAngle(playerid, AE_PickupDoorInfo[session_id][pickup_id][tp_ExitPos_A]);
	return 1;
}

/*
	Pickup other
*/

stock TDM_CreateAEOtherPickup(session_id, cell, const name[], id, style, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, virtualworld, interiorid)
{
	if(AE_OtherPickupInfo[session_id][cell][op_Created])
		return 0;

	if(virtualworld == -1)
		virtualworld = Mode_GetVirtualWorld(MODE_TDM, session_id);
	if(interiorid == -1)
		interiorid = Mode_GetInterior(MODE_TDM, session_id);

	strins(AE_OtherPickupInfo[session_id][cell][op_Name], name, 0);
	AE_OtherPickupInfo[session_id][cell][op_TypeClick] = typeclick;
	AE_OtherPickupInfo[session_id][cell][op_PosX] = pos_x;
	AE_OtherPickupInfo[session_id][cell][op_PosY] = pos_y;
	AE_OtherPickupInfo[session_id][cell][op_PosZ] = pos_z;
	AE_OtherPickupInfo[session_id][cell][op_VirtualWorld] = virtualworld;
	AE_OtherPickupInfo[session_id][cell][op_Interior] = interiorid;
	AE_OtherPickupInfo[session_id][cell][op_Created] = true;
	AE_OtherPickupInfo[session_id][cell][op_Pickup] = CreateDynamicPickup(id, style, pos_x, pos_y, pos_z, virtualworld, interiorid);
	AE_OtherPickupInfo[session_id][cell][op_3DText] = CreateDynamic3DTextLabel(name, 0xFFFFFFFF, pos_x, pos_y, pos_z, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, virtualworld, interiorid);
	return 1;
}

stock TDM_DestroyAEOtherPickup(session_id, cell = -1)
{
	if(cell == -1) {
		n_for(i, AE_TotalNumberOtherPickups[session_id]) {
			if(AE_OtherPickupInfo[session_id][i][op_Created]) {
				DestroyDynamicPickup(AE_OtherPickupInfo[session_id][i][op_Pickup]);
				DestroyDynamic3DTextLabel(AE_OtherPickupInfo[session_id][i][op_3DText]);

				TDM_ResetAEPickupOther(session_id, i);
			}
		}
		AE_TotalNumberOtherPickups[session_id] = 0;
	}
	else {
		if(AE_OtherPickupInfo[session_id][cell][op_Created]) {
			DestroyDynamicPickup(AE_OtherPickupInfo[session_id][cell][op_Pickup]);
			DestroyDynamic3DTextLabel(AE_OtherPickupInfo[session_id][cell][op_3DText]);

			TDM_ResetAEPickupOther(session_id, cell);
		}
	}
	return 1;
}

static TDM_ResetAEPickupOther(session_id, cell)
{
	if(cell == -1) {
		n_for(i, AE_PICKUP_COUNT) {
			AE_OtherPickupInfo[session_id][i][op_Name][0] = EOS;
			AE_OtherPickupInfo[session_id][i][op_TypeClick] = 0;
			AE_OtherPickupInfo[session_id][i][op_PosX] =
			AE_OtherPickupInfo[session_id][i][op_PosY] =
			AE_OtherPickupInfo[session_id][i][op_PosZ] = 0.0;
			AE_OtherPickupInfo[session_id][i][op_VirtualWorld] =
			AE_OtherPickupInfo[session_id][i][op_Interior] = 0;
			AE_OtherPickupInfo[session_id][i][op_Created] = false;
			AE_OtherPickupInfo[session_id][i][op_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
			AE_OtherPickupInfo[session_id][i][op_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		}
	}
	else {
		AE_OtherPickupInfo[session_id][cell][op_Name][0] = EOS;
		AE_OtherPickupInfo[session_id][cell][op_TypeClick] = 0;
		AE_OtherPickupInfo[session_id][cell][op_PosX] =
		AE_OtherPickupInfo[session_id][cell][op_PosY] =
		AE_OtherPickupInfo[session_id][cell][op_PosZ] = 0.0;
		AE_OtherPickupInfo[session_id][cell][op_VirtualWorld] =
		AE_OtherPickupInfo[session_id][cell][op_Interior] = 0;
		AE_OtherPickupInfo[session_id][cell][op_Created] = false;
		AE_OtherPickupInfo[session_id][cell][op_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
		AE_OtherPickupInfo[session_id][cell][op_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
	}
	return 1;
}

stock TDM_UpdateAE3DTextOP(session_id, cell, color, const text[])
{
	if(!AE_OtherPickupInfo[session_id][cell][op_Created])
		return 0;

	AE_OtherPickupInfo[session_id][cell][op_Name][0] = EOS;

	strins(AE_OtherPickupInfo[session_id][cell][op_Name], text, 0);

	UpdateDynamic3DTextLabelText(AE_OtherPickupInfo[session_id][cell][op_3DText], color, text);
	return 1;
}

/*
	Map icon
*/

stock TDM_CreateAEMapIcon(session_id, cell, Float:x, Float:y, Float:z, type, color, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_MAP_ICON_SD, style = MAPICON_LOCAL, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
{
	if(IsValidDynamicMapIcon(AE_MapIcon[session_id][cell]))
		return 0;

	if(worldid == -1) 
		worldid = Mode_GetVirtualWorld(MODE_TDM, session_id);
	if(interiorid == -1) 
		interiorid = Mode_GetInterior(MODE_TDM, session_id);

	AE_MapIcon[session_id][cell] = CreateDynamicMapIcon(x, y, z, type, color, worldid, interiorid, playerid, streamdistance, style, areaid, priority);
	return 1;
}

stock TDM_DestroyAEMapIcon(session_id, cell = -1)
{
	if(cell == -1) {
		n_for(i, AE_TotalNumberMapIcons[session_id]) {
			if(IsValidDynamicMapIcon(AE_MapIcon[session_id][i])) 
				DestroyDynamicMapIcon(AE_MapIcon[session_id][i]);

			TDM_ResetAEMapIcon(session_id, i);
		}
		AE_TotalNumberMapIcons[session_id] = 0;
	}
	else {
		if(IsValidDynamicMapIcon(AE_MapIcon[session_id][cell]))
			DestroyDynamicMapIcon(AE_MapIcon[session_id][cell]);

		TDM_ResetAEMapIcon(session_id, cell);
	}
	return 1;
}

static TDM_ResetAEMapIcon(session_id, cell)
{
	if(cell == -1) {
		n_for(i, AE_MAPICON_COUNT)
			AE_MapIcon[session_id][i] = INVALID_DYNAMIC_MAP_ICON_ID;
	}
	else
		AE_MapIcon[session_id][cell] = INVALID_DYNAMIC_MAP_ICON_ID;

	return 1;
}

/*
	Actor
*/

stock TDM_CreateAEActor(session_id, cell, modelid, Float:x, Float:y, Float:z, Float:r, invulnerable = true, Float:health = 100.0, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_ACTOR_SD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
{
	if(IsValidDynamicActor(AE_Actor[session_id][cell]))
		return 0;

	if(worldid == -1) 
		worldid = Mode_GetVirtualWorld(MODE_TDM, session_id);
	if(interiorid == -1) 
		interiorid = Mode_GetInterior(MODE_TDM, session_id);

	AE_Actor[session_id][cell] = CreateDynamicActor(modelid, x, y, z, r, invulnerable, health, worldid, interiorid, playerid, streamdistance, areaid, priority);
	return 1;
}

stock TDM_DestroyAEActor(session_id, cell = -1)
{
	if(cell == -1) {
		n_for(i, AE_TotalNumberActors[session_id]) {
			if(IsValidDynamicActor(AE_Actor[session_id][i]))
				DestroyDynamicActor(AE_Actor[session_id][i]);

			TDM_ResetAEActor(session_id, i);
		}
		AE_TotalNumberActors[session_id] = 0;
	}
	else {
		if(IsValidDynamicActor(AE_Actor[session_id][cell]))
			DestroyDynamicActor(AE_Actor[session_id][cell]);

		TDM_ResetAEActor(session_id, cell);
	}
	return 1;
}

static TDM_ResetAEActor(session_id, cell)
{
	if(cell == -1) {
		n_for(i, AE_ACTOR_COUNT)
			AE_Actor[session_id][i] = INVALID_DYNAMIC_ACTOR_ID;
	}
	else
		AE_Actor[session_id][cell] = INVALID_DYNAMIC_ACTOR_ID;

	return 1;
}

/*
	Setting elements
*/

stock TDM_SetAEElements(session_id, objects, texts3d, pickupsdoor, otherpickups, mapicons, actors)
{
	AE_TotalNumberObjects[session_id] = objects;
	AE_TotalNumber3DTexts[session_id] = texts3d;
	AE_TotalNumberPickupsDoor[session_id] = pickupsdoor;
	AE_TotalNumberOtherPickups[session_id] = otherpickups;
	AE_TotalNumberMapIcons[session_id] = mapicons;
	AE_TotalNumberActors[session_id] = actors;
	return 1;
}

/*
	Team
*/

stock TDM_AddTeam(session_id, team_id, bool:chet)
{
	Iter_Add(TDM_ActiveTeams[session_id], team_id);

	if(chet)
		Iter_Add(TDM_ActiveTeamsChet[session_id], team_id);

	return 1;
}

stock TDM_RemoveTeam(session_id, team_id)
{
	if(team_id != -1) {
		Iter_Remove(TDM_ActiveTeams[session_id], team_id);

		if(Iter_Contains(TDM_ActiveTeamsChet[session_id], team_id))
			Iter_Remove(TDM_ActiveTeamsChet[session_id], team_id);
	}
	else {
		Iter_Clear(TDM_ActiveTeams[session_id]);

		if(Iter_Count(TDM_ActiveTeamsChet[session_id]))
			Iter_Clear(TDM_ActiveTeamsChet[session_id]);
	}
	return 1;
}

stock TDM_CheckTeam(session_id, team_id)
{
	return Iter_Contains(TDM_ActiveTeams[session_id], team_id);
}

stock TDM_CheckTeamChet(session_id, team_id)
{
	return Iter_Contains(TDM_ActiveTeamsChet[session_id], team_id);
}

stock TDM_GetActiveTeams(session_id)
{
	return Iter_Count(TDM_ActiveTeamsChet[session_id]);
}

/*
	Base team
*/

stock TDM_CreateBaseTeam(session_id, team_id, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	TDM_BaseTeam[session_id][team_id][BT_VirtualWorld] = Mode_GetVirtualWorld(MODE_TDM, session_id);
	TDM_BaseTeam[session_id][team_id][BT_Interior] = Mode_GetInterior(MODE_TDM, session_id);

	TDM_BaseTeam[session_id][team_id][BT_Color] = team_id;
	TDM_BaseTeam[session_id][team_id][BT_GangZone] = GangZoneCreate(minx, miny, maxx, maxy);

	Iter_Add(TDM_BaseTeamCount[session_id], team_id);
	return 1;
}

stock TDM_DestroyBaseTeam(session_id, team_id)
{
	if(team_id != -1) {
		GangZoneDestroy(TDM_BaseTeam[session_id][team_id][BT_GangZone]);
		TDM_ResetBaseTeam(session_id, team_id);

		Iter_Remove(TDM_BaseTeamCount[session_id], team_id);
	}
	else {
		foreach(new tt:TDM_BaseTeamCount[session_id]) {
			GangZoneDestroy(TDM_BaseTeam[session_id][tt][BT_GangZone]);
			TDM_ResetBaseTeam(session_id, tt);
		}
		Iter_Clear(TDM_BaseTeamCount[session_id]);
	}
	return 1;
}

stock TDM_ResetBaseTeam(session_id, team_id)
{
	if(team_id == -1) {
		n_for(tt, TDM_MAX_TEAMS) {
			TDM_BaseTeam[session_id][tt][BT_Color] = TDM_TEAM_NONE;
			TDM_BaseTeam[session_id][tt][BT_VirtualWorld] =
			TDM_BaseTeam[session_id][tt][BT_Interior] = 0;
			TDM_BaseTeam[session_id][tt][BT_GangZone] = INVALID_GANG_ZONE;

			n_for2(i, sizeof(CameraBasePos[][])) {
				CameraBasePos[session_id][tt][i][0] =
				CameraBasePos[session_id][tt][i][1] =
				CameraBasePos[session_id][tt][i][2] = 0.0;
			}

			n_for2(i, sizeof(SpawnBasePos[][])) {
				SpawnBasePos[session_id][tt][i][0] =
				SpawnBasePos[session_id][tt][i][1] =
				SpawnBasePos[session_id][tt][i][2] = 0.0;
			}
		}
	}
	else {
		TDM_BaseTeam[session_id][team_id][BT_Color] = TDM_TEAM_NONE;
		TDM_BaseTeam[session_id][team_id][BT_VirtualWorld] =
		TDM_BaseTeam[session_id][team_id][BT_Interior] = 0;
		TDM_BaseTeam[session_id][team_id][BT_GangZone] = INVALID_GANG_ZONE;

		n_for(i, sizeof(CameraBasePos[][])) {
			CameraBasePos[session_id][team_id][i][0] =
			CameraBasePos[session_id][team_id][i][1] =
			CameraBasePos[session_id][team_id][i][2] = 0.0;
		}

		n_for(i, sizeof(SpawnBasePos[][])) {
			SpawnBasePos[session_id][team_id][i][0] =
			SpawnBasePos[session_id][team_id][i][1] =
			SpawnBasePos[session_id][team_id][i][2] = 0.0;
		}
	}
	return 1;
}

stock TDM_SetCameraBaseTeam(session_id, team_id, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
{
	CameraBasePos[session_id][team_id][0][0] = x;
	CameraBasePos[session_id][team_id][0][1] = y;
	CameraBasePos[session_id][team_id][0][2] = z;

	CameraBasePos[session_id][team_id][1][0] = x2;
	CameraBasePos[session_id][team_id][1][1] = y2;
	CameraBasePos[session_id][team_id][1][2] = z2;
	return 1;
}

stock TDM_SetSpawnBaseTeam(session_id, team_id, cell, Float:x, Float:y, Float:z)
{
	SpawnBasePos[session_id][team_id][cell][0] = x;
	SpawnBasePos[session_id][team_id][cell][1] = y;
	SpawnBasePos[session_id][team_id][cell][2] = z;
	return 1;
}

stock TDM_GetBaseSpawn(session_id, base_id, random_pos, &Float:X, &Float:Y, &Float:Z)
{
	X = SpawnBasePos[session_id][base_id][random_pos][0];
	Y = SpawnBasePos[session_id][base_id][random_pos][1];
	Z = SpawnBasePos[session_id][base_id][random_pos][2];
	return 1;
}

/*
	Capture point
*/

stock TDM_CreateCapturePoint(session_id, cell, const name[], Float:x, Float:y, Float:z, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	new 
		vworld = Mode_GetVirtualWorld(MODE_TDM, session_id),
		vint = Mode_GetInterior(MODE_TDM, session_id);

	TDM_CapturePoint[session_id][cell][CP_Name][0] = EOS;

	strins(TDM_CapturePoint[session_id][cell][CP_Name], name, 0);

	TDM_CapturePoint[session_id][cell][CP_PosX] = x;
	TDM_CapturePoint[session_id][cell][CP_PosY] = y;
	TDM_CapturePoint[session_id][cell][CP_PosZ] = z;

	TDM_CapturePoint[session_id][cell][CP_Minx] = minx;
	TDM_CapturePoint[session_id][cell][CP_Miny] = miny;
	TDM_CapturePoint[session_id][cell][CP_Maxx] = maxx;
	TDM_CapturePoint[session_id][cell][CP_Maxy] = maxy;

	TDM_CapturePoint[session_id][cell][CP_VirtualWorld] = vworld;
	TDM_CapturePoint[session_id][cell][CP_Interior] = vint;

	TDM_CapturePoint[session_id][cell][CP_GangZone] = GangZoneCreate(minx, miny, maxx, maxy);
	TDM_CapturePoint[session_id][cell][CP_Sphere] = CreateDynamicSphere(x, y, z, 15.0, vworld, vint, -1);
	TDM_CapturePoint[session_id][cell][CP_MapIcon] = CreateDynamicMapIcon(x, y, z, 19, 0, vworld, vint, -1, 300.0);
	TDM_CapturePoint[session_id][cell][CP_3DText] = CreateDynamic3DTextLabel("_", -1, x, y, z + 1.0, 700.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vworld, vint);
	
	z += 8.11;

	TDM_CapturePoint[session_id][cell][CP_Object][0] = CreateDynamicObject(1308, x, y, z, 900.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	SetDynamicObjectMaterial(TDM_CapturePoint[session_id][cell][CP_Object][0], 1, 3271, "boneyard", "bonyrd_skin1", -1);
	TDM_CapturePoint[session_id][cell][CP_Object][1] = CreateDynamicObject(2030, x - 0.08, y - 0.05, z - 9.47, 0.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	TDM_CapturePoint[session_id][cell][CP_Object][2] = CreateDynamicObject(3385, x - 0.06, y - 0.05, z - 9.09, 0.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	TDM_CapturePoint[session_id][cell][CP_Object][3] = CreateDynamicObject(19294, x - 0.16, y - 0.08, z - 3.9, 0.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	TDM_CapturePoint[session_id][cell][CP_Object][4] = CreateDynamicObject(2168, x + 0.41, y - 0.84, z - 9.02, 0.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	ChangeColorPointFlag(session_id, cell, TDM_TEAM_NONE);

	Iter_Add(TDM_CapturePointCount[session_id], cell);
	return 1;
}

stock TDM_DestroyCapturePoint(session_id, cell)
{
	if(cell != -1) {
		GangZoneDestroy(TDM_CapturePoint[session_id][cell][CP_GangZone]);
		DestroyDynamicArea(TDM_CapturePoint[session_id][cell][CP_Sphere]);
		DestroyDynamicMapIcon(TDM_CapturePoint[session_id][cell][CP_MapIcon]);
		DestroyDynamic3DTextLabel(TDM_CapturePoint[session_id][cell][CP_3DText]);

		n_for(i, 5)
			DestroyDynamicObject(TDM_CapturePoint[session_id][cell][CP_Object][i]);

		TDM_ResetCapturePoint(session_id, cell);

		Iter_Remove(TDM_CapturePointCount[session_id], cell);
	}
	else {
		foreach(new g:TDM_CapturePointCount[session_id]) {	
			GangZoneDestroy(TDM_CapturePoint[session_id][g][CP_GangZone]);
			DestroyDynamicArea(TDM_CapturePoint[session_id][g][CP_Sphere]);
			DestroyDynamicMapIcon(TDM_CapturePoint[session_id][g][CP_MapIcon]);
			DestroyDynamic3DTextLabel(TDM_CapturePoint[session_id][g][CP_3DText]);

			n_for(i, 5)
				DestroyDynamicObject(TDM_CapturePoint[session_id][g][CP_Object][i]);

			TDM_ResetCapturePoint(session_id, g);
		}
		Iter_Clear(TDM_CapturePointCount[session_id]);
	}
	return 1;
}

stock TDM_ResetCapturePoint(session_id, point_id)
{
	if(point_id == -1) {
		n_for(p, TDM_MAX_CAPTURE_POINTS) {
			TDM_CapturePoint[session_id][p][CP_Name][0] = EOS;
			TDM_CapturePoint[session_id][p][CP_Color] = TDM_TEAM_NONE;
			TDM_CapturePoint[session_id][p][CP_CaptureTeam] = TDM_TEAM_NONE;
			TDM_CapturePoint[session_id][p][CP_Red] = false;
			TDM_CapturePoint[session_id][p][CP_Chet] = 0;
			TDM_CapturePoint[session_id][p][CP_Property] = TDM_TEAM_NONE;
			TDM_CapturePoint[session_id][p][CP_VirtualWorld] =
			TDM_CapturePoint[session_id][p][CP_Interior] = 0;
			TDM_CapturePoint[session_id][p][CP_GangZone] = INVALID_GANG_ZONE;
			TDM_CapturePoint[session_id][p][CP_Sphere] = INVALID_DYNAMIC_AREA_ID;
			TDM_CapturePoint[session_id][p][CP_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
			TDM_CapturePoint[session_id][p][CP_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

			n_for2(i, 5)
				TDM_CapturePoint[session_id][p][CP_Object][i] = INVALID_DYNAMIC_OBJECT_ID;

			n_for2(i, sizeof(CameraPointPos[][])) {
				CameraPointPos[session_id][p][i][0] =
				CameraPointPos[session_id][p][i][1] =
				CameraPointPos[session_id][p][i][2] = 0.0;
			}

			n_for2(i, sizeof(SpawnPointPos[][])) {
				SpawnPointPos[session_id][p][i][0] =
				SpawnPointPos[session_id][p][i][1] =
				SpawnPointPos[session_id][p][i][2] = 0.0;
			}
		}
	}
	else {
		TDM_CapturePoint[session_id][point_id][CP_Name][0] = EOS;
		TDM_CapturePoint[session_id][point_id][CP_Color] = TDM_TEAM_NONE;
		TDM_CapturePoint[session_id][point_id][CP_CaptureTeam] = TDM_TEAM_NONE;
		TDM_CapturePoint[session_id][point_id][CP_Red] = false;
		TDM_CapturePoint[session_id][point_id][CP_Chet] = 0;
		TDM_CapturePoint[session_id][point_id][CP_Property] = TDM_TEAM_NONE;
		TDM_CapturePoint[session_id][point_id][CP_VirtualWorld] =
		TDM_CapturePoint[session_id][point_id][CP_Interior] = 0;
		TDM_CapturePoint[session_id][point_id][CP_GangZone] = INVALID_GANG_ZONE;
		TDM_CapturePoint[session_id][point_id][CP_Sphere] = INVALID_DYNAMIC_AREA_ID;
		TDM_CapturePoint[session_id][point_id][CP_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		TDM_CapturePoint[session_id][point_id][CP_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

		n_for(i, 5)
			TDM_CapturePoint[session_id][point_id][CP_Object][i] = INVALID_DYNAMIC_OBJECT_ID;

		n_for(i, sizeof(CameraPointPos[][])) {
			CameraPointPos[session_id][point_id][i][0] =
			CameraPointPos[session_id][point_id][i][1] =
			CameraPointPos[session_id][point_id][i][2] = 0.0;
		}

		n_for(i, sizeof(SpawnPointPos[][])) {
			SpawnPointPos[session_id][point_id][i][0] =
			SpawnPointPos[session_id][point_id][i][1] =
			SpawnPointPos[session_id][point_id][i][2] = 0.0;
		}
	} 
	return 1;
}

static SetPointFlagPos(session_id, point_id, type)
{
	if(!IsValidDynamicObject(TDM_CapturePoint[session_id][point_id][CP_Object][4]))
		return 0;

	new
		Float:X, Float:Y, Float:Z,
		Float:RotX, Float:RotY, Float:RotZ;
		
	GetDynamicObjectPos(TDM_CapturePoint[session_id][point_id][CP_Object][0], X, Y, Z);
	GetDynamicObjectRot(TDM_CapturePoint[session_id][point_id][CP_Object][4], RotX, RotY, RotZ);

	if(IsDynamicObjectMoving(TDM_CapturePoint[session_id][point_id][CP_Object][4])) 
		StopDynamicObject(TDM_CapturePoint[session_id][point_id][CP_Object][4]);

	switch(type) {
		case 1: SetDynamicObjectPos(TDM_CapturePoint[session_id][point_id][CP_Object][4], X + 0.41, Y - 0.84, Z - 9.02);
		case 2: SetDynamicObjectPos(TDM_CapturePoint[session_id][point_id][CP_Object][4], X + 0.41, Y - 0.84, (Z - 9.02) + (0.4 * 20));
	}
	SetDynamicObjectRot(TDM_CapturePoint[session_id][point_id][CP_Object][4], RotX, RotY, RotZ);
	return 1;
}

static MovePointFlag(session_id, point_id, type, bool:speed = false)
{
	if(!IsValidDynamicObject(TDM_CapturePoint[session_id][point_id][CP_Object][4]))
		return 0;

	new
		Float:X, Float:Y, Float:Z;
		
	GetDynamicObjectPos(TDM_CapturePoint[session_id][point_id][CP_Object][4], X, Y, Z);

	switch(type) {
		case 1: {
			if(!speed)
				MoveDynamicObject(TDM_CapturePoint[session_id][point_id][CP_Object][4], X, Y, Z + 0.4, 3.0, 0.00000, 0.00000, 0.00000);
			else 
				MoveDynamicObject(TDM_CapturePoint[session_id][point_id][CP_Object][4], X, Y, Z + 0.8, 3.0, 0.00000, 0.00000, 0.00000);
		}
		case 2: {
			if(!speed)
				MoveDynamicObject(TDM_CapturePoint[session_id][point_id][CP_Object][4], X, Y, Z - 0.4, 3.0, 0.00000, 0.00000, 0.00000);
			else 
				MoveDynamicObject(TDM_CapturePoint[session_id][point_id][CP_Object][4], X, Y, Z - 0.8, 3.0, 0.00000, 0.00000, 0.00000);
		}
	}
	return 1;
}

static ChangeColorPointFlag(session_id, point_id, team_id)
{
	if(IsValidDynamicObject(TDM_CapturePoint[session_id][point_id][CP_Object][4]))
		SetDynamicObjectMaterial(TDM_CapturePoint[session_id][point_id][CP_Object][4], 0, -1, "none", "none", TDM_ShowTeamColorObject(team_id));

	return 1;
}

static CreatePlayerPointCapture(playerid, gangzone_id)
{
	if(GangZonePlayerCapture[playerid] != -1)
		DestroyPlayerPointCapture(playerid);

	new
		session_id = Mode_GetPlayerSession(playerid),
		str[20];

	GangZonePlayerCapture[playerid] = gangzone_id;
	GangZoneCaptureBar[playerid] = CreatePlayerProgressBar(playerid, 285.00, 279.00, 75.50, 7.19, 0xCCCCCC00, TDM_MAX_CHET_CAPTURE.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarColour(playerid, GangZoneCaptureBar[playerid], TDM_ShowTeamColorXB(TDM_CapturePoint[session_id][gangzone_id][CP_Property]));
	SetPlayerProgressBarValue(playerid, GangZoneCaptureBar[playerid], floatround(TDM_CapturePoint[session_id][gangzone_id][CP_Chet]));
	ShowPlayerProgressBar(playerid, GangZoneCaptureBar[playerid]);

	ShowTDGangZoneCapture(playerid);

	f(str, "Точка: ~y~%s", GetNamePoint(gangzone_id));
	PlayerTextDrawSetString(playerid, TD_GangZone[playerid], str);
	PlayerTextDrawShow(playerid, TD_GangZone[playerid]);
	return 1;
}

static DestroyPlayerPointCapture(playerid)
{
	if(GangZonePlayerCapture[playerid] == -1)
		return 0;

	DestroyPlayerProgressBar(playerid, GangZoneCaptureBar[playerid]);
	DestroyPlayerTD(playerid, TD_GangZone[playerid]);

	GangZonePlayerCapture[playerid] = -1;
	return 1;
}

stock TDM_GetGangZonePlayer(playerid, &point_id)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	foreach(new g:TDM_CapturePointCount[session_id]) {
		if(TDM_CapturePoint[session_id][g][CP_VirtualWorld] != GetPlayerVirtualWorldEx(playerid))
			continue;

		if(TDM_CapturePoint[session_id][g][CP_Interior] != GetPlayerInteriorEx(playerid))
			continue;

		if(!IsPlayerInDynamicArea(playerid, TDM_CapturePoint[session_id][g][CP_Sphere]))
			continue;

		point_id = g;
	}
	return 1;
}

stock TDM_SetCameraCapturePoint(session_id, cell, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
{
	CameraPointPos[session_id][cell][0][0] = x;
	CameraPointPos[session_id][cell][0][1] = y;
	CameraPointPos[session_id][cell][0][2] = z;

	CameraPointPos[session_id][cell][1][0] = x2;
	CameraPointPos[session_id][cell][1][1] = y2;
	CameraPointPos[session_id][cell][1][2] = z2;
	return 1;
}

stock TDM_SetSpawnCapturePoint(session_id, cell, cell2, Float:x, Float:y, Float:z)
{
	SpawnPointPos[session_id][cell][cell2][0] = x;
	SpawnPointPos[session_id][cell][cell2][1] = y;
	SpawnPointPos[session_id][cell][cell2][2] = z;
	return 1;
}

stock TDM_LocGetCapturePointSpawn(session_id, point_id, random_pos, &Float:X, &Float:Y, &Float:Z)
{
	X = SpawnPointPos[session_id][point_id][random_pos][0];
	Y = SpawnPointPos[session_id][point_id][random_pos][1];
	Z = SpawnPointPos[session_id][point_id][random_pos][2];
	return 1;
}

stock TDM_SetCPTeamChet(session_id, team_id, num)
{
	if(num)
		CP_TeamChet[session_id][team_id] += num;
	else
		CP_TeamChet[session_id][team_id] = 0;

	return 1;
}

stock TDM_GetCPTeamChet(session_id, team_id)
{
	return CP_TeamChet[session_id][team_id];
}

stock TDM_SetCPTeamMaxChet(session_id, team_id, num)
{
	if(num)
		CP_TeamMaxChet[session_id][team_id] = num;
	else
		CP_TeamMaxChet[session_id][team_id] = 0;
		
	return 1;
}

stock TDM_GetCPTeamMaxChet(session_id, team_id)
{
	return CP_TeamMaxChet[session_id][team_id];
}

stock TDM_GiveCPPointTeam(session_id, team_id)
{
	foreach(new g:TDM_CapturePointCount[session_id]) {
		if(TDM_CapturePoint[session_id][g][CP_Color] == team_id)
			TDM_GiveTeamChet(session_id, team_id, 1);
	}
	return 1;
}

stock TDM_GetPointTeam(session_id, point_id)
{
	return TDM_CapturePoint[session_id][point_id][CP_Color];
}

stock TDM_GetPointRed(session_id, point_id)
{
	return TDM_CapturePoint[session_id][point_id][CP_Red];
}

stock TDM_GetPointName(session_id, point_id)
{
	new
		str[50];

	strcat(str, TDM_CapturePoint[session_id][point_id][CP_Name]);
	return str;
}

/*
	Computer
*/

stock TDM_CreateComputer(session_id, team_id, cell, Float:x, Float:y, Float:z)
{
	new 
		vworld = Mode_GetVirtualWorld(MODE_TDM, session_id),
		vint = Mode_GetInterior(MODE_TDM, session_id);

	PosComputers[session_id][team_id][cell][0] = x;
	PosComputers[session_id][team_id][cell][1] = y;
	PosComputers[session_id][team_id][cell][2] = z;

	TDM_Computer[session_id][team_id][cell][COMP_Enabled] = true;
	TDM_Computer[session_id][team_id][cell][COMP_ProtectTeam] = team_id;
	TDM_Computer[session_id][team_id][cell][COMP_VirtualWorld] = vworld;
	TDM_Computer[session_id][team_id][cell][COMP_Interior] = vint;
	TDM_Computer[session_id][team_id][cell][COMP_PlayerID] = -1;
	TDM_Computer[session_id][team_id][cell][COMP_Status] = team_id;
	TDM_Computer[session_id][team_id][cell][COMP_MapIcon] = CreateDynamicMapIcon(x, y, z, 16, 0, vworld, vint, -1, 1000.0, MAPICON_GLOBAL);
	TDM_Computer[session_id][team_id][cell][COMP_ObjectSmoke] = CreateDynamicObject(18728, x + 1.0, y, z - 7.0, 0.00000, 0.00000, 0.00000, vworld, vint);
	TDM_Computer[session_id][team_id][cell][COMP_3DText] = CreateDynamic3DTextLabel("_", -1, x, y, z + 2.0, 400.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vworld, vint);
	TDM_Computer[session_id][team_id][cell][COMP_3DTextClick] = CreateDynamic3DTextLabel("{10B3EA}Компьютер\n\n{D42C21}Нажмите {E5D110}[ ALT ]", -1, x, y, z, 13.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, vworld, vint);
	return 1;
}

stock TDM_DestroyComputer(session_id, team_id)
{
	if(team_id != -1) {
		n_for(c, TDM_MAX_COMPUTERS) {
			if(!TDM_Computer[session_id][team_id][c][COMP_Enabled])
				continue;

			DestroyDynamicObject(TDM_Computer[session_id][team_id][c][COMP_ObjectSmoke]);
			DestroyDynamic3DTextLabel(TDM_Computer[session_id][team_id][c][COMP_3DText]);
			DestroyDynamic3DTextLabel(TDM_Computer[session_id][team_id][c][COMP_3DTextClick]);
			if(!TDM_Computer[session_id][team_id][c][COMP_ActionCapture]) 
				DestroyDynamicMapIcon(TDM_Computer[session_id][team_id][c][COMP_MapIcon]);

			TDM_ResetComputer(session_id, team_id, c);
		}
	}
	else {
		n_for(tt, TDM_MAX_TEAMS) {
			n_for2(c, TDM_MAX_COMPUTERS) {
				if(!TDM_Computer[session_id][tt][c][COMP_Enabled])
					continue;

				DestroyDynamicObject(TDM_Computer[session_id][tt][c][COMP_ObjectSmoke]);
				DestroyDynamic3DTextLabel(TDM_Computer[session_id][tt][c][COMP_3DText]);
				DestroyDynamic3DTextLabel(TDM_Computer[session_id][tt][c][COMP_3DTextClick]);
				if(!TDM_Computer[session_id][tt][c][COMP_ActionCapture]) 
					DestroyDynamicMapIcon(TDM_Computer[session_id][tt][c][COMP_MapIcon]);
				
				TDM_ResetComputer(session_id, tt, c);
			}
		}
	}
	return 1;
}

stock TDM_ResetComputer(session_id, team_id, comp_id)
{
	if(team_id == -1
	&& comp_id == -1) {
		n_for(tt, TDM_MAX_TEAMS) {
			n_for2(c, TDM_MAX_COMPUTERS) {
				TDM_Computer[session_id][tt][c][COMP_Enabled] =
				TDM_Computer[session_id][tt][c][COMP_ActionCapture] =
				TDM_Computer[session_id][tt][c][COMP_Red] = false;
				TDM_Computer[session_id][tt][c][COMP_Status] =
				TDM_Computer[session_id][tt][c][COMP_Chet] =
				TDM_Computer[session_id][tt][c][COMP_Timer] =
				TDM_Computer[session_id][tt][c][COMP_VirtualWorld] =
				TDM_Computer[session_id][tt][c][COMP_Interior] = 0;
				TDM_Computer[session_id][tt][c][COMP_ProtectTeam] = TDM_TEAM_NONE;
				TDM_Computer[session_id][tt][c][COMP_PlayerID] = -1;
				TDM_Computer[session_id][tt][c][COMP_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
				TDM_Computer[session_id][tt][c][COMP_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
				TDM_Computer[session_id][tt][c][COMP_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
				TDM_Computer[session_id][tt][c][COMP_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;

				PosComputers[session_id][tt][c][0] =
				PosComputers[session_id][tt][c][1] =
				PosComputers[session_id][tt][c][2] = 0.0;
			}
		}
	}
	else {
		TDM_Computer[session_id][team_id][comp_id][COMP_Enabled] =
		TDM_Computer[session_id][team_id][comp_id][COMP_ActionCapture] =
		TDM_Computer[session_id][team_id][comp_id][COMP_Red] = false;
		TDM_Computer[session_id][team_id][comp_id][COMP_Status] =
		TDM_Computer[session_id][team_id][comp_id][COMP_Chet] =
		TDM_Computer[session_id][team_id][comp_id][COMP_Timer] =
		TDM_Computer[session_id][team_id][comp_id][COMP_VirtualWorld] =
		TDM_Computer[session_id][team_id][comp_id][COMP_Interior] = 0;
		TDM_Computer[session_id][team_id][comp_id][COMP_ProtectTeam] = TDM_TEAM_NONE;
		TDM_Computer[session_id][team_id][comp_id][COMP_PlayerID] = -1;
		TDM_Computer[session_id][team_id][comp_id][COMP_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
		TDM_Computer[session_id][team_id][comp_id][COMP_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		TDM_Computer[session_id][team_id][comp_id][COMP_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		TDM_Computer[session_id][team_id][comp_id][COMP_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;

		PosComputers[session_id][team_id][comp_id][0] =
		PosComputers[session_id][team_id][comp_id][1] =
		PosComputers[session_id][team_id][comp_id][2] = 0.0;
	}
	return 1;
}

static CreatePlayerComputer(playerid, team_id, comp_id) 
{
	if(ComputerPlayerCapture[playerid] != -1)
		DestroyPlayerComputer(playerid);

	new
		session_id = Mode_GetPlayerSession(playerid);

	TDM_Computer[session_id][team_id][comp_id][COMP_Red] = true;
	TDM_Computer[session_id][team_id][comp_id][COMP_PlayerID] = playerid;
	ComputerPlayerCapture[playerid] = comp_id;
	ComputerPlayerTeam[playerid] = team_id;

	if(TDM_Computer[session_id][team_id][comp_id][COMP_ProtectTeam] != GetPlayerTeamEx(playerid))
		TDM_Computer[session_id][team_id][comp_id][COMP_Chet] = 0;
	else 
		TDM_Computer[session_id][team_id][comp_id][COMP_Chet] = TDM_MAX_CHET_COMPUTER;

	new 
		str[100];

	ShowTDHackComputer(playerid);

	f(str, "%s ~w~- Компьютер: ~y~%i", TDM_GetTeamName(team_id), comp_id + 1);
	PlayerTextDrawColour(playerid, TD_ComputerHack[playerid], TDM_ShowTeamColorXB(team_id));
	PlayerTextDrawSetString(playerid, TD_ComputerHack[playerid], str);
	PlayerTextDrawShow(playerid, TD_ComputerHack[playerid]);

	ComputerCaptureBar[playerid] = CreatePlayerProgressBar(playerid, 281.00, 250.00, 84.50, 7.19, 0xC7DBFFAA, 10.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarValue(playerid, ComputerCaptureBar[playerid], floatround(TDM_Computer[session_id][team_id][comp_id][COMP_Chet]));
	ShowPlayerProgressBar(playerid, ComputerCaptureBar[playerid]);
	return 1;
}

static DestroyPlayerComputer(playerid)
{
	if(ComputerPlayerCapture[playerid] == -1)
		return 0;

	new
		session_id = Mode_GetPlayerSession(playerid);

	new 
		c = ComputerPlayerCapture[playerid],
		team = ComputerPlayerTeam[playerid];

	TDM_Computer[session_id][team][c][COMP_Red] = false;
	TDM_Computer[session_id][team][c][COMP_PlayerID] = -1;

	DestroyPlayerProgressBar(playerid, ComputerCaptureBar[playerid]);
	DestroyPlayerTD(playerid, TD_ComputerHack[playerid]);

	ComputerPlayerCapture[playerid] = -1;
	ComputerPlayerTeam[playerid] = TDM_TEAM_NONE;

	if(TDM_Computer[session_id][team][c][COMP_ProtectTeam] != GetPlayerTeamEx(playerid))
		TDM_Computer[session_id][team][c][COMP_Chet] = 0;
	else 
		TDM_Computer[session_id][team][c][COMP_Chet] = TDM_MAX_CHET_COMPUTER;

	return 1;
}

stock TDM_SetCompTeamChet(session_id, team_id, num)
{
	if(num)
		COMP_TeamChet[session_id][team_id] += num;
	else
		COMP_TeamChet[session_id][team_id] = 0;

	return 1;
}

stock TDM_GetCompTeamChet(session_id, team_id)
{
	return COMP_TeamChet[session_id][team_id];
}

stock TDM_SetCompTeamMaxChet(session_id, team_id, num)
{
	if(num)
		COMP_TeamMaxChet[session_id][team_id] = num;
	else
		COMP_TeamMaxChet[session_id][team_id] = 0;
		
	return 1;
}

stock TDM_GetCompTeamMaxChet(session_id, team_id)
{
	return COMP_TeamMaxChet[session_id][team_id];
}

/*
	Capture Flag
*/

stock TDM_CreateCaptureFlag(session_id, team_id, Float:x, Float:y, Float:z)
{
	new 
		vworld = Mode_GetVirtualWorld(MODE_TDM, session_id),
		vint = Mode_GetInterior(MODE_TDM, session_id);

	PosCaptureFlag[session_id][team_id][0] = x;
	PosCaptureFlag[session_id][team_id][1] = y;
	PosCaptureFlag[session_id][team_id][2] = z;
	
	TDM_CaptureFlag[session_id][team_id][FLAG_PlayerID] = -1;
	TDM_CaptureFlag[session_id][team_id][FLAG_VirtualWorld] = vworld;
	TDM_CaptureFlag[session_id][team_id][FLAG_Interior] = vint;

	TDM_CaptureFlag[session_id][team_id][FLAG_Object][0] = CreateDynamicObject(19357, x, y, z - 1.0, 0.00000, 90.00000, 0.00000, vworld, vint);
	TDM_CaptureFlag[session_id][team_id][FLAG_Object][1] = CreateDynamicObject(19357, x, y, z - 1.0, 0.00000, 90.00000, 0.00000, vworld, vint);
	TDM_CaptureFlag[session_id][team_id][FLAG_ObjectFlag] = CreateDynamicObject(2993, x, y, z - 1.0, 0.00000, 0.00000, 0.00000, vworld, vint);
	TDM_CaptureFlag[session_id][team_id][FLAG_MapIcon] = CreateDynamicMapIcon(x, y, z, 53, 0, vworld, vint, -1, 1000.0, MAPICON_GLOBAL);
	TDM_CaptureFlag[session_id][team_id][FLAG_ObjectSmoke] = CreateDynamicObject(18728, x + 1.0, y, z - 7.0, 0.00000, 0.00000, 0.00000, vworld, vint);
	
	new
		str[200];

	f(str, "{10B3EA}Флаг\n{FFFFFF}[%s%s{FFFFFF}]\n\n{D42C21}Нажмите {E5D110}[ ALT ]", TDM_ShowTeamColor(team_id), TDM_GetTeamName(team_id));
	TDM_CaptureFlag[session_id][team_id][FLAG_3DTextClick] = CreateDynamic3DTextLabel(str, -1, x, y, z, 13.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, vworld, vint);

	Iter_Add(TDM_CaptureFlagCount[session_id], team_id);
	return 1;
}

stock TDM_DestroyCaptureFlag(session_id, team_id)
{
	if(team_id != -1) {
		n_for(o, 2)
			DestroyDynamicObject(TDM_CaptureFlag[session_id][team_id][FLAG_Object][o]);
	
		if(IsValidDynamicObject(TDM_CaptureFlag[session_id][team_id][FLAG_ObjectFlag])) 
			DestroyDynamicObject(TDM_CaptureFlag[session_id][team_id][FLAG_ObjectFlag]);

		if(IsValidDynamic3DTextLabel(TDM_CaptureFlag[session_id][team_id][FLAG_3DTextCapture]))
			DestroyDynamic3DTextLabel(TDM_CaptureFlag[session_id][team_id][FLAG_3DTextCapture]);

		DestroyDynamic3DTextLabel(TDM_CaptureFlag[session_id][team_id][FLAG_3DTextClick]);
		DestroyDynamicObject(TDM_CaptureFlag[session_id][team_id][FLAG_ObjectSmoke]);
		DestroyDynamicMapIcon(TDM_CaptureFlag[session_id][team_id][FLAG_MapIcon]);

		TDM_ResetCaptureFlag(session_id, team_id);

		Iter_Remove(TDM_CaptureFlagCount[session_id], team_id);
	}
	else {
		foreach(new tt:TDM_CaptureFlagCount[session_id]) {
			n_for(o, 2)
				DestroyDynamicObject(TDM_CaptureFlag[session_id][tt][FLAG_Object][o]);

			if(IsValidDynamicObject(TDM_CaptureFlag[session_id][tt][FLAG_ObjectFlag])) 
				DestroyDynamicObject(TDM_CaptureFlag[session_id][tt][FLAG_ObjectFlag]);

			if(IsValidDynamic3DTextLabel(TDM_CaptureFlag[session_id][tt][FLAG_3DTextCapture]))
				DestroyDynamic3DTextLabel(TDM_CaptureFlag[session_id][tt][FLAG_3DTextCapture]);

			DestroyDynamic3DTextLabel(TDM_CaptureFlag[session_id][tt][FLAG_3DTextClick]);
			DestroyDynamicObject(TDM_CaptureFlag[session_id][tt][FLAG_ObjectSmoke]);
			DestroyDynamicMapIcon(TDM_CaptureFlag[session_id][tt][FLAG_MapIcon]);

			TDM_ResetCaptureFlag(session_id, tt);
		}
		Iter_Clear(TDM_CaptureFlagCount[session_id]);
	}
	return 1;
}

stock TDM_ResetCaptureFlag(session_id, team_id)
{
	if(team_id == -1) {
		n_for(tt, TDM_MAX_TEAMS) {
			TDM_CaptureFlag[session_id][tt][FLAG_Status] = 0;
			TDM_CaptureFlag[session_id][tt][FLAG_PlayerID] = -1;
			TDM_CaptureFlag[session_id][tt][FLAG_VirtualWorld] =
			TDM_CaptureFlag[session_id][tt][FLAG_Interior] = 0;

			n_for2(o, 2)
				TDM_CaptureFlag[session_id][tt][FLAG_Object][o] = INVALID_DYNAMIC_OBJECT_ID;

			TDM_CaptureFlag[session_id][tt][FLAG_ObjectFlag] = INVALID_DYNAMIC_OBJECT_ID;
			TDM_CaptureFlag[session_id][tt][FLAG_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
			TDM_CaptureFlag[session_id][tt][FLAG_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
			TDM_CaptureFlag[session_id][tt][FLAG_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;
			TDM_CaptureFlag[session_id][tt][FLAG_3DTextCapture] = INVALID_DYNAMIC_3D_TEXT_ID;

			PosCaptureFlag[session_id][tt][0] =
			PosCaptureFlag[session_id][tt][1] =
			PosCaptureFlag[session_id][tt][2] = 0.0;
		}
	}
	else {
		TDM_CaptureFlag[session_id][team_id][FLAG_Status] = 0;
		TDM_CaptureFlag[session_id][team_id][FLAG_PlayerID] = -1;
		TDM_CaptureFlag[session_id][team_id][FLAG_VirtualWorld] =
		TDM_CaptureFlag[session_id][team_id][FLAG_Interior] = 0;

		n_for(o, 2)
			TDM_CaptureFlag[session_id][team_id][FLAG_Object][o] = INVALID_DYNAMIC_OBJECT_ID;

		TDM_CaptureFlag[session_id][team_id][FLAG_ObjectFlag] = INVALID_DYNAMIC_OBJECT_ID;
		TDM_CaptureFlag[session_id][team_id][FLAG_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
		TDM_CaptureFlag[session_id][team_id][FLAG_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		TDM_CaptureFlag[session_id][team_id][FLAG_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;
		TDM_CaptureFlag[session_id][team_id][FLAG_3DTextCapture] = INVALID_DYNAMIC_3D_TEXT_ID;

		PosCaptureFlag[session_id][team_id][0] =
		PosCaptureFlag[session_id][team_id][1] =
		PosCaptureFlag[session_id][team_id][2] = 0.0;
	}
	return 1;
}

static CreateDynamic3DTextCaptureFlag(playerid, session_id, team_id)
{
	new
		str[200];

	f(str, "{FFFFFF}Флаг захвачен!\n{FFFFFF}[%s%s{FFFFFF}]", TDM_ShowTeamColor(team_id), TDM_GetTeamName(team_id));
	TDM_CaptureFlag[session_id][team_id][FLAG_3DTextCapture] = CreateDynamic3DTextLabel(str, -1, 0.0, 0.0, 0.0, 3000.0, playerid, INVALID_VEHICLE_ID, 1, TDM_CaptureFlag[session_id][team_id][FLAG_VirtualWorld], TDM_CaptureFlag[session_id][team_id][FLAG_Interior]);
	return 1;
}

static CreatePlayerCaptureFlag(playerid, flag_team) 
{
	if(ActionPlayerCaptureFlag[playerid] != -1)
		DestroyPlayerCaptureFlag(playerid);

	new
		session_id = Mode_GetPlayerSession(playerid);

	TDM_CaptureFlag[session_id][flag_team][FLAG_Status] = 1;
	TDM_CaptureFlag[session_id][flag_team][FLAG_PlayerID] = playerid;
	DestroyDynamicObject(TDM_CaptureFlag[session_id][flag_team][FLAG_ObjectFlag]);

	CreateDynamic3DTextCaptureFlag(playerid, session_id, flag_team);

	ActionPlayerCaptureFlag[playerid] = flag_team;
	SetPlayerColor(playerid, 0xcc1d1dBB);
	SetPlayerAttachedObject(playerid, 9, 2993, 1, -0.455999, -0.093999, -0.122999, -95.199981, 84.200012, -0.800000, 1.000000, 1.000000, 1.000000);
	return 1;
}

static DestroyPlayerCaptureFlag(playerid) 
{
	if(ActionPlayerCaptureFlag[playerid] == -1)
		return 0;

	new
		session_id = Mode_GetPlayerSession(playerid);

	new
		team_id = ActionPlayerCaptureFlag[playerid];

	TDM_CaptureFlag[session_id][team_id][FLAG_Status] = 0;
	TDM_CaptureFlag[session_id][team_id][FLAG_PlayerID] = -1;
	TDM_CaptureFlag[session_id][team_id][FLAG_ObjectFlag] = CreateDynamicObject(2993, PosCaptureFlag[session_id][team_id][0], PosCaptureFlag[session_id][team_id][1], PosCaptureFlag[session_id][team_id][2] - 1.0, 0.00000, 0.00000, 0.00000, TDM_CaptureFlag[session_id][team_id][FLAG_VirtualWorld], TDM_CaptureFlag[session_id][team_id][FLAG_Interior]);
	DestroyDynamic3DTextLabel(TDM_CaptureFlag[session_id][team_id][FLAG_3DTextCapture]);

	ActionPlayerCaptureFlag[playerid] = -1;
	if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) 
		RemovePlayerAttachedObject(playerid, 9);

	if(GetPlayerInvisible(playerid))
		SetPlayerColor(playerid, TDM_ShowTeamColorXB(GetPlayerTeamEx(playerid)) & 0xFFFFFF00);
	else
		SetPlayerColorEx(playerid, TDM_ShowTeamColorXB(GetPlayerTeamEx(playerid)));

	return 1;
}

static SpawnCaptureFlag(playerid, type)
{
	if(ActionPlayerCaptureFlag[playerid] == -1)
		return 0;

	new
		session_id = Mode_GetPlayerSession(playerid),
		team_flag = ActionPlayerCaptureFlag[playerid];

	DestroyPlayerCaptureFlag(playerid);

	switch(type) {
		case 0: TDM_SetTextTeamMatch(session_id, "Флаг возвращен!", team_flag);
		case 1: {
			new 
				player_team = GetPlayerTeamEx(playerid);

			SetPlayerFee(playerid, 400, 300, REPLEN_CAPTURE_FLAG);
			PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

			FLAG_TeamChet[session_id][player_team]++;
			TDM_SetTextTeamMatch(session_id, "Ваша команда получила одно очко!", player_team);
			
			//Квесты
			Quest_CheckPlayerProgress(playerid, MODE_TDM, 7);
			Quest_CheckPlayerProgress(playerid, MODE_TDM, 19);
			//
		}
	}
	return 1;
}

stock TDM_SetFlagTeamChet(session_id, team_id, num)
{
	if(num)
		FLAG_TeamChet[session_id][team_id] += num;
	else
		FLAG_TeamChet[session_id][team_id] = 0;

	return 1;
}

stock TDM_GetFlagTeamChet(session_id, team_id)
{
	return FLAG_TeamChet[session_id][team_id];
}

stock TDM_SetFlagTeamMaxChet(session_id, team_id, num)
{
	if(num)
		FLAG_TeamMaxChet[session_id][team_id] = num;
	else
		FLAG_TeamMaxChet[session_id][team_id] = 0;
		
	return 1;
}

stock TDM_GetFlagTeamMaxChet(session_id, team_id)
{
	return FLAG_TeamMaxChet[session_id][team_id];
}

/*
	Battle
*/

stock TDM_SetBattleTeamChet(session_id, team_id, num)
{
	if(num)
		BATTLE_TeamChet[session_id][team_id] += num;
	else
		BATTLE_TeamChet[session_id][team_id] = 0;

	return 1;
}

stock TDM_GetBattleTeamChet(session_id, team_id)
{
	return BATTLE_TeamChet[session_id][team_id];
}

stock TDM_SetBattleTeamMaxChet(session_id, team_id, num)
{
	if(num)
		BATTLE_TeamMaxChet[session_id][team_id] = num;
	else
		BATTLE_TeamMaxChet[session_id][team_id] = 0;
		
	return 1;
}

stock TDM_GetBattleTeamMaxChet(session_id, team_id)
{
	return BATTLE_TeamMaxChet[session_id][team_id];
}

/*
	Bag money
*/

stock TDM_CreateBagMoney(session_id, team_id, Float:x, Float:y, Float:z, virtualworld = -1, interior = -1)
{
	if(virtualworld == -1)
		virtualworld = Mode_GetVirtualWorld(MODE_TDM, session_id);
	if(interior == -1)
		interior = Mode_GetInterior(MODE_TDM, session_id);

	PosBagMoney[session_id][team_id][0] = x;
	PosBagMoney[session_id][team_id][1] = y;
	PosBagMoney[session_id][team_id][2] = z;
	
	TDM_BagMoney[session_id][team_id][BG_Team] = team_id;
	TDM_BagMoney[session_id][team_id][BG_VirtualWorld] = virtualworld;
	TDM_BagMoney[session_id][team_id][BG_Interior] = interior;

	TDM_BagMoney[session_id][team_id][BG_MapIcon] = CreateDynamicMapIcon(x, y, z, 52, 0, virtualworld, interior, -1, 5000.0, MAPICON_GLOBAL);
	TDM_BagMoney[session_id][team_id][BG_Pickup] = CreateDynamicPickup(1550, 1, x, y, z, virtualworld, interior);

	new
		str[200];

	f(str, "{10B3EA}Мешок денег\n{FFFFFF}[%s%s{FFFFFF}]\n\n{D42C21}Нажмите {E5D110}[ N ]", TDM_ShowTeamColor(team_id), TDM_GetTeamName(team_id));
	TDM_BagMoney[session_id][team_id][BG_3DText] = CreateDynamic3DTextLabel(str, -1, x, y, z, 9.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, virtualworld, interior);

	Iter_Add(TDM_BagMoneyCount[session_id], team_id);
	return 1;
}

stock TDM_DestroyBagMoney(session_id, team_id)
{
	if(team_id != -1) {
		DestroyDynamicMapIcon(TDM_BagMoney[session_id][team_id][BG_MapIcon]);
		DestroyDynamicPickup(TDM_BagMoney[session_id][team_id][BG_Pickup]);
		DestroyDynamic3DTextLabel(TDM_BagMoney[session_id][team_id][BG_3DText]);

		TDM_ResetBagMoney(session_id, team_id);
		
		Iter_Remove(TDM_BagMoneyCount[session_id], team_id);
	}
	else {
		foreach(new tt:TDM_BagMoneyCount[session_id]) {
			DestroyDynamicMapIcon(TDM_BagMoney[session_id][tt][BG_MapIcon]);
			DestroyDynamicPickup(TDM_BagMoney[session_id][tt][BG_Pickup]);
			DestroyDynamic3DTextLabel(TDM_BagMoney[session_id][tt][BG_3DText]);

			TDM_ResetBagMoney(session_id, tt);
		}
		Iter_Clear(TDM_BagMoneyCount[session_id]);
	}
	return 1;
}

stock TDM_ResetBagMoney(session_id, team_id)
{
	if(team_id == -1) {
		n_for(i, TDM_MAX_TEAMS) {
			TDM_BagMoney[session_id][i][BG_Team] = TDM_TEAM_NONE;
			TDM_BagMoney[session_id][i][BG_VirtualWorld] =
			TDM_BagMoney[session_id][i][BG_Interior] = 0;
			TDM_BagMoney[session_id][i][BG_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
			TDM_BagMoney[session_id][i][BG_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
			TDM_BagMoney[session_id][i][BG_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

			PosBagMoney[session_id][i][0] =
			PosBagMoney[session_id][i][1] =
			PosBagMoney[session_id][i][2] = 0.0;
		}
	}
	else {
		TDM_BagMoney[session_id][team_id][BG_Team] = TDM_TEAM_NONE;
		TDM_BagMoney[session_id][team_id][BG_VirtualWorld] =
		TDM_BagMoney[session_id][team_id][BG_Interior] = 0;
		TDM_BagMoney[session_id][team_id][BG_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		TDM_BagMoney[session_id][team_id][BG_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
		TDM_BagMoney[session_id][team_id][BG_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

		PosBagMoney[session_id][team_id][0] =
		PosBagMoney[session_id][team_id][1] =
		PosBagMoney[session_id][team_id][2] = 0.0;
	}
	return 1;
}

stock TDM_GetBagMoney(session_id)
{
	return Iter_Count(TDM_BagMoneyCount[session_id]);
}

stock TDM_SetPlayerBagMoney(playerid, bool:type)
{
	PlayerMoneyBag{playerid} = type;
	return 1;
}

stock TDM_GetPlayerBagMoney(playerid)
{
	return PlayerMoneyBag{playerid};
}

/*
	Shop
*/

stock TDM_CreateShop(session_id, team_id, Float:x, Float:y, Float:z, virtualworld = -1, interior = -1)
{
	if(virtualworld == -1)
		virtualworld = Mode_GetVirtualWorld(MODE_TDM, session_id);
	if(interior == -1)
		interior = Mode_GetInterior(MODE_TDM, session_id);

	PosShop[session_id][team_id][0] = x;
	PosShop[session_id][team_id][1] = y;
	PosShop[session_id][team_id][2] = z;
	
	TDM_Shop[session_id][team_id][WP_Team] = team_id;
	TDM_Shop[session_id][team_id][WP_VirtualWorld] = virtualworld;
	TDM_Shop[session_id][team_id][WP_Interior] = interior;

	TDM_Shop[session_id][team_id][WP_Pickup] = CreateDynamicPickup(2358, 23, x, y, z, virtualworld, interior);
	TDM_Shop[session_id][team_id][WP_MapIcon] = CreateDynamicMapIcon(x, y, z, 18, 0, virtualworld, interior, -1, 300.0, MAPICON_LOCAL);
	TDM_Shop[session_id][team_id][WP_ObjectSmoke] = CreateDynamicObject(18728, x + 0.5, y, z - 7.0, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	TDM_Shop[session_id][team_id][WP_3DText] = CreateDynamic3DTextLabel("{10B3EA}Магазин\n\n{D42C21}Нажмите {E5D110}[ N ]", -1, x, y, z, 17.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, virtualworld, interior);

	n_for(i, TDM_SHOP_MAX_ITEMS) {
		PriceShopTeam[session_id][team_id][i][sp_ItemID] = PriceShop[i][sp_ItemID];
		PriceShopTeam[session_id][team_id][i][sp_Count] = PriceShop[i][sp_Count];
		PriceShopTeam[session_id][team_id][i][sp_Price] = PriceShop[i][sp_Price];
	}
	RebateShopTeam[session_id][team_id] = 0;
	
	Iter_Add(TDM_ShopCount[session_id], team_id);
	return 1;
}

stock TDM_DestroyShop(session_id, team_id)
{
	if(team_id != -1) {
		DestroyDynamicPickup(TDM_Shop[session_id][team_id][WP_Pickup]);
		DestroyDynamicMapIcon(TDM_Shop[session_id][team_id][WP_MapIcon]);
		DestroyDynamicObject(TDM_Shop[session_id][team_id][WP_ObjectSmoke]);
		DestroyDynamic3DTextLabel(TDM_Shop[session_id][team_id][WP_3DText]);

		TDM_ResetShop(session_id, team_id);
		
		Iter_Remove(TDM_ShopCount[session_id], team_id);
	}
	else {
		foreach(new tt:TDM_ShopCount[session_id]) {
			DestroyDynamicPickup(TDM_Shop[session_id][tt][WP_Pickup]);
			DestroyDynamicMapIcon(TDM_Shop[session_id][tt][WP_MapIcon]);
			DestroyDynamicObject(TDM_Shop[session_id][tt][WP_ObjectSmoke]);
			DestroyDynamic3DTextLabel(TDM_Shop[session_id][tt][WP_3DText]);

			TDM_ResetShop(session_id, tt);
		}
		Iter_Clear(TDM_ShopCount[session_id]);
	}
	return 1;
}

stock TDM_ResetShop(session_id, team_id)
{
	if(team_id == -1) {
		n_for(tt, TDM_MAX_TEAMS) {
			TDM_Shop[session_id][tt][WP_Team] = TDM_TEAM_NONE;
			TDM_Shop[session_id][tt][WP_VirtualWorld] =
			TDM_Shop[session_id][tt][WP_Interior] = 0;
			TDM_Shop[session_id][tt][WP_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
			TDM_Shop[session_id][tt][WP_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
			TDM_Shop[session_id][tt][WP_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
			TDM_Shop[session_id][tt][WP_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

			n_for2(i, TDM_SHOP_MAX_ITEMS) {
				PriceShopTeam[session_id][tt][i][sp_ItemID] =
				PriceShopTeam[session_id][tt][i][sp_Count] =
				PriceShopTeam[session_id][tt][i][sp_Price] = 0;
			}
			RebateShopTeam[session_id][tt] = 0;

			PosShop[session_id][tt][0] =
			PosShop[session_id][tt][1] =
			PosShop[session_id][tt][2] = 0.0;
		}
	}
	else {
		TDM_Shop[session_id][team_id][WP_Team] = TDM_TEAM_NONE;
		TDM_Shop[session_id][team_id][WP_VirtualWorld] =
		TDM_Shop[session_id][team_id][WP_Interior] = 0;
		TDM_Shop[session_id][team_id][WP_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		TDM_Shop[session_id][team_id][WP_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
		TDM_Shop[session_id][team_id][WP_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
		TDM_Shop[session_id][team_id][WP_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

		n_for(i, TDM_SHOP_MAX_ITEMS) {
			PriceShopTeam[session_id][team_id][i][sp_ItemID] =
			PriceShopTeam[session_id][team_id][i][sp_Count] =
			PriceShopTeam[session_id][team_id][i][sp_Price] = 0;
		}
		RebateShopTeam[session_id][team_id] = 0;

		PosShop[session_id][team_id][0] =
		PosShop[session_id][team_id][1] =
		PosShop[session_id][team_id][2] = 0.0;
	}
	return 1;
}

stock TDM_GetShops(session_id)
{
	return Iter_Count(TDM_ShopCount[session_id]);
}

/*
	Fast point
*/

stock TDM_CreateFastPoint(session_id, Float:x, Float:y, Float:z)
{
	if(FastPoint[session_id][FP_Status]) 
		TDM_DestroyFastPoint(session_id);

	new
		vworld = Mode_GetVirtualWorld(MODE_TDM, session_id),
		vint = Mode_GetInterior(MODE_TDM, session_id);

	FastPoint[session_id][FP_PosX] = x;
	FastPoint[session_id][FP_PosY] = y;
	FastPoint[session_id][FP_PosZ] = z;

	FastPoint[session_id][FP_Status] = 1;
	FastPoint[session_id][FP_VirtualWorld] = vworld;
	FastPoint[session_id][FP_Interior] = vint;

	FastPoint[session_id][FP_Sphere] = CreateDynamicSphere(x, y, z, 10.0, vworld, vint);
	FastPoint[session_id][FP_MapIcon] = CreateDynamicMapIcon(x, y, z, 20, 0, vworld, vint, -1, 5000.0, MAPICON_GLOBAL);

	SetAirFastPoint(session_id, x, y, z, vworld, vint);

	m_for(MODE_TDM, session_id, p)
		SCM(p, -1, "{e31717}(Важно) {17e387}Появилась временная точка захвата!");

	return 1;
}

stock TDM_DestroyFastPoint(session_id, all = 0)
{
	if(!FastPoint[session_id][FP_Status])
		return 1;

	DestroyAirFastPoint(session_id);

	n_for(i, 8) {
		if(IsValidDynamicObject(FastPoint[session_id][FP_Object][i]))
			DestroyDynamicObject(FastPoint[session_id][FP_Object][i]);
	}

	if(IsValidDynamic3DTextLabel(FastPoint[session_id][FP_3DText]))
		DestroyDynamic3DTextLabel(FastPoint[session_id][FP_3DText]);

	DestroyDynamicArea(FastPoint[session_id][FP_Sphere]);
	DestroyDynamicMapIcon(FastPoint[session_id][FP_MapIcon]);

	TDM_ResetFastPoint(session_id, all);
	return 1;
}

stock TDM_ResetFastPoint(session_id, all)
{
	if(all == -1) {
		ActiveFastPoint[session_id] = false;
		n_for(i, sizeof(PosFastPoint)) {
			PosFastPoint[session_id][i][0] =
			PosFastPoint[session_id][i][1] =
			PosFastPoint[session_id][i][2] = 0.0;
		}
	}

	FastPoint[session_id][FP_Status] =
	FastPoint[session_id][FP_Timer] = 0;
	FastPoint[session_id][FP_Color] = TDM_TEAM_NONE;
	FastPoint[session_id][FP_CaptureTeam] = TDM_TEAM_NONE;
	FastPoint[session_id][FP_Red] = false;
	FastPoint[session_id][FP_Chet] = 0;
	FastPoint[session_id][FP_Property] = TDM_TEAM_NONE;
	FastPoint[session_id][FP_VirtualWorld] =
	FastPoint[session_id][FP_Interior] = 0;

	n_for(i, 8)
		FastPoint[session_id][FP_Object][i] = INVALID_DYNAMIC_OBJECT_ID;

	FastPoint[session_id][FP_Sphere] = INVALID_DYNAMIC_AREA_ID;
	FastPoint[session_id][FP_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
	FastPoint[session_id][FP_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

	FastPoint[session_id][FP_PosX] =
	FastPoint[session_id][FP_PosY] =
	FastPoint[session_id][FP_PosZ] = 0.0;
	return 1;
}

stock TDM_CreatePosFastPoint(session_id, cell, Float:x, Float:y, Float:z)
{
	if(!ActiveFastPoint[session_id])
		ActiveFastPoint[session_id] = true;

	PosFastPoint[session_id][cell][0] = x;
	PosFastPoint[session_id][cell][1] = y;
	PosFastPoint[session_id][cell][2] = z;
	return 1;
}

stock TDM_GetFastPoint(session_id)
{
	return ActiveFastPoint[session_id];
}

stock TDM_StartFastPoint(session_id)
{
	new
		random_pos = random(sizeof(PosFastPoint[]));

	TDM_CreateFastPoint(session_id, PosFastPoint[session_id][random_pos][0], PosFastPoint[session_id][random_pos][1], PosFastPoint[session_id][random_pos][2]);
	return 1;
}

stock TDM_FastPointReInfo(session_id) 
{
	if(FastPoint[session_id][FP_Status] <= 1)
		return 0;

	new
		team[TDM_MAX_TEAMS];

	foreach(new tt:TDM_ActiveTeams[session_id]) {
		m_for(MODE_TDM, session_id, p) {
			if(GetPlayerSpectating(p) > -1) 
				continue;

			if(FastPoint[session_id][FP_VirtualWorld] != GetPlayerVirtualWorldEx(p)) 
				continue;

			if(FastPoint[session_id][FP_Interior] != GetPlayerInteriorEx(p)) 
				continue;

			if(!FastPointPlayerCapture[p])
				continue;

			if(GetPlayerTeamEx(p) != tt)
				continue;

			team[tt]++;
		}
	}

	new
		most_players,
		win_team = -1,
		worse_team = -1,
		bool:draw;

	foreach(new tt:TDM_ActiveTeams[session_id]) {
		if(team[tt] > NONE) {
			if(team[tt] >= most_players) {
				if(draw) 
					draw = false;

				if(team[tt] == most_players) {
					if(win_team != -1)
						draw = true;
				}
				most_players = team[tt];
				win_team = tt;
			}
			else
				worse_team = tt;
		}
	}

	if(most_players == NONE) {
		if(FastPoint[session_id][FP_Chet])
			FastPoint[session_id][FP_Chet]--;
		else {
			if(FastPoint[session_id][FP_Property] != TDM_TEAM_NONE)
				FastPoint[session_id][FP_Property] = TDM_TEAM_NONE;
		}

		if(FastPoint[session_id][FP_Red]) {
			FastPoint[session_id][FP_Red] = false;
			FastPoint[session_id][FP_CaptureTeam] = TDM_TEAM_NONE;
		}

		if(FastPoint[session_id][FP_Color] == TDM_TEAM_NONE) {
			if(FastPoint[session_id][FP_Status] != 2) {
				FastPoint[session_id][FP_Status] = 2;
				FastPoint[session_id][FP_Timer] = 120 + gettime();
			}
		}
	}
	else {
		if(draw) {
			foreach(new tt:TDM_ActiveTeams[session_id]) {
				if(team[tt] == most_players) {
					if(tt != FastPoint[session_id][FP_Color]) {
						FastPoint[session_id][FP_Red] = true;
						FastPoint[session_id][FP_CaptureTeam] = tt;
						break;
					}
				}
			}
		}
		else {
			if(worse_team != -1) {
				if(worse_team != FastPoint[session_id][FP_Color]) {
					if(win_team == FastPoint[session_id][FP_Color])
						FastPoint[session_id][FP_Red] = true;
				}
			}
			if(win_team != -1) {
				if(win_team != FastPoint[session_id][FP_Color]) {
					FastPoint[session_id][FP_Red] = true;
					FastPoint[session_id][FP_CaptureTeam] = win_team;

					if(FastPoint[session_id][FP_Property] != win_team) {
						if(FastPoint[session_id][FP_Chet] > 0) {
							if(team[win_team] > 1)
								FastPoint[session_id][FP_Chet] -= 2;
							else
								FastPoint[session_id][FP_Chet]--;
						}
						if(FastPoint[session_id][FP_Chet] <= 0) {
							FastPoint[session_id][FP_Chet] = 0;
							FastPoint[session_id][FP_Property] = win_team;
						}
					}
					else {
						if(FastPoint[session_id][FP_Chet] < TDM_MAX_CHET_FAST_POINT) {
							if(team[win_team] > 1)
								FastPoint[session_id][FP_Chet] += 2;
							else
								FastPoint[session_id][FP_Chet]++;
				
							if(FastPoint[session_id][FP_Chet] >= TDM_MAX_CHET_FAST_POINT) {
								FastPoint[session_id][FP_Red] = false;
								FastPoint[session_id][FP_Color] = win_team;
								FastPoint[session_id][FP_CaptureTeam] = TDM_TEAM_NONE;
								FastPoint[session_id][FP_Chet] = 0;

								m_for(MODE_TDM, session_id, p) {
									if(!FastPointPlayerCapture[p]) 
										continue;

									if(GetPlayerTeamEx(p) != win_team) 
										continue;

									SetPlayerFee(p, 400, 250, REPLEN_CAPTURE);
									PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);
								}

								FastPoint[session_id][FP_Status] = 4;
								FastPoint[session_id][FP_Timer] = 40 + gettime();
							}
						}
					}
					if(FastPoint[session_id][FP_Status] != 3 && FastPoint[session_id][FP_Status] != 4) {
						FastPoint[session_id][FP_Status] = 3;
						FastPoint[session_id][FP_Timer] = 0;
					}
				}
				else {
					if(FastPoint[session_id][FP_Chet])
						FastPoint[session_id][FP_Chet]--;

					if(worse_team == -1) {
						if(FastPoint[session_id][FP_Red]) {
							FastPoint[session_id][FP_Red] = false;
							FastPoint[session_id][FP_CaptureTeam] = TDM_TEAM_NONE;
						}
					}
				}
			}
		}
	}

	new
		sticks[100],
		timer_text[50];

	if(!FastPoint[session_id][FP_Chet]) {
		f(sticks, "%s", TDM_ShowTeamColor(FastPoint[session_id][FP_Color]));
		n_for(i, TDM_MAX_CHET_FAST_POINT)
			strcat(sticks, "|");
	}
	else {
		new
			i;

		if(FastPoint[session_id][FP_Red]) {
			f(sticks, "%s", TDM_ShowTeamColor(FastPoint[session_id][FP_Property]));
			for(i = 0; i < FastPoint[session_id][FP_Chet]; i++)
				strcat(sticks, "|");

			f(sticks, "%s%s", sticks, TDM_ShowTeamColor(FastPoint[session_id][FP_Color]));
			for(; i < TDM_MAX_CHET_FAST_POINT; i++)
				strcat(sticks, "|");
		}
		else {
			f(sticks, "%s", TDM_ShowTeamColor(FastPoint[session_id][FP_Property]));
			for(i = 0; i < FastPoint[session_id][FP_Chet]; i++)
				strcat(sticks, "|");

			f(sticks, "%s%s", sticks, TDM_ShowTeamColor(FastPoint[session_id][FP_Color]));
			for(; i < TDM_MAX_CHET_FAST_POINT; i++)
				strcat(sticks, "|");
		}
	}

	if(FastPoint[session_id][FP_Status] == 4)
		f(timer_text, "{26a2eb}Захват: {eb2626}%i {26a2eb}секунд", FastPoint[session_id][FP_Timer] - gettime());

	new
		str[250];

	if(!FastPoint[session_id][FP_Red])
		f(str, "%sВременная точка\n\n{d6d6d6}[ %s{d6d6d6} ]\n%s", TDM_ShowTeamColor(FastPoint[session_id][FP_Color]), sticks, timer_text);
	else {
		f(str, "%sВременная точка\n{D53032}Захватывают %s%s\n\n{d6d6d6}[ %s{d6d6d6} ]\n%s", 
		TDM_ShowTeamColor(FastPoint[session_id][FP_Color]), TDM_ShowTeamColor(FastPoint[session_id][FP_CaptureTeam]), 
		TDM_GetTeamName(FastPoint[session_id][FP_CaptureTeam]), sticks, timer_text);
	}
	UpdateDynamic3DTextLabelText(FastPoint[session_id][FP_3DText], 0x000000FF, str);

	if(FastPoint[session_id][FP_Status] == 2) {
		if(FastPoint[session_id][FP_Timer] < gettime())
			TDM_DestroyFastPoint(session_id);
	}
	if(FastPoint[session_id][FP_Status] == 4) {
		if(FastPoint[session_id][FP_Timer] < gettime()) {
			if(TDM_GetShops(session_id))
				RebateShopTeam[session_id][FastPoint[session_id][FP_Color]]++;

			if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE)
				CP_TeamChet[session_id][FastPoint[session_id][FP_Color]] += 30;

			m_for(MODE_TDM, session_id, p) {
				if(GetPlayerTeamEx(p) == FastPoint[session_id][FP_Color]) {
					if(FastPointPlayerCapture[p]) {
						SetPlayerFee(p, 700, 500, REPLEN_CAPTURE);
						PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);
					}

					SCM(p, -1, "{e31717}(Важно) {17e387}Временная точка была успешно захвачена!");

					if(TDM_GetShops(session_id))
						SCM(p, -1, "{e31717}(Важно) {17e387}На базе добавлены скидки в магазине!");

					if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE)
						SCM(p, -1, "{e31717}(Важно) {17e387}Прибавлены очки команды!");
				}
				else
					SCM(p, -1, "{e31717}(Важно) {17e387}Враги захватили временную точку!");
			}
			TDM_DestroyFastPoint(session_id);
		}
	}
	return 1;
}

static IsPlayerReadyCaptureFastPoint(session_id, playerid)
{
	if(FastPoint[session_id][FP_VirtualWorld] == GetPlayerVirtualWorldEx(playerid)
	&& FastPoint[session_id][FP_Interior] == GetPlayerInteriorEx(playerid)
	&& !FastPointPlayerCapture[playerid]
	&& !GetPlayerDead(playerid)
	&& !Adm_GetPlayerSpectating(playerid)) 
		return 1;

	return 0;
}

static CreatePlayerFastPointArea(session_id, playerid)
{
	if(TDM_GetStatusGame(session_id) != TDM_LOC_GAME_STATUS_GAME)
		return 0;

	if(FastPoint[session_id][FP_Status] <= 1)
		return 0;

	if(IsPlayerInDynamicArea(playerid, FastPoint[session_id][FP_Sphere])) {
		if(IsPlayerReadyCaptureFastPoint(session_id, playerid))
			FastPointPlayerCapture[playerid] = 1;
	}
	return 1;
}

stock TDM_UpdateAirFastPoint(session_id)
{
	if(!FastPoint[session_id][FP_Status])
		return 0;

	switch(AirFastPoint[session_id][Air_Status]) {
		case 1: { // Отстыковка
			new
				Float:ax,
				Float:ay,
				Float:az;

			GetDynamicObjectPos(AirFastPoint[session_id][Air_ObjectAir], ax, ay, az);
			if(ay > (AirFastPoint[session_id][Air_PosY] - 50.0)) {
				AirFastPoint[session_id][Air_Status] = 2;
				new
					Float:bx,
					Float:by,
					Float:bz;

				GetDynamicObjectPos(AirFastPoint[session_id][Air_ObjectBox], bx, by, bz);
				StopDynamicObject(AirFastPoint[session_id][Air_ObjectBox]);
				MoveDynamicObject(AirFastPoint[session_id][Air_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
			}
		}
		case 2: { // Падение к цели
			AirFastPoint[session_id][Air_Status] = 3;
			new
				Float:bx,
				Float:by,
				Float:bz;

			GetDynamicObjectPos(AirFastPoint[session_id][Air_ObjectBox], bx, by, bz);

			AirFastPoint[session_id][Air_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirFastPoint[session_id][Air_VirtualWorld], AirFastPoint[session_id][Air_Interior]);

			StopDynamicObject(AirFastPoint[session_id][Air_ObjectBox]);
			MoveDynamicObject(AirFastPoint[session_id][Air_ObjectBox], AirFastPoint[session_id][Air_PosX], AirFastPoint[session_id][Air_PosY], AirFastPoint[session_id][Air_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
			MoveDynamicObject(AirFastPoint[session_id][Air_ObjectParachute], AirFastPoint[session_id][Air_PosX] + 0.0203, AirFastPoint[session_id][Air_PosY] - 0.0138, AirFastPoint[session_id][Air_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
			Streamer_UP(MODE_TDM, session_id);
		}
		case 3: { // Остановка у цели
			new
				Float:bx,
				Float:by,
				Float:bz;

			GetDynamicObjectPos(AirFastPoint[session_id][Air_ObjectBox], bx, by, bz);
			if((bx == AirFastPoint[session_id][Air_PosX]) 
			&& (by == AirFastPoint[session_id][Air_PosY]) 
			&& (bz == AirFastPoint[session_id][Air_PosZ] - 0.30000)) {
				FastPoint[session_id][FP_Status] = 2;
				FastPoint[session_id][FP_Timer] = 150 + gettime();

				AirFastPoint[session_id][Air_Status] = 4;
				AirFastPoint[session_id][Air_Timer] = gettime() + 15;

				DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectParachute]);

				FastPoint[session_id][FP_Object][0] = CreateDynamicObject(2061, bx - 0.02, by - 1.0 + 0.05, bz - 0.43,   0.00000, 0.00000, 0.00000, FastPoint[session_id][FP_VirtualWorld], FastPoint[session_id][FP_Interior]);
				FastPoint[session_id][FP_Object][1] = CreateDynamicObject(2061, bx + 1.0 - 0.3, by - 1.0 + 0.03, bz - 0.43,   0.00000, 0.00000, 0.00000, FastPoint[session_id][FP_VirtualWorld], FastPoint[session_id][FP_Interior]);
				FastPoint[session_id][FP_Object][2] = CreateDynamicObject(2041, bx + 1.0 - 0.37, by - 0.4, bz + 1.0 - 0.1,   0.00000, 0.00000, 0.00000, FastPoint[session_id][FP_VirtualWorld], FastPoint[session_id][FP_Interior]);
				FastPoint[session_id][FP_Object][3] = CreateDynamicObject(2041, bx + 1.0 - 0.9, by - 0.6, bz + 1.0 - 0.1,   0.00000, 0.00000, 84.00000, FastPoint[session_id][FP_VirtualWorld], FastPoint[session_id][FP_Interior]);
				FastPoint[session_id][FP_Object][4] = CreateDynamicObject(2041, bx + 1.0 - 0.8, by - 0.3, bz + 1.0 - 0.1,   0.00000, 0.00000, 40.00000, FastPoint[session_id][FP_VirtualWorld], FastPoint[session_id][FP_Interior]);
				FastPoint[session_id][FP_Object][5] = CreateDynamicObject(2042, bx - 0.3, by + 1.0 - 0.7, bz + 1.0 - 0.2,   0.00000, 0.00000, 0.00000, FastPoint[session_id][FP_VirtualWorld], FastPoint[session_id][FP_Interior]);
				FastPoint[session_id][FP_Object][6] = CreateDynamicObject(3015, bx - 0.37, by + 1.0 + 0.1, bz - 1.0 + 0.4,   0.00000, 0.00000, 0.00000, FastPoint[session_id][FP_VirtualWorld], FastPoint[session_id][FP_Interior]);
				FastPoint[session_id][FP_Object][7] = CreateDynamicObject(2358, bx + 1.0 - 0.5, by + 1.0 - 0.5, bz + 1.0 - 0.2,   0.00000, 0.00000, 76.00000, FastPoint[session_id][FP_VirtualWorld], FastPoint[session_id][FP_Interior]);

				FastPoint[session_id][FP_3DText] = CreateDynamic3DTextLabel("_", 0xFFFFFFFF, FastPoint[session_id][FP_PosX], FastPoint[session_id][FP_PosY], FastPoint[session_id][FP_PosZ], 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, FastPoint[session_id][FP_VirtualWorld], FastPoint[session_id][FP_Interior]);

				//CreateDynamicObject(1685, 62.97323, 2090.74927, 17.44248,   0.00000, 0.00000, 0.00000);

				//CreateDynamicObject(2061, 62.95085, 2089.79175, 17.01131,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(2061, 63.68470, 2089.77759, 17.01130,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(2041, 63.60580, 2090.33545, 18.38450,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(2041, 63.03876, 2090.12012, 18.38450,   0.00000, 0.00000, 84.00000);
				//CreateDynamicObject(2041, 63.15140, 2090.47363, 18.38450,   0.00000, 0.00000, 40.00000);
				//CreateDynamicObject(2042, 62.60100, 2091.02100, 18.27090,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(3015, 62.60590, 2091.87109, 16.82370,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(2358, 63.42210, 2091.22803, 18.31040,   0.00000, 0.00000, 76.00000);

				m_for(MODE_TDM, session_id, p) {
					if(IsPlayerInDynamicArea(p, FastPoint[session_id][FP_Sphere])) {
						if(IsPlayerReadyCaptureFastPoint(session_id, p))
							FastPointPlayerCapture[p] = 1;
					}
				}
			}
		}
		case 4: { // Удаление самолёта
			if(AirFastPoint[session_id][Air_Timer] < gettime()) {
				AirFastPoint[session_id][Air_Status] = 5;
				AirFastPoint[session_id][Air_Timer] = 0;
				DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectAir]);
				DestroyDynamic3DTextLabel(FastPoint[session_id][FP_3DText]);
			}
		}
	}
	return 1;
}

/*
	Транспорт
*/

stock TDM_CreateVehicle(session_id, team_id, cell, vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1 = -1, color2 = -1, respawn_delay = VEHICLE_RESPAWN_TIME, addsiren = 0)
{
	if(INVALID_VEHICLE_ID == (v_Vehicle[session_id][cell] = CreateVehicleEx(vehicletype, x, y, z, rotation, color1, color2, respawn_delay, addsiren)))
		return 0;

	new
		vehicleid = v_Vehicle[session_id][cell];

	Veh_SetMode(vehicleid, MODE_TDM);
	Veh_SetSession(vehicleid, session_id);
	Veh_SetTeam(vehicleid, team_id);

	TDM_VehicleSetSettings(vehicleid);
	return 1;
}

stock TDM_DestroyVehicle(session_id, cell)
{
	if(cell == -1) {
		n_for(i, TDM_MAX_VEHICLES) {
			DestroyVehicleEx(v_Vehicle[session_id][i]);
			ResetVehicle(session_id, i);
		}
	}
	else {
		DestroyVehicleEx(v_Vehicle[session_id][cell]);
		ResetVehicle(session_id, cell);
	}
	return 1;
}

static ResetVehicle(session_id, cell)
{
	if(cell == -1) {
		n_for(i, TDM_MAX_VEHICLES)
			v_Vehicle[session_id][i] = INVALID_VEHICLE_ID;
	}
	else
		v_Vehicle[session_id][cell] = INVALID_VEHICLE_ID;

	return 1;
}

stock TDM_GetVehicleID(session_id, cell)
{
	return v_Vehicle[session_id][cell];
}

stock TDM_SetVehicle(session_id, bool:type)
{
	ActiveVehicles[session_id] = type;
	return 1;
}

stock TDM_GetVehicle(session_id)
{
	return ActiveVehicles[session_id];
}

/*
	Счёт команд
*/

stock TDM_SetTeamChet(session_id, team_id, chet, maxchet)
{
	if(!ActiveTeamChet[session_id])
		ActiveTeamChet[session_id] = true;

	TDM_SetTeamModeChet(session_id, team_id, chet);
	TDM_SetTeamModeMaxChet(session_id, team_id, maxchet);
	return 1;
}

stock TDM_ResetTeamsChet(session_id)
{
	ActiveTeamChet[session_id] = false;

	foreach(new tt:TDM_ActiveTeamsChet[session_id]) {
		TDM_SetTeamModeChet(session_id, tt, 0);
		TDM_SetTeamModeMaxChet(session_id, tt, 0);
	}
	return 1;
}

stock TDM_GetTeamsChet(session_id)
{
	return ActiveTeamChet[session_id];
}

/*
	Время
*/

stock TDM_SetTimer(session_id, minutes, seconds)
{
	ActiveTimer[session_id] = true;

	PresetMinutesTimer[session_id] = minutes;
	PresetSecondsTimer[session_id] = seconds;

	Mode_SetMinutes(MODE_TDM, session_id, minutes);
	Mode_SetSeconds(MODE_TDM, session_id, seconds);
	return 1;
}

static TDM_ResetTimer(session_id)
{
	ActiveTimer[session_id] = false;
	PresetMinutesTimer[session_id] =
	PresetSecondsTimer[session_id] = 0;

	Mode_SetMinutes(MODE_TDM, session_id, 0);
	Mode_SetSeconds(MODE_TDM, session_id, 0);
	return 1;
}

stock TDM_GetActiveTimer(session_id)
{
	return ActiveTimer[session_id];
}

stock TDM_GetPresetMinutesTimer(session_id)
{
	return PresetMinutesTimer[session_id];
}

stock TDM_GetPresetSecondsTimer(session_id)
{
	return PresetSecondsTimer[session_id];
}

/*
	Зона локации
*/

stock TDM_SetExitZonePos(session_id, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	ActiveExitZone[session_id] = true;
	AreaExitZone[session_id] = CreateDynamicRectangle(minx, miny, maxx, maxy, Mode_GetVirtualWorld(MODE_TDM, session_id), Mode_GetInterior(MODE_TDM, session_id));
	return 1;
}

stock TDM_DestroyExitZone(session_id)
{
	if(IsValidDynamicArea(AreaExitZone[session_id]))
		DestroyDynamicArea(AreaExitZone[session_id]);

	TDM_ResetExitZone(session_id);
	return 1;
}

stock TDM_GetExitZone(session_id)
{
	return ActiveExitZone[session_id];
}

static TDM_ResetExitZone(session_id)
{
	ActiveExitZone[session_id] = false;
	AreaExitZone[session_id] = INVALID_DYNAMIC_AREA_ID;
	return 1;
}

/*
	Лучшие игроки
*/

stock TDM_SetSpawnTopActor(session_id, cell, Float:X, Float:Y, Float:Z, Float:Angle)
{
	ActorsTopKillsPos[session_id][cell][0] = X;
	ActorsTopKillsPos[session_id][cell][1] = Y;
	ActorsTopKillsPos[session_id][cell][2] = Z;
	ActorsTopKillsPos[session_id][cell][3] = Angle;
	return 1;
}

stock TDM_GetSpawnTopActor(session_id, cell, &Float:X, &Float:Y, &Float:Z, &Float:Angle)
{
	X = ActorsTopKillsPos[session_id][cell][0];
	Y = ActorsTopKillsPos[session_id][cell][1];
	Z = ActorsTopKillsPos[session_id][cell][2];
	Angle = ActorsTopKillsPos[session_id][cell][3];
	return 1;
}

static TDM_ResetSpawnTopActor(session_id)
{
	n_for(i, sizeof(ActorsTopKillsPos[])) {
		ActorsTopKillsPos[session_id][i][0] =
		ActorsTopKillsPos[session_id][i][1] =
		ActorsTopKillsPos[session_id][i][2] =
		ActorsTopKillsPos[session_id][i][3] = 0.0;
	}
	return 1;
}

/*
	Airs
*/

stock SetAirBomb(session_id, id, Float:x, Float:y, Float:z, virtualworld, interior) 
{
	n_for(i, MAX_AIR_BOMB) {
		if(AllAirBomb[session_id][i] > -1) 
			continue;

		AllAirBomb[session_id][i] = id;
		break;
	}

	AirBomb[session_id][id][Air_Status] = 1;
	AirBomb[session_id][id][Air_VirtualWorld] = virtualworld;
	AirBomb[session_id][id][Air_Interior] = interior;
	AirBomb[session_id][id][Air_PosX] = x;
	AirBomb[session_id][id][Air_PosY] = y;
	AirBomb[session_id][id][Air_PosZ] = z;

	new
		Float:r = GetAirRandomPos();

	AirBomb[session_id][id][Air_ObjectAir] = CreateDynamicObject(10757, x - 1300.00000, y, z + 123.00000 + r, 10.00000, 10.00000, 90.00000, virtualworld, interior);
	MoveDynamicObject(AirBomb[session_id][id][Air_ObjectAir], x + 5000.00000, y, z + 123.00000 + r, 60.0, 10.00000, 10.00000, 90.00000);
	Streamer_UP(MODE_TDM, session_id);

	AllAirsBomb[session_id]++;
	return 1;
}

static ResetAirBomb(session_id, cell)
{
	if(cell == -1) {
		n_for(i, MAX_AIR_BOMB) {
			AirBomb[session_id][i][Air_Status] =
			AirBomb[session_id][i][Air_Timer] = 0;
			AirBomb[session_id][i][Air_PosX] =
			AirBomb[session_id][i][Air_PosY] =
			AirBomb[session_id][i][Air_PosZ] = 0.0;
			AirBomb[session_id][i][Air_VirtualWorld] =
			AirBomb[session_id][i][Air_Interior] = 0;
			AirBomb[session_id][i][Air_ObjectAir] =
			AirBomb[session_id][i][Air_ObjectBomb] = INVALID_DYNAMIC_OBJECT_ID;

			AllAirBomb[session_id][i] = -1;
		}
		AllAirsBomb[session_id] = 0;
		AirBombNextPriority[session_id] = 0;
	}
	else {
		AirBomb[session_id][cell][Air_Status] =
		AirBomb[session_id][cell][Air_Timer] = 0;
		AirBomb[session_id][cell][Air_PosX] =
		AirBomb[session_id][cell][Air_PosY] =
		AirBomb[session_id][cell][Air_PosZ] = 0.0;
		AirBomb[session_id][cell][Air_VirtualWorld] =
		AirBomb[session_id][cell][Air_Interior] = 0;
		AirBomb[session_id][cell][Air_ObjectAir] =
		AirBomb[session_id][cell][Air_ObjectBomb] = INVALID_DYNAMIC_OBJECT_ID;
	}
	return 1;
}

stock SetAirWeapon(session_id, id, Float:x, Float:y, Float:z, virtualworld, interior) 
{
	n_for(i, MAX_AIR_WEAPON) {
		if(AllAirWeapon[session_id][i] > -1) 
			continue;

		AllAirWeapon[session_id][i] = id;
		break;
	}

	AirWeapon[session_id][id][Air_Status] = 1;
	AirWeapon[session_id][id][Air_Action] = false;
	AirWeapon[session_id][id][Air_Timer] = 0;
	AirWeapon[session_id][id][Air_VirtualWorld] = virtualworld;
	AirWeapon[session_id][id][Air_Interior] = interior;
	AirWeapon[session_id][id][Air_PosX] = x;
	AirWeapon[session_id][id][Air_PosY] = y;
	AirWeapon[session_id][id][Air_PosZ] = z;
	SetRandomAirWeaponAmmo(session_id, id);

	new
		Float:r = GetAirRandomPos();

	AirWeapon[session_id][id][Air_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirWeapon[session_id][id][Air_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirWeapon[session_id][id][Air_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 50.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirWeapon[session_id][id][Air_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 50.0, 0.00000, 0.00000, 0.00000);
	Streamer_UP(MODE_TDM, session_id);

	AllAirsWeapon[session_id]++;
	return 1;
}

static ResetAirWeapon(session_id, cell)
{
	if(cell == -1) {
		n_for(i, MAX_AIR_WEAPON) {
			AirWeapon[session_id][i][Air_Action] = false;
			AirWeapon[session_id][i][Air_Status] =
			AirWeapon[session_id][i][Air_Timer] =
			AirWeapon[session_id][i][Air_VirtualWorld] =
			AirWeapon[session_id][i][Air_Interior] = 0;
			AirWeapon[session_id][i][Air_PosX] =
			AirWeapon[session_id][i][Air_PosY] =
			AirWeapon[session_id][i][Air_PosZ] = 0.0;

			n_for2(w, TDM_AIR_MAX_WEAPON) {
				AirWeapon[session_id][i][Air_Weapon][w] =
				AirWeapon[session_id][i][Air_WeaponAmmo][w] = 0;
			}

			AirWeapon[session_id][i][Air_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
			AirWeapon[session_id][i][Air_ObjectParachute] =
			AirWeapon[session_id][i][Air_ObjectBox] =
			AirWeapon[session_id][i][Air_ObjectAir] = INVALID_DYNAMIC_OBJECT_ID;

			AllAirWeapon[session_id][i] = -1;
		}
		AllAirsWeapon[session_id] = 0;
		AirWeaponNextPriority[session_id] = 0;
	}
	else {
		AirWeapon[session_id][cell][Air_Action] = false;
		AirWeapon[session_id][cell][Air_Status] =
		AirWeapon[session_id][cell][Air_Timer] =
		AirWeapon[session_id][cell][Air_VirtualWorld] =
		AirWeapon[session_id][cell][Air_Interior] = 0;
		AirWeapon[session_id][cell][Air_PosX] =
		AirWeapon[session_id][cell][Air_PosY] =
		AirWeapon[session_id][cell][Air_PosZ] = 0.0;

		n_for(w, TDM_AIR_MAX_WEAPON) {
			AirWeapon[session_id][cell][Air_Weapon][w] =
			AirWeapon[session_id][cell][Air_WeaponAmmo][w] = 0;
		}

		AirWeapon[session_id][cell][Air_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		AirWeapon[session_id][cell][Air_ObjectParachute] =
		AirWeapon[session_id][cell][Air_ObjectBox] =
		AirWeapon[session_id][cell][Air_ObjectAir] = INVALID_DYNAMIC_OBJECT_ID;
	}
	return 1;
}

stock Create3DTextAirWeapon(session_id, id, Float:x, Float:y, Float:z)
{
	new
		string[500],
		namebox[50],
		text[50],
		text2[50],
		text3[50];

	namebox = "Контейнер с оружием";
	text = "Вызвал:";
	text2 = "Неизвестно";
	text3 = "Нажмите";

	f(string, ""TDM_AIR_COLOR_NAME_WEAPON"%s\n\n{FFFFFF}%s {CCCCCC}%s\n\n{D42C21}%s {E5D110}[ ALT ]", namebox, text, text2, text3);
	AirWeapon[session_id][id][Air_3DText] = CreateDynamic3DTextLabel(string, -1, x, y, z, 11.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, AirWeapon[session_id][id][Air_VirtualWorld], AirWeapon[session_id][id][Air_Interior]);
	return 1;
}

static SetRandomAirWeaponAmmo(session_id, id)
{
	new
		r1 = random(2);

	switch(r1) {
		case 0: {
			AirWeapon[session_id][id][Air_Weapon][0] = 30;
			AirWeapon[session_id][id][Air_WeaponAmmo][0] = 40;
		}
		case 1: {
			AirWeapon[session_id][id][Air_Weapon][0] = 31;
			AirWeapon[session_id][id][Air_WeaponAmmo][0] = 30;
		}
	}

	new
		r2 = random(2);

	switch(r2) {
		case 0: {
			AirWeapon[session_id][id][Air_Weapon][1] = 33;
			AirWeapon[session_id][id][Air_WeaponAmmo][1] = 10;
		}
		case 1: {
			AirWeapon[session_id][id][Air_Weapon][1] = 23;
			AirWeapon[session_id][id][Air_WeaponAmmo][1] = 20;
		}
	}

	new
		r3 = random(2);

	switch(r3) {
		case 0: {
			AirWeapon[session_id][id][Air_Weapon][2] = 29;
			AirWeapon[session_id][id][Air_WeaponAmmo][2] = 40;
		}
		case 1: {
			AirWeapon[session_id][id][Air_Weapon][2] = 27;
			AirWeapon[session_id][id][Air_WeaponAmmo][2] = 15;
		}
	}

	new
		r4 = random(2);

	switch(r4) {
		case 0: {
			AirWeapon[session_id][id][Air_Weapon][3] = 17;
			AirWeapon[session_id][id][Air_WeaponAmmo][3] = 5;
		}
		case 1: {
			AirWeapon[session_id][id][Air_Weapon][3] = 16;
			AirWeapon[session_id][id][Air_WeaponAmmo][3] = 3;
		}
	}
	return 1;
}

stock TDM_SetWeaponAirNextPriority(session_id, num)
{
	if(num > 0)
		AirWeaponNextPriority[session_id] += num;
	else
		AirWeaponNextPriority[session_id] = 0;

	return 1;
}

stock TDM_GetWeaponAirBextPriority(session_id)
{
	return AirWeaponNextPriority[session_id];
}

stock TDM_SetBombAirNextPriority(session_id, num)
{
	if(num > 0)
		AirBombNextPriority[session_id] += num;
	else
		AirBombNextPriority[session_id] = 0;

	return 1;
}

stock TDM_GetBombAirBextPriority(session_id)
{
	return AirBombNextPriority[session_id];
}

stock TDM_SetBombAirs(session_id)
{
	TDM_SetBombAirNextPriority(session_id, 1);

	switch(Mode_GetLocation(MODE_TDM, session_id)) {
		case TDM_LOC_DESERT: TDM_Desert_AirBombTimer(session_id);
	}
	return 1;
}

stock TDM_SetWeaponAirs(session_id)
{
	TDM_SetWeaponAirNextPriority(session_id, 1);

	switch(Mode_GetLocation(MODE_TDM, session_id)) {
		case TDM_LOC_DESERT: TDM_Desert_AirWeaponTimer(session_id);
		case TDM_LOC_AIRPORT: TDM_Airport_AirWeaponTimer(session_id);
	}
	return 1;
}

stock TDM_IsValidAirWeapon(session_id, air_id)
{
	if(AirWeapon[session_id][air_id][Air_Status] == 0)
		return 0;

	return 1;
}

stock TDM_IsValidAirBomb(session_id, air_id)
{
	if(AirBomb[session_id][air_id][Air_Status] == 0)
		return 0;

	return 1;
}

stock TDM_SetAirDropWeapon(session_id, bool:type)
{
	ActiveAirDropWeapon[session_id] = type;
	return 1;
}

stock TDM_GetAirDropWeapon(session_id)
{
	return ActiveAirDropWeapon[session_id];
}

stock TDM_SetAirBomb(session_id, bool:type)
{
	ActiveAirBomb[session_id] = type;
	return 1;
}

stock TDM_GetAirBomb(session_id)
{
	return ActiveAirBomb[session_id];
}

// Air Fast point

static SetAirFastPoint(session_id, Float:x, Float:y, Float:z, virtualworld, interior)
{
	AirFastPoint[session_id][Air_Status] = 1;
	AirFastPoint[session_id][Air_VirtualWorld] = virtualworld;
	AirFastPoint[session_id][Air_Interior] = interior;
	AirFastPoint[session_id][Air_PosX] = x;
	AirFastPoint[session_id][Air_PosY] = y;
	AirFastPoint[session_id][Air_PosZ] = z;

	new 
		Float:r = GetAirRandomPos();

	AirFastPoint[session_id][Air_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirFastPoint[session_id][Air_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirFastPoint[session_id][Air_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 70.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirFastPoint[session_id][Air_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 70.0, 0.00000, 0.00000, 0.00000);
	Streamer_UP(MODE_TDM, session_id);
	return 1;
}

static DestroyAirFastPoint(session_id)
{
	m_for(MODE_TDM, session_id, p)
		CreateExplosionForPlayer(p, AirFastPoint[session_id][Air_PosX], AirFastPoint[session_id][Air_PosY], AirFastPoint[session_id][Air_PosZ], 13, 1.0);

	switch(AirFastPoint[session_id][Air_Status]) {
		case 1, 2: {
			DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectBox]);
			DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectAir]);
		}
		case 3: {
			DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectBox]);
			DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectAir]);
			DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectParachute]);
		}
		case 4: {
			DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectBox]);
			DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectAir]);
		}
		case 5: {
			DestroyDynamicObject(AirFastPoint[session_id][Air_ObjectBox]);
		}
	}

	ResetAirFastPoint(session_id);
	return 1;
}

static ResetAirFastPoint(session_id)
{
	AirFastPoint[session_id][Air_Status] =
	AirFastPoint[session_id][Air_Timer] =
	AirFastPoint[session_id][Air_VirtualWorld] =
	AirFastPoint[session_id][Air_Interior] = 0;
	AirFastPoint[session_id][Air_PosX] =
	AirFastPoint[session_id][Air_PosY] =
	AirFastPoint[session_id][Air_PosZ] = 0.0;

	AirFastPoint[session_id][Air_ObjectBox] =
	AirFastPoint[session_id][Air_ObjectAir] =
	AirFastPoint[session_id][Air_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
	return 1;
}

// Player AirDrop ID

stock TDM_SetPlayerIDAirdrop(playerid, air_id)
{
	TDM_PlayerIDAirWeapon[playerid] = air_id;
	return 1;
}

stock TDM_GetPlayerIDAirdrop(playerid)
{
	return TDM_PlayerIDAirWeapon[playerid];
}

/*
	Camera end match
*/

stock TDM_ShowCameraEndLocation(playerid, type)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	if(type) {
		InterpolateCameraPos(playerid, CameraEndLocationPos[session_id][0][0], CameraEndLocationPos[session_id][0][1], CameraEndLocationPos[session_id][0][2], CameraEndLocationPos[session_id][1][0], CameraEndLocationPos[session_id][1][1], CameraEndLocationPos[session_id][1][2], 7000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPos[session_id][2][0], CameraEndLocationPos[session_id][2][1], CameraEndLocationPos[session_id][2][2], CameraEndLocationPos[session_id][3][0], CameraEndLocationPos[session_id][3][1], CameraEndLocationPos[session_id][3][2], 7000);
	}
	else {
		InterpolateCameraPos(playerid, CameraEndLocationPos[session_id][1][0], CameraEndLocationPos[session_id][1][1], CameraEndLocationPos[session_id][1][2], CameraEndLocationPos[session_id][1][0], CameraEndLocationPos[session_id][1][1], CameraEndLocationPos[session_id][1][2], 1000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPos[session_id][3][0], CameraEndLocationPos[session_id][3][1], CameraEndLocationPos[session_id][3][2], CameraEndLocationPos[session_id][3][0], CameraEndLocationPos[session_id][3][1], CameraEndLocationPos[session_id][3][2], 1000);
	}
	return 1;
}

stock TDM_ShowCameraEndLocationTwo(playerid, type)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	if(type) {
		InterpolateCameraPos(playerid, CameraEndLocationPos[session_id][0][0], CameraEndLocationPos[session_id][0][1], CameraEndLocationPos[session_id][0][2], CameraEndLocationPosTwo[session_id][0][0], CameraEndLocationPosTwo[session_id][0][1], CameraEndLocationPosTwo[session_id][0][2], 2000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPos[session_id][2][0], CameraEndLocationPos[session_id][2][1], CameraEndLocationPos[session_id][2][2], CameraEndLocationPosTwo[session_id][1][0], CameraEndLocationPosTwo[session_id][1][1], CameraEndLocationPosTwo[session_id][1][2], 2000);
	}
	else {
		InterpolateCameraPos(playerid, CameraEndLocationPosTwo[session_id][0][0], CameraEndLocationPosTwo[session_id][0][1], CameraEndLocationPosTwo[session_id][0][2], CameraEndLocationPosTwo[session_id][0][0], CameraEndLocationPosTwo[session_id][0][1], CameraEndLocationPosTwo[session_id][0][2], 1000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPosTwo[session_id][1][0], CameraEndLocationPosTwo[session_id][1][1], CameraEndLocationPosTwo[session_id][1][2], CameraEndLocationPosTwo[session_id][1][0], CameraEndLocationPosTwo[session_id][1][1], CameraEndLocationPosTwo[session_id][1][2], 1000);
	}
	return 1;
}

stock TDM_ShowCameraEndLocationThree(playerid, type)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	if(type) {
		InterpolateCameraPos(playerid, CameraEndLocationPosTwo[session_id][0][0], CameraEndLocationPosTwo[session_id][0][1], CameraEndLocationPosTwo[session_id][0][2], CameraEndLocationPos[session_id][1][0], CameraEndLocationPos[session_id][1][1], CameraEndLocationPos[session_id][1][2], 2000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPosTwo[session_id][1][0], CameraEndLocationPosTwo[session_id][1][1], CameraEndLocationPosTwo[session_id][1][2], CameraEndLocationPos[session_id][3][0], CameraEndLocationPos[session_id][3][1], CameraEndLocationPos[session_id][3][2], 2000);
	}
	else {
		InterpolateCameraPos(playerid, CameraEndLocationPos[session_id][1][0], CameraEndLocationPos[session_id][1][1], CameraEndLocationPos[session_id][1][2], CameraEndLocationPos[session_id][1][0], CameraEndLocationPos[session_id][1][1], CameraEndLocationPos[session_id][1][2], 1000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPos[session_id][3][0], CameraEndLocationPos[session_id][3][1], CameraEndLocationPos[session_id][3][2], CameraEndLocationPos[session_id][3][0], CameraEndLocationPos[session_id][3][1], CameraEndLocationPos[session_id][3][2], 1000);
	}
	return 1;
}

stock TDM_SetCameraEndPos(session_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraPos от и до
	CameraEndLocationPos[session_id][0][0] = X;
	CameraEndLocationPos[session_id][0][1] = Y;
	CameraEndLocationPos[session_id][0][2] = Z;

	CameraEndLocationPos[session_id][2][0] = X2;
	CameraEndLocationPos[session_id][2][1] = Y2;
	CameraEndLocationPos[session_id][2][2] = Z2;
	return 1;
}

stock TDM_SetCameraEndLookAt(session_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraLookAt от и до
	CameraEndLocationPos[session_id][1][0] = X;
	CameraEndLocationPos[session_id][1][1] = Y;
	CameraEndLocationPos[session_id][1][2] = Z;

	CameraEndLocationPos[session_id][3][0] = X2;
	CameraEndLocationPos[session_id][3][1] = Y2;
	CameraEndLocationPos[session_id][3][2] = Z2;
	return 1;
}

stock TDM_SetCameraEndPosTwo(session_id, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraPos
	CameraEndLocationPosTwo[session_id][0][0] = X;
	CameraEndLocationPosTwo[session_id][0][1] = Y;
	CameraEndLocationPosTwo[session_id][0][2] = Z;

	// InterpolateCameraLookAt
	CameraEndLocationPosTwo[session_id][1][0] = X2;
	CameraEndLocationPosTwo[session_id][1][1] = Y2;
	CameraEndLocationPosTwo[session_id][1][2] = Z2;
	return 1;
}

stock TDM_ResetCameraEndPos(session_id)
{
	n_for(i, sizeof(CameraEndLocationPos[])) {
		CameraEndLocationPos[session_id][i][0] =
		CameraEndLocationPos[session_id][i][1] =
		CameraEndLocationPos[session_id][i][2] = 0.0;
	}
	n_for(i, sizeof(CameraEndLocationPosTwo[])) {
		CameraEndLocationPosTwo[session_id][i][0] =
		CameraEndLocationPosTwo[session_id][i][1] =
		CameraEndLocationPosTwo[session_id][i][2] = 0.0;
	}
	return 1;
}

/*
	Camera base team
*/

stock TDM_SetPlayerBaseCamera(playerid, team_id)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	InterpolateCameraPos(playerid, CameraBasePos[session_id][team_id][0][0], CameraBasePos[session_id][team_id][0][1], CameraBasePos[session_id][team_id][0][2], CameraBasePos[session_id][team_id][0][0], CameraBasePos[session_id][team_id][0][1], CameraBasePos[session_id][team_id][0][2], 1000);
	InterpolateCameraLookAt(playerid, CameraBasePos[session_id][team_id][1][0], CameraBasePos[session_id][team_id][1][1], CameraBasePos[session_id][team_id][1][2], CameraBasePos[session_id][team_id][1][0], CameraBasePos[session_id][team_id][1][1], CameraBasePos[session_id][team_id][1][2], 1000);
	return 1;
}

/*
	Camera capture point
*/

stock TDM_SetPlayerPointCamera(playerid, point_id)
{
	new
		session_id = Mode_GetPlayerSession(playerid);
	
	InterpolateCameraPos(playerid, CameraPointPos[session_id][point_id][0][0], CameraPointPos[session_id][point_id][0][1], CameraPointPos[session_id][point_id][0][2], CameraPointPos[session_id][point_id][0][0], CameraPointPos[session_id][point_id][0][1], CameraPointPos[session_id][point_id][0][2], 1000);
	InterpolateCameraLookAt(playerid, CameraPointPos[session_id][point_id][1][0], CameraPointPos[session_id][point_id][1][1], CameraPointPos[session_id][point_id][1][2], CameraPointPos[session_id][point_id][1][0], CameraPointPos[session_id][point_id][1][1], CameraPointPos[session_id][point_id][1][2], 1000);
	return 1;
}

stock TDM_CreateElementsLocation(session_id) 
{
	// Локации
	switch(Mode_GetLocation(MODE_TDM, session_id)) {
		// Пустыня
		case TDM_LOC_DESERT: TDM_Desert_CreateElements(session_id);
		// Пустыня 2
		case TDM_LOC_DESERT2: TDM_Desert2_CreateElements(session_id);
		// Аэропорт
		case TDM_LOC_AIRPORT: TDM_Airport_CreateElements(session_id);
		// Аэропорт 2
		case TDM_LOC_AIRPORT2: TDM_Airport2_CreateElements(session_id);
		// Стадион
		case TDM_LOC_STADIUM: TDM_Stadium_CreateElements(session_id);
		// Городок
		case TDM_LOC_VILLAGE: TDM_Village_CreateElements(session_id);
		// Гольф
		case TDM_LOC_GOLF: TDM_Golf_CreateElements(session_id);
		// Зона 51
		case TDM_LOC_ZONE51: TDM_Zone51_CreateElements(session_id);
		// Пример (4 команды игроков)
		case TDM_LOC_EXAMPLE: TDM_Example_CreateElements(session_id);
	}
	return 1;
}

stock TDM_DestroyElementsLocation(session_id)
{
	// Базы
	TDM_DestroyBaseTeam(session_id, -1);

	switch(Mode_GetMode(MODE_TDM, session_id)) {
		// Точки
		case TDM_MODE_CAPTURE: TDM_DestroyCapturePoint(session_id, -1);
		// Компьютеры
		case TDM_MODE_SECRET_DATA: TDM_DestroyComputer(session_id, -1);
		// Флаги
		case TDM_MODE_CAPTURE_FLAG: TDM_DestroyCaptureFlag(session_id, -1);
	}

	// Зона
	if(TDM_GetExitZone(session_id))
		TDM_DestroyExitZone(session_id);

	// Мешки с деньгами
	if(TDM_GetBagMoney(session_id))
		TDM_DestroyBagMoney(session_id, -1);

	// Магазины
	if(TDM_GetShops(session_id))
		TDM_DestroyShop(session_id, -1);

	// Транспорт
	if(TDM_GetVehicle(session_id))
		TDM_DestroyVehicle(session_id, -1);

	// Самолёты
	DeleteAllAir(session_id);

	if(TDM_GetAirDropWeapon(session_id))
		TDM_SetAirDropWeapon(session_id, false);

	if(TDM_GetAirBomb(session_id))
		TDM_SetAirBomb(session_id, false);

	// Время
	TDM_ResetTimer(session_id);

	// Счёт
	TDM_ResetTeamsChet(session_id);

	// Временная точка
	TDM_DestroyFastPoint(session_id, -1);

	// Камера в конце матча
	TDM_ResetCameraEndPos(session_id);

	// Команды
	TDM_RemoveTeam(session_id, -1);

	// Погода
	Mode_SetWeather(MODE_TDM, session_id, 0);

	// Виртуальный мир и интерьер
	Mode_SetVirtualWorld(MODE_TDM, session_id, Mode_GetBasicVirtualWorld(MODE_TDM, session_id));
	Mode_SetInterior(MODE_TDM, session_id, Mode_GetBasicInterior(MODE_TDM, session_id));
	return 1;
}

stock TDM_ShowPlayerElementsLocation(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	// Базы
	foreach(new g:TDM_ActiveTeams[session_id])
		GangZoneShowForPlayer(playerid, TDM_BaseTeam[session_id][g][BT_GangZone], TDM_ShowTeamColorXB(TDM_BaseTeam[session_id][g][BT_Color]));

	// Таймер
	if(TDM_GetActiveTimer(session_id))
		Mode_CreatePlTDTimerSession(playerid);

	// Счёт
	if(TDM_GetTeamsChet(session_id))
		TDM_ShowPlayerTDTeamsChet(playerid);

	// Точки
	if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE) {
		foreach(new g:TDM_CapturePointCount[session_id]) {
			GangZoneShowForPlayer(playerid, TDM_CapturePoint[session_id][g][CP_GangZone], TDM_ShowTeamColorXB(TDM_CapturePoint[session_id][g][CP_Color]));
		}
	}
	return 1;
}

stock TDM_HidePlayerElementsLocation(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	// Базы
	foreach(new i:TDM_ActiveTeams[session_id])
		GangZoneHideForPlayer(playerid, TDM_BaseTeam[session_id][i][BT_GangZone]);

	// Таймер
	if(TDM_GetActiveTimer(session_id)) 
		Mode_DestroyPlTDTimerSession(playerid);

	// Счёт
	if(TDM_GetTeamsChet(session_id))
		TDM_DestroyPlayerTDTeamsChet(playerid);

	// Точки
	if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE) {
		DestroyPlayerPointCapture(playerid);
		foreach(new g:TDM_CapturePointCount[session_id]) {
			GangZoneHideForPlayer(playerid, TDM_CapturePoint[session_id][g][CP_GangZone]);
		}
	}

	// Компьютеры
	if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_SECRET_DATA) {
		DestroyPlayerComputer(playerid);
	}

	// Захват флага
	if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE_FLAG) {
		SpawnCaptureFlag(playerid, 0);
	}
	return 1;
}

stock TDM_CreateElementEnterArea(playerid)
{
	new
		session_id = Mode_GetPlayerSession(playerid);

	if(TDM_GetStatusGame(session_id) != TDM_LOC_GAME_STATUS_GAME)
		return 0;

	if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE) {
		new 
			point_id = -1;

		TDM_GetGangZonePlayer(playerid, point_id);

		if(point_id > -1)
			CreatePlayerPointCapture(playerid, point_id);
	}
	if(TDM_GetExitZone(session_id)) {
		if(IsPlayerInDynamicArea(playerid, AreaExitZone[session_id])) {
			if(GetPlayerExitZone(playerid)) 
				HidePlayerExitZone(playerid);
		}
		else 
			ShowPlayerExitZone(playerid);
	}
	if(TDM_GetFastPoint(session_id))
		CreatePlayerFastPointArea(session_id, playerid);

	return 1;
}

stock TDM_PointReInfo(session_id) 
{
	foreach(new g:TDM_CapturePointCount[session_id]) {
		new
			team[TDM_MAX_TEAMS];

		foreach(new tt:TDM_ActiveTeams[session_id]) {
			m_for(MODE_TDM, session_id, p) {
				if(GetPlayerSpectating(p) > -1) 
					continue;

				if(TDM_CapturePoint[session_id][g][CP_VirtualWorld] != GetPlayerVirtualWorldEx(p)) 
					continue;

				if(TDM_CapturePoint[session_id][g][CP_Interior] != GetPlayerInteriorEx(p)) 
					continue;

				if(GangZonePlayerCapture[p] != g) 
					continue;

				if(GetPlayerTeamEx(p) == tt) 
					team[tt]++;
			}
		}

		new
			most_players,
			win_team = -1,
			worse_team = -1,
			bool:draw;

		foreach(new tt:TDM_ActiveTeams[session_id]) {
			if(tt == TDM_TEAM_NONE)
				continue;

			if(team[tt] > NONE) {
				if(team[tt] >= most_players) {
					if(draw == true) 
						draw = false;

					if(team[tt] == most_players) {
						if(win_team != -1)
						    draw = true;
					}

					most_players = team[tt];
					win_team = tt;
				}
				else
					worse_team = tt;
			}
		}

		if(most_players == NONE) {
			if(TDM_CapturePoint[session_id][g][CP_Color] != TDM_TEAM_NONE) {
				if(TDM_CapturePoint[session_id][g][CP_Chet] < TDM_MAX_CHET_CAPTURE) {
					TDM_CapturePoint[session_id][g][CP_Chet]++;
					MovePointFlag(session_id, g, 1);
				}
			}
			else {
				if(TDM_CapturePoint[session_id][g][CP_Chet] > 0) {
					TDM_CapturePoint[session_id][g][CP_Chet]--;
					MovePointFlag(session_id, g, 2);
				}
				else {
					TDM_CapturePoint[session_id][g][CP_Color] = TDM_TEAM_NONE;
					TDM_CapturePoint[session_id][g][CP_Property] = TDM_TEAM_NONE;
					SetPointFlagPos(session_id, g, 1);
					ChangeColorPointFlag(session_id, g, TDM_TEAM_NONE);
					TDM_ChangePointCameraForPlayer(session_id, g);
				}
			}

			if(TDM_CapturePoint[session_id][g][CP_Red]) {
				TDM_CapturePoint[session_id][g][CP_Red] = false;
				TDM_CapturePoint[session_id][g][CP_CaptureTeam] = TDM_TEAM_NONE;
				m_for(MODE_TDM, session_id, p)
					GangZoneStopFlashForPlayer(p, TDM_CapturePoint[session_id][g][CP_GangZone]);
			}
		}
		else {
			if(draw) {
				foreach(new tt:TDM_ActiveTeams[session_id]) {
					if(team[tt] == most_players) {
						if(tt != TDM_CapturePoint[session_id][g][CP_Color]) {
							m_for(MODE_TDM, session_id, p)
								GangZoneFlashForPlayer(p, TDM_CapturePoint[session_id][g][CP_GangZone], TDM_ShowTeamColorXB(tt));

							TDM_CapturePoint[session_id][g][CP_Red] = true;
							TDM_CapturePoint[session_id][g][CP_CaptureTeam] = tt;
							break;
						}
					}
				}
			}
			else {
				if(worse_team != -1) {
					if(worse_team != TDM_CapturePoint[session_id][g][CP_Color]) {
						if(win_team == TDM_CapturePoint[session_id][g][CP_Color]) {
							m_for(MODE_TDM, session_id, p)
								GangZoneFlashForPlayer(p, TDM_CapturePoint[session_id][g][CP_GangZone], TDM_ShowTeamColorXB(worse_team));

							TDM_CapturePoint[session_id][g][CP_Red] = true;
						}
					}
				}
				if(win_team != -1) {
					if(win_team != TDM_CapturePoint[session_id][g][CP_Color]) {
						m_for(MODE_TDM, session_id, p)
							GangZoneFlashForPlayer(p, TDM_CapturePoint[session_id][g][CP_GangZone], TDM_ShowTeamColorXB(win_team));

						TDM_CapturePoint[session_id][g][CP_Red] = true;
						TDM_CapturePoint[session_id][g][CP_CaptureTeam] = win_team;

						if(TDM_CapturePoint[session_id][g][CP_Property] != win_team) {
							if(TDM_CapturePoint[session_id][g][CP_Chet] > 0) {
								if(team[win_team] > 1) {
									TDM_CapturePoint[session_id][g][CP_Chet] -= 2;
									MovePointFlag(session_id, g, 2, true);
								}
								else { 
									TDM_CapturePoint[session_id][g][CP_Chet]--;
									MovePointFlag(session_id, g, 2);
								}
							}
							if(TDM_CapturePoint[session_id][g][CP_Chet] <= 0) {
								if(TDM_CapturePoint[session_id][g][CP_Color] != TDM_TEAM_NONE) {
									m_for(MODE_TDM, session_id, p) {
										GangZoneShowForPlayer(p, TDM_CapturePoint[session_id][g][CP_GangZone], TDM_ShowTeamColorXB(TDM_TEAM_NONE));

										if(GetPlayerSpectating(p) > -1)
											continue;

										if(GangZonePlayerCapture[p] != g)
											continue;

										if(GetPlayerTeamEx(p) != win_team) 
											continue;

										SetPlayerFee(p, 150, 50, REPLEN_CAPTURE);
										PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);
									}
								}

								TDM_CapturePoint[session_id][g][CP_Chet] = 0;
								TDM_CapturePoint[session_id][g][CP_Color] = TDM_TEAM_NONE;
								TDM_CapturePoint[session_id][g][CP_Property] = win_team;

								SetPointFlagPos(session_id, g, 1);
								ChangeColorPointFlag(session_id, g, win_team);
								TDM_ChangePointCameraForPlayer(session_id, g);
							}
						}
						else {
							if(TDM_CapturePoint[session_id][g][CP_Chet] < TDM_MAX_CHET_CAPTURE) {
								if(team[win_team] > 1) {
									TDM_CapturePoint[session_id][g][CP_Chet] += 2;
									MovePointFlag(session_id, g, 1, true);
								}
								else { 
									TDM_CapturePoint[session_id][g][CP_Chet]++;
									MovePointFlag(session_id, g, 1);
								}
					
								if(TDM_CapturePoint[session_id][g][CP_Chet] >= TDM_MAX_CHET_CAPTURE) {
									TDM_CapturePoint[session_id][g][CP_Red] = false;
									TDM_CapturePoint[session_id][g][CP_Color] = win_team;
									TDM_CapturePoint[session_id][g][CP_CaptureTeam] = TDM_TEAM_NONE;
									TDM_CapturePoint[session_id][g][CP_Chet] = TDM_MAX_CHET_CAPTURE;

									SetPointFlagPos(session_id, g, 2);
									ChangeColorPointFlag(session_id, g, win_team);
									TDM_ChangePointCameraForPlayer(session_id, g);

									m_for(MODE_TDM, session_id, p) {
										GangZoneStopFlashForPlayer(p, TDM_CapturePoint[session_id][g][CP_GangZone]);
										GangZoneShowForPlayer(p, TDM_CapturePoint[session_id][g][CP_GangZone], TDM_ShowTeamColorXB(win_team));

										if(GetPlayerSpectating(p) > -1)
											continue;

										if(GangZonePlayerCapture[p] != g)
											continue;

										if(GetPlayerTeamEx(p) != win_team)
											continue;

										SetPlayerFee(p, 400, 250, REPLEN_CAPTURE);
										PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);

										// Квесты
										Quest_CheckPlayerProgress(p, MODE_TDM, 1);
										Quest_CheckPlayerProgress(p, MODE_TDM, 10);
										Quest_CheckPlayerProgress(p, MODE_TDM, 29);
										//

										Dina_CheckPlayerHint(p, 13);
									}
								}
							}
						}
					}
					else {
						if(TDM_CapturePoint[session_id][g][CP_Chet] < TDM_MAX_CHET_CAPTURE) {
							TDM_CapturePoint[session_id][g][CP_Chet]++;
							MovePointFlag(session_id, g, 1);
						}
						if(worse_team == -1) {
							if(TDM_CapturePoint[session_id][g][CP_Red]) {
								TDM_CapturePoint[session_id][g][CP_Red] = false;
								TDM_CapturePoint[session_id][g][CP_CaptureTeam] = TDM_TEAM_NONE;
								m_for(MODE_TDM, session_id, p) {
									GangZoneStopFlashForPlayer(p, TDM_CapturePoint[session_id][g][CP_GangZone]);
								}
							}
						}
					}
				}
			}
		}
		new
			str[100];

		if(!TDM_CapturePoint[session_id][g][CP_Red])
			f(str, "%s[%s] [ %s ]", TDM_ShowTeamColor(TDM_CapturePoint[session_id][g][CP_Color]), GetNamePoint(g), TDM_CapturePoint[session_id][g][CP_Name]);
		else
			f(str, "%s[%s] [ %s ]\n\n{D53032}Захватывают %s%s", TDM_ShowTeamColor(TDM_CapturePoint[session_id][g][CP_Color]), GetNamePoint(g), TDM_CapturePoint[session_id][g][CP_Name], TDM_ShowTeamColor(TDM_CapturePoint[session_id][g][CP_CaptureTeam]), TDM_GetTeamName(TDM_CapturePoint[session_id][g][CP_CaptureTeam]));

		UpdateDynamic3DTextLabelText(TDM_CapturePoint[session_id][g][CP_3DText], 0x000000FF, str);

		m_for(MODE_TDM, session_id, p) {
			if(GangZonePlayerCapture[p] == g) {
				SetPlayerProgressBarColour(p, GangZoneCaptureBar[p], TDM_ShowTeamColorXB(TDM_CapturePoint[session_id][g][CP_Property]));
				SetPlayerProgressBarValue(p, GangZoneCaptureBar[p], floatround(TDM_CapturePoint[session_id][g][CP_Chet]));
			}
		}
	}
	return 1;
}

stock TDM_ComputerReInfo(session_id)
{
	n_for(tt, TDM_MAX_TEAMS) {
		n_for2(c, TDM_MAX_COMPUTERS) {
			if(!TDM_Computer[session_id][tt][c][COMP_Enabled])
				continue;
	
			new
				team = TDM_Computer[session_id][tt][c][COMP_ProtectTeam];

			if(!TDM_Computer[session_id][team][c][COMP_ActionCapture]) {
				if(TDM_Computer[session_id][team][c][COMP_Status] != TDM_Computer[session_id][team][c][COMP_ProtectTeam]) {
					if(TDM_Computer[session_id][team][c][COMP_Timer] > 0) {
						TDM_Computer[session_id][team][c][COMP_Timer]--;
						if(TDM_Computer[session_id][team][c][COMP_Timer] <= 0) {
							COMP_TeamChet[session_id][team]--;

							new 
								player = TDM_Computer[session_id][team][c][COMP_PlayerID];

							if(player > -1) {
								if(ComputerPlayerCapture[player] == c)
									DestroyPlayerComputer(player);
							}
							TDM_Computer[session_id][team][c][COMP_Timer] = 0;
							TDM_Computer[session_id][team][c][COMP_ActionCapture] = true;
							TDM_Computer[session_id][team][c][COMP_Red] = false;
							TDM_Computer[session_id][team][c][COMP_PlayerID] = -1;

							DestroyDynamicMapIcon(TDM_Computer[session_id][team][c][COMP_MapIcon]);
							if(COMP_TeamChet[session_id][team] < (COMP_TeamMaxChet[session_id][team] - COMP_TeamMaxChet[session_id][team] + 1)) {
								new 
									str1[30];

								f(str1, "Компьютер (%i) взломан!", c + 1);
								TDM_SetTextTeamMatch(session_id, str1, team);
							}
							else if(COMP_TeamChet[session_id][team] == (COMP_TeamMaxChet[session_id][team] - COMP_TeamMaxChet[session_id][team] + 1)) 
								TDM_SetTextTeamMatch(session_id, "Остался последний компьютер!", team);
						}
					}
				}
				new
					string[100];

				if(TDM_Computer[session_id][team][c][COMP_Status] != TDM_Computer[session_id][team][c][COMP_ProtectTeam]) {
					f(string, "[%i] Компьютер взламывается\nВремя: %i\n\n{FFFFFF}[%s%s{FFFFFF}]", c + 1, TDM_Computer[session_id][team][c][COMP_Timer], TDM_ShowTeamColor(team), TDM_GetTeamName(team));
					UpdateDynamic3DTextLabelText(TDM_Computer[session_id][team][c][COMP_3DText], 0xDE2B2BFF, string);
				}
				else {
					f(string, "[%i] Компьютер не взломан\n\n{FFFFFF}[%s%s{FFFFFF}]", c + 1, TDM_ShowTeamColor(team), TDM_GetTeamName(team));
					UpdateDynamic3DTextLabelText(TDM_Computer[session_id][team][c][COMP_3DText], 0x3CDB39FF, string);
				}
			}
			else {
				new
					string[100];

				f(string, "[%i] Компьютер взломан\n\n{FFFFFF}[%s%s{FFFFFF}]", c + 1, TDM_ShowTeamColor(team), TDM_GetTeamName(team));
				UpdateDynamic3DTextLabelText(TDM_Computer[session_id][team][c][COMP_3DText], 0xDE2B2BFF, string);
			}
		}
	}
	return 1;
}

stock TDM_UpdatePlayerComputer(playerid)
{
	if(ComputerPlayerCapture[playerid] == -1)
		return 1;

	new
		session_id = Mode_GetPlayerSession(playerid);

	new
		c = ComputerPlayerCapture[playerid],
		team = ComputerPlayerTeam[playerid];

	if(IsPlayerInRangeOfPoint(playerid, 1.3, PosComputers[session_id][team][c][0], PosComputers[session_id][team][c][1], PosComputers[session_id][team][c][2])) {
		if(GetPlayerTeamEx(playerid) != TDM_Computer[session_id][team][c][COMP_ProtectTeam]) {
			if(TDM_Computer[session_id][team][c][COMP_Chet] < TDM_MAX_CHET_COMPUTER) {
				TDM_Computer[session_id][team][c][COMP_Chet]++;
				SetPlayerProgressBarValue(playerid, ComputerCaptureBar[playerid], floatround(TDM_Computer[session_id][team][c][COMP_Chet]));

				if(TDM_Computer[session_id][team][c][COMP_Chet] >= TDM_MAX_CHET_COMPUTER) {
					DestroyPlayerComputer(playerid);

					TDM_Computer[session_id][team][c][COMP_Chet] = TDM_MAX_CHET_COMPUTER;
					TDM_Computer[session_id][team][c][COMP_Status] = GetPlayerTeamEx(playerid);
					TDM_Computer[session_id][team][c][COMP_Timer] = TDM_MAX_COMPUTER_TIMER;
					TDM_Computer[session_id][team][c][COMP_Red] = false;
					TDM_Computer[session_id][team][c][COMP_PlayerID] = -1;

					SetPlayerFee(playerid, 300, 200, REPLEN_HACK);
					PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

					//Квесты
					Quest_CheckPlayerProgress(playerid, MODE_TDM, 6);
					Quest_CheckPlayerProgress(playerid, MODE_TDM, 16);
					//

					Dina_CheckPlayerHint(playerid, 14);

					m_for(MODE_TDM, session_id, p) {
						if(GetPlayerTeamEx(p) != TDM_Computer[session_id][team][c][COMP_ProtectTeam]) 
							continue;

						new 
							str[150];

						f(str, "{E61414}(Взлом) {FFFFFF}Компьютер {FFFF33}(%i) {FFFFFF}взломали, деактивируйте взлом!", c);
						SCM(p, -1, str);
					}
				}
			}
		}
		else {
			if(TDM_Computer[session_id][team][c][COMP_Chet] > 0) {
				TDM_Computer[session_id][team][c][COMP_Chet]--;
				SetPlayerProgressBarValue(playerid, ComputerCaptureBar[playerid], floatround(TDM_Computer[session_id][team][c][COMP_Chet]));

				if(TDM_Computer[session_id][team][c][COMP_Chet] <= 0) {
					DestroyPlayerComputer(playerid);

					TDM_Computer[session_id][team][c][COMP_Chet] = 0;
					TDM_Computer[session_id][team][c][COMP_Status] = GetPlayerTeamEx(playerid);
					TDM_Computer[session_id][team][c][COMP_Timer] = 0;
					TDM_Computer[session_id][team][c][COMP_Red] = false;
					TDM_Computer[session_id][team][c][COMP_PlayerID] = -1;

					SetPlayerFee(playerid, 300, 200, REPLEN_HACK);
					PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

					//Квесты
					Quest_CheckPlayerProgress(playerid, MODE_TDM, 6);
					Quest_CheckPlayerProgress(playerid, MODE_TDM, 16);
					//

					m_for(MODE_TDM, session_id, p) {
						if(GetPlayerTeamEx(p) == TDM_Computer[session_id][team][c][COMP_ProtectTeam]) 
							continue;

						new 
							str[150];

						f(str, "{E61414}(Взлом) {FFFFFF}Взлом компьютера {FFFF33}(%i) {FFFFFF}деактивировали!", c);
						SCM(p, -1, str);
					}
				}
			}
		}
	}
	else {
		TDM_Computer[session_id][team][c][COMP_Red] = false;
		TDM_Computer[session_id][team][c][COMP_PlayerID] = -1;

		DestroyPlayerComputer(playerid);
	}
	return 1;
}

static ShowTDHackComputer(playerid)
{
	TD_ComputerHack[playerid] = CreatePlayerTextDraw(playerid, 321.000000, 241.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_ComputerHack[playerid], 0.136333, 0.840887);
	PlayerTextDrawAlignment(playerid, TD_ComputerHack[playerid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_ComputerHack[playerid], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_ComputerHack[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TD_ComputerHack[playerid], 0);
	PlayerTextDrawBackgroundColour(playerid, TD_ComputerHack[playerid], 255);
	PlayerTextDrawFont(playerid, TD_ComputerHack[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_ComputerHack[playerid], true);
	return 1;
}

static ShowTDGangZoneCapture(playerid)
{
	TD_GangZone[playerid] = CreatePlayerTextDraw(playerid, 321.0000, 277.0000, "_"); 
	PlayerTextDrawLetterSize(playerid, TD_GangZone[playerid], 0.1576, 1.1022);
	PlayerTextDrawAlignment(playerid, TD_GangZone[playerid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_GangZone[playerid], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_GangZone[playerid], 255);
	PlayerTextDrawFont(playerid, TD_GangZone[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_GangZone[playerid], true);
	PlayerTextDrawSetShadow(playerid, TD_GangZone[playerid], 0);
	return 1;
}

/*
	Additional Elements (AE)
*/

stock TDM_CreateAEElementsLoc(session_id)
{
	new
		location_id = Mode_GetLocation(MODE_TDM, session_id);

	switch(location_id) {
		case TDM_LOC_DESERT: TDM_Desert_CreateAEElements(session_id); // Пустыня
	}
	return 1;
}

stock TDM_DestroyAEElementsLoc(session_id)
{
	new
		location_id = Mode_GetLocation(MODE_TDM, session_id);

	switch(location_id) {
		case TDM_LOC_DESERT: TDM_Desert_DestroyAEElements(session_id); // Пустыня
	}

	TDM_DestroyAEObject(session_id);
	TDM_DestroyAE3DText(session_id);
	TDM_DestroyAEPickupDoor(session_id);
	TDM_DestroyAEOtherPickup(session_id);
	TDM_DestroyAEMapIcon(session_id);
	return 1;
}

stock TDM_SetPlayerKeyPickupDoor(playerid, location_id, pickup_id)
{
	switch(location_id) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlayerKeyDPickup(playerid, pickup_id); // Пустыня
	}

	TDM_SetPlayerPosAEDoor(playerid, pickup_id);
	return 1;
}

stock TDM_SetPlayerKeyOtherPickup(playerid, location_id, pickup_id)
{
	switch(location_id) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlayerKeyOPickup(playerid, pickup_id); // Пустыня
	}
	return 1;
}

stock TDM_SetPlayerKey3DText(playerid, location_id, text_id)
{
	switch(location_id) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlayerKey3DText(playerid, text_id); // Пустыня
	}
	return 1;
}

stock TDM_UpdateAEElement(location_id, session_id)
{
	switch(location_id) {
		case TDM_LOC_DESERT: TDM_Desert_UpdateAEElements(session_id); // Пустыня
	}
	return 1;
}

stock TDM_UpdatePlAEElements(playerid)
{
	switch(Mode_GetLocation(MODE_TDM, Mode_GetPlayerSession(playerid))) {
		case TDM_LOC_DESERT: TDM_Desert_UpdatePlAEElements(playerid);
	}
	return 1;
}

stock TDM_VehicleSetSettings(vehicleid)
{
	switch(Mode_GetLocation(MODE_TDM, Veh_GetSession(vehicleid))) {
		case TDM_LOC_DESERT: TDM_Desert_VehSetSettings(vehicleid);
		case TDM_LOC_DESERT2: TDM_Desert2_VehSetSettings(vehicleid);
		case TDM_LOC_AIRPORT: TDM_Airport_VehSetSettings(vehicleid);
		case TDM_LOC_VILLAGE: TDM_Village_VehSetSettings(vehicleid);
		case TDM_LOC_GOLF: TDM_Golf_VehSetSettings(vehicleid);
	}
	return 1;
}

stock TDM_SetPlKeyAE3DText(playerid, location_id, p_3dtext, text_id)
{
	switch(location_id) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlKeyAd3DText(playerid, p_3dtext, text_id);
	}
	return 1;
}

stock TDM_CheckStartFastPoint(session_id)
{
	if(FastPoint[session_id][FP_Status])
		return 1;

	switch(Mode_GetLocation(MODE_TDM, session_id)) {
		case TDM_LOC_DESERT: TDM_Desert_CheckStartFastPoint(session_id); // Пустыня
	}
	return 1;
}

stock TDM_LocSetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
{
	switch(Mode_GetLocation(MODE_TDM, Mode_GetPlayerSession(playerid))) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlayerMG(playerid, num, timer, count, value, ptime);
	}
	return 1;
}

stock TDM_LocResetPlayerMG(playerid)
{
	switch(Mode_GetLocation(MODE_TDM, Mode_GetPlayerSession(playerid))) {
		case TDM_LOC_DESERT: TDM_Desert_ResetPlayerMG(playerid);
	}
	return 1;
}

stock TDM_LocUpdatePlayerMG(playerid) 
{
	switch(Mode_GetLocation(MODE_TDM, Mode_GetPlayerSession(playerid))) {
		case TDM_LOC_DESERT: TDM_Desert_UpdateMGlayer(playerid);
	}
}

stock TDM_UpdateAir(session_id)
{
	if(AllAirsBomb[session_id] > 0) {
		r_for(ii, AllAirsBomb[session_id]) {
			new
				i = AllAirBomb[session_id][ii];

			switch(AirBomb[session_id][i][Air_Status]) {
				case 1: { // Падение к цели
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirBomb[session_id][i][Air_ObjectAir], ax, ay, az);
					if(ax > (AirBomb[session_id][i][Air_PosX] - 20.0)) {
						AirBomb[session_id][i][Air_Status] = 2;
						AirBomb[session_id][i][Air_ObjectBomb] = CreateDynamicObject(3786, ax, ay, az, 0.00000, -20.00000, 900.00000, AirBomb[session_id][i][Air_VirtualWorld], AirBomb[session_id][i][Air_Interior]);
						MoveDynamicObject(AirBomb[session_id][i][Air_ObjectBomb], AirBomb[session_id][i][Air_PosX], AirBomb[session_id][i][Air_PosY], AirBomb[session_id][i][Air_PosZ] - 3.0, 60.0, 0.00000, -80.00000, 900.00000);
					}
				}
				case 2: { // После падения
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirBomb[session_id][i][Air_ObjectBomb], bx, by, bz);
					if((bx == AirBomb[session_id][i][Air_PosX]) 
					&& (by == AirBomb[session_id][i][Air_PosY])
					&& (bz <= AirBomb[session_id][i][Air_PosZ])) {
						AirBomb[session_id][i][Air_Status] = 3;
						AirBomb[session_id][i][Air_Timer] = gettime() + 30;
						DestroyDynamicObject(AirBomb[session_id][i][Air_ObjectBomb]);

						m_for(MODE_TDM, session_id, p) {
							if(GetPlayerVirtualWorldEx(p) != AirBomb[session_id][i][Air_VirtualWorld]) 
								continue;

							if(GetPlayerInteriorEx(p) != AirBomb[session_id][i][Air_Interior]) 
								continue;

							CreateExplosionForPlayer(p, bx, by, bz, 6, 15.0);
						}
						Streamer_UP(MODE_TDM, session_id);
					}
				}
				case 3: { // Удаление
					if(AirBomb[session_id][i][Air_Timer] < gettime()) {
						DestroyDynamicObject(AirBomb[session_id][i][Air_ObjectAir]);

						ResetAirBomb(session_id, i);

						if(AllAirsBomb[session_id] > 0) 
							AllAirsBomb[session_id]--;

						AllAirBomb[session_id][ii] = AllAirBomb[session_id][AllAirsBomb[session_id]];
						AllAirBomb[session_id][AllAirsBomb[session_id]] = -1;
					}
				}
			}
		}
	}

	if(AllAirsWeapon[session_id] > 0) {
		r_for(ii, AllAirsWeapon[session_id]) {
			new 
				i = AllAirWeapon[session_id][ii];

			switch(AirWeapon[session_id][i][Air_Status]) {
				case 1: { // Отстыковка
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirWeapon[session_id][i][Air_ObjectAir], ax, ay, az);
					if(ay > (AirWeapon[session_id][i][Air_PosY] - 50.0)) {
						AirWeapon[session_id][i][Air_Status] = 2;
						new
							Float:bx,
							Float:by,
							Float:bz;

						GetDynamicObjectPos(AirWeapon[session_id][i][Air_ObjectBox], bx, by, bz);
						StopDynamicObject(AirWeapon[session_id][i][Air_ObjectBox]);
						MoveDynamicObject(AirWeapon[session_id][i][Air_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
					}
				}
				case 2: { // Падение к цели
					AirWeapon[session_id][i][Air_Status] = 3;
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirWeapon[session_id][i][Air_ObjectBox], bx, by, bz);

					AirWeapon[session_id][i][Air_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirWeapon[session_id][i][Air_VirtualWorld], AirWeapon[session_id][i][Air_Interior]);

					StopDynamicObject(AirWeapon[session_id][i][Air_ObjectBox]);
					MoveDynamicObject(AirWeapon[session_id][i][Air_ObjectBox], AirWeapon[session_id][i][Air_PosX] - 0.80000, AirWeapon[session_id][i][Air_PosY], AirWeapon[session_id][i][Air_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
					MoveDynamicObject(AirWeapon[session_id][i][Air_ObjectParachute], AirWeapon[session_id][i][Air_PosX] - 0.80000 + 0.0203, AirWeapon[session_id][i][Air_PosY] - 0.0138, AirWeapon[session_id][i][Air_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
					Streamer_UP(MODE_TDM, session_id);
				}
				case 3: { // Остановка у цели
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirWeapon[session_id][i][Air_ObjectBox], bx, by, bz);
					if((bx == AirWeapon[session_id][i][Air_PosX] - 0.80000) 
					&& (by == AirWeapon[session_id][i][Air_PosY]) 
					&& (bz == AirWeapon[session_id][i][Air_PosZ] - 0.30000)) {
						AirWeapon[session_id][i][Air_Status] = 4;
						AirWeapon[session_id][i][Air_Timer] = gettime() + TDM_AIR_TIMER_WEAPON;
						AirWeapon[session_id][i][Air_Action] = true;

						DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectParachute]);
	/*
						AirWeapo[session_id][i][Air_ObjectWeapon][0] = CreateDynamicObject(356, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[session_id][i][Air_ObjectWeapon][1] = CreateDynamicObject(2358, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[session_id][i][Air_ObjectWeapon][2] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[session_id][i][Air_ObjectWeapon][3] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[session_id][i][Air_ObjectWeapon][4] = CreateDynamicObject(348, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[session_id][i][Air_ObjectWeapon][5] = CreateDynamicObject(353, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[session_id][i][Air_ObjectWeapon][6] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[session_id][i][Air_ObjectWeapon][7] = CreateDynamicObject(342, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[session_id][i][Air_ObjectWeapon][8] = CreateDynamicObject(342, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AttachDynamicObjectToObject(AirWeapon[session_id][i][Air_ObjectWeapon][8], AirWeapon[session_id][i][Air_ObjectBox], -0.1382, 0.0026, 0.8000, 0.0000, 0.0000, 50.0000, 1);
						AttachDynamicObjectToObject(AirWeapon[session_id][i][Air_ObjectWeapon][7], AirWeapon[session_id][i][Air_ObjectBox], -0.3000, 0.0000, 0.8000, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirWeapon[session_id][i][Air_ObjectWeapon][6], AirWeapon[session_id][i][Air_ObjectBox], 0.5976, 0.5976, 0.8799, 0.0000, 0.0000, 70.0000, 1);
						AttachDynamicObjectToObject(AirWeapon[session_id][i][Air_ObjectWeapon][5], AirWeapon[session_id][i][Air_ObjectBox], -0.4000, 0.4000, 0.7500, 80.0000, 0.0000, 90.0000, 1);
						AttachDynamicObjectToObject(AirWeapon[session_id][i][Air_ObjectWeapon][4], AirWeapon[session_id][i][Air_ObjectBox], 0.1000, -0.1732, 0.7500, 90.0000, 0.0000, 30.0000, 1);
						AttachDynamicObjectToObject(AirWeapon[session_id][i][Air_ObjectWeapon][3], AirWeapon[session_id][i][Air_ObjectBox], -0.0867, 0.4924, 0.8798, 0.0000, 0.0000, 80.0000, 1);
						AttachDynamicObjectToObject(AirWeapon[session_id][i][Air_ObjectWeapon][2], AirWeapon[session_id][i][Air_ObjectBox], 0.5160, -0.3343, 0.8798, 0.0000, 0.0000, -50.0000, 1);
						AttachDynamicObjectToObject(AirWeapon[session_id][i][Air_ObjectWeapon][1], AirWeapon[session_id][i][Air_ObjectBox], -0.4000, -0.5999, 0.8500, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirWeapon[session_id][i][Air_ObjectWeapon][0], AirWeapon[session_id][i][Air_ObjectBox], -0.5000, -0.3000, 0.8000, 50.0000, 0.0000, 0.0000, 1);
	*/
						Create3DTextAirWeapon(session_id, i, bx, by, bz);
					}
				}
				case 4: { // Удаление
					if(AirWeapon[session_id][i][Air_Timer] < gettime()) {
						DestroyDynamic3DTextLabel(AirWeapon[session_id][i][Air_3DText]);
						DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectBox]);
						DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectAir]);

						//for(new w = 0; w < TDM_AIR_MAX_OBJECT_WEAPON; w++) DestroyDynamicObject(AirWeapon[i][Air_ObjectWeapon][w]);

						ResetAirWeapon(session_id, i);

						if(AllAirsWeapon[session_id] > 0) 
							AllAirsWeapon[session_id]--;

						AllAirWeapon[session_id][ii] = AllAirWeapon[session_id][AllAirsWeapon[session_id]];
						AllAirWeapon[session_id][AllAirsWeapon[session_id]] = -1;
					}
				}
			}
		}
	}
	
	TDM_UpdateClassesAirdrop(session_id);

	if(TDM_GetFastPoint(session_id))
		TDM_UpdateAirFastPoint(session_id);

	return 1;
}

static DeleteAllAir(session_id)
{
	// Бомбардировщики
	if(AllAirsBomb[session_id] > 0) {
		n_for(ii, AllAirsBomb[session_id]) {
			new
				i = AllAirBomb[session_id][ii];

			switch(AirBomb[session_id][i][Air_Status]) {
				case 1, 3: DestroyDynamicObject(AirBomb[session_id][i][Air_ObjectAir]);
				case 2: {
					DestroyDynamicObject(AirBomb[session_id][i][Air_ObjectAir]);
					DestroyDynamicObject(AirBomb[session_id][i][Air_ObjectBomb]);
				}
			}
		}
	}
	ResetAirBomb(session_id, -1);

	// Обычные аирдропы с оружием
	if(AllAirsWeapon[session_id] > 0) {
		n_for(ii, AllAirsWeapon[session_id]) {
			new 
				i = AllAirWeapon[session_id][ii];

			switch(AirWeapon[session_id][i][Air_Status]) {
				case 1, 2: {
					DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectBox]);
					DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectAir]);
				}
				case 3: {
					DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectBox]);
					DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectAir]);
					DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectParachute]);
				}
				case 4: {
					DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectBox]);
					DestroyDynamicObject(AirWeapon[session_id][i][Air_ObjectAir]);
				}
			}
			if(AirWeapon[session_id][i][Air_Action])
				DestroyDynamic3DTextLabel(AirWeapon[session_id][i][Air_3DText]);
		}
	}
	ResetAirWeapon(session_id, -1);

	TDM_DestroyAllClassesAirdrop(session_id);
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerData(playerid)
{
	TDM_SetPlayerBagMoney(playerid, false);

	FastPointPlayerCapture[playerid] = 0;

	ActionPlayerCaptureFlag[playerid] =
	GangZonePlayerCapture[playerid] =
	ComputerPlayerCapture[playerid] =
	TDM_PlayerIDAirWeapon[playerid] = -1;

	ComputerPlayerTeam[playerid] = TDM_TEAM_NONE;
}

/*

	* Dialogs *

*/

DialogCreate:TDM_Shop(playerid)
{
	new
		team = GetPlayerTeamEx(playerid),
		session_id = Mode_GetPlayerSession(playerid);

	stringer[0] = EOS;

	strcat(stringer, "Предмет\tКоличество\tОчков раунда");

	n_for(i, TDM_SHOP_MAX_ITEMS) {
		new 
			item_name[100];

		switch(PriceShopTeam[session_id][team][i][sp_ItemID]) {
			case 100: item_name = "Здоровье";
			case 101: item_name = "Броня";
			default: GetWeaponNameRU(PriceShopTeam[session_id][team][i][sp_ItemID], item_name, sizeof(item_name));
		}
		f(stringer, "%s\n"C_N" {FFFFFF}%s\t{EF9A0B}%i\t{d69c1e}%i ОР", stringer, item_name, PriceShopTeam[session_id][team][i][sp_Count], PriceShopTeam[session_id][team][i][sp_Price]);
	}
	static
		main_str[100],
		rebate_str[50];

	if(RebateShopTeam[session_id][team])
		f(rebate_str, "{e36f17}(Скидка x%i!)", RebateShopTeam[session_id][team] + 1);

	f(main_str, "{17e3d5}Магазин %s", rebate_str);
	Dialog_Open(playerid, Dialog:TDM_Shop, DSTH, main_str, stringer, "Купить", "Выход");
	return 1;
}

DialogResponse:TDM_Shop(playerid, response, listitem, inputtext[])
{
	if(!response)
		return 1;

	new
		choose_team = GetPlayerTeamEx(playerid),
		session_id = Mode_GetPlayerSession(playerid);

	if(Mode_GetPlayerMatchPoints(playerid) < PriceShopTeam[session_id][choose_team][listitem][sp_Price])
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно очков раунда.");
	else {
		new
			item_name[100];

		Mode_SetPlayerMatchPoint(playerid, -PriceShopTeam[session_id][choose_team][listitem][sp_Price]);
		switch(PriceShopTeam[session_id][choose_team][listitem][sp_ItemID]) {
			case 100: {
				item_name = "Здоровье";
				SetPlayerHealthEx(playerid, 100.0);
			}
			case 101: {
				item_name = "Броня";
				SetPlayerArmourEx(playerid, 100.0);
			}
			default: {
				GetWeaponNameRU(PriceShopTeam[session_id][choose_team][listitem][sp_ItemID], item_name, sizeof(item_name));
				GivePlayerWeaponEx(playerid, PriceShopTeam[session_id][choose_team][listitem][sp_ItemID], PriceShopTeam[session_id][choose_team][listitem][sp_Count]);
			}
		}

		f(stringer, "{e39f17}(Магазин) {17e36f}%s {FFFFFF}у Вас.", item_name);
		SCM(playerid, -1, stringer);

		stringer[0] = EOS;
	}
	Dialog_Show(playerid, Dialog:TDM_Shop);
	return 1;
}

DialogCreate:AirdropWeapon(playerid)
{
	new
		proverka,
		air_id = GetPVarInt(playerid, "TDM_LocAirID_PVar");

	new
		session_id = Mode_GetPlayerSession(playerid);

	DeletePVar(playerid, "TDM_LocAirID_PVar");

	n_for(w, TDM_AIR_MAX_WEAPON) {
		if(AirWeapon[session_id][air_id][Air_Weapon][w] > 0) 
			proverka++;
	}

	if(proverka > 0) {
		TDM_SetPlayerIDAirdrop(playerid, air_id);

		static
			string[1000],
			str[500],
			name[200];

		string[0] = str[0] = name[0] = EOS;

		name = "Оружие\tПатроны\n";
		strcat(string, name);

		n_for(w, TDM_AIR_MAX_WEAPON) {
			if(w != (TDM_AIR_MAX_WEAPON - 1)) {
				if(!AirWeapon[session_id][air_id][Air_Weapon][w]) {
					new
						ww = w + 1;

					AirWeapon[session_id][air_id][Air_Weapon][w] = AirWeapon[session_id][air_id][Air_Weapon][ww];
					AirWeapon[session_id][air_id][Air_WeaponAmmo][w] = AirWeapon[session_id][air_id][Air_WeaponAmmo][ww];

					AirWeapon[session_id][air_id][Air_Weapon][ww] =
					AirWeapon[session_id][air_id][Air_WeaponAmmo][ww] = 0;
				}
			}
			if(AirWeapon[session_id][air_id][Air_Weapon][w]) {
				new
					weapon[WEAPON_NAME_MAX_LENGTH + 1];

				GetWeaponNameRU(AirWeapon[session_id][air_id][Air_Weapon][w], weapon, sizeof(weapon));
				f(str, "{C5F9FC}%s\t{DAB767}%i\n", weapon, AirWeapon[session_id][air_id][Air_WeaponAmmo][w]);
				strcat(string, str);
			}
		}
		Dialog_Open(playerid, Dialog:AirdropWeapon, DSTH, "Оружие в контейнере", string, "Выбрать", "Назад");
	}
	else {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		Dialog_Message(playerid, "Оружие в контейнере", "{FFFFFF}\tПусто", "Закрыть");
	}
	return 1;
}

DialogResponse:AirdropWeapon(playerid, response, listitem, inputtext[])
{
	new
		air_id = TDM_GetPlayerIDAirdrop(playerid);

	new
		session_id = Mode_GetPlayerSession(playerid);

	if(!AirWeapon[session_id][air_id][Air_Action]) {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		return 1;
	}

	if(response) {
		n_for(w, TDM_AIR_MAX_WEAPON) {
			if(listitem != w)
				continue;

			GivePlayerWeaponEx(playerid, AirWeapon[session_id][air_id][Air_Weapon][w], AirWeapon[session_id][air_id][Air_WeaponAmmo][w]);
			AirWeapon[session_id][air_id][Air_Weapon][w] =
			AirWeapon[session_id][air_id][Air_WeaponAmmo][w] = 0;

			m_for(MODE_TDM, session_id, p) {
				if(GetPlayerVirtualWorldEx(p) != AirWeapon[session_id][air_id][Air_VirtualWorld]) 
					continue;

				if(GetPlayerInteriorEx(p) != AirWeapon[session_id][air_id][Air_Interior]) 
					continue;

				if(TDM_GetPlayerIDAirdrop(p) != air_id) 
					continue;

				Dialog_Close(p);

				SetPVarInt(p, "TDM_LocAirID_PVar", air_id);
				Dialog_Show(p, Dialog:AirdropWeapon);
			}
			break;
		}
	}
	else
		TDM_SetPlayerIDAirdrop(playerid, -1);

	return 1;
}

/*

	* Callbacks *

*/

/*
	OnGameModeInit
*/

stock TDM_LocOnGameModeInit(session_id)
{
	// Локации
	TDM_lDesert_OnGameModeInit(session_id);

	// Others
	Iter_Init(TDM_BaseTeamCount);
	Iter_Init(TDM_CapturePointCount);
	Iter_Init(TDM_CaptureFlagCount);
	Iter_Init(TDM_BagMoneyCount);
	Iter_Init(TDM_ShopCount);

	TDM_ResetBaseTeam(session_id, -1);
	TDM_ResetCapturePoint(session_id, -1);
	TDM_ResetComputer(session_id, -1, -1);
	TDM_ResetCaptureFlag(session_id, -1);
	TDM_ResetBagMoney(session_id, -1);
	TDM_ResetShop(session_id, -1);

	TDM_ResetFastPoint(session_id, -1);
	ResetAirFastPoint(session_id);

	TDM_ResetAEObject(session_id, -1);
	TDM_ResetAE3DText(session_id, -1);
	TDM_ResetAEPickupDoor(session_id, -1);
	TDM_ResetAEPickupOther(session_id, -1);
	TDM_ResetAEMapIcon(session_id, -1);
	TDM_ResetAEActor(session_id, -1);

	ResetVehicle(session_id, -1);
	TDM_ResetTimer(session_id);
	TDM_ResetExitZone(session_id);
	TDM_ResetSpawnTopActor(session_id);
	TDM_ResetCameraEndPos(session_id);

	ResetAirBomb(session_id, -1);
	ResetAirWeapon(session_id, -1);
	return 1;
}

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);

	#if defined TDM_LocOnPlayerConnect
		return TDM_LocOnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	OnPlayerDeath
*/

stock TDM_LocOnPlayerDeath(playerid, killerid, reason)
{
	DestroyPlayerPointCapture(playerid);
	DestroyPlayerComputer(playerid);
	SpawnCaptureFlag(playerid, 0);

	new
		session_id = Mode_GetPlayerSession(playerid);

	switch(Mode_GetLocation(MODE_TDM, session_id)) {
		case TDM_LOC_DESERT: TDM_lDesert_OnPlayerDeath(playerid, killerid, reason);
	}
	return 1;
}

/*
	OnPlayerPickUpDynamicPickup
*/

stock TDM_LocOnPlPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 0;

	if(GetPlayerSpectating(playerid) > -1)
		return 0;

	if(GetPlayerDead(playerid))
		return 0;

	new
		session_id = Mode_GetPlayerSession(playerid);

	// Пикапы дверей
	n_for(i, AE_TotalNumberPickupsDoor[session_id]) {
		if(!AE_PickupDoorInfo[session_id][i][tp_Created]) 
			continue;

		if(AE_PickupDoorInfo[session_id][i][tp_TypeClick]) 
			continue;

		if(pickupid == AE_PickupDoorInfo[session_id][i][tp_Pickup]) {
			TDM_SetPlayerKeyPickupDoor(playerid, Mode_GetLocation(MODE_TDM, session_id), i);
			return 1;
		}
	}

	// Разные пикапы
	n_for(i, AE_TotalNumberOtherPickups[session_id]) {
		if(!AE_OtherPickupInfo[session_id][i][op_Created]) 
			continue;

		if(AE_OtherPickupInfo[session_id][i][op_TypeClick]) 
			continue;

		if(pickupid == AE_OtherPickupInfo[session_id][i][op_Pickup]) {
			TDM_SetPlayerKeyOtherPickup(playerid, Mode_GetLocation(MODE_TDM, session_id), i);
			return 1;
		}
	}
	return 0;
}

/*
	OnPlayerEnterDynamicArea
*/

stock TDM_LocOnPlEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 0;

	if(GetPlayerSpectating(playerid) > -1)
		return 0;

	if(GetPlayerDead(playerid))
		return 0;

	new
		session_id = Mode_GetPlayerSession(playerid);

	if(TDM_GetExitZone(session_id)) {
		if(!TDM_GetPlayerSelectTP(playerid)
		&& GetPlayerZone(playerid)
		&& !GetPlayerInteriorEx(playerid)) {
			if(areaid == AreaExitZone[session_id]) {
				if(GetPlayerExitZone(playerid))
					HidePlayerExitZone(playerid);
			}
		}
	}

	if(TDM_GetStatusGame(session_id) != TDM_LOC_GAME_STATUS_GAME)
		return 0;

	if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE) {
		if(GangZonePlayerCapture[playerid] == -1
		&& !Adm_GetPlayerSpectating(playerid)) {
			new 
				gangzone = -1;

			foreach(new g:TDM_CapturePointCount[session_id]) {
				if(TDM_CapturePoint[session_id][g][CP_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) 
					continue;

				if(TDM_CapturePoint[session_id][g][CP_Interior] != GetPlayerInteriorEx(playerid)) 
					continue;

				if(areaid != TDM_CapturePoint[session_id][g][CP_Sphere]) 
					continue;

				gangzone = g;
			}

			if(gangzone != -1)
				CreatePlayerPointCapture(playerid, gangzone);
		}
	}

	if(TDM_GetFastPoint(session_id)) {
		if(FastPoint[session_id][FP_Status] > 1) {
			if(areaid == FastPoint[session_id][FP_Sphere]) {
				if(IsPlayerReadyCaptureFastPoint(session_id, playerid))
					FastPointPlayerCapture[playerid] = 1;
			}
		}
	}
	return 0;
}

/*
	OnPlayerLeaveDynamicArea
*/

stock TDM_LocOnPlLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if(GetPlayerBusy(playerid) != GAME)
		return 0;

	if(GetPlayerSpectating(playerid) > -1)
		return 0;

	new
		session_id = Mode_GetPlayerSession(playerid);

	if(TDM_GetExitZone(session_id)) {
		if(!GetPlayerDead(playerid)
		&& !TDM_GetPlayerSelectTP(playerid) 
		&& GetPlayerZone(playerid)
		&& !GetPlayerInteriorEx(playerid)) {
			if(areaid == AreaExitZone[session_id]) {
				ShowPlayerExitZone(playerid);
			}
		}
	}

	if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE) {
		new 
			point_id = -1;

		foreach(new g:TDM_CapturePointCount[session_id]) {
			if(TDM_CapturePoint[session_id][g][CP_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) 
				continue;

			if(TDM_CapturePoint[session_id][g][CP_Interior] != GetPlayerInteriorEx(playerid)) 
				continue;

			if(areaid != TDM_CapturePoint[session_id][g][CP_Sphere]) 
				continue;

			point_id = g;
		}

		if(point_id != -1) {
			DestroyPlayerPointCapture(playerid);
		}
	}

	if(TDM_GetFastPoint(session_id)) {
		if(FastPointPlayerCapture[playerid]
		&& areaid == FastPoint[session_id][FP_Sphere]) {
			FastPointPlayerCapture[playerid] = 0;
		}
	}
	return 0;
}

/*
	OnPlayerKeyStateChange
*/

stock TDM_LocOnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	#pragma unused oldkeys

	new
		session_id = Mode_GetPlayerSession(playerid),
		return_callback = 0;

	switch(Mode_GetLocation(MODE_TDM, session_id)) {
		case TDM_LOC_DESERT: return_callback = TDM_lDesert_OnPlayerKeySC(playerid, newkeys, oldkeys);
	}

	if(return_callback)
		return 1;

	// ALT
	if(newkeys & KEY_WALK) {
		// Пикапы дверей
		n_for(i, AE_TotalNumberPickupsDoor[session_id]) {
			if(!AE_PickupDoorInfo[session_id][i][tp_Created]) 
				continue;

			if(!AE_PickupDoorInfo[session_id][i][tp_TypeClick]) 
				continue;

			if(IsPlayerInRangeOfPoint(playerid, 1.3, AE_PickupDoorInfo[session_id][i][tp_EnterPos_X], AE_PickupDoorInfo[session_id][i][tp_EnterPos_Y], AE_PickupDoorInfo[session_id][i][tp_EnterPos_Z])) {
				TDM_SetPlayerKeyPickupDoor(playerid, Mode_GetLocation(MODE_TDM, session_id), i);
				return 1;
			}
		}
		// Разные пикапы
		n_for(i, AE_TotalNumberOtherPickups[session_id]) {
			if(!AE_OtherPickupInfo[session_id][i][op_Created]) 
				continue;

			if(!AE_OtherPickupInfo[session_id][i][op_TypeClick]) 
				continue;

			if(IsPlayerInRangeOfPoint(playerid, 1.3, AE_OtherPickupInfo[session_id][i][op_PosX], AE_OtherPickupInfo[session_id][i][op_PosY], AE_OtherPickupInfo[session_id][i][op_PosZ])) {
				TDM_SetPlayerKeyOtherPickup(playerid, Mode_GetLocation(MODE_TDM, session_id), i);
				return 1;
			}
		}
		// 3D тексты
		n_for(i, AE_TotalNumber3DTexts[session_id]) {
			if(!AE_3DTextInfo[session_id][i][dt_Created]) 
				continue;

			if(!AE_3DTextInfo[session_id][i][dt_TypeClick]) 
				continue;

			if(IsPlayerInRangeOfPoint(playerid, 1.3, AE_3DTextInfo[session_id][i][dt_PosX], AE_3DTextInfo[session_id][i][dt_PosY], AE_3DTextInfo[session_id][i][dt_PosZ])) {
				TDM_SetPlayerKey3DText(playerid, Mode_GetLocation(MODE_TDM, session_id), i);
				return 1;
			}
		}

		// Аирдроп оружия
		if(AllAirsWeapon[session_id] > 0) {
			n_for(ii, AllAirsWeapon[session_id]) {
				new
					air_id = AllAirWeapon[session_id][ii];

				if(AirWeapon[session_id][air_id][Air_Action]) {
					if(AirWeapon[session_id][air_id][Air_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) 
						continue;

					if(AirWeapon[session_id][air_id][Air_Interior] != GetPlayerInteriorEx(playerid)) 
						continue;

					if(IsPlayerInRangeOfPoint(playerid, 3.0, AirWeapon[session_id][air_id][Air_PosX], AirWeapon[session_id][air_id][Air_PosY], AirWeapon[session_id][air_id][Air_PosZ])) {
						SetPVarInt(playerid, "TDM_LocAirID_PVar", air_id);
						Dialog_Show(playerid, Dialog:AirdropWeapon);
						return 1;
					}
				}
			}
		}
		// Компьютеры
		if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_SECRET_DATA) {
			n_for(tt, TDM_MAX_TEAMS) {
				n_for2(c, TDM_MAX_COMPUTERS) {
					if(!TDM_Computer[session_id][tt][c][COMP_Enabled])
						continue;

					new 
						team = TDM_Computer[session_id][tt][c][COMP_ProtectTeam];

					if(TDM_Computer[session_id][team][c][COMP_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) 
						continue;

					if(TDM_Computer[session_id][team][c][COMP_Interior] != GetPlayerInteriorEx(playerid)) 
						continue;

					if(IsPlayerInRangeOfPoint(playerid, 1.3, PosComputers[session_id][team][c][0], PosComputers[session_id][team][c][1], PosComputers[session_id][team][c][2])) {
						if(GetPlayerTeamEx(playerid) != TDM_Computer[session_id][team][c][COMP_Status]) {
							if(!TDM_Computer[session_id][team][c][COMP_ActionCapture]) {
								if(!TDM_Computer[session_id][team][c][COMP_Red]) {
									CreatePlayerComputer(playerid, team, c);
								}
							}
						}
						else {
							if(!TDM_Computer[session_id][team][c][COMP_ActionCapture]) {
								if(GetPlayerTeamEx(playerid) == TDM_Computer[session_id][team][c][COMP_ProtectTeam])
									SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Вы должны защищать компьютер!");
							}
						}
						return 1;
					}
				}
			}
		}
		// Захват флага
		if(Mode_GetMode(MODE_TDM, session_id) == TDM_MODE_CAPTURE_FLAG) {
			foreach(new tt:TDM_CaptureFlagCount[session_id]) {
				if(IsPlayerInRangeOfPoint(playerid, 1.3, PosCaptureFlag[session_id][tt][0], PosCaptureFlag[session_id][tt][1], PosCaptureFlag[session_id][tt][2])) {
					if(GetPlayerTeamEx(playerid) != tt) {
						if(!TDM_CaptureFlag[session_id][tt][FLAG_Status]) {
							if(ActionPlayerCaptureFlag[playerid] == -1) {
								CreatePlayerCaptureFlag(playerid, tt);
								TDM_SetTextTeamMatch(session_id, "Ваш флаг захвачен!", tt);
								Dina_CheckPlayerHint(playerid, 15);
							}
						}
					}
					else {
						if(ActionPlayerCaptureFlag[playerid] > -1) {
							SpawnCaptureFlag(playerid, 1);
						}
					}
					return 1;
				}
			}
		}
	}

	// N
	if(newkeys & KEY_NO) {
		// Мешок с деньгами
		if(TDM_GetBagMoney(session_id)) {
			foreach(new b:TDM_BagMoneyCount[session_id]) {
				if(TDM_BagMoney[session_id][b][BG_VirtualWorld] != GetPlayerVirtualWorldEx(playerid))
					continue;

				if(TDM_BagMoney[session_id][b][BG_Interior] != GetPlayerInteriorEx(playerid)) 
					continue;

				if(IsPlayerInRangeOfPoint(playerid, 1.0, PosBagMoney[session_id][b][0], PosBagMoney[session_id][b][1], PosBagMoney[session_id][b][2])) {
					if(TDM_BagMoney[session_id][b][BG_Team] == GetPlayerTeamEx(playerid)) {
						if(!TDM_GetPlayerBagMoney(playerid)) {
							SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Требуется иметь при себе мешок с деньгами.");
						}
						else {
							TDM_SetPlayerBagMoney(playerid, false);
							RemovePlayerAttachedObject(playerid, 8);
							SetPlayerFee(playerid, 400, 300, REPLEN_BAG_OF_CREDITS);

							// Квесты
							Quest_CheckPlayerProgress(playerid, MODE_TDM, 20);
							Quest_CheckPlayerProgress(playerid, MODE_TDM, 24);
							//
						}
					}
					else {
						if(TDM_GetPlayerBagMoney(playerid)) {
							SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Мешок с деньгами уже имеется.");
						}
						else {
							if(IsPlayerAttachedObjectSlotUsed(playerid, 8)) {
								SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы уже переносите предмет на спине!");
							}
							else {
								TDM_SetPlayerBagMoney(playerid, true);
								SetPlayerAttachedObject(playerid, 8, 1550, 1, 0.0, -0.3, 0, 90, 90, 0.0);

								SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Мешок с деньгами у Вас, теперь доставьте его на свою базу.");
							}
						}
					}
					return 1;
				}
			}
		}
		// Магазин
		if(TDM_GetShops(session_id)) {
			foreach(new b:TDM_ShopCount[session_id]) {
				if(TDM_Shop[session_id][b][WP_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) 
					continue;

				if(TDM_Shop[session_id][b][WP_Interior] != GetPlayerInteriorEx(playerid)) 
					continue;

				if(IsPlayerInRangeOfPoint(playerid, 1.0, PosShop[session_id][b][0], PosShop[session_id][b][1], PosShop[session_id][b][2])) {
					if(GetPlayerTeamEx(playerid) != TDM_Shop[session_id][b][WP_Team]) {
						SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный магазин не принадлежит Вашей команде!");
					}
					else
						Dialog_Show(playerid, Dialog:TDM_Shop);

					return 1;
				}
			}
		}
	}

	Mode_CheckOnPlayerKey(playerid);
	return 0;
}

/*
	ALS
*/

#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif
#define OnPlayerConnect TDM_LocOnPlayerConnect
#if defined TDM_LocOnPlayerConnect
	forward TDM_LocOnPlayerConnect(playerid);
#endif