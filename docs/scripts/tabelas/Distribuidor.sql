CREATE TABLE tab_distribuidor (
    distribuidor_id INTEGER NOT NULL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cnpj VARCHAR(20) UNIQUE NOT NULL
);