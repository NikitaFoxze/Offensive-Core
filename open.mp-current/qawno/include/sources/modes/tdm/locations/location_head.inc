/*
 * |>============================<|
 * |   About: TDM location head   |
 * |   Author: Foxze              |
 * |>============================<|
 */

/*
 * |>--------------------------------------------<|
 * |                  Functions                   |
 * |>--------------------------------------------<|
 * Public:
	- (None)
 * Stock:
	- Float:GetAirRandomPos()
 * |>--------------------------------------------<|
 * |                  Enums                       |
 * |>--------------------------------------------<|
	- (None)
 * |>--------------------------------------------<|
 * |                  Global vars                 |
 * |>--------------------------------------------<|
	- adstr[TDM_MAX_LENGTH_AD]
	- Iterator:TDM_BaseTeamCount[GMS_MAX_SESSIONS]<TDM_MAX_TEAM_BASES>
	- Iterator:TDM_CapturePointCount[GMS_MAX_SESSIONS]<TDM_MAX_CAPTURE_POINTS>
	- Iterator:TDM_CaptureFlagCount[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>
	- Iterator:TDM_BagMoneyCount[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>
	- Iterator:TDM_ShopCount[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>
 */

#if defined _INC_TDM_LOC_HEAD
	#endinput
#endif
#define _INC_TDM_LOC_HEAD

/*
 * |>---------------<|
 * |     Defines     |
 * |>---------------<|
 */

// Elements
#define TDM_MAX_LEN_CAPT_POINT_NAME		(50)
#define TDM_MAX_LEN_AE_3DTEXT_NAME		(150)
#define TDM_MAX_LEN_AE_PICKUPDOOR_NAME	(150)
#define TDM_MAX_LEN_AE_PICKUP_NAME		(150)

// Additional Elements (AE)
#define TDM_MAX_AE_OBJECT		(100)
#define TDM_MAX_AE_3DTEXT		(50)
#define TDM_MAX_AE_PICKUP_DOOR	(50)
#define TDM_MAX_AE_PICKUP		(50)
#define TDM_MAX_AE_MAPICON		(50)
#define TDM_MAX_AE_ACTOR		(50)

#define TDM_MAX_LENGTH_AD		(500)

/*
 * |>-------------<|
 * |     Enums     |
 * |>-------------<|
 */

enum {
	TDM_LOC_DESERT = 0,
	TDM_LOC_DESERT2,
	TDM_LOC_AIRPORT,
	TDM_LOC_AIRPORT2,
	TDM_LOC_STADIUM,
	TDM_LOC_VILLAGE,
	TDM_LOC_GOLF,
	TDM_LOC_ZONE51,
	TDM_LOC_EXAMPLE
}

/*
 * |>------------<|
 * |     Vars     |
 * |>------------<|
 */

new
	adstr[TDM_MAX_LENGTH_AD];

new
	Iterator:TDM_BaseTeamCount[GMS_MAX_SESSIONS]<TDM_MAX_TEAM_BASES>,
	Iterator:TDM_CapturePointCount[GMS_MAX_SESSIONS]<TDM_MAX_CAPTURE_POINTS>,
	Iterator:TDM_CaptureFlagCount[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>,
	Iterator:TDM_BagMoneyCount[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>,
	Iterator:TDM_ShopCount[GMS_MAX_SESSIONS]<TDM_MAX_TEAMS>;

/*
 * |>-----------------<|
 * |     Functions     |
 * |>-----------------<|
 */

stock Float:GetAirRandomPos()
{
	new
		Float:r,
		ran = random(5);

	switch (ran) {
		case 0: r = 2.0;
		case 1: r = 3.0;
		case 2: r = 4.0;
		case 3: r = 5.0;
		case 4: r = 6.0;
	}
	return r;
}