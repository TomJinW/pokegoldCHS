dfsUnion_NoManagement:
	push de
	push hl

	ld b, h
	ld c, l
	push bc

    ld hl, wDFSNoManagementCurrentTileNo
    ld a, [wDFSNoManagementCurrentTileNo]
    ld b, a
    ld a, [wDFSNoManagementStartTile]
    cp b
    jr c, .okOrTooHigh
    jr .reset
.okOrTooHigh
    ld a, [wDFSNoManagementCurrentTileNo]
    ld b, a
    ld a, [wDFSNoManagementEndTile]
    cp b
    jr nc, .wrapped
.reset
    ld a, [wDFSNoManagementStartTile]
    ld [hl], a
.wrapped
	pop bc
	ld hl, wDFSCode
	ld a, [hli]
	cp a, $EC
	jr nc, StaticSingleCode_NoManagement
	cp a, $80
	jp nc, SingleCode_NoManagement
	cp a, $2F
	jr nc, StaticSingleCode_NoManagement

	ld a, [wDFSNoManagementCombineCode]
	and a
	jr z, .not_combine
	ld a, [sDFSCombineAddr]
	cp c
	jr nz, .not_combine
	ld a, [sDFSCombineAddr + 1]
	cp b
	jp z, CombineDoubleCode_NoManagement

.not_combine
    inc hl
	ld a, [hl]
	and a
	jr z, DoubleCode_NoManagement
	cp a, $14
	jp c, QuadrupleCode_NoManagement
	cp a, $2F
	jr nc, DoubleCode_NoManagement
	bit 3, a
	jp nz, QuadrupleCode_NoManagement

DoubleCode_NoManagement:
	ld a, [wDFSCode]
	ld [wDFSNoManagementCombineCode], a
	ld b, a
	set 6, a
	ld d, a
	ld a, [wDFSCode + 1]
	ld [wDFSNoManagementCombineCode + 1], a
	ld c, a
	ld e, a
	call DoubleCodeMain_NoManagement
	pop hl
	call DoubleCodeDrawMap_NoManagement
	call DFSNoManagementPrintLetterDelay
	push hl
	ld a, [wDFSCode]
	set 7, a
	ld b, a
	ld a, [wDFSCode + 1]
	ld c, a
	ld de, $0000
	call DoubleCodeMain_NoManagement
	pop hl
	call DoubleCodeDrawMap_NoManagement
    call DFSNoManagementPrintLetterDelay
	pop de
	inc de
	ld a, [wDFSCode]
	ld [wDFSNoManagementCombineCode], a
	ld a, [wDFSCode + 1]
	ld [wDFSNoManagementCombineCode + 1], a
	ld a, l
	ld [sDFSCombineAddr], a
	ld a, h
	ld [sDFSCombineAddr + 1], a
	ret

StaticSingleCode_NoManagement:
	pop hl
	ld [hli], a
    
    call DFSNoManagementPrintLetterDelay


	pop de
	xor a
	ld [wDFSNoManagementCombineCode], a
	ret

SingleCode_NoManagement:
	call SingleCodeMain_NoManagement
	pop hl
	call SingleCodeDrawMap_NoManagement
    call DFSNoManagementPrintLetterDelay
	pop de
	xor a
	ld [wDFSNoManagementCombineCode], a
	ret

CombineDoubleCode_NoManagement:
	ld a, [wDFSNoManagementCurrentTileNo]
; 	sub 2
;     ld b, a
;     ld a, [wDFSNoManagementStartTile]
;     sub b
;     jr c, .skipResettingTileNo
;     dec a
;     ld b, a
;     ld a, [wDFSNoManagementEndTile]
;     sub b
; .skipResettingTileNo
	; ld [wDFSNoManagementCurrentTileNo], a
	ld hl, wDFSNoManagementCombineCode
	ld a, [hli]
	ld b, a
	set 7, b
	ld c, [hl]
	ld hl, wDFSCode
	ld a, [hli]
	ld d, a
	ld e, [hl]
	call DoubleCodeMain_NoManagement
	pop hl
	dec hl
	call DoubleCodeDrawMap_NoManagement
    call DFSNoManagementPrintLetterDelay
	push hl
	ld hl, wDFSCode
	ld a, [hli]
	ld b, a
	ld d, a
	set 6, b
	set 7, d
	ld c, [hl]
	ld e, c
	call DoubleCodeMain_NoManagement
	pop hl
	call DoubleCodeDrawMap_NoManagement
    call DFSNoManagementPrintLetterDelay
	pop de
	inc de
	xor a
	ld [wDFSNoManagementCombineCode], a
	ret

SingleCodeMain_NoManagement:
	ld b, a
	ld a, [wDFSNoManagementCurrentTileNo]
	call GetVramAddr_NoManagement
	ld a, [wDFSNoManagementCurrentTileNo]
	call SendRom8FontToVram_NoManagement
	ret
	
DoubleCodeMain_NoManagement:
	ld a, [wDFSNoManagementCurrentTileNo]
	call Send8FontToWRAM_NoManagement
	call SendWRAM8FontToVram_NoManagement
	ret

Send8FontToWRAM_NoManagement:
	; push de
	; call Get4RawFontAddr_NoManagement
	; ld hl, wGBCOnlyDecompressBuffer
	; call DecompressRaw4FontTo8FontLeft
	; pop bc
	; ld a, b
	; or c
	; ret z
	; call Get4RawFontAddr_NoManagement
	; ld hl, wGBCOnlyDecompressBuffer + LEN_2BPP_TILE / 2
	; call DecompressRaw4FontTo8FontRight
	; ret
	push de
	call Send4RawFontToSRAM
	call Send4RawFontTo8FontLeft
	pop bc
	ld a, b
	or c
	; jr z, .skip
	ret z
	call Send4RawFontToSRAM
	call Send4RawFontTo8FontRight
; .skip
; 	jp SetFontStyle
	ret


; 4px单片字体原始大小，应该为6
DEF DFS_RAW_4FONT_SIZE EQU 4 * 12 / 8
; 送4px裸字体片到内存
; Get4RawFontAddr
Get4RawFontAddr_NoManagement:
	ld a, b
	push af

	and a, DFS_MASK_DOUBLE
	sla c
	rla
	ld b, 0
	ld d, b
	ld e, a
	ld hl, FontPointer_NoManagement
rept 3
	add hl, de
endr
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, [hl]
	ld h, b
	ld l, c
	add hl, hl
	add hl, hl
	add hl, hl
	add hl, bc
	add hl, de
	ld d, a
	pop af

	ld c, DFS_RAW_4FONT_SIZE
	jr .entry
.loop
	add hl, bc
.entry
	sub a, 1 << 6
	jr nc, .loop

	ld a, d
	ld d, h
	ld e, l
	ret

ResetIfTileIDTooHigh:
	push af
	ld b, a
	ld a, [wDFSNoManagementEndTile]
	cp b
	jr nc, .wrapped
	pop af
	ld a, [wDFSNoManagementStartTile]
	ret
.wrapped
	pop af
	ret

GetVramAddr_NoManagement:
	swap a
	ld e, a
	and a, $0F
	ld d, a
	ld a, e
	and a, $F0
	ld e, a
	ld hl, $9000
	add hl, de
	ret
	
SendWRAM8FontToVram_NoManagement:
	; ld de, wGBCOnlyDecompressBuffer
	; ld b, BANK(GBCOnlyGFX)
	; call Get2bpp
	; ret

	ld a, [wDFSNoManagementCurrentTileNo]
	call GetVramAddr_NoManagement
	ld c, $2

	ld de, sDFS8Font
	ld c, LOW(rSTAT)
	di
rept $10
.loop\@
	ldh a, [c]
	and $2
	jr nz, .loop\@
	ld a, [de]
	ld [hli], a
	inc de
endr

	push de
	ld a, [wDFSNoManagementCurrentTileNo]
	inc a
	ld b, a
	ld a, [wDFSNoManagementEndTile]
	cp b
	jr nc, .wrapped
	ld a, [wDFSNoManagementStartTile]
	jr .sendSecoundTile
.wrapped
	ld a, [wDFSNoManagementCurrentTileNo]
	inc a
.sendSecoundTile
	call GetVramAddr_NoManagement
	
	pop de

rept $10
.loop\@
	ldh a, [c]
	and $2
	jr nz, .loop\@
	ld a, [de]
	ld [hli], a
	inc de
endr
	reti
	
SendRom8FontToVram_NoManagement:
	push hl
	ld h, 0
	ld l, b
	res 7, l
rept 3
	add hl, hl
endr
	ld bc, Font
	add hl, bc
	ld d, h
	ld e, l
	lb bc, BANK(Font), $01
	pop hl
	call Get1bpp
	ret

SingleCodeDrawMap_NoManagement:
	ld a, [wDFSNoManagementCurrentTileNo]
	ld [hli], a
	inc a
	call ResetIfTileIDTooHigh
	ld [wDFSNoManagementCurrentTileNo], a
	ret
DoubleCodeDrawMap_NoManagement:
	ld a, [wDFSNoManagementCurrentTileNo]
	ld bc, - SCREEN_WIDTH
	add hl, bc
	ld [hl], a
	inc a
	call ResetIfTileIDTooHigh
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	inc a
	call ResetIfTileIDTooHigh
	ld [wDFSNoManagementCurrentTileNo], a
	ret

MACRO dfontab_NoManagement
rept _NARG
	dwb DFS_C_\1_L, BANK(DFS_C_\1_L)
	dwb DFS_C_\1_H, BANK(DFS_C_\1_H)
	shift
endr
ENDM

FontPointer_NoManagement:
	dfontab_NoManagement FF, 01, 02, 03, 04, 05, 06, 07, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	dfontab_NoManagement 10, 11, 12, 13, FF, FF, FF, FF, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F
	dfontab_NoManagement FF, FF, FF, FF, FF, FF, FF, FF, 28, 29, 2A, 2B, 2C, 2D, 2E, FF


QuadrupleCode_NoManagement:
    ld hl, wDFSCode
	ld a, [hli]
	ld b, a
	ld d, a
	set 6, d
	ld c, [hl]
	ld e, c
	call DoubleCodeMain_NoManagement
	pop hl
	call DoubleCodeDrawMap_NoManagement
	call DFSNoManagementPrintLetterDelay
	push hl
	ld hl, wDFSCode
	ld a, [hli]
	ld b, a
	set 7, b
	ld a, [hli]
	ld c, a
	ld a, [hli]
	ld d, a
	ld e, [hl]
	call DoubleCodeMain_NoManagement
	pop hl
	call DoubleCodeDrawMap_NoManagement
	call DFSNoManagementPrintLetterDelay
	push hl
	ld hl, wDFSCode + 2
	ld a, [hli]
	ld b, a
	ld d, a
	set 6, b
	set 7, d
	ld c, [hl]
	ld e, c
	call DoubleCodeMain_NoManagement
	pop hl
	call DoubleCodeDrawMap_NoManagement
	call DFSNoManagementPrintLetterDelay
	pop de
	inc de
	inc de
	inc de
	xor a
	ld [wDFSNoManagementCombineCode], a
	ret

DFSNoManagementPrintLetterDelay:
    ld a, [wDFSNoManagementPrintDelay]
    and a
    jr z, .skip
    call PrintLetterDelay
.skip
    ret