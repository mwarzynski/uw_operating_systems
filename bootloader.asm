org 0x7c00

start:
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax 
    mov sp, 0x8000

    mov ax, PROMPT_MSG
    call print


    call load_sector
    ; 0x7800 original bootloader
    ; 0x7a00 second   bootloader
    ; 0x7c00 first    bootloader
    jmp 0x7a00

load_sector:
    mov ah, 0x02
    mov al, 2      ; sectors to read count (sector = 512b)
    mov ch, 0      ; cylinder
    mov dh, 0      ; head
    mov cl, 2      ; sector
    mov dl, 0x80   ; drive
    mov bx, 0x7800 ; buffer address pointer 
    int 0x13       ; do the interupt
    ret

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

PROMPT_MSG: db 'Enter your name', 0xd, 0xa, 0x0
