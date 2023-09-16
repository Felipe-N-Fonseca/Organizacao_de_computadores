.data 

	vetor: .word 2, -5, 12, 7, -3, 99, 8, 54, 21, -45, 67, 61, 55
	tamanho: .word 13
	colchete: .asciiz  "]"
	virgula: .asciiz ","
	saidaA: .asciiz "O vetor original é: ["
	saidaB: .asciiz "O maior elemento do vetor é: "
	saidaC: .asciiz "O menor elemento do vetor é: "
	saidaD: .asciiz "A média dos elementos do vetor é: "
	saidaE: .asciiz "Digite um número: "
	encontrado: .asciiz "Número encontrado no vetor"
	naoEncontrado: .asciiz "Número não encontrado no vetor"
	
.text
	j main
	
	imprime_original: #  Imprimir o vetor original
	
	li $v0, 4
	la $a0, saidaA
	Syscall
	
	# while( $t0 < tamanho )
	while_01:
	
	
	
	
	
	jr
	
	
	imprime_maior: # Encontrar e imprimir o maior elemento dentro do vetor
	
	
	jr
	
	
	imprime_menor: # Encontrar e imprimir o menor elemento dentro do vetor
	
	
	jr
	
	imprime_media: # Calcular e imprimir a média dos elementos do vetor
	
	
	jr
	
	verifica_elemento: # Verificar se um elemento está presente no vetor
	
	
	
	jr
	
	
	carrega: # carrega as variaveis para evitar que estejam manipuladas ao começo de cada função
	
	la $s0, vetor
	la $t0, tamanho
	
	jr
	
	main:
	
	jal imprime_original
	jal imprime_maior
	jal imprime_menor
	jal imprime_media
	jal verifica_elemento
	
	li $v0, 10
	syscall 
	