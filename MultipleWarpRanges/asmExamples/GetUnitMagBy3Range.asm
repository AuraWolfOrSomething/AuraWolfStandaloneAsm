.thumb

.include "../MultipleWarpRangesDefs.s"

.global GetUnitMagBy3Range
.type GetUnitMagBy3Range, %function


		GetUnitMagBy3Range:
		push	{r14}
		blh		GetUnitPower, r1
		mov		r1, #3
		swi		#0x06
		
		cmp		r0, #5
		bge		GetUnitMagBy3Range_End
		
			@Minimum range of 5
			mov		r0, #5
			
		GetUnitMagBy3Range_End:
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

