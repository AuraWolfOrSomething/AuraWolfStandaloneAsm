.thumb

.include "../MinimumDeploymentDefs.s"

.global GetChapterMinimumDeployment
.type GetChapterMinimumDeployment, %function

		GetChapterMinimumDeployment:
		ldr		r1, =gChapterData
		mov		r0, #0x0E
		ldsb	r1, [r1,r0]
		ldr		r0, =MinimumDeploymentAmountTable
		ldrb	r0, [r0,r1]
		cmp		r0, #0
		bne		End_GetChapterMinimumDeployment
		
			mov		r0, #1
			
		End_GetChapterMinimumDeployment:
		bx		r14
		
		.align
		.ltorg

