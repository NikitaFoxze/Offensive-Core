/*

	About: Drop-tokens header
	Author: Foxze

*/

/*----------------------------------------------------------------------------
Functions:
	Public:
		-
	Stock:
		-
Enums:
	-
Global var:
	PlayerDropTokens
------------------------------------------------------------------------------*/

#if defined _INC_DROP_TOKENS_HEADER
	#endinput
#endif
#define _INC_DROP_TOKENS_HEADER

/*

	* Defines *

*/

#define DROP_TOKENS_MAX					(2)		// Макс. кол-во выпада жетонов
#define DROP_TOKENS_TIMER				(10)	// Таймер до удаления жетона в секундах
#define DROP_TOKENS_STRING_MAX_LENGTH	(61)


/*

	* Vars *

*/

new
	Iterator:PlayerDropTokens[MAX_PLAYERS]<DROP_TOKENS_MAX>;