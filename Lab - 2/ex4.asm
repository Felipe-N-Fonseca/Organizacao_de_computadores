# Exercicio 04

.data

	msg: .asciiz "Digite o número: "
	res: .asciiz "Resultado: "


.text 

	j main

	decimal_para_binario:
	
	# while $s0 > 3
	comeco:
	
	beq $s0, 1, fim
	beq $s0, 2, pra2
	beq $s0, 3, pra3
	
	rem $t0, $s0, 2
	div $s0, $s0, 2
		
	beq $t0, 1, soma
	beq $t0, 0, passa
	
	soma:
	
	add $a0, $a0, $t1
	
	passa:
	
	mul $t1, $t1, 10
	
	j comeco
	
	pra3:
	
	add $a0, $a0, $t1
	
	pra2:
	
	mul $t1, $t1, 10
	add $a0, $a0, $t1
	
	
	fim:
	
	jr $ra


	main:
	
	la $a0, msg
	li $v0, 4
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0
	li $t1, 1
	move $a0, $zero
	
	jal decimal_para_binario

	move $t3, $a0
	
	la $a0, res
	li $v0, 4
	syscall

	move $a0, $t3
	li $v0, 1
	syscall
