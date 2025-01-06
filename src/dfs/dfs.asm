; LoadScreenTilesFromBuffer2_Origin::
; 	call LoadScreenTilesFromBuffer2DisableBGTransfer_Origin
; 	ld a, 1
; 	ld [hAutoBGTransferEnabled], a
; 	ret

; LoadScreenTilesFromBuffer2DisableBGTransfer_Origin::
; 	xor a
; 	ld [hAutoBGTransferEnabled], a
; 	ld hl, wTilemapBackup2
; 	coord de, 0, 0
; 	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
; 	jp CopyData

; SaveScreenTilesToBuffer1_Origin::
; 	hlcoord 0, 0
; 	ld de, wTilemapBackup
; 	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
; 	jp CopyData

; LoadScreenTilesFromBuffer1_Origin::
; 	xor a
; 	ld [hAutoBGTransferEnabled], a
; 	ld hl, wTilemapBackup
; 	coord de, 0, 0
; 	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
; 	call CopyData
; 	ld a, 1
; 	ld [hAutoBGTransferEnabled], a
; 	ret

; _SaveScreenTilesToBuffer2::
; 	ld a, SRAM_ENABLE
; 	ld [MBC3SRamEnable], a
; 	xor a
; 	ld [MBC3SRamBank], a
; 	ld hl, sDFSCache
; 	ld de, sDFSCacheTileMapBackup2
; 	ld bc, $36 * 4
; 	call CopyData
; 	xor a
; 	ld [MBC3SRamEnable], a
; 	hlcoord 0, 0
; 	ld de, wTilemapBackup2
; 	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
; 	jp CopyData

; _LoadScreenTilesFromBuffer2DisableBGTransfer::
; 	xor a
; 	ld [hAutoBGTransferEnabled], a
; 	ld a, SRAM_ENABLE
; 	ld [MBC3SRamEnable], a
; 	xor a
; 	ld [MBC3SRamBank], a
; 	; call dfsClearCacheLite
; 	hlcoord 0, 0
; 	ld de, wTilemapBackup2
; 	ld b, SCREEN_HEIGHT
; .loop1
; 	ld c, SCREEN_WIDTH
; .loop2
; 	ld a, [de]
; 	cp a, $EC
; 	jr nc, .normal
; 	cp a, $80
; 	jr c, .normal
; 	push bc
; 	push de
; 	push hl
; 	ld b, a
; 	and $7E
; 	ld d, 0
; 	ld e, a
; 	ld hl, sDFSCacheTileMapBackup2
; 	add hl, de
; 	add hl, de
; 	ld a, [hli]
; 	and a
; 	jr z, .eng
; 	ld b, a
; 	ld a, [hli]
; 	ld c, a
; 	ld a, [hli]
; 	ld d, a
; 	ld e, [hl]
; 	pop hl
; 	push hl
; 	call DoubleCodeMain
; 	pop hl
; 	pop de
; 	ld b, a
; 	ld a, [de]
; 	and $81
; 	or b
; 	jr .double_end
; .eng
; 	inc hl
; 	bit 0, b
; 	jr z, .engisc1
; 	inc hl
; 	inc hl
; .engisc1
; 	ld a, [hl]
; 	pop hl
; 	push hl
; 	call SingleCodeMain
; 	or $80
; 	pop hl
; 	pop de
; .double_end
; 	pop bc
; .normal
; 	ld [hli], a
; 	inc de
; 	dec c
; 	jr nz, .loop2
; 	dec b
; 	jr nz, .loop1
; 	xor a
; 	ld [MBC3SRamEnable], a
; 	ret

; _SaveScreenTilesToBuffer1::
; 	ld a, SRAM_ENABLE
; 	ld [MBC3SRamEnable], a
; 	xor a
; 	ld [MBC3SRamBank], a
; 	ld hl, sDFSCache
; 	ld de, sDFSCacheTileMapBackup
; 	ld bc, $36 * 4
; 	call CopyData
; 	xor a
; 	ld [MBC3SRamEnable], a
; 	hlcoord 0, 0
; 	ld de, wTilemapBackup
; 	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT
; 	jp CopyData

; _LoadScreenTilesFromBuffer1::
; 	xor a
; 	ld [hAutoBGTransferEnabled], a
; 	ld a, SRAM_ENABLE
; 	ld [MBC3SRamEnable], a
; 	xor a
; 	ld [MBC3SRamBank], a
; 	; call dfsClearCacheLite
; 	hlcoord 0, 0
; 	ld de, wTilemapBackup
; 	ld b, SCREEN_HEIGHT
; .loop1
; 	ld c, SCREEN_WIDTH
; .loop2
; 	ld a, [de]
; 	cp a, $EC
; 	jr nc, .normal
; 	cp a, $80
; 	jr c, .normal
; 	push bc
; 	push de
; 	push hl
; 	ld b, a
; 	and $7E
; 	ld d, 0
; 	ld e, a
; 	ld hl, sDFSCacheTileMapBackup
; 	add hl, de
; 	add hl, de
; 	ld a, [hli]
; 	and a
; 	jr z, .eng
; 	ld b, a
; 	ld a, [hli]
; 	ld c, a
; 	ld a, [hli]
; 	ld d, a
; 	ld e, [hl]
; 	pop hl
; 	push hl
; 	call DoubleCodeMain
; 	pop hl
; 	pop de
; 	ld b, a
; 	ld a, [de]
; 	and $81
; 	or b
; 	jr .double_end
; .eng
; 	inc hl
; 	bit 0, b
; 	jr z, .engisc1
; 	inc hl
; 	inc hl
; .engisc1
; 	ld a, [hl]
; 	pop hl
; 	push hl
; 	call SingleCodeMain
; 	pop hl
; 	pop de
; .double_end
; 	pop bc
; .normal
; 	ld [hli], a
; 	inc de
; 	dec c
; 	jr nz, .loop2
; 	dec b
; 	jr nz, .loop1
; 	xor a
; 	ld [MBC3SRamEnable], a
; 	inc a; ld a, 1
; 	ld [hAutoBGTransferEnabled], a
; 	ret

dfsClearCache::
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	xor a
	ld [MBC3SRamBank], a
	ld [wDFSCombineCode], a
	ld a, $FF
	ld [sDFSFreeEng], a
	ld hl, sDFSUsed
	ld b, $36
.loop1
	res 0, [hl]
	inc hl
	dec b
	jr nz, .loop1
	ld hl, sDFSCache
	ld b, $36
	ld de, 0004
	ld a, $FF
.loop2
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop2
	xor a
	ld [MBC3SRamEnable], a
	ret

_dfsUnion::
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	xor a
	ld [MBC3SRamBank], a
	

	ld a, [wDFSNoManagementEnabled]
	and a
	jr z, .usingManagement
	call dfsUnion_NoManagement
	xor a
	ld [MBC3SRamEnable], a
	ret
.usingManagement
	push de
	push hl
	ld b, h
	ld c, l

	ld hl, wDFSCode
	ld a, [hli]
	cp a, $EC
	jr nc, StaticSingleCode
	cp a, $80
	jr nc, SingleCode
	cp a, $2F
	jr nc, StaticSingleCode
	; ld a, [wDFSStack]
	; cp 2
	; jr c, .not_combine
	ld a, [wDFSCombineCode]
	and a
	jr z, .not_combine
	ld a, [sDFSCombineAddr]
	cp c
	jr nz, .not_combine
	ld a, [sDFSCombineAddr + 1]
	cp b
	jp z, CombineDoubleCode
.not_combine
	inc hl
	ld a, [hl]
	and a
	jr z, DoubleCode
	cp a, $14
	jp c, QuadrupleCode
	cp a, $2F
	jr nc, DoubleCode
	bit 3, a
	jp nz, QuadrupleCode
	jr DoubleCode
	
StaticSingleCode:
	pop hl
	; ld bc, wAttrmap - wTilemap
	; add hl, bc
	; res 3, [hl]
	; ld bc, wTilemap - wAttrmap
	; add hl, bc
	ld [hli], a
	call PrintLetterDelay
	pop de
	xor a
	ld [wDFSCombineCode], a
	ld [MBC3SRamEnable], a
	ret
	
SingleCode:
	call SingleCodeMain
	pop hl
	call SingleCodeDrawMap
	call PrintLetterDelay
	pop de
	xor a
	ld [wDFSCombineCode], a
	ld [MBC3SRamEnable], a
	ret

; SingleCode_TempTileMap:
; 	push hl
; 	call SingleCodeMain
; 	pop hl
; 	call SingleCodeDrawMap
; 	ret
	
DoubleCode:
	ld hl, wDFSCode
	ld a, [hli]
	ld b, a
	ld d, a
	set 6, d
	ld c, [hl]
	ld e, c
	call DoubleCodeMain
	pop hl
	call DoubleCodeDrawMap
	call PrintLetterDelay
	push hl
	ld hl, wDFSCode
	ld a, [hli]
	ld b, a
	set 7, b
	ld c, [hl]
	ld de, $0000
	call DoubleCodeMain
	pop hl
	call DoubleCodeDrawMap
	call PrintLetterDelay
	pop de
	inc de
	; ld a, [wDFSStack]
	; cp 2
	; jr c, .not_combine
	ld a, [wDFSCode]
	ld [wDFSCombineCode], a
	ld a, [wDFSCode + 1]
	ld [wDFSCombineCode + 1], a
	ld a, l
	ld [sDFSCombineAddr], a
	ld a, h
	ld [sDFSCombineAddr + 1], a
.not_combine
	xor a
	ld [MBC3SRamEnable], a
	ret
; DoubleCode_TempTileMap:
; 	push hl
; 	call DoubleCodeMain
; 	pop hl
; 	jp DoubleCodeDrawMap_TempTileMap

CombineDoubleCode:
	ld hl, wDFSCombineCode
	ld a, [hli]
	ld b, a
	set 7, b
	ld c, [hl]
	ld hl, wDFSCode
	ld a, [hli]
	ld d, a
	ld e, [hl]
	call DoubleCodeMain
	pop hl
	dec hl
	call DoubleCodeDrawMap
	call PrintLetterDelay
	push hl
	ld hl, wDFSCode
	ld a, [hli]
	ld b, a
	ld d, a
	set 6, b
	set 7, d
	ld c, [hl]
	ld e, c
	call DoubleCodeMain
	pop hl
	call DoubleCodeDrawMap
	call PrintLetterDelay
	pop de
	inc de
	xor a
	ld [wDFSCombineCode], a
	ld [MBC3SRamEnable], a
	ret

QuadrupleCode:
	ld hl, wDFSCode
	ld a, [hli]
	ld b, a
	ld d, a
	set 6, d
	ld c, [hl]
	ld e, c
	call DoubleCodeMain
	pop hl
	call DoubleCodeDrawMap
	call PrintLetterDelay
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
	call DoubleCodeMain
	pop hl
	call DoubleCodeDrawMap
	call PrintLetterDelay
	push hl
	ld hl, wDFSCode + 2
	ld a, [hli]
	ld b, a
	ld d, a
	set 6, b
	set 7, d
	ld c, [hl]
	ld e, c
	call DoubleCodeMain
	pop hl
	call DoubleCodeDrawMap
	call PrintLetterDelay
	pop de
	inc de
	inc de
	inc de
	xor a
	ld [wDFSCombineCode], a
	ld [MBC3SRamEnable], a
	ret

SingleCodeMain:
	ld b, a
	call Find8FontCacheEng
	ret nc
	call FindFree8FontCacheEng
	jr nc, .hitfree
	call RecoverFree8FontCache
	call FindFree8FontCacheEng
.hitfree
	push af
	call Send8FontToSramEng
	pop af
	push af
	call GetVramAddr
	; ld b, $10
	; call SendSram8FontToVram
	call SendSram8FontToVram10b
	pop af
	ret
DoubleCodeMain:
	call Find8FontCache
	ret nc
	call FindFree8FontCache
	jr nc, .hitfree
	call RecoverFree8FontCache
	call FindFree8FontCache
.hitfree
	; add a, $10
	push af
	call Send8FontToSram
	pop af
	push af
	call GetVramAddr
	; ld b, $20
	; call SendSram8FontToVram
	call SendSram8FontToVram20b
	pop af
	ret

Find8FontCache:
; 	ld a, [wDFSV0Only]
; 	and %00000011
; 	jr z, .normal
; 	dec a
; 	jr z, .v0only
; 	ld hl, sDFSCache
; 	ld a, $40
; 	jr .loop
; .v0only
; 	ld hl, sDFSCache + $40 * 4
; 	ld a, $36 - $40
; 	jr .loop
.normal
	ld hl, sDFSCache
	ld a, $36
.loop
	push af
	ld a, [hli]
	cp b
	jr nz, .next1
	ld a, [hli]
	cp c
	jr nz, .next2
	ld a, [hli]
	cp d
	jr nz, .next3
	ld a, [hl]
	cp e
	jr nz, .next3
	pop hl
	ld a, $36
	sub h
	ld l, a
	; call DFSCache2DFSUsed
	; srl h
	; ccf
	; rr l
	; srl l
	ld h, HIGH(sDFSUsed)
	set 0, [hl]
	ld a, l
	rlca
	ret
.next1
	inc hl
.next2
	inc hl
.next3
	inc hl
	pop af
	dec a
	jr nz, .loop
	scf
	ret
Find8FontCacheEng:
; 	ld a, [wDFSV0Only]
; 	and %00000011
; 	jr z, .normal
; 	dec a
; 	jr z, .v0only
; 	ld hl, sDFSCache
; 	ld c, $40
; 	jr .loop
; .v0only
; 	ld hl, sDFSCache + $40 * 4
; 	ld c, $36 - $40
; 	jr .loop
; .normal
	ld hl, sDFSCache
	ld c, $36
.loop
	ld a, [hli]
	and a
	jr nz, .next1
	ld a, [hli]
	cp b
	jr z, .target
	ld a, [hli]
	and a
	jr nz, .next3
	ld a, [hl]
	cp b
	jr nz, .next3
.target
	; call DFSCache2DFSUsed
	srl h
	
	; CHS_Fix for Displaying English
	ASSERT HIGH(sDFSCache) & 1 == 0, "Error HIGH(sDFSCache) & 1 != 0"
	; if Error HIGH(sDFSCache) & 1 != 0, uncomment line below
	; ccf

	rr l
	push af
	srl l
	ld h, HIGH(sDFSUsed)
	set 0, [hl]
	sla l
	pop af
	ld a, 0
	adc a, l
	and a
	ret
.next1
	inc hl
	inc hl
.next3
	inc hl
	dec c
	jr nz, .loop
	scf
	ret
	
FindFree8FontCache:
; 	ld a, [wDFSV0Only]
; 	and %00000011
; 	jr z, .normal
; 	dec a
; 	jr z, .v0only
; 	ld hl, sDFSUsed
; 	ld a, $40
; 	jr .loop
; .v0only
; 	ld hl, sDFSUsed + $40
; 	ld a, $36 - $40
; 	jr .loop
; .normal
	ld hl, sDFSUsed
	ld a, $36
.loop
	bit 0, [hl]
	jr nz, .notfound
	set 0, [hl]
	push hl
	; call DFSUsed2DFSCache
	xor a
	sla l
	rla
	sla l
	rla
	add a, HIGH(sDFSCache)
	ld h, a
	ld a, b
	ld [hli], a
	ld a, c
	ld [hli], a
	ld a, d
	ld [hli], a
	ld [hl], e
	pop hl
	ld a, l
	rlca
	ret
.notfound
	inc hl
	dec a
	jr nz, .loop
	scf
	ret
FindFree8FontCacheEng:
	; ld a, [wDFSV0Only]
	; and %00000011
	; ld l, a
	ld a, [sDFSFreeEng]
; 	jr z, .full
; 	dec l
; 	jr z, .v0only0
; 	cp a, $80
; 	jr c, .full
; 	ld a, $FF
; 	ld [sDFSFreeEng], a
; 	jr .full
; .v0only0
; 	cp a, $80
; 	jr nc, .full
; 	ld a, $FF
; 	ld [sDFSFreeEng], a
; .full
	inc a
	jr z, .regular
	push af
	; call DFSUsed2DFSCache
	ld l, a
	xor a
	sla l
	rla
	add a, HIGH(sDFSCache)
	ld h, a
	xor a
	ld [hli], a
	ld [hl], b
	ld hl, sDFSFreeEng
	ld [hl], $FF
	pop af
	and a
	ret
.regular
; 	ld a, [wDFSV0Only]
; 	and %00000011
; 	jr z, .normal
; 	dec a
; 	jr z, .v0only
; 	ld hl, sDFSUsed
; 	ld a, $40
; 	jr .loop
; .v0only
; 	ld hl, sDFSUsed + $40
; 	ld a, $36 - $40
; 	jr .loop
; .normal
	ld hl, sDFSUsed
	ld a, $36
.loop
	bit 0, [hl]
	jr nz, .notfound
	set 0, [hl]
	push hl
	; call DFSUsed2DFSCache
	xor a
	sla l
	rla
	sla l
	rla
	add a, HIGH(sDFSCache)
	ld h, a
	xor a
	ld [hli], a
	ld a, b
	ld [hli], a
	ld [hl], $FF
	pop hl
	sla l
	xor a
	ld a, l
	ld [sDFSFreeEng], a
	ret
.notfound
	inc hl
	dec a
	jr nz, .loop
	scf
	ret
	
RecoverFree8FontCache:
	push bc
	push de
	ld c, $36
	ld hl, sDFSUsed
.loop1
	res 0, [hl]
	inc hl
	dec c
	jr nz, .loop1

	ld bc, SCREEN_WIDTH * SCREEN_HEIGHT + $0100
	ld de, wTilemap
	; ld hl, wAttrmap
.loop2
	ld a, [de]
	bit 7, a
	jr z, .next
.font
	and a, $7E
	rrca
; 	bit 3, [hl]
; 	jr nz, .setfree
; .vram0
; 	set 6, a
; .setfree
	; push hl
	ld h, HIGH(sDFSUsed)
	ld l, a
	set 0, [hl]
	; pop hl
.next
	; inc hl
	inc de
	dec c
	jr nz, .loop2
	dec b
	jr nz, .loop2
	ld a, [sDFSFreeEng]
	inc a
	jr z, .alreadyfree
	srl a
	ld h, HIGH(sDFSUsed)
	ld l, a
	bit 0, [hl]
	jr nz, .alreadyfree
	ld a, $FF
	ld [sDFSFreeEng], a
.alreadyfree
	pop de
	pop bc
	ret
	
Send8FontToSram:
	push de
	call Send4RawFontToSRAM
	call Send4RawFontTo8FontLeft
	pop bc
	ld a, b
	or c
	jr z, .skip
	ret z
	call Send4RawFontToSRAM
	call Send4RawFontTo8FontRight
.skip
	jp SetFontStyle
	ret

;b  > TlieNo
Send8FontToSramEng:
	ld h, 0
	ld l, b
	res 7, l
rept 3
	add hl, hl
endr
	ld bc, Font
	add hl, bc
	ld a, BANK(Font)
	ld bc, 8
	ld de, sDFS8Font
	call FarCopyDataDouble
	jp SetFontStyle
	ret

Send4RawFontToSRAM:
	ld a, b
	push af
	and a, $3F
	sla c
	rla
	ld b, 0
	ld d, b
	ld e, a
	ld hl, FontAB
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
	ld c, 6
	cp a, $40
	jr c, .c1
	cp a, $80
	jr c, .c2
	add hl, bc
.c2
	add hl, bc
.c1
	ld a, d
	ld de, sDFSRaw4Font
	jp FarCopyData2

MACRO fontab
rept _NARG
	dwb DFS_C_\1_L, BANK(DFS_C_\1_L)
	dwb DFS_C_\1_H, BANK(DFS_C_\1_H)
	shift
endr
ENDM

FontAB:
	fontab FF, 01, 02, 03, 04, 05, 06, 07, 08, 09, 0A, 0B, 0C, 0D, 0E, 0F
	fontab 10, 11, 12, 13, FF, FF, FF, FF, 18, 19, 1A, 1B, 1C, 1D, 1E, 1F
	fontab FF, FF, FF, FF, FF, FF, FF, FF, 28, 29, 2A, 2B, 2C, 2D, 2E, FF

Send4RawFontTo8FontLeft:
	ld hl, sDFS8Font
	ld de, sDFSRaw4Font
	ld b, 8
	xor a
.loop1
	ld [hli], a
	dec b
	jr nz, .loop1
	ld b, 6
.loop2
	ld a, [de]
	and $F0
	ld [hli], a
	ld [hli], a
	ld a, [de]
	swap a
	and $F0
	ld [hli], a
	ld [hli], a
	inc de
	dec b
	jr nz, .loop2
	ret
	
Send4RawFontTo8FontRight:
	ld hl, sDFS8Font + 8
	ld de, sDFSRaw4Font
	ld b, 6
.loop
	ld a, [de]
	swap a
	and $0F
	or [hl]
	ld [hli], a
	ld [hli], a
	ld a, [de]
	and $0F
	or [hl]
	ld [hli], a
	ld [hli], a
	inc de
	dec b
	jr nz, .loop
	ret
	
SetFontStyle:
	ld a, [wDFSFontSytle]
	and a ; 0
	ret z
	ld hl, sDFS8Font
	dec a ; 1
	jr nz, .OverworldSytle8Font
.DexStyle8Font
	ld b, $20
.dexloop
	ld a, [hl]
	cpl
	ld [hli], a
	dec b
	jr nz, .dexloop
	ret
.OverworldSytle8Font
	ld b, $10
	ld a, $FF
.owloop
	ld [hli], a
	inc hl
	dec b
	jr nz, .owloop
	ret
	
;a  > CacheNo
;hl < Tile Addr
GetVramAddr:
	swap a
	ld e, a
	and a, $0F
	ld d, a
	ld a, e
	and a, $F0
	ld e, a
	ld hl, $8800
	add hl, de
	ret

; hl > Tile Addr
; b > Bytes
SendSram8FontToVram:
	; ld hl, rSTAT
	ld de, sDFS8Font
	ld c, LOW(rSTAT)
	di ; 中断
.loop
	; ldh a, [rLY]
	; cp a, $8c
	; jr nc, .loop
	ldh a, [c]
	and $2
	jr nz, .loop
	ld a, [de]
	ld [hli], a
	inc de
	dec b
	jr nz, .loop

	; ld a, [wIfCurrentlyRestoringWindow]
	; and a
	; ret nz
	; ldh a, [rIF]
	; and a, $FC 
	; ldh [rIF], a
	reti ; 中断
	

; hl > Tile Addr
; b > Bytes
SendSram8FontToVram10b:
	ld de, sDFS8Font
	ld c, LOW(rSTAT) ;判断
	di ; 中断
rept $10
.loop\@
	ld a, [c]
	and $2
	jr nz, .loop\@
	ld a, [de]
	ld [hli], a
	inc de
endr
	; ld a, [wIfCurrentlyRestoringWindow]
	; and a
	; ret nz
	; ldh a, [rIF]
	; and a, $FC 
	; ldh [rIF], a
	reti ; 中断
	

; hl > Tile Addr
; b > Bytes
SendSram8FontToVram20b:
	ld de, sDFS8Font
	ld c, LOW(rSTAT)
	di ; 中断
rept $20
.loop\@
	ldh a, [c]
	and $2
	jr nz, .loop\@
	ld a, [de]
	ld [hli], a
	inc de
endr
	; ld a, [wIfCurrentlyRestoringWindow]
	; and a
	; ret nz
	; ldh a, [rIF]
	; and a, $FC 
	; ldh [rIF], a
	reti ; 中断
	

	




	
; ;hl > Tile Addr
; ;b  > Vram Bank
; ;c  > Tile - 1
; SendWram8FontToVram:
; 	ld a, HIGH(sDFS8Font)
; 	ld [rHDMA1], a
; 	ld a, LOW(sDFS8Font)
; 	ld [rHDMA2], a
; 	ld a, h
; 	ld [rHDMA3], a
; 	ld a, l
; 	ld [rHDMA4], a
; 	ld a, [rLCDC]
; 	bit 7, a
; 	jr nz, .wait1
; 	di
; 	ld a, b
; 	ld [rVBK], a
; 	ld a, c
; 	ld [rHDMA5], a
; 	xor a
; 	ld [rVBK], a
; 	reti
; .wait1
; 	ld a, [rLY]
; 	cp a, $8c
; 	jr nc, .wait1
; 	di
; 	ld a, b
; 	ld [rVBK], a
; 	set 7, c
; .wait2
; 	ld a, [rSTAT]
; 	and a, 3
; 	jr nz, .wait2
; .wait3
; 	ld a, [rSTAT]
; 	and a, 3
; 	jr z, .wait3
; 	ld a, c
; 	ld [rHDMA5], a
; .wait4
; 	ld a, [rHDMA5]
; 	cp a, $FF
; 	jr nz, .wait4
; 	xor a
; 	ld [rVBK], a
; 	reti
	
SingleCodeDrawMap:
; 	push af
; 	ld a, [wDFSV0Only]
; 	ld b, a
; 	pop af
; 	bit 2, b
; 	jr nz, .skipAttr
; 	ld bc, wAttrmap - wTilemap
; 	add hl, bc
; 	bit 7, a
; 	jr z, .isv1
; 	res 3, [hl]
; 	jr .setTile
; .isv1
; 	set 3, [hl]
; 	set 7, a
; .setTile
; 	ld bc, wTilemap - wAttrmap
; 	add hl, bc
; 	ld [hli], a
; 	ret
; .skipAttr
	set 7, a
	ld [hli], a
	ret
; SingleCodeDrawMap_Restore:
; 	ld bc, wAttrmap - wTilemap
; 	add hl, bc
; 	bit 7, a
; 	jr z, .isv1
; 	ld [hl], $07
; 	jr .setTile
; .isv1
; 	ld [hl], $0F
; 	set 7, a
; .setTile
; 	ld bc, wTilemap - wAttrmap
; 	add hl, bc
	; ld [hli], a
	; ret

DoubleCodeDrawMap:
; 	push af
; 	ld a, [wDFSV0Only]
; 	ld b, a
; 	pop af
; 	bit 2, b
; 	jr nz, .skipAttr
; 	ld bc, wAttrmap - wTilemap - SCREEN_WIDTH
; 	add hl, bc
; 	bit 7, a
; 	jr z, .isv1
; 	res 3, [hl]
; 	ld bc, SCREEN_WIDTH
; 	add hl, bc
; 	res 3, [hl]
; 	jr .setTile
; .isv1
; 	set 3, [hl]
; 	ld bc, SCREEN_WIDTH
; 	add hl, bc
; 	set 3, [hl]
; 	set 7, a
; .setTile
; 	ld bc, wTilemap - wAttrmap - SCREEN_WIDTH
; 	add hl, bc
; 	ld [hl], a
; 	inc a
; 	ld bc, SCREEN_WIDTH
; 	add hl, bc
; 	ld [hli], a
; 	ret
; .skipAttr
	set 7, a
	ld bc, -SCREEN_WIDTH
	add hl, bc
	ld [hl], a
	inc a
	ld bc, SCREEN_WIDTH
	add hl, bc
	ld [hli], a
	ret
; DoubleCodeDrawMap_Restore:
; 	ld bc, wAttrmap - wTilemap
; 	add hl, bc
; 	bit 7, a
; 	jr z, .isv1
; 	ld [hl], $07
; 	jr .setTile
; .isv1
; 	ld [hl], $0F
; 	set 7, a
; .setTile
; 	ld bc, wTilemap - wAttrmap
; 	add hl, bc
; 	ld [hl], a
; 	ld a, [wDFSCode + 2]
; 	bit 7, a
; 	jr z, .isc0
; 	inc [hl]
; .isc0
; 	inc hl
; 	ret
; DoubleCodeDrawMap_TempTileMap:
; 	ld bc, wAttrmap - wTilemap
; 	add hl, bc
; 	bit 7, a
; 	jr z, .isv1
; 	res 3, [hl]
; 	jr .setTile
; .isv1
; 	set 3, [hl]
; 	set 7, a
; .setTile
; 	ld bc, wTilemap - wAttrmap
; 	add hl, bc
; 	ld [hl], a
; 	ld a, [wDFSCode + 2]
; 	bit 7, a
; 	jr z, .isc0
; 	inc [hl]
; .isc0
; 	inc hl
; 	ret



MACRO dfs_alphabet_param
	ld hl, sDFSCache + ((\1 - $80) / 2) * 4
	ld de, sDFSUsed  + ((\1 - $80) / 2)
	lb bc, \1, (\2 / 2)
ENDM

DFSSetAlphabetCache:
	ld a, SRAM_ENABLE
	ld [MBC3SRamEnable], a
	xor a
	ld [MBC3SRamBank], a

	dfs_alphabet_param $80, $40 ;$40
	call .loop_used

	; dfs_alphabet_param $E0, 12
	; call .loop_used

	xor a
	ld [MBC3SRamEnable], a
	ret

.loop_used
	xor a
	ld [hli], a
	ld [hl], b
	inc hl
	inc b
	ld [hli], a
	ld [hl], b
	inc hl
	inc b
	inc a
	ld [de], a
	inc de
	dec c
	jr nz, .loop_used
	ret
	
; Gen2:
; >b : length (half tile)
; >c : start at left / right
; >de: straddr
; <de: straddr (same as input)
; <hl: new straddr end
; <[straddr] : fix legnth
; Gen1:
; >c bit0-6 : length (half tile)
; >c bit7   : start at left / right
; >de: straddr
; <de: straddr (same as input)
; <hl: new straddr end
; <[straddr] : fix legnth
; FixStrLength_Gen1::
; 	ld a, [wDummy]
; 	ld c, a
; 	and $7F
; 	ld b, a
; 	rlc c

; 	inc b
; 	ld h, d
; 	ld l, e
; .checkchar
; ; end of nick?
; 	ld a, [hli]
; 	cp "@" ; terminator
; 	ret z
; 	and a
; 	jr z, .singlechar
; 	cp $14
; 	jr c, .doublechar
; 	cp $2F
; 	jr nc, .singlechar
; 	bit 3, a
; 	jr nz, .doublechar
	
; .singlechar
; 	bit 0, c
; 	jr z, .newsingle
; 	inc c
; 	dec b
; 	jr z, .done
; .newsingle
; rept 2
; 	dec b
; 	jr z, .done
; endr
; 	jr .checkchar
	
; .doublechar
; 	inc c
; rept 3
; 	dec b
; 	jr z, .done
; endr
; 	inc hl
; 	jr .checkchar
; .done
; 	dec hl
; 	ld [hl], "@"
; 	ret

; Gen2:
; >de: straddr
; <b : length (tile)
; <c : last tile is half tile
; <de: straddr (same as input)
; <hl: new straddr end + 1
; Gen1:
; >de: straddr
; <d : length (tile)
; <e : last tile is half tile
; <hl: new straddr end + 1
; GetStrLength_Gen1::
; 	ld h, d
; 	ld l, e
; 	ld de, 0
; .checkchar
; ; end of nick?
; 	ld a, [hli]
; 	cp "@" ; terminator
; 	jr z, .done
; 	and a
; 	jr z, .singlechar
; 	cp $14
; 	jr c, .doublechar
; 	cp $2F
; 	jr nc, .singlechar
; 	bit 3, a
; 	jr nz, .doublechar
	
; .singlechar
; 	bit 0, d
; 	jr z, .newsingle
; 	jr .leftsingle
; .doublechar
; 	inc hl
; .leftsingle
; 	inc d
; .newsingle
; 	inc d
; 	inc d
; 	jr .checkchar

; .done
; 	srl d
; 	ret nc
; 	rr e
; 	inc d
; 	ret


DEF DFS_CODE_NULL               EQU $00
DEF DFS_CODE_DOUBLE_0           EQU $01
DEF DFS_CODE_CONTRL_0           EQU $14
DEF DFS_CODE_DOUBLE_1           EQU $18
DEF DFS_CODE_CONTRL_1           EQU $20
DEF DFS_CODE_DOUBLE_2           EQU $28
DEF DFS_CODE_CONTRL_2           EQU $2F
DEF DFS_CODE_SINGLE_STA_0       EQU $60
DEF DFS_CODE_SINGLE_DYN_0       EQU "A" ; $80
DEF DFS_CODE_SINGLE_STA_1       EQU "." ; $e8
DEF DFS_CODE_END                EQU "9" ; $ff

DEF DFS_CODE_DOUBLE_0_END       EQU DFS_CODE_CONTRL_0     - 1
DEF DFS_CODE_CONTRL_0_END       EQU DFS_CODE_DOUBLE_1     - 1
DEF DFS_CODE_DOUBLE_1_END       EQU DFS_CODE_CONTRL_1     - 1
DEF DFS_CODE_CONTRL_1_END       EQU DFS_CODE_DOUBLE_2     - 1
DEF DFS_CODE_DOUBLE_2_END       EQU DFS_CODE_CONTRL_2     - 1
DEF DFS_CODE_CONTRL_2_END       EQU DFS_CODE_SINGLE_STA_0 - 1
DEF DFS_CODE_SINGLE_STA_0_END   EQU DFS_CODE_SINGLE_DYN_0 - 1
DEF DFS_CODE_SINGLE_DYN_0_END   EQU DFS_CODE_SINGLE_STA_1 - 1
DEF DFS_CODE_SINGLE_STA_1_END   EQU DFS_CODE_END

DEF DFS_CODE_L_NULL             EQU $00
DEF DFS_CODE_L_DOUBLE_0         EQU $01
DEF DFS_CODE_L_CONTRL_0         EQU $14
DEF DFS_CODE_L_DOUBLE_1         EQU $17
DEF DFS_CODE_L_CONTRL_1         EQU $22
DEF DFS_CODE_L_DOUBLE_2         EQU $23
DEF DFS_CODE_L_CONTRL_2         EQU $3F
DEF DFS_CODE_L_DOUBLE_3         EQU $40
DEF DFS_CODE_L_CONTRL_3         EQU $4B
DEF DFS_CODE_L_DOUBLE_4         EQU $60
DEF DFS_CODE_L_CONTRL_4         EQU $FD
DEF DFS_CODE_L_END              EQU $FF

DEF DFS_CODE_L_DOUBLE_0_END     EQU DFS_CODE_L_CONTRL_0   - 1
DEF DFS_CODE_L_CONTRL_0_END     EQU DFS_CODE_L_DOUBLE_1   - 1
DEF DFS_CODE_L_DOUBLE_1_END     EQU DFS_CODE_L_CONTRL_1   - 1
DEF DFS_CODE_L_CONTRL_1_END     EQU DFS_CODE_L_DOUBLE_2   - 1
DEF DFS_CODE_L_DOUBLE_2_END     EQU DFS_CODE_L_CONTRL_2   - 1
DEF DFS_CODE_L_CONTRL_2_END     EQU DFS_CODE_L_DOUBLE_3   - 1
DEF DFS_CODE_L_DOUBLE_3_END     EQU DFS_CODE_L_CONTRL_3   - 1
DEF DFS_CODE_L_CONTRL_3_END     EQU DFS_CODE_L_DOUBLE_4   - 1
DEF DFS_CODE_L_DOUBLE_4_END     EQU DFS_CODE_L_CONTRL_4   - 1
DEF DFS_CODE_L_CONTRL_4_END     EQU DFS_CODE_L_END

DEF DFS_TILENO_VRAM0_START EQU DFS_CODE_SINGLE_DYN_0
DEF DFS_TILENO_VRAM0_END   EQU DFS_CODE_SINGLE_DYN_0_END
DEF DFS_TILENO_VRAM1_START EQU DFS_CODE_SINGLE_DYN_0
DEF DFS_TILENO_VRAM1_END   EQU DFS_CODE_SINGLE_STA_1_END

DEF DFS_CACHE_NUM_VRAM0 EQU ( DFS_TILENO_VRAM0_END + 1 - DFS_TILENO_VRAM0_START ) / 2 ; $34
DEF DFS_CACHE_NUM_VRAM1 EQU ( DFS_TILENO_VRAM1_END + 1 - DFS_TILENO_VRAM1_START ) / 2 ; $40
DEF DFS_CACHE_NUM       EQU DFS_CACHE_NUM_VRAM0 + DFS_CACHE_NUM_VRAM1                 ; $74


; DFS 大小，一个汉字由两个字节编码
DEF DFS_CODE_SIZE EQU 2
; DFS 缓存块大小，包含两个汉字编码
DEF DFS_CACHE_SIZE EQU DFS_CODE_SIZE * 2
; 破坏缓存块使用的值
; 汉字块不存在 HHHHHH 为全 1 的场合，英文块使用全 0
DEF DFS_MASK_CLEAR  EQU %11111111
; 汉字高位编码掩模
DEF DFS_MASK_DOUBLE EQU %00111111

STATIC_ASSERT DFS_CACHE_NUM == $74, "Error DFS_CACHE_NUM != $74"



dfsFirstCharRightAlign2::
	dec hl
	dec hl
	ld de, .FullSpaceText
	call PlaceString
	ld [hl], " "
	ld bc, -SCREEN_WIDTH
	add hl, bc
	ld [hl], " "
	ret 
.FullSpaceText
	db_w $01,$01,$50
; 字符串首字母右对齐
; b : 英文起始的字符，返回是否右移hl 0: 不移动 1:移动
; c : 字符串首字母，用于判断英文起始
; de: 字符串位置
; hl: 返回最终字符串位置，可能存在偏移
; dfsFirstCharRightAlign::
; 	ld h, d
; 	ld l, e
; 	ld a, c
; 	cp "@" ; terminator
; 	jr z, .singlechar ; .done
; 	and a
; 	jr z, .singlechar
; 	cp DFS_CODE_CONTRL_0
; 	jr c, .doublechar
; 	cp DFS_CODE_CONTRL_2
; 	jr nc, .singlechar
; 	bit 3, a
; 	jr z, .singlechar
; .doublechar
; 	inc hl
; 	getchar_w "　"
; 	ld a, HIGH(CHARMAP_W_CHAR)
; 	ld [wDFSCombineCode], a
; if HIGH(CHARMAP_W_CHAR) != LOW(CHARMAP_W_CHAR)
; 	ld a, LOW(CHARMAP_W_CHAR)
; endc
; 	ld [wDFSCombineCode + 1], a
; 	ldh a, [rSVBK]
; 	ld b, a
; 	ld a, BANK(wDFSCombineAddr)
; 	ldh [rSVBK], a
; 	ld a, l
; 	ld [wDFSCombineAddr], a
; 	ld a, h
; 	ld [wDFSCombineAddr + 1], a
; 	ld a, b
; 	ldh [rSVBK], a
; 	ret

; .singlechar
; 	bit 0, b
; 	ret z
; 	inc hl
; 	ret

_TextScroll::
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY 
	decoord TEXTBOX_INNERX, TEXTBOX_INNERY - 1
	ld bc, TEXTBOX_WIDTH * 3 - 1
	call CopyBytes
	hlcoord TEXTBOX_INNERX, TEXTBOX_INNERY	, wAttrmap
	decoord TEXTBOX_INNERX, TEXTBOX_INNERY - 1, wAttrmap
	ld bc, TEXTBOX_WIDTH * 3 - 1
	call CopyBytes
	hlcoord TEXTBOX_INNERX - 1, TEXTBOX_INNERY + 2
	ld a, "│"
	ld [hli], a
	ld bc, TEXTBOX_INNERW
	ld a, " "
	call ByteFill
	ld [hl], "│"
	hlcoord TEXTBOX_INNERX - 1, TEXTBOX_INNERY + 2, wAttrmap
	ld bc, TEXTBOX_INNERW + 2
	; call ClearVramNo
	ld c, 5
	call DelayFrames
	ret

	const_def
	const DFS_FONT_STYLE_STANDARD
	const DFS_FONT_STYLE_DEX
	const DFS_FONT_STYLE_OVERWORLD
	const DFS_FONT_STYLE_EUROPE

_RestoreTileBackup::
	call MenuBoxCoord2Tile
 
.copy
	call GetMenuBoxDims
	inc b
	inc c

.row
	; push bc
	; xor a
	; ldh [rSVBK], a
	; ei ; 中断
	; nop
	; nop
	; nop
	; ; call DelayFrame
	; ; nop
	; ld a, BANK(wWindowStack)
	; ldh [rSVBK], a
	; di ; 中断
	; pop bc

	push bc
	push hl

.col
	push bc
	ld a, b
	; ldh [hTmpSpace], a
	; ld a, c
	; ldh [hTmpSpace + 1], a

	ld a, BANK(wDFSCodeStack)
	ldh [rSVBK], a

	; ld a, BANK(sDFSCodeStack)
	; call OpenSRAM
	call OpenSDFSCodeStackSRAMOnlyDMG

	
	ld a, [de]
	and a
	jr z, .single
	cp a, DFS_MASK_CLEAR
	jp z, .normal

	dec de



	ldh [hTmpSpace], a
	ld a, BANK(wWindowStack)
	ldh [rSVBK], a

	push de
	push hl

	ld a, BANK(wDFSCodeStack)
	ldh [rSVBK], a
	ldh a, [hTmpSpace]


	ld b, a

	ld h, d
	ld l, e
	ld a, [hli]
	ld d, a

	ld a, BANK(wWindowStack)
	ldh [rSVBK], a
	
	; ld a, BANK(sWindowStack)
	; call OpenSRAM
	call OpenSWindowStackSRAMOnlyDMG

	ld a, [hld]
	ld c, a
	ld e, [hl]
	
	pop hl
	

	ld a, BANK(sDFSCache)
	call OpenSRAM

	xor a
	ldh [rSVBK], a

	ld a, b

	; 恢复右半对应汉字片
	; CCHHHHHH ICHHHHHH -> CCHHHHHH CCHHHHHH
	; 左半00 -> 右半01 / 左半01 -> 右半10 / 左半10 -> 右半00
	; 因此，右半CC的高位 == 左半CC的低位
	sla d ; cy = I
	rla
	rla   ; 左半CC低位 -> cy 同时 a = XXXXXXIX
	rr d  ; cy -> 右半CC高位
	rrca  ; a = XXXXXXXI
	and 1 ; a = 0000000I
	
.calldoublecode
	call DoubleCode_Restore

	ld a, BANK(wWindowStack)
	ldh [rSVBK], a

	pop de
	dec de
	jr .next

.single
	dec de
	ld a, [de]
	ldh [hTmpSpace], a
	; bit 7, a
	
	ld a, BANK(wWindowStack)
	ldh [rSVBK], a

	; ld a, BANK(sWindowStack)
	; call OpenSRAM
	call OpenSWindowStackSRAMOnlyDMG

	ldh a, [hTmpSpace]
	bit 7, a
	ld a, [de]
	jr nz, .single_end
	inc de
	ld a, [de]
	dec de
.single_end
	dec de
	push de
	ld b, a

	ld a, BANK(sDFSCache)
	call OpenSRAM
	xor a
	ldh [rSVBK], a


	ld a, b
	call SingleCode_Restore

	ld a, BANK(wWindowStack)
	ldh [rSVBK], a

	pop de
	jr .next

.normal
	ld a, BANK(wWindowStack)
	ldh [rSVBK], a

	; ld a, BANK(sWindowStack)
	; call OpenSRAM
	call OpenSWindowStackSRAMOnlyDMG

	ld a, [de]
	ld [hl], a
	dec de
	ld bc, wAttrmap - wTilemap
	add hl, bc
	ld a, [de]
	ld [hl], a
	dec de
	ld bc, wTilemap - wAttrmap + 1
	add hl, bc
.next
	pop bc
	dec c
	jp nz, .col

	pop hl
	ld bc, SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jp nz, .row

	ret

SingleCode_Restore:
	push hl
	call SingleCodeMain
	pop hl
	jp SingleCodeDrawMap_Restore

DoubleCode_Restore:
	push af
	push hl
.double
	call DoubleCodeMain
	pop hl
	pop bc
	jp DoubleCodeDrawMap_Restore



DoubleCodeDrawMap_Restore:
	add a, b
SingleCodeDrawMap_Restore:
	ld bc, wAttrmap - wTilemap
	add hl, bc
	; bit 7, a
	; jr z, .isv1
	ld [hl], $07
; 	jr .setTile
; .isv1
; 	ld [hl], $0F
; 	set 7, a
.setTile
	ld bc, wTilemap - wAttrmap
	add hl, bc
	set 7, a
	ld [hli], a
	ret

; ; 菜单恢复时字符画到背景
; ; a : BCCCCCCC 或 BEEEEEEE
; ; b : 0为字符上半 1为字符下半，英文无此参数
; ; hl: 写入wTilemap的位置，结果自增
; ; 破坏 bc
; ; B : 显存所在页，0为显存1，1为显存0
; ; CC/EE: 字符上半Tile号低7位（最高位必定为1）
; DoubleCodeDrawMap_Restore:
; 	add a, b
; SingleCodeDrawMap_Restore:
; 	; 不检测wDFSVramLimit，因为菜单恢复总伴随Attr更新
; 	ld bc, wAttrmap - wTilemap
; 	add hl, bc
; 	bit 7, a
; 	jr z, .is_vram1
; 	ld [hl], PAL_BG_TEXT ; 所有恢复的字符都会被视为是7号调色板
; 	jr .end
; .is_vram1
; 	ld [hl], PAL_BG_TEXT | VRAM_BANK_1
; 	set 7, a
; .end
; 	ld bc, wTilemap - wAttrmap
; 	add hl, bc
; 	ld [hli], a
; 	ret

INCLUDE "dfs/CheckIfMBC30WhenDMG.asm"

INCLUDE "dfs/dfsNomanage.asm"


Menu0Desc:
	INCBIN "gfx/font/Menu0Desc.1bpp"

Menu1Desc:
	INCBIN "gfx/font/Menu1Desc.1bpp"

Menu2Desc:
	INCBIN "gfx/font/Menu2Desc.1bpp"

Menu3Desc:
	INCBIN "gfx/font/Menu3Desc.1bpp"

Menu4Desc:
	INCBIN "gfx/font/Menu4Desc.1bpp"

Menu5Desc:
	INCBIN "gfx/font/Menu5Desc.1bpp"

Menu6Desc:
	INCBIN "gfx/font/Menu6Desc.1bpp"

Menu7Desc:
	INCBIN "gfx/font/Menu7Desc.1bpp"

Menu8Desc:
	INCBIN "gfx/font/Menu8Desc.1bpp"