CREATE TABLE tab_negociacao (
    negociacao_id INTEGER NOT NULL PRIMARY KEY,
    produtor_id INTEGER NOT NULL,
    distribuidor_id INTEGER NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	data_aprovacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	data_conclusao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	data_cancelamento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) NOT NULL,
    valor_total NUMERIC(15, 2) DEFAULT 0,
    CONSTRAINT fk_negociacao_produtor FOREIGN KEY (produtor_id) REFERENCES tab_produtor(produtor_id),
    CONSTRAINT fk_negociacao_distribuidor FOREIGN KEY (distribuidor_id) REFERENCES tab_distribuidor(distribuidor_id),
    CONSTRAINT ck_negociacao_status CHECK (status IN ('Pendente', 'Aprovada', 'Concluir', 'Cancelada'))
);