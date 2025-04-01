
.macro blh to, reg=r3
  ldr \reg, =\to
  mov lr, \reg
  .short 0xf800
.endm

.equ gpKeyState, 0x0858791C
.equ Menu_DrawHoverThing, 0x0804F0E0
.equ gChapterData, 0x0202BCF0
.equ m4aSongNumStart, 0x080D01FC
.equ gMenu_UnitMenu, 0x0859D1F0
.equ NextRN_N, 0x08000C80
.equ gProc_MenuCommand, 0x085B6510
.equ ProcStart, 0x08002C7C
.equ Text_InitClear, 0x08003D5C

.equ gGameState, 0x0202BCB0
.equ Roll1RN, 0x08000CA0
.equ ReadMenuRelatedList, 0x0804F7E8
.equ EffectWait, 0x08022738|1
