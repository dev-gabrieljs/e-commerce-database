CREATE TABLE "cliente" (
  "cliente_id" integer PRIMARY KEY,
  "nome" varchar(100),
  "email" varchar(100) UNIQUE NOT NULL,
  "senha" varchar(255) NOT NULL,
  "tipo_cliente" enum(PJ,PF) NOT NULL,
  "cnpj_cpf" varchar(20) NOT NULL,
  "endereco" varchar(255),
  "telefone" varchar(20),
  "data_criacao" timestamp
);

CREATE TABLE "produto" (
  "produto_id" integer PRIMARY KEY,
  "nome" varchar(100) NOT NULL,
  "descricao" text,
  "preco" decimal(10,2) NOT NULL,
  "estoque" integer NOT NULL,
  "categoria_id" integer,
  "imagem_url" varchar(255)
);

CREATE TABLE "categoria" (
  "categoria_id" integer PRIMARY KEY,
  "nome" varchar(100) NOT NULL
);

CREATE TABLE "pedido" (
  "pedido_id" integer PRIMARY KEY,
  "cliente_id" integer,
  "data_pedido" timestamp NOT NULL,
  "total" decimal(10,2) NOT NULL,
  "status" "enum(Pendente,Pago,Em Processamento,Enviado,Entregue,Cancelado)" NOT NULL,
  "data_entrega" timestamp
);

CREATE TABLE "item_pedido" (
  "item_pedido_id" integer PRIMARY KEY,
  "pedido_id" integer,
  "produto_id" integer,
  "quantidade" integer NOT NULL,
  "preco_unitario" decimal(10,2) NOT NULL
);

CREATE TABLE "pagamento" (
  "pagamento_id" integer PRIMARY KEY,
  "pedido_id" integer,
  "tipo_pagamento" "enum(Cartão de Crédito,Boleto,PayPal,Pix)" NOT NULL,
  "status" enum(Pendente,Aprovado,Cancelado) NOT NULL,
  "valor" decimal(10,2) NOT NULL,
  "data_pagamento" timestamp
);

CREATE TABLE "entrega" (
  "entrega_id" integer PRIMARY KEY,
  "pedido_id" integer,
  "status" "enum(Pendente,Em Trânsito,Entregue,Falha)" NOT NULL,
  "codigo_rastreio" varchar(50),
  "data_envio" timestamp,
  "data_entrega" timestamp
);

CREATE TABLE "avaliacao" (
  "avaliacao_id" integer PRIMARY KEY,
  "cliente_id" integer,
  "produto_id" integer,
  "nota" integer,
  "comentario" text,
  "data" timestamp
);

ALTER TABLE "pedido" ADD FOREIGN KEY ("cliente_id") REFERENCES "cliente" ("cliente_id");

ALTER TABLE "item_pedido" ADD FOREIGN KEY ("pedido_id") REFERENCES "pedido" ("pedido_id");

ALTER TABLE "item_pedido" ADD FOREIGN KEY ("produto_id") REFERENCES "produto" ("produto_id");

ALTER TABLE "pagamento" ADD FOREIGN KEY ("pedido_id") REFERENCES "pedido" ("pedido_id");

ALTER TABLE "entrega" ADD FOREIGN KEY ("pedido_id") REFERENCES "pedido" ("pedido_id");

ALTER TABLE "produto" ADD FOREIGN KEY ("categoria_id") REFERENCES "categoria" ("categoria_id");

ALTER TABLE "avaliacao" ADD FOREIGN KEY ("cliente_id") REFERENCES "cliente" ("cliente_id");

ALTER TABLE "avaliacao" ADD FOREIGN KEY ("produto_id") REFERENCES "produto" ("produto_id");
