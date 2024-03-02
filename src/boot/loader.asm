bits 16
org 0x7c00

main:
; -----------------------------------------------------------------------------
; Definição dos segmentos de dados...
; -----------------------------------------------------------------------------
    xor ax, ax      ; Registra 0x0000 em AX
    mov ds, ax      ; Segmento de Dados DS=AX=0x0000
    mov es, ax      ; Segmento de Dados ES=AX=0x0000
; -----------------------------------------------------------------------------
; Definição do topo da pilha...
; -----------------------------------------------------------------------------
    mov ss, ax      ; Segmento do endereçamento da pilha: SS=AX=0x0000
    mov sp, 0x7c00  ; Todos os 'push' serão endereçados a partir daqui
; -----------------------------------------------------------------------------
; Limpar a tela...
; -----------------------------------------------------------------------------
clr_screen:
    mov al, 0x03    ; AX=0x0003 = Modo texto VGA 80x25, char 9x16, 16 cores
    int 0x10
; -----------------------------------------------------------------------------
; Imprimir mensagem...
; -----------------------------------------------------------------------------
print_str:
    mov ah, 0x0e        ; Escrever caractere no TTY
    mov cx, pad - msg   ; Contador recebe tamanho da string
    mov si, msg         ; {si} recebe endereço da string
.char_loop:
    lodsb               ; Carrega byte corrente em {al} e incrementa o endereço
    int 0x10
    loop .char_loop     ; Repete e decrementa o contador
; -----------------------------------------------------------------------------
; Parada da CPU...
; -----------------------------------------------------------------------------
halt:
    cli                 ; Limpa a flag de interrupções
    hlt                 ; Para a CPU
; -----------------------------------------------------------------------------
; DATA
; -----------------------------------------------------------------------------
msg:
    db 'Loading OS...'

pad:
    times 510-($-$$) db 0

sig:
    dw 0xaa55