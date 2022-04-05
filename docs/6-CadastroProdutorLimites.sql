CREATE TABLE PRODUTORES_LIMITES (
    ID INTEGER NOT NULL,
    ID_PRODUTOR INTEGER NOT NULL,
    ID_DISTRIBUIDOR INTEGER NOT NULL,
    LIMITE_CREDITO NUMERIC(15,2) NOT NULL);

ALTER TABLE PRODUTORES_LIMITES
ADD CONSTRAINT PK_PRODUTORES_LIMITES
PRIMARY KEY (ID);

CREATE SEQUENCE GEN_PRODUTORES_LIMITES_ID;

SET TERM ^ ;

create trigger produtores_limites_bi for produtores_limites
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_produtores_limites_id,1);
end^

SET TERM ; ^

