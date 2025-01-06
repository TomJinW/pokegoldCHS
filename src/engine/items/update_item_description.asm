UpdateItemDescription:

	; push hl
	; ld a, $2E
	; lb bc, 10, 7
	; coord hl, 7, 2
	; call DFSStaticize
	; pop hl

	ld a, [wMenuSelection]
	ld [wCurSpecies], a
	hlcoord 0, 12
	ld b, 4
	ld c, SCREEN_WIDTH - 2
	call Textbox
	ld a, [wMenuSelection]
	cp -1
	ret z
	decoord 1, 14
	farcall PrintItemDescription
	ret
