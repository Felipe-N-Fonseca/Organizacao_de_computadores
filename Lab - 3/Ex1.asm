.data 

	vetor: .word 2, -5, 12, 7, -3, 99, 8, 54, 21, -45, 67, 61, 55
	tamanho: .word 13 
	colchete: .asciiz  "]\n"
	virgula: .asciiz ", "
	saidaA: .asciiz "O vetor original é: ["
	saidaB: .asciiz "O maior elemento do vetor é: "
	saidaC: .asciiz "\nO menor elemento do vetor é: "
	saidaD: .asciiz "\nA média dos elementos do vetor é: "
	saidaE: .asciiz "\nDigite um número: "
	encontrado: .asciiz "Número encontrado no vetor"
	naoEncontrado: .asciiz "Número não encontrado no vetor"
	
.text
	j main
	
	imprime_original: #  Imprimir o vetor original
	
	li $v0, 4
	la $a0, saidaA
	Syscall
	
	move $t9, $ra
	jal carrega # carrega o vetor ($s0) e tamanho ($t0)
	
	li $v0, 1
	lw $a0, 0($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 4($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 8($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 12($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 16($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 20($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 24($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 28($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 32($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 36($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 40($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 44($s0)
	Syscall
	
	li $v0, 4
	la $a0, virgula
	Syscall
	
	li $v0, 1
	lw $a0, 48($s0)
	Syscall
	
	li $v0, 4
	la $a0, colchete
	Syscall
	
	jr $t9
	
	
	imprime_maior: # Encontrar e imprimir o maior elemento dentro do vetor
	
	move $t9, $ra
	jal carrega # carrega o vetor ($s0) e tamanho ($t0)
	
	lw $t3, 0($s0)
	
	# while( $t1 < tamanho )
	while_01:
	addi $s0, $s0, 4
	lw $t2, 0($s0)
	bge $t3, $t2, final_while01
	
	move $t3, $t2
	
	final_while01:
	addi $t1, $t1, 1
	blt $t1, $t0, while_01
	
	li $v0, 4
	la $a0, saidaB
	Syscall
	
	li $v0, 1
	move $a0, $t3
	Syscall
	
	jr $t9
	
	
	imprime_menor: # Encontrar e imprimir o menor elemento dentro do vetor
	
	move $t9, $ra
	jal carrega # carrega o vetor ($s0) e tamanho ($t0)
	
	jr $t9
	
	imprime_media: # Calcular e imprimir a média dos elementos do vetor
	
	move $t9, $ra
	jal carrega # carrega o vetor ($s0) e tamanho ($t0)
	
	jr $t9
	
	verifica_elemento: # Verificar se um elemento está presente no vetor
	
	move $t9, $ra
	jal carrega # carrega o vetor ($s0) e tamanho ($t0)
	
	
	jr $t9
	
	
	carrega: # carrega as variaveis para evitar que estejam manipuladas ao começo de cada função
	
	la $s0, vetor
	lw $t0, tamanho
	li $t1, 0
	
	jr $ra
	
	main:
	
	jal imprime_original
	jal imprime_maior
	#jal imprime_menor
	#jal imprime_media
	#jal verifica_elemento
	
	li $v0, 10
	syscall 
	
