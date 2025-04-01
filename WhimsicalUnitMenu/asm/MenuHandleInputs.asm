.thumb

.include "../WhimsicalUnitMenuDefs.s"

.global NewMenu_HandleDirectionInputs
.type NewMenu_HandleDirectionInputs, %function

.global NewMenu_HandleSelectInputs
.type NewMenu_HandleSelectInputs, %function


@-----------------------------------------
@NewMenu_HandleDirectionInputs
@-----------------------------------------


		NewMenu_HandleDirectionInputs:
		push	{r4-r6,r14}
		mov		r5, r0
		mov		r6, r5
		add		r6, #0x60
		ldrb	r0, [r6,#1]
		strb	r0, [r6,#2]
		
		ldr		r4, =gpKeyState
		ldr		r4, [r4]
		
		ldr		r1, [r5,#0x30]
		ldr		r2, =MenuDependentMenuInputList
		
		NewMenu_HandleDirectionInputs_Loop:
		ldr		r0, [r2]
		cmp		r0, #0
		beq		GetButtonInput_Direction
		
			cmp		r0, r1
			beq		NewMenu_HandleDirectionInputs_EntryFound
			
				add		r2, #0x0C
				b		NewMenu_HandleDirectionInputs_Loop
		
		NewMenu_HandleDirectionInputs_EntryFound:
		ldr		r3, [r2,#4]
		cmp		r3, #0
		beq		GetButtonInput_Direction
		
			mov		lr, r3
			mov		r0, r4
			mov		r1, r5
			mov		r2, r6
			.short	0xF800
			b		NewMenu_HandleDirectionInputs_End
		
		GetButtonInput_Direction:
		ldrh	r3, [r4,#6]
		
		CheckButton_Up:
		mov		r0, #0x40
		tst		r0, r3
		beq		CheckButton_Down
		
			ldrb	r0, [r6,#1]
			cmp		r0, #0
			bne		NewCursorLocation_Up
			
				ldrh	r2, [r4,#8]
				cmp		r3, r2
				bne		NewMenu_HandleDirectionInputs_End
				
					ldrb	r0, [r6]
					strb	r0, [r6,#1]
					
					NewCursorLocation_Up:
					ldrb	r0, [r6,#1]
					sub		r0, #1
					strb	r0, [r6,#1]
					
		CheckButton_Down:
		mov		r0, #0x80
		tst		r0, r3
		beq		DidCursorMove
		
			ldrb	r0, [r6]
			sub		r0, #1
			ldrb	r1, [r6,#1]
			cmp		r1, r0
			bne		NewCursorLocation_Down
			
				ldrh	r2, [r4,#8]
				cmp		r3, r2
				bne		NewMenu_HandleDirectionInputs_End
				
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
		pop		{r4-r6}
		pop		{r0}
		bx		r0
		
		.align
		.ltorg


@-----------------------------------------
@NewMenu_HandleSelectInputs
@-----------------------------------------


		NewMenu_HandleSelectInputs:
		push	{r4-r7,r14}
		mov		r4, r0
		mov		r6, #0
		add		r0, #0x61
		ldrb	r1, [r0]
		lsl		r1, #2
		sub		r0, #0x2D
		add		r0, r1
		ldr		r5, [r0]
		ldr		r7, [r5,#0x30]
		
		ldr		r2, [r7,#0x18]
		cmp		r2, #0
		beq		CheckButtonInput
		
			mov		r0, r4
			mov		r1, r5
			mov		lr, r2
			.short	0xF800
			lsl		r0, #0x18
			lsr		r6, r0, #0x18
		
		CheckButtonInput:
		ldr		r1, =gpKeyState
		ldr		r1, [r1]
		
		ldr		r2, =MenuDependentMenuInputList
		ldr		r3, [r4,#0x30]
		
		NewMenu_HandleSelectInputs_Loop:
		ldr		r0, [r2]
		cmp		r0, #0
		beq		GetButtonInput_Select
		
			cmp		r0, r3
			beq		NewMenu_HandleSelectInputs_EntryFound
			
				add		r2, #0x0C
				b		NewMenu_HandleSelectInputs_Loop
		
		NewMenu_HandleSelectInputs_EntryFound:
		ldr		r3, [r2,#8]
		cmp		r3, #0
		beq		GetButtonInput_Select
		
			mov		lr, r3
			mov		r0, r1
			mov		r1, r4
			mov		r2, r5
			mov		r3, r6
			.short	0xF800
			b		NewMenu_HandleSelectInputs_End2
		
		GetButtonInput_Select:
		ldrh	r1, [r1,#8]
		
		CheckButton_A:
		mov		r0, #1
		tst		r0, r1
		beq		CheckButton_B
		
			mov		r0, r4
			mov		r1, r5
			blh		0x0804F7E8, r2
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
		
			ldr		r0, [r4,#0x30]
			ldr		r2, [r0,#0x18]
			
			CheckForValidRoutine:
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

