;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; RC_01_OUTPUT_HBIOS1
; output through hbios1 library routine
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; ;;;;;;;;;;;;;;;;;;;;
; DRIVER CLASS DIAGRAM
; ;;;;;;;;;;;;;;;;;;;;
;
; CONSOLE_01_OUTPUT_TERMINAL (root, abstract)
; RC_01_OUTPUT_HBIOS1 (concrete)
;
; This driver is compatible with CONSOLE_01_INPUT_TERMINAL.
;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MESSAGES CONSUMED FROM STDIO
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; * STDIO_MSG_PUTC
;   Generates multiple OTERM_MSG_PUTC messages.
;
; * STDIO_MSG_WRIT
;   Generates multiple OTERM_MSG_PUTC messages.
;
; * STDIO_MSG_SEEK -> no error, do nothing
; * STDIO_MSG_FLSH -> no error, do nothing
; * STDIO_MSG_ICTL
; * STDIO_MSG_CLOS -> no error, do nothing
;
; Any other messages are reported as errors via
; error_enotsup_zc
;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MESSAGES CONSUMED FROM CONSOLE_01_OUTPUT_TERMINAL
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;   * OTERM_MSG_PUTC
;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MESSAGES CONSUMED FROM CONSOLE_01_INPUT_TERMINAL
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;   * ITERM_MSG_PUTC
;   * ITERM_MSG_PRINT_CURSOR
;   * ITERM_MSG_BS
;   * ITERM_MSG_BS_PWD
;   * ITERM_MSG_ERASE_CURSOR
;   * ITERM_MSG_ERASE_CURSOR_PWD
;   * ITERM_MSG_READLINE_BEGIN
;   * ITERM_MSG_READLINE_END
;   * ITERM_MSG_BELL
;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; MESSAGES GENERATED FOR DERIVED DRIVERS
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;   * OTERM_MSG_TTY (optional)
;
;     enter  :  c = char to output
;     exit   :  c = char to output (possibly modified)
;               carry reset if tty emulation absorbs char
;     can use:  af, bc, de, hl
;
;     The driver should call the tty emulation module.
;     If not implemented characters are output without processing.
;
;   * OTERM_MSG_BELL (optional)
;
;     can use:  af, bc, de, hl
;
;     Sound the terminal's bell.
;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; IOCTLs UNDERSTOOD BY THIS DRIVER
; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;   * IOCTL_OTERM_CRLF
;     enable / disable crlf processing
;
;   * IOCTL_OTERM_BELL
;     enable / disable terminal bell
;
;   * IOCTL_OTERM_SIGNAL
;     enable / disable signal bell
;
;   * IOCTL_OTERM_COOK
;     enable / disable cook mode (tty emulation)
;
;   * IOCTL_OTERM_GET_OTERM
;
; ;;;;;;;;;;;;;;;;;;;;;;;;;;
; BYTES RESERVED IN FDSTRUCT
; ;;;;;;;;;;;;;;;;;;;;;;;;;;
;
; offset (wrt FDSTRUCT.JP)  description
;
;  8..13                    mutex

SECTION code_driver
SECTION code_driver_terminal_output

PUBLIC rc_01_output_hbios1

EXTERN console_01_output_terminal, error_zc
EXTERN rc_01_output_hbios1_oterm_msg_putc, rc_01_output_hbios1_stdio_msg_ictl
EXTERN rc_01_output_hbios1_iterm_msg_putc, rc_01_output_hbios1_iterm_msg_bs
EXTERN rc_01_output_hbios1_oterm_msg_bell, rc_01_output_hbios1_iterm_msg_bell

EXTERN OTERM_MSG_TTY, OTERM_MSG_BELL, ITERM_MSG_BELL
EXTERN OTERM_MSG_PUTC, STDIO_MSG_ICTL, ITERM_MSG_PUTC, ITERM_MSG_BS, ITERM_MSG_READLINE_BEGIN
EXTERN ITERM_MSG_BS_PWD, ITERM_MSG_PRINT_CURSOR, ITERM_MSG_ERASE_CURSOR, ITERM_MSG_READLINE_END
EXTERN ITERM_MSG_ERASE_CURSOR_PWD

rc_01_output_hbios1:

   ; messages generated by stdio

   cp OTERM_MSG_PUTC
   jp z, rc_01_output_hbios1_oterm_msg_putc

   cp OTERM_MSG_TTY   ;; prevent error generation for unimplemented message
   jp z, error_zc     ;; placed further up to speed up putchar

   cp STDIO_MSG_ICTL
   jp z, rc_01_output_hbios1_stdio_msg_ictl
   
   ; messages generated by input terminal
   
   cp ITERM_MSG_PUTC
   jp z, rc_01_output_hbios1_iterm_msg_putc
   
   jp c, console_01_output_terminal    ; forward to library
   
   cp ITERM_MSG_BS
   jp z, rc_01_output_hbios1_iterm_msg_bs
   
   cp ITERM_MSG_BS_PWD
   jp z, rc_01_output_hbios1_iterm_msg_bs

   cp ITERM_MSG_PRINT_CURSOR
   jp z, rc_01_output_hbios1_iterm_msg_putc

   cp ITERM_MSG_ERASE_CURSOR
   jp z, rc_01_output_hbios1_iterm_msg_bs

   cp ITERM_MSG_ERASE_CURSOR_PWD
   jp z, rc_01_output_hbios1_iterm_msg_bs

   cp OTERM_MSG_BELL
   jp z, rc_01_output_hbios1_oterm_msg_bell
   
   cp ITERM_MSG_BELL
   jp z, rc_01_output_hbios1_iterm_msg_bell

   ; prevent error generation for unimplemented optional messages

   cp ITERM_MSG_READLINE_BEGIN
   ret z
   
   cp ITERM_MSG_READLINE_END
   ret z

   jp console_01_output_terminal       ; forward to library
