#!/usr/bin/env perl

BEGIN { use lib 't2'; require 'testlib.pl'; }

# BUG_0024 : (ix+128) should show warning message
z80asm_ok("", "", <<END_WARN, 
$test.asm:1: warning: integer range: 0xff
  ^---- 255
END_WARN
		"inc (ix + 255)",		bytes(0xdd, 0x34, 0xff),
);

unlink_testfiles;
done_testing;
