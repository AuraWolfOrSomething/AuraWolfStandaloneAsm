.thumb

.equ origin, 0x0801E374
.include "../MultipleWarpRangesDefs.s"

.global MultipleWarpRanges_Hook
.type MultipleWarpRanges_Hook, %function


		MultipleWarpRanges_Hook:
		mov		r0, r8
		ldrb	r4, [r0,#0x10]
		ldrb	r5, [r0,#0x11]
		mov		r0, r9
		blh		MultipleWarpRanges, r1
		b		MultipleWarpRanges_Hook_End
		
		.align
		.ltorg
		
		MultipleWarpRanges_Hook_End:
		mov		r3, r0
		mov		r0, r4
		mov		r1, r5
		mov		r2, #1
		
		.align

