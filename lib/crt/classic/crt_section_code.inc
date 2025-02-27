; CODE sections defined by the classic library

    SECTION CODE
    SECTION code_crt_init
    SECTION code_crt_init_exit
    SECTION code_crt_exit
    SECTION code_crt_exit_exit
    SECTION code_driver
    SECTION rodata_driver       ;Keep it in low memoey
    SECTION code_compiler
    SECTION code_clib
    SECTION code_l
    SECTION code_l_sdcc
    SECTION code_l_sccz80
    SECTION code_compress_zx7
    SECTION code_compress_zx0
    SECTION code_compress_zx1
    SECTION code_compress_zx2
    SECTION code_compress_aplib
    SECTION code_ctype
    SECTION code_esxdos
    SECTION code_fp
    SECTION code_fp_math48
    SECTION code_fp_math32
    SECTION code_fp_math16
    SECTION code_fp_mbf32
    SECTION code_fp_mbf64
    SECTION code_fp_am9511
    SECTION code_fp_dai32
    SECTION code_math
    SECTION code_error
    SECTION code_stdlib
    SECTION code_string
    SECTION code_adt_b_array
    SECTION code_adt_b_vector
    SECTION code_adt_ba_priority_queue
    SECTION code_adt_ba_stack
    SECTION code_adt_bv_priority_queue
    SECTION code_adt_bv_stack
    SECTION code_adt_p_forward_list
    SECTION code_adt_p_forward_list_alt
    SECTION code_adt_p_list
    SECTION code_adt_p_queue
    SECTION code_adt_p_stack
    SECTION code_adt_w_array
    SECTION code_adt_w_vector
    SECTION code_adt_wa_priority_queue
    SECTION code_adt_wa_stack
    SECTION code_adt_wv_priority_queue
    SECTION code_adt_wv_stack
    SECTION code_alloc_balloc
    SECTION code_alloc_obstack
    SECTION code_arch
    SECTION code_font
    SECTION code_font_fzx
    SECTION code_psg
    SECTION code_sound_ay
    SECTION code_PSGlib
    SECTION code_time
    SECTION code_z80
    SECTION code_sprite_sp1
    SECTION code_temp_sp1
    SECTION code_splib2
    SECTION code_sound_bit
IF !__crt_org_graphics
    SECTION code_graphics
ENDIF
    SECTION code_user
    SECTION CODE_END
