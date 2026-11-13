; Original English names, separate from the Excel-imported NPCTrades table.
; Entries correspond to NPC_TRADE_* constants.
NPCTradeNicknamesENG:
	table_width MON_NAME_LENGTH, NPCTradeNicknamesENG
	db_w "MUSCLE@@@@@"
	db_w "ROCKY@@@@@@"
	db_w "VOLTY@@@@@@"
	db_w "DON@@@@@@@@"
	db_w "RUNNY@@@@@@"
	db_w "AEROY@@@@@@"
	assert_table_length NUM_NPC_TRADES

NPCTradeOTNamesENG:
	table_width NAME_LENGTH, NPCTradeOTNamesENG
	db_w "MIKE@@@@@@@"
	db_w "KYLE@@@@@@@"
	db_w "TIM@@@@@@@@"
	db_w "EMY@@@@@@@@"
	db_w "CHRIS@@@@@@"
	db_w "KIM@@@@@@@@"
	assert_table_length NUM_NPC_TRADES

	assert MON_NAME_LENGTH == NAME_LENGTH
