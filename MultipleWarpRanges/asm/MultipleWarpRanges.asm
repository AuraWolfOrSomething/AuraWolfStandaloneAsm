.thumb

.include "../MultipleWarpRangesDefs.s"

.global MultipleWarpRanges
.type MultipleWarpRanges, %function


		MultipleWarpRanges:
		push	{r14}
		ldr		r2, =gActionData
		ldrb	r2, [r2,#0x12]
		lsl		r2, #1
		add		r2, #0x1E
		ldrb	r1, [r0,r2] @r0 = active unit; r1 now = item id of item being used
		ldr		r3, =WarpRangesList
		
		MultipleWarpRanges_Loop:
		ldr		r2, [r3]
		cmp		r2, #0
		beq		MultipleWarpRanges_End
		
			ldrb	r2, [r3]
			cmp		r1, r2
			beq		MultipleWarpRanges_EntryFound
				
				add		r3, #8
				b		MultipleWarpRanges_Loop
				
		MultipleWarpRanges_EntryFound:
		ldr		r2, [r3,#4]
		cmp		r2, #0
		beq		MultipleWarpRanges_Fixed
		
			mov		lr, r2
			.short	0xF800
			mov		r2, r0
			b		MultipleWarpRanges_End
			
			MultipleWarpRanges_Fixed:
			ldrb	r2, [r3,#2]
		
		MultipleWarpRanges_End:
		lsl		r0, r2, #0x10 @This probably isn't needed, but just in case (and also since hook overwrites this)
		lsr		r0, #0x10
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

