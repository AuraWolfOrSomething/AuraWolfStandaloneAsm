.thumb

.include "../MultipleWarpRangesDefs.s"

.global GetHalfMagPlusStaffSavantRange
.type GetHalfMagPlusStaffSavantRange, %function


		GetHalfMagPlusStaffSavantRange:
		push	{r4-r5,r14}
		mov		r5, r0
		blh		GetUnitMagic, r1
		mov		r1, #2
		swi		#0x06
		
		cmp		r0, #5
		bge		GetHalfMagPlusStaffSavantRange_SkillCheck
		
			@Minimum range of 5
			mov		r0, #5
			
		GetHalfMagPlusStaffSavantRange_SkillCheck:
		mov		r4, r0
		mov		r0, r5
		ldr		r1, =StaffSavantIdLink
		ldrb	r1, [r1]
		blh		SkillTester, r3
		cmp		r0, #0
		beq		GetHalfMagPlusStaffSavantRange_End
		
			add		r4, #1
		
		GetHalfMagPlusStaffSavantRange_End:
		mov		r0, r4
		pop		{r4-r5}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

