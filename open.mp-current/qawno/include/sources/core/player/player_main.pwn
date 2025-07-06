/*
 * |>======================<|
 * |   About: Player main   |
 * |   Author: Foxze        |
 * |>======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- OnGameModeInit()
	- PC_OnInit()
	- OnPlayerRequestSpawn(playerid)
	- OnPlayerRequestClass(playerid, classid)
	- OnPlayerConnect(playerid)
	- OnPlayerDisconnect(playerid, reason)
	- OnPlayerSpawn(playerid)
	- OnPlayerDeath(playerid, killerid, WEAPON:reason)
	- OnPlayerText(playerid, text[])
	- OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
	- OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
	- OnPlayerUpdate(playerid)
	- OnPlayerCommandReceived(playerid, cmd[], params[], flags)

	# Technical #
	- CallUpdatePlayerData(playerid)
	- CallKicker(playerid)
	- CallClearPlayerAnim(playerid)
	- CallUnFreeze(playerid, bool:freeze)
	- CallFreezingPos(playerid)
	- CallPlayerLoggedTimer(playerid)
	- CallUnfreezeCw(playerid)
	- MySQLCreateAccountBackpack(playerid)
	- MySQLUploadPlayerAccount(playerid)
	- MySQLGetPlayerData(playerid)
	- MySQLOnPlayerBanLoad(playerid)
	- MySQLUpdateAccountReferal(playerid)
	- MySQLCheckRegisterReferal(playerid, const nickname[])
	- MySQLSetPlayerPassword(playerid)
	- MySQLCheckPlayerPassword(playerid)
 * Stock:
	- SetPlayerMySQLID(playerid, num)
	- GetPlayerMySQLID(playerid)

	- SetPlayerNameEx(playerid, const name[])
	- GetPlayerNameEx(playerid)

	- SetPlayerPassword(playerid, const password[])
	- GetPlayerPassword(playerid)

	- SetPlayerReferal(playerid, const name[])
	- GetPlayerReferal(playerid)
	- SetCheckNameReferal(playerid, const name[])

	- SetPlayerFoundServer(playerid, foundid)
	- GetPlayerFoundServer(playerid)

	- SetPlayerIPReg(playerid, const ip[])
	- GetPlayerIPReg(playerid)

	- SetPlayerIPLast(playerid, const ip[])
	- GetPlayerIPLast(playerid)

	- SetPlayerSex(playerid, sexid)
	- GetPlayerSex(playerid)

	- GivePlayerRank(playerid, rank, bool:message = false)
	- ResetPlayerRank(playerid)
	- GetPlayerRank(playerid)

	- GivePlayerExp(playerid, exp, bool:message = false, bool:matchScore = true)
	- ResetPlayerExp(playerid)
	- GetPlayerExp(playerid)

	- GivePlayerMoneyEx(playerid, money, bool:message = false)
	- ResetPlayerMoneyEx(playerid)
	- GetPlayerMoneyEx(playerid)

	- GivePlayerWarns(playerid, warns)
	- ResetPlayerWarns(playerid)
	- GetPlayerWarns(playerid)

	- GivePlayerGoldCoins(playerid, goldCoins, bool:message = false)
	- ResetPlayerGoldCoins(playerid)
	- GetPlayerGoldCoins(playerid)

	- GivePlayerKills(playerid, kills)
	- GetPlayerKills(playerid)

	- GivePlayerDeaths(playerid, deaths)
	- GetPlayerDeaths(playerid)

	- GivePlayerWinningMatchs(playerid, matchs)
	- GetPlayerWinningMatchs(playerid)

	- GivePlayerLosingMatchs(playerid, matchs)
	- GetPlayerLosingMatchs(playerid)

	- GivePlayerShotsEnemy(playerid, shots)
	- GetPlayerShotsEnemy(playerid)

	- GivePlayerShotsHead(playerid, shots)
	- GetPlayerShotsHead(playerid)

	- GivePlayerSeriesKills(playerid, kills)
	- GetPlayerSeriesKills(playerid)

	- GivePlayerPlayHours(playerid, hours)
	- GetPlayerPlayHours(playerid)

	- GivePlayerPlayMinutes(playerid, minutes)
	- GetPlayerPlayMinutes(playerid)

	- BuyPlayerAnimation(playerid, cellid)
	- GetPlayerAnimation(playerid, cellid)

	- SetPlayerBlacklistPlayer(playerid, cellid, playerBlack)
	- GetPlayerBlacklist(playerid, cellid)

	- SetPlayerRegDatetime(playerid, const datetime[])
	- GetPlayerRegDatetime(playerid)

	- SetPlayerLastDatetime(playerid, const datetime[])
	- GetPlayerLastDatetime(playerid)

	- SetPlayerVirtualWorldEx(playerid, worldid)
	- GetPlayerVirtualWorldEx(playerid)

	- SetPlayerInteriorEx(playerid, interiorid)
	- GetPlayerInteriorEx(playerid)

	- SetPlayerCustomClass(playerid, classid)
	- GetPlayerCustomClass(playerid)

	- SetPlayerCustomClass2(playerid, classid)
	- GetPlayerCustomClass2(playerid)

	- SetPlayerMute(playerid, minutes)
	- GetPlayerMute(playerid)

	- SetPlayerColorEx(playerid, color)
	- GetPlayerColorEx(playerid)

	- SetPlayerHealthEx(playerid, Float:health)
	- GetPlayerHealthEx(playerid, &Float:health)

	- SetPlayerArmourEx(playerid, Float:armour)
	- GetPlayerArmourEx(playerid, &Float:armour)

	- SetPlayerSpectating(playerid, spectedid)
	- GetPlayerSpectating(playerid)
	- SetPlayerSpecStatus(playerid, status)
	- GetPlayerSpecStatus(playerid)
	- SpecPl(playerid, bool:spec)
	- GetSpecPl(playerid)
	- UpdateSpectatingPlayer(playerid, spectedid)
	- UpdateSpectatingStatus(playerid, spectedid)
	- AddPlayerSpecatingPlayer(playerid, spectedid)
	- RemovePlayerSpectatingPlayer(playerid, spectedid)
	- GetPlayerSpecatingPlayers(playerid)

	- PlayerPlaySoundEx(playerid, sound, Float:x, Float:y, Float:z)

	- SetPlayerTeamEx(playerid, team)
	- GetPlayerTeamEx(playerid)

	- SetPlayerSkinEx(playerid, skinid)
	- GetPlayerSkinEx(playerid)

	- SetPlayerFightingStyleEx(playerid, FIGHT_STYLE:style)
	- GetPlayerFightingStyleEx(playerid)

	- SetPlayerStatusDead(playerid, status)
	- GetPlayerDead(playerid)
	- RemovePlayerDead(playerid)

	- KickPlayerEx(playerid, delay = 5000)

	- SetPlayerDamage(playerid, bool:type)
	- GetPlayerDamage(playerid)

	- SetPlayerAnimationEx(playerid, bool:type)
	- GetPlayerAnimationEx(playerid)
	- StartPlayerTimerClearAnim(playerid, seconds = 0)

	- SetPlayerSpeedRespawn(playerid, seconds)
	- GivePlayerSpeedRespawn(playerid, seconds)
	- GetPlayerSpeedRespawn(playerid)
	- UpdatePlayerSpeedRespawn(playerid)
	- UpdateBarTimeRespawn(playerid)

	- SetPlayerFreeze(playerid, time = 1, bool:freeze = true)
	- GetPlayerFreeze(playerid)

	- GivePlayerSecondTime(playerid)
	- GetPlayerSecondTime(playerid)
	- GivePlayerMinuteTime(playerid)
	- GetPlayerMinuteTime(playerid)
	- GivePlayerHourTime(playerid)
	- GetPlayerHourTime(playerid)

	- SetPlayerAntiKeys(playerid, KEY:keys)
	- GetPlayerAntiKeys(playerid)

	- SetPlayerInvisible(playerid, bool:type)
	- GetPlayerInvisible(playerid)

	- GivePlayerKillStrike(playerid, num)
	- ResetPlayerKillStrike(playerid)
	- GetPlayerKillStrike(playerid)

	- SetPlayerCanSpectating(playerid, bool:type)
	- GetPlayerCanSpectating(playerid)

	- SetPlayerActionZone(playerid, bool:type)
	- GetPlayerActionZone(playerid)

	- SetPlayerClickTD(playerid, bool:type)
	- GetPlayerClickTD(playerid)

	- SetPlayerWeatherEx(playerid, weatherid)
	- GetPlayerWeatherEx(playerid)

	- SetPlayerCheckPlayerid(playerid, playerCheck)
	- GetPlayerCheckPlayerid(playerid)

	- SetSpawnInfoEx(playerid, skin, Float:x, Float:y, Float:z, Float:angle)
	- GetSpawnInfoPosEx(playerid, &Float:x, &Float:y, &Float:z)

	- SetPlayerLogged(playerid, bool:logged)
	- GetPlayerLogged(playerid)
	- SetPlayerLoggedTimer(playerid, seconds)
	- KillPlayerLoggedTimer(playerid)

	- DeaglePlayerAntiC(playerid)

	- ShowPlayerKillStrike(playerid)
	- HidePlayerKillStrike(playerid)

	- SetPlayerSpawnKill(playerid)
	- DestroyPlayerSpawnKill(playerid)

	- ShowPlayerExitZone(playerid) 
	- HidePlayerExitZone(playerid)
	- GetPlayerExitZone(playerid)

	- DestroyPlayerBelowHealth(playerid)
	- UpdatePlayerBelowHealth(playerid)

	- SetPlayerIDStats(playerid, playerid2)
	- GetPlayerIDStats(playerid)

	- SetPlayerLastDamage(playerid)
	- ResetPlayerLastDamage(playerid)
	- GetPlayerLastDamage(playerid)
	- GetPlayerLastDamageTimer(playerid)

	- CreatePlayerDeadKillerTD(playerid)
	- DestroyPlayerDeadKillerTD(playerid, type)
	- CreatePlayerAfterDeadTD(playerid)

	# Base Indicators #
	- CreatePlayerBaseIndicatorsTD(playerid)
	- DestroyPlayerBaseIndicatorsTD(playerid)
	- ShowPlayerBaseIndicatorsTD(playerid)
	- HidePlayerBaseIndicatorsTD(playerid)

	# Net Graph #
	- CreatePlayerNetGraphTD(playerid)
	- DestroyPlayerNetGraphTD(playerid)
	- ShowPlayerNewGraphTD(playerid)
	- HidePlayerNewGraphTD(playerid)

	# Match stats #
	- ShowPlayerMatchStatsTD(playerid)
	- DestroyPlayerMatchStatsTD(playerid, bool:hide = true)

	- PlayerSpawn(playerid)
	- SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, spawnWorld, spawnInterior, setUP = false, freezing = false)
	- DestroyPlayerAttachedObjects(playerid)
	- SendPlayerMessageCMD(playerid, const text[])
	- SetErrorText(playerid, const text[])
	- IsPlayerInArea(playerid, Float:minX, Float:minY ,Float:maxX, Float:maxY)
	- GetPlayerSpeed(playerid)
	- GetPlayerFPS(playerid)
	- ClearPlayerChat(playerid)
	- DestroyPlayerTD(playerid, &PlayerText:tdid)
	- DestroyPlayerText3D(playerid, &PlayerText3D:text3did)
	- PreloadAnimLib(playerid, const animlib[])
	- PreloadAllAnimLibs(playerid)
	- TDRandomColor(playerid, PlayerText:tdid)
	- TDRandomVehicle(playerid, PlayerText:tdid)
	- ClosePlayerDialog(playerid)
	- ProxDetector(Float:radi, playerid, const str[], col1, col2, col3, col4, col5)
	- ProxDetectorS(Float:radi, playerid, targetid)

	- SetPlayerAntiFloodChat(playerid, seconds = 2)
	- GetPlayerAntiFloodChat(playerid)
	- SCMEX(playerid, color, message[], bool:chatText)
	- UpdatePlayerInAFK(playerid)
	- CheckSpectatingPlayers(playerid, killerid)
	- ConnectPlayerServer(playerid)
	- IsPlayerInvalided(playerid)
	- IsPlayerOnServer(playerid)
	- ClearKillFeed(playerid = INVALID_PLAYER_ID)

	- SetPlayerORMData(playerid)
	- SavePlayerData(playerid)
	- SavePlayerMoney(playerid)
	- SavePlayerGoldCoins(playerid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- E_PLAYER_INFO
	- E_ANIMATION_INFO
 * |>--------------------------------------------<|
 * |                  Commands                    |
 * |>--------------------------------------------<|
	- test(playerid)
	- killtest(playerid)
	- none_mode(playerid)

	- chlen(playerid)
	- leave(playerid)
	- o(playerid, params[])
	- referals(playerid)
	- quest(playerid)
	- quests(playerid)
	- mission(playerid)
	- missions(playerid)
	- me(playerid, params[])
	- anims(playerid)
	- blacklist(playerid)
	- help(playerid)
	- info(playerid)
	- menu(playerid)
	- mn(playerid)
	- mm(playerid)
	- donate(playerid)
	- cmds(playerid)
	- rules(playerid)
	- stats(playerid)
	- photo(playerid)
	- piss(playerid)
	- pm(playerid, params[])
 * |>--------------------------------------------<|
 * |                  Dialogs                     |
 * |>--------------------------------------------<|
	- ListReferals
	- ClickOnPlayerInTAB
	- MessagePlayerInTAB
	- ViolationPlayerInTAB
	- BlackListPlayerInTAB
	- ChoosePlayerStats
	- Help
	- InfoModes
	- CommandsServer
	- PlayerOptions
	- PlayerStats
	- PlayerMenu
	- PlayerChangeSecurity
	- Donate
	- SelectTopPlayers
	- TopKillsPlayers
	- TopMoneyPlayers
	- ServerRules
	- SelectSex
	- SelectFoundServer
	- ChangePassword
	- InputNicknameReferal
	- BuyAnimations
	- ListAnimations
	- BlackListPlayers
	- InputPassword
	- RepeatPassword
	- Login
 * |>--------------------------------------------<|
 * |                  Interfaces                  |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_PLAYER_MAIN
	#endinput
#endif
#define _INC_PLAYER_MAIN

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum E_PLAYER_INFO {
	// MySQL
	ORM:e_ORM_ID,
	e_ID,
	e_Name[MAX_PLAYER_NAME],
	e_Password[MAX_LENGTH_PASSWORD],
	e_Referal[MAX_PLAYER_NAME],
	e_FoundServer,
	e_Sex,
	e_Rank,
	e_Exp,
	e_Money,
	e_GoldCoins,
	e_Kills,
	e_Deaths,
	e_WinningMatchs,
	e_LosingMatchs,
	e_ShotsEnemy,
	e_ShotsHead,
	e_SeriesKills,
	e_Blacklist[MAX_PLAYERS_IN_BLACKLIST],
	e_Animations[MAX_PLAYER_ANIMATIONS],
	e_Warns,
	e_MutedMinutes,
	e_PlayedHours,
	e_PlayedMinutes,
	e_RegIP[MAX_LENGTH_IP],
	e_LastIP[MAX_LENGTH_IP],
	e_RegDatetime[MAX_LENGTH_DATETIME],
	e_LastDatetime[MAX_LENGTH_DATETIME],

	// Server
	e_Skin,
	e_VirtualWorld,
	e_Interior,
	e_StatusDead,
	bool:e_StatusDamage,
	e_Team,
	e_Weather,
	e_Color,
	e_PlayerClass,
	e_PlayerClass2,
	Float:e_Health,
	Float:e_Armour
}

enum E_ANIMATION_INFO {
	e_Name[MAX_LENGTH_PLAYER_ANIMATIONS],
	e_Price
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static
	pInfo[MAX_PLAYERS][E_PLAYER_INFO];

static
	TimerUpdateData[MAX_PLAYERS];

static
	Float:SpawnInfoPosX[MAX_PLAYERS],
	Float:SpawnInfoPosY[MAX_PLAYERS],
	Float:SpawnInfoPosZ[MAX_PLAYERS];

static
	TimerSpawn[MAX_PLAYERS],
	TimerClearAnim[MAX_PLAYERS],
	TimerFloodText[MAX_PLAYERS],
	TimerFreezingPos[MAX_PLAYERS],
	TimerUnFreezeCW[MAX_PLAYERS],
	TimerExitZone[MAX_PLAYERS],
	TimerLogged[MAX_PLAYERS],
	TimerRespawn[MAX_PLAYERS],
	TimeAFK[MAX_PLAYERS];

static
	ActiveBelowHealth[MAX_PLAYERS],
	CheckingPlayerid[MAX_PLAYERS],
	ListFirstReferal[MAX_PLAYERS],
	CheckingReferalName[MAX_PLAYERS][MAX_PLAYER_NAME],
	LastDrunkLevel[MAX_PLAYERS],
	AdsServer[MAX_PLAYERS],
	DialogListAnims[MAX_PLAYERS][MAX_PLAYER_ANIMATIONS],
	FIGHT_STYLE:PlayerFightStyle[MAX_PLAYERS];

static
	bool:ActiveClickTD[MAX_PLAYERS char],
	bool:ActiveInvisible[MAX_PLAYERS char],
	bool:ActiveAnimation[MAX_PLAYERS char],
	bool:ActionZone[MAX_PLAYERS char],
	bool:ActiveExitZone[MAX_PLAYERS char],
	bool:ActiveJetPack[MAX_PLAYERS char],
	bool:ActiveSpectate[MAX_PLAYERS char],
	bool:AntiC[MAX_PLAYERS char];

static
	TimerTDRank[MAX_PLAYERS],
	bool:ActiveTDRank[MAX_PLAYERS char],
	bool:CreatedTDRank[MAX_PLAYERS char];

static
	SpectatingID[MAX_PLAYERS],
	SpectatingStatus[MAX_PLAYERS];

static
	ListBlackListCount[MAX_PLAYERS],
	ListBlacklist[MAX_PLAYERS][10];

static
	bool:ActiveLogged[MAX_PLAYERS char];

static
	bool:ActiveKillStrike[MAX_PLAYERS char],
	ScoreKillStrike[MAX_PLAYERS],
	TimerKillStrike[MAX_PLAYERS];

static
	SecondTime[MAX_PLAYERS],
	MinuteTime[MAX_PLAYERS],
	HourTime[MAX_PLAYERS];

static
	TimerSpawnKill[MAX_PLAYERS],
	bool:ActiveSpawnKill[MAX_PLAYERS char];

static
	TimerLastDamage[MAX_PLAYERS],
	bool:ActiveLastDamage[MAX_PLAYERS char];

static
	bool:ActiveFreeze[MAX_PLAYERS char],
	TimerFreeze[MAX_PLAYERS];

static
	CheckPlayerid[MAX_PLAYERS];

static
	Iterator:SpecDeadPlayers[MAX_PLAYERS]<MAX_PLAYERS>;

static
	StateNetGraphTD[MAX_PLAYERS][E_PLAYER_STATE_TEXT_DRAW],
	PlayerText:TD_NetGraph[MAX_PLAYERS][PLAYER_TD_NET_GRAPH];

static
	StateMatchStatsTD[MAX_PLAYERS][E_PLAYER_STATE_TEXT_DRAW],
	PlayerText:TD_MatchStats[MAX_PLAYERS][PLAYER_TD_MATCH_STATS];

static
	PlayerBar:BarSpawnTime[MAX_PLAYERS],
	PlayerBar:BarHealth[MAX_PLAYERS],
	PlayerBar:BarArmour[MAX_PLAYERS];

static
	PlayerText:TD_TimerSpawnKill[MAX_PLAYERS] = {INVALID_PLAYER_TEXT_DRAW, ...},
	PlayerText:TD_NewRank[MAX_PLAYERS] = {INVALID_PLAYER_TEXT_DRAW, ...},
	PlayerText:TD_AfterDead[MAX_PLAYERS] = {INVALID_PLAYER_TEXT_DRAW, ...},
	PlayerText:TD_KillStrike[MAX_PLAYERS] = {INVALID_PLAYER_TEXT_DRAW, ...},
	PlayerText:TD_ExitZone[MAX_PLAYERS][PLAYER_TD_EXIT_ZONE],
	PlayerText:TD_DeadKiller[MAX_PLAYERS][PLAYER_TD_DEAD_KILLER];

static
	bool:CanStartSpectating[MAX_PLAYERS char],
	KEY:AntiMoreKeys[MAX_PLAYERS];

static const
	TextAfterDeath[MAX_TEXTS_PLAYER_AFTER_DEAD][MAX_LENGTH_PLAYER_AFTER_DEAD] = {
	"Ты способен на большее!",
	"Не сдавайся!",
	"Будь лучше!",
	"Не расслабляйся!",
	"Вставай и борись!",
	"Скорее же стань лучше!",
	"Иногда врагам везёт больше",
	"Не будь тряпкой!",
	"Быстрее же победи врагов!",
	"Ошибка - лишь новый опыт"
};

static const
	AnimInfo[MAX_PLAYER_ANIMATIONS][E_ANIMATION_INFO] = {
	/*0*/{ "Ложиться #1", 5000 },
	/*1*/{ "Читать RAP #1", 5000 },
	/*2*/{ "Читать RAP #2", 5000 },
	/*3*/{ "Сесть #1", 5000 },
	/*4*/{ "Сесть #2", 5000 },
	/*5*/{ "Поднять руки", 5000 },
	/*6*/{ "Навести пушку", 5000 },
	/*7*/{ "Ударить по попе", 5000 },
	/*8*/{ "Положить цветы", 5000 },
	/*9*/{ "Fuck Bich", 5000 },
	/*10*/{ "Кунг-Фу #1", 5000 },
	/*11*/{ "Поцеловать по мужски", 5000 },
	/*12*/{ "Поцеловать по женски", 5000 },
	/*13*/{ "Танец #1", 5000 },
	/*14*/{ "Танец #2", 5000 },
	/*15*/{ "Танец #3", 5000 },
	/*16*/{ "Кунг-Фу #2", 5000 },
	/*17*/{ "Остановить такси", 5000 },
	/*18*/{ "Сесть #3", 5000 },
	/*19*/{ "Сесть #4", 5000 },
	/*20*/{ "Ложиться #2", 5000 },
	/*21*/{ "Ложиться #3", 5000 },
	/*22*/{ "Ложиться #4", 5000 },
	/*23*/{ "Стойка АK-47", 5000 },
	/*24*/{ "Стойка Deagle", 5000 },
	/*25*/{ "Махать рукой", 5000 },
	/*26*/{ "Устроить бунт", 5000 },
	/*27*/{ "Позвать к себе", 5000 },
	/*28*/{ "Упасть", 5000 },
	/*29*/{ "Подняться", 5000 },
	/*30*/{ "Поздароваться #1", 5000 },
	/*31*/{ "Поздароваться #2", 5000 },
	/*32*/{ "Поздароваться #3", 5000 },
	/*33*/{ "Пить", 5000 },
	/*34*/{ "Ударить с ноги", 5000 },
	/*35*/{ "Задуматься", 5000 },
	/*36*/{ "Сдаться", 5000 },
	/*37*/{ "Толкнуть", 5000 },
	/*38*/{ "Почесать яйца", 5000 },
	/*39*/{ "Рисовать", 5000 },
	/*40*/{ "Медик", 5000 },
	/*41*/{ "Умирать", 5000 },
	/*42*/{ "Прыгнуть", 5000 },
	/*43*/{ "Перекатиться", 5000 },
	/*44*/{ "Бокс", 5000 },
	/*45*/{ "Читать RAP #3", 5000 },
	/*46*/{ "You Nigga", 5000 },
	/*47*/{ "Полежать", 5000 },
	/*48*/{ "Танцевать на одной ноге", 5000 }
};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

/*
 * |>------------<|
 * |   ID MySQL   |
 * |>------------<|
 */

stock SetPlayerMySQLID(playerid, num)
{
	pInfo[playerid][e_ID] = num;
	return 1;
}

stock GetPlayerMySQLID(playerid)
{
	return pInfo[playerid][e_ID];
}

/*
 * |>--------<|
 * |   Name   |
 * |>--------<|
 */

stock SetPlayerNameEx(playerid, const name[])
{
	strcopy(pInfo[playerid][e_Name], name, MAX_PLAYER_NAME);
	mysql_escape_string(pInfo[playerid][e_Name], pInfo[playerid][e_Name], MAX_PLAYER_NAME);
	return 1;
}

stock GetPlayerNameEx(playerid)
{
	new
		str[MAX_PLAYER_NAME];

	strcopy(str, pInfo[playerid][e_Name], MAX_PLAYER_NAME);
	return str;
}

/*
 * |>------------<|
 * |   Password   |
 * |>------------<|
 */

stock SetPlayerPassword(playerid, const password[])
{
	strcopy(pInfo[playerid][e_Password], password, MAX_LENGTH_PASSWORD);
	return 1;
}

stock GetPlayerPassword(playerid)
{
	new
		str[MAX_LENGTH_PASSWORD];

	strcopy(str, pInfo[playerid][e_Password], MAX_LENGTH_PASSWORD);
	return str;
}

/*
 * |>-----------<|
 * |   Referal   |
 * |>-----------<|
 */

stock SetPlayerReferal(playerid, const name[])
{
	strcopy(pInfo[playerid][e_Referal], name, MAX_PLAYER_NAME);
	mysql_escape_string(pInfo[playerid][e_Referal], pInfo[playerid][e_Referal], MAX_PLAYER_NAME);
	return 1;
}

stock GetPlayerReferal(playerid)
{
	new
		str[MAX_PLAYER_NAME];

	strcopy(str, pInfo[playerid][e_Referal], MAX_PLAYER_NAME);
	return str;
}

stock SetCheckNameReferal(playerid, const name[])
{
	strcopy(CheckingReferalName[playerid], name, MAX_PLAYER_NAME);
	return 1;
}

/*
 * |>----------------<|
 * |   Found server   |
 * |>----------------<|
 */

stock SetPlayerFoundServer(playerid, foundid)
{
	pInfo[playerid][e_FoundServer] = foundid;
	return 1;
}

stock GetPlayerFoundServer(playerid)
{
	return pInfo[playerid][e_FoundServer];
}

/*
 * |>-------------------<|
 * |   IP registration   |
 * |>-------------------<|
 */

stock SetPlayerIPReg(playerid, const ip[])
{
	strcopy(pInfo[playerid][e_RegIP], ip, MAX_LENGTH_IP);
	return 1;
}

stock GetPlayerIPReg(playerid)
{
	new
		str[MAX_LENGTH_IP];

	strcopy(str, pInfo[playerid][e_RegIP], MAX_LENGTH_IP);
	return str;
}

/*
 * |>-----------<|
 * |   IP last   |
 * |>-----------<|
 */

stock SetPlayerIPLast(playerid, const ip[])
{
	strcopy(pInfo[playerid][e_LastIP], ip, MAX_LENGTH_IP);
	return 1;
}

stock GetPlayerIPLast(playerid)
{
	new
		str[MAX_LENGTH_IP];

	strcopy(str, pInfo[playerid][e_LastIP], MAX_LENGTH_IP);
	return str;
}

/*
 * |>-------<|
 * |   Sex   |
 * |>-------<|
 */

stock SetPlayerSex(playerid, sexid)
{
	pInfo[playerid][e_Sex] = sexid;
	return 1;
}

stock GetPlayerSex(playerid)
{
	return pInfo[playerid][e_Sex];
}

/*
 * |>--------<|
 * |   Rank   |
 * |>--------<|
 */

stock GivePlayerRank(playerid, rank, bool:message = false)
{
	pInfo[playerid][e_Rank] += rank;
	SetPlayerScore(playerid, pInfo[playerid][e_Rank]);

	// Referal
	if (pInfo[playerid][e_Rank] == PLAYER_RANK_BONUS_REFERAL) {
		if (!strcmp(GetPlayerReferal(playerid), DB_STRING_VALUE_NO, true)) {
			static const
				queryFormat[] = "SELECT * FROM `"DB_ACCOUNTS"` WHERE BINARY `"DB_ACCOUNTS_NICKNAME"` = '%s' LIMIT 1";

			new
				query[sizeof(queryFormat) - 2 + MAX_PLAYER_NAME];

			mysql_format(MySQLID, query, sizeof(query), queryFormat, GetPlayerReferal(playerid));
			mysql_tquery(MySQLID, query, "MySQLUpdateAccountReferal", "i", playerid);
		}
	}

	if (message) {
		SCM(playerid, C_GREEN, ""T_RANK" "CT_WHITE"Получен "CT_YELLOW"%i "CT_WHITE"ранг!", pInfo[playerid][e_Rank]);
	}
	return 1;
}

stock ResetPlayerRank(playerid)
{
	pInfo[playerid][e_Rank] = 0;
	return 1;
}

stock GetPlayerRank(playerid)
{
	return pInfo[playerid][e_Rank];
}

/*
 * |>-------<|
 * |   Exp   |
 * |>-------<|
 */

stock GivePlayerExp(playerid, exp, bool:message = false, bool:matchScore = true)
{
	if (matchScore) {
		Mode_GivePlayerMatchExp(playerid, exp);
	}

	if (GetPlayerPremium(playerid) != PREMIUM_LEVEL_NONE) {
		pInfo[playerid][e_Exp] = pInfo[playerid][e_Exp] + (exp * 2);
	}
	else {
		pInfo[playerid][e_Exp] = pInfo[playerid][e_Exp] + exp;
	}

	if (message) {
		SCM(playerid, C_GREEN, ""T_EXP" "CT_WHITE"Получено "CT_YELLOW"%i EXP!", exp);
	}

	if (GetPlayerExp(playerid) >= CheckPlayerNextRank(playerid)) {
		pInfo[playerid][e_Exp] = 0;
		GivePlayerRank(playerid, 1, true);
		ShowPlayerNewRank(playerid);
		PlayerPlaySoundEx(playerid, 5203, 0.0, 0.0, 0.0);
	}
	return 1;
}

stock ResetPlayerExp(playerid)
{
	pInfo[playerid][e_Exp] = 0;
	return 1;
}

stock GetPlayerExp(playerid)
{
	return pInfo[playerid][e_Exp];
}

/*
 * |>---------<|
 * |   Money   |
 * |>---------<|
 */

stock GivePlayerMoneyEx(playerid, money, bool:message = false)
{
	pInfo[playerid][e_Money] += money;
	GivePlayerMoney(playerid, money);

	if (message) {
		SCM(playerid, C_GREEN, ""T_REPLEN" "CT_WHITE"Получено "CT_YELLOW"$%i", money);
	}
	return 1;
}

stock ResetPlayerMoneyEx(playerid)
{
	pInfo[playerid][e_Money] = 0;
	return 1;
}

stock GetPlayerMoneyEx(playerid)
{
	return pInfo[playerid][e_Money];
}

/*
 * |>---------<|
 * |   Warns   |
 * |>---------<|
 */

stock GivePlayerWarns(playerid, warns)
{
	pInfo[playerid][e_Warns] += warns;
	return 1;
}

stock ResetPlayerWarns(playerid)
{
    pInfo[playerid][e_Warns] = 0;
    return 1;
}

stock GetPlayerWarns(playerid)
{
	return pInfo[playerid][e_Warns];
}

/*
 * |>--------------<|
 * |   Gold coins   |
 * |>--------------<|
 */

stock GivePlayerGoldCoins(playerid, goldCoins, bool:message = false)
{
	pInfo[playerid][e_GoldCoins] += goldCoins;

	if (message) {
		SCM(playerid, C_GREEN, ""T_REPLEN" "CT_WHITE"Получено "CT_YELLOW"%i "CT_WHITE"Gold coins", goldCoins);
	}
	return 1;
}

stock ResetPlayerGoldCoins(playerid)
{
    pInfo[playerid][e_GoldCoins] = 0;
    return 1;
}

stock GetPlayerGoldCoins(playerid)
{
	return pInfo[playerid][e_GoldCoins];
}

/*
 * |>---------<|
 * |   Kills   |
 * |>---------<|
 */

stock GivePlayerKills(playerid, kills)
{
	pInfo[playerid][e_Kills] += kills;
	TDM_GivePlayerClassKills(playerid, kills);
	return 1;
}

stock GetPlayerKills(playerid)
{
	return pInfo[playerid][e_Kills];
}

/*
 * |>----------<|
 * |   Deaths   |
 * |>----------<|
 */

stock GivePlayerDeaths(playerid, deaths)
{
	pInfo[playerid][e_Deaths] += deaths;
	TDM_GivePlayerClassDeaths(playerid, deaths);
	return 1;
}

stock GetPlayerDeaths(playerid)
{
	return pInfo[playerid][e_Deaths];
}

/*
 * |>------------------<|
 * |   Winning matchs   |
 * |>------------------<|
 */

stock GivePlayerWinningMatchs(playerid, matchs)
{
	pInfo[playerid][e_WinningMatchs] += matchs;
	return 1;
}

stock GetPlayerWinningMatchs(playerid)
{
	return pInfo[playerid][e_WinningMatchs];
}

/*
 * |>------------------<|
 * |   Lossing matchs   |
 * |>------------------<|
 */

stock GivePlayerLosingMatchs(playerid, matchs)
{
	pInfo[playerid][e_LosingMatchs] += matchs;
	return 1;
}

stock GetPlayerLosingMatchs(playerid)
{
	return pInfo[playerid][e_LosingMatchs];
}

/*
 * |>---------------<|
 * |   Shots enemy   |
 * |>---------------<|
 */

stock GivePlayerShotsEnemy(playerid, shots)
{
	pInfo[playerid][e_ShotsEnemy] += shots;
	return 1;
}

stock GetPlayerShotsEnemy(playerid)
{
	return pInfo[playerid][e_ShotsEnemy];
}

/*
 * |>--------------<|
 * |   Shots head   |
 * |>--------------<|
 */

stock GivePlayerShotsHead(playerid, shots)
{
	pInfo[playerid][e_ShotsHead] += shots;
	return 1;
}

stock GetPlayerShotsHead(playerid)
{
	return pInfo[playerid][e_ShotsHead];
}

/*
 * |>----------------<|
 * |   Series kills   |
 * |>----------------<|
 */

stock GivePlayerSeriesKills(playerid, kills)
{
	pInfo[playerid][e_SeriesKills] += kills;
	return 1;
}

stock GetPlayerSeriesKills(playerid)
{
	return pInfo[playerid][e_SeriesKills];
}

/*
 * |>--------------<|
 * |   Play hours   |
 * |>--------------<|
 */

stock GivePlayerPlayHours(playerid, hours)
{
	pInfo[playerid][e_PlayedHours] += hours;
	return 1;
}

stock GetPlayerPlayHours(playerid)
{
	return pInfo[playerid][e_PlayedHours];
}

/*
 * |>----------------<|
 * |   Play minutes   |
 * |>----------------<|
 */

stock GivePlayerPlayMinutes(playerid, minutes)
{
	pInfo[playerid][e_PlayedMinutes] += minutes;
	return 1;
}

stock GetPlayerPlayMinutes(playerid)
{
	return pInfo[playerid][e_PlayedMinutes];
}

/*
 * |>-------------<|
 * |   Animation   |
 * |>-------------<|
 */

stock BuyPlayerAnimation(playerid, cellid)
{
	pInfo[playerid][e_Animations][cellid] = 1;
	return 1;
}

stock GetPlayerAnimation(playerid, cellid)
{
	return pInfo[playerid][e_Animations][cellid];
}

/*
 * |>--------------<|
 * |   Black list   |
 * |>--------------<|
 */

stock SetPlayerBlacklistPlayer(playerid, cellid, playerBlack)
{
	pInfo[playerid][e_Blacklist][cellid] = playerBlack;
	return 1;
}

stock GetPlayerBlacklist(playerid, cellid)
{
	return pInfo[playerid][e_Blacklist][cellid];
}

/*
 * |>-------------------------<|
 * |   Datetime registration   |
 * |>-------------------------<|
 */

stock SetPlayerRegDatetime(playerid, const datetime[])
{
	strcopy(pInfo[playerid][e_RegDatetime], datetime, MAX_LENGTH_DATETIME);
	return 1;
}

stock GetPlayerRegDatetime(playerid)
{
	new
		str[MAX_LENGTH_DATETIME];

	strcopy(str, pInfo[playerid][e_RegDatetime], MAX_LENGTH_DATETIME);
	return str;
}

/*
 * |>-----------------<|
 * |   Datetime last   |
 * |>-----------------<|
 */

stock SetPlayerLastDatetime(playerid, const datetime[])
{
	strcopy(pInfo[playerid][e_LastDatetime], datetime, MAX_LENGTH_DATETIME);
	return 1;
}

stock GetPlayerLastDatetime(playerid)
{
	new
		str[MAX_LENGTH_DATETIME];

	strcopy(str, pInfo[playerid][e_LastDatetime], MAX_LENGTH_DATETIME);
	return str;
}

/*
 * |>-----------------<|
 * |   Virtual world   |
 * |>-----------------<|
 */

stock SetPlayerVirtualWorldEx(playerid, worldid)
{
	pInfo[playerid][e_VirtualWorld] = worldid;
	SetPlayerVirtualWorld(playerid, worldid);
	return 1;
}

stock GetPlayerVirtualWorldEx(playerid)
{
	return pInfo[playerid][e_VirtualWorld];
}

/*
 * |>------------<|
 * |   Interior   |
 * |>------------<|
 */

stock SetPlayerInteriorEx(playerid, interiorid)
{
	pInfo[playerid][e_Interior] = interiorid;
	SetPlayerInterior(playerid, interiorid);
	return 1;
}

stock GetPlayerInteriorEx(playerid)
{
	return pInfo[playerid][e_Interior];
}

/*
 * |>----------------<|
 * |   Custom class   |
 * |>----------------<|
 */

stock SetPlayerCustomClass(playerid, classid)
{
	pInfo[playerid][e_PlayerClass] = classid;
	return 1;
}

stock GetPlayerCustomClass(playerid)
{
	return pInfo[playerid][e_PlayerClass];
}

/*
 * |>------------------<|
 * |   Custom class 2   |
 * |>------------------<|
 */

stock SetPlayerCustomClass2(playerid, classid)
{
	pInfo[playerid][e_PlayerClass2] = classid;
	return 1;
}

stock GetPlayerCustomClass2(playerid)
{
	return pInfo[playerid][e_PlayerClass2];
}

/*
 * |>--------<|
 * |   Mute   |
 * |>--------<|
 */

stock SetPlayerMute(playerid, minutes)
{
	pInfo[playerid][e_MutedMinutes] = minutes;
	return 1;
}

stock GetPlayerMute(playerid)
{
	return pInfo[playerid][e_MutedMinutes];
}

/*
 * |>----------------<|
 * |   Player color   |
 * |>----------------<|
 */

stock SetPlayerColorEx(playerid, color)
{
	new
		nicknameColor[MAX_LENGTH_COLOR_NICK];

	nicknameColor = GetPlayerNicknameColor(playerid);

	if (strcmp(nicknameColor, DB_STRING_VALUE_NO, true)) {
		if (!GetPlayerLogged(playerid)) {
			pInfo[playerid][e_Color] = HexToInt(HEXResultColor(nicknameColor, 1));
			SetPlayerColor(playerid, HexToInt(HEXResultColor(nicknameColor, 1)));
		}
	}
	else {
		pInfo[playerid][e_Color] = color;
		SetPlayerColor(playerid, color);
	}
	return 1;
}

stock GetPlayerColorEx(playerid)
{
	return pInfo[playerid][e_Color];
}

/*
 * |>----------<|
 * |   Health   |
 * |>----------<|
 */

stock SetPlayerHealthEx(playerid, Float:health)
{
	if (health < 0.0) {
		health = 0.0;
	}

	else if (health > 100.0) {
		health = 100.0;
	}

	if (SetPlayerHealth(playerid, health)) {
		pInfo[playerid][e_Health] = health;
	}
	return 1;
}

stock GetPlayerHealthEx(playerid, &Float:health)
{
	GetPlayerHealth(playerid, health);
	return 1;
}

/*
 * |>----------<|
 * |   Armour   |
 * |>----------<|
 */

stock SetPlayerArmourEx(playerid, Float:armour)
{
	if (armour < 0.0) {
		armour = 0.0;
	}

	else if (armour > 100.0) {
		armour = 100.0;
	}

	if (SetPlayerArmour(playerid, armour)) {
		pInfo[playerid][e_Armour] = armour;
	}
	return 1;
}

stock GetPlayerArmourEx(playerid, &Float:armour)
{
	GetPlayerArmour(playerid, armour);
	return 1;
}

/*
 * |>--------------<|
 * |   Spectating   |
 * |>--------------<|
 */

stock SetPlayerSpectating(playerid, spectedid)
{
	SpectatingID[playerid] = spectedid;
	return 1;
}

stock GetPlayerSpectating(playerid)
{
	return SpectatingID[playerid];
}

stock SetPlayerSpecStatus(playerid, status)
{
	SpectatingStatus[playerid] = status;
	return 1;
}

stock GetPlayerSpecStatus(playerid)
{
	return SpectatingStatus[playerid];
}

stock SpecPl(playerid, bool:spec)
{
	if (ActiveSpectate{playerid} == spec) {
		return 0;
	}

	ActiveSpectate{playerid} = spec;
	TogglePlayerSpectating(playerid, spec);
	return 1;
}

stock GetSpecPl(playerid)
{
	return ActiveSpectate{playerid};
}

stock UpdateSpectatingPlayer(playerid, spectedid)
{
	if (GetPlayerVirtualWorldEx(playerid) != GetPlayerVirtualWorldEx(spectedid)) {
		SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorldEx(spectedid));
	}

	if (GetPlayerInteriorEx(playerid) != GetPlayerInteriorEx(spectedid)) {
		SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(spectedid));
	}

	if (GetPlayerVehicleIDEx(spectedid) != INVALID_VEHICLE_ID) {
		if (GetPlayerSpecStatus(playerid) != PLAYER_SPECTATE_PLAYER) {
			SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_PLAYER);
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(spectedid));
		}
	}
	else {
		if (GetPlayerSpecStatus(playerid) != PLAYER_SPECTATE_VEHICLE) {
			SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_VEHICLE);
			PlayerSpectatePlayer(playerid, spectedid);
		}
	}
	return 1;
}

stock UpdateSpectatingStatus(playerid, spectedid)
{
	if (spectedid == INVALID_PLAYER_ID) {
		return 1;
	}

	if (GetAdminSpectating(playerid)) {
		if (GetAdminLevel(playerid) != ADM_LEVEL_NONE) {
			if (!IsPlayerOnServer(spectedid)) {
				StopAdminSpectating(playerid);

				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрока нет на сервере!");
			}
			else {
				UpdateSpectatingPlayer(playerid, spectedid);
				UpdateAdminTDSpec(playerid, spectedid);
			}
		}
		return 1;
	}
	else {
		if (Mode_UpdateSpectateStatus(playerid, spectedid)) {
			return 1;
		}

		if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE
		&& GetPlayerDead(spectedid) == PLAYER_DEATH_NONE) {
			UpdateSpectatingPlayer(playerid, spectedid);
		}
	}
	return 1;
}

stock AddPlayerSpecatingPlayer(playerid, spectedid)
{
	Iter_Add(SpecDeadPlayers[playerid], spectedid);
	return 1;
}

stock RemovePlayerSpectatingPlayer(playerid, spectedid)
{
	Iter_Remove(SpecDeadPlayers[playerid], spectedid);
	return 1;
}

stock GetPlayerSpecatingPlayers(playerid)
{
	return Iter_Count(SpecDeadPlayers[playerid]);
}

/*
 * |>--------------<|
 * |   Play sound   |
 * |>--------------<|
 */

stock PlayerPlaySoundEx(playerid, sound, Float:x, Float:y, Float:z)
{
	PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, sound, x, y, z);
	return 1;
}

/*
 * |>--------<|
 * |   Team   |
 * |>--------<|
 */

stock SetPlayerTeamEx(playerid, team)
{
	pInfo[playerid][e_Team] = team;
	SetPlayerTeam(playerid, team);
	return 1;
}

stock GetPlayerTeamEx(playerid)
{
	return pInfo[playerid][e_Team];
}

/*
 * |>--------<|
 * |   Skin   |
 * |>--------<|
 */

stock SetPlayerSkinEx(playerid, skinid)
{
	pInfo[playerid][e_Skin] = skinid;
	SetPlayerSkin(playerid, skinid);
	return 1;
}

stock GetPlayerSkinEx(playerid)
{
	return pInfo[playerid][e_Skin];
}

/*
 * |>---------------<|
 * |   Fight style   |
 * |>---------------<|
 */

stock SetPlayerFightingStyleEx(playerid, FIGHT_STYLE:style)
{
	PlayerFightStyle[playerid] = style;
	SetPlayerFightingStyle(playerid, style);
	return 1;
}

stock FIGHT_STYLE:GetPlayerFightingStyleEx(playerid)
{
	return PlayerFightStyle[playerid];
}

/*
 * |>--------<|
 * |   Dead   |
 * |>--------<|
 */

stock SetPlayerStatusDead(playerid, status)
{
	pInfo[playerid][e_StatusDead] = status;
	return 1;
}

stock GetPlayerDead(playerid)
{
	return pInfo[playerid][e_StatusDead];
}

stock RemovePlayerDead(playerid)
{
	DestroyPlayerDeadKillerTD(playerid, GetPlayerDead(playerid));

	SetPlayerSpecStatus(playerid, PLAYER_SPECTATE_INVALID);
	SetPlayerStatusDead(playerid, PLAYER_DEATH_NONE);
	SetPlayerSpeedRespawn(playerid, 0);
	SetPlayerSpectating(playerid, INVALID_PLAYER_ID);
	return 1;
}

/*
 * |>--------<|
 * |   Kick   |
 * |>--------<|
 */

stock KickPlayerEx(playerid, delay = 5000) {
	SetPlayerTimer(playerid, "CallKicker", delay, false);
	return 1;
}

public: CallKicker(playerid) {
	Kick(playerid);
	return 1;
}

/*
 * |>----------<|
 * |   Damage   |
 * |>----------<|
 */

stock SetPlayerDamage(playerid, bool:type)
{
	pInfo[playerid][e_StatusDamage] = type;
	return 1;
}

stock GetPlayerDamage(playerid)
{
	return pInfo[playerid][e_StatusDamage];
}

/*
 * |>-------------<|
 * |   Animation   |
 * |>-------------<|
 */

stock SetPlayerAnimationEx(playerid, bool:type)
{
	ActiveAnimation{playerid} = type;
	return 1;
}

stock GetPlayerAnimationEx(playerid)
{
	return ActiveAnimation{playerid};
}

stock StartPlayerTimerClearAnim(playerid, seconds = 0)
{
	if (seconds == 0) {
		ApplyAnimation(playerid, "BD_FIRE", "BD_Fire1", 4.1, false, false, false, false, 1, SYNC_ALL);
	}
	else {
		TimerClearAnim[playerid] = SetPlayerTimer(playerid, "CallClearPlayerAnim", seconds, false);
	}
	return 1;
}

public: CallClearPlayerAnim(playerid)
{
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, false, false, false, false, 0, SYNC_ALL);
	return 1;
}

/*
 * |>-----------<|
 * |   Respawn   |
 * |>-----------<|
 */

stock SetPlayerSpeedRespawn(playerid, seconds)
{
	TimerRespawn[playerid] = seconds;
	return 1;
}

stock GivePlayerSpeedRespawn(playerid, seconds)
{
	TimerRespawn[playerid] += seconds;
	return 1;
}

stock GetPlayerSpeedRespawn(playerid)
{
	return TimerRespawn[playerid];
}

stock UpdatePlayerSpeedRespawn(playerid)
{
	TimerRespawn[playerid]--;
	return 1;
}

stock UpdateBarTimeRespawn(playerid)
{
	SetPlayerProgressBarValue(playerid, BarSpawnTime[playerid], floatround((Mode_GetModeTimeRespawn(Mode_GetPlayerMode(playerid))) - GetPlayerSpeedRespawn(playerid)));
	return 1;
}

/*
 * |>----------<|
 * |   Freeze   |
 * |>----------<|
 */

stock SetPlayerFreeze(playerid, time = 1, bool:freeze = true)
{
	if (time < 0) {
		time = 0;
	}

	if (ActiveFreeze{playerid}) {
		CallUnFreeze(playerid, true);
		KillTimer(TimerFreeze[playerid]);
	}

	ActiveFreeze{playerid} = true;
	TogglePlayerControllable(playerid, false);
	TimerFreeze[playerid] = SetTimerEx("CallUnFreeze", time * 1000, false, "ii", playerid, freeze);
	return 1;
}

stock GetPlayerFreeze(playerid)
{
	return ActiveFreeze{playerid};
}

public: CallUnFreeze(playerid, bool:freeze)
{
	ActiveFreeze{playerid} = false;

	if (freeze) {
		TogglePlayerControllable(playerid, true);
	}
	return 1;
}

public: CallFreezingPos(playerid)
{
	SetPlayerDamage(playerid, true);
	TogglePlayerControllable(playerid, true);
	return 1;
}

/*
 * |>--------<|
 * |   Time   |
 * |>--------<|
 */

stock GivePlayerSecondTime(playerid)
{
	SecondTime[playerid]++;
	return 1;
}

stock GetPlayerSecondTime(playerid)
{
	return SecondTime[playerid];
}

stock GivePlayerMinuteTime(playerid)
{
	MinuteTime[playerid]++;
	return 1;
}

stock GetPlayerMinuteTime(playerid)
{
	return MinuteTime[playerid];
}

stock GivePlayerHourTime(playerid)
{
	HourTime[playerid]++;
	return 1;
}
stock GetPlayerHourTime(playerid)
{
	return HourTime[playerid];
}

/*
 * |>-------------<|
 * |   Anti keys   |
 * |>-------------<|
 */

stock SetPlayerAntiKeys(playerid, KEY:keys)
{
	AntiMoreKeys[playerid] = keys;
	return 1;
}

stock GetPlayerAntiKeys(playerid)
{
	return AntiMoreKeys[playerid];
}

/*
 * |>-------------<|
 * |   Invisible   |
 * |>-------------<|
 */

stock SetPlayerInvisible(playerid, bool:type)
{
	ActiveInvisible{playerid} = type;
	return 1;
}

stock GetPlayerInvisible(playerid)
{
	return ActiveInvisible{playerid};
}

/*
 * |>---------------<|
 * |   Kill strike   |
 * |>---------------<|
 */

stock GivePlayerKillStrike(playerid, num)
{
	ScoreKillStrike[playerid] += num;
	return 1;
}

stock ResetPlayerKillStrike(playerid)
{
	ScoreKillStrike[playerid] = 0;
    return 1;
}

stock GetPlayerKillStrike(playerid)
{
	return ScoreKillStrike[playerid];
}

/*
 * |>------------------------------------------------------<|
 * |   Spectating can (possibility to start surveillance)   |
 * |>------------------------------------------------------<|
 */

stock SetPlayerCanSpectating(playerid, bool:type)
{
	CanStartSpectating[playerid] = type;
	return 1;
}

stock GetPlayerCanSpectating(playerid)
{
	return CanStartSpectating[playerid];
}

/*
 * |>--------<|
 * |   Zone   |
 * |>--------<|
 */

stock SetPlayerActionZone(playerid, bool:type)
{
	ActionZone{playerid} = type;
	return 1;
}

stock GetPlayerActionZone(playerid)
{
	return ActionZone{playerid};
}

/*
 * |>------------------<|
 * |   Click TextDraw   |
 * |>------------------<|
 */

stock SetPlayerClickTD(playerid, bool:type)
{
	ActiveClickTD{playerid} = type;
	return 1;
}

stock GetPlayerClickTD(playerid)
{
	return ActiveClickTD{playerid};
}

/*
 * |>-----------<|
 * |   Weather   |
 * |>-----------<|
 */

stock SetPlayerWeatherEx(playerid, weatherid)
{
	pInfo[playerid][e_Weather] = weatherid;
	SetPlayerWeather(playerid, weatherid);
	return 1;
}

stock GetPlayerWeatherEx(playerid)
{
	return pInfo[playerid][e_Weather];
}

/*
 * |>-------------------------<|
 * |   Player check playerid   |
 * |>-------------------------<|
 */

stock SetPlayerCheckPlayerid(playerid, playerCheck)
{
	CheckPlayerid[playerid] = playerCheck;
	return 1;
}

stock GetPlayerCheckPlayerid(playerid)
{
	return CheckPlayerid[playerid];
}

/*
 * |>--------------<|
 * |   Spawn info   |
 * |>--------------<|
 */

stock SetSpawnInfoEx(playerid, skin, Float:x, Float:y, Float:z, Float:angle)
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	SpawnInfoPosX[playerid] = x;
	SpawnInfoPosY[playerid] = y;
	SpawnInfoPosZ[playerid] = z;

	SetSpawnInfo(playerid, GetPlayerTeamEx(playerid), skin, x, y, z, angle, WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);
	return 1;
}

stock GetSpawnInfoPosEx(playerid, &Float:x, &Float:y, &Float:z)
{
	x = SpawnInfoPosX[playerid];
	y = SpawnInfoPosY[playerid];
	z = SpawnInfoPosZ[playerid];
	return 1;
}

/*
 * |>----------<|
 * |   Logged   |
 * |>----------<|
 */

stock SetPlayerLogged(playerid, bool:logged)
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	ActiveLogged{playerid} = logged;
	return 1;
}

stock GetPlayerLogged(playerid)
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	return ActiveLogged{playerid};
}

stock SetPlayerLoggedTimer(playerid, seconds)
{
	TimerLogged[playerid] = SetPlayerTimer(playerid, "CallPlayerLoggedTimer", seconds, false);
	return 1;
}

stock KillPlayerLoggedTimer(playerid)
{
	KillTimer(TimerLogged[playerid]);
	return 1;
}

public: CallPlayerLoggedTimer(playerid)
{
	SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Время истекло!");
	KickPlayerEx(playerid);
	return 1;
}

/*
 * |>-----------<|
 * |   Anti +C   |
 * |>-----------<|
 */

stock DeaglePlayerAntiC(playerid)
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	switch (GetPlayerWeapon(playerid)) {
		case WEAPON_DEAGLE: {
			ApplyAnimation(playerid, "PED", "getup_front", 4.0, false, false, true, false, 0);

			AntiC{playerid} = false;
			TimerUnFreezeCW[playerid] = SetPlayerTimer(playerid, "CallUnfreezeCw", 500, false);
		}
	}
	return 1;
}

public: CallUnfreezeCw(playerid)
{
	AntiC{playerid} = true;
	return 1;
}

/*
 * |>----------------------<|
 * |   Player kill strike   |
 * |>----------------------<|
 */

stock ShowPlayerKillStrike(playerid)
{
	if (ActiveKillStrike{playerid}) {
		HidePlayerKillStrike(playerid);
	}

	ActiveKillStrike{playerid} = true;
	TimerKillStrike[playerid] += 2;
	CreatePlayerKillStrikeTD(playerid, TD_KillStrike[playerid]);

	PlayerTextDrawSetString(playerid, TD_KillStrike[playerid], "Убийств: %i", GetPlayerKillStrike(playerid));
	PlayerTextDrawShow(playerid, TD_KillStrike[playerid]);
	return 1;
}

stock HidePlayerKillStrike(playerid)
{
	if (!ActiveKillStrike{playerid}) {
		return 1;
	}

	ActiveKillStrike{playerid} = false;
	TimerKillStrike[playerid] = 0;
	DestroyPlayerTD(playerid, TD_KillStrike[playerid]);
	return 1;
}

static UpdatePlayerKillStrike(playerid)
{
	if (ActiveKillStrike{playerid}) {
		if (TimerKillStrike[playerid] > 0) {
			TimerKillStrike[playerid]--;
		}
		else {
			HidePlayerKillStrike(playerid);
		}
	}
	return 1;
}

/*
 * |>---------------<|
 * |   Player rank   |
 * |>---------------<|
 */

static ShowPlayerNewRank(playerid)
{
	CreatePlayerNewRankTD(playerid, TD_NewRank[playerid]);

	PlayerTextDrawSetString(playerid, TD_NewRank[playerid], "Новый_ранг:_~y~%i~w~!", GetPlayerRank(playerid));
	PlayerTextDrawShow(playerid, TD_NewRank[playerid]);

	CreatedTDRank{playerid} = true;
	TimerTDRank[playerid] += 5;
	return 1;
}

static HidePlayerNewRank(playerid)
{
	CreatedTDRank{playerid} = false;
	TimerTDRank[playerid] = 0;
	DestroyPlayerTD(playerid, TD_NewRank[playerid]);
	return 1;
}

static UpdatePlayerNewRank(playerid)
{
	if (CreatedTDRank{playerid}) {
		if (TimerTDRank[playerid] > 0) {
			TimerTDRank[playerid]--;
		}
		else {
			HidePlayerNewRank(playerid);
		}
	}
	return 1;
}

/*
 * |>---------------------<|
 * |   Player spawn kill   |
 * |>---------------------<|
 */

stock SetPlayerSpawnKill(playerid)
{
	if (ActiveSpawnKill{playerid}) {
		DestroyPlayerSpawnKill(playerid);
	}

	SetPlayerDamage(playerid, false);
	ActiveSpawnKill{playerid} = true;
	TimerSpawnKill[playerid] += TIMER_PLAYER_SPAWNKILL;

	CreatePlayerSpawnKillTD(playerid, TD_TimerSpawnKill[playerid]);
	PlayerTextDrawShow(playerid, TD_TimerSpawnKill[playerid]);
	return 1;
}

stock DestroyPlayerSpawnKill(playerid)
{
	if (!ActiveSpawnKill{playerid}) {
		return 1;
	}

	ActiveSpawnKill{playerid} = false;
	TimerSpawnKill[playerid] = 0;
	DestroyPlayerTD(playerid, TD_TimerSpawnKill[playerid]);

	SetPlayerDamage(playerid, true);
	return 1;
}

static UpdatePlayerSpawnKill(playerid)
{
	if (!ActiveSpawnKill{playerid}) {
		return 1;
	}

	if (TimerSpawnKill[playerid] > 0) {
		TimerSpawnKill[playerid]--;

		if (TimerSpawnKill[playerid] <= 0) {
			DestroyPlayerSpawnKill(playerid);
			return 1;
		}

		SetPlayerChatBubble(playerid, "SpawnKill", 0xCC0033FF, 30.0, 1000);
		PlayerTextDrawSetString(playerid, TD_TimerSpawnKill[playerid], "Бессмертие: ~b~%i", TimerSpawnKill[playerid]);
	}
	return 1;
}

/*
 * |>--------------------<|
 * |   Player exit zone   |
 * |>--------------------<|
 */

stock ShowPlayerExitZone(playerid) 
{
	if (ActiveExitZone{playerid}) {
		return 1;
	}

	ActiveExitZone{playerid} = true;
	TimerExitZone[playerid] += 10;

	CreatePlayerExitZoneTD(playerid, TD_ExitZone[playerid]);

	n_for(i, PLAYER_TD_EXIT_ZONE) {
		PlayerTextDrawShow(playerid, TD_ExitZone[playerid][i]);
	}
	return 1;
}

stock HidePlayerExitZone(playerid)
{
	if (!ActiveExitZone{playerid}) {
		return 1;
	}

	ActiveExitZone{playerid} = false;
	TimerExitZone[playerid] = 0;

	n_for(i, PLAYER_TD_EXIT_ZONE) {
		DestroyPlayerTD(playerid, TD_ExitZone[playerid][i]);
	}
	return 1;
}

stock GetPlayerExitZone(playerid)
{
	if (ActiveExitZone{playerid}) {
		return 1;
	}
	return 0;
}

static UpdatePlayerExitZone(playerid)
{
	if (!ActiveExitZone{playerid}) {
		return 1;
	}

	if (TimerExitZone[playerid] > 0) {
		TimerExitZone[playerid]--;

		PlayerTextDrawSetString(playerid, TD_ExitZone[playerid][3], "Смерть_наступит_через:_%01d", TimerExitZone[playerid]);
	}
	else {
		HidePlayerExitZone(playerid);
		SetPlayerHealthEx(playerid, 0.0);
	}

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		HidePlayerExitZone(playerid);
	}
	return 1;
}

/*
 * |>-----------------------<|
 * |   Player below health   |
 * |>-----------------------<|
 */

stock DestroyPlayerBelowHealth(playerid)
{
	if (ActiveBelowHealth[playerid] <= 0) {
		return 1;
	}

	ActiveBelowHealth[playerid] = 0;

	HidePlayerBelowHealthTD(playerid, 0);

	SetPlayerDrunkLevel(playerid, 0);
	return 1;
}

stock UpdatePlayerBelowHealth(playerid)
{
	if (ActiveBelowHealth[playerid] == 0) {
		new
			Float:health;

		GetPlayerHealthEx(playerid, health);

		if (health < 20.0) {
			ActiveBelowHealth[playerid] = 1;
		}
	}
	if (ActiveBelowHealth[playerid] > 0) {
		new
			Float:health;

		GetPlayerHealthEx(playerid, health);

		if (health >= 20.0) {
			ActiveBelowHealth[playerid] = 0;
			SetPlayerDrunkLevel(playerid, 0);
			HidePlayerBelowHealthTD(playerid, 0);
		}
		else {
			if (ActiveBelowHealth[playerid] != 2) {
				if (health > 15.0 && health < 20.0) {
					if (ActiveBelowHealth[playerid] == 3)
						HidePlayerBelowHealthTD(playerid, 4);
					else
						ShowPlayerBelowHealthTD(playerid, 0, 5);

					ActiveBelowHealth[playerid] = 2;
					SetPlayerDrunkLevel(playerid, 3000);
				}
			}
			if (ActiveBelowHealth[playerid] != 3) {
				if (health > 0.0 && health < 15.0) {
					if (ActiveBelowHealth[playerid] == 2)
						ShowPlayerBelowHealthTD(playerid, 4);
					else
						ShowPlayerBelowHealthTD(playerid, 4);

					ActiveBelowHealth[playerid] = 3;
					SetPlayerDrunkLevel(playerid, 5000);
				}
			}
			CheckPlayerDinaHint(playerid, 18);
		}
	}
	return 1;
}

/*
 * |>-----------------------<|
 * |   View another player   |
 * |>-----------------------<|
 */

stock SetPlayerIDStats(playerid, playerid2)
{
	CheckingPlayerid[playerid] = playerid2;
	return 1;
}

stock GetPlayerIDStats(playerid)
{
	return CheckingPlayerid[playerid];
}

/*
 * |>----------------------<|
 * |   Player last damage   |
 * |>----------------------<|
 */

stock SetPlayerLastDamage(playerid)
{
	ActiveLastDamage{playerid} = true;
	TimerLastDamage[playerid] += 6;
	return 1;
}

stock ResetPlayerLastDamage(playerid)
{
	ActiveLastDamage{playerid} = false;
	TimerLastDamage[playerid] = 0;
	return 1;
}

stock GetPlayerLastDamage(playerid)
{
	return ActiveLastDamage{playerid};
}

stock GetPlayerLastDamageTimer(playerid)
{
	return TimerLastDamage[playerid];
}

static UpdatePlayerLastDamage(playerid)
{
	if (ActiveLastDamage{playerid}) {
		if (TimerLastDamage[playerid] > 0) {
			TimerLastDamage[playerid]--;
		}
		else {
			ResetPlayerLastDamage(playerid);
		}
	}
	return 1;
}

/*
 * |>---------------<|
 * |   Player dead   |
 * |>---------------<|
 */

stock CreatePlayerDeadKillerTD(playerid)
{
	CreatePlayerDeadKillerTD2(playerid, TD_DeadKiller[playerid]);

	BarSpawnTime[playerid] = CreatePlayerProgressBar(playerid, 243.00, 418.00, 55.50, 6.19, 0xff0000FF, Mode_GetModeTimeRespawn(Mode_GetPlayerMode(playerid)), BAR_DIRECTION_RIGHT);
	HidePlayerProgressBar(playerid, BarSpawnTime[playerid]);
	return 1;
}

stock DestroyPlayerDeadKillerTD(playerid, type)
{
	switch (type) {
		case PLAYER_DEATH_INVALID: {
			DestroyPlayerTD(playerid, TD_AfterDead[playerid]);
		}
		case PLAYER_DEATH_KILLER: {
			DestroyPlayerProgressBar(playerid, BarSpawnTime[playerid]);

			n_for(i, PLAYER_TD_DEAD_KILLER) {
				DestroyPlayerTD(playerid, TD_DeadKiller[playerid][i]);
			}
		}
	}
	return 1;
}

static ShowPlayerDeadKiller(playerid, type)
{
	switch (type) {
		case PLAYER_DEATH_INVALID: {
			CreatePlayerAfterDeadTD(playerid);
			PlayerTextDrawShow(playerid, TD_AfterDead[playerid]);
		}
		case PLAYER_DEATH_KILLER: {
			CreatePlayerDeadKillerTD(playerid);
			n_for(i, PLAYER_TD_DEAD_KILLER) {
				PlayerTextDrawShow(playerid, TD_DeadKiller[playerid][i]);
			}
		}
	}
	return 1;
}

static UpdatePlayerDeadKillerTD(playerid, killerid)
{
	ShowPlayerProgressBar(playerid, BarSpawnTime[playerid]);

	new
		weaponName[MAX_LENGTH_WEAPON_NAME],
		Float:health, Float:armour;

	// Nick
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][1], "%s ~y~(ID: %i)", GetPlayerNameEx(killerid), killerid);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][1], GetPlayerColorEx(killerid));

	// Health
	GetPlayerHealthEx(killerid, health);
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][4], "%.0f", health);

	// Armour
	GetPlayerArmourEx(killerid, armour);
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][6], "%.0f", armour);

	// Rank
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][10], "%i", GetPlayerRank(killerid));

	// Weapon
	PlayerTextDrawSetPreviewModel(playerid, TD_DeadKiller[playerid][12], GetWeaponModelEx(GetPlayerWeapon(killerid)));

	if (GetWeaponModelEx(GetPlayerWeapon(killerid)) != -1) {
		PlayerTextDrawSetPreviewRot(playerid, TD_DeadKiller[playerid][12], 0.000000, 0.000000, 60.000000, 2.000000);
	}
	else {
		PlayerTextDrawSetPreviewRot(playerid, TD_DeadKiller[playerid][12], 0.000000, 0.000000, 0.000000, 1000.000000);
	}

	GetWeaponNameRU(GetPlayerWeapon(killerid), weaponName, MAX_LENGTH_WEAPON_NAME);

	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][13], weaponName);
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][8], GetInvBannerModel(GetPlayerInvBanner(killerid)));
	return 1;
}

// Fake killer

stock CreatePlayerAfterDeadTD(playerid)
{
	CreatePlayerAfterDeadTD2(playerid, TD_AfterDead[playerid]);
	return 1;
}

static UpdatePlayerAfterDeadTD(playerid)
{
	new
		str[MAX_LENGTH_PLAYER_AFTER_DEAD],
		textRandom = random(MAX_TEXTS_PLAYER_AFTER_DEAD);

	strcopy(str, TextAfterDeath[textRandom], MAX_LENGTH_PLAYER_AFTER_DEAD);
	PlayerTextDrawSetString(playerid, TD_AfterDead[playerid], str);
	return 1;
}

/*
 * |>-------------------<|
 * |   Base indicators   |
 * |>-------------------<|
 */

stock CreatePlayerBaseIndicatorsTD(playerid)
{
	if (GetIndicatorHealth() == PLAYER_IND_HEALTH_CUSTOM) {
		if (!IsValidPlayerProgressBar(playerid, BarHealth[playerid])) {
			BarHealth[playerid] = CreatePlayerProgressBar(playerid, 547.00, 68.00, 65.50, 7.20, 0xb51821FF, 100.0, BAR_DIRECTION_RIGHT);
			HidePlayerProgressBar(playerid, BarHealth[playerid]);
		}

		if (!IsValidPlayerProgressBar(playerid, BarArmour[playerid])) {
			BarArmour[playerid] = CreatePlayerProgressBar(playerid, 547.00, 46.00, 65.50, 7.20, 0xe6e6e6FF, 100.0, BAR_DIRECTION_RIGHT);
			HidePlayerProgressBar(playerid, BarArmour[playerid]);
		}
	}
	return 1;
}

stock DestroyPlayerBaseIndicatorsTD(playerid)
{
	if (GetIndicatorHealth() == PLAYER_IND_HEALTH_CUSTOM) {
		DestroyPlayerProgressBar(playerid, BarHealth[playerid]);
		DestroyPlayerProgressBar(playerid, BarArmour[playerid]);
	}
	return 1;
}

stock ShowPlayerBaseIndicatorsTD(playerid)
{
	if (GetIndicatorHealth() == PLAYER_IND_HEALTH_CUSTOM) {
		new
			Float:health, Float:armour;

		GetPlayerHealthEx(playerid, health);
		GetPlayerArmourEx(playerid, armour);

		SetPlayerProgressBarValue(playerid, BarHealth[playerid], health);
		SetPlayerProgressBarValue(playerid, BarArmour[playerid], armour);

		ShowPlayerProgressBar(playerid, BarHealth[playerid]);
		ShowPlayerProgressBar(playerid, BarArmour[playerid]);
	}
	return 1;
}

stock HidePlayerBaseIndicatorsTD(playerid)
{
	if (GetIndicatorHealth() == PLAYER_IND_HEALTH_CUSTOM) {
		HidePlayerProgressBar(playerid, BarHealth[playerid]);
		HidePlayerProgressBar(playerid, BarArmour[playerid]);
	}
	return 1;
}

static UpdatePlayerBaseIndicatorsTD(playerid)
{
	if (GetIndicatorHealth() == PLAYER_IND_HEALTH_CUSTOM) {
		new
			Float:health, Float:armour;

		GetPlayerHealthEx(playerid, health);
		GetPlayerArmourEx(playerid, armour);

		SetPlayerProgressBarValue(playerid, BarHealth[playerid], health);

		if (armour <= 0.0) {
			HidePlayerProgressBar(playerid, BarArmour[playerid]);
		}
		else {
			if(!IsPlayerProgressBarVisible(playerid, BarArmour[playerid])) {
				ShowPlayerProgressBar(playerid, BarArmour[playerid]);
			}
			SetPlayerProgressBarValue(playerid, BarArmour[playerid], armour);
		}
	}
	return 1;
}

/*
 * |>-------------<|
 * |   Net Graph   |
 * |>-------------<|
 */

stock CreatePlayerNetGraphTD(playerid)
{
	if (StateNetGraphTD[playerid][e_Created]) {
		return 0;
	}

	StateNetGraphTD[playerid][e_Created] = true;

	CreatePlayerNetGraphTD2(playerid, TD_NetGraph[playerid]);
	return 1;
}

stock DestroyPlayerNetGraphTD(playerid)
{
	if (!StateNetGraphTD[playerid][e_Created]) {
		return 0;
	}

	StateNetGraphTD[playerid][e_Created] =
	StateNetGraphTD[playerid][e_Shown] = false;

	n_for(i, PLAYER_TD_NET_GRAPH) {
		DestroyPlayerTD(playerid, TD_NetGraph[playerid][i]);
	}
	return 1;
}

stock ShowPlayerNewGraphTD(playerid)
{
	if (!StateNetGraphTD[playerid][e_Created]
	|| StateNetGraphTD[playerid][e_Shown]) {
		return 0;
	}

	StateNetGraphTD[playerid][e_Shown] = true;

	UpdatePlayerNetGraphTD(playerid);

	n_for(i, PLAYER_TD_NET_GRAPH) {
		PlayerTextDrawShow(playerid, TD_NetGraph[playerid][i]);
	}
	return 1;
}

stock HidePlayerNewGraphTD(playerid)
{
	if (!StateNetGraphTD[playerid][e_Created]
	|| !StateNetGraphTD[playerid][e_Shown]) {
		return 0;
	}

	StateNetGraphTD[playerid][e_Shown] = false;

	n_for(i, PLAYER_TD_NET_GRAPH) {
		PlayerTextDrawHide(playerid, TD_NetGraph[playerid][i]);
	}
	return 1;
}

static UpdatePlayerNetGraphTD(playerid)
{
	if (!StateNetGraphTD[playerid][e_Created]
	|| !StateNetGraphTD[playerid][e_Shown]) {
		return 0;
	}

	new
		strColor[5],
		fps = GetPlayerFPS(playerid),
		ping = GetPlayerPing(playerid);

	// FPS
	if (fps > 0) {
		if (fps <= 15) {
			strColor = "~r~";
		}
		else if (fps <= 25) {
			strColor = "~y~";
		}
		else if (fps > 25) {
			strColor = "~g~";
		}

		PlayerTextDrawSetString(playerid, TD_NetGraph[playerid][1], "FPS:_%s%i", strColor, fps);
		strColor[0] = EOS;
	}

	// Ping
	if (ping > 0) {
		if (ping >= 200) {
			strColor = "~r~";
		}
		else if (ping >= 101) {
			strColor = "~y~";
		}
		else if (ping >= 0) {
			strColor = "~g~";
		}

		PlayerTextDrawSetString(playerid, TD_NetGraph[playerid][2], "PING:_%s%i", strColor, ping);
	}
	return 1;
}

/*
 * |>---------------<|
 * |   Match stats   |
 * |>---------------<|
 */

stock ShowPlayerMatchStatsTD(playerid)
{
	if (!StateMatchStatsTD[playerid][e_Created]) {
		CreatePlayerStatsMatchTD(playerid, TD_MatchStats[playerid], GetPlayerRank(playerid), Mode_GetPlayerMatchKills(playerid), Mode_GetPlayerMatchDeaths(playerid));
	}

	StateMatchStatsTD[playerid][e_Created] = true;

	UpdatePlayerMatchStatsTD(playerid);

	n_for(i, PLAYER_TD_MATCH_STATS) {
		PlayerTextDrawShow(playerid, TD_MatchStats[playerid][i]);
	}
	return 1;
}

stock DestroyPlayerMatchStatsTD(playerid)
{
	if (!StateMatchStatsTD[playerid][e_Created]) {
		return 0;
	}

	StateMatchStatsTD[playerid][e_Created] = false;

	n_for(i, PLAYER_TD_MATCH_STATS) {
		DestroyPlayerTD(playerid, TD_MatchStats[playerid][i]);
	}
	return 1;
}

static UpdatePlayerMatchStatsTD(playerid)
{
	if (!StateMatchStatsTD[playerid][e_Created]) {
		return 0;
	}

	PlayerTextDrawSetString(playerid, TD_MatchStats[playerid][0], "Ранг: %i", GetPlayerRank(playerid));
	PlayerTextDrawSetString(playerid, TD_MatchStats[playerid][1], "Убийств: %i", Mode_GetPlayerMatchKills(playerid));
	PlayerTextDrawSetString(playerid, TD_MatchStats[playerid][2], "Смертей: %i", Mode_GetPlayerMatchDeaths(playerid));
	return 1;
}

/*
 * |>----------<|
 * |   Others   |
 * |>----------<|
 */

public: CallUpdatePlayerData(playerid)
{
	Mode_UpdatePlayerData(playerid);

	UpdatePlayerAdminData(playerid);
	UpdatePlayerAnticheatData(playerid);

	UpdatePlayerNetGraphTD(playerid);
	UpdatePlayerMatchStatsTD(playerid);

	UpdatePlayerKillStrike(playerid);
	UpdatePlayerNewRank(playerid);
	UpdatePlayerSpawnKill(playerid);
	UpdatePlayerExitZone(playerid);
	UpdatePlayerLastDamage(playerid);
	UpdatePlayerAntiFloodChat(playerid);
	UpdatePlayerReward(playerid);
	UdpatePlayerDamageIndicator(playerid);

	if (GetPlayerSecondTime(playerid) == 60) {
		SecondTime[playerid] = 0;
		GivePlayerMinuteTime(playerid);

		if (!GetPlayerLogged(playerid)) {
			UpdatePlayerInvData(playerid);

			if (pInfo[playerid][e_PlayedMinutes] < 60) {
				pInfo[playerid][e_PlayedMinutes]++;
			}
			else if (pInfo[playerid][e_PlayedMinutes] >= 60) {
				pInfo[playerid][e_PlayedHours]++;
				pInfo[playerid][e_PlayedMinutes] = 0;
			}

			// Muted
			if (GetPlayerMute(playerid) > 0) {
				SetPlayerMute(playerid, GetPlayerMute(playerid) - 1);
				SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_MUTED_MINUTES"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerMute(playerid), GetPlayerMySQLID(playerid));
			}
		}
	}
	if (GetPlayerMinuteTime(playerid) == 60) {
		MinuteTime[playerid] = 0;
		GivePlayerHourTime(playerid);
	}

	// Ads server
	AdsServer[playerid]++;
	if (AdsServer[playerid] >= 360) {
		AdsServer[playerid] = 0;

		if (!GetPlayerLogged(playerid)) {
			new
				ad = random(3);

			switch (ad) {
				case 0: {
					if (!GetPlayerQuestAllPassed(playerid)) {
						SCM(playerid, C_ORANGE, "--------------------------------------------------------");
						SCM(playerid, C_ORANGE, "• "CT_WHITE"У Вас есть невыполненные квесты {d14545}/quests");
						SCM(playerid, C_ORANGE, "• "CT_WHITE"Приятной игры!");
						SCM(playerid, C_ORANGE, "--------------------------------------------------------");
					}
				}
				case 1: {
					SCM(playerid, C_ORANGE, "--------------------------------------------------------");
					SCM(playerid, C_ORANGE, "• "CT_WHITE"Сайт проекта: {d63838}"SERVER_SITE"");
					SCM(playerid, C_ORANGE, "• "CT_WHITE"Группа ВКонтакте: {eda258}"SERVER_VK"");
					SCM(playerid, C_ORANGE, "• "CT_WHITE"Модификация: {5f6fe8}"SERVER_CLIENT"");
					SCM(playerid, C_ORANGE, "• "CT_WHITE"Приятной игры!");
					SCM(playerid, C_ORANGE, "--------------------------------------------------------");
				}
				case 2: {
					SCM(playerid, C_ORANGE, "--------------------------------------------------------");
					SCM(playerid, C_ORANGE, "• "CT_WHITE"Есть идеи по улучшению игрового сервера?");
					SCM(playerid, C_ORANGE, "• "CT_WHITE"Тогда обращаться нужно на форум!");
					SCM(playerid, C_ORANGE, "• "CT_WHITE"Приятной игры!");
					SCM(playerid, C_ORANGE, "--------------------------------------------------------");
				}
			}
		}
	}
	return 1;
}

stock PlayerSpawn(playerid)
{
	if (IsPlayerNPC(playerid)) {
		return 0;
	}
		
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	if (IsPlayerInAnyVehicle(playerid)) {
		new
			Float:x, Float:y, Float:z;

		GetPlayerPos(playerid, x, y, z);
		SetPlayerPosEx(playerid, x, y, z, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		SetPlayerTimerSpawn(playerid, 50);
	}
	else {
		if (GetSpecPl(playerid)) {
			SpecPl(playerid, false);
		}
		else {
			SpawnPlayer(playerid);
		}
	}
	return 1;
}

static SetPlayerTimerSpawn(playerid, seconds)
{
	TimerSpawn[playerid] = SetPlayerTimer(playerid, "PlayerSpawn", seconds, false);
	return 1;
}

stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, spawnWorld, spawnInterior, setUP = false, freezing = false)
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	if (!setUP) {
		if (GetPlayerVirtualWorldEx(playerid) != spawnWorld) {
			SetPlayerVirtualWorldEx(playerid, spawnWorld);
		}

		if (GetPlayerInteriorEx(playerid) != spawnInterior) {
			SetPlayerInteriorEx(playerid, spawnInterior);
		}
	}

	SetPlayerPos(playerid, x, y, z);

	if (freezing) {
		SetPlayerDamage(playerid, false);
		TogglePlayerControllable(playerid, false);
		TimerFreezingPos[playerid] = SetPlayerTimer(playerid, "CallFreezingPos", 1000, false);
	}
	return 1;
}

stock DestroyPlayerAttachedObjects(playerid)
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	n_for(i, MAX_PLAYER_ATTACHED_OBJECTS) {
		if (IsPlayerAttachedObjectSlotUsed(playerid, i)) {
			RemovePlayerAttachedObject(playerid, i);
		}
	}
	return 1;
}

stock SendPlayerMessageCMD(playerid, const text[])
{
	SCM(playerid, C_RED, ""T_CMD" "CT_WHITE"Введите: "CT_YELLOW"%s", text);
	return 1;
}

stock SetErrorText(playerid, const text[])
{
	SetPVarString(playerid, "ErrorTextString", text);
	return 1;
}

stock IsPlayerInArea(playerid, Float:minX, Float:minY ,Float:maxX, Float:maxY)
{
	new
		Float:X, Float:Y, Float:Z;

	GetPlayerPos(playerid, X, Y, Z);

	if (X <= maxX && X >= minX && Y <= maxY && Y >= minY) {
		return 1;
	}
	return 0;
}

stock GetPlayerSpeed(playerid)
{
	new
		Float:ST1[4];

	GetPlayerVelocity(playerid, ST1[0], ST1[1], ST1[2]);
	ST1[3] = floatsqroot(floatpower(floatabs(ST1[0]), 2.0) + floatpower(floatabs(ST1[1]), 2.0) + floatpower(floatabs(ST1[2]), 2.0)) * 1000;

	return floatround(ST1[3]);
}

stock GetPlayerFPS(playerid)
{
	new
		drunk2 = GetPlayerDrunkLevel(playerid);

	if (drunk2 < 100) {
		SetPlayerDrunkLevel(playerid, 2000);
	}
	else {
		if (LastDrunkLevel[playerid] != drunk2) {
			new
				fps = LastDrunkLevel[playerid] - drunk2;

			LastDrunkLevel[playerid] = drunk2;

			if ((fps > 0) && (fps < 256)) {
				return fps - 1;
			}
		}
	}
	return 0;
}

stock ClearPlayerChat(playerid)
{
	for (new i = 0; i < 20; i++) {
		SCM(playerid, C_WHITE, !" ");
	}
	return 1;
}

stock DestroyPlayerTD(playerid, &PlayerText:tdid)
{
	if (tdid == INVALID_PLAYER_TEXT_DRAW) {
		return 0;
	}

	PlayerTextDrawDestroy(playerid, tdid);
	tdid = INVALID_PLAYER_TEXT_DRAW;
	return 1;
}

stock DestroyPlayerText3D(playerid, &PlayerText3D:text3did)
{
	if (text3did == INVALID_PLAYER_3DTEXT_ID) {
		return 0;
	}

	DeletePlayer3DTextLabel(playerid, text3did);
	text3did = INVALID_PLAYER_3DTEXT_ID;
	return 1;
}

stock PreloadAnimLib(playerid, const animlib[])
{
	return ApplyAnimation(playerid, animlib, "null", 0.0, false, false, false, false, 0);
}

stock PreloadAllAnimLibs(playerid)
{
	PreloadAnimLib(playerid, "AIRPORT");
	PreloadAnimLib(playerid, "Attractors");
	PreloadAnimLib(playerid, "BAR");
	PreloadAnimLib(playerid, "BASEBALL");
	PreloadAnimLib(playerid, "BD_FIRE");
	PreloadAnimLib(playerid, "BEACH");
	PreloadAnimLib(playerid, "BENCHPRESS");
	PreloadAnimLib(playerid, "BF_injection");
	PreloadAnimLib(playerid, "BIKED");
	PreloadAnimLib(playerid, "BIKEH");
	PreloadAnimLib(playerid, "BIKELEAP");
	PreloadAnimLib(playerid, "BIKES");
	PreloadAnimLib(playerid, "BIKEV");
	PreloadAnimLib(playerid, "BIKE_DBZ");
	PreloadAnimLib(playerid, "BLOWJOBZ");
	PreloadAnimLib(playerid, "BMX");
	PreloadAnimLib(playerid, "BOMBER");
	PreloadAnimLib(playerid, "BOX");
	PreloadAnimLib(playerid, "BSKTBALL");
	PreloadAnimLib(playerid, "BUDDY");
	PreloadAnimLib(playerid, "BUS");
	PreloadAnimLib(playerid, "CAMERA");
	PreloadAnimLib(playerid, "CAR");
	PreloadAnimLib(playerid, "CARRY");
	PreloadAnimLib(playerid, "CAR_CHAT");
	PreloadAnimLib(playerid, "CASINO");
	PreloadAnimLib(playerid, "CHAINSAW");
	PreloadAnimLib(playerid, "CHOPPA");
	PreloadAnimLib(playerid, "CLOTHES");
	PreloadAnimLib(playerid, "COACH");
	PreloadAnimLib(playerid, "COLT45");
	PreloadAnimLib(playerid, "COP_AMBIENT");
	PreloadAnimLib(playerid, "COP_DVBYZ");
	PreloadAnimLib(playerid, "CRACK");
	PreloadAnimLib(playerid, "CRIB");
	PreloadAnimLib(playerid, "DAM_JUMP");
	PreloadAnimLib(playerid, "DANCING");
	PreloadAnimLib(playerid, "DEALER");
	PreloadAnimLib(playerid, "DILDO");
	PreloadAnimLib(playerid, "DODGE");
	PreloadAnimLib(playerid, "DOZER");
	PreloadAnimLib(playerid, "DRIVEBYS");
	PreloadAnimLib(playerid, "FAT");
	PreloadAnimLib(playerid, "FIGHT_B");
	PreloadAnimLib(playerid, "FIGHT_C");
	PreloadAnimLib(playerid, "FIGHT_D");
	PreloadAnimLib(playerid, "FIGHT_E");
	PreloadAnimLib(playerid, "FINALE");
	PreloadAnimLib(playerid, "FINALE2");
	PreloadAnimLib(playerid, "FLAME");
	PreloadAnimLib(playerid, "Flowers");
	PreloadAnimLib(playerid, "FOOD");
	PreloadAnimLib(playerid, "Freeweights");
	PreloadAnimLib(playerid, "GANGS");
	PreloadAnimLib(playerid, "GHANDS");
	PreloadAnimLib(playerid, "GHETTO_DB");
	PreloadAnimLib(playerid, "goggles");
	PreloadAnimLib(playerid, "GRAFFITI");
	PreloadAnimLib(playerid, "GRAVEYARD");
	PreloadAnimLib(playerid, "GRENADE");
	PreloadAnimLib(playerid, "GYMNASIUM");
	PreloadAnimLib(playerid, "HAIRCUTS");
	PreloadAnimLib(playerid, "HEIST9");
	PreloadAnimLib(playerid, "INT_HOUSE");
	PreloadAnimLib(playerid, "INT_OFFICE");
	PreloadAnimLib(playerid, "INT_SHOP");
	PreloadAnimLib(playerid, "JST_BUISNESS");
	PreloadAnimLib(playerid, "KART");
	PreloadAnimLib(playerid, "KISSING");
	PreloadAnimLib(playerid, "KNIFE");
	PreloadAnimLib(playerid, "LAPDAN1");
	PreloadAnimLib(playerid, "LAPDAN2");
	PreloadAnimLib(playerid, "LAPDAN3");
	PreloadAnimLib(playerid, "LOWRIDER");
	PreloadAnimLib(playerid, "MD_CHASE");
	PreloadAnimLib(playerid, "MD_END");
	PreloadAnimLib(playerid, "MEDIC");
	PreloadAnimLib(playerid, "MISC");
	PreloadAnimLib(playerid, "MTB");
	PreloadAnimLib(playerid, "MUSCULAR");
	PreloadAnimLib(playerid, "NEVADA");
	PreloadAnimLib(playerid, "ON_LOOKERS");
	PreloadAnimLib(playerid, "OTB");
	PreloadAnimLib(playerid, "PARACHUTE");
	PreloadAnimLib(playerid, "PARK");
	PreloadAnimLib(playerid, "PAULNMAC");
	PreloadAnimLib(playerid, "PED");
	PreloadAnimLib(playerid, "PLAYER_DVBYS");
	PreloadAnimLib(playerid, "PLAYIDLES");
	PreloadAnimLib(playerid, "POLICE");
	PreloadAnimLib(playerid, "POOL");
	PreloadAnimLib(playerid, "POOR");
	PreloadAnimLib(playerid, "PYTHON");
	PreloadAnimLib(playerid, "QUAD");
	PreloadAnimLib(playerid, "QUAD_DBZ");
	PreloadAnimLib(playerid, "RAPPING");
	PreloadAnimLib(playerid, "RIFLE");
	PreloadAnimLib(playerid, "RIOT");
	PreloadAnimLib(playerid, "ROB_BANK");
	PreloadAnimLib(playerid, "ROCKET");
	PreloadAnimLib(playerid, "RUSTLER");
	PreloadAnimLib(playerid, "RYDER");
	PreloadAnimLib(playerid, "SCRATCHING");
	PreloadAnimLib(playerid, "SHAMAL");
	PreloadAnimLib(playerid, "SHOP");
	PreloadAnimLib(playerid, "SHOTGUN");
	PreloadAnimLib(playerid, "SILENCED");
	PreloadAnimLib(playerid, "SKATE");
	PreloadAnimLib(playerid, "SMOKING");
	PreloadAnimLib(playerid, "SNIPER");
	PreloadAnimLib(playerid, "SPRAYCAN");
	PreloadAnimLib(playerid, "STRIP");
	PreloadAnimLib(playerid, "SUNBATHE");
	PreloadAnimLib(playerid, "SWAT");
	PreloadAnimLib(playerid, "SWEET");
	PreloadAnimLib(playerid, "SWIM");
	PreloadAnimLib(playerid, "SWORD");
	PreloadAnimLib(playerid, "TANK");
	PreloadAnimLib(playerid, "TATTOOS");
	PreloadAnimLib(playerid, "TEC");
	PreloadAnimLib(playerid, "TRAIN");
	PreloadAnimLib(playerid, "TRUCK");
	PreloadAnimLib(playerid, "UZI");
	PreloadAnimLib(playerid, "VAN");
	PreloadAnimLib(playerid, "VENDING");
	PreloadAnimLib(playerid, "VORTEX");
	PreloadAnimLib(playerid, "WAYFARER");
	PreloadAnimLib(playerid, "WEAPONS");
	PreloadAnimLib(playerid, "WUZI");
	return 1;
}

stock TDRandomColor(playerid, PlayerText:tdid)
{
	new
		r = random(11);

	switch (r) {
		case 0: PlayerTextDrawColour(playerid, tdid, 0xff3030FF);
		case 1: PlayerTextDrawColour(playerid, tdid, 0x5630ffFF);
		case 2: PlayerTextDrawColour(playerid, tdid, 0x2ec8d9FF);
		case 3: PlayerTextDrawColour(playerid, tdid, 0x2ed947FF);
		case 4: PlayerTextDrawColour(playerid, tdid, 0x83d92eFF);
		case 5: PlayerTextDrawColour(playerid, tdid, 0xd9d92eFF);
		case 6: PlayerTextDrawColour(playerid, tdid, 0xa32ed9FF);
		case 7: PlayerTextDrawColour(playerid, tdid, 0x2e8cd9FF);
		case 8: PlayerTextDrawColour(playerid, tdid, 0x8cd92eFF);
		case 9: PlayerTextDrawColour(playerid, tdid, 0xd92e97FF);
		case 10: PlayerTextDrawColour(playerid, tdid, 0x2ed99dFF);
	}
	PlayerTextDrawShow(playerid, tdid);
	return 1;
}

stock TDRandomVehicle(playerid, PlayerText:tdid)
{
	new
		r = random(5);

	switch (r) {
		case 0: PlayerTextDrawSetPreviewModel(playerid, tdid, 432);
		case 1: PlayerTextDrawSetPreviewModel(playerid, tdid, 433);
		case 2: PlayerTextDrawSetPreviewModel(playerid, tdid, 470);
		case 3: PlayerTextDrawSetPreviewModel(playerid, tdid, 528);
		case 4: PlayerTextDrawSetPreviewModel(playerid, tdid, 601);
	}
	return 1;
}

stock ClosePlayerDialog(playerid)
{
	if (Dialog_IsOpen(playerid, Dialog:ReportAnswer)) {
		CloseReportDialogAnswer(playerid);
	}

	else if (Dialog_IsOpen(playerid, Dialog:TDM_ClassBuyAmmo)) {
		DeletePVar(playerid, "TDM_BuyAmmo");
	}

	else if (Dialog_IsOpen(playerid, Dialog:ListAnimations)) {
		n_for(i, MAX_PLAYER_ANIMATIONS) {
			DialogListAnims[playerid][i] = -1;
		}
	}

	else if (Dialog_IsOpen(playerid, Dialog:TDM_ClSkillsWeapon)
	|| Dialog_IsOpen(playerid, Dialog:TDM_ClSkillsCloseFight)
	|| Dialog_IsOpen(playerid, Dialog:TDM_ClassChooseStats)
	|| Dialog_IsOpen(playerid, Dialog:TDM_BuyListClAbility)
	|| Dialog_IsOpen(playerid, Dialog:TDM_PlayerClassStats)) {
		if (!Interface_IsOpen(playerid, Interface:TDM_SelectedClass)) {
			SetPlayerCustomClass2(playerid, -1);
		}

		TDM_ResetDialogClassAbils(playerid);
		DeletePVar(playerid, "ClassAbilityID");
	}

	Dialog_Close(playerid);
	return 1;
}

stock ProxDetector(Float:radi, playerid, const str[], col1, col2, col3, col4, col5)
{
	if (!IsPlayerOnServer(playerid)) {
		return 1;
	}

	new
		Float:posX, Float:posY, Float:posZ,
		Float:oldPosX, Float:oldPosY, Float:oldPosZ,
		Float:tempPosX, Float:tempPosY, Float:tempPosZ;

	GetPlayerPos(playerid, oldPosX, oldPosY, oldPosZ);

	foreach (Player, p) {
		GetPlayerPos(p, posX, posY, posZ);
		tempPosX = (oldPosX -posX);
		tempPosY = (oldPosY -posY);
		tempPosZ = (oldPosZ -posZ);

		if (((tempPosX < radi/16) && (tempPosX > -radi/16)) && ((tempPosY < radi/16)
		&& (tempPosY > -radi/16)) && ((tempPosZ < radi/16) && (tempPosZ > -radi/16))) {
			SCM(p, col1, str);
		}

		else if (((tempPosX < radi/8) && (tempPosX > -radi/8)) && ((tempPosY < radi/8)
		&& (tempPosY > -radi/8)) && ((tempPosZ < radi/8) && (tempPosZ > -radi/8))) {
			SCM(p, col2, str);
		}

		else if (((tempPosX < radi/4) && (tempPosX > -radi/4)) && ((tempPosY < radi/4)
		&& (tempPosY > -radi/4)) && ((tempPosZ < radi/4) && (tempPosZ > -radi/4))) {
			SCM(p, col3, str);
		}
		
		else if (((tempPosX < radi/2) && (tempPosX > -radi/2)) && ((tempPosY < radi/2)
		&& (tempPosY > -radi/2)) && ((tempPosZ < radi/2) && (tempPosZ > -radi/2))) {
			SCM(p, col4, str);
		}

		else if (((tempPosX < radi) && (tempPosX > -radi)) && ((tempPosY < radi)
		&& (tempPosY > -radi)) && ((tempPosZ < radi) && (tempPosZ > -radi))) {
			SCM(p, col5, str);
		}
	}
	return 1;
}

stock ProxDetectorS(Float:radi, playerid, targetid)
{
	if (IsPlayerOnServer(playerid)
	&& IsPlayerOnServer(targetid)) {
		return 0;
	}

	new
		Float:posX, Float:posY, Float:posZ,
		Float:oldPosX, Float:oldPosY, Float:oldPosZ,
		Float:tempPosX, Float:tempPosY, Float:tempPosZ;

	GetPlayerPos(playerid, oldPosX, oldPosY, oldPosZ);
	GetPlayerPos(targetid, posX, posY, posZ);

	tempPosX = (oldPosX -posX);
	tempPosY = (oldPosY -posY);
	tempPosZ = (oldPosZ -posZ);

	if (((tempPosX < radi) && (tempPosX > -radi)) && ((tempPosY < radi)
	&& (tempPosY > -radi)) && ((tempPosZ < radi) && (tempPosZ > -radi))) {
		return 1;
	}
	return 0;
}

static SetPlayerAnimation(playerid, animid)
{
	switch (animid) {
		case 0: ApplyAnimation(playerid, "BEACH", "bather", 4.0, true, false, false, false, 0);
		case 1: ApplyAnimation(playerid, "RAPPING", "RAP_A_Loop", 4.0, true, false, false, false, 0);
		case 2: ApplyAnimation(playerid, "RAPPING", "RAP_C_Loop", 4.0, true, false, false, false, 0);
		case 3: ApplyAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.0, false, false, false, true, 1, SYNC_ALL);
		case 4: ApplyAnimation(playerid, "JST_BUISNESS", "girl_02", 4.1, false, false, false, true, 1, SYNC_ALL);
		case 5: ApplyAnimation(playerid, "ROB_BANK", "SHP_HandsUp_Scr", 4.1, false, true, true, true, 1, SYNC_ALL);
		case 6: ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, false, false, false, false, 0, SYNC_ALL);
		case 7: ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, false, false, false, false, 0, SYNC_ALL);
		case 8: ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, true, false, false, true, 0, SYNC_ALL);
		case 9: ApplyAnimation(playerid, "PED", "fucku", 4.0, false, false, false, false, 0, SYNC_ALL);
		case 10: ApplyAnimation(playerid, "PARK", "Tai_Chi_Loop", 4.0, true, false, false, false, 0, SYNC_ALL);
		case 11: ApplyAnimation(playerid, "KISSING", "Playa_Kiss_02", 4.0, false, false, false, false, 0, SYNC_ALL);
		case 12: ApplyAnimation(playerid, "KISSING", "Grlfrd_Kiss_03", 4.0, false, false, false, false, 0, SYNC_ALL);
		case 13: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE2);
		case 14: SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DANCE3);
		case 15: SetPlayerSpecialAction(playerid ,SPECIAL_ACTION_DANCE4);
		case 16: ApplyAnimation(playerid, "PARK", "Tai_Chi_Loop", 4.0, true, false, false, false, 0);
		case 17: ApplyAnimation(playerid, "PED", "IDLE_taxi", 4.0, false, false, false, false, 0);
		case 18: ApplyAnimation(playerid, "INT_HOUSE", "LOU_In", 4.1, false, false, false, true, 1, SYNC_ALL);
		case 19: ApplyAnimation(playerid, "PED", "SEAT_down", 4.1, false, false, false, true, 1, SYNC_ALL);
		case 20: ApplyAnimation(playerid, "SUNBATHE", "Lay_Bac_in", 3.0, false, true, true, true, 0);
		case 21: ApplyAnimation(playerid, "BEACH", "ParkSit_W_loop", 3.0, false, true, true, true, 0);
		case 22: ApplyAnimation(playerid, "BEACH", "SitnWait_loop_W", 4.0, true, false, false, false, 0);
		case 23: ApplyAnimation(playerid, "PED", "IDLE_armed", 4.1, false, true, true, true, 1, SYNC_ALL);
		case 24: ApplyAnimation(playerid, "PED", "Gun_stand", 4.1, false, true, true, true, 1, SYNC_ALL);
		case 25: ApplyAnimation(playerid, "KISSING", "gfwave2", 4.1, false, true, true, false, 0);
		case 26: ApplyAnimation(playerid, "ON_LOOKERS", "wave_loop", 4.1, true, true, true, false, 0);
		case 27: ApplyAnimation(playerid, "CAMERA", "camstnd_cmon", 4.0, false, false, false, false, 0);
		case 28: ApplyAnimation(playerid, "PED", "BIKE_fall_off", 4.1, false, true, true, true, 1, SYNC_ALL);
		case 29: ApplyAnimation(playerid, "PED", "BIKE_pickupL", 4.1, false, false, false, false, 0, SYNC_ALL);
		case 30: ApplyAnimation(playerid, "GANGS", "hndshkaa", 4.0, false, false, false, false, 0, SYNC_ALL);
		case 31: ApplyAnimation(playerid, "GANGS", "hndshkfa", 4.0, false, false, false, false, 0, SYNC_ALL);
		case 32: ApplyAnimation(playerid, "GANGS", "hndshkfa_swt", 4.0, false, false, false, false, 0, SYNC_ALL);
		case 33: ApplyAnimation(playerid, "BAR", "dnk_stndF_loop", 4.1, false, false, false, false, 0, SYNC_ALL);
		case 34: ApplyAnimation(playerid, "GANGS", "shake_carK", 4.0, false, false, false, false, 0);
		case 35: ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, false, true, true, true, 0);
		case 36: ApplyAnimation(playerid, "PED", "cower", 3.0, true, false, false, false, 0);
		case 37: ApplyAnimation(playerid, "GANGS", "shake_cara", 4.0, false, false, false, false, 0);
		case 38: ApplyAnimation(playerid, "MISC", "scratchballs_01", 4.0, false, false, false, false, 0);
		case 39: ApplyAnimation(playerid, "SPRAYCAN", "spraycan_full", 4.0, false, false, false, false, 0);
		case 40: ApplyAnimation(playerid, "MEDIC", "CPR", 4.0, false, false, false, false, 0);
		case 41: ApplyAnimation(playerid, "PED", "KO_shot_stom", 4.0, false, true, true, true, 0);
		case 42: ApplyAnimation(playerid, "PED", "EV_dive", 4.0, false, true, true, true, 0);
		case 43: ApplyAnimation(playerid, "PED", "BIKE_fallR", 4.0, false, true, true, true, 0);
		case 44: ApplyAnimation(playerid, "GYMNASIUM", "GYMshadowbox", 4.0, true, true, true, true, 0);
		case 45: ApplyAnimation(playerid, "BENCHPRESS", "gym_bp_celebrate", 4.0, false, false, false, false, 0);
		case 46: ApplyAnimation(playerid, "RIOT", "RIOT_ANGRY", 4.0, false, false, false, false, 0);
		case 47: ApplyAnimation(playerid, "BEACH", "ParkSit_M_loop", 4.0, true, false, false, false, 0);
		case 48: ApplyAnimation(playerid, "PED", "gang_gunstand", 3.0, false, true, true, true, 0);
		case 49: ApplyAnimation(playerid, "DANCING", "DAN_Right_A", 4.1, true, false, false, false, 0);
	}

	SetPlayerAnimationEx(playerid, true);

	SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Нажмите "CT_YELLOW"ENTER/SPACE "CT_WHITE"для остановки анимации.");
	return 1;
}

stock SetPlayerAntiFloodChat(playerid, seconds = 2)
{	
	TimerFloodText[playerid] += seconds;
	return 1;
}

stock GetPlayerAntiFloodChat(playerid)
{
	return TimerFloodText[playerid];
}

static UpdatePlayerAntiFloodChat(playerid)
{
	if (TimerFloodText[playerid] > 0) {
		TimerFloodText[playerid]--;
	}
	return 1;
}

stock SCMEX(playerid, color, message[], bool:chatText)
{
	new
		messageLength = strlen(message);

	n_for(i, messageLength) {
		if (message[i] == '%') {
			message[i] = '#';
		}
	}

	static
		outstr[300];

	outstr[0] = EOS;

	new
		length = strlen(message),
		trim, color_f[9];

	if (length > 80) {
		for (new i = 80; i >= 0; i--) {
			trim = i;
			if (message[i] == ' ') {
				for (new b = i; b >= 0; b--) {
					if (message[b] == '{') {
						n_for(v, 8) {
							color_f[v] = message[b + v];
						}
						break;
					}
				}
				break;
			}
		}

		if (trim < 64) {
			trim = 80;
		}

		strmid(outstr, message, 0, trim);
		SCM(playerid, color, outstr);
		strmid(outstr, message, trim, length);

		if (!chatText) {
			f(outstr, "%s%s", color_f, outstr);
		}
		else {
			f(outstr, ""CT_WHITE"%s", outstr);
		}

		SCM(playerid, color, outstr);
	}
	else {
		SCM(playerid, color, message);
	}
	return 1;
}

stock UpdatePlayerInAFK(playerid) 
{
	if (TimeAFK[playerid] == -1
	|| TimeAFK[playerid] == -2) {
		TimeAFK[playerid]++;
	}
	if (TimeAFK[playerid] >= 0) {
		TimeAFK[playerid]++;

		SetPlayerChatBubble(playerid, "AFK %d", 0xad1a1aFF, 30.0, 3000, TimeAFK[playerid]);
	}
	return 1;
}

static IsPlayerInBlackList(playerid, playerid_blacklist)
{
	n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
		if (pInfo[playerid][e_Blacklist][i] != GetPlayerMySQLID(playerid_blacklist)) {
			continue;
		}
		return 1;
	}
	return 0;
}

static CheckPlayerBlacklists(playerid, playerid_blacklist)
{
	if (IsPlayerInBlackList(playerid, playerid_blacklist)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный игрок находится у Вас в чёрном списке.");
		return 1;	
	}
	if (IsPlayerInBlackList(playerid_blacklist, playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы находитесь в чёрном списке у данного игрока.");
		return 1;	
	}
	return 0;
}

stock CheckSpectatingPlayers(playerid, killerid)
{
	TDM_SquadCheckSpecPlayers(playerid);

	// If the player is being watched by the dead
	if (Iter_Count(SpecDeadPlayers[playerid]) > 0) {
		if (killerid != INVALID_PLAYER_ID) {
			foreach (new p:SpecDeadPlayers[playerid]) {
				Iter_Add(SpecDeadPlayers[killerid], p);
				SetPlayerSpectating(p, killerid);

				if (IsPlayerInAnyVehicle(killerid)) {
					PlayerSpectateVehicle(p, GetPlayerVehicleID(killerid));
				}
				else { 
					PlayerSpectatePlayer(p, killerid);
				}
			}
		}
		else {
			foreach (new p:SpecDeadPlayers[playerid]) {
				RemovePlayerDead(p);
				Mode_OnPlayerSpawn(p);
			}
		}
		Iter_Clear(SpecDeadPlayers[playerid]);
	}
	return 1;
}

stock ConnectPlayerServer(playerid)
{
	SetPlayerORMData(playerid);

	PlayerConnectServerMessage(playerid);
	ShowPlayerMainMenu(playerid);

	SCM(playerid, C_WHITE, " ");
	SendPlayerDinaMessageLogin(playerid);
	return 1;
}

stock IsPlayerInvalided(playerid)
{
	if (playerid < 0 || playerid >= MAX_PLAYERS || playerid == INVALID_PLAYER_ID) {
		return 0;
	}

	if (!IsPlayerConnected(playerid)) {
		return 0;
	}
	return 1;
}

stock IsPlayerOnServer(playerid)
{
	if (!IsPlayerConnected(playerid)) {
		return 0;
	}

	if (GetPlayerLogged(playerid)) {
		return 0;
	}
	return 1;
}

// by Londlem & Daniel_Cortez
stock ClearKillFeed(playerid = INVALID_PLAYER_ID)
{
	#if defined _INC_open_mp
		if ((playerid != INVALID_PLAYER_ID) && (false == IsPlayerConnected(playerid)))
			return 0;
	#else
		if ((playerid != INVALID_PLAYER_ID) && (0 == IsPlayerConnected(playerid)))
			return 0;
	#endif

	goto L_start;
	// avoid possible stack overflow (due to using push.* opcodes)
	{
		new dummy[16/(cellbits/charbits)];
		#emit const.pri dummy
	}
#if __Pawn < 0x030A
	// optional sysreq.c bugfix
	SendDeathMessage(0, 0, 0),
	SendDeathMessageToPlayer(0, 0, 0, 0);
#endif
L_start:
	const CKF_MAGIC_ID = INVALID_PLAYER_ID - 1;
	// this variable is also used as weaponid parameter
	new i = 5;
	// push killer and killee IDs
	#emit    push.c    CKF_MAGIC_ID
	#emit    push.c    CKF_MAGIC_ID
	if (playerid == INVALID_PLAYER_ID)
	{
		#emit    push.c    12
		do{
			#emit    sysreq.c    SendDeathMessage
		}while(--i != 0);
		#emit    stack    12
	}
	else
	{
		#emit    push.s    playerid
		#emit    push.c    16
		do{
			#emit    sysreq.c    SendDeathMessageToPlayer
		}while(--i != 0);
		#emit    stack    16
	}
	return 1;
}

static ConnectNewPlayerServer(playerid)
{
	SetPlayerORMData(playerid);
	PlayerConnectServerMessage(playerid);
	ShowPlayerMainMenu(playerid);
	return 1;
}

static PlayerConnectServerMessage(playerid)
{
	SCM(playerid, C_WHITE, " ");

	foreach (Player, p) {
		if (!IsPlayerOnServer(p)) {
			continue;
		}

		SCM(p, C_GREY, "%s "T_PID" подключился к серверу!", GetPlayerNameEx(playerid), playerid);
	}

	new
		str[100];
	
	f(str, "~n~~n~~n~~n~~n~~n~~b~Welcome~n~~y~~h~%s", GetPlayerNameEx(playerid));

	GameTextForPlayer(playerid, str, 5000, 5);
	return 1;
}

static CheckPlayerNextRank(playerid)
{
	if (!IsPlayerInvalided(playerid)) {
		return 0;
	}

	if (GetPlayerRank(playerid) > 0 && GetPlayerRank(playerid) < 4) {
		return GetPlayerRank(playerid) * 100 + 1500;
	}

	else if (GetPlayerRank(playerid) > 3 && GetPlayerRank(playerid) < 15) {
		return GetPlayerRank(playerid) * 1000;
	}

	else if (GetPlayerRank(playerid) > 14) {
		return GetPlayerRank(playerid) * 2000;
	}
	return 1;
}

/*
 * |>-------------<|
 * |     Reset     |
 * |>-------------<|
 */

static ResetPlayerGlobalData(playerid)
{
	AntiC{playerid}						=
	PermissionPlayerSpawn{playerid}		=
	ActiveTDRank{playerid}				= true;

	ActiveClickTD{playerid}			=
	ActionZone{playerid}			=
	ActiveInvisible{playerid}		=
	ActiveSpectate{playerid}		=
	ActiveExitZone{playerid}		=
	ActiveLastDamage{playerid}		=
	ActiveSpawnKill{playerid}		=
	ActiveJetPack{playerid}			=
	CanStartSpectating{playerid}	=
	ActiveAnimation{playerid}		=
	ActiveFreeze{playerid}			=
	ActiveKillStrike{playerid}		=
	CreatedTDRank{playerid}			= false;

	AdsServer[playerid]				=
	LastDrunkLevel[playerid]		=
	TimerExitZone[playerid]			=
	TimerKillStrike[playerid]		=
	ScoreKillStrike[playerid]		=
	TimerTDRank[playerid]			=
	TimerFloodText[playerid]		=
	TimerSpawnKill[playerid]		=
	TimerLastDamage[playerid]		=
	ActiveBelowHealth[playerid]		=
	ListFirstReferal[playerid]		=
	SecondTime[playerid]			=
	MinuteTime[playerid]			=
	HourTime[playerid]				= 0;

	CheckPlayerid[playerid]		= 
	CheckingPlayerid[playerid]	= -1;

	SpectatingStatus[playerid]	= PLAYER_SPECTATE_INVALID;
	SpectatingID[playerid]		= INVALID_PLAYER_ID;
	AntiMoreKeys[playerid]		= UNKNOWN_KEY;

	CheckingReferalName[playerid][0] = EOS;

	PlayerFightStyle[playerid] = FIGHT_STYLE_NORMAL;

	n_for(i, MAX_PLAYER_ANIMATIONS)
		DialogListAnims[playerid][i] = -1;

	// Black list
	ListBlackListCount[playerid] = 0;

	n_for(i, 10)
		ListBlacklist[playerid][i] = -1;

	ResetPlayerInfoData(playerid);

	SetPlayerCustomClass(playerid, -1);
	SetPlayerCustomClass2(playerid, -1);

	Mode_ResetPlayerMatchKills(playerid);
	Mode_ResetPlayerMatchDeaths(playerid);
	return 1;
}

static ResetPlayerInfoData(playerid)
{
	// MySQL
	pInfo[playerid][e_ORM_ID]				= ORM:0;
	pInfo[playerid][e_ID]					= -1;

	pInfo[playerid][e_Name][0]				=
	pInfo[playerid][e_Referal][0]			=
	pInfo[playerid][e_RegIP][0]				=
	pInfo[playerid][e_LastIP][0]			=
	pInfo[playerid][e_RegDatetime][0]		=
	pInfo[playerid][e_LastDatetime][0]		= EOS;

	pInfo[playerid][e_FoundServer]			=
	pInfo[playerid][e_Sex]					=
	pInfo[playerid][e_Rank]					=
	pInfo[playerid][e_Exp]					=
	pInfo[playerid][e_Money]				=
	pInfo[playerid][e_GoldCoins]			=
	pInfo[playerid][e_Kills]				=
	pInfo[playerid][e_Deaths]				=
	pInfo[playerid][e_WinningMatchs]		=
	pInfo[playerid][e_LosingMatchs]			=
	pInfo[playerid][e_ShotsEnemy]			=
	pInfo[playerid][e_ShotsHead]			=
	pInfo[playerid][e_SeriesKills]			=
	pInfo[playerid][e_Warns]				=
	pInfo[playerid][e_MutedMinutes]			=
	pInfo[playerid][e_PlayedHours]			=
	pInfo[playerid][e_PlayedMinutes]		= 0;

	mysql_escape_string(DB_STRING_VALUE_NO, pInfo[playerid][e_Referal], MAX_PLAYER_NAME);

	n_for(i, MAX_PLAYER_ANIMATIONS) {
		pInfo[playerid][e_Animations][i] = 0;
	}

	n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
		pInfo[playerid][e_Blacklist][i] = -1;
	}

	// Server
	pInfo[playerid][e_StatusDead] 			=
	pInfo[playerid][e_Team]					=
	pInfo[playerid][e_Weather]				= 0;

	pInfo[playerid][e_StatusDamage] 		= false;

	StateNetGraphTD[playerid][e_Created]		=
	StateNetGraphTD[playerid][e_Shown]			=

	StateMatchStatsTD[playerid][e_Created]		=
	StateMatchStatsTD[playerid][e_Shown]		= false;
	return 1;
}

static ResetPlayerCoreTDs(playerid)
{
	TD_TimerSpawnKill[playerid] = INVALID_PLAYER_TEXT_DRAW;
	TD_NewRank[playerid] = INVALID_PLAYER_TEXT_DRAW;
	TD_AfterDead[playerid] = INVALID_PLAYER_TEXT_DRAW;
	TD_KillStrike[playerid] = INVALID_PLAYER_TEXT_DRAW;

	n_for(i, PLAYER_TD_EXIT_ZONE) {
		TD_ExitZone[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, PLAYER_TD_DEAD_KILLER) {
		TD_DeadKiller[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, PLAYER_TD_MATCH_STATS) {
		TD_MatchStats[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}

	n_for(i, PLAYER_TD_NET_GRAPH) {
		TD_NetGraph[playerid][i] = INVALID_PLAYER_TEXT_DRAW;
	}
	return 1;
}

/*
 * |>----------------<|
 * |     Commands     |
 * |>----------------<|
 */

/*
 * |>--------<|
 * |   Test   |
 * |>--------<|
 */

CMD:test(playerid)
{
	TDM_GivePlayerExplosive(playerid, 2);
	return 1;
}

CMD:killtest(playerid)
{
	SetPlayerArmourEx(playerid, 0.0);
	SetPlayerHealthEx(playerid, 0.0);
	return 1;
}

CMD:none_mode(playerid)
{
	if (GetAdminLevel(playerid) < ADM_LEVEL_STEERING) {
		return 1;
	}

	if (!GetPVarInt(playerid, "NONE_MODE_CMD")) {
		Mode_LeavePlayer(playerid);
		SetPVarInt(playerid, "NONE_MODE_CMD", 1);

		SCM(playerid, C_WHITE, "Выход из всех режимов прошёл успешно.");
	}
	else {
		DeletePVar(playerid, "NONE_MODE_CMD");

		SCM(playerid, C_WHITE, "Заход в режимы прошёл успешно.");
		Mode_EnterPlayer(playerid, MODE_NONE, playerid);
	}
	return 1;
}

//

CMD:chlen(playerid)
{
	if (IsPlayerAttachedObjectSlotUsed(playerid, 7)) {
		RemovePlayerAttachedObject(playerid, 7);
	}

	if (strcmp(GetPlayerNameEx(playerid), "Foxze", true)) {
		SetPlayerAttachedObject(playerid, 7, 322, 1, -0.280000, 0.277000, 0.127999, -83.299995, 27.499996, 14.699998, 1.869000, 2.542000, 2.602000);
	}
	else {
		SetPlayerAttachedObject(playerid, 7, 321, 1, 0.417000, 0.525999, 0.076999, -12.400009, -84.800254, 78.199996, 4.633003, 3.878999, 1.517999);
	}
	return 1;
}

CMD:leave(playerid)
{
	if (GetAdminSpectating(playerid)) {
		return 1;
	}

	if (Mode_GetPlayerMode(playerid) == MODE_NONE
	|| Mode_GetPlayerMode(playerid) == -1) {
		return 1;
	}

	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 1;
	}

	Mode_LeavePlayer(playerid);
	Mode_EnterPlayer(playerid, MODE_NONE, playerid);
	return 1;
}

CMD:exit(playerid)
{
	return callcmd::leave(playerid);
}

CMD:o(playerid, params[])
{
	if (isnull(params)) {
		return SendPlayerMessageCMD(playerid, "/o [текст]");
	}

	if (GetPlayerAntiFloodChat(playerid) > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Не флуди!");
		return 1;
	}

	static
		string[300];

	f(string, ""CT_GREY"[OC]:{FFCC33}[Р: %i]:{%06x}%s(%d): "CT_WHITE"%s", GetPlayerRank(playerid), GetPlayerColorEx(playerid) >>> 8, GetPlayerNameEx(playerid), playerid, params);

	foreach (Player, p) {
		if (!IsPlayerOnServer(p)) {
			continue;
		}

		SCMEX(p, -1, string, true);
	}
	SetPlayerAntiFloodChat(playerid);
	return 1;
}

CMD:referals(playerid)
{
	SetCheckNameReferal(playerid, GetPlayerNameEx(playerid));
	Dialog_Show(playerid, Dialog:ListReferals);
	return 1;
}

CMD:quest(playerid)
{
	return Dialog_Show(playerid, Dialog:QuestsSelectMode);
}

CMD:quests(playerid)
{
	return callcmd::quest(playerid);
}

CMD:mission(playerid)
{
	return callcmd::quest(playerid);
}

CMD:missions(playerid)
{
	return callcmd::quest(playerid);
}

CMD:me(playerid, params[])
{
	if (isnull(params)) {
		return SendPlayerMessageCMD(playerid, "/me [текст]");
	}

	if (GetPlayerAntiFloodChat(playerid) > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Не флуди!");
		return 1;
	}

	new
		str[200];

	f(str, ""CT_YELLOW"%s {FF99FF}%s", GetPlayerNameEx(playerid), params);

	ProxDetector(25.0, playerid, str, -1, -1, -1, -1, -1);
	SetPlayerChatBubble(playerid, str, -1, 15.0, 5000);

	SetPlayerAntiFloodChat(playerid);
	return 1;
}

CMD:anims(playerid)
{
	if (IsPlayerInAnyVehicle(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В машине запрещено использовать анимации!");
		return 1;
	}

	if (GetPlayerAnimationEx(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы уже используете анимацию.");
		return 1;
	}

	Dialog_Show(playerid, Dialog:BuyAnimations);
	return 1;
}

CMD:blacklist(playerid)
{
	ListBlackListCount[playerid] = 0;
	
	n_for(i, 10)
		ListBlacklist[playerid][i] = -1;
	
	Dialog_Show(playerid, Dialog:BlackListPlayers);
	return 1;
}

CMD:help(playerid)
{
	return Dialog_Show(playerid, Dialog:Help);
}

CMD:info(playerid)
{
	return callcmd::help(playerid);
}

CMD:menu(playerid)
{
	return Dialog_Show(playerid, Dialog:PlayerMenu);
}

CMD:mn(playerid)
{
	return callcmd::menu(playerid);
}

CMD:mm(playerid)
{
	return callcmd::menu(playerid);
}

CMD:donate(playerid)
{
	return Dialog_Show(playerid, Dialog:Donate);
}

CMD:cmds(playerid)
{
	return Dialog_Show(playerid, Dialog:CommandsServer);
}

CMD:rules(playerid)
{
	return Dialog_Show(playerid, Dialog:ServerRules);
}

CMD:stats(playerid)
{
	if (CheckingPlayerid[playerid] > -1) {
		CheckingPlayerid[playerid] = -1;
	}
	
	Dialog_Show(playerid, Dialog:ChoosePlayerStats);
}

CMD:photo(playerid)
{
	GivePlayerWeaponEx(playerid, WEAPON_CAMERA, 100);
	return 1;
}

CMD:piss(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_PISSING);

	SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Нажмите "CT_YELLOW"ENTER/SPACE "CT_WHITE"для остановки анимации.");
	return 1;
}

CMD:pm(playerid, params[])
{
	new
		playerPM, text[MAX_LENGTH_PLAYER_PM];

	if (sscanf(params, "us["MAX_STR_PLAYER_PM"]", playerPM, text)) {
		return SendPlayerMessageCMD(playerid, "/pm [id игрока] [текст]");
	}

	if (!IsPlayerOnServer(playerPM)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрок не в сети.");
		return 1;
	}

	if (playerid == playerPM) {
		return 1;
	}

	if (strlen(text) > MAX_LENGTH_PLAYER_PM - 1) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Больше "MAX_STR_PLAYER_PM" символов запрещено вводить.");
		return 1;
	}

	if (CheckPlayerBlacklists(playerid, playerPM)) {
		return 1;
	}

	if (GetPlayerAntiFloodChat(playerid) > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Не флуди!");
		return 1;
	}

	SCM(playerPM, C_GREY, ""T_PM" %s "T_PID": "CT_WHITE"%s", GetPlayerNameEx(playerid), playerid, text);
	SCM(playerid, C_GREY, ""T_PM" Игроку %s "T_PID": "CT_WHITE"%s", GetPlayerNameEx(playerPM), playerPM, text);

	PlayerPlaySoundEx(playerPM, 1138, 0.0, 0.0, 0.0);
	PlayerPlaySoundEx(playerid, 1137, 0.0, 0.0, 0.0);

	SetPlayerAntiFloodChat(playerid);
	return 1;
}

/*
 * |>---------------<|
 * |     Dialogs     |
 * |>---------------<|
 */

/*
 * |>------------------------<|
 * |   List player referals   |
 * |>------------------------<|
 */

DialogCreate:ListReferals(playerid)
{
	static
		string[1300];

	new
		query[150 - 2 + DB_MAX_LENGTH_TABLE_NAME + (DB_MAX_LENGTH_FIELD_NAME * 3) + MAX_PLAYER_NAME + 1];

	mysql_format(MySQLID, query, sizeof(query),
	"SELECT `"DB_ACCOUNTS_NICKNAME"`, `"DB_ACCOUNTS_RANK"` \
	FROM `"DB_ACCOUNTS"` \
	WHERE BINARY `"DB_ACCOUNTS_REFERAL"` = '%s' LIMIT 10",
	CheckingReferalName[playerid]);

	new
		Cache:result = mysql_query(MySQLID, query);

	if (!cache_num_rows()) {
		SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Игрока никто не указывал как реферал.");
		return 1;
	}

	ListFirstReferal[playerid] = 0;

	new
		rank,
		name[MAX_PLAYER_NAME];

	n_for(i, cache_num_rows()) {
		name[0] = EOS;

		cache_get_value_name(i, DB_ACCOUNTS_NICKNAME, name, MAX_PLAYER_NAME);
		cache_get_value_name_int(i, DB_ACCOUNTS_RANK, rank);

		f(string, "%s"CT_WHITE"%i. "CT_YELLOW"%s "CT_WHITE"- "CT_GREY"%i "CT_WHITE"ранг\n", string, i + 1, name, rank);
	}
	cache_delete(result);

	Dialog_Open(playerid, Dialog:ListReferals, DSM, "Приглашенные", string, "Далее", "Назад");
	return 1;
}

DialogResponse:ListReferals(playerid, response, listitem, inputtext[])
{
	if (response) {
		ListFirstReferal[playerid] += 10;
	}
	else {
		if (ListFirstReferal[playerid] >= 10)  {
			ListFirstReferal[playerid] -= 10;
		}
		else {
			return 1;
		}
	}

	static
		string[1300];

	new
		query[150 - 2 + DB_MAX_LENGTH_TABLE_NAME + (DB_MAX_LENGTH_FIELD_NAME * 3) + MAX_PLAYER_NAME + 1];

	mysql_format(MySQLID, query, sizeof(query),
	"SELECT `"DB_ACCOUNTS_NICKNAME"`, `"DB_ACCOUNTS_RANK"` \
	FROM `"DB_ACCOUNTS"` \
	WHERE BINARY `"DB_ACCOUNTS_REFERAL"` = '%s' LIMIT %i, 10",
	CheckingReferalName[playerid], ListFirstReferal[playerid]);

	new
		Cache:result = mysql_query(MySQLID, query);

	if (!cache_num_rows()) {
		SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Больше вас никто не указывал как реферал.");
		return 1;
	}

	new
		name[MAX_PLAYER_NAME],
		rank;

	n_for(i, cache_num_rows()) {
		cache_get_value_name(i, DB_ACCOUNTS_NICKNAME, name, MAX_PLAYER_NAME);
		cache_get_value_name_int(i, DB_ACCOUNTS_RANK, rank);

		f(string, "%s"CT_WHITE"%i. "CT_YELLOW"%s "CT_WHITE"- "CT_GREY"%i "CT_WHITE"ранг\n", string, i + 1, name, rank);
	}
	cache_delete(result);

	Dialog_Open(playerid, Dialog:ListReferals, DSM, "Приглашенные", string, "Далее", "Назад");
	return 1;
}

/*
 * |>-----------------------<|
 * |   Click player in TAB   |
 * |>-----------------------<|
 */

DialogCreate:ClickOnPlayerInTAB(playerid)
{
	new
		playerClicked = GetPVarInt(playerid, "ClickPlayerNameTAB");

	if (!IsPlayerOnServer(playerClicked)) {
		DeletePVar(playerid, "ClickPlayerNameTAB");

		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	new
		strHead[15 + MAX_PLAYER_NAME];

	f(strHead, "%s "T_PID"", GetPlayerNameEx(playerClicked), playerClicked);

	Dialog_Open(playerid, Dialog:ClickOnPlayerInTAB, DSL, strHead,
	""CT_ORANGE""T_NUM" "CT_WHITE"Отправить сообщение\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Сообщить о нарушении\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Добавить в чёрный список",
	"Выбрать", "Выйти");
	return 1;
}

DialogResponse:ClickOnPlayerInTAB(playerid, response, listitem, inputtext[])
{
	if (!response) {
		DeletePVar(playerid, "ClickPlayerNameTAB");
		return 1;
	}

	new
		playerClicked = GetPVarInt(playerid, "ClickPlayerNameTAB");

	if (!IsPlayerOnServer(playerClicked)) {
		DeletePVar(playerid, "ClickPlayerNameTAB");

		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:MessagePlayerInTAB);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:ViolationPlayerInTAB);
		}
		case 2: {
			Dialog_Show(playerid, Dialog:BlackListPlayerInTAB);
		}
	}
	return 1;
}

/*
 * |>-------------------------<|
 * |   Message player in TAB   |
 * |>-------------------------<|
 */

DialogCreate:MessagePlayerInTAB(playerid)
{
	Dialog_Open(playerid, Dialog:MessagePlayerInTAB, DSI, "Отправка сообщения игроку",
	""CT_WHITE"Введите сообщение игроку.",
	"Отправить", "Назад");
	return 1;
}

DialogResponse:MessagePlayerInTAB(playerid, response, listitem, inputtext[])
{
	new
		playerClicked = GetPVarInt(playerid, "ClickPlayerNameTAB");

	if (!response) {
		SetPVarInt(playerid, "ClickPlayerNameTAB", playerClicked);
		Dialog_Show(playerid, Dialog:ClickOnPlayerInTAB);
		return 1;
	}

	if (!IsPlayerOnServer(playerClicked)) {
		DeletePVar(playerid, "ClickPlayerNameTAB");

		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:MessagePlayerInTAB);
		return 1;
	}

	if (strlen(inputtext) > 100) {
		Dialog_Show(playerid, Dialog:MessagePlayerInTAB);
		return 1;
	}

	if (CheckPlayerBlacklists(playerid, playerClicked)) {
		SetPVarInt(playerid, "ClickPlayerNameTAB", playerClicked);
		Dialog_Show(playerid, Dialog:MessagePlayerInTAB);
		return 1;
	}

	SCM(playerClicked, C_GREY, ""T_PM" %s "T_PID": "CT_WHITE"%s", GetPlayerNameEx(playerid), playerid, inputtext);
	SCM(playerid, C_GREY, ""T_PM" Игроку %s "T_PID": "CT_WHITE"%s", GetPlayerNameEx(playerClicked), playerClicked, inputtext);

	PlayerPlaySoundEx(playerClicked, 1138, 0.0, 0.0, 0.0);
	PlayerPlaySoundEx(playerid, 1137, 0.0, 0.0, 0.0);
	DeletePVar(playerid, "ClickPlayerNameTAB");
	return 1;
}

/*
 * |>---------------------------<|
 * |   Violation player in TAB   |
 * |>---------------------------<|
 */

DialogCreate:ViolationPlayerInTAB(playerid)
{
	Dialog_Open(playerid, Dialog:ViolationPlayerInTAB, DSI, "Сообщение о нарушении",
	""CT_WHITE"Расскажите о нарушении игрока.",
	"Отправить", "Назад");
	return 1;
}

DialogResponse:ViolationPlayerInTAB(playerid, response, listitem, inputtext[])
{
	new
		playerClicked = GetPVarInt(playerid, "ClickPlayerNameTAB");

	if (!response) {
		SetPVarInt(playerid, "ClickPlayerNameTAB", playerClicked);
		Dialog_Show(playerid, Dialog:ClickOnPlayerInTAB);
		return 1;
	}

	if (!IsPlayerOnServer(playerClicked)) {
		DeletePVar(playerid, "ClickPlayerNameTAB");

		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	if (!strlen(inputtext)) {
		Dialog_Show(playerid, Dialog:ViolationPlayerInTAB);
		return 1;
	}
	if (strlen(inputtext) > 100) {
		Dialog_Show(playerid, Dialog:ViolationPlayerInTAB);
		return 1;
	}

	SendAdminsMessage(C_CARMINE, "[A]: От игрока %s "T_PID" жалоба на %s "T_PID" Нарушение: %s", GetPlayerNameEx(playerid), playerid, GetPlayerNameEx(playerClicked), playerClicked, inputtext);

	SCM(playerid, C_YELLOW, ""T_INFO" "CT_WHITE"Ваше сообщение успешно отправлено администрации!");
	DeletePVar(playerid, "ClickPlayerNameTAB");
	return 1;
}

/*
 * |>---------------------<|
 * |   Black list in TAB   |
 * |>---------------------<|
 */

DialogCreate:BlackListPlayerInTAB(playerid)
{
	Dialog_Open(playerid, Dialog:BlackListPlayerInTAB, DSM, "Внесение игрока в чёрный список",
	""CT_WHITE"Вы точно хотите отправить игрока в чёрный список?",
	"Да", "Нет");
	return 1;
}

DialogResponse:BlackListPlayerInTAB(playerid, response, listitem, inputtext[])
{
	new
		playerClicked = GetPVarInt(playerid, "ClickPlayerNameTAB");

	if (!response) {
		SetPVarInt(playerid, "ClickPlayerNameTAB", playerClicked);
		Dialog_Show(playerid, Dialog:ClickOnPlayerInTAB);
		return 1;
	}

	if (!IsPlayerOnServer(playerClicked)) {
		DeletePVar(playerid, "ClickPlayerNameTAB");
		
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	new
		check1;
	
	n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
		if (pInfo[playerid][e_Blacklist][i] != GetPlayerMySQLID(playerClicked)) {
			continue;
		}

		check1++;
		break;
	}
	if (check1 > 0) {
		DeletePVar(playerid, "ClickPlayerNameTAB");
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данный игрок уже находится в чёрном списке.");
		return 1;
	}

	new
		check2;
	
	n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
		if (pInfo[playerid][e_Blacklist][i] > -1
		&& pInfo[playerid][e_Blacklist][i] != 0) {
			continue;
		}

		pInfo[playerid][e_Blacklist][i] = GetPlayerMySQLID(playerClicked);
		check2++;
		break;
	}
	if (check2 > 0) {
		SavePlayerBlacklist(playerid);

		SCM(playerid, C_GREY, ""T_BLACKLIST" "CT_WHITE"Игрок успешно добавлен в чёрный список!");
		SCM(playerClicked, C_GREY, ""T_BLACKLIST" "CT_WHITE"Игрок %s "T_PID" добавил Вас в чёрный список!", GetPlayerNameEx(playerid), playerid);
	}
	else {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Достигнут предел чёрного списка. Введите "CT_YELLOW"/blacklist");
	}

	DeletePVar(playerid, "ClickPlayerNameTAB");
	return 1;
}

/*
 * |>-----------------------<|
 * |   Choose player stats   |
 * |>-----------------------<|
 */

DialogCreate:ChoosePlayerStats(playerid)
{
	Dialog_Open(playerid, Dialog:ChoosePlayerStats, DSL, "Статистика",
	""CT_ORANGE""T_NUM" "CT_WHITE"Общая статистика\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Статистика классов",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:ChoosePlayerStats(playerid, response, listitem, inputtext[])
{
	if (!response) {
		if (CheckingPlayerid[playerid] > -1) {
			return CheckingPlayerid[playerid] = -1;
		}

		Dialog_Show(playerid, Dialog:PlayerMenu);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:PlayerStats);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:TDM_ChooseStatsClass);
		}
	}
	return 1;
}

/*
 * |>--------<|
 * |   Help   |
 * |>--------<|
 */

DialogCreate:Help(playerid)
{
	Dialog_Open(playerid, Dialog:Help, DSL, "Помощь",
	""CT_ORANGE""T_NUM" {c21717}Частые вопросы\
	\n"CT_ORANGE""T_NUM" {c21717}Правила сервера\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Информация об сервере\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Режимы и локации\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Команды\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Анимации\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Навыки",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:Help(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:PlayerMenu);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Message(playerid, "Частые вопросы", "\
			"CT_WHITE"Как здесь играть? - Всё просто, в главном меню зайдите во вкладку\"Подключиться\" и далее выберайте режим для игры.\
			\nКак получать EXP и деньги? - Играйте и пробуйте все режимы на сервере.\
			\nЗачем мне EXP и деньги? - Для прокачки персонажа, способностей и т.д.\
			\nДля чего персонажу ранг? - Чем выше ранг, тем больше возможностей доступно.\
			\nСуществуют ли бонусы для новичков? - Да, промо-коды.\
			\nНа сервере продаются админ права? - Нет, не продаются.\
			\nКак изменить пароль? - Перейдите в /menu > Безопасность > Изменить пароль.\
			\nКак создать второй пароль? - Перейдите в /menu > Безопасность > Второй пароль.\
			", "Назад");
		}
		case 1: {
			Dialog_Message(playerid, "Правила сервера", "\
			{1ced3c}Правила игры на сервере:\
			\n"CT_WHITE"1. Запрещается использовать программы, читы, моды и т.д. дающие преимущество в игре.\
			\n2. Запрещается входить в АФК длительное время.\
			\n3. Запрещается любая ускоренная прокачка персонажа.\
			\n4. Запрещается использование ошибок, багов и недоработок мода.\
			\n5. Запрещается использование клавиши <ESC> для спасения персонажа.\
			\n\n{1ced3c}Правила общения:\
			\n"CT_WHITE"1. Запрещается использовать нецензурную лексику, оскорбление в чей-то адрес.\
			\n2. Запрещается дерзкое отношение к игрокам и администрации.\
			\n3. Запрещается рекламировать что-либо.\
			\n4. Запрещается флудить в чате.\
			", "Назад");
		}
		case 2: {
			Dialog_Message(playerid, "Информация об сервере", "\
			"CT_WHITE""SERVER_NAME_CORE" — динамичный и захватывающий игровой сервер.\
			\nНа сервере присутствует множество уникальных режимов.\
			\nОбъедините силы с друзьями, чтобы уничтожить многочисленных противников.\
			\nК примеру, в TDM режиме игроки могут выбрать один из четырех классов, каждый из которых\
			\nобладает своими тактическими возможностями и особенностями: штурмовика, разведчика, и так далее.\
			\n\n{ebc81a}Особенности:\
			\n"CT_WHITE"- Широкие игровые возможности.\
			\n- Качественно проработанный с нуля игровой мод.\
			\n- Множество режимов и бесконечное совершенство.\
			\n"CT_WHITE"Сайт - {ebc81a}"SERVER_SITE"\
			\n"CT_WHITE"Группа ВКонтакте - {ebc81a}"SERVER_VK"\
			", "Назад");
		}
		case 3: {
			Dialog_Show(playerid, Dialog:InfoModes);
		}
		case 4: {
			Dialog_Show(playerid, Dialog:CommandsServer);
		}
		case 5: {
			Dialog_Message(playerid, "Анимации", "\
			"CT_WHITE"Используйте команду /anims для анимации.\
			", "Назад");
		}
		case 6: {
			Dialog_Message(playerid, "Навыки", "\
			"CT_WHITE"Для прокачки разновидных навыков необходимо просто играть.\
			\nВсю информацию можно узнать в процессе игры.\
			", "Назад");
		}
	}
	return 1;
}

/*
 * |>--------------------------<|
 * |   Information game modes   |
 * |>--------------------------<|
 */

DialogCreate:InfoModes(playerid)
{
	Dialog_Open(playerid, Dialog:InfoModes, DSL, "Режимы и локации",
	""CT_ORANGE""T_NUM" "CT_WHITE"Информация\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Режим: TDM\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Режим: DM\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Комната", "Выбрать", "Назад");
	return 1;
}

DialogResponse:InfoModes(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:Help);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Message(playerid, "Информация", "\
			"CT_WHITE"На сервере присутствуют режимы, подрежимы и уникальные локации.\
			\n{ebba1a}Режим "CT_WHITE"- это совокупность элементов игры, которые нужны для победы.\
			\n{ebba1a}Подрежим "CT_WHITE"- это один из элементов режима, имеющий свои определённые качества.\
			\n{ebba1a}Локации "CT_WHITE"- это место где можно взаимодействовать с элементами определённого режима и подрежима.\
			", "Назад");
		}
		case 1: {
			static
				str[2000];

			str[0] = EOS;
			
			str = ""CT_WHITE"Режим TDM является командым. Игрок в любой команде должен сражаться вместе с союзниками.\
			\nДля победы команде необходимо следовать правилам подрежима.\
			\nПри заходе в режим автоматически выбирается команда и имеется возможность выбрать класс персонажа:\
			\nШтурмовик, Медик, Инженер и Разведчик.\
			\nУ каждого класса существуют свои возможности, способности и оружие.\
			\nО правилах подрежима можно узнать при заходе на локацию.\n\nЛокации:\n";

			foreach (new i:Locations[MODE_TDM]) {
				f(str, "%s"CT_GREY"%s: {e8d71c}[%s]\n", str, Mode_GetLocationName(MODE_TDM, i), Mode_GetGameModeName(MODE_TDM, Mode_GetLocationGameMode(MODE_TDM, i)));
			}
			Dialog_Message(playerid, "Режим: TDM", str, "Назад");
		}
		case 2: {
			static
				str[2000];

			str[0] = EOS;
			
			str = ""CT_WHITE"Режим DM является игрой в соло. Игрок должен побеждать других игроков.\
			\nИгроки сражаются между собой до смены локации и дальше по новой.\
			\nИмеются 3 подрежима: нормальный, дигл (+c) и снайпер.\
			\n\nЛокации:\n";

			foreach (new i:Locations[MODE_DM]) {
				f(str, "%s"CT_GREY"%s: {e8d71c}[%s]\n", str, Mode_GetLocationName(MODE_DM, i), Mode_GetGameModeName(MODE_DM, Mode_GetLocationGameMode(MODE_DM, i)));
			}

			Dialog_Message(playerid, "Режим: DM", str, "Назад");
		}
		case 3: {
			Dialog_Message(playerid, "Комната", "\
			"CT_WHITE"Режим комнаты - это то место, где можно по экспериментировать.\
			\nВ данном режиме можно выбрать кол-во играющих игроков, локацию, оружие и т.д.\
			\nСписок локаций можно посмотреть только при выборе локаций.\
			", "Назад");
		}
	}
	return 1;
}

/*
 * |>----------------------------------<|
 * |   List of commands on the server   |
 * |>----------------------------------<|
 */

DialogCreate:CommandsServer(playerid)
{
	static
		strMain[1500];

	strMain[0] = EOS;

	n_for(i, PLAYER_MAX_COMMANDS) {
		f(strMain, "%s"CT_GREY"/%s "CT_WHITE"- %s.\n", strMain, GetPlayerCommandName(i), GetPlayerCommandInfo(i));
	}

	Dialog_Open(playerid, Dialog:CommandsServer, DSM, "Команды", strMain, "Назад", "");
	return 1;
}

DialogResponse:CommandsServer(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:Help);
	return 1;
}

/*
 * |>------------------<|
 * |   Player options   |
 * |>------------------<|
 */

DialogCreate:PlayerOptions(playerid)
{
	new
		str[100];

	f(str, "\
	"CT_ORANGE""T_NUM" "CT_WHITE"Пол\t"CT_YELLOW"[%s]",
	GetPlayerSex(playerid) == SEX_MALE ? "Мужской" : "Женский");

	Dialog_Open(playerid, Dialog:PlayerOptions, DST, "Опции", str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:PlayerOptions(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:PlayerMenu);
		return 1;
	}

	switch (listitem) {
		case 0: {
			if (GetPlayerSex(playerid) == SEX_MALE) {
				SetPlayerSex(playerid, SEX_FEMALE);
			}
			else {
				SetPlayerSex(playerid, SEX_MALE);
			}
			Dialog_Show(playerid, Dialog:PlayerOptions);
		}
	}
	return 1;
}

/*
 * |>----------------<|
 * |   Player stats   |
 * |>----------------<|
 */

DialogCreate:PlayerStats(playerid)
{
	new
		playerShow = playerid;

	if (CheckingPlayerid[playerid] > -1) {
		if (IsPlayerInvalided(CheckingPlayerid[playerid])) {
			playerid = CheckingPlayerid[playerid];
		}
	}

	static
		string[3700];

	string[0] = EOS;

	new
		Float:KD = float(GetPlayerKills(playerid)) / float(GetPlayerDeaths(playerid));

	if (KD <= 0.0) {
		KD = 0.0;
	}

	f(string,
	""CT_GREY"Ник: {fcd060}[%s]\
	\n"CT_GREY"Аккаунт: "CT_WHITE"[№%i]\
	\n"CT_GREY"Ранг: "CT_WHITE"[%i]\
	\n"CT_GREY"Опыт: "CT_WHITE"[%i/%i]\
	\n"CT_GREY"Денег: "CT_WHITE"[$%i]\
	\n"CT_GREY"Gold coin: {e8e85d}[%i]\
	\n"CT_GREY"Пол: "CT_WHITE"[%s]\
	\n"CT_GREY"Премиум: "CT_WHITE"[%s"CT_GREY"]\
	\n"CT_GREY"Времени в игре: "CT_WHITE"[%i часов %i минут]\
	\n\
	\n"CT_GREY"Убийств: "CT_WHITE"[%i]\
	\n"CT_GREY"Смертей: "CT_WHITE"[%i]\
	\n"CT_GREY"K/D: {ffebba}[%.1f]\
	\n"CT_GREY"Победных матчей: "CT_WHITE"[%i]\
	\n"CT_GREY"Проигрышных матчей: "CT_WHITE"[%i]\
	\n"CT_GREY"Выстрелов по врагу: "CT_WHITE"[%i]\
	\n"CT_GREY"Выстрелов в голову: "CT_WHITE"[%i]\
	\n"CT_GREY"Высокая серия убийств: "CT_WHITE"[%i]\
	\n"CT_GREY"Предупреждений: "CT_WHITE"[%i]\
	\n"CT_GREY"Дата регистрации: "CT_WHITE"[%s]\
	\n\
	\n"CT_GREY"[TDM] Выполнено квестов: {e6ae20}[%i/%i]\
	\n"CT_GREY"[DM] Выполнено квестов: {e6ae20}[%i/%i]",
	GetPlayerNameEx(playerid), GetPlayerMySQLID(playerid), GetPlayerRank(playerid), GetPlayerExp(playerid),
	CheckPlayerNextRank(playerid), GetPlayerMoneyEx(playerid), pInfo[playerid][e_GoldCoins],
	GetPlayerSex(playerid) == SEX_MALE ? "мужской" : "женский", 
	GetPlayerPremium(playerid) != PREMIUM_LEVEL_NONE ? "{69CA21}Да" : ""CT_RED"Нет",
	pInfo[playerid][e_PlayedHours], pInfo[playerid][e_PlayedMinutes],
	GetPlayerKills(playerid), GetPlayerDeaths(playerid), KD, GetPlayerWinningMatchs(playerid), GetPlayerLosingMatchs(playerid),
	GetPlayerShotsEnemy(playerid), GetPlayerShotsHead(playerid), GetPlayerSeriesKills(playerid),
	pInfo[playerid][e_Warns], ShowDatetimeForPlayer(playerid, pInfo[playerid][e_RegDatetime]),
	CheckPlayerQuestPassedCount(playerid, MODE_TDM), Mode_GetMaxQuests(MODE_TDM),
	CheckPlayerQuestPassedCount(playerid, MODE_DM), Mode_GetMaxQuests(MODE_DM));
	
	Dialog_Open(playerShow, Dialog:PlayerStats, DSM, "Общая статистика", string, "Назад", "");
	return 1;
}

DialogResponse:PlayerStats(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:ChoosePlayerStats);
	return 1;
}

/*
 * |>---------------<|
 * |   Menu server   |
 * |>---------------<|
 */

DialogCreate:PlayerMenu(playerid)
{
	Dialog_Open(playerid, Dialog:PlayerMenu, DSL, "Меню сервера",
	""CT_ORANGE""T_NUM" "CT_WHITE"Статистика\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Помощь\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Донат\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Опции\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Безопасность\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Топ игроков\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Промо-код\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Правила игры", "Выбрать", "Выйти");
	return 1;
}

DialogResponse:PlayerMenu(playerid, response, listitem, inputtext[])
{
	if (response) {
		switch (listitem) {
			case 0: {
				Dialog_Show(playerid, Dialog:ChoosePlayerStats);
			}
			case 1: {
				Dialog_Show(playerid, Dialog:Help);
			}
			case 2: {
				Dialog_Show(playerid, Dialog:Donate);
			}
			case 3: {
				Dialog_Show(playerid, Dialog:PlayerOptions);
			}
			case 4: {
				Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
			}
			case 5: {
				Dialog_Show(playerid, Dialog:SelectTopPlayers);
			}
			case 6: {
				if (GetPlayerRank(playerid) < LIMIT_RANK_PROMOCODE) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Для активации промо-кода требуется %i ранг!", LIMIT_RANK_PROMOCODE);

					Dialog_Show(playerid, Dialog:PlayerMenu);
					return 1;
				}
				if (strcmp(GetPlayerPromoCode(playerid), DB_STRING_VALUE_NO, true)) {
					SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Вы уже активировали промо-код!");

					Dialog_Show(playerid, Dialog:PlayerMenu);
					return 1;
				}
				Dialog_Show(playerid, Dialog:UsePlayerPromoCode);
			}
			case 7: {
				Dialog_Show(playerid, Dialog:ServerRules);
			}
		}
	}
	return 1;
}

/*
 * |>-------------------<|
 * |   Player security   |
 * |>-------------------<|
 */

DialogCreate:PlayerChangeSecurity(playerid)
{
	new
		string[150];

	f(string, "\
	"CT_ORANGE""T_NUM" "CT_WHITE"Изменить пароль\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Второй пароль\t[%s"CT_WHITE"]", strcmp(GetPlayerSecondPassword(playerid), DB_STRING_VALUE_NO, true) ? "{69CA21}Вкл" : ""CT_RED"Выкл");
	Dialog_Open(playerid, Dialog:PlayerChangeSecurity, DST, "Безопасность", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:PlayerChangeSecurity(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:PlayerMenu);
		return 1;
	}

	switch (listitem) {
		case 0: {
			SetErrorText(playerid, "");
			Dialog_Show(playerid, Dialog:ChangePassword);
		}
		case 1: {
			if (Mode_GetPlayerMode(playerid) != MODE_NONE
			|| Interface_IsOpen(playerid, Interface:SecondPassword)) {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Данную функцию можно изменить только в главном меню.");
				Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
				return 1;
			}
			Dialog_Show(playerid, Dialog:SecondPassword);
		}
	}
	return 1;
}

/*
 * |>----------<|
 * |   Donate   |
 * |>----------<|
 */

DialogCreate:Donate(playerid)
{
	new
		strHead[21 - 2 + MAX_LENGTH_NUM + 1];

	f(strHead, "На счету %i GoldCoins", GetPlayerGoldCoins(playerid));

	Dialog_Open(playerid, Dialog:Donate, DSL, strHead,
	""CT_ORANGE""T_NUM" "CT_WHITE"Игровая валюта\t{19b529}[50 GoldCoins > $10.000]\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Премиум аккаунт\t{19b529}[250 GoldCoins]",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:Donate(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:PlayerMenu);
		return 1;
	}

	switch (listitem) {
		case 0: {
			if (GetPlayerGoldCoins(playerid) < 50) {
				SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Необходимо иметь 50 GoldCoins!");
				Dialog_Show(playerid, Dialog:Donate);
				return 1;
			}

			GivePlayerGoldCoins(playerid, -50);
			GivePlayerMoneyEx(playerid, 10000);

			SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_GOLD_COINS"` = '%i', `"DB_ACCOUNTS_MONEY"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerMoneyEx(playerid), GetPlayerGoldCoins(playerid), GetPlayerMySQLID(playerid));

			SCM(playerid, C_GREEN, ""T_REPLEN" "CT_WHITE"$10.000 успешно приобретены!");
			Dialog_Show(playerid, Dialog:Donate);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:BuyPremium);
		}
	}
	return 1;
}

/*
 * |>-----------------------------<|
 * |   Select top players server   |
 * |>-----------------------------<|
 */

DialogCreate:SelectTopPlayers(playerid)
{
	Dialog_Open(playerid, Dialog:SelectTopPlayers, DSL, "Топ игроков",
	""CT_ORANGE""T_NUM" "CT_WHITE"Топ по убийствам\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Топ по деньгам",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:SelectTopPlayers(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:PlayerMenu);
		return 1;
	}

	switch (listitem) {
		case 0: {
			Dialog_Show(playerid, Dialog:TopKillsPlayers);
		}
		case 1: {
			Dialog_Show(playerid, Dialog:TopMoneyPlayers);
		}
	}
	return 1;
}

/*
 * |>---------------------<|
 * |   Top players kills   |
 * |>---------------------<|
 */

DialogCreate:TopKillsPlayers(playerid)
{
	new
		query[100];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ACCOUNTS"` ORDER BY `"DB_ACCOUNTS_KILLS"` DESC LIMIT 10");
	mysql_query(MySQLID, query, true);

	static
		str[1000];

	if (cache_num_rows()) {
		n_for(i, cache_num_rows()) {
			new
				name[MAX_PLAYER_NAME], 
				kills;

			cache_get_value_name(i, DB_ACCOUNTS_NICKNAME, name, MAX_PLAYER_NAME);
			cache_get_value_name_int(i, DB_ACCOUNTS_KILLS, kills);

			f(str, "%s"CT_WHITE"%i. "CT_GREY"%s: {c71212}[%i]\n", str, i + 1, name, kills);
		}
	}
	else
		str = ""CT_WHITE"Игроков не найдено";

	Dialog_Open(playerid, Dialog:TopKillsPlayers, DSM, "Топ 10 игроков по убийствам", str, "Назад", "");
	return 1;
}

DialogResponse:TopKillsPlayers(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:SelectTopPlayers);
	return 1;
}

/*
 * |>---------------------<|
 * |   Top players money   |
 * |>---------------------<|
 */

DialogCreate:TopMoneyPlayers(playerid)
{
	new
		query[100];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ACCOUNTS"` ORDER BY `"DB_ACCOUNTS_MONEY"` DESC LIMIT 10");
	mysql_query(MySQLID, query, true);

	static
		str[1000];

	if (cache_num_rows()) {
		n_for(i, cache_num_rows()) {
			new
				name[MAX_PLAYER_NAME],
				money;

			cache_get_value_name(i, DB_ACCOUNTS_NICKNAME, name, MAX_PLAYER_NAME);
			cache_get_value_name_int(i, DB_ACCOUNTS_MONEY, money);

			f(str, "%s"CT_WHITE"%i. "CT_GREY"%s: {12c724}[$%i]\n", str, i + 1, name, money);
		}
	}
	else {
		str = ""CT_WHITE"Игроков не найдено";
	}

	Dialog_Open(playerid, Dialog:TopMoneyPlayers, DSM, "Топ 10 игроков по деньгам", str, "Назад", "");
	return 1;
}

DialogResponse:TopMoneyPlayers(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:SelectTopPlayers);
	return 1;
}

/*
 * |>----------------<|
 * |   Server rules   |
 * |>----------------<|
 */

DialogCreate:ServerRules(playerid)
{
	if (GetPlayerLogged(playerid)) {
		Dialog_Open(playerid, Dialog:ServerRules, DSM, "{ff6d00}[1/5] Правила сервера", "\
		{1ced3c}Правила игры на сервере:\
		\n{d4d4d4}1. Запрещается использовать программы, читы, моды и т.д. дающие преимущество в игре.\
		\n2. Запрещается входить в АФК длительное время.\
		\n3. Запрещается любая ускоренная прокачка персонажа.\
		\n4. Запрещается использование ошибок, багов и недоработок мода.\
		\n5. Запрещается использование клавиши <ESC> для спасения персонажа.\
		\n\n{1ced3c}Правила общения:\
		\n{d4d4d4}1. Запрещается использовать нецензурную лексику, оскорбление в чей-то адрес.\
		\n2. Запрещается дерзкое отношение к игрокам и администрации.\
		\n3. Запрещается рекламировать что-либо.\
		\n4. Запрещается флудить в чате.\
		", "Согласен", "Выйти");
	}
	else {
		Dialog_Open(playerid, Dialog:ServerRules, DSM, "Правила сервера", "\
		{1ced3c}Правила игры на сервере:\
		\n{d4d4d4}1. Запрещается использовать программы, читы, моды и т.д. дающие преимущество в игре.\
		\n2. Запрещается входить в АФК длительное время.\
		\n3. Запрещается любая ускоренная прокачка персонажа.\
		\n4. Запрещается использование ошибок, багов и недоработок мода.\
		\n5. Запрещается использование клавиши <ESC> для спасения персонажа.\
		\n\n{1ced3c}Правила общения:\
		\n{d4d4d4}1. Запрещается использовать нецензурную лексику, оскорбление в чей-то адрес.\
		\n2. Запрещается дерзкое отношение к игрокам и администрации.\
		\n3. Запрещается рекламировать что-либо.\
		\n4. Запрещается флудить в чате.\
		", "Понятно", "");
	}
	return 1;
}

DialogResponse:ServerRules(playerid, response, listitem, inputtext[])
{
	if (GetPlayerLogged(playerid)) {
		if (response) {
			SetErrorText(playerid, "");
			Dialog_Show(playerid, Dialog:InputPassword);

			CheckPlayerDinaHint(playerid, 1);
		}
		else {
			return KickPlayerEx(playerid);
		}
	}
	else {
		Dialog_Show(playerid, Dialog:PlayerMenu);
	}
	return 1;
}

/*
 * |>--------------<|
 * |   Select sex   |
 * |>--------------<|
 */

DialogCreate:SelectSex(playerid)
{
	Dialog_Open(playerid, Dialog:SelectSex, DSM, "{ff6d00}[3/5] Выбор пола",
	"\n{d4d4d4}Пожалуйста, выберите свой будущий {d16b17}пол{d4d4d4}.\n ",
	"Мужской", "Женский");
	return 1;
}

DialogResponse:SelectSex(playerid, response, listitem, inputtext[])
{
	if (response) {
		SetPlayerSex(playerid, SEX_MALE);
	}
	else {
		SetPlayerSex(playerid, SEX_FEMALE);
	}

	Dialog_Show(playerid, Dialog:SelectFoundServer);

	KillPlayerLoggedTimer(playerid);
	SetPlayerLoggedTimer(playerid, 60000);
	return 1;
}

/*
 * |>-----------------------<|
 * |   Select found server   |
 * |>-----------------------<|
 */

DialogCreate:SelectFoundServer(playerid)
{
	Dialog_Open(playerid, Dialog:SelectFoundServer, DSL, "{ff6d00}[4/5] Где Вы узнали о сервере?",
	""CT_ORANGE""T_NUM" "CT_WHITE"Вкладка\"Hosted\"\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"В соц. сетях\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"На порталах/форумах\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"В поисковике\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"На YouTube\
	\n"CT_ORANGE""T_NUM" "CT_WHITE"Другое...", "Выбрать", "Выйти");
	return 1;
}

DialogResponse:SelectFoundServer(playerid, response, listitem, inputtext[])
{
	if (!response) {
		KickPlayerEx(playerid);
		return 1;
	}

	pInfo[playerid][e_FoundServer] = listitem + 1;

	SetErrorText(playerid, "");
	Dialog_Show(playerid, Dialog:InputNicknameReferal);

	CheckPlayerDinaHint(playerid, 2);

	KillPlayerLoggedTimer(playerid);
	SetPlayerLoggedTimer(playerid, 60000);
	return 1;
}

/*
 * |>-------------------<|
 * |   Change password   |
 * |>-------------------<|
 */

DialogCreate:ChangePassword(playerid)
{
	new
		string[500],
		textError[100];

	GetPVarString(playerid, "ErrorTextString", textError, sizeof(textError));
	DeletePVar(playerid, "ErrorTextString");

	f(string, "\
	"CT_RED"Информация:\
	\n\n"CT_WHITE"Вы изменяете пароль от аккаунта на сервере {33FF00}"SERVER_NAME"\
	\n\n"CT_WHITE"Придумайте новый пароль для изменение пароля от аккаунта.\
	\n\n"CT_RED"Примечание:\
	\n"CT_GREY"1. Пароль чувствителен к регистру.\
	\n2. Пароль должен содержать от 4 до 25 символов.\
	\n3. Пароль должен содержать только латинские символы и цифры.\
	\n\n"CT_RED"%s", textError);
	Dialog_Open(playerid, Dialog:ChangePassword, DSI, "Изменение пароля от аккаунта", string, "Ввод", "Назад");
	return 1;
}

DialogResponse:ChangePassword(playerid, response, listitem, inputtext[])
{
	if (!response) {
		Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
		return 1;
	}

	if (!strlen(inputtext)) {
		SetErrorText(playerid, "");
		Dialog_Show(playerid, Dialog:ChangePassword);
		return 1;
	}
	
	for (new i = strlen(inputtext)-1; i != -1; i--) {
		switch (inputtext[i]) {
			case '0'..'9', 'a'..'z','A'..'Z': {
				continue;
			}
			default: {
				SetErrorText(playerid, 
				"Ошибка: пароль должен содержать латинские символы и цифры!");

				Dialog_Show(playerid, Dialog:ChangePassword);
				return 1;
			}
		}
	}

	if (strlen(inputtext) < 4) {
		SetErrorText(playerid, "Ошибка: пароль слишком короткий!");
		Dialog_Show(playerid, Dialog:ChangePassword);
		return 1;
	}

	else if (strlen(inputtext) > 25) {
		SetErrorText(playerid, "Ошибка: пароль слишком длинный!");
		Dialog_Show(playerid, Dialog:ChangePassword);
		return 1;
	}

	bcrypt_hash(inputtext, BCRYPT_COST, "MySQLSetPlayerPassword", "i", playerid);
	return 1;
}

/*
 * |>--------------------------<|
 * |   Input nickname referal   |
 * |>--------------------------<|
 */

DialogCreate:InputNicknameReferal(playerid)
{
	new
		string[300],
		textError[100];

	GetPVarString(playerid, "ErrorTextString", textError, sizeof(textError));
	DeletePVar(playerid, "ErrorTextString");

	KillPlayerLoggedTimer(playerid);
	SetPlayerLoggedTimer(playerid, 60000);

	f(string, "\
	{d4d4d4}Если вас кто-то {d16b17}пригласил{d4d4d4}, то введите его ник сюда.\
	\nПример: {9e9e9e}Foxze\
	\n\n{d4d4d4}* Когда Вы достигните {d16b17}15 ранга{d4d4d4}, ему будет выдано вознаграждение!\
	\n\n"CT_RED"%s", textError);

	Dialog_Open(playerid, Dialog:InputNicknameReferal, DSI, "{ff6d00}[5/5] Кто вас пригласил?", string, "Выбрать", "Пропустить");
	return 1;
}

DialogResponse:InputNicknameReferal(playerid, response, listitem, inputtext[])
{
	if (!response) {
		KillPlayerLoggedTimer(playerid);
		SetPlayerReferal(playerid, DB_STRING_VALUE_NO);

		MySQLCreateNewAccount(playerid);
		return 1;
	}

	if (!strlen(inputtext)) {
		SetErrorText(playerid, "");
		Dialog_Show(playerid, Dialog:InputNicknameReferal);
		return 1;
	}

	if (!strcmp(GetPlayerNameEx(playerid), inputtext, true)) {
		SetErrorText(playerid, "Ошибка: собственный ник запрещён!");
		Dialog_Show(playerid, Dialog:InputNicknameReferal);
		return 1;
	}

	new
		query[39 - 2 + DB_MAX_LENGTH_TABLE_NAME + DB_MAX_LENGTH_FIELD_NAME + MAX_PLAYER_NAME + 1];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ACCOUNTS"` WHERE BINARY `"DB_ACCOUNTS_NICKNAME"` = '%s'", inputtext);
	mysql_tquery(MySQLID, query, "MySQLCheckRegisterReferal", "is", playerid, inputtext);
	return 1;
}

/*
 * |>------------------<|
 * |   Buy adnimation   |
 * |>------------------<|
 */

DialogCreate:BuyAnimations(playerid)
{
	static
		string[2000];

	string[0] = EOS;

	strcat(string, "Название\tЦена\n");

	n_for(i, MAX_PLAYER_ANIMATIONS) {
		if (!pInfo[playerid][e_Animations][i]) {
			f(string, "%s"CT_ORANGE""T_NUM" "CT_WHITE"%s\t{1ad943}[$%i]\n", string, AnimInfo[i][e_Name], AnimInfo[i][e_Price]);
		}
		else {
			f(string, "%s"CT_ORANGE""T_NUM" "CT_WHITE"%s\t\n", string, AnimInfo[i][e_Name], AnimInfo[i][e_Price]);
		}
	}
	Dialog_Open(playerid, Dialog:BuyAnimations, DSTH, "{1ad9c9}Покупка анимации", string, "Выбрать", "Выйти");
	return 1;
}

DialogResponse:BuyAnimations(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	if (!pInfo[playerid][e_Animations][listitem]) {
		if (GetPlayerMoneyEx(playerid) < AnimInfo[listitem][e_Price]) {
			Dialog_Show(playerid, Dialog:BuyAnimations);

			SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Недостаточно денег!");
			return 1;
		}
		else {
			GivePlayerMoneyEx(playerid, -AnimInfo[listitem][e_Price]);
			pInfo[playerid][e_Animations][listitem] = 1;

			SavePlayerAnimations(playerid);

			SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Анимация успешно приобретена!");
		}
	}
	if (!GetSpecPl(playerid)) {
		SetPlayerAnimation(playerid, listitem);
	}
	return 1;
}

/*
 * |>-------------------<|
 * |   List animations   |
 * |>-------------------<|
 */

DialogCreate:ListAnimations(playerid)
{
	static
		string[1500];

	string[0] = EOS;
	
	new
		num = 0;

	n_for(i, MAX_PLAYER_ANIMATIONS) {
		if (pInfo[playerid][e_Animations][i]) {
			DialogListAnims[playerid][num] = i;
			num++;
		}
	}

	n_for(i, num)
		f(string, "%s"CT_ORANGE""T_NUM" "CT_WHITE"%s\n", string, AnimInfo[DialogListAnims[playerid][i]][e_Name]);
	
	if (num != 0) {
		strcat(string, "\n"CT_ORANGE""T_NUM" {5acc1d}Приобрести анимацию");
	}
	else {
		strcat(string, ""CT_ORANGE""T_NUM" {5acc1d}Приобрести анимацию");
	}

	Dialog_Open(playerid, Dialog:ListAnimations, DSL, "{1ad9c9}Анимации", string, "Выбрать", "Выйти");
	return 1;
}

DialogResponse:ListAnimations(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	new
		num = 0;

	n_for(i, MAX_PLAYER_ANIMATIONS) {
		if (DialogListAnims[playerid][i] != -1)
			num++;
	}

	if (num != 0) {
		num++;
	}

	if (num != 0) {
		if (listitem == num - 1) {
			Dialog_Show(playerid, Dialog:ListAnimations);
			return 1;
		}
	}

	if (listitem == num) {
		Dialog_Show(playerid, Dialog:BuyAnimations);
	}
	else {
		SetPlayerAnimation(playerid, DialogListAnims[playerid][listitem]);
	}

	n_for(i, MAX_PLAYER_ANIMATIONS) {
		DialogListAnims[playerid][i] = -1;
	}
	return 1;
}

/*
 * |>----------------------<|
 * |   Black list players   |
 * |>----------------------<|
 */

DialogCreate:BlackListPlayers(playerid)
{
	new
		check;

	n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
		if (pInfo[playerid][e_Blacklist][i] == -1 || pInfo[playerid][e_Blacklist][i] == 0) {
			continue;
		}

		check++;
	}

	if (check == 0) {
		SCM(playerid, C_GREY, ""T_BLACKLIST" "CT_WHITE"Чёрный список пуст.");

		ListBlackListCount[playerid] = 0;

		n_for(i, 10)
			ListBlacklist[playerid][i] = -1;

		ClosePlayerDialog(playerid);
		return 1;
	}

	n_for(i, 10)
		ListBlacklist[playerid][i] = -1;
	
	static
		str[1000];

	str[0] = EOS;
	
	new
		list = 0;

	for (new i = ListBlackListCount[playerid], num = ListBlackListCount[playerid] + 1; i < 10; i++) {
		if (pInfo[playerid][e_Blacklist][i] == -1 || pInfo[playerid][e_Blacklist][i] == 0) {
			continue;
		}

		new
			query[150], 
			name[MAX_PLAYER_NAME];

		mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ACCOUNTS"` WHERE `"DB_ACCOUNTS_ID"` = '%i' LIMIT 1", pInfo[playerid][e_Blacklist][i]);
		mysql_query(MySQLID, query, true);

		cache_get_value_name(0, DB_ACCOUNTS_NICKNAME, name, MAX_PLAYER_NAME);

		f(str, "%s"CT_ORANGE""T_NUM"%i. "CT_WHITE"%s\n", str, num, name);

		ListBlacklist[playerid][num - 1] = i;
		list++;
		num++;
	}
	if (list >= 10) {
		if (check > ListBlackListCount[playerid] + 10) {
			strcat(str, "Далее >>");
		}
	}
	Dialog_Open(playerid, Dialog:BlackListPlayers, DSL, "Чёрный список", str, "Удалить", "Выйти");
	return 1;
}

DialogResponse:BlackListPlayers(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	n_for(i, 10) {
		if (listitem == i) {
			pInfo[playerid][e_Blacklist][ListBlacklist[playerid][i]] = -1;
			SavePlayerBlacklist(playerid);

			SCM(playerid, C_GREY, ""T_BLACKLIST" "CT_WHITE"Игрок успешно убран из чёрного списка.");
			ListBlackListCount[playerid] = 0;
			Dialog_Show(playerid, Dialog:BlackListPlayers);
			break;
		}
	}
	if (listitem == 10) {
		ListBlackListCount[playerid] += 10;
		Dialog_Show(playerid, Dialog:BlackListPlayers);
	}
	return 1;
}

/*
 * |>------------------<|
 * |   Input password   |
 * |>------------------<|
 */

DialogCreate:InputPassword(playerid)
{
	new
		string[600],
		textError[100];

	GetPVarString(playerid, "ErrorTextString", textError, sizeof(textError));
	DeletePVar(playerid, "ErrorTextString");

	f(string, "\
	{d4d4d4}Игровой ник: {FF9900}%s\
	\n{d4d4d4}Данный аккаунт {e03f3f}не зарегистрирован {d4d4d4}на сервере.\
	\n\n{d4d4d4}Придумайте и введите пароль для регистрации нового персонажа:\
	\n\n{d93636}Примечание:\
	\n{9e9e9e}1) Пароль чувствителен к регистру.\
	\n2) Пароль должен содержать от 4 до 25 символов.\
	\n3) Пароль должен содержать только латинские символы и цифры.\
	\n\n{4ecc47}* У Вас есть 2 минуты на создание пароля!\
	\n\n"CT_RED"%s", GetPlayerNameEx(playerid), textError);

	Dialog_Open(playerid, Dialog:InputPassword, DSI, "{ff6d00}[2/5] Создание пароля", string, "Ввод", "Выйти");
	return 1;
}

DialogResponse:InputPassword(playerid, response, listitem, inputtext[])
{
	if (!response) {
		KickPlayerEx(playerid);
		return 1;
	}

	if (!strlen(inputtext)) {
		SetErrorText(playerid, "");
		Dialog_Show(playerid, Dialog:InputPassword);
		return 1;
	}

	for (new i = strlen(inputtext)-1; i != -1; i--) {
		switch (inputtext[i]) {
			case '0'..'9', 'a'..'z','A'..'Z': {
				continue;
			}
			default: {
				SetErrorText(playerid, 
				"Ошибка: пароль должен содержать латинские символы и цифры!");

				Dialog_Show(playerid, Dialog:InputPassword);
				return 1;
			}
		}
	}

	if (strlen(inputtext) < 4) {
		SetErrorText(playerid, "Ошибка: пароль слишком короткий!");
		Dialog_Show(playerid, Dialog:InputPassword);
		return 1;
	}

	else if (strlen(inputtext) > 25) {
		SetErrorText(playerid, "Ошибка: пароль слишком длинный!");
		Dialog_Show(playerid, Dialog:InputPassword);
		return 1;
	}

	bcrypt_hash(inputtext, BCRYPT_COST, "MySQLSetPlayerPassword", "i", playerid);
	return 1;
}

/*
 * |>-------------------<|
 * |   Repeat password   |
 * |>-------------------<|
 */

DialogCreate:RepeatPassword(playerid)
{
	new
		string[150],
		textError[100];

	GetPVarString(playerid, "ErrorTextString", textError, sizeof(textError));
	DeletePVar(playerid, "ErrorTextString");

	f(string, "\
	"CT_WHITE"Повторите пароль:\
	\n\n{006633}У Вас есть 120 секунд для регистрации.\
	\n\n"CT_RED"%s", textError);

	Dialog_Open(playerid, Dialog:RepeatPassword, DSP, "Повторение пароля", string, "Ввод", "Назад");
	return 1;
}

DialogResponse:RepeatPassword(playerid, response, listitem, inputtext[])
{
	if (!response) {
		return 1;
	}

	if (!strlen(inputtext)) {
		SetErrorText(playerid, "");
		Dialog_Show(playerid, Dialog:RepeatPassword);
		return 1;
	}

	if (strcmp(inputtext, pInfo[playerid][e_Password], true)) {
		SetErrorText(playerid, "Ошибка: пароли не совпадают!");
		Dialog_Show(playerid, Dialog:RepeatPassword);

		if (GetPVarInt(playerid, "PasswordRepeat") == 2)
			SetPVarInt(playerid, "PasswordRepeat", 1);

		return 1;
	}

	SetPVarInt(playerid, "PasswordRepeat", 2);
	return 1;
}

/*
 * |>----------------<|
 * |   Login player   |
 * |>----------------<|
 */

DialogCreate:Login(playerid)
{
	new
		string[350],
		textError[100];

	GetPVarString(playerid, "ErrorTextString", textError, sizeof(textError));
	DeletePVar(playerid, "ErrorTextString");

	f(string, "\
	{d4d4d4}Игровой ник: {FF9900}%s\
	\n{d4d4d4}Данный аккаунт {3399FF}зарегистрирован {d4d4d4}на сервере.\
	\n\n{d4d4d4}Введите пароль ниже:\
	\n\n{4ecc47}* У Вас есть 2 минуты на авторизацию!\
	\n\n"CT_RED"%s",
	GetPlayerNameEx(playerid), textError);
	
	Dialog_Open(playerid, Dialog:Login, DSP, "{ff6d00}Авторизация", string, "Ввод", "Выйти");
	return 1;
}

DialogResponse:Login(playerid, response, listitem, inputtext[])
{
	if (!response) {
		KickPlayerEx(playerid);
		return 1;
	}

	if (!strlen(inputtext)) {
		SetErrorText(playerid, "");
		Dialog_Show(playerid, Dialog:Login);
		return 1;
	}

	bcrypt_check(inputtext, pInfo[playerid][e_Password], "MySQLCheckPlayerPassword", "i", playerid);
	return 1;
}

/*
 * |>-------------<|
 * |     MySQL     |
 * |>-------------<|
 */

static MySQLInitialPlayerData(playerid)
{
	new
		currentDatetime[MAX_LENGTH_DATETIME];

	strcopy(currentDatetime, GetCurrentDatetime(), MAX_LENGTH_DATETIME);

	// IP
	GetPlayerIp(playerid, pInfo[playerid][e_RegIP], MAX_LENGTH_IP);
	GetPlayerIp(playerid, pInfo[playerid][e_LastIP], MAX_LENGTH_IP);

	// Datetime
	SetPlayerRegDatetime(playerid, currentDatetime);
	SetPlayerLastDatetime(playerid, currentDatetime);

	// Rank
	pInfo[playerid][e_Rank] = PLAYER_INITIAL_RANK;
	SetPlayerScore(playerid, PLAYER_INITIAL_RANK);

	// Money
	pInfo[playerid][e_Money] = PLAYER_INITIAL_MONEY;
	GivePlayerMoney(playerid, PLAYER_INITIAL_MONEY);

	// Daily bonus
	GivePlayerDailyBonusDays(playerid, 1);
	SetPlayerDailyBonusDatetime(playerid, currentDatetime);

	InitialPlayerInventory(playerid);
	return 1;
}

static MySQLCreateNewAccount(playerid)
{
	MySQLInitialPlayerData(playerid);

	static
		strFormat[6000],
		strData[1000],
		strData2[500];

	strFormat[0] =
	strData[0] =
	strData2[0] = EOS;

	f(strFormat, "\
	INSERT INTO \
	`"DB_ACCOUNTS"` \
	(\
	`"DB_ACCOUNTS_NICKNAME"`,\
	`"DB_ACCOUNTS_PASSWORD"`,\
	`"DB_ACCOUNTS_REFERAL"`,\
	`"DB_ACCOUNTS_FOUND_SERVER"`,\
	`"DB_ACCOUNTS_SEX"`,\
	`"DB_ACCOUNTS_RANK"`,\
	`"DB_ACCOUNTS_MONEY"`,\
	`"DB_ACCOUNTS_DBONUS_DAYS"`,\
	`"DB_ACCOUNTS_DBONUS_DATETIME"`,\
	`"DB_ACCOUNTS_INV_USES_ITEMS"`,\
	`"DB_ACCOUNTS_INV_ITEMS"`,\
	`"DB_ACCOUNTS_INV_ITEMS_COUNT"`,\
	`"DB_ACCOUNTS_INV_BANNERS"`,\
	`"DB_ACCOUNTS_INV_BANNERS_COUNT"`,\
	`"DB_ACCOUNTS_ANIMATIONS"`,\
	`"DB_ACCOUNTS_BLACKLIST"`,\
	`"DB_ACCOUNTS_HELPER_DINA"`,\
	`"DB_ACCOUNTS_REG_IP"`,\
	`"DB_ACCOUNTS_LAST_IP"`,\
	`"DB_ACCOUNTS_REG_DATETIME"`,\
	`"DB_ACCOUNTS_LAST_DATETIME"`\
	) \
	VALUES ");

	strcat(strFormat, "(");

	// DB_ACCOUNTS_NICKNAME
	f(strData, "'%s',", GetPlayerNameEx(playerid));
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_ACCOUNTS_PASSWORD
	f(strData, "'%s',", GetPlayerPassword(playerid));
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_ACCOUNTS_REFERAL
	f(strData, "'%s',", pInfo[playerid][e_Referal]);
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_ACCOUNTS_FOUND_SERVER
	f(strData, "'%i',", pInfo[playerid][e_FoundServer]);
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_ACCOUNTS_SEX
	f(strData, "'%i',", GetPlayerSex(playerid));
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_ACCOUNTS_RANK
	f(strData, "'%i',", GetPlayerRank(playerid));
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_ACCOUNTS_MONEY
	f(strData, "'%i',", GetPlayerMoneyEx(playerid));
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_ACCOUNTS_DBONUS_DAYS
	f(strData, "'%i',", GetPlayerDailyBonusDays(playerid));
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_ACCOUNTS_DBONUS_DATETIME
	f(strData, "'%s',", GetPlayerDailyBonusDatetime(playerid));
	strcat(strFormat, strData);

	strData[0] = EOS;

	// DB_ACCOUNTS_INV_USES_ITEMS
	f(strData2, "%i,", GetPlayerInvStandSkin(playerid));
	f(strData2, "%s%i,", strData2, GetPlayerInvSkin(playerid));
	f(strData2, "%s%i,", strData2, GetPlayerInvHead(playerid));
	f(strData2, "%s%i,", strData2, GetPlayerInvHeadphones(playerid));
	f(strData2, "%s%i,", strData2, GetPlayerInvGlasses(playerid));
	f(strData2, "%s%i,", strData2, GetPlayerInvMask(playerid));
	f(strData2, "%s%i,", strData2, GetPlayerInvWatch(playerid));
	f(strData2, "%s%i,", strData2, GetPlayerInvBanner(playerid));
	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_ACCOUNTS_INV_ITEMS
	n_for(i, INV_PLAYER_MAX_ITEMS) {
		f(strData2, "%s%i,", strData2, GetPlayerInvCellItem(playerid, i));
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_ACCOUNTS_INV_ITEMS_COUNT
	n_for(i, INV_PLAYER_MAX_ITEMS) {
		f(strData2, "%s%i,", strData2, GetPlayerInvCellItemCount(playerid, i));
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_ACCOUNTS_INV_BANNERS
	n_for(i, INV_PLAYER_MAX_BANNERS) {
		f(strData2, "%s%i,", strData2, GetPlayerInvCellBanner(playerid, i));
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_ACCOUNTS_INV_BANNERS_COUNT
	n_for(i, INV_PLAYER_MAX_BANNERS) {
		f(strData2, "%s%i,", strData2, GetPlayerInvCellBannerCount(playerid, i));
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_ACCOUNTS_ANIMATIONS
	n_for(i, MAX_PLAYER_ANIMATIONS) {
		f(strData2, "%s%i,", strData2, pInfo[playerid][e_Animations][i]);
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_ACCOUNTS_BLACKLIST
	n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
		strcat(strData2, "-1,");
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_ACCOUNTS_HELPER_DINA
	n_for(i, DINA_MAX_HINTS) {
		f(strData2, "%s%i,", strData2, GetPlayerDinaHint(playerid, i));
	}

	f(strData, "'%s',", strData2);
	strcat(strFormat, strData);

	strData[0] =
	strData2[0] = EOS;

	// DB_ACCOUNTS_REG_IP
	f(strData, "'%s',", pInfo[playerid][e_RegIP]);
	strcat(strFormat, strData);
	
	strData[0] = EOS;
	
	// DB_ACCOUNTS_LAST_IP
	f(strData, "'%s',", pInfo[playerid][e_LastIP]);
	strcat(strFormat, strData);
	
	strData[0] = EOS;

	// DB_ACCOUNTS_REG_DATETIME
	f(strData, "'%s',", pInfo[playerid][e_RegDatetime]);
	strcat(strFormat, strData);

	strData[0] = EOS;
	
	// DB_ACCOUNTS_LAST_DATETIME
	f(strData, "'%s'", pInfo[playerid][e_LastDatetime]);
	strcat(strFormat, strData);

	strData[0] = EOS;

	strcat(strFormat, ")");

	mysql_tquery(MySQLID, strFormat, "MySQLCreateAccountBackpack", "i", playerid);

	SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Аккаунт "CT_ORANGE"%s "CT_WHITE"успешно зарегистрирован на сервере!", GetPlayerNameEx(playerid));
	return 1;
}

public: MySQLCreateAccountBackpack(playerid)
{
	SetPlayerMySQLID(playerid, cache_insert_id());

	if (GetPlayerMySQLID(playerid) != -1) {
		TDM_MySQLCreateNewStatsClass(playerid);
		MySQLCreateNewQuest(playerid);

		ConnectNewPlayerServer(playerid);
	}
	else {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Упс! Попробуйте ещё раз!");
		KickPlayerEx(playerid);
	}
	return 1;
}

public: MySQLUploadPlayerAccount(playerid)
{
	MySQLUploadPlayerPromoCode(playerid);
	MySQLUploadPlayerDailyBonus(playerid);
	MySQLUploadPlayerPremium(playerid);
	MySQLUploadPlayerSecPassword(playerid);
	MySQLUploadPlayerInvData(playerid);
	MySQLUploadPlayerDinaData(playerid);

	cache_get_value_name(0, DB_ACCOUNTS_REFERAL, pInfo[playerid][e_Referal], MAX_PLAYER_NAME);
	cache_get_value_name_int(0, DB_ACCOUNTS_FOUND_SERVER, pInfo[playerid][e_FoundServer]);
	cache_get_value_name_int(0, DB_ACCOUNTS_SEX, pInfo[playerid][e_Sex]);
	cache_get_value_name_int(0, DB_ACCOUNTS_RANK, pInfo[playerid][e_Rank]);
	cache_get_value_name_int(0, DB_ACCOUNTS_EXP, pInfo[playerid][e_Exp]);
	cache_get_value_name_int(0, DB_ACCOUNTS_MONEY, pInfo[playerid][e_Money]);
	cache_get_value_name_int(0, DB_ACCOUNTS_GOLD_COINS, pInfo[playerid][e_GoldCoins]);
	cache_get_value_name_int(0, DB_ACCOUNTS_KILLS, pInfo[playerid][e_Kills]);
	cache_get_value_name_int(0, DB_ACCOUNTS_DEATHS, pInfo[playerid][e_Deaths]);
	cache_get_value_name_int(0, DB_ACCOUNTS_WINNING_MATCHES, pInfo[playerid][e_WinningMatchs]);
	cache_get_value_name_int(0, DB_ACCOUNTS_LOSING_MATCHES, pInfo[playerid][e_LosingMatchs]);
	cache_get_value_name_int(0, DB_ACCOUNTS_SHOTS_ENEMY, pInfo[playerid][e_ShotsEnemy]);
	cache_get_value_name_int(0, DB_ACCOUNTS_SHOTS_HEAD, pInfo[playerid][e_ShotsHead]);
	cache_get_value_name_int(0, DB_ACCOUNTS_SERIES_KILLS, pInfo[playerid][e_SeriesKills]);

	new
		str[50], str2[250];

	f(str, "p<,>a<i>[%i]", MAX_PLAYER_ANIMATIONS);
	cache_get_value_name(0, DB_ACCOUNTS_ANIMATIONS, str2, sizeof(str2)), sscanf(str2, str, pInfo[playerid][e_Animations]), str[0] = str2[0] = EOS;

	f(str, "p<,>a<i>[%i]", MAX_PLAYERS_IN_BLACKLIST);
	cache_get_value_name(0, DB_ACCOUNTS_BLACKLIST, str2, sizeof(str2)), sscanf(str2, str, pInfo[playerid][e_Blacklist]), str[0] = str2[0] = EOS;

	cache_get_value_name_int(0, DB_ACCOUNTS_WARNS, pInfo[playerid][e_Warns]);
	cache_get_value_name_int(0, DB_ACCOUNTS_MUTED_MINUTES, pInfo[playerid][e_MutedMinutes]);
	cache_get_value_name_int(0, DB_ACCOUNTS_PLAYED_HOURS, pInfo[playerid][e_PlayedHours]);
	cache_get_value_name_int(0, DB_ACCOUNTS_PLAYED_MINUTES, pInfo[playerid][e_PlayedMinutes]);
	cache_get_value_name(0, DB_ACCOUNTS_REG_IP, pInfo[playerid][e_RegIP], MAX_LENGTH_IP);
	cache_get_value_name(0, DB_ACCOUNTS_REG_DATETIME, pInfo[playerid][e_RegDatetime], MAX_LENGTH_DATETIME);
	cache_get_value_name(0, DB_ACCOUNTS_LAST_DATETIME, pInfo[playerid][e_LastDatetime], MAX_LENGTH_DATETIME);

	// Update player data in database
	GetPlayerIp(playerid, pInfo[playerid][e_LastIP], MAX_LENGTH_IP);
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_LAST_DATETIME"` = Now() + INTERVAL %i DAY WHERE `"DB_ACCOUNTS_ID"` = '%i'", pInfo[playerid][e_LastDatetime], GetPlayerMySQLID(playerid));
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_LAST_IP"` = '%s' WHERE `"DB_ACCOUNTS_ID"` = '%i'", pInfo[playerid][e_LastIP], GetPlayerMySQLID(playerid));

	// Set player data in server
	SetPlayerScore(playerid, GetPlayerRank(playerid));
	GivePlayerMoney(playerid, GetPlayerMoneyEx(playerid));

	SCM(playerid, C_GREEN, ""T_INFO" "CT_WHITE"Авторизация прошла успешно!");

	// Second password
	if (strcmp(GetPlayerSecondPassword(playerid), DB_STRING_VALUE_NO, true)) {
		return Interface_Show(playerid, Interface:SecondPassword);
	}

	// Administrator
	CheckMySQLPlayerForAdmin(playerid);
	return 1;
}

static MySQLUploadPlayerData(playerid)
{
	new
		query[47 - 2 + DB_MAX_LENGTH_TABLE_NAME + DB_MAX_LENGTH_FIELD_NAME + MAX_PLAYER_NAME + 1];

	mysql_format(MySQLID, query, sizeof(query), "SELECT * FROM `"DB_ACCOUNTS"` WHERE BINARY `"DB_ACCOUNTS_NICKNAME"` = '%s' LIMIT 1", GetPlayerNameEx(playerid));
	mysql_tquery(MySQLID, query, "MySQLUploadPlayerAccount", "i", playerid);

	TDM_MySQLUploadPlayerClassData(playerid);
	MySQLUploadPlayerQuestData(playerid);
	return 1;
}

public: MySQLGetPlayerData(playerid)
{
	// Login
	if (cache_num_rows()) {
		cache_get_value_name(0, DB_ACCOUNTS_PASSWORD, pInfo[playerid][e_Password], MAX_LENGTH_PASSWORD);
		cache_get_value_name_int(0, DB_ACCOUNTS_ID, pInfo[playerid][e_ID]);

		// Check ban
		static const
			queryFormat[] = "SELECT * FROM `"DB_BANS"` WHERE BINARY `"DB_BANS_PLAYER_NICKNAME"` = '%s' LIMIT 1";

		new
			query[sizeof(queryFormat) - 2 + MAX_PLAYER_NAME];

		mysql_format(MySQLID, query, sizeof(query), queryFormat, GetPlayerNameEx(playerid));
		mysql_tquery(MySQLID, query, "MySQLOnPlayerBanLoad", "i", playerid);
	}
	// Registration
	else {
		ClearPlayerChat(playerid);

		Dialog_Show(playerid, Dialog:ServerRules);

		SCM(playerid, C_WHITE, "Добро пожаловать на сервер "CT_ORANGE""SERVER_NAME_CORE"");
		SCM(playerid, C_WHITE, "");

		CheckPlayerDinaHint(playerid, 0);

		SetPlayerLoggedTimer(playerid, 120000);
	}
	return 1;
}

public: MySQLOnPlayerBanLoad(playerid)
{
	new
		checkBan = true;

	if (cache_num_rows()) {
		new
			adminName[MAX_PLAYER_NAME],
			reason[MAX_LENGTH_ADM_REASON],
			unbanDatetime[MAX_LENGTH_DATETIME];

		cache_get_value_name(0, DB_BANS_ADMIN_NICKNAME, adminName, MAX_PLAYER_NAME);
		cache_get_value_name(0, DB_BANS_REASON, reason, MAX_LENGTH_ADM_REASON);
		cache_get_value_name(0, DB_BANS_UNBAN_DATETIME, unbanDatetime, MAX_LENGTH_DATETIME);

		checkBan = IsDatetimeExpired(unbanDatetime);

		// Unban
		if(checkBan) {
			new
				string[100];

			mysql_format(MySQLID, string, sizeof(string), "DELETE FROM `"DB_BANS"` WHERE BINARY `"DB_BANS_PLAYER_NICKNAME"` = '%s' LIMIT 1", GetPlayerNameEx(playerid));
			mysql_tquery(MySQLID, string);
		}
		else {
			new
				str[300];

			f(str,
			""CT_WHITE"Аккаунт: "CT_YELLOW"%s\
			\n\n"CT_WHITE"Администратор: "CT_YELLOW"%s\
			\n\n"CT_WHITE"Заблокирован до: "CT_WHITE"%s.\
			\n"CT_WHITE"Причина блокировки: "CT_RED"%s\
			\n\n"CT_WHITE"Введите: "CT_RED"/q "CT_WHITE"чтобы выйти.",
			GetPlayerNameEx(playerid), adminName, ShowDatetimeForPlayer(playerid, unbanDatetime), reason);

			Dialog_Message(playerid, ""CT_TOMATO"Данный аккаунт забанен :(", str, "Ok");

			SCM(playerid, C_TOMATO, "Данный аккаунт забанен!");
			KickPlayerEx(playerid, 5000);
		}
	}

	if(checkBan) {
		SetPlayerRussifierType(playerid, RussifierType:0);

		ClearPlayerChat(playerid);

		SCM(playerid, C_WHITE, "Добро пожаловать на сервер "CT_ORANGE""SERVER_NAME_CORE"");

		SetErrorText(playerid, "");
		Dialog_Show(playerid, Dialog:Login);

		SetPlayerLoggedTimer(playerid, 120000);
	}
	return 1;
}

public: MySQLUpdateAccountReferal(playerid)
{
	if (!cache_num_rows()) {
		return 1;
	}

	new
		ReferalMySQLID,
		ReferalExp,
		ReferalMoney;

	cache_get_value_name_int(0, DB_ACCOUNTS_EXP, ReferalExp);
	cache_get_value_name_int(0, DB_ACCOUNTS_MONEY, ReferalMoney);
	cache_get_value_name_int(0, DB_ACCOUNTS_ID, ReferalMySQLID);

	ReferalExp += PLAYER_REFERAL_EXP;
	ReferalMoney += PLAYER_REFERAL_MONEY;

	new
		referalid;

	GetPlayerID(GetPlayerReferal(playerid), referalid);

	if (!IsPlayerOnServer(referalid)) {
		SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_EXP"` = '%i', `"DB_ACCOUNTS_MONEY"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", ReferalExp, ReferalMoney, ReferalMySQLID);
	}
	else {
		GivePlayerExp(referalid, PLAYER_REFERAL_EXP);
		GivePlayerMoneyEx(referalid, PLAYER_REFERAL_MONEY);
	}
	return 1;
}

public: MySQLCheckRegisterReferal(playerid, const nickname[])
{
	if (!cache_num_rows()) {
		SetErrorText(playerid, "Ошибка: данный игрок не зарегистрирован на сервере!");
		Dialog_Show(playerid, Dialog:InputNicknameReferal);
		return 1;
	}

	KillPlayerLoggedTimer(playerid);
	SetPlayerReferal(playerid, nickname);

	MySQLCreateNewAccount(playerid);
	return 1;
}

public: MySQLSetPlayerPassword(playerid)
{
	new
		hash[BCRYPT_HASH_LENGTH];
	
	bcrypt_get_hash(hash);
	SetPlayerPassword(playerid, hash);

	// Registration
	if (GetPlayerLogged(playerid)) {
		Dialog_Show(playerid, Dialog:SelectSex);
		KillPlayerLoggedTimer(playerid);
		SetPlayerLoggedTimer(playerid, 60000);
		return 1;
	}

	// Change password
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_PASSWORD"` = '%s' WHERE `"DB_ACCOUNTS_ID"` = '%i'", pInfo[playerid][e_Password], GetPlayerMySQLID(playerid));
	SCM(playerid, C_GREEN, ""T_PASS" "CT_WHITE"Пароль успешно изменён!");
	return 1;
}

public: MySQLCheckPlayerPassword(playerid)
{
	new
		bool:passwordHash = bcrypt_is_equal();

	if (passwordHash) {
		DeletePVar(playerid, "WrongPassword");
		KillPlayerLoggedTimer(playerid);

		MySQLUploadPlayerData(playerid);
		return 1;
	}

	switch (GetPVarInt(playerid, "WrongPassword")) {
		case 0: {
			SetErrorText(playerid, "Осталось 3 попытки.");
			Dialog_Show(playerid, Dialog:Login);
		}
		case 1: {
			SetErrorText(playerid, "Осталось 2 попытки.");
			Dialog_Show(playerid, Dialog:Login);
		}
		case 2: {
			SetErrorText(playerid, "Осталась 1 попытка.");
			Dialog_Show(playerid, Dialog:Login);
		}
		case 3: {
			SetErrorText(playerid, "Осталась последняя попытка.");
			Dialog_Show(playerid, Dialog:Login);
		}
		default: {
			Dialog_Message(playerid, "Ошибка", ""CT_WHITE"Вы были кикнуты с сервера.\n"CT_RED"Причина: Превышен лимит попыток на ввод пароля.\n"CT_WHITE"Для выхода с сервера введите\"/q\" в чат", "Выход");
			KickPlayerEx(playerid);
		}
	}
	SetPVarInt(playerid, "WrongPassword", GetPVarInt(playerid, "WrongPassword") + 1);
	return 1;
}

stock SetPlayerORMData(playerid)
{
	pInfo[playerid][e_ORM_ID] = orm_create(DB_ACCOUNTS);

	new
		ORM:orm = pInfo[playerid][e_ORM_ID];
	
	orm_addvar_int(orm, pInfo[playerid][e_ID], DB_ACCOUNTS_ID);

	orm_addvar_int(orm, pInfo[playerid][e_Rank], DB_ACCOUNTS_RANK);
	orm_addvar_int(orm, pInfo[playerid][e_Exp], DB_ACCOUNTS_EXP);
	orm_addvar_int(orm, pInfo[playerid][e_Money], DB_ACCOUNTS_MONEY);
	orm_addvar_int(orm, pInfo[playerid][e_Kills], DB_ACCOUNTS_KILLS);
	orm_addvar_int(orm, pInfo[playerid][e_Deaths], DB_ACCOUNTS_DEATHS);
	orm_addvar_int(orm, pInfo[playerid][e_WinningMatchs], DB_ACCOUNTS_WINNING_MATCHES);
	orm_addvar_int(orm, pInfo[playerid][e_LosingMatchs], DB_ACCOUNTS_LOSING_MATCHES);
	orm_addvar_int(orm, pInfo[playerid][e_ShotsEnemy], DB_ACCOUNTS_SHOTS_ENEMY);
	orm_addvar_int(orm, pInfo[playerid][e_ShotsHead], DB_ACCOUNTS_SHOTS_HEAD);
	orm_addvar_int(orm, pInfo[playerid][e_SeriesKills], DB_ACCOUNTS_SERIES_KILLS);

	orm_addvar_int(orm, pInfo[playerid][e_MutedMinutes], DB_ACCOUNTS_MUTED_MINUTES);

	orm_addvar_int(orm, pInfo[playerid][e_PlayedHours], DB_ACCOUNTS_PLAYED_HOURS);
	orm_addvar_int(orm, pInfo[playerid][e_PlayedMinutes], DB_ACCOUNTS_PLAYED_MINUTES);

	orm_setkey(orm, DB_ACCOUNTS_ID);
	return 1;
}

stock SavePlayerData(playerid)
{
	if (pInfo[playerid][e_ORM_ID] != ORM:0) {
		orm_update(pInfo[playerid][e_ORM_ID]);
	}
	return 1;
}

static SavePlayerAnimations(playerid)
{
	new
		strAnims[(MAX_PLAYER_ANIMATIONS * 2) + 1];

	FormatIntArrayToSQL(pInfo[playerid][e_Animations], MAX_PLAYER_ANIMATIONS, strAnims);

	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_ANIMATIONS"` = '%s', `"DB_ACCOUNTS_MONEY"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", strAnims, GetPlayerMoneyEx(playerid), GetPlayerMySQLID(playerid));
	return 1;
}

static SavePlayerBlacklist(playerid)
{
	new
		strBlackList[(MAX_PLAYERS_IN_BLACKLIST * MAX_LENGTH_NUM) + (MAX_PLAYERS_IN_BLACKLIST * 2) + 1];

	FormatIntArrayToSQL(pInfo[playerid][e_Blacklist], MAX_PLAYERS_IN_BLACKLIST, strBlackList);

	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_BLACKLIST"` = '%s' WHERE `"DB_ACCOUNTS_ID"` = '%i'", strBlackList, GetPlayerMySQLID(playerid));
	return 1;
}

stock SavePlayerMoney(playerid)
{
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_MONEY"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerMoneyEx(playerid), GetPlayerMySQLID(playerid));
	return 1;
}

stock SavePlayerGoldCoins(playerid)
{
	SQL("UPDATE `"DB_ACCOUNTS"` SET `"DB_ACCOUNTS_GOLD_COINS"` = '%i' WHERE `"DB_ACCOUNTS_ID"` = '%i'", GetPlayerGoldCoins(playerid), GetPlayerMySQLID(playerid));
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

stock Player_OnGameModeInit()
{
	Iter_Init(SpecDeadPlayers);
	return 1;
}

/*
 * |>-------------<|
 * |   PC_OnInit   |
 * |>-------------<|
 */

stock Player_PC_OnInit()
{
	Premium_PC_OnInit();
}

/*
 * |>------------------------<|
 * |   OnPlayerRequestSpawn   |
 * |>------------------------<|
 */

stock Player_OnPlayerRequestSpawn(playerid)
{
	if (IsPlayerNPC(playerid)) {
		return 1;
	}

	if (GetPlayerLogged(playerid)) {
		return 0;
	}
	return 1;
}

/*
 * |>------------------------<|
 * |   OnPlayerRequestClass   |
 * |>------------------------<|
 */

stock Player_OnPlayerRequestClass(playerid, classid)
{
	#pragma unused classid

	if (IsPlayerNPC(playerid)) {
		return 1;
	}

	SetSpawnInfo(playerid, NO_TEAM, 0, 0.0, 0.0, 0.0, 0.0, WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);

	if (!GetPlayerLogged(playerid)) {
		if (GetPVarInt(playerid, "WC_RequestClass")) {
			SpecPl(playerid, true);
		}
		else {
			SetPlayerTimerSpawn(playerid, 200);
		}
		return 0;
	}
	return 1;
}

/*
 * |>-------------------<|
 * |   OnPlayerConnect   |
 * |>-------------------<|
 */

stock Player_OnPlayerConnect(playerid)
{
	if (IsPlayerNPC(playerid)) {
		return 1;
	}

	// Reset data
	ResetPlayerGlobalData(playerid);
	ResetPlayerCoreTDs(playerid);

	// Name and IP
	new
		playerLastIP[MAX_LENGTH_IP], playerName[MAX_PLAYER_NAME];

	GetPlayerIp(playerid, playerLastIP, MAX_LENGTH_IP);
	GetPlayerName(playerid, playerName, MAX_PLAYER_NAME);

	SetPlayerIPLast(playerid, playerLastIP);
	SetPlayerNameEx(playerid, playerName);

	// Checks
	if (!IsValidNickName(GetPlayerNameEx(playerid))) {
		KickPlayerEx(playerid);
		return 1;
	}

	if (IsStringIP(GetPlayerNameEx(playerid)) 
	|| IsODomen(GetPlayerNameEx(playerid))) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_YELLOW"%s "CT_WHITE"имеет рекламный ник [IP: "CT_YELLOW"%s"CT_WHITE"].", GetPlayerNameEx(playerid), pInfo[playerid][e_LastIP]);

		KickPlayerEx(playerid);
		return 1;
	}

	// Logo
	ShowPlayerLogoServerTD(playerid);

	// Animations
	PreloadAllAnimLibs(playerid);

	// Set data player
	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerArmourEx(playerid, 0.0);

	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 850, playerid);

	SetPlayerSkinEx(playerid, 0);
	SetPlayerTeamEx(playerid, 0);
	SetPlayerColorEx(playerid, 0xCCCCCC00);

	SetPlayerLogged(playerid, true);

	// Mode
	Mode_EnterPlayer(playerid, MODE_NONE, playerid);

	// Update data
	TimerUpdateData[playerid] = SetPlayerTimer(playerid, "CallUpdatePlayerData", 1000, true);

	// Database MySQL
	static const
		queryFormat[] = "SELECT * FROM `"DB_ACCOUNTS"` WHERE BINARY `"DB_ACCOUNTS_NICKNAME"` = '%s' LIMIT 1";

	new
		query[sizeof(queryFormat) - 2 + MAX_PLAYER_NAME];

	mysql_format(MySQLID, query, sizeof(query), queryFormat, GetPlayerNameEx(playerid));
	mysql_tquery(MySQLID, query, "MySQLGetPlayerData", "i", playerid);

	// Destroyed objects
	#include <map-objects/destroyed-objects>
	return 0;
}

/*
 * |>----------------------<|
 * |   OnPlayerDisconnect   |
 * |>----------------------<|
 */

stock Player_OnPlayerDisconnect(playerid, reason)
{
	#pragma unused reason

	if (IsPlayerNPC(playerid)) {
		return 1;
	}

	KillTimer(TimerUpdateData[playerid]);

	KillTimer(TimerSpawn[playerid]);
	KillTimer(TimerClearAnim[playerid]);
	KillTimer(TimerFreezingPos[playerid]);
	KillTimer(TimerUnFreezeCW[playerid]);
	KillTimer(TimerLogged[playerid]);

	if (GetPlayerFreeze(playerid)) {
		CallUnFreeze(playerid, true);
		KillTimer(TimerFreeze[playerid]);
	}

	if (IsAdminsSpecPlayer(playerid)) {
		foreach (new p:AdminCountSpecPlayer[playerid]) {
			StopAdminSpectating(p, false);
			SCM(p, C_RED, ""T_INFO" "CT_WHITE"Игрок вышел из сервера.");
		}
		StopAdminsSpectating(playerid);
	}

	if (GetAdminSpectating(playerid)) {
		StopAdminSpectating(playerid);
	}
	else {
		Mode_LeavePlayer(playerid);
	}

	if (GetAdminLevel(playerid) != ADM_LEVEL_NONE) {
		Iter_Remove(TotalAdmins, playerid);
	}

	// MySQL data
	if (pInfo[playerid][e_ORM_ID] != ORM:0) {
		orm_destroy(pInfo[playerid][e_ORM_ID]);
	}
	return 0;
}

/*
 * |>-----------------<|
 * |   OnPlayerSpawn   |
 * |>-----------------<|
 */

stock Player_OnPlayerSpawn(playerid)
{
	if (!PermissionPlayerSpawn{playerid}) {
		PermissionPlayerSpawn{playerid} = true;
		return 1;
	}
		
	PreloadAllAnimLibs(playerid);
	SetPlayerFightingStyleEx(playerid, GetPlayerFightingStyleEx(playerid));

	new
		Float:x, Float:y, Float:z;

	GetSpawnInfoPosEx(playerid, x, y, z);
	SetPlayerPosEx(playerid, x, y, z, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));

	if (GetPlayerCanSpectating(playerid)) {
		SetPlayerCanSpectating(playerid, false);
	}

	if (IsAdminsSpecPlayer(playerid)) { 
		UpdateAdminSpectating(playerid);
	}
	return 0;
}

/*
 * |>-----------------<|
 * |   OnPlayerDeath   |
 * |>-----------------<|
 */

stock Player_OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	if (GetPlayerDead(playerid) != PLAYER_DEATH_NONE) {
		return 1;
	}

	AntiCheatSetDeathState(playerid, 1);

	OnVehicleDeathPlayer(playerid, killerid, reason);
	ExitPlayerVehicle(playerid);

	SetPlayerCanSpectating(playerid, true);
	GivePlayerDeaths(playerid, 1);

	if (GetPlayerAnimationEx(playerid)) {
		SetPlayerAnimationEx(playerid, false);
	}

	if (killerid == INVALID_PLAYER_ID) {
		SetPlayerStatusDead(playerid, PLAYER_DEATH_INVALID);

		new
			Float:x, Float:y, Float:z;

		GetPlayerPos(playerid, x, y, z);
		SetPlayerCameraPos(playerid, x + 0.5, y + 0.5, z + 3.0);
		SetPlayerCameraLookAt(playerid, x, y, z);

		ResetPlayerWeaponsEx(playerid);

		UpdatePlayerAfterDeadTD(playerid);
		ShowPlayerDeadKiller(playerid, PLAYER_DEATH_INVALID);
	}
	else {
		SetPlayerStatusDead(playerid, PLAYER_DEATH_KILLER);

		GivePlayerKillStrike(killerid, 1);
		ShowPlayerKillStrike(killerid);

		if (GetPlayerKillStrike(killerid) > GetPlayerSeriesKills(playerid)) {
			GivePlayerSeriesKills(playerid, GetPlayerKillStrike(killerid));
		}

		ResetPlayerKillStrike(playerid);
		HidePlayerKillStrike(playerid);

		GivePlayerKills(killerid, 1);

		SetPVarString(killerid, "NamePlayerForReward", GetPlayerNameEx(playerid));
	
		PlayerPlaySoundEx(killerid, 17802, 0.0, 0.0, 0.0);
		ResetPlayerWeaponsEx(playerid);

		SetPlayerSpectating(playerid, killerid);
		SpecPl(playerid, true);

		if (IsPlayerInAnyVehicle(killerid)) {
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(killerid));
		}
		else {
			PlayerSpectatePlayer(playerid, killerid);
		}

		SCM(playerid, C_RED, ""T_INFO" "CT_WHITE"Убийство совершил: "CT_YELLOW"%s", GetPlayerNameEx(killerid));

		SetPlayerProgressBarValue(playerid, BarSpawnTime[playerid], 0.0);
		UpdatePlayerDeadKillerTD(playerid, killerid);
		ShowPlayerDeadKiller(playerid, PLAYER_DEATH_KILLER);

		CheckPlayerDinaHint(playerid, 19);
	}

	if (GetIndicatorHealth() == PLAYER_IND_HEALTH_CUSTOM) {
		SetPlayerProgressBarValue(playerid, BarHealth[playerid], 0.0);
		SetPlayerProgressBarValue(playerid, BarArmour[playerid], 0.0);
	}
	return 0;
}

/*
 * |>----------------<|
 * |   OnPlayerText   |
 * |>----------------<|
 */

stock Player_OnPlayerText(playerid, const text[])
{
	if (GetPlayerLogged(playerid)) {
		return 1;
	}

	if (GetPlayerMute(playerid) > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"У вас мут чата! Осталось: %i минут", GetPlayerMute(playerid));
		return 1;
	}

	if (GetPlayerAntiFloodChat(playerid) > 0) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Не флуди!");
		return 1;
	}

	if (IsStringIP(text)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Подозрение на рекламу!");
		return 1;
	}

	if (strlen(text) > 90) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"Больше 90 символов запрещено вводить!");
		return 1;
	}

	if (!GetPlayerAnimationEx(playerid)) {
		ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.1, false, true, true, true, 0, SYNC_ALL);
		StartPlayerTimerClearAnim(playerid, 100 * strlen(text));
	}

	SetPlayerAntiFloodChat(playerid);
	return 0;
}

/*
 * |>-----------------------<|
 * |   OnPlayerClickPlayer   |
 * |>-----------------------<|
 */

stock Player_OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	#pragma unused source

	if (GetPlayerLogged(playerid)) {
		return 1;
	}

	if (Dialog_IsOpen(playerid)) {
		SCM(playerid, C_RED, ""T_ERROR" "CT_WHITE"В открытом диалоге запрещено выбирать игроков.");
		return 1;
	}

	if (playerid == clickedplayerid) {
		return 1;
	}

	SetPVarInt(playerid, "ClickPlayerNameTAB", clickedplayerid);
	Dialog_Show(playerid, Dialog:ClickOnPlayerInTAB);
	return 0;
}

/*
 * |>--------------------------<|
 * |   OnPlayerKeyStateChange   |
 * |>--------------------------<|
 */

stock Player_OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	// ENTER
	if (newkeys & KEY_SECONDARY_ATTACK) {
		if (GetPlayerAnimationEx(playerid)) {
			SetPlayerAnimationEx(playerid, false);
			StartPlayerTimerClearAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			return 1;
		}
	}

	// SPACE
	if (newkeys & KEY_SPRINT) {
		if (GetPlayerAnimationEx(playerid)) {
			SetPlayerAnimationEx(playerid, false);
			StartPlayerTimerClearAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			return 1;
		}
	}

	// Y
	if (newkeys & KEY_YES) {
		if (!IsPlayerInAnyVehicle(playerid) && !GetSpecPl(playerid)) {
			Dialog_Show(playerid, Dialog:ListAnimations);
			return 1;
		}
	}

	if (newkeys & KEY_FIRE) {
		// Timer respawn
		if (GetPlayerDead(playerid) == PLAYER_DEATH_KILLER) {
			Mode_SetAddSpeedRespawn(playerid);
			return 1;
		}
	}

	// Weapon sniper
	if (GetPVarInt(playerid, "ActiveBody")) {
		if (GetPlayerWeapon(playerid) == WEAPON_SNIPER) {
			if (oldkeys & KEY_ANALOG_LEFT) {
				DeletePVar(playerid, "ActiveBody");

				if (!IsPlayerAttachedObjectSlotUsed(playerid, 0)) {
					if (GetPlayerInvHead(playerid)) {
						GiveAttachPlayerItem(playerid, GetPlayerInvHead(playerid));
					}
					TDM_PlayerClassAttachHead(playerid);
				}

				if (!IsPlayerAttachedObjectSlotUsed(playerid, 2)) {
					if (GetPlayerInvGlasses(playerid)) {
						GiveAttachPlayerItem(playerid, GetPlayerInvGlasses(playerid));
					}
				}
				if (!IsPlayerAttachedObjectSlotUsed(playerid, 3)) {
					if (GetPlayerInvMask(playerid)) {
						GiveAttachPlayerItem(playerid, GetPlayerInvMask(playerid));
					}
				}
				return 1;
			}
		}
	}
	else {
		if (GetPlayerWeapon(playerid) == WEAPON_SNIPER) {
			if (newkeys & KEY_ANALOG_LEFT) {
				if (IsPlayerAttachedObjectSlotUsed(playerid, 0)
				|| IsPlayerAttachedObjectSlotUsed(playerid, 2)
				|| IsPlayerAttachedObjectSlotUsed(playerid, 3)) {

					SetPVarInt(playerid, "ActiveBody", 1);

					if (IsPlayerAttachedObjectSlotUsed(playerid, 0)) {
						RemovePlayerAttachedObject(playerid, 0);
					}

					if (IsPlayerAttachedObjectSlotUsed(playerid, 2)) {
						RemovePlayerAttachedObject(playerid, 2);
					}

					if (IsPlayerAttachedObjectSlotUsed(playerid, 3)) {
						RemovePlayerAttachedObject(playerid, 3);
					}
					return 1;
				}
			}
		}
	}
	return 0;
}

/*
 * |>------------------<|
 * |   OnPlayerUpdate   |
 * |>------------------<|
 */

stock Player_OnPlayerUpdate(playerid)
{
	if (GetPlayerDead(playerid) == PLAYER_DEATH_NONE) {
		if (!GetAdminSpectating(playerid)) {
			UpdatePlayerBaseIndicatorsTD(playerid);
		}
	}

	TimeAFK[playerid] = -2;
	return 1;
}

/*
 * |>---------------------------<|
 * |   OnPlayerCommandReceived   |
 * |>---------------------------<|
 */

stock Player_OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if (Premium_OnPlayerCommandReceived(playerid, cmd, params, flags)) {
		return 1;
	}

	return 0;
}