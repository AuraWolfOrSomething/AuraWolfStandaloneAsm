.thumb

.equ origin, 0
.include "../UpdatedLButtonCyclingDefs.s"

.global CheckIfValidForLPressCursor
.type CheckIfValidForLPressCursor, %function


		CheckIfValidForLPressCursor:
		push	{r4-r7,r14}
		mov		r5, r0
		blh		GetUnit, r1
		mov		r4, r0
		cmp		r4, #0
		beq		RetFalse
		
			ldr		r0, [r4]
			cmp		r0, #0
			beq		RetFalse
		
				ldr		r0, [r4,#0x0C]
				ldr		r1, =UnitState
				tst		r0, r1
				bne		RetFalse
		
					mov		r6, #0x10
					ldsb	r6, [r4,r6] @x-coord
					mov		r7, #0x11
					ldsb	r7, [r4,r7] @y-coord
		
					@If unit is concealed by fog, don't move cursor to them
					ldr		r0, =gMapFog
					ldr		r0, [r0]
					lsl		r1, r7, #2
					ldr		r1, [r0,r1]
					ldrb	r0, [r1,r6]
					cmp		r0, #0
					beq		End
		
						@Added an allegiance check so status is only checked for player units
						lsr		r5, #6
						cmp		r5, #0
						bne		Success
		
							mov		r0, r4
							add		r0, #0x30
							ldrb	r0, [r0]
							mov		r1, #0x0F
							and		r1, r0
		
							@berserk
							cmp		r1, #4
							beq		RetFalse
		
								@sleep
								cmp		r1, #2
								beq		RetFalse
		
		Success:
		ldr		r0, =gProc_PlayerPhase
		blh		ProcFind, r5
		cmp		r0, #0
		bne		GetCoords
		
			ldr		r0, =gProc_PrepScreen
			mov		lr, r5
			.short	0xF800
		
			GetCoords:
			mov		r1, r6
			mov		r2, r7
			blh		EnsureCameraOntoPosition, r3
			mov		r0, r6
			mov		r1, r7
			blh		SetCursorMapPosition, r2
			mov		r0, #1
			b		End
		
		RetFalse:
		mov		r0, #0
		
		End:
		pop		{r4-r7}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

