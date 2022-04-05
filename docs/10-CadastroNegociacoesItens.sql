CREATE TABLE NEGOCIACOES_ITENS (
    ID INTEGER NOT NULL,
    ID_NEGOCIACAO INTEGER NOT NULL,
    ID_PRODUTO INTEGER NOT NULL,
    VALOR NUMERIC(15,2) NOT NULL);

ALTER TABLE NEGOCIACOES_ITENS
ADD CONSTRAINT PK_NEGOCIACOES_ITENS
PRIMARY KEY (ID);

CREATE SEQUENCE GEN_NEGOCIACOES_ITENS_ID;

SET TERM ^ ;

create trigger negociacoes_itens_bi for negociacoes_itens
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_negociacoes_itens_id,1);
end^

SET TERM ; ^

