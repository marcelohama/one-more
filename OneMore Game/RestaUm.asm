;=====================================;
; INICIA CASAS NULAS E VAZIA          ;
;=====================================;
jmp GRAFICO
INICIALIZA:
   mov byte [xaux],0			;; inicializa auxiliar da posi��o x
   mov byte [yaux],0			;; inicializa auxiliar da posi��o y
   mov byte [posx],8			;; inicia cursor X no meio do campo
   mov byte [posy],4			;; inicia cursor Y no meio do campo
   mov bx,campo				;; bx recebe o endere�o inicial do campo
   mov byte [bx+0],-1			;; casa 1 � nula
   mov byte [bx+8],-1			;; casa 2 � nula
   mov byte [bx+16],1			;; casa 3 � ocupada
   mov byte [bx+24],1			;; casa 4 � ocupada
   mov byte [bx+32],1			;; casa 5 � ocupada
   mov byte [bx+40],-1			;; casa 6 � nula
   mov byte [bx+48],-1			;; casa 7 � nula
   mov byte [bx+56],-1			;; casa 8 � nula
   mov byte [bx+64],-1			;; casa 9 � nula
   mov byte [bx+72],1			;; casa 10 � ocupada
   mov byte [bx+80],1			;; casa 11 � ocupada
   mov byte [bx+88],1			;; casa 12 � ocupada
   mov byte [bx+96],-1			;; casa 13 � nula
   mov byte [bx+104],-1			;; casa 14 � nula
   mov byte [bx+112],1			;; casa 15 � ocupada
   mov byte [bx+120],1			;; casa 16 � ocupada
   mov byte [bx+128],1			;; casa 17 � ocupada
   mov byte [bx+136],1			;; casa 18 � ocupada
   mov byte [bx+144],1			;; casa 19 � ocupada
   mov byte [bx+152],1			;; casa 20 � ocupada
   mov byte [bx+160],1			;; casa 21 � ocupada
   mov byte [bx+168],1			;; casa 22 � ocupada
   mov byte [bx+176],1			;; casa 23 � ocupada
   mov byte [bx+184],1			;; casa 24 � ocupada
   mov byte [bx+192],0			;; casa 25 � vazia
   mov byte [bx+200],1			;; casa 26 � ocupada
   mov byte [bx+208],1			;; casa 27 � ocupada
   mov byte [bx+216],1			;; casa 28 � ocupada
   mov byte [bx+224],1			;; casa 29 � ocupada
   mov byte [bx+232],1			;; casa 30 � ocupada
   mov byte [bx+240],1			;; casa 31 � ocupada
   mov byte [bx+248],1			;; casa 32 � ocupada
   mov byte [bx+256],1			;; casa 33 � ocupada
   mov byte [bx+264],1			;; casa 34 � ocupada
   mov byte [bx+272],1			;; casa 35 � ocupada
   mov byte [bx+280],-1			;; casa 36 � nula
   mov byte [bx+288],-1			;; casa 37 � nula
   mov byte [bx+296],1			;; casa 38 � ocupada
   mov byte [bx+304],1			;; casa 39 � ocupada
   mov byte [bx+312],1			;; casa 40 � ocupada
   mov byte [bx+320],-1			;; casa 41 � nula  
   mov byte [bx+328],-1			;; casa 42 � nula
   mov byte [bx+336],-1			;; casa 43 � nula
   mov byte [bx+344],-1			;; casa 44 � nula
   mov byte [bx+352],1			;; casa 45 � ocupada
   mov byte [bx+360],1			;; casa 46 � ocupada
   mov byte [bx+368],1			;; casa 47 � ocupada
   mov byte [bx+376],-1			;; casa 48 � nula
   mov byte [bx+384],-1			;; casa 49 � nula
   mov si,campo+192			;; si recebe o endere�o do cursor em campo
   jmp LEIA_CARACTER			;; come�a a ler as teclas

;=====================================================;
; N�CLEO DO PROGRAMA E C�LCULOS DE JOGADAS EXECUTADAS ;
;=====================================================;
VERIFICA_DISTANCIA:
   mov dx,[yaux]			;; dx recebendo a posi��o anterior de y
   sub dx,[posy]			;; subtraindo-se de dx a posi��o atual de y
   cmp dx,2				;; comparando se a diferen�a � 2
   jz .VERIFICA_DESTINO			;; caso sim, a dist�ncia est� correta
   cmp dx,-2				;; comparando a dist�ncia com -2
   jz .VERIFICA_DESTINO			;; caso sim, a dist�ncia est� correta
   mov dx,[xaux]			;; dx recebendo a posi��o anterior de x
   sub dx,[posx]			;; subtraindo-se de dx a posi��o atual de x
   cmp dx,4				;; comparando a dist�ncia com 4
   jz .VERIFICA_DESTINO			;; caso sim, a dist�ncia est� correta
   cmp dx,-4				;; comparando a dist�ncia com -4
   jz .VERIFICA_DESTINO			;; caso sim, a dist�ncia est� correta

   mov ax,[yaux]			;; move para ax a posi��o anterior de y
   cmp ax,[posy]			;; compara com a posi��o atual de y
   jz .CANCELA				;; caso a posi��o seja igual, permite a pr�xima compara��o
   jmp LEIA_CARACTER			;; caso n�o, volta a esperar entrada de teclado
.CANCELA:
   mov ax,[xaux]			;; move para ax a posi��o anterior de x
   cmp ax,[posx]			;; compara com a posi��o atual de x
   jz .OK				;; caso seja igual, a casa � a mesma e a jogada segue, cancelando-se a sele��o
   jmp LEIA_CARACTER			;; caso n�o, volta a esperar entrada de teclado

.VERIFICA_DESTINO:
   xor ax,ax				;; zera ax
   mov al,[posx]			;; move para al a posi��o atual de x
   sub al,2				;; subtrai-se 2 de al
   shl ax,1				;; desloca para a esquerda 1 bit de ax
   shl ax,1				;; desloca para a esquerda 1 bit de ax
   mov bx,ax				;; move o conte�do de ax para bx
   xor ax,ax				;; zera ax
   mov al,[posy]			;; move para al a posi��o atual de y
   sub ax,1				;; subtrai-se 1 de al
   mov cx,56				;; cx recebe 56
   mul cx				;; ax recebe a multiplica��o de ax por cx
   add bx,ax				;; adiciona em bx o conte�do de ax (obtendo o endere�o da casa)
   cmp byte [campo+bx],0		;; compara se a casa � logicamente vazia
   jz .VERIFICA_PULADA			;; caso seja, 
   jmp LEIA_CARACTER			;; n�o sendo satisfeitas as condi��es, volta

.VERIFICA_PULADA:
   xor ax,ax				;; verifica se a casa pulada � ocupada, para
   mov al,[xaux]			;; que seja poss�vel a jogada
   add al,[posx]			;; soma em al a posi��o atual de x
   shr al,1				;; desloca bit a bit para a direita (divide por 2)
   sub al,2				;; subtrai 2 de al
   shl al,1				;; desloca bit a bit para a esquerda (multiplica por 2)
   shl al,1				;; desloca bit a bit para a esquerda (multiplica por 2)
   xor bx,bx				;; zerando o bx para poder receber o valor correto
   mov bx,ax				;; movendo para bx o conte�do de ax
   xor ax,ax				;; zera ax
   mov al,[yaux]			;; move para al a posi��o anterior de y
   add al,[posy]			;; adiciona a al a posi��o atual de y
   shr al,1				;; desloca bit a bit para a direita (divide por 2)
   sub al,1				;; subtrai 1 de al
   mov cx,56				;; move para cx o valor 56
   mul cx				;; multiplica ax por cx e guarda em ax
   add bx,ax				;; adiciona em bx o valor de ax (obtendo o endere�o da casa)
   cmp byte [campo+bx],1		;; compara se a casa � logicamente ocupada
   jz .OK				;; caso sim, a jogada pode ser executada (todas as condi��es satisfeitas)
   jmp LEIA_CARACTER			;; n�o sendo satisfeitas as condi��es, volta
.OK:
   mov ah,2				;; move para ah o valor 2 (mudan�a de cursor)
   mov bh,0				;; move para bh o valor 0 (p�gina)
   mov dh,[yaux]			;; move para dh a posi��o y a ser movido o cursor
   mov dl,[xaux]			;; move para dl a posi��o x a ser movido o cursor
   int 0x10				;; chama a interrup��o e move o cursor
   mov ah,9				;; move para ah o valor 9 (impress�o de caracter)
   mov al,32				;; move para al o valor 32 (caracter)
   mov bh,0				;; move para bh o valor 0 (p�gina)
   mov bl,0x0C				;; move para bl o valor 0x0C (cor de letra e fundo)
   mov cx,1				;; move para cx o valor 1 (n�mero de vezes)
   int 0x10				;; chama a interrup��o e seta o espa�o da posi��o antiga como vazio

   xor ax,ax				;; zera ax
   mov al,[xaux]			;; move para al a posi��o anterior de x
   sub al,2				;; subtrai 2 de al
   shl ax,1				;; multiplica o conte�do de ax por 2
   shl ax,1				;; multiplica o conte�do de ax por 2
   mov bx,ax				;; guarda em bx o valor de ax
   xor ax,ax				;; zera ax
   mov al,[yaux]			;; move em al a posi��o anterior de y
   sub ax,1				;; subtrai 1 de al
   mov cx,56				;; cx recebe 56
   mul cx				;; multiplica ax por cx e coloca em ax
   add bx,ax				;; adiciona o valor de ax em bx (obtendo o endere�o da casa)
   mov byte [campo+bx],0		;; coloca no conte�do da casa o valor 0

   mov ax,[xaux]			;; coloca em ax a posi��o anterior de x
   mov bx,[posx]			;; coloca em bx a posi��o anterior de y
   cmp ax,bx				;; compara as posi��es
   jz .mesmaLinha			;; pulo da condi��o de mesma linha
   jmp .mesmaColuna			;; pulo da condi��o de mesma coluna ou diagonal
.mesmaLinha:				;; 
   mov ax,[yaux]			;; coloca em ax a posi��o anterior de y
   add ax,[posy]			;; adiciona em ax a posi��o atual de y
   shr ax,1				;; divide ax por 2, obtendo a casa do meio
   mov [yaux],ax			;; coloca em yaux a posi��o y da casa pulada
   jmp .executa				;; obtidas as posi��es da casa pulada, segue para a execu��o
.mesmaColuna				;; 
   mov ax,[xaux]			;; coloca em ax a posi��o anterior de x
   add ax,[posx]			;; adiciona em ax a posi��o atual de x
   shr ax,1				;; divide ax por 2, obtendo a casa do meio
   mov [xaux],ax			;; coloca em xaux a posi��o x da casa pulada

.executa
   mov ah,2				;; coloca 2 em ah (mudan�a de cursor)
   mov bh,0				;; coloca 0 em bh (p�gina)
   mov dh,[yaux]			;; coloca em dh a posi��o y do cursor
   mov dl,[xaux]			;; coloca em dl a posi��o x do cursor
   int 0x10				;; chama a interrup��o e muda o cursor
   mov ah,9				;; coloca 9 em ah (impress�o de caracter)
   mov al,32				;; coloca 32 em al (espa�o em branco)
   mov bh,0				;; coloca 0 em bh (p�gina)
   mov bl,0x0C				;; coloca 0x0C em bl (cor de fundo e texto)
   mov cx,1				;; coloca 1 em CX (n�mero de vezes)
   int 0x10				;; chama a interrup��o e imprime um caracter em branco

   xor ax,ax				;; zera ax
   mov al,[xaux]			;; move a posi��o anterior de x para al
   sub al,2				;; subtrai 2 de al
   shl ax,1				;; desloca os 1 bit para a esquerda
   shl ax,1				;; desloca os 1 bit para a esquerda
   mov bx,ax				;; coloca o conte�do de ax em bx
   xor ax,ax				;; zera ax
   mov al,[yaux]			;; coloca em al a posi��o y anterior
   sub ax,1				;; subtrai 1 de ax
   mov cx,56				;; coloca 56 em cx
   mul cx				;; multiplica ax por cx e coloca em ax
   add bx,ax				;; adiciona em bx o conte�do de ax (obtendo o endere�o da casa pulada)
   mov byte [campo+bx],0		;; coloca 0 no conte�do da casa pulada

   mov ah,2				;; coloca 2 em ah (mudan�a de cursor)
   mov bh,0				;; coloca 0 em bh (p�gina)
   mov dh,[posy]			;; coloca em dh a posi��o y do cursor
   mov dl,[posx]			;; coloca em dl a posi��o x do cursor
   int 0x10				;; chama a interrup��o e muda o cursor
   mov ah,9				;; coloca 9 em ah (impress�o de caracter)
   mov al,2				;; coloca 2 em al (carinha de sorriso)
   mov bh,0				;; coloca 0 em bh (p�gina)
   mov bl,0x0C				;; coloca 0x0C em bl (cor de fundo e texto)
   mov cx,1				;; coloca 1 em CX (n�mero de vezes)
   int 0x10				;; chama a interrup��o e imprime um caracter em branco

   xor ax,ax				;; zera ax
   mov al,[posx]			;; move a posi��o anterior de x para al
   sub al,2				;; subtrai 2 de al
   shl ax,1				;; desloca os 1 bit para a esquerda
   shl ax,1				;; desloca os 1 bit para a esquerda
   mov bx,ax				;; coloca o conte�do de ax em bx
   xor ax,ax				;; zera ax
   mov al,[posy]			;; coloca em al a posi��o y anterior
   sub ax,1				;; subtrai 1 de ax
   mov cx,56				;; coloca 56 em cx
   mul cx				;; multiplica ax por cx e coloca em ax
   add bx,ax				;; adiciona em bx o conte�do de ax (obtendo o endere�o da casa destino)
   mov byte [campo+bx],1		;; coloca 1 no conte�do da casa destino

   mov byte [xaux],0			;; reseta a vari�vel auxiliar
   jmp LEIA_CARACTER			;; continua lendo caracteres

;========================================================;
; MANIPULA��O DE IMPUT/OUTPUT E A��ES DE TECLADO E V�DEO ;
;========================================================;
LEIA_CARACTER:
   mov ah,2				;; servi�o de mundan�a de cursor
   mov bh,0				;; p�gina
   mov dh,[posy]			;; seta linha
   mov dl,[posx]			;; seta coluna
   int 0x10				;; interrup��o de v�deo
   mov ah,8				;; setando o servi�o 8 de stdin sem echo
   int 0x21				;; chamando a interrup��o
   cmp al,0				;; comparando com uma tecla especial
   jz CARACTER_ESPECIAL			;; se for especial, pula para normal
   cmp al,27				;; compara esc com 27 (esc)
   jz FINALIZA				;; caso seja 27, finaliza o programa
   cmp al,32				;; compara o caracter com 32 (space)
   jz OPERACAO				;; caso seja space, executa jogada
   jmp LEIA_CARACTER			;; continua lendo caracteres caso seja outro caracter
CARACTER_ESPECIAL:
   mov ah,8				;; setando o servi�o 8 de stdin sem echo
   int 0x21				;; chamando a interrup��o novamente p/ captura
   cmp al,72				;; compara o caracter com 72 (cima)
   jz CIMA				;; caso sim, executa o respectivo comando
   cmp al,80				;; compara o caracter com 80 (baixo)
   jz BAIXO				;; caso sim, executa o respectivo comando
   cmp al,75				;; compara o caracter com 75 (esquerda)
   jz ESQUERDA				;; caso sim, executa o respectivo comando
   cmp al,77				;; compara o caracter com 77 (direita)
   jnz .prox				;; caso n�o seja, pula para .prox
   jmp DIREITA				;; caso sim, executa o respectivo comando
.prox:
   jmp LEIA_CARACTER			;; volta a esperar o teclado

OPERACAO:
   cmp byte [xaux],0			;; verifica se a casa ainda n�o est� selecionada
   jz  .SELECIONANDO			;; caso n�o, pula para .SELECIONANDO
   jmp VERIFICA_DISTANCIA		;; caso sim, executa jogadas
.SELECIONANDO:
   cmp byte [si],1			;; verifica se a casa � ocupada
   jnz LEIA_CARACTER			;; se for casa vazia, apenas volta
   mov ax,[posx]			;; ax recebe o valor x da casa
   mov [xaux],ax			;; salva a posi��o x da casa
   mov ax,[posy]			;; ax recebe o valor y da casa
   mov [yaux],ax			;; salva a posi��o y da casa
   mov ah,9				;; servi�o de impress�o de caracter
   mov al,2				;; caracter a ser escrito
   mov bh,0				;; p�gina de exibi��o
   mov bl,0x0A				;; cor e fundo
   mov cx,1				;; quantia de vezes
   int 0x10				;; chamada da interrup��o
   jmp LEIA_CARACTER			;; continua lendo caracteres
FINALIZA:
   mov ax,0x4C00			;; seta o servi�o de finaliza��o de programa
   int 0x21				;; chamando a interrup��o
CIMA:
   cmp byte [posy],1			;; verifica se j� est� no limite
   jz LEIA_CARACTER			;; caso sim, apenas retorna
   cmp byte [si-56],-1			;; verifica se a casa � v�lida
   jz LEIA_CARACTER			;; caso n�o, volta a ler caracteres
   dec byte [posy]			;; decrementa cursor Y
   sub si,56				;; decrementa o �ndice da casa em 7
   jmp LEIA_CARACTER			;; continua lendo caracteres
BAIXO:
   cmp byte [posy],7			;; verifica se j� est� no limite
   jz LEIA_CARACTER			;; se sim, apenas retorna
   cmp byte [si+56],-1			;; verifica se a casa � v�lida
   jz LEIA_CARACTER			;; caso n�o, volta a ler caracteres
   inc byte [posy]			;; incrementa cursor Y
   add si,56				;; incrementa o �ndice da casa em 7
   jmp LEIA_CARACTER			;; continua lendo caracteres
ESQUERDA:
   cmp byte [posx],2			;; verifica se j� est� no limite
   jz LEIA_CARACTER			;; se sim, apenas retorna
   cmp byte [si-8],-1			;; verifica se a casa � v�lida
   jz LEIA_CARACTER			;; caso n�o, volta a ler caracteres
   sub byte [posx],2			;; decrementa cursor X
   sub si,8				;; decrementa o �ndice da casa
   jmp LEIA_CARACTER			;; continua lendo caracteres
DIREITA:
   cmp byte [posx],14			;; verifica se j� est� no limite
   jz LEIA_CARACTER			;; se sim, apenas retorna
   cmp byte [si+8],-1			;; verifica se a casa � v�lida
   jz LEIA_CARACTER			;; caso n�o, volta a ler caracteres
   add byte [posx],2			;; incrementa cursor X
   add si,8				;; incrementa o �ndice da casa
   jmp LEIA_CARACTER			;; continua lendo caracteres

;=====================================;
; IMPLEMENTA��O DA INTERFACE GR�FICA  ;
;=====================================;
GRAFICO:
; borda superior do campo
   mov ah,2				;; servi�o de mudan�a de cursor
   mov bh,0				;; p�gina
   mov dh,0				;; seta linha
   mov dl,0				;; seta coluna
   int 0x10				;; interrup��o de v�deo
   mov ah,9				;; servi�o de impress�o de caracter
   mov al,201				;; caracter a ser escrito
   mov bh,0				;; p�gina de exibi��o
   mov bl,0x0F				;; cor e fundo
   mov cx,1				;; quantia de vezes
   int 0x10				;; chamada da interrup��o
   mov ah,2
   mov bh,0
   mov dh,0
   mov dl,1
   int 0x10
   mov ah,9
   mov al,205
   mov bh,0
   mov bl,0x0F
   mov cx,16
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,0
   mov dl,16
   int 0x10
   mov ah,9
   mov al,187
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,0
   int 0x10
; primeira linha do campo
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,2
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,4
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,6
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,8
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,10
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,12
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,14
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,1
   mov dl,16
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,2
   mov dl,0
   int 0x10
; segunda linha do campo
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,2
   mov dl,2
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,2
   mov dl,4
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,2
   mov dl,6
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,2
   mov dl,8
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,2
   mov dl,10
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,2
   mov dl,12
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,2
   mov dl,14
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,2
   mov dl,16
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
; terceira linha do campo
   mov ah,2
   mov bh,0
   mov dh,3
   mov dl,0
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,3
   mov dl,2
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,3
   mov dl,4
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,3
   mov dl,6
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,3
   mov dl,8
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,3
   mov dl,10
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,3
   mov dl,12
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,3
   mov dl,14
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,3
   mov dl,16
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
; quarta linha do campo
   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,0
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,2
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,4
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,6
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,10
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,12
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,14
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,4
   mov dl,16
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
; quinta linha do campo
   mov ah,2
   mov bh,0
   mov dh,5
   mov dl,0
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,5
   mov dl,2
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,5
   mov dl,4
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,5
   mov dl,6
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,5
   mov dl,8
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,5
   mov dl,10
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,5
   mov dl,12
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,5
   mov dl,14
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,5
   mov dl,16
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
; sexta linha do campo
   mov ah,2
   mov bh,0
   mov dh,6
   mov dl,0
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,6
   mov dl,2
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,6
   mov dl,4
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,6
   mov dl,6
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,6
   mov dl,8
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,6
   mov dl,10
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,6
   mov dl,12
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,6
   mov dl,14
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,6
   mov dl,16
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
; s�tima linha do campo
   mov ah,2
   mov bh,0
   mov dh,7
   mov dl,0
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,7
   mov dl,2
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,7
   mov dl,4
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,7
   mov dl,6
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,7
   mov dl,8
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,7
   mov dl,10
   int 0x10
   mov ah,9
   mov al,2
   mov bh,0
   mov bl,0x0C
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,7
   mov dl,12
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,7
   mov dl,14
   int 0x10
   mov ah,9
   mov al,254
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,7
   mov dl,16
   int 0x10
   mov ah,9
   mov al,186
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
; borda inferior do campo
   mov ah,2
   mov bh,0
   mov dh,8
   mov dl,0
   int 0x10
   mov ah,9
   mov al,200
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,8
   mov dl,1
   int 0x10
   mov ah,9
   mov al,205
   mov bh,0
   mov bl,0x0F
   mov cx,15
   int 0x10
   mov ah,2
   mov bh,0
   mov dh,8
   mov dl,16
   int 0x10
   mov ah,9
   mov al,188
   mov bh,0
   mov bl,0x0F
   mov cx,1
   int 0x10
jmp INICIALIZA

;=====================================;
; DEFINI��O DO CAMPO E VARI�VEIS      ;
;=====================================;
   campo resb 392			;; campo definido como 7x7
   posx resb 1				;; inicia no centro
   posy resb 1				;; inicia no centro
   xaux resb 1				;; vari�vel auxiliar da posi��o x
   yaux resb 1				;; vari�vel auxiliar da posi��o y