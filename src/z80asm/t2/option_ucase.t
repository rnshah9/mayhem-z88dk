#!/usr/bin/env perl

BEGIN { use lib 't2'; require 'testlib.pl'; }

path("$test.asm")->spew(<<END);
SubRoutine: ret
Main:       call SubRoutine
END

# no -ucase
run_ok("./z88dk-z80asm -b -m $test.asm");

check_bin_file("$test.bin", bytes(0xc9, 0xcd, 0, 0));

check_txt_file("$test.map", <<END);
SubRoutine                      = \$0000 ; addr, local, , $test, , $test.asm:1
Main                            = \$0001 ; addr, local, , $test, , $test.asm:2
__head                          = \$0000 ; const, public, def, , ,
__tail                          = \$0004 ; const, public, def, , ,
__size                          = \$0004 ; const, public, def, , ,
END

capture_ok("z88dk-z80nm -a $test.o", <<END);
Object  file $test.o at \$0000: Z80RMF16
  Name: $test
  Section "": 4 bytes
    C \$0000: C9 CD 00 00
  Symbols:
    L A \$0000 SubRoutine (section "") (file $test.asm:1)
    L A \$0001 Main (section "") (file $test.asm:2)
  Expressions:
    E Cw \$0001 \$0002: SubRoutine (section "") (file $test.asm:2)
END

# with -ucase
run_ok("./z88dk-z80asm -b -m -ucase $test.asm");

check_bin_file("$test.bin", bytes(0xc9, 0xcd, 0, 0));

check_txt_file("$test.map", <<END);
SUBROUTINE                      = \$0000 ; addr, local, , $test, , $test.asm:1
MAIN                            = \$0001 ; addr, local, , $test, , $test.asm:2
__head                          = \$0000 ; const, public, def, , ,
__tail                          = \$0004 ; const, public, def, , ,
__size                          = \$0004 ; const, public, def, , ,
END

capture_ok("z88dk-z80nm -a $test.o", <<END);
Object  file $test.o at \$0000: Z80RMF16
  Name: $test
  Section "": 4 bytes
    C \$0000: C9 CD 00 00
  Symbols:
    L A \$0000 SUBROUTINE (section "") (file $test.asm:1)
    L A \$0001 MAIN (section "") (file $test.asm:2)
  Expressions:
    E Cw \$0001 \$0002: SUBROUTINE (section "") (file $test.asm:2)
END

unlink_testfiles;
done_testing;
