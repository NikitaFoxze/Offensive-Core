/*
 * |>==============================<|
 * |   About: Database MySQL head   |
 * |   Author: Foxze                |
 * |>==============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- (None)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
 	- MySQL:MySQLID,
	- StrSQL[4097]
 */

#if defined _INC_DATABASE_HEAD
	#endinput
#endif
#define _INC_DATABASE_HEAD

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

new
	MySQL:MySQLID,
	StrSQL[4097];

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Connect MySQL
#define MYSQL_HOST			"127.127.126.5"
#define MYSQL_USER			"root"
#define MYSQL_DATABASE		"offensive_core"
#define MYSQL_PASSWORD		""

// Core
#define DB_STRING_VALUE_NO			"No"
#define DB_MAX_LENGTH_TABLE_NAME	(10)
#define DB_MAX_LENGTH_FIELD_NAME	(25)

// Others
#define SQL(%0,%1) mysql_format(MySQLID, StrSQL, sizeof(StrSQL), %0, %1), mysql_tquery(MySQLID, StrSQL)

/*
 * |>-----------<|
 * |   Columns   |
 * |>-----------<|
 */

// Table "accounts"
#define DB_ACCOUNTS						"accounts"
#define DB_ACCOUNTS_ID					"id"
#define DB_ACCOUNTS_NICKNAME			"nickname"
#define DB_ACCOUNTS_PASSWORD			"password"
#define DB_ACCOUNTS_SEC_PASS			"second_password"
#define DB_ACCOUNTS_REFERAL				"referal"
#define DB_ACCOUNTS_FOUND_SERVER		"found_server"
#define DB_ACCOUNTS_PROMO_CODE			"promo_code"
#define DB_ACCOUNTS_SEX					"sex"
#define DB_ACCOUNTS_RANK				"rank"
#define DB_ACCOUNTS_EXP					"exp"
#define DB_ACCOUNTS_MONEY				"money"
#define DB_ACCOUNTS_GOLD_COINS			"gold_coins"
#define DB_ACCOUNTS_KILLS				"kills"
#define DB_ACCOUNTS_DEATHS				"deaths"
#define DB_ACCOUNTS_WINNING_MATCHES		"winning_matches"
#define DB_ACCOUNTS_LOSING_MATCHES		"losing_matches"
#define DB_ACCOUNTS_SHOTS_ENEMY			"shots_enemy"
#define DB_ACCOUNTS_SHOTS_HEAD			"shots_head"
#define DB_ACCOUNTS_SERIES_KILLS		"series_kills"
#define DB_ACCOUNTS_DBONUS_DAYS			"daily_bonus_days"
#define DB_ACCOUNTS_DBONUS_DATETIME		"daily_bonus_datetime"
#define DB_ACCOUNTS_INV_USES_ITEMS		"inv_uses_items"
#define DB_ACCOUNTS_INV_ITEMS			"inv_items"
#define DB_ACCOUNTS_INV_ITEMS_COUNT		"inv_items_count"
#define DB_ACCOUNTS_INV_BANNERS			"inv_banners"
#define DB_ACCOUNTS_INV_BANNERS_COUNT	"inv_banners_count"
#define DB_ACCOUNTS_BLACKLIST			"blacklist"
#define DB_ACCOUNTS_ANIMATIONS			"animations"
#define DB_ACCOUNTS_HELPER_DINA			"helper_dina"
#define DB_ACCOUNTS_PREMIUM				"premium"
#define DB_ACCOUNTS_PREMIUM_DATETIME	"premium_datetime"
#define DB_ACCOUNTS_NICK_COLOR			"nickname_color"
#define DB_ACCOUNTS_WARNS				"warns"
#define DB_ACCOUNTS_MUTED_MINUTES		"muted_minutes"
#define DB_ACCOUNTS_PLAYED_HOURS		"played_hours"
#define DB_ACCOUNTS_PLAYED_MINUTES		"played_minutes"
#define DB_ACCOUNTS_REG_IP				"reg_ip"
#define DB_ACCOUNTS_LAST_IP				"last_ip"
#define DB_ACCOUNTS_REG_DATETIME		"reg_datetime"
#define DB_ACCOUNTS_LAST_DATETIME		"last_datetime"

// Table "admins"
#define DB_ADMINS				"admins"
#define DB_ADMINS_ID			"id"
#define DB_ADMINS_NICKNAME		"nickname"
#define DB_ADMINS_LEVEL			"level"
#define DB_ADMINS_REPUTATION	"reputation"
#define DB_ADMINS_KEY			"key"
#define DB_ADMINS_REPRIMANDS	"reprimands"
#define DB_ADMINS_KICKS			"kicks"
#define DB_ADMINS_BANS			"bans"
#define DB_ADMINS_UNBANS		"unbans"
#define DB_ADMINS_MUTS			"muts"
#define DB_ADMINS_UNMUTS		"unmuts"
#define DB_ADMINS_WARNS			"warns"
#define DB_ADMINS_UNWARNS		"unwarns"
#define DB_ADMINS_REG_DATETIME	"reg_datetime"

// Table "bans"
#define DB_BANS						"bans"
#define DB_BANS_ID					"id"
#define DB_BANS_PLAYER_NICKNAME		"player_nickname"
#define DB_BANS_ADMIN_NICKNAME		"admin_nickname"
#define DB_BANS_REASON				"reason"
#define DB_BANS_UNBAN_DATETIME		"unban_datetime"

// Table "bugs"
#define DB_BUGS						"bugs"
#define DB_BUGS_ID					"id"
#define DB_BUGS_PLAYER_NICKNAME		"player_nickname"
#define DB_BUGS_TEXT				"text"
#define DB_BUGS_SENDING_DATETIME	"sending_datetime"

// Table "promocodes"
#define DB_PROMOCODES				"promocodes"
#define DB_PROMOCODES_ID			"id"
#define DB_PROMOCODES_CODE			"code"
#define DB_PROMOCODES_MONEY			"money"
#define DB_PROMOCODES_DONATE		"donate"
#define DB_PROMOCODES_CLICK			"click"
#define DB_PROMOCODES_DAYS			"days"
#define DB_PROMOCODES_PEOPLE		"people"
#define DB_PROMOCODES_DATETIME		"datetime"

// Table "quests"
#define DB_QUESTS				"quests"
#define DB_QUESTS_ID			"id"
#define DB_QUESTS_TDM_PROGRESS	"tdm_quests_progress"
#define DB_QUESTS_TDM_QUESTS	"tdm_quests"
#define DB_QUESTS_DM_PROGRESS	"dm_quests_progress"
#define DB_QUESTS_DM_QUESTS		"dm_quests"

// Table "tdm_stats"
#define DB_TDM						"tdm_stats"
#define DB_TDM_ID					"id"
#define DB_TDM_KILLS				"kills"
#define DB_TDM_DEATHS				"deaths"
#define DB_TDM_ASSAULT_WEAPONS		"assault_weapons"
#define DB_TDM_ASSAULT_AMMO			"assault_ammo"
#define DB_TDM_MEDIC_WEAPONS		"medic_weapons"
#define DB_TDM_MEDIC_AMMO			"medic_ammo"
#define DB_TDM_ENGINEER_WEAPONS		"engineer_weapons"
#define DB_TDM_ENGINEER_AMMO		"engineer_ammo"
#define DB_TDM_RECON_WEAPONS		"recon_weapons"
#define DB_TDM_RECON_AMMO			"recon_ammo"
#define DB_TDM_USES_CAP				"uses_cap"
#define DB_TDM_USES_ARMOUR			"uses_armour"
#define DB_TDM_ASSAULT_CAPS			"assault_caps"
#define DB_TDM_ASSAULT_ARMORS		"assault_armours"
#define DB_TDM_MEDIC_CAPS			"medic_caps"
#define DB_TDM_MEDIC_ARMOURS		"medic_armours"
#define DB_TDM_ENGINEER_CAPS		"engineer_caps"
#define DB_TDM_ENGINEER_ARMOURS		"engineer_armours"
#define DB_TDM_RECON_CAPS			"recon_caps"
#define DB_TDM_RECON_ARMOURS		"recon_armours"
#define DB_TDM_ASSAULT_ABILITIES	"assault_abilities"
#define DB_TDM_MEDIC_ABILITIES		"medic_abilities"
#define DB_TDM_ENGINEER_ABILITIES	"engineer_abilities"
#define DB_TDM_RECON_ABILITIES		"recon_abilities"
#define DB_TDM_SKILL_M4				"skill_m4"
#define DB_TDM_SKILL_AK47			"skill_ak47"
#define DB_TDM_SKILL_DEAGLE			"skill_deagle"
#define DB_TDM_SKILL_SHOTGUN		"skill_shotgun"
#define DB_TDM_SKILL_SAWSHOTGUN		"skill_sawshotgun"
#define DB_TDM_SKILL_UZI			"skill_uzi"
#define DB_TDM_SKILL_MP5			"skill_mp5"
#define DB_TDM_SKILL_SNIPERRIFLE	"skill_sniperrifle"
#define DB_TDM_SKILL_NORMAL			"skill_normal"
#define DB_TDM_SKILL_BOXING			"skill_boxing"
#define DB_TDM_SKILL_KUNGFU			"skill_kungfu"
#define DB_TDM_SKILL_KNEEHEAD		"skill_kneehead"
#define DB_TDM_SKILL_GRABKICK		"skill_grabkick"
#define DB_TDM_SKILL_ELBOW			"skill_elbow"
#define DB_TDM_PLAYED_HOURS			"played_hours"
#define DB_TDM_PLAYED_MINUTES		"played_minutes"