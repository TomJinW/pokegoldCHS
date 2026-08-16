FarCopyData2::
; Copy bc bytes from a:hl to de.
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	ldh [hROMBank], a
	ld [MBC3RomBank], a
	call CopyBytes
	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a
	ret

FarCopyDataDouble::
; Expand bc bytes of 1bpp image data
; from a:hl to 2bpp data at de.
	ld [wBuffer], a
	ldh a, [hROMBank]
	push af
	ld a, [wBuffer]
	ldh [hROMBank], a
	ld [MBC3RomBank], a
.loop
	ld a, [hli]
	ld [de], a
	inc de
	ld [de], a
	inc de
	dec bc
	ld a, c
	or b
	jr nz, .loop
	pop af
	ldh [hROMBank], a
	ld [MBC3RomBank], a
	ret

DebugPressedOrHeldB::
IF DEF(_DEBUG)
	ldh a, [hJoyDown]
	bit B_BUTTON_F, a
	ret nz
	ldh a, [hJoyPressed]
	bit B_BUTTON_F, a
ENDC
	ret

DebugPressedOrHeldUP::
IF DEF(_DEBUG)
	ldh a, [hJoyDown]
	bit D_UP_F, a
	ret nz
	ldh a, [hJoyPressed]
	bit D_UP_F, a
	ret
ENDC

; CopyDataOld::
; 	; Copy bc bytes from hl to de.
; 	ld a, [hli]
; 	ld [de], a
; 	inc de
; 	dec bc
; 	ld a, c
; 	or b
; 	jr nz, CopyDataOld
; 	ret

; ClearFullVramNo::
	; ret
; 	hlcoord 0, 0, wAttrmap
; 	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
; ClearVramNo::
	; ret
; 	inc b  ; we bail the moment b hits 0, so include the last run
; 	inc c  ; same thing; include last byte
; 	jr .HandleLoop
; .Clear:
; 	res OAM_TILE_BANK, [hl]
; 	inc hl
; .HandleLoop:
; 	dec c
; 	jr nz, .Clear
; 	dec b
; 	jr nz, .Clear
; 	ret

; ResetVramNo::
; 	push hl
; 	ld hl, wDFSVramLimit
; 	bit 2, [hl]
; 	pop hl
; 	ret nz
; 	push bc
; 	push hl
; 	ld bc, wAttrmap - wTilemap
; 	add hl, bc
; 	res OAM_TILE_BANK, [hl]
; 	pop hl
; 	pop bc
; 	ret

DFSStaticize2::
	ld a, $0
	lb bc, 2, 5
	coord hl, 12, 8
DFSStaticize::
	push af
	swap a
	ld d, a
	and $F0
	ld e, a
	ld a, d
	and $0F
	or HIGH(vTiles2)
	ld d, a
	pop af
.row
	push bc
	push hl
.col
	push af
	ld a, [hl]
	cp a, $EC
	jr nc, .static
	cp a, $80
	jr c, .static

	push hl
	swap a
	ld h, a
	and $F0
	ld l, a
	ld a, h
	and $0F
	or HIGH(vTiles0)
	ld h, a

	push bc
	lb bc, $10, LOW(rSTAT)
	di
.loop
	; ldh a, [rLY]
	; cp a, $8c
	; jr nc, .loop
	ldh a, [c]
	and $2
	jr nz, .loop
	ld a, [hli]
	ld [de], a
	inc de
	dec b
	jr nz, .loop
	ei
	pop bc

	pop hl

	pop af
	ld [hli], a
	inc a
	; cp a, $03 ; flower
	; jr z, .skipmovingtile
	; cp a, $14 ; water
	; jr z, .skipmovingtile

.staticend
	dec c
	jr nz, .col
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	ret

.static
	inc hl
	pop af
	jr .staticend

.skipmovingtile
	inc a
	swap e
	inc e
	swap e
	jr .staticend

NewDFSRightAlign::
	push hl
	push de
	dec hl
	dec hl
	ld de, .FullSpaceText
	call PlaceString
	ld [hl], " "
	ld bc, -SCREEN_WIDTH
	add hl, bc
	ld [hl], " "
	pop de
	pop hl
	ret
.FullSpaceText
	db $01,$01,$50

SetupDFSNomanagementIMEWithDelay::
	ld b, $0
	ld c, $5f
	ld a, 1
	ld [wDFSNoManagementPrintDelay], a
	jr SetupDFSNomanagementWithBC

SetupDFSNomanagementIME::
	ld b, $0
	ld c, $5f
	jr SetupDFSNomanagementWithBCNoDelay

SetupDFSNomanagementWithBCFixRangeNoDelay::
	ld b, $31
	ld c, $5b
SetupDFSNomanagementWithBCNoDelay::
	ld a, 0
	ld [wDFSNoManagementPrintDelay], a
SetupDFSNomanagementWithBC::
	ld a, b
	ld [wDFSNoManagementStartTile], a
	ld a, c
	ld [wDFSNoManagementEndTile], a
	jr SetupDFSNomanagementNoDelay.enable

SetupDFSNomanagement::
	ld a, 1
	ld [wDFSNoManagementPrintDelay], a
	jr SetupDFSNomanagementNoDelay.setupTileID
SetupDFSNomanagementNoDelay::
	ld a, 0
	ld [wDFSNoManagementPrintDelay], a
.setupTileID
	ld a, $2E
    ld [wDFSNoManagementStartTile], a
    ld a, $75
    ld [wDFSNoManagementEndTile], a
.enable
	ld a, 1
    ld [wDFSNoManagementEnabled], a
	; ld a, 0
    ; ld [wDFSNoManagementCombineCode], a
	ret

DisableDFSNoManagement::
	ld a, 0
    ld [wDFSNoManagementEnabled], a
	ret

PlaceFarPrinterStringDirect::
	ld b, a
	ldh a, [hROMBank]
	push af

	ld a, b
	rst Bankswitch
	call PlacePrinterStringDirect

	pop af
	rst Bankswitch
	ret

PlaceStringDirect::
	push hl
.loop
	ld a, [de]
	cp -1
	jr z, .done
	cp $fe
	jr nz, .notNewLine
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	push hl
	inc de
	jr .loop
.notNewLine
	inc de
	; cp $72
	; jr nc, .notUsingShift
	; ld c, a
	; ldh a, [hCurrentPrintTileIDOffset]
	; add a, c
.notUsingShift
	ld [hli], a
	jr .loop
.done
	pop hl
	ret

PlacePrinterStringDirect::
	push hl
.loop
	ld a, [de]
	cp -1
	jr z, .done
	cp $fe
	jr nz, .notNewLine
	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	push hl
	inc de
	jr .loop
.notNewLine
	inc de
	cp $72
	jr nc, .notUsingShift
	ld c, a
	ldh a, [hCurrentPrintTileIDOffset]
	add a, c
.notUsingShift
	ld [hli], a
	jr .loop
.done
	pop hl
	ret

OpenSWindowStackSRAMOnlyDMG::
	ldh a, [hCGB]
	and a
	ret nz
	ld a, BANK(sWindowStack)
	call OpenSRAM
	ret


OpenSDFSCodeStackSRAMOnlyDMG::
	ldh a, [hCGB]
	and a
	ret nz
	ld a, BANK(sDFSCodeStack)
	call OpenSRAM
	ret

