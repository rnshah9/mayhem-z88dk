#!/usr/bin/perl

# Z88DK Z80 Macro Assembler
#
# Copyright (C) Paulo Custodio, 2011-2018
# License: The Artistic License 2.0, http://www.perlfoundation.org/artistic_license_2_0
# Repository: https://github.com/z88dk/z88dk/
#
# Test macros

use strict;
use warnings;
use v5.10;
use Test::More;
require './t/testlib.pl';

unlink_testfiles();

z80asm(<<'END');
	nop
END
check_bin_file("test.bin", pack("C*", 0));

z80asm(<<'END');
#define nil 0
#UNDEF  nil
#undef  nil			; ignored
#define nil nop		; define macro
	nil
END
check_bin_file("test.bin", pack("C*", 0));

z80asm(<<'END');
#define label here
.label jp here
END
check_bin_file("test.bin", pack("C*", 0xC3, 0, 0));

z80asm(<<'END', "", 1, "", <<'ERR');
#define nil nop
#define nil nop
	nil
END
Error at file 'test.asm' line 2: macro 'nil' redefined
1 errors occurred during assembly
ERR

z80asm(<<'END', "", 1, "", <<'ERR');
#define .3 nop
#define 3 nop
END
Error at file 'test.asm' line 1: syntax error
Error at file 'test.asm' line 2: syntax error
2 errors occurred during assembly
ERR

z80asm(<<'END');
#DEFINE .one 1
#Define @two 2
#define #three 3
#define $four 4
#define %five 5
#define ._ 6
#define _ 7
defb .one, @two, #three, $four, %five, ._, _, ".one\'";comment
END
check_bin_file("test.bin", pack("C*", 1..7).".one'");

z80asm(<<'END');
#define set equ
one=1
 two    =    2
three  equ  3
four   Equ  4
five   EQU  5
six    set  6
defb one,two,three,four,five,six
END
check_bin_file("test.bin", pack("C*", 1..6));

unlink_testfiles();
done_testing();
