.data
# Mensagens
bem_vindo: .asciiz "+------------------------------------------------------+\n|           Bem-vindo ao Sistema de Estoque!           |\n+------------------------------------------------------+\n"
menu: .asciiz "\n        **** SISTEMA DE CONTROLE DE ESTOQUE ****\n            1. Inserir um novo item no estoque\n            2. Excluir um item do estoque\n            3. Buscar um item pelo código\n            4. Imprimir os produtos em estoque (código e quantidade)\n            5. Sair\n            Digite sua opção: "
saindo: .asciiz "\nSaindo do programa..."
msg_erro: .asciiz "\n+------------------------------------------------------+\n|           Valor inválido, digite novamente.          |\n+------------------------------------------------------+\n"
codigo: .asciiz "Insira o código do produto: "
qtd: .asciiz "Insira a quantidade: "
item_excluidomsg: .asciiz "Item excluído com sucesso!"
item_nao_excluidomsg: .asciiz "Item não excluído pois não foi localizado!"
prodmsg: .asciiz "     Estoque de Produtos:\n"
codmsg: .asciiz "Codigo do Produto |"
qtdmsg: .asciiz " Quantidade\n"
encontradomsg: .asciiz "Item Encontrado! Quantidade no Estoque: "
nao_encontradomsg: .asciiz "Item não localizado!"
estoquevaziomsg: .asciiz "Estoque vazio!"
espacotabela: .asciiz "            		"
pulalinha: .asciiz "\n"
lista: .word 0 # Define a lista no elemento 0
estoque: .space 800
tamanho_estoque: .word 0
MAX_ESTOQUE: .word 100

.text
main:
    li $v0, 4
    la $a0, bem_vindo
    syscall

    j menu_loop

menu_loop:
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beqz $t0, sair
    bgt $t0, 5, erro

    # Tratamento das opções do menu
    beq $t0, 1, inserir_item
    beq $t0, 2, excluir_item
    beq $t0, 3, buscar_item
    beq $t0, 4, imprimir_estoque
    beq $t0, 5, sair
    j menu_loop

inserir_item:
    jal verificar_espaco_estoque

    # Solicite o código do produto
    li $v0, 4
    la $a0, codigo
    syscall

    # Leia o código do produto
    li $v0, 5
    syscall
    move $t2, $v0 # $t2 contém o código do produto

    # Solicite a quantidade
    li $v0, 4
    la $a0, qtd
    syscall

    # Leia a quantidade
    li $v0, 5
    syscall
    move $t3, $v0 # $t3 contém a quantidade

    jal buscar_item_insercao

    j menu_loop

verificar_espaco_estoque:
    lw $t0, MAX_ESTOQUE
    lw $t1, tamanho_estoque
    bge $t1, $t0, estoque_cheio
    jr $ra

estoque_cheio:
    li $v0, 4
    la $a0, msg_erro
    syscall
    j menu_loop

buscar_item_insercao:
    la $t4, estoque
    li $t5, 0 # Índice para percorrer o estoque
    lw $t6, tamanho_estoque

procurar_item_insercao:
    beq $t5, $t6, item_nao_encontrado_insercao # Se o índice atingir o tamanho do estoque, o item não foi encontrado

    lw $t7, ($t4) # Código do item no estoque
    beq $t7, $t2, item_encontrado_insercao # Item encontrado, vá para a atualização da quantidade
    addi $t4, $t4, 8 # Próximo item
    addi $t5, $t5, 1 # Próximo índice
    bnez $t7, procurar_item_insercao # Continue procurando

item_encontrado_insercao:
    # Atualize a quantidade do item no estoque
    lw $t8, 4($t4) # Quantidade atual
    add $t3, $t3, $t8 # Adicione a nova quantidade à quantidade atual
    sw $t3, 4($t4)   # Atualize a quantidade no estoque
    jr $ra

item_nao_encontrado_insercao:
    # O item não foi encontrado, adicione-o ao estoque
    la $t9, estoque
    lw $t6, tamanho_estoque
    sll $t6, $t6, 3 # Multiplica o tamanho do estoque por 8
    add $t9, $t9, $t6 # Endereço do próximo item no estoque

    sw $t2, ($t9)    # Armazene o código
    sw $t3, 4($t9)   # Armazene a quantidade

    # Aumente o tamanho do estoque
    addi $t6, $t6, 1
    sw $t6, tamanho_estoque
    jr $ra

excluir_item:
    # Solicite o código do produto a ser excluído
    li $v0, 4
    la $a0, codigo
    syscall

    # Leia o código do produto a ser excluído
    li $v0, 5
    syscall
    move $t2, $v0 # $t2 contém o código a ser excluído

    # Chame a função buscar_item_exclusao
    jal buscar_item_exclusao

    # Verifique o resultado da busca
    beqz $v0, item_nao_encontrado_exclusao
    j item_encontrado_exclusao

item_nao_encontrado_exclusao:
    # Imprima a mensagem de item não excluído
    li $v0, 4
    la $a0, item_nao_excluidomsg
    syscall

    j menu_loop

item_encontrado_exclusao:
    # Marque o código do item como zero (indicando item excluído)
    sw $zero, ($t4)

    # Atualize o ponteiro para o próximo item
    addi $t4, $t4, 8

    # Decrementar o tamanho do estoque
    subi $t6, $t6, 1
    sw $t6, tamanho_estoque

    # Imprima a mensagem de item excluído
    li $v0, 4
    la $a0, item_excluidomsg
    syscall

    j menu_loop

buscar_item_exclusao:
    la $t4, estoque
    li $t5, 0 # Índice para percorrer o estoque
    lw $t6, tamanho_estoque

procurar_item_exclusao:
    beq $t5, $t6, item_nao_encontrado_exclusao # Se o índice atingir o tamanho do estoque, o item não foi encontrado

    lw $t7, ($t4) # Código do item no estoque
    beq $t7, $t2, item_encontrado_exclusao # Item encontrado, retorne 1
    addi $t4, $t4, 8 # Próximo item
    addi $t5, $t5, 1 # Próximo índice
    bnez $t7, procurar_item_exclusao # Continue procurando

buscar_item:
    # Solicite o código do produto a ser buscado
    li $v0, 4
    la $a0, codigo
    syscall

    # Leia o código do produto a ser buscado
    li $v0, 5
    syscall
    move $t2, $v0 # $t2 contém o código a ser buscado

    jal procurar_item

    j menu_loop

procurar_item:
    la $t4, estoque
    li $t5, 0 # Índice para percorrer o estoque
    lw $t6, tamanho_estoque
    li $t7, 0 # Flag para indicar se o item foi encontrado (0 = não encontrado)

procura_item:
    beq $t5, $t6, item_nao_encontrado # Se o índice atingir o tamanho do estoque, o item não foi encontrado

    lw $t8, ($t4) # Código do item no estoque
    beqz $t8, item_nao_encontrado # Se o código for zero, chegamos ao final do estoque

    beq $t8, $t2, encontrou_item # Se o código corresponder ao código buscado, encontramos o item

    addi $t4, $t4, 8 # Próximo item
    addi $t5, $t5, 1 # Próximo índice
    j procura_item # Continue procurando

encontrou_item:
    li $v0, 4        # Código para imprimir string
    la $a0, encontradomsg
    syscall

    lw $t3, 4($t4)   # Carrega a quantidade do produto do nó atual
    li $v0, 1        # Código para imprimir inteiro
    move $a0, $t3     # Coloca a quantidade em $a0
    syscall

    j menu_loop

item_nao_encontrado:
    li $v0, 4        # Código para imprimir string
    la $a0, nao_encontradomsg
    syscall
    j menu_loop

imprimir_estoque:
    jal verificar_estoque_vazio

    # Imprima o cabeçalho
    li $v0, 4
    la $a0, prodmsg
    syscall

    # Imprima os títulos das colunas alinhados
    li $v0, 4
    la $a0, codmsg
    syscall

    li $v0, 4
    la $a0, qtdmsg
    syscall

    # Inicialize a flag para indicar que há itens no estoque
    li $t7, 1

    jal imprimir_loop

    j menu_loop

verificar_estoque_vazio:
    lw $t6, tamanho_estoque
    beqz $t6, estoque_vazio
    jr $ra

estoque_vazio:
    li $v0, 4
    la $a0, estoquevaziomsg
    syscall
    j menu_loop

imprimir_loop:
    # Imprima os itens do estoque
    la $t4, estoque
    li $t5, 0 # Índice para percorrer o estoque
    lw $t6, tamanho_estoque
    li $t8, 0 # Flag para indicar se há mais itens para imprimir (0 = não há mais itens)

proximo_item_impressao:
    beq $t5, $t6, item_nao_encontrado_impressao # Se o índice atingir o tamanho do estoque, não há mais itens para imprimir

    lw $t9, ($t4) # Código do item no estoque
    beqz $t9, item_nao_encontrado_impressao # Se o código for zero, chegamos ao final do estoque

    li $v0, 1
    move $a0, $t9
    syscall

    # Imprima espaços para alinhar a quantidade com a mensagem
    li $v0, 4
    la $a0, espacotabela
    syscall

    # Imprima a quantidade do item
    lw $a0, 4($t4) # Carrega a quantidade do item
    li $v0, 1
    syscall

    # Defina a flag para indicar que há mais itens para imprimir
    li $t8, 1

    addi $t4, $t4, 8 # Próximo item
    addi $t5, $t5, 1 # Próximo índice
    
    li $v0, 4
    la $a0, pulalinha
    syscall
    
    j proximo_item_impressao

item_nao_encontrado_impressao:
    # Verifique a flag para decidir se deve continuar o loop
    beqz $t8, fim_impressao # Se não há mais itens, saia do loop

    jr $ra

fim_impressao:
    jr $ra

sair:
    li $v0, 4
    la $a0, saindo
    syscall

    li $v0, 10
    syscall

erro:
    li $v0, 4
    la $a0, msg_erro
    syscall

    j menu_loop
