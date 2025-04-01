.thumb

.include "../WhimsicalUnitMenuDefs.s"

.global RandomizeMenuCommands
.type RandomizeMenuCommands, %function

.global WhimsicalUnitMenuDirectionInputs
.type WhimsicalUnitMenuDirectionInputs, %function

.global WhimsicalUnitMenuSelectInputs
.type WhimsicalUnitMenuSelectInputs, %function


@-----------------------------------------
@RandomizeMenuCommands
@-----------------------------------------


		RandomizeMenuCommands:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r5, r1
		ldr		r6, =RandomMenuCommandStorageLink
		ldr		r6, [r6]
		
		mov		r0, #0
		mov		r1, #0
		
		RandomizeMenuCommands_ClearLoop:
		str		r0, [r6,r1]
		add		r1, #4
		cmp		r1, r5
		blt		RandomizeMenuCommands_ClearLoop
		
		mov		r7, #0
		
		RandomizeMenuCommands_RandomLoop:
		mov		r0, r5
		blh		NextRN_N, r1
		ldrb	r1, [r6,r0]
		mov		r2, #0xFF
		cmp		r1, r2
		beq		RandomizeMenuCommands_RandomLoop
		
			strb	r2, [r6,r0]
			strb	r0, [r4,r7]
			add		r7, #1
			cmp		r7, r5
			blt		RandomizeMenuCommands_RandomLoop
			
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@WhimsicalUnitMenuDirectionInputs
@-----------------------------------------


		WhimsicalUnitMenuDirectionInputs:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r5, r1
		mov		r6, r2
		
		ldr		r7, =WhimsicalUnitMenuFrameCounterLink
		ldr		r7, [r7]
		ldrb	r0, [r7]
		add		r0, #1
		strb	r0, [r7]
		
		blh		GetSaveFileDifficulty, r0
		lsl		r0, #1
		
		ldr		r1, =gChapterData
		add		r1, #0x40
		ldrb	r1, [r1]
		mov		r2, #0x80
		tst		r1, r2
		beq		WhimsicalUnitMenuDirectionInputs_FrameTimer
		
			add		r0, #1
			
		WhimsicalUnitMenuDirectionInputs_FrameTimer:
		ldr		r2, =WhimsicalFramePointers
		ldrb	r0, [r2,r0]
		
		ldrb	r1, [r7]
		cmp		r1, r0
		
		blt		DidCursorMove
		
			mov		r0, #0
			strb	r0, [r7]

			ldrb	r0, [r6]
			sub		r0, #1
			ldrb	r1, [r6,#1]
			cmp		r1, r0
			bne		NewCursorLocation_Down
			
				mov		r0, #0xFF
				strb	r0, [r6,#1]
				
				NewCursorLocation_Down:
				ldrb	r0, [r6,#1]
				add		r0, #1
				strb	r0, [r6,#1]	
				
		DidCursorMove:
		ldrb	r1, [r6,#2]
		ldrb	r0, [r6,#1]
		cmp		r1, r0
		beq		DidCursorMove2
		
			ldrb	r1, [r6,#2]
			mov		r0, r5
			mov		r2, #0
			blh		Menu_DrawHoverThing, r3
			ldrb	r1, [r6,#1]
			mov		r0, r5
			mov		r2, #1
			blh		Menu_DrawHoverThing, r3
			
			ldr		r0, =gChapterData
			add		r0, #0x41
			ldrb	r0, [r0]
			lsl		r0, #0x1E
			cmp		r0, #0
			blt		DidCursorMove2
			
				mov		r0, #0x66
				blh		m4aSongNumStart, r1
					
		DidCursorMove2:
		ldrb	r0, [r6,#1]
		ldrb	r1, [r6,#2]
		cmp		r0, r1
		beq		NewMenu_HandleDirectionInputs_End
		
			ldrb	r0, [r6,#2]
			lsl		r0, #2
			add		r0, #0x34
			ldr		r1, [r5,r0]
			ldr		r0, [r1,#0x30]
			ldr		r2, [r0,#0x20]
			cmp		r2, #0
			beq		Label_0804F350
			
				mov		r0, r5
				mov		lr, r2
				.short	0xF800
				
				Label_0804F350:
				ldrb	r0, [r6,#1]
				lsl		r0, #2
				add		r0, #0x34
				ldr		r1, [r5,r0]
				ldr		r0, [r1,#0x30]
				ldr		r2, [r0,#0x1C]
				cmp		r2, #0
				beq		NewMenu_HandleDirectionInputs_End
				
					mov		r0, r5
					mov		lr, r2
					.short	0xF800
		
		NewMenu_HandleDirectionInputs_End:
		pop		{r4-r7}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@WhimsicalUnitMenuSelectInputs
@-----------------------------------------


		WhimsicalUnitMenuSelectInputs:
		push	{r4-r7,r14}
		mov		r4, r1
		mov		r5, r2
		mov		r6, r3
		ldr		r7, [r5,#0x30]
		
		ldrh	r1, [r0,#8] @button input
		
		CheckButton_A:
		mov		r0, #1
		tst		r0, r1
		beq		CheckButton_B
		
			@succeed if wait
			ldr		r0, [r7,#0x14]
			ldr		r1, =EffectWait
			cmp		r0, r1
			beq		Button_A_Cont
			
				@succeed if unit has already used take, give, trade, or supply
				ldr		r0, =gGameState
				add		r0, #0x3D
				ldrb	r0, [r0]
				mov		r1, #7
				tst		r0, r1
				bne		Button_A_Cont
				
					@fail on random success
					blh		GetSaveFileDifficulty, r0
					ldr		r1, =WhimsicalFailPointers
					ldrb	r0, [r1,r0]
					blh		Roll1RN, r1
					cmp		r0, #1
					beq		Button_B_Cont
					
						Button_A_Cont:
						mov		r0, r4
						mov		r1, r5
						blh		ReadMenuRelatedList, r2
						lsl		r0, #0x18
						lsr		r6, r0, #0x18
						cmp		r6, #0xFF
						bne		NewMenu_HandleSelectInputs_End
						
							ldr		r2, [r7,#0x14]
							b		CheckForValidRoutine
						
		CheckButton_B:
		mov		r0, #2
		tst		r0, r1
		beq		CheckButton_R
		
			Button_B_Cont:
			ldr		r0, [r4,#0x30]
			ldr		r2, [r0,#0x18]
			
			CheckForValidRoutine:
			
			@Reset frame counter
			ldr		r1, =WhimsicalUnitMenuFrameCounterLink
			ldr		r1, [r1]
			mov		r0, #0
			strh	r0, [r1]
			
			cmp		r2, #0
			beq		NewMenu_HandleSelectInputs_End
			
				mov		r0, r4
				mov		r1, r5
				mov		lr, r2
				.short	0xF800
				lsl		r0, #0x18
				lsr		r6, r0, #0x18
				b		NewMenu_HandleSelectInputs_End
				
		CheckButton_R:
		mov		r0, #0x80
		lsl		r0, #1
		tst		r0, r1
		beq		NewMenu_HandleSelectInputs_End
		
			ldr		r0, [r4,#0x30]
			ldr		r1, [r0,#0x1C]
			cmp		r1, #0
			beq		NewMenu_HandleSelectInputs_End
			
				mov		r0, r4
				mov		lr, r1
				.short	0xF800
		
		NewMenu_HandleSelectInputs_End:
		mov		r0, r6
		
		NewMenu_HandleSelectInputs_End2:
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

