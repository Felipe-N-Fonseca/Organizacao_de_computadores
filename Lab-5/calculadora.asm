.data
	msg1: .asciiz "\n\nSelecione a operação:\n1. Soma\n2. Subtração\n3. Multiplicação\n4. Divisão\n5. Potenciação\nDigite sua escolha: "
	msg2: .asciiz "\nDigite o primeiro número em ponto flutuante: "
	msg3: .asciiz "Digite o segundo número em ponto flutuante: "
	res: .asciiz "Total: "
	cont: .asciiz "\n\nDeseja continuar?(S/N): "
	erro: .asciiz "\nDigite um valor Válido!\n"
	um: .float 1
	
.text

main:
	loop: #loop do menu
		li $v0, 4
		la $a0, msg1 #mostrar o menu
		syscall
		
		li $v0, 5
		syscall
		move $t0, $v0 #armazena a opção escolhida
		
		
		#retorna com uma mensagem se for um valor inválido
		blt $t0, 1, retorna 
		bgt $t0, 5, retorna
		
		
		#armazenamento dos dados
		li $v0, 4
		la $a0, msg2 #Solicita a entrada do primeiro número
		syscall
		
		li $v0, 6
		syscall
		mov.s $f2, $f0 #Le o número em float
		
		li $v0, 4
		la $a0, msg3 #Solicita a entrada do segunco número
		syscall
		
		li $v0, 6
		syscall
		mov.s $f6, $f0
		
		#Chamada das funções do menu
		beq $t0, 1, adicao
		beq $t0, 2, subitracao
		beq $t0, 3, multiplicacao
		beq $t0, 4, divisao
		beq $t0, 5, potenciacao
		
	retorna: # retorno no caso de dado inválido
		li $v0, 4
		la $a0, erro
		syscall
		
		j loop
		
	adicao: 
		add.s $f4, $f2, $f6 
		j print_res 
		
	subitracao: 
		sub.s $f4, $f2, $f6 
		j print_res 
		
	multiplicacao: 
		mul.s $f4, $f2, $f6 
		j print_res 
		
	divisao: 
		div.s $f4, $f2, $f6 
		j print_res 
		
	potenciacao:
		cvt.w.s $f6, $f6
		mfc1 $t6, $f6
		
		beqz $t6, pzero # Se for elevado a zero ele retorna 1
		bltz $t6, retorna # se for menor que zero ele não executa
		beq $t6, 1, mesmo # se for elevado a 1 retorna ele mesmo
		
		sub $t6, $t6, 1
		mov.s $f4, $f2
		
		pot:
			mul.s $f4, $f4, $f2
			sub $t6, $t6, 1
			bgtz $t6, pot
		
		j print_res
		
		mesmo:
			mov.s $f4, $f2
			j print_res
		
		pzero:
			lwc1 $f4, um
		
	print_res: #Função para imprimir o resultado
		li $v0, 4
		la $a0, res #printa o resultado
		syscall
		
		li $v0, 2
		mov.s $f12, $f4
		syscall
		
		li $v0, 4
		la $a0, cont
		syscall
		
		li $v0, 12
		syscall
		
		beq $v0, 'n', exit
		beq $v0, 'N', exit
		
		j loop #recomeça o loop
		
	exit:
		li $v0, 10 #Encerra o programa
