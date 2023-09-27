#Este c�digo em Assembly MIPS copia os elementos de um array est�tico para um array din�mico alocado na heap. 
#Em seguida, imprime os elementos do array din�mico com uma v�rgula e espa�o separando-os. 
#Ao final, desaloca a mem�ria alocada e encerra o programa.

.data
v:         .word 10, 15, 20, 25, 30      # Array est�tico com valores iniciais: v[10,15,20,25,30]
size:      .word 5                       # Tamanho do array: 5 elementos
vir:       .asciiz ", "                  # String para imprimir uma v�rgula e espa�o
msg:       .asciiz "\nCopiando dados de um array est�tico para um array din�mico (heap memory):\n"

.text

# Alocar mem�ria na heap
li $v0, 9       # Chamada do sistema para alocar mem�ria
li $a0, 20      # Solicita��o de 20 Bytes de mem�ria: 5 inteiros ocupam 20 Bytes
syscall

move $t2, $v0   # Salvar o endere�o da mem�ria alocada no heap ($v0) em t2
move $t6, $t2   # Auxiliar: copiar para $t6

la $t1, v       # Carregar o endere�o do array est�tico em $t1
li $t0, 0       # Inicializar contador i=0
lw $t3, size    # Carregar o tamanho do array em $t3

# La�o para percorrer o array est�tico e copiar para o array din�mico
loop:
    bge $t0, $t3, next   # Se i >= tamanho, ir para o pr�ximo passo
    lw $t5, 0($t1)        # Obter elemento do array est�tico
    sw $t5, ($t2)        # Copiar para o array din�mico
    addi $t1, $t1, 4    # Apontar para o pr�ximo elemento do array est�tico (pr�xima palavra/endere�o)
    addi $t2, $t2, 4    # Apontar para o pr�ximo elemento do array din�mico (pr�xima palavra/endere�o)
    addi $t0, $t0, 1    # i++
    j loop

next:

li $v0,4
la $a0,msg
syscall

# La�o para percorrer o array din�mico e imprimir os dados
li $t0, 0       # Reinicializar i=0
move $t2, $t6   # Resetar o ponteiro para o in�cio do array din�mico

loop_print:
    bge $t0, $t3, exit  # Se i >= tamanho, sair
    lw $t5, 0($t2)        # Obter elemento do array din�mico
    move $a0, $t5       # Colocar o elemento em $a0 para imprimir
    li $v0, 1           # Chamada do sistema para imprimir inteiro
    syscall

    # Imprimir v�rgula e espa�o
    li $v0, 4
    la $a0, vir
    syscall

    addi $t2, $t2, 4    # Apontar para o pr�ximo elemento do array din�mico (pr�xima palavra/endere�o)
    addi $t0, $t0, 1    # i++
    j loop_print

exit:
# Desalocar a aloca��o de 20 bytes: n�o est� implementado no MARS o uso de valores negativos
#li $a0, -20
#li $v0, 9
#syscall

li $v0, 10
syscall
