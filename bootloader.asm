
start:
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax 
    mov sp, 0x8000

    mov ax, USERNAME_MSG
    call print

loop:
    jmp loop

print:
    mov bx, ax

print_text:
    mov al, byte [bx]
    test al, al
    je print_ret
    call print_char
    inc bx
    jmp print_text

print_ret:
    ret

print_char:
    mov ah, 0xe
    int 0x10
    ret

USERNAME_MSG: db 'Type you username: '

times (510 - ($ - $$)) db 0;
dw 0xaa55
