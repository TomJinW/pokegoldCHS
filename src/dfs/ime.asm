IMEInputFont:
    INCBIN "gfx/naming_screen/imeInputFont.2bpp"
    
imeInput::
    ; ret
	ld a, [de]
	cp $1A ; letter after Z
	jr nc, .notUppercaseLetterInVtiles2
	set 7, a
	jr .eng
.notUppercaseLetterInVtiles2
	cp a, $61
	jr z, .pgup
	cp a, $EE
	jr z, .pgdn
.notpg
	cp $60
	jr nc, .normal
.code

	ld a, [wNamingScreenCursorObjectPointer]
	ld l, a
	ld a, [wNamingScreenCursorObjectPointer + 1]
	ld h, a

	ld bc, SPRITEANIMSTRUCT_VAR2
	add hl, bc

	ld a, [hld]
	sub 2

	add a
	add a
	add a
	add a

	ld c, a
	ld a, [hl]
	sub 2
	add a, c
	
	ld b, 0
	ld c, a

	ld a, BANK(sIMELine_u108)
	call OpenSRAM

	ld hl, sIMELine_u108
	add hl, bc

	ld a, [hli]
	cp $2F
	jr nc, .eng
	ld l, [hl]
	ld h, a
	ld a, h
	ld [wIMEChar], a
	ld a, l
	ld [wIMEChar + 1], a
	ld hl, wIMEPinyin
	ld [hl], "@"
	hlcoord 13, 10
	ld de, SixUnderLine
	ld a, [wIMEtmpBuffer]
	bit 0, a
	call z, PlaceString
	; pop af
	; ldh [rSVBK], a
	call CloseSRAM
	ld b, 1
	ret

	; ld a, [hli]
	; ld [wIMEChar], a
	; ld a, [hl]
	; ld [wIMEChar + 1], a
	; call CloseSRAM
	; ld hl, wIMEPinyin
	; ld [hl], "@"
	; hlcoord 13, 10
	; ld de, SixUnderLine
	; ld a, [wIMEtmpBuffer]
	; bit 0, a
	; call z, PlaceString
   


	; ld c, a
	; ld a, BANK(sDFSCache)
	; call OpenSRAM
	; ld a, c
	; and a, %01111110
	; rlca
	; ld l, a
	; ld h, HIGH(sDFSCache)
	; ld a, [hli]
	; and a, DFS_MASK_DOUBLE
	; jr z, .eng
	; ld l, [hl]
	; ld h, a
	; ld a, h
	; ld [wIMEChar], a
	; ld a, l
	; ld [wIMEChar + 1], a
	; ld hl, wIMEPinyin
	; ld [hl], "@"
	; hlcoord 13, 10
	; ld de, SixUnderLine
	; ld a, [wIMEtmpBuffer]
	; bit 0, a
	; call z, PlaceString
    ; call CloseSRAM
	; ; pop af
	; ; ldh [rSVBK], a
	; ld b, 1
	ret
.eng
	ld b, a
	ld a, [wIMEtmpBuffer]
	bit 0, a
	jr z, InputPinyin
	ret
.normal
	ld b, a
	ret
.pgup
	ld a, [wIMELine]
	and a
	jr z, .end
	dec a
	ld [wIMELine], a
	call PrintIMELines
.end
	ld b, 0
	ret
.pgdn
	ld a, [wIMEMaxLine]
	ld b, a
	ld a, [wIMELine]
	inc a
	cp a, b
	jr z, .end
	ld [wIMELine], a
	call PrintIMELines
	ld b, 0
	ret
	

InputPinyin:
	ld hl, wIMEPinyin
	ld c, 6
.ccloop
	ld a, [hl]
	cp a, "@"
	jr z, .ccend
	inc hl
	dec c
	jr nz, .ccloop
	jr .full
.ccend
	ld [hl], b
	inc hl
	ld [hl], "@"
	call SetPinyin
.full:
	ld b, 0
	ret

SetPinyin::
;	 hlcoord 13, 10
;	 lb bc, 1, 6
;	 call ClearBox
	hlcoord 13, 10
	ld de, SixUnderLine
	call PlaceString
	hlcoord 13, 10
	ld de, wIMEPinyin
	call PlaceString
	xor a
	ld [wIMELine], a
	call GetPinyinNo
	call GetPinyinEntry
	call PrintIMELines
	ret
	
GetPinyinNo:
	ld bc, $0000
	ld hl, PinyinTB
	jr .start
.miss
	pop hl
	ld de, $0007
	add hl, de
	inc bc
.start
	push hl
	ld de, wIMEPinyin
.trynext
	ld a, [de]
	cp a, "@"
	jr z, .succeed
	cp a, [hl]
	jr c, .failed
	jr nz, .miss
	inc hl
	inc de
	jr .trynext
.failed
	ld bc, $0000
.succeed
	pop hl
	ret


GetPinyinEntry:
	ld hl, CharTBEntry
rept 4
	add hl, bc
endr
	ld a, [hli]
	ld [wIMEMaxLine], a
	ld a, [hli]
	ld [wIMEBank], a
	ld a, [hli]
	ld [wIMEAddr], a
	ld a, [hl]
	ld [wIMEAddr + 1], a
	ret

PrintIMELines::
    ; call SetupDFSNomanagementIME
	ld a, [hBGMapMode]
	push af
	xor a
	ld [hBGMapMode], a
	hlcoord 3, 11
	lb bc, 4, 16
	call ClearBox
	ld a, [wIMELine]
	hlcoord 3, 12
	call PrintIMELine_u108
    
    ld a, $20
    lb bc, 2, 16
    hlcoord 3, 11
    call DFSStaticize


	ld a, [wIMELine]
	inc a
	hlcoord 3, 14
	call PrintIMELine_u109

    ld a, $40
    lb bc, 2, 16
    hlcoord 3, 13
    call DFSStaticize

	pop af
	ld [hBGMapMode], a
    ; call DisableDFSNoManagement
	ret

; rept 2
PrintIMELine_u108:

	; push af

	; pop af

	ld c, a
	ld a, [wIMEMaxLine]
	cp c
	ret z
	ret c
	push hl
	swap c
	ld a, c
	and a, $0F
	ld b, a
	ld a, c
	and a ,$F0
	ld c, a
	ld a, [wIMEAddr]
	ld l, a
	ld a, [wIMEAddr + 1]
	ld h, a
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, "@"
	ld [wDFSCode + 2], a
	ld b, 8
.loop
	push bc
	push hl
	ld h, d
	ld l, e
	ld a, [wIMEBank]
	call GetFarWord
	ld a, l
	cp a, "@"
	jr z, .end
	ld [wDFSCode], a
	ld a, h
	ld [wDFSCode + 1], a
	pop hl
	push hl
	push de

	push bc
	push hl
	push de
	ld de, wDFSCode
	ld hl, sIMELine_u108
	dec b
	ld a, b
	cpl
	and a, %00000111
	add a
	ld b, 0
	ld c, a
	add hl, bc

	ld a, BANK(sIMELine_u108)
	call OpenSRAM

	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	call CloseSRAM

	pop de
	pop hl
	pop bc

	call PlaceDFSChar
	pop de
	pop hl
	inc hl
	inc hl
	inc de
	inc de
	pop bc
	dec b
	jr nz, .loop
	ret
.end
	pop hl
	pop bc
	ret
	
; endr

PrintIMELine_u109:

	; push af

	; pop af

	ld c, a
	ld a, [wIMEMaxLine]
	cp c
	ret z
	ret c
	push hl
	swap c
	ld a, c
	and a, $0F
	ld b, a
	ld a, c
	and a ,$F0
	ld c, a
	ld a, [wIMEAddr]
	ld l, a
	ld a, [wIMEAddr + 1]
	ld h, a
	add hl, bc
	ld d, h
	ld e, l
	pop hl
	ld a, "@"
	ld [wDFSCode + 2], a
	ld b, 8
.loop
	push bc
	push hl
	ld h, d
	ld l, e
	ld a, [wIMEBank]
	call GetFarWord
	ld a, l
	cp a, "@"
	jr z, .end
	ld [wDFSCode], a
	ld a, h
	ld [wDFSCode + 1], a
	pop hl
	push hl
	push de

	push bc
	push hl
	push de
	ld de, wDFSCode
	ld hl, sIMELine_u109
	dec b
	ld a, b
	cpl
	and a, %00000111
	add a
	ld b, 0
	ld c, a
	add hl, bc

	ld a, BANK(sIMELine_u109)
	call OpenSRAM

	ld a, [de]
	ld [hli], a
	inc de
	ld a, [de]
	ld [hl], a
	call CloseSRAM

	pop de
	pop hl
	pop bc

	call PlaceDFSChar
	pop de
	pop hl
	inc hl
	inc hl
	inc de
	inc de
	pop bc
	dec b
	jr nz, .loop
	ret
.end
	pop hl
	pop bc
	ret

SixUnderLine:
	db $F2, $F2, $F2, $F2, $F2, $F2, $50

INCLUDE "dfs/ime/ime_entry.asm"
