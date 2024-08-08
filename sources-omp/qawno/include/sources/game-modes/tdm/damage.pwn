/*

	About: TDM damage system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnPlayerDamage(playerid, &Float:amount, issuerid, weaponid, bodypart)
	Stock:
		-
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_TDM_DAMAGE_SYSTEM
	#endinput
#endif
#define _INC_TDM_DAMAGE_SYSTEM

/*

	* Callbacks *

*/

/*
	OnPlayerDamage
*/

stock TDM_OnPlayerDamage(playerid, &Float:amount, issuerid, weaponid, bodypart) 
{
	if(issuerid != INVALID_PLAYER_ID 
	&& GetPlayerTeamEx(playerid) == GetPlayerTeamEx(issuerid)) 
		return 1;

	if(issuerid != INVALID_PLAYER_ID)
		ShowPlayerBeDamage(playerid);

	new 
		Float:total_damage;

	if(issuerid != INVALID_PLAYER_ID) {
		PlayerPlaySoundEx(issuerid, 17802, 0.0, 0.0, 0.0);
		if(!IsHighRateWeaponEx(weaponid)) {
			if(weaponid == 0 
			|| weaponid == 1) {
				new
					skill_id = GetPlayerStyleMelee(issuerid),
					skill_id2,
					Float:exp;

				switch(skill_id) {
					case FIGHT_STYLE_NORMAL: skill_id2 = 0;
					case FIGHT_STYLE_BOXING: skill_id2 = 1;
					case FIGHT_STYLE_KUNGFU: skill_id2 = 2;
					case FIGHT_STYLE_KNEEHEAD: skill_id2 = 3;
					case FIGHT_STYLE_GRABKICK: skill_id2 = 4;
					case FIGHT_STYLE_ELBOW: skill_id2 = 5;
				}

				TDM_GetPlayerSkill(issuerid, 1, GetPlayerStyleMelee(issuerid), exp);
				
				if(exp < 100.0) {
					if(Damage_GetPlayerNextSkill(issuerid, 1, skill_id2) < 100)
						Damage_SetPlayerNextSkill(issuerid, 1, skill_id2, 1);

					else if(Damage_GetPlayerNextSkill(issuerid, 1, skill_id2) >= 100) {
						Damage_SetPlayerNextSkill(issuerid, 1, skill_id2, 0);
						TDM_SetPlayerSkill(issuerid, 1, GetPlayerStyleMelee(issuerid), 10.0);

						SCM(issuerid, -1, "{FFCC33}(Рукопашный бой) {FFFF33}+10 {FFFFFF}очков к выбранному стилю.");
					}
				}

				TDM_GetPlayerSkill(issuerid, 1, GetPlayerStyleMelee(issuerid), exp);

				if(exp > 0.0)
					total_damage += exp / 20.0;
			}
			else if(weaponid > 0) {
				new
					skill_id,
					skill_id2,
					Float:exp;

				switch(weaponid) {
					case 31: skill_id = WEAPONSKILL_M4;
					case 30: skill_id = WEAPONSKILL_AK47;
					case 24: skill_id = WEAPONSKILL_DESERT_EAGLE;
					case 25: skill_id = WEAPONSKILL_SHOTGUN;
					case 26: skill_id = WEAPONSKILL_SAWNOFF_SHOTGUN;
					case 28: skill_id = WEAPONSKILL_MICRO_UZI;
					case 29: skill_id = WEAPONSKILL_MP5;
					case 34: skill_id = WEAPONSKILL_SNIPERRIFLE;
				}

				switch(weaponid) {
					case 31: skill_id2 = 0;
					case 30: skill_id2 = 1;
					case 24: skill_id2 = 2;
					case 25: skill_id2 = 3;
					case 26: skill_id2 = 4;
					case 28: skill_id2 = 5;
					case 29: skill_id2 = 6;
					case 34: skill_id2 = 7;
				}

				TDM_GetPlayerSkill(issuerid, 2, skill_id, exp);

				if(exp < 100.0) {
					if(Damage_GetPlayerNextSkill(issuerid, 2, skill_id2) < 200)
						Damage_SetPlayerNextSkill(issuerid, 2, skill_id2, 1);

					else if(Damage_GetPlayerNextSkill(issuerid, 2, skill_id2) >= 200) {
						Damage_SetPlayerNextSkill(issuerid, 2, skill_id2, 0);
						TDM_SetPlayerSkill(issuerid, 2, skill_id, 10.0);

						SCM(issuerid, -1, "{FFCC33}(Оружие) {FFFF33}+10 {FFFFFF}очков к оружию");
					}
				}

				TDM_GetPlayerSkill(issuerid, 2, skill_id, exp);

				if(exp > 0.0)
					total_damage += exp / 20.0;
			}
		}
		switch(bodypart) {
			// Туловище
			case 3: {
				total_damage += 5.0;
				switch(TDM_GetPlayerClassWearning(playerid, 2)) {
					case 1: total_damage -= 3.0;
					case 2: total_damage -= 6.0;
					case 3: total_damage -= 8.0;
				}
			}
			case 4: total_damage += 4.0;  // Ниже пояса
			case 5: total_damage += 1.0;  // Левая рука
			case 6: total_damage += 1.0;  // Правая рука
			case 7: total_damage += 2.0;  // Левая нога
			case 8: total_damage += 2.0;  // Правая нога
			// Голова
			case 9: {
				total_damage += 10.0;
				switch(TDM_GetPlayerClassWearning(playerid, 1)) {
					case 1: total_damage -= 2.0;
					case 2: total_damage -= 4.0;
					case 3: total_damage -= 8.0;
				}
			}
		}
		Damage_SetPlayerBody(playerid, issuerid, bodypart);

		// Квесты
		if(GetPlayerWeapon(issuerid) == 31) 
			Quest_CheckPlayerProgress(issuerid, MODE_TDM, 21, floatround(amount, floatround_round));
		//
	}
	
	amount += total_damage;
	return 1;
}