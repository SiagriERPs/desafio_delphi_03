CREATE TABLE PRODUTORES (
    ID INTEGER NOT NULL,
	NOME VARCHAR(120) NOT NULL,
    CPF_CNPJ VARCHAR(14) NOT NULL);

ALTER TABLE PRODUTORES
ADD CONSTRAINT PK_PRODUTORES
PRIMARY KEY (ID);

CREATE SEQUENCE GEN_PRODUTORES_ID;

SET TERM ^ ;

create trigger produtores_bi for produtores
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_produtores_id,1);
end^


SET TERM ; ^

