; ld a, 0
; ld [wDFSNoManagementPrintDelay], a
; ld a, $0
; ld [wDFSNoManagementStartTile], a
; ld a, $7E
; ld [wDFSNoManagementEndTile], a
; ld a, 1
; ld [wDFSNoManagementEnabled], a


; IF DEF(_32KB)
DetectGBModel:
	ld hl, $0149 ; read ROM header
	ld a, [hl]
	cp 5
	jp z, DetectGBModelMBC30

DetectGBModelMBC3:
	ldh a, [hCGB]
	and a
	ret nz

	call DisableLCD
	call ClearTilemap
	ld de, MUSIC_NONE
	call PlayMusic

	ld a, $27
	ldh [rBGP], a

	; if the rom uses 32KB of SRAM, then DMG models are not supported
	ld de, NotCGB
	ld hl, vTiles2
	lb bc, BANK(NotCGB), $80
	call Get1bpp
	
	hlcoord 1,5
	ld de, NotCGBText
	call PlaceStringDirect

	call EnableLCD
	call WaitBGMap
.loop
	call DelayFrame
	jr .loop

NotCGB:
	INCBIN "dfs/NotCGB.1bpp"


NotCGBText:
	db  		$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0A
	nextDirect  $10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1A
	nextDirect	$0c,$0d,$0e,$0f,$20,$21,$22,$23,$24,$25,$26,$27,$7f,$7f,$7f,$2B
	nextDirect 	$1c,$1d,$1e,$1f,$30,$31,$32,$33,$34,$35,$36,$37,$38,$39,$3A,$3B
	nextDirect	$2c,$2d,$2e,$2f,$40,$41,$42,$43,$44,$45,$46,$47,$48
	nextDirect	$3c,$3d,$3e,$3f,$50,$51,$52,$53,$54,$55,$56,$57,$58
	nextDirect  $49,$4a,$4b,$4c,$4d,$7f,$7f,$60,$61,$62,$63,$64,$65,$66,$67,$68
	nextDirect  $59,$5a,$5b,$5c,$5d,$34,$35,$70,$71,$72,$73,$74,$75,$76,$77,$78
	nextDirect  $7f
	nextDirect  $69,$6a,$6b,$6c,$6d,$6e,$28,$29,$2A,$6f,$7a,$7b,$7c
	nextDirect	$10,$11,$7d,$7e,$6f,$7a,$7b,$4e,$10,$11,$12,$5e,$5f,$6f,$7a,$7b
	nextDirect  $7d,$4f,$0b,$7b,$1b,$79
	nextDirect  -1


; NotCGBText:
; 	db_w "GBC专用汉化版"
; 	next "不支持黑白GB和SGB！"
; 	next "使用黑白机游玩时，"
; 	next "请使用GB共通汉化版！@"



; ELSE


DetectGBModelMBC30:
	ldh a, [hCGB]
	and a
	; ret nz
	ld a, 3
	jr nz, .readyToWrite ; jump if cgb
	ld a, 5
.readyToWrite
	push af
.saveLoop
	call OpenSRAM
	ld [$BFFF], a
	dec a
	cp $ff
	jr nz, .saveLoop
	
	pop af
.readLoop
	ld b, a
	call OpenSRAM
	push af
	ld a, [$BFFF]
	cp b
	jr nz, .not_equal ; 分歧点
	pop af
	dec a
	cp $ff
	jr nz, .readLoop
	call CloseSRAM
	ret

.not_equal
	call DisableLCD
	call ClearTilemap
	pop af
	hlcoord 5, 0
	add a, "0"
	ld [hl], a
	call CloseSRAM

	ld de, MUSIC_NONE
	call PlayMusic

	ld a, $27
	ldh [rBGP], a



	ld de, Font
	ld hl, vTiles1
	lb bc, BANK(Font), $80
	call Get1bpp

	hlcoord 2,4
	ld de, FailedCheckingTextDirect
	call PlaceStringDirect

	ldh a, [hCGB]
	and a
	jr nz, .cgb ; jump if cgb

.dmg
	ld de, NotMBC30
	ld hl, vTiles2
	lb bc, BANK(NotMBC30), 104
	call Get1bpp

	hlcoord 2,8
	ld de, FailedCheckingTextDirect2
	call PlaceStringDirect

	jr .finish
.cgb 
	ld de, MBC3ErrorCGB
	ld hl, vTiles2
	lb bc, BANK(MBC3ErrorCGB), 128
	call Get1bpp

	hlcoord 2,9
	ld de, FailedCheckingTextDirect3
	call PlaceStringDirect
.finish
	hlcoord 0,0
	ld de, .bankText
	call PlaceStringDirect
	hlcoord 7,0
	ld de, .errorText
	call PlaceStringDirect
	call EnableLCD
	call WaitBGMap
.loop
	call DelayFrame
	jr .loop
.bankText:
	db_w "BANK", -1
.errorText:
	db_w "ERROR!", -1

; FailedCheckingText:
; 	db_w "没有检测到卡带上"
; 	next "有足够的内存！"
FailedCheckingTextDirect:
	db 			$00,$01,$02,$03,$04,$05,$06,$07,$08,$09,$0a,$0b
	nextDirect	$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$1a,$1b
	nextDirect	$0c,$0d,$0e,$0f,$20,$21,$22,$23,$24,$25
	nextDirect	$1c,$1d,$1e,$1f,$30,$31,$32,$33,$34,$35, -1


; 	next "使用黑白机游玩时，"
; 	next "卡带必须支持"
; 	next "64KB存档！@"
FailedCheckingTextDirect2:
	db  		$26,$27,$28,$29,$2a,$2b,$2c,$2d,$2e,$2f,$40,$41,$42
	nextDirect  $36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$3f,$50,$51,$52
	nextDirect	$43,$44,$45,$46,$47,$48,$49,$4a,$4b
	nextDirect 	$53,$54,$55,$56,$57,$58,$59,$5a,$5b
	nextDirect	$4c,$4d,$4e,$4f,$60,$61,$62,$63
	nextDirect	$5c,$5d,$5e,$5f,$64,$65,$66,$67,  -1

; db_w "如果使用GBC，GBA游玩"
; next "请使用GBC专用汉化版！"
FailedCheckingTextDirect3:
	db  		$26,$27,$28,$29,$2a,$2b,$2c,$2d,$2e,$2f,$40,$41,$42,$43,$44,$45
	nextDirect  $36,$37,$38,$39,$3a,$3b,$3c,$3d,$3e,$3f,$50,$51,$52,$53,$54,$55
	nextDirect	$46,$47,$48,$49,$4a,$7f,$7f,$7f,$60,$61,$62,$63,$64,$65,$66,$4b,$4c
	nextDirect	$56,$57,$58,$59,$5a,$3c,$3d,$3e,$67,$68,$69,$6a,$6b,$6c,$6d,$6e,$6f, 
	nextDirect  $7f
	nextDirect  $70,$71,$72,$73,$74,$75,$76,$77,$78,$79,$7a,$78,$7b
	nextDirect	$3c,$3d,$7c,$7d,$79,$7a,$78,$7e,$3c,$3d,$3e,$5b,$5c,$79,$7a,$78
	nextDirect  $7c,$5d,$5e,$78,$5f,$4f
	nextDirect  -1


NotMBC30:
INCBIN "dfs/NotMBC30.1bpp"

MBC3ErrorCGB:
INCBIN "dfs/MBC3ErrorCGB.1bpp"

; ENDC

; IF DEF(_32KB)
; VerImg::
; 	INCBIN "dfs/vergbc.1bpp"
; ELSE
; VerImg::
; 	INCBIN "dfs/vergb.1bpp"
; ENDC

CHSENGLabel::
	INCBIN "dfs/chsenglabel.1bpp"
