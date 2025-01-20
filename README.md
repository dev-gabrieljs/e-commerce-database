# E-commerce Database Structure

Este projeto define a estrutura de banco de dados para um sistema de e-commerce, incluindo tabelas e relacionamentos entre elas. O modelo abrange informações sobre clientes, produtos, pedidos, pagamentos, entregas, avaliações e categorias. A estrutura foi desenhada usando o DBML (Database Markup Language), que permite representar de forma simples o modelo de dados.

## Tabelas

### Cliente
Armazena informações sobre os clientes da loja.

- `cliente_id` (PK) - Identificador único do cliente.
- `nome` - Nome do cliente.
- `email` (unique, not null) - Endereço de email único.
- `senha` (not null) - Senha do cliente.
- `tipo_cliente` (enum) - Tipo de cliente (Pessoa Física - PF ou Pessoa Jurídica - PJ).
- `cnpj_cpf` (not null) - CNPJ ou CPF do cliente.
- `endereco` - Endereço do cliente.
- `telefone` - Telefone de contato.
- `data_criacao` - Data de criação do cadastro.

### Produto
Armazena as informações dos produtos vendidos na loja.

- `produto_id` (PK) - Identificador único do produto.
- `nome` (not null) - Nome do produto.
- `descricao` - Descrição do produto.
- `preco` (not null) - Preço do produto.
- `estoque` (not null) - Quantidade de estoque disponível.
- `categoria_id` - Identificador da categoria à qual o produto pertence.
- `imagem_url` - URL da imagem do produto.

### Categoria
Armazena as categorias dos produtos.

- `categoria_id` (PK) - Identificador único da categoria.
- `nome` (not null) - Nome da categoria.

### Pedido
Armazena os pedidos feitos pelos clientes.

- `pedido_id` (PK) - Identificador único do pedido.
- `cliente_id` - Identificador do cliente que realizou o pedido.
- `data_pedido` (not null) - Data e hora em que o pedido foi feito.
- `total` (not null) - Valor total do pedido.
- `status` (enum) - Status do pedido (Pendente, Pago, Em Processamento, Enviado, Entregue, Cancelado).
- `data_entrega` - Data prevista para entrega do pedido.

### Item_Pedido
Armazena os itens de um pedido.

- `item_pedido_id` (PK) - Identificador único do item do pedido.
- `pedido_id` - Identificador do pedido.
- `produto_id` - Identificador do produto.
- `quantidade` (not null) - Quantidade do produto no pedido.
- `preco_unitario` (not null) - Preço unitário do produto no momento do pedido.

### Pagamento
Armazena as informações de pagamento dos pedidos.

- `pagamento_id` (PK) - Identificador único do pagamento.
- `pedido_id` - Identificador do pedido pago.
- `tipo_pagamento` (enum) - Tipo de pagamento (Cartão de Crédito, Boleto, PayPal, Pix).
- `status` (enum) - Status do pagamento (Pendente, Aprovado, Cancelado).
- `valor` (not null) - Valor do pagamento.
- `data_pagamento` - Data do pagamento.

### Entrega
Armazena as informações sobre a entrega de um pedido.

- `entrega_id` (PK) - Identificador único da entrega.
- `pedido_id` - Identificador do pedido.
- `status` (enum) - Status da entrega (Pendente, Em Trânsito, Entregue, Falha).
- `codigo_rastreio` - Código de rastreamento da entrega.
- `data_envio` - Data de envio do pedido.
- `data_entrega` - Data de entrega do pedido.

### Avaliação
Armazena as avaliações feitas pelos clientes sobre os produtos.

- `avaliacao_id` (PK) - Identificador único da avaliação.
- `cliente_id` - Identificador do cliente que fez a avaliação.
- `produto_id` - Identificador do produto avaliado.
- `nota` - Nota dada ao produto (de 1 a 5).
- `comentario` - Comentário sobre o produto.
- `data` - Data da avaliação.

## Relacionamentos

- **Cliente -> Pedido**: Cada pedido pertence a um cliente.
- **Pedido -> Item_Pedido**: Cada pedido pode ter múltiplos itens.
- **Produto -> Item_Pedido**: Cada item de pedido é associado a um produto.
- **Pedido -> Pagamento**: Cada pedido pode ter um ou mais pagamentos.
- **Pedido -> Entrega**: Cada pedido pode ter um status de entrega.
- **Categoria -> Produto**: Cada produto pertence a uma categoria.
- **Cliente -> Avaliação**: Cada avaliação é feita por um cliente.
- **Produto -> Avaliação**: Cada avaliação é feita sobre um produto.

## Exemplo de uso

### 1. Criar um novo cliente
```sql
INSERT INTO cliente (nome, email, senha, tipo_cliente, cnpj_cpf, endereco, telefone, data_criacao)
VALUES ('João Silva', 'joao@email.com', 'senha123', 'PF', '123.456.789-00', 'Rua X, 123', '999999999', CURRENT_TIMESTAMP);
