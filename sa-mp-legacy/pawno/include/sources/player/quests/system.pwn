/*

	About: Quests system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnPlayerConnect(playerid)
		Call_UploadPlayerQuests(playerid)
	Stock:
		Quest_CheckPlayerProgress(playerid, mode_id, quest_id, num = 1)
		Quest_SetPlayerProgress(playerid, mode_id, quest_id, num)
		Quest_GetPlayerAllPassed(playerid)
		Quest_CheckPlayerPassedCount(playerid, mode_id)
		Quest_CreateNewUser(playerid, query[1000], str[6000])
		Quest_UploadPlayerData(playerid)
		Quest_SavePlayer(playerid, mode_id)
Enums:
	E_QUEST_INFO
	E_PLAYER_QUEST_INFO
Commands:
	-
Dialogs:
	Quest_List
	Quest_SelectMode
	Quest_ListProgress
	Quest_Info
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_QUESTS_SYSTEM
	#endinput
#endif
#define _INC_QUESTS_SYSTEM

/*

	* Enums *

*/

enum E_QUEST_INFO {
	Q_Name[QUESTS_MAX_NAME_LENGTH],
	Q_Info[QUESTS_MAX_INFO_LENGTH],
	Q_Number,

	QR_Exp,
	QR_Credits,
	QR_SkinMale,
	QR_SkinFemale,
	QR_Item,
	QR_ItemCount
}

enum E_PLAYER_QUEST_INFO {
	qProgress[QUESTS_MAX_PROGRESS],
	qProgressSum[QUESTS_MAX_PROGRESS],
	qList[QUESTS_MAX]
}

/*

	* Vars *

*/

static
	qPlayerInfo[MAX_PLAYERS][GM_MAX_MODES][E_PLAYER_QUEST_INFO],
	qActiveListID[MAX_PLAYERS][QUESTS_MAX_PROGRESS],
	qActiveListMode[MAX_PLAYERS];

static
	bool:AllQuestsDone[MAX_PLAYERS char];

static const
	QuestInfo[GM_MAX_MODES][QUESTS_MAX][E_QUEST_INFO] = {
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

	* Functions *

*/

stock Quest_CheckPlayerProgress(playerid, mode_id, quest_id, num = 1)
{
	new
		quest_progress = -1;

	Quest_CheckPlayerCellProgress(playerid, mode_id, quest_id, quest_progress);

	if(quest_progress > -1) {
		qPlayerInfo[playerid][mode_id][qProgressSum][quest_progress] += num;

		if(qPlayerInfo[playerid][mode_id][qProgressSum][quest_progress] >= QuestInfo[mode_id][qPlayerInfo[playerid][mode_id][qProgress][quest_progress]][Q_Number]) 
			SetPlayerDoneQuest(playerid, mode_id, quest_id);
		else
			Quest_SavePlayer(playerid, mode_id);
	}
	return 1;
}

stock Quest_SetPlayerProgress(playerid, mode_id, quest_id, num)
{
	new
		quest_progress;

	Quest_CheckPlayerCellProgress(playerid, mode_id, quest_id, quest_progress);

	if(quest_progress > -1) {
		qPlayerInfo[playerid][mode_id][qProgressSum][quest_progress] = num;
		Quest_SavePlayer(playerid, mode_id);
	}
	return 1;
}

stock Quest_GetPlayerAllPassed(playerid)
{
	return AllQuestsDone{playerid};
}

stock Quest_CheckPlayerPassedCount(playerid, mode_id)
{
	new
		count_passed;

	for(new i = 0; i < Mode_GetMaxQuests(mode_id); i++) {
		if(qPlayerInfo[playerid][mode_id][qList][i] == 1)
			count_passed++;
	}

	return count_passed;
}

static Quest_CheckPlayerCellProgress(playerid, mode_id, quest_id, &cell_progress)
{
	new
		quests_progress = Mode_GetMaxQuestsProgress(mode_id);

	n_for(i, quests_progress) {
		if(qPlayerInfo[playerid][mode_id][qProgress][i] == quest_id) {
			cell_progress = i;
			return 1;
		}
	}
	return 0;
}

static SetPlayerRewardQuest(playerid, mode_id, questid)
{
	static
		str[52 - 2 + 1 + QUESTS_MAX_NAME_LENGTH];

	str[0] = EOS;

	if(QuestInfo[mode_id][questid][QR_Exp] > 0) {
		SetPlayerExp(playerid, QuestInfo[mode_id][questid][QR_Exp], false, false);

		f(str, "{f58414}(Квест) {e8d123}\"%s\" получено %i EXP", QuestInfo[mode_id][questid][Q_Name], QuestInfo[mode_id][questid][QR_Exp]);
		SCM(playerid, -1, str);
		str[0] = EOS;
	}
	if(QuestInfo[mode_id][questid][QR_Credits] > 0) {
		SetPlayerCredit(playerid, QuestInfo[mode_id][questid][QR_Credits]);

		f(str, "{f58414}(Квест) {e8d123}\"%s\" получено %i$", QuestInfo[mode_id][questid][Q_Name], QuestInfo[mode_id][questid][QR_Credits]);
		SCM(playerid, -1, str);
		str[0] = EOS;
	}
	if(GetPlayerSex(playerid) == SEX_MALE) {
		if(QuestInfo[mode_id][questid][QR_SkinMale] > 0) {
			Inv_SetPlayerItem(playerid, QuestInfo[mode_id][questid][QR_SkinMale], 1);

			f(str, "{f58414}(Квест) {e8d123}\"%s\" получен %s", QuestInfo[mode_id][questid][Q_Name], Inv_GetNameItem(QuestInfo[mode_id][questid][QR_SkinMale]));
			SCM(playerid, -1, str);
			str[0] = EOS;
		}
	}
	else {
		if(QuestInfo[mode_id][questid][QR_SkinFemale] > 0) {
			Inv_SetPlayerItem(playerid, QuestInfo[mode_id][questid][QR_SkinFemale], 1);

			f(str, "{f58414}(Квест) {e8d123}\"%s\" получен %s", QuestInfo[mode_id][questid][Q_Name], Inv_GetNameItem(QuestInfo[mode_id][questid][QR_SkinFemale]));
			SCM(playerid, -1, str);
			str[0] = EOS;
		}	
	}
	if(QuestInfo[mode_id][questid][QR_Item] > 0) {
		switch(Inv_CheckItemDestination(QuestInfo[mode_id][questid][QR_Item])) {
			case INV_PLAYER_DEST_CASES: {
				f(str, "{f58414}(Квест) {e8d123}\"%s\" получен %s", QuestInfo[mode_id][questid][Q_Name], Inv_GetNameItem(QuestInfo[mode_id][questid][QR_Item]));
			}
			default: {
				f(str, "{f58414}(Квест) {e8d123}\"%s\" получен %s. Кол-во %i", QuestInfo[mode_id][questid][Q_Name], Inv_GetNameItem(QuestInfo[mode_id][questid][QR_Item]), QuestInfo[mode_id][questid][QR_ItemCount]);
			}
		}
		Inv_SetPlayerItem(playerid, QuestInfo[mode_id][questid][QR_Item], QuestInfo[mode_id][questid][QR_ItemCount]);

		SCM(playerid, -1, str);
		str[0] = EOS;
	}	
	return 1;
}

static SetPlayerDoneQuest(playerid, mode_id, questid)
{
	qPlayerInfo[playerid][mode_id][qList][questid] = 1;

	new
		progress_id = -1,
		quests_progress = Mode_GetMaxQuestsProgress(mode_id),
		quests_max = Mode_GetMaxQuests(mode_id);

	n_for(i, quests_progress) {
		if(qPlayerInfo[playerid][mode_id][qProgress][i] == questid) {
			progress_id = i;
			break;
		}
	}
	if(progress_id > -1) {
		n_for(i, quests_max) {
			if(qPlayerInfo[playerid][mode_id][qList][i] == 1)
				continue;
			
			new
				proverka;
			
			n_for2(q, quests_progress)
				if(qPlayerInfo[playerid][mode_id][qProgress][q] == i) proverka++;

			if(proverka > 0)
				continue;

			qPlayerInfo[playerid][mode_id][qProgress][progress_id] = i;
			break;
		}
		qPlayerInfo[playerid][mode_id][qProgressSum][progress_id] = 0;

		if(qPlayerInfo[playerid][mode_id][qProgress][progress_id] == questid) 
			qPlayerInfo[playerid][mode_id][qProgress][progress_id] = -1;
	}
	SetPlayerRewardQuest(playerid, mode_id, questid);
	Quest_SavePlayer(playerid, mode_id);
	return 1;
}

static SetPlayerCheckQuests(playerid, mode_id = MODE_NONE)
{
	if(mode_id == MODE_NONE) {
		n_for(m, GM_MAX_MODES) {
			new
				quests_progress = Mode_GetMaxQuestsProgress(mode_id),
				quests_max = Mode_GetMaxQuests(mode_id);

			new
				progress_id[QUESTS_MAX_PROGRESS] = {-1, ...};

			n_for2(i, quests_progress) {
				if(qPlayerInfo[playerid][m][qProgress][i] == -1) {
					n_for3(b, quests_progress) {
						if(progress_id[b] == -1) {
							progress_id[b] = i;
							break;
						}
					}
				}
			}
			n_for2(i, quests_max) {
				if(qPlayerInfo[playerid][m][qList][i] == 1)
					continue;
				
				new
					proverka;

				n_for3(q, quests_progress) {
					if(qPlayerInfo[playerid][m][qProgress][q] == i)
						proverka++;
				}

				if(proverka > 0) 
					continue;

				n_for3(b, quests_progress) {
					if(progress_id[b] > -1) {
						qPlayerInfo[playerid][m][qProgress][progress_id[b]] = i;
						progress_id[b] = -1;
						break;
					}
				}
			}
			Quest_SavePlayer(playerid, m);
		}
	}
	else {
		new
			quests_progress = Mode_GetMaxQuestsProgress(mode_id),
			quests_max = Mode_GetMaxQuests(mode_id);

		new
			progress_id[QUESTS_MAX_PROGRESS] = {-1, ...};

		n_for(i, quests_progress) {
			if(qPlayerInfo[playerid][mode_id][qProgress][i] == -1) {
				n_for2(b, quests_progress) {
					if(progress_id[b] == -1) {
						progress_id[b] = i;
						break;
					}
				}
			}
		}
		n_for(i, quests_max) {
			if(qPlayerInfo[playerid][mode_id][qList][i] == 1)
				continue;
			
			new 
				proverka;

			n_for2(q, quests_progress) {
				if(qPlayerInfo[playerid][mode_id][qProgress][q] == i)
					proverka++;
			}
				
			if(proverka > 0) 
				continue;

			n_for2(b, quests_progress) {
				if(progress_id[b] > -1) {
					qPlayerInfo[playerid][mode_id][qProgress][progress_id[b]] = i;
					progress_id[b] = -1;
					break;
				}
			}
		}
		Quest_SavePlayer(playerid, mode_id);
	}
	return 1;
}

static SetListQuest(playerid, cell, mode_id, quest_start, quest_finish)
{
	SetPVarInt(playerid, "Quest_Selected_List_PVar", cell);
	SetPVarInt(playerid, "Quest_Mode_PVar", mode_id);
	SetPVarInt(playerid, "Quest_Start_PVar", quest_start);
	SetPVarInt(playerid, "Quest_Finish_PVar", quest_finish);
}

static SetQuestInfo(playerid, mode_id, quest_id)
{
	SetPVarInt(playerid, "QuestI_Mode_PVar", mode_id);
	SetPVarInt(playerid, "QuestI_ID_PVar", quest_id);
	return 1;
}

/*

	* MySQL *

*/

stock Quest_CreateNewUser(playerid, query[1000], str[6000])
{
	static 
		text[QUESTS_MAX * 2 + 1];

	text[0] = EOS;

	f(str, "INSERT INTO `"T_QUESTS"` (`ID`,`TDM_quests_progress`,`TDM_quests`,`DM_quests_progress`,`DM_quests`) VALUES ");
	strcat(str, "(");

	f(query, "'%i',", GetPlayerpID(playerid)), strcat(str, query), query[0] = EOS; // ID

	// TDM_quests_progress
	n_for(i, TDM_MAX_QUESTS_PROGRESS) {
		f(text, "%s%i,0,", text, i);
		qPlayerInfo[playerid][MODE_TDM][qProgress][i] = i;
	}
	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// TDM_quests
	n_for(i, TDM_MAX_QUESTS)
		strcat(text, "0,");

	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// DM_quests_progress
	n_for(i, DM_MAX_QUESTS_PROGRESS) {
		f(text, "%s%i,0,", text, i);
		qPlayerInfo[playerid][MODE_DM][qProgress][i] = i;
	}
	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// DM_quests
	n_for(i, DM_MAX_QUESTS)
		strcat(text, "0,");

	f(query, "'%s'", text), strcat(str, query), query[0] = text[0] = EOS;

	strcat(str, ")");
	mysql_tquery(MysqlID, str);
	return 1;
}

stock Quest_UploadPlayerData(playerid)
{
	static
		query[100 + 1];

	query[0] = EOS;

	mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_QUESTS"` WHERE `ID` = '%i' LIMIT 1", GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query, "Call_UploadPlayerQuests", "i", playerid);
	return 1;
}

publics Call_UploadPlayerQuests(playerid)
{
	static
		str[50],
		str2[400];

	str[0] = str2[0] = EOS;
	
	new
		m[6];

	// TDM режим
	f(str, "p<,>a<i>[%i]", TDM_MAX_QUESTS_PROGRESS * 2);
	cache_get_value_name(0, "TDM_quests_progress", str2, sizeof(str2));
	sscanf(str2, str, m);
	str[0] = str2[0] = EOS;

	for(new i = 0, b = 0; b < TDM_MAX_QUESTS_PROGRESS; b++, i += 2) {
		qPlayerInfo[playerid][MODE_TDM][qProgress][b] = m[i]; 
		qPlayerInfo[playerid][MODE_TDM][qProgressSum][b] = m[i + 1]; 
	}

	f(str, "p<,>a<i>[%i]", TDM_MAX_QUESTS);
	cache_get_value_name(0, "TDM_quests", str2, sizeof(str2));
	sscanf(str2, str, qPlayerInfo[playerid][MODE_TDM][qList]);
	str[0] = str2[0] = EOS;

	// DM режим
	f(str, "p<,>a<i>[%i]", DM_MAX_QUESTS_PROGRESS * 2);
	cache_get_value_name(0, "DM_quests_progress", str2, sizeof(str2));
	sscanf(str2, str, m);
	str[0] = str2[0] = EOS;

	for(new i = 0, b = 0; b < DM_MAX_QUESTS_PROGRESS; b++, i += 2) {
		qPlayerInfo[playerid][MODE_DM][qProgress][b] = m[i]; 
		qPlayerInfo[playerid][MODE_DM][qProgressSum][b] = m[i + 1]; 
	}

	f(str, "p<,>a<i>[%i]", DM_MAX_QUESTS);
	cache_get_value_name(0, "DM_quests", str2, sizeof(str2));
	sscanf(str2, str, qPlayerInfo[playerid][MODE_DM][qList]);
	str[0] = str2[0] = EOS;

	SetPlayerCheckQuests(playerid);
	return 1;
}

stock Quest_SavePlayer(playerid, mode_id)
{
	static
		str[400],
		query[500];

	str[0] = query[0] = EOS;

	switch(mode_id) {
		case MODE_TDM: {
			n_for(i, TDM_MAX_QUESTS_PROGRESS)
				f(str, "%s%d,%d,", str, qPlayerInfo[playerid][MODE_TDM][qProgress][i], qPlayerInfo[playerid][MODE_TDM][qProgressSum][i]);

			mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_QUESTS"` SET `TDM_quests_progress` = '%s' WHERE `ID` = '%d'", str, GetPlayerpID(playerid));
			mysql_tquery(MysqlID, query);
			str[0] = query[0] = EOS;

			n_for(i, TDM_MAX_QUESTS)
				f(str, "%s%d,", str, qPlayerInfo[playerid][MODE_TDM][qList][i]);

			mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_QUESTS"` SET `TDM_quests` = '%s' WHERE `ID` = '%d'", str, GetPlayerpID(playerid));
			mysql_tquery(MysqlID, query);
			str[0] = query[0] = EOS;
		}
		case MODE_DM: {
			n_for(i, DM_MAX_QUESTS_PROGRESS)
				f(str, "%s%d,%d,", str, qPlayerInfo[playerid][MODE_DM][qProgress][i], qPlayerInfo[playerid][MODE_DM][qProgressSum][i]);

			mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_QUESTS"` SET `DM_quests_progress` = '%s' WHERE `ID` = '%d'", str, GetPlayerpID(playerid));
			mysql_tquery(MysqlID, query);
			str[0] = query[0] = EOS;

			n_for(i, DM_MAX_QUESTS)
				f(str, "%s%d,", str, qPlayerInfo[playerid][MODE_DM][qList][i]);

			mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_QUESTS"` SET `DM_quests` = '%s' WHERE `ID` = '%d'", str, GetPlayerpID(playerid));
			mysql_tquery(MysqlID, query);
			str[0] = query[0] = EOS;
		}
	}

	// Проверка, выполнил ли игрок все квесты

	new
		quests;

	n_for(i, TDM_MAX_QUESTS) {
		if(qPlayerInfo[playerid][MODE_TDM][qList][i] == 1)
			continue;

		quests++;
		break;
	}
	n_for(i, DM_MAX_QUESTS) {
		if(qPlayerInfo[playerid][MODE_DM][qList][i] == 1)
			continue;

		quests++;
		break; 
	}

	if(quests == 2)
		AllQuestsDone{playerid} = false;
	else
		AllQuestsDone{playerid} = true;

	return 1; 
}

/*

	* Reset *

*/

static ResetPlayerData(playerid)
{
	AllQuestsDone{playerid} = false;

	n_for(i, GM_MAX_MODES) {
		n_for2(q, QUESTS_MAX_PROGRESS) {
			qPlayerInfo[playerid][i][qProgress][q] = -1;
			qPlayerInfo[playerid][i][qProgressSum][q] = 0;

			qActiveListID[playerid][q] = -1;
		}
		n_for2(q, QUESTS_MAX)
			qPlayerInfo[playerid][i][qList][q] = 0;
	}
	qActiveListMode[playerid] = MODE_NONE;
	return 1;
}

/*

	* Dialogs *

*/

DialogCreate:Quest_List(playerid)
{
	static
		str[1000];

	str[0] = EOS;

	new
		mode_id = GetPVarInt(playerid, "Quest_Mode_PVar"),
		quest_start = GetPVarInt(playerid, "Quest_Start_PVar"),
		quest_finish = GetPVarInt(playerid, "Quest_Finish_PVar"),
		quests_progress = Mode_GetMaxQuestsProgress(mode_id),
		max_quests = Mode_GetMaxQuests(mode_id);

	DeletePVar(playerid, "Quest_Last_PVar");
	DeletePVar(playerid, "Quest_Mode_Progress_PVar");

	strcat(str, "Название\tПрогресс\n");
	for(new i = quest_start, l = 0; i < quest_finish; i++, l++) {
		SetPVarInt(playerid, "Quest_Last_PVar", l);

		if(qPlayerInfo[playerid][mode_id][qList][i] == 1) 
			f(str, "%s"C_N"%i. {FFFFFF}%s\t{26eb43}[Выполнено]\n", str, i + 1, QuestInfo[mode_id][i][Q_Name]);
		else {
			new
				proverka;

			n_for(p, quests_progress) {
				if(qPlayerInfo[playerid][mode_id][qProgress][p] == i) 
					proverka++;
			}

			if(proverka > 0) 
				f(str, "%s"C_N"%i. {FFFFFF}%s\t{dede1f}[В процессе]\n", str, i + 1, QuestInfo[mode_id][i][Q_Name]);
			else 
				f(str, "%s"C_N"%i. {FFFFFF}%s\t{eb2626}[Не выполнено]\n", str, i + 1, QuestInfo[mode_id][i][Q_Name]);
		}
	}
	if(quest_start == 0)
		f(str, "%s{CCCCCC}Далее >>", str);
	else {
		if(max_quests - quest_finish > 0) 
			f(str, "%s{CCCCCC}Далее >>\n", str);
		
		f(str, "%s{CCCCCC}<< Вернуться", str);
	}
	new
		strs[100];

	f(strs, "Квесты в %s режиме", Mode_GetName(mode_id));
	Dialog_Open(playerid, Dialog:Quest_List, DSTH, strs, str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:Quest_List(playerid, response, listitem, inputtext[])
{
	if(response) {
		new
			selected_list = GetPVarInt(playerid, "Quest_Selected_List_PVar"),
			quest_start = GetPVarInt(playerid, "Quest_Start_PVar"),
			quest_finish = GetPVarInt(playerid, "Quest_Finish_PVar"),
			quest_last = GetPVarInt(playerid, "Quest_Last_PVar"),
			mode_id = GetPVarInt(playerid, "Quest_Mode_PVar");
		
		new
			//quests_progress = Mode_GetMaxQuestsProgress(mode_id),
			quests_max = Mode_GetMaxQuests(mode_id);

		if(listitem == quest_last + 1) {
			if(quests_max - quest_finish > 0) {
				new 
					proverka;
				
				if(quests_max - (quest_finish + QUESTS_MAX_LIST) > 0) 
					proverka = 1;
				else 
					proverka = 0;

				if(proverka == 1) {
					SetListQuest(playerid, selected_list + 1, mode_id, quest_finish, quest_finish + QUESTS_MAX_LIST);
					Dialog_Show(playerid, Dialog:Quest_List);
				}
				else {
					SetListQuest(playerid, selected_list + 1, mode_id, quest_finish, quests_max);
					Dialog_Show(playerid, Dialog:Quest_List);
				}
			}
			else {
				if(QUESTS_MAX_LIST - (selected_list * 10 - quest_finish) > 0) {
					SetListQuest(playerid, selected_list - 1, mode_id, quest_start - QUESTS_MAX_LIST, quest_finish - (QUESTS_MAX_LIST - (selected_list * 10 - quest_finish)));
					Dialog_Show(playerid, Dialog:Quest_List);
				}
				else {
					SetListQuest(playerid, selected_list - 1, mode_id, quest_start - QUESTS_MAX_LIST, quest_finish - QUESTS_MAX_LIST);
					Dialog_Show(playerid, Dialog:Quest_List);
				}
			}
		}
		else if(listitem == quest_last + 2) {
			SetListQuest(playerid, selected_list - 1, mode_id, quest_start - QUESTS_MAX_LIST, quest_finish - QUESTS_MAX_LIST);
			Dialog_Show(playerid, Dialog:Quest_List);
		}
		else {
			for(new i = quest_start, l = 0; i < quest_finish; l++, i++) {
				if(listitem == l) {
					SetQuestInfo(playerid, mode_id, i);
					Dialog_Show(playerid, Dialog:Quest_Info);
				}
			}
		}
	}
	else {
		DeletePVar(playerid, "Quest_Selected_List_PVar");
		DeletePVar(playerid, "Quest_Mode_PVar");
		DeletePVar(playerid, "Quest_Start_PVar");
		DeletePVar(playerid, "Quest_Finish_PVar");
		DeletePVar(playerid, "Quest_Last_PVar");

		Dialog_Show(playerid, Dialog:Quest_SelectMode);
	}
	return 1;
}

DialogCreate:Quest_SelectMode(playerid)
{
	Dialog_Open(playerid, Dialog:Quest_SelectMode, DSL, "Квесты", ""C_N"• {FFFFFF}TDM режим\n"C_N"• {FFFFFF}DM режим", "Выбрать", "Выход");
	Dina_CheckPlayerHint(playerid, 12);
	return 1;
}

DialogResponse:Quest_SelectMode(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				SetListQuest(playerid, 1, MODE_TDM, 0, QUESTS_MAX_LIST);
				Dialog_Show(playerid, Dialog:Quest_List);
			}
			case 1: {
				SetListQuest(playerid, 1, MODE_DM, 0, QUESTS_MAX_LIST);
				Dialog_Show(playerid, Dialog:Quest_List);
			}
		}
	}
	else {
		DeletePVar(playerid, "Quest_Selected_List_PVar");
		DeletePVar(playerid, "Quest_Mode_PVar");
		DeletePVar(playerid, "Quest_Start_PVar");
		DeletePVar(playerid, "Quest_Finish_PVar");
		DeletePVar(playerid, "Quest_Last_PVar");
	}
	return 1;
}

DialogCreate:Quest_ListProgress(playerid)
{
	static
		str[1000];

	str[0] = EOS;

	new
		mode_id = GetPVarInt(playerid, "Quest_Mode_Progress_PVar"),
		quests_progress = Mode_GetMaxQuestsProgress(mode_id);

	n_for(a, quests_progress)
		qActiveListID[playerid][a] = -1;

	qActiveListMode[playerid] = MODE_NONE;

	strcat(str, "Название\tПроцесс\n"C_N"• {FFFFFF}Все квесты\n");
	for(new p = 0, i = 1; p < quests_progress; i++, p++) {
		if(qPlayerInfo[playerid][mode_id][qProgress][p] > -1) {
			n_for(a, quests_progress) {
				if(qActiveListID[playerid][a] == -1) {
					qActiveListID[playerid][a] = p;
					qActiveListMode[playerid] = mode_id;
					break;
				}
			}
			f(str, "%s"C_N"%i. {FFFFFF}%s\t{dede1f}[%i/%i]\n", str, i, QuestInfo[mode_id][qPlayerInfo[playerid][mode_id][qProgress][p]][Q_Name], qPlayerInfo[playerid][mode_id][qProgressSum][p], QuestInfo[mode_id][qPlayerInfo[playerid][mode_id][qProgress][p]][Q_Number]);
		}
	}
	Dialog_Open(playerid, Dialog:Quest_ListProgress, DSTH, "Квесты в процессе", str, "Выбрать", "Выход");
	return 1;
}

DialogResponse:Quest_ListProgress(playerid, response, listitem, inputtext[])
{
	if(response) {
		new 
			quest_progress = Mode_GetMaxQuestsProgress(qActiveListMode[playerid]);
		
		if(listitem == 0) {
			SetListQuest(playerid, 1, GetPVarInt(playerid, "Quest_Mode_Progress_PVar"), 0, QUESTS_MAX_LIST);
			Dialog_Show(playerid, Dialog:Quest_List);

			DeletePVar(playerid, "Quest_Mode_Progress_PVar");

			n_for(q, QUESTS_MAX_PROGRESS)
				qActiveListID[playerid][q] = -1;
			
			qActiveListMode[playerid] = MODE_NONE;
			return 1;
		}
		n_for(i, quest_progress) {
			if(listitem == i + 1) {
				if(qActiveListID[playerid][i] > -1) {
					SetQuestInfo(playerid, qActiveListMode[playerid], qPlayerInfo[playerid][qActiveListMode[playerid]][qProgress][qActiveListID[playerid][i]]);
					Dialog_Show(playerid, Dialog:Quest_Info);

					n_for2(q, QUESTS_MAX_PROGRESS)
						qActiveListID[playerid][q] = -1;
					
					qActiveListMode[playerid] = MODE_NONE;
				}
			}
		}
	}
	else {
		DeletePVar(playerid, "Quest_Mode_Progress_PVar");
		
		n_for(q, QUESTS_MAX_PROGRESS)
			qActiveListID[playerid][q] = -1;
		
		qActiveListMode[playerid] = MODE_NONE;
	}
	return 1;
}

DialogCreate:Quest_Info(playerid)
{
	new
		mode_id = GetPVarInt(playerid, "QuestI_Mode_PVar"),
		quest_id = GetPVarInt(playerid, "QuestI_ID_PVar");

	new
		reward[100],
		progress[100],
		progress_id = -1;

	DeletePVar(playerid, "QuestI_Mode_PVar");
	DeletePVar(playerid, "QuestI_ID_PVar");

	if(qPlayerInfo[playerid][mode_id][qList][quest_id] == 1) {
		progress = "{26eb43}Выполнено";
	}
	else {
		new
			proverka,
			quests_progress = Mode_GetMaxQuestsProgress(mode_id);

		n_for(p, quests_progress) {
			if(qPlayerInfo[playerid][mode_id][qProgress][p] == quest_id) {
				proverka++;
				progress_id = p;
			}
		}
		if(proverka > 0)
			progress = "{dede1f}В процессе";
		else
			progress = "{eb2626}Не выполнено";
	}

	if(QuestInfo[mode_id][quest_id][QR_Exp] > 0) {
		f(reward, "%s{ced422}%i EXP\n", reward, QuestInfo[mode_id][quest_id][QR_Exp]);
	}
	if(QuestInfo[mode_id][quest_id][QR_Credits] > 0) {
		f(reward, "%s{22d43d}%i$\n", reward, QuestInfo[mode_id][quest_id][QR_Credits]);
	}
	if(GetPlayerSex(playerid) == SEX_MALE) {
		if(QuestInfo[mode_id][quest_id][QR_SkinMale] > 0) {
			f(reward, "%s{22d4b6}%s\n", reward, Inv_GetNameItem(QuestInfo[mode_id][quest_id][QR_SkinMale]));
		}
	}
	else {
		if(QuestInfo[mode_id][quest_id][QR_SkinFemale] > 0) {
			f(reward, "%s{22d4b6}%s\n", reward, Inv_GetNameItem(QuestInfo[mode_id][quest_id][QR_SkinFemale]));
		}
	}
	if(QuestInfo[mode_id][quest_id][QR_Item] > 0 && QuestInfo[mode_id][quest_id][QR_ItemCount] > 0) {
		switch(Inv_CheckItemDestination(QuestInfo[mode_id][quest_id][QR_Item])) {
			case INV_PLAYER_DEST_CASES: {
				f(reward, "%s{e65545}Предмет: %s\n", reward, Inv_GetNameItem(QuestInfo[mode_id][quest_id][QR_Item]));
			}
			default: {
				f(reward, "%s{e65545}Предмет: %s. Количество: %i\n", reward, Inv_GetNameItem(QuestInfo[mode_id][quest_id][QR_Item]), QuestInfo[mode_id][quest_id][QR_ItemCount]);
			}
		}
	}

	static
		str[500];

	str[0] = EOS;

	if(progress_id > -1)
		f(str, "{FFFFFF}Квест: {d9910d}%s\n{FFFFFF}Прогресс: %s [%i/%i]\n\n{FFFFFF}Информация:\n{CCCCCC}%s\n\n{FFFFFF}Награда за выполнение:\n{CCCCCC}%s", QuestInfo[mode_id][quest_id][Q_Name], progress, qPlayerInfo[playerid][mode_id][qProgressSum][progress_id], QuestInfo[mode_id][quest_id][Q_Number], QuestInfo[mode_id][quest_id][Q_Info], reward);
	else 
		f(str, "{FFFFFF}Квест: {d9910d}%s\n{FFFFFF}Прогресс: %s\n\n{FFFFFF}Информация:\n{CCCCCC}%s\n\n{FFFFFF}Награда:\n{CCCCCC}%s", QuestInfo[mode_id][quest_id][Q_Name], progress, QuestInfo[mode_id][quest_id][Q_Info], reward);
	
	Dialog_Open(playerid, Dialog:Quest_Info, DSM, "Информация об квесте", str, "Назад", "");
	return 1;
}

DialogResponse:Quest_Info(playerid, response, listitem, inputtext[])
{
	if(GetPVarInt(playerid, "Quest_Mode_Progress_PVar") > 0)
		Dialog_Show(playerid, Dialog:Quest_ListProgress);
	else {
		SetListQuest(playerid, GetPVarInt(playerid, "Quest_Selected_List_PVar"), GetPVarInt(playerid, "Quest_Mode_PVar"), GetPVarInt(playerid, "Quest_Start_PVar"), GetPVarInt(playerid, "Quest_Finish_PVar"));
		Dialog_Show(playerid, Dialog:Quest_List);
	}
	return 1;
}

/*

	* Callbacks *

*/

/*
	OnPlayerConnect
*/

public OnPlayerConnect(playerid)
{
	ResetPlayerData(playerid);

	#if defined Quest_OnPlayerConnect
		return Quest_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}

/*
	ALS
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