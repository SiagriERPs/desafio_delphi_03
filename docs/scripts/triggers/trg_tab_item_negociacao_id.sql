-- Trigger para tab_item_negociacao
CREATE TRIGGER trg_tab_item_negociacao_id FOR tab_item_negociacao
BEFORE INSERT
AS
BEGIN
  IF (NEW.item_negociacao_id IS NULL) THEN
    NEW.item_negociacao_id = GEN_ID(gen_tab_item_negociacao_id, 1);
END;