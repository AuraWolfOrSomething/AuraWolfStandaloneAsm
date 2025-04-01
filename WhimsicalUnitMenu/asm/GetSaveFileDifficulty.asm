.thumb

.include "../WhimsicalUnitMenuDefs.s"

.global GetSaveFileDifficulty
.type GetSaveFileDifficulty, %function

@0 = easy, 1 = normal, 2 = hard


		GetSaveFileDifficulty:
		ldr		r2, =gChapterData
		ldrb	r0, [r2,#0x14]
		mov		r1, #0x40
		tst		r0, r1
		bne		GetSaveFileDifficulty_Hard
		
			mov		r0, #0x42
			ldrb	r0, [r2,r0]
			mov		r1, #0x20
			tst		r0, r1
			beq		GetSaveFileDifficulty_Easy
			
				mov		r0, #1
				b		GetSaveFileDifficulty_End
		
		GetSaveFileDifficulty_Hard:
		mov		r0, #2
		b		GetSaveFileDifficulty_End
		
		GetSaveFileDifficulty_Easy:
		mov		r0, #0
		
		GetSaveFileDifficulty_End:
		bx		r14
		
		.align
		.ltorg

