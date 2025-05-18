.thumb

.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ StartMenuAdjusted, 0x0804EB98
.equ gMenuYCoordRepositioning, 0x085B6550
.equ DisplayUnitAdditionalBlinkingIcons, 0x080275E8

.global NewStartMenu_AndDoSomethingCommands
.type NewStartMenu_AndDoSomethingCommands, %function


		NewStartMenu_AndDoSomethingCommands:
		push	{r4-r7,r14}
		blh		StartMenuAdjusted, r4
		mov		r5, r0
		
		@check usable command count
		mov		r2, #0x60
		ldrb	r1, [r5,r2]
		cmp		r1, #6
		bls		End
		
			mov		r0, #0
			mov		r12, r0
			mov		r2, #0x60
			mov		r3, #0x2D
			
			ldrb	r0, [r5,r2]
			ldr		r6, =gMenuYCoordRepositioning
			ldrb	r6, [r6,r0]
			
			ldrb	r1, [r5,r3]
			sub		r1, r6
			cmp		r1, #0
			bge		StoreNewYCoord
			
				neg		r0, r1
				mov		r12, r0
				mov		r1, #0
				
				StoreNewYCoord:
				strb	r1, [r5,r3]
				mov		r4, #0
				
				@I don't think this check from vanilla is actually needed, but keeping it here just in case
				@ldrb	r0, [r5,r2]
				@cmp		r4, r0
				@bge		End
				
				mov		r7, r5
				add		r7, #0x34
				
				AdjustMenuCommandTextLoop:
				ldmia	r7, {r3}
				ldrb	r0, [r5,r2]
				ldrh	r0, [r3,#0x2C]
				sub		r0, r6
				mov		r1, r12
				add		r0, r1
				strh	r0, [r3,#0x2C]
				add		r4, #1
				ldrb	r0, [r5,r2]
				cmp		r4, r0
				blt		AdjustMenuCommandTextLoop
				
		End:
		mov		r0, #0
		ldr		r1, =WarningCacheLink
		ldr		r1, [r1]
		strh	r0, [r1]
		blh		DisplayUnitAdditionalBlinkingIcons, r0
		
		mov		r0, r5
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

