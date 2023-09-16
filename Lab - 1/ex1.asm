# Lab 1 - Exercicio 01
# 
# Anderson Correa Nicodemo 	- 3221536-6
# Felipe do Nascimento Fonseca 	- 4221536-6
# Gustavo Garabetti Munhoz	- 4221195-6
# Giovanni Alves Lavia 		- 4221836-5

.data
	# Entradas:
	
	menu: .asciiz "+-----------------------+\n|         Menu          |\n+-----------------------+\n|1. Soma                |\n|2. Subtração           |\n|3. Multiplicação       |\n|4. Divisão             |\n|5. Sair                |\n+-----------------------+\nEscolha a operação: "
	num1: .asciiz "Didite o 1° número: "
	num2: .asciiz "Didite o 2° número: "
	             
	# Saidas: 
	
	soma: .asciiz "O resultado da Soma é: "
	subtr: .asciiz "O resultado da Subtração é: "
	multi: .asciiz "O resultado da Multiplicação é: "
	div1: .asciiz "A Divisão tem quociente: "
	div2: .asciiz " e resto: "
	sair: .asciiz "Obrigado por me usar :) \nSaindo..."
	lf: .asciiz "\n"
	df: .asciiz "\n\n"
	
	# Mensagens auxiliares
	
	erroentrada: .asciiz "\nValor incorreto!\n\n"


.text
	# Inicio do programa chamando o menu e recebendo o valor
	
	inicio:
	
	li $v0, 4
	la $a0, menu
	syscall
	
	li $v0, 5
	syscall
	
	move $s0, $v0
	
	# comparar se o valor do menu está correto
	
	blez $s0, erroMenu
	bgt $s0, 5, erroMenu
	beq $s0, 5, saida
	
	j recebeValores
	
	erroMenu:
	
	li $v0, 4
	la $a0, erroentrada
	syscall
	
	j inicio
	
	# Recebendo os valores
	
	# número 1:
	recebeValores:
	
	li $v0, 4
	la $a0, num1
	syscall
	
	li $v0, 5
	syscall
	
	move $s1, $v0
	
	# número 2
	
	li $v0, 4
	la $a0, num2
	syscall
	
	li $v0, 5
	syscall
	
	move $s2, $v0
	
	# Decidindo para onde vai o código
	
	beq $s0, 1, somar
	beq $s0, 2, subtrair
	beq $s0, 3, multiplicar
	beq $s0, 4, dividir
	
	somar:
	
	add $s3, $s1, $s2
	
	li $v0, 4
	la $a0, soma
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, df
	syscall
	
	j inicio
	
	
	subtrair:
	
	sub $s3, $s1, $s2
	
	li $v0, 4
	la $a0, subtr
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, df
	syscall
	
	j inicio
	

	multiplicar:
	
	mul $s3, $s1, $s2
	
	li $v0, 4
	la $a0, multi
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, df
	syscall
	
	j inicio
	
	
	dividir:
	
	beq $s2, $zero, porZero
	
	divu $s1, $s2
	mflo $s3
	mfhi $s4
	
	li $v0, 4
	la $a0, div1
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall
	
	li $v0, 4
	la $a0, div2
	syscall
	
	li $v0, 1
	move $a0, $s4
	syscall
	
	li $v0, 4
	la $a0, df
	syscall
	
	j inicio

	porZero:
	
	li $v0, 4
	la $a0, erroentrada
	syscall
		
	j recebeValores
	
	
	saida:
	  
	li $v0, 4
	la $a0, sair
	syscall

	li $v0, 10
	syscall
