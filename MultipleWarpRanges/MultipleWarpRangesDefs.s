
.macro blh to, reg=r3
	ldr \reg, =\to
	mov lr, \reg
	.short 0xF800
.endm

.equ gActionData, 0x0203A958
.equ GetUnitPower, 0x080191B0
.equ GetUnitMagic, 0x080191B8
.equ GetUnitResistance, 0x08019270
.equ gChapterData, 0x0202BCF0

