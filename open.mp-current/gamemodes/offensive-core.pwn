/*
 * |>=======================<|
 * |     Offensive-Core      |
 * |         v2.0.0          |
 * |     By: Foxze           |
 * |>=======================<|
 */

// DeAMX
@include_a_samp_();
@include_a_samp_()
{
	#emit	stack	0x7FFFFFFF
	#emit	inc.s	cellmax
	static const ___[][] = {"protected from", "deamx"};
	#emit	retn
	#emit	load.s.pri	___
	#emit	proc
	#emit	proc
	#emit	fill	cellmax
	#emit	proc
	#emit	stack	1
	#emit	stor.alt	___
	#emit	strb.i	2
	#emit	switch	4
	#emit	retn
L1:
	#emit	jump	L1
	#emit	zero	cellmin
}

// Custom options
#pragma warning disable 239
#define NO_TAGS

/*
 * |>----------------<|
 * |     Includes     |
 * |>----------------<|
 */

// Modification
#include <open.mp>

// Configs
#include <sources/core/configs/config>
#include <sources/core/configs/colors>
#include <sources/core/configs/texts>

// Library
#include <library/a_mysql>
#include <library/bcrypt>
#include <library/crashdetect>
#include <library/sscanf2>
#include <library/streamer>
#include <library/StreamerFunction>
#include <library/foreach>
#include <library/Pawn.CMD>
#include <library/Pawn.Raknet>
#include <library/Pawn.Regex>
#include <library/cinterface>
#include <library/mdialog>
#include <library/progress2>
#include <library/rustext>
#include <library/mapfix>
#include <library/nex-ac>
#include <library/weapon-config>

// Core
#include <sources/core/core.pwn>

/*
 * |>--------<|
 * |   Head   |
 * |>--------<|
 */

// Admin
#include <sources/core/admin/admin_head>
#include <sources/core/admin/admin_td>

// Database
#include <sources/core/database/database_head>

// Player
#include <sources/core/player/player_head>
#include <sources/core/player/player_td>
#include <sources/core/player/modules/daily-bonus/daily_bonus_td>
#include <sources/core/player/modules/drop-tokens/drop_tokens_head>
#include <sources/core/player/modules/drop-weapons/drop_weapons_head>
#include <sources/core/player/modules/inventory/inventory_head>
#include <sources/core/player/modules/inventory/inventory_td>
#include <sources/core/player/modules/premium/premium_head>
#include <sources/core/player/modules/quests/quests_head>
#include <sources/core/player/modules/reward/reward_head>
#include <sources/core/player/modules/second-password/second_password_td>

// Vehicle
#include <sources/core/vehicle/vehicle_head>
#include <sources/core/vehicle/vehicle_td>

// Weapon & damage
#include <sources/core/weapon/weapon_head>

// Modes
#include <sources/modes/includes_head>

// Modules
#include <sources/modules/dina/dina_head>
#include <sources/modules/trading-platform/trading_platform_head>
#include <sources/modules/trading-platform/trading_platform_td>

/*
 * |>--------<|
 * |   Main   |
 * |>--------<|
 */

// Admin
#include <sources/core/admin/admin_main.pwn>
#include <sources/core/admin/modules/report/report_main.pwn>

// Anticheat
#include <sources/core/anticheat/anticheat_main.pwn>

// Database
#include <sources/core/database/database_main.pwn>

// Player
#include <sources/core/player/player_main.pwn>
#include <sources/core/player/modules/drop-tokens/drop_tokens_main.pwn>
#include <sources/core/player/modules/drop-weapons/drop_weapons_main.pwn>
#include <sources/core/player/modules/inventory/inventory_main.pwn>
#include <sources/core/player/modules/premium/premium_main.pwn>
#include <sources/core/player/modules/quests/quests_main.pwn>
#include <sources/core/player/modules/reward/reward_main.pwn>
#include <sources/core/player/modules/mini-games/mini_games_main.pwn>
#include <sources/core/player/modules/daily-bonus/daily_bonus_main.pwn>
#include <sources/core/player/modules/second-password/second_password_main.pwn>

// Vehicle
#include <sources/core/vehicle/vehicle_main.pwn>

// Weapon & damage
#include <sources/core/weapon/weapon_main.pwn>
#include <sources/core/weapon/damage/damage_main.pwn>

// Modes
#include <sources/modes/includes_main>

// Modules
#include <sources/modules/dina/dina_main.pwn>
#include <sources/modules/trading-platform/trading_platform_main.pwn>
#include <sources/modules/promocode/promocode_main.pwn>

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

main()
{
	print("--------------------------------------");
	print(" "SERVER_NAME_CORE" готов к работе!");
	print(" Версия: "SERVER_VERSION"");
	print(" Автор: Foxze");
	print("--------------------------------------\n");
}

/*
 * |>----------<|
 * |   Server   |
 * |>----------<|
 */

public OnGameModeInit()
{
	MySQL_OnGameModeInit();
	Core_OnGameModeInit();
	Player_OnGameModeInit();
	Mode_OnGameModeInit();
	return 1;
}

public OnGameModeExit()
{
	Core_OnGameModeExit();
	MySQL_OnGameModeExit();
	return 1;
}

/*
 * |>----------<|
 * |   Player   |
 * |>----------<|
 */

public OnPlayerRequestSpawn(playerid)
{
	return Player_OnPlayerRequestSpawn(playerid);
}

public OnPlayerRequestClass(playerid, classid)
{
	return Player_OnPlayerRequestClass(playerid, classid);
}

public OnPlayerConnect(playerid)
{
	if (Player_OnPlayerConnect(playerid)) {
		return 1;
	}

	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if (Player_OnPlayerDisconnect(playerid, reason)) {
		return 1;
	}

	return 1;
}

public OnPlayerSpawn(playerid)
{
	if (Player_OnPlayerSpawn(playerid)) {
		return 1;
	}

	Mode_OnPlayerSpawn(playerid);
	return 1;
}

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	if (Player_OnPlayerDeath(playerid, killerid, reason)) {
		return 1;
	}

	Mode_OnPlayerDeath(playerid, killerid, reason);
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if (Player_OnPlayerText(playerid, text)) {
		return 0;
	}

	if (Mode_OnPlayerText(playerid, text)) {
		return 0;
	}

	Mode_SendPlayerChatText(playerid, text);
	return 0;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	if (Player_OnPlayerClickPlayer(playerid, clickedplayerid, source)) {
		return 1;
	}

	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	if (Adm_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) {
		return 1;
	}

	if (Mode_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) {
		return 1;
	}

	if (Player_OnPlayerKeyStateChange(playerid, newkeys, oldkeys)) {
		return 1;
	}

	return 1;
}

public OnPlayerUpdate(playerid)
{
	Player_OnPlayerUpdate(playerid);
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

/*
 * |>-----------<|
 * |   Command   |
 * |>-----------<|
 */

public PC_OnInit()
{
	Player_PC_OnInit();
	Admin_PC_OnInit();
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if (GetPlayerLogged(playerid)) {
		return 0;
	}

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 0;
	}

	if (Dialog_IsOpen(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В открытом диалоге запрещено вводить команды.");
		return 0;
	}

	if (Adm_OnPlayerCommandReceived(playerid, cmd, params, flags)) {
		return 0;
	}

	if (Player_OnPlayerCommandReceived(playerid, cmd, params, flags)) {
		return 0;
	}

	if (Mode_OnPlayerCommandReceived(playerid, cmd, params, flags)) {
		return 0;
	}

	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if (GetPlayerLogged(playerid)) {
		return 0;
	}

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 0;
	}

	if (result == -1) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данной команды нет на сервере.");
		return 0;
	}

	return 1;
}

// Do not use
public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

/*
 * |>--------<|
 * |   Rcon   |
 * |>--------<|
 */

public OnRconCommand(cmd[])
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

/*
 * |>-----------<|
 * |   Vehicle   |
 * |>-----------<|
 */

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

/*
 * |>-------------<|
 * |   GangZones   |
 * |>-------------<|
 */

public OnPlayerEnterPlayerGangZone(playerid, zoneid)
{
	Mode_OnPlayerEnterPlayerGZ(playerid, zoneid);
    return 1;
}

public OnPlayerLeavePlayerGangZone(playerid, zoneid)
{
	Mode_OnPlayerLeavePlayerGZ(playerid, zoneid);
    return 1;
}

/*
 * |>--------------<|
 * |   Checkpoint   |
 * |>--------------<|
 */

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	return 1;
}

public OnPlayerLeaveDynamicCP(playerid)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

/*
 * |>----------<|
 * |   Object   |
 * |>----------<|
 */

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

/*
 * |>----------<|
 * |   Pickup   |
 * |>----------<|
 */

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if (Mode_OnPlPickUpDynamicPickup(playerid, pickupid)) {
		return 1;
	}

	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

/*
 * |>--------<|
 * |   Menu   |
 * |>--------<|
 */

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

/*
 * |>------------<|
 * |   TextDraw   |
 * |>------------<|
 */

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

/*
 * |>----------<|
 * |   Damage   |
 * |>----------<|
 */

public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &WEAPON:weapon, &bodypart)
{
	if (!Damage_OnPlayerDamage(playerid, Float:amount, issuerid, weapon, bodypart)) {
		return 1;
	}

	Mode_OnPlayerDamage(playerid, Float:amount, issuerid, weapon, bodypart);
	return 1;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

/*
 * |>--------<|
 * |   Area   |
 * |>--------<|
 */

public OnPlayerEnterDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	Mode_OnPlayerEnterDynamicArea(playerid, areaid);
	return 1;
}

public OnPlayerLeaveDynamicArea(playerid, STREAMER_TAG_AREA:areaid)
{
	Mode_OnPlayerLeaveDynamicArea(playerid, areaid);
	return 1;
}

/*
 * |>-----------<|
 * |   Dialogs   |
 * |>-----------<|
 */

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if (!GetPlayerLogged(playerid)) {
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	}
	return 1;
}