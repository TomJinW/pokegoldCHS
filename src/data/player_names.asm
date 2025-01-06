NameMenuHeader:
	db STATICMENU_NO_TOP_SPACING ; flags
	menu_coords 0, 0, 10, TEXTBOX_Y - 1
	dw .Names
	db 1 ; default option

.Names:
	db STATICMENU_CURSOR | STATICMENU_PLACE_TITLE | STATICMENU_DISABLE_B ; flags
	db 5 ; items
	db "NEW NAME@"

PlayerNameArray:
IF DEF(_DEBUG)
	IF DEF(_GOLD)
		db_w "索软堂 X@"
		db_w "任地狱@"
		db_w "任地狱最强@"
		db_w "ABCDEFGHIJ@"
	ELIF DEF(_SILVER)
		db_w "索软堂 X@"
		db_w "任地狱@"
		db_w "任地狱最强@"
		db_w "ABCDEFGHIJ@"
	ENDC
		db 2 ; title indent
		db "NAME@" ; title

ELSE
	IF DEF(_GOLD)
		db "GOLD@"
		db "HIRO@"
		db "TAYLOR@"
		db "KARL@"
	ELIF DEF(_SILVER)
		db "SILVER@"
		db "KAMON@"
		db "OSCAR@"
		db "MAX@"
	ENDC
		db 2 ; title indent
		db "NAME@" ; title
ENDC
