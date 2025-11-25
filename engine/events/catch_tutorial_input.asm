_DudeAutoInput_A::
	ld hl, DudeAutoInput_A
	jr _DudeAutoInput

_DudeAutoInput_RightA:
	ld hl, DudeAutoInput_RightA
	jr _DudeAutoInput

_DudeAutoInput_DownA:
_DudeAutoInput_WaitRightA:
	ld hl, DudeAutoInput_WaitRightA
	jr _DudeAutoInput

_DudeAutoInput:
	ld a, BANK(DudeAutoInputs)
	call StartAutoInput
	ret

DudeAutoInputs: ; used only for BANK(DudeAutoInputs)

DudeAutoInput_A:
	db NO_INPUT, $50
	db A_BUTTON, $00
	db NO_INPUT, $ff ; end

DudeAutoInput_RightA:
	db NO_INPUT, $08
	db D_RIGHT,  $00
	db NO_INPUT, $08
	db A_BUTTON, $00
	db NO_INPUT, $ff ; end

DudeAutoInput_DownA:
DudeAutoInput_WaitRightA:
	db NO_INPUT, $fe
	db NO_INPUT, $fe
	db NO_INPUT, $fe
	db NO_INPUT, $fe
	db D_RIGHT,  $00 ; D_DOWN in English version
	db NO_INPUT, $fe
	db NO_INPUT, $fe
	db NO_INPUT, $fe
	db NO_INPUT, $fe
	db A_BUTTON, $00
	db NO_INPUT, $ff ; end
