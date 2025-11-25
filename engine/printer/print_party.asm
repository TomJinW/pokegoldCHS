DEF PRINTPARTY_HP EQU "◀" ; $71

; PrintPage1:
; 	hlcoord 0, 0
; 	decoord 0, 0, wPrinterTilemapBuffer
; 	ld bc, 17 * SCREEN_WIDTH
; 	call CopyBytes
; 	hlcoord 17, 1, wPrinterTilemapBuffer
; 	ld a, $62
; 	ld [hli], a
; 	inc a ; $63
; 	ld [hl], a
; 	hlcoord 17, 2, wPrinterTilemapBuffer
; 	ld a, $64
; 	ld [hli], a
; 	inc a ; $65
; 	ld [hl], a
; 	hlcoord 1, 9, wPrinterTilemapBuffer
; 	ld a, " "
; 	ld [hli], a
; 	ld [hl], a
; 	hlcoord 1, 10, wPrinterTilemapBuffer
; 	ld a, $61
; 	ld [hli], a
; 	ld [hl], a
; 	hlcoord 2, 11, wPrinterTilemapBuffer
; 	lb bc, 5, 18
; 	call ClearBox
; 	ld a, [wTempSpecies]
; 	dec a
; 	call CheckCaughtMon
; 	push af
; 	ld a, [wTempSpecies]
; 	ld b, a
; 	ld c, 1 ; get page 1
; 	farcall GetDexEntryPagePointer
; 	pop af
; 	ld a, b
; 	hlcoord 1, 11, wPrinterTilemapBuffer
; 	call nz, PlaceFarString
; 	hlcoord 19, 0, wPrinterTilemapBuffer
; 	ld [hl], $35
; 	ld de, SCREEN_WIDTH
; 	add hl, de
; 	ld b, $f
; .column_loop
; 	ld [hl], $37
; 	add hl, de
; 	dec b
; 	jr nz, .column_loop
; 	ld [hl], $3a
; 	ret

PrintPage1:
	farcall dfsClearCache
	hlcoord 0, 0
	decoord 0, 0, wPrinterTilemapBuffer
	ld bc, 17 * SCREEN_WIDTH
	call CopyBytes

	hlcoord 1, 11, wPrinterTilemapBuffer
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	call ByteFill

	hlcoord 1, 12, wPrinterTilemapBuffer
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	call ByteFill

	hlcoord 1, 13, wPrinterTilemapBuffer
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	call ByteFill

	hlcoord 1, 14, wPrinterTilemapBuffer
	ld bc, SCREEN_WIDTH - 2
	ld a, " "
	call ByteFill

	hlcoord 9, 7, wPrinterTilemapBuffer
	ld de, .Height
	call PlaceString
	hlcoord 9, 9, wPrinterTilemapBuffer
	ld de, .Weight
	call PlaceString
	call GetPokemonName
	hlcoord 9, 3, wPrinterTilemapBuffer
	call PlaceString ; mon species
	ld a, [wTempSpecies]
	ld b, a
	farcall GetDexEntryPointer
	ld a, b
	call IncreaseDFSStack
	hlcoord 9, 5, wPrinterTilemapBuffer
	call PlaceFarString ; dex species
	ld h, b
	ld l, c
	ld a, [wEngPKMNNameMark]
	cp 1
	ld de, .PokemonStr
	jr nz, .CHS
	ld de, .PokemonStrENG
.CHS
	call PlaceString
	call DecreaseDFSStack
	hlcoord 17, 1, wPrinterTilemapBuffer
	ld a, $62
	ld [hli], a
	inc a ; $63
	ld [hl], a
	hlcoord 17, 2, wPrinterTilemapBuffer
	ld a, $64
	ld [hli], a
	inc a ; $65
	ld [hl], a

	hlcoord 1, 9, wPrinterTilemapBuffer
	ld a, " "
	ld [hli], a
	ld [hl], a

	hlcoord 1, 10, wPrinterTilemapBuffer
	ld a, $61
	ld [hli], a
	ld [hl], a

	hlcoord 1, 12, wPrinterTilemapBuffer
	lb bc, 5, 19
	call ClearBox
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	push af
	ld a, [wTempSpecies]
	ld b, a
	ld c, 1 ; get page 1
	farcall GetDexEntryPagePointer
	dec de
	pop af
	ld a, b
	hlcoord 1, 13, wPrinterTilemapBuffer
	call nz, PlaceFarString

	hlcoord 19, 0, wPrinterTilemapBuffer
	ld [hl], $35
	ld de, SCREEN_WIDTH
	add hl, de
	ld b, $f
.column_loop
	ld [hl], $37
	add hl, de
	dec b
	jr nz, .column_loop
	ld [hl], $3a
	ret
.Height:
	db_w "身高@"
.Weight:
	db_w "体重@"
.PokemonStr
	db_w "宝可梦@"
.PokemonStrENG
	db_w "@"

PrintPage2:
	farcall dfsClearCache
	hlcoord 0, 0, wPrinterTilemapBuffer
	ld bc, 8 * SCREEN_WIDTH
	ld a, " "
	call ByteFill
	hlcoord 0, 0, wPrinterTilemapBuffer
	ld a, $36
	ld b, 6
	call .FillColumn
	hlcoord 19, 0, wPrinterTilemapBuffer
	ld a, $37
	ld b, 6
	call .FillColumn
	hlcoord 0, 6, wPrinterTilemapBuffer
	ld [hl], $38
	inc hl
	ld a, $39
	ld bc, SCREEN_HEIGHT
	call ByteFill
	ld [hl], $3a
	hlcoord 0, 7, wPrinterTilemapBuffer
	ld bc, SCREEN_WIDTH
	ld a, $32
	call ByteFill
	ld a, [wTempSpecies]
	dec a
	call CheckCaughtMon
	push af
	ld a, [wTempSpecies]
	ld b, a
	ld c, 2 ; get page 2
	farcall GetDexEntryPagePointer
	pop af
	hlcoord 1, 1, wPrinterTilemapBuffer
	ld a, b
	call nz, PlaceFarString
	ret

.FillColumn:
	push de
	ld de, SCREEN_WIDTH
.column_loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .column_loop
	pop de
	ret

GBPrinterStrings: ; used only for BANK(GBPrinterStrings)
GBPrinterString_Null: db -1
GBPrinterString_CheckingLink: db $fe, "      ", $10, $11, $13, $75, $75, -1 ; 小字 检查中
GBPrinterString_Transmitting: db $fe, "      ", $0E, $0F, $13, $75, $75, -1 ; 小字 传输中
GBPrinterString_Printing:     db $fe, "      ", $00, $01, $13, $75, $75, -1 ; 小字 打印中
GBPrinterString_PrinterError1:
	db   		"      ", $00, $01, $03, $04, " 1" ; 小字 打印错误 1
	nextDirect 	""
	nextDirect 	"     ", $05, $06, $00, $01, $02, $07, $08, $09 ; 小字 请读打印机说明书
	db   -1
GBPrinterString_PrinterError2:
	db   		"      ", $00, $01, $03, $04, " 2" ; 小字 打印错误 2
	nextDirect 	""
	nextDirect 	"     ", $05, $06, $00, $01, $02, $07, $08, $09
	db   -1
GBPrinterString_PrinterError3:
	db   		"      ", $00, $01, $03, $04, " 3" ; 小字 打印错误 3
	nextDirect	""
	nextDirect 	"     ", $05, $06, $00, $01, $02, $07, $08, $09
	db   -1
GBPrinterString_PrinterError4:
	db   		"      ", $00, $01, $03, $04, " 4" ; 小字 打印错误 4
	nextDirect	""
	nextDirect 	"     ", $05, $06, $00, $01, $02, $07, $08, $09
	db   -1


; PrintPartyMonPage1:
; 	call ClearBGPalettes
; 	call ClearTilemap
; 	call ClearSprites

; 	xor a
; 	ldh [hBGMapMode], a
; 	call LoadFontsBattleExtra

; 	ld de, GBPrinterHPIcon
; 	ld hl, vTiles2 tile PRINTPARTY_HP
; 	lb bc, BANK(GBPrinterHPIcon), 1
; 	call Request1bpp

; 	ld de, GBPrinterLvIcon
; 	ld hl, vTiles2 tile "<LV>"
; 	lb bc, BANK(GBPrinterLvIcon), 1
; 	call Request1bpp

; 	ld de, StatsScreenPageTilesGFX + 14 tiles ; shiny icon
; 	ld hl, vTiles2 tile "⁂"
; 	lb bc, BANK(StatsScreenPageTilesGFX), 1
; 	call Get2bpp

; 	ld a, 1
; 	ldh [hCurrentPrintMode], a
; 	farcall LoadPrinterFont

; 	xor a
; 	ld [wMonType], a
; 	farcall CopyMonToTempMon
; 	hlcoord 0, 7
; 	ld b, 9
; 	ld c, 18
; 	call Textbox
; 	hlcoord 8, 2
; 	ld a, [wTempMonLevel]
; 	call PrintLevel_Force3Digits
; 	hlcoord 12, 2
; 	ld [hl], PRINTPARTY_HP
; 	inc hl
; 	ld de, wTempMonMaxHP
; 	lb bc, 2, 3
; 	call PrintNum
; 	ld a, [wCurPartySpecies]
; 	ld [wNamedObjectIndex], a
; 	ld [wCurSpecies], a
; 	ld hl, wPartyMonNicknames
; 	call GetCurPartyMonName
; 	hlcoord 8, 4
; 	call PlaceString
; 	hlcoord 9, 6
; 	ld [hl], "/"
; 	call GetPokemonName
; 	hlcoord 10, 6
; 	call PlaceString
; 	hlcoord 8, 0
; 	ld [hl], "№"
; 	inc hl
; 	ld [hl], "."
; 	inc hl
; 	ld de, wNamedObjectIndex
; 	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
; 	call PrintNum
; 	hlcoord 1, 9
; 	ld de, PrintParty_OTString
; 	call PlaceString
; 	ld hl, wPartyMonOTs
; 	call GetCurPartyMonName
; 	hlcoord 7, 9
; 	call PlaceString
; 	hlcoord 1, 11
; 	ld de, PrintParty_IDNoString
; 	call PlaceString
; 	hlcoord 4, 11
; 	ld de, wTempMonID
; 	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
; 	call PrintNum
; 	hlcoord 1, 14
; 	ld de, PrintParty_MoveString
; 	call PlaceString
; 	hlcoord 7, 15
; 	ld a, [wTempMonMoves + 0]
; 	call PlaceMoveNameString
; 	call PlaceGenderAndShininess
; 	ld hl, wTempMonDVs
; 	predef GetUnownLetter
; 	hlcoord 0, 0
; 	call PrepMonFrontpic
; 	call WaitBGMap
; 	ld b, SCGB_STATS_SCREEN_HP_PALS
; 	call GetSGBLayout
; 	call SetPalettes
; 	ret

PrintPartyMonPage1:
	call ClearBGPalettes
	call ClearTilemap
	call ClearSprites
	farcall dfsClearCache
	xor a
	ldh [hBGMapMode], a
	call LoadFontsBattleExtra

	ld de, GBPrinterHPIcon
	ld hl, vTiles2 tile PRINTPARTY_HP
	lb bc, BANK(GBPrinterHPIcon), 1
	call Request1bpp

	ld de, GBPrinterLvIcon
	ld hl, vTiles2 tile "<LV>"
	lb bc, BANK(GBPrinterLvIcon), 1
	call Request1bpp

	ld de, StatsScreenPageTilesGFX + 14 tiles ; shiny icon
	ld hl, vTiles2 tile $72 ;ld hl, vTiles2 tile "⁂"
	lb bc, BANK(StatsScreenPageTilesGFX), 1
	call Get2bpp

	ld a, 1
	ldh [hCurrentPrintMode], a
	farcall LoadPrinterFont

	; ld a, DFS_VRAM_LIMIT_VRAM0
	; ld [wDFSVramLimit], a

	xor a
	ld [wMonType], a
	farcall CopyMonToTempMon
	hlcoord 7, 0
	ld b, 16
	ld c, 11
	call Textbox
	hlcoord 0, 8
	lb bc, 8, 8
	call Textbox

	hlcoord 10, 8
	ld de, PrintParty_StatsString
	call PlaceString

	ld a, $4f
	lb bc, 10, 3
	coord hl, 10, 7
	call DFSStaticize

	hlcoord 8, 1
	ld a, [wTempMonLevel]
	call PrintLevel_Force3Digits
	hlcoord 12, 1
	ld [hl], PRINTPARTY_HP
	inc hl
	ld de, wTempMonMaxHP
	lb bc, 2, 3
	call PrintNum
	ld a, [wCurPartySpecies]
	ld [wNamedObjectIndex], a
	; ld [wCurSpecies], a
	; ld hl, wPartyMonNicknames
	; call GetCurPartyMonName
	; hlcoord 8, 4
	; call PlaceString
	; hlcoord 9, 6
	; ld [hl], "/"
	hlcoord 8, 3
	ld a, [wEngPKMNNameMark]
	cp 1
	ld de, PrintParty_MoveString
	jr nz, .CHS
	ld de, PrintParty_MoveStringENG
.CHS
	call PlaceString
	 
	ld a, $31
	lb bc, 2, 2
	coord hl, 8, 2
	call DFSStaticize

	call GetPokemonName
	ld a, [wEngPKMNNameMark]
	cp 1
	hlcoord 11, 3
	jr nz, .CHS2
	hlcoord 8, 3
.CHS2
	call PlaceString
	hlcoord 1, 0
	ld [hl], "№"
	inc hl
	ld [hl], "."
	inc hl
	ld de, wNamedObjectIndex
	lb bc, PRINTNUM_LEADINGZEROS | 1, 3
	call PrintNum
	hlcoord 8, 5
	ld de, PrintParty_OTString
	call PlaceString

	ld a, $35
	lb bc, 2, 3
	coord hl, 8, 4
	call DFSStaticize


	ld hl, wPartyMonOTs
	call GetCurPartyMonName
	hlcoord 12, 5
	call PlaceString
	hlcoord 11, 6
	ld de, PrintParty_IDNoString
	call PlaceString
	hlcoord 14, 6
	ld de, wTempMonID
	lb bc, PRINTNUM_LEADINGZEROS | 2, 5
	call PrintNum
	hlcoord 16, 8
	ld de, wTempMonAttack
	call .PrintTempMonStats
	hlcoord 16, 10
	ld de, wTempMonDefense
	call .PrintTempMonStats
	hlcoord 16, 12
	ld de, wTempMonSpclAtk
	call .PrintTempMonStats
	hlcoord 16, 14
	ld de, wTempMonSpclDef
	call .PrintTempMonStats
	hlcoord 16, 16
	ld de, wTempMonSpeed
	call .PrintTempMonStats

	; hlcoord 1, 14
	; ld de, PrintParty_MoveString
	; call PlaceString
	hlcoord 1, 10
	ld a, [wTempMonMoves + 0]
	call PlaceMoveNameString
	hlcoord 1, 12
	ld a, [wTempMonMoves + 1]
	call PlaceMoveNameString
	hlcoord 1, 14
	ld a, [wTempMonMoves + 2]
	call PlaceMoveNameString
	hlcoord 1, 16
	ld a, [wTempMonMoves + 3]
	call PlaceMoveNameString
	call PlaceGenderAndShininess
	ld hl, wTempMonDVs
	predef GetUnownLetter
	ld hl, wBoxAlignment
	xor a
	ld [hl], a
	ld a, [wCurPartySpecies]
	cp UNOWN
	jr z, .got_alignment
	inc [hl]
.got_alignment
	hlcoord 0, 1
	call _PrepMonFrontpic
	call WaitBGMap
	ld b, SCGB_STATS_SCREEN_HP_PALS
	call GetSGBLayout
	call SetPalettes
	; xor a ; DFS_VRAM_LIMIT_NOLIMIT
	; ld [wDFSVramLimit], a
	ret
.PrintTempMonStats:
	lb bc, 2, 3
	call PrintNum
	ret

; PrintPartyMonPage2:
; 	call ClearBGPalettes
; 	call ClearTilemap
; 	call ClearSprites
; 	xor a
; 	ldh [hBGMapMode], a
; 	call LoadFontsBattleExtra

; 	ld de, GBPrinterHPIcon
; 	ld hl, vTiles2 tile PRINTPARTY_HP
; 	lb bc, BANK(GBPrinterHPIcon), 1
; 	call Request1bpp

; 	ld de, GBPrinterLvIcon
; 	ld hl, vTiles2 tile "<LV>"
; 	lb bc, BANK(GBPrinterLvIcon), 1
; 	call Request1bpp

; 	ld de, StatsScreenPageTilesGFX + 14 tiles ; shiny icon
; 	ld hl, vTiles2 tile "⁂"
; 	lb bc, BANK(StatsScreenPageTilesGFX), 1
; 	call Get2bpp

; 	xor a
; 	ld [wMonType], a
; 	farcall CopyMonToTempMon
; 	hlcoord 0, 0
; 	ld b, 15
; 	ld c, 18
; 	call Textbox
; 	ld bc, SCREEN_WIDTH
; 	decoord 0, 0
; 	hlcoord 0, 1
; 	call CopyBytes
; 	hlcoord 7, 1
; 	ld a, [wTempMonMoves + 1]
; 	call PlaceMoveNameString
; 	hlcoord 7, 3
; 	ld a, [wTempMonMoves + 2]
; 	call PlaceMoveNameString
; 	hlcoord 7, 5
; 	ld a, [wTempMonMoves + 3]
; 	call PlaceMoveNameString
; 	hlcoord 7, 7
; 	ld de, PrintParty_StatsString
; 	call PlaceString
; 	hlcoord 16, 7
; 	ld de, wTempMonAttack
; 	call .PrintTempMonStats
; 	hlcoord 16, 9
; 	ld de, wTempMonDefense
; 	call .PrintTempMonStats
; 	hlcoord 16, 11
; 	ld de, wTempMonSpclAtk
; 	call .PrintTempMonStats
; 	hlcoord 16, 13
; 	ld de, wTempMonSpclDef
; 	call .PrintTempMonStats
; 	hlcoord 16, 15
; 	ld de, wTempMonSpeed
; 	call .PrintTempMonStats
; 	call WaitBGMap
; 	ld b, SCGB_STATS_SCREEN_HP_PALS
; 	call GetSGBLayout
; 	call SetPalettes
; 	ret

; .PrintTempMonStats:
; 	lb bc, 2, 3
; 	call PrintNum
; 	ret

GetCurPartyMonName:
	ld bc, NAME_LENGTH
	ld a, [wCurPartyMon]
	call AddNTimes
	ld e, l
	ld d, h
	ret

PlaceMoveNameString:
	and a
	jr z, .no_move

	ld [wNamedObjectIndex], a
	call GetMoveName
	jr .got_string

.no_move
	ld de, PrintParty_NoMoveString

.got_string
	call PlaceString
	ret

PlaceGenderAndShininess:
	farcall GetGender
	ld a, " "
	jr c, .got_gender
	ld a, "♂"
	jr nz, .got_gender
	ld a, "♀"

.got_gender
	hlcoord 17, 1
	ld [hl], a
	ld bc, wTempMonDVs
	farcall CheckShininess
	ret nc
	hlcoord 18, 1
	ld [hl], $72 ;ld [hl], "⁂" ; Shiny mark is relocated
	ret

PrintParty_OTString:
	db "OT/@"

PrintParty_MoveString:
	db "MOVE@"

PrintParty_MoveStringENG:
	db_w "@"

PrintParty_IDNoString:
	db "<ID>№@"

PrintParty_StatsString:
	db   "ATTACK"
	next "DEFENSE"
	next "SPCL.ATK"
	next "SPCL.DEF"
	next "SPEED"
	db   "@"

PrintParty_NoMoveString:
	db "--------@"

GBPrinterHPIcon:
INCBIN "gfx/printer/hp.1bpp"

GBPrinterLvIcon:
INCBIN "gfx/printer/lv.1bpp"
