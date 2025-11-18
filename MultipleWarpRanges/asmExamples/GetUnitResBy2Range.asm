.thumb

.include "../MultipleWarpRangesDefs.s"

.global GetUnitResBy2Range
.type GetUnitResBy2Range, %function


		GetUnitResBy2Range:
		push	{r14}
		blh		GetUnitResistance, r1
		mov		r1, #2
		swi		#0x06
		
		cmp		r0, #5
		bge		GetUnitResBy2Range_End
		
			@Minimum range of 5
			mov		r0, #5
			
		GetUnitResBy2Range_End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

