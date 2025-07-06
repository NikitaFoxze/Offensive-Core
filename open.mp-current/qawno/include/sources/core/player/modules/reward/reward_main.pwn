/*
 * |>======================<|
 * |   About: Reward main   |
 * |   Author: Foxze        |
 * |>======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)
 * Stock:
	- GivePlayerReward(playerid, exp, money, rewardid, bool:textTD = true)
	- DestroyPlayerReward(playerid)
	- UpdatePlayerReward(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_TD_REWARD_INFO
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

#if defined _INC_REWARD_MAIN
	#endinput
#endif
#define _INC_REWARD_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_TD_REWARD_INFO {
	bool:e_ActionTextAll,
	e_ScoreExpMoney[2],
	e_Timer
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_TD_REWARD_INFO],
	RewardStr[MAX_PLAYERS][MAX_REWARD_COUNT_TEXTS][100],
	PlayerText:TD_PlayerReward[MAX_PLAYERS][MAX_REWARD_COUNT_TEXTS];

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock GivePlayerReward(playerid, exp, money, rewardid, bool:textTD = true)
{
	GivePlayerExp(playerid, exp);
	GivePlayerMoneyEx(playerid, money);

	SCM(playerid, C_GREEN, "[%s] "CT_WHITE"Получено "CT_ORANGE"+%i EXP "CT_WHITE"и "CT_GREEN"+$%i.", GetNameReward(rewardid), exp, money);

	Mode_GivePlayerReward(playerid, exp, money);

	if (textTD) {
		ShowTDRewardText(playerid, exp, money, rewardid);
	}
	return 1;
}

stock DestroyPlayerReward(playerid)
{
	if (!pInfo[playerid][e_ActionTextAll]) {
		return 1;
	}

	ResetPlayerRewardData(playerid);

	n_for(i, MAX_REWARD_COUNT_TEXTS) {
		DestroyPlayerTD(playerid, TD_PlayerReward[playerid][i]);
	}
	return 1;
}

stock UpdatePlayerReward(playerid)
{
	if (!pInfo[playerid][e_ActionTextAll]) {
		return 1;
	}

	if (pInfo[playerid][e_Timer] > 0) {
		pInfo[playerid][e_Timer]--;
	}
	else {
		DestroyPlayerReward(playerid);
	}
	return 1;
}

static CreateTDRewardText(playerid, id, rewardid)
{
	static
		str[MAX_LENGTH_REWARD_NAME + MAX_PLAYER_NAME];

	str[0] = EOS;

	switch (rewardid) {
		case REWARD_KILL: {
			new
				playerName[MAX_PLAYER_NAME];

			GetPVarString(playerid, "NamePlayerForReward", playerName, MAX_PLAYER_NAME);
			DeletePVar(playerid, "NamePlayerForReward");

			f(str, "%s %s", GetNameReward(rewardid), playerName);
		}
		default: {
			f(str, "%s", GetNameReward(rewardid));
		}
	}

	RewardStr[playerid][id] = str;
	PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][id], str);
	return 1;
}

static ShowTDRewardText(playerid, exp, money, rewardid)
{
	if (pInfo[playerid][e_ActionTextAll]) {
		pInfo[playerid][e_Timer] = REWARD_SHOW_TIMER;

		for (new i = MAX_REWARD_COUNT_TEXTS - 1; i > 1; i--) {
			if (i == 2) {
				CreateTDRewardText(playerid, i, rewardid);
			}
			else {
				PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][i], RewardStr[playerid][i - 1]);
				RewardStr[playerid][i] = RewardStr[playerid][i - 1];
			}
		}

		pInfo[playerid][e_ScoreExpMoney][0] += exp;
		PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][0], "+%i EXP", pInfo[playerid][e_ScoreExpMoney][0]);

		pInfo[playerid][e_ScoreExpMoney][1] += money;
		PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][1], "+$%i", pInfo[playerid][e_ScoreExpMoney][1]);
	}
	else {
		pInfo[playerid][e_ActionTextAll] = true;
		pInfo[playerid][e_Timer] = REWARD_SHOW_TIMER;

		CreatePlayerTDReward(playerid);

		for (new i = MAX_REWARD_COUNT_TEXTS - 1; i > 1; i--) {
			if (i == 2) {
				CreateTDRewardText(playerid, i, rewardid);
			}
			else {
				PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][i], RewardStr[playerid][i - 1]);
				RewardStr[playerid][i] = RewardStr[playerid][i - 1];

				PlayerTextDrawShow(playerid, TD_PlayerReward[playerid][i]);
			}
		}

		pInfo[playerid][e_ScoreExpMoney][0] += exp;
		PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][0], "+%i EXP", pInfo[playerid][e_ScoreExpMoney][0]);

		pInfo[playerid][e_ScoreExpMoney][1] += money;
		PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][1], "+$%i", pInfo[playerid][e_ScoreExpMoney][1]);

		n_for(i, sizeof(TD_PlayerReward[])) {
			PlayerTextDrawShow(playerid, TD_PlayerReward[playerid][i]);
		}
	}
	return 1;
}

static CreatePlayerTDReward(playerid) 
{
	// EXP
	TD_PlayerReward[playerid][0] = CreatePlayerTextDraw(playerid, 364.000000, 163.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_PlayerReward[playerid][0], 0.199999, 1.172739);
	PlayerTextDrawAlignment(playerid, TD_PlayerReward[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerReward[playerid][0], -274973185);
	PlayerTextDrawSetShadow(playerid, TD_PlayerReward[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_PlayerReward[playerid][0], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerReward[playerid][0], 48);
	PlayerTextDrawFont(playerid, TD_PlayerReward[playerid][0], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerReward[playerid][0], true);

	// Money
	TD_PlayerReward[playerid][1] = CreatePlayerTextDraw(playerid, 364.000000, 173.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_PlayerReward[playerid][1], 0.199999, 1.172739);
	PlayerTextDrawAlignment(playerid, TD_PlayerReward[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerReward[playerid][1], 1575768575);
	PlayerTextDrawSetShadow(playerid, TD_PlayerReward[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TD_PlayerReward[playerid][1], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerReward[playerid][1], 48);
	PlayerTextDrawFont(playerid, TD_PlayerReward[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerReward[playerid][1], true);

	// Text 1
	TD_PlayerReward[playerid][2] = CreatePlayerTextDraw(playerid, 364.000000, 190.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_PlayerReward[playerid][2], 0.200999, 0.969480);
	PlayerTextDrawAlignment(playerid, TD_PlayerReward[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerReward[playerid][2], -219147265);
	PlayerTextDrawSetShadow(playerid, TD_PlayerReward[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TD_PlayerReward[playerid][2], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerReward[playerid][2], 48);
	PlayerTextDrawFont(playerid, TD_PlayerReward[playerid][2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerReward[playerid][2], true);

	// Text 2
	TD_PlayerReward[playerid][3] = CreatePlayerTextDraw(playerid, 364.000000, 200.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_PlayerReward[playerid][3], 0.200999, 0.969480);
	PlayerTextDrawAlignment(playerid, TD_PlayerReward[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerReward[playerid][3], -219147265);
	PlayerTextDrawSetShadow(playerid, TD_PlayerReward[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TD_PlayerReward[playerid][3], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerReward[playerid][3], 48);
	PlayerTextDrawFont(playerid, TD_PlayerReward[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerReward[playerid][3], true);

	// Text 3
	TD_PlayerReward[playerid][4] = CreatePlayerTextDraw(playerid, 364.000000, 210.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_PlayerReward[playerid][4], 0.200999, 0.969480);
	PlayerTextDrawAlignment(playerid, TD_PlayerReward[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerReward[playerid][4], -219147265);
	PlayerTextDrawSetShadow(playerid, TD_PlayerReward[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, TD_PlayerReward[playerid][4], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerReward[playerid][4], 48);
	PlayerTextDrawFont(playerid, TD_PlayerReward[playerid][4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerReward[playerid][4], true);
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerRewardData(playerid)
{
	pInfo[playerid][e_ActionTextAll] = false;
	pInfo[playerid][e_Timer] = 0;

	n_for(i, 2) {
		pInfo[playerid][e_ScoreExpMoney][i] = 0;
	}

	n_for(i, MAX_REWARD_COUNT_TEXTS) {
		RewardStr[playerid][i] = "";
	}
	return 1;
}

static ResetPlayerRewardTDs(playerid)
{
	n_for(t, sizeof(TD_PlayerReward[]))
		TD_PlayerReward[playerid][t] = INVALID_PLAYER_TEXT_DRAW;

	return 1;
}

/*
 * |>-----------------<|
 * |     Callbacks     |
 * |>-----------------<|
 */

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

public OnPlayerConnect(playerid)
{
	ResetPlayerRewardData(playerid);
	ResetPlayerRewardTDs(playerid);

	#if defined Reward_OnPlayerConnect
		return Reward_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
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
#define OnPlayerConnect Reward_OnPlayerConnect
#if defined Reward_OnPlayerConnect
	forward Reward_OnPlayerConnect(playerid);
#endif