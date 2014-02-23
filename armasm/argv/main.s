
.data

LF: .string "\n"
 
.text

.global	_start
_start:
    pop     { r0 }
    b       printargv

printargv:
    pop     { r0 }
    tst     r0, r0
    beq     exit
    bl      echol
    b       printargv

echol:
    mov     ip, sp
    stmfd   sp!, {fp, ip, lr}
    sub     fp, ip, #4

    push    { r0 }
    bl      strlen
    pop     { r1 }    @ const void *buf = pop()
    mov     r2, r0    @ size_t count = strlen(r0)
    mov     r0, #1    @ int fd = 1 (stdout)
    mov     r7, #4    @ write() syscall
    swi     #0

    mov     r0, #1
    ldr     r1, =LF
    mov     r2, #1
    swi     #0


    ldmfd   sp, {fp, sp, lr}
    bx      lr

strlen:
    mov     r1, r0    @ counter
strlen_loop:
    ldrb    r2, [r1]
    tst     r2, r2
    beq     strlen_exit
    add     r1, r1, #1
    b       strlen_loop
strlen_exit:
    sub     r0, r1, r0
    bx      lr

exit:
    mov     r0, #0    @ int status = 0
    mov     r7, #1    @ _exit() syscall
    swi     #0

