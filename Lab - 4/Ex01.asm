.data

	bem_vindo: .asciiz "+------------------------------------------------------+\n|           Bem vindo ao Sistema de estoque!           |\n+------------------------------------------------------+\n"
	menu: .asciiz "\n        **** SISTEMA DE CONTROLE DE ESTOQUE ****\n         1. Inserir um novo item no estoque\n            2. Excluir um item do estoque\n            3. Buscar um item pelo código\n4. Imprimir os produtos em estoque (código e quantidade)\n                      5. Sair\n                  Digite sua opção: "
	saindo: .asciiz "\nSaindo do programa..."
	msg_erro: .asciiz "\n+------------------------------------------------------+\n|           Valor inválido, digite novamente.          |\n+------------------------------------------------------+\n"
	codigo: .asciiz "Digite o código do produto: "
	qtd: .asciiz "Digite a quantide: "
	
.text

	li $v0, 4
	la $a0, bem_vindo # imprime a menságem de inicio
	syscall
	
	move $s0 ,$zero # responsável pelo tamanho do vetor
	
	j main
	
	erro:
	
	li $v0, 4
	la $a0, msg_erro
	syscall

	main:
	
	li $v0, 4
	la $a0, menu
	syscall
	
	li $v0, 5
	syscall
	
	blez $v0, erro
	bgt $v0, 5, erro # se dirige a impressão da mensagem de erro e reinicia o menu
	beq $v0, 1, func_1
	beq $v0, 2, func_2
	beq $v0, 3, func_3
	beq $v0, 4, func_4
	beq $v0, 5, Sair
	
	func_1:
	jal item_do_estoque
	j main
	
	func_2:
	jal Excluir_item_do_estoque
	j main
	
	func_3:
	jal Buscar_um_item_pelo_codigo
	j main
	
	func_4:
	jal Imprimir
	j main
	
	Item_do_estoque:
	
	li $v0, 9
	li $a0, 12 # solicita que o sistema aloque 12 bytes para a insersão de 3 inteiros
	syscall
	
	move $t0, $v0 # nó atual
	
	beq $s0, $zero, primeira # pula o trecho de adição do endereço ao anterior
	
	sw $v0, $s1 # carrega o endereço do nó atual nó nó anterior
	j continua
	
	primeira:
	
	move $s2, $v0 # endereço inicial do array encadeado
	
	continua:
	
	li $v0, 4
	la $a0, codigo
	syscall
	li $v0, 5
	syscall
	
	sw $v0, $t0 # Carrega no nó atual o código do produto
	addi $t0, $t0, 4 # anda ao endereço do proximo indice
	
	li $v0, 4
	la $a0, qtd
	syscall
	li $v0, 5
	syscall
	
	sw $v0, $t0 # Carrega no nó atual a quantidade
	addi $t0, $t0, 4 # anda ao endereço do proximo indice
	
	sw $zero , $t0 # define o terminador
	move $s1, $t0 # armazena o endereço do ultimo nó
	addi $s0, $s0, 1
	
	jr $ra
	
	Excluir_item_do_estoque:
	
	
	
	
	loop:
	
	
	
	beq $s0, 1 , esvazia # esvazia a array encadeada
	
	
	
	esvazia:
	
	subi $s0, $s0, 1
	
	jr $ra
	
	Buscar_um_item_pelo_codigo: # Giovanni
	
	
	
	jr $ra
	
	Imprimir: # Anderson
	
	
	
	jr $ra
	
	Sair:
	
	li $v0, 4
	la $a0, saindo
	syscall
	
	li $v0, 10
	syscall
	
