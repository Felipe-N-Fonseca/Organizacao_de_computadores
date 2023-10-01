# Função 3 para buscar um item pelo código
procura_item:
    # Solicitar ao usuário que digite o código do produto
    li $v0, 4        # Código para imprimir string
    la $a0, # <------ Colocar aqui uma mensagem como: "Digite o código do produto: " 
    syscall           # Chama o sistema para imprimir a mensagem
    li $v0, 5        # Código para ler inteiro
    syscall           # Chama o sistema para ler o código do produto, armazena em $v0
    
    # Inicialize o ponteiro para o início da lista (suponha que o endereço do primeiro nó esteja em $s0)
    la $s0, lista   # Onde 'lista' é o rótulo para o início da lista encadeada
    
    # Carregue o código a ser buscado em $t0
    move $t0, $v0
    
procura_loop:
    lw $t1, 0($s0)   # Carrega o código do produto do nó atual
    beq $t1, $t0, encontrou_item   # Se o código do nó atual for igual ao código buscado, encontramos o item
    
    # Verifique se chegamos ao final da lista (próximo nó é zero)
    lw $t2, 8($s0)   # Carrega o endereço do próximo nó
    beq $t2, $zero, item_nao_encontrado   # Se for zero, chegamos ao final da lista e o item não foi encontrado
    
    move $s0, $t2    # Atualiza o ponteiro para o próximo nó na lista
    j procura_loop    # Continue procurando
    
encontrou_item:
    li $v0, 4        # Código para imprimir string
    la $a0, # <------ Colocar aqui uma mensagem como: "Item encontrado! Quantidade em estoque: "
    syscall           # Chama o sistema para imprimir a mensagem
    
    lw $t3, 4($s0)   # Carrega a quantidade do produto do nó atual
    li $v0, 1        # Código para imprimir inteiro
    move $a0, $t3     # Coloca a quantidade em $a0
    syscall           # Chama o sistema para imprimir a quantidade
    
    j menu           # Retorna ao menu que voce ja deve ter criado e não sei como foi chamado
    
item_nao_encontrado:
    li $v0, 4        # Código para imprimir string
    la $a0, # <------ Colocar aqui uma mensagem como: "Item não encontrado!"
    syscall           # Chama o sistema para imprimir a mensagem
    
    j menu           # Retorna ao menu que voce ja deve ter criado e não sei como foi chamado