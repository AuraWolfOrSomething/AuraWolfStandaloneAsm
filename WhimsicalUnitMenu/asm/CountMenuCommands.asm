.thumb

.global CountMenuCommands
.type CountMenuCommands, %function


		CountMenuCommands:
		ldr		r1, [r0,#8]
		mov		r0, #0
		
		CountMenuCommands_Loop:
		ldr		r2, [r1]
		cmp		r2, #0
		beq		CountMenuCommands_End
		
			add		r0, #1
			add		r1, #0x24
			b		CountMenuCommands_Loop
		
		CountMenuCommands_End:
		bx		r14
		
		.align
		.ltorg

