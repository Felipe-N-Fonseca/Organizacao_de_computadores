.data
head: .asciiz "\nhead -> "     # String indicando o in�cio da lista
no1: .asciiz "\nNode 1(key) -> "    # String para o primeiro n� (chave)
no1Next: .asciiz "\nNode 1(next) -> "   # String para o primeiro n� (pr�ximo)
no2: .asciiz "\nNode 2(key) -> "   # String para o segundo n� (chave)

.text
.globl main

main:
    # Inicializa��o do ponteiro para o primeiro n� da lista
    li $t0, 0
    la $s0, ($t0) # head

    # Alocando espa�o na heap para o primeiro n� da lista
    li $a0, 8          # 8 bytes para armazenar um ponteiro e um valor inteiro
    li $v0, 9          # C�digo do servi�o do sistema para aloca��o na heap
    syscall
    move $s1, $v0      # Armazenando o endere�o do n� alocado na heap em $s1

    # Configurando o valor do primeiro n� da lista e seu ponteiro pr�ximo
    li $t1, 42         # Valor a ser armazenado no n�
    sw $t1, ($s1)      # Armazenando o valor no endere�o do n� alocado
    sw $t0, 4($s1)     # O ponteiro pr�ximo do n� � nulo

    # Configurando o ponteiro para o primeiro n� da lista para apontar para o n� alocado
    move $s0, $s1 # head aponta para o 1o n� da lista

    # Alocando espa�o na heap para um segundo n� da lista
    li $a0, 8
    li $v0, 9
    syscall
    move $s2, $v0

    # Configurando o valor do segundo n� da lista e seu ponteiro pr�ximo
    li $t1, 123
    sw $t1, ($s2)
    sw $t0, 4($s2)

    # Configurando o ponteiro pr�ximo do primeiro n� para apontar para o segundo n�
    sw $s2, 4($s1)
      
    # Imprimindo head
    li $v0, 4
    la $a0, head
    syscall
    
    # Imprimindo o endere�o armazenado em head
    li $v0, 1
    move $a0, $s0
    syscall
    
    # Imprimindo a mensagem Node 1(key) ->
    li $v0, 4
    la $a0, no1
    syscall
    
    # Imprimindo a chave (key) do primeiro n�
    li $v0, 1
    lw $a0, ($s0)
    syscall

    # Imprimindo a mensagem Node 2(key) ->
    li $v0, 4
    la $a0, no2
    syscall
    
    lw $t5, 4($s0)
    
    # Imprimindo a chave (key) do segundo n�    
    li $v0, 1
    lw $a0, ($t5)
    syscall 

    # Encerrando o programa
    li $v0, 10
    syscall
