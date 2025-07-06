/*
 * |>============================<|
 * |   About: TDM location main   |
 * |   Author: Foxze              |
 * |>============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnPlayerConnect(playerid)
	- OnPlayerSpawn(playerid)
	- OnPlayerDeath(playerid, killerid, WEAPON:reason)
	- OnPlayerPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
	- OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
 * Stock:
	- TDM_InitialLocations()

	- TDM_CreateElementsLocation(sessionid, locationid)
	- TDM_DestroyElementsLocation(sessionid)

	- TDM_ShowPlayerElementsLocation(playerid)
	- TDM_HidePlayerElementsLocation(playerid)

	- TDM_CreateLocAE(sessionid, locationid)
	- TDM_DestroyLocAE(sessionid)

	- TDM_CreateAEObject(sessionid, cell, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
	- TDM_DestroyAEObject(sessionid, cell = -1)
	- TDM_GetAEObjectPos(sessionid, cell, &Float:x, &Float:y, &Float:z)
	- TDM_SetAEObjectMaterial(sessionid, cell, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0)
	- TDM_SetAEObjectMaterialText(sessionid, cell, materialindex, const text[], materialsize = OBJECT_MATERIAL_SIZE_256x128, const fontface[] = "Arial", fontsize = 24, bold = 1, fontcolor = 0xFFFFFFFF, backcolor = 0, textalignment = 0)
	- TDM_MoveAEObject(sessionid, cell, Float:x, Float:y, Float:z, Float:speed, Float:rx = -1000.0, Float:ry = -1000.0, Float:rz = -1000.0)
	- TDM_StopAEObject(sessionid, cell)

	- TDM_CreateAE3DText(sessionid, cell, const name[], color, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid, vehicleid, lost)
	- TDM_DestroyAE3DText(sessionid, cell = -1)
	- TDM_UpdateAE3DText(sessionid, cell, color, const text[])

	- TDM_CreateAEPickupDoor(sessionid, cell, const name[], id, style, typeclick, Float:enterpos_x, Float:enterpos_y, Float:enterpos_z, enter_virtualworld, enter_interior, Float:exitpos_x, Float:exitpos_y, Float:exitpos_z, Float:exitpos_a, exit_virtualworld, exit_interior)
	- TDM_DestroyAEPickupDoor(sessionid, cell = -1)
	- TDM_SetPlayerPosAEDoor(playerid, pickupid)

	- TDM_CreateAEOtherPickup(sessionid, cell, const name[], id, style, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, virtualworld, interior)
	- TDM_DestroyAEOtherPickup(sessionid, cell = -1)
	- TDM_UpdateAE3DTextOP(sessionid, cell, color, const text[])

	- TDM_CreateAEMapIcon(sessionid, cell, Float:x, Float:y, Float:z, type, color, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_MAP_ICON_SD, style = MAPICON_LOCAL, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
	- TDM_DestroyAEMapIcon(sessionid, cell = -1)

	- TDM_CreateAEActor(sessionid, cell, modelid, Float:x, Float:y, Float:z, Float:r, invulnerable = true, Float:health = 100.0, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_ACTOR_SD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
	- TDM_DestroyAEActor(sessionid, cell = -1)

	- TDM_SetNumberAE(sessionid, objects, texts3d, pickupsdoor, otherpickups, mapicons, actors)

	- TDM_AddTeam(sessionid, teamid, bool:score)
	- TDM_RemoveTeam(sessionid, teamid)
	- TDM_CheckTeam(sessionid, teamid)
	- TDM_CheckTeamScore(sessionid, teamid)
	- TDM_GetActiveTeams(sessionid)

	- TDM_CreateBaseTeam(sessionid, teamid, Float:minx, Float:miny, Float:maxx, Float:maxy)
	- TDM_DestroyBaseTeam(sessionid, teamid)
	- TDM_ResetBaseTeam(sessionid, teamid)
	- TDM_SetCameraBaseTeam(sessionid, teamid, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
	- TDM_SetSpawnBaseTeam(sessionid, teamid, cell, Float:x, Float:y, Float:z)
	- TDM_GetBaseSpawn(sessionid, base_id, randomPos, &Float:X, &Float:Y, &Float:Z)
	- TDM_SetPlayerBaseCamera(playerid, teamid)

	- TDM_CreateCapturePoint(sessionid, cell, const name[], Float:x, Float:y, Float:z, Float:minx, Float:miny, Float:maxx, Float:maxy)
	- TDM_DestroyCapturePoint(sessionid, cell)
	- TDM_ResetCapturePoint(sessionid, pointid)
	- TDM_GetGangZonePlayer(playerid, &pointid)
	- TDM_SetCameraCapturePoint(sessionid, cell, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
	- TDM_SetSpawnCapturePoint(sessionid, cell, cell2, Float:x, Float:y, Float:z)
	- TDM_SetPlayerCPointCamera(playerid, pointid)
	- TDM_LocGetCapturePointSpawn(sessionid, pointid, randomPos, &Float:X, &Float:Y, &Float:Z)
	- TDM_GiveCPTeamScore(sessionid, teamid, num)
	- TDM_ResetCPTeamScore(sessionid, teamid)
	- TDM_GetCPTeamScore(sessionid, teamid)
	- TDM_GiveCPTeamMaxScore(sessionid, teamid, num)
	- TDM_ResetCPTeamMaxScore(sessionid, teamid)
	- TDM_GetCPTeamMaxScore(sessionid, teamid)
	- TDM_GiveCPPointTeam(sessionid, teamid)
	- TDM_GetCapturePointTeam(sessionid, pointid)
	- TDM_GetCapturePointRed(sessionid, pointid)
	- TDM_GetCapturePointName(sessionid, pointid)
	- TDM_CapturePointReInfo(sessionid)

	- TDM_CreateComputer(sessionid, teamid, cell, Float:x, Float:y, Float:z)
	- TDM_DestroyComputer(sessionid, teamid)
	- TDM_ResetComputer(sessionid, teamid, compid)
	- TDM_GiveCompTeamScore(sessionid, teamid, num)
	- TDM_ResetCompTeamScore(sessionid, teamid)
	- TDM_GetCompTeamScore(sessionid, teamid)
	- TDM_GiveCompTeamMaxScore(sessionid, teamid, num)
	- TDM_ResetCompTeamMaxScore(sessionid, teamid)
	- TDM_GetCompTeamMaxScore(sessionid, teamid)
	- TDM_ComputerReInfo(sessionid)
	- TDM_UpdatePlayerComputer(playerid)

	- TDM_CreateCaptureFlag(sessionid, teamid, Float:x, Float:y, Float:z)
	- TDM_DestroyCaptureFlag(sessionid, teamid)
	- TDM_ResetCaptureFlag(sessionid, teamid)
	- TDM_GiveFlagTeamScore(sessionid, teamid, num)
	- TDM_ResetFlagTeamScore(sessionid, teamid)
	- TDM_GetFlagTeamScore(sessionid, teamid)
	- TDM_GiveFlagTeamMaxScore(sessionid, teamid, num)
	- TDM_ResetFlagTeamMaxScore(sessionid, teamid)
	- TDM_GetFlagTeamMaxScore(sessionid, teamid)

	- TDM_GiveBattleTeamScore(sessionid, teamid, num)
	- TDM_GetBattleTeamScore(sessionid, teamid)
	- TDM_GiveBattleTeamMaxScore(sessionid, teamid, num)
	- TDM_GetBattleTeamMaxScore(sessionid, teamid)

	- TDM_CreateBagMoney(sessionid, teamid, Float:x, Float:y, Float:z, virtualworld = -1, interior = -1)
	- TDM_DestroyBagMoney(sessionid, teamid)
	- TDM_ResetBagMoney(sessionid, teamid)
	- TDM_GetBagMoney(sessionid)
	- TDM_SetPlayerBagMoney(playerid, bool:type)
	- TDM_GetPlayerBagMoney(playerid)

	- TDM_CreateShopTeam(sessionid, teamid, Float:x, Float:y, Float:z, virtualworld = -1, interior = -1)
	- TDM_DestroyShopTeam(sessionid, teamid)
	- TDM_ResetShopTeam(sessionid, teamid)
	- TDM_GetShopTeams(sessionid)

	- TDM_CreateFastPoint(sessionid, Float:x, Float:y, Float:z)
	- TDM_DestroyFastPoint(sessionid, all = 0)
	- TDM_ResetFastPoint(sessionid, all)
	- TDM_CreatePosFastPoint(sessionid, cell, Float:x, Float:y, Float:z)
	- TDM_GetFastPoint(sessionid)
	- TDM_StartFastPoint(sessionid)
	- TDM_FastPointReInfo(sessionid)
	- TDM_UpdateAirFastPoint(sessionid)
	- TDM_CheckStartFastPoint(sessionid)

	- TDM_CreateVehicle(sessionid, teamid, cell, vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1 = -1, color2 = -1, respawn_delay = VEHICLE_RESPAWN_TIME, addsiren = 0)
	- TDM_DestroyVehicle(sessionid, cell)
	- TDM_GetVehicleID(sessionid, cell)
	- TDM_SetActiveVehicle(sessionid, bool:type)
	- TDM_GetActiveVehicle(sessionid)

	- TDM_SetTeamScore(sessionid, teamid, score, maxscore)
	- TDM_ResetTeamsScore(sessionid)
	- TDM_GetTeamsScore(sessionid)

	- TDM_SetExitZonePos(sessionid, Float:minx, Float:miny, Float:maxx, Float:maxy)
	- TDM_DestroyExitZone(sessionid)
	- TDM_GetExitZone(sessionid)

	- TDM_SetSpawnTopActor(sessionid, cell, Float:X, Float:Y, Float:Z, Float:Angle)
	- TDM_GetSpawnTopActor(sessionid, cell, &Float:X, &Float:Y, &Float:Z, &Float:Angle)
	- 
	- SetAirBomb(sessionid, id, Float:x, Float:y, Float:z, virtualworld, interior)
	- SetAirWeapon(sessionid, id, Float:x, Float:y, Float:z, virtualworld, interior)
	- Create3DTextAirWeapon(sessionid, id, Float:x, Float:y, Float:z)
	- TDM_SetWeaponAirNextPriority(sessionid, num)
	- TDM_GetWeaponAirBextPriority(sessionid)
	- TDM_SetBombAirNextPriority(sessionid, num)
	- TDM_GetBombAirBextPriority(sessionid)
	- TDM_SetBombAirs(sessionid)
	- TDM_SetWeaponAirs(sessionid)
	- TDM_IsValidAirWeapon(sessionid, airid)
	- TDM_IsValidAirBomb(sessionid, airid)
	- TDM_SetAirDropWeapon(sessionid, bool:type)
	- TDM_GetAirDropWeapon(sessionid)
	- TDM_SetAirBomb(sessionid, bool:type)
	- TDM_GetAirBomb(sessionid)
	- TDM_UpdateAirData(sessionid)

	- TDM_SetPlayerIDAirdrop(playerid, airid)
	- TDM_GetPlayerIDAirdrop(playerid)

	- TDM_ShowCameraEndLocation(playerid, type)
	- TDM_ShowCameraEndLocationTwo(playerid, type)
	- TDM_ShowCameraEndLocationThree(playerid, type)
	- TDM_SetCameraEndPos(sessionid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
	- TDM_SetCameraEndLookAt(sessionid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
	- TDM_SetCameraEndPosTwo(sessionid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
	- TDM_ResetCameraEndPos(sessionid)

	- TDM_LocSetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
	- TDM_LocResetPlayerMG(playerid)
	- TDM_LocUpdatePlayerMG(playerid)

	- TDM_LocCallPlayerCommand(playerid, const cmdName[], const params[])
	- TDM_SpawnPlayerElementArea(playerid)
	- TDM_SetPlayerKeyAEPickupDoor(playerid, locationid, pickupid)
	- TDM_SetPlayerKeyAEOtherPickup(playerid, locationid, pickupid)
	- TDM_SetPlayerKeyAE3DText(playerid, locationid, textid)
	- TDM_UpdateAE(locationid, sessionid)
	- TDM_UpdatePlayerAE(playerid)
	- TDM_VehicleSetSettings(vehicleid)
	- TDM_SetPlayerKeyMode3DText(playerid, locationid, p_3dtext, textid)

	# Technical #
	- TDM_LocResetSessionData(sessionid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_TDM_AIR_DROP_WEAPON_INFO
	- E_TDM_AIR_BOMB_INFO
	- E_TDM_AIR_FAST_POINT_INFO
	- E_TDM_SHOP_PRICE_INFO
	- E_TDM_CAPTURE_POINT_INFO
	- E_TDM_COMPUTER_INFO
	- E_TDM_CAPTURE_FLAG_INFO
	- E_TDM_BAG_MONEY_INFO
	- E_TDM_SHOP_INFO
	- E_TDM_FAST_POINT_INFO
	- E_TDM_BASE_TEAM_INFO
	- E_TDM_AE_3D_TEXT_INFO
	- E_TDM_AE_PICKUP_DOOR_INFO
	- E_TDM_AE_OTHER_PICKUP_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- TDM_ShopTeam
	- TDM_AirdropWeapon
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_TDM_LOC_MAIN
	#endinput
#endif
#define _INC_TDM_LOC_MAIN

/*
 * |>-----------------<|
 * |     Locations     |
 * |>-----------------<|
 */

#include <sources/modes/tdm/locations/desert/desert.pwn>
#include <sources/modes/tdm/locations/desert2/desert2.pwn>
#include <sources/modes/tdm/locations/airport/airport.pwn>
#include <sources/modes/tdm/locations/airport2/airport2.pwn>
#include <sources/modes/tdm/locations/stadium/stadium.pwn>
#include <sources/modes/tdm/locations/village/village.pwn>
#include <sources/modes/tdm/locations/golf/golf.pwn>
#include <sources/modes/tdm/locations/zone51/zone51.pwn>
#include <sources/modes/tdm/locations/example/example.pwn>

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_TDM_AIR_DROP_WEAPON_INFO {
	e_ObjectAir,
	e_ObjectBox,
	//e_ObjectWeapon[TDM_AIR_MAX_OBJECT_WEAPON],
	e_ObjectParachute,
	Text3D:e_3DText,
	e_Status,
	bool:e_Active,
	e_Timer,
	e_VirtualWorld,
	e_Interior,
	e_Weapon[TDM_AIR_MAX_WEAPON],
	e_Ammo[TDM_AIR_C_MAX_WEAPON],
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ
}

enum E_TDM_AIR_BOMB_INFO {
	e_ObjectAir,
	e_ObjectBomb,
	e_Status,
	e_Timer,
	e_VirtualWorld,
	e_Interior,
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ
}

enum E_TDM_AIR_FAST_POINT_INFO {
	e_ObjectAir,
	e_ObjectBox,
	e_ObjectParachute,
	e_Status,
	e_Timer,
	e_VirtualWorld,
	e_Interior,
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ
}

enum E_TDM_CAPTURE_POINT_INFO {
	e_Name[TDM_MAX_LEN_CAPT_POINT_NAME],
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ,
	Float:e_Minx,
	Float:e_Miny,
	Float:e_Maxx,
	Float:e_Maxy,
	e_GangZone,
	e_Object[5],
	Text3D:e_3DText,
	e_Sphere,
	e_Color,
	e_Score,
	e_Property,
	bool:e_Red,
	e_CaptureTeam,
	e_MapIcon,
	e_VirtualWorld,
	e_Interior
}

enum E_TDM_COMPUTER_INFO {
	bool:e_Enabled,
	bool:e_ActiveCapture,
	bool:e_Red,
	e_Status,
	e_Score,
	e_Timer,
	e_ObjectSmoke,
	Text3D:e_3DText,
	Text3D:e_3DTextClick,
	e_MapIcon,
	e_VirtualWorld,
	e_Interior,
	e_ProtectTeam,
	e_PlayerID
}

enum E_TDM_CAPTURE_FLAG_INFO {
	e_Object[2],
	e_ObjectFlag,
	e_ObjectSmoke,
	Text3D:e_3DTextClick,
	Text3D:e_3DTextCapture,
	e_Status,
	e_PlayerID,
	e_MapIcon,
	e_VirtualWorld,
	e_Interior
}

enum E_TDM_BAG_MONEY_INFO {
	e_Team,
	e_Pickup,
	e_MapIcon,
	Text3D:e_3DText,
	e_VirtualWorld,
	e_Interior	
}

enum E_TDM_SHOP_PRICE_INFO {
	e_ItemID,
	e_Count,
	e_Price
}

enum E_TDM_SHOP_INFO {
	e_Team,
	e_Pickup,
	e_MapIcon,
	e_ObjectSmoke,
	Text3D:e_3DText,
	e_VirtualWorld,
	e_Interior
}

enum E_TDM_FAST_POINT_INFO {
	e_Status,
	e_Timer,
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ,
	e_Object[8],
	Text3D:e_3DText,
	e_Sphere,
	e_Color,
	e_Score,
	e_Property,
	bool:e_Red,
	e_CaptureTeam,
	e_MapIcon,
	e_VirtualWorld,
	e_Interior
}

enum E_TDM_BASE_TEAM_INFO {
	e_GangZone,
	e_Color,
	e_VirtualWorld,
	e_Interior
}

/*
 * |>----------------------------<|
 * |   Additional Elements (AE)   |
 * |>----------------------------<|
 */

enum E_TDM_AE_3D_TEXT_INFO {
	e_Name[TDM_MAX_LEN_AE_3DTEXT_NAME],
	Text3D:e_3DText,
	e_Color,
	e_TypeClick, // 0 - No / 1 - ALT
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ,
	Float:e_Radius,
	e_PlayerID,
	e_VehicleID,
	e_LOST,
	bool:e_Created
}

enum E_TDM_AE_PICKUP_DOOR_INFO {
	e_Name[TDM_MAX_LEN_AE_PICKUPDOOR_NAME],
	e_Pickup,
	Text3D:e_3DText,
	e_TypeClick, // 0 - No / 1 - ALT
	Float:e_EnterPosX,
	Float:e_EnterPosY,
	Float:e_EnterPosZ,
	e_EnterVirtualWorld,
	e_EnterInterior,
	Float:e_ExitPosX,
	Float:e_ExitPosY,
	Float:e_ExitPosZ,
	Float:e_ExitPosA,
	e_ExitVirtualWorld,
	e_ExitInterior,
	bool:e_Created
}

enum E_TDM_AE_OTHER_PICKUP_INFO {
	e_Name[TDM_MAX_LEN_AE_PICKUP_NAME],
	Text3D:e_3DText,
	e_Pickup,
	e_TypeClick, // 0 - No / 1 - ALT
	Float:e_PosX,
	Float:e_PosY,
	Float:e_PosZ,
	e_VirtualWorld,
	e_Interior,
	bool:e_Created
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

// Base team
static
	BaseTeamInfo[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][E_TDM_BASE_TEAM_INFO],
	Float:CameraBaseTeamPos[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][2][3],
	Float:SpawnBaseTeamPos[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][3][3];

// Capture point
static
	CapturePointInfo[GMS_MAX_SESSIONS][TDM_MAX_CAPTURE_POINTS][E_TDM_CAPTURE_POINT_INFO],
	Float:CameraCapturePointPos[GMS_MAX_SESSIONS][TDM_MAX_CAPTURE_POINTS][2][3],
	Float:SpawnCapturePointPos[GMS_MAX_SESSIONS][TDM_MAX_CAPTURE_POINTS][3][3],
	CP_TeamScore[GMS_MAX_SESSIONS][TDM_MAX_TEAMS],
	CP_TeamMaxScore[GMS_MAX_SESSIONS][TDM_MAX_TEAMS],
	PlayerCapturePointID[MAX_PLAYERS],
	PlayerBar:CapturePointBar[MAX_PLAYERS],
	PlayerText:TD_CapturePoint[MAX_PLAYERS] = {INVALID_PLAYER_TEXT_DRAW, ...};

// Computer
static
	ComputerInfo[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][TDM_MAX_COMPUTERS][E_TDM_COMPUTER_INFO],
	Float:PosComputer[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][TDM_MAX_COMPUTERS][3],
	COMP_TeamScore[GMS_MAX_SESSIONS][TDM_MAX_TEAMS],
	COMP_TeamMaxScore[GMS_MAX_SESSIONS][TDM_MAX_TEAMS],
	PlayerComputerID[MAX_PLAYERS],
	PlayerComputerTeamID[MAX_PLAYERS],
	PlayerBar:HackComputerBar[MAX_PLAYERS],
	PlayerText:TD_HackComputer[MAX_PLAYERS] = {INVALID_PLAYER_TEXT_DRAW, ...};

// Capture flag
static
	CaptureFlagInfo[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][E_TDM_CAPTURE_FLAG_INFO],
	Float:PosCaptureFlag[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][3],
	FLAG_TeamScore[GMS_MAX_SESSIONS][TDM_MAX_TEAMS],
	FLAG_TeamMaxScore[GMS_MAX_SESSIONS][TDM_MAX_TEAMS],
	ActionPlayerCaptureFlag[MAX_PLAYERS];

// Battle
static
	BATTLE_TeamScore[GMS_MAX_SESSIONS][TDM_MAX_TEAMS],
	BATTLE_TeamMaxScore[GMS_MAX_SESSIONS][TDM_MAX_TEAMS];

// Fast point
static
	bool:ActiveFastPoint[GMS_MAX_SESSIONS],
	AirFastPointInfo[GMS_MAX_SESSIONS][E_TDM_AIR_FAST_POINT_INFO],
	FastPointInfo[GMS_MAX_SESSIONS][E_TDM_FAST_POINT_INFO],
	Float:PosFastPoint[GMS_MAX_SESSIONS][5][3],
	bool:PlayerActiveFastPoint[MAX_PLAYERS char];

// Shop team
static
	TDM_ShopTeam[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][E_TDM_SHOP_INFO],
	Float:PosShop[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][3],
	PriceShopTeam[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][TDM_SHOP_MAX_ITEMS][E_TDM_SHOP_PRICE_INFO],
	RebateShopTeam[GMS_MAX_SESSIONS][TDM_MAX_TEAMS];

// Bag money
static
	BagMoneyInfo[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][E_TDM_BAG_MONEY_INFO],
	Float:PosBagMoney[GMS_MAX_SESSIONS][TDM_MAX_TEAMS][3],
	bool:PlayerActiveMoneyBag[MAX_PLAYERS char];

// Exit zone
static
	bool:ActiveExitZone[GMS_MAX_SESSIONS],
	AreaExitZone[GMS_MAX_SESSIONS];

// Team score
static
	bool:ActiveTeamScore[GMS_MAX_SESSIONS];

// Vehicle
static
	bool:ActiveVehicle[GMS_MAX_SESSIONS],
	VehicleID[GMS_MAX_SESSIONS][TDM_MAX_VEHICLES];

// Match end
static
	Float:ActorsTopKillsPos[GMS_MAX_SESSIONS][5][4],
	Float:CameraEndLocationPos[GMS_MAX_SESSIONS][4][3],
	Float:CameraEndLocationPosTwo[GMS_MAX_SESSIONS][2][3];

// Airdrop
static
	bool:ActiveAirdropWeapon[GMS_MAX_SESSIONS],
	PlayerAirdropIDWeapon[MAX_PLAYERS];

// Air bomb
static
	bool:ActiveAirBomb[GMS_MAX_SESSIONS],
	AirBombInfo[GMS_MAX_SESSIONS][TDM_MAX_AIR_BOMB][E_TDM_AIR_BOMB_INFO],
	AirBombNextPriority[GMS_MAX_SESSIONS],
	AllAirsBomb[GMS_MAX_SESSIONS],
	AllAirBomb[GMS_MAX_SESSIONS][TDM_MAX_AIR_BOMB];

// Air weapon
static
	AirWeaponInfo[GMS_MAX_SESSIONS][TDM_MAX_AIR_WEAPON][E_TDM_AIR_DROP_WEAPON_INFO],
	AirWeaponNextPriority[GMS_MAX_SESSIONS],
	AllAirsWeapon[GMS_MAX_SESSIONS],
	AllAirWeapon[GMS_MAX_SESSIONS][TDM_MAX_AIR_WEAPON];

// AE object
static
	AE_Object[GMS_MAX_SESSIONS][TDM_MAX_AE_OBJECT],
	AE_TotalNumberObjects[GMS_MAX_SESSIONS];

// AE 3DText
static
	AE_3DTextInfo[GMS_MAX_SESSIONS][TDM_MAX_AE_3DTEXT][E_TDM_AE_3D_TEXT_INFO],
	AE_TotalNumber3DTexts[GMS_MAX_SESSIONS];

// AE pickup door
static
	AE_PickupDoorInfo[GMS_MAX_SESSIONS][TDM_MAX_AE_PICKUP_DOOR][E_TDM_AE_PICKUP_DOOR_INFO],
	AE_TotalNumberPickupsDoor[GMS_MAX_SESSIONS];

// AE pickup
static
	AE_OtherPickupInfo[GMS_MAX_SESSIONS][TDM_MAX_AE_PICKUP][E_TDM_AE_OTHER_PICKUP_INFO],
	AE_TotalNumberOtherPickups[GMS_MAX_SESSIONS];

// AE mapicon
static
	AE_MapIcon[GMS_MAX_SESSIONS][TDM_MAX_AE_MAPICON],
	AE_TotalNumberMapIcons[GMS_MAX_SESSIONS];

// AE actor
static
	AE_Actor[GMS_MAX_SESSIONS][TDM_MAX_AE_ACTOR],
	AE_TotalNumberActors[GMS_MAX_SESSIONS];

// Shop price
static const
	PriceShopInfo[TDM_SHOP_MAX_ITEMS][E_TDM_SHOP_PRICE_INFO] = {
		{WEAPON_M4,				50, 500},
		{WEAPON_AK47,			50, 300},
		{WEAPON_DEAGLE,			30, 400},
		{WEAPON_COLT45,			30, 100},
		{WEAPON_MP5,			50, 150},
		{WEAPON_SAWEDOFF,		18, 600},
		{WEAPON_UZI,			40, 450},
		{WEAPON_RIFLE,			10, 500},
		{WEAPON_ROCKETLAUNCHER,	5, 1000},
		{WEAPON_GRENADE,		5, 100},
		{100,					100, 600},	// Health
		{101,					100, 700}	// Armour
	};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>----------------------------<|
 * |   Initialization locations   |
 * |>----------------------------<|
 */

stock TDM_InitialLocations()
{
	TDM_Desert_Init();
	TDM_Desert2_Init();
	TDM_Airport_Init();
	TDM_Airport2_Init();
	TDM_Stadium_Init();
	TDM_Village_Init();
	TDM_Golf_Init();
	TDM_Zone51_Init();
	TDM_Example_Init();
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Elements create & destroy   |
 * |>-----------------------------<|
 */

stock TDM_CreateElementsLocation(sessionid, locationid)
{
	switch (locationid) {
		case TDM_LOC_DESERT: TDM_Desert_CreateElements(sessionid);
		case TDM_LOC_DESERT2: TDM_Desert2_CreateElements(sessionid);
		case TDM_LOC_AIRPORT: TDM_Airport_CreateElements(sessionid);
		case TDM_LOC_AIRPORT2: TDM_Airport2_CreateElements(sessionid);
		case TDM_LOC_STADIUM: TDM_Stadium_CreateElements(sessionid);
		case TDM_LOC_VILLAGE: TDM_Village_CreateElements(sessionid);
		case TDM_LOC_GOLF: TDM_Golf_CreateElements(sessionid);
		case TDM_LOC_ZONE51: TDM_Zone51_CreateElements(sessionid);
		case TDM_LOC_EXAMPLE: TDM_Example_CreateElements(sessionid);
	}
	return 1;
}

stock TDM_DestroyElementsLocation(sessionid)
{
	// Base
	TDM_DestroyBaseTeam(sessionid, -1);

	switch (Mode_GetSessionGameMode(MODE_TDM, sessionid)) {
		// Capture point
		case TDM_GAME_MODE_CAPTURE: TDM_DestroyCapturePoint(sessionid, -1);
		// Computer
		case TDM_GAME_MODE_SECRET_DATA: TDM_DestroyComputer(sessionid, -1);
		// Capture flag
		case TDM_GAME_MODE_CAPTURE_FLAG: TDM_DestroyCaptureFlag(sessionid, -1);
	}

	// Exiz zone
	if (TDM_GetExitZone(sessionid)) {
		TDM_DestroyExitZone(sessionid);
	}

	// Mag money
	if (TDM_GetBagMoney(sessionid)) {
		TDM_DestroyBagMoney(sessionid, -1);
	}

	// Shop
	if (TDM_GetShopTeams(sessionid)) {
		TDM_DestroyShopTeam(sessionid, -1);
	}

	// Vehicle
	if (TDM_GetActiveVehicle(sessionid)) {
		TDM_DestroyVehicle(sessionid, -1);
	}

	// Airs
	DeleteAllAir(sessionid);

	if (TDM_GetAirDropWeapon(sessionid)) {
		TDM_SetAirDropWeapon(sessionid, false);
	}

	if (TDM_GetAirBomb(sessionid)) {
		TDM_SetAirBomb(sessionid, false);
	}

	// Score
	TDM_ResetTeamsScore(sessionid);

	// Fast point
	TDM_DestroyFastPoint(sessionid, -1);

	// Camera end match
	TDM_ResetCameraEndPos(sessionid);

	// Teams
	TDM_RemoveTeam(sessionid, -1);
	return 1;
}

stock TDM_ShowPlayerElementsLocation(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Base team
	foreach (new g:TDM_ActiveTeams[sessionid]) {
		GangZoneShowForPlayer(playerid, BaseTeamInfo[sessionid][g][e_GangZone], TDM_GetTeamColorXB(BaseTeamInfo[sessionid][g][e_Color]));
	}

	// Timer
	if (Mode_GetSessionActiveTimer(MODE_TDM, sessionid)) {
		Mode_ShowPlSessionTimerTD(playerid);
	}

	// Score
	if (TDM_GetTeamsScore(sessionid)) {
		TDM_ShowPlayerTeamsScoreTD(playerid);
	}

	// Capture points
	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE) {
		foreach (new g:TDM_CapturePointCount[sessionid]) {
			GangZoneShowForPlayer(playerid, CapturePointInfo[sessionid][g][e_GangZone], TDM_GetTeamColorXB(CapturePointInfo[sessionid][g][e_Color]));
		}
	}
	return 1;
}

stock TDM_HidePlayerElementsLocation(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Base team
	foreach (new i:TDM_ActiveTeams[sessionid]) {
		GangZoneHideForPlayer(playerid, BaseTeamInfo[sessionid][i][e_GangZone]);
	}

	// Score
	if (TDM_GetTeamsScore(sessionid)) {
		TDM_DestroyPlayerTeamsScoreTD(playerid);
	}

	// Capture point
	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE) {
		DestroyPlayerPointCapture(playerid);
		foreach (new g:TDM_CapturePointCount[sessionid]) {
			GangZoneHideForPlayer(playerid, CapturePointInfo[sessionid][g][e_GangZone]);
		}
	}

	// Computer
	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_SECRET_DATA) {
		DestroyPlayerComputer(playerid);
	}

	// Capture flag
	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE_FLAG) {
		SpawnCaptureFlag(playerid, 0);
	}
	return 1;
}

/*
 * |>-----------------------<|
 * |   AE create & destroy   |
 * |>-----------------------<|
 */

stock TDM_CreateLocAE(sessionid, locationid)
{
	switch (locationid) {
		case TDM_LOC_DESERT: TDM_Desert_CreateAE(sessionid);
	}
	return 1;
}

stock TDM_DestroyLocAE(sessionid)
{
	new
		locationid = Mode_GetSessionLocation(MODE_TDM, sessionid);

	switch (locationid) {
		case TDM_LOC_DESERT: TDM_Desert_DestroyAE(sessionid);
	}

	TDM_DestroyAEObject(sessionid);
	TDM_DestroyAE3DText(sessionid);
	TDM_DestroyAEPickupDoor(sessionid);
	TDM_DestroyAEOtherPickup(sessionid);
	TDM_DestroyAEMapIcon(sessionid);
	return 1;
}

/*
 * |>-------------<|
 * |   AE Object   |
 * |>-------------<|
 */

stock TDM_CreateAEObject(sessionid, cell, modelid, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_OBJECT_SD, Float:drawdistance = STREAMER_OBJECT_DD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
{
	if (IsValidDynamicObject(AE_Object[sessionid][cell])) {
		return 0;
	}

	if (worldid == -1) {
		worldid = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	}
	if (interiorid == -1) {
		interiorid = Mode_GetSessionInterior(MODE_TDM, sessionid);
	}

	AE_Object[sessionid][cell] = CreateDynamicObject(modelid, x, y, z, rx, ry, rz, worldid, interiorid, playerid, streamdistance, drawdistance, areaid, priority);
	return 1;
}

stock TDM_DestroyAEObject(sessionid, cell = -1)
{
	if (cell == -1) {
		n_for(i, AE_TotalNumberObjects[sessionid]) {
			if (IsValidDynamicObject(AE_Object[sessionid][i])) {
				DestroyDynamicObject(AE_Object[sessionid][i]);
			}
			TDM_ResetAEObject(sessionid, i);
		}
		AE_TotalNumberObjects[sessionid] = 0;
	}
	else {
		if (IsValidDynamicObject(AE_Object[sessionid][cell])) {
			DestroyDynamicObject(AE_Object[sessionid][cell]);
		}
		TDM_ResetAEObject(sessionid, cell);
	}
	return 1;
}

static TDM_ResetAEObject(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_AE_OBJECT) {
			AE_Object[sessionid][i] = INVALID_DYNAMIC_OBJECT_ID;
		}
	}
	else {
		AE_Object[sessionid][cell] = INVALID_DYNAMIC_OBJECT_ID;
	}
	return 1;
}

stock TDM_GetAEObjectPos(sessionid, cell, &Float:x, &Float:y, &Float:z)
{
	if (IsValidDynamicObject(AE_Object[sessionid][cell])) {
		GetDynamicObjectPos(AE_Object[sessionid][cell], x, y, z);
	}
	return 1;
}

stock TDM_SetAEObjectMaterial(sessionid, cell, materialindex, modelid, const txdname[], const texturename[], materialcolor = 0)
{
	if (IsValidDynamicObject(AE_Object[sessionid][cell])) {
		SetDynamicObjectMaterial(AE_Object[sessionid][cell], materialindex, modelid, txdname, texturename, materialcolor);
	}
	return 1;
}

stock TDM_SetAEObjectMaterialText(sessionid, cell, materialindex, const text[], materialsize = OBJECT_MATERIAL_SIZE_256x128, const fontface[] = "Arial", fontsize = 24, bold = 1, fontcolor = 0xFFFFFFFF, backcolor = 0, textalignment = 0)
{
	if (IsValidDynamicObject(AE_Object[sessionid][cell])) {
		SetDynamicObjectMaterialText(AE_Object[sessionid][cell], materialindex, text, materialsize, fontface, fontsize, bold, fontcolor, backcolor, textalignment);
	}
	return 1;
}

stock TDM_MoveAEObject(sessionid, cell, Float:x, Float:y, Float:z, Float:speed, Float:rx = -1000.0, Float:ry = -1000.0, Float:rz = -1000.0)
{
	if (IsValidDynamicObject(AE_Object[sessionid][cell])) {
		MoveDynamicObject(AE_Object[sessionid][cell], x, y, z, speed, rx, ry, rz);
	}
	return 1;
}

stock TDM_StopAEObject(sessionid, cell)
{
	if (IsValidDynamicObject(AE_Object[sessionid][cell])) {
		StopDynamicObject(AE_Object[sessionid][cell]);
	}
	return 1;
}

/*
 * |>-------------<|
 * |   AE 3DText   |
 * |>-------------<|
 */

stock TDM_CreateAE3DText(sessionid, cell, const name[], color, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, Float:radius, playerid, vehicleid, lost, virtualworld = -1, interiorid = -1)
{
	if (AE_3DTextInfo[sessionid][cell][e_Created]) {
		return 0;
	}

	if (virtualworld == -1) {
		virtualworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	}
	if (interiorid == -1) {
		interiorid = Mode_GetSessionInterior(MODE_TDM, sessionid);
	}

	strins(AE_3DTextInfo[sessionid][cell][e_Name], name, 0);
	AE_3DTextInfo[sessionid][cell][e_Color] = color;
	AE_3DTextInfo[sessionid][cell][e_TypeClick] = typeclick;
	AE_3DTextInfo[sessionid][cell][e_PosX] = pos_x;
	AE_3DTextInfo[sessionid][cell][e_PosY] = pos_y;
	AE_3DTextInfo[sessionid][cell][e_PosZ] = pos_z;
	AE_3DTextInfo[sessionid][cell][e_Radius] = radius;
	AE_3DTextInfo[sessionid][cell][e_PlayerID] = playerid;
	AE_3DTextInfo[sessionid][cell][e_VehicleID] = vehicleid;
	AE_3DTextInfo[sessionid][cell][e_LOST] = lost;
	AE_3DTextInfo[sessionid][cell][e_Created] = true;
	AE_3DTextInfo[sessionid][cell][e_3DText] = CreateDynamic3DTextLabel(name, color, pos_x, pos_y, pos_z, radius, playerid, vehicleid, lost, virtualworld, interiorid);
	return 1;
}

stock TDM_DestroyAE3DText(sessionid, cell = -1)
{
	if (cell == -1) {
		n_for(i, AE_TotalNumber3DTexts[sessionid]) {
			if (AE_3DTextInfo[sessionid][i][e_Created]) {
				DestroyDynamic3DTextLabel(AE_3DTextInfo[sessionid][i][e_3DText]);
				TDM_ResetAE3DText(sessionid, i);
			}
		}
		AE_TotalNumber3DTexts[sessionid] = 0;
	}
	else {
		if (AE_3DTextInfo[sessionid][cell][e_Created]) {
			DestroyDynamic3DTextLabel(AE_3DTextInfo[sessionid][cell][e_3DText]);
			TDM_ResetAE3DText(sessionid, cell);
		}
	}
	return 1;
}

static TDM_ResetAE3DText(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_AE_3DTEXT) {
			AE_3DTextInfo[sessionid][i][e_Name][0] = EOS;
			AE_3DTextInfo[sessionid][i][e_Color] =
			AE_3DTextInfo[sessionid][i][e_TypeClick] = 0;
			AE_3DTextInfo[sessionid][i][e_PosX] =
			AE_3DTextInfo[sessionid][i][e_PosY] =
			AE_3DTextInfo[sessionid][i][e_PosZ] =
			AE_3DTextInfo[sessionid][i][e_Radius] = 0.0;
			AE_3DTextInfo[sessionid][i][e_PlayerID] =
			AE_3DTextInfo[sessionid][i][e_VehicleID] = -1;
			AE_3DTextInfo[sessionid][i][e_LOST] = 0;
			AE_3DTextInfo[sessionid][i][e_Created] = false;

			AE_3DTextInfo[sessionid][i][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		}
	}
	else {
		AE_3DTextInfo[sessionid][cell][e_Name][0] = EOS;
		AE_3DTextInfo[sessionid][cell][e_Color] =
		AE_3DTextInfo[sessionid][cell][e_TypeClick] = 0;
		AE_3DTextInfo[sessionid][cell][e_PosX] =
		AE_3DTextInfo[sessionid][cell][e_PosY] =
		AE_3DTextInfo[sessionid][cell][e_PosZ] =
		AE_3DTextInfo[sessionid][cell][e_Radius] = 0.0;
		AE_3DTextInfo[sessionid][cell][e_PlayerID] =
		AE_3DTextInfo[sessionid][cell][e_VehicleID] = -1;
		AE_3DTextInfo[sessionid][cell][e_LOST] = 0;
		AE_3DTextInfo[sessionid][cell][e_Created] = false;

		AE_3DTextInfo[sessionid][cell][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
	}
	return 1;
}

stock TDM_UpdateAE3DText(sessionid, cell, color, const text[])
{
	if (AE_3DTextInfo[sessionid][cell][e_Created]) {
		AE_3DTextInfo[sessionid][cell][e_Name][0] = EOS;

		strins(AE_3DTextInfo[sessionid][cell][e_Name], text, 0);
		UpdateDynamic3DTextLabelText(AE_3DTextInfo[sessionid][cell][e_3DText], color, text);
	}
	return 1;
}

/*
 * |>------------------<|
 * |   AE Pickup door   |
 * |>------------------<|
 */

stock TDM_CreateAEPickupDoor(sessionid, cell, const name[], id, style, typeclick, Float:enterpos_x, Float:enterpos_y, Float:enterpos_z, enter_virtualworld, enter_interior, Float:exitpos_x, Float:exitpos_y, Float:exitpos_z, Float:exitpos_a, exit_virtualworld, exit_interior)
{
	if (AE_PickupDoorInfo[sessionid][cell][e_Created]) {
		return 0;
	}

	if (enter_virtualworld == -1) {
		enter_virtualworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	}
	if (enter_interior == -1) {
		enter_interior = Mode_GetSessionInterior(MODE_TDM, sessionid);
	}

	if (exit_virtualworld == -1) {
		exit_virtualworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	}
	if (exit_interior == -1) {
		exit_interior = Mode_GetSessionInterior(MODE_TDM, sessionid);
	}

	strins(AE_PickupDoorInfo[sessionid][cell][e_Name], name, 0);
	AE_PickupDoorInfo[sessionid][cell][e_TypeClick] = typeclick;
	AE_PickupDoorInfo[sessionid][cell][e_EnterPosX] = enterpos_x;
	AE_PickupDoorInfo[sessionid][cell][e_EnterPosY] = enterpos_y;
	AE_PickupDoorInfo[sessionid][cell][e_EnterPosZ] = enterpos_z;
	AE_PickupDoorInfo[sessionid][cell][e_EnterVirtualWorld] = enter_virtualworld;
	AE_PickupDoorInfo[sessionid][cell][e_EnterInterior] = enter_interior;
	AE_PickupDoorInfo[sessionid][cell][e_ExitPosX] = exitpos_x;
	AE_PickupDoorInfo[sessionid][cell][e_ExitPosY] = exitpos_y;
	AE_PickupDoorInfo[sessionid][cell][e_ExitPosZ] = exitpos_z;
	AE_PickupDoorInfo[sessionid][cell][e_ExitPosA] = exitpos_a;
	AE_PickupDoorInfo[sessionid][cell][e_ExitVirtualWorld] = exit_virtualworld;
	AE_PickupDoorInfo[sessionid][cell][e_ExitInterior] = exit_interior;
	AE_PickupDoorInfo[sessionid][cell][e_Created] = true;
	AE_PickupDoorInfo[sessionid][cell][e_Pickup] = CreateDynamicPickup(id, style, enterpos_x, enterpos_y, enterpos_z, enter_virtualworld, enter_interior);
	AE_PickupDoorInfo[sessionid][cell][e_3DText] = CreateDynamic3DTextLabel(name, 0xFFFFFFFF, enterpos_x, enterpos_y, enterpos_z, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, enter_virtualworld, enter_interior);
	return 1;
}

stock TDM_DestroyAEPickupDoor(sessionid, cell = -1)
{
	if (cell == -1) {
		n_for(i, AE_TotalNumberPickupsDoor[sessionid]) {
			if (AE_PickupDoorInfo[sessionid][i][e_Created]) {
				DestroyDynamicPickup(AE_PickupDoorInfo[sessionid][i][e_Pickup]);
				DestroyDynamic3DTextLabel(AE_PickupDoorInfo[sessionid][i][e_3DText]);
	
				TDM_ResetAEPickupDoor(sessionid, i);
			}
		}
		AE_TotalNumberPickupsDoor[sessionid] = 0;
	}
	else {
		if (AE_PickupDoorInfo[sessionid][cell][e_Created]) {
			DestroyDynamicPickup(AE_PickupDoorInfo[sessionid][cell][e_Pickup]);
			DestroyDynamic3DTextLabel(AE_PickupDoorInfo[sessionid][cell][e_3DText]);

			TDM_ResetAEPickupDoor(sessionid, cell);
		}
	}
	return 1;
}

static TDM_ResetAEPickupDoor(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_AE_PICKUP_DOOR) {
			AE_PickupDoorInfo[sessionid][i][e_Name][0] = EOS;
			AE_PickupDoorInfo[sessionid][i][e_TypeClick] = 0;
			AE_PickupDoorInfo[sessionid][i][e_EnterPosX] =
			AE_PickupDoorInfo[sessionid][i][e_EnterPosY] =
			AE_PickupDoorInfo[sessionid][i][e_EnterPosZ] = 0.0;
			AE_PickupDoorInfo[sessionid][i][e_EnterVirtualWorld] =
			AE_PickupDoorInfo[sessionid][i][e_EnterInterior] = 0;
			AE_PickupDoorInfo[sessionid][i][e_ExitPosX] =
			AE_PickupDoorInfo[sessionid][i][e_ExitPosY] =
			AE_PickupDoorInfo[sessionid][i][e_ExitPosZ] =
			AE_PickupDoorInfo[sessionid][i][e_ExitPosA] = 0.0;
			AE_PickupDoorInfo[sessionid][i][e_ExitVirtualWorld] =
			AE_PickupDoorInfo[sessionid][i][e_ExitInterior] = 0;
			AE_PickupDoorInfo[sessionid][i][e_Created] = false;
			AE_PickupDoorInfo[sessionid][i][e_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
			AE_PickupDoorInfo[sessionid][i][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		}
	}
	else {
		AE_PickupDoorInfo[sessionid][cell][e_Name][0] = EOS;
		AE_PickupDoorInfo[sessionid][cell][e_TypeClick] = 0;
		AE_PickupDoorInfo[sessionid][cell][e_EnterPosX] =
		AE_PickupDoorInfo[sessionid][cell][e_EnterPosY] =
		AE_PickupDoorInfo[sessionid][cell][e_EnterPosZ] = 0.0;
		AE_PickupDoorInfo[sessionid][cell][e_EnterVirtualWorld] =
		AE_PickupDoorInfo[sessionid][cell][e_EnterInterior] = 0;
		AE_PickupDoorInfo[sessionid][cell][e_ExitPosX] =
		AE_PickupDoorInfo[sessionid][cell][e_ExitPosY] =
		AE_PickupDoorInfo[sessionid][cell][e_ExitPosZ] =
		AE_PickupDoorInfo[sessionid][cell][e_ExitPosA] = 0.0;
		AE_PickupDoorInfo[sessionid][cell][e_ExitVirtualWorld] =
		AE_PickupDoorInfo[sessionid][cell][e_ExitInterior] = 0;
		AE_PickupDoorInfo[sessionid][cell][e_Created] = false;
		AE_PickupDoorInfo[sessionid][cell][e_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
		AE_PickupDoorInfo[sessionid][cell][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
	}
	return 1;
}

stock TDM_SetPlayerPosAEDoor(playerid, pickupid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	SetPlayerPosEx(playerid, AE_PickupDoorInfo[sessionid][pickupid][e_ExitPosX], AE_PickupDoorInfo[sessionid][pickupid][e_ExitPosY], AE_PickupDoorInfo[sessionid][pickupid][e_ExitPosZ], AE_PickupDoorInfo[sessionid][pickupid][e_ExitVirtualWorld], AE_PickupDoorInfo[sessionid][pickupid][e_ExitInterior], false);
	SetPlayerFacingAngle(playerid, AE_PickupDoorInfo[sessionid][pickupid][e_ExitPosA]);
	return 1;
}

/*
 * |>-------------------<|
 * |   AE Pickup other   |
 * |>-------------------<|
 */

stock TDM_CreateAEOtherPickup(sessionid, cell, const name[], id, style, typeclick, Float:pos_x, Float:pos_y, Float:pos_z, virtualworld, interiorid)
{
	if (AE_OtherPickupInfo[sessionid][cell][e_Created]) {
		return 0;
	}

	if (virtualworld == -1) {
		virtualworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	}
	if (interiorid == -1) {
		interiorid = Mode_GetSessionInterior(MODE_TDM, sessionid);
	}

	strins(AE_OtherPickupInfo[sessionid][cell][e_Name], name, 0);
	AE_OtherPickupInfo[sessionid][cell][e_TypeClick] = typeclick;
	AE_OtherPickupInfo[sessionid][cell][e_PosX] = pos_x;
	AE_OtherPickupInfo[sessionid][cell][e_PosY] = pos_y;
	AE_OtherPickupInfo[sessionid][cell][e_PosZ] = pos_z;
	AE_OtherPickupInfo[sessionid][cell][e_VirtualWorld] = virtualworld;
	AE_OtherPickupInfo[sessionid][cell][e_Interior] = interiorid;
	AE_OtherPickupInfo[sessionid][cell][e_Created] = true;
	AE_OtherPickupInfo[sessionid][cell][e_Pickup] = CreateDynamicPickup(id, style, pos_x, pos_y, pos_z, virtualworld, interiorid);
	AE_OtherPickupInfo[sessionid][cell][e_3DText] = CreateDynamic3DTextLabel(name, 0xFFFFFFFF, pos_x, pos_y, pos_z, 15.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, virtualworld, interiorid);
	return 1;
}

stock TDM_DestroyAEOtherPickup(sessionid, cell = -1)
{
	if (cell == -1) {
		n_for(i, AE_TotalNumberOtherPickups[sessionid]) {
			if (AE_OtherPickupInfo[sessionid][i][e_Created]) {
				DestroyDynamicPickup(AE_OtherPickupInfo[sessionid][i][e_Pickup]);
				DestroyDynamic3DTextLabel(AE_OtherPickupInfo[sessionid][i][e_3DText]);

				TDM_ResetAEPickupOther(sessionid, i);
			}
		}
		AE_TotalNumberOtherPickups[sessionid] = 0;
	}
	else {
		if (AE_OtherPickupInfo[sessionid][cell][e_Created]) {
			DestroyDynamicPickup(AE_OtherPickupInfo[sessionid][cell][e_Pickup]);
			DestroyDynamic3DTextLabel(AE_OtherPickupInfo[sessionid][cell][e_3DText]);

			TDM_ResetAEPickupOther(sessionid, cell);
		}
	}
	return 1;
}

static TDM_ResetAEPickupOther(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_AE_PICKUP) {
			AE_OtherPickupInfo[sessionid][i][e_Name][0] = EOS;
			AE_OtherPickupInfo[sessionid][i][e_TypeClick] = 0;
			AE_OtherPickupInfo[sessionid][i][e_PosX] =
			AE_OtherPickupInfo[sessionid][i][e_PosY] =
			AE_OtherPickupInfo[sessionid][i][e_PosZ] = 0.0;
			AE_OtherPickupInfo[sessionid][i][e_VirtualWorld] =
			AE_OtherPickupInfo[sessionid][i][e_Interior] = 0;
			AE_OtherPickupInfo[sessionid][i][e_Created] = false;
			AE_OtherPickupInfo[sessionid][i][e_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
			AE_OtherPickupInfo[sessionid][i][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		}
	}
	else {
		AE_OtherPickupInfo[sessionid][cell][e_Name][0] = EOS;
		AE_OtherPickupInfo[sessionid][cell][e_TypeClick] = 0;
		AE_OtherPickupInfo[sessionid][cell][e_PosX] =
		AE_OtherPickupInfo[sessionid][cell][e_PosY] =
		AE_OtherPickupInfo[sessionid][cell][e_PosZ] = 0.0;
		AE_OtherPickupInfo[sessionid][cell][e_VirtualWorld] =
		AE_OtherPickupInfo[sessionid][cell][e_Interior] = 0;
		AE_OtherPickupInfo[sessionid][cell][e_Created] = false;
		AE_OtherPickupInfo[sessionid][cell][e_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
		AE_OtherPickupInfo[sessionid][cell][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
	}
	return 1;
}

stock TDM_UpdateAE3DTextOP(sessionid, cell, color, const text[])
{
	if (!AE_OtherPickupInfo[sessionid][cell][e_Created]) {
		return 0;
	}

	AE_OtherPickupInfo[sessionid][cell][e_Name][0] = EOS;

	strins(AE_OtherPickupInfo[sessionid][cell][e_Name], text, 0);
	UpdateDynamic3DTextLabelText(AE_OtherPickupInfo[sessionid][cell][e_3DText], color, text);
	return 1;
}

/*
 * |>--------------<|
 * |   AE Mapicon   |
 * |>--------------<|
 */

stock TDM_CreateAEMapIcon(sessionid, cell, Float:x, Float:y, Float:z, type, color, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_MAP_ICON_SD, style = MAPICON_LOCAL, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
{
	if (IsValidDynamicMapIcon(AE_MapIcon[sessionid][cell])) {
		return 0;
	}

	if (worldid == -1) {
		worldid = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	}
	if (interiorid == -1) { 
		interiorid = Mode_GetSessionInterior(MODE_TDM, sessionid);
	}

	AE_MapIcon[sessionid][cell] = CreateDynamicMapIcon(x, y, z, type, color, worldid, interiorid, playerid, streamdistance, style, areaid, priority);
	return 1;
}

stock TDM_DestroyAEMapIcon(sessionid, cell = -1)
{
	if (cell == -1) {
		n_for(i, AE_TotalNumberMapIcons[sessionid]) {
			if (IsValidDynamicMapIcon(AE_MapIcon[sessionid][i])) {
				DestroyDynamicMapIcon(AE_MapIcon[sessionid][i]);
			}
			TDM_ResetAEMapIcon(sessionid, i);
		}
		AE_TotalNumberMapIcons[sessionid] = 0;
	}
	else {
		if (IsValidDynamicMapIcon(AE_MapIcon[sessionid][cell])) {
			DestroyDynamicMapIcon(AE_MapIcon[sessionid][cell]);
		}
		TDM_ResetAEMapIcon(sessionid, cell);
	}
	return 1;
}

static TDM_ResetAEMapIcon(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_AE_MAPICON) {
			AE_MapIcon[sessionid][i] = INVALID_DYNAMIC_MAP_ICON_ID;
		}
	}
	else {
		AE_MapIcon[sessionid][cell] = INVALID_DYNAMIC_MAP_ICON_ID;
	}
	return 1;
}

/*
 * |>------------<|
 * |   AE Actor   |
 * |>------------<|
 */

stock TDM_CreateAEActor(sessionid, cell, modelid, Float:x, Float:y, Float:z, Float:r, invulnerable = true, Float:health = 100.0, worldid = -1, interiorid = -1, playerid = -1, Float:streamdistance = STREAMER_ACTOR_SD, STREAMER_TAG_AREA:areaid = STREAMER_TAG_AREA:-1, priority = 0)
{
	if (IsValidDynamicActor(AE_Actor[sessionid][cell])) {
		return 0;
	}

	if (worldid == -1) {
		worldid = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	}
	if (interiorid == -1) { 
		interiorid = Mode_GetSessionInterior(MODE_TDM, sessionid);
	}

	AE_Actor[sessionid][cell] = CreateDynamicActor(modelid, x, y, z, r, invulnerable, health, worldid, interiorid, playerid, streamdistance, areaid, priority);
	return 1;
}

stock TDM_DestroyAEActor(sessionid, cell = -1)
{
	if (cell == -1) {
		n_for(i, AE_TotalNumberActors[sessionid]) {
			if (IsValidDynamicActor(AE_Actor[sessionid][i]))
				DestroyDynamicActor(AE_Actor[sessionid][i]);

			TDM_ResetAEActor(sessionid, i);
		}
		AE_TotalNumberActors[sessionid] = 0;
	}
	else {
		if (IsValidDynamicActor(AE_Actor[sessionid][cell]))
			DestroyDynamicActor(AE_Actor[sessionid][cell]);

		TDM_ResetAEActor(sessionid, cell);
	}
	return 1;
}

static TDM_ResetAEActor(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_AE_ACTOR)
			AE_Actor[sessionid][i] = INVALID_DYNAMIC_ACTOR_ID;
	}
	else
		AE_Actor[sessionid][cell] = INVALID_DYNAMIC_ACTOR_ID;

	return 1;
}

/*
 * |>-------------------------<|
 * |   AE Number of elements   |
 * |>-------------------------<|
 */

stock TDM_SetNumberAE(sessionid, objects, texts3d, pickupsdoor, otherpickups, mapicons, actors)
{
	AE_TotalNumberObjects[sessionid] = objects;
	AE_TotalNumber3DTexts[sessionid] = texts3d;
	AE_TotalNumberPickupsDoor[sessionid] = pickupsdoor;
	AE_TotalNumberOtherPickups[sessionid] = otherpickups;
	AE_TotalNumberMapIcons[sessionid] = mapicons;
	AE_TotalNumberActors[sessionid] = actors;
	return 1;
}

/*
 * |>--------<|
 * |   Team   |
 * |>--------<|
 */

stock TDM_AddTeam(sessionid, teamid, bool:score)
{
	Iter_Add(TDM_ActiveTeams[sessionid], teamid);

	if (score) {
		Iter_Add(TDM_ActiveTeamsScore[sessionid], teamid);
	}
	return 1;
}

stock TDM_RemoveTeam(sessionid, teamid)
{
	if (teamid != -1) {
		Iter_Remove(TDM_ActiveTeams[sessionid], teamid);

		if (Iter_Contains(TDM_ActiveTeamsScore[sessionid], teamid)) {
			Iter_Remove(TDM_ActiveTeamsScore[sessionid], teamid);
		}
	}
	else {
		Iter_Clear(TDM_ActiveTeams[sessionid]);

		if (Iter_Count(TDM_ActiveTeamsScore[sessionid])) {
			Iter_Clear(TDM_ActiveTeamsScore[sessionid]);
		}
	}
	return 1;
}

stock TDM_CheckTeam(sessionid, teamid)
{
	return Iter_Contains(TDM_ActiveTeams[sessionid], teamid);
}

stock TDM_CheckTeamScore(sessionid, teamid)
{
	return Iter_Contains(TDM_ActiveTeamsScore[sessionid], teamid);
}

stock TDM_GetActiveTeams(sessionid)
{
	return Iter_Count(TDM_ActiveTeamsScore[sessionid]);
}

/*
 * |>-------------<|
 * |   Base team   |
 * |>-------------<|
 */

stock TDM_CreateBaseTeam(sessionid, teamid, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	BaseTeamInfo[sessionid][teamid][e_VirtualWorld] = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	BaseTeamInfo[sessionid][teamid][e_Interior] = Mode_GetSessionInterior(MODE_TDM, sessionid);

	BaseTeamInfo[sessionid][teamid][e_Color] = teamid;
	BaseTeamInfo[sessionid][teamid][e_GangZone] = GangZoneCreate(minx, miny, maxx, maxy);

	Iter_Add(TDM_BaseTeamCount[sessionid], teamid);
	return 1;
}

stock TDM_DestroyBaseTeam(sessionid, teamid)
{
	if (teamid != -1) {
		GangZoneDestroy(BaseTeamInfo[sessionid][teamid][e_GangZone]);
		TDM_ResetBaseTeam(sessionid, teamid);

		Iter_Remove(TDM_BaseTeamCount[sessionid], teamid);
	}
	else {
		foreach (new tt:TDM_BaseTeamCount[sessionid]) {
			GangZoneDestroy(BaseTeamInfo[sessionid][tt][e_GangZone]);
			TDM_ResetBaseTeam(sessionid, tt);
		}
		Iter_Clear(TDM_BaseTeamCount[sessionid]);
	}
	return 1;
}

stock TDM_ResetBaseTeam(sessionid, teamid)
{
	if (teamid == -1) {
		n_for(tt, TDM_MAX_TEAMS) {
			BaseTeamInfo[sessionid][tt][e_Color] = TDM_TEAM_NONE;
			BaseTeamInfo[sessionid][tt][e_VirtualWorld] =
			BaseTeamInfo[sessionid][tt][e_Interior] = 0;
			BaseTeamInfo[sessionid][tt][e_GangZone] = INVALID_GANG_ZONE;

			n_for2(i, sizeof(CameraBaseTeamPos[][])) {
				CameraBaseTeamPos[sessionid][tt][i][0] =
				CameraBaseTeamPos[sessionid][tt][i][1] =
				CameraBaseTeamPos[sessionid][tt][i][2] = 0.0;
			}

			n_for2(i, sizeof(SpawnBaseTeamPos[][])) {
				SpawnBaseTeamPos[sessionid][tt][i][0] =
				SpawnBaseTeamPos[sessionid][tt][i][1] =
				SpawnBaseTeamPos[sessionid][tt][i][2] = 0.0;
			}
		}
	}
	else {
		BaseTeamInfo[sessionid][teamid][e_Color] = TDM_TEAM_NONE;
		BaseTeamInfo[sessionid][teamid][e_VirtualWorld] =
		BaseTeamInfo[sessionid][teamid][e_Interior] = 0;
		BaseTeamInfo[sessionid][teamid][e_GangZone] = INVALID_GANG_ZONE;

		n_for(i, sizeof(CameraBaseTeamPos[][])) {
			CameraBaseTeamPos[sessionid][teamid][i][0] =
			CameraBaseTeamPos[sessionid][teamid][i][1] =
			CameraBaseTeamPos[sessionid][teamid][i][2] = 0.0;
		}

		n_for(i, sizeof(SpawnBaseTeamPos[][])) {
			SpawnBaseTeamPos[sessionid][teamid][i][0] =
			SpawnBaseTeamPos[sessionid][teamid][i][1] =
			SpawnBaseTeamPos[sessionid][teamid][i][2] = 0.0;
		}
	}
	return 1;
}

stock TDM_SetCameraBaseTeam(sessionid, teamid, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
{
	CameraBaseTeamPos[sessionid][teamid][0][0] = x;
	CameraBaseTeamPos[sessionid][teamid][0][1] = y;
	CameraBaseTeamPos[sessionid][teamid][0][2] = z;

	CameraBaseTeamPos[sessionid][teamid][1][0] = x2;
	CameraBaseTeamPos[sessionid][teamid][1][1] = y2;
	CameraBaseTeamPos[sessionid][teamid][1][2] = z2;
	return 1;
}

stock TDM_SetSpawnBaseTeam(sessionid, teamid, cell, Float:x, Float:y, Float:z)
{
	SpawnBaseTeamPos[sessionid][teamid][cell][0] = x;
	SpawnBaseTeamPos[sessionid][teamid][cell][1] = y;
	SpawnBaseTeamPos[sessionid][teamid][cell][2] = z;
	return 1;
}

stock TDM_GetBaseSpawn(sessionid, base_id, randomPos, &Float:X, &Float:Y, &Float:Z)
{
	X = SpawnBaseTeamPos[sessionid][base_id][randomPos][0];
	Y = SpawnBaseTeamPos[sessionid][base_id][randomPos][1];
	Z = SpawnBaseTeamPos[sessionid][base_id][randomPos][2];
	return 1;
}

/*
 * |>-----------------<|
 * |   Capture point   |
 * |>-----------------<|
 */

stock TDM_CreateCapturePoint(sessionid, cell, const name[], Float:x, Float:y, Float:z, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	new 
		vworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid),
		vint = Mode_GetSessionInterior(MODE_TDM, sessionid);

	CapturePointInfo[sessionid][cell][e_Name][0] = EOS;

	strins(CapturePointInfo[sessionid][cell][e_Name], name, 0);

	CapturePointInfo[sessionid][cell][e_PosX] = x;
	CapturePointInfo[sessionid][cell][e_PosY] = y;
	CapturePointInfo[sessionid][cell][e_PosZ] = z;

	CapturePointInfo[sessionid][cell][e_Minx] = minx;
	CapturePointInfo[sessionid][cell][e_Miny] = miny;
	CapturePointInfo[sessionid][cell][e_Maxx] = maxx;
	CapturePointInfo[sessionid][cell][e_Maxy] = maxy;

	CapturePointInfo[sessionid][cell][e_VirtualWorld] = vworld;
	CapturePointInfo[sessionid][cell][e_Interior] = vint;

	CapturePointInfo[sessionid][cell][e_GangZone] = GangZoneCreate(minx, miny, maxx, maxy);
	CapturePointInfo[sessionid][cell][e_Sphere] = CreateDynamicSphere(x, y, z, 15.0, vworld, vint, -1);
	CapturePointInfo[sessionid][cell][e_MapIcon] = CreateDynamicMapIcon(x, y, z, 19, 0, vworld, vint, -1, 300.0);
	CapturePointInfo[sessionid][cell][e_3DText] = CreateDynamic3DTextLabel("_", -1, x, y, z + 1.0, 700.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vworld, vint);
	
	z += 8.11;

	CapturePointInfo[sessionid][cell][e_Object][0] = CreateDynamicObject(1308, x, y, z, 900.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	SetDynamicObjectMaterial(CapturePointInfo[sessionid][cell][e_Object][0], 1, 3271, "boneyard", "bonyrd_skin1", -1);
	CapturePointInfo[sessionid][cell][e_Object][1] = CreateDynamicObject(2030, x - 0.08, y - 0.05, z - 9.47, 0.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	CapturePointInfo[sessionid][cell][e_Object][2] = CreateDynamicObject(3385, x - 0.06, y - 0.05, z - 9.09, 0.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	CapturePointInfo[sessionid][cell][e_Object][3] = CreateDynamicObject(19294, x - 0.16, y - 0.08, z - 3.9, 0.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	CapturePointInfo[sessionid][cell][e_Object][4] = CreateDynamicObject(2168, x + 0.41, y - 0.84, z - 9.02, 0.00000, 0.00000, 0.00000, vworld, vint, -1, 300.0, 300.0);
	ChangeColorPointFlag(sessionid, cell, TDM_TEAM_NONE);

	Iter_Add(TDM_CapturePointCount[sessionid], cell);
	return 1;
}

stock TDM_DestroyCapturePoint(sessionid, cell)
{
	if (cell != -1) {
		GangZoneDestroy(CapturePointInfo[sessionid][cell][e_GangZone]);
		DestroyDynamicArea(CapturePointInfo[sessionid][cell][e_Sphere]);
		DestroyDynamicMapIcon(CapturePointInfo[sessionid][cell][e_MapIcon]);
		DestroyDynamic3DTextLabel(CapturePointInfo[sessionid][cell][e_3DText]);

		n_for(i, 5) {
			DestroyDynamicObject(CapturePointInfo[sessionid][cell][e_Object][i]);
		}
		TDM_ResetCapturePoint(sessionid, cell);

		Iter_Remove(TDM_CapturePointCount[sessionid], cell);
	}
	else {
		foreach (new g:TDM_CapturePointCount[sessionid]) {	
			GangZoneDestroy(CapturePointInfo[sessionid][g][e_GangZone]);
			DestroyDynamicArea(CapturePointInfo[sessionid][g][e_Sphere]);
			DestroyDynamicMapIcon(CapturePointInfo[sessionid][g][e_MapIcon]);
			DestroyDynamic3DTextLabel(CapturePointInfo[sessionid][g][e_3DText]);

			n_for(i, 5) {
				DestroyDynamicObject(CapturePointInfo[sessionid][g][e_Object][i]);
			}
			TDM_ResetCapturePoint(sessionid, g);
		}
		Iter_Clear(TDM_CapturePointCount[sessionid]);
	}
	return 1;
}

stock TDM_ResetCapturePoint(sessionid, pointid)
{
	if (pointid == -1) {
		n_for(p, TDM_MAX_CAPTURE_POINTS) {
			CapturePointInfo[sessionid][p][e_Name][0] = EOS;
			CapturePointInfo[sessionid][p][e_Color] = TDM_TEAM_NONE;
			CapturePointInfo[sessionid][p][e_CaptureTeam] = TDM_TEAM_NONE;
			CapturePointInfo[sessionid][p][e_Red] = false;
			CapturePointInfo[sessionid][p][e_Score] = 0;
			CapturePointInfo[sessionid][p][e_Property] = TDM_TEAM_NONE;
			CapturePointInfo[sessionid][p][e_VirtualWorld] =
			CapturePointInfo[sessionid][p][e_Interior] = 0;
			CapturePointInfo[sessionid][p][e_GangZone] = INVALID_GANG_ZONE;
			CapturePointInfo[sessionid][p][e_Sphere] = INVALID_DYNAMIC_AREA_ID;
			CapturePointInfo[sessionid][p][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
			CapturePointInfo[sessionid][p][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

			n_for2(i, 5) {
				CapturePointInfo[sessionid][p][e_Object][i] = INVALID_DYNAMIC_OBJECT_ID;
			}

			n_for2(i, sizeof(CameraCapturePointPos[][])) {
				CameraCapturePointPos[sessionid][p][i][0] =
				CameraCapturePointPos[sessionid][p][i][1] =
				CameraCapturePointPos[sessionid][p][i][2] = 0.0;
			}

			n_for2(i, sizeof(SpawnCapturePointPos[][])) {
				SpawnCapturePointPos[sessionid][p][i][0] =
				SpawnCapturePointPos[sessionid][p][i][1] =
				SpawnCapturePointPos[sessionid][p][i][2] = 0.0;
			}
		}
	}
	else {
		CapturePointInfo[sessionid][pointid][e_Name][0] = EOS;
		CapturePointInfo[sessionid][pointid][e_Color] = TDM_TEAM_NONE;
		CapturePointInfo[sessionid][pointid][e_CaptureTeam] = TDM_TEAM_NONE;
		CapturePointInfo[sessionid][pointid][e_Red] = false;
		CapturePointInfo[sessionid][pointid][e_Score] = 0;
		CapturePointInfo[sessionid][pointid][e_Property] = TDM_TEAM_NONE;
		CapturePointInfo[sessionid][pointid][e_VirtualWorld] =
		CapturePointInfo[sessionid][pointid][e_Interior] = 0;
		CapturePointInfo[sessionid][pointid][e_GangZone] = INVALID_GANG_ZONE;
		CapturePointInfo[sessionid][pointid][e_Sphere] = INVALID_DYNAMIC_AREA_ID;
		CapturePointInfo[sessionid][pointid][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		CapturePointInfo[sessionid][pointid][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

		n_for(i, 5) {
			CapturePointInfo[sessionid][pointid][e_Object][i] = INVALID_DYNAMIC_OBJECT_ID;
		}

		n_for(i, sizeof(CameraCapturePointPos[][])) {
			CameraCapturePointPos[sessionid][pointid][i][0] =
			CameraCapturePointPos[sessionid][pointid][i][1] =
			CameraCapturePointPos[sessionid][pointid][i][2] = 0.0;
		}

		n_for(i, sizeof(SpawnCapturePointPos[][])) {
			SpawnCapturePointPos[sessionid][pointid][i][0] =
			SpawnCapturePointPos[sessionid][pointid][i][1] =
			SpawnCapturePointPos[sessionid][pointid][i][2] = 0.0;
		}
	} 
	return 1;
}

static SetPointFlagPos(sessionid, pointid, type)
{
	if (!IsValidDynamicObject(CapturePointInfo[sessionid][pointid][e_Object][4])) {
		return 0;
	}

	new
		Float:X, Float:Y, Float:Z,
		Float:rotX, Float:rotY, Float:rotZ;
		
	GetDynamicObjectPos(CapturePointInfo[sessionid][pointid][e_Object][0], X, Y, Z);
	GetDynamicObjectRot(CapturePointInfo[sessionid][pointid][e_Object][4], rotX, rotY, rotZ);

	if (IsDynamicObjectMoving(CapturePointInfo[sessionid][pointid][e_Object][4])) {
		StopDynamicObject(CapturePointInfo[sessionid][pointid][e_Object][4]);
	}

	switch (type) {
		case 1: SetDynamicObjectPos(CapturePointInfo[sessionid][pointid][e_Object][4], X + 0.41, Y - 0.84, Z - 9.02);
		case 2: SetDynamicObjectPos(CapturePointInfo[sessionid][pointid][e_Object][4], X + 0.41, Y - 0.84, (Z - 9.02) + (0.4 * 20));
	}
	SetDynamicObjectRot(CapturePointInfo[sessionid][pointid][e_Object][4], rotX, rotY, rotZ);
	return 1;
}

static MovePointFlag(sessionid, pointid, type, bool:speed = false)
{
	if (!IsValidDynamicObject(CapturePointInfo[sessionid][pointid][e_Object][4])) {
		return 0;
	}

	new
		Float:X, Float:Y, Float:Z;
		
	GetDynamicObjectPos(CapturePointInfo[sessionid][pointid][e_Object][4], X, Y, Z);

	switch (type) {
		case 1: {
			if (!speed) {
				MoveDynamicObject(CapturePointInfo[sessionid][pointid][e_Object][4], X, Y, Z + 0.4, 3.0, 0.00000, 0.00000, 0.00000);
			}
			else { 
				MoveDynamicObject(CapturePointInfo[sessionid][pointid][e_Object][4], X, Y, Z + 0.8, 3.0, 0.00000, 0.00000, 0.00000);
			}
		}
		case 2: {
			if (!speed) {
				MoveDynamicObject(CapturePointInfo[sessionid][pointid][e_Object][4], X, Y, Z - 0.4, 3.0, 0.00000, 0.00000, 0.00000);
			}
			else {
				MoveDynamicObject(CapturePointInfo[sessionid][pointid][e_Object][4], X, Y, Z - 0.8, 3.0, 0.00000, 0.00000, 0.00000);
			}
		}
	}
	return 1;
}

static ChangeColorPointFlag(sessionid, pointid, teamid)
{
	if (IsValidDynamicObject(CapturePointInfo[sessionid][pointid][e_Object][4])) {
		SetDynamicObjectMaterial(CapturePointInfo[sessionid][pointid][e_Object][4], 0, -1, "none", "none", TDM_GetTeamColorObject(teamid));
	}
	return 1;
}

static CreatePlayerPointCapture(playerid, gangzone_id)
{
	if (PlayerCapturePointID[playerid] != -1) {
		DestroyPlayerPointCapture(playerid);
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	PlayerCapturePointID[playerid] = gangzone_id;
	CapturePointBar[playerid] = CreatePlayerProgressBar(playerid, 285.00, 279.00, 75.50, 7.19, 0xCCCCCC00, TDM_MAX_SCORE_CAPTURE.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarColour(playerid, CapturePointBar[playerid], TDM_GetTeamColorXB(CapturePointInfo[sessionid][gangzone_id][e_Property]));
	SetPlayerProgressBarValue(playerid, CapturePointBar[playerid], floatround(CapturePointInfo[sessionid][gangzone_id][e_Score]));
	ShowPlayerProgressBar(playerid, CapturePointBar[playerid]);

	TDM_CreatePlayerCaptPointTD(playerid, TD_CapturePoint[playerid]);

	PlayerTextDrawSetString(playerid, TD_CapturePoint[playerid], "Точка: ~y~%s", GetNamePointABC(gangzone_id));
	PlayerTextDrawShow(playerid, TD_CapturePoint[playerid]);
	return 1;
}

static DestroyPlayerPointCapture(playerid)
{
	if (PlayerCapturePointID[playerid] == -1) {
		return 0;
	}

	DestroyPlayerProgressBar(playerid, CapturePointBar[playerid]);
	DestroyPlayerTD(playerid, TD_CapturePoint[playerid]);

	PlayerCapturePointID[playerid] = -1;
	return 1;
}

stock TDM_GetGangZonePlayer(playerid, &pointid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	foreach (new g:TDM_CapturePointCount[sessionid]) {
		if (CapturePointInfo[sessionid][g][e_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) {
			continue;
		}

		if (CapturePointInfo[sessionid][g][e_Interior] != GetPlayerInteriorEx(playerid)) {
			continue;
		}

		if (!IsPlayerInDynamicArea(playerid, CapturePointInfo[sessionid][g][e_Sphere])) {
			continue;
		}

		pointid = g;
	}
	return 1;
}

stock TDM_SetCameraCapturePoint(sessionid, cell, Float:x, Float:y, Float:z, Float:x2, Float:y2, Float:z2)
{
	CameraCapturePointPos[sessionid][cell][0][0] = x;
	CameraCapturePointPos[sessionid][cell][0][1] = y;
	CameraCapturePointPos[sessionid][cell][0][2] = z;

	CameraCapturePointPos[sessionid][cell][1][0] = x2;
	CameraCapturePointPos[sessionid][cell][1][1] = y2;
	CameraCapturePointPos[sessionid][cell][1][2] = z2;
	return 1;
}

stock TDM_SetSpawnCapturePoint(sessionid, cell, cell2, Float:x, Float:y, Float:z)
{
	SpawnCapturePointPos[sessionid][cell][cell2][0] = x;
	SpawnCapturePointPos[sessionid][cell][cell2][1] = y;
	SpawnCapturePointPos[sessionid][cell][cell2][2] = z;
	return 1;
}

stock TDM_LocGetCapturePointSpawn(sessionid, pointid, randomPos, &Float:X, &Float:Y, &Float:Z)
{
	X = SpawnCapturePointPos[sessionid][pointid][randomPos][0];
	Y = SpawnCapturePointPos[sessionid][pointid][randomPos][1];
	Z = SpawnCapturePointPos[sessionid][pointid][randomPos][2];
	return 1;
}

stock TDM_GiveCPTeamScore(sessionid, teamid, num)
{
	CP_TeamScore[sessionid][teamid] += num;
	return 1;
}

stock TDM_ResetCPTeamScore(sessionid, teamid)
{
	CP_TeamScore[sessionid][teamid] = 0;
	return 1;
}

stock TDM_GetCPTeamScore(sessionid, teamid)
{
	return CP_TeamScore[sessionid][teamid];
}

stock TDM_GiveCPTeamMaxScore(sessionid, teamid, num)
{
	CP_TeamMaxScore[sessionid][teamid] += num;
	return 1;
}

stock TDM_ResetCPTeamMaxScore(sessionid, teamid)
{
	CP_TeamMaxScore[sessionid][teamid] = 0;
	return 1;
}

stock TDM_GetCPTeamMaxScore(sessionid, teamid)
{
	return CP_TeamMaxScore[sessionid][teamid];
}

stock TDM_GiveCPPointTeam(sessionid, teamid)
{
	foreach (new g:TDM_CapturePointCount[sessionid]) {
		if (CapturePointInfo[sessionid][g][e_Color] == teamid) {
			TDM_GiveTeamScore(sessionid, teamid, 1);
		}
	}
	return 1;
}

stock TDM_GetCapturePointTeam(sessionid, pointid)
{
	return CapturePointInfo[sessionid][pointid][e_Color];
}

stock TDM_GetCapturePointRed(sessionid, pointid)
{
	return CapturePointInfo[sessionid][pointid][e_Red];
}

stock TDM_GetCapturePointName(sessionid, pointid)
{
	new
		str[TDM_MAX_LEN_CAPT_POINT_NAME];

	strcopy(str, CapturePointInfo[sessionid][pointid][e_Name], TDM_MAX_LEN_CAPT_POINT_NAME);
	return str;
}

stock TDM_CapturePointReInfo(sessionid) 
{
	foreach (new g:TDM_CapturePointCount[sessionid]) {
		new
			team[TDM_MAX_TEAMS];

		foreach (new tt:TDM_ActiveTeams[sessionid]) {
			m_for(MODE_TDM, sessionid, p) {
				if (GetPlayerSpectating(p) != INVALID_PLAYER_ID) {
					continue;
				}

				if (CapturePointInfo[sessionid][g][e_VirtualWorld] != GetPlayerVirtualWorldEx(p)) {
					continue;
				}

				if (CapturePointInfo[sessionid][g][e_Interior] != GetPlayerInteriorEx(p)) {
					continue;
				}

				if (PlayerCapturePointID[p] != g) {
					continue;
				}

				if (GetPlayerTeamEx(p) == tt) {
					team[tt]++;
				}
			}
		}

		new
			mostPlayers,
			winTeam = -1,
			worseTeam = -1,
			bool:draw;

		foreach (new tt:TDM_ActiveTeams[sessionid]) {
			if (tt == TDM_TEAM_NONE) {
				continue;
			}

			if (team[tt] > 0) {
				if (team[tt] >= mostPlayers) {
					if (draw == true) 
						draw = false;

					if (team[tt] == mostPlayers) {
						if (winTeam != -1)
						    draw = true;
					}

					mostPlayers = team[tt];
					winTeam = tt;
				}
				else
					worseTeam = tt;
			}
		}

		if (mostPlayers == 0) {
			if (CapturePointInfo[sessionid][g][e_Color] != TDM_TEAM_NONE) {
				if (CapturePointInfo[sessionid][g][e_Score] < TDM_MAX_SCORE_CAPTURE) {
					CapturePointInfo[sessionid][g][e_Score]++;
					MovePointFlag(sessionid, g, 1);
				}
			}
			else {
				if (CapturePointInfo[sessionid][g][e_Score] > 0) {
					CapturePointInfo[sessionid][g][e_Score]--;
					MovePointFlag(sessionid, g, 2);
				}
				else {
					CapturePointInfo[sessionid][g][e_Color] = TDM_TEAM_NONE;
					CapturePointInfo[sessionid][g][e_Property] = TDM_TEAM_NONE;
					SetPointFlagPos(sessionid, g, 1);
					ChangeColorPointFlag(sessionid, g, TDM_TEAM_NONE);
					TDM_ChangePointCameraForPlayer(sessionid, g);
				}
			}

			if (CapturePointInfo[sessionid][g][e_Red]) {
				CapturePointInfo[sessionid][g][e_Red] = false;
				CapturePointInfo[sessionid][g][e_CaptureTeam] = TDM_TEAM_NONE;
				m_for(MODE_TDM, sessionid, p)
					GangZoneStopFlashForPlayer(p, CapturePointInfo[sessionid][g][e_GangZone]);
			}
		}
		else {
			if (draw) {
				foreach (new tt:TDM_ActiveTeams[sessionid]) {
					if (team[tt] == mostPlayers) {
						if (tt != CapturePointInfo[sessionid][g][e_Color]) {
							m_for(MODE_TDM, sessionid, p)
								GangZoneFlashForPlayer(p, CapturePointInfo[sessionid][g][e_GangZone], TDM_GetTeamColorXB(tt));

							CapturePointInfo[sessionid][g][e_Red] = true;
							CapturePointInfo[sessionid][g][e_CaptureTeam] = tt;
							break;
						}
					}
				}
			}
			else {
				if (worseTeam != -1) {
					if (worseTeam != CapturePointInfo[sessionid][g][e_Color]) {
						if (winTeam == CapturePointInfo[sessionid][g][e_Color]) {
							m_for(MODE_TDM, sessionid, p)
								GangZoneFlashForPlayer(p, CapturePointInfo[sessionid][g][e_GangZone], TDM_GetTeamColorXB(worseTeam));

							CapturePointInfo[sessionid][g][e_Red] = true;
						}
					}
				}
				if (winTeam != -1) {
					if (winTeam != CapturePointInfo[sessionid][g][e_Color]) {
						m_for(MODE_TDM, sessionid, p)
							GangZoneFlashForPlayer(p, CapturePointInfo[sessionid][g][e_GangZone], TDM_GetTeamColorXB(winTeam));

						CapturePointInfo[sessionid][g][e_Red] = true;
						CapturePointInfo[sessionid][g][e_CaptureTeam] = winTeam;

						if (CapturePointInfo[sessionid][g][e_Property] != winTeam) {
							if (CapturePointInfo[sessionid][g][e_Score] > 0) {
								if (team[winTeam] > 1) {
									CapturePointInfo[sessionid][g][e_Score] -= 2;
									MovePointFlag(sessionid, g, 2, true);
								}
								else { 
									CapturePointInfo[sessionid][g][e_Score]--;
									MovePointFlag(sessionid, g, 2);
								}
							}
							if (CapturePointInfo[sessionid][g][e_Score] <= 0) {
								if (CapturePointInfo[sessionid][g][e_Color] != TDM_TEAM_NONE) {
									m_for(MODE_TDM, sessionid, p) {
										GangZoneShowForPlayer(p, CapturePointInfo[sessionid][g][e_GangZone], TDM_GetTeamColorXB(TDM_TEAM_NONE));

										if (GetPlayerSpectating(p) != INVALID_PLAYER_ID) {
											continue;
										}

										if (PlayerCapturePointID[p] != g) {
											continue;
										}

										if (GetPlayerTeamEx(p) != winTeam) { 
											continue;
										}

										GivePlayerReward(p, 150, 50, REWARD_CAPTURE_POINT);
										PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);
									}
								}

								CapturePointInfo[sessionid][g][e_Score] = 0;
								CapturePointInfo[sessionid][g][e_Color] = TDM_TEAM_NONE;
								CapturePointInfo[sessionid][g][e_Property] = winTeam;

								SetPointFlagPos(sessionid, g, 1);
								ChangeColorPointFlag(sessionid, g, winTeam);
								TDM_ChangePointCameraForPlayer(sessionid, g);
							}
						}
						else {
							if (CapturePointInfo[sessionid][g][e_Score] < TDM_MAX_SCORE_CAPTURE) {
								if (team[winTeam] > 1) {
									CapturePointInfo[sessionid][g][e_Score] += 2;
									MovePointFlag(sessionid, g, 1, true);
								}
								else { 
									CapturePointInfo[sessionid][g][e_Score]++;
									MovePointFlag(sessionid, g, 1);
								}
					
								if (CapturePointInfo[sessionid][g][e_Score] >= TDM_MAX_SCORE_CAPTURE) {
									CapturePointInfo[sessionid][g][e_Red] = false;
									CapturePointInfo[sessionid][g][e_Color] = winTeam;
									CapturePointInfo[sessionid][g][e_CaptureTeam] = TDM_TEAM_NONE;
									CapturePointInfo[sessionid][g][e_Score] = TDM_MAX_SCORE_CAPTURE;

									SetPointFlagPos(sessionid, g, 2);
									ChangeColorPointFlag(sessionid, g, winTeam);
									TDM_ChangePointCameraForPlayer(sessionid, g);

									m_for(MODE_TDM, sessionid, p) {
										GangZoneStopFlashForPlayer(p, CapturePointInfo[sessionid][g][e_GangZone]);
										GangZoneShowForPlayer(p, CapturePointInfo[sessionid][g][e_GangZone], TDM_GetTeamColorXB(winTeam));

										if (GetPlayerSpectating(p) != INVALID_PLAYER_ID) {
											continue;
										}

										if (PlayerCapturePointID[p] != g) {
											continue;
										}

										if (GetPlayerTeamEx(p) != winTeam) {
											continue;
										}

										GivePlayerReward(p, 400, 250, REWARD_CAPTURE_POINT);
										PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);

										// Квесты
										CheckPlayerQuestProgress(p, MODE_TDM, 1);
										CheckPlayerQuestProgress(p, MODE_TDM, 10);
										CheckPlayerQuestProgress(p, MODE_TDM, 29);
										//

										CheckPlayerDinaHint(p, 13);
									}
								}
							}
						}
					}
					else {
						if (CapturePointInfo[sessionid][g][e_Score] < TDM_MAX_SCORE_CAPTURE) {
							CapturePointInfo[sessionid][g][e_Score]++;
							MovePointFlag(sessionid, g, 1);
						}
						if (worseTeam == -1) {
							if (CapturePointInfo[sessionid][g][e_Red]) {
								CapturePointInfo[sessionid][g][e_Red] = false;
								CapturePointInfo[sessionid][g][e_CaptureTeam] = TDM_TEAM_NONE;
								m_for(MODE_TDM, sessionid, p) {
									GangZoneStopFlashForPlayer(p, CapturePointInfo[sessionid][g][e_GangZone]);
								}
							}
						}
					}
				}
			}
		}
		new
			str[100];

		if (!CapturePointInfo[sessionid][g][e_Red])
			f(str, "%s[%s] [ %s ]", TDM_GetTeamColor(CapturePointInfo[sessionid][g][e_Color]), GetNamePointABC(g), CapturePointInfo[sessionid][g][e_Name]);
		else
			f(str, "%s[%s] [ %s ]\n\n{D53032}Захватывают %s%s", TDM_GetTeamColor(CapturePointInfo[sessionid][g][e_Color]), GetNamePointABC(g), CapturePointInfo[sessionid][g][e_Name], TDM_GetTeamColor(CapturePointInfo[sessionid][g][e_CaptureTeam]), TDM_GetTeamName(CapturePointInfo[sessionid][g][e_CaptureTeam]));

		UpdateDynamic3DTextLabelText(CapturePointInfo[sessionid][g][e_3DText], 0x000000FF, str);

		m_for(MODE_TDM, sessionid, p) {
			if (PlayerCapturePointID[p] == g) {
				SetPlayerProgressBarColour(p, CapturePointBar[p], TDM_GetTeamColorXB(CapturePointInfo[sessionid][g][e_Property]));
				SetPlayerProgressBarValue(p, CapturePointBar[p], floatround(CapturePointInfo[sessionid][g][e_Score]));
			}
		}
	}
	return 1;
}

/*
 * |>------------<|
 * |   Computer   |
 * |>------------<|
 */

stock TDM_CreateComputer(sessionid, teamid, cell, Float:x, Float:y, Float:z)
{
	new 
		vworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid),
		vint = Mode_GetSessionInterior(MODE_TDM, sessionid);

	PosComputer[sessionid][teamid][cell][0] = x;
	PosComputer[sessionid][teamid][cell][1] = y;
	PosComputer[sessionid][teamid][cell][2] = z;

	ComputerInfo[sessionid][teamid][cell][e_Enabled] = true;
	ComputerInfo[sessionid][teamid][cell][e_ProtectTeam] = teamid;
	ComputerInfo[sessionid][teamid][cell][e_VirtualWorld] = vworld;
	ComputerInfo[sessionid][teamid][cell][e_Interior] = vint;
	ComputerInfo[sessionid][teamid][cell][e_PlayerID] = -1;
	ComputerInfo[sessionid][teamid][cell][e_Status] = teamid;
	ComputerInfo[sessionid][teamid][cell][e_MapIcon] = CreateDynamicMapIcon(x, y, z, 16, 0, vworld, vint, -1, 1000.0, MAPICON_GLOBAL);
	ComputerInfo[sessionid][teamid][cell][e_ObjectSmoke] = CreateDynamicObject(18728, x + 1.0, y, z - 7.0, 0.00000, 0.00000, 0.00000, vworld, vint);
	ComputerInfo[sessionid][teamid][cell][e_3DText] = CreateDynamic3DTextLabel("_", -1, x, y, z + 2.0, 400.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, vworld, vint);
	ComputerInfo[sessionid][teamid][cell][e_3DTextClick] = CreateDynamic3DTextLabel("{10B3EA}Компьютер\n\n{D42C21}Нажмите {E5D110}[ ALT ]", -1, x, y, z, 13.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, vworld, vint);
	return 1;
}

stock TDM_DestroyComputer(sessionid, teamid)
{
	if (teamid != -1) {
		n_for(c, TDM_MAX_COMPUTERS) {
			if (!ComputerInfo[sessionid][teamid][c][e_Enabled]) {
				continue;
			}

			DestroyDynamicObject(ComputerInfo[sessionid][teamid][c][e_ObjectSmoke]);
			DestroyDynamic3DTextLabel(ComputerInfo[sessionid][teamid][c][e_3DText]);
			DestroyDynamic3DTextLabel(ComputerInfo[sessionid][teamid][c][e_3DTextClick]);
			if (!ComputerInfo[sessionid][teamid][c][e_ActiveCapture]) {
				DestroyDynamicMapIcon(ComputerInfo[sessionid][teamid][c][e_MapIcon]);
			}
			TDM_ResetComputer(sessionid, teamid, c);
		}
	}
	else {
		n_for(tt, TDM_MAX_TEAMS) {
			n_for2(c, TDM_MAX_COMPUTERS) {
				if (!ComputerInfo[sessionid][tt][c][e_Enabled]) {
					continue;
				}

				DestroyDynamicObject(ComputerInfo[sessionid][tt][c][e_ObjectSmoke]);
				DestroyDynamic3DTextLabel(ComputerInfo[sessionid][tt][c][e_3DText]);
				DestroyDynamic3DTextLabel(ComputerInfo[sessionid][tt][c][e_3DTextClick]);
				if (!ComputerInfo[sessionid][tt][c][e_ActiveCapture]) {
					DestroyDynamicMapIcon(ComputerInfo[sessionid][tt][c][e_MapIcon]);
				}
				TDM_ResetComputer(sessionid, tt, c);
			}
		}
	}
	return 1;
}

stock TDM_ResetComputer(sessionid, teamid, compid)
{
	if (teamid == -1
	&& compid == -1) {
		n_for(tt, TDM_MAX_TEAMS) {
			n_for2(c, TDM_MAX_COMPUTERS) {
				ComputerInfo[sessionid][tt][c][e_Enabled] =
				ComputerInfo[sessionid][tt][c][e_ActiveCapture] =
				ComputerInfo[sessionid][tt][c][e_Red] = false;
				ComputerInfo[sessionid][tt][c][e_Status] =
				ComputerInfo[sessionid][tt][c][e_Score] =
				ComputerInfo[sessionid][tt][c][e_Timer] =
				ComputerInfo[sessionid][tt][c][e_VirtualWorld] =
				ComputerInfo[sessionid][tt][c][e_Interior] = 0;
				ComputerInfo[sessionid][tt][c][e_ProtectTeam] = TDM_TEAM_NONE;
				ComputerInfo[sessionid][tt][c][e_PlayerID] = -1;
				ComputerInfo[sessionid][tt][c][e_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
				ComputerInfo[sessionid][tt][c][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
				ComputerInfo[sessionid][tt][c][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
				ComputerInfo[sessionid][tt][c][e_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;

				PosComputer[sessionid][tt][c][0] =
				PosComputer[sessionid][tt][c][1] =
				PosComputer[sessionid][tt][c][2] = 0.0;
			}
		}
	}
	else {
		ComputerInfo[sessionid][teamid][compid][e_Enabled] =
		ComputerInfo[sessionid][teamid][compid][e_ActiveCapture] =
		ComputerInfo[sessionid][teamid][compid][e_Red] = false;
		ComputerInfo[sessionid][teamid][compid][e_Status] =
		ComputerInfo[sessionid][teamid][compid][e_Score] =
		ComputerInfo[sessionid][teamid][compid][e_Timer] =
		ComputerInfo[sessionid][teamid][compid][e_VirtualWorld] =
		ComputerInfo[sessionid][teamid][compid][e_Interior] = 0;
		ComputerInfo[sessionid][teamid][compid][e_ProtectTeam] = TDM_TEAM_NONE;
		ComputerInfo[sessionid][teamid][compid][e_PlayerID] = -1;
		ComputerInfo[sessionid][teamid][compid][e_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
		ComputerInfo[sessionid][teamid][compid][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		ComputerInfo[sessionid][teamid][compid][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		ComputerInfo[sessionid][teamid][compid][e_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;

		PosComputer[sessionid][teamid][compid][0] =
		PosComputer[sessionid][teamid][compid][1] =
		PosComputer[sessionid][teamid][compid][2] = 0.0;
	}
	return 1;
}

static CreatePlayerComputer(playerid, teamid, compid) 
{
	if (PlayerComputerID[playerid] != -1) {
		DestroyPlayerComputer(playerid);
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	ComputerInfo[sessionid][teamid][compid][e_Red] = true;
	ComputerInfo[sessionid][teamid][compid][e_PlayerID] = playerid;
	PlayerComputerID[playerid] = compid;
	PlayerComputerTeamID[playerid] = teamid;

	if (ComputerInfo[sessionid][teamid][compid][e_ProtectTeam] != GetPlayerTeamEx(playerid)) {
		ComputerInfo[sessionid][teamid][compid][e_Score] = 0;
	}
	else {
		ComputerInfo[sessionid][teamid][compid][e_Score] = TDM_MAX_SCORE_COMPUTER;
	}

	TDM_CreatePlayerHackCompTD(playerid, TD_HackComputer[playerid]);

	PlayerTextDrawSetString(playerid, TD_HackComputer[playerid], "%s ~w~- Компьютер: ~y~%i", TDM_GetTeamName(teamid), compid + 1);
	PlayerTextDrawColour(playerid, TD_HackComputer[playerid], TDM_GetTeamColorXB(teamid));
	PlayerTextDrawShow(playerid, TD_HackComputer[playerid]);

	HackComputerBar[playerid] = CreatePlayerProgressBar(playerid, 281.00, 250.00, 84.50, 7.19, 0xC7DBFFAA, 10.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarValue(playerid, HackComputerBar[playerid], floatround(ComputerInfo[sessionid][teamid][compid][e_Score]));
	ShowPlayerProgressBar(playerid, HackComputerBar[playerid]);
	return 1;
}

static DestroyPlayerComputer(playerid)
{
	if (PlayerComputerID[playerid] == -1) {
		return 0;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	new 
		c = PlayerComputerID[playerid],
		team = PlayerComputerTeamID[playerid];

	ComputerInfo[sessionid][team][c][e_Red] = false;
	ComputerInfo[sessionid][team][c][e_PlayerID] = -1;

	DestroyPlayerProgressBar(playerid, HackComputerBar[playerid]);
	DestroyPlayerTD(playerid, TD_HackComputer[playerid]);

	PlayerComputerID[playerid] = -1;
	PlayerComputerTeamID[playerid] = TDM_TEAM_NONE;

	if (ComputerInfo[sessionid][team][c][e_ProtectTeam] != GetPlayerTeamEx(playerid)) {
		ComputerInfo[sessionid][team][c][e_Score] = 0;
	}
	else { 
		ComputerInfo[sessionid][team][c][e_Score] = TDM_MAX_SCORE_COMPUTER;
	}
	return 1;
}

stock TDM_GiveCompTeamScore(sessionid, teamid, num)
{
	COMP_TeamScore[sessionid][teamid] += num;
	return 1;
}

stock TDM_ResetCompTeamScore(sessionid, teamid)
{
	COMP_TeamScore[sessionid][teamid] = 0;
	return 1;
}

stock TDM_GetCompTeamScore(sessionid, teamid)
{
	return COMP_TeamScore[sessionid][teamid];
}

stock TDM_GiveCompTeamMaxScore(sessionid, teamid, num)
{
	COMP_TeamMaxScore[sessionid][teamid] += num;
	return 1;
}

stock TDM_ResetCompTeamMaxScore(sessionid, teamid)
{
	COMP_TeamMaxScore[sessionid][teamid] = 0;
	return 1;
}

stock TDM_GetCompTeamMaxScore(sessionid, teamid)
{
	return COMP_TeamMaxScore[sessionid][teamid];
}

stock TDM_ComputerReInfo(sessionid)
{
	n_for(tt, TDM_MAX_TEAMS) {
		n_for2(c, TDM_MAX_COMPUTERS) {
			if (!ComputerInfo[sessionid][tt][c][e_Enabled]) {
				continue;
			}
	
			new
				team = ComputerInfo[sessionid][tt][c][e_ProtectTeam];

			if (!ComputerInfo[sessionid][team][c][e_ActiveCapture]) {
				if (ComputerInfo[sessionid][team][c][e_Status] != ComputerInfo[sessionid][team][c][e_ProtectTeam]) {
					if (ComputerInfo[sessionid][team][c][e_Timer] > 0) {
						ComputerInfo[sessionid][team][c][e_Timer]--;
						if (ComputerInfo[sessionid][team][c][e_Timer] <= 0) {
							COMP_TeamScore[sessionid][team]--;

							new 
								player = ComputerInfo[sessionid][team][c][e_PlayerID];

							if (player > -1) {
								if (PlayerComputerID[player] == c)
									DestroyPlayerComputer(player);
							}
							ComputerInfo[sessionid][team][c][e_Timer] = 0;
							ComputerInfo[sessionid][team][c][e_ActiveCapture] = true;
							ComputerInfo[sessionid][team][c][e_Red] = false;
							ComputerInfo[sessionid][team][c][e_PlayerID] = -1;

							DestroyDynamicMapIcon(ComputerInfo[sessionid][team][c][e_MapIcon]);
							if (COMP_TeamScore[sessionid][team] < (COMP_TeamMaxScore[sessionid][team] - COMP_TeamMaxScore[sessionid][team] + 1)) {
								new 
									str1[30];

								f(str1, "Компьютер (%i) взломан!", c + 1);
								TDM_SetTextTeamMatch(sessionid, str1, team);
							}
							else if (COMP_TeamScore[sessionid][team] == (COMP_TeamMaxScore[sessionid][team] - COMP_TeamMaxScore[sessionid][team] + 1)) 
								TDM_SetTextTeamMatch(sessionid, "Остался последний компьютер!", team);
						}
					}
				}
				new
					string[100];

				if (ComputerInfo[sessionid][team][c][e_Status] != ComputerInfo[sessionid][team][c][e_ProtectTeam]) {
					f(string, "[%i] Компьютер взламывается\nВремя: %i\n\n"CT_WHITE"[%s%s"CT_WHITE"]", c + 1, ComputerInfo[sessionid][team][c][e_Timer], TDM_GetTeamColor(team), TDM_GetTeamName(team));
					UpdateDynamic3DTextLabelText(ComputerInfo[sessionid][team][c][e_3DText], 0xDE2B2BFF, string);
				}
				else {
					f(string, "[%i] Компьютер не взломан\n\n"CT_WHITE"[%s%s"CT_WHITE"]", c + 1, TDM_GetTeamColor(team), TDM_GetTeamName(team));
					UpdateDynamic3DTextLabelText(ComputerInfo[sessionid][team][c][e_3DText], 0x3CDB39FF, string);
				}
			}
			else {
				new
					string[100];

				f(string, "[%i] Компьютер взломан\n\n"CT_WHITE"[%s%s"CT_WHITE"]", c + 1, TDM_GetTeamColor(team), TDM_GetTeamName(team));
				UpdateDynamic3DTextLabelText(ComputerInfo[sessionid][team][c][e_3DText], 0xDE2B2BFF, string);
			}
		}
	}
	return 1;
}

stock TDM_UpdatePlayerComputer(playerid)
{
	if (PlayerComputerID[playerid] == -1)
		return 1;

	new
		sessionid = Mode_GetPlayerSession(playerid);

	new
		c = PlayerComputerID[playerid],
		team = PlayerComputerTeamID[playerid];

	if (IsPlayerInRangeOfPoint(playerid, 1.3, PosComputer[sessionid][team][c][0], PosComputer[sessionid][team][c][1], PosComputer[sessionid][team][c][2])) {
		if (GetPlayerTeamEx(playerid) != ComputerInfo[sessionid][team][c][e_ProtectTeam]) {
			if (ComputerInfo[sessionid][team][c][e_Score] < TDM_MAX_SCORE_COMPUTER) {
				ComputerInfo[sessionid][team][c][e_Score]++;
				SetPlayerProgressBarValue(playerid, HackComputerBar[playerid], floatround(ComputerInfo[sessionid][team][c][e_Score]));

				if (ComputerInfo[sessionid][team][c][e_Score] >= TDM_MAX_SCORE_COMPUTER) {
					DestroyPlayerComputer(playerid);

					ComputerInfo[sessionid][team][c][e_Score] = TDM_MAX_SCORE_COMPUTER;
					ComputerInfo[sessionid][team][c][e_Status] = GetPlayerTeamEx(playerid);
					ComputerInfo[sessionid][team][c][e_Timer] = TDM_MAX_COMPUTER_TIMER;
					ComputerInfo[sessionid][team][c][e_Red] = false;
					ComputerInfo[sessionid][team][c][e_PlayerID] = -1;

					GivePlayerReward(playerid, 300, 200, REWARD_HACK);
					PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

					// Quests
					CheckPlayerQuestProgress(playerid, MODE_TDM, 6);
					CheckPlayerQuestProgress(playerid, MODE_TDM, 16);
					//

					CheckPlayerDinaHint(playerid, 14);

					m_for(MODE_TDM, sessionid, p) {
						if (GetPlayerTeamEx(p) != ComputerInfo[sessionid][team][c][e_ProtectTeam]) {
							continue;
						}

						SCM(p, C_TOMATO, ""T_MATCH" Компьютер [%i] взломали, деактивируйте взлом!", c);
					}
				}
			}
		}
		else {
			if (ComputerInfo[sessionid][team][c][e_Score] > 0) {
				ComputerInfo[sessionid][team][c][e_Score]--;
				SetPlayerProgressBarValue(playerid, HackComputerBar[playerid], floatround(ComputerInfo[sessionid][team][c][e_Score]));

				if (ComputerInfo[sessionid][team][c][e_Score] <= 0) {
					DestroyPlayerComputer(playerid);

					ComputerInfo[sessionid][team][c][e_Score] = 0;
					ComputerInfo[sessionid][team][c][e_Status] = GetPlayerTeamEx(playerid);
					ComputerInfo[sessionid][team][c][e_Timer] = 0;
					ComputerInfo[sessionid][team][c][e_Red] = false;
					ComputerInfo[sessionid][team][c][e_PlayerID] = -1;

					GivePlayerReward(playerid, 300, 200, REWARD_HACK);
					PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

					//Квесты
					CheckPlayerQuestProgress(playerid, MODE_TDM, 6);
					CheckPlayerQuestProgress(playerid, MODE_TDM, 16);
					//

					m_for(MODE_TDM, sessionid, p) {
						if (GetPlayerTeamEx(p) == ComputerInfo[sessionid][team][c][e_ProtectTeam]) {
							continue;
						}

						SCM(p, C_TOMATO, ""T_MATCH" Взлом компьютера [%i] деактивировали!", c);
					}
				}
			}
		}
	}
	else {
		ComputerInfo[sessionid][team][c][e_Red] = false;
		ComputerInfo[sessionid][team][c][e_PlayerID] = -1;

		DestroyPlayerComputer(playerid);
	}
	return 1;
}

/*
 * |>----------------<|
 * |   Capture flag   |
 * |>----------------<|
 */

stock TDM_CreateCaptureFlag(sessionid, teamid, Float:x, Float:y, Float:z)
{
	new 
		vworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid),
		vint = Mode_GetSessionInterior(MODE_TDM, sessionid);

	PosCaptureFlag[sessionid][teamid][0] = x;
	PosCaptureFlag[sessionid][teamid][1] = y;
	PosCaptureFlag[sessionid][teamid][2] = z;
	
	CaptureFlagInfo[sessionid][teamid][e_PlayerID] = -1;
	CaptureFlagInfo[sessionid][teamid][e_VirtualWorld] = vworld;
	CaptureFlagInfo[sessionid][teamid][e_Interior] = vint;

	CaptureFlagInfo[sessionid][teamid][e_Object][0] = CreateDynamicObject(19357, x, y, z - 1.0, 0.00000, 90.00000, 0.00000, vworld, vint);
	CaptureFlagInfo[sessionid][teamid][e_Object][1] = CreateDynamicObject(19357, x, y, z - 1.0, 0.00000, 90.00000, 0.00000, vworld, vint);
	CaptureFlagInfo[sessionid][teamid][e_ObjectFlag] = CreateDynamicObject(2993, x, y, z - 1.0, 0.00000, 0.00000, 0.00000, vworld, vint);
	CaptureFlagInfo[sessionid][teamid][e_MapIcon] = CreateDynamicMapIcon(x, y, z, 53, 0, vworld, vint, -1, 1000.0, MAPICON_GLOBAL);
	CaptureFlagInfo[sessionid][teamid][e_ObjectSmoke] = CreateDynamicObject(18728, x + 1.0, y, z - 7.0, 0.00000, 0.00000, 0.00000, vworld, vint);
	
	new
		str[200];

	f(str, "{10B3EA}Флаг\n"CT_WHITE"[%s%s"CT_WHITE"]\n\n{D42C21}Нажмите {E5D110}[ ALT ]", TDM_GetTeamColor(teamid), TDM_GetTeamName(teamid));
	CaptureFlagInfo[sessionid][teamid][e_3DTextClick] = CreateDynamic3DTextLabel(str, -1, x, y, z, 13.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, vworld, vint);

	Iter_Add(TDM_CaptureFlagCount[sessionid], teamid);
	return 1;
}

stock TDM_DestroyCaptureFlag(sessionid, teamid)
{
	if (teamid != -1) {
		n_for(o, 2) {
			DestroyDynamicObject(CaptureFlagInfo[sessionid][teamid][e_Object][o]);
		}

		if (IsValidDynamicObject(CaptureFlagInfo[sessionid][teamid][e_ObjectFlag])) { 
			DestroyDynamicObject(CaptureFlagInfo[sessionid][teamid][e_ObjectFlag]);
		}

		if (IsValidDynamic3DTextLabel(CaptureFlagInfo[sessionid][teamid][e_3DTextCapture])) {
			DestroyDynamic3DTextLabel(CaptureFlagInfo[sessionid][teamid][e_3DTextCapture]);
		}

		DestroyDynamic3DTextLabel(CaptureFlagInfo[sessionid][teamid][e_3DTextClick]);
		DestroyDynamicObject(CaptureFlagInfo[sessionid][teamid][e_ObjectSmoke]);
		DestroyDynamicMapIcon(CaptureFlagInfo[sessionid][teamid][e_MapIcon]);

		TDM_ResetCaptureFlag(sessionid, teamid);

		Iter_Remove(TDM_CaptureFlagCount[sessionid], teamid);
	}
	else {
		foreach (new tt:TDM_CaptureFlagCount[sessionid]) {
			n_for(o, 2) {
				DestroyDynamicObject(CaptureFlagInfo[sessionid][tt][e_Object][o]);
			}

			if (IsValidDynamicObject(CaptureFlagInfo[sessionid][tt][e_ObjectFlag])) {
				DestroyDynamicObject(CaptureFlagInfo[sessionid][tt][e_ObjectFlag]);
			}

			if (IsValidDynamic3DTextLabel(CaptureFlagInfo[sessionid][tt][e_3DTextCapture])) {
				DestroyDynamic3DTextLabel(CaptureFlagInfo[sessionid][tt][e_3DTextCapture]);
			}

			DestroyDynamic3DTextLabel(CaptureFlagInfo[sessionid][tt][e_3DTextClick]);
			DestroyDynamicObject(CaptureFlagInfo[sessionid][tt][e_ObjectSmoke]);
			DestroyDynamicMapIcon(CaptureFlagInfo[sessionid][tt][e_MapIcon]);

			TDM_ResetCaptureFlag(sessionid, tt);
		}
		Iter_Clear(TDM_CaptureFlagCount[sessionid]);
	}
	return 1;
}

stock TDM_ResetCaptureFlag(sessionid, teamid)
{
	if (teamid == -1) {
		n_for(tt, TDM_MAX_TEAMS) {
			CaptureFlagInfo[sessionid][tt][e_Status] = 0;
			CaptureFlagInfo[sessionid][tt][e_PlayerID] = -1;
			CaptureFlagInfo[sessionid][tt][e_VirtualWorld] =
			CaptureFlagInfo[sessionid][tt][e_Interior] = 0;

			n_for2(o, 2) {
				CaptureFlagInfo[sessionid][tt][e_Object][o] = INVALID_DYNAMIC_OBJECT_ID;
			}

			CaptureFlagInfo[sessionid][tt][e_ObjectFlag] = INVALID_DYNAMIC_OBJECT_ID;
			CaptureFlagInfo[sessionid][tt][e_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
			CaptureFlagInfo[sessionid][tt][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
			CaptureFlagInfo[sessionid][tt][e_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;
			CaptureFlagInfo[sessionid][tt][e_3DTextCapture] = INVALID_DYNAMIC_3D_TEXT_ID;

			PosCaptureFlag[sessionid][tt][0] =
			PosCaptureFlag[sessionid][tt][1] =
			PosCaptureFlag[sessionid][tt][2] = 0.0;
		}
	}
	else {
		CaptureFlagInfo[sessionid][teamid][e_Status] = 0;
		CaptureFlagInfo[sessionid][teamid][e_PlayerID] = -1;
		CaptureFlagInfo[sessionid][teamid][e_VirtualWorld] =
		CaptureFlagInfo[sessionid][teamid][e_Interior] = 0;

		n_for(o, 2) {
			CaptureFlagInfo[sessionid][teamid][e_Object][o] = INVALID_DYNAMIC_OBJECT_ID;
		}

		CaptureFlagInfo[sessionid][teamid][e_ObjectFlag] = INVALID_DYNAMIC_OBJECT_ID;
		CaptureFlagInfo[sessionid][teamid][e_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
		CaptureFlagInfo[sessionid][teamid][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		CaptureFlagInfo[sessionid][teamid][e_3DTextClick] = INVALID_DYNAMIC_3D_TEXT_ID;
		CaptureFlagInfo[sessionid][teamid][e_3DTextCapture] = INVALID_DYNAMIC_3D_TEXT_ID;

		PosCaptureFlag[sessionid][teamid][0] =
		PosCaptureFlag[sessionid][teamid][1] =
		PosCaptureFlag[sessionid][teamid][2] = 0.0;
	}
	return 1;
}

static Create3DTextCaptureFlag(playerid, sessionid, teamid)
{
	new
		str[200];

	f(str, ""CT_WHITE"Флаг захвачен!\n"CT_WHITE"[%s%s"CT_WHITE"]", TDM_GetTeamColor(teamid), TDM_GetTeamName(teamid));
	CaptureFlagInfo[sessionid][teamid][e_3DTextCapture] = CreateDynamic3DTextLabel(str, -1, 0.0, 0.0, 0.0, 3000.0, playerid, INVALID_VEHICLE_ID, 1, CaptureFlagInfo[sessionid][teamid][e_VirtualWorld], CaptureFlagInfo[sessionid][teamid][e_Interior]);
	return 1;
}

static CreatePlayerCaptureFlag(playerid, teamid) 
{
	if (ActionPlayerCaptureFlag[playerid] != -1) {
		DestroyPlayerCaptureFlag(playerid);
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	CaptureFlagInfo[sessionid][teamid][e_Status] = 1;
	CaptureFlagInfo[sessionid][teamid][e_PlayerID] = playerid;
	DestroyDynamicObject(CaptureFlagInfo[sessionid][teamid][e_ObjectFlag]);

	Create3DTextCaptureFlag(playerid, sessionid, teamid);

	ActionPlayerCaptureFlag[playerid] = teamid;
	SetPlayerColor(playerid, 0xcc1d1dBB);
	SetPlayerAttachedObject(playerid, 9, 2993, 1, -0.455999, -0.093999, -0.122999, -95.199981, 84.200012, -0.800000, 1.000000, 1.000000, 1.000000);
	return 1;
}

static DestroyPlayerCaptureFlag(playerid) 
{
	if (ActionPlayerCaptureFlag[playerid] == -1) {
		return 0;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid),
		teamid = ActionPlayerCaptureFlag[playerid];

	CaptureFlagInfo[sessionid][teamid][e_Status] = 0;
	CaptureFlagInfo[sessionid][teamid][e_PlayerID] = -1;
	CaptureFlagInfo[sessionid][teamid][e_ObjectFlag] = CreateDynamicObject(2993, PosCaptureFlag[sessionid][teamid][0], PosCaptureFlag[sessionid][teamid][1], PosCaptureFlag[sessionid][teamid][2] - 1.0, 0.00000, 0.00000, 0.00000, CaptureFlagInfo[sessionid][teamid][e_VirtualWorld], CaptureFlagInfo[sessionid][teamid][e_Interior]);
	DestroyDynamic3DTextLabel(CaptureFlagInfo[sessionid][teamid][e_3DTextCapture]);

	ActionPlayerCaptureFlag[playerid] = -1;
	if (IsPlayerAttachedObjectSlotUsed(playerid, 9)) {
		RemovePlayerAttachedObject(playerid, 9);
	}

	if (GetPlayerInvisible(playerid)) {
		SetPlayerColor(playerid, TDM_GetTeamColorXB(GetPlayerTeamEx(playerid)) & 0xFFFFFF00);
	}
	else {
		SetPlayerColorEx(playerid, TDM_GetTeamColorXB(GetPlayerTeamEx(playerid)));
	}
	return 1;
}

static SpawnCaptureFlag(playerid, type)
{
	if (ActionPlayerCaptureFlag[playerid] == -1) {
		return 0;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid),
		teamid = ActionPlayerCaptureFlag[playerid];

	DestroyPlayerCaptureFlag(playerid);

	switch (type) {
		case 0: {
			TDM_SetTextTeamMatch(sessionid, "Флаг возвращен!", teamid);
		}
		case 1: {
			new 
				playerTeam = GetPlayerTeamEx(playerid);

			GivePlayerReward(playerid, 400, 300, REWARD_CAPTURE_FLAG);
			PlayerPlaySoundEx(playerid, 17802, 0.0, 0.0, 0.0);

			FLAG_TeamScore[sessionid][playerTeam]++;
			TDM_SetTextTeamMatch(sessionid, "Ваша команда получила одно очко!", playerTeam);
			
			// Quests
			CheckPlayerQuestProgress(playerid, MODE_TDM, 7);
			CheckPlayerQuestProgress(playerid, MODE_TDM, 19);
		}
	}
	return 1;
}

stock TDM_GiveFlagTeamScore(sessionid, teamid, num)
{
	FLAG_TeamScore[sessionid][teamid] += num;
	return 1;
}

stock TDM_ResetFlagTeamScore(sessionid, teamid)
{
	FLAG_TeamScore[sessionid][teamid] = 0;
	return 1;
}

stock TDM_GetFlagTeamScore(sessionid, teamid)
{
	return FLAG_TeamScore[sessionid][teamid];
}

stock TDM_GiveFlagTeamMaxScore(sessionid, teamid, num)
{
	FLAG_TeamMaxScore[sessionid][teamid] += num;
	return 1;
}

stock TDM_ResetFlagTeamMaxScore(sessionid, teamid)
{
	FLAG_TeamMaxScore[sessionid][teamid] = 0;
	return 1;
}

stock TDM_GetFlagTeamMaxScore(sessionid, teamid)
{
	return FLAG_TeamMaxScore[sessionid][teamid];
}

/*
 * |>----------<|
 * |   Battle   |
 * |>----------<|
 */

stock TDM_GiveBattleTeamScore(sessionid, teamid, num)
{
	BATTLE_TeamScore[sessionid][teamid] += num;
	return 1;
}

stock TDM_ResetBattleTeamScore(sessionid, teamid)
{
	BATTLE_TeamScore[sessionid][teamid] = 0;
	return 1;
}

stock TDM_GetBattleTeamScore(sessionid, teamid)
{
	return BATTLE_TeamScore[sessionid][teamid];
}

stock TDM_GiveBattleTeamMaxScore(sessionid, teamid, num)
{
	BATTLE_TeamMaxScore[sessionid][teamid] += num;
	return 1;
}

stock TDM_ResetBattleTeamMaxScore(sessionid, teamid)
{
	BATTLE_TeamMaxScore[sessionid][teamid] = 0;
	return 1;
}

stock TDM_GetBattleTeamMaxScore(sessionid, teamid)
{
	return BATTLE_TeamMaxScore[sessionid][teamid];
}

/*
 * |>-------------<|
 * |   Bag money   |
 * |>-------------<|
 */

stock TDM_CreateBagMoney(sessionid, teamid, Float:x, Float:y, Float:z, virtualworld = -1, interior = -1)
{
	if (virtualworld == -1) {
		virtualworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	}
	if (interior == -1) {
		interior = Mode_GetSessionInterior(MODE_TDM, sessionid);
	}

	PosBagMoney[sessionid][teamid][0] = x;
	PosBagMoney[sessionid][teamid][1] = y;
	PosBagMoney[sessionid][teamid][2] = z;
	
	BagMoneyInfo[sessionid][teamid][e_Team] = teamid;
	BagMoneyInfo[sessionid][teamid][e_VirtualWorld] = virtualworld;
	BagMoneyInfo[sessionid][teamid][e_Interior] = interior;

	BagMoneyInfo[sessionid][teamid][e_MapIcon] = CreateDynamicMapIcon(x, y, z, 52, 0, virtualworld, interior, -1, 5000.0, MAPICON_GLOBAL);
	BagMoneyInfo[sessionid][teamid][e_Pickup] = CreateDynamicPickup(1550, 1, x, y, z, virtualworld, interior);

	new
		str[200];

	f(str, "{10B3EA}Мешок денег\n"CT_WHITE"[%s%s"CT_WHITE"]\n\n{D42C21}Нажмите {E5D110}[ N ]", TDM_GetTeamColor(teamid), TDM_GetTeamName(teamid));
	BagMoneyInfo[sessionid][teamid][e_3DText] = CreateDynamic3DTextLabel(str, -1, x, y, z, 9.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, virtualworld, interior);

	Iter_Add(TDM_BagMoneyCount[sessionid], teamid);
	return 1;
}

stock TDM_DestroyBagMoney(sessionid, teamid)
{
	if (teamid != -1) {
		DestroyDynamicMapIcon(BagMoneyInfo[sessionid][teamid][e_MapIcon]);
		DestroyDynamicPickup(BagMoneyInfo[sessionid][teamid][e_Pickup]);
		DestroyDynamic3DTextLabel(BagMoneyInfo[sessionid][teamid][e_3DText]);

		TDM_ResetBagMoney(sessionid, teamid);
		
		Iter_Remove(TDM_BagMoneyCount[sessionid], teamid);
	}
	else {
		foreach (new tt:TDM_BagMoneyCount[sessionid]) {
			DestroyDynamicMapIcon(BagMoneyInfo[sessionid][tt][e_MapIcon]);
			DestroyDynamicPickup(BagMoneyInfo[sessionid][tt][e_Pickup]);
			DestroyDynamic3DTextLabel(BagMoneyInfo[sessionid][tt][e_3DText]);

			TDM_ResetBagMoney(sessionid, tt);
		}
		Iter_Clear(TDM_BagMoneyCount[sessionid]);
	}
	return 1;
}

stock TDM_ResetBagMoney(sessionid, teamid)
{
	if (teamid == -1) {
		n_for(i, TDM_MAX_TEAMS) {
			BagMoneyInfo[sessionid][i][e_Team] = TDM_TEAM_NONE;
			BagMoneyInfo[sessionid][i][e_VirtualWorld] =
			BagMoneyInfo[sessionid][i][e_Interior] = 0;
			BagMoneyInfo[sessionid][i][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
			BagMoneyInfo[sessionid][i][e_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
			BagMoneyInfo[sessionid][i][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

			PosBagMoney[sessionid][i][0] =
			PosBagMoney[sessionid][i][1] =
			PosBagMoney[sessionid][i][2] = 0.0;
		}
	}
	else {
		BagMoneyInfo[sessionid][teamid][e_Team] = TDM_TEAM_NONE;
		BagMoneyInfo[sessionid][teamid][e_VirtualWorld] =
		BagMoneyInfo[sessionid][teamid][e_Interior] = 0;
		BagMoneyInfo[sessionid][teamid][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		BagMoneyInfo[sessionid][teamid][e_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
		BagMoneyInfo[sessionid][teamid][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

		PosBagMoney[sessionid][teamid][0] =
		PosBagMoney[sessionid][teamid][1] =
		PosBagMoney[sessionid][teamid][2] = 0.0;
	}
	return 1;
}

stock TDM_GetBagMoney(sessionid)
{
	return Iter_Count(TDM_BagMoneyCount[sessionid]);
}

stock TDM_SetPlayerBagMoney(playerid, bool:type)
{
	PlayerActiveMoneyBag{playerid} = type;
	return 1;
}

stock TDM_GetPlayerBagMoney(playerid)
{
	return PlayerActiveMoneyBag{playerid};
}

/*
 * |>-------------<|
 * |   Shop team   |
 * |>-------------<|
 */

stock TDM_CreateShopTeam(sessionid, teamid, Float:x, Float:y, Float:z, virtualworld = -1, interior = -1)
{
	if (virtualworld == -1) {
		virtualworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid);
	}
	if (interior == -1) {
		interior = Mode_GetSessionInterior(MODE_TDM, sessionid);
	}

	PosShop[sessionid][teamid][0] = x;
	PosShop[sessionid][teamid][1] = y;
	PosShop[sessionid][teamid][2] = z;
	
	TDM_ShopTeam[sessionid][teamid][e_Team] = teamid;
	TDM_ShopTeam[sessionid][teamid][e_VirtualWorld] = virtualworld;
	TDM_ShopTeam[sessionid][teamid][e_Interior] = interior;

	TDM_ShopTeam[sessionid][teamid][e_Pickup] = CreateDynamicPickup(2358, 23, x, y, z, virtualworld, interior);
	TDM_ShopTeam[sessionid][teamid][e_MapIcon] = CreateDynamicMapIcon(x, y, z, 18, 0, virtualworld, interior, -1, 300.0, MAPICON_LOCAL);
	TDM_ShopTeam[sessionid][teamid][e_ObjectSmoke] = CreateDynamicObject(18728, x + 0.5, y, z - 7.0, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	TDM_ShopTeam[sessionid][teamid][e_3DText] = CreateDynamic3DTextLabel("{10B3EA}Магазин\n\n{D42C21}Нажмите {E5D110}[ N ]", -1, x, y, z, 17.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, virtualworld, interior);

	n_for(i, TDM_SHOP_MAX_ITEMS) {
		PriceShopTeam[sessionid][teamid][i][e_ItemID] = PriceShopInfo[i][e_ItemID];
		PriceShopTeam[sessionid][teamid][i][e_Count] = PriceShopInfo[i][e_Count];
		PriceShopTeam[sessionid][teamid][i][e_Price] = PriceShopInfo[i][e_Price];
	}
	RebateShopTeam[sessionid][teamid] = 0;
	
	Iter_Add(TDM_ShopCount[sessionid], teamid);
	return 1;
}

stock TDM_DestroyShopTeam(sessionid, teamid)
{
	if (teamid != -1) {
		DestroyDynamicPickup(TDM_ShopTeam[sessionid][teamid][e_Pickup]);
		DestroyDynamicMapIcon(TDM_ShopTeam[sessionid][teamid][e_MapIcon]);
		DestroyDynamicObject(TDM_ShopTeam[sessionid][teamid][e_ObjectSmoke]);
		DestroyDynamic3DTextLabel(TDM_ShopTeam[sessionid][teamid][e_3DText]);

		TDM_ResetShopTeam(sessionid, teamid);
		
		Iter_Remove(TDM_ShopCount[sessionid], teamid);
	}
	else {
		foreach (new tt:TDM_ShopCount[sessionid]) {
			DestroyDynamicPickup(TDM_ShopTeam[sessionid][tt][e_Pickup]);
			DestroyDynamicMapIcon(TDM_ShopTeam[sessionid][tt][e_MapIcon]);
			DestroyDynamicObject(TDM_ShopTeam[sessionid][tt][e_ObjectSmoke]);
			DestroyDynamic3DTextLabel(TDM_ShopTeam[sessionid][tt][e_3DText]);

			TDM_ResetShopTeam(sessionid, tt);
		}
		Iter_Clear(TDM_ShopCount[sessionid]);
	}
	return 1;
}

stock TDM_ResetShopTeam(sessionid, teamid)
{
	if (teamid == -1) {
		n_for(tt, TDM_MAX_TEAMS) {
			TDM_ShopTeam[sessionid][tt][e_Team] = TDM_TEAM_NONE;
			TDM_ShopTeam[sessionid][tt][e_VirtualWorld] =
			TDM_ShopTeam[sessionid][tt][e_Interior] = 0;
			TDM_ShopTeam[sessionid][tt][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
			TDM_ShopTeam[sessionid][tt][e_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
			TDM_ShopTeam[sessionid][tt][e_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
			TDM_ShopTeam[sessionid][tt][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

			n_for2(i, TDM_SHOP_MAX_ITEMS) {
				PriceShopTeam[sessionid][tt][i][e_ItemID] =
				PriceShopTeam[sessionid][tt][i][e_Count] =
				PriceShopTeam[sessionid][tt][i][e_Price] = 0;
			}
			RebateShopTeam[sessionid][tt] = 0;

			PosShop[sessionid][tt][0] =
			PosShop[sessionid][tt][1] =
			PosShop[sessionid][tt][2] = 0.0;
		}
	}
	else {
		TDM_ShopTeam[sessionid][teamid][e_Team] = TDM_TEAM_NONE;
		TDM_ShopTeam[sessionid][teamid][e_VirtualWorld] =
		TDM_ShopTeam[sessionid][teamid][e_Interior] = 0;
		TDM_ShopTeam[sessionid][teamid][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
		TDM_ShopTeam[sessionid][teamid][e_Pickup] = INVALID_DYNAMIC_PICKUP_ID;
		TDM_ShopTeam[sessionid][teamid][e_ObjectSmoke] = INVALID_DYNAMIC_OBJECT_ID;
		TDM_ShopTeam[sessionid][teamid][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

		n_for(i, TDM_SHOP_MAX_ITEMS) {
			PriceShopTeam[sessionid][teamid][i][e_ItemID] =
			PriceShopTeam[sessionid][teamid][i][e_Count] =
			PriceShopTeam[sessionid][teamid][i][e_Price] = 0;
		}
		RebateShopTeam[sessionid][teamid] = 0;

		PosShop[sessionid][teamid][0] =
		PosShop[sessionid][teamid][1] =
		PosShop[sessionid][teamid][2] = 0.0;
	}
	return 1;
}

static GiveShopTeamRebatePrice(sessionid, teamid)
{
	RebateShopTeam[sessionid][teamid]++;

	n_for(i, TDM_SHOP_MAX_ITEMS) {
		PriceShopTeam[sessionid][teamid][i][e_Price] = PriceShopTeam[sessionid][teamid][i][e_Price] / 2;
	}
	return 1;
}

stock TDM_GetShopTeams(sessionid)
{
	return Iter_Count(TDM_ShopCount[sessionid]);
}

/*
 * |>--------------<|
 * |   Fast point   |
 * |>--------------<|
 */

stock TDM_CreateFastPoint(sessionid, Float:x, Float:y, Float:z)
{
	if (FastPointInfo[sessionid][e_Status] > 0) {
		TDM_DestroyFastPoint(sessionid);
	}

	new
		vworld = Mode_GetSessionVirtualWorld(MODE_TDM, sessionid),
		vint = Mode_GetSessionInterior(MODE_TDM, sessionid);

	FastPointInfo[sessionid][e_PosX] = x;
	FastPointInfo[sessionid][e_PosY] = y;
	FastPointInfo[sessionid][e_PosZ] = z;

	FastPointInfo[sessionid][e_Status] = 1;
	FastPointInfo[sessionid][e_VirtualWorld] = vworld;
	FastPointInfo[sessionid][e_Interior] = vint;

	FastPointInfo[sessionid][e_Sphere] = CreateDynamicSphere(x, y, z, 10.0, vworld, vint);
	FastPointInfo[sessionid][e_MapIcon] = CreateDynamicMapIcon(x, y, z, 20, 0, vworld, vint, -1, 5000.0, MAPICON_GLOBAL);

	SetAirFastPoint(sessionid, x, y, z, vworld, vint);

	m_for(MODE_TDM, sessionid, p) {
		SCM(p, C_EMERLAND, ""T_MATCH" Появилась временная точка захвата!");
	}
	return 1;
}

stock TDM_DestroyFastPoint(sessionid, all = 0)
{
	if (FastPointInfo[sessionid][e_Status] == 0) {
		return 1;
	}

	DestroyAirFastPoint(sessionid);

	n_for(i, 8) {
		if (IsValidDynamicObject(FastPointInfo[sessionid][e_Object][i])) {
			DestroyDynamicObject(FastPointInfo[sessionid][e_Object][i]);
		}
	}

	if (IsValidDynamic3DTextLabel(FastPointInfo[sessionid][e_3DText])) {
		DestroyDynamic3DTextLabel(FastPointInfo[sessionid][e_3DText]);
	}

	DestroyDynamicArea(FastPointInfo[sessionid][e_Sphere]);
	DestroyDynamicMapIcon(FastPointInfo[sessionid][e_MapIcon]);

	TDM_ResetFastPoint(sessionid, all);
	return 1;
}

stock TDM_ResetFastPoint(sessionid, all)
{
	if (all == -1) {
		ActiveFastPoint[sessionid] = false;
		n_for(i, sizeof(PosFastPoint[])) {
			PosFastPoint[sessionid][i][0] =
			PosFastPoint[sessionid][i][1] =
			PosFastPoint[sessionid][i][2] = 0.0;
		}
	}

	FastPointInfo[sessionid][e_Status] =
	FastPointInfo[sessionid][e_Timer] = 0;
	FastPointInfo[sessionid][e_Color] = TDM_TEAM_NONE;
	FastPointInfo[sessionid][e_CaptureTeam] = TDM_TEAM_NONE;
	FastPointInfo[sessionid][e_Red] = false;
	FastPointInfo[sessionid][e_Score] = 0;
	FastPointInfo[sessionid][e_Property] = TDM_TEAM_NONE;
	FastPointInfo[sessionid][e_VirtualWorld] =
	FastPointInfo[sessionid][e_Interior] = 0;

	n_for(i, 8) {
		FastPointInfo[sessionid][e_Object][i] = INVALID_DYNAMIC_OBJECT_ID;
	}

	FastPointInfo[sessionid][e_Sphere] = INVALID_DYNAMIC_AREA_ID;
	FastPointInfo[sessionid][e_MapIcon] = INVALID_DYNAMIC_MAP_ICON_ID;
	FastPointInfo[sessionid][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;

	FastPointInfo[sessionid][e_PosX] =
	FastPointInfo[sessionid][e_PosY] =
	FastPointInfo[sessionid][e_PosZ] = 0.0;
	return 1;
}

stock TDM_CreatePosFastPoint(sessionid, cell, Float:x, Float:y, Float:z)
{
	if (!ActiveFastPoint[sessionid]) {
		ActiveFastPoint[sessionid] = true;
	}

	PosFastPoint[sessionid][cell][0] = x;
	PosFastPoint[sessionid][cell][1] = y;
	PosFastPoint[sessionid][cell][2] = z;
	return 1;
}

stock TDM_GetFastPoint(sessionid)
{
	return ActiveFastPoint[sessionid];
}

stock TDM_StartFastPoint(sessionid)
{
	new
		randomPos = random(sizeof(PosFastPoint[]));

	TDM_CreateFastPoint(sessionid, PosFastPoint[sessionid][randomPos][0], PosFastPoint[sessionid][randomPos][1], PosFastPoint[sessionid][randomPos][2]);
	return 1;
}

stock TDM_FastPointReInfo(sessionid) 
{
	if (FastPointInfo[sessionid][e_Status] <= 1) {
		return 0;
	}

	new
		team[TDM_MAX_TEAMS];

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		m_for(MODE_TDM, sessionid, p) {
			if (GetPlayerSpectating(p) != INVALID_PLAYER_ID) {
				continue;
			}

			if (FastPointInfo[sessionid][e_VirtualWorld] != GetPlayerVirtualWorldEx(p)) {
				continue;
			}

			if (FastPointInfo[sessionid][e_Interior] != GetPlayerInteriorEx(p)) {
				continue;
			}

			if (!PlayerActiveFastPoint{p}) {
				continue;
			}

			if (GetPlayerTeamEx(p) != tt) {
				continue;
			}

			team[tt]++;
		}
	}

	new
		mostPlayers,
		winTeam = -1,
		worseTeam = -1,
		bool:draw;

	foreach (new tt:TDM_ActiveTeams[sessionid]) {
		if (team[tt] > 0) {
			if (team[tt] >= mostPlayers) {
				if (draw) {
					draw = false;
				}

				if (team[tt] == mostPlayers) {
					if (winTeam != -1) {
						draw = true;
					}
				}
				mostPlayers = team[tt];
				winTeam = tt;
			}
			else {
				worseTeam = tt;
			}
		}
	}

	if (mostPlayers == 0) {
		if (FastPointInfo[sessionid][e_Score]) {
			FastPointInfo[sessionid][e_Score]--;
		}
		else {
			if (FastPointInfo[sessionid][e_Property] != TDM_TEAM_NONE) {
				FastPointInfo[sessionid][e_Property] = TDM_TEAM_NONE;
			}
		}

		if (FastPointInfo[sessionid][e_Red]) {
			FastPointInfo[sessionid][e_Red] = false;
			FastPointInfo[sessionid][e_CaptureTeam] = TDM_TEAM_NONE;
		}

		if (FastPointInfo[sessionid][e_Color] == TDM_TEAM_NONE) {
			if (FastPointInfo[sessionid][e_Status] != 2) {
				FastPointInfo[sessionid][e_Status] = 2;
				FastPointInfo[sessionid][e_Timer] += 120;
			}
		}
	}
	else {
		if (draw) {
			foreach (new tt:TDM_ActiveTeams[sessionid]) {
				if (team[tt] == mostPlayers) {
					if (tt != FastPointInfo[sessionid][e_Color]) {
						FastPointInfo[sessionid][e_Red] = true;
						FastPointInfo[sessionid][e_CaptureTeam] = tt;
						break;
					}
				}
			}
		}
		else {
			if (worseTeam != -1) {
				if (worseTeam != FastPointInfo[sessionid][e_Color]) {
					if (winTeam == FastPointInfo[sessionid][e_Color])
						FastPointInfo[sessionid][e_Red] = true;
				}
			}
			if (winTeam != -1) {
				if (winTeam != FastPointInfo[sessionid][e_Color]) {
					FastPointInfo[sessionid][e_Red] = true;
					FastPointInfo[sessionid][e_CaptureTeam] = winTeam;

					if (FastPointInfo[sessionid][e_Property] != winTeam) {
						if (FastPointInfo[sessionid][e_Score] > 0) {
							if (team[winTeam] > 1)
								FastPointInfo[sessionid][e_Score] -= 2;
							else
								FastPointInfo[sessionid][e_Score]--;
						}
						if (FastPointInfo[sessionid][e_Score] <= 0) {
							FastPointInfo[sessionid][e_Score] = 0;
							FastPointInfo[sessionid][e_Property] = winTeam;
						}
					}
					else {
						if (FastPointInfo[sessionid][e_Score] < TDM_MAX_SCORE_FAST_POINT) {
							if (team[winTeam] > 1)
								FastPointInfo[sessionid][e_Score] += 2;
							else
								FastPointInfo[sessionid][e_Score]++;
				
							if (FastPointInfo[sessionid][e_Score] >= TDM_MAX_SCORE_FAST_POINT) {
								FastPointInfo[sessionid][e_Red] = false;
								FastPointInfo[sessionid][e_Color] = winTeam;
								FastPointInfo[sessionid][e_CaptureTeam] = TDM_TEAM_NONE;
								FastPointInfo[sessionid][e_Score] = 0;

								m_for(MODE_TDM, sessionid, p) {
									if (!PlayerActiveFastPoint{p}) {
										continue;
									}

									if (GetPlayerTeamEx(p) != winTeam) {
										continue;
									}

									GivePlayerReward(p, 400, 250, REWARD_CAPTURE_POINT);
									PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);
								}

								FastPointInfo[sessionid][e_Status] = 4;
								FastPointInfo[sessionid][e_Timer] += 40;
							}
						}
					}

					if (FastPointInfo[sessionid][e_Status] != 3
					&& FastPointInfo[sessionid][e_Status] != 4) {
						FastPointInfo[sessionid][e_Status] = 3;
						FastPointInfo[sessionid][e_Timer] = 0;
					}
				}
				else {
					if (FastPointInfo[sessionid][e_Score] > 0) {
						FastPointInfo[sessionid][e_Score]--;
					}

					if (worseTeam == -1) {
						if (FastPointInfo[sessionid][e_Red]) {
							FastPointInfo[sessionid][e_Red] = false;
							FastPointInfo[sessionid][e_CaptureTeam] = TDM_TEAM_NONE;
						}
					}
				}
			}
		}
	}

	static
		sticks[100],
		timerText[50];

	sticks[0] =
	timerText[0] = EOS;

	if (FastPointInfo[sessionid][e_Score] <= 0) {
		f(sticks, "%s", TDM_GetTeamColor(FastPointInfo[sessionid][e_Color]));
		n_for(i, TDM_MAX_SCORE_FAST_POINT) {
			strcat(sticks, "|");
		}
	}
	else {
		new
			i;

		if (FastPointInfo[sessionid][e_Red]) {
			f(sticks, "%s", TDM_GetTeamColor(FastPointInfo[sessionid][e_Property]));
			for (i = 0; i < FastPointInfo[sessionid][e_Score]; i++) {
				strcat(sticks, "|");
			}

			f(sticks, "%s%s", sticks, TDM_GetTeamColor(FastPointInfo[sessionid][e_Color]));
			for (; i < TDM_MAX_SCORE_FAST_POINT; i++) {
				strcat(sticks, "|");
			}
		}
		else {
			f(sticks, "%s", TDM_GetTeamColor(FastPointInfo[sessionid][e_Property]));
			for (i = 0; i < FastPointInfo[sessionid][e_Score]; i++) {
				strcat(sticks, "|");
			}

			f(sticks, "%s%s", sticks, TDM_GetTeamColor(FastPointInfo[sessionid][e_Color]));
			for (; i < TDM_MAX_SCORE_FAST_POINT; i++) {
				strcat(sticks, "|");
			}
		}
	}

	if (FastPointInfo[sessionid][e_Status] == 4) {
		f(timerText, "{26a2eb}Захват: {eb2626}%i {26a2eb}секунд", FastPointInfo[sessionid][e_Timer]);
	}

	static
		str[500];

	str[0] = EOS;

	if (!FastPointInfo[sessionid][e_Red]) {
		f(str, "%sВременная точка\n\n{d6d6d6}[ %s{d6d6d6} ]\n%s", TDM_GetTeamColor(FastPointInfo[sessionid][e_Color]), sticks, timerText);
	}
	else {
		f(str, "%sВременная точка\n{D53032}Захватывают %s%s\n\n{d6d6d6}[ %s{d6d6d6} ]\n%s", 
		TDM_GetTeamColor(FastPointInfo[sessionid][e_Color]), TDM_GetTeamColor(FastPointInfo[sessionid][e_CaptureTeam]), 
		TDM_GetTeamName(FastPointInfo[sessionid][e_CaptureTeam]), sticks, timerText);
	}
	UpdateDynamic3DTextLabelText(FastPointInfo[sessionid][e_3DText], 0xFFFFFFFF, str);

	if (FastPointInfo[sessionid][e_Status] == 2) {
		if (FastPointInfo[sessionid][e_Timer] > 0) {
			FastPointInfo[sessionid][e_Timer]--;

			if (FastPointInfo[sessionid][e_Timer] <= 0) {
				TDM_DestroyFastPoint(sessionid);
			}
		}
	}

	if (FastPointInfo[sessionid][e_Status] == 4) {
		if (FastPointInfo[sessionid][e_Timer] > 0) {
			FastPointInfo[sessionid][e_Timer]--;

			if (FastPointInfo[sessionid][e_Timer] <= 0) {
				if (TDM_GetShopTeams(sessionid)) {
					GiveShopTeamRebatePrice(sessionid, FastPointInfo[sessionid][e_Color]);
				}

				if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE) {
					TDM_GiveTeamScore(sessionid, FastPointInfo[sessionid][e_Color], 30);
				}

				m_for(MODE_TDM, sessionid, p) {
					if (GetPlayerTeamEx(p) != FastPointInfo[sessionid][e_Color]) {
						SCM(p, C_EMERLAND, ""T_MATCH" Враги захватили временную точку!");
						continue;
					}
				
					if (PlayerActiveFastPoint{p}) {
						GivePlayerReward(p, 700, 500, REWARD_CAPTURE_POINT);
						PlayerPlaySoundEx(p, 17802, 0.0, 0.0, 0.0);
					}

					SCM(p, C_EMERLAND, ""T_MATCH" Временная точка была успешно захвачена!");

					if (TDM_GetShopTeams(sessionid)) {
						SCM(p, C_EMERLAND, ""T_MATCH" На базе теперь скидки в магазине!");
					}

					if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE) {
						SCM(p, C_EMERLAND, ""T_MATCH" Прибавлены очки команды!");
					}
				}
				TDM_DestroyFastPoint(sessionid);
			}
		}
	}
	return 1;
}

static IsPlayerReadyCaptureFastPoint(sessionid, playerid)
{
	if (FastPointInfo[sessionid][e_VirtualWorld] == GetPlayerVirtualWorldEx(playerid)
	&& FastPointInfo[sessionid][e_Interior] == GetPlayerInteriorEx(playerid)
	&& !PlayerActiveFastPoint{playerid}
	&& GetPlayerDead(playerid) == PLAYER_DEATH_NONE
	&& !GetAdminSpectating(playerid)) {
		return 1;
	}

	return 0;
}

static CreatePlayerFastPointArea(sessionid, playerid)
{
	if (TDM_GetStatusGame(sessionid) != TDM_GAME_STATUS_GAME) {
		return 0;
	}

	if (FastPointInfo[sessionid][e_Status] <= 1) {
		return 0;
	}

	if (IsPlayerInDynamicArea(playerid, FastPointInfo[sessionid][e_Sphere])) {
		if (IsPlayerReadyCaptureFastPoint(sessionid, playerid)) {
			PlayerActiveFastPoint{playerid} = true;
		}
	}
	return 1;
}

stock TDM_UpdateAirFastPoint(sessionid)
{
	if (FastPointInfo[sessionid][e_Status] == 0) {
		return 0;
	}

	switch (AirFastPointInfo[sessionid][e_Status]) {
		case 1: { // Отстыковка
			new
				Float:ax,
				Float:ay,
				Float:az;

			GetDynamicObjectPos(AirFastPointInfo[sessionid][e_ObjectAir], ax, ay, az);
			if (ay > (AirFastPointInfo[sessionid][e_PosY] - 50.0)) {
				AirFastPointInfo[sessionid][e_Status] = 2;
				new
					Float:bx,
					Float:by,
					Float:bz;

				GetDynamicObjectPos(AirFastPointInfo[sessionid][e_ObjectBox], bx, by, bz);
				StopDynamicObject(AirFastPointInfo[sessionid][e_ObjectBox]);
				MoveDynamicObject(AirFastPointInfo[sessionid][e_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
			}
		}
		case 2: { // Падение к цели
			AirFastPointInfo[sessionid][e_Status] = 3;
			new
				Float:bx,
				Float:by,
				Float:bz;

			GetDynamicObjectPos(AirFastPointInfo[sessionid][e_ObjectBox], bx, by, bz);

			AirFastPointInfo[sessionid][e_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirFastPointInfo[sessionid][e_VirtualWorld], AirFastPointInfo[sessionid][e_Interior]);

			StopDynamicObject(AirFastPointInfo[sessionid][e_ObjectBox]);
			MoveDynamicObject(AirFastPointInfo[sessionid][e_ObjectBox], AirFastPointInfo[sessionid][e_PosX], AirFastPointInfo[sessionid][e_PosY], AirFastPointInfo[sessionid][e_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
			MoveDynamicObject(AirFastPointInfo[sessionid][e_ObjectParachute], AirFastPointInfo[sessionid][e_PosX] + 0.0203, AirFastPointInfo[sessionid][e_PosY] - 0.0138, AirFastPointInfo[sessionid][e_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
			Mode_StreamerUpdate(MODE_TDM, sessionid);
		}
		case 3: { // Остановка у цели
			new
				Float:bx,
				Float:by,
				Float:bz;

			GetDynamicObjectPos(AirFastPointInfo[sessionid][e_ObjectBox], bx, by, bz);
			if ((bx == AirFastPointInfo[sessionid][e_PosX]) 
			&& (by == AirFastPointInfo[sessionid][e_PosY]) 
			&& (bz == AirFastPointInfo[sessionid][e_PosZ] - 0.30000)) {
				FastPointInfo[sessionid][e_Status] = 2;
				FastPointInfo[sessionid][e_Timer] += 150;

				AirFastPointInfo[sessionid][e_Status] = 4;
				AirFastPointInfo[sessionid][e_Timer] += 15;

				DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectParachute]);

				FastPointInfo[sessionid][e_Object][0] = CreateDynamicObject(2061, bx - 0.02, by - 1.0 + 0.05, bz - 0.43,   0.00000, 0.00000, 0.00000, FastPointInfo[sessionid][e_VirtualWorld], FastPointInfo[sessionid][e_Interior]);
				FastPointInfo[sessionid][e_Object][1] = CreateDynamicObject(2061, bx + 1.0 - 0.3, by - 1.0 + 0.03, bz - 0.43,   0.00000, 0.00000, 0.00000, FastPointInfo[sessionid][e_VirtualWorld], FastPointInfo[sessionid][e_Interior]);
				FastPointInfo[sessionid][e_Object][2] = CreateDynamicObject(2041, bx + 1.0 - 0.37, by - 0.4, bz + 1.0 - 0.1,   0.00000, 0.00000, 0.00000, FastPointInfo[sessionid][e_VirtualWorld], FastPointInfo[sessionid][e_Interior]);
				FastPointInfo[sessionid][e_Object][3] = CreateDynamicObject(2041, bx + 1.0 - 0.9, by - 0.6, bz + 1.0 - 0.1,   0.00000, 0.00000, 84.00000, FastPointInfo[sessionid][e_VirtualWorld], FastPointInfo[sessionid][e_Interior]);
				FastPointInfo[sessionid][e_Object][4] = CreateDynamicObject(2041, bx + 1.0 - 0.8, by - 0.3, bz + 1.0 - 0.1,   0.00000, 0.00000, 40.00000, FastPointInfo[sessionid][e_VirtualWorld], FastPointInfo[sessionid][e_Interior]);
				FastPointInfo[sessionid][e_Object][5] = CreateDynamicObject(2042, bx - 0.3, by + 1.0 - 0.7, bz + 1.0 - 0.2,   0.00000, 0.00000, 0.00000, FastPointInfo[sessionid][e_VirtualWorld], FastPointInfo[sessionid][e_Interior]);
				FastPointInfo[sessionid][e_Object][6] = CreateDynamicObject(3015, bx - 0.37, by + 1.0 + 0.1, bz - 1.0 + 0.4,   0.00000, 0.00000, 0.00000, FastPointInfo[sessionid][e_VirtualWorld], FastPointInfo[sessionid][e_Interior]);
				FastPointInfo[sessionid][e_Object][7] = CreateDynamicObject(2358, bx + 1.0 - 0.5, by + 1.0 - 0.5, bz + 1.0 - 0.2,   0.00000, 0.00000, 76.00000, FastPointInfo[sessionid][e_VirtualWorld], FastPointInfo[sessionid][e_Interior]);

				FastPointInfo[sessionid][e_3DText] = CreateDynamic3DTextLabel("_", 0xFFFFFFFF, FastPointInfo[sessionid][e_PosX], FastPointInfo[sessionid][e_PosY], FastPointInfo[sessionid][e_PosZ], 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, FastPointInfo[sessionid][e_VirtualWorld], FastPointInfo[sessionid][e_Interior]);

				//CreateDynamicObject(1685, 62.97323, 2090.74927, 17.44248,   0.00000, 0.00000, 0.00000);

				//CreateDynamicObject(2061, 62.95085, 2089.79175, 17.01131,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(2061, 63.68470, 2089.77759, 17.01130,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(2041, 63.60580, 2090.33545, 18.38450,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(2041, 63.03876, 2090.12012, 18.38450,   0.00000, 0.00000, 84.00000);
				//CreateDynamicObject(2041, 63.15140, 2090.47363, 18.38450,   0.00000, 0.00000, 40.00000);
				//CreateDynamicObject(2042, 62.60100, 2091.02100, 18.27090,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(3015, 62.60590, 2091.87109, 16.82370,   0.00000, 0.00000, 0.00000);
				//CreateDynamicObject(2358, 63.42210, 2091.22803, 18.31040,   0.00000, 0.00000, 76.00000);

				m_for(MODE_TDM, sessionid, p) {
					if (IsPlayerInDynamicArea(p, FastPointInfo[sessionid][e_Sphere])) {
						if (IsPlayerReadyCaptureFastPoint(sessionid, p)) {
							PlayerActiveFastPoint{p} = true;
						}
					}
				}
			}
		}
		case 4: { // Удаление самолёта
			if (AirFastPointInfo[sessionid][e_Timer] > 0) {
				AirFastPointInfo[sessionid][e_Timer]--;
			}
			else {
				AirFastPointInfo[sessionid][e_Status] = 5;
				AirFastPointInfo[sessionid][e_Timer] = 0;
				DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectAir]);
			}
		}
	}
	return 1;
}

/*
 * |>-----------<|
 * |   Vehicle   |
 * |>-----------<|
 */

stock TDM_CreateVehicle(sessionid, teamid, cell, vehicletype, Float:x, Float:y, Float:z, Float:rotation, color1 = -1, color2 = -1, respawn_delay = VEHICLE_RESPAWN_TIME, addsiren = 0)
{
	if (INVALID_VEHICLE_ID == (VehicleID[sessionid][cell] = CreateVehicleEx(vehicletype, x, y, z, rotation, color1, color2, respawn_delay, addsiren))) {
		return 0;
	}

	new
		vehicleid = VehicleID[sessionid][cell];

	SetVehicleMode(vehicleid, MODE_TDM);
	SetVehicleSession(vehicleid, sessionid);
	SetVehicleTeam(vehicleid, teamid);

	TDM_VehicleSetSettings(vehicleid);
	return 1;
}

stock TDM_DestroyVehicle(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_VEHICLES) {
			DestroyVehicleEx(VehicleID[sessionid][i]);
			ResetVehicleData(sessionid, i);
		}
	}
	else {
		DestroyVehicleEx(VehicleID[sessionid][cell]);
		ResetVehicleData(sessionid, cell);
	}
	return 1;
}

static ResetVehicleData(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_VEHICLES) {
			VehicleID[sessionid][i] = INVALID_VEHICLE_ID;
		}
	}
	else {
		VehicleID[sessionid][cell] = INVALID_VEHICLE_ID;
	}
	return 1;
}

stock TDM_GetVehicleID(sessionid, cell)
{
	return VehicleID[sessionid][cell];
}

stock TDM_SetActiveVehicle(sessionid, bool:type)
{
	ActiveVehicle[sessionid] = type;
	return 1;
}

stock TDM_GetActiveVehicle(sessionid)
{
	return ActiveVehicle[sessionid];
}

/*
 * |>--------------<|
 * |   Team score   |
 * |>--------------<|
 */

stock TDM_SetTeamScore(sessionid, teamid, score, maxscore)
{
	if (!ActiveTeamScore[sessionid]) {
		ActiveTeamScore[sessionid] = true;
	}

	TDM_GiveTeamModeScore(sessionid, teamid, score);
	TDM_GiveTeamModeMaxScore(sessionid, teamid, maxscore);
	return 1;
}

stock TDM_ResetTeamsScore(sessionid)
{
	ActiveTeamScore[sessionid] = false;

	foreach (new tt:TDM_ActiveTeamsScore[sessionid]) {
		TDM_ResetTeamModeScore(sessionid, tt);
		TDM_ResetTeamModeMaxScore(sessionid, tt);
	}
	return 1;
}

stock TDM_GetTeamsScore(sessionid)
{
	return ActiveTeamScore[sessionid];
}

/*
 * |>-------------<|
 * |   Exit zone   |
 * |>-------------<|
 */

stock TDM_SetExitZonePos(sessionid, Float:minx, Float:miny, Float:maxx, Float:maxy)
{
	ActiveExitZone[sessionid] = true;
	AreaExitZone[sessionid] = CreateDynamicRectangle(minx, miny, maxx, maxy, Mode_GetSessionVirtualWorld(MODE_TDM, sessionid), Mode_GetSessionInterior(MODE_TDM, sessionid));
	return 1;
}

stock TDM_DestroyExitZone(sessionid)
{
	if (IsValidDynamicArea(AreaExitZone[sessionid])) {
		DestroyDynamicArea(AreaExitZone[sessionid]);
	}

	TDM_ResetExitZone(sessionid);
	return 1;
}

stock TDM_GetExitZone(sessionid)
{
	return ActiveExitZone[sessionid];
}

static TDM_ResetExitZone(sessionid)
{
	ActiveExitZone[sessionid] = false;
	AreaExitZone[sessionid] = INVALID_DYNAMIC_AREA_ID;
	return 1;
}

/*
 * |>---------------<|
 * |   TOP players   |
 * |>---------------<|
 */

stock TDM_SetSpawnTopActor(sessionid, cell, Float:X, Float:Y, Float:Z, Float:Angle)
{
	ActorsTopKillsPos[sessionid][cell][0] = X;
	ActorsTopKillsPos[sessionid][cell][1] = Y;
	ActorsTopKillsPos[sessionid][cell][2] = Z;
	ActorsTopKillsPos[sessionid][cell][3] = Angle;
	return 1;
}

stock TDM_GetSpawnTopActor(sessionid, cell, &Float:X, &Float:Y, &Float:Z, &Float:Angle)
{
	X = ActorsTopKillsPos[sessionid][cell][0];
	Y = ActorsTopKillsPos[sessionid][cell][1];
	Z = ActorsTopKillsPos[sessionid][cell][2];
	Angle = ActorsTopKillsPos[sessionid][cell][3];
	return 1;
}

static TDM_ResetSpawnTopActor(sessionid)
{
	n_for(i, sizeof(ActorsTopKillsPos[])) {
		ActorsTopKillsPos[sessionid][i][0] =
		ActorsTopKillsPos[sessionid][i][1] =
		ActorsTopKillsPos[sessionid][i][2] =
		ActorsTopKillsPos[sessionid][i][3] = 0.0;
	}
	return 1;
}

/*
 * |>--------<|
 * |   Airs   |
 * |>--------<|
 */

stock SetAirBomb(sessionid, id, Float:x, Float:y, Float:z, virtualworld, interior) 
{
	n_for(i, TDM_MAX_AIR_BOMB) {
		if (AllAirBomb[sessionid][i] > -1) {
			continue;
		}

		AllAirBomb[sessionid][i] = id;
		break;
	}

	AirBombInfo[sessionid][id][e_Status] = 1;
	AirBombInfo[sessionid][id][e_VirtualWorld] = virtualworld;
	AirBombInfo[sessionid][id][e_Interior] = interior;
	AirBombInfo[sessionid][id][e_PosX] = x;
	AirBombInfo[sessionid][id][e_PosY] = y;
	AirBombInfo[sessionid][id][e_PosZ] = z;

	new
		Float:r = GetAirRandomPos();

	AirBombInfo[sessionid][id][e_ObjectAir] = CreateDynamicObject(10757, x - 1300.00000, y, z + 123.00000 + r, 10.00000, 10.00000, 90.00000, virtualworld, interior);
	MoveDynamicObject(AirBombInfo[sessionid][id][e_ObjectAir], x + 5000.00000, y, z + 123.00000 + r, 60.0, 10.00000, 10.00000, 90.00000);
	Mode_StreamerUpdate(MODE_TDM, sessionid);

	AllAirsBomb[sessionid]++;
	return 1;
}

static ResetAirBomb(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_AIR_BOMB) {
			AirBombInfo[sessionid][i][e_Status] =
			AirBombInfo[sessionid][i][e_Timer] = 0;
			AirBombInfo[sessionid][i][e_PosX] =
			AirBombInfo[sessionid][i][e_PosY] =
			AirBombInfo[sessionid][i][e_PosZ] = 0.0;
			AirBombInfo[sessionid][i][e_VirtualWorld] =
			AirBombInfo[sessionid][i][e_Interior] = 0;
			AirBombInfo[sessionid][i][e_ObjectAir] =
			AirBombInfo[sessionid][i][e_ObjectBomb] = INVALID_DYNAMIC_OBJECT_ID;

			AllAirBomb[sessionid][i] = -1;
		}
		AllAirsBomb[sessionid] = 0;
		AirBombNextPriority[sessionid] = 0;
	}
	else {
		AirBombInfo[sessionid][cell][e_Status] =
		AirBombInfo[sessionid][cell][e_Timer] = 0;
		AirBombInfo[sessionid][cell][e_PosX] =
		AirBombInfo[sessionid][cell][e_PosY] =
		AirBombInfo[sessionid][cell][e_PosZ] = 0.0;
		AirBombInfo[sessionid][cell][e_VirtualWorld] =
		AirBombInfo[sessionid][cell][e_Interior] = 0;
		AirBombInfo[sessionid][cell][e_ObjectAir] =
		AirBombInfo[sessionid][cell][e_ObjectBomb] = INVALID_DYNAMIC_OBJECT_ID;
	}
	return 1;
}

stock SetAirWeapon(sessionid, id, Float:x, Float:y, Float:z, virtualworld, interior) 
{
	n_for(i, TDM_MAX_AIR_WEAPON) {
		if (AllAirWeapon[sessionid][i] > -1) {
			continue;
		}

		AllAirWeapon[sessionid][i] = id;
		break;
	}

	AirWeaponInfo[sessionid][id][e_Status] = 1;
	AirWeaponInfo[sessionid][id][e_Active] = false;
	AirWeaponInfo[sessionid][id][e_Timer] = 0;
	AirWeaponInfo[sessionid][id][e_VirtualWorld] = virtualworld;
	AirWeaponInfo[sessionid][id][e_Interior] = interior;
	AirWeaponInfo[sessionid][id][e_PosX] = x;
	AirWeaponInfo[sessionid][id][e_PosY] = y;
	AirWeaponInfo[sessionid][id][e_PosZ] = z;
	SetRandomAirWeaponAmmo(sessionid, id);

	new
		Float:r = GetAirRandomPos();

	AirWeaponInfo[sessionid][id][e_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirWeaponInfo[sessionid][id][e_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirWeaponInfo[sessionid][id][e_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 50.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirWeaponInfo[sessionid][id][e_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 50.0, 0.00000, 0.00000, 0.00000);
	Mode_StreamerUpdate(MODE_TDM, sessionid);

	AllAirsWeapon[sessionid]++;
	return 1;
}

static ResetAirWeapon(sessionid, cell)
{
	if (cell == -1) {
		n_for(i, TDM_MAX_AIR_WEAPON) {
			AirWeaponInfo[sessionid][i][e_Active] = false;
			AirWeaponInfo[sessionid][i][e_Status] =
			AirWeaponInfo[sessionid][i][e_Timer] =
			AirWeaponInfo[sessionid][i][e_VirtualWorld] =
			AirWeaponInfo[sessionid][i][e_Interior] = 0;
			AirWeaponInfo[sessionid][i][e_PosX] =
			AirWeaponInfo[sessionid][i][e_PosY] =
			AirWeaponInfo[sessionid][i][e_PosZ] = 0.0;

			n_for2(w, TDM_AIR_MAX_WEAPON) {
				AirWeaponInfo[sessionid][i][e_Weapon][w] =
				AirWeaponInfo[sessionid][i][e_Ammo][w] = 0;
			}

			AirWeaponInfo[sessionid][i][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
			AirWeaponInfo[sessionid][i][e_ObjectParachute] =
			AirWeaponInfo[sessionid][i][e_ObjectBox] =
			AirWeaponInfo[sessionid][i][e_ObjectAir] = INVALID_DYNAMIC_OBJECT_ID;

			AllAirWeapon[sessionid][i] = -1;
		}
		AllAirsWeapon[sessionid] = 0;
		AirWeaponNextPriority[sessionid] = 0;
	}
	else {
		AirWeaponInfo[sessionid][cell][e_Active] = false;
		AirWeaponInfo[sessionid][cell][e_Status] =
		AirWeaponInfo[sessionid][cell][e_Timer] =
		AirWeaponInfo[sessionid][cell][e_VirtualWorld] =
		AirWeaponInfo[sessionid][cell][e_Interior] = 0;
		AirWeaponInfo[sessionid][cell][e_PosX] =
		AirWeaponInfo[sessionid][cell][e_PosY] =
		AirWeaponInfo[sessionid][cell][e_PosZ] = 0.0;

		n_for(w, TDM_AIR_MAX_WEAPON) {
			AirWeaponInfo[sessionid][cell][e_Weapon][w] =
			AirWeaponInfo[sessionid][cell][e_Ammo][w] = 0;
		}

		AirWeaponInfo[sessionid][cell][e_3DText] = INVALID_DYNAMIC_3D_TEXT_ID;
		AirWeaponInfo[sessionid][cell][e_ObjectParachute] =
		AirWeaponInfo[sessionid][cell][e_ObjectBox] =
		AirWeaponInfo[sessionid][cell][e_ObjectAir] = INVALID_DYNAMIC_OBJECT_ID;
	}
	return 1;
}

stock Create3DTextAirWeapon(sessionid, id, Float:x, Float:y, Float:z)
{
	new
		string[500],
		boxName[50],
		text[50],
		text2[50],
		text3[50];

	boxName = "Контейнер с оружием";
	text = "Вызвал:";
	text2 = "Неизвестно";
	text3 = "Нажмите";

	f(string, ""TDM_AIR_COLOR_NAME_WEAPON"%s\n\n"CT_WHITE"%s "CT_GREY"%s\n\n{D42C21}%s {E5D110}[ ALT ]", boxName, text, text2, text3);
	AirWeaponInfo[sessionid][id][e_3DText] = CreateDynamic3DTextLabel(string, -1, x, y, z, 11.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, AirWeaponInfo[sessionid][id][e_VirtualWorld], AirWeaponInfo[sessionid][id][e_Interior]);
	return 1;
}

static SetRandomAirWeaponAmmo(sessionid, id)
{
	new
		r1 = random(2);

	switch (r1) {
		case 0: {
			AirWeaponInfo[sessionid][id][e_Weapon][0] = WEAPON_AK47;
			AirWeaponInfo[sessionid][id][e_Ammo][0] = 40;
		}
		case 1: {
			AirWeaponInfo[sessionid][id][e_Weapon][0] = WEAPON_M4;
			AirWeaponInfo[sessionid][id][e_Ammo][0] = 30;
		}
	}

	new
		r2 = random(2);

	switch (r2) {
		case 0: {
			AirWeaponInfo[sessionid][id][e_Weapon][1] = WEAPON_RIFLE;
			AirWeaponInfo[sessionid][id][e_Ammo][1] = 10;
		}
		case 1: {
			AirWeaponInfo[sessionid][id][e_Weapon][1] = WEAPON_SILENCED;
			AirWeaponInfo[sessionid][id][e_Ammo][1] = 20;
		}
	}

	new
		r3 = random(2);

	switch (r3) {
		case 0: {
			AirWeaponInfo[sessionid][id][e_Weapon][2] = WEAPON_MP5;
			AirWeaponInfo[sessionid][id][e_Ammo][2] = 40;
		}
		case 1: {
			AirWeaponInfo[sessionid][id][e_Weapon][2] = WEAPON_SHOTGSPA;
			AirWeaponInfo[sessionid][id][e_Ammo][2] = 15;
		}
	}

	new
		r4 = random(2);

	switch (r4) {
		case 0: {
			AirWeaponInfo[sessionid][id][e_Weapon][3] = WEAPON_TEARGAS;
			AirWeaponInfo[sessionid][id][e_Ammo][3] = 5;
		}
		case 1: {
			AirWeaponInfo[sessionid][id][e_Weapon][3] = WEAPON_GRENADE;
			AirWeaponInfo[sessionid][id][e_Ammo][3] = 3;
		}
	}
	return 1;
}

stock TDM_SetWeaponAirNextPriority(sessionid, num)
{
	if (num > 0)
		AirWeaponNextPriority[sessionid] += num;
	else
		AirWeaponNextPriority[sessionid] = 0;

	return 1;
}

stock TDM_GetWeaponAirBextPriority(sessionid)
{
	return AirWeaponNextPriority[sessionid];
}

stock TDM_SetBombAirNextPriority(sessionid, num)
{
	if (num > 0)
		AirBombNextPriority[sessionid] += num;
	else
		AirBombNextPriority[sessionid] = 0;

	return 1;
}

stock TDM_GetBombAirBextPriority(sessionid)
{
	return AirBombNextPriority[sessionid];
}

stock TDM_SetBombAirs(sessionid)
{
	TDM_SetBombAirNextPriority(sessionid, 1);

	switch (Mode_GetSessionLocation(MODE_TDM, sessionid)) {
		case TDM_LOC_DESERT: TDM_Desert_AirBombTimer(sessionid);
	}
	return 1;
}

stock TDM_SetWeaponAirs(sessionid)
{
	TDM_SetWeaponAirNextPriority(sessionid, 1);

	switch (Mode_GetSessionLocation(MODE_TDM, sessionid)) {
		case TDM_LOC_DESERT: TDM_Desert_AirWeaponTimer(sessionid);
		case TDM_LOC_AIRPORT: TDM_Airport_AirWeaponTimer(sessionid);
	}
	return 1;
}

stock TDM_IsValidAirWeapon(sessionid, airid)
{
	if (AirWeaponInfo[sessionid][airid][e_Status] == 0) {
		return 0;
	}
	return 1;
}

stock TDM_IsValidAirBomb(sessionid, airid)
{
	if (AirBombInfo[sessionid][airid][e_Status] == 0) {
		return 0;
	}
	return 1;
}

stock TDM_SetAirDropWeapon(sessionid, bool:type)
{
	ActiveAirdropWeapon[sessionid] = type;
	return 1;
}

stock TDM_GetAirDropWeapon(sessionid)
{
	return ActiveAirdropWeapon[sessionid];
}

stock TDM_SetAirBomb(sessionid, bool:type)
{
	ActiveAirBomb[sessionid] = type;
	return 1;
}

stock TDM_GetAirBomb(sessionid)
{
	return ActiveAirBomb[sessionid];
}

/*
 * |>------------------<|
 * |   Air Fast point   |
 * |>------------------<|
 */

static SetAirFastPoint(sessionid, Float:x, Float:y, Float:z, virtualworld, interior)
{
	AirFastPointInfo[sessionid][e_Status] = 1;
	AirFastPointInfo[sessionid][e_VirtualWorld] = virtualworld;
	AirFastPointInfo[sessionid][e_Interior] = interior;
	AirFastPointInfo[sessionid][e_PosX] = x;
	AirFastPointInfo[sessionid][e_PosY] = y;
	AirFastPointInfo[sessionid][e_PosZ] = z;

	new 
		Float:r = GetAirRandomPos();

	AirFastPointInfo[sessionid][e_ObjectAir] = CreateDynamicObject(10757, x, y - 1300.00000, z + 105.00000 + r, 10.00000, 10.00000, 900.00000, virtualworld, interior);
	AirFastPointInfo[sessionid][e_ObjectBox] = CreateDynamicObject(1685, x, y - 1300.00000, z + 103.00000 + r, 0.00000, 0.00000, 0.00000, virtualworld, interior);
	MoveDynamicObject(AirFastPointInfo[sessionid][e_ObjectAir], x, y + 5000.00000, z + 105.00000 + r, 70.0, 10.00000, 10.00000, 900.00000);
	MoveDynamicObject(AirFastPointInfo[sessionid][e_ObjectBox], x, y + 5000.00000, z + 103.00000 + r, 70.0, 0.00000, 0.00000, 0.00000);
	Mode_StreamerUpdate(MODE_TDM, sessionid);
	return 1;
}

static DestroyAirFastPoint(sessionid)
{
	m_for(MODE_TDM, sessionid, p) {
		CreateExplosionForPlayer(p, AirFastPointInfo[sessionid][e_PosX], AirFastPointInfo[sessionid][e_PosY], AirFastPointInfo[sessionid][e_PosZ], 13, 1.0);
	}

	switch (AirFastPointInfo[sessionid][e_Status]) {
		case 1, 2: {
			DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectBox]);
			DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectAir]);
		}
		case 3: {
			DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectBox]);
			DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectAir]);
			DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectParachute]);
		}
		case 4: {
			DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectBox]);
			DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectAir]);
		}
		case 5: {
			DestroyDynamicObject(AirFastPointInfo[sessionid][e_ObjectBox]);
		}
	}

	ResetAirFastPoint(sessionid);
	return 1;
}

static ResetAirFastPoint(sessionid)
{
	AirFastPointInfo[sessionid][e_Status] =
	AirFastPointInfo[sessionid][e_Timer] =
	AirFastPointInfo[sessionid][e_VirtualWorld] =
	AirFastPointInfo[sessionid][e_Interior] = 0;
	AirFastPointInfo[sessionid][e_PosX] =
	AirFastPointInfo[sessionid][e_PosY] =
	AirFastPointInfo[sessionid][e_PosZ] = 0.0;

	AirFastPointInfo[sessionid][e_ObjectBox] =
	AirFastPointInfo[sessionid][e_ObjectAir] =
	AirFastPointInfo[sessionid][e_ObjectParachute] = INVALID_DYNAMIC_OBJECT_ID;
	return 1;
}

/*
 * |>---------------------<|
 * |   Player airdrop ID   |
 * |>---------------------<|
 */

stock TDM_SetPlayerIDAirdrop(playerid, airid)
{
	PlayerAirdropIDWeapon[playerid] = airid;
	return 1;
}

stock TDM_GetPlayerIDAirdrop(playerid)
{
	return PlayerAirdropIDWeapon[playerid];
}

/*
 * |>--------------------<|
 * |   Camera end match   |
 * |>--------------------<|
 */

stock TDM_ShowCameraEndLocation(playerid, type)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (type) {
		InterpolateCameraPos(playerid, CameraEndLocationPos[sessionid][0][0], CameraEndLocationPos[sessionid][0][1], CameraEndLocationPos[sessionid][0][2], CameraEndLocationPos[sessionid][1][0], CameraEndLocationPos[sessionid][1][1], CameraEndLocationPos[sessionid][1][2], 7000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPos[sessionid][2][0], CameraEndLocationPos[sessionid][2][1], CameraEndLocationPos[sessionid][2][2], CameraEndLocationPos[sessionid][3][0], CameraEndLocationPos[sessionid][3][1], CameraEndLocationPos[sessionid][3][2], 7000);
	}
	else {
		InterpolateCameraPos(playerid, CameraEndLocationPos[sessionid][1][0], CameraEndLocationPos[sessionid][1][1], CameraEndLocationPos[sessionid][1][2], CameraEndLocationPos[sessionid][1][0], CameraEndLocationPos[sessionid][1][1], CameraEndLocationPos[sessionid][1][2], 1000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPos[sessionid][3][0], CameraEndLocationPos[sessionid][3][1], CameraEndLocationPos[sessionid][3][2], CameraEndLocationPos[sessionid][3][0], CameraEndLocationPos[sessionid][3][1], CameraEndLocationPos[sessionid][3][2], 1000);
	}
	return 1;
}

stock TDM_ShowCameraEndLocationTwo(playerid, type)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (type) {
		InterpolateCameraPos(playerid, CameraEndLocationPos[sessionid][0][0], CameraEndLocationPos[sessionid][0][1], CameraEndLocationPos[sessionid][0][2], CameraEndLocationPosTwo[sessionid][0][0], CameraEndLocationPosTwo[sessionid][0][1], CameraEndLocationPosTwo[sessionid][0][2], 2000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPos[sessionid][2][0], CameraEndLocationPos[sessionid][2][1], CameraEndLocationPos[sessionid][2][2], CameraEndLocationPosTwo[sessionid][1][0], CameraEndLocationPosTwo[sessionid][1][1], CameraEndLocationPosTwo[sessionid][1][2], 2000);
	}
	else {
		InterpolateCameraPos(playerid, CameraEndLocationPosTwo[sessionid][0][0], CameraEndLocationPosTwo[sessionid][0][1], CameraEndLocationPosTwo[sessionid][0][2], CameraEndLocationPosTwo[sessionid][0][0], CameraEndLocationPosTwo[sessionid][0][1], CameraEndLocationPosTwo[sessionid][0][2], 1000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPosTwo[sessionid][1][0], CameraEndLocationPosTwo[sessionid][1][1], CameraEndLocationPosTwo[sessionid][1][2], CameraEndLocationPosTwo[sessionid][1][0], CameraEndLocationPosTwo[sessionid][1][1], CameraEndLocationPosTwo[sessionid][1][2], 1000);
	}
	return 1;
}

stock TDM_ShowCameraEndLocationThree(playerid, type)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (type) {
		InterpolateCameraPos(playerid, CameraEndLocationPosTwo[sessionid][0][0], CameraEndLocationPosTwo[sessionid][0][1], CameraEndLocationPosTwo[sessionid][0][2], CameraEndLocationPos[sessionid][1][0], CameraEndLocationPos[sessionid][1][1], CameraEndLocationPos[sessionid][1][2], 2000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPosTwo[sessionid][1][0], CameraEndLocationPosTwo[sessionid][1][1], CameraEndLocationPosTwo[sessionid][1][2], CameraEndLocationPos[sessionid][3][0], CameraEndLocationPos[sessionid][3][1], CameraEndLocationPos[sessionid][3][2], 2000);
	}
	else {
		InterpolateCameraPos(playerid, CameraEndLocationPos[sessionid][1][0], CameraEndLocationPos[sessionid][1][1], CameraEndLocationPos[sessionid][1][2], CameraEndLocationPos[sessionid][1][0], CameraEndLocationPos[sessionid][1][1], CameraEndLocationPos[sessionid][1][2], 1000);
		InterpolateCameraLookAt(playerid, CameraEndLocationPos[sessionid][3][0], CameraEndLocationPos[sessionid][3][1], CameraEndLocationPos[sessionid][3][2], CameraEndLocationPos[sessionid][3][0], CameraEndLocationPos[sessionid][3][1], CameraEndLocationPos[sessionid][3][2], 1000);
	}
	return 1;
}

stock TDM_SetCameraEndPos(sessionid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraPos от и до
	CameraEndLocationPos[sessionid][0][0] = X;
	CameraEndLocationPos[sessionid][0][1] = Y;
	CameraEndLocationPos[sessionid][0][2] = Z;

	CameraEndLocationPos[sessionid][2][0] = X2;
	CameraEndLocationPos[sessionid][2][1] = Y2;
	CameraEndLocationPos[sessionid][2][2] = Z2;
	return 1;
}

stock TDM_SetCameraEndLookAt(sessionid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraLookAt от и до
	CameraEndLocationPos[sessionid][1][0] = X;
	CameraEndLocationPos[sessionid][1][1] = Y;
	CameraEndLocationPos[sessionid][1][2] = Z;

	CameraEndLocationPos[sessionid][3][0] = X2;
	CameraEndLocationPos[sessionid][3][1] = Y2;
	CameraEndLocationPos[sessionid][3][2] = Z2;
	return 1;
}

stock TDM_SetCameraEndPosTwo(sessionid, Float:X, Float:Y, Float:Z, Float:X2, Float:Y2, Float:Z2)
{
	// InterpolateCameraPos
	CameraEndLocationPosTwo[sessionid][0][0] = X;
	CameraEndLocationPosTwo[sessionid][0][1] = Y;
	CameraEndLocationPosTwo[sessionid][0][2] = Z;

	// InterpolateCameraLookAt
	CameraEndLocationPosTwo[sessionid][1][0] = X2;
	CameraEndLocationPosTwo[sessionid][1][1] = Y2;
	CameraEndLocationPosTwo[sessionid][1][2] = Z2;
	return 1;
}

stock TDM_ResetCameraEndPos(sessionid)
{
	n_for(i, sizeof(CameraEndLocationPos[])) {
		CameraEndLocationPos[sessionid][i][0] =
		CameraEndLocationPos[sessionid][i][1] =
		CameraEndLocationPos[sessionid][i][2] = 0.0;
	}
	n_for(i, sizeof(CameraEndLocationPosTwo[])) {
		CameraEndLocationPosTwo[sessionid][i][0] =
		CameraEndLocationPosTwo[sessionid][i][1] =
		CameraEndLocationPosTwo[sessionid][i][2] = 0.0;
	}
	return 1;
}

/*
 * |>--------------------<|
 * |   Camera base team   |
 * |>--------------------<|
 */

stock TDM_SetPlayerBaseCamera(playerid, teamid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	InterpolateCameraPos(playerid, CameraBaseTeamPos[sessionid][teamid][0][0], CameraBaseTeamPos[sessionid][teamid][0][1], CameraBaseTeamPos[sessionid][teamid][0][2], CameraBaseTeamPos[sessionid][teamid][0][0], CameraBaseTeamPos[sessionid][teamid][0][1], CameraBaseTeamPos[sessionid][teamid][0][2], 1000);
	InterpolateCameraLookAt(playerid, CameraBaseTeamPos[sessionid][teamid][1][0], CameraBaseTeamPos[sessionid][teamid][1][1], CameraBaseTeamPos[sessionid][teamid][1][2], CameraBaseTeamPos[sessionid][teamid][1][0], CameraBaseTeamPos[sessionid][teamid][1][1], CameraBaseTeamPos[sessionid][teamid][1][2], 1000);
	return 1;
}

/*
 * |>------------------------<|
 * |   Camera capture point   |
 * |>------------------------<|
 */

stock TDM_SetPlayerCPointCamera(playerid, pointid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);
	
	InterpolateCameraPos(playerid, CameraCapturePointPos[sessionid][pointid][0][0], CameraCapturePointPos[sessionid][pointid][0][1], CameraCapturePointPos[sessionid][pointid][0][2], CameraCapturePointPos[sessionid][pointid][0][0], CameraCapturePointPos[sessionid][pointid][0][1], CameraCapturePointPos[sessionid][pointid][0][2], 1000);
	InterpolateCameraLookAt(playerid, CameraCapturePointPos[sessionid][pointid][1][0], CameraCapturePointPos[sessionid][pointid][1][1], CameraCapturePointPos[sessionid][pointid][1][2], CameraCapturePointPos[sessionid][pointid][1][0], CameraCapturePointPos[sessionid][pointid][1][1], CameraCapturePointPos[sessionid][pointid][1][2], 1000);
	return 1;
}

/*
 * |>-------------<|
 * |   Mini-game   |
 * |>-------------<|
 */

stock TDM_LocSetPlayerMG(playerid, num, &timer, &count, &value, &ptime)
{
	switch (Mode_GetSessionLocation(MODE_TDM, Mode_GetPlayerSession(playerid))) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlayerMG(playerid, num, timer, count, value, ptime);
	}
	return 1;
}

stock TDM_LocResetPlayerMG(playerid)
{
	switch (Mode_GetSessionLocation(MODE_TDM, Mode_GetPlayerSession(playerid))) {
		case TDM_LOC_DESERT: TDM_Desert_ResetPlayerMG(playerid);
	}
	return 1;
}

stock TDM_LocUpdatePlayerMG(playerid) 
{
	switch (Mode_GetSessionLocation(MODE_TDM, Mode_GetPlayerSession(playerid))) {
		case TDM_LOC_DESERT: TDM_Desert_UpdatePlayerMG(playerid);
	}
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

stock TDM_LocCallPlayerCommand(playerid, const cmdName[], const params[])
{
	#pragma unused params

	if (!strcmp(cmdName, "accode", true)) {
		switch(Mode_GetSessionLocation(MODE_TDM, Mode_GetPlayerSession(playerid))) {
			case TDM_LOC_DESERT: TDM_Desert_CallAccode(playerid);
		}
		return 1;
	}
	return 1;
}

stock TDM_SpawnPlayerElementArea(playerid)
{
	new
		sessionid = Mode_GetPlayerSession(playerid);

	if (TDM_GetStatusGame(sessionid) != TDM_GAME_STATUS_GAME) {
		return 0;
	}

	// Capture point
	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE) {
		new 
			pointid = -1;

		TDM_GetGangZonePlayer(playerid, pointid);

		if (pointid > -1) {
			CreatePlayerPointCapture(playerid, pointid);
		}
	}

	// Exit zone
	if (TDM_GetExitZone(sessionid)) {
		if (IsPlayerInDynamicArea(playerid, AreaExitZone[sessionid])) {
			if (GetPlayerExitZone(playerid)) {
				HidePlayerExitZone(playerid);
			}
		}
		else {
			ShowPlayerExitZone(playerid);
		}
	}

	// Fast point
	if (TDM_GetFastPoint(sessionid)) {
		CreatePlayerFastPointArea(sessionid, playerid);
	}
	return 1;
}

stock TDM_SetPlayerKeyAEPickupDoor(playerid, locationid, pickupid)
{
	switch (locationid) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlayerKeyDPickup(playerid, pickupid);
	}

	TDM_SetPlayerPosAEDoor(playerid, pickupid);
	return 1;
}

stock TDM_SetPlayerKeyAEOtherPickup(playerid, locationid, pickupid)
{
	switch (locationid) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlayerKeyOPickup(playerid, pickupid);
	}
	return 1;
}

stock TDM_SetPlayerKeyAE3DText(playerid, locationid, textid)
{
	switch (locationid) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlayerKey3DText(playerid, textid);
	}
	return 1;
}

stock TDM_UpdateAE(locationid, sessionid)
{
	switch (locationid) {
		case TDM_LOC_DESERT: TDM_Desert_UpdateAE(sessionid);
	}
	return 1;
}

stock TDM_UpdatePlayerAE(playerid)
{
	switch (Mode_GetSessionLocation(MODE_TDM, Mode_GetPlayerSession(playerid))) {
		case TDM_LOC_DESERT: TDM_Desert_UpdatePlayerAE(playerid);
	}
	return 1;
}

stock TDM_VehicleSetSettings(vehicleid)
{
	switch (Mode_GetSessionLocation(MODE_TDM, GetVehicleSession(vehicleid))) {
		case TDM_LOC_DESERT: TDM_Desert_VehSetSettings(vehicleid);
		case TDM_LOC_DESERT2: TDM_Desert2_VehSetSettings(vehicleid);
		case TDM_LOC_AIRPORT: TDM_Airport_VehSetSettings(vehicleid);
		case TDM_LOC_VILLAGE: TDM_Village_VehSetSettings(vehicleid);
		case TDM_LOC_GOLF: TDM_Golf_VehSetSettings(vehicleid);
	}
	return 1;
}

stock TDM_SetPlayerKeyMode3DText(playerid, locationid, p_3dtext, textid)
{
	switch (locationid) {
		case TDM_LOC_DESERT: TDM_Desert_SetPlKeyMode3DText(playerid, p_3dtext, textid);
	}
	return 1;
}

stock TDM_CheckStartFastPoint(sessionid)
{
	if (FastPointInfo[sessionid][e_Status] > 0) {
		return 1;
	}

	switch (Mode_GetSessionLocation(MODE_TDM, sessionid)) {
		case TDM_LOC_DESERT: TDM_Desert_CheckStartFastPoint(sessionid);
	}
	return 1;
}

stock TDM_UpdateAirData(sessionid)
{
	if (AllAirsBomb[sessionid] > 0) {
		r_for(ii, AllAirsBomb[sessionid]) {
			new
				i = AllAirBomb[sessionid][ii];

			switch (AirBombInfo[sessionid][i][e_Status]) {
				case 1: { // Падение к цели
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirBombInfo[sessionid][i][e_ObjectAir], ax, ay, az);
					if (ax > (AirBombInfo[sessionid][i][e_PosX] - 20.0)) {
						AirBombInfo[sessionid][i][e_Status] = 2;
						AirBombInfo[sessionid][i][e_ObjectBomb] = CreateDynamicObject(3786, ax, ay, az, 0.00000, -20.00000, 900.00000, AirBombInfo[sessionid][i][e_VirtualWorld], AirBombInfo[sessionid][i][e_Interior]);
						MoveDynamicObject(AirBombInfo[sessionid][i][e_ObjectBomb], AirBombInfo[sessionid][i][e_PosX], AirBombInfo[sessionid][i][e_PosY], AirBombInfo[sessionid][i][e_PosZ] - 3.0, 60.0, 0.00000, -80.00000, 900.00000);
					}
				}
				case 2: { // После падения
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirBombInfo[sessionid][i][e_ObjectBomb], bx, by, bz);
					if ((bx == AirBombInfo[sessionid][i][e_PosX]) 
					&& (by == AirBombInfo[sessionid][i][e_PosY])
					&& (bz <= AirBombInfo[sessionid][i][e_PosZ])) {
						AirBombInfo[sessionid][i][e_Status] = 3;
						AirBombInfo[sessionid][i][e_Timer] += 30;
						DestroyDynamicObject(AirBombInfo[sessionid][i][e_ObjectBomb]);

						m_for(MODE_TDM, sessionid, p) {
							if (GetPlayerVirtualWorldEx(p) != AirBombInfo[sessionid][i][e_VirtualWorld]) {
								continue;
							}

							if (GetPlayerInteriorEx(p) != AirBombInfo[sessionid][i][e_Interior]) {
								continue;
							}

							CreateExplosionForPlayer(p, bx, by, bz, 6, 15.0);
						}
						Mode_StreamerUpdate(MODE_TDM, sessionid);
					}
				}
				case 3: { // Удаление
					if (AirBombInfo[sessionid][i][e_Timer] > 0) {
						AirBombInfo[sessionid][i][e_Timer]--;
					}
					else {
						DestroyDynamicObject(AirBombInfo[sessionid][i][e_ObjectAir]);

						ResetAirBomb(sessionid, i);

						if (AllAirsBomb[sessionid] > 0) 
							AllAirsBomb[sessionid]--;

						AllAirBomb[sessionid][ii] = AllAirBomb[sessionid][AllAirsBomb[sessionid]];
						AllAirBomb[sessionid][AllAirsBomb[sessionid]] = -1;
					}
				}
			}
		}
	}

	if (AllAirsWeapon[sessionid] > 0) {
		r_for(ii, AllAirsWeapon[sessionid]) {
			new 
				i = AllAirWeapon[sessionid][ii];

			switch (AirWeaponInfo[sessionid][i][e_Status]) {
				case 1: { // Отстыковка
					new
						Float:ax,
						Float:ay,
						Float:az;

					GetDynamicObjectPos(AirWeaponInfo[sessionid][i][e_ObjectAir], ax, ay, az);
					if (ay > (AirWeaponInfo[sessionid][i][e_PosY] - 50.0)) {
						AirWeaponInfo[sessionid][i][e_Status] = 2;
						new
							Float:bx,
							Float:by,
							Float:bz;

						GetDynamicObjectPos(AirWeaponInfo[sessionid][i][e_ObjectBox], bx, by, bz);
						StopDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectBox]);
						MoveDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectBox], bx, by, bz - 12.00000, 20.0, 0.00000, 0.00000, 0.00000);
					}
				}
				case 2: { // Падение к цели
					AirWeaponInfo[sessionid][i][e_Status] = 3;
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirWeaponInfo[sessionid][i][e_ObjectBox], bx, by, bz);

					AirWeaponInfo[sessionid][i][e_ObjectParachute] = CreateDynamicObject(18849, bx + 0.0203, by - 0.0138, bz + 6.9159, 0.00000, 0.00000, 0.00000, AirWeaponInfo[sessionid][i][e_VirtualWorld], AirWeaponInfo[sessionid][i][e_Interior]);

					StopDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectBox]);
					MoveDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectBox], AirWeaponInfo[sessionid][i][e_PosX] - 0.80000, AirWeaponInfo[sessionid][i][e_PosY], AirWeaponInfo[sessionid][i][e_PosZ] - 0.30000, 13.0, 0.00000, 0.00000, 0.00000);
					MoveDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectParachute], AirWeaponInfo[sessionid][i][e_PosX] - 0.80000 + 0.0203, AirWeaponInfo[sessionid][i][e_PosY] - 0.0138, AirWeaponInfo[sessionid][i][e_PosZ] - 0.30000 + 6.9159, 13.0, 0.00000, 0.00000, 0.00000);
					Mode_StreamerUpdate(MODE_TDM, sessionid);
				}
				case 3: { // Остановка у цели
					new
						Float:bx,
						Float:by,
						Float:bz;

					GetDynamicObjectPos(AirWeaponInfo[sessionid][i][e_ObjectBox], bx, by, bz);
					if ((bx == AirWeaponInfo[sessionid][i][e_PosX] - 0.80000) 
					&& (by == AirWeaponInfo[sessionid][i][e_PosY]) 
					&& (bz == AirWeaponInfo[sessionid][i][e_PosZ] - 0.30000)) {
						AirWeaponInfo[sessionid][i][e_Status] = 4;
						AirWeaponInfo[sessionid][i][e_Timer] = TDM_AIR_TIMER_WEAPON;
						AirWeaponInfo[sessionid][i][e_Active] = true;

						DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectParachute]);
	/*
						AirWeapo[sessionid][i][e_ObjectWeapon][0] = CreateDynamicObject(356, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[sessionid][i][e_ObjectWeapon][1] = CreateDynamicObject(2358, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[sessionid][i][e_ObjectWeapon][2] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[sessionid][i][e_ObjectWeapon][3] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[sessionid][i][e_ObjectWeapon][4] = CreateDynamicObject(348, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[sessionid][i][e_ObjectWeapon][5] = CreateDynamicObject(353, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[sessionid][i][e_ObjectWeapon][6] = CreateDynamicObject(3013, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[sessionid][i][e_ObjectWeapon][7] = CreateDynamicObject(342, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AirWeapo[sessionid][i][e_ObjectWeapon][8] = CreateDynamicObject(342, 0.0, 0.0, -500.0, 0.0000, 0.0000, 0.0000);
						AttachDynamicObjectToObject(AirWeaponInfo[sessionid][i][e_ObjectWeapon][8], AirWeaponInfo[sessionid][i][e_ObjectBox], -0.1382, 0.0026, 0.8000, 0.0000, 0.0000, 50.0000, 1);
						AttachDynamicObjectToObject(AirWeaponInfo[sessionid][i][e_ObjectWeapon][7], AirWeaponInfo[sessionid][i][e_ObjectBox], -0.3000, 0.0000, 0.8000, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirWeaponInfo[sessionid][i][e_ObjectWeapon][6], AirWeaponInfo[sessionid][i][e_ObjectBox], 0.5976, 0.5976, 0.8799, 0.0000, 0.0000, 70.0000, 1);
						AttachDynamicObjectToObject(AirWeaponInfo[sessionid][i][e_ObjectWeapon][5], AirWeaponInfo[sessionid][i][e_ObjectBox], -0.4000, 0.4000, 0.7500, 80.0000, 0.0000, 90.0000, 1);
						AttachDynamicObjectToObject(AirWeaponInfo[sessionid][i][e_ObjectWeapon][4], AirWeaponInfo[sessionid][i][e_ObjectBox], 0.1000, -0.1732, 0.7500, 90.0000, 0.0000, 30.0000, 1);
						AttachDynamicObjectToObject(AirWeaponInfo[sessionid][i][e_ObjectWeapon][3], AirWeaponInfo[sessionid][i][e_ObjectBox], -0.0867, 0.4924, 0.8798, 0.0000, 0.0000, 80.0000, 1);
						AttachDynamicObjectToObject(AirWeaponInfo[sessionid][i][e_ObjectWeapon][2], AirWeaponInfo[sessionid][i][e_ObjectBox], 0.5160, -0.3343, 0.8798, 0.0000, 0.0000, -50.0000, 1);
						AttachDynamicObjectToObject(AirWeaponInfo[sessionid][i][e_ObjectWeapon][1], AirWeaponInfo[sessionid][i][e_ObjectBox], -0.4000, -0.5999, 0.8500, 0.0000, 0.0000, 0.0000, 1);
						AttachDynamicObjectToObject(AirWeaponInfo[sessionid][i][e_ObjectWeapon][0], AirWeaponInfo[sessionid][i][e_ObjectBox], -0.5000, -0.3000, 0.8000, 50.0000, 0.0000, 0.0000, 1);
	*/
						Create3DTextAirWeapon(sessionid, i, bx, by, bz);
					}
				}
				case 4: { // Удаление
					if (AirWeaponInfo[sessionid][i][e_Timer] > 0) {
						AirWeaponInfo[sessionid][i][e_Timer]--;
					}
					else {
						DestroyDynamic3DTextLabel(AirWeaponInfo[sessionid][i][e_3DText]);
						DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectBox]);
						DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectAir]);

						//for (new w = 0; w < TDM_AIR_MAX_OBJECT_WEAPON; w++) DestroyDynamicObject(AirWeaponInfo[i][e_ObjectWeapon][w]);

						ResetAirWeapon(sessionid, i);

						if (AllAirsWeapon[sessionid] > 0) 
							AllAirsWeapon[sessionid]--;

						AllAirWeapon[sessionid][ii] = AllAirWeapon[sessionid][AllAirsWeapon[sessionid]];
						AllAirWeapon[sessionid][AllAirsWeapon[sessionid]] = -1;
					}
				}
			}
		}
	}
	
	TDM_UpdateClassesAirdrop(sessionid);

	if (TDM_GetFastPoint(sessionid)) {
		TDM_UpdateAirFastPoint(sessionid);
	}
	return 1;
}

static DeleteAllAir(sessionid)
{
	// Air bomb
	if (AllAirsBomb[sessionid] > 0) {
		n_for(ii, AllAirsBomb[sessionid]) {
			new
				i = AllAirBomb[sessionid][ii];

			switch (AirBombInfo[sessionid][i][e_Status]) {
				case 1, 3: DestroyDynamicObject(AirBombInfo[sessionid][i][e_ObjectAir]);
				case 2: {
					DestroyDynamicObject(AirBombInfo[sessionid][i][e_ObjectAir]);
					DestroyDynamicObject(AirBombInfo[sessionid][i][e_ObjectBomb]);
				}
			}
		}
	}
	ResetAirBomb(sessionid, -1);

	// Air weapon
	if (AllAirsWeapon[sessionid] > 0) {
		n_for(ii, AllAirsWeapon[sessionid]) {
			new 
				i = AllAirWeapon[sessionid][ii];

			switch (AirWeaponInfo[sessionid][i][e_Status]) {
				case 1, 2: {
					DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectBox]);
					DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectAir]);
				}
				case 3: {
					DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectBox]);
					DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectAir]);
					DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectParachute]);
				}
				case 4: {
					DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectBox]);
					DestroyDynamicObject(AirWeaponInfo[sessionid][i][e_ObjectAir]);
				}
			}
			if (AirWeaponInfo[sessionid][i][e_Active])
				DestroyDynamic3DTextLabel(AirWeaponInfo[sessionid][i][e_3DText]);
		}
	}
	ResetAirWeapon(sessionid, -1);

	TDM_DestroyAllClassesAirdrop(sessionid);
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

stock TDM_LocResetSessionData(sessionid)
{
	// Locations
	TDM_Desert_OnGameModeInit(sessionid);

	// Others
	TDM_ResetBaseTeam(sessionid, -1);
	TDM_ResetCapturePoint(sessionid, -1);
	TDM_ResetComputer(sessionid, -1, -1);
	TDM_ResetCaptureFlag(sessionid, -1);
	TDM_ResetBagMoney(sessionid, -1);
	TDM_ResetShopTeam(sessionid, -1);

	TDM_ResetFastPoint(sessionid, -1);
	ResetAirFastPoint(sessionid);

	TDM_ResetAEObject(sessionid, -1);
	TDM_ResetAE3DText(sessionid, -1);
	TDM_ResetAEPickupDoor(sessionid, -1);
	TDM_ResetAEPickupOther(sessionid, -1);
	TDM_ResetAEMapIcon(sessionid, -1);
	TDM_ResetAEActor(sessionid, -1);

	ResetVehicleData(sessionid, -1);
	TDM_ResetExitZone(sessionid);
	TDM_ResetSpawnTopActor(sessionid);
	TDM_ResetCameraEndPos(sessionid);

	ResetAirBomb(sessionid, -1);
	ResetAirWeapon(sessionid, -1);
	return 1;
}

static ResetPlayerData(playerid)
{
	TDM_SetPlayerBagMoney(playerid, false);

	PlayerActiveFastPoint{playerid} = false;

	ActionPlayerCaptureFlag[playerid] =
	PlayerCapturePointID[playerid] =
	PlayerComputerID[playerid] =
	PlayerAirdropIDWeapon[playerid] = -1;

	PlayerComputerTeamID[playerid] = TDM_TEAM_NONE;
}

static ResetPlayerTDs(playerid)
{
	TD_CapturePoint[playerid] = INVALID_PLAYER_TEXT_DRAW;
	TD_HackComputer[playerid] = INVALID_PLAYER_TEXT_DRAW;
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

DialogCreate:TDM_ShopTeam(playerid)
{
	new
		team = GetPlayerTeamEx(playerid),
		sessionid = Mode_GetPlayerSession(playerid);

	static
		strShop[1000],
		strMain[150],
		strRebate[50];

	strShop[0] =
	strMain[0] =
	strRebate[0] = EOS;

	strcat(strShop, "Предмет\tКоличество\tОчков матча");

	n_for(i, TDM_SHOP_MAX_ITEMS) {
		new 
			itemName[50];

		switch (PriceShopTeam[sessionid][team][i][e_ItemID]) {
			case 100: itemName = "Здоровье";
			case 101: itemName = "Броня";
			default: GetWeaponNameRU(WEAPON:PriceShopTeam[sessionid][team][i][e_ItemID], itemName);
		}
		f(strShop, "%s\n"CT_ORANGE""T_NUM" "CT_WHITE"%s\t{EF9A0B}%i\t{d69c1e}%i ОМ", strShop, itemName, PriceShopTeam[sessionid][team][i][e_Count], PriceShopTeam[sessionid][team][i][e_Price]);
	}

	if (RebateShopTeam[sessionid][team]) {
		f(strRebate, "{e36f17}(Скидка x%i!)", RebateShopTeam[sessionid][team] + 1);
	}

	f(strMain, "{17e3d5}Магазин %s", strRebate);
	Dialog_Open(playerid, Dialog:TDM_ShopTeam, DSTH, strMain, strShop, "Купить", "Выход");
	return 1;
}

DialogResponse:TDM_ShopTeam(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	new
		chooseTeam = GetPlayerTeamEx(playerid),
		sessionid = Mode_GetPlayerSession(playerid);

	if (Mode_GetPlayerMatchPoints(playerid) < PriceShopTeam[sessionid][chooseTeam][listitem][e_Price]) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно очков матча.");
	}
	else {
		new
			itemName[100];

		Mode_GivePlayerMatchPoints(playerid, -PriceShopTeam[sessionid][chooseTeam][listitem][e_Price]);
		switch (PriceShopTeam[sessionid][chooseTeam][listitem][e_ItemID]) {
			case 100: {
				itemName = "Здоровье";
				SetPlayerHealthEx(playerid, 100.0);
			}
			case 101: {
				itemName = "Броня";
				SetPlayerArmourEx(playerid, 100.0);
			}
			default: {
				GetWeaponNameRU(WEAPON:PriceShopTeam[sessionid][chooseTeam][listitem][e_ItemID], itemName, sizeof(itemName));
				GivePlayerWeaponEx(playerid, WEAPON:PriceShopTeam[sessionid][chooseTeam][listitem][e_ItemID], PriceShopTeam[sessionid][chooseTeam][listitem][e_Count]);
			}
		}
		SCM(playerid, C_GREEN, ""T_INFO" %s куплен.", itemName);
	}
	Dialog_Show(playerid, Dialog:TDM_ShopTeam);
	return 1;
}

DialogCreate:TDM_AirdropWeapon(playerid)
{
	new
		check,
		airid = GetPVarInt(playerid, "TDM_LocAirID");

	new
		sessionid = Mode_GetPlayerSession(playerid);

	DeletePVar(playerid, "TDM_LocAirID");

	n_for(w, TDM_AIR_MAX_WEAPON) {
		if (AirWeaponInfo[sessionid][airid][e_Weapon][w] > 0) {
			check++;
		}
	}

	if (check > 0) {
		TDM_SetPlayerIDAirdrop(playerid, airid);

		static
			string[1000],
			str[500],
			name[200];

		string[0] = str[0] = name[0] = EOS;

		name = "Оружие\tПатроны\n";
		strcat(string, name);

		n_for(w, TDM_AIR_MAX_WEAPON) {
			if (w != (TDM_AIR_MAX_WEAPON - 1)) {
				if (!AirWeaponInfo[sessionid][airid][e_Weapon][w]) {
					new
						ww = w + 1;

					AirWeaponInfo[sessionid][airid][e_Weapon][w] = AirWeaponInfo[sessionid][airid][e_Weapon][ww];
					AirWeaponInfo[sessionid][airid][e_Ammo][w] = AirWeaponInfo[sessionid][airid][e_Ammo][ww];

					AirWeaponInfo[sessionid][airid][e_Weapon][ww] =
					AirWeaponInfo[sessionid][airid][e_Ammo][ww] = 0;
				}
			}
			if (AirWeaponInfo[sessionid][airid][e_Weapon][w]) {
				new
					weapon[MAX_LENGTH_WEAPON_NAME];

				GetWeaponNameRU(WEAPON:AirWeaponInfo[sessionid][airid][e_Weapon][w], weapon, MAX_LENGTH_WEAPON_NAME);
				f(str, "{C5F9FC}%s\t{DAB767}%i\n", weapon, AirWeaponInfo[sessionid][airid][e_Ammo][w]);
				strcat(string, str);
			}
		}
		Dialog_Open(playerid, Dialog:TDM_AirdropWeapon, DSTH, "Оружие в контейнере", string, "Выбрать", "Назад");
	}
	else {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		Dialog_Message(playerid, "Оружие в контейнере", ""CT_WHITE"\tПусто", "Закрыть");
	}
	return 1;
}

DialogResponse:TDM_AirdropWeapon(playerid, response, listitem, inputtext[])
{
	new
		airid = TDM_GetPlayerIDAirdrop(playerid),
		sessionid = Mode_GetPlayerSession(playerid);

	if (!AirWeaponInfo[sessionid][airid][e_Active]) {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		return 1;
	}

	if (!response) {
		TDM_SetPlayerIDAirdrop(playerid, -1);
		return 1;
	}

	n_for(w, TDM_AIR_MAX_WEAPON) {
		if (listitem != w) {
			continue;
		}

		GivePlayerWeaponEx(playerid, WEAPON:AirWeaponInfo[sessionid][airid][e_Weapon][w], AirWeaponInfo[sessionid][airid][e_Ammo][w]);
		AirWeaponInfo[sessionid][airid][e_Weapon][w] =
		AirWeaponInfo[sessionid][airid][e_Ammo][w] = 0;

		m_for(MODE_TDM, sessionid, p) {
			if (GetPlayerVirtualWorldEx(p) != AirWeaponInfo[sessionid][airid][e_VirtualWorld]) {
				continue;
			}

			if (GetPlayerInteriorEx(p) != AirWeaponInfo[sessionid][airid][e_Interior]) {
				continue;
			}

			if (TDM_GetPlayerIDAirdrop(p) != airid) {
				continue;
			}

			Dialog_Close(p);

			SetPVarInt(p, "TDM_LocAirID", airid);
			Dialog_Show(p, Dialog:TDM_AirdropWeapon);
		}
		break;
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

stock TDM_LocOnGameModeInit()
{
	TDM_InitialLocations();

	Iter_Init(TDM_BaseTeamCount);
	Iter_Init(TDM_CapturePointCount);
	Iter_Init(TDM_CaptureFlagCount);
	Iter_Init(TDM_BagMoneyCount);
	Iter_Init(TDM_ShopCount);
	return 1;
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);
	ResetPlayerTDs(playerid);

	#if defined TDM_LocOnPlayerConnect
		return TDM_LocOnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
 * |>-----------------<|
 * |   OnPlayerDeath   |
 * |>-----------------<|
 */

stock TDM_LocOnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	DestroyPlayerPointCapture(playerid);
	DestroyPlayerComputer(playerid);
	SpawnCaptureFlag(playerid, 0);

	new
		sessionid = Mode_GetPlayerSession(playerid);

	switch (Mode_GetSessionLocation(MODE_TDM, sessionid)) {
		case TDM_LOC_DESERT: TDM_Desert_OnPlayerDeath(playerid, killerid, reason);
	}
	return 1;
}

/*
 * |>-------------------------------<|
 * |   OnPlayerPickUpDynamicPickup   |
 * |>-------------------------------<|
 */

stock TDM_LocOnPlPickUpDynamicPickup(playerid, STREAMER_TAG_PICKUP:pickupid)
{
	if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
		return 0;
	}

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 0;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Pickup door
	n_for(i, AE_TotalNumberPickupsDoor[sessionid]) {
		if (!AE_PickupDoorInfo[sessionid][i][e_Created]) {
			continue;
		}

		if (AE_PickupDoorInfo[sessionid][i][e_TypeClick]) {
			continue;
		}

		if (pickupid == AE_PickupDoorInfo[sessionid][i][e_Pickup]) {
			TDM_SetPlayerKeyAEPickupDoor(playerid, Mode_GetSessionLocation(MODE_TDM, sessionid), i);
			return 1;
		}
	}

	// Pickup other
	n_for(i, AE_TotalNumberOtherPickups[sessionid]) {
		if (!AE_OtherPickupInfo[sessionid][i][e_Created]) {
			continue;
		}

		if (AE_OtherPickupInfo[sessionid][i][e_TypeClick]) {
			continue;
		}

		if (pickupid == AE_OtherPickupInfo[sessionid][i][e_Pickup]) {
			TDM_SetPlayerKeyAEOtherPickup(playerid, Mode_GetSessionLocation(MODE_TDM, sessionid), i);
			return 1;
		}
	}
	return 0;
}

/*
 * |>----------------------------<|
 * |   OnPlayerEnterDynamicArea   |
 * |>----------------------------<|
 */

stock TDM_LocOnPlEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
		return 0;
	}

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 0;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Exit zone
	if (TDM_GetExitZone(sessionid)) {
		if (!TDM_GetPlayerSelectSpawn(playerid)
		&& GetPlayerActionZone(playerid)
		&& !GetPlayerInteriorEx(playerid)) {
			if (areaid == AreaExitZone[sessionid]) {
				if (GetPlayerExitZone(playerid)) {
					HidePlayerExitZone(playerid);
				}
			}
		}
	}

	if (TDM_GetStatusGame(sessionid) != TDM_GAME_STATUS_GAME) {
		return 0;
	}

	// Capture point
	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE) {
		if (PlayerCapturePointID[playerid] == -1
		&& !GetAdminSpectating(playerid)) {
			new 
				pointid = -1;

			foreach (new g:TDM_CapturePointCount[sessionid]) {
				if (CapturePointInfo[sessionid][g][e_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) {
					continue;
				}

				if (CapturePointInfo[sessionid][g][e_Interior] != GetPlayerInteriorEx(playerid)) {
					continue;
				}

				if (areaid != CapturePointInfo[sessionid][g][e_Sphere]) {
					continue;
				}

				pointid = g;
			}

			if (pointid != -1) {
				CreatePlayerPointCapture(playerid, pointid);
			}
		}
	}

	// Fast point
	if (TDM_GetFastPoint(sessionid)) {
		if (FastPointInfo[sessionid][e_Status] > 1) {
			if (areaid == FastPointInfo[sessionid][e_Sphere]) {
				if (IsPlayerReadyCaptureFastPoint(sessionid, playerid)) {
					PlayerActiveFastPoint{playerid} = true;
				}
			}
		}
	}
	return 0;
}

/*
 * |>----------------------------<|
 * |   OnPlayerLeaveDynamicArea   |
 * |>----------------------------<|
 */

stock TDM_LocOnPlLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	if (GetPlayerSpectating(playerid) != INVALID_PLAYER_ID) {
		return 0;
	}

	new
		sessionid = Mode_GetPlayerSession(playerid);

	// Exit zone
	if (TDM_GetExitZone(sessionid)) {
		if (GetPlayerDead(playerid) == PLAYER_DEATH_NONE
		&& !TDM_GetPlayerSelectSpawn(playerid) 
		&& GetPlayerActionZone(playerid)
		&& !GetPlayerInteriorEx(playerid)) {
			if (areaid == AreaExitZone[sessionid]) {
				ShowPlayerExitZone(playerid);
			}
		}
	}

	// Capture point
	if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE) {
		new 
			pointid = -1;

		foreach (new g:TDM_CapturePointCount[sessionid]) {
			if (CapturePointInfo[sessionid][g][e_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) {
				continue;
			}

			if (CapturePointInfo[sessionid][g][e_Interior] != GetPlayerInteriorEx(playerid)) {
				continue;
			}

			if (areaid != CapturePointInfo[sessionid][g][e_Sphere]) {
				continue;
			}

			pointid = g;
		}

		if (pointid != -1) {
			DestroyPlayerPointCapture(playerid);
		}
	}

	// Fast point
	if (TDM_GetFastPoint(sessionid)) {
		if (PlayerActiveFastPoint{playerid}
		&& areaid == FastPointInfo[sessionid][e_Sphere]) {
			PlayerActiveFastPoint{playerid} = false;
		}
	}
	return 0;
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

stock TDM_LocOnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	#pragma unused oldkeys

	new
		sessionid = Mode_GetPlayerSession(playerid),
		returnCallback = 0;

	switch (Mode_GetSessionLocation(MODE_TDM, sessionid)) {
		case TDM_LOC_DESERT: returnCallback = TDM_Desert_OnPlayerKeySC(playerid, newkeys, oldkeys);
	}

	if (returnCallback) {
		return 1;
	}

	// ALT
	if (newkeys & KEY_WALK) {
		// Pickup door
		n_for(i, AE_TotalNumberPickupsDoor[sessionid]) {
			if (!AE_PickupDoorInfo[sessionid][i][e_Created]) {
				continue;
			}

			if (!AE_PickupDoorInfo[sessionid][i][e_TypeClick]) {
				continue;
			}

			if (IsPlayerInRangeOfPoint(playerid, 1.3, AE_PickupDoorInfo[sessionid][i][e_EnterPosX], AE_PickupDoorInfo[sessionid][i][e_EnterPosY], AE_PickupDoorInfo[sessionid][i][e_EnterPosZ])) {
				TDM_SetPlayerKeyAEPickupDoor(playerid, Mode_GetSessionLocation(MODE_TDM, sessionid), i);
				return 1;
			}
		}

		// Pickup others
		n_for(i, AE_TotalNumberOtherPickups[sessionid]) {
			if (!AE_OtherPickupInfo[sessionid][i][e_Created]) {
				continue;
			}

			if (!AE_OtherPickupInfo[sessionid][i][e_TypeClick]) {
				continue;
			}

			if (IsPlayerInRangeOfPoint(playerid, 1.3, AE_OtherPickupInfo[sessionid][i][e_PosX], AE_OtherPickupInfo[sessionid][i][e_PosY], AE_OtherPickupInfo[sessionid][i][e_PosZ])) {
				TDM_SetPlayerKeyAEOtherPickup(playerid, Mode_GetSessionLocation(MODE_TDM, sessionid), i);
				return 1;
			}
		}

		// 3DText
		n_for(i, AE_TotalNumber3DTexts[sessionid]) {
			if (!AE_3DTextInfo[sessionid][i][e_Created]) {
				continue;
			}

			if (!AE_3DTextInfo[sessionid][i][e_TypeClick]) {
				continue;
			}

			if (IsPlayerInRangeOfPoint(playerid, 1.3, AE_3DTextInfo[sessionid][i][e_PosX], AE_3DTextInfo[sessionid][i][e_PosY], AE_3DTextInfo[sessionid][i][e_PosZ])) {
				TDM_SetPlayerKeyAE3DText(playerid, Mode_GetSessionLocation(MODE_TDM, sessionid), i);
				return 1;
			}
		}

		// Airdrop weapon
		if (AllAirsWeapon[sessionid] > 0) {
			n_for(ii, AllAirsWeapon[sessionid]) {
				new
					airid = AllAirWeapon[sessionid][ii];

				if (AirWeaponInfo[sessionid][airid][e_Active]) {
					if (AirWeaponInfo[sessionid][airid][e_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) { 
						continue;
					}

					if (AirWeaponInfo[sessionid][airid][e_Interior] != GetPlayerInteriorEx(playerid)) {
						continue;
					}

					if (IsPlayerInRangeOfPoint(playerid, 3.0, AirWeaponInfo[sessionid][airid][e_PosX], AirWeaponInfo[sessionid][airid][e_PosY], AirWeaponInfo[sessionid][airid][e_PosZ])) {
						SetPVarInt(playerid, "TDM_LocAirID", airid);
						Dialog_Show(playerid, Dialog:TDM_AirdropWeapon);
						return 1;
					}
				}
			}
		}

		// Computer
		if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_SECRET_DATA) {
			n_for(tt, TDM_MAX_TEAMS) {
				n_for2(c, TDM_MAX_COMPUTERS) {
					if (!ComputerInfo[sessionid][tt][c][e_Enabled]) {
						continue;
					}

					new 
						team = ComputerInfo[sessionid][tt][c][e_ProtectTeam];

					if (ComputerInfo[sessionid][team][c][e_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) {
						continue;
					}

					if (ComputerInfo[sessionid][team][c][e_Interior] != GetPlayerInteriorEx(playerid)) {
						continue;
					}

					if (IsPlayerInRangeOfPoint(playerid, 1.3, PosComputer[sessionid][team][c][0], PosComputer[sessionid][team][c][1], PosComputer[sessionid][team][c][2])) {
						if (GetPlayerTeamEx(playerid) != ComputerInfo[sessionid][team][c][e_Status]) {
							if (!ComputerInfo[sessionid][team][c][e_ActiveCapture]) {
								if (!ComputerInfo[sessionid][team][c][e_Red]) {
									CreatePlayerComputer(playerid, team, c);
								}
							}
						}
						else {
							if (!ComputerInfo[sessionid][team][c][e_ActiveCapture]) {
								if (GetPlayerTeamEx(playerid) == ComputerInfo[sessionid][team][c][e_ProtectTeam]) {
									SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Вы должны защищать компьютер!");
								}
							}
						}
						return 1;
					}
				}
			}
		}

		// Capture flag
		if (Mode_GetSessionGameMode(MODE_TDM, sessionid) == TDM_GAME_MODE_CAPTURE_FLAG) {
			foreach (new tt:TDM_CaptureFlagCount[sessionid]) {
				if (IsPlayerInRangeOfPoint(playerid, 1.3, PosCaptureFlag[sessionid][tt][0], PosCaptureFlag[sessionid][tt][1], PosCaptureFlag[sessionid][tt][2])) {
					if (GetPlayerTeamEx(playerid) != tt) {
						if (!CaptureFlagInfo[sessionid][tt][e_Status]) {
							if (ActionPlayerCaptureFlag[playerid] == -1) {
								CreatePlayerCaptureFlag(playerid, tt);
								TDM_SetTextTeamMatch(sessionid, "Ваш флаг захвачен!", tt);
								CheckPlayerDinaHint(playerid, 15);
							}
						}
					}
					else {
						if (ActionPlayerCaptureFlag[playerid] > -1) {
							SpawnCaptureFlag(playerid, 1);
						}
					}
					return 1;
				}
			}
		}
	}

	// N
	if (newkeys & KEY_NO) {
		// Bag money
		if (TDM_GetBagMoney(sessionid)) {
			foreach (new b:TDM_BagMoneyCount[sessionid]) {
				if (BagMoneyInfo[sessionid][b][e_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) {
					continue;
				}

				if (BagMoneyInfo[sessionid][b][e_Interior] != GetPlayerInteriorEx(playerid)) {
					continue;
				}

				if (IsPlayerInRangeOfPoint(playerid, 1.0, PosBagMoney[sessionid][b][0], PosBagMoney[sessionid][b][1], PosBagMoney[sessionid][b][2])) {
					if (BagMoneyInfo[sessionid][b][e_Team] == GetPlayerTeamEx(playerid)) {
						if (!TDM_GetPlayerBagMoney(playerid)) {
							SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Требуется иметь при себе мешок с деньгами.");
						}
						else {
							TDM_SetPlayerBagMoney(playerid, false);
							RemovePlayerAttachedObject(playerid, 8);
							GivePlayerReward(playerid, 400, 300, REWARD_BAG_OF_MONEY);

							// Quests
							CheckPlayerQuestProgress(playerid, MODE_TDM, 20);
							CheckPlayerQuestProgress(playerid, MODE_TDM, 24);
							//
						}
					}
					else {
						if (TDM_GetPlayerBagMoney(playerid)) {
							SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Мешок с деньгами уже имеется.");
						}
						else {
							if (IsPlayerAttachedObjectSlotUsed(playerid, 8)) {
								SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы уже переносите предмет на спине!");
							}
							else {
								TDM_SetPlayerBagMoney(playerid, true);
								SetPlayerAttachedObject(playerid, 8, 1550, 1, 0.0, -0.3, 0, 90, 90, 0.0);

								SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Мешок с деньгами у Вас, теперь доставьте его на свою базу.");
							}
						}
					}
					return 1;
				}
			}
		}

		// Shop team
		if (TDM_GetShopTeams(sessionid)) {
			foreach (new b:TDM_ShopCount[sessionid]) {
				if (TDM_ShopTeam[sessionid][b][e_VirtualWorld] != GetPlayerVirtualWorldEx(playerid)) {
					continue;
				}

				if (TDM_ShopTeam[sessionid][b][e_Interior] != GetPlayerInteriorEx(playerid)) {
					continue;
				}

				if (IsPlayerInRangeOfPoint(playerid, 1.0, PosShop[sessionid][b][0], PosShop[sessionid][b][1], PosShop[sessionid][b][2])) {
					if (GetPlayerTeamEx(playerid) != TDM_ShopTeam[sessionid][b][e_Team]) {
						SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный магазин не принадлежит Вашей команде!");
					}
					else {
						Dialog_Show(playerid, Dialog:TDM_ShopTeam);
					}
					return 1;
				}
			}
		}
	}

	Mode_CheckOnPlayerKey(playerid);
	return 0;
}

/*
 * |>-------<|
 * |   ALS   |
 * |>-------<|
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