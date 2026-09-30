; These are all the asm constants needed to make the silver_vc patch.

MACRO vc_const
	DEF x = \1
	println "00:{04x:x} \1" ; same format as rgblink's .sym file
ENDM

MACRO vc_char
	DEF x = CHARVAL(\1)
	println "00:{04x:x} \1" ; same format as rgblink's .sym file
ENDM

; [FPA 001 Begin]
	vc_char "F"
	vc_char "I"
	vc_char "S"
	vc_char "U"
	vc_char "R"

; [FPA 002 Begin]
	vc_char "E"
	vc_char "L"
	vc_char "D"

; [FPA 003 Begin]
	vc_char "T"
	vc_char "H"
	vc_char "N"

; [FPA 004 Begin]
	vc_char "Y"
	vc_char "P"
	; "<SPACE>" is necessary since spaces separate template command arguments
	charmap "<SPACE>", CHARVAL(" ")
	vc_char "<SPACE>"

; [FPA 005 Begin]
	vc_char "O"

; [FPA 006 Begin]
	vc_char "X"

; [FPA 007 Begin]
	vc_char "A"
	vc_char "@"

; [FPA 042801 Begin]
	vc_const ANIM_GFX_BUBBLE

; [fight begin]
	vc_const SCREEN_HEIGHT_PX

; [print forbid 2]
	vc_const NO_INPUT
	vc_const A_BUTTON
	vc_const B_BUTTON
	vc_const D_UP
	vc_const D_DOWN

; [print forbid 3]
	vc_const MAPGROUP_CIANWOOD
	vc_const MAP_CIANWOOD_PHOTO_STUDIO
