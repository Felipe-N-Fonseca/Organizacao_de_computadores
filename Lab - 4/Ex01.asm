.data

	menu: .asciiz "\n**** SISTEMA DE CONTROLE DE ESTOQUE ****\n1. Inserir um novo item no estoque\n2. Excluir um item do estoque\n3. Buscar um item pelo código\n4. Imprimir os produtos em estoque (código e quantidade)\n5. Sair\nDigite sua opção: "
	saindo: .asciiz "\nSaindo do programa..."
	
.text

	main:
	
	li $v0, 4
	la $a0, menu
	syscall
	
	li $v0, 5
	syscall
	
	blez $v0, main
	bgt $v0, 5, main
	
	
	Item_do_estoque:
	
	Excluir_item_do_estoque:
	
	Buscar_um_item_pelo_codigo:
	
	Imprimir:
	
	Sair:
	
	li $v0, 4
	la $a0, saindo
	syscall
	
	li $v0, 10
	syscall
	