MACRO landmark
; x, y, name
	db \1 + 8, \2 + 16
	dw \3
ENDM

Landmarks:
; entries correspond to constants/landmark_constants.asm
	table_width 4, Landmarks
	landmark  -8, -16, SpecialMapName
	landmark 140, 100, NewBarkTownName
	landmark 128, 100, Route29Name
	landmark 100, 100, CherrygroveCityName
	landmark 100,  80, Route30Name
	landmark  96,  60, Route31Name
	landmark  84,  60, VioletCityName
	landmark  85,  58, SproutTowerName
	landmark  84,  92, Route32Name
	landmark  76,  76, RuinsOfAlphName
	landmark  84, 124, UnionCaveName
	landmark  82, 124, Route33Name
	landmark  68, 124, AzaleaTownName
	landmark  70, 122, SlowpokeWellName
	landmark  52, 120, IlexForestName
	landmark  52, 112, Route34Name
	landmark  52,  92, GoldenrodCityName
	landmark  50,  92, RadioTowerName
	landmark  52,  76, Route35Name
	landmark  52,  60, NationalParkName
	landmark  64,  60, Route36Name
	landmark  68,  52, Route37Name
	landmark  68,  44, EcruteakCityName
	landmark  70,  42, TinTowerName
	landmark  66,  42, BurnedTowerName
	landmark  52,  44, Route38Name
	landmark  36,  48, Route39Name
	landmark  36,  60, OlivineCityName
	landmark  38,  62, LighthouseName
	landmark  28,  64, Route40Name
	landmark  28,  92, WhirlIslandsName
	landmark  28, 100, Route41Name
	landmark  20, 100, CianwoodCityName
	landmark  92,  44, Route42Name
	landmark  84,  44, MtMortarName
	landmark 108,  44, MahoganyTownName
	landmark 108,  36, Route43Name
	landmark 108,  28, LakeOfRageName
	landmark 120,  44, Route44Name
	landmark 130,  38, IcePathName
	landmark 132,  44, BlackthornCityName
	landmark 132,  36, DragonsDenName
	landmark 132,  64, Route45Name
	landmark 112,  72, DarkCaveName
	landmark 124,  88, Route46Name
	landmark 148,  68, SilverCaveName
	assert_table_length KANTO_LANDMARK
	landmark  52, 108, PalletTownName
	landmark  52,  92, Route1Name
	landmark  52,  76, ViridianCityName
	landmark  52,  64, Route2Name
	landmark  52,  52, PewterCityName
	landmark  64,  52, Route3Name
	landmark  76,  52, MtMoonName
	landmark  88,  52, Route4Name
	landmark 100,  52, CeruleanCityName
	landmark 100,  44, Route24Name
	landmark 108,  36, Route25Name
	landmark 100,  60, Route5Name
	landmark 108,  76, UndergroundName
	landmark 100,  76, Route6Name
	landmark 100,  84, VermilionCityName
	landmark  88,  60, DiglettsCaveName
	landmark  88,  68, Route7Name
	landmark 116,  68, Route8Name
	landmark 116,  52, Route9Name
	landmark 132,  52, RockTunnelName
	landmark 132,  56, Route10Name
	landmark 132,  60, PowerPlantName
	landmark 132,  68, LavenderTownName
	landmark 140,  68, LavRadioTowerName
	landmark  76,  68, CeladonCityName
	landmark 100,  68, SaffronCityName
	landmark 116,  84, Route11Name
	landmark 132,  80, Route12Name
	landmark 124, 100, Route13Name
	landmark 116, 112, Route14Name
	landmark 104, 116, Route15Name
	landmark  68,  68, Route16Name
	landmark  68,  92, Route17Name
	landmark  80, 116, Route18Name
	landmark  92, 116, FuchsiaCityName
	landmark  92, 128, Route19Name
	landmark  76, 132, Route20Name
	landmark  68, 132, SeafoamIslandsName
	landmark  52, 132, CinnabarIslandName
	landmark  52, 120, Route21Name
	landmark  36,  68, Route22Name
	landmark  28,  52, VictoryRoadName
	landmark  28,  44, Route23Name
	landmark  28,  36, IndigoPlateauName
	landmark  28,  92, Route26Name
	landmark  20, 100, Route27Name
	landmark  12, 100, TohjoFallsName
	landmark  20,  68, Route28Name
	landmark 140, 116, FastShipName
	assert_table_length NUM_LANDMARKS

	NewBarkTownName:     db_w "NEW BARK<WBR>TOWN@"
	CherrygroveCityName: db_w "CHERRYGROVE<WBR>CITY@"
	VioletCityName:      db_w "VIOLET CITY@"
	AzaleaTownName:      db_w "AZALEA TOWN@"
	GoldenrodCityName:   db_w "GOLDENROD<WBR>CITY@"
	EcruteakCityName:    db_w "ECRUTEAK<WBR>CITY@"
	OlivineCityName:     db_w "OLIVINE<WBR>CITY@"
	CianwoodCityName:    db_w "CIANWOOD<WBR>CITY@"
	MahoganyTownName:    db_w "MAHOGANY<WBR>TOWN@"
	BlackthornCityName:  db_w "BLACKTHORN<WBR>CITY@"
	LakeOfRageName:      db_w "LAKE OF<WBR>RAGE@"
	SilverCaveName:      db_w "SILVER CAVE@"
	SproutTowerName:     db_w "SPROUT<WBR>TOWER@"
	RuinsOfAlphName:     db_w "RUINS<WBR>OF ALPH@"
	UnionCaveName:       db_w "UNION CAVE@"
	SlowpokeWellName:    db_w "SLOWPOKE<WBR>WELL@"
	RadioTowerName:      db_w "RADIO TOWER@"
	PowerPlantName:      db_w "POWER PLANT@"
	NationalParkName:    db_w "NATIONAL<WBR>PARK@"
	TinTowerName:        db_w "TIN TOWER@"
	LighthouseName:      db_w "LIGHTHOUSE@"
	WhirlIslandsName:    db_w "WHIRL<WBR>ISLANDS@"
	MtMortarName:        db_w "MT.MORTAR@"
	DragonsDenName:      db_w "DRAGON'S<WBR>DEN@"
	IcePathName:         db_w "ICE PATH@"
	NotApplicableName:   db_w "N/A@" ; unreferenced ; "オバケやしき" ("HAUNTED HOUSE") in Japanese
	PalletTownName:      db_w "PALLET TOWN@"
	ViridianCityName:    db_w "VIRIDIAN<WBR>CITY@"
	PewterCityName:      db_w "PEWTER CITY@"
	CeruleanCityName:    db_w "CERULEAN<WBR>CITY@"
	LavenderTownName:    db_w "LAVENDER<WBR>TOWN@"
	VermilionCityName:   db_w "VERMILION<WBR>CITY@"
	CeladonCityName:     db_w "CELADON<WBR>CITY@"
	SaffronCityName:     db_w "SAFFRON<WBR>CITY@"
	FuchsiaCityName:     db_w "FUCHSIA<WBR>CITY@"
	CinnabarIslandName:  db_w "CINNABAR<WBR>ISLAND@"
	IndigoPlateauName:   db_w "INDIGO<WBR>PLATEAU@"
	VictoryRoadName:     db_w "VICTORY<WBR>ROAD@"
	MtMoonName:          db_w "MT.MOON@"
	RockTunnelName:      db_w "ROCK TUNNEL@"
	LavRadioTowerName:   db_w "LAV<WBR>RADIO TOWER@"
	SilphCoName:         db_w "SILPH CO.@" ; unreferenced
	SafariZoneName:      db_w "SAFARI ZONE@" ; unreferenced
	SeafoamIslandsName:  db_w "SEAFOAM<WBR>ISLANDS@"
	PokemonMansionName:  db_w "#MON<WBR>MANSION@" ; unreferenced
	CeruleanCaveName:    db_w "CERULEAN<WBR>CAVE@" ; unreferenced
	Route1Name:          db_w "ROUTE 1@"
	Route2Name:          db_w "ROUTE 2@"
	Route3Name:          db_w "ROUTE 3@"
	Route4Name:          db_w "ROUTE 4@"
	Route5Name:          db_w "ROUTE 5@"
	Route6Name:          db_w "ROUTE 6@"
	Route7Name:          db_w "ROUTE 7@"
	Route8Name:          db_w "ROUTE 8@"
	Route9Name:          db_w "ROUTE 9@"
	Route10Name:         db_w "ROUTE 10@"
	Route11Name:         db_w "ROUTE 11@"
	Route12Name:         db_w "ROUTE 12@"
	Route13Name:         db_w "ROUTE 13@"
	Route14Name:         db_w "ROUTE 14@"
	Route15Name:         db_w "ROUTE 15@"
	Route16Name:         db_w "ROUTE 16@"
	Route17Name:         db_w "ROUTE 17@"
	Route18Name:         db_w "ROUTE 18@"
	Route19Name:         db_w "ROUTE 19@"
	Route20Name:         db_w "ROUTE 20@"
	Route21Name:         db_w "ROUTE 21@"
	Route22Name:         db_w "ROUTE 22@"
	Route23Name:         db_w "ROUTE 23@"
	Route24Name:         db_w "ROUTE 24@"
	Route25Name:         db_w "ROUTE 25@"
	Route26Name:         db_w "ROUTE 26@"
	Route27Name:         db_w "ROUTE 27@"
	Route28Name:         db_w "ROUTE 28@"
	Route29Name:         db_w "ROUTE 29@"
	Route30Name:         db_w "ROUTE 30@"
	Route31Name:         db_w "ROUTE 31@"
	Route32Name:         db_w "ROUTE 32@"
	Route33Name:         db_w "ROUTE 33@"
	Route34Name:         db_w "ROUTE 34@"
	Route35Name:         db_w "ROUTE 35@"
	Route36Name:         db_w "ROUTE 36@"
	Route37Name:         db_w "ROUTE 37@"
	Route38Name:         db_w "ROUTE 38@"
	Route39Name:         db_w "ROUTE 39@"
	Route40Name:         db_w "ROUTE 40@"
	Route41Name:         db_w "ROUTE 41@"
	Route42Name:         db_w "ROUTE 42@"
	Route43Name:         db_w "ROUTE 43@"
	Route44Name:         db_w "ROUTE 44@"
	Route45Name:         db_w "ROUTE 45@"
	Route46Name:         db_w "ROUTE 46@"
	DarkCaveName:        db_w "DARK CAVE@"
	IlexForestName:      db_w "ILEX<WBR>FOREST@"
	BurnedTowerName:     db_w "BURNED<WBR>TOWER@"
	FastShipName:        db_w "FAST SHIP@"
	ViridianForestName:  db_w "VIRIDIAN<WBR>FOREST@" ; unreferenced
	DiglettsCaveName:    db_w "DIGLETT's<WBR>CAVE@"
	TohjoFallsName:      db_w "TOHJO FALLS@"
	UndergroundName:     db_w "UNDERGROUND@"
	SpecialMapName:      db_w "SPECIAL@"
