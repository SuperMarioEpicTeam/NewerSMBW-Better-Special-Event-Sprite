.text

#include <asm_setup.S>

.align 4
.extern SlowedDownTime
.extern updateUI
.extern ApparentlyStartsMusic
.extern returnTimerLeq100
.extern returnAt8019e154
.extern returnAt8019e140
.extern SoundSceneMgrInstance
.extern DoneWithMuteHurrySFXWhenRaisingTime					#801956c8
.extern SetVolume__Q44nw4r3snd6detail10BasicSoundFfi
.extern GameTimer
.extern ContinueFromSkipGameOverThoughSlowedDownTime		#8013d818
.extern ReturnSendToWm										#8013d8dc
# .extern DoneWithSelectiveHurryUpSFX_SaveRegs				#8019566c
# .extern _savegpr_25
# .extern _restgpr_25
.extern Player_ID
.extern Player_Lives
.extern SlowedDownTimeAlt
.extern ReturnUpdateTimeUpAc								#8077c00c
.extern ReturnDontUpdateTimeUpAc							#8077c04c

.global CheckForTimeUnder100
CheckForTimeUnder100:								
	cmpwi	r0, 100
	bgt		TimeIsBgt100				

	b		returnTimerLeq100			


.global TimeIsBgt100
TimeIsBgt100:
	lis		r4, SlowedDownTime@ha			
	lbz		r0, SlowedDownTime@l (r4)
	cmplwi	r0, 0						
	bne		SlowDownMusic

	b		updateUI					


.global SlowDownMusic
SlowDownMusic:
	li		r0, 0						
	stb		r0, 0xB(r31)				
	li 		r4, 0x10

	lis		r3, SoundSceneMgrInstance@ha
	lwz		r3, SoundSceneMgrInstance@l (r3)
	bl		ApparentlyStartsMusic		

	b		updateUI					



.global WhichSongAfterTimeOver100
WhichSongAfterTimeOver100:
	cmplwi	r0, 0
	beq		returnNormalSpeed

	lis		r3, SlowedDownTime@ha
	lbz		r5, SlowedDownTime@l (r3)

	li		r0, 0
	lis		r3, SlowedDownTime@ha
	stb		r0, SlowedDownTime@l (r3)

	lis		r6, GameTimer@ha
	lwz		r6, GameTimer@l (r6)
	lbz		r0, 0xB(r6)

	lis		r3, SoundSceneMgrInstance@ha
	lwz		r3, SoundSceneMgrInstance@l (r3)
	stb		r0, 0x38(r3)

	cmplwi	r5, 0
	bne		returnNormalSpeed

	b		returnAt8019e140


.global returnNormalSpeed			
returnNormalSpeed:
	b		returnAt8019e154



# .extern ReturnHurryUpSFX						#8019ea48
# .extern ReturnNoHurryUpSFX						#8019ea58

# .global SelectiveHurryUpSFX
# SelectiveHurryUpSFX:
	# mr		r31, r3

	# lis		r3, SlowedDownTime@ha
	# lbz		r0, SlowedDownTime@l (r3)

	# li		r5, 5
	# li		r6, 14

	# cmplwi	r0, 0
	# bne		NoHurryUpSFX

	# li		r4, 175
	# b		ReturnHurryUpSFX
# NoHurryUpSFX:
	# li		r4, 1312
	# b		ReturnNoHurryUpSFX




# .global SelectiveHurryUpSFX_SaveRegs
# SelectiveHurryUpSFX_SaveRegs:
	# stwu	r1, -0x40(r1)
	# mfspr	r0, LR
	# stw		r0, 0x44(r1)
	# addi	r11, r1, 0x30
	# stfd	f31, 0x38(r1)
	# stfd	f30, 0x30(r1)
	# bl		_savegpr_25

	# #Here we gotta add 
	# b		DoneWithSelectiveHurryUpSFX_SaveRegs



# .global SelectiveHurryUpSFX_RestRegs
# SelectiveHurryUpSFX_RestRegs:
	# addi	r11, r1, 0x30
	# lfd		f31, 0x38(r1)
	# lfd		f30, 0x30(r1)
	# bl		_restgpr_25

	# lwz		r0, 0x44(r1)
	# mtspr	LR, r0
	# addi	r1, r1, 0x40
	# blr



.global MuteHurrySFXWhenRaisingTime
MuteHurrySFXWhenRaisingTime:
	mr		r31, r3

	lis		r3, SlowedDownTime@ha
	lbz		r3, SlowedDownTime@l (r3)
	cmplwi	r3, 0
	beq		DontMuteHurryFX

	lis		r3, Zeroooo@ha
	lfs		f1, Zeroooo@l (r3)
	lwz		r3, 0x900(r26)
	li		r4, 0			# <- fade out timer???
	bl		SetVolume__Q44nw4r3snd6detail10BasicSoundFfi

DontMuteHurryFX:
	mr		r3, r31
	cmpwi	r3, 0
	b		DoneWithMuteHurrySFXWhenRaisingTime





.global SelectHurryUpSFX
SelectHurryUpSFX:
	#r4 is the SFX type
	lis		r8, SlowedDownTime@ha
	lbz		r8, SlowedDownTime@l (r8)
	mulli	r9, r8, 2
	lis		r7, HUSFXs@h
	ori		r7, r7, HUSFXs@l
	lhzx	r4, r7, r9

	#r6 is (PROB) the fade out counter
	mulli	r9, r8, 4
	lis		r7, FadeOutCounters@h
	ori		r7, r7, FadeOutCounters@l
	lwzx	r6, r7, r9

	li		r7, 1
	blr





.global SkipTimeUpThoughSlowedDownTime
SkipTimeUpThoughSlowedDownTime:
	beq		DontUpdateTimeUpAc

	lis		r3, SlowedDownTimeAlt@ha
	lbz		r3, SlowedDownTimeAlt@l (r3)
	cmplwi	r3, 0
	bne		DontUpdateTimeUpAc

	mr		r3, r31
	b		ReturnUpdateTimeUpAc
DontUpdateTimeUpAc:
	b		ReturnDontUpdateTimeUpAc

.data
.align 4

HUSFXs:
	.short 0xAF
	.short 2			#SE_DEMO_OP_LAND_JR_0983f :D

FadeOutCounters:
	.long 20
	.long 2

Zeroooo:	.float 0.0

.align 4