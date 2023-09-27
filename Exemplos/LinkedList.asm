.data
head: .asciiz "\nhead -> "     # String indicando o início da lista
no1: .asciiz "\nNode 1(key) -> "    # String para o primeiro nó (chave)
no1Next: .asciiz "\nNode 1(next) -> "   # String para o primeiro nó (próximo)
no2: .asciiz "\nNode 2(key) -> "   # String para o segundo nó (chave)

.text
.globl main

main:
    # Inicialização do ponteiro para o primeiro nó da lista
    li $t0, 0
    la $s0, ($t0) # head

    # Alocando espaço na heap para o primeiro nó da lista
    li $a0, 8          # 8 bytes para armazenar um ponteiro e um valor inteiro
    li $v0, 9          # Código do serviço do sistema para alocação na heap
    syscall
    move $s1, $v0      # Armazenando o endereço do nó alocado na heap em $s1

    # Configurando o valor do primeiro nó da lista e seu ponteiro próximo
    li $t1, 42         # Valor a ser armazenado no nó
    sw $t1, ($s1)      # Armazenando o valor no endereço do nó alocado
    sw $t0, 4($s1)     # O ponteiro próximo do nó é nulo

    # Configurando o ponteiro para o primeiro nó da lista para apontar para o nó alocado
    move $s0, $s1 # head aponta para o 1o nó da lista

    # Alocando espaço na heap para um segundo nó da lista
    li $a0, 8
    li $v0, 9
    syscall
    move $s2, $v0

    # Configurando o valor do segundo nó da lista e seu ponteiro próximo
    li $t1, 123
    sw $t1, ($s2)
    sw $t0, 4($s2)

    # Configurando o ponteiro próximo do primeiro nó para apontar para o segundo nó
    sw $s2, 4($s1)
      
    # Imprimindo head
    li $v0, 4
    la $a0, head
    syscall
    
    # Imprimindo o endereço armazenado em head
    li $v0, 1
    move $a0, $s0
    syscall
    
    # Imprimindo a mensagem Node 1(key) ->
    li $v0, 4
    la $a0, no1
    syscall
    
    # Imprimindo a chave (key) do primeiro nó
    li $v0, 1
    lw $a0, ($s0)
    syscall

    # Imprimindo a mensagem Node 2(key) ->
    li $v0, 4
    la $a0, no2
    syscall
    
    lw $t5, 4($s0)
    
    # Imprimindo a chave (key) do segundo nó    
    li $v0, 1
    lw $a0, ($t5)
    syscall 

    # Encerrando o programa
    li $v0, 10
    syscall
