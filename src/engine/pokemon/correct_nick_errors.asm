; >de: straddr
; <b : length (tile)
; <c : last tile is half tile
; <de: straddr (same as input)
; <hl: new straddr end + 1
GetStrLength::
	ld bc, 0
	ld h, d
	ld l, e
.checkchar
; end of nick?
	ld a, [hli]
	cp "@" ; terminator
	jr z, .done
	and a
	jr z, .singlechar
	cp DFS_CODE_CONTRL_0
	jr c, .doublechar
	cp DFS_CODE_CONTRL_2
	jr nc, .singlechar
	bit 3, a
	jr nz, .doublechar
	
.singlechar
	bit 0, b
	jr z, .newsingle
	jr .leftsingle
.doublechar
	inc hl
.leftsingle
	inc b
.newsingle
	inc b
	inc b
	jr .checkchar

.done
	srl b
	ret nc
	rr c
	inc b
	ret

FixStrLength::
	inc b
	ld h, d
	ld l, e
.checkchar
; end of nick?
	ld a, [hli]
	cp "@" ; terminator
	ret z
	and a
	jr z, .singlechar
	cp DFS_CODE_CONTRL_0
	jr c, .doublechar
	cp DFS_CODE_CONTRL_2
	jr nc, .singlechar
	bit 3, a
	jr nz, .doublechar
	
.singlechar
	bit 0, c
	jr z, .newsingle
	inc c
	dec b
	jr z, .done
.newsingle
rept 2
	dec b
	jr z, .done
endr
	jr .checkchar
	
.doublechar
	inc c
rept 3
	dec b
	jr z, .done
endr
	inc hl
	jr .checkchar
.done
	dec hl
	ld [hl], "@"
	ret

CorrectNickErrors::
; error-check monster nick before use
; must be a peace offering to gamesharkers

; input: de = nick location

	push bc
	push de
	ld b, MON_NAME_LENGTH

.checkchar
; end of nick?
	ld a, [de]
	cp "@" ; terminator
	jr z, .end
	and a
	jr z, .singlechar
	cp DFS_CODE_CONTRL_0
	jr c, .doublechar
	cp DFS_CODE_CONTRL_2
	jr nc, .singlechar
	bit 3, a
	jr nz, .doublechar

.singlechar
; check if this char is a text command
	ld c, 0
	ld hl, .textcommands - 1
	; dec hl
	jr .loop

.doublechar
	dec b
	jr z, .overflow
	inc de
	ld a, [de]
	cp "@"
	jr z, .earlyend
	ld c, 1
	cp DFS_CODE_L_CONTRL_4_END
	jr z, .replace
	ld hl, .textcommands_double - 1
	; dec hl

.loop
; next entry
	inc hl
; reached end of commands table?
	ld a, [hl]
	cp -1
	jr z, .done

; is the current char between this value (inclusive)...
	ld a, [de]
	cp [hl]
	inc hl
	jr c, .loop
; ...and this one?
	cp [hl]
	jr nc, .loop
.replace
; replace it with a "?"
	ld a, "?"
	ld [de], a
	; jr .loop
	dec c
	jr nz, .done
	dec de
	ld [de], a
	inc de


.done
; next char
	inc de
; reached end of nick without finding a terminator?
	dec b
	jr nz, .checkchar

.overflow
; change nick to "?@"
	pop de
	push de
	ld a, "?"
	ld [de], a
	inc de
	ld a, "@"
	ld [de], a
.end
; if the nick has any errors at this point it's out of our hands
	pop de
	pop bc
	ret

.earlyend
	dec de
	ld a, "?"
	ld [de], a
	jr .end

.textcommands
; table defining which characters are actually text commands
; format:
	;      ≥           <
	db "<NULL>",   "ガ"
	db "<JP_14>",  "<JP_18>" + 1
	db "<NI>",     "<NO>"    + 1
	db "<ROUTE>",  "<GREEN>" + 1
	db "<ENEMY>",  "<ENEMY>" + 1
	db "<MOM>",    "<TM>"    + 1
	db "<ROCKET>", "┘"       + 1
	db -1 ; end

.textcommands_double
; table defining which characters are actually text commands
; format:
	;      ≥           <
	db DFS_CODE_L_NULL,     DFS_CODE_L_NULL         + 1
	db DFS_CODE_L_CONTRL_0, DFS_CODE_L_CONTRL_0_END + 1
	db DFS_CODE_L_CONTRL_1, DFS_CODE_L_CONTRL_1_END + 1
	db DFS_CODE_L_CONTRL_2, DFS_CODE_L_CONTRL_2_END + 1
	db DFS_CODE_L_CONTRL_3, DFS_CODE_L_CONTRL_3_END + 1
	db DFS_CODE_L_CONTRL_4, DFS_CODE_L_CONTRL_4_END + 1 - 1 ; max $ff
	db -1 ; end