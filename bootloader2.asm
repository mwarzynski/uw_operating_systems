org 0x7a00

start:
    mov ah, 0x02
    mov al, 1      ; sectors to read count (sector = 512b)
    mov ch, 0      ; cylinder
    mov dh, 0      ; head
    mov cl, 2      ; sector
    mov dl, 0x80   ; drive
    mov bx, 0x7c00 ; buffer address pointer 
    int 0x13       ; do the interupt
    
    jmp 0x7c00
