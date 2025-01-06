PlaceWaitingText::
	; hlcoord 3, 10
	; ld b, 1
	; ld c, 11
	hlcoord 2, 8
	ld b, 2
	ld c, 13

	ld a, [wBattleMode]
	and a
	jr z, .notinbattle

	call Textbox
	jr .proceed

.notinbattle
	predef LinkTextboxAtHL

.proceed
	hlcoord 4, 10 ;hlcoord 4, 11
	ld de, .Waiting
	call PlaceString
	ld c, 50
	jp DelayFrames

.Waiting:
	db "Waiting...!@"

DummyPredef1:
	ret
