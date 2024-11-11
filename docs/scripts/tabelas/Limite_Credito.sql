CREATE TABLE tab_limite_credito (
    limite_credito_id INT PRIMARY KEY,
    produtor_id INT,
    distribuidor_id INT,
    limite_credito DECIMAL(15, 2) DEFAULT 0,
	CONSTRAINT fk_limite_credito_produtor FOREIGN KEY (produtor_id) REFERENCES tab_produtor(produtor_id),
	CONSTRAINT fk_limite_credito_distribuidor FOREIGN KEY (distribuidor_id) REFERENCES tab_distribuidor(distribuidor_id)
);