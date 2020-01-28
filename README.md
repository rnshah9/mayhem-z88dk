# Z88DK - The Development Kit for Z80 Computers

![WinXP+](doc/images/windows.png) ![MacOSX](doc/images/mac.png) ![Linux and Other](doc/images/linux.png) [![Build Status](https://travis-ci.org/z88dk/z88dk.svg?branch=master)](https://travis-ci.org/z88dk/z88dk)

Z88DK is a collection of software development tools that targets the 8080 and z80 family of machines.  It allows development of programs in C, assembly language or any mixture of the two.  What makes z88dk unique is its ease of use, built-in support for many z80 machines and its extensive set of assembly language library subroutines implementing the C standard and extensions.

## THE TOOLS

Many tools have a ` z88dk-` prefix to distinguish them from tools from other packages that may be installed with the same name. The documentation
generally omits the prefix when referring to them.

* **ZCC** is the toolchain's front end.  zcc can generate an output binary out of any set of input source files.
* **SCCZ80** is z88dk's native c compiler.   sccz80 is derived from small c but has seen much development to the point that it is nearly c90 compliant.
* **ZSDCC** is z88dk's customization of the [sdcc compiler](https://sourceforge.net/projects/sdcc/).  [Our patch](https://github.com/z88dk/z88dk/tree/master/src/zsdcc) makes sdcc compatible with the z88dk toolchain, gives it access to z88dk's extensive assembly language libraries and ready-made crts, addresses code generation bugs where present and improves on sdcc's generated code.
* **Z80ASM** (not to be confused with several external projects called z80asm) is a fully featured assembler / linker / librarian implementing sections.
* **Z80NM** is z80asm's companion archiver.  It can provide a listing of functions or data encoded in an object or library file.
* **APPMAKE** processes the raw binaries generated by the toolkit into a form suitable for specific target machines.  For example, it can generate intel hex files, tapes, ROMs, etc.
* **Z88DK-TICKS** is a command line z80 emulator that can be used to time execution speed of code fragments. Ticks includes a debugger and disassembler in addition to supporting some of the ZX Next Z80N extension instructions.
* **Z88DK-DIS** is a command line disassembler for Z80, Z180, Z80N and Rabbit 2000/3000. It can additionally read map files generated by z80asm to provide a more symbolic output.
* **Z88DK-LIB** is an installer for third party libraries.  It manages installation, removal and listing of available libraries.
* **Z88DK-ZX7** is a PC-side optimal lz77 data compression tool with companion decompression functions in the z80 library.
* **Z88DK-DZX7** is a PC-side decompressor counterpart to zx7.

These tools are not normally directly invoked by the user:

* **M4** acts as z88dk's macro preprocessor and can optionally process files ahead of the c preprocessor or assembler.
* **Z88DK-UCPP** is the c preprocessor invoked for sccz80.
* **ZSDCPP** is the c preprocessor invoked for zsdcc.
* **Z88DK-ZPRAGMA** is used by the toolchain to process pragmas embedded in c source.
* **Z88DK-COPT** is a regular expression engine that is used as peephole optimizer for sccz80 and as a post-processing tool for both sccz80 and zsdcc.

## BENCHMARKS

The assembly language libraries supplied by z88dk give it performance advantages over other z80 compilers.
(COMING)

* **Dhrystone 2.1**  Dhrystone was a common synthetic benchmark for measuring the integer performance of compilers in the 1980s until more modern benchmarks replaced it.  It attempts to simulate typical programs by executing a set of statements statistically determined from common programs.
* **Pi**  Mainly measures 32-bit integer performance.
* **Sieve of Eratosthenes**  Popular benchmark for small machine compilers because just about everything is able to compile it.  As a benchmark it doesn't reveal much more than loop overhead.
* **Whetstone 1.2**  Whetstone is a common synthetic floating point benchmark.
* **Program Size**  Program size has great importance for small machines.  A collection of test programs were compiled for the common cp/m target and resulting binary sizes were compared.

## INSTALLATION

There are three ways to install z88dk.

1. Use the [Most Recent Official Release](https://github.com/z88dk/z88dk/tree/github/Readme#most-recent-official-release) currently v1.99C dated 19 Jan 2019.  Follow these [installation instructions](https://github.com/z88dk/z88dk/wiki/installation).
2. Get the [Nightly Build](http://nightly.z88dk.org/).  Every night we build complete binary packages for windows and osx and generate source packages for everyone else.  The same [installation instructions](https://github.com/z88dk/z88dk/wiki/installation) apply.  Using a nightly build means you can keep up with bugfixes and new features rather than having to wait an entire year for a release to occur.
3. Use Github.  Using github will keep you up-to-date with the developers and will allow you to contribute to the project.  We do not store the z80 libraries or the binaries in the github repository.  Instead you will either have to build those things yourself or acquire them from the nightly build to have a working install.

The z88dk repository uses git submodules, these are not automatically downloaded by git by default so you will have to either adjust your clone line, or retrieve them manually. To clone with submodules use `git clone --recursive https://github.com/z88dk/z88dk.git`. To add the submodules to an already existing clone use `git submodule update --init --recursive`


1. **Installing the Z88DK Binaries**
	  * **Mac OSX** Download the nightly build for osx and copy the z88dk/bin directory to the same place in your z88dk tree.  If you would like to try building the binaries yourself, follow the Other instructions below.
	  * **Windows** Download the nightly build for win32 and copy the z88dk/bin directory to the same place in your z88dk tree.  You can also build the z88dk binaries yourself using the VS2015 solution found in z88dk/win32 however you should copy the nightly build initially so that various required dlls and some non-z88dk binaries are present.
	  * **Other** Build the binaries yourself by following these [instructions](https://www.z88dk.org/wiki/doku.php?id=temp:front#linux_unix).
2. **Installing the Classic Lib Z80 Libraries**  If you installed the z88dk binaries following the Other instructions in (I) you should have also built the classic z80 libraries.  You can confirm this by checking that z88dk/lib/clibs contains about 138 .lib files.  Otherwise you can following one of these two methods:
	  * **Copy the classic lib library files** from any nightly build by copying the z88dk/lib/clibs directory to the same place in your z88dk tree.
	  * **Build the classic lib library from source**  Building the classic lib from source requires unix-like tools so windows users will need to use msys or cygwin.  Aside from that the process is simple.  After setting the environment variables as detailed below, open a shell, cd to z88dk/libsrc and enter "make -i" then "make install" followed by "make clean".
3. **Installing the New Lib Z80 Libraries**  If you installed the z88dk binaries following the Other instructions in (I) you should have also built the new z80 libraries.  You can confirm this by checking that z88dk/libsrc/_DEVELOPMENT/lib contains six .lib files in each of the subdirectories.  Otherwise you can following one of these two methods:
	  * **Copy the new lib library files** from any nightly build by copying the z88dk/libsrc/_DEVELOPMENT/lib tree to the same place in your z88dk tree.
	  * **Build the new lib library files from source**  After setting the environment variables as detailed below, open a command prompt, cd to z88dk/libsrc/_DEVELOPMENT and enter "Winmake all" for windows or "make" for other platforms.

We do not maintain the zsdcc or zsdcpp source code in the repository.  Instead zsdcc is built separately from a [patched sdcc](https://github.com/z88dk/z88dk/tree/master/src/zsdcc).  We supply the zsdcc and zsdcpp binaries for win32 and osx in the nightly build so if you are using win32 or osx and you copied z88dk/bin, you will already have zsdcc and zsdcpp installed.  Other users will have to build the zsdcc binary by following these [instructions](https://www.z88dk.org/wiki/doku.php?id=temp:front#sdcc1).

The last step for installation is to set the ZCCCFG environment variable and your PATH appropriately.  You can find that information [here](https://github.com/z88dk/z88dk/wiki/installation).

To verify that the install was successful, try some test compiles from the examples directories in [z88dk/examples](https://github.com/z88dk/z88dk/tree/master/examples) (classic c lib) and [z88dk/libsrc/_DEVELOPMENT/EXAMPLES](https://github.com/z88dk/z88dk/tree/master/libsrc/_DEVELOPMENT/EXAMPLES) (new c lib).  Compile instructions most often appear as comments at the top of .c files.  Note that zsdcc compiles with optimization turned high can be slow.

## USING Z88DK

Unfortunately, like a lot of open source projects, we could use a lot of help with the documentation.

Some things to know:

* There are [two c compilers](https://www.z88dk.org/wiki/doku.php?id=temp:front#z88dk_supports_two_c_compilers) in z88dk.  Projects must be completely compiled with one compiler only.  Due to various [differences](https://www.z88dk.org/wiki/doku.php?id=temp:front#limitations) the object files generated by the two compilers are [not compatible](https://github.com/z88dk/z88dk/issues/15).
* There are [two c libraries](https://www.z88dk.org/wiki/doku.php?id=temp:front#z88dk_contains_two_independent_c_libraries) in z88dk.  These are referred to as the classic c library and the new c library.
* Thankfully there is only one assembler so we only need to deal with 2*2 combinations :)

When you form a compile line you must decide which compiler you will use and which c library you will link against.  You will make that decision based on which targets you want to compile for and what features you need.

The classic c library is z88dk's original c library and it has crts that allow generation of programs for [80+ different z80 machines](https://github.com/z88dk/z88dk/wiki/Platform).  The level of support for each is historically determined by user interest.  [Documentation begins here](https://github.com/z88dk/z88dk/wiki) and example programs can be found in [z88dk/examples](https://github.com/z88dk/z88dk/tree/master/examples) with compile lines most often appearing at the top of .c files.

The new c library is z88dk's rewrite aiming for a large subset of C11 conformance.  It directly supports eleven targets currently ([cpm](https://github.com/z88dk/z88dk/wiki/Platform---CPM), [embedded](https://www.z88dk.org/wiki/doku.php?id=libnew:target_embedded), [hbios](https://github.com/wwarthen/RomWBW/blob/master/Doc/RomWBW%20Architecture.pdf), [rc2014](https://rc2014.co.uk/), [scz180](https://smallcomputercentral.wordpress.com/sc130-z180-motherboard/), [sega master system](https://en.wikipedia.org/wiki/Master_System), [vgl](https://hackaday.io/project/166921-v-tech-genius-leader-precomputer-hacking), [yaz180](https://github.com/feilipu/yaz180), z180, [zx spectrum](https://en.wikipedia.org/wiki/ZX_Spectrum), and [zx spectrum next](https://www.specnext.com/)) but the [embedded target](https://www.z88dk.org/wiki/doku.php?id=libnew:target_embedded) can also be used to compile programs for any z80 machine.  [Documentation begins here](https://www.z88dk.org/wiki/doku.php?id=temp:front) and example programs can be found in [z88dk/libsrc/_DEVELOPMENT/EXAMPLES](https://github.com/z88dk/z88dk/tree/master/libsrc/_DEVELOPMENT/EXAMPLES) with compile lines most often appearing at the top of .c files.  The documentation for the [embedded target](https://www.z88dk.org/wiki/doku.php?id=libnew:target_embedded) gives an excellent overview of how the tools work.

## QUICK LINKS

[Z88DK Home Page](https://www.z88dk.org/forum/)
Includes a link to the nightly builds where you can get an up-to-date package.

[Install Instructions](https://github.com/z88dk/z88dk/wiki/installation)

[Forum for Questions](https://www.z88dk.org/forum/forums.php)

[Bug Reporting](https://github.com/z88dk/z88dk/issues)
(old bugs in the forum)

[Introduction to Compiling Using the Classic C Library](https://github.com/z88dk/z88dk/wiki)
Examples in [z88dk/examples](https://github.com/z88dk/z88dk/tree/master/examples)

[Introduction to Compiling Using the New C Library](https://www.z88dk.org/wiki/doku.php?id=temp:front)
Examples in [z88dk/libsrc/_DEVELOPMENT/EXAMPLES](https://github.com/z88dk/z88dk/tree/master/libsrc/_DEVELOPMENT/EXAMPLES)

[Compiling for Generic z80 Embedded Systems Using the New C Library](https://www.z88dk.org/wiki/doku.php?id=libnew:target_embedded)
For any z80 computer, embedded or not.

Using [z88dk with the rc2014](https://github.com/RC2014Z80/RC2014/wiki/Using-Z88DK), covers cpm, hbios, and rc2014 subtypes.

