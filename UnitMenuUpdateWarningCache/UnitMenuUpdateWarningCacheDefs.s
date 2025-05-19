
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ StartMenuAdjusted, 0x0804EB98
.equ gMenuYCoordRepositioning, 0x085B6550
.equ DisplayUnitAdditionalBlinkingIcons, 0x080275E8
