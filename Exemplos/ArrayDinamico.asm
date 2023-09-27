#Este código em Assembly MIPS copia os elementos de um array estático para um array dinâmico alocado na heap. 
#Em seguida, imprime os elementos do array dinâmico com uma vírgula e espaço separando-os. 
#Ao final, desaloca a memória alocada e encerra o programa.

.data
v:         .word 10, 15, 20, 25, 30      # Array estático com valores iniciais: v[10,15,20,25,30]
size:      .word 5                       # Tamanho do array: 5 elementos
vir:       .asciiz ", "                  # String para imprimir uma vírgula e espaço
msg:       .asciiz "\nCopiando dados de um array estático para um array dinâmico (heap memory):\n"

.text

# Alocar memória na heap
li $v0, 9       # Chamada do sistema para alocar memória
li $a0, 20      # Solicitação de 20 Bytes de memória: 5 inteiros ocupam 20 Bytes
syscall

move $t2, $v0   # Salvar o endereço da memória alocada no heap ($v0) em t2
move $t6, $t2   # Auxiliar: copiar para $t6

la $t1, v       # Carregar o endereço do array estático em $t1
li $t0, 0       # Inicializar contador i=0
lw $t3, size    # Carregar o tamanho do array em $t3

# Laço para percorrer o array estático e copiar para o array dinâmico
loop:
    bge $t0, $t3, next   # Se i >= tamanho, ir para o próximo passo
    lw $t5, 0($t1)        # Obter elemento do array estático
    sw $t5, ($t2)        # Copiar para o array dinâmico
    addi $t1, $t1, 4    # Apontar para o próximo elemento do array estático (próxima palavra/endereço)
    addi $t2, $t2, 4    # Apontar para o próximo elemento do array dinâmico (próxima palavra/endereço)
    addi $t0, $t0, 1    # i++
    j loop

next:

li $v0,4
la $a0,msg
syscall

# Laço para percorrer o array dinâmico e imprimir os dados
li $t0, 0       # Reinicializar i=0
move $t2, $t6   # Resetar o ponteiro para o início do array dinâmico

loop_print:
    bge $t0, $t3, exit  # Se i >= tamanho, sair
    lw $t5, 0($t2)        # Obter elemento do array dinâmico
    move $a0, $t5       # Colocar o elemento em $a0 para imprimir
    li $v0, 1           # Chamada do sistema para imprimir inteiro
    syscall

    # Imprimir vírgula e espaço
    li $v0, 4
    la $a0, vir
    syscall

    addi $t2, $t2, 4    # Apontar para o próximo elemento do array dinâmico (próxima palavra/endereço)
    addi $t0, $t0, 1    # i++
    j loop_print

exit:
# Desalocar a alocação de 20 bytes: não está implementado no MARS o uso de valores negativos
#li $a0, -20
#li $v0, 9
#syscall

li $v0, 10
syscall
