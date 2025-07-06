/*
 * |>===========================<|
 * |   About: Dina helper main   |
 * |   Author: Foxze             |
 * |>===========================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnPlayerConnect(playerid)
 * Stock:
	- CheckPlayerDinaHint(playerid, hintid, type = 0)
	- SendPlayerDinaMessageLogin(playerid)
	- GetPlayerDinaHint(playerid, num)

	- MySQLUploadPlayerDinaData(playerid)
	- SavePlayerDina(playerid) 
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

#if defined _INC_DINA_MAIN
	#endinput
#endif
#define _INC_DINA_MAIN

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

// MySQL
static
	pInfo[MAX_PLAYERS][DINA_MAX_HINTS];

// Texts
static const
	TextInfo[DINA_MAX_HINTS][DINA_MAX_LENGTH_TEXT] = {
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
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock CheckPlayerDinaHint(playerid, hintid, type = 0)
{
	if (pInfo[playerid][hintid] > 0) {
		return 1;
	}

	pInfo[playerid][hintid] = 1;

	static
		str[DINA_MAX_LENGTH_TEXT];

	str[0] = EOS;

	if (type == 0) {
		f(str, ""T_DINA" "CT_DARK_WHITE"%s", TextInfo[hintid]);
		SCMEX(playerid, C_VIOLET, str, false);
	}
	else {
		f(str, ""CT_VIOLET"Дина:\n\n"CT_DARK_WHITE"%s", TextInfo[hintid]);
		Dialog_Message(playerid, "Подсказка", str, "Хорошо");
	}

	if (!GetPlayerLogged(playerid)) {
		SavePlayerDina(playerid);
		PlayerPlaySoundEx(playerid, 17001, 0.0, 0.0, 0.0);
	}
	return 1;
}

stock SendPlayerDinaMessageLogin(playerid)
{
	new
		randomText = random(6);

	switch (randomText) {
		case 0: {
			SCM(playerid, C_VIOLET, ""T_DINA" "CT_DARK_WHITE"Я уже заждалась `•_•");
		}
		case 1: {
			SCM(playerid, C_VIOLET, ""T_DINA" "CT_DARK_WHITE"Бей все рекорды на сервере!");
		}
		case 2: {
			SCM(playerid, C_VIOLET, ""T_DINA" "CT_DARK_WHITE"Надеюсь сегодня ты что-нибудь купишь.");
		}
		case 3: {
			SCM(playerid, C_VIOLET, ""T_DINA" "CT_DARK_WHITE"Почему так долго не был(-а) ?)");
		}
		case 4: {
			SCM(playerid, C_VIOLET, ""T_DINA" "CT_DARK_WHITE"Где пропадал? Я заждалась!");
		}
		case 5: {
			SCM(playerid, C_VIOLET, ""T_DINA" "CT_DARK_WHITE"Надеюсь ты найдёшь новых друзей!");
		}
	}
	return 1;
}

stock GetPlayerDinaHint(playerid, num)
{
	return pInfo[playerid][num];
}

/*
 * |>-------------<|
 * |     MySQL     |
 * |>-------------<|
 */

stock MySQLUploadPlayerDinaData(playerid)
{
	static
		strFormat[30],
		strData[(DINA_MAX_HINTS * 2) + 1];

	strFormat[0] =
	strData[0] = EOS;

	f(strFormat, "p<,>a<i>[%i]", DINA_MAX_HINTS);

	cache_get_value_name(0, DB_ACCOUNTS_HELPER_DINA, strData);
	sscanf(strData, strFormat, pInfo[playerid]);
	return 1;
}

stock SavePlayerDina(playerid)
{
	new
		strHints[(DINA_MAX_HINTS * 2) + 1];

	FormatIntArrayToSQL(pInfo[playerid], DINA_MAX_HINTS, strHints);

	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_HELPER_DINA"` = '%s' WHERE `"DB_ACCOUNTS_ID"` = '%i'", strHints, GetPlayerMySQLID(playerid));
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerDinaData(playerid)
{
	n_for(i, DINA_MAX_HINTS) {
		pInfo[playerid][i] = 0;
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
	ResetPlayerDinaData(playerid);

	#if defined Dina_OnPlayerConnect
		return Dina_OnPlayerConnect(playerid);
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
#define OnPlayerConnect Dina_OnPlayerConnect
#if defined Dina_OnPlayerConnect
	forward Dina_OnPlayerConnect(playerid);
#endif