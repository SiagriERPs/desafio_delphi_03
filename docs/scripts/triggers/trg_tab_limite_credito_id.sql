-- Trigger para tab_limite_credito
CREATE TRIGGER trg_tab_limite_credito_id FOR tab_limite_credito
BEFORE INSERT
AS
BEGIN
  IF (NEW.limite_credito_id IS NULL) THEN
    NEW.limite_credito_id = GEN_ID(seq_limite_credito_id, 1);
END;