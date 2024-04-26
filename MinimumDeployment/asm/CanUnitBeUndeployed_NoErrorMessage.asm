.thumb

.include "../MinimumDeploymentDefs.s"

.global CanUnitBeUndeployed
.type CanUnitBeUndeployed, %function


		CanUnitBeUndeployed:
		push	{r4-r6,r14}
		mov		r5, r0 @proc
		mov		r4, r1 @current unit
		mov		r6, #0 @return value
		
		ldr		r0, [r4]
		ldrb	r0, [r0,#4]
		blh		IsCharacterForceDeployed, r1
		cmp		r0, #0
		bne		DenyUndeployment_ForcedUnit
		
			blh		GetChapterMinimumDeployment, r0
			mov		r2, #0x29
			ldrb	r1, [r5,r2] @current deployment count
			cmp		r0, r1
			bge		DenyUndeployment_LessThanMin
			
				@Lower current deployment count by 1
				sub		r1, #1
				strb	r1, [r5,r2]
				
				@Set undeployed state on unit
				ldr		r0, [r4,#0x0C]
				mov		r1, #0x0A
				orr		r0, r1
				str		r0, [r4,#0x0C]
				
				ldr		r0, [r4]
				ldrb	r0, [r0,#4]
				blh		RemoveCharFromDeployData, r1
				
				@Updates character name to be gray
				mov		r0, r5
				ldrh	r1, [r5,#0x2E]
				lsr		r1, #1
				blh		Routine_0809A580, r2
				
				mov		r6, #1
				mov		r0, #0x6B
				b		PlaySoundEffectIfOn
		
		DenyUndeployment_ForcedUnit:
		mov		r0, #0x6C
		b		PlaySoundEffectIfOn
		
		DenyUndeployment_LessThanMin:
		ldr		r0, =UndeployMinDenySoundLink
		ldrb	r0, [r0]
		
		PlaySoundEffectIfOn:
		ldr		r1, =gChapterData
		add		r1, #0x41
		ldrb	r1, [r1]
		lsl		r1, #0x1E
		cmp		r1, #0
		blt		End_CanUnitBeUndeployed
		
			blh		m4aSongNumStart, r1
			
		End_CanUnitBeUndeployed:
		mov		r0, r6
		pop		{r4-r6}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

