.thumb

.equ origin, 0x0804F64C
.include "../UnitMenuUpdateWarningCacheDefs.s"

.global StartMenu_AndDoSomethingCommandsHook
.type StartMenu_AndDoSomethingCommandsHook, %function


		StartMenu_AndDoSomethingCommandsHook:
		push	{r4,r14}
		blh		NewStartMenu_AndDoSomethingCommands, r4
		pop		{r4}
		pop		{r1}
		bx		r1
		
		.align
		.ltorg

