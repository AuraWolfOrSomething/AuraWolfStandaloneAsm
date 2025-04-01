.thumb

.include "../WhimsicalUnitMenuDefs.s"

.global StartMenuExt_MenuCommandLoop
.type StartMenuExt_MenuCommandLoop, %function


		StartMenuExt_MenuCommandLoop:
		push	{r14}
		add		sp, #-0x0C
		
		@See if menu can have its commands reordered
		mov		r2, r8
		ldr		r3, =gMenu_UnitMenu
		cmp		r3, r2
		bne		FixedOrder
			
			ldr		r2, =WhimsicalUnitMenuFrameCounterLink
			ldr		r2, [r2]
			mov		r0, #0
			strh	r0, [r2]
			
			add		r2, #0x10
			str		r2, [sp]
			
			mov		r3, #0
			str		r3, [sp,#4] @loop counter

			mov		r0, r8
			blh		CountMenuCommands, r1
			str		r0, [sp,#8] @number of commands in menu
			
			@randomize order
			mov		r1, r0
			ldr		r0, [sp]
			bl		RandomizeMenuCommands
			
			ldr		r2, [sp]
			ldrb	r6, [r2]
			mov		r2, #0x24
			mul		r6, r2
			b		LoopStart
			
		FixedOrder:
		mov		r6, #0
		str		r6, [sp]

		LoopStart:
		add		r0, r1, r6
		mov		r1, r7
		blh		0x0804F7AC, r2
		lsl		r0, #0x18
		lsr		r4, r0, #0x18
		cmp		r4, #0
		bne		CheckCommandUsability
		
			mov		r1, r8
			ldr		r0, [r1,#8]
			add		r0, r6
			ldr		r2, [r0,#0x0C]
			mov		r1, r7
			mov		lr, r2
			.short	0xF800
			lsl		r0, #0x18
			lsr		r4, r0, #0x18
		
			CheckCommandUsability:
			cmp		r4, #3
			beq		NextCommand
			
				ldr		r0, =gProc_MenuCommand
				mov		r1, r5
				blh		ProcStart, r2
				mov		r2, r0
				ldr		r0, [sp,#0x18] @vanilla code has loading at [sp,#0x08]; with the current stack adjustments, +0x10 will correctly re-align this 
				lsl		r1, r0, #2
				add		r0, r5, r1
				str		r2, [r0,#0x34]
				ldr		r1, [sp,#0x18] @vanilla code has loading at [sp,#0x08]; with the current stack adjustments, +0x10 will correctly re-align this 
				add		r1, #1
				str		r1, [sp,#0x18] @vanilla code has loading at [sp,#0x08]; with the current stack adjustments, +0x10 will correctly re-align this 
				mov		r1, r8
				ldr		r0, [r1,#8]
				add		r0, r6
				str		r0, [r2,#0x30]
				mov		r0, #0x3C
				strb	r7, [r2,r0]
				add		r0, #1
				strb	r4, [r2,r0]
				mov		r0, r13
				ldrh	r0, [r0,#0x1C] @vanilla code has loading at [sp,#0x0C]; with the current stack adjustments, +0x10 will correctly re-align this 
				strh	r0, [r2,#0x2A]
				mov		r1, r9
				strh	r1, [r2,#0x2C]
				mov		r0, #0x63
				ldrb	r1, [r5,r0]
				mov		r0, #8
				tst		r0, r1
				bne		NextCommand_NewLine
				
					mov		r0, r2
					add		r0, #0x34
					mov		r2, r10
					lsl		r1, r2, #8
					asr		r1, #0x18
					sub		r1, #1
					blh		Text_InitClear, r3
					
					NextCommand_NewLine:
					mov		r0, #2
					add		r9, r0
					
					NextCommand:
					add		r7, #1
					mov		r2, r8
					ldr		r1, [r2,#8]
					ldr		r0, [sp]
					cmp		r0, #0
					beq		NextCommand_Fixed
					
						ldr		r6, [sp,#4]
						add		r6, #1
						str		r6, [sp,#4]
						ldrb	r6, [r0,r6]
						ldr		r0, [sp,#8]
						cmp		r7, r0
						bge		StartMenuExt_MenuCommandLoop_End
						
							mov		r2, #0x24
							mul		r6, r2
							b		LoopStart
						
							NextCommand_Fixed:
							add		r6, #0x24
							add		r0, r6, r1
							ldr		r2, [r0,#0x0C]
							cmp		r2, #0
							bne		LoopStart
		
		StartMenuExt_MenuCommandLoop_End:
		add		sp, #0x0C
		pop		{r0}
		bx		r0
		
		.align
		.ltorg

