argv
====

This program is written in armv6 assembler for Linux. It prints out command line
arguments separated by newline characters, including the program name. The
included Makefile uses qemu and an armv6-targeted `as` to allow for
compilation/execution on a x86_64 host.

# requirements to run on x86_64
- `qemu-arm`
- `as` with armv6 target
- (optional) `gdb` with armv6 target for debugging

It may be necessary to change the executable names in the Makefile to match
the local system binaries.

# running
    make run
    # to run with arguments, copy the output and append desired arguments

# debugging
    make debug
    gdb argv # in another terminal
    (gdb) target remote localhost:9000
    (gdb) disas

# resources
inspired by:
http://www.elliotbradbury.com/x86-assembly-string-length-command-line-arguments

ARM Reference:
http://ozark.hendrix.edu/~burch/cs/230/arm-ref.pdf

Writing ARM Assembler Language:
http://infocenter.arm.com/help/topic/com.arm.doc.dui0204j/DUI0204J_rvct_assembler_guide.pdf

ARM Procedure Call Standard:
http://infocenter.arm.com/help/topic/com.arm.doc.ihi0042e/IHI0042E_aapcs.pdf

ARM EABI: new syscall entry convention:
http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=3105/4

syscall numbers (for me) found in:
/usr/armv6j-hardfloat-linux-gnueabi/usr/include/asm/unistd.h

