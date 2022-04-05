CREATE TABLE DISTRIBUIDORES (
    ID INTEGER NOT NULL,
    NOME VARCHAR(120) NOT NULL,
    CNPJ VARCHAR(14) NOT NULL);

ALTER TABLE DISTRIBUIDORES
ADD CONSTRAINT PK_DISTRIBUIDORES
PRIMARY KEY (ID);

CREATE SEQUENCE GEN_DISTRIBUIDORES_ID;

SET TERM ^ ;

create trigger distribuidores_bi for distribuidores
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_distribuidores_id,1);
end^

SET TERM ; ^

