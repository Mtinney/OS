BITS 16
start:
   mov ax, 07C0h
   add ax, 288
   mov ss, ax
   mov sp, 4096
   mov ax, 07C0h
   mov ds, ax
mov si, boot_message call print_string
; Set up 4K stack space after this bootloader ; (4096 + 512) / 16 bytes per paragraph
; Set data segment to where we're loaded
; Put message string position into SI ; Call printing routine
jmp $
boot_message db 'Booting from floppy...', 0
cs_message db 'CS-DOS Operating System v1.0', 0
creating_message db 'Created for CS3423, Summer 2014', 0
copyright db '(C) Copyright 2014 by Matthew Tinney and Shade Alabsa. All rights reserved.', 0
; Jump here - infinite loop!
print_string: mov ah, 0Eh
.repeat:
   lodsb
   cmp al, 0
   je .done
   int 10h
   jmp .repeat
.done: ret
times 510-($-$$) db 0 dw 0xAA55
; Routine: output string in SI to screen ; 'print char' function is denoted by 0Eh
; load next byte from SI and increment SI. ; compare to zero to see if end of string. ; if char is zero, we’re at end of string. ; Otherwise, print it.
; fill remainder of boot sector with 0s up ; to byte 510.
; The standard PC boot signature of AA 55 ; is placed in bytes 511 and 512.