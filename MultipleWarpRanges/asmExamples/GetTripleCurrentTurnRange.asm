.thumb

.include "../MultipleWarpRangesDefs.s"

.global GetTripleCurrentTurnRange
.type GetTripleCurrentTurnRange, %function


		GetTripleCurrentTurnRange:
		ldr		r0, =gChapterData
		ldrh	r0, [r0,#0x10]
		lsl		r1, r0, #1
		add		r0, r1
		bx		r14
		
		.align
		.ltorg

