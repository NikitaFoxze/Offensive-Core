/*

	About: Dina system
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		OnPlayerConnect(playerid)
	Stock:
		Dina_CheckPlayerHint(playerid, hint_id, type = 0)
		Dina_SendPlayerMessageLogin(playerid)
		Dina_GetPlayerHint(playerid, num)
		Dina_UploadPlayerData(playerid)
		Dina_SavePlayer(playerid) 
Enums:
	-
Commands:
	-
Dialogs:
	-
Interfaces:
	-
------------------------------------------------------------------------------*/

#if defined _INC_DINA_SYSTEM
	#endinput
#endif
#define _INC_DINA_SYSTEM

/*

	* Vars *

*/

static
	Dina_PlayerHints[MAX_PLAYERS][DINA_MAX_HINTS];

static const
	Dina_TextInfo[DINA_MAX_HINTS][DINA_MAX_TEXT_LENGTH] = {
	/*0*/"Здравствуй! Я Дина и моя задача помочь тебе.",
	/*1*/"Придумай сложный пароль, дабы тебя не взломали!",
	/*2*/"Я награжу того, кто позвал тебя на лучший сервер!",
	/*3*/"Смотри!\nСейчас перед тобой главное меню и в нём есть:\n\n{e3bd27}Играть {d4d4d4}- здесь находятся все игровые режимы.\n{e3bd27}Инвентарь {d4d4d4}- тут хранятся все твои предметы.\n{e3bd27}Торговая площадка {d4d4d4}- это магазин для покупки скинов, аксессуаров и не только.\n\n* Теперь можешь приступать к изучению интересного сервера!",
	/*4*/"В Инвентаре имеются две вкладки, это предметы и баннеры.",
	/*5*/"На Торговой площадке можно покупать скины, аксессуары и не только!",
	/*6*/"Перед тобой уникальные и проработанные до мелочей игровые режимы, скорее же выбери один из них!",
	/*7*/"Сейчас ты находишься в режиме TDM. Для спавна можешь выбрать точку захвата или своего союзника!",
	/*8*/"Ого! Твой первый спавн, исследуй всё вокруг и я в этом помогу!",
	/*9*/"В транспорте имеется спидометр и в нём отображается здоровье, бензин и скорость. Завести: ALT",
	/*10*/"Здесь ты всегда сможешь поменять свой класс персонажа на другой.",
	/*11*/"В каждом классе можно изменить оружие, купить патроны, а также приобрести броню и шлем!",
	/*12*/"Квесты есть на каждом режиме, а в процессе могут быть лишь несколько из них.",
	/*13*/"Молодец, продолжай в том же духе!",
	/*14*/"Да ты настоящий русский хакер!",
	/*15*/"Молодец, теперь быстрее отнеси флаг на свою базу!",
	/*16*/"В своей комнате можно выбрать оружие, карту, режим, создай или присоединись к кому-нибудь!",
	/*17*/"Теперь можешь позвать своих друзей или ожидай случайных игроков!",
	/*18*/"Быстрей же спрячься где-нибудь!",
	/*19*/"Твой первый опыт, кликай на ЛКМ, чтобы быстрее возродиться!"
};

/*

	* Functions *

*/

stock Dina_CheckPlayerHint(playerid, hint_id, type = 0)
{
	if(Dina_PlayerHints[playerid][hint_id] > 0)
		return 1;

	Dina_PlayerHints[playerid][hint_id] = 1;

	static
		str[26 - 2 + 1 + DINA_MAX_TEXT_LENGTH];

	str[0] = EOS;

	if(type == 0) {
		f(str, "{4837de}[ Дина ] {d4d4d4}%s", Dina_TextInfo[0][hint_id]);
		SCMEX(playerid, 0x4837deFF, str, false);
	}
	else {
		f(str, "{4837de}Дина:\n\n{d4d4d4}%s", Dina_TextInfo[0][hint_id]);
		Dialog_Message(playerid, "Подсказка", str, "Хорошо");
	}

	if(!GetPlayerLogged(playerid)) {
		Dina_SavePlayer(playerid);
		PlayerPlaySoundEx(playerid, 17001, 0.0, 0.0, 0.0);
	}
	return 1;
}

stock Dina_SendPlayerMessageLogin(playerid)
{
	new
		random_text = random(6);

	switch(random_text) {
		case 0: {
			SCM(playerid, -1, "{4837de}[ Дина ] {d4d4d4}Я уже заждалась `•_•");
		}
		case 1: {
			SCM(playerid, -1, "{4837de}[ Дина ] {d4d4d4}Бей все рекорды на сервере!");
		}
		case 2: {
			SCM(playerid, -1, "{4837de}[ Дина ] {d4d4d4}Надеюсь сегодня ты что-нибудь купишь.");
		}
		case 3: {
			SCM(playerid, -1, "{4837de}[ Дина ] {d4d4d4}Почему так долго не был(-а) ?)");
		}
		case 4: {
			SCM(playerid, -1, "{4837de}[ Дина ] {d4d4d4}Где пропадал? Я заждалась!");
		}
		case 5: {
			SCM(playerid, -1, "{4837de}[ Дина ] {d4d4d4}Надеюсь ты найдёшь новых друзей!");
		}
	}
	return 1;
}

stock Dina_GetPlayerHint(playerid, num)
{
	return Dina_PlayerHints[playerid][num];
}

/*

	* MySQL *

*/

stock Dina_UploadPlayerData(playerid)
{
	static
		str[DINA_MAX_HINTS * 2 + 10],
		str2[DINA_MAX_HINTS * 2 + 100];

	str[0] = str2[0] = EOS;

	f(str, "p<,>a<i>[%i]", DINA_MAX_HINTS);
	cache_get_value_name(0, "Helper_Dina", str2, sizeof(str2)), sscanf(str2, str, Dina_PlayerHints[playerid]), str[0] = str2[0] = EOS;	
	return 1;
}

stock Dina_SavePlayer(playerid)
{
	static
		str[DINA_MAX_HINTS * 2 + 10],
		query[DINA_MAX_HINTS * 2 + 200];

	str[0] = query[0] = EOS;

	n_for(i, DINA_MAX_HINTS)
		f(str, "%s%i,", str, Dina_PlayerHints[playerid][i]);

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Helper_Dina` = '%s' WHERE `ID` = '%d'", str, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

/*

	* Reset *

*/

static ResetPlayerData(playerid)
{
	n_for(i, DINA_MAX_HINTS)
		Dina_PlayerHints[playerid][i] = 0;

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

	#if defined Dina_OnPlayerConnect
		return Dina_OnPlayerConnect(playerid);
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
#define OnPlayerConnect Dina_OnPlayerConnect
#if defined Dina_OnPlayerConnect
	forward Dina_OnPlayerConnect(playerid);
#endif