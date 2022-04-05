CREATE TABLE NEGOCIACOES (
    ID INTEGER NOT NULL,
    STATUS CHAR(3) NOT NULL,
    DESCRICAO VARCHAR(120) NOT NULL,
    ID_PRODUTOR INTEGER NOT NULL,
    ID_DISTRIBUIDOR INTEGER NOT NULL,
    VALOR NUMERIC(15,7));

ALTER TABLE NEGOCIACOES
ADD CONSTRAINT PK_NEGOCIACOES
PRIMARY KEY (ID);

COMMENT ON COLUMN NEGOCIACOES.STATUS IS
'PEN - Pendente
APR - Aprovada
CON - Concluida
CAN - Cancelada';

COMMENT ON COLUMN NEGOCIACOES.DESCRICAO IS
'Uma descrição que identifique a negociação';

COMMENT ON COLUMN NEGOCIACOES.VALOR IS
'Valor totalizado da negociação com base na soma dos itens';

CREATE SEQUENCE GEN_NEGOCIACOES_ID;

SET TERM ^ ;

create trigger negociacoes_bi for negociacoes
active before insert position 0
as
begin
  if (new.id is null) then
    new.id = gen_id(gen_negociacoes_id,1);
end^

SET TERM ; ^

