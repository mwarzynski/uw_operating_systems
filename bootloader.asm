USERNAME_MSG: db 'Type you username: '
BUFFER times 64 db 0


start:
    mov ax, cs
    mov ds, ax
    mov ex, ax
    mov ss, ax 
    mov sp, 0x8000

    mov al, 'H'
    call print_char

loop:
    jmp loop

print:
    ax         ; buffer
    xor cx, cx ; index
    .print_t
    mov bx, [ax + cx]

print_char:
    mov ah, 0xe
    int 0x10
    ret

times (510 - ($ - $$)) db 0;
dw 0xaa55
