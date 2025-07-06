/*
 * |>======================<|
 * |   About: Quests main   |
 * |   Author: Foxze        |
 * |>======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)

	# Technical #
	- MySQLUploadPlayerQuests(playerid)
 * Stock:
	- CheckPlayerQuestProgress(playerid, modeid, questid, num = 1)
	- SetPlayerQuestProgress(playerid, modeid, questid, num)
	- GetPlayerQuestAllPassed(playerid)
	- CheckPlayerQuestPassedCount(playerid, modeid)

	- MySQLCreateNewQuest(playerid)
	- MySQLUploadPlayerQuestData(playerid)
	- SavePlayerQuests(playerid, modeid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_QUEST_INFO
	- E_PLAYER_QUEST_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- QuestsList
	- QuestsSelectMode
	- QuestsListProgress
	- QuestInfo
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_QUESTS_MAIN
	#endinput
#endif
#define _INC_QUESTS_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_QUEST_INFO {
	e_Name[QUESTS_MAX_NAME_LENGTH],
	e_Info[QUESTS_MAX_INFO_LENGTH],
	e_Number,

	e_Exp,
	e_Money,
	e_SkinMale,
	e_SkinFemale,
	e_Item,
	e_ItemCount
}

enum E_PLAYER_QUEST_INFO {
	e_Progress[QUESTS_MAX_PROGRESS],
	e_ProgressSum[QUESTS_MAX_PROGRESS],
	e_List[QUESTS_MAX]
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][GMS_MAX_MODES][E_PLAYER_QUEST_INFO],
	ActiveListID[MAX_PLAYERS][QUESTS_MAX_PROGRESS],
	ActiveListMode[MAX_PLAYERS];

static
	bool:AllQuestsDone[MAX_PLAYERS char];

static const
	qInfo[GMS_MAX_MODES][QUESTS_MAX][E_QUEST_INFO] = {
	{ // None
		{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
	},
	{ // Комната
		{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
	},
	{ // TDM режим
		// Лёгкие
		 /*0*/{"Расправа", 							"Совершить убийство 3-х противников", 3, 300, 200, 0, 0, 0, 0},
		 /*1*/{"Захватчик", 						"Захватить 2 территории", 2, 0, 0, 6, 12, 0, 0},
		 /*2*/{"Штурмовик со стажем", 				"Совершить убийство 6-х противников за штурмовика", 6, 0, 0, 0, 0, 312, 15},
		 /*3*/{"Медик с оружием", 					"Совершить убийство 7-х противников за медика", 7, 500, 450, 0, 0, 0, 0},
		 /*4*/{"Опасный инженер", 					"Совершить убийство 9-х противников за инженера", 9, 900, 700, 0, 0, 0, 0},
		 /*5*/{"Зоркий глаз", 						"Совершить убийство 15 противников из снайперской винтовки за разведчика", 15, 1300, 1000, 0, 0, 0, 0},
		 /*6*/{"Хакер", 							"Взломать 5 вражеских компьютеров", 15, 1600, 1300, 0, 0, 0, 0},
		 /*7*/{"Выживший", 							"Захватить 2 вражеских флага", 2, 1700, 1400, 0, 0, 0, 0},
		 /*8*/{"Мясник", 							"Совершить убийство 1 противника при помощи ножа", 1, 1750, 1420, 0, 0, 0, 0},
		 /*9*/{"Мастер над холодным оружием", 		"Совершить убийство 3-х противников при помощи холодного оружия (кроме ножа)", 3, 1800, 1500, 0, 0, 0, 0},
		
		// Средние
		/*10*/{"Мега-захватчик", 					"Захватить 3 территории не умирая", 3, 0, 0, 0, 0, 313, 30},
		/*11*/{"Киллер", 							"Совершить убийство 5-х противников не умирая", 5, 0, 0, 29, 56, 0, 0},
		/*12*/{"Айболит", 							"Вылечить 10-х союзников за медика (/hp)", 10, 2300, 2000, 0, 0, 0, 0},
		/*13*/{"Вояка",								"Совершить убийство 15 противников за штурмовика", 15, 0, 0, 86, 91, 0, 0},
		/*14*/{"Механик", 							"Починить 20 транспортных средств (/rep)", 20, 2800, 2500, 0, 0, 0, 0},
		/*15*/{"Орёл", 								"Совершить убийство 30 противников из снайперской винтовки за разведчика", 30, 3300, 3250, 0, 0, 0, 0},
		/*16*/{"Русский хакер", 					"Взломать 8 вражеских компьютеров", 8, 4000, 3900, 0, 0, 0, 0},
		/*17*/{"Вегетарианец", 						"Совершить убийство 5-х противников при помощи катаны", 5, 4300, 4100, 0, 0, 0, 0},
		/*18*/{"Ниндзя",	 						"Совершить убийство 15 противников при помощи холодного оружия (кроме катаны)", 15, 4800, 4500, 0, 0, 0, 0},
		/*19*/{"Удача", 							"Захватить 5 вражеских флага", 5, 5100, 5000, 0, 0, 0, 0},
		/*20*/{"Чеканные монеты", 					"Забрать на складе противников мешок денег и принести его на свой склад", 1, 6000, 5500, 0, 0, 0, 0},
		
		// Сложные
		/*21*/{"Уничтожитель", 						"Нанести 1500 урона по противникам из M4 за штурмовика", 1500, 8000, 7000, 0, 0, 0, 0},
		/*22*/{"Воздух наш", 						"Совершить убийство 20 противников при помощи самолёта или вертолёта", 20, 0, 0, 107, 141, 0, 0},
		/*23*/{"Никакой пощады", 					"Совершить убийство 30 противников при помощи танка", 30, 0, 0, 0, 0, 314, 60},
		/*24*/{"Всегда доставляет", 				"Забрать на складе противников мешок денег и принести его на свой склад 5 раз", 5, 11000, 10000, 0, 0, 0, 0},
		/*25*/{"Истинный охотник", 					"Совершить убийство 50 противников из снайперской винтовки за разведчика", 50, 13000, 12000, 0, 0, 0, 0},
		/*26*/{"Дэдшот", 							"Совершить убийство 10-х противников в голову", 10, 0, 0, 165, 169, 0, 0},
		/*27*/{"Пустынный орёл", 					"Совершить убийство 30 противников при помощи дигла", 30, 0, 0, 0, 0, 314, 120},
		/*28*/{"Разрушитель", 						"Совершить убийство 25 противников при помощи РПГ", 25, 0, 0, 271, 263, 0, 0},
		/*29*/{"Ловкач", 							"Захватить 40 территорий", 40, 15000, 14000, 0, 0, 0, 0},
		/*30*/{"Бессмертный", 						"Совершить убийство 10-х противников находящиеся в танке", 10, 0, 0, 0, 0, 314, 150}
	},
	{ // DM режим
		 /*0*/{"Особое дело", 						"Совершить убийство 1-го противника", 1, 300, 250, 0, 0, 0, 0},
		 /*1*/{"В лоб", 							"Совершить убийство 3-х противников в голову", 3, 0, 0, 49, 55, 0, 0},
		 /*2*/{"Профессионал", 						"Совершить убийство 5-х противников", 5, 0, 0, 0, 0, 312, 10},
		 /*3*/{"Любитель", 							"Собрать 10 жетонов после убийств противников", 10, 500, 400, 0, 0, 0, 0}, 
		 /*4*/{"Король", 							"Совершить убийство 6-х противников из дигла", 6, 700, 500, 0, 0, 0, 0}, 
		 /*5*/{"Меткость основа жизни",	 			"Совершить убийство 15-х противников из M4", 15, 1000, 900, 0, 0, 0, 0}, 
		 /*6*/{"Соколиный глаз", 					"Совершить убийство 10-х противников из снайперской винтовки", 10, 0, 0, 59, 63, 0, 0},
		 /*7*/{"Знаток", 							"Собрать 30 жетонов после убийств противников", 30, 1300, 1000, 0, 0, 0, 0}, 
		 /*8*/{"Твёрдый характер", 					"Совершить убийство 5-х противников не умирая", 5, 0, 0, 0, 0, 313, 30},
		 /*9*/{"Хладнокровный", 					"Совершить убийство 7-х противников не используя огнестрельное оружие", 7, 1500, 1300, 0, 0, 0, 0}, 
		/*10*/{"Сильная хватка", 					"Совершить убийство 20-х противников из дробовика", 20, 0, 0, 68, 69, 0, 0},
		/*11*/{"Массовый хаос", 					"Совершить убийство 50 противников", 50, 5000, 4000, 0, 0, 0, 0}, 
		/*12*/{"Коллекционер", 						"Собрать 60 жетонов после убийств противников", 60, 0, 0, 73, 76, 0, 0},
		/*13*/{"Между глаз", 						"Совершить убийство 30 противников в голову", 30, 0, 0, 0, 0, 314, 60},
		/*14*/{"Лучший стрелок на Диком Западе",	"Совершить убийство 40 противников из дигла", 40, 10000, 9000, 0, 0, 0, 0}, 
		{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
	},
	{ // GangWar
		{}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
	}
};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock CheckPlayerQuestProgress(playerid, modeid, questid, num = 1)
{
	new
		questProgress = -1;

	CheckPlayerQuestCellProgress(playerid, modeid, questid, questProgress);

	if (questProgress > -1) {
		pInfo[playerid][modeid][e_ProgressSum][questProgress] += num;

		if (pInfo[playerid][modeid][e_ProgressSum][questProgress] >= qInfo[modeid][pInfo[playerid][modeid][e_Progress][questProgress]][e_Number]) {
			SetPlayerQuestDone(playerid, modeid, questid);
		}
	}
	return 1;
}

stock SetPlayerQuestProgress(playerid, modeid, questid, num)
{
	new
		questProgress;

	CheckPlayerQuestCellProgress(playerid, modeid, questid, questProgress);

	if (questProgress > -1) {
		pInfo[playerid][modeid][e_ProgressSum][questProgress] = num;
	}
	return 1;
}

stock GetPlayerQuestAllPassed(playerid)
{
	return AllQuestsDone{playerid};
}

stock CheckPlayerQuestPassedCount(playerid, modeid)
{
	new
		countPassed;

	for (new i = 0; i < Mode_GetMaxQuests(modeid); i++) {
		if (pInfo[playerid][modeid][e_List][i] == 1) {
			countPassed++;
		}
	}
	return countPassed;
}

static CheckPlayerQuestCellProgress(playerid, modeid, questid, &cellProgress)
{
	new
		questsProgress = Mode_GetMaxQuestsProgress(modeid);

	n_for(i, questsProgress) {
		if (pInfo[playerid][modeid][e_Progress][i] == questid) {
			cellProgress = i;
			return 1;
		}
	}
	return 0;
}

static SetPlayerQuestReward(playerid, modeid, questid)
{
	if (qInfo[modeid][questid][e_Exp] > 0) {
		GivePlayerExp(playerid, qInfo[modeid][questid][e_Exp], false, false);
		SCM(playerid, C_ORANGE, ""T_QUEST" "CT_ORANGE"\"%s\" получено +%i EXP", qInfo[modeid][questid][e_Name], qInfo[modeid][questid][e_Exp]);
	}
	if (qInfo[modeid][questid][e_Money] > 0) {
		GivePlayerMoneyEx(playerid, qInfo[modeid][questid][e_Money]);
		SCM(playerid, C_ORANGE, ""T_QUEST" "CT_ORANGE"\"%s\" получено +$%i", qInfo[modeid][questid][e_Name], qInfo[modeid][questid][e_Money]);
	}
	if (GetPlayerSex(playerid) == SEX_MALE) {
		if (qInfo[modeid][questid][e_SkinMale] > 0) {
			GivePlayerInvItem(playerid, qInfo[modeid][questid][e_SkinMale], 1);
			SCM(playerid, C_ORANGE, ""T_QUEST" "CT_ORANGE"\"%s\" получен %s", qInfo[modeid][questid][e_Name], GetInvNameItem(qInfo[modeid][questid][e_SkinMale]));
		}
	}
	else {
		if (qInfo[modeid][questid][e_SkinFemale] > 0) {
			GivePlayerInvItem(playerid, qInfo[modeid][questid][e_SkinFemale], 1);
			SCM(playerid, C_ORANGE, ""T_QUEST" "CT_ORANGE"\"%s\" получен %s", qInfo[modeid][questid][e_Name], GetInvNameItem(qInfo[modeid][questid][e_SkinFemale]));
		}	
	}
	if (qInfo[modeid][questid][e_Item] > 0) {
		switch (CheckInvItemDestination(qInfo[modeid][questid][e_Item])) {
			case INV_PLAYER_DEST_CASES: {
				SCM(playerid, C_ORANGE, ""T_QUEST" "CT_ORANGE"\"%s\" получен %s", qInfo[modeid][questid][e_Name], GetInvNameItem(qInfo[modeid][questid][e_Item]));
			}
			default: {
				SCM(playerid, C_ORANGE, ""T_QUEST" "CT_ORANGE"\"%s\" получен %s. Кол-во %i", qInfo[modeid][questid][e_Name], GetInvNameItem(qInfo[modeid][questid][e_Item]), qInfo[modeid][questid][e_ItemCount]);
			}
		}
		GivePlayerInvItem(playerid, qInfo[modeid][questid][e_Item], qInfo[modeid][questid][e_ItemCount]);
	}	
	return 1;
}

static SetPlayerQuestDone(playerid, modeid, questid)
{
	pInfo[playerid][modeid][e_List][questid] = 1;

	new
		progressid = -1,
		questsProgress = Mode_GetMaxQuestsProgress(modeid),
		questsMax = Mode_GetMaxQuests(modeid);

	n_for(i, questsProgress) {
		if (pInfo[playerid][modeid][e_Progress][i] == questid) {
			progressid = i;
			break;
		}
	}
	if (progressid > -1) {
		n_for(i, questsMax) {
			if (pInfo[playerid][modeid][e_List][i] == 1) {
				continue;
			}
			
			new
				check;
			
			n_for2(q, questsProgress) {
				if (pInfo[playerid][modeid][e_Progress][q] == i) {
					check++;
				}
			}

			if (check > 0) {
				continue;
			}

			pInfo[playerid][modeid][e_Progress][progressid] = i;
			break;
		}
		pInfo[playerid][modeid][e_ProgressSum][progressid] = 0;

		if (pInfo[playerid][modeid][e_Progress][progressid] == questid) {
			pInfo[playerid][modeid][e_Progress][progressid] = -1;
		}
	}
	SetPlayerQuestReward(playerid, modeid, questid);

	SavePlayerQuests(playerid, modeid);
	return 1;
}

static SetPlayerQuestsCheck(playerid, modeid = MODE_NONE)
{
	if (modeid == MODE_NONE) {
		n_for(m, GMS_MAX_MODES) {
			new
				questsProgress = Mode_GetMaxQuestsProgress(modeid),
				questsMax = Mode_GetMaxQuests(modeid);

			new
				progressid[QUESTS_MAX_PROGRESS] = {-1, ...};

			n_for2(i, questsProgress) {
				if (pInfo[playerid][m][e_Progress][i] == -1) {
					n_for3(b, questsProgress) {
						if (progressid[b] == -1) {
							progressid[b] = i;
							break;
						}
					}
				}
			}
			n_for2(i, questsMax) {
				if (pInfo[playerid][m][e_List][i] == 1) {
					continue;
				}
				
				new
					check;

				n_for3(q, questsProgress) {
					if (pInfo[playerid][m][e_Progress][q] == i)
						check++;
				}

				if (check > 0) {
					continue;
				}

				n_for3(b, questsProgress) {
					if (progressid[b] > -1) {
						pInfo[playerid][m][e_Progress][progressid[b]] = i;
						progressid[b] = -1;
						break;
					}
				}
			}
		}
	}
	else {
		new
			questsProgress = Mode_GetMaxQuestsProgress(modeid),
			questsMax = Mode_GetMaxQuests(modeid);

		new
			progressid[QUESTS_MAX_PROGRESS] = {-1, ...};

		n_for(i, questsProgress) {
			if (pInfo[playerid][modeid][e_Progress][i] == -1) {
				n_for2(b, questsProgress) {
					if (progressid[b] == -1) {
						progressid[b] = i;
						break;
					}
				}
			}
		}
		n_for(i, questsMax) {
			if (pInfo[playerid][modeid][e_List][i] == 1) {
				continue;
			}
			
			new 
				check;

			n_for2(q, questsProgress) {
				if (pInfo[playerid][modeid][e_Progress][q] == i)
					check++;
			}
				
			if (check > 0) {
				continue;
			}

			n_for2(b, questsProgress) {
				if (progressid[b] > -1) {
					pInfo[playerid][modeid][e_Progress][progressid[b]] = i;
					progressid[b] = -1;
					break;
				}
			}
		}
	}
	return 1;
}

static SetListQuest(playerid, cell, modeid, questStart, questFinish)
{
	SetPVarInt(playerid, "QuestSelectedList", cell);
	SetPVarInt(playerid, "QuestMode", modeid);
	SetPVarInt(playerid, "QuestStart", questStart);
	SetPVarInt(playerid, "QuestFinish", questFinish);
}

static SetQuestInfo(playerid, modeid, questid)
{
	SetPVarInt(playerid, "QuestInfoMode", modeid);
	SetPVarInt(playerid, "QuestInfoID", questid);
	return 1;
}

/*
 * |>-------------<|
 * |     MySQL     |
 * |>-------------<|
 */

stock MySQLCreateNewQuest(playerid)
{
	static
		strFormat[6000],
		strData[1000],
		strData2[500];

	strFormat[0] =
	strData[0] =
	strData2[0] = EOS;

	f(strFormat, "\
	INSERT INTO \
	`"DB_QUESTS"` \
	(\
	`"DB_QUESTS_ID"`,\
	`"DB_QUESTS_TDM_PROGRESS"`,\
	`"DB_QUESTS_TDM_QUESTS"`,\
	`"DB_QUESTS_DM_PROGRESS"`,\
	`"DB_QUESTS_DM_QUESTS"`\
	) \
	VALUES ");
	
	strcat(strFormat, "(");

	// DB_QUESTS_ID
	f(strData, "'%i',", GetPlayerMySQLID(playerid));
	strcat(strFormat, strData);
	
	strData[0] = EOS;

	// DB_QUESTS_TDM_PROGRESS
	n_for(i, TDM_MAX_QUESTS_PROGRESS) {
		f(strData2, "%s%i,0,", strData2, i);
		pInfo[playerid][MODE_TDM][e_Progress][i] = i;
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);
	
	strData[0] =
	strData2[0] = EOS;

	// DB_QUESTS_TDM_QUESTS
	n_for(i, TDM_MAX_QUESTS) {
		strcat(strData2, "0,");
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_QUESTS_DM_PROGRESS
	n_for(i, DM_MAX_QUESTS_PROGRESS) {
		f(strData2, "%s%i,0,", strData2, i);
		pInfo[playerid][MODE_DM][e_Progress][i] = i;
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_QUESTS_DM_QUESTS
	n_for(i, DM_MAX_QUESTS) {
		strcat(strData2, "0,");
	}

	f(strData, "'%s'", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	strcat(strFormat, ")");
	
	mysql_tquery(MySQLID, strFormat);
	return 1;
}

stock MySQLUploadPlayerQuestData(playerid)
{
	static const
		queryFormat[] = "SELECT * FROM `"DB_QUESTS"` WHERE `"DB_QUESTS_ID"` = '%i' LIMIT 1";

	new
		query[sizeof(queryFormat) - 2 + MAX_LENGTH_NUM];

	mysql_format(MySQLID, query, sizeof(query), queryFormat, GetPlayerMySQLID(playerid));
	mysql_tquery(MySQLID, query, "MySQLUploadPlayerQuests", "i", playerid);
	return 1;
}

public: MySQLUploadPlayerQuests(playerid)
{
	static
		strFormat[30],
		strData[1000];

	strFormat[0] =
	strData[0] = EOS;
	
	new
		progressTDM[TDM_MAX_QUESTS_PROGRESS * 2],
		progressDM[DM_MAX_QUESTS_PROGRESS * 2];

	/* Mode TDM */

	// Progress
	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_QUESTS_PROGRESS * 2);

	cache_get_value_name(0, DB_QUESTS_TDM_PROGRESS, strData);
	sscanf(strData, strFormat, progressTDM);

	strFormat[0] =
	strData[0] = EOS;

	for (new i = 0, b = 0; b < TDM_MAX_QUESTS_PROGRESS; b++, i += 2) {
		pInfo[playerid][MODE_TDM][e_Progress][b] = progressTDM[i]; 
		pInfo[playerid][MODE_TDM][e_ProgressSum][b] = progressTDM[i + 1]; 
	}

	// All
	f(strFormat, "p<,>a<i>[%i]", TDM_MAX_QUESTS);

	cache_get_value_name(0, DB_QUESTS_TDM_QUESTS, strData);
	sscanf(strData, strFormat, pInfo[playerid][MODE_TDM][e_List]);

	strFormat[0] =
	strData[0] = EOS;

	/* Mode DM */

	// Progress
	f(strFormat, "p<,>a<i>[%i]", DM_MAX_QUESTS_PROGRESS * 2);

	cache_get_value_name(0, DB_QUESTS_DM_PROGRESS, strData);
	sscanf(strData, strFormat, progressDM);

	strFormat[0] =
	strData[0] = EOS;

	for (new i = 0, b = 0; b < DM_MAX_QUESTS_PROGRESS; b++, i += 2) {
		pInfo[playerid][MODE_DM][e_Progress][b] = progressDM[i]; 
		pInfo[playerid][MODE_DM][e_ProgressSum][b] = progressDM[i + 1]; 
	}

	// All
	f(strFormat, "p<,>a<i>[%i]", DM_MAX_QUESTS);

	cache_get_value_name(0, DB_QUESTS_DM_QUESTS, strData);
	sscanf(strData, strFormat, pInfo[playerid][MODE_DM][e_List]);

	strFormat[0] =
	strData[0] = EOS;

	SetPlayerQuestsCheck(playerid);
	return 1;
}

stock SavePlayerQuests(playerid, modeid)
{
	static
		strProgress[500],
		strAll[1000];

	strProgress[0] =
	strAll[0] = EOS;

	switch (modeid) {
		case MODE_TDM: {
			n_for(i, TDM_MAX_QUESTS_PROGRESS) {
				f(strProgress, "%s%d,%d,", strProgress, pInfo[playerid][MODE_TDM][e_Progress][i], pInfo[playerid][MODE_TDM][e_ProgressSum][i]);
			}

			n_for(i, TDM_MAX_QUESTS) {
				f(strAll, "%s%d,", strAll, pInfo[playerid][MODE_TDM][e_List][i]);
			}

			SQL("\
			UPDATE `"DB_QUESTS"` \
			SET \
			`"DB_QUESTS_TDM_PROGRESS"` = '%s', \
			`"DB_QUESTS_TDM_QUESTS"` = '%s' \
			WHERE `"DB_QUESTS_ID"` = '%i'", strProgress, strAll, GetPlayerMySQLID(playerid));
		}
		case MODE_DM: {
			n_for(i, DM_MAX_QUESTS_PROGRESS) {
				f(strProgress, "%s%d,%d,", strProgress, pInfo[playerid][MODE_DM][e_Progress][i], pInfo[playerid][MODE_DM][e_ProgressSum][i]);
			}

			n_for(i, DM_MAX_QUESTS) {
				f(strAll, "%s%d,", strAll, pInfo[playerid][MODE_DM][e_List][i]);
			}

			SQL("\
			UPDATE `"DB_QUESTS"` \
			SET \
			`"DB_QUESTS_DM_PROGRESS"` = '%s', \
			`"DB_QUESTS_DM_QUESTS"` = '%s' \
			WHERE `"DB_QUESTS_ID"` = '%i'", strProgress, strAll, GetPlayerMySQLID(playerid));
		}
	}

	// Checking if the player has completed all quests

	new
		quests;

	n_for(i, TDM_MAX_QUESTS) {
		if (pInfo[playerid][MODE_TDM][e_List][i] == 1) {
			continue;
		}

		quests++;
		break;
	}
	n_for(i, DM_MAX_QUESTS) {
		if (pInfo[playerid][MODE_DM][e_List][i] == 1) {
			continue;
		}

		quests++;
		break; 
	}

	if (quests == 2) {
		AllQuestsDone{playerid} = false;
	}
	else {
		AllQuestsDone{playerid} = true;
	}
	return 1; 
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerQuestData(playerid)
{
	AllQuestsDone{playerid} = false;

	n_for(i, GMS_MAX_MODES) {
		n_for2(q, QUESTS_MAX_PROGRESS) {
			pInfo[playerid][i][e_Progress][q] = -1;
			pInfo[playerid][i][e_ProgressSum][q] = 0;

			ActiveListID[playerid][q] = -1;
		}
		n_for2(q, QUESTS_MAX) {
			pInfo[playerid][i][e_List][q] = 0;
		}
	}
	ActiveListMode[playerid] = MODE_NONE;
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

/*
 * |>---------------<|
 * |   List quests   |
 * |>---------------<|
 */

DialogCreate:QuestsList(playerid)
{
	static
		str[1000];

	str[0] = EOS;

	new
		modeid = GetPVarInt(playerid, "QuestMode"),
		questStart = GetPVarInt(playerid, "QuestStart"),
		questFinish = GetPVarInt(playerid, "QuestFinish"),
		questsProgress = Mode_GetMaxQuestsProgress(modeid),
		questsMax = Mode_GetMaxQuests(modeid);

	DeletePVar(playerid, "QuestLast");
	DeletePVar(playerid, "QuestModeProgress");

	strcat(str, "Название\tПрогресс\n");
	for (new i = questStart, l = 0; i < questFinish; i++, l++) {
		SetPVarInt(playerid, "QuestLast", l);

		if (pInfo[playerid][modeid][e_List][i] == 1) 
			f(str, "%s"CT_ORANGE"%i. "CT_WHITE"%s\t{26eb43}[Выполнено]\n", str, i + 1, qInfo[modeid][i][e_Name]);
		else {
			new
				check;

			n_for(p, questsProgress) {
				if (pInfo[playerid][modeid][e_Progress][p] == i) 
					check++;
			}

			if (check > 0) 
				f(str, "%s"CT_ORANGE"%i. "CT_WHITE"%s\t{dede1f}[В процессе]\n", str, i + 1, qInfo[modeid][i][e_Name]);
			else 
				f(str, "%s"CT_ORANGE"%i. "CT_WHITE"%s\t{eb2626}[Не выполнено]\n", str, i + 1, qInfo[modeid][i][e_Name]);
		}
	}
	if (questStart == 0) {
		f(str, "%s"CT_GREY"Далее >>", str);
	}
	else {
		if (questsMax - questFinish > 0) 
			f(str, "%s"CT_GREY"Далее >>\n", str);
		
		f(str, "%s"CT_GREY"<< Вернуться", str);
	}
	new
		strs[100];

	f(strs, "Квесты в %s режиме", Mode_GetShortName(modeid));
	Dialog_Open(playerid, Dialog:QuestsList, DSTH, strs, str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:QuestsList(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "QuestSelectedList");
		DeletePVar(playerid, "QuestMode");
		DeletePVar(playerid, "QuestStart");
		DeletePVar(playerid, "QuestFinish");
		DeletePVar(playerid, "QuestLast");

		Dialog_Show(playerid, Dialog:QuestsSelectMode);
		return 1;
	}

	new
		selectedList = GetPVarInt(playerid, "QuestSelectedList"),
		questStart = GetPVarInt(playerid, "QuestStart"),
		questFinish = GetPVarInt(playerid, "QuestFinish"),
		quest_last = GetPVarInt(playerid, "QuestLast"),
		modeid = GetPVarInt(playerid, "QuestMode");
	
	new
		//questsProgress = Mode_GetMaxQuestsProgress(modeid),
		questsMax = Mode_GetMaxQuests(modeid);

	if (listitem == quest_last + 1) {
		if (questsMax - questFinish > 0) {
			new 
				check;
			
			if (questsMax - (questFinish + QUESTS_MAX_LIST) > 0) 
				check = 1;
			else 
				check = 0;

			if (check == 1) {
				SetListQuest(playerid, selectedList + 1, modeid, questFinish, questFinish + QUESTS_MAX_LIST);
				Dialog_Show(playerid, Dialog:QuestsList);
			}
			else {
				SetListQuest(playerid, selectedList + 1, modeid, questFinish, questsMax);
				Dialog_Show(playerid, Dialog:QuestsList);
			}
		}
		else {
			if (QUESTS_MAX_LIST - (selectedList * 10 - questFinish) > 0) {
				SetListQuest(playerid, selectedList - 1, modeid, questStart - QUESTS_MAX_LIST, questFinish - (QUESTS_MAX_LIST - (selectedList * 10 - questFinish)));
				Dialog_Show(playerid, Dialog:QuestsList);
			}
			else {
				SetListQuest(playerid, selectedList - 1, modeid, questStart - QUESTS_MAX_LIST, questFinish - QUESTS_MAX_LIST);
				Dialog_Show(playerid, Dialog:QuestsList);
			}
		}
	}
	else if (listitem == quest_last + 2) {
		SetListQuest(playerid, selectedList - 1, modeid, questStart - QUESTS_MAX_LIST, questFinish - QUESTS_MAX_LIST);
		Dialog_Show(playerid, Dialog:QuestsList);
	}
	else {
		for (new i = questStart, l = 0; i < questFinish; l++, i++) {
			if (listitem == l) {
				SetQuestInfo(playerid, modeid, i);
				Dialog_Show(playerid, Dialog:QuestInfo);
			}
		}
	}
	return 1;
}

/*
 * |>---------------<|
 * |   Select mode   |
 * |>---------------<|
 */

DialogCreate:QuestsSelectMode(playerid)
{
	Dialog_Open(playerid, Dialog:QuestsSelectMode, DSL, "Квесты",
	""CT_ORANGE""T_NUM" "CT_WHITE"TDM режим\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"DM режим",
	"Выбрать", "Выход");

	CheckPlayerDinaHint(playerid, 12);
	return 1;
}

DialogResponse:QuestsSelectMode(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "QuestSelectedList");
		DeletePVar(playerid, "QuestMode");
		DeletePVar(playerid, "QuestStart");
		DeletePVar(playerid, "QuestFinish");
		DeletePVar(playerid, "QuestLast");
		return 1;
	}

	switch (listitem) {
		case 0: {
			SetListQuest(playerid, 1, MODE_TDM, 0, QUESTS_MAX_LIST);
			Dialog_Show(playerid, Dialog:QuestsList);
		}
		case 1: {
			SetListQuest(playerid, 1, MODE_DM, 0, QUESTS_MAX_LIST);
			Dialog_Show(playerid, Dialog:QuestsList);
		}
	}
	return 1;
}

/*
 * |>-----------------<|
 * |   List progress   |
 * |>-----------------<|
 */

DialogCreate:QuestsListProgress(playerid)
{
	static
		str[1000];

	str[0] = EOS;

	new
		modeid = GetPVarInt(playerid, "QuestModeProgress"),
		questsProgress = Mode_GetMaxQuestsProgress(modeid);

	n_for(a, questsProgress) {
		ActiveListID[playerid][a] = -1;
	}

	ActiveListMode[playerid] = MODE_NONE;

	strcat(str, "Название\tПроцесс\n"CT_ORANGE""T_NUM" "CT_WHITE"Все квесты\n");
	for (new p = 0, i = 1; p < questsProgress; i++, p++) {
		if (pInfo[playerid][modeid][e_Progress][p] > -1) {
			n_for(a, questsProgress) {
				if (ActiveListID[playerid][a] == -1) {
					ActiveListID[playerid][a] = p;
					ActiveListMode[playerid] = modeid;
					break;
				}
			}
			f(str, "%s"CT_ORANGE"%i. "CT_WHITE"%s\t{dede1f}[%i/%i]\n", str, i, qInfo[modeid][pInfo[playerid][modeid][e_Progress][p]][e_Name], pInfo[playerid][modeid][e_ProgressSum][p], qInfo[modeid][pInfo[playerid][modeid][e_Progress][p]][e_Number]);
		}
	}
	Dialog_Open(playerid, Dialog:QuestsListProgress, DSTH, "Квесты в процессе", str, "Выбрать", "Выход");
	return 1;
}

DialogResponse:QuestsListProgress(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "QuestModeProgress");
		
		n_for(q, QUESTS_MAX_PROGRESS)
			ActiveListID[playerid][q] = -1;
		
		ActiveListMode[playerid] = MODE_NONE;
		return 1;
	}

	new 
		questProgress = Mode_GetMaxQuestsProgress(ActiveListMode[playerid]);
	
	if (listitem == 0) {
		SetListQuest(playerid, 1, GetPVarInt(playerid, "QuestModeProgress"), 0, QUESTS_MAX_LIST);
		Dialog_Show(playerid, Dialog:QuestsList);

		DeletePVar(playerid, "QuestModeProgress");

		n_for(q, QUESTS_MAX_PROGRESS)
			ActiveListID[playerid][q] = -1;
		
		ActiveListMode[playerid] = MODE_NONE;
		return 1;
	}
	n_for(i, questProgress) {
		if (listitem == i + 1) {
			if (ActiveListID[playerid][i] > -1) {
				SetQuestInfo(playerid, ActiveListMode[playerid], pInfo[playerid][ActiveListMode[playerid]][e_Progress][ActiveListID[playerid][i]]);
				Dialog_Show(playerid, Dialog:QuestInfo);

				n_for2(q, QUESTS_MAX_PROGRESS)
					ActiveListID[playerid][q] = -1;
				
				ActiveListMode[playerid] = MODE_NONE;
			}
		}
	}
	return 1;
}

/*
 * |>--------------<|
 * |   Quest info   |
 * |>--------------<|
 */

DialogCreate:QuestInfo(playerid)
{
	new
		modeid = GetPVarInt(playerid, "QuestInfoMode"),
		questid = GetPVarInt(playerid, "QuestInfoID");

	new
		reward[100],
		progress[100],
		progressid = -1;

	DeletePVar(playerid, "QuestInfoMode");
	DeletePVar(playerid, "QuestInfoID");

	if (pInfo[playerid][modeid][e_List][questid] == 1) {
		progress = "{26eb43}Выполнено";
	}
	else {
		new
			check,
			questsProgress = Mode_GetMaxQuestsProgress(modeid);

		n_for(p, questsProgress) {
			if (pInfo[playerid][modeid][e_Progress][p] == questid) {
				check++;
				progressid = p;
			}
		}
		if (check > 0)
			progress = "{dede1f}В процессе";
		else
			progress = "{eb2626}Не выполнено";
	}

	if (qInfo[modeid][questid][e_Exp] > 0) {
		f(reward, "%s{ced422}%i EXP\n", reward, qInfo[modeid][questid][e_Exp]);
	}
	if (qInfo[modeid][questid][e_Money] > 0) {
		f(reward, "%s{22d43d}$%i\n", reward, qInfo[modeid][questid][e_Money]);
	}
	if (GetPlayerSex(playerid) == SEX_MALE) {
		if (qInfo[modeid][questid][e_SkinMale] > 0) {
			f(reward, "%s{22d4b6}%s\n", reward, GetInvNameItem(qInfo[modeid][questid][e_SkinMale]));
		}
	}
	else {
		if (qInfo[modeid][questid][e_SkinFemale] > 0) {
			f(reward, "%s{22d4b6}%s\n", reward, GetInvNameItem(qInfo[modeid][questid][e_SkinFemale]));
		}
	}
	if (qInfo[modeid][questid][e_Item] > 0 && qInfo[modeid][questid][e_ItemCount] > 0) {
		switch (CheckInvItemDestination(qInfo[modeid][questid][e_Item])) {
			case INV_PLAYER_DEST_CASES: {
				f(reward, "%s{e65545}Предмет: %s\n", reward, GetInvNameItem(qInfo[modeid][questid][e_Item]));
			}
			default: {
				f(reward, "%s{e65545}Предмет: %s. Количество: %i\n", reward, GetInvNameItem(qInfo[modeid][questid][e_Item]), qInfo[modeid][questid][e_ItemCount]);
			}
		}
	}

	static
		str[500];

	str[0] = EOS;

	if (progressid > -1)
		f(str, ""CT_WHITE"Квест: {d9910d}%s\n"CT_WHITE"Прогресс: %s [%i/%i]\n\n"CT_WHITE"Информация:\n"CT_GREY"%s\n\n"CT_WHITE"Награда за выполнение:\n"CT_GREY"%s", qInfo[modeid][questid][e_Name], progress, pInfo[playerid][modeid][e_ProgressSum][progressid], qInfo[modeid][questid][e_Number], qInfo[modeid][questid][e_Info], reward);
	else 
		f(str, ""CT_WHITE"Квест: {d9910d}%s\n"CT_WHITE"Прогресс: %s\n\n"CT_WHITE"Информация:\n"CT_GREY"%s\n\n"CT_WHITE"Награда:\n"CT_GREY"%s", qInfo[modeid][questid][e_Name], progress, qInfo[modeid][questid][e_Info], reward);
	
	Dialog_Open(playerid, Dialog:QuestInfo, DSM, "Информация об квесте", str, "Назад", "");
	return 1;
}

DialogResponse:QuestInfo(playerid, response, listitem, inputtext[])
{
	if (GetPVarInt(playerid, "QuestModeProgress") > 0) {
		Dialog_Show(playerid, Dialog:QuestsListProgress);
	}
	else {
		SetListQuest(playerid, GetPVarInt(playerid, "QuestSelectedList"), GetPVarInt(playerid, "QuestMode"), GetPVarInt(playerid, "QuestStart"), GetPVarInt(playerid, "QuestFinish"));
		Dialog_Show(playerid, Dialog:QuestsList);
	}
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
	ResetPlayerQuestData(playerid);

	#if defined Quest_OnPlayerConnect
		return Quest_OnPlayerConnect(playerid);
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
#define OnPlayerConnect Quest_OnPlayerConnect
#if defined Quest_OnPlayerConnect
	forward Quest_OnPlayerConnect(playerid);
#endif