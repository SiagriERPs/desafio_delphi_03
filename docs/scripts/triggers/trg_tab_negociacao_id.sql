-- Trigger para tab_negociacao
CREATE TRIGGER trg_tab_negociacao_id FOR tab_negociacao
BEFORE INSERT
AS
BEGIN
  IF (NEW.negociacao_id IS NULL) THEN
    NEW.negociacao_id = GEN_ID(gen_tab_negociacao_id, 1);
END;