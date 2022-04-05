CREATE TABLE PRODUTOS (
    ID INTEGER NOT NULL,
    DESCRICAO VARCHAR(80) NOT NULL,
    PRECO_VENDA NUMERIC(15,7) NOT NULL);

ALTER TABLE PRODUTOS
ADD CONSTRAINT PK_PRODUTOS
PRIMARY KEY (ID);

CREATE SEQUENCE GEN_PRODUTOS_ID;

SET TERM ^ ;

create trigger produtos_bi for produtos
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_produtos_id,1);
end^

SET TERM ; ^

