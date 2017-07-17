         org 7C00h
 
         jmp short Start 
 
 Msg:    db "Booting system "
 EndMsg:
 
 Start:  mov bx, 000Fh   ; Page 0, 15=blanco
         mov cx, 1       ;
         xor dx, dx      ; clear dx
         mov ds, dx      ; clear ds
         cld             ; limpiar flag direccion
 
 Print:  mov si, Msg     ; 1er byte 
                         
 Char:   mov ah, 2       ; BIOS modo 2 int 10
         int 10h
         lodsb           
 
         mov ah, 9     
         int 10h

         inc dl          ; cursor++
 
         cmp dl, 80      
         jne Skip
         xor dl, dl
         inc dh
 
         cmp dh, 25
         jne Skip
         xor dh, dh
 
 Skip:   cmp si, EndMsg  ;bucle
         jne Char        ;si no ha acabado imprimer el siguiente caracter
         jmp Halt        ; si se ha acabado apagar
 
 Halt:
	 hlt ; apagar
 
 times 0200h - 2 - ($ - $$)  db 0    ; BOOTLOADER 510 BYTES
 
         dw 0AA55h       ; BOOTLOADER ID
 
 ;times 1474560 - ($ - $$) db 0 ; LLENAR 1'44 mbs 