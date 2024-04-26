
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ gChapterData, 0x0202BCF0
.equ IsCharacterForceDeployed, 0x080953F0
.equ RemoveCharFromDeployData, 0x08095314
.equ Routine_0809A580, 0x0809A580
.equ PrepUnitSelectCallHelpBox, 0x08097DA8
.equ m4aSongNumStart, 0x080D01FC
