; ----------------------------------------------------------------------------------------
; Writes "Hello, World" to the console using only system calls. Runs on 64-bit Linux only.
; To assemble and run:
;
;     nasm -felf64 hello.asm && ld hello.o && ./a.out
; ----------------------------------------------------------------------------------------

;https://thevivekpandey.github.io/posts/2017-09-25-linux-system-calls.html

          global    _start

          section   .text
_start:   call      read_int                ; read a digit from 0 to 9 and store it in AL
          mov       ax, dx
          call      print_int               ; print a digit from AL to console

          mov       rax, 60                 ; system call for exit
          xor       rdi, rdi                ; exit code 0
          syscall                           ; invoke operating system to exit

; Read a single char from stdin and save it to buf
read_char: push     rax
          push      rdi
          push      rsi
          push      rdx
          mov       rax, 0                  ; system call for read
          mov       rdi, 1                  ; file handle 1 is stdin
          mov       rsi, buf                ; address of string to output
          mov       rdx, 1                  ; number of bytes
          syscall                           ; invoke operating system to read
          pop       rdx
          pop       rsi
          pop       rdi
          pop       rax
          ret

; Print a char from buf to stdin
print_char: push    rdi
          push      rsi
          push      rdx
          mov       rax, 1                  ; system call for write
          mov       rdi, 1                  ; file handle 1 is stdout
          mov       rsi, buf                ; address of string to output
          mov       rdx, 1                  ; number of bytes
          syscall                           ; invoke operating system to do the write
          pop       rdx
          pop       rsi
          pop       rdi
          ret


; Read a whole number and store it in CX
read_int: mov       ax, 1                   ; multiplier
read_int_loop: call read_char               ; read a digit
          mov       bl, [buf]               ; copy the digit to bl
          sub       bl, 0x30                ; convert to integer
          js        read_int_ret            ; ' ' and CR values are lower than ascii digits. if sign, return the number
          mov       [buf], bl
          call print_char
          mul       bx                      ; multiply ax <- ax * bx
          add       dx, ax                  ; add the new digit to the output dx
          mov       cx, 10                  ; increment the multiplier
          mul       cx
          jmp       read_int_loop
read_int_ret: ret

print_int: push     rdi
          push      rsi
          push      rdx
          ; add       al, 0x30                ; convert to ASCII
          ; mov       [buf], al               ; take the value from al and copy to memory
          mov       rax, 1                  ; system call for write
          mov       rdi, 1                  ; file handle 1 is stdout
          mov       rsi, buf                ; address of string to output
          mov       rdx, 1                  ; number of bytes
          syscall                           ; invoke operating system to do the write
          pop       rdx
          pop       rsi
          pop       rdi
          ret

        ;   section   .data
; message:  db        "Hello, World", 10      ; note the newline at the end

          section   .bss
buf:      resb      1                       ; reserve 1 byte for buffer
