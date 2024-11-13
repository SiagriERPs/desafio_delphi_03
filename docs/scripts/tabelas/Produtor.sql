CREATE TABLE tab_produtor (
    produtor_id INTEGER NOT NULL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cpf_cnpj VARCHAR(20) UNIQUE NOT NULL,
    limite_credito NUMERIC(15, 2) NOT NULL
);