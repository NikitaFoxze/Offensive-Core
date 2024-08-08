/*

	About: Core system
	Author: Foxze

*/

/*

    * Natives

*/

#if !defined _INC_open_mp
native IsValidVehicle(vehicleid);
#endif

/*

    * Defines

*/

#if !defined _INC_open_mp
	#if !defined BULLET_HIT_TYPE
		#define BULLET_HIT_TYPE: _:
	#endif

	#if !defined FORCE_SYNC
		#define FORCE_SYNC: _:
	#endif

	#if !defined KEY
		#define KEY: _:
	#endif

	#if !defined PLAYER_STATE
		#define PLAYER_STATE: _:
	#endif

	#if !defined SPECIAL_ACTION
		#define SPECIAL_ACTION: _:
	#endif

	#if !defined SPECTATE_MODE
		#define SPECTATE_MODE: _:
	#endif

	#if !defined TEXT_DRAW_ALIGN
		#define TEXT_DRAW_ALIGN: _:
	#endif

	#if !defined TEXT_DRAW_FONT
		#define TEXT_DRAW_FONT: _:
	#endif

	#if !defined WEAPON
		#define WEAPON: _:
	#endif

	#if !defined WEAPON_SLOT
		#define WEAPON_SLOT: _:
	#endif

	#if !defined PlayerTextDrawBackgroundColour
		#define PlayerTextDrawBackgroundColour PlayerTextDrawBackgroundColor
	#endif

	#if !defined PlayerTextDrawColour
		#define PlayerTextDrawColour PlayerTextDrawColor
	#endif

	#if !defined TextDrawBackgroundColour
		#define TextDrawBackgroundColour TextDrawBackgroundColor
	#endif

	#if !defined TextDrawColour
		#define TextDrawColour TextDrawColor
	#endif
#endif

#if !defined _INC_open_mp
#define UNKNOWN_TEXT_DRAW_ALIGN                (TEXT_DRAW_ALIGN:-1)
#define TEXT_DRAW_ALIGN_LEFT                   (TEXT_DRAW_ALIGN:1)
#define TEXT_DRAW_ALIGN_CENTRE                 (TEXT_DRAW_ALIGN:2)
#define TEXT_DRAW_ALIGN_CENTER                 (TEXT_DRAW_ALIGN:2)
#define TEXT_DRAW_ALIGN_RIGHT                  (TEXT_DRAW_ALIGN:3)

#define UNKNOWN_TEXT_DRAW_FONT                 (TEXT_DRAW_FONT:-1)
#define TEXT_DRAW_FONT_BECKETT_REGULAR         (TEXT_DRAW_FONT:0)
#define TEXT_DRAW_FONT_AHARONI_BOLD            (TEXT_DRAW_FONT:1)
#define TEXT_DRAW_FONT_BANK_GOTHIC             (TEXT_DRAW_FONT:2)
#define TEXT_DRAW_FONT_PRICEDOWN               (TEXT_DRAW_FONT:3)
#define TEXT_DRAW_FONT_SPRITE                  (TEXT_DRAW_FONT:4)
#define TEXT_DRAW_FONT_PREVIEW                 (TEXT_DRAW_FONT:5)
#endif

/*

    * Functions

*/

stock GetClickedID(Text:clickedid)
{
	#if !defined _INC_open_mp
	return _:clickedid;
	#else
	return clickedid;
	#endif
}