/*
 * |>==============================<|
 * |   About: Database MySQL main   |
 * |   Author: Foxze                |
 * |>==============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- OnGameModeExit()
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

#if defined _INC_DATABASE_MAIN
	#endinput
#endif
#define _INC_DATABASE_MAIN

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

static ConnectDatabase()
{
	MySQLID = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE);
	mysql_set_charset("cp1251");
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

stock MySQL_OnGameModeInit()
{
	print("--------------------------------------");
	printf(" Подключение к базе данных...");
	printf(" ");
	printf(" Хост: "MYSQL_HOST"");
	printf(" Пользователь: "MYSQL_USER"");
	printf(" База данных: "MYSQL_DATABASE"");
	printf(" Пароль: "MYSQL_PASSWORD"");
	printf(" ");

	ConnectDatabase();

	if (mysql_errno() == 0) {
		print(" Подключение к базе данных удалось!");
	}
	else {
		printf(" Подключение к базе данных не удалось [Код ошибки: %i]", mysql_errno());
		printf(" ");

		switch (mysql_errno()) {
			case ER_DBACCESS_DENIED_ERROR: {
				print(" Возможные проблемы:");
				print(" - Неправильное название базы данных");
				print(" - Неправильное имя пользователя");
				print(" - Недостаточные привилегии");
			}
			case ER_ACCESS_DENIED_ERROR: {
				print(" Возможные проблемы:");
				print(" - Неправильное имя пользователя");
				print(" - Неправильный пароль");
			}
			case 1049: {
				print(" Возможные проблемы:");
				print(" - Неправильное название базы данных");
			}
			case 2002: {
				print(" Возможные проблемы:");
				print(" - Неправильное название хоста");
			}
			default: {
				printf(" Неизвестная ошибка");
			}
		}
	}

	print("--------------------------------------\n");
	return 1;
}

/*
 * |>------------------<|
 * |   OnGameModeExit   |
 * |>------------------<|
 */

stock MySQL_OnGameModeExit()
{
	mysql_close(MySQLID);
	return 1;
}