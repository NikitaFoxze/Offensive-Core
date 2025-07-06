/*
 * |>==========================<|
 * |   About: TDM damage main   |
 * |   Author: Foxze            |
 * |>==========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerDamage(playerid, &Float:amount, issuerid, weaponid, bodypart)
 * Stock:
	- (None)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_TDM_DAMAGE_MAIN
	#endinput
#endif
#define _INC_TDM_DAMAGE_MAIN

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>------------------<|
 * |   OnPlayerDamage   |
 * |>------------------<|
 */

stock TDM_OnPlayerDamage(playerid, &Float:amount, issuerid, WEAPON:weaponid, bodypart) 
{
	if (issuerid != INVALID_PLAYER_ID 
	&& GetPlayerTeamEx(playerid) == GetPlayerTeamEx(issuerid)) {
		return 1;
	}

	new 
		Float:totalDamage;

	if (issuerid != INVALID_PLAYER_ID) {
		SetPlayerLastDamage(playerid);
		PlayerPlaySoundEx(issuerid, 17802, 0.0, 0.0, 0.0);

		if (!IsHighRateWeaponEx(weaponid)) {
			if (weaponid == WEAPON_FIST 
			|| weaponid == WEAPON_BRASSKNUCKLE) {
				new
					FIGHT_STYLE:skillid = FIGHT_STYLE:GetPlayerFightingStyleEx(issuerid),
					skillid2,
					Float:exp;

				switch (skillid) {
					case FIGHT_STYLE_NORMAL: skillid2 = 0;
					case FIGHT_STYLE_BOXING: skillid2 = 1;
					case FIGHT_STYLE_KUNGFU: skillid2 = 2;
					case FIGHT_STYLE_KNEEHEAD: skillid2 = 3;
					case FIGHT_STYLE_GRABKICK: skillid2 = 4;
					case FIGHT_STYLE_ELBOW: skillid2 = 5;
				}

				TDM_GetPlayerFightSkill(issuerid, skillid, exp);
				
				if (exp < 100.0) {
					if (GetPlayerDamageNextSkill(issuerid, 1, skillid2) < 100) {
						SetPlayerDamageNextSkill(issuerid, 1, skillid2, 1);
					}

					else if (GetPlayerDamageNextSkill(issuerid, 1, skillid2) >= 100) {
						SetPlayerDamageNextSkill(issuerid, 1, skillid2, 0);
						TDM_SetPlayerFightSkill(issuerid, skillid, 10.0);

						SCM(issuerid, -1, "{FFCC33}(Рукопашный бой) "CT_YELLOW"+10 "CT_WHITE"очков к выбранному стилю.");
					}
				}

				TDM_GetPlayerFightSkill(issuerid, skillid, exp);

				if (exp > 0.0) {
					totalDamage += exp / 20.0;
				}
			}
			else if (weaponid > WEAPON_FIST) {
				new
					WEAPONSKILL:skillid,
					skillid2,
					Float:exp;

				switch (weaponid) {
					case WEAPON_M4: skillid = WEAPONSKILL_M4, skillid2 = 0;
					case WEAPON_AK47: skillid = WEAPONSKILL_AK47, skillid2 = 1;
					case WEAPON_DEAGLE: skillid = WEAPONSKILL_DESERT_EAGLE, skillid2 = 2;
					case WEAPON_SHOTGUN: skillid = WEAPONSKILL_SHOTGUN, skillid2 = 3;
					case WEAPON_SAWEDOFF: skillid = WEAPONSKILL_SAWNOFF_SHOTGUN, skillid2 = 4;
					case WEAPON_UZI: skillid = WEAPONSKILL_MICRO_UZI, skillid2 = 5;
					case WEAPON_MP5: skillid = WEAPONSKILL_MP5, skillid2 = 6;
					case WEAPON_SNIPER: skillid = WEAPONSKILL_SNIPERRIFLE, skillid2 = 7;
				}

				TDM_GetPlayerWeaponSkill(issuerid, skillid, exp);

				if (exp < 100.0) {
					if (GetPlayerDamageNextSkill(issuerid, 2, skillid2) < 200) {
						SetPlayerDamageNextSkill(issuerid, 2, skillid2, 1);
					}

					else if (GetPlayerDamageNextSkill(issuerid, 2, skillid2) >= 200) {
						SetPlayerDamageNextSkill(issuerid, 2, skillid2, 0);
						TDM_SetPlayerWeaponSkill(issuerid, skillid, 10.0);

						SCM(issuerid, -1, "{FFCC33}(Оружие) "CT_YELLOW"+10 "CT_WHITE"очков к оружию");
					}
				}

				TDM_GetPlayerWeaponSkill(issuerid, skillid, exp);

				if (exp > 0.0) {
					totalDamage += exp / 20.0;
				}
			}
		}
		switch (bodypart) {
			// Torso
			case 3: {
				totalDamage += 5.0;
				switch (TDM_GetPlayerClassBody(playerid, 2)) {
					case 1: totalDamage -= 3.0;
					case 2: totalDamage -= 6.0;
					case 3: totalDamage -= 8.0;
				}
			}
			case 4: totalDamage += 4.0;  // Below the belt
			case 5: totalDamage += 1.0;  // Left hand
			case 6: totalDamage += 1.0;  // Right hand
			case 7: totalDamage += 2.0;  // Left leg
			case 8: totalDamage += 2.0;  // Right leg
			// Head
			case 9: {
				totalDamage += 10.0;
				switch (TDM_GetPlayerClassBody(playerid, 1)) {
					case 1: totalDamage -= 2.0;
					case 2: totalDamage -= 4.0;
					case 3: totalDamage -= 8.0;
				}
			}
		}
		SetPlayerDamageBody(playerid, issuerid, bodypart);

		// Quests
		if (GetPlayerWeapon(issuerid) == WEAPON_M4) {
			CheckPlayerQuestProgress(issuerid, MODE_TDM, 21, floatround(amount, floatround_round));
		}
		//
	}

	amount += totalDamage;
	return 1;
}