org 0x7c00

start:
    mov ax, cs
    mov ds, ax
    mov es, ax
    mov ss, ax 
    mov sp, 0x8000

    ; print out PROMPT_MSG - Enter your name
    mov ax, PROMPT_MSG
    call print

    ; read valid username from input
    call prompt_username

    ; TODO: Po zaakceptowaniu imienia na ekranie maszyny wyświetla się napis "Hello $name\r\n".
    ; TODO: Po upływie 2 sekund zostaje uruchomiony oryginalny bootloader (z oryginalnego obrazu MINIX-a).

    ; copy original and second bootloader to RAM
    ; 0x7c00 - first
    ; 0x7a00 - second
    ; 0x7800 - original
    call load_bootloaders ; copy bootloaders to RAM
    jmp 0x7a00            ; jump to second bootloader

load_bootloaders:
    mov ah, 0x02
    mov ch, 0      ; cylinder
    mov dh, 0      ; head
    mov dl, 0x80   ; drive
    mov cl, 2      ; sector (first sector was already loaded)
    mov al, 2      ; sectors to read (sector = 512b)
    mov bx, 0x7800 ; buffer address pointer 
    int 0x13       ; do the interupt (reading sectors)
    ret

prompt_username:
    push bx
    xor bx, bx

    .prompt_start:
    ; get character from input
    mov ah, 0x00
    int 0x16

    ; check if backspace
    cmp al, 0x08
    je .prompt_backspace

    ; check if enter
    cmp al, 0x0d
    je .prompt_enter

    ; check if index is too long
    cmp bx, 11
    jg .prompt_start

    xor cx, cx
    mov cl, al
    mov [BUFFER + bx], cx
    inc bx

    call print_char
    jmp .prompt_start

    .prompt_backspace:
    cmp bx, 1
    jl .prompt_start
    ; remove last character
    call print_char ; backspace
    mov al, 0x20
    call print_char ; print space
    mov al, 0x08
    call print_char ; backspace

    ; save empty character (space)
    xor cx, cx
    mov cl, 0x20
    mov [BUFFER + bx], cx
    dec bx 
    jmp .prompt_start

    .prompt_enter:
    cmp bx, 3
    jl .prompt_start

    xor cx, cx
    mov cl, 0x0

    .prompt_bsave:
    cmp bx, 15
    je .prompt_save
    mov [BUFFER + bx], cl
    inc bx
    jmp .prompt_bsave

    .prompt_save:
    ; save name to disk
    mov ah, 0x03
    mov al, 1
    mov ch, 0
    mov cl, 4
    mov dh, 0
    mov dl, 0x80
    mov bx, BUFFER
    int 0x13

    pop bx
    ret

print:
    mov bx, ax
    .print_text:
    mov al, byte [bx]
    test al, al
    je .print_ret
    call print_char
    inc bx
    jmp .print_text
    .print_ret:
    ret
    
print_char:
    mov ah, 0xe
    int 0x10
    ret

PROMPT_MSG: db 'Enter your name', 0xd, 0xa, 0x0
BUFFER: times 15 db 0
