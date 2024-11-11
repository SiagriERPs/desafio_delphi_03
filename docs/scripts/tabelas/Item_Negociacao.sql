CREATE TABLE tab_item_negociacao (
    item_negociacao_id INTEGER NOT NULL PRIMARY KEY,
    negociacao_id INTEGER NOT NULL,
    produto_id INTEGER NOT NULL,
    quantidade INTEGER NOT NULL,
    preco NUMERIC(15, 2) NOT NULL,
    CONSTRAINT fk_item_negociacao_negociacao FOREIGN KEY (negociacao_id) REFERENCES tab_negociacao(negociacao_id),
    CONSTRAINT fk_item_negociacao_produto FOREIGN KEY (produto_id) REFERENCES tab_produto(produto_id)
);
