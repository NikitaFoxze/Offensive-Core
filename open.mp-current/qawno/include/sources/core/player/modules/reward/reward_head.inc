/*
 * |>======================<|
 * |   About: Reward head   |
 * |   Author: Foxze        |
 * |>======================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- GetNameReward(rewardid)
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
	- (None)
 */

#if defined _INC_REWARD_HEAD
	#endinput
#endif
#define _INC_REWARD_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

#define MAX_REWARD_COUNT_TEXTS	(5)
#define MAX_LENGTH_REWARD_NAME	(15)
#define REWARD_SHOW_TIMER		(3)

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	REWARD_DEFAULT = 0,
	REWARD_KILL,
	REWARD_BAG_OF_MONEY,
	REWARD_CAPTURE_POINT,
	REWARD_MATCH,
	REWARD_HACK,
	REWARD_CAPTURE_FLAG,
	REWARD_TOKEN,
	REWARD_REPLENISH_HP,
	REWARD_REPAIR_VEHICLE
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

static const
	NameReward[][MAX_LENGTH_REWARD_NAME] = {
	"Пополнение",
	"Убийство",
	"Мешок денег",
	"Захват",
	"Матч",
	"Взлом",
	"Захват флага",
	"Жетон",
	"Лечение",
	"Починка"
};

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock GetNameReward(rewardid)
{
	new
		str[MAX_LENGTH_REWARD_NAME];
	
	strcopy(str, NameReward[rewardid], MAX_LENGTH_REWARD_NAME);
	return str;
}