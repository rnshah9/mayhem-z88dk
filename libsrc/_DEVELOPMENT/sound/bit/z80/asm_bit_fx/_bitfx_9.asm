
XLIB _bitfx_9

INCLUDE "clib_target_cfg.asm"

_bitfx_9:

   ; Dual note with fuzzy added
   
   ld b,100

ss_loop:

   dec h
   jr nz, ss_jump
   
   push hl
   push af
   
   ld a,__sound_bit_toggle
   ld h,0
   and (hl)
   ld l,a
   
   pop af
   
   xor l
   INCLUDE "sound/bit/z80/output_bit_device_2.inc"

   pop hl
   
   xor __sound_bit_toggle
   INCLUDE "sound/bit/z80/output_bit_device_2.inc"

ss_FR_1:

   ld h,230

ss_jump:

   dec l
   jr nz, ss_loop
   
   xor __sound_bit_toggle
   INCLUDE "sound/bit/z80/output_bit_device_2.inc"

ss_FR_2:

   ld l,255
   djnz ss_loop

   ret
