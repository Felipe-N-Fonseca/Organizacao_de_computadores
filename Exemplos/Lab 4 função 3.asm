# Fun��o 3 para buscar um item pelo c�digo
procura_item:
    # Solicitar ao usu�rio que digite o c�digo do produto
    li $v0, 4        # C�digo para imprimir string
    la $a0, # <------ Colocar aqui uma mensagem como: "Digite o c�digo do produto: " 
    syscall           # Chama o sistema para imprimir a mensagem
    li $v0, 5        # C�digo para ler inteiro
    syscall           # Chama o sistema para ler o c�digo do produto, armazena em $v0
    
    # Inicialize o ponteiro para o in�cio da lista (suponha que o endere�o do primeiro n� esteja em $s0)
    la $s0, lista   # Onde 'lista' � o r�tulo para o in�cio da lista encadeada
    
    # Carregue o c�digo a ser buscado em $t0
    move $t0, $v0
    
procura_loop:
    lw $t1, 0($s0)   # Carrega o c�digo do produto do n� atual
    beq $t1, $t0, encontrou_item   # Se o c�digo do n� atual for igual ao c�digo buscado, encontramos o item
    
    # Verifique se chegamos ao final da lista (pr�ximo n� � zero)
    lw $t2, 8($s0)   # Carrega o endere�o do pr�ximo n�
    beq $t2, $zero, item_nao_encontrado   # Se for zero, chegamos ao final da lista e o item n�o foi encontrado
    
    move $s0, $t2    # Atualiza o ponteiro para o pr�ximo n� na lista
    j procura_loop    # Continue procurando
    
encontrou_item:
    li $v0, 4        # C�digo para imprimir string
    la $a0, # <------ Colocar aqui uma mensagem como: "Item encontrado! Quantidade em estoque: "
    syscall           # Chama o sistema para imprimir a mensagem
    
    lw $t3, 4($s0)   # Carrega a quantidade do produto do n� atual
    li $v0, 1        # C�digo para imprimir inteiro
    move $a0, $t3     # Coloca a quantidade em $a0
    syscall           # Chama o sistema para imprimir a quantidade
    
    j menu           # Retorna ao menu que voce ja deve ter criado e n�o sei como foi chamado
    
item_nao_encontrado:
    li $v0, 4        # C�digo para imprimir string
    la $a0, # <------ Colocar aqui uma mensagem como: "Item n�o encontrado!"
    syscall           # Chama o sistema para imprimir a mensagem
    
    j menu           # Retorna ao menu que voce ja deve ter criado e n�o sei como foi chamado