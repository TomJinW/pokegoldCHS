TownMap_ConvertLineBreakCharacters:
	ld hl, wStringBuffer1
.loop
	ld a, [hl]
	cp CHARVAL("@")
	jr z, .end
	cp CHARVAL("<WBR>")
	jr z, .line_feed
	cp CHARVAL("<BSP>")
	jr z, .line_feed
	inc hl
	jr .loop

.line_feed
	ld [hl], CHARVAL("<LF>")

.end
	ld de, wStringBuffer1
	hlcoord 9, 0
	call PlaceString
	ret
