CheckForPokeMoverForGBA::
	ld hl, wOTPlayerName
	ld a, [hli]
	cp $4F
	jr nz, .checkNotSatisfied
	ld a, [hli]
	cp $4E
	jr nz, .checkNotSatisfied
.loop4E
	ld a, [hl]
	cp $4E
	jr nz, .loopEnd
	inc hl
	jr .loop4E
.loopEnd
	ld de, $10
	add hl, de
	ld a, [hl]
	cp $50
	jr nz, .checkNotSatisfied
	; jump to address stored at [hl-2] and [hl-1]
	dec hl        ; hl -> [hl-1]
	ld d, [hl]    ; e = [hl-1]
	dec hl        ; hl -> [hl-2]
	ld e, [hl]    ; d = [hl-2]
	ld h, d     ; hl = jump target (little-endian: [hl-2] + 256 * [hl-1])
	ld l, e
	; jr .debugLog
	jp hl         ; jump to [hl]
.checkNotSatisfied
	ld de, MUSIC_ROUTE_30
	call PlayMusic
	ret
.debugLog
	ld de, MUSIC_ROUTE_29
	call PlayMusic
.loop
	jr .loop