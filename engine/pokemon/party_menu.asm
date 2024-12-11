SelectMonFromParty:
	call DisableSpriteUpdates
	xor a
	ld [wPartyMenuActionText], a
	call ClearBGPalettes
	call InitPartyMenuLayout
	call WaitBGMap
	call SetPalettes
	call DelayFrame
	call PartyMenuSelect
	call ReturnToMapWithSpeechTextbox
	ret

SelectTradeOrDayCareMon:
	ld a, b
	ld [wPartyMenuActionText], a
	call DisableSpriteUpdates
	call ClearBGPalettes
	call InitPartyMenuLayout
	call WaitBGMap
	ld b, SCGB_PARTY_MENU
	call GetSGBLayout
	call SetPalettes
	call DelayFrame
	call PartyMenuSelect
	call ReturnToMapWithSpeechTextbox
	ret

InitPartyMenuLayout:
	call LoadPartyMenuGFX
	call InitPartyMenuWithCancel
	call InitPartyMenuGFX
	call WritePartyMenuTilemap
	call PrintPartyMenuText
	ret

LoadPartyMenuGFX:
	call LoadFontsBattleExtra
	callfar InitPartyMenuPalettes
	callfar ClearSpriteAnims2
	ret

WritePartyMenuTilemap:
	ld hl, wOptions
	ld a, [hl]
	push af
	set NO_TEXT_SCROLL, [hl]
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
	ld a, " "
	call ByteFill ; blank the tilemap
	;call ClearFullVramNo
	call GetPartyMenuQualityIndexes
.loop
	ld a, [hli]
	cp -1
	jr z, .end
	push hl
	ld hl, .Jumptable
	rst JumpTable
	pop hl
	jr .loop
.end
	pop af
	ld [wOptions], a
	ret

.Jumptable:
; entries correspond to PARTYMENUQUALITY_* constants
	dw PlacePartyNicknames
	dw PlacePartyHPBar
	dw PlacePartyMenuHPDigits
	dw PlacePartyMonLevel
	dw PlacePartyMonStatus
	dw PlacePartyMonTMHMCompatibility
	dw PlacePartyMonEvoStoneCompatibility
	dw PlacePartyMonGender

PlacePartyNicknames:

	; CGB 超频模式启动
	; ld a, [hCGB] ;
	; and a ;
	; jr z, .NOTCGB ;

	; ld a, 1 ;
	; ldh [rKEY1], a ;
	; stop ;
.NOTCGB ;

	hlcoord 3, 1 ;hlcoord 3, 1
	ld a, [wPartyCount]
	and a
	jr z, .end
	ld c, a
	ld b, 0
.loop
	push bc
	push hl
	push hl
	ld hl, wPartyMonNicknames
	ld a, b
	call GetNickname
	lb bc, 15, 1
	farcall FixStrLength
	pop hl
	call IncreaseDFSStack
	
	; push hl
	; push de
	; dec hl
	; dec hl
	; ld de, .FullSpaceText
	; call PlaceString
	; ld [hl], " "
	; ld bc, -SCREEN_WIDTH
	; add hl, bc
	; ld [hl], " "
	; pop de
	; pop hl
	; ld a, $0
    ; ld [wDFSNoManagementStartTile], a
    ; ld a, $5F
    ; ld [wDFSNoManagementEndTile], a
    ; ld a, 0
    ; ld [wDFSNoManagementPrintDelay], a
	; ld a, 1
    ; ld [wDFSNoManagementEnabled], a
	; ld a, 1
    ; ld [wDFSNoManagementCombineCode], a

	call NewDFSRightAlign



	call PlaceString

	; ld a, 0
    ; ld [wDFSNoManagementEnabled], a

	call DecreaseDFSStack

	pop hl ;
	pop bc
	push bc
	push hl ;
	ld a, c ;
	dec a
	sla a
	sla a
	sla a
	sla a

	lb bc, 2, 8
	ld de, - SCREEN_WIDTH - 1
	add hl, de
	call DFSStaticize ;

	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop

.end



	; dec hl
	
	; push hl ;
	; ld a, 0 ;
	; lb bc, 12, 8 ;
	; hlcoord 2, 0 ;
	; call DFSStaticize ;
	; pop hl ;

	dec hl
	ld de, .CancelString
	call PlaceString

	; CGB 超频模式关闭
	; ld a, [hCGB] ;
	; and a ;
	; jr z, .NOTCGB2 ;

	; ld a, 1 ;
	; ldh [rKEY1], a ;
	; stop ;
.NOTCGB2
	ret
.FullSpaceText
	db $01,$01,$50


.CancelString:
	db "CANCEL@"

PlacePartyHPBar:
	xor a
	ld [wSGBPals], a
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 13, 1 ;hlcoord 11, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr z, .skip
	push hl
	call PlacePartymonHPBar
	pop hl
	ld d, $4 ;ld d, $6
	ld b, $0
	call DrawBattleHPBar
	ld hl, wHPPals
	ld a, [wSGBPals]
	ld c, a
	ld b, 0
	add hl, bc
	call SetShortHPPal ;call SetHPPal
	ld b, SCGB_PARTY_MENU_HP_BARS
	call GetSGBLayout
.skip
	ld hl, wSGBPals
	inc [hl]
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ld b, SCGB_PARTY_MENU
	call GetSGBLayout
	ret

PlacePartymonHPBar:
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1HP
	call AddNTimes
	ld a, [hli]
	or [hl]
	jr nz, .not_fainted
	xor a
	ld e, a
	ld c, a
	ret

.not_fainted
	dec hl
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld a, [hli]
	ld e, a
	predef ComputeShortHPBarPixels ;predef ComputeHPBarPixels
	ret

PlacePartyMenuHPDigits:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 13, 0 ;hlcoord 13, 1
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr z, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1HP
	call AddNTimes
	ld e, l
	ld d, h
	pop hl
	push de
	lb bc, 2, 3
	call PrintNum
	pop de
	ld a, "/"
	ld [hli], a
	inc de
	inc de
	lb bc, 2, 3
	call PrintNum

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartyMonLevel:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 10, 1 ;hlcoord 8, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr z, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Level
	call AddNTimes
	ld e, l
	ld d, h
	pop hl
	ld a, [de]
	cp 100 ; This is distinct from MAX_LEVEL.
	jr nc, .ThreeDigits
	ld a, "<LV>"
	ld [hli], a
	lb bc, PRINTNUM_LEFTALIGN | 1, 2
	; jr .okay
.ThreeDigits:
	lb bc, PRINTNUM_LEFTALIGN | 1, 3
; .okay
	call PrintNum

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartyMonStatus:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	; hlcoord 5, 2
	hlcoord 10, 0
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr z, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Status
	call AddNTimes
	ld e, l
	ld d, h
	pop hl
	call PlaceStatusString

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

PlacePartyMonTMHMCompatibility:
	ld a, 1
	ld [wPartyMonLearnMark], a

	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 13, 1 ;hlcoord 12, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr z, .next
	push hl
	ld hl, wPartySpecies
	ld e, b
	ld d, 0
	add hl, de
	ld a, [hl]
	ld [wCurPartySpecies], a
	predef CanLearnTMHMMove
	pop hl
	call .PlaceAbleNotAble
	; call PlaceString

.next
	pop hl
	ld de, SCREEN_WIDTH * 2
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

.PlaceAbleNotAble:
	ld a, c
	and a
	jr nz, .able

.not_able
	ld de, .string_not_able
	call PlaceString

	ld a, [wPartyMonLearnMark]
	cp 1
	jr nz, .AlreadyHasIntialValueNotAble
	ld a, 0
	ld [wPartyMonLearnMark], a
.AlreadyHasIntialValueNotAble
	ld a, [wPartyMonLearnMark]
	cpl
	or 0
	ret nz
	jr SaveDFSTiles


.able
	ld de, .string_able
	call PlaceString

	ld a, [wPartyMonLearnMark]
	cp 1
	jr nz, .AlreadyHasIntialValueAble
	ld a, $FF
	ld [wPartyMonLearnMark], a
.AlreadyHasIntialValueAble
	ld a, [wPartyMonLearnMark]
	or 0
	ret nz
	jr SaveDFSTiles

.string_able
	db_w "能学习！@" ;db "ABLE@"

.string_not_able
	db_w "不能学@" ;db "NOT ABLE@"

SaveDFSTiles:
	push hl
	ld bc, -SCREEN_WIDTH
	add hl, bc
	ld a, $60
	lb bc, 2, 6
	call DFSStaticize 
	pop hl
	ret 

PlacePartyMonEvoStoneCompatibility:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 13, 1 ;hlcoord 12, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr z, .next
	push hl
	ld a, b
	ld bc, PARTYMON_STRUCT_LENGTH
	ld hl, wPartyMon1Species
	call AddNTimes
	ld a, [hl]
	dec a
	ld e, a
	ld d, 0
	ld hl, EvosAttacksPointers
	add hl, de
	add hl, de
	call .DetermineCompatibility
	pop hl
	call PlaceString

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

.DetermineCompatibility:
; BUG: Only the first three evolution entries can have Stone compatibility reported correctly (see docs/bugs_and_glitches.md)
	ld de, wStringBuffer1
	ld a, BANK(EvosAttacksPointers)
	ld bc, 2
	call FarCopyBytes
	ld hl, wStringBuffer1
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer1
	ld a, BANK("Evolutions and Attacks")
	ld bc, 10
	call FarCopyBytes
	ld hl, wStringBuffer1
.loop2
; BUG: EVOLVE_STAT can break Stone compatibility reporting (see docs/bugs_and_glitches.md)
	ld a, [hli]
	and a
	jr z, .nope
	inc hl
	inc hl
	cp EVOLVE_ITEM
	jr nz, .loop2
	dec hl
	dec hl
	ld a, [wCurItem]
	cp [hl]
	inc hl
	inc hl
	jr nz, .loop2
	ld de, .string_able
	ret

.nope
	ld de, .string_not_able
	ret

.string_able
	db_w "能使用@" ;db "ABLE@"
.string_not_able
	db_w "不能用@" ;db "NOT ABLE@"

PlacePartyMonGender:
	ld a, [wPartyCount]
	and a
	ret z
	ld c, a
	ld b, 0
	hlcoord 13, 1 ;hlcoord 12, 2
.loop
	push bc
	push hl
	call PartyMenuCheckEgg
	jr z, .next
	ld [wCurPartySpecies], a
	push hl
	ld a, b
	ld [wCurPartyMon], a
	xor a
	ld [wMonType], a
	call GetGender
	ld de, .unknown
	jr c, .got_gender
	ld de, .male
	jr nz, .got_gender
	ld de, .female

.got_gender
	pop hl
	call PlaceString

.next
	pop hl
	ld de, 2 * SCREEN_WIDTH
	add hl, de
	pop bc
	inc b
	dec c
	jr nz, .loop
	ret

.male
	db "♂…MALE@"

.female
	db "♀…FEMALE@"

.unknown
	db "…UNKNOWN@"

PartyMenuCheckEgg:
	ld a, LOW(wPartySpecies)
	add b
	ld e, a
	ld a, HIGH(wPartySpecies)
	adc 0
	ld d, a
	ld a, [de]
	cp EGG
	ret

GetPartyMenuQualityIndexes:
	ld a, [wPartyMenuActionText]
	and $f0
	jr nz, .skip
	ld a, [wPartyMenuActionText]
	and $f
	ld e, a
	ld d, 0
	ld hl, PartyMenuQualityPointers
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

.skip
	ld hl, PartyMenuQualityPointers.Default
	ret

INCLUDE "data/party_menu_qualities.asm"

InitPartyMenuGFX:
	ld hl, wPartyCount
	ld a, [hli]
	and a
	ret z
	ld c, a
	xor a
	ldh [hObjectStructIndex], a
.loop
	push bc
	push hl
	ld hl, LoadMenuMonIcon
	ld a, BANK(LoadMenuMonIcon)
	ld e, MONICON_PARTYMENU
	rst FarCall
	ldh a, [hObjectStructIndex]
	inc a
	ldh [hObjectStructIndex], a
	pop hl
	pop bc
	dec c
	jr nz, .loop
	callfar PlaySpriteAnimations
	ret

InitPartyMenuWithCancel:
; with cancel
	xor a
	ld [wSwitchMon], a
	ld de, PartyMenu2DMenuData
	call Load2DMenuData
	ld a, [wPartyCount]
	inc a
	ld [w2DMenuNumRows], a ; list length
	dec a
	ld b, a
	ld a, [wPartyMenuCursor]
	and a
	jr z, .skip
	inc b
	cp b
	jr c, .done

.skip
	ld a, 1

.done
	ld [wMenuCursorY], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ret

InitPartyMenuNoCancel:
; no cancel
	ld de, PartyMenu2DMenuData
	call Load2DMenuData
	ld a, [wPartyCount]
	ld [w2DMenuNumRows], a ; list length
	ld b, a
	ld a, [wPartyMenuCursor]
	and a
	jr z, .skip
	inc b
	cp b
	jr c, .done
.skip
	ld a, 1
.done
	ld [wMenuCursorY], a
	ld a, A_BUTTON | B_BUTTON
	ld [wMenuJoypadFilter], a
	ret

PartyMenu2DMenuData:
	db 1, 0 ; cursor start y, x
	db 0, 1 ; rows, columns
	db $60, $00 ; flags
	dn 2, 0 ; cursor offset
	db 0 ; accepted buttons

PartyMenuSelect:
; sets carry if exitted menu.
	call StaticMenuJoypad
	call PlaceHollowCursor
	ld a, [wPartyCount]
	inc a
	ld b, a
	ld a, [wMenuCursorY] ; menu selection?
	cp b
	jr z, .exitmenu ; CANCEL
	ld [wPartyMenuCursor], a
	ldh a, [hJoyLast]
	ld b, a
	bit B_BUTTON_F, b
	jr nz, .exitmenu ; B button
	ld a, [wMenuCursorY]
	dec a
	ld [wCurPartyMon], a
	ld c, a
	ld b, 0
	ld hl, wPartySpecies
	add hl, bc
	ld a, [hl]
	ld [wCurPartySpecies], a

	ld de, SFX_READ_TEXT_2
	call PlaySFX
	call WaitSFX
	and a
	ret

.exitmenu
	ld de, SFX_READ_TEXT_2
	call PlaySFX
	call WaitSFX
	scf
	ret

PrintPartyMenuText:
	hlcoord 0, 14
	lb bc, 2, 18
	call Textbox
	ld a, [wPartyCount]
	and a
	jr nz, .haspokemon
	ld de, YouHaveNoPKMNString
	jr .gotstring
.haspokemon
	ld a, [wPartyMenuActionText]
	and $f ; drop high nibble
	ld hl, PartyMenuStrings
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
.gotstring
	ld a, [wOptions]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions], a
	hlcoord 1, 16 ; Coord
	call PlaceString
	pop af
	ld [wOptions], a
	ret

PartyMenuStrings:
	dw ChooseAMonString
	dw UseOnWhichPKMNString
	dw WhichPKMNString
	dw TeachWhichPKMNString
	dw MoveToWhereString
	dw UseOnWhichPKMNString
	dw ChooseAMonString ; Probably used to be ChooseAFemalePKMNString
	dw ChooseAMonString ; Probably used to be ChooseAMalePKMNString
	dw ToWhichPKMNString

ChooseAMonString:
	db "Choose a #MON.@"

UseOnWhichPKMNString:
	db "Use on which <PK><MN>?@"

WhichPKMNString:
	db "Which <PK><MN>?@"

TeachWhichPKMNString:
	db "Teach which <PK><MN>?@"

MoveToWhereString:
	db "Move to where?@"

ChooseAFemalePKMNString: ; unreferenced
	db "Choose a ♀<PK><MN>.@"

ChooseAMalePKMNString: ; unreferenced
	db "Choose a ♂<PK><MN>.@"

ToWhichPKMNString:
	db "To which <PK><MN>?@"

YouHaveNoPKMNString:
	db "You have no <PK><MN>!@"

PrintPartyMenuActionText:
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	call GetNickname
	ld a, [wPartyMenuActionText]
	and $f
	ld hl, .MenuActionTexts
	call .PrintText
	ret

.MenuActionTexts:
; entries correspond to PARTYMENUTEXT_* constants
	dw .CuredOfPoisonText
	dw .BurnWasHealedText
	dw .WasDefrostedText
	dw .WokeUpText
	dw .RidOfParalysisText
	dw .RecoveredSomeHPText
	dw .HealthReturnedText
	dw .RevitalizedText
	dw .GrewToLevelText
	dw .CameToItsSensesText

.RecoveredSomeHPText:
	text_far _RecoveredSomeHPText
	text_end

.CuredOfPoisonText:
	text_far _CuredOfPoisonText
	text_end

.RidOfParalysisText:
	text_far _RidOfParalysisText
	text_end

.BurnWasHealedText:
	text_far _BurnWasHealedText
	text_end

.WasDefrostedText:
	text_far _WasDefrostedText
	text_end

.WokeUpText:
	text_far _WokeUpText
	text_end

.HealthReturnedText:
	text_far _HealthReturnedText
	text_end

.RevitalizedText:
	text_far _RevitalizedText
	text_end

.GrewToLevelText:
	text_far _GrewToLevelText
	text_end

.CameToItsSensesText:
	text_far _CameToItsSensesText
	text_end

.PrintText:
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wOptions]
	push af
	set NO_TEXT_SCROLL, a
	ld [wOptions], a
	call PrintText
	pop af
	ld [wOptions], a
	ret
