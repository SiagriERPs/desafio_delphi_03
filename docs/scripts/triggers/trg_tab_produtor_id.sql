-- Trigger para tab_produtor
CREATE TRIGGER trg_tab_produtor_id FOR tab_produtor
BEFORE INSERT
AS
BEGIN
  IF (NEW.produtor_id IS NULL) THEN
    NEW.produtor_id = GEN_ID(gen_tab_produtor_id, 1);
END;