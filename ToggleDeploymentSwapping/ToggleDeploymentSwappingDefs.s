
.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm


.equ gChapterData, 0x0202BCF0
.equ gActiveUnit, 0x03004E50
.equ CheckGameLinkArenaBit, 0x08042E98
.equ GetBattleMapType, 0x080BD068
