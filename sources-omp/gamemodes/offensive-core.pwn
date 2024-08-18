/*
 *	Offensive-Core
 *	By: Foxze
 *
*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		UnFreeze(playerid, bool:freeze)
		Call_PlayerLoggedTimer(playerid)
		UpdateAccount(playerid)
		UpdateAccountReferal(playerid)
		Kicker(playerid)
		ProxDetectorS(Float:radi, playerid, targetid)
		mysql_PromoCodeShow(playerid)
		mysql_PromoCreate(playerid, code[])
		mysql_PromoCheck(playerid, code[])
		CreatePromoBackpack()
		mysql_PromoDelete(playerid, code[])
		SCMEX(playerid, color, message[], bool:chat_text)
		UpdatePlayerMiniGame(playerid)
		UnfreezeCw(playerid)
		PlayerFreezingPos(playerid)
		ClearPlayerAnim(playerid)
		CheckPlayerBan(playerid)
		SRV_Update()
		SRV_Update_2()
		CreateUserBackpack(playerid) 
		UploadPlayerAccount(playerid)
		UpdatePlayerRegisterData(playerid) 
	Stock:
		IsPlayerInvalided(playerid)
		SetPlayerLogged(playerid, bool:logged)
		GetPlayerLogged(playerid)
		PlayerSpawn(playerid)
		SetSpawnInfoEx(playerid, skin, Float:x, Float:y, Float:z, Float:angle)
		SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, sp_world, sp_interior, setUP = false, freezing = false)
		DestroyPlayerAttachedObjects(playerid)
		DeaglePlayerAntiC(playerid)
		SetPlayerColorEx(playerid, color)
		GetPlayerColorEx(playerid)
		SpecPl(playerid, bool:spec)
		GetSpecPl(playerid)
		SetPlayerTeamEx(playerid, team)
		GetPlayerTeamEx(playerid)
		SetPlayerHealthEx(playerid, Float:health)
		GetPlayerHealthEx(playerid, &Float:health)
		SetPlayerArmourEx(playerid, Float:armour)
		GetPlayerArmourEx(playerid, &Float:armour)
		SetPlayerSkinEx(playerid, skinid)
		GetPlayerSkinEx(playerid)
		SetPlayerStyleMelee(playerid, style)
		GetPlayerStyleMelee(playerid)
		SetPlayerStylesMelee(playerid)
		SetPlayerGoldCoins(playerid, goldcoins, bool:text = false)
		GetPlayerGoldCoins(playerid)
		SetPlayerCredit(playerid, credit, bool:text = false)
		GetPlayerCredits(playerid)
		SetPlayerRank(playerid, rank, bool:text = false)
		GetPlayerRank(playerid)
		CheckPlayerNextRank(playerid)
		SetPlayerExp(playerid, exp, bool:text = false, bool:roundpoints = true)
		GetPlayerExp(playerid)
		SetPlayerVirtualWorldEx(playerid, world_id)
		GetPlayerVirtualWorldEx(playerid)
		SetPlayerInteriorEx(playerid, interior_id)
		GetPlayerInteriorEx(playerid)
		SetPlayerSex(playerid, type)
		GetPlayerSex(playerid)
		SetPlayerDead(playerid, num)
		GetPlayerDead(playerid)
		SetPlayerDamage(playerid, bool:type)
		GetPlayerDamage(playerid)
		SetPlayerAnimationEx(playerid, bool:type)
		GetPlayerAnimationEx(playerid)
		SetPlayerBusy(playerid, type)
		GetPlayerBusy(playerid)
		SetPlayerWeatherEx(playerid, weather_id)
		GetPlayerWeatherEx(playerid)
		SetPlayerFreeze(playerid, time = 1, bool:freeze = true)
		GetPlayerFreeze(playerid)
		GetPlayerWinRounds(playerid) 
		SetPlayerWinRound(playerid, rounds)
		GetPlayerLossRounds(playerid) 
		SetPlayerLossRound(playerid, rounds)
		GetPlayerShotsEnemy(playerid)
		SetPlayerShotEnemy(playerid, shot
		GetPlayerShotsHead(playerid)
		SetPlayerShotHead(playerid, shot)
		GetPlayerSeriesKills(playerid
		SetPlayerSeriesKill(playerid, kills)
		GetPlayerKills(playerid
		SetPlayerKill(playerid, kills)
		GetPlayerDeaths(playerid)
		SetPlayerDeath(playerid, deaths)
		SetPlayerCarabSpectating(playerid, bool:type)
		GetPlayerCarabSpectating(playerid)
		SetPlayerAntiKeys(playerid, keys)
		GetPlayerAntiKeys(playerid)
		SetPlayerInvisible(playerid, bool:type)
		GetPlayerInvisible(playerid)
		SetPlayerKillStrike(playerid, num)
		GetPlayerKillStrike(playerid)
		GetNamePoint(num)
		GetNameSquad(num)
		SetPlayerZone(playerid, bool:type)
		GetPlayerZone(playerid)
		SetPlayerClickTD(playerid, bool:type)
		GetPlayerClickTD(playerid)
		SetPlayerpID(playerid, num)
		GetPlayerpID(playerid)
		SetPlayerPremium(playerid, num)
		GetPlayerPremium(playerid)
		SetPlayerPremiumData(playerid, num)
		GetPlayerPremiumData(playerid)
		SetPlayerCheckPlayerid(playerid, check_player)
		GetPlayerCheckPlayerid(playerid)
		SetPlayerLoggedTimer(playerid, seconds)
		KillPlayerLoggedTimer(playerid)
		SetCheckNameReferal(playerid, const name[])
		InformationTextCMD(playerid, const text[])
		SetErrorText(playerid, text[])
		Name(playerid) 
		IsPlayerInArea(playerid, Float:min_x, Float:min_y ,Float:max_x, Float:max_y)
		GetPlayerSpeed(playerid)
		GetPlayerFPS(playerid) 
		GetPlayerID(const name[], id)
		GetNameID(const name[])
		GetString(param1[], param2[]) 
		IsCh(num)
		IsOSymbol(text[], symbol, first, end)
		IsODomen(text[]) 
		IsOIP(text[])
		HexToInt(string[])
		DestroyPlayerTD(playerid, &PlayerText:TD_id)
		DestroyPlayerText3D(playerid, &PlayerText3D:T3D_id)
		SetPlayerFee(playerid, exp, credit, type, bool:textTD = true)
		CreateTextTDReward(playerid, id, type)
		ShowReplenText(playerid, exp, credit, type)
		DestroyPlayerReward(playerid)
		UpdatePlayerReward(playerid) 
		ShowNewRank(playerid)
		ShowTDNewRank(playerid)
		CreatePlayerTDs(playerid)
		PreloadAnimLib(playerid, animlib[])
		PreloadAllAnimLibs(playerid)
		RemovePlayerDead(playerid)
		TDRandomColor(playerid, PlayerText:td_id)
		TDRandomVehicle(playerid, PlayerText:td_id)
		ClosePlayerDialog(playerid)
		KickEx(playerid)
		UpdateBarTimeRespawn(playerid)
		ProxDetector(Float:radi, playerid, const str[], col1, col2, col3, col4, col5)
		CheckPremiumAccount(playerid)
		ShowTDKillStrike(playerid)
		ShowTDPlayerReward(playerid)
		ShowTDPlayerStatsRound(playerid)
		ShowTDPlayerFPSandPING(playerid)
		UpdateSpectatingPlayer(playerid, spectedid)
		ShowPlayerKillStrike(playerid)
		HidePlayerKillStrike(playerid)
		UpdatePlayerKillStrike(playerid)
		CreatePlayerNewRank(playerid)
		DestroyPlayerNewRank(playerid)
		UpdatePlayerNewRank(playerid)
		SetPlayerSpawnKill(playerid)
		DestroyPlayerSpawnKill(playerid)
		UpdatePlayerSpawnKill(playerid)
		ShowTDSpawnKill(playerid)
		ShowPlayerExitZone(playerid)
		HidePlayerExitZone(playerid)
		GetPlayerExitZone(playerid)
		ShowPlayerTDExitZone(playerid)
		UpdatePlayerExitZone(playerid)
		DestroyPlayerBelowHealth(playerid)
		UpdatePlayerBelowHealth(playerid)
		CreatePlayerBaseIndicators(playerid)
		DestroyPlayerBaseIndicators(playerid, bool:hide = true)
		ShowBarPlayerHealth(playerid)
		DestroyBarPlayerHealth(playerid, bool:hide = true)
		ShowPlayerTDBarHealth(playerid)
		ShowBarPlayerArmour(playerid)
		DestroyBarPlayerArmour(playerid, bool:hide = true)
		ShowPlayerTDBarArmour(playerid)
		CreatePlayerFPSandPING(playerid)
		DestroyPlayerFPSandPING(playerid, bool:hide = true)
		UpdatePlayerFPSandPING(playerid)
		CreatePlayerStatsRound(playerid)
		DestroyPlayerStatsRound(playerid, bool:hide = true)
		UpdatePlayerStatsRound(playerid)
		SetPlayerAnimation(playerid, id)
		PlayerPlaySoundEx(playerid, sound, Float:x, Float:y, Float:z)
		SetPlayerAntiFloodChat(playerid)
		UpdatePlayerTime(playerid)
		SetPlayerSecondTime(playerid)
		GetPlayerSecondTime(playerid)
		SetPlayerMinuteTime(playerid)
		GetPlayerMinuteTime(playerid)
		SetPlayerHourTime(playerid)
		GetPlayerHourTime(playerid)
		UpdatePlayerInAFK(playerid)
		Streamer_UP(mode_id, world_id)
		IsPlayerOnServer(playerid)
		IsSex(sex_id)
		IsPlayerInBlackList(playerid, playerid_blacklist)
		CheckPlayerBlacklists(playerid, playerid_blacklist)
		CheckSpectatingPlayers(playerid, killerid)
		ResetPlayerTDs(playerid)
		LoadMapObjects() 
		ClearKillFeed(playerid = INVALID_PLAYER_ID)
		ResetPlayerGlobalVariables(playerid)
		SetPlayerIDStats(playerid, playerid2)
		GetPlayerIDStats(playerid)
		SetPlayerMGSettings(playerid, num)
		ResetPlayerMG(playerid)
		MG_SetPlayerNum(playerid, num)
		MG_GetPlayerNum(playerid)
		MG_SetPlayerTimer(playerid, num)
		MG_GetPlayerTimer(playerid)
		MG_SetPlayerCount(playerid, num)
		MG_GetPlayerCount(playerid)
		MG_SetPlayerValue(playerid, num)
		MG_GetPlayerValue(playerid)
		MG_SetPlayerTime(playerid, num)
		MG_GetPlayerTime(playerid)
		HEXResultColor(color[], type) 
		GeneratePassword(size)
		ShowPlayerBeDamage(playerid)
		HidePlayerBeDamage(playerid)
		GetPlayerBeDamage(playerid)
		GetPlayerBeDamageTimer(playerid)
		SetPlayerCustomClass(playerid, class_id)
		GetPlayerCustomClass(playerid)
		SetPlayerCustomClass2(playerid, class_id)
		GetPlayerCustomClass2(playerid)
		SetPlayerSpeedRespawn(playerid, add, type)
		GetPlayerSpeedRespawn(playerid)
		SetPlayerSpectating(playerid, spec_playerid)
		GetPlayerSpectating(playerid)
		SetPlayerSpecStatus(playerid, num)
		GetPlayerSpecStatus(playerid)
		CreatePlayerDeadKiller(playerid, type)
		DestroyPlayerDeadKiller(playerid, type, bool:hide = true)
		UpdateTDDeadKiller(playerid, killerid)
		ShowTDDeadKiller(playerid)
		ShowTDDeath(playerid)
		UpdateTDTextDeath(playerid)
		ShowDeadKiller(playerid, killerid)
		ConnectPlayerServer(playerid)
		ConnectNewPlayerServer(playerid)
		PlayerConnectServerMessage(playerid)
		GetRandomKey(num)
		GetRandomKeyStr(num)
		StartPlayerTimerClearAnim(playerid, seconds = 0)
		GetRandomColorText(num)
		SetIndicatorHealth(num)
		GetIndicatorHealth()
		CreateNewAccount(playerid) 
		CreateNewUser(playerid, Password[])
		CreateNewUserBasic(playerid, Password[], query[1000], str[6000])
		UploadPlayerData(playerid)
		UploadPlayerPremium(playerid)
		SavePlayerPremium(playerid)
		SavePlayerNickColor(playerid)
		UPD(playerid, const field[], data)
		TDM_UPD(playerid, const field[], data)
		SavePlayerAnimations(playerid)
		SavePlayerBlacklist(playerid)
		SavePlayerKillsDeaths(playerid)
		SavePlayerRankExp(playerid)
		SavePlayerGoldCoins(playerid)
		SavePlayerCredit(playerid)
		SavePlayerRounds(playerid)
		SavePlayerShotsEnemy(playerid)
		SavePlayerShotsHead(playerid)
		SavePlayerSeriesKills(playerid)
		SavePlayerTime(playerid)
Enums:
	E_PLAYER_INFO
	E_PLAYER_TD_REWARD_INFO
	E_PLAYER_MINIGAME_INFO
	E_RANDOM_KEYS_INFO
Commands:
	test(playerid) 
	killtest(playerid) 
	weapontest(playerid)
	locsettime(playerid, params[])
	none_mode(playerid)
	leave(playerid)
	exit(playerid)
	v(playerid, params[])
	color(playerid)
	e(playerid)
	o(playerid, params[])
	referals(playerid)
	quest(playerid)
	quests(playerid)
	mission(playerid)
	missions(playerid)
	me(playerid, params[])
	anims(playerid)
	blacklist(playerid)
	help(playerid)
	info(playerid)
	menu(playerid)
	news(playerid)
	mn(playerid)
	mm(playerid)
	donate(playerid)
	cmds(playerid)
	rules(playerid)
	stats(playerid)
	photo(playerid)
	piss(playerid)
	pm(playerid, params[])
Dialogs:
	Referals
	ClickOnPlayerInTAB
	MessagePlayerInTAB
	ViolationPlayerInTAB
	BlackListPlayerInTAB
	ChoosePlayerStats
	Help
	InfoModes
	CommandsServer
	PlayerOptions
	PlayerStats
	PlayerMenu
	PlayerChangeSecurity
	PlayerChangeColor
	PlayerInputColor
	ServerNews
	PlayerDonate
	PlayerBuyPremium
	SelectTopPlayers
	TopKillsPlayers
	TopCreditsPlayers
	ServerOptions
	SelectOptionPromo
	PlayerPromoCode
	ServerRules
	SelectPlayerSex
	SelectPlayerFoundServer
	PlayerChangePassword
	PlayerInputReferal
	PlayerBuyAnimations
	PlayerListAnimations
	ListPromo
	CreatePromoGoldCoins
	CreatePromoCredits
	CreatePromoSelectDP
	CreatePromoPeople
	CreatePromoDays
	CreatePromoName
	CreatePromo
	DeletePromo
	PlayerBlackList
	PlayerInputPassword
	PlayerRepeatPassword
	PlayerLogin
Interfaces:
	-
------------------------------------------------------------------------------*/

AntiDeAMX()
{
	new a[][] = { "Unarmed (Fist)", "Brass K" };
	#pragma unused a
}

#pragma warning disable 239
#pragma warning disable 214

/*

	* Includes *

*/

#define NO_TAGS
#define MIXED_SPELLINGS

#include <open.mp>
#include <a_http>
#include <a_mysql>

#include <sources/config>
#include <sources/colors>
#include <sources/core>

#include <crashdetect>
#include <sscanf2>
#include <streamer>
#include <StreamerFunction>
#include <foreach>
#include <Pawn.CMD>
#include <Pawn.Raknet>
#include <Pawn.Regex>
#include <cinterface>
#include <mdialog>
#include <progress2>
#include <rustext>
#include <mapfix>
#include <nex-ac>
#include <weapon-config>

/*

	* Defines *

*/

// Server source names
#define SERVER_NAME					"Offensive"				// Название сервера
#define SERVER_NAME_CORE			"Offensive-Core"		// Название сервера Core
#define SERVER_VERSION				"1.0.0"					// Версия сервера
#define SERVER_SITE					"-"						// Ссылка на сайт
#define SERVER_CLIENT				"OpenMP"				// Ссылка на Discord
#define SERVER_VK					"vk.com/offensive_samp"	// Ссылка на VK группу

// MySQL
#define MYSQL_HOST					"127.127.126.25"		// Адрес MySQL Сервер
#define MYSQL_USER					"root"					// Имя пользователя
#define MYSQL_DATABASE				"offensive_core"		// Имя базы данных
#define MYSQL_PASSWORD				""						// Пароль базы данных

#define T_ACCOUNTS					"accounts"		// Игроки
#define T_ADMINS					"admins"		// Админы
#define T_BANS						"bans"			// Забаненные игроки
#define T_BUGS						"bugs"			// Обратная связь игроков
#define T_PROMOCODES				"promocodes"	// Промокоды на игровом сервере
#define T_QUESTS					"quests"		// Квесты игроков в режимах
#define T_TDM_STATS					"tdm_stats"		// Статистика игроков в TDM 

// Player indicator health bar
#define PLAYER_IND_HEALTH_NONE		(0)		// Нет индикатора
#define PLAYER_IND_HEALTH_WC		(1)		// Индикатор от weapon-config
#define PLAYER_IND_HEALTH_CUSTOM	(2)		// Индикатор кастомный

// Player Start Bonus
#define INITIAL_PLAYER_RANK			(1)			// Начальный ранг игрока
#define INITIAL_PLAYER_CREDIT		(300)		// Начальные кредиты игрока
#define INITIAL_PLAYER_BANNER		(1)			// Начальный баннер игрока

// Damage indicator
#define MAX_INDICATOR_TEXT			(20)		// Макс. кол-во показателей попадания
#define INDICATOR_TEXT_TIMER		(2)			// Таймер пропадания показателя попадания в секундах

// Dialogue styles
#define DSM							DIALOG_STYLE_MSGBOX
#define DSI							DIALOG_STYLE_INPUT
#define DSL							DIALOG_STYLE_LIST
#define DSP							DIALOG_STYLE_PASSWORD
#define DST							DIALOG_STYLE_TABLIST
#define DSTH						DIALOG_STYLE_TABLIST_HEADERS

// Others data
#define PLAYER_MAX_ANIMATIONS		(49)		// Макс. кол-во доступных анимаций для игрока
#define MAX_PLAYERS_IN_BLACKLIST	(30)		// Макс. кол-во людей в чёрном списке
#define PLAYER_TIMER_SPAWNKILL		(3)			// Таймер SpawnKill для игрока
#define MAX_DAILY_DAYS				(10)		// Макс. кол-во дней получения ежедневного бонуса
#define MAX_REPORTS					(5000)		// Макс. кол-во репортов
#define MAX_PLAYER_ATTACH_ITEM		(10)		// Макс. кол-во предметов надетых на игрока
#define MAX_PLAYER_WEAPON_SLOTS		(13)		// Макс. кол-во слотов оружия от 0 до 12
#define MAX_TEXTS_AFTER_DEAD		(10)		// Макс. кол-во текстов после смерти
#define MAX_PLAYER_TIMER_RESPAWN	(3)			// Таймер респавна игрока после смерти
#define RANDOM_KEYS_MAX_COUNT		(3)			// Кол-во рандомных клавиш
#define RANDOM_COLOR_MAX_COUNT		(6)			// Кол-во рандомных цветов для текста

// Death player
#define PLAYER_DEATH_INVALID		(1)			// Игрок умер сам (дединсайд)
#define PLAYER_DEATH_KILLER			(2)			// Игрока убил другой игрок

// Sex
#define SEX_MALE					(1)			// Мужчина
#define SEX_FEMALE					(2)			// Женщина

// Others
#define NameEx(%0)					pInfo[%0][pName]

#define SCM							SendClientMessage
#define SCMTA						SendClientMessageToAll
#define SCMF(%1,%2,%3)				stringer[0] = EOS, format(stringer, sizeof(stringer), %3), SendClientMessage(%1, %2, stringer)

#define GivePVarInt(%0,%1,%2)		SetPVarInt(%0,%1,(GetPVarInt(%0,%1) + %2))
#define publics%0(%1)				forward%0(%1); public%0(%1)
#define random_ex(%0,%1,%2)			%0 + (random((%1 - %0) / %2 + 1) * %2)
#define SetPlayerTimer(%0,%1,%2,%3)	SetTimerEx(%1,%2,%3,"i",%0)

#define n_for(%0,%1)				for(new %0 = 0, jjj = %1; %0 < jjj; %0++)
#define n_for2(%0,%1)				for(new %0 = 0, yyy = %1; %0 < yyy; %0++)
#define n_for3(%0,%1)				for(new %0 = 0, zzz = %1; %0 < zzz; %0++)
#define n_for4(%0,%1)				for(new %0 = 0, fff = %1; %0 < fff; %0++)
#define n_for5(%0,%1)				for(new %0 = 0, ggg = %1; %0 < ggg; %0++)

#define r_for(%0,%1)				for(new %0 = %1 - 1; %0 != -1; %0--)

#define f(%1,						format(%1,sizeof(%1),
#define INVALID_INTERFACE			(0)

// Replen
#define REPLEN_AMOUNT_OF_TEXT	(5)		// Количество текста в TD при получении опыта и кредитов

#define REPLEN_KILL				(1)		// Пополнение при убийстве противника
#define REPLEN_BAG_OF_CREDITS	(2)		// Пополнение при убийстве если у противника мешок с кредитами
#define REPLEN_CAPTURE			(3)		// Пополнение при захвате точки
#define REPLEN_ROUND			(4)		// Пополнение после раунда
#define REPLEN_HACK				(5)		// Пополнение при взлома компьютера
#define REPLEN_CAPTURE_FLAG		(6)		// Пополнение при захвате флага
#define REPLEN_TOKEN			(7)		// Пополнение при получения жетона
#define REPLEN_MEDIC_HP			(8)		// Пополнение при лечении другого игрока
#define REPLEN_ENGINEER_VEHICLE	(9)		// Пополнение при починке транспорта

// Busy (данная система немного устарела, редко юзается)
#define NONE					(0)		// Не занят
#define RUS						(1)		// Выбор русификатора
#define REG						(2)		// Регистрация
#define AUTHO					(3)		// Авторизация
#define GAME					(4)		// Игровой режим (игрок в игровом режиме)
#define ADMIN_PASS				(5)		// Админ пароль
#define REFERAL					(6)		// Пригласивший игрок
#define MAIN_MENU				(7)		// Главное меню

// States TextDraws
#define TD_DESTROYED		(0)		// Удалённый
#define TD_CREATED			(1)		// Созданный
#define TD_SHOWN			(2)		// Показанный
#define TD_HIDDEN			(3)		// Спрятанный

#define TD_CLICK_COLOR_GREY	0xAFAFAFAA

/*

	* Includes *

*/

/* 
	Headers
*/

// Game modes
#include <sources/game-modes/include-headers>

// Player
#include <sources/player/drop-weapons/header>
#include <sources/player/drop-tokens/header>
#include <sources/player/inventory/header>
#include <sources/player/quests/header>

// Others
#include <sources/admin/header>
#include <sources/vehicle/header>
#include <sources/weapon/header>

#include <sources/others/dina/header>
#include <sources/others/trading-platform/header>

/*

	* Enums *

*/

enum E_PLAYER_INFO {
	// MySQL data
	pID,
	pName[MAX_PLAYER_NAME],
	pPassword[65],
	pSalt[11],
	pSecondPassword[20],
	pReferal[MAX_PLAYER_NAME],
	pFoundServer,
	pIP[17],
	pOldIP[17],
	pSex,
	pRank,
	pExp,
	pCredit,
	pWarn,
	pGoldCoin,
	pKills,
	pDeaths,
	pWinRounds,
	pLossRounds,
	pShotsEnemy,
	pShotsHead,
	pSeriesKills,
	pHours,
	pMinutes,
	pPromoCode,
	pBDays,
	pBData,
	pInvItem[INV_PLAYER_MAX_ITEMS],
	pInvItemCount[INV_PLAYER_MAX_ITEMS],
	pInvBanner[INV_PLAYER_MAX_BANNERS],
	pInvBannerCount[INV_PLAYER_MAX_BANNERS],
	pAnimations[PLAYER_MAX_ANIMATIONS],
	pBlacklist[MAX_PLAYERS_IN_BLACKLIST],
	pPremium,
	pPremiumData,
	pNickColor[15],
	pData[120],
	pOldData[120],

	// No MySQL data
	pVirtualWorld,
	pInterior,
	pPlayerClass,
	pPlayerClass2,
	pMute,
	pColor,
	Float:pHealth,
	Float:pArmour
}

enum E_PLAYER_TD_REWARD_INFO {
	bool:REW_ActionTextAll,
	REW_ChetExpCredit[2],
	REW_Timer
}

enum E_PLAYER_MINIGAME_INFO {
	mg_Num,
	mg_Timer,
	mg_Count,
	mg_Value,
	mg_pTimer,
	mg_pTime
}

enum E_RANDOM_KEYS_INFO {
	RK_Key,
	RK_KeyStr[3]
}

enum (<<= 1)
{
	CMD_FLAG_ADMIN = 1,
	CMD_FLAG_MODE_NONE,
	CMD_FLAG_MODE_ROOM,
	CMD_FLAG_MODE_TDM,
	CMD_FLAG_MODE_DM
}

/*

	* Vars *

*/

new
	MySQL:MysqlID,

	stringer[2048],

	SRV_UpdateSecond,
	SRV_DailyPlayers,

	IndicatorPlayerHealth;

new
	pInfo[MAX_PLAYERS][E_PLAYER_INFO],
	pMG[MAX_PLAYERS][E_PLAYER_MINIGAME_INFO];

new
	Float:setX[MAX_PLAYERS],
	Float:setY[MAX_PLAYERS],
	Float:setZ[MAX_PLAYERS];

new
	TimerPlayerSpawn[MAX_PLAYERS],
	TimerPlayerClearAnim[MAX_PLAYERS],
	TimerPlayerFloodText[MAX_PLAYERS],
	TimerPlayerFreezingPos[MAX_PLAYERS],
	TimerPlayerUnFreezeCW[MAX_PLAYERS],
	ActionPlayerBelowHealth[MAX_PLAYERS],
	PlayerSkin[MAX_PLAYERS],
	CheckPlayerIDStats[MAX_PLAYERS],
	PlayerListFirstReferal[MAX_PLAYERS],
	CheckReferalName[MAX_PLAYERS][MAX_PLAYER_NAME],
	PlayerLoggedTimer[MAX_PLAYERS],
	PlayerRespawnTimer[MAX_PLAYERS],
	PlayerExitZoneTimer[MAX_PLAYERS],
	AFK_PlayerTime[MAX_PLAYERS],
	PlayerLastDrunkLevel[MAX_PLAYERS],
	PlayerAdsServer[MAX_PLAYERS],
	DialogListPlayerAnims[MAX_PLAYERS][PLAYER_MAX_ANIMATIONS],
	PlayerStyleMelee[MAX_PLAYERS],
	ActionPlayerDeadKiller[MAX_PLAYERS];

new
	bool:ActivePlayerClickTD[MAX_PLAYERS char],
	bool:ActionPlayerInvisible[MAX_PLAYERS char],
	bool:AntiC[MAX_PLAYERS char],
	bool:ActionPlayerAnimation[MAX_PLAYERS char],
	bool:ActionPlayerZone[MAX_PLAYERS char],
	bool:ActionPlayerExitZone[MAX_PLAYERS char],
	bool:ActionPlayerJetPack[MAX_PLAYERS char],
	bool:ActionPlayerSpectate[MAX_PLAYERS char];

new
	ActionPlayerFPSandPING[MAX_PLAYERS],
	ActionPlayerStatsRound[MAX_PLAYERS],
	ActionPlayerBarHealth[MAX_PLAYERS],
	ActionPlayerBarArmour[MAX_PLAYERS],
	PlayerTimerTDRank[MAX_PLAYERS],
	bool:ActionTDRank[MAX_PLAYERS char],
	bool:ActivePlayerTDRank[MAX_PLAYERS char];

new
	PlayerSpectating[MAX_PLAYERS],
	PlayerSpectatingStatus[MAX_PLAYERS];

new
	PlayerListBlackListCount[MAX_PLAYERS],
	PlayerListBlacklist[MAX_PLAYERS][10];

new
	bool:ActionPlayerLogged[MAX_PLAYERS char];

new
	bool:ActionPlayerKillStrike[MAX_PLAYERS char],
	PlayerChetKillStrike[MAX_PLAYERS],
	PlayerTimerKillStrike[MAX_PLAYERS];

new
	SecondPlayerTimer[MAX_PLAYERS],
	MinutePlayerTimer[MAX_PLAYERS],
	HourPlayerTimer[MAX_PLAYERS];

new
	TimerPlayerSpawnKill[MAX_PLAYERS],
	bool:ActionPlayerSpawnKill[MAX_PLAYERS char];

new
	TimerPlayerBeDamage[MAX_PLAYERS],
	bool:ActionPlayerBeDamage[MAX_PLAYERS char];

new
	bool:ActionPlayerFreeze[MAX_PLAYERS char],
	PlayerTimerFreeze[MAX_PLAYERS];

new
	player_check_playerid[MAX_PLAYERS];

new
	Iterator:spec_dead_playerid[MAX_PLAYERS]<MAX_PLAYERS>;

new
	PlayerBar:GangZoneCaptureBar[MAX_PLAYERS],
	PlayerBar:Bar_time_to_spawn[MAX_PLAYERS],
	PlayerBar:ComputerCaptureBar[MAX_PLAYERS],
	PlayerBar:BarHealth[MAX_PLAYERS],
	PlayerBar:BarArmour[MAX_PLAYERS];

new
	PlayerText:TD_TimerSpawnKill[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:TD_GangZone[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:TD_NewRank[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:TD_Dead[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:TD_ComputerHack[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:TD_PlayerKillStrike[MAX_PLAYERS] = {PlayerText:INVALID_TEXT_DRAW, ...},
	PlayerText:TD_ExitZone[MAX_PLAYERS][5],
	PlayerText:TD_DeadKiller[MAX_PLAYERS][17],
	PlayerText:TD_PlayerStatsRound[MAX_PLAYERS][3],
	PlayerText:TD_PlayerReward[MAX_PLAYERS][REPLEN_AMOUNT_OF_TEXT],
	PlayerText:TD_OpenCase[MAX_PLAYERS][3],
	PlayerText:TD_OpeningCase[MAX_PLAYERS][15],
	PlayerText:TD_FPS_and_PING[MAX_PLAYERS][3];

new
	Text:TD_LogoServer[3],
	Text:TD_BelowHealth[8],
	Text:TD_BlackStripe[2];

new
	ActionPlayerDead[MAX_PLAYERS],
	bool:ActionPlayerDamage[MAX_PLAYERS char],
	ActionPlayerBusy[MAX_PLAYERS],
	ActionPlayerTeam[MAX_PLAYERS],
	ActionPlayerWeatherID[MAX_PLAYERS],

	bool:ActiveCapabSpectating[MAX_PLAYERS char],
	PlayerAntiMoreKeys[MAX_PLAYERS];

new
	PlayerTDReward[MAX_PLAYERS][E_PLAYER_TD_REWARD_INFO],
	PlayerTextTDReward[MAX_PLAYERS][REPLEN_AMOUNT_OF_TEXT][500];

new const
	texts_after_death[MAX_TEXTS_AFTER_DEAD][50] = {
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

new const
	AnimPrice[49] = {
	/*0*/5000,
	/*1*/5000,
	/*2*/5000,
	/*3*/5000,
	/*4*/5000,
	/*5*/5000,
	/*6*/5000,
	/*7*/5000,
	/*8*/5000,
	/*9*/5000,
	/*10*/5000,
	/*11*/5000,
	/*12*/5000,
	/*13*/5000,
	/*14*/5000,
	/*15*/5000,
	/*16*/5000,
	/*17*/5000,
	/*18*/5000,
	/*19*/5000,
	/*20*/5000,
	/*21*/5000,
	/*22*/5000,
	/*23*/5000,
	/*24*/5000,
	/*25*/5000,
	/*26*/5000,
	/*27*/5000,
	/*28*/5000,
	/*29*/5000,
	/*30*/5000,
	/*31*/5000,
	/*32*/5000,
	/*33*/5000,
	/*34*/5000,
	/*35*/5000,
	/*36*/5000,
	/*37*/5000,
	/*38*/5000,
	/*39*/5000,
	/*40*/5000,
	/*41*/5000,
	/*42*/5000,
	/*43*/5000,
	/*44*/5000,
	/*45*/5000,
	/*46*/5000,
	/*47*/5000,
	/*48*/5000
};

new const
	AnimName[49][60] = {
	/*0*/"Ложиться #1",
	/*1*/"Читать RAP #1",
	/*2*/"Читать RAP #2",
	/*3*/"Сесть #1",
	/*4*/"Сесть #2",
	/*5*/"Поднять руки",
	/*6*/"Навести пушку",
	/*7*/"Ударить по попе",
	/*8*/"Положить цветы",
	/*9*/"Fuck Bich",
	/*10*/"Кунг-Фу #1",
	/*11*/"Поцеловать по мужски",
	/*12*/"Поцеловать по женски",
	/*13*/"Танец #1",
	/*14*/"Танец #2",
	/*15*/"Танец #3",
	/*16*/"Кунг-Фу #2",
	/*17*/"Остановить такси",
	/*18*/"Сесть #3",
	/*19*/"Сесть #4",
	/*20*/"Ложиться #2",
	/*21*/"Ложиться #3",
	/*22*/"Ложиться #4",
	/*23*/"Стойка АK-47",
	/*24*/"Стойка Deagle",
	/*25*/"Махать рукой",
	/*26*/"Устроить бунт",
	/*27*/"Позвать к себе",
	/*28*/"Упасть",
	/*29*/"Подняться",
	/*30*/"Поздароваться #1",
	/*31*/"Поздароваться #2",
	/*32*/"Поздароваться #3",
	/*33*/"Пить",
	/*34*/"Ударить с ноги",
	/*35*/"Задуматься",
	/*36*/"Сдаться",
	/*37*/"Толкнуть",
	/*38*/"Почесать яйца",
	/*39*/"Рисовать",
	/*40*/"Медик",
	/*41*/"Умирать",
	/*42*/"Прыгнуть",
	/*43*/"Перекатиться",
	/*44*/"Бокс",
	/*45*/"Читать RAP #3",
	/*46*/"You Nigga",
	/*47*/"Полежать",
	/*48*/"Танцевать на одной ноге"
};

new const 
	NamePointCapture[20][5] = {
	"A", "B", "C", "D", "E", "F",
	"G", "H", "I", "J", "K", "L",
	"M", "N", "O", "P", "Q", "R",
	"S", "T"
};

new const 
	name_squad[20][30] = {
	"Альфа", "Браво", "Чарли", "Дельта", "Эхо", "Фокстрот", "Оскар", "Хотель", "Сиерра", "Джулиет", 
	"Стрелок", "Непоседы", "Улыбка", "Смайлики", "Пингвины", "Червячки", "Торнадо", "Пупсы", "Интеграл", "Мамонты"
};

new const
	RandomKeys[RANDOM_KEYS_MAX_COUNT][E_RANDOM_KEYS_INFO] = {
		{65536, "Y"},
		{131072, "N"},
		{262144, "H"}
	},
	RandomColorText[RANDOM_COLOR_MAX_COUNT][5] = {
		{"~r~"},
		{"~g~"},
		{"~b~"},
		{"~w~"},
		{"~y~"},
		{"~p~"}
	};

new const
	Domains[][] = { 
		"ru", "com", "ру", "рф", "su", "net", "info", "pro", "org", "biz", "tel", "name", "xxx" 
	};

/*

	* Includes *

*/

/* 
	Systems
*/

// Game modes
#include <sources/game-modes/include-systems>

// Player
#include <sources/player/drop-weapons/system.pwn>
#include <sources/player/drop-tokens/system.pwn>
#include <sources/player/inventory/system.pwn>
#include <sources/player/quests/system.pwn>
#include <sources/player/daily-bonus.pwn>
#include <sources/player/second-password.pwn>

// Systems
#include <sources/admin/system.pwn>
#include <sources/anticheat/system.pwn>
#include <sources/vehicle/system.pwn>
#include <sources/weapon/system.pwn>
#include <sources/weapon/damage/system.pwn>

// Others
#include <sources/others/dina/system.pwn>
#include <sources/others/trading-platform/system.pwn>

/*

	* Callbacks *

*/

main()
{
	print("\n -----------------------");
	print(" "SERVER_NAME_CORE" loaded!");
	print(" Version: "SERVER_VERSION"");
	print(" By: Foxze");
	print(" -----------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("TDM DM PvP");
	SendRconCommand("name "SERVER_NAME_CORE"");
	SendRconCommand("website "SERVER_VK"");
	SendRconCommand("game.map Uprising");

	// Nex-ac
	EnableAntiCheat(12, 0);	// Health (onfoot)
	EnableAntiCheat(13, 0);	// Armour
	EnableAntiCheat(15, 0);	// Weapon
	EnableAntiCheat(27, 0);	// FakeSpawn
	EnableAntiCheat(28, 0);	// FakeKill
	EnableAntiCheat(38, 0);	// Ping

	// Weapon-config
	SetVehiclePassengerDamage(true);				// Уничтожение транспорта если там есть пассажир
	SetDisableSyncBugs(true);						// Улучшение синхронизации
	SetDamageFeed(false);							// Показ информации при дамаге
	SetVehicleUnoccupiedDamage(false);				// Уничтожать транспорт если там никого нет
	SetRespawnTime(3000);							// Время до респавна после смерти (не должно работать!)

	// Параметры игры
	ManualVehicleEngineAndLights();		// Убираем автоматическую заводку двигателя в транспорте
	DisableInteriorEnterExits();		// Убирает жёлтые стрелочки
	ShowNameTags(true);					// Показывает теги с именами игроков
	AllowInteriorWeapons(true);			// Разрешает использовать оружие в интерьерах
	EnableStuntBonusForAll(false);		// Убираем бонусы за трюки
	ShowPlayerMarkers(PLAYER_MARKERS_MODE_GLOBAL);
	SetNameTagDrawDistance(30.0);
	LimitPlayerMarkerRadius(1000.0);
	EnableVehicleFriendlyFire();

	SetIndicatorHealth(PLAYER_IND_HEALTH_WC);	// Индикатор здоровья у игроков

	// MySQL
	MysqlID = mysql_connect(MYSQL_HOST, MYSQL_USER, MYSQL_PASSWORD, MYSQL_DATABASE);
	mysql_set_charset("cp1251");
/*
	mysql_tquery(MysqlID, !"SET CHARACTER SET 'utf8'");
	mysql_tquery(MysqlID, !"SET NAMES 'utf8'");
	mysql_tquery(MysqlID, !"SET character_set_client = 'cp1251'");
	mysql_tquery(MysqlID, !"SET character_set_connection = 'cp1251'");
	mysql_tquery(MysqlID, !"SET character_set_results = 'cp1251'");
	mysql_tquery(MysqlID, !"SET SESSION collation_connection = 'utf8_general_ci'");
*/
	switch(mysql_errno()) {
		case 0: print("[mysql] Подключение к базе данных удалось");
		case 1044: print("[mysql] Подключение к базе данных не удалось [Указано неизвестное имя пользователя]");
		case 1045: print("[mysql] Подключение к базе данных не удалось [Указан неизвестный пароль]");
		case 1049: print("[mysql] Подключение к базе данных не удалось [Указана неизвестная база данных]");
		case 2003: print("[mysql] Подключение к базе данных не удалось [Хостинг с базой данных недоступен]");
		case 2005: print("[mysql] Подключение к базе данных не удалось [Указан неизвестный адрес хостинга]");
		default: printf("[mysql] Подключение к базе данных не удалось [Неизвестная ошибка. Код ошибки: %d]", mysql_errno());
	}

	// Objects
	Streamer_SetVisibleItems(STREAMER_TYPE_OBJECT, 4000, -1);
	LoadMapObjects();

	// Iterators
	Iter_Init(spec_dead_playerid);

	// TextDraw's

	// Logo
	TD_LogoServer[0] = TextDrawCreate(585.0000, 5.0000, "OFFENSIVE");
	TextDrawLetterSize(TD_LogoServer[0], 0.4329, 1.7201);
	TextDrawAlignment(TD_LogoServer[0], TEXT_DRAW_ALIGN_CENTER);
	TextDrawColour(TD_LogoServer[0], -136586497);
	TextDrawBackgroundColour(TD_LogoServer[0], 606348543);
	TextDrawFont(TD_LogoServer[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_LogoServer[0], true);
	TextDrawSetShadow(TD_LogoServer[0], 1);
	TextDrawSetOutline(TD_LogoServer[0], 0);

	TD_LogoServer[1] = TextDrawCreate(551.0000, 22.0000, "Box");
	TextDrawLetterSize(TD_LogoServer[1], 0.0000, 0.8999);
	TextDrawTextSize(TD_LogoServer[1], 620.0000, 0.0000);
	TextDrawAlignment(TD_LogoServer[1], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_LogoServer[1], 1130251775);
	TextDrawUseBox(TD_LogoServer[1], true);
	TextDrawBoxColor(TD_LogoServer[1], -646184705);
	TextDrawBackgroundColour(TD_LogoServer[1], 255);
	TextDrawFont(TD_LogoServer[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_LogoServer[1], true);
	TextDrawSetShadow(TD_LogoServer[1], 0);
	TextDrawSetOutline(TD_LogoServer[1], 0);

	TD_LogoServer[2] = TextDrawCreate(586.0000, 19.0000, "CORE");
	TextDrawLetterSize(TD_LogoServer[2], 0.2533, 1.3839);
	TextDrawAlignment(TD_LogoServer[2], TEXT_DRAW_ALIGN_CENTER);
	TextDrawColour(TD_LogoServer[2], -437918721);
	TextDrawBackgroundColour(TD_LogoServer[2], 16);
	TextDrawFont(TD_LogoServer[2], TEXT_DRAW_FONT_BANK_GOTHIC);
	TextDrawSetProportional(TD_LogoServer[2], true);
	TextDrawSetShadow(TD_LogoServer[2], 1);
	TextDrawSetOutline(TD_LogoServer[2], 0);

	// Black stripe
	TD_BlackStripe[0] = TextDrawCreate(0.000000, 0.000000, "_"); // Верхняя полоса
	TextDrawLetterSize(TD_BlackStripe[0], 0.000000, 3.799993);
	TextDrawTextSize(TD_BlackStripe[0], 645.000000, 0.000000);
	TextDrawAlignment(TD_BlackStripe[0], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BlackStripe[0], 0xFFFFFFFF);
	TextDrawUseBox(TD_BlackStripe[0], true);
	TextDrawBoxColor(TD_BlackStripe[0], 255);
	TextDrawSetShadow(TD_BlackStripe[0], 0);
	TextDrawSetOutline(TD_BlackStripe[0], 0);
	TextDrawBackgroundColour(TD_BlackStripe[0], 255);
	TextDrawFont(TD_BlackStripe[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_BlackStripe[0], true);

	TD_BlackStripe[1] = TextDrawCreate(0.000000, 400.000000, "_"); // Нижняя полоса
	TextDrawLetterSize(TD_BlackStripe[1], 0.000000, 5.233336);
	TextDrawTextSize(TD_BlackStripe[1], 645.333312, 0.000000);
	TextDrawAlignment(TD_BlackStripe[1], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BlackStripe[1], 0xFFFFFFFF);
	TextDrawUseBox(TD_BlackStripe[1], true);
	TextDrawBoxColor(TD_BlackStripe[1], 255);
	TextDrawSetShadow(TD_BlackStripe[1], 0);
	TextDrawSetOutline(TD_BlackStripe[1], 0);
	TextDrawBackgroundColour(TD_BlackStripe[1], 255);
	TextDrawFont(TD_BlackStripe[1], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_BlackStripe[1], true);

	// Игрок при смерти
	TD_BelowHealth[0] = TextDrawCreate(-14.000000, -2.000000, "_");
	TextDrawLetterSize(TD_BelowHealth[0], 0.000000, 52.933341);
	TextDrawTextSize(TD_BelowHealth[0], 650.000000, 0.000000);
	TextDrawAlignment(TD_BelowHealth[0], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[0], 80);
	TextDrawUseBox(TD_BelowHealth[0], true);
	TextDrawBoxColor(TD_BelowHealth[0], 48);
	TextDrawSetShadow(TD_BelowHealth[0], 0);
	TextDrawSetOutline(TD_BelowHealth[0], 0);
	TextDrawBackgroundColour(TD_BelowHealth[0], 255);
	TextDrawFont(TD_BelowHealth[0], TEXT_DRAW_FONT_AHARONI_BOLD);
	TextDrawSetProportional(TD_BelowHealth[0], true);

	TD_BelowHealth[1] = TextDrawCreate(235.000000, 118.000000, "particle:shad_heli");
	TextDrawLetterSize(TD_BelowHealth[1], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[1], 449.000000, -215.000000);
	TextDrawAlignment(TD_BelowHealth[1], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[1], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[1], 0);
	TextDrawSetOutline(TD_BelowHealth[1], 0);
	TextDrawBackgroundColour(TD_BelowHealth[1], 255);
	TextDrawFont(TD_BelowHealth[1], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[1], false);

	TD_BelowHealth[2] = TextDrawCreate(387.000000, 437.000000, "particle:shad_heli");
	TextDrawLetterSize(TD_BelowHealth[2], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[2], 427.000000, -126.000000);
	TextDrawAlignment(TD_BelowHealth[2], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[2], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[2], 0);
	TextDrawSetOutline(TD_BelowHealth[2], 0);
	TextDrawBackgroundColour(TD_BelowHealth[2], 255);
	TextDrawFont(TD_BelowHealth[2], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[2], false);

	TD_BelowHealth[3] = TextDrawCreate(-138.000000, 289.000000, "particle:shad_heli");
	TextDrawLetterSize(TD_BelowHealth[3], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[3], 476.000000, 113.000000);
	TextDrawAlignment(TD_BelowHealth[3], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[3], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[3], 0);
	TextDrawSetOutline(TD_BelowHealth[3], 0);
	TextDrawBackgroundColour(TD_BelowHealth[3], 255);
	TextDrawFont(TD_BelowHealth[3], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[3], false);

	TD_BelowHealth[4] = TextDrawCreate(460.000000, 176.000000, "particle:shad_ped");
	TextDrawLetterSize(TD_BelowHealth[4], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[4], 182.000000, 118.000000);
	TextDrawAlignment(TD_BelowHealth[4], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[4], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[4], 0);
	TextDrawSetOutline(TD_BelowHealth[4], 0);
	TextDrawBackgroundColour(TD_BelowHealth[4], 255);
	TextDrawFont(TD_BelowHealth[4], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[4], false);

	TD_BelowHealth[5] = TextDrawCreate(243.000000, 289.000000, "particle:shad_ped");
	TextDrawLetterSize(TD_BelowHealth[5], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[5], 248.000000, 124.000000);
	TextDrawAlignment(TD_BelowHealth[5], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[5], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[5], 0);
	TextDrawSetOutline(TD_BelowHealth[5], 0);
	TextDrawBackgroundColour(TD_BelowHealth[5], 255);
	TextDrawFont(TD_BelowHealth[5], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[5], false);

	TD_BelowHealth[6] = TextDrawCreate(71.000000, 133.000000, "particle:shad_ped");
	TextDrawLetterSize(TD_BelowHealth[6], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[6], 224.000000, 140.000000);
	TextDrawAlignment(TD_BelowHealth[6], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[6], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[6], 0);
	TextDrawSetOutline(TD_BelowHealth[6], 0);
	TextDrawBackgroundColour(TD_BelowHealth[6], 255);
	TextDrawFont(TD_BelowHealth[6], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[6], false);

	TD_BelowHealth[7] = TextDrawCreate(-158.000000, 156.000000, "particle:shad_heli");
	TextDrawLetterSize(TD_BelowHealth[7], 0.000000, 0.000000);
	TextDrawTextSize(TD_BelowHealth[7], 452.000000, -194.000000);
	TextDrawAlignment(TD_BelowHealth[7], TEXT_DRAW_ALIGN_LEFT);
	TextDrawColour(TD_BelowHealth[7], 0xFFFFFFFF);
	TextDrawSetShadow(TD_BelowHealth[7], 0);
	TextDrawSetOutline(TD_BelowHealth[7], 0);
	TextDrawBackgroundColour(TD_BelowHealth[7], 255);
	TextDrawFont(TD_BelowHealth[7], TEXT_DRAW_FONT_SPRITE);
	TextDrawSetProportional(TD_BelowHealth[7], false);

	Mode_OnGameModeInit();

	AntiDeAMX();

	SetTimer("SRV_Update", 1000, true);
	SetTimer("SRV_Update_2", 500, true);
	return 1;
}

public OnGameModeExit()
{
	new
		year,
		month,
		day;

	getdate(year, month, day);

	mysql_close(MysqlID);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
		return 1;

	if(GetPlayerLogged(playerid))
		return 0;

	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	if(IsPlayerNPC(playerid))
		return 1;

	SetSpawnInfo(playerid, 255, 0, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0);

	if(!GetPlayerLogged(playerid)) {
		if(GetPVarInt(playerid, "WC_RequestClass_PVar"))
			SpecPl(playerid, true);
		else
			TimerPlayerSpawn[playerid] = SetPlayerTimer(playerid, "PlayerSpawn", 200, false);

		return 0;
	}

	return 1;
}

public OnPlayerEnterDynamicCP(playerid, checkpointid)
{
	return 1;
}

public OnPlayerLeaveDynamicCP(playerid)
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	if(IsPlayerNPC(playerid))
		return 1;

	ResetPlayerGlobalVariables(playerid);
	ResetPlayerTDs(playerid);
	CreatePlayerTDs(playerid);

	GetPlayerIp(playerid, pInfo[playerid][pOldIP], 17);
	GetPlayerName(playerid, pInfo[playerid][pName], MAX_PLAYER_NAME);
	mysql_escape_string(pInfo[playerid][pName], pInfo[playerid][pName]);

	if(IsOIP(NameEx(playerid)) || IsODomen(NameEx(playerid))) {
		SCMF(playerid, COLOR_ERROR, "(Ошибка) {FFFF33}%s {FFFFFF}имеет рекламный ник [IP: {FFFF33}%s{FFFFFF}].", NameEx(playerid), pInfo[playerid][pOldIP]);

		KickEx(playerid);
		return 1;
	}

	// Logo
	n_for(i, sizeof(TD_LogoServer))
		TextDrawShowForPlayer(playerid, TD_LogoServer[i]);

	PreloadAllAnimLibs(playerid);

	// Check MySQL
	static
		str[200];

	str[0] = EOS;

	mysql_format(MysqlID, str, sizeof(str), "SELECT * FROM `"T_BANS"` WHERE BINARY `Name` = '%s'", NameEx(playerid));
	mysql_tquery(MysqlID, str, "CheckPlayerBan", "i", playerid);

	// Set data
	SetPlayerHealthEx(playerid, 100.0);
	SetPlayerArmourEx(playerid, 0.0);

	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 850, playerid);

	Mode_SetPlayerVirtualWorld(playerid, MODE_NONE, 0);
	Mode_SetPlayerInterior(playerid, MODE_NONE, 0);

	SetPlayerSkinEx(playerid, 0);
	SetPlayerTeamEx(playerid, 0);
	SetPlayerColorEx(playerid, 0xCCCCCC00);

	SetPlayerLogged(playerid, true);
	Mode_CreateLocationPlayer(playerid, MODE_NONE, 0);

	//PlayerPlaySoundEx(playerid, 1097, 0.0, 0.0, 0.0); // Залупа не вырубается потом

	SRV_DailyPlayers++;

	#include <sources/map-objects/destroyed-objects>
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(IsPlayerNPC(playerid))
		return 1;

	KillTimer(TimerPlayerSpawn[playerid]);
	KillTimer(TimerPlayerClearAnim[playerid]);
	KillTimer(TimerPlayerFreezingPos[playerid]);
	KillTimer(TimerPlayerUnFreezeCW[playerid]);
	KillTimer(PlayerLoggedTimer[playerid]);
	KillTimer(pMG[playerid][mg_pTimer]);

	if(GetPlayerFreeze(playerid)) {
		UnFreeze(playerid, true);
		KillTimer(PlayerTimerFreeze[playerid]);
	}

	if(Adm_IsAdminsSpecPlayer(playerid)) {
		foreach(new p:spec_admin_playerid[playerid]) {
			Adm_HidePlayerSpectating(p, false);
			SCM(p, -1, "{CC0033}(Слежка) {FFFFFF}Игрок вышел из сервера.");
		}
		Adm_StopPlayersSpectating(playerid);
	}

	SetPVarInt(playerid, "Room_Exit_PVar", 1);
	if(Adm_GetPlayerSpectating(playerid))
		Adm_HidePlayerSpectating(playerid);
	else 
		Mode_DestroyLocationPlayer(playerid);

	if(Adm_GetPlayerLevel(playerid) > 0)
		Iter_Remove(admin_players, playerid);

	ResetPlayerMG(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(!PermissionPlayerSpawn{playerid}) {
		PermissionPlayerSpawn{playerid} = true;
		return 1;
	}
		
	PreloadAllAnimLibs(playerid);
	SetPlayerStylesMelee(playerid);

	SetPlayerPosEx(playerid, setX[playerid], setY[playerid], setZ[playerid],
	GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));

	Mode_OnPlayerSpawn(playerid);

	if(GetPlayerCarabSpectating(playerid))
		SetPlayerCarabSpectating(playerid, false);

	if(Adm_IsAdminsSpecPlayer(playerid)) 
		Adm_UpdateSpectating(playerid);

	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	AntiCheatSetDeathState(playerid, 1);

	Veh_DeathPlayer(playerid, killerid, reason);

	if(GetPlayerDead(playerid))
		return 1;

	SetPlayerCarabSpectating(playerid, true);
	SetPlayerDeath(playerid, 1);

	if(GetPlayerAnimationEx(playerid))
		SetPlayerAnimationEx(playerid, false);

	Mode_OnPlayerDeath(playerid, killerid, reason);
	return 1;
}

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

public OnPlayerText(playerid, text[])
{
	if(GetPlayerLogged(playerid))
		return 0;

	if(pInfo[playerid][pMute] > gettime()) {
		SCM(playerid, -1, "{CC0033}(Чат) {FFFFFF}У вас мут чата!");
		return 0;
	}
	if(TimerPlayerFloodText[playerid] > gettime()) {
		SCM(playerid, -1, "{CC0033}(Анти-Флуд) {FFFFFF}Не флуди!");
		return 0;
	}
	if(IsOIP(text)) {
		SCM(playerid, -1, "{CC0033}(Чат) {FFFFFF}Подозрение на рекламу!");
		return 0;
	}
	if(strlen(text) > 90) {
		SCM(playerid, -1, "{CC0033}(Чат) {FFFFFF}Больше 90 символов запрещено вводить!");
		return 0;
	}

	if(Mode_OnPlayerText(playerid, text))
		return 0;

	Mode_SendText(playerid, text);

	if(!GetPlayerAnimationEx(playerid)) {
		ApplyAnimation(playerid, "PED", "IDLE_CHAT", 4.1, 0, 1, 1, 1, 1, 1);
		StartPlayerTimerClearAnim(playerid, 100 * strlen(text));
	}

	SetPlayerAntiFloodChat(playerid);
	return 0;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerCommandReceived(playerid, cmd[], params[], flags)
{
	if(GetPlayerLogged(playerid))
		return 0;

	if(GetPlayerDead(playerid))
		return 0;

	if((flags & CMD_FLAG_ADMIN) && !Adm_GetPlayerLevel(playerid))
		return Adm_ErrorTextForPlayer(playerid);

	if((flags & CMD_FLAG_MODE_NONE) && Mode_GetPlayer(playerid) != MODE_NONE)
		return Mode_ErrorTextCMD(playerid, MODE_NONE);

	if((flags & CMD_FLAG_MODE_ROOM) && Mode_GetPlayer(playerid) != MODE_ROOM)
		return Mode_ErrorTextCMD(playerid, MODE_ROOM);

	if((flags & CMD_FLAG_MODE_TDM) && Mode_GetPlayer(playerid) != MODE_TDM)
		return Mode_ErrorTextCMD(playerid, MODE_TDM);

	if((flags & CMD_FLAG_MODE_DM) && Mode_GetPlayer(playerid) != MODE_DM)
		return Mode_ErrorTextCMD(playerid, MODE_DM);

	if(Dialog_IsOpen(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}В открытом диалоге запрещено вводить команды.");
		return 0;
	}
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmd[], params[], result, flags)
{
	if(GetPlayerLogged(playerid))
		return 0;

	if(GetPlayerDead(playerid))
		return 0;

	if(result == -1) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данной команды нет на сервере.");
		return 0;
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
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

public OnRconCommand(cmd[])
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpDynamicPickup(playerid, pickupid)
{
	if(Mode_OnPlPickUpDynamicPickup(playerid, pickupid))
		return 1;

	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
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

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(GetClickedID(clickedid) == INVALID_TEXT_DRAW) {
		if(Adm_GetPlayerSpectating(playerid)) {
			if(GetPlayerClickTD(playerid)) {
				SetPlayerClickTD(playerid, false);
				CancelSelectTextDraw(playerid);
			}
			return 1;
		}
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	if(Mode_OnPlayerClickPTextDraw(playerid, playertextid))
		return 1;

	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(Adm_GetPlayerSpectating(playerid)) {
		if(newkeys & KEY_FIRE) {
			SetPlayerClickTD(playerid, true);
			SelectTextDraw(playerid, TD_CLICK_COLOR_GREY);
		}
		return 1;
	}

	if(Mode_OnPlayerKeyStateChange(playerid, newkeys, oldkeys))
		return 1;

	// ENTER
	if(newkeys & KEY_SECONDARY_ATTACK) {
		if(GetPlayerAnimationEx(playerid)) {
			SetPlayerAnimationEx(playerid, false);
			StartPlayerTimerClearAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}

	// SPACE
	if(newkeys & KEY_SPRINT) {
		if(GetPlayerAnimationEx(playerid)) {
			SetPlayerAnimationEx(playerid, false);
			StartPlayerTimerClearAnim(playerid);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		}
	}

	// Y
	if(newkeys & KEY_YES) {
		if(GetPlayerBusy(playerid) == GAME) {
			if(!IsPlayerInAnyVehicle(playerid))
				Dialog_Show(playerid, Dialog:PlayerListAnimations);
		}
	}

	if(newkeys & KEY_FIRE) {
		// Таймер респавна
		if(GetPlayerDead(playerid) == PLAYER_DEATH_KILLER)
			Mode_SetAddSpeedRespawn(playerid);
	}

	// Стрельба из снайперки
	if(GetPVarInt(playerid, "Body_PVar")) {
		if(GetPlayerWeapon(playerid) == 34) {
			if(oldkeys & KEY_LEFT) {
				DeletePVar(playerid, "Body_PVar");

				if(!IsPlayerAttachedObjectSlotUsed(playerid, 0)) {
					if(Inv_GetPlayerHead(playerid))
						GiveAttachPlayerItem(playerid, Inv_GetPlayerHead(playerid));

					TDM_PlayerClassAttachHead(playerid);
				}

				if(!IsPlayerAttachedObjectSlotUsed(playerid, 2)) {
					if(Inv_GetPlayerGlasses(playerid))
						GiveAttachPlayerItem(playerid, Inv_GetPlayerGlasses(playerid));
				}
				if(!IsPlayerAttachedObjectSlotUsed(playerid, 3)) {
					if(Inv_GetPlayerMask(playerid))
						GiveAttachPlayerItem(playerid, Inv_GetPlayerMask(playerid));
				}
			}
		}
	}
	else {
		if(GetPlayerWeapon(playerid) == 34) {
			if(newkeys & KEY_LEFT) {
				if(IsPlayerAttachedObjectSlotUsed(playerid, 0)
				|| IsPlayerAttachedObjectSlotUsed(playerid, 2)
				|| IsPlayerAttachedObjectSlotUsed(playerid, 3)) {

					SetPVarInt(playerid, "Body_PVar", 1);

					if(IsPlayerAttachedObjectSlotUsed(playerid, 0))
						RemovePlayerAttachedObject(playerid, 0);

					if(IsPlayerAttachedObjectSlotUsed(playerid, 2))
						RemovePlayerAttachedObject(playerid, 2);

					if(IsPlayerAttachedObjectSlotUsed(playerid, 3))
						RemovePlayerAttachedObject(playerid, 3);
				}
			}
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(!GetPlayerDead(playerid)) {
		if(!Adm_GetPlayerSpectating(playerid)) {
			if(GetIndicatorHealth() == PLAYER_IND_HEALTH_CUSTOM) {
				if(ActionPlayerBarHealth[playerid] == TD_SHOWN) {
					new
						Float:health;

					GetPlayerHealthEx(playerid, health);
					SetPlayerProgressBarValue(playerid, BarHealth[playerid], health);
				}
				if(ActionPlayerBarArmour[playerid] != TD_DESTROYED) {
					new
						Float:armour;

					GetPlayerArmourEx(playerid, armour);

					if(armour <= 0.0) {
						if(ActionPlayerBarArmour[playerid] != TD_HIDDEN)
							DestroyBarPlayerArmour(playerid);
					}
					else {
						if(ActionPlayerBarArmour[playerid] != TD_SHOWN)
							ShowBarPlayerArmour(playerid);

						SetPlayerProgressBarValue(playerid, BarArmour[playerid], armour);
					}
				}
			}
		}
	}

	AFK_PlayerTime[playerid] = -2;
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

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(Dialog_IsOpen(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}В открытом диалоге запрещено выбирать игроков.");
		return 1;
	}

	if(GetPlayerLogged(playerid))
		return 1;

	if(playerid == clickedplayerid)
		return 1;

	SetPVarInt(playerid, "ClickPlayerName_PVar", clickedplayerid);
	Dialog_Show(playerid, Dialog:ClickOnPlayerInTAB);
	return 1;
}

public OnPlayerDamage(&playerid, &Float:amount, &issuerid, &weapon, &bodypart)
{
	if(!Damage_OnPlayerDamage(playerid, Float:amount, issuerid, weapon, bodypart))
		return 1;

	Mode_OnPlayerDamage(playerid, Float:amount, issuerid, weapon, bodypart);
	return 1;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

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

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(!GetPlayerLogged(playerid))
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);

	return 1;
}

/*

	* Functions *

*/

stock IsPlayerInvalided(playerid)
{
	if(playerid == INVALID_PLAYER_ID || !IsPlayerConnected(playerid))
		return 0;

	return 1;
}

stock SetPlayerLogged(playerid, bool:logged)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	ActionPlayerLogged{playerid} = logged;
	return 1;
}

stock GetPlayerLogged(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	return ActionPlayerLogged{playerid};
}

stock PlayerSpawn(playerid)
{
	if(IsPlayerNPC(playerid))
		return 0;
		
	if(!IsPlayerInvalided(playerid))
		return 0;

	if(IsPlayerInAnyVehicle(playerid)) {
		new
			Float:X,
			Float:Y, 
			Float:Z;

		GetPlayerPos(playerid, X, Y, Z);
		SetPlayerPosEx(playerid, X, Y, Z, GetPlayerVirtualWorldEx(playerid), GetPlayerInteriorEx(playerid));
		TimerPlayerSpawn[playerid] = SetPlayerTimer(playerid, "PlayerSpawn", 50, false);
	}
	else {
		if(GetSpecPl(playerid))
			SpecPl(playerid, false);
		else
			SpawnPlayer(playerid);
	}
	return 1;
}

stock SetSpawnInfoEx(playerid, skin, Float:x, Float:y, Float:z, Float:angle)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	setX[playerid] = x;
	setY[playerid] = y;
	setZ[playerid] = z;

	SetSpawnInfo(playerid, GetPlayerTeamEx(playerid), skin, x, y, z, angle, -1, -1, -1, -1, -1, -1);
	return 1;
}

stock SetPlayerPosEx(playerid, Float:x, Float:y, Float:z, sp_world, sp_interior, setUP = false, freezing = false)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	if(!setUP) {
		if(GetPlayerVirtualWorldEx(playerid) != sp_world)
			SetPlayerVirtualWorldEx(playerid, sp_world);

		if(GetPlayerInteriorEx(playerid) != sp_interior)
			SetPlayerInteriorEx(playerid, sp_interior);
	}

	SetPlayerPos(playerid, x, y, z);

	if(freezing) {
		SetPlayerDamage(playerid, false);
		TogglePlayerControllable(playerid, false);
		TimerPlayerFreezingPos[playerid] = SetPlayerTimer(playerid, "PlayerFreezingPos", 1000, false);
	}
	return 1;
}

stock DestroyPlayerAttachedObjects(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	n_for(i, MAX_PLAYER_ATTACHED_OBJECTS) {
		if(IsPlayerAttachedObjectSlotUsed(playerid, i))
			RemovePlayerAttachedObject(playerid, i);
	}

	return 1;
}

stock DeaglePlayerAntiC(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	switch(GetPlayerWeapon(playerid)) {
		case 24: {
			ApplyAnimation(playerid, "PED", "getup_front", 4.0, 0, 0, 1, 0, 0);
			AntiC{playerid} = false;
			TimerPlayerUnFreezeCW[playerid] = SetPlayerTimer(playerid, "UnfreezeCw", 500, false);
		}
	}
	return 1;
}

stock SetPlayerColorEx(playerid, color)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	if(strcmp(pInfo[playerid][pNickColor], "No Color", true)) {
		if(!GetPlayerLogged(playerid)) {
			pInfo[playerid][pColor] = HexToInt(HEXResultColor(pInfo[playerid][pNickColor], 1));
			SetPlayerColor(playerid, HexToInt(HEXResultColor(pInfo[playerid][pNickColor], 1)));
		}
	}
	else {
		pInfo[playerid][pColor] = color;
		SetPlayerColor(playerid, color);
	}
	return 1;
}

stock GetPlayerColorEx(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	return pInfo[playerid][pColor];
}

stock SpecPl(playerid, bool:spec)
{
	ActionPlayerSpectate{playerid} = spec;
	TogglePlayerSpectating(playerid, spec);
}

stock GetSpecPl(playerid)
{
	return ActionPlayerSpectate{playerid};
}

stock SetPlayerTeamEx(playerid, team)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	ActionPlayerTeam[playerid] = team;
	SetPlayerTeam(playerid, team);
	return 1;
}

stock GetPlayerTeamEx(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	return ActionPlayerTeam[playerid];
}

stock SetPlayerHealthEx(playerid, Float:health)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	if(health < 0.0)
		health = 0.0;

	else if(health > 100.0)
		health = 100.0;

	if(SetPlayerHealth(playerid, health))
		pInfo[playerid][pHealth] = health;

	return 1;
}

stock GetPlayerHealthEx(playerid, &Float:health)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	GetPlayerHealth(playerid, health);
	return 1;
}

stock SetPlayerArmourEx(playerid, Float:armour)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	if(armour < 0.0)
		armour = 0.0;

	else if(armour > 100.0)
		armour = 100.0;

	if(SetPlayerArmour(playerid, armour))
		pInfo[playerid][pArmour] = armour;

	return 1;
}

stock GetPlayerArmourEx(playerid, &Float:armour)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	GetPlayerArmour(playerid, armour);
	return 1;
}

stock SetPlayerSkinEx(playerid, skinid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	PlayerSkin[playerid] = skinid;
	SetPlayerSkin(playerid, skinid);
	return 1;
}

stock GetPlayerSkinEx(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	return PlayerSkin[playerid];
}

stock SetPlayerStyleMelee(playerid, style)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	PlayerStyleMelee[playerid] = style;
	SetPlayerFightingStyle(playerid, style);
	return 1;
}

stock GetPlayerStyleMelee(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	return PlayerStyleMelee[playerid];
}

stock SetPlayerStylesMelee(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	switch(GetPlayerStyleMelee(playerid)) {
		case FIGHT_STYLE_NORMAL: SetPlayerFightingStyle(playerid, FIGHT_STYLE_NORMAL);
		case FIGHT_STYLE_BOXING: SetPlayerFightingStyle(playerid, FIGHT_STYLE_BOXING);
		case FIGHT_STYLE_KUNGFU: SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
		case FIGHT_STYLE_KNEEHEAD: SetPlayerFightingStyle(playerid, FIGHT_STYLE_KNEEHEAD);
		case FIGHT_STYLE_GRABKICK: SetPlayerFightingStyle(playerid, FIGHT_STYLE_GRABKICK);
		case FIGHT_STYLE_ELBOW: SetPlayerFightingStyle(playerid, FIGHT_STYLE_ELBOW);
	}
	return 1;
}

stock SetPlayerGoldCoins(playerid, goldcoins, bool:text = false)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	pInfo[playerid][pGoldCoin] += goldcoins;

	if(text) {
		new
			string[300];

		f(string, "{15cf51}(Пополнение) {FFFFFF}Получено {e8c609}%i {FFFFFF}Gold coins", goldcoins);
		SCM(playerid, -1, string);
	}

	SavePlayerGoldCoins(playerid);
	return 1;
}

stock GetPlayerGoldCoins(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	return pInfo[playerid][pGoldCoin];
}

stock SetPlayerCredit(playerid, credit, bool:text = false)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	pInfo[playerid][pCredit] = pInfo[playerid][pCredit] + credit;

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, pInfo[playerid][pCredit]);

	if(text) {
		new
			string[300],
			dNameMoney[20];

		switch(credit) {
			case 1: dNameMoney = "кредит";
			case 2..5: dNameMoney = "кредита";
			default: dNameMoney = "кредитов";
		}
		f(string, "{15cf51}(Пополнение) {FFFFFF}Получено {e8c609}%i {FFFFFF}%s", credit, dNameMoney);
		SCM(playerid, -1, string);
	}

	SavePlayerCredit(playerid);
	return 1;
}

stock GetPlayerCredits(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	return pInfo[playerid][pCredit];
}

stock SetPlayerRank(playerid, rank, bool:text = false)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	pInfo[playerid][pRank] = pInfo[playerid][pRank] + rank;
	SetPlayerScore(playerid, pInfo[playerid][pRank]);

	if(GetPlayerRank(playerid) == 15) {
		if(!strcmp(pInfo[playerid][pReferal], "No Referal", true)) {
			new
				query_string[100];

			mysql_format(MysqlID, query_string, sizeof(query_string), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s'", pInfo[playerid][pReferal]);
			mysql_tquery(MysqlID, query_string, "UpdateAccountReferal", "i", playerid);
		}
	}

	if(text) {
		new
			string[100];

		f(string, "{15cf51}(Ранг) {FFFFFF}Получен {FFFF33}%i {FFFFFF}ранг.", GetPlayerRank(playerid));
		SCM(playerid, -1, string);
	}

	SavePlayerRankExp(playerid);
	return 1;
}

stock GetPlayerRank(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	return pInfo[playerid][pRank];
}

stock CheckPlayerNextRank(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	if(GetPlayerRank(playerid) > 0 && GetPlayerRank(playerid) < 4)
		return GetPlayerRank(playerid) * 100 + 1500;

	else if(GetPlayerRank(playerid) > 3 && GetPlayerRank(playerid) < 15)
		return GetPlayerRank(playerid) * 1000;

	else if(GetPlayerRank(playerid) > 14)
		return GetPlayerRank(playerid) * 2000;

	return 1;
}

stock GetPlayerExp(playerid)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	return pInfo[playerid][pExp];
}

stock SetPlayerExp(playerid, exp, bool:text = false, bool:roundpoints = true)
{
	if(!IsPlayerInvalided(playerid))
		return 0;

	if(roundpoints)
		Mode_SetPlayerExp(playerid, exp);

	if(GetPlayerPremium(playerid) > 0)
		pInfo[playerid][pExp] = pInfo[playerid][pExp] + (exp * 2);
	else
		pInfo[playerid][pExp] = pInfo[playerid][pExp] + exp;

	if(text) {
		new
			string[100];
		
		f(string, "{15cf51}(Опыт) {FFFFFF}Получено {FFFF33}%i {FFFFFF}опыта.", exp);
		SCM(playerid, -1, string);
	}

	if(GetPlayerExp(playerid) >= CheckPlayerNextRank(playerid)) {
		pInfo[playerid][pExp] = 0;
		SetPlayerRank(playerid, 1, true);
		CreatePlayerNewRank(playerid);
		PlayerPlaySoundEx(playerid, 5203, 0.0, 0.0, 0.0);
	}

	SavePlayerRankExp(playerid);
	return 1;
}

stock SetPlayerVirtualWorldEx(playerid, world_id)
{
	pInfo[playerid][pVirtualWorld] = world_id;
	SetPlayerVirtualWorld(playerid, world_id);
	return 1;
}

stock GetPlayerVirtualWorldEx(playerid)
{
	return pInfo[playerid][pVirtualWorld];
}

stock SetPlayerInteriorEx(playerid, interior_id)
{
	pInfo[playerid][pInterior] = interior_id;
	SetPlayerInterior(playerid, interior_id);
	return 1;
}

stock GetPlayerInteriorEx(playerid)
{
	return pInfo[playerid][pInterior];
}

stock SetPlayerSex(playerid, type)
{
	pInfo[playerid][pSex] = type;
	return 1;
}

stock GetPlayerSex(playerid)
{
	return pInfo[playerid][pSex];
}

stock SetPlayerDead(playerid, num)
{
	ActionPlayerDead[playerid] = num;
	return 1;
}

stock GetPlayerDead(playerid)
{
	return ActionPlayerDead[playerid];
}

stock SetPlayerDamage(playerid, bool:type)
{
	ActionPlayerDamage{playerid} = type;
	return 1;
}

stock GetPlayerDamage(playerid)
{
	return ActionPlayerDamage{playerid};
}

stock SetPlayerAnimationEx(playerid, bool:type)
{
	ActionPlayerAnimation{playerid} = type;
	return 1;
}

stock GetPlayerAnimationEx(playerid)
{
	return ActionPlayerAnimation{playerid};
}

// Переменная и функция для разных ситуаций

stock SetPlayerBusy(playerid, type)
{
	ActionPlayerBusy[playerid] = type;
	return 1;
}

stock GetPlayerBusy(playerid)
{
	return ActionPlayerBusy[playerid];
}

//

stock SetPlayerWeatherEx(playerid, weather_id)
{
	ActionPlayerWeatherID[playerid] = weather_id;
	SetPlayerWeather(playerid, weather_id);
	return 1;
}

stock GetPlayerWeatherEx(playerid)
{
	return ActionPlayerWeatherID[playerid];
}

/*

	* Others *

*/

stock SetPlayerFreeze(playerid, time = 1, bool:freeze = true)
{
	if(time < 0)
		time = 0;

	if(ActionPlayerFreeze{playerid}) {
		UnFreeze(playerid, true);
		KillTimer(PlayerTimerFreeze[playerid]);
	}

	ActionPlayerFreeze{playerid} = true;
	TogglePlayerControllable(playerid, false);
	PlayerTimerFreeze[playerid] = SetTimerEx("UnFreeze", time * 1000, false, "ii", playerid, freeze);
	return 1;
}

stock GetPlayerFreeze(playerid)
{
	return ActionPlayerFreeze{playerid};
}

publics UnFreeze(playerid, bool:freeze)
{
	ActionPlayerFreeze{playerid} = false;

	if(freeze)
		TogglePlayerControllable(playerid, true);

	return 1;
}

stock GetPlayerWinRounds(playerid)
{
	return pInfo[playerid][pWinRounds];
}

stock SetPlayerWinRound(playerid, rounds)
{
	pInfo[playerid][pWinRounds] = pInfo[playerid][pWinRounds] + rounds;
	SavePlayerRounds(playerid);
	return 1;
}

stock GetPlayerLossRounds(playerid)
{
	return pInfo[playerid][pLossRounds];
}

stock SetPlayerLossRound(playerid, rounds)
{
	pInfo[playerid][pLossRounds] = pInfo[playerid][pLossRounds] + rounds;
	SavePlayerRounds(playerid);
	return 1;
}

stock GetPlayerShotsEnemy(playerid)
{
	return pInfo[playerid][pShotsEnemy];
}

stock SetPlayerShotEnemy(playerid, shot)
{
	pInfo[playerid][pShotsEnemy] = pInfo[playerid][pShotsEnemy] + shot;
	SavePlayerShotsEnemy(playerid);
	return 1;
}

stock GetPlayerShotsHead(playerid)
{
	return pInfo[playerid][pShotsHead];
}

stock SetPlayerShotHead(playerid, shot)
{
	pInfo[playerid][pShotsHead] = pInfo[playerid][pShotsHead] + shot;
	SavePlayerShotsHead(playerid);
	return 1;
}

stock GetPlayerSeriesKills(playerid)
{
	return pInfo[playerid][pSeriesKills];
}

stock SetPlayerSeriesKill(playerid, kills)
{
	pInfo[playerid][pSeriesKills] = kills;

	SavePlayerSeriesKills(playerid);
	return 1;
}

stock GetPlayerKills(playerid)
{
	return pInfo[playerid][pKills];
}

stock SetPlayerKill(playerid, kills)
{
	pInfo[playerid][pKills] = pInfo[playerid][pKills] + kills;
	TDM_SetPlayerClassKill(playerid, kills);

	SavePlayerKillsDeaths(playerid);
	return 1;
}

stock GetPlayerDeaths(playerid)
{
	return pInfo[playerid][pDeaths];
}

stock SetPlayerDeath(playerid, deaths)
{
	pInfo[playerid][pDeaths] = pInfo[playerid][pDeaths] + deaths;
	TDM_SetPlayerClassDeaths(playerid, deaths);

	SavePlayerKillsDeaths(playerid);
	return 1;
}

// Возможность начать слежку

stock SetPlayerCarabSpectating(playerid, bool:type)
{
	ActiveCapabSpectating[playerid] = type;
	return 1;
}

stock GetPlayerCarabSpectating(playerid)
{
	return ActiveCapabSpectating[playerid];
}

//

stock SetPlayerAntiKeys(playerid, keys)
{
	PlayerAntiMoreKeys[playerid] = keys;
	return 1;
}

stock GetPlayerAntiKeys(playerid)
{
	return PlayerAntiMoreKeys[playerid];
}

stock SetPlayerInvisible(playerid, bool:type)
{
	ActionPlayerInvisible{playerid} = type;
	return 1;
}

stock GetPlayerInvisible(playerid)
{
	return ActionPlayerInvisible{playerid};
}

stock SetPlayerKillStrike(playerid, num)
{
	if(num > 0)
		PlayerChetKillStrike[playerid] += num;
	else 
		PlayerChetKillStrike[playerid] = 0;

	return 1;
}

stock GetPlayerKillStrike(playerid)
{
	return PlayerChetKillStrike[playerid];
}

stock GetNamePoint(num)
{
	new
		str[5];

	strcat(str, NamePointCapture[num]);
	return str;
}

stock GetNameSquad(num)
{
	new
		str[30];

	strcat(str, name_squad[num]);
	return str;
}

stock SetPlayerZone(playerid, bool:type)
{
	ActionPlayerZone{playerid} = type;
	return 1;
}

stock GetPlayerZone(playerid)
{
	return ActionPlayerZone{playerid};
}

stock SetPlayerClickTD(playerid, bool:type)
{
	ActivePlayerClickTD{playerid} = type;
	return 1;
}

stock GetPlayerClickTD(playerid)
{
	return ActivePlayerClickTD{playerid};
}

stock SetPlayerpID(playerid, num)
{
	pInfo[playerid][pID] = num;
	return 1;
}

stock GetPlayerpID(playerid)
{
	return pInfo[playerid][pID];
}

/*
	Premium
*/

stock SetPlayerPremium(playerid, num)
{
	pInfo[playerid][pPremium] = num;
	return 1;
}

stock GetPlayerPremium(playerid)
{
	return pInfo[playerid][pPremium];
}

stock SetPlayerPremiumData(playerid, num)
{
	pInfo[playerid][pPremiumData] = num;
	return 1;
}

stock GetPlayerPremiumData(playerid)
{
	return pInfo[playerid][pPremiumData];
}

stock SetPlayerCheckPlayerid(playerid, check_player)
{
	player_check_playerid[playerid] = check_player;
	return 1;
}

stock GetPlayerCheckPlayerid(playerid)
{
	return player_check_playerid[playerid];
}

/*
	Logged timer
*/

stock SetPlayerLoggedTimer(playerid, seconds)
{
	PlayerLoggedTimer[playerid] = SetPlayerTimer(playerid, "Call_PlayerLoggedTimer", seconds, false);
	return 1;
}

stock KillPlayerLoggedTimer(playerid)
{
	KillTimer(PlayerLoggedTimer[playerid]);
	return 1;
}

publics Call_PlayerLoggedTimer(playerid)
{
	SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Время истекло.");
	KickEx(playerid);
	return 1;
}

stock SetCheckNameReferal(playerid, const name[])
{
	CheckReferalName[playerid][0] = EOS;
	strcat(CheckReferalName[playerid], name);
	return 1;
}

stock InformationTextCMD(playerid, const text[])
{
	new
		string[150];

	f(string, "{CC0033}(Информация) {FFFFFF}Введите: {e3ca25}%s", text);
	SCM(playerid, -1, string);
	return 1;
}

stock SetErrorText(playerid, text[])
{
	SetPVarString(playerid, "ErrorText_PVar", text);
	return 1;
}

stock Name(playerid)
{
	new
		name[MAX_PLAYER_NAME];

	GetPlayerName(playerid, name, MAX_PLAYER_NAME);
	return name;
}

stock IsPlayerInArea(playerid, Float:min_x, Float:min_y ,Float:max_x, Float:max_y)
{
	new
		Float:X,
		Float:Y,
		Float:Z;

	GetPlayerPos(playerid, X, Y, Z);
	if(X <= max_x && X >= min_x && Y <= max_y && Y >= min_y)
		return 1;
	
	return 0;
}

stock GetPlayerSpeed(playerid)
{
	new
		Float:ST1[4];

	GetPlayerVelocity(playerid,ST1[0],ST1[1],ST1[2]);
	ST1[3] = floatsqroot(floatpower(floatabs(ST1[0]), 2.0) + floatpower(floatabs(ST1[1]), 2.0) + floatpower(floatabs(ST1[2]), 2.0)) * 1000;

	return floatround(ST1[3]);
}

stock GetPlayerFPS(playerid)
{
	new
		drunk2 = GetPlayerDrunkLevel(playerid);

	if(drunk2 < 100)
		SetPlayerDrunkLevel(playerid, 2000);
	else {
		if(PlayerLastDrunkLevel[playerid] != drunk2) {
			new
				fps = PlayerLastDrunkLevel[playerid] - drunk2;

			PlayerLastDrunkLevel[playerid] = drunk2;

			if((fps > 0) && (fps < 256))
				return fps - 1;
		}
	}
	return 0;
}

stock GetPlayerID(const name[], id)
{
	return sscanf(name, "u", id);
}

stock GetNameID(const name[])
{
	new
		ID = INVALID_PLAYER_ID;

	sscanf(name, "u", ID);

	if(IsPlayerOnServer(ID))
		return ID;

	return INVALID_PLAYER_ID;
}

stock GetString(param1[], param2[])
{
	return !strcmp(param1, param2, false);
}

stock IsCh(num)
{
	if(num % 2 == 0)
		return 1;
	else 
		return 0;
}

stock IsOSymbol(text[], symbol, first, end)
{
	if(first < 0)
		first = 0;

	if(end >= strlen(text))
		end = strlen(text) - 1;

	for(new i = first; i <= end; i ++) {
		if(text[i] == symbol)
			return 1;
	}
	return 0;
}

stock IsODomen(text[])
{
	n_for(i, sizeof(Domains)) {
		new
			find = strfind(text, Domains[i], true);

		if(find != -1)
			if(IsOSymbol(text, '.', find - 2, find))
				return 1;
	}
	return 0;
}

stock IsOIP(text[])
{
	new
		numbers;

	n_for(i, strlen(text)) {
		if('0' <= text[i] <= '9') {
		if(!('0' <= text[i+1] <= '9'))
				numbers++;
		}
	}
	if(numbers >= 4)
		return 1;

	return 0;
}

stock HexToInt(string[])
{
	if(string[0] == 0)
		return 0;

	new
		i,
		cur = 1,
		res = 0;

	for (i = strlen(string); i > 0; i--) {
		if (string[i - 1] < 58)
			res = res + cur * (string[i - 1] - 48);
		else 
			res = res + cur * (string[i - 1] - 65 + 10);
		
		cur = cur * 16;
	}
	return res;
}

stock DestroyPlayerTD(playerid, &PlayerText:TD_id)
{
	if(TD_id != PlayerText:INVALID_TEXT_DRAW) {
		PlayerTextDrawDestroy(playerid, TD_id);
		TD_id = PlayerText:INVALID_TEXT_DRAW;
	}
	return 1;
}

stock DestroyPlayerText3D(playerid, &PlayerText3D:T3D_id)
{
	if(T3D_id != PlayerText3D:INVALID_3DTEXT_ID) {
		DeletePlayer3DTextLabel(playerid, T3D_id);
		T3D_id = PlayerText3D:INVALID_3DTEXT_ID;
	}
	return 1;
}

stock SetPlayerFee(playerid, exp, credit, type, bool:textTD = true)
{
	SetPlayerExp(playerid, exp);
	SetPlayerCredit(playerid, credit);

	new
		string[200],
		NameExp[20],
		NameCredit[20];

	switch(exp) {
		case 1: NameExp = "опыт";
		default: NameExp = "опыта";
	}
	switch(credit) {
		case 1: NameCredit = "кредит";
		case 2..5: NameCredit = "кредита";
	default: NameCredit = "кредитов";
	}

	switch(type) {
		case REPLEN_KILL: {
			f(string, "{15cf51}(Убийство) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
		case REPLEN_BAG_OF_CREDITS: {
			f(string, "{15cf51}(Мешок денег) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
		case REPLEN_CAPTURE: {
			f(string, "{15cf51}(Захват) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
		case REPLEN_ROUND: {
			f(string, "{15cf51}(Раунд) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
		case REPLEN_HACK: {
			f(string, "{15cf51}(Взлом) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
		case REPLEN_CAPTURE_FLAG: {
			f(string, "{15cf51}(Захват флага) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
		case REPLEN_TOKEN: {
			f(string, "{15cf51}(Жетон) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
		case REPLEN_MEDIC_HP: {
			f(string, "{15cf51}(Лечение) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
		case REPLEN_ENGINEER_VEHICLE: {
			f(string, "{15cf51}(Починка) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
		default: {
			f(string, "{15cf51}(Пополнение) {FFFFFF}Получено {CE9150}+%i {FFFFFF}%s и {CE9150}+%i {FFFFFF}%s.", exp, NameExp, credit, NameCredit);
		}
	}
	SCM(playerid, -1, string);

	Mode_SetPlayerFee(playerid, exp, credit);

	if(textTD)
		ShowReplenText(playerid, exp, credit, type);

	return 1;
}

stock CreateTextTDReward(playerid, id, type)
{
	new
		str[300];

	switch(type) {
		case REPLEN_KILL: {
			f(str, "Убийство %s", NameEx(GetPVarInt(playerid, "DeadPlayerid_PVar")));
			DeletePVar(playerid, "DeadPlayerid_PVar");
		}
		case REPLEN_BAG_OF_CREDITS: {
			str = "Мешок денег";
		}
		case REPLEN_CAPTURE: {
			str = "Захват точки";
		}
		case REPLEN_HACK: {
			str = "Взлом компьютера";
		}
		case REPLEN_CAPTURE_FLAG: {
			str = "Захват флага";
		}
		case REPLEN_TOKEN: {
			str = "Жетон";
		}
		case REPLEN_MEDIC_HP: {
			str = "Лечение";
		}
		case REPLEN_ENGINEER_VEHICLE: {
			str = "Починка";
		}
		default: {
			str = "Пополнение";
		}
	}

	PlayerTextTDReward[playerid][id] = str;
	PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][id], str);
	return 1;
}

stock ShowReplenText(playerid, exp, credit, type)
{
	if(PlayerTDReward[playerid][REW_ActionTextAll]) {
		PlayerTDReward[playerid][REW_Timer] = gettime() + 3;

		for(new i = REPLEN_AMOUNT_OF_TEXT - 1; i > 1; i--) {
			if(i == 2)
				CreateTextTDReward(playerid, i, type);
			if(i != 2) {
				PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][i], PlayerTextTDReward[playerid][i - 1]);
				PlayerTextTDReward[playerid][i] = PlayerTextTDReward[playerid][i - 1];
			}
		}

		new
			str[300];

		PlayerTDReward[playerid][REW_ChetExpCredit][0] += exp;
		
		f(str, "+%i опыта", PlayerTDReward[playerid][REW_ChetExpCredit][0]);
		PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][0], str);

		new
			str2[300];

		PlayerTDReward[playerid][REW_ChetExpCredit][1] += credit;

		f(str2, "+%i кредитов", PlayerTDReward[playerid][REW_ChetExpCredit][1]);
		PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][1], str2);
	}
	else {
		PlayerTDReward[playerid][REW_ActionTextAll] = true;
		PlayerTDReward[playerid][REW_Timer] = gettime() + 3;

		ShowTDPlayerReward(playerid);

		for(new i = REPLEN_AMOUNT_OF_TEXT - 1; i > 1; i--) {
			if(i == 2)
				CreateTextTDReward(playerid, i, type);
			if(i != 2) {
				PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][i], PlayerTextTDReward[playerid][i - 1]);
				PlayerTextTDReward[playerid][i] = PlayerTextTDReward[playerid][i - 1];

				PlayerTextDrawShow(playerid, TD_PlayerReward[playerid][i]);
			}
		}

		new
			str[300];

		PlayerTDReward[playerid][REW_ChetExpCredit][0] += exp;
		
		f(str, "+%i опыта", PlayerTDReward[playerid][REW_ChetExpCredit][0]);
		PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][0], str);

		new
			str2[300];

		PlayerTDReward[playerid][REW_ChetExpCredit][1] += credit;

		f(str2, "+%i кредитов", PlayerTDReward[playerid][REW_ChetExpCredit][1]);
		PlayerTextDrawSetString(playerid, TD_PlayerReward[playerid][1], str2);

		n_for(i, sizeof(TD_PlayerReward[]))
			PlayerTextDrawShow(playerid, TD_PlayerReward[playerid][i]);
	}
	return 1;
}

stock DestroyPlayerReward(playerid)
{
	if(PlayerTDReward[playerid][REW_ActionTextAll]) {
		PlayerTDReward[playerid][REW_ActionTextAll] = false;
		PlayerTDReward[playerid][REW_Timer] = 0;

		n_for(i, REPLEN_AMOUNT_OF_TEXT) {
			PlayerTextTDReward[playerid][i] = "";
			DestroyPlayerTD(playerid, TD_PlayerReward[playerid][i]);
		}

		n_for(i, 2)
			PlayerTDReward[playerid][REW_ChetExpCredit][i] = 0;
	}
	return 1;
}

stock UpdatePlayerReward(playerid)
{
	if(PlayerTDReward[playerid][REW_ActionTextAll]) {
		if(PlayerTDReward[playerid][REW_Timer] < gettime()) {
			DestroyPlayerReward(playerid);
		}
	}
	return 1;
}

stock ShowNewRank(playerid)
{
	ShowTDNewRank(playerid);

	new
		string[150];

	f(string, "Новый_ранг:_~y~%i~w~!", GetPlayerRank(playerid));
	PlayerTextDrawSetString(playerid, TD_NewRank[playerid], string);
	PlayerTextDrawShow(playerid, TD_NewRank[playerid]);
	return 1;
}

stock ShowTDNewRank(playerid)
{
	TD_NewRank[playerid] = CreatePlayerTextDraw(playerid, 326.000000, 80.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_NewRank[playerid], 0.278999, 1.263999);
	PlayerTextDrawAlignment(playerid, TD_NewRank[playerid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_NewRank[playerid], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_NewRank[playerid], 0);
	PlayerTextDrawSetOutline(playerid, TD_NewRank[playerid], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_NewRank[playerid], 48);
	PlayerTextDrawFont(playerid, TD_NewRank[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_NewRank[playerid], true);
	return 1;
}

// None TD

stock CreatePlayerTDs(playerid)
{
	new
		PlayerText:TD;

	TD = CreatePlayerTextDraw(playerid, 547.000000, 30.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD, 0.300000, 1.370000);
	PlayerTextDrawAlignment(playerid, TD, TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD, 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD, 0);
	PlayerTextDrawSetOutline(playerid, TD, 1);
	PlayerTextDrawFont(playerid, TD, TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD, true);
	return 1;
}

stock PreloadAnimLib(playerid, animlib[])
{
	return ApplyAnimation(playerid, animlib, "null", 0.0, 0, 0, 0, 0, 0);
}

stock PreloadAllAnimLibs(playerid)
{
	PreloadAnimLib(playerid,"AIRPORT");
	PreloadAnimLib(playerid,"Attractors");
	PreloadAnimLib(playerid,"BAR");
	PreloadAnimLib(playerid,"BASEBALL");
	PreloadAnimLib(playerid,"BD_FIRE");
	PreloadAnimLib(playerid,"BEACH");
	PreloadAnimLib(playerid,"benchpress");
	PreloadAnimLib(playerid,"BF_injection");
	PreloadAnimLib(playerid,"BIKED");
	PreloadAnimLib(playerid,"BIKEH");
	PreloadAnimLib(playerid,"BIKELEAP");
	PreloadAnimLib(playerid,"BIKES");
	PreloadAnimLib(playerid,"BIKEV");
	PreloadAnimLib(playerid,"BIKE_DBZ");
	PreloadAnimLib(playerid,"BLOWJOBZ");
	PreloadAnimLib(playerid,"BMX");
	PreloadAnimLib(playerid,"BOMBER");
	PreloadAnimLib(playerid,"BOX");
	PreloadAnimLib(playerid,"BSKTBALL");
	PreloadAnimLib(playerid,"BUDDY");
	PreloadAnimLib(playerid,"BUS");
	PreloadAnimLib(playerid,"CAMERA");
	PreloadAnimLib(playerid,"CAR");
	PreloadAnimLib(playerid,"CARRY");
	PreloadAnimLib(playerid,"CAR_CHAT");
	PreloadAnimLib(playerid,"CASINO");
	PreloadAnimLib(playerid,"CHAINSAW");
	PreloadAnimLib(playerid,"CHOPPA");
	PreloadAnimLib(playerid,"CLOTHES");
	PreloadAnimLib(playerid,"COACH");
	PreloadAnimLib(playerid,"COLT45");
	PreloadAnimLib(playerid,"COP_AMBIENT");
	PreloadAnimLib(playerid,"COP_DVBYZ");
	PreloadAnimLib(playerid,"CRACK");
	PreloadAnimLib(playerid,"CRIB");
	PreloadAnimLib(playerid,"DAM_JUMP");
	PreloadAnimLib(playerid,"DANCING");
	PreloadAnimLib(playerid,"DEALER");
	PreloadAnimLib(playerid,"DILDO");
	PreloadAnimLib(playerid,"DODGE");
	PreloadAnimLib(playerid,"DOZER");
	PreloadAnimLib(playerid,"DRIVEBYS");
	PreloadAnimLib(playerid,"FAT");
	PreloadAnimLib(playerid,"FIGHT_B");
	PreloadAnimLib(playerid,"FIGHT_C");
	PreloadAnimLib(playerid,"FIGHT_D");
	PreloadAnimLib(playerid,"FIGHT_E");
	PreloadAnimLib(playerid,"FINALE");
	PreloadAnimLib(playerid,"FINALE2");
	PreloadAnimLib(playerid,"FLAME");
	PreloadAnimLib(playerid,"Flowers");
	PreloadAnimLib(playerid,"FOOD");
	PreloadAnimLib(playerid,"Freeweights");
	PreloadAnimLib(playerid,"GANGS");
	PreloadAnimLib(playerid,"GHANDS");
	PreloadAnimLib(playerid,"GHETTO_DB");
	PreloadAnimLib(playerid,"goggles");
	PreloadAnimLib(playerid,"GRAFFITI");
	PreloadAnimLib(playerid,"GRAVEYARD");
	PreloadAnimLib(playerid,"GRENADE");
	PreloadAnimLib(playerid,"GYMNASIUM");
	PreloadAnimLib(playerid,"HAIRCUTS");
	PreloadAnimLib(playerid,"HEIST9");
	PreloadAnimLib(playerid,"INT_HOUSE");
	PreloadAnimLib(playerid,"INT_OFFICE");
	PreloadAnimLib(playerid,"INT_SHOP");
	PreloadAnimLib(playerid,"JST_BUISNESS");
	PreloadAnimLib(playerid,"KART");
	PreloadAnimLib(playerid,"KISSING");
	PreloadAnimLib(playerid,"KNIFE");
	PreloadAnimLib(playerid,"LAPDAN1");
	PreloadAnimLib(playerid,"LAPDAN2");
	PreloadAnimLib(playerid,"LAPDAN3");
	PreloadAnimLib(playerid,"LOWRIDER");
	PreloadAnimLib(playerid,"MD_CHASE");
	PreloadAnimLib(playerid,"MD_END");
	PreloadAnimLib(playerid,"MEDIC");
	PreloadAnimLib(playerid,"MISC");
	PreloadAnimLib(playerid,"MTB");
	PreloadAnimLib(playerid,"MUSCULAR");
	PreloadAnimLib(playerid,"NEVADA");
	PreloadAnimLib(playerid,"ON_LOOKERS");
	PreloadAnimLib(playerid,"OTB");
	PreloadAnimLib(playerid,"PARACHUTE");
	PreloadAnimLib(playerid,"PARK");
	PreloadAnimLib(playerid,"PAULNMAC");
	PreloadAnimLib(playerid,"ped");
	PreloadAnimLib(playerid,"PLAYER_DVBYS");
	PreloadAnimLib(playerid,"PLAYIDLES");
	PreloadAnimLib(playerid,"POLICE");
	PreloadAnimLib(playerid,"POOL");
	PreloadAnimLib(playerid,"POOR");
	PreloadAnimLib(playerid,"PYTHON");
	PreloadAnimLib(playerid,"QUAD");
	PreloadAnimLib(playerid,"QUAD_DBZ");
	PreloadAnimLib(playerid,"RAPPING");
	PreloadAnimLib(playerid,"RIFLE");
	PreloadAnimLib(playerid,"RIOT");
	PreloadAnimLib(playerid,"ROB_BANK");
	PreloadAnimLib(playerid,"ROCKET");
	PreloadAnimLib(playerid,"RUSTLER");
	PreloadAnimLib(playerid,"RYDER");
	PreloadAnimLib(playerid,"SCRATCHING");
	PreloadAnimLib(playerid,"SHAMAL");
	PreloadAnimLib(playerid,"SHOP");
	PreloadAnimLib(playerid,"SHOTGUN");
	PreloadAnimLib(playerid,"SILENCED");
	PreloadAnimLib(playerid,"SKATE");
	PreloadAnimLib(playerid,"SMOKING");
	PreloadAnimLib(playerid,"SNIPER");
	PreloadAnimLib(playerid,"SPRAYCAN");
	PreloadAnimLib(playerid,"STRIP");
	PreloadAnimLib(playerid,"SUNBATHE");
	PreloadAnimLib(playerid,"SWAT");
	PreloadAnimLib(playerid,"SWEET");
	PreloadAnimLib(playerid,"SWIM");
	PreloadAnimLib(playerid,"SWORD");
	PreloadAnimLib(playerid,"TANK");
	PreloadAnimLib(playerid,"TATTOOS");
	PreloadAnimLib(playerid,"TEC");
	PreloadAnimLib(playerid,"TRAIN");
	PreloadAnimLib(playerid,"TRUCK");
	PreloadAnimLib(playerid,"UZI");
	PreloadAnimLib(playerid,"VAN");
	PreloadAnimLib(playerid,"VENDING");
	PreloadAnimLib(playerid,"VORTEX");
	PreloadAnimLib(playerid,"WAYFARER");
	PreloadAnimLib(playerid,"WEAPONS");
	PreloadAnimLib(playerid,"WUZI");
	return 1;
}

stock RemovePlayerDead(playerid)
{
	DestroyPlayerDeadKiller(playerid, GetPlayerDead(playerid));

	SetPlayerSpecStatus(playerid, 0);
	SetPlayerDead(playerid, 0);
	SetPlayerSpeedRespawn(playerid, 0, false);
	SetPlayerSpectating(playerid, -1);
	return 1;
}

stock TDRandomColor(playerid, PlayerText:td_id)
{
	new
		r = random(11);

	switch(r) {
		case 0: PlayerTextDrawColour(playerid, td_id, 0xff3030FF);
		case 1: PlayerTextDrawColour(playerid, td_id, 0x5630ffFF);
		case 2: PlayerTextDrawColour(playerid, td_id, 0x2ec8d9FF);
		case 3: PlayerTextDrawColour(playerid, td_id, 0x2ed947FF);
		case 4: PlayerTextDrawColour(playerid, td_id, 0x83d92eFF);
		case 5: PlayerTextDrawColour(playerid, td_id, 0xd9d92eFF);
		case 6: PlayerTextDrawColour(playerid, td_id, 0xa32ed9FF);
		case 7: PlayerTextDrawColour(playerid, td_id, 0x2e8cd9FF);
		case 8: PlayerTextDrawColour(playerid, td_id, 0x8cd92eFF);
		case 9: PlayerTextDrawColour(playerid, td_id, 0xd92e97FF);
		case 10: PlayerTextDrawColour(playerid, td_id, 0x2ed99dFF);
	}
	PlayerTextDrawShow(playerid, td_id);
	return 1;
}

stock TDRandomVehicle(playerid, PlayerText:td_id)
{
	new
		r = random(5);

	switch(r) {
		case 0: PlayerTextDrawSetPreviewModel(playerid, td_id, 432);
		case 1: PlayerTextDrawSetPreviewModel(playerid, td_id, 433);
		case 2: PlayerTextDrawSetPreviewModel(playerid, td_id, 470);
		case 3: PlayerTextDrawSetPreviewModel(playerid, td_id, 528);
		case 4: PlayerTextDrawSetPreviewModel(playerid, td_id, 601);
	}
	return 1;
}

publics CheckPlayerAccount(playerid)
{
	// Indicator health weapon-config
	if(GetIndicatorHealth() == PLAYER_IND_HEALTH_WC)
		EnableHealthBarForPlayer(playerid, true);
	else
		EnableHealthBarForPlayer(playerid, false);

	SpecPl(playerid, true);
	StartPlayerCameraMainMenu(playerid);

	new
		num_rows;

	cache_get_row_count(num_rows);

	if(num_rows) {
		SetPVarInt(playerid, "CheckPlayerRegistered_PVar", 0);

		cache_get_value_name(0, "Password", pInfo[playerid][pPassword], 65);
		cache_get_value_name(0, "Salt", pInfo[playerid][pSalt], 11);
		cache_get_value_name_int(0, "ID", pInfo[playerid][pID]);

		SetPlayerRussifierType(playerid, RussifierType:0);

		n_for(i, 10)
			SCM(playerid, -1, "");

		SCM(playerid, -1, "Добро пожаловать на сервер {66CC66}"SERVER_NAME_CORE"");

		SetErrorText(playerid, "");
		Dialog_Show(playerid, Dialog:PlayerLogin);

		SetPlayerLoggedTimer(playerid, 120000);
	}
	else {
		n_for(i, 10)
			SCM(playerid, -1, "");

		Dialog_Show(playerid, Dialog:ServerRules);

		SCM(playerid, -1, "Добро пожаловать на сервер {66CC66}"SERVER_NAME_CORE"");
		SCM(playerid, -1, "");

		Dina_CheckPlayerHint(playerid, 0);

		SetPlayerLoggedTimer(playerid, 120000);
	}
	return 1;
}

publics UpdateAccountReferal(playerid)
{
	new
		num_rows;

	cache_get_row_count(num_rows);

	if(num_rows) {
		new
			IDMySQLReferal,
			ReferalExp,
			ReferalCredit;

		cache_get_value_name_int(0, "Exp", ReferalExp);
		cache_get_value_name_int(0, "Credit", ReferalCredit);
		cache_get_value_name_int(0, "ID", IDMySQLReferal);

		new
			RewardExp = 5000,
			RewardCredit = 30000;

		ReferalExp = ReferalExp + RewardExp;
		ReferalCredit = ReferalCredit + RewardCredit;

		new
			ReferalID;

		GetPlayerID(pInfo[playerid][pReferal], ReferalID);

		if(!IsPlayerOnServer(ReferalID)) {
			new
				query[500];

			mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Exp` = '%i', `Credit` = '%i' WHERE `ID` = '%d'", ReferalExp, ReferalCredit, IDMySQLReferal);
			mysql_tquery(MysqlID, query);
		}
		else {
			SetPlayerExp(ReferalID, RewardExp);
			SetPlayerCredit(ReferalID, RewardCredit);
		}
	}
	return 1;
}

stock ClosePlayerDialog(playerid)
{
	if(Dialog_IsOpen(playerid, Dialog:Adm_Answer))
		DialogAdm_AnswerClose(playerid);

	else if(Dialog_IsOpen(playerid, Dialog:TDM_ClassBuyAmmo))
		DeletePVar(playerid, "TDM_BuyAmmo_PVar");

	else if(Dialog_IsOpen(playerid, Dialog:PlayerListAnimations)) {
		n_for(i, PLAYER_MAX_ANIMATIONS)
			DialogListPlayerAnims[playerid][i] = -1;
	}

	else if(Dialog_IsOpen(playerid, Dialog:TDM_ClSkillsWeapon)
	|| Dialog_IsOpen(playerid, Dialog:TDM_ClSkillsCloseFight)
	|| Dialog_IsOpen(playerid, Dialog:TDM_ClassChooseStats)
	|| Dialog_IsOpen(playerid, Dialog:TDM_BuyListClAbility)
	|| Dialog_IsOpen(playerid, Dialog:TDM_PlayerClassStats)) {
		if(!Interface_IsOpen(playerid, Interface:TDM_SelectedClass))
			SetPlayerCustomClass2(playerid, -1);

		TDM_RemoveClassAbilities(playerid);
		DeletePVar(playerid, "PlayerClassAbility_PVar");
	}

	Dialog_Close(playerid);
	return 1;
}

stock KickEx(playerid) {
	SetPVarInt(playerid, "ActionKick_PVar", 1);
	SetPlayerTimer(playerid, "Kicker", 500, false);
	return 1;
}

publics Kicker(playerid) {
	DeletePVar(playerid, "ActionKick_PVar");
	Kick(playerid);
	return 1;
}

stock UpdateBarTimeRespawn(playerid)
{
	SetPlayerProgressBarValue(playerid, Bar_time_to_spawn[playerid], floatround((Mode_GetModeTimeRespawn(Mode_GetPlayer(playerid))) - (GetPlayerSpeedRespawn(playerid) - gettime())));
	return 1;
}

stock ProxDetector(Float:radi, playerid, const str[], col1, col2, col3, col4, col5)
{
	if(IsPlayerOnServer(playerid)) {
		new
			Float:posx, Float:posy, Float:posz,
			Float:oldposx, Float:oldposy, Float:oldposz,
			Float:tempposx, Float:tempposy, Float:tempposz;

		GetPlayerPos(playerid, oldposx, oldposy, oldposz);

		foreach(Player, p) {
			if(!IsPlayerOnServer(p))
				continue;
			
			GetPlayerPos(p, posx, posy, posz);
			tempposx = (oldposx -posx);
			tempposy = (oldposy -posy);
			tempposz = (oldposz -posz);

			if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16)
			&& (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
				SCM(p, col1, str);

			else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8)
			&& (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
				SCM(p, col2, str);

			else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4)
			&& (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
				SCM(p, col3, str);
			
			else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2)
			&& (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
				SCM(p, col4, str);

			else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi)
			&& (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
				SCM(p, col5, str);
		}
	}
	return 1;
}

publics ProxDetectorS(Float:radi, playerid, targetid)
{
	if(IsPlayerOnServer(playerid) && IsPlayerOnServer(targetid)) {
		new
			Float:posx, Float:posy, Float:posz,
			Float:oldposx, Float:oldposy, Float:oldposz,
			Float:tempposx, Float:tempposy, Float:tempposz;

		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		GetPlayerPos(targetid, posx, posy, posz);

		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);

		if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi)
		&& (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
			return 1;
	}
	return 0;
}

stock CheckPremiumAccount(playerid)
{
	new
		seconds = pInfo[playerid][pPremiumData],
		times = gettime(),
		rutima[50],
		dima;

	if(floatround((seconds - times) / 60 / 60 / 24) > 1) {
		rutima = "дней";
		dima = floatround((seconds - times) / 60 / 60 / 24, floatround_ceil);
	}
	else if(floatround((seconds - times) / 60 / 60) > 1) {
		rutima = "истекает сегодня";
		dima = 0;
	}
	else {
		rutima = "истекает сегодня";
		dima = 0;
	}

	if(times < seconds) {
		new
			str[500];

		f(str, "{3bcae3}(Премиум аккаунт) {FFFFFF}Оставшееся время: %i %s", dima, rutima);
		SCM(playerid, -1, str);
	}
	else {
		SCM(playerid, -1, "{3bcae3}(Премиум аккаунт) {FFFFFF}Ваш Премиум аккаунт подошёл к конку :(");

		pInfo[playerid][pPremium] = 0;
		pInfo[playerid][pPremiumData] = 0;
		pInfo[playerid][pNickColor][0] = EOS;
		
		mysql_escape_string("No Color", pInfo[playerid][pNickColor]);
		SavePlayerPremium(playerid);
		SavePlayerNickColor(playerid);
	}
	return 1;
}

stock ShowTDKillStrike(playerid) 
{
	TD_PlayerKillStrike[playerid] = CreatePlayerTextDraw(playerid, 317.000000, 364.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_PlayerKillStrike[playerid], 0.249666, 1.010963);
	PlayerTextDrawTextSize(playerid, TD_PlayerKillStrike[playerid], 0.000000, 74.000000);
	PlayerTextDrawAlignment(playerid, TD_PlayerKillStrike[playerid], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerKillStrike[playerid], -653192773);
	PlayerTextDrawSetShadow(playerid, TD_PlayerKillStrike[playerid], 0);
	PlayerTextDrawUseBox(playerid, TD_PlayerKillStrike[playerid], true);
	PlayerTextDrawBoxColour(playerid, TD_PlayerKillStrike[playerid], 187);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerKillStrike[playerid], 255);
	PlayerTextDrawFont(playerid, TD_PlayerKillStrike[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerKillStrike[playerid], true);
	return 1;
}

stock ShowTDPlayerReward(playerid) 
{
	TD_PlayerReward[playerid][0] = CreatePlayerTextDraw(playerid, 364.000000, 163.000000, "_"); // Всего опыта
	PlayerTextDrawLetterSize(playerid, TD_PlayerReward[playerid][0], 0.199999, 1.172739);
	PlayerTextDrawAlignment(playerid, TD_PlayerReward[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerReward[playerid][0], -274973185);
	PlayerTextDrawSetShadow(playerid, TD_PlayerReward[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, TD_PlayerReward[playerid][0], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerReward[playerid][0], 48);
	PlayerTextDrawFont(playerid, TD_PlayerReward[playerid][0], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerReward[playerid][0], true);

	TD_PlayerReward[playerid][1] = CreatePlayerTextDraw(playerid, 364.000000, 173.000000, "_"); // Всего кредитов
	PlayerTextDrawLetterSize(playerid, TD_PlayerReward[playerid][1], 0.199999, 1.172739);
	PlayerTextDrawAlignment(playerid, TD_PlayerReward[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerReward[playerid][1], 1575768575);
	PlayerTextDrawSetShadow(playerid, TD_PlayerReward[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, TD_PlayerReward[playerid][1], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerReward[playerid][1], 48);
	PlayerTextDrawFont(playerid, TD_PlayerReward[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerReward[playerid][1], true);

	TD_PlayerReward[playerid][2] = CreatePlayerTextDraw(playerid, 364.000000, 190.000000, "_"); // Строчка 1
	PlayerTextDrawLetterSize(playerid, TD_PlayerReward[playerid][2], 0.200999, 0.969480);
	PlayerTextDrawAlignment(playerid, TD_PlayerReward[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerReward[playerid][2], -219147265);
	PlayerTextDrawSetShadow(playerid, TD_PlayerReward[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, TD_PlayerReward[playerid][2], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerReward[playerid][2], 48);
	PlayerTextDrawFont(playerid, TD_PlayerReward[playerid][2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerReward[playerid][2], true);

	TD_PlayerReward[playerid][3] = CreatePlayerTextDraw(playerid, 364.000000, 200.000000, "_"); // Строчка 2
	PlayerTextDrawLetterSize(playerid, TD_PlayerReward[playerid][3], 0.200999, 0.969480);
	PlayerTextDrawAlignment(playerid, TD_PlayerReward[playerid][3], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerReward[playerid][3], -219147265);
	PlayerTextDrawSetShadow(playerid, TD_PlayerReward[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, TD_PlayerReward[playerid][3], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerReward[playerid][3], 48);
	PlayerTextDrawFont(playerid, TD_PlayerReward[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerReward[playerid][3], true);

	TD_PlayerReward[playerid][4] = CreatePlayerTextDraw(playerid, 364.000000, 210.000000, "_"); // Строчка 3
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

stock ShowTDPlayerStatsRound(playerid)
{
	ActionPlayerStatsRound[playerid] = TD_CREATED;

	new
		str[100];

	f(str, "Ранг: %i", GetPlayerRank(playerid));
	TD_PlayerStatsRound[playerid][0] = CreatePlayerTextDraw(playerid, 30.0000, 268.0000, str);
	PlayerTextDrawLetterSize(playerid, TD_PlayerStatsRound[playerid][0], 0.2081, 1.3839);
	PlayerTextDrawAlignment(playerid, TD_PlayerStatsRound[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerStatsRound[playerid][0], -34978049);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerStatsRound[playerid][0], 153);
	PlayerTextDrawFont(playerid, TD_PlayerStatsRound[playerid][0], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerStatsRound[playerid][0], true);
	PlayerTextDrawSetShadow(playerid, TD_PlayerStatsRound[playerid][0], 1);
	str[0] = EOS;

	f(str, "Убийств: %i", Mode_GetPlayerKills(playerid));
	TD_PlayerStatsRound[playerid][1] = CreatePlayerTextDraw(playerid, 30.0000, 280.0000, str);
	PlayerTextDrawLetterSize(playerid, TD_PlayerStatsRound[playerid][1], 0.2081, 1.3840);
	PlayerTextDrawAlignment(playerid, TD_PlayerStatsRound[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerStatsRound[playerid][1], 2121985279);
	PlayerTextDrawSetShadow(playerid, TD_PlayerStatsRound[playerid][1], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerStatsRound[playerid][1], 153);
	PlayerTextDrawFont(playerid, TD_PlayerStatsRound[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerStatsRound[playerid][1], true);
	str[0] = EOS;

	f(str, "Смертей: %i", Mode_GetPlayerDeaths(playerid));
	TD_PlayerStatsRound[playerid][2] = CreatePlayerTextDraw(playerid, 30.0000, 292.000, str);
	PlayerTextDrawLetterSize(playerid, TD_PlayerStatsRound[playerid][2], 0.2081, 1.3840);
	PlayerTextDrawAlignment(playerid, TD_PlayerStatsRound[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_PlayerStatsRound[playerid][2], -327254273);
	PlayerTextDrawSetShadow(playerid, TD_PlayerStatsRound[playerid][2], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_PlayerStatsRound[playerid][2], 153);
	PlayerTextDrawFont(playerid, TD_PlayerStatsRound[playerid][2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_PlayerStatsRound[playerid][2], true);
	return 1;
}

stock ShowTDPlayerFPSandPING(playerid)
{
	ActionPlayerFPSandPING[playerid] = TD_CREATED;

	TD_FPS_and_PING[playerid][0] = CreatePlayerTextDraw(playerid, 487.0000, 103.0000, "Box"); // Задний фон
	PlayerTextDrawLetterSize(playerid, TD_FPS_and_PING[playerid][0], 0.0000, 0.8999);
	PlayerTextDrawTextSize(playerid, TD_FPS_and_PING[playerid][0], 620.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_FPS_and_PING[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_FPS_and_PING[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_FPS_and_PING[playerid][0], true);
	PlayerTextDrawBoxColour(playerid, TD_FPS_and_PING[playerid][0], 0x00000000); // 153
	PlayerTextDrawBackgroundColour(playerid, TD_FPS_and_PING[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_FPS_and_PING[playerid][0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_FPS_and_PING[playerid][0], true);

	TD_FPS_and_PING[playerid][1] = CreatePlayerTextDraw(playerid, 540.0000, 100.0000, "FPS:_~g~60"); // FPS
	PlayerTextDrawLetterSize(playerid, TD_FPS_and_PING[playerid][1], 0.2506, 1.3634);
	PlayerTextDrawAlignment(playerid, TD_FPS_and_PING[playerid][1], TEXT_DRAW_ALIGN_RIGHT);
	PlayerTextDrawColour(playerid, TD_FPS_and_PING[playerid][1], -960051969);
	PlayerTextDrawSetShadow(playerid, TD_FPS_and_PING[playerid][1], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_FPS_and_PING[playerid][1], 128);
	PlayerTextDrawFont(playerid, TD_FPS_and_PING[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_FPS_and_PING[playerid][1], true);

	TD_FPS_and_PING[playerid][2] = CreatePlayerTextDraw(playerid, 560.0000, 100.0000, "Ping_~r~50"); // PING
	PlayerTextDrawLetterSize(playerid, TD_FPS_and_PING[playerid][2], 0.2506, 1.3634);
	PlayerTextDrawAlignment(playerid, TD_FPS_and_PING[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_FPS_and_PING[playerid][2], -960051969);
	PlayerTextDrawSetShadow(playerid, TD_FPS_and_PING[playerid][2], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_FPS_and_PING[playerid][2], 128);
	PlayerTextDrawFont(playerid, TD_FPS_and_PING[playerid][2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_FPS_and_PING[playerid][2], true);
	return 1;
}

stock UpdateSpectatingPlayer(playerid, spectedid)
{
	if(GetPlayerVirtualWorldEx(playerid) != GetPlayerVirtualWorldEx(spectedid))
		SetPlayerVirtualWorldEx(playerid, GetPlayerVirtualWorldEx(spectedid));

	if(GetPlayerInteriorEx(playerid) != GetPlayerInteriorEx(spectedid))
		SetPlayerInteriorEx(playerid, GetPlayerInteriorEx(spectedid));

	if(GetPlayerVehicleIDEx(spectedid) != -1) {
		if(GetPlayerSpecStatus(playerid) != 1) {
			SetPlayerSpecStatus(playerid, 1);
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(spectedid));
		}
	}
	else {
		if(GetPlayerSpecStatus(playerid) != 2) {
			SetPlayerSpecStatus(playerid, 2);
			PlayerSpectatePlayer(playerid, spectedid);
		}
	}
	return 1;
}

stock UpdateSpectatingStatus(playerid, spectedid)
{
	if(spectedid == -1)
		return 1;

	if(Adm_GetPlayerSpectating(playerid)) {
		if(Adm_GetPlayerLevel(playerid) > 0) {
			if(!IsPlayerOnServer(spectedid)) {
				Adm_HidePlayerSpectating(playerid);

				SCM(playerid, -1, "{CC0033}(Слежка) {FFFFFF}Игрока нет на сервере.");
			}
			else {
				UpdateSpectatingPlayer(playerid, spectedid);
				Adm_UpdateTDSpec(playerid, spectedid);
			}
		}
		return 1;
	}
	else {
		if(Mode_UpdateSpectateStatus(playerid, spectedid))
			return 1;

		if(GetPlayerDead(playerid)
		&& !GetPlayerDead(spectedid))
			UpdateSpectatingPlayer(playerid, spectedid);
	}
	return 1;
}

stock ShowPlayerKillStrike(playerid)
{
	if(ActionPlayerKillStrike{playerid})
		HidePlayerKillStrike(playerid);

	ActionPlayerKillStrike{playerid} = true;
	PlayerTimerKillStrike[playerid] = gettime() + 2;
	ShowTDKillStrike(playerid);

	new
		string[50];

	f(string, "Убийств: %i", GetPlayerKillStrike(playerid));
	PlayerTextDrawSetString(playerid, TD_PlayerKillStrike[playerid], string);
	PlayerTextDrawShow(playerid, TD_PlayerKillStrike[playerid]);
	return 1;
}

stock HidePlayerKillStrike(playerid)
{
	if(!ActionPlayerKillStrike{playerid})
		return 1;

	ActionPlayerKillStrike{playerid} = false;
	PlayerTimerKillStrike[playerid] = 0;
	DestroyPlayerTD(playerid, TD_PlayerKillStrike[playerid]);
	return 1;
}

stock UpdatePlayerKillStrike(playerid)
{
	if(ActionPlayerKillStrike{playerid}) {
		if(PlayerTimerKillStrike[playerid] < gettime())
			HidePlayerKillStrike(playerid);
	}
	return 1;
}

stock CreatePlayerNewRank(playerid)
{
	ShowNewRank(playerid);
	ActivePlayerTDRank{playerid} = true;
	PlayerTimerTDRank[playerid] = gettime() + 5;
	return 1;
}

stock DestroyPlayerNewRank(playerid)
{
	ActivePlayerTDRank{playerid} = false;
	PlayerTimerTDRank[playerid] = 0;
	DestroyPlayerTD(playerid, TD_NewRank[playerid]);
	return 1;
}

stock UpdatePlayerNewRank(playerid)
{
	if(ActivePlayerTDRank{playerid}) {
		if(PlayerTimerTDRank[playerid] < gettime())
			DestroyPlayerNewRank(playerid);
	}
	return 1;
}

stock SetPlayerSpawnKill(playerid)
{
	if(ActionPlayerSpawnKill{playerid} == true)
		DestroyPlayerSpawnKill(playerid);

	SetPlayerDamage(playerid, false);
	ActionPlayerSpawnKill{playerid} = true;
	TimerPlayerSpawnKill[playerid] = gettime() + PLAYER_TIMER_SPAWNKILL;

	ShowTDSpawnKill(playerid);
	PlayerTextDrawShow(playerid, TD_TimerSpawnKill[playerid]);
	return 1;
}

stock DestroyPlayerSpawnKill(playerid)
{
	if(!ActionPlayerSpawnKill{playerid})
		return 1;

	ActionPlayerSpawnKill{playerid} = false;
	TimerPlayerSpawnKill[playerid] = 0;
	DestroyPlayerTD(playerid, TD_TimerSpawnKill[playerid]);

	SetPlayerDamage(playerid, true);
	return 1;
}

stock UpdatePlayerSpawnKill(playerid)
{
	if(ActionPlayerSpawnKill{playerid}) {
		if(TimerPlayerSpawnKill[playerid] <= gettime())
			DestroyPlayerSpawnKill(playerid);
		else {
			SetPlayerChatBubble(playerid, "SpawnKill", 0xCC0033FF, 30.0, 1000);

			new
				string[20];
	
			f(string, "Бессмертие: ~b~%i", TimerPlayerSpawnKill[playerid] - gettime());
			PlayerTextDrawSetString(playerid, TD_TimerSpawnKill[playerid], string);
		}
	}
	return 1;
}

stock ShowTDSpawnKill(playerid)
{
	TD_TimerSpawnKill[playerid] = CreatePlayerTextDraw(playerid, 320.000000, 343.000000, "_");
	PlayerTextDrawLetterSize(playerid, TD_TimerSpawnKill[playerid], 0.282332, 1.558518);
	PlayerTextDrawFont(playerid, TD_TimerSpawnKill[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawAlignment(playerid, TD_TimerSpawnKill[playerid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_TimerSpawnKill[playerid], 0xFFFFFFFF);
	PlayerTextDrawSetShadow(playerid, TD_TimerSpawnKill[playerid], true);
	PlayerTextDrawBackgroundColour(playerid, TD_TimerSpawnKill[playerid], 80);
	PlayerTextDrawSetProportional(playerid, TD_TimerSpawnKill[playerid], true);
	return 1;
}

stock ShowPlayerExitZone(playerid) 
{
	if(ActionPlayerExitZone{playerid})
		return 1;

	ActionPlayerExitZone{playerid} = true;
	PlayerExitZoneTimer[playerid] = gettime() + 10;

	ShowPlayerTDExitZone(playerid);

	n_for(i, sizeof(TD_ExitZone[]))
		PlayerTextDrawShow(playerid, TD_ExitZone[playerid][i]);

	return 1;
}

stock HidePlayerExitZone(playerid)
{
	if(!ActionPlayerExitZone{playerid})
		return 1;

	ActionPlayerExitZone{playerid} = false;
	PlayerExitZoneTimer[playerid] = 0;

	n_for(i, sizeof(TD_ExitZone[]))
		DestroyPlayerTD(playerid, TD_ExitZone[playerid][i]);

	return 1;
}

stock GetPlayerExitZone(playerid)
{
	if(ActionPlayerExitZone{playerid})
		return 1;

	return 0;
}

stock ShowPlayerTDExitZone(playerid)
{
	// Основной задний фон
	TD_ExitZone[playerid][0] = CreatePlayerTextDraw(playerid, 0.0000, 0.0000, "Box");
	PlayerTextDrawLetterSize(playerid, TD_ExitZone[playerid][0], 0.0000, 50.6665);
	PlayerTextDrawTextSize(playerid, TD_ExitZone[playerid][0], 646.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_ExitZone[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_ExitZone[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_ExitZone[playerid][0], true);
	PlayerTextDrawBoxColour(playerid, TD_ExitZone[playerid][0], 80);
	PlayerTextDrawBackgroundColour(playerid, TD_ExitZone[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_ExitZone[playerid][0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_ExitZone[playerid][0], true);

	TD_ExitZone[playerid][1] = CreatePlayerTextDraw(playerid, 320.0000, 195.0000, "Выход_из_боевой_зоны");
	PlayerTextDrawLetterSize(playerid, TD_ExitZone[playerid][1], 0.2749, 1.4548);
	PlayerTextDrawAlignment(playerid, TD_ExitZone[playerid][1], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_ExitZone[playerid][1], -1136573953);
	PlayerTextDrawSetOutline(playerid, TD_ExitZone[playerid][1], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_ExitZone[playerid][1], 21);
	PlayerTextDrawFont(playerid, TD_ExitZone[playerid][1], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_ExitZone[playerid][1], true);

	TD_ExitZone[playerid][2] = CreatePlayerTextDraw(playerid, 320.0000, 215.0000, "Вернитесь_обратно!");
	PlayerTextDrawLetterSize(playerid, TD_ExitZone[playerid][2], 0.2749, 1.4548);
	PlayerTextDrawAlignment(playerid, TD_ExitZone[playerid][2], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_ExitZone[playerid][2], -1339019009);
	PlayerTextDrawSetOutline(playerid, TD_ExitZone[playerid][2], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_ExitZone[playerid][2], 32);
	PlayerTextDrawFont(playerid, TD_ExitZone[playerid][2], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_ExitZone[playerid][2], true);

	TD_ExitZone[playerid][3] = CreatePlayerTextDraw(playerid, 320.0000, 250.0000, "Смерть_наступит_через:_10");
	PlayerTextDrawLetterSize(playerid, TD_ExitZone[playerid][3], 0.2749, 1.4548);
	PlayerTextDrawAlignment(playerid, TD_ExitZone[playerid][3], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_ExitZone[playerid][3], -1037621249);
	PlayerTextDrawSetOutline(playerid, TD_ExitZone[playerid][3], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_ExitZone[playerid][3], 32);
	PlayerTextDrawFont(playerid, TD_ExitZone[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_ExitZone[playerid][3], true);

	TD_ExitZone[playerid][4] = CreatePlayerTextDraw(playerid, 311.0000, 237.0000, "_");
	PlayerTextDrawFont(playerid, TD_ExitZone[playerid][4], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawAlignment(playerid, TD_ExitZone[playerid][4], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_ExitZone[playerid][4], -579241473);
	PlayerTextDrawBackgroundColour(playerid, TD_ExitZone[playerid][4], 0x00000000);
	PlayerTextDrawTextSize(playerid, TD_ExitZone[playerid][4], 15.0000, 13.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_ExitZone[playerid][4], 1254);
	PlayerTextDrawSetPreviewRot(playerid, TD_ExitZone[playerid][4], 0.0000, 0.0000, 0.0000, 1.0000);
	return 1;
}

stock UpdatePlayerExitZone(playerid)
{
	if(!ActionPlayerExitZone{playerid})
		return 1;

	if(PlayerExitZoneTimer[playerid] <= gettime()) {
		HidePlayerExitZone(playerid);
		SetPlayerHealthEx(playerid, 0.0);
	}
	else {
		new
			string[50];

		f(string, "Смерть_наступит_через:_%01d", PlayerExitZoneTimer[playerid] - gettime());
		PlayerTextDrawSetString(playerid, TD_ExitZone[playerid][3], string);
	}
	if(GetPlayerDead(playerid))
		HidePlayerExitZone(playerid);

	return 1;
}


stock DestroyPlayerBelowHealth(playerid)
{
	if(ActionPlayerBelowHealth[playerid] > 0) {
		ActionPlayerBelowHealth[playerid] = 0;

		n_for(i, sizeof(TD_BelowHealth))
			TextDrawHideForPlayer(playerid, TD_BelowHealth[i]);

		SetPlayerDrunkLevel(playerid, 0);
	}
	return 1;
}

stock UpdatePlayerBelowHealth(playerid)
{
	if(ActionPlayerBelowHealth[playerid] == 0) {
		new
			Float:hp;

		GetPlayerHealthEx(playerid, hp);
		if(hp < 20.0) ActionPlayerBelowHealth[playerid] = 1;
	}
	if(ActionPlayerBelowHealth[playerid] > 0) {
		new
			Float:health;

		GetPlayerHealthEx(playerid, health);
		if(health >= 20.0) {
			ActionPlayerBelowHealth[playerid] = 0;
			SetPlayerDrunkLevel(playerid, 0);

			n_for(i, sizeof(TD_BelowHealth))
				TextDrawHideForPlayer(playerid, TD_BelowHealth[i]);
		}
		else {
			if(ActionPlayerBelowHealth[playerid] != 2) {
				if(health > 15.0 && health < 20.0) {
					if(ActionPlayerBelowHealth[playerid] == 3) {
						for(new i = 4; i < sizeof(TD_BelowHealth); i++)
							TextDrawHideForPlayer(playerid, TD_BelowHealth[i]);
					}
					else {
						n_for(i, 5)
							TextDrawShowForPlayer(playerid, TD_BelowHealth[i]);
					}
					ActionPlayerBelowHealth[playerid] = 2;
					SetPlayerDrunkLevel(playerid, 3000);
				}
			}
			if(ActionPlayerBelowHealth[playerid] != 3) {
				if(health > 0.0 && health < 15.0) {
					if(ActionPlayerBelowHealth[playerid] == 2) {
						for(new i = 4; i < sizeof(TD_BelowHealth); i++)
							TextDrawShowForPlayer(playerid, TD_BelowHealth[i]);
					}
					else {
						n_for(i, sizeof(TD_BelowHealth))
							TextDrawShowForPlayer(playerid, TD_BelowHealth[i]);
					}
					ActionPlayerBelowHealth[playerid] = 3;
					SetPlayerDrunkLevel(playerid, 5000);
				}
			}
			Dina_CheckPlayerHint(playerid, 18);
		}
	}
	return 1;
}

stock CreatePlayerBaseIndicators(playerid)
{
	if(GetIndicatorHealth() != PLAYER_IND_HEALTH_CUSTOM)
		return 1;

	if(ActionPlayerBarHealth[playerid] == TD_DESTROYED)
		ShowPlayerTDBarHealth(playerid);

	if(ActionPlayerBarArmour[playerid] == TD_DESTROYED)
		ShowPlayerTDBarArmour(playerid);
	
	ShowBarPlayerHealth(playerid);
	ShowBarPlayerArmour(playerid);
	return 1;
}

stock DestroyPlayerBaseIndicators(playerid, bool:hide = true)
{
	if(GetIndicatorHealth() != PLAYER_IND_HEALTH_CUSTOM)
		return 1;

	if(ActionPlayerBarHealth[playerid] != TD_DESTROYED)
		DestroyBarPlayerHealth(playerid, hide);

	if(ActionPlayerBarArmour[playerid] != TD_DESTROYED)
		DestroyBarPlayerArmour(playerid, hide);

	return 1;
}

stock ShowBarPlayerHealth(playerid)
{
	if(GetIndicatorHealth() != PLAYER_IND_HEALTH_CUSTOM)
		return 1;
	
	if(ActionPlayerBarHealth[playerid] != TD_DESTROYED
	&& ActionPlayerBarHealth[playerid] != TD_SHOWN) {
		ActionPlayerBarHealth[playerid] = TD_SHOWN;
		ShowPlayerProgressBar(playerid, BarHealth[playerid]);
	}
	return 1;
}

stock DestroyBarPlayerHealth(playerid, bool:hide = true)
{
	if(GetIndicatorHealth() != PLAYER_IND_HEALTH_CUSTOM)
		return 1;
	
	if(ActionPlayerBarHealth[playerid] != TD_DESTROYED) {
		if(hide) {
			if(ActionPlayerBarHealth[playerid] != TD_HIDDEN) {
				ActionPlayerBarHealth[playerid] = TD_HIDDEN;
				HidePlayerProgressBar(playerid, BarHealth[playerid]);
			}
		}
		else {
			ActionPlayerBarHealth[playerid] = TD_DESTROYED;
			DestroyPlayerProgressBar(playerid, BarHealth[playerid]);
		}
	}
	return 1;
}

stock ShowPlayerTDBarHealth(playerid)
{
	if(GetIndicatorHealth() != PLAYER_IND_HEALTH_CUSTOM)
		return 1;

	ActionPlayerBarHealth[playerid] = TD_CREATED;

	new
		Float:health;

	GetPlayerHealthEx(playerid, health);
	BarHealth[playerid] = CreatePlayerProgressBar(playerid, 547.00, 68.00, 65.50, 7.20, 0xb51821FF, 100.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarValue(playerid, BarHealth[playerid], health);
	HidePlayerProgressBar(playerid, BarHealth[playerid]);
	return 1;
}

stock ShowBarPlayerArmour(playerid)
{
	if(GetIndicatorHealth() != PLAYER_IND_HEALTH_CUSTOM)
		return 1;
	
	if(ActionPlayerBarArmour[playerid] != TD_DESTROYED 
	&& ActionPlayerBarArmour[playerid] != TD_SHOWN) {
		ActionPlayerBarArmour[playerid] = TD_SHOWN;
		ShowPlayerProgressBar(playerid, BarArmour[playerid]);
	}
	return 1;
}

stock DestroyBarPlayerArmour(playerid, bool:hide = true)
{
	if(GetIndicatorHealth() != PLAYER_IND_HEALTH_CUSTOM)
		return 1;

	if(ActionPlayerBarArmour[playerid] != TD_DESTROYED) {
		if(hide) {
			if(ActionPlayerBarArmour[playerid] != TD_HIDDEN) {
				ActionPlayerBarArmour[playerid] = TD_HIDDEN;
				HidePlayerProgressBar(playerid, BarArmour[playerid]);
			}
		}
		else {
			ActionPlayerBarArmour[playerid] = TD_DESTROYED;
			DestroyPlayerProgressBar(playerid, BarArmour[playerid]);
		}
	}
	return 1;
}

stock ShowPlayerTDBarArmour(playerid)
{
	if(GetIndicatorHealth() != PLAYER_IND_HEALTH_CUSTOM)
		return 1;

	ActionPlayerBarArmour[playerid] = TD_CREATED;

	new
		Float:armour;

	GetPlayerArmourEx(playerid, armour);
	BarArmour[playerid] = CreatePlayerProgressBar(playerid, 547.00, 46.00, 65.50, 7.20, 0xe6e6e6FF, 100.0, BAR_DIRECTION_RIGHT);
	SetPlayerProgressBarValue(playerid, BarArmour[playerid], armour);
	HidePlayerProgressBar(playerid, BarArmour[playerid]);
	return 1;
}

stock CreatePlayerFPSandPING(playerid)
{
	if(ActionPlayerFPSandPING[playerid] != TD_DESTROYED
	&& ActionPlayerFPSandPING[playerid] != TD_SHOWN) {
		ActionPlayerFPSandPING[playerid] = TD_SHOWN;
		UpdatePlayerFPSandPING(playerid);

		n_for(i, sizeof(TD_FPS_and_PING[]))
			PlayerTextDrawShow(playerid, TD_FPS_and_PING[playerid][i]);
	}
	return 1;
}

stock DestroyPlayerFPSandPING(playerid, bool:hide = true)
{
	if(ActionPlayerFPSandPING[playerid] != TD_DESTROYED) {
		if(hide) {
			if(ActionPlayerFPSandPING[playerid] != TD_HIDDEN) {
				ActionPlayerFPSandPING[playerid] = TD_HIDDEN;

				n_for(i, sizeof(TD_FPS_and_PING[]))
					PlayerTextDrawHide(playerid, TD_FPS_and_PING[playerid][i]);
			}
		}
		else {
			ActionPlayerFPSandPING[playerid] = TD_DESTROYED;

			n_for(i, sizeof(TD_FPS_and_PING[]))
				DestroyPlayerTD(playerid, TD_FPS_and_PING[playerid][i]);
		}
	}
	return 1;
}

stock UpdatePlayerFPSandPING(playerid)
{
	if(ActionPlayerFPSandPING[playerid] == TD_SHOWN) {
		new
			str[30],
			str2[10],
			fps = GetPlayerFPS(playerid);

		if(fps > 0) {
			if(fps <= 15)
				str2 = "~r~";
			else if(fps <= 25)
				str2 = "~y~";
			else if(fps > 25)
				str2 = "~g~";

			f(str, "FPS:_%s%i", str2, fps);
			PlayerTextDrawSetString(playerid, TD_FPS_and_PING[playerid][1], str);
			str[0] = str2[0] = EOS;
		}

		new
			ping = GetPlayerPing(playerid);

		if(ping > 0) { 
			if(ping >= 200)
				str2 = "~r~";
			else if(ping >= 101)
				str2 = "~y~";
			else if(ping >= 0)
				str2 = "~g~";

			f(str, "PING:_%s%i", str2, ping);
			PlayerTextDrawSetString(playerid, TD_FPS_and_PING[playerid][2], str);
		}
	}
	return 1;
}

stock CreatePlayerStatsRound(playerid)
{
	if(ActionPlayerStatsRound[playerid] != TD_DESTROYED
	&& ActionPlayerStatsRound[playerid] != TD_SHOWN) {
		ActionPlayerStatsRound[playerid] = TD_SHOWN;
		UpdatePlayerStatsRound(playerid);

		n_for(i, sizeof(TD_PlayerStatsRound[]))
			PlayerTextDrawShow(playerid, TD_PlayerStatsRound[playerid][i]);
	}
	return 1;
}

stock DestroyPlayerStatsRound(playerid, bool:hide = true)
{
	if(ActionPlayerStatsRound[playerid] != TD_DESTROYED) {
		if(hide) {
			if(ActionPlayerStatsRound[playerid] != TD_HIDDEN) {
				ActionPlayerStatsRound[playerid] = TD_HIDDEN;

				n_for(i, sizeof(TD_PlayerStatsRound[]))
					PlayerTextDrawHide(playerid, TD_PlayerStatsRound[playerid][i]);
			}
		}
		else {
			ActionPlayerStatsRound[playerid] = TD_DESTROYED;

			n_for(i, sizeof(TD_PlayerStatsRound[]))
				DestroyPlayerTD(playerid, TD_PlayerStatsRound[playerid][i]);
		}
	}
	return 1;
}

stock UpdatePlayerStatsRound(playerid)
{
	if(ActionPlayerStatsRound[playerid] == TD_SHOWN) {
		new
			str[30];

		f(str, "Ранг: %i", GetPlayerRank(playerid));
		PlayerTextDrawSetString(playerid, TD_PlayerStatsRound[playerid][0], str);
		str[0] = EOS;

		f(str, "Убийств: %i", Mode_GetPlayerKills(playerid));
		PlayerTextDrawSetString(playerid, TD_PlayerStatsRound[playerid][1], str);
		str[0] = EOS;

		f(str, "Смертей: %i", Mode_GetPlayerDeaths(playerid));
		PlayerTextDrawSetString(playerid, TD_PlayerStatsRound[playerid][2], str);
		str[0] = EOS;
	}
	return 1;
}

stock SetPlayerAnimation(playerid, id)
{
	switch(id) {
		case 0: ApplyAnimation(playerid,"BEACH", "bather", 4.0, 1, 0, 0, 0, 0);
		case 1: ApplyAnimation(playerid,"RAPPING","RAP_A_Loop",4.0,1,0,0,0,0);
		case 2: ApplyAnimation(playerid,"RAPPING","RAP_C_Loop",4.0,1,0,0,0,0);
		case 3: ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.0, 0, 0, 0, 1, 1,1);
		case 4: ApplyAnimation(playerid,"JST_BUISNESS","girl_02",4.1,0,0,0,1,1,1);
		case 5: ApplyAnimation(playerid,"ROB_BANK","SHP_HandsUp_Scr",4.1,0,1,1,1,1,1);
		case 6: ApplyAnimation(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 0, 0, 0, 0, 0,1);
		case 7: ApplyAnimation(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0,1);
		case 8: ApplyAnimation(playerid, "BOMBER","BOM_Plant_Loop",4.0,1,0,0,1,0,1);
		case 9: ApplyAnimation(playerid,"PED","fucku",4.0,0,0,0,0,0,1);
		case 10: ApplyAnimation(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0,1);
		case 11: ApplyAnimation(playerid,"KISSING","Playa_Kiss_02",4.0, 0, 0, 0, 0, 0,1);
		case 12: ApplyAnimation(playerid,"KISSING","Grlfrd_Kiss_03",4.0, 0, 0, 0, 0, 0,1);
		case 13: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE2);
		case 14: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE3);
		case 15: SetPlayerSpecialAction(playerid,SPECIAL_ACTION_DANCE4);
		case 16: ApplyAnimation(playerid,"PARK","Tai_Chi_Loop",4.0,1,0,0,0,0);
		case 17: ApplyAnimation(playerid,"PED","IDLE_taxi",4.0,0,0,0,0,0);
		case 18: ApplyAnimation(playerid,"INT_HOUSE","LOU_In",4.1,0,0,0,1,1,1);
		case 19: ApplyAnimation(playerid,"PED","SEAT_down",4.1,0,0,0,1,1,1);
		case 20: ApplyAnimation(playerid,"SUNBATHE","Lay_Bac_in",3.0,0,1,1,1,0);
		case 21: ApplyAnimation(playerid,"BEACH","ParkSit_W_loop",3.0,0,1,1,1,0);
		case 22: ApplyAnimation(playerid,"BEACH","SitnWait_loop_W",4.0, 1, 0, 0, 0, 0);
		case 23: ApplyAnimation(playerid,"PED","IDLE_armed",4.1,0,1,1,1,1,1);
		case 24: ApplyAnimation(playerid,"PED","Gun_stand",4.1,0,1,1,1,1,1);
		case 25: ApplyAnimation(playerid, "KISSING","gfwave2", 4.1,0,1,1,0,0);
		case 26: ApplyAnimation(playerid, "ON_LOOKERS","wave_loop", 4.1,1,1,1,0,0);
		case 27: ApplyAnimation(playerid,"CAMERA","camstnd_cmon",4.0,0,0,0,0,0);
		case 28: ApplyAnimation(playerid,"PED","BIKE_fall_off",4.1,0,1,1,1,1,1);
		case 29: ApplyAnimation(playerid,"PED","BIKE_pickupL",4.1,0,0,0,0,0,1);
		case 30: ApplyAnimation(playerid,"GANGS","hndshkaa",4.0, 0, 0, 0, 0, 0,1);
		case 31: ApplyAnimation(playerid,"GANGS","hndshkfa",4.0, 0, 0, 0, 0, 0,1);
		case 32: ApplyAnimation(playerid,"GANGS","hndshkfa_swt",4.0, 0, 0, 0, 0, 0,1);
		case 33: ApplyAnimation(playerid,"BAR","dnk_stndF_loop",4.1,0,0,0,0,0,1);
		case 34: ApplyAnimation(playerid,"GANGS","shake_carK",4.0,0,0,0,0,0);
		case 35: ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1);
		case 36: ApplyAnimation(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0);
		case 37: ApplyAnimation(playerid,"GANGS","shake_cara",4.0,0,0,0,0,0);
		case 38: ApplyAnimation(playerid,"MISC","scratchballs_01",4.0,0,0,0,0,0);
		case 39: ApplyAnimation(playerid,"SPRAYCAN","spraycan_full",4.0,0,0,0,0,0);
		case 40: ApplyAnimation(playerid,"MEDIC","CPR",4.0,0,0,0,0,0);
		case 41: ApplyAnimation(playerid,"PED","KO_shot_stom",4.0,0,1,1,1,0);
		case 42: ApplyAnimation(playerid,"PED","EV_dive",4.0,0,1,1,1,0);
		case 43: ApplyAnimation(playerid,"PED","BIKE_fallR",4.0,0,1,1,1,0);
		case 44: ApplyAnimation(playerid,"GYMNASIUM","GYMshadowbox",4.0,1,1,1,1,0);
		case 45: ApplyAnimation(playerid,"benchpress","gym_bp_celebrate",4.0,0,0,0,0,0);
		case 46: ApplyAnimation(playerid,"RIOT","RIOT_ANGRY",4.0,0,0,0,0,0);
		case 47: ApplyAnimation(playerid,"BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0);
		case 48: ApplyAnimation(playerid,"PED","gang_gunstand",3.0,0,1,1,1,0);
		case 49: ApplyAnimation(playerid, "DANCING", "DAN_Right_A",4.1,1,0,0,0,0,0);
	}

	SetPlayerAnimationEx(playerid, true);

	SCM(playerid, -1, "{1ad9c9}(Анимация) {FFFFFF}Нажмите {FFFF33}ENTER/SPACE {FFFFFF}для остановки анимации.");
	return 1;
}

stock PlayerPlaySoundEx(playerid, sound, Float:x, Float:y, Float:z)
{
	PlayerPlaySound(playerid, 0, 0.0, 0.0, 0.0);
	PlayerPlaySound(playerid, sound, x, y, z);
	return 1;
}

stock SetPlayerAntiFloodChat(playerid)
{
	if(pInfo[playerid][pPremium] > 0) 
		return 1;
	
	TimerPlayerFloodText[playerid] = gettime() + 2;
	return 1;
}

publics mysql_PromoCodeShow(playerid)
{
	new
		rows;

	cache_get_row_count(rows);

	if(!rows) {
		SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Список промо-кодов отсутствует.");
		return 1;
	}
	else {
		new
			promolist[3500];

		n_for(i, rows) {
			new
				money,
				donate,
				click,
				code[32];

			cache_get_value_name(i, "Code", code, sizeof(code));
			cache_get_value_name_int(i, "Money", money);
			cache_get_value_name_int(i, "Donate", donate);
			cache_get_value_name_int(i, "Click", click);

			f(promolist, "%s"C_N"%i. {FFFFFF}Название: %s | Кредиты: +%i | Gold Coins: +%i | Кликов: %i\n", promolist, i + 1, code, money, donate, click);
		}

		SetPVarString(playerid, "ListPromCcodes_Pvar", promolist);
		Dialog_Show(playerid, Dialog:ListPromo);
	}
	return 1;
}

publics mysql_PromoCreate(playerid, code[])
{
	new
		num_rows;

	cache_get_row_count(num_rows);

	if(num_rows) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный промо-код уже существует!");
		return 1;
	}

	new
		string[1000],
		promoday = GetPVarInt(playerid, "PROMODAYS"),
		promolud = GetPVarInt(playerid, "PROMOLUD"),
		promomoney = GetPVarInt(playerid, "PROMOMONEY"),
		promodonate = GetPVarInt(playerid, "PROMODONATE"),
		promolic = GetPVarInt(playerid, "PROMOLIC");

	mysql_format(MysqlID, string, sizeof(string), "INSERT INTO `"T_PROMOCODES"` (`Code`, `Money`, `Donate`, `Click`, `Days`, `People`, `Data`) VALUES ('%s', '%d', '%d', '%d', '%d', '%d', '%d')", code, promomoney, promodonate, promolic, promoday, promolud, gettime() + promoday);
	mysql_tquery(MysqlID, string, "CreatePromoBackpack");

	f(string, "{FFFFFF}Промо-код {FFFF33}%s {FFFFFF}успешно создан\n{FFFFFF}Выдача денег: %i$\nВыдача Gold coins: %i\n\nПромо-код действует на %i дней или %i человек.", code, promomoney, promodonate, promoday, promolud);
	Dialog_Message(playerid, "Промо-код", string, "Хорошо");

	DeletePVar(playerid,"PROMONAME"), DeletePVar(playerid,"PROMODAYS"), DeletePVar(playerid,"PROMOLUD"), DeletePVar(playerid,"PROMOMONEY"), DeletePVar(playerid,"PROMODONATE"), DeletePVar(playerid,"PROMOLIC");
	return 1;
}

publics CreatePromoBackpack()
{
	cache_insert_id();
	return 1;
}

publics mysql_PromoDelete(playerid, code[])
{
	new
		num_rows;

	cache_get_row_count(num_rows);

	if(!num_rows) {
		Dialog_Show(playerid, Dialog:DeletePromo);
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данного промо-кода не существует!");
		return 1;
	}

	SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Промо-код успешно удалён");

	new
		string[100];

	mysql_format(MysqlID, string, sizeof(string), "DELETE FROM `"T_PROMOCODES"` WHERE BINARY `Code` = '%s'", code);
	mysql_tquery(MysqlID, string);
	return 1;
}

publics mysql_PromoCheck(playerid, code[])
{
	new
		num_rows;

	cache_get_row_count(num_rows);

	if(!num_rows) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данного промо-кода не существует!");
		Dialog_Show(playerid, Dialog:PlayerPromoCode);
		return 1;
	}

	new
		money,
		donate,
		click,
		days,
		people,
		data;

	cache_get_value_name_int(0, "Money", money);
	cache_get_value_name_int(0, "Donate", donate);
	cache_get_value_name_int(0, "Click", click);
	cache_get_value_name_int(0, "Days", days);
	cache_get_value_name_int(0, "People", people);
	cache_get_value_name_int(0, "Data", data);

	if(days != -1) {
		new
			times = gettime();

		if(times <= data) {
			new
				str[300];

			mysql_format(MysqlID, str, sizeof(str), "DELETE FROM `"T_PROMOCODES"` WHERE BINARY `Code`= '%s'", code);
			mysql_tquery(MysqlID, str);

			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данного промо-кода не существует!");
			Dialog_Show(playerid, Dialog:PlayerPromoCode);
			return 1;
		}
	}

	SCM(playerid, -1, "");
	SCM(playerid, -1, "{CC0033}(Промо-код) {FFFFFF}Промо-код успешно активирован!");

	new
		str[300];

	f(str, "{CC0033}(Промо-код) {FFFFFF}Получено кредитов: {14e040}+%i {FFFFFF}и gold coins: {e0be14}+%i", money, donate);
	SCM(playerid, -1, str);

	pInfo[playerid][pPromoCode] += 1;

	new
		querys[200];

	mysql_format(MysqlID, querys, sizeof(querys), "UPDATE `"T_ACCOUNTS"` SET `Promocode` = '%i' WHERE `ID` = '%d'", pInfo[playerid][pPromoCode], GetPlayerpID(playerid));
	mysql_tquery(MysqlID, querys);

	new
		query[200];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_PROMOCODES"` SET `People` = '%i', `Click` = '%i' WHERE BINARY `code` = '%s'", people, click + 1, code);
	mysql_tquery(MysqlID, query);

	new
		string[300];

	if(people > 0) {
		people--;

		if(people == 0
		&& days == -1) {
			mysql_format(MysqlID, string, sizeof(string), "DELETE FROM `"T_PROMOCODES"` WHERE BINARY `Code`= '%s'", code);
			mysql_tquery(MysqlID, string);
		}
	}
	return 1;
}

publics SCMEX(playerid, color, message[], bool:chat_text)
{
	new
		message_length = strlen(message);

	n_for(i, message_length) {
		if(message[i] == '%')
			message[i] = '#';
	}

	new
		length = strlen(message),
		outstr[128],
		trim,
		color_f[9];

	if(length > 80) {
		for(new i = 80; i >= 0; i--) {
			trim = i;
			if(message[i] == ' ') {
				for(new b = i; b >= 0; b--) {
					if(message[b] == '{') {
						n_for(v, 8)
							color_f[v] = message[b + v];

						break;
					}
				}
				break;
			}
		}
		if(trim < 64)
			trim = 80;

		strmid(outstr, message, 0, trim);
		SCM(playerid, color, outstr);

		strmid(outstr, message, trim, length);
		if(!chat_text) 
			f(outstr, "%s%s", color_f, outstr);
		else 
			f(outstr, "{FFFFFF}%s", outstr);

		SCM(playerid, color, outstr);
	}
	else
		SCM(playerid, color, message);

	return 1;
}

stock UpdatePlayerTime(playerid)
{
	Damage_UdpatePlayerIndicator(playerid);

	if(GetPlayerSecondTime(playerid) == 60) {
		SecondPlayerTimer[playerid] = 0;
		SetPlayerMinuteTime(playerid);

		if(!GetPlayerLogged(playerid)) {
			Inv_UpdatePLayerData(playerid);

			if(pInfo[playerid][pMinutes] < 60)
				pInfo[playerid][pMinutes]++;
			else if(pInfo[playerid][pMinutes] >= 60) {
				pInfo[playerid][pHours]++;
				pInfo[playerid][pMinutes] = 0;
			}
			SavePlayerTime(playerid);
		}
	}
	if(GetPlayerMinuteTime(playerid) == 60) {
		MinutePlayerTimer[playerid] = 0;
		SetPlayerHourTime(playerid);
	}

	PlayerAdsServer[playerid]++;
	if(PlayerAdsServer[playerid] >= 360) {
		PlayerAdsServer[playerid] = 0;

		if(!GetPlayerLogged(playerid)) {
			new
				ad = random(3);

			switch(ad) {
				case 0: {
					if(!Quest_GetPlayerAllPassed(playerid)) {
						SCM(playerid, 0xe08e2fFF, "{e08e2f} --------------------------------------------------------");
						SCM(playerid, 0xe08e2fFF, "{e08e2f} • {FFFFFF}У Вас есть невыполненные квесты {d14545}/quests");
						SCM(playerid, 0xe08e2fFF, "{e08e2f} • {FFFFFF}Приятной игры!");
						SCM(playerid, 0xe08e2fFF, "{e08e2f} --------------------------------------------------------");
					}
				}
				case 1: {
					SCM(playerid, 0xe08e2fFF, "{e08e2f} --------------------------------------------------------");
					SCM(playerid, 0xe08e2fFF, "{e08e2f} • {FFFFFF}Сайт проекта: {d63838}"SERVER_SITE"");
					SCM(playerid, 0xe08e2fFF, "{e08e2f} • {FFFFFF}Группа ВКонтакте: {eda258}"SERVER_VK"");
					SCM(playerid, 0xe08e2fFF, "{e08e2f} • {FFFFFF}Клиент: {5f6fe8}"SERVER_CLIENT"");
					SCM(playerid, 0xe08e2fFF, "{e08e2f} • {FFFFFF}Приятной игры!");
					SCM(playerid, 0xe08e2fFF, "{e08e2f} --------------------------------------------------------");
				}
				case 2: {
					SCM(playerid, 0xe08e2fFF, "{e08e2f} --------------------------------------------------------");
					SCM(playerid, 0xe08e2fFF, "{e08e2f} • {FFFFFF}Есть идеи по улучшению игрового сервера?");
					SCM(playerid, 0xe08e2fFF, "{e08e2f} • {FFFFFF}Тогда обращаться нужно на форум!");
					SCM(playerid, 0xe08e2fFF, "{e08e2f} • {FFFFFF}Приятной игры!");
					SCM(playerid, 0xe08e2fFF, "{e08e2f} --------------------------------------------------------");
				}
			}
		}
	}
	return 1;
}

stock SetPlayerSecondTime(playerid)
{
	SecondPlayerTimer[playerid]++;
	return 1;
}

stock GetPlayerSecondTime(playerid)
{
	return SecondPlayerTimer[playerid];
}

stock SetPlayerMinuteTime(playerid)
{
	MinutePlayerTimer[playerid]++;
	return 1;
}

stock GetPlayerMinuteTime(playerid)
{
	return MinutePlayerTimer[playerid];
}

stock SetPlayerHourTime(playerid)
{
	HourPlayerTimer[playerid]++;
	return 1;
}
stock GetPlayerHourTime(playerid)
{
	return HourPlayerTimer[playerid];
}

stock UpdatePlayerInAFK(playerid) 
{
	if(AFK_PlayerTime[playerid] == -1
	|| AFK_PlayerTime[playerid] == -2)
		AFK_PlayerTime[playerid]++;
	if(AFK_PlayerTime[playerid] >= 0) {
		AFK_PlayerTime[playerid]++;

		new
			str[50];

		f(str, "AFK %d", AFK_PlayerTime[playerid]);
		SetPlayerChatBubble(playerid, str, 0xad1a1aFF, 30.0, 3000);
	}
	return 1;
}

stock Streamer_UP(mode_id, world_id)
{
	m_for(mode_id, world_id, p)
		Streamer_Update(p);

	return 1;
}

stock IsPlayerOnServer(playerid)
{
	if(!IsPlayerConnected(playerid))
		return 0;

	if(GetPlayerLogged(playerid))
		return 0;
	
	return 1;
}

stock IsSex(sex_id)
{
	if(sex_id != SEX_MALE 
	&& sex_id != SEX_FEMALE) return 0;

	return 1;
}

stock IsPlayerInBlackList(playerid, playerid_blacklist)
{
	n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
		if(pInfo[playerid][pBlacklist][i] != GetPlayerpID(playerid_blacklist))
			continue;

		return 1;
	}
	return 0;
}

stock CheckPlayerBlacklists(playerid, playerid_blacklist)
{
	if(IsPlayerInBlackList(playerid, playerid_blacklist)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный игрок находится у Вас в чёрном списке.");
		return 1;	
	}
	if(IsPlayerInBlackList(playerid_blacklist, playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы находитесь в чёрном списке у данного игрока.");
		return 1;	
	}
	return 0;
}

stock CheckSpectatingPlayers(playerid, killerid)
{
	TDM_SquadCheckSpecPlayers(playerid);

	// Если за игроком следят умершие
	if(Iter_Count(spec_dead_playerid[playerid]) > 0) {
		if(killerid != INVALID_PLAYER_ID) {
			foreach(new p:spec_dead_playerid[playerid]) {
				Iter_Add(spec_dead_playerid[killerid], p);
				SetPlayerSpectating(p, killerid);

				if(IsPlayerInAnyVehicle(killerid))
					PlayerSpectateVehicle(p, GetPlayerVehicleID(killerid));
				else 
					PlayerSpectatePlayer(p, killerid);
			}
		}
		else {
			foreach(new p:spec_dead_playerid[playerid]) {
				RemovePlayerDead(p);
				Mode_OnPlayerSpawn(p);
			}
		}
		Iter_Clear(spec_dead_playerid[playerid]);
	}
	return 1;
}

stock ResetPlayerTDs(playerid)
{
	TD_TimerSpawnKill[playerid] = PlayerText:INVALID_TEXT_DRAW;
	TD_GangZone[playerid] = PlayerText:INVALID_TEXT_DRAW;
	TD_NewRank[playerid] = PlayerText:INVALID_TEXT_DRAW;
	TD_Dead[playerid] = PlayerText:INVALID_TEXT_DRAW;
	TD_ComputerHack[playerid] = PlayerText:INVALID_TEXT_DRAW;
	TD_PlayerKillStrike[playerid] = PlayerText:INVALID_TEXT_DRAW;

	n_for(t, sizeof(TD_ExitZone[]))
		TD_ExitZone[playerid][t] = PlayerText:INVALID_TEXT_DRAW;

	n_for(t, sizeof(TD_DeadKiller[]))
		TD_DeadKiller[playerid][t] = PlayerText:INVALID_TEXT_DRAW;

	n_for(t, sizeof(TD_PlayerStatsRound[]))
		TD_PlayerStatsRound[playerid][t] = PlayerText:INVALID_TEXT_DRAW;

	n_for(t, sizeof(TD_PlayerReward[]))
		TD_PlayerReward[playerid][t] = PlayerText:INVALID_TEXT_DRAW;

	n_for(t, sizeof(TD_FPS_and_PING[]))
		TD_FPS_and_PING[playerid][t] = PlayerText:INVALID_TEXT_DRAW;

	return 1;
}

stock LoadMapObjects()
{
	new
		tmpobjid,
		object_world = -1,
		object_int = -1;

	if(tmpobjid) {
		tmpobjid = tmpobjid + 1 - 2;
	}

	#include <sources/map-objects/desert>
	#include <sources/map-objects/airport>
	#include <sources/map-objects/stadium>
	#include <sources/map-objects/village>
	#include <sources/map-objects/golf>
	#include <sources/map-objects/military-oil>
	#include <sources/map-objects/swimming-pool>
	#include <sources/map-objects/warehouse>
	#include <sources/map-objects/ghetto>
	#include <sources/map-objects/bf>
	#include <sources/map-objects/afghan>

	#include <sources/map-objects/i-dog-mansion>
	#include <sources/map-objects/i-palace-smoke>
	#include <sources/map-objects/i-atrium>
	#include <sources/map-objects/i-jizzie>
	return 1;
}

stock ClearKillFeed(playerid = INVALID_PLAYER_ID) // by Londlem & Daniel_Cortez
{
	#if defined _INC_open_mp
		if((playerid != INVALID_PLAYER_ID) && (false == IsPlayerConnected(playerid)))
			return 0;
	#else
		if((playerid != INVALID_PLAYER_ID) && (0 == IsPlayerConnected(playerid)))
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
	if(playerid == INVALID_PLAYER_ID)
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

stock ResetPlayerGlobalVariables(playerid)
{
	AntiC{playerid} =
	PermissionPlayerSpawn{playerid} =
	ActionTDRank{playerid} = true;

	ActivePlayerClickTD{playerid} =
	ActionPlayerZone{playerid} =
	ActionPlayerInvisible{playerid} =
	ActionPlayerSpectate{playerid} =
	ActionPlayerExitZone{playerid} =
	ActionPlayerBeDamage{playerid} =
	ActionPlayerDamage{playerid} =
	ActionPlayerSpawnKill{playerid} =
	ActionPlayerJetPack{playerid} =
	ActiveCapabSpectating{playerid} =
	ActionPlayerAnimation{playerid} =
	ActionPlayerFreeze{playerid} =
	ActionPlayerKillStrike{playerid} =
	ActivePlayerTDRank{playerid} = false;

	ActionPlayerWeatherID[playerid] =
	ActionPlayerTeam[playerid] =
	ActionPlayerDead[playerid] =
	ActionPlayerBarHealth[playerid] =
	ActionPlayerBarArmour[playerid] =
	PlayerAdsServer[playerid] =
	PlayerLastDrunkLevel[playerid] =
	PlayerExitZoneTimer[playerid] =
	PlayerTimerKillStrike[playerid] =
	PlayerChetKillStrike[playerid] =
	PlayerTimerTDRank[playerid] =
	TimerPlayerFloodText[playerid] =
	TimerPlayerSpawnKill[playerid] =
	TimerPlayerBeDamage[playerid] =
	ActionPlayerBelowHealth[playerid] =
	PlayerSpectatingStatus[playerid] =
	PlayerListFirstReferal[playerid] =
	SecondPlayerTimer[playerid] =
	MinutePlayerTimer[playerid] =
	HourPlayerTimer[playerid] = 0;

	player_check_playerid[playerid] =
	PlayerAntiMoreKeys[playerid] =
	PlayerSpectating[playerid] =
	CheckPlayerIDStats[playerid] = -1;

	ActionPlayerStatsRound[playerid] =
	ActionPlayerDeadKiller[playerid] =
	ActionPlayerFPSandPING[playerid] = TD_DESTROYED;

	SetPlayerBusy(playerid, NONE);
	CheckReferalName[playerid][0] = EOS;

	PlayerStyleMelee[playerid] = FIGHT_STYLE_NORMAL;

	n_for(i, PLAYER_MAX_ANIMATIONS)
		DialogListPlayerAnims[playerid][i] = -1;

	// Black list
	PlayerListBlackListCount[playerid] = 0;

	n_for(i, 10)
		PlayerListBlacklist[playerid][i] = -1;

	// TD Reward
	PlayerTDReward[playerid][REW_ActionTextAll] = false;
	PlayerTDReward[playerid][REW_Timer] = 0;

	n_for(i, 2)
		PlayerTDReward[playerid][REW_ChetExpCredit][i] = 0;

	n_for(i, REPLEN_AMOUNT_OF_TEXT)
		PlayerTextTDReward[playerid][i] = "";

	// Player data
	pInfo[playerid][pID] = -1;

	pInfo[playerid][pOldIP][0] =
	pInfo[playerid][pName][0] =
	pInfo[playerid][pSecondPassword][0] =
	pInfo[playerid][pIP][0] =
	pInfo[playerid][pReferal][0] =
	pInfo[playerid][pNickColor][0] =
	pInfo[playerid][pData][0] =
	pInfo[playerid][pOldData][0] = EOS;

	mysql_escape_string("No Second Password", pInfo[playerid][pSecondPassword]);
	mysql_escape_string("No Referal", pInfo[playerid][pReferal]);
	mysql_escape_string("No Color", pInfo[playerid][pNickColor]);

	pInfo[playerid][pPremium] =
	pInfo[playerid][pPremiumData] =
	pInfo[playerid][pFoundServer] =
	pInfo[playerid][pSex] =
	pInfo[playerid][pRank] =
	pInfo[playerid][pExp] =
	pInfo[playerid][pCredit] =
	pInfo[playerid][pWarn] =
	pInfo[playerid][pGoldCoin] =
	pInfo[playerid][pMute] =
	pInfo[playerid][pKills] =
	pInfo[playerid][pDeaths] =
	pInfo[playerid][pWinRounds] =
	pInfo[playerid][pLossRounds] =
	pInfo[playerid][pShotsEnemy] =
	pInfo[playerid][pShotsHead] =
	pInfo[playerid][pSeriesKills] =
	pInfo[playerid][pHours] =
	pInfo[playerid][pMinutes] =
	pInfo[playerid][pPromoCode] =
	pInfo[playerid][pBDays] =
	pInfo[playerid][pBData] = 0;

	n_for(i, PLAYER_MAX_ANIMATIONS)
		pInfo[playerid][pAnimations][i] = 0;

	n_for(i, MAX_PLAYERS_IN_BLACKLIST)
		pInfo[playerid][pBlacklist][i] = -1;

	SetPlayerCustomClass(playerid, -1);
	SetPlayerCustomClass2(playerid, -1);

	Mode_SetPlayerKill(playerid, 0);
	Mode_SetPlayerDeath(playerid, 0);

	ResetPlayerMG(playerid);
	return 1;
}

stock SetPlayerIDStats(playerid, playerid2)
{
	CheckPlayerIDStats[playerid] = playerid2;
	return 1;
}

stock GetPlayerIDStats(playerid)
{
	return CheckPlayerIDStats[playerid];
}

// Mini Games

stock SetPlayerMGSettings(playerid, num)
{
	new
		timer,
		count,
		value,
		ptime;

	Mode_SetPlayerMG(playerid, num, timer, count, value, ptime);

	pMG[playerid][mg_Num] = num;
	pMG[playerid][mg_Timer] = timer;
	pMG[playerid][mg_Count] = count;
	pMG[playerid][mg_Value] = value;
	pMG[playerid][mg_pTime] = ptime;

	pMG[playerid][mg_pTimer] = SetPlayerTimer(playerid, "UpdatePlayerMiniGame", ptime, false);
	return 1;
}

stock ResetPlayerMG(playerid)
{
	if(!pMG[playerid][mg_Num])
		return 1;

	Mode_ResetPlayerMG(playerid);

	pMG[playerid][mg_Num] =
	pMG[playerid][mg_Timer] =
	pMG[playerid][mg_Count] =
	pMG[playerid][mg_Value] =
	pMG[playerid][mg_pTime] = 0;

	KillTimer(pMG[playerid][mg_pTimer]);
	return 1;
}

stock MG_SetPlayerNum(playerid, num)
{
	pMG[playerid][mg_Num] = num;
	return 1;
}

stock MG_GetPlayerNum(playerid)
{
	return pMG[playerid][mg_Num];
}

stock MG_SetPlayerTimer(playerid, num)
{
	pMG[playerid][mg_Timer] = num;
	return 1;
}

stock MG_GetPlayerTimer(playerid)
{
	return pMG[playerid][mg_Timer];
}

stock MG_SetPlayerCount(playerid, num)
{
	pMG[playerid][mg_Count] = num;
	return 1;
}

stock MG_GetPlayerCount(playerid)
{
	return pMG[playerid][mg_Count];
}

stock MG_SetPlayerValue(playerid, num)
{
	pMG[playerid][mg_Value] = num;
	return 1;
}

stock MG_GetPlayerValue(playerid)
{
	return pMG[playerid][mg_Value];
}

stock MG_SetPlayerTime(playerid, num)
{
	pMG[playerid][mg_pTime] = num;
	return 1;
}

stock MG_GetPlayerTime(playerid)
{
	return pMG[playerid][mg_pTime];
}

publics UpdatePlayerMiniGame(playerid)
{
	Mode_UpdatePlayerMG(playerid);

	pMG[playerid][mg_pTimer] = SetPlayerTimer(playerid, "UpdatePlayerMiniGame", pMG[playerid][mg_pTime], false);
	return 1;
}

stock HEXResultColor(color[], type)
{
	new
		str[15];

	switch(type) {
		case 1: { // FF
			f(str, "0x%sFF", color);
		}
		case 2: { // AA
			f(str, "0x%sAA", color);
		}
		case 3: { // BB
			f(str, "0x%sBB", color);
		}
	}
	return str;
}

publics UnfreezeCw(playerid)
{
	AntiC{playerid} = true;
	return 1;
}

stock GeneratePassword(size)
{
	new
		numbers[10][] = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"},
		password[128];

	if(size > sizeof(password))
		size = sizeof(password);
	
	n_for(i, size) {
		switch(random(4)) {
			case 0: strcat(password, numbers[random(sizeof(numbers))]);
			case 1: strcat(password, numbers[random(sizeof(numbers))]);
			case 2: strcat(password, numbers[random(sizeof(numbers))]);
			case 3: strcat(password, numbers[random(sizeof(numbers))]);
		}
	}
	return password;
}

publics PlayerFreezingPos(playerid)
{
	SetPlayerDamage(playerid, true);
	TogglePlayerControllable(playerid, true);
	return 1;
}

stock StartPlayerTimerClearAnim(playerid, seconds = 0)
{
	if(seconds == 0)
		ApplyAnimation(playerid, "BD_FIRE", "BD_Fire1", 4.1, 0, 0, 0, 0, 1, 1);
	else
		TimerPlayerClearAnim[playerid] = SetPlayerTimer(playerid, "ClearPlayerAnim", seconds, false);
	
	return 1;
}

publics ClearPlayerAnim(playerid)
{
	ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
	return 1;
}

publics SRV_Update()
{
	if(SRV_UpdateSecond < 59)
		SRV_UpdateSecond++;
	else
		SRV_UpdateSecond = 0;

	switch(SRV_UpdateSecond) {
		case 59: {}
	}

	Mode_UpdateTime();

	foreach(Player, p)
		UpdatePlayerInAFK(p);

	new
		h, m, s;

	gettime(h, m, s);
	SetWorldTime(h);
	return 1;
}

publics SRV_Update_2()
{
	Mode_UpdateTime_2();
	return 1;
}

stock ShowPlayerBeDamage(playerid)
{
	ActionPlayerBeDamage{playerid} = true;
	TimerPlayerBeDamage[playerid] = gettime() + 6;
	return 1;
}

stock HidePlayerBeDamage(playerid)
{
	ActionPlayerBeDamage{playerid} = false;
	TimerPlayerBeDamage[playerid] = 0;
	return 1;
}

stock GetPlayerBeDamage(playerid)
{
	return ActionPlayerBeDamage{playerid};
}

stock GetPlayerBeDamageTimer(playerid)
{
	return TimerPlayerBeDamage[playerid];
}

stock SetPlayerCustomClass(playerid, class_id)
{
	if(!IsPlayerOnServer(playerid))
		return 0;

	pInfo[playerid][pPlayerClass] = class_id;
	return 1;
}

stock GetPlayerCustomClass(playerid)
{
	if(!IsPlayerOnServer(playerid))
		return 0;

	return pInfo[playerid][pPlayerClass];
}

stock SetPlayerCustomClass2(playerid, class_id)
{
	if(!IsPlayerOnServer(playerid))
		return 0;

	pInfo[playerid][pPlayerClass2] = class_id;
	return 1;
}

stock GetPlayerCustomClass2(playerid)
{
	if(!IsPlayerOnServer(playerid))
		return 0;

	return pInfo[playerid][pPlayerClass2];
}

// Время респавна

stock SetPlayerSpeedRespawn(playerid, add, type)
{
	if(type)
		PlayerRespawnTimer[playerid] -= add;
	else 
		PlayerRespawnTimer[playerid] = add;

	return 1;
}

stock GetPlayerSpeedRespawn(playerid)
{
	return PlayerRespawnTimer[playerid];
}

// Слежка за игроком

stock SetPlayerSpectating(playerid, spec_playerid)
{
	PlayerSpectating[playerid] = spec_playerid;
	return 1;
}

stock GetPlayerSpectating(playerid)
{
	return PlayerSpectating[playerid];
}

stock SetPlayerSpecStatus(playerid, num)
{
	PlayerSpectatingStatus[playerid] = num;
	return 1;
}

stock GetPlayerSpecStatus(playerid)
{
	return PlayerSpectatingStatus[playerid];
}

/*
	Смерть игрока
*/

// Создание TD's

stock CreatePlayerDeadKiller(playerid, type)
{
	if(ActionPlayerDeadKiller[playerid] != TD_DESTROYED
	&& ActionPlayerDeadKiller[playerid] != TD_SHOWN) {
		ActionPlayerDeadKiller[playerid] = TD_SHOWN;

		switch(type) {
			case 1:
				PlayerTextDrawShow(playerid, TD_Dead[playerid]);
			case 2: {
				n_for(i, sizeof(TD_DeadKiller[]))
					PlayerTextDrawShow(playerid, TD_DeadKiller[playerid][i]);
			}
		}
	}
	return 1;
}

// Удаление TD's

stock DestroyPlayerDeadKiller(playerid, type, bool:hide = true)
{
	if(ActionPlayerDeadKiller[playerid] != TD_DESTROYED) {
		if(hide) {
			if(ActionPlayerDeadKiller[playerid] != TD_HIDDEN) {
				ActionPlayerDeadKiller[playerid] = TD_HIDDEN;

				switch(type) {
					case 1:
						PlayerTextDrawHide(playerid, TD_Dead[playerid]);
					case 2: {
						HidePlayerProgressBar(playerid, Bar_time_to_spawn[playerid]);

						n_for(i, sizeof(TD_DeadKiller[]))
							PlayerTextDrawHide(playerid, TD_DeadKiller[playerid][i]);
					}
					case 3: {
						PlayerTextDrawHide(playerid, TD_Dead[playerid]);
						HidePlayerProgressBar(playerid, Bar_time_to_spawn[playerid]);

						n_for(i, sizeof(TD_DeadKiller[]))
							PlayerTextDrawHide(playerid, TD_DeadKiller[playerid][i]);
					}
				}
			}
		}
		else {
			ActionPlayerDeadKiller[playerid] = TD_DESTROYED;

			switch(type) {
				case 1:
					DestroyPlayerTD(playerid, TD_Dead[playerid]);
				case 2: {
					DestroyPlayerProgressBar(playerid, Bar_time_to_spawn[playerid]);

					n_for(i, sizeof(TD_DeadKiller[]))
						DestroyPlayerTD(playerid, TD_DeadKiller[playerid][i]);
				}
				case 3: {
					DestroyPlayerTD(playerid, TD_Dead[playerid]);
					DestroyPlayerProgressBar(playerid, Bar_time_to_spawn[playerid]);

					n_for(i, sizeof(TD_DeadKiller[]))
						DestroyPlayerTD(playerid, TD_DeadKiller[playerid][i]);
				}
			}
		}
	}
	return 1;
}

stock UpdateTDDeadKiller(playerid, killerid)
{
	ShowPlayerProgressBar(playerid, Bar_time_to_spawn[playerid]);

	new
		str[100],
		Float:health,
		Float:armor;

	f(str, "%s ~y~(ID: %i)", NameEx(killerid), killerid);
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][1], str);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][1], GetPlayerColorEx(killerid));
	str[0] = EOS;

	GetPlayerHealthEx(killerid, health);
	f(str, "%.0f", health);
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][4], str);
	str[0] = EOS;

	GetPlayerArmourEx(killerid, armor);
	f(str, "%.0f", armor);
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][6], str);
	str[0] = EOS;

	f(str, "%i", GetPlayerRank(killerid));
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][10], str);
	str[0] = EOS;

	PlayerTextDrawSetPreviewModel(playerid, TD_DeadKiller[playerid][12], GetWeaponModelEx(GetPlayerWeapon(killerid)));

	if(GetWeaponModelEx(GetPlayerWeapon(killerid)) != -1) 
		PlayerTextDrawSetPreviewRot(playerid, TD_DeadKiller[playerid][12], 0.000000, 0.000000, 60.000000, 2.000000);
	else
		PlayerTextDrawSetPreviewRot(playerid, TD_DeadKiller[playerid][12], 0.000000, 0.000000, 0.000000, 1000.000000);

	GetWeaponNameRU(GetPlayerWeapon(killerid), str, sizeof(str));

	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][13], str);
	PlayerTextDrawSetString(playerid, TD_DeadKiller[playerid][8], Inv_GetBannerModel(Inv_GetPlayerBanner(killerid)));
	return 1;
}

stock ShowTDDeadKiller(playerid)
{
	ActionPlayerDeadKiller[playerid] = TD_CREATED;

	TD_DeadKiller[playerid][0] = CreatePlayerTextDraw(playerid, 240.0000, 311.0000, "_"); // Задний фон ника
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][0], 0.0000, 0.9666);
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][0], 400.6666, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][0], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][0], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_DeadKiller[playerid][0], true);
	PlayerTextDrawBoxColour(playerid, TD_DeadKiller[playerid][0], -620362002);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][0], 255);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][0], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][0], true);

	TD_DeadKiller[playerid][1] = CreatePlayerTextDraw(playerid, 241.0000, 308.0000, "_"); // Ник
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][1], 0.2643, 1.4257);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][1], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][1], -488447745);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][1], 128);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][1], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][1], true);
	PlayerTextDrawSetShadow(playerid, TD_DeadKiller[playerid][1], 1);

	TD_DeadKiller[playerid][2] = CreatePlayerTextDraw(playerid, 240.0000, 325.0000, "_"); // Задний фон хп и брони
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][2], 0.0000, 5.8333);
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][2], 291.3333, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][2], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][2], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_DeadKiller[playerid][2], true);
	PlayerTextDrawBoxColour(playerid, TD_DeadKiller[playerid][2], 1145194478);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][2], 255);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][2], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][2], true);

	TD_DeadKiller[playerid][3] = CreatePlayerTextDraw(playerid, 266.0000, 326.0000, "Здоровье:");
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][3], 0.1916, 1.4216);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][3], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][3], -690563841);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][3], 16);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][3], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][3], true);

	TD_DeadKiller[playerid][4] = CreatePlayerTextDraw(playerid, 265.0000, 338.0000, "_"); // Здоровье
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][4], 0.2613, 1.4050);
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][4], 0.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][4], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][4], -651745281);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][4], 16);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][4], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][4], true);

	TD_DeadKiller[playerid][5] = CreatePlayerTextDraw(playerid, 266.0000, 350.0000, "Броня:");
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][5], 0.1916, 1.4216);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][5], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][5], -690563841);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][5], 16);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][5], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][5], true);

	TD_DeadKiller[playerid][6] = CreatePlayerTextDraw(playerid, 265.0000, 362.0000, "_"); // Броня
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][6], 0.2613, 1.4050);
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][6], 0.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][6], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][6], 1168234239);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][6], 16);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][6], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][6], true);

	TD_DeadKiller[playerid][7] = CreatePlayerTextDraw(playerid, 296.0000, 325.0000, "_"); // Задний фон ранга
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][7], 0.0000, 5.8333);
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][7], 401.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][7], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][7], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_DeadKiller[playerid][7], true);
	PlayerTextDrawBoxColour(playerid, TD_DeadKiller[playerid][7], 1145194478);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][7], 255);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][7], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][7], true);

	TD_DeadKiller[playerid][8] = CreatePlayerTextDraw(playerid, 340.0000, 325.0000, "_"); // Картинка
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][8], 54.0000, 52.0000);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][8], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][8], 0xFFFFFFFF);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][8], 255);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][8], TEXT_DRAW_FONT_SPRITE);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][8], false);

	TD_DeadKiller[playerid][9] = CreatePlayerTextDraw(playerid, 317.0000, 336.0000, "Ранг:");
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][9], 0.1916, 1.4216);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][9], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][9], -690563841);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][9], 16);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][9], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][9], true);

	TD_DeadKiller[playerid][10] = CreatePlayerTextDraw(playerid, 316.0000, 348.0000, "_"); // Ранг
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][10], 0.2613, 1.4050);
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][10], 0.0000, 23.0000);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][10], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][10], -35964161);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][10], 16);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][10], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][10], true);

	TD_DeadKiller[playerid][11] = CreatePlayerTextDraw(playerid, 305.0000, 383.0000, "_"); // Задний фон оружия
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][11], 0.0000, 4.9333);
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][11], 401.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][11], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][11], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_DeadKiller[playerid][11], true);
	PlayerTextDrawBoxColour(playerid, TD_DeadKiller[playerid][11], 1145194478);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][11], 255);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][11], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][11], true);

	TD_DeadKiller[playerid][12] = CreatePlayerTextDraw(playerid, 316.0000, 382.0000, "_"); // Объект оружия
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][12], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][12], 0xFFFFFFFF);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][12], TEXT_DRAW_FONT_PREVIEW);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][12], false);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][12], 0x00000000);
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][12], 70.0000, 47.0000);
	PlayerTextDrawSetPreviewModel(playerid, TD_DeadKiller[playerid][12], 356);
	PlayerTextDrawSetPreviewRot(playerid, TD_DeadKiller[playerid][12], 0.0000, 30.0000, 900.0000, 2.0000);

	TD_DeadKiller[playerid][13] = CreatePlayerTextDraw(playerid, 353.0000, 414.0000, "_"); // Название оружия
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][13], 0.1750, 1.5004);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][13], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][13], -690563841);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][13], 16);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][13], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][13], true);

	TD_DeadKiller[playerid][14] = CreatePlayerTextDraw(playerid, 240.0000, 383.0000, "_"); // Задний фон таймера
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][14], 0.0000, 4.9333);
	PlayerTextDrawTextSize(playerid, TD_DeadKiller[playerid][14], 300.0000, 0.0000);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][14], TEXT_DRAW_ALIGN_LEFT);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][14], 0xFFFFFFFF);
	PlayerTextDrawUseBox(playerid, TD_DeadKiller[playerid][14], true);
	PlayerTextDrawBoxColour(playerid, TD_DeadKiller[playerid][14], 1145194478);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][14], 255);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][14], TEXT_DRAW_FONT_AHARONI_BOLD);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][14], true);

	TD_DeadKiller[playerid][15] = CreatePlayerTextDraw(playerid, 270.0000, 400.0000, "Спавн_через:");
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][15], 0.1916, 1.4216);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][15], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][15], -690563841);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][15], 16);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][15], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][15], true);

	TD_DeadKiller[playerid][16] = CreatePlayerTextDraw(playerid, 270.0000, 385.0000, "Клик_на_ЛКМ");
	PlayerTextDrawLetterSize(playerid, TD_DeadKiller[playerid][16], 0.1726, 1.4216);
	PlayerTextDrawAlignment(playerid, TD_DeadKiller[playerid][16], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_DeadKiller[playerid][16], -692027393);
	PlayerTextDrawBackgroundColour(playerid, TD_DeadKiller[playerid][16], 16);
	PlayerTextDrawFont(playerid, TD_DeadKiller[playerid][16], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_DeadKiller[playerid][16], true);

	Bar_time_to_spawn[playerid] = CreatePlayerProgressBar(playerid, 243.00, 418.00, 55.50, 6.19, 0xff0000FF, Mode_GetModeTimeRespawn(Mode_GetPlayer(playerid)), BAR_DIRECTION_RIGHT);
	HidePlayerProgressBar(playerid, Bar_time_to_spawn[playerid]);
	return 1;
}

// Фейковый убийца TD's

stock ShowTDDeath(playerid)
{
	ActionPlayerDeadKiller[playerid] = TD_CREATED;

	TD_Dead[playerid] = CreatePlayerTextDraw(playerid, 318.0000, 115.0000, "Убит_в_бою");
	PlayerTextDrawLetterSize(playerid, TD_Dead[playerid], 0.3429, 1.7451);
	PlayerTextDrawAlignment(playerid, TD_Dead[playerid], TEXT_DRAW_ALIGN_CENTER);
	PlayerTextDrawColour(playerid, TD_Dead[playerid], -534633729);
	PlayerTextDrawSetOutline(playerid, TD_Dead[playerid], 1);
	PlayerTextDrawBackgroundColour(playerid, TD_Dead[playerid], 255);
	PlayerTextDrawFont(playerid, TD_Dead[playerid], TEXT_DRAW_FONT_BANK_GOTHIC);
	PlayerTextDrawSetProportional(playerid, TD_Dead[playerid], true);
	PlayerTextDrawSetShadow(playerid, TD_Dead[playerid], 0);
	return 1;
}

stock UpdateTDTextDeath(playerid)
{
	new
		str[50],
		text_random = random(MAX_TEXTS_AFTER_DEAD);

	strcat(str, texts_after_death[text_random]);
	PlayerTextDrawSetString(playerid, TD_Dead[playerid], str);
	return 1;
}

// Действия после смерти

stock ShowDeadKiller(playerid, killerid)
{
	if(killerid == INVALID_PLAYER_ID) {
		SetPlayerDead(playerid, PLAYER_DEATH_INVALID);

		new
			Float:x,
			Float:y,
			Float:z;

		GetPlayerPos(playerid, x, y, z);
		SetPlayerCameraPos(playerid, x + 0.5, y + 0.5, z + 3.0);
		SetPlayerCameraLookAt(playerid, x, y, z);

		ResetPlayerWeaponsEx(playerid);

		UpdateTDTextDeath(playerid);
		CreatePlayerDeadKiller(playerid, 1);
	}
	else {
		SetPlayerDead(playerid, PLAYER_DEATH_KILLER);

		SetPlayerKillStrike(killerid, 1);
		ShowPlayerKillStrike(killerid);

		if(GetPlayerKillStrike(killerid) > GetPlayerSeriesKills(playerid))
			SetPlayerSeriesKill(playerid, GetPlayerKillStrike(killerid));

		SetPlayerKillStrike(playerid, 0);
		HidePlayerKillStrike(playerid);

		SetPlayerKill(killerid, 1);
		Mode_SetPlayerKill(killerid, 1);

		SetPVarInt(killerid, "DeadPlayerid_PVar", playerid);

		Mode_ShowDeadKiller(playerid, killerid);

		PlayerPlaySoundEx(killerid, 17802, 0.0, 0.0, 0.0);
		ResetPlayerWeaponsEx(playerid);

		SetPlayerSpectating(playerid, killerid);
		SpecPl(playerid, true);

		if(IsPlayerInAnyVehicle(killerid))
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(killerid));
		else
			PlayerSpectatePlayer(playerid, killerid);

		new
			str[150];
			
		f(str, "{CC0033}(Убийство) {FFFFFF}Убийство совершил: {FFFF33}%s", NameEx(killerid));
		SCM(playerid, -1, str);

		SetPlayerProgressBarValue(playerid, Bar_time_to_spawn[playerid], 0.0);
		UpdateTDDeadKiller(playerid, killerid);
		CreatePlayerDeadKiller(playerid, 2);
		UpdatePlayerStatsRound(killerid);

		Dina_CheckPlayerHint(playerid, 19);
	}

	if(GetIndicatorHealth() == PLAYER_IND_HEALTH_CUSTOM) {
		if(ActionPlayerBarHealth[playerid] == TD_SHOWN)
			SetPlayerProgressBarValue(playerid, BarHealth[playerid], 0.0);

		if(ActionPlayerBarArmour[playerid] == TD_SHOWN)
			SetPlayerProgressBarValue(playerid, BarArmour[playerid], 0.0);
	}

	DestroyBarPlayerArmour(playerid);
	UpdatePlayerStatsRound(playerid);
	return 1;
}

stock ConnectPlayerServer(playerid)
{
	PlayerConnectServerMessage(playerid);
	ShowPlayerMainMenu(playerid);

	SCM(playerid, -1, "");
	Dina_SendPlayerMessageLogin(playerid);
	return 1;
}

stock ConnectNewPlayerServer(playerid)
{
	PlayerConnectServerMessage(playerid);
	ShowPlayerMainMenu(playerid);
	return 1;
}

stock PlayerConnectServerMessage(playerid)
{
	SCM(playerid, 0x3b9de3FF, "Новости обновлений сервера {44e324}/news");
	SCM(playerid, -1, "");

	foreach(Player, p) {
		if(!IsPlayerOnServer(p)) 
			continue;

		new
			string[200];

		f(string, "{CCCCCC}%s (ID:%d) подключился к серверу.", NameEx(playerid), playerid);
		SCM(p, -1, string);
	}

	new
		str[100];
		
	f(str, "~n~~n~~n~~n~~n~~n~~b~Welcome~n~~y~~h~%s", NameEx(playerid));
	GameTextForPlayer(playerid, str, 5000, 5);
	return 1;
}

stock GetRandomKey(num)
{
	return RandomKeys[num][RK_Key];
}

stock GetRandomKeyStr(num)
{
	return RandomKeys[num][RK_KeyStr];
}

stock GetRandomColorText(num)
{
	return RandomColorText[num];
}

publics CheckPlayerBan(playerid)
{
	new
		num_rows;

	cache_get_row_count(num_rows);

	if(num_rows) {
		new
			nameadmin[MAX_PLAYER_NAME],
			seconds,
			reason[100];

		cache_get_value_name(0, "BanAdmin", nameadmin);
		cache_get_value_name_int(0, "BanSeconds", seconds);
		cache_get_value_name(0, "BanReason", reason);

		new
			times = gettime(),
			rutima[30],
			dima;

		if(floatround((seconds - times) / 60 / 60 / 24) > 1) {
			rutima = "дней";
			dima = floatround((seconds - times) / 60 / 60 / 24, floatround_ceil);
		}
		else if(floatround((seconds - times) / 60 / 60) > 1) {
			rutima = "час(ов)";
			dima = floatround((seconds - times) / 60 / 60, floatround_ceil);
		}
		else {
			rutima = "минут";
			dima = floatround((seconds - times) / 60, floatround_ceil);
		}

		if(times < seconds) {
			new
				str[600];

			f(str,
			"{FFFFFF}Аккаунт: {FFFF33}%s\
			\n\n{FFFFFF}Администратор: {FFFF33}%s\
			\n\n{FFFFFF}Заблокирован на {FFFF33}%i {FFFFFF}%s.\
			\n{FFFFFF}Причина блокировки: {CC0033}%s\
			\n\n{FFFFFF}Введите: {CC0033}/q {FFFFFF}чтобы выйти.",
			NameEx(playerid), nameadmin, dima, rutima, reason);

			Dialog_Message(playerid, "{FF6347}Данный аккаунт забанен", str, "Ok");

			SCM(playerid, -1, "{FF6347}Данный аккаунт забанен!");
			KickEx(playerid);
			return 1;
		}
		else {
			new
				string[100];

			mysql_format(MysqlID, string, sizeof(string), "DELETE FROM `"T_BANS"` WHERE BINARY `Name` = '%s' LIMIT 1", NameEx(playerid));
			mysql_tquery(MysqlID, string);
		}
	}
	else {
		new
			query[150];

		mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s'", NameEx(playerid));
		mysql_tquery(MysqlID, query, "CheckPlayerAccount", "i", playerid);
	}
	return 1;
}

stock SetIndicatorHealth(num)
{
	IndicatorPlayerHealth = num;
	return 1;
}

stock GetIndicatorHealth()
{
	return IndicatorPlayerHealth;
}

/*

	* Commands *

*/

// Test

CMD:test(playerid)
{
	TDM_SetPlayerExplosive(playerid, 5);
	return 1;
}

CMD:killtest(playerid)
{
	SetPlayerArmourEx(playerid, 0.0);
	SetPlayerHealthEx(playerid, 0.0);
	return 1;
}

CMD:weapontest(playerid)
{
	GivePlayerWeaponEx(playerid, 16, 50);
	GivePlayerWeaponEx(playerid, 28, 500);
	GivePlayerWeaponEx(playerid, 31, 500);
	return 1;
}

CMD:locsettime(playerid, params[])
{
	if(sscanf(params, "i", params[0])) 
		return InformationTextCMD(playerid, "/locsettime [время]");

	Mode_SetMinutes(M_GP(playerid), M_GPS(playerid), params[0]);
	return 1;
}

CMD:none_mode(playerid)
{
	if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING)
		return Adm_ErrorTextForPlayer(playerid);

	if(!GetPVarInt(playerid, "NONE_MODE_CMD")) {
		Mode_DestroyLocationPlayer(playerid);
		SetPVarInt(playerid, "NONE_MODE_CMD", 1);

		SCM(playerid, -1, "Выход из всех режимов прошёл успешно.");
	}
	else {
		DeletePVar(playerid, "NONE_MODE_CMD");

		SCM(playerid, -1, "Заход в режимы прошёл успешно.");
		Mode_CreateLocationPlayer(playerid, MODE_NONE, 0);
	}
	return 1;
}

//

CMD:chlen(playerid)
{
	if(IsPlayerAttachedObjectSlotUsed(playerid, 7))
		RemovePlayerAttachedObject(playerid, 7);

	if(strcmp(NameEx(playerid), "Foxze", true))
		SetPlayerAttachedObject(playerid, 7, 322, 1, -0.280000, 0.277000, 0.127999, -83.299995, 27.499996, 14.699998, 1.869000, 2.542000, 2.602000);
	else 
		SetPlayerAttachedObject(playerid, 7, 321, 1, 0.417000, 0.525999, 0.076999, -12.400009, -84.800254, 78.199996, 4.633003, 3.878999, 1.517999);
	
	return 1;
}

CMD:leave(playerid)
{
	if(Adm_GetPlayerSpectating(playerid))
		return 1;

	if(Mode_GetPlayer(playerid) == MODE_NONE)
		return 1;

	if(GetPlayerDead(playerid))
		return 1;

	Mode_LeavePlayer(playerid);
	return 1;
}

CMD:exit(playerid)
{
	return callcmd::leave(playerid);
}

CMD:v(playerid, params[])
{
	if(isnull(params))
		return InformationTextCMD(playerid, "/v [текст]");
	
	if(TimerPlayerFloodText[playerid] > gettime()) {
		SCM(playerid, -1, "{CC0033}(Анти-Флуд) {FFFFFF}Не флуди!");
		return 1;
	}

	static
		string[300];

	string[0] = EOS;

	f(string, "{eb972a}[Premium]:{%06x}%s(%d): {FFFFFF}%s", GetPlayerColorEx(playerid) >>> 8, NameEx(playerid), playerid, params);

	foreach(Player, p) {
		if(!IsPlayerOnServer(p))
			continue;

		if(!GetPlayerPremium(playerid))
			continue;

		SCMEX(p, -1, string, true);
	}
	SetPlayerAntiFloodChat(playerid);
	return 1;
}

CMD:color(playerid)
{
	if(!GetPlayerPremium(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы не являетесь премиум аккаунтом (/donate)");
		return 1;
	}

	Dialog_Show(playerid, Dialog:PlayerChangeColor);
	return 1;
}

CMD:o(playerid, params[])
{
	if(isnull(params))
		return InformationTextCMD(playerid, "/o [текст]");

	if(TimerPlayerFloodText[playerid] > gettime()) {
		SCM(playerid, -1, "{CC0033}(Анти-Флуд) {FFFFFF}Не флуди!");
		return 1;
	}

	static
		string[300];

	string[0] = EOS;

	f(string, "{CCCCCC}[OC]:{FFCC33}[Р: %i]:{%06x}%s(%d): {FFFFFF}%s", GetPlayerRank(playerid), GetPlayerColorEx(playerid) >>> 8, NameEx(playerid), playerid, params);

	foreach(Player, p) {
		if(!IsPlayerOnServer(p))
			continue;

		SCMEX(p, -1, string, true);
	}
	SetPlayerAntiFloodChat(playerid);
	return 1;
}

CMD:referals(playerid)
{
	SetCheckNameReferal(playerid, NameEx(playerid));
	Dialog_Show(playerid, Dialog:Referals);
	return 1;
}

CMD:quest(playerid)
{
	return Dialog_Show(playerid, Dialog:Quest_SelectMode);
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
	if(isnull(params))
		return InformationTextCMD(playerid, "/me [текст]");

	if(TimerPlayerFloodText[playerid] > gettime()) {
		SCM(playerid, -1, "{CC0033}(Анти-Флуд) {FFFFFF}Не флуди!");
		return 1;
	}

	new
		str[200];

	f(str, "{FFFF33}%s {FF99FF}%s", NameEx(playerid), params);

	ProxDetector(25.0, playerid, str, -1, -1, -1, -1, -1);
	SetPlayerChatBubble(playerid, str, -1, 15.0, 5000);

	SetPlayerAntiFloodChat(playerid);
	return 1;
}

CMD:anims(playerid)
{
	if(IsPlayerInAnyVehicle(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}В машине запрещено использовать анимации!");
		return 1;
	}
	if(GetPlayerAnimationEx(playerid)) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы уже используете анимацию.");
		return 1;
	}

	Dialog_Show(playerid, Dialog:PlayerBuyAnimations);
	return 1;
}

CMD:blacklist(playerid)
{
	PlayerListBlackListCount[playerid] = 0;
	
	n_for(i, 10)
		PlayerListBlacklist[playerid][i] = -1;
	
	Dialog_Show(playerid, Dialog:PlayerBlackList);
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

CMD:news(playerid)
{
	return Dialog_Show(playerid, Dialog:ServerNews);
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
	return Dialog_Show(playerid, Dialog:PlayerDonate);
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
	if(CheckPlayerIDStats[playerid] > -1)
		CheckPlayerIDStats[playerid] = -1;
	
	Dialog_Show(playerid, Dialog:ChoosePlayerStats);
}

CMD:photo(playerid)
{
	GivePlayerWeaponEx(playerid, 43, 100);
	return 1;
}

CMD:piss(playerid)
{
	SetPlayerSpecialAction(playerid, 68);

	SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Чтобы прекратить писать, нажмите {33FF00}Enter");
	return 1;
}

CMD:pm(playerid, params[])
{
	if(sscanf(params, "is[100]", params[0], params[1]))
		return InformationTextCMD(playerid, "/pm [id игрока] [текст]");

	if(!IsPlayerOnServer(params[0])) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрок не в сети.");
		return 1;
	}

	if(playerid == params[0])
		return 1;

	if(strlen(params[1]) > 39) {
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Больше 40 символов запрещено вводить.");
		return 1;
	}

	if(CheckPlayerBlacklists(playerid, params[0])) 
		return 1;

	if(TimerPlayerFloodText[playerid] > gettime()) {
		SCM(playerid, -1, "{CC0033}(Анти-Флуд) {FFFFFF}Не флуди!");
		return 1;
	}

	new
		str[500];

	f(str, "{CCCCCC}(ЛС) {FFFF33}%s (ID:%i): {FFFFFF}%s", NameEx(playerid), playerid, params[1]);
	SCM(params[0], -1, str);
	str[0] = EOS;

	f(str, "{CCCCCC}(ЛС) {FFFFFF}Игроку {FFFF33}%s (ID:%i): {FFFFFF}%s", NameEx(params[0]), params[0], params[1]);
	SCM(playerid, -1, str);

	PlayerPlaySoundEx(params[0], 1138, 0.0, 0.0, 0.0);
	PlayerPlaySoundEx(playerid, 1137, 0.0, 0.0, 0.0);

	SetPlayerAntiFloodChat(playerid);
	return 1;
}

/*

	* Dialogs *

*/

DialogCreate:Referals(playerid)
{
	new
		string[1500],
		Rank,
		Names[MAX_PLAYER_NAME],
		query[300];

	mysql_format(MysqlID, query, sizeof(query), "SELECT `Name`, `Rank` FROM `"T_ACCOUNTS"` WHERE BINARY `Referal` = '%s' LIMIT 10", CheckReferalName[playerid]);
	
	new
		Cache:result = mysql_query(MysqlID, query),
		accounts;

	cache_get_row_count(accounts);
	if(!accounts) {
		SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Игрока никто не указывал как реферал.");
		return 1;
	}
	query[0] = EOS;

	PlayerListFirstReferal[playerid] = 0;

	n_for(i, accounts) {
		Names[0] = EOS;
		Rank = 1;

		cache_get_value_name(i, "Name", Names, MAX_PLAYER_NAME);
		cache_get_value_name_int(i, "Rank", Rank);

		f(string, "%s{FFFFFF}%i. {FFFF33}%s {FFFFFF}- {CCCCCC}%i {FFFFFF}ранг\n", string, i + 1, Names, Rank);
	}
	cache_delete(result);

	Dialog_Open(playerid, Dialog:Referals, DSM, "Приглашенные", string, "Далее", "Назад");
	return 1;
}

DialogResponse:Referals(playerid, response, listitem, inputtext[])
{
	if(response)
		PlayerListFirstReferal[playerid] += 10;
	else {
		if(PlayerListFirstReferal[playerid] >= 10) 
			PlayerListFirstReferal[playerid] -= 10;
		else
			return 1;
	}

	new
		rstring[1000],
		query[300],
		Names[MAX_PLAYER_NAME],
		Rank;

	mysql_format(MysqlID, query, sizeof(query), "SELECT `Name`, `Rank` FROM `"T_ACCOUNTS"` WHERE BINARY `Referal` = '%s' LIMIT %i, 10", CheckReferalName[playerid], PlayerListFirstReferal[playerid]);

	new
		Cache:result = mysql_query(MysqlID, query),
		accounts;

	cache_get_row_count(accounts);
	if(!accounts) {
		SCM(playerid, COLOR_INFO, "(Информация) {FFFFFF}Больше вас никто не указывал как реферал.");
		return 1;
	}

	n_for(i, accounts) {
		cache_get_value_name(i, "Name", Names, MAX_PLAYER_NAME);
		cache_get_value_name_int(i, "Rank", Rank);

		f(rstring, "%s{FFFFFF}%i. {FFFF33}%s {FFFFFF}- {CCCCCC}%i {FFFFFF}ранг\n", rstring, i + 1, Names, Rank);
	}
	cache_delete(result);

	Dialog_Open(playerid, Dialog:Referals, DSM, "Приглашенные", rstring, "Далее", "Назад");
	return 1;
}

DialogCreate:ClickOnPlayerInTAB(playerid)
{
	new
		clickedplayerid = GetPVarInt(playerid, "ClickPlayerName_PVar");

	if(!IsPlayerOnServer(clickedplayerid)) {
		DeletePVar(playerid, "ClickPlayerName_PVar");

		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	new
		str_nick[MAX_PLAYER_NAME + 15];

	f(str_nick, "%s (ID:%i)", NameEx(clickedplayerid), clickedplayerid);

	Dialog_Open(playerid, Dialog:ClickOnPlayerInTAB, DSL, str_nick, ""C_N"• {FFFFFF}Отправить сообщение\n"C_N"• {FFFFFF}Сообщить о нарушении\n"C_N"• {FFFFFF}Добавить в чёрный список", "Выбрать", "Выйти");
	return 1;
}

DialogResponse:ClickOnPlayerInTAB(playerid, response, listitem, inputtext[])
{
	new
		clickedplayer = GetPVarInt(playerid, "ClickPlayerName_PVar");

	if(!IsPlayerOnServer(clickedplayer)) {
		DeletePVar(playerid, "ClickPlayerName_PVar");

		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:MessagePlayerInTAB);
			case 1: Dialog_Show(playerid, Dialog:ViolationPlayerInTAB);
			case 2: Dialog_Show(playerid, Dialog:BlackListPlayerInTAB);
		}
	}
	else
		DeletePVar(playerid, "ClickPlayerName_PVar");
	
	return 1;
}

DialogCreate:MessagePlayerInTAB(playerid)
{
	Dialog_Open(playerid, Dialog:MessagePlayerInTAB, DSI, "Отправка сообщения игроку", "{FFFFFF}Введите сообщение игроку.", "Отправить", "Назад");
	return 1;
}

DialogResponse:MessagePlayerInTAB(playerid, response, listitem, inputtext[])
{
	new
		clickedplayer = GetPVarInt(playerid, "ClickPlayerName_PVar");

	if(!IsPlayerOnServer(clickedplayer)) {
		DeletePVar(playerid, "ClickPlayerName_PVar");

		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	if(response) {
		if(!strlen(inputtext)) {
			Dialog_Show(playerid, Dialog:MessagePlayerInTAB);
			return 1;
		}
		if(strlen(inputtext) > 100) {
			Dialog_Show(playerid, Dialog:MessagePlayerInTAB);
			return 1;
		}
		if(CheckPlayerBlacklists(playerid, clickedplayer)) {
			SetPVarInt(playerid, "ClickPlayerName_PVar", clickedplayer);
			Dialog_Show(playerid, Dialog:MessagePlayerInTAB);
			return 1;
		}

		new
			str[500];

		f(str, "{CCCCCC}(PM) {FFFF33}%s (ID:%i): {FFFFFF}%s", NameEx(playerid), playerid, inputtext);
		SCM(clickedplayer, -1, str);

		str[0] = EOS;

		f(str, "{CCCCCC}(PM) {FFFF33}%s (ID:%i): {FFFFFF}%s", NameEx(clickedplayer), clickedplayer, inputtext);
		SCM(playerid, -1, str);

		PlayerPlaySoundEx(clickedplayer, 1138, 0.0, 0.0, 0.0);
		PlayerPlaySoundEx(playerid, 1137, 0.0, 0.0, 0.0);
		DeletePVar(playerid, "ClickPlayerName_PVar");
	}
	else {
		SetPVarInt(playerid, "ClickPlayerName_PVar", clickedplayer);
		Dialog_Show(playerid, Dialog:ClickOnPlayerInTAB);
	}
	return 1;
}

DialogCreate:ViolationPlayerInTAB(playerid)
{
	Dialog_Open(playerid, Dialog:ViolationPlayerInTAB, DSI, "Сообщение о нарушении", "{FFFFFF}Расскажите о нарушении игрока.", "Отправить", "Назад");
	return 1;
}

DialogResponse:ViolationPlayerInTAB(playerid, response, listitem, inputtext[])
{
	new
		clickedplayer = GetPVarInt(playerid, "ClickPlayerName_PVar");

	if(!IsPlayerOnServer(clickedplayer)) {
		DeletePVar(playerid, "ClickPlayerName_PVar");

		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	if(response) {
		if(!strlen(inputtext)) {
			Dialog_Show(playerid, Dialog:ViolationPlayerInTAB);
			return 1;
		}
		if(strlen(inputtext) > 100) {
			Dialog_Show(playerid, Dialog:ViolationPlayerInTAB);
			return 1;
		}

		foreach(new a:admin_players) {
			new
				str[500];

			f(str, "{cc1836}[A]: {FFFFFF}От игрока {FFFF33}%s (ID:%i) {FFFFFF}жалоба на {FFFF33}%s (ID:%i) {FFFFFF}Нарушение: {CC0033}%s", NameEx(playerid), playerid, NameEx(clickedplayer), clickedplayer, inputtext);
			SCM(a, -1, str);
		}

		SCM(playerid, -1, "{2fba33}(Сообщение) {FFFFFF}Ваше сообщение успешно отправлено администрации.");
		DeletePVar(playerid, "ClickPlayerName_PVar");
	}

	else {
		SetPVarInt(playerid, "ClickPlayerName_PVar", clickedplayer);
		Dialog_Show(playerid, Dialog:ClickOnPlayerInTAB);
	}
	return 1;
}

DialogCreate:BlackListPlayerInTAB(playerid)
{
	Dialog_Open(playerid, Dialog:BlackListPlayerInTAB, DSM, "Внесение игрока в чёрный список", "{FFFFFF}Вы точно хотите отправить игрока в чёрный список?", "Да", "Нет");
	return 1;
}

DialogResponse:BlackListPlayerInTAB(playerid, response, listitem, inputtext[])
{
	new
		clickedplayer = GetPVarInt(playerid, "ClickPlayerName_PVar");

	if(!IsPlayerOnServer(clickedplayer)) {
		DeletePVar(playerid, "ClickPlayerName_PVar");
		
		SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Игрока нет на сервере.");
		ClosePlayerDialog(playerid);
		return 1;
	}

	if(response) {
		new
			proverka_2;
		
		n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
			if(pInfo[playerid][pBlacklist][i] != GetPlayerpID(clickedplayer)) 
				continue;

			proverka_2++;
			break;
		}
		if(proverka_2 > 0) {
			DeletePVar(playerid, "ClickPlayerName_PVar");
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данный игрок уже находится в чёрном списке.");
			return 1;
		}

		new
			proverka;
		
		n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
			if(pInfo[playerid][pBlacklist][i] > -1 && pInfo[playerid][pBlacklist][i] != 0) 
				continue;

			pInfo[playerid][pBlacklist][i] = GetPlayerpID(clickedplayer);
			proverka++;
			break;
		}
		if(proverka > 0) {
			SavePlayerBlacklist(playerid);
			SCM(playerid, -1, "{2fba33}(Чёрный список) {FFFFFF}Игрок успешно добавлен в чёрный список.");

			new
				str[300];
			
			f(str, "{CC0033}(Чёрный список) {FFFFFF}Игрок {FFFF33}%s (ID:%i) {FFFFFF}добавил Вас в чёрный список.", NameEx(playerid), playerid);
			SCM(clickedplayer, -1, str);
		}
		else
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Достигнут предел чёрного списка. Введите {FFFF33}/blacklist");

		DeletePVar(playerid, "ClickPlayerName_PVar");
	}
	else {
		SetPVarInt(playerid, "ClickPlayerName_PVar", clickedplayer);
		Dialog_Show(playerid, Dialog:ClickOnPlayerInTAB);
	}
	return 1;
}

DialogCreate:ChoosePlayerStats(playerid)
{
	Dialog_Open(playerid, Dialog:ChoosePlayerStats, DSL, "Статистика", ""C_N"• {FFFFFF}Общая статистика\n"C_N"• {FFFFFF}Статистика классов", "Выбрать", "Назад");
	return 1;
}

DialogResponse:ChoosePlayerStats(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:PlayerStats);
			case 1: Dialog_Show(playerid, Dialog:TDM_ChooseStatsClass);
		}
	}
	else {
		if(CheckPlayerIDStats[playerid] > -1) 
			return CheckPlayerIDStats[playerid] = -1;

		if(GetPlayerBusy(playerid) != MAIN_MENU) 
			Dialog_Show(playerid, Dialog:PlayerMenu);
	}
	return 1;
}

DialogCreate:Help(playerid)
{
	Dialog_Open(playerid, Dialog:Help, DSL, "Помощь", ""C_N"• {c21717}Частые вопросы\n"C_N"• {c21717}Правила сервера\n"C_N"• {FFFFFF}Информация об сервере\n"C_N"• {FFFFFF}Режимы и локации\n"C_N"• {FFFFFF}Команды\n"C_N"• {FFFFFF}Анимации\n"C_N"• {FFFFFF}Навыки", "Выбрать", "Назад");
	return 1;
}

DialogResponse:Help(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				Dialog_Message(playerid, "Частые вопросы", "\
				{FFFFFF}Как здесь играть? - Всё просто, в главном меню зайдите во вкладку\"Подключиться\" и далее выберайте режим для игры.\
				\nКак получать опыт и кредиты? - Играйте и пробуйте все режимы на сервере.\
				\nЗачем мне опыт и кредиты? - Для прокачки персонажа, способностей и т.д.\
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
				\n{FFFFFF}1. Запрещается использовать программы, читы, моды и т.д. дающие преимущество в игре.\
				\n2. Запрещается входить в АФК длительное время.\
				\n3. Запрещается любая ускоренная прокачка персонажа.\
				\n4. Запрещается использование ошибок, багов и недоработок мода.\
				\n5. Запрещается использование клавиши <ESC> для спасения персонажа.\
				\n\n{1ced3c}Правила общения:\
				\n{FFFFFF}1. Запрещается использовать нецензурную лексику, оскорбление в чей-то адрес.\
				\n2. Запрещается дерзкое отношение к игрокам и администрации.\
				\n3. Запрещается рекламировать что-либо.\
				\n4. Запрещается флудить в чате.\
				", "Назад");
			}
			case 2: {
				Dialog_Message(playerid, "Информация об сервере", "\
				{FFFFFF}"SERVER_NAME_CORE" — динамичный и захватывающий игровой сервер.\
				\nНа сервере присутствует множество уникальных режимов.\
				\nОбъедините силы с друзьями, чтобы уничтожить многочисленных противников.\
				\nК примеру, в TDM режиме игроки могут выбрать один из четырех классов, каждый из которых\
				\nобладает своими тактическими возможностями и особенностями: штурмовика, разведчика, и так далее.\
				\n\n{ebc81a}Особенности:\
				\n{FFFFFF}- Широкие игровые возможности.\
				\n- Качественно проработанный с нуля игровой мод.\
				\n- Множество режимов и бесконечное совершенство.\
				\n{FFFFFF}Сайт - {ebc81a}"SERVER_SITE"\
				\n{FFFFFF}Группа ВКонтакте - {ebc81a}"SERVER_VK"\
				", "Назад");
			}
			case 3: Dialog_Show(playerid, Dialog:InfoModes);
			case 4: Dialog_Show(playerid, Dialog:CommandsServer);
			case 5: {
				Dialog_Message(playerid, "Анимации", "\
				{FFFFFF}Используйте команду /anims для анимации.\
				", "Назад");
			}
			case 6: {
				Dialog_Message(playerid, "Навыки", "\
				{FFFFFF}Для прокачки разновидных навыков необходимо просто играть.\
				\nВсю информацию можно узнать в процессе игры.\
				", "Назад");
			}
		}
	}
	else {
		if(GetPlayerBusy(playerid) != MAIN_MENU)
			Dialog_Show(playerid, Dialog:PlayerMenu);
	}
	return 1;
}

DialogCreate:InfoModes(playerid)
{
	Dialog_Open(playerid, Dialog:InfoModes, DSL, "Режимы и локации", ""C_N"• {FFFFFF}Информация\n"C_N"• {FFFFFF}Режим: TDM\n"C_N"• {FFFFFF}Режим: DM\n"C_N"• {FFFFFF}Комната", "Выбрать", "Назад");
	return 1;
}

DialogResponse:InfoModes(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				Dialog_Message(playerid, "Информация", "\
				{FFFFFF}На сервере присутствуют режимы, подрежимы и уникальные локации.\
				\n{ebba1a}Режим {FFFFFF}- это совокупность элементов игры, которые нужны для победы.\
				\n{ebba1a}Подрежим {FFFFFF}- это один из элементов режима, имеющий свои определённые качества.\
				\n{ebba1a}Локации {FFFFFF}- это место где можно взаимодействовать с элементами определённого режима и подрежима.\
				", "Назад");
			}
			case 1: {
				new
					str[2000];
				
				str = "{FFFFFF}Режим TDM является командым. Игрок в любой команде должен сражаться вместе с союзниками.\
				\nДля победы команде необходимо следовать правилам подрежима.\
				\nПри заходе в режим автоматически выбирается команда и имеется возможность выбрать класс персонажа:\
				\nШтурмовик, Медик, Инженер и Разведчик.\
				\nУ каждого класса существуют свои возможности, способности и оружие.\
				\nО правилах подрежима можно узнать при заходе на локацию.\n\nЛокации:\n";

				n_for(i, TDM_MAX_LOCATIONS)
					f(str, "%s{CCCCCC}%s: {e8d71c}[%s]\n", str, TDM_GetNameLocation(i), TDM_GetModeName(TDM_GetModeLocation(i)));

				Dialog_Message(playerid, "Режим: TDM", str, "Назад");
			}
			case 2: {
				new
					str[2000];
				
				str = "{FFFFFF}Режим DM является игрой в соло. Игрок должен побеждать других игроков.\
				\nИгроки сражаются между собой до смены локации и дальше по новой.\
				\nИмеются 3 подрежима: нормальный, дигл (+c) и снайпер.\
				\n\nЛокации:\n";

				n_for(i, DM_MAX_LOCATIONS)
					f(str, "%s{CCCCCC}%s: {e8d71c}[%s]\n", str, DM_GetNameLocation(i), DM_GetModeName(DM_GetModeLocation(i)));

				Dialog_Message(playerid, "Режим: DM", str, "Назад");
			}
			case 3: {
				Dialog_Message(playerid, "Комната", "\
				{FFFFFF}Режим комнаты - это то место, где можно по экспериментировать.\
				\nВ данном режиме можно выбрать кол-во играющих игроков, локацию, оружие и т.д.\
				\nСписок локаций можно посмотреть только при выборе локаций.\
				", "Назад");
			}
		}
	}
	else
		Dialog_Show(playerid, Dialog:Help);
	
	return 1;
}

DialogCreate:CommandsServer(playerid)
{
	Dialog_Open(playerid, Dialog:CommandsServer, DSM, "Команды", "\
	{CCCCCC}/leave {FFFFFF}- выйти из режима.\
	\n{CCCCCC}/menu {FFFFFF}- главное меню.\
	\n{CCCCCC}/stats {FFFFFF}- статистика персонажа.\
	\n{CCCCCC}/donate {FFFFFF}- донат.\
	\n{CCCCCC}/o {FFFFFF}- основной чат.\
	\n{CCCCCC}/e {FFFFFF}- завести/заглушить транспорт.\
	\n{CCCCCC}/anims {FFFFFF}- список анимаций.\
	\n{CCCCCC}/referals {FFFFFF}- рефералы.\
	\n{CCCCCC}/me {FFFFFF}- действие от 3 лица.\
	\n{CCCCCC}/cmds {FFFFFF}- команды.\
	\n{CCCCCC}/report {FFFFFF}- связь с администрацией.\
	\n{CCCCCC}/photo {FFFFFF}- получить фотоаппарат.\
	\n{CCCCCC}/piss {FFFFFF}- пописать.\
	\n{CCCCCC}/pm {FFFFFF}- написать личное сообщение.\
	\n{CCCCCC}/blacklist {FFFFFF}- чёрный список.\
	\n{CCCCCC}/bug {FFFFFF}- сообщить про баг.\
	", "Назад", "");
	return 1;
}

DialogResponse:CommandsServer(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:Help);
	return 1;
}

DialogCreate:PlayerOptions(playerid)
{
	new
		str[300];

	new
		sex[50];

	if(GetPlayerSex(playerid) == SEX_MALE)
		sex = "{FFFF33}Мужской{FFFFFF}";
	else
		sex = "{FFFF33}Женский{FFFFFF}";

	f(str, "\
	\n"C_N"• {FFFFFF}Пол\t[%s]", sex);

	Dialog_Open(playerid, Dialog:PlayerOptions, DST, "Опции", str, "Выбрать", "Назад");
	return 1;
}

DialogResponse:PlayerOptions(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				if(GetPlayerSex(playerid) == SEX_MALE)
					SetPlayerSex(playerid, SEX_FEMALE);
				else if(GetPlayerSex(playerid) == SEX_FEMALE)
					SetPlayerSex(playerid, SEX_MALE);

				new
					query[150];
				
				mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Sex` = '%i' WHERE `ID` = '%d'", GetPlayerSex(playerid), GetPlayerpID(playerid));
				mysql_tquery(MysqlID, query);
				
				Dialog_Show(playerid, Dialog:PlayerOptions);
			}
		}
	}
	else {
		if(GetPlayerBusy(playerid) != MAIN_MENU)
			Dialog_Show(playerid, Dialog:PlayerMenu);
	}
	return 1;
}

DialogCreate:PlayerStats(playerid)
{
	new
		showplayerid = playerid;

	if(CheckPlayerIDStats[playerid] > -1) {
		if(IsPlayerInvalided(CheckPlayerIDStats[playerid]))
			playerid = CheckPlayerIDStats[playerid];
	}

	static
		string[3700];

	string[0] = EOS;

	new
		sextext[30], 
		premium_text[30];

	if(GetPlayerSex(playerid) == SEX_MALE)
		sextext = "мужской";
	else
		sextext = "женский";

	new
		hourstext[30],
		minutestext[30];

	switch(pInfo[playerid][pHours]) {
		case 1: hourstext = "час";
		case 2, 3, 4: hourstext = "часа";
		default: hourstext = "часов";
	}
	switch(pInfo[playerid][pMinutes]) {
		case 1: minutestext = "минута";
		case 2, 3, 4: minutestext = "минуты";
		default: minutestext = "минут";
	}
	
	if(pInfo[playerid][pPremium] > 0)
		premium_text = "{69CA21}Да";
	else
		premium_text = "{CC0033}Нет";

	new
		Float:KD = float(GetPlayerKills(playerid)) / float(GetPlayerDeaths(playerid));

	if(KD <= 0.0)
		KD = 0.0;

	new
		tdm_quests = Quest_CheckPlayerPassedCount(playerid, MODE_TDM),
		dm_quests = Quest_CheckPlayerPassedCount(playerid, MODE_DM);

	f(string,
	"{CCCCCC}Ник: {fcd060}[%s]\
	\n{CCCCCC}Аккаунт: {FFFFFF}[№%i]\
	\n{CCCCCC}Ранг: {FFFFFF}[%i]\
	\n{CCCCCC}Опыт: {FFFFFF}[%i/%i]\
	\n{CCCCCC}Кредитов: {FFFFFF}[%i$]\
	\n{CCCCCC}Gold coin: {e8e85d}[%i]\
	\n{CCCCCC}Пол: {FFFFFF}[%s]\
	\n{CCCCCC}Премиум: {FFFFFF}[%s{CCCCCC}]\
	\n{CCCCCC}Времени в игре: {FFFFFF}[%i %s %i %s]\
	\n\
	\n{CCCCCC}Убийств: {FFFFFF}[%i]\
	\n{CCCCCC}Смертей: {FFFFFF}[%i]\
	\n{CCCCCC}K/D: {ffebba}[%.1f]\
	\n{CCCCCC}Победных раундов: {FFFFFF}[%i]\
	\n{CCCCCC}Проигрышных раундов: {FFFFFF}[%i]\
	\n{CCCCCC}Выстрелов по врагу: {FFFFFF}[%i]\
	\n{CCCCCC}Выстрелов в голову: {FFFFFF}[%i]\
	\n{CCCCCC}Высокая серия убийств: {FFFFFF}[%i]\
	\n{CCCCCC}Предупреждений: {FFFFFF}[%i]\
	\n{CCCCCC}Дата регистрации: {FFFFFF}[%s]\
	\n\
	\n{CCCCCC}[TDM] Выполнено квестов: {e6ae20}[%i/%i]\
	\n{CCCCCC}[DM] Выполнено квестов: {e6ae20}[%i/%i]",
	NameEx(playerid), GetPlayerpID(playerid), GetPlayerRank(playerid), GetPlayerExp(playerid), CheckPlayerNextRank(playerid), GetPlayerCredits(playerid), pInfo[playerid][pGoldCoin], sextext, premium_text, pInfo[playerid][pHours], hourstext, pInfo[playerid][pMinutes], minutestext,
	GetPlayerKills(playerid), GetPlayerDeaths(playerid), KD, GetPlayerWinRounds(playerid), GetPlayerLossRounds(playerid), GetPlayerShotsEnemy(playerid), GetPlayerShotsHead(playerid), GetPlayerSeriesKills(playerid), pInfo[playerid][pWarn], pInfo[playerid][pData],
	tdm_quests, Mode_GetMaxQuests(MODE_TDM), dm_quests, Mode_GetMaxQuests(MODE_DM));
	
	Dialog_Open(showplayerid, Dialog:PlayerStats, DSM, "Общая статистика", string, "Назад", "");
	return 1;
}

DialogResponse:PlayerStats(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:ChoosePlayerStats);
	return 1;
}

DialogCreate:PlayerMenu(playerid)
{
	Dialog_Open(playerid, Dialog:PlayerMenu, DSL, "Меню сервера",
	""C_N"• {FFFFFF}Статистика\
	\n"C_N"• {FFFFFF}Помощь\
	\n"C_N"• {FFFFFF}Донат\
	\n"C_N"• {FFFFFF}Опции\
	\n"C_N"• {FFFFFF}Безопасность\
	\n"C_N"• {FFFFFF}Топ игроков\
	\n"C_N"• {FFFFFF}Промо-код\
	\n"C_N"• {FFFFFF}Правила игры\
	\n"C_N"• {FFFFFF}Новости", "Выбрать", "Выйти");
	return 1;
}

DialogResponse:PlayerMenu(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:ChoosePlayerStats);
			case 1: Dialog_Show(playerid, Dialog:Help);
			case 2: Dialog_Show(playerid, Dialog:PlayerDonate);
			case 3: Dialog_Show(playerid, Dialog:PlayerOptions);
			case 4: Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
			case 5: Dialog_Show(playerid, Dialog:SelectTopPlayers);
			case 6: {
				if(GetPlayerRank(playerid) < 10) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Для активации промо-кода требуется 10 ранг!");

					if(GetPlayerBusy(playerid) != MAIN_MENU) 
						Dialog_Show(playerid, Dialog:PlayerMenu);
					
					return 1;
				}
				if(pInfo[playerid][pPromoCode] == 1) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы уже активировали промо-код!");

					if(GetPlayerBusy(playerid) != MAIN_MENU) 
						Dialog_Show(playerid, Dialog:PlayerMenu);
					
					return 1;
				}
				Dialog_Show(playerid, Dialog:PlayerPromoCode);
			}
			case 7: Dialog_Show(playerid, Dialog:ServerRules);
			case 8: Dialog_Show(playerid, Dialog:ServerNews);
			case 9: Dialog_Show(playerid, Dialog:PlayerMenu);
		}
	}
	return 1;
}

DialogCreate:PlayerChangeSecurity(playerid)
{
	new
		string[500],
		secpass[50];

	if(strcmp(pInfo[playerid][pSecondPassword], "No Second Password", true)) 
		secpass = "{69CA21}Вкл";
	else 
		secpass = "{CC0033}Выкл";

	f(string, ""C_N"• {FFFFFF}Изменить пароль\n"C_N"• {FFFFFF}Второй пароль\t[%s{FFFFFF}]", secpass);
	Dialog_Open(playerid, Dialog:PlayerChangeSecurity, DST, "Безопасность", string, "Выбрать", "Назад");
	return 1;
}

DialogResponse:PlayerChangeSecurity(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				SetErrorText(playerid, "");
				Dialog_Show(playerid, Dialog:PlayerChangePassword);
			}
			case 1: {
				if(Mode_GetPlayer(playerid) != MODE_NONE 
				|| GetPlayerBusy(playerid) != MAIN_MENU 
				|| Interface_IsOpen(playerid, Interface:SecondPassword)) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данную функцию можно изменить только в главном меню.");
					Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
					return 1;
				}
				Dialog_Show(playerid, Dialog:PlayerSecondPassword);
			}
		}
	}
	else {
		if(GetPlayerBusy(playerid) != MAIN_MENU) 
			Dialog_Show(playerid, Dialog:PlayerMenu);
	}
	return 1;
}

DialogCreate:PlayerChangeColor(playerid)
{
	Dialog_Open(playerid, Dialog:PlayerChangeColor, DSL, "Изменение цвета ника",
	""C_N"• {FFFFFF}Изменить цвет\
	\n"C_N"• {FFFFFF}Сбросить цвет",
	"Выбрать", "Выйти");
	return 1;
}

DialogResponse:PlayerChangeColor(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:PlayerInputColor);
			case 1: {
				if(Mode_GetPlayer(playerid) != MODE_NONE) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Данную функцию можно изменить только в главном меню.");
					return 1;
				}

				pInfo[playerid][pNickColor][0] = EOS;
				mysql_escape_string("No Color", pInfo[playerid][pNickColor]);
				SetPlayerColorEx(playerid, 0xCCCCCC00);
				SavePlayerNickColor(playerid);
			}
		}
	}
	return 1;
}

DialogCreate:PlayerInputColor(playerid)
{
	Dialog_Open(playerid, Dialog:PlayerInputColor, DSI, "Изменение цвета ника",
	"{FFFFFF}Введите RGB цвет.\
	\nЦвета можно найти на сайте {eb901a}https://colorscheme.ru",
	"Изменить", "Выйти");
	return 1;
}

DialogResponse:PlayerInputColor(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) 
			return Dialog_Show(playerid, Dialog:PlayerInputColor);
		
		for(new i = strlen(inputtext) - 1; i != -1; i--) {
			switch(inputtext[i]) {
				case '0'..'9', 'a'..'z', 'A'..'Z': continue;
				default: {
					SCM(playerid, -1, "{CC0033}Ошибка: цвет должен содержать латинские символы и цифры!");
					Dialog_Show(playerid, Dialog:PlayerInputColor);
					return 1;
				}
			}
		}
		if(strlen(inputtext) < 1 || strlen(inputtext) > 6) {
			SCM(playerid, -1, "{CC0033}Ошибка: символов должно быть не меньше 1 и не больше 6!");
			Dialog_Show(playerid, Dialog:PlayerInputColor);
			return 1;	
		}	

		pInfo[playerid][pNickColor][0] = EOS;
		mysql_escape_string(inputtext, pInfo[playerid][pNickColor]);

		SetPlayerColorEx(playerid, HexToInt(HEXResultColor(pInfo[playerid][pNickColor], 1)));
		SavePlayerNickColor(playerid);
	}
	return 1;
}

DialogCreate:ServerNews(playerid)
{
	Dialog_Open(playerid, Dialog:ServerNews, DSL, "Новости сервера", 
	"{e32424}• {FFFFFF}Новогоднее обновление!\
	\n{44e324}• {FFFFFF}Открытие сервера!",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:ServerNews(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				Dialog_Message(playerid, "Новогоднее обновление", 
				"{e32424}Новогоднее обновление 30.12.2020\
				\n\n{FFFFFF}Наша команда выпустила новогоднее обновление в честь Нового Года!\
				\n- Добавлено новогоднее окружение и атмосфера.\
				\n- Во всех режимах и картах добавлены ёлки и подарки.\
				\n- Теперь можно собирать подарки под ёлками в режиме TDM и DM.\
				\nЕсли хотите узнать сколько у Вас подарков, то это возможно при помощи команды /stats\
				\n- В главном меню (/menu) размещён обмен подарками, которые вы нашли!\
				\nИмеется возможность обменять подарки на рандомные скины и аксессуары, а также на GoldCoins!\
				\n- Добавлено 10 новых новогодних квестов (/quests)!\
				\nПосле их выполнения выдаётся много опыта и кредитов!", 
				"Назад");
			}
			case 1: {
				Dialog_Message(playerid, "Открытие сервера", 
				"{44e324}Открытие сервера 03.01.2021\
				\n\n{FFFFFF}Наша команда работала не один год и теперь мы заявляем об открытии сервера!\
				\nСервер проходил всевозможные тестирования и теперь он полностью готов!\
				\nНасколько он готов могут сказать только наши преданные игроки.\
				\nМы не остановимся и будет продолжать развивать проект вместе с нашими игроками!", 
				"Назад");
			}
		}
	}
	else {
		if(GetPlayerBusy(playerid) != MAIN_MENU) 
			Dialog_Show(playerid, Dialog:PlayerMenu);
	}
	return 1;
}

DialogCreate:PlayerDonate(playerid)
{
	new
		str[50];

	f(str, "На счету %i GoldCoins", GetPlayerGoldCoins(playerid));

	Dialog_Open(playerid, Dialog:PlayerDonate, DSL, str,
	""C_N"• {FFFFFF}Игровая валюта\t{19b529}[50 GoldCoins > 10.000$]\
	\n"C_N"• {FFFFFF}Премиум аккаунт\t{19b529}[250 GoldCoins]",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:PlayerDonate(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				if(GetPlayerGoldCoins(playerid) < 50) {
					SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Необходимо иметь 50 GoldCoins");
					Dialog_Show(playerid, Dialog:PlayerDonate);
					return 1;
				}

				SetPlayerGoldCoins(playerid, -50);
				SetPlayerCredit(playerid, 10000);

				SCM(playerid, -1, "{2deb39}(Информация) {FFFFFF}10.000 кредитов успешно приобретены!");
				Dialog_Show(playerid, Dialog:PlayerDonate);
			}
			case 1: Dialog_Show(playerid, Dialog:PlayerBuyPremium);
		}
	}
	else {
		if(GetPlayerBusy(playerid) != MAIN_MENU) 
			Dialog_Show(playerid, Dialog:PlayerMenu);
	}
	return 1;
}

DialogCreate:PlayerBuyPremium(playerid)
{
	new
		str[1000];
	
	f(str,
	"{FFFFFF}Покупка: {eba82d}Премиум аккаунт\
	\n{FFFFFF}Стоимость: {ebdb2d}250 GoldCoins\
	\n{FFFFFF}На счету: {ebdb2d}%i GoldCoins\
	\n\n{FFFFFF}Возможности:\
	\n{2deb66}• {FFFFFF}Чат между владельцами премиум аккаунтов (/v).\
	\n{2deb66}• {FFFFFF}Просмотр онлайн администрации (/admins).\
	\n{2deb66}• {FFFFFF}Установка личного цвета своего ника (/color).\
	\n{2deb66}• {FFFFFF}Все анти-флуды не будут действовать.\
	\n{2deb66}• {FFFFFF}Получения оружие РПГ в TDM режиме.\
	\n{2deb66}• {FFFFFF}Получение x2 опыта.\
	\n\n{eb2d2d}• {FFFFFF}Премиум аккаунт будет действовать целый месяц после покупки!", GetPlayerGoldCoins(playerid));
	Dialog_Open(playerid, Dialog:PlayerDonate, DSM, "Покупка Премиум аккаунта", str, "Купить", "Назад");
	return 1;
}

DialogResponse:PlayerBuyPremium(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(GetPlayerPremium(playerid) > 0) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Вы уже обладаете Премиум аккаунтом");
			Dialog_Show(playerid, Dialog:PlayerDonate);
			return 1;
		}
		if(GetPlayerGoldCoins(playerid) < 250) {
			SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Необходимо иметь 250 GoldCoins");
			Dialog_Show(playerid, Dialog:PlayerDonate);
			return 1;
		}

		SetPlayerGoldCoins(playerid, -250);
		pInfo[playerid][pPremium] = 1;
		pInfo[playerid][pPremiumData] = gettime() + 30 * 60 * 60 * 24;
		SavePlayerPremium(playerid);

		SCM(playerid, -1, "{2deb39}(Информация) {FFFFFF}Премиум аккаунт успешно приобретён на целый месяц!");
		Dialog_Show(playerid, Dialog:PlayerDonate);
	}
	else {
		if(GetPlayerBusy(playerid) != MAIN_MENU) 
			Dialog_Show(playerid, Dialog:PlayerDonate);
	}
	return 1;
}

DialogCreate:SelectTopPlayers(playerid)
{
	Dialog_Open(playerid, Dialog:SelectTopPlayers, DSL, "Топ игроков", ""C_N"• {FFFFFF}Топ по убийствам\n"C_N"• {FFFFFF}Топ по кредитам", "Выбрать", "Назад");
	return 1;
}

DialogResponse:SelectTopPlayers(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:TopKillsPlayers);
			case 1: Dialog_Show(playerid, Dialog:TopCreditsPlayers);
		}
	}
	else {
		if(GetPlayerBusy(playerid) != MAIN_MENU) 
			Dialog_Show(playerid, Dialog:PlayerMenu);
	}
	return 1;
}

DialogCreate:TopKillsPlayers(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_ACCOUNTS"` ORDER BY `Kills` DESC LIMIT 10");
	mysql_query(MysqlID, query, true);

	new
		rows;

	cache_get_row_count(rows);

	new
		str[1000];

	if(rows) {
		n_for(i, rows) {
			new
				Names[MAX_PLAYER_NAME], 
				kills;

			cache_get_value_name(i, "Name", Names, sizeof(Names));
			cache_get_value_name_int(i, "Kills", kills);

			f(str, "%s{FFFFFF}%i. {CCCCCC}%s: {c71212}[%i]\n", str, i + 1, Names, kills);
		}
	}
	else
		str = "{FFFFFF}Игроков не найдено";

	Dialog_Open(playerid, Dialog:TopKillsPlayers, DSM, "Топ 10 игроков по убийствам", str, "Назад", "");
	return 1;
}

DialogResponse:TopKillsPlayers(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:SelectTopPlayers);
	return 1;
}

DialogCreate:TopCreditsPlayers(playerid)
{
	new
		query[250],
		rows,
		str[1000];

	mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_ACCOUNTS"` ORDER BY `Credit` DESC LIMIT 10");
	mysql_query(MysqlID, query, true);

	cache_get_row_count(rows);

	if(rows) {
		n_for(i, rows) {
			new
				Names[MAX_PLAYER_NAME],
				credits;

			cache_get_value_name(i, "Name", Names, sizeof(Names));
			cache_get_value_name_int(i, "Credit", credits);

			f(str, "%s{FFFFFF}%i. {CCCCCC}%s: {12c724}[%i$]\n", str, i + 1, Names, credits);
		}
	}
	else
		str = "{FFFFFF}Игроков не найдено";

	Dialog_Open(playerid, Dialog:TopCreditsPlayers, DSM, "Топ 10 игроков по кредитам", str, "Назад", "");
	return 1;
}

DialogResponse:TopCreditsPlayers(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:SelectTopPlayers);
	return 1;
}

DialogCreate:ServerOptions(playerid)
{
	Dialog_Open(playerid, Dialog:ServerOptions, DSL, "Настройки сервера", "\
	"C_N"• {FFFFFF}Промо-коды\
	\n"C_N"• {FFFFFF}Античит",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:ServerOptions(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING) {
					Adm_ErrorTextForAdmin(playerid);
					Dialog_Show(playerid, Dialog:ServerOptions);
					return 1;
				}
				Dialog_Show(playerid, Dialog:SelectOptionPromo);
			}
			case 1: {
				if(Adm_GetPlayerLevel(playerid) < ADM_LEVEL_STEERING) {
					Adm_ErrorTextForAdmin(playerid);
					Dialog_Show(playerid, Dialog:ServerOptions);
					return 1;	
				}
				pAntiCheatSettingsPage{playerid} = 1;
				Dialog_Show(playerid, Dialog:AC_Settings);
			}
		}
	}
	else
		Dialog_Show(playerid, Dialog:Adm_Menu);
	
	return 1;
}

DialogCreate:SelectOptionPromo(playerid)
{
	Dialog_Open(playerid, Dialog:SelectOptionPromo, DSL, "Промо-коды", "\
	"C_N"• {FFFFFF}Список промо-кодов\
	\n"C_N"• {FFFFFF}Создать промо-код\
	\n"C_N"• {FFFFFF}Удалить промо-код",
	"Выбрать", "Назад");
	return 1;
}

DialogResponse:SelectOptionPromo(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: {
				new
					query[300];
				
				mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_PROMOCODES"`");
				mysql_tquery(MysqlID, query, "mysql_PromoCodeShow", "i", playerid);
			}
			case 1: Dialog_Show(playerid, Dialog:CreatePromoName);
			case 2: Dialog_Show(playerid, Dialog:DeletePromo);
		}
	}
	else
		Dialog_Show(playerid, Dialog:ServerOptions);
	
	return 1;
}

DialogCreate:PlayerPromoCode(playerid)
{
	Dialog_Open(playerid, Dialog:PlayerPromoCode, DSI, "Активировать промо-код", "{FFFFFF}Активируйте промо-код:", "Ввод", "Выход");
	return 1;
}

DialogResponse:PlayerPromoCode(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext))
			return Dialog_Show(playerid, Dialog:PlayerPromoCode);

		new
			query[300];
		
		mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_PROMOCODES"` WHERE BINARY `Code` = '%s'", inputtext);
		mysql_tquery(MysqlID, query, "mysql_PromoCheck", "is", playerid, inputtext);
	}
	return 1;
}

DialogCreate:ServerRules(playerid)
{
	if(GetPlayerLogged(playerid)) {
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
	if(GetPlayerLogged(playerid)) {
		if(response) {
			SetErrorText(playerid, "");
			Dialog_Show(playerid, Dialog:PlayerInputPassword);

			Dina_CheckPlayerHint(playerid, 1);
		}
		else 
			return KickEx(playerid);
	}
	else
		Dialog_Show(playerid, Dialog:PlayerMenu);

	return 1;
}

DialogCreate:SelectPlayerSex(playerid)
{
	Dialog_Open(playerid, Dialog:SelectPlayerSex, DSM, "{ff6d00}[3/5] Выбор пола", "\n{d4d4d4}Пожалуйста, выберите свой будущий {d16b17}пол{d4d4d4}.\n ", "Мужской", "Женский");
	return 1;
}

DialogResponse:SelectPlayerSex(playerid, response, listitem, inputtext[])
{
	if(response)
		SetPlayerSex(playerid, 1);
	else
		SetPlayerSex(playerid, 2);

	Dialog_Show(playerid, Dialog:SelectPlayerFoundServer);

	KillPlayerLoggedTimer(playerid);
	SetPlayerLoggedTimer(playerid, 60000);
	return 1;
}

DialogCreate:SelectPlayerFoundServer(playerid)
{
	Dialog_Open(playerid, Dialog:SelectPlayerFoundServer, DSL, "{ff6d00}[4/5] Где Вы узнали о сервере?", ""C_N"• {FFFFFF}Вкладка\"Hosted\"\n"C_N"• {FFFFFF}В соц. сетях\n"C_N"• {FFFFFF}На порталах/форумах\n"C_N"• {FFFFFF}В поисковике\n"C_N"• {FFFFFF}На YouTube\n"C_N"• {FFFFFF}Другое...", "Выбрать", "Выйти");
	return 1;
}

DialogResponse:SelectPlayerFoundServer(playerid, response, listitem, inputtext[])
{
	if(response) {
		pInfo[playerid][pFoundServer] = listitem + 1;

		SetErrorText(playerid, "");
		Dialog_Show(playerid, Dialog:PlayerInputReferal);

		Dina_CheckPlayerHint(playerid, 2);

		KillPlayerLoggedTimer(playerid);
		SetPlayerLoggedTimer(playerid, 60000);
	}
	else {
		KickEx(playerid);
		return 1;
	}
	return 1;
}

DialogCreate:PlayerChangePassword(playerid)
{
	new
		string[1000];

	new
		errortext[100];

	GetPVarString(playerid, "ErrorText_PVar", errortext, sizeof(errortext));
	DeletePVar(playerid, "ErrorText_PVar");

	f(string, "{CC0033}Информация:\n\n{FFFFFF}Вы изменяете пароль от аккаунта на сервере {33FF00}"SERVER_NAME"\n\n{FFFFFF}Придумайте новый пароль для изменение пароля от аккаунта.\n\n{CC0033}Примечание:\n{CCCCCC}1. Пароль чувствителен к регистру.\n2. Пароль должен содержать от 4 до 25 символов.\n3. Пароль должен содержать только латинские символы и цифры.\n\n{CC0033}%s", errortext);
	Dialog_Open(playerid, Dialog:PlayerChangePassword, DSI, "Изменение пароля от аккаунта", string, "Ввод", "Назад");
	return 1;
}

DialogResponse:PlayerChangePassword(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			SetErrorText(playerid, "");
			Dialog_Show(playerid, Dialog:PlayerChangePassword);
			return 1;
		}
		
		for(new i = strlen(inputtext)-1; i != -1; i--) {
			switch(inputtext[i]) {
				case '0'..'9', 'a'..'z','A'..'Z': continue;
				default: {
					SetErrorText(playerid, 
					"Ошибка: пароль должен содержать латинские символы и цифры!");

					Dialog_Show(playerid, Dialog:PlayerChangePassword);
					return 1;
				}
			}
		}
		if(strlen(inputtext) < 4) {
			SetErrorText(playerid, "Ошибка: пароль слишком короткий!");
			Dialog_Show(playerid, Dialog:PlayerChangePassword);
			return 1;
		}
		else if(strlen(inputtext) > 25) {
			SetErrorText(playerid, "Ошибка: пароль слишком длинный!");
			Dialog_Show(playerid, Dialog:PlayerChangePassword);
			return 1;
		}

		pInfo[playerid][pPassword][0] = EOS;
		mysql_escape_string(inputtext, pInfo[playerid][pPassword]);

		new
			salt[11];

		for(new i; i < 10; i++) 
			salt[i] = random(79) + 47;
		
		salt[10] = 0;
		SHA256_PassHash(pInfo[playerid][pPassword], salt, pInfo[playerid][pPassword], 65);
		pInfo[playerid][pSalt] = salt;

		new
			query[400];
		
		mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Password` = '%s', `Salt` = '%s', WHERE `ID` = '%d'", pInfo[playerid][pPassword], pInfo[playerid][pSalt], GetPlayerpID(playerid));
		mysql_tquery(MysqlID, query);

		SCM(playerid, -1, "{57D643}(Информация) {FFFFFF}Пароль успешно изменён.");
	}
	else {
		if(GetPlayerBusy(playerid) != MAIN_MENU)
			Dialog_Show(playerid, Dialog:PlayerChangeSecurity);
	}
	return 1;
}

DialogCreate:PlayerInputReferal(playerid)
{
	new
		string[350];

	new
		errortext[100];

	GetPVarString(playerid, "ErrorText_PVar", errortext, sizeof(errortext));
	DeletePVar(playerid, "ErrorText_PVar");

	KillPlayerLoggedTimer(playerid);
	SetPlayerLoggedTimer(playerid, 60000);

	f(string, "{d4d4d4}Если вас кто-то {d16b17}пригласил{d4d4d4}, то введите его ник сюда.\nПример: {9e9e9e}Nikita_Foxze\n\n{d4d4d4}* Когда Вы достигните {d16b17}15 ранга{d4d4d4}, ему будет выдано вознаграждение!\n\n{CC0033}%s", errortext);
	Dialog_Open(playerid, Dialog:PlayerInputReferal, DSI, "{ff6d00}[5/5] Кто вас пригласил?", string, "Выбрать", "Пропустить");
	return 1;
}

DialogResponse:PlayerInputReferal(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			SetErrorText(playerid, "");
			Dialog_Show(playerid, Dialog:PlayerInputReferal);
			return 1;
		}
		if(!strcmp(NameEx(playerid), inputtext, true)) {
			SetErrorText(playerid, "Ошибка: собственный ник запрещён!");
			Dialog_Show(playerid, Dialog:PlayerInputReferal);
			return 1;
		}
		new
			query[200];

		mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s'", inputtext);
		mysql_tquery(MysqlID, query, "CheckRegisterPlayerReferal", "is", playerid, inputtext);
	}
	else {
		KillPlayerLoggedTimer(playerid);

		pInfo[playerid][pReferal][0] = EOS;
		mysql_escape_string("No Referal", pInfo[playerid][pReferal]);

		CreateNewAccount(playerid);
	}
	return 1;
}

publics CheckRegisterPlayerReferal(playerid, const name[])
{
	new
		num_rows;

	cache_get_row_count(num_rows);

	if(!num_rows) {
		SetErrorText(playerid, "Ошибка: данный игрок не зарегистрирован на сервере!");
		Dialog_Show(playerid, Dialog:PlayerInputReferal);
		return 1;
	}

	pInfo[playerid][pReferal][0] = EOS;
	mysql_escape_string(name, pInfo[playerid][pReferal]);

	CreateNewAccount(playerid);
	return 1;
}

DialogCreate:PlayerBuyAnimations(playerid)
{
	new
		string[3000];

	strcat(string, "Название\tЦена\n");

	n_for(i, PLAYER_MAX_ANIMATIONS) {
		if(!pInfo[playerid][pAnimations][i]) 
			f(string, "%s"C_N"• {FFFFFF}%s\t{1ad943}[%i$]\n", string, AnimName[i], AnimPrice[i]);
		else 
			f(string, "%s"C_N"• {FFFFFF}%s\t\n", string, AnimName[i], AnimPrice[i]);
	}
	Dialog_Open(playerid, Dialog:PlayerBuyAnimations, DSTH, "{1ad9c9}Покупка анимации", string, "Выбрать", "Выйти");
	return 1;
}

DialogResponse:PlayerBuyAnimations(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!pInfo[playerid][pAnimations][listitem]) {
			if(GetPlayerCredits(playerid) < AnimPrice[listitem]) {
				Dialog_Show(playerid, Dialog:PlayerBuyAnimations);

				SCM(playerid, COLOR_ERROR, "(Ошибка) {FFFFFF}Недостаточно кредитов!");
				return 1;
			}
			else {
				SetPlayerCredit(playerid, -AnimPrice[listitem]);
				pInfo[playerid][pAnimations][listitem] = 1;

				SavePlayerCredit(playerid);
				SavePlayerAnimations(playerid);

				SCM(playerid, -1, "{1ad943}(Покупка) {FFFFFF}Анимация успешно приобретена!");
			}
		}
		if(GetPlayerBusy(playerid) == GAME)
			SetPlayerAnimation(playerid, listitem);
	}
	return 1;
}

DialogCreate:PlayerListAnimations(playerid)
{
	new
		string[3000],
		num = 0;

	n_for(i, PLAYER_MAX_ANIMATIONS) {
		if(pInfo[playerid][pAnimations][i]) {
			DialogListPlayerAnims[playerid][num] = i;
			num++;
		}
	}

	n_for(i, num)
		f(string, "%s"C_N"• {FFFFFF}%s\n", string, AnimName[DialogListPlayerAnims[playerid][i]]);
	
	if(num != 0) 
		strcat(string, "\n"C_N"• {5acc1d}Приобрести анимацию");
	else 
		strcat(string, ""C_N"• {5acc1d}Приобрести анимацию");

	Dialog_Open(playerid, Dialog:PlayerListAnimations, DSL, "{1ad9c9}Анимации", string, "Выбрать", "Выйти");
	return 1;
}

DialogResponse:PlayerListAnimations(playerid, response, listitem, inputtext[])
{
	if(response) {
		new
			num = 0;

		n_for(i, PLAYER_MAX_ANIMATIONS) {
			if(DialogListPlayerAnims[playerid][i] != -1)
				num++;
		}

		if(num != 0)
			num++;

		if(num != 0) {
			if(listitem == num - 1) {
				Dialog_Show(playerid, Dialog:PlayerListAnimations);
				return 1;
			}
		}

		if(listitem == num) 
			Dialog_Show(playerid, Dialog:PlayerBuyAnimations);
		else 
			SetPlayerAnimation(playerid, DialogListPlayerAnims[playerid][listitem]);

		n_for(i, PLAYER_MAX_ANIMATIONS)
			DialogListPlayerAnims[playerid][i] = -1;
	}
	return 1;
}

DialogCreate:ListPromo(playerid)
{
	new
		string[3500];

	GetPVarString(playerid, "ListPromCcodes_Pvar", string, sizeof(string));
	Dialog_Open(playerid, Dialog:ListPromo, DSL, "Список промо-кодов", string, "Назад", "");
	return 1;
}

DialogResponse:ListPromo(playerid, response, listitem, inputtext[])
{
	Dialog_Show(playerid, Dialog:SelectOptionPromo);
	return 1;
}

DialogCreate:CreatePromoGoldCoins(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoGoldCoins, DSI, "Создание промо-кода", "{FFFFFF}Введите кол-во gold coins, которое будет выдано при вводе промо-кода:\nИспользуйте до 30 Gold coins", "Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoGoldCoins(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			Dialog_Show(playerid, Dialog:CreatePromoGoldCoins);
			return 1;
		}
		if(strval(inputtext) < 1 || strval(inputtext) > 30) {
			Dialog_Show(playerid, Dialog:CreatePromoGoldCoins);
			return 1;
		}

		SetPVarInt(playerid, "PROMODONATE", strval(inputtext));
		Dialog_Show(playerid, Dialog:CreatePromo);
	}
	else {
		DeletePVar(playerid, "PROMOMONEY");
		Dialog_Show(playerid, Dialog:CreatePromoCredits);
	}
	return 1;
}

DialogCreate:CreatePromoCredits(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoCredits, DSI, "Создание промо-кода", "{FFFFFF}Введите кол-во кредитов, которое будет выдано при вводе промо-кода:\nИспользуйте до 100.000$", "Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoCredits(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			Dialog_Show(playerid, Dialog:CreatePromoCredits);
			return 1;
		}
		if(strval(inputtext) < 1 || strval(inputtext) > 100000) {
			Dialog_Show(playerid, Dialog:CreatePromoCredits);
			return 1;
		}
		SetPVarInt(playerid, "PROMOMONEY", strval(inputtext));
		Dialog_Show(playerid, Dialog:CreatePromoGoldCoins);
	}
	else {
		DeletePVar(playerid, "PROMOLUD");
		DeletePVar(playerid, "PROMODAYS");

		Dialog_Show(playerid, Dialog:CreatePromoSelectDP);
	}
	return 1;
}

DialogCreate:CreatePromoSelectDP(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoSelectDP, DSL, "Создание промо-кода", ""C_N"• {FFFFFF}Кол-во дней\n"C_N"• {FFFFFF}Кол-во людей", "Выбрать", "Назад");
	return 1;
}

DialogResponse:CreatePromoSelectDP(playerid, response, listitem, inputtext[])
{
	if(response) {
		switch(listitem) {
			case 0: Dialog_Show(playerid, Dialog:CreatePromoPeople);
			case 1: Dialog_Show(playerid, Dialog:CreatePromoDays);
		}
	}
	else {
		DeletePVar(playerid, "PROMONAME");
		Dialog_Show(playerid, Dialog:CreatePromoName);
	}
	return 1;
}

DialogCreate:CreatePromoPeople(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoPeople, DSI, "Создание промо-кода", "{FFFFFF}На какое кол-во дней создать промо-код?\nИспользуйте от 1 до 7 дней", "Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoPeople(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			Dialog_Show(playerid, Dialog:CreatePromoPeople);
			return 1;
		}
		if(strval(inputtext) < 1 || strval(inputtext) > 7) {
			Dialog_Show(playerid, Dialog:CreatePromoPeople);
			return 1;
		}
		SetPVarInt(playerid, "PROMODAYS", strval(inputtext));
		SetPVarInt(playerid, "PROMOLUD", 0);

		Dialog_Show(playerid, Dialog:CreatePromoCredits);
	}
	else {
		DeletePVar(playerid, "PROMOLUD");
		DeletePVar(playerid, "PROMODAYS");
		Dialog_Show(playerid, Dialog:CreatePromoSelectDP);
	}
	return 1;
}

DialogCreate:CreatePromoDays(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoDays, DSI, "Создание промо-кода", "{FFFFFF}На сколько человек создать промо-код?\nИспользуйте от 1 до 500", "Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoDays(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			Dialog_Show(playerid, Dialog:CreatePromoDays);
			return 1;
		}
		if(strval(inputtext) < 1 || strval(inputtext) > 500) {
			Dialog_Show(playerid, Dialog:CreatePromoDays);
			return 1;
		}
		SetPVarInt(playerid, "PROMOLUD", strval(inputtext));
		SetPVarInt(playerid, "PROMODAYS", -1);

		Dialog_Show(playerid, Dialog:CreatePromoCredits);
	}
	else {
		DeletePVar(playerid, "PROMOLUD");
		DeletePVar(playerid, "PROMODAYS");
		Dialog_Show(playerid, Dialog:CreatePromoSelectDP);
	}
	return 1;
}

DialogCreate:CreatePromoName(playerid)
{
	Dialog_Open(playerid, Dialog:CreatePromoName, DSI, "Создание промо-кода", "{FFFFFF}Введите название промо-кода:\nИспользуйте от 3 до 16 символов\n\n{CCCCCC}Пример: #"SERVER_NAME"", "Далее", "Назад");
	return 1;
}

DialogResponse:CreatePromoName(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			Dialog_Show(playerid, Dialog:CreatePromoName);
			return 1;
		}
		if(strlen(inputtext) < 3 || strlen(inputtext) > 16) {
			Dialog_Show(playerid, Dialog:CreatePromoName);
			return 1;
		}
		SetPVarString(playerid, "PROMONAME", inputtext);
		Dialog_Show(playerid, Dialog:CreatePromoSelectDP);
	}
	else 
		Dialog_Show(playerid, Dialog:SelectOptionPromo);
	
	return 1;
}

DialogCreate:CreatePromo(playerid)
{
	new
		promoname[31],
		str[1000];

	GetPVarString(playerid, "PROMONAME", promoname, sizeof(promoname));

	new
		promoday = GetPVarInt(playerid, "PROMODAYS"),
		promolud = GetPVarInt(playerid, "PROMOLUD"),
		promomoney = GetPVarInt(playerid, "PROMOMONEY"),
		promodonate = GetPVarInt(playerid, "PROMODONATE");
		
	f(str, "{FFFFFF}Создать промо-код {FFFF33}%s\n{FFFFFF}Выдача денег: %i$\nВыдача Gold coins: %i\n\nПромо-код действует на %i дней или %i человек.", promoname, promomoney, promodonate, promoday, promolud);
	Dialog_Open(playerid, Dialog:CreatePromo, DSM, "Создание промо-кода", str, "Создать", "Назад");
	return 1;
}

DialogResponse:CreatePromo(playerid, response, listitem, inputtext[])
{
	if(response) {
		new
			query[300],
			promoname[31];

		GetPVarString(playerid, "PROMONAME", promoname, sizeof(promoname));

		mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_PROMOCODES"` WHERE BINARY `Code` = '%s'", promoname);
		mysql_tquery(MysqlID, query, "mysql_PromoCreate", "is", playerid, promoname);
	}
	else {
		DeletePVar(playerid, "PROMODONATE");
		Dialog_Show(playerid, Dialog:CreatePromoGoldCoins);
	}
	return 1;
}

DialogCreate:DeletePromo(playerid)
{
	Dialog_Open(playerid, Dialog:DeletePromo, DSI, "Удаление промо-кода", "{FFFFFF}Введите название промо-кода:", "Далее", "Назад");
	return 1;
}

DialogResponse:DeletePromo(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			Dialog_Show(playerid, Dialog:DeletePromo);
			return 1;
		}
		new
			query[300];
		
		mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_PROMOCODES"` WHERE BINARY `Code` = '%s'", inputtext);
		mysql_tquery(MysqlID, query, "mysql_PromoDelete", "is", playerid, inputtext);
	}
	else
		Dialog_Show(playerid, Dialog:SelectOptionPromo);
	
	return 1;
}

DialogCreate:PlayerBlackList(playerid)
{
	new
		proverka;

	n_for(i, MAX_PLAYERS_IN_BLACKLIST) {
		if(pInfo[playerid][pBlacklist][i] == -1 || pInfo[playerid][pBlacklist][i] == 0) 
			continue;

		proverka++;
	}
	if(proverka == 0) {
		SCM(playerid, COLOR_ERROR, "(Чёрный список) {FFFFFF}Чёрный список пуст.");

		PlayerListBlackListCount[playerid] = 0;

		n_for(i, 10)
			PlayerListBlacklist[playerid][i] = -1;

		ClosePlayerDialog(playerid);
		return 1;
	}

	n_for(i, 10)
		PlayerListBlacklist[playerid][i] = -1;
	
	new
		str[1000],
		list = 0;

	for(new i = PlayerListBlackListCount[playerid], num = PlayerListBlackListCount[playerid] + 1; i < 10; i++) {
		if(pInfo[playerid][pBlacklist][i] == -1 || pInfo[playerid][pBlacklist][i] == 0) 
			continue;

		new
			query[300], 
			Names[MAX_PLAYER_NAME];

		mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_ACCOUNTS"` WHERE `ID` = '%i' LIMIT 1", pInfo[playerid][pBlacklist][i]);
		mysql_query(MysqlID, query, true);

		cache_get_value_name(0, "Name", Names, MAX_PLAYER_NAME);

		f(str, "%s"C_N"%i. {FFFFFF}%s\n", str, num, Names);

		PlayerListBlacklist[playerid][num - 1] = i;
		list++;
		num++;
	}
	if(list >= 10) {
		if(proverka > PlayerListBlackListCount[playerid] + 10) {
			strcat(str, "Далее >>");
		}
	}
	Dialog_Open(playerid, Dialog:PlayerBlackList, DSL, "Чёрный список", str, "Удалить", "Выйти");
	return 1;
}

DialogResponse:PlayerBlackList(playerid, response, listitem, inputtext[])
{
	if(response) {
		n_for(i, 10) {
			if(listitem == i) {
				pInfo[playerid][pBlacklist][PlayerListBlacklist[playerid][i]] = -1;
				SavePlayerBlacklist(playerid);

				SCM(playerid, -1, "{2fba33}(Чёрный список) {FFFFFF}Игрок успешно убран из чёрного списка.");
				PlayerListBlackListCount[playerid] = 0;
				Dialog_Show(playerid, Dialog:PlayerBlackList);
				break;
			}
		}
		if(listitem == 10) {
			PlayerListBlackListCount[playerid] += 10;
			Dialog_Show(playerid, Dialog:PlayerBlackList);
		}
	}
	return 1;
}

DialogCreate:PlayerInputPassword(playerid)
{
	new
		string[1000];

	new
		errortext[100];

	GetPVarString(playerid, "ErrorText_PVar", errortext, sizeof(errortext));
	DeletePVar(playerid, "ErrorText_PVar");

	f(string, "{d4d4d4}Игровой ник: {FF9900}%s\n{d4d4d4}Данный аккаунт {e03f3f}не зарегистрирован {d4d4d4}на сервере.\n\n{d4d4d4}Придумайте и введите пароль для регистрации нового персонажа:\n\n{d93636}Примечание:\n{9e9e9e}1) Пароль чувствителен к регистру.\n2) Пароль должен содержать от 4 до 25 символов.\n3) Пароль должен содержать только латинские символы и цифры.\n\n{4ecc47}* У Вас есть 2 минуты на создание пароля!\n\n{CC0033}%s", NameEx(playerid), errortext);
	Dialog_Open(playerid, Dialog:PlayerInputPassword, DSI, "{ff6d00}[2/5] Создание пароля", string, "Ввод", "Выйти");
	return 1;
}

DialogResponse:PlayerInputPassword(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			SetErrorText(playerid, "");
			Dialog_Show(playerid, Dialog:PlayerInputPassword);
			return 1;
		}
		for(new i = strlen(inputtext)-1; i != -1; i--) {
			switch(inputtext[i]) {
				case '0'..'9', 'a'..'z','A'..'Z': continue;
				default: {
					SetErrorText(playerid, 
					"Ошибка: пароль должен содержать латинские символы и цифры!");

					Dialog_Show(playerid, Dialog:PlayerInputPassword);
					return 1;
				}
			}
		}
		if(strlen(inputtext) < 4) {
			SetErrorText(playerid, "Ошибка: пароль слишком короткий!");
			Dialog_Show(playerid, Dialog:PlayerInputPassword);
			return 1;
		}
		else if(strlen(inputtext) > 25) {
			SetErrorText(playerid, "Ошибка: пароль слишком длинный!");
			Dialog_Show(playerid, Dialog:PlayerInputPassword);
			return 1;
		}

		pInfo[playerid][pPassword][0] = EOS;
		mysql_escape_string(inputtext, pInfo[playerid][pPassword]);

		Dialog_Show(playerid, Dialog:SelectPlayerSex);

		KillPlayerLoggedTimer(playerid);
		SetPlayerLoggedTimer(playerid, 60000);
		return 1;
	}
	else
		 KickEx(playerid);

	return 1;
}

DialogCreate:PlayerRepeatPassword(playerid)
{
	new
		string[500];

	new
		errortext[100];

	GetPVarString(playerid, "ErrorText_PVar", errortext, sizeof(errortext));
	DeletePVar(playerid, "ErrorText_PVar");

	f(string, "{FFFFFF}Повторите пароль:\n\n{006633}У Вас есть 120 секунд для регистрации.\n\n{CC0033}%s", errortext);
	Dialog_Open(playerid, Dialog:PlayerRepeatPassword, DSP, "Повторение пароля", string, "Ввод", "Назад");
	return 1;
}

DialogResponse:PlayerRepeatPassword(playerid, response, listitem, inputtext[])
{
	if(response) {
		if(!strlen(inputtext)) {
			SetErrorText(playerid, "");
			Dialog_Show(playerid, Dialog:PlayerRepeatPassword);
			return 1;
		}
		if(strcmp(inputtext, pInfo[playerid][pPassword], true)) {
			SetErrorText(playerid, "Ошибка: пароли не совпадают!");
			Dialog_Show(playerid, Dialog:PlayerRepeatPassword);

			if(GetPVarInt(playerid, "Password_PVar") == 2)
				SetPVarInt(playerid, "Password_PVar", 1);

			return 1;
		}

		new
			string[26];

		n_for(i, strlen(inputtext))
			strcat(string, ".");
		
		SetPVarInt(playerid, "Password_PVar", 2);
		return 1;
	}
	return 1;
}

DialogCreate:PlayerLogin(playerid)
{
	new
		string[700];

	new
		errortext[100];

	GetPVarString(playerid, "ErrorText_PVar", errortext, sizeof(errortext));
	DeletePVar(playerid, "ErrorText_PVar");

	f(string, "{d4d4d4}Игровой ник: {FF9900}%s\n{d4d4d4}Данный аккаунт {3399FF}зарегистрирован {d4d4d4}на сервере.\n\n{d4d4d4}Введите пароль ниже:\n\n{4ecc47}* У Вас есть 2 минуты на авторизацию!\n\n{CC0033}%s", NameEx(playerid), errortext);
	Dialog_Open(playerid, Dialog:PlayerLogin, DSP, "{ff6d00}Авторизация", string, "Ввод", "Выйти");
	return 1;
}

DialogResponse:PlayerLogin(playerid, response, listitem, inputtext[])
{
	if(!response) {
		KickEx(playerid);
		return 1;
	}
	if(!strlen(inputtext)) {
		SetErrorText(playerid, "");
		Dialog_Show(playerid, Dialog:PlayerLogin);
		return 1;
	}

	new
		hash[64 + 1];

	SHA256_PassHash(inputtext, pInfo[playerid][pSalt], hash, sizeof(hash));
	
	if(strcmp(hash, pInfo[playerid][pPassword], true)) {
		switch(GetPVarInt(playerid, "WrongPassword")) {
			case 0: {
				SetErrorText(playerid, "Осталось 3 попытки.");
				Dialog_Show(playerid, Dialog:PlayerLogin);
			}
			case 1: {
				SetErrorText(playerid, "Осталось 2 попытки.");
				Dialog_Show(playerid, Dialog:PlayerLogin);
			}
			case 2: {
				SetErrorText(playerid, "Осталась 1 попытка.");
				Dialog_Show(playerid, Dialog:PlayerLogin);
			}
			case 3: {
				SetErrorText(playerid, "Осталась последняя попытка.");
				Dialog_Show(playerid, Dialog:PlayerLogin);
			}
			default: {
				Dialog_Message(playerid, "Ошибка", "{FFFFFF}Вы были кикнуты с сервера.\n{CC0033}Причина: Превышен лимит попыток на ввод пароля.\n{FFFFFF}Для выхода с сервера введите\"/q\" в чат", "Выход");
				KickEx(playerid);
			}
		}
		SetPVarInt(playerid, "WrongPassword", GetPVarInt(playerid, "WrongPassword") + 1);
		return 1;
	}
	DeletePVar(playerid, "WrongPassword");
	KillPlayerLoggedTimer(playerid);

	UploadPlayerData(playerid);
	return 1;
}

/*

	* MySQL *

*/

stock CreateNewAccount(playerid)
{
	// IP
	GetPlayerIp(playerid, pInfo[playerid][pIP], 17);
	GetPlayerIp(playerid, pInfo[playerid][pOldIP], 17);

	// Ранг
	pInfo[playerid][pRank] = INITIAL_PLAYER_RANK;
	SetPlayerScore(playerid, GetPlayerRank(playerid));

	// Кредиты
	pInfo[playerid][pCredit] = INITIAL_PLAYER_CREDIT;
	GivePlayerMoney(playerid, INITIAL_PLAYER_CREDIT);

	// Ежедневный бонус
	pInfo[playerid][pBDays] = 1;
	pInfo[playerid][pBData] = 0;

	Inv_PlayerCreateAccount(playerid);

	// Генерация пароля
	new
		salt[11];

	n_for(i, 10)
		salt[i] = random(79) + 47;

	salt[10] = 0;

	SHA256_PassHash(pInfo[playerid][pPassword], salt, pInfo[playerid][pPassword], 65);
	pInfo[playerid][pSalt] = salt;

	CreateNewUser(playerid, pInfo[playerid][pPassword]);

	new
		querys[150];

	mysql_format(MysqlID, querys, sizeof(querys), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s' LIMIT 1", NameEx(playerid));
	mysql_tquery(MysqlID, querys, "UpdatePlayerRegisterData", "i", playerid);
	return 1;
}

stock CreateNewUser(playerid, Password[])
{
	static
		str[6000],
		query[1000];

	CreateNewUserBasic(playerid, Password, query, str);
	str[0] = query[0] = EOS;

	f(str, "{57D643}(Информация) {FFFFFF}Аккаунт {FFCC33}%s {FFFFFF}успешно зарегистрирован на сервере!", NameEx(playerid));
	SCM(playerid, -1, str);
	return 1;
}

stock CreateNewUserBasic(playerid, Password[], query[1000], str[6000])
{
	new
		text[200];

	// Создание
	f(str, "INSERT INTO `"T_ACCOUNTS"` (`Name`,`Password`,`Salt`,`Referal`,`Found_server`,`Ip`,`Old_ip`,`Sex`,`Rank`,`Credit`,\
	`BDays`,`BData`,`Inv_items`,`Inv_item`,`Inv_item_count`,`Inv_banner`,`Inv_banner_count`,`Animations`,`Blacklist`,`Helper_Dina`,`Data`,`Old_data`) VALUES ");
	strcat(str, "(");

	f(query, "'%s',", NameEx(playerid)), strcat(str, query), query[0] = EOS; // Name
	f(query, "'%s',", Password), strcat(str, query), query[0] = EOS; // Password
	f(query, "'%s',", pInfo[playerid][pSalt]), strcat(str, query), query[0] = EOS; // Salt
	f(query, "'%s',", pInfo[playerid][pReferal]), strcat(str, query), query[0] = EOS; // Referal
	f(query, "'%i',", pInfo[playerid][pFoundServer]), strcat(str, query), query[0] = EOS; // Found_server
	f(query, "'%s',", pInfo[playerid][pIP]), strcat(str, query), query[0] = EOS; // Ip
	f(query, "'%s',", pInfo[playerid][pOldIP]), strcat(str, query), query[0] = EOS; // Old_ip
	f(query, "'%i',", GetPlayerSex(playerid)), strcat(str, query), query[0] = EOS; // Sex
	f(query, "'%i',", GetPlayerRank(playerid)), strcat(str, query), query[0] = EOS; // Rank
	f(query, "'%i',", GetPlayerCredits(playerid)), strcat(str, query), query[0] = EOS; // Credit
	f(query, "'%i',", pInfo[playerid][pBDays]), strcat(str, query), query[0] = EOS; // BDays
	f(query, "'%i',", pInfo[playerid][pBData]), strcat(str, query), query[0] = EOS; // BData

	// Inv_items
	f(text, "%i,", Inv_GetPlayerStandSkin(playerid));
	f(text, "%s%i,", text, Inv_GetPlayerSkin(playerid));
	f(text, "%s%i,", text, Inv_GetPlayerHead(playerid));
	f(text, "%s%i,", text, Inv_GetPlayerHeadphones(playerid));
	f(text, "%s%i,", text, Inv_GetPlayerGlasses(playerid));
	f(text, "%s%i,", text, Inv_GetPlayerMask(playerid));
	f(text, "%s%i,", text, Inv_GetPlayerWatch(playerid));
	f(text, "%s%i,", text, Inv_GetPlayerBanner(playerid));
	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// Inv_item
	n_for(i, INV_PLAYER_MAX_ITEMS)
		f(text, "%s%i,", text, Inv_GetPlayerCellItem(playerid, i));

	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// Inv_item_count
	n_for(i, INV_PLAYER_MAX_ITEMS)
		f(text, "%s%i,", text, Inv_GetPlayerCellItemCount(playerid, i));

	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// Inv_banner
	n_for(i, INV_PLAYER_MAX_BANNERS)
		f(text, "%s%i,", text, Inv_GetPlayerCellBanner(playerid, i));

	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// Inv_banner_count
	n_for(i, INV_PLAYER_MAX_BANNERS)
		f(text, "%s%i,", text, Inv_GetPlayerCellBannerCount(playerid, i));

	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// Animations
	n_for(i, PLAYER_MAX_ANIMATIONS)
		f(text, "%s%i,", text, pInfo[playerid][pAnimations][i]);

	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// Blacklist
	n_for(i, MAX_PLAYERS_IN_BLACKLIST)
		strcat(text, "-1,");

	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	// Helper_Dina
	n_for(i, DINA_MAX_HINTS)
		f(text, "%s%i,", text, Dina_GetPlayerHint(playerid, i));

	f(query, "'%s',", text), strcat(str, query), query[0] = text[0] = EOS;

	f(query, "Now() + INTERVAL 0 DAY,"), strcat(str, query), query[0] = EOS; // Data
	f(query, "Now() + INTERVAL 0 DAY"), strcat(str, query), query[0] = EOS; // Old_data

	strcat(str, ")");
	mysql_tquery(MysqlID, str, "CreateUserBackpack", "i", playerid);
	return 1;
}

publics CreateUserBackpack(playerid)
{
	SetPlayerpID(playerid, cache_insert_id());
	
	static
		str[6000],
		query[1000];

	if(GetPlayerpID(playerid) != -1) {
		TDM_CreateNewUserStatsClass(playerid, query, str);
		str[0] = query[0] = EOS;
		Quest_CreateNewUser(playerid, query, str);

		ConnectNewPlayerServer(playerid);
	}
	else {
		SCM(playerid, -1, "Упс! Попробуйте ещё раз!");
		KickEx(playerid);
	}
	return 1;
}

publics UploadPlayerAccount(playerid)
{
	UploadPlayerPremium(playerid);
	Inv_UploadPlayerData(playerid);
	Dina_UploadPlayerData(playerid);

	cache_get_value_name(0, "Second_password", pInfo[playerid][pSecondPassword], 20);
	cache_get_value_name(0, "Referal", pInfo[playerid][pReferal], MAX_PLAYER_NAME);
	cache_get_value_name_int(0, "Found_server", pInfo[playerid][pFoundServer]);
	cache_get_value_name(0, "Ip", pInfo[playerid][pIP], 17);
	cache_get_value_name_int(0, "Sex", pInfo[playerid][pSex]);
	cache_get_value_name_int(0, "Rank", pInfo[playerid][pRank]);
	cache_get_value_name_int(0, "Exp", pInfo[playerid][pExp]);
	cache_get_value_name_int(0, "Credit", pInfo[playerid][pCredit]);
	cache_get_value_name_int(0, "Warn", pInfo[playerid][pWarn]);
	cache_get_value_name_int(0, "Gold_coins", pInfo[playerid][pGoldCoin]);
	cache_get_value_name_int(0, "Kills", pInfo[playerid][pKills]);
	cache_get_value_name_int(0, "Deaths", pInfo[playerid][pDeaths]);
	cache_get_value_name_int(0, "Win_rounds", pInfo[playerid][pWinRounds]);
	cache_get_value_name_int(0, "Loss_rounds", pInfo[playerid][pLossRounds]);
	cache_get_value_name_int(0, "Shots_enemy", pInfo[playerid][pShotsEnemy]);
	cache_get_value_name_int(0, "Shots_head", pInfo[playerid][pShotsHead]);
	cache_get_value_name_int(0, "Series_kills", pInfo[playerid][pSeriesKills]);
	cache_get_value_name_int(0, "Hours", pInfo[playerid][pHours]);
	cache_get_value_name_int(0, "Minutes", pInfo[playerid][pMinutes]);
	cache_get_value_name_int(0, "Promocode", pInfo[playerid][pPromoCode]);
	cache_get_value_name_int(0, "BDays", pInfo[playerid][pBDays]);
	cache_get_value_name_int(0, "BData", pInfo[playerid][pBData]);

	new
		str[50],
		str2[250];

	f(str, "p<,>a<i>[%i]", PLAYER_MAX_ANIMATIONS);
	cache_get_value_name(0, "Animations", str2, sizeof(str2)), sscanf(str2, str, pInfo[playerid][pAnimations]), str[0] = str2[0] = EOS;

	f(str, "p<,>a<i>[%i]", MAX_PLAYERS_IN_BLACKLIST);
	cache_get_value_name(0, "Blacklist", str2, sizeof(str2)), sscanf(str2, str, pInfo[playerid][pBlacklist]), str[0] = str2[0] = EOS;

	cache_get_value_name(0, "Data", pInfo[playerid][pData]);

	new
		query[200];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Old_data` = Now() + INTERVAL %i DAY WHERE `ID` = '%d'", pInfo[playerid][pOldData], GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);

	cache_get_value_name(0, "Old_data", pInfo[playerid][pOldData]);
	query[0] = EOS;

	GetPlayerIp(playerid, pInfo[playerid][pOldIP], 17);
	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Old_ip` = '%s' WHERE `ID` = '%d'", pInfo[playerid][pOldIP], GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	query[0] = EOS;

	SetPlayerScore(playerid, GetPlayerRank(playerid));
	GivePlayerMoney(playerid, GetPlayerCredits(playerid));

	SCM(playerid, -1, "{57D643}(Информация) {FFFFFF}Авторизация прошла успешно.");

	// Второй пароль
	if(strcmp(pInfo[playerid][pSecondPassword], "No Second Password", true))
		return Interface_Show(playerid, Interface:SecondPassword);

	// Администратор
	if(Adm_CheckPlayerForAdmin(playerid))
		return 1;

	ConnectPlayerServer(playerid);
	return 1;
}

stock UploadPlayerData(playerid)
{
	new
		query[200];

	mysql_format(MysqlID, query, sizeof(query), "SELECT * FROM `"T_ACCOUNTS"` WHERE BINARY `Name` = '%s' LIMIT 1", NameEx(playerid));
	mysql_tquery(MysqlID, query, "UploadPlayerAccount", "i", playerid);
	query[0] = EOS;

	TDM_UploadPlayerDataClasses(playerid);
	Quest_UploadPlayerData(playerid);
	return 1;
}

stock UploadPlayerPremium(playerid)
{
	cache_get_value_name_int(0, "Premium", pInfo[playerid][pPremium]);
	cache_get_value_name_int(0, "Premium_data", pInfo[playerid][pPremiumData]);
	cache_get_value_name(0, "Nick_color", pInfo[playerid][pNickColor], 15);
}

stock SavePlayerPremium(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Premium` = '%i', `Premium_data` = '%i' WHERE `ID` = '%d'", pInfo[playerid][pPremium], pInfo[playerid][pPremiumData], GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerNickColor(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Nick_color` = '%s' WHERE `ID` = '%d'", pInfo[playerid][pNickColor], GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock UPD(playerid, const field[], data)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `%s` = '%d' WHERE `ID` = '%d' LIMIT 1", field, data, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock TDM_UPD(playerid, const field[], data)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_TDM_STATS"` SET `%s` = '%d' WHERE `ID` = '%d' LIMIT 1", field, data, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerAnimations(playerid)
{
	new
		str[400],
		query[500];

	n_for(i, PLAYER_MAX_ANIMATIONS)
		f(str, "%s%d,", str, pInfo[playerid][pAnimations][i]);

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Animations` = '%s' WHERE `ID` = '%d'", str, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerBlacklist(playerid)
{
	new
		str[400], 
		query[500];

	n_for(i, MAX_PLAYERS_IN_BLACKLIST)
		format(str, sizeof(str), "%s%d,", str, pInfo[playerid][pBlacklist][i]);

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Blacklist` = '%s'", str, GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerKillsDeaths(playerid)
{
	if(GetPlayerCustomClass(playerid) != -1) {
		TDM_SavePlClassKillsDeaths(playerid);
	}

	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Kills` = '%i', `Deaths` = '%i' WHERE `ID` = '%d'", GetPlayerKills(playerid), GetPlayerDeaths(playerid), GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerRankExp(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Rank` = '%i', `Exp` = '%i' WHERE `ID` = '%d'", GetPlayerRank(playerid), GetPlayerExp(playerid), GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerGoldCoins(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Gold_coins` = '%i' WHERE `ID` = '%d'", GetPlayerGoldCoins(playerid), GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerCredit(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Credit` = '%i' WHERE `ID` = '%d'", GetPlayerCredits(playerid), GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerRounds(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Win_rounds` = '%i', `Loss_rounds` = '%i' WHERE `ID` = '%d'", GetPlayerWinRounds(playerid), GetPlayerLossRounds(playerid), GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerShotsEnemy(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Shots_enemy` = '%i' WHERE `ID` = '%d'", GetPlayerShotsEnemy(playerid), GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerShotsHead(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Shots_head` = '%i' WHERE `ID` = '%d'", GetPlayerShotsHead(playerid), GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerSeriesKills(playerid)
{
	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Series_kills` = '%i' WHERE `ID` = '%d'", GetPlayerSeriesKills(playerid), GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

stock SavePlayerTime(playerid)
{
	if(GetPlayerCustomClass(playerid) != -1) {
		TDM_SavePlayerClassTime(playerid);
	}

	new
		query[250];

	mysql_format(MysqlID, query, sizeof(query), "UPDATE `"T_ACCOUNTS"` SET `Hours` = '%i', `Minutes` = '%i' WHERE `ID` = '%d'", pInfo[playerid][pHours], pInfo[playerid][pMinutes], GetPlayerpID(playerid));
	mysql_tquery(MysqlID, query);
	return 1;
}

publics UpdatePlayerRegisterData(playerid)
{
	new
		num_rows;

	cache_get_row_count(num_rows);

	if(num_rows) {
		cache_get_value_name(0, "Data", pInfo[playerid][pData]);
		cache_get_value_name(0, "Old_data", pInfo[playerid][pOldData]);
	}
	return 1;
}
