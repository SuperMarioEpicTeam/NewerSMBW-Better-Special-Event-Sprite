SECTIONS {
	/*		LEVEL SPECIAL DX	*/
	updateUI = 0x800e3b18;
	ApparentlyStartsMusic = 0x8019bd90;
	returnTimerLeq100 = 0x800e3af8;
	returnAt8019e154 = 0x8019e154;
	returnAt8019e140 = 0x8019e140;
	SoundSceneMgrInstance = 0x8042a788;
	ReturnHurryUpSFX = 0x8019ea48;
	ReturnNoHurryUpSFX = 0x8019ea58;
	ReturnFromSelectiveHurryUpSFX = 0x8019ea30;
	DoneWithSelectiveHurryUpSFX_SaveRegs = 0x8019566c;
	DoneWithMuteHurrySFXWhenRaisingTime = 0x801956c8;
	ContinueFromSkipGameOverThoughSlowedDownTime = 0x8013d818;
	ReturnSendToWm = 0x8013d8dc;
	ReturnUpdateTimeUpAc = 0x8077c00c;
	ReturnDontUpdateTimeUpAc = 0x8077c04c;

	.text : {
		FILL (0)

		__text_start = . ;
		*(.init)
		*(.text)
		__ctor_loc = . ;
		*(.ctors)
		__ctor_end = . ;
		*(.dtors)
		*(.rodata)
		/**(.sdata)*/
		*(.data)
		/**(.sbss)*/
		*(.bss)
		*(.fini)
		*(.rodata.*)
		__text_end  = . ;
	}
}
